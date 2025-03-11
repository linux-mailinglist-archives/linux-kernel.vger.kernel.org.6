Return-Path: <linux-kernel+bounces-556736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A93A5CE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976E617CF9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD09C263F3F;
	Tue, 11 Mar 2025 18:40:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462B426460B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718433; cv=none; b=s2ByI8n6HzgLgKcj+VPoNu6t7as33Dr1cN3LRC/+EDKxVA092VOm+lR9i9+GgRR02CYTX2qgQCVRsiVWFt59hF3aqM0A3mM8lwbEvpbMxwUe/NnSCPepcEvarOfEzB4Ji5+J8yF2BlzYfCimesjp5HOqm82XL1y3du833DnKi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718433; c=relaxed/simple;
	bh=HSbVP+Ni2lfqgdhhtyAl+mGcj41xi1GRTOk2mILwqKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZoXxJooPXniNCzQgwZUBXSiDtN0SbojOX8HHMvYq6bC8DL9wOjif4ZZc5K+CyJ1kFmqF48OtjKFS2w72swYPvCmRO/SQxUMCu0CMfvvbkMo5DRgOclnICb43TXazRQtBiaiNkD4iTMAvs2YkvZnILHfJ9mortEZwAGsncRaAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 934A91515;
	Tue, 11 Mar 2025 11:40:41 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C42F3F694;
	Tue, 11 Mar 2025 11:40:27 -0700 (PDT)
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
Subject: [PATCH v8:for-boris 06/30] x86/resctrl: Remove data_width and the tabular format
Date: Tue, 11 Mar 2025 18:36:51 +0000
Message-Id: <20250311183715.16445-7-james.morse@arm.com>
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

The resctrl architecture code provides a data_width for the controls of
each resource. This is used to zero pad all control values in the schemata
file so they appear in columns. The same is done with the resource names
to complete the visual effect. e.g.
| SMBA:0=2048
|   L3:0=00ff

AMD platforms discover their maximum bandwidth for the MB resource from
firmware, but hard-code the data_width to 4. If the maximum bandwidth
requires more digits - the tabular format is silently broken.
This is also broken when the mba_MBps mount option is used as the
field width isn't updated. If new schema are added resctrl will need
to be able to determine the maximum width. The benefit of this
pretty-printing is questionable.

Instead of handling runtime discovery of the data_width for AMD platforms,
remove the feature. These fields are always zero padded so should be
harmless to remove if the whole field has been treated as a number.
In the above example, this would now look like this:
| SMBA:0=2048
|   L3:0=ff

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 26 -----------------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  3 +--
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 10 +++++++--
 include/linux/resctrl.h                   |  2 --
 5 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 542503a8c953..754fb65565ec 100644
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
@@ -228,7 +222,6 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
 			return false;
 		r->membw.arch_needs_linear = false;
 	}
-	r->data_width = 3;
 
 	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA))
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
@@ -269,8 +262,6 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	r->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
 	r->membw.min_bw = 0;
 	r->membw.bw_gran = 1;
-	/* Max value is 2048, Data width should be 4 in decimal */
-	r->data_width = 4;
 
 	r->alloc_capable = true;
 
@@ -290,7 +281,6 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->cache.cbm_len = eax.split.cbm_len + 1;
 	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
 	r->cache.shareable_bits = ebx & r->default_ctrl;
-	r->data_width = (r->cache.cbm_len + 3) / 4;
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
 	r->alloc_capable = true;
@@ -786,20 +776,6 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
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
@@ -1102,8 +1078,6 @@ static int __init resctrl_late_init(void)
 	if (!get_rdt_resources())
 		return -ENODEV;
 
-	rdt_init_padding();
-
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
 				  resctrl_arch_online_cpu,
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index c763cb4fb1a8..59610b209b4e 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -487,8 +487,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
 							   schema->conf_type);
 
-		seq_printf(s, schema->fmt_str, dom->hdr.id, max_data_width,
-			   ctrl_val);
+		seq_printf(s, schema->fmt_str, dom->hdr.id, ctrl_val);
 		sep = true;
 	}
 	seq_puts(s, "\n");
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b5543bd506c3..f975cd6cfe61 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -326,7 +326,7 @@ struct rdtgroup {
 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
 
-extern int max_name_width, max_data_width;
+extern int max_name_width;
 
 int __init rdtgroup_init(void);
 void __exit rdtgroup_exit(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e7862d0936c9..1e0bae1a9d95 100644
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
 
@@ -2613,10 +2619,10 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 
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
index 736b9a9a9464..e1a982adef45 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -214,7 +214,6 @@ enum resctrl_schema_fmt {
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
- * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @schema_fmt:		Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
@@ -232,7 +231,6 @@ struct rdt_resource {
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
-	int			data_width;
 	u32			default_ctrl;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
-- 
2.39.5


