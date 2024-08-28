Return-Path: <linux-kernel+bounces-305650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9799631B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207241C21F94
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1715749A;
	Wed, 28 Aug 2024 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SpXptOvD"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A031AC45E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876605; cv=fail; b=ZjYkcjN1TZGT/niCqJSNGlzCOdz4IlO5y/OIVD1I5qiJoc2zUnPJ3Q1MlnAm6HXHknnhywAkywAsUE1huwBTXNHbld7mMHLAIKJcUYv0ZnstVYXgyQqcyxkMUk8eleO8gMxzxethIvrk+2HzdX9fYziCC83YoUVenXtBhL47FmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876605; c=relaxed/simple;
	bh=C3cRp56+JYf9d0zEbOYvpIt1kKnOIggYaW/bG40nE2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vCMKrRtTaNoneDz88W86+0DKFkWJP20Z5k7oybeLOdHcYJ0FiARw0DEsh00mzngrdFMmXK6HsM+Kv6QCE0DRWQvo+8Gr/2POrNQxpgxzoPIpCIs7Z4cFOmZ6DYd5jWozbXpm26YnxIUm8oOilDJnk4SmyTZJCED4tNUSWeQeevY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SpXptOvD; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk1Aql1N3bPUiIqCz4DigwAy38KAu2oxrRm7r2CGywrKhtc0DfTGJDAmOK66PMdcFlyXhqL9em9uVAKKIUAvx+BXtafKy4vWVWFMOpWARD8SYq0e8fC+UHVuKbXvqVc8Ki9G61F/k0CNw4c9pkDLRl2uMJFPGY94npTHGw0HEHS7krHzL8zp1wZSOrePkXZLAOlibItAkH0GBYxfV2Tz+Czz0TKV9cpEVu2aX9H2E3aIh4SM0ZGh99xucrwaHxPEyrhiG4+PU8xMueRmCPbml6mnY/hizV55eJzSZLuRSqpReErZPU1yDy49YGxcLWV4cduUHF/pCwmOi5zNpAwizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zpM54XLlKeXzRoO4ZQiZhoxVX7+BY03S5QPKaQfn+4=;
 b=Lz8xq26Uw6GhSX+xGP8SbGJO/NbLvB0KEEa/nJFzXbYN9Bkiy8S/qdZa1oi/lTpnmdDaS7uFdwxDsSvr/MIGL+GXxozQMIB94Y8MD+vtBDCI0ebwDvojznKKqTbhwwFDSluA94zyV3hANpVxX8AqTwWZuqeLyVYEiXIHiZBBw9DWe1xzBOQyjpuhxxhmey8sWDMNGIsEle51LQWNh6YVIlGfYFYBqMRvnDVk9a5514ZCzwy9MUZGVHjt0K/rCM0vhuAOMd5mD1qdeaDAH3kFkyRoPcmLkd3Gw0/t6RXnr3J+0Xe73Bxk1eq6eTDIIGlWy1uO39YC5gv70Ka5ZAEoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zpM54XLlKeXzRoO4ZQiZhoxVX7+BY03S5QPKaQfn+4=;
 b=SpXptOvDpsZKMUDHhYJj6V+y6dgDZIoOtjGN0oMbpsEkDw2RaO/GJyy3oL6OKwIA2FzZsuD/plID6IJDixm1cIPt8cKxb4ybFqd6Nel6+et2c0870F1OTfTVcer7i9OD2vUHtP/0NQGqSWl65IqAVPS9RSAd5y85PPIIR2WgCzZzLlIoFDToz41NVc+sCG2G2P47Z2jefuV7m3f4NEGuvMlRoNL6C7gRlXS2zwuwMfs1xbtKKacFnGcU5ALrWdjhZYtNu7q5nimm41ra5Bg1oYmWeMkzkrkV3OS5HCyFaKq+EfnGMZX+exYxngQ3QvfUqc7GF57VHzs6DzCXHDm6uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 20:23:20 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 20:23:20 +0000
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
Subject: [RFC PATCH 2/4] mm/page_isolation: remove migratetype from move_freepages_block_isolate()
Date: Wed, 28 Aug 2024 16:22:38 -0400
Message-ID: <20240828202240.2809740-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828202240.2809740-1-ziy@nvidia.com>
References: <20240828202240.2809740-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0979.namprd03.prod.outlook.com
 (2603:10b6:408:109::24) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: f54a0698-144e-452f-dd84-08dcc79f421d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lRPe3xx8kKY1/oS3OsiMZGqR078vvrOXjsqaJu2raeEXyN9Sj5vaqyw3yvBj?=
 =?us-ascii?Q?y4xNGCWKVfzfxxfTNcn7BBwLxG0jne/VMtJIzQiDdpOImnqL7JBUmwlSIa7A?=
 =?us-ascii?Q?z9s7qQt2Yyu2dz0mFUJ81pvx4j9u+PhQQ2xbXAhr0WN7nra8Uhj6zeEG693i?=
 =?us-ascii?Q?66QWJDVycIu0vnQ1NwK77W0+M1uIJ+TGu5VQr2t3yzFako4Xn0aXYCeiLqSy?=
 =?us-ascii?Q?+zDDYRfMGlXn/QplyPuy/mvIS477Egiuo2ceo18jCBHtF76pY47gaXFLkX9z?=
 =?us-ascii?Q?dAe4clJJrTUAFCWgeUUNy8zABDjgfZsyw/MTfhdD0yXvXE0XtPQdo0O4duit?=
 =?us-ascii?Q?aB9JDQUImqJpKN21Xpct8UQxH31rHbsjPWTYDdG5oED3BZ3FoI0HojVV8PsL?=
 =?us-ascii?Q?GE+RaAdpPQg5dRCniO+uIypPODyEZ+ok97VzML+1cYqplA2doJGXxUIuyRXk?=
 =?us-ascii?Q?5939HI7S4LiKF83+eSx/kSQxh5Nvbx4kCzOje35OZ4TWucoQnlRTPLtzHR2v?=
 =?us-ascii?Q?322OcEAcQWPE0mJ9l2g61VYDDZz+XUhhC3BqUi44fNsDBvnmX3RjHV4ozGPF?=
 =?us-ascii?Q?ge5NuEQ3bZc21nds0hu58ddYgeo+r+ev0O4zfAuhDWGKjSee+a+fadCu9nP/?=
 =?us-ascii?Q?wl8oX1XP/c5s2ZhSLJ8Es+H2B3aeWx8tehtcCf3ar3n7yu2WZ1DJfK9md31N?=
 =?us-ascii?Q?MPDt/Mk14H3v7kqSmS8JMhtTnb6b/jAj9UYwmmshCu413nnWcFFpPcP/DEqM?=
 =?us-ascii?Q?uZbpQi/md6fRj/IBy0tQOmtwBjQ/yPQ/3DcUTcWTF+p5y7PIgE6UbqkFQI2x?=
 =?us-ascii?Q?vALBXfOwMDRedoHCXr76KctseEx5u8iezwNO16R/1gqAEDblIcoMN65gsKKa?=
 =?us-ascii?Q?Jfc14YbAEjFI32x4YYJsouENCdsV+Y+6/IbOlLH6nY2+xPmQtvLZa2tlyjnf?=
 =?us-ascii?Q?DG9lP30AgtmhAsLqh1h4LLinfcBjvzWQCIBgrv2nxb+of4BiIofD8+zNshok?=
 =?us-ascii?Q?caZdS4aJQnV/vA1mqJUe/K8GFJJhqKGvQB32r1GpxWGRzWVEKrKjtcwBDL5R?=
 =?us-ascii?Q?BEfH6/aVluyRIn7DZ2LU2Z76pHqKqc8zIEtwomFZ1h7t0T51XckdiV8UJH2A?=
 =?us-ascii?Q?J+QW7a6wJnEw3K2yK3pVClQAgFY/k6FWC88cQi4lwiG3oMPrCyU8YJMEUv/6?=
 =?us-ascii?Q?psZYG5Jd/LrNxuoxLf1rBh9Y1NDzsYXXINjT/KXnovEy2OU1tBBUPkpF8y8l?=
 =?us-ascii?Q?dVu5ChNxgy0cdQwpCMRNcm/sdF18Hl/RtpnZmIAn/XbrfCRoD2ssx1UKcCzi?=
 =?us-ascii?Q?wsCZ+UmKQR4A3lqclflXnfbonIdK6BCXbd1wyVi2Sy+w+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jvBBIKoDL04+bLFO2C9XZt366YgW5iKmablCYOHvi+5zh6+JGhV9+/5wgrDV?=
 =?us-ascii?Q?xbWHd2Y/mLz3nETYkBKOx9wemeuc46rAjbE0ne03nBDBbngE996li4seDJzm?=
 =?us-ascii?Q?ZcXM3w1RBF4HhccwZoEGJcfecDsp3ExvPeBoRky7C488/5lNJPehM8QO7cag?=
 =?us-ascii?Q?CDeQnHKz8fHisF3zs4UevFTt8FrFortZzHvsFJc5s8s9xXucgSu8rRKYwhfi?=
 =?us-ascii?Q?AOB5Y80/jmqyOBrKRNjZGk7IhaQBQy8z0x9PQOdAjeNlj2eoRCWQesEUx502?=
 =?us-ascii?Q?9thvCQ6DCNcz+Z3Ls1b1jPYzCGTwelOI/OpXxajE8tUR/fXhKnjrXAr0IOz3?=
 =?us-ascii?Q?aBgRGH4mg06t+STTxErgQlP3xgrNMe45pCbyBImMSb88G2h+FLd7RdDGPgJL?=
 =?us-ascii?Q?Ut9COM9lwTImS4T/009upajGfU+fsIwIwMWX7VMQtoddB1FSRBw70Jk+mTNe?=
 =?us-ascii?Q?NCnv/cz+l6AjG3kuDd0xXBWDFWFdPyef6MPC3RtPMzY93g8ydU6OruW6C6kg?=
 =?us-ascii?Q?VTmBpxS8S450Xjo0+VmZ3Rvqko7gD7/CPLdfl/rVE7BWcZqnS6tbV2rCY1f8?=
 =?us-ascii?Q?2LJNiMyq+nOBpc38okBM8JZkoQTVIna6oFLUvim9yZ68aOBM99HfPsT7zt1Y?=
 =?us-ascii?Q?uXZRbLltyXMNW/CLZcFPDE6bJQulfqc9RN1A8npJfiRYW5JLqMfNRx7ixo57?=
 =?us-ascii?Q?ROI8phRZjnjlmrND2mk8t+0sqkbJqnv/HufosVxDPDoTb5BTcx/19Q0PNweA?=
 =?us-ascii?Q?isDiO3gzsjYYx2/njCqsSzsOaA9SPWaz5/wyTAeRSlvvPUo7lbx1Bua9JJo4?=
 =?us-ascii?Q?xqPgbJxwCmp6SuPIDsqDu2ivRkqLPoBBP4v73G6U4J6sbk7JcvgBpMmAlu0J?=
 =?us-ascii?Q?C1wICn7k01ajK99JV3CeCgZtsGpXJb7TUbjTLdXsSqCyQbmuZjImgYcTarOh?=
 =?us-ascii?Q?lXn1BxrXJu+piqu0Hl1nLW91AlDGpWmd+2oew9XfbeE0Lw3C7i1g23g/KzaE?=
 =?us-ascii?Q?ZRZcmtimibOxZFfXFCdauJaC+aNfO5wbCVd+BQkVEApETt6J/F5nruWRYKsz?=
 =?us-ascii?Q?XHMEHYzmgJvHB3+iq+X4ywP6hc+JzgoDzbDju+ADS57xwAbZFtFcZr2alPKK?=
 =?us-ascii?Q?ed1YRUBaPf8HQhi6s2z2udPXxzYQC5Fe+ckaVJ4IapnYr84u183mHGUvdFq7?=
 =?us-ascii?Q?CW0VVp3yjuyQmaW4JNlgR6brWaSVLClcUwLBdFsMbI9Z1OezZVUNXjIHgajf?=
 =?us-ascii?Q?qcUTkjtoRFLUC+Jj0107VXFinXf7EPWetMm6wBEZxtZlaUiddyPErYhBykN0?=
 =?us-ascii?Q?tKfllqqQGTSdeP/1iqIuq0E1d3sMbiCeLntUt2h6NrMCd22C5P95XYFuzJjD?=
 =?us-ascii?Q?xxMYU3J3VLALAVwHYGctApmweF4eAFS4jaTMw0XWDZTgzniGcPrWV0yOsGcX?=
 =?us-ascii?Q?Xj59LvkOEeS1FBYZlxYh/i8lz7jhof+y7Ik4I0pPylie1nRworowas2x9MD1?=
 =?us-ascii?Q?nZRYpXcZZ9DFwv8pLXdgdb8aZCHvzRSVopXIKidoVaTnVr8Kxn4sg0UGt6E1?=
 =?us-ascii?Q?3CE35LV3qMdvq3ozY/1KnKz7Ry0OXXCsQStpiMcF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54a0698-144e-452f-dd84-08dcc79f421d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:23:20.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgVJZGT0Jvi54UQGdEdfmHGiYwIvhjTDQsmwQYz2vefbOL+ZvmCtdWOsYyVa6Q02
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134

Since migratetype is no longer overwritten during pageblock isolation,
moving pageblocks to and from MIGRATE_ISOLATE do not need migratetype.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h |  3 +--
 mm/page_alloc.c                | 27 +++++++++++++++++++++------
 mm/page_isolation.c            | 19 +++++++++----------
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 11b8695115ea..6a62401410c3 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -35,8 +35,7 @@ static inline bool is_migrate_isolate(int migratetype)
 
 void set_pageblock_migratetype(struct page *page, int migratetype);
 
-bool move_freepages_block_isolate(struct zone *zone, struct page *page,
-				  int migratetype);
+bool move_freepages_block_isolate(struct zone *zone, struct page *page);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype, int flags, gfp_t gfp_flags);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4ea5cd1a07e2..dc7c36461953 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1764,10 +1764,12 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
  *
  * Returns %true if pages could be moved, %false otherwise.
  */
-bool move_freepages_block_isolate(struct zone *zone, struct page *page,
-				  int migratetype)
+bool move_freepages_block_isolate(struct zone *zone, struct page *page)
 {
 	unsigned long start_pfn, pfn;
+	bool is_block_isolated = get_pageblock_isolate(page);
+	int from_mt;
+	int to_mt;
 
 	if (!prep_move_freepages_block(zone, page, &start_pfn, NULL, NULL))
 		return false;
@@ -1784,7 +1786,10 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
-		set_pageblock_migratetype(page, migratetype);
+		if (is_block_isolated)
+			clear_pageblock_isolate(page);
+		else
+			set_pageblock_isolate(page);
 		split_large_buddy(zone, buddy, pfn, order, FPI_NONE);
 		return true;
 	}
@@ -1795,14 +1800,24 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
-		set_pageblock_migratetype(page, migratetype);
+		if (is_block_isolated)
+			clear_pageblock_isolate(page);
+		else
+			set_pageblock_isolate(page);
 		split_large_buddy(zone, page, pfn, order, FPI_NONE);
 		return true;
 	}
 move:
+	if (is_block_isolated)
+		clear_pageblock_isolate(page);
+
+	from_mt = is_block_isolated ? MIGRATE_ISOLATE : get_pageblock_migratetype(page);
+	to_mt = is_block_isolated ? get_pageblock_migratetype(page) : MIGRATE_ISOLATE;
+
+	if (!is_block_isolated)
+		set_pageblock_isolate(page);
 	__move_freepages_block(zone, start_pfn,
-			       get_pfnblock_migratetype(page, start_pfn),
-			       migratetype);
+			       from_mt, to_mt);
 	return true;
 }
 #endif /* CONFIG_MEMORY_ISOLATION */
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 7e04047977cf..3ffdfddbdd50 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -181,7 +181,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	unmovable = has_unmovable_pages(check_unmovable_start, check_unmovable_end,
 			migratetype, isol_flags);
 	if (!unmovable) {
-		if (!move_freepages_block_isolate(zone, page, MIGRATE_ISOLATE)) {
+		if (!move_freepages_block_isolate(zone, page)) {
 			spin_unlock_irqrestore(&zone->lock, flags);
 			return -EBUSY;
 		}
@@ -202,7 +202,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	return -EBUSY;
 }
 
-static void unset_migratetype_isolate(struct page *page, int migratetype)
+static void unset_migratetype_isolate(struct page *page)
 {
 	struct zone *zone;
 	unsigned long flags;
@@ -255,10 +255,10 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 		 * Isolating this block already succeeded, so this
 		 * should not fail on zone boundaries.
 		 */
-		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
+		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page));
 	} else {
-		set_pageblock_migratetype(page, migratetype);
-		__putback_isolated_page(page, order, migratetype);
+		clear_pageblock_isolate(page);
+		__putback_isolated_page(page, order, get_pageblock_migratetype(page));
 	}
 	zone->nr_isolate_pageblock--;
 out:
@@ -428,7 +428,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 failed:
 	/* restore the original migratetype */
 	if (!skip_isolation)
-		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), migratetype);
+		unset_migratetype_isolate(pfn_to_page(isolate_pageblock));
 	return -EBUSY;
 }
 
@@ -501,7 +501,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true,
 			skip_isolation, migratetype);
 	if (ret) {
-		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
+		unset_migratetype_isolate(pfn_to_page(isolate_start));
 		return ret;
 	}
 
@@ -514,8 +514,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 					start_pfn, end_pfn)) {
 			undo_isolate_page_range(isolate_start, pfn, migratetype);
 			unset_migratetype_isolate(
-				pfn_to_page(isolate_end - pageblock_nr_pages),
-				migratetype);
+				pfn_to_page(isolate_end - pageblock_nr_pages));
 			return -EBUSY;
 		}
 	}
@@ -545,7 +544,7 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		page = __first_valid_page(pfn, pageblock_nr_pages);
 		if (!page || !is_migrate_isolate_page(page))
 			continue;
-		unset_migratetype_isolate(page, migratetype);
+		unset_migratetype_isolate(page);
 	}
 }
 /*
-- 
2.45.2


