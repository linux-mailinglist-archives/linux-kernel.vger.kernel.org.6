Return-Path: <linux-kernel+bounces-273699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6623946CA0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 08:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3031C20AB4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 06:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115E315E81;
	Sun,  4 Aug 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRDTNl8g"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05812B72;
	Sun,  4 Aug 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722752170; cv=none; b=Uyx6K1PklxrDWQS9CppvcgGLUBfN+Ctj6q8SXC6zC68u/LTDaKIPvyzmYTFrOaxEmCJo0CgBBX69wRZPdXhR1htgKT+BZCb8zU3hPQG+uUWrLjRLzlZGl8pz7/iuERYdH3UIrRVo1OdnSP5GN3xtUxzjB+fuehwnKjcr2JrAPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722752170; c=relaxed/simple;
	bh=cGU/hLohP2jwLFnKHyuRm6DaFnX3MmjOh1Ousc2m1XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0gKYgnYHmL/Q4YtlczN66V5CyGA+eS66dwUTF6EMVuHsJ4XXFv1rwfUIG2sVVa4bmbsW1eBV2UAzeEr43DOIBLnbp9FW05zqRuOveXUbU6GeM1aKo3K4o1MXrxXGQEOYb3UMgiz207IHidZmzDjQn6NgObyV5IJ9CBPWWKEXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRDTNl8g; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd70ba6a15so71968355ad.0;
        Sat, 03 Aug 2024 23:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722752168; x=1723356968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QCBHipd9ju2B6kDRIPqyXO7nCYrctm5/4ZaKFrTgHo=;
        b=gRDTNl8gOYZFSwaslDbJ76cOmLfyyzYjpz0tYPMKvCVcqaJ5iwbbIbZ6dnMKC5/Lmm
         WEgvNdU3/dy//brKS2Rz5uEWr6H1oplyuDA6q2G/bWKA03J2CIKhSygMI/jeNXX3ihgy
         DuxFoOcrzNQrXLQgu69oYjFndeEcpM9TL27gw803mRq0ZyfOF8Jala2VrltILb1TDk/J
         k5T0f6nYc6gp2AqmkJ7ZVThsyTrffmLh84tepIygwiRzKlCGiMuSf8qhLM0VpOSkhhrL
         WY15VvhDZn50gS2U8ilTh62eOBiXYG3pTHBh0JuU3MB7FeAqwq1gd0v7bvxGhppE90sU
         Uohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722752168; x=1723356968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QCBHipd9ju2B6kDRIPqyXO7nCYrctm5/4ZaKFrTgHo=;
        b=CGN14e+xFdZ0T4BD9ryum0cLn4twVUb9OUPb4FmqLjJfOErq6ytM+dKGCgMRw3WA1R
         lRnWIl4+/g+h9c9Z1Imfz+IfK6Tc3rgd6pO/LcQ0N/GVx9V122vOOljKWSyvD9gibuXf
         BHgWjoXa0fsozqpeATG2HXSm1X+QeX5/g90AVNvY6VDLr5I2SExBPRkK7LafSBNHkf5s
         pFtVEZzgq8yaqBj057ijyqNCvpVYFyZrwxM2/RkhYcYOuAlZpBy2CnwtFvDanuk0MNUv
         95p/QV78tcWHR7ZDJeXGFcbcrliCQcBh+eZJsW5bHCAjXXGnCLasTZXztWMBr86nXA2x
         bPzw==
X-Forwarded-Encrypted: i=1; AJvYcCWF73K9DUW8IufyC6HqTt/+h2rQ+DBw2VrSEkEbqqCPBbtWZgvPLN6lIHd++JhI6UoZthKgi3VAR3CfOnsKAvgm1r1IGreL7NLwkw==
X-Gm-Message-State: AOJu0YwmYSFLm66EApHacHYAgaBBrpHaK5FjJU9JNou7Bw59jyM/4Nr2
	c/WjD4o2o1zLzCfRY/TJmtK3VrpTN6DLqyvYGEAOkXqrLkxFO6XsktSsETby
X-Google-Smtp-Source: AGHT+IF2nVOyQC7h9YelKyVOaAywKnE46vjSEtLS5cAVyCk6ig+Yg/Q6vLleff/wH5lSdJpCHHoUng==
X-Received: by 2002:a17:902:f54b:b0:1fb:74b3:53d5 with SMTP id d9443c01a7336-1ff572d43dcmr93610485ad.35.1722752167823;
        Sat, 03 Aug 2024 23:16:07 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29ef4sm44194195ad.14.2024.08.03.23.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 23:16:07 -0700 (PDT)
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
Subject: [PATCH v4 2/5] drm/panel: st7701: Decouple DSI and DRM parts
Date: Sun,  4 Aug 2024 15:14:46 +0900
Message-ID: <20240804061503.881283-3-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804061503.881283-1-kikuchan98@gmail.com>
References: <20240804061503.881283-1-kikuchan98@gmail.com>
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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


