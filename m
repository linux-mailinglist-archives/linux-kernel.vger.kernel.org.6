Return-Path: <linux-kernel+bounces-229064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512A3916A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A291F22A32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D517B504;
	Tue, 25 Jun 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WNJcE+Hf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC116DC19
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325583; cv=none; b=FYs9zi2ECx+w0x9ZQCl+Mz3F0LdXTJvI0AvUus96UCtrEZBH0i9m3oUOy9PvzA3MwLABNXyRyS/bIu1mLGxwBtVAHk3VJFd+1w+DRzYx4QXMjcnCIcjk3/Jk1k7CNlY44uBmmuBd9zryf9LzdV1WuGqYzQwUwUcU9cz8m2AKPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325583; c=relaxed/simple;
	bh=BCynszyAqM5z6ODoWd0A/6BG/6mB7F0a7CXeHGB8vpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgHsjdOgfjFflaCQhGShKQB7CTNQEfPNd5u/Sj2L1JizLSzunJIjv8IkklclEi4DKC9gnp+F0RiKwXfpQcEayMpEqUu4h037RNAb6Ws2oq9hVay17xHcbPodRTeXrsS2esWd2ncDZ/FVG7Q6hpp4FO9Zz/cTooq+oGiU85yUSBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WNJcE+Hf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4217990f997so41705075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719325579; x=1719930379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUnlDK2msKQOjLK3wL+RmE8TdQfuWckSjRfYqDGL9KQ=;
        b=WNJcE+HfNpOskAFexZQoTo8UB6Yjaaml+iOIletCQeXZ9FAJnMEvHyAr81c4z4Gj/H
         +WPjjWGNcxDLiuKykcZ5uXex+xtlCB3ap79O+PUrRN2Oi/7lyjC/Ymu7tuG48LnD0Q3n
         i5iceBuQvb/Ufn+mStRNYgZhzsf0wP5ymfC1MCNm/Mojbgp3wRXoaaQZm56vD1pnknAk
         HjFVzUSTicCjULf0Lt0g/vf21JVGjrfm9i/JyGKWMkf5R9j4HJSomCTnEak6L5KWdqZR
         7QrX586iKB5vbKDfay5zpAumlrh7qltcUrhPyvsXPAhqfLTcSXx4+vm6puW5kfZPTDy/
         XpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325579; x=1719930379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUnlDK2msKQOjLK3wL+RmE8TdQfuWckSjRfYqDGL9KQ=;
        b=gdZom5K12ptRzvkDLC2sTz3sS3tSc9SVnZK0tD+2Nhhnz7PPRz5j49xeiFkf62dR0j
         Nuch21LnfKcuLCMZoni/Eb2s7Y3rXi7AQOt6ux/6UH1jMZC7Z0DmNRdPTXhZowyv/fj1
         0NCqQSQ9Ge4EKSqxPeJgs124nm7ozoCcCFcJWV1PIb3TamDrWT/4Yc9wgHF9Gql/kQ5l
         yaTeYQak+CoOKVsOM2tUyWdSiBRmIwHFkP2ImRnHKvulNEFtC+unNcfAOeU5EAd+LzUw
         GZ+I+5f0bq497h+2IERFqdCLVDjmk8Z7ZP5YQWAoNELHm8QXdyBZecqqkVCRiXsKy+95
         HwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3xxNgQno0DLghfbbDZVbWAhs/37YLjOhvVYmnmyFbGhnpKYw0u2jthAC1RdhOPjKW9DGBeZ1mj5sUq19cLM64ZsS545H9GUBHcnjh
X-Gm-Message-State: AOJu0Yze+0RuTaGq/rTh+8aGMr6PJGKUisXfkAWW/1pbmqq67OHp+eOB
	sQChFcPvMRXrAWHxssoKULGqDIjeRqYzuETHxSQW+1Tvk1g6vupOMMVAgNXWqJs=
X-Google-Smtp-Source: AGHT+IGmMdR0rJvIyxVksyUH6PxxYdEPX/b3rlGUBjOv9iXFZymmefXVwDYeoY2rJN5UdeoRRGa2Og==
X-Received: by 2002:a05:600c:434b:b0:424:abd7:2321 with SMTP id 5b1f17b1804b1-424abd72412mr1124715e9.12.1719325579403;
        Tue, 25 Jun 2024 07:26:19 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:b30c:4c5e:f49e:ab33])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d211881sm213770685e9.46.2024.06.25.07.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:26:19 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/panel: add lincoln lcd197 support
Date: Tue, 25 Jun 2024 16:25:50 +0200
Message-ID: <20240625142552.1000988-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625142552.1000988-1-jbrunet@baylibre.com>
References: <20240625142552.1000988-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add support for the Lincoln LCD197 1080x1920 DSI panel.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/panel/Kconfig                |  11 +
 drivers/gpu/drm/panel/Makefile               |   1 +
 drivers/gpu/drm/panel/panel-lincoln-lcd197.c | 333 +++++++++++++++++++
 3 files changed, 345 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-lincoln-lcd197.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 2ae0eb0638f3..a4e68981e740 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -319,6 +319,17 @@ config DRM_PANEL_LEADTEK_LTK500HD1829
 	  24 bit RGB per pixel. It provides a MIPI DSI interface to
 	  the host and has a built-in LED backlight.
 
+config DRM_PANEL_LINCOLN_LCD197
+	tristate "Lincoln lcd197 panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for lincoln lcd197
+	  TFT-LCD modules. The panel has a 1080x1920 resolution and uses
+	  24 bit RGB per pixel. It provides a MIPI DSI interface to
+	  the host.
+
 config DRM_PANEL_LG_LB035Q02
 	tristate "LG LB035Q024573 RGB panel"
 	depends on GPIOLIB && OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index f0203f6e02f4..06141ec2e065 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_DRM_PANEL_KHADAS_TS050) += panel-khadas-ts050.o
 obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) += panel-kingdisplay-kd097d04.o
 obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) += panel-leadtek-ltk050h3146w.o
 obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) += panel-leadtek-ltk500hd1829.o
+obj-$(CONFIG_DRM_PANEL_LINCOLN_LCD197) += panel-lincoln-lcd197.o
 obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) += panel-lg-lb035q02.o
 obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
 obj-$(CONFIG_DRM_PANEL_LG_SW43408) += panel-lg-sw43408.o
diff --git a/drivers/gpu/drm/panel/panel-lincoln-lcd197.c b/drivers/gpu/drm/panel/panel-lincoln-lcd197.c
new file mode 100644
index 000000000000..977790797d70
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-lincoln-lcd197.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 BayLibre, SAS
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#include <drm/drm_crtc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+struct lincoln_lcd197_panel {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct regulator *supply;
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *reset_gpio;
+
+	bool prepared;
+	bool enabled;
+};
+
+static inline
+struct lincoln_lcd197_panel *to_lincoln_lcd197_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct lincoln_lcd197_panel, panel);
+}
+
+static int lincoln_lcd197_panel_prepare(struct drm_panel *panel)
+{
+	struct lincoln_lcd197_panel *lcd = to_lincoln_lcd197_panel(panel);
+	int err;
+	u8 display_id[3];
+
+	if (lcd->prepared)
+		return 0;
+
+	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
+	err = regulator_enable(lcd->supply);
+	if (err < 0)
+		return err;
+
+	gpiod_set_value_cansleep(lcd->enable_gpio, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(lcd->reset_gpio, 1);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(lcd->reset_gpio, 0);
+	msleep(50);
+
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB9, 0xFF, 0x83, 0x99);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xD2, 0x55);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB1, 0x02, 0x04, 0x70, 0x90, 0x01,
+			       0x32, 0x33, 0x11, 0x11, 0x4D, 0x57, 0x56, 0x73,
+			       0x02, 0x02);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB2, 0x00, 0x80, 0x80, 0xAE, 0x0A,
+			       0x0E, 0x75, 0x11, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB4, 0x00, 0xFF, 0x04, 0xA4, 0x02,
+			       0xA0, 0x00, 0x00, 0x10, 0x00, 0x00, 0x02, 0x00,
+			       0x24, 0x02, 0x04, 0x0A, 0x21, 0x03, 0x00, 0x00,
+			       0x08, 0xA6, 0x88, 0x04, 0xA4, 0x02, 0xA0, 0x00,
+			       0x00, 0x10, 0x00, 0x00, 0x02, 0x00, 0x24, 0x02,
+			       0x04, 0x0A, 0x00, 0x00, 0x08, 0xA6, 0x00, 0x08,
+			       0x11);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xD3, 0x00, 0x00, 0x00, 0X00, 0x00,
+			       0x00, 0x18, 0x18, 0x32, 0x10, 0x09, 0x00, 0x09,
+			       0x32, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			       0x00, 0x00, 0x11, 0x00, 0x02, 0x02, 0x03, 0x00,
+			       0x00, 0x00, 0x0A, 0x40);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xD5, 0x18, 0x18, 0x18, 0x18, 0x21,
+			       0x20, 0x18, 0x18, 0x19, 0x19, 0x19, 0x19, 0x18,
+			       0x18, 0x18, 0x18, 0x03, 0x02, 0x01, 0x00, 0x2F,
+			       0x2F, 0x30, 0x30, 0x31, 0x31, 0x18, 0x18, 0x18,
+			       0x18, 0x18, 0x18);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xD6, 0x18, 0x18, 0x18, 0x18, 0x20,
+			       0x21, 0x19, 0x19, 0x18, 0x18, 0x19, 0x19, 0x18,
+			       0x18, 0x18, 0x18, 0x00, 0x01, 0x02, 0x03, 0x2F,
+			       0x2F, 0x30, 0x30, 0x31, 0x31, 0x18, 0x18, 0x18,
+			       0x18, 0x18, 0x18);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xBD, 0x01);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xD8, 0x0A, 0xBE, 0xFA, 0xA0, 0x0A,
+			       0xBE, 0xFA, 0xA0);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xD8, 0x0F, 0xFF, 0xFF, 0xE0, 0x0F,
+			       0xFF, 0xFF, 0xE0);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xBD, 0x02);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xD8, 0x0F, 0xFF, 0xFF, 0xE0, 0x0F,
+			       0xFF, 0xFF, 0xE0);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xE0, 0x01, 0x11, 0x1C, 0x17, 0x39,
+			       0x43, 0x54, 0x51, 0x5A, 0x64, 0x6C, 0x74, 0x7A,
+			       0x83, 0x8D, 0x92, 0x99, 0xA4, 0xA9, 0xB4, 0xAA,
+			       0xBA, 0xBE, 0x63, 0x5E, 0x69, 0x73, 0x01, 0x11,
+			       0x1C, 0x17, 0x39, 0x43, 0x54, 0x51, 0x5A, 0x64,
+			       0x6C, 0x74, 0x7A, 0x83, 0x8D, 0x92, 0x99, 0xA4,
+			       0xA7, 0xB2, 0xA9, 0xBA, 0xBE, 0x63, 0x5E, 0x69,
+			       0x73);
+	usleep_range(200, 300);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB6, 0x92, 0x92);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xCC, 0x00);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xBF, 0x40, 0x41, 0x50, 0x49);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xC6, 0xFF, 0xF9);
+	mipi_dsi_dcs_write_seq(lcd->dsi, 0xC0, 0x25, 0x5A);
+	mipi_dsi_dcs_write_seq(lcd->dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x02);
+
+	err = mipi_dsi_dcs_exit_sleep_mode(lcd->dsi);
+	if (err < 0) {
+		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
+		goto poweroff;
+	}
+	msleep(120);
+
+	err = mipi_dsi_dcs_read(lcd->dsi, MIPI_DCS_GET_DISPLAY_ID, display_id, 3);
+	if (err < 0) {
+		dev_err(panel->dev, "Failed to read display id: %d\n", err);
+	} else {
+		dev_dbg(panel->dev, "Display id: 0x%02x-0x%02x-0x%02x\n",
+			display_id[0], display_id[1], display_id[2]);
+	}
+
+	lcd->prepared = true;
+
+	return 0;
+
+poweroff:
+	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
+	gpiod_set_value_cansleep(lcd->reset_gpio, 1);
+	regulator_disable(lcd->supply);
+
+	return err;
+}
+
+static int lincoln_lcd197_panel_unprepare(struct drm_panel *panel)
+{
+	struct lincoln_lcd197_panel *lcd = to_lincoln_lcd197_panel(panel);
+	int err;
+
+	if (!lcd->prepared)
+		return 0;
+
+	lcd->prepared = false;
+
+	err = mipi_dsi_dcs_enter_sleep_mode(lcd->dsi);
+	if (err < 0)
+		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
+
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
+	gpiod_set_value_cansleep(lcd->reset_gpio, 1);
+	regulator_disable(lcd->supply);
+
+	return err;
+}
+
+static int lincoln_lcd197_panel_enable(struct drm_panel *panel)
+{
+	struct lincoln_lcd197_panel *lcd = to_lincoln_lcd197_panel(panel);
+	int err;
+
+	if (lcd->enabled)
+		return 0;
+
+	err = mipi_dsi_dcs_set_display_on(lcd->dsi);
+	if (err < 0) {
+		dev_err(panel->dev, "failed to set display on: %d\n", err);
+		return err;
+	}
+
+	msleep(20);
+	lcd->enabled = true;
+
+	return 0;
+}
+
+static int lincoln_lcd197_panel_disable(struct drm_panel *panel)
+{
+	struct lincoln_lcd197_panel *lcd = to_lincoln_lcd197_panel(panel);
+	int err;
+
+	if (!lcd->enabled)
+		return 0;
+
+	err = mipi_dsi_dcs_set_display_off(lcd->dsi);
+	if (err < 0)
+		dev_err(panel->dev, "failed to set display off: %d\n", err);
+
+
+	msleep(50);
+	lcd->enabled = false;
+
+	return 0;
+}
+
+static const struct drm_display_mode default_mode = {
+	.clock = 154002,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 20,
+	.hsync_end = 1080 + 20 + 6,
+	.htotal = 1080 + 204,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 4,
+	.vsync_end = 1920 + 4 + 4,
+	.vtotal = 1920 + 79,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static int lincoln_lcd197_panel_get_modes(struct drm_panel *panel,
+					  struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &default_mode);
+	if (!mode) {
+		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
+			default_mode.hdisplay, default_mode.vdisplay,
+			drm_mode_vrefresh(&default_mode));
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+	connector->display_info.width_mm = 79;
+	connector->display_info.height_mm = 125;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs lincoln_lcd197_panel_funcs = {
+	.prepare = lincoln_lcd197_panel_prepare,
+	.unprepare = lincoln_lcd197_panel_unprepare,
+	.enable = lincoln_lcd197_panel_enable,
+	.disable = lincoln_lcd197_panel_disable,
+	.get_modes = lincoln_lcd197_panel_get_modes,
+};
+
+static int lincoln_lcd197_panel_probe(struct mipi_dsi_device *dsi)
+{
+	struct lincoln_lcd197_panel *lcd;
+	struct device *dev = &dsi->dev;
+	int err;
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = (MIPI_DSI_MODE_VIDEO |
+			   MIPI_DSI_MODE_VIDEO_BURST |
+			   MIPI_DSI_MODE_LPM);
+
+	lcd = devm_kzalloc(&dsi->dev, sizeof(*lcd), GFP_KERNEL);
+	if (!lcd)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, lcd);
+	lcd->dsi = dsi;
+
+	lcd->supply = devm_regulator_get(dev, "power");
+	if (IS_ERR(lcd->supply))
+		return dev_err_probe(dev, PTR_ERR(lcd->supply),
+				     "failed to get power supply");
+
+	lcd->enable_gpio = devm_gpiod_get(dev, "enable",
+					  GPIOD_OUT_HIGH);
+	if (IS_ERR(lcd->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(lcd->enable_gpio),
+				     "failed to get enable gpio");
+
+	lcd->reset_gpio = devm_gpiod_get(dev, "reset",
+					  GPIOD_OUT_HIGH);
+	if (IS_ERR(lcd->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(lcd->reset_gpio),
+				     "failed to get reset gpio");
+
+	drm_panel_init(&lcd->panel, dev,
+		       &lincoln_lcd197_panel_funcs, DRM_MODE_CONNECTOR_DSI);
+
+	err = drm_panel_of_backlight(&lcd->panel);
+	if (err)
+		return err;
+
+	drm_panel_add(&lcd->panel);
+	err = mipi_dsi_attach(dsi);
+	if (err)
+		drm_panel_remove(&lcd->panel);
+
+	return err;
+}
+
+static void lincoln_lcd197_panel_shutdown(struct mipi_dsi_device *dsi)
+{
+	struct lincoln_lcd197_panel *lcd = mipi_dsi_get_drvdata(dsi);
+
+	drm_panel_disable(&lcd->panel);
+	drm_panel_unprepare(&lcd->panel);
+}
+
+static void lincoln_lcd197_panel_remove(struct mipi_dsi_device *dsi)
+{
+	struct lincoln_lcd197_panel *lcd = mipi_dsi_get_drvdata(dsi);
+	int err;
+
+	err = mipi_dsi_detach(dsi);
+	if (err < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
+
+	lincoln_lcd197_panel_shutdown(dsi);
+	drm_panel_remove(&lcd->panel);
+}
+
+static const struct of_device_id lincoln_lcd197_of_match[] = {
+	{ .compatible = "lincoln,lcd197", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, lincoln_lcd197_of_match);
+
+static struct mipi_dsi_driver lincoln_lcd197_panel_driver = {
+	.driver = {
+		.name = "panel-licoln-lcd197",
+		.of_match_table = lincoln_lcd197_of_match,
+	},
+	.probe = lincoln_lcd197_panel_probe,
+	.remove = lincoln_lcd197_panel_remove,
+	.shutdown = lincoln_lcd197_panel_shutdown,
+};
+module_mipi_dsi_driver(lincoln_lcd197_panel_driver);
+
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_DESCRIPTION("Lincoln LCD197 panel driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


