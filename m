Return-Path: <linux-kernel+bounces-376267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E21289AA273
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A74DB22E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9D619DF77;
	Tue, 22 Oct 2024 12:47:06 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6C19C579
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601225; cv=none; b=aySF2Vo4AySKUmjfB8mlDU+AVC5o6U9sHCIymk8vS10RnYkKBROYlzBLwOGo0ky4o5iSlJMzpf2lQmUvJHSIg6eRuAL7TH2wCkaqlcQ0c2nI+xA/QIXhR2QqO4QYJeq4Non8MHRlNpRUops/iss0M8d1IMF3aQXmFB+6+qxXKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601225; c=relaxed/simple;
	bh=avWmMzD2mQaO9LmZV9IXH2C4SkIsOTbE8nZtDDJsrl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pp7oZWUbJ1yHPu6xTvken7bDg9yWqCg2QWdC1kCH/9YuU05jksFxYfHQ6mkcyUJuipzH92pskiUXSgaae7Gz6madBfVfYGH0fwg042tCLonXtAWkLX8JCXVGO9koOz29jTqfC93HHcYon/gL1yktvSUiVAz7QKOfYKRkPwyNZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XXsJw2bl7z1HLKC;
	Tue, 22 Oct 2024 20:42:40 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B65B140361;
	Tue, 22 Oct 2024 20:47:00 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 22 Oct 2024 20:46:58 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 drm-dp 2/4] drm/hisilicon/hibmc: add dp link moduel in hibmc
Date: Tue, 22 Oct 2024 20:41:46 +0800
Message-ID: <20241022124148.1952761-3-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241022124148.1952761-1-shiyongbang@huawei.com>
References: <20241022124148.1952761-1-shiyongbang@huawei.com>
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

From: baihan li <libaihan@huawei.com>

Add link training process functions in this moduel.

Signed-off-by: baihan li <libaihan@huawei.com>
---
ChangeLog:
v1 -> v2:
  - using drm_dp_* functions implement dp link training process, suggested by Jani Nikula.
  - fix build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202410031735.8iRZZR6T-lkp@intel.com/
  v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
---
 drivers/gpu/drm/hisilicon/hibmc/Makefile     |   2 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 344 +++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h |  25 ++
 3 files changed, 370 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h

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
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
new file mode 100644
index 000000000000..b02a536e0689
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Hisilicon Limited.
+
+#include <linux/delay.h>
+#include <drm/drm_device.h>
+#include <drm/drm_print.h>
+#include "dp_comm.h"
+#include "dp_reg.h"
+#include "dp_link.h"
+#include "dp_aux.h"
+
+const u8 link_rate_map[] = {DP_LINK_BW_1_62, DP_LINK_BW_2_7,
+			    DP_LINK_BW_5_4, DP_LINK_BW_8_1};
+
+static int dp_link_training_configure(struct dp_dev *dp)
+{
+	u8 buf[2];
+	int ret;
+
+	/* DP 2 lane */
+	dp_write_bits(dp->base + DP_PHYIF_CTRL0, DP_CFG_LANE_DATA_EN,
+		      dp->link.cap.lanes == DP_LANE_NUM_2 ? 0x3 : 0x1);
+	dp_write_bits(dp->base + DP_DPTX_GCTL0, DP_CFG_PHY_LANE_NUM,
+		      dp->link.cap.lanes == DP_LANE_NUM_2 ? 0x1 : 0);
+
+	/* enhanced frame */
+	dp_write_bits(dp->base + DP_VIDEO_CTRL, DP_CFG_STREAM_FRAME_MODE, 0x1);
+
+	/* set rate and lane count */
+	buf[0] = dp_get_link_rate(dp->link.cap.link_rate);
+	buf[1] = DP_LANE_COUNT_ENHANCED_FRAME_EN | dp->link.cap.lanes;
+	ret = drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		drm_err(dp->dev, "dp aux write link rate and lanes failed, ret: %d\n", ret);
+		return ret;
+	}
+
+	/* set 8b/10b and downspread */
+	buf[0] = 0x10;
+	buf[1] = 0x1;
+	ret = drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, buf, sizeof(buf));
+	if (ret != sizeof(buf))
+		drm_err(dp->dev, "dp aux write 8b/10b and downspread failed, ret: %d\n", ret);
+
+	ret = drm_dp_read_dpcd_caps(&dp->aux, dp->dpcd);
+	if (ret)
+		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
+
+	return ret;
+}
+
+static int dp_link_pattern2dpcd(struct dp_dev *dp, enum dp_pattern_e pattern)
+{
+	switch (pattern) {
+	case DP_PATTERN_NO:
+		return DP_TRAINING_PATTERN_DISABLE;
+	case DP_PATTERN_TPS1:
+		return DP_TRAINING_PATTERN_1;
+	case DP_PATTERN_TPS2:
+		return DP_TRAINING_PATTERN_2;
+	case DP_PATTERN_TPS3:
+		return DP_TRAINING_PATTERN_3;
+	case DP_PATTERN_TPS4:
+		return DP_TRAINING_PATTERN_4;
+	default:
+		drm_err(dp->dev, "dp link unknown pattern %d\n", pattern);
+		return -EINVAL;
+	}
+}
+
+static int dp_link_set_pattern(struct dp_dev *dp, enum dp_pattern_e pattern)
+{
+	int ret;
+	u8 buf;
+
+	ret = dp_link_pattern2dpcd(dp, pattern);
+	if (ret < 0)
+		return ret;
+
+	buf = (u8)ret;
+	if (pattern != DP_TRAINING_PATTERN_DISABLE && pattern != DP_TRAINING_PATTERN_4) {
+		buf |= DP_LINK_SCRAMBLING_DISABLE;
+		dp_write_bits(dp->base + DP_PHYIF_CTRL0, DP_CFG_SCRAMBLE_EN, 0x1);
+	} else {
+		dp_write_bits(dp->base + DP_PHYIF_CTRL0, DP_CFG_SCRAMBLE_EN, 0);
+	}
+
+	dp_write_bits(dp->base + DP_PHYIF_CTRL0, DP_CFG_PAT_SEL, pattern);
+
+	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_PATTERN_SET, &buf, sizeof(buf));
+	if (ret != sizeof(buf))
+		drm_err(dp->dev, "dp aux write training pattern set failed\n");
+
+	return 0;
+}
+
+static int dp_link_training_cr_pre(struct dp_dev *dp)
+{
+	u8 *train_set = dp->link.train_set;
+	int ret;
+	u8 i;
+
+	ret = dp_link_training_configure(dp);
+	if (ret)
+		return ret;
+
+	ret = dp_link_set_pattern(dp, DP_PATTERN_TPS1);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < dp->link.cap.lanes; i++)
+		train_set[i] = DP_TRAIN_VOLTAGE_SWING_LEVEL_2;
+
+	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, train_set, dp->link.cap.lanes);
+	if (ret != dp->link.cap.lanes)
+		drm_err(dp->dev, "dp aux write training lane set failed\n");
+
+	return 0;
+}
+
+static bool dp_link_get_adjust_train(struct dp_dev *dp, u8 lane_status[DP_LINK_STATUS_SIZE])
+{
+	u8 pre_emph[DP_LANE_NUM_MAX] = {0};
+	u8 voltage[DP_LANE_NUM_MAX] = {0};
+	bool changed = false;
+	u8 train_set;
+	u8 lane;
+
+	/* not support level 3 */
+	for (lane = 0; lane < dp->link.cap.lanes; lane++) {
+		voltage[lane] = drm_dp_get_adjust_request_voltage(lane_status, lane);
+		pre_emph[lane] = drm_dp_get_adjust_request_pre_emphasis(lane_status, lane);
+	}
+
+	for (lane = 0; lane < dp->link.cap.lanes; lane++) {
+		train_set = voltage[lane] | pre_emph[lane];
+		if (dp->link.train_set[lane] != train_set) {
+			changed = true;
+			dp->link.train_set[lane] = train_set;
+		}
+	}
+
+	return changed;
+}
+
+u8 dp_get_link_rate(u8 index)
+{
+	return link_rate_map[index];
+}
+
+static int dp_link_reduce_rate(struct dp_dev *dp)
+{
+	if (dp->link.cap.link_rate > 0) {
+		dp->link.cap.link_rate--;
+		return 0;
+	}
+
+	drm_err(dp->dev, "dp link training reduce rate failed, already lowest rate\n");
+
+	return -EFAULT;
+}
+
+static int dp_link_reduce_lane(struct dp_dev *dp)
+{
+	if (dp->link.cap.lanes == DP_LANE_NUM_1) {
+		drm_err(dp->dev, "dp link training reduce lane failed, already reach minimum\n");
+		return -EFAULT;
+	}
+
+	/* currently only 1 lane */
+	dp->link.cap.lanes = DP_LANE_NUM_1;
+
+	return 0;
+}
+
+static int dp_link_training_cr(struct dp_dev *dp)
+{
+	u8 lane_status[DP_LINK_STATUS_SIZE] = {0};
+	bool level_changed;
+	u32 voltage_tries;
+	u32 cr_tries;
+	u32 max_cr;
+	int ret;
+
+	/*
+	 * DP 1.4 spec define 10 for maxtries value, for pre DP 1.4 version set a limit of 80
+	 * (4 voltage levels x 4 preemphasis levels x 5 identical voltage retries)
+	 */
+	max_cr = dp->link.cap.rx_dpcd_revision >= DPCD_REVISION_14 ? 10 : 80;
+
+	voltage_tries = 1;
+	for (cr_tries = 0; cr_tries < max_cr; cr_tries++) {
+		drm_dp_link_train_clock_recovery_delay(&dp->aux, dp->dpcd);
+
+		ret = drm_dp_dpcd_read_link_status(&dp->aux, lane_status);
+		if (ret != DP_LINK_STATUS_SIZE) {
+			drm_err(dp->dev, "Get lane status failed\n");
+			return ret;
+		}
+
+		if (drm_dp_clock_recovery_ok(lane_status, dp->link.cap.lanes)) {
+			drm_info(dp->dev, "dp link training cr done\n");
+			dp->link.status.clock_recovered = true;
+			return 0;
+		}
+
+		if (voltage_tries == 5) {
+			drm_info(dp->dev, "same voltage tries 5 times\n");
+			dp->link.status.clock_recovered = false;
+			return 0;
+		}
+
+		level_changed = dp_link_get_adjust_train(dp, lane_status);
+		ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, dp->link.train_set,
+					dp->link.cap.lanes);
+		if (ret != dp->link.cap.lanes) {
+			drm_err(dp->dev, "Update link training failed\n");
+			return ret;
+		}
+
+		voltage_tries = level_changed ? 1 : voltage_tries + 1;
+	}
+
+	drm_err(dp->dev, "dp link training clock recovery %u timers failed\n", max_cr);
+	dp->link.status.clock_recovered = false;
+
+	return 0;
+}
+
+static int dp_link_training_channel_eq(struct dp_dev *dp)
+{
+	u8 lane_status[DP_LINK_STATUS_SIZE] = {0};
+	enum dp_pattern_e tps;
+	u8 eq_tries;
+	int ret;
+
+	if (dp->link.cap.is_tps4)
+		tps = DP_PATTERN_TPS4;
+	else if (dp->link.cap.is_tps3)
+		tps = DP_PATTERN_TPS3;
+	else
+		tps = DP_PATTERN_TPS2;
+
+	ret = dp_link_set_pattern(dp, tps);
+	if (ret)
+		return ret;
+
+	for (eq_tries = 0; eq_tries < EQ_MAX_RETRY; eq_tries++) {
+		drm_dp_link_train_channel_eq_delay(&dp->aux, dp->dpcd);
+
+		ret = drm_dp_dpcd_read_link_status(&dp->aux, lane_status);
+		if (ret != DP_LINK_STATUS_SIZE) {
+			drm_err(dp->dev, "get lane status failed\n");
+			break;
+		}
+
+		if (!drm_dp_clock_recovery_ok(lane_status, dp->link.cap.lanes)) {
+			drm_info(dp->dev, "clock recovery check failed\n");
+			drm_info(dp->dev, "cannot continue channel equalization\n");
+			dp->link.status.clock_recovered = false;
+			break;
+		}
+
+		if (drm_dp_channel_eq_ok(lane_status, dp->link.cap.lanes)) {
+			dp->link.status.channel_equalized = true;
+			drm_info(dp->dev, "dp link training eq done\n");
+			break;
+		}
+
+		dp_link_get_adjust_train(dp, lane_status);
+		ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET,
+					dp->link.train_set, dp->link.cap.lanes);
+		if (ret != dp->link.cap.lanes) {
+			drm_err(dp->dev, "Update link training failed\n");
+			break;
+		}
+	}
+
+	if (eq_tries == EQ_MAX_RETRY)
+		drm_err(dp->dev, "channel equalization failed %u times\n", eq_tries);
+
+	dp_link_set_pattern(dp, DP_PATTERN_NO);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int dp_link_downgrade_training_cr(struct dp_dev *dp)
+{
+	if (dp_link_reduce_rate(dp))
+		return dp_link_reduce_lane(dp);
+
+	return 0;
+}
+
+static int dp_link_downgrade_training_eq(struct dp_dev *dp)
+{
+	if ((dp->link.status.clock_recovered && !dp->link.status.channel_equalized)) {
+		if (!dp_link_reduce_lane(dp))
+			return 0;
+	}
+
+	return dp_link_reduce_rate(dp);
+}
+
+int dp_link_training(struct dp_dev *dp)
+{
+	struct hibmc_dp_link *link = &dp->link;
+	int ret;
+
+	while (true) {
+		ret = dp_link_training_cr_pre(dp);
+		if (ret)
+			goto err;
+
+		ret = dp_link_training_cr(dp);
+		if (ret)
+			goto err;
+
+		if (!link->status.clock_recovered) {
+			ret = dp_link_downgrade_training_cr(dp);
+			if (ret)
+				goto err;
+			continue;
+		}
+
+		ret = dp_link_training_channel_eq(dp);
+		if (ret)
+			goto err;
+
+		if (!link->status.channel_equalized) {
+			ret = dp_link_downgrade_training_eq(dp);
+			if (ret)
+				goto err;
+			continue;
+		}
+
+		return 0;
+	}
+
+err:
+	dp_link_set_pattern(dp, DP_PATTERN_NO);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h
new file mode 100644
index 000000000000..38877d8f473b
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (c) 2024 Hisilicon Limited. */
+
+#ifndef DP_LINK_H
+#define DP_LINK_H
+
+#include "dp_comm.h"
+
+#define DP_LANE_NUM_MAX		2
+#define DP_LANE_STATUS_SIZE	1
+#define DP_LANE_NUM_1		0x1
+#define DP_LANE_NUM_2		0x2
+
+enum dp_pattern_e {
+	DP_PATTERN_NO = 0,
+	DP_PATTERN_TPS1,
+	DP_PATTERN_TPS2,
+	DP_PATTERN_TPS3,
+	DP_PATTERN_TPS4,
+};
+
+int dp_link_training(struct dp_dev *dp);
+u8 dp_get_link_rate(u8 index);
+
+#endif
-- 
2.33.0


