Return-Path: <linux-kernel+bounces-308122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CEE965793
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8334B22725
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D31531D5;
	Fri, 30 Aug 2024 06:24:28 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1D482DD
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999067; cv=none; b=OB2VzhJk8xZnHPU8qqwqrhl0YyC5KKXROcLw4OxUKADAtyI9zOGEZzfBb6ko1hi1YC3ny8zqWkjVHLN4NkTdTgr/Jmc4w4cNbsEaplQnrYRQ/9T51ehLc90pV0K7CIK0cnmgJ+Gio8FnMudbVxGkBNc8uDacPsLwVHFGMYdQRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999067; c=relaxed/simple;
	bh=49IQeLOULWHmDKOrDfXIlbTQuX/7ep0g4VwWqiW3INs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V74HzjPcDGbIxKFsIGoC55QaMec2Hys9abXOEHJnpOn7v4/zLg9IuPwANU6tgo/5zl3JqAOTFR7lVEtkq9THnwYKJGNxQ3CdFeYVwyWugPztJuiWUrl3Q3HbkvUxWQqsU8TFeIIBWRXRfonCggCTfuz9e1lhvWuvhTNXST+E0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ww7KG6ScQz20llM;
	Fri, 30 Aug 2024 14:19:30 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 42F0A140136;
	Fri, 30 Aug 2024 14:24:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 14:24:21 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <nm@ti.com>, <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 3/4] soc: ti: knav_qmss_queue: Simplify with scoped for each OF child loop
Date: Fri, 30 Aug 2024 14:32:27 +0800
Message-ID: <20240830063228.3519385-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830063228.3519385-1-ruanjinjie@huawei.com>
References: <20240830063228.3519385-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Split into 2 patches.
- Rebased the newest next.
- Update the commit message.
---
 drivers/soc/ti/knav_qmss_queue.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6c98738e548a..02983f8ba1b6 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1082,7 +1082,6 @@ static int knav_queue_setup_regions(struct knav_device *kdev,
 	struct device_node *regions __free(device_node) =
 			of_get_child_by_name(node, "descriptor-regions");
 	struct knav_region *region;
-	struct device_node *child;
 	u32 temp[2];
 	int ret;
 
@@ -1090,10 +1089,9 @@ static int knav_queue_setup_regions(struct knav_device *kdev,
 		return dev_err_probe(dev, -ENODEV,
 				     "descriptor-regions not specified\n");
 
-	for_each_child_of_node(regions, child) {
+	for_each_child_of_node_scoped(regions, child) {
 		region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
 		if (!region) {
-			of_node_put(child);
 			dev_err(dev, "out of memory allocating region\n");
 			return -ENOMEM;
 		}
@@ -1400,7 +1398,6 @@ static int knav_queue_init_qmgrs(struct knav_device *kdev,
 	struct device_node *qmgrs __free(device_node) =
 			of_get_child_by_name(node, "qmgrs");
 	struct knav_qmgr_info *qmgr;
-	struct device_node *child;
 	u32 temp[2];
 	int ret;
 
@@ -1408,10 +1405,9 @@ static int knav_queue_init_qmgrs(struct knav_device *kdev,
 		return dev_err_probe(dev, -ENODEV,
 				     "queue manager info not specified\n");
 
-	for_each_child_of_node(qmgrs, child) {
+	for_each_child_of_node_scoped(qmgrs, child) {
 		qmgr = devm_kzalloc(dev, sizeof(*qmgr), GFP_KERNEL);
 		if (!qmgr) {
-			of_node_put(child);
 			dev_err(dev, "out of memory allocating qmgr\n");
 			return -ENOMEM;
 		}
@@ -1506,12 +1502,10 @@ static int knav_queue_init_pdsps(struct knav_device *kdev,
 {
 	struct device *dev = kdev->dev;
 	struct knav_pdsp_info *pdsp;
-	struct device_node *child;
 
-	for_each_child_of_node(pdsps, child) {
+	for_each_child_of_node_scoped(pdsps, child) {
 		pdsp = devm_kzalloc(dev, sizeof(*pdsp), GFP_KERNEL);
 		if (!pdsp) {
-			of_node_put(child);
 			dev_err(dev, "out of memory allocating pdsp\n");
 			return -ENOMEM;
 		}
-- 
2.34.1


