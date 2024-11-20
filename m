Return-Path: <linux-kernel+bounces-416345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC39D438A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDF928395B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C0F1C9EB5;
	Wed, 20 Nov 2024 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tY2ER4G5"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB519CD1D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138451; cv=none; b=kzTqj5LEgmrIOvdp5hOJ404RVB1Ka05Q/Ffy2epAOX66elWGW30IF/h/3EVdzADVEWTD+20EodceD/nBx0PJFtN5GpS3OF/LHdD8SmQWNZKSe7A8aCBFGEhyNsa4rcC7P9kf7nmNXtuxx8m86I5YKQbQ9ku6MqtgoX83rhvfM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138451; c=relaxed/simple;
	bh=YjqOsVePl6JyW118q8DsTO1Va4k/YK8vLblJ92Fp8so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2Mo1d960PdxRMtZu+qSLfiD/gWo1N4jc0BIQvPxmSh4NKUjMcnUhCfIbZxU160h+mg1D4pz0gT8MGF3cmqQpVQ9oESMp3Bqvt9MBEKMhJT3y6+99FQZuEJnEYBqdGVVg+a0Ikks95CRO8eQW7OyYrwQHklQYU+PpBTuz63apZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tY2ER4G5; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-295eb32566dso199084fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138449; x=1732743249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJZQBFRnmYxrzYBipVu7BSAWGgETcbwul8XNON+Nu4o=;
        b=tY2ER4G5jPp4QO7dmGYoQ/PgMz0O0dpnTAXeccYKEnkpZb8c4RT7YtYV2Xh4biQBaH
         +dYf3ywiKqK/SgXhew1Qch/6bwXXY9BvQs72FC/YThtMl1zaJd9Qi9/R+ShkcabricjS
         zCT9p6mIKfLXufm0zzMpWgP5BmoIRiTF5wd1rAiuuVv7wpb1keJ/ACw+MPzjUagBEKWr
         hQcHj/yoF2tZ4veFgjDv7M89vQUMn2PKGhELZwt/p/t6qeroMBjniooy0dIBWtAimfuL
         MgdGpyKgh6oK4jADrfQycdeDKsvDLJaMTeuBI6vvyzyN72CKO4Eh3hYkRcwJUc/5ZN2+
         Yu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138449; x=1732743249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJZQBFRnmYxrzYBipVu7BSAWGgETcbwul8XNON+Nu4o=;
        b=do21wfra0KYtQ0JeTSOqUNy9Us+T5GihXkFb2rAfn+ljMLed6Jcu6uKBGU1EImzGgT
         JlnaPoBLwjz6EkXOFzGKFIfPVd04HiX4QKY5ZksJ8qORYKfXhR+D1wy/IEAkPu2c+XM5
         UIFxBDV1p1ZGCbjwdvGE3xfs7L0fmC5syIsgtTfJ8jzzdhbosvPYWZH7dbjbLQXWzBsb
         l3xxsf50w0WK8frSZJ0OsBekVcWQhMx+Xczj8MisjvcehQJ4CEYFK0/jmAAwtI859hw0
         SB/tEyrw9z7As9o0ewNivThhIVZ7OwqpfQrgNlsiUWXm3rvPNBJX/ms5kLvvJPI7x1eJ
         xQHA==
X-Forwarded-Encrypted: i=1; AJvYcCVuIaBGHvcOvacha4dvdHqkxyQ9CVYu6FPdgqRCGZKz3ln2tD4G1IPC3h3+kTs2ZEzIpYAPifP1ZNQKqO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvMd5AjQVNnIQkQkQSIyDvMqiIm7gvZyqI5SZl7/WEblo3kH3
	Z9F2VS+jlgoki3Fa8GBoeJbfqXB/pvihXcGFKqWbEAafyqKLPYyVw9XUBO6eWfo=
X-Gm-Gg: ASbGnctgYga98+KbHfNwINQ1YNBB7Q9Uq+cgFlvccH4JuYbOexp1s1MmU60noiM+q+G
	Tzg+JhguJvJgAbNd8/3Xp0JIzElVybc/c7YY4HYc+30rNOv1isP89BmvjERswBfjrv6BfSL9B84
	n4iOjaf+MIAH+7CT2kTwdAYKrOh3Fxcjai0t+ChI9lka5KMnpQdzTjrA+cEtIdBwibJrE7aiREd
	n7sG+Anxjgft4jMLOcsoo6g/hu8vYZcJTpNmA79GCIPUzi42mqPN5lC3e937Lh63fQApIeAJ00o
	AoxRsA==
X-Google-Smtp-Source: AGHT+IGGWhizSMIHEU9PwpCFwQtddmQouUfb9G2QjGVXrzwtaGtElTxE36+XrkVbMrbkvPL2h1MFGA==
X-Received: by 2002:a05:6871:8214:b0:289:2126:6826 with SMTP id 586e51a60fabf-296d9eb4983mr5002242fac.30.1732138449182;
        Wed, 20 Nov 2024 13:34:09 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:07 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:29 -0600
Subject: [PATCH 06/11] iio: dac: ad8801: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-6-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad8801.c | 70 +++++++++---------------------------------------
 1 file changed, 12 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/dac/ad8801.c b/drivers/iio/dac/ad8801.c
index 919e8c880697..bd857754fc11 100644
--- a/drivers/iio/dac/ad8801.c
+++ b/drivers/iio/dac/ad8801.c
@@ -23,8 +23,6 @@ struct ad8801_state {
 	unsigned char dac_cache[8]; /* Value write on each channel */
 	unsigned int vrefh_mv;
 	unsigned int vrefl_mv;
-	struct regulator *vrefh_reg;
-	struct regulator *vrefl_reg;
 
 	__be16 data __aligned(IIO_DMA_MINALIGN);
 };
@@ -122,51 +120,20 @@ static int ad8801_probe(struct spi_device *spi)
 	state->spi = spi;
 	id = spi_get_device_id(spi);
 
-	state->vrefh_reg = devm_regulator_get(&spi->dev, "vrefh");
-	if (IS_ERR(state->vrefh_reg))
-		return dev_err_probe(&spi->dev, PTR_ERR(state->vrefh_reg),
-				     "Vrefh regulator not specified\n");
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vrefh");
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to get Vrefh voltage\n");
 
-	ret = regulator_enable(state->vrefh_reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable vrefh regulator: %d\n",
-				ret);
-		return ret;
-	}
-
-	ret = regulator_get_voltage(state->vrefh_reg);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to read vrefh regulator: %d\n",
-				ret);
-		goto error_disable_vrefh_reg;
-	}
 	state->vrefh_mv = ret / 1000;
 
 	if (id->driver_data == ID_AD8803) {
-		state->vrefl_reg = devm_regulator_get(&spi->dev, "vrefl");
-		if (IS_ERR(state->vrefl_reg)) {
-			ret = dev_err_probe(&spi->dev, PTR_ERR(state->vrefl_reg),
-					    "Vrefl regulator not specified\n");
-			goto error_disable_vrefh_reg;
-		}
-
-		ret = regulator_enable(state->vrefl_reg);
-		if (ret) {
-			dev_err(&spi->dev, "Failed to enable vrefl regulator: %d\n",
-					ret);
-			goto error_disable_vrefh_reg;
-		}
-
-		ret = regulator_get_voltage(state->vrefl_reg);
-		if (ret < 0) {
-			dev_err(&spi->dev, "Failed to read vrefl regulator: %d\n",
-					ret);
-			goto error_disable_vrefl_reg;
-		}
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vrefl");
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "failed to get Vrefl voltage\n");
+
 		state->vrefl_mv = ret / 1000;
-	} else {
-		state->vrefl_mv = 0;
-		state->vrefl_reg = NULL;
 	}
 
 	spi_set_drvdata(spi, indio_dev);
@@ -177,31 +144,18 @@ static int ad8801_probe(struct spi_device *spi)
 	indio_dev->name = id->name;
 
 	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to register iio device: %d\n",
-				ret);
-		goto error_disable_vrefl_reg;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to register iio device\n");
 
 	return 0;
-
-error_disable_vrefl_reg:
-	if (state->vrefl_reg)
-		regulator_disable(state->vrefl_reg);
-error_disable_vrefh_reg:
-	regulator_disable(state->vrefh_reg);
-	return ret;
 }
 
 static void ad8801_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad8801_state *state = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (state->vrefl_reg)
-		regulator_disable(state->vrefl_reg);
-	regulator_disable(state->vrefh_reg);
 }
 
 static const struct spi_device_id ad8801_ids[] = {

-- 
2.43.0


