Return-Path: <linux-kernel+bounces-319679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A3970074
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DD51F23BB2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACEE14884C;
	Sat,  7 Sep 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tl+AxXpz"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94B8157E87
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725691862; cv=none; b=hXwXvosDhaJaYZ6GlrPpdhUJuifBcEUQbPkqpk7mMmUygrgZ9ignEcWgwZ2Y0c0+Hi38SmlN/ODvXAiCqu6pjUXdC88o3ZEfJ4N1oHvHyxnCdXWIUdhk5/L2ierkbx/YEyyTKs96xFHdKDjwDhhGl46oJ+k259GSAuS+F0zB4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725691862; c=relaxed/simple;
	bh=UrQVZr2Ut7tXRzDLHI6k+MfrW96ZgN+yhIcNORux8Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RewQQUBBeIk//6gekPxt3XD8sPVzOoH+dJW6cGRSvr2T8TyV1/EDyOuMrdIGUaGNEIHbGeCjIy0WmdaqImxMt4cq62SHJruZxY4yJdSrkLFElRW0hQqck0Nu6kGTw2+g315ZOb7zP3NvopuTpxgwkEtpeUDXnrgWDkpJMiBWDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tl+AxXpz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f74e613a10so343911fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725691859; x=1726296659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMcKOFwkI5rA4jvBzx/C0roj6f73aPe0+suqT1cOIBQ=;
        b=tl+AxXpzQ2NKZcFeWUvLxYl9tgyQXqjMlMichhsSjBQg6YzgDW3oxMJfEqJHJEK5jV
         VZhURuRMwWXdh3XzSRAI0dtv8liS9k6hjqUkMB9YDKOVOPrWH+p8lE9WzrELtwhZ0POV
         f+c6PPONyHhZPnT9wU6SEhm1S+SoQCF6Z6SK+IXVF/4+teJGU+XAFAF+Bo4nTpRL63B0
         Im5Vkkm5BQ8SRqoUc4GGvOrA4l3e6d/55m/gAMYwNP0rdS8CGkUm8+mNjGvWmyeLdv+F
         h93zmTsDiTVCnHAt5j+yIL+0d23dwYdGdnGqJIm+wEnOW1StXXMspFkzGuAgBlnXJWjN
         LNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725691859; x=1726296659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMcKOFwkI5rA4jvBzx/C0roj6f73aPe0+suqT1cOIBQ=;
        b=IvQv0dBUycOZW8aX1xhas9kBoU34hKz+Vf2PnwgLArEV2nS7RCAHMkV6yj0J9Nla5R
         ADEjMgKoOQNjsb8Bn4WyFZTGb+ZDnHveJpldpN2t4fgXOKCsimaWvihHh2YOr7Q6SBtK
         /+820/wl2Up17e/CqimqCfQCPVwNS1SkKrmt5f2S3pdkbfHSI4HpojKU0gffYKUQuxCA
         nimFAoeRJkC7oL3R0DDBOrho6Z1xEAc7GmtbiHgyh+XC1HxMNledQ4k9I/xrkwDB5ozl
         mM4B8T0OldEzD+GJrHAl7aYmh6S//3q090mAKx03tUVCSZRQZYdpvyqAC4zK0YfqrEgf
         fTjw==
X-Forwarded-Encrypted: i=1; AJvYcCV3cqrFKIudWAELHsPgW+ve+9makMPQiiORHX83iwAVo+jya/i22S+mCfIoMYTOK7aSYLbxF/27fbnLWTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSAHqeHrThNkVZFnX01HqyvSoI02TRlXAld3fLSfQ3QAqI7J0b
	votlqzQqlyfpZSmujVa1vPDMaiCMORgpLPKjuK7+o2eZoFBbxW2wMssAxd7PZb8=
X-Google-Smtp-Source: AGHT+IEY5tdhxR8rZimtBcmWuZd+S2OGAxIzohVmU4P1L3XcjB9nocDnAsvxsLEZEqokzoNR2fysmA==
X-Received: by 2002:a05:6512:308f:b0:52c:dcdc:f186 with SMTP id 2adb3069b0e04-536587b96b1mr3505379e87.27.1725691858839;
        Fri, 06 Sep 2024 23:50:58 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835a76sm36539266b.39.2024.09.06.23.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 23:50:58 -0700 (PDT)
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
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v5 6/9] iio: adc: ad7606: rework available attributes for SW channels
Date: Sat,  7 Sep 2024 09:50:39 +0300
Message-ID: <20240907065043.771364-7-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907065043.771364-1-aardelean@baylibre.com>
References: <20240907065043.771364-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For SW mode, the oversampling and scales attributes are always present.
So, they can be implemented via a 'read_avail' hook in iio_info.

For HW mode, it's a bit tricky, as these attributes get assigned based on
GPIO definitions.

So, for SW mode, we define a separate AD7606_SW_CHANNEL() macro, and use
that for the SW channels.
And 'ad7606_info_os_range_and_debug' can be renamed to
'ad7606_info_sw_mode' as it is only used for SW mode.

For the 'read_avail' hook, we'll need to allocate the SW scales, so that
they are just returned userspace without any extra processing.
The allocation will happen when then ad7606_state struct is allocated.
The oversampling available parameters don't need any extra processing; they
can just be passed back to userspace (as they are).

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 63 ++++++++++++++++++++++++++++++++++++----
 drivers/iio/adc/ad7606.h | 31 +++++++++++++++++---
 2 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 39ef72a8acd2..364f16fb96bf 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -483,6 +483,37 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int ad7606_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	struct ad7606_chan_scale *cs;
+	unsigned int ch = 0;
+
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = st->oversampling_avail;
+		*length = st->num_os_ratios;
+		*type = IIO_VAL_INT;
+
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_SCALE:
+		if (st->sw_mode_en)
+			ch = chan->address;
+
+		cs = &st->chan_scales[ch];
+		*vals = cs->scale_avail_show;
+		*length = cs->num_scales * 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+
+		return IIO_AVAIL_LIST;
+	}
+	return -EINVAL;
+}
+
 static const struct iio_buffer_setup_ops ad7606_buffer_ops = {
 	.postenable = &ad7606_buffer_postenable,
 	.predisable = &ad7606_buffer_predisable,
@@ -500,11 +531,11 @@ static const struct iio_info ad7606_info_os_and_range = {
 	.validate_trigger = &ad7606_validate_trigger,
 };
 
-static const struct iio_info ad7606_info_os_range_and_debug = {
+static const struct iio_info ad7606_info_sw_mode = {
 	.read_raw = &ad7606_read_raw,
 	.write_raw = &ad7606_write_raw,
+	.read_avail = &ad7606_read_avail,
 	.debugfs_reg_access = &ad7606_reg_access,
-	.attrs = &ad7606_attribute_group_os_and_range,
 	.validate_trigger = &ad7606_validate_trigger,
 };
 
@@ -530,7 +561,7 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 {
 	unsigned int num_channels = indio_dev->num_channels - 1;
 	struct ad7606_state *st = iio_priv(indio_dev);
-	int ch;
+	int ret, ch;
 
 	if (!st->bops->sw_mode_config)
 		return 0;
@@ -539,7 +570,7 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 	if (!st->sw_mode_en)
 		return 0;
 
-	indio_dev->info = &ad7606_info_os_range_and_debug;
+	indio_dev->info = &ad7606_info_sw_mode;
 
 	/* Scale of 0.076293 is only available in sw mode */
 	/* After reset, in software mode, ±10 V is set by default */
@@ -551,7 +582,29 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 		cs->range = 2;
 	}
 
-	return st->bops->sw_mode_config(indio_dev);
+	ret = st->bops->sw_mode_config(indio_dev);
+	if (ret)
+		return ret;
+
+	for (ch = 0; ch < num_channels; ch++) {
+		struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+		int i;
+
+		cs = &st->chan_scales[ch];
+
+		if (cs->num_scales * 2 > AD760X_MAX_SCALE_SHOW) {
+			dev_err(st->dev, "Driver error: scale range too big");
+			return -ERANGE;
+		}
+
+		/* Generate a scale_avail list for showing to userspace */
+		for (i = 0; i < cs->num_scales; i++) {
+			cs->scale_avail_show[i * 2] = 0;
+			cs->scale_avail_show[i * 2 + 1] = cs->scale_avail[i];
+		}
+	}
+
+	return 0;
 }
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 635407c2acc0..fa175cff256c 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -27,6 +27,29 @@
 		},						\
 }
 
+#define AD7606_SW_CHANNEL(num, bits) {				\
+		.type = IIO_VOLTAGE,				\
+		.indexed = 1,					\
+		.channel = num,					\
+		.address = num,					\
+		.info_mask_separate =				\
+			BIT(IIO_CHAN_INFO_RAW) |		\
+			BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_separate_available =			\
+			BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_shared_by_all =			\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.info_mask_shared_by_all_available =		\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.scan_index = num,				\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = (bits),			\
+			.storagebits = (bits) > 16 ? 32 : 16,	\
+			.endianness = IIO_CPU,			\
+		},						\
+}
+
 #define AD7605_CHANNEL(num)				\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
 		BIT(IIO_CHAN_INFO_SCALE), 0, 16)
@@ -36,10 +59,6 @@
 		BIT(IIO_CHAN_INFO_SCALE),		\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
 
-#define AD7606_SW_CHANNEL(num, bits)	\
-	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
-		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
-
 #define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
 
 /**
@@ -65,11 +84,15 @@ struct ad7606_chip_info {
 /**
  * struct ad7606_chan_scale - channel scale configuration
  * @scale_avail		pointer to the array which stores the available scales
+ * @scale_avail_show	a duplicate of 'scale_avail' which is readily formatted
+ *			such that it can be read via the 'read_avail' hook
  * @num_scales		number of elements stored in the scale_avail array
  * @range		voltage range selection, selects which scale to apply
  */
 struct ad7606_chan_scale {
+#define AD760X_MAX_SCALE_SHOW		(AD760X_MAX_CHANNELS * 2)
 	const unsigned int		*scale_avail;
+	int				scale_avail_show[AD760X_MAX_SCALE_SHOW];
 	unsigned int			num_scales;
 	unsigned int			range;
 };
-- 
2.46.0


