Return-Path: <linux-kernel+bounces-333501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF9B97C9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B347D1C22885
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986E19E830;
	Thu, 19 Sep 2024 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h+jCse6I"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAC1A01C5
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751106; cv=none; b=BUMob9RFNEEy7o7NCfupSD1QTHoqqF1A+HCrTdhswLpDsusnRzUgv1u2XfHRPngBTT31hjjEJPDWLeYtKu7R6LapWdnMQnlvHe4yig30kRnR2uDqZGbJcVOMUAI07yvte26N7gKSeaLuyFN2azCcFAeGKohuo8D1cH2glpZmGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751106; c=relaxed/simple;
	bh=GQdyZWqzfnQT3hAZa3L+fZIM4t+AoyLa8IiB5e8peIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3YI80hBVSxoJwVvOz/PwAWZZcTJaT38w3MKf2W2oZ+n3FODYm+kiPvZHgRns+LMUcfXG+0nwdprb7iM+AlQS5Ljr5dY9B/HKW0AbjlCl2PR+R1nTZQOiXa9WAx6fyEZg0jp3sL06UzM3OGdzFneHeVwFqMjXbnJ4qYc2MzXkF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h+jCse6I; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa086b077so112675066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726751103; x=1727355903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7id2uNYW2O+D+9KmRKjfLk5jRelw+ydc8eaTsKnZHc=;
        b=h+jCse6IKqg2yWvu2L50mVw/DU264NerkzbzJcT+mFPcBcOjx/8Mpcw8l7yJCb5M/X
         oO27CC5UvoP8dRMEv/xs1RbNBaCxZcFHYo9CzbMyIrI0vpflwUMWjJu5mJyV8Xz7j/f4
         iBK93+XByp105yTfMYjMmMXSe3BbybxzV+1O/1Umic/jh0nn5ZfC45RIEHhqV0wK7UPr
         wD54Trc+apY3h7xRPGfMVPK0VvY8hv5vA7igdrUQ8//QErcJDMa9KlZQcIVbKmPLIm5f
         IEKiGr1aGNQqAdXIhrKvBTFynjfLaT8OXcXou1Atbs1ZwwgYxwfnfuO/vNLwN5PL0F+e
         P2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726751103; x=1727355903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7id2uNYW2O+D+9KmRKjfLk5jRelw+ydc8eaTsKnZHc=;
        b=Ls9bH95b5B852C8W06PTf+QnQbmqLwHlx5ocN36PMZ0/01pKJDmPxSWHIzukFRdpoz
         1sTO0EWyuAwaSndSs0c2UMgLbKROZDvkyBHqUEgkER6oFrQXBDK3vOmT70T9K3GWO3lj
         gh342aekFLYfMLfVS/upUlymAN/4zAy/T+YnYbDiCRqX3nAD+pK94xrHi8kxT3YYxOam
         7XmSyUbQWcRCY+RaTR3xdI2KvQLRGakxhGrMV3WKje4xp880qoN9lw/ytLPmVh2c1w4K
         m2gqmMRjLOwYdkZOcfhsYHGQFOzT+9ieU+tqpGs34tuGXXUpVH008A8lW1cWvrJt76fy
         fRnw==
X-Forwarded-Encrypted: i=1; AJvYcCV+gbccoEjNXTkcOc9nYH2eRAulaJO5g5+1EGSDP5rG67jAz+Jn0Sh0ky+0FWlAVT6xamXKnv346pK35o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIn3EvvWY5EJcGFgn71R/RY7IfqwKk3WnAzT6hs5hC55KcHhO
	eOSaszA+SKRNAjD1bXdSUICZLHm9kNeZGVvex68sko56/cLYBot5DsVm7Vz3RTs=
X-Google-Smtp-Source: AGHT+IGNlJottmDzPzx0Gu7cX0jZi+pY3crUMD5i6Wzg/5buXQlriDxASBEnczvo+IbUWDCdACJVyA==
X-Received: by 2002:a17:907:d5a2:b0:a86:96d1:d1f with SMTP id a640c23a62f3a-a902943a557mr2472309566b.26.1726751102601;
        Thu, 19 Sep 2024 06:05:02 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90cbc7122esm53213166b.124.2024.09.19.06.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:05:02 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 7/8] dt-bindings: iio: adc: add docs for AD7606C-{16,18} parts
Date: Thu, 19 Sep 2024 16:04:42 +0300
Message-ID: <20240919130444.2100447-8-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919130444.2100447-1-aardelean@baylibre.com>
References: <20240919130444.2100447-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver will support the AD7606C-16 and AD7606C-18.
This change adds the compatible strings for these devices.

The AD7606C-16,18 channels also support these (individually configurable)
types of channels:
 - bipolar single-ended
 - unipolar single-ended
 - bipolar differential

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 .../bindings/iio/adc/adi,ad7606.yaml          | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 69408cae3db9..bec7cfba52a7 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -14,6 +14,8 @@ description: |
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7605-4.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606_7606-6_7606-4.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7606B.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf
 
 properties:
@@ -24,11 +26,19 @@ properties:
       - adi,ad7606-6
       - adi,ad7606-8  # Referred to as AD7606 (without -8) in the datasheet
       - adi,ad7606b
+      - adi,ad7606c-16
+      - adi,ad7606c-18
       - adi,ad7616
 
   reg:
     maxItems: 1
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
   spi-cpha: true
 
   spi-cpol: true
@@ -114,6 +124,47 @@ properties:
       assumed that the pins are hardwired to VDD.
     type: boolean
 
+patternProperties:
+  "^channel@[1-8]$":
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        description:
+          The channel number, as specified in the datasheet (from 1 to 8).
+        minimum: 1
+        maximum: 8
+
+      diff-channels:
+        description:
+          Each channel can be configured as a bipolar differential channel.
+          The ADC uses the same positive and negative inputs for this.
+          This property must be specified as 'reg' (or the channel number) for
+          both positive and negative inputs (i.e. diff-channels = <reg reg>).
+          Since the configuration is bipolar differential, the 'bipolar'
+          property is required.
+        items:
+          minimum: 1
+          maximum: 8
+
+      bipolar:
+        description:
+          The ADC channels can be configured as
+             * Bipolar single-ended
+             * Unipolar single-ended
+             * Bipolar differential
+          Therefore in the DT, if no channel node is specified, it is considered
+          'unipolar single-ended'. So for the other configurations the 'bipolar'
+          property must be specified. If 'diff-channels' is specified, it is
+          considered a bipolar differential channel. Otherwise it is bipolar
+          single-ended.
+
+    required:
+      - reg
+      - bipolar
+
 required:
   - compatible
   - reg
@@ -170,6 +221,25 @@ allOf:
         adi,conversion-start-gpios:
           maxItems: 1
 
+  - if:
+      not:
+        required:
+          - adi,sw-mode
+    then:
+      patternProperties:
+        "^channel@[1-8]$": false
+
+  - if:
+      not:
+        properties:
+          compatible:
+            enum:
+              - adi,ad7606c-16
+              - adi,ad7606c-18
+    then:
+      patternProperties:
+        "^channel@[1-8]$": false
+
 unevaluatedProperties: false
 
 examples:
@@ -202,4 +272,54 @@ examples:
             standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7606c-18";
+            reg = <0>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+
+            avcc-supply = <&adc_vref>;
+            vdrive-supply = <&vdd_supply>;
+
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+
+            adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+            adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+            standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
+
+            adi,sw-mode;
+
+            channel@1 {
+                reg = <1>;
+                diff-channels = <1 1>;
+                bipolar;
+            };
+
+            channel@3 {
+                reg = <3>;
+                bipolar;
+            };
+
+            channel@8 {
+                reg = <8>;
+                diff-channels = <8 8>;
+                bipolar;
+            };
+
+        };
+    };
 ...
-- 
2.46.0


