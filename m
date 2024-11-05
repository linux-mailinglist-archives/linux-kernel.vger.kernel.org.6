Return-Path: <linux-kernel+bounces-397197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28B9BD7E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F302841F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C158F216E1B;
	Tue,  5 Nov 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VV08O/lZ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E1216A00
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843733; cv=fail; b=gKdJxxliO6YFhSD4jD4Hp20H1MaQtYZZGS53Mni9TKT0g6U2kuCzjTimPMdC586FeYxi4AKvdXljjCD85d8sHACzKIzcJLi9rQ/oc0lOlcoUj7Cc8UbfizRAgukvpWFaqByUd9QqEpNt37E13H1modoamN6jAFp7t1PFmV/4L1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843733; c=relaxed/simple;
	bh=tbUtUS2qfNPfPsia+G3UrINja3H88xOuIKuqkgW2FS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsIovsY3w5Znm+p1nZilqmpmKaxQTGvDmMqDm8BiaWjyu6Rq+Umi0/py2BeAqi8fpdQTVRBfwo8pPiP3kL6bKM+ni1fVCkbYvzrDz59WBM8JPaGtE3zvriiUfhO/ba4dSYienWIosbr9nJWFjlzcE1YY2iV3jLYL1HKklcxQeeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VV08O/lZ; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nalEs4V7QoqLWawF3nEdKD/S870q7wpY/jP4JzBlZkQ+yTsLW9YKDBJbWBXlljna6jzvE0pZJ8hHJMDQSYu7Zc+1dauEHgWCEvVVrhsrtGZ5TFswdkPTrmIGCTANAwg1qdokJDyKptWqUK5hjYGigEfXIzdX2YEOnrqLjEhQ+FcB8RiC6WtTNicB9OwbDAok8Gkxvq0vPfMWNgdWNeAJEjQkpbGo4QIWauDUW7wNdQFXNBy3hUfQVpypiKa86VPJOy58Mq3mSo7NJzVNYuXg+6Sf+qn/S3VaqEB1BHpf2g0D1RQ2sRoE3df17lFNZfA2D4FJ9L+Z5z3Vi10na8ZQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfrbJgAyXdnTl7Q5Z5ABPt5Yym4D9QPmGgjhqcAzXhM=;
 b=gzeA1TRjtDKxFRBgIwLNlkuuyPBA8ODmbqhSvvG8N+C+O/kYA6d0hOovl1vyNEttIXJIe6+7cnjtGyzdO1HZ+J+w23QAVtHWLj+/uAlqTd0udxMfrwryb8ak8lVYfS3aRfjqKc/3tuhNgbBGjwMx0DQAc8/42jGV7W6EBgcYrP2JwHb+hoXFu8uLK21vUDDWBgh8zAKujKNv/4rxuNIdNTbc4soT6UYP+IvBMPMFLlNCINlCw5qIH0gFheTWDYQ99qwT6CFXUJ3pkxRIYAEr+eX6ChCU/WPqP9epOhq96Cxt9mOIB44Du7JJFkCFOvjm/gKJkCMUWJfF6J8qK1PfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfrbJgAyXdnTl7Q5Z5ABPt5Yym4D9QPmGgjhqcAzXhM=;
 b=VV08O/lZJm8mVJ4Sln1skE0svfZX/0+VNCXw4rdTV/BJYNlYsMHPQt0RKRTrQBRHM6THHPyjF8SQIP8z70LnhKW6mZY+3DdOt4+hW+hIKFdgqrfBDyqdbuUEbyrz5rMuq1ucngMCAli9zKYD1Z8GZCuUEFKE64POUWYNcwffcZ8=
Received: from MN2PR15CA0051.namprd15.prod.outlook.com (2603:10b6:208:237::20)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 21:55:27 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::47) by MN2PR15CA0051.outlook.office365.com
 (2603:10b6:208:237::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:27 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:25 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/35] x86/bugs: Remove md_clear_*_mitigation()
Date: Tue, 5 Nov 2024 15:54:28 -0600
Message-ID: <20241105215455.359471-9-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105215455.359471-1-david.kaplan@amd.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7c1ae7-3e59-4df0-a788-08dcfde48f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0M4MSltHeiVyBhzTxcFi3iW6nRkHvZxi/oAWBlifHNTkEA1V8imb83T85pC?=
 =?us-ascii?Q?tO9Rc2XKRJxaord0y+MG9wBhhjL0SVAQEluPtAfwTGBm8NfBk78MnJh+nf+k?=
 =?us-ascii?Q?8cokzwl4kt8uKHVqEQLH56tZKzlZopaWIn3QmEzQnm8U5H7B7mM1qg/6WZ2c?=
 =?us-ascii?Q?2yZc1DKZ63PwQvcWAizsRcLKyjd3QC0j/alg4ToBPBp3Q5Lb27kn3v75hpB6?=
 =?us-ascii?Q?guF5ukUEbQUIKsKu4J49yeCTWGqS9q5blkTm0QBj9wRQv/+I3Rbms1RoriWu?=
 =?us-ascii?Q?Zjotx4MrShGBjLccirYQyUtkfUX4p4u7TID23+oyLwFd7KutwFrPDLrXbShp?=
 =?us-ascii?Q?uRkNpHTJ8ycO9J3EiEJdLbB7Q5v5LlUGOOa8+shj9hgeTKL1/tSMGaN6qP5A?=
 =?us-ascii?Q?HM8GF0bcq9ch4o/CvKzcnyElOpvOifPpLHvTNWzMRXjceDaV+JDOvcC/8guU?=
 =?us-ascii?Q?2+pOjS9ovFMFRxzo9RsF9MOu9w/OXFmdwSz7OcRw7NZnxQisXSHremm9BAp5?=
 =?us-ascii?Q?CUGS5ZOAVsqMI3H7PXIm7yDATKePeMFsYddJuVW9xNe/kxuCRofGaK/vAzOw?=
 =?us-ascii?Q?1Wm/ZacNRNKnQtpY/V1/D+NsdVsFrbvFtVycLWVWE7k9G8Tv6XL/40+TjHWt?=
 =?us-ascii?Q?fdo5c+xio7a/cLlrEDtEMMNNq2gjzAIbIoN6XTFPKQ/Ut/vETH0dYlYShS8s?=
 =?us-ascii?Q?Xw0MyLNMusID0EMtlfml4FVLhB1nCOT0i0AyH/SVOfZhME5rZb33y/BdLCGj?=
 =?us-ascii?Q?w8D5TwNhSPuPaqT1tcwdJlOM81I+P/HqPoNtI4H0Ax5xaWjdp740Q9tbZuK2?=
 =?us-ascii?Q?iOuXarT0PXkPBjr4L62mveNNoCKCO+7UMbTCldFIdG0QUbrpgbOizv8MHXvf?=
 =?us-ascii?Q?flQ5+Y74Etla3pV1rBN0XMZyjirxNT4mzQ0xNWYQxgZlv/4I0Xj1uP0GR5Hb?=
 =?us-ascii?Q?sm3lU9Iga0kAl6x51wPHeg+y0aunZHNeCq5AflRqUn0OWlZ99ZDt8oMb/9/h?=
 =?us-ascii?Q?WSUJNZZWdkEUty10s19wf2QfCg8toMtYVCDPzSkwOZcqtsNLspbwgxXMjwEh?=
 =?us-ascii?Q?cDLkdJXE6smKApjWavm2pBu3Zr4jtj0ZREPEOLqgtaOTbKVtFMJK5fAtwcF5?=
 =?us-ascii?Q?cGjFoxc6BtJPWQeZDBTJt4NMIRzDJMhw7RD4GgwhiMadx+PcqizOPxt7V+P/?=
 =?us-ascii?Q?paOtglZEmvrYO4fTZ7A35uQsVvGP7U/Q/uLGRARV0Ms4Jkvx9ZLfkONWu/DQ?=
 =?us-ascii?Q?zYFQn7EXz3jfcvhZRbukiOnmv7MArVPatd0Yc3eIspKWvmNPCd/8BvdwndAv?=
 =?us-ascii?Q?W/sGPI2Qwm8mQr9OX6U2JMqU75VwfQsYytReic77nox5r3YBOpoWZgq+fX/7?=
 =?us-ascii?Q?ZgfFqAtLGmv+G9Hy3Y9CoH0bQYS8By7aszx4au91s9+YMY/rGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:27.5778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7c1ae7-3e59-4df0-a788-08dcfde48f2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666

The functionality in md_clear_update_mitigation() and
md_clear_select_mitigation() is now integrated into the select/update
functions for the MDS, TAA, MMIO, and RFDS vulnerabilities.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 65 --------------------------------------
 1 file changed, 65 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c3a2d3b8d153..5ad989e8eea3 100644
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
@@ -197,7 +195,6 @@ void __init cpu_select_mitigations(void)
 	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
-	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
 
@@ -661,68 +658,6 @@ static __init int rfds_parse_cmdline(char *str)
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


