Return-Path: <linux-kernel+bounces-397210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC499BD7F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F0A1F25C91
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301321643E;
	Tue,  5 Nov 2024 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rd7mynQn"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FA217334
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843741; cv=fail; b=c4P8YhMvyhRCFme9BEPM6KiRZ+unMPR+R3NSrZwD7kUWNRxPe3TYNvN7G2mRTh7p7kyJ2m/QMWN8gDnBFEdZrVUjt3PERoL/8mMZ1Sg/3FdiM7uxuvR6PmlOGe1+JQ0qVPW1QnQh8vg5dVQHqfVmsHNo3GfK43YjnT7rpM6PAnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843741; c=relaxed/simple;
	bh=djNZ79Jt4J/tLPccjuYugwp8UMuejY/agXQGn9te6Zc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1QKxM2g1sCa1iADTlnr3xErrNg4wObdg6gOn9LulfwUVz7I9Tr2K5VIA9b/XWNiGEIeH7iNQUfRc0OxT64C5QePtZtizfMM50aGEn2SIj4KRR0vmrMBYgoHgIPcWQebvUr69DFwEOhz473QzSpb92ojyoAjXk3sZnVFsOFJTrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rd7mynQn; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9YPEChPjLz7liOld+MnUkC12zq0PtDoaVF0hbOU5m7+kiRijkPTV1jx+KSKbgG3ZBWaCSy93FoLM2fZHYnd5PA6lojmgUlFj+FP9P7MnE89WQfSzr9dTCzNoDcx49z0uV79mP+7cUtIAEUhn0l0gvcitFTzyWVzkhtrUDdj1D6cnFHx1CpqrVWS+Xg2HDKdX18Su8k1IjN+vVY4kIqbEg8OyITFYZ+WFKjw+Mb8TAjflYjTmlhMYnIiAm7Oi2YPU34B3+ds0ybJ9Lw5sKVRIiy1VuoWzHJeh4i7paiAbx/XxJ2QslSxZeH+rSbVDlh0og3lhHv/mA92B4JQANGhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n8uPPpECp2UpIWGEmhow2mWPOxEx9CWPa/TSQxPTdU=;
 b=e4uBvTiU3LrupzexXY/Ae6pWkVsAb80jRSsc0G233+c+NlpqjxnXWhpzCaO2jxqsihVHFZ1h9MnWs3sIygGLf6JGFY8aY/yBWeHMxdN+zUOx75Jga6K8Ao9LuVt5ilZMJSbEM8vi3VPbbHQLZWDtjQiKZS/0qIN2jAF7uuUSMDmz1HiYb2xcgofDw/ptgEFRnMHodr/HKhieW3iE0Ja1WdOSQH7HIhtawg75wWUlsLRfYBa9MjZKpJCi+N6vDxq0DnBFQrxU7BoMtcZ8bfZsYIInnSI1hdSqNNwTJYhz7up/8Fl+0P37E/Gm5YZf1S1sr5S+s55ZKMdJFahKFFtMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n8uPPpECp2UpIWGEmhow2mWPOxEx9CWPa/TSQxPTdU=;
 b=rd7mynQnBwtLm8lwO9vTewjLgJ6qwg8t1ePvmOiD8VxEA76ixfJytoVv4wEW4FHoamHCEUzgMntVdwrHxWZzpZTIoODrGB/wFVXlFQXQ+XU2/H6mZ6IVSNL9N/yydNKHmiV9IEIy9e8hY3ct+D61Axv1FMVjWTjdJEI2pI8X2f0=
Received: from MN2PR15CA0044.namprd15.prod.outlook.com (2603:10b6:208:237::13)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:36 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::df) by MN2PR15CA0044.outlook.office365.com
 (2603:10b6:208:237::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:36 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:33 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 24/35] x86/bugs: Add attack vector controls for mmio
Date: Tue, 5 Nov 2024 15:54:44 -0600
Message-ID: <20241105215455.359471-25-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adf3894-12d2-42e8-5887-08dcfde49451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SRz7R1oJaOiOtIlkw60OfWDzWH6azqLY5VeCe3chzH8HbbKw7VPN1ytHxhHh?=
 =?us-ascii?Q?/GX131h9jRfyy9DsV8aFQpVYw+bgEkHMqjrhLz5gq17i3SU49ZjTM29blvAu?=
 =?us-ascii?Q?HtaOt99lCqevQmTC0vYLWkhNdvfhyci1W4O8gP5ZdtH3gWTUimlLOXxI1VEI?=
 =?us-ascii?Q?G3HMwBbk7yF5Cvszi0rKWhkL7b33b7Aw8JQAQcKpqiF1fC6bsZ3E7KSKvQz0?=
 =?us-ascii?Q?T51dIQnmM3+Jg/PT6E1EDuV8rrpIvV7HcIFTT+X7kL9ZwZiGM8SWQxktldL4?=
 =?us-ascii?Q?VZZsAC4gdiRLUrwfmMQ6xThkxL2gd546pzP86DGbt1ZUmQU6dEeERgHpt0We?=
 =?us-ascii?Q?WUp4iXvhVz72utm+NLp+B1bgQ1CyVSwIQe7ZlJ8LnGsTMeyrqGHlU3ofR/+p?=
 =?us-ascii?Q?jGneCQRiR8cw8OoUXf0x5XTPbZVFGlc85fF44XeD3WXcqyIBo6sHfUGDRYsk?=
 =?us-ascii?Q?lLFCwXAD2A9MJI54QbgUjm3mNN8bCRyP6xfTK6MkixW/jx8zdr4RDWMydT2u?=
 =?us-ascii?Q?OnMgKYHi2nOfj4FuBJ8NMI2e+Tj5mvkOlRTgA1y/SNKZJzK4r4gNOYhSQ5Gi?=
 =?us-ascii?Q?NksQQDJSr5lA96aIKTZ6xitK7mfQDHdclOS4QIEu/+QWAQUTt5HH3no/LHZ2?=
 =?us-ascii?Q?+HyXDctPcDAOClgqmbbuA5g7k+N70mhKP/l+209HC9eDb08T2dD3nw5vF8Wm?=
 =?us-ascii?Q?cSblnk87lJ9X9m4WHdLayzln/N8xXY38sOui6VeiyS320MhrP8w7HeYgkiXX?=
 =?us-ascii?Q?l5aGAT06XjnGLxWg9xLgL35xhwyEcdrgjxGgDoje58uGB0uF7mFPFIWgusbY?=
 =?us-ascii?Q?MFnIW/mKUZhafuwi7AAsMMgcHjgy4xflUzqvWAI7cwPEye5sah6FCPNTcqmB?=
 =?us-ascii?Q?kuOkRamoLrFkKWgJLuUkR5HgAJMmpmyi5WZN2fO4KY6uEZ2HpbtOtU4MfB1A?=
 =?us-ascii?Q?JSNOuqZNHssuL/XiCLhpYL00S0HN5y8OGp/WWxyBfw9SSWEgV/pKzA/v6B5e?=
 =?us-ascii?Q?NZowZiSxxVk8mlLq8/H3EALn+z5Fel4TGp20QJy0osjpXfRj6mWbZ2Vicc9F?=
 =?us-ascii?Q?jcnEUzVSCZ7/gro7uoPQPt5UD1rU1rhMf5kb5gihCg++bjIm+urf0glUbN5b?=
 =?us-ascii?Q?+KxI5LbZTGspkgVyyAWuTCT5DNd9j0efzqdj4lsx0voN+S1WZImIxUmoo+8d?=
 =?us-ascii?Q?ZUTXUqAI6ZqxMaca1T7DDrtBFjLMyqxlMlfukq41m2gapASg6Y4tj/gfO0G0?=
 =?us-ascii?Q?PjuOeRRTi6DMkBpJFx0YLaYguJnc1MLSKlnezCW0cdCsxqr+4Yl3VlLMPc8s?=
 =?us-ascii?Q?g2oPFs/3olowPzs/3eh6LZ73f4A2tN67q0cBDrMdBRh6oLKIF5JzH60KrJkY?=
 =?us-ascii?Q?YzUy0onQP7sqlTxWNSzye7Bf+n7cg+dA2x+9f62aqk5jEZtYlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:36.1872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adf3894-12d2-42e8-5887-08dcfde49451
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967

Use attack vectors controls to determine if mmio mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 431182a0ecc5..ab1a8ae31588 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -612,20 +612,26 @@ static void __init mmio_select_mitigation(void)
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
+		if (should_mitigate_vuln(X86_BUG_MMIO_STALE_DATA)) {
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
@@ -671,7 +677,8 @@ static void __init mmio_apply_mitigation(void)
 	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
-	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
+	if (mmio_nosmt || cpu_mitigations_auto_nosmt() ||
+	    cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD))
 		cpu_smt_disable(false);
 }
 
-- 
2.34.1


