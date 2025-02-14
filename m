Return-Path: <linux-kernel+bounces-515226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347DA36208
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4153B1FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29312673B9;
	Fri, 14 Feb 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D3daoQ5+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08800267388
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547755; cv=fail; b=msH86jSAWSo16wVP8EkwcgFEdPbyb7DNxT/sXvOHKm+Qh2PDdV3cBKFEqNHDhQ9EE0QidTwZ8fSQkG4Xmja4aaSKyCCphcp7F/a+bBbY61MZwfxMQIIXNXNuYwiNmQWt0yYr1LCHcTqe7HN3AvMBWx3gLkstFPP6dN1QbyEv4WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547755; c=relaxed/simple;
	bh=i0n8816nYOn1RWCrOl2agolwcEC5FmBLHq0MwRkyGjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KiqdUmzw7v8qC/V5SxZhnWETTIiS8pTPS845bP+AWbGP+kDQtld9BMIqZfbZC084fG7X7Toc95+pFcfqnT8m/+eMG/TFYsqze1vjs4yNhzvTxgIOrmCdCT8q+avx5dC/4jk7TnB7ggC8AlyCMVA6euAxuO9y0XF6X57ywFaDpME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D3daoQ5+; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcKR+gSlOFJs2dCdD8is4SJYkklmNF4pRtJkH/akNSY0uGlSOW21pDp4OFryFEMzWrDeLGfERRPNHHgfnhNdLHHG9PXj9FewY7gUSSzpAnboMjGUd80bbU9UFrLqk4RNCbSDQHfgRGVrrcrG4BO+zEmo2/ZPGCf/dn13WYJJZCbrlCPX0aS3X+AoOYGKDGC+3QUG3EG3W/Couj36UFuykx+80OE3kfzAQTdCplWDSqmwvqt/farX0bCggfant9FEu1VI0Yx1tyDThPjcCu3MPppyEb+q2z8bMfpzpsciANtyT3uoxW1qkLEwlzMiLAh6LHEerEKSIPDWXT9AzczQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uEVNm36daEAQedWM1fmv32brDf7DLmvj6nt8IZy6Dw=;
 b=lrJYJ9Gwxm6Ri1Z22QGQS+ZV7EBpz4cG9AQyxrp+u7QQC8oZMazWkwEUu1Z3QkFEkZ0r+e7ivXv3cV3Kz5XhIiaAIpDoDhCOvJfVf5uFCBH4JQAioeHLRJmw+Jj722fHNQy0VWCFTHq+AaPsn4J7XjXodE+MpB+TXcDJ+pD1hxcjg/DvpsAXUTx7+MehefAvBlo03MENImluhObIe9wweFH0izqpwvJLORuIFVTD431vY21R7hcVG1xiXY/0sBvPtJZcU2xm42mUBTYT2NfvCq5gQ/6LgNvJlfiXQzthBmXjwDFc9prX8junu8xpcI1QID5rhotfzhuaiJJ+u3AZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uEVNm36daEAQedWM1fmv32brDf7DLmvj6nt8IZy6Dw=;
 b=D3daoQ5+em1PgiHIu5ibfHx0vgBxPl158qqlRuDSzBE0fKPY89tiyhNZKcwyNHVDSF/fx/fzq5y7uqGqddgEbZ1o9/HwKd0GUL9iWRNvPID7hAfObv6qtTpw5XOwlvTep/h9fA2lAkrPqEa911O6pM1WUhh1EBal3XNagwZlOyjGSOs1gBzgPk268L7HkYJyq9LqnwKY65nsuDBVy3lY/O5E6WwUW/jCoIsoaWxH65n0l6CIsDHU/PxHYZ2BbjrbxAP5NoWa3nypxusOvHEuH2yhPq7b/TYVBblDA0zYDr/RxJBlPRQOaNhJVUcAqKqN7s9bzVhxanmzO6Y5+caQCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.14; Fri, 14 Feb 2025 15:42:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 15:42:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 2/4] mm/page_isolation: remove migratetype from move_freepages_block_isolate()
Date: Fri, 14 Feb 2025 10:42:13 -0500
Message-ID: <20250214154215.717537-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214154215.717537-1-ziy@nvidia.com>
References: <20250214154215.717537-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:208:52d::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: af76635c-b321-4b72-a20b-08dd4d0e2e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?00NuQBAPdZNCJgjPosGQu+5+M/ivtm6R/nfQFYVhIjZQSnfpsJ1PFqsg8ROB?=
 =?us-ascii?Q?G1jw0bdRcQVZSqU0tw9jmkXYTexMeGRizvItU32/j6Y8CbQPgcgBJxMjMf4Q?=
 =?us-ascii?Q?0p/XLp/M7cUKD95XoMg7/Pp2YqffAcmntHLAz2o19UHy8on4yX2QAjt2rmt3?=
 =?us-ascii?Q?Z29sEizzd66JmS4ac4267VvTfipkh54sUTA70UG0y9qZ1sXe6Xr5vNGzrfuH?=
 =?us-ascii?Q?eLPtz8Bsn0zzePB2Lnq14nm07958uTYmQVdOf9Z7s9FEKH5LdXtyT1LMkqjs?=
 =?us-ascii?Q?MNwEltwGXH5KEcjR0TmXKjU3hMBLuQUKOtjGBnFHXcEQC3cw/Z+Q5+Umn8Bk?=
 =?us-ascii?Q?aiG22xuQ7jv3PSF4gDD5wQrxehHgfdtmwH+FwGq0hLc85MCV1PVqh//EME6l?=
 =?us-ascii?Q?HDTMG35daLe4rngvXPMJquZFTSWUIO6MxM9amgbMzPOXx1MteJRDfnoquX5R?=
 =?us-ascii?Q?NqXWe5GQAuJOlg4RXtDu4QlH2/ceDhhI9yaOgot3uswN6c4D/caAFzp9IwCA?=
 =?us-ascii?Q?zXyx4+XoUu5FGscqHcmugcaSoMvaOCSNCb8RPbFpB/di3b2Wo0JGduh6hzZc?=
 =?us-ascii?Q?KhSGKXsPMsEhXDMKIN3jYoyGpwT3apdsS1uC2OzI6QHWOAnjuTWeeYE1IxKy?=
 =?us-ascii?Q?xr+VB+TQ8NuqrDZJdf+PrVNm15kzoTvCp7JFOY7DYY1Jl2vMShrt5Zvbrp3w?=
 =?us-ascii?Q?zW2+ksErHUvylqemb855jNUpA7Y6RbE0be5ml+ll7aQqJmXeckoK24ILNMMV?=
 =?us-ascii?Q?9fNkSojyo6RIXjwfwvAsNfLDzpoCG4+OqWryB5jMtOiuEWVVAfGxljd5M7To?=
 =?us-ascii?Q?LsTe0t+OgRPh11w/ho11TVh+JMjZQHDJdEYxDXajXVD7YRWc4AcbiCNiVxuV?=
 =?us-ascii?Q?kPOAHFgcQPWDaSoyl7ljxlfRRQ/Wtgn9eXWx4VDLUTMo3K/L5GQj3bq2emIK?=
 =?us-ascii?Q?pUT6wUy7uD+4sLJO+VlHFbb9s639hGSScgyqZhAKMHCH/Vb9EyhL5ZnTwhK/?=
 =?us-ascii?Q?m21nV4XCZnvKvH4QtEPFwOB8PQQ3gxPBAfvxTJhLeaHgRyDJVue51CZnvjIX?=
 =?us-ascii?Q?HjGzC+vYcmFKWWcb8xaB0C8jG8hkDELdNVB6mFWQWJkTFvny+tYBqRoWVw1r?=
 =?us-ascii?Q?aGlgzVqWw4YBni6642O+QqSW0H5yVC4V1rRD81R9r/i4vxzuKocGxuNsCjEf?=
 =?us-ascii?Q?Sc71lSvvHj8P43k9ydtPe5lUN8lf2WRDhZIgF0M6tm2OqJNvFzD0bpc4rAI9?=
 =?us-ascii?Q?yN6E95EpSTy+DJGAKtYIsngSFPtQ8lfrwZq3ARFImLMyMkxaOERPQbYy4k8o?=
 =?us-ascii?Q?ex0Fc5HJIMb8ufN2tzaDOg66eOUDXqj3vM1DJ6a6to7+Ru3Hr2f9Vt0RYh3j?=
 =?us-ascii?Q?/f9KVNvx4I0f/R664UDA6dypFo4L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/KTufJfOzhmERdxbqVaH09hSAfDLI5zd2qYNxso/H7o8fju0ew/uhruv6v4S?=
 =?us-ascii?Q?zV/ThRhksDrrmY4az7qA27Df0vn2/FMis099TpOhgnbR8fT4WGAB4zwpk+mL?=
 =?us-ascii?Q?5Ph1EhuV9QhVStjQci2T4t08D+yUTNAADYzC0ELrHQT3ur6XDH9dm4VfZvM3?=
 =?us-ascii?Q?VzdcXswOBWOPtTHizN6NOS0cZdfyyiE6ToJOw8OY5OVXoxf+7GrIkPDe8Pnp?=
 =?us-ascii?Q?9j81OjakWzxfymbbpXdD9CRxTKKU5tL+miYpJLzedukI76YCioqxksCtPI2L?=
 =?us-ascii?Q?r380peshEeC38rsw6zPp0UHUJ3tr00pGq/Bi/Vb+yilorTYfUCLb01g9KI9o?=
 =?us-ascii?Q?08f7eu8tuYpfdnzdLJrc/hA2wPPkodYK2N0+4Q/MQlFTYvy2h9RjOf8P3Vky?=
 =?us-ascii?Q?G9Rq3MhNg+ZpcKgqWig0lJqKzqx8nwQZvYMCO+SUn1CZ5F78tCjHjGkN6xMw?=
 =?us-ascii?Q?/QqKUkEAulw/Q2PZoVNT7FpLTNfymz5NcjvJo9/9/2PK6iHt/BPs46o140oJ?=
 =?us-ascii?Q?qn/JDV8JN0RD5A0Q/w9sISiIDonoVUskEa0QTcQcgVctilI8/ZxVNl+D6uCv?=
 =?us-ascii?Q?jelrQUlwKIkamWaGL57fpEvdLi1PHbzP5RM8k+zcmvNLFFSwWYX8FF33/BFH?=
 =?us-ascii?Q?YjoruyhCiS2BpuuxqFnHB/J/IPODSjpA8eQtlCd35L3c0BziAbcDV8yhzw7E?=
 =?us-ascii?Q?ZnZAX4dWvQ0tZVzyKQHbkfjymoE13av9Zz1U64be5tPslXAmkIfZdOpwd7bx?=
 =?us-ascii?Q?KfTW9VRrlICy05aQTrIMyCYlnDrtAGzByEcqtd2hqYrbdXKEU2lY5fNGXpCm?=
 =?us-ascii?Q?2pYF0SkV21q+EpYIL3rhPStiD8/8VIeKliKWrgRNZ5ltPiqCO6MYjLzGR9UX?=
 =?us-ascii?Q?rBjhUyUmFuIusoH2egwuKo3UkfOHlRlVOv8w9TVxIWDgu3IeOO1D/D7TvarW?=
 =?us-ascii?Q?zas5svddpNZBREm/vhBftEAS0nAzTzGRSDy4yzdNu6HrS88upmHTH8P9gzP9?=
 =?us-ascii?Q?COgVtWr6YKt1uyOoelOVU75+vqNqlagQgxwv4qH/gBsqAGOlPV630AxAR7rS?=
 =?us-ascii?Q?xuHjnjsIKF1kAzzwrWwWAzu7830iruI8vKDQBL8Byn4qq67AdUWV0oeQyjyP?=
 =?us-ascii?Q?NYv/jPykS/zs4ENBJED9Z5t9uRLRPLCKi+W6qswkEyzRpMWGd6M5kTtT22ZP?=
 =?us-ascii?Q?oGV5TDvoKCeGFrW8ojTFzOG5A/oY2wa/LcO+dJJy2VYSXsf4gjGnEMaYOSi0?=
 =?us-ascii?Q?K/o5lEvlOCi5CIQNsyXWTTA/myexFTwBSzAu7qMVqXR/GvYfWt2NOVBJYYuh?=
 =?us-ascii?Q?/G5+TVjIR5ckVFrC7ZE+q5QLF8heRNcljRPebV8hdHFBaUCjB4YeYyG4wZBH?=
 =?us-ascii?Q?e3IT5LcTebql7VwvgrAftMpGDn0yVm1g7o8k836Fg7CJatts3voxeZRNsb4m?=
 =?us-ascii?Q?CYpvcsGgc8cbVnfsIoOTC4ZenYg5NnJ9mi88RQBrXt0iabh91ZLwf/B87cTC?=
 =?us-ascii?Q?+6QvZ/ZL9gmJiuregJT6au397fk8P+x2lf8HobO1C2zLBUAfX9iJIb0UvlCt?=
 =?us-ascii?Q?HVG/rBqen0lt3EfmWZ3FR1jl1gmZQEaZt0MIym2b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af76635c-b321-4b72-a20b-08dd4d0e2e41
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:42:25.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Idb0lS7AmnEH0ThnxLALp2rXBzg8+dmQAnz8ES71r6UPULUzgRLFU+YJx9of+E9d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

Since migratetype is no longer overwritten during pageblock isolation,
moving pageblocks to and from MIGRATE_ISOLATE do not need migratetype.

Rename move_freepages_block_isolate() to share common code and add
pageblock_isolate_and_move_free_pages() and
pageblock_unisolate_and_move_free_pages() to be explicit about the page
isolation operations.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h |  4 +--
 mm/page_alloc.c                | 48 +++++++++++++++++++++++++++-------
 mm/page_isolation.c            | 21 +++++++--------
 3 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 51797dc39cbc..28c56f423e34 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -27,8 +27,8 @@ static inline bool is_migrate_isolate(int migratetype)
 
 void set_pageblock_migratetype(struct page *page, int migratetype);
 
-bool move_freepages_block_isolate(struct zone *zone, struct page *page,
-				  int migratetype);
+bool pageblock_isolate_and_move_free_pages(struct zone *zone, struct page *page);
+bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *page);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype, int flags);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f17f4acc38c6..9bba5b1c4f1d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1848,10 +1848,10 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
 }
 
 /**
- * move_freepages_block_isolate - move free pages in block for page isolation
+ * __move_freepages_for_page_isolation - move free pages in block for page isolation
  * @zone: the zone
  * @page: the pageblock page
- * @migratetype: migratetype to set on the pageblock
+ * @isolate_pageblock to isolate the given pageblock or unisolate it
  *
  * This is similar to move_freepages_block(), but handles the special
  * case encountered in page isolation, where the block of interest
@@ -1866,10 +1866,15 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
  *
  * Returns %true if pages could be moved, %false otherwise.
  */
-bool move_freepages_block_isolate(struct zone *zone, struct page *page,
-				  int migratetype)
+static bool __move_freepages_for_page_isolation(struct zone *zone,
+		struct page *page, bool isolate_pageblock)
 {
 	unsigned long start_pfn, pfn;
+	int from_mt;
+	int to_mt;
+
+	if (isolate_pageblock == get_pageblock_isolate(page))
+		return false;
 
 	if (!prep_move_freepages_block(zone, page, &start_pfn, NULL, NULL))
 		return false;
@@ -1886,7 +1891,10 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
-		set_pageblock_migratetype(page, migratetype);
+		if (isolate_pageblock)
+			set_pageblock_isolate(page);
+		else
+			clear_pageblock_isolate(page);
 		split_large_buddy(zone, buddy, pfn, order, FPI_NONE);
 		return true;
 	}
@@ -1897,16 +1905,38 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
-		set_pageblock_migratetype(page, migratetype);
+		if (isolate_pageblock)
+			set_pageblock_isolate(page);
+		else
+			clear_pageblock_isolate(page);
 		split_large_buddy(zone, page, pfn, order, FPI_NONE);
 		return true;
 	}
 move:
-	__move_freepages_block(zone, start_pfn,
-			       get_pfnblock_migratetype(page, start_pfn),
-			       migratetype);
+	if (isolate_pageblock) {
+		from_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
+				MIGRATETYPE_MASK);
+		to_mt = MIGRATE_ISOLATE;
+	} else {
+		from_mt = MIGRATE_ISOLATE;
+		to_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
+				MIGRATETYPE_MASK);
+	}
+
+	__move_freepages_block(zone, start_pfn, from_mt, to_mt);
 	return true;
 }
+
+bool pageblock_isolate_and_move_free_pages(struct zone *zone, struct page *page)
+{
+	return __move_freepages_for_page_isolation(zone, page, true);
+}
+
+bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *page)
+{
+	return __move_freepages_for_page_isolation(zone, page, false);
+}
+
 #endif /* CONFIG_MEMORY_ISOLATION */
 
 static void change_pageblock_range(struct page *pageblock_page,
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 8ed53ee00f2a..01d9a4eace7a 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -188,7 +188,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	unmovable = has_unmovable_pages(check_unmovable_start, check_unmovable_end,
 			migratetype, isol_flags);
 	if (!unmovable) {
-		if (!move_freepages_block_isolate(zone, page, MIGRATE_ISOLATE)) {
+		if (!pageblock_isolate_and_move_free_pages(zone, page)) {
 			spin_unlock_irqrestore(&zone->lock, flags);
 			return -EBUSY;
 		}
@@ -209,7 +209,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	return -EBUSY;
 }
 
-static void unset_migratetype_isolate(struct page *page, int migratetype)
+static void unset_migratetype_isolate(struct page *page)
 {
 	struct zone *zone;
 	unsigned long flags;
@@ -262,10 +262,10 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 		 * Isolating this block already succeeded, so this
 		 * should not fail on zone boundaries.
 		 */
-		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
+		WARN_ON_ONCE(!pageblock_unisolate_and_move_free_pages(zone, page));
 	} else {
-		set_pageblock_migratetype(page, migratetype);
-		__putback_isolated_page(page, order, migratetype);
+		clear_pageblock_isolate(page);
+		__putback_isolated_page(page, order, get_pageblock_migratetype(page));
 	}
 	zone->nr_isolate_pageblock--;
 out:
@@ -383,7 +383,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 		if (PageBuddy(page)) {
 			int order = buddy_order(page);
 
-			/* move_freepages_block_isolate() handled this */
+			/* pageblock_isolate_and_move_free_pages() handled this */
 			VM_WARN_ON_ONCE(pfn + (1 << order) > boundary_pfn);
 
 			pfn += 1UL << order;
@@ -433,7 +433,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 failed:
 	/* restore the original migratetype */
 	if (!skip_isolation)
-		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), migratetype);
+		unset_migratetype_isolate(pfn_to_page(isolate_pageblock));
 	return -EBUSY;
 }
 
@@ -504,7 +504,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	ret = isolate_single_pageblock(isolate_end, flags, true,
 			skip_isolation, migratetype);
 	if (ret) {
-		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
+		unset_migratetype_isolate(pfn_to_page(isolate_start));
 		return ret;
 	}
 
@@ -517,8 +517,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 					start_pfn, end_pfn)) {
 			undo_isolate_page_range(isolate_start, pfn, migratetype);
 			unset_migratetype_isolate(
-				pfn_to_page(isolate_end - pageblock_nr_pages),
-				migratetype);
+				pfn_to_page(isolate_end - pageblock_nr_pages));
 			return -EBUSY;
 		}
 	}
@@ -548,7 +547,7 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		page = __first_valid_page(pfn, pageblock_nr_pages);
 		if (!page || !is_migrate_isolate_page(page))
 			continue;
-		unset_migratetype_isolate(page, migratetype);
+		unset_migratetype_isolate(page);
 	}
 }
 /*
-- 
2.47.2


