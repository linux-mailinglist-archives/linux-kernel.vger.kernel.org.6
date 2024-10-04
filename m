Return-Path: <linux-kernel+bounces-350866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A940F990A97
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6623828615E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA491E2848;
	Fri,  4 Oct 2024 18:05:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42431DACA5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065123; cv=none; b=Qz/s8X+8OI/JzIcZgQ/5YlSstsVYD0CTCOHOPQboEPmOdRAG/i8ACNjI9p4CttNwW4atpwOE0QTr4XmYmeQV0NpPLuufm6vCheEHkugRZDAzYz+t6tKREZ53nHQyX0oscELxMuPVGd6KdPcE24ljZi9MT9Xh6bx7oy70FXq+2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065123; c=relaxed/simple;
	bh=b77tL2BUTuzx5prdXtKqIEMtu0YyCdzOFjdAaT7iqwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKpSBxefxZP+feiRYPz0tv0galwX3Um71dCuGFJeziT8B4DmzluQyQkioiz6v9o39AOijrwMK42rsHrr07v5ovsk+lZ2fsmUOUWu/2ILQPQtyuO7bNNVKewgVldDZjGdR962/PGK9vQSWP90WdlQJMoG8UXtyKPQ/vkMuAGgOc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2F7A1063;
	Fri,  4 Oct 2024 11:05:50 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04CAA3F58B;
	Fri,  4 Oct 2024 11:05:16 -0700 (PDT)
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
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v5 08/40] x86/resctrl: Generate default_ctrl instead of sharing it
Date: Fri,  4 Oct 2024 18:03:15 +0000
Message-Id: <20241004180347.19985-9-james.morse@arm.com>
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

The struct rdt_resource default_ctrl is used by both the architecture
code for resetting the hardware controls, and by the filesystem parts
of resctrl to report to user-space.

This means the value has to be shared, but might not match the
properties of the control. e.g. a percentage greater than 100.

Instead, determine the default control value from a shared helper
resctrl_get_default_ctrl() that uses the schema properties to
determine the correct value.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 16 +++++++---------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  6 +++---
 include/linux/resctrl.h                | 19 +++++++++++++++++--
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e79807a8f060..d77bfa17447a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -143,7 +143,10 @@ static inline void cache_alloc_hsw_probe(void)
 {
 	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
 	struct rdt_resource *r  = &hw_res->r_resctrl;
-	u64 max_cbm = BIT_ULL_MASK(20) - 1, l3_cbm_0;
+	u64 max_cbm, l3_cbm_0;
+
+	r->cache.cbm_len = 20;
+	max_cbm = resctrl_get_default_ctrl(r);
 
 	if (wrmsrl_safe(MSR_IA32_L3_CBM_BASE, max_cbm))
 		return;
@@ -155,8 +158,6 @@ static inline void cache_alloc_hsw_probe(void)
 		return;
 
 	hw_res->num_closid = 4;
-	r->default_ctrl = max_cbm;
-	r->cache.cbm_len = 20;
 	r->cache.shareable_bits = 0xc0000;
 	r->cache.min_cbm_bits = 2;
 	r->cache.arch_has_sparse_bitmasks = false;
@@ -211,7 +212,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	cpuid_count(0x00000010, 3, &eax.full, &ebx, &ecx, &edx.full);
 	hw_res->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
-	r->default_ctrl = MAX_MBA_BW;
 	r->membw.max_bw = MAX_MBA_BW;
 	r->membw.arch_needs_linear = true;
 	if (ecx & MBA_IS_LINEAR) {
@@ -248,7 +248,6 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 
 	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
 	hw_res->num_closid = edx + 1;
-	r->default_ctrl = 1 << eax;
 	r->schema_fmt = RESCTRL_SCHEMA_RANGE;
 	r->membw.max_bw = 1 << eax;
 
@@ -280,8 +279,7 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
 	hw_res->num_closid = edx.split.cos_max + 1;
 	r->cache.cbm_len = eax.split.cbm_len + 1;
-	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
-	r->cache.shareable_bits = ebx & r->default_ctrl;
+	r->cache.shareable_bits = ebx & resctrl_get_default_ctrl(r);
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
 	r->alloc_capable = true;
@@ -328,7 +326,7 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 		return MAX_MBA_BW - bw;
 
 	pr_warn_once("Non Linear delay-bw map not supported but queried\n");
-	return r->default_ctrl;
+	return resctrl_get_default_ctrl(r);
 }
 
 static void mba_wrmsr_intel(struct msr_param *m)
@@ -437,7 +435,7 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 	 * For Memory Allocation: Set b/w requested to 100%
 	 */
 	for (i = 0; i < hw_res->num_closid; i++, dc++)
-		*dc = r->default_ctrl;
+		*dc = resctrl_get_default_ctrl(r);
 }
 
 static void ctrl_domain_free(struct rdt_hw_ctrl_domain *hw_dom)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1707b04e901e..de2c169a1678 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -969,7 +969,7 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
 
-	seq_printf(seq, "%x\n", r->default_ctrl);
+	seq_printf(seq, "%x\n", resctrl_get_default_ctrl(r));
 	return 0;
 }
 
@@ -2866,7 +2866,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		hw_dom = resctrl_to_arch_ctrl_dom(d);
 
 		for (i = 0; i < hw_res->num_closid; i++)
-			hw_dom->ctrl_val[i] = r->default_ctrl;
+			hw_dom->ctrl_val[i] = resctrl_get_default_ctrl(r);
 		msr_param.dom = d;
 		smp_call_function_any(&d->hdr.cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	}
@@ -3401,7 +3401,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 		}
 
 		cfg = &d->staged_config[CDP_NONE];
-		cfg->new_ctrl = r->default_ctrl;
+		cfg->new_ctrl = resctrl_get_default_ctrl(r);
 		cfg->have_new_ctrl = true;
 	}
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b66cd977b658..1a9cca95b5e8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -217,7 +217,6 @@ enum resctrl_schema_fmt {
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
- * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -234,7 +233,6 @@ struct rdt_resource {
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
-	u32			default_ctrl;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
 	bool			cdp_capable;
@@ -269,6 +267,23 @@ struct resctrl_schema {
 	u32				num_closid;
 };
 
+/**
+ * resctrl_get_default_ctrl() - Return the default control value for this
+ *                              resource.
+ * @r:		The resource whose default control type is queried.
+ */
+static inline u32 resctrl_get_default_ctrl(struct rdt_resource *r)
+{
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		return BIT_MASK(r->cache.cbm_len) - 1;
+	case RESCTRL_SCHEMA_RANGE:
+		return r->membw.max_bw;
+	}
+
+	return WARN_ON_ONCE(1);
+}
+
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
-- 
2.39.2


