Return-Path: <linux-kernel+bounces-215071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA68F908E13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6753D1F24371
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A865016ABC1;
	Fri, 14 Jun 2024 15:01:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAA316D30D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377287; cv=none; b=CKrpzwgbesRCCJmr8jbHcKOTKbv16bWpMBFksdKXjutjfXYWuWRWzndzzioT+N+b1Y9nwswBT01Mr5Pr3qJ34BFZJPtGtTrkRQ9Jo3Tidrsl4mQy9r8PLbOdtncfENjiWcENBM0oJOIqTEt9Q3e+xYwhagtEKZjWZXFs27krhD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377287; c=relaxed/simple;
	bh=bPdQCQ4xeJZ4G0IuxdRn3sYl14kL8nEeodwfTmYOUy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCMciVEiX8O6Liac2fnUDVTUmp+iWTvkOkFhAdOMIL+YOipv6gT4eDKl+5+cLqnudwGsYa4FSUprov/D7kPF97myA2M+mZIiZmFxgO70/CsNqdBynaNCeTBLFCBZznookIYdq+/aRhDmPsviPt88o3oz5DTqCGITHaio6xU120g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEBA21480;
	Fri, 14 Jun 2024 08:01:49 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43DB33F5A1;
	Fri, 14 Jun 2024 08:01:22 -0700 (PDT)
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
Subject: [PATCH v3 05/38] x86/resctrl: Use schema type to determine the schema format string
Date: Fri, 14 Jun 2024 15:00:00 +0000
Message-Id: <20240614150033.10454-6-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240614150033.10454-1-james.morse@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
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
---
Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/core.c        |  4 ----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 12 ++++++++++++
 include/linux/resctrl.h                   |  4 ++--
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 02a51cce380f..4a5216a13b46 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -71,7 +71,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_L3),
-			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -84,7 +83,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.cache_level		= 2,
 			.domains		= domain_init(RDT_RESOURCE_L2),
-			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -101,7 +99,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.schema_fmt		= RESCTRL_SCHEMA_PERCENTAGE,
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_MBA),
-			.format_str		= "%d=%*u",
 		},
 	},
 	[RDT_RESOURCE_SMBA] =
@@ -112,7 +109,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.schema_fmt		= RESCTRL_SCHEMA_MBPS,
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_SMBA),
-			.format_str		= "%d=%*u",
 		},
 	},
 };
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 30a4ff2b6392..380b88b69c6e 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -483,7 +483,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
 							   schema->conf_type);
 
-		seq_printf(s, r->format_str, dom->id, max_data_width,
+		seq_printf(s, schema->fmt_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b12307d465bc..af9968328771 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2597,6 +2597,18 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 	if (cl > max_name_width)
 		max_name_width = cl;
 
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		s->fmt_str = "%d=%0*x";
+		break;
+	case RESCTRL_SCHEMA_PERCENTAGE:
+		s->fmt_str = "%d=%0*u";
+		break;
+	case RESCTRL_SCHEMA_MBPS:
+		s->fmt_str = "%d=%0*u";
+		break;
+	}
+
 	INIT_LIST_HEAD(&s->list);
 	list_add(&s->list, &resctrl_schema_all);
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 975345f3cd0a..abecbd92ac93 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -184,7 +184,6 @@ enum resctrl_schema_fmt {
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
- * @format_str:		Per resource format string to show domain value
  * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -201,7 +200,6 @@ struct rdt_resource {
 	char			*name;
 	int			data_width;
 	u32			default_ctrl;
-	const char		*format_str;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
 	bool			cdp_capable;
@@ -219,6 +217,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
  *			   user-space
  * @list:	Member of resctrl_schema_all.
  * @name:	The name to use in the "schemata" file.
+ * @fmt_str:	Format string to show domain value
  * @conf_type:	Whether this schema is specific to code/data.
  * @res:	The resource structure exported by the architecture to describe
  *		the hardware that is configured by this schema.
@@ -229,6 +228,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
 struct resctrl_schema {
 	struct list_head		list;
 	char				name[8];
+	const char			*fmt_str;
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
-- 
2.39.2


