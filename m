Return-Path: <linux-kernel+bounces-243151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE235929289
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C5AB20FC6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD3773467;
	Sat,  6 Jul 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COtl24ib"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7D7172F;
	Sat,  6 Jul 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720261462; cv=none; b=qnUT8CkwI+xnGZ2R1KT+/ab3aaHJ26gfL2xXAorfSm+gscS3sFMTrGnqYvCP+dnCHu/7c0F4KppCddZaUFXxQ7IYBMuW30N476utEPEcGi3DNoTbUgKJzLISIW1bQYkgDlk77qZHlFus4o0jlGZH9i/bnziAwyDIdfyceQaCErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720261462; c=relaxed/simple;
	bh=xNcPhhbRnzZiWFwFDA+zeSRCL1Crs0ptxekpV/3+PVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsZ1elW8C00pObL4LYA3tSO3X6ZLd7jUL1X64R/lQesW1ZRBsgTm+fYO/erHXSF79vBrZEBPB8p9Ky+lcqeKKziFMW/yyc6vPiJkcxMK2FcabuSYcX6gi/WYKWKNPADSDkSO8QVp3E6HzAPjjHnkcAXz7KWMFahAv9QytwTRSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COtl24ib; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-75e7e110e89so1401567a12.3;
        Sat, 06 Jul 2024 03:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720261461; x=1720866261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCLSW0HbBwbaS3nL0I53zWuMSMpYt360azX1zUWdd0k=;
        b=COtl24ibAgbJEl9kkKifdjbU9XcO/IkxlFrwev031oF5yBbUCCYzy57fa6zl1gi2m0
         cfVN9IVrvGFWUhhFlq/ljYC5IiZjXfe3cPW49yULf4AwkqLFelSClDFn3Ge9se72qPBg
         RQTt1940PlqDkhjpFEFmFlCWbE2vUCOyXx/yIureHfZqU/s2stxqg5tQ4WXXLridgpHi
         fLW1eLG+oDAOFd3ncoZVcCMNrIQSc0SU6CIzRZG3AcIr3LFI6/BQBp7yEq/Syc6Bhxyz
         GYDk0CEeWuuxNs13iowEh52iJ/09HodXg6hM8FumWvQOkJCtjuGpJ6CX7ntUwV4ATvj3
         1lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720261461; x=1720866261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCLSW0HbBwbaS3nL0I53zWuMSMpYt360azX1zUWdd0k=;
        b=OAqjlvI397feO5qhRWAvgEog6DP0JfCAHfAOxgY2JM+YQ9CamEuyyxq0ieS2ClaDG8
         /oKglIeVJs/hs+Y05JJKykF1+39A3armLS2nuXI/xBguFD8JuPRStJTR3Htqfaw67AWF
         eaVcpvnYVF6XvtF00tIYFxVjoK67nZVxu+UmYMbKw82u4jyKe9SC4/S5V7NhnZHk09wN
         6yhMwKKaIwBj0+SfMlMsKDLI03XyJZXIGc4+coO8EmYZiv8JMsz0JBofMw9YeZ7Hm/11
         SXYjqdpxYssIZmd/UaWhqu8XL2kv7jklhAgJmiTLHxoORuLERKsbcBeu7fE+pELDs12S
         R5Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXpi9rx/HkbnpVgrD1T/y59E3CTRed+Xyfr9laGGZz+5us2j6y2Z5XBNhDgtuJrHmM7CrwPl6rfCurcGUP97euwjzrbRn3KzJc6Ww==
X-Gm-Message-State: AOJu0Ywzm5ir+2EbWu15schSMpUrVhYKxnvOMubyPOZLPwpizIPfg+NU
	2LyCZ8tYnXX8wAhBmzXBYcQMm8M5CEZ5KQrVxnJshzwk8iQfP/fkA/yvhJqAKqQ=
X-Google-Smtp-Source: AGHT+IHPbJwaX0rSPG0rISm/Df/RDW03hjsjQ/2SDn1k/nrgezWcnqmdHbuXDXRDt+tCIxIVRS4ucg==
X-Received: by 2002:a05:6a21:6b0c:b0:1bd:29f2:c7df with SMTP id adf61e73a8af0-1c0cc8b3ac9mr6769970637.43.1720261460815;
        Sat, 06 Jul 2024 03:24:20 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb67e04f64sm9126625ad.214.2024.07.06.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 03:24:20 -0700 (PDT)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 2/5] drm/panel: st7701: Decouple DSI and DRM parts
Date: Sat,  6 Jul 2024 19:23:33 +0900
Message-ID: <20240706102338.99231-3-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240706102338.99231-1-kikuchan98@gmail.com>
References: <20240706102338.99231-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split into a DSI-specific part and a DRM-specific part.

Additionally, use devm_add_action_or_reset() to simplify the flow,
and disable and unprepare the panel on cleanup.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 72 ++++++++++++-------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index a9a8fd85057..a0644f7a4c8 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -539,7 +539,7 @@ static int st7701_get_modes(struct drm_panel *panel,
 
 	mode = drm_mode_duplicate(connector->dev, desc_mode);
 	if (!mode) {
-		dev_err(&st7701->dsi->dev, "failed to add mode %ux%u@%u\n",
+		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
 			desc_mode->hdisplay, desc_mode->vdisplay,
 			drm_mode_vrefresh(desc_mode));
 		return -ENOMEM;
@@ -974,42 +974,48 @@ static const struct st7701_panel_desc rg_arc_desc = {
 	.gip_sequence = rg_arc_gip_sequence,
 };
 
-static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
+static void st7701_cleanup(void *data)
+{
+	struct st7701 *st7701 = (struct st7701 *)data;
+
+	drm_panel_remove(&st7701->panel);
+	drm_panel_disable(&st7701->panel);
+	drm_panel_unprepare(&st7701->panel);
+}
+
+static int st7701_probe(struct device *dev, int connector_type)
 {
 	const struct st7701_panel_desc *desc;
 	struct st7701 *st7701;
 	int ret;
 
-	st7701 = devm_kzalloc(&dsi->dev, sizeof(*st7701), GFP_KERNEL);
+	st7701 = devm_kzalloc(dev, sizeof(*st7701), GFP_KERNEL);
 	if (!st7701)
 		return -ENOMEM;
 
-	desc = of_device_get_match_data(&dsi->dev);
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
-	dsi->format = desc->format;
-	dsi->lanes = desc->lanes;
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -ENODEV;
 
 	st7701->supplies[0].supply = "VCC";
 	st7701->supplies[1].supply = "IOVCC";
 
-	ret = devm_regulator_bulk_get(&dsi->dev, ARRAY_SIZE(st7701->supplies),
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st7701->supplies),
 				      st7701->supplies);
 	if (ret < 0)
 		return ret;
 
-	st7701->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	st7701->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(st7701->reset)) {
-		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
+		dev_err(dev, "Couldn't get our reset GPIO\n");
 		return PTR_ERR(st7701->reset);
 	}
 
-	ret = of_drm_get_panel_orientation(dsi->dev.of_node, &st7701->orientation);
+	ret = of_drm_get_panel_orientation(dev->of_node, &st7701->orientation);
 	if (ret < 0)
-		return dev_err_probe(&dsi->dev, ret, "Failed to get orientation\n");
+		return dev_err_probe(dev, ret, "Failed to get orientation\n");
 
-	drm_panel_init(&st7701->panel, &dsi->dev, &st7701_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
+	drm_panel_init(&st7701->panel, dev, &st7701_funcs, connector_type);
 
 	/**
 	 * Once sleep out has been issued, ST7701 IC required to wait 120ms
@@ -1028,27 +1034,39 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&st7701->panel);
 
-	mipi_dsi_set_drvdata(dsi, st7701);
-	st7701->dsi = dsi;
+	dev_set_drvdata(dev, st7701);
 	st7701->desc = desc;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret)
-		goto err_attach;
+	return devm_add_action_or_reset(dev, st7701_cleanup, st7701);
+}
+
+static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct st7701 *st7701;
+	int err;
+
+	err = st7701_probe(&dsi->dev, DRM_MODE_CONNECTOR_DSI);
+	if (err)
+		return err;
+
+	st7701 = dev_get_drvdata(&dsi->dev);
+	st7701->dsi = dsi;
+
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
+	dsi->format = st7701->desc->format;
+	dsi->lanes = st7701->desc->lanes;
+
+	err = mipi_dsi_attach(dsi);
+	if (err)
+		return dev_err_probe(&dsi->dev, err, "Failed to init MIPI DSI\n");
 
 	return 0;
-
-err_attach:
-	drm_panel_remove(&st7701->panel);
-	return ret;
 }
 
 static void st7701_dsi_remove(struct mipi_dsi_device *dsi)
 {
-	struct st7701 *st7701 = mipi_dsi_get_drvdata(dsi);
-
 	mipi_dsi_detach(dsi);
-	drm_panel_remove(&st7701->panel);
 }
 
 static const struct of_device_id st7701_of_match[] = {
-- 
2.45.2


