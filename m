Return-Path: <linux-kernel+bounces-305649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9283C9631B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90C22844F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30461AC895;
	Wed, 28 Aug 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i+V/tbRL"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD11ABED1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876603; cv=fail; b=GoCLNspJlcJv3rY2M+6u9jObSJmjIjfEb1j0WLMrmKC3FyJQM11cDNTgmPp+ZRzMsrpmCP1MIQzG0Co9FOMFHBtMn1QWxVf1ubH9fGPeeXuvvRcpgD2wa1kqt012rL+eh/zBHyc1sw9Ef9yDwHV130yjOLuw6cseCIveILVqvec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876603; c=relaxed/simple;
	bh=KzKFLjjKUIXYLV7Nw6KROTG0jZldXo7uF7lSk7ja2Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KtQ/5MQthXuoqq04BHlwiBrVsJbUkpGsk4cSWQ2uWI6y2hTAKO2fRbOLRkCXfKe+Jy+B0HgE4eZTkN9Ac1LadQ3ExwH4U91JibjAKvYLKl8YDVA5EIs4gcTuWSZjZYzf+a3x2i6qAtUq8POXVd0PcFjZhQwHfN8FeMwgdeH2m48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i+V/tbRL; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMZcoTgFOM25p+pb/l6g+O4KzdIRq1CEcWpOeQR+4G/NgzsgoqDKvZFkaogyvJM+z2yHO6qNRBJvbgoEXdlCyDh6TKpfuUiIAyxDUxaAPohqf+9yfQ4kTBJ7/4lYe+M04KSoBeZp8E+RfsiclUs2YkOEhRtYLoYn9/Mx4iRcn90rjIOfGjr5JQP5QJXV0Dm8HhWKxEWwDtAzXezPzMjp8PsdhSP8aaaF/9MSYdFhHM9/+vgLebFkKWj5enJBm4L9IvmrRuin7xc3/Yj8DEBKwiF3bYeHYdoJXoXaG0v5LqocGi6NSBu4fcxilOmKqscLWo63jtBklMi/0EnaaUjDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvlvOKiL1uDrY0SOAsMeAPqpU7SQeBVYP8MOTmwgRbQ=;
 b=oI781mdNe6mfbpDrqlZAQ3Cic3a6xISaADwq6n0fFMiV8+LUIwpQT1ghMWJ2u1SE0narmeGsYCNyAydqsmcxbdcIut4lKJiiQXAJqrJHoq2kTMKtRwW6Hok7Y/NniCBhia1jAlNa552Y/46QAie/WEgsgXMuIIxctxa19X/sN4cc8aA9pfiljBoSe/2byXK0+twytci5wo1460HNo4FAR/jpDamfzO8Kz71KCG7xiboHF/RGuF+StBEvtDtMYb9wcJjkJpuZTjbtgrEbd7CV/rrOIq1fgaMpiGaCfMrX1tNRzTAuuYjUezhkIRcgIFy3TerCiOpMEMrAXeDdpzE8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvlvOKiL1uDrY0SOAsMeAPqpU7SQeBVYP8MOTmwgRbQ=;
 b=i+V/tbRL4+mb8d+yVe2p231T0pYFdYGxTN5sJ0DZflCR4UGKcjzswzc7ktp+D0/Y/2awh3ScdgpLMO9VFDjvWAxHnJcGjXu08LOOlRnCrzP9K4iTLy5c8TOjzCvgpxNFNfFMUJGOjgU4f70lSbq24RrJ1R7NJ602bsYxvNBISOE/kVQTvCFsjPoO8WJRNqZnkF2b0HPLrDIcQP2IDfxqThskE2fgj56j3nlYjf7Z8Cp9LWBnKQlqa8c9O5gb5BoRAeuj3GesNqgKSp+3jT1ETiHK0xzhocM1zHSYonJFimJcmdjGmn8oxk5UdxHLIFv/72nAqktkh/VHOcDru/rxCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 20:23:18 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 20:23:18 +0000
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
Subject: [RFC PATCH 1/4] mm/page_isolation: make page isolation a standalone bit.
Date: Wed, 28 Aug 2024 16:22:37 -0400
Message-ID: <20240828202240.2809740-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828202240.2809740-1-ziy@nvidia.com>
References: <20240828202240.2809740-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0978.namprd03.prod.outlook.com
 (2603:10b6:408:109::23) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8db155-2a3e-498e-fb1e-08dcc79f40e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?clqcE2F/YBs8zz5EqWsUzj4SFZeoe2ipdycRcgWakJE3ez1w/rPWugw2FZis?=
 =?us-ascii?Q?hDFdz7YoZfe/pIF3M6weiW5T7wKArGs+kXetHZsGt84RtVEdcDBqomk/eb9I?=
 =?us-ascii?Q?DoIVrAHuj103mhc+fJlSYf1DreCYiuQ5U6yH9NetFfG8AkyOWmZiZ97BvxPX?=
 =?us-ascii?Q?ZvGCIf7/FOmJv93FhU1smSi1XdZ5JBOMUO47btxKUZaRGve8T6d1NnlL8hG2?=
 =?us-ascii?Q?m+NAjq0XZ8z2qMaUL4w8nf/JR85G6c+tF1agqsB0IXTqf6QcDqUApBjmgnzQ?=
 =?us-ascii?Q?DqpuVgN364IIfjPlxFce+pP3Qrp8jcYMpYu5990RE7Dw4WFYAefeGpw4GYdN?=
 =?us-ascii?Q?ufAX6jvbk3hgYFofLE1uLbRSRbWlC5zHphFdw2jM67KHlhDJ/r6CoRvjLGyp?=
 =?us-ascii?Q?PD+9eJD6y2NBwkj/ChYmM2UPA+HiomgtOIbYxMwEUOTCp4V6pZDc5+YQKZM5?=
 =?us-ascii?Q?dCINEFgKwohOzaSfB6ktdkPO4FnH72MRGIenJoXAx12ro5T8J/ET3Lx50ZST?=
 =?us-ascii?Q?rzrG9tdXTpS+29ymLoC4c1otym3wB5kpp0VtJdBPBNku1g+PR3EGF/E6ok81?=
 =?us-ascii?Q?r6CYwa06s3wnbekb6sbbU215cBwdcBuebsJxMFpEtwhV90HWNRosaK5yCcwZ?=
 =?us-ascii?Q?X80aRm8Hz473aYTYBW4qE218FrohanD2j+nLMKk5SSsYPsHa14KVb2FCYQmB?=
 =?us-ascii?Q?9Lp5md7Xb8UkPUhHePUVSE1vUTKU4DeWNoYjOc1nKrxMB0uHLEi20v9QwHO5?=
 =?us-ascii?Q?PVXbDVGtxptA4vuHfQYHIuUqENC9S/4nqnb0hZuG4gFYbItAFEoI0H2AnJ2g?=
 =?us-ascii?Q?GxeCevbKomP0tEDq6n7zEP39PRejKR7Izz2bXVzTtTHP0Xjq/WmKu6ZfJaWr?=
 =?us-ascii?Q?yfciHcBvMCvTNpNJ2da1myr7Af8YeGOe4y1h86YcH3w+AImtl0qh1m2sf7DH?=
 =?us-ascii?Q?KjWxC4kRsNwV6QmpdByIrgkOIHVO+wlrjT00/RO3vrbOzozhf8abLb8GTXHk?=
 =?us-ascii?Q?vvZdB02RMLEMJnkojxuywNSzwDGiL1lI2+eh8mkkDifUS884UMcVeyq7jlDH?=
 =?us-ascii?Q?/cXlSWlMJbIWronh91i9npqSFTqwWAm6uEfR4YoXzn2b1cbC5FCePnDMblrw?=
 =?us-ascii?Q?rJqqQEVg4/8HDyT2gsFwuKmakZeY8R88Rm8PDsa6So7IKODAqQd1qRdMhsoK?=
 =?us-ascii?Q?e8MCB3HxQac7tIqjDW/e5xvnlUqVAu0Ohekikwefvnpa6M8d4cPqrwFqv841?=
 =?us-ascii?Q?mxhIupN2+lxj9GclblEk0U9NZM0lxUbt8jX7pAfn/U2zABg6xGiTz1cMHzYl?=
 =?us-ascii?Q?9+P3qgnPq3X5an3PVtOo6Ly/05One4vkdy2G07//4pjoZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6SIQ1oHiNuUr+5BTfbx6SXY/XXp60TUPtf59z/FeBQt6DkpcWOfUVJBX8b7s?=
 =?us-ascii?Q?HegxCw3+dnUe8PbUWGrDuUz8hTCSMiv0Qlrvi6okENpusnC+GcyAVN1mman+?=
 =?us-ascii?Q?BYS3zJ0s8ktw48eYCzyCfNaE8A16N+zgFf9jUubsXuqnTPOT2Q7Ot+4Xv28R?=
 =?us-ascii?Q?RiFcKsQaSwDQExN+2ZMTbRkZpsqooMjBnRKbE05br2nkVKc3UayZiT4TX7lz?=
 =?us-ascii?Q?K2/pPSPA6ayzGpeRiopJRMM9//6nnC4jC+06LhQ2NsysAziQgU3T/B0MDRz8?=
 =?us-ascii?Q?/5Kcm/nIpihK8Rcny2t+GeaIx4xrXy0FOzaSXBH7dHTf4ED5prp+Ew3n8Qve?=
 =?us-ascii?Q?Od2Luu5fIqNxh/sUSzfeGv3oiVFJA3oc0BQ9dfpb6F4HHRG3WkPPRlHNrUWH?=
 =?us-ascii?Q?fG63FZXnrRGwIeEqtD17Wp/4MSnk15fNSFxEwB5QnTO0Qr1vf5XVgkPQ5CYC?=
 =?us-ascii?Q?z/EFraYpS0wI7OduScYge+hc5PiufOry7QUOCFgEalColDickF1W9sXxSUAZ?=
 =?us-ascii?Q?h8WjrGe4MGSZy+/N1dKqSe3NPLyeKmlrXax3H0fOXl82tIY7BJYeVxATet4W?=
 =?us-ascii?Q?rZn3Nbcp5zlXileYMYcbhyW1RucXffi+JLVyIilXfim9gEkcOC4W5FXf/ChY?=
 =?us-ascii?Q?1yhxHlwzmn9GtmL5V3IS/E0x4oEztI6e224yYCN5iazkH80L8BEcyZzqWLeZ?=
 =?us-ascii?Q?2bYDqGTkuPSev0+k/ZUIfc38m5sygceO1y882wwkXV1+sJ03KPx86oVtwfdW?=
 =?us-ascii?Q?tr2oyIMI7jjDaPxRcXp+KqVP2/cIQF36J3LThKgkJ4k5c9xFBxXCgYeNBiqM?=
 =?us-ascii?Q?J+j/VzNUCXBi02oaLdKJBToPwmyHhIAncEsYjaqmFDk/Rf0P71A3a3GRB8zX?=
 =?us-ascii?Q?IdDt4QmVEoHppe8Ej/aXDB4vSUs2hUNBLPavY2CfNo0PlmD6pAqcbVWn0k4I?=
 =?us-ascii?Q?BTQ+H/CaBnNLdEbOYO8bdO3yuzH+yUK5wbVwNRJQ1Dqx5Oasxepy+0Elm5IO?=
 =?us-ascii?Q?oab1OBu5tYYvIu8FZUjH6bHb9Ak6llO70W6UJEe/FKyTqV1gN2Q7Pl/hN9Tn?=
 =?us-ascii?Q?E0ZcnT1D6ZJJ9d1Wyvrh17QiMejco+UJEbkSjM1eSx4tayUPbnXZBoJto8QI?=
 =?us-ascii?Q?bZRWp+C52swHHh4Uq2b8cTADQf+Asu4BN0IuTbNQ4QoFIaLHqtBZ+zERweb0?=
 =?us-ascii?Q?Gkob/IgyGEKoL1BMIa8c4lJYOOaalxd/2ciNF4yJsx94H82KNEeKlQKjEbim?=
 =?us-ascii?Q?IN3o3UHfQBBGzzt26lX/n7rWWA7OFY7uAdMqlS26hKYd8lXMdd3i03StbZbJ?=
 =?us-ascii?Q?Rc8HPJm+1JZSoDuo0gpz3oTKTmmVAVTtR+F5bxi3gurFIqtr7rzI3dOo+ChU?=
 =?us-ascii?Q?OlopuNuoJb68Mzw8wGs2Ai4emyJpIOk8neH0m0qc204fCogbs6Nv5MhZ0snl?=
 =?us-ascii?Q?OZ4Ntl08RkGqpCrfJYuIVd1Z3m6VIozyZkpyBSgkx4LijyrjawoMn2JFNc6k?=
 =?us-ascii?Q?ihSk9Lwc8yiLOn1MDz0BINMeMd/P6yFF1DnPKZ9zmFcG0rcXbfWhA2/yLdWM?=
 =?us-ascii?Q?FsP4FgzJYeJlgZwcSB80PLdg9BMbP51vOH3atHyD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8db155-2a3e-498e-fb1e-08dcc79f40e7
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:23:18.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhepnQBCMwD1259WBO95DCSZv6Lk3iS0CkMxy9+7K0UKdPp79dCydTysERZbyW7B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134

During page isolation, the original migratetype is overwritten, since
MIGRATE_* are enums. Change MIGRATE_ISOLATE to be a standalone bit like
PB_migrate_skip. pageblock bits needs to be word aligned, so expand
the number of pageblock bits from 4 to 8 and make migrate isolate bit 7.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mmzone.h          | 24 ++++++++++++++++++++----
 include/linux/page-isolation.h  |  2 +-
 include/linux/pageblock-flags.h | 29 ++++++++++++++++++++++++++++-
 mm/page_alloc.c                 | 22 ++++++++++++++++++++--
 4 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4a2835..5191a90b94f9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -108,12 +108,28 @@ extern int page_group_by_mobility_disabled;
 
 #define MIGRATETYPE_MASK ((1UL << PB_migratetype_bits) - 1)
 
-#define get_pageblock_migratetype(page)					\
-	get_pfnblock_flags_mask(page, page_to_pfn(page), MIGRATETYPE_MASK)
+#ifdef CONFIG_MEMORY_ISOLATION
+#define get_pageblock_migratetype(page) \
+		(get_pageblock_isolate(page) ? \
+			MIGRATE_ISOLATE : \
+			get_pfnblock_flags_mask(page, page_to_pfn(page), \
+				MIGRATETYPE_MASK))
+
+#define folio_migratetype(folio) \
+		(get_pageblock_isolate(&folio->page) ? \
+			MIGRATE_ISOLATE : \
+			get_pfnblock_flags_mask(&folio->page, folio_pfn(folio), \
+				MIGRATETYPE_MASK))
+#else
+#define get_pageblock_migratetype(page) \
+		get_pfnblock_flags_mask(page, page_to_pfn(page), \
+			MIGRATETYPE_MASK)
 
-#define folio_migratetype(folio)				\
-	get_pfnblock_flags_mask(&folio->page, folio_pfn(folio),		\
+#define folio_migratetype(folio) \
+		get_pfnblock_flags_mask(&folio->page, folio_pfn(folio), \
 			MIGRATETYPE_MASK)
+#endif
+
 struct free_area {
 	struct list_head	free_list[MIGRATE_TYPES];
 	unsigned long		nr_free;
diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index c16db0067090..11b8695115ea 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -9,7 +9,7 @@ static inline bool has_isolate_pageblock(struct zone *zone)
 }
 static inline bool is_migrate_isolate_page(struct page *page)
 {
-	return get_pageblock_migratetype(page) == MIGRATE_ISOLATE;
+	return get_pageblock_isolate(page);
 }
 static inline bool is_migrate_isolate(int migratetype)
 {
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index fc6b9c87cb0a..a8121cab4b4f 100644
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
@@ -99,4 +102,28 @@ static inline void set_pageblock_skip(struct page *page)
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
index c2ffccf9d213..4ea5cd1a07e2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -380,7 +380,12 @@ unsigned long get_pfnblock_flags_mask(const struct page *page,
 static __always_inline int get_pfnblock_migratetype(const struct page *page,
 					unsigned long pfn)
 {
-	return get_pfnblock_flags_mask(page, pfn, MIGRATETYPE_MASK);
+	return
+#ifdef CONFIG_MEMORY_ISOLATION
+		get_pageblock_isolate(page) ?
+		MIGRATE_ISOLATE :
+#endif
+		get_pfnblock_flags_mask(page, pfn, MIGRATETYPE_MASK);
 }
 
 /**
@@ -398,7 +403,11 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	unsigned long bitidx, word_bitidx;
 	unsigned long word;
 
+#ifdef CONFIG_MEMORY_ISOLATION
+	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 8);
+#else
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
+#endif
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
 
 	bitmap = get_pageblock_bitmap(page, pfn);
@@ -422,8 +431,17 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
 		     migratetype < MIGRATE_PCPTYPES))
 		migratetype = MIGRATE_UNMOVABLE;
 
-	set_pfnblock_flags_mask(page, (unsigned long)migratetype,
+#ifdef CONFIG_MEMORY_ISOLATION
+	if (migratetype == MIGRATE_ISOLATE)
+		set_pageblock_isolate(page);
+	else
+#endif
+	{
+		if (get_pageblock_isolate(page))
+			clear_pageblock_isolate(page);
+		set_pfnblock_flags_mask(page, (unsigned long)migratetype,
 				page_to_pfn(page), MIGRATETYPE_MASK);
+	}
 }
 
 #ifdef CONFIG_DEBUG_VM
-- 
2.45.2


