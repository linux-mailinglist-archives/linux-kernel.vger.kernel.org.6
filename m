Return-Path: <linux-kernel+bounces-246277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988D92BFDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BA31F214C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5251ABCBF;
	Tue,  9 Jul 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCcHm8LD"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99F1ABC4A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542055; cv=none; b=G3YFnBdHMmzYg9CG5EoKyeIO20eXl7lDMYiwXC2BkMluq8BHPxwtNlL5nT4rKI0PSRrkNjSVS7o3WG0U2/mObdRjjY2sc6M4t1fb9bn6kY69AYdoGCBE1nyINAJ3zrH9voi5n/voKynL4Byx+d2qaB+9Mzsi+cv2wP9v8TErgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542055; c=relaxed/simple;
	bh=15/G0KHqA0dKur8q9uAiEUuJzQ4VCnWfgrKNlUgEpsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsnInSEbdTV7Nr+2QGJBTqqY8UyURIO9I3vw0BBJphFGPm2qTPx00CbxshlJvcpKGxAXzNUb9RNzt3mgbFl8i0+flEPVVMv0dffnfR6GDw6sYTz618cSsU2SCUGlkfhjrI0u3FLalL2c8Gj2IeFWFWUEOMUQX4AfW8bVpmDirGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SCcHm8LD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36798779d75so4703853f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720542052; x=1721146852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMw3Csc91xG1Dn/+t3HCdPJHIoD7h/vcI/ofAzBjPNA=;
        b=SCcHm8LDHvWkys6gqbLWNlSFyT19UrsfdvzG3hW2mlYtufwbdsFj815jQgPHajFJ0u
         +PjxPPH/+a4Mwd7FIx08BunxzkwqBLgri4Xm/s/EBJNU7O1u83h1Ky7Cg48gwBol3rEK
         1u0ixegOf9kEX1oP9mp0LzAhjYScpOn11/pwzB41SD7vT/J6FPSYm/4FRgzA0+e4fhzR
         vO2eCwmiWkt4MiYaxf2CzSjts0KS2ymL+HFZxbqD3VsRitX2AkdzX+dP+zz6HXxAcpFp
         Lbd2rRsNrARNqeOFONJJCJuiN+/+0i3EZuTMa/59i9XWuIQrO8fivXzYiCuL5HyLJRzc
         pDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542052; x=1721146852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMw3Csc91xG1Dn/+t3HCdPJHIoD7h/vcI/ofAzBjPNA=;
        b=jOPIBzM7DWTUuvRLuS917qZg4BkqWEN9O2/JzC/IR2lddWItOgAYZRPMarnlJJKmJ7
         naViHkWqNrBHynoowO0O8klJH7K3e3xG1GTIkEDyMRIKx7wTbmugdxgT8bKkIO3l1fqv
         wFmXTLosLGefb9+bXmptFTt1R81VeSMITbYRn7s4EZ4xfxGeDJSSkJrGC8YmrKfCinev
         yDw+PdEnvvWaIqQNZHBxEGJrZ4IA6O3tnOO130L1w2aPf7omvXfVCN98gL2CCDrsVMzI
         uf2ZKMhendJafeEkLN2la0uAVvx1uKenCe/b+kIqlcXhV5yOs6Mt4IZ2chalyvQxfK/Z
         c9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXfv9Fya3Da1JZ1DFyJKep6zqvUxRSx+njl3B7EV+1S6QQ+Ob/qV5T9KhE6wmwx8l3zDtzkYo5cm80gylesBoY8tSCGSp0QemXauDLi
X-Gm-Message-State: AOJu0YyPZE521E2ZtDw/4hdpr9Xu4TL9R6Zrblgo2YWU0rk7j7wsOkpZ
	gPUX91SQL1XXeHnXY+oZoCRD9ovg4TbsWFSVCGYVqBRR25/RLJMIHyaRvNop3jE=
X-Google-Smtp-Source: AGHT+IFe6PkqhiCDDJSXx6ob8a+E7JGUWgUrvxr1A9IgPNb3EmRBtZ3lIkQmLc8Rpz+Jj7CtmBiJDw==
X-Received: by 2002:a5d:64c4:0:b0:366:efbd:8aa3 with SMTP id ffacd0b85a97d-367cea46767mr3526398f8f.2.1720542051822;
        Tue, 09 Jul 2024 09:20:51 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e07fsm2966955f8f.17.2024.07.09.09.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:20:51 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 3/4] dt-bindings: pinctrl: qcom,ipq4019-pinctrl: convert to dtschema
Date: Tue,  9 Jul 2024 17:17:55 +0100
Message-ID: <20240709162009.5166-4-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709162009.5166-1-rayyan.ansari@linaro.org>
References: <20240709162009.5166-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Qualcomm IPQ4019 TLMM block bindings from text to yaml dt
schema format.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 .../bindings/pinctrl/qcom,ipq4019-pinctrl.txt |  85 ---------------
 .../pinctrl/qcom,ipq4019-pinctrl.yaml         | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 85 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt
deleted file mode 100644
index 97858a7c07a2..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt
+++ /dev/null
@@ -1,85 +0,0 @@
-Qualcomm Atheros IPQ4019 TLMM block
-
-This is the Top Level Mode Multiplexor block found on the Qualcomm IPQ8019
-platform, it provides pinctrl, pinmux, pinconf, and gpiolib facilities.
-
-Required properties:
-- compatible: "qcom,ipq4019-pinctrl"
-- reg: Should be the base address and length of the TLMM block.
-- interrupts: Should be the parent IRQ of the TLMM block.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: Should be two.
-- gpio-controller: Marks the device node as a GPIO controller.
-- #gpio-cells : Should be two.
-                The first cell is the gpio pin number and the
-                second cell is used for optional parameters.
-- gpio-ranges: see ../gpio/gpio.txt
-
-Optional properties:
-
-- gpio-reserved-ranges: see ../gpio/gpio.txt
-
-Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
-a general description of GPIO and interrupt bindings.
-
-Please refer to pinctrl-bindings.txt in this directory for details of the
-common pinctrl bindings used by client devices, including the meaning of the
-phrase "pin configuration node".
-
-The pin configuration nodes act as a container for an arbitrary number of
-subnodes. Each of these subnodes represents some desired configuration for a
-pin, a group, or a list of pins or groups. This configuration can include the
-mux function to select on those pin(s)/group(s), and various pin configuration
-parameters, such as pull-up, drive strength, etc.
-
-The name of each subnode is not important; all subnodes should be enumerated
-and processed purely based on their content.
-
-Each subnode only affects those parameters that are explicitly listed. In
-other words, a subnode that lists a mux function but no pin configuration
-parameters implies no information about any pin configuration parameters.
-Similarly, a pin subnode that describes a pullup parameter implies no
-information about e.g. the mux function.
-
-
-The following generic properties as defined in pinctrl-bindings.txt are valid
-to specify in a pin configuration subnode:
- pins, function, bias-disable, bias-pull-down, bias-pull-up, drive-open-drain,
- drive-strength.
-
-Non-empty subnodes must specify the 'pins' property.
-Note that not all properties are valid for all pins.
-
-
-Valid values for qcom,pins are:
-  gpio0-gpio99
-    Supports mux, bias and drive-strength
-
-Valid values for qcom,function are:
-aud_pin, audio_pwm, blsp_i2c0, blsp_i2c1, blsp_spi0, blsp_spi1, blsp_uart0,
-blsp_uart1, chip_rst, gpio, i2s_rx, i2s_spdif_in, i2s_spdif_out, i2s_td, i2s_tx,
-jtag, led0, led1, led2, led3, led4, led5, led6, led7, led8, led9, led10, led11,
-mdc, mdio, pcie, pmu, prng_rosc, qpic, rgmii, rmii, sdio, smart0, smart1,
-smart2, smart3, tm, wifi0, wifi1
-
-Example:
-
-	tlmm: pinctrl@1000000 {
-		compatible = "qcom,ipq4019-pinctrl";
-		reg = <0x1000000 0x300000>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-ranges = <&tlmm 0 0 100>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <0 208 0>;
-
-		serial_pins: serial_pinmux {
-			mux {
-				pins = "gpio60", "gpio61";
-				function = "blsp_uart0";
-				bias-disable;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.yaml
new file mode 100644
index 000000000000..ebf74e48ec5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,ipq4019-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. IPQ4019 TLMM block
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  Top Level Mode Multiplexer pin controller in Qualcomm IPQ4019 SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,ipq4019-pinctrl
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-reserved-ranges: true
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-ipq4019-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-ipq4019-tlmm-state"
+        additionalProperties: false
+
+  "-hog(-[0-9]+)?$":
+    required:
+      - gpio-hog
+
+$defs:
+  qcom-ipq4019-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: "^gpio([0-9]|[1-9][0-9])$"
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ aud_pin, audio_pwm, blsp_i2c0, blsp_i2c1, blsp_spi0,
+                blsp_spi1, blsp_uart0, blsp_uart1, chip_rst, gpio,
+                i2s_rx, i2s_spdif_in, i2s_spdif_out, i2s_td, i2s_tx,
+                jtag, led0, led1, led2, led3, led4, led5, led6, led7,
+                led8, led9, led10, led11, mdc, mdio, pcie, pmu,
+                prng_rosc, qpic, rgmii, rmii, sdio, smart0, smart1,
+                smart2, smart3, tm, wifi0, wifi1 ]
+
+    required:
+      - pins
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,ipq4019-pinctrl";
+        reg = <0x01000000 0x300000>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 100>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+        uart-state {
+            pins = "gpio16", "gpio17";
+            function = "blsp_uart0";
+            bias-disable;
+        };
+    };
-- 
2.45.2


