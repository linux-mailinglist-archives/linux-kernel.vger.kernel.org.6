Return-Path: <linux-kernel+bounces-289947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F8954D98
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F11BB22992
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2241BD039;
	Fri, 16 Aug 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GrQyP081"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BD13CF86
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821835; cv=fail; b=sAIqU7HhUmMzpKOjC+SMxt0xu5n8vGWRjEYzvyDnAXOjlfvZwHpRmYP+u6pfTnSrQhJtchhFevmPPtuigR98i3vQbqjWFQ+0dwiqCHE0/whK+5eAmMk+gLJqQpv3r7PcNvCh4mgmqHLHeuxx+N3cV2sdeylvYQwzXDnJjLRsyqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821835; c=relaxed/simple;
	bh=xu2RUoXEfvodAtiv0Voq552j2N888bKGY6HCxTEeyLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agcuEHncYz6ARKhGsYqAzCJvXL5GZvlCZ+NewaEBQ6o38Yk74fqnjenGEj9eCAz8hjEvnZlQCHdwbDkuw752Z9VNZtDqGU6ivPqPwXzsAZV4fwbfByUjF46a5XDEe1uvBYmUOt3u1F5F7a+5gomZYjavtQy6AH+Ko57AnUS85rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GrQyP081; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2Q9r3rbS2G+4VqYtX0wgOsjWiNbFS0d9YEL1eMfaJmCK1SQHSSJ3/guiQ9ZZO7Y7Okk+Yqmt0Sr7HbBjMTs/l8pTG3CzgMUSmDuaQhhgxfqyQk2xc7/JGznX18L2oK9rrbOOCLAE7FjC+Fu7VXDHFfdyPAU5uTmZntsKkMS1s0zxrGS7gnXTn0lO02VzzxYL6c94QSXpTwGkaJspf8+EpJAIuGQx2OJ3STYvyE66iXaAPcBEocq1LsXiyIvpotUNZ+lZzqAsBCPFEvl92IwcgU6u8e85/sRIxXFEO/W3aaylKlV+I7RizE7/tl2R1Gr2EHBqcNrJ3OoOb66P1ZfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9ZOzj3sP7PQ9LTSfmFiy0+7hLIcM0snuzEa4/2z96g=;
 b=WuxZye/kjnsobKz0ehr6I/NZmt6YP3t17trqqhawKZEby4KY7RFlJccxSXG5+JlWIlp5tHuVG4O4CzEHZxmDyjz+XiQDbuBXuihI3+Z9t9BhlBj3pKbcURLKTFl2Y7MmHWe0edIZRL0LZDjX7hLl/EZXd+JdHVpNS9EyicSXcBLbdWWevjD73NFn4JTHp61SI+bgLc5McXWI/tOA7VvbXE33kkl1ry6De97toT9jKaGmsioop14hlhZT0MCr2OtgOAGjGk6mMGAX72RyIYDJwLNI82KAfs54IjIsmzlmWT7ffr7iF1Qsx45cZlHK1ry2lybL2Qkqs2Ltx+z12x7t4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ZOzj3sP7PQ9LTSfmFiy0+7hLIcM0snuzEa4/2z96g=;
 b=GrQyP081XxN/Z+jXHl6fP5ogRCBX43yLInaJOGSIZ3TCTvw5DEi5yK35Z0uyCVZFhysvPfifhJ6bKEx2aG5XURUudUUKmXhgtVOZUYMOep2gGxdxT/wgghJyg50JogapRt1rPC4uaxtqG+wm9yYZjjqh6nBfJRC9VhkeGXp0VG6pTY2iX0B7zpG/AjKN7AvinrhvQSpBQ+J/nAZdsQyfrDr9GG+FfN/lonY7+TfIMPPkcRCgWLREUoG/2tUuAHwBoXVnUEwp8EvBLtSgU168wHAXsn5ShnxjYBC1EXEpUGAjdeO1ZuNbA1hK2cAnQu9/BUxpm2SbARb9MhrnGVG7cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 15:23:51 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 15:23:51 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Frank van der Linden <fvdl@google.com>
Subject: Re: [PATCH mm-unstable v2 3/3] mm/hugetlb: use __GFP_COMP for
 gigantic folios
Date: Fri, 16 Aug 2024 11:23:48 -0400
X-Mailer: MailMate (1.14r6059)
Message-ID: <24CDA80A-1CC1-4AD7-A35C-D1919DAA707D@nvidia.com>
In-Reply-To: <20240814035451.773331-4-yuzhao@google.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-4-yuzhao@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2F6E54D3-C01C-4BCE-B4D8-522AA7A0FD39_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:52d::14) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 650d1995-fc35-408c-c341-08dcbe076e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ws/PRpm+kZ+1j3dYrnGzNVb/lqZ4+Q7pwmt3f7Rm9d68ZticmEhb9qemlpcY?=
 =?us-ascii?Q?ACloMtXuooWMLRfcrp/rPChlocfNTM2Dhzo1Bpsh0FXUgmm9w1S9WeWzcIdE?=
 =?us-ascii?Q?TET4xlYkbQ9MDjG8t3npBW5NPYwQF3ZouU9Pufz2RorBiSWunlBlEM8CDpxY?=
 =?us-ascii?Q?0BRruRxXSaoLmE/vWW6Ao4DaEw3+33gyDBNfer9DIJYdxO7vKIM5wuDGsu/H?=
 =?us-ascii?Q?J03d+gOUdN+Ebqm7J0dwRHlKqCL51GXaJAN36ZCKJYJ4mlbz8+KBubP8ZYgH?=
 =?us-ascii?Q?lBzqfYI4Vf3JazFcjA1YtntvJBkKoyMSp2h9Fk2/S9ffyYVXQ3Z+2zFlFyo1?=
 =?us-ascii?Q?NT+EIbIAAml6NB9az8slqCb0ByRvO/1ch0pq5CbGOuDjzelAL4VFF1+TOAwk?=
 =?us-ascii?Q?+PZMm6VtWlRpGakNgS0YYObATH9/L3OQPwYzU6vyF8mbV5AdUbh+0dyFbUvq?=
 =?us-ascii?Q?fMrZ0Pucv9kyfMAfj/Hd+bH2LkdcK0xVu25BUKNCY889mctopKyWT2mj4R+a?=
 =?us-ascii?Q?sRbUBlubf5Btwt+y8PcpwEN2KkaHynPi5VlEknzzjn+wDg3VBCQimeWl7SIb?=
 =?us-ascii?Q?IPto27+J9WkVRvU95OtYCf+8dlPQt4mVdDGkYsE9PAfi+WC7xVeg2M4NaXOr?=
 =?us-ascii?Q?oMqzzZE+ibcVQc/z/jv75p+NEDEkiyKMZEMkkHn1Uda/nSLP93Jpn4SAnR3G?=
 =?us-ascii?Q?Rti0+JLeATl0muZhJz6W6y9XStFQo1C72nnRTh7uUx0m3ecX+XEtl8EYSWMR?=
 =?us-ascii?Q?9XQQPGLtu5u3KpqmwpbCT8QD5qKmr/gFJ7PSgc7DPuYJhcECkRdEYcPTdWQn?=
 =?us-ascii?Q?khHwsCes2YfltzRYDUKS/wTRM9QwY8wMYKctNagEvK5gnGG7ikrtLYR1DbDq?=
 =?us-ascii?Q?/pQ92ipoKz6Pe8Kc9KD94i5JG6xuSmuHEKG3XxdBvZiR/3wES4RvdMSgAgym?=
 =?us-ascii?Q?vRTZ0PYObJxb6SFYhCKzbHb0cn1oBgzydcgxTNYNAPTwVNTF6Ir1sA5RjSex?=
 =?us-ascii?Q?0vLeBdPaggEvCTAPaZgMI+xRT6mIefhOg+rciKqCj5TZH0hn90JH7gbSU56g?=
 =?us-ascii?Q?RBjC8ghuCBTHg+TUVrkKYZx866OTLXrNXxvlUsfx4KkJfDUre6O7stGILkn7?=
 =?us-ascii?Q?D4fi1L2r4WrTZbxFI9nYp9BQkV+RC0qbbE1Z1HlzsR6Lk98yRyAXo26pOs6T?=
 =?us-ascii?Q?b0CW8xfBUBXeAPBoKnIy2KY1GkLc1u2T8gOzWyY2QDdy53o2Dp3twI3BVlJ7?=
 =?us-ascii?Q?+ayFCaPjKVUbLASWqpyCjzyLCx6hzJon5poCoGGR/8Cv9y5i8FAgbSBIE3Jf?=
 =?us-ascii?Q?bWvDHpZcvNs2cSHdK9BIiW47oHcVCNAJtZWAogwPlpV26w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKiVNXcl9eRjHdaR4awk/zFHJYqNzV15mAmlEXZWL8ECh/o6eeDXP02GL960?=
 =?us-ascii?Q?RsRfCwQFYppK9GQ77rfO0ge7Vib0Ywf/iLa2DYfAuUmDuejyPiQqeuZC5z8d?=
 =?us-ascii?Q?4fXiI6ADdOGcYv75KAmvscJiqLE7JLuUgUfRDD6G2fdA2pkJNBKYWFHBZixp?=
 =?us-ascii?Q?C4O+rGqASWzYZ7JqecRqRnS40G+dYeJvhbH/Gxx/Ii8TQ408UKvUsTMP3EYB?=
 =?us-ascii?Q?apw5EocZ8PUfKJvtIwFAD9SXaPNcsxV90PP5fKim+Izi4TpEPFJS0orLqHcv?=
 =?us-ascii?Q?gMlZEldQCSAmvDUVERbFvnoBw9ajrfm5P+TTPwsTbxGtIM3xR9sN/jythDGU?=
 =?us-ascii?Q?/Xl3S/WdzGAz4L7aRQ7B/trIpXkndCDOX34e+JgGiOugXxxEj4rvaDBmf4gV?=
 =?us-ascii?Q?S6UZxdFNGYEnzsDfy7kQzERjqIZhu/PGIaMj8TFu6ccsZABRAyl191XRhETs?=
 =?us-ascii?Q?s7jPeA0dh7j/fonQPIAeKrNKoZ2Dee5lltQSs35DFcafAmM63+s6X9LFdXDV?=
 =?us-ascii?Q?uppsh1HoaepT8+/jeOzuaHvGvibGA2fGRk3EDkQUwmYXJuyJCDtAS05dVCXB?=
 =?us-ascii?Q?HB217dUGtTflqZFyhweudY+gz6bh0UECRjMioVmn8YCCchW/H5TrIrNS6OUX?=
 =?us-ascii?Q?ZXsQS+lpmE37Z3UJA/LpSPF0EBhHTssGkyEC/0QVB8azh2sVI23H6FihVlfR?=
 =?us-ascii?Q?J+GBY8jKUaSadrjyiCjiYs0Tq/CAguus3q7c97MEJ4w3nT+f/r2Z9pT/JBa/?=
 =?us-ascii?Q?Z+ll1OLuS2R3BsSlz6EaweMXJ/HQUZckpLSKYuCeVcdfqm66a3QUkXMdoIcF?=
 =?us-ascii?Q?JPGibGODDaX/lU/VM7mhysANKKSpwWaHPlLgHIMLlBnInTAm344PpZ0nLzRy?=
 =?us-ascii?Q?M2Docm18qAwEynBWRZ0AMVQsrY8GrjSB8veTSj2Wu4lWk01xqOf6CGcqKzpK?=
 =?us-ascii?Q?qEDiNUHNywmCQYsQ4HKhHVl21bGsWzIq7bKuKFhsjTbukAFmFFkGRe067Glv?=
 =?us-ascii?Q?8y/BXNjAI/CwHx6bbx0v1cCU1uANAMUqLa+jdo1fvn2Ak2DqEtUqrp2L+kZL?=
 =?us-ascii?Q?/EG8ySZ2TfSCtKqalGU1NdUQy9dejmmcUzpu2FFNjvZz1ssfOdYOakwjSoxo?=
 =?us-ascii?Q?osJ1nJ0vSJjeseFtBF9txyRvkjfAVf2EJPU5Cf3Zh4wFruI+AeiiNhbvZois?=
 =?us-ascii?Q?FROxbYtdJ9Op7OKALCyDuiEDcJhkSzmkn90Gwgv+Xxrgb75Q3eWpKphb9Ias?=
 =?us-ascii?Q?oYcMdiSZE/av/pzs+HERjO3bhC3wdG69awCcK3q4ENnOqK+cfn3dvfUuMGJi?=
 =?us-ascii?Q?LMbpztzSntYaXc2/G5ISOYfS6GbfwU1O3GxpGSWflMXUUSHCEIJhpgE6L9g/?=
 =?us-ascii?Q?7IesmCr7MSuUollKrx88eYXEKPvEgGzu4IqFZ6HbMBGlqoAIammJiDYrhILI?=
 =?us-ascii?Q?HCDTdrNo8dlW6tk+G7KemqWBNnxmW7hrBKRn0QHy+T2vfVFyDD8TpLgtp9MS?=
 =?us-ascii?Q?qLI8avYYxihfsJYeW7bA+NNligO7Qmgq+DE1JojVZPAYzXzKZdGaSgOZTqzP?=
 =?us-ascii?Q?Q6pxFO90NK5i7zmurkXKLhDHkpoMqf3sf4djnPMG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650d1995-fc35-408c-c341-08dcbe076e8d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 15:23:51.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeE1i95zzRcuKO+Jh87LdR3L01QFlO24Ey7pbqwFiORAa6WryevcSgBo00LMJW6G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408

--=_MailMate_2F6E54D3-C01C-4BCE-B4D8-522AA7A0FD39_=
Content-Type: text/plain

On 13 Aug 2024, at 23:54, Yu Zhao wrote:

> Use __GFP_COMP for gigantic folios to greatly reduce not only the
> amount of code but also the allocation and free time.
>
> LOC (approximately): +60, -240
>
> Allocate and free 500 1GB hugeTLB memory without HVO by:
>   time echo 500 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   time echo 0 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>
>        Before  After
> Alloc  ~13s    ~10s
> Free   ~15s    <1s
>
> The above magnitude generally holds for multiple x86 and arm64 CPU
> models.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Reported-by: Frank van der Linden <fvdl@google.com>
> ---
>  include/linux/hugetlb.h |   9 +-
>  mm/hugetlb.c            | 293 ++++++++--------------------------------
>  2 files changed, 62 insertions(+), 240 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 3100a52ceb73..98c47c394b89 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -896,10 +896,11 @@ static inline bool hugepage_movable_supported(struct hstate *h)
>  /* Movability of hugepages depends on migration support. */
>  static inline gfp_t htlb_alloc_mask(struct hstate *h)
>  {
> -	if (hugepage_movable_supported(h))
> -		return GFP_HIGHUSER_MOVABLE;
> -	else
> -		return GFP_HIGHUSER;
> +	gfp_t gfp = __GFP_COMP | __GFP_NOWARN;
> +
> +	gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
> +
> +	return gfp;
>  }
>
>  static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 71d469c8e711..efa77ce87dcc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -56,16 +56,6 @@ struct hstate hstates[HUGE_MAX_HSTATE];
>  #ifdef CONFIG_CMA
>  static struct cma *hugetlb_cma[MAX_NUMNODES];
>  static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
> -static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
> -{
> -	return cma_pages_valid(hugetlb_cma[folio_nid(folio)], &folio->page,
> -				1 << order);
> -}
> -#else
> -static bool hugetlb_cma_folio(struct folio *folio, unsigned int order)
> -{
> -	return false;
> -}
>  #endif
>  static unsigned long hugetlb_cma_size __initdata;
>
> @@ -100,6 +90,17 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end);
>  static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
>
> +static void hugetlb_free_folio(struct folio *folio)
> +{
> +#ifdef CONFIG_CMA
> +	int nid = folio_nid(folio);
> +
> +	if (cma_free_folio(hugetlb_cma[nid], folio))
> +		return;
> +#endif
> +	folio_put(folio);
> +}
> +

It seems that we no longer use free_contig_range() to free gigantic
folios from alloc_contig_range(). Will it work? Or did I miss anything?


Best Regards,
Yan, Zi

--=_MailMate_2F6E54D3-C01C-4BCE-B4D8-522AA7A0FD39_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma/bwUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKp/EP/2sHj7EFEp5b0IINwGVJF8KAASPfck6GrECC
eNDVu/EZIgNMaAq8gHJyH9lG9w2s0A490ibXxbFuHTRFdwfwSWIMv+bYRCZOzNgR
2ivUxzw5BpqYks2ffvnAsAfG6z3oKZWHeSvlAJ1COG10J0relskB/FVSJh8Xv403
zdSL5zpNRe/HNw7pbwIksYSsoLfBf+fctzGVXQHheIBGaVYe5oRIargKM0hIhOlT
XhqbNPQr62cH/LhU6GmAx57XAtf8L2xwLzolKXeGe1OlDLKi634+rY+yV5cESi/g
dxxG+zw/hPGdvMmXRDwrJ4v/tzIYOPGWwNJDgRxKNe4EDbFPHGb6iQS67G7niq5U
qe4ZQQtn9jcdkyjVJthQlkKhNjZuQBN2L7Q7XTZbc3nJBsnc2e53ctEp2bYjOuR9
+GRf5Rw2ArPBvs7AuES9XEp7kc3LERyslTX3pzj3V4VTwHnPDOjirxzZoeqXORj8
kV97jLzDQoNV3PyZGgi/B5HcnjGsEuDu7OXjSrC5/O14gcfmUKjTtCkp8yRRYrta
YUYlMZ4Im6gGR3WPWYNoz5/hODIRuzGquadwT+OZahXlokgUgJM+/K72Npkg18iG
YOIqd/nki5S5uqVT1nJ+fvO8K65JMrl4g647fcPsDC/+sRx2Xi5YLdQG0/0Dme1L
A4f1k6+7
=+ogZ
-----END PGP SIGNATURE-----

--=_MailMate_2F6E54D3-C01C-4BCE-B4D8-522AA7A0FD39_=--

