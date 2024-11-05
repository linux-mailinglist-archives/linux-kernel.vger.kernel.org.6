Return-Path: <linux-kernel+bounces-397204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3802E9BD7EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1D31F25415
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621AB21747B;
	Tue,  5 Nov 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="26ZuinxQ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34482170C6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843739; cv=fail; b=gjAakKWtLaCwkgR2dMNUarH7iewtxNFrYNcKuN2Idiry6gPPK0Oxn3ovcDC2lxj7JILTi+2Mz6CQ95t+gx2NJpChZLD5Kf/8iKjryL0/n7e6Taqvc5Fu0UgMMfyuJv4qwUcpe1Af2g3nABtAOWUPSWSCEqTCuLu4MSpOl26o7Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843739; c=relaxed/simple;
	bh=/90LvVkZSwTeTRwQYefd3ItgDJDADN6vn6tghM1QkAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0btEP3mhSgz2SJMdwtpCnYbXLBjDlBCW7eQo9MN/RLlP6wJSverpt0pAMJnv3EOeQoJG/5KYenaJCTlnA/2oq2J79lzFuCOYH88IApKuE/jvP7q1oYMuYXoVBXGzk52Zlm5Y7yiXH7yvIXqlqfYZEAXf/1Dx/cIzl04EtcTq2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=26ZuinxQ; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi2hafqAlrw/fwnlRck3ifexP1ycEYZiGYrrJB2ugyD0q7USWm8rdZUtSP4HMGdizAikmUCWgKu+wKLtZSZKYlVOC489f88bg6IVqyO2VSwvIzqZJqj/dBugwPbkoQsiwGsFOel9QGtgN7Tn37rQJOqtWkomX8Mgd+PpMDwJlSQPYu3Vpf188hpAoCLpT+IxHWEK0UTsfMtrvGbf72uGifhK6jhSAZKgjjvvTgwbsByC9RFU2R1GCIycI6UTTQhgaw3I9j3QjuI6BHjyDz2oh6f8A70b2wq4lCsk1ZDI59B2IHsJILX2zMVDTN9Nc5igh3E0BY2PbSRe5Pj8kH39Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA0vjbGI7BsUSTV1/Y4dU+R0EH2ZA/pNSm/EfeLd5gg=;
 b=p3GOCzVMPUoISn3aL6b6GkQo+w1bIzkTNXIsJXdRNNtFYV90/p/g2Al+mV2laYR7DeLWipy3TirIMFArL12+O7Ds10aeU6fTDPZRnoMKgUBJW1lEuuetOaLMJKqV7jqtSz+LKYHc5BNFTcdlbetZyF7Bqg4MU4ZyeDfIFAjRJVUHWT5oYi6qANNVGBgrj8JurXxllT0abb2Te42HcpVW9MdG94DE1LeDB93392JjEPZ7+c4A2+0w5PTml2Azw+3aFwwC9qDXjO78abwQr/oa77K8zJ3RCzpRubb9wr+GATlf8eEC7AJzw+CGSscbXKHzhxp2vxwI6/JT7VxIA3i1Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA0vjbGI7BsUSTV1/Y4dU+R0EH2ZA/pNSm/EfeLd5gg=;
 b=26ZuinxQICBuB3P1NnqPFm9ETgh50tyecan4v9pa36iINSz09yvRjLa9nQ0IicMN3g0ake1wEMAZm6wDClSxccQFXEel3ADDmc50l9kO4nHN3VDNjDX+4QIYsHZo2BugggkaACswSQxAKToHfxUO1qJRq9DIyl2+bXM+mWicDz4=
Received: from MN2PR15CA0049.namprd15.prod.outlook.com (2603:10b6:208:237::18)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:30 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::e4) by MN2PR15CA0049.outlook.office365.com
 (2603:10b6:208:237::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:30 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:27 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/35] x86/bugs: Restructure retbleed mitigation
Date: Tue, 5 Nov 2024 15:54:32 -0600
Message-ID: <20241105215455.359471-13-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a36ba7-49f9-4eae-a716-08dcfde490f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pkaVYEkE1wY9IDzGQGOfrjF+4AiISGz9dUiVBBDe0YOotXj0ZUTqz6ylUMTb?=
 =?us-ascii?Q?oGjzCglL+F/Pdn5k40D2QMVvPazVQGTp1BphP7HPB/GSP0EilAZ0PjB51GZ9?=
 =?us-ascii?Q?qSa+Qa1DD0/aOJFoIJuUKJIdiERmwZ7poDa7VIp4Yg0r89/TOrySORHZWdtM?=
 =?us-ascii?Q?N87+DEfKzGzAjejtgAoX/PuMIjTWP/GyJ2755r2eiS4tnHuQfQQfbJ7xS89n?=
 =?us-ascii?Q?MdYSCK9hbU/40RPgc390zqvU8qy/pu2ncYni+XitSeIBHRse6y48sQ4hs4fr?=
 =?us-ascii?Q?RqjM++T/N/rIlVfE3pCaDIsfrlj7PfGAz+UVt5WKDXTg28vVfBEtajDh2H/h?=
 =?us-ascii?Q?5SNIH+rs8co8xRLjQVrxMvjNzeQ03yXaWAVTlTn3axPXo90k13B3ZJ00nrHl?=
 =?us-ascii?Q?1i3PvqTDJDJ7cwNBAYxZTf8G3QczQnzc/aTujkLSJaI+/3+0E0iIQae0E053?=
 =?us-ascii?Q?1zBZFjhNi+CbIW97YghB3lmP1rZNT/mYR+NbMNSbqc1uc+jp5+l0VsAPRgXC?=
 =?us-ascii?Q?+hQvlaPhlPeh0y6+pgvli4y6v00zIXTtv+/j2fwzVBMPxl8DkuXkcngP6ViV?=
 =?us-ascii?Q?jMnqC1w51pVtZi4c+mF/bDOHnSPbxyJmJSDoHfWTCAx/j0VgL6jDoY6Bdnf3?=
 =?us-ascii?Q?/+xJvrgy0ixCnpYzz2+9yi6Or7+Aq/fRxW7ksz5fNkRnCUD1L2tn+TZR13Ib?=
 =?us-ascii?Q?rVvm+WGC3cQ1L2PfheXz8kEWty6dFX6ho2usWKcBUC387LD1Ob6sy2/f1Yl7?=
 =?us-ascii?Q?wvxx0LDPid75vD5+f8rysqMC/vzTXBMwENCou769TAi2W+AJiY2R0yIIeqh0?=
 =?us-ascii?Q?8iisxHSG1qA2Dyi3vSflper773m9BBMPDZKJ+MVaPcEsGyiTAW1wWw7VpaCv?=
 =?us-ascii?Q?SlndhXqc+dcOzF3l/IoKEWXyAQeU3wS34q4TEDCeOiMIR5YHa2aG4HbnMMKu?=
 =?us-ascii?Q?qbBofoBgpDIVVYZ3DN80HxrSXafE7U+vMPdLYu/Sy2FM66I6uJDLFZBJzGnZ?=
 =?us-ascii?Q?Tb7IihvBUi3EbQCF5OkaT/3Pl6sZry0rvE3sie7fLifFMAF1VSQpkd0tTwgq?=
 =?us-ascii?Q?v8oZD0P1s5VyUSIht4zfhLQJVBBGMLrZzm6FtaduGyuatYrwHA4HUrWAozPF?=
 =?us-ascii?Q?ahfGMjFlqNVwlcry7mzr//PPHR6MaWelR6mIyAUf5pzDoiRDuNQpD0JF0v7D?=
 =?us-ascii?Q?Sx0rT49X0Z3xfnbG2loBjtd19DS2Bl4IvE4GEqxDr4JR+Hc9P8tBu7gEX6Wv?=
 =?us-ascii?Q?kR7vrlnFrFfaF4CMR7lJAELNAmgWFE+MaRlCYZgwUfs99CF/zwdT7yyKAQTa?=
 =?us-ascii?Q?VhGI5GCo8fIbeNeYS7k7yJAonjPaMhzGPCMrrDIGuLQ+jeq/r+FllDVMvmkH?=
 =?us-ascii?Q?0FbiVOm7pIedqjvdEB+HRpDhnm89yGdFMJ4OgRtvAD6oPiXDOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:30.5466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a36ba7-49f9-4eae-a716-08dcfde490f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809

Restructure retbleed mitigation to use select/update/apply functions to
create consistent vulnerability handling.  The retbleed_update_mitigation()
simplifies the dependency between spectre_v2 and retbleed.

The command line options now directly select a preferred mitigation
which simplifies the logic.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 168 +++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 93 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ea50c77ccb70..36657bd7143b 100644
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
@@ -180,11 +182,6 @@ void __init cpu_select_mitigations(void)
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
@@ -212,12 +209,14 @@ void __init cpu_select_mitigations(void)
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
@@ -1053,6 +1052,7 @@ enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init = SPECTRE_V2_NONE;
 
 enum retbleed_mitigation {
 	RETBLEED_MITIGATION_NONE,
+	RETBLEED_MITIGATION_AUTO,
 	RETBLEED_MITIGATION_UNRET,
 	RETBLEED_MITIGATION_IBPB,
 	RETBLEED_MITIGATION_IBRS,
@@ -1060,14 +1060,6 @@ enum retbleed_mitigation {
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
@@ -1078,9 +1070,7 @@ static const char * const retbleed_strings[] = {
 };
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
-	RETBLEED_MITIGATION_NONE;
-static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_MITIGATION_AUTO : RETBLEED_MITIGATION_NONE;
 
 static int __ro_after_init retbleed_nosmt = false;
 
@@ -1097,15 +1087,15 @@ static int __init retbleed_parse_cmdline(char *str)
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
@@ -1126,53 +1116,38 @@ early_param("retbleed", retbleed_parse_cmdline);
 
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
 		}
 		break;
+	default:
+		break;
+	}
 
-do_cmd_auto:
-	case RETBLEED_CMD_AUTO:
+	if (retbleed_mitigation == RETBLEED_MITIGATION_AUTO) {
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 			if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
@@ -1181,17 +1156,55 @@ static void __init retbleed_select_mitigation(void)
 				 boot_cpu_has(X86_FEATURE_IBPB))
 				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
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
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) ||
+	    retbleed_mitigation == RETBLEED_MITIGATION_NONE)
+		return;
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
+	}
 
-		break;
+	if (retbleed_mitigation == RETBLEED_MITIGATION_STUFF) {
+		if (spectre_v2_enabled != SPECTRE_V2_RETPOLINE) {
+			pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
+			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+			/* Try again */
+			retbleed_select_mitigation();
+		}
 	}
 
+	pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
+}
+
+
+static void __init retbleed_apply_mitigation(void)
+{
+	bool mitigate_smt = false;
+
 	switch (retbleed_mitigation) {
+	case RETBLEED_MITIGATION_NONE:
+		return;
+
 	case RETBLEED_MITIGATION_UNRET:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
@@ -1243,27 +1256,6 @@ static void __init retbleed_select_mitigation(void)
 	    (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
 		cpu_smt_disable(false);
 
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
@@ -1816,16 +1808,6 @@ static void __init spectre_v2_select_mitigation(void)
 			break;
 		}
 
-		if (IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY) &&
-		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
-		    retbleed_cmd != RETBLEED_CMD_OFF &&
-		    retbleed_cmd != RETBLEED_CMD_STUFF &&
-		    boot_cpu_has(X86_FEATURE_IBRS) &&
-		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
-			mode = SPECTRE_V2_IBRS;
-			break;
-		}
-
 		mode = spectre_v2_select_retpoline();
 		break;
 
@@ -1981,7 +1963,7 @@ static void __init spectre_v2_select_mitigation(void)
 	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)) {
 
-		if (retbleed_cmd != RETBLEED_CMD_IBPB) {
+		if (retbleed_mitigation != RETBLEED_MITIGATION_IBPB) {
 			setup_force_cpu_cap(X86_FEATURE_USE_IBPB_FW);
 			pr_info("Enabling Speculation Barrier for firmware calls\n");
 		}
-- 
2.34.1


