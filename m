Return-Path: <linux-kernel+bounces-554692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB782A59B56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE3E3A2F96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E5238164;
	Mon, 10 Mar 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ELrNAkJt"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99062356DA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624856; cv=fail; b=Y5O/0r1GG7maD6aYPf+D5I1gdo6JT+9GPS6hCho0aVrC8SxHbY2ba3/Z3LJrO93Mx5EXsijY/jSzzW9Ck+0NUWYbnZPBud361QhPiRZ95z05MR0c9ivjgc3KVxBvpoaZkDCLmyuz9jPykrIfMR/gKuqEVzd5F+NXMfhXySZVL+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624856; c=relaxed/simple;
	bh=ISqDoFr80KqcseFXTdxmjKRzU9Gsel7LLutZpmuNXZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLnEVttitkfVncoItsqkKLFqMf/veG6Opl3NN8LKfWH+Ufijr5KtSXa4q46B7GdSrlKAGd/PW8et5DRNRs/i7RFtl6xIGLi929hD2wFMkHiN//q70I6ozIr3bobHx0+qlEBvvLvJ1BdUvG+a8EEbSRSaemZobRRgsUp+L9Qk4Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ELrNAkJt; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rn8cg9EKOENRqEx/6k4qJicxYQHGHG9sp86/J4Zw0ESDq1D1fcEW5VsoIlnmuWsZYedqYMiAH/bQqNT66VFyqxwDapLdMt7qmQUAaa98iu4dHzauqIBgOB9vdge1cbn+4wgdf2wjzZJjj7hr6IN1as1IbmIrxSdMpNI24rT9V/iU0qDbikLARg2BQDTzvVa8cKLYBa9nIsFf27Bf4ZT5GeraZZLnSk2tPyraccXkAULeunIie71nu7U8CsQ6qPPCli5NvqSkbFCOSCbDFd2TUd1dgxUsoUemjxoMc+pfqIhfCdgQd8oy43tF4B7XuMSlxv9yChuNZCRIRgwHNCNpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb2QcW7o9rCMcv8cNUnPDmkDPP5Zg+CL3Y1GVR9eqZI=;
 b=TuWLb8dLqp3D5NnbPScFffBFKFetMhG7IHstQPiwWzvKfPvRaHZTCtQV6jKtV2NAyztcvPIBKnR+yOaps2K1iQkSGnOlDbJBd0NGx1lxyMqIdlnRhWgXIWkQyx/tQinIw3Ce2F1eQbyhSXabFq7l6VegLTBg8nAQCmqHjtt6HD1KT0S5Gs2JMiDCBykVuIvZCevZGd2EgHFuYyJueac1+kd/xho9jwejJA6X79RTmscEs9a7L4nrEeQkZ4KudPVsN+VtZC1pqiyJmUYJipTbNu/eoDnF/afyb3lGGowvr66OlK6eFCx9hmvxojOfGJHxwawZXUwtzPz/tcwAVpaHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb2QcW7o9rCMcv8cNUnPDmkDPP5Zg+CL3Y1GVR9eqZI=;
 b=ELrNAkJtHbHyix1BHey92QUe0UYPMtrMcZNUb2kGOPrTYhYSLPaqdiC5nW/lvGZ24ZZfD0uUWIOItbPNj25GWq/BTaPRQrsT1EW9n/H/2Foa+Bm2Mb+Fn+H5WquEt+aeFFsgxxf0wzSOwSTOJdQy+UTArWTyNOXYc3TCiZxKtlc=
Received: from BN1PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:e1::34)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:45 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::b6) by BN1PR12CA0029.outlook.office365.com
 (2603:10b6:408:e1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:44 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:43 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 10/36] x86/bugs: Restructure retbleed mitigation
Date: Mon, 10 Mar 2025 11:39:57 -0500
Message-ID: <20250310164023.779191-11-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca46e5d-e11e-43f0-3615-08dd5ff24dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3WCjXXIwbDSq2xlt5O454ATCvtyN7gbS1wKYl3RbPhgejTq22TTL/hvT2aek?=
 =?us-ascii?Q?/d1WdGoAGRtDz3kMRBo2ZkpEqvrl6TsKlXgHpAtj7hdx2n+gTiwQuwFUJcc9?=
 =?us-ascii?Q?b8wgnc5Ye3r69TGiX5LM5ndnARKd+ZhMavGsAuTv8aw3Umqe9gndGqslhYkT?=
 =?us-ascii?Q?iAhkI8GG0/ZgvN+ke6Oj9Q9qLUUagftyNOkIjtdTFtmnfkpzWliN09I0BSKV?=
 =?us-ascii?Q?8tzPYwxHVyLUGqkqZfdCG2OTzpcuLeRz9cZgWodP6zXnzn3P4w0fPaF3EHKL?=
 =?us-ascii?Q?6t+ln4SrPXH4brML3BLcKk33bJDYW1B1wtWPnkAYQei6uGWkhA4daAZgeAx7?=
 =?us-ascii?Q?g3p/xCPM0XeSGhERxdnEAbSTtS+T+TdsU1Wwpf8K4IHFvU+ulgpjpJwwQJdH?=
 =?us-ascii?Q?xC8cvgQecxy2yXDVgBKOV0mntKQitF3qMCDOY1oFsJUohHdJSIqdwzaeiDC3?=
 =?us-ascii?Q?jJdt14R151sd8o+UgG94/UJmOW13A5ip8FCVxLB1WyUhIzuy2/jSbZlvDeq6?=
 =?us-ascii?Q?HSw2no39w+uUanvCYr1flbA5Q0kz+JdFKyeOW2g9IROqPKyzNmBWbfuuyt7M?=
 =?us-ascii?Q?6Gq68SsWQ8ZRDo7iYWl9wW6wb6HBAkWQZNh6l852t3jMzepvdq2P8M3LNRgf?=
 =?us-ascii?Q?hQy2OrblfXQIiWXSDoVlR+tef/xqHYuNf3CU2Pyg2VG+vDRhPn/3Q9NdOcZ+?=
 =?us-ascii?Q?1PRGaOMczDaMnmvX75wxZabECe9JwNeVapcg4RwKQSA+VGPUrwLdKbyrjrVx?=
 =?us-ascii?Q?V+NJ/uiqT06tnv13cpg5s12v1LWE6havULfslpDvyM5ienEo9GJ1/eHJzQG/?=
 =?us-ascii?Q?C36OAQ46cJuhMyTL5NqP/xe7Zkq5XFUJ8GLZ5Rz7dv8mUoFyJw0ouRZ+2R0R?=
 =?us-ascii?Q?5eXLIWPB13k3hthbHwE7fydq2ym7CftVdrGxA5Mzqvc4u85Kmas0pS2WqJiw?=
 =?us-ascii?Q?JX39qnNg/tUvfhka4x7cX625kDFr5jaxPcIyZKRUzquT9u0vB2/ZzLC5yIAc?=
 =?us-ascii?Q?Ymt69UXMcsOEMYZ3lXbSZEJhZgq/oBL45JR4v0P7tVyI/fnji/RNXEBVIZFw?=
 =?us-ascii?Q?RdL7cgIN/ZGX9Efi06g6eMr6nTRuyem/06iXlwISL1vSmXXtLJVNTDKbDdeu?=
 =?us-ascii?Q?tgKalw0tAaMHjdBFygfN/EqIMqR8Ces2mg36zEW4x9wW/8SBGLjqF0mcifOd?=
 =?us-ascii?Q?zlM0xkku6XDUYHRXbu2/E5Yv7OQ1a1hzy18gxY1eLfe9cZG4uVx8ogX95tb5?=
 =?us-ascii?Q?AVzFh2RshVIQ9TezBvccYD2HKNWsaAB0RgEeja1ol2XrBZhrlSNjXJ10Dhav?=
 =?us-ascii?Q?gpSfFCtDKBaeDeRpZAD85N4VY1YCjIwXjJHLZIHuWKw5u9CBRXfT36klLvUj?=
 =?us-ascii?Q?vN7qzcrIe80+wtufDJ9LT3yOPEQlzS/4enLMcz1kQo4b0HO/tOxZ5yGxCKhW?=
 =?us-ascii?Q?N35GPII1C7IDnnHigLe4NTJ8/8cV4ZiC0W49BnFe41q9ozPu0NWamrkN8mWM?=
 =?us-ascii?Q?lvkrNI6MFRPwWeA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:44.7897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca46e5d-e11e-43f0-3615-08dd5ff24dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321

Restructure retbleed mitigation to use select/update/apply functions to
create consistent vulnerability handling.  The retbleed_update_mitigation()
simplifies the dependency between spectre_v2 and retbleed.

The command line options now directly select a preferred mitigation
which simplifies the logic.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 180 ++++++++++++++++++-------------------
 1 file changed, 90 insertions(+), 90 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4af342d226c8..80b554249d85 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -57,6 +57,8 @@ static void __init spectre_v1_select_mitigation(void);
 static void __init spectre_v1_apply_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
 static void __init retbleed_select_mitigation(void);
+static void __init retbleed_update_mitigation(void);
+static void __init retbleed_apply_mitigation(void);
 static void __init spectre_v2_user_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
@@ -184,11 +186,6 @@ void __init cpu_select_mitigations(void)
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
-	/*
-	 * retbleed_select_mitigation() relies on the state set by
-	 * spectre_v2_select_mitigation(); specifically it wants to know about
-	 * spectre_v2=ibrs.
-	 */
 	retbleed_select_mitigation();
 	/*
 	 * spectre_v2_user_select_mitigation() relies on the state set by
@@ -216,12 +213,14 @@ void __init cpu_select_mitigations(void)
 	 * After mitigations are selected, some may need to update their
 	 * choices.
 	 */
+	retbleed_update_mitigation();
 	mds_update_mitigation();
 	taa_update_mitigation();
 	mmio_update_mitigation();
 	rfds_update_mitigation();
 
 	spectre_v1_apply_mitigation();
+	retbleed_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -1072,6 +1071,7 @@ enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init = SPECTRE_V2_NONE;
 
 enum retbleed_mitigation {
 	RETBLEED_MITIGATION_NONE,
+	RETBLEED_MITIGATION_AUTO,
 	RETBLEED_MITIGATION_UNRET,
 	RETBLEED_MITIGATION_IBPB,
 	RETBLEED_MITIGATION_IBRS,
@@ -1079,14 +1079,6 @@ enum retbleed_mitigation {
 	RETBLEED_MITIGATION_STUFF,
 };
 
-enum retbleed_mitigation_cmd {
-	RETBLEED_CMD_OFF,
-	RETBLEED_CMD_AUTO,
-	RETBLEED_CMD_UNRET,
-	RETBLEED_CMD_IBPB,
-	RETBLEED_CMD_STUFF,
-};
-
 static const char * const retbleed_strings[] = {
 	[RETBLEED_MITIGATION_NONE]	= "Vulnerable",
 	[RETBLEED_MITIGATION_UNRET]	= "Mitigation: untrained return thunk",
@@ -1097,9 +1089,7 @@ static const char * const retbleed_strings[] = {
 };
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
-	RETBLEED_MITIGATION_NONE;
-static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_MITIGATION_AUTO : RETBLEED_MITIGATION_NONE;
 
 static int __ro_after_init retbleed_nosmt = false;
 
@@ -1116,15 +1106,15 @@ static int __init retbleed_parse_cmdline(char *str)
 		}
 
 		if (!strcmp(str, "off")) {
-			retbleed_cmd = RETBLEED_CMD_OFF;
+			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		} else if (!strcmp(str, "auto")) {
-			retbleed_cmd = RETBLEED_CMD_AUTO;
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
 		} else if (!strcmp(str, "unret")) {
-			retbleed_cmd = RETBLEED_CMD_UNRET;
+			retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
 		} else if (!strcmp(str, "ibpb")) {
-			retbleed_cmd = RETBLEED_CMD_IBPB;
+			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
 		} else if (!strcmp(str, "stuff")) {
-			retbleed_cmd = RETBLEED_CMD_STUFF;
+			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
 		} else if (!strcmp(str, "nosmt")) {
 			retbleed_nosmt = true;
 		} else if (!strcmp(str, "force")) {
@@ -1145,57 +1135,42 @@ early_param("retbleed", retbleed_parse_cmdline);
 
 static void __init retbleed_select_mitigation(void)
 {
-	bool mitigate_smt = false;
-
-	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
-		return;
-
-	switch (retbleed_cmd) {
-	case RETBLEED_CMD_OFF:
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off()) {
+		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		return;
+	}
 
-	case RETBLEED_CMD_UNRET:
-		if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY)) {
-			retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
-		} else {
+	switch (retbleed_mitigation) {
+	case RETBLEED_MITIGATION_UNRET:
+		if (!IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY)) {
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
 			pr_err("WARNING: kernel not compiled with MITIGATION_UNRET_ENTRY.\n");
-			goto do_cmd_auto;
 		}
 		break;
-
-	case RETBLEED_CMD_IBPB:
+	case RETBLEED_MITIGATION_IBPB:
 		if (!boot_cpu_has(X86_FEATURE_IBPB)) {
 			pr_err("WARNING: CPU does not support IBPB.\n");
-			goto do_cmd_auto;
-		} else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
-			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
-		} else {
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+		} else if (!IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
 			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
-			goto do_cmd_auto;
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
 		}
 		break;
-
-	case RETBLEED_CMD_STUFF:
-		if (IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING) &&
-		    spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
-			if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-				pr_err("WARNING: retbleed=stuff only supported for Intel CPUs.\n");
-				goto do_cmd_auto;
-			}
-			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
-
-		} else {
-			if (IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING))
-				pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
-			else
-				pr_err("WARNING: kernel not compiled with MITIGATION_CALL_DEPTH_TRACKING.\n");
-
-			goto do_cmd_auto;
+	case RETBLEED_MITIGATION_STUFF:
+		if (!IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)) {
+			pr_err("WARNING: kernel not compiled with MITIGATION_CALL_DEPTH_TRACKING.\n");
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+		} else if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+			pr_err("WARNING: retbleed=stuff only supported for Intel CPUs.\n");
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
 		}
 		break;
+	default:
+		break;
+	}
 
-do_cmd_auto:
-	case RETBLEED_CMD_AUTO:
+	if (retbleed_mitigation == RETBLEED_MITIGATION_AUTO) {
+		/* Intel mitigation selected in retbleed_update_mitigation() */
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 			if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
@@ -1203,18 +1178,65 @@ static void __init retbleed_select_mitigation(void)
 			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
 				 boot_cpu_has(X86_FEATURE_IBPB))
 				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+			else
+				retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		}
+	}
+}
 
-		/*
-		 * The Intel mitigation (IBRS or eIBRS) was already selected in
-		 * spectre_v2_select_mitigation().  'retbleed_mitigation' will
-		 * be set accordingly below.
-		 */
+static void __init retbleed_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
+		return;
 
-		break;
+	if (retbleed_mitigation == RETBLEED_MITIGATION_NONE)
+		goto out;
+
+	/*
+	 * retbleed=stuff is only allowed on Intel.  If stuffing can't be used
+	 * then a different mitigation will be selected below.
+	 */
+	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF) {
+		if (spectre_v2_enabled != SPECTRE_V2_RETPOLINE) {
+			pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+		}
+	}
+	/*
+	 * Let IBRS trump all on Intel without affecting the effects of the
+	 * retbleed= cmdline option except for call depth based stuffing
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+		switch (spectre_v2_enabled) {
+		case SPECTRE_V2_IBRS:
+			retbleed_mitigation = RETBLEED_MITIGATION_IBRS;
+			break;
+		case SPECTRE_V2_EIBRS:
+		case SPECTRE_V2_EIBRS_RETPOLINE:
+		case SPECTRE_V2_EIBRS_LFENCE:
+			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
+			break;
+		default:
+			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
+				pr_err(RETBLEED_INTEL_MSG);
+		}
+		/* If nothing has set the mitigation yet, default to NONE. */
+		if (retbleed_mitigation == RETBLEED_MITIGATION_AUTO)
+			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 	}
+out:
+	pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
+}
+
+
+static void __init retbleed_apply_mitigation(void)
+{
+	bool mitigate_smt = false;
 
 	switch (retbleed_mitigation) {
+	case RETBLEED_MITIGATION_NONE:
+		return;
+
 	case RETBLEED_MITIGATION_UNRET:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
@@ -1264,28 +1286,6 @@ static void __init retbleed_select_mitigation(void)
 	if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
 	    (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
 		cpu_smt_disable(false);
-
-	/*
-	 * Let IBRS trump all on Intel without affecting the effects of the
-	 * retbleed= cmdline option except for call depth based stuffing
-	 */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
-		switch (spectre_v2_enabled) {
-		case SPECTRE_V2_IBRS:
-			retbleed_mitigation = RETBLEED_MITIGATION_IBRS;
-			break;
-		case SPECTRE_V2_EIBRS:
-		case SPECTRE_V2_EIBRS_RETPOLINE:
-		case SPECTRE_V2_EIBRS_LFENCE:
-			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
-			break;
-		default:
-			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
-				pr_err(RETBLEED_INTEL_MSG);
-		}
-	}
-
-	pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
 #undef pr_fmt
@@ -1839,8 +1839,8 @@ static void __init spectre_v2_select_mitigation(void)
 
 		if (IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY) &&
 		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
-		    retbleed_cmd != RETBLEED_CMD_OFF &&
-		    retbleed_cmd != RETBLEED_CMD_STUFF &&
+		    retbleed_mitigation != RETBLEED_MITIGATION_NONE &&
+		    retbleed_mitigation != RETBLEED_MITIGATION_STUFF &&
 		    boot_cpu_has(X86_FEATURE_IBRS) &&
 		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 			mode = SPECTRE_V2_IBRS;
@@ -1989,7 +1989,7 @@ static void __init spectre_v2_select_mitigation(void)
 	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)) {
 
-		if (retbleed_cmd != RETBLEED_CMD_IBPB) {
+		if (retbleed_mitigation != RETBLEED_MITIGATION_IBPB) {
 			setup_force_cpu_cap(X86_FEATURE_USE_IBPB_FW);
 			pr_info("Enabling Speculation Barrier for firmware calls\n");
 		}
-- 
2.34.1


