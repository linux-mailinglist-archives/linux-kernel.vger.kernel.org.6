Return-Path: <linux-kernel+bounces-379022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C387A9AD8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43E71C2147A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D15200132;
	Wed, 23 Oct 2024 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XeADY2iq"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D31FAC51
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727682; cv=none; b=kxh+OZL52Up4oDI+rBMrMdGY9KOCAl8EbKhquxhufi5b1ydcY1rwi8r+GtQbtHlzeprxZsX6E8SbBYfO8YuyYwjg3zbnzZKGiQCZ9k6USox9Myb7ql3mBRVbF3eeOXZ2kEVsj9k/6UePfvo1C++wJVrmzZD2f7nf5OFomV0ERJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727682; c=relaxed/simple;
	bh=+qQPhpRBI2xebpxF2IUsDgxiRfAaR2OlImrgtgTUDY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TG5vNWKS7XIJfgmgV653oCYEsfs+AEzAW7fHd9uXg5v6wSIn2hKPDN59IpnOWzjuSrifvBYmz5o45kNFqXk6AmhKieOazzoVCwo0FFJ9Ip+l/upbt5L4UQLn2xzS+u1g2hptJak97BTcEU5dxB8D5TJruWNwPcJKqy0cNrzhOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XeADY2iq; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5e5568f1b6eso158867eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727680; x=1730332480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h499UsT6sj6xlYcZ1JadzuP0YnfDcZeLc9oTI16DnbI=;
        b=XeADY2iqLRL+REpr+OZSm17VgKoloGRHGFJ4+eqC3YT6BwSr7r9aZIULa0t9czILw4
         /HuwkkDFkdVKduOjlmzFLW3Gi4UC3vgs4o+FV47Ej3zEAQ9lZE7SGCSAdbcEJ0uYoUF6
         cS40p9bFP/cYaSpQ72DmuGz3Pb9Unddm9iV4OwFXH8+2d2uCY7Omz8ikv+9U2AeqnZSM
         tbYE9Ry8mw0S1tNXg2tifXwzN6HgC7xMEm8K0/zzecIt+LszllIRiGuApSi/jQXoj7GZ
         jMcXxxXnNJ9+VcmH/zIXoQ0FVsTwe+PGvqWjANqwKAcOVKe6esMaeNAOxw0+yPfhaHxB
         NSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727680; x=1730332480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h499UsT6sj6xlYcZ1JadzuP0YnfDcZeLc9oTI16DnbI=;
        b=QEIkg4/aKw4Kw5EWyzT3LuJSBhdy0ruQZkaD9MiMEDBu5Z5FWd+4mJ8p3DKBAcaR1v
         72tm8aJ1RHjQgOAzK9IhWmlcZ9R12LUFy5rNMkS89f4N0hKlK/tbbPrOymxco0lSs9pa
         wZA1Hl+5Ng2BmM+FHodITII1QJ0gCDnbiTcFv2DkiVAlzMyjI2sgaAQyBURmR2GVoa/n
         Zx2jFPJY6WpfnE46Ivw5OyZ2t9w8ReDZ92aj4ZedTC8QqD0GhfGzYz1vGF8B5e1GfoHg
         S42DJXHXslJsIXWZEe2INbbe7Oa63+7PdsBjvPl6rA8P7Viy8/Wg4GCHTXfI3GAL28W0
         wB+w==
X-Forwarded-Encrypted: i=1; AJvYcCXyqz2ZdPVvFqBT9iwHsf8zOlJSNnywYc6yMNX5VM3r5u6C5vnHAA3ilcYU2HNOJymrNP/Y0y+6zRjY59s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9pRnmKHHgqkbQZ6wCzF2GpvraIKM1uzgoYWHGWeODmppIK6+X
	YRH1SHGq+UigfhHTypw/DRVzD7rVxud/NfSS7rOT6T5OJ+VWpSQh+t20hLS7BVo=
X-Google-Smtp-Source: AGHT+IG0LoE+A40aIKnVIo1drlkt/dwuoqY7uHdyZBDpLRMrmduBDPpg6jxRGWmIdxyPu5IIHKkMeA==
X-Received: by 2002:a4a:ee95:0:b0:5eb:db1c:a860 with SMTP id 006d021491bc7-5ec057e1c3cmr123250eaf.8.1729727679948;
        Wed, 23 Oct 2024 16:54:39 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:05 -0500
Subject: [PATCH 01/11] iio: dac: ad5380: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-1-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5380.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 2e3e33f92bc0..7d1d7053c29e 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -47,7 +47,6 @@ struct ad5380_chip_info {
  * struct ad5380_state - driver instance specific data
  * @regmap:		regmap instance used by the device
  * @chip_info:		chip model specific constants, available modes etc
- * @vref_reg:		vref supply regulator
  * @vref:		actual reference voltage used in uA
  * @pwr_down:		whether the chip is currently in power down mode
  * @lock:		lock to protect the data buffer during regmap ops
@@ -55,7 +54,6 @@ struct ad5380_chip_info {
 struct ad5380_state {
 	struct regmap			*regmap;
 	const struct ad5380_chip_info	*chip_info;
-	struct regulator		*vref_reg;
 	int				vref;
 	bool				pwr_down;
 	struct mutex			lock;
@@ -400,42 +398,32 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 	if (st->chip_info->int_vref == 2500)
 		ctrl |= AD5380_CTRL_INT_VREF_2V5;
 
-	st->vref_reg = devm_regulator_get(dev, "vref");
-	if (!IS_ERR(st->vref_reg)) {
-		ret = regulator_enable(st->vref_reg);
-		if (ret) {
-			dev_err(dev, "Failed to enable vref regulators: %d\n",
-				ret);
-			goto error_free_reg;
-		}
-
-		ret = regulator_get_voltage(st->vref_reg);
-		if (ret < 0)
-			goto error_disable_reg;
-
-		st->vref = ret / 1000;
-	} else {
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0 && ret != -ENODEV) {
+		dev_err(dev, "Failed to get vref voltage: %d\n", ret);
+		goto error_free_reg;
+	}
+	if (ret == -ENODEV) {
 		st->vref = st->chip_info->int_vref;
 		ctrl |= AD5380_CTRL_INT_VREF_EN;
+	} else {
+		st->vref = ret / 1000;
 	}
 
 	ret = regmap_write(st->regmap, AD5380_REG_SF_CTRL, ctrl);
 	if (ret) {
 		dev_err(dev, "Failed to write to device: %d\n", ret);
-		goto error_disable_reg;
+		goto error_free_reg;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(dev, "Failed to register iio device: %d\n", ret);
-		goto error_disable_reg;
+		goto error_free_reg;
 	}
 
 	return 0;
 
-error_disable_reg:
-	if (!IS_ERR(st->vref_reg))
-		regulator_disable(st->vref_reg);
 error_free_reg:
 	kfree(indio_dev->channels);
 
@@ -445,14 +433,10 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 static void ad5380_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5380_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
 	kfree(indio_dev->channels);
-
-	if (!IS_ERR(st->vref_reg))
-		regulator_disable(st->vref_reg);
 }
 
 static bool ad5380_reg_false(struct device *dev, unsigned int reg)

-- 
2.43.0


