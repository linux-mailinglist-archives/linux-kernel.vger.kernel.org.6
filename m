Return-Path: <linux-kernel+bounces-341558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A655098819C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356211F2256A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083651BAED8;
	Fri, 27 Sep 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="CcLgHUi5"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D1E1BBBEB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430254; cv=none; b=WtcMO92vo4M6DtMqHWODxue9FrPC5YO5eN306CVmT6mSOSE1TsAao9UOU3qG79kEdSdHagYheydi4n8fAKnM9U3BxKMZHIqy0v6iIvJUEj4wAxX3FSlCDC8LgRfvc0fYrIZ7LTbjlr8TaE5Js8rMStQjF04bLoIpta5eTKZO8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430254; c=relaxed/simple;
	bh=HcCP2rekDd7lA+V0zfMNj7Eaud2KbIIRS5cNTt4Dysk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oHPQMmVKUwQJK4qrWWOa09fmRtmukAAaLx736u/SLri4h9lPWFgAVHq4AZuv9gf9mPltGznPObGkt4f65zRlddtjdMCgyNeR967hKDqGbkRJgdCpFiD7dRwYxfQvYRVcbSvjvrIQVRZIWdQF0D/o2YXN65EoUPtQuj+lTKewh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=CcLgHUi5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e0c2e42b75so107759a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1727430252; x=1728035052; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6vXo/QBqbRSPcyQ8x6xHYpiZBOONjq8OugZwsB+apMA=;
        b=CcLgHUi5g9lfWHEIpZn7vx/cOFF8ZpVi72+Z9ZZgy/xXxNUCB1bHBzCfBLZMRgGUIJ
         u5YzNXMTwjaISe8IlHnqvGUJY63sV/OJ8pGps0FTp6pPBSgQBq0ktcH2igx9BgNeL6Qs
         ujiTsGxx0hPF+qIwcK53kT8Adfivs2uhxtlqOiW3tC9qiQrcoBAvngM1oCrNrfla7Zo8
         tgr5r4FMo4R3uNK9t0rJlrlpl7mRGoGSO4+KxAhaaG07SDe7LUDTLVz3mCdykYglYgFF
         THWmbACxCIpU1DP597C4kozNut2w0CWVRuu86fpTyBUivn6tQPbgQhel58pmh9A87Nqp
         cNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727430252; x=1728035052;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vXo/QBqbRSPcyQ8x6xHYpiZBOONjq8OugZwsB+apMA=;
        b=gJyUlMDerD+IegDQtdL6yNEKCqF8SUDY9fiDpO2G7lBXsMJ1NAeT1BvFXbq8z4r+mD
         Y5rKN+CTDHvX8YWVCCAGP6J+bGTxHaHc41KBAG3Z71gO6Mil7UwJ9tM8n1J5ABjRs9hS
         J6UQQXoA1RNJ8bbg1cnGbScM/1AGl+UFFaBwQf/OlfW8p94ajqEleBsfc5UTZYKEc1c7
         shlHEdvixMa0uKkok4JbuYqOYrhrKwFwfKz3P5nLu4hX4CYtVqJpTd/+snFloyogSYXN
         Z0JtSZvu850+w4VWxhnh8vqARoDb9YpqoGMHMmNwTsEwa8MHfjO+pao7EShWj0bUHvhe
         dZBw==
X-Forwarded-Encrypted: i=1; AJvYcCVozFQoH8HpqtliwQW4IBJtAxZzrzHRHJlt8T8S1EIuVsQ72RUTCjH5hqQBVjQsYMwujZMnPpqX8cfIDiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbINoZPmGc6lKA+6aq2rBr8doUOasMuUhExo0apRI7jSQRa6Tf
	D3xaiMhuUU7EZyGaB0HAzI/F63nJAPD1bqEqZPSvzYfiD9H8yw0t3MV1oT+Z+iw=
X-Google-Smtp-Source: AGHT+IE7RZB9BJpIiNesgL3dY0bxd4GYrJD5iq+grbfZ17f5PpYAXUaASOupLwHC3H3KxQnpst0sMw==
X-Received: by 2002:a17:90a:d802:b0:2da:71f8:7ff with SMTP id 98e67ed59e1d1-2e0b8e841bfmr1312757a91.5.1727430251873;
        Fri, 27 Sep 2024 02:44:11 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1bae46sm5105895a91.22.2024.09.27.02.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:44:11 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dianders@chromium.org,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v3 2/2] drm/panel: boe-th101mb31ig002: Modify Starry panel timing
Date: Fri, 27 Sep 2024 17:43:40 +0800
Message-Id: <20240927094340.18544-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240927094340.18544-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240927094340.18544-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In MTK chips, if the DRM runtime resume has not yet completed and the
system enters sleep mode at the same time, there is a possibility of
a black screen after waking the machine. Reduce the disable delay
resolves this issue,

The "backlight_off_to_display_off_delay_ms" was added between
"backlight off" and "display off"  to prevent "display off" from being
executed when the backlight is not fully powered off, which may cause
a white screen. However, we removed this
"backlight_off_to_display_off_delay_ms" and found that this situation
did not occur. Therefore, in order to solve the problem mentioned
above, we removed this delay, and the delay between "display off" and
"enter sleep" is not defined in the spec, so we reduce it from 120ms
to 50ms.

In addition, T14 >= 120ms, so we change
"enter_sleep_to_reset_down_delay_ms" from 100ms to 120ms.

The panel spec:
1. https://github.com/Vme5o/power-on-off-sequential

Fixes: e4bd1db1c1f7 ("drm/panel: boe-th101mb31ig002: Support for starry-er88577 MIPI-DSI panel")

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V3 and V2:
-  1. Modify the commit message 
v2: https://lore.kernel.org/all/20240923134227.11383-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  1. Modify the commit message.
-  2. Delete the value of backlight_off_to_display_off_delay_ms.
-  3. Modify the value of enter_sleep_to_reset_down_delay_ms from 100ms to 120ms.
v1: https://lore.kernel.org/all/20240915080830.11318-3-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 .../gpu/drm/panel/panel-boe-th101mb31ig002-28a.c    | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 0b87f1e6ecae..9e4d91c7c394 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -29,7 +29,7 @@ struct panel_desc {
 	bool lp11_before_reset;
 	unsigned int vcioo_to_lp11_delay_ms;
 	unsigned int lp11_to_reset_delay_ms;
-	unsigned int backlight_off_to_display_off_delay_ms;
+	unsigned int display_off_to_enter_sleep_delay_ms;
 	unsigned int enter_sleep_to_reset_down_delay_ms;
 	unsigned int power_off_delay_ms;
 };
@@ -184,12 +184,10 @@ static int boe_th101mb31ig002_disable(struct drm_panel *panel)
 						      panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	if (ctx->desc->backlight_off_to_display_off_delay_ms)
-		mipi_dsi_msleep(&dsi_ctx, ctx->desc->backlight_off_to_display_off_delay_ms);
-
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	mipi_dsi_msleep(&dsi_ctx, 120);
+	if (ctx->desc->display_off_to_enter_sleep_delay_ms)
+		mipi_dsi_msleep(&dsi_ctx, ctx->desc->display_off_to_enter_sleep_delay_ms);
 
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
@@ -275,6 +273,7 @@ static const struct panel_desc boe_th101mb31ig002_desc = {
 			  MIPI_DSI_MODE_NO_EOT_PACKET |
 			  MIPI_DSI_MODE_LPM,
 	.init = boe_th101mb31ig002_enable,
+	.display_off_to_enter_sleep_delay_ms = 120,
 };
 
 static const struct drm_display_mode starry_er88577_default_mode = {
@@ -302,8 +301,8 @@ static const struct panel_desc starry_er88577_desc = {
 	.lp11_before_reset = true,
 	.vcioo_to_lp11_delay_ms = 5,
 	.lp11_to_reset_delay_ms = 50,
-	.backlight_off_to_display_off_delay_ms = 100,
-	.enter_sleep_to_reset_down_delay_ms = 100,
+	.display_off_to_enter_sleep_delay_ms = 50,
+	.enter_sleep_to_reset_down_delay_ms = 120,
 	.power_off_delay_ms = 1000,
 };
 
-- 
2.17.1


