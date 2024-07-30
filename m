Return-Path: <linux-kernel+bounces-266820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AE5940819
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32EE1F23D91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D74C18E769;
	Tue, 30 Jul 2024 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEulmHf2"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694618D4B3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319651; cv=none; b=dPDQ2xQ4emc2/uDnS9hM5mj2i6AJimcinfzQ/XKh7ZmkXrt6GIhjvj/FMhVmOxSvuwPYp1EEACh3aQ1fN/thmFRW7bYhiGr7fLDd2IUFbTU5Cb+DnPetbfjV6a0mXUiIhItqdZqUA5uv4N+x63MAReR/GnBcdTWvOgtDX8yCXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319651; c=relaxed/simple;
	bh=ZXI/JZSqWXhXkKTOEa/XOyUoMkMdq3Kiw1EydseD9g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDCnxaYhbxm2oGr0qEeVs82kK9pQ4QQvtBTiC5F9FynIQa5rYAHqKZ7FtetVs6FpEkN9kCU4S1OpVTXe+gHHkzq1nIlUNBTGiFmDHS+Sv0JyBuHwuxAJU0SxuL06/TbxQ243z4Vs3u83tnrEtGUN1xn7BqFMXYBNa+Yckq2JUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEulmHf2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd6ed7688cso27949715ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722319649; x=1722924449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nUjLNuPhA0ZemM5E+a6+HXIf2vTrBCrMNImUmEpou0=;
        b=bEulmHf2D0GAchm6wzB5AhuWyEct0f/NJ6N+ypzmuN0n52hsKOWvYO1WMfzQZt1FQx
         uMWoYXYj+1iZYgqtx/awp23i1bibcBdHAR+jgKdNHS4drVF90o2aZTp9DjZMyCTVCzy6
         oDtk2fbhwqUkeqw50Od4a1aA7CrHSQgfdar5cAIihokcZpki12u4Rd2NH/6LkkqHS/AP
         bRWtq+WvlKJk+EuSkJLMna/wnwRPfIRbkwCkAlkKuIioREJLH4v0NTehyvI0eSa5690n
         uLfZkAP59U0VLrsyVHP2YeH8FlLNYohGAaIavAJuGBoXiWH9JoEDZWZey7HT8Vq+N8EK
         THDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722319649; x=1722924449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nUjLNuPhA0ZemM5E+a6+HXIf2vTrBCrMNImUmEpou0=;
        b=u3mbDLYWXsOgZEpsJIFUYPlg1P8qk8qK1pPeqGLQtSOaqL6hf3uKFqagL3ikgxjptY
         nIrlG/tfkIe2Eaa9yoU8BrP5BWVgjGeVOX0eMJpk9Evb7yHFPfGu7saCkYOSzCyFd0CV
         6ev1cutDzK/AQQqdTVOFiHp7z7MBrs2HyTkQzzRj0Sh0d7gd9yNz6tIQZhsYq3W3iiHB
         whAUQd70nDN00urQkme1HptXTvBREzbBnoCZovP+xbkEPn41goHxxqz7xf9mZd6jhTeH
         qFSFA+xf/V30jfz0lT5ZtqwPYWjpPCAXLWYGdEEL5isF/ndPPL36rxcq+sC8Ld6egGgl
         EHSg==
X-Forwarded-Encrypted: i=1; AJvYcCU8c6zK59a3K8l387hhuQHki8fztVQbNS0Jd8w3X6ibe1i/7fR6y/toReg6bRyLe6f3g2JvqK4kSv3Vsoy4Nz8dHejS3F8gSUWZsZKz
X-Gm-Message-State: AOJu0Yx/q0DGtrdX5c0mp75PevUlLJpYTsweNjHA3T75fhwT/x3Jm96/
	7IWeiKWW68CUDOKuNgcUbI6Qjp05Q3Ur55/pyZdEK7dQ5lv7LABy
X-Google-Smtp-Source: AGHT+IFCAk8xtEo9IOGEMHT4pM4XLaFJu1tAipcjmvjw2BFrQGf8AKqe85DxNjL12FVVm0m2oMcE2g==
X-Received: by 2002:a17:903:2289:b0:1fb:37fa:fedb with SMTP id d9443c01a7336-1ff04805bb5mr83419115ad.10.1722319649042;
        Mon, 29 Jul 2024 23:07:29 -0700 (PDT)
Received: from distilledx.localdomain ([2401:4900:6320:5c5f:a09c:1e46:e58e:e6c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7eef4f0sm93589375ad.178.2024.07.29.23.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:07:28 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: dianders@chromium.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2 2/2] drm/panel: startek-kd070fhfid015: transition to mipi_dsi wrapped functions
Date: Tue, 30 Jul 2024 11:36:59 +0530
Message-ID: <20240730060659.455953-3-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730060659.455953-1-tejasvipin76@gmail.com>
References: <20240730060659.455953-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use multi style wrapped functions for mipi_dsi in the
startek-kd070fhfid015 panel.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 .../drm/panel/panel-startek-kd070fhfid015.c   | 123 ++++++------------
 1 file changed, 39 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
index 0156689f41cd..f1df727b9183 100644
--- a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
+++ b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
@@ -24,10 +24,10 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
-#define DSI_REG_MCAP	0xB0
-#define DSI_REG_IS	0xB3 /* Interface Setting */
-#define DSI_REG_IIS	0xB4 /* Interface ID Setting */
-#define DSI_REG_CTRL	0xB6
+#define DSI_REG_MCAP	0xb0
+#define DSI_REG_IS	0xb3 /* Interface Setting */
+#define DSI_REG_IIS	0xb4 /* Interface ID Setting */
+#define DSI_REG_CTRL	0xb6
 
 enum {
 	IOVCC = 0,
@@ -52,92 +52,55 @@ static inline struct stk_panel *to_stk_panel(struct drm_panel *panel)
 static int stk_panel_init(struct stk_panel *stk)
 {
 	struct mipi_dsi_device *dsi = stk->dsi;
-	struct device *dev = &stk->dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = {.dsi = dsi};
 
-	ret = mipi_dsi_dcs_soft_reset(dsi);
-	if (ret < 0) {
-		dev_err(dev, "failed to mipi_dsi_dcs_soft_reset: %d\n", ret);
-		return ret;
-	}
-	mdelay(5);
+	mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 5);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "failed to set exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(120);
-
-	mipi_dsi_generic_write_seq(dsi, DSI_REG_MCAP, 0x04);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, DSI_REG_MCAP, 0x04);
 
 	/* Interface setting, video mode */
-	mipi_dsi_generic_write_seq(dsi, DSI_REG_IS, 0x14, 0x08, 0x00, 0x22, 0x00);
-	mipi_dsi_generic_write_seq(dsi, DSI_REG_IIS, 0x0C, 0x00);
-	mipi_dsi_generic_write_seq(dsi, DSI_REG_CTRL, 0x3A, 0xD3);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, DSI_REG_IS, 0x14, 0x08, 0x00, 0x22, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, DSI_REG_IIS, 0x0c, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, DSI_REG_CTRL, 0x3a, 0xd3);
 
-	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x77);
-	if (ret < 0) {
-		dev_err(dev, "failed to write display brightness: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x77);
 
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
-			       MIPI_DCS_WRITE_MEMORY_START);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY,
+				     MIPI_DCS_WRITE_MEMORY_START);
 
-	ret = mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
-	if (ret < 0) {
-		dev_err(dev, "failed to set pixel format: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx, 0x77);
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0, stk->mode->hdisplay - 1);
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0, stk->mode->vdisplay - 1);
 
-	ret = mipi_dsi_dcs_set_column_address(dsi, 0, stk->mode->hdisplay - 1);
-	if (ret < 0) {
-		dev_err(dev, "failed to set column address: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_set_page_address(dsi, 0, stk->mode->vdisplay - 1);
-	if (ret < 0) {
-		dev_err(dev, "failed to set page address: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int stk_panel_on(struct stk_panel *stk)
 {
 	struct mipi_dsi_device *dsi = stk->dsi;
-	struct device *dev = &stk->dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = {.dsi = dsi};
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0)
-		dev_err(dev, "failed to set display on: %d\n", ret);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	mdelay(20);
+	mipi_dsi_msleep(&dsi_ctx, 20);
 
-	return ret;
+	return dsi_ctx.accum_err;
 }
 
 static void stk_panel_off(struct stk_panel *stk)
 {
 	struct mipi_dsi_device *dsi = stk->dsi;
-	struct device *dev = &stk->dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = {.dsi = dsi};
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		dev_err(dev, "failed to set display off: %d\n", ret);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		dev_err(dev, "failed to enter sleep mode: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	msleep(100);
+	mipi_dsi_msleep(&dsi_ctx, 100);
 }
 
 static int stk_panel_unprepare(struct drm_panel *panel)
@@ -155,7 +118,6 @@ static int stk_panel_unprepare(struct drm_panel *panel)
 static int stk_panel_prepare(struct drm_panel *panel)
 {
 	struct stk_panel *stk = to_stk_panel(panel);
-	struct device *dev = &stk->dsi->dev;
 	int ret;
 
 	gpiod_set_value(stk->reset_gpio, 0);
@@ -175,16 +137,12 @@ static int stk_panel_prepare(struct drm_panel *panel)
 	gpiod_set_value(stk->reset_gpio, 1);
 	mdelay(10);
 	ret = stk_panel_init(stk);
-	if (ret < 0) {
-		dev_err(dev, "failed to init panel: %d\n", ret);
+	if (ret < 0)
 		goto poweroff;
-	}
 
 	ret = stk_panel_on(stk);
-	if (ret < 0) {
-		dev_err(dev, "failed to set panel on: %d\n", ret);
+	if (ret < 0)
 		goto poweroff;
-	}
 
 	return 0;
 
@@ -235,13 +193,13 @@ static int stk_panel_get_modes(struct drm_panel *panel,
 static int dsi_dcs_bl_get_brightness(struct backlight_device *bl)
 {
 	struct mipi_dsi_device *dsi = bl_get_data(bl);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	u16 brightness;
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
-	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_get_display_brightness_multi(&dsi_ctx, &brightness);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 	return brightness & 0xff;
@@ -250,18 +208,15 @@ static int dsi_dcs_bl_get_brightness(struct backlight_device *bl)
 static int dsi_dcs_bl_update_status(struct backlight_device *bl)
 {
 	struct mipi_dsi_device *dsi = bl_get_data(bl);
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = {.dsi = dsi};
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
-	ret = mipi_dsi_dcs_set_display_brightness(dsi, bl->props.brightness);
-	if (ret < 0) {
-		dev_err(dev, "failed to set DSI control: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, bl->props.brightness);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static const struct backlight_ops dsi_bl_ops = {
-- 
2.45.2


