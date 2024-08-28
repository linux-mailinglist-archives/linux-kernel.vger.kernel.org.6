Return-Path: <linux-kernel+bounces-304606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39696226C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B691F25E85
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB4515DBDD;
	Wed, 28 Aug 2024 08:41:36 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53115D5A6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834496; cv=none; b=uPMHIFmUFLlQRjIF/pPQ7GCXW9NSrhlv6iLhlZnzTZqPfoDSLyYF16v9+LWIZWg4DTK07yMgYbU9JDqrjYgPEkycAfI/C1vmZEvDd1c2Wao4sQ6mDRnLxd/Ti2DtEN3QwKEpfeRIDhC2EuiP5jBvCQuOpY7nPPT8LOHB5mbkp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834496; c=relaxed/simple;
	bh=rWmCPxypz7qxULMK7KcjNspyMv3rla32W8XHVkUoxiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iKQ9p51dvTx25Y4bNd/xU6Cu8ai0sZDU7d0yyW/yp74U1O8/r0NrIUvxNDhcW7wJafWVqHmlgKu/nh8alDLWgH+injuO/NZvgL7wTaZ+y63uWqcwDLIPxY20Tr1rkl2dcHTQxuKbVFdyygP/g4n9BzE1PjoEexyFD0/PN9HX4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtyWg4v6gzfbhN;
	Wed, 28 Aug 2024 16:39:27 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 84E13180087;
	Wed, 28 Aug 2024 16:41:31 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 16:41:30 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <laurent.pinchart@ideasonboard.com>, <tomi.valkeinen@ideasonboard.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<michal.simek@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] drm: zynqmp_dp: Use devm_platform_ioremap_resource_byname()
Date: Wed, 28 Aug 2024 16:49:29 +0800
Message-ID: <20240828084929.2527228-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

platform_get_resource_byname() and devm_ioremap_resource() can be
replaced by devm_platform_ioremap_resource_byname(), which can
simplify the code logic a bit, No functional change here.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 129beac4c073..4eb19ac95bdb 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1715,7 +1715,6 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	struct platform_device *pdev = to_platform_device(dpsub->dev);
 	struct drm_bridge *bridge;
 	struct zynqmp_dp *dp;
-	struct resource *res;
 	int ret;
 
 	dp = kzalloc(sizeof(*dp), GFP_KERNEL);
@@ -1729,8 +1728,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
 	INIT_WORK(&dp->hpd_work, zynqmp_dp_hpd_work_func);
 
 	/* Acquire all resources (IOMEM, IRQ and PHYs). */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dp");
-	dp->iomem = devm_ioremap_resource(dp->dev, res);
+	dp->iomem = devm_platform_ioremap_resource_byname(pdev, "dp");
 	if (IS_ERR(dp->iomem)) {
 		ret = PTR_ERR(dp->iomem);
 		goto err_free;
-- 
2.34.1


