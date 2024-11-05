Return-Path: <linux-kernel+bounces-397205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E469BD7EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67341F25355
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C021746C;
	Tue,  5 Nov 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zkntCoZJ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793321642A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843739; cv=fail; b=YP+g4nWEw2HzigGp8Baq4Vq0ad3aX/ib2y5UG6UaDQgR7A6MvymUv8TrsfTDkicMJw7uiZiifZfMP8h/tuiu61HAw9DK1X/GrdQMrBWCaamkTHGEFOl9CyezFYivcVnvJkT5EZC7c//tz2CGcQYKl0xkqJjYaBr+5Md97gXxaRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843739; c=relaxed/simple;
	bh=idIsFJf6Uf3G7TYCyVhgVlyNEpzG+mGjWintVF81uPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssg3c0Jn3uXdzzuLTZXPUsB1N2XDnNHLIO+3vrNKjXengbuJMg/tns1UBWSx8hBKSCoRJ9krNeWmAXusnY2VzYTpvkyxJB4cZJGNlc1Mpj/rlrsvDCGhiocbdplUVmb/b8V1KpTvzfCzeSrDdhu33f6e/N44CFKw/G2NsMFMqG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zkntCoZJ; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmceFj+BsSbnuNpY81zxUlAb1C/grnQYQmKWqODKM3ROZ8Orq42bABakJiy2GrRU1mJ/W0tJi0DQf6mFHLCRLnVRa2rGlhHjwKvwBLByBZClg7LMNP3UtqtV/HH4rP1K5iKCE26a5qpmX0urdtJdzlbBSPaXiN7h3YHr+9om3+7zupwv5gKI6Dju8Fsw5u44km6iPGoENxDdjR12t+W2BoMze7kLP/oVQRqZDvcamSzETOtmW5y/VbFuEBo/8qT7b/fqcIdd4Ih/u7CEA1E1ISlPxzXbQ9CkgF2aTBaeWGUGC8ZkDBWDJmW+LV8p+YBGEBiMHUvM+UIk/VrZFJyBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUJlO+GwKIosNNfhw3xznS3MV7JCOLVGdt2swOWlimo=;
 b=wk9iy0pj4OjOTuDu45kPs6e0NOlL95+4W4KIJ4S6EUYij9MU2WnGN413jCuIuekM1ZHfkcfsN8jqboaLVIJ4E/LcjlLOLmjs94K5kHCFlbMX1cSGq3RuuvIvfNkp2yCTEWdcx95+zGpqyld9ZWO9nO/6F1euPa14afdCC2ZYbZBdo4UIAXHn0wi6aKS/vlhxysleNqCH7IPPmDn8xF6EYW4yDeg68YBNiJObddU/o3h9qKTKo20BFyYFU1p6eSGr+9pL4NOOeGXgFuIX8MusfFdRCoqJMPbVMq+02tZtYoy0PJPq1sPkmqdRO/4F5FeHRUwPJjlyh/ltr9UQ0pDX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUJlO+GwKIosNNfhw3xznS3MV7JCOLVGdt2swOWlimo=;
 b=zkntCoZJuJCEpcFLzBiqfgHdPaq2BJHBKz1o5o2A2N24/T+I02A+RqZxb9z09H+DTZxbPktw6960AcMwbdiEMJG6fns/HupxnuXL0/uOiOVWeHinSa9CGDQ+FgndOy02CyQbJpQ/cIPa8SClcN7ySOzux4r8URaUmnejFF09Rao=
Received: from MN2PR15CA0065.namprd15.prod.outlook.com (2603:10b6:208:237::34)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 21:55:32 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::1b) by MN2PR15CA0065.outlook.office365.com
 (2603:10b6:208:237::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:31 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:28 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 14/35] x86/bugs: Restructure bhi mitigation
Date: Tue, 5 Nov 2024 15:54:34 -0600
Message-ID: <20241105215455.359471-15-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acb9c7f-9304-4650-b148-08dcfde491c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wEByiEKFGniwaIPl1OHm4f7Zvmf2hA8gnqM9Td/+HIHjbiSWnL9ifDMDwm+b?=
 =?us-ascii?Q?M5LobBSUuqQSUildNHMLc0q9fo5gSITaW/WKo/VgCz1YJuf+uoCiMoSfmadp?=
 =?us-ascii?Q?ZZ8YqW8pHIT9Nul992S0CxohJ5Hs14H7gf3kwl42J83y5gXNX4gUnVN4zpeh?=
 =?us-ascii?Q?lwsCTp6PPId+GCWfjaW/24D6FiNNoI+uE6mYtMPGTJoctXFO0jtxPUVgwm20?=
 =?us-ascii?Q?9+UrZBb+FeHmu9W+omI2X4C2SGrbdbGuUdkVRwQPqJeFkHvWaBoJisH1JGVb?=
 =?us-ascii?Q?SliJHR5iz7aoX6/dLqMixgiNx7kQ4HoEWX1Pbu8jqJCR+grRuJE5WJg9NkKg?=
 =?us-ascii?Q?mW6/zSEJhPTJLnou6E/rdVyyjuS0IhzLdhnvKMujMJGjDhOlAwe5A1MZBC/v?=
 =?us-ascii?Q?y34a18/SV7TVozSQqY2oG5+8uhXS4fqgYv27m9AqEoH2OXTeOvIrZGXplxQa?=
 =?us-ascii?Q?YD93t0GEh9i6OB38ANb56QTR05uz0MDPmUBJbAjCHBevXT+rMjy0pq7tmh59?=
 =?us-ascii?Q?dUFCe69qa2TMJl3NVKJFkGFm0rvH80vqADM1FXpR+K00EOWDOMyV2l8D/CFp?=
 =?us-ascii?Q?sLN+lip8rqHoa4AuNGm/9N58UiaNqEXUmYM9vPgh+6saOmOtL7utAnJCtWN4?=
 =?us-ascii?Q?/RLnWZhdp5Qa5kI4qrNCL6PJxdNHmSqr5XOtvpZWHibf9YDlcqGmHCw8hGeP?=
 =?us-ascii?Q?+52UW+Eo6bC4tNLi8VP3yWugzlvZh+0IuFYNeM5TEXrElWuFsfmjitbdoBax?=
 =?us-ascii?Q?Rs6GDFyjX8yBFXVZo5B3LnukJveYbFUlVGadZCrXG2rM7m89qiCgdrp5krZ/?=
 =?us-ascii?Q?wsw648I6ifkNNoy+wcZ4cXyMLhJ+SvPojNF6DWbr43aQaOYh0OyDGwnDrhX+?=
 =?us-ascii?Q?FXnt3Zh5TAj1quUy+48erAziNcVi6Fv6FraIu4lNAwqUnGWEG/veEldMRPeX?=
 =?us-ascii?Q?NU5C+QqKITihs3P91Ed92n0ALnOyY6kdWZzdcTWzR1OqdRxVchEJKBjXOdZO?=
 =?us-ascii?Q?IDwIGnwuS6Uv5BLFHuydZSbac2SABF0/25A9OW/w5RRQw9JqxQI1x4sZ/HW8?=
 =?us-ascii?Q?m9W/tu/t9S7S354bBBeEQXRgo5iRN+R5ALltg/8nWFo5Z8VdBxDzKn2DLsQM?=
 =?us-ascii?Q?iMflLnMTbR2PkrkDxxrP1P6vIuNdxD2O0c4JEBvkjPdddIDywABTb9qP6slj?=
 =?us-ascii?Q?FsV4fzZJyCN1Sh+qVnYmTEV2mMR4LikXGm/t1fCM1ObCANcR8tGuzhAHNQh+?=
 =?us-ascii?Q?pYZG8giY+6mFUsMxrHYEz4yq7yzJCK8xjqn33auJt7xfikDjOHAXky8ZyRmE?=
 =?us-ascii?Q?fgZRxwlFDbIYSZ6WZ9W0lsOga7TaD5tgPNihaYm5z0Rj34yhhXUVRsfiD988?=
 =?us-ascii?Q?STrs4XZoVNkPFB7M1UCKvQljdU8ek1DnZPytm/Rzc9hcLGqYyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:31.8903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acb9c7f-9304-4650-b148-08dcfde491c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

Restructure bhi mitigation to use select/apply functions to create
consistent vulnerability handling.

Define new AUTO mitigation for bhi.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9a41fd121b71..62ba49062182 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -82,6 +82,8 @@ static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
 static void __init gds_apply_mitigation(void);
+static void __init bhi_select_mitigation(void);
+static void __init bhi_apply_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -201,6 +203,7 @@ void __init cpu_select_mitigations(void)
 	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
+	bhi_select_mitigation();
 
 	/*
 	 * After mitigations are selected, some may need to update their
@@ -222,6 +225,7 @@ void __init cpu_select_mitigations(void)
 	rfds_apply_mitigation();
 	srbds_apply_mitigation();
 	gds_apply_mitigation();
+	bhi_apply_mitigation();
 }
 
 /*
@@ -1743,12 +1747,13 @@ static bool __init spec_ctrl_bhi_dis(void)
 
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
+	BHI_MITIGATION_AUTO,
 	BHI_MITIGATION_ON,
 	BHI_MITIGATION_VMEXIT_ONLY,
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {
@@ -1769,6 +1774,18 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 early_param("spectre_bhi", spectre_bhi_parse_cmdline);
 
 static void __init bhi_select_mitigation(void)
+{
+	if (!boot_cpu_has(X86_BUG_BHI) || cpu_mitigations_off())
+		bhi_mitigation = BHI_MITIGATION_OFF;
+
+	if (bhi_mitigation == BHI_MITIGATION_OFF)
+		return;
+
+	if (bhi_mitigation == BHI_MITIGATION_AUTO)
+		bhi_mitigation = BHI_MITIGATION_ON;
+}
+
+static void __init bhi_apply_mitigation(void)
 {
 	if (bhi_mitigation == BHI_MITIGATION_OFF)
 		return;
@@ -1900,9 +1917,6 @@ static void __init spectre_v2_select_mitigation(void)
 	    mode == SPECTRE_V2_RETPOLINE)
 		spec_ctrl_disable_kernel_rrsba();
 
-	if (boot_cpu_has(X86_BUG_BHI))
-		bhi_select_mitigation();
-
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
-- 
2.34.1


