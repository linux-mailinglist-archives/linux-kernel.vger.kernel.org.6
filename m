Return-Path: <linux-kernel+bounces-335854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBF397EB89
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC101F21A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5F3195F3A;
	Mon, 23 Sep 2024 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBw3ANGN"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124980043
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094808; cv=none; b=RJsn5/pxYa14rQ6BnWFWJg7Air0sC7EiN6qQlsZrc6n8wOV4GTFAY/+WDIwFwekWqSVjwGlFIGYC9fNXZkywQ2xop4xpTrWPIHSY2eAlR172P4LfkLMEKa6+AA0QFCfJXccwObwRtyFhMf1tTYAtb2nTK/CVsXyqNJV+FAeE6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094808; c=relaxed/simple;
	bh=BJ0Kz6ILgetpytbxFvlAh8CsE9v5DDll0SsT9dG41/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyz6k55GpmB4Yi5hm0EwTtL7rb8L7Vi/63Cj7M0fLvPQkdZmdsw8ETcqCQ1qSPjphFMJRTVo9V7+nkHHVly85YSDn4LaPThJWyW2znjNg+G2WP3Wuw2odc1bydnAw4Y3uUe1S0dLBa9DyJ8TxjvpgOQHEg2kkgI0qcg/Vn1GDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBw3ANGN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71798a15ce5so3652170b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727094805; x=1727699605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WnZ1mJ0xSGz3MPNSmU/3w1WkSR43rfZNTvcNA1XQD6c=;
        b=YBw3ANGNEAeoWPNqX6734Bymw49KVlXVViYzpbL/g7BLzWqMW4jLxG5UgQUzUptmjt
         WMrrZW427Nv+j3jYqkaSPqFxedGkZOZGwsUeH/VmwMRbMWftWlbFnGddTjOp3EJOxahd
         KUIS2Tqd5E60GaCfqYEzRv0ZQzqnNe98nch9cBFxheVyqehab6+i3LRL874OMvJy0xu1
         9wPwpgBdENu6d3Gs5OEC5eUbb3+v4OWCOjNvPrk0OP+oTDR0BQg91a3/fBYTHwncCmDu
         CdLbBUBvZ12HIrg+4ne3aEiJEMDTYXyUBpm6ysMIIUutWrLFRYwT6AbFfMYx1oRgO0WU
         tueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727094805; x=1727699605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnZ1mJ0xSGz3MPNSmU/3w1WkSR43rfZNTvcNA1XQD6c=;
        b=Lj0qbI+CUS86wd20SC3Sru4Tl1qeanr0ydnqqpBZxHJ9bGApn2N5Whtq+PtiRLX1U0
         +QNBBBAJvtKFdrodBj0hrkWmXrDteqRyDCz5OsD1H/wE/maeDwLPIcJlh530rN4vMKyV
         9SHBqIiABdlZP0lJkOefChRBbqQ4xQ3ssF+F/OuN0jLc/XPLI+sdrhLXcX3ldpwA1okW
         fjumPyteCYN2Vk514nqRMJ2IqN7cTKGrEvO7X7/3HO5XnINqGPVOHTXgXMfiD7nDcq63
         lRCriY75v4nMc1F8v/0f6z7SGfyfv9IAPOwyOGDkK4o3hpc1/zvLcbGnULi1IUNmUEHD
         7k/A==
X-Forwarded-Encrypted: i=1; AJvYcCWhe2WPFZ4k8Y/FW/aPP6FaWQ+bDyRdAiIsc8hsO4aXnWdGytYZ0hQzYlDalCySI3Rl9vWUPeSpNz6v198=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ekYxmV3+ayJ9bRtLfwKZSFifQcAbL1M8aySq5FZDRkIimIHw
	lRE6g8CcNQPKUBUBfDSw1Llz3dqVcMgFe1lHXvOUTJFKZm4PddLB
X-Google-Smtp-Source: AGHT+IH2aTee1fvftdnkbuuRP0h6QHYhefVJ/JHUJuhjgKucjhqYQClN/hlAUA8gbCCJ7KVBaejObA==
X-Received: by 2002:a05:6a20:cf84:b0:1d2:e458:404b with SMTP id adf61e73a8af0-1d30a91f380mr18066767637.14.1727094805325;
        Mon, 23 Sep 2024 05:33:25 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc8b30sm13813347b3a.190.2024.09.23.05.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:33:24 -0700 (PDT)
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
Subject: [PATCH v2] drm/panel: elida-kd35t133: transition to mipi_dsi wrapped functions
Date: Mon, 23 Sep 2024 17:55:58 +0530
Message-ID: <20240923122558.728516-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the elida-kd35t133 panel to use multi style functions for
improved error handling.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
Changes in v2:
    - Changed mipi_dsi_dcs_write to mipi_dsi_dcs_write_buffer_multi
    - Cleaned up error handling

Link to v1: https://lore.kernel.org/all/20240917071710.1254520-1-tejasvipin76@gmail.com/
---
 drivers/gpu/drm/panel/panel-elida-kd35t133.c | 108 ++++++++-----------
 1 file changed, 45 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index 00791ea81e90..2c031301fdd2 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -50,55 +50,44 @@ static inline struct kd35t133 *panel_to_kd35t133(struct drm_panel *panel)
 	return container_of(panel, struct kd35t133, panel);
 }
 
-static int kd35t133_init_sequence(struct kd35t133 *ctx)
+static void kd35t133_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	struct device *dev = ctx->dev;
-
 	/*
 	 * Init sequence was supplied by the panel vendor with minimal
 	 * documentation.
 	 */
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
-			       0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
-			       0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
-			       0x00, 0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
-			       0x4d, 0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
-	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
-			       0x20, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
-			       0xa9, 0x51, 0x2c, 0x82);
-	mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);
-
-	dev_dbg(dev, "Panel init sequence done\n");
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POSITIVEGAMMA,
+				     0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
+				     0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_NEGATIVEGAMMA,
+				     0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
+				     0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POWERCONTROL2, 0x41);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_FRAMERATECTRL, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
+				     0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_ADJUSTCONTROL3,
+				     0x51, 0x2c, 0x82);
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, NULL, 0);
 }
 
 static int kd35t133_unprepare(struct drm_panel *panel)
 {
 	struct kd35t133 *ctx = panel_to_kd35t133(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		dev_err(ctx->dev, "failed to set display off: %d\n", ret);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 
@@ -112,18 +101,20 @@ static int kd35t133_prepare(struct drm_panel *panel)
 {
 	struct kd35t133 *ctx = panel_to_kd35t133(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dev_dbg(ctx->dev, "Resetting the panel\n");
-	ret = regulator_enable(ctx->vdd);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to enable vdd supply: %d\n", ret);
-		return ret;
+	dsi_ctx.accum_err = regulator_enable(ctx->vdd);
+	if (dsi_ctx.accum_err) {
+		dev_err(ctx->dev, "Failed to enable vdd supply: %d\n",
+			dsi_ctx.accum_err);
+		return dsi_ctx.accum_err;
 	}
 
-	ret = regulator_enable(ctx->iovcc);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
+	dsi_ctx.accum_err = regulator_enable(ctx->iovcc);
+	if (dsi_ctx.accum_err) {
+		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n",
+			dsi_ctx.accum_err);
 		goto disable_vdd;
 	}
 
@@ -135,27 +126,18 @@ static int kd35t133_prepare(struct drm_panel *panel)
 
 	msleep(20);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
-		goto disable_iovcc;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 250);
 
-	msleep(250);
+	kd35t133_init_sequence(&dsi_ctx);
+	if (!dsi_ctx.accum_err)
+		dev_dbg(ctx->dev, "Panel init sequence done\n");
 
-	ret = kd35t133_init_sequence(ctx);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
-		goto disable_iovcc;
-	}
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to set display on: %d\n", ret);
+	if (dsi_ctx.accum_err)
 		goto disable_iovcc;
-	}
-
-	msleep(50);
 
 	return 0;
 
@@ -163,7 +145,7 @@ static int kd35t133_prepare(struct drm_panel *panel)
 	regulator_disable(ctx->iovcc);
 disable_vdd:
 	regulator_disable(ctx->vdd);
-	return ret;
+	return dsi_ctx.accum_err;
 }
 
 static const struct drm_display_mode default_mode = {
-- 
2.46.1


