Return-Path: <linux-kernel+bounces-192519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841A08D1E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA95284604
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF3916FF58;
	Tue, 28 May 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UhPH2/vQ"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F916F85C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906043; cv=none; b=ok2GMFypzP4sRuU3cAQDi5SYLoKWrNwkxZlkGp33ik14/7K3tdBmr+GiiaMr/2rW4Ic2Z9OGIrAatKOIt9/xybTSF+J6uENbidRugvkMCBe7pWmjDp66SVet5SZZaOX8doJhCwE9+9DoW+tKwsf+Tu22BtqFlb7xoTr/ZRACRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906043; c=relaxed/simple;
	bh=OB8tgBWPkNRhkYwIg+R2Ji0Wb3SGKEyVa27sOqMTYcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QPUUOrjWTh8DHRQT/KmK71/diMlTuaDQY/z7E+dIJBQ1Xy34AGT5O/xnVivfqbeDS60Cvl27X9rOkEXcCSz6SetaRlpZCYul+PH1bKz7vto8JgRpamAbcLpshX/In7tUvmj3ov2zEEm3HfpnET14twwKoOypDJrv4B2zTx8Ykxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UhPH2/vQ; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-35a264cb831so661430f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716906040; x=1717510840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJ8CU1KsZdsOI/zOnwTeILM7ZuUE9hyEpMnwtAluPZE=;
        b=UhPH2/vQp+mzJVOuIJ33iOT2zdFUCVU3TqxIu95+RkE9nuh+IBQAaMnF2AEvsRMCwu
         sCf7qmeF+NnuKADuY9xUK1oPq++Q3FSR1L1hunl+5GPCunikHHHmF42sEUQhiaqaCnyk
         hol4W5pH1Tir1xZ5rRieb5os8v/ThlREy9fGY73u3h4EOCGLdoi09Tqvmw6P7NbCW42a
         QO8Cf2Tf+Afxl1Bnv9jzgXQ6CmeyAu9d2MFx6YB/nbuLSpUDe+duJLtKLgc3NSNUshdu
         BKia69aH643yX4/7yJffsQgLONknlaqmvaGS7JrCtRFNG5oDYrYQBkizspBstqpOcDcQ
         HeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906040; x=1717510840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ8CU1KsZdsOI/zOnwTeILM7ZuUE9hyEpMnwtAluPZE=;
        b=fHsXrxAgMLAFmphtOeXMD/HQWLZCjLiAjxcfoWMoJrtF0hX6cLYQ3ehLzzHOm/ON4C
         8kRc/czh/RujCwsexH5kkzMRVr0SSoQD8KRWiu7D2E22f4cMbTsAJ2wS/QpNywe0aEnB
         cKUg5ZEyHNg98vYdYUS1Vv8LbefAabTB2By0qA2WcmbmMakhn8jAs5NU3UdNWrFvtN5r
         mcFT7zEyC/cQr3+EH96JBM44gblqNCZJ8Ta+r9UI06ueUTWbrrUMi9fICxv/0bTTU0FS
         LxqBDSQrZ2G+Atjk/lkJh11dWju3QAfdPGkzQOtJDe9UT8dptcxyY16gC5+MZGTL85yk
         1tdw==
X-Forwarded-Encrypted: i=1; AJvYcCWIOcRRdSYucz5p0jH4syt3du1enCPNFeq0cyECeeHla9ujKnCK7BkbeplbjRLY5I+ApdVUMmEMu6IHKsMJsg0+C+C+6zojDPvGC6l3
X-Gm-Message-State: AOJu0YwIQE/DpXXPOaqWC9h7OaK83Wf2DBc4XeFCzqmbNCB+BKqi2pEG
	XB7foot1p+nfdjl5WeFeuQx+lV8xLaHRn15m2Lyl5sTfsXcjigCHK1sYdawOhVM=
X-Google-Smtp-Source: AGHT+IFQYAZ2c7lzfDXVd6AmpmI0ICuN9BqtJxijv8ZHyENpbP62R1LSn0FAhBPpQ2Y9D2RZBK10Ug==
X-Received: by 2002:a05:6000:248:b0:34d:b605:ec68 with SMTP id ffacd0b85a97d-35526c37d2emr9720315f8f.17.1716906039881;
        Tue, 28 May 2024 07:20:39 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db5esm11999275f8f.15.2024.05.28.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:20:39 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 May 2024 16:20:30 +0200
Subject: [PATCH v7 3/7] dt-bindings: iio: adc: ad7380: add
 pseudo-differential parts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-adding-new-ad738x-driver-v7-3-4cd70a4c12c8@baylibre.com>
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

From: David Lechner <dlechner@baylibre.com>

Adding AD7383 and AD7384 compatible parts that are pseudo-differential.

Pseudo-differential require common mode voltage supplies, so add them
conditionally

Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index 5e1ee0ebe0a2..de3d28a021ae 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -13,6 +13,8 @@ maintainers:
 description: |
   * https://www.analog.com/en/products/ad7380.html
   * https://www.analog.com/en/products/ad7381.html
+  * https://www.analog.com/en/products/ad7383.html
+  * https://www.analog.com/en/products/ad7384.html
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
 
@@ -21,6 +23,8 @@ properties:
     enum:
       - adi,ad7380
       - adi,ad7381
+      - adi,ad7383
+      - adi,ad7384
 
   reg:
     maxItems: 1
@@ -42,6 +46,16 @@ properties:
       A 2.5V to 3.3V supply for the external reference voltage. When omitted,
       the internal 2.5V reference is used.
 
+  aina-supply:
+    description:
+      The common mode voltage supply for the AINA- pin on pseudo-differential
+      chips.
+
+  ainb-supply:
+    description:
+      The common mode voltage supply for the AINB- pin on pseudo-differential
+      chips.
+
   interrupts:
     description:
       When the device is using 1-wire mode, this property is used to optionally
@@ -56,6 +70,24 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  # pseudo-differential chips require common mode voltage supplies,
+  # true differential chips don't use them
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7383
+            - adi,ad7384
+    then:
+      required:
+        - aina-supply
+        - ainb-supply
+    else:
+      properties:
+        aina-supply: false
+        ainb-supply: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.44.0


