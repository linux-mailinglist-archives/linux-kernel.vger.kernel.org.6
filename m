Return-Path: <linux-kernel+bounces-314406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478996B2CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B0D285594
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C8146D53;
	Wed,  4 Sep 2024 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cuxE5Ozr"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016B146018
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434849; cv=none; b=HORTKwoJp6Z4jLnnMvIjDaRuuQcV2dIF4DE1eCUoMZLoXAxXS4q/3xM5U0V6hJeM590EvZiDHTTUFH+COm2qScf1pL8wFxIu/EeNX8is14bp+Sn7BhHMcrm2cRZnbaNKMvuHGS0YHrdWwL7iO1b/ceoOlJSOTq8Mn2w8eq9EjNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434849; c=relaxed/simple;
	bh=m+JDUAFze61TKUmqgjZi4kJQBJPi7r7Nl0ZvyJY2pOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQ6JtiR18kNWiHS7cU9nd4CtRYFY7+J/C8FRzzdMfwzzOyab/NnLUoYu3dX7YzwSjtIM5CYcEXPfvf+RAxvXL81Gr7gug+IMnLTP1oYL9hswmVPBZ35wrsxgZOQct+w8MDhv1X5pL4p6dj1jcu+bwM2cAhg3UnnqOz2OD4pO3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cuxE5Ozr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8692bbec79so710986166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725434846; x=1726039646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwFKX15TuB+lP2XuqgSDKuPw5N2dTeJWzE8YjtBx2Ck=;
        b=cuxE5OzrT+uKeYOt9zbThDT2okBBiIDVMWXhJ2bRCpMR6CBEEl71/ssJSOyJXM4YHh
         TR76G5VWwfAmtqbUM4CsrguJnATstYrU5E6nKjk5JiBzvT52lXh6rsG8geq1mL40Xv6O
         cIZZRTvgpUmLxh0lrwJj7wvavvd2rhM1DBiq6shVfFpjIMqR6yND16FsHRBnx3umShET
         m7bCZT2Q21rfBLQIilRy3JExVEhwhBvPjWfEKgjPduQEpozRRHquN9S7WfTwnQsth23g
         2jRVJQrEl6sjuUMcMayaDGN48nOa0ZwIqAD+0Erqkq0CCZC3/3fn0YyLPXpJLAFrs/VQ
         Reow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434846; x=1726039646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwFKX15TuB+lP2XuqgSDKuPw5N2dTeJWzE8YjtBx2Ck=;
        b=kLwKq3/ppY4JL/5CPSuQHygiN0xk/Z8cX0gnmXMJH2j49KdkW616c1uFPs8WwSMtGY
         BsGNuP52oo0XsGtXCGIb8nt+In+OYLe+K8qiAwOPwQllCv0z+Pr7zmaJZ7Chh3ARs0xc
         kB2TPatZ6uWEvObjwmFN6DWLLjwzyXy7m0nlC+kALUTEeNc3UBti8KzIgqXEzZPByihI
         UEvh0T9HKzCDmoR7Rih24SiZyjLqmd7oC/u/AY6x248o8OMAl5hQdBk4gXgRap7BOZXe
         9K5Wa981ZmgylF2IHk4u/nG7gtCjL81PezSV/KtbNlMoWyNCFFgMTG2uO2pHwxwxT+P8
         o2Mg==
X-Forwarded-Encrypted: i=1; AJvYcCV4ufSnvpY0LEwOvrD3jKFaQizaqDetjyivAExc2Ei1YNQPa8oW7qSXcX5Dn00zz4WQXhbP3wWWkzS3weQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxproamZhCx62vps+TZyB/xxNbxOHUQbKSmt+0HKRp6AD6JFgTC
	aaeK950c1txFSnJfG+pgW4VAJMyHnoFS7ISIgGy2KLRZJ9cR99D47PQGLGi2J1s=
X-Google-Smtp-Source: AGHT+IHdAnMtwj2cVJbtZC+1VjqYoA2vYtSW6YnnAqQZ+P2tzmJFo0NH4EeOchNQen+3iiA9+YRyVA==
X-Received: by 2002:a17:906:478c:b0:a86:6fa8:c6a3 with SMTP id a640c23a62f3a-a89a36d084dmr1007250566b.39.1725434844861;
        Wed, 04 Sep 2024 00:27:24 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d77fasm771151766b.167.2024.09.04.00.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:27:24 -0700 (PDT)
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
Subject: [PATCH v3 1/8] iio: adc: ad7606: add 'bits' parameter to channels macros
Date: Wed,  4 Sep 2024 10:27:09 +0300
Message-ID: <20240904072718.1143440-2-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904072718.1143440-1-aardelean@baylibre.com>
References: <20240904072718.1143440-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some newer additions to the AD7606 family, which support 18 bit
precision.
Up until now, all chips were 16 bit.

This change adds a 'bits' parameter to the AD760X_CHANNEL macro and renames
'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.

The AD7606_SW_CHANNEL() macro is also introduced, as a short-hand for IIO
channels in SW mode.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 58 ++++++++++++++++++------------------
 drivers/iio/adc/ad7606.h     | 18 ++++++-----
 drivers/iio/adc/ad7606_spi.c | 16 +++++-----
 3 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 539e4a8621fe..dba1f28782e4 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -333,16 +333,16 @@ static const struct iio_chan_spec ad7605_channels[] = {
 	AD7605_CHANNEL(3),
 };
 
-static const struct iio_chan_spec ad7606_channels[] = {
+static const struct iio_chan_spec ad7606_channels_16bit[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0),
-	AD7606_CHANNEL(1),
-	AD7606_CHANNEL(2),
-	AD7606_CHANNEL(3),
-	AD7606_CHANNEL(4),
-	AD7606_CHANNEL(5),
-	AD7606_CHANNEL(6),
-	AD7606_CHANNEL(7),
+	AD7606_CHANNEL(0, 16),
+	AD7606_CHANNEL(1, 16),
+	AD7606_CHANNEL(2, 16),
+	AD7606_CHANNEL(3, 16),
+	AD7606_CHANNEL(4, 16),
+	AD7606_CHANNEL(5, 16),
+	AD7606_CHANNEL(6, 16),
+	AD7606_CHANNEL(7, 16),
 };
 
 /*
@@ -357,22 +357,22 @@ static const struct iio_chan_spec ad7606_channels[] = {
  */
 static const struct iio_chan_spec ad7616_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(16),
-	AD7606_CHANNEL(0),
-	AD7606_CHANNEL(1),
-	AD7606_CHANNEL(2),
-	AD7606_CHANNEL(3),
-	AD7606_CHANNEL(4),
-	AD7606_CHANNEL(5),
-	AD7606_CHANNEL(6),
-	AD7606_CHANNEL(7),
-	AD7606_CHANNEL(8),
-	AD7606_CHANNEL(9),
-	AD7606_CHANNEL(10),
-	AD7606_CHANNEL(11),
-	AD7606_CHANNEL(12),
-	AD7606_CHANNEL(13),
-	AD7606_CHANNEL(14),
-	AD7606_CHANNEL(15),
+	AD7606_CHANNEL(0, 16),
+	AD7606_CHANNEL(1, 16),
+	AD7606_CHANNEL(2, 16),
+	AD7606_CHANNEL(3, 16),
+	AD7606_CHANNEL(4, 16),
+	AD7606_CHANNEL(5, 16),
+	AD7606_CHANNEL(6, 16),
+	AD7606_CHANNEL(7, 16),
+	AD7606_CHANNEL(8, 16),
+	AD7606_CHANNEL(9, 16),
+	AD7606_CHANNEL(10, 16),
+	AD7606_CHANNEL(11, 16),
+	AD7606_CHANNEL(12, 16),
+	AD7606_CHANNEL(13, 16),
+	AD7606_CHANNEL(14, 16),
+	AD7606_CHANNEL(15, 16),
 };
 
 static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
@@ -382,25 +382,25 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 		.num_channels = 5,
 	},
 	[ID_AD7606_8] = {
-		.channels = ad7606_channels,
+		.channels = ad7606_channels_16bit,
 		.num_channels = 9,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606_6] = {
-		.channels = ad7606_channels,
+		.channels = ad7606_channels_16bit,
 		.num_channels = 7,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606_4] = {
-		.channels = ad7606_channels,
+		.channels = ad7606_channels_16bit,
 		.num_channels = 5,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606B] = {
-		.channels = ad7606_channels,
+		.channels = ad7606_channels_16bit,
 		.num_channels = 9,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 0c6a88cc4695..771121350f98 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -8,7 +8,7 @@
 #ifndef IIO_ADC_AD7606_H_
 #define IIO_ADC_AD7606_H_
 
-#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) {	\
+#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = num,					\
@@ -19,24 +19,26 @@
 		.scan_index = num,				\
 		.scan_type = {					\
 			.sign = 's',				\
-			.realbits = 16,				\
-			.storagebits = 16,			\
+			.realbits = (bits),			\
+			.storagebits = (bits),			\
 			.endianness = IIO_CPU,			\
 		},						\
 }
 
 #define AD7605_CHANNEL(num)				\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
-		BIT(IIO_CHAN_INFO_SCALE), 0)
+		BIT(IIO_CHAN_INFO_SCALE), 0, 16)
 
-#define AD7606_CHANNEL(num)				\
+#define AD7606_CHANNEL(num, bits)			\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
 		BIT(IIO_CHAN_INFO_SCALE),		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
 
-#define AD7616_CHANNEL(num)	\
+#define AD7606_SW_CHANNEL(num, bits)	\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
-		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
+		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
+
+#define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
 
 /**
  * struct ad7606_chip_info - chip specific information
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 62ec12195307..e00f58a6a0e9 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -67,14 +67,14 @@ static const struct iio_chan_spec ad7616_sw_channels[] = {
 
 static const struct iio_chan_spec ad7606b_sw_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7616_CHANNEL(0),
-	AD7616_CHANNEL(1),
-	AD7616_CHANNEL(2),
-	AD7616_CHANNEL(3),
-	AD7616_CHANNEL(4),
-	AD7616_CHANNEL(5),
-	AD7616_CHANNEL(6),
-	AD7616_CHANNEL(7),
+	AD7606_SW_CHANNEL(0, 16),
+	AD7606_SW_CHANNEL(1, 16),
+	AD7606_SW_CHANNEL(2, 16),
+	AD7606_SW_CHANNEL(3, 16),
+	AD7606_SW_CHANNEL(4, 16),
+	AD7606_SW_CHANNEL(5, 16),
+	AD7606_SW_CHANNEL(6, 16),
+	AD7606_SW_CHANNEL(7, 16),
 };
 
 static const unsigned int ad7606B_oversampling_avail[9] = {
-- 
2.46.0


