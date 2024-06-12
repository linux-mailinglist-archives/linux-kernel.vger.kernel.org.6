Return-Path: <linux-kernel+bounces-212150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CBA905BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C94C2880C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DDF84D0B;
	Wed, 12 Jun 2024 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XBKued0E"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000283A12
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718220109; cv=none; b=bkY598cohNqZkD7FGHvivIN1zeViSTBDeBDuuse9sEPuFamtX+2QVtz6hixV/G/FA0Qi3v8QuuqDPBE/jx3F2YN/ZAD/6K/b9Kh/KDzYaGXomtskXt8Ro/8voEj8cR0VxfrBzMYeAvRm0rdLoUT7ao4I1Orncbo5mMKGTQyZTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718220109; c=relaxed/simple;
	bh=dvmZdQy9gjHFAEqxiZyIZWPqYSmJNIY4i5p9DPr7XvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd4B/E5Hxnx2nRmg9nh5m6DicwvFbK9jD2bbHZzbopgpTjL3VGVgW9pGtgEu3xv6scafSbg+VHeVHZVkY84hOo1G2nupjrmowLoPBP3RvZEKFaeTeufGYJi8lT1CC6mA2Wwir8YTgFvonyKMyl/715qEbeWfaVvjTVZi7q7q4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XBKued0E; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f96f7465a6so702908a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718220105; x=1718824905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adv6hAITLa2R1TJy+qkYE+hXBxIyKoUUbMRb5HfUdKM=;
        b=XBKued0ELmUiWkJlJe/H8jpSMqN3pxuZJtCv/ZN3IWBahoWQy1cTCCxCAyxYkYWNTo
         d9ghBK2+XXQEyAuFsFp2o/cuk3s9kMf4NGVbrzB6y1iE5h91dfPt+PzTGx+q4FDq3a79
         nlINqqBBtoJSIgVZtrCo82CG7YddST2X0PbQJHxCL34ldpvFcf6zazabSwCGBurihJJN
         S9CU0wq+NBM5D6Vq8snA5LdriPEklugvHJHnU8QMBAZVjBPBHDWqABXA0d3Pm2cq25jc
         nBO0+M+W2xSORt7A2yjDq3qOOtQoexNANnZaq0ClaMvEXwbkIXY0OcCVbT7CyfwSYckf
         663g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718220105; x=1718824905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adv6hAITLa2R1TJy+qkYE+hXBxIyKoUUbMRb5HfUdKM=;
        b=dm4oOaDOwJqR30Ot1CZ1nFAQ/0MQV7mcCVkYLg9On0r8rxk4y7vm9ZM27LHyeW4h98
         Ff60Auh5yMzaQR9vNkOlPVw5Kuq/XXNyti1npxIcuErPmcbZEZv4PbkZsaiJIDThIgfF
         QvzNBddpzXz9tYTzo9t5Z8AiyjI6kq3kEhRWRiwhxDhZ+nhuuRmMkC6DBuR1UQEu77pm
         j6WQgH3+TC2rWXNezaMMY85XYo+P2CoscwvmAGtkduVj1k+WdDpEcS5vCyFxOSnycK4x
         JpoXB1ydywEx3vwGyNzkE0csPhR96OcID3LJPNcAG64gRQnzVAU6tKN4As8vLngfL5zx
         QooQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHDTWajsviXwYUBbA38nlsgHSegBlnLwiEej6MYevaJ8TTxuVD7Xbza2EsUO9anMy74NVQTV8AJvHKft6Ia9SQmoZ/GmtghudnH5mG
X-Gm-Message-State: AOJu0YyfncqNRAWfHNdWqG0nAbGJWVlvGoqiIbXnp/binc8h6CtI6y2O
	UBABGMErUFhc+MsSHAzArPJQPBNbpOcCkQgZgawYtt7PeNyfgsneB6Pt5o9hl8A=
X-Google-Smtp-Source: AGHT+IEQPfuf8Deay2ughLjf0mO221a1T0deKLDRLG35q5BS6L/972WRFWOz57bW4VTx5wmhipo6sQ==
X-Received: by 2002:a05:6808:d53:b0:3d2:1a98:24bb with SMTP id 5614622812f47-3d244e93710mr322991b6e.17.1718220101857;
        Wed, 12 Jun 2024 12:21:41 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d236676bfesm648795b6e.12.2024.06.12.12.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 12:21:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
Date: Wed, 12 Jun 2024 14:20:40 -0500
Message-ID: <20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Add device tree bindings for AD4695 and similar ADCs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    | 297 +++++++++++++++++++++
 MAINTAINERS                                        |   9 +
 2 files changed, 306 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
new file mode 100644
index 000000000000..8ff5bbbbef9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -0,0 +1,297 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4695.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices Easy Drive Multiplexed SAR Analog to Digital Converters
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  A family of similar multi-channel analog to digital converters with SPI bus.
+
+  * https://www.analog.com/en/products/ad4695.html
+  * https://www.analog.com/en/products/ad4696.html
+  * https://www.analog.com/en/products/ad4697.html
+  * https://www.analog.com/en/products/ad4698.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - adi,ad4695
+          - adi,ad4697
+      # same chips in WLCSP package with more pins
+      - items:
+          - const: adi,ad4695-wlcsp
+          - const: adi,ad4695
+      - items:
+          - const: adi,ad4697-wlcsp
+          - const: adi,ad4697
+      # same chips with higher max sample rate
+      - items:
+          - const: adi,ad4696
+          - const: adi,ad4695
+      - items:
+          - const: adi,ad4698
+          - const: adi,ad4697
+      # same chips with higher max sample rate in WLCSP package
+      - items:
+          - const: adi,ad4696-wlcsp
+          - const: adi,ad4696
+          - const: adi,ad4695-wlcsp
+          - const: adi,ad4695
+      - items:
+          - const: adi,ad4698-wlcsp
+          - const: adi,ad4698
+          - const: adi,ad4697-wlcsp
+          - const: adi,ad4697
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 80000000
+
+  spi-cpol: true
+  spi-cpha: true
+
+  spi-rx-bus-width:
+    minimum: 1
+    maximum: 4
+
+  avdd-supply:
+    description: A 2.7 V to 5.5 V supply that powers the analog circuitry.
+
+  ldo-in-supply:
+    description: A 2.4 V to 5.5 V supply connected to the internal LDO input.
+
+  vdd-supply:
+    description: A 1.8V supply that powers the core circuitry.
+
+  vio-supply:
+    description: A 1.2V to 1.8V supply for the digital inputs and outputs.
+
+  ref-supply:
+    description: A 2.4 V to 5.1 V supply for the external reference voltage.
+
+  refin-supply:
+    description: A 2.4 V to 5.1 V supply for the internal reference buffer input.
+
+  com-supply:
+    description: Common voltage supply for pseudo-differential analog inputs.
+
+  adi,no-ref-current-limit:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When this flag is present, the REF Overvoltage Reduced Current protection
+      is disabled.
+
+  adi,no-ref-high-z:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable this flag if the ref-supply requires Reference Input High-Z Mode
+      to be disabled for proper operation.
+
+  cnv-gpios:
+    description: The Convert Input (CNV). If omitted, CNV is tied to SPI CS.
+    maxItems: 1
+
+  reset-gpios:
+    description: The Reset Input (RESET). Should be configured GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    items:
+      - description:
+          Signal coming from the BSY_ALT_GP0 or GP3 pin that indicates a busy
+          condition.
+      - description:
+          Signal coming from the BSY_ALT_GP0 or GP2 pin that indicates an alert
+          condition.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: busy
+      - const: alert
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: |
+      The first cell is the GPn number: 0 to 3.
+      The second cell takes standard GPIO flags.
+
+  "#address-cells":
+    const: 1
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@[0-9a-f]$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+    description:
+      Describes each individual channel. In addition the properties defined
+      below, bipolar from adc.yaml is also supported.
+
+    properties:
+      reg:
+        maximum: 15
+        description: Input pin number (INx).
+
+      adi,pin-pairing:
+        description: |
+          The input pin pairing for the negative input. This can be:
+          - REFGND, normally 0V (single-ended)
+          - COM, normally V_REF/2, see com-supply (pseudo-differential)
+          - For even numbered pins, the next odd numbered pin (differential)
+        $ref: /schemas/types.yaml#/definitions/string
+        enum: [refgnd, com, next]
+        default: refgnd
+
+      adi,no-high-z:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: |
+          Enable this flag if the input pin requires the Analog Input High-Z
+          Mode to be disabled for proper operation.
+
+    required:
+      - reg
+
+    allOf:
+      # only even number pins can be paired with the next pin
+      - if:
+          properties:
+            reg:
+              not:
+                multipleOf: 2
+        then:
+          properties:
+            adi,pin-pairing:
+              enum: [refgnd, com]
+      # bipolar mode is not supported with REFGND pairing
+      - if:
+          not:
+            required:
+              - adi,pin-pairing
+        then:
+          properties:
+            bipolar: false
+        else:
+          if:
+            properties:
+              adi,pin-pairing:
+                const: refgnd
+          then:
+            properties:
+              bipolar: false
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - vio-supply
+
+allOf:
+  - oneOf:
+      - required:
+          - ref-supply
+      - required:
+          - refin-supply
+
+  - oneOf:
+      - required:
+          - ldo-in-supply
+      - required:
+          - vdd-supply
+
+  # LFSCP package has fewer pins, so a few things are not valid in that case
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              pattern: -wlcsp$
+    then:
+      properties:
+        refin-supply: false
+        spi-rx-bus-width:
+          maximum: 2
+
+  # the internal reference buffer always requires high-z mode
+  - if:
+      required:
+        - refin-supply
+    then:
+      properties:
+        adi,no-ref-high-z: false
+
+  # limit channels for 8-channel chips
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad4697
+    then:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              maximum: 7
+        "^channel@[8-9a-f]$": false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4695";
+            reg = <0>;
+            spi-cpol;
+            spi-cpha;
+            spi-max-frequency = <80000000>;
+            avdd-supply = <&supply_2_5V>;
+            vdd-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_2V>;
+            ref-supply = <&supply_5V>;
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            /* Differential channel between IN0 and IN1. */
+            channel@0 {
+                reg = <0>;
+                adi,pin-pairing = "next";
+                bipolar;
+            };
+
+            /* Single-ended channel between IN2 and REFGND. */
+            channel@2 {
+                reg = <2>;
+            };
+
+            /* Pseudo-differential channel between IN3 and COM. */
+            channel@f {
+                reg = <3>;
+                adi,pin-pairing = "com";
+                bipolar;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c870bc6b8d63..8d15e4089d7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1209,6 +1209,15 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 F:	drivers/iio/adc/ad4130.c
 
+ANALOG DEVICES INC AD4695 DRIVER
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	David Lechner <dlechner@baylibre.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+
 ANALOG DEVICES INC AD7091R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.45.2


