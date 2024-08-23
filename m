Return-Path: <linux-kernel+bounces-298573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A849095C8FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A17283A75
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A4D16EB79;
	Fri, 23 Aug 2024 09:13:25 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088514B082
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404405; cv=none; b=Zw80a9kEdRf6j9Lwng8Djf3AT53/SUE2lPzhsj/qeV+tE3q5jKrW4KMdWbZ7hMViHuYUeRaI4P0cV4DEmjWEn4NQxf1PJQK7XgZ01oAdeAD1ToKrFUZyVmVoOFdX7g1b2efFIC4xSGLykZwRS4eWVbZI3X9uKn3DntaP4dpiKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404405; c=relaxed/simple;
	bh=8SD4/pr8QBYlpewFcQP7Rqn7BjPSOF+URTCVIpMUIZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFIdXcKYEubpRRyFW8NzWBseB6aWrh8w+WPAExZiNEwdXM3W4ZdaxOnRwjrCT8TDf2pi7iMt/e7aOdKSgdFkygbFaamWbgPnkzpDoT6Trs9ET5LE706a8nZXMjNye9GRnwwb8iUBp+YC4JQ/uzdZYts9BJokk/iuAlVfUQqYFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WqvSs3FRlz1xvwW;
	Fri, 23 Aug 2024 17:11:25 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id CDDF914013B;
	Fri, 23 Aug 2024 17:13:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 17:13:20 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 4/5] drm/nouveau: Use for_each_child_of_node_scoped()
Date: Fri, 23 Aug 2024 17:20:52 +0800
Message-ID: <20240823092053.3170445-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823092053.3170445-1-ruanjinjie@huawei.com>
References: <20240823092053.3170445-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoids the need for manual cleanup of_node_put() in early exits
from the loop.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index b06aa473102b..8d5c9c74cbb9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -477,14 +477,14 @@ nouveau_connector_of_detect(struct drm_connector *connector)
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_encoder *nv_encoder;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	struct device_node *cn, *dn = pci_device_to_OF_node(pdev);
+	struct device_node *dn = pci_device_to_OF_node(pdev);
 
 	if (!dn ||
 	    !((nv_encoder = find_encoder(connector, DCB_OUTPUT_TMDS)) ||
 	      (nv_encoder = find_encoder(connector, DCB_OUTPUT_ANALOG))))
 		return NULL;
 
-	for_each_child_of_node(dn, cn) {
+	for_each_child_of_node_scoped(dn, cn) {
 		const char *name = of_get_property(cn, "name", NULL);
 		const void *edid = of_get_property(cn, "EDID", NULL);
 		int idx = name ? name[strlen(name) - 1] - 'A' : 0;
@@ -492,7 +492,6 @@ nouveau_connector_of_detect(struct drm_connector *connector)
 		if (nv_encoder->dcb->i2c_index == idx && edid) {
 			nv_connector->edid =
 				kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
-			of_node_put(cn);
 			return nv_encoder;
 		}
 	}
-- 
2.34.1


