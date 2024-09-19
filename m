Return-Path: <linux-kernel+bounces-333495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A337697C9A3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C031F23E74
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A668919E83F;
	Thu, 19 Sep 2024 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MFTY8Fke"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEE19D892
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751094; cv=none; b=s0P6r6B5X0D2ctnWaaIz+eBJRghWeRrl8SH2CSEJa8z82gaWIMuBkV710iChpP2HVQxwAhNW5EP/AnLJii9ZrPLsvsbcX28Q30+s1BRmpFp6sB8ek/I1BVSgTnY+5SPqXYGSYO1VbWhqImXkSTr5ffBMKJEJZio8cnVJmdd0Q8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751094; c=relaxed/simple;
	bh=7jeDEErQ+xBSjvZ9RT/TEcexKXO8icQCIcZ4pRA2dbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SikD552V5m7ea71DnivB1ktPk02s0XiCkqpjtu2XWsa/RsK+wI/vUjnEBbLROMEwQuwwNmApQFrNyZtdY41YhwZlcnTiJJY6YaCdS332jvlb1OdhV9rUANiKa6aVsK0qX6BBwL0dETK+O3FD9++ofz8bJTFT5VTQIqxXK/9fB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MFTY8Fke; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso1049496a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726751091; x=1727355891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWLUgthTvXLTW08JjjEElu7+ziFuVs/iQEkeWDpV0KA=;
        b=MFTY8FkeCfksuk8FcdznELF/uzWI1EQ0g0jCBshhzvxxjfc76NX1sZa/30ktKkVSbl
         lwXRylojqzL6FKXmIQuXU155l6540IeuY2G42UUhBzpSxeHru+SIf3MKuE9OGYmaPAGd
         98guD3o4qS/7r20hczXakVTBYAwd6JUDN634gV1lFV2sordzV/4TPjhEkXqvWt7kcJlk
         JlEzaBxFy4cPK2RPydTPk+OK1tfUKhgcE86JhrNvq+kc30qgVlU8LPCDx4X6Sr1dSXOh
         MS/EhiCDDzR615pen7ImTG/fN2ljWNUKcLuHDOk6ym2wVuJcYnJMJLby1btrBEgJ+bvt
         ojBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726751091; x=1727355891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWLUgthTvXLTW08JjjEElu7+ziFuVs/iQEkeWDpV0KA=;
        b=PHcqGUFBDqtO2d6WuDGmLHl5QmhgoPW5Im/gqz4NK1JWNVylo62zHckR572VbBk16q
         ybJMvsYQovCTMTk7KT/pgWDrzP1awI3llCuVoXsl6F+ix1JaTZKX44ghCAv1F72hawug
         tyFUWqSKz0pt+HMGxgUkSN80Y/FVBxFX9Nj5VwjOMfgLUAhmfNTLVgVLwfw5ZGtdiPwR
         Loe5reL7SpLfID6OhpJ6Nu7ovTh+gNaoYfOy4PvOwnPChRZ0ORIL8arh00+wYmHXHQ/8
         RCT81usn0Yv7PV6aOCIPKKXjlX4o0+APsnKBpgmAfPduLvTIfuYQewHV72P/ZHQVdT47
         skBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+/sTL2dZ4pdH+KGHPdbbYA60jzwN6jPymtjmzbwD2TcFwCxFK0pL+3nnRN0iaVCWTQPo1yQK3rgf8O/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LdYrXSRgQLcquTxVhqm1CFquW2TBf0fqHSxceP06LpxzKzCH
	JcDkZshhHNLYd0uCkle+a+vfWVAOPSu0e9xKAN7ZnunEl1n1wXfGWRdnnR+YoiQ=
X-Google-Smtp-Source: AGHT+IFCzw8baFkNf0BgCzVZQgQ3gbw6b+bcEnMmiDQX9iGDzFn09M+1ygpCg5C6XyrB59wxuSzCTw==
X-Received: by 2002:a17:906:794b:b0:a86:a4b1:d2b8 with SMTP id a640c23a62f3a-a90293b1860mr2515563166b.4.1726751090966;
        Thu, 19 Sep 2024 06:04:50 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90cbc7122esm53213166b.124.2024.09.19.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:04:50 -0700 (PDT)
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
Subject: [PATCH v7 1/8] iio: adc: ad7606: add 'bits' parameter to channels macros
Date: Thu, 19 Sep 2024 16:04:36 +0300
Message-ID: <20240919130444.2100447-2-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919130444.2100447-1-aardelean@baylibre.com>
References: <20240919130444.2100447-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some newer additions to the AD7606 family, which support 18 bit
precision. Up until now, all chips were 16 bit.

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
index 9b457472d49c..8ebfe8abc3f4 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -309,16 +309,16 @@ static const struct iio_chan_spec ad7605_channels[] = {
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
@@ -333,22 +333,22 @@ static const struct iio_chan_spec ad7606_channels[] = {
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
@@ -358,25 +358,25 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
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
index 6649e84d25de..204a343067e5 100644
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
+			.storagebits = (bits) > 16 ? 32 : 16,	\
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


