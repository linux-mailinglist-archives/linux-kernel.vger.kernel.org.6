Return-Path: <linux-kernel+bounces-379027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273939AD8CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDC028448D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AD32038CC;
	Wed, 23 Oct 2024 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pEHMMLjj"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B62022FE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727697; cv=none; b=EhewJutiL4fj+CnJ92hZZ1UQttKAz8SNVFR34+ohOgiLnafMH69xAH17P6O+c84S0VVFdDwfrnikE/KrAC6tqKTY13J29XQKfcgyG36JwCGibXUftqKIpXc9pehlcblSQ13iwEMOiyfJM5v29Xta6iEBKmg06/R/xeLjQiaFGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727697; c=relaxed/simple;
	bh=eodQcTyvrhGf+yUx3CV8lHgZoGBVQssedMmfdXFFW70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0vKFWdAU+KUaQtePBKsBR0E3vqItsJLMzNaloPqpkZpndU3NAPwjIuC0eA3ljSt2MPtjMzrMM94ZhIFk31ZnEYSTIR4zisBB3Yq/fJ/rTPgzR6RVlnsxlaJRSLfYgtX6NfWJ3+WkTQV+BTyJt1ErCWsS2ItLIK6xaJU+a9tjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pEHMMLjj; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-718123ec383so202405a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727693; x=1730332493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNDl0JsjI2ngL2OUq0CBnv+Q1hyMOtpynagqCTgnhh4=;
        b=pEHMMLjjBfPq/OGxfTStJ4BXiygNm9szm+eUn+yBT82JC8OO0Stw4QH2+F8t92Mujh
         J3BvXQdXhr2GE4THd9jHE3tezddcsZ3EFCKMCNpce5xOTvhw+KqVR25pcMQAhZWAFZAR
         18m8tSreFrxozz2DMXXRiajJ8u51U86yIAjNvlUELLtOstqzMnMdCgY2OaC7FILjMUq9
         1MvAAOeM9ae3G4s7qelBBD/HJkAaan1rX+pzm4hHZq17sYAh5QGxBzGwD4SqN3XRG7IE
         CJSknZqWomNnrc156eqepHCkhr70wXfAcAHMIb5YJNm5VAEgqz9RYrmppNyoyfLFxJan
         vayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727693; x=1730332493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNDl0JsjI2ngL2OUq0CBnv+Q1hyMOtpynagqCTgnhh4=;
        b=KGbl7HTlA0oIRPij72+NrOEc8hx26qPmskXMaYu0YIeDXfqQ3Y4z2f2BSq40MXfKhp
         QeUmnuuN/rr1zn/t9itC6LEkkBjfHU2AgRjlyD8UMpgwK8ZHUWf226cJyOqO2AW0jkl5
         Pd+sdgI3WkFvDksazFzxAUtN2oFYH8UjAckhVLgpUk0bB29DahlarzbUgQbNTX3AMCKB
         5RcOp9tcV/undphhxSp7O2r6+IorCQMQpmbkhG41qrH8NCJQ+TEnZCysmgYcd7n8iKaC
         2ZUC6z77dR+nz6N98RisyaUl6WHlTO21UhCvTPjpUcX+pHIk2y0aT1sOqeHNC3L0urwB
         lEJw==
X-Forwarded-Encrypted: i=1; AJvYcCXx05t2MBke1dEjro3vQTmXFA4IELtB9/R3L9PVVic0iQitiJb8vwVS5RrXrWiY9ep7TydBcPVn3hu6oy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8vGItlYFfkiSWKuXc9eeznVlJ3K7jcWmhLavM2nBk72vKp/PJ
	y71Rghs0YiLR8eA1ed5v+E5CGL42TfJJQWnnv6FzHy1g/7fNAPmzlC28s5Xanrs=
X-Google-Smtp-Source: AGHT+IFIuwReVcdIdbunzDzkviLkIqgHxfk94OzuL5c7zcvw3lrHA5VqCjHLaUK5+XcjjvThPDRwKA==
X-Received: by 2002:a05:6830:448b:b0:710:f375:a6c9 with SMTP id 46e09a7af769-7184b286fd8mr5065169a34.7.1729727692954;
        Wed, 23 Oct 2024 16:54:52 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:10 -0500
Subject: [PATCH 06/11] iio: dac: ad5504: drop driver remove callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-6-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Drop use of the driver remove callback in the ad5504 driver.

By making use of a a devm_ helper, we can avoid the need for the remove
callback entirely.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5504.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index f1717955ddcf..ff0765c8af47 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -279,7 +279,6 @@ static int ad5504_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
 
 	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
@@ -315,14 +314,7 @@ static int ad5504_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	return iio_device_register(indio_dev);
-}
-
-static void ad5504_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad5504_id[] = {
@@ -337,7 +329,6 @@ static struct spi_driver ad5504_driver = {
 		   .name = "ad5504",
 		   },
 	.probe = ad5504_probe,
-	.remove = ad5504_remove,
 	.id_table = ad5504_id,
 };
 module_spi_driver(ad5504_driver);

-- 
2.43.0


