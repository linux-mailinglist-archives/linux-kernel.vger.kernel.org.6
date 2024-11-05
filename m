Return-Path: <linux-kernel+bounces-397213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FA29BD7F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFEF3B2292B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36100218308;
	Tue,  5 Nov 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fPv/te6h"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20AA216A02
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843743; cv=fail; b=dFvju8+pH4fWLUqLk4tUM+N3OGVwGg059NssXzhsHyuz+LpJQULDVvUO/jr3HzODa+25q/ZBhktY+j9dwo4xWeHpc+tBWSD6PKdbGh2x+NPspunV1HEkE66xkvchUvZ9DomZ2oz7tgeV8veCtmOx0OnXE7GgjQ1xlqtmdb3t5PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843743; c=relaxed/simple;
	bh=2IoyFCPJ8H7Fwi3DUbE/dLTlxvH6Lh+bQ1Tc1JFHaks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtJrPPXmUmTmULrM7wFUVIbf3ucNxMI4z5lluf3OgyK3JBGiSy7XZtX87rrOR6r8Q0Bxd8jT4jckJMI9UGCMQk5cTr+D2pgMycoxz+waFPDVoHx3i4MIDdYvSk+4tUC4ZAmrjd9QUuOXHL5RfXTk77/kNrfO1/3zDSZE0beeLd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fPv/te6h; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqY8GZBp1KUxOcQ3Otw+KRsU5gde6jSqjzCTWeOEP8pIVg4J7SOjF4M8Li6n758CI4ql6EdevD5Qz5y3mqMVVmvSPnf++OJ64tf155lq9/Z7VoWyWjeSlFmTqnQOZr8/ANWbug7zDoqQrtdFM1QUsQ+3msUA1tNVPOD/nRF3WEliwS2jucOtYK9EdPLKDN3pNyYd+C97DrPbRs/i07v2yY9wKnzKPV1ruD4Fi4yvP5eZ2ZNgiovhNFUuomrrbi79kWziPEVe72TMX325x/bgdyTbBUdNIl/y0aadEnNMTJE2oRkwPVWLKJd+lsuP80sBKUH3EC5kNcc5uQigw5WmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOcyIb6TiFnmXDsiYA3UUVrMktYMhGpQMtXO/Xl/7g8=;
 b=Uc6wz1RvEn6Yeclwz5rG4mdzJwT1yNe4fM/vRn/fIf1Yvm14aOvqNIntRnMEMKw8C6AB41cwnOGJi7xL/4lIs7eqO5kPLfMPcwm6SJXNbrdJKD0/kA4a36WKH6hD98jDUHNeqZ/VvK7+DyM1jBbYnTnOsn9op6jomRHHbJLVK+KlswLUP9q3YhGnfokx497SYtGk0KKInw/K8wMQdOmmzqvGnrKe0HoQeYyqbSFA9f7vDodk/GLg5CDMCUuJdu0i0UaawGmBEx+F53W7w+EYXThu4mx+GfuLAq1jFSspFtIOPlq2FSeqK1f+/3oflr4uXcTNTJV5aJDAf3rbTZ8heA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOcyIb6TiFnmXDsiYA3UUVrMktYMhGpQMtXO/Xl/7g8=;
 b=fPv/te6hNRQDT4rj9WYFW3dgqe0ZPVFfsIS7CoLvUTuNW4Fcpo1Q5pvZiqXphiUItSWuYpGiDhZT17vxlcXur6YR5pnf+zrYJUioH61WXeJkSUudX54BR9ulzYL3Iuidn9FU3oQWVFUWR8L2gMxir77Zob88fXZ8TZVdwb2/2+g=
Received: from MN2PR15CA0051.namprd15.prod.outlook.com (2603:10b6:208:237::20)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:35 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::cf) by MN2PR15CA0051.outlook.office365.com
 (2603:10b6:208:237::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:35 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:31 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 21/35] x86/bugs: Determine relevant vulnerabilities based on attack vector controls.
Date: Tue, 5 Nov 2024 15:54:41 -0600
Message-ID: <20241105215455.359471-22-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e19eaef-faa3-4ef9-ac6c-08dcfde493e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f7j1bBr/gQ8pgMok5vPczDu0+iNPo+p5P3fllfcTAtL0AQRg7tQcFfulyEDj?=
 =?us-ascii?Q?uESG2zFdRI5Jqxg+dBhgFxKOt2zrRaOGy/MiGziWmVQvJH0xhtW3xl1RTnio?=
 =?us-ascii?Q?Wnwmw5YxW4IxHMcPjn3bqfTl0UjbSSfJkq1fSKx0lDsnNdwRBrhD2gIAsf2J?=
 =?us-ascii?Q?vsjEVYoC3Ib562zcgPDhwZ5Usqi9M/Hzc9thHqzRSmnNwRoIOX4fakqmeOkR?=
 =?us-ascii?Q?ChRjY1BNkXvRVyHl3EpWalAPEMhrauFxWXivqtyK4zH0ZYaxM+90Z4PCHvxz?=
 =?us-ascii?Q?J+irD0IJtMX9vxbtDV+HFTdW5sHi1Lpbqz+YUUsO7AGpiNMXseqQqUD9X0+m?=
 =?us-ascii?Q?Hg/fGMldn0/pbXVtP4j59Ej3lCU25ZtUHBYg/PzoQJBsykJRrXHJ/LWIQNBY?=
 =?us-ascii?Q?hKkRxrmrL7G2HNg+QMQsyFTSGGcLXv/k+BjpFYiTajDIOZPc3UliBc+uo7Qq?=
 =?us-ascii?Q?xoIJrzys1ry4APtthdGwwDNz5Q7lybaZEz8utIahzhPGetFgAFnrXNBu1Dbr?=
 =?us-ascii?Q?1Uvug/6eWYv/q4spRlaExxyaYHVIio9h3NgVQoJIrENLv6n1LOG01n+YsqWk?=
 =?us-ascii?Q?Ijj7RTmn3HlzD5cu70+V92hCFJTnctqbnkpegcbKo5G9mjtlzTQ9icEv+PUv?=
 =?us-ascii?Q?+bIx8cx66fqSmzFwbbtlcmi84a3PaSmLl+8EjOSefRo4dv2DwIsjQm17E01+?=
 =?us-ascii?Q?VxMNoTZxI0FHpDKQMO/erF+msO0QUEsCLQA8tA0uh3f2QaGIyybut/UKDbpj?=
 =?us-ascii?Q?z25/md9hDnczFnP4dkG6cysFOWX5itgn787JsZeLlnahYr3eUJk2b3AEqJY5?=
 =?us-ascii?Q?GongwMagczPHtGNXfKAWmYNdxCVj//4SJDkoR4KNo/p91qqSmc5d24KUMFUG?=
 =?us-ascii?Q?xZX2dRYK1EqYYRVn4dSq9gUtBm86pdv+D1MktYaZsPm7dt/2tTFgblJKoc72?=
 =?us-ascii?Q?84uVVlXB4DQphYjlJdoqIh6CpgvFB4ecSjr9+JbWcXNe12yLtEigfpamq8Yt?=
 =?us-ascii?Q?aGufJJHw85wHvpMuzs81M//xsJy3sBCPQR2W+lm1uZmwp5QCqPDWLLK8M+yU?=
 =?us-ascii?Q?M9WZWLzSOujdSrSwylLgknLe0uxdtkC5P6oyYRGjkGqcTpKs2xUumX/Ud09o?=
 =?us-ascii?Q?MVvLyGv69gDtSokqCEUgsEnSOKGsEsKcSrOCTkuRxd2jIH4fdpvjfK9OBVO7?=
 =?us-ascii?Q?3CN4wtm9n9NFGsORyEzknJCxO4wUlR7nZAMVGv5PJxX5eQ7usSmSGJsBHOHs?=
 =?us-ascii?Q?eqmyzuDOcktbw1TwSBjG6Z2H3hi511Bdp2IJJBDP89qf2oycnaa9oJ16BlSy?=
 =?us-ascii?Q?ymF+mEjKFGcbgQL9GBncO5Ddu09yVQANuZQCAsXyRcz4YfrKUckcXc0GhzlG?=
 =?us-ascii?Q?IKTutjxJrJMVLE8GX8nxSvHJCXuVlUNmgmfTUU1M1qwitfQGEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:35.4685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e19eaef-faa3-4ef9-ac6c-08dcfde493e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672

The function should_mitigate_vuln() defines which vulnerabilities should
be mitigated based on the selected attack vector controls.  The
selections here are based on the individual characteristics of each
vulnerability.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 178415d8026a..6a5996d3b324 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -287,6 +287,75 @@ static void x86_amd_ssb_disable(void)
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
+/*
+ * Returns true if vulnerability should be mitigated based on the
+ * selected attack vector controls
+ *
+ * See Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+ */
+static bool __init should_mitigate_vuln(unsigned int bug)
+{
+	switch (bug) {
+	/*
+	 * The only spectre_v1 mitigations in the kernel are related to
+	 * SWAPGS protection on kernel entry.  Therefore, protection is
+	 * only required for the user->kernel attack vector.
+	 */
+	case X86_BUG_SPECTRE_V1:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL);
+
+	/*
+	 * Both spectre_v2 and srso may allow user->kernel or
+	 * guest->host attacks through branch predictor manipulation.
+	 */
+	case X86_BUG_SPECTRE_V2:
+	case X86_BUG_SRSO:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST);
+
+	/*
+	 * spectre_v2_user refers to user->user or guest->guest branch
+	 * predictor attacks only.  Other indirect branch predictor attacks
+	 * are covered by the spectre_v2 vulnerability.
+	 */
+	case X86_BUG_SPECTRE_V2_USER:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST);
+
+	/* L1TF is only possible as a guest->host attack */
+	case X86_BUG_L1TF:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST);
+
+	/*
+	 * All the vulnerabilities below allow potentially leaking data
+	 * across address spaces.  Therefore, mitigation is required for
+	 * any of these 4 attack vectors.
+	 */
+	case X86_BUG_MDS:
+	case X86_BUG_TAA:
+	case X86_BUG_MMIO_STALE_DATA:
+	case X86_BUG_RFDS:
+	case X86_BUG_SRBDS:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST);
+	/*
+	 * GDS can potentially leak data across address spaces and
+	 * threads.  Mitigation is required under all attack vectors.
+	 */
+	case X86_BUG_GDS:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD);
+	default:
+		return false;
+	}
+}
+
+
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
-- 
2.34.1


