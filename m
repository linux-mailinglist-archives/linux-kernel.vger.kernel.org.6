Return-Path: <linux-kernel+bounces-227369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D69F91501A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12141C21A11
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F86E19AD87;
	Mon, 24 Jun 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MJMy2xVd"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315C19B59B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239872; cv=fail; b=eEHDrXItN2YYXHcjDw5WqVl5Eg4PQeypugou9Bsn0SfG7nPPsTjHnJVw0NF3IVbYbnBOVdXk/fCAuuRf256tbDf1UvP4xnj/5pRZmkfb/YTDcySWmLK1oiE2FbmJuaqbckiuUO7XcvtdFFArJNYdgaN/goVlwYJ0ja3yigZRtCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239872; c=relaxed/simple;
	bh=Mc2ee84SgFyDb0h0mo9ws6lpRDIQ9SiKwncvWwVdG1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qp4S9KzfjZKJ4Df135fOv+WPUfic00tKQWZ5+pqnBfRlN+G5gVJO8/ytRcDSNBE9ue2Tk2FiNQDBfL0txmlAj2dq91TB1jrN3vjbqN3jFlZ6VdOpMl1KBjDQFS0a/EEL7LZQLUj+0DqBZmrVuiG9dktzUy1HcQz5CcJfgXKX71o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MJMy2xVd; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwOI8iTolVqrYfDL+SWJ7xoRKm+zePfBU/AUT5fzyVZ+x8zAjzgRfYhXBSJd8pLKOl8R0foygZPqLvyeXGnU0cchlIVtdr0ldexmyCNs8OQRL8aB6eTfJJytmkAT4+ut0ERI6vv4zPV/JJOnlmcIyWWs5bfKex2KkLszvUSqMaeuw50sDIXmyehkZl1LavTA98FO19S5L3zn0g9TWoIT+/6y2649mji/J4r42qj4t7ps1NNCSy0A64TJ5R0PVZUCJ3Rj+Dl40GIBnjiyxHylxBynoifaEYckj9L5K/1iIhAe+JQY2WrmwCzJtJmhEWAiYmTJvgyWs1SXg4MhFavHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmU7o/twtIG9evYYle3zC8IweScf8S3r74TCCRZ1WIg=;
 b=EwrFDOeijM74ri8ySBiRoHF/WM9BrTGB/YkU99YcyPMm54KFAMN+h7XtIAVtL0YOS5h1i6p4NRK0sdiHEHdYgeXTEhn/xoOxPkJIqtoTNakP7OHLjfXkp6hrieeYXhmOiFbQlHQGXiKceVF6/zHEvNlsspcjtUbq/Lg+3KXBmd+2b+1aidK1FATru05JDhpy5mk0/P1RmC2i9oim/3G1NgubrSbP5WZfVoujywWBDFQLGuXEXNDmF80y7aOkDPTnlu3MJr06DbNKYUeBcq7u8XxqAxZUa8kAdymXmhpXYncRik4LRB0QnswivM/SYGZkP7UhdFCAQrt7wgd1pIZnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmU7o/twtIG9evYYle3zC8IweScf8S3r74TCCRZ1WIg=;
 b=MJMy2xVdc+Cv9u2a3rMtVbXrAqZDnAwOAb8/OuBowcWEhG4EN/b3qsoz7tpAHdcT7O1jeAJfskweyhuD3rd5xMV2BnBC3Un8nqL64F+KBsUBwslz7iSzfgageIINdNfsCnOgq96JEetmmyEHmvWZM59EyvbB9/lt5a1SfUCbqi4=
Received: from BL1PR13CA0338.namprd13.prod.outlook.com (2603:10b6:208:2c6::13)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 14:37:48 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::36) by BL1PR13CA0338.outlook.office365.com
 (2603:10b6:208:2c6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.17 via Frontend
 Transport; Mon, 24 Jun 2024 14:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:37:48 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:37:47 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 3/7] x86/sev: Require the RMPREAD instruction after Fam19h
Date: Mon, 24 Jun 2024 09:37:07 -0500
Message-ID: <cd70a5985855bfcbf1244f08dd78281f99f56616.1719239831.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1719239831.git.thomas.lendacky@amd.com>
References: <cover.1719239831.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d28000-cee4-4951-d387-08dc945b37fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kPmuAxGgf0TUHRVvS9aab9dkke4qHsTB6r2WAyKXGKYd91+WU/admahFPB+a?=
 =?us-ascii?Q?30OwUYJQ2TnBgYVlLoUURQaZHx6pWDxy6scCeZN2kd9IjbqqBn/wxwSCg9yQ?=
 =?us-ascii?Q?F3lY7hxjNQQINvkjVYBS4RE4cypE98Ns14LNwqafr4LMePM4VEEYC1dqhSAC?=
 =?us-ascii?Q?d9a0zUYHteODcR/A2V9z4QGZHgflpF+fCBj7LpLaGaPsdVLXPrrdWurOdn9f?=
 =?us-ascii?Q?B7M20g8hMe25r7VAjOhjLuxwpF+DvNE3HSj+VOCAhhImxP4/+fyjX8B2wxXW?=
 =?us-ascii?Q?WC2U1JEpdAJMmxjMwbhcIDIYFTq2sxksqTywzMhtaufXOqcCsuX6vZrYmnGw?=
 =?us-ascii?Q?OkpDdFMXKJcRcoSn1fpHBohECzd2ZRgHEz6UOLVhuZnHXf2q+Kr0hVZGf5qj?=
 =?us-ascii?Q?Wut1FtwPfbeEL4asmyBeWXgXeXvHh4U25y1aQH36iemAB3Mv4RAF2FEMZp4M?=
 =?us-ascii?Q?w8St0eQJQSv9jnw6DDI5IkTFhUMmAZexLG482QvcvBoebX91i0chFXvnYiCF?=
 =?us-ascii?Q?LOxH9+syVPKs1RMweHaSRW29dH93bE8ulj2eNvOJ1/oIKk3GscJPy1MZ7DP3?=
 =?us-ascii?Q?CflY4xzRy8YdFP899uMYW9chazuE9DWkN4uVWe4TwXCehMnuVY893CBzyUZx?=
 =?us-ascii?Q?jbWkv6XjB8/Zrr7nrd0MgY6FLEN9G2RHz8dverfKk/wHlpaOqP32jTi/rwQo?=
 =?us-ascii?Q?+UIRzUQr56l6U5+s4KZDhGhY/ubPBgkhI1mrIKq2ZSerDIIpFS6qnjRc78J5?=
 =?us-ascii?Q?hpR/BJuABQJwRw+6sF2kUEQQYnUriUqysbpq/ZQzmNV/TFhvCcDPLslBrrex?=
 =?us-ascii?Q?2/ZCInGA9lMeR0Zk/R1eHvlQ8S8th6XGNsWzI14LvEjDw1ndrMb0fhegN/Rf?=
 =?us-ascii?Q?AaNd6pqyBor65LAeShostmZCnKAbGdHNMQujc+H2S4p4l7Ujt7Qhkmw0E8q+?=
 =?us-ascii?Q?M6Re/wQ+mxAkBpUxgqHxc6U2wAjJWQei+gyIwpM10+9fdIsILDehrofZKRcw?=
 =?us-ascii?Q?FLyVPdY+W8b0vZ8ps57nRHCctLvX+nljxd/Ol3xvk7N9DWfHtNJyiVRUJ+xw?=
 =?us-ascii?Q?/ZWLCVMKU7xG9FoQMJ9jsP1+GpCy10Hc2pvHWCTmLmV0VbMTVfsuyEgehvOT?=
 =?us-ascii?Q?sqFkl7dMrd8nDFy+v2PVNa6kaiCWWnjtQYytdEcBTstjD6Fshk5J9h88qOdY?=
 =?us-ascii?Q?w0/popgT8fGNdn5uZvbGApBVfm5Daru6NzKuuALwnRpAP/oLYINBRtJlO7FK?=
 =?us-ascii?Q?kh9gd0PjJfRYTcGjnzDZz0pkZaddZv8p40bS2FbDx/p1IrmgjM2I3UGJhpRc?=
 =?us-ascii?Q?SmNZvQ2CkGiFPgtes7BVuC4lTOoO4iqL0roVsqdrZTETFe4I1TuNqvHKWQjH?=
 =?us-ascii?Q?aEte+P7Bo1GBUO1gbiFktFk8Jjmle8YLWeOP+yu8zYnwNUu3LA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:37:48.0990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d28000-cee4-4951-d387-08dc945b37fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396

Limit usage of the non-architectural RMP format to Fam19h processors.
The RMPREAD instruction, with its architecture defined output, is
available, and should be used, for RMP access beyond Fam19h.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index be5889bded49..0b39249640ee 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -358,7 +358,8 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
 		 * for which the RMP table entry format is currently defined for.
 		 */
 		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
-		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
+		    (c->x86 == 0x19 || cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
+		    snp_probe_rmptable_info()) {
 			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
 		} else {
 			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
-- 
2.43.2


