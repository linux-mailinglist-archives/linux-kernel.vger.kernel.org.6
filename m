Return-Path: <linux-kernel+bounces-378438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7E59AD02D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37B31F22B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA081CFEB8;
	Wed, 23 Oct 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uElm/43r"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DDE1CF5DF;
	Wed, 23 Oct 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700533; cv=fail; b=srNyFe8fKu8YL6S42zHD78fR5UxrQRsonKzC33SFFSs6ZgSjsMsw3ffB5H/X+Oi+9oi4aXRp+pnJUDMjR37/WNiCiTO0xwsC9/V66m0gM5eZaDqCWaQ9YE2OfH1jlVpOAb+z5hnkVPUIh6l7WJIAzYYiPXkC028wpSrIS9FQY7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700533; c=relaxed/simple;
	bh=TJwdEE4HIlMn6Pg+0QOOHyvjt3rMVGdyJXMXXdWs4JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8O15YIaoDadC1Qi/dxswey16l6DAaZkb1bQXBPeXxAYOXstoSYZe+H0sVNwLmXEr5KC+iz8+HtOXXq6XeHVizks1aAaURAhmjVnfaBHiATXxl5dxOrEE+66hxIjZDjHIlvnNQDeZzkhvgTJ7NTV88d8V7RV4Y+D2khrazXpQlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uElm/43r; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P26qulQQJsD29+OptC55NmNMLrW0pclOWKp6+TtbtPVz2NFlB1kAnpA7EgdluQvRJccocV+MYDnKryHoln7vcDAXH/4DtMky43vnkXDGBYBeARdAQwue9F4xQi35JkRM3lufKdIsARB9G9doHymdN16RL7ihBBM0sW2NkhPJjDr31vNgUmGeFkLam+8R/qnqAp1tCCjyCRzW5Si2iC5K+qBdT5JAA1h0d4QS+QlWGoOAOO194BfF2QBJ4XGbjucSHaVbpTupsg1HPAlV5svghypOKDLBuKAIs+HflXUKmfm3Tk+JWMQyH2dTBkTcV3m6QkN8yPg2oIU+gVUBC9ZxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIrJy3QSg1/3v97/H+6Im0MTit75W0XgVuVvs3Z9u4w=;
 b=PQFvOMGkB6K/izKIUDLwXJNBxRp/GlErwUpOsFENVVSxcDBJPPT9Vbok/TUBhCC4oyC18ttOpRzGg81iSY4K6q1Vico16SMVJHpf4laA3oD1C6OSwai2F4B5HVKFG1eWjd8JL/9PZww4fEeX5P6Z9ea5nOIb8gCp2LcVkgD9cvXK3liIc8mkSrq+J/07o08uOj8v7gwV/HKmk86Cc312xKkbqNiqO6Ekii2if4PtdH3vtoH3DSm34CcjoieuAjbpmqLJsRhKjK+GsUcJVQkbjRjrqAtvn3huumkQa+zhfDjdeNp5L2RQwEVp5L57y5+N6kZmO6E5ehXpH1OKWs4V/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIrJy3QSg1/3v97/H+6Im0MTit75W0XgVuVvs3Z9u4w=;
 b=uElm/43ruFQhZksmSQg+DGf3DPJJIUKeIzmhcqTStonRq4/hm/4SvpcYVowPJXyNE3lvSs87nShlDaxFWGRZFilIklFwzkwvRCm+zbWSb97nFCKakJwapu2AP+EFJJ+eu+OUy8T3MizZC63XPFjJf8zSLUJsPhGfywivUPFKf9fDnXuy/GOPzEg218ytsrdMhwyTZn6jStYYTH19EBjhP6V1lO9PMhpRW38hfxmuxTQbjzfNgeJsDD6IKdyIYNOkn249rp9YJBjHQwCpJBXiuWv/43Fe08beV7xCqAk7qRdr07MZuJHsay0OUPKKVQaNob2uU/KRo3/Fl12rZ48/3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 16:22:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 16:22:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, david@redhat.com, npache@redhat.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, ryncsn@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Shuang Zhai <zhais@google.com>
Subject: Re: [PATCH v5 2/6] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
Date: Wed, 23 Oct 2024 12:21:57 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <4B7449C4-D2B8-4285-973C-97178C09CE7E@nvidia.com>
In-Reply-To: <20240830100438.3623486-3-usamaarif642@gmail.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
 <20240830100438.3623486-3-usamaarif642@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_720C5D8A-8AE9-4AF0-AFD0-ABF2C61ED944_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: IA1P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::16) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: c39c5f68-5b90-4622-2d15-08dcf37ed5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DPYsiUK2si0rbxXrpJldZckIcbLoeYnLRxDHPyO+0L+UqPnjHkuN514uC9PI?=
 =?us-ascii?Q?xneLWbin6g6GMm485Em/JwBbb+XWg5WqxhhthSmT/jmZU6WCUWI6sRmTOwWf?=
 =?us-ascii?Q?YxJB2xUIgG2e1GHMuU0D9X2E9CtdKHuN68mvjv6zUIa/hxzgHTN2GE46jmY2?=
 =?us-ascii?Q?grqT7bltrYnoUB/DWnW80iDP1mSA1B0gswCV8eTKm7fTEE75Bx9fVFgd71tx?=
 =?us-ascii?Q?WyNMv9FdeNZ+8XiFqktv+F+L035zxjVQFzgac3Xx/rC11yr69ZUm9dV9/sQz?=
 =?us-ascii?Q?7BU/NK4kz9fphL651pwPJUI0PAijfAQNq+n47GKjp2ZtOP1jOSPb3obfgtFo?=
 =?us-ascii?Q?CeYOcZGWUReCIP89YgOwWxIOdoBdKBellmB9qW3pXk41IjMhqlIXRQ7Itbv4?=
 =?us-ascii?Q?Emp2i1sw63srSjUG2S/Ri4fFIu/QDp93SytCgnWK0J57SSK3CcaiRTOupat5?=
 =?us-ascii?Q?zf7HRNo015/Iz2ZulLnyx7zmKCAVO95AYjy6elADEgvuN2x/s0rTSV/1f4ko?=
 =?us-ascii?Q?qpMJoG3uLg5G9KJD+IoC8AAnya0DmAhHDAiGxCewTWVwl2LT26KO9S8WMGmU?=
 =?us-ascii?Q?TpuB9kpCUQ545AXH/jqwmWBwaX6mKJfGir3lMOrUzC92SkaXR6XQGy6DqD+m?=
 =?us-ascii?Q?ix+uv5UnUwisUBKcO1773d3+3zmWaiednzGPFU7Mau/tYPapxT6VDLxBTgsC?=
 =?us-ascii?Q?nOL8XammZ0LWpdzF3DbB0rsyx0ofqgTb6/BVn8jDERM5jpCiBvEO7jqZzvTE?=
 =?us-ascii?Q?SRpz9bC9Ch3/WciYMHs8VYdlUbHeCkfm3WUQZvqD+r/VKbCV4q8oJNeqhW9c?=
 =?us-ascii?Q?CcBxjsj5vJEW5IdX2pq/3Scthb4mdgq2lEhrW/78TmJO8UpFsrdYy1CH6AkA?=
 =?us-ascii?Q?zXcuVLnAq7wF+pd0M0HPVueHIQQLKRsbfrBRrLiY3iLCzj8QS1EUyQlxb60Z?=
 =?us-ascii?Q?vYKUCppLsxiS1GJrtUJij5kCRxbuoS5EA9EjxuX0+a/QM/k5xnVuqGFx8xsG?=
 =?us-ascii?Q?JYQv7RkKL7wtHp73x59+/zxQ11btJpm0BRnFJwG8twbMobbvjSewvEID5lLN?=
 =?us-ascii?Q?3wP8Syqdg3EYxcVrbCUDuuia1C2Aq3/4Iv2Hn5J7VJGi5g3ge/M7Df4eS4fp?=
 =?us-ascii?Q?qoMT8TzLP0QN1VqA1u/LLN1/hUN4R+iCpMeFToYyu0d155al459DQx/Ig8p1?=
 =?us-ascii?Q?AJ2wLiBS/mlOQRX9GmwE8Py2elPefW8vXTE1L0JAS4ewpHwf9TrAnlXYUQqt?=
 =?us-ascii?Q?QvUXwDFF0UsHSsu2brvcwt3tOTil6np1fnU94o5UY2vE6+fqCan9TQDRCR7y?=
 =?us-ascii?Q?7BeGb5009iSO4A4OnTvW/5WN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?odGoRq6MzQ+aVmdHdC+9ls0azkq5a4AEwXyiA/eRdkQyOIRTPXdViiqC5zOa?=
 =?us-ascii?Q?ZgXvn+8DLh1o8KkWqwa1bjG2ZPDV9M3/dOeNAr40qm3gVXegi1AJbQvOGscx?=
 =?us-ascii?Q?er4UwWMDDQSOXXdyYknykn882AssKNcY1RRL4R8FkAYSvB87xC9urPU121wS?=
 =?us-ascii?Q?fikXc2VToCDfY/hkazjPTlo2b+W5Ebuw826y9iT1845IpLVoUtLn4wrlz0a7?=
 =?us-ascii?Q?mm3nxBWkrA1WZUxpYmvBp8/2lhNUPbzDnAO2SZpQEAOlD+Uh332CdAyOsjwx?=
 =?us-ascii?Q?zpwiMxTX98rNwHdaziRaxk9cQygL0tHxpgj5Hfe5BDDpH8VovxHkGe/2g3L1?=
 =?us-ascii?Q?w+N5tQl5Z+VUFMZv43kqtcdb4ObpJbJJagrCZQ6KLGPo+Y7F4uB8VlXMaUoC?=
 =?us-ascii?Q?Oo/sFfPhXw4322OUZ5o7qrWAtv0MEt2inFm6DyCqOBh6zzrawVj5BBJrdNa/?=
 =?us-ascii?Q?kMRRVdPtCVRLuaHUdxTM5sQbsKhBBEslUV6BuRFDdhWRnJB6LYvnv7SRfIqh?=
 =?us-ascii?Q?79Tc6BEyAbye81kttjzi2DW9cbbSe/jOkXlOfRQybCoXAFozNkEBLTn+U/hD?=
 =?us-ascii?Q?4Fl4hO+o0RVCfIkCdMiaAUlWjmz4yhYlSZxTMCRiAWsS+R21GiXspGoT707Q?=
 =?us-ascii?Q?ZkDeVp7JLdD3Am7dWp/CrCieAAoSxJ2+HzzIiMOKCPsnS86AIUJooIMJxR3a?=
 =?us-ascii?Q?+2/rxBLoByQqsC09h0NFceRPC8sIePaJD0xSLpS9iv4rjIm+4l30alGw7WaD?=
 =?us-ascii?Q?Ih+hJvPHXvUTaYpCge5IqqrTJX8UxiJ8R9xOhe0jeViXGlQ1fqBafBn8VMoO?=
 =?us-ascii?Q?9GvKei6QqZjLUxLTbuN60jAgKCLDhj+lp1yDQDRJPcpVk+hYlkaWNVXLHIQt?=
 =?us-ascii?Q?I8+7dFGshiMHv5ttQe5S0X8MlofFFSoVvzF02STbbZT4u697VfP2uQ4IN2na?=
 =?us-ascii?Q?CtpIPqKO/CXHc6JQN4BqfDiuw0LORlFgw8blJePDkkACv24GGIcgW1oPYQ/8?=
 =?us-ascii?Q?kLo/VhgqBIqkrQCi4dQ4MNoCcORzslxbUWamQDjxF5Rpz1xBbwEFTpYmxjS2?=
 =?us-ascii?Q?UtxQpx/S5Puxe8ZKWjLEq9GZc7xYPddYZBnsDDo2xKY7YNZB30CjKQaTUxHr?=
 =?us-ascii?Q?QZb7j8yuCYrF8nnOnzw/aayNxUSIuMF4nzl+BJkYiqGHW5uc1XqeE8CdYkx8?=
 =?us-ascii?Q?ulssTkv7FcRfAzwyWRCoT3bwWeafLx2wRsWY25oVRZtvA5qw80eNnKh6sFCO?=
 =?us-ascii?Q?jqHBDDZSRKi8Idl443JrpcUEW/Lg+uqb7udYhXz1NGByFL2JgqUSttnT/Ggo?=
 =?us-ascii?Q?YRyYVzLOEcX7/5Rv3Zn8yL+jDjxtsgtdyuq/+R90MPChBypGQdTk2smLUZzG?=
 =?us-ascii?Q?hlfYzVk+OfFJ/h4KGHngGzMyS0Shz+yf3MPqJ+NOLIWavcM/0whKnSJ4HXiA?=
 =?us-ascii?Q?KghOn0dzZMJo1PTqpg+zriOp7pR6wmTR3k318HQLr1qEdECT08+tjbey95ki?=
 =?us-ascii?Q?BPpLOIX+yF8sgPKnfdtluKtkthNWQRAxDz7TKbz9td1DRNVSEDKHUTkyPITX?=
 =?us-ascii?Q?v8fB8iEmgtONLk613y6Vs0fcyzxWsR88R3mdrrJB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39c5f68-5b90-4622-2d15-08dcf37ed5ee
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:22:07.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHWvC2PFr6LmfRA5fFCW5c8UtG1lhcRYGccQsT68M0YMeMt2esXOx5/YzQV8sb5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591

--=_MailMate_720C5D8A-8AE9-4AF0-AFD0-ABF2C61ED944_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 30 Aug 2024, at 6:03, Usama Arif wrote:

> From: Yu Zhao <yuzhao@google.com>
>
> Here being unused means containing only zeros and inaccessible to
> userspace. When splitting an isolated thp under reclaim or migration,
> the unused subpages can be mapped to the shared zeropage, hence saving
> memory. This is particularly helpful when the internal
> fragmentation of a thp is high, i.e. it has many untouched subpages.
>
> This is also a prerequisite for THP low utilization shrinker which will=

> be introduced in later patches, where underutilized THPs are split, and=

> the zero-filled pages are freed saving memory.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Shuang Zhai <zhais@google.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/rmap.h |  7 ++++-
>  mm/huge_memory.c     |  8 ++---
>  mm/migrate.c         | 72 ++++++++++++++++++++++++++++++++++++++------=

>  mm/migrate_device.c  |  4 +--
>  4 files changed, 75 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 91b5935e8485..d5e93e44322e 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -745,7 +745,12 @@ int folio_mkclean(struct folio *);
>  int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff=
_t pgoff,
>  		      struct vm_area_struct *vma);
>
> -void remove_migration_ptes(struct folio *src, struct folio *dst, bool =
locked);
> +enum rmp_flags {
> +	RMP_LOCKED		=3D 1 << 0,
> +	RMP_USE_SHARED_ZEROPAGE	=3D 1 << 1,
> +};
> +
> +void remove_migration_ptes(struct folio *src, struct folio *dst, int f=
lags);
>
>  /*
>   * rmap_walk_control: To control rmap traversing for specific needs
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0c48806ccb9a..af60684e7c70 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3020,7 +3020,7 @@ bool unmap_huge_pmd_locked(struct vm_area_struct =
*vma, unsigned long addr,
>  	return false;
>  }
>
> -static void remap_page(struct folio *folio, unsigned long nr)
> +static void remap_page(struct folio *folio, unsigned long nr, int flag=
s)
>  {
>  	int i =3D 0;
>
> @@ -3028,7 +3028,7 @@ static void remap_page(struct folio *folio, unsig=
ned long nr)
>  	if (!folio_test_anon(folio))
>  		return;
>  	for (;;) {
> -		remove_migration_ptes(folio, folio, true);
> +		remove_migration_ptes(folio, folio, RMP_LOCKED | flags);
>  		i +=3D folio_nr_pages(folio);
>  		if (i >=3D nr)
>  			break;
> @@ -3240,7 +3240,7 @@ static void __split_huge_page(struct page *page, =
struct list_head *list,
>
>  	if (nr_dropped)
>  		shmem_uncharge(folio->mapping->host, nr_dropped);
> -	remap_page(folio, nr);
> +	remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : 0);
>
>  	/*
>  	 * set page to its compound_head when split to non order-0 pages, so
> @@ -3542,7 +3542,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
>  		if (mapping)
>  			xas_unlock(&xas);
>  		local_irq_enable();
> -		remap_page(folio, folio_nr_pages(folio));
> +		remap_page(folio, folio_nr_pages(folio), 0);
>  		ret =3D -EAGAIN;
>  	}
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6f9c62c746be..d039863e014b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -204,13 +204,57 @@ bool isolate_folio_to_list(struct folio *folio, s=
truct list_head *list)
>  	return true;
>  }
>
> +static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk =
*pvmw,
> +					  struct folio *folio,
> +					  unsigned long idx)
> +{
> +	struct page *page =3D folio_page(folio, idx);
> +	bool contains_data;
> +	pte_t newpte;
> +	void *addr;
> +
> +	VM_BUG_ON_PAGE(PageCompound(page), page);

This should be:

diff --git a/mm/migrate.c b/mm/migrate.c
index e950fd62607f..7ffdbe078aa7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -206,7 +206,8 @@ static bool try_to_map_unused_to_zeropage(struct page=
_vma_mapped_walk *pvmw,
        pte_t newpte;
        void *addr;

-       VM_BUG_ON_PAGE(PageCompound(page), page);
+       if (PageCompound(page))
+               return false;
        VM_BUG_ON_PAGE(!PageAnon(page), page);
        VM_BUG_ON_PAGE(!PageLocked(page), page);
        VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);

Otherwise, splitting anonymous large folios to non order-0 ones just
triggers this BUG_ON.

> +	VM_BUG_ON_PAGE(!PageAnon(page), page);
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
> +
> +	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||=

> +	    mm_forbids_zeropage(pvmw->vma->vm_mm))
> +		return false;
> +
> +	/*
> +	 * The pmd entry mapping the old thp was flushed and the pte mapping
> +	 * this subpage has been non present. If the subpage is only zero-fil=
led
> +	 * then map it to the shared zeropage.
> +	 */
> +	addr =3D kmap_local_page(page);
> +	contains_data =3D memchr_inv(addr, 0, PAGE_SIZE);
> +	kunmap_local(addr);
> +
> +	if (contains_data)
> +		return false;
> +
> +	newpte =3D pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
> +					pvmw->vma->vm_page_prot));
> +	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
> +
> +	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
> +	return true;
> +}
> +
> +struct rmap_walk_arg {
> +	struct folio *folio;
> +	bool map_unused_to_zeropage;
> +};
> +
>  /*
>   * Restore a potential migration pte to a working pte entry
>   */
>  static bool remove_migration_pte(struct folio *folio,
> -		struct vm_area_struct *vma, unsigned long addr, void *old)
> +		struct vm_area_struct *vma, unsigned long addr, void *arg)
>  {
> -	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATIO=
N);
> +	struct rmap_walk_arg *rmap_walk_arg =3D arg;
> +	DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->folio, vma, addr, PVMW_SYN=
C | PVMW_MIGRATION);
>
>  	while (page_vma_mapped_walk(&pvmw)) {
>  		rmap_t rmap_flags =3D RMAP_NONE;
> @@ -234,6 +278,9 @@ static bool remove_migration_pte(struct folio *foli=
o,
>  			continue;
>  		}
>  #endif
> +		if (rmap_walk_arg->map_unused_to_zeropage &&
> +		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
> +			continue;
>
>  		folio_get(folio);
>  		pte =3D mk_pte(new, READ_ONCE(vma->vm_page_prot));
> @@ -312,14 +359,21 @@ static bool remove_migration_pte(struct folio *fo=
lio,
>   * Get rid of all migration entries and replace them by
>   * references to the indicated page.
>   */
> -void remove_migration_ptes(struct folio *src, struct folio *dst, bool =
locked)
> +void remove_migration_ptes(struct folio *src, struct folio *dst, int f=
lags)
>  {
> +	struct rmap_walk_arg rmap_walk_arg =3D {
> +		.folio =3D src,
> +		.map_unused_to_zeropage =3D flags & RMP_USE_SHARED_ZEROPAGE,
> +	};
> +
>  	struct rmap_walk_control rwc =3D {
>  		.rmap_one =3D remove_migration_pte,
> -		.arg =3D src,
> +		.arg =3D &rmap_walk_arg,
>  	};
>
> -	if (locked)
> +	VM_BUG_ON_FOLIO((flags & RMP_USE_SHARED_ZEROPAGE) && (src !=3D dst), =
src);
> +
> +	if (flags & RMP_LOCKED)
>  		rmap_walk_locked(dst, &rwc);
>  	else
>  		rmap_walk(dst, &rwc);
> @@ -934,7 +988,7 @@ static int writeout(struct address_space *mapping, =
struct folio *folio)
>  	 * At this point we know that the migration attempt cannot
>  	 * be successful.
>  	 */
> -	remove_migration_ptes(folio, folio, false);
> +	remove_migration_ptes(folio, folio, 0);
>
>  	rc =3D mapping->a_ops->writepage(&folio->page, &wbc);
>
> @@ -1098,7 +1152,7 @@ static void migrate_folio_undo_src(struct folio *=
src,
>  				   struct list_head *ret)
>  {
>  	if (page_was_mapped)
> -		remove_migration_ptes(src, src, false);
> +		remove_migration_ptes(src, src, 0);
>  	/* Drop an anon_vma reference if we took one */
>  	if (anon_vma)
>  		put_anon_vma(anon_vma);
> @@ -1336,7 +1390,7 @@ static int migrate_folio_move(free_folio_t put_ne=
w_folio, unsigned long private,
>  		lru_add_drain();
>
>  	if (old_page_state & PAGE_WAS_MAPPED)
> -		remove_migration_ptes(src, dst, false);
> +		remove_migration_ptes(src, dst, 0);
>
>  out_unlock_both:
>  	folio_unlock(dst);
> @@ -1474,7 +1528,7 @@ static int unmap_and_move_huge_page(new_folio_t g=
et_new_folio,
>
>  	if (page_was_mapped)
>  		remove_migration_ptes(src,
> -			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : src, false);
> +			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : src, 0);
>
>  unlock_put_anon:
>  	folio_unlock(dst);
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 8d687de88a03..9cf26592ac93 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -424,7 +424,7 @@ static unsigned long migrate_device_unmap(unsigned =
long *src_pfns,
>  			continue;
>
>  		folio =3D page_folio(page);
> -		remove_migration_ptes(folio, folio, false);
> +		remove_migration_ptes(folio, folio, 0);
>
>  		src_pfns[i] =3D 0;
>  		folio_unlock(folio);
> @@ -840,7 +840,7 @@ void migrate_device_finalize(unsigned long *src_pfn=
s,
>  			dst =3D src;
>  		}
>
> -		remove_migration_ptes(src, dst, false);
> +		remove_migration_ptes(src, dst, 0);
>  		folio_unlock(src);
>
>  		if (folio_is_zone_device(src))
> -- =

> 2.43.5

Best Regards,
Yan, Zi

--=_MailMate_720C5D8A-8AE9-4AF0-AFD0-ABF2C61ED944_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcZIqYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKY1AP/A9PBq6LncqBAoaQtFtfCdyRVty1wT24BDrj
2U+9Uuza2izeVULj5OSAEoou6+R3S6Rgcc65pXj4hdUV2VTGJc0FPPWrqlyo75zp
6yhbYVFZmr0s0Fgs7/+4VqZTpVR8i9TSKWDbLAkJYshlukk6VTBNisjj4jA1wjMh
vVjEUy4IW668/fMxH9lz9QQfN9wRFm8PQk/iscQyI2Zn7i2xkYFhbEeyLZVnnbBr
9HcrZbWkhO5knH8pCqItmYWLEBpvnXxvHa5VbTRcVegF3F2b3rrAhS+7PR1QqKEy
4l9d0qTby76mTTGtnie+nLdWgVYNXLOQxdWhNVZfbQbwTd7BUvCYAbZuwlzio1qw
ACJ/kFKmcoQoP9Q+GBA6/rNtNYQ+VP5P/kxZ57a3MG9CTjDN6Vp+xUcnwk0BNPcv
33tbc6DYBGSXEf/eYEHmQXvdtxwXT4a/TpAYXt7XWTNsTtLSBnxIXPoaewVpvBQU
rmcH2myww9VTO7HCtZsLV24kg6QjfRcnI/FuYuWjaOc/o+5DGy6xb1WSaHbgDFLE
KFan6xTJmGEGDcL5zweiSnXtNSAbdgzhA3Ctujzbu4fDs3hAA4IYMwpWlzzu85Pp
dAZgFnt06sSOZ6RNyU9Dd/R598gLa/P4jrHbmGMnaGLAkBk4st79aEk7S9jaJFrU
hYG7O+LB
=WKL5
-----END PGP SIGNATURE-----

--=_MailMate_720C5D8A-8AE9-4AF0-AFD0-ABF2C61ED944_=--

