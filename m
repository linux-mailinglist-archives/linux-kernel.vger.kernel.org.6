Return-Path: <linux-kernel+bounces-172029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021288BEC33
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50943B23C28
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD616EC10;
	Tue,  7 May 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JFkb2rPm"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCA16DEA0
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108543; cv=none; b=N5c2J305D6lSm5QaxXio4Z+ke00MhVNWeYaMuH4FcRpIf/2M/74d5HeIDQ1nBKr2E0Xmj1c9iTFG3aLWUqm33YqtvO5fRul23BYTPDz/zY1LVLxDkg2MpW+qdDsV8dUHUcSIbHUhfsGktW2R9x1Ln9a1q6P1UstAKr1exZMzQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108543; c=relaxed/simple;
	bh=EvBNYEvN8j9ghLH+OpWG+7kKxj7ybV0QTyNby5uwafc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMWr6AkdeqzduQo2e875xwvyAP5xSqb7th+YYKP45RDtT5L8ThKwQN45D3GH4IvNANx/F8cK+VMmor9pSTdPvNuu/U9i9DD3gOeGaPhBfNAQvVJ+HEPYkCclJUZ3KAC0r2C2vLj/bmehUjyT8BE2hgI0iySZF70YU83sjgpt9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JFkb2rPm; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9691e1e78so1611907b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715108541; x=1715713341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6XxGU1FlTtbSR4iab/xAALxEuyhck2Pa/6k2+UASj0=;
        b=JFkb2rPmYyiRTnd6592xo1xzJcwlAj0VUOWlPIwSvVPLzIdOOOvqvXPEgGk32P1Lcp
         XQy8XsIrKkZf7xVrWJf2YgtO/13FU8vbjTNjj2GUbSf6gDRWrJwy0JrXnFIhhch6L+84
         wtlDnSNWcVxSyMklCVrO86pGX1iao4I5RSESWC095KskCIE0+6DtIedVPrtdt2evwQWP
         eT/8hC9YVhtExUUL7QhoeUgXbNZLWs9mEaPl2MbXGrVa7FxTM8fSb0upZeMNwPNcHwev
         ELlc2RDo0XJIK+rNTThRH2Eyo+1d4VIvo+Gd5L4KLzUVDYAnmjWYQjClaK6btop3hz1F
         mNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715108541; x=1715713341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6XxGU1FlTtbSR4iab/xAALxEuyhck2Pa/6k2+UASj0=;
        b=MQ/ex4WbZNt4LEJDtPR29X/qjXWBPfRwKbIR6TqkkY4aw3f0NF1KBWpwd74Vmt3NLr
         gfPtbk6svP3zxgUar/FVwPnb1qnQycVcitA6I4MlLsx0ilOfV/RPhZwuxaQrg/YY2IPJ
         4yj4ixXdop259/5zEmgYqjS2qUMY6d117cHC6i32p/MvV6RsJjkzSwg2xfVwR63kAnRE
         NFQTdd9hUdLPm7iJh/BCc2u2ac2NJt+FD0sdobIYD6I5Uos+5lbPDStY2fjWxQyDCkFn
         OtT7yu5UezA6K0lAnyFEym/UfEhSoJq5q2G8wjqMMH+6iHYhO6q6ov3uDSvdHY1Q8/Uu
         7PYA==
X-Forwarded-Encrypted: i=1; AJvYcCU+RM4y27MDa087hgTBWsdr3/anIIW7EPzJsKXGCdSoKSDVyn0k5e9mH66IXr2i7rSrYvQOVFmcL81RH7wknk5rGCf+DlpH04Rp1aX2
X-Gm-Message-State: AOJu0YxlhXfa/Ziwk47XWcuGSxwWmWJA9UeeCQnEX5qA80bkyKv8EijM
	NNKBYPpDSjKt/TGroHffb64zv9P48jfUafk68LbPnqeKhFAA5S8LH28OLT/neu0=
X-Google-Smtp-Source: AGHT+IHv02i3bUWe97W+AMQ6Wm/DpdvU7UL0PD2+AVRJMmCdz/EkTQYkuN2YVA4GHU0hKqTEA6xPtQ==
X-Received: by 2002:a05:6808:6292:b0:3c9:6bf7:bb7f with SMTP id 5614622812f47-3c985309de7mr415150b6e.48.1715108540566;
        Tue, 07 May 2024 12:02:20 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id j14-20020a54480e000000b003c96bbe0e79sm909652oij.13.2024.05.07.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:02:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 4/4] iio: adc: ad7380: add support for multiple scan type
Date: Tue,  7 May 2024 14:02:08 -0500
Message-ID: <20240507-iio-add-support-for-multiple-scan-types-v1-4-95ac33ee51e9@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The AD783x chips have a resolution boost feature that allows for 2
extra bits of resolution. Previously, we had to choose a scan type to
fit the largest resolution and manipulate the raw data to fit when the
resolution was lower. This patch adds support for multiple scan types
for the voltage input channels so that we can support both resolutions
without having to manipulate the raw data.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 185 ++++++++++++++++++++++-------------------------
 1 file changed, 86 insertions(+), 99 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e240098708e9..ca317e3a72d9 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -89,14 +89,22 @@ struct ad7380_chip_info {
 	const struct ad7380_timing_specs *timing_specs;
 };
 
-/*
- * realbits/storagebits cannot be dynamically changed, so in order to
- * support the resolution boost (additional 2  bits of resolution)
- * we need to set realbits/storagebits to the maximum value i.e :
- *   - realbits = 16 + 2 = 18, and storagebits = 32 for 16-bits chips
- *   - realbits = 14 + 2 = 16, and storagebits = 16 for 14-bits chips
- * We need to adjust the scale depending on resolution boost status
- */
+/** scan type for 14-bit chips with resolution boost enabled. */
+static const struct iio_scan_type ad7380_scan_type_14_boost = {
+	.sign = 's',
+	.realbits = 16,
+	.storagebits = 16,
+	.endianness = IIO_CPU,
+};
+
+/** scan type for 16-bit chips with resolution boost enabled. */
+static const struct iio_scan_type ad7380_scan_type_16_boost = {
+	.sign = 's',
+	.realbits = 18,
+	.storagebits = 32,
+	.endianness = IIO_CPU,
+};
+
 #define AD7380_CHANNEL(index, bits, diff) {			\
 	.type = IIO_VOLTAGE,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
@@ -113,10 +121,12 @@ struct ad7380_chip_info {
 	.scan_index = (index),					\
 	.scan_type = {						\
 		.sign = 's',					\
-		.realbits = (bits) + 2,				\
-		.storagebits = ((bits) + 2 > 16) ? 32 : 16,	\
+		.realbits = (bits),				\
+		.storagebits = ((bits) > 16) ? 32 : 16,		\
 		.endianness = IIO_CPU,				\
 	},							\
+	.ext_scan_type = &ad7380_scan_type_##bits##_boost,	\
+	.num_ext_scan_type = 1,					\
 }
 
 #define DEFINE_AD7380_2_CHANNEL(name, bits, diff)	\
@@ -376,67 +386,62 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 	unreachable();
 }
 
-static int ad7380_prepare_spi_xfer(struct ad7380_state *st, struct spi_transfer *xfer)
+/**
+ * Reads one set of samples from the device. This is a simultaneous sampling
+ * chip, so all channels are always read at the same time.
+ *
+ * On successful return, the raw data is stored in st->scan_data.raw.
+ */
+static int ad7380_read_one_sample(struct ad7380_state *st,
+				  const struct iio_scan_type *scan_type)
 {
-	int bits_per_word;
-
-	memset(xfer, 0, sizeof(*xfer));
-
-	xfer->rx_buf = &st->scan_data.raw;
-
-	if (st->resolution_boost_enable == RESOLUTION_BOOST_ENABLE)
-		bits_per_word = st->chip_info->channels[0].scan_type.realbits;
-	else
-		bits_per_word = st->chip_info->channels[0].scan_type.realbits - 2;
-
-	xfer->bits_per_word = bits_per_word;
+	struct spi_transfer xfers[2] = {
+		/* toggle CS (no data xfer) to trigger a conversion */
+		{
+			.speed_hz = AD7380_REG_WR_SPEED_HZ,
+			.bits_per_word = scan_type->realbits,
+			.delay = {
+				.value = T_CONVERT_NS,
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+			.cs_change = 1,
+			.cs_change_delay = {
+				.value = st->chip_info->timing_specs->t_csh_ns,
+				.unit = SPI_DELAY_UNIT_NSECS,
+			},
+		},
+		{
+			.rx_buf = &st->scan_data.raw,
+			.len = BITS_TO_BYTES(scan_type->storagebits) *
+						(st->chip_info->num_channels - 1),
+			.bits_per_word = scan_type->realbits,
+		},
+	};
 
-	xfer->len = (st->chip_info->num_channels - 1) * BITS_TO_BYTES(bits_per_word);
+	/*
+	 * In normal average oversampling we need to wait for multiple conversions to be done
+	 */
+	if (st->oversampling_mode == OS_MODE_NORMAL_AVERAGE && st->oversampling_ratio > 1)
+		xfers[0].delay.value = T_CONVERT_NS + 500 * st->oversampling_ratio;
 
-	return bits_per_word;
+	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
 }
 
 static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
+	const struct iio_chan_spec *chan = &indio_dev->channels[0];
+	const struct iio_scan_type *scan_type = iio_get_current_scan_type(
+								indio_dev, chan);
 	struct ad7380_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer;
-	int bits_per_word, realbits, i, ret;
+	int ret;
 
-	realbits = st->chip_info->channels[0].scan_type.realbits;
-	bits_per_word = ad7380_prepare_spi_xfer(st, &xfer);
 
-	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	ret = ad7380_read_one_sample(st, scan_type);
 	if (ret)
 		goto out;
 
-	/*
-	 * If bits_per_word == realbits (resolution boost enabled), we don't
-	 * need to manipulate the raw data, otherwise we may need to fix things
-	 * up a bit to fit the scan_type specs
-	 */
-	if (bits_per_word < realbits) {
-		if (realbits > 16 && bits_per_word <= 16) {
-			/*
-			 * Here realbits > 16 so storagebits is 32 and bits_per_word is <= 16
-			 * so we need to sign extend u16 to u32 using reverse order to
-			 * avoid writing over union data
-			 */
-			for (i = st->chip_info->num_channels - 2; i >= 0; i--)
-				st->scan_data.raw.u32[i] = sign_extend32(st->scan_data.raw.u16[i],
-									 bits_per_word - 1);
-		} else if (bits_per_word < 16) {
-			/*
-			 * Here realbits <= 16 so storagebits is 16.
-			 * We only need to sign extend only if bits_per_word is < 16
-			 */
-			for (i = 0; i < st->chip_info->num_channels - 1; i++)
-				st->scan_data.raw.u16[i] = sign_extend32(st->scan_data.raw.u16[i],
-									 bits_per_word - 1);
-		}
-	}
-
 	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
 					   pf->timestamp);
 
@@ -447,47 +452,21 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 }
 
 static int ad7380_read_direct(struct ad7380_state *st,
-			      struct iio_chan_spec const *chan, int *val)
+			      struct iio_chan_spec const *chan,
+			      const struct iio_scan_type *scan_type,
+			      int *val)
 {
-	struct spi_transfer xfers[2] = {
-		/* toggle CS (no data xfer) to trigger a conversion */
-		{
-			.speed_hz = AD7380_REG_WR_SPEED_HZ,
-			.bits_per_word = chan->scan_type.realbits,
-			.delay = {
-				.value = T_CONVERT_NS,
-				.unit = SPI_DELAY_UNIT_NSECS,
-			},
-			.cs_change = 1,
-			.cs_change_delay = {
-				.value = st->chip_info->timing_specs->t_csh_ns,
-				.unit = SPI_DELAY_UNIT_NSECS,
-			},
-		},
-		/* then read all channels, it will be filled by ad7380_prepare_spi_xfer */
-		{
-		},
-	};
-	int bits_per_word, ret;
-
-	/*
-	 * In normal average oversampling we need to wait for multiple conversions to be done
-	 */
-	if (st->oversampling_mode == OS_MODE_NORMAL_AVERAGE && st->oversampling_ratio > 1)
-		xfers[0].delay.value = T_CONVERT_NS + 500 * st->oversampling_ratio;
-
-	bits_per_word = ad7380_prepare_spi_xfer(st, &xfers[1]);
+	int ret;
 
-	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
-	if (ret < 0)
+	ret = ad7380_read_one_sample(st, scan_type);
+	if (ret)
 		return ret;
-
-	if (bits_per_word > 16)
+	if (scan_type->storagebits > 16)
 		*val = sign_extend32(st->scan_data.raw.u32[chan->scan_index],
-				     bits_per_word - 1);
+				     scan_type->realbits - 1);
 	else
 		*val = sign_extend32(st->scan_data.raw.u16[chan->scan_index],
-				     bits_per_word - 1);
+				     scan_type->realbits - 1);
 
 	return IIO_VAL_INT;
 }
@@ -496,18 +475,14 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
 {
+	const struct iio_scan_type *scan_type = iio_get_current_scan_type(
+								indio_dev, chan);
 	struct ad7380_state *st = iio_priv(indio_dev);
-	int realbits;
-
-	if (st->resolution_boost_enable == RESOLUTION_BOOST_ENABLE)
-		realbits = chan->scan_type.realbits;
-	else
-		realbits = chan->scan_type.realbits - 2;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			return ad7380_read_direct(st, chan, val);
+			return ad7380_read_direct(st, chan, scan_type, val);
 		}
 		unreachable();
 	case IIO_CHAN_INFO_SCALE:
@@ -520,7 +495,7 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 		 * According to IIO ABI, offset is applied before scale,
 		 * so offset is: vcm_mv / scale
 		 */
-		*val = st->vcm_mv[chan->channel] * (1 << realbits)
+		*val = st->vcm_mv[chan->channel] * (1 << scan_type->realbits)
 			/ st->vref_mv;
 
 		return IIO_VAL_INT;
@@ -700,6 +675,17 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static const struct iio_scan_type *ad7380_get_current_scan_type(
+		const struct iio_dev *indio_dev, struct iio_chan_spec const *chan)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+
+	if (st->resolution_boost_enable && chan->num_ext_scan_type)
+		return chan->ext_scan_type;
+
+	return &chan->scan_type;
+}
+
 static ssize_t oversampling_mode_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
@@ -796,6 +782,7 @@ static const struct iio_info ad7380_info = {
 	.read_raw = &ad7380_read_raw,
 	.read_avail = &ad7380_read_avail,
 	.write_raw = &ad7380_write_raw,
+	.get_current_scan_type = &ad7380_get_current_scan_type,
 	.debugfs_reg_access = &ad7380_debugfs_reg_access,
 };
 

-- 
2.43.2


