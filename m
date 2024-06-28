Return-Path: <linux-kernel+bounces-234350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CA091C57F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FA41B24C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAD01C8FA8;
	Fri, 28 Jun 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAcnE1zx"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E0A25634
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598372; cv=none; b=QOq6pJZbvO8aihJ1HMexd5szMxTpuksLQ6FgBovbmKOSiqhZ67TE4sBfsS1mP5kmgDEHbSi/tZaxOZuNZy1MgqtCdXIxSHHxGdWsdrfHuBwEDx4/9W8Rep4Zw4Vg2bkjnZGxOiqqPrKKDqU8M3j5867J6kcJq87ALxUf3/EKfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598372; c=relaxed/simple;
	bh=hLcOFwi2J2KZcT+28pyhB884XMs4WErv3F9SncFRe8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPEtipm2HMuQAAXzH/MwojO6svJJ0yfJCv76zTycPoIA6oOGPP5pCN9opmHk0rhc1pCoK7lxHdVu9rA9hFzk7niw1bQ0JjSYOn3QsO5+ctv1aEYlcamB9/k4p2Uc77bGXlfK3lZ/uifpc0/o5GBxjeiio6ugeRu2IEFE8P/cYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAcnE1zx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-706a1711ee5so644849b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598371; x=1720203171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8Jo6W/oSNP8jr6rmsVk9Fz1TTt99fPqwc+b/r8xVV4=;
        b=LAcnE1zxCGk5h3WbsBePz0qfZKde6Z4niY8+SHcfAUMwN1PvwDIvzcsK15CqZ4pzHd
         X7HRdflo5DbaBkn+xWzEYqrVKMQ1/Bu2lcHjd2kP4qhbW7R972pmPVp6iUi7m+4uoYnm
         haryFqM4IznrVXBydeTNlh10lWE9cKT6/K+78CRw2eRB5+dZ1eqaodwfJ3ubKxhsEY1s
         i70QXlHXSdVtSadLsnTKThW8iZxHbEih5urVaKt1nfaj439xrTpbKN8x7thlYe9kvtEh
         XIhhwYemTJ9RzYWtp4I7aTiKOou6QafSvlLiNzRHveFtyeqdHOfi8vTGLwxNh1SjS/DM
         frdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598371; x=1720203171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8Jo6W/oSNP8jr6rmsVk9Fz1TTt99fPqwc+b/r8xVV4=;
        b=UYMewcQ+TI+jzHodu0q87TTlHPCHl4VTf6uB1kot/2yVsbBBEWd4g2tjLq4iFalbfn
         vveHEbo29eQ5sqvSMoV8ebQ+YWfCviXiju5//+J1NXlmbo+yEnaAaT3nXraWyB5ssPee
         8ITgQBlj1gEiQZnAqvJ7kG0p2urs+UjTd3iLvB/3xsOGku92CsIIauyZkbGyS+6+SncZ
         6siSo8kAU8K/smL4vdmqTH9w7QhI65IapRDfc/bEMOqT/7Kwft6TkN03YHkIcYA0I6H9
         IbxxSVXYeIhskMqaFQ9wy0MaVXDQ6+GZ1NzIslXwNp848deMaRr6cwF0MwnT7lmZaXzM
         P9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpmPW8MxyWRzbjP8fuak1uBTIFQmlezPAuOt14mFADLfwh+WfrNya+k1rN1NnyYNvbJG92sSkY5RDQmUwHmm5LcstzpT8ipSYyJxsZ
X-Gm-Message-State: AOJu0YySxalxGbTm/iS2mjA2ypXpKUSOh+xSS/YWEvTMddChsBVBMh91
	F0bn+38FGwljiQUuDL99e6gMt/JSvjxQMc+G+6yEzPUKGjB5vYlFpkztVA==
X-Google-Smtp-Source: AGHT+IF3AjHxyLKw/pfm6Tp0dYJXbY0D7ipNfh1LjJnjgv4OthC3bqatVYyRUQTKQR31MgPFGEPKnA==
X-Received: by 2002:a05:6a00:2d2:b0:704:2b6e:f10b with SMTP id d2e1a72fcca58-706745d6c9dmr14857451b3a.15.1719598370562;
        Fri, 28 Jun 2024 11:12:50 -0700 (PDT)
Received: from distilledx.localdomain ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f5asm1926960b3a.195.2024.06.28.11.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:12:50 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: tejasvipin76@gmail.com,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: dianders@chromium.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: asus-z00t-tm5p5-n35596: transition to mipi_dsi wrapped functions
Date: Fri, 28 Jun 2024 23:42:38 +0530
Message-ID: <20240628181238.169681-4-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628181238.169681-1-tejasvipin76@gmail.com>
References: <20240628181238.169681-1-tejasvipin76@gmail.com>
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


