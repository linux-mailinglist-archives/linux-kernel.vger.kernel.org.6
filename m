Return-Path: <linux-kernel+bounces-554703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B8A59B62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4501882B90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373FD23E34F;
	Mon, 10 Mar 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BQvri4Nf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2423A992
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624871; cv=fail; b=YiMmzH0p3+GnpZPFXgkEsyhawbMIpY0/kGH7pT28NUcB9z0pkUzIgABq3T8XbW3wJ6a2rXPGPj6z2qE2aW/hqkEGfPnwbD+hfcQtPEDOK1zW32kFS066qESkiOh3G+II+uGURBMkHrGjplQc3suevYm6KLvuuNgNw1IfBFWKCxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624871; c=relaxed/simple;
	bh=7xIm5VaBYwvdKd5LGqHW4horYfjlAVRkTUChu3f2g0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ga3mUprxjo5yMI9KBTwOqpi9rqdVHLX3G6Efcf4Sdm7zZQHwWdWegGs3LeDIjc2SaPjG04E8+lgbvkE4lwy9L7kFxYXpNU6vhfxkLzX3jMCN2WOxSAFAU7wuIrLChlO3OWkkKZCq6gG5YOn5GPSJFq2zYHhFHkfpGcqGASAGpJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BQvri4Nf; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mfx976pGb9nLmDgWVB3USWjIl+NJyIOU8clB5aU8ZVGO9JTZ95IEBIIrUtpPjGr+mrKWF86l6ofVzJUH31U1zFTSq27wWNuBuLuLt4XWStKJTk0OLUAdXcw4hgVz/KBIcXd3YI5vz9cRG/LMrtGbQPhFW22Ogb2vBZJQzDWJwszYfhiIUrYqZuLYLT8Ju5sm0RRHGqqeWD0K003HWq9z0QaZXXJdDe4lCqZHrA+WMumcGwdXlTGVwqPQ2QBahQpX0wduZJq0EXQ6NeRS8ADrS7nwE/ANV2t7PWmn9e2N7P5AeTErnzANDITEc5RkL3HWSANHAeNRCq3qqxQ47Ii5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBgl2HrXvGMlgsG5zstsEtHeSHt+xErpSGwcBqAwfGw=;
 b=FB/dktsQXO4DjTLMjtlQ1DWuLFCYCz2SBY0muYToQ+fCbGveYAKOBK/M/Xy8ZoFWnclS+TidfCUcMh8bdiT0AZqLSkKQIJSbHyp3e5PTirEkbAYH40O5A6rH2jzh6exAQCkkpLehQdUqMzf2FsGn1etMYmtr1gxMC0ByVKG0E1nmnJWqMh1qvs2kUTSP3Sffu1xr5tYJrRU0AMaGgZ3mWBXuJ8ubTa4C6jPsUmvp026vxQO2ezcIVD9NVY1AE60hq+GgunDUg3Dq2RXQeNa4iYZ+aK0iFQTjQKeAvs1x0oeSHerptqZmuEH51zP4xz7Pt3AraO6/CfD2yVTwDzDrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBgl2HrXvGMlgsG5zstsEtHeSHt+xErpSGwcBqAwfGw=;
 b=BQvri4NfCg/wLbG4FC3ISfBGYVMbxLuUvttF0F+c3l1B75S5rfPpBzA6d0Ey9RWypu91xPBeN40r1ZM/s2AdRzjYBIPYS0qlJq43IRcOr7mt5o+5Cd8KuPvfvupiU1LStCuKqXOxSL42efW12Q9kmr/mucK/4UB2FubPq9hTX9A=
Received: from BN9PR03CA0061.namprd03.prod.outlook.com (2603:10b6:408:fc::6)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:41:01 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::24) by BN9PR03CA0061.outlook.office365.com
 (2603:10b6:408:fc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:00 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:58 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 24/36] x86/bugs: Add attack vector controls for rfds
Date: Mon, 10 Mar 2025 11:40:11 -0500
Message-ID: <20250310164023.779191-25-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 653ee758-0e31-401b-d2d2-08dd5ff2572f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7/Chf8SfjmYkl+pE5gXf9xHlb3lfu+wFyBG71g8ZyTtNFpMyGgy1Yuz3m50u?=
 =?us-ascii?Q?rf6I3E8VEajRBZsCAvaibozg9ycdbVPEkVZ/jQZjqK7O1SWe5eMLVo5tSZF9?=
 =?us-ascii?Q?0mky8dDx3jTn3qLXiLa1wRSQq1e6O/FQ3P3RiMNowFA8CeCW8mcka1fKa4xE?=
 =?us-ascii?Q?kQg8kSuMj3GL4fNbLUWK+DRNdicwQO+7Tr3z9Km5TZWji/A7CXE3gT2GfR0p?=
 =?us-ascii?Q?jbEO0+mATrXfBJK6acX5FG1JFPTAeUTv6sB9uHXpAXIiXSV49BaytWtn76JP?=
 =?us-ascii?Q?+7lyYsEkAy6nYatulhc4hqCzO2yNiKrcFPceet1LmdIERRLTSaifO2QCZ8m5?=
 =?us-ascii?Q?rSbpkmsnXxesqMNQ6rvYA1svnAR1/T+ODuqDyUPdB2CvN9+nKaeCuvuGyMXf?=
 =?us-ascii?Q?ZxWO/HZpPRWYfKW1MN8EQ3BfnZThdwNDRAxDguxnEp24jldpl6cLfnDuodB9?=
 =?us-ascii?Q?exlu63LJEx1OHTQ/1kzs0QZHtdF2YARGhpEW9elq+xs5+YWzBhKtWHrQttZw?=
 =?us-ascii?Q?LH36PzSzR7ObBNzkLnZLPEVAstl4QAVZYIjQIXC/5IwVIG7uthcYATpN0w4F?=
 =?us-ascii?Q?gBXlgBnza7oy18BHWXwfsO4OO47vNBP7Wqt8oWceZ6jvTFmEgDZAf7C/64bt?=
 =?us-ascii?Q?mySmV4RKdJrpqloLitc2MaU7u6BOlCzB8nLRMNyYG6VUybTXDlvrmfV9hc4z?=
 =?us-ascii?Q?g+FqdsmXV5UU5nirtBLuFP64W1NSHMfbMGx84ezgcxlvo5YxdEuymiPnjGti?=
 =?us-ascii?Q?NEHmzs6iZ83oB6VUQ/NZUBrIsfuJZ+URqjobRcpu/KEj0TKBuwMnVH7D1ren?=
 =?us-ascii?Q?OT0gSs4kAjJMd1oxxAu1xgb1IR7iymQkmQU1VT4JQ5nZZk7iKkqm951xRa2b?=
 =?us-ascii?Q?X/OpC96+pwsJFPaLm3RoNxV3rI9etHAmiWdKvwkFZNqsJtjtU6gm2kO725nO?=
 =?us-ascii?Q?q3sFi17lH34LVuy5RJsp8cLqyS8mHGJ6IKbRk7uBp8h/426En56v7mq6trV8?=
 =?us-ascii?Q?wzvKKKmt4KIQPchTdlAyNXGMmwKyAIij6r+uNqq6MJQdBGNmi0ebKpnb5T6F?=
 =?us-ascii?Q?skWpNcMYlxjidrXtx4HkB+C+69Of8dA2usRkkZxKw6gQjRaSQ8WVPbI95otG?=
 =?us-ascii?Q?CqhbQBDlUq/Iep0fAZWroRTT0CqNeJBYQ7EgLGn+At281k8PHDxJd6oBe3IQ?=
 =?us-ascii?Q?ftY6QJpmzm46Ufod29GhP918iagwq/s21JP4t9D9iNuVZc3B9lTqKFsS3pw1?=
 =?us-ascii?Q?QzaU3iUmFvAIbHSvkKcLNVmSZZNtHpGO4sWszH9ycOrt/5xNMJk3eDEp+mDs?=
 =?us-ascii?Q?lkMmJfrluFZYg/tCf+x1KYpMgbo3MW97Qys2L3zZrkkl1R73RHtXyt9Xa5qL?=
 =?us-ascii?Q?xXyEqHB7EDFlOHUBQU1O3u98+zeEzGLMV21idPaCx3OTpev6xfJ2zyAmOYHI?=
 =?us-ascii?Q?8S0EUW1dGjexNgTE0xI9NJnY5lHSjkUOhV0CYSfeev7AOwN4WZvZAf38XRwp?=
 =?us-ascii?Q?cPbgFFfY65fQk4k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:00.5485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 653ee758-0e31-401b-d2d2-08dd5ff2572f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

Use attack vector controls to determine if rfds mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ba7c2a1ea98f..32f850c80b86 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -712,13 +712,20 @@ static bool __init rfds_has_ucode(void)
 
 static void __init rfds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_RFDS)) {
 		rfds_mitigation = RFDS_MITIGATION_OFF;
 		return;
 	}
 
-	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
-		rfds_mitigation = RFDS_MITIGATION_VERW;
+	if (rfds_mitigation == RFDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_RFDS))
+			rfds_mitigation = RFDS_MITIGATION_VERW;
+		else
+			rfds_mitigation = RFDS_MITIGATION_OFF;
+	}
+
+	if (rfds_mitigation == RFDS_MITIGATION_OFF)
+		return;
 
 	if (rfds_has_ucode())
 		verw_mitigation_selected = true;
@@ -726,7 +733,7 @@ static void __init rfds_select_mitigation(void)
 
 static void __init rfds_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
 		return;
 
 	if (verw_mitigation_selected)
-- 
2.34.1


