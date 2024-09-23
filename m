Return-Path: <linux-kernel+bounces-335915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C268897EC88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFF71F22066
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357E199FB7;
	Mon, 23 Sep 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Q6+ZBeSA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C619C543
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098981; cv=none; b=tqrBr55XNqEumSb1c3Waqnt7T3MWsrsDWEriGM42eaM9gx9DiTAhOs1B8RHSg4Urc6uqAldHvo0aJ4DQ+bK0OacuxyeW6SwImQv5wZgirTF6m9mh+2R0RCLPRHctFPDVrd0U937OJ90H8FPIiWcPTyGR4h3nIk9CWs7I9XSbBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098981; c=relaxed/simple;
	bh=n8TpS44kSkN16qOdnzjYpy71PGVjtdVAUD2J814I67k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cIKlF1vnnFizzsO2h1ydOSjLCN3J5Yn65i+BfcrMpRd2GQIzspO6VN9XJlCMxqNDejtOU4BwrMkhgzQdodsqZk5Qxgo8f6XedbjpQtB1ePFCpWwYRHyL4SENJvgmymx1BXbz92EWaR6gsIcqei+I/6L8UuTzOCKohA9lAdqFdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Q6+ZBeSA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-717880daae7so387069b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1727098976; x=1727703776; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lmi4LwsQVWVuhv2u7M387Utb1/3g/g58JnDuv7KUrV8=;
        b=Q6+ZBeSAdx2ohhVE3FOOwUSmX+RCpfrDuijm8gM7vvDdeXa5Y2DBodJuTw39+4Cn1p
         GjYzWnnkKhvBRBSuh+sOrOlMyLsEI6OkYPRLaaXXMWI9rLQhWIEDO1o6ypkgu7mVTOIm
         ZhI1gtUDj0B7MYUgWADUf6yOrCAm1/mN25mXTBSsy1qMdq73faNl4kg6CLCWBTT8Ddk9
         cqcqIxJgCvtttLI50lKdJ35L+HCl+iUftcCVRTTjLPVSMReRsWZMp3fwOZzghusUUslo
         6y+YXEI/1ZZ3ETl1kER+VdSJJRV2IGgZztVxTZify+Ujm3arUhxwPxWi2H4snxJ4qRDs
         FJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098976; x=1727703776;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmi4LwsQVWVuhv2u7M387Utb1/3g/g58JnDuv7KUrV8=;
        b=GR4GPbj9B+61YVpgGpV04sLjfalbIcAHkditGK4HjTheaebOoHfKAUqTVJy9UysLVE
         tYy8W2acQNVbSDwgw5atGkJiqmQ1lm/96Bdb5QMWYIoRn6gdzhSaDdW+ebMYO14xdQ7t
         WZYPhzefjgVsula1JYaXTOZp7jxHcW5dyGO79+1WvsZm5QtVTsTwUALEHPLOd3DpL25/
         7qlqSNRjt/1EiYxvwW/jxgJldNfEd9iX3gatamKDIif548wx42l92cw1P+vjEAMZ2+O+
         3DDA97/pLBfYSCbwEpaHJRpOjLnNDxb2A0c/w86RPYcKaEqshAkyk4APCPBMoVpp4L/f
         gk1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2Yola5NcQ2KWZXlUlkAb7URXzvcbenMVNFAOhNFmHrHD6jUIuL2MHW7JkF2ON99p4QvXm6wKHst/V14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxMj8cAC/9jFs9O0d90iETcM7ZpRGPVXapUQYw3WEqpaSxKKH
	+tIRRvC02yndAzwr/BkqHgcI2tDx6WKUakXIqNwU5x2mLmA4ae37ta1kLgIlcQg=
X-Google-Smtp-Source: AGHT+IFxg+CNVtD2TyiKjmB4Qulk1SqyU3c8EKJ4MqIDUQPspZnRPVur5vPqy0ENvEqgWxT5svosnA==
X-Received: by 2002:a05:6a00:3e17:b0:70e:acd0:d8b6 with SMTP id d2e1a72fcca58-7199c8456d1mr6829062b3a.0.1727098976235;
        Mon, 23 Sep 2024 06:42:56 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b97302sm14376009b3a.147.2024.09.23.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:42:55 -0700 (PDT)
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
Subject: [PATCH v2 2/2] drm/panel: boe-th101mb31ig002: Modify Starry panel timing
Date: Mon, 23 Sep 2024 21:42:27 +0800
Message-Id: <20240923134227.11383-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240923134227.11383-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240923134227.11383-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In MTK chips, if the system starts suspending before the DRM runtime 
resume has not completed, there is a possibility of a black screen 
after waking the machine. Reduce the disable delay resolves this issue, 

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


