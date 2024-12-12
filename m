Return-Path: <linux-kernel+bounces-443899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B09EFD42
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72C228BDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA941DE4F4;
	Thu, 12 Dec 2024 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZYwTzHKD"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F391DE4E6;
	Thu, 12 Dec 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034725; cv=fail; b=phVpbXT6JOmm4ggsTLfGaPnNYsvFojQ97KQRkMG1kAlKUvKlTjHAvOp7szR9Uxn44NEaoVH/ZhRnZ2JDXpaqbkBxrZR3rGrGkbkwdcddeuHrFD2wsw/eSWQcgD2LuLv3tmegl6apY2ZOO04hIG0rwvoafMk00KBP+fj9Q+C+mAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034725; c=relaxed/simple;
	bh=IfLOQYg9LCih2u06s0z4psbOLYNLi3Mqo4QgmmHqGMI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAVEnS/+tqt+h9v175hXFLU0j2rCXDnADbAoSAbGF6yeLuLo/QnKuglKWAJlT5KD3JIw4VUqysbpfsIJ1sMN9t9ztaxuK9W+hhTX4OLOxqPu3D4mC55ijoGQP2jzjXBICNJa7sGLIMhIDD+T3pfFc0biCymr8dUxLMCTFEjR1Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZYwTzHKD; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWikZOFHxMMESJqzdpAMuo50gqcQYOj6qK1zPil+/EkbMduxgHFo6LP57ypWiN9EooyshvCFVkDyjAQvokppfvdErtSTk1VcC0imrvD76dqeBIitxgj0F6Vd0LPt8TrD8mpXsAwBw0XfgzIVa3GAQJ2Zm7+m3/i27UVuPpidUwNBIQpgbrXiAIn/P31sqapLYiQ4do4uGNU0gcCK+uKmcqWILNJ7sXiwHeWXRD6dQtawXpIRNWIJhDOtzKJ2waLHLt79poOLuD+/BWSYyZMBHS5VqAdxHjZ06SVwcrbSrkl9XdTbndfZYe4S8cG58OrzY0juxi2upSYDGmZn1qx9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOLW36aV3Al/dx8UDbYksb0dH1FcL3VBV8sMgkatbxU=;
 b=mgSDzQpHch/mRx04gsFOPO4KDKUoOZ9VEf/uy4Bn3cEMmzYuDk+EuXgD3OrNJt5iTATLwTmluMgTGncSBDOwttz1+sOzYSP7OlKQ5dWv2TqMe4FhZGB3xre8haB/KzJLo86UAi7cfXL39cx/Iv70xh7sbnW8aYuxt6s/KaGtVMpyi6iiO5+HRbGNp0x8wEFpgdoVXq4rLBHWeNTtKuRcujRkO0Jf9NEXNzuNmdrnwtJyPyI5F6+hA0p1L3+cx7+aDV8UKEjSBWY9QPCr2WKFCkX7ppqhUSv2pZoyZqCBkT7NL9hWse58d1p2SD4T+WAin3qKw5O/c8MP/qnuf7YW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOLW36aV3Al/dx8UDbYksb0dH1FcL3VBV8sMgkatbxU=;
 b=ZYwTzHKDhKlIyq1EUE34vT07bv1MOvVyDDEE2DjQo0j0MtgEk+/BnUXetrEKznGtvhHGDD21W2sd14hR+x22X8v0S7qhf0J67GsaGg6H/Zw9BShq34UxWXxnDS8/SG0EbBdvoIpG0qegnCO9XGwbI5r10J2yZoqAyPggil8aQiQ=
Received: from BN0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:141::16)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 20:18:36 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::59) by BN0PR07CA0021.outlook.office365.com
 (2603:10b6:408:141::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 20:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:18:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:18:33 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <andipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<babu.moger@amd.com>, <xin3.li@intel.com>, <andrew.cooper3@citrix.com>,
	<ebiggers@google.com>, <mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
Subject: [PATCH v10 19/24] x86/resctrl: Report "Unassigned" for MBM events in mbm_cntr_assign mode
Date: Thu, 12 Dec 2024 14:15:22 -0600
Message-ID: <2b59ada547e0444755201f269fc99240b3195e1f.1734034524.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734034524.git.babu.moger@amd.com>
References: <cover.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b6a51d-2ad2-4548-bf17-08dd1aea281c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+rRx/fHpKtuAMalluLi7dR26wgyS8ESiNC3oHsbcPesZhLLpSvG1qb8X64qq?=
 =?us-ascii?Q?AV/mkia5Li+oH5AuCeRYQ+mlCTvTyWzHdGqLGCUOBhWzYD7j3fffuLSAm6Xe?=
 =?us-ascii?Q?QiRmmpPM1AbDMzDYM48SgGNBwCYFg7vod5tJ2UEoVuuqIqSCgLV8C4Culzv+?=
 =?us-ascii?Q?CLz3qK6lP679L6rDiLYbNg0Lsa6+rQesscOg4Fx6gcmpPhsMbCCOgW8M5WMm?=
 =?us-ascii?Q?jeMWXMRoUnf1RtodAkhkLpmiSqouQLkL5s2LH+EhsMu7Q0fKy0is8dEbhECa?=
 =?us-ascii?Q?68tZmHC2Lfowb2zJavZUsybm0RMCNZIsqCJPHq/IwNskm/ZTKPbhhk3BLwbk?=
 =?us-ascii?Q?GwpLNZh1K/+dJUeaR9UEz8FqLmegIXMK2b4QGhLw9ozBp/3Sl0GKBtT7kv2S?=
 =?us-ascii?Q?Crz07NPOhLisFBtu5ep351fKpsB8APpq1WUp3iTXM8P51N2Jbr3KM67TVaup?=
 =?us-ascii?Q?ceTo1ALo3yuA1gb9uVRvYAWYJzaUxJKalGDT+2GatPhI8YQDpfrnFREzJV1U?=
 =?us-ascii?Q?73peIX0+JTaJF/OAtfZglaIlxuJ2xR7CYmpiMEuQHiteQwCJM+2Wd4l+CK3e?=
 =?us-ascii?Q?rgQqMVEUraIsqfhkoSi20/J8CseznahwBMkiKQk6YxUu5L69JunokD0RWKpg?=
 =?us-ascii?Q?Ggcx3BkqfUGHOA2rCuIBlUPlzmpBccnFQQpiVLJVFoPF8fmLFikte7pT6oyg?=
 =?us-ascii?Q?U0qOjaxzkIw84moRw8YGPOFEGs91dkO5RsfyEmE4QJyFFVYOGZ6UyGxuVGs2?=
 =?us-ascii?Q?gA4loREQLega8FDCypyuy2MPlHITSll85U++1r3UaMJD5ak02wSiXfqEeWRX?=
 =?us-ascii?Q?fUyvvdCbcwgac+EPJQbjZzD/Yzg+WNB29ne/KgLAanhjI+CMkvyB0dyOnjzQ?=
 =?us-ascii?Q?Lrg2UQYMaThIGrVNVlHYfNGvPSTg4dLrTjwz+S0VJ/NYrqb6hcFwDstEa/YM?=
 =?us-ascii?Q?3P3z5NjF4eU1E6d7LO6PXiy/TyA8AjmUrR0PO/32KmvesRBZot4n4zid8dpp?=
 =?us-ascii?Q?PPHOfZafL6zA+eRwC+xI3M+ux3WUXEw0o/pUORMXUvKdyOLQOamN0IwJZmo4?=
 =?us-ascii?Q?fmkiE8Uc2Xzt6Q4ECqEtwFLhT6F2cEbJ0sKSG78FWTxZ2lOOl+t2ByJyj6Be?=
 =?us-ascii?Q?0FJV5CBvRlpWdBoH3VZro/YhKrm8arKgHddxXYO5p5rovg2/1xWgLRDsw9vE?=
 =?us-ascii?Q?m2Ge7S+ZtMHGAAh1CwA/r5YGPSLEt01Vq9PBXWAG4E/uQyqUKHhhhMOQWolJ?=
 =?us-ascii?Q?82OxkAvsg/2YGqbkqWOtVq07jIizAmDuC0rUxByJa0Gx4YDanT1okQKVDhT7?=
 =?us-ascii?Q?jcNGRniwn202C9w8tGgIWdbqIfcqtL5WgmR+XwGCgTfLdnbzy6I81LXOiwak?=
 =?us-ascii?Q?pzgqmePAA4jM6FPuncWX6YuGvOmVDrMM/CDvaQoK9xEeGzpb3wgDmNVmIAha?=
 =?us-ascii?Q?p1Mx429+Q6wD1LQG/n28xu07rbw8c0k5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:18:35.3495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b6a51d-2ad2-4548-bf17-08dd1aea281c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345

In mbm_cntr_assign mode, the hardware counter should be assigned to read
the MBM events.

Report 'Unassigned' in case the user attempts to read the events without
assigning the counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Moved the code to check the assign state inside mon_event_read().
     Fixed few text comments.

v9: Used is_mbm_event() to check the event type.
    Minor user documentation update.

v8: Used MBM_EVENT_ARRAY_INDEX to get the index for the MBM event.
    Documentation update to make the text generic.

v7: Moved the documentation under "mon_data".
    Updated the text little bit.

v6: Added more explaination in the resctrl.rst
    Added checks to detect "Unassigned" before reading RMID.

v5: New patch.
---
 Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  8 ++++++++
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  4 ++--
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index c075fcee96b7..3ec14c314606 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -430,6 +430,16 @@ When monitoring is enabled all MON groups will also contain:
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
 	where "YY" is the node number.
 
+	When supported the mbm_cntr_assign mode allows users to assign a
+	counter to mon_hw_id, event pair enabling bandwidth monitoring for
+	as long as the counter remains assigned. The hardware will continue
+	tracking the assigned mon_hw_id until the user manually unassigns
+	it, ensuring that counters are not reset during this period. With
+	a limited number of counters, the system may run out of assignable
+	counters. In that case, MBM event counters will return 'Unassigned'
+	when the event is read. Users must manually assign a counter to read
+	the events.
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 200d89a64027..8e265a86e524 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -527,6 +527,12 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
+	if (resctrl_arch_mbm_cntr_assign_enabled(r) && is_mbm_event(evtid) &&
+	    !mbm_cntr_assigned(r, d, rdtgrp, evtid)) {
+		rr->err = -ENOENT;
+		return;
+	}
+
 	/*
 	 * Setup the parameters to pass to mon_event_count() to read the data.
 	 */
@@ -618,6 +624,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		seq_puts(m, "Error\n");
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
+	else if (rr.err == -ENOENT)
+		seq_puts(m, "Unassigned\n");
 	else
 		seq_printf(m, "%llu\n", rr.val);
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f858098dbe4b..bb3213a7993e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -710,4 +710,6 @@ int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp
 				 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 				u32 rmid, enum resctrl_event_id evtid);
+bool mbm_cntr_assigned(struct rdt_resource *r, struct rdt_mon_domain *d,
+		       struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5acae525881a..8d00b1689a80 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1967,8 +1967,8 @@ static int resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 	return ret;
 }
 
-static bool mbm_cntr_assigned(struct rdt_resource *r, struct rdt_mon_domain *d,
-			      struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+bool mbm_cntr_assigned(struct rdt_resource *r, struct rdt_mon_domain *d,
+		       struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 {
 	int cntr_id;
 
-- 
2.34.1


