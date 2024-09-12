Return-Path: <linux-kernel+bounces-327131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE53977125
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA091F24686
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC761C2DC2;
	Thu, 12 Sep 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sqfwdKEY"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323F1C1AD8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168165; cv=fail; b=DWk9uAfSeZialGXi5MMf8Ch8X8Oq6kLBAlknJVZxKu5RtqtMc8Mcx3wIprdGzLM7x0TXhZxqcFnG4tXoy+S51Hwh6rTMIab7d84p4cqMfYPX5WL+31SDZCHOzxs3ps1jgv44LCSQ4pwKeQyL4iHwSDd/srqoa01O/8WA5pT4PEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168165; c=relaxed/simple;
	bh=7C1IRqQral8zn3EuEteiXOIp+EddsZLHd02f2hOOMvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STnsK+VAOk0x5dIqvINlSzyOKxBVtpQo9M/GUuSvNL5aOCR1l4aggrvKIiWTOgfH7zG3p4ZZSD0NU7Dd73/YtWxsrGGtZCYEypypNakdEU/kRGshWRqrxivs5mI7eY8BrRsr8W9KwUso/mhWg7BRp89lqQSrqPgVhiOSyCn+Www=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sqfwdKEY; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kfs9XrtGAa6k89YYnMBAe4MOsfJvo3+TGwYI+ApHQeHVExQVizzCbihWwRhY3yjwyASafo7PRA+7bHkSzqPR1Fy4afUsFjCcf7raipLs3/RlXtRW+C4scY/6M4/crMdUGdBRXeyJaGV6J+awwxfhF1LD8xxPgjSg9koJpNCg6H8pCMJQUxfvcz0A0f/4i/K6T3p2AHwRHyVbbdo+7oZaC357OrqaR71eAxZuo09ZNVspz0jvy8pPYGXPINXUJyVykTF7joWRJnMysKJ01ehUFD3yJl3OrIL5cSpaTHkdXOCwGUbK2VUVUXRkE9x91JDyvvfjTHWDLAWsHCUgqdDgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRs37hNM3NrKBZ5qz34v1qIx8NNdxQeg7vtEWCjbjDk=;
 b=kHM8gB3v6B2H0IjDEYDSYfB8Gj2zZCg8ZEd78uNqk8WKQh/v1kpIDRoNcTWkkGXvykHNJh3yTY7CBFTjjE6YNZyrIVPqJIh3yAFI9bwT1IPq4tgXQOoXc9Agdh6vaRJNrjaXgEzZhtRogWIhxfFOgctQH0/eCAqfj2sZe2JQ19j1Yp+dhfSzwJUmOz3jMhgo9YVDewZuVqSepkaJljd+xqHoBqGfeqeDpWwfWachcwaijBXf+TYVNxhYYeDA1g7rQti+mk/iL4wdi0EBI8K4c8HCygMpRmGRu5ueRK/M+C2Pqp5gCfCSaimhyuq677Cz0BzkN3zxW4aPF7eYcpNyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRs37hNM3NrKBZ5qz34v1qIx8NNdxQeg7vtEWCjbjDk=;
 b=sqfwdKEYGrHVGAHYaBsB9SQ88ON3YWLfDjl8r0QM/fb4F2p/9nkjHhtOACBg+xUP/VStvPGZnKwcIZkA+aEaLbUsTrYYO9Fu6JxvYr6usYRIr6EjbGhwrA1GdQx09zPqpFCd5vLmRJ5ZCBa8I8lXgEjEzhOYdBeC9uDHY0y9Ztg=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 12 Sep
 2024 19:09:18 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::96) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:17 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:13 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 11/34] x86/bugs: Restructure retbleed mitigation
Date: Thu, 12 Sep 2024 14:08:34 -0500
Message-ID: <20240912190857.235849-12-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e05283a-4c02-48b0-d2f4-08dcd35e6684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1eWmZQjbvcwexA7YGBwKlQGfAQinj5yvYiY0nb3/n5/pDjq8aWNDfkmaI3ah?=
 =?us-ascii?Q?QN5SNnm+jJHTMaKAcV3oy7iC4hQES6DjXAru5sKJyRnZZjTUpukVfJs/ePDq?=
 =?us-ascii?Q?/CYvuGb2n+yVF4MswcTj2sAZPs8bJby3b78uUDrRW3TGv6AJygjR+ByZMhLB?=
 =?us-ascii?Q?7qY8FPFLk3SlWG8Q3DCDn1yfKb2u/eqBWBsR+uEZT9JMsJSwaLfBr7hIjGN+?=
 =?us-ascii?Q?cG3XlUVfcz0e8iHXWBPsPqHak9XnSuYABn0WpMZ+pzjuIFrILcTeZQQlmpmC?=
 =?us-ascii?Q?3zl16YBsR++3i3nA0wsuYsobWTMjMMgj2W4Bz7L+HvrlNWraGCILNYmQK0c1?=
 =?us-ascii?Q?Y2drkV77oy1/76EyNmClRr5WJrAMR+bRxZq5DA4eXqHAFwVXlEL6Ei81w3LQ?=
 =?us-ascii?Q?q19pZNFPZZjEYRGclG5NMW83FxL7qnHEGngWddFQRVzh+AxAyIBXk5BO5Oad?=
 =?us-ascii?Q?OEyS+5VBf2zcdSNiB3CO4iBXKUaipTjImPGkYY6cRZfXvEI1FU3nNSbWsPRK?=
 =?us-ascii?Q?sjWQDHXBGju8Yz2aidYp1Ndj+6dovWownkVnmsIxUMZ/aXaiR3uD9u1XTUrZ?=
 =?us-ascii?Q?X99g4iwBQNzyzWlrMk5Cz3H+4JrLYgtjSiR6/L0mpeWVDDSmXA8usG8g4CyL?=
 =?us-ascii?Q?iBTOHu3mGEC6I7wM7tiTsRjoc6SYLOP/5Dli8fMamzjDqI/28zsTc1S0d94x?=
 =?us-ascii?Q?WxxUvhZYfmJ+N8iY+jNR7hc6Xzs1mq125oZc+NnWrHUR/0qWb0ihr69mOtBi?=
 =?us-ascii?Q?nosjB1UCbBAnjJx1XfZIhIfRs0WjVBkgXNsroYNoxVm4b0Au8zCtHWQPWzjI?=
 =?us-ascii?Q?MVVzokXcDgT7i8WA9d+8dkLMdKzIPEr508MqzUxhjRbkEbRJoIZPSYP/u2iP?=
 =?us-ascii?Q?uDNnA7g+zLHkDxJir9GIpOcJRSXwg2SW4aHICukIvOkVi0EFqJXyPuotENdE?=
 =?us-ascii?Q?IkXxBXCRIqbf7YwaDOeQ/NM8dhdfXIBQvUBr6UvGGhjyC0MorRNJeMLb7C7b?=
 =?us-ascii?Q?2GAGkDgnT89Yb+OLbYB3IRunuXzkVCYis49/CUg/WlE96UbmquM9HgHs+YUH?=
 =?us-ascii?Q?h273AHH41l1sv8hU42yGsj5tafUrJfHXi4Ao/vpjCSfxwnGJT0srBgTMqes1?=
 =?us-ascii?Q?JzA4Z1T8AuTNJBEjVGF7O4PNAvu34SfrIa6ZIK8ozosLLXNBIWy1p+lGdNbJ?=
 =?us-ascii?Q?q26lX+DGjwXXbNeCqFg/4eXJpsjxoLf7318EoJvBRrniZnsIYLg8RzdfAHTz?=
 =?us-ascii?Q?x/v77r3OLhEriR74HkxqWtBcF3dZxFSegoXMILYD1tVhndzRh2p+XmXLJjtJ?=
 =?us-ascii?Q?eUg70QzM9yilot/1UbTTkqbVyZlSbmbhEFQ60sOA9mP474Zn6MA2aUx4uRdk?=
 =?us-ascii?Q?ZHpkz74o9FW2/Q3DlUv3YDRV15eq6M68KoBnmWqSfKUKqGohbY+rrO3nKeIi?=
 =?us-ascii?Q?pGXvewS19LlQ/2u0l/2R89sNk3R1V0nn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:17.8572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e05283a-4c02-48b0-d2f4-08dcd35e6684
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039

Restructure retbleed mitigation to use select/update/apply functions to
create consistent vulnerability handling.  The retbleed_update_mitigation()
simplifies the dependency between spectre_v2 and retbleed.

The command line options now directly select a preferred mitigation
which simplifies the logic.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 168 ++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 95 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ab49205ebb15..13143854ca42 100644
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
@@ -1050,6 +1049,7 @@ enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init = SPECTRE_V2_NONE;
 
 enum retbleed_mitigation {
 	RETBLEED_MITIGATION_NONE,
+	RETBLEED_MITIGATION_AUTO,
 	RETBLEED_MITIGATION_UNRET,
 	RETBLEED_MITIGATION_IBPB,
 	RETBLEED_MITIGATION_IBRS,
@@ -1057,14 +1057,6 @@ enum retbleed_mitigation {
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
@@ -1075,9 +1067,7 @@ static const char * const retbleed_strings[] = {
 };
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
-	RETBLEED_MITIGATION_NONE;
-static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_MITIGATION_AUTO : RETBLEED_MITIGATION_NONE;
 
 static int __ro_after_init retbleed_nosmt = false;
 
@@ -1094,15 +1084,15 @@ static int __init retbleed_parse_cmdline(char *str)
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
@@ -1123,53 +1113,38 @@ early_param("retbleed", retbleed_parse_cmdline);
 
 static void __init retbleed_select_mitigation(void)
 {
-	bool mitigate_smt = false;
-
 	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
 		return;
 
-	switch (retbleed_cmd) {
-	case RETBLEED_CMD_OFF:
-		return;
-
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
-		if (!boot_cpu_has(X86_FEATURE_IBPB)) {
-			pr_err("WARNING: CPU does not support IBPB.\n");
-			goto do_cmd_auto;
-		} else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
-			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
-		} else {
-			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
-			goto do_cmd_auto;
+	case RETBLEED_MITIGATION_IBPB:
+		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
+			if (!boot_cpu_has(X86_FEATURE_IBPB)) {
+				pr_err("WARNING: CPU does not support IBPB.\n");
+				retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+			} else if (!IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
+				pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
+				retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
+			}
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
@@ -1178,16 +1153,50 @@ static void __init retbleed_select_mitigation(void)
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
+	if (!boot_cpu_has_bug(X86_BUG_RETBLEED))
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
 	case RETBLEED_MITIGATION_UNRET:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
@@ -1223,27 +1232,6 @@ static void __init retbleed_select_mitigation(void)
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
@@ -1796,16 +1784,6 @@ static void __init spectre_v2_select_mitigation(void)
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
 
@@ -1948,7 +1926,7 @@ static void __init spectre_v2_select_mitigation(void)
 	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)) {
 
-		if (retbleed_cmd != RETBLEED_CMD_IBPB) {
+		if (retbleed_mitigation != RETBLEED_MITIGATION_IBPB) {
 			setup_force_cpu_cap(X86_FEATURE_USE_IBPB_FW);
 			pr_info("Enabling Speculation Barrier for firmware calls\n");
 		}
-- 
2.34.1


