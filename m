Return-Path: <linux-kernel+bounces-381844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C8B9B0538
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DFB1F246BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20532064EA;
	Fri, 25 Oct 2024 14:11:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57D1859
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865503; cv=none; b=XnUOVkKs7QEvRYH0+SKsANMrzF/e1TMu3HZcnu6dQXYFtu6bU2ZZYuMWvR8R1OABpp/pz97iBrShiwefNnyWdQGDv/tHdl0SZG+PGg1h//q+Lk+ga1ppkXSeGVpL4jXMXqE1DkCjrMCCJRgcFdo2q538tJuu6Khi5QqOgBp6MPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865503; c=relaxed/simple;
	bh=g9yxAVuQM3rDImKdb5YnMY68zAtlGcIi8Q/nIe5VWFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cua2OWpXbWGcXH64KWXedfHY3F8mm5mFriQR6w7/Hgx89rXIcc6tGnUMaxgii/cKXjwoELVAiTXbPTzI9CoNSXzTmJqCs4BzQUeKJ8t0yacdfjvx/NNXezT6THfanMVArz/lfKrp9xyYQ6N8vwjIxE7h1gey+4dsjf0PYffuL8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rcz@pengutronix.de>)
	id 1t4L2O-0005Ms-2p; Fri, 25 Oct 2024 16:11:36 +0200
Received: from dude06.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::5c])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rcz@pengutronix.de>)
	id 1t4L2N-000NRL-1X;
	Fri, 25 Oct 2024 16:11:35 +0200
Received: from rcz by dude06.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rcz@pengutronix.de>)
	id 1t4L2N-00DL3s-1L;
	Fri, 25 Oct 2024 16:11:35 +0200
From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: kernel@pengutronix.de,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 3/3] drm/panel: add LXD M9189A panel driver
Date: Fri, 25 Oct 2024 16:11:29 +0200
Message-Id: <20241025141130.3179166-3-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241025141130.3179166-1-r.czerwinski@pengutronix.de>
References: <20241025141130.3179166-1-r.czerwinski@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rcz@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The LXD M9189A panel is based on the EK79007AD3 DSI display controller.
It currently supports only 4 lane operation.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
v2:
- use _multi functions
- remove unnecessary dcs_nop function
- calculate pixelclock with timings
suggested by Dmitry Baryshkov

- rename functions to m9189_ prefix
- rename struct and c file to use m9189
- fix commit title to mention m9189

 MAINTAINERS                              |   6 +
 drivers/gpu/drm/panel/Kconfig            |   9 +
 drivers/gpu/drm/panel/Makefile           |   1 +
 drivers/gpu/drm/panel/panel-lxd-m9189a.c | 241 +++++++++++++++++++++++
 4 files changed, 257 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-lxd-m9189a.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7fb33..e4d749b403c28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7179,6 +7179,12 @@ F:	Documentation/devicetree/bindings/display/lvds.yaml
 F:	Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
 F:	drivers/gpu/drm/panel/panel-lvds.c
 
+DRM DRIVER FOR LXD M9189A PANELS
+M:	Rouven Czerwinski <r.czerwinski@pengutronix.de>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml
+F:	drivers/gpu/drm/panel/panel-lxd-m9189a.c
+
 DRM DRIVER FOR MANTIX MLAF057WE51 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index d3a9a9fafe4ec..c9acba8f2432c 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -386,6 +386,15 @@ config DRM_PANEL_LG_SW43408
 	  pixel. It provides a MIPI DSI interface to the host and has a
 	  built-in LED backlight.
 
+config DRM_PANEL_LXD_M9189A
+	tristate "LXD M9189A MIPI-DSI LCD panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for the LXD M9189A 4-Lane
+	  1024x600 MIPI DSI panel.
+
 config DRM_PANEL_MAGNACHIP_D53E6EA8966
 	tristate "Magnachip D53E6EA8966 DSI panel"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 987a087024103..705e9f112eb56 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_DRM_PANEL_LINCOLNTECH_LCD197) += panel-lincolntech-lcd197.o
 obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) += panel-lg-lb035q02.o
 obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
 obj-$(CONFIG_DRM_PANEL_LG_SW43408) += panel-lg-sw43408.o
+obj-$(CONFIG_DRM_PANEL_LXD_M9189A) += panel-lxd-m9189a.o
 obj-$(CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966) += panel-magnachip-d53e6ea8966.o
 obj-$(CONFIG_DRM_PANEL_NEC_NL8048HL11) += panel-nec-nl8048hl11.o
 obj-$(CONFIG_DRM_PANEL_NEWVISION_NV3051D) += panel-newvision-nv3051d.o
diff --git a/drivers/gpu/drm/panel/panel-lxd-m9189a.c b/drivers/gpu/drm/panel/panel-lxd-m9189a.c
new file mode 100644
index 0000000000000..07bd88c488712
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-lxd-m9189a.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree.
+ * Copyright (c) 2024 Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+/* Manufacturer specific DSI commands */
+#define EK79007AD3_GAMMA1		0x80
+#define EK79007AD3_GAMMA2		0x81
+#define EK79007AD3_GAMMA3		0x82
+#define EK79007AD3_GAMMA4		0x83
+#define EK79007AD3_GAMMA5		0x84
+#define EK79007AD3_GAMMA6		0x85
+#define EK79007AD3_GAMMA7		0x86
+#define EK79007AD3_PANEL_CTRL3		0xB2
+
+struct m9189_panel {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct regulator *supply;
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *standby_gpio;
+};
+
+static inline struct m9189_panel *to_m9189_panel(struct drm_panel *panel)
+{
+	return container_of(panel, struct m9189_panel, panel);
+}
+
+static void m9189_reset(struct m9189_panel *m9189)
+{
+	gpiod_set_value_cansleep(m9189->reset_gpio, 0);
+	msleep(20);
+	gpiod_set_value_cansleep(m9189->reset_gpio, 1);
+	msleep(30);
+	gpiod_set_value_cansleep(m9189->reset_gpio, 0);
+	msleep(55);
+}
+
+static int m9189_on(struct m9189_panel *m9189)
+{
+	struct mipi_dsi_multi_context ctx = { .dsi = m9189->dsi };
+
+	ctx.dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	/* Gamma 2.2 */
+	mipi_dsi_dcs_write_seq_multi(&ctx, EK79007AD3_GAMMA1, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&ctx, EK79007AD3_GAMMA2, 0xB8);
+	mipi_dsi_dcs_write_seq_multi(&ctx, EK79007AD3_GAMMA3, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&ctx, EK79007AD3_GAMMA4, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&ctx, EK79007AD3_GAMMA5, 0x58);
+	mipi_dsi_dcs_write_seq_multi(&ctx, EK79007AD3_GAMMA6, 0xD2);
+	mipi_dsi_dcs_write_seq_multi(&ctx, EK79007AD3_GAMMA7, 0x88);
+	mipi_dsi_msleep(&ctx, 50);
+
+	/* 4 Lanes */
+	mipi_dsi_generic_write_multi(&ctx, (u8[]){ EK79007AD3_PANEL_CTRL3, 0x70 }, 2);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 120);
+
+	return ctx.accum_err;
+}
+
+static int m9189_disable(struct drm_panel *panel)
+{
+	struct m9189_panel *m9189 = to_m9189_panel(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = m9189->dsi };
+
+	ctx.dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 120);
+
+	gpiod_set_value_cansleep(m9189->standby_gpio, 1);
+
+	return ctx.accum_err;
+}
+
+static int m9189_prepare(struct drm_panel *panel)
+{
+	struct m9189_panel *m9189 = to_m9189_panel(panel);
+	struct device *dev = &m9189->dsi->dev;
+	int ret;
+
+	ret = regulator_enable(m9189->supply);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
+	}
+
+	gpiod_set_value_cansleep(m9189->standby_gpio, 0);
+	msleep(20);
+	m9189_reset(m9189);
+
+	ret = m9189_on(m9189);
+	if (ret < 0) {
+		dev_err(dev, "Failed to initialize panel: %d\n", ret);
+		gpiod_set_value_cansleep(m9189->reset_gpio, 1);
+		regulator_disable(m9189->supply);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int m9189_unprepare(struct drm_panel *panel)
+{
+	struct m9189_panel *m9189 = to_m9189_panel(panel);
+
+	gpiod_set_value_cansleep(m9189->standby_gpio, 1);
+	msleep(50);
+
+	gpiod_set_value_cansleep(m9189->reset_gpio, 1);
+	regulator_disable(m9189->supply);
+
+	return 0;
+}
+
+static const struct drm_display_mode m9189_mode = {
+	.clock = (1024 + 160 + 160 + 10) * (600 + 12 + 23 + 1) * 60 / 1000,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 160,
+	.hsync_end = 1024 + 160 + 160,
+	.htotal = 1024 + 160 + 160 + 10,
+	.vdisplay = 600,
+	.vsync_start = 600 + 12,
+	.vsync_end = 600 + 12 + 23,
+	.vtotal = 600 + 12 + 23 + 1,
+	.width_mm = 154,
+	.height_mm = 86,
+};
+
+static int m9189_get_modes(struct drm_panel *panel,
+				  struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &m9189_mode);
+}
+
+static const struct drm_panel_funcs m9189_panel_funcs = {
+	.prepare = m9189_prepare,
+	.unprepare = m9189_unprepare,
+	.disable = m9189_disable,
+	.get_modes = m9189_get_modes,
+};
+
+static int lxd_m9189_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct m9189_panel *m9189;
+	int ret;
+
+	m9189 = devm_kzalloc(dev, sizeof(*m9189), GFP_KERNEL);
+	if (!m9189)
+		return -ENOMEM;
+
+	m9189->supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(m9189->supply))
+		return dev_err_probe(dev, ret, "Failed to get regulator\n");
+
+	m9189->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(m9189->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(m9189->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	m9189->standby_gpio = devm_gpiod_get(dev, "standby", GPIOD_OUT_LOW);
+	if (IS_ERR(m9189->standby_gpio))
+		return dev_err_probe(dev, PTR_ERR(m9189->standby_gpio),
+				     "Failed to get standby-gpios\n");
+
+	m9189->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, m9189);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST;
+
+	drm_panel_init(&m9189->panel, dev, &m9189_panel_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+	m9189->panel.prepare_prev_first = true;
+
+	ret = drm_panel_of_backlight(&m9189->panel);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get backlight\n");
+
+	drm_panel_add(&m9189->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
+		drm_panel_remove(&m9189->panel);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void lxd_m9189_remove(struct mipi_dsi_device *dsi)
+{
+	struct m9189_panel *m9189 = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&m9189->panel);
+}
+
+static const struct of_device_id lxd_m9189_of_match[] = {
+	{ .compatible = "lxd,m9189a" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, lxd_m9189_of_match);
+
+static struct mipi_dsi_driver lxd_m9189_driver = {
+	.probe = lxd_m9189_probe,
+	.remove = lxd_m9189_remove,
+	.driver = {
+		.name = "panel-lxa-m9189a",
+		.of_match_table = lxd_m9189_of_match,
+	},
+};
+module_mipi_dsi_driver(lxd_m9189_driver);
+
+MODULE_DESCRIPTION("DRM driver for LXD M9189A MIPI-DSI panels");
+MODULE_LICENSE("GPL");
-- 
2.39.5


