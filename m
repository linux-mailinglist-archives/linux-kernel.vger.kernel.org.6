Return-Path: <linux-kernel+bounces-353727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686A9931D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07980281AC3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ECC1DB342;
	Mon,  7 Oct 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SA5fZRQ2"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164171D9A41
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315951; cv=none; b=r5UP7LX0X4PH34KWsEtZ4nJoBn9DDh9tdzkMyKdWTlias01Fte6Co7FX1mwZIdOiZ8hcUVnfMG5uh4mmAe82dvlMkHHsFCJgvN3qQRv1uDNZbzW6Se3FZcaLZWSIyp1sQCcFGMQMTHuJGkIGfheBLrzr0NfeFzutx8JGtI/cuvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315951; c=relaxed/simple;
	bh=/xxwZo5C8/nVz11iyUg86EeL3sGiVKVX2JIuqDL31Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/7NgC+3kf40bptRYGGy1d+CwJKQ4e59I8fECQF60/zwarspyfTZmxnA64v7GN6CnbgGNgS72cr/IvQwoy02yXYQwZT1GMIvqfnfHRahLHXL8VSJa+JtxOzE6kdFBnuUOLs8QDz9AQbszlikJGoxbr5S3UcOhNfneZjYvt+BmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SA5fZRQ2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cdbdbbb1cso2204764f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728315947; x=1728920747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+J8/8VA7c7eBg0Ye/jffG94ic0MjnIN71uk3VMwhqv4=;
        b=SA5fZRQ2KX4s+RiSL5+PVxI9XNuxug3mvplaQtp1i/07JCRBxIusq/itLorJ+rrmm8
         Jcj3sSuClBo62+pJMwJ1I5JWnl30k8iH88eV1jdyfCRMedBeag4UooUNfufJtC5UGJjY
         PVh14lwrkE7rdIMXtxNyikOv/9bEX46H+sSW9joH5dOPGayXHeokuO2uaeQr6r6eLs9l
         Mx7v9FZT0orZVKhUI/VB+ySO3wMvU4sdmzMF9P3ONW8SyRVBr51LDz/eR2bpBvGoD54X
         t4j+kP97TlaX65977XNEzrso8vIIqfNO5gpR0Xqz9/BVRQM15Kb3zSXr9UasEg3y1IZs
         zXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315947; x=1728920747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+J8/8VA7c7eBg0Ye/jffG94ic0MjnIN71uk3VMwhqv4=;
        b=Eb3RNtGiWKZ8OmCVa8GY5zhcOTfm9v0Ae48R3zZi/YbjdgUxG73YjITDWMLjJ/iLWI
         LILJPBXBaEPJKSUpIL8xf5v7/Q0Xe1WjrqVXWYqXsEjraKjWyANNqRbESeUP13JKvGtc
         K+46D9uZxN90X4+9pnlFrOTzG5q+dh2s3UJ60+MiTxRj6LXThm4D42itOBmprIaw1eYh
         ekZbI+onkt9yZG0/TTe4fbzgLAXTuGMpsSLgB0ERECr+ZWfUwbBixlABowPytMBDOSuz
         6DyfotnTC8fy84bA5bSXpzNyME0sNpRjD4YjB6J8sf/0b0FvxH6KVuBG0doCtKOt2hi8
         qBig==
X-Forwarded-Encrypted: i=1; AJvYcCVCB3ILDjrT317RWpDcqOTa45BVSwuRMvMzGbXbeJFH13KvgSxOTD+q+W8Jn0ETjcA+K5Fk9el/cqh8crI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzykTzcMZKryRQVHo4k5QkByL/GY1Ew5rSG9lXlKFDAgTdam8/O
	9k5dHiQ7SOcvs+0wU1atdvpO+yZcqms6qUmfcEVbEL26Sb79jYTuJo9B9GvxxR0=
X-Google-Smtp-Source: AGHT+IHcMijELPdRgJ4lenJP6V++xHnlGtHjjqK7+ZVhhmdKm/XvBxcuF4H9F3gGxbl2pQan2F6DJA==
X-Received: by 2002:a5d:6e53:0:b0:37c:cd59:5a6b with SMTP id ffacd0b85a97d-37d0e73670bmr6997259f8f.27.1728315946749;
        Mon, 07 Oct 2024 08:45:46 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm17645555e9.20.2024.10.07.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:45:46 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 07 Oct 2024 17:45:46 +0200
Subject: [PATCH 3/6] iio: adc: ad7380: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-ad7380-fix-supplies-v1-3-badcf813c9b9@baylibre.com>
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

Use devm_regulator_get_enable_read_voltage() to simplify the code.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 81 +++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e8bddfb0d07d..e033c7341911 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -956,7 +956,7 @@ static const struct iio_info ad7380_info = {
 	.debugfs_reg_access = &ad7380_debugfs_reg_access,
 };
 
-static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
+static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 {
 	int ret;
 
@@ -968,13 +968,13 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 	if (ret < 0)
 		return ret;
 
-	/* select internal or external reference voltage */
-	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
-				 AD7380_CONFIG1_REFSEL,
-				 FIELD_PREP(AD7380_CONFIG1_REFSEL,
-					    vref ? 1 : 0));
-	if (ret < 0)
-		return ret;
+	if (external_ref_en) {
+		/* select external reference voltage */
+		ret = regmap_set_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
+				      AD7380_CONFIG1_REFSEL);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* This is the default value after reset. */
 	st->oversampling_ratio = 1;
@@ -987,16 +987,11 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 				  FIELD_PREP(AD7380_CONFIG2_SDO, 1));
 }
 
-static void ad7380_regulator_disable(void *p)
-{
-	regulator_disable(p);
-}
-
 static int ad7380_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad7380_state *st;
-	struct regulator *vref;
+	bool external_ref_en;
 	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -1009,37 +1004,17 @@ static int ad7380_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return dev_err_probe(&spi->dev, -EINVAL, "missing match data\n");
 
-	vref = devm_regulator_get_optional(&spi->dev, "refio");
-	if (IS_ERR(vref)) {
-		if (PTR_ERR(vref) != -ENODEV)
-			return dev_err_probe(&spi->dev, PTR_ERR(vref),
-					     "Failed to get refio regulator\n");
-
-		vref = NULL;
-	}
-
 	/*
 	 * If there is no REFIO supply, then it means that we are using
 	 * the internal 2.5V reference, otherwise REFIO is reference voltage.
 	 */
-	if (vref) {
-		ret = regulator_enable(vref);
-		if (ret)
-			return ret;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refio");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to get refio regulator\n");
 
-		ret = devm_add_action_or_reset(&spi->dev,
-					       ad7380_regulator_disable, vref);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(vref);
-		if (ret < 0)
-			return ret;
-
-		st->vref_mv = ret / 1000;
-	} else {
-		st->vref_mv = AD7380_INTERNAL_REF_MV;
-	}
+	external_ref_en = ret != -ENODEV;
+	st->vref_mv = external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
 
 	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
 		return dev_err_probe(&spi->dev, -EINVAL,
@@ -1050,27 +1025,13 @@ static int ad7380_probe(struct spi_device *spi)
 	 * input pin.
 	 */
 	for (i = 0; i < st->chip_info->num_vcm_supplies; i++) {
-		struct regulator *vcm;
-
-		vcm = devm_regulator_get(&spi->dev,
-					 st->chip_info->vcm_supplies[i]);
-		if (IS_ERR(vcm))
-			return dev_err_probe(&spi->dev, PTR_ERR(vcm),
-					     "Failed to get %s regulator\n",
-					     st->chip_info->vcm_supplies[i]);
+		const char *vcm = st->chip_info->vcm_supplies[i];
 
-		ret = regulator_enable(vcm);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev,
-					       ad7380_regulator_disable, vcm);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(vcm);
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, vcm);
 		if (ret < 0)
-			return ret;
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get %s regulator\n",
+					     vcm);
 
 		st->vcm_mv[i] = ret / 1000;
 	}
@@ -1135,7 +1096,7 @@ static int ad7380_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad7380_init(st, vref);
+	ret = ad7380_init(st, external_ref_en);
 	if (ret)
 		return ret;
 

-- 
2.46.0


