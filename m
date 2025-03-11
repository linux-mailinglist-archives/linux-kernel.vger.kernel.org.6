Return-Path: <linux-kernel+bounces-556733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472EA5CE08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDF6189B71A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB7C2641C5;
	Tue, 11 Mar 2025 18:40:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A127263C85
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741718422; cv=none; b=aBf7jF/NTSXGFU0aB4bn+hUn2hvQ16XEetAVio2jEqzBKGHXv7I3g9Bls5h5NZHNnqtDv28lCsGwcartBY+wXbcIClQG1ho3OUGcbxbcaY5toe8GoFBWKMRRP75yoWICt6RZMBTpss3jsGFYg+qlCkASwKOLg9daHJpIMU0NoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741718422; c=relaxed/simple;
	bh=95fOEJIWIBmqDF5ADw/HT09xx/pu52pC9PmfMtK0xqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/c9C7CiYtt5b7mKAkWzSqYPo7CwwgKlteGIRSCEdNPz03LbBiahBkWouQ+GAH6CIaMM2h+GzJ+vgKsxg4BsEU9Rfvdug49i0z7uINfIJjzcg0pUwb0y+wGhdJniAoV3n+G/PeynjXERNKfDjYcPDZTWdC6wORgwheUYlQGXd1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 700911713;
	Tue, 11 Mar 2025 11:40:30 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC7F93F694;
	Tue, 11 Mar 2025 11:40:15 -0700 (PDT)
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
Subject: [PATCH v8:for-boris 03/30] x86/resctrl: Remove fflags from struct rdt_resource
Date: Tue, 11 Mar 2025 18:36:48 +0000
Message-Id: <20250311183715.16445-4-james.morse@arm.com>
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

The resctrl arch code specifies whether a resource controls a cache or
memory using the fflags field. This field is then used by resctrl to
determine which files should be exposed in the filesystem.

Allowing the architecture to pick this value means the RFTYPE_
flags have to be in a shared header, and allows an architecture
to create a combination that resctrl does not support.

Remove the fflags field, and pick the value based on the resource
id.

Signed-off-by: James Morse <james.morse@arm.com>
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
Changes since v5:
 * Made fflags_from_resource() return an unsigned long.
 * Removed a space.

Changes since v4:
 * Removed an extra space
 * Fixed a typo
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 ----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++--
 include/linux/resctrl.h                |  2 --
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 12b41316d8f7..8ef2e449b465 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -74,7 +74,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
 		},
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -88,7 +87,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
 		},
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
@@ -102,7 +100,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
-			.fflags			= RFTYPE_RES_MB,
 		},
 	},
 	[RDT_RESOURCE_SMBA] =
@@ -114,7 +111,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
 			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
-			.fflags			= RFTYPE_RES_MB,
 		},
 	},
 };
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 45093b9e8e63..3391ac8ecb2d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2165,6 +2165,20 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
 	return ret;
 }
 
+static unsigned long fflags_from_resource(struct rdt_resource *r)
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
@@ -2185,14 +2199,14 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
 	/* loop over enabled controls, these are all alloc_capable */
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		fflags = r->fflags | RFTYPE_CTRL_INFO;
+		fflags = fflags_from_resource(r) | RFTYPE_CTRL_INFO;
 		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
 		if (ret)
 			goto out_destroy;
 	}
 
 	for_each_mon_capable_rdt_resource(r) {
-		fflags = r->fflags | RFTYPE_MON_INFO;
+		fflags = fflags_from_resource(r) | RFTYPE_MON_INFO;
 		sprintf(name, "%s_MON", r->name);
 		ret = rdtgroup_mkdir_info_resdir(r, name, fflags);
 		if (ret)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 37279e2a89da..496ddcaa4ecf 100644
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
2.39.5


