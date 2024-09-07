Return-Path: <linux-kernel+bounces-319816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF221970294
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 16:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5000D2833B0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701F15C14F;
	Sat,  7 Sep 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+sWCVYL"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58BC4502F
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725717707; cv=none; b=UiC7aZ5283jAdUMUE9CFNTloh55H++3DjlgXzzaIFTmpUK6JJncGz9pytXwscp6klBchx7uubUZzIjzJrcZ1vNuoZedeptKSpAh69MF92yeg4fToowIMMJy9t7+P8KA2WRxVTNrxoga0XT+wBqjBGHnq1yP9faK1VERcv2N7ewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725717707; c=relaxed/simple;
	bh=NTzcEOBZTwlNbZ8AOJbIZw31M1ae8YahyZI5KwgENbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baYBZdhm1HQQBdFXe07I08Xu536WqZcrKgYWpJFh6LNGQKGB0fk3RmBGcZq0qKgNXkoHKQMgS3i8Tt4EL9nFKLdXKkERv1CJAz/jEsBFSHCxSmx/CyqTqbvBjb0IToj+F6ry99wG9Zxif+rHOh1G7CLWs/rLy4vRPOnxobCLer0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+sWCVYL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso2529935b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725717705; x=1726322505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yo5z6YbpFCbyn45YhRjk1uY7oiivyYsSSZRIxOYV05w=;
        b=D+sWCVYLr4AutZzJE3BKug7EQAFoF/mW0Lp/R8+7LomB6cU5+RreZ8GxKeN0rm05ex
         JmlQwL4wj4Nj7BoXIPk5fZ2ChvSrOhPHkhjTBX38ONtS7urK4mhf/gYBGP8lbDopAvnE
         4h7moHRbS1PTc1t99DNSLnkezYNkkeFZHtPO9HWqeOiqswrPlhH0F5k8C+UrufRLZppQ
         yBaOpkm/lLrPiSLcLpcbcrmPy0KIHmhmDvJgFiNMin0F6K95nyRrabAw3G9GjH1vbkh+
         iw9WVL49LzXxc4JRXNmZX4wVvZPCNyL4YgUtP1W8WDDcCGpNnEBHYzPtBhyI0jTCZWoj
         Tt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725717705; x=1726322505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yo5z6YbpFCbyn45YhRjk1uY7oiivyYsSSZRIxOYV05w=;
        b=DNhKSIyMsEH9Gw1QuYA2KX5lwG/3C9QzP4FSGhgkB0uJQEAeCCI1ZNTwXqwEgtYhst
         kzb/NQafBGsK1aHoITJxzbpwa2U6CCAGicW2bcwOILkpp2J9fftV+5bPQ8qcfWHSwXbv
         BCgBBn9Rv/71rM7F4EwNRee7kEBry0r+QZr9Z3NIwkbQEaxfsKp90L1JnlXgt3S+l6xZ
         PduxZfme5ZyEtkouX6AaQ0XJuAbr3aA1spsGZszUQatDXveDseAfsgO0D36kB4OLyglq
         fmsFaa/yKFhikZzi8/LQ8Ai8MDbGOoa2kQ+QBVy9O+e46kVoVIetBD91PEhdP8sq+ICc
         MwHg==
X-Forwarded-Encrypted: i=1; AJvYcCWZWKlyH9li7CZt0a++RlKmXteAKkq5Usg1SkWbYYSgLzmm4ydiwsaUTBfNt3fwxyAwUlNtHqcv6wWW5jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Qg1oc+9KFL/7loDdlGGAESwm3LitLk99p2WFtOvIvGjczAWW
	uyNaWpEMPguRAT+RBY9hKtxjfeTpRP/AWn94s2HBPAQJUnoMb/LA
X-Google-Smtp-Source: AGHT+IGpqmqTNRmwfY/bZDZsLNpspnrjrnzEOH1n3LP9HaM8oIrON1a1L3mL3prDKSrR4TjZIAul6A==
X-Received: by 2002:a05:6a00:1a8b:b0:704:2563:5079 with SMTP id d2e1a72fcca58-718d5f1b705mr7533743b3a.27.1725717704642;
        Sat, 07 Sep 2024 07:01:44 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58b2e1bsm914232b3a.52.2024.09.07.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 07:01:44 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH] drm/panel: raydium-rm69380: transition to mipi_dsi wrapped functions
Date: Sat,  7 Sep 2024 19:31:30 +0530
Message-ID: <20240907140130.410349-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the raydium-rm69380 panel to use multi style functions for
improved error handling.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-raydium-rm69380.c | 95 ++++++-------------
 1 file changed, 30 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm69380.c b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
index 4dca6802faef..bdab844dab55 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm69380.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
@@ -46,108 +46,73 @@ static void rm69380_reset(struct rm69380_panel *ctx)
 static int rm69380_on(struct rm69380_panel *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi[0];
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 	if (ctx->dsi[1])
 		ctx->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd4);
-	mipi_dsi_dcs_write_seq(dsi, 0x00, 0x80);
-	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd0);
-	mipi_dsi_dcs_write_seq(dsi, 0x48, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x26);
-	mipi_dsi_dcs_write_seq(dsi, 0x75, 0x3f);
-	mipi_dsi_dcs_write_seq(dsi, 0x1d, 0x1a);
-	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x28);
-	mipi_dsi_dcs_write_seq(dsi, 0xc2, 0x08);
-
-	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear on: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(20);
-
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-	msleep(36);
-
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xd4);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0xd0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfe, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x08);
+
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 36);
+
+	return dsi_ctx.accum_err;
 }
 
-static int rm69380_off(struct rm69380_panel *ctx)
+static void rm69380_off(struct rm69380_panel *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi[0];
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 	if (ctx->dsi[1])
 		ctx->dsi[1]->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
-	msleep(35);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(20);
-
-	return 0;
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 35);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
 }
 
 static int rm69380_prepare(struct drm_panel *panel)
 {
 	struct rm69380_panel *ctx = to_rm69380_panel(panel);
-	struct device *dev = &ctx->dsi[0]->dev;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable regulators: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0) 
+		return ret;	
 
 	rm69380_reset(ctx);
 
 	ret = rm69380_on(ctx);
 	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int rm69380_unprepare(struct drm_panel *panel)
 {
 	struct rm69380_panel *ctx = to_rm69380_panel(panel);
-	struct device *dev = &ctx->dsi[0]->dev;
-	int ret;
 
-	ret = rm69380_off(ctx);
-	if (ret < 0)
-		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+	rm69380_off(ctx);
 
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-- 
2.46.0


