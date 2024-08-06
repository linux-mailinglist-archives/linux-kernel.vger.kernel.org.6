Return-Path: <linux-kernel+bounces-276998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A1949ADD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48B3B25FE8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64375176ADC;
	Tue,  6 Aug 2024 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y6W6SeSN"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084317AE13;
	Tue,  6 Aug 2024 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981786; cv=fail; b=it4wCvCzrpd/mwlVkTfo5fuEB83WbXBw095Vrgrp1X6KoxXm/E+Fe2y5iO43WJRfzUOqg8ksDsjNRq/9QejOxOMhENq/ZBbT1XmHfWdXm5eovhAjemyFD/ORftHBlRUv0qyvT5Rkb4482nxP26ZzeLsfoSIZxywqXpIAryuTerc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981786; c=relaxed/simple;
	bh=nyjvgsSOndT1Z3YxcJ0SxAxeytqPAiplGOFIg1v7Cs0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hoh5HFRm/ATSf5CMWQIS68G/84nT0Lt6wqwk0bi0x4UNnQhUs/jLMpDmIZGVtrrwlTiwJmZWEKpGfrm2kNJpIB/wQ6fOMErc4KiqZZTp1lS53ImF5A3m8WIcSbnI915IpmT8Am71iedDJORA77qUf4qLI6JWmrk8Fhn0fasv6PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y6W6SeSN; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDqj/P2Tw1bd4T33rhLnPLYiyOAlj85BIQKf4n2PFsc7FUL0vx/pX0SAJUnMSN597I4tqrGE7Xy23Gv61qs/lws8IIBzbKbhU+i7UHxzvLygu6sTZwvw6WDTcc9U+mTQ+/5HIBWZwtrCecY9+2H8ACefgOXZiBA5tzOz6OJZW1j7xMCLS+2vdnZRL3GNYCCb0JjZugImdvaC7I5gTQKgS6WFsMpgJ06h5kz/7XqqQdeHVA1O9HUqw4G9ZNTGzP56YdLrJSH9d9xGge+tIWN34tnjOMiokVxUIP/SDxKdgdGXiqaZ+FoqAZOV0sryz+c4P3gghzkX4YZlhFa/3vQuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xX9FyQBNCPIWmuqoDJkCnrveWezvLUlKx/VDKKRrtnQ=;
 b=jxE68xK7ZrJehBCAe6RZLXXLPaGGR0Ox0YroDjqTicW+uKB7wpkFRzaF5uLV4nn7YxH/JM/EIEpF8rPUtlHEsmTlrdzlhsvLcwxKPCFwhBW7+w3NxGAGrxb3ey1tL9Kj95RHc59UEiCpm4NDji3d1e9qUncV+Mru/i4sBAhPbZcj2cVMH3DMOSH1s3iAew6MCZt8BrZC2tjvjTCg6WInJzXz3a40171n9EYizAp+iK8vI5pMZ89nmF2MDcfGX1pZoEZzTlKWAY1vqsKX8jSxoj5wpdAwiA69h3sA9i81AV1jMLgmg4tKUK9nt05mhItrzQKjphFLSwWtLKjIGly8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX9FyQBNCPIWmuqoDJkCnrveWezvLUlKx/VDKKRrtnQ=;
 b=y6W6SeSN+i/7X/z05ZpD/JSsquLjSjbuSekOqRkDBdQm7UqaVsT70pGes4gyByc16iEXTn2binKzTDIvuc9GeGgaA8eBix2QqE+Lyqjc5M8vA86A7jrboAY6k+2nsB5ESVuT/fjUaP5fYy0YMTW/FiEUhyT8o62JCNsm3FwHD6E=
Received: from PH7PR13CA0018.namprd13.prod.outlook.com (2603:10b6:510:174::22)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 6 Aug
 2024 22:03:01 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::2e) by PH7PR13CA0018.outlook.office365.com
 (2603:10b6:510:174::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10 via Frontend
 Transport; Tue, 6 Aug 2024 22:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:03:01 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:02:59 -0500
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
Subject: [PATCH v6 15/22] x86/resctrl: Add the interface to assign a hardware counter
Date: Tue, 6 Aug 2024 17:00:52 -0500
Message-ID: <099ecbbe678dd44387a8962d0cb81e61500cd2fa.1722981659.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722981659.git.babu.moger@amd.com>
References: <cover.1722981659.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: bc82d443-89cd-4f26-eb43-08dcb66389f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rvucDlGychkWiISz1/COPoOblQAT3vkBVdnnQfSCfcLP2sjTHt7JHnkFjzff?=
 =?us-ascii?Q?Wf3rpRmxevJsBIB/jiw+2Wzjc2uweyqb1vyyTgdW0L9ShZA8nT/bmXmYbpaB?=
 =?us-ascii?Q?+FGKp0Shmhu0lOVgXJxrl+6NNQ3B3rF8RUN5lbJCkYQyCEdC+Q81lafVGP7t?=
 =?us-ascii?Q?1/b0TjIfVjREwcFyoS6bKa03853bfVR63egyzhFltZKQS/LxcqFyeBVigsy6?=
 =?us-ascii?Q?mJT4AriMf95ioLVc8d1+bx1cRD33X7SOu2VqGsSJWsB3gZJ/CERN0tkt5CDe?=
 =?us-ascii?Q?y1n1D3mcZZPsR2SBsBnhjuAz0+3TzFKOkS2k9z+RDGhR0Gm3QbdWnePE0RLL?=
 =?us-ascii?Q?5NtZNYGL4fe/R+7nh1P37tIXAXvPeav8Qp4wWtcWxNe6bvHZCviOCdgdVv79?=
 =?us-ascii?Q?wgSBgxCNqDuwpDcQiplAkM99/OTqbFGSZWTdnTHYYOLnRC75eiBEyZCPybcJ?=
 =?us-ascii?Q?t76Ymu798onBJigqFsdwbLyRYjJC5gsRlwn3UOKp3rF+Ma7YPYK3WzUvBwSF?=
 =?us-ascii?Q?qmwsF1Zmi8ZQ4qI/VT/VY6IMyeonsGN9i2CBbpE1nE52XMD4YHRwamBPge9c?=
 =?us-ascii?Q?9epLe4VKUN2Jl88FvQZvNfB+HgNuk16tk5Sdtp/SA0lbkt7vQVWQ8JPHxkX6?=
 =?us-ascii?Q?9Zj75zVCptpaDO4Ro/rvKmjiMaukAr3h319naoItHR/ZzuO9kOz20grW+71D?=
 =?us-ascii?Q?Vi4O1UVcU7SZrgpTvZK/d5rK0GIL+v79QO5ZC89TFQS6ko1C6yAxdTc4E/iv?=
 =?us-ascii?Q?GIHWq+t6x0W5lpxHm0/Ty6Sh0UKtzdfhmtijB8Bj/x0+49HufFMui2tYTGcv?=
 =?us-ascii?Q?X8UYNlLlVXA2J8kiSdXQsKuc5z7e4bP+P3FS2dMMrU82TINScwkfLOQRBHU2?=
 =?us-ascii?Q?MNDvSTjWcX4ikYQf/zQGcaTyejbShBfgQtBz4T/xnyRLU1u+JOqhheub9r0z?=
 =?us-ascii?Q?XLeQNUstiimEVPep3IuiY9Bs9NFIWeVLlZKcmIOplR4SJTW4Ln5flePJL5lp?=
 =?us-ascii?Q?x64WTstNhZ+D+QuAEqUQC9Oc/4G/eDsYAFW1KWRlVWQP36zPh5BFji7+XZHL?=
 =?us-ascii?Q?Z7SFO9nCZ7S47JlX6Qua/MLGXJTEvoGuVdgnCmsCN/JBF3/uAEydjPG8rdVK?=
 =?us-ascii?Q?AJP17VMJ5Jq5k9rR78X4IxZbr5sfaX69Dp4PSedQNfV6NjxuiJoTStjkzYIi?=
 =?us-ascii?Q?Oqf9jfY96gMKrqAUFuUcmCkmzsdjkB65Cyn7aCqWi+3hr60s4cqIf53hgVeV?=
 =?us-ascii?Q?esgsAJzXqkp2zq+UAP2zBKvISXA9IAjPVlUvasU4j9H4hvBFVJ9gS2Tagv7D?=
 =?us-ascii?Q?4xXb7V7BMlagUKmyfo4EsIiBq1n8IieHuwfzRY+X9owGPX9zcaOI7gtuJwDA?=
 =?us-ascii?Q?uSW0Pr0Z3S0eeDEqT3BaTFIqUd+XizYOVv+yVRhBilp03uSueA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:03:01.1392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc82d443-89cd-4f26-eb43-08dcb66389f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as it is assigned.
The assigned RMID will be tracked by the hardware until the user unassigns
it manually.

Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
specifying the counter id, bandwidth source, and bandwidth types.

Provide the interface to assign the counter ids to RMID.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Removed mbm_cntr_alloc() from this patch to keep fs and arch code
    separate.
    Added code to update the counter assignment at domain level.

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
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 97 ++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d93082b65d69..4e8109dee174 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -685,6 +685,10 @@ int mbm_cntr_alloc(struct rdt_resource *r);
 void mbm_cntr_free(u32 cntr_id);
 void resctrl_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
 unsigned int mon_event_config_index_get(u32 evtid);
+int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum resctrl_event_id evtid,
+			     u32 rmid, u32 cntr_id, u32 closid, bool assign);
+int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
+int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 60696b248b56..1ee91a7293a8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1864,6 +1864,103 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
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
+int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum resctrl_event_id evtid,
+			     u32 rmid, u32 cntr_id, u32 closid, bool assign)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+	struct arch_mbm_state *arch_mbm;
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.cntr_en = assign ? 1 : 0;
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
+/* Allocate a new counter id if the event is unassigned */
+int rdtgroup_alloc_cntr(struct rdtgroup *rdtgrp, int index)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int cntr_id;
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
+	cntr_id = mbm_cntr_alloc(r);
+	if (cntr_id < 0) {
+		rdt_last_cmd_puts("Out of ABMC counters\n");
+		return -ENOSPC;
+	}
+
+	rdtgrp->mon.cntr_id[index] = cntr_id;
+
+	return 0;
+}
+
+/*
+ * Assign a hardware counter to the group and assign the counter
+ * all the domains in the group. It will try to allocate the mbm
+ * counter if the counter is available.
+ */
+int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_mon_domain *d;
+	int index;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX)
+		return -EINVAL;
+
+	if (rdtgroup_alloc_cntr(rdtgrp, index))
+		return -EINVAL;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		resctrl_arch_assign_cntr(d, evtid, rdtgrp->mon.rmid,
+					 rdtgrp->mon.cntr_id[index],
+					 rdtgrp->closid, true);
+		set_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map);
+	}
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


