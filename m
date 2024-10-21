Return-Path: <linux-kernel+bounces-374036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674729A60F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5D51C21D24
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8701E503D;
	Mon, 21 Oct 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yfZTi2vg"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8C1E3DF0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504819; cv=none; b=MFQIDxdiFoUxc6MfLGySKQ6f8pKZ3GO9QjO90exz4JjIDWzD1jN9u9k0dKGK/pL0JaQfQpdOayQHNr4veUIDV6cJ85khHmP9sIdI2Vd2MIJrkX75sV2+Bj6PjNyvjKOWgXNw1USBKRYLTtK7tifRS/RAseHNUS4aiQFmq9tCHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504819; c=relaxed/simple;
	bh=pYKC/ozJRXt9qviKAsjryDj3zz5bmMLUYM6HFMi7wgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSp6rJ61wMEtEi5if2SJ9vikPIWfYqQ9olU3IB/ap9gO7OdGBQKIeZ+EYzhI41H8OikxunRojJD8oDzjrHpg+QNQl0mqLW4HJ5E4XpEj+axncO4SDz7yY3gS3kacq2CUj/qfTNaRbWO0kAzyMzh9m7zDxExCYKS/e7zEqGf0jY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yfZTi2vg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so40235525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729504814; x=1730109614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+XglmH5KouUUXSHvhgqKk4QMj3dNVGqrGai6OpWZdk=;
        b=yfZTi2vgGqwBnL66haofJ6552JOLp4dddX2tJ/nsswjUecpwdtWtx3M+CxQI9iKE+D
         2UZy/Fcb2anQiYt/LX+sKbOJW2+EtlfIgOnDiSXH5MeA5swUKn5jNc8gkCdvBwmxD9O/
         +gEVP/kZH3YOGMvTcl49OyfIJgzLq1FRnF2BeGWgjc9X3v/XSoTQUqMLBzAwoJTTNFca
         oSJd7770rqqBXNQXMrjdp3ra/9rLjEAL416qoNDwy4osDhyzm9tnv08G3AKp9zWrS+Uo
         wFa8RuG0m4r/fEc+nFq5Xzn6yJEb3rWhGv+YQxdfg7/UI+7wVqNnfRgJ+Mku37NFvcBJ
         Eb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504814; x=1730109614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+XglmH5KouUUXSHvhgqKk4QMj3dNVGqrGai6OpWZdk=;
        b=HFLk5ubtcu/YghODC/VCX8OKkHU6gGVEXGrFTRJll9qx4MhE2AP24SdqEAvpfpu92x
         N9IjOhnRoPdlvDblmqGOwNdXZScurMPV4YlQbj+Nbw9VmB00VvctOJLD/4JVWSfSI4xz
         bpPuWAC/xupItrD70KtvQKAZ/c2VPQVxuUPyB4pd8tD5XyC9+VUPjVg4/Cst2gla9zaJ
         KJu6S4rH6QvCrzbOzNLMfN0GfI2/VnyH194dnWjQ9TNMwzlvsdLZB1stXCPnBrKE4mN+
         oPO9Mk6NIFN2iJZMmo91KaEW5MCd9HTCZayld587HRjxGRScStAgQjQZaQCdEc09s4A7
         By/g==
X-Forwarded-Encrypted: i=1; AJvYcCXboxWebIlxSyVrSd969j1iOqtkethY8inmK1oDhqtR72axxs5i/x8/55eY9vpFxM9rCZ0FkR1K8mEX4FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpWGp860UjBeg+hidL0G/0mvrSoMXmn3qbHBKp9A0CVGdQN/vD
	kU/eGUp16KbfbEoo9mhhTwqiI33LHdEi7W+Wbjfj93T05a7yA9TExaCOd/y0Eao=
X-Google-Smtp-Source: AGHT+IFaxOJUQtTdaIO9at2lQQ/ZakRe9JJUO3BStAxciPjCyTaiExJ2MiGvvhZ2SyDu1aqK8ba/Ew==
X-Received: by 2002:a05:600c:3151:b0:42c:b55f:f7c with SMTP id 5b1f17b1804b1-4316165c311mr89344365e9.15.1729504814071;
        Mon, 21 Oct 2024 03:00:14 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58bbaasm52375995e9.23.2024.10.21.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:00:13 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 21 Oct 2024 12:00:10 +0200
Subject: [PATCH v2 2/5] iio: adc: ad7380: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-ad7380-fix-supplies-v2-2-2ca551b3352a@baylibre.com>
References: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
In-Reply-To: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
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
X-Mailer: b4 0.14.2

Use devm_regulator_get_enable_read_voltage() to simplify the code.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 81 +++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e8bddfb0d07dbcf3e2a43344a4e0516f4d617548..e033c734191143a25a490b09c730dbf95f796737 100644
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
2.47.0


