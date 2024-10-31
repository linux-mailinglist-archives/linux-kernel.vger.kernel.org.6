Return-Path: <linux-kernel+bounces-390076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C876C9B7533
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8830E286552
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F691547EE;
	Thu, 31 Oct 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cMW1ujZN"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E02149005
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359079; cv=none; b=Qp9gx15z6xnZ3bcrRZgJ+HOA8m5m5pxl+ZsHyjfH6PAUOuRuytIXss4yeGp2qy3YOw5YgeoDNxnioGbMl6UYePFiLyVhfGrguR2LehHSYaSGvdkzYkZill8HfuoRBKQqkzvKL9mwTMUaKtsXkB905XKLW3PsPbwUikkEsW2OKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359079; c=relaxed/simple;
	bh=Op2p8Q2E5igZsGlkYWqymbzX2Ifj7PSmb49r/ALp7lU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJ388S4uOpk96kDDNIbTc3Ui90/UwM0TXusfOiIk+XGOOMuisgJPYqEaK6fQo5NThE+ysuqbBq+BpkGGdQ2aIQoyk+QJES+EF6kW6Wimrq/q0hrYcDycxawTm0e+jm0FZQScg23Wwuh9Suiyao3G1n6GDFGGzgJ64xSxmdtBr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cMW1ujZN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so393624f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730359075; x=1730963875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1pq/Bgv4QeCrwiPVa9U9DPj0A/SeEyPL96AcSHmLho=;
        b=cMW1ujZNbrhUsB95uM8iS5Y66yMmzaqHwBPFll+On9vBj8euqJESQl596o9IleEmWd
         ePwZ+Qrrk9gMDKteXQ3ULgYEU7hB7urb1vmNX5XBb2N5TbWea9ZP6N+uipU8fuYVRcWq
         f3N+3xdXiiVYWgjbb7OpCv+sHvWKMrm7iN0v9+4eSuMsgdXT1ODczUlmmimjiz5bU7l+
         CQKKrSxoPqEfcDNTGwJF7EAWhP/H2K2B3nm7xBc766OumapcsWVNKOkgv0INh2YaPg32
         2pld/G1OgP9ozhnNCpimS5bZtUb0xvHGfcLVrRepiCKzJKgy8blka6baWqheMK5/MTIs
         t0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359075; x=1730963875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1pq/Bgv4QeCrwiPVa9U9DPj0A/SeEyPL96AcSHmLho=;
        b=kGSAoaAmae92DzTgVpVqA3mwPuBY7+Fv/KotbiEJ65KWyxEFkCuBNHTHfZJyCGLmUm
         67dYBoVt/lmAKG4QFBB5FK/WN5EhHHL8CD7JA+kJ+XBn1+fEmn5pH8YUuSpMulTm2gOF
         bv03LGB7J3VAAOt3bDeLh+bIokkq9vmm4KF8M/5+Xq8fPAtRgER2NhUtbe6/Yz8v37km
         96dSEWWf4SUQ7hgJGs5I818BbDII2bPg6kx0jUutmAEriSS7bNDlrFis20ZW4pBnTQe7
         Fcld810tAJ8rG8mysztIzmVsjFdRXKh8+c22tB7w7UDph1ipI2vO9avZ0RSGFWY1ydcJ
         MtlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBAcuU5LoCueY5MnGe8ggFOeNuDjXHpBHidt7kh2PLN82AVBtal9OPiNMbAxI+CoabMaptW3LEx8uv1M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFUURGrxlVYU2CwuHNEhTRKYgPYdOdWA7zGv7pTU6uUpEiGE7I
	WCd4QSEuUhyLOOG2+u/y/zhpv9q3bbx81O4BHBWnbM/zSZpyyHRlypc7L+v98TE=
X-Google-Smtp-Source: AGHT+IGW7kCzNAoBXXZ34GznNmWRMdGAze3cMSGQu0oer+FnmY9AH27Byjv+q+Uux4qqJf3Mcgy/wA==
X-Received: by 2002:a5d:6a4e:0:b0:37d:4e74:689 with SMTP id ffacd0b85a97d-380611ed135mr13359122f8f.47.1730359075031;
        Thu, 31 Oct 2024 00:17:55 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e694sm1187547f8f.86.2024.10.31.00.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:17:54 -0700 (PDT)
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
Subject: [PATCH v3 4/6] iio: dac: ad5791: Add reset, clr and ldac gpios
Date: Thu, 31 Oct 2024 08:17:44 +0100
Message-Id: <20241031071746.848694-5-ahaslam@baylibre.com>
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

The ad7591 has reset, clr and ldac gpios. For the DAC to output data
continuously written to the data register the state of these gpios needs
to be set by the driver.

Add these gpios to the driver making them optional in case they are fixed
on the pcb.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/iio/dac/ad5791.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index f6b9a40241f3..c5d4d755d57a 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/device.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
@@ -76,6 +77,9 @@ struct ad5791_chip_info {
  * @spi:			spi_device
  * @reg_vdd:		positive supply regulator
  * @reg_vss:		negative supply regulator
+ * @gpio_reset:		reset gpio
+ * @gpio_clear:		clear gpio
+ * @gpio_ldac:		load dac gpio
  * @chip_info:		chip model specific constants
  * @vref_mv:		actual reference voltage used
  * @vref_neg_mv:	voltage of the negative supply
@@ -88,6 +92,9 @@ struct ad5791_state {
 	struct spi_device		*spi;
 	struct regulator		*reg_vdd;
 	struct regulator		*reg_vss;
+	struct gpio_desc		*gpio_reset;
+	struct gpio_desc		*gpio_clear;
+	struct gpio_desc		*gpio_ldac;
 	const struct ad5791_chip_info	*chip_info;
 	unsigned short			vref_mv;
 	unsigned int			vref_neg_mv;
@@ -337,6 +344,22 @@ static int ad5791_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
+
+	st->gpio_reset = devm_gpiod_get_optional(&spi->dev, "reset",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_reset))
+		return PTR_ERR(st->gpio_reset);
+
+	st->gpio_clear = devm_gpiod_get_optional(&spi->dev, "clear",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_clear))
+		return PTR_ERR(st->gpio_clear);
+
+	st->gpio_ldac = devm_gpiod_get_optional(&spi->dev, "ldac",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_ldac))
+		return PTR_ERR(st->gpio_ldac);
+
 	st->reg_vdd = devm_regulator_get(&spi->dev, "vdd");
 	if (!IS_ERR(st->reg_vdd)) {
 		ret = regulator_enable(st->reg_vdd);
@@ -382,9 +405,14 @@ static int ad5791_probe(struct spi_device *spi)
 		dev_warn(&spi->dev, "reference voltage unspecified\n");
 	}
 
-	ret = ad5791_spi_write(st, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
-	if (ret)
-		goto error_disable_reg_neg;
+	if (st->gpio_reset) {
+		fsleep(20);
+		gpiod_set_value_cansleep(st->gpio_reset, 0);
+	} else {
+		ret = ad5791_spi_write(st, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
+		if (ret)
+			goto error_disable_reg_neg;
+	}
 
 	st->chip_info = spi_get_device_match_data(spi);
 	if (!st->chip_info)
-- 
2.34.1


