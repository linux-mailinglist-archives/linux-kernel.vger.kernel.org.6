Return-Path: <linux-kernel+bounces-385695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7079B3A80
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC0128309E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FE1DB361;
	Mon, 28 Oct 2024 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KXB2J860"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF8173
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144003; cv=fail; b=V2Kbi6AztB/noCslTWvnURxzVGERv7epH/5ugRVpk4CLuwEtipBtYi7RDQSFGpFbviwkYepuafQqQK1c2WN+/r1f1fkyB9zwIPRdtazHMW6pvsLzC24qd9UHQGaT1ldaWa2HdME8zYrTENIpoAD2ilNalRG993TkLgcw4tNqfHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144003; c=relaxed/simple;
	bh=RV9ToIY/yj9bhuaHArZs+tuEr1eLdhQbdB1fF/27j7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Km670E6ajy+Rz7opyKi3djdKJSFUolHkpntQ/xhZmJEH4I5DmhnCSupRHDm6+924ztPFR52ocToYtppEwC7mTUpp8ZwrIR4lHu630Ul3KLpyPPEJyHPk96CNH2OQabVvqWClc5gbt7nGLKqFtqkE0kT0CLor4q6ezydiKGTnrjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KXB2J860; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYiHMCGrWSaoirI8IHKz8zMfk5pxwxJDoG75qsIvfgntbNkXXdS0qgbRC9AyVYbm4n3/txy+34qihslTDDWjjkCfPYOqpvnbWRva+Sfqp8UWJutuUnjsU35I52ykeIByBHbrAq4ObcQgsFFPi+zoaRQkYy8wcWVLhHjqqwdFLkYKrZtSSOeTE1z4ceIUAbgEu/dnfLA+J05iFbdDl0xpkuR9oVRqBowp7Jbvo5IvLqHvzpJiBOhpQXutGl57GYk4hN7qqLHjrCK9oLqLzHhQB6NlsTpN39tTH1E8q1TQgozGN3N4UOGcxazrHtCSAeKK0gAns8QaHB3rpNlWrwa6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lJkHzvrTD7SCQ3Ts5guo3x7/ldr0iadDj6ffyc/+lY=;
 b=MZIGvgnKh4HhkC/Kixs30u+tDXD4cE9573Lothp19JXhbQ1cN/nQSf3Y7bttUyZtisWCzUNohU0rNvr1I35KtZikWn7Nav23L4Ui/lmOD92Mt9Ikb0g/Dvbifb4EK0T8vE6TkjBqwTMfb5cQ57v8vEwyJKxCeuYXWqsPziNueceo5OFwWvYE60SBgzd1elPmF2t7qrQOZF49Hm3HnwenqymZdPeissyU3V/HACqzZLvCUK6FvL8gXBEpywatNzChI+T1ktOfHxafkB5PcJpzq4qncHyDOp743cU7+loJfrnRtL3GnPPB/eNvbr3JDPMbqsEQAMC1wmsDAEZDQ1sHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lJkHzvrTD7SCQ3Ts5guo3x7/ldr0iadDj6ffyc/+lY=;
 b=KXB2J860mh4K4720r2o7ZabgbqEQ5Qs5EQ11syYgdWBts8cGohVYsaxvrN+7M+OLXqonxSPknFUEct8CqlMtYzROBq5Dvx1LTKo/PV6AwxyQ3nORcT+1qjt48bBV/1wGCdFT/BctmWO5YzcFu0rRWuXosGmXEBA8qNXPeDVOjRI=
Received: from MW4PR04CA0372.namprd04.prod.outlook.com (2603:10b6:303:81::17)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 19:33:14 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::e0) by MW4PR04CA0372.outlook.office365.com
 (2603:10b6:303:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Mon, 28 Oct 2024 19:33:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 19:33:13 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 14:33:12 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v5 2/8] x86/sev: Add support for the RMPREAD instruction
Date: Mon, 28 Oct 2024 14:32:37 -0500
Message-ID: <e228f4264930bc830a7bd514c14ab1c378b69fea.1730143962.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730143962.git.thomas.lendacky@amd.com>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b0fda9-a5c1-4ef8-9bb0-08dcf7875d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9G1G9vBAOW0DGroXYzTu94Q6UFfG2z3uoeVtEWDFfiBFleQzgLcF1abzCMEM?=
 =?us-ascii?Q?RWH81Yygjw60g4KeoACQw8DMMSwTucFlrPtk2PjPeAmAZDyUK0di2RDr4NAE?=
 =?us-ascii?Q?uul83Nd2HlqV3ATTl6F/rMtX2qWlMWbOaOG4aTR/ry9WQNLEtuLa72byEuPH?=
 =?us-ascii?Q?ZxwtmK0mx4MuVx8Qk1RcrOScZ9a4+xWocltBY/0CI/dHbgPGvTu4v3xKnk5s?=
 =?us-ascii?Q?0hY6k6Q+UcxwD4ZSnbSEVod6t+FtAj9uNFiysfkwL85w6CyvC/tckOb248H6?=
 =?us-ascii?Q?ZzZ7+9swNjpS8fjZ9wjrjAFwYvQjDQNYB7dWqUsiwsLna5eU7falscsqRF+M?=
 =?us-ascii?Q?JYVL1WIQnQSQ5SNl6gcXA+8BfaggqoxwvilMFN0GqbnFjKxzniuo+0RTL+g6?=
 =?us-ascii?Q?Pz+8ojVi732ReU7NYyeAbAgEwMFYbcAUTftnSHOgsEo+BoJK82grz0hNdVE1?=
 =?us-ascii?Q?aDxIMnJWEYv4j4rdNR/3FxSL+BDrHdm6v1xHbyvA8EcbrFZAasCGK4Ux6vjZ?=
 =?us-ascii?Q?0A0pB376/Ws9CUVG6y5BqYZlZpGVYRNgEh/5Dmi7dRdD1jkavKSd/EaHFZoA?=
 =?us-ascii?Q?isq0rQXRkEWqFd1blNa1FL3070UyVUmClBGyLY5ZE8UTU2Qj6uBLdtkodpuu?=
 =?us-ascii?Q?ehhuYIr9JaTWbhS9F+9r7FdTbIicdMdk90v9Dd06Po6HwLFxSKUz2UdH6WvF?=
 =?us-ascii?Q?Lqjz1P22bWRd9aFvTqAyR6hQggYuNF7cuIrIhaiIJwilzADHnLseJ9CQ5HKq?=
 =?us-ascii?Q?UPHd4qeoubXCOGDiELtLLxW+ZqKkd45lAjaoFSsKxEq+L6WvhkV0UFWvH49e?=
 =?us-ascii?Q?EsEK+rc1fhbCwd394b7ddPh9jpBwcXx7fbP0q7HpNshozK+nVj877FFI0DCn?=
 =?us-ascii?Q?seYNW+09CC6qtuPuxg0+Bty7vliS4QCSBtTKPr9riJ0ovSqPgKc63YuwPkp5?=
 =?us-ascii?Q?oeh+WqTQp9zWIioAlOm99s5Q1rCLvXmScJ0oJGCKoh84Oj80ieQ1rkWtE2rG?=
 =?us-ascii?Q?Wh4i5Z3Oel4VQ1poCraHSTMPLvVKz6aN59gxY+nESuDsibvXAgRqdRr9sSNn?=
 =?us-ascii?Q?mD0j0tlHAypP1Q8vxgTlK1f7asjjBBg739bGBLG9p/GdencsrheQaCQ/1/iq?=
 =?us-ascii?Q?1ro4g4N00Q2qSGrdHctEzTj1X3JgGi50znZWqo6Oapdy534AFUDQToFCfF3r?=
 =?us-ascii?Q?Pg33eDPTzge23Ti7pPfaG4nfi066PEBCll7+IXUJyOoAxsyqo9cEN1CxvQtf?=
 =?us-ascii?Q?8QDLmqb7zBMoZm2gCwcJ28A7HXhFyCaQCwUnhzKDSlS85IR1a0MUXcjd8QPA?=
 =?us-ascii?Q?yB7EPMMM3yEBZ46LmWUCCIL8Zf80GtObYRV65ZojjsynrJhRsbdJcVNsGt8k?=
 =?us-ascii?Q?I9/v2Fu1VaJfhYPZ9A0BnjylwE2F/nwGjk29CrSIoXbs0is4Pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:33:13.6500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b0fda9-a5c1-4ef8-9bb0-08dcf7875d43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497

The RMPREAD instruction returns an architecture defined format of an
RMP table entry. This is the preferred method for examining RMP entries.

The instruction is advertised in CPUID 0x8000001f_EAX[21]. Use this
instruction when available.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/virt/svm/sev.c            | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ea33439a5d00..d7395a55c04f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -448,6 +448,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index b705c726e913..7cca3d07e678 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -306,6 +306,18 @@ static int get_rmpentry(u64 pfn, struct rmpentry *e)
 {
 	struct rmpentry_raw *e_raw;
 
+	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
+		int ret;
+
+		/* RMPREAD */
+		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
+			     : "=a" (ret)
+			     : "a" (pfn << PAGE_SHIFT), "c" (e)
+			     : "memory", "cc");
+
+		return ret;
+	}
+
 	e_raw = get_raw_rmpentry(pfn);
 	if (IS_ERR(e_raw))
 		return PTR_ERR(e_raw);
-- 
2.46.2


