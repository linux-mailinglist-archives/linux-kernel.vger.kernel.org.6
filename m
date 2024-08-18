Return-Path: <linux-kernel+bounces-290912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2BF955B1A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 08:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D634E282532
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84B5D53F;
	Sun, 18 Aug 2024 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg3lDvAv"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3D15E96
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723961317; cv=none; b=REkX/biNE1ybQoywDsVfzzSalraB4Jf5NiA417WRZE5OwuxfHszmrgTFdd3jIu8qDiXli6l9v/QJdZJoOGHSW565aq5IKML++y2yLoYiXCCXtfGfAgnBA4OhaWn4m5w22KSJD0EfxNJHEJ+pYcB6BqlLZABTFqmwOi9eIoblS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723961317; c=relaxed/simple;
	bh=lyWdoxJIYg+uZPBV2sDX1oYxJugNPki6UChH6tky+g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0FmnI2yP7r7/LAWmkXmiJGWoHt8WnMRtc3I1NR2+3a7Y2ll9PMlY9h5OvOp692azucA1nIXLNPFRMjGICKDVfJX11uAua0l5X4x+Yg2mnudVgX2z1I8Q7mk5slwHzp/HuXB24wKIiuXVzTYbIB99nMZ/OzyX2KsfblQ5wWL/to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jg3lDvAv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d439572aeaso40568a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723961315; x=1724566115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7ad08V9dWOOHyWHL258V3QEERYZAETpc4J3fM7chOc=;
        b=Jg3lDvAv5YigxVbMGlzyinR6Z6oMinu5SkwienK1MeYkyVL5hyHvqbTf4tatO9og9P
         /Z6Z4kKIGjxh2UTzxjbpHyaQSi3O0p9Dq7+Ak3mQ5BruOzDM2euW0u5NiA21yYeGFZa6
         3MUBmwPWTzmsMK053wPCTVHDMTfSu9WsqjdUufIH0v90Yit2dgI6Q7Il2Si7dcZYF/GO
         DDDGdvzno3cHacLC48ap+2yt/kOA9wIvKriB80R+uGcBLRalfG8tFm/x25F8+8ZeEUMb
         YmgvQfYVruxNnFVOnG5qi/2Y/OAlVXgFE3wr3WQA83Q0hWvqbK9vmAucZs5B75orQZeN
         BJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723961315; x=1724566115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7ad08V9dWOOHyWHL258V3QEERYZAETpc4J3fM7chOc=;
        b=IJSrkKlYQCG+v+Qea3l6G2jivu6ZZueQMWjWLyZ1GX33KTHtRbZhL0YgmFTEVc7bTt
         Pqz6ASzXFarFcu0U6g+7966SRgLRDJ0lCWI6SYQuoD8CsSZQXliQYCTKKFb3fOUPGWkU
         prdwd+9nQ4guCtjks87dx8YTsipp8N+NF/iYGf5SiDLiigqaRUPk7Xn0lDhQZpJpo+y1
         3qcHZ0grmjUvRe4jUl1ANUzzau6zVOHei5MtxALoD7MGH68ni0hmA0TAimBAsbyqErS8
         TPRGYEcHrkhuQrk3pmx4NOZq9oUh6v+fhJUTGm7n9nXkc1ooGSRKLJ0HO68TuuyMIj/D
         qWMg==
X-Forwarded-Encrypted: i=1; AJvYcCX6WZpSQ4DYu3mA465l+2UNhxHfgQIVkRduM1lk4DDfyrCvIqoQ1B0vUk4EusC3ETUCBfT8OJ9XZ9mFtJmhq8Ltsh3VaXZeQl3dcA0z
X-Gm-Message-State: AOJu0YzBACl93YTv7O8w+HigdgISV6CVktOmnhJ9BCuKe7Fg2vru1BwM
	BugV9SPSRM1FAS5K858ucaj2BpSFqAif2TuY18jKNKcg/Epvkexy
X-Google-Smtp-Source: AGHT+IFRtCSERfuy675a0jOJLl4KWwWGVGXXS4VlR/U2FYPHZXXE4rpb1RZGXKMSWZ1kKar/w+HVqA==
X-Received: by 2002:a17:90b:124b:b0:2d3:ad05:7240 with SMTP id 98e67ed59e1d1-2d3c3aa98bbmr16548494a91.22.1723961315162;
        Sat, 17 Aug 2024 23:08:35 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([2401:4900:6322:f541:ea23:e535:a48c:3c88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d4394e01b4sm236228a91.46.2024.08.17.23.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:08:34 -0700 (PDT)
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
Subject: [PATCH v3 2/2] drm/panel: jdi-fhd-r63452: transition to mipi_dsi wrapped functions
Date: Sun, 18 Aug 2024 11:38:16 +0530
Message-ID: <20240818060816.848784-3-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240818060816.848784-1-tejasvipin76@gmail.com>
References: <20240818060816.848784-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the jdi-fhd-r63452 panel to use multi style functions for
improved error handling.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 149 ++++++-------------
 1 file changed, 48 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index 483dc88d16d8..4eb71e85e9e9 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -41,142 +41,89 @@ static void jdi_fhd_r63452_reset(struct jdi_fhd_r63452 *ctx)
 static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xec,
-				   0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
-				   0x13, 0x15, 0x68, 0x0b, 0xb5);
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
-
-	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear on: %d\n", ret);
-		return ret;
-	}
-
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec,
+					 0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
+					 0x13, 0x15, 0x68, 0x0b, 0xb5);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
 
-	ret = mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set pixel format: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_set_column_address(dsi, 0x0000, 0x0437);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set column address: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 
-	ret = mipi_dsi_dcs_set_page_address(dsi, 0x0000, 0x077f);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set page address: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
 
-	ret = mipi_dsi_dcs_set_tear_scanline(dsi, 0x0000);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear scanline: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx, 0x77);
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0x0000, 0x0437);
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0x0000, 0x077f);
+	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx, 0x0000);
+	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x00ff);
 
-	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x00ff);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display brightness: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x00);
 
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 80);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-	msleep(20);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x11);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(80);
-
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc8, 0x11);
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
-static int jdi_fhd_r63452_off(struct jdi_fhd_r63452 *ctx)
+static void jdi_fhd_r63452_off(struct jdi_fhd_r63452 *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xec,
-				   0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
-				   0x13, 0x15, 0x68, 0x0b, 0x95);
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
-	usleep_range(2000, 3000);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(120);
-
-	return 0;
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec,
+					 0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
+					 0x13, 0x15, 0x68, 0x0b, 0x95);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 2000, 3000);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 }
 
 static int jdi_fhd_r63452_prepare(struct drm_panel *panel)
 {
 	struct jdi_fhd_r63452 *ctx = to_jdi_fhd_r63452(panel);
-	struct device *dev = &ctx->dsi->dev;
 	int ret;
 
 	jdi_fhd_r63452_reset(ctx);
 
 	ret = jdi_fhd_r63452_on(ctx);
-	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+	if (ret < 0)
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int jdi_fhd_r63452_unprepare(struct drm_panel *panel)
 {
 	struct jdi_fhd_r63452 *ctx = to_jdi_fhd_r63452(panel);
-	struct device *dev = &ctx->dsi->dev;
-	int ret;
 
-	ret = jdi_fhd_r63452_off(ctx);
-	if (ret < 0)
-		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+	/*
+	 * NOTE: We don't return an error here as while the panel won't have
+	 * been cleanly turned off at least we've asserted the reset signal
+	 * so it should be safe to power it back on again later
+	 */
+	jdi_fhd_r63452_off(ctx);
 
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 
-- 
2.46.0


