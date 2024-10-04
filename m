Return-Path: <linux-kernel+bounces-350864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EF2990A95
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BEA1B21E25
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A791DD88C;
	Fri,  4 Oct 2024 18:05:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881E61DD881
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065114; cv=none; b=N3WH7MceS0JUlO41RBGYjVMelhpsUi6PRmbzW2dG2ZVQk4UbMS8QNZKhmB+B4ZIuBlJb4aD0XOodBQd1opWO6F9/iUL9F/gc7FW5w3Um+IdpHgVl01bmEKUvRHrTbXEBg3RvLNTYxZ4aCsfgpP1P52sZbB6JKo6kPoAR2yw0VRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065114; c=relaxed/simple;
	bh=xvK2uODfw3NajPHdbz3nvRc8e1Euxm/6wxhmmA0alSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xoc4Loa1CPX8xugEjGyDA+FqtjeUwVqO4gwhyjGO2wrbKC+g3qgFWq56UFcTL/Yvlv2+Inc+a0sFTXU2RIbImd4Y3LmKA4cvydWwwrMuktZB55hgn5OUnIzVJnLh2e+MMN9sMlZ1TvAxMQS6pBcfhF+MpONXXlJfQn2PQsDZE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 730E4150C;
	Fri,  4 Oct 2024 11:05:41 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03FBD3F58B;
	Fri,  4 Oct 2024 11:05:07 -0700 (PDT)
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
Subject: [PATCH v5 06/40] x86/resctrl: Remove data_width and the tabular format
Date: Fri,  4 Oct 2024 18:03:13 +0000
Message-Id: <20241004180347.19985-7-james.morse@arm.com>
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

The resctrl architecture code provides a data_width for the controls of
each resource. This is used to zero pad all control values in the schemata
file so they appear in columns. The same is done with the resource names
to complete the visual effect. e.g.
| SMBA:0=2048
|   L3:0=00ff

AMD platforms discover their maximum bandwidth for the MB resource from
firmware, but hard-code the data_width to 4. If the maximum bandwidth
requires more digits - the tabular format is silently broken.
If new schema are added resctrl will need to be able to determine the
maximum width. The benefit of this pretty-printing is questionable.

Instead of handling runtime discovery of the data_width for AMD platforms,
remove the feature. These fields are always zero padded so should be
harmless to remove if the whole field has been treated as a number.
In the above example, this would now look like this:
| SMBA:0=2048
|   L3:0=ff

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since
---
 arch/x86/kernel/cpu/resctrl/core.c        | 26 -----------------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  3 +--
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 10 +++++++--
 include/linux/resctrl.h                   |  2 --
 5 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2a7f0f92c632..4c16e58c4a1b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -43,12 +43,6 @@ static DEFINE_MUTEX(domain_list_lock);
  */
 DEFINE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
-/*
- * Used to store the max resource name width and max resource data width
- * to display the schemata in a tabular format
- */
-int max_name_width, max_data_width;
-
 /*
  * Global boolean for rdt_alloc which is true if any
  * resource allocation is enabled.
@@ -228,7 +222,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 			return false;
 		r->membw.arch_needs_linear = false;
 	}
-	r->data_width = 3;
 
 	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA))
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
@@ -267,8 +260,6 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	r->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
 	r->membw.min_bw = 0;
 	r->membw.bw_gran = 1;
-	/* Max value is 2048, Data width should be 4 in decimal */
-	r->data_width = 4;
 
 	r->alloc_capable = true;
 
@@ -288,7 +279,6 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->cache.cbm_len = eax.split.cbm_len + 1;
 	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
 	r->cache.shareable_bits = ebx & r->default_ctrl;
-	r->data_width = (r->cache.cbm_len + 3) / 4;
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
 	r->alloc_capable = true;
@@ -784,20 +774,6 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Choose a width for the resource name and resource data based on the
- * resource that has widest name and cbm.
- */
-static __init void rdt_init_padding(void)
-{
-	struct rdt_resource *r;
-
-	for_each_alloc_capable_rdt_resource(r) {
-		if (r->data_width > max_data_width)
-			max_data_width = r->data_width;
-	}
-}
-
 enum {
 	RDT_FLAG_CMT,
 	RDT_FLAG_MBM_TOTAL,
@@ -1095,8 +1071,6 @@ static int __init resctrl_late_init(void)
 	if (!get_rdt_resources())
 		return -ENODEV;
 
-	rdt_init_padding();
-
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
 				  resctrl_arch_online_cpu,
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 71881f902728..8d1bdfe89692 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -482,8 +482,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
 							   schema->conf_type);
 
-		seq_printf(s, schema->fmt_str, dom->hdr.id, max_data_width,
-			   ctrl_val);
+		seq_printf(s, schema->fmt_str, dom->hdr.id, ctrl_val);
 		sep = true;
 	}
 	seq_puts(s, "\n");
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ffcade365070..b69722faa703 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -324,7 +324,7 @@ struct rdtgroup {
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
 
-extern int max_name_width, max_data_width;
+extern int max_name_width;
 
 int __init rdtgroup_init(void);
 void __exit rdtgroup_exit(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 896350e9fb32..1707b04e901e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -57,6 +57,12 @@ static struct kernfs_node *kn_mongrp;
 /* Kernel fs node for "mon_data" directory under root */
 static struct kernfs_node *kn_mondata;
 
+/*
+ * Used to store the max resource name width to display the schemata names in
+ * a tabular format.
+ */
+int max_name_width;
+
 static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];
 
@@ -2602,10 +2608,10 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 
 	switch (r->schema_fmt) {
 	case RESCTRL_SCHEMA_BITMAP:
-		s->fmt_str = "%d=%0*x";
+		s->fmt_str = "%d=%x";
 		break;
 	case RESCTRL_SCHEMA_RANGE:
-		s->fmt_str = "%d=%0*u";
+		s->fmt_str = "%d=%u";
 		break;
 	}
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8a7f58d67ed6..0f61673c9165 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -215,7 +215,6 @@ enum resctrl_schema_fmt {
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
- * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
@@ -233,7 +232,6 @@ struct rdt_resource {
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
-	int			data_width;
 	u32			default_ctrl;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
-- 
2.39.2


