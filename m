Return-Path: <linux-kernel+bounces-554712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F9A59B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D4B16E97A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8724293B;
	Mon, 10 Mar 2025 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4DFxiI11"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB323F393
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624879; cv=fail; b=bVdpxSuMNCrVGFQL1hVsRkJyRcyoufKS3FVkzTMFJ37KlrIK87H+90nrz+WUKqYQF+YdsH5MfvhfnAT5zV99FYzevU6krA91Wz3LG1F4iQYF6TMhzjGfcNeXKcDQ+GWw2S6RE6yHypWd/GKfbLZbjWd/v6+j4ZTTA2XHkgHvKoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624879; c=relaxed/simple;
	bh=D4+iov18Atsqo3s8fwFa5sP1hZgZkLMgDkgNsT8zBzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKKLBbsPopUfcN62oxGhWIz/KXc4JSpvj8j4+vcim0CR//h85J3YLGUzWz+60efG/WCoDBHADYnbUxV2+cRasRKaNYJVsZ4Zi7dxU4/P128Z02waffP/QWSnooQnB25He/R/qRvTGBB2AkAfBDVyYB/Fhqk2Khq+YzSTUitFG84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4DFxiI11; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhsE8Mk+BBpFxHA9pZ9IAXZIAeNoZxQhI/i0FhezfAiOkniqf3nbta2QJQp+IhkQZ3e6cahEbsWug3d1YHaP9mzM6Uddd5SupyNnnuGaN1gU4xU/hOuWUx+6R9SJ7vRZfYXWuAhGYJcIaGk/8yLBoqr9ICnv8YSuUYwsofm5Lv6+j24a13T48RgY9DAuUmH5DTg/LbYuX1itUZwcDX8tQyFIdOco1RJsQUBB2Ehd6WI0p5grqwBUFPMDcKKtb3+cErdNOHnmNk7wL5CnN8V69i+e01ZaS9/8rNSrRbhlkSWupQuA9HeyTezuHmUkVwMSytOBEypSSUllKNXbi+iNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwp9ZnYpr+8a6uaCkQSCo0ARoiAD8iQmgNtSQTjtA8E=;
 b=R6aNm8wHcdBfjwsBQ3doqIan72AQFMV8L9qTiTMFvzvNW3mQ8vij1DL1i3eiWZxkOcr6BVsenB7x9ztLHMynFLYhjHhylsUjNnP3mbFhpK8MjwMovLI45rBNFvKEoZ18L8dfJjHHXL+iP3qe26N6Jv1m0cf1ZuFrh5N8mDo3QaG5UBjQQN3Y2vsblX5z3VQ2yxPGnkWqlz0GuSAaPSMIJUrv/n2se9DaDOvCl4gm0OC3/O9kjGbSeoJggHkW/k+XUVd4e4Vh6FpZD5XJmsDW24oyD5EU41HKzrkw0QYwvGflJwVjSdpY1u9DgQ8C26CNyKC91F33BhQSsppIVaYRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwp9ZnYpr+8a6uaCkQSCo0ARoiAD8iQmgNtSQTjtA8E=;
 b=4DFxiI11Z8wnx6B1InO68MiDNwiOovfe8dmcJ95edVil1Kg3shOVRKJ1NR5t9nG7yuoISSs8oiiTChI52YNeJ40NP2Umv4FUYmg3OrWXliA3cSKAGsz2GG35g4EYq5WHb7EcP30qg7Eg1/CTQlezj8dCXXOqHGvtOTlo8cvaCa4=
Received: from BL1PR13CA0081.namprd13.prod.outlook.com (2603:10b6:208:2b8::26)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:41:12 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::66) by BL1PR13CA0081.outlook.office365.com
 (2603:10b6:208:2b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.18 via Frontend Transport; Mon,
 10 Mar 2025 16:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:12 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:10 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 35/36] x86/bugs: Print enabled attack vectors
Date: Mon, 10 Mar 2025 11:40:22 -0500
Message-ID: <20250310164023.779191-36-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 36862c68-0ab2-4fa5-ca5e-08dd5ff25e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WYO7xOA0OZ7hqTwf1X7d47DD+627njCICcoX+Ph4sXpJX5AmrV7kAWHNi9ug?=
 =?us-ascii?Q?mHX/KIeSK98LjRhfPei1k+doSOcw341qxj6qrNsxpDfIsYrfQaoLxickokcq?=
 =?us-ascii?Q?bFa3ETYrg67I6Q+CNjzPMDj6uL0KWtdDHf6u60cWghGi6w9Qb5NJtcFvKV1W?=
 =?us-ascii?Q?33E5nZPvfWcBi5Vk0UU0bUTTG7/w7am30b4+CHZTDUaiytcDvjjEqGjloV7A?=
 =?us-ascii?Q?Z3Xwx+wOxuqRR5cM1Lj1omGWHddtPb7QtfJV+E0JgocynrMUlUK3IfXU3s7R?=
 =?us-ascii?Q?HIY5lc5CEctq9hvq7+V7Fuj5p02MA/KiK8SWjx1BL0Kqn4YtazUTd2DkTEqY?=
 =?us-ascii?Q?RTMreM/EQsYIRUh+Y7mjGUai/Kh/wggO35QQoufSBmFZo0K8VVSOTlUz/0dn?=
 =?us-ascii?Q?fgN97ZCCIdDXpwY6uUZQVREGlbseit+vIR+WGxaRNfLDNU8dl88eV4ujSoiN?=
 =?us-ascii?Q?RzPr6PVLRVFoxgl+IJn46EozqA5X0CyaLgCMspd2SQiuVNn+g8yW74KceGpB?=
 =?us-ascii?Q?bQkfZlObD65OtDaU53INFMaQczfiSSVzhaFhV2NrihiOML0GBFZtHExCNK+q?=
 =?us-ascii?Q?QWN77km7+BoCTOCsOybyZm+UY+PF6tUILl8g3l5udQwgb2z4RhQODtkNhg1s?=
 =?us-ascii?Q?qW7RfUVsMyEEOYK4N0DDCfbKF+eCnN/prq8vin7I5Nl8t/vJ17YziqZ7BGOl?=
 =?us-ascii?Q?xGcLQv2dvnBR0LEcUcBe823MjrUGDf5hOIjlre9ZG1MJtwGNktSOabSH3/zj?=
 =?us-ascii?Q?iw9r5iZ6tg5oEq5rRZvNgQeJXiLl/kgGjBWBvgIa4GCBwqT676LUtV9B+bM1?=
 =?us-ascii?Q?5wqyj6/hX9gmf2hNs8sCDE2BzavVcZiq2trQTxV1Byz5r5SQDOnjjofHLcID?=
 =?us-ascii?Q?LBlBNwgeuOa0ZlBoqU4kqH4kxsQc8i/u6Xd/8pIE71YIiNcu26YniE0GS/re?=
 =?us-ascii?Q?cfViDiFwvDkg51/Tu1rAjg2Gal9cHOxYI9PX6ryvJTG8Bc39KDC+ismYt/7D?=
 =?us-ascii?Q?aVPvSf5ZXRm61iq24W3HJSR8ADh5OwSbtMBPFH8oyq4eYtvGuze4q8gwMqjd?=
 =?us-ascii?Q?BCxNarW/JMuy/g+Y6Qtf0/qOdEvPugGUOuKKIx6g4lk/wUrJ154NEWS8h3GD?=
 =?us-ascii?Q?4lsFCDWOvo9LjtSra6ygCiX6nHByPxoUmZgru5mbegXzMzHmIx9X317358o+?=
 =?us-ascii?Q?KvXBVS+mCjit1CbkD27POqVD+pdQyMYfvVhdvrbGSIuNmaRRv4n1oDQHNAJ2?=
 =?us-ascii?Q?A665C3qHe2aFYP6sAZ4p1wAZSJNHD6Z0c1uSNadERw4Kft2a2bQQBxoAZNwo?=
 =?us-ascii?Q?2QiiPP6hSPm7N2rqP7WxeUiGEud8coStCC52nNoZTyn9kYh7aW+ELEFYZ+98?=
 =?us-ascii?Q?8jkoUwLiABJiZ5HwloTy/HTB/+RG36gi1d4XL0DLua6/3ThB0pm2LiDXUq4B?=
 =?us-ascii?Q?JSRQ9udsQfDgjOmkuieMJgMn6IRLiNQA2V3grG00rHNliP1xipI/+gHHuAOK?=
 =?us-ascii?Q?QCm2M3H3FwYdb1A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:12.2727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36862c68-0ab2-4fa5-ca5e-08dd5ff25e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

Print the status of enabled attack vectors and SMT mitigation status in the
boot log for easier reporting and debugging.  This information will also be
available through sysfs.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4e1fc1468870..7ee9b8bf05e5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -173,6 +173,34 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 DEFINE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 EXPORT_SYMBOL_GPL(mmio_stale_data_clear);
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"mitigations: " fmt
+
+static void __init cpu_print_attack_vectors(void)
+{
+	pr_info("Enabled attack vectors: ");
+	if (cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL))
+		pr_cont("user_kernel, ");
+	if (cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER))
+		pr_cont("user_user, ");
+	if (cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST))
+		pr_cont("guest_host, ");
+	if (cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST))
+		pr_cont("guest_guest, ");
+
+	pr_cont("SMT mitigations: ");
+	switch (smt_mitigations) {
+	case SMT_MITIGATIONS_OFF:
+		pr_cont("off\n");
+		break;
+	case SMT_MITIGATIONS_AUTO:
+		pr_cont("auto\n");
+		break;
+	case SMT_MITIGATIONS_ON:
+		pr_cont("on\n");
+	}
+}
+
 void __init cpu_select_mitigations(void)
 {
 	/*
@@ -193,6 +221,8 @@ void __init cpu_select_mitigations(void)
 
 	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
+	cpu_print_attack_vectors();
+
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
-- 
2.34.1


