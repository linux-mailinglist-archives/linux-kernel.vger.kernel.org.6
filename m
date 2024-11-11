Return-Path: <linux-kernel+bounces-404312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA49C4246
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4442EB224EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1E1A257A;
	Mon, 11 Nov 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kn3gIP/i"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F819E99C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340789; cv=none; b=ERnUT1Ua2XVFWuXMuRxnAthHtQucxAK5IfkQtIAJBlhY6cSvGEnzU0tBESWCcQmrOTnOMJHBv9JTzu973x+xczgmHuzfAyb1ZLLHW0nEshxM9BqZiRG4cyCbpsbylB+6pC8TDQsHFLSQZXgikaQe3Fi3xR/zhg1Aci6hoDSAsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340789; c=relaxed/simple;
	bh=HDcW1VcFC6TUobbEsvgtNwj7T/A2DfMJi7G65Cb9CEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNn8YoMr9RNz1nvtDWwkMhN2pjI04bglNy/6ZKZWgMgaO+ACt+zGMnSb4g8SYEhBTAmFyIrwTlJnHiuLg0u3twHbiintX4pVnw03BxlPEKSutLeydprPAG2RTqC0jhpRYGGCU6IxVG+r2TjhzngmL1pvfXokbICiNHv8z55m9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kn3gIP/i; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83ab21c269eso177249439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731340787; x=1731945587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRx61QutqkHqE8LsifHeDvLFt2mQ7Pk/J2Li4P0J5EU=;
        b=kn3gIP/iAqIFjThhhJdpY5p+TfBzmvYJuz+/2qolTlJII5mEKK3j7U07QJoL3wSF3p
         jPelUIGdgnhYM50ecJrK8+Pv/8/tuFnv0h+pHKanUQPIUaFsxKSJYnOobzeTkdpSdXq6
         WAKSIhzw7pwP8nbNXiPfqzfsFfhhDfaLwWj1Q6jMhDdebiz1BuEU9tH4WTQcklwnQqee
         FUZdV+8Xq32DcT044rA3HqOe6V3qjYo9jQPTC+AvVdZWPBLqnfpc4HkD1QMtV6Lmzv/F
         Z7Me14w4U3UoVW3VSlUTDO1j9LyDLyk2/3KGSwdfzcEod4P4uVqBHRZbBIuaRLNpJNfT
         mCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340787; x=1731945587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRx61QutqkHqE8LsifHeDvLFt2mQ7Pk/J2Li4P0J5EU=;
        b=UBQnlVWItG/VrcXKgCUU4sEWQ04nKPOi70noOT1FzxBCgyBrGpUt1TpamjOhUnFS7D
         fq7WzTYQ2SRnsNqW9D5Vynlj18BESo3/9dosAd0cgMZXQrnemtX8voVhCyGnlItwQyvr
         JIHL4npFI0Cue8NEHRg0kuYrd5Si1kJWpXI+Ohai7ez7v2X5GhFtxCfoOsMsTQW3h/bA
         GZpQKsT95utirC4jvLiDMsjRhzpYVEXf4r4i/H0LGeMWNQ81M63U2LUCitx1t3ymEYFq
         5+CadpUoaHmtT0aMeTaVNO9xZndA9E5PeltPEtsOGlHUB1BPv7dNangTGI5AglCklJFG
         V8gA==
X-Forwarded-Encrypted: i=1; AJvYcCVAHNOCuC5nyUPZ+d5E1bXoWItBOu0xoJm9GGJUuNaOiH8jRo78zdnSSf+8SysdD4BlLFRPGB63N4yZT+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwPJbQFdmw/LgCIq7r1HElnO3APSEL/TmuEZHHTxXnZozirh/
	XsNAl9ab5RGublVqaH9iTcS2TVcZfYVsIsPMAbSE1rEJru2+z5eSjke9C09RvJWURES9mOTTq+N
	L
X-Google-Smtp-Source: AGHT+IFz5onGePgbNMaG6Xw/7Xs9ETfUP+zGO0bMsWlJBZyv1Ip2qkVxHrYh9z77fz9YgW2JWKoJmg==
X-Received: by 2002:a05:6602:13d3:b0:83a:acfa:b0ba with SMTP id ca18e2360f4ac-83e032a171dmr1370582039f.1.1731340786793;
        Mon, 11 Nov 2024 07:59:46 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787d62c6sm1410986173.81.2024.11.11.07.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:59:46 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 11 Nov 2024 10:59:44 -0500
Subject: [PATCH 3/3] iio: adc: ad4695: add custom regmap bus callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-tgamblin-ad4695_improvements-v1-3-698af4512635@baylibre.com>
References: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
In-Reply-To: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Add a custom implementation of regmap read/write callbacks using the SPI
bus. This allows them to be performed at a lower SCLK rate than data
reads. Previously, all SPI transfers were being performed at a lower
speed, but with this change sample data is read at the max bus speed
while the register reads/writes remain at the lower rate.

Also remove .can_multi_write from the AD4695 driver's regmap_configs, as
this isn't implemented or needed.

For some background context, see:

https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/Kconfig  |  2 +-
 drivers/iio/adc/ad4695.c | 74 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6c4e74420fd2..e0f9d01ce37d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -51,9 +51,9 @@ config AD4130
 config AD4695
 	tristate "Analog Device AD4695 ADC Driver"
 	depends on SPI
-	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices AD4695 and similar
 	  analog to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index f36c1a1db886..180a0fd4f03c 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -150,6 +150,8 @@ struct ad4695_state {
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;
 	u8 cnv_cmd2;
+	/* Buffer for storing data from regmap bus reads/writes */
+	u8 regmap_bus_data[4];
 };
 
 static const struct regmap_range ad4695_regmap_rd_ranges[] = {
@@ -194,7 +196,6 @@ static const struct regmap_config ad4695_regmap_config = {
 	.max_register = AD4695_REG_AS_SLOT(127),
 	.rd_table = &ad4695_regmap_rd_table,
 	.wr_table = &ad4695_regmap_wr_table,
-	.can_multi_write = true,
 };
 
 static const struct regmap_range ad4695_regmap16_rd_ranges[] = {
@@ -226,7 +227,67 @@ static const struct regmap_config ad4695_regmap16_config = {
 	.max_register = AD4695_REG_GAIN_IN(15),
 	.rd_table = &ad4695_regmap16_rd_table,
 	.wr_table = &ad4695_regmap16_wr_table,
-	.can_multi_write = true,
+};
+
+static int ad4695_regmap_bus_reg_write(void *context, const void *data,
+				       size_t count)
+{
+	struct ad4695_state *st = context;
+	struct spi_transfer xfer = {
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.len = count,
+			.tx_buf = st->regmap_bus_data,
+	};
+
+	if (count > ARRAY_SIZE(st->regmap_bus_data))
+		return -EINVAL;
+
+	memcpy(st->regmap_bus_data, data, count);
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ad4695_regmap_bus_reg_read(void *context, const void *reg,
+				      size_t reg_size, void *val,
+				      size_t val_size)
+{
+	struct ad4695_state *st = context;
+	struct spi_transfer xfers[] = {
+		{
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.len = reg_size,
+			.tx_buf = &st->regmap_bus_data[0],
+		}, {
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.len = val_size,
+			.rx_buf = &st->regmap_bus_data[2],
+		},
+	};
+	int ret;
+
+	if (reg_size > 2)
+		return -EINVAL;
+
+	if (val_size > 2)
+		return -EINVAL;
+
+	memcpy(&st->regmap_bus_data[0], reg, reg_size);
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret)
+		return ret;
+
+	memcpy(val, &st->regmap_bus_data[2], val_size);
+
+	return 0;
+}
+
+static const struct regmap_bus ad4695_regmap_bus = {
+	.write = ad4695_regmap_bus_reg_write,
+	.read = ad4695_regmap_bus_reg_read,
+	.read_flag_mask = 0x80,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
 static const struct iio_chan_spec ad4695_channel_template = {
@@ -1040,15 +1101,14 @@ static int ad4695_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return -EINVAL;
 
-	/* Registers cannot be read at the max allowable speed */
-	spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
-
-	st->regmap = devm_regmap_init_spi(spi, &ad4695_regmap_config);
+	st->regmap = devm_regmap_init(dev, &ad4695_regmap_bus, st,
+				      &ad4695_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to initialize regmap\n");
 
-	st->regmap16 = devm_regmap_init_spi(spi, &ad4695_regmap16_config);
+	st->regmap16 = devm_regmap_init(dev, &ad4695_regmap_bus, st,
+					&ad4695_regmap_config);
 	if (IS_ERR(st->regmap16))
 		return dev_err_probe(dev, PTR_ERR(st->regmap16),
 				     "Failed to initialize regmap16\n");

-- 
2.39.5


