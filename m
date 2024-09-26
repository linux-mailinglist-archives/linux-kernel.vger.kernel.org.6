Return-Path: <linux-kernel+bounces-340401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF279872D3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81DF1C24984
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37618CC01;
	Thu, 26 Sep 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doXGwA84"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D760E18F2CF;
	Thu, 26 Sep 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350194; cv=none; b=ndFDsNSQpOU54Zqv+hoKXRLQx+A2aVrxJqpZm8pG8qKrdEBJiHHOgJHCz9Hw8bq37iuC7LxMMVw0G2aYSQ6a24nEzXq1N3Ci1fnIFdDJ7a2JsNZrByWd5MBaqf7g4bnFN9IiwPBMg44HddKNJSQGO3RIxMJNLFlnwl8+8Ml/68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350194; c=relaxed/simple;
	bh=NKJ+9tiTkhYJhL0c38JZ/fbWZEwzyvYxkThZPcM3XPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaBj8G8kKBEEYOi/Kfq2ant34dh2RC1tr2Rx00QP2QrwHBwKXtkDI91deuGaECkmXlsdz5wP8dldnk74aF1i/ilN2FIIpkluFDkgJEJMXY6l8WlE0sn8gkXAbx7QPbRsVyOZwOKh8Llii70dKVfVB/JG1D9h6ZIoTH6yxyY2xrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doXGwA84; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53654e2ed93so1129306e87.0;
        Thu, 26 Sep 2024 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727350190; x=1727954990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7Tb9X7URT3xH2JxQI1WUPZsD7nlW1CkLJEsU2thW2Q=;
        b=doXGwA84ojceZnnxgqG6G84EZDNy1TcteqA2W91qoAkF6jladYtNoMEwzInU7VB/1l
         M7qtvNsBkm84NOzXo0zsfNOZzgqjoZZbIDaqEXK9DYJBDDPJ5lHm4bpl6rG2XXtpEWjM
         sv9U2VBNN9OK0C/CW5ujWMaFFy1gXBj2mkqt4hbxrfsGEPYj5MMOHkSze3KxrTZEAFS3
         4pPsNY541Ti0/n22IlLn21IzjhO/tF6UwSP0F2xhKQTbOjH8TX3uGJV9TmwCSZNhwpW5
         H+mfwGH6juJlAQZsF3GkIutrehtOmcF9L/Q62c/wk1TlPnT7AGAlVp182s+vpIBQnZlR
         +s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727350190; x=1727954990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7Tb9X7URT3xH2JxQI1WUPZsD7nlW1CkLJEsU2thW2Q=;
        b=OYpSMsXlfijNJTPZ5YONgx4UD6/xKZ5jCE9saZCDpmtNoYau9ZaSzd0Nd06EsDFmrh
         SJ+clB7Y6cfhzK2SVzvBG5Nh4c+vg0MTcxafXqcT4/RMgBl2f2agSu10c2F8jK566bqR
         BxHU/1ZDJtpzwIE3LAkIs73UJix4cpOSo+ttXt0yfKqKIIHRoowHKF09YxKA7KqkoSPK
         v/GG5T5ZFxnd5vZKC8P4El76qHMKkdpjS4miytX178ZEkpzdbXY+otkU6Hl1HSr/dxiw
         zTiNE7VJDyOwk6EVJRWB5hb353edNf/Cz2LwiIhlgofn1wkj1EkiyQ9zzcaecvKKg9Mk
         g1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCU0AWQ/tAK5yia1Ib1aQsI1hkz6hSfYybntjJRUVrXKSZ54jTE+GxDQBzpgu2M4CUrLuw0MUj29lHIj838e@vger.kernel.org, AJvYcCWmZBZUxfgTs0dqpqAoefHbShfuICi82GIKLII9f2glN9kPoqW3c0ITBH9jVYPEgzZr04MgSv05Kv6k@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrbw8zLJuO/b3O3Lq/GN/FmwCtpGf43PE7hc6ExD40f8rbatUs
	Ku0IRE2OCAPdM+gKQ5viNUPqXXxhY88dAc5v2zgNX467jgbTRjvA
X-Google-Smtp-Source: AGHT+IEeF8Z65BaFaNqrwPbaj6wAjKxoDwFdJkIU7aT+etf+lBTals50qHU4TBSD1UtXUKPTL88+PA==
X-Received: by 2002:a05:6512:1151:b0:533:711:35be with SMTP id 2adb3069b0e04-53877530881mr3633595e87.26.1727350189453;
        Thu, 26 Sep 2024 04:29:49 -0700 (PDT)
Received: from [127.0.1.1] (mm-20-1-84-93.mgts.dynamic.pppoe.byfly.by. [93.84.1.20])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a85ee5fbsm786495e87.74.2024.09.26.04.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 04:29:49 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 26 Sep 2024 14:29:27 +0300
Subject: [PATCH v5 2/2] drm/panel: Add support for S6E3HA8 panel driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-starqltechn_integration_upstream-v5-2-1cb0e43e623f@gmail.com>
References: <20240926-starqltechn_integration_upstream-v5-0-1cb0e43e623f@gmail.com>
In-Reply-To: <20240926-starqltechn_integration_upstream-v5-0-1cb0e43e623f@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727350181; l=14465;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=NKJ+9tiTkhYJhL0c38JZ/fbWZEwzyvYxkThZPcM3XPw=;
 b=iDagYmJVa65P1bbsU1MTIi2NSXBFVCSRs1ZgkUlA5OjqUFGhfBIEXLGaMR9MuIg/RZLqMvXEF
 KZLdpXu+LLIDa2OEdMKYK7aaEZkDza1rGL4Ww6EeTESJJZu6cGFIg+R
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add support for MIPI-DSI based S6E3HA8 AMOLED panel
driver. This panel has 1440x2960 resolution, 5.8-inch physical
size, and can be found in starqltechn device.
Brightness regulation is not yet supported.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes for v5:
- return ctx.accum_err instead of 0 where possible
- switch mipi_dsi_picture_parameter_set to _multi
- replace msleep with mipi_dsi_msleep

Changes in v4:
- inline power related functions
- rework driver using new mipi_dsi_dcs_write_seq_multi macro
- use drm_connector_helper_get_modes_fixed for modes
- remove excessive compression setting
---
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/panel/Kconfig                 |   7 ++
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 344 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 353 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc876e3653e7..3c4fa75c8e95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7392,6 +7392,7 @@ DRM DRIVER FOR SAMSUNG S6E3HA8 PANELS
 M:	Dzmitry Sankouski <dsankouski@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
+F:	drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
 
 DRM DRIVER FOR SITRONIX ST7586 PANELS
 M:	David Lechner <david@lechnology.com>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index d3a9a9fafe4e..65fb3a466e39 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -689,6 +689,13 @@ config DRM_PANEL_SAMSUNG_S6E3HA2
 	depends on BACKLIGHT_CLASS_DEVICE
 	select VIDEOMODE_HELPERS
 
+config DRM_PANEL_SAMSUNG_S6E3HA8
+	tristate "Samsung S6E3HA8 DSI video mode panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	select VIDEOMODE_HELPERS
+
 config DRM_PANEL_SAMSUNG_S6E63J0X03
 	tristate "Samsung S6E63J0X03 DSI command mode panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 987a08702410..8ee28f5a2213 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D27A1) += panel-samsung-s6d27a1.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D7AA0) += panel-samsung-s6d7aa0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3FA7) += panel-samsung-s6e3fa7.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) += panel-samsung-s6e3ha2.o
+obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA8) += panel-samsung-s6e3ha8.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) += panel-samsung-s6e63j0x03.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0) += panel-samsung-s6e63m0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI) += panel-samsung-s6e63m0-spi.o
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
new file mode 100644
index 000000000000..e20cf16a65a5
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
+//	Copyright (c) 2013, The Linux Foundation. All rights reserved.
+// Copyright (c) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/display/drm_dsc.h>
+#include <drm/display/drm_dsc_helper.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_panel.h>
+
+struct s6e3ha8 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct drm_dsc_config dsc;
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[3];
+};
+
+static inline
+struct s6e3ha8 *to_s6e3ha8_amb577px01_wqhd(struct drm_panel *panel)
+{
+	return container_of(panel, struct s6e3ha8, panel);
+}
+
+#define s6e3ha8_test_key_on_lvl2(ctx) \
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0x5a, 0x5a)
+#define s6e3ha8_test_key_off_lvl2(ctx) \
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0xa5, 0xa5)
+#define s6e3ha8_test_key_on_lvl3(ctx) \
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0x5a, 0x5a)
+#define s6e3ha8_test_key_off_lvl3(ctx) \
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0xa5, 0xa5)
+#define s6e3ha8_test_key_on_lvl1(ctx) \
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9f, 0xa5, 0xa5)
+#define s6e3ha8_test_key_off_lvl1(ctx) \
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9f, 0x5a, 0x5a)
+#define s6e3ha8_afc_off(ctx) \
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe2, 0x00, 0x00)
+
+static void s6e3ha8_amb577px01_wqhd_reset(struct s6e3ha8 *priv)
+{
+	gpiod_set_value_cansleep(priv->reset_gpio, 1);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(priv->reset_gpio, 0);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(priv->reset_gpio, 1);
+	usleep_range(5000, 6000);
+}
+
+static int s6e3ha8_amb577px01_wqhd_on(struct s6e3ha8 *priv)
+{
+	struct mipi_dsi_device *dsi = priv->dsi;
+	struct device *dev = &dsi->dev;
+	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
+	int ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	s6e3ha8_test_key_on_lvl1(&ctx);
+	s6e3ha8_test_key_on_lvl2(&ctx);
+
+	ret = mipi_dsi_compression_mode(dsi, true);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set compression mode: %d\n", ret);
+		return ret;
+	}
+
+	s6e3ha8_test_key_off_lvl2(&ctx);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
+	usleep_range(5000, 6000);
+
+	s6e3ha8_test_key_on_lvl2(&ctx);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf2, 0x13);
+	s6e3ha8_test_key_off_lvl2(&ctx);
+
+	usleep_range(10000, 11000);
+
+	s6e3ha8_test_key_on_lvl2(&ctx);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf2, 0x13);
+	s6e3ha8_test_key_off_lvl2(&ctx);
+
+	/* OMOK setting 1 (Initial setting) - Scaler Latch Setting Guide */
+	s6e3ha8_test_key_on_lvl2(&ctx);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x07);
+	/* latch setting 1 : Scaler on/off & address setting & PPS setting -> Image update latch */
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf2, 0x3c, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x0b);
+	/* latch setting 2 : Ratio change mode -> Image update latch */
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf2, 0x30);
+	/* OMOK setting 2 - Seamless setting guide : WQHD */
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2a, 0x00, 0x00, 0x05, 0x9f); /* CASET */
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2b, 0x00, 0x00, 0x0b, 0x8f); /* PASET */
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x01); /* scaler setup : scaler off */
+	s6e3ha8_test_key_off_lvl2(&ctx);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x35, 0x00); /* TE Vsync ON */
+	s6e3ha8_test_key_on_lvl2(&ctx);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xed, 0x4c); /* ERR_FG */
+	s6e3ha8_test_key_off_lvl2(&ctx);
+	s6e3ha8_test_key_on_lvl3(&ctx);
+	/* FFC Setting 897.6Mbps */
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc5, 0x0d, 0x10, 0xb4, 0x3e, 0x01);
+	s6e3ha8_test_key_off_lvl3(&ctx);
+	s6e3ha8_test_key_on_lvl2(&ctx);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb9,
+				   0x00, 0xb0, 0x81, 0x09, 0x00, 0x00, 0x00,
+				   0x11, 0x03); /* TSP HSYNC Setting */
+	s6e3ha8_test_key_off_lvl2(&ctx);
+	s6e3ha8_test_key_on_lvl2(&ctx);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf6, 0x43);
+	s6e3ha8_test_key_off_lvl2(&ctx);
+	s6e3ha8_test_key_on_lvl2(&ctx);
+	/* Brightness condition set */
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xca,
+				   0x07, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80,
+				   0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				   0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				   0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
+				   0x80, 0x80, 0x80, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0x00, 0x0c); /* AID Set : 0% */
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb5,
+				   0x19, 0xdc, 0x16, 0x01, 0x34, 0x67, 0x9a,
+				   0xcd, 0x01, 0x22, 0x33, 0x44, 0x00, 0x00,
+				   0x05, 0x55, 0xcc, 0x0c, 0x01, 0x11, 0x11,
+				   0x10); /* MPS/ELVSS Setting */
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf4, 0xeb, 0x28); /* VINT */
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf7, 0x03); /* Gamma, LTPS(AID) update */
+	s6e3ha8_test_key_off_lvl2(&ctx);
+	s6e3ha8_test_key_off_lvl1(&ctx);
+
+	return ctx.accum_err;
+}
+
+static int s6e3ha8_enable(struct drm_panel *panel)
+{
+	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
+	struct mipi_dsi_device *dsi = priv->dsi;
+	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
+
+	s6e3ha8_test_key_on_lvl1(&ctx);
+	ctx.accum_err = mipi_dsi_dcs_set_display_on(dsi);
+	s6e3ha8_test_key_off_lvl1(&ctx);
+
+	return ctx.accum_err;
+}
+
+static int s6e3ha8_disable(struct drm_panel *panel)
+{
+	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
+	struct mipi_dsi_device *dsi = priv->dsi;
+	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
+
+	s6e3ha8_test_key_on_lvl1(&ctx);
+	ctx.accum_err = mipi_dsi_dcs_set_display_off(dsi);
+	s6e3ha8_test_key_off_lvl1(&ctx);
+	mipi_dsi_msleep(&ctx, 20);
+
+	s6e3ha8_test_key_on_lvl2(&ctx);
+	s6e3ha8_afc_off(&ctx);
+	s6e3ha8_test_key_off_lvl2(&ctx);
+
+	mipi_dsi_msleep(&ctx, 160);
+
+	return ctx.accum_err;
+}
+
+static int s6e3ha8_amb577px01_wqhd_prepare(struct drm_panel *panel)
+{
+	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
+	struct mipi_dsi_device *dsi = priv->dsi;
+	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
+	struct drm_dsc_picture_parameter_set pps;
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	if (ret < 0)
+		return ret;
+	mipi_dsi_msleep(&ctx, 120);
+	s6e3ha8_amb577px01_wqhd_reset(priv);
+
+	ret = s6e3ha8_amb577px01_wqhd_on(priv);
+	if (ret < 0) {
+		gpiod_set_value_cansleep(priv->reset_gpio, 1);
+		goto err;
+	}
+
+	drm_dsc_pps_payload_pack(&pps, &priv->dsc);
+
+	s6e3ha8_test_key_on_lvl1(&ctx);
+	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
+	s6e3ha8_test_key_off_lvl1(&ctx);
+
+	mipi_dsi_msleep(&ctx, 28);
+
+	return ctx.accum_err;
+err:
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+	return ret;
+}
+
+static int s6e3ha8_amb577px01_wqhd_unprepare(struct drm_panel *panel)
+{
+	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
+
+	return regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
+}
+
+static const struct drm_display_mode s6e3ha8_amb577px01_wqhd_mode = {
+	.clock = (1440 + 116 + 44 + 120) * (2960 + 120 + 80 + 124) * 60 / 1000,
+	.hdisplay = 1440,
+	.hsync_start = 1440 + 116,
+	.hsync_end = 1440 + 116 + 44,
+	.htotal = 1440 + 116 + 44 + 120,
+	.vdisplay = 2960,
+	.vsync_start = 2960 + 120,
+	.vsync_end = 2960 + 120 + 80,
+	.vtotal = 2960 + 120 + 80 + 124,
+	.width_mm = 64,
+	.height_mm = 132,
+};
+
+static int s6e3ha8_amb577px01_wqhd_get_modes(struct drm_panel *panel,
+					     struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &s6e3ha8_amb577px01_wqhd_mode);
+}
+
+static const struct drm_panel_funcs s6e3ha8_amb577px01_wqhd_panel_funcs = {
+	.prepare = s6e3ha8_amb577px01_wqhd_prepare,
+	.unprepare = s6e3ha8_amb577px01_wqhd_unprepare,
+	.get_modes = s6e3ha8_amb577px01_wqhd_get_modes,
+	.enable = s6e3ha8_enable,
+	.disable = s6e3ha8_disable,
+};
+
+static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct s6e3ha8 *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->supplies[0].supply = "vdd3";
+	priv->supplies[1].supply = "vci";
+	priv->supplies[2].supply = "vddr";
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
+				      priv->supplies);
+	if (ret < 0) {
+		dev_err(dev, "failed to get regulators: %d\n", ret);
+		return ret;
+	}
+
+	priv->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	priv->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, priv);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
+		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
+		MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
+
+	drm_panel_init(&priv->panel, dev, &s6e3ha8_amb577px01_wqhd_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+	priv->panel.prepare_prev_first = true;
+
+	drm_panel_add(&priv->panel);
+
+	/* This panel only supports DSC; unconditionally enable it */
+	dsi->dsc = &priv->dsc;
+
+	priv->dsc.dsc_version_major = 1;
+	priv->dsc.dsc_version_minor = 1;
+
+	priv->dsc.slice_height = 40;
+	priv->dsc.slice_width = 720;
+	WARN_ON(1440 % priv->dsc.slice_width);
+	priv->dsc.slice_count = 1440 / priv->dsc.slice_width;
+	priv->dsc.bits_per_component = 8;
+	priv->dsc.bits_per_pixel = 8 << 4; /* 4 fractional bits */
+	priv->dsc.block_pred_enable = true;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
+		drm_panel_remove(&priv->panel);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void s6e3ha8_amb577px01_wqhd_remove(struct mipi_dsi_device *dsi)
+{
+	struct s6e3ha8 *priv = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&priv->panel);
+}
+
+static const struct of_device_id s6e3ha8_amb577px01_wqhd_of_match[] = {
+	{ .compatible = "samsung,s6e3ha8" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, s6e3ha8_amb577px01_wqhd_of_match);
+
+static struct mipi_dsi_driver s6e3ha8_amb577px01_wqhd_driver = {
+	.probe = s6e3ha8_amb577px01_wqhd_probe,
+	.remove = s6e3ha8_amb577px01_wqhd_remove,
+	.driver = {
+		.name = "panel-s6e3ha8",
+		.of_match_table = s6e3ha8_amb577px01_wqhd_of_match,
+	},
+};
+module_mipi_dsi_driver(s6e3ha8_amb577px01_wqhd_driver);
+
+MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
+MODULE_DESCRIPTION("DRM driver for S6E3HA8 panel");
+MODULE_LICENSE("GPL");

-- 
2.39.2


