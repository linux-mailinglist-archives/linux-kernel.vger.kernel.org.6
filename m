Return-Path: <linux-kernel+bounces-298574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF5795C8FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4EE283AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0877217ADFB;
	Fri, 23 Aug 2024 09:13:26 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83E14AD3E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404405; cv=none; b=aCMOCzux+eu3adC3s+fi7FpTjxKnEzFICtcVfbxWnZjzd5LaPGxHBId76innl1vkguqEDpD03Fxoc3prflLfe4a15bhOGTz3qWYhB7JceErMW8A8oPc5wIMH+Gh8s89UYz77yEdlvjIQnfmqvOCplST6b78b5DFUXJex4SWjaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404405; c=relaxed/simple;
	bh=Jv3t2nZiJKu1gTtbsCkqlOQGSwrhTUy406Ne9iQCaq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0wDsbHVa1JDaacikqLectHo5djo/Ihb/wYzy5tk/BLZbKmzJ9UBhUPF7NOAHxbjr4LNsCpUBc80/4RQKPdOuU0xgEdqW4NJ1l/Gem3oXG/sBqfqGsjcjKXxigrLvNP/ePM4y7HXpM0PeAtDuIBtRxf49rm/yKj8zqzCBYD4m98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WqvVH6mtQz13dVH;
	Fri, 23 Aug 2024 17:12:39 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E37718005F;
	Fri, 23 Aug 2024 17:13:21 +0800 (CST)
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
Subject: [PATCH -next 5/5] gpu: host1x: Use for_each_available_child_of_node_scoped()
Date: Fri, 23 Aug 2024 17:20:53 +0800
Message-ID: <20240823092053.3170445-6-ruanjinjie@huawei.com>
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
 drivers/gpu/host1x/bus.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 8e09d6d328d2..344cc9e741c1 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -41,7 +41,6 @@ static int host1x_subdev_add(struct host1x_device *device,
 			     struct device_node *np)
 {
 	struct host1x_subdev *subdev;
-	struct device_node *child;
 	int err;
 
 	subdev = kzalloc(sizeof(*subdev), GFP_KERNEL);
@@ -56,13 +55,12 @@ static int host1x_subdev_add(struct host1x_device *device,
 	mutex_unlock(&device->subdevs_lock);
 
 	/* recursively add children */
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_match_node(driver->subdevs, child) &&
 		    of_device_is_available(child)) {
 			err = host1x_subdev_add(device, driver, child);
 			if (err < 0) {
 				/* XXX cleanup? */
-				of_node_put(child);
 				return err;
 			}
 		}
@@ -90,17 +88,14 @@ static void host1x_subdev_del(struct host1x_subdev *subdev)
 static int host1x_device_parse_dt(struct host1x_device *device,
 				  struct host1x_driver *driver)
 {
-	struct device_node *np;
 	int err;
 
-	for_each_child_of_node(device->dev.parent->of_node, np) {
+	for_each_child_of_node_scoped(device->dev.parent->of_node, np) {
 		if (of_match_node(driver->subdevs, np) &&
 		    of_device_is_available(np)) {
 			err = host1x_subdev_add(device, driver, np);
-			if (err < 0) {
-				of_node_put(np);
+			if (err < 0)
 				return err;
-			}
 		}
 	}
 
-- 
2.34.1


