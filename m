Return-Path: <linux-kernel+bounces-237715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E2923D16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E9A2874FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E8E15CD7C;
	Tue,  2 Jul 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb6O7c3I"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01983146A68;
	Tue,  2 Jul 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921715; cv=none; b=XS0gfqJmYD3EmFhD7yr6ZEhCn3YNqVUYZneDboWANEUfOCkPoBHcX8BrEW52idA/Cu0M+0DRarFL52WpoYmw9633NlnXkL72JLKqZwNdUevA5GeEjaz0Hp4yn1irLXTNPEwnsjsnNg+Yf/uRqLzc7na3DpfteaBFlUVmltKroIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921715; c=relaxed/simple;
	bh=rJCAcM3C1JUaxUdTOIuMUvG0MunkfYjmkeJ84V5gn9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xn4UQXLkw1GxV7n5qVue6B2VkATbhymwfN+Zc9X4yVj7cgZqUB1G0FBHUOR/zjJtnWPqvuE5h+jb251Gk4ep/vKC69PMfgmAY7fl0lu6zZYMTsanr0VH2Bcy120qYjDnxDFVbBJNwJiIFLcPr6QrZWM81ulDpiyTISdZ8SREKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb6O7c3I; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso2568376a91.2;
        Tue, 02 Jul 2024 05:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719921713; x=1720526513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=immZ7dYtz8mcNyvIOY7EMVgS8PS/MPa1M5Ott53bgFU=;
        b=Eb6O7c3I1aMjr2729uoc217ecXouK0HRyc6Pi9oEw2yoUw0rD7c4PFURPxXmyuv6Ky
         RZYUw3nfuoJ3Vj7TYO4j0WcxbPndxhgILPGPapoPc5nPYV6Hd2qj2Svi4ecHdqppini0
         9sUp7L6cCyY8XGtsLjtCPOQLT/HqcJXVdPpvB4dhLGay0G1Dj731eWmhyXXfS4k2s06b
         smuClSiGuGRo6NNMclYZRlNw+SOn4DXsO1dyaIBmDyqE6scMQjQvWqqpNVF/z8gziQaO
         irWeU8R5CHtkJEEx5vsfLJp7a2rdGml29Y3FoforOmtrzQryR9fOajuiwc1GvKjHv53v
         GsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719921713; x=1720526513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=immZ7dYtz8mcNyvIOY7EMVgS8PS/MPa1M5Ott53bgFU=;
        b=PTLGdgGvvP5JlFhSGEX4MkYB+Sdf/ZsaiAGesMGOVEtPeObicnioBg7F0OE8wCWY2H
         HTTcaW0KjM1eK1Zysbdx9o52b+KsFlOXlIgpYEZK7XIaVhJyNZKBwK6Qahh7f7+VGrph
         yDZqKH+Zgfx822Lo8VvjDlOwYh/1xR3qFQy8hgcXlb2boJca8FtDGaHfVmf5cW9lmS3o
         ztP6S36GotrbhN6rmrabHw128xQYmaJS/+UdVnKh8EwJU3b6U4H2PrfjZE4xGPMonKkY
         AGwCag349QE4RwLiPuThqyNkrDWnLL/Z2PS7kPiu6Zn5ShbSGTI1r/5GjJU8n4hxG9+8
         TJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi5EczYn2+xccNR2hiroxTludQufew4wtNdUkkr47FlBXz/4oeqIelT3qMekoQCyx4qxxIVbJJizpCsnjyrHluJ+1grtqRCu2t2+lWE44GHrYbvm5eoVhAga+iAnh5nY8DbBJMixZGEj6782TUlKGCqNCdnwpOdYqEaVCvwHrbzZ6AABBR
X-Gm-Message-State: AOJu0Yz4xpbyCU47JzeDeJljzwrOkv+NTD6HC6W2PeO8s2vJExqNGPW9
	AhOONuAVvFnCDJtGtDZE3KySuOyS4ijDoVsXy/qSLyfj1J7c8mjA
X-Google-Smtp-Source: AGHT+IECRhON6Sr/wc0mzrJG+6RAoWBQYYpFGVBpBNFAPCWPML6GKN/WcMkdtYb6pxxmPI37+d1a+w==
X-Received: by 2002:a17:90b:180d:b0:2c3:1234:8bbb with SMTP id 98e67ed59e1d1-2c93d771f59mr4883164a91.38.1719921711643;
        Tue, 02 Jul 2024 05:01:51 -0700 (PDT)
Received: from fedora.. ([2409:40e3:4029:df67:d5dc:7d86:b31:319d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce5490esm8725123a91.24.2024.07.02.05.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:01:51 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Rob Herring <robh@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: dt-bindings: realtek,rt5645: Convert to dtschema
Date: Tue,  2 Jul 2024 17:30:58 +0530
Message-ID: <20240702120106.17100-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the RT5650/RT5645 audio CODEC bindings to DT schema.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>

---
Changes in v2:
  - Added maxItems: 1 for cbj-sleeve-gpios and hp-detect-gpios.
---
 .../bindings/sound/realtek,rt5645.yaml        | 131 ++++++++++++++++++
 .../devicetree/bindings/sound/rt5645.txt      |  82 -----------
 2 files changed, 131 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5645.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
new file mode 100644
index 000000000000..13f09f1bc800
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5645.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RT5650/RT5645 audio CODEC
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+description: |
+  This device supports I2C only.
+
+  Pins on the device (for linking into audio routes) for RT5645/RT5650:
+    * DMIC L1
+    * DMIC R1
+    * DMIC L2
+    * DMIC R2
+    * IN1P
+    * IN1N
+    * IN2P
+    * IN2N
+    * Haptic Generator
+    * HPOL
+    * HPOR
+    * LOUTL
+    * LOUTR
+    * PDM1L
+    * PDM1R
+    * SPOL
+    * SPOR
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - realtek,rt5645
+      - realtek,rt5650
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: The CODEC's interrupt output.
+
+  avdd-supply:
+    description: Power supply for AVDD, providing 1.8V.
+
+  cpvdd-supply:
+    description: Power supply for CPVDD, providing 3.5V.
+
+  hp-detect-gpios:
+    description: 
+      A GPIO spec for the external headphone detect pin. If jd-mode = 0, we
+      will get the JD status by getting the value of hp-detect-gpios.
+    maxItems: 1
+
+  cbj-sleeve-gpios:
+    description:
+      A GPIO spec to control the external combo jack circuit to tie the
+      sleeve/ring2 contacts to the ground or floating. It could avoid some
+      electric noise from the active speaker jacks.
+    maxItems: 1
+
+  realtek,in2-differential:
+    description:
+      Indicate MIC2 input are differential, rather than single-ended.
+    type: boolean
+
+  realtek,dmic1-data-pin:
+    description: Specify which pin to be used as DMIC1 data pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic1 is not used
+      - 1 # using IN2P pin as dmic1 data pin
+      - 2 # using GPIO6 pin as dmic1 data pin
+      - 3 # using GPIO10 pin as dmic1 data pin
+      - 4 # using GPIO12 pin as dmic1 data pin
+
+  realtek,dmic2-data-pin:
+    description: Specify which pin to be used as DMIC2 data pin.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic2 is not used
+      - 1 # using IN2N pin as dmic2 data pin
+      - 2 # using GPIO5 pin as dmic2 data pin
+      - 3 # using GPIO11 pin as dmic2 data pin
+
+  realtek,jd-mode:
+    description: The JD mode of rt5645/rt5650.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # rt5645/rt5650 JD function is not used
+      - 1 # Mode-0 (VDD=3.3V), two port jack detection
+      - 2 # Mode-1 (VDD=3.3V), one port jack detection
+      - 3 # Mode-2 (VDD=1.8V), one port jack detection
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - cpvdd-supply
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
+        codec@1a {
+            compatible = "realtek,rt5650";
+            reg = <0x1a>;
+            hp-detect-gpios = <&gpio 19 0>;
+            cbj-sleeve-gpios = <&gpio 20 0>;
+            interrupt-parent = <&gpio>;
+            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            avdd-supply = <&avdd_reg>;
+            cpvdd-supply = <&cpvdd_supply>;
+            realtek,jd-mode = <3>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
deleted file mode 100644
index c1fa379f5f3e..000000000000
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ /dev/null
@@ -1,82 +0,0 @@
-RT5650/RT5645 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : One of "realtek,rt5645" or "realtek,rt5650".
-
-- reg : The I2C address of the device.
-
-- interrupts : The CODEC's interrupt output.
-
-- avdd-supply: Power supply for AVDD, providing 1.8V.
-
-- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
-
-Optional properties:
-
-- hp-detect-gpios:
-  a GPIO spec for the external headphone detect pin. If jd-mode = 0,
-  we will get the JD status by getting the value of hp-detect-gpios.
-
-- cbj-sleeve-gpios:
-  a GPIO spec to control the external combo jack circuit to tie the sleeve/ring2
-  contacts to the ground or floating. It could avoid some electric noise from the
-  active speaker jacks.
-
-- realtek,in2-differential
-  Boolean. Indicate MIC2 input are differential, rather than single-ended.
-
-- realtek,dmic1-data-pin
-  0: dmic1 is not used
-  1: using IN2P pin as dmic1 data pin
-  2: using GPIO6 pin as dmic1 data pin
-  3: using GPIO10 pin as dmic1 data pin
-  4: using GPIO12 pin as dmic1 data pin
-
-- realtek,dmic2-data-pin
-  0: dmic2 is not used
-  1: using IN2N pin as dmic2 data pin
-  2: using GPIO5 pin as dmic2 data pin
-  3: using GPIO11 pin as dmic2 data pin
-
--- realtek,jd-mode : The JD mode of rt5645/rt5650
-   0 : rt5645/rt5650 JD function is not used
-   1 : Mode-0 (VDD=3.3V), two port jack detection
-   2 : Mode-1 (VDD=3.3V), one port jack detection
-   3 : Mode-2 (VDD=1.8V), one port jack detection
-
-Pins on the device (for linking into audio routes) for RT5645/RT5650:
-
-  * DMIC L1
-  * DMIC R1
-  * DMIC L2
-  * DMIC R2
-  * IN1P
-  * IN1N
-  * IN2P
-  * IN2N
-  * Haptic Generator
-  * HPOL
-  * HPOR
-  * LOUTL
-  * LOUTR
-  * PDM1L
-  * PDM1R
-  * SPOL
-  * SPOR
-
-Example:
-
-codec: rt5650@1a {
-	compatible = "realtek,rt5650";
-	reg = <0x1a>;
-	hp-detect-gpios = <&gpio 19 0>;
-	cbj-sleeve-gpios = <&gpio 20 0>;
-	interrupt-parent = <&gpio>;
-	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-	realtek,dmic-en = "true";
-	realtek,en-jd-func = "true";
-	realtek,jd-mode = <3>;
-};
-- 
2.45.2


