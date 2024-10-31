Return-Path: <linux-kernel+bounces-390077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A87DD9B7538
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698ED2865FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C5B1547F5;
	Thu, 31 Oct 2024 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SLmNCP0p"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51114AD0D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359081; cv=none; b=smj4LHWxqPZfbOGBxeunnTUNLz1k10XQP8lsu0+ux2YLnqAKVd+BgOLPxR3R3Spz1M4YlZgkRRMjq+pNPuBr6zGZdYGYLcXEg2nP9oEZBIxDycsHGPrU4k/c1kYJeJM48DBFlim1Rok3RLDYPb82dIOuwlyq1+I6SvNFfdVhC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359081; c=relaxed/simple;
	bh=Wpo8Oj/klmyH5vH0z1jaegb5OcJIFZ72Wg0pt5glQAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HU3PC8AccPW4vcr5n/IUcejeR1TfTlO7vXIOH6JmbWfEMONOoAcBpypgHXJdj6c9VaMPyTAfHBxlO1+R/z7m2toFapl+Jwcw3HbeiWf0+YRFV1gw7IDvS+oxp1JP4xOyr1q/9/2TyLjoaAB67rTTUxoEEVScCj89c01UwBaCbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SLmNCP0p; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so4738125e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730359078; x=1730963878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta8KKdF2jcNVKVs5pCv9tj8EzXOBx+/a1iWRb1D6Seo=;
        b=SLmNCP0pbhwRhyQijQmytLoOPxPwgYWw6lRGZ841HjhOHC030QRUGftl9jVcK/77/r
         n3D4Uy2s0V3LNcm3w9JKgNL31pOmIHGm7N9D7RKKxXLaamunoXVGzkftDvkNhydly/vT
         6CCF8hfbDTT4y61/U5UORJKqiNQqdehlXxuv1mAYgmewffpUMZH9sPMjHgAI6XXlRbu8
         ubQpFiVpG+6+wTcDVapuEqFExWBlXX7xMT0eJpj+rl2K22/8pcw7ITIBfxvqJq6Ui+Kg
         XeDZ6Z6wH34oDsX6j/lpc9hHIbJo+1vgzGsN4bPAuILjwwjcV1ULO5qz8ODlGL6rRxwq
         FjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359078; x=1730963878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta8KKdF2jcNVKVs5pCv9tj8EzXOBx+/a1iWRb1D6Seo=;
        b=MR/Ok/IHY2Ydu6hORrxcjNV4c2OqIzOTTNyjZSqavloKNgcLlwo5CcJymEmWpa7Nxp
         pLRUrzN3Xsvjm53ZII5fnILIoe0sOKF9oPwfvyoHIZcL3SzPRPtWJUqQj63xAqkhU1b3
         uuEcWjOCJM6dGNqnd2CjOARYv6ETYhQRGL9t6W61RjSx0asRABfgnGdKr2yF0zaYx+WN
         WQRqIBZlzdlKB4yd5WtdrT0Y3A1dY1f3dRDMKXJzVVqj6muyk3mmPB997/W5OgwJiQ1P
         qHQaZ3hH/5M+l9MnTJzUxGuVNnA4goO8vt/43vvgInhMS0ZYQpH7KagVSUGEGCuYZ8Jp
         L0+w==
X-Forwarded-Encrypted: i=1; AJvYcCWyh3pKB2txPqv1ygBy6Krt34/RIkp0wSH9mk4WIm2sFaUVrt+vKM4QmPB5sXrCJ5GsA8GVStl3C9YkH7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMZUHY1L/Qj5Ml69KnxFo7faE+uURSlYcZqvCAjuwxuUQ5eWc
	FdxVmferUs0rsfcLCvIs2zqEEu7ruYMzD6eCd+DA2+Q0jcruOJTyXdkU6F3lyAs=
X-Google-Smtp-Source: AGHT+IFApzsnUKOt+RjkBsEFLWnDMKMhhkMDsz9e5PgIwP+GShRdVqxyiVYzdBFrvcfuDkSiF/a0ww==
X-Received: by 2002:a05:600c:4ecd:b0:431:6060:8b22 with SMTP id 5b1f17b1804b1-431bb9855a2mr50657975e9.10.1730359077813;
        Thu, 31 Oct 2024 00:17:57 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e694sm1187547f8f.86.2024.10.31.00.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:17:56 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v3 6/6] iio: dac: ad5791: Use devm_iio_device_register
Date: Thu, 31 Oct 2024 08:17:46 +0100
Message-Id: <20241031071746.848694-7-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031071746.848694-1-ahaslam@baylibre.com>
References: <20241031071746.848694-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

Use devm_iio_device_register to automatically free the iio device.
since this is the last remaining resource that was not automatically
freed, we can drop the ".remove" callback.

Suggested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/iio/dac/ad5791.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 92d47e766fd3..57374f78f6b8 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -411,24 +411,12 @@ static int ad5791_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "fail to write ctrl register\n");
 
-	spi_set_drvdata(spi, indio_dev);
 	indio_dev->info = &ad5791_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 	indio_dev->name = st->chip_info->name;
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		return dev_err_probe(&spi->dev, ret, "unable to register iio device\n");
-
-	return 0;
-}
-
-static void ad5791_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ad5791_of_match[] = {
@@ -457,7 +445,6 @@ static struct spi_driver ad5791_driver = {
 		   .of_match_table = ad5791_of_match,
 		   },
 	.probe = ad5791_probe,
-	.remove = ad5791_remove,
 	.id_table = ad5791_id,
 };
 module_spi_driver(ad5791_driver);
-- 
2.34.1


