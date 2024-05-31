Return-Path: <linux-kernel+bounces-197501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373608D6B79
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563A41C225C5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE083BB48;
	Fri, 31 May 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tSRAnerk"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4180032
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190390; cv=none; b=PLyYGcZKumy/7Ew2Pu99Tc4OSo2mLGKfhfQDlpCYDfMYjIeYEGK6jF51LOLsTNMf8PYrbCS2OfprCuANmxzF1c1NOiUaheal5VetCPHvqR8kM6xMFDv0JA3na93aHqIwlQWrysH2hHT5GSisseRfvcDHBm9ZcAeauPeDEl8er1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190390; c=relaxed/simple;
	bh=djS+IstEEdXks4E5EEDzjApEn0V5RdWip5LOqYcuvWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNNad2nDp2aE61Bqqn9dRC6qVkKEYoLaVMGNT762WiAEm0clGGnMVCdSvut4lMgfd7UUJ4FqP8SuQn6pbZIRoSagujx3GDTV21YKkR9fWu8aQ0GN7An2Iah3GVTI93VuyuXq+tGTz9pdmZs0plINq3XJkn2zKGLRVam8QNmpOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tSRAnerk; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f855b2499cso1554678a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717190387; x=1717795187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbruLAt03fLjpCxeoEnwGhqppmXvGlKTLyJ4VcLSIfs=;
        b=tSRAnerk5KRJEGjFE5vM/YlwMV836v+xL2j3odbVfO+oWstKhUHtnx0u1G/ZP7Zx7g
         rSA4oVy9z7Kp/mYpeJfDhBIiga2sYY7V79kZ9QSIWiHTYuABQIDKlEuLq8pd6uY3ZgXb
         s3Wjnuyt6Df6tvSX4vSmDHK9jLjC22p4Dji0zYTPJJziwfcOpiWx9B4OA9SLQchiz+NY
         0qkjCqqpbUPDWGuiRggXxZs+lig9hKmvzxRVEjBOsxgAooLS/NBjRjpJrNMm6eeONmnJ
         maWYQvHWPj9BoC40kgtlsFrL2qq7399K1WrihnZXqZx6MQaDdstqA7bXkQ11tVHBemNc
         uM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190387; x=1717795187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbruLAt03fLjpCxeoEnwGhqppmXvGlKTLyJ4VcLSIfs=;
        b=p0kBu7B+WYk76vADiWY0r7W0eMi/cj7bCz1PTYb7Nww4v79smq5F1wFtVEh+KTggDS
         vixnZN1VYYIFkmFHGHKw4DvoZjPvk6gscVWouVRFKMsc34YxsMsmKOKEGi+hAGwHf3pr
         DWSdpFk+3N91rgFTrmMhLjrjMAbnnmR8iqjFQYq1AAV4T/axbDjBHuw+OHzmCNnGfwh5
         Ps0utRUFcjbwb1hlD5J0nqSSUnnwtmWmRjLN6Si6vqOWF+qPp56UFvCRyGJeJdD9CFXV
         KlMXh+xoTXyvHOUdzjWw+kJ/AEvKlEVLGJa4ZMUllYA3mIwx2Sef3Ndk9FiAFtCiJAhy
         pGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU56yul3N+Y+Y5YQmbujMJFvJjrItIxu1UsLgNhmmEQrBPGc6jqz01aKN1QTaBce0mx2XHkkw8lNxcHEzdFxDhl5bgjKBhowqVyYPmC
X-Gm-Message-State: AOJu0YyUTZaqxl8dmb8Kfx23sxB5+9JvdnriW6NcaQhAG7cM6T8lFYW1
	mKbovAbsAa+g19DMpKjGEf/AE3E5R7kFozzdWDwb0hRpAtPEBf+taB2ACqCO+Fc=
X-Google-Smtp-Source: AGHT+IFkz+cdXrbneX907Jl5UcLu0PioPNnv+0/npiT6mmWiF18kZTPeeLG91XQTRcQYGozZr/qoBw==
X-Received: by 2002:a05:6830:1e52:b0:6f0:6864:eee6 with SMTP id 46e09a7af769-6f911f2fea3mr3079003a34.10.1717190387135;
        Fri, 31 May 2024 14:19:47 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054f6c5sm470176a34.38.2024.05.31.14.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:19:46 -0700 (PDT)
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
Subject: [PATCH 4/5] iio: adc: ad7793: use devm_regulator_get_enable_read_voltage
Date: Fri, 31 May 2024 16:19:35 -0500
Message-ID: <20240531-iio-adc-ref-supply-refactor-v1-4-4b313c0615ad@baylibre.com>
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
 drivers/iio/adc/ad7793.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 5f8cb9aaac70..d4ad7e0b515a 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -152,7 +152,6 @@ struct ad7793_chip_info {
 
 struct ad7793_state {
 	const struct ad7793_chip_info	*chip_info;
-	struct regulator		*reg;
 	u16				int_vref_mv;
 	u16				mode;
 	u16				conf;
@@ -769,11 +768,6 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 	},
 };
 
-static void ad7793_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad7793_probe(struct spi_device *spi)
 {
 	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
@@ -800,23 +794,11 @@ static int ad7793_probe(struct spi_device *spi)
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
 
 	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
-		st->reg = devm_regulator_get(&spi->dev, "refin");
-		if (IS_ERR(st->reg))
-			return PTR_ERR(st->reg);
-
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev, ad7793_reg_disable, st->reg);
-		if (ret)
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refin");
+		if (ret < 0)
 			return ret;
 
-		vref_mv = regulator_get_voltage(st->reg);
-		if (vref_mv < 0)
-			return vref_mv;
-
-		vref_mv /= 1000;
+		vref_mv = ret / 1000;
 	} else {
 		vref_mv = 1170; /* Build-in ref */
 	}

-- 
2.45.1


