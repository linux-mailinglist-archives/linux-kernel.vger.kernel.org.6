Return-Path: <linux-kernel+bounces-409382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEBE9C8BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8629E1F22B57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E0514A0A7;
	Thu, 14 Nov 2024 13:37:46 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA541DA3D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591465; cv=none; b=Kj9Ig/mYDUEkuu9X54iO73IrGjdKzLFCV5coRaPE7xXn22GKE2TMW/pvndVVPQ4+EMkFLhBEsVQ0p0h6PNtg1wiLezZ6Cg6amABLJ3rvBLUBtDZaucGiUGe07VNOOG4vXvlizZ8CjojXuU4YypNaTPSbh+CmhyOM/1X127mmuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591465; c=relaxed/simple;
	bh=yk/iv+TYQt8hMl6h7WL9GywBGwD1Nl+uhKZq6NcmuS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGDVvJ0qI7xMXqAwMp/S2Ft5U3nwFamQbkptfeSI3pywL+K0N3SeLPBBThHGCE/tt/ibgI1AA0IHgn6S27TWoBTIgjtiTQ6OC+vL45w6Zj2/DUlJom5FPlWfxXAgDqVOalkeyy+Celj+juVfFtap6zRIhuqJMO8Lp/oOdxvv4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xq1Pc5Qvvz2Dgv3;
	Thu, 14 Nov 2024 21:35:48 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 34A011401F4;
	Thu, 14 Nov 2024 21:37:40 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Nov
 2024 21:37:39 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <Dave.Martin@arm.com>
CC: <bobo.shaobowang@huawei.com>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH mpam mpam/snapshot/v6.11-rc1 5/6] arm_mpam: Call resctrl_sync_config() when allocate new reqPARTID
Date: Thu, 14 Nov 2024 21:50:36 +0800
Message-ID: <20241114135037.918470-6-zengheng4@huawei.com>
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

Add resctrl_sync_config() for establishing new mapping between intPARTID
and reqPARTID for hardware or synchronizing their configuration by
software.

For the expansion of monitors using reqPARTID in the system:
  1. If a MSC class supports the narrow-partid feature, then it is only
     necessary to associate the newly allocated reqPARTID with its
     corresponding intPARTID.
  2. If a MSC class does not support the narrow-partid feature, the
     hardware can't associate reqPARTID with intPARTID, and the software
     needs to synchronize the configuration of the parent control group to
     the new PARTID (the newly allocated "reqpartid").

Additionally, for MSC class that doesn't support the narrow-partid feature,
when the control group configuration is updated, the software needs to
forcibly update its sub-monitoring groups (referencing the
__write_config()). We establish a reqPARTID resource bitmap and check
whether the reqPARTID is in use by reqpartid_is_busy() to reduce
unnecessary I/O operations.

In mpam_apply_config(), if closid is equal to intPARTID, we regard that
it is updating new configuration for the control group. Otherwise, it is
attempting to establish mapping and synchronize configuration for
sub-monitoring groups.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 arch/x86/kernel/cpu/resctrl/core.c          |  5 ++
 drivers/platform/arm64/mpam/mpam_devices.c  | 47 +++++++++++++--
 drivers/platform/arm64/mpam/mpam_internal.h |  4 ++
 drivers/platform/arm64/mpam/mpam_resctrl.c  | 66 ++++++++++++++++++++-
 fs/resctrl/internal.h                       |  2 -
 fs/resctrl/monitor.c                        | 16 ++++-
 fs/resctrl/pseudo_lock.c                    |  4 +-
 fs/resctrl/rdtgroup.c                       | 29 +++++++--
 include/linux/resctrl.h                     | 14 +++++
 9 files changed, 170 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 60889ae61bfc..1e8f46203bc4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -708,6 +708,11 @@ int resctrl_arch_alloc_rmid(u32 *closid, u32 *rmid)
 	return 0;
 }
 
+void resctrl_arch_free_rmid(u32 closid, u32 rmid)
+{
+	free_rmid(closid, rmid);
+}
+
 static void clear_closid_rmid(int cpu)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index 1bcdeb847a22..23b375753372 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -1543,6 +1543,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	u32 pri_val = 0;
 	u16 cmax = MPAMCFG_CMAX_CMAX;
 	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
+	u16 intpartid = req2intpartid(partid);
 	struct mpam_msc *msc = ris->vmsc->msc;
 	struct mpam_props *rprops = &ris->props;
 	u16 dspri = GENMASK(rprops->dspri_wd, 0);
@@ -1553,8 +1554,14 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 
 	if (mpam_has_feature(mpam_feat_partid_nrw, rprops)) {
 		mpam_write_partsel_reg(msc, INTPARTID,
-				       MPAMCFG_INTPARTID_INTERNAL | partid);
-		__mpam_intpart_sel(ris->ris_idx, partid, msc);
+				       MPAMCFG_INTPARTID_INTERNAL |
+				       intpartid);
+
+		/* Already finish mapping reqPARTID to intPARTID */
+		if (partid != intpartid)
+			goto out;
+
+		__mpam_intpart_sel(ris->ris_idx, intpartid, msc);
 	}
 
 	if (mpam_has_feature(mpam_feat_cpor_part, rprops)) {
@@ -1611,6 +1618,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 
 	mpam_quirk_post_config_change(ris, partid, cfg);
 
+out:
 	mutex_unlock(&msc->part_sel_lock);
 }
 
@@ -2975,10 +2983,34 @@ struct mpam_write_config_arg {
 
 static int __write_config(void *arg)
 {
+	int closid_num = resctrl_arch_get_num_closid(NULL);
 	struct mpam_write_config_arg *c = arg;
+	struct mpam_props *rprops;
+	u32 reqpartid;
+	int i;
 
 	mpam_reprogram_ris_partid(c->ris, c->partid, &c->comp->cfg[c->partid]);
 
+	if (c->partid != req2intpartid(c->partid))
+		return 0;
+
+	rprops = &c->ris->props;
+
+	/*
+	 * Synchronize the configuration to each working sub-monitoring
+	 * group.
+	 */
+	for (i = 1; i < get_num_reqpartid_per_closid(); i++) {
+		reqpartid = i * closid_num + c->partid;
+
+		if (!reqpartid_is_busy(reqpartid))
+			continue;
+
+		if (!mpam_has_feature(mpam_feat_partid_nrw, rprops))
+			mpam_reprogram_ris_partid(c->ris, reqpartid,
+						 &c->comp->cfg[c->partid]);
+	}
+
 	return 0;
 }
 
@@ -3030,6 +3062,7 @@ static void mpam_extend_config(struct mpam_class *class, struct mpam_config *cfg
 int mpam_apply_config(struct mpam_component *comp, u16 partid,
 		      struct mpam_config *cfg)
 {
+	int intpartid = req2intpartid(partid);
 	struct mpam_write_config_arg arg;
 	struct mpam_msc_ris *ris;
 	struct mpam_vmsc *vmsc;
@@ -3040,10 +3073,16 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 
 	mpam_extend_config(comp->class, cfg);
 
-	if (!memcmp(&comp->cfg[partid], cfg, sizeof(*cfg)))
+	if ((intpartid == partid) &&
+	    (!memcmp(&comp->cfg[intpartid], cfg, sizeof(*cfg))))
 		return 0;
 
-	comp->cfg[partid] = *cfg;
+	/*
+	 * If the partid is not equal to its intpartid, then we continue
+	 * to establish the association between reqpartid and intpartid.
+	 */
+
+	comp->cfg[intpartid] = *cfg;
 	arg.comp = comp;
 	arg.partid = partid;
 
diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
index db1d990bc42b..ef5ce818464e 100644
--- a/drivers/platform/arm64/mpam/mpam_internal.h
+++ b/drivers/platform/arm64/mpam/mpam_internal.h
@@ -750,4 +750,8 @@ static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
  */
 #define MSMON_CAPT_EVNT_NOW    BIT(0)
 
+u32 get_num_reqpartid_per_closid(void);
+u32 req2intpartid(u32 reqpartid);
+bool reqpartid_is_busy(int reqpartid);
+
 #endif /* MPAM_INTERNAL_H */
diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index ecb3438379bc..1f3478a7d965 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -171,11 +171,16 @@ static u32 get_num_reqpartid(void)
 	return mpam_partid_max + 1;
 }
 
-static u32 get_num_reqpartid_per_closid(void)
+u32 get_num_reqpartid_per_closid(void)
 {
 	return get_num_reqpartid() / resctrl_arch_get_num_closid(NULL);
 }
 
+u32 req2intpartid(u32 reqpartid)
+{
+	return reqpartid % resctrl_arch_get_num_closid(NULL);
+}
+
 u32 resctrl_arch_system_num_rmid_idx(void)
 {
 	u8 closid_shift = fls(mpam_pmg_max);
@@ -1035,10 +1040,26 @@ static void reqpartid_destroy(void)
 	bitmap_free(reqpartid_free_map);
 }
 
+static int reqpartid_alloc(int reqpartid)
+{
+	__clear_bit(reqpartid, reqpartid_free_map);
+	return reqpartid;
+}
+
+static void reqpartid_free(int reqpartid)
+{
+	__set_bit(reqpartid, reqpartid_free_map);
+}
+
+bool reqpartid_is_busy(int reqpartid)
+{
+	return !test_bit(reqpartid, reqpartid_free_map);
+}
+
 int resctrl_arch_alloc_rmid(u32 *closid, u32 *rmid)
 {
 	int closid_num = resctrl_arch_get_num_closid(NULL);
-	int i, reqpartid, pmg;
+	int i, ret, reqpartid, pmg;
 
 	if (!closid || !rmid)
 		return -EINVAL;
@@ -1059,7 +1080,48 @@ int resctrl_arch_alloc_rmid(u32 *closid, u32 *rmid)
 
 	*closid = reqpartid;
 	*rmid = pmg;
+
+	if (reqpartid_is_busy(reqpartid))
+		return 0;
+
+	ret = reqpartid_alloc(reqpartid);
+	if (ret < 0)
+		goto out_free_rmid;
+
+	ret = resctrl_sync_config(reqpartid);
+	if (ret < 0)
+		goto out;
+
 	return 0;
+
+out:
+	reqpartid_free(reqpartid);
+out_free_rmid:
+	free_rmid(reqpartid, pmg);
+	return ret;
+}
+
+void resctrl_arch_free_rmid(u32 reqpartid, u32 pmg)
+{
+	int i;
+
+	free_rmid(reqpartid, pmg);
+
+	/* Always reserve the reqPARTID which equals to its intPARTID. */
+	if (reqpartid == req2intpartid(reqpartid))
+		return;
+
+	/*
+	 * Check whether every RMID belongs to this reqPARTID is freed or
+	 * not. If all belonging rmids are freed, also free the reqPARTID
+	 * self.
+	 */
+	for (i = 0; i <= mpam_pmg_max; i++) {
+		if (rmid_is_busy(reqpartid, i))
+			return;
+	}
+
+	reqpartid_free(reqpartid);
 }
 
 int mpam_resctrl_setup(void)
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 08cf21186448..ca544143d6a9 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -325,8 +325,6 @@ int closids_supported(void);
 
 void closid_free(int closid);
 
-void free_rmid(u32 closid, u32 rmid);
-
 void resctrl_mon_resource_exit(void);
 
 void mon_event_count(void *info);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index d9041d134d54..8258ceaddd24 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -282,10 +282,24 @@ int alloc_rmid(u32 closid)
 	if (IS_ERR(entry))
 		return PTR_ERR(entry);
 
-	list_del(&entry->list);
+	list_del_init(&entry->list);
 	return entry->rmid;
 }
 
+bool rmid_is_busy(u32 closid, u32 rmid)
+{
+	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+	struct rmid_entry *entry;
+
+	entry = __rmid_entry(idx);
+
+	/*
+	 * If it's not in the rmid_free_lru list,
+	 * the rmid is working.
+	 */
+	return list_empty(&entry->list);
+}
+
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index 11532c5a5fed..69754ddada87 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -557,7 +557,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 * anymore when this group would be used for pseudo-locking. This
 	 * is safe to call on platforms not capable of monitoring.
 	 */
-	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+	resctrl_arch_free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	ret = 0;
 	goto out;
@@ -591,7 +591,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 
 	ret = rdtgroup_locksetup_user_restore(rdtgrp);
 	if (ret) {
-		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+		resctrl_arch_free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 		return ret;
 	}
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index b5748fce933f..2e8ec20f0415 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2754,7 +2754,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 
 	head = &rdtgrp->mon.crdtgrp_list;
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
-		free_rmid(sentry->closid, sentry->mon.rmid);
+		resctrl_arch_free_rmid(sentry->closid, sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
 
 		if (atomic_read(&sentry->waitcount) != 0)
@@ -2794,7 +2794,7 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
-		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+		resctrl_arch_free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 		kernfs_remove(rdtgrp->kn);
 		list_del(&rdtgrp->rdtgroup_list);
@@ -3289,7 +3289,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs subdir error\n");
-		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+		resctrl_arch_free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 		return ret;
 	}
 
@@ -3299,7 +3299,24 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
 	if (resctrl_arch_mon_capable())
-		free_rmid(rgrp->closid, rgrp->mon.rmid);
+		resctrl_arch_free_rmid(rgrp->closid, rgrp->mon.rmid);
+}
+
+int resctrl_sync_config(u32 closid)
+{
+	struct resctrl_schema *s;
+	int ret;
+
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		ret = resctrl_arch_update_domains(s->res, closid);
+		if (ret < 0) {
+			rdt_last_cmd_puts("Failed to synchronize partitions\n");
+			goto out;
+		}
+	}
+
+out:
+	return ret;
 }
 
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
@@ -3565,7 +3582,7 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
-	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+	resctrl_arch_free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
 	 * Remove the rdtgrp from the parent ctrl_mon group's list
@@ -3612,7 +3629,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
-	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+	resctrl_arch_free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
 	rdtgroup_ctrl_remove(rdtgrp);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ec679cfad5fb..ede5963cc5b0 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -511,6 +511,9 @@ static inline void resctrl_arch_rmid_read_context_check(void)
 }
 
 int alloc_rmid(u32 closid);
+void free_rmid(u32 closid, u32 rmid);
+bool rmid_is_busy(u32 closid, u32 rmid);
+
 /**
  * resctrl_arch_alloc_rmid() - Providing the similar functionality as
  *			       alloc_rmid, but this function is an
@@ -525,6 +528,17 @@ int alloc_rmid(u32 closid);
  * 0 on success, or -EINVAL, -ENOSPC etc on error.
  */
 int resctrl_arch_alloc_rmid(u32 *closid, u32 *rmid);
+/**
+ * resctrl_arch_free_rmid() - Manage rmid and reqpartid resources in
+ *			      conjunction with the
+ *			      resctrl_arch_alloc_rmid().
+ *
+ * @closid:	closid that matches the rmid.
+ * @rmid:	The rmid would be free.
+ */
+void resctrl_arch_free_rmid(u32 closid, u32 rmid);
+
+int resctrl_sync_config(u32 closid);
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
-- 
2.25.1


