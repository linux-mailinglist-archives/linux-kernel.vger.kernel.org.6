Return-Path: <linux-kernel+bounces-568590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D070EA69811
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8778D3B2882
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5244420AF67;
	Wed, 19 Mar 2025 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwRP76ys"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35711ACEAC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409085; cv=none; b=JYPtAL4saMRLYVA/R/OdISNl0oEIVWTze6ZIa09jkY6ozOUlF8xX4UG6y4UFP56Og4ChgshSyvI6gE4bblHdieTtFSIwGGqi8OBeKmebwuACD1v7LIVcp4Dw/cpc1jvfR8ZoaWBE44GivOU2h1VbANYZdKVp3DamkmkVc66paLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409085; c=relaxed/simple;
	bh=dH0JG4CpLjwAZdV29UH5Pq7vsS7wQbo+IpgGVOW9e/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwN+PN3hXZ2VTCeqW58OBunYffBdy66gHoDPqJgDctXr/+qplyD4oUWHxFVojpV5B7gTkKlf5GcFdBvYYJq7iRDySn6uOst4rKunDgzofM2ZpGelZyp14uZNVyIkOO7yXe0FLYTSQoNsn0f0SrP4ivUnkbzAgCLs5LObrIwEOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwRP76ys; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso5706137a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742409083; x=1743013883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8k6E0SBMJu3+sqsRyfC0ebK6LVVCZ5JuEe2gAlutts0=;
        b=HwRP76ysaH4JRLPULLao/HtBP0FdSP5UDwli+U8GSpc8DlMLPII6520szPt5H97SDT
         UWUv48XG88mGhgkVCv3FroKCidXvGtvNBypby0k1YbrqqotMudymO0DGK462UlskakJ8
         UTVHAHAS+vOPJrjQt+VCXKajVcx9WB90pzwIj1uhIF9q3ig+eU19p434J+NfvJie6yLW
         4f56Nwt6oFK64MZwV9dTilpBdhh3zJ1hHwdRb/oCsXLSpwestkEGS8kxZBFk+FSFGDNC
         wPoUAr6xQ9fOsEFM4B2I0AOe9AbQxBaIvtRML3ynRvZJ/XAqM2rRS0sSuB63W7PsAik1
         pjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409083; x=1743013883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k6E0SBMJu3+sqsRyfC0ebK6LVVCZ5JuEe2gAlutts0=;
        b=m+VW+YNYnyRk+Q1EDA5g0u3TVpH6Qyi3aGTto5r1RivpJoW21+3vAnUzk3aIs2GVoO
         lBBw1X3Mc6IN7QwXHURUGXE8a26Z39Gfke6MRd+hVEByZNFiHN0N/aTWG0gYPsXSRp91
         K/O4cAtyFNTYM5TBDmhuJrBaSV8/TACUeG0OUqNvKXqDZxoomf2QTkei0TsUx/N76ivb
         PdUyeuNdqeTRvn6PWHlHmLqK8FKt5arsQFZ4pWFmLbJ2LE+7w3XPy2wQOLXrRcooh08X
         SjYxoUc4vBPVuNG0eG4TutaWUiKqpxSC9i9M0Rlq1zueu00pSsR1yoLSuNHuJhkplRBM
         Rkxg==
X-Forwarded-Encrypted: i=1; AJvYcCWmL0Ld+0RhA+S/Jlp+c8WU7C6hwVycO3Qhd4SXABqbXRWr35WyGdp3RXd1tCxxNbpmZLqIUJOddvGxtrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTRRA4KsIBJlJp1caiEHa/8ioZ9gpy4yVMjF1gxLaANVhIP3b
	MeEf2ukkj08qwibEvLv15b7hEkq7BIjLS4Gvz63KNm/uYJDrZpdK
X-Gm-Gg: ASbGncs7Sdk5J7FQ1y5SaqV91aJ+vDCkB3i5JnqiuTjMqss52JR/Jx8JkGDNsCyI2u4
	J6+wnL/xf1y3TFrWrV0czjhxEfmZA+MJTRaRby4w2zIJqI66e8PiGzd15u1YPEyRqsfMq/NgX+s
	+kKw2+Sq7epzBWybgPICIEA83p6M/qYFjXfBmKOfEVUDXg1VODH1JbNohdg5aF0RCEXRu+5r5vm
	sx429WR6HYD5ztCq6Xrdq62aGDe1Me21ExcEYXt4a+JXVq2OsnaKtwPW7IQuGJC0VQnKeuW9lZS
	l4FUjwOIbwTdHRMzHZmcr71uRXVVTadSfHa7bWJhQq4MKRN1rG1U8RPxk8ee+qPw
X-Google-Smtp-Source: AGHT+IHYfTCmFqbs+qDm3BvqWkp57qcljfbUjjyj12xeCA0T3RI3cSHuRg+q+GC5f7TR/rYpyh5MoA==
X-Received: by 2002:a17:90b:3d07:b0:2fa:15ab:4de7 with SMTP id 98e67ed59e1d1-301bde7397cmr7592138a91.12.1742409082762;
        Wed, 19 Mar 2025 11:31:22 -0700 (PDT)
Received: from distilledx.SRMIST.EDU.IN ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61b525sm1978422a91.35.2025.03.19.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:31:22 -0700 (PDT)
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
Subject: [PATCH v2] drm/panel: samsung-s6d7aa0: transition to mipi_dsi wrapped functions
Date: Thu, 20 Mar 2025 00:01:06 +0530
Message-ID: <20250319183106.12613-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.49.0
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
Changes in v2:
    - Remove unnecessary early return in s6d7aa0_lock
    - Remove redundant GPIO reset setting in s6d7aa0_on.

Link to v1: https://lore.kernel.org/all/20250316045024.672167-1-tejasvipin76@gmail.com/
---
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 222 +++++-------------
 1 file changed, 65 insertions(+), 157 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
index f23d8832a1ad..9d219809ce38 100644
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
@@ -62,93 +62,61 @@ static void s6d7aa0_reset(struct s6d7aa0 *ctx)
 	msleep(50);
 }
 
-static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
+static void s6d7aa0_lock(struct s6d7aa0 *ctx, struct mipi_dsi_multi_context *dsi_ctx, bool lock)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-
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
-		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-		return ret;
-	}
+	ctx->desc->init_func(ctx, &dsi_ctx);
 
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
@@ -159,12 +127,8 @@ static int s6d7aa0_prepare(struct drm_panel *panel)
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
@@ -185,13 +149,11 @@ static int s6d7aa0_bl_update_status(struct backlight_device *bl)
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
@@ -228,65 +190,39 @@ s6d7aa0_create_backlight(struct mipi_dsi_device *dsi)
 
 /* Initialization code and structures for LSL080AL02 panel */
 
-static int s6d7aa0_lsl080al02_init(struct s6d7aa0 *ctx)
+static void s6d7aa0_lsl080al02_init(struct s6d7aa0 *ctx, struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	mipi_dsi_usleep_range(dsi_ctx, 20000, 25000);
 
-	usleep_range(20000, 25000);
+	s6d7aa0_lock(ctx, dsi_ctx, false);
 
-	ret = s6d7aa0_lock(ctx, false);
-	if (ret < 0) {
-		dev_err(dev, "Failed to unlock registers: %d\n", ret);
-		return ret;
-	}
-
-	mipi_dsi_dcs_write_seq(dsi, MCS_OTP_RELOAD, 0x00, 0x10);
-	usleep_range(1000, 1500);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_OTP_RELOAD, 0x00, 0x10);
+	mipi_dsi_usleep_range(dsi_ctx, 1000, 1500);
 
 	/* SEQ_B6_PARAM_8_R01 */
-	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x10);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb6, 0x10);
 
 	/* BL_CTL_ON */
-	mipi_dsi_dcs_write_seq(dsi, MCS_BL_CTL, 0x40, 0x00, 0x28);
-
-	usleep_range(5000, 6000);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MCS_BL_CTL, 0x40, 0x00, 0x28);
 
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x04);
+	mipi_dsi_usleep_range(dsi_ctx, 5000, 6000);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x04);
 
-	msleep(120);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
+	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
 
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
@@ -317,79 +253,51 @@ static const struct s6d7aa0_panel_desc s6d7aa0_lsl080al02_desc = {
 
 /* Initialization code and structures for LSL080AL03 panel */
 
-static int s6d7aa0_lsl080al03_init(struct s6d7aa0 *ctx)
+static void s6d7aa0_lsl080al03_init(struct s6d7aa0 *ctx, struct mipi_dsi_multi_context *dsi_ctx)
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
-
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc1, 0x03);
 
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


