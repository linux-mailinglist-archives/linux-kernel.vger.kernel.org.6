Return-Path: <linux-kernel+bounces-379029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43A09AD8CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34AA1C21A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020A0205156;
	Wed, 23 Oct 2024 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RhWzKKcf"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEB200136
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727701; cv=none; b=fdd/oh/L1utKiCJ8mS+WwsUfzglnygKqWHnRLIe52+7/AEzdqWAOwX5RAf01AOdaKHXkpyPbsWTWjLEOETOmqOXxFdGIk3SKeYIEPbuEs8PMISgryAnm0xahv0478dR6nCeV1s53m8OuNdZ8/omu059/z5aw1ISOnTXeH79bndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727701; c=relaxed/simple;
	bh=kWbL5m1yzz0e2sWADT8Ksi3XtC6+zGVgjhl+x8sAPqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxCBPreuseNuG4dEp872mLvYBWNmmTHfVtV5MnTXuIoCfZWLYvZsscIn8M03TZtcIVzqL+O0tLiXtgUiKCCvJf0PtfP0cxZjUTXbWERSGiNThSMaRg+NqC2Vsi39nhSlbFG8r17vLF1n4jkqmCe5HU1pCZEH+W2LFupHaddF2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RhWzKKcf; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5eb73ec1e1aso153255eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727698; x=1730332498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOcP75tMDnvIMGtI3xKCbUIx+y+p1KSP/2T/68I9uVM=;
        b=RhWzKKcfN9Qg6AEsiWxg8ijz+oVWNfDNU5WXPWaoxxkDaR5KRWFXBlSmcc+qKMBGPF
         Ec2Vr1z60OtTJaIjM3FE+AOsOFQL+LTvTIJTYCvNOuoE0JJXgsrZz+ERMmzIswNU0ho7
         PUFQEUvmPQgNJ8se27VfTH6woeDm1D5VZqRHjZzf3WIy1OSS413YGxkN0Ll+mx91/PD8
         hjUyV+MmukgAXFsOm4d9OoQNBk3g0jLvvM2O16+w40I4m0i2IxvQNuPh1p+HhMMKRE+Q
         fsg335cJqGh2F3taVOKqKY9C7DOYdU4bkDusOv8xNt4arSGQHBbht724X5ueRE/YZgAl
         rGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727698; x=1730332498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOcP75tMDnvIMGtI3xKCbUIx+y+p1KSP/2T/68I9uVM=;
        b=sP1W7tWKemqn8E5Hfj1c2TcfC/tGF9wwhmtE9Coyn7VLFIj4R/tmVO5rhLKTXHYBd5
         KSUaWdRb2/aZOC5zMNO/xG72hyR7S4/f8o5SAFJLkrY9Q5ltIm16t5k6x/voyU1JgpXE
         ccmyeGzHFgaVE+62MCfsRSPYje99UNnXtANIY3a/E96E9ph6f7SPAEOHDdMRp6SiO6jS
         ygX+LXZTHQHO8QyFi2UxCNifM5JDaLrG/j5e8puIbbl+Ed999qtyeqerjvrb3ffQGoY2
         yP1QLr8qTQqK0DJ1cjT2iUwmGzLlquxDs1TaJ1ikEYGzo0oD+d1vv0O9gV0UpPoJJYEO
         n7gA==
X-Forwarded-Encrypted: i=1; AJvYcCU7wto9Z4hvEITGUIbGxO/i7Tv5PGSvhiAMKG5/ZRhFw/xx164BMOMkqFLTUvr1993rVA/rblAULKQIEss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ABuCOzrxASV3BBqhRBjwz7nHKM8Jfs9gNfN7xXJrbyigRO8Z
	bNYzGP1LkLxKQggVOjYWXPWueXfEkDTkOdjlkHq6ZEiHBH8+JEcgVDvwPfogTi0=
X-Google-Smtp-Source: AGHT+IEXHXqBoW0/wOw8FRbvwPSBj+8W685mXz843ju+kM6CBnhT5LJwRs3reFQ9YlEwGYZ8so0Anw==
X-Received: by 2002:a05:6820:1c8f:b0:5e7:cb2e:e01e with SMTP id 006d021491bc7-5ebee8fb6ebmr3022107eaf.7.1729727698575;
        Wed, 23 Oct 2024 16:54:58 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:12 -0500
Subject: [PATCH 08/11] iio: dac: ad5624r: drop driver remove callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-8-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Drop use of the driver remove callback in the ad5624r_spi driver.

By making use of a a devm_ helper, we can avoid the need for the remove
callback entirely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5624r_spi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index 5a952b45f488..2fd38ac8f698 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -240,7 +240,6 @@ static int ad5624r_probe(struct spi_device *spi)
 	external_vref = ret != -ENODEV;
 	st->vref_mv = external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
 
-	spi_set_drvdata(spi, indio_dev);
 	st->chip_info =
 		&ad5624r_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
@@ -257,14 +256,7 @@ static int ad5624r_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return iio_device_register(indio_dev);
-}
-
-static void ad5624r_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad5624r_id[] = {
@@ -283,7 +275,6 @@ static struct spi_driver ad5624r_driver = {
 		   .name = "ad5624r",
 		   },
 	.probe = ad5624r_probe,
-	.remove = ad5624r_remove,
 	.id_table = ad5624r_id,
 };
 module_spi_driver(ad5624r_driver);

-- 
2.43.0


