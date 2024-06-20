Return-Path: <linux-kernel+bounces-222211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A51C90FE48
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCAE1F24583
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00A41741D3;
	Thu, 20 Jun 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="gNol0SQE"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948F715EFCF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870747; cv=none; b=quPfghnVYtXgwuve4kYonUT6sidTLQv7Zf17ZOIPHrdMaxdIXX5/dqMlRQEcil95pTv7NQ6ZPdlqlyd3Qbe6kWK8Pl0XAwnooL1KVLhBDJ+UoHIXZY/Mh4tfjqFtYz7exrDpgp1JqiiZBMed16ssI1tQScBPmU7aZcUWuKrfCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870747; c=relaxed/simple;
	bh=SMy5ZQzRbzRvirozL1NBPlZTWrQNASxbahosYR4T/aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kL572Lf8aBaiNV2JeglXL5ws3AxoNZCn0LSzkKMI+sAbahOO7//f7ueSXU/juGwA1lhmSx2C2Empvb4O/Mj41bw5rvgokQxbKKQz5d0hqASGdgsv6lzTVJVheZampBsF8Uw3gdkn9f7AS0KQTPhPgjJ+Vtd6GQsg/hnecQBTkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=gNol0SQE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70436048c25so638108b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718870744; x=1719475544; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dn6UDOWgnuz6zvbbDETQvZyfl1lcf55ZCdpjJoB45yY=;
        b=gNol0SQEKbZ2YJ7jpHmq6MTAqUjOf3RVHxzzmtZL0PjdNpUmiBPTyz86dDc6DvnVq7
         /1jFCmnTzW91sCmzzcyawUSjGSXa/v+JgzwxEMQ8D/9PL6ngb9ayir2OITAOCKempnKz
         TBH+9iP508GEa3MsHZiRrgwZwrO8Txg8HqNwr9re4eV7G4K8uzejlq2grx5Jkn5ax2Ls
         NZLUqO1Flt0cPT9568b/7Rzwgqxh2sIEvFpxwMwG6xCnMc4DV8FfXWkY1zZgOLcmHNNx
         9ksjzn6R383SHvJgSxPHiKuXAZZI9xZ9vTCD+nEm1NwpR+BXAfJ9vPLPY8TVvGPYLvye
         ojUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718870744; x=1719475544;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dn6UDOWgnuz6zvbbDETQvZyfl1lcf55ZCdpjJoB45yY=;
        b=P5184k5Evl0dk3o23JY9nSA80hB4s8f4DtRwFHvQx+teJzFrLFk6ptUHDnP9ivdPl2
         KKC7i5Pzrr4/EPut8axQ1cetrj0j2Q25AgSQZqexHENYuw456H6/jbWVl0oqXZC4KeLu
         tmrm2n2fVBrCxyeQp35E8bL4UlVm0qHRSI3MxNabmaXSCzawbhFKK9H+k/IqbuaLhE/1
         xRdadjxLCVDps4enkOxoz/PDBneXLTnPAYvjl2gqsDWf5+ovk4Hh6uYo/tmqpge1Kloy
         ZgVZiSqY7YADPPtFfMiB7zdtAXmBqrMa7tSJxuRrzFT7c5YeAwoC9W+idxSf28edimhd
         aqRw==
X-Forwarded-Encrypted: i=1; AJvYcCWuRAJ10Ei58NX8TPRsGf3OGhc++kKZRDilawkCrmI2d4rucRKK/fWk2sWjCTmvvtWXXsBjyxEQxuVimh1+QH1NUKN9kq4cyf8/5N6l
X-Gm-Message-State: AOJu0YwS5fPlLIqGN8KIQz2XUW5ePfY6uj8imPH1zvaJUEPKuAhA5axl
	CDefUCjE5BWpNIeZX0O02AJ9THYCrsn+BOUk1nJyZSjvSACUqBineMya4sK0JKM=
X-Google-Smtp-Source: AGHT+IH7aptmL+hAyUU+tYWarKvY+9M8pPlEn2+s7yno1xEevBphQAGRhy8UUiknVqGeUsA3SinrnQ==
X-Received: by 2002:a05:6a20:c11a:b0:1b5:4c70:d688 with SMTP id adf61e73a8af0-1bcbb3dcb94mr4562958637.3.1718870743750;
        Thu, 20 Jun 2024 01:05:43 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96c8c5sm11805889b3a.58.2024.06.20.01.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:05:43 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v4 3/4] drm/panel: jd9365da: Support for kd101ne3-40ti MIPI-DSI panel.
Date: Thu, 20 Jun 2024 16:05:08 +0800
Message-Id: <20240620080509.18504-4-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The K&d kd101ne3-40ti is a 10.1" WXGA TFT-LCD panel, use
jd9365da controller,which fits in nicely with the existing
panel-jadard-jd9365da-h3 driver.Hence,we add a new compatible
with panel specific config.

Although they have the same control IC, the two panels are different,
and the timing will be slightly different, so we added some variables
in struct jadard_panel_desc to control the timing

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---

Changes between V4 and V3:
-  1. Use mipi_dsi_msleep.
-  2. Adjust the ".clock" assignment format.
-  3. Adjust "compatible" positions to keep the list sorted.

V3:https://lore.kernel.org/all/20240614145510.22965-4-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V3 and V2:
-  1. Give up creating a new driver and re-add K&d kd101ne3-40ti 
-     configuration to the panel-jadard-jd9365da-h3.c driver.

V2:https://lore.kernel.org/all/20240601084528.22502-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V2 and V1:
-  1. Use the new mipi_dsi_dcs_write_seq_multi() function.
-  2. Modify Move mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode() to disable(),
-  and drop kingdisplay_panel_enter_sleep_mode().
-  3. If prepare fails, disable GPIO before regulators.
-  4. This function drm_connector_set_panel_orientation() is no longer used. Delete it.
-  5. Drop ".shutdown = kingdisplay_panel_shutdown".

---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 281 +++++++++++++++++-
 1 file changed, 279 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index a9c483a7b3fa..632bffa035ee 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -31,6 +31,15 @@ struct jadard_panel_desc {
 	enum mipi_dsi_pixel_format format;
 	const struct jadard_init_cmd *init_cmds;
 	u32 num_init_cmds;
+	bool lp11_before_reset;
+	bool reset_before_power_off_vcioo;
+	unsigned int vcioo_to_lp11_delay;
+	unsigned int lp11_to_reset_delay;
+	unsigned int exit_sleep_to_display_on_delay;
+	unsigned int display_on_delay;
+	unsigned int backlight_off_to_display_off_delay;
+	unsigned int display_off_to_enter_sleep_delay;
+	unsigned int enter_sleep_to_reset_down_delay;
 };
 
 struct jadard {
@@ -53,6 +62,7 @@ static int jadard_enable(struct drm_panel *panel)
 	struct device *dev = panel->dev;
 	struct jadard *jadard = panel_to_jadard(panel);
 	struct mipi_dsi_device *dsi = jadard->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 	int err;
 
 	msleep(120);
@@ -61,10 +71,16 @@ static int jadard_enable(struct drm_panel *panel)
 	if (err < 0)
 		DRM_DEV_ERROR(dev, "failed to exit sleep mode ret = %d\n", err);
 
+	if (jadard->desc->exit_sleep_to_display_on_delay)
+		mipi_dsi_msleep(dsi_ctx, jadard->desc->exit_sleep_to_display_on_delay);
+
 	err =  mipi_dsi_dcs_set_display_on(dsi);
 	if (err < 0)
 		DRM_DEV_ERROR(dev, "failed to set display on ret = %d\n", err);
 
+	if (jadard->desc->display_on_delay)
+		mipi_dsi_msleep(dsi_ctx, jadard->desc->display_on_delay);
+
 	return 0;
 }
 
@@ -72,16 +88,26 @@ static int jadard_disable(struct drm_panel *panel)
 {
 	struct device *dev = panel->dev;
 	struct jadard *jadard = panel_to_jadard(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 	int ret;
 
+	if (jadard->desc->backlight_off_to_display_off_delay)
+		mipi_dsi_msleep(dsi_ctx, jadard->desc->backlight_off_to_display_off_delay);
+
 	ret = mipi_dsi_dcs_set_display_off(jadard->dsi);
 	if (ret < 0)
 		DRM_DEV_ERROR(dev, "failed to set display off: %d\n", ret);
 
+	if (jadard->desc->display_off_to_enter_sleep_delay)
+		mipi_dsi_msleep(dsi_ctx, jadard->desc->display_off_to_enter_sleep_delay);
+
 	ret = mipi_dsi_dcs_enter_sleep_mode(jadard->dsi);
 	if (ret < 0)
 		DRM_DEV_ERROR(dev, "failed to enter sleep mode: %d\n", ret);
 
+	if (jadard->desc->enter_sleep_to_reset_down_delay)
+		mipi_dsi_msleep(dsi_ctx, jadard->desc->enter_sleep_to_reset_down_delay);
+
 	return 0;
 }
 
@@ -89,6 +115,7 @@ static int jadard_prepare(struct drm_panel *panel)
 {
 	struct jadard *jadard = panel_to_jadard(panel);
 	const struct jadard_panel_desc *desc = jadard->desc;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 	unsigned int i;
 	int ret;
 
@@ -100,6 +127,20 @@ static int jadard_prepare(struct drm_panel *panel)
 	if (ret)
 		return ret;
 
+	if (jadard->desc->vcioo_to_lp11_delay)
+		mipi_dsi_msleep(dsi_ctx, jadard->desc->vcioo_to_lp11_delay);
+
+	if (jadard->desc->lp11_before_reset) {
+		ret = mipi_dsi_dcs_nop(jadard->dsi);
+		if (ret)
+			return ret;
+
+		usleep_range(1000, 2000);
+	}
+
+	if (jadard->desc->lp11_to_reset_delay)
+		mipi_dsi_msleep(dsi_ctx, jadard->desc->lp11_to_reset_delay);
+
 	gpiod_set_value(jadard->reset, 1);
 	msleep(5);
 
@@ -111,8 +152,7 @@ static int jadard_prepare(struct drm_panel *panel)
 
 	for (i = 0; i < desc->num_init_cmds; i++) {
 		const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
-
-		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
+		ret = mipi_dsi_dcs_write_buffer(jadard->dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
 		if (ret < 0)
 			return ret;
 	}
@@ -127,6 +167,12 @@ static int jadard_unprepare(struct drm_panel *panel)
 	gpiod_set_value(jadard->reset, 1);
 	msleep(120);
 
+	if (jadard->desc->reset_before_power_off_vcioo) {
+		gpiod_set_value(jadard->reset, 0);
+
+		usleep_range(1000, 2000);
+	}
+
 	regulator_disable(jadard->vdd);
 	regulator_disable(jadard->vccio);
 
@@ -582,6 +628,233 @@ static const struct jadard_panel_desc cz101b4001_desc = {
 	.num_init_cmds = ARRAY_SIZE(cz101b4001_init_cmds),
 };
 
+static const struct jadard_init_cmd kingdisplay_kd101ne3_init_cmds[] = {
+	{ .data = { 0xe0, 0x00 } },
+	{ .data = { 0xe1, 0x93 } },
+	{ .data = { 0xe2, 0x65 } },
+	{ .data = { 0xe3, 0xf8 } },
+	{ .data = { 0x80, 0x03 } },
+	{ .data = { 0xe0, 0x01 } },
+	{ .data = { 0x0c, 0x74 } },
+	{ .data = { 0x17, 0x00 } },
+	{ .data = { 0x18, 0xc7 } },
+	{ .data = { 0x19, 0x01 } },
+	{ .data = { 0x1a, 0x00 } },
+	{ .data = { 0x1b, 0xc7 } },
+	{ .data = { 0x1c, 0x01 } },
+	{ .data = { 0x24, 0xfe } },
+	{ .data = { 0x37, 0x19 } },
+	{ .data = { 0x35, 0x28 } },
+	{ .data = { 0x38, 0x05 } },
+	{ .data = { 0x39, 0x08 } },
+	{ .data = { 0x3a, 0x12 } },
+	{ .data = { 0x3c, 0x7e } },
+	{ .data = { 0x3d, 0xff } },
+	{ .data = { 0x3e, 0xff } },
+	{ .data = { 0x3f, 0x7f } },
+	{ .data = { 0x40, 0x06 } },
+	{ .data = { 0x41, 0xa0 } },
+	{ .data = { 0x43, 0x1e } },
+	{ .data = { 0x44, 0x0b } },
+	{ .data = { 0x55, 0x02 } },
+	{ .data = { 0x57, 0x6a } },
+	{ .data = { 0x59, 0x0a } },
+	{ .data = { 0x5a, 0x2e } },
+	{ .data = { 0x5b, 0x1a } },
+	{ .data = { 0x5c, 0x15 } },
+	{ .data = { 0x5d, 0x7f } },
+	{ .data = { 0x5e, 0x61 } },
+	{ .data = { 0x5f, 0x50 } },
+	{ .data = { 0x60, 0x43 } },
+	{ .data = { 0x61, 0x3f } },
+	{ .data = { 0x62, 0x32 } },
+	{ .data = { 0x63, 0x35 } },
+	{ .data = { 0x64, 0x1f } },
+	{ .data = { 0x65, 0x38 } },
+	{ .data = { 0x66, 0x36 } },
+	{ .data = { 0x67, 0x36 } },
+	{ .data = { 0x68, 0x54 } },
+	{ .data = { 0x69, 0x42 } },
+	{ .data = { 0x6a, 0x48 } },
+	{ .data = { 0x6b, 0x39 } },
+	{ .data = { 0x6c, 0x34 } },
+	{ .data = { 0x6d, 0x26 } },
+	{ .data = { 0x6e, 0x14 } },
+	{ .data = { 0x6f, 0x02 } },
+	{ .data = { 0x70, 0x7f } },
+	{ .data = { 0x71, 0x61 } },
+	{ .data = { 0x72, 0x50 } },
+	{ .data = { 0x73, 0x43 } },
+	{ .data = { 0x74, 0x3f } },
+	{ .data = { 0x75, 0x32 } },
+	{ .data = { 0x76, 0x35 } },
+	{ .data = { 0x77, 0x1f } },
+	{ .data = { 0x78, 0x38 } },
+	{ .data = { 0x79, 0x36 } },
+	{ .data = { 0x7a, 0x36 } },
+	{ .data = { 0x7b, 0x54 } },
+	{ .data = { 0x7c, 0x42 } },
+	{ .data = { 0x7d, 0x48 } },
+	{ .data = { 0x7e, 0x39 } },
+	{ .data = { 0x7f, 0x34 } },
+	{ .data = { 0x80, 0x26 } },
+	{ .data = { 0x81, 0x14 } },
+	{ .data = { 0x82, 0x02 } },
+	{ .data = { 0xe0, 0x02 } },
+	{ .data = { 0x00, 0x52 } },
+	{ .data = { 0x01, 0x5f } },
+	{ .data = { 0x02, 0x5f } },
+	{ .data = { 0x03, 0x50 } },
+	{ .data = { 0x04, 0x77 } },
+	{ .data = { 0x05, 0x57 } },
+	{ .data = { 0x06, 0x5f } },
+	{ .data = { 0x07, 0x4e } },
+	{ .data = { 0x08, 0x4c } },
+	{ .data = { 0x09, 0x5f } },
+	{ .data = { 0x0a, 0x4a } },
+	{ .data = { 0x0b, 0x48 } },
+	{ .data = { 0x0c, 0x5f } },
+	{ .data = { 0x0d, 0x46 } },
+	{ .data = { 0x0e, 0x44 } },
+	{ .data = { 0x0f, 0x40 } },
+	{ .data = { 0x10, 0x5f } },
+	{ .data = { 0x11, 0x5f } },
+	{ .data = { 0x12, 0x5f } },
+	{ .data = { 0x13, 0x5f } },
+	{ .data = { 0x14, 0x5f } },
+	{ .data = { 0x15, 0x5f } },
+	{ .data = { 0x16, 0x53 } },
+	{ .data = { 0x17, 0x5f } },
+	{ .data = { 0x18, 0x5f } },
+	{ .data = { 0x19, 0x51 } },
+	{ .data = { 0x1a, 0x77 } },
+	{ .data = { 0x1b, 0x57 } },
+	{ .data = { 0x1c, 0x5f } },
+	{ .data = { 0x1d, 0x4f } },
+	{ .data = { 0x1e, 0x4d } },
+	{ .data = { 0x1f, 0x5f } },
+	{ .data = { 0x20, 0x4b } },
+	{ .data = { 0x21, 0x49 } },
+	{ .data = { 0x22, 0x5f } },
+	{ .data = { 0x23, 0x47 } },
+	{ .data = { 0x24, 0x45 } },
+	{ .data = { 0x25, 0x41 } },
+	{ .data = { 0x26, 0x5f } },
+	{ .data = { 0x27, 0x5f } },
+	{ .data = { 0x28, 0x5f } },
+	{ .data = { 0x29, 0x5f } },
+	{ .data = { 0x2a, 0x5f } },
+	{ .data = { 0x2b, 0x5f } },
+	{ .data = { 0x2c, 0x13 } },
+	{ .data = { 0x2d, 0x1f } },
+	{ .data = { 0x2e, 0x1f } },
+	{ .data = { 0x2f, 0x01 } },
+	{ .data = { 0x30, 0x17 } },
+	{ .data = { 0x31, 0x17 } },
+	{ .data = { 0x32, 0x1f } },
+	{ .data = { 0x33, 0x0d } },
+	{ .data = { 0x34, 0x0f } },
+	{ .data = { 0x35, 0x1f } },
+	{ .data = { 0x36, 0x05 } },
+	{ .data = { 0x37, 0x07 } },
+	{ .data = { 0x38, 0x1f } },
+	{ .data = { 0x39, 0x09 } },
+	{ .data = { 0x3a, 0x0b } },
+	{ .data = { 0x3b, 0x11 } },
+	{ .data = { 0x3c, 0x1f } },
+	{ .data = { 0x3d, 0x1f } },
+	{ .data = { 0x3e, 0x1f } },
+	{ .data = { 0x3f, 0x1f } },
+	{ .data = { 0x40, 0x1f } },
+	{ .data = { 0x41, 0x1f } },
+	{ .data = { 0x42, 0x12 } },
+	{ .data = { 0x43, 0x1f } },
+	{ .data = { 0x44, 0x1f } },
+	{ .data = { 0x45, 0x00 } },
+	{ .data = { 0x46, 0x17 } },
+	{ .data = { 0x47, 0x17 } },
+	{ .data = { 0x48, 0x1f } },
+	{ .data = { 0x49, 0x0c } },
+	{ .data = { 0x4a, 0x0e } },
+	{ .data = { 0x4b, 0x1f } },
+	{ .data = { 0x4c, 0x04 } },
+	{ .data = { 0x4d, 0x06 } },
+	{ .data = { 0x4e, 0x1f } },
+	{ .data = { 0x4f, 0x08 } },
+	{ .data = { 0x50, 0x0a } },
+	{ .data = { 0x51, 0x10 } },
+	{ .data = { 0x52, 0x1f } },
+	{ .data = { 0x53, 0x1f } },
+	{ .data = { 0x54, 0x1f } },
+	{ .data = { 0x55, 0x1f } },
+	{ .data = { 0x56, 0x1f } },
+	{ .data = { 0x57, 0x1f } },
+	{ .data = { 0x58, 0x40 } },
+	{ .data = { 0x5b, 0x10 } },
+	{ .data = { 0x5c, 0x06 } },
+	{ .data = { 0x5d, 0x40 } },
+	{ .data = { 0x5e, 0x00 } },
+	{ .data = { 0x5f, 0x00 } },
+	{ .data = { 0x60, 0x40 } },
+	{ .data = { 0x61, 0x03 } },
+	{ .data = { 0x62, 0x04 } },
+	{ .data = { 0x63, 0x6c } },
+	{ .data = { 0x64, 0x6c } },
+	{ .data = { 0x65, 0x75 } },
+	{ .data = { 0x66, 0x08 } },
+	{ .data = { 0x67, 0xb4 } },
+	{ .data = { 0x68, 0x08 } },
+	{ .data = { 0x69, 0x6c } },
+	{ .data = { 0x6a, 0x6c } },
+	{ .data = { 0x6b, 0x0c } },
+	{ .data = { 0x6d, 0x00 } },
+	{ .data = { 0x6e, 0x00 } },
+	{ .data = { 0x6f, 0x88 } },
+	{ .data = { 0x75, 0xbb } },
+	{ .data = { 0x76, 0x00 } },
+	{ .data = { 0x77, 0x05 } },
+	{ .data = { 0x78, 0x2a } },
+	{ .data = { 0xe0, 0x04 } },
+	{ .data = { 0x00, 0x0e } },
+	{ .data = { 0x02, 0xb3 } },
+	{ .data = { 0x09, 0x61 } },
+	{ .data = { 0x0e, 0x48 } },
+	{ .data = { 0xe0, 0x00 } },
+};
+
+static const struct jadard_panel_desc kingdisplay_kd101ne3_40ti_desc = {
+	.mode = {
+		.clock		= (800 + 24 + 24 + 24) * (1280 + 30 + 4 + 8) * 60 / 1000,
+
+		.hdisplay	= 800,
+		.hsync_start	= 800 + 24,
+		.hsync_end	= 800 + 24 + 24,
+		.htotal		= 800 + 24 + 24 + 24,
+
+		.vdisplay	= 1280,
+		.vsync_start	= 1280 + 30,
+		.vsync_end	= 1280 + 30 + 4,
+		.vtotal		= 1280 + 30 + 4 + 8,
+
+		.width_mm	= 135,
+		.height_mm	= 216,
+		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+	},
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.init_cmds = kingdisplay_kd101ne3_init_cmds,
+	.num_init_cmds = ARRAY_SIZE(kingdisplay_kd101ne3_init_cmds),
+	.lp11_before_reset = true,
+	.reset_before_power_off_vcioo = true,
+	.vcioo_to_lp11_delay = 5,
+	.lp11_to_reset_delay = 10,
+	.exit_sleep_to_display_on_delay = 120,
+	.display_on_delay = 20,
+	.backlight_off_to_display_off_delay = 100,
+	.display_off_to_enter_sleep_delay = 50,
+	.enter_sleep_to_reset_down_delay = 100,
+};
+
 static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -650,6 +923,10 @@ static const struct of_device_id jadard_of_match[] = {
 		.compatible = "chongzhou,cz101b4001",
 		.data = &cz101b4001_desc
 	},
+	{
+		.compatible = "kingdisplay,kd101ne3-40ti",
+		.data = &kingdisplay_kd101ne3_40ti_desc
+	},
 	{
 		.compatible = "radxa,display-10hd-ad001",
 		.data = &cz101b4001_desc
-- 
2.17.1


