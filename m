Return-Path: <linux-kernel+bounces-416344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392FF9D4386
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81E6283975
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401121C9DDC;
	Wed, 20 Nov 2024 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vw1d0/In"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4B1C8317
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138450; cv=none; b=gqX9fMNAFLUrzQukCzrTkNh0XJPS+5Mr3x+RwqDtKDgyMN85itEVtzKjbNPDr2lKgjl7Fd+iiLwPvXQDflXgIAQLPLP1a0h6wmA+Xd4DQVTTZuBaynRF6yo147Z2+hk1ZjHUTxvAU8mK1jrxVaHPzGY5BN3T0BQo+B1eFAaxE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138450; c=relaxed/simple;
	bh=wQqTKAxl5O+P4WIe2Sj1MmeNWLBkM7Jg9ETyJxQb1mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G20XrEult0N3GY1ktwS4fcQwA2YAJMFhk2UCC+isWg50i0n27QrEgZtVq+yfoF+YFueWfRq/xzu7i9zZuDMMtyaA8ZncalcMX2yVkGyq7jGj0Ywo3LGl8gXQMQSO65Q+c4lIi80bTXQwPoqMyXx9Cm5WqbxrTzUGVcUOz3ospPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vw1d0/In; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2951f3af3ceso198673fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138447; x=1732743247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yNbYsdWlVja/3AQCgkcR1Uui9r2S29rAsSTHquAG0Q=;
        b=Vw1d0/InHsfUvLF3M68Bm5W3atZb1/KnZvVo+38ME/2AJm0pYUMWZDNRHYwuwaIWkO
         RKNwHKqYHgHXyAP0dn+rY6tjuXreKByw/jYh/plxMvaQKqXn0Q+Olr2pAKMLmbH7dMyu
         0cGvw7AW7RpbqhSuWz7XHeXNQYd03sAtb4IBczefk+r5Z7jJnxOVX/WKXgxQleogWYrr
         i8Gn5q3LYKQF6WMtfrJBos9cVXPTRUH8SjFeVuGtCqJOU/6q8B3iQfeCGA0xLG9eRH9B
         WrH66EF4l35a7t8HfR22VOlORDbwDxpPRYBstAiilIu/juMQK2oCEAcRhUJNjbEeUS5Q
         kLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138447; x=1732743247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yNbYsdWlVja/3AQCgkcR1Uui9r2S29rAsSTHquAG0Q=;
        b=UDqFtn/konCr5E07Rq9qKQhg/8YgVtOCjjbmvk9d7w8letphamDAUVUqMS6GcGfpLa
         3DeftkYcAr218PdIF13CDZgLIqsT+6SABYacwVHbVaHsLB6OSsloBfhipQxVoThEes3+
         PCucJRxlPLzq2CiGrMQN4rINfsphU+b/ntIJmw+akk4f6jPPPGG+kShUEPPTQZtl1z8d
         IkkwniDPjGi/vPW8Wkc8MkZRE6TOQTBOGA1lirK2drVxjmIqhd6Wyto7iMtfqxr7Z0n7
         Isz3fMKalDJihIPVG/4Gn2aFwZR3uC6cHBvqTGFMD6WZ6hsfQhWBt2LEISAZwyUd+LA7
         e8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMm+38aoc2tq+6vqzSZDYmypob9/mfeTgl11zldvuo1HH1HzI8677FQ0w7oGIAqPWtlCstZScFm+yVRZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvSA+vwmv5ODI25lhGh3zlukj0JYDiGrMheIohrMJ3z29w9ev
	wJDJ5dxqoNC6ya6c+BTYHFEuEqO6HlaYuJUT0iAskjvE4+7iM5iTSVRaYd4VdsE=
X-Google-Smtp-Source: AGHT+IGRosbHi0euPzLEM1A+4BnjkurMVpdhu51uw/buTqQP1Y4uX+GnXnQoYUZZExG+cGsnPGkI2w==
X-Received: by 2002:a05:6871:69c7:b0:287:6f4:1ac5 with SMTP id 586e51a60fabf-296d9bbe1f5mr5159861fac.20.1732138447479;
        Wed, 20 Nov 2024 13:34:07 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:06 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:28 -0600
Subject: [PATCH 05/11] iio: dac: ad7293: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-5-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

A small change in behavior here due to moving the enable to the same
place as the get: supplies now are enabled before the reset GPIO is
toggled (which is arguably the correct order).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad7293.c | 66 ++++++++----------------------------------------
 1 file changed, 11 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index 1d4032670482..58f7926ec3f3 100644
--- a/drivers/iio/dac/ad7293.c
+++ b/drivers/iio/dac/ad7293.c
@@ -141,8 +141,6 @@ struct ad7293_state {
 	/* Protect against concurrent accesses to the device, page selection and data content */
 	struct mutex lock;
 	struct gpio_desc *gpio_reset;
-	struct regulator *reg_avdd;
-	struct regulator *reg_vdrive;
 	u8 page_select;
 	u8 data[3] __aligned(IIO_DMA_MINALIGN);
 };
@@ -777,6 +775,7 @@ static int ad7293_reset(struct ad7293_state *st)
 static int ad7293_properties_parse(struct ad7293_state *st)
 {
 	struct spi_device *spi = st->spi;
+	int ret;
 
 	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
 						 GPIOD_OUT_HIGH);
@@ -784,24 +783,23 @@ static int ad7293_properties_parse(struct ad7293_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_reset),
 				     "failed to get the reset GPIO\n");
 
-	st->reg_avdd = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->reg_avdd))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->reg_avdd),
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "avdd");
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
 				     "failed to get the AVDD voltage\n");
+	if (ret > 5500000 || ret < 4500000)
+		return -EINVAL;
 
-	st->reg_vdrive = devm_regulator_get(&spi->dev, "vdrive");
-	if (IS_ERR(st->reg_vdrive))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->reg_vdrive),
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vdrive");
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
 				     "failed to get the VDRIVE voltage\n");
+	if (ret > 5500000 || ret < 1700000)
+		return -EINVAL;
 
 	return 0;
 }
 
-static void ad7293_reg_disable(void *data)
-{
-	regulator_disable(data);
-}
-
 static int ad7293_init(struct ad7293_state *st)
 {
 	int ret;
@@ -816,48 +814,6 @@ static int ad7293_init(struct ad7293_state *st)
 	if (ret)
 		return ret;
 
-	ret = regulator_enable(st->reg_avdd);
-	if (ret) {
-		dev_err(&spi->dev,
-			"Failed to enable specified AVDD Voltage!\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad7293_reg_disable,
-				       st->reg_avdd);
-	if (ret)
-		return ret;
-
-	ret = regulator_enable(st->reg_vdrive);
-	if (ret) {
-		dev_err(&spi->dev,
-			"Failed to enable specified VDRIVE Voltage!\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ad7293_reg_disable,
-				       st->reg_vdrive);
-	if (ret)
-		return ret;
-
-	ret = regulator_get_voltage(st->reg_avdd);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to read avdd regulator: %d\n", ret);
-		return ret;
-	}
-
-	if (ret > 5500000 || ret < 4500000)
-		return -EINVAL;
-
-	ret = regulator_get_voltage(st->reg_vdrive);
-	if (ret < 0) {
-		dev_err(&spi->dev,
-			"Failed to read vdrive regulator: %d\n", ret);
-		return ret;
-	}
-	if (ret > 5500000 || ret < 1700000)
-		return -EINVAL;
-
 	/* Check Chip ID */
 	ret = __ad7293_spi_read(st, AD7293_REG_DEVICE_ID, &chip_id);
 	if (ret)

-- 
2.43.0


