Return-Path: <linux-kernel+bounces-261937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C87393BE05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DB31F21D64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493EE17A5AC;
	Thu, 25 Jul 2024 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="srxC0pOy"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E8C176AC1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896389; cv=none; b=JlCI8Va/TSOGXPsRfxnRUhd1hq86hHVpK2sQ3yd5DcR+Y4cn/N437JhesjX5SIIvmdGpyUJQRbUOLkOpKOrcJwvHhX5bYqNdJyuhUmogoxHo1Dcix9n3cLe+my8jQe+Uh+yukqRnFB+1Ss3CjL6NALdOSxJSYQPAH9q0o89AsmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896389; c=relaxed/simple;
	bh=tRwiaIREmNyUclfaZ0U3ccAP2vX2NOjaodM4tLC9coU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HUfYSSApGCD5vxXPuuWFaeCRuWosabYyCZrCkZsH6Jp2gnmg8kSI8vcE1bnWGWaYv+SStuKRBo3Tzr5KAt+WnEG/+0AhTwahWgcO8tVOU+pBhzKvgEMj++BhgqMILR5WNsEU8ACVLntr8O/W5eBDdWPZPcFCih0DeSfDrnGGyzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=srxC0pOy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc49c0aaffso5054895ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721896385; x=1722501185; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P1cIyFfiNPgofzsFP+k9uE4hAkyuSgiUQpvXenggHas=;
        b=srxC0pOyW+cXh3M53aie/yqVtwNi78qUO+yZVWGDOoltg5Mm+x1CRW2t1lS3sb1KBj
         Qrx3jezd/BtNLre2FpdiF8BgiUmcgGvGt9cF3r2fq6GUrGanmD+2xu0H6wlw5i2QXTmc
         QWAsYGiYtMi6BE0orXUtvMwl2ga14BdIRri9gu1PUqDqJ9Ld0HDCD6Z8aLwlvFIfQbJH
         MO6k+ct2rF6XKJV5grAzDKe723OyaH12p7W181Ys/HisvnoA2JSnBULz7U1eUib1bFxu
         381Aw4qd36PdOOQAlwsboohfypRZG+7+VghoPyssmff8fg25MS8nwIIAf+/WyvHgFfHq
         DdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721896385; x=1722501185;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1cIyFfiNPgofzsFP+k9uE4hAkyuSgiUQpvXenggHas=;
        b=nhYcm0Q22bdd9whdAhFTNWTKRQW0iqx8iIxBWvHXaJSu3b/Fd3HygIgAvyGO34QI39
         5F/3VTslIqefVBKFEXsYgljD8GertvEGzmQfChtnJqx/8TQwXHekzHmboGl59EIPcWBG
         KW1crTcneC3x614Bp5XlVb+0UuuQO0Mo1YxAoF7n5vJJk+DaS8h79B9v9OWZw5OzLoFs
         4NIALGPNZ9ND/2luiaU883nP+z36xhrvoJyirawbEKcM6irMnRKpgRcZvGiKZA/Qzp3b
         N+UOn76rSXf3poa/HiH0fmgoGgjR0HS1A47JS8lBebPGppspu4LzzmtvaEUGcIoC8qJk
         4/2g==
X-Forwarded-Encrypted: i=1; AJvYcCV5QPFuU2sQ5BtL8a4XD6IMaT0oYs/TXNikKYrLULOW7Ne4WFG4sjpbrF/4ezKqjysOEqAAcfc1410JJu5KZViHSLpPIXd6aDfEG0DD
X-Gm-Message-State: AOJu0YxgX1v3Lyf1SmSthxz8HEBvp0QfCt1kK00czKkiQyCdpR+U4WAZ
	7AUFB+uPV2Qh3mCh5YUZWNPBv56NGj9RQnUKwiVqOYIEw10LqVIMdQzwtXXbiPE=
X-Google-Smtp-Source: AGHT+IHTS8RJYTflUeDiBY/hXiRtL6ZK1PFmiCuWqxGoTA8NI92QylQX8WpBgHaNKPCfbFzqtkQgjg==
X-Received: by 2002:a17:902:f68d:b0:1f9:c508:acd5 with SMTP id d9443c01a7336-1fed920b957mr14508575ad.5.1721896385467;
        Thu, 25 Jul 2024 01:33:05 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff9086sm8595595ad.302.2024.07.25.01.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 01:33:04 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dianders@chromium.org,
	hsinyi@google.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jagan@edgeble.ai
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/2] drm/panel: jd9365da: Move the sending location of the 11/29 command
Date: Thu, 25 Jul 2024 16:32:44 +0800
Message-Id: <20240725083245.12253-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240725083245.12253-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Move the 11/29 command from enable() to init() function

As mentioned in the patch:
https://lore.kernel.org/all/20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Our DSI host has different modes in prepare() and enable()
functions. prepare() is in LP mode and enable() is in HS mode.
Since the 11/29 command must also be sent in LP mode,
so we also move 11/29 command to the init() function.

After moving the 11/29 command to the init() function,
we no longer need additional delay judgment, so we delete
variables "exit_sleep_to_display_on_delay_ms" and
"display_on_delay_ms".

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 59 ++++++++++---------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 04d315d96bff..ce73e8cb1db5 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -31,8 +31,6 @@ struct jadard_panel_desc {
 	bool reset_before_power_off_vcioo;
 	unsigned int vcioo_to_lp11_delay_ms;
 	unsigned int lp11_to_reset_delay_ms;
-	unsigned int exit_sleep_to_display_on_delay_ms;
-	unsigned int display_on_delay_ms;
 	unsigned int backlight_off_to_display_off_delay_ms;
 	unsigned int display_off_to_enter_sleep_delay_ms;
 	unsigned int enter_sleep_to_reset_down_delay_ms;
@@ -66,26 +64,6 @@ static inline struct jadard *panel_to_jadard(struct drm_panel *panel)
 	return container_of(panel, struct jadard, panel);
 }
 
-static int jadard_enable(struct drm_panel *panel)
-{
-	struct jadard *jadard = panel_to_jadard(panel);
-	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
-
-	msleep(120);
-
-	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
-
-	if (jadard->desc->exit_sleep_to_display_on_delay_ms)
-		mipi_dsi_msleep(&dsi_ctx, jadard->desc->exit_sleep_to_display_on_delay_ms);
-
-	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
-
-	if (jadard->desc->display_on_delay_ms)
-		mipi_dsi_msleep(&dsi_ctx, jadard->desc->display_on_delay_ms);
-
-	return dsi_ctx.accum_err;
-}
-
 static int jadard_disable(struct drm_panel *panel)
 {
 	struct jadard *jadard = panel_to_jadard(panel);
@@ -202,7 +180,6 @@ static const struct drm_panel_funcs jadard_funcs = {
 	.disable = jadard_disable,
 	.unprepare = jadard_unprepare,
 	.prepare = jadard_prepare,
-	.enable = jadard_enable,
 	.get_modes = jadard_get_modes,
 	.get_orientation = jadard_panel_get_orientation,
 };
@@ -382,6 +359,12 @@ static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
 
 	jd9365da_switch_page(&dsi_ctx, 0x00);
 
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
 	return dsi_ctx.accum_err;
 };
 
@@ -608,6 +591,12 @@ static int cz101b4001_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE6, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE7, 0x0C);
 
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
 	return dsi_ctx.accum_err;
 };
 
@@ -831,6 +820,16 @@ static int kingdisplay_kd101ne3_init_cmds(struct jadard *jadard)
 
 	jd9365da_switch_page(&dsi_ctx, 0x00);
 
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
 	return dsi_ctx.accum_err;
 };
 
@@ -859,8 +858,6 @@ static const struct jadard_panel_desc kingdisplay_kd101ne3_40ti_desc = {
 	.reset_before_power_off_vcioo = true,
 	.vcioo_to_lp11_delay_ms = 5,
 	.lp11_to_reset_delay_ms = 10,
-	.exit_sleep_to_display_on_delay_ms = 120,
-	.display_on_delay_ms = 20,
 	.backlight_off_to_display_off_delay_ms = 100,
 	.display_off_to_enter_sleep_delay_ms = 50,
 	.enter_sleep_to_reset_down_delay_ms = 100,
@@ -1074,6 +1071,16 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe7, 0x06);
 
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
 	return dsi_ctx.accum_err;
 };
 
@@ -1102,8 +1109,6 @@ static const struct jadard_panel_desc melfas_lmfbx101117480_desc = {
 	.reset_before_power_off_vcioo = true,
 	.vcioo_to_lp11_delay_ms = 5,
 	.lp11_to_reset_delay_ms = 10,
-	.exit_sleep_to_display_on_delay_ms = 120,
-	.display_on_delay_ms = 20,
 	.backlight_off_to_display_off_delay_ms = 100,
 	.display_off_to_enter_sleep_delay_ms = 50,
 	.enter_sleep_to_reset_down_delay_ms = 100,
-- 
2.17.1


