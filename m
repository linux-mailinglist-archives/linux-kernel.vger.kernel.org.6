Return-Path: <linux-kernel+bounces-409380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB29C8BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC388288B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520C013AA20;
	Thu, 14 Nov 2024 13:37:45 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827E1CF96
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591464; cv=none; b=AHO0lyA9bfW45ZtdNMvJTZfHZ6QwdZUvS+pYCm/YSILMc+NN0Elk4zM/KRNfJ7b0m/d2+F6x11ZkhqHctU8GdaLgJVw5esHVDv5BozPysT/iBwmRuwlJUbUVmnE2t6LCesz3d9oSeIIctef1EFORo4j0MRJb89yDt9nEct9Bnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591464; c=relaxed/simple;
	bh=BAgBY1eIFqv7my3fLgTDkmpgkn4wk+M1r2b9LjTHAH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BS5byFOchw+sajEICN1TDqsQwj71TVwp6Ye4iztQh1QTsCVOrQamUqPlvLTHszWqLbJcU/uXcHPWGRybDJvK+1GY+kRvyJNKnu0glzt1aLVJKXMjFGjnOrkhSpZgjwUtHp8Bca8XVYZqpp+6LzCWauWbWpwSXBeMghAkNtC3PhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xq1Nf6ZwbzDrDW;
	Thu, 14 Nov 2024 21:34:58 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B4471400FF;
	Thu, 14 Nov 2024 21:37:39 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Nov
 2024 21:37:38 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <Dave.Martin@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH mpam mpam/snapshot/v6.11-rc1 4/6] arm_mpam: Enhance the rmid allocation strategy
Date: Thu, 14 Nov 2024 21:50:35 +0800
Message-ID: <20241114135037.918470-5-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241114135037.918470-1-zengheng4@huawei.com>
References: <20241114135037.918470-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100008.china.huawei.com (7.202.181.222)

resctrl_arch_alloc_rmid() provides the similar functionality as
alloc_rmid(), but it is an enhanced version based on different architecture
implementations.

For the new rmid allocation strategy, it will check whether there is an
available rmid of any reqPARTID which belongs to the input intPARTID.

The MPAM driver statically assigns all reqPARTIDs to respective intPARTIDs,
with a specific illustration as follows:

m - Indicates the number of reqPARTIDs per intPARTID
n - Indicates the total number of intPARTIDs
(m * n) - Represents the total number of reqPARTIDs

intPARTID_1 = 0
    ├── reqPARTID_1_1 = 0
    ├── reqPARTID_1_2 = 0 + n
    ├── ...
    └── reqPARTID_1_m = 0 + n * (m - 1)

intPARTID_2 = 1
    ├── reqPARTID_2_1 = 1
    ├── reqPARTID_2_2 = 1 + n
    ├── ...
    └── reqPARTID_2_m = 1 + n * (m - 1)

...

intPARTID_n = (n - 1)

Each intPARTID has m reqPARTIDs, which are used to expand the number of
monitoring groups under the control group. Therefore, the number of
monitoring groups is no longer limited by the range of MPAM PMG, which
enhances the extensibility of the system's monitoring capabilities.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 arch/x86/kernel/cpu/resctrl/core.c         | 15 ++++++++
 drivers/platform/arm64/mpam/mpam_resctrl.c | 41 ++++++++++++++++++++--
 fs/resctrl/internal.h                      |  2 --
 fs/resctrl/pseudo_lock.c                   |  3 +-
 fs/resctrl/rdtgroup.c                      |  3 +-
 include/linux/resctrl.h                    | 16 +++++++++
 6 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b8aa6faf100a..60889ae61bfc 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -693,6 +693,21 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		domain_remove_cpu_mon(cpu, r);
 }
 
+int resctrl_arch_alloc_rmid(u32 *closid, u32 *rmid)
+{
+	int ret;
+
+	if (!closid || !rmid)
+		return -EINVAL;
+
+	ret = alloc_rmid(*closid);
+	if (ret < 0)
+		return ret;
+
+	*rmid = ret;
+	return 0;
+}
+
 static void clear_closid_rmid(int cpu)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index 01ad6732eac5..ecb3438379bc 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -171,6 +171,11 @@ static u32 get_num_reqpartid(void)
 	return mpam_partid_max + 1;
 }
 
+static u32 get_num_reqpartid_per_closid(void)
+{
+	return get_num_reqpartid() / resctrl_arch_get_num_closid(NULL);
+}
+
 u32 resctrl_arch_system_num_rmid_idx(void)
 {
 	u8 closid_shift = fls(mpam_pmg_max);
@@ -182,10 +187,11 @@ u32 resctrl_arch_system_num_rmid_idx(void)
 u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
 {
 	u8 closid_shift = fls(mpam_pmg_max);
+	u32 pmg_mask = ~(~0 << closid_shift);
 
 	BUG_ON(closid_shift > 8);
 
-	return (closid << closid_shift) | rmid;
+	return (closid << closid_shift) | (rmid & pmg_mask);
 }
 
 void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
@@ -195,8 +201,10 @@ void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
 
 	BUG_ON(closid_shift > 8);
 
-	*closid = idx >> closid_shift;
-	*rmid = idx & pmg_mask;
+	if (closid)
+		*closid = idx >> closid_shift;
+	if (rmid)
+		*rmid = idx & pmg_mask;
 }
 
 void resctrl_arch_sched_in(struct task_struct *tsk)
@@ -1027,6 +1035,33 @@ static void reqpartid_destroy(void)
 	bitmap_free(reqpartid_free_map);
 }
 
+int resctrl_arch_alloc_rmid(u32 *closid, u32 *rmid)
+{
+	int closid_num = resctrl_arch_get_num_closid(NULL);
+	int i, reqpartid, pmg;
+
+	if (!closid || !rmid)
+		return -EINVAL;
+
+	/* The closid is out of the range of intPARTIDs */
+	if (*closid >= closid_num)
+		return -EINVAL;
+
+	for (i = 0; i < get_num_reqpartid_per_closid(); i++) {
+		reqpartid = i * closid_num + *closid;
+		pmg = alloc_rmid(reqpartid);
+		if (pmg >= 0)
+			break;
+	}
+
+	if (pmg < 0)
+		return pmg;
+
+	*closid = reqpartid;
+	*rmid = pmg;
+	return 0;
+}
+
 int mpam_resctrl_setup(void)
 {
 	int err = 0;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 4298d45d1851..08cf21186448 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -325,8 +325,6 @@ int closids_supported(void);
 
 void closid_free(int closid);
 
-int alloc_rmid(u32 closid);
-
 void free_rmid(u32 closid, u32 rmid);
 
 void resctrl_mon_resource_exit(void);
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index ef2a277764f9..11532c5a5fed 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -582,12 +582,11 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 	int ret;
 
 	if (resctrl_arch_mon_capable()) {
-		ret = alloc_rmid(rdtgrp->closid);
+		ret = resctrl_arch_alloc_rmid(&rdtgrp->closid, &rdtgrp->mon.rmid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Out of RMIDs\n");
 			return ret;
 		}
-		rdtgrp->mon.rmid = ret;
 	}
 
 	ret = rdtgroup_locksetup_user_restore(rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 7f7586af8def..b5748fce933f 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3280,12 +3280,11 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	if (!resctrl_arch_mon_capable())
 		return 0;
 
-	ret = alloc_rmid(rdtgrp->closid);
+	ret = resctrl_arch_alloc_rmid(&rdtgrp->closid, &rdtgrp->mon.rmid);
 	if (ret < 0) {
 		rdt_last_cmd_puts("Out of RMIDs\n");
 		return ret;
 	}
-	rdtgrp->mon.rmid = ret;
 
 	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a1a96d928c37..ec679cfad5fb 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -510,6 +510,22 @@ static inline void resctrl_arch_rmid_read_context_check(void)
 		might_sleep();
 }
 
+int alloc_rmid(u32 closid);
+/**
+ * resctrl_arch_alloc_rmid() - Providing the similar functionality as
+ *			       alloc_rmid, but this function is an
+ *			       enhanced version based on different
+ *			       architecture implementations.
+ * @closid:	closid that matches the rmid. Depending on the
+ *		architecture, may update new closid and return by the
+ *		pointer.
+ * @rmid:	update available rmid by the pointer.
+ *
+ * Return:
+ * 0 on success, or -EINVAL, -ENOSPC etc on error.
+ */
+int resctrl_arch_alloc_rmid(u32 *closid, u32 *rmid);
+
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
  *			       and eventid.
-- 
2.25.1


