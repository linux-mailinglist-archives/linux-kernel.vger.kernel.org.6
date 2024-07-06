Return-Path: <linux-kernel+bounces-243154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B941929290
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E74E1C20EA3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58728130484;
	Sat,  6 Jul 2024 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtD2abAs"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36C12B143;
	Sat,  6 Jul 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720261475; cv=none; b=A6OwBxnxZc6HIBF63/Ybka7ohHw0ROCTk0guD4YmCtXz3skHNP+wW4WBtvtoewZeCGcXvRyOaCSimrUiQpracD550w9Sfd9RHOxgChb0Kc4p3RoonCXZPtmvwgKFjNXzeRAzB+Mb5up4n9WHoTiGDDNVH/OR5Qe74Vwtw/gGij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720261475; c=relaxed/simple;
	bh=5d03ZuL6teJXOf/T1h1vDxrHa7R8OPBs+R4lJkRXRAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIMB1KF6tfSaD3pyD+iBZz8pOwFrPXGSVbRPY2MfQLEKJniALChlVtz5GEWdOc7zne7MKM35/LKg2PzU2wiaonszZbrhndiaqh7DThd9eR4XtzgbQX99sniEQakuVpObGliEiX2/59C9XIppu6/zZ/kqPzqFxaS8ysrqkBmTV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtD2abAs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb3cf78fcaso13950795ad.1;
        Sat, 06 Jul 2024 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720261473; x=1720866273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h4gurbNkAwaSKOgdNMh5biS07+9cUKmRAWUYCPb8sQ=;
        b=FtD2abAs+NctAuJjM62Cvfn5/GWxgWBXGImshkU/2OJIMDg5PQjPl5kfOdR5pOiyQq
         sZWjNUB02Zc92DJPJ8bJjLETyt/8KP0UQekZu7T8PAH4LL432znma538AtrM9jrqiOww
         //jO91wvYcXmzv/YSQm9TQAQGtfqCsJRhGwKqHRV1bufzsDHNQ9h95i74gMvOztfTMZs
         McY/D3fC/MGWlEdL0d2tN6JIgtsRI923f9z5fyW+6nyldTROXkJTYAN6L2xKmnD/Z9X6
         B0642TJTu+xxEMe63KzGbc6xx1wXxpNAi8jt1y/Fh1bOiwbMw/OZZG48TItxcOVJd08D
         Ox5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720261473; x=1720866273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h4gurbNkAwaSKOgdNMh5biS07+9cUKmRAWUYCPb8sQ=;
        b=vVZr8pRll/4QifVdKpUDvYdp+8yM0acDSp5ILyd1zbJkOkUXQC7QbWjgMnVqaHEiAj
         180FDxgjJkVuHhKZHLLoSzwSlxrK/b53U+luhgKwz6DGSIRExzMXkII02/Gm+h6gNdBl
         uOZbPd081e4LLHKWqe7SQnS1uBDFD9FqobvWn/lloZzmubpLh+xIz6s1mBzFyiqHcK0k
         WbJucnUz/e3ItVM2WpdJhTJC2+JM6Sjc0yMAIJgC4MbKfBf5U4hh8nCwPYLEof57M17q
         BRIbpNIcG0UBT5wfBA7Z8DZ+gNIwG92rsk8ss4IQD0ZeIHi0Z8Xf8fL5UBBxz8aJ99QT
         hq5g==
X-Forwarded-Encrypted: i=1; AJvYcCW3Vw/0Jp+mZf5wmBjyLgJ+cQhSZG3PYyZoMz5HS9skPFq1DduRhHAkXFR3KKdlmFmXx2f5upzjj5TpkUiwi21NQ7UehXQ7LQYPIw==
X-Gm-Message-State: AOJu0YwF/gUlw9tnJmkJgVpkPXrqD0e5m74RgGbkVcdRgJh3X9JlOGuz
	O/3LbxAaclY+gCIZtaCgLgVdDBnjl7NRuT+IfrfpERE3aAlPlLDTV3OeIeZTHYo=
X-Google-Smtp-Source: AGHT+IFnyYWL3WPlLyL7laJQKab+908eQcOctgsy1AfVVm6IqLt4ggJ0zorKGaA29ubMxYbq40AfWA==
X-Received: by 2002:a17:902:c114:b0:1fa:18c3:2791 with SMTP id d9443c01a7336-1fb33e7be44mr44345315ad.36.1720261472986;
        Sat, 06 Jul 2024 03:24:32 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb67e04f64sm9126625ad.214.2024.07.06.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 03:24:31 -0700 (PDT)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 5/5] drm/panel: st7701: Add Anbernic RG28XX panel support
Date: Sat,  6 Jul 2024 19:23:36 +0900
Message-ID: <20240706102338.99231-6-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240706102338.99231-1-kikuchan98@gmail.com>
References: <20240706102338.99231-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Anbernic RG28XX is a handheld gaming device with a 2.8 inch 480x640
display. Add support for the display panel.

This panel is driven by a variant of ST7701 driver IC internally,
confirmed by dumping and analyzing its BSP initialization sequence
by using a logic analyzer. It is very similar to the existing
densitron,dmt028vghmcmi-1a panel, but differs in some unknown
register values. Besides, it is connected via SPI, so add a new entry
for the panel.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 9e83a760a8a..eef03d04e0c 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -471,6 +471,55 @@ static void rg_arc_gip_sequence(struct st7701 *st7701)
 	msleep(120);
 }
 
+static void rg28xx_gip_sequence(struct st7701 *st7701)
+{
+	st7701_switch_cmd_bkx(st7701, true, 3);
+	ST7701_WRITE(st7701, 0xEF, 0x08);
+
+	st7701_switch_cmd_bkx(st7701, true, 0);
+	ST7701_WRITE(st7701, 0xC3, 0x02, 0x10, 0x02);
+	ST7701_WRITE(st7701, 0xC7, 0x04);
+	ST7701_WRITE(st7701, 0xCC, 0x10);
+
+	st7701_switch_cmd_bkx(st7701, true, 1);
+	ST7701_WRITE(st7701, 0xEE, 0x42);
+	ST7701_WRITE(st7701, 0xE0, 0x00, 0x00, 0x02);
+
+	ST7701_WRITE(st7701, 0xE1, 0x04, 0xA0, 0x06, 0xA0, 0x05, 0xA0, 0x07, 0xA0,
+		   0x00, 0x44, 0x44);
+	ST7701_WRITE(st7701, 0xE2, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		   0x00, 0x00, 0x00, 0x00);
+	ST7701_WRITE(st7701, 0xE3, 0x00, 0x00, 0x22, 0x22);
+	ST7701_WRITE(st7701, 0xE4, 0x44, 0x44);
+	ST7701_WRITE(st7701, 0xE5, 0x0C, 0x90, 0xA0, 0xA0, 0x0E, 0x92, 0xA0, 0xA0,
+		   0x08, 0x8C, 0xA0, 0xA0, 0x0A, 0x8E, 0xA0, 0xA0);
+	ST7701_WRITE(st7701, 0xE6, 0x00, 0x00, 0x22, 0x22);
+	ST7701_WRITE(st7701, 0xE7, 0x44, 0x44);
+	ST7701_WRITE(st7701, 0xE8, 0x0D, 0x91, 0xA0, 0xA0, 0x0F, 0x93, 0xA0, 0xA0,
+		   0x09, 0x8D, 0xA0, 0xA0, 0x0B, 0x8F, 0xA0, 0xA0);
+	ST7701_WRITE(st7701, 0xEB, 0x00, 0x00, 0xE4, 0xE4, 0x44, 0x00, 0x40);
+	ST7701_WRITE(st7701, 0xED, 0xFF, 0xF5, 0x47, 0x6F, 0x0B, 0xA1, 0xBA, 0xFF,
+		   0xFF, 0xAB, 0x1A, 0xB0, 0xF6, 0x74, 0x5F, 0xFF);
+	ST7701_WRITE(st7701, 0xEF, 0x08, 0x08, 0x08, 0x45, 0x3F, 0x54);
+
+	st7701_switch_cmd_bkx(st7701, false, 0);
+
+	st7701_switch_cmd_bkx(st7701, true, 3);
+	ST7701_WRITE(st7701, 0xE6, 0x16);
+	ST7701_WRITE(st7701, 0xE8, 0x00, 0x0E);
+
+	st7701_switch_cmd_bkx(st7701, false, 0);
+	ST7701_WRITE(st7701, MIPI_DCS_SET_ADDRESS_MODE, 0x10);
+	ST7701_WRITE(st7701, MIPI_DCS_EXIT_SLEEP_MODE);
+	msleep(120);
+
+	st7701_switch_cmd_bkx(st7701, true, 3);
+	ST7701_WRITE(st7701, 0xE8, 0x00, 0x0C);
+	msleep(10);
+	ST7701_WRITE(st7701, 0xE8, 0x00, 0x00);
+	st7701_switch_cmd_bkx(st7701, false, 0);
+}
+
 static int st7701_prepare(struct drm_panel *panel)
 {
 	struct st7701 *st7701 = panel_to_st7701(panel);
@@ -986,6 +1035,106 @@ static const struct st7701_panel_desc rg_arc_desc = {
 	.gip_sequence = rg_arc_gip_sequence,
 };
 
+static const struct drm_display_mode rg28xx_mode = {
+	.clock		= 22325,
+
+	.hdisplay	= 480,
+	.hsync_start	= 480 + 40,
+	.hsync_end	= 480 + 40 + 4,
+	.htotal		= 480 + 40 + 4 + 20,
+
+	.vdisplay	= 640,
+	.vsync_start	= 640 + 2,
+	.vsync_end	= 640 + 2 + 40,
+	.vtotal		= 640 + 2 + 40 + 16,
+
+	.width_mm	= 44,
+	.height_mm	= 58,
+
+	.flags		= DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct st7701_panel_desc rg28xx_desc = {
+	.mode = &rg28xx_mode,
+
+	.panel_sleep_delay = 80,
+
+	.pv_gamma = {
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0x10),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x17),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0xd),
+
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x6),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x5),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
+
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x7),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x1f),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x4),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x11),
+
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0xe),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x29),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x30),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
+	},
+	.nv_gamma = {
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC0_MASK, 0),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC4_MASK, 0xd),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC8_MASK, 0x14),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC16_MASK, 0xe),
+
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC24_MASK, 0x11),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC52_MASK, 0x6),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC80_MASK, 0x4),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC108_MASK, 0x8),
+
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC147_MASK, 0x8),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC175_MASK, 0x20),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC203_MASK, 0x5),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC231_MASK, 0x13),
+
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC239_MASK, 0x13),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC247_MASK, 0x26),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC251_MASK, 0x30),
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_AJ_MASK, 0) |
+		CFIELD_PREP(ST7701_CMD2_BK0_GAMCTRL_VC255_MASK, 0x1f)
+	},
+	.nlinv = 7,
+	.vop_uv = 4800000,
+	.vcom_uv = 1512500,
+	.vgh_mv = 15000,
+	.vgl_mv = -11730,
+	.avdd_mv = 6600,
+	.avcl_mv = -4400,
+	.gamma_op_bias = OP_BIAS_MIDDLE,
+	.input_op_bias = OP_BIAS_MIN,
+	.output_op_bias = OP_BIAS_MIN,
+	.t2d_ns = 1600,
+	.t3d_ns = 10400,
+	.eot_en = true,
+	.gip_sequence = rg28xx_gip_sequence,
+};
+
 static void st7701_cleanup(void *data)
 {
 	struct st7701 *st7701 = (struct st7701 *)data;
@@ -1120,11 +1269,13 @@ static const struct of_device_id st7701_dsi_of_match[] = {
 MODULE_DEVICE_TABLE(of, st7701_dsi_of_match);
 
 static const struct of_device_id st7701_spi_of_match[] = {
+	{ .compatible = "anbernic,rg28xx-panel", .data = &rg28xx_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, st7701_spi_of_match);
 
 static const struct spi_device_id st7701_spi_ids[] = {
+	{ "rg28xx-panel" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, st7701_spi_ids);
-- 
2.45.2


