`timescale 1ns/1ps
module sd_1011_tb;
reg x, areset, clk;
wire op;
wire [1:0]current_state,next_state;
sd_1011 dut(x,areset,clk,op,current_state,next_state);
initial begin
    clk = 0;
    forever #2 clk = ~clk;
end
initial begin
    $monitor("t=%0t | x=%b | current_state=%02b | next_state=%02b | op=%b",
             $time, x, current_state, next_state, op);
    x = 0;
    areset = 1;

    #1 areset = 0;
 #1 x=0;

    #3 x = 1;   // 1
    #4 x = 0;   // 10
    #4 x = 1;   // 101
    #4 x = 1;   // 1011 → detect

    #4 x = 0;
    #4 x = 1;
    #4 x = 1;   // overlapping sequence

    #10;
    $finish;
end

endmodule
