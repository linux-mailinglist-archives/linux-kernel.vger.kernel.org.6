Return-Path: <linux-kernel+bounces-554710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9319A59B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5167A56DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE67242906;
	Mon, 10 Mar 2025 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fv9kbyao"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49A923F387
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624878; cv=fail; b=C2WgJ+zZ9IjYXlTLoEHDlWQilneT8JJw5LPonl3/ukWY70pYDfMAU4i7vJFvH0kE4H+5oiQdSoq/NmOzScYA/KWYvDDc1ZpLbNxDC1oUm7B1bY0I6IErQO78jt0XGtTOCmO7W3qgusWySrknshzkNi+AUlf7F2UfE1flXf84Baw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624878; c=relaxed/simple;
	bh=/T/sA+MY98hjm3OGlVdiO1pYozwb4VswMVGWNEKHQy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsMhTWBNYJhOt95SXvgVQTtfv9P70lon+Er3uLZYGkALXCwuqRtM5+Q3g0DLKkDDIGGnsI2RqAB8q3tLmdMgS/9adO2CMvUgFkYkn4o5uJPJIe1Sdr/OAM1XgBDaG7KwC7NeECVdhsK61uBJZU2gP0RHyjr4IN+gooX5CYo5cmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fv9kbyao; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtUfnq7yzbVOH1BxxogQUvpa4+bP/flhjqiaZvwC75kKHUthP5ldOYPgmsxevBzscjlOtGG9sL7C2NJv/WUhfgzp7KGm8wn0J5yv0+B6vWtl+Jftd46cyOIiGv16zj81OyPc5Zz83UHCduKcIabE+RAjH8100N6+HnJIg8RzF2JFSa4wDASAnMh7IeWpJHLTLd61lkVq3RnAYIgQZXFKpyAtqrP5JO5SWxRDOkDA8JsaWaFqx97ixqoZ9zI3KPbG+78bTuv2pumzJ2v5+C7XHiMVtgPe8nKempO87Sss/k/CxGFRooNzhkUBu1Fj6nB2omHC6RqMInJelYrXwprSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzY7lei3myX9iNqa4UvZSSvztf2qd4T5w/8a/kP7Hvo=;
 b=DlI6mE9zcQwLqdwFb8tH/7eBfD97nFXF4lywL9Z1v0xhoterf9sOHKLTvlyzct4It4GyNs9UfiqE+QRv7Eh+9RKCSZJKUwQ99HxX2Bu6mSVDx125wJbXIFMSSYvhPeqGp+R2aWZjw+Vi7dplCUj+IaOi9kIYWckPTorBb7naCLvjKAJDqORCpCOjwYQtYtaGUjASy/9z1MvY9wYao8+VGygfHBqIOhz8BVoxxBOwnFqQMaRRoUlgfJkzHnix8xaUwNHUSabDYbTXqgfE28MTyRVCu9mP49S8LLbe/s3cZi/GrFfRfvfCyF/rV3EnlkBIyDB/enFmO9g0YR9KKcXIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzY7lei3myX9iNqa4UvZSSvztf2qd4T5w/8a/kP7Hvo=;
 b=fv9kbyaoDBNt5DPQwSriSZ4LVc8crsksPk6rE5P8hQop9Euk+uGkFXkyrbMnmsYvZdMzC5vvvIumm1hmCAncSVqJMxyXP1xT4SkbCUpPZ3FWg+ha9cGFbw2o8u4iTMGkyUou/SWnvldiqiejhlf/c9JucWvnK3AcR/hjLn12bjI=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:41:10 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::f8) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:10 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:08 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 33/36] x86/bugs: Add attack vector controls for srso
Date: Mon, 10 Mar 2025 11:40:20 -0500
Message-ID: <20250310164023.779191-34-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: c96d2b93-3734-40dc-1a98-08dd5ff25cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dFZOgG/yE2aXFVAVTg4s4XrSsybYLfSWcaauJ704dym3M+Ux3ygPCj13IQkX?=
 =?us-ascii?Q?0p0eNrLRKggfa5qe0FmKWiPXwvA5yjdVA/pjh3j34txryrNbGwPcVzbQF6ON?=
 =?us-ascii?Q?tFwVV5QVXZTW7aQvCHeY90z1/2gnzP4GnUahX5pu95jjCi0JZoSjrfVDOmvM?=
 =?us-ascii?Q?9wGQ0hIBdYSh5K9M0VDZvgLSPNY9jFW/VCIb6hnmHkD43TC+kyChzICI1lPr?=
 =?us-ascii?Q?lARvDROQbhTGb+TuramMbUBCxgJmItfRtSB2fY0mAeap5p3LCKz5iviQesCp?=
 =?us-ascii?Q?AP4Ui153EGkRk3DU7i8ScQP7ar52//fErET7kF62LqcUEVH1DnExeQkjt2er?=
 =?us-ascii?Q?hpGQN/z8dFYk4w9xVfbQKs6hf+G0Nk48XN/VjoL1Z4qfs2cvYysUl1xPW6mm?=
 =?us-ascii?Q?rxXVgaMXEu33UQCAg7zVeTa0oSGpZxDnE7oGXiuHa7l3pWlcsaCxebdP1RLK?=
 =?us-ascii?Q?xsl3Afr6QGZi9LDFYoWOX/popvbvNojdBll2n8ZdXDwvjRzetmxlvlBREDcB?=
 =?us-ascii?Q?aIfleouTyBjOaiiWgxsFZZywTSQnNPQP+ynNw6O/5cYBGYWHubf79sHabKga?=
 =?us-ascii?Q?P93sGqf3FHZyYwnK1KmZ+ihcLaACfmU/okQcHQVzbhzM1PtWfpOGCopKxHij?=
 =?us-ascii?Q?0PGo74F6MTtIFmk3FThpQo7NHI2J5JaR2Io7m+n41na2YjQ6yssFoaGUu51Y?=
 =?us-ascii?Q?gfhgvR5PLE+72A4dNwG9tvm/qrW02qq4TmUaFwej9i9K+q/G/Kmcud94mkuq?=
 =?us-ascii?Q?K5JdCp9ouZVh5JR3JGul91Y0YhtTJN2SFpKMonPasHNf8XlMRMOOLv3IIFDX?=
 =?us-ascii?Q?pvj4BgnBGXvsxP7NvrSFe4N8uHfzcInO91/iNGoLboHZY9cp9TaJfiFjpy8h?=
 =?us-ascii?Q?81WEDE/cpSuRdo+Pw4QyqExUNNsqnlpAHn1iz26/+4sinreuLZJ6s6weoVBu?=
 =?us-ascii?Q?pkC75DPIVKKM/XrBoVPFgJQVGg1wsfGoDTv0gu47X1pknIK52nY8Er7sxbup?=
 =?us-ascii?Q?Uj4/KzI+YznqtespCkA5ZRaqoIpV+iAAPbDh8QD+2Tjv5KcFjZBRPI9tL+wN?=
 =?us-ascii?Q?6h2pwcR5NKXNWNRu6zlB4zc4wlk8huuQo9nxah0mHzL53CCiuHCiPbL2W+DU?=
 =?us-ascii?Q?oI4p9nBJKbXcobloMKh3lRGLTvXzVenA07zBb06MH3sUYhXiSv7h49neRzFi?=
 =?us-ascii?Q?qTW+uq2CQl7pERD4GcK+pDMQgy2/M/qETsKoJ6XDQrpL91FHY2DTuBKveQgs?=
 =?us-ascii?Q?CIjTGn8G3hM3hEAJvw7a1RTaLcAtX6INiOmgL8Yi6fwo1Sp+96zMMI7HpHRY?=
 =?us-ascii?Q?IAl8xQTNiARM/a2bEGxoHBQSzaHPL7FavyIHnvsWclAprSS0SvxfvGtXilOK?=
 =?us-ascii?Q?lPEsMIP7qf+CZJPlxKPaYzQhaEthVkBrXzaXOQLYn7OGho4E7BzjABB7Ih1f?=
 =?us-ascii?Q?gDKVOx8ub0j78Vltml/ebytuQLJGLRyXxeqKd3OPPYek2HZ3v/vMit9I1p6j?=
 =?us-ascii?Q?Sde0DEXcJJFJVP8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:10.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96d2b93-3734-40dc-1a98-08dd5ff25cea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789

Use attack vector controls to determine if srso mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e38529f3022b..4e1fc1468870 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2858,14 +2858,19 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
 		srso_mitigation = SRSO_MITIGATION_NONE;
-
-	if (srso_mitigation == SRSO_MITIGATION_NONE)
 		return;
+	}
 
-	if (srso_mitigation == SRSO_MITIGATION_AUTO)
-		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+	if (srso_mitigation == SRSO_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_SRSO))
+			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+		else {
+			srso_mitigation = SRSO_MITIGATION_NONE;
+			return;
+		}
+	}
 
 	if (has_microcode) {
 		/*
@@ -2921,7 +2926,7 @@ static void __init srso_update_mitigation(void)
 	    boot_cpu_has(X86_FEATURE_IBPB_BRTYPE))
 		srso_mitigation = SRSO_MITIGATION_IBPB;
 
-	if (boot_cpu_has_bug(X86_BUG_SRSO) && !cpu_mitigations_off())
+	if (boot_cpu_has_bug(X86_BUG_SRSO))
 		pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 
-- 
2.34.1


