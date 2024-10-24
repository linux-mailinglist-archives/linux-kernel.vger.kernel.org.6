Return-Path: <linux-kernel+bounces-379032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5299AD8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1C51C20EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E8207A26;
	Wed, 23 Oct 2024 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EAjHzBmK"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAB206057
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727708; cv=none; b=NWhcgUwZ00Pjf8iI7iJX0GBhBRPszZuz2hEPE90cGhMgIodsrs64rPInwl/oZSEGX4DuK8XNAzIC6OapedwmomaA7eVb5rBm/UIG3l2kwxYiG1O9L7IpTHVObg6sGdBlfRsm6rhNHv+sC+zjN4YXACHdu0Ual3NeNJxqGcFy+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727708; c=relaxed/simple;
	bh=7NlO7cRYdSF3gG8gA/man+tCA4mOxbqbKKfGxWwRT8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JADExKYJA2ERksxr5jXUkc7qJHc2xa50uT/AW+MvR6uG7lihq3XqhxAoyOVrDLecbxQCcMD4UFsMT1HHgANECkZ3lToekQmA/omHI11PukI+/rTUQnCqli+oipfuN7rfARH8+Ck+4ShZF/sTfv4lTeYAW3akB/CQvLTYjbJxSGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EAjHzBmK; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7181b86a749so211249a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727706; x=1730332506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwdVzGcaQF7+SOsHpL7ftp3FlbFCZlW7or80O3tjS30=;
        b=EAjHzBmKfRNvKxkR7j4ajPcrpsrmP7EyDPxXiEudP3EoWd59EHq9pG9NlaLF9jh1lZ
         LKm9oHwLajAtdQqsiUJvHKplM/l1Vf/SkJ0MFCbXnqkH0NOhIoJ72+9Q9fq4ziX/nfOF
         BoRkz+SCgbbSUBCrNRYx3m8r/19IbDVHLVWxa3wlrv6vjxn8oS3qIkKNZoLH/r1kRB06
         rTYUTKwyTi91usAWuuRrQArwL2UzDQq1piD7jFC57CSLDrjE3Ohmte/yh/dUjPo5Kkg8
         qmQMulE7EtKjBBZBatMiYekVl+KuLzhUVaGfSYhN/Et146wg2PXOwPchc8Rb8nVOrp4s
         dd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727706; x=1730332506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwdVzGcaQF7+SOsHpL7ftp3FlbFCZlW7or80O3tjS30=;
        b=NkRXHNtNmgsn13/CWkEam5wGZXLBWGkQAqGJMW1l+S4wUPhp5rwR0+/r6W9uhu+XWf
         ICKIQ6VuE/1RhqWQzDeyqR7baCJfpc6Q0w6IS3jZ+xxod8m4/HPLWZdksKpY8PKZQyvw
         w91TvjWv9n7XREzDftdobAJwy02JqvMRosFYvN1zdyzfVllrv7wJmu2UVJiq2sINKrOH
         ajl5sgKIWMC+2WCivV/4P5nKLIIkviAYMSjrL37xBCXHpmol4ZYBKwvhAqll5XFuz5lc
         9z0fuNW8UEPAemrqdWPpYwu5tur4nBwlMMVh+wWNOeVLWc4q4Cohyb+R1uvWgIkiGrcL
         p8rw==
X-Forwarded-Encrypted: i=1; AJvYcCV99RaSrEF+5IZM+d6rWWVznYn5o0Qx79x2rwTKNpGkt7wZLFuxL+yfzlypX0vADHoZIOHT9P0BEiECVNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/RAnMOY2div4MSPNfM6/XY7crO3lJEdMFBBnACuOt462wW74Y
	8epFQAOShHyLWemrJN3xbkiO4/Z3XXxj8JqvAKBruM9ztXnlfMf76bNgRX/ztNtxwxEHcGFKFyK
	6
X-Google-Smtp-Source: AGHT+IFFf5uOVklZ3NWR8b1RT59iDDEKxLvxl1mNoMhioyb2CzYSMhqTdom4ES3ddDpjGH7DrlUq6g==
X-Received: by 2002:a05:6830:43a7:b0:718:196a:c749 with SMTP id 46e09a7af769-7184b44d2b3mr4807921a34.27.1729727705886;
        Wed, 23 Oct 2024 16:55:05 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:55:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:15 -0500
Subject: [PATCH 11/11] iio: dac: ad5770r: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-11-d0bd396b3f50@baylibre.com>
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
 drivers/iio/dac/ad5770r.c | 41 +++++------------------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index 7d7f5110d66a..25cf11d0471b 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -122,7 +122,6 @@ struct ad5770r_out_range {
  * struct ad5770r_state - driver instance specific data
  * @spi:		spi_device
  * @regmap:		regmap
- * @vref_reg:		fixed regulator for reference configuration
  * @gpio_reset:		gpio descriptor
  * @output_mode:	array contains channels output ranges
  * @vref:		reference value
@@ -134,7 +133,6 @@ struct ad5770r_out_range {
 struct ad5770r_state {
 	struct spi_device		*spi;
 	struct regmap			*regmap;
-	struct regulator		*vref_reg;
 	struct gpio_desc		*gpio_reset;
 	struct ad5770r_out_range	output_mode[AD5770R_MAX_CHANNELS];
 	int				vref;
@@ -591,13 +589,6 @@ static int ad5770r_init(struct ad5770r_state *st)
 	return ret;
 }
 
-static void ad5770r_disable_regulator(void *data)
-{
-	struct ad5770r_state *st = data;
-
-	regulator_disable(st->vref_reg);
-}
-
 static int ad5770r_probe(struct spi_device *spi)
 {
 	struct ad5770r_state *st;
@@ -622,34 +613,12 @@ static int ad5770r_probe(struct spi_device *spi)
 	}
 	st->regmap = regmap;
 
-	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->vref_reg)) {
-		ret = regulator_enable(st->vref_reg);
-		if (ret) {
-			dev_err(&spi->dev,
-				"Failed to enable vref regulators: %d\n", ret);
-			return ret;
-		}
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret, "Failed to get vref voltage\n");
 
-		ret = devm_add_action_or_reset(&spi->dev,
-					       ad5770r_disable_regulator,
-					       st);
-		if (ret < 0)
-			return ret;
-
-		ret = regulator_get_voltage(st->vref_reg);
-		if (ret < 0)
-			return ret;
-
-		st->vref = ret / 1000;
-	} else {
-		if (PTR_ERR(st->vref_reg) == -ENODEV) {
-			st->vref = AD5770R_LOW_VREF_mV;
-			st->internal_ref = true;
-		} else {
-			return PTR_ERR(st->vref_reg);
-		}
-	}
+	st->internal_ref = ret == -ENODEV;
+	st->vref = st->internal_ref ? AD5770R_LOW_VREF_mV : ret / 1000;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5770r_info;

-- 
2.43.0


