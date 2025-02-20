Return-Path: <linux-kernel+bounces-522962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E14A3D097
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2443B4C04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05291DFE3A;
	Thu, 20 Feb 2025 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMmrZMx5"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B431DE896
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740027500; cv=none; b=rg/bscuc2r62n/62aqK5DcGE07xm7xngPy3LXNRB1AZyHrPGTZHrN+jhDn1NY/dLsMERql94H5f48Jj2vMHKKk6QkpygCiyrh9fZ91tm3SzqDfTCXvEY9W8EcFu0Jix0GZdGV5vJkS6z2B/VWwzZxQw4HQzB6sEdRPfa1lPl49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740027500; c=relaxed/simple;
	bh=OEymnkP4WWTy1OOiyp6Pwo/iA8tVLpTqteb21aP8xRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMKd16SyTxxep24nxW/SgebZ6U/rlX3SHctRvFYfMmTFzfeDafK14nZSG4Bcy2yeYsRly22mKoeUl7P7XbZs2a2AXBVPgtE/WCHHzXYycWcTEKOBbsck4mDUMWF1c8j4E1SRJAVLdeY10dav4I5p/0noALH9Hus6sn/40ebGSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMmrZMx5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc20e0f0ceso772766a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740027497; x=1740632297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x79i0bhLqpiDBJcBajlZ43nChj/icM/N7Ue738YpG3s=;
        b=FMmrZMx5ZHVNHJear0bHitGr3ES8YNXn1VZccPiv133/JQZ90Slm9UacmkDe+w06t/
         RehNyNidvKttpXgqEfSlBJi7lU8m3IJ/NBkhiIdgTVhZt7hJVofD7rAfmUmyf3MFvWGS
         H4clgfw5sMvdjs/DimuXnf+W3CQxIar884wo41icVR4H0lczH9peL1/BUzei+Gx/QmkT
         xoDZNU4ijE1q0qUd9KEipssUb1N1+Hx+jingo2cOassjqT8hsaAoR722Nars7rnlCoB6
         TSoT1xaXFgKDotTipothzOHV+N8hYzG8+49CN2hLoWhKhXdD4w0/mOyv7/l3mv5tOPCF
         Uu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740027497; x=1740632297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x79i0bhLqpiDBJcBajlZ43nChj/icM/N7Ue738YpG3s=;
        b=XyFbt9C4j+otZgPpcjYhOe98LJqewh9DF2PH/ofZwvGG/oWrD/jN370T5hNUfvGi+j
         qCtFyrHskfOwR9Y7bU/aYHDe+EbpG7gJckd6hIv8IefXh0ToBBoVx6xCKFDr4nnKqRPQ
         thIopP3as9GzUZWXwDYKj/+zVwOpQJqV5rvM6mkm4JP6V4peHJiSmKqJoPphitJQfUeV
         eRXsk6PzZjLF3velcPCqJWtAN0j65Xv0y3zB4mz+u0mEMLZy1KDuwGPb61BzSvoCAB1w
         +d9eWFbp7az4j0fPK6IcKPLa24sAvxiaJ3df3RAJasVjUm5p/Izl+hgSbNwEexoLfvFq
         Kcjw==
X-Forwarded-Encrypted: i=1; AJvYcCUN1cxtVsfMoMUKZ6i5t1k0Y4yIQYfvvGljxeMDKo27j7oVsRqCweydNTZP7upofkwLmY5cKFaA2bx54DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUSA7/kP5xBjHPesWHFIpxpkFUbQmFXA2j5nbRLP3jUISlS6o
	7eQNlRnh8jjyQ7qJSuI/bk1ucDrY0bL6q+artbO7swn3srGeAyUG
X-Gm-Gg: ASbGncuEcwTbqZXYnyXNpIe8Ein5RLz3kmrBk+F+p+W5JXMb4f1F6nTxmGPLws8HyIP
	bg/gm8e6T9rWrFAMdhddTXHLgCKfPMB4PLeiZnrJq6MgK4FZcNYTmRS1lEzvYls7N4HMZHZlTNY
	RyMmF1hv+3jk9NwWRzF0HzSsLQYrHnaaKDxB4QHKJ6nkQwoYFaBGGaV7giukSpwmC6iKGhsXCOr
	uM9hVMpyYwRuuBzHEEqKyfgRz1yldiolSYO/q7BBdSeAmfttq1ARP17+iqCq1909AAG6sOVeptl
	stNWmcI7g9XY3W1gRtBSL7qRfbvghNISoS1KWA==
X-Google-Smtp-Source: AGHT+IHrngJ9wsLKpkmfVQR0Zl8QKv2Ahs8dagIFjlgk1+gYTfOhpaMk96T6lHuygPJ2/XQ7+lJnNA==
X-Received: by 2002:a17:90b:47:b0:2ee:d7d3:3019 with SMTP id 98e67ed59e1d1-2fcb5a1aa37mr11785103a91.12.1740027497539;
        Wed, 19 Feb 2025 20:58:17 -0800 (PST)
Received: from distilledx.localdomain ([2401:4900:6273:d0ef:80a7:d92e:7b3e:31e8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98cfd19sm14993179a91.14.2025.02.19.20.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 20:58:17 -0800 (PST)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: quic_jesszhan@quicinc.com,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH v2] drm/mipi-dsi: extend "multi" functions and use them in sony-td4353-jdi
Date: Thu, 20 Feb 2025 10:27:21 +0530
Message-ID: <20250220045721.145905-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes mipi_dsi_dcs_set_tear_off and replaces it with a
multi version as after replacing it in sony-td4353-jdi, it doesn't
appear anywhere else. sony-td4353-jdi is converted to use multi style
functions, including mipi_dsi_dcs_set_tear_off_multi.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
Changes in v2:
    - Squashed panel changes and mipi_dsi changes into 1 patch

Link to v1: https://lore.kernel.org/all/20250214172958.81258-1-tejasvipin76@gmail.com/
---
 drivers/gpu/drm/drm_mipi_dsi.c                |  42 +++----
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c | 107 ++++--------------
 include/drm/drm_mipi_dsi.h                    |   2 +-
 3 files changed, 47 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 5e5c5f84daac..2e148753ea97 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1265,25 +1265,6 @@ int mipi_dsi_dcs_set_page_address(struct mipi_dsi_device *dsi, u16 start,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_set_page_address);
 
-/**
- * mipi_dsi_dcs_set_tear_off() - turn off the display module's Tearing Effect
- *    output signal on the TE signal line
- * @dsi: DSI peripheral device
- *
- * Return: 0 on success or a negative error code on failure
- */
-int mipi_dsi_dcs_set_tear_off(struct mipi_dsi_device *dsi)
-{
-	ssize_t err;
-
-	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_TEAR_OFF, NULL, 0);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_off);
-
 /**
  * mipi_dsi_dcs_set_tear_on() - turn on the display module's Tearing Effect
  *    output signal on the TE signal line.
@@ -1713,6 +1694,29 @@ void mipi_dsi_turn_on_peripheral_multi(struct mipi_dsi_multi_context *ctx)
 }
 EXPORT_SYMBOL(mipi_dsi_turn_on_peripheral_multi);
 
+/**
+ * mipi_dsi_dcs_set_tear_off_multi() - turn off the display module's Tearing Effect
+ *    output signal on the TE signal line
+ * @ctx: Context for multiple DSI transactions
+ */
+void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t err;
+
+	if (ctx->accum_err)
+		return;
+
+	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_TEAR_OFF, NULL, 0);
+	if (err < 0) {
+		ctx->accum_err = err;
+		dev_err(dev, "Failed to set tear off: %d\n",
+			ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_off_multi);
+
 /**
  * mipi_dsi_dcs_soft_reset_multi() - perform a software reset of the display module
  * @ctx: Context for multiple DSI transactions
diff --git a/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c b/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c
index 472195d4bbbe..97f4bb4e1029 100644
--- a/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c
+++ b/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c
@@ -47,93 +47,40 @@ static inline struct sony_td4353_jdi *to_sony_td4353_jdi(struct drm_panel *panel
 static int sony_td4353_jdi_on(struct sony_td4353_jdi *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_set_column_address(dsi, 0x0000, 1080 - 1);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set column address: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_set_page_address(dsi, 0x0000, 2160 - 1);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set page address: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_set_tear_scanline(dsi, 0);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear scanline: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear on: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0x0000, 1080 - 1);
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0x0000, 2160 - 1);
+	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx, 0);
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
 
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
-
-	ret = mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set pixel format: %d\n", ret);
-		return ret;
-	}
-
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PARTIAL_ROWS,
-			  0x00, 0x00, 0x08, 0x6f);
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(70);
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_PARTIAL_ROWS,
+				     0x00, 0x00, 0x08, 0x6f);
 
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_MEMORY_START);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 70);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_MEMORY_START);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to turn display on: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
-static int sony_td4353_jdi_off(struct sony_td4353_jdi *ctx)
+static void sony_td4353_jdi_off(struct sony_td4353_jdi *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
-	msleep(22);
-
-	ret = mipi_dsi_dcs_set_tear_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear off: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(80);
-
-	return 0;
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 22);
+	mipi_dsi_dcs_set_tear_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 80);
 }
 
 static void sony_td4353_assert_reset_gpios(struct sony_td4353_jdi *ctx, int mode)
@@ -146,14 +93,11 @@ static void sony_td4353_assert_reset_gpios(struct sony_td4353_jdi *ctx, int mode
 static int sony_td4353_jdi_prepare(struct drm_panel *panel)
 {
 	struct sony_td4353_jdi *ctx = to_sony_td4353_jdi(panel);
-	struct device *dev = &ctx->dsi->dev;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	msleep(100);
 
@@ -161,7 +105,6 @@ static int sony_td4353_jdi_prepare(struct drm_panel *panel)
 
 	ret = sony_td4353_jdi_on(ctx);
 	if (ret < 0) {
-		dev_err(dev, "Failed to power on panel: %d\n", ret);
 		sony_td4353_assert_reset_gpios(ctx, 0);
 		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
 		return ret;
@@ -173,12 +116,8 @@ static int sony_td4353_jdi_prepare(struct drm_panel *panel)
 static int sony_td4353_jdi_unprepare(struct drm_panel *panel)
 {
 	struct sony_td4353_jdi *ctx = to_sony_td4353_jdi(panel);
-	struct device *dev = &ctx->dsi->dev;
-	int ret;
 
-	ret = sony_td4353_jdi_off(ctx);
-	if (ret < 0)
-		dev_err(dev, "Failed to power off panel: %d\n", ret);
+	sony_td4353_jdi_off(ctx);
 
 	sony_td4353_assert_reset_gpios(ctx, 0);
 	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 94400a78031f..bd40a443385c 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -346,7 +346,6 @@ int mipi_dsi_dcs_set_column_address(struct mipi_dsi_device *dsi, u16 start,
 				    u16 end);
 int mipi_dsi_dcs_set_page_address(struct mipi_dsi_device *dsi, u16 start,
 				  u16 end);
-int mipi_dsi_dcs_set_tear_off(struct mipi_dsi_device *dsi);
 int mipi_dsi_dcs_set_tear_on(struct mipi_dsi_device *dsi,
 			     enum mipi_dsi_dcs_tear_mode mode);
 int mipi_dsi_dcs_set_pixel_format(struct mipi_dsi_device *dsi, u8 format);
@@ -379,6 +378,7 @@ void mipi_dsi_dcs_set_page_address_multi(struct mipi_dsi_multi_context *ctx,
 					 u16 start, u16 end);
 void mipi_dsi_dcs_set_tear_scanline_multi(struct mipi_dsi_multi_context *ctx,
 					  u16 scanline);
+void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi_multi_context *ctx);
 
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
-- 
2.48.1


