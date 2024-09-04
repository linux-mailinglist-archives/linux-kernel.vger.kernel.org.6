Return-Path: <linux-kernel+bounces-315372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16096C1BF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0121F22A83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977501DCB01;
	Wed,  4 Sep 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C6Muc5j+"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA60DDCD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462447; cv=fail; b=g8CJRr3IwD0OM00ykSPGjT3hFobX9EGun0IGHa11RQpv70FnToKWrkwQ+gD5JsNJsUQQ2oADbikB7aBYc7rpmphTZ1xaAOA5AqprENQ6RIqSH04sgTcCdqgU5HQkktzDIZR0w2SzUXoaIK7mAELLzE6fvYcZBRql6kNE7YizSY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462447; c=relaxed/simple;
	bh=wgQ4jpCDvtLmRSAsKTAV8P8bfz1ta9yU7pz2c8lCAZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tho3w4rtulYYrO2moPOARjc16yycK2H49ELFoxQuvZmV7Vy9o+7qpUtpqk/rWU7Gwqq1IfdZS98xurRs+Q2nJD426BXFsXeQlvlYNAqlPj2oPvtvv7NHCNg+Al7WAs9/fsejaxXjTgpJrVxrrdEV2Gpx9VZz7N/GnzluXBXVn/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C6Muc5j+; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYsDs6GkaEM01cy+m6tJMrYXBusyhddfnQv/mYh+wxQl7T7+aoIEHNgLv7A2YuZcD2JJOr1WllIdkdyxc3BrQlIl267ZEqmlgpNFNo1lvvSgzJ6Jzck3p4Zk5hF68HebxS5od25YPJc4GSCI1v0kbb5QuG7J/+ikKbZkUi0XYugG+vb45t38bm2PZ9lbMJrd0PN5fxXL9jN1h2JhNt4qf/d78ulOlc3EvyUImLSsLW6TyDa/HOI4hzGIZmhGzF7KvQgRGSei1+yFELbHrk8//60qjn0NL4eNDxixa1lWNR7h9y5vJvn2auPT16P5SXT98nYzfbVucsSNKLJ01Jr9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+C3Q6g88NRdLVdBqWfiv7kMsP4cnVn6VDpBzFQzl/9w=;
 b=rWrD2j/eBVNlxqZz3RUXUBi39t5k6sZj15an7bb4uaWLLBvdSgyIXq8SKiQZUzHGEGxlX9rclaNqbc0GGV4oMMR1/1EOmApnsT3ptbAZHcVged0KJqg0vRuVy7en+GdjKXPgGbm5HPGLSZMgpAltUwMwoDngnImk2UCM37TBQSeq/WDjiH+YYgRIN7e6aYrmfZFHwcHIPa/YaZ0KaiPNm2EBaaA2l2fFdm6QCtsl64CjlD9B7ngCmpiQD/xubqkVlaxvWkDAC66WruiYSYKTB5OLORYTwgB32j1tIZxMNI7ikd0ndt4OEO4kvpOjR9ykCO2tlQCKebWbSFrY6nL7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+C3Q6g88NRdLVdBqWfiv7kMsP4cnVn6VDpBzFQzl/9w=;
 b=C6Muc5j+PwOf8/Qe6PngBnGjn9FYM3aNqxZHUde9HSCCr47oBLDHMiHA0IBDMdqB6+DPwaSFe3cutvFMpF64vEnmG4AGb7Z6R/ap29EyJEPaiI+6uj2JsLQoXTFOtkYCFHXkGlJj23THpuLKKtcuMtVlPL8Uo47Vrz0dn3Zf9Ug=
Received: from CH5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:1f4::14)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:07:21 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::f2) by CH5PR04CA0021.outlook.office365.com
 (2603:10b6:610:1f4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 15:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:07:21 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 10:07:20 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/bugs: Fix handling when srso mitigation is disabled
Date: Wed, 4 Sep 2024 10:07:11 -0500
Message-ID: <20240904150711.193022-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 777815de-8e40-4d55-35f4-08dcccf3469b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?26Aq9u5r0U/GFSEkd+dI/Kh45TLT2Q5kAvlnsXdl2TrlY+nmUsnzrLVM6MS/?=
 =?us-ascii?Q?zJohL/LuMHodWyZHO2Qtbnj4CjnIehfCSU3RBn5zC/YQ8a7g7TnRaHDbve5Q?=
 =?us-ascii?Q?Ti3x6BBhsCRixDWzwG3gJGj5WZCR/3yAE8fdvwNOz0E0mQmKg/66u9U8ufPQ?=
 =?us-ascii?Q?ouxWje5bkPTRmKikjLcFJSWhtN6tXKQJASlEc1soYajCzLmtlm1vwg1uKQ9i?=
 =?us-ascii?Q?oOlCEfRTkObwUPmsRdF4Jr/IHkhMdovU9UJbVkBrcGC1/6rChjoIDgYBsXGO?=
 =?us-ascii?Q?bFRj8Vm+QtmuTC5lM4hz2N13juxVZppzoOZhnD+JVfsHcIjUdg6g8yBukvDt?=
 =?us-ascii?Q?PS9+PsBccnjkUPRmV1wUJ3fV1uaew0Ac4J3ZDkiPbPAYFOd0pHw6Aw1bJKNS?=
 =?us-ascii?Q?x1ZN3QHjjhoZzAONIQLXMvS3YvNL6s/xbpxYsX0jA7B7vwtDS9bsZrjNNVFD?=
 =?us-ascii?Q?vEDLpMgdzpI4cVhqwXxJNQv50Qqkv2/XlQaTHasaGBoaoXQD2hxO+DQkonyJ?=
 =?us-ascii?Q?itg5hdhNRfT3WLfl2+f8KhTiTj4BVTBGXU3pGrMWASizwf8oFuLrlUUyEqp0?=
 =?us-ascii?Q?/68PSfyO6k5b+/Yx7fFnR4cS5iHPFEY/DmrpUYj5gKXJkrtWDCtxQEj9317s?=
 =?us-ascii?Q?C2oeW50r/pvqgrG8evwF54ZJVwLp8jUK5UfcyoMf+ISQwNJ54thqviR7exHO?=
 =?us-ascii?Q?J2r3NE30P0RVhL3jjswnVrOspH3n9lcNA/fj5SJ2tE9WK4388r2XP04iCVXT?=
 =?us-ascii?Q?NFdcVd0MbLBqXZSQl0okqbM7CCynAOa1CfHIGgZydPxFg/uF1Re9il3JO+pQ?=
 =?us-ascii?Q?SswoCY+pYzA9cWi+IKAMrdHTaDc4SVwNQmkN0cB7Cjn++N6k4LbkmwjXns6+?=
 =?us-ascii?Q?u2FQjYuCu1KMCBdeIPhGIQwlBxk67W7bOznvGjnM6il+0uwEhKV0xAz03GTN?=
 =?us-ascii?Q?wvb8gAOk67CT5Cy25Sbf+yvG0U3kQ58gUOXlXNrrIg4cj9Nm7edS77W/Pc34?=
 =?us-ascii?Q?vdJ+RpVKbCKnavrmcjlfGHPiLjY5HCYOe3jlUmFTnwkPYKuCwcHTtNMcwr6h?=
 =?us-ascii?Q?OMTOQHAxkYjuuzIIff5LBuGUVATtFvrkjJkVcA4rK/6N6+QGhlWZbm6XwoVn?=
 =?us-ascii?Q?VwDytjTaydV3hwD1f/JkHAQdjURk0TFc4G8ZBmp+W3RpKquuzMDxqUhG1kym?=
 =?us-ascii?Q?emrfLzw7nPMifpjcONmtnXmUUScQ8whVK3C6Cjn00Pxyj3xQPDNRZXa3osI0?=
 =?us-ascii?Q?AhOF63IzftSWvbaU91jEZO+E9kJmzMYNFzcr+0NiLQcADa8/7Ns7PoRwRG49?=
 =?us-ascii?Q?WRiaMJ5h1WwiS6mbgzeAFXXX2QyVOVIAiL3iQ13n/BARmV8D3fcU6tU9f4uE?=
 =?us-ascii?Q?9Phr2fs36Yo8mxMtcrFM0nr36DSaHz1fHY3x4pphEQiw+8tfvnVto106iFEM?=
 =?us-ascii?Q?sj0Yg32rGVK2hICy2fGCrnc26mVaxeGD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:07:21.2370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 777815de-8e40-4d55-35f4-08dcccf3469b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553

When the srso mitigation is disabled, either via mitigations=off or
spec_rstack_overflow=off, SBPB should be used instead of IBPB if
possible.  Additionally, move the check earlier in the function so no
warning is printed about the lack of IBPB-enhancing microcode since the
user has turned off the mitigation.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 189840db2f8d..10d0775e7aa5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2557,10 +2557,9 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (cpu_mitigations_off())
-		return;
-
-	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
+	     cpu_mitigations_off() ||
+	     srso_cmd == SRSO_CMD_OFF) {
 		if (boot_cpu_has(X86_FEATURE_SBPB))
 			x86_pred_cmd = PRED_CMD_SBPB;
 		return;
@@ -2591,11 +2590,6 @@ static void __init srso_select_mitigation(void)
 	}
 
 	switch (srso_cmd) {
-	case SRSO_CMD_OFF:
-		if (boot_cpu_has(X86_FEATURE_SBPB))
-			x86_pred_cmd = PRED_CMD_SBPB;
-		return;
-
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
 			srso_mitigation = SRSO_MITIGATION_MICROCODE;
@@ -2649,6 +2643,8 @@ static void __init srso_select_mitigation(void)
 			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
                 }
 		break;
+	default:
+		break;
 	}
 
 out:
-- 
2.34.1


