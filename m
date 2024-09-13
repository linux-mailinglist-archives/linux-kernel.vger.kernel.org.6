Return-Path: <linux-kernel+bounces-328322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F197820F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3D31C244C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD861E0087;
	Fri, 13 Sep 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iBNbwzm1"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE7C1DEFC8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235879; cv=none; b=nd8yS2etZCWyGXxqKmpSM3z0v6nc1vuiiDOXb3SwKzkY0lOHIkLSrTQiDHieKT9iFf6AWJdIy84beNU2amWjkN3eCOhOJa3tKvMXRJfeWigTKj9f0vD5z5TIjFXtG6rssR3tcN7Qf8DlQhjjUZ+3a7ceTx2fuxMlVnvXB+qVQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235879; c=relaxed/simple;
	bh=AiPTW+eC15hy8WCQnEhvb/1uaDdvGFA0NbdJznajRXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLjkeRfndSUia9XZRBrc174c8t257P4aV3AP8aPRmfrzHTMMeL+4RP+FUmBdthGDSxahzWzF/MJFgpoNkcirFxoh09L6GmKtcOw+gNjxGYQgxTr8b3+ASETmDonRzlnblN9bvWsI+EOVvtHeBoupn9fSsBh4su7xZ/Q3qo+jfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iBNbwzm1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so8799945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726235875; x=1726840675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyNNlkM7L3gokB2vnij6JW+A3TweMpCxgtAx8xE2ujg=;
        b=iBNbwzm1e/oZb/b4NeMJyl1AD4Nv1u7USwuoT4Uvby+m+Vw0yYVC8SqueWuvx7BAzl
         ZksB5Kg2JUlFMkJNiEer16c1in9CAh/TkPknC5KgWIJXvzBq84VquDen1tQxb2tIffxW
         HcUBLau6XtAWvIAFndStzuig7SqfFmvwTnI0R7NQrMSVXf6aUxaKjDaIuBkVc7FxrSpu
         5Gwiw51ykI55tnwtWbxRyM4eAM3LVOw1m4BpMa4LiHWmZGFFpmHsH0j9TUBR/K0lBROa
         ROPx7qlE7FlBpZtUB6qkArOnttjAAzzI8mGAlptoxF0rUIc1wFqX8d1HA18tVHGFugnR
         Ej7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235875; x=1726840675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyNNlkM7L3gokB2vnij6JW+A3TweMpCxgtAx8xE2ujg=;
        b=EdZgjh5QPIopqquOyd/pZ1k/tdG0KhZe/+hAe+kaBd5BViNuq/Wk/hZhqnbWKVG7ok
         H6pz7lXr9Pqy5de6XHkiGzQ4RltNaqDiGFOpAyNPQ+j9IMdjWAbDuaVwqPd59Q0xcalz
         pu83YxXYz70lA+fQYHVupEeDhak5bvwN3yJSwbVEvhLP5szgV1r0UHgSHRpHXnf54Yqg
         M9CsbNJvKAXe7FvCagSTX14i1U0dx9unhxxmy6oNsgCna7YSkleDdfI6NeFI7imBHcNw
         2Iu+Efu4n/dYp5JD9xk9yR3uWAtxgZCrKPR/gpkYR/Yr+9u7Ezl4K5WRoobrCgr7bqos
         yoWw==
X-Forwarded-Encrypted: i=1; AJvYcCUENkpEW2B5yXJhKZYdGHFmRnjqzvW9fqGzSTivmds/a8zQSZvzxnWDuiyp5XrqGNY4bDIbi2FsWnuYOgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Eiwst7DrDjqIdsAwRfV8uDRKkVd/WLRRcRWsJFtUwQN/0cH/
	uGPpOex7/t8hIRlfZ0ekVrcBdtd6t3y5mlQ9QPh2XGBBD3f+5au2LTcjxPIH8XI=
X-Google-Smtp-Source: AGHT+IGv8RHBWrECjrXOKldME62lsBmNivGoVXAKsUStftQtY+4xoTqDtKqRAyrttnbq0zXmAf9NpQ==
X-Received: by 2002:a5d:6da6:0:b0:374:cd96:f73 with SMTP id ffacd0b85a97d-378d61d51bcmr1961956f8f.3.1726235875249;
        Fri, 13 Sep 2024 06:57:55 -0700 (PDT)
Received: from neptune.lan ([188.27.129.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3941sm17104749f8f.84.2024.09.13.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:57:54 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v6 4/8] iio: adc: ad7606: wrap channel ranges & scales into struct
Date: Fri, 13 Sep 2024 16:57:39 +0300
Message-ID: <20240913135744.152669-5-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913135744.152669-1-aardelean@baylibre.com>
References: <20240913135744.152669-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With the addition of AD7606C-16,18 which have differential & bipolar
channels (and ranges), which can vary from channel to channel, we'll need
to keep more information about each channel range.

To do that, we'll add a 'struct ad7606_chan_scale' type to hold just
configuration for each channel.
This includes the scales per channel (which can be different with
AD7606C-16,18), as well as the range for each channel.
This driver was already keeping the range value for each channel before,
and since this is couple with the scales, it also makes sense to put them
in the same struct.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 29 ++++++++++++++++++-----------
 drivers/iio/adc/ad7606.h | 22 ++++++++++++++++------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 7dc299aeee15..94a254c0725e 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -64,19 +64,21 @@ EXPORT_SYMBOL_NS_GPL(ad7606_reset, IIO_AD7606);
 
 static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st, int ch)
 {
+	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+
 	if (!st->sw_mode_en) {
 		/* tied to logic low, analog input range is +/- 5V */
-		st->range[ch] = 0;
-		st->scale_avail = ad7606_16bit_hw_scale_avail;
-		st->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
+		cs->range = 0;
+		cs->scale_avail = ad7606_16bit_hw_scale_avail;
+		cs->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
 		return 0;
 	}
 
 	/* Scale of 0.076293 is only available in sw mode */
 	/* After reset, in software mode, ±10 V is set by default */
-	st->range[ch] = 2;
-	st->scale_avail = ad7606_16bit_sw_scale_avail;
-	st->num_scales = ARRAY_SIZE(ad7606_16bit_sw_scale_avail);
+	cs->range = 2;
+	cs->scale_avail = ad7606_16bit_sw_scale_avail;
+	cs->num_scales = ARRAY_SIZE(ad7606_16bit_sw_scale_avail);
 
 	return 0;
 }
@@ -167,6 +169,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 {
 	int ret, ch = 0;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -180,8 +183,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		if (st->sw_mode_en)
 			ch = chan->address;
+		cs = &st->chan_scales[ch];
 		*val = 0;
-		*val2 = st->scale_avail[st->range[ch]];
+		*val2 = cs->scale_avail[cs->range];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
@@ -211,8 +215,9 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs = &st->chan_scales[0];
 
-	return ad7606_show_avail(buf, st->scale_avail, st->num_scales, true);
+	return ad7606_show_avail(buf, cs->scale_avail, cs->num_scales, true);
 }
 
 static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
@@ -250,19 +255,21 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs;
 	int i, ret, ch = 0;
 
 	guard(mutex)(&st->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		i = find_closest(val2, st->scale_avail, st->num_scales);
 		if (st->sw_mode_en)
 			ch = chan->address;
+		cs = &st->chan_scales[ch];
+		i = find_closest(val2, cs->scale_avail, cs->num_scales);
 		ret = st->write_scale(indio_dev, ch, i);
 		if (ret < 0)
 			return ret;
-		st->range[ch] = i;
+		cs->range = i;
 
 		return 0;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -707,7 +714,7 @@ static int ad7606_resume(struct device *dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, st->range[0]);
+		gpiod_set_value(st->gpio_range, st->chan_scales[0].range);
 		gpiod_set_value(st->gpio_standby, 1);
 		ad7606_reset(st);
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 95f3b3cb0be3..2b90f52affba 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -8,6 +8,8 @@
 #ifndef IIO_ADC_AD7606_H_
 #define IIO_ADC_AD7606_H_
 
+#define AD760X_MAX_CHANNELS	16
+
 #define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
@@ -66,17 +68,27 @@ struct ad7606_chip_info {
 	unsigned long			init_delay_ms;
 };
 
+/**
+ * struct ad7606_chan_scale - channel scale configuration
+ * @scale_avail		pointer to the array which stores the available scales
+ * @num_scales		number of elements stored in the scale_avail array
+ * @range		voltage range selection, selects which scale to apply
+ */
+struct ad7606_chan_scale {
+	const unsigned int		*scale_avail;
+	unsigned int			num_scales;
+	unsigned int			range;
+};
+
 /**
  * struct ad7606_state - driver instance specific data
  * @dev		pointer to kernel device
  * @chip_info		entry in the table of chips that describes this device
  * @bops		bus operations (SPI or parallel)
- * @range		voltage range selection, selects which scale to apply
+ * @chan_scales		scale configuration for channels
  * @oversampling	oversampling selection
  * @base_address	address from where to read data in parallel operation
  * @sw_mode_en		software mode enabled
- * @scale_avail		pointer to the array which stores the available scales
- * @num_scales		number of elements stored in the scale_avail array
  * @oversampling_avail	pointer to the array which stores the available
  *			oversampling ratios.
  * @num_os_ratios	number of elements stored in oversampling_avail array
@@ -100,12 +112,10 @@ struct ad7606_state {
 	struct device			*dev;
 	const struct ad7606_chip_info	*chip_info;
 	const struct ad7606_bus_ops	*bops;
-	unsigned int			range[16];
+	struct ad7606_chan_scale	chan_scales[AD760X_MAX_CHANNELS];
 	unsigned int			oversampling;
 	void __iomem			*base_address;
 	bool				sw_mode_en;
-	const unsigned int		*scale_avail;
-	unsigned int			num_scales;
 	const unsigned int		*oversampling_avail;
 	unsigned int			num_os_ratios;
 	int (*write_scale)(struct iio_dev *indio_dev, int ch, int val);
-- 
2.46.0


