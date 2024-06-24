Return-Path: <linux-kernel+bounces-227280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B41914EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5959928184D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF43A1411FA;
	Mon, 24 Jun 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4xZmgHp"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90172FC08;
	Mon, 24 Jun 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235809; cv=none; b=EBaPLGTJ8K6Hp0stWDY9fVLGmom5o8Lj+l/JHkIQBDIgYyoM1i4GAc0oZAo4t02QTOEhmYBfZAqTbDOGydRDTXYgTpUoZDKI9v9K/V7mFtcu3qjkEW9pyuP0BwVREPx8deu1W6HxEL5FeiXwDJLUc+7djq06dCONMLzfYBJ2Ihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235809; c=relaxed/simple;
	bh=4sv378fujeglQ3cZDizL0q0nX5zw8mKOUFqS0Dw6mp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PN+F2Sow7GP3gekDOmR3DXCFHnmG9FVA5dMmrdYiMtrV4jPJW65RBZs96WQMxJB72/QsU82nTwCkP7W7wxWbuXRy+b05kqSdX6M6w79lG5gFIMvzmox7zDsrSWZBXqGfqvuub12bC/Uo243FIOq96DCFMr8OCQ3cLYRaTb8EL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4xZmgHp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7066c9741fbso1756843b3a.2;
        Mon, 24 Jun 2024 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235807; x=1719840607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXltrUw5MuEEzoCZGOtO9g4puazQVQqF/y+GWYY9aCI=;
        b=K4xZmgHpwazKNXgybR3NDhcdVM6qkTuScL4D33Fhk6nWefsR5Ji09Ekv8hmcxglr/l
         axecfbvyT9hEXqcREEIpclUPyCF4cpdykTpJSV/jaJgXcO3R/VHHolKz7WLudGFi8516
         PeIbRUCsxwwfahhZR2lddZMbk75O0T5Gw1hrm/PArm14h7t43yppbHumvY+avcISc3ep
         XKN6Kt3VPjEPbtMDHmat+ytVcGVySQvll4X7NqZpHgjOPxRsJnqvZ2aQcErgt0mBYIt9
         /quFao/qRQCwEPaYZjmw8wPjb15fGIEw3wELlnDKhR7rG1iplG5jeUdDmnNt2McNQiSk
         JUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235807; x=1719840607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXltrUw5MuEEzoCZGOtO9g4puazQVQqF/y+GWYY9aCI=;
        b=rWS1Lh3P7w4OMoBY7Vk4f1RSM7d8wla9+qmTkFi335iqs1ING6xFDXRN8gWFDmOLsP
         1ogx/H9A75jpnNvgXr/6IbB/v6yDvCyZ5x/vmrRztkv43opQZiNYDv9akf4oa/XZGHLF
         aEJ01PMXg1YPfdQs06wzXom7TXoTmlrFvlkQR5SiunH/66C/Ruwu+eTxjy0u4fhQattS
         d4DLVqYfFX1lexgIQpPjLN6Fdrh1FdnL3YqHz6pwRwUDPLl1uwH7zCu0xwQGCek/VgEp
         9iuWOoGI0teW1p45MTuKRcoq0Up3W5HWeaKjHPbrKGKAunNTE9vHv3FfQd4K6gWlptG8
         y/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWzb2Lum7+E5nvnpmszkZMSBAj/8qKjAqAVkBdUoKeXR3qpF/Ia71bhc259iT38O7K+NXnFgU2sQxCiqa+YgNCbb6cRLBdsYT1eLEisWK5ufP3cdFD+Go4IXV3TfZJgtu3fSBpOhBlJnALBTtplSJKP2jnLSG+bPvfEaIqhmQ/Gkt7E45DI
X-Gm-Message-State: AOJu0YwsPQFms3bW0rl9YMMJWfEf5IjlH7IgDL8Uk+WdGH5TfnGqVV5k
	e/RrMwaL2PGg5RAvUoLs1dWByfxUFUJ6k0H1vYF0QbrQ2nCj0ic7
X-Google-Smtp-Source: AGHT+IE61dZOwYV8byHLse52VH790boyFMhcggAcxjd9FQDnZMeJLlzKLA12J88m2hbL/cwb8WUOhw==
X-Received: by 2002:a05:6a00:1715:b0:705:9526:3c0d with SMTP id d2e1a72fcca58-706745bed3emr5452507b3a.12.1719235806683;
        Mon, 24 Jun 2024 06:30:06 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066c7fb9casm4123931b3a.94.2024.06.24.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:30:06 -0700 (PDT)
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
Subject: [PATCH v2] ASoC: dt-bindings: realtek,rt5659: Convert to dtschema
Date: Mon, 24 Jun 2024 18:59:44 +0530
Message-ID: <20240624132949.124228-1-animeshagarwal28@gmail.com>
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
Changes in v2:
  - Dropped redundant descriptions from reg, interrupts and clocks.
  - Added default to gpio properties.
  - Dropped sound-name-prefix: true
---
 .../bindings/sound/realtek,rt5659.yaml        | 129 ++++++++++++++++++
 .../devicetree/bindings/sound/rt5659.txt      |  89 ------------
 2 files changed, 129 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5659.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
new file mode 100644
index 000000000000..1100ffd9a7c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
@@ -0,0 +1,129 @@
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
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
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
+    default: 0
+
+  realtek,dmic2-data-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # dmic2 is not used
+      - 1 # using IN2P pin as dmic2 data pin
+      - 2 # using GPIO6 pin as dmic2 data pin
+      - 3 # using GPIO10 pin as dmic2 data pin
+      - 4 # using GPIO12 pin as dmic2 data pin
+    description: Specify which pin to be used as DMIC2 data pin.
+    default: 0
+
+  realtek,jd-src:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0 # No JD is used
+      - 1 # using JD3 as JD source
+      - 2 # JD source for Intel HDA header
+    description: Specify which JD source be used.
+    default: 0
+
+  realtek,ldo1-en-gpios:
+    maxItems: 1
+    description: CODEC's LDO1_EN pin.
+
+  realtek,reset-gpios:
+    maxItems: 1
+    description: CODEC's RESET pin.
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
+            realtek,ldo1-en-gpios = <&gpio 3 GPIO_ACTIVE_HIGH>;
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


