Return-Path: <linux-kernel+bounces-379031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB149AD8D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A952E2844FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E382220720A;
	Wed, 23 Oct 2024 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EUavADAY"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CB205ADC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727705; cv=none; b=QUF/Gd+NNVyNj/Pb7w92xcDCp42t6y+lWB9g2+js7kPFYv1C3gyDrvzgWh2X7LSVBKo05+YmdmylPuh+vnlfXs8Y28VqBh+zlawsyd7x9l5mihaYgvgdpaCHVdhf2oy5tlAKxV24bPPxFdPKisET4kWKeOhvV3OaQycwJK7c/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727705; c=relaxed/simple;
	bh=rBJqShNgFgDWxiqlxWde8MpySetcVg/+VpgTQLIZJUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAzY5mgFd9gO8QLPXDLG51JLf26AZoQRmTjEq1VpFKOM3U1RGh0EKJaG+SF1oU2uDFS38Ei/O23Symw3aLj7qgE6UtAXGc9bXkynN4zsf5GZeO3KTRMSQj9KkWeg/xu5fQkkGJpy2ZAbf+QUg2xQEe/VH92K7SMfDnxUGiA5e0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EUavADAY; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e5568f1b6eso158956eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727702; x=1730332502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwRem8dxk8AeEhZFejKaWT2ehSfFw6/ckoM5Vp45PUA=;
        b=EUavADAYDrxMasRmVc37fIaLa4HxSilvbdF4KlBfP84ziR8iCRRRNxRq2uCcDnOQF0
         Po1BWQThLN6wzzdFRo7+eMrwOUk/pcjSyVzVuNCiBUY99kCJBpPoZmE9j59cT5i0BcMS
         YxpnTk5Tp1eJUvrBCSvt2uJOo6mdOtjD8HTAzIC1vAZkA09N6DOXJ5hEG3jrMiBKcorv
         Jez26SIBxPRH53NBO+pE7i2nEllsTfZ/Luzw6jeYwIkTVcF5+yIxW/SQiMzL19qhweEz
         LOtnJxb1VoQ9pw026qJCUeBdnm3NTFRyMsHejA/jOTuf87fy2BxAzWco3sZNFP+fK1gh
         hnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727702; x=1730332502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwRem8dxk8AeEhZFejKaWT2ehSfFw6/ckoM5Vp45PUA=;
        b=k4ssfXOn/to3TbQdTtgglbaGlxxOddKAqz3WgDP6M/dok17r18GbgnW7aGGQvjarp1
         RzrHZmhMvqQBqExAWQ03P7XPt8H9Hjfxu39QHoe5kX+Y96WpW7UD3MnSwbbfEDosrqal
         tISzOZ3+7y/uJx3jIh0qOX4zyNZ62yErx8P7y/cguGA+NjJE85U6aniaC+KYlC8bnRKt
         Wz/hVUWTyDd5bOlwphZCx1mlL/qbCfkU34A/QKpGFqpB7iOc8q2lFYVg92O2WRcA5ZWE
         0t9QawXFRDUmU8XoxVFy4VvxTIkbC6R6KOw+84U4JbIBBNATbG60xZfJJMKUGqanCDHh
         1ZfA==
X-Forwarded-Encrypted: i=1; AJvYcCXadTQ3ubWOwKPpvmZrty/7ru+aUrfcabr1YypH08ByLpdIWk7ei1nahN4kFgksh4woahqOTctZDWhPYdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYpUBLhYHil7kbGe3m3wa8BB8h2UE/JiHXMGINWVlUwZxYeHk1
	ofHmknXhcItKJKdAnK94gUTADppCAfZa6sCZfj814nefflk+B96gRyoythM84F4=
X-Google-Smtp-Source: AGHT+IGtkmr2OClSc6SM8EOI86U/pFTbxAUEWIPPhcsQde8YwVmqunCGN/cl7SNixNhWfRGwgJREGw==
X-Received: by 2002:a05:6820:81e:b0:5e1:e748:7ad with SMTP id 006d021491bc7-5ec057d1013mr124181eaf.7.1729727702539;
        Wed, 23 Oct 2024 16:55:02 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:55:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:14 -0500
Subject: [PATCH 10/11] iio: dac: ad5761: drop driver remove callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-10-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Drop use of the driver remove callback in the ad5761 driver.

By making use of a a devm_ helper, we can avoid the need for the remove
callback entirely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5761.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
index 55e33cf5806e..0aa5ba7f4654 100644
--- a/drivers/iio/dac/ad5761.c
+++ b/drivers/iio/dac/ad5761.c
@@ -302,7 +302,6 @@ static int ad5761_probe(struct spi_device *spi)
 	st = iio_priv(iio_dev);
 
 	st->spi = spi;
-	spi_set_drvdata(spi, iio_dev);
 
 	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
 	if (ret < 0 && ret != -ENODEV)
@@ -341,14 +340,7 @@ static int ad5761_probe(struct spi_device *spi)
 	iio_dev->num_channels = 1;
 	iio_dev->name = spi_get_device_id(st->spi)->name;
 
-	return iio_device_register(iio_dev);
-}
-
-static void ad5761_remove(struct spi_device *spi)
-{
-	struct iio_dev *iio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(iio_dev);
+	return devm_iio_device_register(&spi->dev, iio_dev);
 }
 
 static const struct spi_device_id ad5761_id[] = {
@@ -365,7 +357,6 @@ static struct spi_driver ad5761_driver = {
 		   .name = "ad5761",
 		   },
 	.probe = ad5761_probe,
-	.remove = ad5761_remove,
 	.id_table = ad5761_id,
 };
 module_spi_driver(ad5761_driver);

-- 
2.43.0


