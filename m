Return-Path: <linux-kernel+bounces-305525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2740B962FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A736B22173
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039421A76C1;
	Wed, 28 Aug 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh4d3PZD"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECF0154C19
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869611; cv=none; b=KJLiS00Id83ubN+XVgZKtWTwwZf4IbhDjv7hGBzjfXQoc8NTgoz15T19CnXNR1Jrs0FSeVI6pGRvPfYe2lSg4CdbpPhGo2pCSTxe0ierU3LzVB4oNTcGrL4BQiIuQt+TLUFs9y/FuCrM9EASXdMOZBN2wDrDG1yQMzZQVaJbMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869611; c=relaxed/simple;
	bh=WNmFxmkbhmouO7S4e9WUW/QOLGBiModPn2gBnqr0L/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6/uPDs9/YUcPzc+GheRlI080pJybzUn66cft6ZYlA6CC7R1a9fK2sE8k1pt7ebGmtzJl5PeTEqHuIzl28NYemS3bGX5KfRqfbi7T26elDXIBWXhvO5U8ZXg7kxJJe80jAapkA2Vvd95xGKe+AdhycWLx1TDyvLz6NX8m6/NeyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh4d3PZD; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cd967d8234so4294488a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724869609; x=1725474409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGSEynY/tSTPK3DW4OerxLnNLuQyWG4hJwz9J7iPcWQ=;
        b=dh4d3PZDcX6KLxKa6n9r2jL3HWGGcPEdc5/hUOTf6OSokV4uxJWZuHnFRDq4nGoBkO
         smxZKJvhYtmBb64SxyIfj58FFxaMFAMV/MWrrWZB5pJ+IxJGiPnMnvR5vh/6c3JM1vcB
         LaSywpx6cUfPG7XqxvBbMlQ36xajBp1t5fwZzYaLizLwg3nBRi0o7tE/3Sk/1u8VHkf9
         EBVU+S/XFNwqEtykkQFwry7JTMgNN+POq84sdCZvufX6RPXQ0PJIvpI0l5cx3ZjG6ZRG
         ryxSTndSYeBPNntnizEjSsHMhigxx5A2PETt0ReA5jVAlD5sQyllw6sfq0xDpJh4+czG
         uifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869609; x=1725474409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGSEynY/tSTPK3DW4OerxLnNLuQyWG4hJwz9J7iPcWQ=;
        b=kdN06LWv330K0FTBAPQqsSEIfsCIMICij0mk0dsp3YwVuoqkwMNKqksJL1ibnkksNG
         tXgaJ2nyh2pNAHAVTqKc5ZzFEcK99dfNb1DS9Re3sR9u3jo0VwfqGogySnNlDnxhHiNR
         guabfNMf16tEVA8gMLn5xVGH0sKuE2dQ6Aqxt7GyKvedD0QGR5GeKf5IpzwYIeKvohfb
         S1mBHNvyXjt2G4nVd4+xWm5uT/b9kNDBbz2gy+StSYbQX1tXO9tvTiF4KXjtUZMQ4vvX
         u0ktHSkvcjvQBouFes5ANfAyxz7qezoLwvmgA6y7y7v5+qzohgA5ReFONOTY+/b9TqlV
         RvXw==
X-Forwarded-Encrypted: i=1; AJvYcCXEQTuWZdn48Rc15Var2/rXF8sLe0qzfBICBdftM/FP5ZhhzjEmyHECppGxERhogrGZj/FogE63AZWaGu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IK7BIIrqjVW7aVxJm1q9K0Yady0fkfYuvIMb6aB61g/9z234
	V2QqFK87tghys7hRKdSSU3hQ/W/gsYc/zPCwxlNm28lD+viQUxtO
X-Google-Smtp-Source: AGHT+IEGvbnuPPwVLsqdo82Q5zCnJQ7MDvQGxHqiZZlUXQCu4WYy7vm+ubSpfUrTHl5/YB7u3xGnpw==
X-Received: by 2002:a05:6a21:38b:b0:1c2:9095:7382 with SMTP id adf61e73a8af0-1cce10ff577mr188460637.52.1724869608960;
        Wed, 28 Aug 2024 11:26:48 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([103.4.220.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434335e77sm10350929b3a.202.2024.08.28.11.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:26:48 -0700 (PDT)
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
Subject: [PATCH v2] drm/panel: novatek-nt35950: transition to mipi_dsi wrapped functions
Date: Wed, 28 Aug 2024 23:52:10 +0530
Message-ID: <20240828182210.565861-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the novatek-nt35950 panel to use multi style functions for
improved error handling.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
Changes in v2:
    - Style changes
    - Fixed changes in logic

v1: https://lore.kernel.org/all/20240824084422.202946-1-tejasvipin76@gmail.com/
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 211 ++++++------------
 1 file changed, 66 insertions(+), 145 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 028fdac293f7..b036208f9356 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -100,106 +100,87 @@ static void nt35950_reset(struct nt35950 *nt)
 
 /*
  * nt35950_set_cmd2_page - Select manufacturer control (CMD2) page
+ * @dsi_ctx: context for mipi_dsi functions
  * @nt:   Main driver structure
  * @page: Page number (0-7)
- *
- * Return: Number of transferred bytes or negative number on error
  */
-static int nt35950_set_cmd2_page(struct nt35950 *nt, u8 page)
+static void nt35950_set_cmd2_page(struct mipi_dsi_multi_context *dsi_ctx,
+				  struct nt35950 *nt, u8 page)
 {
 	const u8 mauc_cmd2_page[] = { MCS_CMD_MAUCCTR, 0x55, 0xaa, 0x52,
 				      0x08, page };
-	int ret;
 
-	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], mauc_cmd2_page,
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, mauc_cmd2_page,
 					ARRAY_SIZE(mauc_cmd2_page));
-	if (ret < 0)
-		return ret;
-
-	nt->last_page = page;
-	return 0;
+	if (!dsi_ctx->accum_err)
+		nt->last_page = page;
 }
 
 /*
  * nt35950_set_data_compression - Set data compression mode
+ * @dsi_ctx: context for mipi_dsi functions
  * @nt:        Main driver structure
  * @comp_mode: Compression mode
- *
- * Return: Number of transferred bytes or negative number on error
  */
-static int nt35950_set_data_compression(struct nt35950 *nt, u8 comp_mode)
+static void nt35950_set_data_compression(struct mipi_dsi_multi_context *dsi_ctx,
+					 struct nt35950 *nt, u8 comp_mode)
 {
 	u8 cmd_data_compression[] = { MCS_PARAM_DATA_COMPRESSION, comp_mode };
 	u8 cmd_vesa_dsc_on[] = { MCS_PARAM_VESA_DSC_ON, !!comp_mode };
 	u8 cmd_vesa_dsc_setting[] = { MCS_PARAM_VESA_DSC_SETTING, 0x03 };
 	u8 last_page = nt->last_page;
-	int ret;
 
 	/* Set CMD2 Page 0 if we're not there yet */
-	if (last_page != 0) {
-		ret = nt35950_set_cmd2_page(nt, 0);
-		if (ret < 0)
-			return ret;
-	}
+	if (last_page != 0)
+		nt35950_set_cmd2_page(dsi_ctx, nt, 0);
 
-	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_data_compression,
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_data_compression,
 					ARRAY_SIZE(cmd_data_compression));
-	if (ret < 0)
-		return ret;
-
-	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_vesa_dsc_on,
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_vesa_dsc_on,
 					ARRAY_SIZE(cmd_vesa_dsc_on));
-	if (ret < 0)
-		return ret;
 
 	/* Set the vesa dsc setting on Page 4 */
-	ret = nt35950_set_cmd2_page(nt, 4);
-	if (ret < 0)
-		return ret;
+	nt35950_set_cmd2_page(dsi_ctx, nt, 4);
 
 	/* Display Stream Compression setting, always 0x03 */
-	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_vesa_dsc_setting,
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_vesa_dsc_setting,
 					ARRAY_SIZE(cmd_vesa_dsc_setting));
-	if (ret < 0)
-		return ret;
 
 	/* Get back to the previously set page */
-	return nt35950_set_cmd2_page(nt, last_page);
+	nt35950_set_cmd2_page(dsi_ctx, nt, last_page);
 }
 
 /*
  * nt35950_set_scaler - Enable/disable resolution upscaling
- * @nt:        Main driver structure
+ * @dsi_ctx: context for mipi_dsi functions
  * @scale_up:  Scale up function control
- *
- * Return: Number of transferred bytes or negative number on error
  */
-static int nt35950_set_scaler(struct nt35950 *nt, u8 scale_up)
+static void nt35950_set_scaler(struct mipi_dsi_multi_context *dsi_ctx,
+			       u8 scale_up)
 {
 	u8 cmd_scaler[] = { MCS_PARAM_SCALER_FUNCTION, scale_up };
 
-	return mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_scaler,
-					 ARRAY_SIZE(cmd_scaler));
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_scaler,
+					ARRAY_SIZE(cmd_scaler));
 }
 
 /*
  * nt35950_set_scale_mode - Resolution upscaling mode
- * @nt:   Main driver structure
+ * @dsi_ctx: context for mipi_dsi functions
  * @mode: Scaler mode (MCS_DATA_COMPRESSION_*)
- *
- * Return: Number of transferred bytes or negative number on error
  */
-static int nt35950_set_scale_mode(struct nt35950 *nt, u8 mode)
+static void nt35950_set_scale_mode(struct mipi_dsi_multi_context *dsi_ctx,
+				   u8 mode)
 {
 	u8 cmd_scaler[] = { MCS_PARAM_SCALEUP_MODE, mode };
 
-	return mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_scaler,
-					 ARRAY_SIZE(cmd_scaler));
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_scaler,
+					ARRAY_SIZE(cmd_scaler));
 }
 
 /*
  * nt35950_inject_black_image - Display a completely black image
- * @nt:   Main driver structure
+ * @dsi_ctx: context for mipi_dsi functions
  *
  * After IC setup, the attached panel may show random data
  * due to driveric behavior changes (resolution, compression,
@@ -208,43 +189,34 @@ static int nt35950_set_scale_mode(struct nt35950 *nt, u8 mode)
  * the display.
  * It makes sense to push a black image before sending the sleep-out
  * and display-on commands.
- *
- * Return: Number of transferred bytes or negative number on error
  */
-static int nt35950_inject_black_image(struct nt35950 *nt)
+static void nt35950_inject_black_image(struct mipi_dsi_multi_context *dsi_ctx)
 {
 	const u8 cmd0_black_img[] = { 0x6f, 0x01 };
 	const u8 cmd1_black_img[] = { 0xf3, 0x10 };
 	u8 cmd_test[] = { 0xff, 0xaa, 0x55, 0xa5, 0x80 };
-	int ret;
 
 	/* Enable test command */
-	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_test, ARRAY_SIZE(cmd_test));
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_test, ARRAY_SIZE(cmd_test));
 
 	/* Send a black image */
-	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd0_black_img,
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd0_black_img,
 					ARRAY_SIZE(cmd0_black_img));
-	if (ret < 0)
-		return ret;
-	ret = mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd1_black_img,
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd1_black_img,
 					ARRAY_SIZE(cmd1_black_img));
-	if (ret < 0)
-		return ret;
 
 	/* Disable test command */
 	cmd_test[ARRAY_SIZE(cmd_test) - 1] = 0x00;
-	return mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_test, ARRAY_SIZE(cmd_test));
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_test, ARRAY_SIZE(cmd_test));
 }
 
 /*
  * nt35950_set_dispout - Set Display Output register parameters
  * @nt:    Main driver structure
- *
- * Return: Number of transferred bytes or negative number on error
+ * @dsi_ctx: context for mipi_dsi functions
  */
-static int nt35950_set_dispout(struct nt35950 *nt)
+static void nt35950_set_dispout(struct mipi_dsi_multi_context *dsi_ctx,
+				struct nt35950 *nt)
 {
 	u8 cmd_dispout[] = { MCS_PARAM_DISP_OUTPUT_CTRL, 0x00 };
 	const struct nt35950_panel_mode *mode_data = nt->desc->mode_data;
@@ -254,8 +226,8 @@ static int nt35950_set_dispout(struct nt35950 *nt)
 	if (mode_data[nt->cur_mode].enable_sram)
 		cmd_dispout[1] |= MCS_DISP_OUT_SRAM_EN;
 
-	return mipi_dsi_dcs_write_buffer(nt->dsi[0], cmd_dispout,
-					 ARRAY_SIZE(cmd_dispout));
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, cmd_dispout,
+					ARRAY_SIZE(cmd_dispout));
 }
 
 static int nt35950_get_current_mode(struct nt35950 *nt)
@@ -284,78 +256,47 @@ static int nt35950_on(struct nt35950 *nt)
 {
 	const struct nt35950_panel_mode *mode_data = nt->desc->mode_data;
 	struct mipi_dsi_device *dsi = nt->dsi[0];
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	nt->cur_mode = nt35950_get_current_mode(nt);
 	nt->dsi[0]->mode_flags |= MIPI_DSI_MODE_LPM;
 	nt->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	ret = nt35950_set_cmd2_page(nt, 0);
-	if (ret < 0)
-		return ret;
+	nt35950_set_cmd2_page(&dsi_ctx, nt, 0);
+	nt35950_set_data_compression(&dsi_ctx, nt, mode_data[nt->cur_mode].compression);
+	nt35950_set_scale_mode(&dsi_ctx, mode_data[nt->cur_mode].scaler_mode);
+	nt35950_set_scaler(&dsi_ctx, mode_data[nt->cur_mode].scaler_on);
+	nt35950_set_dispout(&dsi_ctx, nt);
 
-	ret = nt35950_set_data_compression(nt, mode_data[nt->cur_mode].compression);
-	if (ret < 0)
-		return ret;
-
-	ret = nt35950_set_scale_mode(nt, mode_data[nt->cur_mode].scaler_mode);
-	if (ret < 0)
-		return ret;
-
-	ret = nt35950_set_scaler(nt, mode_data[nt->cur_mode].scaler_on);
-	if (ret < 0)
-		return ret;
-
-	ret = nt35950_set_dispout(nt);
-	if (ret < 0)
-		return ret;
-
-	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear on: %d\n", ret);
-		return ret;
-	}
-
-	ret = mipi_dsi_dcs_set_tear_scanline(dsi, 0);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set tear scanline: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx, 0);
 
 	/* CMD2 Page 1 */
-	ret = nt35950_set_cmd2_page(nt, 1);
-	if (ret < 0)
-		return ret;
+	nt35950_set_cmd2_page(&dsi_ctx, nt, 1);
 
 	/* Unknown command */
-	mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x88, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x88, 0x88);
 
 	/* CMD2 Page 7 */
-	ret = nt35950_set_cmd2_page(nt, 7);
-	if (ret < 0)
-		return ret;
+	nt35950_set_cmd2_page(&dsi_ctx, nt, 7);
 
 	/* Enable SubPixel Rendering */
-	mipi_dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_EN, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MCS_PARAM_SPR_EN, 0x01);
 
 	/* SPR Mode: YYG Rainbow-RGB */
-	mipi_dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_MODE, MCS_SPR_MODE_YYG_RAINBOW_RGB);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MCS_PARAM_SPR_MODE,
+				     MCS_SPR_MODE_YYG_RAINBOW_RGB);
 
 	/* CMD3 */
-	ret = nt35950_inject_black_image(nt);
-	if (ret < 0)
-		return ret;
+	nt35950_inject_black_image(&dsi_ctx);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0)
-		return ret;
-	msleep(120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0)
-		return ret;
-	msleep(120);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	nt->dsi[0]->mode_flags &= ~MIPI_DSI_MODE_LPM;
 	nt->dsi[1]->mode_flags &= ~MIPI_DSI_MODE_LPM;
@@ -363,30 +304,19 @@ static int nt35950_on(struct nt35950 *nt)
 	return 0;
 }
 
-static int nt35950_off(struct nt35950 *nt)
+static void nt35950_off(struct nt35950 *nt)
 {
-	struct device *dev = &nt->dsi[0]->dev;
-	int ret;
+	struct mipi_dsi_device *dsi = nt->dsi[0];
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(nt->dsi[0]);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		goto set_lpm;
-	}
-	usleep_range(10000, 11000);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(nt->dsi[0]);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		goto set_lpm;
-	}
-	msleep(150);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 150);
 
-set_lpm:
 	nt->dsi[0]->mode_flags |= MIPI_DSI_MODE_LPM;
 	nt->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
-
-	return 0;
 }
 
 static int nt35950_sharp_init_vregs(struct nt35950 *nt, struct device *dev)
@@ -427,7 +357,6 @@ static int nt35950_sharp_init_vregs(struct nt35950 *nt, struct device *dev)
 static int nt35950_prepare(struct drm_panel *panel)
 {
 	struct nt35950 *nt = to_nt35950(panel);
-	struct device *dev = &nt->dsi[0]->dev;
 	int ret;
 
 	ret = regulator_enable(nt->vregs[0].consumer);
@@ -452,10 +381,6 @@ static int nt35950_prepare(struct drm_panel *panel)
 	nt35950_reset(nt);
 
 	ret = nt35950_on(nt);
-	if (ret < 0) {
-		dev_err(dev, "Failed to initialize panel: %d\n", ret);
-		goto end;
-	}
 
 end:
 	if (ret < 0) {
@@ -469,12 +394,8 @@ static int nt35950_prepare(struct drm_panel *panel)
 static int nt35950_unprepare(struct drm_panel *panel)
 {
 	struct nt35950 *nt = to_nt35950(panel);
-	struct device *dev = &nt->dsi[0]->dev;
-	int ret;
 
-	ret = nt35950_off(nt);
-	if (ret < 0)
-		dev_err(dev, "Failed to deinitialize panel: %d\n", ret);
+	nt35950_off(nt);
 
 	gpiod_set_value_cansleep(nt->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(nt->vregs), nt->vregs);
-- 
2.46.0


