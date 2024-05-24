Return-Path: <linux-kernel+bounces-188685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E919F8CE551
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191D91C2101C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A25986636;
	Fri, 24 May 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sS9mxBxm"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1812AAF7;
	Fri, 24 May 2024 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553554; cv=fail; b=rXx//7XyF3f32TsoZjCuTw7ebfe0eMcelhwtBVIUsaxqnIxrCm4aj1TxeRS9JFPYh9UshIhe5Uv0IAal4q0MH7kf7bjpAsN1Q88TbcHsm7uq746/ysVPniDZrPG3rC3+hV4Nuw0ctap0qUh8Mhex27xIfGOprm3BblEBly6XX5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553554; c=relaxed/simple;
	bh=jK6ooheWL5driCAQJeitfvAJpuOi7nnPSvAPOTTdxJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7SEEtmpZEe31iDrbR6aqgHe9bAOC/hREaH1LpIdS85AUoGssF5b2DDIgBo87fmC8JMmpm58WnW+7Zla4Hcf44NBHGaKPxeWHUTTLDsEAq8o9tqMKcbKSyGxAS5UzSufZZYQMprAmH+jcm1qUCNeR10MRnQ994E5ylCkszNMa78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sS9mxBxm; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh8538bh5VP+d3o116uEnC+/AxJyqiWAE4QQM2JK7umSYZKwr4vH48D9H1ia/IlNmQ9iy9Tu/SVNCXYT/YMoyFXnm9dyZjx/YEv4xiLV6ylSspoEnqGxnoETmoYBjgDk/I6XS1Lqh8LGnu8OyDIocpGWl3d3xiuYl0JGQKnxYCOP7A212j3HNQi/Gh1BMIQYaHiPNGbp+gdoy6qs4kRVAgpfeC0IVVVjqhSHhcQoo2QdLw0bgDCv+eVdP2VG4GP+QreTLSPpYnSukHJ7hT4Dqvvn0/Ruwf5F/MVewLaZi1uoPo8pdl3+DRIs13y0Cl9/ftft3ZWWUt2dLtFVlgOljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWVmiMIHpLuPBH1Oxj8px1EBeE9f/hYpYhoni6lna4c=;
 b=H1w4BS9f+SXTJ42MAqW0BTK3qEF14So15ig3uN07P4kRHN4wScUBSlt8OyC/hY6YaFK8++7U812I1AUX1M826GrCUGP1m69vp29xDwXsFNSaHgU6lUefpUJqTtiMWb2S8h53gzqXGdiqPB3IgDmKJrI7Tsz5AJgLeB3Um0ytpQn6nSdjog457cDON7uTJ0RtB6ci7//rkq+isHVXkINe5OgQwP6TIMVuvuRj/a0x3T5+gMAblGcre/PfhpEdyL0UK1BCryBAjnCk/o4mk26ZF4Z//mTX3B72MAKqNKt+tGtWgH/XRbDUylMSlz654xJGl4VgP5noegGa5dS4VFBtQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWVmiMIHpLuPBH1Oxj8px1EBeE9f/hYpYhoni6lna4c=;
 b=sS9mxBxmOwOGq6tyncB0nQUqAH/IJDl4Ptd9BmlTUmiW2UJ36e04o3PoOubDBfXwZ+ZBX6ArSR57B7GAxMYCfP3Jyo0osYz/ldZxnNNVPdu6U1FOQGVlm7iU3se6wKsxXvB/JiyzWRKrPWIVoy6w6KtG4wecY0tJr+2IaPmJKXI=
Received: from CH2PR19CA0006.namprd19.prod.outlook.com (2603:10b6:610:4d::16)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 12:25:50 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::a6) by CH2PR19CA0006.outlook.office365.com
 (2603:10b6:610:4d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 12:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:25:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:25:47 -0500
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
Subject: [PATCH v4 15/19] x86/resctrl: Add the interface to unassign ABMC counter
Date: Fri, 24 May 2024 07:23:34 -0500
Message-ID: <1964d74c24b041e5c9589040701a6f6aaa839e19.1716552602.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716552602.git.babu.moger@amd.com>
References: <cover.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e623f1-1494-4e59-0f25-08dc7beca58e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hUHvspTzs2JlTkG1TEAOMpIT82Klqr++NVIR78lmnUSSEo7QramKBY5fCDSl?=
 =?us-ascii?Q?xhBM1vlDTI5p3N+6+l1uB9fdFHCXh7Mg4Y2PjilgNj+B1DEkRZ1NILBu8dMC?=
 =?us-ascii?Q?xCubPp/HLg0Myz/5AENL9MAFxasM8fEH0zSxOvJCHLRTVQ0zz/KX682c5qMJ?=
 =?us-ascii?Q?+uDkOkbnWZEIm7dek7m95Cpdo1vm74EJ1H2sRO1jtYf7lyZjbhUX7Bv7BcLq?=
 =?us-ascii?Q?BBcOUWvYc+i6pi42pk5sxGCBUmJQ1kupRiaRDycW1DgdYD5fUae6Q2DRysfO?=
 =?us-ascii?Q?6cuaGAFWjIhoNGH9pHr7uIvrHQbaPublg9qxKESX8kauN/sxmSn9UryAKqUs?=
 =?us-ascii?Q?lJiqpUaj3Y6JfBjxSZqN8ko0PS6HjXjaa2/5zp9x12zAbSqqpRoW/bKiSp7q?=
 =?us-ascii?Q?KsNa74qVr37sr5eyh/c8myplsfp88D4DeuaFFu/Ab+JVulRkturBx573SE87?=
 =?us-ascii?Q?1Hl4Jilk4AkiIs6Liz4xVVZBq6rXyAzo67PWEYD4ibU3WotyjiqHzN1+aQOH?=
 =?us-ascii?Q?iW+vScSqLv93jrbKw1UP2Jvv8aXSlt2IQop/93N1+vtna0rFphnBfsMrM0Uh?=
 =?us-ascii?Q?HXUBfk7ArZrilHrgOne5UGWKTGOUjvNdMHAr4lMkiO9zb1vZ1G9anowRYaRk?=
 =?us-ascii?Q?G2ppVXTDV0mO3JlX5JexwWtU272R1T/iI4nycbwaG3DbIFjnTc9N5m+fHh+H?=
 =?us-ascii?Q?pRyDJxLF3Uv1KjJJk2VpL0VFqK7CAAflG+Omc6alcQUvPJFRkvRc1WHW4N+/?=
 =?us-ascii?Q?XnFPaGrJ9QZt4+0htrc7qwcm9nMJxNYunVpAaTbiGhYnMbIabd4DNTz1eXdf?=
 =?us-ascii?Q?aAez6epVupGUJA0Lih7J9fKGb1mljEdNDnC8rEoYJ1fhR6I+cZE0gcswqVHX?=
 =?us-ascii?Q?WTI8LmDa5mZiY4ENdXSdAKMkKTUEVT1bTvvHJ4ZP7yMmE/Icrcd3vkFT7BRa?=
 =?us-ascii?Q?qZUPaW4zKM/dN1mJKVbblf9qL8pGxhP8aHRoWuYeBo09/Wp30SaMl2+If6FR?=
 =?us-ascii?Q?27U+ZrfiCxA9H62zpL8r9u+PX4d/i8WBy806j1MdsrT5LldnQEyS9O/fi7tE?=
 =?us-ascii?Q?EpfQHHwQRx5LxW+uobIJzGEAQoSjJiItZSTK1KcuEnhMwyERcuGr4R3KU/fS?=
 =?us-ascii?Q?PT6x6Vg1jCtvbZrOIEligaC643sF+1MDKKd1YCNyayC0imKYP98fveDS+Qgx?=
 =?us-ascii?Q?mLEr7dszrmb0TVX3v9zErJgcGDwVZEXSWr0BTNwzi5sbWPZFY+PFxSfMKNkq?=
 =?us-ascii?Q?D3Dy+QIg0f+61GZ8HVN6iCNL5QBNkRPTWaxXfTut8vjXhJP7n+2HywmYEIcv?=
 =?us-ascii?Q?ZBRHSSXdYuzrDCrRJ0GSADwd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:25:49.8566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e623f1-1494-4e59-0f25-08dc7beca58e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743

Hardware provides a limited number of ABMC counters. Once all the
counters are exhausted, counters need to be freed for new assignments.

Provide the interface to unassign the counter.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v4: Added domain specific unassign feature.
    Few name changes.

v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 42 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a88c8fc5e4df..e16244895350 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -660,6 +660,8 @@ void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
 int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
 			u32 ctr_id, u32 closid, bool enable);
 int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid);
+int resctrl_grp_unassign(struct rdtgroup *rdtgrp, u32 evtid);
+void num_cntrs_free(u32 ctr_id);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 48df76499a04..5ea1e58c7201 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -216,6 +216,11 @@ static int assign_cntrs_alloc(void)
 	return ctr_id;
 }
 
+void num_cntrs_free(u32 ctr_id)
+{
+	__set_bit(ctr_id, &num_cntrs_free_map);
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1931,6 +1936,43 @@ int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid)
 	return 0;
 }
 
+int resctrl_grp_unassign(struct rdtgroup *rdtgrp, u32 evtid)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_domain *d;
+	u32 mon_state;
+	int index;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", evtid);
+		return -EINVAL;
+	}
+
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
+		mon_state = ASSIGN_TOTAL;
+	} else if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID) {
+		mon_state = ASSIGN_LOCAL;
+	} else {
+		rdt_last_cmd_puts("Invalid event id\n");
+		return -EINVAL;
+	}
+
+	if (rdtgrp->mon.mon_state & mon_state) {
+		list_for_each_entry(d, &r->domains, list)
+			resctrl_arch_assign(d, evtid, rdtgrp->mon.rmid,
+					    rdtgrp->mon.ctr_id[index],
+					    rdtgrp->closid, 0);
+
+		/* Update the counter bitmap */
+		num_cntrs_free(rdtgrp->mon.ctr_id[index]);
+	}
+
+	rdtgrp->mon.mon_state &= ~mon_state;
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


