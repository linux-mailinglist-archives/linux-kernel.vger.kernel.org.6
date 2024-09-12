Return-Path: <linux-kernel+bounces-327151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A850D97713D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F461F24516
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ACE1C9850;
	Thu, 12 Sep 2024 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u3Vb6gPe"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342EC1C578F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168174; cv=fail; b=mk2kwAI6HDtVeWhlOD/lOU9k4aZ2nS8GlJr8GZaCg2Buglpn+w0Gqt+N6h5REh8J4wgfv6TE9skKEyebXuwSvF8/wzmMBhGrCp/cNuFTYz/zZy6lt1hLJe/o/At63/PZA7UUr3mIARJQ5q1xPWYJUQ6CNHQlWRpZ1rhScPjY6QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168174; c=relaxed/simple;
	bh=7xUmu0YO6Tz6h9ql30iQaoMWmxgsRhUmXm6aCRQEVNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2VR136ulL1vLDNM+zEfK3AEy3nbMBqidInLqaWo0nq7FJnyXFL2z4x1CJBSXp9dnUuXTzSVPFXFVKADBCuzEMw8oY70sSQ6fl9wzScQ3wzP++PMzOpAViIj3Sc5r0YneQbCiLtbo53rscL33IncHb6ef5vXmWKewiBvw2OukJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u3Vb6gPe; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGD35NDtnCIVrDSnGRkL9Xsxi51w/XfHJVEEXJorLgLR3C1OTqsRh9uTDOO1vqY0gw5LbRFWOQE3lMADePX1xx31SozmmftXEC9HZWfaPHrFBCgDbaA+B8UcdcRrmBpcJsC58z/wxh+aOu1xXH2Aep89u0Dw7EvblrQJlXL/FZ4Ms8kdEJDN8/gJS9Hurn7o8aVHIHrpSmuQzFoHrKTf5rE2dqyJqpShfMmug+BEOrEheB0VJY3t3rNx9JyC6vbZSHhM3VYdiZ/XOE4/I3tpnzNVdZd0qJ+6kFpCMa1hieWq3guH8NVLjXUx306NIis4oHh7towfVVmegnXBqassig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEyM8JeEQopHtUCif+6CEqGATxpAr6b265TQW8AtZBM=;
 b=Qjd9hDHIWI1hE6IkgT3BhhF1SuI3wHIP5XMFUovqx8vzxant5xfiZt5IemrSJLGBYkM9TeZ6/kKVLRa5FIY3s1SsGtfSYYDi+695Hz4c/nQNWRNcuNWmfk3oSDZQfP9qiZz77BkRAEY4Ozeqr+cRKQS1oCuTj4jT4MJHXCB3krWe6nRgDiuUqieEdHOHEpqLxToQ1weURtZ6GSeUcpYIhrnb8sW+Cft04FV0oBsx+iy6uV4xNBovYNuPIq4oEJx5AcYGxNEek+rQsGUg3Jpj1D8aoyHWuPs9KrQv13ZDgM9PgXICy/yBpe1lTivVoPBO9DfLKIr5+FGrRuRFDppZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEyM8JeEQopHtUCif+6CEqGATxpAr6b265TQW8AtZBM=;
 b=u3Vb6gPemLARIYS7CPWpZhoYE/Lc+sMsRyZXT9W6t+mGEagj48JLvdKp3H3BDdEX2aJ6Eky7THMYYMPhaKOVRJjN+qgIeGoGe9RL9SCjUZrW155JfumtBm2HIIIKmx85H5z00c+CGeHrw/d58H6nQooBeGFG/Di0iu7wNlTrf1Y=
Received: from BY3PR10CA0005.namprd10.prod.outlook.com (2603:10b6:a03:255::10)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 19:09:22 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::9e) by BY3PR10CA0005.outlook.office365.com
 (2603:10b6:a03:255::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:22 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:18 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 22/34] x86/bugs: Add attack vector controls for taa
Date: Thu, 12 Sep 2024 14:08:45 -0500
Message-ID: <20240912190857.235849-23-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912190857.235849-1-david.kaplan@amd.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2e0138-7493-4e6b-354e-08dcd35e693d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b5q5BszcspDFY7VpCDoJlOjTuNUK0YbmCTF+00byDoUthpDZcteYKaOPDY48?=
 =?us-ascii?Q?3oOpwZT4jtgBdZ5XdNqvQEApDoIpZycxcdfUKWOYm48XFE3jdDfbVvTKII7Q?=
 =?us-ascii?Q?TyvKcyboaA3Rg5hyEx7ZzvtkGTtoSpBDBcNakXNTA76EeXDhYyp0S+40Jweh?=
 =?us-ascii?Q?hrix0etK8YhPSJ1jKfKb/J5FpQU0KjhufzsErylAoMwotUk9L1pyf6UcLDRp?=
 =?us-ascii?Q?rPXm/7B7Yp57qsx58Q0997eHf/uO57fe/7Z9JzJgmWGHNXvwbBHPVzYeIGrT?=
 =?us-ascii?Q?M2bWXbI4wOrTiTHafSIaeBXVODPohuFfaaWac19ovlW2XhAm/YlaEglvWOlV?=
 =?us-ascii?Q?0U9E/r9/vWjU1zsuwm7FYZOETesaZ7mipnmRzKuLWWPUlEnlh1ciFLwgYkgx?=
 =?us-ascii?Q?gJDqJ0FYFuZZvTjCTUh2xsGSJSLOOwNHtYScDC1IvAIhFovuaU/+FJbfyQD8?=
 =?us-ascii?Q?ojTPwhxUrtO+Jf9ZX2G4EAM2a4AC8Ot4689MGiLPbLyNhP/6ucpL/DO2W7Bg?=
 =?us-ascii?Q?7pIf4gxqIPC789okX/fqsJbCR2iCgdApJ00HykIhRFiW4AhOLgsFG7CkyNB9?=
 =?us-ascii?Q?igzQCrnWkACix9kKFH4ZKeOOt3M12kJkHxmpYT9PY0Za6EWspmy9efz/elal?=
 =?us-ascii?Q?NN+x7U7vvcic+UhzEDADpFdXHwZf2zoKGLSIasTtd/pl/i8QksdjT4k9Swyq?=
 =?us-ascii?Q?Z52Tgz9Hb/oDrG3YAb1fychNuAsCAGVuop51AMBZM8vA7BGd8IFn8fxN5uM3?=
 =?us-ascii?Q?kX4dT13frpp6lCP/bG3Lww6QOHIQYI8ExTlHxd125aVyiaeUiSxgPtKqDAFN?=
 =?us-ascii?Q?rXZzeFIAtAr/AneKKHX+Q7CiHtahcNmsJuZifxqDQm4G97vb2tMXNBVmD12A?=
 =?us-ascii?Q?5giAhfh0xbxjFPxUPvx39qzgHQs5ppRzOBJ/nPtSCKjJvCJbTmp2hP88mLSj?=
 =?us-ascii?Q?0VbVdx4dZOrwzdKwBdgLgItaUSNAJmyb/QWB4xnvxfienTE2L9cOm7GAYIp+?=
 =?us-ascii?Q?q+At9U+frVsU60E1rdVQhiSNadhTyK1+SFlTXx4t+/4q4Fl4ngkLvr5V5ueJ?=
 =?us-ascii?Q?RUagXlFjs9zcSCxk8lBkpbF8pB+bl7IbhRXEALLKSse/ryBiCTsOekqye/mz?=
 =?us-ascii?Q?rrEhw7VXTnXt+BUHkRwfJuohbHxDpCo/s5lDbO7TwX9ZKZkeRYQngCKKhmH+?=
 =?us-ascii?Q?JaXovuu1r1JnSgeFsUAKKbTrEfgr8ozhR/1AFu62dujR0eWx4Trk8wZW/C13?=
 =?us-ascii?Q?Nl0kOEGL2I6ZPtFB8hmOXEgTZ4Xwhpv/lwbz6Q5ZRLDm1gu+2nZta8u7K+4d?=
 =?us-ascii?Q?BcRD1nMd+t0+czs0IIHzMWs+bmAM7uTvpOaiQ8KwMXEeQJmViq///VElY/qF?=
 =?us-ascii?Q?S6sRhps9rYnys832HBBmzi+2Ea61IpcoDCanGz0a23rg4KOWR+jCOpevOVXG?=
 =?us-ascii?Q?mXDtAgBwQAkxz+jC0wS/VGpGnDsjPlPb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:22.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2e0138-7493-4e6b-354e-08dcd35e693d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965

Use attack vector controls to determine if taa mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a5fbd7cc9e25..f042c5595463 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -513,11 +513,17 @@ static void __init taa_select_mitigation(void)
 	if (taa_mitigation == TAA_MITIGATION_OFF)
 		return;
 
-	/* This handles the AUTO case. */
-	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
-		taa_mitigation = TAA_MITIGATION_VERW;
-	else
-		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
+	if (taa_mitigation == TAA_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(TAA)) {
+			if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
+				taa_mitigation = TAA_MITIGATION_VERW;
+			else
+				taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
+		} else {
+			taa_mitigation = TAA_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	/*
 	 * VERW doesn't clear the CPU buffers when MD_CLEAR=1 and MDS_NO=1.
@@ -560,7 +566,8 @@ static void __init taa_apply_mitigation(void)
 		 */
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
-		if (taa_nosmt || cpu_mitigations_auto_nosmt())
+		if (taa_nosmt || cpu_mitigations_auto_nosmt() ||
+		    cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD))
 			cpu_smt_disable(false);
 	}
 
-- 
2.34.1


