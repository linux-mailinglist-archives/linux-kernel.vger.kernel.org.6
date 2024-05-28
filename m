Return-Path: <linux-kernel+bounces-192522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9538D1E75
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5BFB229D7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F031816F8F9;
	Tue, 28 May 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wFwd0Maw"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49116FF59
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906047; cv=none; b=WRq97DpU5o8ioCroKl1mGKn+sit+MvyoCqoJi5e/jPowq4OTg9B94BZN2ck1hkbyFWe78/Qm37DRxxyS+Ol9JpIQas0VzP4ucUQDAes8N37t1zJbG6dcgRxfqOPU4z6Cc+Gtu8+IO13f7zdzOBrJFetewQj29xIwdS6m7lUgCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906047; c=relaxed/simple;
	bh=VQ4RPFjraeg9QG+WtxUK0LxObNrAlrRgeIFZywlwUq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldqRqWA0RBFgjBbHveUch35DsN4W3wgwGaOztPM9caAypSDGy28ooY/FXNRtaRQeM6mKU1uldjS/R8osnt0azsDPsLVkrHK5dewV9KqxAq+FCbCtzzNXk0Zq2Zb5lhDi95jYqNlTEzSsIsjx31u2B4fSCubRPqsLi3gRlJ1BDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wFwd0Maw; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-354de97586cso1079431f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716906043; x=1717510843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7kVmMiAww/1MNzSxxAk2mzn+IJ9yIpCfeirFaQBWWao=;
        b=wFwd0Maw8rJdEgBMSEk7MsgOfZsAd3dGyixE4aEcmnTLXRfXGfuwQ3MBvl3Gms+Es+
         ifETO1YlnDHSS4qNA7DMf1uxP/VkOxN4UJpOi4GQZtaCAn7DjnjKLsWFnYP1RD2Zud0t
         1bfoYrW+W9WgxFjitMGTgunioGs7FdO4WLwY3TgWcDqDOekMAUP5tCxiBlwvZcFgzR9z
         Gql8XZfJmyR3QCmGlUWWY12j+48RWqT+umTsBykDM6ZPMx/9MTnErU6JiypyUtH0sIRi
         6xqex9hnWek1IPfrfE4w4EfMMTUO9Zf8RjZYOnF/gqomt/64+yrR3zPoeTwpBLPBS5Fr
         bR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906043; x=1717510843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kVmMiAww/1MNzSxxAk2mzn+IJ9yIpCfeirFaQBWWao=;
        b=nvC1Ifw3IcRU7yR7lVHbzf4NmIxw6zj1Pnrk7DgTiRKeysgzOAsMdaLROM3TRUOKP6
         XSHVVEom3XgZofxrz5KkSo6KeQDU1a1SkEH1LRcgHqxV4tL097Y81rPTiaWXFtOUAdWg
         YmnAGYMzV/0PdGvRId6RKaJNmUdUfyw0dWTXjSBVbTtprgFp3Nse1dGf5oj0F0N/njMC
         tyGTD1ZqV29a7T28MEHQSFV3t8VBitWo8shgEPRHiv4fbnUniKCiuNkdlP/Th+DW/44h
         QSuLr03T1yeBVX8oS6+LOpcH1ZW3Snmf4fJJYljznfpQm0tVizrzGODAGaOY8qZjXsNx
         al2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBpXj1eBkMVmeh7SNnjwfnBDQ5g7QDLSa0XSweAfki8LCgHRZt6LdcSiUVd7hYHymCL74GoOq0lndngWI6Ex7pMpJVVAeyCt6tW9cx
X-Gm-Message-State: AOJu0YywNB/M69lw8MvrNLNxniB/PaBnbeKoHC2bvipjIpZeaUVoHNLD
	wdHIbm4G28m3CV110H27NfCPdwcGaIjH2sxwXm9bbpKGMJs5U/W+06rnWIE8cjQ=
X-Google-Smtp-Source: AGHT+IFP31QoKYFXOEzwlSrrEb3FVw4HSZ2x5WtfZZWQ7ssD6CTt6H9FKMLjuILaLjqwIF9nhUApUA==
X-Received: by 2002:a5d:49cc:0:b0:354:db85:3039 with SMTP id ffacd0b85a97d-3552fe19407mr8128986f8f.44.1716906042936;
        Tue, 28 May 2024 07:20:42 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db5esm11999275f8f.15.2024.05.28.07.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:20:42 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 May 2024 16:20:33 +0200
Subject: [PATCH v7 6/7] dt-bindings: iio: adc: ad7380: add support for
 ad738x-4 4 channels variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-adding-new-ad738x-driver-v7-6-4cd70a4c12c8@baylibre.com>
References: <20240528-adding-new-ad738x-driver-v7-0-4cd70a4c12c8@baylibre.com>
In-Reply-To: <20240528-adding-new-ad738x-driver-v7-0-4cd70a4c12c8@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0

Add compatible support for ad7380/1/3/4-4 parts which are 4 channels
variants from ad7380/1/3/4

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index de3d28a021ae..899b777017ce 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -15,6 +15,10 @@ description: |
   * https://www.analog.com/en/products/ad7381.html
   * https://www.analog.com/en/products/ad7383.html
   * https://www.analog.com/en/products/ad7384.html
+  * https://www.analog.com/en/products/ad7380-4.html
+  * https://www.analog.com/en/products/ad7381-4.html
+  * https://www.analog.com/en/products/ad7383-4.html
+  * https://www.analog.com/en/products/ad7384-4.html
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -25,6 +29,10 @@ properties:
       - adi,ad7381
       - adi,ad7383
       - adi,ad7384
+      - adi,ad7380-4
+      - adi,ad7381-4
+      - adi,ad7383-4
+      - adi,ad7384-4
 
   reg:
     maxItems: 1
@@ -56,6 +64,16 @@ properties:
       The common mode voltage supply for the AINB- pin on pseudo-differential
       chips.
 
+  ainc-supply:
+    description:
+      The common mode voltage supply for the AINC- pin on pseudo-differential
+      chips.
+
+  aind-supply:
+    description:
+      The common mode voltage supply for the AIND- pin on pseudo-differential
+      chips.
+
   interrupts:
     description:
       When the device is using 1-wire mode, this property is used to optionally
@@ -79,6 +97,8 @@ allOf:
           enum:
             - adi,ad7383
             - adi,ad7384
+            - adi,ad7383-4
+            - adi,ad7384-4
     then:
       required:
         - aina-supply
@@ -87,6 +107,20 @@ allOf:
       properties:
         aina-supply: false
         ainb-supply: false
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7383-4
+            - adi,ad7384-4
+    then:
+      required:
+        - ainc-supply
+        - aind-supply
+    else:
+      properties:
+        ainc-supply: false
+        aind-supply: false
 
 examples:
   - |

-- 
2.44.0


