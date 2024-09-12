Return-Path: <linux-kernel+bounces-327122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0F497711B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE06FB25144
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377561C174B;
	Thu, 12 Sep 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yXHsbkkj"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB01BFE0D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168159; cv=fail; b=nwFfz5yVuUWFKbcE4MNV+77N/i28Dx/J1ygM2yHn28UGSmu94NRGkcvf8vhcIrRCWvQDb5Y5X+5AmC6liqHqYPVhci/ttHUw0Osx9eYwKVLWfo8Dzlio0548vspUk0DZjOFWeZDFhpFdW7h+LE6btbanmzZtuXxNc/87Yrpzj1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168159; c=relaxed/simple;
	bh=+CYGMB4pVLRe5WH2LASMqCUfPX+if6bA9ByWYcCh3iQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNEIJzuzydwYgLMMw+RPyIm1kZq4H4oTcH4iNHWKjv/PUocp/TZ63POWCVkk8LV6hQWJ4n0b8GLV33810B8j294L9qV+xtaAAeyHTVvSpB5dYz0h8s4oiGrxGC43Yexwdvp+X1lt2TYHWhPE6C70s0tCf4SiT7uInZc6wvNWwIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yXHsbkkj; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbfZywicSYW+uQEjpNmbvonXsaRlIVdivdbES2WdhSqq5umJEbwDS/pPEi7oak6YnezLQjZC59Cn6CxSajmx8pzHviokUPvGGdCeEzn7wylp1/KfPwgwR31YsQYldUsHlOm6NAoYwrNam/t1QZrGOD/PoQJtCzGaEdZlQ8UclqLWi4jvRa2+IaUwWnMZjIAsViR2DXoMwJr9WUyGAUiYWjW5WizWxWSeVx3HfCO1/CgvuW/bOPxCP1qeanBPDmDdzGVtZb4Ks0qukOROGnnT1wdCBeBBhsiMEtpSJHv5AZXpmDtiDamuZlOsgQDOGl9z7ucVSx/GaGqnOw+edf2l3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h/hbop2lbzZqx1PnHLmIpOGYnAbuYuU6Jv7hdO6WU8=;
 b=MZZK2dXGSBEYtrGvJA/CeSiFobkaxZH8hzVSn3a/VaejRMKNp5qdhfFdT4IZm766vdRMj1QWnpql/FEQDFoGgY2nbjpQeH8y4MSYm7+l8G84WeRtanRs05S1hUARR0ygHxgaBZJabqPUBYaoYVOogWjlT/WxU1feCsgDYGKC9EqSR09Dxg2/TxI4Bn52cLOLY2B81ylIe5I0SfPFHVc/Ut38X5vAueEd9+HTlDp/5RnF0ytg/WWMP3G+Zi3qn5Op7AbvdpsjpRUfkwOEIonH3NZTMN5RKDSweQ7DpfcaQuyFbKGG517I/09nElmx/rmAkzkw0uVFl/l3wP01QREY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h/hbop2lbzZqx1PnHLmIpOGYnAbuYuU6Jv7hdO6WU8=;
 b=yXHsbkkj1AReGeAb6hiD7nkb42ehWjxlozO8zBWCTRsKPA74jqrZce9jp3yajITYcwZgRUpGyY+EDR8eq+MOeyRSnHcp78U2oRkDOvc0QO2HTddkvYdFR3HWft+gdPOxH9gVCaZ4ZMah9rfTntFZC5XL+pwT4JCGl8kq55nVGn0=
Received: from MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::19)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 19:09:13 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::de) by MW4P222CA0014.outlook.office365.com
 (2603:10b6:303:114::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:12 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:10 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 03/34] x86/bugs: Restructure mds mitigation
Date: Thu, 12 Sep 2024 14:08:26 -0500
Message-ID: <20240912190857.235849-4-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 8588c9f6-56b2-4278-bb27-08dcd35e6363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fJasT1Fn3Gl9We0hP6jO06pV7h7V1h/FKrjPXX4CfWElhvWHdAU8KhOLsrv4?=
 =?us-ascii?Q?Dycqr38KCQW5ck67YaLqHMnBoY+lI/XqEq29k/5P4k9VTE4si2yTY1/WlCLI?=
 =?us-ascii?Q?R4P0qzNHlI0E2NnMhaBvnOZ0XNuXNEvTydn+ugOHD1VaEJ9AqLLQPFZxGPGO?=
 =?us-ascii?Q?C05IRgML7wAWyRmyHmdAVs1nSPSEFe7c9R3KFbsJAQFViIA4bRx43+El+yy1?=
 =?us-ascii?Q?Jgt9RAMCq1karEmkAX5/3OPO0YGADIH7aLyjYipsdPJP+3AgNbzJiGBXoNgp?=
 =?us-ascii?Q?lhuiEvhs20cmb0j/rPG+LVJS+ErSzA0hxinlfCVnJNPKaNaF3FPSCuY5uqwm?=
 =?us-ascii?Q?IBeKkHewTUfcWSThlEKgfbjtAulqbdVnuu/Jm0UTjfXjB+gv79+4pmfOz5AZ?=
 =?us-ascii?Q?GXn487XL/3PW7Vder4b/czX8ZM11DT4W6AOO/UgqAxfVLOvpszHfJFSTP2vH?=
 =?us-ascii?Q?M+1487JMSkNsdLTx0WVmk6vKzYu5yzLQsylPjlUHtjiS1C6d0So9ZH1ni2a9?=
 =?us-ascii?Q?J9h23vYrEZ/BoUWf+RcN/UXuZ8hYUKHVt6xFTWhfvDQ9J7riuItbHGgYfdtW?=
 =?us-ascii?Q?w2EhZdA5WiQ0nCnV6oZV3qtq698wU2AvFWZ941nmo04a3YZUs5Z9N3tE/zxu?=
 =?us-ascii?Q?BdjwgdtK9QkXSYZ/l1NzDZIm51yjqN8bNljSpohPXUhCIYdrAHXF6A8bmVw1?=
 =?us-ascii?Q?PHN1slPUBoOfuVhxqZ3N+P4b8WYs6ageMfp8YzysQLDsh6OOmkGl7rPBhuis?=
 =?us-ascii?Q?ie4Vjf0GTWkQmRd8XYdF/HSg5lmvhlXauLzxm8rBVJD8U4jAoFI0bGaySLrV?=
 =?us-ascii?Q?/KJfh0UHLG1g3fuQ+fou45TfIIGSX/BuHz8YbPELZ34imt821acyRqYcYE08?=
 =?us-ascii?Q?dOPbzijGs0JDkhHKegc22010UZI49bLAtEhKe8Vrx5YQtXL2Fqg0qaoBfxq+?=
 =?us-ascii?Q?NaI7k5Qt8gFLHvS/kvW7bOXjL9jLgvGzqNGuUGUyV+0IBdz5OWMhkfrfKAwh?=
 =?us-ascii?Q?Aw49WNUYXnJtcXcnwk5Df9C+HcrEVP9nHPfiLljwKycYy7SQXKicSmIDkrlr?=
 =?us-ascii?Q?5inHhtGay+Mz6XZG9vjgnKZuNXJ8IToUZ8BDbKUdbocLvW4IjrJwAQCcT7Oe?=
 =?us-ascii?Q?RGPSLaAsLsrVMpduKsxGNBW2B09W1h/jsAZAe+Pi190JxpLuG0EBViRLYb4f?=
 =?us-ascii?Q?2fBjTLL2KObyB10alGefewJ0B5gQY3OEEcgG3pmgqARyupvG/4XAbVXDqTSQ?=
 =?us-ascii?Q?Aky9umpVnx5PwfSWG60F2ykPCETKF3NTQT5zXX8rcq4E0n0dVigWn3p+WyY5?=
 =?us-ascii?Q?ZNTEDpJYtrAEG4xjshU0Ec3lq6NJ3AOo6uqan79tMGglepnhO/vgAYCVo7u/?=
 =?us-ascii?Q?3G+f6/kViIFFXXnr9KzMIDQ5vMPliSkURNWmasfeEbNESBLD9D/HCDYAnZ4u?=
 =?us-ascii?Q?2IS7E7Vo4nw7bWCK+ZJ3SocvpvPgxy6f?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:12.6228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8588c9f6-56b2-4278-bb27-08dcd35e6363
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028

Restructure mds mitigation selection to use select/update/apply
functions to create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 58 ++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1cf5a8edec53..0bdd4e5b8fc1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -34,6 +34,25 @@
 
 #include "cpu.h"
 
+/*
+ * Speculation Vulnerability Handling
+ *
+ * Each vulnerability is handled with the following functions:
+ *   <vuln>_select_mitigation() -- Selects a mitigation to use.  This should
+ *				   take into account all relevant command line
+ *				   options.
+ *   <vuln>_update_mitigation() -- This is called after all vulnerabilities have
+ *				   selected a mitigation, in case the selection
+ *				   may want to change based on other choices
+ *				   made.  This function is optional.
+ *   <vuln>_apply_mitigation() -- Enable the selected mitigation.
+ *
+ * The compile-time mitigation in all cases should be AUTO.  An explicit
+ * command-line option can override AUTO.  If no such option is
+ * provided, <vuln>_select_mitigation() will override AUTO to the best
+ * mitigation option.
+ */
+
 static void __init spectre_v1_select_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
 static void __init retbleed_select_mitigation(void);
@@ -41,6 +60,8 @@ static void __init spectre_v2_user_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
+static void __init mds_update_mitigation(void);
+static void __init mds_apply_mitigation(void);
 static void __init md_clear_update_mitigation(void);
 static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
@@ -165,6 +186,7 @@ void __init cpu_select_mitigations(void)
 	spectre_v2_user_select_mitigation();
 	ssb_select_mitigation();
 	l1tf_select_mitigation();
+	mds_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -175,6 +197,14 @@ void __init cpu_select_mitigations(void)
 	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
+
+	/*
+	 * After mitigations are selected, some may need to update their
+	 * choices.
+	 */
+	mds_update_mitigation();
+
+	mds_apply_mitigation();
 }
 
 /*
@@ -229,9 +259,6 @@ static void x86_amd_ssb_disable(void)
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"MDS: " fmt
-
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
@@ -290,9 +317,31 @@ static void __init mds_select_mitigation(void)
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
+	}
+}
+
+static void __init mds_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MDS))
+		return;
+
+	/* If TAA, MMIO, or RFDS are being mitigated, MDS gets mitigated too. */
+	if (taa_mitigation != TAA_MITIGATION_OFF ||
+	    mmio_mitigation != MMIO_MITIGATION_OFF ||
+	    rfds_mitigation != RFDS_MITIGATION_OFF) {
+		if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
+			mds_mitigation = MDS_MITIGATION_FULL;
+		else
+			mds_mitigation = MDS_MITIGATION_VMWERV;
+	}
 
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
+}
 
+static void __init mds_apply_mitigation(void)
+{
+	if (mds_mitigation == MDS_MITIGATION_FULL) {
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
 			cpu_smt_disable(false);
@@ -592,7 +641,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
-- 
2.34.1


