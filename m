Return-Path: <linux-kernel+bounces-331368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D006597ABED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C7428E3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0A364D6;
	Tue, 17 Sep 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh1NIRph"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3718B1A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557478; cv=none; b=aEgk3H4x45hgxxITB+vz7PxpDYEF2WJF7/4HdQY5UhHdVW3DaucDYVoLcJp+ZU+NNxOANOODWiAAb/Ha0XowA6/xX7kfnWBrUb6652Twg3dZfbQmANAgMN26o+Dkn1S94MR53ZN2+8zU498/qDUfAqvke2Fyv9A74e7xkXD1iQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557478; c=relaxed/simple;
	bh=PECPKPSEI8s0qwxIK9pwA5oxGgap47aIA0uplBlQZt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SkHdNP0uMA1dOkpCrbJEKV7HQRJtaQzJ9ZRvuiqbM/Mc5g0jgKh3PRCS5ho/Ooa2X31vCDoqF1N5PFrVaw1cV2TtZiZjemHH2ZdSgpvT2adsUvYjQzk998smRNwnFwPlEzLs3GeaL3wlofx9qAGxo4UAi9WdZ5XW97cZuzEnpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh1NIRph; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718e6299191so2945970b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726557476; x=1727162276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eR3y36WD4tVlkVWOhI0lCliV58lEc5qOyZSZyDjtgq0=;
        b=Vh1NIRphkwz3MHzcjXzf6DhrYXlKZLJBwlUpHcNQ33q+qNM5b5c5KkAD88S/JBzevf
         22EwFZbgskIbNGUpe8qau2ZoMjz5qP5IZP/aigFEcQzy9RDmDkGgm3lyBpcZ0xHeSDpd
         yJbY6mHn81rEPgwvgsx3vHWs9Vtefix77KCGxNyd6EvyyyGaYaNsV4SyathZbxQn9r3M
         fLRw57Wlgp7SwhdCxrKXE5PpG787Lh8h6NUdtmmwCx8hf0PMf0U3xQIdUFcTtPAdpRm8
         IHtz56RmnTlCWxQsa5D4gT6EcMGRZs/OMUxtP9FRC+Y4DxyjGgfGCqikLZCXXk+s6+6S
         cYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726557476; x=1727162276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eR3y36WD4tVlkVWOhI0lCliV58lEc5qOyZSZyDjtgq0=;
        b=PZK6XQsTNnKr8esoIg4X0MyQK1vKJAHbF6JJVsWW8FaeMR0g68jq06q3uh2m+S9sfi
         +mXpoPp81ADJ6IPkEqfQJpSh9f4WufHRM3d/SDraQgn+h5BZF3YwYXMxgWFJlGijKlp5
         jVsXknATmKXvxtZBrEDwg4Bjw1+MZiEzT+YCaJrcv1LQlYjv0uJGjJcq00kwI0+f89a/
         TWE8tQmGVbYaLKU1Nd9gqWrdp7zFOxQHeR0qhNKssYJlrO8WH4N9MzOe0uuQqIsJEndD
         UPHmxJHk2F7xhia9JUGvT+acskUvGcrAT0ZS/wdTPn1qiXVOFGZRUGVeYplRTgN7LC8U
         Xoxg==
X-Forwarded-Encrypted: i=1; AJvYcCXwXf9gG5rswvb88WZxt7Jzlep7FU/e55W31Vq3BQqGY0H0bG02kxOYGPBAmBsOJE6Fmxxm9QOxI87ch/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5s2ummeV6pLxbct4zUnZ7GIqFThdsLfrFmfPwKkboPrHMLwy
	sVAbgZ0zq7PeGed9U4LYY/uhUHbmRBYyr2rWqkq/HzjwDKUFEAfX
X-Google-Smtp-Source: AGHT+IGaBul7iKoYU2pjQ6zunExY6Y/eI2Dn+fgyD558TLkqm9GaNv+wFopgw4ia4meegOtO8eKN+Q==
X-Received: by 2002:a05:6a00:2d05:b0:714:1bcf:3d93 with SMTP id d2e1a72fcca58-719260562d7mr25693441b3a.5.1726557476257;
        Tue, 17 Sep 2024 00:17:56 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a97e6fsm4691502b3a.26.2024.09.17.00.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 00:17:55 -0700 (PDT)
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
Subject: [PATCH] drm/panel: elida-kd35t133: transition to mipi_dsi wrapped functions
Date: Tue, 17 Sep 2024 12:47:10 +0530
Message-ID: <20240917071710.1254520-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the elida-kd35t133 panel to use multi style functions for
improved error handling.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-elida-kd35t133.c | 107 ++++++++-----------
 1 file changed, 45 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index 00791ea81e90..62abda9559e7 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -50,55 +50,45 @@ static inline struct kd35t133 *panel_to_kd35t133(struct drm_panel *panel)
 	return container_of(panel, struct kd35t133, panel);
 }
 
-static int kd35t133_init_sequence(struct kd35t133 *ctx)
+static void kd35t133_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	struct device *dev = ctx->dev;
-
 	/*
 	 * Init sequence was supplied by the panel vendor with minimal
 	 * documentation.
 	 */
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
-			       0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
-			       0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
-			       0x00, 0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
-			       0x4d, 0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
-			       0x20, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
-			       0xa9, 0x51, 0x2c, 0x82);
-	mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);
-
-	dev_dbg(dev, "Panel init sequence done\n");
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POSITIVEGAMMA,
+				     0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
+				     0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_NEGATIVEGAMMA,
+				     0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
+				     0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POWERCONTROL2, 0x41);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_FRAMERATECTRL, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
+				     0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_ADJUSTCONTROL3,
+				     0x51, 0x2c, 0x82);
+	if (!dsi_ctx->accum_err)
+		mipi_dsi_dcs_write(dsi_ctx->dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);
 }
 
 static int kd35t133_unprepare(struct drm_panel *panel)
 {
 	struct kd35t133 *ctx = panel_to_kd35t133(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		dev_err(ctx->dev, "failed to set display off: %d\n", ret);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 
@@ -112,18 +102,20 @@ static int kd35t133_prepare(struct drm_panel *panel)
 {
 	struct kd35t133 *ctx = panel_to_kd35t133(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dev_dbg(ctx->dev, "Resetting the panel\n");
-	ret = regulator_enable(ctx->vdd);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to enable vdd supply: %d\n", ret);
-		return ret;
+	dsi_ctx.accum_err = regulator_enable(ctx->vdd);
+	if (dsi_ctx.accum_err) {
+		dev_err(ctx->dev, "Failed to enable vdd supply: %d\n",
+			dsi_ctx.accum_err);
+		return dsi_ctx.accum_err;
 	}
 
-	ret = regulator_enable(ctx->iovcc);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
+	dsi_ctx.accum_err = regulator_enable(ctx->iovcc);
+	if (dsi_ctx.accum_err) {
+		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n",
+			dsi_ctx.accum_err);
 		goto disable_vdd;
 	}
 
@@ -135,25 +127,16 @@ static int kd35t133_prepare(struct drm_panel *panel)
 
 	msleep(20);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
-		goto disable_iovcc;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 250);
 
-	msleep(250);
+	kd35t133_init_sequence(&dsi_ctx);
+	if (!dsi_ctx.accum_err)
+		dev_dbg(ctx->dev, "Panel init sequence done\n");
 
-	ret = kd35t133_init_sequence(ctx);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
 		goto disable_iovcc;
-	}
-
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to set display on: %d\n", ret);
-		goto disable_iovcc;
-	}
 
 	msleep(50);
 
@@ -163,7 +146,7 @@ static int kd35t133_prepare(struct drm_panel *panel)
 	regulator_disable(ctx->iovcc);
 disable_vdd:
 	regulator_disable(ctx->vdd);
-	return ret;
+	return dsi_ctx.accum_err;
 }
 
 static const struct drm_display_mode default_mode = {
-- 
2.46.0


