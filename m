Return-Path: <linux-kernel+bounces-397215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E859BD7F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7163A1F2668C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B92218593;
	Tue,  5 Nov 2024 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lqCqhA+3"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D9217904
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843744; cv=fail; b=mgHxzuq502zyUpqUpcXdK1jADXguDAyzZ3nyfVZYEJk6cwl/RCoKeEOKNl5iRZoCKt9NaI0bJfoYwSnJR+bYIO4ykJbS+PzTqJl3l9hTex0iwXCrJO+VIm04LsI/EcM6gb1JaI8KwzjW6LJsL2iwZJ4SAuVXlg8uAI0gOJcrsrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843744; c=relaxed/simple;
	bh=L756dl67M6CDX6/zazZ/gviXs4EOze/oITUxauzIOhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtoo8P5I2jPJnycnAZfpZ3o0aavI9aYZopzsbQvuBlQDWE5BDPGAU1KjONPBaBrn4wCCTCbMOF0jKpOPRQvXVFGauXbyn2N8zOuWIpb4tfnITZygsQknQPz5deUm6d5dYvVUAN0oCyB+tuUvbtVe2axqERySNMPKcwjz5CPs0YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lqCqhA+3; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp5PaBR/hMAu/OTfrP5HOi9R7k8Q9TK3gxSqMr7pRHObyD74mO+/WMR1J3T7uagzmmlnMkbZfYXffVcinsuAbYt9NyMrj4QjHY7FJ5yaMNxqD/J7+Rv4MGLik03L+iRHzK24CNuc28ff8frarA93/d5Qfk07hNb4+whvgkAw6B4ZwilahnyEt8BeJ4kNet4BVOLs4KOotqyxopAYGw3gi/3Ctgua+wn34JHgAYeuRC05zeno7HRGMCHWi4wGMehfVeeXnDbSxOlngrNz6NeEz5tlF7TxOn2090Coop3f2UUfahX9QRz28HA0RmrxyAFoV+TT/I1m3itU9r9hPDdEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJGBwnlp0mWArsnb6UbqTIPrgJjXlgbtHLE4cyvQFAA=;
 b=RKnctWtU+8/JJS1uw/8IlHEPMkFPJjXpUA9cjWLciOCfHoFKc+KzLI98NriYdbVuNjxSh7PgRN9Tbpks/LMO83NXBZvOKKdUhDZdmXpp5sGtdVdX2HNd1HVQZXeUHaO8SA9uWywrOmPR/iRfNf3qKqkUmKpbwpEF+wVCsCh5NHkRekBRjfQCZUN5YnX0ezogZo8pAOK+MSS96wqUzw6sDPRZJUMQ6DWSkUnQ2C5UXXOwIfRvr/hxWIP4Y20xku/IedAtatLh48LdEF/8dHy0csNNIKCtxSbHyyiOMFTHucsa+0S8dbCF0IMflLT6EktiDyv3HcfFWRQ6xRRUlxRFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJGBwnlp0mWArsnb6UbqTIPrgJjXlgbtHLE4cyvQFAA=;
 b=lqCqhA+3mOrowwavwxrdwLUZmtdU4QtCIllge4llaFhXVPHOBBMvUXh0n8Py7eLlTdH1j1B6wgc+jd9DqEFfHwsB/RefEVQyuQcpRGdw8HXi/58mvf7Z1kBRL7Fjw0OEdmWCU1dkg9pIaCZhYb5SB2C8k+LpMtmQVHgs/fjQ4Bk=
Received: from MN2PR15CA0066.namprd15.prod.outlook.com (2603:10b6:208:237::35)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:37 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::e3) by MN2PR15CA0066.outlook.office365.com
 (2603:10b6:208:237::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:37 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:34 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 26/35] x86/bugs: Add attack vector controls for srbds
Date: Tue, 5 Nov 2024 15:54:46 -0600
Message-ID: <20241105215455.359471-27-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 421e7bbb-e981-4a0a-c6e1-08dcfde49501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0FFegqN/2D1xC9J/eMj7KwovxMxVVdRsqxkOmGQilRCuShNz81flusvMDk25?=
 =?us-ascii?Q?jLNs/5/IID6TMdz9AOovrXE9Elv6PhNiKJP0bEk18mG9n3eWFFYThVuWEnVG?=
 =?us-ascii?Q?hHhHVfkdV7SrO/5agdqweCU+6xyAHtaPrNn0kao3lase7jhP43xrVV14SnBi?=
 =?us-ascii?Q?uGglVESpQZW5n9qZjapJ8x0/D1C5at+VrbK3Dj6rdBjFdt5w88ZjvsZ+1ELe?=
 =?us-ascii?Q?nV7VfNqg+9ldsBAqDHr++D2z67o2Q6MzTSqnBYE7eTVLUvEeOfW4uS2ACPTU?=
 =?us-ascii?Q?AyCHw6Iu0FYvv8AsyfHOp5lE9JNtdNoOlBlYCV/1/q7TWobFpf2AcQVemYvO?=
 =?us-ascii?Q?dANEIiHeZlf7KsyZGhkmosoXxsFrlEm+/FsOvieRcntVP/EGJVuwHy5wd3kl?=
 =?us-ascii?Q?y9a2AQMcgr4uzCzhpTSY/MQfEaxRP0HSyVEqD7CN829htHz1uVGvFNcDCFDP?=
 =?us-ascii?Q?ZbqMMMFn4a590wj+xflhkKGxVGSkpE8CgvWmrC87js2MuhUfHeqqDyuOeDe6?=
 =?us-ascii?Q?Lve49yEMphQGGGUnfx12ngfweIpkLEm67ABdmnNTUllaEHOUfHFkgywMKLJQ?=
 =?us-ascii?Q?0NbpcGs40wG8aLWrceEiCH1FPdeVPneRNRbVEMc0DYKBgvQLpKdIfvM11+v5?=
 =?us-ascii?Q?j90O7ny+dVtPP2svYKtMCATHnWrc+ZYnsmjL8ajGLFpo9JkrjnTbuLVYWARL?=
 =?us-ascii?Q?WkcKi2Sypzu+6+0RtmzGUX65LWFbYc3z7it2xm6a14K7evsHrI+wy54Uw6e/?=
 =?us-ascii?Q?4G+79YN3yfLRHM4cwaGrUSPgYKIpMzWJaUGAHKtX2Oi88+jWC2+/DDTQ3zG/?=
 =?us-ascii?Q?HAL+/3P8faAteQXmxO4hBoKl58hRUF+uzDsPXPQtDDr3ID8UB1/ejr6y4Kpu?=
 =?us-ascii?Q?Lh2WOl+v7B0MU/AuffA6qsJyFK+KroJv6+K7QU+CLRsqaU+kPskT63D3ZhhC?=
 =?us-ascii?Q?aGHKWrPzHPaXCyTT9N66+Vkov/vvxKk+jMZwk9V+dJFDSCBe1C39rbvDjKGZ?=
 =?us-ascii?Q?CeS1RFW2lcUX7GDEkjBug0FcyREWhyb1+swOLWrRNuk2jRh1TjOpX3uehqiu?=
 =?us-ascii?Q?Ha1aIC8gAHh5rTzqsJgWz3xRJ6KwPUpncbBPVti9bTbVDRQkAUzJuxdfPU57?=
 =?us-ascii?Q?sxsZ9ALoN/IQ+S254aY0AkG0DP6if4DCaeR/MVVM4Wer/AcZlTE/rJKiGGPh?=
 =?us-ascii?Q?b0IdCYkElT7QjAKeqsXcFoyiPRYm4Lvaf4ETOAyBBLo6nPse4j7wEBIe1HKl?=
 =?us-ascii?Q?bJ9zTDyuD/xemUulqT4WtIwYzdx01v+XTcFdvPO61SKo8ni6LH7q6HA/Er9H?=
 =?us-ascii?Q?EdEnjed8DmSIbX7swfcsOUaPRsHcnDkNm5l/1y9Dl0VppzQxPB4SV1mMVct4?=
 =?us-ascii?Q?Wa7N3Ac93V89NPWIMSVEVC7dKyGRZuxzC40YT6zeVqyY/2l9Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:37.3435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421e7bbb-e981-4a0a-c6e1-08dcfde49501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

Use attack vector controls to determine if srbds mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ecf7046673b9..083452942264 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -834,8 +834,14 @@ static void __init srbds_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
 		return;
 
-	if (srbds_mitigation == SRBDS_MITIGATION_AUTO)
-		srbds_mitigation = SRBDS_MITIGATION_FULL;
+	if (srbds_mitigation == SRBDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_SRBDS))
+			srbds_mitigation = SRBDS_MITIGATION_FULL;
+		else {
+			srbds_mitigation = SRBDS_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	/*
 	 * Check to see if this is one of the MDS_NO systems supporting TSX that
-- 
2.34.1


