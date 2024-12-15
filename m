Return-Path: <linux-kernel+bounces-444312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBE09F049B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B42116A15B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3496418CC10;
	Fri, 13 Dec 2024 06:08:42 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD71632FA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070121; cv=none; b=Al4qsyUq4poLef0WOGGpxH8LXOEPQKSUhvtiIm1cm3H2lPBwM8INUxaT7zu54IshTVKg4vKQqjEHRtaED7xhQFyn9/jWK6ejCh6Q+GnNWq/7JQ9ZhNVbRsJnZmZeWWr5P6tUhJB5m6UW+DUn5gpUVltLcbdGJ1YHGAY2By0Y4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070121; c=relaxed/simple;
	bh=bB0y/oPbmRWNc6atJDmuj0IQoMyQk3QAhfz2KSOVXDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwAJfdBInBvLjtt80xOUDaB/nPfcIOcODJjMdEQ/TtgdY5C0NI9gBVByvjotFyaq03n0qzCmixqLce+p9aDGCnp+BvP+CncZT5Qaw+pvT9FxVR1+fP7M2pthpLawjojKAYaJlY77he/TSW2Zvma3xex1eGYMN9uQNCp4dnLgf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y8f3N02gLz1kvsK;
	Fri, 13 Dec 2024 14:06:08 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E2E951A0188;
	Fri, 13 Dec 2024 14:08:35 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 13 Dec 2024 14:08:34 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 drm-dp 2/5] drm/hisilicon/hibmc: add dp link moduel in hibmc drivers
Date: Fri, 13 Dec 2024 14:02:26 +0800
Message-ID: <20241213060229.1191037-3-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241213060229.1191037-1-shiyongbang@huawei.com>
References: <20241213060229.1191037-1-shiyongbang@huawei.com>
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

Add link training process functions in this moduel.

Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changelog:
v7 -> v8:
  - adding DP_AUX_NATIVE_WRITE case in switch statement in hibmc_dp_aux_parse_xfer().
v6 -> v7:
  - deleteing unset fields in struct hibmc_link_cap, suggested by Dmitry Baryshkov.
  - using macro instead of constants in hibmc_dp_link_training_configure(), suggested by Dmitry Baryshkov.
v5 -> v6:
  - using drm_dbg_dp() to print debug info instead of drm_info(), suggested by Dmitry Baryshkov.
v3 -> v4:
  - optimizing hibmc_dp_link_get_adjust_train() to delete for loop, suggested by Dmitry Baryshkov.
  - changing ELNRNG to EIO error code, suggested by Dmitry Baryshkov.
  - deleting meaningless macro, suggested by Dmitry Baryshkov.
  - fixing build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202411041559.WIfxRN6n-lkp@intel.com/
v2 -> v3:
  - using switchcase in dp_link_reduce_lane, suggested by Dmitry Baryshkov.
  - deleting dp_link_pattern2dpcd function and using macros directly, suggested by Dmitry Baryshkov.
  - deleting EFAULT error codes, suggested by Dmitry Baryshkov.
v1 -> v2:
  - using drm_dp_* functions implement dp link training process, suggested by Jani Nikula.
  - fix build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202410031735.8iRZZR6T-lkp@intel.com/
  v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
---
 drivers/gpu/drm/hisilicon/hibmc/Makefile     |   2 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h |  21 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 332 +++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h  |   8 +
 4 files changed, 362 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
index 8770ec6dfffd..94d77da88bbf 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
-	       dp/dp_aux.o
+	       dp/dp_aux.o dp/dp_link.o
 
 obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
index 7d3cd32393c0..2c52a4476c4d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
@@ -13,11 +13,31 @@
 #include <linux/io.h>
 #include <drm/display/drm_dp_helper.h>
 
+#define HIBMC_DP_LANE_NUM_MAX 2
+
+struct hibmc_link_status {
+	bool clock_recovered;
+	bool channel_equalized;
+};
+
+struct hibmc_link_cap {
+	u8 link_rate;
+	u8 lanes;
+};
+
+struct hibmc_dp_link {
+	struct hibmc_link_status status;
+	u8 train_set[HIBMC_DP_LANE_NUM_MAX];
+	struct hibmc_link_cap cap;
+};
+
 struct hibmc_dp_dev {
 	struct drm_dp_aux aux;
 	struct drm_device *dev;
 	void __iomem *base;
 	struct mutex lock; /* protects concurrent RW in hibmc_dp_reg_write_field() */
+	struct hibmc_dp_link link;
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 };
 
 #define dp_field_modify(reg_value, mask, val)				\
@@ -38,5 +58,6 @@ struct hibmc_dp_dev {
 	} while (0)
 
 void hibmc_dp_aux_init(struct hibmc_dp_dev *dp);
+int hibmc_dp_link_training(struct hibmc_dp_dev *dp);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
new file mode 100644
index 000000000000..f6355c16cc0a
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/delay.h>
+#include <drm/drm_device.h>
+#include <drm/drm_print.h>
+#include "dp_comm.h"
+#include "dp_reg.h"
+
+#define HIBMC_EQ_MAX_RETRY 5
+
+static int hibmc_dp_link_training_configure(struct hibmc_dp_dev *dp)
+{
+	u8 buf[2];
+	int ret;
+
+	/* DP 2 lane */
+	hibmc_dp_reg_write_field(dp, HIBMC_DP_PHYIF_CTRL0, HIBMC_DP_CFG_LANE_DATA_EN,
+				 dp->link.cap.lanes == 0x2 ? 0x3 : 0x1);
+	hibmc_dp_reg_write_field(dp, HIBMC_DP_DPTX_GCTL0, HIBMC_DP_CFG_PHY_LANE_NUM,
+				 dp->link.cap.lanes == 0x2 ? 0x1 : 0);
+
+	/* enhanced frame */
+	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_CTRL, HIBMC_DP_CFG_STREAM_FRAME_MODE, 0x1);
+
+	/* set rate and lane count */
+	buf[0] = dp->link.cap.link_rate;
+	buf[1] = DP_LANE_COUNT_ENHANCED_FRAME_EN | dp->link.cap.lanes;
+	ret = drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		drm_dbg_dp(dp->dev, "dp aux write link rate and lanes failed, ret: %d\n", ret);
+		return ret >= 0 ? -EIO : ret;
+	}
+
+	/* set 8b/10b and downspread */
+	buf[0] = DP_SPREAD_AMP_0_5;
+	buf[1] = DP_SET_ANSI_8B10B;
+	ret = drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		drm_dbg_dp(dp->dev, "dp aux write 8b/10b and downspread failed, ret: %d\n", ret);
+		return ret >= 0 ? -EIO : ret;
+	}
+
+	ret = drm_dp_read_dpcd_caps(&dp->aux, dp->dpcd);
+	if (ret)
+		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
+
+	return ret;
+}
+
+static int hibmc_dp_link_set_pattern(struct hibmc_dp_dev *dp, int pattern)
+{
+	int ret;
+	u8 val;
+	u8 buf;
+
+	buf = (u8)pattern;
+	if (pattern != DP_TRAINING_PATTERN_DISABLE && pattern != DP_TRAINING_PATTERN_4) {
+		buf |= DP_LINK_SCRAMBLING_DISABLE;
+		hibmc_dp_reg_write_field(dp, HIBMC_DP_PHYIF_CTRL0, HIBMC_DP_CFG_SCRAMBLE_EN, 0x1);
+	} else {
+		hibmc_dp_reg_write_field(dp, HIBMC_DP_PHYIF_CTRL0, HIBMC_DP_CFG_SCRAMBLE_EN, 0);
+	}
+
+	switch (pattern) {
+	case DP_TRAINING_PATTERN_DISABLE:
+		val = 0;
+		break;
+	case DP_TRAINING_PATTERN_1:
+		val = 1;
+		break;
+	case DP_TRAINING_PATTERN_2:
+		val = 2;
+		break;
+	case DP_TRAINING_PATTERN_3:
+		val = 3;
+		break;
+	case DP_TRAINING_PATTERN_4:
+		val = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	hibmc_dp_reg_write_field(dp, HIBMC_DP_PHYIF_CTRL0, HIBMC_DP_CFG_PAT_SEL, val);
+
+	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_PATTERN_SET, &buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		drm_dbg_dp(dp->dev, "dp aux write training pattern set failed\n");
+		return ret >= 0 ? -EIO : ret;
+	}
+
+	return 0;
+}
+
+static int hibmc_dp_link_training_cr_pre(struct hibmc_dp_dev *dp)
+{
+	u8 *train_set = dp->link.train_set;
+	int ret;
+	u8 i;
+
+	ret = hibmc_dp_link_training_configure(dp);
+	if (ret)
+		return ret;
+
+	ret = hibmc_dp_link_set_pattern(dp, DP_TRAINING_PATTERN_1);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < dp->link.cap.lanes; i++)
+		train_set[i] = DP_TRAIN_VOLTAGE_SWING_LEVEL_2;
+
+	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, train_set, dp->link.cap.lanes);
+	if (ret != dp->link.cap.lanes) {
+		drm_dbg_dp(dp->dev, "dp aux write training lane set failed\n");
+		return ret >= 0 ? -EIO : ret;
+	}
+
+	return 0;
+}
+
+static bool hibmc_dp_link_get_adjust_train(struct hibmc_dp_dev *dp,
+					   u8 lane_status[DP_LINK_STATUS_SIZE])
+{
+	u8 train_set[HIBMC_DP_LANE_NUM_MAX] = {0};
+	u8 lane;
+
+	for (lane = 0; lane < dp->link.cap.lanes; lane++)
+		train_set[lane] = drm_dp_get_adjust_request_voltage(lane_status, lane) |
+				  drm_dp_get_adjust_request_pre_emphasis(lane_status, lane);
+
+	if (memcmp(dp->link.train_set, train_set, HIBMC_DP_LANE_NUM_MAX)) {
+		memcpy(dp->link.train_set, train_set, HIBMC_DP_LANE_NUM_MAX);
+		return true;
+	}
+
+	return false;
+}
+
+static inline int hibmc_dp_link_reduce_rate(struct hibmc_dp_dev *dp)
+{
+	switch (dp->link.cap.link_rate) {
+	case DP_LINK_BW_2_7:
+		dp->link.cap.link_rate = DP_LINK_BW_1_62;
+		return 0;
+	case DP_LINK_BW_5_4:
+		dp->link.cap.link_rate = DP_LINK_BW_2_7;
+		return 0;
+	case DP_LINK_BW_8_1:
+		dp->link.cap.link_rate = DP_LINK_BW_5_4;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static inline int hibmc_dp_link_reduce_lane(struct hibmc_dp_dev *dp)
+{
+	switch (dp->link.cap.lanes) {
+	case 0x2:
+		dp->link.cap.lanes--;
+		break;
+	case 0x1:
+		drm_err(dp->dev, "dp link training reduce lane failed, already reach minimum\n");
+		return -EIO;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hibmc_dp_link_training_cr(struct hibmc_dp_dev *dp)
+{
+	u8 lane_status[DP_LINK_STATUS_SIZE] = {0};
+	bool level_changed;
+	u32 voltage_tries;
+	u32 cr_tries;
+	int ret;
+
+	/*
+	 * DP 1.4 spec define 10 for maxtries value, for pre DP 1.4 version set a limit of 80
+	 * (4 voltage levels x 4 preemphasis levels x 5 identical voltage retries)
+	 */
+
+	voltage_tries = 1;
+	for (cr_tries = 0; cr_tries < 80; cr_tries++) {
+		drm_dp_link_train_clock_recovery_delay(&dp->aux, dp->dpcd);
+
+		ret = drm_dp_dpcd_read_link_status(&dp->aux, lane_status);
+		if (ret != DP_LINK_STATUS_SIZE) {
+			drm_err(dp->dev, "Get lane status failed\n");
+			return ret;
+		}
+
+		if (drm_dp_clock_recovery_ok(lane_status, dp->link.cap.lanes)) {
+			drm_dbg_dp(dp->dev, "dp link training cr done\n");
+			dp->link.status.clock_recovered = true;
+			return 0;
+		}
+
+		if (voltage_tries == 5) {
+			drm_dbg_dp(dp->dev, "same voltage tries 5 times\n");
+			dp->link.status.clock_recovered = false;
+			return 0;
+		}
+
+		level_changed = hibmc_dp_link_get_adjust_train(dp, lane_status);
+		ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, dp->link.train_set,
+					dp->link.cap.lanes);
+		if (ret != dp->link.cap.lanes) {
+			drm_dbg_dp(dp->dev, "Update link training failed\n");
+			return ret >= 0 ? -EIO : ret;
+		}
+
+		voltage_tries = level_changed ? 1 : voltage_tries + 1;
+	}
+
+	drm_err(dp->dev, "dp link training clock recovery 80 times failed\n");
+	dp->link.status.clock_recovered = false;
+
+	return 0;
+}
+
+static int hibmc_dp_link_training_channel_eq(struct hibmc_dp_dev *dp)
+{
+	u8 lane_status[DP_LINK_STATUS_SIZE] = {0};
+	u8 eq_tries;
+	int ret;
+
+	ret = hibmc_dp_link_set_pattern(dp, DP_TRAINING_PATTERN_2);
+	if (ret)
+		return ret;
+
+	for (eq_tries = 0; eq_tries < HIBMC_EQ_MAX_RETRY; eq_tries++) {
+		drm_dp_link_train_channel_eq_delay(&dp->aux, dp->dpcd);
+
+		ret = drm_dp_dpcd_read_link_status(&dp->aux, lane_status);
+		if (ret != DP_LINK_STATUS_SIZE) {
+			drm_err(dp->dev, "get lane status failed\n");
+			break;
+		}
+
+		if (!drm_dp_clock_recovery_ok(lane_status, dp->link.cap.lanes)) {
+			drm_dbg_dp(dp->dev, "clock recovery check failed\n");
+			drm_dbg_dp(dp->dev, "cannot continue channel equalization\n");
+			dp->link.status.clock_recovered = false;
+			break;
+		}
+
+		if (drm_dp_channel_eq_ok(lane_status, dp->link.cap.lanes)) {
+			dp->link.status.channel_equalized = true;
+			drm_dbg_dp(dp->dev, "dp link training eq done\n");
+			break;
+		}
+
+		hibmc_dp_link_get_adjust_train(dp, lane_status);
+		ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET,
+					dp->link.train_set, dp->link.cap.lanes);
+		if (ret != dp->link.cap.lanes) {
+			drm_dbg_dp(dp->dev, "Update link training failed\n");
+			ret = (ret >= 0) ? -EIO : ret;
+			break;
+		}
+	}
+
+	if (eq_tries == HIBMC_EQ_MAX_RETRY)
+		drm_err(dp->dev, "channel equalization failed %u times\n", eq_tries);
+
+	hibmc_dp_link_set_pattern(dp, DP_TRAINING_PATTERN_DISABLE);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int hibmc_dp_link_downgrade_training_cr(struct hibmc_dp_dev *dp)
+{
+	if (hibmc_dp_link_reduce_rate(dp))
+		return hibmc_dp_link_reduce_lane(dp);
+
+	return 0;
+}
+
+static int hibmc_dp_link_downgrade_training_eq(struct hibmc_dp_dev *dp)
+{
+	if ((dp->link.status.clock_recovered && !dp->link.status.channel_equalized)) {
+		if (!hibmc_dp_link_reduce_lane(dp))
+			return 0;
+	}
+
+	return hibmc_dp_link_reduce_rate(dp);
+}
+
+int hibmc_dp_link_training(struct hibmc_dp_dev *dp)
+{
+	struct hibmc_dp_link *link = &dp->link;
+	int ret;
+
+	while (true) {
+		ret = hibmc_dp_link_training_cr_pre(dp);
+		if (ret)
+			goto err;
+
+		ret = hibmc_dp_link_training_cr(dp);
+		if (ret)
+			goto err;
+
+		if (!link->status.clock_recovered) {
+			ret = hibmc_dp_link_downgrade_training_cr(dp);
+			if (ret)
+				goto err;
+			continue;
+		}
+
+		ret = hibmc_dp_link_training_channel_eq(dp);
+		if (ret)
+			goto err;
+
+		if (!link->status.channel_equalized) {
+			ret = hibmc_dp_link_downgrade_training_eq(dp);
+			if (ret)
+				goto err;
+			continue;
+		}
+
+		return 0;
+	}
+
+err:
+	hibmc_dp_link_set_pattern(dp, DP_TRAINING_PATTERN_DISABLE);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
index f3e6781e111a..0bd308eccdc5 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
@@ -12,16 +12,24 @@
 #define HIBMC_DP_AUX_RD_DATA0			0x64
 #define HIBMC_DP_AUX_REQ			0x74
 #define HIBMC_DP_AUX_STATUS			0x78
+#define HIBMC_DP_PHYIF_CTRL0			0xa0
+#define HIBMC_DP_VIDEO_CTRL			0x100
 #define HIBMC_DP_DPTX_RST_CTRL			0x700
+#define HIBMC_DP_DPTX_GCTL0			0x708
 
 #define HIBMC_DP_CFG_AUX_SYNC_LEN_SEL		BIT(1)
 #define HIBMC_DP_CFG_AUX_TIMER_TIMEOUT		BIT(2)
+#define HIBMC_DP_CFG_STREAM_FRAME_MODE		BIT(6)
 #define HIBMC_DP_CFG_AUX_MIN_PULSE_NUM		GENMASK(13, 9)
+#define HIBMC_DP_CFG_LANE_DATA_EN		GENMASK(11, 8)
+#define HIBMC_DP_CFG_PHY_LANE_NUM		GENMASK(2, 1)
 #define HIBMC_DP_CFG_AUX_REQ			BIT(0)
 #define HIBMC_DP_CFG_AUX_RST_N			BIT(4)
 #define HIBMC_DP_CFG_AUX_TIMEOUT		BIT(0)
 #define HIBMC_DP_CFG_AUX_READY_DATA_BYTE	GENMASK(16, 12)
 #define HIBMC_DP_CFG_AUX			GENMASK(24, 17)
 #define HIBMC_DP_CFG_AUX_STATUS			GENMASK(11, 4)
+#define HIBMC_DP_CFG_SCRAMBLE_EN		BIT(0)
+#define HIBMC_DP_CFG_PAT_SEL			GENMASK(7, 4)
 
 #endif
-- 
2.33.0


