Return-Path: <linux-kernel+bounces-305652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A09631B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1881C21EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF831AD3F3;
	Wed, 28 Aug 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IkS+S37E"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7AC1AC8B4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876609; cv=fail; b=s7Nm2+cbdA+N852AIJrz7S6aWIH45Wl1K+NvzXhcGaZq6Plei/FMydVRcolVllgVIzXF8iFGmPX9VAV0G7K2PC+g9gDRld713qjo08xR4g0XLWsUnFNUlTvPISOBM2Wxa1izj5f6YmojgHoYALPq5WORQph5ADl9yPHE/NFFZRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876609; c=relaxed/simple;
	bh=iDG5Nvga02wI1DwSvyAwh5EHBs43MZZOFwgUU+4XS9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kl1pRvZOhZ9+PS4AavpfZNixdslDA+kAumi4O57qTrW9a4++WPrX3n4kkMVxY5n3jR2uip+nqSjXAhuGeu93s/Em+EBcaTw/wVHyefjJwNQm4pfYwXH9g1ZzheJxQZW28w5V1GStE7kBWugpq9GvKxlZ3RzVC/VBYKBGt6muuRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IkS+S37E; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPSP4HqIVZ5zxk99x1vPZBLijjR20TDWEubGr94yk+lgiQqCu+B6sxfeTWjalHGgKojhCgE2CiBIg6H0Bb+pF7aeZI7cEZVpiksWW1OUl5sHyNHYGm9/hglAc812iDNzxV8CAbZiZD6aKCPqyHf3DlH/fNfT0NSaQ4842a6MSknAXHAWPEHKLzJhUea03aTk8a4wTXd+hWrnDJTbSj1zOpXiGyKN9ou5RAG89WzJf7DZpKzbb4p6buL/l4LJl+PiewqVMCnV6FSzyGoo8cGksOhi59g1mQzi0PCRt1uqD3jg5dsIp4D9/ViL8kEJRwor7NLY7QB4L96F5pF2sk6IgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESXEMzvkaY8fCTVrMJZ13dyf3x5+XzARSC5a/TwgfHA=;
 b=Ov1AmCd0k5d3Q4YK2TJDsOdxw8Opsz7Qo5/E4+UA0gGglpYnF+HoCdL/benBkrepAFxcGTkJRC2TwTxNFaDW7hluOFV7k/9V9lcLFe4qBL2dA5Ldii8hewLNE5r3Nne8NHzmMzWqZycd3U20D5EhnYsL1sjo2t3bKffF9Uii0c/IG23u0o+44SXIDbyP02ohq968yTYzkDoKuiMnNdfrewODbjVQgjeBsv1xtmW5p19sfQFMDFeZwIAsIOcs8QkoLHVRHVfDeEXKwm3+KTwUZLRUEAO35yIqjHd3t6TIM6K3wGrxH6e5s08diNcdMYkg5yqJSM5Di91K6WMHXlLcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESXEMzvkaY8fCTVrMJZ13dyf3x5+XzARSC5a/TwgfHA=;
 b=IkS+S37EWG6C0ZQUOnS0yYCrOBnebc39vmt8826HBkV9/j4r1UXs0m0Cw6x/TJGpswT8LHOtAAOg0RbqcVc0XAvMxMeC27V0f7kz+gN78pP4oyIZIyujb8Pw7mVcCd68kvP14RfvW3msTiqyUrcupGamgfH8XzilQ82MGJvw8NQ3Zjkcz3xERnA5N5GSKMDNGA2un3AlGlaIgy8ZI8oCy8Kl5gf2ukijNZxoP192AkawH5U+kch7yz5OEToK9kiwpdjKiZjb2M/Gbd14nqjJlsdZ4gsPGfNz2TmfeexCmChA9RgSIaNJiZf2/ke0F2BbKYQ2O+bbbtlL/xRz0yqf1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 20:23:24 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 20:23:24 +0000
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
Subject: [RFC PATCH 4/4] mm/page_isolation: remove migratetype parameter from more functions.
Date: Wed, 28 Aug 2024 16:22:40 -0400
Message-ID: <20240828202240.2809740-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828202240.2809740-1-ziy@nvidia.com>
References: <20240828202240.2809740-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:208:15e::27) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: d0090a3c-2317-42ec-6a2b-08dcc79f444e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iHva1wSJ7QXHvi+jUudCWBs53LarsRImlF/OrzO0GOhjgzp7ECVNLBX1omi4?=
 =?us-ascii?Q?0IB8zKqqjEtjDNqy0P1D4982/elR203vRjnfEOg9oFbCOMU2wdZAwMtxKw75?=
 =?us-ascii?Q?NwFBeqh++s9g8UTigFBibAZ9AellrKyASGOPAO1Lg5jqJ1/zExnlSt7lN1pK?=
 =?us-ascii?Q?0PuvlpZ0bRXQT4T7mijJ9yijt6ANXDkLzYLN8SGWED0Ceps2Q4KjE9oVB2/T?=
 =?us-ascii?Q?HYFVOJIV622Nmi8Pc5HbPAiil83AzzsH4UaE06DYe1Gq43mQxIhgTgJq26MF?=
 =?us-ascii?Q?4OXMzsmyjVSOrFVbzaKvC3j+JE5VxpjHOGTwBzY/Sskem44PA4sHGo4CxIZL?=
 =?us-ascii?Q?5aZYWGXu0mKK808hb0bMbnzVIyFZdqOTbFmrWo5lttfI1QBFTq2cL7SHDogZ?=
 =?us-ascii?Q?rRuMqWlFH7BKdsk1/7Ozx2p2H5vVkfKFM+2pJcDK2mfyf0CWQnAkf4RsQhKf?=
 =?us-ascii?Q?vSzAj4LZfFtB9Lb67W241+YUrvJFg1Rup73EDZwEWnRGlOxVep53fhf3Kpk4?=
 =?us-ascii?Q?/Ka0CmZsqgAPc52bJ23Oa10BFY2CYcoI2xuDQgftCzfAnd5bc9kZ/FKiuidw?=
 =?us-ascii?Q?3rJIzz06imcSyTOts+H/BBlxrN/7GbPyC7U1jCoI8mmbmlWsB51rlWzOKC5M?=
 =?us-ascii?Q?BtW0hkQ4nI4gLk2yeEnGSfXNFJx5chRGTSRJ0B8XvQyRPWqySJFobWaBDhZB?=
 =?us-ascii?Q?6gwvS7R1t3PZUF+3wRkdTENLg85SzMcnVxi+O66pdQZG453zFQn82Yy4H8hN?=
 =?us-ascii?Q?kA7XUHTZe0ad6cM+auJ8jaCIFIWm6147c2gVuOOngypkBCuBAbJwgTE5igJu?=
 =?us-ascii?Q?r9lYR6bX3f0ZpztNlONoQaakn7I0lo995DY70rIXv090CQPIw55tsqpFrxwQ?=
 =?us-ascii?Q?CkBE5VymozGcFgNfraOf5qJDRFJy+5C6v9xsuYQoBNCK9Dg7+PG9PbHQgkY8?=
 =?us-ascii?Q?KxjfxX7e35UpQmfzHsuhlOAis3ku2dFa+ts7Ww+AjLruKkIJ1BBz1Im4uKLU?=
 =?us-ascii?Q?ZI0HKU0/CjYk5Qd9xwnPfTYvTOo5I4XQUKAFk6vXLLp+t/0wfWC9UJfJt04t?=
 =?us-ascii?Q?RTOWkYPVpCrjOCLXadWNb7Mt9oUdvmXnR646/3L0B/vhBxgDpigQq+as7QA4?=
 =?us-ascii?Q?3YlxZEqjPsoiHP197thpM9qsz6fkfc670Km075CRHtQZTO9qltjGwNR/mmIn?=
 =?us-ascii?Q?wHVYyJH/hgPQuB4E30q5kgAgpvYE0PzmFs+kNKnOrTeBuHR/YpxnQ8NwRcz1?=
 =?us-ascii?Q?aaXwwO26CFtxrt0bqlkltIqtHbDveYL201F1V16HqW8yBgi9m9HkCf2UjwvN?=
 =?us-ascii?Q?0FtdSTKOZUHW9yWVJj5VmPiv3XMWT5S1WP4gta/tXEWx+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?psCVAFuEP+d1WszesLeFR2a4afTwX0JQda6TDMIWxBZR1zeHePuHElk3nqgG?=
 =?us-ascii?Q?i6CM7B9UAxWLJAQQY9qmV54nM8WQY5PBdOm8c5z6X8z/E/PiGuONdzcF5oWH?=
 =?us-ascii?Q?qDhOqke6xKp1YTzFS3rznb9TpHTXH7GDQ2QdXc2mH1I31gaRmU4d6D+DeZqD?=
 =?us-ascii?Q?IhBrHSWzwEbDIBYV4FWkgxbC8DAPkygW9ml4pXUtZYefdpq3ULJb2Krmeo2j?=
 =?us-ascii?Q?OZ9PlluLrRwo6DRdtBBtRA9zp7PnTsfguVQ9DIBDg2kPZhPKE8YiOZoL+P4v?=
 =?us-ascii?Q?2GMJfmIXuTDh6vG/1eT95gwISGhjsVvlgHN44AfyPo+slcy8H7JJjNfbmgfH?=
 =?us-ascii?Q?TYZG9PgsRg3wA0YqWOKkJ80Ago9ODFnFmb8USR+VcTKHQFONgIw1zaLxFTKl?=
 =?us-ascii?Q?60m/7Go5bPl/Q+mdfC12jOFwDXldOvhKDgXF+bteGpFfl0mcZudBXapP4Tg4?=
 =?us-ascii?Q?fxC/wcYpzrphtYP61ZICBY86wa5aLgfIYQQJWkCwHqWn9fQWhC6FqCv6N2pV?=
 =?us-ascii?Q?rYMhFV82p7yXshmMUrDWqfip1XxV90h2E+LrYCBfNNDpFFSekb6yQEee7TZU?=
 =?us-ascii?Q?PMrGSPg8neX9HrYCmMhAjMlkh53Oth+EFr9UfEym1Vm70Zwapz9WjbsyKDR+?=
 =?us-ascii?Q?10PNloU/ku8wwL6sFt0eHKNL4qFRXRI2FzBRZQhrPgI1hcbbaa6PHkUGqAfU?=
 =?us-ascii?Q?5f+/zE7fUwAUlY3ZFvMCLnnTXaGjyTG/QaG82ndnTySWYD9Rvlvvah3amlQz?=
 =?us-ascii?Q?WYmCKuP9SlI+BIG6dAMmVKTRXAKWyXZNz+ws/bY3nNpd/6GzRvJJeFpC1oaC?=
 =?us-ascii?Q?KET3RwGEU7C3KLpAe2TX9K054Ol5eLpIZljw7DW4JiCnVFe7dt4+m9jTzTmB?=
 =?us-ascii?Q?wWWHCv4VXkZBq/4u/twAX1t9Yrzv21pdmn94lAlMYDH8G3kSqYByosvpgwEz?=
 =?us-ascii?Q?8Hflj7drWzlwxplON9cs+tBj7dcD/PmGnKVS0411iN2ZT59nG+NQ3pmQ5tTd?=
 =?us-ascii?Q?I/fJYzk1h1q8JSH3Vsr6uzdb/y2RyH/sSjxLStB3TcHzKxPwh3euUxHIAISo?=
 =?us-ascii?Q?QmZMlMOypSHrV3F6cQA9OShuSLnhhFjnWzL22TZuZPmATGe+GuU3jWduAusH?=
 =?us-ascii?Q?bW2j/zYfLvfw/wh5P48Vu+nIdNvxZwwWOCHXVXWcbQ5OHkAbiUx9BZspzjpm?=
 =?us-ascii?Q?qZWvJh/C3Fz+flDOlnqsRmlbihKBf9EfDebCYoKpzjdHW+e2egv2Vphl50Dc?=
 =?us-ascii?Q?owFjc8RsSvybsp1MQlIy4GG0KKINRW6geOLYgI4vn9oqgOXkqafLihI3UJvP?=
 =?us-ascii?Q?vqbWHhHAUx/T1DDJruZKvEXnYNcHzstyFgEI2FqC+0jnCCmIpor5aPmBjS3x?=
 =?us-ascii?Q?j0/tzDQopPr89X3RhXXykRjIsBp/AMuutzmkC947fRY5euUeeJwBkeusFZBF?=
 =?us-ascii?Q?R8AQzskLNJk4qU7/G6xMekXu6SmsTMpRrk4WqmiyAWmmqyClSR+YNmteCRWJ?=
 =?us-ascii?Q?mbAZYANJVL/YdmZ9d0EvVGn7rr7RP6WMqkkoXSuDRqhMw6Q+0Y2U4i0og8jN?=
 =?us-ascii?Q?Opd9qbG8ko/gZaJly4M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0090a3c-2317-42ec-6a2b-08dcc79f444e
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:23:24.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWyMUE05TSBeYEVVKEo7gzrBtAToFdL4mPsUeD2wOrP+HuYZWaZRHzaJjimdnMDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134

migratetype is no longer overwritten during pageblock isolation,
start_isolate_page_range(), has_unmovable_pages(), and
set_migratetype_isolate() no longer need which migratetype to restore
during isolation failure. For has_unmoable_pages(), it needs to know if
the isolation is for CMA allocation, so adding CMA_ALLOCATION to isolation
flags to provide the information.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h |  3 ++-
 mm/memory_hotplug.c            |  1 -
 mm/page_alloc.c                |  4 +++-
 mm/page_isolation.c            | 27 +++++++++++----------------
 4 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index c2a1bd621561..e94117101b6c 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -32,13 +32,14 @@ static inline bool is_migrate_isolate(int migratetype)
 
 #define MEMORY_OFFLINE	0x1
 #define REPORT_FAILURE	0x2
+#define CMA_ALLOCATION	0x4
 
 void set_pageblock_migratetype(struct page *page, int migratetype);
 
 bool move_freepages_block_isolate(struct zone *zone, struct page *page);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     int migratetype, int flags, gfp_t gfp_flags);
+			     int flags, gfp_t gfp_flags);
 
 void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4265272faf4c..fe0b71e0f307 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1993,7 +1993,6 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
-				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE,
 				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
 	if (ret) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4d06932ba69a..c60bb95d7e65 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6607,7 +6607,9 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(start, end, migratetype, 0, gfp_mask);
+	ret = start_isolate_page_range(start, end,
+			migratetype == MIGRATE_CMA ? CMA_ALLOCATION : 0,
+			gfp_mask);
 	if (ret)
 		goto done;
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 4c65157d78ef..07c58b82db76 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -31,7 +31,7 @@
  *
  */
 static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long end_pfn,
-				int migratetype, int flags)
+				int flags)
 {
 	struct page *page = pfn_to_page(start_pfn);
 	struct zone *zone = page_zone(page);
@@ -46,7 +46,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
 		 * isolate CMA pageblocks even when they are not movable in fact
 		 * so consider them movable here.
 		 */
-		if (is_migrate_cma(migratetype))
+		if (flags & CMA_ALLOCATION)
 			return NULL;
 
 		return page;
@@ -144,7 +144,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
  * present in [start_pfn, end_pfn). The pageblock must intersect with
  * [start_pfn, end_pfn).
  */
-static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags,
+static int set_migratetype_isolate(struct page *page, int isol_flags,
 			unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct zone *zone = page_zone(page);
@@ -179,7 +179,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 				  end_pfn);
 
 	unmovable = has_unmovable_pages(check_unmovable_start, check_unmovable_end,
-			migratetype, isol_flags);
+			isol_flags);
 	if (!unmovable) {
 		if (!move_freepages_block_isolate(zone, page)) {
 			spin_unlock_irqrestore(&zone->lock, flags);
@@ -290,7 +290,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * @isolate_before:	isolate the pageblock before the boundary_pfn
  * @skip_isolation:	the flag to skip the pageblock isolation in second
  *			isolate_single_pageblock()
- * @migratetype:	migrate type to set in error recovery.
  *
  * Free and in-use pages can be as big as MAX_PAGE_ORDER and contain more than one
  * pageblock. When not all pageblocks within a page are isolated at the same
@@ -306,8 +305,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * the in-use page then splitting the free page.
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
-			gfp_t gfp_flags, bool isolate_before, bool skip_isolation,
-			int migratetype)
+			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
 {
 	unsigned long start_pfn;
 	unsigned long isolate_pageblock;
@@ -333,11 +331,9 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				      zone->zone_start_pfn);
 
 	if (skip_isolation) {
-		int mt __maybe_unused = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
-
-		VM_BUG_ON(!is_migrate_isolate(mt));
+		VM_BUG_ON(!get_pageblock_isolate(pfn_to_page(isolate_pageblock)));
 	} else {
-		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), migratetype,
+		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock),
 				flags, isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
 
 		if (ret)
@@ -436,7 +432,6 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
  * start_isolate_page_range() - mark page range MIGRATE_ISOLATE
  * @start_pfn:		The first PFN of the range to be isolated.
  * @end_pfn:		The last PFN of the range to be isolated.
- * @migratetype:	Migrate type to set in error recovery.
  * @flags:		The following flags are allowed (they can be combined in
  *			a bit mask)
  *			MEMORY_OFFLINE - isolate to offline (!allocate) memory
@@ -478,7 +473,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     int migratetype, int flags, gfp_t gfp_flags)
+			     int flags, gfp_t gfp_flags)
 {
 	unsigned long pfn;
 	struct page *page;
@@ -490,7 +485,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 
 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
 	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false,
-			skip_isolation, migratetype);
+			skip_isolation);
 	if (ret)
 		return ret;
 
@@ -499,7 +494,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 
 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
 	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true,
-			skip_isolation, migratetype);
+			skip_isolation);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(isolate_start));
 		return ret;
@@ -510,7 +505,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	     pfn < isolate_end - pageblock_nr_pages;
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
-		if (page && set_migratetype_isolate(page, migratetype, flags,
+		if (page && set_migratetype_isolate(page, flags,
 					start_pfn, end_pfn)) {
 			undo_isolate_page_range(isolate_start, pfn);
 			unset_migratetype_isolate(
-- 
2.45.2


