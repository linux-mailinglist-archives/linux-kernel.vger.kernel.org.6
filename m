Return-Path: <linux-kernel+bounces-527136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D240A407D2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D983119C2D77
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27190207A2A;
	Sat, 22 Feb 2025 11:15:23 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7097713BC0E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740222922; cv=none; b=IzNVrfSJjLi5UAP8a6UEhmRDnkHAMfkdp5c37dW3V4ILmOsdcDVF5kW0WSmkhVZE1lqb0Z3lGPNIWKHzAM+xZqsor4+qz0Vcpde31OXHifr+CCWC+rO7w0D4yD1sTYl4YDFRoRKYtvTSkUoLKIaa2MqFOrQeFyjA4R9TH0gG7eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740222922; c=relaxed/simple;
	bh=kqiJAhMLa9R2vxhmokjZSt78eF1fFQFqNttKXTgYYd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwkZB4FPPdeTKdS/0tSTTn/vFM+ofyfd2boTtX2Jw6x+M17cvEw7Y6FSy1bk7UvGpDZqZJDu6TBg/d2RFfIOHbsBfuAfNZM9ednfUq9D7J4PzRMtfnZwxPZzFuRFDfVJv4RS2V+0sNaxtix7Kdc1dRqIuyW/bPQuCWTZAZJVG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Z0PRw5SYnz1GCL0;
	Sat, 22 Feb 2025 19:10:36 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id B1327180103;
	Sat, 22 Feb 2025 19:15:16 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 22 Feb
 2025 19:15:16 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH mpam mpam/snapshot/v6.14-rc1 v2 2/5] arm_mpam: Add limitation for the Narrow-PARTID feature
Date: Sat, 22 Feb 2025 19:24:45 +0800
Message-ID: <20250222112448.2438586-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250222112448.2438586-1-zengheng4@huawei.com>
References: <20250222112448.2438586-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


