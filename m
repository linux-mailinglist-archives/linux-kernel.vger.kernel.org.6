Return-Path: <linux-kernel+bounces-405938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1ED9C5922
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A693281A29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB01662E4;
	Tue, 12 Nov 2024 13:29:30 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8F1494CC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418170; cv=none; b=FQauMfAW1XPNdZNqXlccX/7n/5fQCVTvSw236bcGzqM1wubvOMvB+WFPlRh2/EZNEb3oYlA9EKGclMaPAQt4yvLMUA/r+O/i2xFZzU5lRZAUnv64s4rDjBBctC9hr+eVi+AK+tlehqv+uWXhgyEYAMec99APW4340r8/vYq8fy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418170; c=relaxed/simple;
	bh=pVN0c6LdzHB4MzKrC5poBvasIJ3wuJ1LsbATBIoBztM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmU7G5+sJ7NB8YPXezy3f9kmrnZxuEiJGF1SUEHcfHwWa4Wzt1W6VPoIEjPxkrjsEGZ+ZDBI3ylgAXEiloqw13+VGpdHIoira6Y4iHVDZ8TVe/55RN85NeLOzKHYXx0spYB+HbyAM1TVsZWjAnDle7PiKWMVcE+J88e+vskl92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XnnKl58KSz20t6F;
	Tue, 12 Nov 2024 21:28:11 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 43F24140257;
	Tue, 12 Nov 2024 21:29:25 +0800 (CST)
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 12 Nov 2024 21:29:23 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<lidongming5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 drm-dp 4/5] drm/hisilicon/hibmc: separate struct of vdac
Date: Tue, 12 Nov 2024 21:23:47 +0800
Message-ID: <20241112132348.2631150-5-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241112132348.2631150-1-shiyongbang@huawei.com>
References: <20241112132348.2631150-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500013.china.huawei.com (7.221.188.12)

From: baihan li <libaihan@huawei.com>

Refactored struct hibmc_drm_private to separate VGA module from
generic struct.

Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v3 -> v4:
  - separating hibmc_vdac and hibmc_dp changes into separate patche, suggested by Dmitry Baryshkov.
v2 -> v3:
  - fix build errors reported by kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202410251136.1m7BlR68-lkp@intel.com/
v1 -> v2:
  - deleting struct dp_mode and dp_mode_cfg function, suggested by Dmitry Baryshkov.
  - modifying drm_simple_encoder_init function, suggested by Dmitry Baryshkov.
  - refactoring struct hibmc_connector, suggested by Dmitry Baryshkov.
  - withdrawing the modification in hibmc_kms_init, suggested by Dmitry Baryshkov.
  v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   | 16 ++++----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c   | 41 +++++++++----------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 20 ++++-----
 3 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 6b566f3aeecb..42f0ab8f9b5a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -20,9 +20,10 @@
 
 #include <drm/drm_framebuffer.h>
 
-struct hibmc_connector {
-	struct drm_connector base;
-
+struct hibmc_vdac {
+	struct drm_device *dev;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
 	struct i2c_adapter adapter;
 	struct i2c_algo_bit_data bit_data;
 };
@@ -35,13 +36,12 @@ struct hibmc_drm_private {
 	struct drm_device dev;
 	struct drm_plane primary_plane;
 	struct drm_crtc crtc;
-	struct drm_encoder encoder;
-	struct hibmc_connector connector;
+	struct hibmc_vdac vdac;
 };
 
-static inline struct hibmc_connector *to_hibmc_connector(struct drm_connector *connector)
+static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
 {
-	return container_of(connector, struct hibmc_connector, base);
+	return container_of(connector, struct hibmc_vdac, connector);
 }
 
 static inline struct hibmc_drm_private *to_hibmc_drm_private(struct drm_device *dev)
@@ -57,6 +57,6 @@ void hibmc_set_current_gate(struct hibmc_drm_private *priv,
 int hibmc_de_init(struct hibmc_drm_private *priv);
 int hibmc_vdac_init(struct hibmc_drm_private *priv);
 
-int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_connector *connector);
+int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *connector);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
index e6e48651c15c..99b3b77b5445 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
@@ -25,8 +25,8 @@
 
 static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
 {
-	struct hibmc_connector *hibmc_connector = data;
-	struct hibmc_drm_private *priv = to_hibmc_drm_private(hibmc_connector->base.dev);
+	struct hibmc_vdac *vdac = data;
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(vdac->connector.dev);
 	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
 
 	if (value) {
@@ -45,8 +45,8 @@ static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
 
 static int hibmc_get_i2c_signal(void *data, u32 mask)
 {
-	struct hibmc_connector *hibmc_connector = data;
-	struct hibmc_drm_private *priv = to_hibmc_drm_private(hibmc_connector->base.dev);
+	struct hibmc_vdac *vdac = data;
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(vdac->connector.dev);
 	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
 
 	if ((tmp_dir & mask) != mask) {
@@ -77,22 +77,21 @@ static int hibmc_ddc_getscl(void *data)
 	return hibmc_get_i2c_signal(data, I2C_SCL_MASK);
 }
 
-int hibmc_ddc_create(struct drm_device *drm_dev,
-		     struct hibmc_connector *connector)
+int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *vdac)
 {
-	connector->adapter.owner = THIS_MODULE;
-	snprintf(connector->adapter.name, I2C_NAME_SIZE, "HIS i2c bit bus");
-	connector->adapter.dev.parent = drm_dev->dev;
-	i2c_set_adapdata(&connector->adapter, connector);
-	connector->adapter.algo_data = &connector->bit_data;
-
-	connector->bit_data.udelay = 20;
-	connector->bit_data.timeout = usecs_to_jiffies(2000);
-	connector->bit_data.data = connector;
-	connector->bit_data.setsda = hibmc_ddc_setsda;
-	connector->bit_data.setscl = hibmc_ddc_setscl;
-	connector->bit_data.getsda = hibmc_ddc_getsda;
-	connector->bit_data.getscl = hibmc_ddc_getscl;
-
-	return i2c_bit_add_bus(&connector->adapter);
+	vdac->adapter.owner = THIS_MODULE;
+	snprintf(vdac->adapter.name, I2C_NAME_SIZE, "HIS i2c bit bus");
+	vdac->adapter.dev.parent = drm_dev->dev;
+	i2c_set_adapdata(&vdac->adapter, vdac);
+	vdac->adapter.algo_data = &vdac->bit_data;
+
+	vdac->bit_data.udelay = 20;
+	vdac->bit_data.timeout = usecs_to_jiffies(2000);
+	vdac->bit_data.data = vdac;
+	vdac->bit_data.setsda = hibmc_ddc_setsda;
+	vdac->bit_data.setscl = hibmc_ddc_setscl;
+	vdac->bit_data.getsda = hibmc_ddc_getsda;
+	vdac->bit_data.getscl = hibmc_ddc_getscl;
+
+	return i2c_bit_add_bus(&vdac->adapter);
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 409c551c92af..05e19ea4c9f9 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -24,11 +24,11 @@
 
 static int hibmc_connector_get_modes(struct drm_connector *connector)
 {
-	struct hibmc_connector *hibmc_connector = to_hibmc_connector(connector);
+	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
 	const struct drm_edid *drm_edid;
 	int count;
 
-	drm_edid = drm_edid_read_ddc(connector, &hibmc_connector->adapter);
+	drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
 
 	drm_edid_connector_update(connector, drm_edid);
 
@@ -51,9 +51,9 @@ static int hibmc_connector_get_modes(struct drm_connector *connector)
 
 static void hibmc_connector_destroy(struct drm_connector *connector)
 {
-	struct hibmc_connector *hibmc_connector = to_hibmc_connector(connector);
+	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
 
-	i2c_del_adapter(&hibmc_connector->adapter);
+	i2c_del_adapter(&vdac->adapter);
 	drm_connector_cleanup(connector);
 }
 
@@ -93,20 +93,20 @@ static const struct drm_encoder_helper_funcs hibmc_encoder_helper_funcs = {
 int hibmc_vdac_init(struct hibmc_drm_private *priv)
 {
 	struct drm_device *dev = &priv->dev;
-	struct hibmc_connector *hibmc_connector = &priv->connector;
-	struct drm_encoder *encoder = &priv->encoder;
+	struct hibmc_vdac *vdac = &priv->vdac;
+	struct drm_encoder *encoder = &vdac->encoder;
 	struct drm_crtc *crtc = &priv->crtc;
-	struct drm_connector *connector = &hibmc_connector->base;
+	struct drm_connector *connector = &vdac->connector;
 	int ret;
 
-	ret = hibmc_ddc_create(dev, hibmc_connector);
+	ret = hibmc_ddc_create(dev, vdac);
 	if (ret) {
 		drm_err(dev, "failed to create ddc: %d\n", ret);
 		return ret;
 	}
 
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
+	ret = drmm_encoder_init(dev, encoder, NULL, DRM_MODE_ENCODER_DAC, NULL);
 	if (ret) {
 		drm_err(dev, "failed to init encoder: %d\n", ret);
 		return ret;
@@ -117,7 +117,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	ret = drm_connector_init_with_ddc(dev, connector,
 					  &hibmc_connector_funcs,
 					  DRM_MODE_CONNECTOR_VGA,
-					  &hibmc_connector->adapter);
+					  &vdac->adapter);
 	if (ret) {
 		drm_err(dev, "failed to init connector: %d\n", ret);
 		return ret;
-- 
2.33.0


