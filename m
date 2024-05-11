Return-Path: <linux-kernel+bounces-176329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A18C2E29
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE1C1C214BA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF91CF96;
	Sat, 11 May 2024 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H86emGCm"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793118EA1
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388606; cv=none; b=J+1gDvereEX41CS6iT23Xiwx3TaslLB30SdisYHXN/jiKxddW352Chd03n5bylwcYe/NEo4NeXWUOY/fwcB7LeC5s5yIMhBDKTCJYSdLNg6rJsgH/yFIrsdb9vA30hRWyyePU8BxPipHUXgvpaL5SjFaEmyUhUoTl9hwpfPKZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388606; c=relaxed/simple;
	bh=dPMCl0g+OO+JoGM1rnoH86D9s8fsanSB5CULbbdJ0oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYrL6NnVyqX7o7iG+sdlpQHVK7K5/isGjhJMw0ySX4rUjfBmT7n8auUUGeGCV/TW1xTCXDslDtaYtsUsxkKiW8Pn16dgIgcKBkZaBUm32KvGV+OAveF/VqhwQ2Ic1KPw2WPLcMRZm1qCE3ie2+BcbIKhNLk7IcqW8/G5TIPpo0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H86emGCm; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b27e8ad4b6so932217eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715388603; x=1715993403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o3IyLXYhcDBezTLcNXXyCLcD/u+BjxsxpQAYgTMy0o=;
        b=H86emGCm+gWk+vQN9C9xcomRFJ0ZxxVPtf9ODNfMRiC6nv4h9T6ZQeQicY5+sgPAHd
         ekOKAluiLPefEyoOQJ8hqMaouvn7X31rwNngQs7DdMfCVp+icV702OS+4WVzI9QUDI1M
         RR83U6okmaxT6WCfVTq/Qtg2eO7MJRbehgGud4tJlNIz4mPivpiLB4EMlS7T54qzB4Mm
         aSgpYdJTtN0gyrDVjXZo+F6dvzhJ3PYBcvoNi8+WnpxNoe4WDscA9hs9YvrdpF8J/Zrf
         Qgtxk4pt6EMXQwpQ7CZX2vRPv5QQZtzlOBGKH7Ojti4BpfCyt9SjW29z8IbinepoL/FT
         oPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715388603; x=1715993403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o3IyLXYhcDBezTLcNXXyCLcD/u+BjxsxpQAYgTMy0o=;
        b=buGM4ja+6dgpl7iFXTymQP+cpAepMU4R2/6hLohkgsn2k/XyM663vZOe1KC97UiyTZ
         mOF8B6P78o/XwSYOROTxszb/GWlcKYQtFkBlXU1VY3uy8QqRE9arvH24+h5ZKkCp0MMN
         n1qfuuHqX/tBsGBOJZDUm1qrkU82AJrTc0MUM7ejqJHsAWmjipHPrOnDoMlLkXl+c7C5
         vVC91E8VpcaUMTwDg8a2jzECmbZsRvhkpOXW9pAXZwHg8NBMyH/g3i7amabJKBFmYxlo
         WEtSUDNuCh3EGkJvOjpSv7hfNtmvgKF61N/oaUFsWi2Kv9B2XMvNS81470acsuijh5Zi
         OP9w==
X-Forwarded-Encrypted: i=1; AJvYcCW8TG6KpoemPNaK6SfvyoNECz74hDgkB0neSi3ovuOOu5cSCw8HqqZJmnJ7q5O5TGC8+uA0tdaCyefMCdGQ60Y6xnea6V+2M5ZA5uX1
X-Gm-Message-State: AOJu0YzZfh5H9nRw317Y7rQXODBwNyOvNxfjSXx3HFjwR205SnBH/9oe
	6zFH+JZFdLbf4H1lRiF6RO2h5CPydmfSjfsE0WzRsEgArcQOZKrMs3Xy0hvhd8E=
X-Google-Smtp-Source: AGHT+IH/UxnNyIem5xjkj+EmfpQmh+3GYvOohKxeg+FekmzNUiGiPzf/c+XGTZipmBuXlKWHUJY7Nw==
X-Received: by 2002:a4a:4881:0:b0:5b2:ef4:873d with SMTP id 006d021491bc7-5b28196c378mr4259504eaf.4.1715388603082;
        Fri, 10 May 2024 17:50:03 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b29015a3dbsm321132eaf.46.2024.05.10.17.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 17:50:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v2 7/8] dt-bindings: iio: adc: adi,ad7944: add SPI offload properties
Date: Fri, 10 May 2024 19:44:30 -0500
Message-ID: <20240510-dlech-mainline-spi-engine-offload-2-v2-7-8707a870c435@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

To enable capturing data at high rates, the AD7944 is frequently used
with the AXI SPI Engine IP core. This patch adds the properties needed
to describe the SPI offload configuration in the device tree.

The clock trigger and DMA buffer for rx data are external to the SPI
controller and specific to the application so the are included in the
peripheral bindings.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:

This is a new patch that partially replaces "dt-bindings: iio: offload:
add binding for PWM/DMA triggered buffer".

In the previous review, it was suggested that having a separate binding
and object node for the offload was overcomplicated. So instead this
opts to use the proposed standard spi-offloads property as a flag to
allow the SPI periperhal node require additional properties that are
resources that are physically connected to the SPI offload.

On a whim, I also changed pwms to clocks in the binding. The thinking
being that we only care about the frequency (it determines the sample
rate) so a clock made more sense and might allow more flexibility in
the future. But since the actual hardware we have is a PWM, we would
have to use "pwm-clock" in the devicetree to make the PWM act as a
clock. But it turns out that the pwm-clock driver does not support
setting the frequency, so we would have to do more work to actually
be able to use this binding in practice.
---
 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
index d17d184842d3..5ea12aac9d25 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
@@ -129,6 +129,25 @@ properties:
       line goes high while the SDI and CNV lines are high (chain mode),
     maxItems: 1
 
+  # optional SPI offload support for use with AXI SPI Engine
+
+  spi-offloads:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+    description: RX DMA Channel for receiving a samples from the SPI offload.
+
+  dma-names:
+    const: rx
+
+  clocks:
+    maxItems: 1
+    description: Clock to trigger the SPI offload for reading a sample.
+
+  clock-names:
+    const: trigger
+
 required:
   - compatible
   - reg
@@ -190,6 +209,23 @@ allOf:
       properties:
         turbo-gpios: false
 
+  # certain properties are for SPI offload use only
+  - if:
+      required:
+        - spi-offloads
+    then:
+      required:
+        - dmas
+        - dma-names
+        - clocks
+        - clock-names
+    else:
+      properties:
+        dmas: false
+        dma-names: false
+        clocks: false
+        clock-names: false
+
 unevaluatedProperties: false
 
 examples:
@@ -211,3 +247,25 @@ examples:
             turbo-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+            compatible = "adi,ad7944";
+            reg = <0>;
+            spi-cpha;
+            spi-max-frequency = <111111111>;
+            adi,spi-mode = "single";
+            avdd-supply = <&supply_2_5V>;
+            dvdd-supply = <&supply_2_5V>;
+            vio-supply = <&supply_1_8V>;
+            bvdd-supply = <&supply_5V>;
+            spi-offloads = <0>;
+            dmas = <&dma 0>;
+            dma-names = "rx";
+            clocks = <&trigger_clk>;
+            clock-names = "trigger";
+        };
+    };

-- 
2.43.2


