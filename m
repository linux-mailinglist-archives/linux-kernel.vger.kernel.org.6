Return-Path: <linux-kernel+bounces-541627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D7EA4BFB0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E203A4B34
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463D620E30F;
	Mon,  3 Mar 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rLc7SPlv"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0E1F4297
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002478; cv=none; b=NP00Mi7bazChWTAK2sy8NC1lKPeWLt6q/D2anYoXoHB2Ahoh+rilNu+MErpISRmpLZ0lZfFuSpmdkUxrgY+8eKFd8rRUWcaTPdsaLOQtnI1vRodiBiWlT577TTkxhSYRD7MOZNr0bz7xB+q1p6z4AAn6g/+drllRSFA89UZuu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002478; c=relaxed/simple;
	bh=cGqPD8/SZrkOEEoS5r71WCJ1/AsMqIH3QA/fWi2qpiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzoXHy7/tAZOHOk1ksfa5U1sD2elaZ3IPgFnLcJfBhh2uveXjGd0gTHoLSuiIDaUnbwSLVGfP1QlYGGaUEHWX5rvCZlx7Om7jXCUhKrk2xEbMADLvKZqTUg/97K6oMiOsX1WvskA63FDl9EMkRwgdyl9PSsqmlJBD9pFurmTLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rLc7SPlv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390e702d481so1774253f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002475; x=1741607275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JfuBlnVs+Mi+9z09rt1BKUuKJ56NGKvPoa3JHTdL8U=;
        b=rLc7SPlvITfDKZc0T1DYAS7loPH9CBrtv9OfIEJGGCNNUEBGjA9ZStuDvDfS3ixCbu
         FjvujN+FrzTVScHm7sdbC5HWSktmrqVeka3tpA00C7q4Kh+XPgvwwVQHjh+7JOBwfkg+
         8UEk5MtWkd3SMXkLg0NRPs7ForPFjtoGt09g1e5NBApZfG9A4KyICwtJ5PqoZF6fwF7R
         II+aVR4xw16DvUpXm3bmR2p2I7B9tftr36dwoxT1Ijg0x2CXcThR18mfX/5xJHijpxqe
         myVXhltfEk3cWEvrnWByLyif5p11uUaJkWqqzOAmFPMXbtcOkB8QrVNvwoXPNDwvSI88
         5Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002475; x=1741607275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JfuBlnVs+Mi+9z09rt1BKUuKJ56NGKvPoa3JHTdL8U=;
        b=Izd53U5CJuNsNT0h+bMbHf+GvTaa8BBR6nw/soWchSAQGdICtrrqCNksupKeZD9KIo
         GvIKyVijzqpCFnHjYATsB0jlIUyZ2z1VN9k2MWXcJWSsfs0ORrWG8A3A9CKZHRo53iyD
         93StiZfAYuDs6+t5PuV+4P/p6VJLcU6p4i28DsoIK2aInJnY1IPWl/EWLAbewsrStUx9
         7agkO4dTaMbM4AAVhIGVX+XBUt7pIHeBqug6KOunKmgF2hQqLunp0Sdfh657XW0i87YX
         ZJbFabDKcBHktKp8RH3KT1aMAhhxKT4/cwY7aGWpeRgSBxY8fOUdS8dmNR/9PNQo6UkX
         Y2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAGrwo2g5gDMimChbd/zn8sR2Cbd59wPtmF6vZrBJ9/Wdaf90GHgSDY3uDQhizmn23aVXTJxlF0cZCYK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycfU29SONoJXc+vXQxgtS4feJK8fodDF2QTNCg/irSCZEY+GQs
	+fLGPNRWlQKY4HM+6WvURiYjnh2phJ52T2E86NV78NnACeME+Vh0ZT6rZw/tYo4=
X-Gm-Gg: ASbGncvRKf8y8I99lvGozuHkwFT3L/M0cObWHNqbhtL2z/CIoNSMnUI/6UGNfRE2rND
	rhFaAvBeSL/uCQ4Vsgf36fMAwTMtuXd8MI5Tm+dr38cdVAsT2lV0zEkX5LJv0ZyEe1q7pRTFF+U
	Jwb46OezOvLFYF+XWwqCSGjivB54JvuS9Wt9joPOPzkiyF2U4ymzNtndGmXKTjJHNniTZavdJS0
	ClNKTJbPgoM+UhNWXJA+r3bCQYxiqd9nBpxb6NER9pRCSdHo4XTqCx9PbL/nKmNCXEKGdBP0wfK
	ReWNd8Ihkroh89sxapPwmqeA9T9XqsHDeufyNvAYRA/HLc+rMlnckY2mCgOxp5z2PGWxff/QLJD
	OcFC8ATjxC4fXWLudMqnQVxfJ4w==
X-Google-Smtp-Source: AGHT+IGkSIxp717Pg3OS71H44ATwH724qKt8I091Xvxo2HPuDyZAhdmwoEbHrejhhauDj7QidAGPPQ==
X-Received: by 2002:a5d:5f4c:0:b0:390:fd7c:98be with SMTP id ffacd0b85a97d-390fd7c9b46mr5721261f8f.19.1741002474987;
        Mon, 03 Mar 2025 03:47:54 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d17sm14048575f8f.28.2025.03.03.03.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:54 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] iio: adc: ad7124: Implement system calibration
Date: Mon,  3 Mar 2025 12:47:06 +0100
Message-ID: <20250303114659.1672695-18-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5359; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=cGqPD8/SZrkOEEoS5r71WCJ1/AsMqIH3QA/fWi2qpiM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZbQQj85GuyCEcT/+/txKbDasve9RcMnzqqly Hw1ZzYSxYWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WW0AAKCRCPgPtYfRL+ Tu9CCACvrDJKvuayNJIw8lOaq4cQjCSsgpuDp3xSqYdQ2o0NL/lOdxFoQ4DOFsOhe5DawJVGVaw DBFDkuLlNr/FSXmbtWmojqmMpdi50c0jrtDWW4rSB0N3PBSHol+PQgWEbpx+3WmlNuOf0a4ozOS 4IiTn8pdcBWdPOGENAzLT2G7xVtVuO93XpPDpxQpyba7DNud6doMPUPYC5TUIm2OYQS8FQ+c8Ss fKPaoM03QcH/s5ObNYfDYsm8WVRZbI3a4nvt1SIgYFK7FIZg2OZMGHWly/xl5vKD3COFkNodkZM YoZRbA2e+yL9SuvgxnprI6blsEpMFRVIExfDONzOlcuZgnWr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Allow triggering both zero-scale and full-scale calibration via sysfs in
the same way as it's done for ad7173.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 153 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 136 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 382f46ff2b51..5ab0d3e48c43 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2018 Analog Devices Inc.
  */
+
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
@@ -181,6 +182,7 @@ struct ad7124_channel {
 	struct ad7124_channel_config cfg;
 	unsigned int ain;
 	unsigned int slot;
+	u8 syscalib_mode;
 };
 
 struct ad7124_state {
@@ -202,23 +204,6 @@ struct ad7124_state {
 	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
 };
 
-static const struct iio_chan_spec ad7124_channel_template = {
-	.type = IIO_VOLTAGE,
-	.indexed = 1,
-	.differential = 1,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
-	.scan_type = {
-		.sign = 'u',
-		.realbits = 24,
-		.storagebits = 32,
-		.endianness = IIO_BE,
-	},
-};
-
 static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
 	[ID_AD7124_4] = {
 		.name = "ad7124-4",
@@ -903,6 +888,140 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 	return 0;
 }
 
+enum {
+	AD7124_SYSCALIB_ZERO_SCALE,
+	AD7124_SYSCALIB_FULL_SCALE,
+};
+
+static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan_spec *chan)
+{
+	struct device *dev = &st->sd.spi->dev;
+	struct ad7124_channel *ch = &st->channels[chan->channel];
+	int ret;
+
+	if (ch->syscalib_mode == AD7124_SYSCALIB_ZERO_SCALE) {
+		ch->cfg.calibration_offset = 0x800000;
+
+		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_ZERO,
+				      chan->address);
+		if (ret < 0)
+			return ret;
+
+		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(ch->cfg.cfg_slot), 3,
+				     &ch->cfg.calibration_offset);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "offset for channel %d after zero-scale calibration: 0x%x\n",
+			chan->channel, ch->cfg.calibration_offset);
+	} else {
+		ch->cfg.calibration_gain = st->gain_default;
+
+		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_FULL,
+				      chan->address);
+		if (ret < 0)
+			return ret;
+
+		ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(ch->cfg.cfg_slot), 3,
+				     &ch->cfg.calibration_gain);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "gain for channel %d after full-scale calibration: 0x%x\n",
+			chan->channel, ch->cfg.calibration_gain);
+	}
+
+	return 0;
+}
+
+static ssize_t ad7124_write_syscalib(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     const char *buf, size_t len)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+	bool sys_calib;
+	int ret;
+
+	ret = kstrtobool(buf, &sys_calib);
+	if (ret)
+		return ret;
+
+	if (!sys_calib)
+		return len;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = ad7124_syscalib_locked(st, chan);
+
+	iio_device_release_direct(indio_dev);
+
+	return ret ?: len;
+}
+
+static const char * const ad7124_syscalib_modes[] = {
+	[AD7124_SYSCALIB_ZERO_SCALE] = "zero_scale",
+	[AD7124_SYSCALIB_FULL_SCALE] = "full_scale",
+};
+
+static int ad7124_set_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int mode)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+
+	st->channels[chan->channel].syscalib_mode = mode;
+
+	return 0;
+}
+
+static int ad7124_get_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+
+	return st->channels[chan->channel].syscalib_mode;
+}
+
+static const struct iio_enum ad7124_syscalib_mode_enum = {
+	.items = ad7124_syscalib_modes,
+	.num_items = ARRAY_SIZE(ad7124_syscalib_modes),
+	.set = ad7124_set_syscalib_mode,
+	.get = ad7124_get_syscalib_mode
+};
+
+static const struct iio_chan_spec_ext_info ad7124_calibsys_ext_info[] = {
+	{
+		.name = "sys_calibration",
+		.write = ad7124_write_syscalib,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("sys_calibration_mode", IIO_SEPARATE,
+		 &ad7124_syscalib_mode_enum),
+	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
+			   &ad7124_syscalib_mode_enum),
+	{ }
+};
+
+static const struct iio_chan_spec ad7124_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.differential = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_BE,
+	},
+	.ext_info = ad7124_calibsys_ext_info,
+};
+
 /*
  * Input specifiers 8 - 15 are explicitly reserved for ad7124-4
  * while they are fine for ad7124-8. Values above 31 don't fit
-- 
2.47.1


