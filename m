Return-Path: <linux-kernel+bounces-238175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A042924671
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F6E281AFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC41BF31D;
	Tue,  2 Jul 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MMQfxXhx"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FA1C004C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941653; cv=none; b=sxuDsBzcKYLBK1WBJMLxE9v1qXAY/E1hdIJ3nDmy/UCxb7O4uUb9zWtYv1PmVsgjZDI+1ZKdfF7vPqda2SeyCqAWMExtGA1/vbU9rQ8w3alkaxQI2FrgH2XEfkR0V02NIP3YSRUaCRDi9EeJlRDINK7r1KPRR2XOSLwx/sQXhMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941653; c=relaxed/simple;
	bh=rhz8IsaaVIFnTZZrBz6KjBh9OTq7v6hGHb8ljoHazaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/Kf7GS9G8jRol/8KI2ZXKyIB3gmNMNkUGK4eN4B2QjFsPIhI40N8Hknu3eeh3UQaHL5Ij0JS6dvJz86rbLp2zGgLMe+miFTUS3aKwG1giYUJXqIHX3mUrs8mLoa6yxN7Z72+zQu1lsMyOzj/XgfWTouSLP1NvFJUZmcaX2RVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MMQfxXhx; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cd717ec07so5609035e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719941648; x=1720546448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4PsgI6ViSPMjJzEXz9ZwZPETs75x12HxOOvUnLBogs=;
        b=MMQfxXhxHILGpuIKp7BXBARHk67TYPEtouN+SIQNb/okU9lwCsaVwPUui8IJdSAnwq
         eELlxHmR7iXrka7txLZRSn4LI9QY+6s3uf7QoQicsEjT8zkdWIKf7Y5R3oGsWyMIhgDW
         NOdTRaM/dyhHjsDtVv6JTsl1HPbeBA5ilCvMN4hSenQ3nPqjZR9JC9Vg6fCJ+ydiR5fs
         B3Xbyskyg5ffV8ONLy1CuWbsLLm89Md/CgQ8tSxYhgl8Kocmi/9xWyMjbKkc7hiZbiss
         GjNj8dxHP2FtztI9SQLm54lmwW8KGpUbxQqnaFFHm4qMxC9EaEx5gCFD7grgZxyqYiv/
         NdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941648; x=1720546448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4PsgI6ViSPMjJzEXz9ZwZPETs75x12HxOOvUnLBogs=;
        b=g7quxWeBOYI05riV25b9z8emwdgN/E/fE8wNBwV/J4cLhD639pXHjJsgMBz/MSpWNq
         5cYcN8Q1wuZBiWa//BnnJijcZQoFVzIAOoOrTNVNiDxqCZ2BFVha9qXSiVVcQB81yfT2
         ML4no5uTYqQMCBL+EXQJvVDRB7rkIZF+SFqbnl2eBrMqEa7PYYuBIGUzSnd2JTd0YJ+e
         BDAfnswt3WnIig/ZnkKDjS649JFjFaMLglkWeJ/4JiZYFjOnzRWLg8KP1fViBXbGYfLh
         O7Wan1EB62icVky6RCVllBVPWQ1cDFgTt2DmPYaGME4uV6hdkfV7QrpaZemCXByhmaHw
         qjSw==
X-Forwarded-Encrypted: i=1; AJvYcCX0mF35y1BKrEmy04Fc3CBR4xNoYDPW2cOH65nz/Y7Iv2juZ8kYYR2mofg1vBL80eWJjBoG8hrikwqHsQlAR/4OfcbtG0axgMe2hOIC
X-Gm-Message-State: AOJu0Yw24unELo9CQJDUbBamBQRx0UwVArjuVL/VqF7OFJTtWlPzw+rK
	iKByN5rx+vBGQw/6ewzoDzlIW6412AVtaem0SmNfmUG4koHJ0+AFXdkveB87Izs=
X-Google-Smtp-Source: AGHT+IGTeGpFakXpFvB+K8s+jVCiEGTABpmrQyZUGoo7/gqdCCvxwaVwIzDm28ZLP34Gl/f3b2j9yQ==
X-Received: by 2002:a05:6512:3c9f:b0:52e:7a8c:35a0 with SMTP id 2adb3069b0e04-52e82651c44mr7961021e87.7.1719941648256;
        Tue, 02 Jul 2024 10:34:08 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af59732sm207594485e9.11.2024.07.02.10.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:34:07 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 02 Jul 2024 17:34:07 +0000
Subject: [PATCH v3 3/8] dt-bindings: iio: adc: adi,ad7606: add supply
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-cleanup-ad7606-v3-3-57fd02a4e2aa@baylibre.com>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
In-Reply-To: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0

Add voltage supplies

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 76fd6df5f9ca..bb716182db63 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -35,6 +35,15 @@ properties:
 
   avcc-supply: true
 
+  vdrive-supply:
+    description:
+      Determines the voltage level at which the interface logic pins will
+      operate.
+
+  refin-supply:
+    description:
+      The voltage supply for optional external reference voltage.
+
   interrupts:
     description:
       The BUSY pin falling edge indicates that the conversion is over, and thus
@@ -106,6 +115,7 @@ required:
   - reg
   - spi-cpha
   - avcc-supply
+  - vdrive-supply
   - interrupts
   - adi,conversion-start-gpios
 
@@ -130,6 +140,7 @@ examples:
             spi-cpha;
 
             avcc-supply = <&adc_vref>;
+            vdrive-supply = <&vdd_supply>;
 
             interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio>;

-- 
2.34.1


