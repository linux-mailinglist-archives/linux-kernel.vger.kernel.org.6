Return-Path: <linux-kernel+bounces-435363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F8D9E7691
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7451886EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9E1F4E20;
	Fri,  6 Dec 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oOzmxiVw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358A620626A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504398; cv=fail; b=IuLvlA4qi4eAnoFNFYduac0z8mSQvD+NLWI5r+WVRDAUS7IBZfhOYhCe3ODJn6jrYkfna1xA9sWdo2GxXNRiEuUVBiIFpP7HsCYyMB2jnmVoziK17nbgfL7TCSacBVG3Q4eZ035QjP9aB4clgnxawB5d2X1od/NNH25W0rBx5j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504398; c=relaxed/simple;
	bh=R2s2nKcl1IdSyEJUcGYu3lv9ZPUni5HHAVTi5OhGvRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=koBn/nmzMgj4LoYC39Ad0IhuqijQ36w9sEesOScZ5WEXzXqwF3Zq73CAbC6TJ58n8QxCONDtW2ttu3JZZXS0wkuXbZVKKnUuNVALJKyK5whoZiBxhgpZFaVYOfEAFa5psJKefbs3pO2RYWqkdm/eN6aGgKU9wHi1nL2pNqflekA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oOzmxiVw; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VS28ovyWpWUncVMdb/gXeKFdU2V5n5Pp7XBJBpvfRBQOc5NOCjZ+GBzCswavFzomM7QWf8YLjwyF/XrNyH6Cxo2Pwa0fg3py0f+DBmNPuLhnIDk6V//aIV2uu3jbQnh0nDy4wGOi77P9pjGCJZLTesjZ+SHZL2n7gK7N77MXuXPmsiplpkblPJL5WVJp+8Cy1IS82Ls8+9UjWZyjqrzzBDa66UlNTyQOl/qqew3JerV1yM2kFY4DATnaeucDOJDuyliNGCPowHbAZ8Q3Shxb9yPBQCnlixxL1pk4soxs3M5xOHoHKkPiwrta7O10IfNB4ywZGDaJmBVsiYSK1vEmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6lYUjw5WWCoG/lyUUrElMaXpH8+IrECnw4zyxLVfjg=;
 b=QKrfWTZxRPjA3s5FcIdx6Ncc37s0WAIa3f9HyRlDqCiL1sggpFE4aMJFLC+26C+uTKgaWsuK/W4Qe0ybqnNg1TaDxmfaneNqahoQvHvixLYJZUebSw7aC52yRziHW8uv5h42gXpu2KPe8C6+FeCOvzIiRMkhHWPtGURfiG4RkJMxhchjb8Pwxcl+pj60jQf2GFAXHLDlhXZzFlb5IO+qWnuoEwNL3TD8QG5ZXzVgh4f5Z1PsT5VYQZDU1tZgOghhVTS4fXqc55exT8lWremdK9jqdfzeeue7cJlKe8juk67HtPdGciZwe1mmBcMSTcU6nPBX26H6q2S6QX4TZ4D3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6lYUjw5WWCoG/lyUUrElMaXpH8+IrECnw4zyxLVfjg=;
 b=oOzmxiVwolbM5r/bDJ7a7yN8p+QKzXYfsRc1UFVBEJAWvyKVzdn6nkE812osAzX62NUIgzVM9EOk9rC6Giw+KufSbqRSbSU2Ir7JqTZB6xCPw6VQ1xiSNKKj/SJHFUg+XZHgGRZ2qp0tuIP+Ga4w/NL+Kj6SMwegNSJ0f03/KmknfNc94kQEShrW2crRlDqVnLQHvtm2/sY929JL43RxGDDw1yiQb6HLAbX63iFCuhwGXhMDJdqVke9ue3+4Hiyq+rVLoePeHW5TDw3575ecY0NN6LxaCMoRpB/CqWR9XPC0zDxWnQkY/0f/rwbXDEL7azmT39GdX/JV8/AxvI0gyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Fri, 6 Dec 2024 16:59:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 16:59:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v1 2/2] mm/page_isolation: fixup
 isolate_single_pageblock() comment regarding splitting free pages
Date: Fri, 06 Dec 2024 11:59:51 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <987BDF68-11E7-4CE3-B5C1-9F18B8E569C7@nvidia.com>
In-Reply-To: <20241206095951.98007-3-david@redhat.com>
References: <20241206095951.98007-1-david@redhat.com>
 <20241206095951.98007-3-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0601.namprd03.prod.outlook.com
 (2603:10b6:408:106::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a947ee6-6abb-4012-7d84-08dd161767d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M++2HnkQDKm6nM0X5jao2Km7KdqqO2kPXLmFDdnjL4d+yLdOqMQ0G+oTXMcH?=
 =?us-ascii?Q?5BA5UNNnYgQskorwNBrqTL094jCN0KxVLq9WU8FUg0SBc8MpS96zlAGr9w6f?=
 =?us-ascii?Q?3eaSzVVqB9CrgoxvuNhrPnnpCMHOKqGNvC2lAWE693nJjZyYg+BOTDd6KD5A?=
 =?us-ascii?Q?gmA9z7Kgvs8nUh3H4E6RzpAGkTLvcQq0MwRH+Wu/GcGpik6QPq7BUQc+3EIK?=
 =?us-ascii?Q?FgaGpV3zwhRVdGb+7b3jDaPVpzQcywJxBgdk+ckbHhVHAQTnHrMlBgEK9sC7?=
 =?us-ascii?Q?R5MJ0r5Zuf4IUY9Ll/rHrQzERBz+Vo30WRzohjmXR8Yaiyx/GVEZ1oTj0UDv?=
 =?us-ascii?Q?dXKkjsQ4I+p8vBKSC0JES4uXFXcDyPb04SjIwE7zatfOIxHQAjJHMzBUt0kQ?=
 =?us-ascii?Q?e90WGKXU7U3ePz4wcov/0wP3Iv7BYgytHNMgLeIG0r0WRFDheqbs7JQaFJnz?=
 =?us-ascii?Q?PEvGAUM4c/5rYeYs6oTEiiu3KZ3toOW+/gWk1Y3S5seYc1bwJZESJMbBgwFf?=
 =?us-ascii?Q?Q88UCt1TKZJGQEqp//c2C/F4/FXiCwcIi1pA6/LyQtueo1KaxDTMaE20FEJW?=
 =?us-ascii?Q?+c491XtZDsBVOUkdTC/3gfgDXxcm9jfA7jd4PS01knFTKrWBTLrHgtBXq99e?=
 =?us-ascii?Q?1M+16N2/WW7bpe27cXl+jqHaWr9djq2ClktrkLvyQnY4lECWMDFay4nCp9+e?=
 =?us-ascii?Q?1MXzWAdpVvyMrctlEUYtQsMAUkPgGQKjJvbG0htQhfgXRluo8B57EemvHSiJ?=
 =?us-ascii?Q?kUIwH/TwRJAgh8C5wxZdmXiEbORLWTQdQBZu+qDaiOQDu3fMZK8v4gztGmGm?=
 =?us-ascii?Q?PHrhpR8hQcMRkYxd+upW7v44nhwqE+d5mioHrIOUtsGyczLi4RzA1WdqrkeG?=
 =?us-ascii?Q?ZlZyXgrot5T2l4LsWl1Dh6cQnoXY5fZIV5HlncnY70adUeoOQ/vkfvDpd5Td?=
 =?us-ascii?Q?+QQkTCWlcC+s//MBxxUjIT6kRpKxPPm+EG7dM3T9EdnrGuhmTv1MKp2Se9+k?=
 =?us-ascii?Q?SoJmabdujVEpq8MI+TO1kG+mtxixKNy2yD0iYlXQJ6TMcs+6eRrPB53hcCzM?=
 =?us-ascii?Q?HbgrF+n75oDhm1YkjFLlxI3KK93ZTDFg961FDeWLNd2X6JbcfHPFqtfaYWEr?=
 =?us-ascii?Q?JyQib9hxfLaXKA0Y23Igqlrb8P/sK2uRGJfQzATj7YuWLmCijE2+GC+y8sLV?=
 =?us-ascii?Q?iHV81HIWIhtkYSWFkEm6BqmzCIKYA5UR/03vEmqWDyxMqfj2yGoAHouLEX9o?=
 =?us-ascii?Q?KHPf8X0tc2iMCmxUaf6FMrEz07EReTXWSCaLAhTgIXQKg4H2RUDgbXLNVaXV?=
 =?us-ascii?Q?qfP35DpoUYu59IL0dP2J6fMGTgGEDfrHwE46kBk0sGGMxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zlgDs77lBZ0Ux9Sxv/cBzLR08B8V5tPuf4KlMpCtaPIHzGlOip9pQIeLKq+z?=
 =?us-ascii?Q?rQZ08/QylJv0CwSdlb9t5b8pFuzBSjqUusiwPnywS2fxfplDBrEeFM0uoZ44?=
 =?us-ascii?Q?dIKlSnklhjRDpaxT52v4hMRyP/yt2g3g0XPsm8JRcK+Z6LCRUADDaKEq9Z7V?=
 =?us-ascii?Q?enEjP51sUsFegIIMRSLo07tie/joOErqTbaAHeuipHniYZbQZb+Rvxxv0XZg?=
 =?us-ascii?Q?L1J9pw1kbMNLniK5w8ZLw4rS9fvykws+XA4hPrd7t2PZ96VBlgKQ02UJrPao?=
 =?us-ascii?Q?FhSSjty6AAIg4HkNC5sHs821H9tdOAdQDeakVb87yVfQ2122XUURbgiDhD8J?=
 =?us-ascii?Q?Edzo1cWN4uSe2ASuyRVN1dXD33JnxUidmREHvh34gjIhoDMiSXLRIjfIuaWs?=
 =?us-ascii?Q?OvVdqmXz/X+tJGPGiNPaUPGmJB0gnhTI7nTKHpgE/Qp3bMb1vFyt7mnHKvhx?=
 =?us-ascii?Q?xyIdkAvFp8Kax16YKc1h9jL2eH8NedjWxuLlX5RTQG4aSnV+hYNXnWY2OiAU?=
 =?us-ascii?Q?YCV7X2ANIAyTeyVEEJre2ozct6LmGN+uqgJ8zVBVHBl6mo4vcWsOw4BDj2kt?=
 =?us-ascii?Q?Ig1/O1gO9rUjnCkCxhH43fORZHwKcO+bdZw9fU6hpGlAhMYLPxFiiQhyTkbG?=
 =?us-ascii?Q?mH2ABHAE61l49HT87BTM/mWHtuHyZ+X7ASGMDQY+cmWfNXJu/Pb2wkkKz2r3?=
 =?us-ascii?Q?IodVtbKGymwk0PWyLN9n85JvbxyqjAgOtwvvKBWRdCKAAyrXGuTS466HdABf?=
 =?us-ascii?Q?bLrEPvrzTuWVRPdDgzM4xRggv5e87XNHmTCvHGXF39DV8tEpROEh8fl88x3L?=
 =?us-ascii?Q?9QARJlaSzJBmQUdPjruJFmjpR3+gnXZ+L2RLqtm8+bCDeXuqkyjr9DqDwJ7W?=
 =?us-ascii?Q?sIscFUuznhchYfgqAi+LGXvkH87EV4Kw2rVjW0wf3BgKwkrA4PwptQZBFtFD?=
 =?us-ascii?Q?w7zegOn0Wjv9yA/HtD71lERHtJ0c9GIUX1jSWyg6FhYdjIh2VAAhjXZ5hEjr?=
 =?us-ascii?Q?JmTndX5dtIr5JmBQ2LID6C54/YZhJRlbZVfyKkoth3DvcpfLvpy4PPoy3yJP?=
 =?us-ascii?Q?lDXGU9r9ausm+cGnsFy6uE71OfOD74KYSw83j8J9j6hYxKJpxsHOdDKDXMxg?=
 =?us-ascii?Q?cVTIVMNIrQpTJfQ63z8b3u4KCTdvSQHGKjLwvBQClz3epH6W67gvL46y+zyx?=
 =?us-ascii?Q?UskkGF3J5EIlacQlAU4Jub4M61UvUCdN8MgFLqr6nhN4Kzvmvdvudi05UPMD?=
 =?us-ascii?Q?zVkpsqdndtm+UZIjz3va9HXFFyDBuJvOVl2keofQQKUzSkxQEvsnOVxsbuGd?=
 =?us-ascii?Q?dY4rsJGPKQHNmNM92MfBJm4RnvwZ+UWM39W4GMM5bUcQ9nTeZwGvq3UX52Ih?=
 =?us-ascii?Q?8FX/Uf1Q43s6XBynocviW5SgUQ+d0XLQG8RgAls+QlkEzV9blJP2LHd+byQi?=
 =?us-ascii?Q?84w5xOOsVOCDd+jYP7bSb8S0n45sA3xWFGoW/eeMRymvvdvfTpMZ2NwTIiVP?=
 =?us-ascii?Q?BDJ+VfPhehrzSMm63jZsY32OI0hM6WNeU54wdWawncWkwFqQlYO5F2R+Yu5z?=
 =?us-ascii?Q?UGPXt1W1tBM/OkmH06sdUnmzHnRSg+7aLLQM5uc0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a947ee6-6abb-4012-7d84-08dd161767d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:59:53.9655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpnFdHD09DNdKvbICmMkK+SGXWz7eKSGB+LaZtA5EDsjvXxRwYoCuIzwnsIy5LRY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

On 6 Dec 2024, at 4:59, David Hildenbrand wrote:

> Let's fixup the comment, documenting how free_one_page_maybe_split()
> comes into play.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_isolation.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index c608e9d728655..63fddf283e681 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -298,11 +298,10 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * pagelbocks.
>   * [      MAX_PAGE_ORDER         ]
>   * [  pageblock0  |  pageblock1  ]
> - * When either pageblock is isolated, if it is a free page, the page is not
> - * split into separate migratetype lists, which is supposed to; if it is an
> - * in-use page and freed later, __free_one_page() does not split the free page
> - * either. The function handles this by splitting the free page or migrating
> - * the in-use page then splitting the free page.
> + * When either pageblock is isolated, if it is an in-use page and freed later,
> + * __free_one_page_maybe_split() will split the free page if required. If the
> + * page is already free, this function handles this by splitting the free page
> + * through move_freepages_block_isolate()->__free_one_page_maybe_split().
>   */
>  static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>  		bool isolate_before, bool skip_isolation, int migratetype)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

