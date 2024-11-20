Return-Path: <linux-kernel+bounces-416347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F59D438F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85807283860
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B01CB33A;
	Wed, 20 Nov 2024 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S7GJH91g"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5091CACDB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138456; cv=none; b=fD98bQGOsZyr60Ve3helKifCzfLfIdBMg4y8d1aCshbdD+PCBJbcZwoDwTN27DzTdEyMr+e2nXhatXOEyRy15abTynIZuZXYh7Ga8I2VtR3df8urupXrS3nBP8RWQlEOy+BcG/XlGd6PiZqhqwHcJjV/HWs9giQjltUXdsjhG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138456; c=relaxed/simple;
	bh=cqpjVH/ZHG/gtX5vBp7R7T9+N9m5GCO0J0pDNO2Q4Kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsVRdemCyjtBgEuyHtqqAQ84AyHZfcL4ghCAkZf+wuhidTjIbikxLVykiy3KDQyrNaMkznfYMsNbwdiFkZWnC9pySm5656ePu2EMBAa9q6s4AiUhkPXQ9C+wNCXBIGlyN3KuVjO10DJLYb9+MeNTYyOD9G3ilPb+SXFX9Oz7EBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S7GJH91g; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso285612fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138452; x=1732743252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEOSnirGLwe2cYoSNYVfb2qy88ppTs6R6KUAO1rKhdk=;
        b=S7GJH91gJmrpCWxFbekapCN3KauKDd6M5kC3f/Cr42LxAlz6ya7GKhll4OYuvrMaAm
         7muDJLFEDp6vFgBDQGUu8hs5G+Qydrze/U0dc1TksKycDFI2iQ4hB0nMQGYJ6GZL6Vyo
         C+Fkvp6GpIZdS8hqn696xnVHkd6ov9uDb1z5gk+WWZSPglzg2Wb//utFytLs+91nMnF4
         UqtHYG+smUjeNHuz918Fs3zstLm8vTUJ0zj9ctv3gTTpT5XdsAyYdLImlozfVXRK2G/6
         FLbCNb6cQ88yNv3V71lItfo+QC2HOcZD8oCR2poDpQDbubrotnF/sg2+Jui9H43bH4mw
         A/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138452; x=1732743252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEOSnirGLwe2cYoSNYVfb2qy88ppTs6R6KUAO1rKhdk=;
        b=dED3PQkdqE0wQ57uWK08KRYzGrnEXDI8xjzUf3gOlR7+yvkw8bfuCyJbNrrbt72q/d
         dLPbA2l6L6gNDDr8rBXdAHu2/I+OX+fn8Yxp77eLRj/h9zyfaS+jh2rh1aegbnYI5who
         V2+hFatSJZTb2x/kt/KJWqYYxFTQtXjtW43QH1tvcD9L7aEDfe4rO6Y8rZ/CTIz62S8H
         LBMhEs3aKRSn95d4Zma9ZJ9lw9U3/aFrhyOiHrjRqvpcF0svqqhB2RJ2PxN/QoIRZOff
         5wWbTyEDXUQM4jc8KQFMFwVHGsvi14R7fkN6KMaXkicoBLTlPX649/if2qfMMeMyranT
         Aoxw==
X-Forwarded-Encrypted: i=1; AJvYcCVqEKdQiYrQG/vYs8BUmidwNCM0Fq8HGEM2WkESj82jWsDK/hVBI5EJ71lip6IQGTfCEOf8u9yXVrk/iwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVr5sQmrD70c4B+NmxNFEBjYwIl8hp9VMP2bhOwl37yUY4mLtg
	p46/o+YX6tGpQVAFLTIkfmzA8DNAyfhvjK7Ap/0m6GdK+l+QXW/2bWEHDOBQp94=
X-Google-Smtp-Source: AGHT+IE3dNYFl8/w+vB/dPnniS0LPl8Cv8wHc2xOQWuQL26dH5rgdnki/dDN7dDXrEFszIQdl+kJPA==
X-Received: by 2002:a05:6870:c384:b0:296:de10:4ef with SMTP id 586e51a60fabf-296de10524cmr3093227fac.0.1732138452571;
        Wed, 20 Nov 2024 13:34:12 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:31 -0600
Subject: [PATCH 08/11] iio: dac: ltc2632: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-8-d5a5360f7ec3@baylibre.com>
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

Some use of dev_err() is replaced with dev_err_probe() to simplify
things even more since we are refactoring these lines anyway.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ltc2632.c | 58 +++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index a4fb2509c950..28f8347eb687 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -41,13 +41,11 @@ struct ltc2632_chip_info {
  * @spi_dev:			pointer to the spi_device struct
  * @powerdown_cache_mask:	used to show current channel powerdown state
  * @vref_mv:			used reference voltage (internal or external)
- * @vref_reg:		regulator for the reference voltage
  */
 struct ltc2632_state {
 	struct spi_device *spi_dev;
 	unsigned int powerdown_cache_mask;
 	int vref_mv;
-	struct regulator *vref_reg;
 };
 
 enum ltc2632_supported_device_ids {
@@ -310,6 +308,7 @@ static int ltc2632_probe(struct spi_device *spi)
 	struct ltc2632_state *st;
 	struct iio_dev *indio_dev;
 	struct ltc2632_chip_info *chip_info;
+	bool has_external_vref;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -324,43 +323,26 @@ static int ltc2632_probe(struct spi_device *spi)
 	chip_info = (struct ltc2632_chip_info *)
 			spi_get_device_id(spi)->driver_data;
 
-	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (PTR_ERR(st->vref_reg) == -ENODEV) {
-		/* use internal reference voltage */
-		st->vref_reg = NULL;
-		st->vref_mv = chip_info->vref_mv;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to get vref regulator voltage\n");
 
-		ret = ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER,
-				0, 0, 0);
-		if (ret) {
-			dev_err(&spi->dev,
-				"Set internal reference command failed, %d\n",
-				ret);
-			return ret;
-		}
-	} else if (IS_ERR(st->vref_reg)) {
-		dev_err(&spi->dev,
-				"Error getting voltage reference regulator\n");
-		return PTR_ERR(st->vref_reg);
-	} else {
-		/* use external reference voltage */
-		ret = regulator_enable(st->vref_reg);
-		if (ret) {
-			dev_err(&spi->dev,
-				"enable reference regulator failed, %d\n",
-				ret);
-			return ret;
-		}
-		st->vref_mv = regulator_get_voltage(st->vref_reg) / 1000;
+	has_external_vref = ret != -ENODEV;
+	st->vref_mv = has_external_vref ? ret / 1000 : chip_info->vref_mv;
 
+	if (has_external_vref) {
 		ret = ltc2632_spi_write(spi, LTC2632_CMD_EXTERNAL_REFER,
-				0, 0, 0);
-		if (ret) {
-			dev_err(&spi->dev,
-				"Set external reference command failed, %d\n",
-				ret);
-			return ret;
-		}
+					0, 0, 0);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+				"Set external reference command failed\n");
+	} else {
+		ret = ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER,
+					0, 0, 0);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+				"Set internal reference command failed\n");
 	}
 
 	indio_dev->name = fwnode_get_name(dev_fwnode(&spi->dev)) ?: spi_get_device_id(spi)->name;
@@ -375,12 +357,8 @@ static int ltc2632_probe(struct spi_device *spi)
 static void ltc2632_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ltc2632_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-
-	if (st->vref_reg)
-		regulator_disable(st->vref_reg);
 }
 
 static const struct spi_device_id ltc2632_id[] = {

-- 
2.43.0


