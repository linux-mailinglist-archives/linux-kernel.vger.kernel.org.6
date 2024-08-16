Return-Path: <linux-kernel+bounces-290030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D996954E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73F8B21F57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB391BF32E;
	Fri, 16 Aug 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QwIbHwDq"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCCB1BF30D;
	Fri, 16 Aug 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825013; cv=fail; b=Gv8v6ik+VVjPpKG3jhkA0RUeqo5tfwWFsKWWrQ6+f+dDtZA7Xl3Ut4P4QXdquKO0ihpTWEUdtYtO9iRWIuTNdZ92xS3W44PFyPgIxkO84JHdOlVSnH8PomxmN66nfdxvNje0L19dfmuDUHwTLA+gYUECF1E+B/dvluJynXsYRRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825013; c=relaxed/simple;
	bh=u0wbzha0SY4VzooY/1BDMLbwRhgXkQSYJe+Wd0TiXtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtqGwQb8tZVwsdiW+PBiQUwGk5h4KJeZuml+mwzMzozlZDz1CgFEocjAuRkMvUVXqZlbx+kOseszshI5sr5Cp8qXQMRwKFjZvjLp55+KlEasnPl9q6EEGB8vsx/xTbPuiFdYVA0Mre9Bn7hE7fuWvF6DMNObtlb3j1ziuLTIJC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QwIbHwDq; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEGi74Se8CQIi4ZfWRqQI+7rX3ylkLr4MgqGqCeTECaAbd7H5pAk6Rjejj0VCbCkrSlvquMEZLLQzwYHElv5WjDmyLKxEDKghXgJfrNfPLkKgkrJ6T7VEoR0stZ2Kg1djC8Vg017DJL3gEqLyKoy881QHCCCl4PCRPAHemuaLgaQGtLdsfh/JLHW27d3hQBEFRRmbidnM0KdQVTaKtb1k6ru9RiVswcd0dHMSjQzoCRK4pxZWFq5xMt9ukkeOn3SByA3zp0FvZmTnBxVLnzLN3L8+19foR0EAUSigBiZkd7VbMuP+QnwGFqBWb8Y39uGtxrZXzLui3CuvCWYA5OqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1whCGP2cH1RZzkfYdbNJMw62tWAvBNsk6J7G/rrBl4=;
 b=CYz5Py4bzQtXBAvQGJHCsNUzgtEYuk7rmlzDX4aFd1diXQe/NchhEi2qUm0E6sK1HlYwpV9+gnTyxCGbrSBCJ4AlpCS/rqTfqo+LswG1vhwyqbuPytllLqcVWxQZF1C/UaAzOpRwCz+Tw1OJ9GQ4guYaf55+Kk/Zk0YgwI63TSt6DwJSMe9qRLQncQrFYeUNwE9lQEX4sva+OFMav+HTljjyjNwm00BuWUE1cVI8OPrWtEgegccjrTkQA7KA1ITeqIEBsruBpg9XHYbQqaU2inJ82qdO6yXMTuE0IbyroVgCbUOuXKYqMTwMi9QQMrtimhdUKgy/lU5VYD7AzHprmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1whCGP2cH1RZzkfYdbNJMw62tWAvBNsk6J7G/rrBl4=;
 b=QwIbHwDqbrRSZhtelMf+ffCsiBWFfeX3UjJ3o/mgevN1MAZw39PYHliuFr1lg8H3H787s8UVdIgpD3heYCw7vRxLEmKwvDa3KwWmL1liLFH2GgceqYTkZZLEvznHn7AQ6iaO/AQ8zxSEA2AdEyH9Dla2cTB1n0QG1tdaaAJ8xIE=
Received: from MW4PR04CA0372.namprd04.prod.outlook.com (2603:10b6:303:81::17)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 16:16:47 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::9b) by MW4PR04CA0372.outlook.office365.com
 (2603:10b6:303:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 16:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 16:16:46 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 11:16:45 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<babu.moger@amd.com>, <ebiggers@google.com>, <alexandre.chartre@oracle.com>,
	<perry.yuan@amd.com>, <tan.shaopeng@fujitsu.com>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH 2/7] x86/resctrl: Add SDCIAE feature in the command line options
Date: Fri, 16 Aug 2024 11:16:19 -0500
Message-ID: <c9dc15428edf7164a1ae73f10348f3fc4cb9fbbf.1723824984.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723824984.git.babu.moger@amd.com>
References: <cover.1723824984.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: ac237447-d3ba-4049-c8e8-08dcbe0ed3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j5Y3621B3igMRX1ec5UgAFLeQe1wANJe/o2mbiR0T+FJDtZZtnoJ41KgpylX?=
 =?us-ascii?Q?lhKA+N7xjZs6TW6R3J0EuEUzJc+pitoetYTyTYGsA6auUAorWUU3zDgv7Suo?=
 =?us-ascii?Q?nesFEATpnsxc1bh4jFmmlpMaOPLAQFvuIISsIrTfLYIFdouTYBATmOYbq+fn?=
 =?us-ascii?Q?i+t4CGx9LMVNxcBJ1qnU6umWq045s0US6UA1VHols8+gyw49gTVBJH5oxKXd?=
 =?us-ascii?Q?a+Nfs6NZSb4JHirtC3QLomcEEMC82ZqkT3sUinPvudXQOfPq2opxp8PLjUQM?=
 =?us-ascii?Q?iyU4pE3+lFMfW23gFuI5REmlH3L458s67x0u3KJeK4t/CzjxhcJ5A+DjSiAb?=
 =?us-ascii?Q?lYiWaOeraglFugyZDQ1D/4/Qe3RU6hPnhAZDxNWkmvsD9Np36l2g7Aqm1yAr?=
 =?us-ascii?Q?y2lVqbcpx77zHA5/Cz+WBZv2/QoLODpVNrDlqGPTIdsopSyCynam7nV8AbTF?=
 =?us-ascii?Q?eprFSqo5Xsea0HogvzuxP8s/K/g1AYwiDticjS/QrqFyvF0K5Yaf40G4/xbP?=
 =?us-ascii?Q?cEQCMlhWCTdt49mmhLicEgdMZLDvC6LevR0j+pdfop7yOGqAPCeUH+r1yPTX?=
 =?us-ascii?Q?45EnAzG5zvMwa/1HithbyzyEf//cghRE+90m5HDr4G7hqAoOVLDLS6rc8j/u?=
 =?us-ascii?Q?QHOE3EtQW1ec1Z1Qjc87LeJDlFf+halA7FGUXFsdnclBqKgURxuF1pR64XhU?=
 =?us-ascii?Q?gg/4JrYjh1ms2dMxFwyVvRcUp/LB8itqJmNNX5wfeIug6RVA61kGPJqwuKCk?=
 =?us-ascii?Q?AYU+fR5ZZcBhyeZZcDMjBn0AqPlAegPnIV2CFlq7eNNhQdoOkmH9lV69lUyk?=
 =?us-ascii?Q?7GeQuaX3tWpxPCyB9rnWNZldF957OGo+r8GoE0PKHaTsE4E5/Q/vKf0aTDCS?=
 =?us-ascii?Q?uKsHqgaI3I5spvqpAhFojsPiEbip4LYdHjBEta7mEFe4A89dn6j4gnphkExD?=
 =?us-ascii?Q?4jmfNvb+yaaMB7AKjMGbbZ0tcrygCwZ9bih9vFezbntu7nbB8SmA5LSoERdR?=
 =?us-ascii?Q?2kYG8TFEl8fnain2ssiFKGbYOPuHOzHVUe9eKTfxJPUauqxNW3KrwD1FhboM?=
 =?us-ascii?Q?JHNjywzikPKZvd+wSfoc3uqDQI+jD2Hgk529o9rkVonswToOS2nB8TbC7vIe?=
 =?us-ascii?Q?isHXCs3H+8PHDWSaM3Md/PV3gUpJJf7Jt7AhP6W5FC2HZg3Xgh0QufjFh7WA?=
 =?us-ascii?Q?gKbE2i/RRORbCDp+oJ9N0waKAZ2yZre3hpJFT/5wFS5D1AVJtlN/mtmt4lDE?=
 =?us-ascii?Q?GLE9gdnM1fg8V6ZjvF0stUpyY6Ovq8vdmw8W/ttqUBBMxH8V1cQ2Uf+f6XE5?=
 =?us-ascii?Q?tR6V0OWDkl8Xt6Rja4KUbP5pM5cpiXSURfGJ3pKsvM3rxh+/xDo4cLpTeb8I?=
 =?us-ascii?Q?SuV9hM/QX+4byZyF6Q2C7xh4nxVTqDLIyYnArsSgvQZeqfXx/4yYJhkQ6XYE?=
 =?us-ascii?Q?dbvyxSJhLc+ITq2EdzcHmjnqmWySwOms?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:16:46.8356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac237447-d3ba-4049-c8e8-08dcbe0ed3b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882

Add the command line options to enable or disable the new resctrl feature
L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..63f17d23b8f4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5604,7 +5604,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, sdciae.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1930fce9dfe9..c4dfc768ddf5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -801,6 +801,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_SDCIAE,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -826,6 +827,7 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_SDCIAE,    "sdciae",	X86_FEATURE_SDCIAE),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


