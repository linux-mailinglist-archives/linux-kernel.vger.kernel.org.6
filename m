Return-Path: <linux-kernel+bounces-554684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A95BA59B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0E3188627C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB02356AA;
	Mon, 10 Mar 2025 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jsYZLrEa"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF94233D72
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624848; cv=fail; b=KAcscdlRP4ISpMp7986/ZRCeQ5rdy3hJ+CeXufygbX3lkX01nNh0UGW/O19z/ftkrJHM+g9z77TH1MXMe7Et/K4PqM2BHexRrI1X4TIPmJh9Qvx80frHvNCbtu4DSMxDR7kw8tSs31xGk5yHixFCCOKqoo9k6zmxAlbkYNvaH6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624848; c=relaxed/simple;
	bh=AGm2Qp0MNQ1Twwf2/FWpUxlnyWnI3yibe/WGqhPkyPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXpRN0vBhfDfXU/AC/tULXXxAyXY5bcyqswqElO2gOoZAv7f42N7Bwuw00/X/f16RN7/wxLrr7G68Ykn7BF0MlTTeKdATaehR1J55+TGeOuMNgNTOL6COuAzoXkOpDnxgH/dZv0hN1N2C9urqS4CN/Pl1MaPaowpvQKZDWiYRno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jsYZLrEa; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNXrUIpVxtudjATCIb3EFPxcCBt0aLdN7ejCGQSZksD9o3P+s44jJPSNPoeirWXAnqvDQ3vswShGY/F/bN7yJ6ODFVFu0mYtSnJ4wnqBqUrS86ZRXdbJP8KgsZFjWUUiYwk4SkuoR8OyPwDX/Wo3uN3m/cBBX/Q1Ifr9WMN3mNm3N+QhckqvKaTj7k8DrorQW0ANHQvFIcNxQ5QvdxoIYdWvGNO5gCcLGXbEwHmFGhlxrW+KOj08+JW+e/sYjVia8WKSst7B/Zgk7+I30ztoxGTcLIGdYDO7qxod/U/Za6BaZWk7I1R4gqzhi6V077L6h3d61psh3aartptbdZkHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGI7KfiRKz+3IcpPYaqzWnAc70h3mjgkBxW95j49ZsQ=;
 b=wNsuEWKs3/RxHRYoMd9lW5KRkIgletxayLGZXdwX2CYRZY4TsuY5Lh1j/F/GL7cy21u8e7cMxx5Acn0mJGccNUefDcEDJDPMdWq6K19rKaYv1AwkEZfOtG6Katgy2sW0m1aUmkTUnB8EmAigtdac2MUPmj5MNHGoTabSFQAetX5PIgaarEvSMC/YzIZiuqpkc47+XlTVIUJLqdOG2m472Nx5Mad0N9rELalQFKTxUz7rop8CmdeT+VPA46k7IqBoBk0OlTwI7htC407eYih0LOqMARfqOyG5SqnGpGQ+s35zXJ4DYlSMVoGeeGHEZx92ZzdzNU3Ra5TpwOapG9Y1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGI7KfiRKz+3IcpPYaqzWnAc70h3mjgkBxW95j49ZsQ=;
 b=jsYZLrEaB8A47FUm5H4qiQpKFM4lvVoMxkUcR4HqKDYKBIEdJruc8mdJ52QEhQsY05BaeOnLNc1BzdD9tU8VzbMDDytyt+PLZiyRyjbZIcu6QgRXE7Ja4fzWC6lixkszkAe7MsAdTQ0WcuB/jDL+lOCSQGl3d5NDxx7E5L7DR9w=
Received: from BN9PR03CA0747.namprd03.prod.outlook.com (2603:10b6:408:110::32)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:42 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::4b) by BN9PR03CA0747.outlook.office365.com
 (2603:10b6:408:110::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Mon,
 10 Mar 2025 16:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:41 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:38 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 06/36] x86/bugs: Restructure srbds mitigation
Date: Mon, 10 Mar 2025 11:39:53 -0500
Message-ID: <20250310164023.779191-7-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c1937a-ad34-4a51-075b-08dd5ff24c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ujm6HRW0hUEKZxKe9HtrRBooR/I6dqaEl/ab4LbET72rG5tvEyaUENp4galJ?=
 =?us-ascii?Q?1RnHmwZjUTPRKgIC2r+uiy31dhmJBBh/G8mU0wShQoI+sdWmtHfyz0OuQ2Wm?=
 =?us-ascii?Q?hzT0FuPoSmIkWmDby7xVaiJ73htcLAvK6D+3/zqUmF1laNUphysUyKYRp4P7?=
 =?us-ascii?Q?50At5HUdGYOG/3Q/YeTuG17hug/Lnk7HM6yErvmk9FUSD0DLS5eIFqQJmRrn?=
 =?us-ascii?Q?FOyrL05ah6Op+dMXGHYphk5UXwZlpqKkpJT/jfTVxq65rkx/G351JJHtacC0?=
 =?us-ascii?Q?u88/ePbhLbazNa9jafmcyMh/cR2vbUnLtKfhSzqKuHKXIryeGC9qTWDeNoyD?=
 =?us-ascii?Q?ZGS0be6vrvTGJ4fhbmv2cS1BMwLSDvBZfDbnori15w+4NPg+0r6o1Fp5twA5?=
 =?us-ascii?Q?ZVu4QPW2DwjPdCrXDOLqMFBe6a5TCxbw4g8p1YVaZL9FRtS6jkRpuBI2B2QI?=
 =?us-ascii?Q?8UnTlHqLT4MajqCtSk9D/fs+lbMoR9wMYfJD8JpOG8ITJ5qHBorEXbmmw1Ed?=
 =?us-ascii?Q?UdxGggB+2uZvz9EUxLbPHryTIBo6RPExdEm3xaai1J3FWmIC1+eDK/TatuoJ?=
 =?us-ascii?Q?lPzHBYUItSqLNenmQzklpIVIuOatGgrHHAXh1sd5KJ1++Ixy9BOAn2/U4WJQ?=
 =?us-ascii?Q?gqVQ/Th8wckrJQEXddxpiYZzOQrZklTtYrhIOb24dJUDo91pwnPA23PPcGDg?=
 =?us-ascii?Q?lsydHV8A72K0BtvSVPfb3KrqGeMv0f/A+hUL+BQWM5nHtYFWiNLjw27MFnvR?=
 =?us-ascii?Q?JIx3U3dTDDD2ivrOGm7ur7XATE9t6ejt9plJE/1cCop6FzRJblPU6bCbHwrr?=
 =?us-ascii?Q?L1Nv+a/AMjcCMd/K/2/xz/4fmu9S0yJcpOz4cXUH9lBa4Pv59056Q6xpoLDy?=
 =?us-ascii?Q?uo8BhLZRLtAePfij79HkqTsgK7Y1zwcQ/PqXQ4OR1cZcYC/c3RueiUFGVlWz?=
 =?us-ascii?Q?Hnsw6T7+aBZf5P3LQH+qVvivKAz6OhPY0uhNJi7gfa/IKFnMnTpcr5s1i9qS?=
 =?us-ascii?Q?Y7N2ZS6jnBC4uVQ1Y49ByPBMtISZ7sPY0ysrASW0PXbYzrAB/S6BjPaOP17z?=
 =?us-ascii?Q?z/BARYvOUpQb7SQpTZkpNGeGHKy0A6QXpxlYwEasIasUzHD7npOLJFwjQbtY?=
 =?us-ascii?Q?DGTip1dtmVJfU1BPk77odQewPC2j+TcMbQI8TPWFZh+O56/aghOJe/TYKECN?=
 =?us-ascii?Q?ZQq54gJcn/X3r5PxPZmsYFfKTDtAzyhhGUDOgR/OFTXyRP8Ft26UG51Rj4q1?=
 =?us-ascii?Q?HgqpmmEfygaPg/SSsaEA1kJ/EouiWvH6Vv5Kbw63+yi1K/0HG31Wyh8SRV0y?=
 =?us-ascii?Q?ZnXPWrdJ51Is4CUShjAJ8diZMbuXYT1o9B3m85QqQER3Vzpb9EoSQOWyeW/U?=
 =?us-ascii?Q?kAdvh9lgFZQc2bNT0Cx2yZVcdzDURtu2fThjSS6jpFVZxC0uMYpn97HLVL9q?=
 =?us-ascii?Q?CuXKicgEXWjk3WE+/TPkV77pXf9yMZk5/ipNELHiux2XFi5H2D0PeWvXLEm6?=
 =?us-ascii?Q?bPyaFK2ANrldnF8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:41.9573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c1937a-ad34-4a51-075b-08dd5ff24c1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103

Restructure srbds to use select/apply functions to create consistent
vulnerability handling.

Define new AUTO mitigation for SRBDS.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 841ab123a180..fd04de518fd0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -72,6 +72,7 @@ static void __init rfds_select_mitigation(void);
 static void __init rfds_update_mitigation(void);
 static void __init rfds_apply_mitigation(void);
 static void __init srbds_select_mitigation(void);
+static void __init srbds_apply_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
@@ -222,6 +223,7 @@ void __init cpu_select_mitigations(void)
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
+	srbds_apply_mitigation();
 }
 
 /*
@@ -680,6 +682,7 @@ early_param("reg_file_data_sampling", rfds_parse_cmdline);
 
 enum srbds_mitigations {
 	SRBDS_MITIGATION_OFF,
+	SRBDS_MITIGATION_AUTO,
 	SRBDS_MITIGATION_UCODE_NEEDED,
 	SRBDS_MITIGATION_FULL,
 	SRBDS_MITIGATION_TSX_OFF,
@@ -687,7 +690,7 @@ enum srbds_mitigations {
 };
 
 static enum srbds_mitigations srbds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_FULL : SRBDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_AUTO : SRBDS_MITIGATION_OFF;
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
@@ -738,8 +741,13 @@ void update_srbds_msr(void)
 
 static void __init srbds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
+	if (!boot_cpu_has_bug(X86_BUG_SRBDS) || cpu_mitigations_off()) {
+		srbds_mitigation = SRBDS_MITIGATION_OFF;
 		return;
+	}
+
+	if (srbds_mitigation == SRBDS_MITIGATION_AUTO)
+		srbds_mitigation = SRBDS_MITIGATION_FULL;
 
 	/*
 	 * Check to see if this is one of the MDS_NO systems supporting TSX that
@@ -753,13 +761,17 @@ static void __init srbds_select_mitigation(void)
 		srbds_mitigation = SRBDS_MITIGATION_HYPERVISOR;
 	else if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
 		srbds_mitigation = SRBDS_MITIGATION_UCODE_NEEDED;
-	else if (cpu_mitigations_off() || srbds_off)
+	else if (srbds_off)
 		srbds_mitigation = SRBDS_MITIGATION_OFF;
 
-	update_srbds_msr();
 	pr_info("%s\n", srbds_strings[srbds_mitigation]);
 }
 
+static void __init srbds_apply_mitigation(void)
+{
+	update_srbds_msr();
+}
+
 static int __init srbds_parse_cmdline(char *str)
 {
 	if (!str)
-- 
2.34.1


