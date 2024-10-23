Return-Path: <linux-kernel+bounces-378839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891C9AD629
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D5BB2326D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B4B1FAC5E;
	Wed, 23 Oct 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dv8N7EVd"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFD200C9F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717193; cv=none; b=ccSIaAFcmx2dNBjXE8vKs3T3Cp0M1qygxQG4mjEHnusxX/3WTGXbhZyaVUMFX4AX3OmoqzPwCgaDchyG6gp0wJtCRmHBWodmzZy/vmMuPc06ehUOBOZTGV4Zv1utnCRx3RVeB3Hc3MpS/vuo2WKJrl7vPNKRo1kcrVY2kz/2srU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717193; c=relaxed/simple;
	bh=LJljvnvTIWQemQAYeFT3M0jCfTCH8lY2g5JMOE6bALQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BL6g+HRwJOkbjMWuEsWhtJlgOoof7hU2ZiGHLqUhetRUNSoQdyPyJeShv+8Edm0y7sJ66mvAF9qI7GguFwD6OP54MEoSKj/L0rut5lq3PZdOoFGV7zZ30cQboy88dCFSgh7QAPY2AN5qPdMZqth35kSVbxIVVoaKoEGoTP+HJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dv8N7EVd; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71822fabf4fso152260a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717190; x=1730321990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBMr4LNoUZbbXc8Fm5EIMq3q1gHL1OkhKLhsRYFm190=;
        b=Dv8N7EVdYBrJCLgnHPD7XkNwwYyz/3ioOZu3u/Qq5rKKNVySRA4jb0QJw0TSSE8zh/
         hzJWUevqMn3nB/tH5yO4ex5mX7uwBk8b1V/YrGcUjOptNCY/+rUJkkgHbpZS7nAyo3Yz
         nyuvmcGWf+heTXJ2jgbzFHjBZz2vRp47Ml+/rZLOldmKNufJY2QXVcxJIpAnUYqmJpZg
         Om92I5hPPt9+00HR23emD1G0ped8nEifz0nLptlhnz6252hsPs7nHwpMC6WRsU+b4pLK
         mrH9KWqUKpsbv3F620YuwsFTFwXTTUaXtkG8/ez06p3hgmBJTT9UIK//X7Y6t8mwmdx4
         6j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717190; x=1730321990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBMr4LNoUZbbXc8Fm5EIMq3q1gHL1OkhKLhsRYFm190=;
        b=fV9Ri3EuZXrIHtRbyRzwMrO0eO0Hi89R6rA+wXdugSVRUYrxh9jAxfMnBy4S0tr654
         M9jN+5vdGqbL5cPmfBSef4SXt57E7Fx/Mib7vSenmQQw9j9st7b/48RJkm4j+jt/BWty
         /jPdS5+kOi6K0O01hQd6B264Hdc/CBKFeIX7X2RdSg9nf/hXHJR/rz0KEHtKMCTj7TU7
         k007bSZYcNDM6KHfUJVM0vK95tLvoU1ptJW+5k/vqotjM9KEtRIqdGUiWVzNxcmLqcit
         j1bg9r29QyT6LaZBa8W9Q1bBgvbPgGJnn79fCZBUyMHMfPjSc3isYgjZoA6Koe7E8+jR
         tvPw==
X-Forwarded-Encrypted: i=1; AJvYcCXyhbBxIDLgNhMmO8GfuQyJGRE7vfDqaNQtfZ0jHo5VU0jLWApXJ9/HeIEk3D7P30F+SygTQvnoGGcVcxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFttx09EbEgCWbfc2yLOv53BE/Vmyx3qctC0/G9ilWg3e7c7Z
	bcBx/hRlcGeP5pwDDkXtKpMnKKqTk9lhh+JeB0aRKzt5/rfVBEh+S+hIHoi0rMM=
X-Google-Smtp-Source: AGHT+IHuDa6m4MVjQHpG/uX5mRcogfjWZsE/n+KJJOq3gRYaUpX6Xw3iHUMb0NuLlRdiNjn65Bj43g==
X-Received: by 2002:a05:6830:349a:b0:718:8f2:220d with SMTP id 46e09a7af769-7184b2edcfemr4031025a34.14.1729717190190;
        Wed, 23 Oct 2024 13:59:50 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:19 -0500
Subject: [PATCH RFC v4 12/15] iio: adc: ad7944: don't use storagebits for
 sizing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-12-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Replace use of storagebits with realbits for determining the number of
bytes needed for SPI transfers.

When adding SPI offload support, storagebits will no longer be
guaranteed to be the "best fit" for 16-bit chips so we can no longer
rely on storagebits being the correct size expected by the SPI
framework. Instead, derive the correct size from realbits since it will
always be correct even when SPI offloads are used.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: new patch in v4
---
 drivers/iio/adc/ad7944.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index a5aea4e9f1a7..6d1202bd55a0 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -98,6 +98,9 @@ struct ad7944_chip_info {
 	const struct iio_chan_spec channels[2];
 };
 
+/* get number of bytes for SPI xfer */
+#define AD7944_SPI_BYTES(scan_type) ((scan_type).realbits > 16 ? 4 : 2)
+
 /*
  * AD7944_DEFINE_CHIP_INFO - Define a chip info structure for a specific chip
  * @_name: The name of the chip
@@ -164,7 +167,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 
 	/* Then we can read the data during the acquisition phase */
 	xfers[2].rx_buf = &adc->sample.raw;
-	xfers[2].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[2].len = AD7944_SPI_BYTES(chan->scan_type);
 	xfers[2].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 3);
@@ -193,7 +196,7 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = &adc->sample.raw;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[1].len = AD7944_SPI_BYTES(chan->scan_type);
 	xfers[1].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
@@ -228,7 +231,7 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = adc->chain_mode_buf;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits) * n_chain_dev;
+	xfers[1].len = AD7944_SPI_BYTES(chan->scan_type) * n_chain_dev;
 	xfers[1].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
@@ -274,12 +277,12 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 		return ret;
 
 	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN) {
-		if (chan->scan_type.storagebits > 16)
+		if (chan->scan_type.realbits > 16)
 			*val = ((u32 *)adc->chain_mode_buf)[chan->scan_index];
 		else
 			*val = ((u16 *)adc->chain_mode_buf)[chan->scan_index];
 	} else {
-		if (chan->scan_type.storagebits > 16)
+		if (chan->scan_type.realbits > 16)
 			*val = adc->sample.raw.u32;
 		else
 			*val = adc->sample.raw.u16;
@@ -409,8 +412,7 @@ static int ad7944_chain_mode_alloc(struct device *dev,
 	/* 1 word for each voltage channel + aligned u64 for timestamp */
 
 	chain_mode_buf_size = ALIGN(n_chain_dev *
-		BITS_TO_BYTES(chan[0].scan_type.storagebits), sizeof(u64))
-		+ sizeof(u64);
+		AD7944_SPI_BYTES(chan[0].scan_type), sizeof(u64)) + sizeof(u64);
 	buf = devm_kzalloc(dev, chain_mode_buf_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;

-- 
2.43.0


