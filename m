Return-Path: <linux-kernel+bounces-205761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ED98FFFEA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCA9283C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212CF157498;
	Fri,  7 Jun 2024 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBM00jEE"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1E13790B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754081; cv=none; b=n3mHjSfTZ7XzWZVms5GI8Neek14m+qEsSsfy/G4KtUCRBQIxaIoaBYX8g03OyjR86e9zJxpqlv/g+MOwrR89L4faSDWQZ7O0J9Gio0WJDevVGHsXZe88c2cMbzskDpcZzcckbM4sZ1saPsb9la0FmoQkBA/G/4C4JZnhBO9jlUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754081; c=relaxed/simple;
	bh=xw71Qt46ptk8d30DH8IHkvqH28EIKm1Uiz+CLu5ChCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MJK8kvdbyIWMYThNDTAs3OFXNQYNQ85XROFD7+kGE+YmbSlEB4a6nRhxey0N/jtDdGIs10os/eYvx/VEq/xX2swhFxvSwglkjBfuwIg+x3FgbfPO7Y9KzZSPy8JYnigYNHmij7bbJ24JI2lgFIH9/KN3MyOTq9KrMCulCa9gIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jBM00jEE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4216b80e36bso3802715e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717754077; x=1718358877; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1dI7O2M357iDdx/gYesZvs+fe+BF1aCu/fNw9Fv4io=;
        b=jBM00jEE9jzguYDmGuAIL+f78T3hq+tZS2a2ukIgiDEMJZbzCZJyZhW7v+5i7dSEMV
         RGvk1tXemtNrToHCrE+3JwVtev128+HEneWGQYmrP4KMPSx0ibrbOVDGV1du+LXPPJBI
         EooOs4OAsE8LYDaU6Ec9en4AioKVNgv64dAFjkiCzorvEU5QsGHLdEyuk8QTKHLqg/WJ
         XhkVYBISHZ7EOIjTNrxdMX4igglkzM/FljYzjRKCrV4ilxMvbg2rSOASSeKExYvvaXhU
         WwkENxOhB5kiNiQ3E8ilzIS+EwWojhBjGXRo69/iHxJKD34qyKu6Xn/ECZ6Rkp0UDSwp
         ljMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717754077; x=1718358877;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1dI7O2M357iDdx/gYesZvs+fe+BF1aCu/fNw9Fv4io=;
        b=kB5kkUgLEcpMEqxiWLRCMSNoxOYlgmpWBmh+/NK/AIdhuddC07iSwQen8S2Jod2AIJ
         StzciRDJg7P4+pl0OJ0sObA73ez10iBQRohNc3LmZOpOkRhHLgZVs3dMNHOVFq/6+L5Y
         Ht+dzecQHIzZsA7AFZd7NnO4mrAzPnjjOmdYsEjm4lkYqVS83tEC3bVbQmcd9PCZvH/h
         idBw8CaC9iLSyGGaacJl/NR3Bl9+BtGYPH3nW6h8gR9Mb6+k/fSOxMi5YCeVIepDFNkl
         WJfoygLydocJf2GqUZmu6pR4O1nqfJOqSYOul70/snAZ6ZMv1uy0zH9C5Z2fQ6aKuiB2
         xmnA==
X-Forwarded-Encrypted: i=1; AJvYcCXqgEAPm0i8nSwMu8tew0TTI+xAocbFhd3w9ww87jbyT/LT0AXTknle04G20tDdsqo6zle+VCzqkAs1Nz1megQXpaQ0Of3/bVGhmHNQ
X-Gm-Message-State: AOJu0YyqbnhFHhXxaAxgS8OPRTeRP5ZujV+PFyMxwNmpYVdm+1dgqb3M
	ATNYEWyHWHD3zbK3iozDVTRMQIwS7jkEEpsXM/LNLappqDJiw/GlFCGoB4hipMjvnRewOTMp4De
	F
X-Google-Smtp-Source: AGHT+IE1uW5XvO1RIV9uLpXgbfv5bywb64KBlRBEKTjKF24y4V+1ZyDorbEWvu3B3gfeZiX+4rO/6w==
X-Received: by 2002:adf:fc0c:0:b0:34d:9e54:11ec with SMTP id ffacd0b85a97d-35efed1b8f8mr1626240f8f.5.1717754076661;
        Fri, 07 Jun 2024 02:54:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d29b05sm3635097f8f.23.2024.06.07.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:54:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 07 Jun 2024 11:54:35 +0200
Subject: [PATCH] ASoC: dt-bindings: convert tas571x.txt to dt-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-topic-amlogic-upstream-bindings-convert-tas57xx-v1-1-ebf1e4919bb1@linaro.org>
X-B4-Tracking: v=1; b=H4sIANrYYmYC/x2NQQrDIBAAvxL23AUN0UC/UnrYmo1daDS4Ngghf
 6/0NMxl5gTlIqxwH04ofIhKTl3sbYDwphQZZekOoxkn482MNe8SkLZPjp3fXWth2vAlaZEUFUN
 OB5eKldTNraGj1bLzE3uy0Kt74VXa//h4XtcPBWNaXIEAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5825;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xw71Qt46ptk8d30DH8IHkvqH28EIKm1Uiz+CLu5ChCo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYtjbtOnM9nsOKjv8rCVTFwpsF062BfASvHbHznYA
 EcDI6UKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmLY2wAKCRB33NvayMhJ0VotD/
 9ps4/NxGrmtc9INAkC8zjPlR/EAAs+kZOP98PAGhX9/PUPPr2K2pcXLvYNnV/JcgwCbyyxRpeDEZ1R
 tVCq8bIr0MU9zezrCyED41a4RIK9GlYc/tTCBhzD9RVEMmt3sgqHFqZha+6GEbSW/TGxAgFSYy1GJk
 /7s0S4+yavWL5RBGCcaj8L8vGQ5m1TjWqjMVT6l40j7rgFHWE7hcOrERYrJSF9NTfMSaZzCMY1ipgC
 Y2TOwYtqwR/VrllzE6BylqE1YGYBEpJ2hrjFTYoBs/TvBofsUcT+BgXDjreX8uqDyR7ToTrh+RuNP5
 /raNtL/5YXN07OegMxXiPv15maJrg3RquFBHSGqCgsFpuqA21FGHMmW6WzsD3EQvmlDHHj1Trpf67y
 PbkaSzQU/55ruVKLFbuEddlF8jXMPPj2yBFkK8Qye8KxsRZFoKVlNcADNssKl1YA4zsvI3eRXJ1f+J
 W5L1YitYVt870NDkzQKMTrmbBY9rmdzFd4aOcnPYDQjajxF4SJ06DWC1yhjetszZ2QiWF9zlq8u/Cg
 3HSUm5C5NU8y7WVBuxvJ8PfNS+o4HijLJuMXOXAQd+pfYYpZzpNSi4esBzLq/a/SYQdhaH3hcesQ2o
 5XLIQZ2NvbXSTWREtwTQ4zqv6bwRama0k3OgfStv0PRAyxpIdwu1I9IIeJig==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the text bindings for the Texas Instruments
TAS5711/TAS5717/TAS5719/TAS5721 stereo power amplifiers to
dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/sound/tas571x.txt          |  49 --------
 .../devicetree/bindings/sound/ti,tas57xx.yaml      | 129 +++++++++++++++++++++
 2 files changed, 129 insertions(+), 49 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas571x.txt b/Documentation/devicetree/bindings/sound/tas571x.txt
deleted file mode 100644
index 1addc75989d5..000000000000
--- a/Documentation/devicetree/bindings/sound/tas571x.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Texas Instruments TAS5711/TAS5717/TAS5719/TAS5721 stereo power amplifiers
-
-The codec is controlled through an I2C interface.  It also has two other
-signals that can be wired up to GPIOs: reset (strongly recommended), and
-powerdown (optional).
-
-Required properties:
-
-- compatible: should be one of the following:
-  - "ti,tas5707"
-  - "ti,tas5711",
-  - "ti,tas5717",
-  - "ti,tas5719",
-  - "ti,tas5721"
-  - "ti,tas5733"
-- reg: The I2C address of the device
-- #sound-dai-cells: must be equal to 0
-
-Optional properties:
-
-- reset-gpios: GPIO specifier for the TAS571x's active low reset line
-- pdn-gpios: GPIO specifier for the TAS571x's active low powerdown line
-- clocks: clock phandle for the MCLK input
-- clock-names: should be "mclk"
-- AVDD-supply: regulator phandle for the AVDD supply (all chips)
-- DVDD-supply: regulator phandle for the DVDD supply (all chips)
-- HPVDD-supply: regulator phandle for the HPVDD supply (5717/5719)
-- PVDD_AB-supply: regulator phandle for the PVDD_AB supply (5717/5719)
-- PVDD_CD-supply: regulator phandle for the PVDD_CD supply (5717/5719)
-- PVDD_A-supply: regulator phandle for the PVDD_A supply (5711)
-- PVDD_B-supply: regulator phandle for the PVDD_B supply (5711)
-- PVDD_C-supply: regulator phandle for the PVDD_C supply (5711)
-- PVDD_D-supply: regulator phandle for the PVDD_D supply (5711)
-- DRVDD-supply: regulator phandle for the DRVDD supply (5721)
-- PVDD-supply: regulator phandle for the PVDD supply (5721)
-
-Example:
-
-	tas5717: audio-codec@2a {
-		compatible = "ti,tas5717";
-		reg = <0x2a>;
-		#sound-dai-cells = <0>;
-
-		reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
-		pdn-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
-
-		clocks = <&clk_core CLK_I2S>;
-		clock-names = "mclk";
-	};
diff --git a/Documentation/devicetree/bindings/sound/ti,tas57xx.yaml b/Documentation/devicetree/bindings/sound/ti,tas57xx.yaml
new file mode 100644
index 000000000000..fa6d6c1c8535
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,tas57xx.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,tas57xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TAS5711/TAS5717/TAS5719/TAS5721 stereo power amplifiers
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - ti,tas5707
+      - ti,tas5711
+      - ti,tas5717
+      - ti,tas5719
+      - ti,tas5721
+      - ti,tas5733
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO for the active low reset line
+
+  pdn-gpios:
+    maxItems: 1
+    description: GPIO for the active low powerdown line
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+  AVDD-supply: true
+  DVDD-supply: true
+  HPVDD-supply: true
+  PVDD_AB-supply: true
+  PVDD_CD-supply: true
+  PVDD_A-supply: true
+  PVDD_B-supply: true
+  PVDD_C-supply: true
+  PVDD_D-supply: true
+  DRVDD-supply: true
+  PVDD-supply: true
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas5717
+              - ti,tas5719
+    then:
+      properties:
+        PVDD_A-supply: false
+        PVDD_B-supply: false
+        PVDD_C-supply: false
+        PVDD_D-supply: false
+        DRVDD-supply: false
+        PVDD-supply: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas5711
+    then:
+      properties:
+        HPVDD-supply: false
+        PVDD_AB-supply: false
+        PVDD_CD-supply: false
+        DRVDD-supply: false
+        PVDD-supply: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas5721
+    then:
+      properties:
+        HPVDD-supply: false
+        PVDD_AB-supply: false
+        PVDD_CD-supply: false
+        PVDD_A-supply: false
+        PVDD_B-supply: false
+        PVDD_C-supply: false
+        PVDD_D-supply: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/gpio/gpio.h>
+   i2c {
+     #address-cells = <1>;
+     #size-cells = <0>;
+     codec: codec@2a {
+       compatible = "ti,tas5717";
+       reg = <0x2a>;
+       #sound-dai-cells = <0>;
+       reset-gpios = <&gpio1 15 0>;
+       pdn-gpios = <&gpio1 15 0>;
+       AVDD-supply = <&avdd_supply>;
+       DVDD-supply = <&dvdd_supply>;
+       HPVDD-supply = <&hpvdd_supply>;
+       PVDD_AB-supply = <&pvdd_ab_supply>;
+       PVDD_CD-supply = <&pvdd_cd_supply>;
+     };
+   };
+
+...

---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240607-topic-amlogic-upstream-bindings-convert-tas57xx-5af1e564e6a1

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


