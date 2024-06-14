Return-Path: <linux-kernel+bounces-215059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3241C908DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1123C1C232B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453513C8E2;
	Fri, 14 Jun 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="ZF3iHL8y"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACC3C482
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376940; cv=none; b=a6efYRYfm92lW33/0vaP+T+dXqBehW5a+7fOTaXkJndodE0p8R6yIbFRkvErRHijMq6a/FJqdtMA6YFbuYm8OXvz4t/g1sjqGGQJs5JNQosJmElvf5y3FwEtsLJ7UT3gB5dVUZnsNB6ggR0kxM4Gcd7s2WnaBPSpe/hgJMqNB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376940; c=relaxed/simple;
	bh=PM7TI088Reb1frPo2xBiGmgBrODxUrXl49noC7e1dSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fPAHH6tlAC9YAfAtuk/YADdnzM5oobujP2zxF1bfq7j857Pn0AU1UGjteFCOuzejE/yCudMcBn2LgZIG48GQyH9rzHalAPD9aBqt+bJzKo+jq34qWqmZw0QP5zpXnMwM0lCw6mkuF3/yAyVtKuITepw+vO1vDjNl4bvJfGnjhWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=ZF3iHL8y; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so1797421a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718376936; x=1718981736; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xrZzAom6O9YIqT+M/rnWnDzzIpj+2dsBCK2KUligyUo=;
        b=ZF3iHL8y0kETGg9rGPTMiXOKNvfObvDNz8ShBAMzomjeUxpxK2/4nwgWAnHCRQoggQ
         BFv6Zf2F/464mTyR0a5ycXpqffIv/Sc+pIUTO/9C1mV/edQ9qSIzMITZo0/Ew4RkrRvS
         JZ3gmic6gtLsK/OliOZJ1SCzQknIVpqkg6fIEp3BjdpkUL9iQIEYTKwSVNDtita5gX5p
         /ISOYkfaRB2sqZIPGhdVs/HYeq9UbaNEKq+NUId8mGLaSZ6SSwbEunUI+NsJ3pmd8h4o
         SOLtpkU2K+yiZkp2Ndw4wlvuQjfhu3DbpR2dJKhF5sqp35miEYWAzxJ33o7W6X1wdKWI
         Bz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718376936; x=1718981736;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrZzAom6O9YIqT+M/rnWnDzzIpj+2dsBCK2KUligyUo=;
        b=vzHdCJItaRsKtKowryG2JbhfZvaGlAhDVpukoenANRd2oDYCWutmnY9PcuD2eEZSA0
         xkN3yPJJ75atPx88o+A7BZaot/FooHwnIhhepXMK/L6gdidgYMTqH0mfAZ3I2ntKGwO1
         ae5k2HJ7rp9Yk6PPAxvC8Pnp6P/N2r+FstUt/D3j2o3Zb7QP8aqGK2l4JB7iaXqnBLGg
         lcnwHfxXLuEU5+5xrEJOV6TCZYDiKoX9KyWZNa3J0HZ2jMon8ZFys22wp1U5vYo9CcGp
         QiGAIjImkFqhP2P8+RXJ2b3OWXig6QhDZzNExiHUNS1y4pvnka0ectxcc0UuiyAfVK1Z
         wMPg==
X-Forwarded-Encrypted: i=1; AJvYcCW7QkVOu3XG66/NXgPhuAQ60lofRY9KXv+WSamcQHYbk6fgj1CxxeYtC3TgNhtLCmiAtZWmNNMVaFUymdsI7oOnUsedapO+lujM41MS
X-Gm-Message-State: AOJu0YwgTC5Y2anYtfjoRKbYPwsmrtxdciodq+0cAUmgsRuGRA4lWx+X
	JCf1KUSjLZ/4Ojxp43fbCL5p3uQtZNqXZZ03SvNnciXBOhBKSpG6an7BkogFvTM=
X-Google-Smtp-Source: AGHT+IG1yphRHAVyJxsijf2qYKEClqTbaZiF+rBJLzU96/6pLrLN9jdXlHt6FV06+yP9/gl1TaPicA==
X-Received: by 2002:a17:903:32c9:b0:1f7:6ed:737a with SMTP id d9443c01a7336-1f862b261d8mr32892905ad.66.1718376936116;
        Fri, 14 Jun 2024 07:55:36 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e739b7sm32914495ad.93.2024.06.14.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:55:35 -0700 (PDT)
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
Subject: [PATCH v3 3/4] drm/panel: jd9365da: Support for kd101ne3-40ti MIPI-DSI panel.
Date: Fri, 14 Jun 2024 22:55:09 +0800
Message-Id: <20240614145510.22965-4-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614145510.22965-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240614145510.22965-1-lvzhaoxiong@huaqin.corp-partner.google.com>
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

Chage since V3:
-  1. Give up creating a new driver and re-add K&d kd101ne3-40ti 
-     configuration to the panel-jadard-jd9365da-h3.c driver.

V2:https://lore.kernel.org/all/20240601084528.22502-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Chage since V2:

-  1. Use the new mipi_dsi_dcs_write_seq_multi() function.
-  2. Modify Move mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode() to disable(),
-  and drop kingdisplay_panel_enter_sleep_mode().
-  3. If prepare fails, disable GPIO before regulators.
-  4. This function drm_connector_set_panel_orientation() is no longer used. Delete it.
-  5. Drop ".shutdown = kingdisplay_panel_shutdown".

---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 284 ++++++++++++++++++
 1 file changed, 284 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index b39f01d7002e..f6e130567707 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -27,6 +27,15 @@ struct jadard_panel_desc {
 	enum mipi_dsi_pixel_format format;
 	int (*init)(struct jadard *jadard);
 	u32 num_init_cmds;
+	bool lp11_before_reset;
+	bool power_off_vcioo_before_reset;
+	unsigned int vcioo_to_lp11_delay;
+	unsigned int lp11_to_reset_delay;
+	unsigned int exit_sleep_to_display_on_delay;
+	unsigned int display_on_delay;
+	unsigned int backlight_off_to_display_off_delay;
+	unsigned int display_off_to_enter_sleep_delay;
+	unsigned int enter_sleep_to_reset_down_delay;
 };
 
 struct jadard {
@@ -57,10 +66,18 @@ static int jadard_enable(struct drm_panel *panel)
 	if (err < 0)
 		DRM_DEV_ERROR(dev, "failed to exit sleep mode ret = %d\n", err);
 
+	/* tSLPOUT >= 120ms */
+	if (jadard->desc->exit_sleep_to_display_on_delay)
+		msleep(jadard->desc->exit_sleep_to_display_on_delay);
+
 	err =  mipi_dsi_dcs_set_display_on(dsi);
 	if (err < 0)
 		DRM_DEV_ERROR(dev, "failed to set display on ret = %d\n", err);
 
+	/* tDISON >= 20ms */
+	if (jadard->desc->display_on_delay)
+		msleep(jadard->desc->display_on_delay);
+
 	return 0;
 }
 
@@ -70,14 +87,26 @@ static int jadard_disable(struct drm_panel *panel)
 	struct jadard *jadard = panel_to_jadard(panel);
 	int ret;
 
+	/* tBLOFF:Backlight_to_0x28h >= 100ms */
+	if (jadard->desc->backlight_off_to_display_off_delay)
+		msleep(jadard->desc->backlight_off_to_display_off_delay);
+
 	ret = mipi_dsi_dcs_set_display_off(jadard->dsi);
 	if (ret < 0)
 		DRM_DEV_ERROR(dev, "failed to set display off: %d\n", ret);
 
+	/* tDISOFF >= 50ms */
+	if (jadard->desc->display_off_to_enter_sleep_delay)
+		msleep(jadard->desc->display_off_to_enter_sleep_delay);
+
 	ret = mipi_dsi_dcs_enter_sleep_mode(jadard->dsi);
 	if (ret < 0)
 		DRM_DEV_ERROR(dev, "failed to enter sleep mode: %d\n", ret);
 
+	/* tSLPIN >= 100ms */
+	if (jadard->desc->enter_sleep_to_reset_down_delay)
+		msleep(jadard->desc->enter_sleep_to_reset_down_delay);
+
 	return 0;
 }
 
@@ -94,6 +123,21 @@ static int jadard_prepare(struct drm_panel *panel)
 	if (ret)
 		return ret;
 
+	/* tMIPI_ON >= 0ms */
+	if (jadard->desc->vcioo_to_lp11_delay)
+		msleep(jadard->desc->vcioo_to_lp11_delay);
+
+	if (jadard->desc->lp11_before_reset) {
+		ret = mipi_dsi_dcs_nop(jadard->dsi);
+		if (ret < 0)
+			goto poweroff;
+
+		usleep_range(1000, 2000);
+	}
+	/* tRPWIRES >= 5ms */
+	if (jadard->desc->lp11_to_reset_delay)
+		msleep(jadard->desc->lp11_to_reset_delay);
+
 	gpiod_set_value(jadard->reset, 1);
 	msleep(5);
 
@@ -125,6 +169,12 @@ static int jadard_unprepare(struct drm_panel *panel)
 	gpiod_set_value(jadard->reset, 1);
 	msleep(120);
 
+	if (jadard->desc->power_off_vcioo_before_reset) {
+		gpiod_set_value(jadard->reset, 0);
+
+		usleep_range(1000, 2000);
+	}
+
 	regulator_disable(jadard->vdd);
 	regulator_disable(jadard->vccio);
 
@@ -586,7 +636,237 @@ static const struct jadard_panel_desc cz101b4001_desc = {
 	.lanes = 4,
 	.format = MIPI_DSI_FMT_RGB888,
 	.init = cz101b4001_init_cmds,
+};
+
+static int kingdisplay_kd101ne3_init_cmds(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xc7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xc7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x7e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x61);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x39);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x61);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x32);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x35);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x36);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x54);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x42);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x39);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x26);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x52);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x4c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x53);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x51);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x4d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x13);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x75);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0xb4);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x6c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xbb);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x61);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+
+	return 0;
+};
+
+static const struct jadard_panel_desc kingdisplay_kd101ne3_40ti_desc = {
+	.mode = {
+		.clock		= 70595,
+
+		.hdisplay	= 800,
+		.hsync_start	= 800 + 30,
+		.hsync_end	= 800 + 30 + 30,
+		.htotal		= 800 + 30 + 30 + 30,
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
+	.init = kingdisplay_kd101ne3_init_cmds,
+	.lp11_before_reset = true,
+	.power_off_vcioo_before_reset = true,
+	.vcioo_to_lp11_delay = 5,
+	.lp11_to_reset_delay = 10,
+	.exit_sleep_to_display_on_delay = 120,
+	.display_on_delay = 20,
+	.backlight_off_to_display_off_delay = 100,
+	.display_off_to_enter_sleep_delay = 50,
+	.enter_sleep_to_reset_down_delay = 100,
 };
 
 static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
@@ -665,6 +945,10 @@ static const struct of_device_id jadard_of_match[] = {
 		.compatible = "radxa,display-8hd-ad002",
 		.data = &radxa_display_8hd_ad002_desc
 	},
+	{
+		.compatible = "kingdisplay,kd101ne3-40ti",
+		.data = &kingdisplay_kd101ne3_40ti_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, jadard_of_match);
-- 
2.17.1


