Return-Path: <linux-kernel+bounces-290976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38363955BCA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB481F213C7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE1414A90;
	Sun, 18 Aug 2024 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr7RDOpR"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2911CAF
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723965866; cv=none; b=Bg03kZZfj5vRBfx+87QFq3UkYoDlBiIj2JTamd+CR0CzJ/ePTnO/qiZf+RuIf9oCCb5yspVd0CInh2O5sbA0wKtsqHWNJXgel5RybTckLbEECWVCbf2Se5HHQwy5EYMduWZaauae5Y4uch3wPO5qTp/Q37LnKCWJTuInmpqPYJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723965866; c=relaxed/simple;
	bh=rTHrz1sVOulNiYayGf/NWFUCDle4p+WyNoxxJo9sHug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vdg219KmaxJ3Z4o2NgNO/Bt7Uks1nDy/4M8Gt7tRauCj2Wkw0OTTF2dzfXka34XgVvFeJ7G8QRolcf4C8jLI8Z9nEYLOGS3Pd/WKEjOIes5SAeo9t5pquLdwedTOKr5nTctPmRMs4EDBhDw0aJV9SzhaBwzfAYqKmECtszMXiXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr7RDOpR; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db1e21b0e4so2196503b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723965863; x=1724570663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/4wel2er+Y+8qgdhA7QELr/jTAEL57Ae/A8Ya8smkc=;
        b=Sr7RDOpR/WFk5y3crsQUzlPkQsJQxR/KvRAxm+dlW4wYXh792yWrk7ig/isTPp24NO
         m7tKdfcy3mDLQ8+rhcs5PwFCuG8/FDaEeU8nPkX62G7lU8EJeVupTxPCDz6M2HAK/A8X
         z5jikRlbjsQ6LyDP8wLJYhOT/LL9Zw9XL/NHLx6dp5WUFGMaqxxCeHC4YSNYTGMRErH7
         T3lt9evMR6QBUJ7bBPinFBXRnYoLMEr5EXfgHWICehE1r9r+HXBFx1Jit90n+7j80tge
         lL4su1APjCocQGVLKY6v7cEHnPRuSk6nicMn3QtnBVIIzk2QCfGTTZH+mYlCaTTwS8rI
         fEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723965863; x=1724570663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/4wel2er+Y+8qgdhA7QELr/jTAEL57Ae/A8Ya8smkc=;
        b=FQwB87oD2YAGfdCBKAPQWRT81Oq9X/l/jhDZz1Z0SQMkdHg0vRP4P83W5NW41uugjX
         lf80oI7rYaTWJE2gFXPd7zQSq5Vziu+pZ73mswpj9KuEz2oNuH95IA4RpP+Hjblf9HJl
         MEC5mYfKSOrLhnmLBoSY7znRUogpax+w0Idj3W8HbhaIOpmIwyGLz0Ti//tMV7kPXZxt
         T0o31aJZmeioLtxFg2A3UqyZKQf+KjR5UzicoFC8w5gVFmK6Oap7xoqMK5ZDJyDLJGKX
         C8vobTnFE/Pi1QfPTlvY+zWMudjqwDBnxv9tp+ro8a7zQRxphi4OXtn6Lx9JugDQ79Uv
         5PNw==
X-Forwarded-Encrypted: i=1; AJvYcCWgewSZ/G38KgmlDSMDmifQd+gOV5ZC1OLkV2wiAuvoGATY9UCtoR+6/7GK69XJffGSawGMIhq5HLN+oPCyxMA/drPdSinXAhHD0Zd0
X-Gm-Message-State: AOJu0Yxca3DirNNDtE47aiSi/rOHmZaAdrKocWcWyfwkY+bFjgs6lT0q
	QUn0riYGep+eqTCYhRHM2e0lQBlKZv/6OreDiH0RIIInfTUfqGUw
X-Google-Smtp-Source: AGHT+IGsv4PuPwr9QsF658mBwaaoRWK38GUFATboGtPG6yrFi3MrCZRRZy/VfscnEYXs5akOAzXnQQ==
X-Received: by 2002:a05:6808:1693:b0:3dc:39e9:df6 with SMTP id 5614622812f47-3dd3ade0dfcmr9031124b6e.23.1723965863488;
        Sun, 18 Aug 2024 00:24:23 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356929sm5704860a12.73.2024.08.18.00.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 00:24:23 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: agx@sigxcpu.org,
	kernel@puri.sm,
	neil.armstrong@linaro.org
Cc: dianders@chromium.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH] drm/panel: mantix-mlaf057we51: transition to mipi_dsi wrapped functions
Date: Sun, 18 Aug 2024 12:53:56 +0530
Message-ID: <20240818072356.870465-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the mantix-mlaf057we51 panel to use multi style functions for
improved error handling.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 79 +++++++------------
 1 file changed, 27 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index ea4a6bf6d35b..4db852ffb0f6 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -23,7 +23,7 @@
 
 /* Manufacturer specific Commands send via DSI */
 #define MANTIX_CMD_OTP_STOP_RELOAD_MIPI 0x41
-#define MANTIX_CMD_INT_CANCEL           0x4C
+#define MANTIX_CMD_INT_CANCEL           0x4c
 #define MANTIX_CMD_SPI_FINISH           0x90
 
 struct mantix {
@@ -45,82 +45,57 @@ static inline struct mantix *panel_to_mantix(struct drm_panel *panel)
 	return container_of(panel, struct mantix, panel);
 }
 
-static int mantix_init_sequence(struct mantix *ctx)
+static void mantix_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	struct device *dev = ctx->dev;
-
 	/*
 	 * Init sequence was supplied by the panel vendor.
 	 */
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
-
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_INT_CANCEL, 0x03);
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
-	mipi_dsi_generic_write_seq(dsi, 0x80, 0xA9, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a);
 
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
-	mipi_dsi_generic_write_seq(dsi, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
-	msleep(20);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_INT_CANCEL, 0x03);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a, 0x03);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0xa9, 0x00);
 
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_SPI_FINISH, 0xA5);
-	mipi_dsi_generic_write_seq(dsi, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
-	msleep(20);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a, 0x09);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
+	mipi_dsi_msleep(dsi_ctx, 20);
 
-	dev_dbg(dev, "Panel init sequence done\n");
-	return 0;
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xa5);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2f);
+	mipi_dsi_msleep(dsi_ctx, 20);
 }
 
 static int mantix_enable(struct drm_panel *panel)
 {
 	struct mantix *ctx = panel_to_mantix(panel);
-	struct device *dev = ctx->dev;
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
-	int ret;
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mantix_init_sequence(ctx);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
-		return ret;
-	}
+	mantix_init_sequence(&dsi_ctx);
+	if (!dsi_ctx.accum_err)
+		dev_dbg(ctx->dev, "Panel init sequence done\n");
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode\n");
-		return ret;
-	}
-	msleep(20);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret)
-		return ret;
-	usleep_range(10000, 12000);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 10000, 12000);
 
-	ret = mipi_dsi_turn_on_peripheral(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to turn on peripheral\n");
-		return ret;
-	}
+	mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int mantix_disable(struct drm_panel *panel)
 {
 	struct mantix *ctx = panel_to_mantix(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		dev_err(ctx->dev, "Failed to turn off the display: %d\n", ret);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		dev_err(ctx->dev, "Failed to enter sleep mode: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int mantix_unprepare(struct drm_panel *panel)
-- 
2.46.0


