Return-Path: <linux-kernel+bounces-240262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AFF926AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DED1F22771
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D54819AD72;
	Wed,  3 Jul 2024 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L/RL3tCW"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0CE19AD5D;
	Wed,  3 Jul 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043432; cv=fail; b=pwhwQZuKXQzAw2jbqOFrrI0lyasDgcwaJ4tdt0nP5sQILI10XBYiFiaGPGr0D1xNIofaH7wZxiTW8rKDloPnfYAUPOxY3dF7akmzLdM2f8Lbpo2h2YnSwixgtdURfUr/lN+nleWQ1v3s+IsFypl8tFww4X9oo19Mduo6aWHb2fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043432; c=relaxed/simple;
	bh=x0TMpQeQ6gW9b93zYowgFIvoINIwGqveSKHctIZPyC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvX1/HW7/jv02d1/mtI9Q0kgLmjq5MIBN5CYFUz0h1rdprdihGdsvXfYLEPOXGO13lqtOJTKLCYhH+60hcJHlVjlo3hnQPzdoYHtUkIbB5r2LnIvXZoRcVFDhrym594vINAHcC7jT93X1Em9jN9Ngby7tJ2ZednSukFTqBxZw7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L/RL3tCW; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMey0ZwxxAKdRrXbC6dzWCRKEazOvB6RHoT90wL46qW6QtQpkhXzQkzUTnOfL79c06Vi3gyRvUZgYT/9qyQJ3ZD5cQ7wSFSy1FVsVgV6XZpgJtusqT6I0kuIbaUCtLRumbbgi6R9prE4a128TGZ7JwNhHOCbr0C+UHa2FFjOXSwS/cvZNmbse1w1bOQzjyBO2GOLBITdN9lqiuInHxENY0IM8ucnDwKbG2+q7JhdsvNoNF2QPMIVXMSCg2bgGJWOnolq34aS7EFhH0TMXq/AdvfDpABGKqnARBxDSExXzF99KSP6Y/cXyJy/+UZL3ZuQJ4Ol7DUbpJU3OWLm9Clhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpgKAXoGLl21U2Pjr5zmefcE0wRxZcjLJNTSQhUKp70=;
 b=OxIT4vmZ4+fFLEmJRr5g7uKkItsbuljtx6tL3AgTMyO+7Aaj139WZN1BHgyJy4ULqTEEdWKXxNlzbGA9CnUWX1BpQ1jEh65rZzlSsWX1qftZygftPlo16wt/Fen3kAblDlCmS+MlOVQgq+4Qf8o8o4TkajC8FLRKmOWhxU01xqLvYriBUgJOZMTQxM/HzJmJUlMP7kcCEyWfgAkdApWS4nn48JrBXHNQ5eJtzJGbMDY4zTfhqZJs3/vsVKd2Mubbx1iyQbds5qUW57l9FccX3sDndqxChsfvJE8wppIKhzj2RtecTFViODICgjvucElNh2adapJmJMFkezCYeqgytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpgKAXoGLl21U2Pjr5zmefcE0wRxZcjLJNTSQhUKp70=;
 b=L/RL3tCWWSGo86VLRNlWxinRz79em+VG2qBKYRwiIN8m77NlTtokBqFcpitwUx4mF7vyAMpJO4sRCSxKyKd3RlPmv7rhDulJQow0zpTplQZ4/2Y0Jo1JsK6+rAiHs4H4zx8HPmi38SQulMsd0ejQp+krBN+JYZwGH1j7hVg4P2I=
Received: from DM6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:5:1b3::26)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 21:50:27 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::87) by DM6PR17CA0013.outlook.office365.com
 (2603:10b6:5:1b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26 via Frontend
 Transport; Wed, 3 Jul 2024 21:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:50:27 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:50:25 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [PATCH v5 13/20] x86/resctrl: Add the interface to assign hardware counter
Date: Wed, 3 Jul 2024 16:48:24 -0500
Message-ID: <add3032b43cd06b538f57249fe0b80a9b5e5fda5.1720043311.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720043311.git.babu.moger@amd.com>
References: <cover.1720043311.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: e155e612-6d91-4e56-d1d5-08dc9baa26b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m72LVBgPl8mB4h7eYstPETzjX80H36LVnyMlLYGAIfZtGDabISqEXaaEzNMG?=
 =?us-ascii?Q?bmVHNBsZNlVRKcfl36GaUe02g1w6P2V6fBaAgHqmEwuxuOQrLtlzHr/kYFLs?=
 =?us-ascii?Q?kGJJz5RBu3YYJAdF0sfatIyHPvtzQBr102BantFEWPyjAfeHjuQAUcKI18rb?=
 =?us-ascii?Q?gprX04ePOyx+ZX63kssBIkVfetxaR2gTsrw74paEUXblsNPVr6mhjSmW6zCS?=
 =?us-ascii?Q?QFY8jB5SKvgTSy9bbiMaGuEr1jklXMSWRzWFK4hA6fSY8XSnFFV+IP4+Ltdt?=
 =?us-ascii?Q?tUQxSp83tZtpyZRw2Nj8HsNOpvGhavkbEvwPKKYCYaD5EEkn8T8YFe1tAohF?=
 =?us-ascii?Q?XHKO0AkRi+aEPdgXmdRd4oYuNZGcwqKBlZE7LR2ZBiOM4ImlXl6ux9nTxzEC?=
 =?us-ascii?Q?uSERt6xqop8vVbKWPzmHdBkrrV5aAZveZbWKav6fGVSNcI9VHFBCQ+FKap01?=
 =?us-ascii?Q?8ccnpHTVps/2qrgOULzxPpt4Tk1CNzfRM2IHj3kFJU/VblGcNEG55LmGyaqk?=
 =?us-ascii?Q?PsE+QyH6RIfJGolZWLAjzDRpJD7hWVBkqJZxP9Iu5RN5kqWBeedL6m/XSv2Z?=
 =?us-ascii?Q?7Io17/arJGVzQ0grBN/QPnDIIBC38W+2nIBtlRB8e5aY/mtcQrmC4SeVEBFL?=
 =?us-ascii?Q?haOTxOYub3uS3oL5JxIc3hKNEXWA7x2XuB+cqwGI4+mG2+o6C6iKVJ8GCVUW?=
 =?us-ascii?Q?bkaJC7UYNiTI+lIBNJZNVaJhLNNXPwcJsZAz1pQ7R9CKS1nSz5XLh+luRkNv?=
 =?us-ascii?Q?rLdP5wPqM675AlCOeFgLGz1r8AOmlJLyjjUcrgZtxAJAsYCO3rZ/N3GCPhVc?=
 =?us-ascii?Q?VIomVq5dFM57tF9zUCFriPiXFcJAxCf0S7GF7cZgJb8aoXWAyhNaq3LeXMz0?=
 =?us-ascii?Q?7YuTQ5UA5N70HswAt8VMkRj+AFSLeS116CJvtWtY3ZkoorV83eLd1XA5Kmtw?=
 =?us-ascii?Q?GvQt40Pu0RpQN4QO1Or/ug62W+mjmhIrFOlJ6LQ2/D9BgLQFcHCX5M67umfw?=
 =?us-ascii?Q?4gWY+qiCrhpTj65t7wHRtttVlvbu+XZWGjPuGyNsiJoJUm5/SSyNgE5gOOXy?=
 =?us-ascii?Q?sfvegfdbxPjW8clbZSmFd8+lTYvUHq/nIR6ibcxzwVZpICN96693vCL+5TZc?=
 =?us-ascii?Q?rsWvajc52HQDfg1O0KmMVnFttzUBhRQvtekXs0DY2DseFz3VVLJUFCRxLRbX?=
 =?us-ascii?Q?p+VQWhILkC17xF9bN7sk0gMZua70fi3gX8rnGr9Z+z7KXJ69CsnXfu7DoJl2?=
 =?us-ascii?Q?KK2LQr2YiKkJgDlTyc93PipNGzxunYNVYAhQuExtqj4lSKSyVPFtLcdJWod+?=
 =?us-ascii?Q?OtM9CJ8dJCR85SheiMIDdqomKWTh6yhmRZ9P/rLVAa95Wdo1gJnKdkb5o9f+?=
 =?us-ascii?Q?sYxFkVuz7KdPmV1MXQOa7tkuS9u8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:50:27.4778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e155e612-6d91-4e56-d1d5-08dc9baa26b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as it is assigned.
The assigned RMID will be tracked by the hardware until the user unassigns
it manually.

Individual counters are configured by writing to L3_QOS_ABMC_CFG MSR
and specifying the counter id, bandwidth source, and bandwidth types.

Provide the interface to assign the counter ids to RMID.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v5: Few name changes to match cntr_id.
    Changed the function names to
    rdtgroup_assign_cntr
    resctr_arch_assign_cntr
    More comments on commit log.
    Added function summary.

v4: Commit message update.
    User bitmap APIs where applicable.
    Changed the interfaces considering MPAM(arm).
    Added domain specific assignment.

v3: Removed the static from the prototype of rdtgroup_assign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: Minor text changes in commit message.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 96 ++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6925c947682d..66460375056c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -708,6 +708,9 @@ void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
 void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
 unsigned int mon_event_config_index_get(u32 evtid);
+int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, u32 rmid,
+			     u32 cntr_id, u32 closid, bool enable);
+int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, u32 evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d2663f1345b7..44f6eff42c30 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -202,6 +202,19 @@ static void mbm_cntrs_init(void)
 	mbm_cntrs_free_map_len = r->mon.num_mbm_cntrs;
 }
 
+static int mbm_cntr_alloc(void)
+{
+	u32 cntr_id = find_first_bit(&mbm_cntrs_free_map,
+				     mbm_cntrs_free_map_len);
+
+	if (cntr_id >= mbm_cntrs_free_map_len)
+		return -ENOSPC;
+
+	__clear_bit(cntr_id, &mbm_cntrs_free_map);
+
+	return cntr_id;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1860,6 +1873,89 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static void rdtgroup_abmc_cfg(void *info)
+{
+	u64 *msrval = info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
+}
+
+/*
+ * Send an IPI to the domain to assign the counter id to RMID.
+ */
+int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, u32 rmid,
+			     u32 cntr_id, u32 closid, bool enable)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+	struct arch_mbm_state *arch_mbm;
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.cntr_en = enable ? 1 : 0;
+	abmc_cfg.split.cntr_id = cntr_id;
+	abmc_cfg.split.bw_src = rmid;
+
+	/* Update the event configuration from the domain */
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
+		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
+		arch_mbm = &hw_dom->arch_mbm_total[rmid];
+	} else {
+		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
+		arch_mbm = &hw_dom->arch_mbm_local[rmid];
+	}
+
+	smp_call_function_any(&d->hdr.cpu_mask, rdtgroup_abmc_cfg, &abmc_cfg, 1);
+
+	/*
+	 * Reset the architectural state so that reading of hardware
+	 * counter is not considered as an overflow in next update.
+	 */
+	if (arch_mbm)
+		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
+
+	return 0;
+}
+
+/*
+ * Assign a hardware counter id to the group. Allocate a new counter id
+ * if the event is unassigned.
+ */
+int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, u32 evtid)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int cntr_id = 0, index;
+	struct rdt_mon_domain *d;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		rdt_last_cmd_puts("Invalid event id\n");
+		return -EINVAL;
+	}
+
+	/* Nothing to do if event has been assigned already */
+	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET) {
+		rdt_last_cmd_puts("ABMC counter is assigned already\n");
+		return 0;
+	}
+
+	/*
+	 * Allocate a new counter id and update domains
+	 */
+	cntr_id = mbm_cntr_alloc();
+	if (cntr_id < 0) {
+		rdt_last_cmd_puts("Out of ABMC counters\n");
+		return -ENOSPC;
+	}
+
+	rdtgrp->mon.cntr_id[index] = cntr_id;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list)
+		resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
+					 cntr_id, rdtgrp->closid, 1);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


