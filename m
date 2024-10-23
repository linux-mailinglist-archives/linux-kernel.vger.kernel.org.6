Return-Path: <linux-kernel+bounces-379025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A99AD8C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EDE1F26B30
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4411200CB1;
	Wed, 23 Oct 2024 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GaEJzVMr"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2369C200B81
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727691; cv=none; b=FbW366vlGTnVd9DzmkW+1SpQCw8WppJzjWNqOSnw7kZSKGNG9vKd8EgYyseSajRJjTCLkabVm1wE+yuYHGCuHzxm5FjgtFJvb79FEN4/sQm3CFD3l/RfLINcWzd4fmg5aXiNt+hdlfKsmKIJWTvsuFTO3rXudd4Cv2EOrB3Y8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727691; c=relaxed/simple;
	bh=TBWabhQJAgeF/JmlGMB0s6sWkKQPG+fMnDw+4FWx7pY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Re7zd8gEjR1xrukIvj+xzF5CS6q7/cTxwCeq/wchq5zSiaPwySWxS94Eu0LhtBQS0Y0/7OYUm4IpOfzoSSM83o2JDMda4DJ/Ztatp958hrNmMplfKWbGwDKtLvFZifxQhUecLc7NOWmCZK1uewLCB9ma3n+0NaD8T0bfvbUa+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GaEJzVMr; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71809fe188cso219766a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727688; x=1730332488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CCrJsd8Dvmrlhf0cfRAhRXo/5Sfbm74xKaBgF7hdoZw=;
        b=GaEJzVMrm6Kax5KY5LXuUVdhO/irVQdaDzWouuzrTY9d8kUUKY0WeA9uMLIFMAuDgH
         al+DhE0gfvLE9Vqdm3cBMBpGgu5xxe/x/v5nX51HVY+hwWaPmqf0tve/TgRb+/xB+p4A
         dR35srNUkHLLamGBkhZeN8GRukkaHhfHVSMYV8x9mtavn2MuAjvBoqJL0/NbmQkags3V
         7hWpTwHcfm+5UhfBRepYpNgdDx/qEDXZ0sURF0myunAbqeeEL/uIZnto4NvkEcjaUtm0
         +1NTnW7JqyRCvd+9FVy1x6AZqGgkwCbugPc/pp9XqiWFZOMqHyq+4OlS9NeFSycdjrS9
         VhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727688; x=1730332488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCrJsd8Dvmrlhf0cfRAhRXo/5Sfbm74xKaBgF7hdoZw=;
        b=rlzFU1AJNj7Tzf2Y4V7zdEkS71YSpZrA6ZVhLJckdkdBwDxZh3esZLwIRgr+venAgF
         sP0eChtu6f0exBIJYNG21pg/MK00fvb+wyvIXTiyOT/6XY6Y75H3H0CR20jvaC3+Bcpt
         WBttgF+6KgjhbXhPJd1pcnX3I/lF31M7Mft9VreZFYDs1ZJaXx7Dq4BZrExoMEQtu4l6
         C6ViKyW4pA25fd1WxAoDR+sKvBNI0lz93/NFaqAJqBOpGrX6Jx8HGWZGQyuS+smphqQ1
         14xGwKM8zALy8l5FuQsPe+AE7AzEwrVPVJnsIT/MGGxhbmWWDrjZW1keJiq6vREWwEPn
         qsSA==
X-Forwarded-Encrypted: i=1; AJvYcCX6pTJgSaVeX11miT5Zev0NmRcLmAq3bfP2BkSS7vRdxSVlvDSiiNlLtxIlpLxs9NhHyWTWhbQrKRJLZdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/WGQQvKY3XrFQsRcbk9+ohYqJgl4X/kqnxJt/NBieI/iv6pA
	QEj2Y6qv3MzrAX5XWDN16TI8YyLpHGjmgl+d3e+NNiio1fdMIBapzq32LLw+1vY=
X-Google-Smtp-Source: AGHT+IFmqtwSvibuxIx443VqJVODLExHgKIwAqImbQsJ68YjECi5O8IiJMzfNAv7dGv+ATRS9zqOcQ==
X-Received: by 2002:a05:6830:348e:b0:70c:9c66:af53 with SMTP id 46e09a7af769-7184b3468d7mr4274863a34.25.1729727688300;
        Wed, 23 Oct 2024 16:54:48 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:08 -0500
Subject: [PATCH 04/11] iio: dac: ad5446: drop driver remove callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-4-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Drop use of the driver remove callbacks in the ad5446 driver.

By making use of a a devm_ helper, we can avoid the need for the remove
callbacks entirely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5446.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 574de97c1c08..6ad99f97eed5 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -233,7 +233,6 @@ static int ad5446_probe(struct device *dev, const char *name,
 	st = iio_priv(indio_dev);
 	st->chip_info = chip_info;
 
-	dev_set_drvdata(dev, indio_dev);
 	st->dev = dev;
 
 	indio_dev->name = name;
@@ -258,14 +257,7 @@ static int ad5446_probe(struct device *dev, const char *name,
 		st->vref_mv = ret / 1000;
 	}
 
-	return iio_device_register(indio_dev);
-}
-
-static void ad5446_remove(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 #if IS_ENABLED(CONFIG_SPI_MASTER)
@@ -466,18 +458,12 @@ static int ad5446_spi_probe(struct spi_device *spi)
 		&ad5446_spi_chip_info[id->driver_data]);
 }
 
-static void ad5446_spi_remove(struct spi_device *spi)
-{
-	ad5446_remove(&spi->dev);
-}
-
 static struct spi_driver ad5446_spi_driver = {
 	.driver = {
 		.name	= "ad5446",
 		.of_match_table = ad5446_of_ids,
 	},
 	.probe		= ad5446_spi_probe,
-	.remove		= ad5446_spi_remove,
 	.id_table	= ad5446_spi_ids,
 };
 
@@ -550,11 +536,6 @@ static int ad5446_i2c_probe(struct i2c_client *i2c)
 		&ad5446_i2c_chip_info[id->driver_data]);
 }
 
-static void ad5446_i2c_remove(struct i2c_client *i2c)
-{
-	ad5446_remove(&i2c->dev);
-}
-
 static const struct i2c_device_id ad5446_i2c_ids[] = {
 	{"ad5301", ID_AD5602},
 	{"ad5311", ID_AD5612},
@@ -571,7 +552,6 @@ static struct i2c_driver ad5446_i2c_driver = {
 		   .name = "ad5446",
 	},
 	.probe = ad5446_i2c_probe,
-	.remove = ad5446_i2c_remove,
 	.id_table = ad5446_i2c_ids,
 };
 

-- 
2.43.0


