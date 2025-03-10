Return-Path: <linux-kernel+bounces-554704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57681A59B63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A49188247A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E823ED5E;
	Mon, 10 Mar 2025 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PMFS3o9L"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E423C8B6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624871; cv=fail; b=DOpz+D2lON4c6NDIVzL/4dny2uvn/u8dDmPKl02TK1TGyNUAnms+nnAdLRu1qIOefCJSE3L5M7EbayQIQJnzRuzJ8Lp8MuFa6N6BW1msU/uP3X2kpSS0iwEtxkefHzABFMDA5plt1x/LZI4g8e8W3xCYRlvc3P9v9BpE2n0xX1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624871; c=relaxed/simple;
	bh=5I8ky2SkEkbvHvGZ076qJyzF8/JwbeCVYaZdFjMHYRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAUj7C4yzKzd2fDnHULDHQzW+WSa82m2WYiD1O4PeyA3xJ4vQUCCTatkqgqHGcN95hHAuZmf4SrX+5744ayMEZjX9IerOW0kpjzSvfcEI1xhC+Bj4jHpblPcDc1dL/5A+002bUElxcJbhJx2F8TX5ygk+CToxphnDUFSQ6D77UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PMFS3o9L; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzgYXOB2dqJyRnr+3M5Wfkatz40JdDH2sFaTmre2MhQRcVTy0Nnzs8jnnd07ey4T9mOCJ5ti3rKv5KCJSe+8T5IApnpoLEYfePjBaLmN33gV2pu4mHvJDUyHO09hFe2zgNF8QfVSJLNEdG3PxBtdBOP175y+jj+5pYUww/ll7hYrYr0KSGUR2Zo2QOggX2jj1xLgAGcjXz4OsbayG5VLQJoO39YZpPAkm4z5ZZ0xgehgiyk5eYjfcf6YW9/rnX6wzLdS1d2bywFQVrQfLJXfzAA5PH6/9eXm/zsjZQ+/3gsiruXhBRtHZk//tCvwoXuDTRxqjUupEaxvgkYekTsTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcU1q6I2XNPpnVHCO0MRiT36GXQ1z6lpxJukiazU/NE=;
 b=PF7DFr0wScRHbYbJDjUmpIsUytDFfJz5wdsxhI95X+vHNuT3vu2RV2n7VMNp2CfqDIvTZdsIvVx0St9z0P8TfH4y9GtpUDu6BX1CovnQLmIdrmJ0fuXpAQzen5ZvLtu+ikGHhaok5488pEr4DOWaPXIdMCCxLoMFA11Am4Rxhx/NebDrkHRuB/kPR/YBaPmUUfXHzAB34BYpgJ96FBsjCQSF7x9jKUZHLCBA9X8CO79DaVJIUqtGnDtDQPRg11nuKRKuEHm/5I7mxHGnHEcXWLBljvlKtybGb+nc5NpPyFxMfEaIwKKqk8MJiJ6oWsWNlTDSzNxCFFHKpuAzUE5dQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcU1q6I2XNPpnVHCO0MRiT36GXQ1z6lpxJukiazU/NE=;
 b=PMFS3o9LwDeIoQkU0lZv0OMJj56RyZ+dNd2Y3W4yVVzF+bqBBT58CqA6dvCfJFTWDnyUuW0VwgzcsS1dANHp5Y2FnCrX43sOfcyXicnvD0LpqLsx0pJTtLzbG+jye0cTvffNN0vTFh1wUFiiKLb4R8WSz48d5zP53Yqz4pJSzbU=
Received: from BN9PR03CA0075.namprd03.prod.outlook.com (2603:10b6:408:fc::20)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.24; Mon, 10 Mar
 2025 16:41:04 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::a3) by BN9PR03CA0075.outlook.office365.com
 (2603:10b6:408:fc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:04 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:02 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 27/36] x86/bugs: Add attack vector controls for spectre_v1
Date: Mon, 10 Mar 2025 11:40:14 -0500
Message-ID: <20250310164023.779191-28-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcdad1f-c20a-48d3-b6dd-08dd5ff2599b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OqOWUkXEw9LmuS89x4ZO1T3k1SWMOiDWJiTygKBh+1Rfk3/uPi/JYJAVbJ3+?=
 =?us-ascii?Q?JLbNbmjV1fdccIEeSmGtqMC8q0j+bHGJLN6j4UavWpr29FHrPk4kc8EqZb1/?=
 =?us-ascii?Q?iygRThmghn++C6Eu1jSx6bkKxBZPbH+prLoMI/pX2W+Q6Svkl3p2IhAGyjfo?=
 =?us-ascii?Q?X75crM4FWLdv5BWsEU4+fOTHJgiYfkS1pVPY3fxuOgXK06YrhL5tO2GvY6Sl?=
 =?us-ascii?Q?lrrqw4e3ocvgnZsEkknSTQpxKWkDRYK6o/3Zd4YSKsTNLacWseGqoKa6uuXI?=
 =?us-ascii?Q?gbV07VYqDiuWeQlRWK7sFnjSwmFgbv2M/AHTyAYuJ3WduxM8ZcpJ/Bxs/dZz?=
 =?us-ascii?Q?PH/4M33dKX4Sc381pfLTKO1Pi2nE0u+btkNPkO82qk7gPbCBX5Hd7CFwxd3I?=
 =?us-ascii?Q?9ZwaUpKgz0glHuFMI7szStqSORSYeWUb4Fkbj57U4ACyf9d6HSvJR3RIzIQm?=
 =?us-ascii?Q?wiAL6GfLdGtMbyBeB6w8pRe3Gmmmb1n7zUZamg22gEn96S+ZVGMHeqhzZmoR?=
 =?us-ascii?Q?r9I0fdOmkd0ePqntscoxxJuMDAH70kr4wgLPnP6uQSTVQB5UsesrqnH+7Gg0?=
 =?us-ascii?Q?tQq0V9rtvVGsEGr4dnUWfZI2/XLBJmtEEf3+J70UrLQxhkx0ZtihUj5rG4dj?=
 =?us-ascii?Q?4iae+xlO5/DajPI82PKqx5vpr4IAbjBXsNifPa+DmfdP1CotEeW/CXv8ZpGy?=
 =?us-ascii?Q?rETb7rQKln482a4U4n/LwLkiVfFF/BL1pJn9gjOZMzODN2CPX90yOx7eqG83?=
 =?us-ascii?Q?By5dDTqEDbhuSdSkpVPBziZ2FA/wRBhw9To+LgCmZ1g1Of8okPsVh4ACPN16?=
 =?us-ascii?Q?xOZDe8O+KCwur9xGwWy2r4DdLDt58RPaYtok/Y0BDCg0nXM87XkQ91RWx1xd?=
 =?us-ascii?Q?ceNakichJ307GwBdkEmXuXKIL3XZG0r63PCh+1uOQx00WtUCimOcKM6vXkUP?=
 =?us-ascii?Q?Vdutm/0O/U7XEPQophGn0XO/UtYyUij7buET82zaGEaxg45/rP/FT9Q/OK6/?=
 =?us-ascii?Q?pabToTuQC77stKtryOU/o90G+lT2Zc8Ql0AvBNuIpxBngNKIndDDda4D8e6u?=
 =?us-ascii?Q?g0duMtt13IdrQ/gyj4WWKSkonqKzdXffjwQ3+sj/rF+mM2W3IaqauqfYCW70?=
 =?us-ascii?Q?7ImJf60Lk5+7LTkT3z5H5AAfoe50NRB7jlvswYIWw1mrMiHVyNA3xVBHF6UM?=
 =?us-ascii?Q?TVF+dhwNYXnzKHeB5EktcGXM5USGIDt201xpBNsnqE/ZMWxePADOY24utOuc?=
 =?us-ascii?Q?IM8zv9FAughszPzpfXRK3up5O7WVv4NjkDkNndqelvY85W5EpVjhm9xkNQ1i?=
 =?us-ascii?Q?p2xvoNMfRC7oEf2nT6xbiEPcrtPGMRIUVljZ76RTtzxMIIJWw9DrarlOYrs0?=
 =?us-ascii?Q?wWDxjZaI0wsyDBCPlwU5B210RKA6s5NomzdlQjDpGouVYOLdi9hbQoXqarsh?=
 =?us-ascii?Q?p31OR5g3jWwt+Az+X9fNR86ntov9rI1sILs8lv/jDdQV4JJXfiSNyU/8GUGH?=
 =?us-ascii?Q?w9WgU7+xmhNPAPU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:04.6111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcdad1f-c20a-48d3-b6dd-08dd5ff2599b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

Use attack vector controls to determine if spectre_v1 mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5803c45dc15c..00f679dcc28a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1108,13 +1108,16 @@ static bool smap_works_speculatively(void)
 
 static void __init spectre_v1_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
+		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
+
+	if (!should_mitigate_vuln(X86_BUG_SPECTRE_V1))
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
 }
 
 static void __init spectre_v1_apply_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1))
 		return;
 
 	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_AUTO) {
-- 
2.34.1


