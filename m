Return-Path: <linux-kernel+bounces-272902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A0946270
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB497B222E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83541166F1A;
	Fri,  2 Aug 2024 17:30:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA05166F07
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619802; cv=none; b=i29HTp+xEzRah8oeE3XEHxmCqzdWXsVCJpkSqEwz+0/Ch8AQoTxEgmzacuKFe53PZIADvX7AFxMQW/k+WyPvOF46fHkKqlPaMLTA1EZFPO7pwc6DzTWKX/+S3R64xbMt+IEC/swsxxCwAI11YnE5wYoNtMRm8hCkGFA3nzJC6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619802; c=relaxed/simple;
	bh=McdM6gql5QmUFevSdUxVMdht28xrml1k69E9oGYg6rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gs7giebJBq8DPqBRp9hO1DWlmMIfv5CPFJQ2smpvMmnsWaGSrbzFyLh62hmYeWvwqYDk+MlD8mil6N4LQstOCe/F+Ms+2+Gqp00xb0kbVkYwvVVRHdrQRiD9k+GDcKLqgLOsnSqPgcSrQg7RiHes3rBsTRS441QU8odnW2mx9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7AB11007;
	Fri,  2 Aug 2024 10:30:25 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 330403F64C;
	Fri,  2 Aug 2024 10:29:56 -0700 (PDT)
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
Subject: [PATCH v4 03/39] x86/resctrl: Remove fflags from struct rdt_resource
Date: Fri,  2 Aug 2024 17:28:17 +0000
Message-Id: <20240802172853.22529-4-james.morse@arm.com>
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

The resctrl arch code specifies whether a resource controls a cache or
memory using the fflags field. This field is then used by resctrl to
determine which files should be exopsed in the filesystem.

Allowing the architecture to pick this value means the RFTYPE_
flags have to be in a shared header, and allows an architecture
to create a combination that resctrl does not support.

Remove the fflags field, and pick the value based on the resource
id.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 ----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++--
 include/linux/resctrl.h                |  2 --
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d7ae77a8f6f4..9ca542a8e2d4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -74,7 +74,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -88,7 +87,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -102,7 +100,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
-			.fflags			= RFTYPE_RES_MB,
 		},
 	},
 	[RDT_RESOURCE_SMBA] =
@@ -114,7 +111,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
-			.fflags			= RFTYPE_RES_MB,
 		},
 	},
 };
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6225d0b7e9ee..50d92e5594a3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2160,6 +2160,20 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 	return ret;
 }
 
+static u32 fflags_from_resource(struct rdt_resource *r)
+{
+	switch (r->rid) {
+	case RDT_RESOURCE_L3:
+	case RDT_RESOURCE_L2:
+		return RFTYPE_RES_CACHE;
+	case RDT_RESOURCE_MBA:
+	case RDT_RESOURCE_SMBA:
+		return RFTYPE_RES_MB;
+	}
+
+	return WARN_ON_ONCE(1);
+}
+
 static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 {
 	struct resctrl_schema *s;
@@ -2180,14 +2194,14 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
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
index 7563628464e5..94dcd72509f5 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -210,7 +210,6 @@ enum resctrl_scope {
  * @format_str:		Per resource format string to show domain value
  * @parse_ctrlval:	Per resource function pointer to parse control values
  * @evt_list:		List of monitoring events
- * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
@@ -232,7 +231,6 @@ struct rdt_resource {
 						 struct resctrl_schema *s,
 						 struct rdt_ctrl_domain *d);
 	struct list_head	evt_list;
-	unsigned long		fflags;
 	bool			cdp_capable;
 };
 
-- 
2.39.2


