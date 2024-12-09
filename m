Return-Path: <linux-kernel+bounces-437850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01389E998D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EBB164834
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F591E9B23;
	Mon,  9 Dec 2024 14:54:53 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520A81C5CAC
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756092; cv=none; b=LRglmJDA+18imfAtC32GgGjEgR4otj65As0YnNoy+kklg/CwUe1bMojKzBPZIsHiUiIMlLGYpI3B6ODr7A+D+7OKZaOWJvYOMC0PvAa3G/HIFOrZbP6e5HZI1N1Zb8rLpUaUta8YhcSjz00A6e0kFpvU4PmGV3P1rADOcIvh7+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756092; c=relaxed/simple;
	bh=VIGfiTyBK1JhCJJli5SzvKil2/VIbuuoF9RGVTMBRa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=km3B+WrUzfXCbieEe7idWVc4gtseHaTg1WlUJH6zmNnPir+RQFp/rDCWecl66UfVr+QK/T5ARRR0VLH/PlNiNuNn5FtAzo4yt81GA+m9A8Uraej2TsfS94qPf/3js099/mggxAZ9eh+/g1Bt6Uca8UO6QL5X4yYvQqn26+6YJpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y6PxF079nzRj5W;
	Mon,  9 Dec 2024 22:53:05 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 209B0180064;
	Mon,  9 Dec 2024 22:54:48 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 9 Dec 2024 22:54:46 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 drm-dp 5/5] drm/hisilicon/hibmc: add dp module in hibmc
Date: Mon, 9 Dec 2024 22:48:40 +0800
Message-ID: <20241209144840.1933265-6-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241209144840.1933265-1-shiyongbang@huawei.com>
References: <20241209144840.1933265-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500013.china.huawei.com (7.221.188.12)

From: baihan li <libaihan@huawei.com>

To support DP interface displaying in hibmc driver. Add
a encoder and connector for DP modual. The HPD function
and get_edid function will be add in next series, so temporarily
using 1024x768 as default in hibmc_dp_connector_get_modes()

Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
ChangeLog:
v6 -> v7:
  - lowercasing hex, suggested by Dmitry Baryshkov.
v5 -> v6:
  - adding hpd and get_edid comments in the beginning of patch, suggested by Dmitry Baryshkov.
v3 -> v4:
  - static inline hibmc_dp_prepare(), suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/Makefile      |   2 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 118 ++++++++++++++++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  12 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
 4 files changed, 136 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
index 214228052ccf..95a4ed599d98 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
-	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o
+	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o hibmc_drm_dp.o
 
 obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
new file mode 100644
index 000000000000..603d6b198a54
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/io.h>
+
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_edid.h>
+
+#include "hibmc_drm_drv.h"
+#include "dp/dp_hw.h"
+
+static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
+{
+	int count;
+
+	count = drm_add_modes_noedid(connector, connector->dev->mode_config.max_width,
+				     connector->dev->mode_config.max_height);
+	drm_set_preferred_mode(connector, 1024, 768); // temporary implementation
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
+static inline int hibmc_dp_prepare(struct hibmc_dp *dp, struct drm_display_mode *mode)
+{
+	int ret;
+
+	hibmc_dp_display_en(dp, false);
+
+	ret = hibmc_dp_mode_set(dp, mode);
+	if (ret)
+		drm_err(dp->drm_dev, "hibmc dp mode set failed: %d\n", ret);
+
+	return ret;
+}
+
+static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
+				    struct drm_atomic_state *state)
+{
+	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
+	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
+
+	if (hibmc_dp_prepare(dp, mode))
+		return;
+
+	hibmc_dp_display_en(dp, true);
+}
+
+static void hibmc_dp_encoder_disable(struct drm_encoder *drm_encoder,
+				     struct drm_atomic_state *state)
+{
+	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
+
+	hibmc_dp_display_en(dp, false);
+}
+
+static const struct drm_encoder_helper_funcs hibmc_dp_encoder_helper_funcs = {
+	.atomic_enable = hibmc_dp_encoder_enable,
+	.atomic_disable = hibmc_dp_encoder_disable,
+};
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
+	ret = hibmc_dp_hw_init(&priv->dp);
+	if (ret) {
+		drm_err(dev, "hibmc dp hw init failed: %d\n", ret);
+		return ret;
+	}
+
+	hibmc_dp_display_en(&priv->dp, false);
+
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+	ret = drmm_encoder_init(dev, encoder, NULL, DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret) {
+		drm_err(dev, "init dp encoder failed: %d\n", ret);
+		return ret;
+	}
+
+	drm_encoder_helper_add(encoder, &hibmc_dp_encoder_helper_funcs);
+
+	ret = drm_connector_init(dev, connector, &hibmc_dp_conn_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	if (ret) {
+		drm_err(dev, "init dp connector failed: %d\n", ret);
+		return ret;
+	}
+
+	drm_connector_helper_add(connector, &hibmc_dp_conn_helper_funcs);
+
+	drm_connector_attach_encoder(connector, encoder);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 8c488c98ac97..91894a124bde 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -28,6 +28,10 @@
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
 
+#define HIBMC_DP_HOST_SERDES_CTRL		0x1f001c
+#define HIBMC_DP_HOST_SERDES_CTRL_VAL		0x8a00
+#define HIBMC_DP_HOST_SERDES_CTRL_MASK		0x7ffff
+
 DEFINE_DRM_GEM_FOPS(hibmc_fops);
 
 static irqreturn_t hibmc_interrupt(int irq, void *arg)
@@ -118,6 +122,14 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 		return ret;
 	}
 
+	/* if DP existed, init DP */
+	if ((readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL) &
+	     HIBMC_DP_HOST_SERDES_CTRL_MASK) == HIBMC_DP_HOST_SERDES_CTRL_VAL) {
+		ret = hibmc_dp_init(priv);
+		if (ret)
+			drm_err(dev, "failed to init dp: %d\n", ret);
+	}
+
 	ret = hibmc_vdac_init(priv);
 	if (ret) {
 		drm_err(dev, "failed to init vdac: %d\n", ret);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 42f0ab8f9b5a..d982f1e4b958 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -20,6 +20,8 @@
 
 #include <drm/drm_framebuffer.h>
 
+#include "dp/dp_hw.h"
+
 struct hibmc_vdac {
 	struct drm_device *dev;
 	struct drm_encoder encoder;
@@ -37,6 +39,7 @@ struct hibmc_drm_private {
 	struct drm_plane primary_plane;
 	struct drm_crtc crtc;
 	struct hibmc_vdac vdac;
+	struct hibmc_dp dp;
 };
 
 static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
@@ -59,4 +62,6 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv);
 
 int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *connector);
 
+int hibmc_dp_init(struct hibmc_drm_private *priv);
+
 #endif
-- 
2.33.0


