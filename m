Return-Path: <linux-kernel+bounces-416342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373CE9D4382
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D8E2838E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B41C830E;
	Wed, 20 Nov 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qC7HF0d7"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08A1C68BD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138447; cv=none; b=p7Bkp0vB90KxzhoDvJZRpcvFB1hwXEr0ibbNbO/CvBSnZzOaSgIme4rnFyU5iW3defdGb9wDauHXkwU02IXy31rzIpNWtQ/eI9UOBEz8wsaU2WstZRs8qGcvUCEk0gV/CFUxesjXBV15iyekKRN+DZjpnXtWk9JftVg598h/9jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138447; c=relaxed/simple;
	bh=fa64DP6YB+c3vhGXH9bhQQ4ElBrLFlB1lU4ITho9Z44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOTZG2FOaWXpj9FhTiI7HFI3s2oAeTWCgGwjyl+JkG+aZpUxzdE7c/U5tw/2JyeCcyOVduSb3o34TYOx//n5+Iq3QJYujOrIvhRVbkzDlRhgYkNU6PPJwjGVk80o4IeY+ZQlDsw3dkQ+dqA/lzh0ILJ3hJAo4UfGia5KOXbsOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qC7HF0d7; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29685066b8dso201292fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138445; x=1732743245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpOmExH/YBf4JnNMGa7Hs+sH1CTkB96FSCJMK4b4hAo=;
        b=qC7HF0d7DVxghbEIJix3Oqle7MwZQyvj2cch0778I2tsESS743K0YtUJGr7Aj2G4tf
         Ewjhw/Ec6QRn/opHi0Ua9LaTXH9RfoUqfj2ZUyWhunFsEe7TOdWcH81oj9R9Ahq1K1OD
         vl7sVWBqJx5DTtLwSbVSnxq/NKzcv7y7u8B4RazxULgmPN6bRZzyMng7Ab/CeeItYl8l
         IniMiNed+th9OUfccHfd/ekaFETw/UZt6pvvfvgcSXveWIWHB9upxCFLyrSAy0ujZ8Gb
         2bmfU2GfXZvbl+HPD0RWRh7SA4T3rnPrEbX1lxHNTeF2nOOIpPMJHiuWVLqHJ5pzKHNO
         gqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138445; x=1732743245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpOmExH/YBf4JnNMGa7Hs+sH1CTkB96FSCJMK4b4hAo=;
        b=dZhJx3VEywARKmzgzpEq3vxVuIwP3tL5ERbpDxgA08tlRd4/fRp8K+zHxbkdej0IyF
         WUCKwolbwFExfFnPM1HeaoZMv+WopvJ3EEuIVT0xNfIaS5YqvGPgRPSKk/UGQZy806qL
         uDLJtwOIesZWyV2QLz8FP8kSGZIvdM8tNou+MRd0S0Nf3dloAGn5ADJKyZl37YmqWjyG
         buFxqJECWkmIknngFJM9rFZWCF+i4wx7RBah68QYosDIFpx6xqb393uoZ/HpFHIEOhBR
         s1TqnHJ7Ot1DdEZM5LVyqddX8zefDQuGAKzBfSNzg1g2plYaKtb/OWzQS68Jrdrndych
         GGEw==
X-Forwarded-Encrypted: i=1; AJvYcCWSBgJ/nYH+lAuQmYw68tADGHcz+0yfWThlsyuwvLBUdpMJJMzqtQ/30JbwWj0KV65D4aoT0YQevSH79lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsdODypTPS8PwUsLmGMPER5fUALmeMGeFpQSXrwQ5r3T/gppk
	ag2ROhALgTEVPrcaiyGZvlmM3Jh1ousYkChi3ifEhzmrGfmfHsm2Nkk7vkJ9QNA=
X-Google-Smtp-Source: AGHT+IErwTdkpK036l2hmrQRg+PDO2T/siAI4WUnVHxNCqr/YbIrLdH2n8uBYHzhdrFruzr/J2XqQw==
X-Received: by 2002:a05:6870:a413:b0:287:7a8c:4f15 with SMTP id 586e51a60fabf-296d9b5c38cmr4696763fac.20.1732138445079;
        Wed, 20 Nov 2024 13:34:05 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:26 -0600
Subject: [PATCH 03/11] iio: dac: ad5686: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-3-d5a5360f7ec3@baylibre.com>
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

There is a small change in behavior. Before, all errors from
devm_regulator_get_optional() were ignored and assumed to mean that
the external reference supply was absent. Now, only -ENODEV is checked
and other errors will cause a failure to probe. So now, this will
catch errors, like using the wrong data type for the devicetree
property.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5686.c | 53 ++++++++++++++----------------------------------
 drivers/iio/dac/ad5686.h |  2 --
 2 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 57cc0f0eedc6..a8a38879fc40 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -455,8 +455,9 @@ int ad5686_probe(struct device *dev,
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
 	unsigned int val, ref_bit_msk;
+	bool has_external_vref;
 	u8 cmd;
-	int ret, i, voltage_uv = 0;
+	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
@@ -469,25 +470,14 @@ int ad5686_probe(struct device *dev,
 	st->write = write;
 	st->read = read;
 
-	st->reg = devm_regulator_get_optional(dev, "vcc");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0)
-			goto error_disable_reg;
-
-		voltage_uv = ret;
-	}
-
 	st->chip_info = &ad5686_chip_info_tbl[chip_type];
 
-	if (voltage_uv)
-		st->vref_mv = voltage_uv / 1000;
-	else
-		st->vref_mv = st->chip_info->int_vref_mv;
+	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+
+	has_external_vref = ret != -ENODEV;
+	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
 
 	/* Set all the power down mode for all channels to 1K pulldown */
 	for (i = 0; i < st->chip_info->num_channels; i++)
@@ -505,12 +495,12 @@ int ad5686_probe(struct device *dev,
 	case AD5310_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
 		ref_bit_msk = AD5310_REF_BIT_MSK;
-		st->use_internal_vref = !voltage_uv;
+		st->use_internal_vref = !has_external_vref;
 		break;
 	case AD5683_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
 		ref_bit_msk = AD5683_REF_BIT_MSK;
-		st->use_internal_vref = !voltage_uv;
+		st->use_internal_vref = !has_external_vref;
 		break;
 	case AD5686_REGMAP:
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
@@ -519,40 +509,27 @@ int ad5686_probe(struct device *dev,
 	case AD5693_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
 		ref_bit_msk = AD5693_REF_BIT_MSK;
-		st->use_internal_vref = !voltage_uv;
+		st->use_internal_vref = !has_external_vref;
 		break;
 	default:
-		ret = -EINVAL;
-		goto error_disable_reg;
+		return -EINVAL;
 	}
 
-	val = (voltage_uv | ref_bit_msk);
+	val = (has_external_vref | ref_bit_msk);
 
 	ret = st->write(st, cmd, 0, !!val);
 	if (ret)
-		goto error_disable_reg;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	return 0;
+		return ret;
 
-error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
-	return ret;
+	return iio_device_register(indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad5686_probe, IIO_AD5686);
 
 void ad5686_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5686_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
 }
 EXPORT_SYMBOL_NS_GPL(ad5686_remove, IIO_AD5686);
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 5b150f344fda..62eb309711af 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -118,7 +118,6 @@ struct ad5686_chip_info {
  * struct ad5686_state - driver instance specific data
  * @spi:		spi_device
  * @chip_info:		chip model specific constants, available modes etc
- * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
@@ -130,7 +129,6 @@ struct ad5686_chip_info {
 struct ad5686_state {
 	struct device			*dev;
 	const struct ad5686_chip_info	*chip_info;
-	struct regulator		*reg;
 	unsigned short			vref_mv;
 	unsigned int			pwr_down_mask;
 	unsigned int			pwr_down_mode;

-- 
2.43.0


