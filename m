Return-Path: <linux-kernel+bounces-197778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078A58D6F07
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 10:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256811C2200F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A85F13D25F;
	Sat,  1 Jun 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Bhw6wh1T"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D574413
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717231620; cv=none; b=AW681+a0PTuaMgcGdk/QU/i+9lgcibNNTTRD730e5zTHbuv75zezWUCHBsPTk6vSs8YAyAzv4d0nLQHCkJymFl0KaSCUsgOqOFlLYhWlecF4H7d7VjMYAsU1sM5NabPle2B28l1vXiZlktYetZ2HJPjBFDOW6AkDyjEtsdiIXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717231620; c=relaxed/simple;
	bh=f1i8qwtUWK1EEB++nbUewPg7VOgSvF7Lz1bgflZ70g4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mUtzJ89265cQBTRSDpovHa87a9bNzplodJs7RdKWQQed9ng8o9R+sWTGrKinzRJq0zbEkhZGhC0zhKn8YBYHLeUvJGuCSI7F49NUMgVue6W/xyO0LPpyBLPI4zJhy0MZJv7KI6HNZPl71hJQjUlQ7R644sG/6JYk9ajLehDFunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Bhw6wh1T; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2506bd2e0ecso1144993fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1717231615; x=1717836415; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WdStofeIHidQWGQHbHEHbFEr8TGeq7MYppuJY/a17KY=;
        b=Bhw6wh1TFBH0sQ+um8mqHOvqcCRMXKckl01gA31Q9ZRRLNq825DlnkFL2A4phWkPxl
         aXRyPhdbeb1yOU9V4K1yO0pAsaZ97RuVdYb0PPo9pW8nF7hrfHGcPYybeetS9JCE5zDQ
         VPVY+twG3s3xurhCpUdiWx/Z+EgtXq22NrZ8qJJ6vwS1W6XBzrHZ14wpATi59NuK+Oae
         VVybCAy6oNGxO5xeccjs5/w7WuYhSHO+UUlH0MJX5fVs8F7l4lSCyPLAwvUytV1jq3Nq
         fErOixREf5aiXwS9TGbAhFVxDsdKN8rpbpBFW2C0mGJJZAUbgO40NqfBHzuy1f3JWao/
         r0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717231615; x=1717836415;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdStofeIHidQWGQHbHEHbFEr8TGeq7MYppuJY/a17KY=;
        b=lYpvxnHGbXGA63EmzyZeWSVfiHRlafT0k/0bHlFfZIVYVbTPFJ68yJ56AHhbqz7tE1
         JB0CeGQV8Sf8f8ITGXjP17y/dcDVlE60G/KnprjUsy81hm6rrm1HsABjbRfny9nXQXCp
         /lhQBdcc6L+P37YFZjBpEBQ64vBIJcKWM9Tb02HG761l9MhgUx/LOc2Nfcd/SL19Y1Fx
         rd3Fm+m1dpcvaynX/nevM5Jm1c7wkcuU8UG6D5cGmqgQzFLW2ie39x/3TKvhhgyqbnRB
         LdHpY+UvCubLjWCwdQ5QwhF14KKm+Q3lOV0FsiPaezXOs0HD2Jpp49pza5kShVyizerq
         gcWA==
X-Forwarded-Encrypted: i=1; AJvYcCUPLm6o18f/tVTvqd5/0WLbxigVFDbXeyAqMNjMOr5Ds7QYG2JLAUWMzUqsqp3VoX8gpVd8swMp4wh2ZCtGW6Bb2sdC8EWbo6BPbOfK
X-Gm-Message-State: AOJu0YyTt1+eNth2FRsZxyTJH1U7tW3sze/RTv4IxznQ3+i/6V7HcrCH
	IzDyielvA61yZ9ky72dpd75VxMgBLrEVECEck11kuGnliYon3M53pl1gK605VSY=
X-Google-Smtp-Source: AGHT+IGRpeTD7Y6oQlX+Um34gHgDWOgMcMsabjxttzzAMT11iEgSrZ/YIhsSFD+d0/f6rTT4bu6JLA==
X-Received: by 2002:a05:6871:5898:b0:24c:ac7e:8a5c with SMTP id 586e51a60fabf-2508bd82416mr3874585fac.21.1717231614964;
        Sat, 01 Jun 2024 01:46:54 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423c7b49sm2512044b3a.37.2024.06.01.01.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 01:46:54 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v2 4/4] drm/panel: starry: add new panel driver
Date: Sat,  1 Jun 2024 16:45:28 +0800
Message-Id: <20240601084528.22502-5-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This Starry panel has the same timing as the Kingdisplay panel,
so add starry configuration in the Kingdisplay driver.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---

Chage since V2:

-  Add compatible for Starry er88577 in panel-kingdisplay-kd101ne3 drivers.

---
 .../drm/panel/panel-kingdisplay-kd101ne3.c    | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
index 8994a1c9afb5..b614d28475a6 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
@@ -267,6 +267,67 @@ static int kingdisplay_kd101ne3_init(struct kingdisplay_panel *kingdisplay)
 	return 0;
 };
 
+static int starry_er88577_init(struct kingdisplay_panel *kingdisplay)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = kingdisplay->dsi };
+
+	/* T5:HWreset to init_code >= 120ms */
+	msleep(120);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0xab, 0xba);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0xba, 0xab);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb1, 0x10, 0x01, 0x47, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x0c, 0x14, 0x04, 0x50, 0x50, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3, 0x56, 0x53, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb4, 0x33, 0x30, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0xb0, 0x00, 0x00, 0x10, 0x00, 0x10, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x05, 0x12, 0x29, 0x49, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x7c, 0x61, 0x4f, 0x42, 0x3e, 0x2d, 0x31,
+				     0x1a, 0x33, 0x33, 0x33, 0x52, 0x40, 0x47, 0x38, 0x34, 0x26,
+				     0x0e, 0x06, 0x7c, 0x61, 0x4f, 0x42, 0x3e, 0x2d, 0x31, 0x1a,
+				     0x33, 0x33, 0x33, 0x52, 0x40, 0x47, 0x38, 0x34, 0x26, 0x0e,
+				     0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0xcc, 0x76, 0x12, 0x34, 0x44, 0x44, 0x44,
+				     0x44, 0x98, 0x04, 0x98, 0x04, 0x0f, 0x00, 0x00, 0xc1);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x54, 0x94, 0x02, 0x85, 0x9f, 0x00, 0x6f,
+				     0x00, 0x54, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x17, 0x09, 0x08, 0x89, 0x08, 0x11, 0x22,
+				     0x20, 0x44, 0xff, 0x18, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x87, 0x47, 0x05, 0x05, 0x1c, 0x1c, 0x1d,
+				     0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f, 0x0f, 0x0f, 0x0d, 0x0d,
+				     0x13, 0x13, 0x11, 0x11, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x06, 0x06, 0x04, 0x04, 0x1c, 0x1c, 0x1d,
+				     0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f, 0x0e, 0x0e, 0x0c, 0x0c,
+				     0x12, 0x12, 0x10, 0x10, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x21, 0x00, 0x31, 0x42, 0x34, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0xcb, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcd, 0x0e, 0x4b, 0x4b, 0x20, 0x19, 0x6b, 0x06,
+				     0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd2, 0xe3, 0x2b, 0x38, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x00, 0x01, 0x00, 0x0e, 0x04, 0x44, 0x08,
+				     0x10, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x80, 0x09, 0xff, 0xff, 0xff, 0xff, 0xff,
+				     0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x12, 0x03, 0x20, 0x00, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0x00);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_EXIT_SLEEP_MODE);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
+
+	msleep(120);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_DISPLAY_ON);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
+
+	msleep(20);
+
+	return 0;
+};
+
 static inline struct kingdisplay_panel *to_kingdisplay_panel(struct drm_panel *panel)
 {
 	return container_of(panel, struct kingdisplay_panel, base);
@@ -391,6 +452,34 @@ static const struct panel_desc kingdisplay_kd101ne3_40ti_desc = {
 	.lp11_before_reset = true,
 };
 
+static const struct drm_display_mode starry_er88577_default_mode = {
+	.clock = 77380,
+	.hdisplay = 800,
+	.hsync_start = 800 + 80,
+	.hsync_end = 800 + 80 + 20,
+	.htotal = 800 + 80 + 20 + 80,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 20,
+	.vsync_end = 1280 + 20 + 4,
+	.vtotal = 1280 + 20 + 4 + 12,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct panel_desc starry_er88577_desc = {
+	.modes = &starry_er88577_default_mode,
+	.bpc = 8,
+	.size = {
+		.width_mm = 135,
+		.height_mm = 216,
+	},
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init = starry_er88577_init,
+	.lp11_before_reset = true,
+};
+
 static int kingdisplay_panel_get_modes(struct drm_panel *panel,
 			       struct drm_connector *connector)
 {
@@ -514,6 +603,9 @@ static const struct of_device_id kingdisplay_of_match[] = {
 	{ .compatible = "kingdisplay,kd101ne3-40ti",
 	  .data = &kingdisplay_kd101ne3_40ti_desc
 	},
+	{ .compatible = "starry,er88577",
+	  .data = &starry_er88577_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, kingdisplay_of_match);
-- 
2.17.1


