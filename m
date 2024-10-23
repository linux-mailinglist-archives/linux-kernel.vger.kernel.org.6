Return-Path: <linux-kernel+bounces-379024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336349AD8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F0E1F26B97
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69989200BB8;
	Wed, 23 Oct 2024 23:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OEN7a9NJ"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651662003DF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727689; cv=none; b=jgnG94tMYvIEXs72RbXjiG784IK2baG/nxBY4zPSkP0cuhUiKNAxErpGzwUdnmwqLJsdyNlcNapjO/uOUaYk/JsAJk5vbOE+ag/0YUh0BZEP8IG+iIXCc/A4l+X+I9w8zWbwfql3cktbt5/ewheq1LVigdOG4Yd7O0gNMJIKUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727689; c=relaxed/simple;
	bh=BZeNhUpFlkIYdGaRA/ukfyi29Qtnq8SmBSpRm9b6skE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMdjrcnoNbxve91/v8jLn9RcCw2dM+XALE96eIQbMiYTNYFCet0R7N0gD3HAkFQ+YzRBME6fH9ixFlKa2jWW10yrbeLtZL9KWW6usneYvFlO+iyyx+jhNwAxayEoyw71aXP9Kc+vMwLizIUBB+l4qW/aLnVKtEurP0VdjyoaVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OEN7a9NJ; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5eb5f07410aso155375eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727685; x=1730332485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIpJs6ysMWquyQzdUXSLhEt4udqL7m21w5SiuwdawWo=;
        b=OEN7a9NJi/wWWUqM8TdHgN8IFz2fiBenKgnNERE8W6gPb6qFMHP9SsxPBkShkzFcmj
         G326otOw0qdXHQYq7maBUnUTfn6ty8rlBpTqfwt80Tq4p6p8T+KnsZ1a39Mw48wRT59p
         2ucb6bvBHbv8bDG0z6bFexXEdRmAxxc8Q2XOIK/YslNDiFlsHLXFOmIR6Al0X1vPzoBU
         wg9cQ3KO815ibQXylNjAHYchTg7wc86Z94jy1QjZ2pyyTivXMlZXjJIV4mSbOySaSLRr
         K+a+P/KS4n2gwFJ6KGeKpiMkRBmJvNCIeXegKzBeM0NR2dAqnZdxvOXpMg6JpL+44Vez
         i5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727685; x=1730332485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIpJs6ysMWquyQzdUXSLhEt4udqL7m21w5SiuwdawWo=;
        b=ao+N2qliQOSdepGJDcjkxeHZo7BNtOJHfFxH+bQaufOjusw6+0cInGZJVHngOMMhhT
         f8u4k2U6sUFFYkNJE3/PxwOvIm71Aj5Dw05ldOsRI2hKUrF/mciuk61oLheoOrCJjHf7
         8ITPBFZNjCaJ25mwo5lX6VYqOsk3il6sLX6pSVkoByzMAWenfkOW1Fuiqn+aq79tj3Rm
         6yjlHm5sjYXNeW5fHkCZd+VEnwdRdEK8EPYwEBrG6U0c+qLps1+oC0IUdpGHUYsmpmR9
         x0RUJhxVaOlYufcG5o32MQtJGWI1J5sirsay1i3Xj714jomM7avN4fUEmLrygdN4cfIm
         MOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUeRRJg2vu0zzuPdZtSqsorrx3drZ8aeLXzpsAUfIxgv4qM315srn9/21oX6o2O+f16r3+tFdRz1omhS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCKv8qX4atE3l3D46BBdZHGhUzCpCChUbMuryIqLgWvZwkjt0
	SfTMS8ivbRSXMq4MuypcOPEEIiBRaWyJgnST+UPS5fNQjBErXIp/RkkUI32sq2A=
X-Google-Smtp-Source: AGHT+IGo8FI1xaZrv+ilwOQNiRHtt7Ey1e86tF2/rnmxXcdoKSdAIdz9WvjSqMtBq2Hp4kNTnjKXhw==
X-Received: by 2002:a05:6820:628:b0:5eb:4f45:d209 with SMTP id 006d021491bc7-5ebee6dd82bmr3108682eaf.3.1729727685558;
        Wed, 23 Oct 2024 16:54:45 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:07 -0500
Subject: [PATCH 03/11] iio: dac: ad5446: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-3-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Also simplify == NULL check while we are touching that line.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5446.c | 57 ++++++++++++++----------------------------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 708629efc157..574de97c1c08 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -32,7 +32,6 @@
  * struct ad5446_state - driver instance specific data
  * @dev:		this device
  * @chip_info:		chip model specific constants, available modes etc
- * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
  * @cached_val:		store/retrieve values during power down
  * @pwr_down_mode:	power down mode (1k, 100k or tristate)
@@ -43,7 +42,6 @@
 struct ad5446_state {
 	struct device		*dev;
 	const struct ad5446_chip_info	*chip_info;
-	struct regulator		*reg;
 	unsigned short			vref_mv;
 	unsigned			cached_val;
 	unsigned			pwr_down_mode;
@@ -226,32 +224,16 @@ static int ad5446_probe(struct device *dev, const char *name,
 {
 	struct ad5446_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *reg;
-	int ret, voltage_uv = 0;
-
-	reg = devm_regulator_get(dev, "vcc");
-	if (!IS_ERR(reg)) {
-		ret = regulator_enable(reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(reg);
-		if (ret < 0)
-			goto error_disable_reg;
-
-		voltage_uv = ret;
-	}
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
+	if (!indio_dev)
+		return -ENOMEM;
+
 	st = iio_priv(indio_dev);
 	st->chip_info = chip_info;
 
 	dev_set_drvdata(dev, indio_dev);
-	st->reg = reg;
 	st->dev = dev;
 
 	indio_dev->name = name;
@@ -264,33 +246,26 @@ static int ad5446_probe(struct device *dev, const char *name,
 
 	st->pwr_down_mode = MODE_PWRDWN_1k;
 
-	if (st->chip_info->int_vref_mv)
-		st->vref_mv = st->chip_info->int_vref_mv;
-	else if (voltage_uv)
-		st->vref_mv = voltage_uv / 1000;
-	else
-		dev_warn(dev, "reference voltage unspecified\n");
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	return 0;
+	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+	if (ret == -ENODEV) {
+		if (chip_info->int_vref_mv)
+			st->vref_mv = chip_info->int_vref_mv;
+		else
+			dev_warn(dev, "reference voltage unspecified\n");
+	} else {
+		st->vref_mv = ret / 1000;
+	}
 
-error_disable_reg:
-	if (!IS_ERR(reg))
-		regulator_disable(reg);
-	return ret;
+	return iio_device_register(indio_dev);
 }
 
 static void ad5446_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
 }
 
 #if IS_ENABLED(CONFIG_SPI_MASTER)

-- 
2.43.0


