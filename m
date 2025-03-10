Return-Path: <linux-kernel+bounces-554705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB42A59B64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F10C188627B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBCB23F37D;
	Mon, 10 Mar 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yRSCQ5sr"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956C23370B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624873; cv=fail; b=of9yFuYZZla8o5Fj5j2VwuXuj5REzD+iXdpLs7sWAhsg3RvT224eZQNyy4mgKLISHuT+xEZxVRtnUhFtAa9+V4dpU7GR/EK8JSoVujv29vlA2n/Y1csvJ0Z+fnsmNlXuq+EfrV38zNkYkGq7XOzpYAQ226hqqPl9Rlatllr9qqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624873; c=relaxed/simple;
	bh=TxWnPHmts8KaPFLnQ+3uYikf58KyzVIH6vWH8ifzfIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coRnZag2Rt4Ts4S4EBT+WVg9DXNyAIbgZo7m7WisqkATvgGM2FoZ4xu7qzSxvlqzcYLAPA06eCfgGAWzvKGUNDsG99EUf0pjHncNKaSry+eEKtxbA/p4fx7rrnn1AMrMlqwV0/GJ8A253d0xF8KHdDdceROlCwyQ41ug9r4vpiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yRSCQ5sr; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDDVLIWf1g0EnTuErc8O3CmxkmGq5jlyxgc09bKwicQxjMNSv9QEJfAUDYLVMKZiq6J8fLCtgkaejzLDeXEzE7qTu+BrdpoDxvNQn0bfJwIWy2efWiDKvmDI+zLtOUEC8mZ7aWkHJrbWSktUqxxXEzfDnnkhktr9VQnwU+KcrmWbvPj1bPBIxWCb6RPmeGanpAVEHj25PGg3RwfPaYO/0PkyJtjp5Iu1I5yClODsxBQLwjlO8AwVkcHaifsq7xtE43IwLGEchUp8bJLIl/WaD8mZRuQH049kSW3iqZKoNXb83ZPuY6N01/Xo2bLDUHu7OMAR/Y8fJvOJFj5DQS9jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSLDcWQEohhQTZNZtq5q2yVa0ow//ukw3v2M2QshXOQ=;
 b=FfQ132J8QQvROY5nDjentx9vQTxDxtHbX/MY/GPEH6B2mnOZpX9C96L8pgydBqCK3Eoh48QP/jNLzlVj8Q4QvcV8zWNUNPDUor8CEScBFnoWvYbHxWbDLM29Fd85Q6yCzv6wUCU9Bs13MtAtYiNV759x741gQR1hKOZOspgKy8b7d7ruzOxYbLPbE0yeXy9cHjS4RVs9+bDDjBTSfV40lnXu0DyBadEcBi6JJM32K+v2gKCy/UNVXA0qUEAwSXq9/b/58wQb51sOLPYq9X5NAb/cB1iFN/ofXMmPwlUeJ70tn28lDtq/b9AmarwlpsAtZhD0dloLKYcRHUPBNPmWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSLDcWQEohhQTZNZtq5q2yVa0ow//ukw3v2M2QshXOQ=;
 b=yRSCQ5srzsvyxnmMHf/83+0s2Txxwo/CaUOZncB1aSxsy42EqfGK4MSEIpAPUcVHQJJ1FZsz5HA3hxNs9fWpIJ67MW495C2+iEcLCJFvXUGf+nllZs896St7140HoQ5feRqDGWY7hyns+gAOkOScnhT9JTumVCSLSgVN6TaI2uM=
Received: from BN9PR03CA0088.namprd03.prod.outlook.com (2603:10b6:408:fc::33)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:41:07 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::50) by BN9PR03CA0088.outlook.office365.com
 (2603:10b6:408:fc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:07 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:04 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 29/36] x86/bugs: Add attack vector controls for spectre_v2_user
Date: Mon, 10 Mar 2025 11:40:16 -0500
Message-ID: <20250310164023.779191-30-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 4278ce01-ee0f-4e0e-7c3c-08dd5ff25b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7VzcC64m0sb0mtNk5pcKXHwlYe7oRFivla77Mqc5nL0MV7kkeihlRoxwQ5A/?=
 =?us-ascii?Q?kc4BeFAGIROeES0BtowCp1HhSRUV1zN0oNQhyxgbhQm7VTUBWRDR9WLTlIHA?=
 =?us-ascii?Q?KdqkDeOdwDfrq8Vq3bMebp6fui319TI3pmht04E7AVPkZgDr+AsHgqWfeu+d?=
 =?us-ascii?Q?/S10mcCfc7sLX7NT2ZoGQxgymLZWYhXWw43dtDPSHqzFfqyHMjSUH0OkhXCK?=
 =?us-ascii?Q?V7jnvYsgw7bfqszIoX5FvM7+Mo4iXqr4rJSMv+ba0mrFy05fYY0vk0Yqz6z1?=
 =?us-ascii?Q?crpyWvriuWzHGnPmdqFYroIHAE3Lq//xeIKARGZntbBgk69ZUh0PQiLRLuHM?=
 =?us-ascii?Q?98CpBRmyl3kSR1eeGVREev1gr0JCdOjOJ6NN5KVgne1QIYnbepgdKN787Hi/?=
 =?us-ascii?Q?dSPhnS1kWHR4NUr8rJr0Qqf9Mo9FtNn3QDrp2PfH8XFfsbaCEkrlRVUgdxh0?=
 =?us-ascii?Q?j2aJKQ982zT160PKL9GpabwbUfFVv3al7RJZq8EG79OW1jY5/BqYyuTl0ZbA?=
 =?us-ascii?Q?BfWX8czdtCFI3s+EUrpz5qW0VVeWhHpuHX8ZHuYZCheFyad6Wdi08SabBGqj?=
 =?us-ascii?Q?wS6PgVpiV2ruG4Da5/cp9eca9rrnVGcZnGnZxuxlwHtpUPwTx8mwAoOSD/Xk?=
 =?us-ascii?Q?oc6F8mxmfYeIFkXCSxxUdA8Mhy9S3jwowDICRz5jHb4MvN8AuhVuzhJygiLO?=
 =?us-ascii?Q?2nKFmkSgCHocyjtNIUYs9tqRFFGr36+dHUfYyhXOmgYs//9lQdb0xKB9xZP/?=
 =?us-ascii?Q?Zat6CdzDxaPJ3cgj4EvNR4ezHx3MD5R6NaGC+Ly1K2caowSCtJHD/xpVvXWP?=
 =?us-ascii?Q?YwLS80qup2yHu+C4JEaMjJSEf7xy5imnr5EiZ/a7PVDkJsOZcz1hlzszRZqM?=
 =?us-ascii?Q?XdniRWxDCQDosSrVAnm8RMA/fC445TPiPOk2YSd2bLGobPtV6KKL6MLvaiqI?=
 =?us-ascii?Q?tlnGk2FEKKbEyVvhsXsA/FyrY0hdyKMnhJiisobqoOXf8m8kn4FpYnoFEa0n?=
 =?us-ascii?Q?a5icUHETgTQgVc9S9Edm1yeqJJOLkRFkdgOW+JStVVBme5W0ZAgp0nquApqi?=
 =?us-ascii?Q?APfQ7raKHXDyOrRygHVShpzju4/NDPphpo76e/0r2UfzHsu4R3Jktm4Ffz3F?=
 =?us-ascii?Q?b9j3qMzdUYTX8b4+p4UiEbp1F8cgiREgHbNFFTjHeKzXZ1Yx/zHyvIIt5QiN?=
 =?us-ascii?Q?EasRuQ55yS8a8JHaoxzoLfRzsJrAxQUowzbIfGluCp9IZPA+aVXaOhLqhg8N?=
 =?us-ascii?Q?L8oBMf5dMv6zhN4tsCWcRYnKJNFM1Tgt7tCDrgK7UY32m3d5GhWK7EUhLlUZ?=
 =?us-ascii?Q?amM21xAzwrAsBfC2KtWWzeWll5ycDE1CMCGCkmUECuCY8EwB86f9eRE0wXjj?=
 =?us-ascii?Q?lF/KLBez+/ovaa6eSR/hoSdPLs+vjHtyJP0pan64x2Go57Sy7rCWRQbtwADN?=
 =?us-ascii?Q?3Fz0Vljvaeepiuc+U4SiTBBlEVk2CQFcGpi52enzKoX5+4NcsZWIdVXfYX0s?=
 =?us-ascii?Q?o3Vkcm2KnxcMA24=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:07.4080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4278ce01-ee0f-4e0e-7c3c-08dd5ff25b46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408

Use attack vector controls to determine if spectre_v2_user mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4d72c6dd66e8..e06dee765fd5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1517,7 +1517,7 @@ spectre_v2_parse_user_cmdline(void)
 	char arg[20];
 	int ret, i;
 
-	if (cpu_mitigations_off() || !IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
+	if (!IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
 		return SPECTRE_V2_USER_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
@@ -1560,6 +1560,13 @@ spectre_v2_user_select_mitigation(void)
 		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT;
 		break;
 	case SPECTRE_V2_USER_CMD_AUTO:
+		if (!should_mitigate_vuln(X86_BUG_SPECTRE_V2_USER))
+			return;
+		spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
+		if (smt_mitigations == SMT_MITIGATIONS_OFF)
+			return;
+		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
+		break;
 	case SPECTRE_V2_USER_CMD_PRCTL:
 		spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
 		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
-- 
2.34.1


