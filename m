Return-Path: <linux-kernel+bounces-212260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F77905D66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420391F210A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026D12D76B;
	Wed, 12 Jun 2024 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QvEJEsnu"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33798526C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226204; cv=none; b=XmDM2YhQwFJAyoZapKd36/n7ONJflndORNrFbxxZSg59YJ5gfuPQHSHI4hzTU1jLxJnsS1j8aZHurx12e/jMQtK/17tWuTOZ4FrWLMbVvKJnIlVAQI2YrnFML0h79jpkzk1gP4K99zwGtbo+KDVz8fT+i2guqIkiOmX14TGjgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226204; c=relaxed/simple;
	bh=RQGZCDhf9GURnEWrVzA4GpPy1QAW6p5jP0M4N6GMfTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSh6gct984RtsLapX6167esUpVAQ3cZYluJKQt6DLmyzDesxZiFLJCZOv/0nvKkTdNhG5xxDtVJK3FRhn9Bbo2JZE9dml9qj6YpMS+4AKxMqnl3i96nEI4jnsjfGehGbIAOzv+S68bl+0+RlZdFc4YLhWOcaVvyDf6pcCEjpF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QvEJEsnu; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d229826727so125902b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718226201; x=1718831001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60rjWI/eWg2WwJP9vLG2m5CtLQt8gZzyCnXFhPgOW24=;
        b=QvEJEsnugo+ABtWMy+Zbcwf6AtHFgzFzNbd6mBRt3kjdm7phaR6c7T2teLs6MjAcYb
         rSwea3J4oamrk48R75NyxxmG8+AJdf9jbekoNygnxi/FiIu4JkbT9ih2t6gEA1z4oDHV
         Z6UrSFUc5iIJ2Gl7oi+LgUWVviRYmqKiotfTkNusORisc2wjQvGu3OVca2fGEZ7Dowx1
         oHIQKsSCjdEX3mRdOhzTSq1vxtx5lKmXT+7/qKsBtMkit+EAUNsqFdUVi8VtPBDWz+fl
         grVmC4JybLO+eEhdqcJb6uoJoj2lxAfbQE+ImH4AqvoJ1y/ivwju7xZ1p9+sUZakzwnq
         nWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226202; x=1718831002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60rjWI/eWg2WwJP9vLG2m5CtLQt8gZzyCnXFhPgOW24=;
        b=dsvnmSbxG7b6VXBERGj/wPtc6Gc5Mf4t5eXuXhgeCuAk0nVnOb12nakfx4CvU5QTII
         Ot9GAKn0ff6y+dJrs9mxAfdEfozQF1Kr44ssB20kNJ0wC1rHC5F7EFgALrb8fKaJee1M
         TWIwdqczjd71UhyCZ0hU1St0fXXoLQigBy/1mJ45Tp22ZEkpVKP7I7KIMnyt50Bypsrl
         0c/hcWlOcO8bk3eaP9c33Pg05EEWucmS1YYYIbwN4xJmfZuoCk9WUH7ebDs5ttfVRW3X
         YAZdT25/dNW6+HyKHVaXwOJVeT1j7B3zyX5HwhsPbf+sbYdzS+fLYgJPH72D8HXKjFDD
         XPww==
X-Forwarded-Encrypted: i=1; AJvYcCWEmxIJB6Bq1YYXgLUYXBRyIrgP1BVCJHE9TRto7KB88AFd55l/WgZ6JWdh3t+CjTNTTKyOPLgYcgHNPcn5iNVJ5jyxJvlWHMRhYeRT
X-Gm-Message-State: AOJu0YwVG+5V8VCMQUsSO7GGV45v+HRIiED6Ufll02fAP6TNrSvtbYrX
	/NVfyziwTEOviRR9Llz7QgncncmFPmXANHajvAzPSm9R4aX5W8DmyhUjlY6ium0=
X-Google-Smtp-Source: AGHT+IGENQe4ez4Gwyda3rsmnSjRQps4X8hzl0vGRVzINVJNtM7Np1gleBLWblptPg91hq9vLRK58g==
X-Received: by 2002:a05:6808:1b11:b0:3d2:231e:4b30 with SMTP id 5614622812f47-3d23dfdef65mr3638602b6e.13.1718226201601;
        Wed, 12 Jun 2024 14:03:21 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b68f5a1sm2433368b6e.23.2024.06.12.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:03:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] iio: adc: ad7292: use devm_regulator_get_enable_read_voltage
Date: Wed, 12 Jun 2024 16:03:07 -0500
Message-ID: <20240612-iio-adc-ref-supply-refactor-v2-3-fa622e7354e9@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes:
* avoid else in return value check
* use macro instead of comment to document internal reference voltage
---
 drivers/iio/adc/ad7292.c | 36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index 6aadd14f459d..87ffe66058a1 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -17,6 +17,8 @@
 
 #define ADI_VENDOR_ID 0x0018
 
+#define AD7292_INTERNAL_REF_MV 1250
+
 /* AD7292 registers definition */
 #define AD7292_REG_VENDOR_ID		0x00
 #define AD7292_REG_CONF_BANK		0x05
@@ -79,7 +81,6 @@ static const struct iio_chan_spec ad7292_channels_diff[] = {
 
 struct ad7292_state {
 	struct spi_device *spi;
-	struct regulator *reg;
 	unsigned short vref_mv;
 
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
@@ -250,13 +251,6 @@ static const struct iio_info ad7292_info = {
 	.read_raw = ad7292_read_raw,
 };
 
-static void ad7292_regulator_disable(void *data)
-{
-	struct ad7292_state *st = data;
-
-	regulator_disable(st->reg);
-}
-
 static int ad7292_probe(struct spi_device *spi)
 {
 	struct ad7292_state *st;
@@ -277,29 +271,11 @@ static int ad7292_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret) {
-			dev_err(&spi->dev,
-				"Failed to enable external vref supply\n");
-			return ret;
-		}
-
-		ret = devm_add_action_or_reset(&spi->dev,
-					       ad7292_regulator_disable, st);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0)
-			return ret;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0 && ret == -ENODEV)
+		return ret;
 
-		st->vref_mv = ret / 1000;
-	} else {
-		/* Use the internal voltage reference. */
-		st->vref_mv = 1250;
-	}
+	st->vref_mv = ret == -ENODEV ? AD7292_INTERNAL_REF_MV : ret / 1000;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.45.2


