Return-Path: <linux-kernel+bounces-243153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88D92928E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFEF282CCB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8589C6F068;
	Sat,  6 Jul 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coEQ7epF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3F6CDC0;
	Sat,  6 Jul 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720261470; cv=none; b=nxvW+1Ph6+QeD3dyU2/3296a3oNMQdGh8Ie27P1y5dEFn58+j7T2aB+oENrUza/p5KB4teoivf84vNtVNzs5Y17OD27SVZlkW8SXRp+OaDTB9D7dYAesql5CVqfo3bYAgmUvzaklezHEtVNl6ISmk2sxGAhO00BvIg03zBBF6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720261470; c=relaxed/simple;
	bh=jAZKCd4wt5HTq1Z6t2dxzQZUpQFFNraRNR1HBFa9Qkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncaAwQkQlRnrGl/s6srIvTCd4e9H6WKnRSbUkicJW0j8EEDCOffVQZzLCLCBsq0IC8TiIfnZAPpM2bbc9FhoVQDxTFMEZ62UeBe53V32QDsySi6lnTrPXs+aplMa04koUs1xLLLBCwd0YFETNcc6gRBC/6Pm+jEfPZtCXyP4jqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coEQ7epF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa244db0b2so17497725ad.3;
        Sat, 06 Jul 2024 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720261468; x=1720866268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9StNyDVPENkogHm64stpcTfuGvnBMbgIW5F8HqFcpo=;
        b=coEQ7epF0qFALUi3WzO6aVD+zZHLmBoHAtEGbJnloltSVME7oA6hZvbZGmGSyLCpN7
         mDO9L7GWayJVU3cGgUFr4coJH/9BuGJPPZbfbj0p+X9/WV5VCQ+lmmK8nRawxf1NeCm+
         cEL4os989RhQKB9IhWOzP8tdq6Q72Ph8LPwpPjyxHgXLkUk43KOoCrU2lKzDukKZT7pK
         dcnnpDGc2qHQW1ucEuQdJl6V4qB7fqUhly37poFCpLwqbnOQLZwHNlWcfSPBF//Llkbu
         C2qiHna69WgkTn+nzHbWdIAr6tXmKJ2VO+NXDWNzJ1YANmdlnaQnzJ+SCUJVfNHmyZSF
         1sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720261468; x=1720866268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9StNyDVPENkogHm64stpcTfuGvnBMbgIW5F8HqFcpo=;
        b=f/iWXbKH85PTFXH3rlNgplaiWWs1mknyjSPylny8bdt1Y4Fz3rriiTPHxsCJsI4mVB
         2QGdR33N4ZYGbJo0Mc63TXKTnnNoarfEMA3OmHtmxpnmvPcD54oWCjOQYDmL+IVPZLuD
         8AqjV1wtRTHJP/hiqQ3/c3/FDqzBdCbC9SwY9EWlvRXD4YJ0nhh9KNdyRPfJdrOVPJsJ
         RqlEKXemBOBRmgBsQUwQvmsl/OTSFqUdSEEA7C7Sctgn06O4sJomiYz8yNhe45EcoOsj
         M2lS+n+z7Cq2Yyf2RuBJbKSGyrX+dkQUnb+2k3TvOIK12OmSkb7dMil+XRHBGzp7WVDg
         NWCw==
X-Forwarded-Encrypted: i=1; AJvYcCXokzUrII5/bO/wmKYzyUJBKK2jfwdxsLzkUaZiu4VIGVtWzQhsWntV0af6SKO1VYH9LKWRNLqo3m+nzjJq+OoSwEuVoX9Bv/Astw==
X-Gm-Message-State: AOJu0YzOLG97D5XWpOwFIxBT2NASm7rSWwEhRv+GV/odYD1wZDRn+8oz
	QMH2PXg1hFAlpHnaOAZa4yCuvQCw/7I3PRLRm37wiH9R+cKsw7gpAH9WnDxsdd0=
X-Google-Smtp-Source: AGHT+IFhOqQRf+hln7Sdoe6lWRdReT7lTXNhbyEB2QZas/lvUfHDiWJaueAuySapmXzAwwGFb3fBbw==
X-Received: by 2002:a17:902:d4d2:b0:1fb:3179:db2d with SMTP id d9443c01a7336-1fb33ee5c13mr52243615ad.46.1720261468289;
        Sat, 06 Jul 2024 03:24:28 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb67e04f64sm9126625ad.214.2024.07.06.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 03:24:27 -0700 (PDT)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 4/5] drm/panel: st7701: Add support for SPI for configuration
Date: Sat,  6 Jul 2024 19:23:35 +0900
Message-ID: <20240706102338.99231-5-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240706102338.99231-1-kikuchan98@gmail.com>
References: <20240706102338.99231-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ST7701 supports not only MIPI DSI, but also SPI as an interface
for configuration. To support a panel connected via SPI with an RGB
parallel interface, add support for SPI using MIPI DBI helpers.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig                 |   3 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 123 +++++++++++++++---
 2 files changed, 110 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 2ae0eb0638f..3dd52869520 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -755,7 +755,8 @@ config DRM_PANEL_SHARP_LS060T1SX01
 config DRM_PANEL_SITRONIX_ST7701
 	tristate "Sitronix ST7701 panel driver"
 	depends on OF
-	depends on DRM_MIPI_DSI
+	depends on SPI || DRM_MIPI_DSI
+	select DRM_MIPI_DBI if SPI
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to enable support for the Sitronix
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index a0644f7a4c8..9e83a760a8a 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -4,6 +4,7 @@
  * Author: Jagan Teki <jagan@amarulasolutions.com>
  */
 
+#include <drm/drm_mipi_dbi.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
@@ -14,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
 
 #include <video/mipi_display.h>
 
@@ -130,12 +132,16 @@ struct st7701_panel_desc {
 struct st7701 {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
+	struct mipi_dbi dbi;
 	const struct st7701_panel_desc *desc;
 
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *reset;
 	unsigned int sleep_delay;
 	enum drm_panel_orientation orientation;
+
+	int (*write_command)(struct st7701 *st7701, u8 cmd, const u8 *seq,
+			     size_t len);
 };
 
 static inline struct st7701 *panel_to_st7701(struct drm_panel *panel)
@@ -143,16 +149,22 @@ static inline struct st7701 *panel_to_st7701(struct drm_panel *panel)
 	return container_of(panel, struct st7701, panel);
 }
 
-static inline int st7701_dsi_write(struct st7701 *st7701, const void *seq,
-				   size_t len)
+static int st7701_dsi_write(struct st7701 *st7701, u8 cmd, const u8 *seq,
+			    size_t len)
 {
-	return mipi_dsi_dcs_write_buffer(st7701->dsi, seq, len);
+	return mipi_dsi_dcs_write(st7701->dsi, cmd, seq, len);
 }
 
-#define ST7701_WRITE(st7701, seq...)				\
-	{							\
-		const u8 d[] = { seq };				\
-		st7701_dsi_write(st7701, d, ARRAY_SIZE(d));	\
+static int st7701_dbi_write(struct st7701 *st7701, u8 cmd, const u8 *seq,
+			    size_t len)
+{
+	return mipi_dbi_command_stackbuf(&st7701->dbi, cmd, seq, len);
+}
+
+#define ST7701_WRITE(st7701, cmd, seq...)				\
+	{								\
+		const u8 d[] = { seq };					\
+		st7701->write_command(st7701, cmd, d, ARRAY_SIZE(d));	\
 	}
 
 static u8 st7701_vgls_map(struct st7701 *st7701)
@@ -211,10 +223,10 @@ static void st7701_init_sequence(struct st7701 *st7701)
 	/* Command2, BK0 */
 	st7701_switch_cmd_bkx(st7701, true, 0);
 
-	mipi_dsi_dcs_write(st7701->dsi, ST7701_CMD2_BK0_PVGAMCTRL,
-			   desc->pv_gamma, ARRAY_SIZE(desc->pv_gamma));
-	mipi_dsi_dcs_write(st7701->dsi, ST7701_CMD2_BK0_NVGAMCTRL,
-			   desc->nv_gamma, ARRAY_SIZE(desc->nv_gamma));
+	st7701->write_command(st7701, ST7701_CMD2_BK0_PVGAMCTRL, desc->pv_gamma,
+			      ARRAY_SIZE(desc->pv_gamma));
+	st7701->write_command(st7701, ST7701_CMD2_BK0_NVGAMCTRL, desc->nv_gamma,
+			      ARRAY_SIZE(desc->nv_gamma));
 	/*
 	 * Vertical line count configuration:
 	 * Line[6:0]: select number of vertical lines of the TFT matrix in
@@ -1051,6 +1063,10 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
 
 	st7701 = dev_get_drvdata(&dsi->dev);
 	st7701->dsi = dsi;
+	st7701->write_command = st7701_dsi_write;
+
+	if (!st7701->desc->lanes)
+		return dev_err_probe(&dsi->dev, -EINVAL, "This panel is not for MIPI DSI\n");
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
@@ -1064,30 +1080,107 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
+static int st7701_spi_probe(struct spi_device *spi)
+{
+	struct st7701 *st7701;
+	struct gpio_desc *dc;
+	int err;
+
+	err = st7701_probe(&spi->dev, DRM_MODE_CONNECTOR_DPI);
+	if (err)
+		return err;
+
+	st7701 = dev_get_drvdata(&spi->dev);
+	st7701->write_command = st7701_dbi_write;
+
+	dc = devm_gpiod_get_optional(&spi->dev, "dc", GPIOD_OUT_LOW);
+	if (IS_ERR(dc))
+		return dev_err_probe(&spi->dev, PTR_ERR(dc), "Failed to get GPIO for D/CX\n");
+
+	err = mipi_dbi_spi_init(spi, &st7701->dbi, dc);
+	if (err)
+		return dev_err_probe(&spi->dev, err, "Failed to init MIPI DBI\n");
+	st7701->dbi.read_commands = NULL;
+
+	return 0;
+}
+
 static void st7701_dsi_remove(struct mipi_dsi_device *dsi)
 {
 	mipi_dsi_detach(dsi);
 }
 
-static const struct of_device_id st7701_of_match[] = {
+static const struct of_device_id st7701_dsi_of_match[] = {
 	{ .compatible = "anbernic,rg-arc-panel", .data = &rg_arc_desc },
 	{ .compatible = "densitron,dmt028vghmcmi-1a", .data = &dmt028vghmcmi_1a_desc },
 	{ .compatible = "elida,kd50t048a", .data = &kd50t048a_desc },
 	{ .compatible = "techstar,ts8550b", .data = &ts8550b_desc },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, st7701_of_match);
+MODULE_DEVICE_TABLE(of, st7701_dsi_of_match);
+
+static const struct of_device_id st7701_spi_of_match[] = {
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, st7701_spi_of_match);
+
+static const struct spi_device_id st7701_spi_ids[] = {
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, st7701_spi_ids);
 
 static struct mipi_dsi_driver st7701_dsi_driver = {
 	.probe		= st7701_dsi_probe,
 	.remove		= st7701_dsi_remove,
 	.driver = {
 		.name		= "st7701",
-		.of_match_table	= st7701_of_match,
+		.of_match_table	= st7701_dsi_of_match,
 	},
 };
-module_mipi_dsi_driver(st7701_dsi_driver);
+
+static struct spi_driver st7701_spi_driver = {
+	.probe		= st7701_spi_probe,
+	.id_table	= st7701_spi_ids,
+	.driver = {
+		.name		= "st7701",
+		.of_match_table	= st7701_spi_of_match,
+	},
+};
+
+static int __init st7701_driver_init(void)
+{
+	int err;
+
+	if (IS_ENABLED(CONFIG_SPI)) {
+		err = spi_register_driver(&st7701_spi_driver);
+		if (err)
+			return err;
+	}
+
+	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI)) {
+		err = mipi_dsi_driver_register(&st7701_dsi_driver);
+		if (err) {
+			if (IS_ENABLED(CONFIG_SPI))
+				spi_unregister_driver(&st7701_spi_driver);
+			return err;
+		}
+	}
+
+	return 0;
+}
+module_init(st7701_driver_init);
+
+static void __exit st7701_driver_exit(void)
+{
+	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI))
+		mipi_dsi_driver_unregister(&st7701_dsi_driver);
+
+	if (IS_ENABLED(CONFIG_SPI))
+		spi_unregister_driver(&st7701_spi_driver);
+}
+module_exit(st7701_driver_exit);
 
 MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_AUTHOR("Hironori KIKUCHI <kikuchan98@gmail.com>");
 MODULE_DESCRIPTION("Sitronix ST7701 LCD Panel Driver");
 MODULE_LICENSE("GPL");
-- 
2.45.2


