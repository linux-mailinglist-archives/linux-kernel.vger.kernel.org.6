Return-Path: <linux-kernel+bounces-277001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C36949AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2F0282090
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002EA1779A9;
	Tue,  6 Aug 2024 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kV2sRK5W"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C1F17B41A;
	Tue,  6 Aug 2024 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981809; cv=fail; b=koQetwGIsi9ifoE8n8PEtrmxQVeeKKelZmI+6+bLBSlD5quqJqyPu4TEtJm8cGI3x1JdsG92Ypwd2dzwheqkWUsZ9BAoiK99+s8v8QhewI6NvirKm21q2dcuTAP+s5d/LN6uxjvbJRU9Ps8UAYI14wSoh2P5AeX4htcicBtI+dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981809; c=relaxed/simple;
	bh=1z43xcCe19W558VWFFZR/gULNawSj83Qmc3804+dW2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnBBHgWXPtW+aQNtx49swkmYSIzL4Nd8QTvi0MDNb/jwPx2g1+kx8ZnzA/msHIiwcq41Vr1QwoqeMrq6lO3uqaLaJTbB9eT2MExcLq8EoSQ3TiXrFVOGm4X0m45xxJiDQFZFEaL1YlbKM7z65p18DV2h6POg0DB30csvQQug5F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kV2sRK5W; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE/icdnXfjgJRoufzHdFVxkgbp8I7k3UghU4va/ZY+T+62O1L25TS2MUu4kGhg2rmDfu0izNairGZJNVaGZCO0907mYbh35y8e00Zm5nvdOS57MBQk+EyEh7wd7K2gileXWvRbD719TiiHjXmnWxmtmWiy6UpTfJ5b7HdmocEBGdk1oW8a9Vq/ItyYDifu78soeRSfStuqhxLiprW3pzaQIRbp/rxhAYlQKLil5yC+0nwdy95OnAAAzCjmFGAXuuy9EueBMiaKIE5Ms8W5j7n+vE9hEpPOvAJ3n6z2yk69L0vJcLpORzXFsfrppLVFJXA/ZWxu1Kq0WmgyDNloOl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngD9Klod5bPdyqwNWknmrJbwDt2Au2VkhoNI6hbNBok=;
 b=UXR5n7RyJNk2g0+fxNvlQjK8/PDN2+BoNzYwMeKYXLAc9Vnl1BZTSSh0w6vqWcLN+hNQp8/eBvHiC7wa52rtwOTfcsUhZl6mw6gwGdvmqafzFZK1zzsfNZQhz0IwH77uRp3hSzMk52tGrKYiD//8XZyUbwJOaBK2AoOGJkZvX/TnW/CcVwYXevofmw/pZv2LlWwSfluptAefp0blHBkrw3UyDldoFXjyjxQqDHPdy1BEyc1cHLdPtgVdHdQ7KEZnLapIZTO9LVfx0dHur6/z28yBE0QYjcZTdc1H6nFewveYmXGx3LvUYA4EYr6/b8019QQNreI5IzeunSa9EFKMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngD9Klod5bPdyqwNWknmrJbwDt2Au2VkhoNI6hbNBok=;
 b=kV2sRK5Wgx+PIKJNtg0RYaZSmq8xdyVwrGJEoDGpa6hz7K1brDQz5r18yeaNw5D1XFNV7H6NWBVB7NA+TBr5XngxOdz6AAWwEEWP/7bPH9UG2XoVMziRZvTaW/zyLsVWuC8pYmV7ZrULSfByyqKu6WaUqi3hz9LhwvOzU0u7LE0=
Received: from PH8PR02CA0016.namprd02.prod.outlook.com (2603:10b6:510:2d0::25)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Tue, 6 Aug
 2024 22:03:24 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::95) by PH8PR02CA0016.outlook.office365.com
 (2603:10b6:510:2d0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Tue, 6 Aug 2024 22:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:03:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:03:22 -0500
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
Subject: [PATCH v6 18/22] x86/resctrl: Report "Unassigned" for MBM events in ABMC mode
Date: Tue, 6 Aug 2024 17:00:55 -0500
Message-ID: <5906d1a910c5e2bceb680c874e5e391618f6e313.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: b62fbf15-d54c-45b5-1ff6-08dcb6639776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2heeY/u0lp5DpR9FpeCqf6f1jVYBGCHeb93WcyzSVplPFFvrCtPvsEOC02PY?=
 =?us-ascii?Q?YviypeUvhrwdvydJDk60PxJHujxbv3sz89Yz6MiiaPX/NVwguN9Kn1mHOuZJ?=
 =?us-ascii?Q?jSjhW5UkTOOCJzeqM37YMLr8a1ChFqqZZ7RhY6kE0pkq8P/2CHcDJnSJQc/O?=
 =?us-ascii?Q?es8YRFOFeYgm2GTGoZPPWEheBFsz7KzhZgG/WQH1+lgowrzreT7psSuIH/WD?=
 =?us-ascii?Q?0cOB/Udw89oloMPN2WiI6UQa+b9u4Ue/rolochYJWcMHoMkVIBCPLNjj4GWE?=
 =?us-ascii?Q?628QGB9eLlRPSCV5ONXGOFpTgKOLPRN6YyA5GtZgiRVxdlFGSo/V22yj9yZj?=
 =?us-ascii?Q?4oguPnQNfxazT32tA6djKc/ndixxBcwT9xXE96z1Ado3TW7MKNw9f3FDCsNT?=
 =?us-ascii?Q?KyRaQBKjT6MMF+okinfTlSi80nrWio/MGWFci6QZrSmBsXalcvh+kLbFlb/c?=
 =?us-ascii?Q?3Q4V4cjbXCGlZgPBOEdkwA+TWdHf2aaIW4Ep4v6gnJO/27SyUla7WS1dsfzP?=
 =?us-ascii?Q?JkeX9TOVqeelaAy/hAEzMKKwEmy5M8zHnlTd/KYB5h0IsyCOdOBxv8cMeKFa?=
 =?us-ascii?Q?oat26wHhHSaAyFtYiwjDqvMxwfr7ER5ecDdrovDdwvSi3ZSW+Ia6493VcYRg?=
 =?us-ascii?Q?lW859q71QBvNdFIIhOFWq7B0jaY2oJ4sbTAjtXkYPJRcfiQo8ps2/gtACIx1?=
 =?us-ascii?Q?PRFK0OxSVCp84X038kPQqfz+IKrTKnOQnEmau+oJqDHYMdPVhAYBBgxNDND1?=
 =?us-ascii?Q?a3QiVhOuqUzFElUVwNzXqfq7lYnIFbFjtCLU6dXHorXD9i7lkHsniU3Gro9+?=
 =?us-ascii?Q?Q8lvq1yyGgA4lblDROgglQH8a/goTjzUSoVJgYm8MMKGmN8irjrFTd9JylGE?=
 =?us-ascii?Q?oz0xml4BTAR7Y2sjHLXB+df7gYAogcayIQnBbfajjXwjstZe+X6Tse3wBhEE?=
 =?us-ascii?Q?R3s4kZpRHIDlSBcj1icvbAymWk+YwIrtEsHHlkq+1+kjho4+j+CU864xqx8S?=
 =?us-ascii?Q?b94TyWqI3PzTIn7HEHWQY/uBnKb86tm3dFbwTPq1+xHAr4ULToArBsXC6j9O?=
 =?us-ascii?Q?cUgHsOZ3mRIBOcP4AGMRexeP8Cs27bSvBSeQ3qzNRIAOkUqydsf7xEJpvrdS?=
 =?us-ascii?Q?xYdKyQ6Bt9H3FunfHHpVFtsblUYpU8LciHECqPji6RvSTf8Ag8cdrbdRAWqE?=
 =?us-ascii?Q?geCZy45S9lRwsAt9CZpwzrvGkBwh7IOfCPaV1dAf7whUWXVlSi4CidynYAv1?=
 =?us-ascii?Q?O+C9WispJLyUYm3e16HbNjcwo8mzHZ7EZFeMaEF1Dc7pScebjOlHTC28zYYl?=
 =?us-ascii?Q?YKP8AYRow/12Fdc3+c0aylHkIZ+e5R5nc9mvtNWZuAEA0prC/GSdLdpk+f2I?=
 =?us-ascii?Q?uhs6Bc4cbWFMWyI1w5XfIXhphvsKejsR/tGxRT6lSeoDyTYUAzETk6bPl4jq?=
 =?us-ascii?Q?O27PCF/uIlbg/ScWVVr++HzKFLoYHRAX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:03:23.7636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b62fbf15-d54c-45b5-1ff6-08dcb6639776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071

In ABMC mode, the hardware counter should be assigned to read the MBM
events.

Report "Unassigned" in case the user attempts to read the events without
assigning the counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: Added more explaination in the resctrl.rst
    Added checks to detect "Unassigned" before reading RMID.

v5: New patch.
---
 Documentation/arch/x86/resctrl.rst        | 11 +++++++++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index fe9f10766c4f..aea440ee6107 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -294,6 +294,17 @@ with the following files:
 "num_mbm_cntrs":
 	The number of monitoring counters available for assignment.
 
+	Resctrl subsystem provides the interface to count maximum of two
+	MBM events per group, from a combination of total and local events.
+	Keeping the current interface, users can assign a maximum of two
+	monitoring counters per group. User will also have the option to
+	enable only one counter to the group.
+
+	With limited number of counters, system can run out of assignable counters.
+	In mbm_cntr_assign mode, the MBM event counters will return "Unassigned" if
+	the counter is not assigned to the event when read. Users need to assign a
+	counter manually to read the events.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..ea918ce7c3ef 100644
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
 
+	if (resctrl_arch_get_abmc_enabled() && evtid != QOS_L3_OCCUP_EVENT_ID) {
+		index = mon_event_config_index_get(evtid);
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


