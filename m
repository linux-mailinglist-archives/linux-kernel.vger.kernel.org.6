Return-Path: <linux-kernel+bounces-546693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF124A4FDB8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8AB18913DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B57522154B;
	Wed,  5 Mar 2025 11:34:31 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCACB241CB3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174470; cv=none; b=pt3n4ShTD/IvE9gAxwFLe0+dICJJuW48yOlAK8DZVX5DTk26mpIfFnlwx3JkNMqQJwFWTmH+TS8hVvpWUhYvsqgO4p/BMSc+xgplFYXz1sDLEZd2Xx+BEpDXeD8HL+6eUSnS4jk3g2lSZq9iTJnxB/w1dl9KOyE0yXxAbYYdD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174470; c=relaxed/simple;
	bh=sJJbTkoYUrP+tcjQZN9rIYyNt8qZ9abWaJwwkFCAngU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHcEBuk06onAKVJXALjFIaILFprvg+LCFcfy8ZdbehDb7obcVUMhK9dSXJyqCbePO9n82IAcwuILtWruR9UWEpb4BqWy0uUz9awTYsvo00V6+j2iJb28Eg8WCT/QeYWtjEN2Cld615X2KAJYCGwtvf3jeZiV88G+mhgGAsP7PcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z79Nj5dCCz21p1M;
	Wed,  5 Mar 2025 19:31:17 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 82FF41400D3;
	Wed,  5 Mar 2025 19:34:25 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 5 Mar 2025 19:34:24 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 drm-dp 6/8] drm/hisilicon/hibmc: Add colorbar-cfg feature and its debugfs file
Date: Wed, 5 Mar 2025 19:26:45 +0800
Message-ID: <20250305112647.2344438-7-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250305112647.2344438-1-shiyongbang@huawei.com>
References: <20250305112647.2344438-1-shiyongbang@huawei.com>
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

From: Baihan Li <libaihan@huawei.com>

DP controller can support generating a color bar signal over the
DisplayPort interface. This can be useful to check for possible DDR
or GPU problems, as the signal generator resides completely in the DP
block. Add debugfs file that controls colorbar generator.

echo: config the color bar register to display
cat: print the color bar configuration

Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v3 -> v4:
  - add comments in hibmc_control_write(), suggested by Dmitry Baryshkov.
v2 -> v3:
  - rewrite the commit log, suggested by Dmitry Baryshkov.
  - move colorbar debugfs entry to this patch, suggested by Dmitry Baryshkov.
  - change binary format to integer format, suggested by Dmitry Baryshkov.
v1 -> v2:
  - add colorbar introduction in commit, suggested by Dmitry Baryshkov.
  - splittting colorbar and debugfs in different patches, suggested by Dmitry Baryshkov.
  - deleting edid decoder and its debugfs, suggested by Dmitry Baryshkov.
  - using debugfs_init() callback, suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/Makefile      |   3 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  43 ++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  29 +++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |   3 +
 .../drm/hisilicon/hibmc/hibmc_drm_debugfs.c   | 104 ++++++++++++++++++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |   1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   2 +
 7 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
index 43de077d6769..1f65c683282f 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
-	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o dp/dp_serdes.o hibmc_drm_dp.o
+	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o dp/dp_serdes.o hibmc_drm_dp.o \
+	       hibmc_drm_debugfs.o
 
 obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index aa9354a996c9..ce7cb07815b2 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -226,3 +226,46 @@ int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode)
 
 	return 0;
 }
+
+static const struct hibmc_dp_color_raw g_rgb_raw[] = {
+	{CBAR_COLOR_BAR, 0x000, 0x000, 0x000},
+	{CBAR_WHITE,     0xfff, 0xfff, 0xfff},
+	{CBAR_RED,       0xfff, 0x000, 0x000},
+	{CBAR_ORANGE,    0xfff, 0x800, 0x000},
+	{CBAR_YELLOW,    0xfff, 0xfff, 0x000},
+	{CBAR_GREEN,     0x000, 0xfff, 0x000},
+	{CBAR_CYAN,      0x000, 0x800, 0x800},
+	{CBAR_BLUE,      0x000, 0x000, 0xfff},
+	{CBAR_PURPLE,    0x800, 0x000, 0x800},
+	{CBAR_BLACK,     0x000, 0x000, 0x000},
+};
+
+void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
+{
+	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
+	struct hibmc_dp_color_raw raw_data;
+
+	if (cfg->enable) {
+		hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(9),
+					 cfg->self_timing);
+		hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, GENMASK(8, 1),
+					 cfg->dynamic_rate);
+		if (cfg->pattern == CBAR_COLOR_BAR) {
+			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(10), 0);
+		} else {
+			raw_data = g_rgb_raw[cfg->pattern];
+			drm_dbg_dp(dp->drm_dev, "r:%x g:%x b:%x\n", raw_data.r_value,
+				   raw_data.g_value, raw_data.b_value);
+			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(10), 1);
+			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, GENMASK(23, 12),
+						 raw_data.r_value);
+			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL1, GENMASK(23, 12),
+						 raw_data.g_value);
+			hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL1, GENMASK(11, 0),
+						 raw_data.b_value);
+		}
+	}
+
+	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(0), cfg->enable);
+	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 53b6d0beecea..83a53dae8012 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -14,6 +14,33 @@
 
 struct hibmc_dp_dev;
 
+enum hibmc_dp_cbar_pattern {
+	CBAR_COLOR_BAR,
+	CBAR_WHITE,
+	CBAR_RED,
+	CBAR_ORANGE,
+	CBAR_YELLOW,
+	CBAR_GREEN,
+	CBAR_CYAN,
+	CBAR_BLUE,
+	CBAR_PURPLE,
+	CBAR_BLACK,
+};
+
+struct hibmc_dp_color_raw {
+	enum hibmc_dp_cbar_pattern pattern;
+	u32 r_value;
+	u32 g_value;
+	u32 b_value;
+};
+
+struct hibmc_dp_cbar_cfg {
+	u8 enable;
+	u8 self_timing;
+	u8 dynamic_rate; /* 0:static, 1-255(frame):dynamic */
+	enum hibmc_dp_cbar_pattern pattern;
+};
+
 struct hibmc_dp {
 	struct hibmc_dp_dev *dp_dev;
 	struct drm_device *drm_dev;
@@ -21,10 +48,12 @@ struct hibmc_dp {
 	struct drm_connector connector;
 	void __iomem *mmio;
 	struct drm_dp_aux aux;
+	struct hibmc_dp_cbar_cfg cfg;
 };
 
 int hibmc_dp_hw_init(struct hibmc_dp *dp);
 int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode);
 void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable);
+void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
index aa6ac951af67..4a31334f0420 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
@@ -67,6 +67,9 @@
 #define HIBMC_DP_CFG_STREAM_HTOTAL_SIZE		GENMASK(31, 16)
 #define HIBMC_DP_CFG_STREAM_HBLANK_SIZE		GENMASK(15, 0)
 
+#define HIBMC_DP_COLOR_BAR_CTRL			0x260
+#define HIBMC_DP_COLOR_BAR_CTRL1		0x264
+
 #define HIBMC_DP_TIMING_GEN_CONFIG0		0x26c
 #define HIBMC_DP_CFG_TIMING_GEN0_HACTIVE	GENMASK(31, 16)
 #define HIBMC_DP_CFG_TIMING_GEN0_HBLANK		GENMASK(15, 0)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
new file mode 100644
index 000000000000..f585387c3a49
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_debugfs.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/seq_file.h>
+#include <linux/pci.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_debugfs.h>
+#include <drm/drm_edid.h>
+
+#include "hibmc_drm_drv.h"
+
+#define MAX_BUF_SIZE 12
+
+static ssize_t hibmc_control_write(struct file *file, const char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct hibmc_drm_private *priv = file_inode(file)->i_private;
+	struct hibmc_dp_cbar_cfg *cfg = &priv->dp.cfg;
+	int ret, idx;
+	u8 buf[MAX_BUF_SIZE];
+
+	if (count >= MAX_BUF_SIZE)
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	buf[count] = '\0';
+
+	/* Only 4 parameters is allowed, the ranger are as follow:
+	 * [0] enable/disable colorbar feature
+	       0: enable colorbar, 1: disable colorbar
+	 * [1] the timing source of colorbar displaying
+	       0: timing follows XDP, 1: internal self timing
+	 * [2] the movment of colorbar displaying
+	       0: static colorbar image,
+	 *     1~255: right shifting a type of color per (1~255)frames
+	 * [3] the color type of colorbar displaying
+	       0~9: color bar, white, red, orange,
+	 *          yellow, green, cyan, bule, pupper, black
+	 */
+	if (sscanf(buf, "%hhu %hhu %hhu %u", &cfg->enable, &cfg->self_timing,
+		   &cfg->dynamic_rate, &cfg->pattern) != 4) {
+		return -EINVAL;
+	}
+
+	if (cfg->pattern > 9 || cfg->enable > 1 || cfg->self_timing > 1)
+		return -EINVAL;
+
+	ret = drm_dev_enter(&priv->dev, &idx);
+	if (!ret)
+		return -ENODEV;
+
+	hibmc_dp_set_cbar(&priv->dp, cfg);
+
+	drm_dev_exit(idx);
+
+	return count;
+}
+
+static int hibmc_dp_dbgfs_show(struct seq_file *m, void *arg)
+{
+	struct hibmc_drm_private *priv = m->private;
+	struct hibmc_dp_cbar_cfg *cfg = &priv->dp.cfg;
+	int idx;
+
+	if (!drm_dev_enter(&priv->dev, &idx))
+		return -ENODEV;
+
+	seq_printf(m, "hibmc dp colorbar cfg: %u %u %u %u\n", cfg->enable, cfg->self_timing,
+		   cfg->dynamic_rate, cfg->pattern);
+
+	drm_dev_exit(idx);
+
+	return 0;
+}
+
+static int hibmc_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, hibmc_dp_dbgfs_show, inode->i_private);
+}
+
+static const struct file_operations hibmc_dbg_fops = {
+	.owner   = THIS_MODULE,
+	.write   = hibmc_control_write,
+	.read    = seq_read,
+	.open    = hibmc_open,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
+void hibmc_debugfs_init(struct drm_connector *connector, struct dentry *root)
+{
+	struct drm_device *dev = connector->dev;
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
+
+	/* create the file in drm directory, so we don't need to remove manually */
+	debugfs_create_file("colorbar-cfg", 0200,
+			    root, priv, &hibmc_dbg_fops);
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 1cb9c32f9ef0..a7f611e82f73 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -57,6 +57,7 @@ static const struct drm_connector_funcs hibmc_dp_conn_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.late_register = hibmc_dp_late_register,
 	.early_unregister = hibmc_dp_early_unregister,
+	.debugfs_init = hibmc_debugfs_init,
 };
 
 static inline int hibmc_dp_prepare(struct hibmc_dp *dp, struct drm_display_mode *mode)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 3ddd71aada66..bc89e4b9f4e3 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -69,4 +69,6 @@ int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *connector);
 
 int hibmc_dp_init(struct hibmc_drm_private *priv);
 
+void hibmc_debugfs_init(struct drm_connector *connector, struct dentry *root);
+
 #endif
-- 
2.33.0


