float k = 0, mult = .65, angle = 70, timer = 0;
long rs = 0, branchLen = 140;
Drop[] drops = new Drop[200] ;


void setup() {
size(900, 700, P3D);
for (int i = 0; i < 200; i++) {
  drops[i] = new Drop();
}
}

void draw() {
timer = millis();
    randomSeed(rs);
    background(#191950);
    pushMatrix();
    translate(width / 2, height);
    branch(branchLen, 0, 0);
    k += 0.01;
    popMatrix();
    for (int i = 0; i < drops.length; i++) {
      drops[i].fall();
      drops[i].show();
    }
    float jj = 6000;
    for (int j = 0; j < width; j++) {
      stroke(255);
      line(j, map(noise(jj += 0.005), 0, 1, height-50, height), j, height);
    }
  }


  void branch(float len, int snow, int star) {

    if (len > 4) {

      stroke(0, 200);
      float sw = map(len, 200, 4, 20, .1);
      strokeWeight(sw);
      line(0, 0, 0, -len);
      if (len < branchLen && len > 4) {
        float i = 0;
        while (i < 5) {
          float ran = random(-1, 1);
          if (ran > 0) {
            rotate(radians(-angle));
          } else if (ran <= 0) {
            rotate(radians(angle));
          }
          stroke(0, 0);
          fill(0, 120, 0, 60);
          ellipse(0, 0, len / 4, len);
          if (ran > 0) {
            rotate(radians(angle));
          } else if (ran <= 0) {
            rotate(radians(-angle));
          }
          if (i + abs(ran) <=5) {
            translate(0, map(abs(ran), 0, 1, 0, -len / 5), 0);
            } else if (i + abs(ran) > 5) {
              translate(0, map(5 - i, 0, 1, 0, -len / 5), 0);
            }
          light(timer);
          i += abs(ran);
        }
      } else {
        translate(0, -len);
      }

      len *= 0.78;
      float slen = len * 0.57;

      pushMatrix();
      rotate(radians(-angle + map(noise(k), 0, 1, -5, 5)));
      int starA = 2;
      int snowA = 0;
      if (snow == 0) {
        snowA = 1;
      } else if (snow == 2) {
        snowA = 3;
      } else if (snow == 3) {
        snowA = 3;
      } else {
        snowA = 4;
      }
      branch(slen, snowA, starA);
      popMatrix();

      pushMatrix();
      rotate(radians(angle + map(noise(1000 + k), 0, 1, -5, 5)));
      int starB = 2;
      int snowB = 0;
      if (snow == 0) {
        snowB = 2;
      } else if (snow == 1) {
        snowB = 3;
      } else if (snow == 3) {
        snowB = 3;
      } else {
        snowB = 4;
      }
      branch(slen, snowB, starB);
      popMatrix();

      pushMatrix();
      rotate(radians(map(noise(2000 + k), 0, 1, -2, 2)));
      int starC = 0;
      int snowC = 0;
      if (star == 0) {
        starC = 1;
      } else if (star == 1) {
        starC = 1;
      } else {
        starC = 2;
      }
      if (snow == 3) {
        snowC = 3;
      } else if (snow == 0) {
        snowC = 0;
      } else if (snow == 2) {
        snowC = 2;
      } else if (snow == 1) {
        snowC = 1;
      } else {
        snowC = 4;
      }
      branch(len, snowC, starC);
      popMatrix();

      // if (random(1) < .5) {
      //   push();
      //   rotate(radians(angle / 2 + map(noise(1000 + k), 0, 1, -10, 10)));
      //   branch(len);
      //   pop();
      // }
    } else {
      noStroke();
      fill(0, 120, 0, 60);
      ellipse(0, 0, random(4, 7), random(10, 20));

      if (snow == 3) {
        fill(255);
        ellipse(0, 0, 12, 12);
      }
      if (star == 1) {
        Astar();
      }
      light(timer);
    }
  }

void light(float timer) {
    int LED = round(random(300));
    //IntList colors = new StringList();
    int[] colors = new int[4];
    colors[0] = #FFC0CB;
    colors[1] = #FF3333;
    colors[2] = #FFD700;
    colors[3] = #663399;
    //colors.append("#FFC0CB");
    //colors.append("#FF3333");
    //colors.append("#FFD700");
    //colors.append("#663399");

    if (LED <= 1) {
      int ColorRandom = round(random(-0.5, 3.499));
      fill(colors[ColorRandom]);
      if (LED >= 0.5) {
        if (timer % 10000 >= 5000) {
          fill(0, 0);
        }
      }
      if (LED < 0.5) {
        if (timer % 10000 < 5000) {
          fill(0, 0);
        }
      }
      ellipse(0, 0, 25, 25);
    }
  }

  void Astar() {
    stroke(#DAA520);
    strokeWeight(2);
    fill(#FFFF00);
    for (int s = 0; s < 5; s++) {
      triangle(0, 0, 10 / tan(radians(54)), -10, 0, -40);
      triangle(0, 0, -10 / tan(radians(54)), -10, 0, -40);
      rotate(radians(72));
    }
  }




class Drop {
float x = random(width);
float y = random(-500, -50);
float z = random(0, 20);
float yspeed = map(z, 0, 20, 1, 10);

void fall() {
  y = y + yspeed;
  float grav = map(z, 0, 20, 0, 0.1);
  yspeed += grav;

  if (y > height) {
    y = random(-200, -100);
    yspeed = map(z, 0, 20, 4, 10);
  }
}

void show() {
  float snowSize = map(z, 0, 20, 1, 7);
  stroke(0, 0);
  fill(255);
  ellipse(x, y, snowSize, snowSize);
}
