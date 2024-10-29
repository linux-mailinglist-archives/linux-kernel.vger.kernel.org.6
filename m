Return-Path: <linux-kernel+bounces-387845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557219B56D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89031F23ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA10205141;
	Tue, 29 Oct 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QCDEKnDG"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D820C03E;
	Tue, 29 Oct 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244301; cv=fail; b=Wjj4ueTxNfnvo/PZQ2KhrJV6vb0eO7y4WPBsvLPce5M4sCpdgqg/BKAesfl4d3PN7mOYeylCMx+nA1d9d9QLBmPj88KXksZ/6ojKeDMrKUZqmD5zS27ELNTD4GC5uG0Aj8dxhD5vAN6PzRY8E3BdMiwt1hM76LlcYgOvqoktLiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244301; c=relaxed/simple;
	bh=3c+K7mTpbWuwj5DHbpGJwyFbugrQmeHvzdAMo/y0/E0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8Dywh3VoJ4xZceB5zOZLRJ7KdMdyTxcsSAO62uHMPwhRcvM2bGahFIMOpy4NgLOYs1X9XBMfojy1Ipa2Mfef1FUlM2DQ59l7V93YVWYAOCgekx5ZvX2UQ0vgU5LysliVbc/e8a7HKhJ9lelEAwfNCvWhYGHcd/pI7RD32Gs8X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QCDEKnDG; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPOq+g1VVnqwSUgFW5EwvtwuSzLK/MPtRfKx4IniA/04wBdvy/vonlYL2sj4sxAVo4diuAqySizD5xJkpAokTCEVmR4kNLKjc5RFGYPCLkOIAc1btdKV4QMrWt4NBI13Xx5v+HRZSfy3thZNvKZwrVjF47YZIQowqZtKuaH/PgH8Q8hOlW7UVCn7MTlv2qBh6PDvAhopMkJQXavf4T2NLawga5axtKviizPWBWCJ63kJBejYNUsi32fWPRxVYgCH9DtKoc0gGa8e/OTGT8BKfdmkTqkEsNnEKBqSvhODTN0kWj4sn+KShLDo228nMknHNgCzEAkRwioFb4nXoSCT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lgJc4GFG8DitFNODUOSWfso0cmaBtUOP8bVocO6kQE=;
 b=HECUFX5yHR9YQb+MnbUZJoIfDc66aSU3YG2ZcHmZSJW3UEmIYDS94hteRxudjeDvbbNO0AUXhpyBWf6B1V//IhNjjagNcS61F/prFEgEpdmYHT48wUGAPqigx1wKFw3ETa8WidVSzqUyE5Ya1zm4JMriIDwWuH/SBp0HclwnDy5GmOIHcKiPXFV2WrkkrQTwzaJ5KUEaiDej7KeWeZNQZZflMoeZs08kSQZ7R8Hhu+xwiRBJ2aqG6hi5a63H+12uBXNZo2bdjnAhxmkw0+xMRSIJFTqE4jsj52reRlLqs0L1Si3PuOUChy41+dyaPv10Q6+g2VdJcBJFjB52rIEApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lgJc4GFG8DitFNODUOSWfso0cmaBtUOP8bVocO6kQE=;
 b=QCDEKnDGZD1mtWqFIa/5MougYFBpeL2cjOjW77mCicyLWjgqRFiV4xYYq14PK5Rmh5EzwH3Pg7AQxJxvG3WCkRM+GphyycMjZWVFbJ7zSXUJrxFpNhj4u4CVIYwsSn4mAi0ZnzUY/FbbWzFJ8d8jZNiJ99DQe50rp34pKDg0hGY=
Received: from SN6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:805:66::17)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 29 Oct
 2024 23:24:55 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::c8) by SN6PR08CA0004.outlook.office365.com
 (2603:10b6:805:66::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.19 via Frontend
 Transport; Tue, 29 Oct 2024 23:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:24:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:24:47 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <babu.moger@amd.com>,
	<jithu.joseph@intel.com>, <brijesh.singh@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
Subject: [PATCH v9 19/26] x86/resctrl: Add the interface to unassign a MBM counter
Date: Tue, 29 Oct 2024 18:21:51 -0500
Message-ID: <d27c3a15ccb11c6ba76794eba6cf7c013b0bb074.1730244116.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730244116.git.babu.moger@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f510502-e80c-4ebf-c41d-08dcf870e604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6/riaFmsFAgPSGuEmLF9XGICXTt37LbyR5eU2EonIgjePJVY6u0t0A11af/R?=
 =?us-ascii?Q?jS0SBf+CgKB+qScaaZkYJx/iz1urKJbZZHElbUizXySgEzyY3CxHfhLjHp22?=
 =?us-ascii?Q?1hGyYllomUFqcBwMCQGU3DAF2+IxICgsPJYoDfy28UPreVpZMysiusQdv/XJ?=
 =?us-ascii?Q?Jm4NGn0maYHBKXgUanE/2/aIucw4r5zcHXyDWZEVji7w5AgC5eBGodNgN97T?=
 =?us-ascii?Q?81miRUzzpxG7496Y6y8zT0p40IzXZRegXQxOuYDzN/brKsjgku2ICiLcko3g?=
 =?us-ascii?Q?W1q+WBxgg8GRdBvxl9shwTRlWWPBsPc+Pqg6e1KmjuSEx8aD/k9f2wXUoKcc?=
 =?us-ascii?Q?1yw55ZWNKmzbbOy73CvKpIVl8lzVs+I1C1Sv4Nzh+b0gIwgHMyhVuSsqaTZ5?=
 =?us-ascii?Q?XQBNk/Wx3vhuLDJHlUWrAmNKDsB74oIUgec498DTSRTVmlBNetH5L4fbyWwl?=
 =?us-ascii?Q?g1CG9xJj4K8/GnJP3wxNYljB2T2fNn/SJm4Tl/wmJpQuPlqLzlI5yFQLHwQZ?=
 =?us-ascii?Q?pIK3VxytZoTti72r1C7adC7gCdWF6TpceoHtLgAVXY4VxURlKpZ22y0f3jRK?=
 =?us-ascii?Q?QeIXlLdQYwTg94VTqmCFUf2CKY7GGP0aJ6mt8z1/Hpd0nri4f/Av9GvjaEBa?=
 =?us-ascii?Q?txa3peZ1EtBw8PL1C3ZX7jsA4vIEy6B273dnk/wkFvIgZNbAW45awoSpBKOR?=
 =?us-ascii?Q?vN7NoPCsexOe/5b2joGFu7mCdlw6k81vdisRfb7ZvcG1BV/TSl2dx9/FWjNN?=
 =?us-ascii?Q?3FEAc01DmFmoxPU4g3nV6+DWblRA2aK7uw4/d52jy1pKNJwyGC1Mzh29wvr2?=
 =?us-ascii?Q?LhkwHd+SbNqRiIICePUj8Pji9eaJAKMKvtKyF7cUfz+jUTEXywYM26RxT0bA?=
 =?us-ascii?Q?/EczN6BSAxKPiPN1RKUSAtCnoqAIx3nj7Qm9ACYqCQxAwrYKkaa/B/M8ANEw?=
 =?us-ascii?Q?SL5pdcK8elLQYu7kCMWdWjoN35cd8ZFciTa/XmY+pPgWwAKls77Ur5ZX7j1C?=
 =?us-ascii?Q?fvx3Kx9r3vJ0hoaTV0UEJ79rFl64sRaoRucTBbJuwL6X1oCD6dj8OYzYxQrd?=
 =?us-ascii?Q?Bgv5odackZg5OQ9l5483s+mu3VudIyYqi5nWX364ORLvLeDyw3/QD1+md6B0?=
 =?us-ascii?Q?TQar7WMDCCOA7Xv0rHwvYuYK/7EMW/87wDKM9xTZ3gXm/pSI9VT1Rg5wpTAF?=
 =?us-ascii?Q?VfCu+V9UyDKRMUl+NyHtjNmqwcfekN+Xgs1Nq7TmRBhOHy4xwQTCQTH1lIA8?=
 =?us-ascii?Q?dozxQgbuLsV7z4LfBQE2YVmIcZrEijXNQyCxi1XYDOps7EQDcQr/Q8zZm3vA?=
 =?us-ascii?Q?fs6ghoqC5FJF8CqaRJirGk8RMXWJu5T5ba43Dj4Qa9XW7oxJfghFEItKPLTu?=
 =?us-ascii?Q?9JODzxs2HnbhGR3glDtdla0O8pWwkXqX+WkBQliJfqHaL/ZOgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:24:55.8084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f510502-e80c-4ebf-c41d-08dcf870e604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205

The mbm_cntr_assign mode provides a limited number of hardware counters
that can be assigned to an RMID, event pair to monitor bandwidth while
assigned. If all counters are in use, the kernel will show an error
message: "Out of MBM assignable counters" when a new assignment is
requested. To make space for a new assignment, users must unassign an
already assigned counter.

Introduce an interface that allows for the unassignment of counter IDs
from both the group and the domain. Additionally, ensure that the global
counter is released if it is no longer assigned to any domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v9: Changes related to addition of new function resctrl_config_cntr().
    The removed rdtgroup_mbm_cntr_is_assigned() as it was introduced
    already.
    Text changes to take care comments.

v8: Renamed rdtgroup_mbm_cntr_is_assigned to mbm_cntr_assigned_to_domain
    Added return error handling in resctrl_arch_config_cntr().

v7: Merged rdtgroup_unassign_cntr and rdtgroup_free_cntr functions.
    Renamed rdtgroup_mbm_cntr_test() to rdtgroup_mbm_cntr_is_assigned().
    Reworded the commit log little bit.

v6: Removed mbm_cntr_free from this patch.
    Added counter test in all the domains and free if it is not assigned to
    any domains.

v5: Few name changes to match cntr_id.
    Changed the function names to rdtgroup_unassign_cntr
    More comments on commit log.

v4: Added domain specific unassign feature.
    Few name changes.

v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 41 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index cb496bd97007..66de0ce12aba 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -719,6 +719,8 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     u32 cntr_id, bool assign);
 int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
+int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index bc3752967c44..b0cce3dfd062 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2011,6 +2011,47 @@ int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 	return ret;
 }
 
+/*
+ * Unassign a hardware counter associated with @evtid from the domain and
+ * the group. Unassign the counters from all the domains if rdt_mon_domain
+ * is NULL else unassign from the specific domain.
+ * Free the global counter once unassigned from all the domains.
+ */
+int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				 struct rdt_mon_domain *d, enum resctrl_event_id evtid)
+{
+	int index = MBM_EVENT_ARRAY_INDEX(evtid);
+	int cntr_id = rdtgrp->mon.cntr_id[index];
+	int ret;
+
+	/* Return early if the counter is unassigned already */
+	if (cntr_id == MON_CNTR_UNSET)
+		return 0;
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+						  rdtgrp->closid, cntr_id, false);
+			if (ret)
+				goto out_done_unassign;
+		}
+	} else {
+		ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+					  rdtgrp->closid, cntr_id, false);
+		if (ret)
+			goto out_done_unassign;
+	}
+
+	/* Free the counter id once it is unassigned from all the domains */
+	if (!mbm_cntr_assigned_to_domain(r, cntr_id)) {
+		mbm_cntr_free(r, cntr_id);
+		rdtgroup_cntr_id_init(rdtgrp, evtid);
+	}
+
+out_done_unassign:
+	return ret;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


