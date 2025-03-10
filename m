Return-Path: <linux-kernel+bounces-554708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44608A59B67
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA2016BD39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5224168A;
	Mon, 10 Mar 2025 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uSGT7tvb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42E23F386
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624876; cv=fail; b=WwwX7p9yquTPzl7UxztWwwlJ6u4EWhJtYYmo7frMBAFVngeu/CANdl59y4YTDs6kC02tIVekrivnMDx4jF0n5fEvZOK2sVUkvnFY0rGDmUlSzqj0zFzh0NWlSayRRiFzuj5J+yqVcIAFynd6UKPneYPP2f5UPD+dXq5XQGn53qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624876; c=relaxed/simple;
	bh=DthrVJEsr7AKQvdbLFK90wujswEhBPh74cLgoBLr98s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9OiBBVhFM9Rd2kvYO8qUBCZeKPC37CueS8Ow+ojlanSi2Xzz38L7jxIFxkezQpLQl0JhKjnYMsgVNC0iltH7JkrhLrd54MJGheip/gGNkotPovs4sahEWrqNg8lFGbUi7CqoRPLEy+VwYMyn/aTz2lLR+iDy8Nv7kljENit+iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uSGT7tvb; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djSmpBZj0o1JdlFJzreOzMRAiHhLW1Lx6xmYNWCrdYUC4gL0HX6uSBfYxateCaA+HrW94PL+n4QQzB9sdZ53dSeDK8dB61OivsDeSagr2h80MUkki8xXBgXvK6I83KiYL6uOWm2mJleIAmi2mW1rdHhujIqTNvNlfgz7xe++htlFNQ1ivJkWmBjnyJYv8ePh9EmE7A7IRXYP28//nsYhALVfV8B5/F8+Bxv9S1/ievZ81o24BQdReLr6F3jl0kHvXPqgITvmgCBqsTP1UcLJFW0lj7i9SLfnoIT1wI7c5mqu/BTkkC5eOmc7Y+BSKsJu6CMkg59wrstAhG5VfzEmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRdcbZ6XO5NCRO3dSaiVobBlS0eT1ZUVskyXMLL3odk=;
 b=X9hCmlNEmRT/jJr/W1hX0xMlExieKTRyZH/1wyGpl+jMmi0OQRQ5nFmwpg2NESg4LodN9m3tWdiIOoAl56TEsMcj4n2uilD01aMrhXCmqk8FuoFizRBgDQ1SlxOJuYFVSb1urpmUMIifacvSpxK0XB7ZsJ2neutPy+I70SjC9Tr6fTGkDuvRg7Lg14jEKdN9ihR86PKyCE11SebmSkX2PIiPgm2StBA1p9yuRUwYEfYvEOuvXFyIXkB8mBCap3kJd7wpFkBZ0FnG8FzdtKkYAe4QtvFBZ8L8mbg57miDkeGL3JcuRfkTlV/NNcVMPcWXtlOMkJ8JnNbs3MV3ciQGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRdcbZ6XO5NCRO3dSaiVobBlS0eT1ZUVskyXMLL3odk=;
 b=uSGT7tvbMHubAX1nP2OKCWQDnfjSBrS3Z5z4bGQVgjziQS0Xe0II4Pp6/qXn4yeeL++7bfNb0wtGSs8DHvQqKR2fxA+55MpISvMAncAFOOZLfd4XK8hnej43muecNeZoyf3pJMoV8AwaQARFbyIkeFpLl84j6ioyL7/d3H/idQ8=
Received: from BN9PR03CA0065.namprd03.prod.outlook.com (2603:10b6:408:fc::10)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:41:05 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::cb) by BN9PR03CA0065.outlook.office365.com
 (2603:10b6:408:fc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:05 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:03 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 28/36] x86/bugs: Add attack vector controls for retbleed
Date: Mon, 10 Mar 2025 11:40:15 -0500
Message-ID: <20250310164023.779191-29-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc89064-d4a8-43b1-ecbd-08dd5ff25a12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URtb7J55rdK2UPz5aYUf6Q2oJqxu5PQ8yddeLBEZVJmr5YAQo6vFehUPzoer?=
 =?us-ascii?Q?VNte3n/DnTKS18XlCZcmU1HbVB7kMemSw9ATb0qE86uN6MV/0Ta5sMUWf176?=
 =?us-ascii?Q?iMx/F5L3W4VoHCpsStbVtpF5eCgp5xsenQlNWsfzl6/f9qwOKMXLooyPLF44?=
 =?us-ascii?Q?43825HeXf8AHsFuPlxqo46+4waKebl/UCQY3KE9w3aZPOgwJC6+T9Isb1R9Y?=
 =?us-ascii?Q?5vhNQ0RP0w+2w9eX0LLMWQ4BpAxlKGbtLmWXX+bAyUC+KGXgB+4+GtNhR95l?=
 =?us-ascii?Q?6uMrjJshKzDmTx/bAYqMiVhSmoCHCqtA3rUBJ5c+cOA5tk8lihd19n8H+lF+?=
 =?us-ascii?Q?D4B8szCPPHoeaB9Uf3Iy9rSsfJG5HHapWciLoBA3UGXX4QbmkxJ9OvKpIsu3?=
 =?us-ascii?Q?0mpcV+pPYtXGXWiFGJNRPg7yxlZLpxFvbFSQc1Z2eRVqeHPyudU0IGvWUvOx?=
 =?us-ascii?Q?5Sc7fgrhzXb/DBOmtwytGAW+kumRjRzwl7PKexHb2mbqhjigI9mPsZnui7Id?=
 =?us-ascii?Q?MGlEXPkuW79EGdvMC+xGHdYUHZojFJKgiTE2W1GkGyCsI7TRJud8It/T+6Xc?=
 =?us-ascii?Q?mmfazjOof5foHCFIcDgy7SQcXGj4QWMhayWxylGSgVL3aqXglbcX123SeOCe?=
 =?us-ascii?Q?LTwxNbXWnTAuOJG2qG8lM/wzWdeXfPFXtzcxZtvZZJjk6t+SlNI4/pFa755v?=
 =?us-ascii?Q?vFTzEJmRSwlnAHtpgs2FcYXU+0V7UavAVikx7RgK6Ef+m/nL+sZur14kj6Dw?=
 =?us-ascii?Q?Aqokp7molFU0K8tUl+PGykQwnfpn8Bzacr87GDjdq84U3N9ZMfNLWhPoFCs7?=
 =?us-ascii?Q?ZsIWs3KYKb7GJYHlRexkBZMdYH5lEGONhjf7b0jMsnfUO7tZh9m9/ZN3ZQid?=
 =?us-ascii?Q?pi1VcygLYepb+V9uS0WoIEsXbpxenFf/TD34Hgy6UyKGoqwgEPHXdn3d/bqw?=
 =?us-ascii?Q?BR78XLhkUMkVyvU3GsDJu5w8rez4cje73oIqBakkeTAfYyUz4S6UOI8F7OOh?=
 =?us-ascii?Q?PlkrYkTTaRQWQNQq/2upCqD0oNSUVkUxOPbWJMapt8cEZ4voNVL555dz25be?=
 =?us-ascii?Q?LUvuSdEmmt3qtgO2JuI9z7lZqrBj4FwKjcD/0oNKEbQ2eRHsxp8Ft3uSXR00?=
 =?us-ascii?Q?B8KxqyeaDK3JUcTv2LVRKmkgBnu55HSIgHTOUsdXich0HZNjU4eCY6b7XZZQ?=
 =?us-ascii?Q?tWKX5mfz4PkcIVYQ9EzS04r84qWIhaWbyU8fJWNUkuOUsP4rdWMsDPFDsOCP?=
 =?us-ascii?Q?7M3z2EROQj5v1TU7s1S1FHTau+/yoqy93c5NUNgDj0Ie9IUlK7LZBfZXde27?=
 =?us-ascii?Q?8h5JO6DFBssOmEqngj140JQZQjdYoHxeERKG7xT3Z0U5dSAyYvUdikDC2W0z?=
 =?us-ascii?Q?mmh1gGC39lx2NApAd/ma/f26InTBTPq2+4UNDUETcOIcf86aYq8ZYUcfmf/Z?=
 =?us-ascii?Q?JJKxseajDejYqxW8KQykdhsyjNktqQ4qeNXnSjXwEE33bHh2toXoFnsgUb9F?=
 =?us-ascii?Q?QSXTb7kDjie9ooY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:05.3923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc89064-d4a8-43b1-ecbd-08dd5ff25a12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793

Use attack vector controls to determine if retbleed mitigation is
required.

Disable SMT if cross-thread protection is desired and STIBP is not
available.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 00f679dcc28a..4d72c6dd66e8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1237,7 +1237,7 @@ early_param("retbleed", retbleed_parse_cmdline);
 
 static void __init retbleed_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED)) {
 		retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		return;
 	}
@@ -1272,23 +1272,27 @@ static void __init retbleed_select_mitigation(void)
 	}
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_AUTO) {
-		/* Intel mitigation selected in retbleed_update_mitigation() */
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-			if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
-				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
-			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
-				 boot_cpu_has(X86_FEATURE_IBPB))
-				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
-			else
-				retbleed_mitigation = RETBLEED_MITIGATION_NONE;
+		if (should_mitigate_vuln(X86_BUG_RETBLEED)) {
+			/* Intel mitigation selected in retbleed_update_mitigation() */
+			if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+			    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+				if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
+					retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
+				else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
+					 boot_cpu_has(X86_FEATURE_IBPB))
+					retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+				else
+					retbleed_mitigation = RETBLEED_MITIGATION_NONE;
+			}
+		} else {
+			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		}
 	}
 }
 
 static void __init retbleed_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED))
 		return;
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_NONE)
@@ -1386,7 +1390,7 @@ static void __init retbleed_apply_mitigation(void)
 	}
 
 	if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
-	    (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
+	    (retbleed_nosmt || smt_mitigations == SMT_MITIGATIONS_ON))
 		cpu_smt_disable(false);
 }
 
-- 
2.34.1


