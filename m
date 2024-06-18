Return-Path: <linux-kernel+bounces-218847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8290C6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA9928454E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E901A38C1;
	Tue, 18 Jun 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXeNDMnX"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7846B1A2FC8;
	Tue, 18 Jun 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698559; cv=none; b=HzRd0FOAY179XLcW/5fPtcGAiO1ekTbNOn7OVroQrFPfWnWIEAERm3i1gxdU6fp1KOy0l9bXM9Ay4DDPONXUAhqqMdZImxOHru23opR0dscAEOsYsMdmYD+/nDIMRrWj4AWfNSZaY8c/GTOS0e8awr3L3v4g+KgZ9LBkwKPcWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698559; c=relaxed/simple;
	bh=Na+4Md+vUbqekewiBj7zRZz4d9pq8oB+aZcFrx4hInM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5j7Yru4eYKLsZCZP2PKYSo0ImSVo+h29dW2U0OKncdE6Ndmlzo7hnjex6/hWcIGGDFCaplbfohqvOEEjGd5Y+IqbuhD1lnUrS9PP0SIJqtLjgHlBWr1e1K+nm0x+hfaD3YCiW5YKHhd3Xl2HIWsg5U+r/5gNdaaRAMkg3Y43yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXeNDMnX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f717b3f2d8so43697165ad.1;
        Tue, 18 Jun 2024 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698557; x=1719303357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSvLjZC07IB2/e6r4rSWcrUumY0ptch207k58YrRPQI=;
        b=VXeNDMnXeYsYEHf2CQnioS2PaiMYswQoqBpTfh3hT3wXzwpyfZ6BYp/zfhyDq1LxdN
         fDE8TurHyCZkfQ8jzWg+GMtXLwP9mojW84hjdhGlggoaWcloJt3bB4fvHQ+WGeehwTzj
         i2MZOvHAbxAOhMeQ2OYi+9+ilabDHBmDlSWd/bz0qf+XIge/rsu5GGTsbAB4Uu/DngqI
         9uNE8klTuaonlvyxKfclPceSg/pE+oPzrDVffPacbbT0DASuvdcsvMkW9o/dOc7CkdKf
         OgNbzrQid3au2vtx771OfIFVQTqOu35Kr5qdTJAZ10U/kpxR/0pa1keN2Dofi+og9Fay
         GISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698557; x=1719303357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSvLjZC07IB2/e6r4rSWcrUumY0ptch207k58YrRPQI=;
        b=MNocEfKqmMhGFvlGBpBk7IcoaqxaUjQIDDLqnoez2i5/d7M6WbjFnISZRyEzEBjpZZ
         fKjEMZMxxPOYForDwdCsqHO6QxD0F3JlIEO7Cmdumcq3VfczkTQTjHILZV72icLj5a07
         5pD0uMDGROWME3Gu1+NFwsKXXjY728EOrM1KBNP9nMylJ793kKopSUkYtIaFQkFb8qoM
         +Uh5/8dqN0vnUcF/oFfQAIk6sYoSglfu9VrmShds3c2kQUC1D61GcJVo4HFT28oxb/vu
         07GY89VqKatOWACOrhs7r1lv8xgQgwgJOSRRcqdZlly71Qj84C2J80OzIedGi3v6DFQD
         9pkw==
X-Forwarded-Encrypted: i=1; AJvYcCVVgTpP32GgHl34Dz5N4+UYJdan77uslx8z5wk5as1e0cSTWMYMHGTgxhG489XZ2aGul6Vv0r7j2Kl6vf8eM67JVMrWFWnd5TnwIw==
X-Gm-Message-State: AOJu0Yyr4aAhnzTloT2zZ3SIeko3qKZRlB03SJ05rIUuu50e+ysqzRhq
	BdO5kD0I2sNNFmiM7CdALooCkE/ofDH9b7nc9UhKdiZdmaGknPYrqGptMRLKIWw=
X-Google-Smtp-Source: AGHT+IGM/6lCX7bL6JdHezDob/H0wWeTBjXAUgY3n5M0N7w8yAdYPVpNTTjIH5ib/xhF8WcfRnlnCg==
X-Received: by 2002:a17:902:d510:b0:1f6:ee7b:6ecf with SMTP id d9443c01a7336-1f98b28f021mr29069955ad.34.1718698556674;
        Tue, 18 Jun 2024 01:15:56 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1a1ebsm91883575ad.238.2024.06.18.01.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:15:56 -0700 (PDT)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 3/3] drm/panel: st7701: Add Anbernic RG28XX panel support
Date: Tue, 18 Jun 2024 17:15:14 +0900
Message-ID: <20240618081515.1215552-4-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618081515.1215552-1-kikuchan98@gmail.com>
References: <20240618081515.1215552-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Anbernic RG28XX is a handheld device with a 2.8 inch 480x640 display.
Add support for the display.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 3c4a66f2fc7..d5f8f36c835 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -471,6 +471,55 @@ static void rg_arc_gip_sequence(struct st7701 *st7701)
 	msleep(120);
 }
 
+static void rg28xx_gip_sequence(struct st7701 *st7701)
+{
+	st7701_switch_cmd_bkx(st7701, true, 3);
+	ST7701_DSI(st7701, 0xEF, 0x08);
+
+	st7701_switch_cmd_bkx(st7701, true, 0);
+	ST7701_DSI(st7701, 0xC3, 0x02, 0x10, 0x02);
+	ST7701_DSI(st7701, 0xC7, 0x04);
+	ST7701_DSI(st7701, 0xCC, 0x10);
+
+	st7701_switch_cmd_bkx(st7701, true, 1);
+	ST7701_DSI(st7701, 0xEE, 0x42);
+	ST7701_DSI(st7701, 0xE0, 0x00, 0x00, 0x02);
+
+	ST7701_DSI(st7701, 0xE1, 0x04, 0xA0, 0x06, 0xA0, 0x05, 0xA0, 0x07, 0xA0,
+		   0x00, 0x44, 0x44);
+	ST7701_DSI(st7701, 0xE2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		   0x00, 0x00, 0x00, 0x00);
+	ST7701_DSI(st7701, 0xE3, 0x00, 0x00, 0x22, 0x22);
+	ST7701_DSI(st7701, 0xE4, 0x44, 0x44);
+	ST7701_DSI(st7701, 0xE5, 0x0C, 0x90, 0xA0, 0xA0, 0x0E, 0x92, 0xA0, 0xA0,
+		   0x08, 0x8C, 0xA0, 0xA0, 0x0A, 0x8E, 0xA0, 0xA0);
+	ST7701_DSI(st7701, 0xE6, 0x00, 0x00, 0x22, 0x22);
+	ST7701_DSI(st7701, 0xE7, 0x44, 0x44);
+	ST7701_DSI(st7701, 0xE8, 0x0D, 0x91, 0xA0, 0xA0, 0x0F, 0x93, 0xA0, 0xA0,
+		   0x09, 0x8D, 0xA0, 0xA0, 0x0B, 0x8F, 0xA0, 0xA0);
+	ST7701_DSI(st7701, 0xEB, 0x00, 0x00, 0xE4, 0xE4, 0x44, 0x00, 0x40);
+	ST7701_DSI(st7701, 0xED, 0xFF, 0xF5, 0x47, 0x6F, 0x0B, 0xA1, 0xBA, 0xFF,
+		   0xFF, 0xAB, 0x1A, 0xB0, 0xF6, 0x74, 0x5F, 0xFF);
+	ST7701_DSI(st7701, 0xEF, 0x08, 0x08, 0x08, 0x45, 0x3F, 0x54);
+
+	st7701_switch_cmd_bkx(st7701, false, 0);
+
+	st7701_switch_cmd_bkx(st7701, true, 3);
+	ST7701_DSI(st7701, 0xE6, 0x16);
+	ST7701_DSI(st7701, 0xE8, 0x00, 0x0E);
+
+	st7701_switch_cmd_bkx(st7701, false, 0);
+	ST7701_DSI(st7701, MIPI_DCS_SET_ADDRESS_MODE, 0x10);
+	ST7701_DSI(st7701, MIPI_DCS_EXIT_SLEEP_MODE);
+	msleep(120);
+
+	st7701_switch_cmd_bkx(st7701, true, 3);
+	ST7701_DSI(st7701, 0xE8, 0x00, 0x0C);
+	msleep(10);
+	ST7701_DSI(st7701, 0xE8, 0x00, 0x00);
+	st7701_switch_cmd_bkx(st7701, false, 0);
+}
+
 static int st7701_prepare(struct drm_panel *panel)
 {
 	struct st7701 *st7701 = panel_to_st7701(panel);
@@ -986,6 +1035,106 @@ static const struct st7701_panel_desc rg_arc_desc = {
 	.gip_sequence = rg_arc_gip_sequence,
 };
 
+static const struct drm_display_mode rg28xx_mode = {
+	.clock		= 22325,
+
+	.hdisplay	= 480,
+	.hsync_start	= 480 + 40,
+	.hsync_end	= 480 + 40 + 4,
+	.htotal		= 480 + 40 + 4 + 20,
+
+	.vdisplay	= 640,
+	.vsync_start	= 640 + 2,
+	.vsync_end	= 640 + 2 + 40,
+	.vtotal		= 640 + 2 + 40 + 16,
+
+	.width_mm	= 44,
+	.height_mm	= 58,
+
+	.flags		= DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct st7701_panel_desc rg28xx_desc = {
+	.mode = &rg28xx_mode,
+
+	.panel_sleep_delay = 80,
+
+	.pv_gamma = {
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0x10),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x17),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xd),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x6),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x5),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x7),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x1f),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x4),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x11),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0xe),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x29),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x30),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
+	},
+	.nv_gamma = {
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC4_MASK, 0xd),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC16_MASK, 0xe),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC52_MASK, 0x6),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC80_MASK, 0x4),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC175_MASK, 0x20),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
+
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC239_MASK, 0x13),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC247_MASK, 0x26),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC251_MASK, 0x30),
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(DSI_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
+	},
+	.nlinv = 7,
+	.vop_uv = 4800000,
+	.vcom_uv = 1512500,
+	.vgh_mv = 15000,
+	.vgl_mv = -11730,
+	.avdd_mv = 6600,
+	.avcl_mv = -4400,
+	.gamma_op_bias = OP_BIAS_MIDDLE,
+	.input_op_bias = OP_BIAS_MIN,
+	.output_op_bias = OP_BIAS_MIN,
+	.t2d_ns = 1600,
+	.t3d_ns = 10400,
+	.eot_en = true,
+	.gip_sequence = rg28xx_gip_sequence,
+};
+
 static void st7701_cleanup(void *data)
 {
 	struct st7701 *st7701 = (struct st7701 *)data;
@@ -1141,11 +1290,13 @@ static const struct of_device_id st7701_dsi_of_match[] = {
 MODULE_DEVICE_TABLE(of, st7701_dsi_of_match);
 
 static const struct of_device_id st7701_spi_of_match[] = {
+	{ .compatible = "anbernic,rg28xx-panel", .data = &rg28xx_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, st7701_spi_of_match);
 
 static const struct spi_device_id st7701_spi_ids[] = {
+	{ "rg28xx-panel" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, st7701_spi_ids);
-- 
2.45.2


