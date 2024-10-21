Return-Path: <linux-kernel+bounces-374037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3E9A60F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725361F22883
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E21E5722;
	Mon, 21 Oct 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kATdHh58"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08321E47B8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504819; cv=none; b=p+ny6sJrR7T1BaRJiPETYBSJM+E+5gZXwJKbo9a7BLWSvfnlNqDVjyxHF6Xegucsqh9dfU+WpfGAZtQu8+9xRmNjPfA03d/m1QxmWthNk6JW/TJrivaoHU2WHHStxrJ6ZZ9uC2MlAbY4qaA92zzzBJAzXXj2ulZp8PUFIycSngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504819; c=relaxed/simple;
	bh=CLWgS17xU2QNj818aWqPE/gqen+525xGgHzoq/mwX6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DofcUbUbw17CUAhrk4suRxrhYIEXT98ua/lnoz5M6iVWd9UaVefe+84LOroiwT74+AhM9ttTXuIgiLSyOyrZENy/SE8GpDEbFp/H0j8g2ZGbvdknbU/qTvjxB/VyqyDAT60c3Ap1oad7MDduy8bpYdv857XdVOEbN5D4ROlj7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kATdHh58; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so45126695e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729504815; x=1730109615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSAuKhPnRKrQtznNZ2b2Xb8z5UtqTMbdPxuKnBZE3RU=;
        b=kATdHh58n/tHc0+DDk056Fc4+TbSwnN/u2Of7MTyd/acjEIa04vXzU+9bwrTCPaYWS
         0eyzmdmk+fjb5WUo6OFhU13vR8b18PTF+2P4hvj5iMMPg16Pe/5TCz7xaohy2MMuSQ52
         Mk4Hc6NTU+MqyzLBGZpDoifV2izGcgdIBozFRoPXIunFPheblL38EysDN8/niGzNo9bP
         2ZUCCWqkrvFEvGhU7ZEiayuFLmmrk2j696JGJW6WzCxfDcB6IE/8gfpp8amr7JM4EPkY
         Z4qA37XkVb8X2AZkKB+xb/wT2ckkLfrnspiPmbC/LMzcbenfsOmki1gLZ3jO+MyLNFut
         qoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504815; x=1730109615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSAuKhPnRKrQtznNZ2b2Xb8z5UtqTMbdPxuKnBZE3RU=;
        b=dRA6w1Ty2nnnPVD5xkNiAMt9Wus3B80NA0ec8LllmbXW0PkHiVUftUcA4c4LQUYDTF
         sAX16M9IExePdyYjqwM1w05z6TNpAjpl72SWRKjYNpgaTDQFvRHwYjEFoTj9+Fs3z3XR
         MFQbyhoVupywkubOR93UdRcYaJdQ0SywcWtUGzOLDHQAlJnOCkU5nCT0IWqJxGjgYCWS
         RDcAN+DUIqoR8W5i8mj/fOn6zGkdc9QRGivxpCrvwzz7WdlFJNLvGWRF83xslp+S/w7g
         R+kqIj9lyAvcHAwpkE0PkMTzcP513jvzTa5K6KVVpxnvT8CvHe1njbACFMLt9Gq8HZIu
         NCVA==
X-Forwarded-Encrypted: i=1; AJvYcCVxAEa6Bq3PqkOkwHjl1Tyx/MuAxrZCf9D6Fl5NF81PDB/JQa6hKt9tGK+BUv6VFxc2sKJmhAnEUS6Yhx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEd+bIwBYrfr+PwDU6u74TgfJevbHSCZmmt43kkzo0kMAs0uA
	96SJbE1wJ/lkHOdTOvR2hGO67+NWYDcGfet4wjp0pBbDVIszkPLYijAHARAjaRk=
X-Google-Smtp-Source: AGHT+IHfwxl2M2jZBLMcvDu4oqoDJ3/yF2Audoq/iqQ+uv2BSUteZWTzxhvukc+D1YDNPQlWSQfcwQ==
X-Received: by 2002:a05:600c:6747:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-4316161f2fcmr91828815e9.1.1729504815144;
        Mon, 21 Oct 2024 03:00:15 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58bbaasm52375995e9.23.2024.10.21.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:00:14 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 21 Oct 2024 12:00:11 +0200
Subject: [PATCH v2 3/5] iio: adc: ad7380: add missing supplies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-ad7380-fix-supplies-v2-3-2ca551b3352a@baylibre.com>
References: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
In-Reply-To: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

vcc and vlogic are required but are not retrieved and enabled in the
probe. Add them.

In order to prepare support for additional parts requiring different
supplies, add vcc and vlogic to the platform specific structures

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e033c734191143a25a490b09c730dbf95f796737..e257f78d63edd7910fcb936ec5344922f8e70b99 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -75,6 +75,7 @@
 #define T_CONVERT_NS 190		/* conversion time */
 #define T_CONVERT_0_NS 10		/* 1st conversion start time (oversampling) */
 #define T_CONVERT_X_NS 500		/* xth conversion start time (oversampling) */
+#define T_POWERUP_MS 5			/* Power up */
 
 struct ad7380_timing_specs {
 	const unsigned int t_csh_ns;	/* CS minimum high time */
@@ -86,6 +87,8 @@ struct ad7380_chip_info {
 	unsigned int num_channels;
 	unsigned int num_simult_channels;
 	bool has_mux;
+	const char * const *supplies;
+	unsigned int num_supplies;
 	const char * const *vcm_supplies;
 	unsigned int num_vcm_supplies;
 	const unsigned long *available_scan_masks;
@@ -243,6 +246,10 @@ DEFINE_AD7380_8_CHANNEL(ad7386_4_channels, 16, 0, u);
 DEFINE_AD7380_8_CHANNEL(ad7387_4_channels, 14, 0, u);
 DEFINE_AD7380_8_CHANNEL(ad7388_4_channels, 12, 0, u);
 
+static const char * const ad7380_supplies[] = {
+	"vcc", "vlogic",
+};
+
 static const char * const ad7380_2_channel_vcm_supplies[] = {
 	"aina", "ainb",
 };
@@ -338,6 +345,8 @@ static const struct ad7380_chip_info ad7380_chip_info = {
 	.channels = ad7380_channels,
 	.num_channels = ARRAY_SIZE(ad7380_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
 };
@@ -347,6 +356,8 @@ static const struct ad7380_chip_info ad7381_chip_info = {
 	.channels = ad7381_channels,
 	.num_channels = ARRAY_SIZE(ad7381_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
 };
@@ -356,6 +367,8 @@ static const struct ad7380_chip_info ad7383_chip_info = {
 	.channels = ad7383_channels,
 	.num_channels = ARRAY_SIZE(ad7383_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.vcm_supplies = ad7380_2_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
@@ -367,6 +380,8 @@ static const struct ad7380_chip_info ad7384_chip_info = {
 	.channels = ad7384_channels,
 	.num_channels = ARRAY_SIZE(ad7384_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.vcm_supplies = ad7380_2_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
@@ -378,6 +393,8 @@ static const struct ad7380_chip_info ad7386_chip_info = {
 	.channels = ad7386_channels,
 	.num_channels = ARRAY_SIZE(ad7386_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
@@ -388,6 +405,8 @@ static const struct ad7380_chip_info ad7387_chip_info = {
 	.channels = ad7387_channels,
 	.num_channels = ARRAY_SIZE(ad7387_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
@@ -398,6 +417,8 @@ static const struct ad7380_chip_info ad7388_chip_info = {
 	.channels = ad7388_channels,
 	.num_channels = ARRAY_SIZE(ad7388_channels),
 	.num_simult_channels = 2,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
@@ -408,6 +429,8 @@ static const struct ad7380_chip_info ad7380_4_chip_info = {
 	.channels = ad7380_4_channels,
 	.num_channels = ARRAY_SIZE(ad7380_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -417,6 +440,8 @@ static const struct ad7380_chip_info ad7381_4_chip_info = {
 	.channels = ad7381_4_channels,
 	.num_channels = ARRAY_SIZE(ad7381_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
 };
@@ -426,6 +451,8 @@ static const struct ad7380_chip_info ad7383_4_chip_info = {
 	.channels = ad7383_4_channels,
 	.num_channels = ARRAY_SIZE(ad7383_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.vcm_supplies = ad7380_4_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
@@ -437,6 +464,8 @@ static const struct ad7380_chip_info ad7384_4_chip_info = {
 	.channels = ad7384_4_channels,
 	.num_channels = ARRAY_SIZE(ad7384_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.vcm_supplies = ad7380_4_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
@@ -448,6 +477,8 @@ static const struct ad7380_chip_info ad7386_4_chip_info = {
 	.channels = ad7386_4_channels,
 	.num_channels = ARRAY_SIZE(ad7386_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
@@ -458,6 +489,8 @@ static const struct ad7380_chip_info ad7387_4_chip_info = {
 	.channels = ad7387_4_channels,
 	.num_channels = ARRAY_SIZE(ad7387_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
@@ -468,6 +501,8 @@ static const struct ad7380_chip_info ad7388_4_chip_info = {
 	.channels = ad7388_4_channels,
 	.num_channels = ARRAY_SIZE(ad7388_4_channels),
 	.num_simult_channels = 4,
+	.supplies = ad7380_supplies,
+	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
@@ -1004,6 +1039,14 @@ static int ad7380_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return dev_err_probe(&spi->dev, -EINVAL, "missing match data\n");
 
+	ret = devm_regulator_bulk_get_enable(&spi->dev, st->chip_info->num_supplies,
+					     st->chip_info->supplies);
+
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to enable power supplies\n");
+	msleep(T_POWERUP_MS);
+
 	/*
 	 * If there is no REFIO supply, then it means that we are using
 	 * the internal 2.5V reference, otherwise REFIO is reference voltage.

-- 
2.47.0


