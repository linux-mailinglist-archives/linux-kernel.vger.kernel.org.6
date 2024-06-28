Return-Path: <linux-kernel+bounces-233897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9820F91BEF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180F91F24925
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B45194AC4;
	Fri, 28 Jun 2024 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="iXueBjrU"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E25181B80
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578726; cv=none; b=YqsA4Iy846kPZ3QID57sVFSeViWVOAMt18r07aId1Mm2koS6X6Oi86wTzTslN5RvDOJ5zYBcriqILG97w6MnMd/S3pdLKtmR2rcgeVIme8ZtGB1xh9gPnBQyWrLHhzcN2oVY4BeG7P2OT0sJI+x/6oaGTTnvaqa5HMr0qLTSuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578726; c=relaxed/simple;
	bh=VqJ5khpUIxU++2oChJJZ0T61k1gPIgHgSoVO6poh39g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KYyPRHTYt9GotjJ/cI+bcWxckP0EWT9n6ai6D6zXeLoizjIlwF2ONeidxCK2d/DCmD+qP55XVmTpYetPnH2jeNEHyb+QdU4ZEqpU3uW+COeWJKxvT+NKCEmgLvjveBjUrWjXv3XpG7p3KrT9PGVADHeOh23De4u6HBZCsjX2rmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=iXueBjrU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-72b070c377aso423191a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719578719; x=1720183519; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tuDunQvtG/SUyhwA7yNBiZ77ORIPkpr9AJ7uT4xV9p4=;
        b=iXueBjrUJW0GN7WzXko43RGQUNlFf3opLDGrayG8gR+m+YkEggdwtESDlhyNB/+c7t
         m+h0s5gRb1p6KySILsT5yE3ntw3mvTQlXhozTfnTFZVrdDJZTleN49XVzZaHtzU7tQWQ
         vW+Cc3RHVKkQ8YyM9eT6RWtkjkQjuU5sRkmzak/UZinNC9dc3ByrNA2Zku2w/szsnMio
         geVn1SSXRwRz9Z0rs0WH1lOYC+BG8ragiez0HzOVqPCpyo7e+Lk/noKVpfpG0TEzISY/
         YBbUO3MBiNJPG/ofahTpsxHHLNR5CTwo70VkrhHYhdEFFAelUX7ufZ60iwwRmZ9JFESf
         GC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578719; x=1720183519;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuDunQvtG/SUyhwA7yNBiZ77ORIPkpr9AJ7uT4xV9p4=;
        b=Xz81k/yAwczq4rvYl+9leAY8mQG65P4+T1hdHuJj2Wzor4ZskpMyiineZS5du2ed/g
         CS84fwqdbuNX4IRYhHVVhoMzPIgtyeT6376YTyJ+P7V/cztbaSur9ZNF6hGIrcOYtdPw
         r8Qis/xRmU5o/W/y/m3QZRsuOM3dGaA4febpxgZgc+YJybQ8dP0BWiaqCyUIcpyntm7f
         0DbVCxxlztBd1+8Jz5Oi321lV36zNY3XNRSylHvecjC5+F3or7surC3ybahiLe9CQYRN
         PALOyClde2+4e32fDp/YWWl/we0j3sF5YDQcWmMYJhaOOjv9wvl2Cq7nPKet0Rm7En71
         4mMw==
X-Forwarded-Encrypted: i=1; AJvYcCXk6X9ol6Fi1NmMyRfHpnS6esPyVmgBjPVozTQRP+gd5A1HHuG2KXqK9nW5SQ0ku6W7z+nuKpao9XQ6mdBVUFKEhuuHU6Is8/QIklVs
X-Gm-Message-State: AOJu0Yzn28YZEbccHNz33yQ+Kjwa0H0jbqVaYkg35URJScrgtcqK9ZBl
	PIas3oBgFHY6x5Z2Z3KQ8i/v5SL5xoWz7T/3I/2ZAyuQcrBRCc0foqR8DQXmyak=
X-Google-Smtp-Source: AGHT+IHAdbigbrlcf+3AeJjYGHIdE2GN0atj1xD07/ssCJ2VGi6ClkGSR2VDV6RmNNk7IOU7i93r1Q==
X-Received: by 2002:a17:903:40d0:b0:1fa:38f4:b5d0 with SMTP id d9443c01a7336-1fac7e4c28emr22845805ad.13.1719578718814;
        Fri, 28 Jun 2024 05:45:18 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15695b4sm14346255ad.225.2024.06.28.05.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:45:18 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com,
	jagan@edgeble.ai,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v6 3/5] drm/panel: panel-jadard-jd9365da-h3: use wrapped MIPI DCS functions
Date: Fri, 28 Jun 2024 20:44:42 +0800
Message-Id: <20240628124444.28152-4-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240628124444.28152-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240628124444.28152-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
simplify driver's init/enable/exit code.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
Changes between V6 and V5:
- 1. Convert the hex in init_code from UPPERCASE to lowercase.

V4:https://lore.kernel.org/all/20240624141926.5250-4-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 793 +++++++++---------
 1 file changed, 390 insertions(+), 403 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index a9c483a7b3fa..ff232a83297f 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -19,17 +19,13 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
-#define JD9365DA_INIT_CMD_LEN		2
-
-struct jadard_init_cmd {
-	u8 data[JD9365DA_INIT_CMD_LEN];
-};
+struct jadard;
 
 struct jadard_panel_desc {
 	const struct drm_display_mode mode;
 	unsigned int lanes;
 	enum mipi_dsi_pixel_format format;
-	const struct jadard_init_cmd *init_cmds;
+	int (*init)(struct jadard *jadard);
 	u32 num_init_cmds;
 };
 
@@ -50,46 +46,33 @@ static inline struct jadard *panel_to_jadard(struct drm_panel *panel)
 
 static int jadard_enable(struct drm_panel *panel)
 {
-	struct device *dev = panel->dev;
 	struct jadard *jadard = panel_to_jadard(panel);
-	struct mipi_dsi_device *dsi = jadard->dsi;
-	int err;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 
 	msleep(120);
 
-	err = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (err < 0)
-		DRM_DEV_ERROR(dev, "failed to exit sleep mode ret = %d\n", err);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
-	err =  mipi_dsi_dcs_set_display_on(dsi);
-	if (err < 0)
-		DRM_DEV_ERROR(dev, "failed to set display on ret = %d\n", err);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int jadard_disable(struct drm_panel *panel)
 {
-	struct device *dev = panel->dev;
 	struct jadard *jadard = panel_to_jadard(panel);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(jadard->dsi);
-	if (ret < 0)
-		DRM_DEV_ERROR(dev, "failed to set display off: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(jadard->dsi);
-	if (ret < 0)
-		DRM_DEV_ERROR(dev, "failed to enter sleep mode: %d\n", ret);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int jadard_prepare(struct drm_panel *panel)
 {
 	struct jadard *jadard = panel_to_jadard(panel);
-	const struct jadard_panel_desc *desc = jadard->desc;
-	unsigned int i;
 	int ret;
 
 	ret = regulator_enable(jadard->vccio);
@@ -109,13 +92,9 @@ static int jadard_prepare(struct drm_panel *panel)
 	gpiod_set_value(jadard->reset, 1);
 	msleep(130);
 
-	for (i = 0; i < desc->num_init_cmds; i++) {
-		const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
-
-		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
-		if (ret < 0)
-			return ret;
-	}
+	ret = jadard->desc->init(jadard);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -165,176 +144,181 @@ static const struct drm_panel_funcs jadard_funcs = {
 	.get_modes = jadard_get_modes,
 };
 
-static const struct jadard_init_cmd radxa_display_8hd_ad002_init_cmds[] = {
-	{ .data = { 0xE0, 0x00 } },
-	{ .data = { 0xE1, 0x93 } },
-	{ .data = { 0xE2, 0x65 } },
-	{ .data = { 0xE3, 0xF8 } },
-	{ .data = { 0x80, 0x03 } },
-	{ .data = { 0xE0, 0x01 } },
-	{ .data = { 0x00, 0x00 } },
-	{ .data = { 0x01, 0x7E } },
-	{ .data = { 0x03, 0x00 } },
-	{ .data = { 0x04, 0x65 } },
-	{ .data = { 0x0C, 0x74 } },
-	{ .data = { 0x17, 0x00 } },
-	{ .data = { 0x18, 0xB7 } },
-	{ .data = { 0x19, 0x00 } },
-	{ .data = { 0x1A, 0x00 } },
-	{ .data = { 0x1B, 0xB7 } },
-	{ .data = { 0x1C, 0x00 } },
-	{ .data = { 0x24, 0xFE } },
-	{ .data = { 0x37, 0x19 } },
-	{ .data = { 0x38, 0x05 } },
-	{ .data = { 0x39, 0x00 } },
-	{ .data = { 0x3A, 0x01 } },
-	{ .data = { 0x3B, 0x01 } },
-	{ .data = { 0x3C, 0x70 } },
-	{ .data = { 0x3D, 0xFF } },
-	{ .data = { 0x3E, 0xFF } },
-	{ .data = { 0x3F, 0xFF } },
-	{ .data = { 0x40, 0x06 } },
-	{ .data = { 0x41, 0xA0 } },
-	{ .data = { 0x43, 0x1E } },
-	{ .data = { 0x44, 0x0F } },
-	{ .data = { 0x45, 0x28 } },
-	{ .data = { 0x4B, 0x04 } },
-	{ .data = { 0x55, 0x02 } },
-	{ .data = { 0x56, 0x01 } },
-	{ .data = { 0x57, 0xA9 } },
-	{ .data = { 0x58, 0x0A } },
-	{ .data = { 0x59, 0x0A } },
-	{ .data = { 0x5A, 0x37 } },
-	{ .data = { 0x5B, 0x19 } },
-	{ .data = { 0x5D, 0x78 } },
-	{ .data = { 0x5E, 0x63 } },
-	{ .data = { 0x5F, 0x54 } },
-	{ .data = { 0x60, 0x49 } },
-	{ .data = { 0x61, 0x45 } },
-	{ .data = { 0x62, 0x38 } },
-	{ .data = { 0x63, 0x3D } },
-	{ .data = { 0x64, 0x28 } },
-	{ .data = { 0x65, 0x43 } },
-	{ .data = { 0x66, 0x41 } },
-	{ .data = { 0x67, 0x43 } },
-	{ .data = { 0x68, 0x62 } },
-	{ .data = { 0x69, 0x50 } },
-	{ .data = { 0x6A, 0x57 } },
-	{ .data = { 0x6B, 0x49 } },
-	{ .data = { 0x6C, 0x44 } },
-	{ .data = { 0x6D, 0x37 } },
-	{ .data = { 0x6E, 0x23 } },
-	{ .data = { 0x6F, 0x10 } },
-	{ .data = { 0x70, 0x78 } },
-	{ .data = { 0x71, 0x63 } },
-	{ .data = { 0x72, 0x54 } },
-	{ .data = { 0x73, 0x49 } },
-	{ .data = { 0x74, 0x45 } },
-	{ .data = { 0x75, 0x38 } },
-	{ .data = { 0x76, 0x3D } },
-	{ .data = { 0x77, 0x28 } },
-	{ .data = { 0x78, 0x43 } },
-	{ .data = { 0x79, 0x41 } },
-	{ .data = { 0x7A, 0x43 } },
-	{ .data = { 0x7B, 0x62 } },
-	{ .data = { 0x7C, 0x50 } },
-	{ .data = { 0x7D, 0x57 } },
-	{ .data = { 0x7E, 0x49 } },
-	{ .data = { 0x7F, 0x44 } },
-	{ .data = { 0x80, 0x37 } },
-	{ .data = { 0x81, 0x23 } },
-	{ .data = { 0x82, 0x10 } },
-	{ .data = { 0xE0, 0x02 } },
-	{ .data = { 0x00, 0x47 } },
-	{ .data = { 0x01, 0x47 } },
-	{ .data = { 0x02, 0x45 } },
-	{ .data = { 0x03, 0x45 } },
-	{ .data = { 0x04, 0x4B } },
-	{ .data = { 0x05, 0x4B } },
-	{ .data = { 0x06, 0x49 } },
-	{ .data = { 0x07, 0x49 } },
-	{ .data = { 0x08, 0x41 } },
-	{ .data = { 0x09, 0x1F } },
-	{ .data = { 0x0A, 0x1F } },
-	{ .data = { 0x0B, 0x1F } },
-	{ .data = { 0x0C, 0x1F } },
-	{ .data = { 0x0D, 0x1F } },
-	{ .data = { 0x0E, 0x1F } },
-	{ .data = { 0x0F, 0x5F } },
-	{ .data = { 0x10, 0x5F } },
-	{ .data = { 0x11, 0x57 } },
-	{ .data = { 0x12, 0x77 } },
-	{ .data = { 0x13, 0x35 } },
-	{ .data = { 0x14, 0x1F } },
-	{ .data = { 0x15, 0x1F } },
-	{ .data = { 0x16, 0x46 } },
-	{ .data = { 0x17, 0x46 } },
-	{ .data = { 0x18, 0x44 } },
-	{ .data = { 0x19, 0x44 } },
-	{ .data = { 0x1A, 0x4A } },
-	{ .data = { 0x1B, 0x4A } },
-	{ .data = { 0x1C, 0x48 } },
-	{ .data = { 0x1D, 0x48 } },
-	{ .data = { 0x1E, 0x40 } },
-	{ .data = { 0x1F, 0x1F } },
-	{ .data = { 0x20, 0x1F } },
-	{ .data = { 0x21, 0x1F } },
-	{ .data = { 0x22, 0x1F } },
-	{ .data = { 0x23, 0x1F } },
-	{ .data = { 0x24, 0x1F } },
-	{ .data = { 0x25, 0x5F } },
-	{ .data = { 0x26, 0x5F } },
-	{ .data = { 0x27, 0x57 } },
-	{ .data = { 0x28, 0x77 } },
-	{ .data = { 0x29, 0x35 } },
-	{ .data = { 0x2A, 0x1F } },
-	{ .data = { 0x2B, 0x1F } },
-	{ .data = { 0x58, 0x40 } },
-	{ .data = { 0x59, 0x00 } },
-	{ .data = { 0x5A, 0x00 } },
-	{ .data = { 0x5B, 0x10 } },
-	{ .data = { 0x5C, 0x06 } },
-	{ .data = { 0x5D, 0x40 } },
-	{ .data = { 0x5E, 0x01 } },
-	{ .data = { 0x5F, 0x02 } },
-	{ .data = { 0x60, 0x30 } },
-	{ .data = { 0x61, 0x01 } },
-	{ .data = { 0x62, 0x02 } },
-	{ .data = { 0x63, 0x03 } },
-	{ .data = { 0x64, 0x6B } },
-	{ .data = { 0x65, 0x05 } },
-	{ .data = { 0x66, 0x0C } },
-	{ .data = { 0x67, 0x73 } },
-	{ .data = { 0x68, 0x09 } },
-	{ .data = { 0x69, 0x03 } },
-	{ .data = { 0x6A, 0x56 } },
-	{ .data = { 0x6B, 0x08 } },
-	{ .data = { 0x6C, 0x00 } },
-	{ .data = { 0x6D, 0x04 } },
-	{ .data = { 0x6E, 0x04 } },
-	{ .data = { 0x6F, 0x88 } },
-	{ .data = { 0x70, 0x00 } },
-	{ .data = { 0x71, 0x00 } },
-	{ .data = { 0x72, 0x06 } },
-	{ .data = { 0x73, 0x7B } },
-	{ .data = { 0x74, 0x00 } },
-	{ .data = { 0x75, 0xF8 } },
-	{ .data = { 0x76, 0x00 } },
-	{ .data = { 0x77, 0xD5 } },
-	{ .data = { 0x78, 0x2E } },
-	{ .data = { 0x79, 0x12 } },
-	{ .data = { 0x7A, 0x03 } },
-	{ .data = { 0x7B, 0x00 } },
-	{ .data = { 0x7C, 0x00 } },
-	{ .data = { 0x7D, 0x03 } },
-	{ .data = { 0x7E, 0x7B } },
-	{ .data = { 0xE0, 0x04 } },
-	{ .data = { 0x00, 0x0E } },
-	{ .data = { 0x02, 0xB3 } },
-	{ .data = { 0x09, 0x60 } },
-	{ .data = { 0x0E, 0x2A } },
-	{ .data = { 0x36, 0x59 } },
-	{ .data = { 0xE0, 0x00 } },
+static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x7e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xb7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xb7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x70);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0xa9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x63);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x62);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x63);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x62);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x7b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xd5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x7b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x60);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x59);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+
+	return dsi_ctx.accum_err;
 };
 
 static const struct jadard_panel_desc radxa_display_8hd_ad002_desc = {
@@ -357,205 +341,209 @@ static const struct jadard_panel_desc radxa_display_8hd_ad002_desc = {
 	},
 	.lanes = 4,
 	.format = MIPI_DSI_FMT_RGB888,
-	.init_cmds = radxa_display_8hd_ad002_init_cmds,
-	.num_init_cmds = ARRAY_SIZE(radxa_display_8hd_ad002_init_cmds),
+	.init = radxa_display_8hd_ad002_init_cmds,
 };
 
-static const struct jadard_init_cmd cz101b4001_init_cmds[] = {
-	{ .data = { 0xE0, 0x00 } },
-	{ .data = { 0xE1, 0x93 } },
-	{ .data = { 0xE2, 0x65 } },
-	{ .data = { 0xE3, 0xF8 } },
-	{ .data = { 0x80, 0x03 } },
-	{ .data = { 0xE0, 0x01 } },
-	{ .data = { 0x00, 0x00 } },
-	{ .data = { 0x01, 0x3B } },
-	{ .data = { 0x0C, 0x74 } },
-	{ .data = { 0x17, 0x00 } },
-	{ .data = { 0x18, 0xAF } },
-	{ .data = { 0x19, 0x00 } },
-	{ .data = { 0x1A, 0x00 } },
-	{ .data = { 0x1B, 0xAF } },
-	{ .data = { 0x1C, 0x00 } },
-	{ .data = { 0x35, 0x26 } },
-	{ .data = { 0x37, 0x09 } },
-	{ .data = { 0x38, 0x04 } },
-	{ .data = { 0x39, 0x00 } },
-	{ .data = { 0x3A, 0x01 } },
-	{ .data = { 0x3C, 0x78 } },
-	{ .data = { 0x3D, 0xFF } },
-	{ .data = { 0x3E, 0xFF } },
-	{ .data = { 0x3F, 0x7F } },
-	{ .data = { 0x40, 0x06 } },
-	{ .data = { 0x41, 0xA0 } },
-	{ .data = { 0x42, 0x81 } },
-	{ .data = { 0x43, 0x14 } },
-	{ .data = { 0x44, 0x23 } },
-	{ .data = { 0x45, 0x28 } },
-	{ .data = { 0x55, 0x02 } },
-	{ .data = { 0x57, 0x69 } },
-	{ .data = { 0x59, 0x0A } },
-	{ .data = { 0x5A, 0x2A } },
-	{ .data = { 0x5B, 0x17 } },
-	{ .data = { 0x5D, 0x7F } },
-	{ .data = { 0x5E, 0x6B } },
-	{ .data = { 0x5F, 0x5C } },
-	{ .data = { 0x60, 0x4F } },
-	{ .data = { 0x61, 0x4D } },
-	{ .data = { 0x62, 0x3F } },
-	{ .data = { 0x63, 0x42 } },
-	{ .data = { 0x64, 0x2B } },
-	{ .data = { 0x65, 0x44 } },
-	{ .data = { 0x66, 0x43 } },
-	{ .data = { 0x67, 0x43 } },
-	{ .data = { 0x68, 0x63 } },
-	{ .data = { 0x69, 0x52 } },
-	{ .data = { 0x6A, 0x5A } },
-	{ .data = { 0x6B, 0x4F } },
-	{ .data = { 0x6C, 0x4E } },
-	{ .data = { 0x6D, 0x20 } },
-	{ .data = { 0x6E, 0x0F } },
-	{ .data = { 0x6F, 0x00 } },
-	{ .data = { 0x70, 0x7F } },
-	{ .data = { 0x71, 0x6B } },
-	{ .data = { 0x72, 0x5C } },
-	{ .data = { 0x73, 0x4F } },
-	{ .data = { 0x74, 0x4D } },
-	{ .data = { 0x75, 0x3F } },
-	{ .data = { 0x76, 0x42 } },
-	{ .data = { 0x77, 0x2B } },
-	{ .data = { 0x78, 0x44 } },
-	{ .data = { 0x79, 0x43 } },
-	{ .data = { 0x7A, 0x43 } },
-	{ .data = { 0x7B, 0x63 } },
-	{ .data = { 0x7C, 0x52 } },
-	{ .data = { 0x7D, 0x5A } },
-	{ .data = { 0x7E, 0x4F } },
-	{ .data = { 0x7F, 0x4E } },
-	{ .data = { 0x80, 0x20 } },
-	{ .data = { 0x81, 0x0F } },
-	{ .data = { 0x82, 0x00 } },
-	{ .data = { 0xE0, 0x02 } },
-	{ .data = { 0x00, 0x02 } },
-	{ .data = { 0x01, 0x02 } },
-	{ .data = { 0x02, 0x00 } },
-	{ .data = { 0x03, 0x00 } },
-	{ .data = { 0x04, 0x1E } },
-	{ .data = { 0x05, 0x1E } },
-	{ .data = { 0x06, 0x1F } },
-	{ .data = { 0x07, 0x1F } },
-	{ .data = { 0x08, 0x1F } },
-	{ .data = { 0x09, 0x17 } },
-	{ .data = { 0x0A, 0x17 } },
-	{ .data = { 0x0B, 0x37 } },
-	{ .data = { 0x0C, 0x37 } },
-	{ .data = { 0x0D, 0x47 } },
-	{ .data = { 0x0E, 0x47 } },
-	{ .data = { 0x0F, 0x45 } },
-	{ .data = { 0x10, 0x45 } },
-	{ .data = { 0x11, 0x4B } },
-	{ .data = { 0x12, 0x4B } },
-	{ .data = { 0x13, 0x49 } },
-	{ .data = { 0x14, 0x49 } },
-	{ .data = { 0x15, 0x1F } },
-	{ .data = { 0x16, 0x01 } },
-	{ .data = { 0x17, 0x01 } },
-	{ .data = { 0x18, 0x00 } },
-	{ .data = { 0x19, 0x00 } },
-	{ .data = { 0x1A, 0x1E } },
-	{ .data = { 0x1B, 0x1E } },
-	{ .data = { 0x1C, 0x1F } },
-	{ .data = { 0x1D, 0x1F } },
-	{ .data = { 0x1E, 0x1F } },
-	{ .data = { 0x1F, 0x17 } },
-	{ .data = { 0x20, 0x17 } },
-	{ .data = { 0x21, 0x37 } },
-	{ .data = { 0x22, 0x37 } },
-	{ .data = { 0x23, 0x46 } },
-	{ .data = { 0x24, 0x46 } },
-	{ .data = { 0x25, 0x44 } },
-	{ .data = { 0x26, 0x44 } },
-	{ .data = { 0x27, 0x4A } },
-	{ .data = { 0x28, 0x4A } },
-	{ .data = { 0x29, 0x48 } },
-	{ .data = { 0x2A, 0x48 } },
-	{ .data = { 0x2B, 0x1F } },
-	{ .data = { 0x2C, 0x01 } },
-	{ .data = { 0x2D, 0x01 } },
-	{ .data = { 0x2E, 0x00 } },
-	{ .data = { 0x2F, 0x00 } },
-	{ .data = { 0x30, 0x1F } },
-	{ .data = { 0x31, 0x1F } },
-	{ .data = { 0x32, 0x1E } },
-	{ .data = { 0x33, 0x1E } },
-	{ .data = { 0x34, 0x1F } },
-	{ .data = { 0x35, 0x17 } },
-	{ .data = { 0x36, 0x17 } },
-	{ .data = { 0x37, 0x37 } },
-	{ .data = { 0x38, 0x37 } },
-	{ .data = { 0x39, 0x08 } },
-	{ .data = { 0x3A, 0x08 } },
-	{ .data = { 0x3B, 0x0A } },
-	{ .data = { 0x3C, 0x0A } },
-	{ .data = { 0x3D, 0x04 } },
-	{ .data = { 0x3E, 0x04 } },
-	{ .data = { 0x3F, 0x06 } },
-	{ .data = { 0x40, 0x06 } },
-	{ .data = { 0x41, 0x1F } },
-	{ .data = { 0x42, 0x02 } },
-	{ .data = { 0x43, 0x02 } },
-	{ .data = { 0x44, 0x00 } },
-	{ .data = { 0x45, 0x00 } },
-	{ .data = { 0x46, 0x1F } },
-	{ .data = { 0x47, 0x1F } },
-	{ .data = { 0x48, 0x1E } },
-	{ .data = { 0x49, 0x1E } },
-	{ .data = { 0x4A, 0x1F } },
-	{ .data = { 0x4B, 0x17 } },
-	{ .data = { 0x4C, 0x17 } },
-	{ .data = { 0x4D, 0x37 } },
-	{ .data = { 0x4E, 0x37 } },
-	{ .data = { 0x4F, 0x09 } },
-	{ .data = { 0x50, 0x09 } },
-	{ .data = { 0x51, 0x0B } },
-	{ .data = { 0x52, 0x0B } },
-	{ .data = { 0x53, 0x05 } },
-	{ .data = { 0x54, 0x05 } },
-	{ .data = { 0x55, 0x07 } },
-	{ .data = { 0x56, 0x07 } },
-	{ .data = { 0x57, 0x1F } },
-	{ .data = { 0x58, 0x40 } },
-	{ .data = { 0x5B, 0x30 } },
-	{ .data = { 0x5C, 0x16 } },
-	{ .data = { 0x5D, 0x34 } },
-	{ .data = { 0x5E, 0x05 } },
-	{ .data = { 0x5F, 0x02 } },
-	{ .data = { 0x63, 0x00 } },
-	{ .data = { 0x64, 0x6A } },
-	{ .data = { 0x67, 0x73 } },
-	{ .data = { 0x68, 0x1D } },
-	{ .data = { 0x69, 0x08 } },
-	{ .data = { 0x6A, 0x6A } },
-	{ .data = { 0x6B, 0x08 } },
-	{ .data = { 0x6C, 0x00 } },
-	{ .data = { 0x6D, 0x00 } },
-	{ .data = { 0x6E, 0x00 } },
-	{ .data = { 0x6F, 0x88 } },
-	{ .data = { 0x75, 0xFF } },
-	{ .data = { 0x77, 0xDD } },
-	{ .data = { 0x78, 0x3F } },
-	{ .data = { 0x79, 0x15 } },
-	{ .data = { 0x7A, 0x17 } },
-	{ .data = { 0x7D, 0x14 } },
-	{ .data = { 0x7E, 0x82 } },
-	{ .data = { 0xE0, 0x04 } },
-	{ .data = { 0x00, 0x0E } },
-	{ .data = { 0x02, 0xB3 } },
-	{ .data = { 0x09, 0x61 } },
-	{ .data = { 0x0E, 0x48 } },
-	{ .data = { 0xE0, 0x00 } },
-	{ .data = { 0xE6, 0x02 } },
-	{ .data = { 0xE7, 0x0C } },
+static int cz101b4001_init_cmds(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x3b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xaf);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xaf);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x81);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x69);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x6b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x5c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x4d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x2b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x63);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x52);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x6b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x5c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x4d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x2b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x63);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x52);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xdd);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x82);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x61);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe7, 0x0c);
+
+	return dsi_ctx.accum_err;
 };
 
 static const struct jadard_panel_desc cz101b4001_desc = {
@@ -578,8 +566,7 @@ static const struct jadard_panel_desc cz101b4001_desc = {
 	},
 	.lanes = 4,
 	.format = MIPI_DSI_FMT_RGB888,
-	.init_cmds = cz101b4001_init_cmds,
-	.num_init_cmds = ARRAY_SIZE(cz101b4001_init_cmds),
+	.init = cz101b4001_init_cmds,
 };
 
 static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
-- 
2.17.1


