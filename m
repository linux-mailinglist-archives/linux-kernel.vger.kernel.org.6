Return-Path: <linux-kernel+bounces-245948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C2E92BBB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9562B23FFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F63158DCD;
	Tue,  9 Jul 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="DTKxc8hE"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984516B38F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532895; cv=none; b=RKtEtAqMlDrFTdID1MdETJAYOlp369CHxdSK4SREI4h0QjCC93WxiLKLlc8+W3LF5RSn60M4pYuVh42l4pybMs/U4ZUqIrLVXSkVFYF1FZr20uWYpOPDUuPWcxH1HJvYPA9Vr6aZB+aHTDD5m3tLrptKmZoavJ0e3h6Qj93dytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532895; c=relaxed/simple;
	bh=YN5rayB4FkzBfWo05KRJJBtnLL3iGZVj26fPYXLj4II=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hGwCvttL2U/cnnDyckOhCug9p+DNqH3IAo2MIGOM5NDLFslMUFFbiHi+wBMnIG8EdbYauncYJaiDdgDX+nA1PEXD7tEmjrvZqdQqN7kgHu/j5189sAhaitdQSNJE0ccDZ7B9JwvzLgMRTmZUimOlXRMxXwbS1tbskEddhpwxu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=DTKxc8hE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb3cf78fbdso26296805ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720532893; x=1721137693; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CYdWEsy6O+5XGf0fUOZ1in9Gq/j66NH1BeYWcQlMcy8=;
        b=DTKxc8hEPMSVsLqxGef9yqgKzjufcaQoItboSzPiqycNZ8cgW+R/VdTpuUFykpT6vL
         +p2W/qXK5zXTJLV3onISoLWDeKKkg3bBwaVyfzU2OY8LRUrDR7h2Hw+j4969aQl/TMW0
         S/Y0RndNjwH1eJbUsX9OgOI7whj5SQX9bnrRJfTVfx4dd5qzuSYP43Kz5OmeLZjI+Gxs
         s1Kkz5N9Xav7uDmC6o2cLUrTs8qMPi3O79gQe9W7Z20R3I+vBGngPgQoADfUfv55l8eb
         vsCLGu9hBXut9o6Ts5TPPiqZyWxU+3g1FJjj/H7THadj/PAYJJPPK35yJ31trFLXGGd5
         A4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720532893; x=1721137693;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYdWEsy6O+5XGf0fUOZ1in9Gq/j66NH1BeYWcQlMcy8=;
        b=plnW0XsEAGJDIrEpSvVvaI2zoJBoSH67AlfqQ92Bgcqd/Zb65Di2XLIjh3P1xmOsd5
         dvWsvy+NioVcwvpou3/DI2NL2HxMLNFVuXMLFbXHiVkmg34H8w/CS6YCSVUK78wh9Ma1
         EujOnpBCGMP7t+culrIQNFvbDKpWRzGzD0ZsXuhzJjk97e7256lNoeAIzxnPp27K9Ekz
         fdLZeW+NR/l5CewZxKcDyIoJIQYSUNuMfnkSH/BaDvS/TEAVfjMCxVeMysXtSissZJf3
         LJjDj6eSs/7+sXlhzsCwrSnxl33tHeH3fBCdG2LZwPY3OeCGMmH08qMeIemTlYTD6R5R
         w5aw==
X-Forwarded-Encrypted: i=1; AJvYcCUO8a1cVjsDJg7o1zzevkh9+H/Y6wnVidxrv9I8VBrFZpisGFv/lGwLTK0emSjsI1p6bA66YBgN/ee5Ssst2m6U/MxJXiU7fyNa57lh
X-Gm-Message-State: AOJu0YxUK8/E20VA+ODWYBs+Xp2feGXIavv981GCOT8uTDzCacZ2JhkN
	yZUkDvf8tlvpVWjKauaIlzmDEuHXb78/YiN642FfmHMOkWeI8l0N12/yYuCnzMc=
X-Google-Smtp-Source: AGHT+IHf3jGkzIV/7x6CYbaGZ5oidggGkve7x/0gRMjUtvEvEhpQPLV5dlBWQeOqvyZ4ARjS8WK1Aw==
X-Received: by 2002:a17:903:283:b0:1fb:9a83:4496 with SMTP id d9443c01a7336-1fbb6cd18dfmr23414525ad.2.1720532893234;
        Tue, 09 Jul 2024 06:48:13 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6b9fsm16211685ad.138.2024.07.09.06.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:48:12 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
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
Subject: [PATCH v6 1/5] drm/panel: boe-th101mb31ig002 : Make it compatible with other panel.
Date: Tue,  9 Jul 2024 21:47:50 +0800
Message-Id: <20240709134754.28013-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240709134754.28013-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This driver currently only applies to one panel. Modify it to be
compatible with other panels.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Changes between V6 and V5:
-  1. Corrected the use of "->init" in struct panel_desc, 
-  2. Modify indentation in "boe_th101mb31ig002_of_match[]"
v5: https://lore.kernel.org/all/20240704072958.27876-2-lvzhaoxiong@huaqin.corp-partner.google.com/
---
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 41 +++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 763e9f8342d3..8f03920e3503 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -17,11 +17,21 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
+struct panel_desc {
+	const struct drm_display_mode *modes;
+	unsigned long mode_flags;
+	enum mipi_dsi_pixel_format format;
+	int (*init)(struct drm_panel *panel);
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
+	ret = ctx->desc->init(panel);
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
+	.init = boe_th101mb31ig002_enable,
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
@@ -302,7 +326,10 @@ static void boe_th101mb31ig002_dsi_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id boe_th101mb31ig002_of_match[] = {
-	{ .compatible = "boe,th101mb31ig002-28a", },
+	{
+		.compatible = "boe,th101mb31ig002-28a",
+		.data = &boe_th101mb31ig002_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, boe_th101mb31ig002_of_match);
-- 
2.17.1


