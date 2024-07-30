Return-Path: <linux-kernel+bounces-268140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40DC9420C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84CB1C20906
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DAD18CC16;
	Tue, 30 Jul 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RzGvgMNg"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6418CBEC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368449; cv=fail; b=WntvXywCJbN2DZVAx3iOSEb4hoChGE6uV68CWP8SrS23SnVXdoq2pSfDqTfjO+1KYA9xn+jIf0Jcvuhfm6Vcq0RRfMb7a3jaFPYPSZVQbqcgWxUprX+SnZkpFWMNrMDzyg/0M2ZRVm5fvNXVlHhc8G/F38IjLMsmVNlq1OGlgYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368449; c=relaxed/simple;
	bh=Mc2ee84SgFyDb0h0mo9ws6lpRDIQ9SiKwncvWwVdG1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trYkQkOjHo2zoYanGB1xiika60XGkTH7OWdnwVW9QBUsnQtGE/C2i9szL+TTT3GoltjztaRHMJE5mZMAMblFsychggv5yU71uF5DC3inwWwVd0LkjtmbFdsref7XI6Z2JTs1JhcHp+G07jUZZd/uyCBhZvwBQ4XjjJnoRhfL2jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RzGvgMNg; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8aF2hMWzGmw+FIhMIgntJ5Q3N2pVOFYxY6BeNsnFet0MsBAzlZ7ofqPvG80ylgueMWOBCQQZIdPMTUqfewqOxA/0+7hv3fH58zp2K5+5HEfWORNqbLB0w7XAOR4U7du8f/27RYnAO/KDoVrMuo4McjIomKESthbWFe4rbMRODMdClutqexByigXN3vK7oQ/w7oun0+bHFE9CFds2LING0c+6DQ9wgWJ0RUZBifU06HEiuswi1YphJ/Cnvgq9s78k+b2aoZWGzphT0bGK8HguU4iIauPjPnB/vtHLDvbDSBCpqnRFVGoNf9YIqRmgqq4d8vCZ2AAt5Mc8xDQK7XzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmU7o/twtIG9evYYle3zC8IweScf8S3r74TCCRZ1WIg=;
 b=Hz64bIcr/5S5lP8vU2HdNDo/2wZz4J39W0b1zQuZGAgwYSgPk20iBjLjtmSnlPxmP0H0eqAj4DzGMV3MawYEH3/9gp4Bu5SoRcq0LvcO312a9Hsz2+KqqHwforaPvT+2lUx0Pp9COTTpaXUuc10ZZhJvvdA1y5bi/8VcOMRxoi+mZFeYFXvrz2D+D/D1aTunsNjnN9S3V/j8pFn0PEHFLiyns7cWiFDiznJq6xN7XRdr5Hs0/iAM6eTRwRQvRCkYOhhcghXJKcia9IpCx2zFG7or6T2uVKSwr+NTHf3R5lrZHcxqmBrdfPvdTdBVMyahMSUtoqCGVNRlrLalWCSRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmU7o/twtIG9evYYle3zC8IweScf8S3r74TCCRZ1WIg=;
 b=RzGvgMNgL/aJujWHdiAxptbPPKfAsx7eQtZIAZwz2rYNKHekAI5XThE15ZgvXH7b+Kuo1MtwtnvJMMs/m+Oqax02d7atRqJPNG0RtJS+gcfNq/TMq9/zOstPM0zjzslzHnX8h6T5bP6rvzgNuJW24pw/fT9L81YdDKq9cdtsrKs=
Received: from PH7PR13CA0005.namprd13.prod.outlook.com (2603:10b6:510:174::8)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.29; Tue, 30 Jul
 2024 19:40:41 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:174:cafe::b9) by PH7PR13CA0005.outlook.office365.com
 (2603:10b6:510:174::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Tue, 30 Jul 2024 19:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:40:41 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:40:39 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 3/7] x86/sev: Require the RMPREAD instruction after Fam19h
Date: Tue, 30 Jul 2024 14:40:03 -0500
Message-ID: <69fd07b45b63fde44a39dbae045343037ccb39f9.1722368407.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1722368407.git.thomas.lendacky@amd.com>
References: <cover.1722368407.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: d5679039-f4b4-48d2-0640-08dcb0cf7ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oa/gIeD/U+3K6XRHwW9FaCmSKd/NQonuPyxuow32JUa0RnOPq/xUh+QORRUY?=
 =?us-ascii?Q?pPbJJBTVm/UYg6deGJja13KNOWr5edndziAVNu8Yne4qPzdZwP5zJl/tSA60?=
 =?us-ascii?Q?o1qMMe9+mEkeZO1ARg/iHcnV/vqFCuN4jHiiK8a/4sjeAA1SAOxJzh62MmGZ?=
 =?us-ascii?Q?NWy+uU/5BDSe97cw3rch7lHOc5pqs8LC6jShPC2+W8lbqI3uFhNL3RZpoflO?=
 =?us-ascii?Q?84TuJbNRl+cBcyFuJzVK8ozRfhXitoEE/hZIU7VnbgLV2Mos+3otyF7HOW1W?=
 =?us-ascii?Q?Tw5JmDNZ5zuwKsTVt+pg18vgr0qFSqoC3FeXfPE59JbgRY6QMzRqQXk8TtXO?=
 =?us-ascii?Q?AzWRE+nWMpTUabBJ8An9omhJ9N/9OI7vTqopMbjrnc2Pjz11WWjlsztLbz7x?=
 =?us-ascii?Q?CPcjqhKx9GxXLQpSstvtd8+TXo9IxFrEYJknv8YYhE14lOSx4DlEmFyH2fC8?=
 =?us-ascii?Q?9C3O6ADpPG6b2ipbHWY62Pvg5zZPsYKRKOlBRhVVgmTkEWjBODVosUR57v5G?=
 =?us-ascii?Q?WXHHTRB12XGzInv+QxnELb6yatXFREyoDBFZoqJ2GjMA6wa+c14YHxu3voJ0?=
 =?us-ascii?Q?Lk1DKX8SMDRorsLyYKBOoeJz4RcyrVv+ZU/r7OoRBWXwWmxAfY/fGFJmq8Qn?=
 =?us-ascii?Q?+hKoUf0jOJVBWgd7NKzttuM3euo/sLqIZARedQOlnJHwXuu6w+cI2PWtlLWV?=
 =?us-ascii?Q?yGFjrE8gAl6qREBCpF1vEw9/xOkchZJvF0a6wsWuP3877iSSuMvqed7/X7Hl?=
 =?us-ascii?Q?1GpI1McrD7Z4eB5JQwaqQxrH1uKxZ6qwvxCwrJ/ScKbwgkdin0IUErQVHpRs?=
 =?us-ascii?Q?hx9katXRKylOotWuOtVINPLWoW/x19h0X7PosGlonDeszkIo9JPvknR9Jegx?=
 =?us-ascii?Q?QOrzJsyVXdxjbj8RUMNH2P+KXP6HndMz6hPGKwqSdDi0lc6XMN/UAaZ4Y+mW?=
 =?us-ascii?Q?Wbp5hRZwVRoQNVW73RIaBGyTLpFrGG7GmB2o3M9JreReqtCSNcV/QyRFYcPc?=
 =?us-ascii?Q?RtzATRxZv92ShL/8znNkujtirgB1xzNvUvN4DIdwXfW8c6Sjv3YXCwfQaOn8?=
 =?us-ascii?Q?/V1ROzhpzKuU+3tWPupkJ7ACuQfFUllLkxlS8Z2pFd/cJvndDRPtoZ7sx05i?=
 =?us-ascii?Q?YpRKwT+PURPzhuNpEqT5UgfXxT59AD3zobSGwz7GTJFoF6eyzz1L2t3IJ3f0?=
 =?us-ascii?Q?zTrP19Ok+5j1XT6AwK6vXys/b3v6Tc9PmjzYG+YNr9dbeY/C2hQyGGvoqynX?=
 =?us-ascii?Q?oGuUITWTIjtnOr+BeXhMZxjaLkyZo7Ryp5H0ooWzKvZMi5POaC+XY4pRJwIO?=
 =?us-ascii?Q?orjFT3rntTx8Zydd31tbFjLD9YykMulByIExqOvbR6/zLYII1ZBvJcfgEhj7?=
 =?us-ascii?Q?HmxSZU9X5SZvtfo/2C4YeaRHKYycRZkCrFl13Vpc/S0GDeNs0PYgf8/xtmCl?=
 =?us-ascii?Q?u8wEuPKqoG8dX3CRWgFoU0g31nPdkh+R?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:40:41.2124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5679039-f4b4-48d2-0640-08dcb0cf7ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659

Limit usage of the non-architectural RMP format to Fam19h processors.
The RMPREAD instruction, with its architecture defined output, is
available, and should be used, for RMP access beyond Fam19h.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index be5889bded49..0b39249640ee 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -358,7 +358,8 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
 		 * for which the RMP table entry format is currently defined for.
 		 */
 		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
-		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
+		    (c->x86 == 0x19 || cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
+		    snp_probe_rmptable_info()) {
 			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
 		} else {
 			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
-- 
2.43.2


