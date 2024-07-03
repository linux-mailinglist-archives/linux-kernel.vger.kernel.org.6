Return-Path: <linux-kernel+bounces-240251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E358926ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16A31C24ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBC6191F96;
	Wed,  3 Jul 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3W2XY/Lz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3C194C85;
	Wed,  3 Jul 2024 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043345; cv=fail; b=ths1q7w5vBf1ZqW9kNiKFS+becowXmx+z60G5OPJu3p9/3N/MEu11lxPH5d+/UyvVzPJp98wWdPFx5DLZA+YtKB7jHzRxEmRCN/ndyr8c69AVTXpWZBB6fexJALk4BEH/FtNTbvMeTNJs8aGc/uzhlnUtOTEmSBV7pjQeg+ngoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043345; c=relaxed/simple;
	bh=tQT3kHBskIfSKApKtr7cn472lGe0F82osBAxmzozRGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vE2iKSuTCGEtuZCgq6vEEmAA0TZJVxL1WzZ5MX8ixbqU+W7PiHVwfCC40RVazC/RZ6D7tu0xrkXiqw3R3JGtHhv3gvDVo0PJVX8+SHGMMQvsyNfFm5glwKiJuePn+Yb/qR+nxv4bRnHJT/Efbt0Lfi2Zju7cLULiluqGZ7iJqTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3W2XY/Lz; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKujm/3DRS34JOUAAjSDfhunBY9qk+e8EFa2iK/NwLPmo3nfI731allixC5y7fGJL1YHjP9IavVr2hYLNKz7UJXqIxGmr43WucztOeOFbdpik9QY16Ro/h4DPJewqwClaYPcKg8UdA/aOkA8GM8EXzlXJEW8mM3yxSu0/7Opbasbh5HrKcOdGS1WRfHJdWf+tflddbI3wC6ecuwcFO089NbGQz+WcwD4+E8t7ov8AiHK5ArGf9DJNKi75WjuToyFY+XY16poIUWS7SkXWe3XvopSUZjHCm/WaAoh11kYugXb2QcmULADCfz1yt6X+P9q5mChMaGulWhl7q3xaHNgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/0t8fyR0+cqEa6HDEEYAG0LzrJ5syOg97hqt/f/DKk=;
 b=mfr2jYOOJgzopsl6cXcttDQXmHoko2eEujRs4+nE5mNTCiB/H6HE2eZm4/+arN6/JfASPSluqXA7/SZB3Z/g+NUmjjmiwGq2eY5M+8GdXvi8aOBeAqfVCdbVLSz3+FQfOZL/VT4p88aQnrUDWJeRW4dhxswfWzRte5xDPZwd0jWVCZaqGQ242SosFPNe9n+eD36fGb0WeiPQkqwSo3UXZhMHuhL4b0FinCWp7GsdYJBp7xvDVFeeSCtaYXYjtaMG08UMYe98JjQB9vo9bLAnu5X1nxzVsp4JzokttgSA6M3ogvEsD8N8GiDeFLeegp8qe287fCIbDexR5iviY0+WMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/0t8fyR0+cqEa6HDEEYAG0LzrJ5syOg97hqt/f/DKk=;
 b=3W2XY/LzDrngQ8Yqvo3TygLrq3kpW4k+MhBUxD8lFdVb+wUCmJzIvXMTNB/ryQ6h4iAvVn4Q5k/OniUxLmXnwp93OC+ADBkzoDRIZWO5xot/gBwi6mV7tpx7sddMD+y5PHv3O42CVbDuwnqlmzD6JDBFNwMSppgdF7r70SnZby8=
Received: from CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.39; Wed, 3 Jul
 2024 21:49:00 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::1) by CH0P221CA0020.outlook.office365.com
 (2603:10b6:610:11c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 21:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:49:00 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:48:58 -0500
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
Subject: [PATCH v5 02/20] x86/resctrl: Add ABMC feature in the command line options
Date: Wed, 3 Jul 2024 16:48:13 -0500
Message-ID: <ae823c5e4c6f41d24060a897d4a9cebf5f0d4d3a.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d720448-6461-4711-b87c-08dc9ba9f2ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JlZMS8RvAcloW3baGz1eq3xlXeX2XdQRD+SoErZLSDd/hgL4C/dS+f3T+147?=
 =?us-ascii?Q?J0fR4QrCxGTDiPx4L1vfH/MT77EvROxcTllAFdj4EWQnT+eC5nXuIwveT5LP?=
 =?us-ascii?Q?sFxrG2lGNXPB9J8shP8DC9tw0I3ZrNTlMOLhRNKitq6cTdXEq1520DW0rSOz?=
 =?us-ascii?Q?8rOfJI1n/XU/iObrpChpZA2fSB2ooDr7VPyGyWRB/NBa79l/ECEnSyYB1feS?=
 =?us-ascii?Q?EH9EqIR0v2pkDTu2ATu6W8eP8UV+Uk1Nk8rkfLA5gTC4XllzU4Z5DvNxdvHy?=
 =?us-ascii?Q?q5fko846fKMvWEb+ylfyteTrDJvhDJmIEyBjYz8C5zo1ETauAFn4e+hZcnGe?=
 =?us-ascii?Q?0DSqDF3QDdQYbmCuaCUYN4ggoLmpDMMtuAQdkaz7QC4/BkL+9tO9IwII4Q0r?=
 =?us-ascii?Q?IVPlMYD7mqewrEJOGZY7Hpp/w+m8PU5sm9+u20VNJvRVI4yJlqjeWTs2cW70?=
 =?us-ascii?Q?TXbabGayQqoyk3mw7ii+hQgc+gi8ZeoY6yn5tYYUR1wMS9sdFr9WCXxLA/sP?=
 =?us-ascii?Q?l70SyYfwEX8wJLHFUnHdRuXp1EPK5OV1+3Z2AuXuV1rmkYGA1aNmaAWd18Gh?=
 =?us-ascii?Q?tI/uFHL/UO/u+746NPdNSKy+e3CEaPYAlcdPCQ16zer+IaHqZNF5HxHE07N1?=
 =?us-ascii?Q?suZCxQylmG0sKDhD+Uway/9juqppdy0+52iU+i+qwMxp3hiLThDRukwJGjRy?=
 =?us-ascii?Q?T5IwxUvvFA4Tjle2H4xZ8sCfpK+6ZNHOyAS/tO6Ag7SnXOzaFIKVnXpb3FBu?=
 =?us-ascii?Q?RFfLdBmoDRNlyystv8/ljXPkBdeJB3gHzN9gqq653fpMRVlSZJrNj32gzjxq?=
 =?us-ascii?Q?ab7oNDJ6Jc27oEBSymg0+varvMzoYi/FWk9otvizifD+eyZ63SWmPC78IYfn?=
 =?us-ascii?Q?b6UCYl4t2aqfM9dZCjpl132Sid8NhyB1+O4lD68F6xoZ0mqlGr4stvVUOX2C?=
 =?us-ascii?Q?bQsoDg43pb3HDiwlP+a68MNsIchjiXz1tL5eb294l3hlJIBjK2U/z7vqaIzy?=
 =?us-ascii?Q?Uu5n712irNMwJqEbuzs8+5uvbbH0qmKUNRIiOSRsrcQZYv9ACdq4ua6jzYjZ?=
 =?us-ascii?Q?k8o55kcceBUlvidvTOZAemEcPlsVBnR5pT4zyGhQq+V0I6oYUUG8Unk23GmX?=
 =?us-ascii?Q?sJ5vfxYVv52PWmNryHdzn6kiY+IUawrmCfGl8Ga2w6ajl8ik2vFyYnw9hvfi?=
 =?us-ascii?Q?JWwseNlT25HjrBYLOuBeqMYZmIMT7yhv/woQOF+mqKlihteFlE4fWoNlPYjj?=
 =?us-ascii?Q?dPWgX1FBrS0o+rqt/QoWMz8iNwc6N9t+nmEyfW6Vr+dibYLAgIo/GFlm4bAb?=
 =?us-ascii?Q?6wZuLuU0Qy208E9ahbwQ8m65op76gVLRD92QAL7+7fa2fFuRKqJmWmB+hVql?=
 =?us-ascii?Q?MfRjanLtWRQ6riAHYQURH3ZRzKSf/sINv8YxWkx8C5fnucRxOD0o6WiCsymj?=
 =?us-ascii?Q?1Bt2vPReWQuiQvxbYcGZsNbeXXBgETAw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:49:00.6208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d720448-6461-4711-b87c-08dc9ba9f2ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435

Add the command line option to enable or disable the new resctrl feature
ABMC (Assignable Bandwidth Monitoring Counters).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v5: No changes

v4: No changes

v3: No changes

v2: No changes
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/arch/x86/resctrl.rst              | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2d6eacea85bd..291d9c47f74d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5597,7 +5597,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, abmc.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a824affd741d..30586728a4cd 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -26,6 +26,7 @@ MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
 MBA (Memory Bandwidth Allocation)		"mba"
 SMBA (Slow Memory Bandwidth Allocation)         ""
 BMEC (Bandwidth Monitoring Event Configuration) ""
+ABMC (Assignable Bandwidth Monitoring Counters) ""
 ===============================================	================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1930fce9dfe9..9417d8bb7029 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -801,6 +801,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ABMC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -826,6 +827,7 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


