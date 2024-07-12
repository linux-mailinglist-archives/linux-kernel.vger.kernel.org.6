Return-Path: <linux-kernel+bounces-250884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD092FE1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95A51F2517F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77E3178370;
	Fri, 12 Jul 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LR+SA9hH"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38B176ABD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800251; cv=none; b=G8pWhGiG7beECZRrE5wGnGDgeDT3fylr+GFt9B++v8KBVM2+SW2rOaoyjI+Gy6XNxz5cXXHLuVzPbAuSn0mj48VcAwutkx2YQOsv/MjsasYpoH3kW/mk2oqBTW+lq80uqqJrCWQHf4isqzVfRNRWnMFe2CDyQgK5ysd9KoBVh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800251; c=relaxed/simple;
	bh=NF0ttJPPJHx2bQ6REVEW0ZebK541cG8BKuKiRadWNyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7ScXBr2uIGLuo8zZzdbBRzuLib/RTRKytFj9y580iqEh578yLWFj4AW4DWsIcrU8bPtLJAWMlsDWzsvZCJ/FnTqUX2VC2p7+r744qF5jD8Qvx0csZ5vni3xDX73hkIycZMK81JuH1X29OGSKFmJ1WNjbam5i9x3J/8Rhi9A4Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LR+SA9hH; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5c7b6c6a581so976285eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720800248; x=1721405048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TvJj9OS9pLYtOuscI8ghIcPdBvxWYcRECb9BgIFeXA=;
        b=LR+SA9hHdA7x/xxy9MhsYIXz5RKJ57gGHaBGlhMWcExbf5o2l4eId0ZowoQDVnA/zJ
         ZtWvAffuQIRCSrPB5zgea8oi9ywOO0HNq5Y7TsD4wlqYVneMafVQjAhav2kknAy2xbld
         2XgsrlFHNeUAgfByF2z5YoCkhyRGsE4fsH1pGMUkI+nRG5vlhXFYb/H6vI+eWMLyMSaP
         E15l4jmU9+lUgEik+GSmzDEed80R7DvUiNNFjv3E01DVLEsswIcudASc9OmZRWOoCheh
         bGhcdU/q0jXPwwG0rt8pk17XSgqZ9VvVLgRFUMoUMnykRnWh3X8SfJA7igKJf/6NGF5u
         7eAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800248; x=1721405048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TvJj9OS9pLYtOuscI8ghIcPdBvxWYcRECb9BgIFeXA=;
        b=QKmbvyPSDUtEmW9RrPS6ThnbXj7ZJhD1vmKau+6tBSoiswVTQWn6XivzDBdFONjYMb
         tQTdDBUJan+oXqUCmr+vZjm14g+oxCrKqq9lLAE0VXTyZq5dwgM7la0m4nsGsySxpJgE
         DRo/XhfE19+0cm2WmmzMXLv6UO0ffiJP9BxAcBHyFJGMQdXSVJYNWCenqX5hmju3j1Ed
         gQXZQKIq+RW1+1CgsyDP8EFX82rsIBawwIcWMdLRfK44IbtomtUkt/ZsFuFv/3lY+/M/
         4aWBXvlEMhx3zShzt8SUNtcJQEdzBCXyk+nNPT6H0C68bRlMTOYDr5CSC02D4Qy3qeBu
         +hCA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ87UJsl3V8VvTzTYo3/Gs0Oz7cjJZ9ppCkRAHzmX9UATgQOGfzTalU0Jrs5nUJxAyhkmwMSIMZ0Ov9zll8Lh98Qv3KWg33F1qdwE1
X-Gm-Message-State: AOJu0YyybEo451Jki4hrIU0ZgnN154DVa44uUqdPs06aD1O5Kho8x4R7
	GX8cHf10UNdxN+rRgfca8KezlQqyv/SkSDibAiIS+iSW0lhkfm+78q0437oNK9Q=
X-Google-Smtp-Source: AGHT+IGr7GtUz90d3Lh/5u99HidVD4eSXHr2INczAl7WDJoabqqvA5RKlDdYHdNqgwfxm7B6k4j9qg==
X-Received: by 2002:a05:6870:6387:b0:25e:4365:c5d6 with SMTP id 586e51a60fabf-25eae7b880emr9984254fac.20.1720800248273;
        Fri, 12 Jul 2024 09:04:08 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d35sm1615131a34.23.2024.07.12.09.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:04:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] iio: adc: mcp3911: use devm_regulator_get_enable_read_voltage()
Date: Fri, 12 Jul 2024 11:03:57 -0500
Message-ID: <20240712-iio-regulator-refactor-round-3-v1-6-835017bae43d@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
References: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
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
helper function to reduce boilerplate code in the MCP3911 ADC driver.

The error message is slightly changed since there are fewer error
return paths.

An extra parameter is added to the config callback to avoid adding
state that is not used outside of the probe() function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/mcp3911.c | 59 +++++++++++++----------------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 7a32e7a1be9d..5076028f541d 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -103,7 +103,7 @@ struct mcp3911_chip_info {
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 
-	int (*config)(struct mcp3911 *adc);
+	int (*config)(struct mcp3911 *adc, bool external_vref);
 	int (*get_osr)(struct mcp3911 *adc, u32 *val);
 	int (*set_osr)(struct mcp3911 *adc, u32 val);
 	int (*enable_offset)(struct mcp3911 *adc, bool enable);
@@ -115,7 +115,6 @@ struct mcp3911_chip_info {
 struct mcp3911 {
 	struct spi_device *spi;
 	struct mutex lock;
-	struct regulator *vref;
 	struct clk *clki;
 	u32 dev_addr;
 	struct iio_trigger *trig;
@@ -385,23 +384,11 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int mcp3911_calc_scale_table(struct mcp3911 *adc)
+static int mcp3911_calc_scale_table(u32 vref_mv)
 {
-	struct device *dev = &adc->spi->dev;
-	u32 ref = MCP3911_INT_VREF_MV;
 	u32 div;
-	int ret;
 	u64 tmp;
 
-	if (adc->vref) {
-		ret = regulator_get_voltage(adc->vref);
-		if (ret < 0) {
-			return dev_err_probe(dev, ret, "failed to get vref voltage\n");
-		}
-
-		ref = ret / 1000;
-	}
-
 	/*
 	 * For 24-bit Conversion
 	 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
@@ -412,7 +399,7 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 	 */
 	for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
 		div = 12582912 * BIT(i);
-		tmp = div_s64((s64)ref * 1000000000LL, div);
+		tmp = div_s64((s64)vref_mv * 1000000000LL, div);
 
 		mcp3911_scale_table[i][0] = 0;
 		mcp3911_scale_table[i][1] = tmp;
@@ -544,7 +531,7 @@ static const struct iio_info mcp3911_info = {
 	.write_raw_get_fmt = mcp3911_write_raw_get_fmt,
 };
 
-static int mcp3911_config(struct mcp3911 *adc)
+static int mcp3911_config(struct mcp3911 *adc, bool external_vref)
 {
 	struct device *dev = &adc->spi->dev;
 	u32 regval;
@@ -555,7 +542,7 @@ static int mcp3911_config(struct mcp3911 *adc)
 		return ret;
 
 	regval &= ~MCP3911_CONFIG_VREFEXT;
-	if (adc->vref) {
+	if (external_vref) {
 		dev_dbg(dev, "use external voltage reference\n");
 		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 1);
 	} else {
@@ -610,7 +597,7 @@ static int mcp3911_config(struct mcp3911 *adc)
 	return mcp3911_write(adc, MCP3911_REG_GAIN, regval, 1);
 }
 
-static int mcp3910_config(struct mcp3911 *adc)
+static int mcp3910_config(struct mcp3911 *adc, bool external_vref)
 {
 	struct device *dev = &adc->spi->dev;
 	u32 regval;
@@ -621,7 +608,7 @@ static int mcp3910_config(struct mcp3911 *adc)
 		return ret;
 
 	regval &= ~MCP3910_CONFIG1_VREFEXT;
-	if (adc->vref) {
+	if (external_vref) {
 		dev_dbg(dev, "use external voltage reference\n");
 		regval |= FIELD_PREP(MCP3910_CONFIG1_VREFEXT, 1);
 	} else {
@@ -677,11 +664,6 @@ static int mcp3910_config(struct mcp3911 *adc)
 	return adc->chip->enable_offset(adc, 0);
 }
 
-static void mcp3911_cleanup_regulator(void *vref)
-{
-	regulator_disable(vref);
-}
-
 static int mcp3911_set_trigger_state(struct iio_trigger *trig, bool enable)
 {
 	struct mcp3911 *adc = iio_trigger_get_drvdata(trig);
@@ -704,6 +686,8 @@ static int mcp3911_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct mcp3911 *adc;
+	bool external_vref;
+	u32 vref_mv;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
@@ -714,23 +698,12 @@ static int mcp3911_probe(struct spi_device *spi)
 	adc->spi = spi;
 	adc->chip = spi_get_device_match_data(spi);
 
-	adc->vref = devm_regulator_get_optional(dev, "vref");
-	if (IS_ERR(adc->vref)) {
-		if (PTR_ERR(adc->vref) == -ENODEV) {
-			adc->vref = NULL;
-		} else {
-			return dev_err_probe(dev, PTR_ERR(adc->vref), "failed to get regulator\n");
-		}
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get vref voltage\n");
 
-	} else {
-		ret = regulator_enable(adc->vref);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(dev, mcp3911_cleanup_regulator, adc->vref);
-		if (ret)
-			return ret;
-	}
+	external_vref = ret != -ENODEV;
+	vref_mv = external_vref ? ret / 1000 : MCP3911_INT_VREF_MV;
 
 	adc->clki = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(adc->clki)) {
@@ -755,11 +728,11 @@ static int mcp3911_probe(struct spi_device *spi)
 	}
 	dev_dbg(dev, "use device address %i\n", adc->dev_addr);
 
-	ret = adc->chip->config(adc);
+	ret = adc->chip->config(adc, external_vref);
 	if (ret)
 		return ret;
 
-	ret = mcp3911_calc_scale_table(adc);
+	ret = mcp3911_calc_scale_table(vref_mv);
 	if (ret)
 		return ret;
 

-- 
2.43.0


