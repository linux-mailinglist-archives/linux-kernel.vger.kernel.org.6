Return-Path: <linux-kernel+bounces-215070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C026D908E12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2091A2848FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132716C692;
	Fri, 14 Jun 2024 15:01:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A004916A38B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377284; cv=none; b=oVag9CvOvx9d3iWX7arLWHYkGQuSfq2s4Sfx++5AruP072Ai4QHS5CCXzux1FrYtZfd2QxqCN/UBDTMGuHdwlkKH6u9xLunUyJBIZLGSrvuGbW20pJxpuUGZaiABfQ0odra/IsLiqw8Ic7UHrXjj6KZ8xHUzmN8azSIFHGPvMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377284; c=relaxed/simple;
	bh=/MPyOVlBkzzGQdipxmMsNdOA3t+WXYsCkizTFAOzw28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=giwdlYjdL/y0czkUsE2tebZei3+iHeZ46Chrs/yhDlni1maR33Ja2+w9UHo1miQAbPFtBLuZv+kD8VdmsyCPglVZu9y64EBR0829DK96TBYIrmyim9Sv3jE/CHsHAu0OzNI/s9XL6Oso574PB55CrXJxsxEPfMxMr3tmtLsbVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9907DFEC;
	Fri, 14 Jun 2024 08:01:46 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 070733F5A1;
	Fri, 14 Jun 2024 08:01:18 -0700 (PDT)
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
Subject: [PATCH v3 04/38] x86/resctrl: Use schema type to determine how to parse schema values
Date: Fri, 14 Jun 2024 14:59:59 +0000
Message-Id: <20240614150033.10454-5-james.morse@arm.com>
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

Resctrl's architecture code gets to specify a function pointer that is
used when parsing schema entries. This is expected to be one of two
helpers from the filesystem code.

Setting this function pointer allows the architecture code to change
the ABI resctrl presents to user-space, and forces resctrl to expose
these helpers.

Instead, use the schema format enum to choose which schema parser to
use. This allows the helpers to be made static and the structs used
for passing arguments moved out of shared headers.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * This patch is new
---
 arch/x86/kernel/cpu/resctrl/core.c        |  4 ---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 33 +++++++++++++++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 -------
 include/linux/resctrl.h                   |  5 ----
 4 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index a72fd53e0ffe..02a51cce380f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -71,7 +71,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_L3),
-			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
@@ -85,7 +84,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.schema_fmt		= RESCTRL_SCHEMA_BITMAP,
 			.cache_level		= 2,
 			.domains		= domain_init(RDT_RESOURCE_L2),
-			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
@@ -103,7 +101,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.schema_fmt		= RESCTRL_SCHEMA_PERCENTAGE,
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_MBA),
-			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
 		},
 	},
@@ -115,7 +112,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.schema_fmt		= RESCTRL_SCHEMA_MBPS,
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_SMBA),
-			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
 		},
 	},
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 9f1ed26b9d83..30a4ff2b6392 100644
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
+			       struct rdt_domain *d);
+
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
@@ -59,8 +68,8 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_domain *d)
+static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
+		    struct rdt_domain *d)
 {
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
@@ -138,8 +147,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_domain *d)
+static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
+		     struct rdt_domain *d)
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
+	};
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
 		if (d->id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
-			if (r->parse_ctrlval(&data, s, d))
+			if (parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
 				cfg = &d->staged_config[t];
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e11abefcfd31..7e0b0b5f3530 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -416,11 +416,6 @@ static inline bool is_mbm_event(int e)
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
@@ -457,11 +452,6 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 	return container_of(r, struct rdt_hw_resource, r_resctrl);
 }
 
-int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_domain *d);
-
 extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 4822abbc08c8..975345f3cd0a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -157,7 +157,6 @@ struct resctrl_membw {
 	u32				*mb_map;
 };
 
-struct rdt_parse_data;
 struct resctrl_schema;
 
 /**
@@ -186,7 +185,6 @@ enum resctrl_schema_fmt {
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
- * @parse_ctrlval:	Per resource function pointer to parse control values
  * @schema_fmt:	Which format string and parser is used for this schema.
  * @evt_list:		List of monitoring events
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -204,9 +202,6 @@ struct rdt_resource {
 	int			data_width;
 	u32			default_ctrl;
 	const char		*format_str;
-	int			(*parse_ctrlval)(struct rdt_parse_data *data,
-						 struct resctrl_schema *s,
-						 struct rdt_domain *d);
 	enum resctrl_schema_fmt	schema_fmt;
 	struct list_head	evt_list;
 	bool			cdp_capable;
-- 
2.39.2


