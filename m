Return-Path: <linux-kernel+bounces-387849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889379B56DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487C72845FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96B20C493;
	Tue, 29 Oct 2024 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JiTfBH7z"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FBB20C49E;
	Tue, 29 Oct 2024 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244318; cv=fail; b=ZUbuGLYLG8VNQQPnRsjFxU979xVSCJLKDMFEpLyQpAHxCflJAnKL0sQL4oofsCvCh4qiqpbEJz/ZpM3d9Pt17EV3I5pnitezHFya1bnauoj427koywKGx3d8bVsvYrN5TrqhuwX5KOoSBI63DGdJszHtNbMfr4da63jUzf0PtXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244318; c=relaxed/simple;
	bh=mloZlnjpGQW5jvhsi6is6ot4gd8ajl7SBErTlHUfOHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsXq2Gg+EL0PuLUxjBOjBzRzK32Q2PBG2mmnKyPDLsdRs4PnURkcH/5ZuoJJWMBoPyjpP6EaDSo94Oa9rVLELqr34K3iAzms6tY7ph20WxZ2ZVA0nHSyCxYTYU5nX9B71ti9D1qrM3a/PFttABMUqLqZroOETxI0X5jgcAqwubo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JiTfBH7z; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/f+nocROOxblYXjHOv4Ec02vKH1wtIAhaGi2Nm64nDwk1LcLf++I8SZNYf6fGEdBT12D69fRQqM7MVZh58lgCKbkH0EAwhdbmZ7sKrHE6Yqugh6/zelD0UOPbywE4ww3XigUuq/0zWqba7R0s4Bu+jZayQaLAMBIzg5aMqMujNw9uHfq9E1bhgKi40XoTMJ4eVyIU/EjWA22T3gPApNyLhMWpMVCqvzQ8cySe91IMrWeYLIYDXN/IsSNz6lapYrVipRMbBaZCRK9Lw/4TX/DydgMzKqBmRaGgFR0E5fSUQzD8ijRcLCn5C3+BbGh5F3rt9OThklqUHZhH7TPTqNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZou7qGuKK8COqvffsuwn3JWZs/IBplc/L8y15Kolkc=;
 b=qO6coHCinnR4LPdvPCJ9PIZ6M8gaFxp8/feToHw02KfBPXSUpIKqq0z1L1lIeUz8sWccrofZDyDBadPfKQM9tbja0p2SGcGZQ6EqFeePf182yfLD1DJfb+tMFgf0lqbm+k/Sw4hscem7DBTpGjlEV/NLFBiC/LLdtBNJQZn6Azj3Fr8wP1d4EW8U2iYeKuFkF2lvAqB+l2ZBbTKmsek2gsLyAnmWCRAgIl1L28he9oYyNIcxD0D28gmx0f9KcEVjq2Q0zOuALvarwhuwZWzzjbitkosKy2FVhT2TcKI6fXevNXMBgz/RmdoZrOMOuojNiro4vtJsogA18spHbI+ojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZou7qGuKK8COqvffsuwn3JWZs/IBplc/L8y15Kolkc=;
 b=JiTfBH7zL6Vie2Cxkp7gpjWtjFVcZGevdL5H703+EfB34Smh/6xI1z4qvu1HAqSd61rQZyiwr6np1ADV4eI+lbgZ2i1Y2d8F0o93QBhtecQfHeLtbpD5KFY20j5dWDyHR+n6Oy1HbPT1fLe+2YFDiB8Zihq9T+bmGouePwFbd+Q=
Received: from MW4PR03CA0344.namprd03.prod.outlook.com (2603:10b6:303:dc::19)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 23:25:13 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::de) by MW4PR03CA0344.outlook.office365.com
 (2603:10b6:303:dc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 23:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 23:25:13 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 18:25:04 -0500
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
Subject: [PATCH v9 21/26] x86/resctrl: Report "Unassigned" for MBM events in mbm_cntr_assign mode
Date: Tue, 29 Oct 2024 18:21:53 -0500
Message-ID: <fcc0d1cc4e0f60626417b0c3bffe7638d6de9071.1730244116.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: e047c5bc-01fe-4101-a749-08dcf870f06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xF/pzApG9Ze3xX1X+wYGMmi6bIE8le8LcSPOvF40PCYPavb+LDPDrtEt8+rz?=
 =?us-ascii?Q?h1UjASfz/Cv5+oIpWN/MPmvNXzlNK75cUlEk30NwE/MeHNAwTvdiOPPwuGbS?=
 =?us-ascii?Q?ZyTUbqpUIPc35ZHnABSFDE+91awKf/3G5K1oL6QyyDqC8VxRLYjdlwvwzx5J?=
 =?us-ascii?Q?t75vH95OwpYDdU2kR4BkA80eJr48W8wt2X24fjwthby7s8KJvoXeoWlwvMsm?=
 =?us-ascii?Q?d9RvELNJdwoYl6PvfS2hQf6uv/gz96D0AejbIsE4920v6TElTbMxt2EMzO3J?=
 =?us-ascii?Q?PWPN+gs8aPkuc3NHu8VXWgVhCoNSO3ATHe4x3Cab/kcShIAxnALNP7cmcy4h?=
 =?us-ascii?Q?SJ3dogOxUZjDHPlTvCiuDMZ9BEfEK4bnQd7JIjVbxLJU+LTRPLYMFeGoDzBC?=
 =?us-ascii?Q?D6qHDhl8nCHuqYP9pxDkp/eoD//cjNKCo/Ivklmopp7ua/DfaK1Dgc8Ip8ps?=
 =?us-ascii?Q?27MrnWETt7kEsAPBC4joaqNWL93pJylng0Rz0+ObYpOY1OIkQnAKVaEqfDw8?=
 =?us-ascii?Q?+AWGPKutGA1ZgxuMhcfpNDCP6wZPVEe5JVtWYH06smUUH1yiKvGsU+GJR+jj?=
 =?us-ascii?Q?ZIf6VPXZpjzNKNpxJZekjLNLHN2CKf2L9slN6IOYXibdtevMoLEie187bKz1?=
 =?us-ascii?Q?jaZkuag0DwO3P2X7BaQIG1P7ZDPqWPf0/BNEVC1h7EX8uu4yHcyK/jyERDuo?=
 =?us-ascii?Q?OkCdc8t1pdF+WwtfYwk2GSNHIPewt+AyHilBEdQlk0zKcnsawZ456Dt3XxoO?=
 =?us-ascii?Q?lEWOgJShvJMmDvH8ntDD5RGqn7nKF50fF+fFUPs4wxJXvJA7vXDNaW5zFwf/?=
 =?us-ascii?Q?SkaXsue6JM2NiSXHRS2/4yQT9ZSMpMqRfnqIsM01VrDqbkn2IVOA3bGUtGeF?=
 =?us-ascii?Q?KaSPLPFSLRVLKogrjFb1Z5L52hw+r/AgV/m97elQt0kp7e3Bmmp8MlHIeAEY?=
 =?us-ascii?Q?WAEQQOkLn+mVSm2wUNd41xW1rMeilhhFUHkyWhcV1qYlHSlaHv3G1KOD+azC?=
 =?us-ascii?Q?TZOvPw7d10ICuj1eK5mB9Ku/WOGC7nFdeipmGc2C3piG6WHla6RttDiM6YyG?=
 =?us-ascii?Q?XGfu7FD0jME2su4/YQq2Jku2lPN9wVZwZs3HB1rw+W87IbnBmHflEKbTOsV7?=
 =?us-ascii?Q?+ewv0742GlDPldz5ebhkiNA5Tzc5xb1d5wx6sm1EEJp5zCWqq+bCiKgC2gz+?=
 =?us-ascii?Q?exVnbEyHlGT35vqakCvGUohjcI6AiWembmdECCfC/tjYsATAcCC6k5vVlhhZ?=
 =?us-ascii?Q?Jj8kxK48zLX8zoLSNG6urs31q9G4BWtFldgv12retK+e876JHTjHtF62vSby?=
 =?us-ascii?Q?7qE5tITS3IuZCYnntD7oO4RFgWwwZIaLJx3LUcCUBCLpPujPrMMVfnAJvcp9?=
 =?us-ascii?Q?RzTm23Vm9PF3MiZ8jnhHdbUHqMs9UBNZv4G+X9Nlm0swjqY3ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 23:25:13.1923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e047c5bc-01fe-4101-a749-08dcf870f06f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753

In mbm_cntr_assign mode, the hardware counter should be assigned to read
the MBM events.

Report "Unassigned" in case the user attempts to read the events without
assigning the counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 12 +++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 2bc58d974934..864fc004d646 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -430,6 +430,16 @@ When monitoring is enabled all MON groups will also contain:
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
 	where "YY" is the node number.
 
+	When supported the 'mbm_cntr_assign' mode allows users to assign a
+	counter to mon_hw_id, event pair enabling bandwidth monitoring for
+	as long as the counter remains assigned. The hardware will continue
+	tracking the assigned mon_hw_id until the user manually unassigns
+	it, ensuring that counters are not reset during this period. With
+	a limited number of counters, the system may run out of assignable
+	counters. In that case, MBM event counters will return "Unassigned"
+	when the event is read. Users must manually assign a counter to read
+	the events.
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 200d89a64027..43a48943578f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -567,7 +567,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	union mon_data_bits md;
-	int ret = 0;
+	int ret = 0, index;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -581,6 +581,14 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	evtid = md.u.evtid;
 	r = &rdt_resources_all[resid].r_resctrl;
 
+	if (resctrl_arch_mbm_cntr_assign_enabled(r) && is_mbm_event(evtid)) {
+		index = MBM_EVENT_ARRAY_INDEX(evtid);
+		if (rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET) {
+			rr.err = -ENOENT;
+			goto checkresult;
+		}
+	}
+
 	if (md.u.sum) {
 		/*
 		 * This file requires summing across all domains that share
@@ -618,6 +626,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		seq_puts(m, "Error\n");
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
+	else if (rr.err == -ENOENT)
+		seq_puts(m, "Unassigned\n");
 	else
 		seq_printf(m, "%llu\n", rr.val);
 
-- 
2.34.1


