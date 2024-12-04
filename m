Return-Path: <linux-kernel+bounces-430992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7B9E37EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365E02817C9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC471B0F18;
	Wed,  4 Dec 2024 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKPTU44p"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF6187FFA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309560; cv=none; b=Svu7CeL9v3ilzfnJcQsg0/zt1dnpKnSqymT/CJgU+QH2bHqoRFK0cyWoghsnI4X23yKmijMg3HKcr+UywkNd2bkYC5oz7zODaCjp/UM559t8k8FMqx1oN1liyly5UTTz+gDMRxYclTkChxK8akk70/+Qn51LkuyYWegDrwHTseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309560; c=relaxed/simple;
	bh=6H5W7vAAX4baxa4CotaWl12QMr7Ura2yQ4snDOf/5R8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c/3emQhVXFiaMsb6jK0TmNWzHYuESrL/km3dz14igRPfnlIsQ6Qyk0PmxJgBIDmZSobSo3KlzYZL/sSrjLL2VzCS/JQXh2H3dyCBtfmP6a4v3SRf5er3E62NUrhD8kdNcG4P/awi+YolLuj5IyjKHEBgG/kfkgG3P+QhecPzE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XKPTU44p; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e87b25f0so441202f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733309556; x=1733914356; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXlDq4NvanBdqWQ55WzKXWR/WSc5CjZr7sBnyCK5s3Q=;
        b=XKPTU44px35Up96aluQmGC9i6fQWlma3g8Pqztel9hhZQk8DSl1cj3bk8SloyGZ+hu
         XP84zLPFbPKgZ02A7FGq3Wun+oKyM9jo3Q9ZlcWmnwR2NJBoFBOM5xxwPWyE3PuSqRsf
         16asuOr8dUZoDmA02Mv+nJ3kA9AuofO8oqTEM+L+0tWREPdXXzH6JlxA3flGPi/IdjWJ
         lO6rdcNY1XbHca0X5NOqeZ1B511NlGkdxl+oCgFp1IDZgCJalr952O/djX7YOCi96H7n
         q5P5wL1GZzzCTtjSSsRx892ImOlS0HynQLMwCZMOLveq0p+x7Fe55e8UAqTLY1sGCQPm
         K4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309556; x=1733914356;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXlDq4NvanBdqWQ55WzKXWR/WSc5CjZr7sBnyCK5s3Q=;
        b=OwP3ivj7giowbb5gcbyZ7988a3MGgcwxZXJCa7CMbUiQe+G/lbbnALg1cd3UiVe8b2
         V+d44oTu7FxXYZXNiqlZDn6hD0un8E/F0NZwc9ZmuhoWrhi16vYwTVEFIlDYy0vN66DE
         7dFZsxmZ9tYZhZekC5Kpv5S1bjwDsRVcYVfjjYIC/GFsl+FfTMg/9DXMBj2Hh9CgGD6B
         nnaYlDg1tLVD8zEa9+/CmAcahrFlo+HN0Eul2UVpPK4EUdoyjWX5FTbJGeB3FLrjzeaU
         YI/VaRRjf+GcKJR43pdJLwv/04BXH8nONmMvZlCdQ5jkD7D3bIDwd1GuhGLcZMRr8DOE
         zzSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbEIY+j4+Y8ko7gfAl+sXL3ccUvTDHGZgmvxLOU1x2Tyk6FK2ml9qWim178X//qsjaiBJDQsB3iDCFwqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypjGUF8rRHGpmH/vYIaaw6n+IOS63cZ7mnCljO9tn5cw/ndvGm
	q8Wf9lbeXe+3cy6ijlyjIriWdKTh62gNRC7kE5Zr0Ghp+WShntjunTNH0wh9mbQ=
X-Gm-Gg: ASbGnctC1ma7V5AelWeD0PunN/INmGZ/msk6/IBe+BVM7BTPJAmeNcXQfofoT229DAS
	bmXh/LV58rvAIXS3QaaxgTnkHjye3OCPj3X7K27++ZL9HXmW3nBo4toIJQlYuDBfPILtpIoZKFn
	JfQE+Q6rt8zqtocjy42Ei38N2SfjOvXhPmi2uzT3SBVBEVBr6I9tFUmet7SJBR18Pe/A54Zsf72
	7APjs6bqkvsg6RiF+26owSS73yVhvI1WwtAqV6fGRT5TsnAr/riGBbc0ntUJyhnjNreUOA=
X-Google-Smtp-Source: AGHT+IFa3MLi99jt932u5A5Rth8o5r7ss/fYn5G3nVmix+wk3iyI7dVavu27cAhibMfyDlXErkHjnQ==
X-Received: by 2002:a05:6000:4707:b0:385:d72b:98 with SMTP id ffacd0b85a97d-385d72b0115mr18248841f8f.5.1733309556106;
        Wed, 04 Dec 2024 02:52:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273882sm20090935e9.16.2024.12.04.02.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:52:35 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 04 Dec 2024 11:52:34 +0100
Subject: [PATCH] ASoC: dt-bindings: convert rt5682.txt to dt-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-topic-misc-rt5682-convert-v1-1-0fedc4ab15e8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHE0UGcC/x3MTQqEMAxA4atI1hNI488Mc5XBhdaoWUwraRFBv
 LvF5bd474QkppLgW51gsmvSGArcqwK/DmER1KkYmLhxTA3muKnHvyaPltvuw+hj2MUy1iPVTOK
 GNxGUfjOZ9Xjev/66bgnQ7K9rAAAA
X-Change-ID: 20241204-topic-misc-rt5682-convert-3b0320e1a700
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8373;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6H5W7vAAX4baxa4CotaWl12QMr7Ura2yQ4snDOf/5R8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUDRybKcTTI3Tkt9kAoX5afSCwBY+LQ50RC5t8msk
 PVb97S6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1A0cgAKCRB33NvayMhJ0YWrEA
 CjbPgcmp6kfaypnx+Os0OQfRqsexNA3LNhz3wDMNWZsXSAfF+evHfFgKuOnb4KGV8nL6vxWbe0NslV
 39uIY29UvEbmKP6vlgu3t/NF7van2yQMYIiLcWCa9mA7QDrDWyysw6Ctxstqg7O7uI9XMXeZqZKEq3
 w87QLnaX5Zmw4iMvNUT+Jua64FbFVYC5rmfSS1yMWMVsUSTVcTYJxv0zRE5gcyhENJsJUioHyQf4hB
 pIhTbyswHhVV0fTqE+cLhS7QHm8n1Hd/wl65lc2zrgGB9qCHlumyvT1q65lUyK+9wiwwOeIgNACmKe
 REasV/D3oNYDlIg418ezm7EroIMaFif+4wgeIBfzMzYwfJ/dTTqJYmehv12rCA1QQ/+wcPDfCABw/L
 ruZ69jEUW4n59FzMEID6mhg8Ig23MZ/ICN9LkFPNEIUmkjUcxrmc7tUo5jKNS56uq+ZzB85NgPKF6t
 neEkSxlSHC29ZarKnuc+aMsbGv2kCPL/8ueHZGlgw6jMtNa1JIvx+QDdfLIulRhbIg5iMQHYWfcerR
 m9jCzeIH+GPrfALVHZlp4IxaMf9UmRgImPqk2qILdJYViX6rk0A0Q2V2Wnpyo3kyTXPBmeWAlVKi51
 e9+RopR0ZK6hb8iaZCSfSEnxn8gqF+d/MDMCz4Nk5awM8Me9SrUoXKItffoA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the text bindings for the Realtek rt5682 and
rt5682i codecs to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/sound/realtek,rt5682.yaml  | 160 +++++++++++++++++++++
 Documentation/devicetree/bindings/sound/rt5682.txt |  98 -------------
 2 files changed, 160 insertions(+), 98 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2fd5065551c473dce829155135b4cffb645bbf02
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5682.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek rt5682 and rt5682i codecs
+
+maintainers:
+  - Bard Liao <bardliao@realtek.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - realtek,rt5682
+      - realtek,rt5682i
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
+
+  interrupts:
+    maxItems: 1
+    description: The CODEC's interrupt output.
+
+  realtek,dmic1-data-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic1 data is not used
+      - 1 # using GPIO2 pin as dmic1 data pin
+      - 2 # using GPIO5 pin as dmic1 data pin
+    description:
+      Specify which GPIO pin be used as DMIC1 data pin.
+
+  realtek,dmic1-clk-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # using GPIO1 pin as dmic1 clock pin
+      - 1 # using GPIO3 pin as dmic1 clock pin
+    description:
+      Specify which GPIO pin be used as DMIC1 clk pin.
+
+  realtek,jd-src:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # No JD is used
+      - 1 # using JD1 as JD source
+    description:
+      Specify which JD source be used.
+
+  realtek,ldo1-en-gpios:
+    description:
+      The GPIO that controls the CODEC's LDO1_EN pin.
+
+  realtek,btndet-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The debounce delay for push button.
+      The delay time is realtek,btndet-delay value multiple of 8.192 ms.
+      If absent, the default is 16.
+
+  realtek,dmic-clk-rate-hz:
+    description:
+      Set the clock rate (hz) for the requirement of the particular DMIC.
+
+  realtek,dmic-delay-ms:
+    description:
+      Set the delay time (ms) for the requirement of the particular DMIC.
+
+  realtek,amic-delay-ms:
+    description:
+      Set the delay time (ms) for the requirement of the particular platform or AMIC.
+
+  realtek,dmic-clk-driving-high:
+    type: boolean
+    description:
+      Set the high driving of the DMIC clock out.
+
+  clocks:
+    items:
+      - description: phandle and clock specifier for codec MCLK.
+
+  clock-names:
+    items:
+      - const: mclk
+
+  "#clock-cells":
+    const: 1
+
+  clock-output-names:
+    minItems: 2
+    maxItems: 2
+    description: Name given for DAI word clock and bit clock outputs.
+
+  "#sound-dai-cells":
+    const: 1
+
+  AVDD-supply:
+    description: Regulator supplying analog power through the AVDD pin.
+
+  MICVDD-supply:
+    description: Regulator supplying power for the microphone bias through the
+      MICVDD pin.
+
+  VBAT-supply:
+    description: Regulator supplying battery power through the VBAT pin.
+
+  DBVDD-supply:
+    description: Regulator supplying I/O power through the DBVDD pin.
+
+  LDO1-IN-supply:
+    description: Regulator supplying power to the digital core and charge pump
+      through the LDO1_IN pin.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - AVDD-supply
+  - VBAT-supply
+  - MICVDD-supply
+  - DBVDD-supply
+  - LDO1-IN-supply
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
+        codec@1a {
+            compatible = "realtek,rt5682";
+            reg = <0x1a>;
+            interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
+            realtek,ldo1-en-gpios =
+                <&gpio 2 GPIO_ACTIVE_HIGH>;
+            realtek,dmic1-data-pin = <1>;
+            realtek,dmic1-clk-pin = <1>;
+            realtek,jd-src = <1>;
+
+            #clock-cells = <1>;
+            clock-output-names = "rt5682-dai-wclk", "rt5682-dai-bclk";
+
+            clocks = <&osc>;
+            clock-names = "mclk";
+
+            AVDD-supply = <&avdd_reg>;
+            VBAT-supply = <&vbat_reg>;
+            MICVDD-supply = <&micvdd_reg>;
+            DBVDD-supply = <&dbvdd_reg>;
+            LDO1-IN-supply = <&ldo1_in_reg>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
deleted file mode 100644
index 5e1d08de18a52021619bee9329d1f1cd693ca7cb..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ /dev/null
@@ -1,98 +0,0 @@
-RT5682 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : "realtek,rt5682" or "realtek,rt5682i"
-
-- reg : The I2C address of the device.
-
-- AVDD-supply: phandle to the regulator supplying analog power through the
-  AVDD pin
-
-- MICVDD-supply: phandle to the regulator supplying power for the microphone
-  bias through the MICVDD pin. Either MICVDD or VBAT should be present.
-
-- VBAT-supply: phandle to the regulator supplying battery power through the
-  VBAT pin. Either MICVDD or VBAT should be present.
-
-- DBVDD-supply: phandle to the regulator supplying I/O power through the DBVDD
-  pin.
-
-- LDO1-IN-supply: phandle to the regulator supplying power to the digital core
-  and charge pump through the LDO1_IN pin.
-
-Optional properties:
-
-- interrupts : The CODEC's interrupt output.
-
-- realtek,dmic1-data-pin
-  0: dmic1 is not used
-  1: using GPIO2 pin as dmic1 data pin
-  2: using GPIO5 pin as dmic1 data pin
-
-- realtek,dmic1-clk-pin
-  0: using GPIO1 pin as dmic1 clock pin
-  1: using GPIO3 pin as dmic1 clock pin
-
-- realtek,jd-src
-  0: No JD is used
-  1: using JD1 as JD source
-
-- realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
-
-- realtek,btndet-delay
-  The debounce delay for push button.
-  The delay time is realtek,btndet-delay value multiple of 8.192 ms.
-  If absent, the default is 16.
-
-- #clock-cells : Should be set to '<1>',  wclk and bclk sources provided.
-- clock-output-names : Name given for DAI clocks output.
-
-- clocks : phandle and clock specifier for codec MCLK.
-- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
-
-- realtek,dmic-clk-rate-hz : Set the clock rate (hz) for the requirement of
-  the particular DMIC.
-
-- realtek,dmic-delay-ms : Set the delay time (ms) for the requirement of
-  the particular DMIC.
-
-- realtek,dmic-clk-driving-high : Set the high driving of the DMIC clock out.
-
-- #sound-dai-cells: Should be set to '<1>'.
-
-Pins on the device (for linking into audio routes) for RT5682:
-
-  * DMIC L1
-  * DMIC R1
-  * IN1P
-  * HPOL
-  * HPOR
-
-Example:
-
-rt5682 {
-	compatible = "realtek,rt5682i";
-	reg = <0x1a>;
-	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(U, 6) IRQ_TYPE_LEVEL_HIGH>;
-	realtek,ldo1-en-gpios =
-		<&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
-	realtek,dmic1-data-pin = <1>;
-	realtek,dmic1-clk-pin = <1>;
-	realtek,jd-src = <1>;
-	realtek,btndet-delay = <16>;
-
-	#clock-cells = <1>;
-	clock-output-names = "rt5682-dai-wclk", "rt5682-dai-bclk";
-
-	clocks = <&osc>;
-	clock-names = "mclk";
-
-	AVDD-supply = <&avdd_reg>;
-	MICVDD-supply = <&micvdd_reg>;
-	DBVDD-supply = <&dbvdd_reg>;
-	LDO1-IN-supply = <&ldo1_in_reg>;
-};

---
base-commit: 695ead81c12bf5430239b43e9d862d6d790e12ce
change-id: 20241204-topic-misc-rt5682-convert-3b0320e1a700

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


