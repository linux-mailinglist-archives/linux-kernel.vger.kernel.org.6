Return-Path: <linux-kernel+bounces-550869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6FA56526
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1EA57AA2D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C839213249;
	Fri,  7 Mar 2025 10:24:26 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68399211A20
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343065; cv=none; b=D8yFdArAGKqRH7Am97e6ipr0I27oYwA8ycMCjszCd9UsUkyg/NJxsZU2ttWsMtkeTxaqSN912JHp1DoBRnpeVnXaT0l9cCbocT2379SuwB49YwNF0ER1cKPI4XdRYhiDNin+EwVFkePpeo7fsCEYI9AfCO9+CcgJgacXNeQN8Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343065; c=relaxed/simple;
	bh=k5R/tE0bNYyMsemBF68ZQKfIm3Fu90Wy6MVWoojZvn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozE9vJCoi3o/d20Q4zdannM74I/V4xfbJD/7CEt8zsb0NnmpdN4PqWthxB7BHhEgMRXccahtmgNGr2RSJ2HFrjcm/2dfXTgp6F8TbTJmN0Q6U92mCwinCP3c6Zkmf77TCQC2flkFGHMGK+OEQtuIizhD3UO2PQx5RLF4ue4Xb8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z8Mk85c5NzvWpf;
	Fri,  7 Mar 2025 18:20:32 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A79C1800B1;
	Fri,  7 Mar 2025 18:24:21 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 7 Mar 2025 18:24:19 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 drm-dp 7/9] drm/hisilicon/hibmc: Enable this hot plug detect of irq feature
Date: Fri, 7 Mar 2025 18:16:38 +0800
Message-ID: <20250307101640.4003229-8-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250307101640.4003229-1-shiyongbang@huawei.com>
References: <20250307101640.4003229-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500013.china.huawei.com (7.221.188.12)

From: Baihan Li <libaihan@huawei.com>

Add HPD interrupt enable functions in drm framework. Add link reset
process to reset link status when a new connector pulgged in.

Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v4 -> v5:
  - separate the vga part commit, suggested by Dmitry Baryshkov.
v3 -> v4:
  - add link reset of rates and lanes in pre link training process, suggested by Dmitry Baryshkov.
  - add vdac detect and connected/disconnected status to enable HPD process, suggested by Dmitry Baryshkov.
  - remove a drm_client, suggested by Dmitry Baryshkov.
  - fix build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202502231304.BCzV4Y8D-lkp@intel.com/
v2 -> v3:
  - remove mdelay(100) hpd function in ISR, suggested by Dmitry Baryshkov.
  - remove enble_display in ISR, suggested by Dmitry Baryshkov.
  - change drm_kms_helper_connector_hotplug_event() to
    drm_connector_helper_hpd_irq_event(), suggested by Dmitry Baryshkov.
  - move macros to dp_reg.h, suggested by Dmitry Baryshkov.
  - remove struct irqs, suggested by Dmitry Baryshkov.
  - split this patch into two parts, suggested by Dmitry Baryshkov.
  - add a drm client dev to handle HPD event.
v1 -> v2:
  - optimizing the description in commit message, suggested by Dmitry Baryshkov.
  - add mdelay(100) comments, suggested by Dmitry Baryshkov.
  - deleting display enable in hpd event, suggested by Dmitry Baryshkov.
---
 .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  1 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 36 +++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  5 +++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 33 +++++++++++++++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  2 ++
 5 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
index c5feef8dc27d..08f9e1caf7fc 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
@@ -16,5 +16,6 @@
 #define HIBMC_DP_SYNC_EN_MASK		0x3
 #define HIBMC_DP_LINK_RATE_CAL		27
 #define HIBMC_DP_SYNC_DELAY(lanes)	((lanes) == 0x2 ? 86 : 46)
+#define HIBMC_DP_INT_ENABLE		0xc
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index ce7cb07815b2..8f0daec7d174 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -189,6 +189,36 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
 	return 0;
 }
 
+void hibmc_dp_enable_int(struct hibmc_dp *dp)
+{
+	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
+
+	writel(HIBMC_DP_INT_ENABLE, dp_dev->base + HIBMC_DP_INTR_ENABLE);
+}
+
+void hibmc_dp_disable_int(struct hibmc_dp *dp)
+{
+	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
+
+	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
+	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
+}
+
+void hibmc_dp_hpd_cfg(struct hibmc_dp *dp)
+{
+	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
+
+	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_SYNC_LEN_SEL, 0x0);
+	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_TIMER_TIMEOUT, 0x1);
+	hibmc_dp_reg_write_field(dp->dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_MIN_PULSE_NUM, 0x9);
+	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
+	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
+	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
+	writel(HIBMC_DP_INT_ENABLE, dp_dev->base + HIBMC_DP_INTR_ENABLE);
+	writel(HIBMC_DP_DPTX_RST, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
+	writel(HIBMC_DP_CLK_EN, dp_dev->base + HIBMC_DP_DPTX_CLK_CTRL);
+}
+
 void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable)
 {
 	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
@@ -227,6 +257,12 @@ int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode)
 	return 0;
 }
 
+void hibmc_dp_reset_link(struct hibmc_dp *dp)
+{
+	dp->dp_dev->link.status.clock_recovered = false;
+	dp->dp_dev->link.status.channel_equalized = false;
+}
+
 static const struct hibmc_dp_color_raw g_rgb_raw[] = {
 	{CBAR_COLOR_BAR, 0x000, 0x000, 0x000},
 	{CBAR_WHITE,     0xfff, 0xfff, 0xfff},
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 83a53dae8012..665f5b166dfb 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -49,11 +49,16 @@ struct hibmc_dp {
 	void __iomem *mmio;
 	struct drm_dp_aux aux;
 	struct hibmc_dp_cbar_cfg cfg;
+	u32 irq_status;
 };
 
 int hibmc_dp_hw_init(struct hibmc_dp *dp);
 int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode);
 void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable);
 void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg);
+void hibmc_dp_reset_link(struct hibmc_dp *dp);
+void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
+void hibmc_dp_enable_int(struct hibmc_dp *dp);
+void hibmc_dp_disable_int(struct hibmc_dp *dp);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index a7f611e82f73..31f1e8970265 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -13,6 +13,8 @@
 #include "hibmc_drm_drv.h"
 #include "dp/dp_hw.h"
 
+#define DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
+
 static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
 {
 	struct hibmc_dp *dp = to_hibmc_dp(connector);
@@ -39,6 +41,8 @@ static int hibmc_dp_late_register(struct drm_connector *connector)
 {
 	struct hibmc_dp *dp = to_hibmc_dp(connector);
 
+	hibmc_dp_enable_int(dp);
+
 	return drm_dp_aux_register(&dp->aux);
 }
 
@@ -47,6 +51,8 @@ static void hibmc_dp_early_unregister(struct drm_connector *connector)
 	struct hibmc_dp *dp = to_hibmc_dp(connector);
 
 	drm_dp_aux_unregister(&dp->aux);
+
+	hibmc_dp_disable_int(dp);
 }
 
 static const struct drm_connector_funcs hibmc_dp_conn_funcs = {
@@ -98,6 +104,31 @@ static const struct drm_encoder_helper_funcs hibmc_dp_encoder_helper_funcs = {
 	.atomic_disable = hibmc_dp_encoder_disable,
 };
 
+irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
+{
+	struct drm_device *dev = (struct drm_device *)arg;
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return -ENODEV;
+
+	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
+		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
+		hibmc_dp_hpd_cfg(&priv->dp);
+	} else {
+		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
+		hibmc_dp_reset_link(&priv->dp);
+	}
+
+	if (dev->registered)
+		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
+
+	drm_dev_exit(idx);
+
+	return IRQ_HANDLED;
+}
+
 int hibmc_dp_init(struct hibmc_drm_private *priv)
 {
 	struct drm_device *dev = &priv->dev;
@@ -138,5 +169,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
 
 	drm_connector_attach_encoder(connector, encoder);
 
+	connector->polled = DRM_CONNECTOR_POLL_HPD;
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index bc89e4b9f4e3..daed1330b961 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -71,4 +71,6 @@ int hibmc_dp_init(struct hibmc_drm_private *priv);
 
 void hibmc_debugfs_init(struct drm_connector *connector, struct dentry *root);
 
+irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg);
+
 #endif
-- 
2.33.0


