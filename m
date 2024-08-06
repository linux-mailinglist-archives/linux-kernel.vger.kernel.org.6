Return-Path: <linux-kernel+bounces-276981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE6B949ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20071B249C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A2D175D5C;
	Tue,  6 Aug 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3n/h0tRY"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A48175D49;
	Tue,  6 Aug 2024 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981688; cv=fail; b=D1u4Iv7Hj4MQ8P85LTsIo0JHKpk9CHlm6NLV9OY2TJl7RmTe2zL4C2P+GBWs8hQt/C0wZlEWu61wnQM26Z2tPL6Imw47U80/EwJvYNyX2USgVLxccpYmFXbqLVyQmWAu3BfSY5YahphF5PNxqiBx4SALZQyFjhJppbjrM2adzDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981688; c=relaxed/simple;
	bh=64i0stlMlNtrUcFXypFdFgjh4lXZANJHVINBe7qWXYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUrpfGEGSLf21IhMslS3Pvia42UhISMVGLkdJoApG2yjsKLMZ2BSgpKRARRrXPV5nL9vu8UTIo8FldCajC0ILopyXg2C4EjsqlNymy18QMZ+NnBOpYT8ohv9p+17I+PSCNMOdz+FRrFAbwHddIhuawT+UF1dl5BlJu4VkfaWFow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3n/h0tRY; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1D/RGAQWs6ysdBH2wvC74ftYWHfSF5PFJ/x7wRRHj834VDyI4JJ2nSdOyTRVCV9tqNCcptE6pn1OXfSysCOQfRRw/nTvXhZIPLOcsGvVikYas91iSbk6QDkAR4+PRUVFoTIl68UwrTtMNPfrphVk0+KECQobpu4FMn8e0TK2gwXbk9GMggWq/Zs2JfxuH5C3+uypXDKSFrdvbVUoEenJJq6r6TLFDle4m7wBAX2fCt68V7574DJLcru4Q9J6EJhkQie/VBsbS5EGpnEEfIMI5Ri3im3QNl/DGLcIoHPTjIA+7VdcbXxlwTOJlhcGhc1XHd55sTP2uxG01+DFWaHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTocGwrdRAYMvkHNg/Y9e+x7YokfWdg67s9eErxQn5Q=;
 b=Ow+9nTJbiYMh+iuwGahSGRXIDj7EjmEVjVXOBpBrg1yPwovm0b5PQprdqF8VMMDyGhE7nlNIjBPLPPgFvAFl4O6qSKaNfImq/zi78qxgTCmeFjRM7PXCf9C9i3frzZsP8Y94Q9cZGVvNsREp+yuuSYX19owVaexzRcHKtWg3kG2UV2/Fuo/Evh1n1lBNkwZw11ZEOa63Hue4W434KpkBzMIoXJVRF9P4jyOsGNwbeGVd4jqjL2yYJg05MfdDRSU7BYacQyLITecdhFPv2yhtw+byEPjLwGus+wsHS2bwBr3KGhEUxGdBgb6U89kyC5wfYrp/cMq1hz/MJhGx4mzKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTocGwrdRAYMvkHNg/Y9e+x7YokfWdg67s9eErxQn5Q=;
 b=3n/h0tRYfrAfRmlQZ2YjH+KwN1aAGFcalmkj88uEGnfbVoctC0kRDqD7YrE/NkbRZ9lYx44KXUKtnrvK/44ZTA+hUh0IlWOt5lmvRQsyVkNhVPVPygjtfnKy7cnHWi2H1wQraHTrDKNSRvVnz0QWTIas5SuG/YtPE5sYrKo4h3c=
Received: from SN6PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:805:106::24) by MN2PR12MB4237.namprd12.prod.outlook.com
 (2603:10b6:208:1d6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Tue, 6 Aug
 2024 22:01:23 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::5e) by SN6PR2101CA0014.outlook.office365.com
 (2603:10b6:805:106::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Tue, 6 Aug 2024 22:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:01:22 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:01:20 -0500
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
Subject: [PATCH v6 02/22] x86/resctrl: Add ABMC feature in the command line options
Date: Tue, 6 Aug 2024 17:00:39 -0500
Message-ID: <b98fce7195bf25fa2773cabe7c27634e9718ee87.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 153db038-a8fe-49ef-44b9-08dcb6634f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nhknu9Ca1AGIeycVn1ubQZG8IjinDjRt2MHjGJxIxNCi46BDH/crZ2Jb+74i?=
 =?us-ascii?Q?C1SzER54ykD00PXRULW7Zz0OFu2KnyPwOSrAPBouKp24ODC1MPSYNwZYugzf?=
 =?us-ascii?Q?b+IgvhMryXfNI+uITjY7sYQbaME+MdnwQ5fM1DzWx/MC5ZbV1jEOElQ8qfXU?=
 =?us-ascii?Q?N2H5r3K6SXmmye6cm7idrlpE+l3J2qDFf4RS+0NGk6qTlht0vHpvufWyDkTp?=
 =?us-ascii?Q?p6W4U387ZXmKyMTTHB42OZXshRDlYZJLZUWnINyUyv/p3lLhT1uzsQojR1j3?=
 =?us-ascii?Q?184Mmn+5rkQQ4Ap0g8f2ckYhadKChQxwZCwBLNsXeHd4pVvTSckdNNWLbT+K?=
 =?us-ascii?Q?nGTqEuZ1Xt1pWHuRF+sPqDyeMWCtdV+4zSEfj+KEXDpJCaK2JoTSnNvk5YTC?=
 =?us-ascii?Q?ZswuNpDSXwMT1lwkxKLHShPMNzJuZYP51UKiEwN6Tyeo8AcIFw4Pw6qEfFPG?=
 =?us-ascii?Q?ldY48ZkZupoIYR+Aa3wLa9s7xNrtisw3VcEdjwudATDYzpKLaC+XyMQPPm70?=
 =?us-ascii?Q?zSDl1i1W/KLcM7JPMg1zbD+6An93LGoNr7npD1ELL2riZuZ3yr5v+JlZdmv8?=
 =?us-ascii?Q?KUaqMTSY2l02L23EvMQl/41kHYrYbzzgxsuJvkG4PKMo+BSarJAl7QjCMD6K?=
 =?us-ascii?Q?1mgvhGqNDoAsehBmvXct23e2UF3mbdzvHaBf5QNnvaGmqt5k251NY+4g61RN?=
 =?us-ascii?Q?yLgK0AGeaX0EZE2i7caJiNA+cY5pqeG3cQNG66FPPdljLLJI7rFoGt44d/hs?=
 =?us-ascii?Q?6e/+lqRhwYhO0tHT1R66QgnlpxVSiCRu9r7Xkdi0WoMoS+bzt05pw+ryvdpp?=
 =?us-ascii?Q?+HiChGbBr7lZ8TYzBgYqc1Cr8VbkRjDWztiDXnWEUWjHLDZVwyUye64/TbKV?=
 =?us-ascii?Q?BoAQ5DhKfdNF6iEalfohD3icfKS8IQjz9pNXTnYPa2rWHx7+4aqIi8qeRue+?=
 =?us-ascii?Q?TGNSneCnlXMRxSzx54Wa9HN7CF0F8ibQGbALhaxoU83qioB2whdSgelanW1T?=
 =?us-ascii?Q?SQKZvjINq2NIZG1SymdZcxVGWQ1WKmaHyjzkeBCeLZBVOL3vLZpKCLHlvI14?=
 =?us-ascii?Q?TnGiNXn4EdtwCPntGD3RuD2/ydsuOxS9c89Q9UBOOwXRrgPPDTihLVK07N2v?=
 =?us-ascii?Q?CGxYiBrXdoN6QPl5EL6eoYboCFYQVGKsChbf2Yyn6Zgcdx4ns+CyleKEetvR?=
 =?us-ascii?Q?rK4KQA4UrXhBB2AnllYaHeIBk8AXRrm3NxF2OAapLks4vPjILXq72TcScjpD?=
 =?us-ascii?Q?o64Q8ZGd6lTNsEJmoUihGiVT/UcnUi+XcO7jqi46zB6UpdueY0yaaF5OllFk?=
 =?us-ascii?Q?Xml9jw0W5EtVmYdt2YKgwJIW51Cr51BByqpiKJIXZ8dQsJV887cUbWm9WgyL?=
 =?us-ascii?Q?vZvymoHHi0rBxyoQ+zSIVokyZJ3MZuir9jCl9h7o/2KUed4jdzk8ToitbKrM?=
 =?us-ascii?Q?isYC2mIJFg2/zE0f28KzjlHZP91s2tdl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:01:22.2396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153db038-a8fe-49ef-44b9-08dcb6634f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237

Add the command line option to enable or disable the new resctrl feature
ABMC (Assignable Bandwidth Monitoring Counters).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: No changes

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
index 09126bb8cc9f..12cc0a26c82a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5604,7 +5604,7 @@
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


