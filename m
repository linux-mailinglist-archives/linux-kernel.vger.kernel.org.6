Return-Path: <linux-kernel+bounces-516744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB831A37677
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A611887FD3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5CC19DF4D;
	Sun, 16 Feb 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiGjR5aU"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408C1494DF;
	Sun, 16 Feb 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739729377; cv=none; b=WwQp6jqMy8tw6Sf97DyNG6jib9xlfWp2uo+QKMKo/vQfnxCtZYK+dpkc7zaDLE/u58K9T04z73D7fXB3zPsDZ7YhsMkfe350zUd+5mdAxQTVb8fQ79TJfJKShtlu3Uz7utTAZpCjUQPIo8ZVtpzcZRyQVe6Vkh4R0NoWgY+EzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739729377; c=relaxed/simple;
	bh=Z/E2jVKQjg00whzxYSWZzggCCsussqYqWWHWhmFLPg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kl2ZAIqmgHXtxGfKxI8tUHFZs+VqNKm/4HB2TIbuMcVUjyHo/PfF2RfTJIkv6ItQGVZRGSIYYQ8kW3QLDfMj40pbO/MC56S/vxWBHbG3+VjorKudHm4FnHtmq5YdlEi5NUdbFgsb4LpqfUBstjelSJo3wwZi8nsaXbe223REXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiGjR5aU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb81285d33so180277166b.0;
        Sun, 16 Feb 2025 10:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739729374; x=1740334174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDKGgAw/XBDG/QV4A9vk0jo2V9VB2oQWQFTgbJUtcfc=;
        b=BiGjR5aUwBFUIyLNr1lEdxDyMbknDcpq5deljv6nCptWjVXDi8upPkOt2h8kMezbbd
         eQYrjy0Aez7nBkHMugkxMQN3ZS8W8zl/CfHG551lc/L7fR0lqv7siPxWDkD6VSBeXG8Z
         5WIikMbfrf/4kCBczVkbyS77q0WLrZI6FX6f/bH+GK8+Tf+P3q4aBuiNvZncM0Omk8Be
         rn7+SbOtihzFiukgb7aFoqRbgdu5JrbD25sN1uB3p7ILU2Q5reebFV7pyLO7PAHQqDXr
         zGhvBKoU4ezDdkiSj8w3J9/avAJZbYiHLWv5m4Za9VJpXZn3CPr0wws7Ah2STxKZq5b9
         bWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739729374; x=1740334174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDKGgAw/XBDG/QV4A9vk0jo2V9VB2oQWQFTgbJUtcfc=;
        b=ZoFpVG1joL3CM9Slom5wgcCUhKjLMRMfx4akJaoEJY7OvBXoQTaNVTKvVFnzpxkbSu
         eC5MerV8CVqaL3jbyvbvg5ThkHXGD9A2Djj9JPbDvfjjXbqbcR0XY1q0PQoUgZcNLthM
         9YnWPFfBa8c6frErE4a12c/X7FeaxgrskXPuFLaWrFdTts6u8Pb5R1NJtTZMJak7+yb8
         FYjEy48Pgr3xSd0bYDEFiRygvRL20EqjVZ61btjwEMkewp8oDH3ftnvkXfTe1EeaD+OP
         RAsY7mVsWOILQL2eNNGTGBLMPtbIi+iKXYpAuX8+s75voEPREMlv7AccBCTaSxU4F7CM
         /SLA==
X-Forwarded-Encrypted: i=1; AJvYcCXgdIo49S73kj2kfdgwcWh4utVqa5VSK06bUCIOeSN/qjr6wdRyrOWuHMzDhMnOsu3rleIuZAn0CbjCq4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjaTQQ1NyeV0+cZkWDQT5ioVKZ+Z4OdcukO/9jh7tRGqfvSAu
	+v2o993xKekBFzK9oE8Ny2ketsoaIjAU7LEjyyuTKmuPW5KpzSAAsOPhZg==
X-Gm-Gg: ASbGncs+69m3oNbHuQsgmNUITPlNArn7qqO5NeKyGiM3Qfh9lM8wlNkF6H+DoicM0nB
	3X8wCC1R0X4MSNU8eBYQ6UEyB9zcjW/GrcOcFOFoBQEhlbvRC293GwVH6ORjRq7gA19vEDR7XM1
	pfrBd7OO1fIXFUuEWU1Dbcva1ZpBKER2dIb3Hr/PhXlNX7P+lJtx1q4G/zJJP/B+lJU2SmhqUD1
	R/50J7kZEMSKfUEwoulx4d2xyiLB4ayEY2ok1GU+CUbU6WUJc2ALGlqNZqK9NORPOzdcY69SWYZ
	lIdQ+SFLqOTegMplRb6XGUU/piLh
X-Google-Smtp-Source: AGHT+IFkY4om+Y9dsuLLfHc/ExMOv5QyNvMmLcNt7jetS7qFMsh3KyfXK15v7y8UdkMryMOIKaHqmg==
X-Received: by 2002:a17:907:9494:b0:ab7:ec84:10af with SMTP id a640c23a62f3a-abb70b1d813mr737311566b.16.1739729373356;
        Sun, 16 Feb 2025 10:09:33 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm164712666b.161.2025.02.16.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 10:09:32 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: devicetree@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC] dt-bindings: rtc: sophgo: add RTC support for Sophgo CV1800 series SoC
Date: Sun, 16 Feb 2025 19:09:09 +0100
Message-ID: <20250216180924.2506416-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RTCSYS devicetree binding for Sophgo CV1800 SoC.

The RTC (Real Time Clock) is an independently powered module in the chip.
It contains a 32KHz oscillator and a Power-On-Reset (POR) sub-module, which
can be used for time display and scheduled alarm produce. In addition, the
hardware state machine provides triggering and timing control for chip
power-on, power-off and reset.

Furthermore, the 8051 subsystem is located within RTCSYS and is
independently powered. System software can use the 8051 to manage wake
conditions and wake the system while the system is asleep, and communicate
with external devices through peripheral controllers.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
QUESTION:

I'm unsure about reg properties in the subnodes (child devices) of
RTCSYS:
- they will not be used anyway by the drivers because they genuinely
overlap (the whole point of going MFD) -- therefore the drivers will do
syscon_node_to_regmap(pdev->dev.parent->of_node)
- as I understood from the history of MFD dt bindings' submissions, regs
are encouraged, if can be specified
- overlapping regs cause dt_binding_check warnings:
Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/pmu@0)
Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/rtc@0)

Shall I remove the MMIO resources from the actual devices or rather ignore the warnings?

 .../bindings/mfd/sophgo,cv1800b-rtcsys.yaml   | 222 ++++++++++++++++++
 1 file changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml b/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
new file mode 100644
index 000000000000..2dc7c2df15c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sophgo,cv1800b-rtcsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cvitek CV18xx/Sophgo SG200x Real Time Clock module
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - sophgo@lists.linux.dev
+
+description:
+  The RTC (Real Time Clock) is an independently powered module in the chip. It
+  contains a 32KHz oscillator and a Power-On-Reset (POR) sub-module, which can
+  be used for time display and scheduled alarm produce. In addition, the
+  hardware state machine provides triggering and timing control for chip
+  power-on, power-off and reset.
+
+  Furthermore, the 8051 subsystem is located within RTCSYS and is independently
+  powered. System software can use the 8051 to manage wake conditions and wake
+  the system while the system is asleep, and communicate with external devices
+  through peripheral controllers.
+
+  Technical Reference Manual available at
+    https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sophgo,cv1800b-rtcsys
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^mcu@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    description:
+      The 8051 subsystem is located within RTCSYS and is independently powered.
+      System software can use the 8051 to manage wake conditions and wake the
+      system while the system is asleep, and communicate with external devices
+      through peripheral controllers.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - sophgo,cv1800b-rtc-dw8051
+
+      reg:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      resets:
+        maxItems: 1
+
+      sram:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        maxItems: 1
+        description: The SRAM controller to host the code/data
+
+    required:
+      - compatible
+      - clocks
+
+  "^pmu@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    description:
+      Power-On-Reset (POR) sub-module, hardware state machine providing
+      triggering and timing control for chip power-on, power-off and reset.
+      Supports battery low voltage detection and interrupt generation, as
+      well as button-triggered wake up from sleep.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - sophgo,cv1800b-rtc-pmu
+
+      reg:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      interrupts:
+        items:
+          - description: long button press interrupt
+          - description: vbat detection interrupt
+
+      interrupt-names:
+        items:
+          - const: longpress
+          - const: vbat
+
+    required:
+      - compatible
+
+  "^rtc@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    description:
+      The RTC (Real Time Clock) is an independently powered module in the chip.
+      Its calibration module uses a 25MHz crystal oscillator clock to calibrate
+      32KHz oscillator.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - sophgo,cv1800b-rtc
+
+      reg:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      interrupts:
+        items:
+          - description: alarm interrupt
+
+      interrupt-names:
+        items:
+          - const: alarm
+
+    required:
+      - compatible
+      - clocks
+      - interrupts
+
+  "^sram@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+
+    description:
+      Provide 2KB of SRAM, which can host software code or temporary data.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - sophgo,cv1800b-rtc-sram
+
+      reg:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    #include <dt-bindings/clock/sophgo,cv1800.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtcsys@5025000 {
+        compatible = "sophgo,cv1800b-rtcsys", "simple-mfd", "syscon";
+        reg = <0x5025000 0x2000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0 0x5025000 0x2000>;
+
+        mcu@0 {
+            compatible = "sophgo,cv1800b-rtc-dw8051";
+            reg = <0x0 0x1000>;
+            clocks = <&clk CLK_SRC_RTC_SYS_0>;
+            sram = <&rtc_sram>;
+        };
+
+        pmu@0 {
+            compatible = "sophgo,cv1800b-rtc-pmu";
+            reg = <0x0 0x2000>;
+            interrupts = <18 IRQ_TYPE_LEVEL_HIGH>,
+                         <19 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "longpress", "vbat";
+        };
+
+        rtc@0 {
+            compatible = "sophgo,cv1800b-rtc";
+            reg = <0 0x2000>;
+            interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "alarm";
+            clocks = <&clk CLK_RTC_25M>;
+        };
+
+        rtc_sram: sram@0 {
+            compatible = "sophgo,cv1800b-rtc-sram";
+            reg = <0x0 0x1000>;
+        };
+    };
-- 
2.48.1


