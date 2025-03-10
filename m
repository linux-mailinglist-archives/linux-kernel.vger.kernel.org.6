Return-Path: <linux-kernel+bounces-554691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01251A59B53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40997A7566
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D2238151;
	Mon, 10 Mar 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h7nRGfP/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F97233D9D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624856; cv=fail; b=g3FyN3HIAFSaLdNKczklI9Y2UADphRHv82bUItnJtkeueGlBWTaCOz8pOfF+sgvleu57En/ojoOUd68oRQLEQZKEX+HWh2c2Q8QiuFIRfOaOQLfUF2ljNc4JKp/6PQxUBX6lhYKClJ1sC6eSpb0WYUoBH6VSdb6NAkUf86cqBrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624856; c=relaxed/simple;
	bh=M3Kf0E8Ybu3qZWiX1Si6DSUqe3u/jHNLsbw4piiMwWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruXdFIIM2nZaIRwPIAYnjgbl6OzYz5cnUfwINpIWJ7BsbOL3bmb1dV7zdKUs6vPW/ncM91T1wTx5NgnD4zwXPpnEPph+11We/teKpsJBADjoWmh8ax/MyA4VW9ngpuGAhdaOa5oJ6SsPP/FOJoThiX2jqG2sbv6ImO8VTnUD6YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h7nRGfP/; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I07gVrayjAoD8l+z0xEcM7vTKyWSmxMyD/1DWAvf+1wKuQClojN2vdpiXP0UrcblP48ft86aiQNBCICQOEZ4z3wrnpVdcy5DCT4+U/TZ+Yf4u/P3sr6+hINZ65jCaOgvSyfu+U2iueZRBOF3kwmlz6vdW1jBQEHaLu/GzCERfRzLN3eyhJmmmYAHziEBCe+XK9Sw9qudKdSZOCMy8u6mLI8BKW3MTTE8v5yLU0t55f2Xq7GwQehsoNVnS7lJb7SO5GGHMwzuxjB16o9wcs2qBjGkPUKtsk/0X65cWe2a7+Ow+R/7qTixlLhZBzXVWVSd+dAXZ0q+LOzHdR6KOFte0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfplAb2bcB/J97WRvOLjcUZzrgTyAMusN+3AIYec1HU=;
 b=R5Z7gJeayG1ly3c2AwRDTjFebB0N5zP8WzDQ8xXNe129SMm6twO2SvchOhtkZk1os/8rybLFM+ns/ygmJxD+DlH4xK5EEUwhA/8ykMftbmYu4c022fMaCD6js/E92CjgFn//KqfOl52kJoGvl+Z7ypVupSwYSzz+ZBZiihRbHRz6sDMQnQy3+rBeT/Lb2IJ5ULqG0WlHn6h+gNyxi2LePVetxOVbOQ9gOzcBATOnfiDYyztie928rYCRlFI5xfLQKutGJPf/2hKkpWETMgdmsObaMy6bZbvEvPSMfR+jbIPwAoOITPD1NA1BmIYgAMGWQMSwPxiP/2Slh0kNPYvm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfplAb2bcB/J97WRvOLjcUZzrgTyAMusN+3AIYec1HU=;
 b=h7nRGfP/+ZAum/e703dNa3cMbisqgMedirjfrtwprNl0yJVesMAlyW8MLvmHigjWsk2k3uLgq3V3mt2iKJCFrY0aDREp6/5hhG7TsX2L4PhZfOyAc2GkmYG7QEOTTjacn8AZiaJrEBABm80sVq5rI9dESNUD90IrwPGf0Sov6YE=
Received: from BL1PR13CA0086.namprd13.prod.outlook.com (2603:10b6:208:2b8::31)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:48 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::fb) by BL1PR13CA0086.outlook.office365.com
 (2603:10b6:208:2b8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.18 via Frontend Transport; Mon,
 10 Mar 2025 16:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:48 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:46 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 13/36] x86/bugs: Restructure spectre_v2 mitigation
Date: Mon, 10 Mar 2025 11:40:00 -0500
Message-ID: <20250310164023.779191-14-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c96726-f10a-4ad8-2f6e-08dd5ff24fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fAn31o2WCkLlPTwFA6hSbEcwETtOsrZAQGeJZGdEfQQOplbJ9ogVP2aTC7oq?=
 =?us-ascii?Q?3FzQbWfQVnHjucv6C742vTOdJH899A0vDTzAhtxRr7aywsnWWs736hzr7n5r?=
 =?us-ascii?Q?0N9N6ie3q7C233gkOxWRWD17bhhTiGDQrjxJN/iqgHSG/LtT/G34uCMu+Wt5?=
 =?us-ascii?Q?V5T8VoxE3z84CZdE95K/Y1siyU6YKFRYWzPi8GMOJEfGksIS9NpTyGPZolqR?=
 =?us-ascii?Q?0j1+8LDG6TlM6C80KdyEYX5ZZlVJWvX8lzPtJ+3WXjmpDBi9cTetsYNnV10j?=
 =?us-ascii?Q?iJ6LPqOXppq52Ox5Wo97KQuMKjLFVye42QBecrE7+xyMiXk0R+kd6zRKJNlk?=
 =?us-ascii?Q?O2RDuxqPqif8TApx8d4lehCiA8qFKQ7wN5BvJg04ywtvuGqophPKQx1tDHPW?=
 =?us-ascii?Q?lw2gt9bq2K13Tdy/i8HlY2HlTVHaJa2ia3g2FrDdqhD0KLf6wiI30pE87N6T?=
 =?us-ascii?Q?si8KwA6tf2dDn+FKcb3Vgsv9DTHhRz6bWzIGqiQDMIBtGL496iGrupZQMTxK?=
 =?us-ascii?Q?tBpkp2isxAThIhIZxcEFnm4ItunWKR4ibWl4qFlLUPzlxxgeWOtmUlZZNsb8?=
 =?us-ascii?Q?skLgRutS2SjDjMfa1JopLPcaVTmHyMeWNh1OJogVAP9yYgeNiYabWWIx6Rds?=
 =?us-ascii?Q?tmGgLyv8dH7ZWH+3Y6A+ngsuaa6le5ADQIdJ71e+j0U9+pXVqACjOmP6FA/g?=
 =?us-ascii?Q?bE943dvQp+NTlzjcv7vO+RszBp3pmhypoKApeJOHHRLj2vq3sQcohaK7tVaH?=
 =?us-ascii?Q?y2YTOIeu1Q7J06v+xagdjj7sYAMFO7DmGWnuNulKLkjq2/61iB8Ja2kfVWCN?=
 =?us-ascii?Q?okjxLwnjqTDdwPdim90lUlIRmlAI32zjJjhZPVX0VhBCYv4XBlQUTwZAsNQF?=
 =?us-ascii?Q?3DUzLFlao3uE0+tYQpMpYAKBMRyo76Rwqfi9pL651RuAnG8HM4G9hCZDscAV?=
 =?us-ascii?Q?DxuR5bMIddLyJYPVs2Su3gxpXY9fR+bpuDanW83KKS4BSHxS9ojKqgT3YlWw?=
 =?us-ascii?Q?FsLF9OviU31wCSlem2UCzIHTCiQFRkT6LBJXxTYhQUXUQXW78GkcHOafqI9k?=
 =?us-ascii?Q?SH0fiJN1p3QwhUptO9OwEyWA+WX0HXcx4tJtiufKSCJSDyv86C4tiwXP44Cz?=
 =?us-ascii?Q?w8N6olt8GbPqjq3C4n1HRz9xCtwBo9S2y/GUTWY7HXCaIKwHJbWpy0mRDpv+?=
 =?us-ascii?Q?CZYHEMt5CPXL2qAFO8ei0WIPoc2sWonAU6ei9of9dvbJqx+yLkIwqqjD0l1u?=
 =?us-ascii?Q?datAgcGtgcliG4bIiWFtxSVwAO2YoU/NxaiQjqX2yp7q+si+N8fh3M5QiHYR?=
 =?us-ascii?Q?wuR2ffPxyRkOKGnM8+sftHzkPXe0F3dlYvWqB8eDfUFiQqd9b6j5RnXsFrju?=
 =?us-ascii?Q?UHEneklV5AzeLcZA8PuHQRj3f6RfO1/DWvA87cySYbDcEnHCeS2ZsfdKTC7b?=
 =?us-ascii?Q?7yFpjXsi9OIj9w6pN+/EU/lFLCTE8ON2gW+VjfkFDNqMt8SD0+DyZVY9vZdd?=
 =?us-ascii?Q?w84ZTQF82xw4H7g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:48.1162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c96726-f10a-4ad8-2f6e-08dd5ff24fc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452

Restructure spectre_v2 to use select/update/apply functions to create
consistent vulnerability handling.

The spectre_v2 mitigation may be updated based on the selected retbleed
mitigation.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 79 +++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 96cb2ac70245..b4a72ddf159c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -56,6 +56,8 @@
 static void __init spectre_v1_select_mitigation(void);
 static void __init spectre_v1_apply_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
+static void __init spectre_v2_update_mitigation(void);
+static void __init spectre_v2_apply_mitigation(void);
 static void __init retbleed_select_mitigation(void);
 static void __init retbleed_update_mitigation(void);
 static void __init retbleed_apply_mitigation(void);
@@ -212,7 +214,12 @@ void __init cpu_select_mitigations(void)
 	/*
 	 * After mitigations are selected, some may need to update their
 	 * choices.
+	 *
+	 * Note that retbleed_update_mitigation() relies on the state set by
+	 * spectre_v2_update_mitigation(); specifically it wants to know about
+	 * spectre_v2=ibrs.
 	 */
+	spectre_v2_update_mitigation();
 	retbleed_update_mitigation();
 	/* spectre_v2_user_update_mitigation() depends on retbleed_mitigation */
 	spectre_v2_user_update_mitigation();
@@ -222,6 +229,7 @@ void __init cpu_select_mitigations(void)
 	rfds_update_mitigation();
 
 	spectre_v1_apply_mitigation();
+	spectre_v2_apply_mitigation();
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
 	mds_apply_mitigation();
@@ -1847,18 +1855,18 @@ static void __init bhi_apply_mitigation(void)
 
 static void __init spectre_v2_select_mitigation(void)
 {
-	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
 	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
+	spectre_v2_cmd = spectre_v2_parse_cmdline();
 
 	/*
 	 * If the CPU is not affected and the command line mode is NONE or AUTO
 	 * then nothing to do.
 	 */
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
-	    (cmd == SPECTRE_V2_CMD_NONE || cmd == SPECTRE_V2_CMD_AUTO))
+	    (spectre_v2_cmd == SPECTRE_V2_CMD_NONE || spectre_v2_cmd == SPECTRE_V2_CMD_AUTO))
 		return;
 
-	switch (cmd) {
+	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return;
 
@@ -1869,16 +1877,6 @@ static void __init spectre_v2_select_mitigation(void)
 			break;
 		}
 
-		if (IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY) &&
-		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
-		    retbleed_mitigation != RETBLEED_MITIGATION_NONE &&
-		    retbleed_mitigation != RETBLEED_MITIGATION_STUFF &&
-		    boot_cpu_has(X86_FEATURE_IBRS) &&
-		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
-			mode = SPECTRE_V2_IBRS;
-			break;
-		}
-
 		mode = spectre_v2_select_retpoline();
 		break;
 
@@ -1912,10 +1910,32 @@ static void __init spectre_v2_select_mitigation(void)
 		break;
 	}
 
-	if (mode == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
+	spectre_v2_enabled = mode;
+}
+
+static void __init spectre_v2_update_mitigation(void)
+{
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_AUTO) {
+		if (IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY) &&
+		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
+		    retbleed_mitigation != RETBLEED_MITIGATION_NONE &&
+		    retbleed_mitigation != RETBLEED_MITIGATION_STUFF &&
+		    boot_cpu_has(X86_FEATURE_IBRS) &&
+		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+			spectre_v2_enabled = SPECTRE_V2_IBRS;
+		}
+	}
+
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) && !cpu_mitigations_off())
+		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
+}
+
+static void __init spectre_v2_apply_mitigation(void)
+{
+	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
 
-	if (spectre_v2_in_ibrs_mode(mode)) {
+	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
 		if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
 			msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
 		} else {
@@ -1924,8 +1944,10 @@ static void __init spectre_v2_select_mitigation(void)
 		}
 	}
 
-	switch (mode) {
+	switch (spectre_v2_enabled) {
 	case SPECTRE_V2_NONE:
+		return;
+
 	case SPECTRE_V2_EIBRS:
 		break;
 
@@ -1951,14 +1973,11 @@ static void __init spectre_v2_select_mitigation(void)
 	 * JMPs gets protection against BHI and Intramode-BTI, but RET
 	 * prediction from a non-RSB predictor is still a risk.
 	 */
-	if (mode == SPECTRE_V2_EIBRS_LFENCE ||
-	    mode == SPECTRE_V2_EIBRS_RETPOLINE ||
-	    mode == SPECTRE_V2_RETPOLINE)
+	if (spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE ||
+	    spectre_v2_enabled == SPECTRE_V2_EIBRS_RETPOLINE ||
+	    spectre_v2_enabled == SPECTRE_V2_RETPOLINE)
 		spec_ctrl_disable_kernel_rrsba();
 
-	spectre_v2_enabled = mode;
-	pr_info("%s\n", spectre_v2_strings[mode]);
-
 	/*
 	 * If Spectre v2 protection has been enabled, fill the RSB during a
 	 * context switch.  In general there are two types of RSB attacks
@@ -2000,7 +2019,7 @@ static void __init spectre_v2_select_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
 
-	spectre_v2_determine_rsb_fill_type_at_vmexit(mode);
+	spectre_v2_determine_rsb_fill_type_at_vmexit(spectre_v2_enabled);
 
 	/*
 	 * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
@@ -2008,10 +2027,10 @@ static void __init spectre_v2_select_mitigation(void)
 	 * firmware calls only when IBRS / Enhanced / Automatic IBRS aren't
 	 * otherwise enabled.
 	 *
-	 * Use "mode" to check Enhanced IBRS instead of boot_cpu_has(), because
-	 * the user might select retpoline on the kernel command line and if
-	 * the CPU supports Enhanced IBRS, kernel might un-intentionally not
-	 * enable IBRS around firmware calls.
+	 * Use "spectre_v2_enabled" to check Enhanced IBRS instead of
+	 * boot_cpu_has(), because the user might select retpoline on the kernel
+	 * command line and if the CPU supports Enhanced IBRS, kernel might
+	 * un-intentionally not enable IBRS around firmware calls.
 	 */
 	if (boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 	    boot_cpu_has(X86_FEATURE_IBPB) &&
@@ -2023,13 +2042,11 @@ static void __init spectre_v2_select_mitigation(void)
 			pr_info("Enabling Speculation Barrier for firmware calls\n");
 		}
 
-	} else if (boot_cpu_has(X86_FEATURE_IBRS) && !spectre_v2_in_ibrs_mode(mode)) {
+	} else if (boot_cpu_has(X86_FEATURE_IBRS) &&
+		   !spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
-
-	/* Set up IBPB and STIBP depending on the general spectre V2 command */
-	spectre_v2_cmd = cmd;
 }
 
 static void update_stibp_msr(void * __unused)
-- 
2.34.1


