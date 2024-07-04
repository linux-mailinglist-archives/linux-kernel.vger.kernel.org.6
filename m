Return-Path: <linux-kernel+bounces-240666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 061299270A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295151C21D1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5C81A2FBB;
	Thu,  4 Jul 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="GAl+0OM2"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB011A2C0E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078249; cv=none; b=hk0O15Eh4zL20qVKPms0A4lP9MOlP5Mv6XeYCoqDmMqcailfO5FiSpN6yKfUBiROIvDLQf+lCekGUrfadVMiaO+cemmuAPx5l0PG/fjzVVtNq4TO0Ilk2tiWTfWcnKH6sFQGwrFb6ioJuFSmnyjM6IBsb7U1x13z8NFbDw1OQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078249; c=relaxed/simple;
	bh=jFqTpPBUj/rVpbFR5JJN/PyggmUCMyGRPpUtHug2/Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YrQJzL/FicxG/il/IPSFzNnfZjClF0Ud/GiVOBww/WwQFi3s+U2gogPYx64CMEA9OR7dy71p+iCLjJlvCOJmhmVpobuSp2PeCsxU52W/GXB/VHoDdvqCscvHE8kMNtRVo5hsDanyL6NeKU7cjr7sHWJolkIx0Lodh+OkTFY2UAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=GAl+0OM2; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-701ef03185fso224055a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720078238; x=1720683038; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oULU6NiiqkyOGkcZi0g7XiI0vpZQtDZ3cbwAH6tTw4E=;
        b=GAl+0OM2rnsFdrmUsxE+XyZVurpOKW/orB93P90FoVEIdMa5fBeGvqdR7sia/Ke0t1
         VQZN+bMj6gyZpFKWUVJeniwCai+EEQjWpkMB7NyRItbWGNJn1Asg5d3htiyOVMQHVj6N
         OocASvYs4V9E9V+lozMGiBDAdhag4z3k+n2nnHqqmoRNWmFhex5vtS8KnCTJcIxUS0C6
         MEtWUw9e1N4P9/Er6nh3MSHT1Pl99kKjQ0R2EBpVmQJrc1Zr/KOkaeKy6H0/qfDBqklO
         gMIUKg8mpiXuxPcmymaR7CJRyFjMTj0VxN0tR2VyGmO+DfPL7ctxPDXr2kQ8edzBNflE
         qYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078238; x=1720683038;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oULU6NiiqkyOGkcZi0g7XiI0vpZQtDZ3cbwAH6tTw4E=;
        b=opL5hTk2SyJaCNa+sIp8Ry55vCqgqZyh5AZ85XyV6mTWONflD6hj2xhDVfruJ02Oon
         JrmwZIABVyD7Yu3A9X3dBGUrcEgn77RCAeEjHFVIZxFwM1r+4gNW2SwRHAiWZuf05eOO
         XAXDIMvJAti4KOjimY0aTzOCGeWeAV5mEA0lyxGoQt2SRAJ4vIq2EF+IhKQqMtgpoSf4
         kzlTo9WtGse408qTk2n1Wa1CL8zkKTu0OL40MLSXLM21vL+hxiUiwtlgqi22evPA+MYY
         R2PQPHcwqyuQN88l8TQcKwuBYWNQxwWayNNPtuChLrKP5gr5HouXifsVoDSfkk1VNKBY
         aUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSwhEBBYo+kE74fIzBkLaVoTzZoLKZ1vMLZANE8MZkYzSKQ2hwJFXxa22jo6y7DkdIzc6AkeAAYBHOkjsbS7g8oxZ/3mJ5qFOEg+X9
X-Gm-Message-State: AOJu0Yy1X0JvJKxj42ev2z+5bPFtBz0sIl8b2/cqcwA0JTif8lhQ9Fib
	qDcr5DV4TgT9imVxZVxBxfGFPOT+D9h2g476d783OqeoSwHvr0grPw97yDeo+Lk=
X-Google-Smtp-Source: AGHT+IEyL2s7WhLKThUReTWnCe+EBOA1JmaAaJ4Sc2IyGOT8K0WXvI85noW28oWCiqxbyMFB0+XbNA==
X-Received: by 2002:a05:6359:4594:b0:1a5:9267:37dd with SMTP id e5c5f4694b2df-1aa98ca5bd1mr80191755d.32.1720078237882;
        Thu, 04 Jul 2024 00:30:37 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm7735699a12.31.2024.07.04.00.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:30:37 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v5 5/5] drm/panel: :boe-th101mb31ig002: Support for starry-er88577 MIPI-DSI panel
Date: Thu,  4 Jul 2024 15:29:58 +0800
Message-Id: <20240704072958.27876-6-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The init_code of the starry-er88577 panel is very similar to the
panel-boe-th101mb31ig002-28a.c driver, so we make it compatible with
the panel-boe-th101mb31ig002-28a.c driver

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V5 and V4:
-  1. Compatible with starry-er88577 panel in panel-boe-th101mb31ig002-28a.c driver,.
v4: https://lore.kernel.org/all/20240620115245.31540-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V4 and V3:
-  1. Adjust the ".clock" assignment format.
v3: https://lore.kernel.org/all/20240614145609.25432-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
-  Separate Starry-er88577 from the panel-kingdisplay-kd101ne3 driver.
-  Use mipi_dsi_dcs_set_display_on_multi().
-  Use mipi_dsi_dcs_exit_sleep_mode_multi() and mipi_dsi_msleep().
v2: https://lore.kernel.org/all/20240601084528.22502-5-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  Add compatible for Starry er88577 in panel-kingdisplay-kd101ne3 drivers.

---
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 736bfba607cf..c103236cc970 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -25,6 +25,12 @@ struct panel_desc {
 	enum mipi_dsi_pixel_format format;
 	int (*init)(struct boe_th101mb31ig002 *ctx);
 	unsigned int lanes;
+	bool lp11_before_reset;
+	unsigned int vcioo_to_lp11_delay_ms;
+	unsigned int lp11_to_reset_delay_ms;
+	unsigned int backlight_off_to_display_off_delay_ms;
+	unsigned int enter_sleep_to_reset_down_delay_ms;
+	unsigned int power_off_delay_ms;
 };
 
 struct boe_th101mb31ig002 {
@@ -108,6 +114,65 @@ static int boe_th101mb31ig002_enable(struct boe_th101mb31ig002 *ctx)
 	return dsi_ctx.accum_err;
 }
 
+static int starry_er88577_init_cmd(struct boe_th101mb31ig002 *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	msleep(70);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0xab, 0xba);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0xba, 0xab);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb1, 0x10, 0x01, 0x47, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x0c, 0x14, 0x04, 0x50, 0x50, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3, 0x56, 0x53, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb4, 0x33, 0x30, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0xb0, 0x00, 0x00, 0x10, 0x00, 0x10,
+					       0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x05, 0x12, 0x29, 0x49, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x7c, 0x61, 0x4f, 0x42, 0x3e, 0x2d,
+					       0x31, 0x1a, 0x33, 0x33, 0x33, 0x52, 0x40,
+					       0x47, 0x38, 0x34, 0x26, 0x0e, 0x06, 0x7c,
+					       0x61, 0x4f, 0x42, 0x3e, 0x2d, 0x31, 0x1a,
+					       0x33, 0x33, 0x33, 0x52, 0x40, 0x47, 0x38,
+					       0x34, 0x26, 0x0e, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0xcc, 0x76, 0x12, 0x34, 0x44, 0x44,
+					       0x44, 0x44, 0x98, 0x04, 0x98, 0x04, 0x0f,
+					       0x00, 0x00, 0xc1);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x54, 0x94, 0x02, 0x85, 0x9f, 0x00,
+					       0x6f, 0x00, 0x54, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x17, 0x09, 0x08, 0x89, 0x08, 0x11,
+					       0x22, 0x20, 0x44, 0xff, 0x18, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x87, 0x47, 0x05, 0x05, 0x1c, 0x1c,
+					       0x1d, 0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f,
+					       0x0f, 0x0f, 0x0d, 0x0d, 0x13, 0x13, 0x11,
+					       0x11, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x06, 0x06, 0x04, 0x04, 0x1c, 0x1c,
+					       0x1d, 0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f,
+					       0x0e, 0x0e, 0x0c, 0x0c, 0x12, 0x12, 0x10,
+					       0x10, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x21, 0x00, 0x31, 0x42, 0x34, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0xcb, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcd, 0x0e, 0x4b, 0x4b, 0x20, 0x19, 0x6b,
+					       0x06, 0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd2, 0xe3, 0x2b, 0x38, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x00, 0x01, 0x00, 0x0e, 0x04, 0x44,
+					       0x08, 0x10, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x80, 0x09, 0xff, 0xff, 0xff, 0xff,
+					       0xff, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x12, 0x03, 0x20, 0x00, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0x00);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	return dsi_ctx.accum_err;
+}
+
 static int boe_th101mb31ig002_disable(struct drm_panel *panel)
 {
 	struct boe_th101mb31ig002 *ctx = container_of(panel,
@@ -115,12 +180,18 @@ static int boe_th101mb31ig002_disable(struct drm_panel *panel)
 						      panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
+	if (ctx->desc->backlight_off_to_display_off_delay_ms)
+		mipi_dsi_msleep(&dsi_ctx, ctx->desc->backlight_off_to_display_off_delay_ms);
+
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
 	mipi_dsi_msleep(&dsi_ctx, 120);
 
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
+	if (ctx->desc->enter_sleep_to_reset_down_delay_ms)
+		mipi_dsi_msleep(&dsi_ctx, ctx->desc->enter_sleep_to_reset_down_delay_ms);
+
 	return dsi_ctx.accum_err;
 }
 
@@ -134,6 +205,9 @@ static int boe_th101mb31ig002_unprepare(struct drm_panel *panel)
 	gpiod_set_value_cansleep(ctx->enable, 0);
 	regulator_disable(ctx->power);
 
+	if(ctx->desc->power_off_delay_ms)
+		msleep(ctx->desc->power_off_delay_ms);
+
 	return 0;
 }
 
@@ -151,6 +225,18 @@ static int boe_th101mb31ig002_prepare(struct drm_panel *panel)
 		return ret;
 	}
 
+	if (ctx->desc->vcioo_to_lp11_delay_ms)
+		msleep(ctx->desc->vcioo_to_lp11_delay_ms);
+
+	if (ctx->desc->lp11_before_reset) {
+		ret = mipi_dsi_dcs_nop(ctx->dsi);
+		if (ret)
+			return ret;
+	}
+
+	if (ctx->desc->lp11_to_reset_delay_ms)
+		msleep(ctx->desc->lp11_to_reset_delay_ms);
+
 	gpiod_set_value_cansleep(ctx->enable, 1);
 	msleep(50);
 	boe_th101mb31ig002_reset(ctx);
@@ -187,6 +273,36 @@ static const struct panel_desc boe_th101mb31ig002_desc = {
 	.init = boe_th101mb31ig002_enable,
 };
 
+static const struct drm_display_mode starry_er88577_default_mode = {
+	.clock	= (800 + 25 + 25 + 25) * (1280 + 20 + 4 + 12) * 60 / 1000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 25,
+	.hsync_end = 800 + 25 + 25,
+	.htotal = 800 + 25 + 25 + 25,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 20,
+	.vsync_end = 1280 + 20 + 4,
+	.vtotal = 1280 + 20 + 4 + 12,
+	.width_mm = 135,
+	.height_mm = 216,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct panel_desc starry_er88577_desc = {
+	.modes = &starry_er88577_default_mode,
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init = starry_er88577_init_cmd,
+	.lp11_before_reset = true,
+	.vcioo_to_lp11_delay_ms = 5,
+	.lp11_to_reset_delay_ms = 50,
+	.backlight_off_to_display_off_delay_ms = 100,
+	.enter_sleep_to_reset_down_delay_ms = 100,
+	.power_off_delay_ms = 1000,
+};
+
 static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
 					struct drm_connector *connector)
 {
@@ -312,6 +428,9 @@ static const struct of_device_id boe_th101mb31ig002_of_match[] = {
 	{ .compatible = "boe,th101mb31ig002-28a",
 	  .data = &boe_th101mb31ig002_desc
 	},
+	{ .compatible = "starry,er88577",
+	  .data = &starry_er88577_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, boe_th101mb31ig002_of_match);
-- 
2.17.1


