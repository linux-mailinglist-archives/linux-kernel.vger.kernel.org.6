Return-Path: <linux-kernel+bounces-260338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C15093A785
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50574283D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A8113D8B2;
	Tue, 23 Jul 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QnE1S6JE"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E463613D633
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761198; cv=none; b=ENSf7riPt2SS2/ETa0b9CJ/pnyI74lvQ1FMvmV8/07mDk0PfeCrlEJ7mYqHdL1UYvCFNPjhkO+PjSZ/7sLIJigSO8zMs4gN9kA7miG8Xu5k4oqTyclnC+OwA7khhij7SKzDuoXhwzAMHW+RzB1OM8d1ITUrDvvnS4rMk7Kc2AOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761198; c=relaxed/simple;
	bh=iyS1ByyUx4twpm9hP+yKFrlEdFKQoGHxhjKyw1jAN64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Anj4CEA3UB8Fda23oc18T5tBApDSXgn+VJ9o85jvFR3rAUQ9lFqicbD8XmF1zcSKufBVV0bARjselDMFjIs4wcOm6KlGaUhk9U2z1cqEpmdmuSrVHiSlW/BuF36ghwvGPKqIPthvVKSwTE84lenAw0Tvuhh6y6fT58gzADjpaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QnE1S6JE; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3dae221e42dso2506844b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721761195; x=1722365995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=upz/OCbfVuYTOG+l6gDkvMC+JV0tNs7jmWYtWPGntn8=;
        b=QnE1S6JElsVkkeCIxCCYdMSh2fNyeYHYg4EXyl9EkBpLS7w4hVxPIS8OfMIBgBtATc
         m7PcZntSqmn168TWrobOoZNaXwKsykiRdyKdvwovM2io1T2eqei7RRDnssVIdYMLL0+z
         BhIqEgCnwfAUgxI//9/FkhMUJJS9i6ojYGFo3Ceik1C5tFIg2LpYV4kydXVOf9L+ZBZM
         Y23wOmuV/oVCcjYgdnYI21FRaoIzntuJwVMUgnGn4D6K8XyO55cz0I6cYgrvClZzrIB1
         7tOHsDu/JARZChCq0cxQNhOsHQEeLJ2dMUD3Acp8ph/GrWOyUtNGAnVlr9dnjdxoshLO
         OEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721761195; x=1722365995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upz/OCbfVuYTOG+l6gDkvMC+JV0tNs7jmWYtWPGntn8=;
        b=EG1dhfjgJ8CU5/b9yitIGanxAzQYu7IaA22NCKjbizTrJhQ39v2ixA86/QKYhqnvts
         sw3sOUQpRTzg0B+5qr2mA64xOldf+39xl95qzHCc33lExY5CHXIPVPD2SDGdkufYyuoR
         QkZIc7j7t10AetmUKaNFnBX/uVNTCjz6wv0+ZhnFyWQ2EKJ1WYpwQrSiPMjTwqZGWRzA
         KaUmE781Bt18N0RRWbIZq1sclUOTStJ/8XfY9zfz0OwlTSniTE7ti6S2KVAjHp6FhW3R
         t5jt9iiNgl7BAHMfu/8xsDwX0MjFGjyd4TmG/xeHDfXp6TG7gb3ZRbsnr5G1fBO06rIe
         reLg==
X-Forwarded-Encrypted: i=1; AJvYcCWbkQjIEhb5l13pSRcKdtE/a9aZwViZi62JphZLF76RBCV0NwT2qecMJYswbi9RwTEPaW22D3RiLZdJF/wK1BxoE+8huzdkLChKpfNL
X-Gm-Message-State: AOJu0YzL5KoWWsYDTeXDJlK3BfGgddu3haYtkHqC7QpSCOfPgLkNOeJI
	mpuGxAyd/U7yAaL4tSULdptlk+6cBin3qKLwsugRS+aZHtxDzdEAO4n+1tT8Ki0=
X-Google-Smtp-Source: AGHT+IHWmxzHoa8Zq3eq10vb/pe8QbH2QvQC7hdWVRqF2Zdoo7oipF+bXn58Y1qBgh1MqL2hHJnofw==
X-Received: by 2002:a05:6808:308f:b0:3d6:53fc:e813 with SMTP id 5614622812f47-3db06d99e36mr993749b6e.27.1721761195030;
        Tue, 23 Jul 2024 11:59:55 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae0981450sm2100211b6e.24.2024.07.23.11.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:59:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: mcp3564: use devm_regulator_get_enable_read_voltage()
Date: Tue, 23 Jul 2024 13:59:50 -0500
Message-ID: <20240723-iio-regulator-refactor-round-3-v2-1-ae9291201785@baylibre.com>
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

This makes use of the new devm_regulator_get_enable_read_voltage()
helper function to reduce boilerplate code in the MCP3564 ADC driver.

The error message is slightly changed since there are fewer error
return paths.

Setting adc->vref_mv is consolidated into a single place to make the
logic easier to follow.

A use_internal_vref_attr local variable is added to make it more
obvious what the difference between the two iio info structures is.

The return value of the "Unknown Vref" dev_err_probe() is hard-coded to
-ENODEV instead of ret since it was getting a bit far from where ret
was set and logically that is the only value it could have.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Rename use_auto_zeroing_ref_attr to use_internal_vref_attr
* Link to v1: https://lore.kernel.org/r/20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com

(other patches from v1 were already applied, so not included in v2)

---
 drivers/iio/adc/mcp3564.c | 54 ++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index d83bed0e63d2..a68f1cd6883e 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -349,8 +349,6 @@ struct mcp3564_chip_info {
  * struct mcp3564_state - working data for a ADC device
  * @chip_info:		chip specific data
  * @spi:		SPI device structure
- * @vref:		the regulator device used as a voltage reference in case
- *			external voltage reference is used
  * @vref_mv:		voltage reference value in miliVolts
  * @lock:		synchronize access to driver's state members
  * @dev_addr:		hardware device address
@@ -369,7 +367,6 @@ struct mcp3564_chip_info {
 struct mcp3564_state {
 	const struct mcp3564_chip_info	*chip_info;
 	struct spi_device		*spi;
-	struct regulator		*vref;
 	unsigned short			vref_mv;
 	struct mutex			lock; /* Synchronize access to driver's state members */
 	u8				dev_addr;
@@ -1085,11 +1082,6 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static void mcp3564_disable_reg(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static void mcp3564_fill_scale_tbls(struct mcp3564_state *adc)
 {
 	unsigned int pow = adc->chip_info->resolution - 1;
@@ -1110,7 +1102,7 @@ static void mcp3564_fill_scale_tbls(struct mcp3564_state *adc)
 	}
 }
 
-static int mcp3564_config(struct iio_dev *indio_dev)
+static int mcp3564_config(struct iio_dev *indio_dev, bool *use_internal_vref_attr)
 {
 	struct mcp3564_state *adc = iio_priv(indio_dev);
 	struct device *dev = &adc->spi->dev;
@@ -1119,6 +1111,7 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 	enum mcp3564_ids ids;
 	int ret = 0;
 	unsigned int tmp = 0x01;
+	bool internal_vref;
 	bool err = false;
 
 	/*
@@ -1218,36 +1211,22 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 
 	dev_dbg(dev, "Found %s chip\n", adc->chip_info->name);
 
-	adc->vref = devm_regulator_get_optional(dev, "vref");
-	if (IS_ERR(adc->vref)) {
-		if (PTR_ERR(adc->vref) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(adc->vref),
-					     "failed to get regulator\n");
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get vref voltage\n");
+
+	internal_vref = ret == -ENODEV;
+	adc->vref_mv = internal_vref ? MCP3564R_INT_VREF_MV : ret / MILLI;
+	*use_internal_vref_attr = internal_vref;
 
+	if (internal_vref) {
 		/* Check if chip has internal vref */
 		if (!adc->have_vref)
-			return dev_err_probe(dev, PTR_ERR(adc->vref),
-					     "Unknown Vref\n");
-		adc->vref = NULL;
+			return dev_err_probe(dev, -ENODEV, "Unknown Vref\n");
+
 		dev_dbg(dev, "%s: Using internal Vref\n", __func__);
 	} else {
-		ret = regulator_enable(adc->vref);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(dev, mcp3564_disable_reg,
-					       adc->vref);
-		if (ret)
-			return ret;
-
 		dev_dbg(dev, "%s: Using External Vref\n", __func__);
-
-		ret = regulator_get_voltage(adc->vref);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Failed to read vref regulator\n");
-
-		adc->vref_mv = ret / MILLI;
 	}
 
 	ret = mcp3564_parse_fw_children(indio_dev);
@@ -1350,10 +1329,8 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 	tmp_reg |= FIELD_PREP(MCP3564_CONFIG0_CLK_SEL_MASK, MCP3564_CONFIG0_USE_INT_CLK);
 	tmp_reg |= MCP3456_CONFIG0_BIT6_DEFAULT;
 
-	if (!adc->vref) {
+	if (internal_vref)
 		tmp_reg |= FIELD_PREP(MCP3456_CONFIG0_VREF_MASK, 1);
-		adc->vref_mv = MCP3564R_INT_VREF_MV;
-	}
 
 	ret = mcp3564_write_8bits(adc, MCP3564_CONFIG0_REG, tmp_reg);
 
@@ -1412,6 +1389,7 @@ static int mcp3564_probe(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev;
 	struct mcp3564_state *adc;
+	bool use_internal_vref_attr;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
 	if (!indio_dev)
@@ -1428,7 +1406,7 @@ static int mcp3564_probe(struct spi_device *spi)
 	 * enable/disable certain channels
 	 * change the sampling rate to the requested value
 	 */
-	ret = mcp3564_config(indio_dev);
+	ret = mcp3564_config(indio_dev, &use_internal_vref_attr);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret,
 				     "Can't configure MCP356X device\n");
@@ -1440,7 +1418,7 @@ static int mcp3564_probe(struct spi_device *spi)
 	indio_dev->name = adc->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (!adc->vref)
+	if (use_internal_vref_attr)
 		indio_dev->info = &mcp3564r_info;
 	else
 		indio_dev->info = &mcp3564_info;

---
base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
change-id: 20240712-iio-regulator-refactor-round-3-17f2a82d2181

