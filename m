Return-Path: <linux-kernel+bounces-439379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F49EAE8A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1535A18896D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD12253F3;
	Tue, 10 Dec 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QwIkiBXA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049192080C9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827610; cv=none; b=QclYtKwgtu86QaZjpfgRTPDtrSMx+iie0qHTwCPBJVaEd6cf43IZAK4Ao+LkexK/U+I90wTkXYTqHLXzlj0ck6s6XnAhufCCzPUNC9GInfUqXhNud2w75T0wgvkNcN9K7f7cJOFjC4dk3AJjgSBwmPx3wibgAUWn2MDN/ItiZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827610; c=relaxed/simple;
	bh=gjf0nQQoBWAGsVMcSFONNcDZNY/bgC7yz8ja/yiFY88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqv7UDQoAblZdqezrli6lsXrkDsb08AG3/p5SNI/QDCD+7VNY1xvpAETmb5s+AV3X1JJKP2gAnR9bf669s41llb9DCkzgUFWF15bFys1mtFwN0rJi7S6XEpzzDwJ7H8J6lqLnngIshUvMyke/0Mrm/tuO82hMdBhrdkcI2ZHB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QwIkiBXA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-432d86a3085so35677685e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827606; x=1734432406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aA58kKEUAeOZYlF3Ik612RJpFfgnSJ0uEeIZq93J8hA=;
        b=QwIkiBXA8tlKQobm7iZ67d4YXwiDGM7j2epvkN3N717Na7h2gWkCGJfeEGGs/jqYMV
         fC5YV4SQ1GP+ngszpVH7M+TJU3Yzf3E4XM2/OZYMcDHzbuTb4PMqJ4E7mqj8dO1ycEzH
         2AR+DNMcyNxVkPn5DsEntJpFoXiCoDysOsdQfSPWzKYK6Z8rPjppqBWgjP8Gj+SnrE26
         moSHrewRPzKqcrCxmqDtdF4GxlCpsOzbfq3fTo3lnjgkZCEaM8h678ePRD/eExYB1/lI
         IeAtYuH/Nyr9LRsyfjhkpaJENepjfWCZjz1BDMpUqJNW/TzN6AWZ4lhq39PozIuZIVYi
         nvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827606; x=1734432406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aA58kKEUAeOZYlF3Ik612RJpFfgnSJ0uEeIZq93J8hA=;
        b=j1ziiSed3eRMxW2M6JNWjNhUYHO0OEG4GUPRVgMZirUesOi924qLclXsfwe0IM6yHu
         ymKIS12LPIb2XYNrwmfVVvbLCKRPwOOE7A16cxWBmIwOyT+aW2hGknq6jj5w1d58Ew0D
         zWl2OZl0HEMm2ZVj1kreT5gqeliy6h5Pp20UorPMLTkKx68SFAjkJ+f8GeCD7+cPv1MO
         QMBkT0znHw0D2D7lY6kjr5eQ4A8X76VLgITICyfUZU337ICVGZipDX2TmvZmRYP+TKws
         7bzy51SanNUp7rzKWKymvxkvWW8yWwHzD4spf1rJWxr5+ZDgz1PqDY6oPCq+I2YaTZgb
         tQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCWxGsVWZ4OryL6KOCcjaUEholqQsLdioOiUIOf7XIL/AHqbps+GNO5LICaksN9x+1ObeWuGtCsUlm4H6L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJQKRI9MGoaK0Z87Ja6zn3cEno1uJ7mOj5fpaj0GyUW60tWDs
	jgvJEukSyxw4Kej7GUFTVkqH/cWLKJmKgJIb/fDQPGKGIis8oG88P7bIyQPsCGQ=
X-Gm-Gg: ASbGncup+DxvhKTDDlN9UuCek8TvSoLDZBsdI4MVojnkfgN9iJQAh8F74+fiUKmeYBZ
	zlGe9QEi3H/NOXvz8O0mbqJU7nX2r8iXnWQqyxqRdvj5UOP3yZei8P/pq0X9+kw2VODgIiuk06W
	w7ooPPvmnw3NGUm9CfTITxCM0vfrxDcCAO0tZgKRSZGGDzkKnZyhS2Mx86Oq24y2FrLeEdfOB5p
	tjxQCcKQIldyIafcBeSpCIDB+5V020sPk9854zRE66ZmwTgA6l3lLdT8e5apR8sPCPhhmGG0x2/
	JA==
X-Google-Smtp-Source: AGHT+IFbIzvkH4+2cZziFJ30qgBDduGBy+bNg0rWxUHk427hgWQmxfn4FILheE5Ie3BWtki9K5yJ5g==
X-Received: by 2002:a5d:6487:0:b0:386:3357:b4ac with SMTP id ffacd0b85a97d-386453f67dbmr2885640f8f.42.1733827606145;
        Tue, 10 Dec 2024 02:46:46 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:45 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:42 +0000
Subject: [PATCH v2 2/9] dt-bindings: iio: dac: adi-axi-adc: Add ad7606
 variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-2-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=3192;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=gjf0nQQoBWAGsVMcSFONNcDZNY/bgC7yz8ja/yiFY88=;
 b=U5uvH2PqBtYNE0NXZMnRmVR9BCGsUX1HsccQXBG+CS5RmDUX7t0FcSTM53m5/ppr2Tf/5cXZQ
 lyjeU6ik+XzAoMrbiP2qT/cNVFbV1lDDTGdghEznHJUVpMwzA5LW9SI
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

A new compatible is added to reflect the specialized version of the HDL.
We use the parallel interface to write the ADC's registers, and
accessing this interface requires to use
ADI_AXI_REG_CONFIG_RD,ADI_AXI_REG_CONFIG_WR and ADI_AXI_REG_CONFIG_CTRL
in a custom fashion.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index e1f450b80db2..6c3fc44422cc 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -17,13 +17,22 @@ description: |
   interface for the actual ADC, while this IP core will interface
   to the data-lines of the ADC and handle the streaming of data into
   memory via DMA.
+  In some cases, the AXI ADC interface is used to perform specialized
+  operation to a particular ADC, e.g access the physical bus through
+  specific registers to write ADC registers.
+  In this case, we use a different compatible whch indicates the target
+  chip(s)'s name.
+  The following IP is currently supported:
+    -axi_ad7606X: Backend for all the chips from the ad7606 family.
 
   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+  http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
 
 properties:
   compatible:
     enum:
       - adi,axi-adc-10.0.a
+      - adi,axi-ad7606x
 
   reg:
     maxItems: 1
@@ -53,6 +62,24 @@ required:
   - reg
   - clocks
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,axi-ad7606x
+    then:
+      patternProperties:
+        "^adc@[0-9a-f]+$":
+          type: object
+          properties:
+            reg:
+              maxItems: 1
+          additionalProperties: true
+          required:
+            - compatible
+            - reg
+
 additionalProperties: false
 
 examples:
@@ -65,4 +92,30 @@ examples:
         clocks = <&axi_clk>;
         #io-backend-cells = <0>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    axi-adc@44a00000 {
+        compatible = "adi,axi-ad7606x";
+        reg = <0x44a00000 0x10000>;
+        dmas = <&rx_dma 0>;
+        dma-names = "rx";
+        clocks = <&ext_clk>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adi_adc@0 {
+            compatible = "adi,ad7606b";
+            reg = <0>;
+            pwms = <&axi_pwm_gen 0 0>;
+            pwm-names = "cnvst_n";
+            avcc-supply = <&adc_vref>;
+            reset-gpios = <&gpio0 91 GPIO_ACTIVE_HIGH>;
+            standby-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
+            adi,range-gpios = <&gpio0 89 GPIO_ACTIVE_HIGH>;
+            adi,oversampling-ratio-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH
+                            &gpio0 87 GPIO_ACTIVE_HIGH
+                            &gpio0 86 GPIO_ACTIVE_HIGH>;
+            io-backends = <&iio_backend>;
+        };
+    };
 ...

-- 
2.34.1


