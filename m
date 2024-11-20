Return-Path: <linux-kernel+bounces-416346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7CC9D438C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064FBB2531B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C21CACE5;
	Wed, 20 Nov 2024 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="evUxwzHM"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FAF1C9DF7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138453; cv=none; b=fBAiVNKHIjl6DD6FwYj+bsGYNd5yP0QZNGjUjPQMvsSBym5dirEtT1vVfPx6qQl3We1mNkZFxq7xuE1A6hdCklv7veEeMQRZGoIT+SmOasiumBQ4u85fMU26+0uCMx4Ztgvinqj6iUhaaOlBrxqEUiw3UvGy1nxoDyKk027PcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138453; c=relaxed/simple;
	bh=KPajQC1aALEfbneuHvtuGop3ovSJzfya4SbeCBcQxC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEWHJ1r+2QrzZlxkcu1ND41SofUNf/cF1eM9RnOosT4C3IAxcxhP/PuyN09LaPUS9OgdXBI+2piW7U2Dnmx7UO69aNrxQbnslyPQC3Qz/6JSoqIf/SHnsqcOR+Q8hz5ce1YXk076y23/GcUJvAxsA2Qyd1JDa9x40f8ZJXaaSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=evUxwzHM; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2958ddf99a7so270169fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138451; x=1732743251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOcVB06XaJFOi/s6psv+BsWaLcpfMNJDY6ZQUGIvfPw=;
        b=evUxwzHM37PcH3OZ+VRAL7LA11tobqW5GV7WawyP8IUEbHO7LGV3ZdpwpVyhlMvbNV
         xf60zvj0kB2wIWP8pVvxei9kE9ROpt0ih6HpvHWVqHGT959qp3M1TRszo4wEoQON9D5a
         1Ehpz3MCWJ5dhlRerh7Cdv5yafKVQlE8fDm9Ejrac1v7XHlKMplysY5VXuEKHJwX34Ak
         4hZBCyVoumari/S9I2m0/y51okrSof318rBcrblj2wd98vG4WVEWnDQAT/o4BQVMU7DY
         kKAd8U6W5MbZWf+lu5QQ+q1QpEsB11T9Jf2a6PjRTFkO4PN5ajWuNLoCaNyEndEYLCT0
         5LhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138451; x=1732743251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOcVB06XaJFOi/s6psv+BsWaLcpfMNJDY6ZQUGIvfPw=;
        b=GFqzSa+E+5QQnG9jO6zBz0EGFArARx5FZy1idDm25bkk5HBi6ViGLFdInixFudkMKv
         bEsJbRB6cOzXxK2v1YDAewoN40csZkScYjpGNll85CpirJ+znpfmMni0qnyeq2k7QZI1
         eOxCIku+QEyaRLFjEhXOUOqLHAaIF4tLvVzy7N6B+9O2+HtkFlqNSD7F5U6ZeOs/bDTL
         WUxXy1ZlktyIG+J+LhLLjvp1cI7xnCvq1RPve7vHkyzJOZqYuTw4x9nzers4Q5t8hRRv
         l9wQc9xZl/jwop+W5V5LeV5tvk88mEQeLGCH3FO+TfA5HmQvlmHaHKTk9DYZbGQj46kU
         DfOw==
X-Forwarded-Encrypted: i=1; AJvYcCVMJIuLu4ZscW5DKijlY6qoFn/sZZ/+tUSfoYSU4CvI3R8xmUpZpN++Ql2WGWAFEay9xnuKYsCxIDT2DN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3XZQvv1OLXGEc1NdTClio5qkGfqiOSABZpWkVuXXrkQu2xaZ
	+EKWb1gkropEhQGncT2Nuvm5Knc7PnAiXhtBnb41fJq/C9V9VUOZi40p6QAfiJs=
X-Gm-Gg: ASbGncsr853sxf6LjDpEOHMch/n0LV6uKFm6Sq2yszwB/Bep698GyM6ZBF5nEC9Y94q
	idYyCMPTGu0usqmcH6EAhiDa6gArnhQK9XAufIcSePndw+reVX5l2RWEUvrs3TTVkSHP8U78OBE
	vTJ/G86I0LYwIfqYxAAuuVm52TcTem/E/142Z7v0ajAut9KC7K4iuYxipbm/gzFoIOIaHF9s3LN
	Wwa+LFvuWNi9ns3UN66JrnK5xK9CSde90NZQMDj+mTjdrZrU1zSCt68v5HfzP3j2K1BGDS4Dwxa
	m6GNUg==
X-Google-Smtp-Source: AGHT+IGZjpgvy1HtxraukJAx9aw7qrY82YEtPjjvc0y70FfHyFvmqDxdPRVkajBg6fK1WC3NQZuHSA==
X-Received: by 2002:a05:6870:ad05:b0:296:9c08:51a3 with SMTP id 586e51a60fabf-296d9f50b0bmr4358153fac.39.1732138450920;
        Wed, 20 Nov 2024 13:34:10 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:09 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:30 -0600
Subject: [PATCH 07/11] iio: dac ad8801: drop driver remove function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-7-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Remove driver remove callback in the ad8801 driver.

By making use of devm_iio_device_register(), we no longer need a driver
remove callback. Also since this was the last user of spi_get_drvdata(),
we can drop the call to spi_set_drvdata().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad8801.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad8801.c b/drivers/iio/dac/ad8801.c
index bd857754fc11..8a362fae2eca 100644
--- a/drivers/iio/dac/ad8801.c
+++ b/drivers/iio/dac/ad8801.c
@@ -136,14 +136,13 @@ static int ad8801_probe(struct spi_device *spi)
 		state->vrefl_mv = ret / 1000;
 	}
 
-	spi_set_drvdata(spi, indio_dev);
 	indio_dev->info = &ad8801_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad8801_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad8801_channels);
 	indio_dev->name = id->name;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret,
 				     "Failed to register iio device\n");
@@ -151,13 +150,6 @@ static int ad8801_probe(struct spi_device *spi)
 	return 0;
 }
 
-static void ad8801_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-}
-
 static const struct spi_device_id ad8801_ids[] = {
 	{"ad8801", ID_AD8801},
 	{"ad8803", ID_AD8803},
@@ -170,7 +162,6 @@ static struct spi_driver ad8801_driver = {
 		.name	= "ad8801",
 	},
 	.probe		= ad8801_probe,
-	.remove		= ad8801_remove,
 	.id_table	= ad8801_ids,
 };
 module_spi_driver(ad8801_driver);

-- 
2.43.0


