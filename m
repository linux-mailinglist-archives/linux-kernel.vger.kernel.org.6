Return-Path: <linux-kernel+bounces-554681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3555DA59B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724EB3A6B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A3823372C;
	Mon, 10 Mar 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MQqUnOBH"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06023236A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624846; cv=fail; b=qyjz6gY+3cOrH4tlnidpcpGriLjUnQcYaMKtahDxovaCHe/hryPFF0pE8YbYsBJisx/UO7T8JkHN2XY4R2gynvY82k84O/xPcZ9IUvl7BowYAypcVzR90eqqE4qCEAePX80gDZBjgA+Ske1pCC1oYZsn/6bsDBCHjJkcBHnt4qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624846; c=relaxed/simple;
	bh=SFK9DT3dfBXWdWZ9ItVdvzTB/xtIHxvDCgoENgg8NWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAEplaiykGq4QohtySQk2gjYDhBgFGCpz9cewCQ//Hf35tY5r76omhR2XKo+wz8uECJaignzTAQPet+9HqKPWSp/KFTOKkrHC0MEqWDBdUh+v21eBkIBzHlDKvtu8nWfUA7H/U1A0lxM23GXldoLFzc0Sx55u/fzdmnY7xmfivk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MQqUnOBH; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+1SbBzZQfQrWLlEJ2vJjRztxw881oWvXCsZFuqvPr0iKTn+pFHIuraKOP6UM7UmS24B48gv/IqHzj/3WskyqqhFddxU8+z8N7X0k32GHl0Y0tQwn4xq6drRO95Os0oLkBwl/+TzQez7d72zNsFsJlSIB0i2bNIUbLOj//dPziBEOb5hqi57WfXsJdLjIVPeQlDR8S+LVPEtInlITrwfgq8z7QiLSbC/w3Sw0zcJNHluKyhpQmAZnJv223+wHd7xc94jeaNE+JlQR/E+Z9ldqjgwYkdF/USLyNYnSJsevGSL8xn0Ef4/z/yoBVSRW1J9g7Nub05FWcVeukHEouiHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsEsPN8nP9Y5YzXToN1rGG41ObZbHURZGHzKWGbHixE=;
 b=TFWrgOq+iVGFdDocRBsF3t+tp+4PIYG+xquIrHqnCG+j72U2iRx5cYRh9llL9Lw12MRo9/xnoZpaJU6co1VxoPqrOhyBuycB/WVJ9LpAKqbbY3wfKbnW3IwTKVGrGkunJiJtyd9DKWbbzhM2gej7XaKXgOuJWOVdua0EcPHc+wu/lnxNRhb+KW+emu3jdUS/VshnwvkmVVzqBZfgrvR/5BKL1tcncTMyvKMeiI0sKkjgLA41Pbljf1x+hlaH+M6G8s7/crdNFNS7gyHE4dUtpmOhvbZq27QPhK9qV7RNsujRtRFQWn44eAqNHy3CB3wkEAaRoYKknjDIu7kW19Dpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsEsPN8nP9Y5YzXToN1rGG41ObZbHURZGHzKWGbHixE=;
 b=MQqUnOBHSohCqNPiPRrCB932gXhO8InjsjFSZPea48h2w2rr7VrK/kfjGVsH11sZIqN2W0lNobmamkcXfhYrwLs988lUfCWuhrkkGcIzFKMNfJPTr6tmxiB9wpK4x0bCszUvd0mnqgztkEu9uDlw5bipT8gSYJS7R80LUOhogXA=
Received: from BN9PR03CA0732.namprd03.prod.outlook.com (2603:10b6:408:110::17)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:40:39 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::dc) by BN9PR03CA0732.outlook.office365.com
 (2603:10b6:408:110::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:39 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:37 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 05/36] x86/bugs: Remove md_clear_*_mitigation()
Date: Mon, 10 Mar 2025 11:39:52 -0500
Message-ID: <20250310164023.779191-6-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 624f4ae1-7969-42c4-dede-08dd5ff24a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?APjWvkC+5MqygpdzIxRH+JoPNgHo3HzbhqNVjJXvESq51vRmeU7gIByeZ8hl?=
 =?us-ascii?Q?LwY+dIeNg/T4TArXUYzIN6X9SbwfdFCuqpB7f2NSEkWQVMCuo65+FkoABvBP?=
 =?us-ascii?Q?MezOkqdbAboW9XN7yJ/ikQt1ziPwOmx5tVNGOr+ENWBzBbhU0gp/ClFun86m?=
 =?us-ascii?Q?4pM/BDqDgysw1Pf6z9pYY8asGWqyLcOlA9nFS6mly+/dcWlh/osMjJRW6zl2?=
 =?us-ascii?Q?Lcrrxsb+8nztTnpE3NDomqvNl+bf3jspy8pMhpUiIBuRQ8QlzJYyrT/9RvSF?=
 =?us-ascii?Q?N1CQJ2id/3Z6x+LRLzQgb+M82Y6LIIE22s5WkVAE+aI3Zn6dYlObJNS0LK3g?=
 =?us-ascii?Q?xaBPwTaTs/QI0hMLSLvIDMNl+/Wjihdskz0mnjmfl6C69pIdpQA2+WxRwFQZ?=
 =?us-ascii?Q?x0SrCO160FyON0F1F5kpzg7EerbiUcUef8IkePhfBcnpHzzuz3LMmW+sJ0rd?=
 =?us-ascii?Q?g69+Su3g1FUTAYPyr1boqB5rtRU1CnHaAothYwADbjfydiAlpsqLhyyJtxIj?=
 =?us-ascii?Q?DI8KWuyf6AhoMMXsk7lEUB4KGRpbsOYe7KSpc70Y04I2ax1PkXnXtWUj/KZq?=
 =?us-ascii?Q?8DmNRaB2vHsFx2CqS+ppWOiAeaX2KDWRwTKjstbQtpWSY/92OGmaPOw7YHQI?=
 =?us-ascii?Q?MNtcvHVQXSmz8a0/kmvG9N/famF695nu6QsHpivXSBwgn6KfzpybnSvlqFjI?=
 =?us-ascii?Q?/ftb/DAY7LP7GiCxTYtX0M0kbT1vXJdNteSH1Ct+QUF99zYc0ggSJ3DSblkQ?=
 =?us-ascii?Q?sYlhiqDFPKmonFAolJqMpyhJRfK/pwzXPuPetV1yk/rSoSwX3yxqB1e1rqsJ?=
 =?us-ascii?Q?QeCYJJT++VQxpsBNlTiGyP9xfYZZJOAyMzf0RUBdhIsnRWJCZ0G57ectuV5X?=
 =?us-ascii?Q?oynmx6hVfXQjIAiLOoSCXRNBCDIJJ6YhrTghSU0LABpUTPp7yrZCl94f3kwJ?=
 =?us-ascii?Q?0I9NrTl6JNrjM535pp936Syf3TLPt8+6JR8vbTR9llAhMrxFzNQg7YlKOOPH?=
 =?us-ascii?Q?w01HS+aGyvSujPRgfcnwgbjsG0GQJD9FjWpjotrVsXO6ugV+mlqe/pr49wyN?=
 =?us-ascii?Q?EaHAyaCbO/SPGgCKHxthCq+5Gplw3W3rsYZ2dSPkxZ9yZ4BL9lz97Mfpdhaa?=
 =?us-ascii?Q?9hHWgz0/i1wJ1qPAETumwPIXAeCPCgWL8IEaLBwUSl/QQEDIpUhXUgm9Db4j?=
 =?us-ascii?Q?0Pu38tKaoNngXyYpBYJ7Uq3tvzNWeQrXq9+bl0PmqHu0SSvC+crfHgs8HgJx?=
 =?us-ascii?Q?ZeEOOXstZcV1S70bKE1QPDo9CsvJyzcsyZ1K/dqdLEqv/IxMg9ypbborGvw2?=
 =?us-ascii?Q?M3zf2xaFa1tQKz467r+LvrOoxArr+/06FcMILWAd/42qd8c9UejpmZHObzTJ?=
 =?us-ascii?Q?eZLGGj0TuhUKbS7P1/6gxTbxzCIOgD4vZ8zFtZKGGM1o7jKUIZffDWs4W0wn?=
 =?us-ascii?Q?NX/M7El4t0m2VIKUU9ZHFfA/Cyvehz+7L81PJagVxrGSUtWktvZtpdfqSwKH?=
 =?us-ascii?Q?2+h1vlGtNAXsm9s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:39.1604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624f4ae1-7969-42c4-dede-08dd5ff24a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301

The functionality in md_clear_update_mitigation() and
md_clear_select_mitigation() is now integrated into the select/update
functions for the MDS, TAA, MMIO, and RFDS vulnerabilities.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 65 --------------------------------------
 1 file changed, 65 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index de431f2bb012..841ab123a180 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -62,8 +62,6 @@ static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_update_mitigation(void);
 static void __init mds_apply_mitigation(void);
-static void __init md_clear_update_mitigation(void);
-static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
 static void __init taa_update_mitigation(void);
 static void __init taa_apply_mitigation(void);
@@ -201,7 +199,6 @@ void __init cpu_select_mitigations(void)
 	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
-	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
 
@@ -678,68 +675,6 @@ static __init int rfds_parse_cmdline(char *str)
 }
 early_param("reg_file_data_sampling", rfds_parse_cmdline);
 
-#undef pr_fmt
-#define pr_fmt(fmt)     "" fmt
-
-static void __init md_clear_update_mitigation(void)
-{
-	if (cpu_mitigations_off())
-		return;
-
-	if (!boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
-		goto out;
-
-	/*
-	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
-	 * Stale Data mitigation, if necessary.
-	 */
-	if (mds_mitigation == MDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_MDS)) {
-		mds_mitigation = MDS_MITIGATION_FULL;
-		mds_select_mitigation();
-	}
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_TAA)) {
-		taa_mitigation = TAA_MITIGATION_VERW;
-		taa_select_mitigation();
-	}
-	/*
-	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
-	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
-	 */
-	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
-		mmio_mitigation = MMIO_MITIGATION_VERW;
-		mmio_select_mitigation();
-	}
-	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_RFDS)) {
-		rfds_mitigation = RFDS_MITIGATION_VERW;
-		rfds_select_mitigation();
-	}
-out:
-	if (boot_cpu_has_bug(X86_BUG_MDS))
-		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
-	if (boot_cpu_has_bug(X86_BUG_TAA))
-		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
-	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
-		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
-	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
-		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
-	if (boot_cpu_has_bug(X86_BUG_RFDS))
-		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
-}
-
-static void __init md_clear_select_mitigation(void)
-{
-
-	/*
-	 * As these mitigations are inter-related and rely on VERW instruction
-	 * to clear the microarchitural buffers, update and print their status
-	 * after mitigation selection is done for each of these vulnerabilities.
-	 */
-	md_clear_update_mitigation();
-}
-
 #undef pr_fmt
 #define pr_fmt(fmt)	"SRBDS: " fmt
 
-- 
2.34.1


