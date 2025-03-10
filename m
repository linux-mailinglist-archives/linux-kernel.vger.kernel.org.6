Return-Path: <linux-kernel+bounces-554706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0E9A59B69
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B326A7A456C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD223F42A;
	Mon, 10 Mar 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X+byfS45"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50723E352
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624875; cv=fail; b=TRZK0KYKGxG8yFK5qO+HJ5J8NuAz4H6my9cvS4Ikhqxgmo874fvIav+mB88MlS0EpVTRKouu7d0l+SOzGH1joZqXZFtaLAT8ekIaB7qukFgLg/Pfrnn2cgqigTV8lgcDwYDDLK82hVCjH5WyvWycHDdl7T73sqk3K7J/dOQ/xWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624875; c=relaxed/simple;
	bh=m/J970w5pJZuuSYl3tIIwINQFGw25NwzleNKgz8D2jE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpQe2HJKiDZ2CI6ftopUIcsapP1CG3z162sEf95JGSAGGUZufon35sQLIzmHZo/k/hK6hnCzvvdq3MOkN57cQComWOXtOXeQC3aLK2ACMeFXmV4+497FY1/RhsUatpub2p1SuhW5M1BWQxw+hpGfWVHIUzTjMbo5r8U1CxE0mwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X+byfS45; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4uGpS08S+z/O3UgHohsFcBOkr12/Ezos7xWxXpQ9BnDqgDnPSFL5Qzy5vd4eGDQeKsHrlES5kNypl3N3OjdRoWtYJPYqkwsjJr1LlqbodX4qpaicliqekrFuWjsWKsIWUL5GTeyG8hZOigQVl/eo9QrOgJbTMjYSi1Sns8T2vIrBvQC5deGVzLh1R16smT4NXeZ63sufPp4oOBHAcQpALaD+wa3GVCaGyc/nDxJLqoc2pb6Da1+F3RgmhrpoeT5Sb3gX0/NpEInu9n5jcADa9Q9/1Vxxr+1FEzwZE3JMS3VQfjtY+mkLnmpG2A530H/LnXtBuNrg35O3FZ4N6RY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ7sGUUSojIDusD92XjlzfCmOKiKisjL85Uxl6nLVtQ=;
 b=KEbf8u3HDtmtbhVITOCBd/o3PKGOU5nUx+d8CZJ6KJoUYAeQSuMNPfTsIl9PxCjsVbxT6HcSfSiRUCDX0Hza9icFbv6pyWFqFj7KFN+ZRkEP19f5mOLcr9x7v3Z737O53YGKfxpd6YPgu/vresa7CCp/0S9e3FLGDQA4U7dayliQvr/8UaMPYDZszS0vuqpHpmcNBrfwUYL7Ju4Nfn8l6BSTiZrvva6s+oNcV0Q9jp0LvHJ7rAXBlWsy3nz9/Ph8CZCYjuOVE+qcbKwJOJAypK9R4uvTCBtEGZmrG2DWem2UO7diOgV+nveKgcKzDWCyPe4CELW5OhwPOYk+iPUaxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ7sGUUSojIDusD92XjlzfCmOKiKisjL85Uxl6nLVtQ=;
 b=X+byfS45Hya3S5LN+WA6vKxY5RLdMQ5y8Nc2k/mgTzrapH2luSE59ungO0ZOQG5lMaeR6PGCVq9FpRQ/rY/flCYvorB50Uq5S9/F390Ku+1vmHGhjcaCaOXFTv5O95wsfFapVe2WNsYxHvAnaB5XghbeICUsE6QZbb51KqtM4DM=
Received: from BN9PR03CA0061.namprd03.prod.outlook.com (2603:10b6:408:fc::6)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:41:08 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::1c) by BN9PR03CA0061.outlook.office365.com
 (2603:10b6:408:fc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:07 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:05 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 30/36] x86/bugs: Add attack vector controls for bhi
Date: Mon, 10 Mar 2025 11:40:17 -0500
Message-ID: <20250310164023.779191-31-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ab8f07-8402-4a92-52ab-08dd5ff25b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0dQLLA3X2nb5iR69J/q5mlhCHCBoV8pyjzj2CTZSitl0tYSzF4FH0V6llSCq?=
 =?us-ascii?Q?d/FrcFW6Ifks6cYwW93hruehHJohzCPi8GFTl1w5CWnD0Bnt+DLV2LfUPcBw?=
 =?us-ascii?Q?LIG61u0jv7sIkSH4UKf6dY7IRepM6OoD0/J9FSi8pH6oLdMDzp7k7pmx29r0?=
 =?us-ascii?Q?HVuoS2vLzhbBWvKYfgX5fdkiQmdbU2IBgbmdIlI6fftzIYQrJJXcwOtMWKMP?=
 =?us-ascii?Q?bCWcRSbxQh0hlyOvHfk71EZgwLmIn2EzHxrQDiK0PUVw6xPLfMBVYw1VfWTn?=
 =?us-ascii?Q?B2HJzTZvvZDYOYYvJrpmeGmL3ABCEP0dmR5+Ebc/n8sApY0x35UThlsR63mi?=
 =?us-ascii?Q?rtA8Y+QN0u0TpQvJ/D0kOXeHDmiaLt3iEUwuDRSd8oS8DDFqXt+UlrZKE7Qp?=
 =?us-ascii?Q?yNL8r/6JNnqSSWYrGYkaqoE3gHc3runUAyYESYssi9GohyQOGeI7wShN4qP6?=
 =?us-ascii?Q?h+uh3btjNyouWUgK7+6YwpGT/vQGJXIn+uUlKxkFJstVdZRqreH/ho/8OFzB?=
 =?us-ascii?Q?UXs/zf6CbdQY/nOixQOJi4E4abKcZT2JPFbU6HhwmwCESoKqzS39t9hcRLo4?=
 =?us-ascii?Q?DSSq7qAfogFuRg/nFazEP/adw5qncSzd5LzEravrcNe+E65X4Im/kwBHoAIu?=
 =?us-ascii?Q?5XD84Job08GZdg1SpPBVyalEMrzWpAne5wEZId1oP8hO1GJ0+X40CPa9Dn+h?=
 =?us-ascii?Q?8Ojvu+M13X316xdmjCmmEXjvVXrZJzc87n2V2aVCSO81bgYFLeI7jdLXI40Q?=
 =?us-ascii?Q?E+sQuJXJL01HiDrUM7zTRhb27TVeOCy/cvmKsqQNh4MHP0/pO2MM+tEn89Gr?=
 =?us-ascii?Q?R30Viv/BnrsRaHk9mQ8FrbcGT2aDLqenGF5NNoVNFi7End/MHJ4st8X0CIyJ?=
 =?us-ascii?Q?kPSCDkPiiQfrbzNMvH/rr+KWoU+MSvwREDdAaqchddjBOYXsWF4jmUHFVwIb?=
 =?us-ascii?Q?5If7k+pJvODQOpq86DqrUNcYuC7sPGC9zXyNewqEc/XZHs4q52UFZjI62GQn?=
 =?us-ascii?Q?rvK+Zr+mYK+5zhJL0k8CIQKnyjRvbO4wr0Jj26zt6ipAmyv0VFzziDvdfW5r?=
 =?us-ascii?Q?Y1n6jfPGgO3k7DhfYc24ERVxd/lRPpJU7h+zaxSKGs6ea680Oo1pjC1uXhou?=
 =?us-ascii?Q?zbEE/jjmZiisrG108Xf4TH5DeC48cRL8coiNTDRrfD9mcqs/lrh5+L2wNEtQ?=
 =?us-ascii?Q?hhU7LDqQCOOMLja5Cs3Wpv9RTmugWaSST87exyFLIRTG8LT/sO3d5UuM6soX?=
 =?us-ascii?Q?9bjnoK9T0H2pc0jQ7Tzm9XOqP+eohSzWbwTqs3qXn6f2aabpgG9QaelUhgUU?=
 =?us-ascii?Q?UPGne2AS/P6sHhOxlu/3udvioHThF64BrU53tz4QA8DE9M8aAdJfmy/7VrL1?=
 =?us-ascii?Q?nuJAy2BuxB6Gm3IxZEkINWPsBlEYGk7XOGsxdZFdJHnRVjePTVKEdCeCC2b/?=
 =?us-ascii?Q?fOAZEFDwi+tQzk9nfa64DMJPRI3sOmb+Z4mBoIo29eC9NBeT//fjXUJYXRZT?=
 =?us-ascii?Q?ND9PL0fGJCXtbs8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:07.7205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ab8f07-8402-4a92-52ab-08dd5ff25b7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952

There are two BHI mitigations, one for SYSCALL and one for VMEXIT.
Split these up so they can be selected individually based on attack
vector.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 40 +++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e06dee765fd5..4912367f2334 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1889,8 +1889,9 @@ static bool __init spec_ctrl_bhi_dis(void)
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
 	BHI_MITIGATION_AUTO,
-	BHI_MITIGATION_ON,
-	BHI_MITIGATION_VMEXIT_ONLY,
+	BHI_MITIGATION_FULL,
+	BHI_MITIGATION_VMEXIT,
+	BHI_MITIGATION_SYSCALL
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
@@ -1904,9 +1905,9 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 	if (!strcmp(str, "off"))
 		bhi_mitigation = BHI_MITIGATION_OFF;
 	else if (!strcmp(str, "on"))
-		bhi_mitigation = BHI_MITIGATION_ON;
+		bhi_mitigation = BHI_MITIGATION_FULL;
 	else if (!strcmp(str, "vmexit"))
-		bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
+		bhi_mitigation = BHI_MITIGATION_VMEXIT;
 	else
 		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
 
@@ -1916,11 +1917,20 @@ early_param("spectre_bhi", spectre_bhi_parse_cmdline);
 
 static void __init bhi_select_mitigation(void)
 {
-	if (!boot_cpu_has(X86_BUG_BHI) || cpu_mitigations_off())
+	if (!boot_cpu_has(X86_BUG_BHI))
 		bhi_mitigation = BHI_MITIGATION_OFF;
 
-	if (bhi_mitigation == BHI_MITIGATION_AUTO)
-		bhi_mitigation = BHI_MITIGATION_ON;
+	if (bhi_mitigation == BHI_MITIGATION_AUTO) {
+		if (cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL)) {
+			if (cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST))
+				bhi_mitigation = BHI_MITIGATION_FULL;
+			else
+				bhi_mitigation = BHI_MITIGATION_SYSCALL;
+		} else if (cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST))
+			bhi_mitigation = BHI_MITIGATION_VMEXIT;
+		else
+			bhi_mitigation = BHI_MITIGATION_OFF;
+	}
 }
 
 static void __init bhi_apply_mitigation(void)
@@ -1943,15 +1953,19 @@ static void __init bhi_apply_mitigation(void)
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
-	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
-		pr_info("Spectre BHI mitigation: SW BHB clearing on VM exit only\n");
+	/* Mitigate KVM if guest->host protection is desired */
+	if (bhi_mitigation == BHI_MITIGATION_FULL ||
+	    bhi_mitigation == BHI_MITIGATION_VMEXIT) {
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
-		return;
+		pr_info("Spectre BHI mitigation: SW BHB clearing on VM exit\n");
 	}
 
-	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and VM exit\n");
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+	/* Mitigate syscalls if user->kernel protection is desired */
+	if (bhi_mitigation == BHI_MITIGATION_FULL ||
+	    bhi_mitigation == BHI_MITIGATION_SYSCALL) {
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
+		pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
+	}
 }
 
 static void __init spectre_v2_select_mitigation(void)
-- 
2.34.1


