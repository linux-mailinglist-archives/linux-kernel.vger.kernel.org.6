Return-Path: <linux-kernel+bounces-240661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29DF92709B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3222D1F23E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD901A2C31;
	Thu,  4 Jul 2024 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Zwch8pCr"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6016C6A4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078219; cv=none; b=BTJiL6rdn07nNJrpo2uGUh9K68XBjJI3rYxN9HJZvb/sSndrHzfBqY5deSWB4Mg1Rko3FRc2z2k5HQv2sat58C9coEnOt+uZ+k4TSR8S1qnhy+OxHOps6Lf4p+MX4fFMDmAomaoB+4mh7lokTHC3vB5JWOx8PHaGkUjYaykaSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078219; c=relaxed/simple;
	bh=ggVqxH/QQ/Kzn+pAFcaiDRqvXfTsWr8WKu5vGhWojtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PJWeSg/mSvFCcTKWGsUcrF/rdGHP9lmWSz+wLJ+eAYSC7IZDuv3DzTUBFLDwUmJjROxY6JfNvy3BfUG9g6Oca5is5bWu/m4vx1Vf/AFyLl27QgnK1Mt3Nm7HPA7LQr2EabQVsnC09BCNOekR+kS+dgRDaZIW5wCnlSDltU+M5I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Zwch8pCr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70af8128081so280074b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720078217; x=1720683017; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xg0hLlO8+PF9aQb4nRdBoCDmNrfex1VFsOmkO3c71VM=;
        b=Zwch8pCr4lrNgki3mf9dItoFEH3KBWTX50J3416M3jvAoQYNXsRQyxGakafIFeUC+J
         JHtRYeXcNMDwVsVJyMZ67rNBiTaQDznBKAIZkFIJ0cEztzVje+T0CGXYiR/fWMCvQKTu
         /sBlzz4qOTilTtX83ZWoShyCmCIJoNMJ1yeamBbgPqP80zuoyM6oEhsNhYh/1FRjulfD
         uo1oUaEv5eNqnXSFxlG8PgDA++LN0DDTCNiSI/pAUyfAsgYEmjYxnCJXWMhmvHk19ql5
         20D4bb/19ggGKzhgsqw3ZIuHsmtfheOLptN3ADlk3js2HcAM6b7waZq75EmqLbwi6Fmq
         CUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078217; x=1720683017;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xg0hLlO8+PF9aQb4nRdBoCDmNrfex1VFsOmkO3c71VM=;
        b=GtGBwgUWDpmutO4NnxeKIntnTLkV9M+BWXMD6fSk3khLYFnp6X4vPWeQxcMKjjV0Ca
         2tgdQ/wJHS7BZebAjV2FpGLiTngnSThtdVtgYmYamBtiyvmhk3DVyZCh6kj+kAvg2LQE
         YwVWS1aEz/ch9gUxf/jdi6kkUeh1XiIs9Kbpt2NweTQ7GqYyQZoMPBJklHqcocBSpcGM
         i3P9ea6bJ9roUXBRFjrepsUU1N641frYRdY+XIH6UGGOUp8HJqsLsu+ASXPujpNo2Axh
         y7z0TY31iDp4Lxp3Y5Jk3Mw4Bx8aVHxFXl3IgJ0ixAEwbrz/JQY/5O0U5PUk5P/h9b8B
         nrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHXYNBrtQnGJzLV8goEFBcoMv0Tenx109tDVnglMGh2LaaZmrJacTX1aNc/0cPqsPXPoaj4I3bnNyM/kjQYOBD1ejxg/dF91bjTeLi
X-Gm-Message-State: AOJu0YwztbkOkhjZHS2nvA4LX5IRnUmTfrXGtnvPBcQPQMdVjzzR/Hyz
	gKEWbCAnek/VUPvYSyNH+IX2IpNFNFdNaimpT/69UTdKz+muYzmCHKnrIVVWy5A=
X-Google-Smtp-Source: AGHT+IETpniVgYzkLnFj0BogOQwz/7wCD/Kjlbtg/LVXdXjJlvArmj0gpZgytp1RjHa5oC0z9AuOWg==
X-Received: by 2002:a05:6a20:9187:b0:1bd:8581:2f61 with SMTP id adf61e73a8af0-1c0cc8d4d5bmr809458637.39.1720078216785;
        Thu, 04 Jul 2024 00:30:16 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm7735699a12.31.2024.07.04.00.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:30:16 -0700 (PDT)
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
Subject: [PATCH v5 1/5] drm/panel: boe-th101mb31ig002 : Make it compatible with other panel.
Date: Thu,  4 Jul 2024 15:29:54 +0800
Message-Id: <20240704072958.27876-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240704072958.27876-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This driver currently only applies to one panel. Modify it to be
compatible with other panels.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 40 +++++++++++++++----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 763e9f8342d3..159e401ad0e6 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -17,11 +17,21 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
+struct panel_desc {
+	const struct drm_display_mode *modes;
+	unsigned long mode_flags;
+	enum mipi_dsi_pixel_format format;
+	const struct panel_init_cmd *init_cmds;
+	unsigned int lanes;
+};
+
 struct boe_th101mb31ig002 {
 	struct drm_panel panel;
 
 	struct mipi_dsi_device *dsi;
 
+	const struct panel_desc *desc;
+
 	struct regulator *power;
 	struct gpio_desc *enable;
 	struct gpio_desc *reset;
@@ -161,7 +171,10 @@ static int boe_th101mb31ig002_prepare(struct drm_panel *panel)
 	gpiod_set_value_cansleep(ctx->enable, 1);
 	msleep(50);
 	boe_th101mb31ig002_reset(ctx);
-	boe_th101mb31ig002_enable(panel);
+
+	ret = ctx->desc->init(ctx);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -181,6 +194,16 @@ static const struct drm_display_mode boe_th101mb31ig002_default_mode = {
 	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 };
 
+static const struct panel_desc boe_th101mb31ig002_desc = {
+	.modes = &boe_th101mb31ig002_default_mode,
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_NO_EOT_PACKET |
+			  MIPI_DSI_MODE_LPM,
+	.init_cmds = boe_th101mb31ig002_enable,
+};
+
 static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
 					struct drm_connector *connector)
 {
@@ -237,6 +260,7 @@ static const struct drm_panel_funcs boe_th101mb31ig002_funcs = {
 static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	struct boe_th101mb31ig002 *ctx;
+	const struct panel_desc *desc;
 	int ret;
 
 	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
@@ -246,11 +270,11 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 	mipi_dsi_set_drvdata(dsi, ctx);
 	ctx->dsi = dsi;
 
-	dsi->lanes = 4;
-	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_NO_EOT_PACKET |
-			  MIPI_DSI_MODE_LPM;
+	desc = of_device_get_match_data(&dsi->dev);
+	dsi->lanes = desc->lanes;
+	dsi->format = desc->format;
+	dsi->mode_flags = desc->mode_flags;
+	ctx->desc = desc;
 
 	ctx->power = devm_regulator_get(&dsi->dev, "power");
 	if (IS_ERR(ctx->power))
@@ -302,7 +326,9 @@ static void boe_th101mb31ig002_dsi_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id boe_th101mb31ig002_of_match[] = {
-	{ .compatible = "boe,th101mb31ig002-28a", },
+	{ .compatible = "boe,th101mb31ig002-28a",
+	  .data = &boe_th101mb31ig002_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, boe_th101mb31ig002_of_match);
-- 
2.17.1


