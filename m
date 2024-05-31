Return-Path: <linux-kernel+bounces-197498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B318D6B74
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCDA282612
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600DA823AC;
	Fri, 31 May 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TagLpnQC"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0676413
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190387; cv=none; b=Rv9bXDgztHf77y56rG2FoAHIg9jqhby8rokLeWIJwgxVvQNF0Cjyc5kz7VEtzZNv+HOo8Ht2O8KwwQ7IRlTlcrOGflojITM/gPvPm9LZ5IJ7CdeRftw9fwiEN0Pf9RDrIw4pasjAvLPlR3/nAiQdLbONiGDFnh1CtgdbQCSAbk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190387; c=relaxed/simple;
	bh=Js0YVyBPm/E3WxsjG5z4McvboiBRBwpr7xybmk/0tP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDX6F2fUf/mknwPMB1T4qUN5qiTUjw/DTMB7DH2BxPtSLFVZMW2RXMaoDugMEAg7TB0bk3LPMiimAyqeM+tSbWxuvoDjI2CzH1vtJJkCCdbvFRb0xSmqmydSQUu3LswLF/tIPi3+MuXQ4div+NRDN93LI/4G6l7mEEHnmITOie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TagLpnQC; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f120ae1ca3so1361922a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717190385; x=1717795185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6K6MHKU/orn8S+VKImZw/DZY35U7Zc26RBfAXI+Msw=;
        b=TagLpnQCDNYhpxS3acth5vPJhgVXybe8PVEs3xxaFsMZEry4W5oOfAQ4lLWzlA5UgH
         4LP88Gj+SmwKcd8dA7TamR9BKdUvo/j72PEyq988UxC/ycnpa+aWdMC3QgMC96g0SMDf
         yZQiqddRzSwWS6bEtmVBPdULaF9ooJkRyir7UYqAxlnpzPfvvusleZM3kZtimTkrpxmz
         TPDMovmw0ZJJkzKOVcxvexKiyqII/iK1BcYfH0wsPUH/x+lwpRwg4EHrOHUgsOjq5lvU
         Op7MP7oyvf4v+U4VvtWAP3GVg2FkBQ22IcNSiB+uQPlOZo2lcDfUEp0YrKEVzP/fUU9I
         ZsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190385; x=1717795185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6K6MHKU/orn8S+VKImZw/DZY35U7Zc26RBfAXI+Msw=;
        b=MKyEMpHjmjiJe2GZRmknx2DnFoR0RGSqYtKGM0V+N6PLTTW1f54kN7nWybKY/IpZvA
         ejTorFoji6ypmUpS93n2tdGYmyVKqNOucfcGcOW7Rz3WwtkinFFGmfdyOggS5jzmLj88
         qv7+/5ue6K8gsbrMz/8EW1CP9XjaUOMIuQQNfb2RHXwlJESJTwaX+fZgOkBJAlUCLu2o
         CWlGupNg5inlTKn+RDwMiiy9CgOW/c0jfI15HDxHlsEvftPsoXvpO/49oSafswbsQhwH
         UXV2sp/BwVQMSgM/FvsaC7IV8bfL+07kBrBEbRqpW5yFhOwyBgNkkknQWeHxulX3AXrT
         sIuA==
X-Forwarded-Encrypted: i=1; AJvYcCVLDBV5s8+ljNnnjFAbEgg+tQY4PR3pHz6rQ2xO84fDZ4td5miwKC8BdL2OpC5a+4yr9ZX2zIvpkiIpmEPTgdftAsYFp37uyYokYCxT
X-Gm-Message-State: AOJu0Yzrckr0ROc8h060jBMe2jZqn9HTw5v2yOtdXcYH2KsDjdjFHb4v
	JZy1/CZed3ZaW7fZjGknjTgYfHvuXQxF4JEl0f5k7Qc3ojR85LbLvX3hgEGMfN0=
X-Google-Smtp-Source: AGHT+IE0Vyt+zzbJTkqMnIXs9WS274qnPNRombwHnz/DhsObFIFbFv8rZmMnOeEGBJQY3G9nmBrm3Q==
X-Received: by 2002:a9d:6206:0:b0:6f0:e4b1:587a with SMTP id 46e09a7af769-6f911f23d9bmr3449349a34.8.1717190385136;
        Fri, 31 May 2024 14:19:45 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054f6c5sm470176a34.38.2024.05.31.14.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:19:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iio: adc: ad7266: use devm_regulator_get_enable_read_voltage
Date: Fri, 31 May 2024 16:19:33 -0500
Message-ID: <20240531-iio-adc-ref-supply-refactor-v1-2-4b313c0615ad@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7266.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 353a97f9c086..026db1bedc0a 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -25,7 +25,6 @@
 
 struct ad7266_state {
 	struct spi_device	*spi;
-	struct regulator	*reg;
 	unsigned long		vref_mv;
 
 	struct spi_transfer	single_xfer[3];
@@ -377,11 +376,6 @@ static const char * const ad7266_gpio_labels[] = {
 	"ad0", "ad1", "ad2",
 };
 
-static void ad7266_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad7266_probe(struct spi_device *spi)
 {
 	struct ad7266_platform_data *pdata = spi->dev.platform_data;
@@ -396,28 +390,17 @@ static int ad7266_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev, ad7266_reg_disable, st->reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0)
-			return ret;
-
-		st->vref_mv = ret / 1000;
-	} else {
-		/* Any other error indicates that the regulator does exist */
-		if (PTR_ERR(st->reg) != -ENODEV)
-			return PTR_ERR(st->reg);
-		/* Use internal reference */
+	/*
+	 * Use external reference from vref if present, otherwise use 2.5V
+	 * internal reference.
+	 */
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret == -ENODEV)
 		st->vref_mv = 2500;
-	}
+	else if (ret < 0)
+		return ret;
+	else
+		st->vref_mv = ret / 1000;
 
 	if (pdata) {
 		st->fixed_addr = pdata->fixed_addr;

-- 
2.45.1


