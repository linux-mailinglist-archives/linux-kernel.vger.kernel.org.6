Return-Path: <linux-kernel+bounces-516940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E9A37A03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C03188AA87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3EE1684A4;
	Mon, 17 Feb 2025 03:09:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67B7DA8C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739761751; cv=none; b=KhZ3crFfQczGxsGXj37PG1xQKLIW7OPlwgvGogQUIV64wwcEctcZTsaE0Mgi+AfSL4R3lS1N2bixCKgbPd72MvGPZPf5Z0XZ363yYzeQT1LhYqmw5BTuJuYD40UIKOk1HqMg2Jo3CWYhMoerNB0raMMI7+l/KfdchYIh7pNOTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739761751; c=relaxed/simple;
	bh=JPHF5iBQi/RBsBLTeinh3Lw+oyw7pjasxlebsUyE8GA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvE3yuSAul8YNDJBykiyDuW5+4BLvHsrgH1CmW9gQxLPdQGcImX1XFZEp5gox9F0/9NJ80w3wRFMjwHkDH20w2TvPCdQJSNM+gicVlBjZ5YCNica/IGfNm0nbXznEu3AGQ5JIdM5ssVXdLUkD+a4FLgqnkKYoH1Gp0J/WiG2fRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yx6vN74j0z11VXG;
	Mon, 17 Feb 2025 11:04:32 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 51C4B1400CA;
	Mon, 17 Feb 2025 11:09:06 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Feb
 2025 11:09:05 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH mpam mpam/snapshot/v6.14-rc1 3/5] arm_mpam: Provide conversion method for new closid/rmid pairs
Date: Mon, 17 Feb 2025 11:18:50 +0800
Message-ID: <20250217031852.2014939-4-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217031852.2014939-1-zengheng4@huawei.com>
References: <20250217031852.2014939-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The MPAM driver statically assigns all reqPARTIDs to respective intPARTIDs.
For the new rmid allocation strategy, it will check if there is an
available rmid of any reqPARTID which belongs to the input closid, not just
the rmids belonging to the closid.

For a mixture of MSCs system, for MSCs that do not support narrow-partid,
we use the PARTIDs exceeding the number of closids as reqPARTIDs for
expanding the monitoring groups.

In order to keep the existing resctrl API interface, the rmid contains both
req_idx and PMG information instead of PMG only under the MPAM driver. The
req_idx represents the req_idx-th sub-monitoring group under the control
group. The new rmid would be like:

    rmid = (req_idx << shift | pmg).

The mapping relationships between each group's closid/rmid and the
respective MSCs' intPARTID/reqPARTID/PARTID are illustrated:

n - Indicates the total number of intPARTIDs
m - Indicates the number of reqPARTIDs per intPARTID

P - Partition group (control group)
M - Monitoring group

Group closid rmid.req_idx PARTID            MSCs with narrow-partid  MSCs without narrow-partid
P1    0      -            0                   intPARTID_1              PARTID_1
M1_1  0      0            0                       ├── reqPARTID_1_1       ├── PARTID_1_1
M1_2  0      1            0+n                     ├── reqPARTID_1_2       ├── PARTID_1_2
M1_3  0      2            0+n*2                   ├── reqPARTID_1_3       ├── PARTID_1_3
 ...                                              ├── ...                 ├── ...
M1_m  0      (m-1)        0+n*(m-1)               └── reqPARTID_1_m       └── PARTID_1_m

P2    1      -            1                   intPARTID_2              PARTID_2
M2_1  1      0            1                       ├── reqPARTID_2_1       ├── PARTID_2_1
M2_2  1      1            1+n                     ├── reqPARTID_2_2       ├── PARTID_2_2
M2_3  1      2            1+n*2                   ├── reqPARTID_2_3       ├── PARTID_2_3
 ...                                              ├── ...                 ├── ...
M2_m  1      (m-1)        1+n*(m-1)               └── reqPARTID_2_m       └── PARTID_2_m

Pn    (n-1)  -            (n-1)               intPARTID_n              PARTID_n
Mn_1  (n-1)  0            (n-1)                   ├── reqPARTID_n_1       ├── PARTID_n_1
Mn_2  (n-1)  1            (n-1)+n                 ├── reqPARTID_n_2       ├── PARTID_n_2
Mn_3  (n-1)  2            (n-1)+n*2               ├── reqPARTID_n_3       ├── PARTID_n_3
 ...                                              ├── ...                 ├── ...
Mn_m  (n-1)  (m-1)        (n-1)+n*(m-1) = n*m-1   └── reqPARTID_n_m       └── PARTID_n_m

Based on the example provided, the conversion relationship between
closid/rmid and (req)PARTID/PMG is:

    (req)PARTID = (rmid.req_idx * n) + intPARTID
    PMG = rmid.pmg

and still,

    intPARTID = resctrl_get_config_index(closid, resctrl_conf_type)

The resctrl layer uses the new conversion functions(closid_rmid2reqpartid()
and rmid2pmg() respectively) to gain the new (req)PARTID/PMG pair.

It can be noted that the approach of allocating the first n IDs to
intPARTIDs keeps the existing conversion between closid and intPARTID.
We still use the resctrl_get_config_index() for conversion, maintaining
the original semantics during the MPAM configuration updating. Essentially,
the narrowing feature is an enhanced monitoring feature, we only expand the
definition of rmid, while reqPARTID is only used in monitoring-related
processes.

Now each control group has m (req)PARTIDs, which are used to expand the
number of monitoring groups under one control group. Therefore, the number
of monitoring groups is no longer limited by the range of MPAM's PMG, which
enhances the extensibility of the system's monitoring capabilities.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 133 ++++++++++++++-------
 1 file changed, 93 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index f3f8fb0ff421..c6ca086f7dd8 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -186,6 +186,11 @@ static u32 get_num_reqpartid(void)
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
@@ -194,24 +199,73 @@ u32 resctrl_arch_system_num_rmid_idx(void)
 	return num_reqpartid << closid_shift;
 }
 
+/*
+ * Under MPAM driver, the rmid contains two pieces of information: one is
+ * req_idx, and the other is pmg. Therefore,
+ *     closid_shift = req_shift + pmg_shift.
+ */
 u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
 {
-	u8 closid_shift = fls(mpam_pmg_max);
+	u32 rmid_mask;
+	u8 closid_shift;
+	u8 pmg_shift = fls(mpam_pmg_max);
+	u8 req_shift = fls(get_num_reqpartid_per_closid() - 1);
+
+	closid_shift = req_shift + pmg_shift;
+	rmid_mask = ~(~0 << closid_shift);
 
 	WARN_ON_ONCE(closid_shift > 8);
 
-	return (closid << closid_shift) | rmid;
+	return (closid << closid_shift) | (rmid & rmid_mask);
 }
 
 void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
 {
-	u8 closid_shift = fls(mpam_pmg_max);
-	u32 pmg_mask = ~(~0 << closid_shift);
+	u32 rmid_mask;
+	u8 closid_shift;
+	u8 pmg_shift = fls(mpam_pmg_max);
+	u8 req_shift = fls(get_num_reqpartid_per_closid() - 1);
+
+	closid_shift = req_shift + pmg_shift;
+	rmid_mask = ~(~0 << closid_shift);
 
 	WARN_ON_ONCE(closid_shift > 8);
 
-	*closid = idx >> closid_shift;
-	*rmid = idx & pmg_mask;
+	if (closid)
+		*closid = idx >> closid_shift;
+	if (rmid)
+		*rmid = idx & rmid_mask;
+}
+
+static u32 closid_rmid2reqpartid(u32 closid, u32 rmid)
+{
+	u32 intpartid;
+	u8 pmg_shift = fls(mpam_pmg_max);
+	u32 req_idx = (rmid >> pmg_shift);
+	u8 intpartid_shift = fls(mpam_intpartid_max);
+
+	if (!cdp_enabled)
+		intpartid = resctrl_get_config_index(closid, CDP_NONE);
+	else
+		intpartid = resctrl_get_config_index(closid, CDP_DATA);
+
+	return (req_idx << intpartid_shift) | intpartid;
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
 }
 
 void resctrl_arch_sched_in(struct task_struct *tsk)
@@ -223,21 +277,20 @@ void resctrl_arch_sched_in(struct task_struct *tsk)
 
 void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid)
 {
-	WARN_ON_ONCE(closid > U16_MAX);
-	WARN_ON_ONCE(rmid > U8_MAX);
+	u32 reqpartid = closid_rmid2reqpartid(closid, rmid);
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
@@ -256,41 +309,41 @@ void resctrl_arch_sync_cpu_closid_rmid(void *info)
 
 void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
 {
-	WARN_ON_ONCE(closid > U16_MAX);
-	WARN_ON_ONCE(rmid > U8_MAX);
+	u32 reqpartid = closid_rmid2reqpartid(closid, rmid);
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
+	return (tsk_partid == closid_rmid2reqpartid(closid, rmid)) &&
+	       (tsk_pmg == rmid2pmg(rmid));
 }
 
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
@@ -412,7 +465,7 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_mon_domain *d,
 		cfg.mon = resctrl_arch_rmid_idx_encode(closid, rmid);
 
 	cfg.match_pmg = true;
-	cfg.pmg = rmid;
+	cfg.pmg = rmid2pmg(rmid);
 	cfg.opts = resctrl_evt_config_to_mpam(dom->mbm_local_evt_cfg);
 
 	if (irqs_disabled()) {
@@ -420,7 +473,7 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_mon_domain *d,
 		err = -EIO;
 	} else {
 		if (cdp_enabled) {
-			cfg.partid = closid << 1;
+			cfg.partid = closid_rmid2reqpartid(closid, rmid);
 			err = mpam_msmon_read(dom->comp, &cfg, type, val);
 			if (err)
 				return err;
@@ -430,7 +483,7 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_mon_domain *d,
 			if (!err)
 				*val += cdp_val;
 		} else {
-			cfg.partid = closid;
+			cfg.partid = closid_rmid2reqpartid(closid, rmid);
 			err = mpam_msmon_read(dom->comp, &cfg, type, val);
 		}
 	}
@@ -449,18 +502,18 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	cfg.mon = resctrl_arch_rmid_idx_encode(closid, rmid);
 	cfg.match_pmg = true;
-	cfg.pmg = rmid;
+	cfg.pmg = rmid2pmg(rmid);
 
 	dom = container_of(d, struct mpam_resctrl_dom, resctrl_mon_dom);
 
 	if (cdp_enabled) {
-		cfg.partid = closid << 1;
+		cfg.partid = closid_rmid2reqpartid(closid, rmid);
 		mpam_msmon_reset_mbwu(dom->comp, &cfg);
 
 		cfg.partid += 1;
 		mpam_msmon_reset_mbwu(dom->comp, &cfg);
 	} else {
-		cfg.partid = closid;
+		cfg.partid = closid_rmid2reqpartid(closid, rmid);
 		mpam_msmon_reset_mbwu(dom->comp, &cfg);
 	}
 }
-- 
2.25.1


