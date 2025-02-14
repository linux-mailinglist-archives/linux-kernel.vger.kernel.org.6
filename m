Return-Path: <linux-kernel+bounces-515460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDC9A3651E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD96172353
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBF7269AE0;
	Fri, 14 Feb 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JS055DuB"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151F2690DF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555930; cv=fail; b=YO8JiyMxX8zYm/xoo/FAqB0txqUui7RB9d+pG/Md0BztQoT3yMjLm85kLg6HLeIW6NL2BntFgcIHKe0yfMsvaDYYWyr9hMG4tnMlrTJUW93I3il28KEtLuJBWydnw6RW79D65Lex/VSLt4dADg/KIZVoxxyYjFj9zMQcLCWmPoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555930; c=relaxed/simple;
	bh=V65lCqwe0kHeK3CrMbTjSbrUZ3VoQ9Q0vRMmMA7prDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PyXbxzBSOvebsNCJDPSCVU/ejkhoLUy6CRlsQzIaRJDSSnzgc1CDtrO+y7WLYEEFLPz+pZDVaFVyRhzS96Oz2WJszamSbq26tg0Wz8TAgs29GXMhcVXJ01ypTs4n9P3pJSW0ahezTO0CP+D59c+wlR1DV/mwOKiLbx16wOv8Skg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JS055DuB; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vdy5pzZDEiWPhL3BcwZh6G0P1QRbs5M3f7dwcDbecqjBACeZHBhLAbEvEkgWIlSpfndy9c9zYqrnJBWEBa00UZQvqQ4bBbV/oCUt1Ir2Pm0GvbJM0KWpFIWfWWxriaBqIwvGmPwRZtG3xo/ojLASZ77IgD28XwEn7EsfjJZqt4IvOcgQeXNuIa8Sl/2Bv+vjoDbusaIYxAhh1K4wkY6F93GQbAel69+2bwsnsiDsDpifXsFoCuKeuknOU4hdTB++Iox9WlQ9AB8J5U/BdJ34oDsF1RpBiM6Em9A+h1GGfakSHJAJ53+xwMu1NlNB165ZqSYUT/cPjWRrzofb/u1Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh4fK6MvOEJzGRVFM9xO68BnwtpVCxxWfD5SYB2AlS4=;
 b=JBHQtiCGQ2WN8cyHtjNJvQZjY8iOqI0GkLcrlSop8rgGzTHgPblAWdOn2VaV8pI15zyRneFiMQ8MlSdUUsaw04XX8wB2cUxZd0GBFUDE8n6cNp5xnIMI168lfC89uW7hjUmJRFMh17WRylzGD3EijQbfncB8ll0bWSGKdZAqCjZ00ApwAOkykki1g7qjJAmAN0wBPeTfI4d6npoEW2x1kFg5WMCpZRXo+xcZld9Ez+gDFrL1EBABUg6TVkO6P/6/ZT1KYFjzd9YwsyOKpJ/GoVMj4os51pjJW8wo7yAzknEbR7JIQpV6FHb5HhtZixhd88FjztwedGNeLhhfjl1nqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh4fK6MvOEJzGRVFM9xO68BnwtpVCxxWfD5SYB2AlS4=;
 b=JS055DuBEKsrj7d6hRtyci4Eoi8V0nPZ1G7Lyga6FGLZDcDfQg5Og8Xt16fKiAj/MaQWlsTFcqhuhJmzi3J2bc+g2p4qPkQBQQlwIOb8pg5w7fal2Ueka7bJ8gnuuLIVTUmhOjj+1TlOyTLJxd5pExXTjagkuZ5QveUflBtUV6XL+2CiGXjTNpmvpJz98jFy19jdFoiMU8IwcYNkyWNYIFlKdDF1As9mEdYUpptRxy6MIeV2uDv8yrPZkr7RXT3Znjq3RCXU+Oj53X6cHUrCPCjqsPXyDIYftwlrta0GHD5npNDXcApWxQoJal133uu+F6QP2gU35W0KYWJyY1H5cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 17:58:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 17:58:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm/page_isolation: make page isolation a
 standalone bit.
Date: Fri, 14 Feb 2025 12:58:38 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <88EFE47D-17FB-4C11-8C5C-F04845819EF6@nvidia.com>
In-Reply-To: <20250214164541.GA233399@cmpxchg.org>
References: <20250214154215.717537-1-ziy@nvidia.com>
 <20250214154215.717537-2-ziy@nvidia.com>
 <20250214164541.GA233399@cmpxchg.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 75faf91e-62e4-42fc-68b0-08dd4d2138d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rFF7TppwZYvv0yJ+XF+Vze2xRONlkmcXHSFChPUK5Xiw3vtJ0LnFD7vN4HJS?=
 =?us-ascii?Q?ThKeLlKgDQKq2q8QfsNmC4xBGPgwZAkq/O1COuJEvtjShJ3WvOYZFjoJYhaP?=
 =?us-ascii?Q?wPW+3OVpaJJiicYLEfz+QxBflcJQtnBFL7RODNrHXBUmOoYooVjsU/r6YSNC?=
 =?us-ascii?Q?2zSWGJMB+eV3Ly0oAESnWbS7gfHDy+6qE69qkHxLtqZmGXL/M50X75zGGKtg?=
 =?us-ascii?Q?dGlsrIV9VP1OLq/DDOA/bsZrjfSuvpPcBeP78dmQl+cfT+yHuFaxI2RIQ+KB?=
 =?us-ascii?Q?hV/vtUYJf5Li+fYcdnIZ/Yv/PpPYslLaGYoVWyuJjEZ81/0V4KZGjtyUtFek?=
 =?us-ascii?Q?gmPgSMFcYkbHzu2doO/O6odD9StDeYDH0GRiim5jmFlBGytRsb0UfnXoiuxV?=
 =?us-ascii?Q?8bwDBwINz2cKGP+hbpxwFeXEHPOb9d0ziFy9/B9Vi9qABC5xftvYv6HHToJN?=
 =?us-ascii?Q?C3oK8OQNPCJNePoawOBFjYWutbglI7+HmbMYaGkwcrfBVpiPGIbblS2bilPq?=
 =?us-ascii?Q?Pz5cyUtqzGL65lkGfXQAflTJsvjwXtbX/nhvXATI7CTWdtMOhEZju5qV7Ie6?=
 =?us-ascii?Q?1qOpj/GSiYeUWlJ8VBM15lBEbfnFr4xtUsXjNm1L0/rs9fJIJhdreQkGXTXs?=
 =?us-ascii?Q?57Px8B9gEzBF1tWp4yw4Pg2sziUbsP9rw1Bg5WU8QXBA6w0zjkKfZmzf0drQ?=
 =?us-ascii?Q?M6ro64tB7czAKELJCdiA20HfEb4YS1p4xjOWH2Eo8fiBVn7FVsL4K/QgM68+?=
 =?us-ascii?Q?GJimNyARzcAty0tx863H1BxAEocq45z5VdErQPBwLJmJRak0NetsjwBFNdCx?=
 =?us-ascii?Q?O39LjrHec96octjelpcc1FsGvazbKmssnojfEJH9Eh8X+czzCh+oV+VO34tg?=
 =?us-ascii?Q?3dXLqhweKapx4u9A4ri8LjSXZo0OsjCtr0cWntdstoj9Ni4jLJNRNsZqpD05?=
 =?us-ascii?Q?bGTGfPnV42Q5iqt/ZrvMHz7aMGGRUl3DQs+XQ5mSo+vkhGR2BWoZI5NmG+f1?=
 =?us-ascii?Q?GRgXLwzULOvLkBy0PXK90TRGnYSDW2Bjg+O3fMGJY+J2eZdgvEtW1l2rQ6od?=
 =?us-ascii?Q?EV7BGXcR/kV9fldpWQMt/YIIxrAWC0YJLoABxc4WuKOB47+4j6hyK80S0JAc?=
 =?us-ascii?Q?xwhG8FrxlXQkzED1hDcgBe7qHGaFE/FIn+FGl5AHCrlyGH6+9oy1YBMfnMfg?=
 =?us-ascii?Q?UIRNnL6+63V9aom76qISzl7eTZQwhuVMOHVwKXdesR5n+iwq5Bda+KbBq6RZ?=
 =?us-ascii?Q?lXGMS1SM9Pn6OpL2TbMxAJ7umbT4X/XwvhxWwmnUaVhrRKdGpD91cj+iG6js?=
 =?us-ascii?Q?m2oY/tmJUvAPhfKn69xpxlE8j6m4Aw8NVF/25/mnSVweapZtaEFIw8lUoUkj?=
 =?us-ascii?Q?vq5LiMLPIY2TPiT6J6q83BhA+Rr0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?knhiesYKo3rLIETRKzkjShrjrTlZjeDeBcym+MfQTCbSB9nbPItu65cH/HBn?=
 =?us-ascii?Q?7FqiIhO0YiDJzNtAkN3nBILYOUZsTkflnjLgSMYYZxBaPcXrXZpPp1Y3PEMc?=
 =?us-ascii?Q?mw8VQ/4mCpCInOYEai1YVp2GtbHIlcTsZyfrLe7KfoMQk/cxntHvFg2VGQ4F?=
 =?us-ascii?Q?53Z1oGYP6ausFCySJZ4HfbUQlT5QKUrGcAvvxUJaDqnPaR4DxorKD136zZSH?=
 =?us-ascii?Q?Vkbe7lFiByupz+LjUFDmOoSxqNW0SzRQNhldAAflKKpyPhR7BEXNgC6jd6vQ?=
 =?us-ascii?Q?7FQ9E26RcAet73KyHL2nRU23nkARzueUHAzkb/7JrFLhRZB9qXB+m3kniuFA?=
 =?us-ascii?Q?8PJLyFzSgSLDheQXywEu62WOyNYnsUBoH8ncXotssnNa2Q5yweegSkHqLRzS?=
 =?us-ascii?Q?B2Cs0fxzC/7+24gzCFO8KP/REiL1H6Td8WBSVauJNkvEjd3M5UFYZnAvqMhr?=
 =?us-ascii?Q?IUehIuLUt4NnpGcyoi9P1eSzBMsANxbqxa2GZ/cx6R3A2Gjad15/0277NGFm?=
 =?us-ascii?Q?biID82zHz8UMCuco6blWd5UjXMA5hC9LhYmRVyn+wS+xnqqogOjYlAI+JnBB?=
 =?us-ascii?Q?iWmEgMQYfMy3GCtSmp+jdNO4fiHb3PuH2VBA/e1bYnxHqBOob3GPdhFGOecD?=
 =?us-ascii?Q?o478ZaLRTSfegyw5f44l/z20jG3s7RzkizGMnKBDIu3H1bnROhK9neU9E1Iy?=
 =?us-ascii?Q?5DclqdLKGBqSGKdVNGTvIFMIwVOthWTjpRYyNGZlAGVU+oFBwEqUcGW18ypG?=
 =?us-ascii?Q?u92urBsyvmecjvJg1uI9IMSrOBIsndn7zUxzJ4VLaDqGdrdEVJSTEMK2shrR?=
 =?us-ascii?Q?24QQoJnT1dpnQlF9unPfww2/qTxDjTYil/qAPcf/4vJLfwP1J8K2yhbn7VO7?=
 =?us-ascii?Q?29SpFlA1lACLLUEXY7BIC+ykx/jvJ+CbKKdqtmtsFjamguzzFj2FfHNgrXLm?=
 =?us-ascii?Q?im9KmKc2DnU+WDsM2maHRuKa3/juknaR1022cXs6B+RIyqzBo1cdaU2gqufF?=
 =?us-ascii?Q?vqgZSC9hH5oj8pMEG8mctHk09yWHnqU3PZkAXWdOBk0oqNLg/S4hSBmvy6hW?=
 =?us-ascii?Q?lmZsPDVS12MLNiDC3Lr4d5xf3yXeWyeOqRE23toljybywFcOaDOgdQEFWHCD?=
 =?us-ascii?Q?BernrZfpw2bP1+TW3AKw4CgLB3iRGcpBR7mlXeFzro8bYoFfgxSJzxbX9AXh?=
 =?us-ascii?Q?p7kvhA+D317zKssGDds2KrZvUI7cMuhgiflvxM33rmV4/Rp1A5gJl1O/Rfxj?=
 =?us-ascii?Q?mnLmZjej3kN7M2goAckdWolG//d2AkONEO+f5Ch41HcLQSsCk1BrvQaVDT50?=
 =?us-ascii?Q?SnNf1lwjLaTId3YEx+qOmqVwoHB48MytlH3SqCF1VsbX8mHD/fPssq9ZQ4Ln?=
 =?us-ascii?Q?2977JslHB03X8q8UdCNJWzj72hrr1KWEC/2mP+cJ8FMFfOdXQ8xJ0k2JhVOP?=
 =?us-ascii?Q?Z3k50TW/x7McG/KTyQJe0AQH4jI/TKf5+38Slz3gY71asxRza/KfwiARsEeo?=
 =?us-ascii?Q?b7JA+eOLvH7u7CyMuiQG9z6dxUeGrOpFAO3nM4y+vwAcaruEHM8FjPg3XGE4?=
 =?us-ascii?Q?9zZ3RoVPqky3MNxDsSflTu7nz8re2WyfZnGaw/XO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75faf91e-62e4-42fc-68b0-08dd4d2138d4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 17:58:44.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhPXecgm7tjEE4rstPKUy4Bz5GjskKpe7vMizFRK6riBhnTrfwQcQfOsh0d9sXxA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111

On 14 Feb 2025, at 11:45, Johannes Weiner wrote:

> On Fri, Feb 14, 2025 at 10:42:12AM -0500, Zi Yan wrote:
>> During page isolation, the original migratetype is overwritten, since
>> MIGRATE_* are enums. Change MIGRATE_ISOLATE to be a standalone bit lik=
e
>> PB_migrate_skip. pageblock bits needs to be word aligned, so expand
>> the number of pageblock bits from 4 to 8 and make migrate isolate bit =
7.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  include/linux/mmzone.h          | 18 +++++++++++++-----
>>  include/linux/page-isolation.h  |  2 +-
>>  include/linux/pageblock-flags.h | 33 ++++++++++++++++++++++++++++++++=
-
>>  mm/page_alloc.c                 | 21 +++++++++++++++++++--
>>  4 files changed, 65 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 8aecbbb0b685..3c7d3f22ccb2 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -106,14 +106,22 @@ static inline bool migratetype_is_mergeable(int =
mt)
>>
>>  extern int page_group_by_mobility_disabled;
>>
>> -#define MIGRATETYPE_MASK ((1UL << PB_migratetype_bits) - 1)
>> +#ifdef CONFIG_MEMORY_ISOLATION
>> +#define MIGRATETYPE_NO_ISO_MASK (BIT(PB_migratetype_bits) - 1)
>> +#define MIGRATETYPE_MASK (MIGRATETYPE_NO_ISO_MASK | PB_migrate_isolat=
e_bit)
>> +#else
>> +#define MIGRATETYPE_NO_ISO_MASK (BIT(PB_migratetype_bits) - 1)
>> +#define MIGRATETYPE_MASK (BIT(PB_migratetype_bits) - 1)
>> +#endif
>
> There is no user of the NO_ISO_MASK until the last patch. Can you
> please defer introduction until then?

Sure.

>
>> -#define get_pageblock_migratetype(page)					\
>> -	get_pfnblock_flags_mask(page, page_to_pfn(page), MIGRATETYPE_MASK)
>> +#define get_pageblock_migratetype(page) \
>> +		get_pfnblock_flags_mask(page, page_to_pfn(page), \
>> +			MIGRATETYPE_MASK)
>>
>> -#define folio_migratetype(folio)				\
>> -	get_pfnblock_flags_mask(&folio->page, folio_pfn(folio),		\
>> +#define folio_migratetype(folio) \
>> +		get_pfnblock_flags_mask(&folio->page, folio_pfn(folio), \
>>  			MIGRATETYPE_MASK)
>
> That's a spurious change currently. I assume you tweaked the
> MIGRATETYPE_MASK parameter during development, but I can't see a
> functional difference now.

Right, will remove it.
>
>> @@ -373,7 +374,13 @@ unsigned long get_pfnblock_flags_mask(const struc=
t page *page,
>>  	 * racy, are not corrupted.
>>  	 */
>>  	word =3D READ_ONCE(bitmap[word_bitidx]);
>> -	return (word >> bitidx) & mask;
>> +	flags =3D (word >> bitidx) & mask;
>> +
>> +#ifdef CONFIG_MEMORY_ISOLATION
>> +	if (flags & PB_migrate_isolate_bit)
>> +		return MIGRATE_ISOLATE;
>> +#endif
>> +	return flags;
>>  }
>>
>>  static __always_inline int get_pfnblock_migratetype(const struct page=
 *page,
>> @@ -397,8 +404,18 @@ void set_pfnblock_flags_mask(struct page *page, u=
nsigned long flags,
>>  	unsigned long bitidx, word_bitidx;
>>  	unsigned long word;
>>
>> +#ifdef CONFIG_MEMORY_ISOLATION
>> +	BUILD_BUG_ON(NR_PAGEBLOCK_BITS !=3D 8);
>> +	/* keep other migratetype bits if MIGRATE_ISOLATE is set */
>> +	if (flags =3D=3D MIGRATE_ISOLATE) {
>> +		mask &=3D ~((1UL << PB_migratetype_bits) - 1);
>> +		flags =3D PB_migrate_isolate_bit;
>> +	}
>
> Please change the callers in both cases to pass the appropriate masks
> of interest instead.
>
> That's likely a bit of churn in the allocator code, but adding caller
> specifics to this function violates abstraction layering rules.

Basically, expose this to the caller. Namely, if it is setting
MIGRATE_ISOLATE, it should use the MIGRATETYPE_ISO_ONLY_MASK. Otherwise,
use MIGRATETYPE_MASK. Maybe adds two helper functions for
setting pageblock isolation and clearing pageblock isolation, like
{set,clear}_pageblock_skip()? I thought about it and did not do that
due to code churn, but now you ask for it explicitly, I am going to
do that.

Thank you for the review.

Best Regards,
Yan, Zi

