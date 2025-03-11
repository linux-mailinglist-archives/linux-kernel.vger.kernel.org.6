Return-Path: <linux-kernel+bounces-556734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A37A5CE09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84523B7AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56581263F31;
	Tue, 11 Mar 2025 18:40:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FAE2641D7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718425; cv=none; b=MJX9WHXdlZJkSuoVY13xvfu0HDf8SDGS2vOgeEj5DopqcfBxVFZTo/M7SnpsiX4HdVq+Jrrz2xsvPfslE0jkLorRoARZhEnBWLj9yGqQZ5XLjggUTkZYO0NPjGy1b4AtN53Dxerw9fd3TRt4nLKYA8OFxrSv2PdTiQlZGgSpDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718425; c=relaxed/simple;
	bh=pRCHB3f9zYWqSQ+idg4nbQqRc+LxR2Z7gVQLeEjuFUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRrFm/hGu5mXXfkMyfrWddTQovb6W8L1NmTHxuLMz397PNg+N9iVO21CAdbkqmexYHlAB8ifwYRvue5B3LsbaDga7yNzrJVv/akwQZIqBYo72gu/jLWr46n5kBM8K7l7SVaihFLCTJrVvCagGzJaYyUWKeZsDwbBI/D+AD5irYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C58C1515;
	Tue, 11 Mar 2025 11:40:34 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A75B43F694;
	Tue, 11 Mar 2025 11:40:19 -0700 (PDT)
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
Subject: [PATCH v8:for-boris 04/30] x86/resctrl: Use schema type to determine how to parse schema values
Date: Tue, 11 Mar 2025 18:36:49 +0000
Message-Id: <20250311183715.16445-5-james.morse@arm.com>
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
Change since v6:
 * Added a full stop.

Changes since v5:
 * Merged the contents of get_parser() with its only caller.
 * Removed the description of what the range schema is used for.
 * Waggled some whitespace.

Changes since v4:
 * Creation of the enum moves into this patch - review tags not picked up.
 * Removed some whitespace.

Changes since v3:
 * Removed a spurious semicolon

Changes since v2:
 * This patch is new
---
 arch/x86/kernel/cpu/resctrl/core.c        |  8 +++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 32 +++++++++++++++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 -------
 include/linux/resctrl.h                   | 17 ++++++++----
 4 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8ef2e449b465..e9fe129a02f8 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -72,7 +72,7 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.mon_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
-			.parse_ctrlval		= parse_cbm,
+			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
@@ -85,7 +85,7 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.name			= "L2",
 			.ctrl_scope		= RESCTRL_L2_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
-			.parse_ctrlval		= parse_cbm,
+			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
@@ -98,7 +98,7 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.name			= "MB",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
-			.parse_ctrlval		= parse_bw,
+			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
 			.format_str		= "%d=%*u",
 		},
 	},
@@ -109,7 +109,7 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.name			= "SMBA",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
-			.parse_ctrlval		= parse_bw,
+			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
 			.format_str		= "%d=%*u",
 		},
 	},
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 4af27ef5a8a1..f4334f437ffc 100644
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
@@ -64,8 +73,8 @@ static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_ctrl_domain *d)
+static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
+		    struct rdt_ctrl_domain *d)
 {
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
@@ -143,8 +152,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
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
@@ -210,6 +219,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
 	enum resctrl_conf_type t = s->conf_type;
+	ctrlval_parser_t *parse_ctrlval = NULL;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
@@ -220,6 +230,18 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		parse_ctrlval = &parse_cbm;
+		break;
+	case RESCTRL_SCHEMA_RANGE:
+		parse_ctrlval = &parse_bw;
+		break;
+	}
+
+	if (WARN_ON_ONCE(!parse_ctrlval))
+		return -EINVAL;
+
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
 	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
 		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
@@ -240,7 +262,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 		if (d->hdr.id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
-			if (r->parse_ctrlval(&data, s, d))
+			if (parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
 				cfg = &d->staged_config[t];
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 75252a7e1ebc..b5543bd506c3 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -459,11 +459,6 @@ static inline bool is_mbm_event(int e)
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
@@ -500,11 +495,6 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 	return container_of(r, struct rdt_hw_resource, r_resctrl);
 }
 
-int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_ctrl_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_ctrl_domain *d);
-
 extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 496ddcaa4ecf..3e1a41356b2a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -183,7 +183,6 @@ struct resctrl_membw {
 	u32				*mb_map;
 };
 
-struct rdt_parse_data;
 struct resctrl_schema;
 
 enum resctrl_scope {
@@ -192,6 +191,16 @@ enum resctrl_scope {
 	RESCTRL_L3_NODE,
 };
 
+/**
+ * enum resctrl_schema_fmt - The format user-space provides for a schema.
+ * @RESCTRL_SCHEMA_BITMAP:	The schema is a bitmap in hex.
+ * @RESCTRL_SCHEMA_RANGE:	The schema is a decimal number.
+ */
+enum resctrl_schema_fmt {
+	RESCTRL_SCHEMA_BITMAP,
+	RESCTRL_SCHEMA_RANGE,
+};
+
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
@@ -208,7 +217,7 @@ enum resctrl_scope {
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
- * @parse_ctrlval:	Per resource function pointer to parse control values
+ * @schema_fmt:		Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
  */
@@ -227,9 +236,7 @@ struct rdt_resource {
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
2.39.5


