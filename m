Return-Path: <linux-kernel+bounces-357609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E514997349
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94949B23533
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141F61A4F0C;
	Wed,  9 Oct 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NeQLhjqY"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56091E0DAF;
	Wed,  9 Oct 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495630; cv=fail; b=Np9uog6CkpYi+3gUEDB84jfxuGHnNt4iicOesFJPZlJoNolp2ExjwO7TM6shJfKmk6e+0m8rIShkqYwIAHzCICYhQ4y+50lbpcFmR/6PI+D3Seo8HwyHuHMzZgvXied2mMbUVrDwP0KgOlsKUptHFxCNJrWvdpofSb2ZGQNkPHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495630; c=relaxed/simple;
	bh=I4NN8i1sjzhSnsYb2HBT67gF1okYyT4exWDeHTELKSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7jTAy0vulrgjHRb6YqVP8ZmMhpsSBiSw5gtc7i4Vp22Z8SfLH89EmkH1dWEFcqdK7xKP3JDJZksMOSdWa2PVKOPCMd+gty8yaRROvo7SNqT8jr6UA2R1lbGlyFCkwDLtcy9KkspemKqXBmziAZ9wMtQ6aF36csQiIYe+vamEKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NeQLhjqY; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz54MFtycJtKlUyfBPUkn3ONtpCit4lR1T0bKlZkf1aPiOK/YCeqg22+O9yVQAX5+aJOIoaydZMNF2v0z36S3lngdHetbJ4W+YOlLuJRTHb9VHOqcy1Tqa3d4lQSWhqG070Tu7AuPCNrOmVsKgYO58oRivXkiMQYFSCRHFo+Dk/QWHwc2FSTERs++C47j/eC6wwd8wOGvuYXko9Giap1lyymGRtDYFAwmchGhhQ8TZXnEZ5mCEPT+xkGp8BBmzfntyajEYICqgvCylknuwbtF6XwTSRR/SrsnapMdLJlaxW+qiEKyo9tfgM6JmCq7f77oNBC6IxxEfrxZA7veBcwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1AEeRNQzKG9qu5cDjxygzIcqOydi54hLdsycK1NSJo=;
 b=d6AJzh1axk7a8RP1XVvvBuBttIDgvmS5V8vNPuTyaHkMEuyXSzpNC/aQn0T/2RHCXUHXjN+SGbBlOanRXYIi9ty94tF/NSCZm2C2aCXNc7tlLmh1dXfBii4yIHBYCNIuaMp22f2MrBnK4XvB2dWstBLbechefdBE3jIfyYojXvkxmQ5/7JkjeH0pjmAPkBZpDJKF7C6njvEHijYSuq65dyHw+toQ5wzFT5ViRbYb2pO9M9eOp4xqRbG/qMA5J4fXQu0gA2bLoZ5+d2Zgqxe8UyAlly/4bqnLyO3X+VX/E1yGj/sJiwwkey++Hgj//f2Sz6xAMTBDrABECv5GqiOyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1AEeRNQzKG9qu5cDjxygzIcqOydi54hLdsycK1NSJo=;
 b=NeQLhjqYpe2i5e4V+xLsblUKioskU6/JejPXIb4UpW5pPRmiCv1IQGrLCDQtH35pftU6aMkXhtbaXT3Yk+vXZA41nT1vrRrouDk8I4T5g/HJymHCOcnBE5VhgjhjUENcDNPqqoF8BqAnny++Z120zmpLHXa5kYh9LOaYPLEeu7o=
Received: from SJ0PR13CA0124.namprd13.prod.outlook.com (2603:10b6:a03:2c6::9)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:40:23 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::ce) by SJ0PR13CA0124.outlook.office365.com
 (2603:10b6:a03:2c6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.7 via Frontend
 Transport; Wed, 9 Oct 2024 17:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:40:22 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:40:19 -0500
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
Subject: [PATCH v8 02/25] x86/resctrl: Add ABMC feature in the command line options
Date: Wed, 9 Oct 2024 12:39:27 -0500
Message-ID: <4ad8817bfdd13e048f93b5868e888a799f8c538d.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d241f3-16cf-4730-0ed9-08dce88973b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fDi2Stg+hhqMR55KdoVxAVam2i/lPqiHMkntgIZOa3Q4b+rXBr7nJCPQIdjV?=
 =?us-ascii?Q?23Wgg1ueRqsVEGyiRSOJHS4ZJnM4ZoaXmeEoq744AsTH1qmSu6uaZukREaK+?=
 =?us-ascii?Q?Sf/oWSVHPSVzNTkOUeVrqYisr8gitZm/m41hHaKqjvc/MWG7M8ASL3da0XD7?=
 =?us-ascii?Q?IsK1Z0G2y5SZ5nhKLyyVc4rOcpIxY5w1viw4T8eVjYvgyHGBYcpAUN4T38RH?=
 =?us-ascii?Q?wGKaj85MTLoRleh9ouFwqFADS2l9vITiIOdkve7tHnU4syTzQFSXrXirb0xG?=
 =?us-ascii?Q?DhJcUZJSLqt06vz7GbSICcq0cj4cH0l88iHkCpNvn2Ym96EpMyzWBfBGqUpj?=
 =?us-ascii?Q?9TEu3/L2Z9g1ad0Wx/w1RRZd2YtErShu60J+sold8Pv0JkEqLMP4M2Yzll5C?=
 =?us-ascii?Q?7M7GVGxaHl4wGu1TsNrUiZLraZVbn71hVZhnv8FjtREIBCsU1AnGuObNJAPb?=
 =?us-ascii?Q?zAXhGpF9IxIu9sGUmi0eCmGoLPigw7v9xuhlyhoTfGzSdgWp/MjpZpgsVJBd?=
 =?us-ascii?Q?ZcpQ1c3msA/nC4/uXK1spTdNbYGe2W88EzJuImOhintm/27RLezuK7LXNX5G?=
 =?us-ascii?Q?QxSrqsiNO6AV+ibSopx1hznp279ywLZlNg9WeXyoSn/EEzA4nYjp+dUWvVC3?=
 =?us-ascii?Q?BtSO8lbFAn4gIbGIX5I+7QcgqGhohE/1p6mv/M1R0N3huAj1ul74I/L1NVvw?=
 =?us-ascii?Q?RgE3zvfiRlpXKL9JfE6ot7li1eMjxWz/JlRjS1jpokKhk7qW1zK6qqDeUM1v?=
 =?us-ascii?Q?qJ6LDxsQrSgOkrPfqXV5AyIIePRaHtZDcDmfZjb/pky+9bHi2l08w3+Xaew6?=
 =?us-ascii?Q?vujkK/DPZk0DSLYdE28asrMR9vSl6+/BHkAH9cShPQV+Kx4UhFyZss6tjDUk?=
 =?us-ascii?Q?FAMt2Rx/Rx5Xjym0lrbz8rM3fmi4xqRpaG2ObHoaK9WaoeiCOKJtqoCcDvEz?=
 =?us-ascii?Q?zQcQiDUDw5lhM23IKeCDF0cqK/1A/Qz49pcxZMT9jnq5HPDtEAG++1vQezwe?=
 =?us-ascii?Q?J24U/b/lZby84exlb3wXmPF7jZWzti/EmSMr8oveB35G/EJyNupVnhU9t8e/?=
 =?us-ascii?Q?jqMLDMwJUC6C73zF3YhmggvTRCvLkNHV9p8KkGMGYNEU6L6VKRqn+o63OyIr?=
 =?us-ascii?Q?YInSX+saDI87FwevhYznsy5lmd1jU7waBTlu8Tyvs5NACNQYxRtd730GQfk4?=
 =?us-ascii?Q?kFjI9CcfrmD48vOr1qA/8bjwy7XyZqDISZVOZ4xwD4rzEkJ9v6GNESvOEu6B?=
 =?us-ascii?Q?Xy40lWk6s+co4nR1ePatn9NllDuq8jIRJJH4idtdkId0B34KjRm01gbggcSG?=
 =?us-ascii?Q?LtVSiIEPTXBBnKtTnsP52Q//iWaRdAfkAh9Dp0Y6fb9Xs0JE86cfah35+4n0?=
 =?us-ascii?Q?lf+LsPhQj7A3spYPfKkQ1d+Jim8T?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:40:22.7639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d241f3-16cf-4730-0ed9-08dce88973b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285

Add the command line option to enable or disable exposing the ABMC
(Assignable Bandwidth Monitoring Counters) hardware feature to resctrl.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Commit message update.

v7: No changes

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
index 1518343bbe22..b3b3ca564220 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5677,7 +5677,7 @@
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
index 8591d53c144b..668148ceda0b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -809,6 +809,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ABMC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -834,6 +835,7 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


