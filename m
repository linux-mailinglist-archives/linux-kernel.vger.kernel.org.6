Return-Path: <linux-kernel+bounces-448209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE469F3CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6431C16B8BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664351D5CD3;
	Mon, 16 Dec 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nIw4vgHd"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D71D5AC2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385451; cv=none; b=dm6IwZS6KZ5Ty2YhCIBRnzzxMSQSyGIhGaSI2XWU+jVaH/wiUmTJmY2UH3yrU49Qjn8rNls54QYf31l0b3Al5fGNHoYeH+N04TO6XQPPGqZ/ohmoPR65SLYTzrjg7PwzGpRc3Wtp1t1ioCA1DMav/XmObvWFnxC22jZUiYW6VD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385451; c=relaxed/simple;
	bh=j1KQVWyRjJzV1KqouG5kBg5gSDPoYC1JMxGnsigizCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RP02lUqAPLtfnzXxPvyI5Vio6voFATkR2lvk7/m8cbHDElQeKmcC4wOShSmHIuE5wd1A8QR20WpWxCb3Yxr2C1pC1KXSC4nk7e0AxtjSaJ00hl06WDJxGJ4x4NjL1gitwHPPRroEiWTvPYmq5PYyWmrPRmsd3S4QSnNLnolpe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nIw4vgHd; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29e61fcc3d2so3708459fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734385447; x=1734990247; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfz8Qyf8HO/uwLU4Ovm0zRhptn7NeZt8a31y9gqWbFY=;
        b=nIw4vgHd70u2ErimWbMMN98vER56lLszSr65mnKSMdpJXg5gDsHps9afEVbf9SuQLX
         L8os97Jr1ykolv7tt2Ti36AoHAE+1OBgCM5MSpMie6Mcxm+3Nk5E/9KPbAG7jH3ZyqlS
         rhO0vuYgBS/u7q33hExtH04wKBLlD01aexaUItvzz1dfk7neCUXRDZWi6TqKYrf5Hx/1
         v1qshHOWqd/s0thVK6ndtacQhSVW6vZrh+kn894BYPgnzHPOCJ2yVLbtrt2MUp1kCF7h
         9SGXZWy1Qz7fqku3wgfc7wTJgBsz08j4qfZrALsJQaQDyp3rDc8xFMYYSxo6FvzRdKHW
         Ih3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734385447; x=1734990247;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wfz8Qyf8HO/uwLU4Ovm0zRhptn7NeZt8a31y9gqWbFY=;
        b=dOeajSLtVSZlKgofgJB3oTUsG0vJ9eH57ndnfVsc26P4yMBPQ/6VAbbaWdxXMA93JQ
         U5srsT1JeATZWtaOj72hdMVYpeFpS3Fz7ohzM5B7twL17R6H3bFYAHyEI6V/M2Liwv/T
         E09CDNVO6SABysufUtizs6sNPxBOLjQZyCSH3x4YEl/TOoac4LEF7DAsyyXzmKJ/lMPH
         0BXOS/nHnCJjcm6sjBIfkKQBRxqQ+nnxVbXDCU4ZbqMAjosZ+sVOABE9JmmC+ljQePs/
         yqr98mTePNaNy64nAoidoeSa5gIlsIUGXzN4I3NKW6wPGVGja8bw2FXQkpIFuzlvXYFL
         HXiA==
X-Forwarded-Encrypted: i=1; AJvYcCXNCW2JALq/bIKrFXT3ObwNq6vYKkVOU2YKqqQR8QFZP0hqEHVFI31COxr8DSoYwtjSURvu5yjXfVp0OVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrC/C15czzIXW/85S2UC7GQXOiylU3PQpwaTygHxvrY6QKHav8
	3BiQuq1Zvo4pVYO7FLgQS4CcYctAWfP0dmTEZAoHdkb53985lQkwaIzyc9JPwRTm0MQ42wQWO/L
	5
X-Gm-Gg: ASbGncuC3hvfj06tVwg/HN13xtS/GQCcV/1Quod5NyLyVC37kLggJaxuloKg2k1I4ta
	3nTW3y8nzae16T8IZoEvmreM2tQYZ2aL3+lUDrdVpZYMRHmpnszVEl2Kf4niytkGg3qIIiiUnpd
	wquJEOHtSAjPRvlWoXRJiOzYhJpoLfjocUV8gTXLRPzptnzSX4QZ5cNhly+zFu6bBF70avRVHXr
	owi5gh4N8zUz3Q/Yts8XItTs3XfwFCy3t/qxlwY+wBkiOmKG54/XYKQH3VrlwuDaG7Mxw65hZns
	B5LwkqkWeZ5T
X-Google-Smtp-Source: AGHT+IFZrT/j2VKlBtv+4Dva/WHzp4WJgWg8VD0OJ9jwCociHQ6PPiFAIN07RHcnUdsUCquDkKUbBQ==
X-Received: by 2002:a05:6870:392c:b0:2a3:d9b3:3d02 with SMTP id 586e51a60fabf-2a3d9b3b082mr5198901fac.40.1734385447306;
        Mon, 16 Dec 2024 13:44:07 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d2645500sm2233309fac.20.2024.12.16.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:44:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Dec 2024 15:44:03 -0600
Subject: [PATCH v2] iio: dac: ad7293: enable power before reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-iio-regulator-cleanup-round-6-v2-1-9482164b68cb@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACKfYGcC/42NTQ6CMBBGr0K6dkxb5CeuvIdh0ZYBJsGWTKWRE
 O5u5QQu30u+9+0iIhNGcS92wZgoUvAZ9KUQbjJ+RKA+s9BS35TSEogCMI7rbN6Bwc1o/LoAh9X
 3UEPTWllZlHWjWpEbC+NAn7P/7DJPFPNsO++S+tl/y0mBhL4yVVnLoUFXPqzZZrKMVxdeojuO4
 wsZlvVvzQAAAA==
X-Change-ID: 20241120-iio-regulator-cleanup-round-6-78b05be06718
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Change the order of regulator enable and reset so that power supplies
are turned on before touching the reset line. Generally, chips should
have the VDRIVE supply enabled before applying voltage on any pins.

While we are at it, remove the voltage level checks. If the power
supplies are not supplying the correct voltage, this is a hardware
design problem, not a software problem.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Dropped patches from "iio: use devm_regulator_get_enable_read_voltage
  round 6" that have already been applied.
- New patch for ad7293 that just enables power supplies and no longer
  reads the voltage.
- Link to v1: https://lore.kernel.org/r/20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com
---
 drivers/iio/dac/ad7293.c | 68 +++++++-----------------------------------------
 1 file changed, 9 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index 1d403267048240be1bf3d8b2a59685409b9087fd..d3f49b5337d2f512363d50b434d99d4e9b95059f 100644
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
@@ -777,6 +775,15 @@ static int ad7293_reset(struct ad7293_state *st)
 static int ad7293_properties_parse(struct ad7293_state *st)
 {
 	struct spi_device *spi = st->spi;
+	int ret;
+
+	ret = devm_regulator_get_enable(&spi->dev, "avdd");
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "failed to enable AVDD\n");
+
+	ret = devm_regulator_get_enable(&spi->dev, "vdrive");
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "failed to enable VDRIVE\n");
 
 	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
 						 GPIOD_OUT_HIGH);
@@ -784,24 +791,9 @@ static int ad7293_properties_parse(struct ad7293_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_reset),
 				     "failed to get the reset GPIO\n");
 
-	st->reg_avdd = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->reg_avdd))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->reg_avdd),
-				     "failed to get the AVDD voltage\n");
-
-	st->reg_vdrive = devm_regulator_get(&spi->dev, "vdrive");
-	if (IS_ERR(st->reg_vdrive))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->reg_vdrive),
-				     "failed to get the VDRIVE voltage\n");
-
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
@@ -816,48 +808,6 @@ static int ad7293_init(struct ad7293_state *st)
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

---
base-commit: 01958cb8a00d9721ae56ad1eef9cd7b22b5a34bb
change-id: 20241120-iio-regulator-cleanup-round-6-78b05be06718

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


