Return-Path: <linux-kernel+bounces-343761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ED5989F21
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE0C1C21728
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3771618B48B;
	Mon, 30 Sep 2024 10:12:20 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AF188711
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691139; cv=none; b=C+coHztd3zzCuMyUtCXzotCVojWiah6uVdnmFOkGmUSMlLnp8UKCfxIaV1iv03BciVkIU/GvSXlqytrs2o8tKQNlJ2+X7Oqsai3pNZG0QjH1o/g9URO+SdVoueRHP6Ytc1nzxcid+tnarePJAYBkuR6MXWAjvSlZbtREYqK7a/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691139; c=relaxed/simple;
	bh=Qma68DagMMYWb77MEmsbkjnN3GJ4qwLe5FpzeJHeJkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jF+SNRtsVkqivr5hKqnUOtlp9w3KDXQm21K504GKELf7SemNNURRg7ubRWXDkqPZqXMmuB43VKnqgniBlruN/9mQKjvo6rHFP9qpB4uk7ufFyU5zFQ4QqOZg459N161oZwoQoYFZ6ciw9haxVYjR/xyAC5J9yUn2rBu9AspPLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XHH0S36GSz1SC7Q;
	Mon, 30 Sep 2024 18:11:20 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id BAD9A1A016C;
	Mon, 30 Sep 2024 18:12:14 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 30 Sep 2024 18:12:13 +0800
From: shiyongbang <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH drm-dp 4/4] drm/hisilicon/hibmc: add dp module in hibmc
Date: Mon, 30 Sep 2024 18:06:10 +0800
Message-ID: <20240930100610.782363-5-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240930100610.782363-1-shiyongbang@huawei.com>
References: <20240930100610.782363-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500013.china.huawei.com (7.221.188.12)

From: baihan li <libaihan@huawei.com>

To support DP interface displaying in hibmc driver. Add
a encoder and connector for DP modual.

Signed-off-by: baihan li <libaihan@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/Makefile      |   2 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 195 ++++++++++++++++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  17 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
 4 files changed, 217 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
index 693036dfab52..8cf74e0d4785 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
-	       dp/dp_aux.o dp/dp_link.o dp/dp_kapi.o
+	       dp/dp_aux.o dp/dp_link.o dp/dp_kapi.o hibmc_drm_dp.o
 
 obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
new file mode 100644
index 000000000000..7a50f1d81aac
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/io.h>
+
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_edid.h>
+
+#include "hibmc_drm_drv.h"
+#include "dp/dp_kapi.h"
+
+static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
+{
+	int count;
+
+	count = drm_add_modes_noedid(connector, connector->dev->mode_config.max_width,
+				     connector->dev->mode_config.max_height);
+	drm_set_preferred_mode(connector, 800, 600); /* default 800x600 */
+
+	return count;
+}
+
+static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
+	.get_modes = hibmc_dp_connector_get_modes,
+};
+
+static const struct drm_connector_funcs hibmc_dp_conn_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static void dp_mode_cfg(struct drm_device *dev, struct dp_mode *dp_mode,
+			struct drm_display_mode *mode)
+{
+	dp_mode->field_rate = drm_mode_vrefresh(mode);
+	dp_mode->pixel_clock = mode->clock / 1000; /* 1000: khz to hz */
+
+	dp_mode->h_total = mode->htotal;
+	dp_mode->h_active = mode->hdisplay;
+	dp_mode->h_blank = mode->htotal - mode->hdisplay;
+	dp_mode->h_front = mode->hsync_start - mode->hdisplay;
+	dp_mode->h_sync = mode->hsync_end - mode->hsync_start;
+	dp_mode->h_back = mode->htotal - mode->hsync_end;
+
+	dp_mode->v_total = mode->vtotal;
+	dp_mode->v_active = mode->vdisplay;
+	dp_mode->v_blank = mode->vtotal - mode->vdisplay;
+	dp_mode->v_front = mode->vsync_start - mode->vdisplay;
+	dp_mode->v_sync = mode->vsync_end - mode->vsync_start;
+	dp_mode->v_back = mode->vtotal - mode->vsync_end;
+
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC) {
+		drm_info(dev, "horizontal sync polarity: positive\n");
+		dp_mode->h_pol = 1;
+	} else if (mode->flags & DRM_MODE_FLAG_NHSYNC) {
+		drm_info(dev, "horizontal sync polarity: negative\n");
+		dp_mode->h_pol = 0;
+	} else {
+		drm_err(dev, "horizontal sync polarity: unknown or not set\n");
+	}
+
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC) {
+		drm_info(dev, "vertical sync polarity: positive\n");
+		dp_mode->v_pol = 1;
+	} else if (mode->flags & DRM_MODE_FLAG_NVSYNC) {
+		drm_info(dev, "vertical sync polarity: negative\n");
+		dp_mode->v_pol = 0;
+	} else {
+		drm_err(dev, "vertical sync polarity: unknown or not set\n");
+	}
+}
+
+static int dp_prepare(struct hibmc_dp *dp, struct drm_display_mode *mode)
+{
+	struct dp_mode dp_mode = {0};
+	int ret;
+
+	hibmc_dp_display_en(dp, false);
+
+	dp_mode_cfg(dp->drm_dev, &dp_mode, mode);
+	ret = hibmc_dp_mode_set(dp, &dp_mode);
+	if (ret)
+		drm_err(dp->drm_dev, "hibmc dp mode set failed: %d\n", ret);
+
+	return ret;
+}
+
+static void dp_enable(struct hibmc_dp *dp)
+{
+	hibmc_dp_display_en(dp, true);
+}
+
+static void dp_disable(struct hibmc_dp *dp)
+{
+	hibmc_dp_display_en(dp, false);
+}
+
+static int hibmc_dp_hw_init(struct hibmc_drm_private *priv)
+{
+	int ret;
+
+	ret = hibmc_dp_kapi_init(&priv->dp);
+	if (ret)
+		return ret;
+
+	hibmc_dp_display_en(&priv->dp, false);
+
+	return 0;
+}
+
+static void hibmc_dp_hw_uninit(struct hibmc_drm_private *priv)
+{
+	hibmc_dp_kapi_uninit(&priv->dp);
+}
+
+static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
+				    struct drm_atomic_state *state)
+{
+	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
+	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
+
+	if (dp_prepare(dp, mode))
+		return;
+
+	dp_enable(dp);
+}
+
+static void hibmc_dp_encoder_disable(struct drm_encoder *drm_encoder,
+				     struct drm_atomic_state *state)
+{
+	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
+
+	dp_disable(dp);
+}
+
+static const struct drm_encoder_helper_funcs hibmc_dp_encoder_helper_funcs = {
+	.atomic_enable = hibmc_dp_encoder_enable,
+	.atomic_disable = hibmc_dp_encoder_disable,
+};
+
+void hibmc_dp_uninit(struct hibmc_drm_private *priv)
+{
+	hibmc_dp_hw_uninit(priv);
+}
+
+int hibmc_dp_init(struct hibmc_drm_private *priv)
+{
+	struct drm_device *dev = &priv->dev;
+	struct drm_crtc *crtc = &priv->crtc;
+	struct hibmc_dp *dp = &priv->dp;
+	struct drm_connector *connector = &dp->connector;
+	struct drm_encoder *encoder = &dp->encoder;
+	int ret;
+
+	dp->mmio = priv->mmio;
+	dp->drm_dev = dev;
+
+	ret = hibmc_dp_hw_init(priv);
+	if (ret) {
+		drm_err(dev, "dp hw init failed: %d\n", ret);
+		return ret;
+	}
+
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
+	if (ret) {
+		drm_err(dev, "init dp encoder failed: %d\n", ret);
+		goto err_init;
+	}
+
+	drm_encoder_helper_add(encoder, &hibmc_dp_encoder_helper_funcs);
+
+	ret = drm_connector_init(dev, connector, &hibmc_dp_conn_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	if (ret) {
+		drm_err(dev, "init dp connector failed: %d\n", ret);
+		goto err_init;
+	}
+
+	drm_connector_helper_add(connector, &hibmc_dp_conn_helper_funcs);
+
+	drm_connector_attach_encoder(connector, encoder);
+
+	return 0;
+
+err_init:
+	hibmc_dp_hw_uninit(priv);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 9f9b19ea0587..c90a8db021b0 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -93,6 +93,10 @@ static const struct drm_mode_config_funcs hibmc_mode_funcs = {
 
 static int hibmc_kms_init(struct hibmc_drm_private *priv)
 {
+#define DP_HOST_SERDES_CTRL		0x1f001c
+#define DP_HOST_SERDES_CTRL_VAL		0x8A00
+#define DP_HOST_SERDES_CTRL_MASK	0x7FFFE
+
 	struct drm_device *dev = &priv->dev;
 	int ret;
 
@@ -116,10 +120,17 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 		return ret;
 	}
 
+	/* if DP existed, init DP */
+	if ((readl(priv->mmio + DP_HOST_SERDES_CTRL) &
+	     DP_HOST_SERDES_CTRL_MASK) == DP_HOST_SERDES_CTRL_VAL) {
+		ret = hibmc_dp_init(priv);
+		if (ret)
+			drm_err(dev, "failed to init dp: %d\n", ret);
+	}
+
 	ret = hibmc_vdac_init(priv);
 	if (ret) {
 		drm_err(dev, "failed to init vdac: %d\n", ret);
-		return ret;
 	}
 
 	return 0;
@@ -239,6 +250,7 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
 
 static int hibmc_unload(struct drm_device *dev)
 {
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	drm_atomic_helper_shutdown(dev);
@@ -247,6 +259,9 @@ static int hibmc_unload(struct drm_device *dev)
 
 	pci_disable_msi(to_pci_dev(dev->dev));
 
+	if (priv->dp.encoder.possible_crtcs)
+		hibmc_dp_uninit(priv);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 6b566f3aeecb..aa79903fe022 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 
 #include <drm/drm_framebuffer.h>
+#include "dp/dp_kapi.h"
 
 struct hibmc_connector {
 	struct drm_connector base;
@@ -37,6 +38,7 @@ struct hibmc_drm_private {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct hibmc_connector connector;
+	struct hibmc_dp dp;
 };
 
 static inline struct hibmc_connector *to_hibmc_connector(struct drm_connector *connector)
@@ -59,4 +61,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv);
 
 int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_connector *connector);
 
+int hibmc_dp_init(struct hibmc_drm_private *priv);
+void hibmc_dp_uninit(struct hibmc_drm_private *priv);
+
 #endif
-- 
2.33.0


