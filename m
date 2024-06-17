Return-Path: <linux-kernel+bounces-217626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1290B24C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBCC1F21846
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426031C2301;
	Mon, 17 Jun 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dzifrHqA"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7091C0DD1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632217; cv=none; b=jgL0RpG3w52+9Ui3c0KxQTD/J/fz6AUi6lgVvxTZSdq0fWqA0mpG3kogmeGOJydKrBl8p/o6VwyXSd4/T/VNPKnk+AEcl9wgKRfKK3XCQSEs2zUoUNyzreqQwEzrMApoNii9otLwrVWcExNsEkdZsdYmUiPT+RhdjEmbzp5plWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632217; c=relaxed/simple;
	bh=fzPzUYcNz9V2ID3qrrApafMZGiDVZpy6ghrI0nU92Lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gr5cjXQb0zjDHvzXd6uoZmJlibASta4KP2mPT4e4mflBtjBEjr5YtcbInF54Gn9flAYLA6czG7jc7e8vhQ00r7ZgHlH7cgQZPgdn8ZWWN5A49iy57nCGN3txIEMxwUKb88qGAQb+odrxnO1Je83oZ0qDmDWvUGG+aS/TXRBfEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dzifrHqA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7955e1bf5f8so275142885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632215; x=1719237015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyaMuqBhP7o7wmqZwNnsnkbTtRp5AugJ4lcsefsATFM=;
        b=dzifrHqARGpGfebqYePD4sZTzikv72YPKBP2AeazQ5HPYDt9gNrqKHrvgA7wgvKTcF
         42SrehdpKxWyz4hf05fUqqExZF4dEFDmxRYmg4nvpmwdah2gZHL/JclvwaXxlewlOCyo
         c/BEHI+OSNSUTuamI3LOVhxPCmoh25zfufx8s7Jl2m6gJjRiYN+q5GYtHtFkz50+Fw/o
         13nm/a1f5Pu1YMFL1Ynp5emxpFm3hh0tL8Avk2LcOR4kfLIyMKZIdH21BtutmTkc8d8K
         FkR4Cqhjmtx4BpRM0xSgQaAPUdWR3QmhTzG2Y4alrkNho2MGRguFte4daMyTk986HO3P
         /3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632215; x=1719237015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyaMuqBhP7o7wmqZwNnsnkbTtRp5AugJ4lcsefsATFM=;
        b=B8tI8iCwzP/a1PzqEhICtlZjegLY+rJheynndyJk3DgV+Zsbz5WTbv4HggB3MILRhs
         YVBhZHrroo1Tc8yjZ2wWmo1gONl/Pu/Fi0CH0BDoyppD/dItD7De2gow6x11yUKKs/Mb
         wOafDtyo+QiD6EeuY6lxHv6H6Ilap/ufV1EfYeBr+GuQELAZxsV8XH5jT/L3DTCTBKSG
         A75pBsGcXXUhZZj0bPxM6+k52AIEfJIH4D3bKIUkX4wV+n/TTuo8WXe1P8mPMwldPDoU
         EQ6RrNOYkALZ0K1uPZKFYXDsKAZAbWixLXEX32KtWgHoIBdrqdWWGk8QEBoCdEaVJFeF
         6hNA==
X-Forwarded-Encrypted: i=1; AJvYcCVTY6hbtSMIH/YPlHsTrnPUm6UT/OiJtOh2CokVR0bTRGf8vRmgyWNGH/oNtxYmOmyeygJHvp+ncgFDzBPTTdQDm/zFzrSxuC2BZQwk
X-Gm-Message-State: AOJu0YygAeDcgYoDFu2urQn25hgcnUVqMbGgmYMnjCfMd8hfi0DNcaLU
	q+/BAk5Ep2BAUX5Tch1rLRydw4U52iTmu23Y6oj1cIwC7zs442FTfNeF2N8F3wE=
X-Google-Smtp-Source: AGHT+IG9rvLxXHys5yM3fiDf+G14AWJNmGoLIu5wSpeGGOXNzHBF3wjPuE24N3ncETdlUUNQNA6oSA==
X-Received: by 2002:a05:620a:45aa:b0:795:4e64:dbbe with SMTP id af79cd13be357-798d1f824a7mr1191474185a.0.1718632214915;
        Mon, 17 Jun 2024 06:50:14 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:14 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:54 -0400
Subject: [PATCH v3 14/41] iio: adc: mp2629_adc: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-14-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.13.0

Instead of using regmap_update_bits() and passing the mask twice, use
regmap_set_bits().

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/mp2629_adc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
index 7c66c2cd5be2..5f672765d4a2 100644
--- a/drivers/iio/adc/mp2629_adc.c
+++ b/drivers/iio/adc/mp2629_adc.c
@@ -131,9 +131,8 @@ static int mp2629_adc_probe(struct platform_device *pdev)
 	info->dev = dev;
 	platform_set_drvdata(pdev, indio_dev);
 
-	ret = regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-				MP2629_ADC_START | MP2629_ADC_CONTINUOUS,
-				MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
+	ret = regmap_set_bits(info->regmap, MP2629_REG_ADC_CTRL,
+			      MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
 	if (ret) {
 		dev_err(dev, "adc enable fail: %d\n", ret);
 		return ret;
@@ -163,10 +162,9 @@ static int mp2629_adc_probe(struct platform_device *pdev)
 	iio_map_array_unregister(indio_dev);
 
 fail_disable:
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_CONTINUOUS, 0);
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_START, 0);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL,
+			  MP2629_ADC_CONTINUOUS);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL, MP2629_ADC_START);
 
 	return ret;
 }
@@ -180,10 +178,9 @@ static void mp2629_adc_remove(struct platform_device *pdev)
 
 	iio_map_array_unregister(indio_dev);
 
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_CONTINUOUS, 0);
-	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
-					 MP2629_ADC_START, 0);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL,
+			  MP2629_ADC_CONTINUOUS);
+	regmap_clear_bits(info->regmap, MP2629_REG_ADC_CTRL, MP2629_ADC_START);
 }
 
 static const struct of_device_id mp2629_adc_of_match[] = {

-- 
2.45.2


