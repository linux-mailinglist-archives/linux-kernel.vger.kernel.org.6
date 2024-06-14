Return-Path: <linux-kernel+bounces-215069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355B4908E11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B2E28D2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD94D16B75E;
	Fri, 14 Jun 2024 15:01:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7619E16B729
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377281; cv=none; b=hOMP0pWf3HIJAkWXz4ipetGU4AnkXyHsO2J9q/tctELDQeqCnGX/BWbZsO70p0oZ3UN4lGJwQAX7HSfI2oCDbNUZfiqwNbbdOy+2cqJG0OHdXxWeQhQcGtW0Sx1V6WegeUrlP3LteznwQUiyLugNmKZctu1lZxoSQiO1KYW6xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377281; c=relaxed/simple;
	bh=XkAWqaMQFM7oKjniweZwaDpdmMw63c4yFjkWtsJligA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+OKxeroBYRoZHxp0u2xOYPBaIaF6PnSvVoZrSN+VzMcCCIsmJZ5WGHMgrvof1vk1LqJmi/DwzGjoXHsqzxZhwhhEc29wQJLgXyMAdrByEB3etHdHFwPUeUnDiVlBTAdYYvPiYH0Dx4SpuoBX8NG+cZAt5tjpKU7gTeHD2tKOqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74D8C1596;
	Fri, 14 Jun 2024 08:01:43 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C56BE3F5A1;
	Fri, 14 Jun 2024 08:01:15 -0700 (PDT)
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
Subject: [PATCH v3 03/38] x86/resctrl: Add a schema format enum and use this for fflags
Date: Fri, 14 Jun 2024 14:59:58 +0000
Message-Id: <20240614150033.10454-4-james.morse@arm.com>
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

resctrl has three types of control, these emerge from the way the
architecture initialises a number of properties in struct rdt_resource.

A group of these properties need to be set the same on all architectures,
it would be better to specify the format the schema entry should use, and
allow resctrl to generate all the other properties it needs. This avoids
architectures having divergant behaviour here.

Add a schema format enum, and as a first use, replace the fflags member
of struct rdt_resource.

The MBA schema has a different format between AMD and Intel systems.
The schema_fmt property is changed by __rdt_get_mem_config_amd() to
enable the MBPS format.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * This patch is new
---
 arch/x86/kernel/cpu/resctrl/core.c     | 13 +++++++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++--
 include/linux/resctrl.h                | 16 ++++++++++++++--
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d04e157dd7f7..a72fd53e0ffe 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -68,11 +68,11 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
+			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -82,11 +82,11 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
+			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.cache_level		= 2,
 			.domains		= domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -96,11 +96,15 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
+			/*
+			 * MBA schema_fmt is modified by
+			 * __rdt_get_mem_config_amd()
+			 */
+			.schema_fmt		= RESCTRL_SCHEMA_PERCENTAGE,
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_MBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
-			.fflags			= RFTYPE_RES_MB,
 		},
 	},
 	[RDT_RESOURCE_SMBA] =
@@ -108,11 +112,11 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_SMBA,
 			.name			= "SMBA",
+			.schema_fmt		= RESCTRL_SCHEMA_MBPS,
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_SMBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
-			.fflags			= RFTYPE_RES_MB,
 		},
 	},
 };
@@ -253,6 +257,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
 	hw_res->num_closid = edx + 1;
 	r->default_ctrl = 1 << eax;
+	r->schema_fmt = RESCTRL_SCHEMA_MBPS;
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e3edc41882dc..b12307d465bc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2162,6 +2162,19 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 	return ret;
 }
 
+static u32 fflags_from_resource(struct rdt_resource *r)
+{
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		return RFTYPE_RES_CACHE;
+	case RESCTRL_SCHEMA_PERCENTAGE:
+	case RESCTRL_SCHEMA_MBPS:
+		return RFTYPE_RES_MB;
+	}
+
+	return WARN_ON_ONCE(1);
+}
+
 static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 {
 	struct resctrl_schema *s;
@@ -2182,14 +2195,14 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		fflags = r->fflags | RFTYPE_CTRL_INFO;
+		fflags =  fflags_from_resource(r) | RFTYPE_CTRL_INFO;
 		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
 
 	for_each_mon_capable_rdt_resource(r) {
-		fflags = r->fflags | RFTYPE_MON_INFO;
+		fflags =  fflags_from_resource(r) | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
 		if (ret)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 168cc9510069..4822abbc08c8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -160,6 +160,18 @@ struct resctrl_membw {
 struct rdt_parse_data;
 struct resctrl_schema;
 
+/**
+ * enum resctrl_schema_fmt - The format user-space provides for a schema.
+ * @RESCTRL_SCHEMA_BITMAP:	The schema is a bitmap in hex.
+ * @RESCTRL_SCHEMA_PERCENTAGE:	The schema is a decimal percentage value.
+ * @RESCTRL_SCHEMA_MBPS:	The schema is a decimal MBps value.
+ */
+enum resctrl_schema_fmt {
+	RESCTRL_SCHEMA_BITMAP,
+	RESCTRL_SCHEMA_PERCENTAGE,
+	RESCTRL_SCHEMA_MBPS,
+};
+
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
@@ -175,8 +187,8 @@ struct resctrl_schema;
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
+ * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
- * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
@@ -195,8 +207,8 @@ struct rdt_resource {
 	int			(*parse_ctrlval)(struct rdt_parse_data *data,
 						 struct resctrl_schema *s,
 						 struct rdt_domain *d);
+	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
-	unsigned long		fflags;
 	bool			cdp_capable;
 };
 
-- 
2.39.2


