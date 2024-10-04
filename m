Return-Path: <linux-kernel+bounces-350862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238FE990A93
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48F9285832
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB291DAC8B;
	Fri,  4 Oct 2024 18:05:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105AA1DD87A
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065106; cv=none; b=LszLC2GbjvQeG7sTpy/y+M87xWSu4SzUGnUA0mELQOSlbPfu+FvDNVHdBUkpBFNepJ9cjydv/hbqrU2Twj/jWRz9wpcWWBKL4ChJlqNuU6lSfXJ8aknGLcERBFu3F1Rpj4z5NBSh6jAjuGwcp1GapTf6f+5xHssyZXwCpCKNi0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065106; c=relaxed/simple;
	bh=Ims7pGpqpMW0CunJETf/eX5zvEyrPnGW4P+sY1x/vlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnZzs5ZABtHUnOYr0uXwJfZL5JUo9e7RgbyoVU9JjodH+b4q3avN85kqmOY4HAqzqDAfFJr28qnQkP25SQWCRsJ9XlVyuqjqw1svwN05W5DY2TCHLQshxqpQKfDpWAqMzasMkw8giYb4BNby1/SnCut9n4LxWFpN7phQAY0fQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2C6B339;
	Fri,  4 Oct 2024 11:05:33 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F8A53F58B;
	Fri,  4 Oct 2024 11:05:01 -0700 (PDT)
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
Subject: [PATCH v5 04/40] x86/resctrl: Use schema type to determine how to parse schema values
Date: Fri,  4 Oct 2024 18:03:11 +0000
Message-Id: <20241004180347.19985-5-james.morse@arm.com>
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
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
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
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 include/linux/resctrl.h                   | 18 +++++++++----
 5 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index a508433ff354..0a05df02d2ed 100644
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
@@ -98,7 +98,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "MB",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
-			.parse_ctrlval		= parse_bw,
+			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
 			.format_str		= "%d=%*u",
 		},
 	},
@@ -109,7 +109,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "SMBA",
 			.ctrl_scope		= RESCTRL_L3_CACHE,
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
-			.parse_ctrlval		= parse_bw,
+			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
 			.format_str		= "%d=%*u",
 		},
 	},
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index e078bfe3840d..a042e234f4f8 100644
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
@@ -195,6 +204,18 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	return 0;
 }
 
+static ctrlval_parser_t *get_parser(struct rdt_resource *r)
+{
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		return &parse_cbm;
+	case RESCTRL_SCHEMA_RANGE:
+		return &parse_bw;
+	}
+
+	return NULL;
+}
+
 /*
  * For each domain in this resource we expect to find a series of:
  *	id=mask
@@ -204,6 +225,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	ctrlval_parser_t *parse_ctrlval = get_parser(s->res);
 	enum resctrl_conf_type t = s->conf_type;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
@@ -235,7 +257,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
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
index 2abe17574407..11153271cbdc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2201,7 +2201,7 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	}
 
 	for_each_mon_capable_rdt_resource(r) {
-		fflags =  fflags_from_resource(r) | RFTYPE_MON_INFO;
+		fflags = fflags_from_resource(r) | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
 		if (ret)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 496ddcaa4ecf..54ec87339038 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -183,7 +183,6 @@ struct resctrl_membw {
 	u32				*mb_map;
 };
 
-struct rdt_parse_data;
 struct resctrl_schema;
 
 enum resctrl_scope {
@@ -192,6 +191,17 @@ enum resctrl_scope {
 	RESCTRL_L3_NODE,
 };
 
+/**
+ * enum resctrl_schema_fmt - The format user-space provides for a schema.
+ * @RESCTRL_SCHEMA_BITMAP:	The schema is a bitmap in hex.
+ * @RESCTRL_SCHEMA_RANGE:	The schema is a number, either a percentage
+ *				or a MBps value.
+ */
+enum resctrl_schema_fmt {
+	RESCTRL_SCHEMA_BITMAP,
+	RESCTRL_SCHEMA_RANGE,
+};
+
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
@@ -208,7 +218,7 @@ enum resctrl_scope {
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
- * @parse_ctrlval:	Per resource function pointer to parse control values
+ * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
  */
@@ -227,9 +237,7 @@ struct rdt_resource {
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


