Return-Path: <linux-kernel+bounces-553535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC46A58B21
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 05:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCA8169FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 04:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87791C6FE9;
	Mon, 10 Mar 2025 04:09:26 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1756B35976
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741579766; cv=none; b=Tbcke5fYsRtExBmgPYM8COTO0rwtnnY2eoUH0uDcD4qX0q4B7hF3gNF4yScbN02paNF5Xsz3RtMQsnCuvfVW8KYmy5CLomvo1aOu8IP0HA2aTbu67nLMaJG3aA+bMn2hXsx7jqY2Q77lWl3oasKA/rNUAB1kCjUycxqBsPeav7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741579766; c=relaxed/simple;
	bh=YYcGCDzQb+lLsNYpVJJ6m08lXSRgYYCJ3obciHLLO4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGUfcEZvpxFPvl51BkYp+irsoETW5vUDea3/4pwk6p64n4FnM+AUaNwa+MwEgYNdwqOLSBijpoyZYHObxMUO3IsYiTrNq5hg/HwBXLw4BW7AD2K6ruPiwBOMsr06ud3jDCKqmG1PxQ4cQy32eUun4dNwFCnSdgCzeA8VBklGnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZB3FP1BNNz2SSpl;
	Mon, 10 Mar 2025 12:04:57 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id CA1D31401F0;
	Mon, 10 Mar 2025 12:09:15 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Mar 2025 12:09:14 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 drm-dp 2/9] drm/hisilicon/hibmc: Add dp serdes cfg to adjust serdes rate, voltage and pre-emphasis
Date: Mon, 10 Mar 2025 12:01:31 +0800
Message-ID: <20250310040138.2025715-3-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250310040138.2025715-1-shiyongbang@huawei.com>
References: <20250310040138.2025715-1-shiyongbang@huawei.com>
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

This dp controller need features of digital-to-analog conversion and
high-speed transmission in chip by its extern serdes controller. Our
serdes cfg is relatively simple, just need two register configurations.
Don't need too much functions, like: power on/off, initialize, and some
complex configurations, so I'm not going to use the phy framework.
This serdes is inited and configured in dp initialization, and also
integrating them into link training process.

For rate changing, we can change from 1.62-8.2Gpbs by cfg reg.
For voltage and pre-emphasis levels changing, we can cfg different
serdes ffe value.

Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
ChangeLog:
v5 -> v6:
  - fix the DP_SERDES_VOL2_PRE0 value after electrical test.
v3 -> v4:
  - fix the serdes cfg in hibmc_dp_serdes_set_tx_cfg(), suggested by Dmitry Baryshkov.
  - move the dp serdes registers to dp_reg.h, suggested by Dmitry Baryshkov.
  - 
v2 -> v3:
  - add commit log about dp serdes, suggested by Dmitry Baryshkov.
  - return value in hibmc_dp_serdes_init(), suggested by Dmitry Baryshkov.
  - add static const in the array of serdes_tx_cfg[], suggested by Dmitry Baryshkov.
  - change drm_warn to drm_dbg_dp, suggested by Dmitry Baryshkov.
  - add explanations about dp serdes macros, suggested by Dmitry Baryshkov.
v1 -> v2:
  - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
  - changing all names of dp phy to dp serdes.
---
 drivers/gpu/drm/hisilicon/hibmc/Makefile      |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  5 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   | 23 ++++++
 .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    | 71 +++++++++++++++++++
 5 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
index 95a4ed599d98..43de077d6769 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
-	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o hibmc_drm_dp.o
+	       dp/dp_aux.o dp/dp_link.o dp/dp_hw.o dp/dp_serdes.o hibmc_drm_dp.o
 
 obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
index 2c52a4476c4d..e0c6a3b7463b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
@@ -38,6 +38,7 @@ struct hibmc_dp_dev {
 	struct mutex lock; /* protects concurrent RW in hibmc_dp_reg_write_field() */
 	struct hibmc_dp_link link;
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	void __iomem *serdes_base;
 };
 
 #define dp_field_modify(reg_value, mask, val)				\
@@ -59,5 +60,8 @@ struct hibmc_dp_dev {
 
 void hibmc_dp_aux_init(struct hibmc_dp_dev *dp);
 int hibmc_dp_link_training(struct hibmc_dp_dev *dp);
+int hibmc_dp_serdes_init(struct hibmc_dp_dev *dp);
+int hibmc_dp_serdes_rate_switch(u8 rate, struct hibmc_dp_dev *dp);
+int hibmc_dp_serdes_set_tx_cfg(struct hibmc_dp_dev *dp, u8 train_set[HIBMC_DP_LANE_NUM_MAX]);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index a8d543881c09..3612f3c5ab23 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -151,6 +151,7 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
 {
 	struct drm_device *drm_dev = dp->drm_dev;
 	struct hibmc_dp_dev *dp_dev;
+	int ret;
 
 	dp_dev = devm_kzalloc(drm_dev->dev, sizeof(struct hibmc_dp_dev), GFP_KERNEL);
 	if (!dp_dev)
@@ -165,6 +166,10 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
 
 	hibmc_dp_aux_init(dp_dev);
 
+	ret = hibmc_dp_serdes_init(dp_dev);
+	if (ret)
+		return ret;
+
 	dp_dev->link.cap.lanes = 0x2;
 	dp_dev->link.cap.link_rate = DP_LINK_BW_2_7;
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
index dc2bd3f80b70..16ea58903598 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
@@ -95,4 +95,27 @@
 
 #define HIBMC_DP_TIMING_SYNC_CTRL		0xFF0
 
+/* dp serdes reg */
+#define HIBMC_DP_HOST_OFFSET		0x10000
+#define HIBMC_DP_LANE0_RATE_OFFSET	0x4
+#define HIBMC_DP_LANE1_RATE_OFFSET	0xc
+#define HIBMC_DP_LANE_STATUS_OFFSET	0x10
+#define HIBMC_DP_PMA_LANE0_OFFSET	0x18
+#define HIBMC_DP_PMA_LANE1_OFFSET	0x1c
+#define HIBMC_DP_PMA_TXDEEMPH		GENMASK(18, 1)
+#define DP_SERDES_DONE			0x3
+
+/* dp serdes TX-Deempth Configuration */
+#define DP_SERDES_VOL0_PRE0		0x280
+#define DP_SERDES_VOL0_PRE1		0x2300
+#define DP_SERDES_VOL0_PRE2		0x53c0
+#define DP_SERDES_VOL0_PRE3		0x8400
+#define DP_SERDES_VOL1_PRE0		0x380
+#define DP_SERDES_VOL1_PRE1		0x3440
+#define DP_SERDES_VOL1_PRE2		0x6480
+#define DP_SERDES_VOL2_PRE0		0x4c1
+#define DP_SERDES_VOL2_PRE1		0x4500
+#define DP_SERDES_VOL3_PRE0		0x600
+#define DP_SERDES_BW_8_1		0x3
+
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
new file mode 100644
index 000000000000..676059d4c1e6
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2025 Hisilicon Limited.
+
+#include <linux/delay.h>
+#include <drm/drm_device.h>
+#include <drm/drm_print.h>
+#include "dp_comm.h"
+#include "dp_config.h"
+#include "dp_reg.h"
+
+int hibmc_dp_serdes_set_tx_cfg(struct hibmc_dp_dev *dp, u8 train_set[HIBMC_DP_LANE_NUM_MAX])
+{
+	static const u32 serdes_tx_cfg[4][4] = { {DP_SERDES_VOL0_PRE0, DP_SERDES_VOL0_PRE1,
+						  DP_SERDES_VOL0_PRE2, DP_SERDES_VOL0_PRE3},
+						 {DP_SERDES_VOL1_PRE0, DP_SERDES_VOL1_PRE1,
+						  DP_SERDES_VOL1_PRE2}, {DP_SERDES_VOL2_PRE0,
+						  DP_SERDES_VOL2_PRE1}, {DP_SERDES_VOL3_PRE0}};
+	int cfg[2];
+	int i;
+
+	for (i = 0; i < HIBMC_DP_LANE_NUM_MAX; i++) {
+		cfg[i] = serdes_tx_cfg[FIELD_GET(DP_TRAIN_VOLTAGE_SWING_MASK, train_set[i])]
+				      [FIELD_GET(DP_TRAIN_PRE_EMPHASIS_MASK, train_set[i])];
+		if (!cfg[i])
+			return -EINVAL;
+
+		/* lane1 offset is 4 */
+		writel(FIELD_PREP(HIBMC_DP_PMA_TXDEEMPH, cfg[i]),
+		       dp->serdes_base + HIBMC_DP_PMA_LANE0_OFFSET + i * 4);
+	}
+
+	usleep_range(300, 500);
+
+	if (readl(dp->serdes_base + HIBMC_DP_LANE_STATUS_OFFSET) != DP_SERDES_DONE) {
+		drm_dbg_dp(dp->dev, "dp serdes cfg failed\n");
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+int hibmc_dp_serdes_rate_switch(u8 rate, struct hibmc_dp_dev *dp)
+{
+	writel(rate, dp->serdes_base + HIBMC_DP_LANE0_RATE_OFFSET);
+	writel(rate, dp->serdes_base + HIBMC_DP_LANE1_RATE_OFFSET);
+
+	usleep_range(300, 500);
+
+	if (readl(dp->serdes_base + HIBMC_DP_LANE_STATUS_OFFSET) != DP_SERDES_DONE) {
+		drm_dbg_dp(dp->dev, "dp serdes rate switching failed\n");
+		return -EAGAIN;
+	}
+
+	if (rate < DP_SERDES_BW_8_1)
+		drm_dbg_dp(dp->dev, "reducing serdes rate to :%d\n",
+			   rate ? rate * HIBMC_DP_LINK_RATE_CAL * 10 : 162);
+
+	return 0;
+}
+
+int hibmc_dp_serdes_init(struct hibmc_dp_dev *dp)
+{
+	dp->serdes_base = dp->base + HIBMC_DP_HOST_OFFSET;
+
+	writel(FIELD_PREP(HIBMC_DP_PMA_TXDEEMPH, DP_SERDES_VOL0_PRE0),
+	       dp->serdes_base + HIBMC_DP_PMA_LANE0_OFFSET);
+	writel(FIELD_PREP(HIBMC_DP_PMA_TXDEEMPH, DP_SERDES_VOL0_PRE0),
+	       dp->serdes_base + HIBMC_DP_PMA_LANE1_OFFSET);
+
+	return hibmc_dp_serdes_rate_switch(DP_SERDES_BW_8_1, dp);
+}
-- 
2.33.0


