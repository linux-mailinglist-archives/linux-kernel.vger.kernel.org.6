Return-Path: <linux-kernel+bounces-555073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F0A5A535
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2793AE8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6B1E1A2D;
	Mon, 10 Mar 2025 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J9QOgRqt"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE261E0E0D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639401; cv=none; b=Wr/C82XlcY9874w9vfQHqUA3EboxI0YNZsQU7tnJT3pkKHSnSY8n89+dCdkwHmuJYovuPqUz3SlIjasJzFD//IIngo+3QxLLNIytHlb3DfEFIZutq7OpmGp4GueQlEmRa0yBXodsLp4NQHZEjg2Cd57KzQN6AUoSr053yaN1cmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639401; c=relaxed/simple;
	bh=Hsc2lTWIH/R8fBT/8ZsO+EBhdL1BLa9dPLrp8/P/Dew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBkWhFvGwhZEPBfXcpUZ0bbilWAq6cgN1UNooEegvDBs4U//wpuL9pDIoaIOPjh5Cz+0LRoOcaPqBw/IR2tEO9y63Z3KidUEzwgLZugJzMSHMPOGfdVkw3Q+esbFBn1TcShM64kCY+bAtR2RvJ2uaZ8nj+iz/rq1Ybyp3OB1WU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J9QOgRqt; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f417de5e25so2140390b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741639397; x=1742244197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJTMB/Yj7akGz6eUAqBxkpGJJmFrHVTQNNCjxXAAAoM=;
        b=J9QOgRqtmnBKDpKg2GVjW8tgLoTqw5QGLM2A0OdSA+U2f/ycjdk7+4YGc7apmZVrDq
         7pq5BnufK7wh4WGTlXo85NcMxFMxqxMTZBjDiAtOY3b42uSzIkzO2jFUSXCxhz03e4WD
         1jiyJIg9o7T9UrdBZV4DZoE6zrK3f4GIvQTZnU6S0POfWZkeNw1q9uGDNJlZo0UliM1D
         EZkJ1HR0bfGqmirAexTk59rBUzcW95GJOAzHmecs74R4+gF2/z36ISQHrIANJnMaPGu4
         nE4Af/38SFZrz0s0vBZi5tgPrDiHrekD6FLTFUtLSYGr/h0rXrnFIAdcKC5cRLX3fMYG
         8vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639397; x=1742244197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJTMB/Yj7akGz6eUAqBxkpGJJmFrHVTQNNCjxXAAAoM=;
        b=r1A8xAbzqIv8vEjdOPW+oc6C+v/QRKxlBmdKM85ITd+8sb/XXa8dZ4Bu+R4Yb/lq3s
         ij2q2LtMq5zjM8vzEIJgWv4OjGW3aK5/d64gqmTXDNTqRR8Ef5rXkLYOwzWc6rbCqE4H
         zUjDTbT2CRP9Yxr+SKCpAjMgJdZvNDipNt97V6ScCHPuEFJaHRuaNt9X0J6Q75kuJEG9
         6hFuxIklQRd1i+gzkzZbziWmShdxpKOIyCtSfhWXtqFJ5YWsYYIjJB3UZeoRpOAepaL+
         1NNgr8AU+7YUdCW3iZ7IuuNWgKoA3+bGFWVUWlMYzi2MOqAE9LHBRbtuTiW1oY6U0ell
         xhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn+9a83tmkjIO+BkEPKYrRFDf9q/L+VxBOfbpgucSW3TYYGnmP1uohw85bsIFtY8oosksQlOEZAjePVtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ozmAwJgi9muj6zGxYVP78wGhf1pkalusZJsxNQk2vSznJsUb
	xyEKxSsPRM/S3KV5QSavLkMZ+00vv4mFUhKp79JwPJF1iypeyuYWehotcv6NmmAYNuruPFq8FPF
	Dh+4=
X-Gm-Gg: ASbGnctYyjn1g6JBvjZASeNrV95tfQmPmARsrmiPx9G2JUBcRS4WJu9GtrQDq7spNES
	5MuXxu/g5ppgMcB4hFzIWsfSajkeQywRiMtRp7TdFTZWQCjJ1uvzNTVrWfWgnxEktRLmLnoYtnO
	Hf62GH//XervnJU4ub9v0L2s1/7C4PFdPNO1RzHlkfI9REaROtMs8YRwABT5BJ7qBsPsQ+uLl8u
	D4+cT9hKpu4ohccmDjleTLg58PAnD7bSJuspMZwoaMEug8tlGbq65fmBLm1QMMxGrgmOc2iRo5s
	OrpUXQOYTnlqSIi5AZim8gN2tX0DF1VWI9sQsZO4yuNz2kZnsGTwbIpfZOJdVsBjKqRBnq8EXj6
	/u4eQCmybKVs=
X-Google-Smtp-Source: AGHT+IE/v8sgTJ1kpxF4TAz8lNU+kyH/TDaACDH4/rifKyICPd/DKFS6AuPRo2wZIJ/52GOdpWETkw==
X-Received: by 2002:a05:6808:1894:b0:3f8:1df6:413 with SMTP id 5614622812f47-3f81df607d5mr3628760b6e.1.1741639397012;
        Mon, 10 Mar 2025 13:43:17 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f855f69b1asm764315b6e.30.2025.03.10.13.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:43:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Mar 2025 15:43:07 -0500
Subject: [PATCH 4/5] iio: adc: ad4030: don't store scan_type in state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-iio-adc-ad4030-check-scan-type-err-v1-4-589e4ebd9711@baylibre.com>
References: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Move getting the scan_type to ad4030_conversion(). Previously, we were
getting the scan_type in two other places, then storing it in the
state struct before using it in ad4030_conversion(). This was a bit
fragile against potential future changes since it isn't obvious that
anything that could potentially change the scan_type would need to
also update the state struct. Also, the non-obviousness of this led to
a redundant call to iio_get_current_scan_type() in
ad4030_single_conversion() since it also calls ad4030_set_mode() which
in turn calls ad4030_conversion().

To simplify things, just call iio_get_current_scan_type() in
ad4030_conversion() where the returned struct is actually used and
don't bother storing it in the state struct.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index c2117c7a296f22aeeec6911c8a8c74ed576296a0..54ad74b96c9f256a67848330f875379edc828b0b 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -147,7 +147,6 @@ struct ad4030_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	const struct ad4030_chip_info *chip;
-	const struct iio_scan_type *current_scan_type;
 	struct gpio_desc *cnv_gpio;
 	int vref_uv;
 	int vio_uv;
@@ -562,11 +561,6 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
 		st->mode = AD4030_OUT_DATA_MD_DIFF;
 	}
 
-	st->current_scan_type = iio_get_current_scan_type(indio_dev,
-							  st->chip->channels);
-	if (IS_ERR(st->current_scan_type))
-		return PTR_ERR(st->current_scan_type);
-
 	return regmap_update_bits(st->regmap, AD4030_REG_MODES,
 				  AD4030_REG_MODES_MASK_OUT_DATA_MODE,
 				  st->mode);
@@ -614,15 +608,20 @@ static void ad4030_extract_interleaved(u8 *src, u32 *ch0, u32 *ch1)
 static int ad4030_conversion(struct iio_dev *indio_dev)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
-	unsigned char diff_realbytes =
-		BITS_TO_BYTES(st->current_scan_type->realbits);
-	unsigned char diff_storagebytes =
-		BITS_TO_BYTES(st->current_scan_type->storagebits);
+	const struct iio_scan_type *scan_type;
+	unsigned char diff_realbytes, diff_storagebytes;
 	unsigned int bytes_to_read;
 	unsigned long cnv_nb = BIT(st->avg_log2);
 	unsigned int i;
 	int ret;
 
+	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	diff_realbytes = BITS_TO_BYTES(scan_type->realbits);
+	diff_storagebytes = BITS_TO_BYTES(scan_type->storagebits);
+
 	/* Number of bytes for one differential channel */
 	bytes_to_read = diff_realbytes;
 	/* Add one byte if we are using a differential + common byte mode */
@@ -673,11 +672,6 @@ static int ad4030_single_conversion(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	st->current_scan_type = iio_get_current_scan_type(indio_dev,
-							  st->chip->channels);
-	if (IS_ERR(st->current_scan_type))
-		return PTR_ERR(st->current_scan_type);
-
 	ret = ad4030_conversion(indio_dev);
 	if (ret)
 		return ret;

-- 
2.43.0


