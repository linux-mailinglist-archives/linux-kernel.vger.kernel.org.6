Return-Path: <linux-kernel+bounces-550910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E576A565A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66083189868C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091020E33F;
	Fri,  7 Mar 2025 10:41:25 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290C634EC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344085; cv=none; b=hNhYkefn0E1mhc6CxKeNbAyzL6HKxvkZlDdttR9ajnLt4LSY26ZdiPJYZei3V9O+5xYS7i4dlZcq96t8gjJIrCQFjgSEwSyb6z0iy3DHRRGGGNRN15WBwJmRms+oUbidSipDPfMW4yUL0vrPM+A6DJVjOIpQQytREOv7URCEBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344085; c=relaxed/simple;
	bh=LU1zHWsQdlRuJry/0Hz32hq5J7fCvpPq6TF7F8LRdAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac++J8WRFUIhKGFqB/PvX/3fRY7eSubWlzFdKNtuVOGif26Kusoi4wpK4VhO2Td0+m5F/OqIrsHiuR+jLtmEkASA5SVIkPRcP+yVmyRAYwkSSi+8+RwxEzb363+Xs1rjgdrPQ4+fuKSTSqgJmVjtqAPENpD9Ajl5b2v7BR+DfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z8Mq84pBLz17NhM;
	Fri,  7 Mar 2025 18:24:52 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id A4DCC1402CA;
	Fri,  7 Mar 2025 18:24:18 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 7 Mar 2025 18:24:17 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 drm-dp 5/9] drm/hisilicon/hibmc: Getting connector info and EDID by using AUX channel
Date: Fri, 7 Mar 2025 18:16:36 +0800
Message-ID: <20250307101640.4003229-6-shiyongbang@huawei.com>
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

Add registering drm_aux and use it to get connector edid with drm
functions. Add ddc channel in connector initialization to put drm_aux
in drm_connector. And also add detect callback to detect connector
befored call connector_get_modes.

Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
ChangeLog:
v2 -> v3:
  - Capitalized EDID and AUX, suggested by Dmitry Baryshkov.
v1 -> v2:
  - deleting type conversion, suggested by Dmitry Baryshkov.
  - deleting hibmc_dp_connector_get_modes() and using drm_connector_helper_get_modes(), suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c   |  3 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 33 ++++++++++++++++---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  5 +++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
index ded9e7ce887a..e0bb9b14d9d8 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_aux.c
@@ -161,7 +161,8 @@ void hibmc_dp_aux_init(struct hibmc_dp *dp)
 				 HIBMC_DP_MIN_PULSE_NUM);
 
 	dp->aux.transfer = hibmc_dp_aux_xfer;
-	dp->aux.is_remote = 0;
+	dp->aux.name = kasprintf(GFP_KERNEL, "HIBMC DRM dp aux");
+	dp->aux.drm_dev = dp->drm_dev;
 	drm_dp_aux_init(&dp->aux);
 	dp->dp_dev->aux = &dp->aux;
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 603d6b198a54..1cb9c32f9ef0 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -15,25 +15,48 @@
 
 static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
 {
+	struct hibmc_dp *dp = to_hibmc_dp(connector);
+	const struct drm_edid *drm_edid;
 	int count;
 
-	count = drm_add_modes_noedid(connector, connector->dev->mode_config.max_width,
-				     connector->dev->mode_config.max_height);
-	drm_set_preferred_mode(connector, 1024, 768); // temporary implementation
+	drm_edid = drm_edid_read_ddc(connector, &dp->aux.ddc);
+
+	drm_edid_connector_update(connector, drm_edid);
+
+	count = drm_edid_connector_add_modes(connector);
+
+	drm_edid_free(drm_edid);
 
 	return count;
 }
 
 static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
 	.get_modes = hibmc_dp_connector_get_modes,
+	.detect_ctx = drm_connector_helper_detect_from_ddc,
 };
 
+static int hibmc_dp_late_register(struct drm_connector *connector)
+{
+	struct hibmc_dp *dp = to_hibmc_dp(connector);
+
+	return drm_dp_aux_register(&dp->aux);
+}
+
+static void hibmc_dp_early_unregister(struct drm_connector *connector)
+{
+	struct hibmc_dp *dp = to_hibmc_dp(connector);
+
+	drm_dp_aux_unregister(&dp->aux);
+}
+
 static const struct drm_connector_funcs hibmc_dp_conn_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.late_register = hibmc_dp_late_register,
+	.early_unregister = hibmc_dp_early_unregister,
 };
 
 static inline int hibmc_dp_prepare(struct hibmc_dp *dp, struct drm_display_mode *mode)
@@ -103,8 +126,8 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
 
 	drm_encoder_helper_add(encoder, &hibmc_dp_encoder_helper_funcs);
 
-	ret = drm_connector_init(dev, connector, &hibmc_dp_conn_funcs,
-				 DRM_MODE_CONNECTOR_DisplayPort);
+	ret = drm_connector_init_with_ddc(dev, connector, &hibmc_dp_conn_funcs,
+					  DRM_MODE_CONNECTOR_DisplayPort, &dp->aux.ddc);
 	if (ret) {
 		drm_err(dev, "init dp connector failed: %d\n", ret);
 		return ret;
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index d982f1e4b958..3ddd71aada66 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -47,6 +47,11 @@ static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
 	return container_of(connector, struct hibmc_vdac, connector);
 }
 
+static inline struct hibmc_dp *to_hibmc_dp(struct drm_connector *connector)
+{
+	return container_of(connector, struct hibmc_dp, connector);
+}
+
 static inline struct hibmc_drm_private *to_hibmc_drm_private(struct drm_device *dev)
 {
 	return container_of(dev, struct hibmc_drm_private, dev);
-- 
2.33.0


