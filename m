Return-Path: <linux-kernel+bounces-227340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A0F914FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E891C21D52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2E4170834;
	Mon, 24 Jun 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="NHuta/wz"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23417D882
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238873; cv=none; b=Le8CcTNg/gx0+In59XggFLeaAfaRbFDduTgGOGU+d5h/64qm06MVoA9FGt68XyiPzF8Xm8NetmuG4Bbkj3ET9Id08XKeNYZcXx+7j8sRoXxojtsGEUrtl4JVxVJhCzMUYF5DIlxgfb5nz4SNcbbHv33Oq04tlzNby/ivxIdZvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238873; c=relaxed/simple;
	bh=gYHN2eoKPTRqNwz6jyJWa06NEdqYaAt6bNvBuFJc6zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DkTEgrMDVksIZwkriDeJcAgoC7usjO1/F8X6bjupvbWaGFWzgzcJhCaIUg0HsqhBtLRWN3c4SP+q1The9pms+SCe56dZ/dRCz/kK/6f+EfAsL6pA6dhk5F0t91H4n2nBDFdH98rCR6Tx7MvpySOkwMh6LTRB2li7aE0XZNMicpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=NHuta/wz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9ffd24262so18175995ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719238860; x=1719843660; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vT91zwa3wj6MuLeFwtQegqUTitwUiDGb35w7LrUTTlE=;
        b=NHuta/wzFjKasn3joNT/2nEAWfw0vT9vG6+9FC15ZImfFEtVXYILnFgr8ZK8OpAFiv
         0hrRUacqfICiDTqiE+1ZawqO8P3Hq9l8+12M6lIPBL1TcghtmTL46/T8UNMR/35qAEca
         zEL8BZmF61putRCuCH2O28Vp2waB7+paCbtIvp5q+S06kn3ucX1QKRf96UuyYPBDxJxT
         5kdOHRY/pCicZQ12nx6d1IJ4aZPp4qXL24B257PHZ0E/sCJncd3uYUIre2YIuv2sw101
         2qpMJsB9tF994TGsC/POnpiki97eV8ZIKXuhOmCLuq+nYct2Di6+NEokrzo3Qtbg+sKU
         OcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719238860; x=1719843660;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vT91zwa3wj6MuLeFwtQegqUTitwUiDGb35w7LrUTTlE=;
        b=Nrsbu7eDARHakJuSmjRFeU4XbNCBjLpbOIEMcrJT+LsoT2DK73YJzK/sg9z/EmBOIt
         3psrTQ49rY6btRnUq/uf64JQpqoK4fQjwDZ5I6P5Psreo9pnIbwj1jJKteTyVwUMSFip
         7QJ+GH64kKVtbWMcoPlanqYCHhVu/lfmlZiKj6mxyNAuiZTYt5tAbMhoX+WvkiAgjkcc
         hjHVYdRFR/nuO5d/Uan8YMJQRrqVq697yQ9uldE80SaHxnQFJbrTjl9Hm7aHAReNcZnF
         CbswHOmTxg+HDtTLM8UloluW4REmWcdkViY9mvE29GBq0331i2t+nbxt9rDgFeL1qnSR
         sLnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR3P/9DZuSpeN8TxlZXdu7LrqGjTaC2CLZFSDxuKlZmZN2cJB4w13zkamOmrI4KkETHIFaI3IQ9NDuTzYu0NhI5nAVPaCV7zWj5N7m
X-Gm-Message-State: AOJu0Yx887H9X5IjnCeI3g/Z+XDHa7tw1E/IuIDbj9qvCdgynsO3mIue
	YO0k2ohGzt6r8X9rHgmq8NSF6sLkBTn2R/aovvifoP3Awdf5/O8vUl9m6+Yz9BM=
X-Google-Smtp-Source: AGHT+IFk0sT32GCJG7xz7Ol4liAXIF5V6fwufYdNG1WK4NZtT025Jwj2esjr4ftNQL3HImkvEziCEg==
X-Received: by 2002:a17:902:cecc:b0:1f9:ab2c:e458 with SMTP id d9443c01a7336-1fa23fd8c26mr46941765ad.31.1719238860301;
        Mon, 24 Jun 2024 07:21:00 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5fa9sm63243855ad.206.2024.06.24.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:20:59 -0700 (PDT)
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
Subject: [PATCH v5 3/5] drm/panel: panel-jadard-jd9365da-h3: use wrapped MIPI DCS functions
Date: Mon, 24 Jun 2024 22:19:24 +0800
Message-Id: <20240624141926.5250-4-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
simplify driver's init/enable/exit code.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 793 +++++++++---------
 1 file changed, 390 insertions(+), 403 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index a9c483a7b3fa..e836260338bf 100644
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
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE1, 0x93);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE2, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE3, 0xF8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x7E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xB7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0xB7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xFE);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3B, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3C, 0x70);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3D, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3E, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3F, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xA0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4B, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0xA9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5A, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x63);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x3D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x62);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x63);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x3D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7B, 0x62);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7C, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7F, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x4B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x4B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0A, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0B, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0D, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0F, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x4A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0x4A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1D, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1E, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1F, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2A, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2B, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5A, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5C, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x0C);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x7B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xF8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xD5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7B, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7C, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x7B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xB3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x60);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x59);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
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
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE1, 0x93);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE2, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE3, 0xF8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x3B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xAF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0xAF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3C, 0x78);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3D, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3E, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3F, 0x7F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xA0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x81);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x69);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5A, 0x2A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x7F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x6B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x5C);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x4F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x4D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x3F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x2B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x63);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x52);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x5A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x4F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x4E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x6B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x5C);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x4F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x4D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x3F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x2B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7B, 0x63);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7C, 0x52);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x5A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x4F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7F, 0x4E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0A, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0B, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0D, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0F, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x4B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x4B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1D, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1E, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1F, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x4A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x4A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2A, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2B, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2C, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2D, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2E, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2F, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3B, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3C, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3D, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3E, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3F, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4A, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4B, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4C, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4D, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4E, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4F, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x0B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x0B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5C, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x1D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x6A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xDD);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x3F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x82);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xB3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x61);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE6, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE7, 0x0C);
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


