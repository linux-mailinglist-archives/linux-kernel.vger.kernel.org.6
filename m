Return-Path: <linux-kernel+bounces-240664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E4E9270A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3AD1C23642
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A699719AD73;
	Thu,  4 Jul 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="dfFhU33O"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5600B1A254F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078233; cv=none; b=XXroLEr/8ueWJJYy9j6Q/eLYbDumCcBFRx3kvyHFKLcKNzMfVx8w5BzItHyIWNch64M2imwm9XF9PYNXM3paBpswcTSS+6ha1XiQPwTAZwGs6OcmvIJ3X4b+suAyMDPlcWaDqxNVc36Oyi9lr1mEJQjQoNUMQzAhIrGLJ6TA07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078233; c=relaxed/simple;
	bh=Xkjm8S6T2GsIPMzXQj2Tpe1yEIrshYdZMUSzUQ2OyTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ovWBSsqGA/n6NUlFZMV7rw1UapA62/ZXufm3gw0gkshBIc8wzbTlTzEjNOokp7SV5j0iuMoJToYHWp7LSY+980jg0XuzTdeHhtZ83WoAavTpHfwOxBg67wpH+aAPiA2dvRV6MNoKYVBeufMkujqu+fYSg+Ym8+1/omJ2DBGYM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=dfFhU33O; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d565deea08so242942b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720078228; x=1720683028; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RWUyP0FQ5nLUTQp3iV2KD4j7bO0bm88DdSGl5HIJ9co=;
        b=dfFhU33OhgFdwEOaWDRyDJnIQkM2dUzAIda69lPdGvTGVmOhrfD+xM7RhfjfhxFnOX
         gDox5sqtRWuYuzHg/yScxb3u9l69TckNJSJqqjqr3hqYLoAsYrPcMLkT4+Lnl5ifTpdd
         9kh7+fZN5U2M2T06phT46GZOqgp+FXly+e5rQ5CqlBlJC8CMgCUNVozFReS94fcndQ9A
         QOwu3ewicCMfBzopWM9w8h+EulLRqQ00Q4dMQcTgDKQEqLzB6CO1sMDnCp/SPhyhFto7
         GRnZm9IR8+KNVE67zaOY8qkOqoju94PfMvVqDAme9Ptlunmw7Kyo1JRxTzq6fNY0e9GB
         fssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078228; x=1720683028;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWUyP0FQ5nLUTQp3iV2KD4j7bO0bm88DdSGl5HIJ9co=;
        b=VJsEP7KeVzkAOvk0Y3n9+mofc2HPaE6uytbHKIJ+PaQ8wjObq4XqiGrjybdAF7Uv5A
         2ona1JTxlxgWiLN86JowhGvnrXcbp4ZY1xh14ZkFqiS9C8kW+eQ3j7G0I8Xep0D9uPQP
         aG0CIxS+H6iiTsm7f6Vv135iOBdofj0qrWxGb1CnJrzZMz12k+Knb2TpkbfFShOVXLhf
         fJef/3IDthsA6+qAgbQm/emRWOUdWldfr/h0qV39tMtN+vT7fxJq4YI+/0E7NMVDBSdz
         rWqyr5IiiMb1n0okOYRJvNSaCMBNwA4ulG1LDVpNzNYVg9pe5oQm1R1S1J9F/vmcT4M8
         1H1A==
X-Forwarded-Encrypted: i=1; AJvYcCWtpenk5733tqe5h1OK63806RJ4MSIjjuX4dZrgiWqrfCEJ2n8PaDwZ+E3wrvXTeIQ8gytDcKLoOaFo4dXKJIJegl5krwBgZOhLSjqw
X-Gm-Message-State: AOJu0YzgMAp6rUMPHnS/O4dRbZPR5wAK5zeVzOqdoq4avwKl0AyXfnfb
	SoPm0MtcRacHe4Yejn9s+8oiNq+GwUbxzj73pU71vhtDeLOH4xSZ+bANS9NZN4Y=
X-Google-Smtp-Source: AGHT+IG6Z/ypPsLwPhVAvPZQbhGKFk4mLpdLjXP0+3iJNMofXUq5JpQZe9gkRwHAyQmx3LEhkHF7MQ==
X-Received: by 2002:a05:6808:f8d:b0:3d2:2aa8:3b2c with SMTP id 5614622812f47-3d914c6b28amr1026922b6e.33.1720078227583;
        Thu, 04 Jul 2024 00:30:27 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm7735699a12.31.2024.07.04.00.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:30:27 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v5 3/5] drm/panel: boe-th101mb31ig002: use wrapped MIPI DCS functions
Date: Thu,  4 Jul 2024 15:29:56 +0800
Message-Id: <20240704072958.27876-4-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
simplify driver's init/enable/exit code.

Convert the hex in init_code from UPPERCASE to lowercase.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 143 ++++++++----------
 1 file changed, 63 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 9f225c15b21c..736bfba607cf 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -17,11 +17,13 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
+struct boe_th101mb31ig002;
+
 struct panel_desc {
 	const struct drm_display_mode *modes;
 	unsigned long mode_flags;
 	enum mipi_dsi_pixel_format format;
-	const struct panel_init_cmd *init_cmds;
+	int (*init)(struct boe_th101mb31ig002 *ctx);
 	unsigned int lanes;
 };
 
@@ -49,74 +51,61 @@ static void boe_th101mb31ig002_reset(struct boe_th101mb31ig002 *ctx)
 	usleep_range(5000, 6000);
 }
 
-static int boe_th101mb31ig002_enable(struct drm_panel *panel)
+static int boe_th101mb31ig002_enable(struct boe_th101mb31ig002 *ctx)
 {
-	struct boe_th101mb31ig002 *ctx = container_of(panel,
-						      struct boe_th101mb31ig002,
-						      panel);
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	mipi_dsi_dcs_write_seq(dsi, 0xE0, 0xAB, 0xBA);
-	mipi_dsi_dcs_write_seq(dsi, 0xE1, 0xBA, 0xAB);
-	mipi_dsi_dcs_write_seq(dsi, 0xB1, 0x10, 0x01, 0x47, 0xFF);
-	mipi_dsi_dcs_write_seq(dsi, 0xB2, 0x0C, 0x14, 0x04, 0x50, 0x50, 0x14);
-	mipi_dsi_dcs_write_seq(dsi, 0xB3, 0x56, 0x53, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xB4, 0x33, 0x30, 0x04);
-	mipi_dsi_dcs_write_seq(dsi, 0xB6, 0xB0, 0x00, 0x00, 0x10, 0x00, 0x10,
-				    0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xB8, 0x05, 0x12, 0x29, 0x49, 0x48, 0x00,
-				    0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xB9, 0x7C, 0x65, 0x55, 0x49, 0x46, 0x36,
-				    0x3B, 0x24, 0x3D, 0x3C, 0x3D, 0x5C, 0x4C,
-				    0x55, 0x47, 0x46, 0x39, 0x26, 0x06, 0x7C,
-				    0x65, 0x55, 0x49, 0x46, 0x36, 0x3B, 0x24,
-				    0x3D, 0x3C, 0x3D, 0x5C, 0x4C, 0x55, 0x47,
-				    0x46, 0x39, 0x26, 0x06);
-	mipi_dsi_dcs_write_seq(dsi, 0x00, 0xFF, 0x87, 0x12, 0x34, 0x44, 0x44,
-				    0x44, 0x44, 0x98, 0x04, 0x98, 0x04, 0x0F,
-				    0x00, 0x00, 0xC1);
-	mipi_dsi_dcs_write_seq(dsi, 0xC1, 0x54, 0x94, 0x02, 0x85, 0x9F, 0x00,
-				    0x7F, 0x00, 0x54, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xC2, 0x17, 0x09, 0x08, 0x89, 0x08, 0x11,
-				    0x22, 0x20, 0x44, 0xFF, 0x18, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xC3, 0x86, 0x46, 0x05, 0x05, 0x1C, 0x1C,
-				    0x1D, 0x1D, 0x02, 0x1F, 0x1F, 0x1E, 0x1E,
-				    0x0F, 0x0F, 0x0D, 0x0D, 0x13, 0x13, 0x11,
-				    0x11, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xC4, 0x07, 0x07, 0x04, 0x04, 0x1C, 0x1C,
-				    0x1D, 0x1D, 0x02, 0x1F, 0x1F, 0x1E, 0x1E,
-				    0x0E, 0x0E, 0x0C, 0x0C, 0x12, 0x12, 0x10,
-				    0x10, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xC6, 0x2A, 0x2A);
-	mipi_dsi_dcs_write_seq(dsi, 0xC8, 0x21, 0x00, 0x31, 0x42, 0x34, 0x16);
-	mipi_dsi_dcs_write_seq(dsi, 0xCA, 0xCB, 0x43);
-	mipi_dsi_dcs_write_seq(dsi, 0xCD, 0x0E, 0x4B, 0x4B, 0x20, 0x19, 0x6B,
-				    0x06, 0xB3);
-	mipi_dsi_dcs_write_seq(dsi, 0xD2, 0xE3, 0x2B, 0x38, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xD4, 0x00, 0x01, 0x00, 0x0E, 0x04, 0x44,
-				    0x08, 0x10, 0x00, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, 0xE6, 0x80, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
-				    0xFF, 0xFF);
-	mipi_dsi_dcs_write_seq(dsi, 0xF0, 0x12, 0x03, 0x20, 0x00, 0xFF);
-	mipi_dsi_dcs_write_seq(dsi, 0xF3, 0x00);
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-
-	msleep(120);
-
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set panel on: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0xab, 0xba);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0xba, 0xab);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb1, 0x10, 0x01, 0x47, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x0c, 0x14, 0x04, 0x50, 0x50, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3, 0x56, 0x53, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb4, 0x33, 0x30, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0xb0, 0x00, 0x00, 0x10, 0x00, 0x10,
+					       0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x05, 0x12, 0x29, 0x49, 0x48, 0x00,
+					       0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x7c, 0x65, 0x55, 0x49, 0x46, 0x36,
+					       0x3b, 0x24, 0x3d, 0x3c, 0x3d, 0x5c, 0x4c,
+					       0x55, 0x47, 0x46, 0x39, 0x26, 0x06, 0x7c,
+					       0x65, 0x55, 0x49, 0x46, 0x36, 0x3b, 0x24,
+					       0x3d, 0x3c, 0x3d, 0x5c, 0x4c, 0x55, 0x47,
+					       0x46, 0x39, 0x26, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0xff, 0x87, 0x12, 0x34, 0x44, 0x44,
+					       0x44, 0x44, 0x98, 0x04, 0x98, 0x04, 0x0f,
+					       0x00, 0x00, 0xc1);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x54, 0x94, 0x02, 0x85, 0x9f, 0x00,
+					       0x7f, 0x00, 0x54, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x17, 0x09, 0x08, 0x89, 0x08, 0x11,
+					       0x22, 0x20, 0x44, 0xff, 0x18, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x86, 0x46, 0x05, 0x05, 0x1c, 0x1c,
+					       0x1d, 0x1d, 0x02, 0x1f, 0x1f, 0x1e, 0x1e,
+					       0x0f, 0x0f, 0x0d, 0x0d, 0x13, 0x13, 0x11,
+					       0x11, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x07, 0x07, 0x04, 0x04, 0x1c, 0x1c,
+					       0x1d, 0x1d, 0x02, 0x1f, 0x1f, 0x1e, 0x1e,
+					       0x0e, 0x0e, 0x0c, 0x0c, 0x12, 0x12, 0x10,
+					       0x10, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc6, 0x2a, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x21, 0x00, 0x31, 0x42, 0x34, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0xcb, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcd, 0x0e, 0x4b, 0x4b, 0x20, 0x19, 0x6b,
+					       0x06, 0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd2, 0xe3, 0x2b, 0x38, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x00, 0x01, 0x00, 0x0e, 0x04, 0x44,
+					       0x08, 0x10, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x80, 0x01, 0xff, 0xff, 0xff, 0xff,
+					       0xff, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x12, 0x03, 0x20, 0x00, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0x00);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	return dsi_ctx.accum_err;
 }
 
 static int boe_th101mb31ig002_disable(struct drm_panel *panel)
@@ -124,21 +113,15 @@ static int boe_th101mb31ig002_disable(struct drm_panel *panel)
 	struct boe_th101mb31ig002 *ctx = container_of(panel,
 						      struct boe_th101mb31ig002,
 						      panel);
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		dev_err(dev, "Failed to set panel off: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	msleep(120);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int boe_th101mb31ig002_unprepare(struct drm_panel *panel)
@@ -201,7 +184,7 @@ static const struct panel_desc boe_th101mb31ig002_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_NO_EOT_PACKET |
 			  MIPI_DSI_MODE_LPM,
-	.init_cmds = boe_th101mb31ig002_enable,
+	.init = boe_th101mb31ig002_enable,
 };
 
 static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
-- 
2.17.1


