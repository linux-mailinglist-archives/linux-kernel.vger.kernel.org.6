Return-Path: <linux-kernel+bounces-409379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4432C9C8BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A924A1F22A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F5E70814;
	Thu, 14 Nov 2024 13:37:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0021CABA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591463; cv=none; b=tXGyKOWgTZYZbO1lAeFM36mFTd+JzV9r5GdcDiTaayTRQtN2UPwpzbl3aTiSiXa1ErWjXv40PlrzxBtB6UxPTvYHCdIuWEy+VjhMQsxh75qmRqLo0CkEigqMxXj+wY5YBpQZK8qwHiduC/G8tzxdmrIdySw6lbitOyQPGhzQqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591463; c=relaxed/simple;
	bh=PGxF3m2fnowrGpIAeH+ctVswHzK24kfB5mNKbpYcUbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md7JOFFcG3obQP4qZOZYI+abVwMK56gK52DxIrerX8HGd0MxJA5Z1rS6+ElZ0IapUmt3ak2CoOE53xjk/7IsFE8us0ZBsvCYU8l6gThFh/YdPff542/Xc/0KooPtWlN/FNn+ThmlFe7cZZh0P9ugaW7ug7fOciUxCs5wuQKvzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xq1PZ3H22zpb0m;
	Thu, 14 Nov 2024 21:35:46 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id EA53E18005F;
	Thu, 14 Nov 2024 21:37:38 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Nov
 2024 21:37:38 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <Dave.Martin@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH mpam mpam/snapshot/v6.11-rc1 3/6] arm_mpam: Create reqPARTIDs resource bitmap
Date: Thu, 14 Nov 2024 21:50:34 +0800
Message-ID: <20241114135037.918470-4-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241114135037.918470-1-zengheng4@huawei.com>
References: <20241114135037.918470-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The driver checks whether mpam_partid_max and mpam_intpartid_max are equal
as a basis for supporting reqPARTID. If this feature is supported, use a
bitmap to represent whether the target reqPARTID is available or not.
Create the bitmap during monitor initialization, and the destructor is
called during the monitor exit process.

It is noted that the reqpartid_free_map reserves the first reqPARTID under
each intPARTID (which is equal to the corresponding intPARTID itself). By
default, assigns it to the corresponding control group for use in
monitoring.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index a74133d7b402..01ad6732eac5 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -1000,6 +1000,33 @@ static void mpam_resctrl_monitor_init(struct mpam_class *class,
 	return;
 }
 
+static unsigned long *reqpartid_free_map;
+static int reqpartid_free_map_len;
+
+static int reqpartid_create(void)
+{
+	u32 reqpartid_num = get_num_reqpartid();
+	int i;
+
+	reqpartid_free_map = bitmap_alloc(reqpartid_num, GFP_KERNEL);
+	if (!reqpartid_free_map)
+		return -ENOMEM;
+
+	bitmap_fill(reqpartid_free_map, reqpartid_num);
+
+	/* Reserved for the internal partIDs mapping */
+	for (i = 0; i < resctrl_arch_get_num_closid(NULL); i++)
+		__clear_bit(i, reqpartid_free_map);
+
+	reqpartid_free_map_len = reqpartid_num;
+	return 0;
+}
+
+static void reqpartid_destroy(void)
+{
+	bitmap_free(reqpartid_free_map);
+}
+
 int mpam_resctrl_setup(void)
 {
 	int err = 0;
@@ -1047,6 +1074,10 @@ int mpam_resctrl_setup(void)
 
 	cpus_read_unlock();
 
+	err = reqpartid_create();
+	if (err)
+		return err;
+
 	if (!err && !exposed_alloc_capable && !exposed_mon_capable)
 		err = -EOPNOTSUPP;
 
@@ -1075,6 +1106,8 @@ static void mpam_resctrl_exit(void)
 
 	WRITE_ONCE(resctrl_enabled, false);
 	resctrl_exit();
+
+	reqpartid_destroy();
 }
 
 
-- 
2.25.1


