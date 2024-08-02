Return-Path: <linux-kernel+bounces-272905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D69946273
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCBA285B73
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58315C155;
	Fri,  2 Aug 2024 17:30:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D656166F2E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619813; cv=none; b=NgNBybPmCyySJdW2ALx90qkX4VEuiyOA1QoBrTQ79QF7plaNVh9Fl6HpC4zd47f4MjBXBoOuYDeRo763LKVkngMWxDfPxjD9zs+2yVpL5pSHxGN2oBpfiJ4/LvwvsVwP/9YO41wEyiDoC1krcFDDkKH3dSg01CnKimCd5IyjI/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619813; c=relaxed/simple;
	bh=mD3UwW/X0FASHix5tYLUsjbWQAnbMukwBkYY2quwGh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J2gT5ceuf9RyWL5LAfnL9v8Ghsseexoge8U2hW5uktMXIRAq0g2+Sc0/IQQMeAvK6CV7RJx5bcxSsMGKs6oNRva9kOgEBcw+zjdOkdZxs1clmK1WtVt1iUdKRQoZQpKTeDiTRObBL/w/z8H6a53kF99WcAth5/qE1rWr5ErF9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A022D1007;
	Fri,  2 Aug 2024 10:30:36 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC2AC3F64C;
	Fri,  2 Aug 2024 10:30:07 -0700 (PDT)
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
Subject: [PATCH v4 06/39] x86/resctrl: Move data_width to be a schema property
Date: Fri,  2 Aug 2024 17:28:20 +0000
Message-Id: <20240802172853.22529-7-james.morse@arm.com>
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

The resctrl architecture code gets to specify the width of the schema
entries that are used by resctrl. These are determined by the schema
format, e.g. percentage or bitmap.

Move this property into struct resctrl_schema and get the filesystem
parts of resctrl to set it based on the schema format. Remove
rdt_init_padding(), its work is be done by schemata_list_add(),
allowing max_name_width and max_data_width to be moved out of core.c
which has no counterpart after the move to fs.

The logic for calculating max_name_width was moved in earlier patches,
but the definition was not moved.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
---
Changes since v3:
 * Moved some words around in the commit message - maybe this is the right mood?
 * Added a full-stop to an existing comment.

Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 26 --------------------------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
 include/linux/resctrl.h                |  4 ++--
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f16014ee48aa..cb1d634274b4 100644
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
@@ -224,7 +218,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 			return false;
 		r->membw.arch_needs_linear = false;
 	}
-	r->data_width = 3;
 
 	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA))
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
@@ -264,8 +257,6 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	r->membw.throttle_mode = THREAD_THROTTLE_UNDEFINED;
 	r->membw.min_bw = 0;
 	r->membw.bw_gran = 1;
-	/* Max value is 2048, Data width should be 4 in decimal */
-	r->data_width = 4;
 
 	r->alloc_capable = true;
 
@@ -285,7 +276,6 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->cache.cbm_len = eax.split.cbm_len + 1;
 	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
 	r->cache.shareable_bits = ebx & r->default_ctrl;
-	r->data_width = (r->cache.cbm_len + 3) / 4;
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
 	r->alloc_capable = true;
@@ -781,20 +771,6 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
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
@@ -1092,8 +1068,6 @@ static int __init resctrl_late_init(void)
 	if (!get_rdt_resources())
 		return -ENODEV;
 
-	rdt_init_padding();
-
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "x86/resctrl/cat:online:",
 				  resctrl_arch_online_cpu,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1ce851447923..ed06384f9161 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -57,6 +57,12 @@ static struct kernfs_node *kn_mongrp;
 /* Kernel fs node for "mon_data" directory under root */
 static struct kernfs_node *kn_mondata;
 
+/*
+ * Used to store the max resource name width and max resource data width
+ * to display the schemata in a tabular format.
+ */
+int max_name_width, max_data_width;
+
 static struct seq_buf last_cmd_status;
 static char last_cmd_status_buf[512];
 
@@ -2603,15 +2609,20 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 	switch (r->schema_fmt) {
 	case RESCTRL_SCHEMA_BITMAP:
 		s->fmt_str = "%d=%0*x";
+		s->data_width = (r->cache.cbm_len + 3) / 4;
 		break;
 	case RESCTRL_SCHEMA_PERCENTAGE:
 		s->fmt_str = "%d=%0*u";
+		s->data_width = 3;
 		break;
 	case RESCTRL_SCHEMA_MBPS:
 		s->fmt_str = "%d=%0*u";
+		s->data_width = 4;
 		break;
 	}
 
+	max_data_width = max(max_data_width, s->data_width);
+
 	INIT_LIST_HEAD(&s->list);
 	list_add(&s->list, &resctrl_schema_all);
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 1624d4b15b52..fe3c1ff732de 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -216,7 +216,6 @@ enum resctrl_schema_fmt {
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
- * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
@@ -234,7 +233,6 @@ struct rdt_resource {
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
-	int			data_width;
 	u32			default_ctrl;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
@@ -254,6 +252,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
  * @list:	Member of resctrl_schema_all.
  * @name:	The name to use in the "schemata" file.
  * @fmt_str:	Format string to show domain value
+ * @data_width:	Character width of data when displaying
  * @conf_type:	Whether this schema is specific to code/data.
  * @res:	The resource structure exported by the architecture to describe
  *		the hardware that is configured by this schema.
@@ -265,6 +264,7 @@ struct resctrl_schema {
 	struct list_head		list;
 	char				name[8];
 	const char			*fmt_str;
+	int				data_width;
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
-- 
2.39.2


