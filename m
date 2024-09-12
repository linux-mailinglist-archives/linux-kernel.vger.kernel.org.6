Return-Path: <linux-kernel+bounces-327128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D96977121
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1225F1C23686
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335911C2333;
	Thu, 12 Sep 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lBz1fRHX"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B811C1AA5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168163; cv=fail; b=WuEtRnIje7jFa6YhjuQgm/PxciXXXMc6Z0irD5hY6zE0GcmtF4fVAuxqrn10IFHY+ip35zL3LamnGmJ3zCosvJsmhD6LdQo81wYa1pk14TnHYu5yMJW/IDhSeYfP7mtUlHrD9srSEe3vDUQY0jkzRADF0dFLu+6y5EUv8i20p3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168163; c=relaxed/simple;
	bh=iRy2qFPJGfKjRDuZC57rer0ZVyBYXlLEKqyYViQWGtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+p1Y8iaeoUbMQ+YUd20dm6vY7TUBqf1DuvpIl7n25nISoQe/kAYZCySGwSUlU1VJRrjd1RSbKOHIhNfLZ/Kz6vd3DmugUbT2IPoUVt5aQ3XYEZkbAVgkSjtKj6p7Xq1bS6qep30/fISFm1KGhGOj/1TGNeQDBN4Pg9nN6ra4kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lBz1fRHX; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0A8/geQl4vxStk8cswJB2ohWPBir6FzbHHvlQgb95rvxOy7lYv2rZ7U/dFCnTHFXY24LqU8N4wh9NET5KfHZeHv8u2/KsmbLGXFafJsRRXHXPFsVz0Ayklvlu44Hd5oozAhqm5NpMi4fyzPAnvJjfE+v4EzQW1NOzFJRLR2n2Eb4m0Ahdp2meDSOKA6lNGhwZ3wRTSL9vYL8CMGzZ3HK6ZZDyYfPWuNq/6260U4GSf0kp69lgi8imsEGhJrzt8M257mEn+ccraP2l1pndrCBtHWWEOBGmDFDBHay+zXE5mxWNREstEXNtjXuryoMJIcpsp73Ri4qYT+TAm/0cJA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg4Qrf31H9I93CZr/JdLWWzFjg6g7M5UID+InX2Su+k=;
 b=jfAe9DTcxl6V3hg0jo/pVYVOt1aI+fIqypmjH+o1NeoYt717K7SvAOPn6DgqQDlkbEXXPcan0Gx8fePBZG3XUp5A4cy/71mcqgILP26q+iZpSCpTixGIYnxXzSWFNy6Tp1I3AT+5K5Ug6VLs6XIyQpOWkVKSpH7OwHBfl7SDbo1oqXWZodcOqM0HYFoK97/HsTLE3l/Znlx/1HNOANuug5jOgjomTf1fyjpNWTbc3yfqWZF6M8N7K0DdGMh/diml27YSSRKx7Ca39rHT0mCkUjFFXxBqjX5UPpOqglaF5FKCzlgtGm0utGFaMAxlo0u8hA4X5mpXyVeKEoJdtr75+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg4Qrf31H9I93CZr/JdLWWzFjg6g7M5UID+InX2Su+k=;
 b=lBz1fRHXhKBp3YFJ9Qp8Q9z4TvQOQLGLzo9rsPFwY/rXyU8kmNRESKDfiS3HbkenuMxxbb0Ls8O5rhMBq0Du98sHYq3qsdmzOYpWk2aA1qTSpK1+BVTFddjdqIVV2UijnIhfO2NoahRZJsMITgQFHTjUKRQxtkFb186Zm8W/3nk=
Received: from BY3PR10CA0010.namprd10.prod.outlook.com (2603:10b6:a03:255::15)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Thu, 12 Sep
 2024 19:09:16 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::e6) by BY3PR10CA0010.outlook.office365.com
 (2603:10b6:a03:255::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:15 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:11 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 06/34] x86/bugs: Restructure rfds mitigation
Date: Thu, 12 Sep 2024 14:08:29 -0500
Message-ID: <20240912190857.235849-7-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912190857.235849-1-david.kaplan@amd.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a62bd13-b58b-4537-4d15-08dcd35e654a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6JYqRWQrNhjCjk9ghfV63bzi25F+ovd9W25BRmu+Cko3jUgNmctduh1+Y4N?=
 =?us-ascii?Q?7ofMqWWiUUhjHbM+en8johoMvEcJLL8WwwgKIKBOVCoRVx47F5C4ROephmdK?=
 =?us-ascii?Q?iCbizZB9611O3vPplZgMyrh/junJIgwLIr8OunRPvOgcI0j3kPfMf7YD7NhD?=
 =?us-ascii?Q?MedM5kOU4a55oOuoLD4d01idHGkHF2oUgjiarAg+OGQCc5T0P/uP9+khDHw3?=
 =?us-ascii?Q?Awm9ZxLuup/9CgaivK7N81g0RElyWWiyHTJDt4QeCaobJJS8RMGYfVnfgTiU?=
 =?us-ascii?Q?kUa4/1W8h9iyLoURPxQ03zSuMqU//CInRT9gcXbzu255lERwgdPM0hVFtYyX?=
 =?us-ascii?Q?BmHjawypWK9JOq+oXRShnxyt0b44OpCQ8R75/NfdpX8XOlgQVzImqYIMBaoe?=
 =?us-ascii?Q?KVSi1ilV75xCG4yW9mR1pGa80rFoe/Rd5VluJdfr6bP1xKpNKR0h8WyvKojO?=
 =?us-ascii?Q?/pBFjwzGjaFDG7wLnL5HO1D6iIItgd9rPfSAqlD1uFdAUJROVvr8AkStatlA?=
 =?us-ascii?Q?9HA0Dly/7qQYbwE3+BA12sDhXiHKDHKAsV1yVtQ76PH1GAF3o5HHnt+Y3Ua+?=
 =?us-ascii?Q?TA6uUV4dSOBkgW5W5RrH2uKaznanjyX/i3yFZyXcE4iK57t80r22FbdyjKxD?=
 =?us-ascii?Q?lQX2EiNHTKS+iazdB6+Mrsywu7T1xb/Eqxr10IT1FrDPUpyVVK17ORfiHfqL?=
 =?us-ascii?Q?eu48qs3Gfab8pG8PCLA4tOsS0oDVaBmMNmj+dIilOph+Gk0I9skpzI+tI/X4?=
 =?us-ascii?Q?BLx8L9FUoNyZ1xwua4cnBqKP8zUM6d7LzEaRQXNC4ra6MSQoRtyG5nIyfq8y?=
 =?us-ascii?Q?ijCjpBGpOWj/5Fbh+oIErQSp5d5tvA9iDQFbpzMHca+2jxax00PoMg2JWUSJ?=
 =?us-ascii?Q?Hb+p8buhnO9JG3v3sw6gx741lTckdgSGqxTBn5HRkJIx+bj1/vdTL3qPsJh+?=
 =?us-ascii?Q?va919lG2KxvWIccXM+BSSQM3S1N++dYQJiXBmVUQ7itav3TKGsvzHdbythdD?=
 =?us-ascii?Q?j1z50EJTC08RZltgwjDvnIQ0PmFwiD7wjJuX6pKpc0DzDRzaSG8pTmnUchgV?=
 =?us-ascii?Q?Bt+R/YDsSFX5dvApulQQ2iz01xbi0X2szYTZkCRuJ4zo7bU+ldQ2+ZFLNCde?=
 =?us-ascii?Q?1+iEdNkTJfBzXfyjZ2HU5PPTwC77M7an6PVBXJ71G+VqO+bJm3xVZ1q895xR?=
 =?us-ascii?Q?bU9jzleAo8WcyXhEO5P3PBtFFlHDXAQ0Iox1qDuDvrEjgMsjuG+2Fbdc42cX?=
 =?us-ascii?Q?7KRnD/PUihA67o0lhT1Gb+kNMrySxBPxfU2UyfQSsBN/a07Wr2ex1vBzQ6q8?=
 =?us-ascii?Q?ub5BzDfH5Ge391dG9EuP1m9NpJBxBIZWYbhheRwkC3R90Vi3YXpDmrTIDMe5?=
 =?us-ascii?Q?UInYDqV8QNsg7SKKJuSDxoNOOJBSmFTYz5cTbrlQWYYLpE3wLH9A53luyFNY?=
 =?us-ascii?Q?2xt2POOGMJqg1F2KL2lhAwvgu+BnpSS+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:15.7959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a62bd13-b58b-4537-4d15-08dcd35e654a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846

Restructure rfds mitigation to use select/update/apply functions to
create consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0b93a0f030b7..d3e6ce7238e4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -70,6 +70,9 @@ static void __init taa_apply_mitigation(void);
 static void __init mmio_select_mitigation(void);
 static void __init mmio_update_mitigation(void);
 static void __init mmio_apply_mitigation(void);
+static void __init rfds_select_mitigation(void);
+static void __init rfds_update_mitigation(void);
+static void __init rfds_apply_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
@@ -193,6 +196,7 @@ void __init cpu_select_mitigations(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
+	rfds_select_mitigation();
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
@@ -211,10 +215,12 @@ void __init cpu_select_mitigations(void)
 	mds_update_mitigation();
 	taa_update_mitigation();
 	mmio_update_mitigation();
+	rfds_update_mitigation();
 
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
+	rfds_apply_mitigation();
 }
 
 /*
@@ -595,9 +601,6 @@ static int __init mmio_stale_data_parse_cmdline(char *str)
 }
 early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 
-#undef pr_fmt
-#define pr_fmt(fmt)	"Register File Data Sampling: " fmt
-
 static const char * const rfds_strings[] = {
 	[RFDS_MITIGATION_OFF]			= "Vulnerable",
 	[RFDS_MITIGATION_VERW]			= "Mitigation: Clear Register File",
@@ -613,12 +616,34 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
-	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
-	else
+	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
+	if (!(x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR))
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
 }
 
+static void __init rfds_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		return;
+
+	if (mds_mitigation != MDS_MITIGATION_OFF ||
+	    taa_mitigation != TAA_MITIGATION_OFF ||
+	    mmio_mitigation != MMIO_MITIGATION_OFF)
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
+	pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
+}
+
+static void __init rfds_apply_mitigation(void)
+{
+	if (rfds_mitigation == RFDS_MITIGATION_VERW) {
+		if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
+			setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	}
+}
+
 static __init int rfds_parse_cmdline(char *str)
 {
 	if (!str)
@@ -689,7 +714,6 @@ static void __init md_clear_update_mitigation(void)
 
 static void __init md_clear_select_mitigation(void)
 {
-	rfds_select_mitigation();
 
 	/*
 	 * As these mitigations are inter-related and rely on VERW instruction
-- 
2.34.1


