Return-Path: <linux-kernel+bounces-514927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DDAA35D87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE83A90C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0422641C5;
	Fri, 14 Feb 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c9INqQ8E"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8526137F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535799; cv=none; b=Kh7xy6nvVMvWXSK2H082F40yE/4seMN/u7n1duouoYKpGruyoP0gpRmjOKUxRX0ef869/vfVoynzAyzi+5stQClxX7RgQDq4ggGy/G3FLXOSM048p//3wGA5b0LHD+HSS7SLqfQV3miPhssilWH5G+oxA0O1Oim5i9IwIzf6tAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535799; c=relaxed/simple;
	bh=GZiQ6zwLnj9czKKnGwp69ohjckNVfoQP2zmeBSWPev8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOZzjgKFZlCJ1eknKVF0UVJzEqY0dve6ly+kQ9uhnhHSX7QM9GP3A/rxE8OD32SG7PNlMxRxGjfNn1Hsz0KEFZ7Jg9nI1GHvnMNvR35ZvoTWzLJrYDcQqP2zue1FQYbTwNtrmy1P+jIV+ly/BKe9yBDx36fU7nkTavecurz+ljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c9INqQ8E; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4395a06cf43so12787585e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739535795; x=1740140595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fm3SdUr+XcDlqAYhLCX7VaMzzxMU+2eGpj/VQCDpL2c=;
        b=c9INqQ8EMECrE/uzzfiffuljT6tpaFvIjHluodQcowUiKNWxXq2B9E68gQEw7/Q6k2
         9zAa4uJEKwxyTzUixB+3MDzn0mK14RYo1uCC5+CljSuiOI1+G417MkN+xsccCwIHDMQX
         VM4Ki1qwhgIR3qMaYDEQMplqdYjEHHw+Dzga3U34/ZTTYY5fXnN3YvC/ksuRsS0KTQpQ
         dqCgWLrbUslypyrZtM55jr8uuK8iw8bpDe+S3xrxEpCU0qrhecW6scvFHA6elo2n7pUc
         3249hsaYDTeUy/c5xc1gDL7iqvLolEjCZw43ihatnzLZwLL2PC+pcFdBxXsGXMg7gO2L
         8n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535795; x=1740140595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fm3SdUr+XcDlqAYhLCX7VaMzzxMU+2eGpj/VQCDpL2c=;
        b=m0tzPpsdsAGx9Fag8RjSLlZdJAuAoAaeUW8DnWY7Phk/2VFpV55LIbQdBtEEHg7u9W
         cTvIXPS0f0A+5ygCRv9qvvpjXpTKvKfmD/mpszjsKnAWx3Za0iBiDWriEVI4aTCBlXvq
         qjZ4nKkCsjNQoPeRJgY3bQ68d4fYbvl0vnv7hFy2CvGCmkHfw1XFBBRkkgznzG1cagH6
         PHi5EkTYorI5fl+Vl/z1LARXquJNYLcY8rNp/dnnDLk+BeAXHo5OYoHaVsef0hQw4YKz
         7i+cfRH94OiB+lLC6RBzDiwSn7NtyY39IduVqfIRDdFFexsMcL1UWqu/P8PTZ2N4Tx1g
         6PPg==
X-Forwarded-Encrypted: i=1; AJvYcCX9e4pF1KXJt3EfK/eIECKydlJeJnf5m1aJn/tsn3CVc04J+ctVKeMgboM1/nbk7F04kvx7+Gz1izsjAcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+2Wm+Ohbaw6wSJvnOtNHY5E6NCiBwlGbhb25mF93eZ06FzSN
	4vU83LNGBxYQD7jfh2b+u9Y69x5aCforOZxDoU44ox/EaujNYszdi9k3QWgZElk=
X-Gm-Gg: ASbGncuGbv0j5+XT4j+WpTnq5vlb9OetPrRhAuGrFi8pMYekTD372eWbFj9e98weUno
	pA3A6VTDJwF1PHmHPCpxyu3OQEyr5Owm9s9IdPQU8SbhUJh/Y57A4Nr0g8KYxatORSaGMNOsnif
	fEpZzp/kzuS5eWoZUnyi7BM5TuSlfJqpy+KrtE2x8RPSo+OqZG3hRDiyxeaHGaZiUZgCxep/6PY
	0kcAGP6s3xOHuGgNLjCfqaf2Ja+LYYpzJ8UfMebNdXcrtuENpAgbKYuxBADkR0OV0nqURD42UGH
	Ivv1p61kHgKmUXL8Hiez7vYFTyYNUtLjtm+m9LlIFi8uEmQj3rzPTdRoHgfbjrgPlwbpzkO4
X-Google-Smtp-Source: AGHT+IGwkq07676KTqyEaxNz9NvrlZsawD0WRNZ0jroOP1Gbp3SkUEhcQHH3b90tMjHwD3iIKtLR2A==
X-Received: by 2002:a05:600c:870a:b0:439:554e:70d4 with SMTP id 5b1f17b1804b1-439601694f2mr75256105e9.1.1739535794612;
        Fri, 14 Feb 2025 04:23:14 -0800 (PST)
Received: from [127.0.0.1] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7b68sm4424654f8f.85.2025.02.14.04.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:23:14 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Fri, 14 Feb 2025 13:22:31 +0100
Subject: [PATCH v4 1/6] dt-bindings: iio: adc: add ADI ad4030, ad4630 and
 ad4632
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-eblanc-ad4630_v1-v4-1-135dd66cab6a@baylibre.com>
References: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
In-Reply-To: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Esteban Blanc <eblanc@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2

This adds a binding specification for the Analog Devices Inc. AD4030,
AD4630 and AD4632 families of ADCs.

- ad4030-24 is a 1 channel SAR ADC with 24 bits of precision and a
  sampling rate of 2M samples per second
- ad4032-24 is a 1 channel SAR ADC with 24 bits of precision and a
  sampling rate of 500K samples per second
- ad4630-16 is a 2 channels SAR ADC with 16 bits of precision and a
  sampling rate of 2M samples per second
- ad4630-24 is a 2 channels SAR ADC with 24 bits of precision and a
  sampling rate of 2M samples per second
- ad4632-16 is a 2 channels SAR ADC with 16 bits of precision and a
  sampling rate of 500K samples per second
- ad4632-24 is a 2 channels SAR ADC with 24 bits of precision and a
  sampling rate of 500K samples per second

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 111 +++++++++++++++++++++
 MAINTAINERS                                        |   9 ++
 2 files changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..cef2dc1eefb9126f836794c742b9e471a847296a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2024 Analog Devices Inc.
+# Copyright 2024 BayLibre, SAS.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4030.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4030 and AD4630 ADC families
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Nuno Sa <nuno.sa@analog.com>
+
+description: |
+  Analog Devices AD4030 single channel and AD4630/AD4632 dual channel precision
+  SAR ADC families
+
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
+  * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4030-24
+      - adi,ad4032-24
+      - adi,ad4630-16
+      - adi,ad4630-24
+      - adi,ad4632-16
+      - adi,ad4632-24
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 102040816
+
+  spi-rx-bus-width:
+    enum: [1, 2, 4]
+
+  vdd-5v-supply: true
+  vdd-1v8-supply: true
+  vio-supply: true
+
+  ref-supply:
+    description:
+      Optional External unbuffered reference. Used when refin-supply is not
+      connected.
+
+  refin-supply:
+    description:
+      Internal buffered Reference. Used when ref-supply is not connected.
+
+  cnv-gpios:
+    description:
+      The Convert Input (CNV). It initiates the sampling conversions.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      The Reset Input (/RST). Used for asynchronous device reset.
+    maxItems: 1
+
+  interrupts:
+    description:
+      The BUSY pin is used to signal that the conversions results are available
+      to be transferred when in SPI Clocking Mode. This nodes should be
+      connected to an interrupt that is triggered when the BUSY line goes low.
+    maxItems: 1
+
+  interrupt-names:
+    const: busy
+
+required:
+  - compatible
+  - reg
+  - vdd-5v-supply
+  - vdd-1v8-supply
+  - vio-supply
+  - cnv-gpios
+
+oneOf:
+  - required:
+      - ref-supply
+  - required:
+      - refin-supply
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
+            compatible = "adi,ad4030-24";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            vdd-5v-supply = <&supply_5V>;
+            vdd-1v8-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+        };
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353de25c88291cc7fd6c4e9bfb12d5c4..f0c7aa6d744040ba530917b566ca68087a49492f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1306,6 +1306,15 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 F:	Documentation/iio/ad4000.rst
 F:	drivers/iio/adc/ad4000.c
 
+AD4030 ADC DRIVER (AD4030-24/AD4630-16/AD4630-24/AD4632-16/AD4632-24)
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	Esteban Blanc <eblanc@baylibre.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.47.2


