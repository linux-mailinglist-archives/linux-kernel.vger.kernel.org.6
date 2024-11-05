Return-Path: <linux-kernel+bounces-397221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537A69BD7FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BC12835EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F702194A1;
	Tue,  5 Nov 2024 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H71AAmtk"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F342170A7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843748; cv=fail; b=AhZ1yBXk2rti08n8r2XJ31BjzpFFNgnnlcSm6MSlxkAl/gyjTmkV3Dt5TduxWRRe7DfGrWZpm+0nzOjoDeImq2U1ARgam6pJYXIKSXa5REWltrfZHEmDSLXKnNfVEr1oHteMBpLmvg1i3zrb+IWdwRNhTQe0nqPUNm+JXvSe2i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843748; c=relaxed/simple;
	bh=pj0NHsjByCKYGkaOjxEVOlFpe2mrmL/tmrB2u9EA18c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbiCYVPHunEJs1dggkyEywkZWMO3w1wIJoape8TZLD0us2GZqJi4Uyx5mA/kYusMvRrL2xX0D5nG6M33ISx8Keg90jN/xutuFDEnZqIAKbcmoEDXuNQJGZpn0XCpRsUmkKHvztsb83/POMqliZy7yRCoS45/n0x09t5UChmkQRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H71AAmtk; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr//kdsXW3B8G2FpjiwiOhcDmT3eR/ZSLLQizSUrtqkxBSv1Gr03YR7s6RBB88UH7pfMHxTjMKut5/DxN2RtBRxSXJFdeKIr5cDKeS42nRfk/e7x/xBrmUlX5oEbjmpKRwQhbbZybsf8gqXCVYrhW6EfAlDhSjJ4i/onfscMV2CTV+TyhWNizjUhXLC2j1lvZ+s7ys8PXtCSoGx9uzcC55bLgDB7zgqCwmrXb5am654JrHPUP0Czc9etQ81hLa9TZlR10fTl9vLIPe+ILnnHi7t9DHBfHLa7E2YlMjKozkl3ANNDYOLfg/JATDL9R5V8WXlGzFaPt0yy2cn0GazRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNDLcaUjatlfFXjm+ZEJKmYY6eFVM9jCktSdTUI8ZQg=;
 b=Hx1SxDGZ2Q9mRbZWsy1StyrvIGoBZSoRORYUbBJ/ojNfqBULuSF0jVVOIyAZXWW8JPInnaz1FINJxkAzonshepNwZFwrIzRLUtbZP2Q2rXrxT8oRmiVLwAwvq2+ZMY4I38YWuYaojB3RT3QtsyJTUfnJwEKov+twyQpL4W2JdDsVpPcgYY6DF3rTzogadLC/0txRu+rdQvpRBMmi4qGQWWmJ2rEzedwZaJBDQUYASmqpbSGG5W8wdFc442t6ZOFnngbB4YCR66wwFLpnfpdus2Ufg08CaGiXu1oAahcmIVLXAej72v7+Q1sQZJvo0Qn7cuJczpshZIAeUZvFdKwxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNDLcaUjatlfFXjm+ZEJKmYY6eFVM9jCktSdTUI8ZQg=;
 b=H71AAmtk4QR05i3NH4QNgGx79ZPKEbPly63wEda8O5j2fj3+A1WRHT0zS+qKytf2bg3RR1ZbTLUMKn5LDC7TKU9zvRuTJZWUzxwcM6oFhNIS4CGGI/XjyJPcjpgty4gc+vx0MVLFN989TnNy0cxvblQ6i1RD106q5rUJg5roJMc=
Received: from BL1PR13CA0373.namprd13.prod.outlook.com (2603:10b6:208:2c0::18)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 21:55:43 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::85) by BL1PR13CA0373.outlook.office365.com
 (2603:10b6:208:2c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:42 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:38 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 35/35] x86/pti: Add attack vector controls for pti
Date: Tue, 5 Nov 2024 15:54:55 -0600
Message-ID: <20241105215455.359471-36-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1055d0-bdae-498e-5dad-08dcfde4983c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FuHqkH8wTNHxD7gxTcPjsCeP9Y5Nt3OM3J2Zp/xvOUZDzYDbwPTInJreo0AL?=
 =?us-ascii?Q?AKDDdHJ1lbzv3258ZA6WBgw9n719FuIuUHb2jSjIY7fpEp+4ugqSOgxlUmhk?=
 =?us-ascii?Q?02FE2iro9hrSr/kHWtMXsoUhYJ483GnFk3vp6bG3loKnSX1g7guv324xnQ6q?=
 =?us-ascii?Q?blYaCraewIQ0TOuX4Npu3Hu5saEPeESRDpL42iKc/2P70jU6kWe2PIe1EIBe?=
 =?us-ascii?Q?lfyvM43Eyxw3XiB51GK+CE4TbbvPu482ahjSGkWYoMtfstjtwgs+6L+HdkM3?=
 =?us-ascii?Q?5xKJsYptBk59oobelOpeFlA2Ll8ibluqKiNM6gnMCNGdggYiFL1P9Ki9lq0c?=
 =?us-ascii?Q?DuPMzfNajZkTWcNIuwZxoSTA48m3y4bZV9t/4ouCL3rY7Hlbo5Azb+vz0tWw?=
 =?us-ascii?Q?QdnFvUW0dUHA2GplAT0wdSGrpXwSCykrOJsvSGUTD2UguBvHVoqR2zmO7Gc0?=
 =?us-ascii?Q?Gl7oSP2ZmFVeA/5DQ7nP3rVSP0+6QcJndObta1H4wtd/qrJXj27NXOqj7PVg?=
 =?us-ascii?Q?Ww34+PPVux10d19uby3CwSY3DEDiCp0iqCeHq+ESc+J1bDhyNVkSU3cxkr/e?=
 =?us-ascii?Q?DInNc76owZIxmnJ+4FOYeIoId95de9vkTxOwFBcCtwraGwexXzoyVWEtjyy0?=
 =?us-ascii?Q?/fasg8Ie2pZLmmdLtYuKh8uUZSbXkteqfj5biNd0NDz3xjbs3EJpr9YvYfV/?=
 =?us-ascii?Q?e3Ed/lFD6m7nCJcwQ3y9hyS3kJGBGbBVDZoWdR0vrPioJGXfMbrUOfgAWHe3?=
 =?us-ascii?Q?TVGJelbOsWA7QuqJVhvnwpUd2FrVGvFOzPz12PO+KqQ8ojEQSXaIp9dr7njb?=
 =?us-ascii?Q?Sy2O7qiwLYhluSHffEK3T8CNxWhtUkdqp+rvCZzEimwCkZebDnMQicftTXaV?=
 =?us-ascii?Q?RcEsv9Vg2Z0IjLzHXNp7ePaGlXkV5LLvnkKxIrQDzv7ke9XojHCNeW3iyQn8?=
 =?us-ascii?Q?2jNVr+P6HM+907NDgNGSZ//SDJfcOY3unNjvBaE4RfbIvJ+8csGq2sZHb6Eq?=
 =?us-ascii?Q?9Zzwarmz3qVd/TykaYxNEOZ+gPFBgKqGf49GCpk2qrnlHl4yneUttaVPkqNj?=
 =?us-ascii?Q?w/B74Nrivh40Qin48PN/71Px2dzvfPZIx0BR1W6T9DXbkXzFhZHNaYqShVOs?=
 =?us-ascii?Q?jp0wEk2uDRuIR58CKcl8+3mrJ3CY/XXZpiZKeVpvtwUibarhnJQrYGZX5RDO?=
 =?us-ascii?Q?ok1/0xo9PJewoJ/Ln7J1K00VsLqDtxEA46vE/UfX3C9JI4jPAIubrJBUx4hS?=
 =?us-ascii?Q?gZzf5GzUEC0ckPeYAjn5tpfrJZ1+YiGjWXzM4vE6jfWEk8OJbrdZwoCzpQZJ?=
 =?us-ascii?Q?o+KTfjp3X6midGnJEj0SZBep2m0i/pTAM3+vIoVNezVx6rV9SJriVYRP9p3W?=
 =?us-ascii?Q?Igjb/5/XLhExpTonnGJTIVBELAJTL7Ns1OBsnz4SEOvnS8jg4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:42.7450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1055d0-bdae-498e-5dad-08dcfde4983c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843

Disable PTI mitigation if user->kernel attack vector mitigations are
disabled.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/mm/pti.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 851ec8f1363a..9e1ed3df04e8 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -94,7 +94,8 @@ void __init pti_check_boottime_disable(void)
 	if (pti_mode == PTI_FORCE_ON)
 		pti_print_if_secure("force enabled on command line.");
 
-	if (pti_mode == PTI_AUTO && !boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
+	if (pti_mode == PTI_AUTO && (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN) ||
+				     !cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL)))
 		return;
 
 	setup_force_cpu_cap(X86_FEATURE_PTI);
-- 
2.34.1


