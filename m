Return-Path: <linux-kernel+bounces-397195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83309BD7E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B3DB21CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3831216A34;
	Tue,  5 Nov 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bu5DO5DY"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F1216433
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843732; cv=fail; b=dCEPNevqXgA7z1N/yEG6dN2C2xksy43rjbTjD1DAIySDqG9m9oyEsuxYgb1MpisPHzmxb/YZmJUES9EW++B3F8/BRzIKbOv1vKh+CuPGS1XCIhu0uS5mpBZK7pQQ832H8UFQYcUd/fnjmZXJMxF8Ie+4daMr1AyPD0CJB2Yiu1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843732; c=relaxed/simple;
	bh=aEVLgSRHzgwlodrww7DAh+7u3fYYIgAWmVt0omgJrlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gS/aEDEdzc6N8uEInUZVwy0PGyQ90oF1j+gDV4MQDe4UNusOqSCX6X/WQMMtC6ooOhnuTh9WAbcxXcE04dlw+RcuGQxh9t0ACRtiOA1x07sEMMKU7UTz+/6raNqZeWHJcQj8QfLiWbJhvUjbQf+Jc2TmZtLuK62zQYK73HUPA78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bu5DO5DY; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWKzVHo3zP/BqBDzY08ncE0JH329Mjh1hQT4xn/9iOuxXJDzA5CWLLCJTDmQCWIxv3zwZhkXKBZDIOYvmk5tfLKaHSEL3TLFxGA2LIzvKrha93vqKfXV6/5lzzd6D9vlYkFOvPRpWu+sS4kDRgaCT3Q4tqa/kx/WSFdP013POi0Gyy+46IaSuzqrrIQzbhnhHVWMoqtiZcqw96Bg4Df1H42V29rnNzMEh98Rpi3dIOHWy2ANRf9mLRzBS5vCcWNlWnfe9V/c2jouzwuN9XUxCddfgsAnJWi0KSGIWFC0nkqumTn3BTPc999TWSGRvQLdjMbhYn4NVs6hgIeNHjXU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KTyZwd6y1gbldugynmCYjZ2hXpwymwICddmru9Rgmg=;
 b=jQvm8L/Z5aRy0iUsDmQFsESGFwraCLxDUoNdT/B29rC0T/vegcvC15uxp2fzdWkzLw0vf3ESceI2583AxPn3uaj64G4z+ylrf46h7jT4hVwtxbhFB6tcrhGz5v4k6bYX6xLtTgOmM4Y7t/rD8ZFurqEUIsI/0PhKZ9HBhkhn5ndmKSWZ3P/FyFl4pXySqc7bbQtMD/Xi/yVQs8uUkGrXTGTWqtpYzSUUqrwOwJqUFvN/M1Q5goRq5ovTw8fQRocaAHu3ps+/o6F5uEMOyX7wGfTTJQMKibGtr1Mfvgf7MUa05zH/IqadTzGewSrzgpvUR1R/xy5til+bQTOJnvmqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KTyZwd6y1gbldugynmCYjZ2hXpwymwICddmru9Rgmg=;
 b=Bu5DO5DYwmiBS7APINGlpU7dRTZEo6OXr9aATja9Pa/0Jes07KN6Cxb2t/Fx8CLPEIeNrOqkf7fDCiSrn4+6Dy7uvhUmXqUL2qrALZOC8hCwl04cr7jVVnBxcl+W1Pl3WfaLzjBiu5esHUYjA4WnpuQQer72tJyZOGlCDw+PHm4=
Received: from MN2PR15CA0064.namprd15.prod.outlook.com (2603:10b6:208:237::33)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Tue, 5 Nov 2024 21:55:27 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::4) by MN2PR15CA0064.outlook.office365.com
 (2603:10b6:208:237::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:27 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:24 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/35] x86/bugs: Restructure rfds mitigation
Date: Tue, 5 Nov 2024 15:54:27 -0600
Message-ID: <20241105215455.359471-8-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a08019-73c9-4750-2135-08dcfde48ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?19myPaHI/MHXrlPsfTZaZClTE9w0SSSVm2cTzLJ/ZGRBGO6V/u2AKZIOg7XK?=
 =?us-ascii?Q?hLACbx4Ahe6PoggL4B1T+RQFBT/U9lLpPFhe17HvrAU3gmdKxjilosNMewpg?=
 =?us-ascii?Q?xRXR87kMQdDWr+davu2D4vh20QLcwCHO4imtSd/c5/a60VeCviax/olCSLRN?=
 =?us-ascii?Q?7qFVRrhhy4YaUxkPhmYFhaXYR0lVkMGSNuPkl6bY/PKLRwA3TijGvoa1Wc4m?=
 =?us-ascii?Q?hUp4+0tJPfEr2vcABf0yaWz/PbZuWc6wX+sfQGYVFGtj0wEXmNgOX84Nm7In?=
 =?us-ascii?Q?FIA8DGDp4AGXMb3E1+4PlHgHpkkV+TkSpifWFC4ZVrCx90h8jIz7J28OTahF?=
 =?us-ascii?Q?sXKpA79T/xZjis8e/IqLOVEzRsfWKBM2xz3Xyw+WcNTKw+851RldALh++8Xn?=
 =?us-ascii?Q?tDGKbuBvVkDr1J4gZle3V1ln+tqYFkGAkkAjAGWEMoMRQumRwCblOBcwpwyq?=
 =?us-ascii?Q?5f1oOpHjyqxtpXPD3NszzgYwcc+zvoSP6Q7KK1JeAgjNN5UsRDIuOSCnV+vy?=
 =?us-ascii?Q?VpI853NybYksWEra9Hua58dyThEr7erT8j2A8WTepnkfl5p9ZQLv4kKnug2S?=
 =?us-ascii?Q?8QVi7YPVQLkQU8eMQFmtPK6vLE7lebqdUZklL5OCpFQIGN5TTDCLBk0kozT+?=
 =?us-ascii?Q?noRKr6ahWahhvZWfEOHfjiaP2MYdyUriZG5r/yrKcfokk7t1KAaWCokreM2a?=
 =?us-ascii?Q?SZnafi+4Tq8o/+H1WElSM5llwBHKscAEMLXPRIxH1YPLHip83HlZ7QHWUsan?=
 =?us-ascii?Q?tR/ZEw+/dJg6Wvnq1e2nVo2iM1/Z5IJUoKxYpw/iiRuUnXaiVGFRrAhE24eH?=
 =?us-ascii?Q?BchmidXnXtVIqABtRCYWIWRkJaCalG9K32rdr9LoUc4+aDfE6pFW9sJsT3gZ?=
 =?us-ascii?Q?vdu6TKUf+ot+SK944bkdw3mzfrWaQYcItnbn40V8FalFxDDmA+ZUm+Fh+ZS6?=
 =?us-ascii?Q?4SKnB+KnJeM36/5b2EOnbYvjFVYNHBNkOEDAACZWXAQnvYFDWvInwnNPe19o?=
 =?us-ascii?Q?WScvreSPKvIUD7C2q7+3BuT7xaKDdcRx7LuNCSsNN6SQLBkAjTSA+rZCcLAT?=
 =?us-ascii?Q?fDaoZ5n9u6jzi6DBxgxuxNlcsxNaz/jQ4TQX6X4AvXhZM+b0fRgqcVlevrFq?=
 =?us-ascii?Q?H5np4NjOGFNJMkW0EdvivU//v2ia6OygqTf5qm5NuNEqitGxKWDt58f01o9/?=
 =?us-ascii?Q?S2XHUSPphJ1y1o77h+MiFHupWdg/O19duxnqodpHdOAOJY6085TD5oPHT0pq?=
 =?us-ascii?Q?Y8gKaT03yPptM++ZDPtPLhvrPLjltgGN98fL3lWsyUoyMURpp7cWCJyUt95f?=
 =?us-ascii?Q?2pG20fXzcM0Pw5j+UbeePFD2Y0Aa9hi16zflNdIqp+U3xRIsDgknuZ7/myXs?=
 =?us-ascii?Q?yTHH7a4KocakRn8PP9MAS9BbXZCJdDNcOWj7/8XpFyEXx7nd3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:27.1091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a08019-73c9-4750-2135-08dcfde48ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323

Restructure rfds mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1332b70e48f8..c3a2d3b8d153 100644
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
@@ -193,6 +196,7 @@ void __init cpu_select_mitigations(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
+	rfds_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -211,10 +215,12 @@ void __init cpu_select_mitigations(void)
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
@@ -597,9 +603,6 @@ static int __init mmio_stale_data_parse_cmdline(char *str)
 }
 early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"Register File Data Sampling: " fmt
-
 static const char * const rfds_strings[] = {
 	[RFDS_MITIGATION_OFF]			= "Vulnerable",
 	[RFDS_MITIGATION_VERW]			= "Mitigation: Clear Register File",
@@ -618,12 +621,29 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
 		rfds_mitigation = RFDS_MITIGATION_VERW;
 
-	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
-	else
+	if (!(x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR))
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
 }
 
+static void __init rfds_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		return;
+
+	if (mitigate_any_verw())
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
+	pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
+}
+
+static void __init rfds_apply_mitigation(void)
+{
+	if (rfds_mitigation == RFDS_MITIGATION_VERW) {
+		if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
+			setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	}
+}
+
 static __init int rfds_parse_cmdline(char *str)
 {
 	if (!str)
@@ -694,7 +714,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	rfds_select_mitigation();
 
 	/*
 	 * As these mitigations are inter-related and rely on VERW instruction
-- 
2.34.1


