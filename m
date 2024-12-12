Return-Path: <linux-kernel+bounces-443325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60869EED11
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F3E2850C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40D6221D93;
	Thu, 12 Dec 2024 15:40:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09002222D7D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018034; cv=none; b=D/dTZpe7PFdRQTbMpXjJkf3eX7n9o7RXhQGEsXeWQb03+6jenEFoYwtk43YytNBtLsSkjqtm3Gn3mJN3QmIuveIhjk76jXAWaAOdGeCvWqF86+VcYPIeMethxYEYSfMj4jlqF+qRaAPgatXbDa1JG2PWhiUQewoGbUtLLwN4mY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018034; c=relaxed/simple;
	bh=3swF8ifBeJ3AnRXz5rtd5qGjIzSvNJHs4PdlcBlQHbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sxucfxbhMAEJzu8+1MWITtaSfb2GV60FNJeU43TLeWn4GtriC1tKBBw9C4jjtKdcRnX7lcfHFtmZUVy/dBvV/vbMjYw1WJkEP9XCkVUMnrMmbdkB1k1+ozukdjXg9A1Gvlzg1YVCM2IVUuTgasJDuXn3AZgrnC9ho9VBmd7NCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 720731A25;
	Thu, 12 Dec 2024 07:40:58 -0800 (PST)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B60D3F720;
	Thu, 12 Dec 2024 07:40:29 -0800 (PST)
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Zeng Heng <zengheng4@huawei.com>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>
Subject: [RFC PATCH 4/6] arm_mpam: Introduce flexible CLOSID/RMID translation
Date: Thu, 12 Dec 2024 15:39:58 +0000
Message-Id: <20241212154000.330467-5-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212154000.330467-1-Dave.Martin@arm.com>
References: <20241212154000.330467-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the MPAM driver uses the resctrl CLOSID directly as the
MPAM Partition Identifier (PARTID; possibly modified to give
different PARTIDs to code and data when Code/Data Partitioning /
CDP is enabled), and uses the resctrl RMID directly as the MPAM
Performance Monitoring Group identifier (PMG).

In preparation for using the MPAM PARTID Narrowing feature to allow
more resctrl monitoring groups to be provided than the number of
PMG values supported by the hardware, a more flexible remapping
scheme is needed.

Factor out ID translation operations in the MPAM resctrl glue code
into a couple of self-contained helpers, and call them as
appropriate.

The translation scheme has a single parameter, partid_per_closid,
which is currently hard-wired to 1.

As a result, this patch should have no effect on functionality.

Logic to determine / control the mapping parameters can be
introduced later.

The ID transformation may be visualised as follows:

without CDP:
  +---------------------------------------------------+-----------+
  |                       CLOSID                      |    RMID   |
  +---------------------------------------------------+-------+---+
  |                           PARTID                  :       |PMG|
  +-----------------------------------------------------------+---+

and with CDP, where the "CDP" field is 0 for the data sub-
partition and 1 for the code sub-partition:
  +-----------------------------------------------+---+-----------+
  |                     CLOSID                    |CDP|    RMID   |
  +-----------------------------------------------+---+-------+---+
  |                           PARTID                  :       |PMG|
  +-----------------------------------------------------------+---+

where each box represents a non-negative integer spanning some
fixed range starting from zero, and horizontal concatenation
denotes multiplying the value denoted by the left-hand box by the
span of the right-hand box, and adding the result to the value
denoted by the right-hand box; thus, most-significant fields are on
the left.

(Except for the span of each field not necessarily being a power of
two, this is conceptually identical to concatenation and cutting of
bitfields.)

The dotted segment indicates the least significant part of PARTID,
which spans partid_per_closid PARTIDs and discriminates monitoring
groups that use the same MPAM PMG value.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 200 +++++++++++----------
 1 file changed, 110 insertions(+), 90 deletions(-)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index 30f2caec11d7..0473286ec65a 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -156,6 +156,18 @@ static bool mpam_resctrl_hide_cdp(enum resctrl_res_level rid)
 	return cdp_enabled && !resctrl_arch_get_cdp_enabled(rid);
 }
 
+static unsigned int partid_per_closid = 1;
+
+static unsigned int mpam_num_pmg(void)
+{
+	return mpam_pmg_max + 1;
+}
+
+static unsigned int mpam_num_rmid(void)
+{
+	return mpam_num_pmg() * partid_per_closid;
+}
+
 /*
  * MSC may raise an error interrupt if it sees an out or range partid/pmg,
  * and go on to truncate the value. Regardless of what the hardware supports,
@@ -163,35 +175,71 @@ static bool mpam_resctrl_hide_cdp(enum resctrl_res_level rid)
  */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *ignored)
 {
-	return mpam_partid_max + 1;
+	u32 res = (mpam_partid_max + 1) / partid_per_closid;
+
+	WARN_ON(res < 1);
+	return res;
 }
 
-u32 resctrl_arch_system_num_rmid_idx(void)
+static void mpam_resctrl_partid_range(u32 closid, enum resctrl_conf_type type,
+				      const struct rdt_resource *r,
+				      u16 *min_partid, u16 *max_partid)
 {
-	u8 closid_shift = fls(mpam_pmg_max);
-	u32 num_partid = resctrl_arch_get_num_closid(NULL);
+	u16 base_partid = closid;
+	u16 span = 1;
+
+	if (cdp_enabled) {
+		base_partid *= 2;
+		if (mpam_resctrl_hide_cdp(r->rid) ||
+		    type == CDP_NONE)
+			span *= 2;
+	}
 
-	return num_partid << closid_shift;
+	*min_partid = base_partid * partid_per_closid;
+	if (max_partid)
+		*max_partid = *min_partid + (span * partid_per_closid - 1);
 }
 
-u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
+static void mpam_resctrl_hwid(u32 closid, u32 rmid,
+			      u16 *partid_d, u16 *partid_i, u8 *pmg)
 {
-	u8 closid_shift = fls(mpam_pmg_max);
+	const u16 pmg_hi = rmid / mpam_num_pmg();
+	const u16 pmg_lo = rmid % mpam_num_pmg();
+	u16 base_partid = closid;
+	u16 partid_stride = 0;
+
+	if (cdp_enabled) {
+		base_partid *= 2;
+		partid_stride = 1;
+	}
 
-	BUG_ON(closid_shift > 8);
+	partid_stride *= partid_per_closid;
+	base_partid *= partid_per_closid;
+	base_partid += pmg_hi;
 
-	return (closid << closid_shift) | rmid;
+	*partid_d = base_partid;
+	if (partid_i)
+		*partid_i = base_partid + partid_stride;
+
+	*pmg = pmg_lo;
 }
 
-void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
+u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
 {
-	u8 closid_shift = fls(mpam_pmg_max);
-	u32 pmg_mask = ~(~0 << closid_shift);
+	return closid * mpam_num_rmid() + rmid;
+}
 
-	BUG_ON(closid_shift > 8);
+u32 resctrl_arch_system_num_rmid_idx(void)
+{
+	u32 num_closid = resctrl_arch_get_num_closid(NULL);
 
-	*closid = idx >> closid_shift;
-	*rmid = idx & pmg_mask;
+	return resctrl_arch_rmid_idx_encode(num_closid, 0);
+}
+
+void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
+{
+	*closid = idx / mpam_num_rmid();
+	*rmid = idx % mpam_num_rmid();
 }
 
 void resctrl_arch_sched_in(struct task_struct *tsk)
@@ -203,21 +251,14 @@ void resctrl_arch_sched_in(struct task_struct *tsk)
 
 void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid)
 {
+	u16 partid_d, partid_i;
+	u8 pmg;
+
 	BUG_ON(closid > U16_MAX);
 	BUG_ON(rmid > U8_MAX);
 
-	if (!cdp_enabled) {
-		mpam_set_cpu_defaults(cpu, closid, closid, rmid, rmid);
-	} else {
-		/*
-		 * When CDP is enabled, resctrl halves the closid range and we
-		 * use odd/even partid for one closid.
-		 */
-		u32 partid_d = resctrl_get_config_index(closid, CDP_DATA);
-		u32 partid_i = resctrl_get_config_index(closid, CDP_CODE);
-
-		mpam_set_cpu_defaults(cpu, partid_d, partid_i, rmid, rmid);
-	}
+	mpam_resctrl_hwid(closid, rmid, &partid_d, &partid_i, &pmg);
+	mpam_set_cpu_defaults(cpu, partid_d, partid_i, pmg, pmg);
 }
 
 void resctrl_arch_sync_cpu_closid_rmid(void *info)
@@ -236,41 +277,38 @@ void resctrl_arch_sync_cpu_closid_rmid(void *info)
 
 void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
 {
+	u16 partid_d, partid_i;
+	u8 pmg;
+
 	BUG_ON(closid > U16_MAX);
 	BUG_ON(rmid > U8_MAX);
 
-	if (!cdp_enabled) {
-		mpam_set_task_partid_pmg(tsk, closid, closid, rmid, rmid);
-	} else {
-		u32 partid_d = resctrl_get_config_index(closid, CDP_DATA);
-		u32 partid_i = resctrl_get_config_index(closid, CDP_CODE);
-
-		mpam_set_task_partid_pmg(tsk, partid_d, partid_i, rmid, rmid);
-	}
+	mpam_resctrl_hwid(closid, rmid, &partid_d, &partid_i, &pmg);
+	mpam_set_task_partid_pmg(tsk, partid_d, partid_i, pmg, pmg);
 }
 
 bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
 {
+	u16 min_partid, max_partid;
 	u64 regval = mpam_get_regval(tsk);
 	u32 tsk_closid = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
 
-	if (cdp_enabled)
-		tsk_closid >>= 1;
-
-	return tsk_closid == closid;
+	mpam_resctrl_partid_range(closid, CDP_NONE, NULL,
+				  &min_partid, &max_partid);
+	return tsk_closid >= min_partid && tsk_closid <= max_partid;
 }
 
 /* The task's pmg is not unique, the partid must be considered too */
 bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
 {
+	u16 partid_d;
+	u8 pmg;
 	u64 regval = mpam_get_regval(tsk);
-	u32 tsk_closid = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
-	u32 tsk_rmid = FIELD_GET(MPAM1_EL1_PMG_D, regval);
-
-	if (cdp_enabled)
-		tsk_closid >>= 1;
+	u16 tsk_partid_d = FIELD_GET(MPAM1_EL1_PARTID_D, regval);
+	u8 tsk_pmg = FIELD_GET(MPAM1_EL1_PMG_D, regval);
 
-	return (tsk_closid == closid) && (tsk_rmid == rmid);
+	mpam_resctrl_hwid(closid, rmid, &partid_d, NULL, &pmg);
+	return (tsk_partid_d == partid_d) && (tsk_pmg == pmg);
 }
 
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
@@ -370,6 +408,7 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_mon_domain *d,
 	struct mpam_resctrl_dom *dom;
 	u32 mon = *(u32 *)arch_mon_ctx;
 	enum mpam_device_features type;
+	u16 partid_d, partid_i, pmg;
 
 	resctrl_arch_rmid_read_context_check();
 
@@ -391,27 +430,23 @@ int resctrl_arch_rmid_read(struct rdt_resource	*r, struct rdt_mon_domain *d,
 	if (cfg.mon == USE_RMID_IDX)
 		cfg.mon = resctrl_arch_rmid_idx_encode(closid, rmid);
 
+	mpam_resctrl_hwid(closid, rmid, &partid_d, &partid_i, &cfg.pmg);
 	cfg.match_pmg = true;
-	cfg.pmg = rmid;
+	cfg.pmg = pmg;
 	cfg.opts = resctrl_evt_config_to_mpam(dom->mbm_local_evt_cfg);
 
 	if (irqs_disabled()) {
 		/* Check if we can access this domain without an IPI */
 		err = -EIO;
 	} else {
-		if (cdp_enabled) {
-			cfg.partid = closid << 1;
-			err = mpam_msmon_read(dom->comp, &cfg, type, val);
-			if (err)
-				return err;
+		cfg.partid = partid_d;
+		err = mpam_msmon_read(dom->comp, &cfg, type, val);
 
-			cfg.partid += 1;
+		if (partid_i != partid_d) {
+			cfg.partid = partid_i;
 			err = mpam_msmon_read(dom->comp, &cfg, type, &cdp_val);
 			if (!err)
 				*val += cdp_val;
-		} else {
-			cfg.partid = closid;
-			err = mpam_msmon_read(dom->comp, &cfg, type, val);
 		}
 	}
 
@@ -423,6 +458,7 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 {
 	struct mon_cfg cfg;
 	struct mpam_resctrl_dom *dom;
+	u16 partid_d, partid_i;
 
 	if (eventid != QOS_L3_MBM_LOCAL_EVENT_ID)
 		return;
@@ -433,14 +469,13 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	dom = container_of(d, struct mpam_resctrl_dom, resctrl_mon_dom);
 
-	if (cdp_enabled) {
-		cfg.partid = closid << 1;
-		mpam_msmon_reset_mbwu(dom->comp, &cfg);
+	mpam_resctrl_hwid(closid, rmid, &partid_d, &partid_i, &cfg.pmg);
 
-		cfg.partid += 1;
-		mpam_msmon_reset_mbwu(dom->comp, &cfg);
-	} else {
-		cfg.partid = closid;
+	cfg.partid = partid_d;
+	mpam_msmon_reset_mbwu(dom->comp, &cfg);
+
+	if (partid_i != partid_d) {
+		cfg.partid = partid_i;
 		mpam_msmon_reset_mbwu(dom->comp, &cfg);
 	}
 }
@@ -1081,7 +1116,7 @@ static void mpam_resctrl_exit(void)
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type type)
 {
-	u32 partid;
+	u16 partid;
 	struct mpam_config *cfg;
 	struct mpam_props *cprops;
 	struct mpam_resctrl_res *res;
@@ -1097,15 +1132,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 	dom = container_of(d, struct mpam_resctrl_dom, resctrl_ctrl_dom);
 	cprops = &res->class->props;
 
-	/*
-	 * When CDP is enabled, but the resource doesn't support it,
-	 * the control is cloned across both partids.
-	 * Pick one at random to read:
-	 */
-	if (mpam_resctrl_hide_cdp(r->rid))
-		type = CDP_DATA;
-
-	partid = resctrl_get_config_index(closid, type);
+	mpam_resctrl_partid_range(closid, type, r, &partid, NULL);
 	cfg = &dom->comp->cfg[partid];
 
 	switch (r->rid) {
@@ -1126,7 +1153,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 		return -EINVAL;
 	}
 
-	if (!r->alloc_capable || partid >= resctrl_arch_get_num_closid(r) ||
+	if (!r->alloc_capable || partid > mpam_partid_max ||
 	    !mpam_has_feature(configured_by, cfg))
 		return resctrl_get_default_ctrl(r);
 
@@ -1147,8 +1174,8 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
-	int err;
-	u32 partid;
+	int err = 0;
+	u16 partid, min_partid, max_partid;
 	struct mpam_config cfg;
 	struct mpam_props *cprops;
 	struct mpam_resctrl_res *res;
@@ -1163,8 +1190,10 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 	dom = container_of(d, struct mpam_resctrl_dom, resctrl_ctrl_dom);
 	cprops = &res->class->props;
 
-	partid = resctrl_get_config_index(closid, t);
-	if (!r->alloc_capable || partid >= resctrl_arch_get_num_closid(r))
+	mpam_resctrl_partid_range(closid, t, r, &min_partid, &max_partid);
+	if (!r->alloc_capable ||
+	    min_partid > mpam_partid_max ||
+	    max_partid > mpam_partid_max)
 		return -EINVAL;
 
 	cfg.features = 0;
@@ -1190,22 +1219,13 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
 		return -EINVAL;
 	}
 
-	/*
-	 * When CDP is enabled, but the resource doesn't support it, we need to
-	 * apply the same configuration to the other partid.
-	 */
-	if (mpam_resctrl_hide_cdp(r->rid)) {
-		partid = resctrl_get_config_index(closid, CDP_CODE);
+	for (partid = min_partid; partid <= max_partid; partid++) {
 		err = mpam_apply_config(dom->comp, partid, &cfg);
 		if (err)
-			return err;
-
-		partid = resctrl_get_config_index(closid, CDP_DATA);
-		return mpam_apply_config(dom->comp, partid, &cfg);
-
-	} else {
-		return mpam_apply_config(dom->comp, partid, &cfg);
+			break;
 	}
+
+	return err;
 }
 
 /* TODO: this is IPI heavy */
-- 
2.34.1


