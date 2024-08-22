Return-Path: <linux-kernel+bounces-296796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F895AF3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2743E2843A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486C813C812;
	Thu, 22 Aug 2024 07:26:50 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277642A9B;
	Thu, 22 Aug 2024 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311609; cv=none; b=Yt9f1ORFbaS80qI3dZTZRnbvMJW0bS1GdyPQFyWrdrUCOSJQeUeACFYObaA4Z8p4UeOFaxfig+Zgfwgedmvz+Rw6cD3/fyDCmkE+I7q86ez8tIArWhuNDtVhqXXj8Uay2XFz6MJkVILGnmmONTz7SGN0Gl/6+Q1TmDKab+FsA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311609; c=relaxed/simple;
	bh=9Bx+mlTFJh7CVQogVmIRk06zCokEZG5UXiMI/hIhcH4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DftD7qYyniAmytFjYKkMqijwYpbnQ8eBjfiXuVjqZ9ICwdzgdAcNV8o/o4115sihdEe8kauYKJ8kkrxlPEq86Sa1xdbIkMfKfCfrOlQ8rIGqfhbk47mhJQf2haDaP5nAW8AEl5PC6/sYWfR+cWOKyP2tIwx8B6i8b4lSznzk9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqF552k97z69MB;
	Thu, 22 Aug 2024 15:22:01 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 678E918009B;
	Thu, 22 Aug 2024 15:26:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Aug
 2024 15:26:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <robh@kernel.org>, <saravanak@google.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] of/platform: Simplify with scoped for each OF child
Date: Thu, 22 Aug 2024 15:34:17 +0800
Message-ID: <20240822073417.3582286-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/of/platform.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 86be4dfb9323..ebc8f0359a95 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -338,7 +338,6 @@ static int of_platform_bus_create(struct device_node *bus,
 				  struct device *parent, bool strict)
 {
 	const struct of_dev_auxdata *auxdata;
-	struct device_node *child;
 	struct platform_device *dev;
 	const char *bus_id = NULL;
 	void *platform_data = NULL;
@@ -382,13 +381,11 @@ static int of_platform_bus_create(struct device_node *bus,
 	if (!dev || !of_match_node(matches, bus))
 		return 0;
 
-	for_each_child_of_node(bus, child) {
+	for_each_child_of_node_scoped(bus, child) {
 		pr_debug("   create child: %pOF\n", child);
 		rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
-		if (rc) {
-			of_node_put(child);
+		if (rc)
 			break;
-		}
 	}
 	of_node_set_flag(bus, OF_POPULATED_BUS);
 	return rc;
@@ -459,7 +456,6 @@ int of_platform_populate(struct device_node *root,
 			const struct of_dev_auxdata *lookup,
 			struct device *parent)
 {
-	struct device_node *child;
 	int rc = 0;
 
 	root = root ? of_node_get(root) : of_find_node_by_path("/");
@@ -470,12 +466,10 @@ int of_platform_populate(struct device_node *root,
 	pr_debug(" starting at: %pOF\n", root);
 
 	device_links_supplier_sync_state_pause();
-	for_each_child_of_node(root, child) {
+	for_each_child_of_node_scoped(root, child) {
 		rc = of_platform_bus_create(child, matches, lookup, parent, true);
-		if (rc) {
-			of_node_put(child);
+		if (rc)
 			break;
-		}
 	}
 	device_links_supplier_sync_state_resume();
 
-- 
2.34.1


