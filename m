Return-Path: <linux-kernel+bounces-554679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B7A59B49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A54D1889E51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8ED232368;
	Mon, 10 Mar 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j52C9zVU"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B844230BFA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624843; cv=fail; b=UWepbkgGEs0F6BMl9sGh32shE+FjoTqVYBtzu7lV6DmOvy4bx/4BYfVNlan8JFhgirmkmVRXtr1i4QgD8wpM3aGNnBBZhL3ObYofElDX8XB8lB3xCMldqvr1DmoBnqXZ85DBBqwvHHZWNxK81Ceqlxb4gnXWvvBYu1+AfkzEpXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624843; c=relaxed/simple;
	bh=DF6MZbZJpXCPECopF9eNLvNxgjJUadmOofM1ZNLxQU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYTCqcj1ugVB31kWcQ9RB7RejGspw6ymxGGNZL3UwAUESMQpsrQDnahX+FkNUQIK9JNCFd8mHR4RyLGHnPz9c8GCocZVi5mgQuaaeRfdOL2oXoT1PdKJpdpzCEVw+its7prNLFxP5+Iz7gX+8vZ//D7uoGxDZb/Cud7d5MXyIoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j52C9zVU; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNrwr5Md0ueDFqgc33Vpnc7uAqllI0LWVkYqbWvG4k/g4lxxzSrzxdTwvle5yjebCOFkwXU6JgfYpGgySAxAdSK7/xy6DMI5yblyaXTeTv/dvEEOy9aqzV34WzOGadh/p/hZ67TCFiBvzEPHEeYUSrAgO66cPBezvMOoTRavmU+w/OLM+TCQgwCQBBMZMCZmvBnedBv/e/pnkx/hem7rEWJb1sFiKoZYO1TfcTIUChmN5+LeeXx8QmT9SMjg42b6GVSCGonX9F1WwNEosp8MTPHMWpsD1Ejy9HIISaHDHO6mOevaWHYEVXNYUJ6p7cr7Q0hFphTgT1qxGzhUrrd12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV6/HIURgDQZVllu3rS46Vt4KguJ+iml0Cn2OfCIHEc=;
 b=TNEQ5nZgSPAXXOLfBvF+ejkE/ZjnoembPvu7gp6kMDBojz4Y19XZIEnJ81g1jG7RLPQPRQpreoDebguSqjWaqD2v1r70VAwqC7QbNx//7L93AL+ITf7gDTbIyiZkz6HspSYbQv/epdB/HbbjPrKEN0WIGnUt6plRkacvKzoSBSUko9XZy+IuQeMWitEw+sJ6CS9SrcIWH+mf30Wrp59WdiVSa43MGXhZJWwg0q2nuf1git5s9ReQtgSUFq8qpv1Xt7enxf3unaB0AgmN6u9eK9UTut7WAEI0K7g+yV92YWbmJqhFvTN/mjX0falAT++50U15GOTI0MgW3CMlmaMVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV6/HIURgDQZVllu3rS46Vt4KguJ+iml0Cn2OfCIHEc=;
 b=j52C9zVUtGecMp/XxLd1zOcLP8p0FosYitJqZNweldD4DoAzGNZscwLyhFs/7F6s845/D7/PEIgLKNDOY+nfPTOVWfcUOdOvG5AT/ZpvI9rYmGSavE0+EdwcQdQwFHWBPVtSF/k0FnOHhh6KGY6DJJCfRBIqOHKaRNlYhHuhVzI=
Received: from BN9PR03CA0085.namprd03.prod.outlook.com (2603:10b6:408:fc::30)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:38 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::d2) by BN9PR03CA0085.outlook.office365.com
 (2603:10b6:408:fc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:38 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:36 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 04/36] x86/bugs: Restructure rfds mitigation
Date: Mon, 10 Mar 2025 11:39:51 -0500
Message-ID: <20250310164023.779191-5-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 325df83b-859d-4b7b-cfe4-08dd5ff249c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L8+VWEj610gyjRIzogUThfSdZhv7p8ClXfPbMnSpB6U1cC74B/YDY+zCBIry?=
 =?us-ascii?Q?ocO5dvifOcoxum/KzrfuG0IwzanI/VyucP7CeXfJOSNlkMPqiRSrDBgUeLfM?=
 =?us-ascii?Q?7i9jvWv1OzLO3bpb1YBCukTxgbDIqqmwjceUYiKne9uWwW47DoRcpfQ1RGdM?=
 =?us-ascii?Q?wih/t6G0OxhQ+xgjHAY7ZbNgTIOiOHAEhSvaWnIxdJNPWpW7t3VLK0+pZDHi?=
 =?us-ascii?Q?F1UU1E+cEHQdlszqJI8rScE19TelgmRlM1ksqWB2UwHQ8NoYprIhejXu3z/K?=
 =?us-ascii?Q?c0CWZO2+oIYaBNovl5sBzql1ewcuykbqVR2LXsX6AVb/2K/3M37Kjc5/GYoD?=
 =?us-ascii?Q?Rn9nyuoYJtWIfvguvS4ZEFfobbbE8cNdsC1lTHpsXMPD9itr2Ca/og49gcFH?=
 =?us-ascii?Q?izLcTjJjCHPL1pPqug/QAluYguKJAGr4loDHo4zY6/GpqTxB9QSlZdzO8QA1?=
 =?us-ascii?Q?vDx0B2lPuBIF8E/1dbUf1xH/1B/bsddQuqYvkkuad0iAcOad+gx3aOERVVrm?=
 =?us-ascii?Q?lPxDhf4Qoy4O237AzxcyDiIvun0lQ4rbCn8NR3igdFGX15+5Tkb2JOCFLKzz?=
 =?us-ascii?Q?8aNoh4oEgUbr6muLCHKYZxAnSeh3XfK00m1M/KvydbarZw6604CzC4HuVfIW?=
 =?us-ascii?Q?HOVuVjSA/2imAvhcqsFdqg7CyGSAED/0fOb00y3VpRjNxPokHeFczkwHOKxl?=
 =?us-ascii?Q?FqnkC7HXj8TJxlhKpIAHeV2S8c4YCuuo1l55d8jWtj2w/86bHQBRNza1F3zL?=
 =?us-ascii?Q?5R9rjkqGF6A4QDgJZ4SEJNTVlsvvdFldk+AtIHTL0sp5qZO7t2++AYEYqJRe?=
 =?us-ascii?Q?IF3qUkiFTCBWktch7vpowX3DIG76ecUA4DzNW+xg0EhB2M7Jz+WLLwJOR/9z?=
 =?us-ascii?Q?MooMh0rvCgxkAcLG9i5JuGKKT24f7QBfp6Tptv0H9TNJJH/dmiai0lGawQSm?=
 =?us-ascii?Q?YmUZ5l1Gl4Ps4rcc9ASaJ362zoWObU8iYi0791+eUAxAmB3KnBhi4y2qRlwU?=
 =?us-ascii?Q?dxeCXvbJ4m9xQMu90oo/NCm+8yD4boTnoTiuH2p2zeeaNppR+hV4tTVsP9FR?=
 =?us-ascii?Q?/Q8YAf1G67rGKlm79yjM08/bs5a90UOUsIBg+OXk6fw9snTWXOaayD0K4Qcg?=
 =?us-ascii?Q?+qXqqSlWoAmjbjd1FX5rfQBZQRnzBfBz/KmbZPOUszlf20LKAZe/LJurWAzG?=
 =?us-ascii?Q?VN4CXQ4BTyJDNX7K1xd2Gur5v9aTY1h5JAWxtfT4FxpHXsGNqGKOSALKzODJ?=
 =?us-ascii?Q?MnJBE8mRiRSh9PzsmXBQIWnBJggByYOK8sj7/m+dorccc7a4t8UK7x23/KpX?=
 =?us-ascii?Q?8HjaHTbc3pbVkVBxOEoNA2Skt8q79zDzWPqHIBrKzo72ltCFZes/cdQT4Vro?=
 =?us-ascii?Q?oHvvE3d4x2siqeN9mZ/XEqcKiXt0PdKsC6KIrAsMoqMgfpc/47hA2KzjIb/7?=
 =?us-ascii?Q?DeL7UOmVA6GEvHb+4+90HirkSvIMBE4YiyY8aGs3Dd5VbOgaoguT080ri/S+?=
 =?us-ascii?Q?pOs15f4+0riZ/1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:38.0172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 325df83b-859d-4b7b-cfe4-08dd5ff249c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642

Restructure rfds mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 40 ++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a727f7998bec..de431f2bb012 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -70,6 +70,9 @@ static void __init taa_apply_mitigation(void);
 static void __init mmio_select_mitigation(void);
 static void __init mmio_update_mitigation(void);
 static void __init mmio_apply_mitigation(void);
+static void __init rfds_select_mitigation(void);
+static void __init rfds_update_mitigation(void);
+static void __init rfds_apply_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
@@ -197,6 +200,7 @@ void __init cpu_select_mitigations(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
+	rfds_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -215,10 +219,12 @@ void __init cpu_select_mitigations(void)
 	mds_update_mitigation();
 	taa_update_mitigation();
 	mmio_update_mitigation();
+	rfds_update_mitigation();
 
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
+	rfds_apply_mitigation();
 }
 
 /*
@@ -614,22 +620,45 @@ static const char * const rfds_strings[] = {
 	[RFDS_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
 };
 
+static bool __init rfds_has_ucode(void)
+{
+	return (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR);
+}
+
 static void __init rfds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
 		rfds_mitigation = RFDS_MITIGATION_OFF;
 		return;
 	}
-	if (rfds_mitigation == RFDS_MITIGATION_OFF)
-		return;
 
 	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
 		rfds_mitigation = RFDS_MITIGATION_VERW;
 
-	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
+	if (rfds_has_ucode())
+		verw_mitigation_selected = true;
+}
+
+static void __init rfds_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off())
+		return;
+
+	if (verw_mitigation_selected)
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
+	if (rfds_mitigation == RFDS_MITIGATION_VERW) {
+		if (!rfds_has_ucode())
+			rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
+	}
+
+	pr_info("%s\n", rfds_strings[rfds_mitigation]);
+}
+
+static void __init rfds_apply_mitigation(void)
+{
+	if (rfds_mitigation == RFDS_MITIGATION_VERW)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
-	else
-		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
 }
 
 static __init int rfds_parse_cmdline(char *str)
@@ -702,7 +731,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	rfds_select_mitigation();
 
 	/*
 	 * As these mitigations are inter-related and rely on VERW instruction
-- 
2.34.1


