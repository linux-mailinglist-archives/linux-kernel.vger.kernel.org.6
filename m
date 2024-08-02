Return-Path: <linux-kernel+bounces-272907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2A946275
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620E01F23674
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131761A34CD;
	Fri,  2 Aug 2024 17:30:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E357415C12D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619819; cv=none; b=eTB+GEK1gw7RrDXxBGhYfW67ldmpUnUd82ZGh8G95w68VGh7nj2Qgrdqwoi0ZaKVLYjPRVFOJSUWQPiDLbC9n0BNJaXwvLK+4JBP4eaukpcSrs2RM0yyFykePlBi7swTenLD4QkB9/JzwF8e8lqSwaZXL8rFRzyvqi3ea9Gw5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619819; c=relaxed/simple;
	bh=HaLrFzz81Py3zI0MhmXkzFAeBHBYSXkq7rWzzwQsBdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FxiN9jphqDvtvdBmnqs/aNxekHLR0d7JQmzR3Lz65WmwiFbaPdfjrh0BvYCaTzUojq3y3bToUO9qxxN2Hxi0fERZWQ4XP9OSiXS5Hffif1+LQxichTzip6C9Qq1HcN6Wfs9+uKqJ8zPLsUfL41LskKIcQj7S10TYsLcvStIuAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D81B1480;
	Fri,  2 Aug 2024 10:30:43 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 631743F64C;
	Fri,  2 Aug 2024 10:30:14 -0700 (PDT)
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
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v4 08/39] x86/resctrl: Generate default_ctrl instead of sharing it
Date: Fri,  2 Aug 2024 17:28:22 +0000
Message-Id: <20240802172853.22529-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240802172853.22529-1-james.morse@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
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
---
Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 16 +++++++---------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  6 +++---
 include/linux/resctrl.h                | 21 +++++++++++++++++++--
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f0bbc1350070..1628c848bfd0 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -139,7 +139,10 @@ static inline void cache_alloc_hsw_probe(void)
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
@@ -151,8 +154,6 @@ static inline void cache_alloc_hsw_probe(void)
 		return;
 
 	hw_res->num_closid = 4;
-	r->default_ctrl = max_cbm;
-	r->cache.cbm_len = 20;
 	r->cache.shareable_bits = 0xc0000;
 	r->cache.min_cbm_bits = 2;
 	r->cache.arch_has_sparse_bitmasks = false;
@@ -207,7 +208,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	cpuid_count(0x00000010, 3, &eax.full, &ebx, &ecx, &edx.full);
 	hw_res->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
-	r->default_ctrl = MAX_MBA_BW;
 	r->membw.max_bw = MAX_MBA_BW;
 	r->membw.arch_needs_linear = true;
 	if (ecx & MBA_IS_LINEAR) {
@@ -244,7 +244,6 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 
 	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
 	hw_res->num_closid = edx + 1;
-	r->default_ctrl = 1 << eax;
 	r->schema_fmt = RESCTRL_SCHEMA_MBPS;
 	r->membw.max_bw = 1 << eax;
 
@@ -276,8 +275,7 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
 	hw_res->num_closid = edx.split.cos_max + 1;
 	r->cache.cbm_len = eax.split.cbm_len + 1;
-	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
-	r->cache.shareable_bits = ebx & r->default_ctrl;
+	r->cache.shareable_bits = ebx & resctrl_get_default_ctrl(r);
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
 	r->alloc_capable = true;
@@ -324,7 +322,7 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 		return MAX_MBA_BW - bw;
 
 	pr_warn_once("Non Linear delay-bw map not supported but queried\n");
-	return r->default_ctrl;
+	return resctrl_get_default_ctrl(r);
 }
 
 static void mba_wrmsr_intel(struct msr_param *m)
@@ -433,7 +431,7 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 	 * For Memory Allocation: Set b/w requested to 100%
 	 */
 	for (i = 0; i < hw_res->num_closid; i++, dc++)
-		*dc = r->default_ctrl;
+		*dc = resctrl_get_default_ctrl(r);
 }
 
 static void ctrl_domain_free(struct rdt_hw_ctrl_domain *hw_dom)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ed06384f9161..4aba311445f7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -969,7 +969,7 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
 
-	seq_printf(seq, "%x\n", r->default_ctrl);
+	seq_printf(seq, "%x\n", resctrl_get_default_ctrl(r));
 	return 0;
 }
 
@@ -2874,7 +2874,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		hw_dom = resctrl_to_arch_ctrl_dom(d);
 
 		for (i = 0; i < hw_res->num_closid; i++)
-			hw_dom->ctrl_val[i] = r->default_ctrl;
+			hw_dom->ctrl_val[i] = resctrl_get_default_ctrl(r);
 		msr_param.dom = d;
 		smp_call_function_any(&d->hdr.cpu_mask, rdt_ctrl_update, &msr_param, 1);
 	}
@@ -3409,7 +3409,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 		}
 
 		cfg = &d->staged_config[CDP_NONE];
-		cfg->new_ctrl = r->default_ctrl;
+		cfg->new_ctrl = resctrl_get_default_ctrl(r);
 		cfg->have_new_ctrl = true;
 	}
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5f08fb2f235f..0eb9854bf94f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -218,7 +218,6 @@ enum resctrl_schema_fmt {
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
- * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -235,7 +234,6 @@ struct rdt_resource {
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
-	u32			default_ctrl;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
 	bool			cdp_capable;
@@ -272,6 +270,25 @@ struct resctrl_schema {
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
+	case RESCTRL_SCHEMA_PERCENTAGE:
+		return 100u;
+	case RESCTRL_SCHEMA_MBPS:
+		return r->membw.max_bw;
+	}
+
+	return WARN_ON_ONCE(1);
+}
+
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
-- 
2.39.2


