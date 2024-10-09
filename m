Return-Path: <linux-kernel+bounces-357634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A77997387
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6D81C252ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8221E8841;
	Wed,  9 Oct 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5G3Au7Rn"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5D1E8829;
	Wed,  9 Oct 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495769; cv=fail; b=ruG2QckcFwQTfxr4ikf8jx8zTNgbDNrcCG9qSDh2daAWqM7o7Vm4+7H9MDKfFqlaJk/t76VGA0fUVy1RMMMwNJyBpvS9KJcFTFu070fXihJ+uJmwTDhlgzGhSfNzuXlCbRt3/LEnciujm9bHXbCTnPdLwi9URjbJsIvMsXNR8aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495769; c=relaxed/simple;
	bh=cs7mul5kpEr1ioI94696AG3AJiRjsWUumrVoruql1vs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECTSEOa7Qcp/eTiwZ+htNUgGohMBBUrXNtKxBzSm77TwLxvtMIFjdEW8lGWbbSqIcCf0TeuJ6SOaAU4+/9m8XJI+XLHcbmQETzjYJHew0Gvzyz/LTWt1yGaCzUI6wZbjVyI8z66foOspa3Oy3I63GE6KUmjVxVglMwEG8iCovvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5G3Au7Rn; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUL0qhlYpQ1kS3faFW2HakfAe32pF/hwiKwHEnltKrAG1riTuyUXBbZAMCmNAG/M5vpCTB4pKGIrnfUTfP0dWaRe7B+Bu+AqMFnJc1b1OpXxZt4GUyfJOn2IncWdhsqllmev+9ac3vE02mj/CaQSZ/MMfAu1gXSKNOBRPcJhdFaeewhF9F+2oj6bhkq/MFVqIJIoAPGS6rb0yHAFTzjRP6wunvjdZJk6SZKkeFQMdbSHmH3vpBBDLuAGJO3B1kDLfxwX2zTdKjc8HTgvQMt65S90ZVLto2JtZ6Rp7XZCrc289/ABy4uTqqwJutDkteAQlHR95sChoEbVgPXf4/Bx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH0V37SwRVibDd2zfkQSRVIB+ZTz2HNmALIIaFskWyQ=;
 b=rPVec7Nw7K+jXbjyqhtcPzf/YqujUcGv3xunBntQW+wan3oTngzcOppgADMzczo8t/dspGw9kPp5PzbArktdmWXbPx3omkeGO2S67w24w1BHGJNTv3pu6Mm9BxvDjO8ypqVl6xm7arX89tDO32008R3NDQatL7+FWtWeM0o2FDbia55FxNlkQrKYmeH0wCItfuodNHw1TNSo6nsfMzKaHdosRwOHz+ndp9EhmqLWTs0K6uCd03sxDb91ycQ+74AIt9/6BXy13e9thN31xezP2KNd3/R+SgIVmZ2OsiWeDS9XOoK7t/dgbLEnIqX2rQvu/o2Ch4avwtxXx52FQlSf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH0V37SwRVibDd2zfkQSRVIB+ZTz2HNmALIIaFskWyQ=;
 b=5G3Au7Rn4pWSsDTdcdUBwQABQsf1I8ZURgmLSTmh1FbGopVDGrL3oP3J7vJlnSHUQFHU3for9nxHW2dblAHT1vIbBFU1i2V87GScphl9n/kxVaLbmdhxiWhkHi8hpxK8pU0QIkfDB1hTujitjzIYHtkHGaIfRNNlUEWbXtuZX9Q=
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 17:42:44 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::24) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.7 via Frontend
 Transport; Wed, 9 Oct 2024 17:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:42:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:42:41 -0500
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
Subject: [PATCH v8 20/25] x86/resctrl: Report "Unassigned" for MBM events in mbm_cntr_assign mode
Date: Wed, 9 Oct 2024 12:39:45 -0500
Message-ID: <50a4e993098422eece96d08edc337856a52cadd1.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b067dc-1551-4dcd-0699-08dce889c79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BilR2Eu30O6Ly5rB0MRixfrws+iIJ6q31S50FiBwbcLhzDL+9Xcz8byHno9o?=
 =?us-ascii?Q?VaEEMC6/J8N3VvJhpv0cfnEfnvKJixypeZVAzUQo55J5eACrRNSYswan9YTL?=
 =?us-ascii?Q?NFqvyXmnOxLmrfV6ND7iifhZpvPrkRqoIGBzze/V968NF9MZszTRGLF1fMPS?=
 =?us-ascii?Q?AKM22UJouYhr3DkYYJdpeYQ2LjApH33KpKRXYDK1TKBWVrPoLOisrb1P1k48?=
 =?us-ascii?Q?bK1DWdjWbab31fhoDd541rheFRIowxZQvQ53smVdc//h7huSQ4+GCDWXkzxD?=
 =?us-ascii?Q?5oGYHIR5Dve57ElvIXLWK8QhSYDMLL9YdH0xwdrZTGyfVJIuaVaPDoeyQ7FZ?=
 =?us-ascii?Q?4eyqH29OUQWccVGGJeUMk+zKqsCTOhePWCLZyBXFQwtc+hn0285NQCXKOSka?=
 =?us-ascii?Q?nHJCyCdaNIOdbOgBluK32vtSJGN0dfLahTUbEEBmTMxrzYtDGvyTClqKnr4b?=
 =?us-ascii?Q?2xNZER1Vx2KIjpZZuuH4f6c2FRepmSrLVqhqpWqbj+4/MtfB6D5q4XyOCkwu?=
 =?us-ascii?Q?UX9GDNhqWFpKUMudMS/jsbjubh8V6vmdYnSqwRnx4zU2WC/O8iMy0TDvkFDu?=
 =?us-ascii?Q?B6AcVxHkvsY++L1gy58RzRdLLLo3+qqkzvdvEaGWvjYC109/KfmF76FMO8QZ?=
 =?us-ascii?Q?0IVMbQgUsAbnyykCgSTZwcWXibUiDGHRDyAxWwWDErZw7LE6stvTHNA75Jrt?=
 =?us-ascii?Q?XmYcOwJkY2VrNejIs/b+75YPTx3V8htPJACqQc5OMrsIscwIl+MClJASiEPu?=
 =?us-ascii?Q?ySLncI9Dvsiu8Xe2Fw+5viXDOQ3MFxr8pVg+bGWZRuF4NrBFfmWx1i3bEb9K?=
 =?us-ascii?Q?3aEDT772RXEAM7qd8VP4USiFao7ddWuxQx10DnMssPjxG1nkWmWfzCu5UAXq?=
 =?us-ascii?Q?/gbbt4vhkLStQMkdwDfSRdwkNfJO04iG2eEK9U5bW70SbiEvSvvv+CDnzCE+?=
 =?us-ascii?Q?PzmeQjlbLQe+KFj2nXSkPbvIYWALB93HbKOrpRR/KDBwSQYV595KfzHZfy+Y?=
 =?us-ascii?Q?hUo4Pi3Zac/ratJTKGJZIBjqE7Ta/x1MKGwZJBewiPpb5TeppNAy5PEiWIm+?=
 =?us-ascii?Q?L+5zGRGGmutOeMrOe9YR5oC3SWNv50nNQOlVmUQMbQZIrqmTIK0oyO6JjUfY?=
 =?us-ascii?Q?arr6xsXyiVIVDy9IMX7zMRclF7igITqMYJATpamyldoxGKK6+4LyYB0eNQoN?=
 =?us-ascii?Q?w9b9+roT8LLlOJ5Df3kPW53Ux2+F5TAJ7pc6SXfBWJUF3Q5xGp7DpsiaKvqU?=
 =?us-ascii?Q?y/3p0U0UVca4PDTSUuwLAllNFzkB0hry50f9gszqPGoWnhs7YrwF9d62pcAW?=
 =?us-ascii?Q?a1/DlyndFBPWW3hKuF6I23v8GVVBO3gkaOI5nqCtruUtkHD7ak2unRTrnRpq?=
 =?us-ascii?Q?ZuLVaXA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:42:43.5416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b067dc-1551-4dcd-0699-08dce889c79c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991

In mbm_cntr_assign mode, the hardware counter should be assigned to read
the MBM events.

Report "Unassigned" in case the user attempts to read the events without
assigning the counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Used MBM_EVENT_ARRAY_INDEX to get the index for the MBM event.
    Documentation update to make the text generic.

v7: Moved the documentation under "mon_data".
    Updated the text little bit.

v6: Added more explaination in the resctrl.rst
    Added checks to detect "Unassigned" before reading RMID.

v5: New patch.
---
 Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 1b5c05a35793..99ee9c87952b 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -419,6 +419,16 @@ When monitoring is enabled all MON groups will also contain:
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
 	where "YY" is the node number.
 
+	When supported the 'mbm_cntr_assign' mode allows users to assign a
+	counter to mon_hw_id, event pair enabling bandwidth monitoring for
+	as long as the counter remains assigned. The hardware will continue
+	tracking the assigned mon_hw_id until the user manually unassigns
+	it, ensuring that counters are not reset during this period. With
+	a limited number of counters, the system may run out of assignable
+	counters at some point. In that case, MBM event counters will return
+	"Unassigned" when the event is read. Users must manually assign a
+	counter to read the events.
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..5a9d15b2c319 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -562,7 +562,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	union mon_data_bits md;
-	int ret = 0;
+	int ret = 0, index;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -576,6 +576,15 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	evtid = md.u.evtid;
 	r = &rdt_resources_all[resid].r_resctrl;
 
+	if (resctrl_arch_mbm_cntr_assign_enabled(r) && evtid != QOS_L3_OCCUP_EVENT_ID) {
+		index = MBM_EVENT_ARRAY_INDEX(evtid);
+		if (index != INVALID_CONFIG_INDEX &&
+		    rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET) {
+			rr.err = -ENOENT;
+			goto checkresult;
+		}
+	}
+
 	if (md.u.sum) {
 		/*
 		 * This file requires summing across all domains that share
@@ -613,6 +622,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		seq_puts(m, "Error\n");
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
+	else if (rr.err == -ENOENT)
+		seq_puts(m, "Unassigned\n");
 	else
 		seq_printf(m, "%llu\n", rr.val);
 
-- 
2.34.1


