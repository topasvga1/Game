// ブロックのパラメータ
int blocks_row = 10;  // ブロックの行数
int blocks_col = 11;  // ブロックの列数
DrawBlock[] block = new DrawBlock[blocks_row * blocks_col];
int[] blockX = new int[blocks_row * blocks_col];
int[] blockY = new int[blocks_row * blocks_col];
color[] blockColor = new int[blocks_row * blocks_col];
int first_block_x = 10;
int first_block_y = 10;
int block_width = 33;
int block_height = 20;
int block_interval_x = 35;
int block_interval_y = 20;
color block_color = color(10,150,10);

// バーのパラメータ
int bar_width = 60;
int bar_height = 15;
int bar_x = 200;
int bar_y = 470;
color bar_color = color(200, 0, 200);

// ボールのパラメータ
float ball_dia = 12;
float ball_x = bar_x + bar_width/2;
float ball_y = bar_y - ball_dia/2;

boolean start_click = false;
float vx = random(random(-3, -3),random(3, 3));
float vy = -3.5;
color back_color = color(0, 20, 0);  // 背景色

// ブロック描画用クラス
class DrawBlock{
  int x, y, w, h;
  color rgb;
  
  DrawBlock(int block_x, int block_y, int block_width, int block_height, color rgb_color){
    x = block_x;
    y = block_y;
    w = block_width;
    h = block_height;
    rgb = rgb_color;
  }
  
  void init(){
    fill(rgb);
    rect(x, y, w, h);
  }
}

void setup(){
  size(400, 500); 
  // ブロックの初期化
  for(int y = 0; y < blocks_row; y++){
    for(int x = 0; x < blocks_col; x++){
      int i = x + (y * blocks_col);
      blockColor[i] = block_color;
      blockX[i] = first_block_x + block_interval_x * x;
      blockY[i] = first_block_y + block_interval_y * y;
      block[i] = new DrawBlock(blockX[i], blockY[i], block_width, block_height, blockColor[i]);
    }
  }
}

void draw(){
  background(back_color);
  
  // ブロックの初期化
  for(int i = 0; i < block.length; i++){
    block[i].init();
  }
  
  // バーの描画
  fill(200,155,155);  
  rect(bar_x, bar_y, bar_width, bar_height);
  bar_x = mouseX - bar_width/2;
  
  // ボールがエリア外にある場合の処理
  if(bar_x > width - bar_width){
    bar_x = width - bar_width;
  }
  if(bar_x < 0){
    bar_x = 0;
  }
  
  // ボールの描画
  fill(220, 200, 200);
  ellipse(ball_x, ball_y, ball_dia, ball_dia);
  // クリックがあればボール移動開始
  if(start_click){
    ball_x += vx;
    ball_y += vy;
  }
  
  // ボールの処理(ブロックと衝突後)
  if( ball_x > width || ball_x < 0){
    vx *= -1;
  }
  if( ball_y < 0){
    vy *= -1;
  }
  
  if( ball_y > height){
    text("Game Over", width/2 , height/2);
  }
  
  // バーにボールが衝突した場合の処理
  if(ball_x > bar_x-5 && ball_x < bar_x + bar_width + 5){
    if(ball_y > bar_y && ball_y < bar_y + 6){
      vx += random(-0.5,0.5);
      vy *= -1;
    }
  }
  
  // ボールと衝突したブロックの描画
  for(int y = 0; y < blocks_row; y++){
    for(int x = 0; x < blocks_col; x++){
      int i = x + (y * blocks_col);
      blockX[i] = first_block_x + block_interval_x * x;
      blockY[i] = first_block_y + block_interval_y * y;
      
      if(blockColor[i] == block_color){
        
        if(ball_y > blockY[i]-5 && ball_y < blockY[i] + block_height+5){
          if(ball_x > blockX[i]-5 && ball_x < blockX[i] + block_width+5){
            vy *= -1;
            blockColor[i] = back_color;
          }
        }
        
        if(ball_y > blockY[i] && ball_y < blockY[i] + block_height){
          if(ball_x > blockX[i]-5 && ball_x < blockX[i]-6 ){
            vx *= -1;
            blockColor[i] = back_color;
          }
          
          if(ball_x > blockX[i]+5 + block_width && ball_x < blockX[i] + block_width + 6){
            vx *= -1;
            blockColor[i] = back_color;
          }
          
        }
        
      }    
     block[i] = new DrawBlock(blockX[i], blockY[i], block_width, block_height, blockColor[i]);   
    }
  }
  
}

void mousePressed(){
  start_click = !start_click;
}
