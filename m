Return-Path: <linux-kernel+bounces-227342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE835914FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40BB2823D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F1176FC9;
	Mon, 24 Jun 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="tvjwOGAh"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72717C7DE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238880; cv=none; b=K28KaHNAymb2sG9tVnxrGl1MucsZMMGiZ4gcTtKPogtlfkHdnHVn7K0yo26oIavIYItJr+KLzB4h1boia3ayS/DTVegDwOqz1PAAPmiJ1SACXm/HwIaiuaEGuPOIdTjN9HAqRiM2CZD8tnSfuz/z066cbAUpS/DHeKKBDsD+ZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238880; c=relaxed/simple;
	bh=wS5mGoWOmn1Gm+T7795dV94G8D9IeP1cJuuMOF6PT7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=vGezq5sQqW5ICwIzV3BSjX0PPYheNdyX6hhllUnhbgNOq2iRyCUQLDUVKg+DXfvqJYnNrT1aZDWL2ttcNsbYSd/AEMvvbWjlEd/TMAbWW4agBbLr9aLsGGiHBBTC19WV52ub6G7oouCDkXMKg28bn61mPeyhu2kaI2ZCsxfoW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=tvjwOGAh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9de13d6baso28592925ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719238868; x=1719843668; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SvGBhyrwNZb2Wcf4/mhibXAUBrAcYT6iuCn9n+d6xXE=;
        b=tvjwOGAhXwvKC2zSHOviBheVIikHwU8uAqEJVZB45o5gEWzIvQFP/9pmxMjCI5oZsX
         uBpXeWil954MRdWYr2QIprooy37a4nJGMq/TjTd7AtHkGgjNbemgtD7IRBJkvjnyGLrz
         UoDE7a4bDqoUu8dn6CIWoP0QV1CEFVzWgRMq5t4udXeyUzUOzndrGmkHj599uEWJnovL
         ayRAKcRvnrVup/xmorTEBiwG/b9SyH/oo1rhlvpKeHnHDvfB1P8aAGO0iPT48bdIJwPP
         QrpaqEeA41EejRq/UAeNh27cIbnuR3JjRWihJKZwzcETXN4q1XPgV985MAoXyiSlBK0F
         EWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719238868; x=1719843668;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvGBhyrwNZb2Wcf4/mhibXAUBrAcYT6iuCn9n+d6xXE=;
        b=PSnhK4iwjhhp8ZSTUSPE+mOAhgszcTM1CO+9wzX87nriNw0ovFwRMZIWF+9OaeUVOM
         wVY02PF+e3F7OoQYJvTwwBEb+puQ3lt3LvcTbk4Hm1RsMzAGui9dDhFab4HCxaXa2QOv
         sHP6SOASq2SDFVZH2mh/IR6MvqocUu7d17Lxm2UlFf5a0FrwKbGy/CcNGFOBE8K3p5Il
         MNokTT4VixG87inxtRDd+Dw0MO2RnwukT31b1fQ0Rx5JzJn4kCiaIpYnerGTd5VW7faN
         IhoZp0DSIi684vWLRNDBz/8eQclHo6hiAAcgepoE1yMEexX4wf+Fx+ebgCLLBXhJkhB+
         6Gzg==
X-Forwarded-Encrypted: i=1; AJvYcCU1r2p9ICw2P38xEr8byuOQdGqEXYTFZO22n6iPIzj4dliVqJdHWvmp5yPLBFJhB+ubiDYDHTeV7nrnKgsysYdtMeFdliVmtUcwGxke
X-Gm-Message-State: AOJu0YzSf4/G6izjI9CfafE1PoBudG7BtYtaOWghfS9JZNnrX5DSfsPT
	OZ0iXoKLw5gTc2MGZIl4BPaB6r2tMi0zRVtoTN7Tgm9Gk/9XXS4tAOYc70FTQqU=
X-Google-Smtp-Source: AGHT+IF15aYpBSA+uNmk5kzixxlsuYpzE+OBUcqEver/B/oPhU099fqjFYZD7hW6gA/YX1ROeSHWZA==
X-Received: by 2002:a17:902:cecc:b0:1f8:67e4:397f with SMTP id d9443c01a7336-1fa23f227b5mr50831475ad.7.1719238868461;
        Mon, 24 Jun 2024 07:21:08 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5fa9sm63243855ad.206.2024.06.24.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:21:08 -0700 (PDT)
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
Subject: [PATCH v5 4/5] drm/panel: jd9365da: Support for kd101ne3-40ti MIPI-DSI panel
Date: Mon, 24 Jun 2024 22:19:25 +0800
Message-Id: <20240624141926.5250-5-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The K&d kd101ne3-40ti is a 10.1" WXGA TFT-LCD panel, use
jd9365da controller,which fits in nicely with the existing
panel-jadard-jd9365da-h3 driver.Hence,we add a new compatible
with panel specific config.

Although they have the same control IC, the two panels are different,
and the timing will be slightly different, so we added some variables
in struct jadard_panel_desc to control the timing.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V5 and V4:
-  1. Add a "_ms" suffix to the variables.
-  2. Use more "_multi" in the enable/disable function
-  3. Use mipi_dsi_dcs_write_seq_multi() in the init() function.

V4:https://lore.kernel.org/all/20240620080509.18504-4-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V4 and V3:
-  1. Use mipi_dsi_msleep.
-  2. Adjust the ".clock" assignment format.
-  3. Adjust "compatible" positions to keep the list sorted.

V3:https://lore.kernel.org/all/20240614145510.22965-4-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
-  1. Give up creating a new driver and re-add K&d kd101ne3-40ti 
-     configuration to the panel-jadard-jd9365da-h3.c driver.

V2:https://lore.kernel.org/all/20240601084528.22502-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  1. Use the new mipi_dsi_dcs_write_seq_multi() function.
-  2. Modify Move mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode() to disable(),
-  and drop kingdisplay_panel_enter_sleep_mode().
-  3. If prepare fails, disable GPIO before regulators.
-  4. This function drm_connector_set_panel_orientation() is no longer used. Delete it.
-  5. Drop ".shutdown = kingdisplay_panel_shutdown".

---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 277 ++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index e836260338bf..593e12b31ebd 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -27,6 +27,15 @@ struct jadard_panel_desc {
 	enum mipi_dsi_pixel_format format;
 	int (*init)(struct jadard *jadard);
 	u32 num_init_cmds;
+	bool lp11_before_reset;
+	bool reset_before_power_off_vcioo;
+	unsigned int vcioo_to_lp11_delay_ms;
+	unsigned int lp11_to_reset_delay_ms;
+	unsigned int exit_sleep_to_display_on_delay_ms;
+	unsigned int display_on_delay_ms;
+	unsigned int backlight_off_to_display_off_delay_ms;
+	unsigned int display_off_to_enter_sleep_delay_ms;
+	unsigned int enter_sleep_to_reset_down_delay_ms;
 };
 
 struct jadard {
@@ -53,8 +62,14 @@ static int jadard_enable(struct drm_panel *panel)
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
+	if (jadard->desc->exit_sleep_to_display_on_delay_ms)
+		mipi_dsi_msleep(&dsi_ctx, jadard->desc->exit_sleep_to_display_on_delay_ms);
+
 	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
+	if (jadard->desc->display_on_delay_ms)
+		mipi_dsi_msleep(&dsi_ctx, jadard->desc->display_on_delay_ms);
+
 	return dsi_ctx.accum_err;
 }
 
@@ -63,10 +78,19 @@ static int jadard_disable(struct drm_panel *panel)
 	struct jadard *jadard = panel_to_jadard(panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 
+	if (jadard->desc->backlight_off_to_display_off_delay_ms)
+		mipi_dsi_msleep(&dsi_ctx, jadard->desc->backlight_off_to_display_off_delay_ms);
+
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
+	if (jadard->desc->display_off_to_enter_sleep_delay_ms)
+		mipi_dsi_msleep(&dsi_ctx, jadard->desc->display_off_to_enter_sleep_delay_ms);
+
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
+	if (jadard->desc->enter_sleep_to_reset_down_delay_ms)
+		mipi_dsi_msleep(&dsi_ctx, jadard->desc->enter_sleep_to_reset_down_delay_ms);
+
 	return dsi_ctx.accum_err;
 }
 
@@ -83,6 +107,18 @@ static int jadard_prepare(struct drm_panel *panel)
 	if (ret)
 		return ret;
 
+	if (jadard->desc->vcioo_to_lp11_delay_ms)
+		msleep(jadard->desc->vcioo_to_lp11_delay_ms);
+
+	if (jadard->desc->lp11_before_reset) {
+		ret = mipi_dsi_dcs_nop(jadard->dsi);
+		if (ret)
+			return ret;
+	}
+
+	if (jadard->desc->lp11_to_reset_delay_ms)
+		msleep(jadard->desc->lp11_to_reset_delay_ms);
+
 	gpiod_set_value(jadard->reset, 1);
 	msleep(5);
 
@@ -106,6 +142,12 @@ static int jadard_unprepare(struct drm_panel *panel)
 	gpiod_set_value(jadard->reset, 1);
 	msleep(120);
 
+	if (jadard->desc->reset_before_power_off_vcioo) {
+		gpiod_set_value(jadard->reset, 0);
+
+		usleep_range(1000, 2000);
+	}
+
 	regulator_disable(jadard->vdd);
 	regulator_disable(jadard->vccio);
 
@@ -569,6 +611,237 @@ static const struct jadard_panel_desc cz101b4001_desc = {
 	.init = cz101b4001_init_cmds,
 };
 
+static int kingdisplay_kd101ne3_init_cmds(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xc7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xc7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x7e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x61);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x39);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x61);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x39);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x52);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x4c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x53);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x51);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x4d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x13);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x75);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0xb4);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xbb);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x61);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+
+	return dsi_ctx.accum_err;
+};
+
+static const struct jadard_panel_desc kingdisplay_kd101ne3_40ti_desc = {
+	.mode = {
+		.clock		= (800 + 24 + 24 + 24) * (1280 + 30 + 4 + 8) * 60 / 1000,
+
+		.hdisplay	= 800,
+		.hsync_start	= 800 + 24,
+		.hsync_end	= 800 + 24 + 24,
+		.htotal		= 800 + 24 + 24 + 24,
+
+		.vdisplay	= 1280,
+		.vsync_start	= 1280 + 30,
+		.vsync_end	= 1280 + 30 + 4,
+		.vtotal		= 1280 + 30 + 4 + 8,
+
+		.width_mm	= 135,
+		.height_mm	= 216,
+		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+	},
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init = kingdisplay_kd101ne3_init_cmds,
+	.lp11_before_reset = true,
+	.reset_before_power_off_vcioo = true,
+	.vcioo_to_lp11_delay_ms = 5,
+	.lp11_to_reset_delay_ms = 10,
+	.exit_sleep_to_display_on_delay_ms = 120,
+	.display_on_delay_ms = 20,
+	.backlight_off_to_display_off_delay_ms = 100,
+	.display_off_to_enter_sleep_delay_ms = 50,
+	.enter_sleep_to_reset_down_delay_ms = 100,
+};
+
 static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -637,6 +910,10 @@ static const struct of_device_id jadard_of_match[] = {
 		.compatible = "chongzhou,cz101b4001",
 		.data = &cz101b4001_desc
 	},
+	{
+		.compatible = "kingdisplay,kd101ne3-40ti",
+		.data = &kingdisplay_kd101ne3_40ti_desc
+	},
 	{
 		.compatible = "radxa,display-10hd-ad001",
 		.data = &cz101b4001_desc
-- 
2.17.1


