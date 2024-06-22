Return-Path: <linux-kernel+bounces-225758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C779134E4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030A7284793
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A358B16FF30;
	Sat, 22 Jun 2024 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAGR6Xl+"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF59B660;
	Sat, 22 Jun 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719070709; cv=none; b=UGutJ2wQyGV6tc6o40iml0M+dDqP4TyKRpwsQx/hvUkvm7jJN7k4rnF9GNgCrJOHtF5OnqWtPsXfAorRW2gB085mZRmD6VYjfhfwtdbFarVvr+c2f6/ZDXLJONYp0+uSeMxFdOtuJEwq/SQA15WuZsUtdDGQIHLoIXARBxyLUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719070709; c=relaxed/simple;
	bh=gT9SKhzEYCq/WK0ydAPi++X6+w9UQanGgqS760UEHNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oa2q7+9uKtQSEImKcnvVg/3CdfmC+Z9nSvxNVT7ph8nEvPd/49ODwUXAobAQpxyV8Z//EuSQD+a4hWTvIU7ilvgP0tdFk+ejqiWefIpJjN3UO2vKL59LPI6sfxSU5THAcuKRF6bv17qXbqexmTmb1TmoDl3ZRuCtkyVfnCSZRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAGR6Xl+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c7da220252so2399688a91.1;
        Sat, 22 Jun 2024 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719070707; x=1719675507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bj/XTmmg7MF2I7Bw1ftzUeRXm7R4y2rYNK4ZrBR4ZfI=;
        b=mAGR6Xl+6Kc9yKunifx1wZB/r0g6+yv6DGYJEn279pyQR6Dp49r9nqvLq03w6fKmmw
         3O8UHKl9plYIoz4zDg4rehfuWIerxvSaZPeaJYoUWejARRvlZABkN2vW3f6u4wZnKOap
         Vpy60pHSYDpb3Uryu9yqP/wr1NqwEZxYm5bsMkmqqpWEyyolV1Hzby43Ch+wVs7duYqS
         RneJyL3BczGitCL3qraORYUlTM4zXwV0ws1toPx+5X1PTzhpTmTdAF6/7YWdxqpbQgnv
         aloCqJly2Bn1rpoaKBeuhZV4WJErabLnMXRIsN44NcY2mvVYNkFp1J0/1vMm0L4G5TwQ
         3Twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719070707; x=1719675507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bj/XTmmg7MF2I7Bw1ftzUeRXm7R4y2rYNK4ZrBR4ZfI=;
        b=qGZWU/PO0ENKJ5A/tQs4ZY7a7mGwelCnvv8zPhVd/bmISrkhpn+JyhRengKme5K+Lv
         +g9NMznbLWMhIU8RoMn8FkLRkhAIrU9epIuKo4Hn5xi5s4MAn34dw8/DogqHvvOYhSFE
         YnvfiuPATzMVoWkvVDK4TKwj8ss3zUP3GTCwPamWk7Zw9MPxAgDkaudnc7Gv1oHFbQ0U
         XFC73REY8XN7pXvh89bRgnZrgG1rIqhz7Vt54mB3ehOInJkYa6d/2ba/M4z51Rk3YK1W
         wV4sXuPbAG8H/CHt09yZvRerHT77q1wIEdxUEv0OSr1sHacUsB7bO0CyD7+3zcbOKYPH
         yuwg==
X-Forwarded-Encrypted: i=1; AJvYcCWYz3HM0faRZQpncfhY5MqdZqbJhkFq0SAqEfjwhxNfy9hxDpOn8h/jx8q1JQt4ACCSxhagqTqtIl7re8vbUTaTc3/X6119IIKcoQszc96ickVLv6pGV1AEvTD9Ref5atWmbdcdAPaSBx/qYrO/4tGC5kBDpbFMOUFpmOU/LnkNsGXH/LJK
X-Gm-Message-State: AOJu0YzPhI5ORG3O7cqpHp/F2cXkMt9msRTCq4hIRYa0vsbLw2hbWTWo
	X517MxAQSGLeFmneJwvPxZzuKcTLj8PhS+rofmZNSQN7pbdU5Oxe
X-Google-Smtp-Source: AGHT+IGHZQpebHkYN4k5oJGo/Kixh/DAUUXiw8QholUSnCYyl+ZDY5eaFrNdxjZ0vCQMDU3s18hfRw==
X-Received: by 2002:a17:90b:50c8:b0:2c0:238c:4ee6 with SMTP id 98e67ed59e1d1-2c86121446cmr216755a91.2.1719070707293;
        Sat, 22 Jun 2024 08:38:27 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dbb7c6sm3476737a91.40.2024.06.22.08.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 08:38:26 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: realtek,rt5659: Convert to dtschema
Date: Sat, 22 Jun 2024 21:07:47 +0530
Message-ID: <20240622153752.94644-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the RT5659/RT5658 audio CODEC bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../bindings/sound/realtek,rt5659.yaml        | 132 ++++++++++++++++++
 .../devicetree/bindings/sound/rt5659.txt      |  89 ------------
 2 files changed, 132 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5659.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
new file mode 100644
index 000000000000..da6966c65c02
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5659.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RT5659/RT5658 audio CODEC
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+description: |
+  This device supports I2C only.
+
+  Pins on the device (for linking into audio routes) for RT5659/RT5658:
+    * DMIC L1
+    * DMIC R1
+    * DMIC L2
+    * DMIC R2
+    * IN1P
+    * IN1N
+    * IN2P
+    * IN2N
+    * IN3P
+    * IN3N
+    * IN4P
+    * IN4N
+    * HPOL
+    * HPOR
+    * SPOL
+    * SPOR
+    * LOUTL
+    * LOUTR
+    * MONOOUT
+    * PDML
+    * PDMR
+    * SPDIF
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - realtek,rt5659
+      - realtek,rt5658
+
+  reg:
+    maxItems: 1
+    description: The I2C address of the device.
+
+  interrupts:
+    maxItems: 1
+    description: The CODEC's interrupt output.
+
+  clocks:
+    maxItems: 1
+    description: phandle and clock specifier for codec MCLK.
+
+  clock-names:
+    const: mclk
+
+  realtek,dmic1-data-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic1 is not used
+      - 1 # using IN2N pin as dmic1 data pin
+      - 2 # using GPIO5 pin as dmic1 data pin
+      - 3 # using GPIO9 pin as dmic1 data pin
+      - 4 # using GPIO11 pin as dmic1 data pin
+    description: Specify which pin to be used as DMIC1 data pin.
+
+  realtek,dmic2-data-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic1 is not used
+      - 1 # using IN2P pin as dmic1 data pin
+      - 2 # using GPIO6 pin as dmic1 data pin
+      - 3 # using GPIO10 pin as dmic1 data pin
+      - 4 # using GPIO12 pin as dmic1 data pin
+    description: Specify which pin to be used as DMIC2 data pin.
+
+  realtek,jd-src:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # No JD is used
+      - 1 # using JD3 as JD source
+      - 2 # JD source for Intel HDA header
+    description: Specify which JD source be used.
+
+  realtek,ldo1-en-gpios:
+    maxItems: 1
+    description: The GPIO that controls the CODEC's LDO1_EN pin.
+
+  realtek,reset-gpios:
+    maxItems: 1
+    description: The GPIO that controls the CODEC's RESET pin.
+
+  sound-name-prefix: true
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1b {
+            compatible = "realtek,rt5659";
+            reg = <0x1b>;
+            interrupt-parent = <&gpio>;
+            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+            realtek,ldo1-en-gpios =
+                <&gpio 3 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5659.txt b/Documentation/devicetree/bindings/sound/rt5659.txt
deleted file mode 100644
index 8f3f62c0226a..000000000000
--- a/Documentation/devicetree/bindings/sound/rt5659.txt
+++ /dev/null
@@ -1,89 +0,0 @@
-RT5659/RT5658 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : One of "realtek,rt5659" or "realtek,rt5658".
-
-- reg : The I2C address of the device.
-
-- interrupts : The CODEC's interrupt output.
-
-Optional properties:
-
-- clocks: The phandle of the master clock to the CODEC
-- clock-names: Should be "mclk"
-
-- realtek,in1-differential
-- realtek,in3-differential
-- realtek,in4-differential
-  Boolean. Indicate MIC1/3/4 input are differential, rather than single-ended.
-
-- realtek,dmic1-data-pin
-  0: dmic1 is not used
-  1: using IN2N pin as dmic1 data pin
-  2: using GPIO5 pin as dmic1 data pin
-  3: using GPIO9 pin as dmic1 data pin
-  4: using GPIO11 pin as dmic1 data pin
-
-- realtek,dmic2-data-pin
-  0: dmic2 is not used
-  1: using IN2P pin as dmic2 data pin
-  2: using GPIO6 pin as dmic2 data pin
-  3: using GPIO10 pin as dmic2 data pin
-  4: using GPIO12 pin as dmic2 data pin
-
-- realtek,jd-src
-  0: No JD is used
-  1: using JD3 as JD source
-  2: JD source for Intel HDA header
-
-- realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
-- realtek,reset-gpios : The GPIO that controls the CODEC's RESET pin.
-
-- sound-name-prefix: Please refer to dai-common.yaml
-
-- ports: A Codec may have a single or multiple I2S interfaces. These
-  interfaces on Codec side can be described under 'ports' or 'port'.
-  When the SoC or host device is connected to multiple interfaces of
-  the Codec, the connectivity can be described using 'ports' property.
-  If a single interface is used, then 'port' can be used. The usage
-  depends on the platform or board design.
-  Please refer to Documentation/devicetree/bindings/graph.txt
-
-Pins on the device (for linking into audio routes) for RT5659/RT5658:
-
-  * DMIC L1
-  * DMIC R1
-  * DMIC L2
-  * DMIC R2
-  * IN1P
-  * IN1N
-  * IN2P
-  * IN2N
-  * IN3P
-  * IN3N
-  * IN4P
-  * IN4N
-  * HPOL
-  * HPOR
-  * SPOL
-  * SPOR
-  * LOUTL
-  * LOUTR
-  * MONOOUT
-  * PDML
-  * PDMR
-  * SPDIF
-
-Example:
-
-rt5659 {
-	compatible = "realtek,rt5659";
-	reg = <0x1b>;
-	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_HIGH>;
-	realtek,ldo1-en-gpios =
-		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
-};
-- 
2.45.2


