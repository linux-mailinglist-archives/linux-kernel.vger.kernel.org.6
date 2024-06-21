Return-Path: <linux-kernel+bounces-224753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9AD91267F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DE41C2134B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266201EA80;
	Fri, 21 Jun 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McZKMvIX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE8EEDC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975841; cv=none; b=Xas8cQqrZSOoDAEyCfwway6mkRfPMxDUbD8d8Iz/Tg819JHzWVaM+Tye/vTVApgqqPfUyAVntkq6vmcscmDB6rSjRaypx21RBIYN9Fqi87Aez24l97vZm0l6X8Jn3xlGAA+5Wc2VDJd3So4iZju9C+oviGhBRLijF2D3IqV7JdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975841; c=relaxed/simple;
	bh=hLcOFwi2J2KZcT+28pyhB884XMs4WErv3F9SncFRe8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWrrNv29fv39fueIVM+h2Zojq9zBH7Cm41VQJ1+B/NgPKu8566l9r/eU04X3c4tv6xphrFj1kHS2BFLXHpp80FiRGqmeoDtiFwWQIl8QWlrxNqm1L1cDJQ7+zEtTml2l6tmlzb8zs9d3eYA46JV12mwINJ+sAfHAE8Cn4rXMkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McZKMvIX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f9885d5c04so17912285ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718975839; x=1719580639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q8Jo6W/oSNP8jr6rmsVk9Fz1TTt99fPqwc+b/r8xVV4=;
        b=McZKMvIXSIuQZWM97AlVgnhs/ybp3DGH+cEQWXP/qwBgctCcrXIRam4lxrmFYu0F9a
         eUk43VwBC6VLWkva7yy7zYBDZewsCAV9Cwd1T1uL86otNfZJXAtYxHozVsbaSU7XbTZh
         hbk1KnkCe6DJ7afwhJeLfBisWHPPKm1oHJtFVIrcB6iNu96ApGMOmAhdx+Ou6Maz5TbC
         a/ed/owIwvu2nmy6F59nnmgCr8XM/519o4UvBom06+3yIcDXfKYGhjLwSCvPEpG9ULiK
         PnvCeHfONh9DI8aPnq/ZSk3ygo85853b4g+1T+PICrfCHfGg8o5W5aWvDk7Er58JuCRl
         ocIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718975839; x=1719580639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8Jo6W/oSNP8jr6rmsVk9Fz1TTt99fPqwc+b/r8xVV4=;
        b=pLEBtzuyGV7z0g/qGqFiLzrYgQ/qNhZ7+EA/sy8axgvIM111bxnAetTR+nzBxzIOnR
         5CykpXnSrb/tL5ppG1g7wPlE1PHstN9EqR/b1O072m4evIJo74DNobhgRMEcT5qYvMjk
         6WM6ZjzlR/jecFzBJ7ce2ILetsULmiuCw/uHUDQwIGXMxX0E4R6ukc8jjzsaf8sPMaj/
         TQJiuYjHbjCjrxcRaXvpcCa+bhgbXr4klnEihR85NPHnQji4HC5YuKBre5JM4aQWP4/F
         vdF7dKh67LHyxhtNkaf7OhrDTv1z3v49zCKAJBeocEzueHwfc5yVfNiJDDvZVIs0UR8o
         hz0g==
X-Forwarded-Encrypted: i=1; AJvYcCWuP76tHYj1ZZRNgO0CyvIwyTbgok8C/MZPUi63//xKhFKnJ+SA0lpGoBnoT03VcqAy5p3TFDlIOmSIEFdEskVDqH0OW4pmBmpbBWa2
X-Gm-Message-State: AOJu0YwzYZi0s2KyMWT+kuO79tUoa5WsjuMQ/1nVfQaw+kXFLWAEoeIg
	vSDyNaEErh2uSHtvlwNa8knGfpaJ5rAX6S4SDN1ppFyrTy9HMVCv
X-Google-Smtp-Source: AGHT+IH/ujlQpjyJpVOol708EAJiossfwncho/7eSVf/kW6J8Bt8687f96NhgOmOJu8sQGHkNYB4Qw==
X-Received: by 2002:a17:902:d482:b0:1f8:3c9e:3b92 with SMTP id d9443c01a7336-1f9aa3dd710mr102086615ad.23.1718975838796;
        Fri, 21 Jun 2024 06:17:18 -0700 (PDT)
Received: from distilledx.localdomain ([122.172.87.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f030csm13804045ad.43.2024.06.21.06.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:17:18 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: Tejas Vipin <tejasvipin76@gmail.com>,
	dianders@chromium.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: asus-z00t-tm5p5-n35596: transition to mipi_dsi wrapped functions
Date: Fri, 21 Jun 2024 18:46:46 +0530
Message-ID: <20240621131648.131667-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi:
Introduce mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
("drm/mipi-dsi: wrap more functions for streamline handling") for the
asus-z00t-tm5p5-n35596 panel.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  | 140 ++++++++----------
 1 file changed, 59 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
index bcaa63d1955f..b05a663c134c 100644
--- a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
+++ b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
@@ -33,119 +33,97 @@ static void tm5p5_nt35596_reset(struct tm5p5_nt35596 *ctx)
 	usleep_range(15000, 16000);
 }
 
-static int tm5p5_nt35596_on(struct tm5p5_nt35596 *ctx)
+static void tm5p5_nt35596_on(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-
-	mipi_dsi_generic_write_seq(dsi, 0xff, 0x05);
-	mipi_dsi_generic_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xc5, 0x31);
-	mipi_dsi_generic_write_seq(dsi, 0xff, 0x04);
-	mipi_dsi_generic_write_seq(dsi, 0x01, 0x84);
-	mipi_dsi_generic_write_seq(dsi, 0x05, 0x25);
-	mipi_dsi_generic_write_seq(dsi, 0x06, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0x07, 0x20);
-	mipi_dsi_generic_write_seq(dsi, 0x08, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0x09, 0x08);
-	mipi_dsi_generic_write_seq(dsi, 0x0a, 0x10);
-	mipi_dsi_generic_write_seq(dsi, 0x0b, 0x10);
-	mipi_dsi_generic_write_seq(dsi, 0x0c, 0x10);
-	mipi_dsi_generic_write_seq(dsi, 0x0d, 0x14);
-	mipi_dsi_generic_write_seq(dsi, 0x0e, 0x14);
-	mipi_dsi_generic_write_seq(dsi, 0x0f, 0x14);
-	mipi_dsi_generic_write_seq(dsi, 0x10, 0x14);
-	mipi_dsi_generic_write_seq(dsi, 0x11, 0x14);
-	mipi_dsi_generic_write_seq(dsi, 0x12, 0x14);
-	mipi_dsi_generic_write_seq(dsi, 0x17, 0xf3);
-	mipi_dsi_generic_write_seq(dsi, 0x18, 0xc0);
-	mipi_dsi_generic_write_seq(dsi, 0x19, 0xc0);
-	mipi_dsi_generic_write_seq(dsi, 0x1a, 0xc0);
-	mipi_dsi_generic_write_seq(dsi, 0x1b, 0xb3);
-	mipi_dsi_generic_write_seq(dsi, 0x1c, 0xb3);
-	mipi_dsi_generic_write_seq(dsi, 0x1d, 0xb3);
-	mipi_dsi_generic_write_seq(dsi, 0x1e, 0xb3);
-	mipi_dsi_generic_write_seq(dsi, 0x1f, 0xb3);
-	mipi_dsi_generic_write_seq(dsi, 0x20, 0xb3);
-	mipi_dsi_generic_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xff, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xfb, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0x35, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xd3, 0x06);
-	mipi_dsi_generic_write_seq(dsi, 0xd4, 0x04);
-	mipi_dsi_generic_write_seq(dsi, 0x5e, 0x0d);
-	mipi_dsi_generic_write_seq(dsi, 0x11, 0x00);
-	msleep(100);
-	mipi_dsi_generic_write_seq(dsi, 0x29, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0x53, 0x24);
-
-	return 0;
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xff, 0x05);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfb, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc5, 0x31);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xff, 0x04);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x01, 0x84);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x05, 0x25);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x06, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x07, 0x20);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x08, 0x06);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x09, 0x08);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0a, 0x10);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0b, 0x10);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0c, 0x10);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0d, 0x14);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0e, 0x14);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0f, 0x14);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x10, 0x14);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x11, 0x14);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x12, 0x14);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x17, 0xf3);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0xc0);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x19, 0xc0);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1a, 0xc0);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1b, 0xb3);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1c, 0xb3);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1d, 0xb3);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1e, 0xb3);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1f, 0xb3);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x20, 0xb3);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfb, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xff, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfb, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x35, 0x01);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd3, 0x06);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd4, 0x04);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x5e, 0x0d);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x11, 0x00);
+
+	mipi_dsi_msleep(dsi_ctx, 100);
+
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x29, 0x00);
+	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x53, 0x24);
 }
 
-static int tm5p5_nt35596_off(struct tm5p5_nt35596 *ctx)
+static void tm5p5_nt35596_off(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
-	msleep(60);
+	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_msleep(dsi_ctx, 60);
 
-	mipi_dsi_dcs_write_seq(dsi, 0x4f, 0x01);
+	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
 
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x4f, 0x01);
 }
 
 static int tm5p5_nt35596_prepare(struct drm_panel *panel)
 {
 	struct tm5p5_nt35596 *ctx = to_tm5p5_nt35596(panel);
-	struct device *dev = &ctx->dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx =	{.dsi = ctx->dsi};
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable regulators: %d\n", ret);
-		return ret;
-	}
+	dsi_ctx.accum_err = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	tm5p5_nt35596_reset(ctx);
 
-	ret = tm5p5_nt35596_on(ctx);
-	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+	tm5p5_nt35596_on(&dsi_ctx);
+
+	if (dsi_ctx.accum_err) {
 		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies),
 				       ctx->supplies);
-		return ret;
 	}
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int tm5p5_nt35596_unprepare(struct drm_panel *panel)
 {
 	struct tm5p5_nt35596 *ctx = to_tm5p5_nt35596(panel);
-	struct device *dev = &ctx->dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx =	{.dsi = ctx->dsi};
 
-	ret = tm5p5_nt35596_off(ctx);
-	if (ret < 0)
-		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+	tm5p5_nt35596_off(&dsi_ctx);
 
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies),
 			       ctx->supplies);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static const struct drm_display_mode tm5p5_nt35596_mode = {
-- 
2.45.2


