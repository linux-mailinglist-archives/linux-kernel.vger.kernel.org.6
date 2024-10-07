Return-Path: <linux-kernel+bounces-353729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880D9931E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276BD284D30
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8421DB546;
	Mon,  7 Oct 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eJaEAqQx"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF71DA2EC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315952; cv=none; b=BsHGZYPyEE055YA1iGv0MiOy1FHR7j2T1XidAJjHwHp8Oyj2PmyoqpxNNPlmCBJeE3N5E6F8yD4GYLiLn1bLt4TVMJqTffXsxGb3IpKyZC8pnSk37B7e4hTbcVLKjY4b2ehk3P3/4Rsj4kG6ORXUKSuqWkTXBWFYDez6tdn1ISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315952; c=relaxed/simple;
	bh=q8KqD3xvy2JB31/JkGiCsf/G4hyDPCkvTc5DXzMR1io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kv7DKQE7bCPa97i4MKIfQwQ5aP++CpowJsJ6RnZcghLmG1Rsej/JoZ9fXII4+acJW/ZuRd+Gy3dRAErxJ5s0XfE1hGeLakZhUmwosEdRuhg/jwRMACS/GMVdw4liW0Z65bldleuSvzz8f9vcQJZZN0+WuGUoM3ae/AvSDYwxhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eJaEAqQx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cc8782869so47206575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728315948; x=1728920748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBooASvX/VhONc8SVPbZTST7U3LP08CxQ9THiZxZyXI=;
        b=eJaEAqQx9B+3wkIQFSHkrviad+CedfXa5/DdpivmhV29roXUa+8iBGef4HGIVWj1QN
         ZW3GGN/xR3Q27/97+UW8sxJVag1AZfLy0iC/0/P72qIJxLKNqhrBVEGvuUaVgIHGNyyU
         wwThv2F9oKGcwYCfMmVbV10FyjwssdEyLnXhprjvkX3dstgd2E9ZiUlfKQuyjRwcsG3V
         q0+nyJ+mF9G1DdwBlULkhnrbpV4bCJYxGK70I+b9pA1prH9Z+G6OFMbmfWbdDLsuxaWV
         7/cIMdnDi34Xug2dY9V0WQvW61z8apqy20vrfXkyBhw4bZPtJMvheHE/XaaWEU/QrJkV
         syLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315948; x=1728920748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBooASvX/VhONc8SVPbZTST7U3LP08CxQ9THiZxZyXI=;
        b=dr3lt38CAJQjLq4eS04gfduGvFA7Jx4auFx1HJUJCqqmSkATFvYUPEVbqHTa71z3y7
         Plry29ndNVO8p//gje2Zfq3KW7KFPf4SzNMp2mVNQfQS++LX66XVhMCnhgULj+rsf01e
         pKEm7EGPNS7RE5ytYzTn+MWoaZ+y3mIsc0C4BXtZGrMTXRsdFgOEFPBn/dlcYrxbGkWV
         /CE54oW1kGeoZn2Rmgll3n7uLbHgYX1ig/E6rRgrv0MVaxyPSGU6MBs42gzLGeESWlh9
         EtP76gvDHowQXSwglF8maLXp+lMZHhquM8zQXrU8NRdtF4C6itrpSp8nj6dnM9gPy/ML
         gwuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH7yBxmCUa1F1Vp8qTm68NmClix3zjarcaTJg4IFHFRqhugsFgIJlFBmLXym9RXA+wrThH0WDABGhlju0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLSLd2oD7qiQhL/2iXBlAk/ucR+YjqcwlWiLz5JHwoy4IjBSC
	Mv3jI2gVmKdlQXH7oE6+ffNbVqxfd5VAU9glzdCu1Fu87mrYgg7IOyUiF0r6/Fc=
X-Google-Smtp-Source: AGHT+IGzR/XAzO+8nh4PcjEIF8gxwoLfd/vK0h/EkHNVg0wwMym23yIX71BMk+Xqn5FNmz5gdvvAXg==
X-Received: by 2002:a05:600c:19d2:b0:42c:bae0:f066 with SMTP id 5b1f17b1804b1-42f85aa72f6mr91413065e9.13.1728315948108;
        Mon, 07 Oct 2024 08:45:48 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm17645555e9.20.2024.10.07.08.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:45:47 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 07 Oct 2024 17:45:48 +0200
Subject: [PATCH 5/6] iio: adc: ad7380: fix supplies for ad7380-4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-ad7380-fix-supplies-v1-5-badcf813c9b9@baylibre.com>
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
In-Reply-To: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.1

ad7380-4 is the only device in the family that does not have an internal
reference. It uses "refin" as a required external reference.
All other devices in the family use "refio"" as an optional external
reference.

Fixes: 737413da8704 ("iio: adc: ad7380: add support for ad738x-4 4 channels variants")
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 9ef44b605144..e9784769baa9 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -89,6 +89,7 @@ struct ad7380_chip_info {
 	bool has_mux;
 	const char * const *supplies;
 	unsigned int num_supplies;
+	bool external_ref_only;
 	const char * const *vcm_supplies;
 	unsigned int num_vcm_supplies;
 	const unsigned long *available_scan_masks;
@@ -431,6 +432,7 @@ static const struct ad7380_chip_info ad7380_4_chip_info = {
 	.num_simult_channels = 4,
 	.supplies = ad7380_supplies,
 	.num_supplies = ARRAY_SIZE(ad7380_supplies),
+	.external_ref_only = true,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -1047,17 +1049,31 @@ static int ad7380_probe(struct spi_device *spi)
 				     "Failed to enable power supplies\n");
 	msleep(T_POWERUP_MS);
 
-	/*
-	 * If there is no REFIO supply, then it means that we are using
-	 * the internal 2.5V reference, otherwise REFIO is reference voltage.
-	 */
-	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refio");
-	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(&spi->dev, ret,
-				     "Failed to get refio regulator\n");
+	if (st->chip_info->external_ref_only) {
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev,
+							     "refin");
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get refin regulator\n");
+
+		st->vref_mv = ret / 1000;
 
-	external_ref_en = ret != -ENODEV;
-	st->vref_mv = external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
+		/* these chips don't have a register bit for this */
+		external_ref_en = false;
+	} else {
+		/*
+		 * If there is no REFIO supply, then it means that we are using
+		 * the internal reference, otherwise REFIO is reference voltage.
+		 */
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev,
+							     "refio");
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get refio regulator\n");
+
+		external_ref_en = ret != -ENODEV;
+		st->vref_mv = external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
+	}
 
 	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
 		return dev_err_probe(&spi->dev, -EINVAL,

-- 
2.46.0


