Return-Path: <linux-kernel+bounces-554709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0680DA59B68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F7718865D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C72417F0;
	Mon, 10 Mar 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xPk5CfLd"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECD23E259
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624877; cv=fail; b=f63yzF7ovY2+o6ShnTzM9FQ0E6kUolNl/lUmG/x6aIxJ+hakE8AYc/7uXg3S/cPNvTK3n105IbHiA7Kh+8liYptNs28ccjfvITQkOOQsVKB1uiMU63cES6raNn2YxYaAsRJE/jFAeBxKWu1LaOKWT1BZfxwXQgkfJZQ7skb+SLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624877; c=relaxed/simple;
	bh=CjCkcCvk2BwwPtK07YTPAlIDLfhmoqogT0K7blxABg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+sz4WPkHiUU1730CtS3YuLK/I+fxfEmpfZ8W9tU8gPmU5884T22RTDpImVvGHRmjxT6tQcVpCAM1SUPAJlbWxoFoLjY06x2B7EISDbubdhJsm1MPmuNIraoSVOEogfhVbGmAG4f8gGzFCBC7Sf2+iqPyCUql4eiNa2fIJiDbjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xPk5CfLd; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaytaT+vEuGQGWBdTJWcoKcCS7t1BjTs3BGLZHDiKYxJhP7GZ3PElC1oNkuq9y3ZWEdvGVNaKTAxd81KAxN6bDGqU5VgGrgXerB1d+N/WnqWtRk5/oCcx7BGT+41oSjVN4JvK37sHQwLmFQae2aHoA+VP9yScsdTtJjeHW2CA0hQBOzsnVTxMWmV1n6yds/RXdzOsufsTdOovkrqO2+LbkHnBPHtXeLuUt3vlm1xnBVFCtQKtWgAQAvPo1QMwhm3DJ7IYVqxNZgw8PRnyMXWdZlDYnjYDemmDvMFF4uPqeU7Jonptl3aTwZCRb/kROM+hdTTDqHZkQqPK+KOxf5qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnjhMpRUFdgxkr9yc534jIt1GKvXLVnxaasVi5ROSys=;
 b=crcg1xCvGdxRU8spWvf0F43OAflJ8OsrLIy0nxfgUJjyooedXRl0whaZKTJ6spSVtQPyrhBnDtf/TWg0yA/toN3ZjhlgtXFFAqWMfVqVwKgWK3cYBCkwcDuXqg2KVd4mf9axAc4omPjVRiYX2eh/9Tnt5qFWRC+mKXwmLCNWT0oLG9t6f6z2B1UwiceHC3qzRW+v2yQlYAMKjF8T5XedbDwUeXqz5tNvlP30FAH0rPxdWztFXUCfJ1wN1U7zebWufkwFdlKjI59s5qRvxoK8sDUm/vGcxKLfSjEJUgnWeYL62u80feCiHYbpof41kJOhOI0/sKA49+dpvLhzfejKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnjhMpRUFdgxkr9yc534jIt1GKvXLVnxaasVi5ROSys=;
 b=xPk5CfLdMvBT8ajd55e6NktVG6UNyn+/x+NbzvAQC+bhIXLntVluraWyOsTO+GYEDWGmj37BsornNBfsRw84ClOHk7x7LFNvk5hWnHs/fMOL6L7GGWes7zxKx4oLeTA27fjkhhHNEg0FXECGE4Tx0tm1yhjM1t5P34NgrEpXOGQ=
Received: from BN9PR03CA0791.namprd03.prod.outlook.com (2603:10b6:408:13f::16)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:41:11 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::55) by BN9PR03CA0791.outlook.office365.com
 (2603:10b6:408:13f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 16:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:11 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:09 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 34/36] x86/pti: Add attack vector controls for pti
Date: Mon, 10 Mar 2025 11:40:21 -0500
Message-ID: <20250310164023.779191-35-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e1272c-930e-4aa1-46b7-08dd5ff25d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xyP6hxYPXCy6dE62clbQbyWXTc+FLKOmjqVAzDS9cSYy4vw/zT2AnX075+aL?=
 =?us-ascii?Q?PHY8FBeQztuWVFxLqYiP1jTrXJnXNOu9kNujJoFvSyil6fdT//M5qFIoNHOc?=
 =?us-ascii?Q?qnL1UrTaA4X8kwlAGSZlZQx+43TYpiKi364EDPjk9r8jrTT0TlKRn4Ew8SkO?=
 =?us-ascii?Q?7f5YgPOH0KoejJGlXdkZgpr2ArrFSY0ec+LZZFv9CoqHFZ6Z/7Ab7TCcQMo0?=
 =?us-ascii?Q?5Ktn2iQtfiz124qPaUyBGMcrWgWNexbkq2otdo7wFxOnZ/wNo2lmz9AWSFfH?=
 =?us-ascii?Q?Z7LOAVMJfu2uVe+FvYiLcSsjm+TxoJF8cCP/mzC3DhLAMGOdw29zDZp6fbPP?=
 =?us-ascii?Q?BFicBjb23cep/fP6Vy7ZWUzc5SmEgXM9cUWfY9ISmvf7uKAVQaSudPQm7Y4W?=
 =?us-ascii?Q?tiuOWor8U8TFIUa8j1eM2mSo93HPdOSGhOvUGb8t8rNTKRUce/KdoH9N52uw?=
 =?us-ascii?Q?2DA8/FcvUTjKxSANy+x4aZFrSlFslWWLiFcqrzqnch7bOYZwElJZ83Q0ZSKr?=
 =?us-ascii?Q?VtR9Amg1aexA5s6oAYSPEatd25k7ZVo/cNgNhxndsvH1ZLGBoMXUfbER5fwl?=
 =?us-ascii?Q?ZetXvfqpeIl4tzgJj+eHzp++8+zoQZXnuDl70CAi3emTyJHNq5pYmvkq4tpt?=
 =?us-ascii?Q?A6Xa7p8L2CHNIHUIiEiU6izYkItFYB48n/XqLDeqKLXWCpH0UqW7S6ajU9hS?=
 =?us-ascii?Q?tGor7h1p1vrIXj96o/aUgVIwm/m3QKOLvyEXjcgpscc8hvpTYlSqDXEpQN1T?=
 =?us-ascii?Q?xktjCHIknazJd7qAX4Si4dQJlOUw5M0AljisdKciuYIithXlRPvHhnwl+tIq?=
 =?us-ascii?Q?H4AVK0npp1qowm5Wng08cjiIVemc45RdjjqtG/BWR/yULFjHdcPB3j+KkeHx?=
 =?us-ascii?Q?8qNzDys4MvoUVZeFGWrENFtILgWP3rPJ4UalcAANCNYLCkweWMpGFs+O9nq0?=
 =?us-ascii?Q?lcrait8SWslL0TZxwmR/2i0gQzfs7hzV+FdoY4Ind2AjNtRGHKA64rjWFw/h?=
 =?us-ascii?Q?78u2J/x+qfNX9rM5g1adOKeF3qRDk9h7HQJ6GFh/RQ+jC7DY+sOe1qKd1+z+?=
 =?us-ascii?Q?ySml5odv3S2P3YwLFGF/qySeJTh/Km2yUkP1UFqDvVHuo/+KvpsWGHV2W058?=
 =?us-ascii?Q?EVz9yWPrRpJhJkbGyPOMVuqBj3KohdKcx+bYdEqAAbjs9MTSXbLDPj+ubjJg?=
 =?us-ascii?Q?b3S6mMxoiVeTxQQP1qDJhQHEmY1dMY8s8S8x8eh1ejYentKknc0/0sLkrOuF?=
 =?us-ascii?Q?0ILMeJ9P5gOnFYuWjTYeKCx7K0aLzMdDxCRty7cPA55ChgJlgQGZGKCP5hEA?=
 =?us-ascii?Q?iYSwkcwNmIJd6j7SO3hrx5nMcdrbkCHvZAXYfn7hS2ZBhJt2jBnr7TADPwIj?=
 =?us-ascii?Q?9pPP9Nsr2OOzKwZeQeIKzw3pSw2K6PMrnX5u6fjMY5vPUNjCYG+Vkx616fK6?=
 =?us-ascii?Q?Waf7DgUuR7ULsOgfVCe+vMadOoSmhhTBGw9i3M1EfkzASoVpsFkDf64bH+rq?=
 =?us-ascii?Q?whj1z5uHW1zC+nE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:11.2077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e1272c-930e-4aa1-46b7-08dd5ff25d8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

Disable PTI mitigation if user->kernel attack vector mitigations are
disabled.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/mm/pti.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5f0d579932c6..e5b96233aa58 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -38,6 +38,7 @@
 #include <asm/desc.h>
 #include <asm/sections.h>
 #include <asm/set_memory.h>
+#include <asm/bugs.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)     "Kernel/User page tables isolation: " fmt
@@ -84,7 +85,8 @@ void __init pti_check_boottime_disable(void)
 		return;
 	}
 
-	if (cpu_mitigations_off())
+	if (pti_mode == PTI_AUTO &&
+	    !cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL))
 		pti_mode = PTI_FORCE_OFF;
 	if (pti_mode == PTI_FORCE_OFF) {
 		pti_print_if_insecure("disabled on command line.");
-- 
2.34.1


