Return-Path: <linux-kernel+bounces-416812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 745A69D4AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046941F2282F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127061D1F56;
	Thu, 21 Nov 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V9f9Ww4t"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CFB1CCEC3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184312; cv=none; b=UofrH91OS+tQHqEfZtrliKRk6tZpwPhZ6oVD+eEPWZ/OfAlDVCXpzX6w3MRf/MXYDmGqZ2q86MkOkBuqcxg8MfAakBLF6R68E9HscA94fIbv3Qpn4nsJ31k6ZA6ji2aj/37oo0uUk7krCkBg4N8Rfe4wKh8Be63Z2L+wYN/03X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184312; c=relaxed/simple;
	bh=2RdUP0opgSj121kEt066DF0V8khGTWZlShuPPaqbCi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EzSToxqSkk54G0KCVA1sRguvwhU17a3koRPJYA+HfOezeDxy/yERslmyowtw/MrqmsHRxQ7cq430NyLBjoYOnMTWOphIF7bCFbF42WHMOTtbkU7EpVi/u7+mF6YsHmXwHZ8rjC0sAk81/vVNlKiE37eKWZhRWJ+xugoRwiElj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V9f9Ww4t; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso5478785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732184308; x=1732789108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnR4UV0w6VSKY/f8yPux4iBG+LYvQ7mliatLzcIQdBM=;
        b=V9f9Ww4tyqz0n6oEURYAOXPqlup7oxzLucuhvRjX7zp8pg++J8yL+0m1GTFaovql9z
         pnn3q+m1b51pvbxWMx417U8Cex3FTpH/Wwm3TZm+LM+WD8wUfIb4dHPfn6V1Lbnt2woh
         DbaX+bmgzdjv1OH/DNKcUK0Q1ICwF0CMTvW+Lq8N3pOexhQ+Ge/uaAfStM8UiHfDHUvi
         8b9HzmgyHgcmUOTHrVs3Vo9x4jsQigvk6BvZXHKRTntZMK3xJpBq71W2f0HM/0JRETbi
         lo8ssBhimOLRDWKY6pLx7njwM6qbdP4I1aurmw/zXvhtMFP9+aJecXNbyDhBVoqEA95F
         pfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184308; x=1732789108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnR4UV0w6VSKY/f8yPux4iBG+LYvQ7mliatLzcIQdBM=;
        b=kivqvOz/gqwLebdJ/rZnoSWL8/cKOBmX7iLetsJ8zqjnUXt7FA+bDJJzqD4iKmJt2C
         c+XoupJyL5m56I9SeIQ/xBgcqVWQavZtDlLR5JJIFIXLvlBEIYFU6ij/u42FvkGoMcDb
         HqvuHQE+84uFNbcbzUimXXKl8MT2dhVTqD3x4BePUP6qzOsfRyq+H98au/YxfdF4GJo9
         L+u1wNQ8RnIjP9qnj4FstFC35r9wsbdHzWgP3ZPMuqS7qVVbKfLqzWmilk25GCQ351Xd
         CtI59HYlAQYCSfdO10UqZsNhkmxqBO5PKBI2NCXDW/c3l61jHYx6iC3SHa+YV+9FirJl
         6KGw==
X-Forwarded-Encrypted: i=1; AJvYcCXCMMp7T2KmNJHfRvgzXGn7DhROdnQzUexj7vh5njDy4DE6Va0THMbm7dVNe360Wri8soEWn4oJjsYUAr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbm1i/k/8ZspAwNGaT9hL1f41fkLCzDSIQdJNQcUUasfSkaMIZ
	zWsF5PGtpISW0/lTGtHYVl+3pBen21H3VeN6P1dYPxccE9bBfZG0lLgHZKqnVxgbO0MH9EsMHut
	h
X-Gm-Gg: ASbGncvYXJ9+B3MZLP7TTHbTFTvretsmMFDgAuMYqpYsko/uj1f9gsJ0T+aMef1XDe2
	YyexOPjbfWtPKyfLt/dfydbAd0FY4I2gkJG5lgMQhsKf1+O2Ia+OBc8nMX/AchVY/D27sYCNtDu
	mPfuLR8cg66Fav8TjOKmxW9/ynWY3IOxGzf7HfWV5YEKn+0gyQVamFzSezaPzMnV/lSSbubBp6j
	XB0ImC1aofiz4QSbTDL0Ng8P872NbPNxJ4g+C0U7oQFu298QfSArcRyyIclIil3ATCZ94bupw==
X-Google-Smtp-Source: AGHT+IEFrv/RthM6qz+7szeDYPM6+coRBlRKnKO/IHtuqFfBkoi0rE1EWyE4uO8xzlFLoYrtCCfo9w==
X-Received: by 2002:a05:6000:144d:b0:382:397f:3df5 with SMTP id ffacd0b85a97d-38254b21914mr4328291f8f.38.1732184308058;
        Thu, 21 Nov 2024 02:18:28 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910796sm4598065f8f.47.2024.11.21.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:18:27 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 21 Nov 2024 10:18:25 +0000
Subject: [PATCH 3/9] iio:adc: ad7606: Move the software mode configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-ad7606_add_iio_backend_software_mode-v1-3-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732184304; l=2020;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=2RdUP0opgSj121kEt066DF0V8khGTWZlShuPPaqbCi8=;
 b=h2ujr71zPBn32R8QCoM2rO5GdcOeQwiHdz8qEQORU/AXJdpiejQlKCfEYCdxWP2UUsq8DD6jk
 ldIWgG6+mHBBDZzv5osKXZMHnV4EXY0SlPnf0jydyZi25SVnsOFQAeO
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This is a preparation for the intoduction of the sofware functions in
the iio backend version of the driver.
The software mode configuration must be executed once the channels are
configured, and the number of channels is known. This is not the case
before iio-backend's configuration is called, and iio backend version of
the driver does not have a timestamp channel.
Also the sw_mode_config callback is configured during the
iio-backend configuration.
For clarity purpose, I moved the entire block instead of just the
concerned function calls.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 893b93b86aa7..828603ed18f6 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1246,17 +1246,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return -ERESTARTSYS;
 	}
 
-	st->write_scale = ad7606_write_scale_hw;
-	st->write_os = ad7606_write_os_hw;
-
-	ret = ad7606_sw_mode_setup(indio_dev);
-	if (ret)
-		return ret;
-
-	ret = ad7606_chan_scales_setup(indio_dev);
-	if (ret)
-		return ret;
-
 	/* If convst pin is not defined, setup PWM. */
 	if (!st->gpio_convst) {
 		st->cnvst_pwm = devm_pwm_get(dev, NULL);
@@ -1334,6 +1323,20 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return ret;
 	}
 
+	st->write_scale = ad7606_write_scale_hw;
+	st->write_os = ad7606_write_os_hw;
+
+	st->sw_mode_en = st->chip_info->sw_setup_cb &&
+			 device_property_present(st->dev, "adi,sw-mode");
+	if (st->sw_mode_en) {
+		indio_dev->info = &ad7606_info_sw_mode;
+		st->chip_info->sw_setup_cb(indio_dev);
+	}
+
+	ret = ad7606_chan_scales_setup(indio_dev);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);

-- 
2.34.1


