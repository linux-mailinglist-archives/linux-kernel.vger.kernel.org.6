Return-Path: <linux-kernel+bounces-554698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59739A59B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062C63A1168
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8F23BCF8;
	Mon, 10 Mar 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I3UOWHNn"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B0A23A985
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624867; cv=fail; b=EB47jW0r06XuYkJmGJPnYaWzhI2/7Mr8rYErHOYIvttgSqqGgasPDWcRtFb2fEfa2bdijW+MKr+Fvjku0bgXKs7JO/Z1EQmW4cQAMryQ6IgDmQVfSgJb5+DHsV/vEGnKspO95Kf2Uz8NEU/Tr8h306mBo3eFpdrz4eJcFo6+u54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624867; c=relaxed/simple;
	bh=GM3r+6M/mkcD00bFOWlBoJUOTEM2bcASUGkZEYnkblA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q95N0d5pjSYTv+OXwZUA3S1N4IrjMu8Q9N3TADDR5fIQ9mSh285vt5aQX6LvtwbZ2F8Xvs+l7EMXtNpAxDih5FUGPcxZ7JMg5HOzvkYBdi2AcGk6wkfeOhHBW6tcSAVFw5csry91FTRU1+7JkdDBhvVh9oIe4ipTCUQLe5mLdmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I3UOWHNn; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUgvXrPh2LoBxWM0WaeY1pm/F+DI7SrLT2qm3nuhca+DbTLnJQB9r1LrsGxafC+/cUtAOlkXSZWhXTT7PoZN0QJuhOG+0+UVuyoEOBc9rAOTbH1/CeO3KHBrcX+3YRRFObzObjPN+T6lnaNuZ17pVkxWsQuANm1lZHbtRb+IXw7uWp5IDJdre/6Kt+NI/79TDk14LAtkzZiwvcR+maeK43NMgywj+zqGUmk2VZQhgQK1C3on86vDgyAdJXJu5uo9kmhs+ITagQzuxdE1lYyNetxTZWo/U6fvq4IBkue7r0/C6fv1RKrBukNLBldK1ooPVBHVnAezvM8rD0QvTJ26IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqVMF0pcH9VH98iRHNmu5Clr8XzWbGv++L4f27a2Rxg=;
 b=vHOEFgMSpVRvF3UlpS1Gdpnf6EhC1vpTIH+jHdB1cxD90jg231vkLHQa8TrJ9X7Xjq8b1pfWpv/XQSiOQMcTP6DatHFggukv8NweVeziAXRObfZoVtO8Wx4c+hpustbrjElwUMZG+bXCmXHK623hPPSRy4oom5VQDM8iiEbxieXWvjjuDqQIfx+iBKUKn2vtEq9LMJElyU4CQaKHMPuOQQJDYFAOSCyzzTcqeXUXvAv8SYRagJlj0MYarESVb2fWBw06rldXbRe/tAtBYjj+PIEIaTm8SSzUzcFuUgxGyCgLJGjG5tgr7IolBWgajXHg2wxensYF3ijv7FECLehZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqVMF0pcH9VH98iRHNmu5Clr8XzWbGv++L4f27a2Rxg=;
 b=I3UOWHNnAs22yM2EDigk7pnARGF5sv1EI3MRC9nNdgFrRhtns1+1kF/upaMeqMRvw4cf6Ar9PMSWLdJ0uCkPn4FMOtTwXUB4sZZlQSXVJydPl0KaX7Tyu3n6oj3mC+7726scONuYtojo3qwAHSPh40i+k8IvFWI8eQqWSAXMrPU=
Received: from BN9PR03CA0078.namprd03.prod.outlook.com (2603:10b6:408:fc::23)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:41:00 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::38) by BN9PR03CA0078.outlook.office365.com
 (2603:10b6:408:fc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Mon,
 10 Mar 2025 16:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:59 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:57 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 23/36] x86/bugs: Add attack vector controls for mmio
Date: Mon, 10 Mar 2025 11:40:10 -0500
Message-ID: <20250310164023.779191-24-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 360be2de-f263-4aeb-c427-08dd5ff256bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e7R0dopvQKu2VZFtCcbb7Lf0lR+tznHa3IZF9pLccW+7YDbNk5dReup7+ENX?=
 =?us-ascii?Q?CO0ywO4TyksUigF42G88hEV8HpyXsqGqJQAxdssT+Kf/B0vAMWEIfIVn0Dea?=
 =?us-ascii?Q?1urZiQvLqnIcu0mliFr6UVXRF/qE2GNRZe8c/yfoTcTCMgIbch4AdHlMLJuR?=
 =?us-ascii?Q?TKJ6+zihUalcauTFDJSFgZS13GmGFYigq67GI2vOAZsFGTTHPo3OZ9e/+fIU?=
 =?us-ascii?Q?5RX4S/Jk7syMxdoJzs8VNS3KdLSbIEhwjElF+0PeOoazWXV7KjkE5f+mWT3m?=
 =?us-ascii?Q?u6zfQHLFSsy6EtyRGD+EIG5j7un1mKwicx7cpu+RemRc8U/iNObCXWhDX4bC?=
 =?us-ascii?Q?C5M+FNUJqdoNUe5inf6zN2RSQUgs6lvr6ZYDjMtlccxXdUwmHsNPkACwQLYa?=
 =?us-ascii?Q?SJgE1pwqMutas9xZ6s+YM+h6wnqOcDdEGzHp3oV8CkJD/fmfMEHsEhbkoQYD?=
 =?us-ascii?Q?kKf7np4XwFIIIxQIgJR/njFxSyGWxUhNUIO5faAWfm0HNkfGtdL45wQH1bbm?=
 =?us-ascii?Q?dlAFKzLkGJ5UCQ746esxIpIJiXOCo4maPIfdwOTLFHpp6leRSCYNNo2MeC+k?=
 =?us-ascii?Q?DZl/hWkHMo9WV9H+T+F1rBN91WW9dG0nYuEDvx3cksRWO0+BxaF5RK8/g1Mh?=
 =?us-ascii?Q?Evir0gYZ9Qo63PT14k+tuBdGTeVb7zF9MoyBXRMbcO7MGbJIdoyNGNXMBXIk?=
 =?us-ascii?Q?oUmszoqqPs2kP7jSEXbSt0Sd3EEQ3j6atISjh+TzPuxtkc1SbmQl2U871Utd?=
 =?us-ascii?Q?+IJws7yliYy/GwkRmqpMtUhrxHrJgT3ZrEYgml3COTvEK0RflzKNpn7eMo4y?=
 =?us-ascii?Q?Gywy6R11iSEygAK3NFgEETr8/I4ZLg9IKREin+AFwa3JjbG6KpEt5ioJBMT0?=
 =?us-ascii?Q?38X98jSQFI+gxMK2YuUhp73UL0esUwCVlGjirarcDXIEjPKr5g1yZZSkJO/x?=
 =?us-ascii?Q?GOcW6cMaBTeqM55RDscLqEO9Zp/ImDs3QN6A7X74LMHRLcPRa0DQ4swMXnfY?=
 =?us-ascii?Q?nrKruDyc3utA5lwf0f5dViA3LFOLzpavAGxFh3G/3zpiY+7MY95PSuCYB8dP?=
 =?us-ascii?Q?lOiq1ArfM5OUXfmNjzuu57acT2U522/mS6VXEHOkcEgQuSnHlc6kljxTYrHb?=
 =?us-ascii?Q?1tsxUwe28+z1Mznxl3pCmXDRNufPOwOn2SmPwaizhxPIW3d84E6qwaDX5O9F?=
 =?us-ascii?Q?6wzKFVAd+o+u/fDH1UkChHc+plJN9rXYm2yjbzRcmoMXOi6eQCIvgOQFdSa6?=
 =?us-ascii?Q?bWXssItZFdGCTKLVmnwvB1Y5JgNbBWVoGvF9VmV7cL3tU7TEA9LAjFfE5XtQ?=
 =?us-ascii?Q?RtJCGHBJ6f2/8uIvkO/zSuNqIvTeotmhs71IQoKg2GWxbYdAHU2VyTvTxMRn?=
 =?us-ascii?Q?8sW5SID2I8nwnrOiRq4tM7+THRZi6baswXrG4pjlhSxgqa5IuImsaCvu8b1W?=
 =?us-ascii?Q?Ozo/omkiGLTMoyKo8/cSiNEBvz6LXbDNONSJCzRNLE46e3WyHlHMEY9+i9BR?=
 =?us-ascii?Q?ulesBix8PGL+qro=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:59.8142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360be2de-f263-4aeb-c427-08dd5ff256bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277

Use attack vectors controls to determine if mmio mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 56d3bf343d1f..ba7c2a1ea98f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -595,15 +595,21 @@ static const char * const mmio_strings[] = {
 static void __init mmio_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
-	     cpu_mitigations_off()) {
+	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN)) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
 	}
 
 	/* Microcode will be checked in mmio_update_mitigation(). */
-	if (mmio_mitigation == MMIO_MITIGATION_AUTO)
-		mmio_mitigation = MMIO_MITIGATION_VERW;
+	if (mmio_mitigation == MMIO_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_MMIO_STALE_DATA))
+			mmio_mitigation = MMIO_MITIGATION_VERW;
+		else
+			mmio_mitigation = MMIO_MITIGATION_OFF;
+	}
+
+	if (mmio_mitigation == MMIO_MITIGATION_OFF)
+		return;
 
 	/*
 	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
@@ -615,7 +621,7 @@ static void __init mmio_select_mitigation(void)
 
 static void __init mmio_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		return;
 
 	if (verw_mitigation_selected)
@@ -665,7 +671,7 @@ static void __init mmio_apply_mitigation(void)
 	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
-	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
+	if (mmio_nosmt || smt_mitigations == SMT_MITIGATIONS_ON)
 		cpu_smt_disable(false);
 }
 
-- 
2.34.1


