Return-Path: <linux-kernel+bounces-318019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F796E737
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78F828864F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4CA2C853;
	Fri,  6 Sep 2024 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wwyj/jBJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392E1B969;
	Fri,  6 Sep 2024 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585493; cv=none; b=eKRZ5aL+8FopvrCqcPJ1SvPI88qo4BWVFQijn4VcyiUBNzN/6++0g479VhNmi9trbicCWJp2P+jC/9XoCLLYePdzYC0gY/R+gWhyLkzPpcSgVo7AZTgYA75xRHLT3JYyYuWOfZqiWx47V6rSXbH5/u/UcYorQdc+E39wkSuGJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585493; c=relaxed/simple;
	bh=GAfLoi36Uxwpi/nOUjY2YKMfRcHM3xVHFeIS2EC14HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0jyQeq6tCK6SX6LOHkOcyJN4hj4+o2dmkXvAZ4Drdz4DbBoSPkr6AuiRVKL441thuYAURirmHREUuqG9P1oZE8rcBUUkVk+vyjBGZKRZFHudNmxpQN+cowqFE/OP6wf+/M86Fx2dfsTBAA7zxrPC5Ftcc1Q/cLi6MaCjQEYqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wwyj/jBJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725585482;
	bh=GAfLoi36Uxwpi/nOUjY2YKMfRcHM3xVHFeIS2EC14HA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wwyj/jBJJGnfo61uwVCs24j7lfCLnDIGk1cMGBI9KHGqUbDZMlo7JkCesX1NEitDX
	 AtY+13YAqydveLRAtwkla9ZlWx2fMQaItxd7BCF4FvtgVlw8czcIIpE2vxBFfH1RGn
	 bp6Dfl+otg/NdqGWBz9OoPWoIdp+idBupHbtEPRGsdFaZD/EeUlyHwn4a4/XM5PSXq
	 m1S2hAbgiMOB0bHSzOIGzSe5lSYUp1+7YH1Ao1Hqu3+kbNyVeRUiLX6KNt+9wfR/U8
	 xifCJVUnZC9WHaxEwCN38hAAmZq4DK7uA0woP182qVnV8CQIpA4EudODOPXDy5NEjy
	 XPviRQYrpvMXQ==
Received: from localhost (unknown [188.27.55.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 580B017E0E9C;
	Fri,  6 Sep 2024 03:18:02 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 06 Sep 2024 04:17:42 +0300
Subject: [PATCH v6 3/3] drm/rockchip: Add basic RK3588 HDMI output support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-b4-rk3588-bridge-upstream-v6-3-a3128fb103eb@collabora.com>
References: <20240906-b4-rk3588-bridge-upstream-v6-0-a3128fb103eb@collabora.com>
In-Reply-To: <20240906-b4-rk3588-bridge-upstream-v6-0-a3128fb103eb@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>, 
 Algea Cao <algea.cao@rock-chips.com>
X-Mailer: b4 0.14.1

The RK3588 SoC family integrates the newer Synopsys DesignWare HDMI 2.1
Quad-Pixel (QP) TX controller IP and a HDMI/eDP TX Combo PHY based on a
Samsung IP block.

Add just the basic support for now, i.e. RGB output up to 4K@60Hz,
without audio, CEC or any of the HDMI 2.1 specific features.

Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/Kconfig               |   8 +
 drivers/gpu/drm/rockchip/Makefile              |   1 +
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 437 +++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c    |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h    |   1 +
 5 files changed, 449 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 7df875e38517..4da7cef24f57 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -8,6 +8,7 @@ config DRM_ROCKCHIP
 	select VIDEOMODE_HELPERS
 	select DRM_ANALOGIX_DP if ROCKCHIP_ANALOGIX_DP
 	select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
+	select DRM_DW_HDMI_QP if ROCKCHIP_DW_HDMI_QP
 	select DRM_DW_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
 	select GENERIC_PHY if ROCKCHIP_DW_MIPI_DSI
 	select GENERIC_PHY_MIPI_DPHY if ROCKCHIP_DW_MIPI_DSI
@@ -63,6 +64,13 @@ config ROCKCHIP_DW_HDMI
 	  enable HDMI on RK3288 or RK3399 based SoC, you should select
 	  this option.
 
+config ROCKCHIP_DW_HDMI_QP
+	bool "Rockchip specific extensions for Synopsys DW HDMI QP"
+	help
+	  This selects support for Rockchip SoC specific extensions
+	  for the Synopsys DesignWare HDMI QP driver. If you want to
+	  enable HDMI on RK3588 based SoC, you should select this option.
+
 config ROCKCHIP_DW_MIPI_DSI
 	bool "Rockchip specific extensions for Synopsys DW MIPI DSI"
 	select GENERIC_PHY_MIPI_DPHY
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index 3ff7b21c0414..3eab662a5a1d 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -11,6 +11,7 @@ rockchipdrm-$(CONFIG_ROCKCHIP_VOP) += rockchip_drm_vop.o rockchip_vop_reg.o
 rockchipdrm-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
+rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI_QP) += dw_hdmi_qp-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_LVDS) += rockchip_lvds.o
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
new file mode 100644
index 000000000000..a743ed3a2090
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021-2022 Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2024 Collabora Ltd.
+ *
+ * Author: Algea Cao <algea.cao@rock-chips.com>
+ * Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+
+#include <drm/bridge/dw_hdmi_qp.h>
+#include <drm/drm_bridge_connector.h>
+#include <drm/drm_of.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+
+#include "rockchip_drm_drv.h"
+
+#define RK3588_GRF_SOC_CON2		0x0308
+#define RK3588_HDMI0_HPD_INT_MSK	BIT(13)
+#define RK3588_HDMI0_HPD_INT_CLR	BIT(12)
+#define RK3588_GRF_SOC_CON7		0x031c
+#define RK3588_SET_HPD_PATH_MASK	GENMASK(13, 12)
+#define RK3588_GRF_SOC_STATUS1		0x0384
+#define RK3588_HDMI0_LEVEL_INT		BIT(16)
+#define RK3588_GRF_VO1_CON3		0x000c
+#define RK3588_SCLIN_MASK		BIT(9)
+#define RK3588_SDAIN_MASK		BIT(10)
+#define RK3588_MODE_MASK		BIT(11)
+#define RK3588_I2S_SEL_MASK		BIT(13)
+#define RK3588_GRF_VO1_CON9		0x0024
+#define RK3588_HDMI0_GRANT_SEL		BIT(10)
+
+#define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
+
+struct rockchip_hdmi_qp {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regmap *vo_regmap;
+	struct rockchip_encoder encoder;
+	struct clk *ref_clk;
+	struct dw_hdmi_qp *hdmi;
+	struct phy *phy;
+	struct gpio_desc *enable_gpio;
+	struct delayed_work hpd_work;
+};
+
+static struct rockchip_hdmi_qp *to_rockchip_hdmi_qp(struct drm_encoder *encoder)
+{
+	struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
+
+	return container_of(rkencoder, struct rockchip_hdmi_qp, encoder);
+}
+
+static void
+dw_hdmi_qp_rockchip_encoder_mode_set(struct drm_encoder *encoder,
+				     struct drm_display_mode *mode,
+				     struct drm_display_mode *adj_mode)
+{
+	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
+
+	clk_set_rate(hdmi->ref_clk, adj_mode->clock * 1000);
+}
+
+static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
+{
+	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
+	struct drm_crtc *crtc = encoder->crtc;
+	int rate;
+
+	/* Unconditionally switch to TMDS as FRL is not yet supported */
+	gpiod_set_value(hdmi->enable_gpio, 1);
+
+	if (crtc && crtc->state) {
+		clk_set_rate(hdmi->ref_clk,
+			     crtc->state->adjusted_mode.crtc_clock * 1000);
+		/*
+		 * FIXME: Temporary workaround to pass pixel clock rate
+		 * to the PHY driver until phy_configure_opts_hdmi
+		 * becomes available in the PHY API. See also the related
+		 * comment in rk_hdptx_phy_power_on() from
+		 * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+		 */
+		rate = crtc->state->mode.clock * 10;
+		phy_set_bus_width(hdmi->phy, rate);
+		drm_dbg(hdmi, "%s set bus_width=%u\n", __func__, rate);
+	}
+}
+
+static int
+dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
+					 struct drm_crtc_state *crtc_state,
+					 struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+
+	s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
+	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
+
+	return 0;
+}
+
+static const struct
+drm_encoder_helper_funcs dw_hdmi_qp_rockchip_encoder_helper_funcs = {
+	.mode_set	= dw_hdmi_qp_rockchip_encoder_mode_set,
+	.enable		= dw_hdmi_qp_rockchip_encoder_enable,
+	.atomic_check	= dw_hdmi_qp_rockchip_encoder_atomic_check,
+};
+
+static int dw_hdmi_qp_rk3588_phy_init(struct dw_hdmi_qp *dw_hdmi, void *data,
+				      const struct drm_display_info *display)
+{
+	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
+
+	return phy_power_on(hdmi->phy);
+}
+
+static void dw_hdmi_qp_rk3588_phy_disable(struct dw_hdmi_qp *dw_hdmi,
+					  void *data)
+{
+	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
+
+	phy_power_off(hdmi->phy);
+}
+
+static enum drm_connector_status
+dw_hdmi_qp_rk3588_read_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
+{
+	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
+	u32 val;
+
+	regmap_read(hdmi->regmap, RK3588_GRF_SOC_STATUS1, &val);
+
+	return val & RK3588_HDMI0_LEVEL_INT ?
+		connector_status_connected : connector_status_disconnected;
+}
+
+static void dw_hdmi_qp_rk3588_setup_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
+{
+	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
+
+	regmap_write(hdmi->regmap,
+		     RK3588_GRF_SOC_CON2,
+		     HIWORD_UPDATE(RK3588_HDMI0_HPD_INT_CLR,
+				   RK3588_HDMI0_HPD_INT_CLR |
+				   RK3588_HDMI0_HPD_INT_MSK));
+}
+
+static const struct dw_hdmi_qp_phy_ops rk3588_hdmi_phy_ops = {
+	.init		= dw_hdmi_qp_rk3588_phy_init,
+	.disable	= dw_hdmi_qp_rk3588_phy_disable,
+	.read_hpd	= dw_hdmi_qp_rk3588_read_hpd,
+	.setup_hpd	= dw_hdmi_qp_rk3588_setup_hpd,
+};
+
+static void dw_hdmi_qp_rk3588_hpd_work(struct work_struct *work)
+{
+	struct rockchip_hdmi_qp *hdmi = container_of(work,
+						     struct rockchip_hdmi_qp,
+						     hpd_work.work);
+	struct drm_device *drm = hdmi->encoder.encoder.dev;
+	bool changed;
+
+	if (drm) {
+		changed = drm_helper_hpd_irq_event(drm);
+		if (changed)
+			drm_dbg(hdmi, "connector status changed\n");
+	}
+}
+
+static irqreturn_t dw_hdmi_qp_rk3588_hardirq(int irq, void *dev_id)
+{
+	struct rockchip_hdmi_qp *hdmi = dev_id;
+	u32 intr_stat, val;
+
+	regmap_read(hdmi->regmap, RK3588_GRF_SOC_STATUS1, &intr_stat);
+
+	if (intr_stat) {
+		val = HIWORD_UPDATE(RK3588_HDMI0_HPD_INT_MSK,
+				    RK3588_HDMI0_HPD_INT_MSK);
+		regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
+		return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t dw_hdmi_qp_rk3588_irq(int irq, void *dev_id)
+{
+	struct rockchip_hdmi_qp *hdmi = dev_id;
+	u32 intr_stat, val;
+	int debounce_ms;
+
+	regmap_read(hdmi->regmap, RK3588_GRF_SOC_STATUS1, &intr_stat);
+	if (!intr_stat)
+		return IRQ_NONE;
+
+	val = HIWORD_UPDATE(RK3588_HDMI0_HPD_INT_CLR,
+			    RK3588_HDMI0_HPD_INT_CLR);
+	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
+
+	debounce_ms = intr_stat & RK3588_HDMI0_LEVEL_INT ? 150 : 20;
+	mod_delayed_work(system_wq, &hdmi->hpd_work,
+			 msecs_to_jiffies(debounce_ms));
+
+	val |= HIWORD_UPDATE(0, RK3588_HDMI0_HPD_INT_MSK);
+	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
+
+	return IRQ_HANDLED;
+}
+
+static const struct of_device_id dw_hdmi_qp_rockchip_dt_ids[] = {
+	{ .compatible = "rockchip,rk3588-dw-hdmi-qp",
+	  .data = &rk3588_hdmi_phy_ops },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_hdmi_qp_rockchip_dt_ids);
+
+static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
+				    void *data)
+{
+	static const char * const clk_names[] = {
+		"pclk", "earc", "aud", "hdp", "hclk_vo1",
+		"ref" /* keep "ref" last */
+	};
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_hdmi_qp_plat_data plat_data;
+	struct drm_device *drm = data;
+	struct drm_connector *connector;
+	struct drm_encoder *encoder;
+	struct rockchip_hdmi_qp *hdmi;
+	struct clk *clk;
+	int ret, irq, i;
+	u32 val;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
+	if (!hdmi)
+		return -ENOMEM;
+
+	plat_data.phy_ops = of_device_get_match_data(dev);
+	if (!plat_data.phy_ops)
+		return -ENODEV;
+
+	plat_data.phy_data = hdmi;
+	hdmi->dev = &pdev->dev;
+
+	encoder = &hdmi->encoder.encoder;
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+
+	rockchip_drm_encoder_set_crtc_endpoint_id(&hdmi->encoder,
+						  dev->of_node, 0, 0);
+	/*
+	 * If we failed to find the CRTC(s) which this encoder is
+	 * supposed to be connected to, it's because the CRTC has
+	 * not been registered yet.  Defer probing, and hope that
+	 * the required CRTC is added later.
+	 */
+	if (encoder->possible_crtcs == 0)
+		return -EPROBE_DEFER;
+
+	hdmi->regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+						       "rockchip,grf");
+	if (IS_ERR(hdmi->regmap)) {
+		drm_err(hdmi, "Unable to get rockchip,grf\n");
+		return PTR_ERR(hdmi->regmap);
+	}
+
+	hdmi->vo_regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+							  "rockchip,vo-grf");
+	if (IS_ERR(hdmi->vo_regmap)) {
+		drm_err(hdmi, "Unable to get rockchip,vo-grf\n");
+		return PTR_ERR(hdmi->vo_regmap);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(clk_names); i++) {
+		clk = devm_clk_get_enabled(hdmi->dev, clk_names[i]);
+
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			if (ret != -EPROBE_DEFER)
+				drm_err(hdmi, "Failed to get %s clock: %d\n",
+					clk_names[i], ret);
+			return ret;
+		}
+	}
+	hdmi->ref_clk = clk;
+
+	hdmi->enable_gpio = devm_gpiod_get_optional(hdmi->dev, "enable",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(hdmi->enable_gpio)) {
+		ret = PTR_ERR(hdmi->enable_gpio);
+		drm_err(hdmi, "Failed to request enable GPIO: %d\n", ret);
+		return ret;
+	}
+
+	hdmi->phy = devm_of_phy_get_by_index(dev, dev->of_node, 0);
+	if (IS_ERR(hdmi->phy)) {
+		ret = PTR_ERR(hdmi->phy);
+		if (ret != -EPROBE_DEFER)
+			drm_err(hdmi, "failed to get phy: %d\n", ret);
+		return ret;
+	}
+
+	val = HIWORD_UPDATE(RK3588_SCLIN_MASK, RK3588_SCLIN_MASK) |
+	      HIWORD_UPDATE(RK3588_SDAIN_MASK, RK3588_SDAIN_MASK) |
+	      HIWORD_UPDATE(RK3588_MODE_MASK, RK3588_MODE_MASK) |
+	      HIWORD_UPDATE(RK3588_I2S_SEL_MASK, RK3588_I2S_SEL_MASK);
+	regmap_write(hdmi->vo_regmap, RK3588_GRF_VO1_CON3, val);
+
+	val = HIWORD_UPDATE(RK3588_SET_HPD_PATH_MASK,
+			    RK3588_SET_HPD_PATH_MASK);
+	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON7, val);
+
+	val = HIWORD_UPDATE(RK3588_HDMI0_GRANT_SEL,
+			    RK3588_HDMI0_GRANT_SEL);
+	regmap_write(hdmi->vo_regmap, RK3588_GRF_VO1_CON9, val);
+
+	val = HIWORD_UPDATE(RK3588_HDMI0_HPD_INT_MSK, RK3588_HDMI0_HPD_INT_MSK);
+	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON2, val);
+
+	INIT_DELAYED_WORK(&hdmi->hpd_work, dw_hdmi_qp_rk3588_hpd_work);
+
+	plat_data.main_irq = platform_get_irq_byname(pdev, "main");
+	if (plat_data.main_irq < 0)
+		return plat_data.main_irq;
+
+	irq = platform_get_irq_byname(pdev, "hpd");
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(hdmi->dev, irq,
+					dw_hdmi_qp_rk3588_hardirq,
+					dw_hdmi_qp_rk3588_irq,
+					IRQF_SHARED, "dw-hdmi-qp-hpd",
+					hdmi);
+	if (ret)
+		return ret;
+
+	drm_encoder_helper_add(encoder, &dw_hdmi_qp_rockchip_encoder_helper_funcs);
+	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
+
+	platform_set_drvdata(pdev, hdmi);
+
+	hdmi->hdmi = dw_hdmi_qp_bind(pdev, encoder, &plat_data);
+	if (IS_ERR(hdmi->hdmi)) {
+		ret = PTR_ERR(hdmi->hdmi);
+		drm_encoder_cleanup(encoder);
+		return ret;
+	}
+
+	connector = drm_bridge_connector_init(drm, encoder);
+	if (IS_ERR(connector)) {
+		ret = PTR_ERR(connector);
+		drm_err(hdmi, "failed to init bridge connector: %d\n", ret);
+		return ret;
+	}
+
+	return drm_connector_attach_encoder(connector, encoder);
+}
+
+static void dw_hdmi_qp_rockchip_unbind(struct device *dev,
+				       struct device *master,
+				       void *data)
+{
+	struct rockchip_hdmi_qp *hdmi = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&hdmi->hpd_work);
+
+	drm_encoder_cleanup(&hdmi->encoder.encoder);
+}
+
+static const struct component_ops dw_hdmi_qp_rockchip_ops = {
+	.bind	= dw_hdmi_qp_rockchip_bind,
+	.unbind	= dw_hdmi_qp_rockchip_unbind,
+};
+
+static int dw_hdmi_qp_rockchip_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &dw_hdmi_qp_rockchip_ops);
+}
+
+static void dw_hdmi_qp_rockchip_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &dw_hdmi_qp_rockchip_ops);
+}
+
+static int __maybe_unused dw_hdmi_qp_rockchip_resume(struct device *dev)
+{
+	struct rockchip_hdmi_qp *hdmi = dev_get_drvdata(dev);
+	u32 val;
+
+	val = HIWORD_UPDATE(RK3588_SCLIN_MASK, RK3588_SCLIN_MASK) |
+	      HIWORD_UPDATE(RK3588_SDAIN_MASK, RK3588_SDAIN_MASK) |
+	      HIWORD_UPDATE(RK3588_MODE_MASK, RK3588_MODE_MASK) |
+	      HIWORD_UPDATE(RK3588_I2S_SEL_MASK, RK3588_I2S_SEL_MASK);
+	regmap_write(hdmi->vo_regmap, RK3588_GRF_VO1_CON3, val);
+
+	val = HIWORD_UPDATE(RK3588_SET_HPD_PATH_MASK,
+			    RK3588_SET_HPD_PATH_MASK);
+	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON7, val);
+
+	val = HIWORD_UPDATE(RK3588_HDMI0_GRANT_SEL,
+			    RK3588_HDMI0_GRANT_SEL);
+	regmap_write(hdmi->vo_regmap, RK3588_GRF_VO1_CON9, val);
+
+	dw_hdmi_qp_resume(dev, hdmi->hdmi);
+
+	if (hdmi->encoder.encoder.dev)
+		drm_helper_hpd_irq_event(hdmi->encoder.encoder.dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops dw_hdmi_qp_rockchip_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, dw_hdmi_qp_rockchip_resume)
+};
+
+struct platform_driver dw_hdmi_qp_rockchip_pltfm_driver = {
+	.probe  = dw_hdmi_qp_rockchip_probe,
+	.remove_new = dw_hdmi_qp_rockchip_remove,
+	.driver = {
+		.name = "dwhdmiqp-rockchip",
+		.pm = &dw_hdmi_qp_rockchip_pm,
+		.of_match_table = dw_hdmi_qp_rockchip_dt_ids,
+	},
+};
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 44d769d9234d..04ef7a2c3833 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -503,6 +503,8 @@ static int __init rockchip_drm_init(void)
 	ADD_ROCKCHIP_SUB_DRIVER(cdn_dp_driver, CONFIG_ROCKCHIP_CDN_DP);
 	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_rockchip_pltfm_driver,
 				CONFIG_ROCKCHIP_DW_HDMI);
+	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_qp_rockchip_pltfm_driver,
+				CONFIG_ROCKCHIP_DW_HDMI_QP);
 	ADD_ROCKCHIP_SUB_DRIVER(dw_mipi_dsi_rockchip_driver,
 				CONFIG_ROCKCHIP_DW_MIPI_DSI);
 	ADD_ROCKCHIP_SUB_DRIVER(inno_hdmi_driver, CONFIG_ROCKCHIP_INNO_HDMI);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index bbb9e0bf6804..d7f2f0fd02e6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -87,6 +87,7 @@ int rockchip_drm_encoder_set_crtc_endpoint_id(struct rockchip_encoder *rencoder,
 int rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
 extern struct platform_driver cdn_dp_driver;
 extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
+extern struct platform_driver dw_hdmi_qp_rockchip_pltfm_driver;
 extern struct platform_driver dw_mipi_dsi_rockchip_driver;
 extern struct platform_driver inno_hdmi_driver;
 extern struct platform_driver rockchip_dp_driver;

-- 
2.46.0


