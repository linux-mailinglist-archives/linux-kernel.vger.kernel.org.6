Return-Path: <linux-kernel+bounces-218846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D9290C6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3BA1F22F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D531A2FC5;
	Tue, 18 Jun 2024 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg31f79g"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F51A2FB1;
	Tue, 18 Jun 2024 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698555; cv=none; b=O/d2IxZgobZrzQ+61dsN7KkULqwSr7R2fd2BfArflg8XC5RU8wcCChtYC4qDgLYutPTunsGXlxeM3MBzXfp54dH3EOLFohhhSve+Bxi56KockG73U9b1aeBUt5UQq826TX2TmMIvjYn06YNAIBp1PQGSz46d2LULLpG7CtooXqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698555; c=relaxed/simple;
	bh=uQUNGAcIwO5KI3YsUNcKvF1CZ6oHdR4sOHYGX85Zw7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvDp0BUK9fP5Vv3ni2WjjD4+Kpn/uHoNJ7BYrD3K7Do3FfJkopmwc175mXVogXq/23z1WcyBLUVvQQKytvaIw9L8N6MUKGPKnFeDKhEO0EI6ymoUvS6CSVn5jwEA1/USP83q2RWDEHrlwKYEDyYghLJxxue0c6Ie4N35JGh42aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lg31f79g; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f862f7c7edso33272505ad.3;
        Tue, 18 Jun 2024 01:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698553; x=1719303353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QD1GfKw9SNR3aCxw2m1Eb7xqb4LCyjQ9URCxOhH2S+4=;
        b=Lg31f79gnsP3Z3HVEFLYbeQSOs1duK+zm3a8Fw7+cpHRIRJVSUsi4tcMGJFZYUC4fu
         05Vk8VjvdWBqVCoJBz5HpouSPY1kpEO2D3xD6Zpm8wUHNyR8WS+soDy+7Glu0QGNuC+N
         ulKhUAmGZgaQRMzT10Fn33LKNK+BM204fUr6Cq1t6NFGzOg2i76z+tIT0bCKdFEQ1OdW
         inIGtSYo5yyEU17JHiVz/9h0eS1aY2qrzX+fAlYNe+5yI1vkmKN+CN9Xekt6D4v0doE9
         cA8vSuSap7vnG2bbveqr7HnK9MJnjsohZOZP9PBJUh+Z9RBxL3z6491e4SZtCh5dVBiz
         S14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698553; x=1719303353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QD1GfKw9SNR3aCxw2m1Eb7xqb4LCyjQ9URCxOhH2S+4=;
        b=oNkD4uXESnEZ2T5vCATR7LxvoaH+Wh2F0tFd9rIjEsHxiYgsaTHOQxO3/YPfkdf4zZ
         JNV5WB2oBxWqrJtn2UZ1+VaULyHCyYfs2K++nHlAv0XD45yu5DKYn5ih2F59g36z0SXG
         i1CarAR77bVclO9kJxN7OGb7vGsiC2qU6hGb5Cas/DNSC1hyitNHvk1CMmrg9MKW9BXV
         gD2ky2K9Nr9+SPXU7r6ZthxszkLr1/mbBs62MMG5pPJkLCBLg7VVKu8xkuB1q1nEN7M9
         gw10LbLU91XYTiQ6Lj2VvYeJbrG2qUpSL6ZCuAEZoKZUMDz0h0naz3WxX7++2VsNjfzF
         dfBA==
X-Forwarded-Encrypted: i=1; AJvYcCUeR+8mGYEcHpm1+uGJSp7uSLkRpE9ED7bO6YJjALD/FLnElT0vagRoRWgQK8/8vy0ciidUG7JQU2AFdoITjaQIdXUPKEx6VnZiLA==
X-Gm-Message-State: AOJu0YwavzzeJ9pKVP7LKN0Gq8WBGFfOfZBtU/FhgqviHg2O+x34wOnP
	/md7H/WrGGnUOvwi5SPG2zw4mEva7jzdwvGXBUKzzVRYQW99bL6VsaWxG6wB6BQ=
X-Google-Smtp-Source: AGHT+IG9TC/KD0e6xD+FYGIcjwjENiHg6TgflND45V342WU/3qkJFD75wF7dTxbpmYomMIt7s9egqA==
X-Received: by 2002:a17:902:ce87:b0:1f7:3d0d:4cd with SMTP id d9443c01a7336-1f8625cf213mr128231965ad.24.1718698553108;
        Tue, 18 Jun 2024 01:15:53 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1a1ebsm91883575ad.238.2024.06.18.01.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:15:52 -0700 (PDT)
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
Subject: [PATCH v1 2/3] drm/panel: st7701: Add support for SPI for configuration
Date: Tue, 18 Jun 2024 17:15:13 +0900
Message-ID: <20240618081515.1215552-3-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618081515.1215552-1-kikuchan98@gmail.com>
References: <20240618081515.1215552-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ST7701 supports not only MIPI DSI, but also SPI as an interface
for configuration. To support a panel connected via RGB parallel
interface, add support for SPI using MIPI DBI helpers.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig                 |   2 +
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 211 ++++++++++++++----
 2 files changed, 172 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 2ae0eb0638f..1831544400d 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -755,7 +755,9 @@ config DRM_PANEL_SHARP_LS060T1SX01
 config DRM_PANEL_SITRONIX_ST7701
 	tristate "Sitronix ST7701 panel driver"
 	depends on OF
+	depends on SPI
 	depends on DRM_MIPI_DSI
+	select DRM_MIPI_DBI
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to enable support for the Sitronix
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 421eb4592b6..3c4a66f2fc7 100644
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
 
-#define ST7701_DSI(st7701, seq...)				\
-	{							\
-		const u8 d[] = { seq };				\
-		st7701_dsi_write(st7701, d, ARRAY_SIZE(d));	\
+static int st7701_dbi_write(struct st7701 *st7701, u8 cmd, const u8 *seq,
+			    size_t len)
+{
+	return mipi_dbi_command_stackbuf(&st7701->dbi, cmd, seq, len);
+}
+
+#define ST7701_DSI(st7701, cmd, seq...)					\
+	{								\
+		const u8 d[] = { seq };					\
+		st7701->write_command(st7701, cmd, d, ARRAY_SIZE(d));	\
 	}
 
 static u8 st7701_vgls_map(struct st7701 *st7701)
@@ -211,10 +223,10 @@ static void st7701_init_sequence(struct st7701 *st7701)
 	/* Command2, BK0 */
 	st7701_switch_cmd_bkx(st7701, true, 0);
 
-	mipi_dsi_dcs_write(st7701->dsi, DSI_CMD2_BK0_PVGAMCTRL,
-			   desc->pv_gamma, ARRAY_SIZE(desc->pv_gamma));
-	mipi_dsi_dcs_write(st7701->dsi, DSI_CMD2_BK0_NVGAMCTRL,
-			   desc->nv_gamma, ARRAY_SIZE(desc->nv_gamma));
+	st7701->write_command(st7701, DSI_CMD2_BK0_PVGAMCTRL, desc->pv_gamma,
+			      ARRAY_SIZE(desc->pv_gamma));
+	st7701->write_command(st7701, DSI_CMD2_BK0_NVGAMCTRL, desc->nv_gamma,
+			      ARRAY_SIZE(desc->nv_gamma));
 	/*
 	 * Vertical line count configuration:
 	 * Line[6:0]: select number of vertical lines of the TFT matrix in
@@ -974,42 +986,47 @@ static const struct st7701_panel_desc rg_arc_desc = {
 	.gip_sequence = rg_arc_gip_sequence,
 };
 
-static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
+static void st7701_cleanup(void *data)
+{
+	struct st7701 *st7701 = (struct st7701 *)data;
+
+	drm_panel_remove(&st7701->panel);
+}
+
+static int st7701_probe(struct device *dev, int connector_type)
 {
 	const struct st7701_panel_desc *desc;
 	struct st7701 *st7701;
 	int ret;
 
-	st7701 = devm_kzalloc(&dsi->dev, sizeof(*st7701), GFP_KERNEL);
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -ENODEV;
+
+	st7701 = devm_kzalloc(dev, sizeof(*st7701), GFP_KERNEL);
 	if (!st7701)
 		return -ENOMEM;
 
-	desc = of_device_get_match_data(&dsi->dev);
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
-	dsi->format = desc->format;
-	dsi->lanes = desc->lanes;
-
+	st7701->desc = desc;
 	st7701->supplies[0].supply = "VCC";
 	st7701->supplies[1].supply = "IOVCC";
 
-	ret = devm_regulator_bulk_get(&dsi->dev, ARRAY_SIZE(st7701->supplies),
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st7701->supplies),
 				      st7701->supplies);
 	if (ret < 0)
 		return ret;
 
-	st7701->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	st7701->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(st7701->reset)) {
-		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
+		dev_err(dev, "Couldn't get our reset GPIO\n");
 		return PTR_ERR(st7701->reset);
 	}
 
-	ret = of_drm_get_panel_orientation(dsi->dev.of_node, &st7701->orientation);
+	ret = of_drm_get_panel_orientation(dev->of_node, &st7701->orientation);
 	if (ret < 0)
-		return dev_err_probe(&dsi->dev, ret, "Failed to get orientation\n");
+		return dev_err_probe(dev, ret, "Failed to get orientation\n");
 
-	drm_panel_init(&st7701->panel, &dsi->dev, &st7701_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
+	drm_panel_init(&st7701->panel, dev, &st7701_funcs, connector_type);
 
 	/**
 	 * Once sleep out has been issued, ST7701 IC required to wait 120ms
@@ -1026,21 +1043,77 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
+	dev_set_drvdata(dev, st7701);
+
 	drm_panel_add(&st7701->panel);
 
-	mipi_dsi_set_drvdata(dsi, st7701);
-	st7701->dsi = dsi;
-	st7701->desc = desc;
-
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_add_action_or_reset(dev, st7701_cleanup, st7701);
 	if (ret)
-		goto err_attach;
+		return ret;
 
 	return 0;
+}
 
-err_attach:
-	drm_panel_remove(&st7701->panel);
-	return ret;
+static void st7701_remove(struct st7701 *st7701)
+{
+	st7701_cleanup(st7701);
+}
+
+static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct st7701 *st7701;
+	int err;
+
+	err = st7701_probe(&dsi->dev, DRM_MODE_CONNECTOR_DSI);
+	if (err)
+		return err;
+
+	st7701 = dev_get_drvdata(&dsi->dev);
+	st7701->dsi = dsi;
+	st7701->write_command = st7701_dsi_write;
+
+	if (!st7701->desc->lanes)
+		return dev_err_probe(&dsi->dev, err, "This panel is not for MIPI DSI\n");
+
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;
+	dsi->format = st7701->desc->format;
+	dsi->lanes = st7701->desc->lanes;
+
+	mipi_dsi_set_drvdata(dsi, st7701);
+
+	err = mipi_dsi_attach(dsi);
+	if (err)
+		return dev_err_probe(&dsi->dev, err, "Failed to init MIPI DSI\n");
+
+	return 0;
+}
+
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
+	dc = devm_gpiod_get_optional(&spi->dev, "dc", GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	if (IS_ERR(dc))
+		return dev_err_probe(&spi->dev, PTR_ERR(dc), "Failed to get GPIO for D/CX\n");
+
+	spi_set_drvdata(spi, st7701);
+
+	err = mipi_dbi_spi_init(spi, &st7701->dbi, dc);
+	if (err)
+		return dev_err_probe(&spi->dev, err, "Failed to init MIPI DBI\n");
+	st7701->dbi.read_commands = NULL;
+
+	return 0;
 }
 
 static void st7701_dsi_remove(struct mipi_dsi_device *dsi)
@@ -1048,28 +1121,84 @@ static void st7701_dsi_remove(struct mipi_dsi_device *dsi)
 	struct st7701 *st7701 = mipi_dsi_get_drvdata(dsi);
 
 	mipi_dsi_detach(dsi);
-	drm_panel_remove(&st7701->panel);
+	st7701_remove(st7701);
 }
 
-static const struct of_device_id st7701_of_match[] = {
+static void st7701_spi_remove(struct spi_device *spi)
+{
+	struct st7701 *st7701 = spi_get_drvdata(spi);
+
+	st7701_remove(st7701);
+}
+
+static const struct of_device_id st7701_dsi_of_match[] = {
 	{ .compatible = "anbernic,rg-arc-panel", .data = &rg_arc_desc },
 	{ .compatible = "densitron,dmt028vghmcmi-1a", .data = &dmt028vghmcmi_1a_desc },
 	{ .compatible = "elida,kd50t048a", .data = &kd50t048a_desc },
 	{ .compatible = "techstar,ts8550b", .data = &ts8550b_desc },
-	{ }
+	{ /* sentinel */ }
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
+	.remove		= st7701_spi_remove,
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
+	err = spi_register_driver(&st7701_spi_driver);
+	if (err)
+		return err;
+
+	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI)) {
+		err = mipi_dsi_driver_register(&st7701_dsi_driver);
+		if (err) {
+			spi_unregister_driver(&st7701_spi_driver);
+			return err;
+		}
+
+		return 0;
+	}
+}
+module_init(st7701_driver_init);
+
+static void __exit st7701_driver_exit(void)
+{
+	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI))
+		mipi_dsi_driver_unregister(&st7701_dsi_driver);
+
+	spi_unregister_driver(&st7701_spi_driver);
+}
+module_exit(st7701_driver_exit);
 
 MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_AUTHOR("Hironori KIKUCHI <kikuchan98@gmail.com>");
 MODULE_DESCRIPTION("Sitronix ST7701 LCD Panel Driver");
 MODULE_LICENSE("GPL");
-- 
2.45.2


