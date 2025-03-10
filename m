Return-Path: <linux-kernel+bounces-554686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA7A59B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1171889D80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1294235BF4;
	Mon, 10 Mar 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KEYO7iVy"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336952343C2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624850; cv=fail; b=SZ3uq8cxgwhn914GSOV/NrC92ds3DfvUtSEJj/3V1Y90dd5rWcuz1JgevzmNuf3NrUsfI3WLUA3nS9HmINha/LRM9vSWbMLZVvM6Zk0HOGOQICQ9Eq3lPmE1Xtcqp4teOlK7uDssu5i2bkZT9svbh18y5RjYT3H5eU2mztHmt+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624850; c=relaxed/simple;
	bh=Q+Yue1gMn7wcxp2wKsjTdhdw2V7/pSHWVRoZMTEwp2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqx3CbkgFrow4ixUDkFG9xMN4KruvQ5s/JGsSq44xyYyCFN3vOHiyJh0BaUFhCa1Y9U21MSMnTcZNwFznzo0pmZapHzOxtTMh4kSYMtWSxjYa0T8lJgQmkoWV7qXJYb8/nd+M2SIwggfwtiP52xCTZ/AW0IBRVR5e84qBT7xRQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KEYO7iVy; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3r2C+E5L7VTEpDPC4WsZ51Wo3Z4Cq06TeLP6D223z+14NFx88RGO0vXMql1lSD3Z8HFPjfdZw5/7ORzHYNkw6ejxoJuwZqWe7O8GI8tIbSvPRAtBPLI0mJCKIrErTXqgJgNejAaLXn7oUnBlbh4hqnpyKlq1qHjTI3WI0X9SwTc3qbFGV7JP8mj3cu9RPdeey5hmd+AhXPawPfiFDcdkC+jIfArlBBBxbha7ZBZwr7jgRHGB/gYVmpQ9QZYI/zC5F9SauohQiJSl58J3Uc1TTyvCkQxGBk+vMbZ/OoCktDgnssDhz8sRFJ8whl9rlRRJiGDXWn1iGPUWzZtueHzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP71tFKdROMV0ocq+5HT2/BV53oiBNwi+8LaIIY1zaU=;
 b=IqBPEbhr9TPrUUImIHTRgqv0Ns8eDRM8ZplqVCjkz4eM+heIQ+PzjMmipLMfN1H0NGt41aOkQxwoMMPooiEtFPwQijie/43SlMQjgyX3uodOQVddBdtLRmpAWKYHUKI8hpGWBeytLWdbxOAGxmxvZpRmP2jq6zvAEHHcL+4L5icSeCqHpNlrWZnnQyQF18Oi9OgtR4jT9QwTrwDaEZbkawH+/KZIgrfhjfl5bkbWoWHudoGMxSRTIbP+daxjw7mA20Xhg2vTqnQpkBf/Kl+oW8j6O2szWO0HfHrre9RjYOcWXCBSVWcKE42hQbtYcJnE0Fj/NrxH6qdM+ZKaWP/DZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP71tFKdROMV0ocq+5HT2/BV53oiBNwi+8LaIIY1zaU=;
 b=KEYO7iVyFyk/s36nEsKQ0zjBNK1QC8nmvV04vkvLPa5DmCPsQhG2LqDgJvAz9xKwVNJYhCTlNVnbZP14yUW55YK1VE1Yvr+nT48sesAcglmdFikxJWKTzicZ7ckfb0JkOU5O2oVIsZJpMK8zl8dcWmjFaVx5rUK6bTLRuNu6hUk=
Received: from BN9PR03CA0732.namprd03.prod.outlook.com (2603:10b6:408:110::17)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:40:43 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::d7) by BN9PR03CA0732.outlook.office365.com
 (2603:10b6:408:110::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:43 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:40 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 08/36] x86/bugs: Restructure spectre_v1 mitigation
Date: Mon, 10 Mar 2025 11:39:55 -0500
Message-ID: <20250310164023.779191-9-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b565add-fb46-45f2-61c1-08dd5ff24cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mgdGH+nBg0esVEqSuKEO6pC4poAWpQo6vmLLay3Vm3xBlZCBVxbxJith90ZQ?=
 =?us-ascii?Q?VWtHRIHxRj6KzNUG4Lobl36dKgAThWryOkYpSr21ws4IvS/T3PSvAse7lSBG?=
 =?us-ascii?Q?6UsqUE+uRAC/05gm4Sz029VWxDUz0d0aDwuyDjjVnUYucx4nM7W57ipl+SHk?=
 =?us-ascii?Q?+Xx93iVLf5LJDzNcI+nG4ar6ylshomMoklkk2+DGg++XhL3JQsFvlUJ/cTfX?=
 =?us-ascii?Q?0Bx6K+PbFp9i/AGzHnW1Zln0lqEntFLYq5K6wh8IBYrlCpBPfdXfZY6AVMl7?=
 =?us-ascii?Q?DEA4Wz3rn/74IISkF98+mzRAG63O1kwEz/tRdphD0eNhlkGD7Ucx88YmJgsM?=
 =?us-ascii?Q?ll7a3nYnQ/MsiEWNcmEn6t7hJ2L2M57WudGzDgEggDB/6zcyQDg96txXSMMj?=
 =?us-ascii?Q?McRouLyx4GF84qcW3PkZrNeLd6gDT0ldeqaCYNY6mhKmnJbMY7gWELgi+MSS?=
 =?us-ascii?Q?TvE7/YOJ6AQFQnXtlQWFAdbvRSVJGxR0u1QznbjAmhMrhgNux0hNek2GIr2D?=
 =?us-ascii?Q?gtx4P5b+GK/FyGyDONdKKIM4pQ+GQeMY3cglGxsJjhVFsExWuhx8PJilRasJ?=
 =?us-ascii?Q?bVOu44dB9/VpSj9Lq7Tr7ikrLO2qD06KUFkOJTIbB7JE99+vGHPID45Xi0bT?=
 =?us-ascii?Q?0L6V5PaNwMofFYy3g+6LFyhZnXygwTGzQW/vj+4HjpYDPMI2D986mYC5Ck+b?=
 =?us-ascii?Q?RZTJxxW5X4AwggRSboEzGyZOq3vq22cFqShhXQ5Je/lVUv8qK8FUNc3yvTLK?=
 =?us-ascii?Q?6t74LC6TWCz5lKad9LzhnVCl2wG34J42nOYAXFAd8qBW25joXpu7ReWHON3X?=
 =?us-ascii?Q?kIMsxWyAGCqr2CJJi+ZQMcJo/AKa6KeGoU64UeC+xWbaISfph35u/Z3DeBG2?=
 =?us-ascii?Q?rzGLm20UB402uOEq6Z78WMRF70SIljZPURgVKXazMb/hU9OCPqYFW/YvlG5/?=
 =?us-ascii?Q?mtdEzLY+9Z7ModXuwiJCLYu2chEnyUmdzWJdp4G3j5SPuAQurXQgduXoCaQ8?=
 =?us-ascii?Q?v6tTUepKq8bYz1/pUwHW50WRiQjLzX3QLDdBC9e7HLCUJZ4BteSgdz7AQg5R?=
 =?us-ascii?Q?ifXtKrwJJWFXxgaW0BJ4065lKCnsVfIszHWmSH6Pvjg1uCYkFeeC2GKj9qDc?=
 =?us-ascii?Q?Y1tMrbzmHN5/gS98YeMBVUX2uc/GOZpS78mNtnq8fgSVnMv7yzq4NMfgn+Td?=
 =?us-ascii?Q?YA9E1xqUEUbpXYL+7HRQWzXyL6JPPBa6FnrmNBcou1P0QfcMgerUKc87WDPn?=
 =?us-ascii?Q?YChge8moaIkem3TvFhaPS7cQqW8zPEuEv0eDPB0RKHA1i1d6YL1SyMAJDE8U?=
 =?us-ascii?Q?yMRtP7Ft9dMqGDVvEOWWTVdvvLacx1aQnzRbjN7YLisX4ZrKgoSH9rdFeGVR?=
 =?us-ascii?Q?qrk2oG7MxyBI6ZUJAE7eYAhM8MNZRdD8LqhxtYMXE70fcmkKvmoZZkgINYeX?=
 =?us-ascii?Q?/y9Zjsy/3kQY9Ki4szb7p79457O0RIZFleF0TQGJcU7atTJOU7EevlZiU8SZ?=
 =?us-ascii?Q?S9AJhP2V23mTODg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:43.1917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b565add-fb46-45f2-61c1-08dd5ff24cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

Restructure spectre_v1 to use select/apply functions to create
consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ee7a8009a188..de120ecb752d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -54,6 +54,7 @@
  */
 
 static void __init spectre_v1_select_mitigation(void);
+static void __init spectre_v1_apply_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
 static void __init retbleed_select_mitigation(void);
 static void __init spectre_v2_user_select_mitigation(void);
@@ -220,6 +221,7 @@ void __init cpu_select_mitigations(void)
 	mmio_update_mitigation();
 	rfds_update_mitigation();
 
+	spectre_v1_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -1008,10 +1010,14 @@ static bool smap_works_speculatively(void)
 
 static void __init spectre_v1_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
+}
+
+static void __init spectre_v1_apply_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
 		return;
-	}
 
 	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_AUTO) {
 		/*
-- 
2.34.1


