Return-Path: <linux-kernel+bounces-272904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD844946272
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F7B2857FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D0166F3D;
	Fri,  2 Aug 2024 17:30:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1915ADAF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619810; cv=none; b=MDFAK/4RnlV92tbDYVQ+2LS6BLs/xsbRvlkypfWsVTTt6CksKdsWE3jbB7CQz0CJAm3B33ov71QUYxof6ZKfdb3zR9YbPAik0CPn6sh7u8XlnrQC7oAuQy/k1nGQ+QW6HQD0Y7xprDbHskAhM7LhejdcBZ6IqfQB0ajoAQKAY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619810; c=relaxed/simple;
	bh=MJdBTprTuD4b8GYNQ0KLHotI6gs8actsnvm10g1tlRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5kJS5FNnvH0FJxHQYG3bcSDuo9VPFHt3kVNuQUrpTRTYaudlF2eJhks8xCFZlXh2LMyp7DxyF6+FtDnmKKgNZcbAsWfTvYuwGkh6U/Wf0ENcaV1PgMPOCQevHsM7pfsb/gYh/AqQqXDFp/16DcvRb+uXQFT/9Y/n8Maf5u0YWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BBAE1007;
	Fri,  2 Aug 2024 10:30:33 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B59ED3F64C;
	Fri,  2 Aug 2024 10:30:04 -0700 (PDT)
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
Subject: [PATCH v4 05/39] x86/resctrl: Use schema type to determine the schema format string
Date: Fri,  2 Aug 2024 17:28:19 +0000
Message-Id: <20240802172853.22529-6-james.morse@arm.com>
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

Resctrl's architecture code gets to specify a format string that is
used when printing schema entries. This is expected to be one of two
values that the filesystem code supports.

Setting this format string allows the architecture code to change
the ABI resctrl presents to user-space.

Instead, use the schema format enum to choose which format string to
use.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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
index 57c88e1c2adf..f16014ee48aa 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -73,7 +73,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
 			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
-			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -86,7 +85,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.ctrl_scope		= RESCTRL_L2_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
 			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
-			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -103,7 +101,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			 * __rdt_get_mem_config_amd()
 			 */
 			.schema_fmt		= RESCTRL_SCHEMA_PERCENTAGE,
-			.format_str		= "%d=%*u",
 		},
 	},
 	[RDT_RESOURCE_SMBA] =
@@ -114,7 +111,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
 			.schema_fmt		= RESCTRL_SCHEMA_MBPS,
-			.format_str		= "%d=%*u",
 		},
 	},
 };
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 8d02d563bb60..1d9ad4d82bf0 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -483,7 +483,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 			ctrl_val = resctrl_arch_get_config(r, dom, closid,
 							   schema->conf_type);
 
-		seq_printf(s, r->format_str, dom->hdr.id, max_data_width,
+		seq_printf(s, schema->fmt_str, dom->hdr.id, max_data_width,
 			   ctrl_val);
 		sep = true;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 11153271cbdc..1ce851447923 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2600,6 +2600,18 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
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
index 77fec8970d40..1624d4b15b52 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -218,7 +218,6 @@ enum resctrl_schema_fmt {
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
- * @format_str:		Per resource format string to show domain value
  * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -237,7 +236,6 @@ struct rdt_resource {
 	char			*name;
 	int			data_width;
 	u32			default_ctrl;
-	const char		*format_str;
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
 	bool			cdp_capable;
@@ -255,6 +253,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
  *			   user-space
  * @list:	Member of resctrl_schema_all.
  * @name:	The name to use in the "schemata" file.
+ * @fmt_str:	Format string to show domain value
  * @conf_type:	Whether this schema is specific to code/data.
  * @res:	The resource structure exported by the architecture to describe
  *		the hardware that is configured by this schema.
@@ -265,6 +264,7 @@ struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l);
 struct resctrl_schema {
 	struct list_head		list;
 	char				name[8];
+	const char			*fmt_str;
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 	u32				num_closid;
-- 
2.39.2


