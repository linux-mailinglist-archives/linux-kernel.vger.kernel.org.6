Return-Path: <linux-kernel+bounces-240265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA6926AF9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F058228329F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514319B3EC;
	Wed,  3 Jul 2024 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sEEG51ZK"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B640194138;
	Wed,  3 Jul 2024 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043455; cv=fail; b=EpKhMMSeCufdXxYvA2rr4YbiHJi2GWKRkeAdu9m7EXelMkmk0r0ZqdqYfFCtnZ49F4/UlQJGytA67auUI/ZBnMceNKmESEJ8vvf3vqPwa9ZgZMPurQrjyq0eSH2ng1EzHO5TEdv8GGLRMHg/eJCig9luHInFDHh3P3WPg3I8v84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043455; c=relaxed/simple;
	bh=0E4jmm5o0/08fu9af0EbfKH4+M13JiFEQBz9QMfNNWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6EItQgBWyZU4bGEO+POOvlzVs3reS+EgiMybmp4qY8xhTBHi3FYksfUYMhCr1SORgmLgLspSVY3/Bc4G5p0Uj+Vlek5eGpiBjHJTsWafu2SOatxLAivfQAndbrVGda965mFcJFdjYEpxm4VBfVO+fRyo8Ck336vEn18ZRv7mak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sEEG51ZK; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO+UI8vRcxBi60cU8AlNo4Ljh2Zs9qODZG9YeD/TO020++4ovZod76eaXIUgxxF+vsASGJ2mCtcVFl8bnRIlQHO+vlMb1O6lZw0d8CfGxRIS96lAoWgdyV/RmJclZYmRSAZg3ir8FgncoJykmZztMPTuHYiVaTQgEc1HFcRnaUjopryxwtOlkhnO6MpoH7NFFEgHBoZsyaEcdkkIj4mQEhER3fXiB2JXFE3WXA58ynsmOB42y/1Y+j0jFK0h87UxpSuRqjMEj8T1jjfLVMGEujdror2jf+TET/TZrHGjIs/d9xwW5XjEzNxcPqPyNgk2CEfUQ0iBbB8iEvKpWTvXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNLee2lvEWFK0kue5F6Eth46zv8Zkifo5L+rpe3Lpmk=;
 b=eLhL749eTF3QdB3AzOIlZqGA1nRZl9Zv5EHGxquFBtbWZOpHK5yhyyXW7nzOhd4/dISUesZLzWcj8+vVbGv0vt4PB7dbl70ovVhiauxdhyj8tSjFqCZUT5vOZ53V9VAXskm/EMSqtbQvreyAsDS6mOsbsL05e5mhTiVmloqkrw9AbldL3zOvk0C82eP9PoEgM+E5SCnrpm1EQoe2xfBD+VZx+cApX0CuaKJvU8mflr9tWIbXY+mgn0A0eLTfQBcyxxDM5r8wi3hKEgJgvCaQSqD61RwPRiu2ko7uaHQWj5tNBPT18zGNDRNpQ2Yl999sPjPt2zAFS3FRs46pxdnDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNLee2lvEWFK0kue5F6Eth46zv8Zkifo5L+rpe3Lpmk=;
 b=sEEG51ZKX7Quv9OrSojCj9Kndf7nWxoZe9OKc5jih2ccod4KdQJsiFkOVYLNVKOKAfMocpUa1ae1/Q8Vc0SVdCV/RO06Va++GIPO7Ga7FmlCwrc4sMjMWFQ+wmaji+l2ysF4Cnodd15uQ9qBLK6g2T0s4MsWo0Mo9OEjSS8eETw=
Received: from DS7PR07CA0019.namprd07.prod.outlook.com (2603:10b6:5:3af::7) by
 DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Wed, 3 Jul 2024 21:50:51 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::bf) by DS7PR07CA0019.outlook.office365.com
 (2603:10b6:5:3af::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 21:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:50:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:50:49 -0500
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
Subject: [PATCH v5 16/20] x86/resctrl: Report "Unassigned" for MBM events in ABMC mode
Date: Wed, 3 Jul 2024 16:48:27 -0500
Message-ID: <81ca60c0029ba63fab7cfd6903ad115fad1d29fc.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba7b62d-e230-461e-177a-08dc9baa34ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TFXARq2osde6/ctSjBvOoVOOK03V6gwNRnkPvheuSkb8Yy715XSHPpHHY4IP?=
 =?us-ascii?Q?4g7zDvD1gB41dttDB9mTI8WoG15Gmh+QI/lodCDnAkw5XbsK9I7V8cSM+0i2?=
 =?us-ascii?Q?XPP8kqeA2Ujrt7kXqGoF5s6j7slGpS8eRRcu1NNa+TkV6CUyWC83OfpCNZ2o?=
 =?us-ascii?Q?KXgOgHKYs/fIZnInOb8cULdJLFWca65syTeoZXocwHigrgROO/85iRNbUZY0?=
 =?us-ascii?Q?knuiFI86DfuRynEF5Y+Teo7T7P0ZN0Bb47ZGq5vHZfdUGbTZDYfyhk52rbkZ?=
 =?us-ascii?Q?UoopNTZspHOu+sXLz7+MJwtMka9S5qZM97UyAxfAit6B0wxjmu59Jc3ugr0s?=
 =?us-ascii?Q?YP4MRnjjmjaBwKPl/vNnGajbJT0PWCv0+fGN+bOKmACgsSCi+Bn7LI8AtesT?=
 =?us-ascii?Q?rwP2Yi3SUEERbbfk0FFEMvvuKJzNPbQu8mNIv4Xum9EceaS+JqqE1K7cWo5M?=
 =?us-ascii?Q?H8Li9ErsPFJBEaoz3fQFys5+66Nhz3vKlK/keJ8SX8/aB1HJVEELmJii8aqs?=
 =?us-ascii?Q?HkokOUWWk4PHroyoR7xfB6qiIPNviSchpvBVkOb8XHVuYQjXGpTnOgARPbGv?=
 =?us-ascii?Q?QVDQCr2dfdhNLPftDLaxRet8NQnxoAyYz2mq7zUo9/FbZxD2BaZTB4MXFMBU?=
 =?us-ascii?Q?sY/KGDmYUUXt8y5snxZyLb7b5w24izdM9IVEvfpmCv6ofATBmlxfIb+rw9nk?=
 =?us-ascii?Q?fIyTIJSyS+U+p3X21Xtvtd9bFN39kA/rcjwO9ZkamopLlPfl48S7LbQtLQdg?=
 =?us-ascii?Q?K7PxJiMqPqSShTNkMGlZJlX2N6ofOcIzCSvz3WgbWcwz6vnEj2vaeLtoD79v?=
 =?us-ascii?Q?PraBuqZdEPdBdmMd4/8ySe7TrGeHLOYtulbtn8iM5oYhOXZRq5gMPmdnXLm7?=
 =?us-ascii?Q?dqGcp6cUz8LkqhvHWAlWl6zXMBOtfdW0ctHHpZEB7AosaIVlikuu2D6e4rY0?=
 =?us-ascii?Q?QK4cXGUYi+lpkWxT2bYmQelTb0VOnMCwgrXGwemXJhOgmw6wvuLd185Ml5Ic?=
 =?us-ascii?Q?/qKnnyF2ekE58huq1a3Xp6ka7h5HSj251W2EEQZlhS+yodPN9hS5n/kNHEjR?=
 =?us-ascii?Q?w3ksxO1D48kkjJL3XTCgPC3YUo3HD4OFblLPYUrJkcVWgItbtM+WZZoEExug?=
 =?us-ascii?Q?wmVq8XKVZEF3Xe32oxNuZDKTecCiaYd1A66iDIUFXIQaQJSHQRusO/Zo6Tta?=
 =?us-ascii?Q?I4Y0UiWDNGSopXOxP5e2YxRSVsqL7dCXCveZFJGCgfn5s+j7m6Q05ffj3w7b?=
 =?us-ascii?Q?lOUeVzXA9g3gQ8gVCJnaroSa94xKNMsEwLB0kpPCzGId8XiqxD8/SjTucbfB?=
 =?us-ascii?Q?lLcBoJeoSMj698+hR1T+csGkx9RVVY6V/fX2/9VeoIah3KWjoPEUiMw+XDCw?=
 =?us-ascii?Q?MLOko8U/LxDpHsoeDeTSTe7CXEuFh6k4wJRDWUZOCotZiWlaaF2alLUjuu9t?=
 =?us-ascii?Q?a1DfNGJ35YdHHrukbpYDqOrF3oZSvTRX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:50:51.1079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba7b62d-e230-461e-177a-08dc9baa34ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421

In ABMC mode, the hardware counter should be assigned to read the MBM
events.

Report "Unassigned" in case the user attempts to read the events without
assigning the counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v5: New patch.
---
 Documentation/arch/x86/resctrl.rst        |  4 ++++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 ++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 4907d0758118..11b7a5f26b40 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -284,6 +284,10 @@ with the following files:
 	until the user unassigns it manually. There is no need to worry
 	about counters being reset during this period.
 
+	In ABMC mode, the MBM event counters will return "Unassigned" if
+	the hardware counter is not assigned to the event. Users need to
+	assign a counter manually to read the events.
+
 	Without ABMC enabled, monitoring will work in "legacy" mode
 	without assignment option.
 
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..e60b469b7d12 100644
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
@@ -609,12 +609,21 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 checkresult:
 
-	if (rr.err == -EIO)
+	if (rr.err == -EIO) {
 		seq_puts(m, "Error\n");
-	else if (rr.err == -EINVAL)
-		seq_puts(m, "Unavailable\n");
-	else
+	} else if (rr.err == -EINVAL) {
+		if (resctrl_arch_get_abmc_enabled()) {
+			index = mon_event_config_index_get(evtid);
+			if (rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET)
+				seq_puts(m, "Unassigned\n");
+			else
+				seq_puts(m, "Unavailable\n");
+		} else {
+			seq_puts(m, "Unavailable\n");
+		}
+	} else {
 		seq_printf(m, "%llu\n", rr.val);
+	}
 
 out:
 	rdtgroup_kn_unlock(of->kn);
-- 
2.34.1


