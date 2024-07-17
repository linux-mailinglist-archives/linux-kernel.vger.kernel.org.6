Return-Path: <linux-kernel+bounces-254789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164DC93379C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399231C20A90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF841864C;
	Wed, 17 Jul 2024 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldKfg3wN"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58CE14267;
	Wed, 17 Jul 2024 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200235; cv=none; b=KOpiUiAgAUTRwNLXDpAgre9eEE/lKEA2jNn3KRQY+Yrl7ToXtVECRb+u7HBexSMWrAPFNq3Wf+m0+iyCqpT4Nn+jkgMD5rlojPycwzgbpqqRZDS2FD9UrwiXoVAfMywEodm2PVShx8RLjh6pynViTZr9CM1/7fohFboSGGjLxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200235; c=relaxed/simple;
	bh=pbB84E+DJFZ7Rqz4bRF7r+sShLSkf9DDLjHCtgiQTlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUywVupsCK0cCln3QIxo3r3j//hnIc3bgZr/gNm8ca6PJzwxp8yoi22E1EPtrsPcsUV0hgi+AcqGKPZ2ibUn3lgkbJsA8kWWSY6MYx/Gu/IE54zqQaGc3DB2LN3USlOMPto90XLwBsxxrzlUJybfu8aHAloVrGle+OqZPW/s+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldKfg3wN; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9cc681e4fso3554042b6e.0;
        Wed, 17 Jul 2024 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721200233; x=1721805033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzFXhN/4zexpSGV6jXmNmwyuYw2EujDfcH8DxGXktmk=;
        b=ldKfg3wN63owKo/iyntPxxflZ/gNfgLcvPocK4EhquJX21Bcw5ziX97OS2uyiGHJEO
         L0NFFVK92iLpCFBJx3vTxSmLaGnpkznwW8H9j4rY14EO94fj2y0qlDPbclwH9rJn3qpI
         QbDEYZoXL2Rm1ArG5X2ko4pdIXXfcq9rmV11zAfgI2ENXG8dGoKrl7EqmxBZUAS7t2Na
         M6lQZMBR5oYIl7ZMgEKSV7sLZT/dg6XhpU33STtFk99LWUSr75QNZeC2sdYSmoNyamll
         7wq7OTPEogdNDFNK7c0fFYdeS/vqMtee9sJRwgACKUsKdcdc92MT2rdjayo7LQ0Lpewc
         t5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721200233; x=1721805033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzFXhN/4zexpSGV6jXmNmwyuYw2EujDfcH8DxGXktmk=;
        b=l8ZfuV8QwaBTR/FlnDHEauIcmXLXxXIhQ4bRCbib80g7XGBKg4rvR+yUa1TgCtiw3V
         RgV70+y8/iZzWZRARMY/QS9CE9SWwXuGypg0pELtNFlcf/XIuUsvbsrgUa54N1BFZXJ1
         dI1GgPHCTxGRDTiAdX+SOD1q7UVqcNHTVm+1Di5IiBzKmxD9VHXwmH1ZEqAp3Oe6HAoC
         2vL7F3J5ypNfUvPhnQxwioxvjw0ZXtnEjh2NoFQrgh87j+GBG//SwvVSOSJjxup3cLp+
         mI6RG2Y8AEbqkcEhTD4AfpTd9RmKG9lfIs9Y5CEopr7yJsFt/nuEssW/3Ty2sFKofkIA
         AhvA==
X-Forwarded-Encrypted: i=1; AJvYcCUJPkubyE7A4X6/rPm7ru5TyxKpq23nSZjIIIaTqT1OfQjYobCeuMw6e0YSQGPFWermMDUznVcFW8sTX/U0tgdtUXed1Y2lKOtsMWY+taSUSZUyWDjrhWag4g8byf2GjYVT4fyj87OVRttJo5YnsaPZBsC0mqM12/X16qb3CxNBJmvmwYa4
X-Gm-Message-State: AOJu0YyhP97hpxHYVqlGG3qQ0CJyeJLizr/PgbgbDzdM32DpLagWoVYT
	o16BEaqpHLjzeAZ8+jeDDLVhrQwgAQmIgLXInlTBoDrKR/rx2qPE
X-Google-Smtp-Source: AGHT+IHYHLNiQMYFfPuy8h3AbJt+F+ROLpfldNCC0RiWPWi7h5zs8pqh7AbWsxlPdKaSWx4l2J3quA==
X-Received: by 2002:a05:6871:5228:b0:259:cdf1:b8af with SMTP id 586e51a60fabf-260d9504d67mr653256fac.46.1721200232596;
        Wed, 17 Jul 2024 00:10:32 -0700 (PDT)
Received: from fedora.. ([2409:40f4:a8:bf06:b8b7:aa61:3ed2:c8f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c856sm7520236b3a.4.2024.07.17.00.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 00:10:32 -0700 (PDT)
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
Subject: [PATCH] ASoC: dt-bindings: ti,pcm512x: Convert to dtschema
Date: Wed, 17 Jul 2024 12:40:08 +0530
Message-ID: <20240717071012.114786-1-animeshagarwal28@gmail.com>
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
 .../devicetree/bindings/sound/pcm512x.txt     |  53 ---------
 .../devicetree/bindings/sound/ti,pcm512x.yaml | 112 ++++++++++++++++++
 2 files changed, 112 insertions(+), 53 deletions(-)
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
index 000000000000..a8635477d23e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm512x.yaml
@@ -0,0 +1,112 @@
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
+      description: GPIO pin used to connect the pll using <1> through <3>. The
+        device will be configured for clock input on the given pll-in pin.
+      $ref: /schemas/types.yaml#/definitions/uint32
+      minimum: 1
+      maximum: 3
+
+    pll-out:
+      description: GPIO pin used to connect the pll using <1> through <3>. The
+        device will be configured for PLL output on the given pll-out pin.  An
+        external connection from the pll-out pin to the SCLK pin is assumed.
+      $ref: /schemas/types.yaml#/definitions/uint32
+      minimum: 1
+      maximum: 3
+
+else:
+  properties:
+    pll-in:
+      description: GPIO pin used to connect the pll using <1> through <6>. The
+      device will be configured for clock input on the given pll-in pin.
+      $ref: /schemas/types.yaml#/definitions/uint32
+      minimum: 1
+      maximum: 6
+
+    pll-out:
+      description: GPIO pin used to connect the pll using <1> through <6>. The
+        device will be configured for PLL output on the given pll-out pin.  An
+        external connection from the pll-out pin to the SCLK pin is assumed.
+      $ref: /schemas/types.yaml#/definitions/uint32
+      minimum: 1
+      maximum: 6
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


