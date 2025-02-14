Return-Path: <linux-kernel+bounces-515225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA36A36205
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717643B0978
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB4267391;
	Fri, 14 Feb 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ndcCe9LN"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448DF266EFE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547750; cv=fail; b=XUivfRk8cXMbcknhnhTbmFpNWaz3VvP/ocIiKdvLaIyQDe43puHQIQoPGVgW7k0tulkrHnIS/JTUExxCdlVipluIiAXgkVbd/zInzlRraal1IOPaAHNFatCDHuzCtS45LH2iYKxaMejJTxB8TUiC1h2bscdGPo/i98AL7eIIpGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547750; c=relaxed/simple;
	bh=t+ojR14eNEZc6uxP0HjYSPTvSlOZcN+q/vemDcmLcRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uws6RPIGjPEBVQsgkuAWvtf0cPvYmYgKhabgsBbeWwHQXJU6GRAdpsyOm0Jg0psd7dFxGoi17xOi7nSbCBlmTP61d2EBXzT/jFnaBnoZvVkjYktJtIn3MA78Dge/hLD54RwTymTRFRpW7ZQ97jI/QurFkbeIbpSG557EWv2Tw/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ndcCe9LN; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPHg5r7ppzyYSV2+BCHWue17bD8SpU+9hKde0Mpvzd2hQ4Gcgiqlshh7r+x+/sZ6/cbw7661/j0jwek6f/+lGvEOPKvR9XmLwC9III1DeZU4R/8SA5ZA/XGnhEq7AoEj0vghcXRlH6RAuJFm8fkrRhzPTS6JNtHYmr2KdK0g12hrX1bW/5R8iUhza66p6MwRwGMsO9OTurjSZ1+WB2iy1WdilS3yYFxOs3a/fpXhp/Gual5bZXLAq2NQiT6LNKoxdMrjtONKQPBbThdrIIoUqLA0dVgypK66u3euhJ7/ATxouuCc4CuwzoDIVv4KldDoZLXEN4niYHzt+1k6nFYF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AebmBmJkIAuQ7h16HolSR4JegMPa7EHSV1KqsaK63Ow=;
 b=oQeKuA88qfEU3vyO/V7GMhWE1JZRGfEM8qvwh+kBGYW/VJ4Mc0RpPYxoLuQwW04ReFDx1r9TisuxKwvlfJxlOFqYXxUR+SKTSt8fIe2FR0nzPTg2IRvikILA5ONGGR0BTXpJj6rgP19UKMnS1gmjGrfgfP/iRyb/feFvLmHiRgyYnU/mbAF5ZXKUMW3RK3e7mnWdD1XCmuRqHxR5xUCSsvb0PTy/nbfd32xVZV7U+k5KCzcTdBEFvxKoFI4zA08nFSs0fJMiNwh4hnSvnWNz8jcEeRuueRMRr8396afBsCkk1wMX3OqU7e+RCMoBHTPBSbbW4KnQKsEIb3+Lwc4ueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AebmBmJkIAuQ7h16HolSR4JegMPa7EHSV1KqsaK63Ow=;
 b=ndcCe9LNbuiXBcEVO7xZfNKtkrXt4mzQP3JP1rfh8uOlitgLwpFb6E4KiiljeiMsspM7jtG9a8Vo0HA4c9yJ41oaZPgR7WPiSVZw6rKByhoFlkpY5EKj1C8UVT1qHh82g5XzR3w2jH2M0UiLtwR1lohbU1qm2RwSr+hdW+yjgEjRgzSwaR3M5nU86RTIkIcOOg5mRZZVOsXM9cw2tVytWBKbBWxchHBtqvQNV9z5p7yijYGJV5tMD4j7BnBVJaXFyvKF6npWhnfMudb377dPO4APcFCPnpc+lGgW4YU1hpP5W8clVWcRe/EVL7yrLGZUjILrgjbFKpW4qfZS5HgzJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.14; Fri, 14 Feb 2025 15:42:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 15:42:24 +0000
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
Subject: [PATCH v2 1/4] mm/page_isolation: make page isolation a standalone bit.
Date: Fri, 14 Feb 2025 10:42:12 -0500
Message-ID: <20250214154215.717537-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214154215.717537-1-ziy@nvidia.com>
References: <20250214154215.717537-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:208:52d::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ba1d9f-37c0-476f-09b7-08dd4d0e2d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxmdowwLmZYoXQfU1A24v2y++AMfGflHKUgGPAM9v4ZygP7eLkowhmD/YW12?=
 =?us-ascii?Q?YMHDA8pW4zh0GsNWxQ8SlMiRBR2LgiIruSNPEPCunDsOgNNNdUE2D2o89ab4?=
 =?us-ascii?Q?G5ZVKDQ3tG0bLQTBUaayFvYR9klgfcV9BaCmS8z++AYavghnKHWVvdBOztXL?=
 =?us-ascii?Q?7kwFepXhf5t5PBHtM5d5rQKy+FJoOY+YYxRA/ObJ8Gw8xQpxqJSad4yx5oWj?=
 =?us-ascii?Q?kW0sQoK4bHnnv/ihF4KbCIlEq54dQg6yjLbLJtfvQhJNc6gXGhkYXxuAMJmH?=
 =?us-ascii?Q?5Faa5rsHEOhdM/LXTLIVxZcKneb/4FPy0Z7i0Ac8cSRg5go0Wh82+UevSesd?=
 =?us-ascii?Q?hKrMhZdUGcH1H3XzIr6rypHFaCcRGMMaSaC8yx6XiGzyaE6TET69mmc0xIAk?=
 =?us-ascii?Q?rnGtrJCxcb6TclgkioQ5Dd4mj9KJlr2xWKpdPpDfdELurA2Y1m8eplMYo2M5?=
 =?us-ascii?Q?il1i39taUlTZWZW/NZEU/svFJZbI31v1+Vwq9MF81+jI4z1lZ90XUxxUq8Zm?=
 =?us-ascii?Q?XwjyhWPfWq1fen4vIWgIjNJ+Nc5ggI96gBZGN4k2EiAruBFaebGIlbrcIsr8?=
 =?us-ascii?Q?dHl7KHTChLfKicWH5ZPYt+aVEL8GdvY8zQ+R7U9HA3JLWl7HPj1Cl0q0uQqN?=
 =?us-ascii?Q?RY6eStQ7TVPn9flVsB4GrPRVZUEzymV0tE+lI8GwXfbG2V+S5mWIwkSpoNDv?=
 =?us-ascii?Q?rJfgij723XBt0MibxR9fiXYkGtyDrdeq94B+AHsexsFWZLGG2/IeSPixCaOq?=
 =?us-ascii?Q?LZHSaJmrJNfuHmq5uWVMYj8z2zTNKUBEgbV/INaI6edHDF3CCQ98dWn06fHM?=
 =?us-ascii?Q?RRdCrNpZozvbIIZLNofP1WSrzyMKoxWirWd004fywG7hCpJjzvA9VTFxPIZj?=
 =?us-ascii?Q?lFrXDH3jqKOTXtMCh7/7suVCD2srisOSfV9S4VijU9488PYZqErDbT0QNwiA?=
 =?us-ascii?Q?F6tDj25XYFe22jzXpEaVGsP2B6f6YX5lDFBQNj6lB5idPI8hhO7/Xosub/hn?=
 =?us-ascii?Q?T1mO91yUOwnfrGGeGAb24NuuPWRPdS/zIDOJ9S4K/oU3UBuT4m39+igy0vFT?=
 =?us-ascii?Q?jSdbaucgUm+oCsKtT6zm7lVT1un3+y9TLPDT3mGktu/DvF1DlTwatwlNruFW?=
 =?us-ascii?Q?mzricjdZBEfem0y8AmZ1NqmIazkzS6GxeuoIHBjr/cWA1/SWDrYpaAFpJmkL?=
 =?us-ascii?Q?dl77nZK2j4a8f0Kz2zyoKSt94BiRNsUDaeC2TfMXqpo1Ocr8YM51xeIwgHvk?=
 =?us-ascii?Q?dTrYsG7i7IHCMTevqTApqLkOMH8Oxla7bG0+Vc98qLSCLwVu/TUIr1UrHtrA?=
 =?us-ascii?Q?IqCRBxSjAsYTiB8pcvsda5z92MhzghqCnASqKtiGH0v3VAByvEea1nq73B7/?=
 =?us-ascii?Q?TzUwwOnl1DmLnmgVWLyLI9viTKEq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8UW9o0egujEIDx9Hat6VaHAeAqpnhtDpooDZCaodjDnI2E3ZAIHQrDuvIMXj?=
 =?us-ascii?Q?vgUzDi6kIJoaFSC/5gAUsoTjE8G6U6ay33sJM/w0BxyCK8+2t9YRDgmFOacX?=
 =?us-ascii?Q?A5ZT8vmujNYWCf1d3Ey1SaDrvjCKsntT/gLJVFla18VqUoFQHn5emHjEVqeS?=
 =?us-ascii?Q?icpXcTMfTrmfT41rnceGRW7FeA5N091+qt+i6/vS2tfyjrKQ4Nl3pUhDvDxF?=
 =?us-ascii?Q?f2JRHFBgSpolnU+N0iOAMnppSvUgzdDRrtWmrdSWyvrXB/mkNtjntz+OC/eA?=
 =?us-ascii?Q?u+d3+jmJUyJaeXr64uxA9yGK32GPg8WaCC10deMthawcwLoXpPGXaBqwURUT?=
 =?us-ascii?Q?pT5Kbz0kfwsBx/bNBXWLVWaK5gcc9/ozLZtrjIno/ABS+l4MQg2T/atwRmPb?=
 =?us-ascii?Q?hiCETU4f45WUeQKr+kZKdZj4SZfp0wotfKuhthavBliXGmudW9ZGKjme86fF?=
 =?us-ascii?Q?fqU2Rxau4N3CThtma/J4SqcTCtcFHct/jxExGt4XnwGLtLvqpCHlelZy/+sC?=
 =?us-ascii?Q?YBJfmohC0HornGHjW6XKjLR01DffN4iLYkfWl/SzUoxFfaDY7Rgdlamh+BxG?=
 =?us-ascii?Q?RJF7CcZyz/Oaa9gnGVjrxnVd3hH7lquGRpSJ7KiwdnyJYdfgyvi4in1l1tk7?=
 =?us-ascii?Q?ab9t+U+wMiZGQFjpWVgNQQtnAVqkG063Oe6JAgkG12z29zKyaDJOFVf+jUQ1?=
 =?us-ascii?Q?ocJWQ5pTgVxMJMiAHudM3JPHXcktYR0W88+Bbk5IK4QtQihH92qIKCCuY6mU?=
 =?us-ascii?Q?RuQBFiDdjcKThhGLZudWa3VgKDS3+2vq3sk3gU4TftK1PcEvSl3QRZ09RrVJ?=
 =?us-ascii?Q?GW6eVeHYyuWiRpxl9MTiRi587ahX9UKcEYZUf1q88ZQOxQTMuqEjomUJKQjO?=
 =?us-ascii?Q?35ykwgKQXmCOkpg62SOqDtQuW1oEJJ3FB4VL+B3kyUmJ7YcxO55hjNp/mHde?=
 =?us-ascii?Q?IzbMGQWoipgO9NjDnUWXnrxxWAmNIshw4T9/AJ8/yTql/XWVT1c2Aq5WWuMu?=
 =?us-ascii?Q?zY8+6AmR7znT+OP47DviGjpPxTxac8tduq179N7EJL3q2zr7+9mmSGMu9eGQ?=
 =?us-ascii?Q?DWvLtTP0GBmUlmCIIXF9wrdL2GWGnUMtbhacXg+a1KGOiJONSt6Jml+fzXky?=
 =?us-ascii?Q?wwO/ONOTbu6NSoKP0C0vcHM2ye/bh+23fcd98EWSmrcJcjE2eHSBGjNN7vdz?=
 =?us-ascii?Q?bWyiYFTYvXP4YyLURBH7gWWjq6B+TKkwxwOYSdBZ7n22sVm+88HguY/97AtT?=
 =?us-ascii?Q?Qu/l8OHgkWgKd5bKIZRPb4a5WVi4rwaarva7t/kdyljmWrdNi0iR0DzAVgMh?=
 =?us-ascii?Q?YXX4xnT1y63STu8jX3nlbORnAlJbqO5wgwuYTZFBPA5UN4lcxCXhKDTQEbI0?=
 =?us-ascii?Q?imIvsxiMp81KCOmYvr+pGOIe7RqLwKX8dvY60WWWZeN/X/+vOrfgnYA+3Hu6?=
 =?us-ascii?Q?2v8gyS63PdvdOeyhVO9kuaN200bYXEYDCiZFY97DNu4uPRDvAb5DJFUf59Ik?=
 =?us-ascii?Q?Se+QrPrsSpugTXr9rNaMsMefm8PTQDBwG9cieMKIqSnpjw41lOIV9dL0fnA+?=
 =?us-ascii?Q?rXA53ttkAwWuqqVRBj8Jb4T4l7LJssyvjXUfkq14?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ba1d9f-37c0-476f-09b7-08dd4d0e2d56
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:42:24.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BQljV9wq+4Fgs4DmRO1GFk0C538OvTrgMr2IS2dZ4JqZoJEyyOoHzLamhDfD2QK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

During page isolation, the original migratetype is overwritten, since
MIGRATE_* are enums. Change MIGRATE_ISOLATE to be a standalone bit like
PB_migrate_skip. pageblock bits needs to be word aligned, so expand
the number of pageblock bits from 4 to 8 and make migrate isolate bit 7.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mmzone.h          | 18 +++++++++++++-----
 include/linux/page-isolation.h  |  2 +-
 include/linux/pageblock-flags.h | 33 ++++++++++++++++++++++++++++++++-
 mm/page_alloc.c                 | 21 +++++++++++++++++++--
 4 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8aecbbb0b685..3c7d3f22ccb2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -106,14 +106,22 @@ static inline bool migratetype_is_mergeable(int mt)
 
 extern int page_group_by_mobility_disabled;
 
-#define MIGRATETYPE_MASK ((1UL << PB_migratetype_bits) - 1)
+#ifdef CONFIG_MEMORY_ISOLATION
+#define MIGRATETYPE_NO_ISO_MASK (BIT(PB_migratetype_bits) - 1)
+#define MIGRATETYPE_MASK (MIGRATETYPE_NO_ISO_MASK | PB_migrate_isolate_bit)
+#else
+#define MIGRATETYPE_NO_ISO_MASK (BIT(PB_migratetype_bits) - 1)
+#define MIGRATETYPE_MASK (BIT(PB_migratetype_bits) - 1)
+#endif
 
-#define get_pageblock_migratetype(page)					\
-	get_pfnblock_flags_mask(page, page_to_pfn(page), MIGRATETYPE_MASK)
+#define get_pageblock_migratetype(page) \
+		get_pfnblock_flags_mask(page, page_to_pfn(page), \
+			MIGRATETYPE_MASK)
 
-#define folio_migratetype(folio)				\
-	get_pfnblock_flags_mask(&folio->page, folio_pfn(folio),		\
+#define folio_migratetype(folio) \
+		get_pfnblock_flags_mask(&folio->page, folio_pfn(folio), \
 			MIGRATETYPE_MASK)
+
 struct free_area {
 	struct list_head	free_list[MIGRATE_TYPES];
 	unsigned long		nr_free;
diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 898bb788243b..51797dc39cbc 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -5,7 +5,7 @@
 #ifdef CONFIG_MEMORY_ISOLATION
 static inline bool is_migrate_isolate_page(struct page *page)
 {
-	return get_pageblock_migratetype(page) == MIGRATE_ISOLATE;
+	return get_pageblock_isolate(page);
 }
 static inline bool is_migrate_isolate(int migratetype)
 {
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index fc6b9c87cb0a..d6fe17bf0c9b 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -20,7 +20,10 @@ enum pageblock_bits {
 	PB_migrate_end = PB_migrate + PB_migratetype_bits - 1,
 			/* 3 bits required for migrate types */
 	PB_migrate_skip,/* If set the block is skipped by compaction */
-
+#ifdef CONFIG_MEMORY_ISOLATION
+	PB_migrate_isolate = 7, /* If set the block is isolated */
+			/* set it to 7 to make pageblock bit word aligned */
+#endif
 	/*
 	 * Assume the bits will always align on a word. If this assumption
 	 * changes then get/set pageblock needs updating.
@@ -28,6 +31,10 @@ enum pageblock_bits {
 	NR_PAGEBLOCK_BITS
 };
 
+#ifdef CONFIG_MEMORY_ISOLATION
+#define PB_migrate_isolate_bit BIT(PB_migrate_isolate)
+#endif
+
 #if defined(CONFIG_HUGETLB_PAGE)
 
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
@@ -99,4 +106,28 @@ static inline void set_pageblock_skip(struct page *page)
 }
 #endif /* CONFIG_COMPACTION */
 
+#ifdef CONFIG_MEMORY_ISOLATION
+#define get_pageblock_isolate(page) \
+	get_pfnblock_flags_mask(page, page_to_pfn(page),	\
+			(1 << (PB_migrate_isolate)))
+#define clear_pageblock_isolate(page) \
+	set_pfnblock_flags_mask(page, 0, page_to_pfn(page),	\
+			(1 << PB_migrate_isolate))
+#define set_pageblock_isolate(page) \
+	set_pfnblock_flags_mask(page, (1 << PB_migrate_isolate),	\
+			page_to_pfn(page),			\
+			(1 << PB_migrate_isolate))
+#else
+static inline bool get_pageblock_isolate(struct page *page)
+{
+	return false;
+}
+static inline void clear_pageblock_isolate(struct page *page)
+{
+}
+static inline void set_pageblock_isolate(struct page *page)
+{
+}
+#endif /* CONFIG_MEMORY_ISOLATION */
+
 #endif	/* PAGEBLOCK_FLAGS_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 16dfcf7ade74..f17f4acc38c6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -362,6 +362,7 @@ unsigned long get_pfnblock_flags_mask(const struct page *page,
 	unsigned long *bitmap;
 	unsigned long bitidx, word_bitidx;
 	unsigned long word;
+	unsigned long flags;
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	bitidx = pfn_to_bitidx(page, pfn);
@@ -373,7 +374,13 @@ unsigned long get_pfnblock_flags_mask(const struct page *page,
 	 * racy, are not corrupted.
 	 */
 	word = READ_ONCE(bitmap[word_bitidx]);
-	return (word >> bitidx) & mask;
+	flags = (word >> bitidx) & mask;
+
+#ifdef CONFIG_MEMORY_ISOLATION
+	if (flags & PB_migrate_isolate_bit)
+		return MIGRATE_ISOLATE;
+#endif
+	return flags;
 }
 
 static __always_inline int get_pfnblock_migratetype(const struct page *page,
@@ -397,8 +404,18 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	unsigned long bitidx, word_bitidx;
 	unsigned long word;
 
+#ifdef CONFIG_MEMORY_ISOLATION
+	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 8);
+	/* keep other migratetype bits if MIGRATE_ISOLATE is set */
+	if (flags == MIGRATE_ISOLATE) {
+		mask &= ~((1UL << PB_migratetype_bits) - 1);
+		flags = PB_migrate_isolate_bit;
+	}
+#else
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
-	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
+#endif
+	/* extra one for MIGRATE_ISOLATE */
+	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits) + 1);
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	bitidx = pfn_to_bitidx(page, pfn);
-- 
2.47.2


