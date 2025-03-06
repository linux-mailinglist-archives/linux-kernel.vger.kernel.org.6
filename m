Return-Path: <linux-kernel+bounces-548712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE915A54883
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241DC18954EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD845209F4B;
	Thu,  6 Mar 2025 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9p++ycT"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF62040B3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258587; cv=none; b=uHk6wMycaGmFjqeyfQem4cGr/VhXhQwa0CnaptT6ARG/tybzLOcq/o4h0EK97cuRsoz1rvLIL7uCd25/nHHaDQalk6FG+f0Dh5Xoes1nPA3DjiV+EbgXwUYwtQdwQU6R/Cjvfnfl1Ssdj6okR9YCA/pongzE3i69T06WbxpD5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258587; c=relaxed/simple;
	bh=taxAsShf8N+C3lfR1sHXXuY7T3xlKIk7iNzMTefkC08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRsmypNk8bfADyY8v1YTWAqKbToqG0F0oHPG7DIu2yS0G2X6MRQ27jaYDvH/zRCWBcnE7tt1hCKheC7WSq0/cEez/FueG84+cxqnTAiFKD+/M1VvC/ec5WZd5wywif8NFCGKjeZaAmNyV0yLVKaOE+Iz0BrJacyHKvkTNXzRsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W9p++ycT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so196237f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741258583; x=1741863383; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x74ipVoGKHqkFU8ArF+lIxMw+tVehiDovnCNJ+OJIfg=;
        b=W9p++ycT5vte70V8u2X4FKOeIwlMEx8OEhqR+fjPPiXaRzjJDKz71W8EVXrF8JcpGM
         XiKhpWUMEs5SVFD+bCPE3YVMi1CAkJL/hrFs7dkCu8uL4WdRSyMuTZooz916twJjotId
         I/oCBxQ3G1pBFh0Kq04EEJacl4YZlAHMkp9siqP8mIT166w4ZMu3FTuS5wSHDnIyimFD
         GoFpUMX3Zm3eqkja+sUscu4m1ffKc5v6uyKQqvfIu4GPCLDFHrWRzUB3yCCaK7s6zQNx
         d0seI7Tjg0xqbfn873I+J5c3g9WXTzh71/OV5gz6Wkv0sZmiBYrX2sZ5Gdto4auLorWU
         gc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258583; x=1741863383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x74ipVoGKHqkFU8ArF+lIxMw+tVehiDovnCNJ+OJIfg=;
        b=pTCtoq9n3b/0rEl7vWb46D0AC+mcDQZ4Y6mArXFppCqtJVroJGL1lMhVk7TjjVq+To
         R+saGc6AvtB3Iu8vdflGh+PqXf71W4o3X1TdqK26sD/RoElH4Dt18Ki8qqzvQiLSq5Jg
         0rWFZC/+BKcmIXyDKwY/S1hI1fP+6JUWWGMxWCixIRC0E7BVFxoudknb89V0VnLFoAi5
         sQ7fycpr/U9KnP5V1TKKOX4hjJw0vlFsqtwQYQiANAtZbMBkJD9/sj+w7hlZm2vKU91D
         06sgFdLstwbz578riYFaSwmM8xV7sLI7atLKg83KzPRd3W7de55b1ia1s5wAOK4mJqUw
         s0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxtP64LSiS92iTSYZEcVxPSK6veK5CJ5OTDS7gh25THnzVJUZAXBCCrZAst2/bE27/rDi0RvAHh1jL6Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCCyFUqwVpNUDXYm+DuqU9rjor+pQ8QK1BSQfTITV6at+wYOh
	Sr8AymxZI9RUWWJjGOjYx8/MFM+5k22yQavg0FuolJ6FmMRe7Y8VH7wV6055sTU=
X-Gm-Gg: ASbGncs/XzXbv5Ou7px1SZ7+zKWjWmUOlEF/ntbT5YvXIAekzuejb1mHnEYiskWUHvz
	EhcXBj1cs9wNNAcTG8oGAc9/FeQnrCbHE5Zr/kVG/q+Vd0+3Mm2ztttcl7RMAIxa9IZb/eTl4QY
	sHpFGRqhqiEVEZKLpd7LMF8OLZ1NXT1gu4uVUGGFkPkP+VNFGy7k2ygwgMyA0jwRnR1JEIycuBN
	1d1HgR1YkMW0v78zc/yj1V3YbdIZSgUBSpVPlJvXwUnIm3kHHDkIKh8AGJpv2J0OtiNto267F6N
	pk2AtCgFd2/GSbrfhH3GY2zlYBq5z1+J7twxar4omuldgvih3Yy4fP0fDWCVmHPQJA==
X-Google-Smtp-Source: AGHT+IFn5gzHhm22oQS3cvWYyKeYsOtf1P20ftX6VS0oYrqVE2MlbWY/kXumacxy8rSc7+7QNpU2Tg==
X-Received: by 2002:a5d:64cb:0:b0:390:df75:ddc4 with SMTP id ffacd0b85a97d-3911f7cba2amr6699862f8f.44.1741258583569;
        Thu, 06 Mar 2025 02:56:23 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd831719sm17406675e9.0.2025.03.06.02.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:56:23 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Mar 2025 11:56:19 +0100
Subject: [PATCH v4 1/2] dt-bindings: input: convert dlg,da7280.txt to
 dt-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-misc-da7280-convert-v4-1-2972c4e81cb5@linaro.org>
References: <20250306-topic-misc-da7280-convert-v4-0-2972c4e81cb5@linaro.org>
In-Reply-To: <20250306-topic-misc-da7280-convert-v4-0-2972c4e81cb5@linaro.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roy Im <roy.im.opensource@diasemi.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12991;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=taxAsShf8N+C3lfR1sHXXuY7T3xlKIk7iNzMTefkC08=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnyX9VNHZTeg8mAo9KMrLG2jSRhPqAE8q3IjLOkQ0/
 aMfGydqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ8l/VQAKCRB33NvayMhJ0TilD/
 9MDV6dZvo6xB25iptfesGERCgzLSTV950XplKMpuR21wYGjnJl0iMJkdUlyfqdkGRynGtUyeS4rWm2
 v+nskVhl/zS4qN46XmvUXUIqYZeSLd00g9NbY4PKoynVtZm8YSVNAJ9U3CQL64Mkp+DVrNBBZ/EcJ9
 opXl9HeNf+zSGBW3WM22FTQlnQHIlY7wfAhG9M8+kEkkzcOY7OeilYYYVk/zLfN32Ef0SYzxfKIB6r
 nkPjqldyJKtzjc5inPFtid67NO9NOYf2S2F3J7xpa0+ROEeqiP3tnLR5XaX0/V0++OaW60qr759kFt
 TH6de8lSF2fKKTzhzyrG9JZTRCgoR3DuFZesXruZmGLX7H2LBGASGHCLiw7LJlw53C1xVIOZI2ERnv
 BLAgCyrzIJImbUZVTM8BdtmqilrEhMzTqrdJJVc++Pe4c4+gAMaavCAqlb/atvfKiYayfWFvhMTK02
 Bkt2s1erOuOo8L9jKiO1KDOdUDmJ/euKu029+mqIk2+c1+E61dpe932jN3H6Yjzm3s67wZsnFRqR3K
 ZydhUOBz841AnnI5Dg1RsziqU2rpBOz6WFNQW1XIkWhoq0ZetjKhOsKKUG4FJEdgjOEjqyHWOi+upF
 OS1Yd2AOrSJXIfjz8bXoxmjg+4+DzknzOH25y0frDvxkXCZGaRoqg9di8iiA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the Dialog Semiconductor DA7280 Low Power High-Definition
Haptic Driver bindings to dt-schema.

Due to the implementation and usage in DT the array must be
an uint32 array.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/input/dlg,da7280.txt       | 108 ---------
 .../devicetree/bindings/input/dlg,da7280.yaml      | 248 +++++++++++++++++++++
 2 files changed, 248 insertions(+), 108 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/dlg,da7280.txt b/Documentation/devicetree/bindings/input/dlg,da7280.txt
deleted file mode 100644
index 96ee5d50e111b85ce680eadd0276280e706bb4cf..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/input/dlg,da7280.txt
+++ /dev/null
@@ -1,108 +0,0 @@
-Dialog Semiconductor DA7280 Haptics bindings
-
-Required properties:
-- compatible: Should be "dlg,da7280".
-- reg: Specifies the I2C slave address.
-
-- interrupt-parent : Specifies the phandle of the interrupt controller to
-  which the IRQs from DA7280 are delivered to.
-
-- dlg,actuator-type: Set Actuator type. it should be one of:
-  "LRA" - Linear Resonance Actuator type.
-  "ERM-bar" - Bar type Eccentric Rotating Mass.
-  "ERM-coin" - Coin type Eccentric Rotating Mass.
-
-- dlg,const-op-mode: Haptic operation mode for FF_CONSTANT.
-  Possible values:
-	1 - Direct register override(DRO) mode triggered by i2c(default),
-	2 - PWM data source mode controlled by PWM duty,
-- dlg,periodic-op-mode: Haptic operation mode for FF_PERIODIC.
-  Possible values:
-	1 - Register triggered waveform memory(RTWM) mode, the pattern
-	    assigned to the PS_SEQ_ID played as much times as PS_SEQ_LOOP,
-	2 - Edge triggered waveform memory(ETWM) mode, external GPI(N)
-	    control are required to enable/disable and it needs to keep
-	    device enabled by sending magnitude (X > 0),
-	    the pattern is assigned to the GPI(N)_SEQUENCE_ID below.
-	The default value is 1 for both of the operation modes.
-	For more details, please see the datasheet.
-
-- dlg,nom-microvolt: Nominal actuator voltage rating.
-  Valid values: 0 - 6000000.
-- dlg,abs-max-microvolt: Absolute actuator maximum voltage rating.
-  Valid values: 0 - 6000000.
-- dlg,imax-microamp: Actuator max current rating.
-  Valid values: 0 - 252000.
-  Default: 130000.
-- dlg,impd-micro-ohms: the impedance of the actuator in micro ohms.
-  Valid values: 0 - 1500000000.
-
-Optional properties:
-- pwms : phandle to the physical PWM(Pulse Width Modulation) device.
-  PWM properties should be named "pwms". And number of cell is different
-  for each pwm device.
-  (See Documentation/devicetree/bindings/pwm/pwm.txt
-   for further information relating to pwm properties)
-
-- dlg,ps-seq-id: the PS_SEQ_ID(pattern ID in waveform memory inside chip)
-  to play back when RTWM-MODE is enabled.
-  Valid range: 0 - 15.
-- dlg,ps-seq-loop: the PS_SEQ_LOOP, Number of times the pre-stored sequence
-  pointed to by PS_SEQ_ID or GPI(N)_SEQUENCE_ID is repeated.
-  Valid range: 0 - 15.
-- dlg,gpiN-seq-id: the GPI(N)_SEQUENCE_ID, pattern to play
-  when gpi0 is triggered, 'N' must be 0 - 2.
-  Valid range: 0 - 15.
-- dlg,gpiN-mode: the pattern mode which can select either
-  "Single-pattern" or "Multi-pattern", 'N' must be 0 - 2.
-- dlg,gpiN-polarity: gpiN polarity which can be chosen among
-  "Rising-edge", "Falling-edge" and "Both-edge",
-  'N' must be 0 - 2
-  Haptic will work by this edge option in case of ETWM mode.
-
-- dlg,resonant-freq-hz: use in case of LRA.
-  the frequency range: 50 - 300.
-  Default: 205.
-
-- dlg,bemf-sens-enable: Enable for internal loop computations.
-- dlg,freq-track-enable: Enable for resonant frequency tracking.
-- dlg,acc-enable: Enable for active acceleration.
-- dlg,rapid-stop-enable: Enable for rapid stop.
-- dlg,amp-pid-enable: Enable for the amplitude PID.
-- dlg,mem-array: Customized waveform memory(patterns) data downloaded to
-  the device during initialization. This is an array of 100 values(u8).
-
-For further information, see device datasheet.
-
-======
-
-Example:
-
-	haptics: da7280-haptics@4a {
-		compatible = "dlg,da7280";
-		reg = <0x4a>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-		dlg,actuator-type = "LRA";
-		dlg,dlg,const-op-mode = <1>;
-		dlg,dlg,periodic-op-mode = <1>;
-		dlg,nom-microvolt = <2000000>;
-		dlg,abs-max-microvolt = <2000000>;
-		dlg,imax-microamp = <170000>;
-		dlg,resonant-freq-hz = <180>;
-		dlg,impd-micro-ohms = <10500000>;
-		dlg,freq-track-enable;
-		dlg,rapid-stop-enable;
-		dlg,mem-array = <
-		  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
-		  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
-		  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
-		  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
-		  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
-		  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
-		  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
-		  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
-		  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
-		  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
-		>;
-	};
diff --git a/Documentation/devicetree/bindings/input/dlg,da7280.yaml b/Documentation/devicetree/bindings/input/dlg,da7280.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..0d06755aaaa8177eaa8b2951c4c387ef2ce53d43
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/dlg,da7280.yaml
@@ -0,0 +1,248 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/dlg,da7280.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor DA7280 Low Power High-Definition Haptic Driver
+
+maintainers:
+  - Roy Im <roy.im.opensource@diasemi.com>
+
+properties:
+  compatible:
+    const: dlg,da7280
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
+
+  interrupts:
+    maxItems: 1
+
+  dlg,actuator-type:
+    enum:
+      - LRA # Linear Resonance Actuator type
+      - ERM-bar # Bar type Eccentric Rotating Mass
+      - ERM-coin # Coin type Eccentric Rotating Mass
+
+  dlg,const-op-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 1 # Direct register override (DRO) mode triggered by i2c (default)
+      - 2 # PWM data source mode controlled by PWM duty
+    description:
+      Haptic operation mode for FF_CONSTANT
+
+  dlg,periodic-op-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 1 # Register triggered waveform memory(RTWM) mode, the pattern
+          # assigned to the PS_SEQ_ID played as much times as PS_SEQ_LOOP
+      - 2 # Edge triggered waveform memory(ETWM) mode, external GPI(N)
+          # control are required to enable/disable and it needs to keep
+          # device enabled by sending magnitude (X > 0),
+          # the pattern is assigned to the GPI(N)_SEQUENCE_ID below
+    default: 1
+    description:
+      Haptic operation mode for FF_PERIODIC.
+      The default value is 1 for both of the operation modes.
+      For more details, please see the datasheet
+
+  dlg,nom-microvolt:
+    minimum: 0
+    maximum: 6000000
+    description:
+      Nominal actuator voltage rating
+
+  dlg,abs-max-microvolt:
+    minimum: 0
+    maximum: 6000000
+    description:
+      Absolute actuator maximum voltage rating
+
+  dlg,imax-microamp:
+    minimum: 0
+    maximum: 252000
+    default: 130000
+    description:
+      Actuator max current rating
+
+  dlg,impd-micro-ohms:
+    minimum: 0
+    maximum: 1500000000
+    description:
+      Impedance of the actuator
+
+  pwms:
+    maxItems: 1
+
+  dlg,ps-seq-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    description:
+      The PS_SEQ_ID(pattern ID in waveform memory inside chip)
+      to play back when RTWM-MODE is enabled
+
+  dlg,ps-seq-loop:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    description:
+      The PS_SEQ_LOOP, Number of times the pre-stored sequence pointed to by
+      PS_SEQ_ID or GPI(N)_SEQUENCE_ID is repeated
+
+  dlg,gpi0-seq-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    description:
+      the GPI0_SEQUENCE_ID, pattern to play when gpi0 is triggered
+
+  dlg,gpi1-seq-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    description:
+      the GPI1_SEQUENCE_ID, pattern to play when gpi1 is triggered
+
+  dlg,gpi2-seq-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    description:
+      the GPI2_SEQUENCE_ID, pattern to play when gpi2 is triggered
+
+  dlg,gpi0-mode:
+    enum:
+      - Single-pattern
+      - Multi-pattern
+    description:
+      Pattern mode for gpi0
+
+  dlg,gpi1-mode:
+    enum:
+      - Single-pattern
+      - Multi-pattern
+    description:
+      Pattern mode for gpi1
+
+  dlg,gpi2-mode:
+    enum:
+      - Single-pattern
+      - Multi-pattern
+    description:
+      Pattern mode for gpi2
+
+  dlg,gpi0-polarity:
+    enum:
+      - Rising-edge
+      - Falling-edge
+      - Both-edge
+    description:
+      gpi0 polarity, Haptic will work by this edge option in case of ETWM mode
+
+  dlg,gpi1-polarity:
+    enum:
+      - Rising-edge
+      - Falling-edge
+      - Both-edge
+    description:
+      gpi1 polarity, Haptic will work by this edge option in case of ETWM mode
+
+  dlg,gpi2-polarity:
+    enum:
+      - Rising-edge
+      - Falling-edge
+      - Both-edge
+    description:
+      gpi2 polarity, Haptic will work by this edge option in case of ETWM mode
+
+  dlg,resonant-freq-hz:
+    minimum: 50
+    maximum: 300
+    default: 205
+
+  dlg,bemf-sens-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable for internal loop computations
+
+  dlg,freq-track-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable for resonant frequency tracking
+
+  dlg,acc-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable for active acceleration
+
+  dlg,rapid-stop-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable for rapid stop
+
+  dlg,amp-pid-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable for the amplitude PID
+
+  dlg,mem-array:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 100
+    description:
+      Customized waveform memory (patterns) data downloaded to the device during initialization.
+      Each entry value must be included between 0 and 255.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dlg,actuator-type
+  - dlg,const-op-mode
+  - dlg,periodic-op-mode
+  - dlg,nom-microvolt
+  - dlg,abs-max-microvolt
+  - dlg,imax-microamp
+  - dlg,impd-micro-ohms
+
+additionalProperties: false
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
+        haptics@4a {
+            compatible = "dlg,da7280";
+            reg = <0x4a>;
+            interrupt-parent = <&gpio6>;
+            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+            dlg,actuator-type = "LRA";
+            dlg,const-op-mode = <1>;
+            dlg,periodic-op-mode = <1>;
+            dlg,nom-microvolt = <2000000>;
+            dlg,abs-max-microvolt = <2000000>;
+            dlg,imax-microamp = <170000>;
+            dlg,resonant-freq-hz = <180>;
+            dlg,impd-micro-ohms = <10500000>;
+            dlg,freq-track-enable;
+            dlg,rapid-stop-enable;
+            dlg,mem-array = <0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+                             0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+                             0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+                             0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+                             0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+                             0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+                             0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+                             0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+                             0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+                             0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00>;
+        };
+    };

-- 
2.34.1


