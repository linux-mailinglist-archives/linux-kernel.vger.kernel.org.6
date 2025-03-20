Return-Path: <linux-kernel+bounces-569480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8EDA6A393
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434D38A31BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1DE22422D;
	Thu, 20 Mar 2025 10:22:56 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626C224B0D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466175; cv=none; b=rkmDwk8k5V/xysuNk4nJfy9+8q9zAxDw8qYiU+sblXzuaDMrx2AVEynW7jv7Kl4hxCq7aeyEfTI1toaXIOceqkSCbOQR5JWT4kwMq2Oz7CaSA+Hs0Nec2JsysLpzzH5niIDpsMKfmFgujhWqzHEVqv5T20NSbX1yhjfP816onrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466175; c=relaxed/simple;
	bh=C0UaHSvNIqvfh2MYS0J8HQ1rSvOxLRYbCNcJoOu5WKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDagWkeMpLPeUSm9IpD1vReSbnm9tVTqAiVzTBfyqcAIM1COcnuo1jnFEo71Yj/RIb5P2Hhl/ksadH9n4NUpNPEX0vDeiScoBvK7R75XNlc/oxNGeujiIayVa6eIgt9nE/W7YBhyRhYrDJbLfB89MyokW8oaY2LRuYhAYRM4+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZJM3S6rdhz1f1PY;
	Thu, 20 Mar 2025 18:18:12 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CF2F18005F;
	Thu, 20 Mar 2025 18:22:45 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 20 Mar 2025 18:22:43 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<jani.nikula@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 drm-dp 3/9] drm/hisilicon/hibmc: Add dp serdes cfg in dp process
Date: Thu, 20 Mar 2025 18:14:49 +0800
Message-ID: <20250320101455.2538835-4-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250320101455.2538835-1-shiyongbang@huawei.com>
References: <20250320101455.2538835-1-shiyongbang@huawei.com>
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

From: Baihan Li <libaihan@huawei.com>

Add dp serdes cfg in link training process, and related adapting
and modificating. Change some init values about training, because we want
completely to negotiation process, so we start with the maximum rate and
the electrical characteristic level is 0. Because serdes default cfgs is
changed and used in hibmc_kms_init(), we changed the if-statement to check
whether the value is 0.

Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
ChangeLog:
v4 -> v5:
  - add commit log about hibmc_kms_init(), suggested by Dmitry Baryshkov.
  - fix the format of block comments, suggested by Dmitry Baryshkov.
  - add hibmc_dp_get_serdes_rate_cfg() to correct transferring serdes cfg.
v3 -> v4:
  - add comments for if-statement of dp_init(), suggested by Dmitry Baryshkov.
v2 -> v3:
  - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
  - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
v1 -> v2:
  - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
---
 .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  1 +
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  5 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 77 ++++++++++++++-----
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  5 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 13 ++--
 5 files changed, 75 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
index 74dd9956144e..c5feef8dc27d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
@@ -15,5 +15,6 @@
 #define HIBMC_DP_CLK_EN			0x7
 #define HIBMC_DP_SYNC_EN_MASK		0x3
 #define HIBMC_DP_LINK_RATE_CAL		27
+#define HIBMC_DP_SYNC_DELAY(lanes)	((lanes) == 0x2 ? 86 : 46)
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index 3612f3c5ab23..dcb2ab5ea6bb 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -72,6 +72,9 @@ static void hibmc_dp_set_sst(struct hibmc_dp_dev *dp, struct drm_display_mode *m
 				 HIBMC_DP_CFG_STREAM_HTOTAL_SIZE, htotal_size);
 	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_HORIZONTAL_SIZE,
 				 HIBMC_DP_CFG_STREAM_HBLANK_SIZE, hblank_size);
+	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_PACKET,
+				 HIBMC_DP_CFG_STREAM_SYNC_CALIBRATION,
+				 HIBMC_DP_SYNC_DELAY(dp->link.cap.lanes));
 }
 
 static void hibmc_dp_link_cfg(struct hibmc_dp_dev *dp, struct drm_display_mode *mode)
@@ -171,7 +174,7 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
 		return ret;
 
 	dp_dev->link.cap.lanes = 0x2;
-	dp_dev->link.cap.link_rate = DP_LINK_BW_2_7;
+	dp_dev->link.cap.link_rate = DP_LINK_BW_8_1;
 
 	/* hdcp data */
 	writel(HIBMC_DP_HDCP, dp_dev->base + HIBMC_DP_HDCP_CFG);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
index f6355c16cc0a..2b4940ea809c 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
@@ -9,6 +9,22 @@
 
 #define HIBMC_EQ_MAX_RETRY 5
 
+static inline int hibmc_dp_get_serdes_rate_cfg(struct hibmc_dp_dev *dp)
+{
+	switch (dp->link.cap.link_rate) {
+	case DP_LINK_BW_1_62:
+		return DP_SERDES_BW_1_62;
+	case DP_LINK_BW_2_7:
+		return DP_SERDES_BW_2_7;
+	case DP_LINK_BW_5_4:
+		return DP_SERDES_BW_5_4;
+	case DP_LINK_BW_8_1:
+		return DP_SERDES_BW_8_1;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int hibmc_dp_link_training_configure(struct hibmc_dp_dev *dp)
 {
 	u8 buf[2];
@@ -41,11 +57,7 @@ static int hibmc_dp_link_training_configure(struct hibmc_dp_dev *dp)
 		return ret >= 0 ? -EIO : ret;
 	}
 
-	ret = drm_dp_read_dpcd_caps(&dp->aux, dp->dpcd);
-	if (ret)
-		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
-
-	return ret;
+	return 0;
 }
 
 static int hibmc_dp_link_set_pattern(struct hibmc_dp_dev *dp, int pattern)
@@ -108,7 +120,11 @@ static int hibmc_dp_link_training_cr_pre(struct hibmc_dp_dev *dp)
 		return ret;
 
 	for (i = 0; i < dp->link.cap.lanes; i++)
-		train_set[i] = DP_TRAIN_VOLTAGE_SWING_LEVEL_2;
+		train_set[i] = DP_TRAIN_VOLTAGE_SWING_LEVEL_0;
+
+	ret = hibmc_dp_serdes_set_tx_cfg(dp, dp->link.train_set);
+	if (ret)
+		return ret;
 
 	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, train_set, dp->link.cap.lanes);
 	if (ret != dp->link.cap.lanes) {
@@ -137,21 +153,18 @@ static bool hibmc_dp_link_get_adjust_train(struct hibmc_dp_dev *dp,
 	return false;
 }
 
-static inline int hibmc_dp_link_reduce_rate(struct hibmc_dp_dev *dp)
+static int hibmc_dp_link_reduce_rate(struct hibmc_dp_dev *dp)
 {
-	switch (dp->link.cap.link_rate) {
-	case DP_LINK_BW_2_7:
-		dp->link.cap.link_rate = DP_LINK_BW_1_62;
-		return 0;
-	case DP_LINK_BW_5_4:
-		dp->link.cap.link_rate = DP_LINK_BW_2_7;
-		return 0;
-	case DP_LINK_BW_8_1:
-		dp->link.cap.link_rate = DP_LINK_BW_5_4;
-		return 0;
-	default:
+	int ret;
+
+	if (dp->link.cap.link_rate == DP_LINK_BW_1_62)
 		return -EINVAL;
-	}
+
+	ret = hibmc_dp_get_serdes_rate_cfg(dp);
+	if (ret < 0)
+		return ret;
+
+	return hibmc_dp_serdes_rate_switch(--ret, dp);
 }
 
 static inline int hibmc_dp_link_reduce_lane(struct hibmc_dp_dev *dp)
@@ -159,6 +172,7 @@ static inline int hibmc_dp_link_reduce_lane(struct hibmc_dp_dev *dp)
 	switch (dp->link.cap.lanes) {
 	case 0x2:
 		dp->link.cap.lanes--;
+		drm_dbg_dp(dp->dev, "dp link training reduce to 1 lane\n");
 		break;
 	case 0x1:
 		drm_err(dp->dev, "dp link training reduce lane failed, already reach minimum\n");
@@ -206,6 +220,11 @@ static int hibmc_dp_link_training_cr(struct hibmc_dp_dev *dp)
 		}
 
 		level_changed = hibmc_dp_link_get_adjust_train(dp, lane_status);
+
+		ret = hibmc_dp_serdes_set_tx_cfg(dp, dp->link.train_set);
+		if (ret)
+			return ret;
+
 		ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, dp->link.train_set,
 					dp->link.cap.lanes);
 		if (ret != dp->link.cap.lanes) {
@@ -255,6 +274,11 @@ static int hibmc_dp_link_training_channel_eq(struct hibmc_dp_dev *dp)
 		}
 
 		hibmc_dp_link_get_adjust_train(dp, lane_status);
+
+		ret = hibmc_dp_serdes_set_tx_cfg(dp, dp->link.train_set);
+		if (ret)
+			return ret;
+
 		ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET,
 					dp->link.train_set, dp->link.cap.lanes);
 		if (ret != dp->link.cap.lanes) {
@@ -295,6 +319,21 @@ int hibmc_dp_link_training(struct hibmc_dp_dev *dp)
 	struct hibmc_dp_link *link = &dp->link;
 	int ret;
 
+	ret = drm_dp_read_dpcd_caps(&dp->aux, dp->dpcd);
+	if (ret)
+		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
+
+	dp->link.cap.link_rate = dp->dpcd[DP_MAX_LINK_RATE];
+	dp->link.cap.lanes = 0x2;
+
+	ret = hibmc_dp_get_serdes_rate_cfg(dp);
+	if (ret < 0)
+		return ret;
+
+	ret = hibmc_dp_serdes_rate_switch(ret, dp);
+	if (ret)
+		return ret;
+
 	while (true) {
 		ret = hibmc_dp_link_training_cr_pre(dp);
 		if (ret)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
index 16ea58903598..6eb76decc636 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
@@ -54,6 +54,7 @@
 #define HIBMC_DP_VIDEO_PACKET			0x114
 #define HIBMC_DP_CFG_STREAM_TU_SYMBOL_SIZE	GENMASK(5, 0)
 #define HIBMC_DP_CFG_STREAM_TU_SYMBOL_FRAC_SIZE	GENMASK(9, 6)
+#define HIBMC_DP_CFG_STREAM_SYNC_CALIBRATION	GENMASK(31, 20)
 
 #define HIBMC_DP_VIDEO_MSA0			0x118
 #define HIBMC_DP_CFG_STREAM_VSTART		GENMASK(31, 16)
@@ -102,6 +103,7 @@
 #define HIBMC_DP_LANE_STATUS_OFFSET	0x10
 #define HIBMC_DP_PMA_LANE0_OFFSET	0x18
 #define HIBMC_DP_PMA_LANE1_OFFSET	0x1c
+#define HIBMC_DP_HOST_SERDES_CTRL	0x1f001c
 #define HIBMC_DP_PMA_TXDEEMPH		GENMASK(18, 1)
 #define DP_SERDES_DONE			0x3
 
@@ -117,5 +119,8 @@
 #define DP_SERDES_VOL2_PRE1		0x4500
 #define DP_SERDES_VOL3_PRE0		0x600
 #define DP_SERDES_BW_8_1		0x3
+#define DP_SERDES_BW_5_4		0x2
+#define DP_SERDES_BW_2_7		0x1
+#define DP_SERDES_BW_1_62		0x0
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index e6de6d5edf6b..98b01c8aee8e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -28,9 +28,7 @@
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
 
-#define HIBMC_DP_HOST_SERDES_CTRL		0x1f001c
-#define HIBMC_DP_HOST_SERDES_CTRL_VAL		0x8a00
-#define HIBMC_DP_HOST_SERDES_CTRL_MASK		0x7ffff
+#include "dp/dp_reg.h"
 
 DEFINE_DRM_GEM_FOPS(hibmc_fops);
 
@@ -121,9 +119,12 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 		return ret;
 	}
 
-	/* if DP existed, init DP */
-	if ((readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL) &
-	     HIBMC_DP_HOST_SERDES_CTRL_MASK) == HIBMC_DP_HOST_SERDES_CTRL_VAL) {
+	/*
+	 * If the serdes reg is readable and is not equal to 0,
+	 * DP block exists and initializes it.
+	 */
+	ret = readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL);
+	if (ret) {
 		ret = hibmc_dp_init(priv);
 		if (ret)
 			drm_err(dev, "failed to init dp: %d\n", ret);
-- 
2.33.0


