Return-Path: <linux-kernel+bounces-554695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3624A59B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D28A7A71C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0B123A99A;
	Mon, 10 Mar 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fbcKPnZr"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20987239584
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624864; cv=fail; b=ZAG13Pd/Lh9a3kHxVyaJM5TP6n7PxQkKHne9yBYF4A0YAOYVy1mlmGp4Ppd5M10j2F58N0E7/mRJzL3Kyd0PQ9DP7OUzUO7j1jNv8B4zaz7vZHZ+EaICTNI40rpoAE0CrxgmJ8nVqQkrX1D/VY7oox/RpKal6Ue3wGRKSPVtaCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624864; c=relaxed/simple;
	bh=c8G2POovbqff3DYFiso9X4iLiHbDV/PRv3b5zJ1rqe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lhcivp68lOmzcqi7qPBdQU+mLAQJaHYsaepqjmusTd7dbz+xW5/ny1DS4fUzzZjaO2Fwb1NMcCsJr2r9kjuGBVSdXfT3ekLKPUn1BFQ4AFjCRfqJAyuNVVpv9TbYKm90SYJ1GIl2OalX7Tj/03GKYRZVNMozK+ffSEBNjCPq0Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fbcKPnZr; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARzSzUiWZQLUZoO647YLJa9Y42bVSbT3e3r6kw+U5lxwD0s53H/zt5fO4QrYFEu6ACLs+WdeqZnIWesOp6C0x8BWCuVRu0UWzXNKZJT/koFWVucRfCdGkt03tSxDlWfwhdika0vBIMnQwRYGsot8sEgMkB9Xq7xtBLVdFAESQHG0kvXvG+UmOv59Jw4GtngSK/jbVNj4djwTWrj1pRwfeKszK7HmXjdg4OOPwXGN0D0x02eD9hr2s02QkStKXRMaDXc9p/H6xDJ94tW3ULMmDocSvOwiGAQOk7L1QSvluPS9QZLDe3KnjjeJBbt5PgIXksdVc/bBHEbd2Uu7kwnsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+jzbKzJQFsXftXUzG259CvQI8KGT5ejKuNzQpGq2xU=;
 b=iDkJzER+CyTrikuCAHvoQLWJF6iHuK/vmLRuJNkv9MvJ+58wXk/Al+UIJqwUbY8knQyN1sVifXIOOP9xWaZ3UD7Xtav574bg1YJd8LJdXgHgr43yK8KYOze4U/S7bgMKgdeW9pegZQTYtwbtvSLJm9nu6NbBGE2wbUvGIkC4YWhTBRUCd7qbselSECMx6HpL6cModiLexTi1yQA25l9S/DYiLulhF2D9ndix+7+jTX0QH5/Lbv8pFAU7esKbKmFyf8MmjOYK1yzvNgAOXg4jzsn/wrHcru52U3J+Cuo0qkkW0WJoQbvOX0WqZIYKw9iQpyEj1MydAm32Iv8VTbXV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+jzbKzJQFsXftXUzG259CvQI8KGT5ejKuNzQpGq2xU=;
 b=fbcKPnZrctQXxUGRJSPGGt1yFqlF4nRlLgj1XxOlsamLqTUliwPCNXaBFsVtckEbB2ibah/vnRtPu+2ddnDgHHC73E5K5i0FMdN6hTBAg4Z2xu2VugDzVnvtSjVJ2HsHpemJqdV7k51U7uj7gO/BOURyCbTnCgKZDBxAn/ig0v0=
Received: from BN9PR03CA0064.namprd03.prod.outlook.com (2603:10b6:408:fc::9)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:40:58 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::d6) by BN9PR03CA0064.outlook.office365.com
 (2603:10b6:408:fc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:58 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:55 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 21/36] x86/bugs: Add attack vector controls for mds
Date: Mon, 10 Mar 2025 11:40:08 -0500
Message-ID: <20250310164023.779191-22-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310164023.779191-1-david.kaplan@amd.com>
References: <20250310164023.779191-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 47430491-b6df-4a37-58ad-08dd5ff255d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7CjdY1Ukq6R0XJZMB+otEj62QVQVg1tA3RUvPfR6uxhJq3qSzAJOfT7HiOXb?=
 =?us-ascii?Q?E1oKOpX4XBfJfNKd43XT5mbLdaTwywTEPPnDhXEBPKC+Yhm4J4gFxDzncET0?=
 =?us-ascii?Q?XwB40VsXtsSYc5HC4oQGAWu6WjzyNA3/hNbiu4whG9g7kPU33j7mx30UyVDF?=
 =?us-ascii?Q?pxmzDBrllm3pSyi7t/yAWOon4iA5o+HMmXuUnFU+NFZsyAM3OV5JpQnIZRTV?=
 =?us-ascii?Q?TeqShFkrOD7KRq2Jm9rc/bNCos2WPdtUcGOXRW20Z1pe/pssVTwaDj5oapMB?=
 =?us-ascii?Q?tWqj3HV6zEkiHjHYCkKnJYSnwxHcQeiX7wausvJ8ReAjl+ls3qAiT3IYbZuy?=
 =?us-ascii?Q?pCdhY+7effPdIyYGDrFFkA0qngs1h6xqVTwCzCy2LKCivpXGOGn4gjC/n7ea?=
 =?us-ascii?Q?Gnv2I1DoKHy+kYADGf4U16sQyDa7qes6O2V5w0j9UJ+kKhiByGirPrZ5h0Cy?=
 =?us-ascii?Q?ZNe3TZ3pgxMAbAHP9G1M2kmOzUNfsGNUp75z+xPCfLM0mKJljsUgo/Yhl1ua?=
 =?us-ascii?Q?lgIb/C0RyUHRJoivcK7R3iE/pSnJfDNCLGg2GVyQJN/Z5nlQupQ7LYfCiuEf?=
 =?us-ascii?Q?va78I8dKfPLuj0kL1vD4ps0EgU+QdDt4UOTGvIrlLYHl8VQg7CO3B2HdBNXd?=
 =?us-ascii?Q?o220dmh3Hx2B37Y/PM+BO33gclcDVfpriQqyGewcx9m2RPm4+yWixxpXngZR?=
 =?us-ascii?Q?0L9PpdDMhCMFBrCUwQrnkx2xXdfKjz/u8xuLfKpXMxSsQmy/l+HGDC1EWeBh?=
 =?us-ascii?Q?zllAOVwfaHfqi0t2JqEfmCK8N9PJiKlQ6h7M7K4fPtTz8t7UAEhyLuSjG/SF?=
 =?us-ascii?Q?JI7lw14kIo5WBnYlNJ6mMUdd6OT2Y0VGQdzM6bHD8N3ccWv2MF/Nl2tDIs3h?=
 =?us-ascii?Q?nHBfQdpQbaqQPVELSIwO+TviI7J9I8Nbteaon3l57FhpuSRpxlJe5u/KNDwY?=
 =?us-ascii?Q?F9wsqIo3K/agNOzqSHgF2KIAOsrdvfB7UyRK1qGn041U1tT0f2OR4OD5gOn7?=
 =?us-ascii?Q?xoTYMO2SfXwj9/pPlUmXoyKWxXgEM1brqsx9AaM2MWhGfVlIPuxnjHP6L90F?=
 =?us-ascii?Q?3yCebZwrHmnbxAmFfPRUy/kSp4Dq07ucmAoGUyMoQrzOceHf3U/4dmNBiJzT?=
 =?us-ascii?Q?4NCbDHnIAteoT6r9S2Y5fTMEJEeCUGf3a8piJjYcR39sU5QXC/oCmttQWGz7?=
 =?us-ascii?Q?uic14kYIMiSHoICXutkNMT0Eop1r8MB2Cgvm0LqZZvTWOFXXSAos2XAYPfCB?=
 =?us-ascii?Q?ZY4y5qmG/56RAW6LEImkzAL8IQH6hqWKy79A4seFZXBFheOjbmrrcOAJerIL?=
 =?us-ascii?Q?u2YR8YUwC/SkISzbC7UUbid846Pr83ziAKsEpJnVFt6qkhxH5UF//RRNyI0Q?=
 =?us-ascii?Q?Tw7HoVWgl5T13oopnooZcXyA7hifZSl1bM5WcleblmAXxIk6KuyKSJn5vC1S?=
 =?us-ascii?Q?kMzbIe/2GE1CsvTuRoQy+JUwmUDrG6EK+3MrkQDeguNRHTwkkORPJcqQu+X0?=
 =?us-ascii?Q?qZyHiZ30chM90dE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:58.2517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47430491-b6df-4a37-58ad-08dd5ff255d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083

Use attack vector controls to determine if mds mitigation is required.
The global mitigations=off command now simply disables all attack vectors
so explicit checking of mitigations=off is no longer needed.

If cross-thread attack mitigations are required, disable SMT.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2323bfbcd694..197ef9f2cbce 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -405,20 +405,25 @@ static bool verw_mitigation_selected __ro_after_init;
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS)) {
 		mds_mitigation = MDS_MITIGATION_OFF;
 		return;
 	}
 
-	if (mds_mitigation == MDS_MITIGATION_AUTO)
-		mds_mitigation = MDS_MITIGATION_FULL;
+	if (mds_mitigation == MDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_MDS))
+			mds_mitigation = MDS_MITIGATION_FULL;
+		else
+			mds_mitigation = MDS_MITIGATION_OFF;
+	}
 
-	verw_mitigation_selected = true;
+	if (mds_mitigation != MDS_MITIGATION_OFF)
+		verw_mitigation_selected = true;
 }
 
 static void __init mds_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		return;
 
 	/* If TAA, MMIO, or RFDS are being mitigated, MDS gets mitigated too. */
@@ -439,7 +444,7 @@ static void __init mds_apply_mitigation(void)
 	    mds_mitigation == MDS_MITIGATION_VMWERV) {
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
-		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
+		    (mds_nosmt || smt_mitigations == SMT_MITIGATIONS_ON))
 			cpu_smt_disable(false);
 	}
 }
-- 
2.34.1


