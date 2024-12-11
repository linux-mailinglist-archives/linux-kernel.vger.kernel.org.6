Return-Path: <linux-kernel+bounces-440942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6A9EC6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BB92830B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19EC1D88B1;
	Wed, 11 Dec 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcArtnfH"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D111C1ADB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904943; cv=none; b=OATRjRRyzgsZT0kZToIA/2iXOY/xOctYGCEfgLg+2nxroyoIqIbf1D6wLCALMbkDUcJHaWy8+MJJVrhCsKKD/at7AGnXJJ2DvTCGMNB1qJhxKx1fIx0oTguxo6SDC59Ih7IF3S2umYg7JtRxlfaQEkX9yeAcPjbVsKmzEUUkH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904943; c=relaxed/simple;
	bh=taxAsShf8N+C3lfR1sHXXuY7T3xlKIk7iNzMTefkC08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNYXP72Jo074RJs42d7dzl2UTYS28+UnHG8O7YAWTPm/j9BuvT63otA103sKcrTradOFAJVRqbCLC69cdcVPOZ4s0cQsjAvX0MSOMZ+mOjUs4xnxHIrf+e62DZLuh3NtCT70/1qF1proX71vvTwxy4EG7eZyUG2URNsqPeMhL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WcArtnfH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso8082705e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904940; x=1734509740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x74ipVoGKHqkFU8ArF+lIxMw+tVehiDovnCNJ+OJIfg=;
        b=WcArtnfHNJ7p/xmzYisef5BrSCFcKCJHKzsUmdn6iwqFsFrn+t9v1C5JUeZtsiTQzq
         xqhasM5dw7ut3JdIgopy2ShDWfOSnz+o+cJbBvog8+A7qBpk+kMh1I6OCLnqq0v2lv/7
         VgSUIIUnM5tcz3B9CQ1craz/V9TXYc8qfxDlp+CylZO+EhXyHqRYuER+giWLLOF0JeOl
         3LwHIV8heElNZIirqjqajOX/dV1tKWqnTD5/v07xKKwURBBDjyMymQ4YhmH+MfQzVjXL
         zkXINoj5i2tWCGlQgfxqjOMS8tPCMOt86yMkq9L4jCGZ6/u8dVeSoln+2iBuK2AbVFP4
         B+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904940; x=1734509740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x74ipVoGKHqkFU8ArF+lIxMw+tVehiDovnCNJ+OJIfg=;
        b=VrqABOpb1q2qRtk71vTd2RYpWwbMinRtdrpg9c7iFYiFHQ11LPLYQgon9UCsChuoS0
         pRyi9dkPxy6ys0qjvtxI0g9a1ZaysOJZPBwXmaCr8tB/ubLIcHq2PNHVBBwM8iKFBAXc
         MVPIe1pyxElLUSprIdvUOL+kxFsMVkhYzBQjc10teVDHDnGKWln7kXL1gaL3TxRv9yqk
         3mjpQoM/xtp3IaHdj7dHAXJJIsLKlRZAV2nYNwPSC7yCRoubE/N65kTfI/4T7hUaWlhG
         P7pR2OVARhs/slJ42uyZpB16rsYllZEjzcS4QT8F2FlJPYuH7WGWprRPl5cCgxUaZ0c+
         e+xA==
X-Forwarded-Encrypted: i=1; AJvYcCXANs7UWSqzxG8LLCrwUBe3giesOheJrKCuf9frHWxZ+32XC6/mVYcZEW9cixqELs5+3l6yNlRa0iXDUTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6u9GF//I0x/ZOyU1j+uzWYjxB/HxyPD+PR/vhtOfOCk8sVFKz
	h5LuBjR5B1dVfbyC6JynX/fbUtCbbblZnJPD55x32lFN844hcEugFCqn6KuXMKMYBmixUP179H1
	hvx8=
X-Gm-Gg: ASbGnctp7pDUX9Iy/qMFAX7Gtij8sEB8sNRLNDfcA6GAmnYAiyyW14aCmcfYtlzK/Tl
	MbadShzzNz7ex4cSGU6HpwGbm7wqZrt8MSA4imqJ68/C0+prL0KkQfb/QELRb+zbo599gKrXWMc
	wiQRmumA4/dpwQ8yKYC/lMBOfxFZ7uO0FHJcQLQ7sBv6w/yK4zh4IpjEYnkQmpxWl5kOBlcYxMB
	G5viAeoeHyEiIEDG8tqsooxwQNgB/W8WVe4c2hJU+3NhA2TA8zvkQIBvznMxACiC5AAZhqz8lY=
X-Google-Smtp-Source: AGHT+IFfICaaAT9OZi5mdfc8vCv1Qs9rTTdAIcGrfVR/ykaViH+560HO0qPtjzHW99Z3Cai6WczaUA==
X-Received: by 2002:a05:600c:3b26:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-4361c375b94mr13249525e9.4.1733904939880;
        Wed, 11 Dec 2024 00:15:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361f6d878asm6231805e9.2.2024.12.11.00.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:15:39 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Dec 2024 09:15:36 +0100
Subject: [PATCH v3 1/2] dt-bindings: input: convert dlg,da7280.txt to
 dt-schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-topic-misc-da7280-convert-v3-1-4df87ac08881@linaro.org>
References: <20241211-topic-misc-da7280-convert-v3-0-4df87ac08881@linaro.org>
In-Reply-To: <20241211-topic-misc-da7280-convert-v3-0-4df87ac08881@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnWUopTkCzU2kh1OoUWZceNUo9KuqOOG5KEP9qqT+P
 0FL9rQeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1lKKQAKCRB33NvayMhJ0aY9D/
 0UOpi3gcSWRK4TpVu5gAhd/jqD5J0Z93327bhjADclWw0KsRu7ffZ10GQdw26fJBZ+HXEQnUQl3JP0
 xXA4tQXBJSeaZjlK6BxScIrOwC/qsiBsmTId7WMzoRbTmCTxz3qY/HY2PYuxvxSdShJzeztM5ql8ES
 kX5SdR6/1LWrkmcp0JNmOkAcCDwvWrLY2tNC+kR9EIgdbzPLix6+MTDbJLOPBCcsxti0UDeZa685Ht
 xucI5nFAI6FYPcgZhF3GiSgev2PBm2c8rUkgMeKapCHdiHg/GQ5v8lF1ru+3hxNAJbNVcnkkp6avw3
 /e28mUSTh6fMKG95qxvE8UwR5IvgH7XNcFN4rfFb7fcIqhCMZW1JFGoz0dsJDZ80ry2tYIdo5my4aw
 MWS/9nUOjBkjppTekXNF1JwJ3XY3B0NBjBXWSJ1vQuJ62vvzKNiHt0HmJWFEWRGk/7Jlr0ltiqP2Ts
 fSCK8QFHulYOJ6m61xDGCR2K+nY03LEpecdtAYq6BH/PnytlOyz2x/6aqLw7ERAjCfkximXO2V0H5s
 wRJ9y6AWew0N/miVhLFfF/A8KMp6TQTwXeVvMCXtAHJIH5Kfzk6YKgH9QrdNzVNeRGV4XqQTU++x+A
 8xbeyynBZZDIdqDBghkGSU7DpGqP2bGTmrA7ma4xouyw2ccyVRceoNzCeLww==
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


