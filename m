Return-Path: <linux-kernel+bounces-435977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223639E7F4D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 10:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4AD282E30
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56751465A1;
	Sat,  7 Dec 2024 09:09:28 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC013665A
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733562568; cv=none; b=PNnM9/AopMN3/kqoV7ePxS6PO0d6+fzyK/sBpU/5DANeqvAIEvKxpdyRSIITCxbfi7BjHkwFTEzcyiXKw1BFsyUgQd1pr+b7rHRAXyPbeIGK3fMwt274EHmYDYf9PgM2MohoHEB+D6rAnfw9Z6uvEVpMvpJ81NjibdYdVlza46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733562568; c=relaxed/simple;
	bh=KGkxUgjYFgm2LPDBakL+Hxm3i7aDgvTrCzuFQb/tums=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDcEQuj/NYLYghXVNd/nUZcCW+sD3pNLHpDtcaLrufCy053IGt4j/TfCsmKrW+7YyiW/iifG6ajQ1sOGuSbj47mXHWaC/C9vDHf9zdmHeSL4qEcvG5lHn9O9Uf2wIxAsCmk32HTRX90LOUsf0Dmvqop9I9HBdr1ppILhcah3uBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Y52Ls6H0hz1T6bp;
	Sat,  7 Dec 2024 17:07:01 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 1113C140136;
	Sat,  7 Dec 2024 17:09:23 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 7 Dec
 2024 17:09:22 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<jonathan.cameron@huawei.com>, <xiexiuqi@huawei.com>
Subject: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v3 5/5] arm_mpam: Adapting the closid/rmid matching determination functions
Date: Sat, 7 Dec 2024 17:21:36 +0800
Message-ID: <20241207092136.2488426-6-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241207092136.2488426-1-zengheng4@huawei.com>
References: <20241207092136.2488426-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100008.china.huawei.com (7.202.181.222)

According to the previous patches, add the inverse functions for the
closid/rmid conversion functions to serve as the conversion functions for
reqpartid/pmg. And adapt the matching determination functions
resctrl_arch_match_closid() and resctrl_arch_match_rmid() by the inverse
functions.

For the same reason, when updating the (req)PARTID/PMG pair for a task,
the new conversion functions also are used for adaptation.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 arch/arm64/include/asm/mpam.h              |  6 ++-
 drivers/platform/arm64/mpam/mpam_resctrl.c | 63 +++++++++++++++-------
 2 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/mpam.h b/arch/arm64/include/asm/mpam.h
index e5f385767174..9fc095530671 100644
--- a/arch/arm64/include/asm/mpam.h
+++ b/arch/arm64/include/asm/mpam.h
@@ -93,6 +93,8 @@ static inline u64 mpam_get_regval(struct task_struct *tsk)
 #endif
 }
 
+u32 rmid2pmg(u32 rmid);
+
 static inline void resctrl_arch_set_rmid(struct task_struct *tsk, u32 rmid)
 {
 #ifdef CONFIG_ARM64_MPAM
@@ -100,8 +102,8 @@ static inline void resctrl_arch_set_rmid(struct task_struct *tsk, u32 rmid)
 
 	regval &= ~MPAM1_EL1_PMG_D;
 	regval &= ~MPAM1_EL1_PMG_I;
-	regval |= FIELD_PREP(MPAM1_EL1_PMG_D, rmid);
-	regval |= FIELD_PREP(MPAM1_EL1_PMG_I, rmid);
+	regval |= FIELD_PREP(MPAM1_EL1_PMG_D, rmid2pmg(rmid));
+	regval |= FIELD_PREP(MPAM1_EL1_PMG_I, rmid2pmg(rmid));
 
 	WRITE_ONCE(task_thread_info(tsk)->mpam_partid_pmg, regval);
 #endif
diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index 47e3a51b0942..cb5da3de907a 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -239,7 +239,7 @@ static u32 closid_rmid2reqpartid(u32 closid, u32 rmid)
 	return (req_idx << intpartid_shift) | closid;
 }
 
-static u32 rmid2pmg(u32 rmid)
+u32 rmid2pmg(u32 rmid)
 {
 	u8 pmg_shift = fls(mpam_pmg_max);
 	u32 pmg_mask = ~(~0 << pmg_shift);
@@ -247,6 +247,20 @@ static u32 rmid2pmg(u32 rmid)
 	return rmid & pmg_mask;
 }
 
+static u32 reqpartid2closid(u32 reqpartid)
+{
+	return req2intpartid(reqpartid);
+}
+
+static u32 reqpartid_pmg2rmid(u32 reqpartid, u32 pmg)
+{
+	u8 pmg_shift = fls(mpam_pmg_max);
+	u8 intpartid_shift = fls(mpam_intpartid_max);
+	u32 req_idx = (reqpartid >> intpartid_shift);
+
+	return (req_idx << pmg_shift) | pmg;
+}
+
 void resctrl_arch_sched_in(struct task_struct *tsk)
 {
 	lockdep_assert_preemption_disabled();
@@ -256,20 +270,24 @@ void resctrl_arch_sched_in(struct task_struct *tsk)
 
 void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid)
 {
-	BUG_ON(closid > U16_MAX);
-	BUG_ON(rmid > U8_MAX);
+	u32 reqpartid = closid_rmid2reqpartid(closid, rmid);
+	u32 pmg = rmid2pmg(rmid);
+	u32 partid_d, partid_i;
+
+	BUG_ON(reqpartid > U16_MAX);
+	BUG_ON(pmg > U8_MAX);
 
 	if (!cdp_enabled) {
-		mpam_set_cpu_defaults(cpu, closid, closid, rmid, rmid);
+		mpam_set_cpu_defaults(cpu, reqpartid, reqpartid, pmg, pmg);
 	} else {
 		/*
 		 * When CDP is enabled, resctrl halves the closid range and we
 		 * use odd/even partid for one closid.
 		 */
-		u32 partid_d = resctrl_get_config_index(closid, CDP_DATA);
-		u32 partid_i = resctrl_get_config_index(closid, CDP_CODE);
+		partid_d = resctrl_get_config_index(reqpartid, CDP_DATA);
+		partid_i = resctrl_get_config_index(reqpartid, CDP_CODE);
 
-		mpam_set_cpu_defaults(cpu, partid_d, partid_i, rmid, rmid);
+		mpam_set_cpu_defaults(cpu, partid_d, partid_i, pmg, pmg);
 	}
 }
 
@@ -289,41 +307,46 @@ void resctrl_arch_sync_cpu_closid_rmid(void *info)
 
 void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
 {
-	BUG_ON(closid > U16_MAX);
-	BUG_ON(rmid > U8_MAX);
+	u32 reqpartid = closid_rmid2reqpartid(closid, rmid);
+	u32 pmg = rmid2pmg(rmid);
+	u32 partid_d, partid_i;
+
+	BUG_ON(reqpartid > U16_MAX);
+	BUG_ON(pmg > U8_MAX);
 
 	if (!cdp_enabled) {
-		mpam_set_task_partid_pmg(tsk, closid, closid, rmid, rmid);
+		mpam_set_task_partid_pmg(tsk, reqpartid, reqpartid, pmg, pmg);
 	} else {
-		u32 partid_d = resctrl_get_config_index(closid, CDP_DATA);
-		u32 partid_i = resctrl_get_config_index(closid, CDP_CODE);
+		partid_d = resctrl_get_config_index(reqpartid, CDP_DATA);
+		partid_i = resctrl_get_config_index(reqpartid, CDP_CODE);
 
-		mpam_set_task_partid_pmg(tsk, partid_d, partid_i, rmid, rmid);
+		mpam_set_task_partid_pmg(tsk, partid_d, partid_i, pmg, pmg);
 	}
 }
 
 bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
 {
 	u64 regval = mpam_get_regval(tsk);
-	u32 tsk_closid = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
+	u32 tsk_partid = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
 
 	if (cdp_enabled)
-		tsk_closid >>= 1;
+		tsk_partid >>= 1;
 
-	return tsk_closid == closid;
+	return reqpartid2closid(tsk_partid) == closid;
 }
 
 /* The task's pmg is not unique, the partid must be considered too */
 bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
 {
 	u64 regval = mpam_get_regval(tsk);
-	u32 tsk_closid = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
-	u32 tsk_rmid = FIELD_GET(MPAM1_EL1_PMG_D, regval);
+	u32 tsk_pmg = FIELD_GET(MPAM1_EL1_PMG_D, regval);
+	u32 tsk_partid = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
 
 	if (cdp_enabled)
-		tsk_closid >>= 1;
+		tsk_partid >>= 1;
 
-	return (tsk_closid == closid) && (tsk_rmid == rmid);
+	return (reqpartid2closid(tsk_partid) == closid) &&
+	       (reqpartid_pmg2rmid(tsk_partid, tsk_pmg) == rmid);
 }
 
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
-- 
2.25.1


