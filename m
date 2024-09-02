Return-Path: <linux-kernel+bounces-310690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D2A96802D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6182815B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA3F183092;
	Mon,  2 Sep 2024 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caYn/wB4"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229615C140
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261046; cv=none; b=SA2AAKt4CjFkppSdjLWyBJINCUmmlwyeCdBG6KmU6g3J9FXr+yZB7pj2PyuMUR6ox83d40t7o18v1ZHUSRf1wOVtv4hb3XBS9qq8tr1M80Ouo6G+dfYHjOWKxmcuRdzaQ6H3HQoJsVBHf4YyChbfw4gCKRgROonzSKueErobg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261046; c=relaxed/simple;
	bh=ep7ynCvlTSoE0xCdV0XxmQntHu6FOEEIhf1yFNatyxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+KUGPeZFsD1OAmucZWyNKcKrdP7Me8Fe21nLGqLY3QZJ633iuxqzqOj4VnpJKoEN0IKhWRok74/KqBl4aPvyrbNpXpEVyR5sll8S77I9tkjz9ta5TL7ysXeOHYbzWIxVe4A2K/5h+EGMPWI/IyX0P3JJ2XmWD7m7OP+Kj0/XPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caYn/wB4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso2734734a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 00:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725261044; x=1725865844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TOY94K2Mh0IapSjH2sQrQvMt6OsnaIbHwlnnud6QQKk=;
        b=caYn/wB46rNdBB3N+uL0zMoUzDzhzcbR2dAux+nOv7FE/apnshp/RfZVjw6yrJ1PPr
         WzpQam2uXx8xyf9yEhijRahvYnRT9YrbNKEpNzf5Ekq6+nuiqmL+RyQW+Jrzmv3PAp51
         haLtFiIAWINaG3pUIQEsJGYHLQfm6PX22wGgk5/FxPq8OxCbJbCSlxwkzn6aGtW8GUwZ
         9sZ5wCQiJdBBKaJq3xR6jghjiEEwsb3P2IaFv1qlmnHX+aLR385g3lKsXsrId3N1zJTY
         HUvOGbl1MSDElyVuGmMluZW40p9fS79Ss9Vg/4cmfIJw8afmSYX9lgjSCRmROeQ0pI1S
         lJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725261044; x=1725865844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOY94K2Mh0IapSjH2sQrQvMt6OsnaIbHwlnnud6QQKk=;
        b=V2dR2egFsJMlFoA/cLJDSraO+RE/bLzMqjfEINV/1fPNxxQYPC5p9UuVlHCGbPyO84
         0NrMJOhPJlA1G5x+xwWiChGBhT+Q79siAKqJWwZMGquI1Vf0o0vQySdTgyOyh5ZDaP9k
         oNoggsaW0fS0YXAyTuajzK3qSvl4UUHMtzYCQOcaKDgwTRRMhHDGwdj0k4wm7JMIQfvu
         jM+m46xDxBgEZGlsUn6boA7mIskvWpKNnwhjiKmZ6ic2Tl8V1NMKmtbvnfLLjrKkmSNM
         BG2/ZHVwRiBC490EcXfnthiM3ePWYBwN44+pZSzxS3uI56TqPzSO/5EU4hczyjhl4Kf0
         eErg==
X-Forwarded-Encrypted: i=1; AJvYcCVjVtoDKpAxgiRez3FmptzjH3skZxegx2bfR+axEP3fyZ7JnOzSPxQIx/kYhxr6pT1PCn2oy26zJhocanE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrCusUBMSNa2G6D4zqJkHSUTZ7GwTzffZ64C1bt7EVhMbcvq9
	K+Xs0aQaQX/7DPVLV40ZelpEfUIUj5w2f/bV3Joi7i4XbYoR/DJW
X-Google-Smtp-Source: AGHT+IEmw6q1DRvrefSp2AkZbs1EPDuMAj9FZdiWBHNEwdE+ma3GuHFZcwpYEjBuAoI+krAogHJqpg==
X-Received: by 2002:a17:90a:4b85:b0:2cf:7388:ad9e with SMTP id 98e67ed59e1d1-2d85616eccamr14325219a91.2.1725261043981;
        Mon, 02 Sep 2024 00:10:43 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([2401:4900:6344:e783:1e00:4325:ad65:51fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8818feacesm5299674a91.30.2024.09.02.00.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 00:10:43 -0700 (PDT)
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
Subject: [PATCH] drm/panel: samsung-s6e3fa7: transition to mipi_dsi wrapped functions
Date: Mon,  2 Sep 2024 12:40:19 +0530
Message-ID: <20240902071019.351158-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the samsung-s6e3fa7 panel to use multi style functions for
improved error handling.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c | 71 ++++++-------------
 1 file changed, 21 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c b/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c
index 10bc8fb5f1f9..27a059b55ae5 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c
@@ -38,57 +38,38 @@ static void s6e3fa7_panel_reset(struct s6e3fa7_panel *ctx)
 	usleep_range(10000, 11000);
 }
 
-static int s6e3fa7_panel_on(struct s6e3fa7_panel *ctx)
+static int s6e3fa7_panel_on(struct mipi_dsi_device *dsi)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(120);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 
-	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear on: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf4,
+				     0xbb, 0x23, 0x19, 0x3a, 0x9f, 0x0f, 0x09, 0xc0,
+				     0x00, 0xb4, 0x37, 0x70, 0x79, 0x69);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
 
-	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
-	mipi_dsi_dcs_write_seq(dsi, 0xf4,
-			       0xbb, 0x23, 0x19, 0x3a, 0x9f, 0x0f, 0x09, 0xc0,
-			       0x00, 0xb4, 0x37, 0x70, 0x79, 0x69);
-	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int s6e3fa7_panel_prepare(struct drm_panel *panel)
 {
 	struct s6e3fa7_panel *ctx = to_s6e3fa7_panel(panel);
-	struct device *dev = &ctx->dsi->dev;
 	int ret;
 
 	s6e3fa7_panel_reset(ctx);
 
-	ret = s6e3fa7_panel_on(ctx);
-	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+	ret = s6e3fa7_panel_on(ctx->dsi);
+	if (ret < 0)
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int s6e3fa7_panel_unprepare(struct drm_panel *panel)
@@ -104,23 +85,13 @@ static int s6e3fa7_panel_disable(struct drm_panel *panel)
 {
 	struct s6e3fa7_panel *ctx = to_s6e3fa7_panel(panel);
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(120);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static const struct drm_display_mode s6e3fa7_panel_mode = {
-- 
2.46.0


