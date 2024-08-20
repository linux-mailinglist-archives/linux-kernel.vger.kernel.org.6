Return-Path: <linux-kernel+bounces-294294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68985958BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C61B22597
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B519D886;
	Tue, 20 Aug 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ael4jJVT"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0FB19408E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169536; cv=none; b=IBugJevLoY7Kr7heaGRhFMTxo40j6eNuZvh+GvoXWWKP1w/q5zbnwQsVWe8hSrYKKMxzRrf9u57cyTWvPluWDRsC1UJaX8LPijCFJ7Xt+4iQOq3o5xEBWKfxd5uhZrpUAxkF58U5ZTuRPyJVUFLk8aU2HA/93holSDulqHG15Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169536; c=relaxed/simple;
	bh=T2uW+9PyixgbUtWpXjoj/knW40tAhHFwdFvL2UuJfK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Be8lY4UVWhG1DNxxrzj3B0U8rrte90DPdywMQZKZ9NkNYqyXpAqDzYH6JvWUtW7Oa6SaKGJHbvlpysFbLvX8u4owvyJeZ2wbpDqFTiLoEHcXgV7bveVnpbP/KVFcOD7Zl/3b1Ti4luyGrS2K9DQwS8Z972j4bnnTX+t6vP/+Dew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ael4jJVT; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db1d0fca58so3403567b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724169533; x=1724774333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8r3jcTfoo6qehw9myoqpknk+mT1kpzg79vaDmFe51U=;
        b=ael4jJVTaF16e4/5ceLQ78FNbFohPooyWGJzuOU4Uif3PBVlTC+06Ll1qgBSgzn2z/
         NeqJq+10Y3UOvKpJmCyAEC693q9hXW6FLKAeG/80fZ18HfBYTQrbgWaNuusdfl0o9QCq
         KxD6muz3Hl8mpoIV58Pf/bYrKN8GPMQ3O79DD4L5zD0DlGd96EFqGOk1s9dfRHwsfyZZ
         vlfa06359DqoAaDc6cbN6XwHCR7Ywh8VxG/+vSBLwaLoj1ULtbOX7YaCSwSNEeSZXgtG
         Gaytuka1eh+FcaXnd4sKpI2vAI19d/c2qJ6sZpfirFt1usC4HgoScw3H/i0QrBqqdmCC
         8v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169533; x=1724774333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8r3jcTfoo6qehw9myoqpknk+mT1kpzg79vaDmFe51U=;
        b=jYO0FaOCOegF1FVLR9vOMcfQ+FzEYI9T+oJ4aFnuek43L4mYOUKtYYBjmYM5JEdOh7
         vVrR2VW2c8VaXw8paQZNwpZeV46R4tutF+KA1QD7Xj/B+Kbwf+IpPgJLH+VsG49T3HD3
         wDNj70o4jjid1F+HnLPsakJqR/zrZ0QdJNLA/xoPlXtBCss4RAaXTmSbm6YBKne7GzvT
         wr2LYAYLCTjrUngKHQOPuGA0yaCKKfZe8HcOL+1lRJK5Y87/4ENxESfpCqRMOHrgz5tf
         BsY/VIqMolvA5rdWiPvFk/cNjTCTMLMWgjeGGLEszYMCadEDUMFu7UDuDPG4vTT4Vucp
         1Wdw==
X-Forwarded-Encrypted: i=1; AJvYcCVQTRfVoczp3ObTmasoI85+GTer9N6vPR/DbGE5ve5ub9j2yqFIjLsfrL0T5MhXj4hsqQ6LveDcL4WEHyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdy8M2GrfZNLwcmkw3hov2RH//uQChG8Y/uIwyIaPQlLxhfm6m
	mMdPsqYQocSTe3OX9c0RFpwGQFs4v7DqsMjf2WPmMXGQeS0Z5eY+uHIl/mWj7mM=
X-Google-Smtp-Source: AGHT+IHY9wEuslBOuA+07pv4kLyKmUKmBvx9lJ6KeF5DAR20Dmo8DuJoCoB0Nvw1kx6Q5jEcJFPEAA==
X-Received: by 2002:a05:6808:14c6:b0:3d6:3050:7ce7 with SMTP id 5614622812f47-3dd3af8210fmr16554650b6e.44.1724169533411;
        Tue, 20 Aug 2024 08:58:53 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33d5a3efsm2872718b6e.17.2024.08.20.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:58:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 20 Aug 2024 10:58:35 -0500
Subject: [PATCH 1/4] iio: adc: ad4695: add 2nd regmap for 16-bit registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-ad4695-gain-offset-v1-1-c8f6e3b47551@baylibre.com>
References: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
In-Reply-To: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

The AD4695 and similar chips have some multibyte registers that have
to be read/written in a single operation. So we need to add a 2nd regmap
for these registers.

These registers are removed from the 8-bit regmap allowable ranges and
AD4695_MAX_REG is dropped since it would be ambiguous now.

debugfs register access is also updated to automatically use the correct
regmap depending on the register address.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 83 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index b8547914f00f..63d816ad2d1f 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -34,6 +34,7 @@
 /* AD4695 registers */
 #define AD4695_REG_SPI_CONFIG_A				0x0000
 #define   AD4695_REG_SPI_CONFIG_A_SW_RST		  (BIT(7) | BIT(0))
+#define   AD4695_REG_SPI_CONFIG_A_ADDR_DIR		  BIT(5)
 #define AD4695_REG_SPI_CONFIG_B				0x0001
 #define   AD4695_REG_SPI_CONFIG_B_INST_MODE		  BIT(7)
 #define AD4695_REG_DEVICE_TYPE				0x0003
@@ -77,7 +78,6 @@
 #define AD4695_REG_GAIN_IN(n)				(0x00C0 | (2 * (n)))
 #define AD4695_REG_AS_SLOT(n)				(0x0100 | (n))
 #define   AD4695_REG_AS_SLOT_INX			  GENMASK(3, 0)
-#define AD4695_MAX_REG					0x017F
 
 /* Conversion mode commands */
 #define AD4695_CMD_EXIT_CNV_MODE	0x0A
@@ -121,6 +121,7 @@ struct ad4695_channel_config {
 struct ad4695_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
+	struct regmap *regmap16;
 	struct gpio_desc *reset_gpio;
 	/* voltages channels plus temperature and timestamp */
 	struct iio_chan_spec iio_chan[AD4695_MAX_CHANNELS + 2];
@@ -150,8 +151,10 @@ static const struct regmap_range ad4695_regmap_rd_ranges[] = {
 	regmap_reg_range(AD4695_REG_SPI_CONFIG_C, AD4695_REG_SPI_STATUS),
 	regmap_reg_range(AD4695_REG_STATUS, AD4695_REG_ALERT_STATUS2),
 	regmap_reg_range(AD4695_REG_CLAMP_STATUS, AD4695_REG_CLAMP_STATUS),
-	regmap_reg_range(AD4695_REG_SETUP, AD4695_REG_TEMP_CTRL),
-	regmap_reg_range(AD4695_REG_CONFIG_IN(0), AD4695_MAX_REG),
+	regmap_reg_range(AD4695_REG_SETUP, AD4695_REG_AC_CTRL),
+	regmap_reg_range(AD4695_REG_GPIO_CTRL, AD4695_REG_TEMP_CTRL),
+	regmap_reg_range(AD4695_REG_CONFIG_IN(0), AD4695_REG_CONFIG_IN(15)),
+	regmap_reg_range(AD4695_REG_AS_SLOT(0), AD4695_REG_AS_SLOT(127)),
 };
 
 static const struct regmap_access_table ad4695_regmap_rd_table = {
@@ -164,8 +167,10 @@ static const struct regmap_range ad4695_regmap_wr_ranges[] = {
 	regmap_reg_range(AD4695_REG_SCRATCH_PAD, AD4695_REG_SCRATCH_PAD),
 	regmap_reg_range(AD4695_REG_LOOP_MODE, AD4695_REG_LOOP_MODE),
 	regmap_reg_range(AD4695_REG_SPI_CONFIG_C, AD4695_REG_SPI_STATUS),
-	regmap_reg_range(AD4695_REG_SETUP, AD4695_REG_TEMP_CTRL),
-	regmap_reg_range(AD4695_REG_CONFIG_IN(0), AD4695_MAX_REG),
+	regmap_reg_range(AD4695_REG_SETUP, AD4695_REG_AC_CTRL),
+	regmap_reg_range(AD4695_REG_GPIO_CTRL, AD4695_REG_TEMP_CTRL),
+	regmap_reg_range(AD4695_REG_CONFIG_IN(0), AD4695_REG_CONFIG_IN(15)),
+	regmap_reg_range(AD4695_REG_AS_SLOT(0), AD4695_REG_AS_SLOT(127)),
 };
 
 static const struct regmap_access_table ad4695_regmap_wr_table = {
@@ -174,15 +179,47 @@ static const struct regmap_access_table ad4695_regmap_wr_table = {
 };
 
 static const struct regmap_config ad4695_regmap_config = {
-	.name = "ad4695",
+	.name = "ad4695-8",
 	.reg_bits = 16,
 	.val_bits = 8,
-	.max_register = AD4695_MAX_REG,
+	.max_register = AD4695_REG_AS_SLOT(127),
 	.rd_table = &ad4695_regmap_rd_table,
 	.wr_table = &ad4695_regmap_wr_table,
 	.can_multi_write = true,
 };
 
+static const struct regmap_range ad4695_regmap16_rd_ranges[] = {
+	regmap_reg_range(AD4695_REG_STD_SEQ_CONFIG, AD4695_REG_STD_SEQ_CONFIG),
+	regmap_reg_range(AD4695_REG_UPPER_IN(0), AD4695_REG_GAIN_IN(15)),
+};
+
+static const struct regmap_access_table ad4695_regmap16_rd_table = {
+	.yes_ranges = ad4695_regmap16_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad4695_regmap16_rd_ranges),
+};
+
+static const struct regmap_range ad4695_regmap16_wr_ranges[] = {
+	regmap_reg_range(AD4695_REG_STD_SEQ_CONFIG, AD4695_REG_STD_SEQ_CONFIG),
+	regmap_reg_range(AD4695_REG_UPPER_IN(0), AD4695_REG_GAIN_IN(15)),
+};
+
+static const struct regmap_access_table ad4695_regmap16_wr_table = {
+	.yes_ranges = ad4695_regmap16_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad4695_regmap16_wr_ranges),
+};
+
+static const struct regmap_config ad4695_regmap16_config = {
+	.name = "ad4695-16",
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.max_register = AD4695_REG_GAIN_IN(15),
+	.rd_table = &ad4695_regmap16_rd_table,
+	.wr_table = &ad4695_regmap16_wr_table,
+	.can_multi_write = true,
+};
+
 static const struct iio_chan_spec ad4695_channel_template = {
 	.type = IIO_VOLTAGE,
 	.indexed = 1,
@@ -646,13 +683,24 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
 	struct ad4695_state *st = iio_priv(indio_dev);
 
 	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		if (readval)
-			return regmap_read(st->regmap, reg, readval);
-
-		return regmap_write(st->regmap, reg, writeval);
+		if (readval) {
+			if (regmap_check_range_table(st->regmap, reg,
+						     &ad4695_regmap_rd_table))
+				return regmap_read(st->regmap, reg, readval);
+			if (regmap_check_range_table(st->regmap16, reg,
+						     &ad4695_regmap16_rd_table))
+				return regmap_read(st->regmap16, reg, readval);
+		} else {
+			if (regmap_check_range_table(st->regmap, reg,
+						     &ad4695_regmap_wr_table))
+				return regmap_write(st->regmap, reg, writeval);
+			if (regmap_check_range_table(st->regmap16, reg,
+						     &ad4695_regmap16_wr_table))
+				return regmap_write(st->regmap16, reg, writeval);
+		}
 	}
 
-	unreachable();
+	return -EINVAL;
 }
 
 static const struct iio_info ad4695_info = {
@@ -807,6 +855,11 @@ static int ad4695_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to initialize regmap\n");
 
+	st->regmap16 = devm_regmap_init_spi(spi, &ad4695_regmap16_config);
+	if (IS_ERR(st->regmap16))
+		return dev_err_probe(dev, PTR_ERR(st->regmap16),
+				     "Failed to initialize regmap16\n");
+
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(ad4695_power_supplies),
 					     ad4695_power_supplies);
@@ -876,9 +929,9 @@ static int ad4695_probe(struct spi_device *spi)
 		msleep(AD4695_T_WAKEUP_SW_MS);
 	}
 
-	/* Needed for debugfs since it only access registers 1 byte at a time. */
-	ret = regmap_set_bits(st->regmap, AD4695_REG_SPI_CONFIG_C,
-			      AD4695_REG_SPI_CONFIG_C_MB_STRICT);
+	/* Needed for regmap16 to be able to work correctly. */
+	ret = regmap_set_bits(st->regmap, AD4695_REG_SPI_CONFIG_A,
+			      AD4695_REG_SPI_CONFIG_A_ADDR_DIR);
 	if (ret)
 		return ret;
 

-- 
2.43.0


