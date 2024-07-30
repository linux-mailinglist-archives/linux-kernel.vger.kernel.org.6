Return-Path: <linux-kernel+bounces-268138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1319420C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C09E1C212A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA018CC02;
	Tue, 30 Jul 2024 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m3ZP6rz/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FE118C93F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368439; cv=fail; b=rgIbXMUUHBmhLCAErGqCrPzhqQvz2VOiDleWp1caOhBZvAWyCtgDUIodfT/aSNz3VloXy2o807pI2JVUluj0BTogrZpTbFaGZw/sCKw0qHPU4wgdQKBxwteBWKxcRjrgW/CfgRdplCUHdoqA8R0H5ima0fXohvHNKfjagon7clY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368439; c=relaxed/simple;
	bh=T+AuwQVlO4kVy2UTybr9Ssl+QOUDs4z7w0Yl9022B30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoZckVaIWYIr5bX0tLbngodtbHtk0CB4BB5/LaQY9GPqRkjeAlJpHqAiIFJ/9ap92xloDQbQQo1WbT43pirrPSKxfrBwKs2/OgvZE9rynhfJcOOJjXpMZlmQipZB6iN6QJETnGT0jPmySs0w4gGBZoYbye0pHdSafGg7zKcMxFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m3ZP6rz/; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvA89MEtHemkwARsKEeEexMl6kgVh4exJj2xCdI4u2ngcSpD2RxCijtf4xVaK5jDXUmfdjZ7yDV3F3tQ2YVzwGP0wY6KCTSqKVGR6LrItJ+Mrm5tpH0QVm5kLjOr6k8hk3d1+NKNDlUMu/EI3/2Fcoh8TDt9cWEbCES5yeqSmIw4XNLPcsR37kSEE/ThmW53SY4riE33Rb6iPUDCNTNcrLcdSYKNuOo7rOtF7WuiE8D4wgaBzi9Us49NSPMR1K+/rjTvoR2ZmTkR8vjNDCCvXCbvXrpc2SEiuupkljFPp4zicWPA/KBAhgzUVGOL4gBef0oiMB/DrottxINjiPyPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNzdsdorqmzdI1TX0wknVPixlglwQ7l2/ZAdfw+j/XY=;
 b=ukeQRfbxKypaEeVCcijEq22QmTiKfVfMdoMYSXVHJ4jk3Y3wlweurmJsfwWbFH4PcHKi844B54LGzKvt0tYGsSqo35DJGmdKfGxeakE9DDtgcOOddM8uFgORUGWYUuqK46Rbto5m+zOT9RNX+fHSM2dMtxurLciFiRyZoMrNkQQuqWBZdnV1C9bQtUy0ii8I66Bi8ACCivISRgPFtPlpDTeGL1qdwDJ3ZJl1Tmdkwidx+KSnFlxp8D8DQwKgI2HC2ixBvymI5n6GHLl4RGHEvMZMXcqcaZKbxmpVPvSxxFndsaAKp8zgmLIeWMh7vwbpFyDei4lmklyhdxgXycTX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNzdsdorqmzdI1TX0wknVPixlglwQ7l2/ZAdfw+j/XY=;
 b=m3ZP6rz/obpyfrdzb1+F7H6uongHWBS+ejsfenVwixTCo/u/Or04A1hOTjqvNe2/ILo0FZMqst0SSAEIGrqnSmq1ZMW1PWyPPUDFiroLrKu/6dzMlgqlyNlECTVVdCT1N4SPlfYk9q3ashhD+c258JgKW89j/KeLniyVV0S9mxw=
Received: from MW4PR04CA0351.namprd04.prod.outlook.com (2603:10b6:303:8a::26)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 19:40:35 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::6f) by MW4PR04CA0351.outlook.office365.com
 (2603:10b6:303:8a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Tue, 30 Jul 2024 19:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:40:35 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:40:32 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 2/7] x86/sev: Add support for the RMPREAD instruction
Date: Tue, 30 Jul 2024 14:40:02 -0500
Message-ID: <97c2a5756294188cf4b32cd87046fdc7116eb5b7.1722368407.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1722368407.git.thomas.lendacky@amd.com>
References: <cover.1722368407.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: cc339a2b-c3ab-47c5-656f-08dcb0cf7b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O92gG3PUFJn63BCacKYEDeDs6/zkAbBZAZZ58VeZiU8lXgCvgWuIkKukxetV?=
 =?us-ascii?Q?Seylc8D6mFR/eoZ1XPxDhpWmy9P2oHrf2AbZnQuwjkzoq0Gx98h45BLMLKvN?=
 =?us-ascii?Q?bNo8hL/GA25DQ1nlRUcCfqMeYVLOQ7poPODZ93qzr41EU6oGmmuSa/PKxvfu?=
 =?us-ascii?Q?GAvMyb8io5/48AfM8tjVj97Vw3wqXJlKnNy0MSmJVgRAOVV34CCjCPUP1sct?=
 =?us-ascii?Q?vJ1dur08US83CBiBLLviKEddlOyYdEmSzaMr3/txwQUZx61+klDNRI0xeSlA?=
 =?us-ascii?Q?9OT0Nfl5PJlIjh/YQRb/yrCx4mGuZuV4efHlECbPaub5XpTRJTU4ifXPiI5h?=
 =?us-ascii?Q?p0D1YG0Y038YD7PHqXjGZEbuGQak3y54HcpRXwH70AwU69f3GkeASca+FgZ3?=
 =?us-ascii?Q?N2yOY7ReUkq1gzf/OzxpSAWF1cTlbrfZrUTVxyjnJiZJRKhGl82MkFFhQkYv?=
 =?us-ascii?Q?K9V27FVlTsQNoz8pf/1/oVVDIq6DdrOu+sbVgpOpir8PJboxu3MTXOh6PKSi?=
 =?us-ascii?Q?SobvA5Q5TUn9OM7botuj1obWEOX17vSFZobz46bbCYERHWem+vWnRy1NvDL8?=
 =?us-ascii?Q?V3oOtWLgeUmDUnkj2IANhCuQP1zAjDWhy/GIt+CyTB7VeFX/VB0+LVRdJjEv?=
 =?us-ascii?Q?9JcXJdi+ZnGgUViHgozGDGWhYZX7TEYBKieTqkDRlkPhYw2W4JeEzOwWYIQl?=
 =?us-ascii?Q?FyCCzStizqJjqj7R52WOoQRQmMO9I6N+F4tqZTbd82Sjh7Ubn1Qd9gGvJxBy?=
 =?us-ascii?Q?EUAzFl8/sXXqm199UArRdQ0ls60xd1QA7EaJAUCPhubMV1cXvm4wClhs8XRi?=
 =?us-ascii?Q?Yf+G7pXN4Lv7rMe7S7OQnTZ80bcXP+K4zpj2A+gzhuDFSE5icxQWI7TH4DlT?=
 =?us-ascii?Q?yrKBDLOTvQZi3oAyxCH2ctQ6EKI3A/J5H7dA+LKOnLDTu50nUnhXJpqIyX0W?=
 =?us-ascii?Q?OnpPFk45VGceMIV/J4DKpjMBYwwpR9Nmrx1pWYDEhSsSQRvv+IB9zFgjW436?=
 =?us-ascii?Q?F/xwDh8M2jJzx8Ceai5tvpKQogHknq8xR+OB4ZhTTeibo5DrocWmkbzXNTm3?=
 =?us-ascii?Q?lf9ykDyeIoCUKNvwhujCMLKgrp3QOf4hZVNnzRCIfD5Nn3Q0r9xr2Ao3SCfb?=
 =?us-ascii?Q?JYuadjCHzcxY1dmq1cyxLFmRKn381bbKWM/8p1ZPgEFMabr2Y5tQDqjoHHwR?=
 =?us-ascii?Q?rGRNyVuqWghCZVY1AuGNw6QBnDV/FBH88OT4d5FRJDnko13oHGEjkyj4qMO2?=
 =?us-ascii?Q?clr0VQbRRRccrmUTymeSac5Ene9nO/JEgW+tUNAWF5jYzzaF0x6hB1U2u2Ox?=
 =?us-ascii?Q?sK6Hj3WYGUJacKGDzBU1OOfrbQKZURCYezACsWkiwegg3RNGpGhmK4Jz2grw?=
 =?us-ascii?Q?7RxxX1N6elkefc6rPgR72d3XiiGEnHqa3umeBwmrGo7XXgNVhUsAVPcUrRgL?=
 =?us-ascii?Q?8tWkoSWKGYdiLWQPgwvOmwxoAqxWn3Fq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:40:35.1215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc339a2b-c3ab-47c5-656f-08dcb0cf7b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707

The RMPREAD instruction returns an architecture defined format of an
RMP table entry. This is the preferred method for examining RMP entries.

The instruction is advertised in CPUID 0x8000001f_EAX[21]. Use this
instruction when available.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/virt/svm/sev.c            | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd4682857c12..93620a4c5b15 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -447,6 +447,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 103a2dd6e81d..73d4f422829a 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -301,6 +301,17 @@ static int get_rmpentry(u64 pfn, struct rmpentry *entry)
 {
 	struct rmpentry_raw *e;
 
+	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
+		int ret;
+
+		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
+			     : "=a" (ret)
+			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
+			     : "memory", "cc");
+
+		return ret;
+	}
+
 	e = __get_rmpentry(pfn);
 	if (IS_ERR(e))
 		return PTR_ERR(e);
-- 
2.43.2


