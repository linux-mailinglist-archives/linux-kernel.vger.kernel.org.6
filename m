Return-Path: <linux-kernel+bounces-284173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91E94FDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA15D281319
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3CC3BB32;
	Tue, 13 Aug 2024 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqYJfeaW"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00F44393
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530662; cv=none; b=VA0fSKaQNdmwhqXML0tP1lhuUypjDYbFzuKAflN65sl3BX3V958Yy/wpc8yvnx6020yjl/Xm6aZ9Ek1Qr7KXLIJjADgsQKJ7ZYtLa0NhcQVFzvCthE2YLpBxLL4+UlmEsoZGThuZlOf9xohFMdCziPmlGdAaD6xmhqQ2FybhQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530662; c=relaxed/simple;
	bh=CdivoeaAr3lYU0Z5j4OlwyOz1nmuX2TSQ+f7cUhOuAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgwZZzuhyw0RxFkP/AD5uRTUbuE5sXpDaQ0xxShVr4VhnfIH9Xb93lz1ofcMvdDbH6gpuSgOyyAZC4JJWXXY71uNj/MK5Wnb7nUWkUVQJSNnJkFgPmBqM6i543AWhXFRtN8ekHRbOQxMRcjMxkmSr7I0+vc++3mU/ewiOXcvhh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqYJfeaW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db51133978so3609802b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723530659; x=1724135459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCRwCY9EDZcaC0Ax+MD/I4e/vXfkLFmA0dK7jr+FvWs=;
        b=KqYJfeaWy1XvkNUufzT9Sgek/b2PEj8UATorSHADHe9KRvNpuSnPr/pYKlwZot76bD
         xSnTgC1T8e52N+pkSPWo90w1Tw8F5JMOYrll/Fps4WZ5hlP2Oz95VBgp7kjipKmptQtI
         hhoOv+JT0vbx90jPDEPB27D2WwQUF0hOVEZutmVuWvq0WViFQ3Qkg/2SzGBXftgDWlQr
         tkmzvmVYtWA65dnrbOXI5FQAWpbxAkkuva1KtL39TeUg5tvn9aFISZlb234n5yuZe06i
         DpL+IrQWSKaQhv320nDijRDwQU0xUjIwuAXOcibbj5v5QLPzF4mpnW2peyacXzK/eXWz
         aFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723530659; x=1724135459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCRwCY9EDZcaC0Ax+MD/I4e/vXfkLFmA0dK7jr+FvWs=;
        b=m09oQkQRDWnRLVdNulPvVONF5Xpw9RH0v2N5ebWbXko8LqiYlTfVSfyutE906yXkNq
         ghJHeK87I9VoRn/pwYONi+vu7788tPIANxPTnHLiP3TyY30unxskOGcCdDoQCEjNVLNv
         7Tx9YfFUnctfcOmPQHc5oZY//Q8n2i2E0V/NYwfLfms49dLy/U8zHd0eGO9blonR3G9R
         mZoWoxKk/Hisfw+hjMSycnTXLVxgMiEFqqNRNQjc5WUlHbNkwnDzE8/sa//eYwIjEvhD
         HOZ14KPU8DtlDOTNSbLmLzRkLRZgLRgFglhEoL0dKKwnPYOF7Rou9N/Llg8W4IoPkzun
         MDOA==
X-Forwarded-Encrypted: i=1; AJvYcCVYs9XmZelMhpYcYWKxA0ge477OQCyOkkJjxMjDwxTDcXEG5VBU3F4z5qixTkHA8XReLwTB+G3M2zKkxb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ozL+fQZaxyYklzFNWzCy5xLQg+n8mHb69iLg/rJV6UvWY4qK
	q0MaBPkkvpqG/ZY0Y+FJd7zIMpg6EgbHxCSaH5hD/SLFub6BQUmU
X-Google-Smtp-Source: AGHT+IEdAD3lQBiintdbrrYL9Q9u1r8Hb7gnuu2Rg873fjM/Qkagyegk+fduHZKHHicbc3C/esKghA==
X-Received: by 2002:a05:6808:199d:b0:3da:b35d:52e0 with SMTP id 5614622812f47-3dd1eee0effmr2829791b6e.43.1723530659653;
        Mon, 12 Aug 2024 23:30:59 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([2401:4900:6325:9539:8b89:ebee:b1a0:5ff9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5874ef7sm4991965b3a.38.2024.08.12.23.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 23:30:59 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: dianders@chromium.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2 2/2] drm/panel: jdi-fhd-r63452: transition to mipi_dsi wrapped functions
Date: Tue, 13 Aug 2024 11:59:12 +0530
Message-ID: <20240813062912.467280-3-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813062912.467280-1-tejasvipin76@gmail.com>
References: <20240813062912.467280-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the jdi-fhd-r63452 panel to use multi style functions for
improved error handling.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 150 ++++++-------------
 1 file changed, 49 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index 483dc88d16d8..9ec567b4a8e2 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -41,142 +41,90 @@ static void jdi_fhd_r63452_reset(struct jdi_fhd_r63452 *ctx)
 static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xec,
-				   0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
-				   0x13, 0x15, 0x68, 0x0b, 0xb5);
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
-
-	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear on: %d\n", ret);
-		return ret;
-	}
-
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec,
+					 0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
+					 0x13, 0x15, 0x68, 0x0b, 0xb5);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
 
-	ret = mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set pixel format: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_set_column_address(dsi, 0x0000, 0x0437);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set column address: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 
-	ret = mipi_dsi_dcs_set_page_address(dsi, 0x0000, 0x077f);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set page address: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
 
-	ret = mipi_dsi_dcs_set_tear_scanline(dsi, 0x0000);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear scanline: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx, 0x77);
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0x0000, 0x0437);
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0x0000, 0x077f);
+	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx, 0x0000);
+	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x00ff);
 
-	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x00ff);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display brightness: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x00);
 
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 80);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-	msleep(20);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x11);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(80);
-
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xc8, 0x11);
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
-static int jdi_fhd_r63452_off(struct jdi_fhd_r63452 *ctx)
+static void jdi_fhd_r63452_off(struct jdi_fhd_r63452 *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x00);
-	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x01);
-	mipi_dsi_generic_write_seq(dsi, 0xec,
-				   0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
-				   0x13, 0x15, 0x68, 0x0b, 0x95);
-	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
-	usleep_range(2000, 3000);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(120);
-
-	return 0;
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec,
+					 0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
+					 0x13, 0x15, 0x68, 0x0b, 0x95);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	if (!dsi_ctx.accum_err)
+		usleep_range(2000, 3000);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 }
 
 static int jdi_fhd_r63452_prepare(struct drm_panel *panel)
 {
 	struct jdi_fhd_r63452 *ctx = to_jdi_fhd_r63452(panel);
-	struct device *dev = &ctx->dsi->dev;
 	int ret;
 
 	jdi_fhd_r63452_reset(ctx);
 
 	ret = jdi_fhd_r63452_on(ctx);
-	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+	if (ret < 0)
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int jdi_fhd_r63452_unprepare(struct drm_panel *panel)
 {
 	struct jdi_fhd_r63452 *ctx = to_jdi_fhd_r63452(panel);
-	struct device *dev = &ctx->dsi->dev;
-	int ret;
 
-	ret = jdi_fhd_r63452_off(ctx);
-	if (ret < 0)
-		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
+	/*
+	 * NOTE: We don't return an error here as while the panel won't have
+	 * been cleanly turned off at least we've asserted the reset signal
+	 * so it should be safe to power it back on again later
+	 */
+	jdi_fhd_r63452_off(ctx);
 
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 
-- 
2.46.0


