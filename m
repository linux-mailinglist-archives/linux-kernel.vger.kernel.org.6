Return-Path: <linux-kernel+bounces-526924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE75BA40538
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 03:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEEE19E0B87
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816D3202C5D;
	Sat, 22 Feb 2025 02:58:29 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA65200105
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740193108; cv=none; b=rFCfT9XXBAK6p8lCLfjr8SZukjKjAFqCh9gUVQjIErnJ4ewrvVLaaB2W6twdVmbz8t3dyE6ciMklxgyMyRFjr6PjUtuvrz3ebBlKsvs6e7QIDbFDkH2xDXh+l89rhivsOv/cHnmu2/FcktL7azrZpjUuFARtK41rsNDuPfQ9zgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740193108; c=relaxed/simple;
	bh=LwyCyvBmQqqrp83jGdHXG3fuDoLk/Cidzo3CkwSC8T8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBrwwlhq8BV4r+EHu6nOl8LQhYNyGs3u3V0egKQxfZiYzly9rVKtMBasLKIb9YjMFFbDXRxIKSwpjgsNT+/j5ZbrXp6vxwiY/IVRSfKJnaQQwfG7779C3hRn0ZbNoZ5YLv9lQ7HYauAyrnSX4KEPVDWuckrC+bcnpnW6kTqCAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z0BST2yrnzHr9M;
	Sat, 22 Feb 2025 10:55:21 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CF75180080;
	Sat, 22 Feb 2025 10:58:24 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 22 Feb 2025 10:58:22 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 drm-dp 4/8] drm/hisilicon/hibmc: Refactor the member of drm_aux in struct hibmc_dp
Date: Sat, 22 Feb 2025 10:50:57 +0800
Message-ID: <20250222025102.1519798-5-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250222025102.1519798-1-shiyongbang@huawei.com>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
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

Because the drm_aux of struct hibmc_dp_dev's member is not easy to get in
hibmc_drm_dp.c, we move the drm_aux to struct hibmc_dp. Then there are some
adaptations and modifications to make this patch compile.

Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v2 -> v3:
  - split the patch into two parts, suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c  | 13 +++++++-----
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h |  6 ++++--
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c   |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h   |  2 ++
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 22 ++++++++++----------
 5 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
index 0a903cce1fa9..ded9e7ce887a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
@@ -8,6 +8,7 @@
 #include <drm/drm_print.h>
 #include "dp_comm.h"
 #include "dp_reg.h"
+#include "dp_hw.h"
 
 #define HIBMC_AUX_CMD_REQ_LEN		GENMASK(7, 4)
 #define HIBMC_AUX_CMD_ADDR		GENMASK(27, 8)
@@ -124,7 +125,8 @@ static int hibmc_dp_aux_parse_xfer(struct hibmc_dp_dev *dp, struct drm_dp_aux_ms
 /* ret >= 0 ,ret is size; ret < 0, ret is err code */
 static ssize_t hibmc_dp_aux_xfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
 {
-	struct hibmc_dp_dev *dp = container_of(aux, struct hibmc_dp_dev, aux);
+	struct hibmc_dp *dp_priv = container_of(aux, struct hibmc_dp, aux);
+	struct hibmc_dp_dev *dp = dp_priv->dp_dev;
 	u32 aux_cmd;
 	int ret;
 	u32 val; /* val will be assigned at the beginning of readl_poll_timeout function */
@@ -151,14 +153,15 @@ static ssize_t hibmc_dp_aux_xfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *
 	return hibmc_dp_aux_parse_xfer(dp, msg);
 }
 
-void hibmc_dp_aux_init(struct hibmc_dp_dev *dp)
+void hibmc_dp_aux_init(struct hibmc_dp *dp)
 {
-	hibmc_dp_reg_write_field(dp, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_SYNC_LEN_SEL, 0x0);
-	hibmc_dp_reg_write_field(dp, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_TIMER_TIMEOUT, 0x1);
-	hibmc_dp_reg_write_field(dp, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_MIN_PULSE_NUM,
+	hibmc_dp_reg_write_field(dp->dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_SYNC_LEN_SEL, 0x0);
+	hibmc_dp_reg_write_field(dp->dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_TIMER_TIMEOUT, 0x1);
+	hibmc_dp_reg_write_field(dp->dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_MIN_PULSE_NUM,
 				 HIBMC_DP_MIN_PULSE_NUM);
 
 	dp->aux.transfer = hibmc_dp_aux_xfer;
 	dp->aux.is_remote = 0;
 	drm_dp_aux_init(&dp->aux);
+	dp->dp_dev->aux = &dp->aux;
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
index e7746bc4b592..2296c7258cbb 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
@@ -13,6 +13,8 @@
 #include <linux/io.h>
 #include <drm/display/drm_dp_helper.h>
 
+#include "dp_hw.h"
+
 #define HIBMC_DP_LANE_NUM_MAX 2
 
 struct hibmc_link_status {
@@ -32,7 +34,7 @@ struct hibmc_dp_link {
 };
 
 struct hibmc_dp_dev {
-	struct drm_dp_aux aux;
+	struct drm_dp_aux *aux;
 	struct drm_device *dev;
 	void __iomem *base;
 	struct mutex lock; /* protects concurrent RW in hibmc_dp_reg_write_field() */
@@ -58,7 +60,7 @@ struct hibmc_dp_dev {
 		mutex_unlock(&_dp->lock);				\
 	} while (0)
 
-void hibmc_dp_aux_init(struct hibmc_dp_dev *dp);
+void hibmc_dp_aux_init(struct hibmc_dp *dp);
 int hibmc_dp_link_training(struct hibmc_dp_dev *dp);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
index ad3e5c527e39..9d673f431a0e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
@@ -168,7 +168,7 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
 	dp_dev->dev = drm_dev;
 	dp_dev->base = dp->mmio + HIBMC_DP_OFFSET;
 
-	hibmc_dp_aux_init(dp_dev);
+	hibmc_dp_aux_init(dp);
 
 	ret = hibmc_dp_serdes_init(dp_dev);
 	if (ret)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
index 4dc13b3d9875..53b6d0beecea 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
@@ -10,6 +10,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_print.h>
+#include <drm/display/drm_dp_helper.h>
 
 struct hibmc_dp_dev;
 
@@ -19,6 +20,7 @@ struct hibmc_dp {
 	struct drm_encoder encoder;
 	struct drm_connector connector;
 	void __iomem *mmio;
+	struct drm_dp_aux aux;
 };
 
 int hibmc_dp_hw_init(struct hibmc_dp *dp);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
index e2bee7500226..add55787fbea 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
@@ -27,7 +27,7 @@ static int hibmc_dp_link_training_configure(struct hibmc_dp_dev *dp)
 	/* set rate and lane count */
 	buf[0] = dp->link.cap.link_rate;
 	buf[1] = DP_LANE_COUNT_ENHANCED_FRAME_EN | dp->link.cap.lanes;
-	ret = drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, buf, sizeof(buf));
+	ret = drm_dp_dpcd_write(dp->aux, DP_LINK_BW_SET, buf, sizeof(buf));
 	if (ret != sizeof(buf)) {
 		drm_dbg_dp(dp->dev, "dp aux write link rate and lanes failed, ret: %d\n", ret);
 		return ret >= 0 ? -EIO : ret;
@@ -36,13 +36,13 @@ static int hibmc_dp_link_training_configure(struct hibmc_dp_dev *dp)
 	/* set 8b/10b and downspread */
 	buf[0] = DP_SPREAD_AMP_0_5;
 	buf[1] = DP_SET_ANSI_8B10B;
-	ret = drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, buf, sizeof(buf));
+	ret = drm_dp_dpcd_write(dp->aux, DP_DOWNSPREAD_CTRL, buf, sizeof(buf));
 	if (ret != sizeof(buf)) {
 		drm_dbg_dp(dp->dev, "dp aux write 8b/10b and downspread failed, ret: %d\n", ret);
 		return ret >= 0 ? -EIO : ret;
 	}
 
-	ret = drm_dp_read_dpcd_caps(&dp->aux, dp->dpcd);
+	ret = drm_dp_read_dpcd_caps(dp->aux, dp->dpcd);
 	if (ret)
 		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
 
@@ -85,7 +85,7 @@ static int hibmc_dp_link_set_pattern(struct hibmc_dp_dev *dp, int pattern)
 
 	hibmc_dp_reg_write_field(dp, HIBMC_DP_PHYIF_CTRL0, HIBMC_DP_CFG_PAT_SEL, val);
 
-	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_PATTERN_SET, &buf, sizeof(buf));
+	ret = drm_dp_dpcd_write(dp->aux, DP_TRAINING_PATTERN_SET, &buf, sizeof(buf));
 	if (ret != sizeof(buf)) {
 		drm_dbg_dp(dp->dev, "dp aux write training pattern set failed\n");
 		return ret >= 0 ? -EIO : ret;
@@ -115,7 +115,7 @@ static int hibmc_dp_link_training_cr_pre(struct hibmc_dp_dev *dp)
 	if (ret)
 		return ret;
 
-	ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, train_set, dp->link.cap.lanes);
+	ret = drm_dp_dpcd_write(dp->aux, DP_TRAINING_LANE0_SET, train_set, dp->link.cap.lanes);
 	if (ret != dp->link.cap.lanes) {
 		drm_dbg_dp(dp->dev, "dp aux write training lane set failed\n");
 		return ret >= 0 ? -EIO : ret;
@@ -198,9 +198,9 @@ static int hibmc_dp_link_training_cr(struct hibmc_dp_dev *dp)
 
 	voltage_tries = 1;
 	for (cr_tries = 0; cr_tries < 80; cr_tries++) {
-		drm_dp_link_train_clock_recovery_delay(&dp->aux, dp->dpcd);
+		drm_dp_link_train_clock_recovery_delay(dp->aux, dp->dpcd);
 
-		ret = drm_dp_dpcd_read_link_status(&dp->aux, lane_status);
+		ret = drm_dp_dpcd_read_link_status(dp->aux, lane_status);
 		if (ret != DP_LINK_STATUS_SIZE) {
 			drm_err(dp->dev, "Get lane status failed\n");
 			return ret;
@@ -224,7 +224,7 @@ static int hibmc_dp_link_training_cr(struct hibmc_dp_dev *dp)
 		if (ret)
 			return ret;
 
-		ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, dp->link.train_set,
+		ret = drm_dp_dpcd_write(dp->aux, DP_TRAINING_LANE0_SET, dp->link.train_set,
 					dp->link.cap.lanes);
 		if (ret != dp->link.cap.lanes) {
 			drm_dbg_dp(dp->dev, "Update link training failed\n");
@@ -251,9 +251,9 @@ static int hibmc_dp_link_training_channel_eq(struct hibmc_dp_dev *dp)
 		return ret;
 
 	for (eq_tries = 0; eq_tries < HIBMC_EQ_MAX_RETRY; eq_tries++) {
-		drm_dp_link_train_channel_eq_delay(&dp->aux, dp->dpcd);
+		drm_dp_link_train_channel_eq_delay(dp->aux, dp->dpcd);
 
-		ret = drm_dp_dpcd_read_link_status(&dp->aux, lane_status);
+		ret = drm_dp_dpcd_read_link_status(dp->aux, lane_status);
 		if (ret != DP_LINK_STATUS_SIZE) {
 			drm_err(dp->dev, "get lane status failed\n");
 			break;
@@ -278,7 +278,7 @@ static int hibmc_dp_link_training_channel_eq(struct hibmc_dp_dev *dp)
 		if (ret)
 			return ret;
 
-		ret = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET,
+		ret = drm_dp_dpcd_write(dp->aux, DP_TRAINING_LANE0_SET,
 					dp->link.train_set, dp->link.cap.lanes);
 		if (ret != dp->link.cap.lanes) {
 			drm_dbg_dp(dp->dev, "Update link training failed\n");
-- 
2.33.0


