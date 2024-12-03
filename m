Return-Path: <linux-kernel+bounces-429322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF09E1A81
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2246166619
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2C1E3DC9;
	Tue,  3 Dec 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HPpgfi2L"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582241E377C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224419; cv=none; b=sLxcHHmxY6iIOBZ6d7T/FlqtkjUfb9q9O01veHhJdsbbOxaJwvg2Sx5hsVTjhxfnXd2GnLhMZ+Y4XE0IMHoF3vcGzHnrBey+2vn5i+9Q6Nhy+0wv5BqHJdyAMLt6kQ1AVNMnaA60+raqZOXpyBkr0FALpXhaDZrfr3+oi9wAcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224419; c=relaxed/simple;
	bh=ff34cQFPgG3xPGj+0bvlWg/J2lBiYjm/GyMhI0szKWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F9urWULuxHlh3WXwxMXnQbx3r7osdWIfLYn52qf7FG2CVT+IpmCMgi8lb3ITX1oo9f0CZTeGSCeQjH0gGeta/ewnRKe0dMOpRUd83M8Vy7EQGisY0m+bLXYOB+MiqRLyLQenP1u/rj8XXXi2qQNwVvnw2/dCgkjSv5IlWqTZpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HPpgfi2L; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so1770828f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224415; x=1733829215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpsUCVbg51wgZ+ljmc9sIjByzc7EQ21C5U8Di0xfO6M=;
        b=HPpgfi2Lj4nvdW+jiF3V2WGOw6DDfambGucJKXzTI96kfvdvAostI/XZOLwDsqtY5o
         v5Q0DKLPBlL2q97tUAtBiOrwqrRutZOTLoUflBp3TiDSfJ9ru0AHKyHnqyUW8RG4+8Gm
         HwI7tUmWZPLudGh+sTf+P4bF8ogz6D8Wwvv/r82TY/tVVixi+F4GZWM/PtZtMa7n7zc7
         pwOjWHNaR8dWWB0CIlWXD4/7OxIuLN7rdywkhpJRbWCPKsjnnAJy+EU1GQOq48ooMB88
         4vuyKtq6qxZed6phqs9h5CU/UGYnkLOVlwsjt8GsH9JQd6r4vALFpE48K0vyWz1jdJug
         u9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224415; x=1733829215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpsUCVbg51wgZ+ljmc9sIjByzc7EQ21C5U8Di0xfO6M=;
        b=CsiSh1NbnT+cFfPwRgfGxI2AAaDjZhTC5BidmcP5I5HMK7RzUcknPQs1ElEaXxHkfA
         gS3uujUUgxpQDb7vfPK/Ao4ijj7fdnciIq6PLBEAYEniW0wDmN8PPYCd76FnJScqDHTf
         bSxAiQA6HX2JOVSoEXFvyUJK4z9/UG+rt9RoBQf8Yo4bNvlJUEFbinvTXOQbMuxzJfKD
         +VKjJGD3nLXDxP0LQ7/FrykfX45k7cWtvVpyhwQVCIIdrupEBQT+rdOK3N3B15bO/YQe
         Pjmkd1PJJPKMzxbyvA0uvxLJtSbhw7Ru1sE4QWstBgcRwK/esydXbpgHwF91TMBGQsSR
         41Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVb5P05Tt+HloM+XY/tJgZpfKNwz+0rooORhWICppsha7MWX0x5LwJF8ia74BDQNIcjJfddczuCThb3cvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNENVyU0HAjgO8ve6ung7Ibymk4jg5obniJgQ6JB2gK/kf8cr
	gmfU3SF+67p8Ght5EvDpzu4whwKjHA4KJSimtT1x3K61Smq1oc7ItU5BYDxHdj8=
X-Gm-Gg: ASbGncsbACEdcThUtPyEIpBlxTmVvkJq/xi3tfdAlVhYxgdvBAr5M44KdJTGQiuP17y
	suUZexm9Je9Ck6Ht1XDDPGwKg5PdgtehAU8KYagwIyrXgsibv5G/JDhK1iqt39QF8Qa3QEurLXJ
	iEF+0UdANkX7bOrK5CN5UqAz8EtgH5UQg8eYyX1Ez/JXvvb7YD1t2O19x1yjGhvBKdab5uk5ZDM
	HD/fVwmCKyvXrJW3FXHlCmFCI1fkbjgZDJd9tj7Gynp9lbQE3vzlNsVHXUU9V/OamJT0u6uTc5x
	Ri9K
X-Google-Smtp-Source: AGHT+IHMg3Nkv4CHCpsOjSMzRZr8TqzGyHtSpdM+SvKAVByMGT347C2accU1yqJXA260QixDrRIIVQ==
X-Received: by 2002:a05:6000:1ac7:b0:385:f44a:a64 with SMTP id ffacd0b85a97d-385fd3d0816mr1770078f8f.24.1733224415144;
        Tue, 03 Dec 2024 03:13:35 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:34 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 03/14] iio: adc: rzg2l_adc: Simplify the runtime PM code
Date: Tue,  3 Dec 2024 13:13:03 +0200
Message-Id: <20241203111314.2420473-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

All Renesas SoCs using the rzg2l_adc driver manage ADC clocks through PM
domains. Calling pm_runtime_{resume_and_get, put_sync}() implicitly sets
the state of the clocks. As a result, the code in the rzg2l_adc driver that
explicitly manages ADC clocks can be removed, leading to simpler and
cleaner implementation.

Additionally, replace the use of rzg2l_adc_set_power() with direct PM
runtime API calls to further simplify and clean up the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 100 ++++++++----------------------------
 1 file changed, 20 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 7039949a7554..a17690ecbdc3 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
@@ -69,8 +68,6 @@ struct rzg2l_adc_data {
 
 struct rzg2l_adc {
 	void __iomem *base;
-	struct clk *pclk;
-	struct clk *adclk;
 	struct reset_control *presetn;
 	struct reset_control *adrstn;
 	struct completion completion;
@@ -188,29 +185,18 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 	return 0;
 }
 
-static int rzg2l_adc_set_power(struct iio_dev *indio_dev, bool on)
-{
-	struct device *dev = indio_dev->dev.parent;
-
-	if (on)
-		return pm_runtime_resume_and_get(dev);
-
-	return pm_runtime_put_sync(dev);
-}
-
 static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc, u8 ch)
 {
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
-	ret = rzg2l_adc_set_power(indio_dev, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
 	ret = rzg2l_adc_conversion_setup(adc, ch);
-	if (ret) {
-		rzg2l_adc_set_power(indio_dev, false);
-		return ret;
-	}
+	if (ret)
+		goto rpm_put;
 
 	reinit_completion(&adc->completion);
 
@@ -219,12 +205,14 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
 	if (!wait_for_completion_timeout(&adc->completion, RZG2L_ADC_TIMEOUT)) {
 		rzg2l_adc_writel(adc, RZG2L_ADINT,
 				 rzg2l_adc_readl(adc, RZG2L_ADINT) & ~RZG2L_ADINT_INTEN_MASK);
-		rzg2l_adc_start_stop(adc, false);
-		rzg2l_adc_set_power(indio_dev, false);
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
 	}
 
-	return rzg2l_adc_set_power(indio_dev, false);
+	rzg2l_adc_start_stop(adc, false);
+
+rpm_put:
+	pm_runtime_put_sync(dev);
+	return ret;
 }
 
 static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
@@ -352,13 +340,13 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 	return 0;
 }
 
-static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
+static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 {
 	int timeout = 5;
 	u32 reg;
 	int ret;
 
-	ret = clk_prepare_enable(adc->pclk);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
@@ -396,25 +384,10 @@ static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
-	clk_disable_unprepare(adc->pclk);
-
+	pm_runtime_put_sync(dev);
 	return ret;
 }
 
-static void rzg2l_adc_pm_runtime_disable(void *data)
-{
-	struct device *dev = data;
-
-	pm_runtime_disable(dev->parent);
-}
-
-static void rzg2l_adc_pm_runtime_set_suspended(void *data)
-{
-	struct device *dev = data;
-
-	pm_runtime_set_suspended(dev->parent);
-}
-
 static int rzg2l_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -439,18 +412,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
 
-	adc->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(adc->pclk)) {
-		dev_err(dev, "Failed to get pclk");
-		return PTR_ERR(adc->pclk);
-	}
-
-	adc->adclk = devm_clk_get(dev, "adclk");
-	if (IS_ERR(adc->adclk)) {
-		dev_err(dev, "Failed to get adclk");
-		return PTR_ERR(adc->adclk);
-	}
-
 	adc->adrstn = devm_reset_control_get_exclusive_deasserted(dev, "adrst-n");
 	if (IS_ERR(adc->adrstn)) {
 		dev_err(dev, "failed to get adrstn\n");
@@ -463,7 +424,13 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(adc->presetn);
 	}
 
-	ret = rzg2l_adc_hw_init(adc);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize ADC HW, %d\n", ret);
 		return ret;
@@ -480,26 +447,12 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 
 	init_completion(&adc->completion);
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	indio_dev->name = DRIVER_NAME;
 	indio_dev->info = &rzg2l_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adc->data->channels;
 	indio_dev->num_channels = adc->data->num_channels;
 
-	pm_runtime_set_suspended(dev);
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_adc_pm_runtime_set_suspended, &indio_dev->dev);
-	if (ret)
-		return ret;
-
-	pm_runtime_enable(dev);
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_adc_pm_runtime_disable, &indio_dev->dev);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 
@@ -515,8 +468,6 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
 
 	rzg2l_adc_pwr(adc, false);
-	clk_disable_unprepare(adc->adclk);
-	clk_disable_unprepare(adc->pclk);
 
 	return 0;
 }
@@ -525,17 +476,6 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
-	int ret;
-
-	ret = clk_prepare_enable(adc->pclk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(adc->adclk);
-	if (ret) {
-		clk_disable_unprepare(adc->pclk);
-		return ret;
-	}
 
 	rzg2l_adc_pwr(adc, true);
 
-- 
2.39.2


