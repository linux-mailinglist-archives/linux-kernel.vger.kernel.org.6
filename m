Return-Path: <linux-kernel+bounces-329090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F198978D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8450EB2382C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6230617741;
	Sat, 14 Sep 2024 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6msBNwP"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B214A8B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726285469; cv=none; b=RCXPqDw9SOnXVd9vJ4sLPS3xoSyupKvhwqAqZUcYAc3AU5BWvwS9Bc2x9vD4JBSWYsln61TJi7kpJsy8mzC5bmPl0UJFrAItyhNxRrtUOJtDZPIXWCXeDaAj9GMsoy2NmqmFqilub4wxLmdN1Eb9lhSCVu3XbKSjKy9mPP0dS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726285469; c=relaxed/simple;
	bh=CdWMTPieakVWGWEIwjF/Oq1HwDtWkdpwUMsZpeLFCjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJ1ScpKg1rmG1AgWDL2FDcM3KTPRsNaSvzP+8S4sNYApwAIqNUrvhEgR2GVJOa0pFrv2HYDdgj32R2FqZZBCydJMFO8uBxVyiozzJ++nvje63PZZFahZnbbkJ+nXKTmAieG7selNHTM3Xb8fVm/u4lfouF0O0xctvrEkR799DYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6msBNwP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso2293938a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 20:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726285467; x=1726890267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxhVso1KKLgRKM8XbkVpntKvRcoYBAw5zJqYDcpu1Gw=;
        b=L6msBNwPjA45yQQzgK6xpOR5Dt8pIc4Gi/eThyEVUhvbq78SKilLaC5A7A1qHjlkZW
         cGXgG3bLgnTmUCBN8RN7/5AeWDACBaqyyR9T98IkWdUsTlgppcJJNyMQA75reZqjDx9V
         ixgCy/ouzvZJsE2HWTL7jzpYOCbguvkTy3lTX5h6q4OCefQkcr4I2MLCUIyCZpY3xYyr
         z6xASzsOd8kDdnapNk/FcDezY66bwwWtGzPc2BQD7XOUOz2CYYFjALmXIAPld1Ub9SWJ
         m/9PuA27PiaiIMoP3aJEMW9BRAPzihB10P49d1NURnFRPMtFhe0ooGpDkIDs/Hd+588q
         9INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726285467; x=1726890267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxhVso1KKLgRKM8XbkVpntKvRcoYBAw5zJqYDcpu1Gw=;
        b=JXrsminWq23GsBc8zJNYOsJQYwHg735ZmXx9Ds6bfjBoiCHqEXf3UDlpmcN4mX8f3K
         CQQk64/RstIfAwPTojpRCgKC3vcibThDCODeBcQcBPEU17o18iEcfR2OLkaamsQP1M5r
         iHIBa69hPqSTrJVIqbg+T0WTHxIFs9A0aFiMQNqQJ/aDq/GMwFGvqzSfW6zRKVIAaCkJ
         yMnT+SA+o2X0f8DoaxrbR8jbbPCL3nOLfD5drSJI3uYKsfFypq1qBvh5RubpJCce0kyh
         0SXlm1gcbx34Ij1S87K5D2BdVR/wJqY2///3Z6Lj3c6nqF5b6VjX7wEWt6HnEVonDoOR
         NDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI27vAOLjythXe1Bn8edmothYiN4beubwSom8GBrxjhfaXJKR7wSbJtxKFZjVU7sWfp4dOzBEo7kisswA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPgCPqXsAxLGgLHmel+APzB+lMoxDG0C5nCio4rfwSVil3UC5
	w7hJWD7JNedlKr1N3MYURkJ3VMJXS5wedHQgzImsRjq7G18grawg
X-Google-Smtp-Source: AGHT+IEpUHmvc5Z7CiBw9pqO5r/tUIpQvtIHlhC/3FFuuZ59EP3DoZi5f7oP8fTxjGaS8P5CnSITkw==
X-Received: by 2002:a05:6a21:4d81:b0:1cf:6625:f05 with SMTP id adf61e73a8af0-1cf76239c8dmr10833766637.50.1726285467196;
        Fri, 13 Sep 2024 20:44:27 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([103.4.220.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498d970fsm387383a12.5.2024.09.13.20.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 20:44:26 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2] drm/panel: raydium-rm69380: transition to mipi_dsi wrapped functions
Date: Sat, 14 Sep 2024 09:13:41 +0530
Message-ID: <20240914034341.897197-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the raydium-rm69380 panel to use multi style functions for
improved error handling.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
Changes in v2:
    - Fix whitespace issues

Link to v1: https://lore.kernel.org/all/20240907140130.410349-1-tejasvipin76@gmail.com/
---
 drivers/gpu/drm/panel/panel-raydium-rm69380.c | 93 ++++++-------------
 1 file changed, 29 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm69380.c b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
index 4dca6802faef..d3071c01aaea 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm69380.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
@@ -46,108 +46,73 @@ static void rm69380_reset(struct rm69380_panel *ctx)
 static int rm69380_on(struct rm69380_panel *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi[0];
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 	if (ctx->dsi[1])
 		ctx->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd4);
-	mipi_dsi_dcs_write_seq(dsi, 0x00, 0x80);
-	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd0);
-	mipi_dsi_dcs_write_seq(dsi, 0x48, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x26);
-	mipi_dsi_dcs_write_seq(dsi, 0x75, 0x3f);
-	mipi_dsi_dcs_write_seq(dsi, 0x1d, 0x1a);
-	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x28);
-	mipi_dsi_dcs_write_seq(dsi, 0xc2, 0x08);
-
-	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear on: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(20);
-
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-	msleep(36);
-
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xd4);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xd0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x08);
+
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 36);
+
+	return dsi_ctx.accum_err;
 }
 
-static int rm69380_off(struct rm69380_panel *ctx)
+static void rm69380_off(struct rm69380_panel *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi[0];
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 	if (ctx->dsi[1])
 		ctx->dsi[1]->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
-	msleep(35);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(20);
-
-	return 0;
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 35);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
 }
 
 static int rm69380_prepare(struct drm_panel *panel)
 {
 	struct rm69380_panel *ctx = to_rm69380_panel(panel);
-	struct device *dev = &ctx->dsi[0]->dev;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	rm69380_reset(ctx);
 
 	ret = rm69380_on(ctx);
 	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int rm69380_unprepare(struct drm_panel *panel)
 {
 	struct rm69380_panel *ctx = to_rm69380_panel(panel);
-	struct device *dev = &ctx->dsi[0]->dev;
-	int ret;
 
-	ret = rm69380_off(ctx);
-	if (ret < 0)
-		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+	rm69380_off(ctx);
 
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-- 
2.46.0


