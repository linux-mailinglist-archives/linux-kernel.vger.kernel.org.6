Return-Path: <linux-kernel+bounces-397191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F609BD7DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891621C22C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEC121643E;
	Tue,  5 Nov 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="egv2t6KN"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99979216208
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843730; cv=fail; b=Wavv9Ox8fk4u4mboqSMRHvvaCFuQgpE24ykAToaQNxEeSXtkZbyRkSRDIkXfIYUDmugA/kFWssnV9WOzFUHpqz7UI1omFCylPQlqFbhCXfQXi3FhW88FKt9D0Tq1zEz1CA4I0AFa58MiAJ+9WVXaWQbyXQnXUAnO1zRcMZfVGZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843730; c=relaxed/simple;
	bh=XkwO1BcRyH+q3huY2ZYKVrbaBMXFW+N7q0t3RemmyA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6EPMJ1GjiHG7t7+IENKshaMw7VBRGHArzEThp1PVUvwi18XlVC/jjnF1QzFj6sbBMW/Ywe9RLMTYVbrLxgFXWlMsIJyGMQM+mrHFw7yZhpWrqtjh7MfVUJ8IMvoC7GFUbXDqcVABNCi8ykQCDJGsATNzlqpOXYwURvdVv8EZ1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=egv2t6KN; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzUnsaa1e4H2y9WaBGdJbcRAWq+mx2IZblDPATnl6hFh9LnDNXOwoVo10AAMTsEzPEA8xRzmzSpEm+eshW/iUK3gIsNh1jmulLTgg7OLax4ahDwu3DqEW//oWLMp0GYE5WZg1g7JaPbbLyzr7Fdv9xpi6NJqxYz3KdW1K7QEd4p6DJPFjvVstkWUWlCbP8xm3vuolyGsflQDx2tGJK7XJT+3oJa15hV0iQUeIxB+ev9cNSn/08bhbIZPbMDni7UXP3whZFhzzdJNrKtAVf3fbog7HAOAvZ2hG/iatgTCpQvutb71UkBPIMZoeacJZqENahQRyVCWqn+MAzMtM5TuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVspYfqF4DbXmwAm58QSEOkjYHLrJjE8bKsKwVCDz5I=;
 b=gThrnB/HhEcHHKjSgjZgOAb6ig3n8TWLiuhgEMPVHUvY/Druj7l2GpU9wwx0B6qwDAMM0Zbu/RyBLXO1xTYsZ06Ve+PCXLADNVKnyVl+2GHkxaT8yvvfqTLZxi90jR0FhXMFxHN2sOP1xzZ2eVozsqZaolGO0qCYl80rdXcu8Lv1bWziLqoJeaa4qU5FxyxzBs2Yvq620Q2F6K0zylIwpJ6qu/rh0sZKySwtvN2DEM/csOyHL5ILv1jZfaiZkfetaJQizrCzqFx6Jz4wDr689hW2W8YROtmt5RUzELFHsWFbtaCt7AVDbKcMryyKypX5MytmnASnGZIHZVGvJSPfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVspYfqF4DbXmwAm58QSEOkjYHLrJjE8bKsKwVCDz5I=;
 b=egv2t6KNzPyBhX25X/xkRiSQc3tNmSwaOVcSNu32KANNtpy6jJCBz4fAfT1/hlWS4LsOcFFGRVijkJ8vRSXqDmLYvP172UcKFZAMlZem8pcD8iG5qpvdPRUVBL8lcf0BkG2+2UUEbqMhG9AE9c9SffXytzKQtvtpd5Uw1Q5cBYI=
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 21:55:23 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::d6) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:22 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:21 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/35] x86/bugs: Add X86_BUG_SPECTRE_V2_USER
Date: Tue, 5 Nov 2024 15:54:21 -0600
Message-ID: <20241105215455.359471-2-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 83145290-5e59-4674-dd5e-08dcfde48c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v6IKaeVKyyvJojMAO0via17uEgvr08QvqxJmQTPWsP/O71BIaKoikc5Y7Jd6?=
 =?us-ascii?Q?FjUdqUZNHljYQ5oC+rLYu9025Ded+5miPMbRJcf1eFYQa7quqExyRPLiFwVp?=
 =?us-ascii?Q?Bo0yqEqzZ1CTdy/rmFTRT1G519PbvrQIlrqWIHBnWkXWxFjNWRBcNSdtAfiY?=
 =?us-ascii?Q?d0D4Va1d56o14ROLmdxFeE3TZ4whv0NSUPetRL77OOlwSbA23zjUKYS2GnnU?=
 =?us-ascii?Q?iXV6rZ9YnhXU+z4gVMqTWTjtwowbYRsNuhiQLuHcR4K0VptTlpWMQf4O7xYD?=
 =?us-ascii?Q?VT6ACK2tUyJ0eyPSsMI4XZnOE9EDtvszR+BlnVxxDG5h2fOkcB6rlefk2Bas?=
 =?us-ascii?Q?zNKISBR89I/rlOrMq42GfsqqMt8KpG8RMLn687PmHs5uOV3FlSRPWE2yZae9?=
 =?us-ascii?Q?W75BUwJLkzfhO+jN1duuRTRGmIBgQnTQbn3UWrk1D8hMyXN7p/x8QKnr9mLh?=
 =?us-ascii?Q?4bvj4dxOf5Gj/6WEvWjX0tq4xecFVBBsdfqdVJHVhWBTm+A/AVb28AVo29Nd?=
 =?us-ascii?Q?jEAKpP0b0EHqBuwYfin2wbyWi8GsU4dhQQNB+22cBN/tG3/mGZBSpMZvqBWC?=
 =?us-ascii?Q?vcrqv2dF1S7xEiG3zSSijTNcRNsvOk+j2zg7XdfhGpRBL+AOY8Z5FPYdKvuz?=
 =?us-ascii?Q?27OtoxKsfP3VpY3ppt6/uP2R7oEs1RZtbiUs8SkFGFfsiIM94YWFM+bVj6u+?=
 =?us-ascii?Q?/PPXMM06R4Bc8lI9RBhvPeBFq64AKJwi+quGtp1Cb8fy083eV4k6i4WP0DL6?=
 =?us-ascii?Q?z9+/3ic4Qmnp7bw0WGOjGlPL9p8AsQdI7c3BHIhVe9YYeMnBDtOnAVtC7w8I?=
 =?us-ascii?Q?OBDVDCd89c+OvGpUBg03Aq17+FVfnFBzZ1tQG62ShIQVsNVrsxcHlcfedAEt?=
 =?us-ascii?Q?ZEWsKCZtrEPcOqmlRsqlMdVDEhnMLL5/xxoRuCF10Z9C2jaN5FQMWeorFIXT?=
 =?us-ascii?Q?OeVEB6dnc7tkRMotuOjt+xuQ5SIWM/RTEPQVy46rcW5O3kpLMj5G6i2FHpIE?=
 =?us-ascii?Q?YgM8Dr6f+m87RN2fF51AHT9ET+jrsTmFZV/YTBFHZFcZUBxQv7YsqHRqUM0e?=
 =?us-ascii?Q?tWlHfJaYdz7OiSKoz5pH2vpdyo4+13G1kVj/A0AsrqB96n/Lkv5ErHPVKNIK?=
 =?us-ascii?Q?rQwZNHbe1gXDrJMgVmYomLboZBt3cxfGH40xg174ojFLVwUy9cJvKpkPTL6u?=
 =?us-ascii?Q?QCgiQjRP8+ZClbjvcWsCqSSY0TO4hZVbVxPh8RQc4Ug1Salgk+NUDkAFbNdz?=
 =?us-ascii?Q?lM+tEN7Xyx5NZX8pSm3fJ+Gi7NJPYOEMCN2P7a9uG07qZs8RER3O10PwC4C7?=
 =?us-ascii?Q?mxZqEbtoOw0xds2GVDBcsXS6IobfblG3uYMEn/w7bbsJT+Tk4PRfUnb7XHWX?=
 =?us-ascii?Q?jZBoRq263k50OsW/UPcSqo72hjjJd2YAw8ysWRr9jzLn1OGAFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:22.6247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83145290-5e59-4674-dd5e-08dcfde48c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720

All CPU vulnerabilities with command line options map to a single
X86_BUG bit except for Spectre V2 where both the spectre_v2 and
spectre_v2_user command line options are related to the same bug.  The
spectre_v2 command line options mostly relate to user->kernel and
guest->host mitigations, while the spectre_v2_user command line options
relate to user->user or guest->guest protections.

Define a new X86_BUG bit for spectre_v2_user so each
*_select_mitigation() function in bugs.c is related to a unique X86_BUG
bit.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/common.c       | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 924f530129d7..0c4c974a616b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -528,4 +528,5 @@
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8f41ab219cf1..a2bc1c1b31a9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1332,8 +1332,10 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
 
-	if (!cpu_matches(cpu_vuln_whitelist, NO_SPECTRE_V2))
+	if (!cpu_matches(cpu_vuln_whitelist, NO_SPECTRE_V2)) {
 		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V2_USER);
+	}
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_SSB) &&
 	    !(x86_arch_cap_msr & ARCH_CAP_SSB_NO) &&
-- 
2.34.1


