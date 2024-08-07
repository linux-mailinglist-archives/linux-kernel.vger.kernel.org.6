Return-Path: <linux-kernel+bounces-277707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D585594A504
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965BB282D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB41D3649;
	Wed,  7 Aug 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="WJ6PTJj7"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51601D2F51
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025088; cv=none; b=XomyIhli+Wwi2i6OevGy44Lr0J03vCuVtB0mU5nbwRhBLYveScIQxxiGpDsrnThx2SJIbHzKIL8xN5h390OA00ad1HN1OFWa9IG9s1v/QMPLJ/qT72IZ7niv88AXb/QVst5+gDtF5NQECfQA+DRo1rx2t+hdn9tMnTJtstpcuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025088; c=relaxed/simple;
	bh=h5PwanRWo0hRZrjyL8ceM2+ETwSQTNvkD3omPGo/98E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TqAQI3t0kZZYrkedlhxErFNFVpzdnaqMsi9kY8bCs/x5XE7ENoa72ele+7M+U5VztLDzhwZ287gmSGLfNWwqbIgSyvJz33bSJwB0QBAV8bAqifZaxqBP9q1fsraUN/NnYrP7j1CItaIdwybS7H/zmwvhR5FXKyvdhrcq3LT9QBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=WJ6PTJj7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so1140923b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1723025086; x=1723629886; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XxHvlW+GPIrL16ohKwLK8Pe/MaSBIU8AXjIyW7SHLSE=;
        b=WJ6PTJj77/qtER6pAevBoc71TSBkeU5R453chvm0yODsEGLR84/kJ5pYzlood3KWyq
         D+Aro6A8572rucUCcrqP/tt/wBD54Vbz0iZiqQJvty7z8IY3KChAcwnxCU/WRkrk/+NH
         vo0FvOJAjSQ33GxzRGd+UBEeAtPvadb3UUXxI77xrFZIMotTk+DLKD8VQmsCwcMictK/
         xgGjju+nepCw+WlYvfPdP8MFivAZDcVbC4JzbO3j64r/CI9H8FnZIBqpJ9tpQ61HxF3m
         7HyUfuFonb39jNfhFhcO/78cWPp/4PH/kMm/rHWoWaIW/Ee9ZfTARFYXneVngMQanp/7
         /2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723025086; x=1723629886;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxHvlW+GPIrL16ohKwLK8Pe/MaSBIU8AXjIyW7SHLSE=;
        b=F7m4tj99B/tC5bIhVEKS6RodEMYuHZPyv66rqWt0w0/dd+tbCHGgcb09mNHbtwqeg0
         rvyhAcpKaqxEu7JSapk+ESN9bDiPAtg50QOLdKLccB9Ujd90pUlCI5saiqTyJc0dYd1H
         Uenrwf2+m+eB+ip7ch6zULATLmNCJVifE0VQcOBEsasF9ZGcQrhXhstI23lWgBoypbBR
         jRG7gY2jqhW8T+ToG9zW4k0LHKXjlWF68Grb9yis3tv/gl7HWMGMQOjEgsBCa4DrPruq
         NfjyNiSlS5rqAuN8x94ECqZkLO3m5ByGFQxoAq667Tp1uynz56za+yCcOj1zsIF+eIJj
         ZWpw==
X-Forwarded-Encrypted: i=1; AJvYcCWfoyYLvqKoxhwd55anpedjqEoevf9b8EcWyY/Yt1F1NL+gi1YMAah7SBChq0D7KQkxLke5goLmNeWnWroK6c8JdshJP88YZ4cknz/R
X-Gm-Message-State: AOJu0Yx0p/DQFMhQwyu0xepiCIZ2C98Heww8HXpr9yd4STICG5zuYeQq
	AskKu7Q3S1YDYauS39+IVsga7rcM9vfkfpUA4k33YE3gLBT3TviIaMIMN5OEfNU=
X-Google-Smtp-Source: AGHT+IHx0fnYhknx7Pb72V9GMhWIWX7/L6foCBec3QTiwVs9nHU+yz25MljxI78JpzydsflHwhqQeA==
X-Received: by 2002:a05:6a20:6a0a:b0:1c3:b102:bfd2 with SMTP id adf61e73a8af0-1c699580a4cmr24278664637.14.1723025085878;
        Wed, 07 Aug 2024 03:04:45 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdff89sm8119248b3a.103.2024.08.07.03.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:04:45 -0700 (PDT)
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
	jagan@edgeble.ai,
	dmitry.baryshkov@linaro.org,
	jani.nikula@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 1/2] drm/panel: jd9365da: Move "exit sleep mode" and "set display on" cmds
Date: Wed,  7 Aug 2024 18:04:28 +0800
Message-Id: <20240807100429.13260-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240807100429.13260-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240807100429.13260-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Move the "exit sleep mode" and "set display on" command from
enable() to init() function.

As mentioned in the patch:
https://lore.kernel.org/all/20240624141926.5250-2-lvzhaoxiong@huaqin.corp-partner.google.com/

The Mediatek Soc DSI host has different modes in prepare() and
enable() functions, prepare() is in LP mode and enable() is in
HS mode. Since the "exit sleep mode" and "set display on"
command must also be sent in LP mode, so we also move "exit
sleep mode" and "set display on" command to the init() function.

We have no other actions in the enable() function after moves
"exit sleep mode" and "set display on", and we checked the call
of the enable() function during the "startup" process. It seems
that only one judgment was made in drm_panel_enabel(). If the
panel does not define enable(), the judgment will skip the
enable() and continue execution. This does not seem to have
any other effect, and we found that some drivers also seem
to have no enable() function added, for example:
panel-asus-z00t-tm5p5-n35596 / panel-boe-himax8279d...
In addition, we briefly tested the kingdisplay_kd101ne3 panel and
melfas_lmfbx101117480 panel, and it seems that there is no garbage
on the panel, so we delete enable() function.

After moving the "exit sleep mode" and "set display on" command
to the init() function, we no longer need additional delay
judgment, so we delete variables "exit_sleep_to_display_on_delay_ms"
and "display_on_delay_ms".

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V3 and V2:
-  1. The code has not changed, Just modified the nit in the commit 
-     information mentioned by Doug.
v2: https://lore.kernel.org/all/20240806034015.11884-2-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  1. The code has not changed, Modify the commit information.
v1: https://lore.kernel.org/all/20240725083245.12253-2-lvzhaoxiong@huaqin.corp-partner.google.com/
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


