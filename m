Return-Path: <linux-kernel+bounces-182651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B548C8DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D8BB2350B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39431428FC;
	Fri, 17 May 2024 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ds13V/0I"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7C1428ED
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981872; cv=none; b=Bk+6a7otSRFsSuvPb4ZCYQZ4FCpbsnPIMRcp82eLQplh9Ebjft1Ss1GGnaxCNGzc9ZIYzkRgi4yLtUHFUp+nTagNwXGakEmo8I6o8ZZy6rrSyfVxWSd/cJAmTdqS27CQRrVyr9FRauTLEvDc3u7Vcjw63JSz3mJlHJ3llI64u9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981872; c=relaxed/simple;
	bh=IJ0tu0n33u7l2czqvINqi/D9BsxunlVpd9Ueto7k4Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StLIoHcBXEYJzcdWD23qOUGeV9jsfkilMh0U0Stu3ll0mfMVehqW1WnjCA0wQJu0uZxtCkhTsa0ZTi7jpVN/Qr8mwt5npIXmEIv57FNXg8w0ph+w1PziKa1t3dw5U9XiUcuh7CyiqhRefoIIIJ4hoGKc4EEfV4TZG50emgBmEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ds13V/0I; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-662aeb8d157so85466a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981870; x=1716586670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Idck8NJaJ/+Vpl/CRWABV0vclOOqdIkStHcxSg1So4=;
        b=Ds13V/0Ie6IX5risax3pfabpkZamxKquwGgj733NcjdI+UoQ5nTCtW3szxp0b3pTAl
         KfZT5PPXKDKIQiQvxUMC8yM7S/MRijL9N36lbegwtI3pLXrmxcrsquH9maVgEJ1zRIMF
         EfO2xNjVr7h4ovJMn1X6WHHKMeccOGOF8ZpqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981870; x=1716586670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Idck8NJaJ/+Vpl/CRWABV0vclOOqdIkStHcxSg1So4=;
        b=lAj2FK6fuwP7AdXMSNnTJoWNBlXqrkQ++hHrzy4nN9oU6VfcGApnkgxHLecolEw90m
         3d0UONho2859qhwBMIdmhyHZJNgvNc0Fu2MNZx/caAKemsT/7dlOHND8QvUMcBYkWvaO
         2VQVaFluK9u6XQkfayz3haBOHK5p7YELPMNhUmPAsNzkVsUsPgIDfivN4qZEjAW0X++4
         pi6LwROPNprsUbvKOrqEkJrP6MELveawFDFGzzwoiWoo8xUDpKXAdu9DzfAAZwFFomMw
         lo1He5Tj8R8jys/8xUEiwCTuOb+xgD9z121287HFXK1HvkLL3cg0aQas91DzD2drmIwo
         GkwA==
X-Forwarded-Encrypted: i=1; AJvYcCWfz2NOOPCvIeGZK66MAzEe7gLhLPA3HHzkT3BAMO2pykRccoGed/oLfuS6WYvuGfP4M3YHEXSkzckmo66VfeWVaKM5B2ffC24xn3Jk
X-Gm-Message-State: AOJu0YwBaDbZxXlfSc53TLhyhOJ06mUw7pUrK0zLHse1OUv3ED4S3TVa
	2UN6a3EtM2AriDXmU9+spZ9tK3F1i3ZXfxMHZJe4CRAjCcqXx6bmzBKUo+l48w==
X-Google-Smtp-Source: AGHT+IFTf9mztHoG3W0qKI9PMVLR156uygC1Rq1UbvG0b5tcufO2fDgf17EUnFOGEMDC1IYVyFm+4g==
X-Received: by 2002:a05:6a00:14cb:b0:6f3:ea39:a56a with SMTP id d2e1a72fcca58-6f4e0299776mr26311621b3a.1.1715981870627;
        Fri, 17 May 2024 14:37:50 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:26de:b1dd:5:771c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f8b3sm15168736b3a.211.2024.05.17.14.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:37:50 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] drm/panel: himax-hx83102: use wrapped MIPI DCS functions
Date: Fri, 17 May 2024 14:36:43 -0700
Message-ID: <20240517143643.8.If761d37b5d511867ac8207fe8220ae48d444a04f@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240517213712.3135166-1-dianders@chromium.org>
References: <20240517213712.3135166-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take advantage of some of the new wrapped routines introduced by
commit f79d6d28d8fe ("drm/mipi-dsi: wrap more functions for streamline
handling") to simplify the himax-hx83102 driver a bit more. This gets
rid of some extra error prints (since the _multi functions all print
errors for you) and simplifies the code a bit.

One thing here that isn't just refactoring is that in a few places we
now check with errors with "if (err)" instead of "if (err < 0)". All
errors are expected to be negative so this is not expected to have any
impact. The _multi code internally considers anything non-zero to be
an error so this just makes things consistent.

It can also be noted that hx83102_prepare() has a mix of things that
can take advantage of _multi calls and things that can't. The cleanest
seemed to be to use the multi_ctx still but consistently use the
"accum_err" variable for error returns, though that's definitely a
style decision with pros and cons.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-himax-hx83102.c | 92 +++++++--------------
 1 file changed, 28 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 1ba623e41924..6009a3fe1b8f 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -285,12 +285,10 @@ static int boe_nv110wum_init(struct hx83102 *ctx)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
 	hx83102_enable_extended_cmds(&dsi_ctx, false);
-	if (dsi_ctx.accum_err)
-		return dsi_ctx.accum_err;
 
-	msleep(50);
+	mipi_dsi_msleep(dsi_ctx, 50);
 
-	return 0;
+	return dsi_ctx.accum_err;
 };
 
 static int ivo_t109nw41_init(struct hx83102 *ctx)
@@ -392,12 +390,10 @@ static int ivo_t109nw41_init(struct hx83102 *ctx)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
 	hx83102_enable_extended_cmds(&dsi_ctx, false);
-	if (dsi_ctx.accum_err)
-		return dsi_ctx.accum_err;
 
-	msleep(60);
+	mipi_dsi_msleep(dsi_ctx, 60);
 
-	return 0;
+	return dsi_ctx.accum_err;
 };
 
 static const struct drm_display_mode starry_mode = {
@@ -472,40 +468,20 @@ static int hx83102_enable(struct drm_panel *panel)
 	return 0;
 }
 
-static int hx83102_panel_enter_sleep_mode(struct hx83102 *ctx)
-{
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	int ret;
-
-	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		return ret;
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static int hx83102_disable(struct drm_panel *panel)
 {
 	struct hx83102 *ctx = panel_to_hx83102(panel);
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = hx83102_panel_enter_sleep_mode(ctx);
-	if (ret < 0) {
-		dev_err(dev, "failed to set panel off: %d\n", ret);
-		return ret;
-	}
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	msleep(150);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	mipi_dsi_msleep(&dsi_ctx, 150);
+
+	return dsi_ctx.accum_err;
 }
 
 static int hx83102_unprepare(struct drm_panel *panel)
@@ -526,32 +502,30 @@ static int hx83102_prepare(struct drm_panel *panel)
 {
 	struct hx83102 *ctx = panel_to_hx83102(panel);
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	gpiod_set_value(ctx->enable_gpio, 0);
 	usleep_range(1000, 1500);
 
-	ret = regulator_enable(ctx->pp1800);
-	if (ret < 0)
-		return ret;
+	dsi_ctx.accum_err = regulator_enable(ctx->pp1800);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	usleep_range(3000, 5000);
 
-	ret = regulator_enable(ctx->avdd);
-	if (ret < 0)
+	dsi_ctx.accum_err = regulator_enable(ctx->avdd);
+	if (dsi_ctx.accum_err)
 		goto poweroff1v8;
-	ret = regulator_enable(ctx->avee);
-	if (ret < 0)
+	dsi_ctx.accum_err = regulator_enable(ctx->avee);
+	if (dsi_ctx.accum_err)
 		goto poweroffavdd;
 
 	usleep_range(10000, 11000);
 
-	ret = mipi_dsi_dcs_nop(ctx->dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to send NOP: %d\n", ret);
+	mipi_dsi_dcs_nop_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
 		goto poweroff;
-	}
+
 	usleep_range(1000, 2000);
 
 	gpiod_set_value(ctx->enable_gpio, 1);
@@ -561,23 +535,13 @@ static int hx83102_prepare(struct drm_panel *panel)
 	gpiod_set_value(ctx->enable_gpio, 1);
 	usleep_range(6000, 10000);
 
-	ret = ctx->desc->init(ctx);
-	if (ret < 0)
-		goto poweroff;
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		goto poweroff;
-	}
-
-	msleep(120);
+	dsi_ctx.accum_err = ctx->desc->init(ctx);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret) {
-		dev_err(dev, "Failed to turn on the display: %d\n", ret);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
 		goto poweroff;
-	}
 
 	return 0;
 
@@ -590,7 +554,7 @@ static int hx83102_prepare(struct drm_panel *panel)
 	usleep_range(5000, 7000);
 	regulator_disable(ctx->pp1800);
 
-	return ret;
+	return dsi_ctx.accum_err;
 }
 
 static int hx83102_get_modes(struct drm_panel *panel,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


