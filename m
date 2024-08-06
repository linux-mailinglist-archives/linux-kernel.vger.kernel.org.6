Return-Path: <linux-kernel+bounces-276367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D700694929B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FEBB271D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CFE18D634;
	Tue,  6 Aug 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxpaIOKj"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9D20FABD
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952826; cv=none; b=o/OYkgq1vbkG277FwWXG7FXhZ2j3LQC8t2VlOV9AF2U8eTeQHkHoShMD7GfUEVQ1N843e9erHse4soEIt7UMKmoXdzbp6Id+mzu7usTGoSxKNs4+inZlejTyFMhcfGakasfjuJAyHsg5WwQ1LQsf5aySHLvAw3gxzWn7SNsObDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952826; c=relaxed/simple;
	bh=CGXUrPsz/OmExTM5SbVDpLX0u2V4Tt4P9Tx5vcp2+Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOmCHJLfrku1ABsCZaOvCh9dTSRJFi97mExeDi9VWBfeEfGz1zyr+wMSKqSMl77voOi25pVDm7Ee7nUgU7zm+fQM1sM9nOhKnFK80oIFeML4EsvYS9MqyVi9ldmEC3tCzzeAWESMZIO/aBsxylpboz8SVj2eCvupyYpCBWtt2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxpaIOKj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb81c0ecb4so4824097a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722952824; x=1723557624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK7ANORZUzGJICKPtXebR+TykgsKwGrzcFtwkmK0p10=;
        b=CxpaIOKj4eC0Y1MeptRWFCnU1+MkMRa25U/2jl/V3pv5jLRczOgL5FeD9nN5HogvTV
         9doGjCrfwW6Mm5JtJauTyT/62DRfBWMufpCOxOmttecQf9K/orPBm/0Sfp+yekTRuha1
         nTUtjGWLiDlni8ee/AovoeMQkWQvMNCdzdg1cdhEaOC8a1ldJk2QCL1sKlsoPWY76fl7
         H3y+UdwJ8t+RHmiG7ufzCZZf9PtHYgQYJPi4VpbFKSoSWLrVb0pnfmSvTG53GSyhw05E
         BkzJRcDNpLZlQ/S1IzinaFHeN/wrrLtqdt2RvGrShevykwRLi6q2lqutXPWpiZ9ym0l8
         iVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952824; x=1723557624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK7ANORZUzGJICKPtXebR+TykgsKwGrzcFtwkmK0p10=;
        b=Yw0igTlGjLNx2tzgcVlJ1V30Rlvc0Ekjyggg70cbthQhaa/zixTqjuRfP/5eAfQWId
         4GlZ9vXSVyVETzo3FUvJz/Fx+rvJCi2t9+FGuJ2jZn4YSf/6jmSO8l0NkPvleOGV0yrC
         fo4HDHrQqI6KPndtn1k2f5oK8fD0d6/jtZpU8sM93OgBGrTdUwWuGbgrenvQxjQuHWbc
         WdZf+6fJTVYSPc6J8ChpOoH01JwPH1CMgJj3wohX5VRxGcGwHX9LYU7JxrOYLuiBBK4l
         mZV0hBnDAspN/xEeLzC6UpOvwyXN98ie67bEbACqok35pGXLICgBCgMpIpAnG8thsa1z
         QlNA==
X-Forwarded-Encrypted: i=1; AJvYcCVixHzrM6R0evDHFimhUptdpiKhL2MC/HsWpw2qXOvGHG33xWxQi2PfXX4R3fx/d2WOe/Qbmc8wuJGeXkWoJritOnFj/jZGypUtYS4Q
X-Gm-Message-State: AOJu0YzWC8xOvWl+mXzQm83doF1rXL/mXsTCiom9WwUuhE8Ww695H0ao
	xB9IelNzZ9/DioRs3Ci5FYW6AMKQi0yGIE1gaaBNfgdAgTa7fUQ/
X-Google-Smtp-Source: AGHT+IEMJuSc3n8itBDIcMqQLHq9b38TucY0X+Cs8gDQafx/MBSagnSSDNMUT4P1LpKXjey729/MqA==
X-Received: by 2002:a17:90b:4c07:b0:2c8:2236:e2c3 with SMTP id 98e67ed59e1d1-2cff0b253a1mr26643464a91.17.1722952823581;
        Tue, 06 Aug 2024 07:00:23 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b8a7453e92sm4415203a12.41.2024.08.06.07.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:00:23 -0700 (PDT)
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
Subject: [PATCH v3 2/2] drm/panel: startek-kd070fhfid015: transition to mipi_dsi wrapped functions
Date: Tue,  6 Aug 2024 19:29:49 +0530
Message-ID: <20240806135949.468636-3-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806135949.468636-1-tejasvipin76@gmail.com>
References: <20240806135949.468636-1-tejasvipin76@gmail.com>
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
 .../drm/panel/panel-startek-kd070fhfid015.c   | 115 ++++++------------
 1 file changed, 35 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
index 0156689f41cd..c0c95355b743 100644
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
-
-	ret = mipi_dsi_dcs_soft_reset(dsi);
-	if (ret < 0) {
-		dev_err(dev, "failed to mipi_dsi_dcs_soft_reset: %d\n", ret);
-		return ret;
-	}
-	mdelay(5);
+	struct mipi_dsi_multi_context dsi_ctx = {.dsi = dsi};
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "failed to set exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(120);
+	mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 5);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
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
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		dev_err(dev, "failed to enter sleep mode: %d\n", ret);
-
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
2.46.0


