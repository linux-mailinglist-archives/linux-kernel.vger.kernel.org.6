Return-Path: <linux-kernel+bounces-397224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB869BD7FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6C9280D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9AD21A4C6;
	Tue,  5 Nov 2024 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fMfO1UXv"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63060218D86
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843750; cv=fail; b=t3UdnxpDfTywescqrNCFJu0BjDCsG5HJoRlaJLZnWfAK7uR29kffCLmKA1bsRXSo1Kpk3vBh3yGmjLNjvIqoTgySmfbV34I6regji8CJdZ4yp1INt95hPhfqOT8Wcw3cgtgipjLIV8POjHnxkLJZDFgnOHAY/GTEX6kajrijYNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843750; c=relaxed/simple;
	bh=0uZxXm54Sda11+q9Bk0iNChNLq82eCuq1RxZyl8kzc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WU0HQtdnSLOJkDrPZ8Dj+SdM63JByXFkHo/3paoEMMqwxUslZbU+yVAXamstN/mwXPCKZK6w15zEIAz2rl06N49XO8TyfcOtmQLolPYdTbXbjLQft8MTHKuQQOZiaZ+gcqyaVqMQYGfWEUnCgIPKY8G06KJfM808qYPeguPMLSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fMfO1UXv; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+hYRYiaOaHHAuJ1W/x+8n9rfanlXu0QfYcaocMrtftVf8vZotQ74lMIFj73AYoJc7QZPD8k/ftAsMPeZSmK1uCaRaZDuQnLmVT5iSP17KShC0YXaC7o2yuZAyBujkylakwXZ1lGNzLLKHqJ9Wkvf6ae+t1iV0qkVYYzBxbVMZuEOWFU20GCTmz4+zG53pT/stB3/YPvQQqn4mJgiELUocDQQEyZ91JAwZ5wXTMUzVnTJAJ0oR/T370vjik47bxKbQ/YHRkUOV+6eyjyNpsrelFkzt5eL91utVNmGlbwwQmGw+34B2GK5farwFauXNje5+jP5FUptQ2chTpwW4fVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpO5RsR7cKKlqGW3remJY3A30upc81M3vAflgnUILPs=;
 b=EZCSKiu1rsC6MzE9dElb3drmcDCktpSEH6IXoBU57m65uovYGWTy+gmKmwIhlBaH7BK3ZZXIv0XNg4IosPt7qetgIxtGI4WtNBhvRfBvuwvFJ2yQFS44PFaGA8jfDH7mYkuHJ5K5vQqefejTTgLd5fMahouDx8FgTR9Wt9R9unY4oUITVpJv5g9sCrTugOnoi47++UnejrnMdh4qOuP6rbK3yg4z4Yyoau6my/NgKyCK0An41P3C8bNuta0eUKpYOx3J4IS7cSN7KjbOyZmjVVH9Ty7h7+fBdJDOI5umGPN+KZUS9St574ew2KVH7LedIpdxZ9AyqxyxHKOCr1MORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpO5RsR7cKKlqGW3remJY3A30upc81M3vAflgnUILPs=;
 b=fMfO1UXvCbrXBMzh65WewZidu0MFySw/UVtk01yz5VKUNB2TjKoep4EEUBbFPgfaSelssQ9rry+DzUXWB7QHjhUNC+z6LJEhIQWcOSMmmp6D3iMAw/3/ZLIk/vRf/IZb1S+FSwXhOwpxA99pcHGtljSjpsh6y+p/2YOhR4Ph+zI=
Received: from BL1PR13CA0361.namprd13.prod.outlook.com (2603:10b6:208:2c0::6)
 by SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:42 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::18) by BL1PR13CA0361.outlook.office365.com
 (2603:10b6:208:2c0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:41 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:36 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 31/35] x86/bugs: Add attack vector controls for bhi
Date: Tue, 5 Nov 2024 15:54:51 -0600
Message-ID: <20241105215455.359471-32-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: f221b094-1d75-433a-401c-08dcfde4975c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d5pDjT4npJGdxUmOVXLXkQ4CGC1l/BlTOLKrSjGjwkVenv5eLxU45hJuFRXd?=
 =?us-ascii?Q?M0eq5iAay9t2cEpp/cqiWBko+P8v069BteNeYN+eQLS4nyvaN7YFMjp6IK6R?=
 =?us-ascii?Q?xi5V1ZGVMVxQDkkjcPqmzbhhiiOich2qLM0Q1RtQpCI7e3O5qHSHCaw3UWE9?=
 =?us-ascii?Q?8ppPnI3C9VBIjEeKKdr2aEpj6+apTPEbneecUN09ocikeR/rkb8GHsXQhGdt?=
 =?us-ascii?Q?xS+QwT1hpO6Fd7atLQHM0vwjo7vqtXFrahRw/2yVMT3+Gy5U477cmHuOY36U?=
 =?us-ascii?Q?7iO3pUt9uCz1t7q7EYOSFMqdveScO0qCRsHat3P50YvfQlWDjaeJIM1oEikx?=
 =?us-ascii?Q?MLcjslKMfvjM/jPNFfW8OlVAfKpN5e1LlY/T3HinzoF6i1IcqOUVRxgsz/Fw?=
 =?us-ascii?Q?iByiUjy7cicMtV65HApIvzK5fo6vGZ6i0rDytp96wHiGY5sNdh3SOFi0KpHb?=
 =?us-ascii?Q?G0TsNJUj2MbLR1v9XEUdASmnWomJ0g75wYU6S045+r/Ez1o7b0JLFXlxP61o?=
 =?us-ascii?Q?eMxk0C4+5l0P+aTZ+kzrb69OjdW93MWGmisGbG3OcpA6wtNXs7ek3EF4RMIW?=
 =?us-ascii?Q?QJriiFkeZyBFvOtIAAN4IPzHVH6AVr26vGjkE09JQzzImoq3yrmKSCXFHN/8?=
 =?us-ascii?Q?8dXI7vWxzcuHiwlsyRHOuPcKTMYgV4BTtSVBcITW3WRB2Hndp/yU4iYTXQvp?=
 =?us-ascii?Q?UcKI5NShj0iFlsQKMU4G981CWIwoyuPPIBs9jH36PcWQqT+xbrnPLoCHIhgv?=
 =?us-ascii?Q?nedWcKBGdPgiGyJK/SAuLvSpEthBpYd+0yGzOR+3LXlAT5UAhGGpgkqDsCen?=
 =?us-ascii?Q?nvkOTcCyrXkMSH2kgxrdaup1Wl9g8b85QD/YEetliJYPhHgsZv3Mb7GgUeBF?=
 =?us-ascii?Q?TeMvVWFdesNGWkpfHWykdoeSi/AeRT5ho1962dRBQFKAT7RU4jRmEpC73mCg?=
 =?us-ascii?Q?3qjTsft4XNRa5LjAx1KgjuvQ0HhN5n7yka/3J9/6CIjQl8p/8UH6gnlHsD92?=
 =?us-ascii?Q?QYkkAoO3TejViS7buIM2j3Drrj/Isp4Hd2qL8Gup/Hz6g3Fy5Qyprz1r3Q05?=
 =?us-ascii?Q?26KguqLGbGlFwgnpyWwB81OP+D+VpigAVykCQI5i29qtm6JL3CvwqOq/GIg4?=
 =?us-ascii?Q?yc5tWjb8hLr6RAZWmUrppjW2TXsMfeYGIFcT/B9HhjmW6lDlhkMz4016FJ2I?=
 =?us-ascii?Q?YQ8N2kEG2GAmY1o/J9zo53Tkph8cULpYm2xS/YEF09MXEo5fiL/3XiseAtXw?=
 =?us-ascii?Q?kzNigmo39VL5Nq71AGrjOgxe+thx5NlE/Dm9F2kyZuMjAgD/OQA8gPnCFccG?=
 =?us-ascii?Q?Uic8u/iw+NlsJZHuXxrPg3/a/xbww1wSz89QDi7vEvxmI7TZ99n6UB35ewUL?=
 =?us-ascii?Q?ybajcKsD9ob3gR9Wiy8LoFMGAQygDTX5ldM18w/MUaGv1d/rfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:41.2762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f221b094-1d75-433a-401c-08dcfde4975c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237

There are two BHI mitigations, one for SYSCALL and one for VMEXIT.
Split these up so they can be selected individually based on attack
vector.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6479c800e973..cc5248cdfe6f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1876,8 +1876,9 @@ static bool __init spec_ctrl_bhi_dis(void)
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
 	BHI_MITIGATION_AUTO,
-	BHI_MITIGATION_ON,
-	BHI_MITIGATION_VMEXIT_ONLY,
+	BHI_MITIGATION_FULL,
+	BHI_MITIGATION_VMEXIT,
+	BHI_MITIGATION_SYSCALL
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
@@ -1891,9 +1892,9 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 	if (!strcmp(str, "off"))
 		bhi_mitigation = BHI_MITIGATION_OFF;
 	else if (!strcmp(str, "on"))
-		bhi_mitigation = BHI_MITIGATION_ON;
+		bhi_mitigation = BHI_MITIGATION_FULL;
 	else if (!strcmp(str, "vmexit"))
-		bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
+		bhi_mitigation = BHI_MITIGATION_VMEXIT;
 	else
 		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
 
@@ -1909,8 +1910,17 @@ static void __init bhi_select_mitigation(void)
 	if (bhi_mitigation == BHI_MITIGATION_OFF)
 		return;
 
-	if (bhi_mitigation == BHI_MITIGATION_AUTO)
-		bhi_mitigation = BHI_MITIGATION_ON;
+	if (bhi_mitigation == BHI_MITIGATION_AUTO) {
+		if (cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL)) {
+			if (cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST))
+				bhi_mitigation = BHI_MITIGATION_FULL;
+			else
+				bhi_mitigation = BHI_MITIGATION_SYSCALL;
+		} else if (cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST))
+			bhi_mitigation = BHI_MITIGATION_VMEXIT;
+		else
+			bhi_mitigation = BHI_MITIGATION_OFF;
+	}
 }
 
 static void __init bhi_apply_mitigation(void)
@@ -1933,15 +1943,19 @@ static void __init bhi_apply_mitigation(void)
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
-	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
-		pr_info("Spectre BHI mitigation: SW BHB clearing on VM exit only\n");
+	/* Mitigate KVM if guest->host protection is desired */
+	if (bhi_mitigation == BHI_MITIGATION_FULL ||
+	    bhi_mitigation == BHI_MITIGATION_VMEXIT) {
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
-		return;
+		pr_info("Spectre BHI mitigation: SW BHB clearing on VM exit\n");
 	}
 
-	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and VM exit\n");
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+	/* Mitigate syscalls if user->kernel protection is desired */
+	if (bhi_mitigation == BHI_MITIGATION_FULL ||
+	    bhi_mitigation == BHI_MITIGATION_SYSCALL) {
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
+		pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
+	}
 }
 
 static void __init spectre_v2_select_mitigation(void)
-- 
2.34.1


