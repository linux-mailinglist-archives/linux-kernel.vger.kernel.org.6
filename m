Return-Path: <linux-kernel+bounces-350860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64469990A91
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8547D1C21061
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9141DACA4;
	Fri,  4 Oct 2024 18:05:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767681DAC98
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065100; cv=none; b=SCZwgrpV8ViWR/nZXFjRIq5s4jBRCrwnyC8Ra9lgxwxP7Yq/dJbHyffOCyvg3JcXhU3qjWpPWik2bu6cpD+0SnXJgCOjdQ1PyM394/7POrOvY27PXuCDOXtgSdtE9QsQZTP7fvUvQR7vDvJe5oq0VqWlSBC9S3VBhXSOkV+KEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065100; c=relaxed/simple;
	bh=DG4pNXapHHAAgr9GL6f7sfviG1GzkUpCFbQq6dreWNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ja9nO7muurBrg6HzebGTd11pSbfaEVkadLaxWeDZLTGj3PIoQ3whjQD+74ePbXsBEgP39DKJwyY0oQHX4RGtQLgcY53Livky0szEFdrja1RqhQ53TEBhefixXYSq0wdJ+SB9aadQNCiHkwDSV5oYf0I55tzY03vSMw8udvIVrrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29ACA1063;
	Fri,  4 Oct 2024 11:05:27 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C46A3F58B;
	Fri,  4 Oct 2024 11:04:54 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v5 02/40] x86/resctrl: Add a helper to avoid reaching into the arch code resource list
Date: Fri,  4 Oct 2024 18:03:09 +0000
Message-Id: <20241004180347.19985-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>
References: <20241004180347.19985-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl occasionally wants to know something about a specific resource,
in these cases it reaches into the arch code's rdt_resources_all[]
array.

Once the filesystem parts of resctrl are moved to /fs/, this means it
will need visibility of the architecture specific struct
rdt_hw_resource definition, and the array of all resources.  All
architectures would also need a r_resctrl member in this struct.

Instead, abstract this via a helper to allow architectures to do
different things here. Move the level enum to the resctrl header and
add a helper to retrieve the struct rdt_resource by 'rid'.

resctrl_arch_get_resource() should not return NULL for any value in
the enum, it may instead return a dummy resource that is
!alloc_enabled && !mon_enabled.

Co-developed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v1:
 * Backed out non-functional renaming of "r" to "l3" in rdt_get_tree(),
   and unhoisted the assignment of r (as now is) back into the if ()
   where it started out.  There seem to be no uses of this variable
   outside this if().
 * [Commit message only] Typo fix:
   s/resctrl_hw_resource/rdt_hw_resource/g
---
 arch/x86/kernel/cpu/resctrl/core.c        | 10 +++++++++-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 ----------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  8 ++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 +++++++-------
 include/linux/resctrl.h                   | 17 +++++++++++++++++
 6 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8591d53c144b..12af2adf371c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -127,6 +127,14 @@ u32 resctrl_arch_system_num_rmid_idx(void)
 	return r->num_rmid;
 }
 
+struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
+{
+	if (l >= RDT_NUM_RESOURCES)
+		return NULL;
+
+	return &rdt_resources_all[l].r_resctrl;
+}
+
 /*
  * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
  * as they do not have CPUID enumeration support for Cache allocation.
@@ -174,7 +182,7 @@ static inline void cache_alloc_hsw_probe(void)
 bool is_mba_sc(struct rdt_resource *r)
 {
 	if (!r)
-		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
+		r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 
 	/*
 	 * The software controller support is only applicable to MBA resource.
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..e078bfe3840d 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -574,7 +574,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	resid = md.u.rid;
 	domid = md.u.domid;
 	evtid = md.u.evtid;
-	r = &rdt_resources_all[resid].r_resctrl;
+	r = resctrl_arch_get_resource(resid);
 
 	if (md.u.sum) {
 		/*
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 955999aecfca..b5a34a3fa599 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -509,16 +509,6 @@ extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
 
-enum resctrl_res_level {
-	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L2,
-	RDT_RESOURCE_MBA,
-	RDT_RESOURCE_SMBA,
-
-	/* Must be the last */
-	RDT_NUM_RESOURCES,
-};
-
 static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 851b561850e0..00d906a1f51c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -365,7 +365,7 @@ static void limbo_release_entry(struct rmid_entry *entry)
  */
 void __check_limbo(struct rdt_mon_domain *d, bool force_free)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
 	u32 idx, cur_idx = 1;
@@ -521,7 +521,7 @@ int alloc_rmid(u32 closid)
 
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	struct rdt_mon_domain *d;
 	u32 idx;
 
@@ -760,7 +760,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 	if (!is_mbm_local_enabled())
 		return;
 
-	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
@@ -929,7 +929,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		goto out_unlock;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	d = container_of(work, struct rdt_mon_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2d48db66fca8..6225d0b7e9ee 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2251,7 +2251,7 @@ static void l2_qos_cfg_update(void *arg)
 
 static inline bool is_mba_linear(void)
 {
-	return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.delay_linear;
+	return resctrl_arch_get_resource(RDT_RESOURCE_MBA)->membw.delay_linear;
 }
 
 static int set_cache_qos_cfg(int level, bool enable)
@@ -2341,8 +2341,8 @@ static void mba_sc_domain_destroy(struct rdt_resource *r,
  */
 static bool supports_mba_mbps(void)
 {
-	struct rdt_resource *rmbm = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	struct rdt_resource *rmbm = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 
 	return (is_mbm_local_enabled() &&
 		r->alloc_capable && is_mba_linear() &&
@@ -2355,7 +2355,7 @@ static bool supports_mba_mbps(void)
  */
 static int set_mba_sc(bool mba_sc)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 	u32 num_closid = resctrl_arch_get_num_closid(r);
 	struct rdt_ctrl_domain *d;
 	int i;
@@ -2703,7 +2703,7 @@ static int rdt_get_tree(struct fs_context *fc)
 		resctrl_mounted = true;
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+		r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 		list_for_each_entry(dom, &r->mon_domains, hdr.list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
 						   RESCTRL_PICK_ANY_CPU);
@@ -3938,7 +3938,7 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
 		seq_puts(seq, ",cdpl2");
 
-	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
+	if (is_mba_sc(resctrl_arch_get_resource(RDT_RESOURCE_MBA)))
 		seq_puts(seq, ",mba_MBps");
 
 	if (resctrl_debug)
@@ -4138,7 +4138,7 @@ static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
 
 void resctrl_offline_cpu(unsigned int cpu)
 {
-	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *l3 = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	struct rdt_mon_domain *d;
 	struct rdtgroup *rdtgrp;
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d94abba1c716..37279e2a89da 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -37,6 +37,16 @@ enum resctrl_conf_type {
 	CDP_DATA,
 };
 
+enum resctrl_res_level {
+	RDT_RESOURCE_L3,
+	RDT_RESOURCE_L2,
+	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_SMBA,
+
+	/* Must be the last */
+	RDT_NUM_RESOURCES,
+};
+
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
 
 /*
@@ -226,6 +236,13 @@ struct rdt_resource {
 	bool			cdp_capable;
 };
 
+/*
+ * Get the resource that exists at this level. If the level is not supported
+ * a dummy/not-capable resource can be returned. Levels >= RDT_NUM_RESOURCES
+ * will return NULL.
+ */
+struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
+
 /**
  * struct resctrl_schema - configuration abilities of a resource presented to
  *			   user-space
-- 
2.39.2


