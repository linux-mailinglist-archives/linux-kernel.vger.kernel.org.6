Return-Path: <linux-kernel+bounces-515424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C8CA3649E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF954188F2FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8044A2686AA;
	Fri, 14 Feb 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggxoXb6l"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44632268FC4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554235; cv=none; b=ou0IgQdkcg7EOVmjdPfFPlD93vliKiMdduf/CN29F9lhkfS8gXSspla0ZgLOp7RvkLVAUdEwj5pPes3JIUrZ0d2Rta4HQ3aizOpVUK0287gZQ11jUPrz+qYcTzmymM3l27hfZlWOtzMaxFmIsq7yKorSHkFdqjUT5qWU2/z8CkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554235; c=relaxed/simple;
	bh=xs60vMlQ/tjZ4CPb2ppmZPFT5hhkOFi4OyqMfSj0J7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3E2J67wSmA0s/QbEEoGPMAsE2+bOZejxbtVymjLaVvZjOV3s9rJJJxq+hRoI1N+ET16rDw1U74G+U6lnRa7J2jhIOqGZPpnpFWAcB2PnzxVHwv3e0T9rlKlmEK7Y/6B2V32Xh4U6Ze2BFXQbQwtSRwnzL/PnkN/CPiHoHayEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggxoXb6l; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220d28c215eso33305555ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739554233; x=1740159033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JG67CoErQ4jk/j2wz6ZGsEzl+oGpqJgy4uTscNC0oGk=;
        b=ggxoXb6lIr1cB0BBbd/o8D9f8JMuBZbzo9qNreylyEa3CtXee3vg8os9q/csS4OPri
         qULKMpdnyAzdzg6vDTV9H5VZFFJe9FUCaNxhalLvNenrLxtTDlos4ifuR2HdSf6xNmRC
         TVtihpdPlYqSBAZnllGFqvh3nSujVwIYL1KOsm3aAfKY6gkWrSzqB52IGIGdWc+OLTvG
         hG9WUA+VttKiPmrQn7nWrGl/Scj3Dk+ZKu2xyKoUneBvOvONsIoCT14Ct5w+0W5KdI/y
         APQLbn5BVRVb5DADbSAPFe7PsAFO0s/w/5mAtUR6/l9qox4jeXReZHqKu3wcMmM6+188
         xasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554233; x=1740159033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JG67CoErQ4jk/j2wz6ZGsEzl+oGpqJgy4uTscNC0oGk=;
        b=Xs4UuTL2g4LzAo5W4dM3X3kP7H8U5xywb+Ay9NLuUXCPOJc55/nbyTO5YkVIP0stcC
         2fLoTUIG6oBB8p+R3cWat28TvUJJmUL6oR4ZCdB0dpqAIZh2nt2GLK0LeejYRU456mfO
         pCChMLsL+IAfiMA9ZHuWOAV9YU6WIRV5YJOjJf5qZjk1lkdV8Etun5psugzxp3NA8mbz
         O13KjtGg8irzbUniws2t+ITvlHjWxbOt7lzUD1YuQea55Ch97FKSfjd3Krs9q5A0GAUw
         Qu0NXLORxdMHbqBBqymFojcQKgpCOTTzZnEZbTnt82zVFyTcX14Mga2veMLYHhfxW2Ck
         pzuA==
X-Forwarded-Encrypted: i=1; AJvYcCWY5djwQsnne/rf/NNNr01DvHclkCZLUmAnBRgrEU9Mb31aR/LQKIZjdzCgOAHhLVwDQLEfu8hQIOBw0Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YySi8Of5US+M/puFBVqY0eLfj9Q3dtDAX8GVUy0B4Wn+Pfl5DJH
	vfkLPhi0Fku407c/d1kEMR+oEMwrjaNKY0l7P924llSb3vswyHCG
X-Gm-Gg: ASbGnctfuA7Xhundbz/af+ttyOCHODbe75/FSl1WNACQBMpCkyWNYZ9TvrFz+6ykd79
	K6pcNIP7Ql3mYoRFdjc563SA0egr+S3/EzLKFGU+yzFKnd1Kfvr5eNZvcsU8i6PHh5iJccjLC2q
	qL14s1ePrAkPaPT4UQ76ouq0hZUNh0Ya5KXgqLxQ2llviL35c15l2ofBtwZ5R9UZRnGT6nFqtD3
	EcAR3u4Aa3KrfDHs4wpm7Po5lLQitDPZ/VmGL9A9f5KDPvubSEahkyAcABbln4xiC3SrAu1TQUe
	PDqHgqxhO6aiMJOzyrp+H6wHe7iFAqL/dg==
X-Google-Smtp-Source: AGHT+IEo0wiggK4AdGkrdqyzJ6jWqqzwh3wptoY15dEQvTVEJw6wVA6kehfEZXMQuLRKEaZFZ1jYkw==
X-Received: by 2002:a05:6a21:e8c:b0:1eb:48e2:2c2f with SMTP id adf61e73a8af0-1ee8cbc1ea9mr535075637.30.1739554233442;
        Fri, 14 Feb 2025 09:30:33 -0800 (PST)
Received: from distilledx.SRMIST.EDU.IN ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adcc6fb20f8sm1355138a12.37.2025.02.14.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:30:33 -0800 (PST)
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
Subject: [PATCH 2/2] drm/panel: sony-td4353-jdi: transition to mipi_dsi wrapped functions
Date: Fri, 14 Feb 2025 22:59:58 +0530
Message-ID: <20250214172958.81258-3-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214172958.81258-1-tejasvipin76@gmail.com>
References: <20250214172958.81258-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the sony-td4353-jdi panel to use multi style functions for 
improved error handling.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c | 107 ++++--------------
 1 file changed, 23 insertions(+), 84 deletions(-)

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
-- 
2.48.1


