Return-Path: <linux-kernel+bounces-201585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E868FC06F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5741C20F03
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9AE3D66;
	Wed,  5 Jun 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hmm/VEwc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FECEDE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547054; cv=none; b=XqccpcneKPc2zdHXXmDEKN52FRhTFW/WHqCmd73YSRWmmeV9zbEJguUStw4xBOX2jM4G+bqp1cSV+DT8X0jaQX1KseOu9VFq/Go77Y/QIQnWddzIQp1btXU14SGnBlDDxZjiqMJpKvolorkpyid8xVRNV0/enPW1vCElmzyIofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547054; c=relaxed/simple;
	bh=cEEFAm1A0QXMTg6R/9OXTqsoNO7Rs7Qxk/5qSpAPufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSQeo7nfQTWY85cs5qcns5FWFspxQo+/J9k+/+Upg9sIiTeU9RtFw/P9NRv3S57n2vN+atzGHT5nrTTfBveLtAw+fbkmSk76SFnhB8y2Jd/I9eYY8Q98xDocNX247diQv7GBl5cFB8DyMjwo4dZqcbPKEsFOqdMCwD6deW+owWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hmm/VEwc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6559668e1so27251895ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547052; x=1718151852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZEZey5x5luD0xWg/8KZQe7BPyHWAO218kvdlS1elh8=;
        b=hmm/VEwcHc1KKTUjl2oGn6VzF78dGlACD62bx+DAYVaiDCfw7j8VAXonp5X2IhbpBa
         yvW/H8BpWEXO3PKtAiVn2ZxIYFadc30tE9gsYstcuR7SbhFB9gyTgHpJATLw2/ksmFtB
         LKbkQBOihcBB+l0ih8dFqdkoT/YlgLw5Oy7ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547052; x=1718151852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZEZey5x5luD0xWg/8KZQe7BPyHWAO218kvdlS1elh8=;
        b=cp40pN9rPOfyclnCH6Pnez2PRbKlAo8zJO9FgxupSu4BiAL1xQf37kGSSvDEkjtw20
         kglvFgboQFChNJH1FgV6fIAgEGDo07So/OFl3xiNSmDcfZst7NAp0E+sLX67/JzPbBLX
         lXCO5xtI8ObN5WHQx/B9cHzr6WhdG+uWb5wIzn2yf1ZxjTYJ1XIy8te+Qrp7FuSeaSC0
         v9n2g6rdaEEIWaHfslIGESoEMvObYXtObnYXk+bKkjzjvDvoqS/fmYHbwg53vj/m0JG3
         cbgEI1xNwdoqU4yNo9szGyIsLVsE1RgYx3UwbdKxOoISFhWvtFMSlokVZ4Q2hGutphKL
         8qDA==
X-Forwarded-Encrypted: i=1; AJvYcCW+kONzoipTFfUIFYLpxSvBUmZG3YBttuCijUZfWs2PNBgoEVUHkHkKgbZusOHJHO1e40B9gLLSQtm6NtEOK9E96eRwmkcA3592TvaP
X-Gm-Message-State: AOJu0YzzKtybwSI3Iulb+kS795q3jbvWx2EYmMDyxAyO2XAJ0Q+qfrpD
	Z2e6W4IKalFrvlTOzZjU1IUIVq6g4WjQjllYpI4TiOY/gjhWjlTThXt6Fbkmaw==
X-Google-Smtp-Source: AGHT+IEfsqqgmgYWM0BC/bbTU6AS9BdhPGPSHuCKwVJwHIAn7JXDeAeaFpMbK/YJKuIU6Ne3nlYqaw==
X-Received: by 2002:a17:902:a515:b0:1f6:4cff:6ffd with SMTP id d9443c01a7336-1f6a5a83e7emr9332115ad.57.1717547052198;
        Tue, 04 Jun 2024 17:24:12 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:11 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Jerry Han <jerry.han.hq@gmail.com>,
	Jitao Shi <jitao.shi@mediatek.com>,
	Rock Wang <rock_wang@himax.com.cn>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 01/24] drm/panel: boe-himax8279d: Stop tracking prepared/enabled
Date: Tue,  4 Jun 2024 17:22:47 -0700
Message-ID: <20240604172305.v3.1.Ia3f254ab6e04e4f7afba6c066454498c8fb01324@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240605002401.2848541-1-dianders@chromium.org>
References: <20240605002401.2848541-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

NOTE: as part of this, transition the panel's direct calls to its
disable/unprepare functions in shutdown/remove to call through DRM
panel.

Cc: Jerry Han <jerry.han.hq@gmail.com>
Cc: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rock Wang <rock_wang@himax.com.cn>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-boe-himax8279d.c | 31 +++-----------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
index e225840b0d67..12e14615298b 100644
--- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
+++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
@@ -47,9 +47,6 @@ struct panel_info {
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *pp33_gpio;
 	struct gpio_desc *pp18_gpio;
-
-	bool prepared;
-	bool enabled;
 };
 
 static inline struct panel_info *to_panel_info(struct drm_panel *panel)
@@ -86,17 +83,12 @@ static int boe_panel_disable(struct drm_panel *panel)
 	struct panel_info *pinfo = to_panel_info(panel);
 	int err;
 
-	if (!pinfo->enabled)
-		return 0;
-
 	err = mipi_dsi_dcs_set_display_off(pinfo->link);
 	if (err < 0) {
 		dev_err(panel->dev, "failed to set display off: %d\n", err);
 		return err;
 	}
 
-	pinfo->enabled = false;
-
 	return 0;
 }
 
@@ -105,9 +97,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 	struct panel_info *pinfo = to_panel_info(panel);
 	int err;
 
-	if (!pinfo->prepared)
-		return 0;
-
 	err = mipi_dsi_dcs_set_display_off(pinfo->link);
 	if (err < 0)
 		dev_err(panel->dev, "failed to set display off: %d\n", err);
@@ -121,8 +110,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 
 	disable_gpios(pinfo);
 
-	pinfo->prepared = false;
-
 	return 0;
 }
 
@@ -131,9 +118,6 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	struct panel_info *pinfo = to_panel_info(panel);
 	int err;
 
-	if (pinfo->prepared)
-		return 0;
-
 	gpiod_set_value(pinfo->pp18_gpio, 1);
 	/* T1: 5ms - 6ms */
 	usleep_range(5000, 6000);
@@ -180,8 +164,6 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	/* T7: 20ms - 21ms */
 	usleep_range(20000, 21000);
 
-	pinfo->prepared = true;
-
 	return 0;
 
 poweroff:
@@ -194,9 +176,6 @@ static int boe_panel_enable(struct drm_panel *panel)
 	struct panel_info *pinfo = to_panel_info(panel);
 	int ret;
 
-	if (pinfo->enabled)
-		return 0;
-
 	usleep_range(120000, 121000);
 
 	ret = mipi_dsi_dcs_set_display_on(pinfo->link);
@@ -205,8 +184,6 @@ static int boe_panel_enable(struct drm_panel *panel)
 		return ret;
 	}
 
-	pinfo->enabled = true;
-
 	return 0;
 }
 
@@ -917,11 +894,11 @@ static void panel_remove(struct mipi_dsi_device *dsi)
 	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
 	int err;
 
-	err = boe_panel_disable(&pinfo->base);
+	err = drm_panel_disable(&pinfo->base);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
 
-	err = boe_panel_unprepare(&pinfo->base);
+	err = drm_panel_unprepare(&pinfo->base);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", err);
 
@@ -936,8 +913,8 @@ static void panel_shutdown(struct mipi_dsi_device *dsi)
 {
 	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
 
-	boe_panel_disable(&pinfo->base);
-	boe_panel_unprepare(&pinfo->base);
+	drm_panel_disable(&pinfo->base);
+	drm_panel_unprepare(&pinfo->base);
 }
 
 static struct mipi_dsi_driver panel_driver = {
-- 
2.45.1.288.g0e0cd299f1-goog


