Return-Path: <linux-kernel+bounces-539343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D8A4A354
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB3C3AC357
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F2C2755F6;
	Fri, 28 Feb 2025 20:00:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98FE27426E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772830; cv=none; b=a8dx8OITn01QI8h/3q3q5bEEcgWw7/avtUSe6Qy53+OfoWMfO8WxW/RZPjZA793TOVoMSchaTxyZGfpXULftf7Cr6lF7JqGMvk0HufMvEoVIClzSy7wgr6MD5878oDi/jNe5PoVOxTovJsUepYomcsP8jROAxnHk8+wk3edlFOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772830; c=relaxed/simple;
	bh=0NUdUJFNBD3qpcu76zmufwJOvy96yO/+onwYYOLxlFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5cFmr7IbxEph8ac1qDXnZkD3smTa2H7GWbX5Qv87hQ9nkCLHNo0UoBzZJH6uUey8SIDezII24VN0O7TB2WJZTSxkU66fIBsogS90wF3QlL8NYUzrfXWw3ME7hbyyuxCcGLW7MZ0bM0gmogBmZcZ/KOaZNtm2d9vDZwBjEDk1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29915150C;
	Fri, 28 Feb 2025 12:00:43 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB6093F5A1;
	Fri, 28 Feb 2025 12:00:24 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
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
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 08/49] x86/resctrl: Generate default_ctrl instead of sharing it
Date: Fri, 28 Feb 2025 19:58:32 +0000
Message-Id: <20250228195913.24895-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
References: <20250228195913.24895-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct rdt_resource default_ctrl is used by both the architecture
code for resetting the hardware controls, and sometimes by the
filesystem code as the default value for the schema, unless the
bandwidth software controller is in use.

Having the default exposed by the architecture code causes unnecessary
duplication for each architecture as the default value must be specified,
but can be derived from other schema properties. Now that the
maximum bandwidth is explicitly described, resctrl can derive the default
value from the schema format and the other resource properties.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Changes since v6:
 * Return MBA_BW_MAX from delay_bw_map() for improved readability.
 * Generate the bitmap directly in rdt_get_cache_alloc_cfg() to make it
   clear shareable_bits is being generated correctly.

Changes since v5:
 * Rewrote commit message.

Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c        | 19 +++++++++----------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  5 +++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 +++---
 include/linux/resctrl.h                   | 19 +++++++++++++++++--
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4504a12efc97..5280a2819760 100644
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
@@ -211,7 +212,6 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
 	cpuid_count(0x00000010, 3, &eax.full, &ebx, &ecx, &edx.full);
 	hw_res->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
-	r->default_ctrl = MAX_MBA_BW;
 	r->membw.max_bw = MAX_MBA_BW;
 	r->membw.arch_needs_linear = true;
 	if (ecx & MBA_IS_LINEAR) {
@@ -250,7 +250,6 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 
 	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
 	hw_res->num_closid = edx + 1;
-	r->default_ctrl = 1 << eax;
 	r->membw.max_bw = 1 << eax;
 
 	/* AMD does not use delay */
@@ -276,13 +275,13 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	union cpuid_0x10_1_eax eax;
 	union cpuid_0x10_x_ecx ecx;
 	union cpuid_0x10_x_edx edx;
-	u32 ebx;
+	u32 ebx, default_ctrl;
 
 	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
 	hw_res->num_closid = edx.split.cos_max + 1;
 	r->cache.cbm_len = eax.split.cbm_len + 1;
-	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
-	r->cache.shareable_bits = ebx & r->default_ctrl;
+	default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
+	r->cache.shareable_bits = ebx & default_ctrl;
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
 	r->alloc_capable = true;
@@ -329,7 +328,7 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 		return MAX_MBA_BW - bw;
 
 	pr_warn_once("Non Linear delay-bw map not supported but queried\n");
-	return r->default_ctrl;
+	return MAX_MBA_BW;
 }
 
 static void mba_wrmsr_intel(struct msr_param *m)
@@ -438,7 +437,7 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 	 * For Memory Allocation: Set b/w requested to 100%
 	 */
 	for (i = 0; i < hw_res->num_closid; i++, dc++)
-		*dc = r->default_ctrl;
+		*dc = resctrl_get_default_ctrl(r);
 }
 
 static void ctrl_domain_free(struct rdt_hw_ctrl_domain *hw_dom)
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 23a01eaebd58..5d87f279085f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -113,8 +113,9 @@ static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
  */
 static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
-	unsigned long first_bit, zero_bit, val;
+	u32 supported_bits = BIT_MASK(r->cache.cbm_len) - 1;
 	unsigned int cbm_len = r->cache.cbm_len;
+	unsigned long first_bit, zero_bit, val;
 	int ret;
 
 	ret = kstrtoul(buf, 16, &val);
@@ -123,7 +124,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 		return false;
 	}
 
-	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > r->default_ctrl) {
+	if ((r->cache.min_cbm_bits > 0 && val == 0) || val > supported_bits) {
 		rdt_last_cmd_puts("Mask out of range\n");
 		return false;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1e0bae1a9d95..cd8f65c12124 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -978,7 +978,7 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
 
-	seq_printf(seq, "%x\n", r->default_ctrl);
+	seq_printf(seq, "%x\n", resctrl_get_default_ctrl(r));
 	return 0;
 }
 
@@ -2882,7 +2882,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		hw_dom = resctrl_to_arch_ctrl_dom(d);
 
 		for (i = 0; i < hw_res->num_closid; i++)
-			hw_dom->ctrl_val[i] = r->default_ctrl;
+			hw_dom->ctrl_val[i] = resctrl_get_default_ctrl(r);
 		msr_param.dom = d;
 		smp_call_function_any(&d->hdr.cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	}
@@ -3417,7 +3417,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 		}
 
 		cfg = &d->staged_config[CDP_NONE];
-		cfg->new_ctrl = r->default_ctrl;
+		cfg->new_ctrl = resctrl_get_default_ctrl(r);
 		cfg->have_new_ctrl = true;
 	}
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 465f3cf8c4bc..d16dc960f1fc 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -216,7 +216,6 @@ enum resctrl_schema_fmt {
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
- * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @schema_fmt:		Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -233,7 +232,6 @@ struct rdt_resource {
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
-	u32			default_ctrl;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
 	bool			cdp_capable;
@@ -268,6 +266,23 @@ struct resctrl_schema {
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
2.39.5


