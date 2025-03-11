Return-Path: <linux-kernel+bounces-556735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A6A5CE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E39D17CE97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076E52641F8;
	Tue, 11 Mar 2025 18:40:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F7D2641F5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718429; cv=none; b=Gcxf/iELaCXTr6wYo0tZZ39vSB1doy0yMo160Ds4k/WLQaR4DIIBdrEAU8BX0aNopQ3TKdEeONrL5a7mnMB/JSZeUgk11Bk8uEKm97MwCdBY5htcB8p/c0wHWKH037DIDeDx4cs2/jI1yk8l/jLEfNcjjXPVS1sCLGTXVgDDxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718429; c=relaxed/simple;
	bh=Qe77bJhCDYr1i/oD+Cdlt0KCIOTR3PruKv11ZFeO4nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgtBO9zXMCXKTwEhGyjhyktctF+SN1MpPans7eXcaZByN4/7Q7NKSPTGJQ+zttaetscyGaMC7rqO/UO69fNCVUiyQHKc7K+E3sQit0knEBEHp3rfYjzBzfjtDZe58jPHfbcqwjbwE4X5s6ITeWud0GnQ/SyvM4E1hwOkIlf5WMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9D131713;
	Tue, 11 Mar 2025 11:40:37 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629353F694;
	Tue, 11 Mar 2025 11:40:23 -0700 (PDT)
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
Subject: [PATCH v8:for-boris 05/30] x86/resctrl: Use schema type to determine the schema format string
Date: Tue, 11 Mar 2025 18:36:50 +0000
Message-Id: <20250311183715.16445-6-james.morse@arm.com>
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

Resctrl's architecture code gets to specify a format string that is
used when printing schema entries. This is expected to be one of two
values that the filesystem code supports.

Setting this format string allows the architecture code to change
the ABI resctrl presents to user-space.

Instead, use the schema format enum to choose which format string to
use.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v5:
 * Added runtime check for resource schema_format being junk.

Change since v4:
 * Added a stop to a struct comment.

Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c        |  4 ----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 ++++++++++++++
 include/linux/resctrl.h                   |  4 ++--
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e9fe129a02f8..542503a8c953 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -73,7 +73,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
 			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
-			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -86,7 +85,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_scope		= RESCTRL_L2_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
 			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
-			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -99,7 +97,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
 			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
-			.format_str		= "%d=%*u",
 		},
 	},
 	[RDT_RESOURCE_SMBA] =
@@ -110,7 +107,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
 			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
-			.format_str		= "%d=%*u",
 		},
 	},
 };
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index f4334f437ffc..c763cb4fb1a8 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -487,7 +487,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
 							   schema->conf_type);
 
-		seq_printf(s, r->format_str, dom->hdr.id, max_data_width,
+		seq_printf(s, schema->fmt_str, dom->hdr.id, max_data_width,
 			   ctrl_val);
 		sep = true;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3391ac8ecb2d..e7862d0936c9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2611,6 +2611,20 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 	if (cl > max_name_width)
 		max_name_width = cl;
 
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		s->fmt_str = "%d=%0*x";
+		break;
+	case RESCTRL_SCHEMA_RANGE:
+		s->fmt_str = "%d=%0*u";
+		break;
+	}
+
+	if (WARN_ON_ONCE(!s->fmt_str)) {
+		kfree(s);
+		return -EINVAL;
+	}
+
 	INIT_LIST_HEAD(&s->list);
 	list_add(&s->list, &resctrl_schema_all);
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3e1a41356b2a..736b9a9a9464 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -216,7 +216,6 @@ enum resctrl_schema_fmt {
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
- * @format_str:		Per resource format string to show domain value
  * @schema_fmt:		Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -235,7 +234,6 @@ struct rdt_resource {
 	char			*name;
 	int			data_width;
 	u32			default_ctrl;
-	const char		*format_str;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
 	bool			cdp_capable;
@@ -253,6 +251,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
  *			   user-space
  * @list:	Member of resctrl_schema_all.
  * @name:	The name to use in the "schemata" file.
+ * @fmt_str:	Format string to show domain value.
  * @conf_type:	Whether this schema is specific to code/data.
  * @res:	The resource structure exported by the architecture to describe
  *		the hardware that is configured by this schema.
@@ -263,6 +262,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
 struct resctrl_schema {
 	struct list_head		list;
 	char				name[8];
+	const char			*fmt_str;
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
-- 
2.39.5


