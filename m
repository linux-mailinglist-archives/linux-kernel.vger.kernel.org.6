Return-Path: <linux-kernel+bounces-222542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2E8910376
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9658A1C22307
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084041ACE61;
	Thu, 20 Jun 2024 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="dJgh8jUO"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6A1AC228
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884405; cv=none; b=RZJntRkAr7F1E2kE0MKk6Si3PDXmbwai8+GvZyhha5kalh5RRfnHZoQGEyz9njtq16NX8ZDFgyi3Ng+MTsqFMH99HihcRoN+JULiz0tt/mviURWH1DtxRVStWsPLqtcQr6zt8rLdws6gTBH4wFTLhSH9fOdjDb9c8HQPFo2JYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884405; c=relaxed/simple;
	bh=JbjvBSoeGaOTiJHj0pNmCK5cvxVytAzO4Zwsf0Qcm0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mltqKU7bp9dBgMcjUYny+cKCLmphQ8lgZNpwZ+5LamaP1VU2+Lwf2n0AWHlq9fXMrZJ3gm6ArGms+IFshVpOe64oQmcX8555aDuIHwGLfLF0/6Er4+w5qdYbx/3GlUYjoKQFcnLhWizg6MxCKP1Apn3/0l5jZE7/zERnf0mi4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=dJgh8jUO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c7fa0c9a8cso265648a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718884400; x=1719489200; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SGxsnuQ/Ed2W6oHEgWL59ov1wcKeqfhC4//KwM5fATY=;
        b=dJgh8jUOgG61iBXy4fRlzFvd9wOUrZ9UGE2Hq5eFanWF/mjUMwsVvHEmQNqGzKiMW3
         T5CzcO+BfrvRlv7wINEnFbDxUmhwA1+TaBxXS0rgKslb0qMwFU9tZHOPt0rA4giwHNUZ
         ayf7UOmJRKKocM/3pOb2iYaC+F68oJzUcUZgmyVH9CExSs3cdwe0H9gTgNDltkqQDfcZ
         +VriW4Z9B6JvXODB5zRhzD4Pr6OpHOE0tVYAVpOnR6Pr6CijP1PzD504CCIylYZRH07j
         ZzY0Kh6EkfIPNkSFxDl7SlnsWSEG0C/E/2pr4TL7L/OBs7KePMt3m5jVcG2YwpFAu48s
         6rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884400; x=1719489200;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGxsnuQ/Ed2W6oHEgWL59ov1wcKeqfhC4//KwM5fATY=;
        b=A1mlr393CIudTgm7qvfxAXG8huEtYx5Wz5ayLQ+9akuz9c/o9qKPMUFv9/No2aEXWL
         1kqMjwjKAtxBbrFe1p3wdEASVaPRjriETRKecOW8cHkAMj5yv9Ibx3YdgIN2x1bEHVCN
         /yLYiehZVhjao2JMc3+Y7dk3glHi8swpsYw+cz7iJZdt0bu+bwag29MWe28mkt4qpL0U
         gp/s18PgFWI5t1XsNu+7yVUXAjnMQZT2G3QjPztZRZGX82VajGCMW1Cct9gNVQWBCDWZ
         eBLhRBh9HA7PiC8I1blvj4MP8Z0/FW3tNsdEQpswCYLxUBkIh8L5RkM2ZxyQbFiBk6/I
         SY+A==
X-Forwarded-Encrypted: i=1; AJvYcCVIzuXpBxRneGh1srykFhtjJMVQdb7UCB2EN/TrCqDcC1wvLsI4nHwhipCyMP2CLYVz/npcHcm6UXKh5sQpApkDUaAIyFDnfqUagiXf
X-Gm-Message-State: AOJu0YwwcCuRSHtB7XN0MQFtSpJu2kGgbnMmd6Ay2cUXQSudEpkvGsSA
	6aZuFevFUZWyv4e9/7mSTsty7wyUwLoY+pcyPUgOQJp5Zx1Q8G09P8ysJiB+34BGmD0U2D8S5Iw
	I
X-Google-Smtp-Source: AGHT+IGPaoUMZD2bE4TUQaAjM2Xa6g5NiSG8yzzsu6txP6paw9VEvEuLWcEQrpokt40rkmIuHxjR3g==
X-Received: by 2002:a17:90b:fd8:b0:2c2:fed1:769f with SMTP id 98e67ed59e1d1-2c7b5c8234cmr4978938a91.13.1718884386873;
        Thu, 20 Jun 2024 04:53:06 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e64a1da9sm1486316a91.53.2024.06.20.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:53:06 -0700 (PDT)
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
Subject: [PATCH v4 2/2] drm/panel: starry-er88577: add new panel driver
Date: Thu, 20 Jun 2024 19:52:45 +0800
Message-Id: <20240620115245.31540-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240620115245.31540-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240620115245.31540-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The bias IC of this starry-er88577 panel is placed
on the panel side, so when the panel is powered on,
there is no need to control AVDD and AVEE in the driver,
only 3.3v and reset are needed.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
Chage since V3:
-  1. Adjust the ".clock" assignment format.

v3: https://lore.kernel.org/all/20240614145609.25432-3-lvzhaoxiong@huaqin.corp-partner.google.com/

Chage since V3:
-  Separate Starry-er88577 from the panel-kingdisplay-kd101ne3 driver.
-  Use mipi_dsi_dcs_set_display_on_multi().
-  Use mipi_dsi_dcs_exit_sleep_mode_multi() and mipi_dsi_msleep().

v2: https://lore.kernel.org/all/20240601084528.22502-5-lvzhaoxiong@huaqin.corp-partner.google.com/

Chage since V2:
-  Add compatible for Starry er88577 in panel-kingdisplay-kd101ne3 drivers.

---
 drivers/gpu/drm/panel/Kconfig                |   9 +
 drivers/gpu/drm/panel/Makefile               |   1 +
 drivers/gpu/drm/panel/panel-starry-er88577.c | 343 +++++++++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-starry-er88577.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index e54f6f5604ed..a52aa2552ab8 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -781,6 +781,15 @@ config DRM_PANEL_SITRONIX_ST7789V
 	  Say Y here if you want to enable support for the Sitronix
 	  ST7789V controller for 240x320 LCD panels
 
+config DRM_PANEL_STARRY_ER88577
+	tristate "Starry er88577 panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Starry er88577 controller.
+
 config DRM_PANEL_SONY_ACX565AKM
 	tristate "Sony ACX565AKM panel"
 	depends on GPIOLIB && OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index f0203f6e02f4..ecd843a6dc6e 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_DRM_PANEL_SHARP_LS060T1SX01) += panel-sharp-ls060t1sx01.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) += panel-sitronix-st7701.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
+obj-$(CONFIG_DRM_PANEL_STARRY_ER88577) += panel-starry-er88577.o
 obj-$(CONFIG_DRM_PANEL_SYNAPTICS_R63353) += panel-synaptics-r63353.o
 obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
 obj-$(CONFIG_DRM_PANEL_SONY_TD4353_JDI) += panel-sony-td4353-jdi.o
diff --git a/drivers/gpu/drm/panel/panel-starry-er88577.c b/drivers/gpu/drm/panel/panel-starry-er88577.c
new file mode 100644
index 000000000000..e6088262ee69
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-starry-er88577.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Panels based on the ER88577 display controller.
+ * Author: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+
+#include <video/mipi_display.h>
+#include <drm/drm_probe_helper.h>
+
+struct starry_panel;
+
+struct panel_desc {
+	const struct drm_display_mode *modes;
+	unsigned int bpc;
+	unsigned long mode_flags;
+	enum mipi_dsi_pixel_format format;
+	const struct panel_init_cmd *init_cmds;
+	int (*init)(struct starry_panel *starry);
+	unsigned int lanes;
+	bool discharge_on_disable;
+	bool lp11_before_reset;
+	unsigned int power_off_delay_ms;
+};
+
+struct starry_panel {
+	struct drm_panel base;
+	struct mipi_dsi_device *dsi;
+
+	const struct panel_desc *desc;
+
+	enum drm_panel_orientation orientation;
+	struct regulator *vccio;
+	struct gpio_desc *reset;
+};
+
+static int starry_er88577_init(struct starry_panel *starry)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = starry->dsi };
+
+	/* T5:HWreset to init_code >= 120ms */
+	mipi_dsi_msleep(dsi_ctx, 120);
+
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0xab, 0xba);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0xba, 0xab);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb1, 0x10, 0x01, 0x47, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x0c, 0x14, 0x04, 0x50, 0x50, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3, 0x56, 0x53, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb4, 0x33, 0x30, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0xb0, 0x00, 0x00, 0x10, 0x00, 0x10, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x05, 0x12, 0x29, 0x49, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x7c, 0x61, 0x4f, 0x42, 0x3e, 0x2d, 0x31,
+				     0x1a, 0x33, 0x33, 0x33, 0x52, 0x40, 0x47, 0x38, 0x34, 0x26,
+				     0x0e, 0x06, 0x7c, 0x61, 0x4f, 0x42, 0x3e, 0x2d, 0x31, 0x1a,
+				     0x33, 0x33, 0x33, 0x52, 0x40, 0x47, 0x38, 0x34, 0x26, 0x0e,
+				     0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0xcc, 0x76, 0x12, 0x34, 0x44, 0x44, 0x44,
+				     0x44, 0x98, 0x04, 0x98, 0x04, 0x0f, 0x00, 0x00, 0xc1);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x54, 0x94, 0x02, 0x85, 0x9f, 0x00, 0x6f,
+				     0x00, 0x54, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x17, 0x09, 0x08, 0x89, 0x08, 0x11, 0x22,
+				     0x20, 0x44, 0xff, 0x18, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x87, 0x47, 0x05, 0x05, 0x1c, 0x1c, 0x1d,
+				     0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f, 0x0f, 0x0f, 0x0d, 0x0d,
+				     0x13, 0x13, 0x11, 0x11, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x06, 0x06, 0x04, 0x04, 0x1c, 0x1c, 0x1d,
+				     0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f, 0x0e, 0x0e, 0x0c, 0x0c,
+				     0x12, 0x12, 0x10, 0x10, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x21, 0x00, 0x31, 0x42, 0x34, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0xcb, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcd, 0x0e, 0x4b, 0x4b, 0x20, 0x19, 0x6b, 0x06,
+				     0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd2, 0xe3, 0x2b, 0x38, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x00, 0x01, 0x00, 0x0e, 0x04, 0x44, 0x08,
+				     0x10, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x80, 0x09, 0xff, 0xff, 0xff, 0xff, 0xff,
+				     0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x12, 0x03, 0x20, 0x00, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0x00);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 20);
+
+	return dsi_ctx.accum_err;
+};
+
+static inline struct starry_panel *to_starry_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct starry_panel, base);
+}
+
+static int starry_panel_disable(struct drm_panel *panel)
+{
+	struct starry_panel *starry = to_starry_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = starry->dsi };
+
+	starry->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_msleep(dsi_ctx, 100);
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(dsi_ctx, 50);
+
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(dsi_ctx, 120);
+
+	return dsi_ctx.accum_err;
+}
+
+static int starry_panel_unprepare(struct drm_panel *panel)
+{
+	struct starry_panel *starry = to_starry_panel(panel);
+	int err;
+
+	gpiod_set_value_cansleep(starry->reset, 0);
+
+	/* T15: 2ms */
+	usleep_range(1000, 2000);
+
+	err = regulator_disable(starry->vccio);
+	if (err < 0)
+		return err;
+
+	if (starry->desc->power_off_delay_ms)
+		msleep(starry->desc->power_off_delay_ms);
+
+	return 0;
+}
+
+static int starry_panel_prepare(struct drm_panel *panel)
+{
+	struct starry_panel *starry = to_starry_panel(panel);
+	int err;
+
+	gpiod_set_value(starry->reset, 0);
+
+	err = regulator_enable(starry->vccio);
+	if (err < 0)
+		return err;
+
+	/* T1:Vdd to mipi_lp >= 0ms */
+	usleep_range(5000, 6000);
+
+	if (starry->desc->lp11_before_reset) {
+		err = mipi_dsi_dcs_nop(starry->dsi);
+		if (err < 0)
+			goto poweroff;
+
+		usleep_range(1000, 2000);
+	}
+
+	/* T2: 10ms, T1 + T2 > 60ms */
+	msleep(60);
+
+	gpiod_set_value_cansleep(starry->reset, 1);
+
+	err = starry->desc->init(starry);
+	if (err < 0)
+		goto poweroff;
+
+	return 0;
+
+poweroff:
+	gpiod_set_value(starry->reset, 0);
+		/* T6: 2ms */
+	usleep_range(1000, 2000);
+	regulator_disable(starry->vccio);
+
+	return err;
+}
+
+static int starry_panel_enable(struct drm_panel *panel)
+{
+	msleep(130);
+	return 0;
+}
+
+static const struct drm_display_mode starry_er88577_default_mode = {
+	.clock = (800 + 25 + 25 + 25) * (1280 + 20 + 4 + 12) * 60 / 1000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 25,
+	.hsync_end = 800 + 25 + 25,
+	.htotal = 800 + 25 + 25 + 25,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 20,
+	.vsync_end = 1280 + 20 + 4,
+	.vtotal = 1280 + 20 + 4 + 12,
+	.width_mm = 135,
+	.height_mm = 216,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct panel_desc starry_er88577_desc = {
+	.modes = &starry_er88577_default_mode,
+	.bpc = 8,
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init = starry_er88577_init,
+	.lp11_before_reset = true,
+	.power_off_delay_ms = 1000,
+};
+
+static int starry_panel_get_modes(struct drm_panel *panel,
+			       struct drm_connector *connector)
+{
+	struct starry_panel *starry = to_starry_panel(panel);
+	const struct drm_display_mode *mode = starry->desc->modes;
+
+	return drm_connector_helper_get_modes_fixed(connector, mode);
+}
+
+static enum drm_panel_orientation starry_panel_get_orientation(struct drm_panel *panel)
+{
+	struct starry_panel *starry = to_starry_panel(panel);
+
+	return starry->orientation;
+}
+
+static const struct drm_panel_funcs starry_panel_funcs = {
+	.disable = starry_panel_disable,
+	.unprepare = starry_panel_unprepare,
+	.prepare = starry_panel_prepare,
+	.enable = starry_panel_enable,
+	.get_modes = starry_panel_get_modes,
+	.get_orientation = starry_panel_get_orientation,
+};
+
+static int starry_panel_add(struct starry_panel *starry)
+{
+	struct device *dev = &starry->dsi->dev;
+	int err;
+
+	starry->vccio = devm_regulator_get(dev, "vccio");
+	if (IS_ERR(starry->vccio))
+		return dev_err_probe(dev, PTR_ERR(starry->vccio),
+				     "Cannot get vccio\n");
+
+	starry->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(starry->reset))
+		return dev_err_probe(dev, PTR_ERR(starry->reset),
+				     "Cannot get reset GPIO\n");
+
+	drm_panel_init(&starry->base, dev, &starry_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+
+	err = of_drm_get_panel_orientation(dev->of_node, &starry->orientation);
+	if (err < 0) {
+		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
+		return err;
+	}
+
+	err = drm_panel_of_backlight(&starry->base);
+	if (err)
+		return err;
+
+	starry->base.funcs = &starry_panel_funcs;
+	starry->base.dev = &starry->dsi->dev;
+
+	drm_panel_add(&starry->base);
+
+	return 0;
+}
+
+static int starry_panel_probe(struct mipi_dsi_device *dsi)
+{
+	struct starry_panel *starry;
+	int ret;
+	const struct panel_desc *desc;
+
+	starry = devm_kzalloc(&dsi->dev, sizeof(*starry), GFP_KERNEL);
+	if (!starry)
+		return -ENOMEM;
+
+	desc = of_device_get_match_data(&dsi->dev);
+	dsi->lanes = desc->lanes;
+	dsi->format = desc->format;
+	dsi->mode_flags = desc->mode_flags;
+	starry->desc = desc;
+	starry->dsi = dsi;
+	ret = starry_panel_add(starry);
+	if (ret < 0)
+		return ret;
+
+	mipi_dsi_set_drvdata(dsi, starry);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret)
+		drm_panel_remove(&starry->base);
+
+	return ret;
+}
+
+static void starry_panel_remove(struct mipi_dsi_device *dsi)
+{
+	struct starry_panel *starry = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+
+	if (starry->base.dev)
+		drm_panel_remove(&starry->base);
+}
+
+static const struct of_device_id starry_of_match[] = {
+	{ .compatible = "starry,er88577",
+	  .data = &starry_er88577_desc
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, starry_of_match);
+
+static struct mipi_dsi_driver starry_panel_driver = {
+	.driver = {
+		.name = "panel-starry-er88577",
+		.of_match_table = starry_of_match,
+	},
+	.probe = starry_panel_probe,
+	.remove = starry_panel_remove,
+};
+module_mipi_dsi_driver(starry_panel_driver);
+
+MODULE_AUTHOR("Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>");
+MODULE_DESCRIPTION("starry er88577 800x1280 video mode panel driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


