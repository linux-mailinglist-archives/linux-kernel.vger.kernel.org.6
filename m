Return-Path: <linux-kernel+bounces-554699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E00FA59B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2251518825C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CC123BF93;
	Mon, 10 Mar 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ofCCMVu4"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4923A588
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624867; cv=fail; b=fIFqPUGGdJxPBBIM+xkTcE2oSp4v20f+1Kk1V4t23Islfkq64T4XATAmTZ1V21H78j4rFKfYNyAR9rAwCFT03ZiK67a9JzicDkxJA1HYbVm0ZVuRzQIAM1IdwBxxVSxOZCry1l6GhGv7Zw3UNGYwzH8ic0PPte6MQIvqfD86nsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624867; c=relaxed/simple;
	bh=Y+FmxaDm2QGNNfX8AY4gVfZMs17B+IxDp6QcTMtY0UI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRl/orG2ZYRjYWQ2IbhDkvahNuKylxUjAhwURY5WDLxImMBjZaf1XcqBXjs1jice2eC3SfFJKO1SpIDg4EenPY0Cuob3Q4gysxJ/BGuw4UPb3zzsnawmPlDiQCktIhciYx2z8BdLuZIXeJ9WL2J3c6dJM04Z6wbgbqsi9OfN+os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ofCCMVu4; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e48TpdY+dRZ2VEf/5ZORkTmBlyE1piJjZY9GK9Wfhlf/iy/kjxMJWN8JoSpfFREEd4jGWHZgSpmkvuETUuheJ3zJ5hqcHnU+2Bi5We+3S9WTw6iLyWOrdmu34eOeuY4VVRfHtn1NeCBQxVGRxOO/sp6KFGd+VyovfvZDtm61iEcEAGInA5tIXrI0BbbV1Kv6GvaIwkRwna1hODuxqiADzCP9Zp1aajo+OhCzXJWA6ia9dcTftubo8NLIKGxPODemuWLBcEa5F/tTSvVsRSO8Liy77GvN54iuDXrBDWx6UonlNmA0Z383FbnMjPrE9CyjvNssArZxDGlftFkie5wMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQDd0K7AHI+w3sAzw6GP8dOWrlxAKW73yxzj4TV9WqE=;
 b=rpPHMkdQpPvL5urJ8+/gQ6aMfGNY5ZRgui1D4nOfwtrRU/b7gJPeU0jdUUMtJn8TlXt3zboEeJjf0HA8e45HMvLwSO5eRhDR5jUqHwlNELqzhDBAKy+kZYux2h6uQyFrmEA3KvZBv3UkbaFEGZ87uEt3BcxsNVfuZx1VUP+bYX0r8gAK77olPOIHQQ0AyJ72HoQMAo9g46PM78iqQ6YRekPdyRNZ5O1RYF15/01f/210UiPUfTtdc6OWBzadvHvXIq13Vy9nTDOaQ8ZLsgf8a4mst7cr9tGN//Q9lSQl695oZt7XqW8xZiQYQ3kIHwsBrUFL+IQcrBEhO7QQ+PchKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQDd0K7AHI+w3sAzw6GP8dOWrlxAKW73yxzj4TV9WqE=;
 b=ofCCMVu4iqsDChtvDU5mlNOtojnF+DZ2wzEsEKk+pAjSwfe8lS0xP0jwH7eWOA7loQO0h2PbVUpekiyRUGj8o+5pvjzQ6WQNFsSJS3siEIUFEwglRoClpnOPR3v0PfiZA/AdoIFK46DPkP6+Uv8cLrA43a7jga3uxFYa1htiOFI=
Received: from BN9PR03CA0081.namprd03.prod.outlook.com (2603:10b6:408:fc::26)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:57 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::40) by BN9PR03CA0081.outlook.office365.com
 (2603:10b6:408:fc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:56 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:53 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 19/36] x86/Kconfig: Arch attack vector support
Date: Mon, 10 Mar 2025 11:40:06 -0500
Message-ID: <20250310164023.779191-20-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6ec2b5-c083-480e-d791-08dd5ff2550d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XPpx9G+SX6C0vjVa2bA/2zLhcMiEszxz7VQiiwowVaC5iFkm4HozscdTZFps?=
 =?us-ascii?Q?ZwcpZDwtjKJkX9sP/sTkRC9ZY7SfyZeItiRQ1gen4gKYcyFLtxOf2kYQ76Z8?=
 =?us-ascii?Q?UltyeGvd/SiGPhlczv7tS5+Qs0n79ks2L7ZXddR81awGfpZtMl4HqJTNn8Hq?=
 =?us-ascii?Q?+obrFO4PuFxfLoU9AJu/t0a9dYVx15ik3op7dTNsAP7LdST1YuHPp5yvv774?=
 =?us-ascii?Q?C+RsSj1dbZt4cwwK39L7sWwv9ww7z+wqp3/YU4rfTEZOHlo7sT+/THOYqro4?=
 =?us-ascii?Q?EN/uHMVV3VhivcurMqqwYxPjdypHkWs6vniHIMHq4oyU+elu2I3uKjpnusty?=
 =?us-ascii?Q?e8GrQGMK7ZKfOtVptr0LdWlsYfUIUM0fK9YC2LEr3gFgH5ygY+73HaxsVseo?=
 =?us-ascii?Q?4M5beOw7QUQfLFluMUpeKETMaRU2WRoTSff8fELuN2Ko+KHa0i36/XfvHYWp?=
 =?us-ascii?Q?9ZhaSiaZVbRuI41+Jq0lb+3uHT/2ObdRWjIdv27CaB0vCpiiJzqttbRhrWAw?=
 =?us-ascii?Q?n6jtd8fmfdh+MaZkOE7jUQ9non2Y9Jgd2+xTFbcdSiG1/Ak2hHz7HpjKjPts?=
 =?us-ascii?Q?kPeIlLNFRzd85K9ClXrQtkN6dLsRXWcEE7oio0gnbCwQvbxIPG1FvXfShMXU?=
 =?us-ascii?Q?Kkl0i9qHgBKsCd6xYr8PEOYGouYlIG7Qs8zBP/XAuPg31XzYsjBcIqASrGCE?=
 =?us-ascii?Q?KwEexlQFusCOAUT4OQZrColetGD4XTg7ijg4i3WhaHfOO03AjdCZUhEOh1HD?=
 =?us-ascii?Q?0iwBoaUKhBeragLUbY/8b1uPPXa8CXRmWcaMqdva2UHlfouzZlBPcsyvOzKe?=
 =?us-ascii?Q?OxEZknnaeZc4xzJgRV1KVjmp0uiX9Rbtkr/AtySXh5Or1BdpzUmdAb245/AY?=
 =?us-ascii?Q?81MBthtu94T6RKeVSW25ZxLtTdWHlxefK4/oUY8Hd3Cg+k+eu4ThgVv/n1n8?=
 =?us-ascii?Q?fdYNzaJTZJIlcsoDQ1jtXw5mCaDhgltRCXdOgogBsh9DbIIjg2nlsZvaQ03l?=
 =?us-ascii?Q?E6ruaf/oIFXEFvwaVstIqJiIl7QnZTzEVeZYI8fUFMAU/tY4HmbvL3DuTeTj?=
 =?us-ascii?Q?rdjZf2eXCFRS3/O2ZWiaq5L51+C5z0GMI7nu1bFn09Aag9q+YC6lAekZ7WOw?=
 =?us-ascii?Q?89DxH77zvD+xbokLCc/tBi4lfJC+DwLxSlqD2Uao+AidbvHEspLrRVNeo4PP?=
 =?us-ascii?Q?hARmbCM9YfAPAyNrBHM6jGvAHEwMJ/L+w7bFDg56B6C9aksvOf8YYJgvYWtR?=
 =?us-ascii?Q?YtB+5GEL46miWbj/E2dgf3LhDAkRwlLITEwTeRD0MppSRAXcSi7KM1Qur2hX?=
 =?us-ascii?Q?7Q+CaHIaEI+RRO35yO5mwRdu1luqPQym2gc4AF0to1mpsMbJlCVuVeM+nCsT?=
 =?us-ascii?Q?HRCYsbYg0BrgdCbcOyfZLnwFqyxnNOsToIn2aKWve5g+k1q0OAgfc1gCaOUB?=
 =?us-ascii?Q?9Xjj0XqqPb1IYo/sbXhLT1uY3gMz2xXdOqT57YxGXRLRkfLTeLgxrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:56.9704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6ec2b5-c083-480e-d791-08dd5ff2550d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436

ARCH_HAS_CPU_ATTACK_VECTORS should be set for architectures which implement
the new attack-vector based controls for CPU mitigations.  If an arch does
not support attack-vector based controls then an attempt to use them
results in a warning.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/Kconfig     | 3 +++
 arch/x86/Kconfig | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9f6eb09ef12d..cfa65367a08b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1748,4 +1748,7 @@ config ARCH_WANTS_PRE_LINK_VMLINUX
 	  An architecture can select this if it provides arch/<arch>/tools/Makefile
 	  with .arch.vmlinux.o target to be linked into vmlinux.
 
+config ARCH_HAS_CPU_ATTACK_VECTORS
+	bool
+
 endmenu
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1665ebaba251..cb1c03021683 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -72,6 +72,7 @@ config X86
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)
 	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_CPU_ATTACK_VECTORS	if CPU_MITIGATIONS
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CPU_FINALIZE_INIT
-- 
2.34.1


