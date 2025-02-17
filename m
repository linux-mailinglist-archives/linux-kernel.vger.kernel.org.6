Return-Path: <linux-kernel+bounces-516943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD5A37A04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883DA18913C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B218DB23;
	Mon, 17 Feb 2025 03:09:16 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE31D1891A8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739761755; cv=none; b=l47O1jGrBHPZYMmF6syesjsJIlqiXVkiAlYvzd3H1XBRU+RdTQ75D0kHaVV5FCyofhUPXwORBvb0BUE3W8Gmfh9mA96HXjnVGr5XgbX+N6UZ0tRV/dIA6M08kRS2FdEikbiwaW33J27C9P0kVGa+nybekfHEy0d1WZZI+6hlCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739761755; c=relaxed/simple;
	bh=kqiJAhMLa9R2vxhmokjZSt78eF1fFQFqNttKXTgYYd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1M5dC6j33/qdFipA0p/c+JJDLAoXxKwve0Yx2L/zvl5w7tiCwus+QKIA7lzc/HLX7WIUnjdUAlxpeSVK0jb4z/t8pe4wszmxbQRpRGqhlHSY2rRGEb7InLfIHGqhroMjnoR9f2/cV6z+3sv15vU34sgWJ+FbFy6/rZNNZSlfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Yx6vN4T9xz1Y1q7;
	Mon, 17 Feb 2025 11:04:32 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id A50F11800EC;
	Mon, 17 Feb 2025 11:09:05 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Feb
 2025 11:09:04 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH mpam mpam/snapshot/v6.14-rc1 2/5] arm_mpam: Add limitation for the Narrow-PARTID feature
Date: Mon, 17 Feb 2025 11:18:49 +0800
Message-ID: <20250217031852.2014939-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217031852.2014939-1-zengheng4@huawei.com>
References: <20250217031852.2014939-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Because it needs to support mixed systems that include MSCs with and
without Narrow-PARTID support, there are the following incompatible
control issues.

If an MSC does not support Narrow-PARTID and its control method is not of
the "partition bitmap" type, then delivering the resctrl control group
configuration across multiple PARTIDs will change the user's expected
behavior.

Currently, there is no way to solve this problem by programming different
control values simply, so here decide to restrict the usage scenarios of
this feature. When we find that the MATA MSC does not support the
Narrow-PARTID feature, the driver will disable the feature, which means
get_num_reqpartid() directly returns the number of intPARTIDs.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index eedd308d9c88..f3f8fb0ff421 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -168,6 +168,21 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *ignored)
 
 static u32 get_num_reqpartid(void)
 {
+	struct mpam_resctrl_res *res;
+	struct rdt_resource *r_mba;
+	struct mpam_props *cprops;
+
+	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+	res = container_of(r_mba, struct mpam_resctrl_res, resctrl_res);
+	cprops = &res->class->props;
+
+	/*
+	 * If the MBA does not support Narrow-PARTID,
+	 * then the feature should be disabled at the system level.
+	 */
+	if (!mpam_has_feature(mpam_feat_partid_nrw, cprops))
+		return resctrl_arch_get_num_closid(NULL);
+
 	return mpam_partid_max + 1;
 }
 
-- 
2.25.1


