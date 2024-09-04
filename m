Return-Path: <linux-kernel+bounces-316030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A5D96CA31
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F422BB21667
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD42181CE1;
	Wed,  4 Sep 2024 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VLFuoydK"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DFE17BECA;
	Wed,  4 Sep 2024 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488534; cv=fail; b=lfaBk7sOhPWOSaQDfDXRimxRUdWbGbMj/iD6ibx+atkD8Ub7gpCrRQCJK4Ln8tkHdDqh2Pz4EvdWAYQXALEJ15RP8Mk+/jMNii5UDI0yf/vP3OBIK26fJpeRfz4QAUA1lRnc99PWKvLd/EHfUIItpLRLLOfDFnUpIv7acWLk2vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488534; c=relaxed/simple;
	bh=fo3Ri7/uu01whB25ZmtGv0Fa6c3GyntYpNZFXo7rZ2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drGCTZEfTLLnwOimNnGUAXjpp8SUW3fK2ck+Jeq0hTU8c5rDkLjcAtS1nKjweak57SA5PHE25arL9gFSyv/kG2DjoDAnZ5gCcMNBsHOYoOBKI6FauT8OZkaHOBT+pkBskqn2ZsyUc+JsyoCcS/Kk6D0MMxdcHM1oDUMyoaMr1SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VLFuoydK; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLn9VvaGJQFkByl7r7ayzT8uZPP0+TaX4bq7Q1zw5EB07/wMuQeU6z2i1+9xHZ8azTuo2eo7Hh6cg7LjsOCEY7X3I4oZEcifjjtUPEk25BQUNQ3FSwSOiRglULcE3jXpHuD7XMSUN/Rqq7bEtiJ7szf3QkHJrwxICH8DqthMktdZR0gcyARqk04Mfv6+MUsDFcBjjKwMNvad6Rp70wUL6XLr3uIdmKIrnHheg1xi3Bl00rejOJQEtbcBVZPXJJuPH3jz6dvimueYT+n0ekUETgd/i//wLyhVf6YtR+b86bIwO+0AnSBGrKKK7kcAhlf+IjgVxcUE2lw4blWmbkt9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z27Zf2tdP3yxSUyFd7U2BAG1CsFuHQmPBsh5AR+yauM=;
 b=gHfd+HtfH9ZAZCKGrV4HQfB69TRWxfEBVnANhn5nSy0WGE3axAEHHi3yLOr4ZoOm6JB5rX/fQag4DahzYC1/2bDK9X98mWdKYT9if04dzhHQw79gz9aktZec7W3j7y2Ob9ay7zOR4SPXW0tEaVbwx0av6XaOoYHRAL+dtGscYNMFmbbDjedpmQ9huZnC+wVzl4q7djJ4rpAIDiUvMwl1ORn9dzI1rYvk06u+ptb6JSGHH8KyrzmCvMpjHRLghWjfvo4w8iMW32WV1OOvvK/fu9Ld036pN74RpQPUJ13vqmlm4zv7FrFDjxliXS/5Hxm/3btzpJi/gRxQR9F0CG+X2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z27Zf2tdP3yxSUyFd7U2BAG1CsFuHQmPBsh5AR+yauM=;
 b=VLFuoydKC1zMUnQQfB2WL16+k4B+vaen8fCCeJ9/hNpIBHDFqcIOZfPW9QGy91Dp1h37AgjB2mzsyThMHGeVY2t0uB7t5l+Z4QM0hGYDx5ygc4RFcL3Qg4bN2uxTg7ZHuCkRuAM4cqU3Cj8Ou1wRwUaU+sOWH4i1CDKLCrujBG0=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 22:22:10 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::8e) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 22:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:22:09 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:22:06 -0500
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
Subject: [PATCH v7 02/24] x86/resctrl: Add ABMC feature in the command line options
Date: Wed, 4 Sep 2024 17:21:17 -0500
Message-ID: <a08d9391f48252410ab084ab90bd5f20b5d4a4f0.1725488488.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725488488.git.babu.moger@amd.com>
References: <cover.1725488488.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: e22763fd-2471-4c72-2f0a-08dccd300488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KnuuauymIAhgLj4s3k/FZeg+R49acVVRXB5sReFPUQEd716mLrgYyCMsUxCu?=
 =?us-ascii?Q?AEri60WktXwkbvnZAPb33GJPSqSZmS9+PNaosaLCqJWf/4ftcTYoL0JN0WlL?=
 =?us-ascii?Q?3WNJRSueJVkY/NXeiXDYjacf5prdMEmJzjf0b5OBbAGZT8eIY6IPcdbpZ51x?=
 =?us-ascii?Q?49xFmadJvfweSAAb7ZVS9MddbCObsqAZACunrrUZ4RZH3o3HG3D4aCKbKe/1?=
 =?us-ascii?Q?xs/knK8jhhahyGAiwEX2LZxo1XZ8+a/IwUWv0wHOAzQPfDd5hS/3/5OMUO/f?=
 =?us-ascii?Q?tIPuIdky/R4jsgNyTJ0kSRS2mmLWi1+EICxvI+sWAVrq1NZIC3ymdBT0bO8C?=
 =?us-ascii?Q?DxGSrP/WOWfFRa7fZzlRPBy+Pmw4qOjKFQ+1stfVm7Fg0LCI/aLn1cZ0TZPP?=
 =?us-ascii?Q?yHYRQyBckzzLscdCv+ldfPCCS1Lfke6ldmUg8cfnGxAvt28sbfjR6HEjJNy3?=
 =?us-ascii?Q?YWrgHR8BJ17URhT7bXo1qu4EgB/wTz12ssD0HC+qdCgbI2LtycOwua1YWrZd?=
 =?us-ascii?Q?gWVSWV5S/+W//P0S9nhS7ZjsegDN+ngDYfPHLONqy1lCEhxBHOmaD1vZ2Q44?=
 =?us-ascii?Q?v0af+o7JkodiEj/8ZT8GguLFRT5iB6fnEBYcUR3RmR/5T27rkTOYlTovhwEE?=
 =?us-ascii?Q?9J4yo0Mi4KjBtO2jsnd001okxNfm/pFkwmfJdGhogroUdTULQiMuKTyEkZGZ?=
 =?us-ascii?Q?OHgeBj5gHkE7JvKuiK0ZWC8WrH0z13ai4pXFciAtLOhV5M9rhUqizNTlJtlK?=
 =?us-ascii?Q?EclEKh9lTFrx8magnszsRnY913kL0tmfw+ftSOXQUXvHpB+AFsw/JPk3um6t?=
 =?us-ascii?Q?R+3DNKJZKIolXK2lrDy4oUU1WYjxcubTnRxC7hwen2rrgAxEySXPRrofoqDt?=
 =?us-ascii?Q?I0nlsVksOXkTZllVrWgXR+OSkedsFXy9uVzCz+oEWacB5PFF7xgVzepOFsls?=
 =?us-ascii?Q?jAQB3oCWg/XbpC53ysAPIHgpC1uTQ/VPccore71QvLiEPAasTEvbHmQTY3uC?=
 =?us-ascii?Q?Wx9Q6kdciZyF6Aw14QC6B3v1ongJHke5yyz/NiisH3q/zcedIDpUDbZQb3vA?=
 =?us-ascii?Q?7Y4Y5jXkhgBWaybrwA2IOIUpQW6fneJPzS9BQ6HCBAmyFh9UD7EWc28zlFF7?=
 =?us-ascii?Q?zX+SsiRao/UgUcQqkzOt1pQF7v5XHpLwWBr/CO/4cPAMdQUZfatYzxUeleLj?=
 =?us-ascii?Q?v0T4b2u4L1kg5+kJc28kBy6/+di9lJZqolXPyQCCA5sd2BlEIMMrV8Dz9Ifu?=
 =?us-ascii?Q?Cx3+WANp4hIhF7veIr5AxnTRaiIXDA/rbeC8Gx+WIjqgnLovWKQumjWgSEYI?=
 =?us-ascii?Q?XT3gqeRrgTq13WVzDfweCcRty6/CIHyBvPjzbSE2paC3L35dV9G+phcFpn82?=
 =?us-ascii?Q?p6WwILWAJZGKAaI6JQclANHtw0nJJAgmNd3JXYaJSkNHmF2unPlIu3kwCTFr?=
 =?us-ascii?Q?+Yu2s1C4hurynODfIpVFjHEGX3jRe50Z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:22:09.6363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e22763fd-2471-4c72-2f0a-08dccd300488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741

Add the command line option to enable or disable the new resctrl feature
ABMC (Assignable Bandwidth Monitoring Counters).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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


