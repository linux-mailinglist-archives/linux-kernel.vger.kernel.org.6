Return-Path: <linux-kernel+bounces-330928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44097A633
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E8D1F235E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5912915ADB3;
	Mon, 16 Sep 2024 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdZMnd/m"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121280C0A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505337; cv=none; b=H+vFKJatneo+Zb2Hs8AXdL0XqDXK1N3+6CLcqPQnSM9Z3lsPRHoJdzTTtKT6Gib8OYDZqmqNr05x44kZfCInyXYT9uGupKhnFTpwirFOi6vUEk0YpwIsyVhDfm7SndGjtfgH6Kac7e3w/rwQkm438GNJdhl3p5kZO5Y+Ddn+q3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505337; c=relaxed/simple;
	bh=pxmyAbks+J2we7TOo5iUIuL8bcXcYzSQD1oMRLUv3SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDXGhjFO48L/jay8OHBuMXuoAG3H+EahpHiZjIcEobpczYwruP+aFYmcS3Icke8YgqfuPshoR0DGh7YIBlIQ7ltEMfUw965BkL6syXX2zTqlv3tnExJa0iN3ELXxmUxc34ZDvIUaLRd3fIoTTUfLi+uYituTKElCbiJAHOJI+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PdZMnd/m; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so8537931a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726505334; x=1727110134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLLYvOuj/CMtRI/JQM+Q1v7wRhCj/jiSXsGWsgUrjx4=;
        b=PdZMnd/mgl0DWuVhTYvdnklj29QaZQqpqfYQUg49mV/854oQU34if6w6TBlNr8YwLe
         oOmEATDfTX6Mzgmk0zHvfV+cr/KYkIUONIsJENUYc7RR4RDkNAQWuMHRHoyqNIBEo6M+
         +D92IBeE3RIDPC5sgOCdyGUqXLEpNArK4HMTxman4b0AMDwndh86WxzoJoWGPvrlRHPa
         rWI0BEX1pIhcMous4zdgOAch8Q913qWrjOcWc1pcxNxQab3bKXdM4BMBrkth0CJ03OsR
         bhcVyf/8JEq+E7pthEg7KYKCIhxBBldHG8Uy1ORHNLLj8QHRmsGC/TIYwdPGMDNITwI+
         HPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726505334; x=1727110134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLLYvOuj/CMtRI/JQM+Q1v7wRhCj/jiSXsGWsgUrjx4=;
        b=AFvhKlBGLaYbSBTT9mWzjK6Wg1/mLnGBPdgrbFOnczN0WI6BApqy69Jn9BFVuQjY/7
         HviO/fyxVSRBTwgDNNBA82aKUkV5A/eJY7cN1NFoLBskX2vgr1ntKqqTN/cjvp1fYcOn
         OnV3CB7zUZvfdM8OotZAfuZYxHisPJCKQmYGAKH0HpW5ri6cpayOQhvw9WVWxfbJx7Qv
         Z8R6J4d+9/8CsdLL/tCPNPzwtaxsbdaOzp5LKlTBQddFNliRq6C3yuuUZj4MACGzwXsF
         7EIsIzXI8FT/+0HtodN9LMJj4KPu7k50ZS2jVodEBUPzgPMJqYVBOHUD3FvTKoeLysiX
         qiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqi5+v8mUlVVhm6CEfMGtwFGORKfx7zCeQqxuGp6iCOmcjjW/gU6yO0NV0S7nVdd+Cko8FvP6kQA6Ce/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMxbqqQ0p9qgmXzS2cz5t/ht+Qt69RrVE8bmuOQp13UeHJUtO
	K1qVTJuRZ5w73RVx2Pd7Fn9L/7wixjCC2S75BzcA3R267Bs2UcL6dlU7i9Di7vY=
X-Google-Smtp-Source: AGHT+IF4dVgp1g2BP9PAZ9FssRy9leVgWKxlc0y6nvI5F6SL3IYtQZD0PvpBYLDVffRMKI558xWasQ==
X-Received: by 2002:a05:6402:51cc:b0:5be:d595:5413 with SMTP id 4fb4d7f45d1cf-5c41434e36fmr16404116a12.3.1726505333764;
        Mon, 16 Sep 2024 09:48:53 -0700 (PDT)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb492a1sm2798145a12.8.2024.09.16.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:48:53 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 16 Sep 2024 17:48:52 +0100
Subject: [PATCH 1/2] dt-bindings: regulator: add max20339 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240916-max20339-v1-1-b04ce8e8c471@linaro.org>
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
In-Reply-To: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Add device tree binding for Maxim MAX20339 overvoltage protector with
load switches.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/regulator/maxim,max20339.yaml         | 171 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 177 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max20339.yaml b/Documentation/devicetree/bindings/regulator/maxim,max20339.yaml
new file mode 100644
index 000000000000..ef6490cf5a6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max20339.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max20339.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX20339 overvoltage protector with load switches
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  The MAX20339 is an overvoltage protection (OVP) device with integrated load
+  switches and ESD Protection for USB Type-C applications. It protects low
+  voltage systems against voltage faults and surges. It also integrates two
+  load switches with current limiting, configurable by hard- and software.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max20339
+
+  dig-supply:
+    description:
+      Input supply for the device itself (DIG pin, 1.7V to 1.9V). In absence of
+      Vdig, the IN pin will power the device.
+
+  gpio:
+    type: object
+
+    properties:
+      "#gpio-cells":
+        const: 2
+
+      gpio-controller: true
+
+      gpio-line-names:
+        description: Strings describing the names of each gpio line.
+        maxItems: 1
+
+    required:
+      - "#gpio-cells"
+      - gpio-controller
+
+    additionalProperties: false
+
+  insw-supply:
+    description:
+      Input supply for the outputs (IN pin, 3.9V to 28.0V). Also used as supply
+      for the device itself in case dig-supply is not wired up.
+
+  interrupts:
+    maxItems: 1
+
+  lsw1-supply:
+    description: Input supply for the outputs (LSW1IN pin, 4.0V to 10.0V)
+
+  lsw2-supply:
+    description: Input supply for the outputs (LSW2IN pin, 4.0V to 10.0V)
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    properties:
+      insw:
+        type: object
+        $ref: regulator.yaml#
+        description: Represents the switch connecting IN to OUT, INSW.
+
+        properties:
+          regulator-ov-protection-microvolt:
+            enum: [5850000, 9700000, 14500000]
+
+        unevaluatedProperties: false
+
+    patternProperties:
+      "^lsw[12]$":
+        type: object
+        $ref: regulator.yaml#
+        description: Represents the load switches LSW1 and LSW2.
+
+        properties:
+          regulator-ov-protection-microvolt:
+            enum: [0, 1]
+
+          shunt-resistor-micro-ohms:
+            description:
+              Value in micro Ohm of the resistor connected between the SETx
+              pin and GND. This value is required to be able to calculate and
+              program the current limiting threshold register.
+
+        required:
+          - shunt-resistor-micro-ohms
+
+        unevaluatedProperties: false
+
+    required:
+      - lsw1
+      - lsw2
+
+    additionalProperties: false
+
+anyOf:
+  - oneOf:
+      - required:
+          - dig-supply
+      - required:
+          - insw-supply
+  - required:
+      - dig-supply
+      - insw-supply
+
+required:
+  - compatible
+  - reg
+  - regulators
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
+        ovp@35 {
+            compatible = "maxim,max20339";
+            reg = <0x35>;
+
+            dig-supply = <&reg_1v8>;
+            insw-supply = <&reg_5v3>;
+            lsw1-supply = <&reg_5v3>;
+            lsw2-supply = <&reg_5v3>;
+
+            interrupts-extended = <&gpa8 1 IRQ_TYPE_LEVEL_LOW>;
+
+            gpio {
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            regulators {
+                insw {
+                    regulator-name = "PPVAR_VBUS_OVP";
+                    regulator-active-discharge = <0>;
+                    regulator-min-microvolt = <5850000>;
+                    regulator-max-microvolt = <14500000>;
+                    regulator-ov-protection-microvolt = <14500000>;
+                };
+                lsw1 {
+                    regulator-name = "PPVAR_VBUS_OVP_LSW1";
+                    regulator-oc-protection-microamp = <1460000>;
+                    regulator-ov-protection-microvolt = <1>;
+                    shunt-resistor-micro-ohms = <120000000>;
+                };
+                lsw2 {
+                    regulator-name = "PPVAR_QI_VOUT_TX";
+                    regulator-oc-protection-microamp = <1230000>;
+                    regulator-ov-protection-microvolt = <1>;
+                    shunt-resistor-micro-ohms = <147000000>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2cdd7cacec86..ec871955e31c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13998,6 +13998,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
 F:	drivers/regulator/max20086-regulator.c
 
+MAXIM MAX20339 OVERVOLTAGE PROTECTOR WITH LOAD SWITCHES DRIVER
+M:	André Draszik <andre.draszik@linaro.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/maxim,max20339.yaml
+
 MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
 M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
 L:	linux-iio@vger.kernel.org

-- 
2.46.0.662.g92d0881bb0-goog


