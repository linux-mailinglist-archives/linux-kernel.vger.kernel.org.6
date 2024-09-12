Return-Path: <linux-kernel+bounces-327147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847C977139
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F051F248D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914271C689F;
	Thu, 12 Sep 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tGpjEUaQ"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919271C3F1F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168172; cv=fail; b=HGbgA8REqe59qT91Dp1vugOPeRZfZcbAriP2VF3/vgFFVuAAmxAHJvHZokngVp8o3jwoq9+/gJXVbFLgr3nA2Md8ElfViXZHQDAhfxjSgtYJ62tUHGH+eixTtjNuYNSOyAtIPPsFO5iAIB9gqzSzviIR6Z+VpeML7VBmx09wXNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168172; c=relaxed/simple;
	bh=fHO9Apdbvzh3cE4ZQB89Z9Pp/S/eyfSTCKQOxCpxjbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Quo4sLRmqfm1gvGWPrB/U4CJbdsxjy+pj0fhrc4kUpZkMc4GhjKy1u9z3q/vRuX1j2j/bfdqSTBZdrpMGEf1qQMyX7jG2lApRqiXRaGRiM76JywDP58qawQwwpCsU7FExzR71ZmI5EWp9Enz44fr3pVXGc3CUrRcZysMaeNG9NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tGpjEUaQ; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn9O2DrG85ADkEqBsLSGpQS4btNCmvAFBkYWeFkO3Si6OkOTM0qnRPwS2m1QC+ZooY0QuC1okkCSOXjIm/iYEVMGkgYz3ZoanU05eRmy4DVlSIlz4QX9UtaE3RRbxmNDsug+x9GYNLZwDDpl62wvLiZ+aGCWAagHMxkIcg1dAyLa9bm26aYH8+P402CP4xwD0DV+6cK8bJHy3U8Xwl3V/1lWJOmRB+xG00UN9CdoTljQrWRc3T4dxDZyTPrrm64sJj17tRfjDKFNSb41l4oZOcUNEgKDtPZEMCUekP773ftPfPM6aGAgrfjlmqXPmh8cixzBiNS9kywfX+rAcRVTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WYTevq1lQoIboFPqigrvDmK1MYuZ8L4fA0dR1kwfss=;
 b=cICqGJqrrep/AQoaqB1iVUhqKH01STnmjzx31iPzxwUBrEbzblFT58D9jqRsQF+vAViNYQwiPVDRTTE/pjui+7gnfxZ2shfr6gQDVZh+A5BbEx5uRwQewiEO12YdJdGl5QQ6gpIpLg6jQTMJjjm3IynFwrgjRDbXXoBQG0VIn8IEtdPx0JJa4mZ/qoNY97k1SrURUbUQ4YotB0OAcLZWV7yR0ddFMewMPz5R/dD1SHuFRgix06Xda2lDAtmzA+IjaPeJyj6MEGJuJQfw7yF0rMIXwfWkbzMp20xai/bCJ/lQRB9lDpslyyNClqLLUOlnZELFZw66UHcwCB57gM6KZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WYTevq1lQoIboFPqigrvDmK1MYuZ8L4fA0dR1kwfss=;
 b=tGpjEUaQU/rZ7EHOwtXHq4E/uM+VsNUDde+JP+Io0ca4XxFsdtr/J3w7JNN6MaofUwH+dS9yEnaBHAkH4IF8W76JJNSlP5CS97feViH2C/zAStiihQeJpE5PYrFjNLl2897OYiL3AzZWYiI7IimOiIb3DW+6WVuQxoNeUSMl8vc=
Received: from MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::19)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 19:09:23 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::5d) by MW4P222CA0014.outlook.office365.com
 (2603:10b6:303:114::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:22 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:19 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 23/34] x86/bugs: Add attack vector controls for mmio
Date: Thu, 12 Sep 2024 14:08:46 -0500
Message-ID: <20240912190857.235849-24-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f58e585-bdda-4ddc-9e2f-08dcd35e6978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?faUTH1f4QtpxmhI+ngF95sbRyj/lFTPDrMRsV0qh5ePi50DMApkX93vfG4lY?=
 =?us-ascii?Q?FS+m0MQaS2GU69My6pIccJ59eWJyPVvRV0NV76p0OcjWm8uVoFtxcA+PYqRe?=
 =?us-ascii?Q?LH7P8O2WxHD3KFBwLtWQPfH2BUKOqBPqSVuCdbPo+ELzSKqBz93QHN6+f6UQ?=
 =?us-ascii?Q?rk6puM9CL7+XhU2T0nYNID19Wnjs4OvC+UFwghXgncunjJni910bzyYdynvY?=
 =?us-ascii?Q?NVi4zx3QaSKDPBzdSYSNaYaZWblGBQR3tzmtQT+7tka+VSVwueOZqA/V5TR8?=
 =?us-ascii?Q?UTM8z+9CSLSl4AGwyextx1/WXUPlgIgGzF4J4HDOyimyIOpMGb4ortuLx6/a?=
 =?us-ascii?Q?iEJpoTT2R0BA8Wug45xNzyj8iSrECclooEtAF6ARkueFP9s2kxdUod6z+Wn7?=
 =?us-ascii?Q?A9b44eeYX8ZtZKSWi1pgPcQQ16hbyiMZ5eBB3wmUG6RC5M1tyjh3ELRobz5U?=
 =?us-ascii?Q?87lNALBif/XC9t9mnvba/C6Ixn06xBeZzLzx2o2CxyQBeIwIM/KpKAA1jjOa?=
 =?us-ascii?Q?VWBpcLj4uOoWUrokN1h0ZvPSmI7wHbTOQNQtwJCJaJqG2U5ZoHW9Of4tnHgW?=
 =?us-ascii?Q?Gra68WpUFOFN+1hnhrEzyqxcu7Oq3LGKxrg46KWXWhPEJEF22ZmGtx8u0QI2?=
 =?us-ascii?Q?faAQg/d2SQgMrdNH1/+dzAW0VKdDg6MV1Vu2bsy44jJbjGLTMKygLzcql74E?=
 =?us-ascii?Q?eODhpQbamNbonJgNMIIFgC4Jpho06GTXjasq4L1wVAvZKnvAjD4RKsnn460s?=
 =?us-ascii?Q?v8oBpFlbewiH49C2nAzspnoI5AmP6WoGDNGNe+E+45WxdmD89Eh/xvsZvw75?=
 =?us-ascii?Q?2zBPaYoydRXyhE0u5N0+3Jt42Hbgg7GDnl64qmPmnxSL1rgMjUQ02W3+dISt?=
 =?us-ascii?Q?AQVuYGq+BC9/lTbtqRzNxMeuALG28ZLDbxSdlpr1fjiTOkoJAyv7TgTt61v9?=
 =?us-ascii?Q?zcTf8WFwLrtvjq8xFVYqHUBZg8sZkWJ7/qPVuXSDtbGsRG1ZCrHzJc5FpFjJ?=
 =?us-ascii?Q?j5q8gXGtoUS8HOQQd5z1TDAJiaU668yqfL+t7WNPzA6hqutSUdRVeJeMaHLt?=
 =?us-ascii?Q?F32as8WV15v6CoB7m1Ck6bILwiwn0bFuFeWpcEJzjn/tl5T31rie35EE7arb?=
 =?us-ascii?Q?+d+kKNdPBOX6UessFPqOh4fWgIv64hcdCZM0lirtiU2JAjn70wTkollt4xJK?=
 =?us-ascii?Q?PFe7hHNKoZ1QotSb/DKk7pzNORpMpoU1tyoQnGrYSp/b5vCVY86DdHf+kA0z?=
 =?us-ascii?Q?7K9qWsRMlWcMXGctqBmtVWb9KJx89039Vit5fk/gCEeiTEEjHF3wl7BSKh4W?=
 =?us-ascii?Q?EXQYN4TBEOotUBo7trYRhATxYa6iRQs2BBS8ejkyYgSafems4krHH5BfVzcU?=
 =?us-ascii?Q?B5TFN3nutUhXa2Z5gpahWgLJRcoysBpZ3xCbtW7Q4Eh0YH10bJfJQcBMwHHL?=
 =?us-ascii?Q?GRBBN7hMKW6Gs9u73XpAZkD1kJI8n90b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:22.8104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f58e585-bdda-4ddc-9e2f-08dcd35e6978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420

Use attack vectors controls to determine if mmio mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f042c5595463..87ddf0b67d45 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -614,20 +614,26 @@ static void __init mmio_select_mitigation(void)
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
-	/*
-	 * Check if the system has the right microcode.
-	 *
-	 * CPU Fill buffer clear mitigation is enumerated by either an explicit
-	 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
-	 * affected systems.
-	 */
-	if ((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
-	    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
-	     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
-	     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)))
-		mmio_mitigation = MMIO_MITIGATION_VERW;
-	else
-		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
+	if (mmio_mitigation == MMIO_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(MMIO)) {
+			/*
+			 * Check if the system has the right microcode.
+			 *
+			 * CPU Fill buffer clear mitigation is enumerated by either an explicit
+			 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
+			 * affected systems.
+			 */
+			if ((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
+			    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
+			     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
+			     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)))
+				mmio_mitigation = MMIO_MITIGATION_VERW;
+			else
+				mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
+		} else {
+			mmio_mitigation = MMIO_MITIGATION_OFF;
+		}
+	}
 }
 
 static void __init mmio_update_mitigation(void)
@@ -675,7 +681,8 @@ static void __init mmio_apply_mitigation(void)
 	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
-	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
+	if (mmio_nosmt || cpu_mitigations_auto_nosmt() ||
+	    cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD))
 		cpu_smt_disable(false);
 }
 
-- 
2.34.1


