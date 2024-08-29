Return-Path: <linux-kernel+bounces-306849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A9964491
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63891B214A0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364071ABEC3;
	Thu, 29 Aug 2024 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2V+wQm2z"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323641991B5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934800; cv=none; b=VNssarLUnHtO6alEQxnHL6TIKbKwNooSHt+rEaetekGASJIJmyt2NEk0sArKazkgrY4fpJ+woj0RJL4GHmnW/O/OxJuLr1krA8pItpmTXQKLI8x+7J+0ANzCURIhOnHyqRNby04A2UunXFr3MRy6J/J0+8jztxJ8m+dp2wpC+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934800; c=relaxed/simple;
	bh=E1ArSvYWlEKg2mj8U4mUHAOngGGn/icyww8fVMtpx+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzThKsyi8tNZ2uUuwNAN9STkUGsBu3zPrK5Ol9KqSbCNKS4BCTK4spgUef42r3zqPUTeTde0JTyX5RirGh92kOiAChzIcWAAlEVg1cPWeiwDJ3cX2aQnxyekEWow9+rXdlv79jjT46eiph5eB7v8m3Fodg4goiLqEk1/gRINFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2V+wQm2z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso370580f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724934796; x=1725539596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSbzKoZMSzlZLqSuQFsdX/6ISDzmO2lC8VpPGyPhuxI=;
        b=2V+wQm2zT6gV+I9dc2MhicjZTAz2TUjFB4pxuBfiTF4hTg2I65pvfNTd5SGsTuosVo
         FRRaWovJrAiDEXc/Qdmtei8CVQHOc7hZOarKFxkSS72CQbQKarQeHA6dOq6xSxab8cOV
         3O/5gEaqoP5p9frAI9eFEbzReoG62eoi7KLEMDO08izTAjBM7BCtCtqY0/Rnzo8R8Gtg
         5uj6bDDgegh6OpVPhV14hQr+eroPwANtNBLculJ70Q9o17U5pN1uUhnWVjz1qKotOEmI
         mYvoiUeyo2vuC8ZTwN4qHQ54qSCSqgb4DZi3jfqMyO3Pxg04P02I/mSoGbDv/29pmDqV
         YhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934796; x=1725539596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSbzKoZMSzlZLqSuQFsdX/6ISDzmO2lC8VpPGyPhuxI=;
        b=nvPOSAWCmBoN2Isc+cEY41JGNE3o9IPXyIlEhzLl3Lwkq10Rb/OxaPA5Md5PGWxVD3
         EV2so3Y/JqMj0oP4P8ffVrRUVTF5cHPADpI8dDVQ5SsVE8Iq4GLoaTlU78UtnCcg3cwj
         56FPJMEDW1OZujMWF71mRTySOvIVuE4lzi/1Wk3uZ0VLCzp3ws2sB0ZHPSNqqyFtADPf
         6FqdU1q1To8AEJOm6A3swqZ0SD04ru9660ZSNcANl9eu3HPnXTd/3+LCztPRJoyGdbyc
         OpzWHMAYOMUcUc12WREr5uhngbFmi79Hru7ATyQ9/LmGHn/o4luY+OJOKrcJ1mwSI5P7
         744A==
X-Forwarded-Encrypted: i=1; AJvYcCU8y+jh3dsY9IsqgQnWuRKAUokmgFQ6jJUpJfWFwXIViHTG/VyAMLufWkrFP1L/gV09T/LWnINityzK8CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrDjf8KuypHrO49pSAkE4/sue8E1eK2ZDdzt6tKEw2Eh5opR2
	qTjUOBqnCL8IJyrXGwM9cZHAzJoe6MQXw55hHK2dy7NrSJK8R2JNyBInfVJ0HH2hJFiSbvErV58
	Z
X-Google-Smtp-Source: AGHT+IGdX+6BPRfUeoPV/k4K2aySBQ9Gqbyh0fWcL2k663Xqq0qtlZFTMJAWVJqZU/yqDbbxq9Fvzg==
X-Received: by 2002:a05:6000:8e:b0:360:7812:6abc with SMTP id ffacd0b85a97d-3749b5890ecmr1729426f8f.60.1724934795974;
        Thu, 29 Aug 2024 05:33:15 -0700 (PDT)
Received: from [127.0.1.1] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9978bsm1315042f8f.49.2024.08.29.05.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:33:15 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 29 Aug 2024 14:31:59 +0200
Subject: [PATCH RFC 1/8] dt-bindings: iio: dac: ad3552r: add io-backend
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-wip-bl-ad3552r-axi-v0-v1-1-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

There is a version AXI DAC IP block (for FPGAs) that provides
a physical bus for AD3552R and similar chips. This can be used
instead of a typical SPI controller to be able to use the chip
in ways that typical SPI controllers are not capable of.

The binding is modified so that either the device is a SPI
peripheral or it uses an io-backend.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 39 ++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index fc8b97f82077..1874486229ad 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -60,12 +60,34 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3]
 
+  io-backends:
+    description: The iio backend reference.
+      An example backend can be found at
+        https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
   '#size-cells':
     const: 0
 
+if:
+  required:
+    - reg
+
+then:
+  $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  properties:
+    io-backends: false
+
+  required: [ spi-max-frequency ]
+
+else:
+  required:
+    - io-backends
+
 patternProperties:
   "^channel@([0-1])$":
     type: object
@@ -207,8 +229,6 @@ allOf:
 
 required:
   - compatible
-  - reg
-  - spi-max-frequency
 
 additionalProperties: false
 
@@ -238,4 +258,19 @@ examples:
             };
         };
     };
+
+  - |
+    fpga_axi {
+        ad3552r {
+            compatible = "adi,ad3552r";
+            reset-gpios = <&gpio0 92 1>;
+            io-backends = <&backend>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                adi,output-range-microvolt = <(-5000000) (5000000)>;
+            };
+        };
+    };
 ...

-- 
2.45.0.rc1


