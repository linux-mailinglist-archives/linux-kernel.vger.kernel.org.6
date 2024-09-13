Return-Path: <linux-kernel+bounces-328321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9A397820D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5C228872A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BB61DFE2B;
	Fri, 13 Sep 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pS0XT1WD"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148B1DEFDC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235878; cv=none; b=I1qSpYWp75pPd0ef7jrZSDOvgSwBema+slwNBDFJOD/E+4yueZr8HxGelmhXtzDjbsYLka6oRDOCGO3bQg8vnEfcUL8cMryqkQpN3Cqkz+Ixsv1+ajYTQB+mWZJipgTNd/F8i1PK0CbV6roun7WZy+KuyG89C+O3TA/ASbes46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235878; c=relaxed/simple;
	bh=63E+67ut4upizdiuiIAIWX+zYFAZeVjPavEhQ9/iZhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuRymXd02EKHgyO8w6G7CZ2V1bhTAWuFMaS8b8fHyGaOJeU/HYnElgL+erFxE4uWf+p76nfSK7Qa4YHmuKX3ufNeWvfQVfW5cI90dcIyZwzdzdlf77kY9rg0ksr/r2dk2TL8PPviUKxxBaAkTyyza8jqOgnYkOF3FPmYH9UiuIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pS0XT1WD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so1417573f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726235874; x=1726840674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGwDN6q9n1jJb2Ms/M/RGF868EKCCN0sUCPfjspQZyM=;
        b=pS0XT1WDOmi8z0nadyu2eWeHa8IbvHvrJNJqagjJoNCjZAniRjpMhZn8kaEsfsYAAz
         gblLpOhpiS5BBHvhlt8VIKCGeRNbQQKQ8aPRVqyhjPtYEV/uVS7Gzk9rFC6CVdwrFbzj
         hSVieBjtsoF6eKviNNziK4hTT/OIZfaJg18gIUjG2YezDHdqODD4N6dGGo1hxQsbLg7E
         U/zFBnE5UEVPnseotI76F/Wl+cPSPPslnJ90jOqIgypwpFbxOohE7SYdkRoWf/bo4QqF
         2lnboWb5oQpMCtnHNK+/qfQctfej5JmluakNGwnSGE1sqQ/ql7Xw6s0SN3q81bA5p0DI
         5dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235874; x=1726840674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGwDN6q9n1jJb2Ms/M/RGF868EKCCN0sUCPfjspQZyM=;
        b=Qo1cUxE+yiBjYW9feM4pf+9FuPUGRKjfLLCUEh8DOtcnbHCHBboarNOwrflrGKPASc
         DA6qP+xEuR+s3Y+zU/xjER88ziV8zJC6h6h2/RtIgUBFtmgBV18iKXcfI79+fQeaVUdG
         McLyyYm7wy/4Ua7GdmsAB3EM2WpF/vFZqFzFSdg1JOV6uaM8kpYUYgdhQLKAMAgvO33T
         +7ObHfhJaYP2wtNr8AGNqweqLNxHQS/fnscaS64AC9sBaUwL5MbTcY1mD+1STclcy5qs
         wqAOs9Uhx78FkeqP3MKUebvHu2BrJZJcPprEq6Yc/kIW+DA0CiK3/zLj5JT7bAcvFfWg
         lQiA==
X-Forwarded-Encrypted: i=1; AJvYcCVL3BWMlwP4WT3/8GfMZYXPwNazjyTLzkj7ihcDx7tNwlIiqxMEvp6oYdOYCFWbfQoPGEyDh9NUh39pA+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxebzgj7I6L+Bt9gQPVnalSAqbJ0N3641XsOs5NJAswvRbWwDen
	fSBidGVteomlnrCetyjE0w5CpNy58XAuhrWEXpjVfeXtn99rYKbg4aubjVbMXJA=
X-Google-Smtp-Source: AGHT+IE2C5BhArLhucm6UxlBmoiLDdxw8C7i4rKFzo5wgmOoa0CgKS8hgyUnXY2IZU8JTxf53yhotA==
X-Received: by 2002:a5d:4b82:0:b0:374:babf:ac4f with SMTP id ffacd0b85a97d-378c2cfec6bmr4144046f8f.12.1726235873516;
        Fri, 13 Sep 2024 06:57:53 -0700 (PDT)
Received: from neptune.lan ([188.27.129.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3941sm17104749f8f.84.2024.09.13.06.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:57:53 -0700 (PDT)
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
Subject: [PATCH v6 3/8] iio: adc: ad7606: move scale_setup as function pointer on chip-info
Date: Fri, 13 Sep 2024 16:57:38 +0300
Message-ID: <20240913135744.152669-4-aardelean@baylibre.com>
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

Up until now, all ADCs were 16-bit precision.
With the addition of the AD7606C some things will change. For one thing,
we'll need to setup available-scales for each channel. Also for the 18-bit
precision variants, the scales will be different.

This change adds a function-pointer to the chip-info struct to be able to
set this up (differently) for the new parts. For the current parts, the
scales are the same (for all parts) between HW and SW modes.

Also creating a 'ad7606_sw_mode_setup()' function that must be called
before the scale_setup callback. This is needed in case SW mode is enabled
for some ADCs.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 84 +++++++++++++++++++++++++++++-----------
 drivers/iio/adc/ad7606.h |  6 +++
 2 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 032a8135c912..7dc299aeee15 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -32,12 +32,12 @@
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
  * so that when applied to the raw values they provide mV values
  */
-static const unsigned int ad7606_scale_avail[2] = {
+static const unsigned int ad7606_16bit_hw_scale_avail[2] = {
 	152588, 305176
 };
 
 
-static const unsigned int ad7616_sw_scale_avail[3] = {
+static const unsigned int ad7606_16bit_sw_scale_avail[3] = {
 	76293, 152588, 305176
 };
 
@@ -62,6 +62,25 @@ int ad7606_reset(struct ad7606_state *st)
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_reset, IIO_AD7606);
 
+static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st, int ch)
+{
+	if (!st->sw_mode_en) {
+		/* tied to logic low, analog input range is +/- 5V */
+		st->range[ch] = 0;
+		st->scale_avail = ad7606_16bit_hw_scale_avail;
+		st->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
+		return 0;
+	}
+
+	/* Scale of 0.076293 is only available in sw mode */
+	/* After reset, in software mode, ±10 V is set by default */
+	st->range[ch] = 2;
+	st->scale_avail = ad7606_16bit_sw_scale_avail;
+	st->num_scales = ARRAY_SIZE(ad7606_16bit_sw_scale_avail);
+
+	return 0;
+}
+
 static int ad7606_reg_access(struct iio_dev *indio_dev,
 			     unsigned int reg,
 			     unsigned int writeval,
@@ -358,34 +377,40 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 	[ID_AD7605_4] = {
 		.channels = ad7605_channels,
 		.num_channels = 5,
+		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 	},
 	[ID_AD7606_8] = {
 		.channels = ad7606_channels_16bit,
 		.num_channels = 9,
+		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606_6] = {
 		.channels = ad7606_channels_16bit,
 		.num_channels = 7,
+		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606_4] = {
 		.channels = ad7606_channels_16bit,
 		.num_channels = 5,
+		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606B] = {
 		.channels = ad7606_channels_16bit,
 		.num_channels = 9,
+		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7616] = {
 		.channels = ad7616_channels,
 		.num_channels = 17,
+		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 		.oversampling_avail = ad7616_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
 		.os_req_reset = true,
@@ -523,6 +548,35 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
+static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	st->sw_mode_en = st->bops->sw_mode_config &&
+			 device_property_present(st->dev, "adi,sw-mode");
+	if (!st->sw_mode_en)
+		return 0;
+
+	indio_dev->info = &ad7606_info_os_range_and_debug;
+
+	return st->bops->sw_mode_config(indio_dev);
+}
+
+static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
+{
+	unsigned int num_channels = indio_dev->num_channels - 1;
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int ch, ret;
+
+	for (ch = 0; ch < num_channels; ch++) {
+		ret = st->chip_info->scale_setup_cb(st, ch);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
@@ -542,11 +596,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	mutex_init(&st->lock);
 	st->bops = bops;
 	st->base_address = base_address;
-	/* tied to logic low, analog input range is +/- 5V */
-	st->range[0] = 0;
 	st->oversampling = 1;
-	st->scale_avail = ad7606_scale_avail;
-	st->num_scales = ARRAY_SIZE(ad7606_scale_avail);
 
 	ret = devm_regulator_get_enable(dev, "avcc");
 	if (ret)
@@ -595,23 +645,13 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-	if (st->bops->sw_mode_config)
-		st->sw_mode_en = device_property_present(st->dev,
-							 "adi,sw-mode");
-
-	if (st->sw_mode_en) {
-		/* Scale of 0.076293 is only available in sw mode */
-		st->scale_avail = ad7616_sw_scale_avail;
-		st->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
-
-		/* After reset, in software mode, ±10 V is set by default */
-		memset32(st->range, 2, ARRAY_SIZE(st->range));
-		indio_dev->info = &ad7606_info_os_range_and_debug;
+	ret = ad7606_sw_mode_setup(indio_dev);
+	if (ret)
+		return ret;
 
-		ret = st->bops->sw_mode_config(indio_dev);
-		if (ret < 0)
-			return ret;
-	}
+	ret = ad7606_chan_scales_setup(indio_dev);
+	if (ret)
+		return ret;
 
 	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 					  indio_dev->name,
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 204a343067e5..95f3b3cb0be3 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -40,10 +40,15 @@
 
 #define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
 
+struct ad7606_state;
+
+typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st, int ch);
+
 /**
  * struct ad7606_chip_info - chip specific information
  * @channels:		channel specification
  * @num_channels:	number of channels
+ * @scale_setup_cb:	callback to setup the scales for each channel
  * @oversampling_avail	pointer to the array which stores the available
  *			oversampling ratios.
  * @oversampling_num	number of elements stored in oversampling_avail array
@@ -54,6 +59,7 @@
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
 	unsigned int			num_channels;
+	ad7606_scale_setup_cb_t		scale_setup_cb;
 	const unsigned int		*oversampling_avail;
 	unsigned int			oversampling_num;
 	bool				os_req_reset;
-- 
2.46.0


