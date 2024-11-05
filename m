Return-Path: <linux-kernel+bounces-397200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC439BD7E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C133C1C22BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34EB2170BE;
	Tue,  5 Nov 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XsNydhLl"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E63216A2E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843735; cv=fail; b=LM5xhqBVdWfjtZmXFK7ldCBshw6uiJUFgpljtHaih5F7NmzxwZUoEE49ytodekH5Zon9MdUKjSV2/Dgo8K2NsgdVGrOAseWn9FwHJxVTVdevJPm/QDK2sJzWEbE9opPJAaXXSwhkMljqYXhOUXeLEa3ku+PNamVzNqTNBqmQIo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843735; c=relaxed/simple;
	bh=iLk3aDy/9I94hY6gUJa8/lLsCzNceTg9RoPM74xbbWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arX/DR7oYMGkmyk40TWaXlcx/KY1Mel7hRMqhGMxcp2TqbNb/tOumYj+0XIE1cIymCK3lmVBDKHQrUSMVzX88DEGJrys5S8+X3KO0pvgthFdanQyjLPiF68G86GB0HV0aPgjlTR2PuSVK39bKjD4M1EXDB8jfOX6Ot6pTLr5P18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XsNydhLl; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IklmeEZs+49ca/dcjPDIx2wB6fknDz6spnko3eZNDodO36ZHM3Xz6UMRqfAV4XyxvfnmAkGEIVwGJoSFpxBFCq7V5xS5ivSprVFYcJdmZNMFefjaToFP6RCyXVnlfeAz2EjFxD1b4o5fp9XTi2ZFuwDF6PCcJy99wTw3EHfYb2WM0BHjqg8MBKbgonlxpaCPZmptND259XNCaJCodc+F2pwZp/GI4SlsBYgvN7Or2+Y7dlSBj1xHCA5nnS1/fE+04sBXXj0IrnXq2hIc5BSUQ++s5g1+/awnDGzdrVmjLEVw+K05Vyrb7iQih2AxEDXSQE/yw6mf4msee29eRtzhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkoci+x/ijd7JU3pGDnPFf5u9C5Gjetnjhzf4ljTn3g=;
 b=Mlxr7dIx8QsTjl1BKVI4QJFpKtWE+dr18kDyfWAmkXHptJfYcG3mJtmr3U8o+qJA39+JqUQ3U5kQAk5xVCTeY5xI1sVMkCoQBVwdkGIaAxTFwh/2IF7Bs9XTtygedmbZpVUkLznzuAYYQYXYL4IPrqTHnZWbqec2KR1ol5BfF4A1IjJ/w596j4yUmkDoahTlKrcAlTfHfXqRg/nwpLWhFcFJcI/sE9Or9NIRbgu0rqaTTgJfYITs/3Ya+t++G1BaXLk3FwJKAzyVevg+fPvHPIhMTghfbRQRdJDSPU3HVQcDQY/Z5VfuXg4Qu9hZ94hkIEpRYFuBvMWZP1n+q46AlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkoci+x/ijd7JU3pGDnPFf5u9C5Gjetnjhzf4ljTn3g=;
 b=XsNydhLlIOdsk+5LiPDt9s8MeJ1vCq5HXY9WosUBNuA4QSdVHvkzSuCU8xwlyD0obrR2a4FlPAtRwb5s4ZtlkQnBxUNd9qKDm2olSypf3fANvPrS0GPVq9dTXcLYCpyptIE2Bkq0sOfqBLTIIT8yTBdl+rUiuU/rIq58G36zn7o=
Received: from MN2PR15CA0047.namprd15.prod.outlook.com (2603:10b6:208:237::16)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:28 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::d7) by MN2PR15CA0047.outlook.office365.com
 (2603:10b6:208:237::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:28 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:25 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/35] x86/bugs: Restructure srbds mitigation
Date: Tue, 5 Nov 2024 15:54:29 -0600
Message-ID: <20241105215455.359471-10-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: eac9e547-1cb2-4234-a36d-08dcfde48f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/QgjHZ/tWDJ+17Px+IFX9Tmuih/j02/MP3Mf7a4UTgojyUGuy4e5mfjEKbv?=
 =?us-ascii?Q?9btVY2Vu6R03r8cp+mWRzvlvthlkr07N9E/ZhwSW8egeJqDTJPaM8q0FWqnz?=
 =?us-ascii?Q?aZ7qlx7OKtjhsDGo6WWiFsXf6jqpowbOZxyzmCq1V0u2ml/okM3RUBw/as8L?=
 =?us-ascii?Q?uPDmI6UqTF0xsdhDVpBkkM7eSC/BzQvMvX305KIrmzQXex3P3ppTOecFYfIR?=
 =?us-ascii?Q?ghEi7+gIZd01AGYbcFyiV1L9vuEAZmSjV64/E4DcZGdof1a4+Tdo3iwqrJ4W?=
 =?us-ascii?Q?hocMJkU/zqxE4a26BQt9kbzNVphVbObcj1wO9RWUWqkHKKxB+OElsRh4u3Jf?=
 =?us-ascii?Q?useOCDUwyyUxoz5xRqBL3iZh1q8R5vy0Q9LOPp/M4c9ZFaJlGKFszDQK5nP2?=
 =?us-ascii?Q?siEJTT3tgg1E7LinXIxIqhoBkVqcu4ZgZauJwUAPoEXKM54yLThFTwGVfHpF?=
 =?us-ascii?Q?IlLbPxztZ26K+evPJEdYjZFseACeLfxcooJGuXTzM+2x45BPdyZhPihF36//?=
 =?us-ascii?Q?ENyzxuSS9mPFlgO4znBJg4ybG18EOzi22Hg0GWKdukuyt2Pdh5PD5KOZ87IR?=
 =?us-ascii?Q?lkS00Sftqwpvz+ABU2eRcC2AdC7WmHbHwBAa3fa1cBsWpMH2axBJ7FlH1nEc?=
 =?us-ascii?Q?x1eB1D+m89CKrkcZGRRBHVRY7fHsPPqIgf7EsSrjEsENmxio1W6R/SHJ5Cwc?=
 =?us-ascii?Q?gbo2OSOpyCPyzWQny+OOPEkdl+za4UFLjaQVWn2kw5YsA7Kb0NuvwU3EEQk8?=
 =?us-ascii?Q?iRu7flpeE2+mIwA3fHeFhnQ9n7uuDZKBXrUU3iarMCYwh74OL3svHckTcfM+?=
 =?us-ascii?Q?o/ipYIUAFxfypohyz6jLbeLjIGj8NDDEBlxHFgCp27sqSzt3YRnp0IrBC2iM?=
 =?us-ascii?Q?IZwwbnsL+Y7IPOG+qApITxuO+Go8PggyJZwt2tGNQveRC3RSYiDUnVjltqfN?=
 =?us-ascii?Q?fV6O8nsiqGrHS+UXuTRf4sSFWoYL9GJSnHCDs27ZMca3U/9Vz3+J06KSGyA8?=
 =?us-ascii?Q?D3FMft0mofphbK08oT0E27E2AcNSAdToFN1hRWUcSlAaLf4HkF0dYephbq7m?=
 =?us-ascii?Q?XozMke4VhDCUJXXx97kN56Pd8+vRl8nsWf2l2qxmb5cxengpu4r9Ws6OW1QT?=
 =?us-ascii?Q?cMthvgw/G+GveIDmKQVa6wZ2iS6klFYY31xYqxqzxFTrWP9xI7BYotYd30Il?=
 =?us-ascii?Q?/g4RI3JhDguVhuq7XUwA6gXb6ag6AElpNSZSPL+mTNe5M0iFcPDcthdllu+f?=
 =?us-ascii?Q?gMH2tsyG47Q7/PFtGX3F3h9Uu7Be09/0xnlqCUX3pqzqlAxMTroCl1WCv5ZR?=
 =?us-ascii?Q?U9/8myLoqqZG18NRIUdfanqfH7KMIMjF4hHuh/g9f7ULIkPi7fePAtbDP/k5?=
 =?us-ascii?Q?YwmNlS1JS3Jub+p4mBCUtc4JIIVOhW3V4nNRyXCL3Uotu21vLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:28.1872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac9e547-1cb2-4234-a36d-08dcfde48f8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

Restructure srbds to use select/apply functions to create consistent
vulnerability handling.

Define new AUTO mitigation for SRBDS.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5ad989e8eea3..452aa5994aac 100644
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
@@ -218,6 +219,7 @@ void __init cpu_select_mitigations(void)
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
 	rfds_apply_mitigation();
+	srbds_apply_mitigation();
 }
 
 /*
@@ -663,6 +665,7 @@ early_param("reg_file_data_sampling", rfds_parse_cmdline);
 
 enum srbds_mitigations {
 	SRBDS_MITIGATION_OFF,
+	SRBDS_MITIGATION_AUTO,
 	SRBDS_MITIGATION_UCODE_NEEDED,
 	SRBDS_MITIGATION_FULL,
 	SRBDS_MITIGATION_TSX_OFF,
@@ -670,7 +673,7 @@ enum srbds_mitigations {
 };
 
 static enum srbds_mitigations srbds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_FULL : SRBDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_AUTO : SRBDS_MITIGATION_OFF;
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
@@ -724,6 +727,9 @@ static void __init srbds_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
 		return;
 
+	if (srbds_mitigation == SRBDS_MITIGATION_AUTO)
+		srbds_mitigation = SRBDS_MITIGATION_FULL;
+
 	/*
 	 * Check to see if this is one of the MDS_NO systems supporting TSX that
 	 * are only exposed to SRBDS when TSX is enabled or when CPU is affected
@@ -738,6 +744,12 @@ static void __init srbds_select_mitigation(void)
 		srbds_mitigation = SRBDS_MITIGATION_UCODE_NEEDED;
 	else if (cpu_mitigations_off() || srbds_off)
 		srbds_mitigation = SRBDS_MITIGATION_OFF;
+}
+
+static void __init srbds_apply_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
+		return;
 
 	update_srbds_msr();
 	pr_info("%s\n", srbds_strings[srbds_mitigation]);
-- 
2.34.1


