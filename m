Return-Path: <linux-kernel+bounces-281751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60094DAC8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC0C282C67
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 04:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD4913D2B7;
	Sat, 10 Aug 2024 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTaD6V5A"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD713D243
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723265710; cv=none; b=ePaRAh/2xtH3UYKk3xKBE0Nq4BJ6NsauBQQsjbAK5UnpKC6d90A7B91TAEHrTFZ2kpDiUqSf/PiXd2CHUNtWtekhUNS2q23LPiUKCOQ0I8HJ/DNuZAqr5aPzXZlwsu2mnvIeOhcwUMRUYrzh2TQMvzEjWoKJWz1/+PsHasHybcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723265710; c=relaxed/simple;
	bh=LqEkVqT0zJjqip7n6TGZEDAtPSc7ms/WQ5BGpRJDb0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAy6ZdR50vU5FM+/tcapOsbr6VyEkAE4Ny189LiuN8MfqF8iZJUgHjoDFc/8nNid19ty+HioPQEuOckaAvFOkhUHWTKBJU8dDcxC9fKfviQ9HnBUD7v7Vg9jcV5k1w8iyt6e4+nwFQZcr4TMIt5qZfgr8H3y/aDyZRycEb9GyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTaD6V5A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd65aaac27so26106385ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 21:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723265708; x=1723870508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19rt3cYGIz9ovZGS8R2mAVuVxzzyQDGkKj8/iUwXAXE=;
        b=XTaD6V5ATFlz1/WW3wKh/0atbfxpZcPhCtFtxw8ip/fiTFZ4LqdGtWPyUmudXsXriZ
         NDnhd+ImFIK2BLDG2dkTAxUUIHh+1mfJMQX5v3Bb0/bT8ayr5I7+H4kq5sXREuSkXto/
         WA/cW3glfl9tXIGDWHFrUt6ZiFxQmic4oSWgCf60A74wLo/xwHg5zh05XZxg64RWlCWP
         Lpb9nMUEmzwMwZAJTuLqDoI8bSSSEsxoVPYQ51V+VNPhnS4AhhCjiOeLEu6oBQsBngSk
         wDZB9cVwG0NHIpfJCxX+tiZqBCqJMFDjEKP/LWx/BQvbC3BUyKHj0O0gwEJhTMZoNoIs
         dNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723265708; x=1723870508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19rt3cYGIz9ovZGS8R2mAVuVxzzyQDGkKj8/iUwXAXE=;
        b=b9AbarXW7vYUQy7DzuMYDrjLcpXzAomD0aVQVQ+ScRUIa3ZM91iU7qDHeJ2vRByh39
         Lxb8HcGTMVCYSv9xgzwl9naIn/EIp2nv2N3zAVjzlZTZAsx9/ZoNa69y1z2Vho2uyQKt
         Aq6soLfAGupNeQ5cGZrL7qg9mV874k4J8dKsjUnFX6ZlUnJ6crPfiZyKzx5UgcVio4Q5
         5qewO5lSufVCJ4GsnCrVwEDcn6KsuBXjqckmjim3l/hcLSYNK/HXHEo+fImOpXyG16vz
         c5OqiImcH7JB0LfHtF9QKzRPMPcujcR/QEubWdVwEReRK2u42yKiJWhf6MS/tQgLDGjz
         Sv7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzvqqFRpB1FeM5fSdeyOPxzs2Nu9OPbYVpjmURod7V18OQArn3IFRKBQpR91p2mQlI0CY6Fdc+1IGHJIsLU9TwTL6Nc/oeDewhKVjv
X-Gm-Message-State: AOJu0YydEyzmZkhuTz4lLdr0jguoOVTqYUnBHCGkBQZxxydAm6wbGypE
	ZCqv/kr5nyBXzU8J48CcSYKhNooa5lgB/dxHUB3IeWyB0caNA5B1
X-Google-Smtp-Source: AGHT+IHlx1kQsTJ98HNGtbgTUm2+DBvCCePAmf3vd6I3xO5Wjd0CVQtCUkh5r/ZzM9mb4PGZk+PFeQ==
X-Received: by 2002:a17:903:2345:b0:1f7:3a70:9e71 with SMTP id d9443c01a7336-200ae540e3amr57633735ad.13.1723265707658;
        Fri, 09 Aug 2024 21:55:07 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd82asm5227005ad.73.2024.08.09.21.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 21:55:07 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/panel: jdi-fhd-r63452: transition to mipi_dsi wrapped functions
Date: Sat, 10 Aug 2024 10:24:04 +0530
Message-ID: <20240810045404.188146-3-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810045404.188146-1-tejasvipin76@gmail.com>
References: <20240810045404.188146-1-tejasvipin76@gmail.com>
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
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 125 ++++++-------------
 1 file changed, 39 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index 483dc88d16d8..32a244d4bae7 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -41,79 +41,41 @@ static void jdi_fhd_r63452_reset(struct jdi_fhd_r63452 *ctx)
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
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec,
+					 0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x0b, 0x0b,
+					 0x13, 0x15, 0x68, 0x0b, 0xb5);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
 
-	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear on: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
 
-	ret = mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set pixel format: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx, 0x77);
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0x0000, 0x0437);
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0x0000, 0x077f);
+	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx, 0x0000);
+	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x00ff);
 
-	ret = mipi_dsi_dcs_set_column_address(dsi, 0x0000, 0x0437);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set column address: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x00);
 
-	ret = mipi_dsi_dcs_set_page_address(dsi, 0x0000, 0x077f);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set page address: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_set_tear_scanline(dsi, 0x0000);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear scanline: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 80);
 
-	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x00ff);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display brightness: %d\n", ret);
-		return ret;
-	}
-
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
-
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-	msleep(20);
-
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
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x00);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x11);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
 
 	return 0;
 }
@@ -121,31 +83,22 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
 static int jdi_fhd_r63452_off(struct jdi_fhd_r63452 *ctx)
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
 
 	return 0;
 }
-- 
2.46.0


