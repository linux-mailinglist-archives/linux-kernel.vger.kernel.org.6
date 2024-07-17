Return-Path: <linux-kernel+bounces-255245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B7E933DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6511F22457
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F73E180A7B;
	Wed, 17 Jul 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLm/ACed"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C81802CF;
	Wed, 17 Jul 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224076; cv=none; b=Jr6bRKOo9grdM7ZTyraHwT4rg0BvxOJXvdmKcdr0uVsXPvrVk+86k87i8nLcjeASI3Frltq1/dmycW1W+9+AaRu6R24/1bA2STON/bMIPuooKQWHF9QWCSJFA2AwrKmrXXk/qanubIhfo0b3e871gM5anDpd2+QuOlWBRJO/CpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224076; c=relaxed/simple;
	bh=TK5CcCrQpoQwMuE1ZtzVEvqvCNUw1UJgh/OinqbaVnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aW0JRRnUVX9V4sb0jBxwWY89V0ECbUvtFUwj24a0T2eV7pVi13urGOFnXqfqQPPGQmCLNEqHZ7KCVN7/SmUnHOUsmGu0U2r667VcK1RyDVCBujIsrDMccb4MPyMmPS3bi+QW2jx7dH/BHZqfIPWEVbyBjF6seBvjo9e+sb2T7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLm/ACed; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb05ac6b77so41059505ad.0;
        Wed, 17 Jul 2024 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721224074; x=1721828874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJiVjPpB17KuA/ZiRxr8+LU1A6kvrnOJUhTd7VpuBq0=;
        b=dLm/ACedESzNmWSNa3Jhqr15BDf9AB3X+IV/OjK1SFIygnGrbQPpN8rBOuwvyjzULp
         hzxogyMnRlL6tlcirQjSEw3Nmh+RdMW+JOSDOkBeTZv3QdyXWphAf4esAC7nOrOvSI6D
         MpioZ2VAx2HQTegDPf2sItpB0dsrJ0y4Db28MW+Icj+UGmamOlJDTf7+QcflpRt+x4ks
         JBA/ul7qdeL6gIJHLXSCr6CJYqSbfqEOUi5b1PiOKI3C2nIq5ZCZCIo2m1ARqm9BkrZO
         vyZWbJVsrUcYdnsOWHXHioKeEET5KttO3i7R/YLZ6McgucfCkfjzUlY6Zb2d1jdJucxb
         E8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721224074; x=1721828874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJiVjPpB17KuA/ZiRxr8+LU1A6kvrnOJUhTd7VpuBq0=;
        b=NlGldCr8OnkB6I/0A++u1+2+SmCfKCt3JcCmvjiAT1xRT9DPg1K94K+rKA7Ph0CfPY
         K2PgbstTt1H2HfDsxjpI5gQpQeOR0Hn3sdyUiX8JZQA27fSEbRFNmuvET7EivRfoZ/vN
         4wdLF9G4IDIrICl2ueWpebtAU6RVVurNHr5o+l2wGj5m9OEvVoj1HoDnChadYtaq049M
         PBOjRvn3KQkc3H+ZF8+1WWaU1/trEXePaVAKj8uRVimJPmu0cvq6+1X3tmwO/37/3CU7
         7KSW5+q+minrWfGt+tyYKGib+XbJR49ngqZqM97LzgzGPrn2bZkOT9FhAhKpKkLf1CgW
         QtQw==
X-Forwarded-Encrypted: i=1; AJvYcCUXZdW+ODXt+AWM98K/Jz1fbO7clM2U+IxD9jYqfT6NB432fs2TPE5FSnDD2AicYVU5HHw7RClEcOLBYl6vJ/i/6ETTAJ3xyeUYL1pxn+BFMezYh2SHLvw+Mxkb0myG+/uLrtITADlaKKfaUiKv0fhmAhpXDFVctw52Y7WR9T31M+xvGMTk
X-Gm-Message-State: AOJu0YwoBiDgzj4oRKH5U5EAl2/9ro+YezUKmqd/Uis04JcEqh+6vabS
	U7RKmyTkxjAO+INap5N3lLp3ev0cxb6m7oHDJ6UbdIcP6npqRsYU7Wu1iL01RPclig==
X-Google-Smtp-Source: AGHT+IGrhV4IzgF4D3H6T1QQOr4+kF3oasP7TI0Bm4g2gxxwNjEehpGI6GoU8BEg0Nzbds/s4fcHJw==
X-Received: by 2002:a17:902:e5c2:b0:1fb:6b94:66ee with SMTP id d9443c01a7336-1fc4e15280bmr16645435ad.26.1721224073640;
        Wed, 17 Jul 2024 06:47:53 -0700 (PDT)
Received: from localhost.localdomain ([115.240.194.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc516dasm75114775ad.288.2024.07.17.06.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:47:52 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: dt-bindings: ti,pcm512x: Convert to dtschema
Date: Wed, 17 Jul 2024 19:17:21 +0530
Message-ID: <20240717134729.51661-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the PCM512x and TAS575x audio CODECs/amplifiers bindings to DT
schema format. Add missing sound-dai-cells property.

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v2:
  - Defined pll-in and pll-out in top-level propertirs list (outside
    conditional statements).
---
 .../devicetree/bindings/sound/pcm512x.txt     |  53 ---------
 .../devicetree/bindings/sound/ti,pcm512x.yaml | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/pcm512x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm512x.yaml

diff --git a/Documentation/devicetree/bindings/sound/pcm512x.txt b/Documentation/devicetree/bindings/sound/pcm512x.txt
deleted file mode 100644
index 47878a6df608..000000000000
--- a/Documentation/devicetree/bindings/sound/pcm512x.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-PCM512x and TAS575x audio CODECs/amplifiers
-
-These devices support both I2C and SPI (configured with pin strapping
-on the board). The TAS575x devices only support I2C.
-
-Required properties:
-
-  - compatible : One of "ti,pcm5121", "ti,pcm5122", "ti,pcm5141",
-                 "ti,pcm5142", "ti,pcm5242", "ti,tas5754" or "ti,tas5756"
-
-  - reg : the I2C address of the device for I2C, the chip select
-          number for SPI.
-
-  - AVDD-supply, DVDD-supply, and CPVDD-supply : power supplies for the
-    device, as covered in bindings/regulator/regulator.txt
-
-Optional properties:
-
-  - clocks : A clock specifier for the clock connected as SCLK.  If this
-    is absent the device will be configured to clock from BCLK.  If pll-in
-    and pll-out are specified in addition to a clock, the device is
-    configured to accept clock input on a specified gpio pin.
-
-  - pll-in, pll-out : gpio pins used to connect the pll using <1>
-    through <6>.  The device will be configured for clock input on the
-    given pll-in pin and PLL output on the given pll-out pin.  An
-    external connection from the pll-out pin to the SCLK pin is assumed.
-    Caution: the TAS-desvices only support gpios 1,2 and 3
-
-Examples:
-
-	pcm5122: pcm5122@4c {
-		compatible = "ti,pcm5122";
-		reg = <0x4c>;
-
-		AVDD-supply = <&reg_3v3_analog>;
-		DVDD-supply = <&reg_1v8>;
-		CPVDD-supply = <&reg_3v3>;
-	};
-
-
-	pcm5142: pcm5142@4c {
-		compatible = "ti,pcm5142";
-		reg = <0x4c>;
-
-		AVDD-supply = <&reg_3v3_analog>;
-		DVDD-supply = <&reg_1v8>;
-		CPVDD-supply = <&reg_3v3>;
-
-		clocks = <&sck>;
-		pll-in = <3>;
-		pll-out = <6>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/ti,pcm512x.yaml b/Documentation/devicetree/bindings/sound/ti,pcm512x.yaml
new file mode 100644
index 000000000000..21ea9ff5a2bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm512x.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,pcm512x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCM512x and TAS575x audio CODECs/amplifiers
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,pcm5121
+      - ti,pcm5122
+      - ti,pcm5141
+      - ti,pcm5142
+      - ti,pcm5242
+      - ti,tas5754
+      - ti,tas5756
+
+  reg:
+    maxItems: 1
+
+  AVDD-supply: true
+
+  DVDD-supply: true
+
+  CPVDD-supply: true
+
+  clocks:
+    maxItems: 1
+    description: A clock specifier for the clock connected as SCLK. If this is
+      absent the device will be configured to clock from BCLK. If pll-in and
+      pll-out are specified in addition to a clock, the device is configured to
+      accept clock input on a specified gpio pin.
+
+  '#sound-dai-cells':
+    const: 0
+
+  pll-in:
+    description: GPIO pin used to connect the pll using <1> through <6>. The
+      device will be configured for clock input on the given pll-in pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 6
+
+  pll-out:
+    description: GPIO pin used to connect the pll using <1> through <6>. The
+      device will be configured for PLL output on the given pll-out pin.  An
+      external connection from the pll-out pin to the SCLK pin is assumed.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 6
+
+required:
+  - compatible
+  - reg
+  - AVDD-supply
+  - DVDD-supply
+  - CPVDD-supply
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ti,tas5754
+          - ti,tas5756
+
+then:
+  properties:
+    pll-in:
+      maximum: 3
+
+    pll-out:
+      maximum: 3
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@4c {
+            compatible = "ti,pcm5142";
+            reg = <0x4c>;
+            AVDD-supply = <&reg_3v3_analog>;
+            DVDD-supply = <&reg_1v8>;
+            CPVDD-supply = <&reg_3v3>;
+            #sound-dai-cells = <0>;
+            clocks = <&sck>;
+            pll-in = <3>;
+            pll-out = <6>;
+        };
+    };
-- 
2.45.2


