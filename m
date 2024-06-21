Return-Path: <linux-kernel+bounces-225398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFE8913029
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC9D1C239C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E84D17D374;
	Fri, 21 Jun 2024 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2VAm9Ea1"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4BB17C7D3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007929; cv=none; b=WcA+JhEgXniOZRVQ89CRoGHqeAdsVZCpNl4BJx/FOg7J0ejyaPqjm8NOYHACVJwCkredPdEbp3DKZ51uhFaZCTpKoAoKIu3PRjBjKMdKKSGBREqNbGJMWGivEPNAnNnPdEySL8gqskO7jL0cJmoClxUJXuw+5sUsumOPlZrWIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007929; c=relaxed/simple;
	bh=NuI4TGky1zgci5Akrsl+6+XqKEbrSq45EGYRP7kU4fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIzH2/A/qQ36ub/lM7/d5VYRaLRvYtK+RJ+p5PMQZgsPoUGMJqk/7/uGYHM5qsn6kpegtxwY/5BaBycKIDJYhjJ0bQXgkfTP9m3xCtXbLHsaCEHCAPojnx+2YatHadPBOczJDugk1DzQ4hCNX9x63g6uaA3ZOKMwDyDyYkJvS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2VAm9Ea1; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6fa11ac8695so1447753a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007927; x=1719612727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VHcpSCSl+z9MULQ1sxanESbfc3kKx/Z7jY5Xhv+4kU=;
        b=2VAm9Ea1l7hSFY7ODtzNk8ShTzKdkLXwupxxudbVyjkSkN6TbhDpi0kRa0IT/rZO99
         FD/pNqhMHnWIA+f+T5cIM/jtEqztJ2qBTrwJSMLSrt/bO21Cpuxco6FPDY93Pt3dQ2Tm
         DleK9ccnQlA3Z7OQ++M7NJux9wECOJOjMMkfQHj9cp65bfCRKMd3yLQmet86AIZcF+dx
         SpKqZAOkEtw6bwirS69SXFRhWLNjtGEaL8uRp9SsHBj8GJPkPtETekg+muE0Ox8+ocCA
         HWgcw5GOXz8cXmYWOcoJM/B9LzTNBrbt7N4IhMNsD1q9YNtGJtN86D9lrByC7UMjbf9M
         EVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007927; x=1719612727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VHcpSCSl+z9MULQ1sxanESbfc3kKx/Z7jY5Xhv+4kU=;
        b=WP30Dz1x30TxiqW6ldul1lor4hGtw/2P1ioi48ht5tAcHhFoACGsDU5wNFzia7PV37
         mbcMGaDV8pOQha6lWj8mIzff0bbpM1BLTmFNsW4RBiM9yiKT7sEU8S0PmwDF6riSPbXM
         9h70yf0eth4zA6KYNpHyhmmfat2VE9H+vqRtjeZJScdfne0CnfRhtUzcgHr8cFza+7MN
         5XGSyoAp7bv8UQDh40nhgtF17PiMUdL+DygtGWlTzYPxxmBhFileHcu8EX7gFVkMbuOf
         N/jsCKsT22o9LN+UlkY8PUVQhxSGIxkrFM6Pb5R1OwoKctiV/F8HQ2bLon9uVQHDY82G
         ij3A==
X-Forwarded-Encrypted: i=1; AJvYcCXPixKlEt4KwzkTa3sFaUw5AZC9pFdl/AIyO/MkN1fjw1s/6f6FK9VwXZk3J3BadGnhzAyqA2DKEPeSovZSLVqxlUOcOKkFdQ5Yhfk2
X-Gm-Message-State: AOJu0Yx8qY9xRPpK0sKzMw64+LCqbkWGKHrI65V/O7ZmqS67OD2JATz/
	uuX3BqcVBG7syYej6Ha/kJ7cqIGnYpnNnZBsEJMKSOXRLmmu/0p44hl6CVsd5+g=
X-Google-Smtp-Source: AGHT+IH97rOzv+89TB95LIhCbolye0EdHa9Rc661ctJrvuPP++dIiPj9NzWl+Xc/RagwgCrSd0GJLg==
X-Received: by 2002:a9d:7404:0:b0:6f9:7919:a33a with SMTP id 46e09a7af769-7007401b178mr10452707a34.19.1719007926913;
        Fri, 21 Jun 2024 15:12:06 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:12:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] iio: adc: ltc2309: use devm_regulator_get_enable_read_voltage()
Date: Fri, 21 Jun 2024 17:11:52 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-5-49e50cd0b99a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Use devm_regulator_get_enable_read_voltage() to simplify the code.
Error message is changed since there is only one error return now.
LTC2309_INTERNAL_REF_MV macro is added to make the internal reference
voltage value self-documenting.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ltc2309.c | 43 ++++++-------------------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 8b3a89c1b840..888a71454070 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/consumer.h>
 
 #define LTC2309_ADC_RESOLUTION	12
+#define LTC2309_INTERNAL_REF_MV 4096
 
 #define LTC2309_DIN_CH_MASK	GENMASK(7, 4)
 #define LTC2309_DIN_SDN		BIT(7)
@@ -29,14 +30,12 @@
  * struct ltc2309 - internal device data structure
  * @dev:	Device reference
  * @client:	I2C reference
- * @vref:	External reference source
  * @lock:	Lock to serialize data access
  * @vref_mv:	Internal voltage reference
  */
 struct ltc2309 {
 	struct device		*dev;
 	struct i2c_client	*client;
-	struct regulator	*vref;
 	struct mutex		lock; /* serialize data access */
 	int			vref_mv;
 };
@@ -157,11 +156,6 @@ static const struct iio_info ltc2309_info = {
 	.read_raw = ltc2309_read_raw,
 };
 
-static void ltc2309_regulator_disable(void *regulator)
-{
-	regulator_disable(regulator);
-}
-
 static int ltc2309_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
@@ -175,7 +169,6 @@ static int ltc2309_probe(struct i2c_client *client)
 	ltc2309 = iio_priv(indio_dev);
 	ltc2309->dev = &indio_dev->dev;
 	ltc2309->client = client;
-	ltc2309->vref_mv = 4096; /* Default to the internal ref */
 
 	indio_dev->name = "ltc2309";
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -183,36 +176,12 @@ static int ltc2309_probe(struct i2c_client *client)
 	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
 	indio_dev->info = &ltc2309_info;
 
-	ltc2309->vref = devm_regulator_get_optional(&client->dev, "vref");
-	if (IS_ERR(ltc2309->vref)) {
-		ret = PTR_ERR(ltc2309->vref);
-		if (ret == -ENODEV)
-			ltc2309->vref = NULL;
-		else
-			return ret;
-	}
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(ltc2309->dev, ret,
+				     "failed to get vref voltage\n");
 
-	if (ltc2309->vref) {
-		ret = regulator_enable(ltc2309->vref);
-		if (ret)
-			return dev_err_probe(ltc2309->dev, ret,
-					     "failed to enable vref\n");
-
-		ret = devm_add_action_or_reset(ltc2309->dev,
-					       ltc2309_regulator_disable,
-					       ltc2309->vref);
-		if (ret) {
-			return dev_err_probe(ltc2309->dev, ret,
-					     "failed to add regulator_disable action: %d\n",
-					     ret);
-		}
-
-		ret = regulator_get_voltage(ltc2309->vref);
-		if (ret < 0)
-			return ret;
-
-		ltc2309->vref_mv = ret / 1000;
-	}
+	ltc2309->vref_mv = ret == -ENODEV ? LTC2309_INTERNAL_REF_MV : ret / 1000;
 
 	mutex_init(&ltc2309->lock);
 

-- 
2.45.2


