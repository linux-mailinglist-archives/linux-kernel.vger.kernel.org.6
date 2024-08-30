Return-Path: <linux-kernel+bounces-308198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199D7965896
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B54E1C209C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11D16DEA3;
	Fri, 30 Aug 2024 07:28:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2C16DC01
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002935; cv=none; b=VXaxGQ5+LKZeJgeCBlCwYBsX5TC2kxwYXFwc8WkFMmSol/Tu96JulTkO+aIsg8J7AbFHhJMgzjQifTwc/NxnaXMD3sfivBZhIQtydN9G8rropKqOvxBQ4HtPALfa3tTMjK1EZf+XH78a+S7sp+93oUYgz9XNpENtpI6ceuiY2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002935; c=relaxed/simple;
	bh=H2QEufYRWIldcrFXfbojbY60QT1tGRsknvAzFJ64mZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=opqcwk6fzILQP5uKu3DVjFUmUcPxC7d/VZ+W0wlA+6P8R70uuTzQu1T6hmWr9vlDuIlAQbeg3HetHiYsXMsJ2TzUCIPVP9XQMlUMUpQjmPQihXNSWtPcPk4MfdG/pO/8yGEjxlufDbe6chjZKUlhc0dLSO/+c32jtG74iheXjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ww8pl5ZhbzLr08;
	Fri, 30 Aug 2024 15:26:39 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BCFA140202;
	Fri, 30 Aug 2024 15:28:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 15:28:44 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <kherbst@redhat.com>, <lyude@redhat.com>, <dakr@redhat.com>,
	<airlied@gmail.com>, <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] drm/nouveau: Use for_each_child_of_node_scoped()
Date: Fri, 30 Aug 2024 15:36:54 +0800
Message-ID: <20240830073654.3539640-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoids the need for manual cleanup of_node_put() in early exits
from the loop.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Split out from the patch set.
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


