Return-Path: <linux-kernel+bounces-397199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EE39BD7E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6A4B21E1F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0750216427;
	Tue,  5 Nov 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g76RmzBv"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06575216A17
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843734; cv=fail; b=LksylsL/g/SFecVQSBTVPJeh/O3q1Nbgrt1lzd2Cc2KqwgtF4gerv3my/h8fH1k3nYuVvXY0PsnKpS1eVsmiATv42EVJpT/DaYB7fVHsBOn+vGuLRsyUIH9F9BPyMSf2FmySayY1fJh30yhZOWOUINvbOV3lkFmLvfkdE4PpkEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843734; c=relaxed/simple;
	bh=vbSqaCqCArdUUKDaEIywJgEH2JkkCvjq4ZTdvD7lh/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnqCmcIrifuGrd0wqI9IPQ6NjDdYjBfCe+REIH/BSwmxbrXBbD7VzGUF4cwu5aXgqGjjwsJKtv9KC7SkpLs49EbTROLmVHwkE91RZVvFrZDC/EiblgJBEmwpm9tgncBaC3eG1NGW1/V6SLByElGpbJsy5iirEAOWF3u/DlVjIOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g76RmzBv; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTR9fWagHrgo5ShfJ00tW0+bgIqYwcJJ5F5N6xSkvIUH0tmDeZOTJSlegMAIBW76GUCzYt4bj29E0gWyIxztugXWgIVgWjKZjzcz+Je3m7pnKNuR2dhVKSkfrwOVkHBrWHfzMcSSV3Bg/vDgWKn3GMfH4P1vL+3VjOf90dMzaBq7DC21YUxztR19OY3dKmxhnwbZBHfWpp8RdiCyRYmjItr3D8Cn6XBkoVTJ0j9Ngi1/KVMTcaSMW5RlBPDm8EqbU735SQRv/TGLFXGqzn24F+EbnpMzfplbq6AZ0fUIOzPGfVVvnoq+zy7KsHLV/fyRZSkwdWBtYJgUbL1RXTgEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZGW8OmzQetmyOCoWtJbUipRiLjCplyIVdavaAnPWcU=;
 b=BBlTRPy8meeqO2K4ry/akIZ1SIoPdXtj1fy5LimJSFoF7J4DB/UXOuFlkbHux/WNS1MdT0iaELXNc4v6+qcm/BdwXbbkHBIIfHiCGjvXzwXnmxbg8zJ4YalKr57YktDqdNt0zwL0IROQquVC7pFSdPPabNgMqnqC3Pgp35QP2mj4nHL8TQj+W8V47KOhhpU5g1n+3XQ3/Ws5c+fO1u8GnfsoXqJsuETadRmhQ6R8cw4fncfIXExQ2t3Ag8X8FjRn2n1k3BMFR17SPWNhoo8XO/HvzVMzPdByfiStvrZgjwDivNQA4Q4RC565Q6dPL2ZowI0+fWRf9JfOWiPEKw5qMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZGW8OmzQetmyOCoWtJbUipRiLjCplyIVdavaAnPWcU=;
 b=g76RmzBvRjkLoy1NzmXA97MeiDaXVuVDPQz437d1pNEa3o0m7s5ZJKKHdqMUEYD9WB9PMLCeTbPUDGR0bI6YlCAbAKtTKG1ZYR5eVH/fuunJIv98lfv7hTnl2iR3qeQ0HDfMS9bizqPs1l1p+pmdPBswIUJjpS0GnhGrngi5uW4=
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:30 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::d6) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:29 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:26 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/35] x86/bugs: Restructure spectre_v1 mitigation
Date: Tue, 5 Nov 2024 15:54:31 -0600
Message-ID: <20241105215455.359471-12-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6bbe1a-8ee3-4bea-ea7b-08dcfde49035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fSfQxxGQabbLpU28WpdYD4lsZ+zzd1DNVit1uIFxy7oBxez+aFVLJYflTGnF?=
 =?us-ascii?Q?DUwR2MqFa6fF3IV8ydnppE2hSyb/GVvSpMue8uIlOMh0yoS+cjKWImRjIvxe?=
 =?us-ascii?Q?C6OxcFzFUq3RPXo+NfsdnAzM/G5DxJ/ajurD2cAYZqjkbs/xJNPUbJjBAVh5?=
 =?us-ascii?Q?N+rQNK4NBmx0/INFzsCMoH1fOeNpX10ukEy3kNh5/vEkaeNE7WsZdUaS/L0m?=
 =?us-ascii?Q?RBItqivkpCNfW/n02dD3d7GvUuSkL1Kd+dm7AnPB0ZIdHGNlijfDu6pBcn4/?=
 =?us-ascii?Q?srnU/yaH6RywxNd7zWmKLR4umhYhNoR0ie7DIyqBbfe1wui7Et0UIZ1H3WTd?=
 =?us-ascii?Q?4OzgZxOnwFABZCx0gS5thbOjv1rrlqdY2vUT6pslrEZk+82hsCB2SMueuwMf?=
 =?us-ascii?Q?e28OsZhfADursV3nhrjK6jFBi7UNmMDOmHY4fOaBAqCUwQaeeVSm4+OF7fKM?=
 =?us-ascii?Q?siGmWSPgLJj6tTv9EN6QPOv/qSffc9Z19JD/CpjwbG0RoIWKnqYyHmsB4gDF?=
 =?us-ascii?Q?U1a+ONsAXwNFj1MXY2HlhWBjmD/7FGHcWXan55RbB1hpIGYEPXsG1KU/sJEp?=
 =?us-ascii?Q?9o5RkQnMxYuA8sGDu/pZ0ViTPIQmoqiW26KpzdC4ur0CfOEDDtP3HhmYZ1k0?=
 =?us-ascii?Q?s9Bhk4xtVwHrSH+Rt6TK/7gujmLJ8l04v6jrhqk0BVlxvgTwEScfXPjXmmGF?=
 =?us-ascii?Q?G78HmftoaKdJZjDX8JVDx6AR1Tqgqmt+tlEC3iuRlvi7tgJjAgV0RFu0XO4A?=
 =?us-ascii?Q?wpPY++taXBHluEbXrYzN8why1+kt2xUTPv6+MXCKW82/fjHsu2VWLYemf/K+?=
 =?us-ascii?Q?GWPAFUb0VZwH/g4tNQLN1P8pQAD2d+/O3lha4s/0AfYRvhCQhf+IoC1Ff/+k?=
 =?us-ascii?Q?6P2769YOZnsrQGH2VfPf6aYfaohA4z9ahnVFzlIKc1Ae3trfhMRISXDgYPxa?=
 =?us-ascii?Q?+bWBAWFOFEM25tZIodvY6NxYuW6RfoYclt5uvqSEURCBNnn5HUmrW4aNfic7?=
 =?us-ascii?Q?fuq8A0eXzvbGHA01pMUNXn/S8Z+cMn0xJZFQLA6Z7RWOEPbw3RdFngW0w+6g?=
 =?us-ascii?Q?foIDsJvRnmuFqc/2GBKXalLHAmj6YBgOg8HXgbvOh7yiAWvVqO0ZAJwDV22w?=
 =?us-ascii?Q?59kEH+MUL2PIywpAaRqihyt6zXu7o7c6J4+vYaqBL7uGrkKqA4ZQXAw7+nOQ?=
 =?us-ascii?Q?7CUPHHgQxJxBpfdbblvBppMNfWw7/XfxFB11j/4Auwa8tEfCeoxbUapiGVBn?=
 =?us-ascii?Q?OZwG+DLVwQiiOH8zU8cTBswX9j8Ox6uFLXUOMs49Yctda+3NSWmlnTSu0+SS?=
 =?us-ascii?Q?ATD6Cernhx9njo+B0bO09QlIrsszFgl3pvyggqvjzyTK3z/p7ClR5/pgk5H+?=
 =?us-ascii?Q?9HHg2VwVpZJZ2rZieazQ3rRhcQ++rqIxQbVJkH0FAUs68mJClQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:29.2966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6bbe1a-8ee3-4bea-ea7b-08dcfde49035
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

Restructure spectre_v1 to use select/apply functions to create
consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 37056bdd3a9b..ea50c77ccb70 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -54,6 +54,7 @@
  */
 
 static void __init spectre_v1_select_mitigation(void);
+static void __init spectre_v1_apply_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
 static void __init retbleed_select_mitigation(void);
 static void __init spectre_v2_user_select_mitigation(void);
@@ -216,6 +217,7 @@ void __init cpu_select_mitigations(void)
 	mmio_update_mitigation();
 	rfds_update_mitigation();
 
+	spectre_v1_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -989,10 +991,14 @@ static bool smap_works_speculatively(void)
 
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


