Return-Path: <linux-kernel+bounces-527138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA12A407D4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1328F17647D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0E220AF7B;
	Sat, 22 Feb 2025 11:15:25 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF620012D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740222925; cv=none; b=Z2kiMHYZecuJKbGuWxHQckPu5N7zQKc6auKZDsJTGawVPso8mXCSWwq7aTffHPxXv9Im2ommCrj4VlzHveDqakz0NmSQn4XnzKRkTMR5CV9ATaBGkdwxuzvbcFgSJN1h9Qy5/l8bSq7hV8bZ684Iw0G3kxbSwqfnfIf8gLp6KMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740222925; c=relaxed/simple;
	bh=jVd5ywd1gFQLdwPESCqaPpkzWXr5s7mMQSpfHqybMM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNVqhOEraci7bogl8uchmZplUb+xcqrurot4mQ1tNbYQgJRK8NOBTdo60cofpWLHPrgP+9IYewZ/5pkEhbtrjzOSgmPPzsXqXuHPPUNRTyqiqaVHt54kYkfXY9n5rdKGz+CLMidiH/9fRSZcZ9XBjfoC5IfG4lG81VpQzSMKAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z0PSk4y1rz2JvT8;
	Sat, 22 Feb 2025 19:11:18 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 532791A0188;
	Sat, 22 Feb 2025 19:15:17 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 22 Feb
 2025 19:15:16 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH mpam mpam/snapshot/v6.14-rc1 v2 3/5] arm_mpam: Expand the composition of RMID
Date: Sat, 22 Feb 2025 19:24:46 +0800
Message-ID: <20250222112448.2438586-4-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250222112448.2438586-1-zengheng4@huawei.com>
References: <20250222112448.2438586-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The Narrow Partid feature supports for the MPAM driver statically or
dynamically allocates all reqPARTIDs to various intPARTIDs. The new RMID
allocation strategy will check whether there are available reqPARTIDs for
the incoming closid, rather than simply checking for available PMGs.

For a mixture of MSCs system, for MSCs that do not support narrow-partid,
we use the PARTIDs exceeding the number of closids as reqPARTIDs for
expanding the monitoring groups.

Therefore, we will expand the information contained in the RMID, so that it
includes not only PMG, but also reqPARTIDs information. The new RMID would
be like:

    RMID = (reqPARTID << shift | PMG).

In order to keep the existing resctrl layer interfaces, the reqPARTIDs are
allocated statically. Here req2intpartid() linearly binds each reqPARTID to
the corresponding intPARTID. If reqPARTID needs to support dynamic
allocation in the future, then simply rewrite req2intpartid() and can be
replaced with a table-lookup approach.

The static mapping relationships between each group's closid/rmid and the
respective MSCs' intPARTID/reqPARTID/PARTID are illustrated:

n - Indicates the total number of intPARTIDs
m - Indicates the number of reqPARTIDs per intPARTID

P - Partition group
M - Monitoring group

Group closid rmid.reqPARTID     MSCs with narrow-partid  MSCs without narrow-partid
P1     0                          intPARTID_1              PARTID_1
M1_1   0      0                       ├── reqPARTID_1_1       ├── PARTID_1
M1_2   0      0+n                     ├── reqPARTID_1_2       ├── PARTID_1_2
M1_3   0      0+n*2                   ├── reqPARTID_1_3       ├── PARTID_1_3
 ...                                  ├── ...                 ├── ...
M1_m   0      0+n*(m-1)               └── reqPARTID_1_m       └── PARTID_1_m

P2     1                          intPARTID_2              PARTID_2
M2_1   1      1                       ├── reqPARTID_2_1       ├── PARTID_2
M2_2   1      1+n                     ├── reqPARTID_2_2       ├── PARTID_2_2
M2_3   1      1+n*2                   ├── reqPARTID_2_3       ├── PARTID_2_3
 ...                                  ├── ...                 ├── ...
M2_m   1      1+n*(m-1)               └── reqPARTID_2_m       └── PARTID_2_m

Pn    (n-1)                       intPARTID_n              PARTID_n
Mn_1  (n-1)  (n-1)                    ├── reqPARTID_n_1       ├── PARTID_n
Mn_2  (n-1)  (n-1)+n                  ├── reqPARTID_n_2       ├── PARTID_n_2
Mn_3  (n-1)  (n-1)+n*2                ├── reqPARTID_n_3       ├── PARTID_n_3
 ...                                  ├── ...                 ├── ...
Mn_m  (n-1)  (n-1)+n*(m-1) = n*m-1    └── reqPARTID_n_m       └── PARTID_n_m

The resctrl layer uses the new conversion functions rmid2reqpartid()
and rmid2pmg() respectively to gain the new reqPARTID/PMG pair by RMID.

And still, the translation between closid and intPARTID follows the
original conversion logic of closid:

    intPARTID = resctrl_get_config_index(closid, resctrl_conf_type).

It can be noted that the approach of allocating the first n IDs to
intPARTIDs keeps the existing conversion between closid and intPARTID.
We still use the resctrl_get_config_index() for conversion, maintaining
the original semantics during the MPAM configuration updating.

Essentially, the narrowing feature is an enhanced monitoring feature, we
only expand the definition of rmid, while reqPARTID is only used in
monitoring-related processes.

Now each control group has m (req)PARTIDs, which are used to expand the
number of monitoring groups under one control group. Therefore, the number
of monitoring groups is no longer limited by the range of MPAM's PMG, which
enhances the extensibility of the system's monitoring capabilities.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 126 ++++++++++++++-------
 1 file changed, 83 insertions(+), 43 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index f3f8fb0ff421..af314f6df13e 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -194,24 +194,65 @@ u32 resctrl_arch_system_num_rmid_idx(void)
 	return num_reqpartid << closid_shift;
 }
 
+static u32 rmid2reqpartid(u32 rmid)
+{
+	u8 pmg_shift = fls(mpam_pmg_max);
+
+	WARN_ON_ONCE(pmg_shift > 8);
+
+	return rmid >> pmg_shift;
+}
+
+static u32 rmid2pmg(u32 rmid)
+{
+	u8 pmg_shift = fls(mpam_pmg_max);
+	u32 pmg_mask = ~(~0 << pmg_shift);
+
+	return rmid & pmg_mask;
+}
+
+static u32 req2intpartid(u32 reqpartid)
+{
+	u8 intpartid_shift = fls(mpam_intpartid_max);
+	u32 intpartid_mask = ~(~0 << intpartid_shift);
+
+	return reqpartid & intpartid_mask;
+}
+
+/*
+ * To avoid the reuse of rmid across multiple control groups, we will
+ * check the incoming closid to prevent rmid from being reallocated by
+ * resctrl_find_free_rmid().
+ *
+ * If the closid and rmid do not match upon inspection, immediately
+ * returns an invalid rmid. A valid rmid will not exceed 24 bits.
+ */
 u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
 {
-	u8 closid_shift = fls(mpam_pmg_max);
+	u32 reqpartid = rmid2reqpartid(rmid);
+	u32 intpartid = req2intpartid(reqpartid);
+
+	if (cdp_enabled)
+		intpartid >>= 1;
 
-	WARN_ON_ONCE(closid_shift > 8);
+	if (closid != intpartid)
+		return U32_MAX;
 
-	return (closid << closid_shift) | rmid;
+	return rmid;
 }
 
 void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
 {
-	u8 closid_shift = fls(mpam_pmg_max);
-	u32 pmg_mask = ~(~0 << closid_shift);
+	u32 reqpartid = rmid2reqpartid(idx);
+	u32 intpartid = req2intpartid(reqpartid);
 
-	WARN_ON_ONCE(closid_shift > 8);
-
-	*closid = idx >> closid_shift;
-	*rmid = idx & pmg_mask;
+	if (rmid)
+		*rmid = idx;
+	if (closid) {
+		if (cdp_enabled)
+			intpartid >>= 1;
+		*closid = intpartid;
+	}
 }
 
 void resctrl_arch_sched_in(struct task_struct *tsk)
@@ -223,21 +264,20 @@ void resctrl_arch_sched_in(struct task_struct *tsk)
 
 void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid)
 {
-	WARN_ON_ONCE(closid > U16_MAX);
-	WARN_ON_ONCE(rmid > U8_MAX);
+	u32 reqpartid = rmid2reqpartid(rmid);
+	u32 pmg = rmid2pmg(rmid);
 
-	if (!cdp_enabled) {
-		mpam_set_cpu_defaults(cpu, closid, closid, rmid, rmid);
-	} else {
+	WARN_ON_ONCE(reqpartid > U16_MAX);
+	WARN_ON_ONCE(pmg > U8_MAX);
+
+	if (!cdp_enabled)
+		mpam_set_cpu_defaults(cpu, reqpartid, reqpartid, pmg, pmg);
+	else
 		/*
 		 * When CDP is enabled, resctrl halves the closid range and we
 		 * use odd/even partid for one closid.
 		 */
-		u32 partid_d = resctrl_get_config_index(closid, CDP_DATA);
-		u32 partid_i = resctrl_get_config_index(closid, CDP_CODE);
-
-		mpam_set_cpu_defaults(cpu, partid_d, partid_i, rmid, rmid);
-	}
+		mpam_set_cpu_defaults(cpu, reqpartid, reqpartid + 1, pmg, pmg);
 }
 
 void resctrl_arch_sync_cpu_closid_rmid(void *info)
@@ -256,41 +296,41 @@ void resctrl_arch_sync_cpu_closid_rmid(void *info)
 
 void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
 {
-	WARN_ON_ONCE(closid > U16_MAX);
-	WARN_ON_ONCE(rmid > U8_MAX);
+	u32 reqpartid = rmid2reqpartid(rmid);
+	u32 pmg = rmid2pmg(rmid);
 
-	if (!cdp_enabled) {
-		mpam_set_task_partid_pmg(tsk, closid, closid, rmid, rmid);
-	} else {
-		u32 partid_d = resctrl_get_config_index(closid, CDP_DATA);
-		u32 partid_i = resctrl_get_config_index(closid, CDP_CODE);
+	WARN_ON_ONCE(reqpartid > U16_MAX);
+	WARN_ON_ONCE(pmg > U8_MAX);
+
+	if (!cdp_enabled)
+		mpam_set_task_partid_pmg(tsk, reqpartid, reqpartid, pmg, pmg);
+	else
+		mpam_set_task_partid_pmg(tsk, reqpartid, reqpartid + 1, pmg, pmg);
 
-		mpam_set_task_partid_pmg(tsk, partid_d, partid_i, rmid, rmid);
-	}
 }
 
 bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
 {
 	u64 regval = mpam_get_regval(tsk);
-	u32 tsk_closid = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
+	u32 tsk_partid = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
+
+	tsk_partid = req2intpartid(tsk_partid);
 
 	if (cdp_enabled)
-		tsk_closid >>= 1;
+		tsk_partid >>= 1;
 
-	return tsk_closid == closid;
+	return tsk_partid == closid;
 }
 
 /* The task's pmg is not unique, the partid must be considered too */
 bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
 {
 	u64 regval = mpam_get_regval(tsk);
-	u32 tsk_closid = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
-	u32 tsk_rmid = FIELD_GET(MPAM1_EL1_PMG_D, regval);
-
-	if (cdp_enabled)
-		tsk_closid >>= 1;
+	u32 tsk_partid = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
+	u32 tsk_pmg = FIELD_GET(MPAM1_EL1_PMG_D, regval);
 
-	return (tsk_closid == closid) && (tsk_rmid == rmid);
+	return (tsk_partid == rmid2reqpartid(rmid)) &&
+	       (tsk_pmg == rmid2pmg(rmid));
 }
 
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
@@ -412,7 +452,7 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_mon_domain *d,
 		cfg.mon = resctrl_arch_rmid_idx_encode(closid, rmid);
 
 	cfg.match_pmg = true;
-	cfg.pmg = rmid;
+	cfg.pmg = rmid2pmg(rmid);
 	cfg.opts = resctrl_evt_config_to_mpam(dom->mbm_local_evt_cfg);
 
 	if (irqs_disabled()) {
@@ -420,7 +460,7 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_mon_domain *d,
 		err = -EIO;
 	} else {
 		if (cdp_enabled) {
-			cfg.partid = closid << 1;
+			cfg.partid = rmid2reqpartid(rmid);
 			err = mpam_msmon_read(dom->comp, &cfg, type, val);
 			if (err)
 				return err;
@@ -430,7 +470,7 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_mon_domain *d,
 			if (!err)
 				*val += cdp_val;
 		} else {
-			cfg.partid = closid;
+			cfg.partid = rmid2reqpartid(rmid);
 			err = mpam_msmon_read(dom->comp, &cfg, type, val);
 		}
 	}
@@ -449,18 +489,18 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	cfg.mon = resctrl_arch_rmid_idx_encode(closid, rmid);
 	cfg.match_pmg = true;
-	cfg.pmg = rmid;
+	cfg.pmg = rmid2pmg(rmid);
 
 	dom = container_of(d, struct mpam_resctrl_dom, resctrl_mon_dom);
 
 	if (cdp_enabled) {
-		cfg.partid = closid << 1;
+		cfg.partid = rmid2reqpartid(rmid);
 		mpam_msmon_reset_mbwu(dom->comp, &cfg);
 
 		cfg.partid += 1;
 		mpam_msmon_reset_mbwu(dom->comp, &cfg);
 	} else {
-		cfg.partid = closid;
+		cfg.partid = rmid2reqpartid(rmid);
 		mpam_msmon_reset_mbwu(dom->comp, &cfg);
 	}
 }
-- 
2.25.1


