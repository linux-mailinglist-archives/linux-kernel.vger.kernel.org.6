Return-Path: <linux-kernel+bounces-272903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EEC946271
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1510285408
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919415C12E;
	Fri,  2 Aug 2024 17:30:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9062166F07
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619806; cv=none; b=c/nxzIw1IJAXuOIlmHRLv8vcea1jvoS+r2WYIV/laG327Esd9R0I+lpNLEfN4jwwOgA+L3by112juAUAlZuewNiOaIbU7ZvAPcSAx66kwyY7mujqEUKp7xOqlLYvowDVfo2EI7SqJprJGwZwDT194RA6eu6jQzkZxNEO0aEFULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619806; c=relaxed/simple;
	bh=bpJwY5yBPEHkdzoNCG41h+FFxBY2odV4PEz/KFXn8sA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uDfMIZN6d1h/65xDhTasSrzcIyEl0DFNLd8gMYgoppE2uicfK7vpQM3DPRGuIhBIRpEyUEHqAfVx11QmUCENHKBjYLh7gWQg6CtywAhJKW4VWcCgXPpMnWP5Xx7UzbSGDirJfHLuTFiJhNNPMaVHMEMzSmuteaRqJoCV5IMyvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 278C11042;
	Fri,  2 Aug 2024 10:30:30 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815DE3F64C;
	Fri,  2 Aug 2024 10:30:00 -0700 (PDT)
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
Subject: [PATCH v4 04/39] x86/resctrl: Use schema type to determine how to parse schema values
Date: Fri,  2 Aug 2024 17:28:18 +0000
Message-Id: <20240802172853.22529-5-james.morse@arm.com>
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

Resctrl's architecture code gets to specify a function pointer that is
used when parsing schema entries. This is expected to be one of two
helpers from the filesystem code.

Setting this function pointer allows the architecture code to change
the ABI resctrl presents to user-space, and forces resctrl to expose
these helpers.

Instead, add a schema format enum to choose which schema parser to
use. This allows the helpers to be made static and the structs used
for passing arguments moved out of shared headers.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
---
Changes since v4:
 * Creation of the enum moves into this patch - review tags not picked up.
 * Removed some whitespace.

Changes since v3:
 * Removed a spurious semicolon

Changes since v2:
 * This patch is new
---
 arch/x86/kernel/cpu/resctrl/core.c        | 13 ++++++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 33 +++++++++++++++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 -------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  4 +--
 include/linux/resctrl.h                   | 19 +++++++++----
 5 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9ca542a8e2d4..57c88e1c2adf 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -72,7 +72,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.mon_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
-			.parse_ctrlval		= parse_cbm,
+			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
@@ -85,7 +85,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "L2",
 			.ctrl_scope		= RESCTRL_L2_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
-			.parse_ctrlval		= parse_cbm,
+			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
@@ -98,7 +98,11 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "MB",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
-			.parse_ctrlval		= parse_bw,
+			/*
+			 * MBA schema_fmt is modified by
+			 * __rdt_get_mem_config_amd()
+			 */
+			.schema_fmt		= RESCTRL_SCHEMA_PERCENTAGE,
 			.format_str		= "%d=%*u",
 		},
 	},
@@ -109,7 +113,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "SMBA",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
-			.parse_ctrlval		= parse_bw,
+			.schema_fmt		= RESCTRL_SCHEMA_MBPS,
 			.format_str		= "%d=%*u",
 		},
 	},
@@ -251,6 +255,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
 	hw_res->num_closid = edx + 1;
 	r->default_ctrl = 1 << eax;
+	r->schema_fmt = RESCTRL_SCHEMA_MBPS;
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index e078bfe3840d..8d02d563bb60 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -23,6 +23,15 @@
 
 #include "internal.h"
 
+struct rdt_parse_data {
+	struct rdtgroup		*rdtgrp;
+	char			*buf;
+};
+
+typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
+			       struct resctrl_schema *s,
+			       struct rdt_ctrl_domain *d);
+
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
@@ -59,8 +68,8 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_ctrl_domain *d)
+static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
+		    struct rdt_ctrl_domain *d)
 {
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
@@ -138,8 +147,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_ctrl_domain *d)
+static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
+		     struct rdt_ctrl_domain *d)
 {
 	struct rdtgroup *rdtgrp = data->rdtgrp;
 	struct resctrl_staged_config *cfg;
@@ -195,6 +204,19 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	return 0;
 }
 
+static ctrlval_parser_t *get_parser(struct rdt_resource *r)
+{
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		return &parse_cbm;
+	case RESCTRL_SCHEMA_PERCENTAGE:
+	case RESCTRL_SCHEMA_MBPS:
+		return &parse_bw;
+	}
+
+	return NULL;
+}
+
 /*
  * For each domain in this resource we expect to find a series of:
  *	id=mask
@@ -204,6 +226,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	ctrlval_parser_t *parse_ctrlval = get_parser(s->res);
 	enum resctrl_conf_type t = s->conf_type;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
@@ -235,7 +258,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 		if (d->hdr.id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
-			if (r->parse_ctrlval(&data, s, d))
+			if (parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
 				cfg = &d->staged_config[t];
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b5a34a3fa599..ffcade365070 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -457,11 +457,6 @@ static inline bool is_mbm_event(int e)
 		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
-struct rdt_parse_data {
-	struct rdtgroup		*rdtgrp;
-	char			*buf;
-};
-
 /**
  * struct rdt_hw_resource - arch private attributes of a resctrl resource
  * @r_resctrl:		Attributes of the resource used directly by resctrl.
@@ -498,11 +493,6 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 	return container_of(r, struct rdt_hw_resource, r_resctrl);
 }
 
-int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_ctrl_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_ctrl_domain *d);
-
 extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 50d92e5594a3..11153271cbdc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2194,14 +2194,14 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		fflags =  fflags_from_resource(r) | RFTYPE_CTRL_INFO;
+		fflags = fflags_from_resource(r) | RFTYPE_CTRL_INFO;
 		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
 
 	for_each_mon_capable_rdt_resource(r) {
-		fflags =  fflags_from_resource(r) | RFTYPE_MON_INFO;
+		fflags = fflags_from_resource(r) | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
 		if (ret)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 94dcd72509f5..77fec8970d40 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -183,7 +183,6 @@ struct resctrl_membw {
 	u32				*mb_map;
 };
 
-struct rdt_parse_data;
 struct resctrl_schema;
 
 enum resctrl_scope {
@@ -192,6 +191,18 @@ enum resctrl_scope {
 	RESCTRL_L3_NODE,
 };
 
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
@@ -208,7 +219,7 @@ enum resctrl_scope {
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
- * @parse_ctrlval:	Per resource function pointer to parse control values
+ * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
  */
@@ -227,9 +238,7 @@ struct rdt_resource {
 	int			data_width;
 	u32			default_ctrl;
 	const char		*format_str;
-	int			(*parse_ctrlval)(struct rdt_parse_data *data,
-						 struct resctrl_schema *s,
-						 struct rdt_ctrl_domain *d);
+	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
 	bool			cdp_capable;
 };
-- 
2.39.2


