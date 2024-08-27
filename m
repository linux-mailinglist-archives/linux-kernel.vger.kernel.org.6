Return-Path: <linux-kernel+bounces-302492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B506A95FF68
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A3B1F21CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8655D17C6C;
	Tue, 27 Aug 2024 02:56:11 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11AA17543
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727371; cv=none; b=aGUWIhgbJKPbKG1f66G/P0C8azEPRl8QFTSLaTN0ePFzh75DLpcWcaGIztc+jYdzJqt5QRPHMYjxQv24LoSQ9j4SqX5jvuOurkdjnYvB9lPbg4bLkpF75k8WREHYarKdE4DrMPj4znoegVIISGfiUCMSUIR6aqPDZY2ZRbEPFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727371; c=relaxed/simple;
	bh=lL4XVJKQ4PYD2MIolPkDp9WDQAXMT2w6r/O/ovYALwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLtCSMuClQgK2KE7ZkydzI80km6GnYybPCRK0iyDj5R31Ynw7+fhCc+BImp8er4LMngAxUs/I5HnUtdZkJFS0WEZ0Z0SmwxVqrQiFkqB2JCN18lVX78+bMXqxhrNoj8Fbp7mv5FpwhW6Osgc/gAwoXWAz/Yjx86aZ4zl4MoJZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WtBx32WTPz16PFX;
	Tue, 27 Aug 2024 10:55:19 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BC2C718007C;
	Tue, 27 Aug 2024 10:56:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 10:56:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 2/3] drm/rockchip: Simplified with dev_err() and __free()
Date: Tue, 27 Aug 2024 11:03:56 +0800
Message-ID: <20240827030357.1006220-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827030357.1006220-1-ruanjinjie@huawei.com>
References: <20240827030357.1006220-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoid need to manually handle of_node_put() by using __free(), and use
dev_err() to replace deprecated() DRM_DEV_ERROR(), which can simplfy
code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 38 ++++++++----------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index f5b3f18794dd..700ac730887d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -548,16 +548,14 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	struct drm_encoder *encoder;
 	struct drm_connector *connector;
 	struct device_node *remote = NULL;
-	struct device_node  *port;
 	int ret = 0, child_count = 0;
 	const char *name;
 	u32 endpoint_id = 0;
 
 	lvds->drm_dev = drm_dev;
-	port = of_graph_get_port_by_id(dev->of_node, 1);
+	struct device_node *port __free(device_node) = of_graph_get_port_by_id(dev->of_node, 1);
 	if (!port) {
-		DRM_DEV_ERROR(dev,
-			      "can't found port point, please init lvds panel port!\n");
+		dev_err(dev, "can't found port point, please init lvds panel port!\n");
 		return -EINVAL;
 	}
 	for_each_child_of_node_scoped(port, endpoint) {
@@ -569,13 +567,10 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 			break;
 	}
 	if (!child_count) {
-		DRM_DEV_ERROR(dev, "lvds port does not have any children\n");
-		ret = -EINVAL;
-		goto err_put_port;
-	} else if (ret) {
-		dev_err_probe(dev, ret, "failed to find panel and bridge node\n");
-		goto err_put_port;
-	}
+		dev_err(dev, "lvds port does not have any children\n");
+		return -EINVAL;
+	} else if (ret)
+		return dev_err_probe(dev, ret, "failed to find panel and bridge node\n");
 	if (lvds->panel)
 		remote = lvds->panel->dev->of_node;
 	else
@@ -587,7 +582,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		lvds->output = rockchip_lvds_name_to_output(name);
 
 	if (lvds->output < 0) {
-		DRM_DEV_ERROR(dev, "invalid output type [%s]\n", name);
+		dev_err(dev, "invalid output type [%s]\n", name);
 		ret = lvds->output;
 		goto err_put_remote;
 	}
@@ -599,7 +594,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		lvds->format = rockchip_lvds_name_to_format(name);
 
 	if (lvds->format < 0) {
-		DRM_DEV_ERROR(dev, "invalid data-mapping format [%s]\n", name);
+		dev_err(dev, "invalid data-mapping format [%s]\n", name);
 		ret = lvds->format;
 		goto err_put_remote;
 	}
@@ -610,8 +605,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS);
 	if (ret < 0) {
-		DRM_DEV_ERROR(drm_dev->dev,
-			      "failed to initialize encoder: %d\n", ret);
+		dev_err(drm_dev->dev, "failed to initialize encoder: %d\n", ret);
 		goto err_put_remote;
 	}
 
@@ -624,8 +618,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 					 &rockchip_lvds_connector_funcs,
 					 DRM_MODE_CONNECTOR_LVDS);
 		if (ret < 0) {
-			DRM_DEV_ERROR(drm_dev->dev,
-				      "failed to initialize connector: %d\n", ret);
+			dev_err(drm_dev->dev, "failed to initialize connector: %d\n", ret);
 			goto err_free_encoder;
 		}
 
@@ -639,9 +632,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 		connector = drm_bridge_connector_init(lvds->drm_dev, encoder);
 		if (IS_ERR(connector)) {
-			DRM_DEV_ERROR(drm_dev->dev,
-				      "failed to initialize bridge connector: %pe\n",
-				      connector);
+			dev_err(drm_dev->dev, "failed to initialize bridge connector: %pe\n",
+				connector);
 			ret = PTR_ERR(connector);
 			goto err_free_encoder;
 		}
@@ -649,14 +641,12 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret < 0) {
-		DRM_DEV_ERROR(drm_dev->dev,
-			      "failed to attach encoder: %d\n", ret);
+		dev_err(drm_dev->dev, "failed to attach encoder: %d\n", ret);
 		goto err_free_connector;
 	}
 
 	pm_runtime_enable(dev);
 	of_node_put(remote);
-	of_node_put(port);
 
 	return 0;
 
@@ -666,8 +656,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	drm_encoder_cleanup(encoder);
 err_put_remote:
 	of_node_put(remote);
-err_put_port:
-	of_node_put(port);
 
 	return ret;
 }
-- 
2.34.1


