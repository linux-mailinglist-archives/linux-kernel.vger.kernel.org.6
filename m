Return-Path: <linux-kernel+bounces-554678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C414A59B47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C15216DF53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D17230BF8;
	Mon, 10 Mar 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N+8SxiC+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868312309A8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624841; cv=fail; b=IIcoed00miZlO6ePlJc6S/zSsZNqCaW+C8Oh5FPlAMoqRNb850KM+KOJxHpGKlpBYZkkS70sDFkhVdRdfFhdBFIuCvmR5coMO2LKK8OQvU8uLwnVmchATaLZRIpuGX2F/00ZpxWqhexpVrXoMyJ4+t7UNTZUaadr9+/V6ecq/mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624841; c=relaxed/simple;
	bh=L1u2MJRGqXUj4fJEoeyc95KP3e1ivS3Z8ABOW950Q2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axwGkMnfoH8WNaTHnHVvP3gavcwX7D/preApSZs4A4F+TwXmWEgDVX8h7xvUVKTlyr8LdA/DQseZOPiZJyiP5tD654zBKouMORMBGbSY/ZGDDvvfP3MmtYQZZEbXpIvMWkLmOlFJK858cyiOKwmKAI7nX4ZE44V4QhvAuItHlhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N+8SxiC+; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmtWzly0GSAmG+AaibRrJA4cX81JrpJCcDuPwxk3THzgtzfPzG+Q3vg7Rh1gvaoaDVHVmlFjzeFqiq3ZPAY0DdrJ0UKRQVKsm4br0zHjBYntoActTpG6Sv8ZzrXxN6TurVZDY9JpWFi3HTXrQ1Lr8HG4An3Miq8OJzCTrM9keNeBeyeKSm0hRo78mzHlUlTvoVWnbWrUN1rhF5bECNW2R4W3+n8y31tpKs+BUAytqhWGuav2GGXmh8j2XUvrrTtP8wxeqthh+/iZ2KbD9T6LArD6WV/1VU15NJSGVo6wuA9UkF3+W1E6xiJksXNE2IVmdiqOp+XuQ5evhS/BAcPulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1vpDB791O6bK6bWgOo2SONuoiJZfuv6YBsDLc66UyU=;
 b=Ee/cwzFu9Ola+Lk2NgnQgWlkRGaAMuiqra5tvW/NurqqWo9P7QKWnmR5m8XzG8s+DLA5ZS8LQ8ZibssjEYWgyc708hZ1gJUn4OLzD1eMuQCVA8qrPz5l/m/9crlOX2VLIDy7AFj00W/CHd+VNWbXlc+cijVJQr6k/sAw9PszyIIKoaZ3bRLu/TqpjVFJD3IQtPU05mF7au2coiB3eGXPRIuTwHuI/LXAIw1npul/YUhD1CZbXh98Vc/Lm11S/KT4DR1VDywEK2KmIELzmacGuJYoBbXYl3J8lytQgy4FHRQumfDUBFuRTZEvCGMGVhZkTF8p1wj2wjoRSNm1qQUQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1vpDB791O6bK6bWgOo2SONuoiJZfuv6YBsDLc66UyU=;
 b=N+8SxiC+rtrFYPvKM72NJrul5u/kIg+iuC/zMCYioAKDmcp0R9dyL3mTvOFrMXOe/VCa0tuLTkAfmjDIsSHRFGXvaDflTDXXpXhVhksQhqqAkcBBzaLdIzT4eyxg3Tp1qBa6hgRulJd88f+OHH66FWNdWQaGiT0mTCFA+uoj9kc=
Received: from BL1PR13CA0063.namprd13.prod.outlook.com (2603:10b6:208:2b8::8)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:34 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::37) by BL1PR13CA0063.outlook.office365.com
 (2603:10b6:208:2b8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.18 via Frontend Transport; Mon,
 10 Mar 2025 16:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:34 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:33 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 01/36] x86/bugs: Restructure mds mitigation
Date: Mon, 10 Mar 2025 11:39:48 -0500
Message-ID: <20250310164023.779191-2-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adae8ff-1017-4fd9-2597-08dd5ff247c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oCMt4pGzfAYxn3AH+4+0QAbe2JuWEjzC0BQWj7/qjgsYrGhAV3yyXRi1PLop?=
 =?us-ascii?Q?Zbe4Y02rmE4cIkzX5fxdM9qyUG7bYRJeKxSADOOPvVjHTYlLge/9PygpgXin?=
 =?us-ascii?Q?N7S6h8XEp/aTzbSd+GCnv+YVBz7g3JzSK+C9RbVDMA5ixjEdWEJixBxoL7FK?=
 =?us-ascii?Q?Z4txeueEc/BoTEdJNty3PYmW97BCXUcQXbNxJ14accvXIF+RKjAS4JkxQJ9R?=
 =?us-ascii?Q?73Kn0K/DpcjLtPFgiwmL+fZp5Xxzdc9Fc3T4tRUF6m3R0Q8B8fAUwJwaQ21J?=
 =?us-ascii?Q?DFEyK2g88xVTz4XJ+y2VAVZBdu9N+WWFCwixOqLEa89PVMmbjz76jPsKtuLr?=
 =?us-ascii?Q?ZYupB8FYusn3bKd90BQ6/RnOkMRgkYB82IW9JfIOPK3iUJysm1gfbhBDkqMG?=
 =?us-ascii?Q?/RdroTBA35cR5ctfA2ayeE8C9QHyYj9BnN0RyBH8d5WbEIm3puO0Gb6z0JEH?=
 =?us-ascii?Q?FkonlrkJm180amvOcLu6HbkPQ76Uva5/YBQS+2DnkmjTlnxILU3htcEu0kMa?=
 =?us-ascii?Q?KZpibGiMI7vQUE79Q6STnDDN03ROJ0CnP0+7H8sjaV81XEOJupkloqazOGNZ?=
 =?us-ascii?Q?A+PAHrVE7bg0rSSw9J7Svxqs4HJmVNQ7320s8MNJULymRPeeM4TmWIOF45gI?=
 =?us-ascii?Q?hKIXjqSSLdEOaI2HgtsHC/Ua3w+IYU0eP7z27KDb9z8IXFEBkuM2S+zuVozk?=
 =?us-ascii?Q?L9cFqvAF1nrGS74czWsc5ETX7Z/9GaPIg9fpypZwttX2nZE0fOvO0WnNvKHQ?=
 =?us-ascii?Q?nhzKKb3kQRmi1/QZOvvzPW6BOClevPAOqJCp1ETFu0jGyM/FLfdsYQjXuXZ3?=
 =?us-ascii?Q?a/7ZLRmMUspsDY0H4gROa89VR+Vc5oV2OtW/TJIzwrxYxY0IDzr7Oar1xoW/?=
 =?us-ascii?Q?taIVXvflPDAi2kYCstO6hJOBQEv0eVRGhsGKgPhL/C82h5lxzRPy1Nl7aHNj?=
 =?us-ascii?Q?gZf59uatYvZ6suMpgWNA1O3cnBwuLKy2oM4anVRftioEaxGYcL3sOZhOTWoi?=
 =?us-ascii?Q?hKJrBQbIRfhdBB3nmIeSkPTOAvx/pNOzBByrlwrJRjPciBh1T+g2BijFG5tr?=
 =?us-ascii?Q?NgN+47u3XEwwVFRVkqzEjrzMWG1heAtw61uMx9lNTr/jAYo3Q92RHSOoEdOt?=
 =?us-ascii?Q?NkGGi4Qnus5V0pjvxc2eRp6spbJQdf3PWDpMw7yGVNoII1N/8MON2poVvpbN?=
 =?us-ascii?Q?9H4mgGgux/JLHreETHEgbT1AYZDKIzXhuq6gLm/xUJHiQoYAIQgmzt6hUTTE?=
 =?us-ascii?Q?hY0M2RR9ZOlO/MLbmWQt14HRNT16dd1PK+joXrSxpmWczH/WUdpVkPAe9zl4?=
 =?us-ascii?Q?87gOoCTSxuiEzM+oDISil94hNtH9tJw9zmSFF6X679nLLZR/+DNGy9drNU4b?=
 =?us-ascii?Q?QbiJLhID8pHCIxAOWzEGm8WSprF7WWws6VIDv9Oa8GcDuRni8c11ZLFdNbT/?=
 =?us-ascii?Q?hHMFWQilmLOTLjSSfe4J6n7kiQgtVyD8wxKXRLaDdA6XeyTT4q1MyoZ83bUP?=
 =?us-ascii?Q?t2/dyLQ57B77yXg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:34.7098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adae8ff-1017-4fd9-2597-08dd5ff247c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

Restructure mds mitigation selection to use select/update/apply
functions to create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 55 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4386aa6c69e1..71da57c4f83b 100644
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
@@ -169,6 +190,7 @@ void __init cpu_select_mitigations(void)
 	spectre_v2_user_select_mitigation();
 	ssb_select_mitigation();
 	l1tf_select_mitigation();
+	mds_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -179,6 +201,14 @@ void __init cpu_select_mitigations(void)
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
@@ -281,6 +311,9 @@ enum rfds_mitigations {
 static enum rfds_mitigations rfds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_AUTO : RFDS_MITIGATION_OFF;
 
+/* Set if any of MDS/TAA/MMIO/RFDS are going to enable VERW. */
+static bool verw_mitigation_selected __ro_after_init;
+
 static void __init mds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
@@ -291,12 +324,31 @@ static void __init mds_select_mitigation(void)
 	if (mds_mitigation == MDS_MITIGATION_AUTO)
 		mds_mitigation = MDS_MITIGATION_FULL;
 
+	verw_mitigation_selected = true;
+}
+
+static void __init mds_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
+		return;
+
+	/* If TAA, MMIO, or RFDS are being mitigated, MDS gets mitigated too. */
+	if (verw_mitigation_selected)
+		mds_mitigation = MDS_MITIGATION_FULL;
+
 	if (mds_mitigation == MDS_MITIGATION_FULL) {
 		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
 			mds_mitigation = MDS_MITIGATION_VMWERV;
+	}
 
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	pr_info("%s\n", mds_strings[mds_mitigation]);
+}
 
+static void __init mds_apply_mitigation(void)
+{
+	if (mds_mitigation == MDS_MITIGATION_FULL ||
+	    mds_mitigation == MDS_MITIGATION_VMWERV) {
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
 			cpu_smt_disable(false);
@@ -599,7 +651,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
 	rfds_select_mitigation();
-- 
2.34.1


