Return-Path: <linux-kernel+bounces-397194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2786C9BD7E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421341C22C95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CAC1F6689;
	Tue,  5 Nov 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wA3tNv2b"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F71A216424
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843731; cv=fail; b=nljGeXqZZ4peE3UUHsTrCezze3xZAtShsdjHY1dX97450MxlJA1P5z1Ka04e7C2G9UxLyfa0ZokxSHs94iuaJGYtDVYZL58Reg/3b0JfDdXGKgMZCICvbhzUCowbRQwzbORVW7LbAIIA1CYRKldHcmo50Vc0WZnPlOsbqRSn4KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843731; c=relaxed/simple;
	bh=LcvOdJfryZrSfV7udLzLjN3ieErwFRLp7Je9kh2aZ88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVa3tjvpxU4w0/VcLrP4mwzyorqiP0ngI3VLfhiM4vn3eh8RNR8fQ1MgSWplrmH3FZxRAJZ5iIvwpaaBHL2Lnml4ygiYXxiveT9iDKQJTC44qGtL0vEvhPIe8dOAJv4/tRoWdqvbcqztA7W6se2R3GUfHsYxUpiSxfe+X4+NO60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wA3tNv2b; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7rfhVsl4xCsdJYzAfy76bouNkgzr2ZgOO5HgZbl1Nj2J6huR+lIhLM9fS2YwJ6KNKYWasIDibAud1RBvOfpdsvfAlVWW8gRO7nO6VLkBBItD3HVD4avgpNKFQI4szk6R5JG8LYU/hT+CF5L1Jb9O6nFNcsZ+WtZVoMIL/KjfWNivn7DY35TShgV0fnCeWZpqus83wPBx5BqRsHz5z0O5ze3jTTrHm75TfrlJmivCSpIkwYatG2Cjn3o543jhwQ0gzaiccV0CFzI9ymLYvydtSNJft8jvnvArPzX7Dw8nG96t9aITwRmw+kFTf5Q1clIKF7E38Ofy02C4nfNzW/VRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYca2WduCBaVkj4tg9THKA4yGCgNOQl0R7DokBNU8/U=;
 b=S+PGBiF9tSzhgBkHK9peOGzgyy4yCaWhUpMjmClojWXP+U60BujEgrINGfZUfYcIc1/W4VWduiluzIHU1w+flY1+Qx1olShPlQycPTPZzdg1k/hh5Lyp2PqTAKkBYTZvAEe0KGjx/DU1CI2zSQHjln4HHBmo0Zuot+mJG9Dm4M8VuJt8nTQqizAyFXhNoEUIQrcniP3Lf4v/HvX2JQfn5mocYNWCPGFHf77hD3fUNj1lKWlDZtGc+71MkvsdDBFfhAZQoj7hwm8gv53fn2JgLfAhKyqxc4v5w8Jy5J2uyK5w7iDMckhmf1ePWmgzzKP0Jv6nkh/GktGecwFjBMPbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYca2WduCBaVkj4tg9THKA4yGCgNOQl0R7DokBNU8/U=;
 b=wA3tNv2bKs58rHjmoBVq8qCDOZcNeQ3nkmeu7tEUiOYcTNEQPBm7LBuT4UEGzPvd5ACywNbSXU9s1RQCkp75H1OEgiAwtO4Rx2rqvhi6JfaaoJtT98pyzR08Jw8Rg0bVCg4+RuUMiQlXeW4fWIvocGRllYD9ayUdIqtG4dTRUnc=
Received: from MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 21:55:25 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::41) by MN2PR15CA0055.outlook.office365.com
 (2603:10b6:208:237::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:25 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:23 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/35] x86/bugs: Restructure mds mitigation
Date: Tue, 5 Nov 2024 15:54:24 -0600
Message-ID: <20241105215455.359471-5-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3f5cce-8f43-41b9-6a5a-08dcfde48dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iTmN+iaWjiVg1iiVWPw/AeAntzztLIA5wchs2Jh32PsEpS8D3ju2XIJABkVg?=
 =?us-ascii?Q?SrUDPeeWotJDrZzL50qxBMfo5V72b5SU7pFZIqxmu7R3x8OUSNZ6GE0ZkITv?=
 =?us-ascii?Q?76KqkyzESNePrWHFOj2yZMlYFUFSubFYDJiD5wFCUzdvoBJ5BnpnjCM8e3oI?=
 =?us-ascii?Q?SLZDmdXcl05JO2rvBREdN3KNpq5NX/KQd4uZj1f2RXo/Wpu2Od6Q1QRDjEym?=
 =?us-ascii?Q?yl01dARlddQT3H84zMYG134QSbLUEQc7CblxMDXPt8X7I7+AgmAfkRGQwKyF?=
 =?us-ascii?Q?PfRdlKY9qzW7WoVqB9+bqnf6Btq/uFuLubbqbD/TpZCrc+NDevGi6MBOMWMa?=
 =?us-ascii?Q?OxKTB9/L014MzLwJEkPQNOlkU3w+7dnqfErdpM1B7ADEMpWvAoJOzePQiodU?=
 =?us-ascii?Q?+uTpVEM2JAbrHUCVCCX75pbgUp9YzK8ns1SJQaSB6JIS7vpYDGsFgl3h5FoY?=
 =?us-ascii?Q?jAEyi6oTtIP232/E7QEpkWdFTYbaS8KJ/VTvv1Q9okA0knwklv95OIL1EuRa?=
 =?us-ascii?Q?j6kUqYX9+SUbHd37+fqj2qZCYisRkAIe249cIEb/8RWu0KzJJuL8GdGl/iEM?=
 =?us-ascii?Q?1a9GLe7MLOUJ8jq2IhcmDMQSUEYHx/Cbvep5DkIlkfx9wCiroABAswmp+EVR?=
 =?us-ascii?Q?JI1+lujdPpGhUSEWUrCR+a+Po5yjNpx6g3vySgonUV98MgZYgOKXKiFqaOUB?=
 =?us-ascii?Q?1cQ5eZJzzS3n8bn4QjVRLCe0bF5wbRI91g+ugYxAQIArLiVoDjIwCt76hyuH?=
 =?us-ascii?Q?RnmeJWnRKAM44p/Ksrv2PvHxE3issL/FV0CdDzmuyWj/8CpX9SClEEZ/ggNb?=
 =?us-ascii?Q?JL0DkEXY2qaJCaLmUyhuvThaVg97P+WA/qYt/4M6GVnTlRVOCx+3xc75OEUO?=
 =?us-ascii?Q?ouX40o2BHf4HqCXsJo+XvyMdzoCNwyE/QLX4hYSUMegXmMiw8oGO7t+IJyX4?=
 =?us-ascii?Q?l3CEzmrgIuQ3xf+iAT1mddD7uZXeqV9h9RJUvphOxCwA6nuPb4Qs/2pSFbsM?=
 =?us-ascii?Q?jepfdIv9d9Rf4YKf9w3TcKuLyMQSS8XffH1Vd2G0Uf67xlf8gcyVghLhlxBM?=
 =?us-ascii?Q?nLgvy/vWwf2JHsTzG3TTvFxe2mtAftyQH6H1V6vBgQt5DGe+xUSojwWVqhgI?=
 =?us-ascii?Q?9/cHpXmib4XzsrAoSVdeSD8yA/ogE5M4dJQ+44oBj8kKkj3ZQMQ1CJ7HUItq?=
 =?us-ascii?Q?VxzjPnZsoMp+8eeUVAPT3MlNLia2X+arqz3lviZAClqD7zVhfqsFUBAUtsm9?=
 =?us-ascii?Q?PKrSxyqlaVinljwRn6RvgRxgW5aJKu5B9CFo5Va/6fpuaVqYRlrK6YiqUG9Z?=
 =?us-ascii?Q?bq+c9E8HihGDPe7DbkFdPzSW0VFx/yp1GFNaT8w8GTkKh+Kjt7IY79wdD63w?=
 =?us-ascii?Q?UEpUtZdYHPNleAdAyBzvCmjbx8gUxHspHHuWBjvVT4dwjF1MiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:25.0465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3f5cce-8f43-41b9-6a5a-08dcfde48dad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163

Restructure mds mitigation selection to use select/update/apply
functions to create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 69 +++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 34d55f368bff..4f35dcd9dee8 100644
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
@@ -277,12 +304,19 @@ enum rfds_mitigations {
 static enum rfds_mitigations rfds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_AUTO : RFDS_MITIGATION_OFF;
 
+/* Return TRUE if any VERW-based mitigation is enabled. */
+static bool __init mitigate_any_verw(void)
+{
+	return (mds_mitigation != MDS_MITIGATION_OFF ||
+		taa_mitigation != TAA_MITIGATION_OFF ||
+		mmio_mitigation != MMIO_MITIGATION_OFF ||
+		rfds_mitigation != RFDS_MITIGATION_OFF);
+}
+
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
 		mds_mitigation = MDS_MITIGATION_OFF;
-		return;
-	}
 
 	if (mds_mitigation == MDS_MITIGATION_AUTO)
 		mds_mitigation = MDS_MITIGATION_FULL;
@@ -290,9 +324,29 @@ static void __init mds_select_mitigation(void)
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
+	}
+}
 
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+static void __init mds_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MDS))
+		return;
+
+	/* If TAA, MMIO, or RFDS are being mitigated, MDS gets mitigated too. */
+	if (mitigate_any_verw()) {
+		if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
+			mds_mitigation = MDS_MITIGATION_FULL;
+		else
+			mds_mitigation = MDS_MITIGATION_VMWERV;
+	}
+
+	pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
+}
 
+static void __init mds_apply_mitigation(void)
+{
+	if (mds_mitigation == MDS_MITIGATION_FULL) {
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
 			cpu_smt_disable(false);
@@ -595,7 +649,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
-- 
2.34.1


