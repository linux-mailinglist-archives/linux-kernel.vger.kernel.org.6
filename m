Return-Path: <linux-kernel+bounces-568701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7AA6996E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D56E7B2609
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09F72165E2;
	Wed, 19 Mar 2025 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kvsoUwai"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B362C215162
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412756; cv=fail; b=i1AiFB5n+OCIatKS0Aa8Wr/9NWoLUGwtPcERUyOP3Uh1J61tEaXwNXZ4nzAwZTAWEDXbGX9S4rundeIbhTxWjGRypoGqfoSCm116MZw2KZp3p+UQiM42fWmQO5tqNy8OWzsSa5ZZct/XnM/c1zhG32qsRaUb+UjSSTTjbYNEd9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412756; c=relaxed/simple;
	bh=oaZ/AiMA6+vJ6S5JZbHNXsodD/q3TOiQ9vQ19iktFks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMTf6sp4yfXJ8TnXvotY8dIrDAYpk2J2r9a2C1lM+Wq/F0WCpJcGvou8kMje6HLZdZshU/UPsFkLbB5GmADHHC/t5D/YKzCGeVV0jqsAaIc9PB7GqZt9iOnvVZ8r1JPyDNgZML19fzhuR19T6AYe1p3o63vb69SmTlVGXoFQgN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kvsoUwai; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTMHDZR2EEMCdZs3UWwMQndK8OkpnKimRntopJahrXuFZ9kbYPkfgmfLikaZcxBUyN6e4iW+IhYhLafnE/mjxIirvtZ2ebDW2dcWmbgHqgl0ybuayEuh5/3ZHdfjGI7JrnfcryNmCQCthPVTN9BR/rcwLXgirUtXMjXLQyANy56rWKgKD40wlBMP3ggQBlj2DRrs0FjQUpUIRzgzrB7S5BtDC48DtgGlAF9VzuypLmlfutLwjVr5BhM5xwNi90arGI6ptu85+IXNkLutWiQ0kLDTgItgicQKXGWF1aFZ2u9g+Y6j3FERNzDm3HajwtTXDYZWzZkXoKLSU0XpsJ3KAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWt1GZDA3EZY+FP4C7YhcSYsQNWOvQYIMshl1kgSG1I=;
 b=o62dgaE19l4LOptxjkvP+XjZ0lG30h1xwGc/4g7n+T+d3EdrQbfUCayQFA9ERB8aj3MVaKDjrg8ucnPrFgWEEimVDsTFtGaN/MdXZkNZpBDDaYsg7/dymSWI1zZ42MkLxD/izsykI6vMllfbi2x+T3V5+PKni+8Lcwtt4jsxqqTs3uL8TARYV1TCwo/nL6g6qMPqlppg4YnjkTQhs3z2bjpuOf95i8y8VmGXc4EBXqTVnFDJ1cyu1d8B4pKApHvZIk6crDHMLPfJbyPKhmxQ4b6CgZJOx6t/x75QZESBuI49IgbLM1OXgqdj8Eb0blok2ipKOX7fy55NUHblKmhxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWt1GZDA3EZY+FP4C7YhcSYsQNWOvQYIMshl1kgSG1I=;
 b=kvsoUwaiYrAJ1PZq9XnhDKRKfvY20q2UzvMZzRGqeZQEJQ5KQnLCsDueb00ml0POvaK8hTRuL4F6JQ50aD8UjuqBIgdq9YvPuPeDrwRUTvHG8xILDFV+ZuTR38FOi4Hd8EbPyDHUPv3gCL38pLtatQ1xjLe1tR9LtLoTH2IfOx8=
Received: from SN7PR04CA0005.namprd04.prod.outlook.com (2603:10b6:806:f2::10)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:32:22 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::6e) by SN7PR04CA0005.outlook.office365.com
 (2603:10b6:806:f2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:32:21 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:32:11 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <bharata@amd.com>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dongjoo.linux.dev@gmail.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<santosh.shukla@amd.com>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: [RFC PATCH V1 08/13] mm: Add initial scan delay
Date: Wed, 19 Mar 2025 19:30:23 +0000
Message-ID: <20250319193028.29514-9-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319193028.29514-1-raghavendra.kt@amd.com>
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eebad5a-3e68-4ae3-2f75-08dd671cc510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ok7TasDbDnnHhl32YkpffKvFAVstQVfvDxyTfIRD1RdHJZ3ti1gvSNPBEDPW?=
 =?us-ascii?Q?sN1fVWvcigqPcOWPmIPYELNylgi63+TXbAairLoptFGJYgOUa4XVqwOX1nUy?=
 =?us-ascii?Q?qPqImScE61rlLT+7VB/H/ulIEJynayR/aSstXP7O6LZOXGJy2y8fm7LvxAFt?=
 =?us-ascii?Q?H7lY0Auu5UxztfRNm9N3rT3AYlUzjDpPkyk14fGVlniQWmMxZxIlyDFjaG6x?=
 =?us-ascii?Q?3EAf4/lWeXNEEgHsTP8dqiG5Htj1/Ard9fX/ZQHkvozKp27KWH2nLgi/V6rd?=
 =?us-ascii?Q?c66JTjkeczlpiw9+gydWmA6WC+vU6Mm/SBVWNFXFqmjGl2dFBOVojp7H2xuV?=
 =?us-ascii?Q?dHUo3J+OQUwmEncpvOnv1J0sg6clnw+n58NX9h6q0ppf6OVqbXZWu0NZzCl3?=
 =?us-ascii?Q?/z5/rB7joDrWbiq3jXB0hpz4K9rH3oCWL6BZda0XgWYyvkKWete2FkQZysyN?=
 =?us-ascii?Q?4cYdz5rE61KgZ7rP50nACBMlmK/R1p3z3utvQJWOGoE82/Sz+gGawovWWy31?=
 =?us-ascii?Q?K0UEYO6pVCpGd3c490g9AGvO56e/FrrM2anDjAEJIqqNowmaDL8c4452hY15?=
 =?us-ascii?Q?cyQciR2Cwi1UfF9oC7RDRxgu8dP1JwA3cWPaGPFQKl19GMDLdbMS9p0Xoagc?=
 =?us-ascii?Q?eSJ9LMbd32DEjU3f+U9soU9/xFgZoi3L/R78vkBqrG/fRziW6XmzI/Wbp6DK?=
 =?us-ascii?Q?MGqw/+A7V+y9bgcXCY4zulxjDnvi8FPMZwutksC4CUBRCtsUl1jy0/dZRKSr?=
 =?us-ascii?Q?5Y5V92qiA56aM/BlDwdowGuQd8ekUUIHWNzGsIk4MLGyeE1McoCd1sUc1Rmz?=
 =?us-ascii?Q?4Ecq2ImplJbRk1cSsjP9/q8LcyKbHJ99SEpCbManKluizDJml3C43Nt+BUvX?=
 =?us-ascii?Q?U2BYEYsrSQebKWsEayWoXBKpdOUtN+6VBPUciZmxqd+F75FvaJoJXNKe7Od5?=
 =?us-ascii?Q?YpDEoZ6s4YgetfA987E7mArZK66CGweH6OyQQ8eX4AZoZq84Ufc157EMyw12?=
 =?us-ascii?Q?q9xnSegHZfu6vO0BQNjy+x3C67yp2WFo1/5XET8A9bEdTvx89n5uMV/DX2rP?=
 =?us-ascii?Q?VZcqcAVoDB2gRjyYynA0PILW1vhrjRzu/26j7OMFR/RL48g3SP2vG9VfF+7M?=
 =?us-ascii?Q?8zm+WZgVsxYpDgez9GvUG30N87GHrLaMC+yQRVry7BSuD+Ra6B+w0ELdp+2k?=
 =?us-ascii?Q?ToVHdH2wOqv9no9OM3uWrarSN6frojAmsos5n4bWyI+JIE6B/IrXvQqlxO/8?=
 =?us-ascii?Q?spPD+ViNX6YioHyqYp+nThxBOP7ovoe4wP1LKIt6ojWRhvKWs8YGy3vg/sK7?=
 =?us-ascii?Q?c2+lfNwRL6h+nkulDGY/qGFtxELrUry20xslvDvble6qZAT3Vo62JHkFm6vl?=
 =?us-ascii?Q?OZycWbUkyGg0sTg51aoK4ojqbF/iJY4S8sarn13Zs2XA6/jSauW7MR0v4pvw?=
 =?us-ascii?Q?BUlI+x4mdRGfTWHgokwNqSs8VmGPR+bo62g1FB1RaDVM7qbCmxug7lvvCfAc?=
 =?us-ascii?Q?zNsTARlCwJhWBGE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:32:21.8770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eebad5a-3e68-4ae3-2f75-08dd671cc510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835

This is to prevent unnecessary scanning of short lived tasks
spending in scanning.

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kmmscand.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index a19b1f31271d..84140b9e8ce2 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -28,6 +28,7 @@
 
 static struct task_struct *kmmscand_thread __read_mostly;
 static DEFINE_MUTEX(kmmscand_mutex);
+extern unsigned int sysctl_numa_balancing_scan_delay;
 
 /*
  * Total VMA size to cover during scan.
@@ -880,6 +881,7 @@ void __kmmscand_enter(struct mm_struct *mm)
 {
 	struct kmmscand_mm_slot *kmmscand_slot;
 	struct mm_slot *slot;
+	unsigned long now;
 	int wakeup;
 
 	/* __kmmscand_exit() must not run from under us */
@@ -890,10 +892,12 @@ void __kmmscand_enter(struct mm_struct *mm)
 	if (!kmmscand_slot)
 		return;
 
+	now = jiffies;
 	kmmscand_slot->address = 0;
 	kmmscand_slot->scan_period = kmmscand_mm_scan_period_ms;
 	kmmscand_slot->scan_size = kmmscand_scan_size;
-	kmmscand_slot->next_scan = 0;
+	kmmscand_slot->next_scan = now +
+			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 	kmmscand_slot->scan_delta = 0;
 
 	slot = &kmmscand_slot->slot;
-- 
2.34.1


