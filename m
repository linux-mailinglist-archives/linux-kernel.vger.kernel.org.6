Return-Path: <linux-kernel+bounces-262563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6DD93C8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E01B1F22822
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D35E3FB96;
	Thu, 25 Jul 2024 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r/UoYBBJ"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116F52B9B5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721935380; cv=none; b=hXlELJZg7SoYmPKk2nXUvm4qI8019/niUDp2t6cBBWKW9t2COozqD10DvnwVL2I7/J4vFtBds1te0ExsZLhp9GGQ/Foo5PT44c5Zjhlh7U3UrHgmugQPwvc/mnLg36yrrI/1srlozF/Kq4VOC73/diqTihkOL3at7jLC3X9Hux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721935380; c=relaxed/simple;
	bh=W74KhW7f18fdckH7PTnmfHoJXiOMCXxtfnQ2XKj2YVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HU3RzUqbCQaxHQeKWJwdJIQTFYjn9r3wd0YOQhgex8tgEkj6PXv6xfqFj3/ly7X3QSKhEJPWKfEmlA1s+oedC16QDqnwRQCNB9f/fTGqCMjacA/+nLcUwUsw5F1uSQI8GGbp/4sHzXlgqr4TbzrU2SNQRyQ+zeOHo5nviyDtbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r/UoYBBJ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5aeaa9751so153890eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721935376; x=1722540176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQMh1UJAxymzMN0ie+0N/QmjWGT/RhgZsPJdQF8YRPU=;
        b=r/UoYBBJ3Oye1sxuBHmMI6HcrVE7bRqgsUog/iYYK72qaIdi68L7t+4xXn223Gn/Py
         1fDz+oLmFqR4mpChqSDB/a4IqbriuOpAWUWio4z0XztHvrwoyEE/cp33D1NRQHYcNGrz
         eY2lkALflsHeQKGOzNrXG+PksokJ3nAe6OEvSpWIilIRPZ3hmlRJoHAc9ekktgKECO6U
         BmS33+JxCqjDpXJEgPTACT9yWo9tj4CiQJikvGP06VMi8fx7Hf3UIJ148ATJX/QYqz5p
         kXLotvuWcdtRw/YYRWXu2HwZ6+8IIyz6OZUnMu1tKl1k5YGPo3P9U/ZLvLfcr+q7ozsV
         +aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721935376; x=1722540176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQMh1UJAxymzMN0ie+0N/QmjWGT/RhgZsPJdQF8YRPU=;
        b=vpJoZRAiBGU6SjlkEHFbmPjDCPrxBLD9C34RKDit8lpsqN60kt1hmJb8T2baBbdMcZ
         bKP2NRQPXDAoLtwtomKFhk4KyaZ9LX2opO3s7eBAtk1iLHH8bgEwPVeDO1MbheCvZEJR
         7dXVwC1oTcUeWqFj/JyyO9ZwEyR2BqKOURSBlm+29XfXL9GyZH2ru90oBzNeV2UC3TB4
         j59b+1J3Hj9H7r8andScH4Sr0518uKqxhN+xmnU4Zbn06KFFgaBo872BeWeKTn+Lp9zN
         vH5OopMxI9mdR+XxiSPI1rwzNz5f5cBgQuaUIthXpmrK9ohYo6JQvUNHjroY3EES6ja9
         U8wA==
X-Forwarded-Encrypted: i=1; AJvYcCX9+w3ZphVRLkS1+OjGfOw2i1wqK9riNDrvR3ame75Q39VdpCUf7oSvF6ij4qGuM76NQgCRhuhLQkFNLJiJu9UIshd0wE1kuGd/0cFv
X-Gm-Message-State: AOJu0Yz6Af6KHqwRH0WnynNboPnxWYBybVBhMpf8PkyGZzhi0rAZUJ58
	eTjcbqWZDxxizTvBCKCw+1gdUvbs6Pb9TgrKXPO9bcxgejnP8A6J6yrGbQ5wuK8=
X-Google-Smtp-Source: AGHT+IHMS9ikhdwjEYofufmWSmmPD+rPCz3HDWUd5S/cb+div34BY8osZupPZHJa9CXarrFW8kIhUQ==
X-Received: by 2002:a05:6820:1b09:b0:5c4:7b18:b8eb with SMTP id 006d021491bc7-5d5ad9c892dmr5616917eaf.2.1721935376103;
        Thu, 25 Jul 2024 12:22:56 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930778280sm417754a34.64.2024.07.25.12.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 12:22:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	kernel@pengutronix.de,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ti-tsc2046: use devm_regulator_get_enable_read_voltage()
Date: Thu, 25 Jul 2024 14:22:51 -0500
Message-ID: <20240725-iio-regulator-refactor-round-4-v1-1-55e9dc1de325@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Use devm_regulator_get_enable_read_voltage() to replace
tsc2046_adc_configure_regulator() which does the same thing.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-tsc2046.c | 54 ++++++--------------------------------------
 1 file changed, 7 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 24b1d4390872..311d97001249 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -142,7 +142,7 @@ enum tsc2046_state {
 struct tsc2046_adc_priv {
 	struct spi_device *spi;
 	const struct tsc2046_adc_dcfg *dcfg;
-	struct regulator *vref_reg;
+	bool internal_vref;
 
 	struct iio_trigger *trig;
 	struct hrtimer trig_timer;
@@ -258,7 +258,7 @@ static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
 	case TI_TSC2046_ADDR_VBAT:
 	case TI_TSC2046_ADDR_TEMP0:
 		pd |= TI_TSC2046_SER;
-		if (!priv->vref_reg)
+		if (priv->internal_vref)
 			pd |= TI_TSC2046_PD1_VREF_ON;
 	}
 
@@ -741,49 +741,6 @@ static void tsc2046_adc_parse_fwnode(struct tsc2046_adc_priv *priv)
 	}
 }
 
-static void tsc2046_adc_regulator_disable(void *data)
-{
-	struct tsc2046_adc_priv *priv = data;
-
-	regulator_disable(priv->vref_reg);
-}
-
-static int tsc2046_adc_configure_regulator(struct tsc2046_adc_priv *priv)
-{
-	struct device *dev = &priv->spi->dev;
-	int ret;
-
-	priv->vref_reg = devm_regulator_get_optional(dev, "vref");
-	if (IS_ERR(priv->vref_reg)) {
-		/* If regulator exists but can't be get, return an error */
-		if (PTR_ERR(priv->vref_reg) != -ENODEV)
-			return PTR_ERR(priv->vref_reg);
-		priv->vref_reg = NULL;
-	}
-	if (!priv->vref_reg) {
-		/* Use internal reference */
-		priv->vref_mv = TI_TSC2046_INT_VREF;
-		return 0;
-	}
-
-	ret = regulator_enable(priv->vref_reg);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, tsc2046_adc_regulator_disable,
-				       priv);
-	if (ret)
-		return ret;
-
-	ret = regulator_get_voltage(priv->vref_reg);
-	if (ret < 0)
-		return ret;
-
-	priv->vref_mv = ret / MILLI;
-
-	return 0;
-}
-
 static int tsc2046_adc_probe(struct spi_device *spi)
 {
 	const struct tsc2046_adc_dcfg *dcfg;
@@ -825,10 +782,13 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 	indio_dev->num_channels = dcfg->num_channels;
 	indio_dev->info = &tsc2046_adc_info;
 
-	ret = tsc2046_adc_configure_regulator(priv);
-	if (ret)
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
 		return ret;
 
+	priv->internal_vref = ret == -ENODEV;
+	priv->vref_mv = priv->internal_vref ? TI_TSC2046_INT_VREF : ret / MILLI;
+
 	tsc2046_adc_parse_fwnode(priv);
 
 	ret = tsc2046_adc_setup_spi_msg(priv);

---
base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
change-id: 20240725-iio-regulator-refactor-round-4-13f032a6f2cc

