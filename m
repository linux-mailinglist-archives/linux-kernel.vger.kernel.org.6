Return-Path: <linux-kernel+bounces-376310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257BA9AA306
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E79B22C82
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B0F1A0704;
	Tue, 22 Oct 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WhY83h7F"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FF19E97A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603368; cv=none; b=Atk6MqTbVg8Kj2fbS+tGuMzijgWD0V519hsHeYT33vmx6TSfKyTBbmQwzqtuRkKCl7f3cKz0SFNKCEcJI9X8EeiXdyryV0g70rhig0xlPyqTSn2pkChQqtIlEOkW8CX/gh+VzmukWyrZ+bsLGygG8ArBLsc0YEZpy7oMF/fp8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603368; c=relaxed/simple;
	bh=/q7bY3LdozfZxpkgjWCBfzgBSVHbQ62bY4N3y+cj/fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/MXX/o8gssRJMf/Ly/E0eEpuhMwRdToBLMb5r4xGa9lNOXLp9YOxcNQlbqTB52c8v0Uvq2XN6nkxyTeZrn4wwLGMsrCz8ok6+LC7DIbdqvjk+9B/UQFjaX/ZWDtHXMRHT+7OG22+BvgVbaw+NmsHJHxCKYahrhkmY0RahZ715o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WhY83h7F; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f6e1f756so6592466e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729603363; x=1730208163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbmAaG8fixSpFKc9j1duqIsE3U5n248SVuREqUqWo5U=;
        b=WhY83h7Fv3CXdbM8PeB7gnUCvWwl2oo3SBKXoeoO6gXLZDNtuHwdENzWzYM5gF+w0M
         tivn1IQsaReXog33+lzZcmId86i1fYpPuFUXmGJT+GlUSbNwMzImUwhpa7HLNVOSBuPO
         FHCiJwqsthHJDCNvVA5uNi3x2QfLYx3JZnVqgH0I+6SLcQOqgeFKPazdo/xyi4dNhakV
         AUEGfTU8+bpUgNZJeAh8Yn0L36JJdGLxYb8fofkpk0fqP40K0kMOdhkpFE/dL7FKE+UO
         exPP45UFHIlyX2/ZZDwuCq74WAtdAUtF65Dlnq4rKxAEeLQK1ydraeVcL0u6ih7fts98
         PpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603363; x=1730208163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbmAaG8fixSpFKc9j1duqIsE3U5n248SVuREqUqWo5U=;
        b=m7iI2YqBrUZ2RoewAibzPJKd1t3e19HH5r6woxKBIXIZYWBQRnGo02cmt2p51gSSj9
         LullYgwuuXkkihzYfmBPPV8tEHQqcLtKmvBxMpAwU3K3WAqb7TWk3Vm2Zfd3PlGQzbhr
         uoMBEe79tg5rzFG6lzwOmXEpebo2V7m/wAy1chnwM6fNzq5wa8BwAvIefVG3ArhkuoTm
         DUEeN7QGf1rMZ8A07gmTWnfoSVzX0lSxLk7R2oVK5S5cIIsDEY445z+JU2LgeWrnygSF
         IgHNG694aGKMrVjlUicwj1kY1b0B2pEWBbBgZNJwFZzm8DSRPdjyirpYx8X4une88VUd
         Vdng==
X-Forwarded-Encrypted: i=1; AJvYcCXaVGQ1/Vna8qHnBuUSPQKET7IV+DEqGYUCB5G8kOjBeQ9T+brsQgGtiRJSH/argxyJeGGLeJRrNBFUius=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7pxxlfE+4pJn0d+i7IQ/uVWfT9KfExE65z8meAvDJxOlpNLL
	Pvwu//oHEFZpBrSsuL2xgRtrX123u0GREzmE1SJstgBwrrrbxr109JDqVAGAWJo=
X-Google-Smtp-Source: AGHT+IGgkuhfpmA9z1fSQbEsxGS/o3vgnR3trA4uG/lWbdbD/vyEj4Nr9FTqBvvAcdSzM9K1NeC7hQ==
X-Received: by 2002:a05:6512:3d20:b0:539:e761:c21a with SMTP id 2adb3069b0e04-53a1544629amr8444414e87.48.1729603362902;
        Tue, 22 Oct 2024 06:22:42 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c737c4sm3109496a12.96.2024.10.22.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 06:22:42 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 22 Oct 2024 15:22:37 +0200
Subject: [PATCH v3 2/5] iio: adc: ad7380: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-ad7380-fix-supplies-v3-2-f0cefe1b7fa6@baylibre.com>
References: <20241022-ad7380-fix-supplies-v3-0-f0cefe1b7fa6@baylibre.com>
In-Reply-To: <20241022-ad7380-fix-supplies-v3-0-f0cefe1b7fa6@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Use devm_regulator_get_enable_read_voltage() to simplify the code.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 81 +++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e8bddfb0d07dbcf3e2a43344a4e0516f4d617548..e033c734191143a25a490b09c730dbf95f796737 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -956,7 +956,7 @@ static const struct iio_info ad7380_info = {
 	.debugfs_reg_access = &ad7380_debugfs_reg_access,
 };
 
-static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
+static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 {
 	int ret;
 
@@ -968,13 +968,13 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 	if (ret < 0)
 		return ret;
 
-	/* select internal or external reference voltage */
-	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
-				 AD7380_CONFIG1_REFSEL,
-				 FIELD_PREP(AD7380_CONFIG1_REFSEL,
-					    vref ? 1 : 0));
-	if (ret < 0)
-		return ret;
+	if (external_ref_en) {
+		/* select external reference voltage */
+		ret = regmap_set_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
+				      AD7380_CONFIG1_REFSEL);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* This is the default value after reset. */
 	st->oversampling_ratio = 1;
@@ -987,16 +987,11 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 				  FIELD_PREP(AD7380_CONFIG2_SDO, 1));
 }
 
-static void ad7380_regulator_disable(void *p)
-{
-	regulator_disable(p);
-}
-
 static int ad7380_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad7380_state *st;
-	struct regulator *vref;
+	bool external_ref_en;
 	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -1009,37 +1004,17 @@ static int ad7380_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return dev_err_probe(&spi->dev, -EINVAL, "missing match data\n");
 
-	vref = devm_regulator_get_optional(&spi->dev, "refio");
-	if (IS_ERR(vref)) {
-		if (PTR_ERR(vref) != -ENODEV)
-			return dev_err_probe(&spi->dev, PTR_ERR(vref),
-					     "Failed to get refio regulator\n");
-
-		vref = NULL;
-	}
-
 	/*
 	 * If there is no REFIO supply, then it means that we are using
 	 * the internal 2.5V reference, otherwise REFIO is reference voltage.
 	 */
-	if (vref) {
-		ret = regulator_enable(vref);
-		if (ret)
-			return ret;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refio");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to get refio regulator\n");
 
-		ret = devm_add_action_or_reset(&spi->dev,
-					       ad7380_regulator_disable, vref);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(vref);
-		if (ret < 0)
-			return ret;
-
-		st->vref_mv = ret / 1000;
-	} else {
-		st->vref_mv = AD7380_INTERNAL_REF_MV;
-	}
+	external_ref_en = ret != -ENODEV;
+	st->vref_mv = external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
 
 	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
 		return dev_err_probe(&spi->dev, -EINVAL,
@@ -1050,27 +1025,13 @@ static int ad7380_probe(struct spi_device *spi)
 	 * input pin.
 	 */
 	for (i = 0; i < st->chip_info->num_vcm_supplies; i++) {
-		struct regulator *vcm;
-
-		vcm = devm_regulator_get(&spi->dev,
-					 st->chip_info->vcm_supplies[i]);
-		if (IS_ERR(vcm))
-			return dev_err_probe(&spi->dev, PTR_ERR(vcm),
-					     "Failed to get %s regulator\n",
-					     st->chip_info->vcm_supplies[i]);
+		const char *vcm = st->chip_info->vcm_supplies[i];
 
-		ret = regulator_enable(vcm);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev,
-					       ad7380_regulator_disable, vcm);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(vcm);
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, vcm);
 		if (ret < 0)
-			return ret;
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get %s regulator\n",
+					     vcm);
 
 		st->vcm_mv[i] = ret / 1000;
 	}
@@ -1135,7 +1096,7 @@ static int ad7380_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad7380_init(st, vref);
+	ret = ad7380_init(st, external_ref_en);
 	if (ret)
 		return ret;
 

-- 
2.47.0


