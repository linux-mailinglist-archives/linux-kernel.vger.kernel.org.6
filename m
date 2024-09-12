Return-Path: <linux-kernel+bounces-327155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2068E977142
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DD71F24D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C5B1CC170;
	Thu, 12 Sep 2024 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aIwXgtwR"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15601CB503
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168180; cv=fail; b=qpUkVNEp2r4DVEzhxA+LOZ12OXI1dfYnRmP7hiadFgZ0InUWIG8oKK5oLldU5v92DBmeJGsti6qJRBWQx4V5+DwsKLJFvLIdQEefbl5/p0SFeOe6agY1GeiPj5ggOoIWYhPPMrYpDBVzYmBUyI5GxYrBwpv32orUCLvCKzNLRPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168180; c=relaxed/simple;
	bh=pj0NHsjByCKYGkaOjxEVOlFpe2mrmL/tmrB2u9EA18c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXRAlfFYNF0rkvWwPrtEEUljdI+SBPsyRts8vDdWa/yHaAXnpaO4feQ4VBlM4iZY8x9z1fO6eb9hQMSOZL4IWVaXi5qBxFXAMB17KxquUT5IEo1g+D0ASHUilFvFXZhOxE0XAnUCBAr4mDrV1L7mvsbijPnMpBta7S1PbzShFfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aIwXgtwR; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vnvq6bDYVkU8EhW5QBOX9Y8+EnfrtsHQo4t+IwTxaGUQ250xFH35fM77KtCP8qUqDC/rar2Yt4198eu8bWIn/i5GZa3ZXUI9ytn8rAUZNGGjeuPnTfXiqdm98wasCeSq67LeNr3/KVRYDRKBKiws9su/b/Ji3LxbLCFB1NVMJJcWqbzFQ1fYiMlOn6itYvtnJr2ROFAujgLgdjXh+YzujkWzNdykqP4XkVewTzIV9xGxu/XEzYZALesVi5HnWj1z+K8yGzay2zPGlSG3jSLrOcjH6qGYeN6ZtUcrksPnF2WTLvmnZzUSfIErlcHudmhZLKqEMxXYJn0cgKIw3AeX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNDLcaUjatlfFXjm+ZEJKmYY6eFVM9jCktSdTUI8ZQg=;
 b=x1XlvCQAN0hu5CxheaBTnQ1kDBoSPyfadRKcfwKltRPtVpyUxTvEgISj4n+lF4PtQ8SRzLmpJkxSG1WBeQG7g2nBje4lpUNvb2qTkhgpK9eq1NRm945zxsgARFsx1Ngm+uaqa7Pyg34IE+ucowpSBeo1yyHVIwP+McC5IdKc/vNpXEUwxq9XGlUEk+Dl2v9XBBFwiKJw0QgfyyTjhoFA3U88+ooPg6K/jZcOx6n1B7buTFBX2UW+Kkw+TIqCwUay/sNSZ6eXQHFzRIrvdQXCOKjl01MxRWn0/+ZtnTMux/rpDh44h0Su6v2ykNrL45er71m8hqDGCvFlQIUsp0IDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNDLcaUjatlfFXjm+ZEJKmYY6eFVM9jCktSdTUI8ZQg=;
 b=aIwXgtwRc+JDDDPlCDE57qCOWXDQJ6HlAvmhABA9BFq8/QNSOnKxzUYxlfUQsYVJr4s3NezGw0N2smw5Dn/2WKK6ZLwJn20jhmB8jCtR6QGnc6xD71oJ2Wm+6Pq3PilQWy0du0cQucs0gB3ltns6so2sEcYuHfzXw5kTgh87Ht4=
Received: from BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Thu, 12 Sep
 2024 19:09:31 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::b5) by BY3PR10CA0008.outlook.office365.com
 (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:31 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:24 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 34/34] x86/pti: Add attack vector controls for pti
Date: Thu, 12 Sep 2024 14:08:57 -0500
Message-ID: <20240912190857.235849-35-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe61d84-049d-4abc-37a3-08dcd35e6e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1zkPxA5GgnHwjd5ShBoeUe1yF51RWPVxhY7XLu8EDzj76gaqPcZbcy+iupqZ?=
 =?us-ascii?Q?5Q5gpI1GDRv6Ij21fbt/0oOdSOSpp1FjfjQ2fjEJ2/4zC1vXU41iv60knAFo?=
 =?us-ascii?Q?SzVYTEBA7KiHdKvVKMtK/HEz+wJuicsE1foo7bXBTmANkr6hzfUp0Jbb00GN?=
 =?us-ascii?Q?u9i0OShXVuNxZ9hBIHyWWK/85JhhuZX7JVk8CRJimoQG9KDY7bBd0sLEEtVM?=
 =?us-ascii?Q?iUchYQd5z8byEvDonbfDPZPMhj5mu7xtr++iuSnwSaV/FwWiYPY6JNUep8fw?=
 =?us-ascii?Q?3npgT9xTUi7KkpGSJq3rjRA7l3yjnYU+Z2jCarqfzvOmLF0tv5xwOJCPyUci?=
 =?us-ascii?Q?UwxXHe18F29p4w0KyC1s/evaS99O1Dyf1ewyzID8uqyE5lY/rJTboGlhtP5R?=
 =?us-ascii?Q?kcHM/xQyHxFXwPKpPJJfdnjPtBzsulhh/Y5uy4SpaY13MTbMt7195TEo68ic?=
 =?us-ascii?Q?o8KC69lsr2AI+xeGbQLp0h3UrsJ3BceEecAPyWrQ980jEe+0IOyfV5fgjLUO?=
 =?us-ascii?Q?5jvfZtPtyLZ3AlraoTg1XTZG3FX9IjojHXlxYUwnDYmsEAoBcNRa0AGVasts?=
 =?us-ascii?Q?PagDHz+vPZmW3DOAGcLoeixVrPHmjJUv8yGAaymdh2GClUmMcSs+6i6Yq9zn?=
 =?us-ascii?Q?0+f7fTaXl2pSKerI9g087r6wYW7uUyCoZrAwM4nMUmG7WSrLWnIUeBQtbymW?=
 =?us-ascii?Q?G9/vyvlRct5Vihu7BgljFIhmykUaF303VtsIToXfKvV4gGUg3Jd6k+FexzBD?=
 =?us-ascii?Q?xtqP5h2ekPsy1UGuA9G/2UPiFKp/zmILnjAD9WwNvhPU0RunaYvzykp/GZ9/?=
 =?us-ascii?Q?MFD21NFuAG42s3bMYeMFTUYIexIE+MTlj4kpHW/+s4SZAwnLfIK5GsrWpONQ?=
 =?us-ascii?Q?zN0z8u90sMFwoQrGBliFI9NUOAaaLOPm1ZTtfn745kP8jIHretVXZQDEr1Wc?=
 =?us-ascii?Q?ZmfW7SRjYXL3SvHZHWqTb2bsNFCkzwjEdGnElRXGWCdKxRb4/tK7DBWQEjwv?=
 =?us-ascii?Q?sByQ1IXCdOckbNbikbrAtZT/xnXd5WDLLuvsxuGpXdQl0F8jMKGbURoO/iE8?=
 =?us-ascii?Q?8W4yThXHl9KnqxGT/Mq92MMzefo91+F5bqUG2+NHSZb++ZFWsTn+Miqrituy?=
 =?us-ascii?Q?CXaGqyKpsuLO5vf99VVu0C9sW5JM47SHwA6qSbGk+zZ1vwyhGC1hFQ6RSwJJ?=
 =?us-ascii?Q?CLZE6CTjYv2CU70N/HH5ynotxrjo3Um+1TsTCUjM0vrsOv8+mxoh7FtSqsYu?=
 =?us-ascii?Q?kjxvy0giGtxalSwKCJBUpgnMYiC+hHdOKcTe1tnV0cOKLsUbZQb20m7DfvxG?=
 =?us-ascii?Q?RL+S1sAxPkPCqtlI2aH4ziUdoPYNZohD5Jy6P2dTAc9rLpBd1gRo36EQ6xql?=
 =?us-ascii?Q?Go/ZHAyI/9PJMpYP0Je7Lq6omNWJe0XpRTe5+IwBsPQMnVCDSjoyuljvymQh?=
 =?us-ascii?Q?8+eVwtMvUuBD6/rSdulwg08fXfk7s9ts?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:31.1243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe61d84-049d-4abc-37a3-08dcd35e6e6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369

Disable PTI mitigation if user->kernel attack vector mitigations are
disabled.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/mm/pti.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 851ec8f1363a..9e1ed3df04e8 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -94,7 +94,8 @@ void __init pti_check_boottime_disable(void)
 	if (pti_mode == PTI_FORCE_ON)
 		pti_print_if_secure("force enabled on command line.");
 
-	if (pti_mode == PTI_AUTO && !boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
+	if (pti_mode == PTI_AUTO && (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN) ||
+				     !cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL)))
 		return;
 
 	setup_force_cpu_cap(X86_FEATURE_PTI);
-- 
2.34.1


