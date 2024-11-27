Return-Path: <linux-kernel+bounces-423918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C79DAE43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761001635B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1C202F92;
	Wed, 27 Nov 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EMbr239G"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBBF152160
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737770; cv=none; b=tzWzGQ3UA8VJLmrCxgqVdQuj1W0bYISRClyG4uKeGVcPJevn9YjxVV+UHWvQDKH7ebgUaogU0bWy1UkSoqlk+VGcGhXUkxmxPxoqa1Ap05HAVxKJAgLoq2Y2aZqDKuS6mOfPRBVHx9g9IGdsuKceWGNXu3TS/GMFN2Mh10lbuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737770; c=relaxed/simple;
	bh=zRHRyZj9u8W2LqLLqjrSDlClSWY/ZCi+rinARacbnps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PA4pWesdt0YRLjxRapOIN7182g51FBsHTRY0HKlHYF9xqaqpVI0uemKbC3t/cNZh0Tt3Ubx0IJefsBo6/2Y8vrdVAkLY+z1Yc/jC8pMT3XrmppuLoJ5DBr9cJ43l1RTTRFzYKKbEpqTinSsXtSQi3EgakgCpHNDxLauRu6EX8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EMbr239G; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-296252514c2so160844fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732737768; x=1733342568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUqW/RG6GFljj5n4ZtmSErYGHBX90zPHoNRIF8yvn5Q=;
        b=EMbr239G+vNOPGVECM2Fu4lTHRRtWZFDABNntHR6JbcqYD+jB6ATXDh51dKcdz93vh
         qQhqhQOIVI13qJf4C+GkFVsl1hMD/iF5RbH78vC9rzZnWNUcjPr6rAhYRjBHkEISKSkb
         yiZis+GRD70Nht0zFxCiggqy/wcubl+6ls4G7M65zzUYDQ8lifb95joJvWFMwKgF1uLZ
         v38F4U1+3o26hT8G4yGaiF+wqFMyRTVBo9T77Mx37S3KrEn7dL1o4BRQ4q8Z41HB8E8G
         d6YFCR/mijUe+JoHEfriIfBHFNCLK1P9CXDSesqVBtz+ykGlRTQenkBfMucXOEm6GsT2
         gRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732737768; x=1733342568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUqW/RG6GFljj5n4ZtmSErYGHBX90zPHoNRIF8yvn5Q=;
        b=fBQNEhtBVMxOPJjVjvhtIJG2ZYqEmF8s3pgtJxIfldgxsT8TTzWPZsOnHvc+a/L7Of
         To/ldlxnq0iwNv7FfPXzs4bLhBnhcb4ht9U23NgO9GcB9Iha8oyI5iTzYu8r9zBoyC8P
         pubQj6Q64+wNw+4Y9LcCgm9PQFvO9CGU8UL2fYJj1biERusRgWlZfBbaPmKrmG6qWgRl
         uxSZofNmZLIuYpQyBJ41LLNZGl3NgOlKniqtd5OKD58qF87osumeWAxRwcxuReQ6d1bz
         GFd8OCTbuks5KtjYr0I+01fbU374BiFfLvQaoEk7wdZ2GUjuz3MGEYn/7HqOiU8+rKvN
         NytA==
X-Forwarded-Encrypted: i=1; AJvYcCUDoz8Fs0ocBh9ARwm1MEsYHTtWo93MnwSqUNlwzIlwEzMSd4fyOM8O5AfydYtmpsuZ0EfoPVt9bDEg6lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjX6AHkW7rcNa6O1vkyuBTeuuGChuNXOQMvOb+0JLlWzmHCyZy
	efPNgifUIyHWh1H+5LkNaua693ROANO5Ap2U9oGG0dN8a4oV55GaRKtqK+PB9v0=
X-Gm-Gg: ASbGncvs3zaMPYbQTjzuFrYje37xqIV+hYUnkgKojSXCsA2hC932WSo4jwU1kDPNZ4e
	sCranZT8GzWQeQkXxH7qVT2QN9+qfe6efD8J//yCN9Luzf119J/FJt21E7JxLLLuCJx9/M6B7xw
	JIAH7/BZMtjkqGplHvqkpt3rdUWHZ6HpLZEGBhOLXvWgnnvRKa0mwRbTOZuUvQe6G6S2cPG5Bbp
	bX3VxadjNz6L/S48B0vyQLvHMzve61KtMWMU6PkdDBTHzxep4/Tpu+YCsDlJsfuLrhPZSbApsfP
	f98dZQ==
X-Google-Smtp-Source: AGHT+IHeUY/rHu6dEk9u0KJC/fgJM/4Ys4OZzsjFEIvS+qqtGNLwZKanKVMkIm6RVrrtyE4uluGpsA==
X-Received: by 2002:a05:6871:728e:b0:287:e3e1:15f2 with SMTP id 586e51a60fabf-29dc41cb355mr4902257fac.25.1732737767948;
        Wed, 27 Nov 2024 12:02:47 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d6654e9sm5069542fac.24.2024.11.27.12.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:02:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 27 Nov 2024 14:01:53 -0600
Subject: [PATCH v2 1/3] iio: adc: ad7173: fix using shared static info
 struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-1-b6d7022b7466@baylibre.com>
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
In-Reply-To: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Guillaume Ranquet <granquet@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Fix a possible race condition during driver probe in the ad7173 driver
due to using a shared static info struct. If more that one instance of
the driver is probed at the same time, some of the info could be
overwritten by the other instance, leading to incorrect operation.

To fix this, make the static info struct const so that it is read-only
and make a copy of the info struct for each instance of the driver that
can be modified.

Reported-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Fixes: 76a1e6a42802 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 29ff9c7036c0..c83c4c90b090 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -199,6 +199,7 @@ struct ad7173_channel {
 
 struct ad7173_state {
 	struct ad_sigma_delta sd;
+	struct ad_sigma_delta_info sigma_delta_info;
 	const struct ad7173_device_info *info;
 	struct ad7173_channel *channels;
 	struct regulator_bulk_data regulators[3];
@@ -752,7 +753,7 @@ static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
 }
 
-static struct ad_sigma_delta_info ad7173_sigma_delta_info = {
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.set_channel = ad7173_set_channel,
 	.append_status = ad7173_append_status,
 	.disable_all = ad7173_disable_all,
@@ -1401,7 +1402,7 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Interrupt 'rdy' is required\n");
 
-	ad7173_sigma_delta_info.irq_line = ret;
+	st->sigma_delta_info.irq_line = ret;
 
 	return ad7173_fw_parse_channel_config(indio_dev);
 }
@@ -1434,8 +1435,9 @@ static int ad7173_probe(struct spi_device *spi)
 	spi->mode = SPI_MODE_3;
 	spi_setup(spi);
 
-	ad7173_sigma_delta_info.num_slots = st->info->num_configs;
-	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7173_sigma_delta_info);
+	st->sigma_delta_info = ad7173_sigma_delta_info;
+	st->sigma_delta_info.num_slots = st->info->num_configs;
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &st->sigma_delta_info);
 	if (ret)
 		return ret;
 

-- 
2.43.0


