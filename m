Return-Path: <linux-kernel+bounces-562876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD67A63411
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 05:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F322C3B0BB0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 04:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1B148FF9;
	Sun, 16 Mar 2025 04:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OX/c5puv"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC818B0F
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742100648; cv=none; b=eSa49fE3zz9HG35kmZ60fZJJBpq0+y+iWBBeQT55iTBjykT+KIrP8qCswk/sJK+e1aWZ/H48nryixk1/Jyd4t+pe0ErsQrA44+Wi0jvezVEqyqK7KbgQ7Cx5OOPjFdUGrq+OrUil+Kx7gY9xZIwaySdVvusvY9+JJXwqDY9Co6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742100648; c=relaxed/simple;
	bh=5lNEGphn4E7KI1eiDQAVdZ1/8DahGEECiewjLvkHpOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqGhHlGzpEL/EUxb9QhXfKjrIbxkOqUjQd2fEKVSeah0llktOZnk7p0nQ5UmvUWX2JYIrTQIv4k8nVpumQfuqvt8deYq7B1kXvgmJTSLH3ro6J1ACZDNArBCPm8QZTUvKKX6yaHOGK+U0O2qgTt/wkpxRV9atvKy0wH/NusxmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OX/c5puv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225d66a4839so38876675ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 21:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742100646; x=1742705446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q66nfil3m+uWhgZ5FFwnyHNnX7SmSdFtJPXyVwhg0bM=;
        b=OX/c5puvi7FIPsYikua+FbqEEgHwBlshwJjwh/Ik9MxQ5aA5AtAoBKchpdadpS7fEw
         A6gC/2+4PAhzLYxqX3RkvY3/ybcYYI3JuRM0N+x9DS8J4fztLju7Kp192QaxcBJWrOc/
         JichvEMYbusTUWk1K+tROsBTupOYY1XDFnNflf3K42kDuiUj8fARRU7Bb3wPmp/CJ+0R
         8S/xqx9K9VZC83mYw8rxlg6SBtH7kXWJtcXgLv5U0/YttD8ID6ef1u4Vf143D8lo1pnJ
         1vGqGP/kPq+qdWXkLWTRXwZO7EMEuFEtWwT18v4GcozQ7rMmCLujT8vjyDlSpS80Axoa
         k+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742100646; x=1742705446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q66nfil3m+uWhgZ5FFwnyHNnX7SmSdFtJPXyVwhg0bM=;
        b=pWHYild43n2H/Ar+Y5vi5mB1nfQvUmambutVqucrNPIBD/JboSonjKWAniIgLucRTN
         T9CgRgKYMDwuWrA1qA63XVG+UsueMMH7iqRpLgxnsRxAnfE5sYUm7FS9sKx5zrqL9E2A
         v45gX4DLYcvIPjsh0s5CL60u8iLiusDIQYswbuP5QHs8c1VdYSmAgNriUZ2dhBjg4YUI
         fgIrPHmnseZwaC5JayF0hjgtVt0y4Pwho6lq0g6baS6H7waQto6UMO8iWvS6hW4G6lYI
         MDhvgKPzUr4DR9osRNd5dhjf5dLs4m51Za0+gJNqYIKhEC/i2szb0rwY/iQo4YBKH3fV
         k7kg==
X-Forwarded-Encrypted: i=1; AJvYcCXIYpob+ncdMKqbsht5hHZkzF2Rwk5VE964UsyDVHobhSCVte9wwv4iB3v/4MHdHbgUK74mhJMHSO6dcCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XKNj8l8cNrbgExICvx1WY7ScO9YK9xzelLcOghB9hEhEnBYZ
	PDUdlPXUDJ7X2+rGq2lVkHrYRwHXiGwO49W7SMK3+jxFgRxJalv2
X-Gm-Gg: ASbGnctzd3Ykafh3WVmCCYRe9E/kZI7cqGWrHlmm28qXmMbjogUS4ieEdLrRTbUQAWg
	iKQchZr8nOiMBWYJl2X9kVGGRMav7mo0yLvRNCUuV9DPitBeCs5wrAFvV273/aYTiKGYq2nKH4M
	M+qFWp9ZWaRjnobuziL2o+HK9GL7y6JjBaq+Mm/aOexcATlGrzYPdB6fHoOFOg7ZlAw7QaDSIV5
	2nwHu6RTTzRq9WlsPch/nVi3tooAOqC7tTDVly414kMSvIKbvxMBA/C97XhK/XkO35ga+0GymEJ
	3b+CrcktoR88I5OzMGY8ZUxJQeFj+5T2658g4ex09F9tMhoM2zzyJ0+iuM/SS9ys
X-Google-Smtp-Source: AGHT+IEFtj5BoDnYhim5CpEYJvAQRoz0fbg+50pd02N8rk11VkzTkxNRGS13O+w7ruzkoTNQGmgymQ==
X-Received: by 2002:a17:903:189:b0:221:8568:c00f with SMTP id d9443c01a7336-225c64097abmr157497885ad.0.1742100645530;
        Sat, 15 Mar 2025 21:50:45 -0700 (PDT)
Received: from distilledx.SRMIST.EDU.IN ([103.4.220.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba721esm51926085ad.149.2025.03.15.21.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:50:45 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	aweber.kernel@gmail.com
Cc: quic_jesszhan@quicinc.com,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	asrivats@redhat.com,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH] drm/panel: samsung-s6d7aa0: transition to mipi_dsi wrapped functions
Date: Sun, 16 Mar 2025 10:20:24 +0530
Message-ID: <20250316045024.672167-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the samsung-s6d7aa0 panel to use multi style functions for
improved error handling.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 223 ++++++------------
 1 file changed, 68 insertions(+), 155 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
index f23d8832a1ad..02b5bb1c51ef 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
@@ -34,8 +34,8 @@ struct s6d7aa0 {
 
 struct s6d7aa0_panel_desc {
 	unsigned int panel_type;
-	int (*init_func)(struct s6d7aa0 *ctx);
-	int (*off_func)(struct s6d7aa0 *ctx);
+	void (*init_func)(struct s6d7aa0 *ctx, struct mipi_dsi_multi_context *dsi_ctx);
+	void (*off_func)(struct mipi_dsi_multi_context *dsi_ctx);
 	const struct drm_display_mode *drm_mode;
 	unsigned long mode_flags;
 	u32 bus_flags;
@@ -62,93 +62,66 @@ static void s6d7aa0_reset(struct s6d7aa0 *ctx)
 	msleep(50);
 }
 
-static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
+static void s6d7aa0_lock(struct s6d7aa0 *ctx, struct mipi_dsi_multi_context *dsi_ctx, bool lock)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
+	if (dsi_ctx->accum_err)
+		return;
 
 	if (lock) {
-		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0xa5, 0xa5);
-		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0xa5, 0xa5);
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_PASSWD1, 0xa5, 0xa5);
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_PASSWD2, 0xa5, 0xa5);
 		if (ctx->desc->use_passwd3)
-			mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0x5a, 0x5a);
+			mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_PASSWD3, 0x5a, 0x5a);
 	} else {
-		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD1, 0x5a, 0x5a);
-		mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD2, 0x5a, 0x5a);
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_PASSWD1, 0x5a, 0x5a);
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_PASSWD2, 0x5a, 0x5a);
 		if (ctx->desc->use_passwd3)
-			mipi_dsi_dcs_write_seq(dsi, MCS_PASSWD3, 0xa5, 0xa5);
+			mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_PASSWD3, 0xa5, 0xa5);
 	}
-
-	return 0;
 }
 
 static int s6d7aa0_on(struct s6d7aa0 *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = ctx->desc->init_func(ctx);
-	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+	ctx->desc->init_func(ctx, &dsi_ctx);
+	if (dsi_ctx.accum_err < 0)
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-		return ret;
-	}
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
-static int s6d7aa0_off(struct s6d7aa0 *ctx)
+static void s6d7aa0_off(struct s6d7aa0 *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = ctx->desc->off_func(ctx);
-	if (ret < 0) {
-		dev_err(dev, "Panel-specific off function failed: %d\n", ret);
-		return ret;
-	}
+	ctx->desc->off_func(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
-	msleep(64);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 64);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(120);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	mipi_dsi_msleep(&dsi_ctx, 120);
 }
 
 static int s6d7aa0_prepare(struct drm_panel *panel)
 {
 	struct s6d7aa0 *ctx = panel_to_s6d7aa0(panel);
-	struct device *dev = &ctx->dsi->dev;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	s6d7aa0_reset(ctx);
 
 	ret = s6d7aa0_on(ctx);
 	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 		return ret;
 	}
@@ -159,12 +132,8 @@ static int s6d7aa0_prepare(struct drm_panel *panel)
 static int s6d7aa0_disable(struct drm_panel *panel)
 {
 	struct s6d7aa0 *ctx = panel_to_s6d7aa0(panel);
-	struct device *dev = &ctx->dsi->dev;
-	int ret;
 
-	ret = s6d7aa0_off(ctx);
-	if (ret < 0)
-		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+	s6d7aa0_off(ctx);
 
 	return 0;
 }
@@ -185,13 +154,11 @@ static int s6d7aa0_bl_update_status(struct backlight_device *bl)
 {
 	struct mipi_dsi_device *dsi = bl_get_data(bl);
 	u16 brightness = backlight_get_brightness(bl);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, brightness);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int s6d7aa0_bl_get_brightness(struct backlight_device *bl)
@@ -228,65 +195,39 @@ s6d7aa0_create_backlight(struct mipi_dsi_device *dsi)
 
 /* Initialization code and structures for LSL080AL02 panel */
 
-static int s6d7aa0_lsl080al02_init(struct s6d7aa0 *ctx)
+static void s6d7aa0_lsl080al02_init(struct s6d7aa0 *ctx, struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	usleep_range(20000, 25000);
+	mipi_dsi_usleep_range(dsi_ctx, 20000, 25000);
 
-	ret = s6d7aa0_lock(ctx, false);
-	if (ret < 0) {
-		dev_err(dev, "Failed to unlock registers: %d\n", ret);
-		return ret;
-	}
+	s6d7aa0_lock(ctx, dsi_ctx, false);
 
-	mipi_dsi_dcs_write_seq(dsi, MCS_OTP_RELOAD, 0x00, 0x10);
-	usleep_range(1000, 1500);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_OTP_RELOAD, 0x00, 0x10);
+	mipi_dsi_usleep_range(dsi_ctx, 1000, 1500);
 
 	/* SEQ_B6_PARAM_8_R01 */
-	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x10);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb6, 0x10);
 
 	/* BL_CTL_ON */
-	mipi_dsi_dcs_write_seq(dsi, MCS_BL_CTL, 0x40, 0x00, 0x28);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BL_CTL, 0x40, 0x00, 0x28);
 
-	usleep_range(5000, 6000);
+	mipi_dsi_usleep_range(dsi_ctx, 5000, 6000);
 
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x04);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
 
-	msleep(120);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
-
-	ret = s6d7aa0_lock(ctx, true);
-	if (ret < 0) {
-		dev_err(dev, "Failed to lock registers: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_msleep(dsi_ctx, 120);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
+	s6d7aa0_lock(ctx, dsi_ctx, true);
 
-	return 0;
+	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
 }
 
-static int s6d7aa0_lsl080al02_off(struct s6d7aa0 *ctx)
+static void s6d7aa0_lsl080al02_off(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-
 	/* BL_CTL_OFF */
-	mipi_dsi_dcs_write_seq(dsi, MCS_BL_CTL, 0x40, 0x00, 0x20);
-
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BL_CTL, 0x40, 0x00, 0x20);
 }
 
 static const struct drm_display_mode s6d7aa0_lsl080al02_mode = {
@@ -317,79 +258,51 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080al02_desc = {
 
 /* Initialization code and structures for LSL080AL03 panel */
 
-static int s6d7aa0_lsl080al03_init(struct s6d7aa0 *ctx)
+static void s6d7aa0_lsl080al03_init(struct s6d7aa0 *ctx, struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	mipi_dsi_usleep_range(dsi_ctx, 20000, 25000);
 
-	usleep_range(20000, 25000);
-
-	ret = s6d7aa0_lock(ctx, false);
-	if (ret < 0) {
-		dev_err(dev, "Failed to unlock registers: %d\n", ret);
-		return ret;
-	}
+	s6d7aa0_lock(ctx, dsi_ctx, false);
 
 	if (ctx->desc->panel_type == S6D7AA0_PANEL_LSL080AL03) {
-		mipi_dsi_dcs_write_seq(dsi, MCS_BL_CTL, 0xc7, 0x00, 0x29);
-		mipi_dsi_dcs_write_seq(dsi, 0xbc, 0x01, 0x4e, 0xa0);
-		mipi_dsi_dcs_write_seq(dsi, 0xfd, 0x16, 0x10, 0x11, 0x23,
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BL_CTL, 0xc7, 0x00, 0x29);
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbc, 0x01, 0x4e, 0xa0);
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfd, 0x16, 0x10, 0x11, 0x23,
 				       0x09);
-		mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x00, 0x02, 0x03, 0x21,
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfe, 0x00, 0x02, 0x03, 0x21,
 				       0x80, 0x78);
 	} else if (ctx->desc->panel_type == S6D7AA0_PANEL_LTL101AT01) {
-		mipi_dsi_dcs_write_seq(dsi, MCS_BL_CTL, 0x40, 0x00, 0x08);
-		mipi_dsi_dcs_write_seq(dsi, 0xbc, 0x01, 0x4e, 0x0b);
-		mipi_dsi_dcs_write_seq(dsi, 0xfd, 0x16, 0x10, 0x11, 0x23,
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BL_CTL, 0x40, 0x00, 0x08);
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbc, 0x01, 0x4e, 0x0b);
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfd, 0x16, 0x10, 0x11, 0x23,
 				       0x09);
-		mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x00, 0x02, 0x03, 0x21,
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfe, 0x00, 0x02, 0x03, 0x21,
 				       0x80, 0x68);
 	}
 
-	mipi_dsi_dcs_write_seq(dsi, 0xb3, 0x51);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
-	mipi_dsi_dcs_write_seq(dsi, 0xf2, 0x02, 0x08, 0x08);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb3, 0x51);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf2, 0x02, 0x08, 0x08);
 
-	usleep_range(10000, 11000);
+	mipi_dsi_usleep_range(dsi_ctx, 10000, 11000);
 
-	mipi_dsi_dcs_write_seq(dsi, 0xc0, 0x80, 0x80, 0x30);
-	mipi_dsi_dcs_write_seq(dsi, 0xcd,
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc0, 0x80, 0x80, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xcd,
 			       0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e, 0x2e,
 			       0x2e, 0x2e, 0x2e, 0x2e, 0x2e);
-	mipi_dsi_dcs_write_seq(dsi, 0xce,
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xce,
 			       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			       0x00, 0x00, 0x00, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xc1, 0x03);
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-
-	ret = s6d7aa0_lock(ctx, true);
-	if (ret < 0) {
-		dev_err(dev, "Failed to lock registers: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc1, 0x03);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
+	s6d7aa0_lock(ctx, dsi_ctx, true);
+	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
 }
 
-static int s6d7aa0_lsl080al03_off(struct s6d7aa0 *ctx)
+static void s6d7aa0_lsl080al03_off(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-
-	mipi_dsi_dcs_write_seq(dsi, 0x22, 0x00);
-
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x22, 0x00);
 }
 
 static const struct drm_display_mode s6d7aa0_lsl080al03_mode = {
-- 
2.48.1


