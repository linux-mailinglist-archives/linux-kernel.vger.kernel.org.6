Return-Path: <linux-kernel+bounces-556738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5ABA5CE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0BC3B6F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41359264A62;
	Tue, 11 Mar 2025 18:40:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E125926461F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718440; cv=none; b=RanyGBWhezkEfy6RviWoKM1s5L6s/g4ZIpzBOroqfa8IhQ6RUhZqkrovOCKCemrs98DN6qq5Mt2d6dAwuyKcnpFQf/3H+231p/SpCPtdve+VN1ZF13nIpRfanp+PUTr+ENzGM2rXmB5TId9Z5kJQgSZLfZ89/TTyIRn3ggfIQT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718440; c=relaxed/simple;
	bh=WIMTabFq5rtpRGSKg9xj7oyKCmBUSfdS3qZ0H430xHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lb3ZRbv1DZgC09sWP9Y1V05TA+sprFyqN5hjGmKHQAYzre5H9Lt+HeJ6Lp2idJXrWdJn+0IbgM/NItGuZDydOG/6u2KcrJCi0uCFlfD1/We6P+CDPEchatg9N+Jh0fmCZzRanSNTRb5DcRd3vMWJuxuzFtZMGPk6cbhwKNGGqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31AED1762;
	Tue, 11 Mar 2025 11:40:49 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 982213F694;
	Tue, 11 Mar 2025 11:40:34 -0700 (PDT)
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
	Babu Moger <babu.moger@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8:for-boris 08/30] x86/resctrl: Generate default_ctrl instead of sharing it
Date: Tue, 11 Mar 2025 18:36:53 +0000
Message-Id: <20250311183715.16445-9-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250311183715.16445-1-james.morse@arm.com>
References: <20250311183715.16445-1-james.morse@arm.com>
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
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v7:
 * Dropped the hunk in cache_alloc_hsw_probe() and left it open-coded for
   readability.

Changes since v6:
 * Return MBA_BW_MAX from delay_bw_map() for improved readability.
 * Generate the bitmap directly in rdt_get_cache_alloc_cfg() to make it
   clear shareable_bits is being generated correctly.

Changes since v5:
 * Rewrote commit message.

Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c        | 13 +++++--------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  5 +++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 +++---
 include/linux/resctrl.h                   | 19 +++++++++++++++++--
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4504a12efc97..d001ca43b53d 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -155,7 +155,6 @@ static inline void cache_alloc_hsw_probe(void)
 		return;
 
 	hw_res->num_closid = 4;
-	r->default_ctrl = max_cbm;
 	r->cache.cbm_len = 20;
 	r->cache.shareable_bits = 0xc0000;
 	r->cache.min_cbm_bits = 2;
@@ -211,7 +210,6 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
 	cpuid_count(0x00000010, 3, &eax.full, &ebx, &ecx, &edx.full);
 	hw_res->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
-	r->default_ctrl = MAX_MBA_BW;
 	r->membw.max_bw = MAX_MBA_BW;
 	r->membw.arch_needs_linear = true;
 	if (ecx & MBA_IS_LINEAR) {
@@ -250,7 +248,6 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 
 	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
 	hw_res->num_closid = edx + 1;
-	r->default_ctrl = 1 << eax;
 	r->membw.max_bw = 1 << eax;
 
 	/* AMD does not use delay */
@@ -276,13 +273,13 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
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
@@ -329,7 +326,7 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 		return MAX_MBA_BW - bw;
 
 	pr_warn_once("Non Linear delay-bw map not supported but queried\n");
-	return r->default_ctrl;
+	return MAX_MBA_BW;
 }
 
 static void mba_wrmsr_intel(struct msr_param *m)
@@ -438,7 +435,7 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
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


