Return-Path: <linux-kernel+bounces-568675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E903EA6992F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BFA9829B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C41214A66;
	Wed, 19 Mar 2025 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QiPbmOhV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50138214A7D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412263; cv=fail; b=nc9daJkpbA0CjjfiFrH4RiKR8O/AFtmdjAxkHAlMrvvvHtrHFNxNj0LMxj+eAGHSjyE1R/dnAd6jfg22qYFhiNaGism/uADvpzv1Nnhr5bkqGu6jtLiC+Pal0Tpusns2YTz1rxykS6OLY6BGvFAKF/eSuU7Dihs5x3l6kX1mFbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412263; c=relaxed/simple;
	bh=hZK7sg3yKRMdU+rwmyJOPmRRgRmnAbB2q0yF43t3LWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRxFQv4eNefBmDV0uCBp7jJ2rGjk/A5jFz10sFEsdrO3L+44Aam1D32DdCxJlIDySPioupyzuLJSz/ML88MC0S6cWPwtE17L5P6qyuzHQlnzYWrvmbFRN1y8msT5NjJpFEC+IPjmdNv5UKPCajB+ohY5EE4GeSAQViqJyPTWOeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QiPbmOhV; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOCcuIf3vvCy8AdALaVQQ+6KxS9tLGdGp8OCnhrHzmdlYg7OfJNBlNQoEWhCif8TWC5qTVndN20QXmr1rGvG6h1oFExJsjWBOh7598GFRGoJ6Qr8RV5CuonPq8M6PS+UB5tlm0eB/onjp8el1Zho4NAW5QULVHsc1TzFfx6H1e6V7AvE3DnRrFqfs9UT8RaT8xsDip/qCgXrsR8brDsTYHcJWHzqtxhnuK1xqHRmZ8w/8tFg/aO4VJ+xb6vMMvRn+Iq5p2zgIgm6OSLcu4amN7ikuYcmQErKFI4UdStYWwEIQ10LZ7AfJ+vfK8XuN7ip2Ku4gegOxZj6Lla4/62YPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaI3tqmugpKqCcloLD1mp5kwytZpVfANTVAtyTPxnVQ=;
 b=OPQppiH2T3dOBzraecc1tQmj7so62ucYz8tFcQX11ZhyRUObDxoRhmmTZq0IFlKCgw549M9UFaXnJJpfE+rSYiqQVb7x5SvySZmK4YxS13LvFRRhvaTiIoP4TwokpkUW6569MM2lsL0wtCf+w5ZoitDvluAbWq8EUBLcfxRpY4DwJQG+bNJbzdW6//tY2HDCznmXjW51kZ/8RRhVjhmr1NGXyeWstfSrwdS2L+yVpjz8bo5cv/I0fKvnSiJwyylEysdTcknq797RJj4Y+F4ssUlPPdwdHCM7U7oqr/0czLy/ZJR2D+SVlMEsATCMsxmE3tygSI5shNOz9COe/CD4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaI3tqmugpKqCcloLD1mp5kwytZpVfANTVAtyTPxnVQ=;
 b=QiPbmOhVcZjr5zNIHlHKgkC3f2n86ldOQskpll2clBYusFDyk6a7ZsbVH/mFyBUAo7CVb9OnAmuwFsY9mNB3Gyi2qJ4CfSFm4UuEO3VTNUmTknfZ80/7Zd3aGxP3HCoPRFpC/GpUGFCDbczYYAxPJgQJKdD8smiFRgo+CNKMMDA=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 19:24:16 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::8a) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:24:14 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:24:06 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>, <ziy@nvidia.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <baolin.wang@linux.alibaba.com>,
	<bharata@amd.com>, <david@redhat.com>, <gregory.price@memverge.com>,
	<honggyu.kim@sk.com>, <jane.chu@oracle.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <leesuyeon0506@gmail.com>,
	<leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mel.gorman@gmail.com>,
	<Michael.Day@amd.com>, <Raghavendra.KodsaraThimmappa@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>,
	<wangkefeng.wang@huawei.com>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <anannara@amd.com>, <wei.huang2@amd.com>,
	<Jonathan.Cameron@huawei.com>, <hyeonggon.yoo@sk.com>, <byungchul@sk.com>
Subject: [PATCH RFC V2 8/9] adjust NR_MAX_BATCHED_MIGRATION for testing
Date: Wed, 19 Mar 2025 19:22:11 +0000
Message-ID: <20250319192211.10092-9-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319192211.10092-1-shivankg@amd.com>
References: <20250319192211.10092-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: c373366d-91f9-4806-12bb-08dd671ba2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K1fQyQGAe8p6vVUZFiVp36ZxQyIGAjDDmr/rfLUlFlOXld4x7strnOzoIVlO?=
 =?us-ascii?Q?U5YQmN8ZhyOiOK/sMBc9KUKgfuxaTuij3ZGPbK4oOnWIo6qfeNHpVTqZJ0mv?=
 =?us-ascii?Q?+PmCa9BUcRwWX+dwEeMLCT28BZEtA8Hr9z7ZFdJXJLNyR1JivaR2xFKL/ER6?=
 =?us-ascii?Q?Q2VKcMyUBY7aXuy++6MpLVDmwmXNLJ+LIF2eV5Kbuh2LCGR66E/+MBUE3RgV?=
 =?us-ascii?Q?crxtK1zgxmFiAEDY3v2MWgtY6k3rb9KPugtSwVmzJ74uAWPDG1XQsMSJsn2v?=
 =?us-ascii?Q?3CSSG0MlFESDGDKj7VlJ5Bjo8Fw9K1R2VdO17BT+SrXvjYsVxUZt5MEHYn2K?=
 =?us-ascii?Q?S3ZN1AO048TMZKu4pyinMKwG/P9FHA7wnHEjQKxOhuQdQdUK8rxHIrDZ5P4s?=
 =?us-ascii?Q?eDTjVYCjuHU4bhJ2Q9woDgGpVpexKHMb1JGS1rZ45ZfAHJmRrygQrMk1Ybip?=
 =?us-ascii?Q?WlxenNhN+NtONkCubv2i3KSZ/WMFO0sAx3ot8q6lF5FA7XaA28mEV3zczVj6?=
 =?us-ascii?Q?4y8gwQMmdg4/mVoSfmJ6Zd995L/9kXpNLF3eKZwvMNqr7+HI9Q9XxP64bELB?=
 =?us-ascii?Q?G5ip+li1CUA4op7FItT7ECIOH+mZtAMrn+K/Sqj8JqzAgVyKbjghspptzYgi?=
 =?us-ascii?Q?+eKUQjQF3F8/73KjMHNtthpQrW5VYCi7ImEzYL2qiUr64haV4p4ILZym/yxY?=
 =?us-ascii?Q?UaftqOAMNtz/7V7YxKd5qaNSIYmLkJIwLSzXTAPD/vZdbBW2ETH6P1+r57IT?=
 =?us-ascii?Q?CGZAJGK8bXGcHfYw0thYmpSS4ea05Qa/kol7zg6xPtJcFRy2NFbojCyDjarb?=
 =?us-ascii?Q?uYklaXR7BzqIr8dEnYSwPe7QsVvAT/KaklZJvf38vS4Q8Ss/EvMv6B/UKW2N?=
 =?us-ascii?Q?PN2dXSlCwu86diYoZp2sT2nRqvStow8B+6GGUPTKppf+IVJg2TT9BZnAXosD?=
 =?us-ascii?Q?QHhc2/RVGHx0YDQyS286O4mFSUdIhJzqvxhmWEcyFh7MSpF2EUmBGRwmCmn+?=
 =?us-ascii?Q?4nGb3hQP5d4zC88WONbl4K08N3eHvF2cK9zWN+4PzsUMZ9trVxNb7Y7bBfm2?=
 =?us-ascii?Q?i1GFxXx4X1fN6XgkapGqGpFaKKuPZ6c5VHX73iUiNsQzMvHcZ9LwwS9XdUzH?=
 =?us-ascii?Q?rk1zrRc3pnRg5siBJTq3HLBCxJma5PFsOBqiqGa3yPvgoYz1+wvxGxrX68ev?=
 =?us-ascii?Q?rrdVWrk2Cy2Tno5Cqb4mh73P2qnt8y+FOy14ucxSekyEP0BMTIHQKmm/9Aze?=
 =?us-ascii?Q?c4RCiOkCQfRyNLbwipJZbG4tth/pgJTBvoVGMx0oGPqWuLHNZt2TDP5djPBp?=
 =?us-ascii?Q?VbG3codCW+V8ObOZklT33o9odKAujJg/lGprDwbErcJrQZ47w8squQvCyrAH?=
 =?us-ascii?Q?9bkk4ujpKVvnIj/HLngYBJr1FkHmTD4WkQtYDSMKAw6ysNH+nXebksZ/PpN1?=
 =?us-ascii?Q?9uL4HvEsdZtf7cjqps6Fy3tvI6k2IU4yFBLEnqYefky7A6E7AR0o42EYnFa1?=
 =?us-ascii?Q?51NsujRXp59Th9M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:24:14.5562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c373366d-91f9-4806-12bb-08dd671ba2a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601

From: Zi Yan <ziy@nvidia.com>

change NR_MAX_BATCHED_MIGRATION to HPAGE_PUD_NR to allow batching THP
copies.

These are for testing purpose only.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e74dbc7a4758..f9eea16a975d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1653,7 +1653,7 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define NR_MAX_BATCHED_MIGRATION	HPAGE_PMD_NR
+#define NR_MAX_BATCHED_MIGRATION	HPAGE_PUD_NR
 #else
 #define NR_MAX_BATCHED_MIGRATION	512
 #endif
-- 
2.34.1


