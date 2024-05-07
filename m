Return-Path: <linux-kernel+bounces-171788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C0C8BE8CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7389CB227AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB216C43E;
	Tue,  7 May 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4hm/USg"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9F16C434
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098817; cv=fail; b=Sj6+AHu7FnR7D8Op7S9KGXlBO1aHjGa016bbD9mrXycFNrNk0xPQTlGJS++RQqJPbABU0sd2e7W8huR/GG6a6Lo6nDyKVOtmH+ZSkPlMT23X9fvu0nKaT0UoEGnCzhTxRNaokdP6oWXMP7NEuYGJrfe52bH2SQj42MfJk/+86dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098817; c=relaxed/simple;
	bh=vxCNwBsbRbkns6ExcPtKOoccs9tUzinSjzpP/noLl5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pw++DDAXiRuE9gxQBIs614UUCWd5+PWyNTjqgQCi38wjHvNUcZ/PRW0NCMtzAUFvmzanClJyqKAwe4larjs4gccULmcxB9/rbSFgRWgjC1X5rLpbjJYcv3UORGiquDa9P08mC3WYADMt7Erg/E3P7DM6200amYLJ2QA1jZ1jfHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4hm/USg; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyoCjru6oY5IQPlJbjzaDMI/xSI4FBiPoUS7vJyf3N3Z/Pk1mqZNWhOSPiwhlTOCiGwNAZlzw4VEmo/+3ZIu90uy2TprWDfiEBiDIwgqsKBeCPHvZkvnBwQPaJS7Wa2HgEsyM4IUmsS1WEmdV/Pb478mNXbmCTlUntlw4snStDryZ5g5w6KyhGeIXEZM/bgXdBL9MdCArvgcqZ8xHDriTtsR2N0h+2o1Mtp4jYMzbGAxdBLldaZQeX0ytP5Q1/DiUSmu6kBdqH9fWKLTe6PPx6EgYWDduKklqCHG30TBW3fas6mOVaWDH6y3cw88xINttpONiIY6LbV1efoBQcp/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEI4bwBFDLALk2VEbXyC4uBpVN6LxUd0Z7FhfR2t86Y=;
 b=f7iP0mthby6Bo8FO9p/mgQiGk4wx8DS/ysObxnSI9Aiq0wOjWxGiYDa+149oJGvbGtxyf8KGWurt2MmPFYQy0XYL9UaZcomrA+FLrKiTzhHtK8S+DXOG0hkp6NezZgAG6gayo7e4ml32aLLF5hYtZM0hq7ESvgk3QjjdeQTs3v0mVpPSW07ygrxkP4KM1+BWplQG43M4rPNQqCl2CHwSv+CKYigX5i1ENpsvH0ML3VgWN9qhZG1tYG3Y4KhCA1McdiELjIYlIwKbMrbR72LtcNS7tYpXqtEybe/08dFrVJ9Xzn5PV8f9lAwag8PtJpCtH4xlCEJWar8J31u5nZpYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEI4bwBFDLALk2VEbXyC4uBpVN6LxUd0Z7FhfR2t86Y=;
 b=O4hm/USgWeVjgn5AGzj+aVNgaSw7aWo+7/p8MkXbwGUasoJQwTRrAdEXbrwx7hNCacgFFA0KxmawcE00oMgwOXHIfT1cfKpeMvtQnaV8D5cOBq7dSOYMKTTzWr8wqf1cZ/NP6PQlMGeVuluzhoVq9CFp/vk+cBnKgyg/3sfqcs7vNWwRPtEOvEqlKciadzLpctOPN2/aM+I6+9CBAnQVdu16zJzQwyyud+g8VIf6pVth8dgUO0966OIBvWA4//tKHndpnEqpQomNjmbc795f2M7c6BciSYSS1UpK0st/JkAd1z6ccbxUGxpYuXpKP8MEZe0X8sYMyN/8kpxLTRa/Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 16:20:11 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:20:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ryan.roberts@arm.com, david@redhat.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v4 3/3] mm/vmscan: avoid split lazyfree THP during
 shrink_folio_list()
Date: Tue, 07 May 2024 12:20:08 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <9BC53B16-A63F-48DF-BE0B-D51E0E82E1B4@nvidia.com>
In-Reply-To: <20240501042700.83974-4-ioworker0@gmail.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-4-ioworker0@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_AABD3D7D-A972-430C-9D2E-FBED6D4220F3_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:208:32e::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: c789086b-97c2-470a-3779-08dc6eb191a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cRqc3vycX4O89UQeeyDe59c4c/KAb3jLf8nfBOcGi7RbBFibBNAJPFouhwcV?=
 =?us-ascii?Q?wpK2JnqJkzk7nwnz9e+Midt9jtVsSIfqzal4HNRY9V3vNGiMqhpeNpP7VzNs?=
 =?us-ascii?Q?G0JvVvN8Hk5DW5GGDoAcvaNjKLKgxv+5qiBLrQ8ge7tJEpQWRUgTQNDe3P5X?=
 =?us-ascii?Q?hYTxFAJ2AQnv5QDHxwjSlI9au9nh+hqrMiaBgb6/Xk10UBAffYHrd3txPQ8F?=
 =?us-ascii?Q?fXewb2GaqbBcpyYm5/EasWSzOc7urLPnyxlG7ekvrKL5ShddeUCpIX2U5gaG?=
 =?us-ascii?Q?zzEMtB9ML5vFFP7WQ+RynT05dxcYEW7oYQUPBRPhJpvXBeIq/G625pf0V2SH?=
 =?us-ascii?Q?ZoWLL7J+MGWSsSUVEkoU+5q+6Gx9LddkU5PjaKM8fPyVYBLOJTZ8fTzgwBM2?=
 =?us-ascii?Q?aCpLOMM0RZPWzOwEkW30lhRUwi5UL9fPIQz8QA2MwZ9ig0trjRfgr5OPsx3t?=
 =?us-ascii?Q?bT+z4tdLD0bHSMGfIhRNAUamC+wPFSQYFcHpGhsue/2U91QnlGWPQx/YJ5Nv?=
 =?us-ascii?Q?dk0j3u0wvkG5SE6qsOuvwPbOjE5z0hhCAFzTW0iODw8Z6zZuEDdAwFZSdiHe?=
 =?us-ascii?Q?MYVPKsI7Wdb07DEEpW+TLMphz/DatvSxIQcds2+efKvysGSnUIWgpWEOL/ZB?=
 =?us-ascii?Q?sW+CKjRwI3whhE/0mxCBcO78y+SCaPocFjJCFiplhoUoEDFEJqfDdXGM3EQh?=
 =?us-ascii?Q?sC2jYx2XMPg+OnhXydsgJlvWj0FEqIsdzKE9pmWiPx7gU9GkTpkej4MizvQw?=
 =?us-ascii?Q?+qPdW7MleA5s8HhJflHnlYsmOms3VjKUCaH5HZ3N1Ncc8VZ3Dq66NP9Hk8lf?=
 =?us-ascii?Q?9wiupyJg4uDpDgePcM0TYLKCp1I4DtIUoT0ogLRPeufHbAOqf9xf3ZeJLw3g?=
 =?us-ascii?Q?g6N/YV9RG1Q9TFxr/u8RTos+x3AYrZRTv3uVurmiTuts3q8tYIPIxbLbzSZa?=
 =?us-ascii?Q?vRbgLf5gV0OA2wMjegjKvc7UhMt0R6p/em/7WfTEhMhtLyMx92tFy+rNvxbL?=
 =?us-ascii?Q?kNVdVpZYwb+aTc8t8pSog34/xOvZf03qScXdmHpqMRC6lh4TsgNKo5xc5KDx?=
 =?us-ascii?Q?xJ7z2drfB4nEGzd7UAhRxJlazc96R2mL0162y3DeWjQpJGVb6+4L0wJ47z7O?=
 =?us-ascii?Q?Y8+UmMWiPuauq3P9dUsKpgNx3TlmYv/20GoSXDSiT1EJg5C3ul9gE+DZE8vk?=
 =?us-ascii?Q?tAxHkwDwwoZMzXhqCSehKNP2iXyQC6n0HqOWNIQVzOzEBesfeHTjCh+4Lz4v?=
 =?us-ascii?Q?+TLLbsuboCtTXu9mDY635qkEtkrxy4f0V57RT0diZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P4nNb+zTA/GIyN9Skt48cxrUVi9XSXaTbqNVyXajYhA7A5y4XwUm+ffDoWR3?=
 =?us-ascii?Q?AkIV3koveWidCUxC5ggbTGuYXpo5Uo2fNZjUqmUHTbrI+HZbRRDQjwE4Ak6Q?=
 =?us-ascii?Q?qq6ibeOWio3MFT51/LCS2lEkM26O1JuZgLuq1KJoK+2w+eibg61phX2PuCKw?=
 =?us-ascii?Q?1pYygUKxAXqMBQwUq2K2GupNuwKxG+gmLlaJ3NZiOf7KjS0Rr94uUOS8Ih9E?=
 =?us-ascii?Q?PMttkoe5jYtpwKb8N4kG9RqnT6iQwoYBwkyjtrpuNEyOQrLXHcbLFwQ7z7Uy?=
 =?us-ascii?Q?rcykscE4Zf7Hk1mHiF69QgtrRa6y74KPeVOzkQKRcg9TAWQqrgNzVkn69ySi?=
 =?us-ascii?Q?YL/Fkn/Lk7VpGxcBEyd2mOnTp0+lHcjV3Wh1Bcne54HeTH6xXIbYv5yrVF3e?=
 =?us-ascii?Q?mv9D1h7zjsKpWhmNZkP0bV44Vj/IFaKXpk3iTfuFV+uOvKuoywmH3W9V3zJv?=
 =?us-ascii?Q?oVZKorefK1xabgcRlENpZmBWK5uDxzYQ2uFxkpER/y1EmEKF62Ezef75ev3u?=
 =?us-ascii?Q?VzcST0jTNNJTJgi0XrSslIfvlhA+eCBYPKVaXWZXrnszSPGIRxH+uoVC+xIA?=
 =?us-ascii?Q?kK3MqZ6DE04/x4Z3Kgxjg3tjaNb13YVIkU96oDzwD/eCRpCyMuDSEUoVauee?=
 =?us-ascii?Q?uk2vO8pkezlYEbhUZYxZUZWuy7IRiGzGy/ML0rzb9S6/2I+HXUHx2Mt+ZJqK?=
 =?us-ascii?Q?e2Q9vZIWJbwJrB6aIBKfDSewubOOYPp+KGZJwmGPe4xfjsyntZJbF4q4WY9D?=
 =?us-ascii?Q?6kbIfwHedrePuJVAHzoNOuQOOPYT628zLTYdaEcX1u6r5cy63Yy+9CFIynfZ?=
 =?us-ascii?Q?vj1u0+eXZb58hZau2tA96cxyEl8I8Vq7gIsDUl4uvZufs8g0yuZoR7Z2k23o?=
 =?us-ascii?Q?nNqr2Fc/l3hykq+wHaY8t4d9+qvSMr3S4qHBuOpWT/Vqa2SSt50ojYPxw/Hb?=
 =?us-ascii?Q?BhGMuQXumSEAT+cfqR/R3Es533Zlg9vniFCuEzFj6DfEjkkLP93zpAKkCtOK?=
 =?us-ascii?Q?smT/uTvHZ/qxmUieWQWBSUK3rWIpuPzTSpgM+Us9HI5ax1a233Gm90aF3rFP?=
 =?us-ascii?Q?DH77fVJV7Zc6qso+MquH4Rynw5S0LGFG5qfxKITbCAw8Pdd38hkWvqtQJjus?=
 =?us-ascii?Q?4Y3YIZEHE8jp5QSONBWGhLLI13jjlGTpDh0I67CuTmeGZklciZionpABz6eZ?=
 =?us-ascii?Q?vY2Lsi2bkL1AIUfvoU6pFtgKiXWv3VRkycC07+I0TyIkBfdcr/of7RDIqOiR?=
 =?us-ascii?Q?iT59YOw0q4PZiqPJtNvFu/Dy7l6KI0Faiqq84x4PXBpKY/ilNc5HbYPy+u88?=
 =?us-ascii?Q?7B3KpCAzhk9l11tKHclI0GSkpLnE/Z1ltBOSxCaDu096/CfqpqRDWxd5lKm5?=
 =?us-ascii?Q?QGE+S0DLuAfro3ymX3ARHGr81OHJK1LjfBGM+VEQcr3i0l2vWeXRNaQvL2cQ?=
 =?us-ascii?Q?1LbmAtoLVI65R2HPGMlnO0sYKcAPzxgvu20Hv6YiXLmP0ojaVTXZoyTYEI6N?=
 =?us-ascii?Q?+MRZsRY8fgejlLu+CAbtWLe0WxOVWoaCCtaYdibITdh55lR24nEdH/hKtvRd?=
 =?us-ascii?Q?xQn31BQJ1Q9eXMrvKgaumXwt0rGKmIAF7llIwSz2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c789086b-97c2-470a-3779-08dc6eb191a5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:20:11.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLzIaPb4zV27TNM2TqhRA+beS6L/pqTGqcp8TSbsTR5oeEyxe5LQOzdIfc0Ziib8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013

--=_MailMate_AABD3D7D-A972-430C-9D2E-FBED6D4220F3_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 1 May 2024, at 0:27, Lance Yang wrote:

> When the user no longer requires the pages, they would use
> madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
> typically would not re-write to that memory again.
>
> During memory reclaim, if we detect that the large folio and its PMD ar=
e
> both still marked as clean and there are no unexpected references
> (such as GUP), so we can just discard the memory lazily, improving the
> efficiency of memory reclamation in this case.  On an Intel i5 CPU, rec=
laiming 1GiB of lazyfree THPs using
> mem_cgroup_force_empty() results in the following runtimes in seconds
> (shorter is better):
>
> --------------------------------------------
> |     Old       |      New       |  Change  |
> --------------------------------------------
> |   0.683426    |    0.049197    |  -92.80% |
> --------------------------------------------
>
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/huge_mm.h |  9 +++++
>  mm/huge_memory.c        | 73 +++++++++++++++++++++++++++++++++++++++++=

>  mm/rmap.c               |  3 ++
>  3 files changed, 85 insertions(+)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 38c4b5537715..017cee864080 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
>
>  void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddress,
>  			   pmd_t *pmd, bool freeze, struct folio *folio);
> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> +			   pmd_t *pmdp, struct folio *folio);
>
>  static inline void align_huge_pmd_range(struct vm_area_struct *vma,
>  					unsigned long *start,
> @@ -492,6 +494,13 @@ static inline void align_huge_pmd_range(struct vm_=
area_struct *vma,
>  					unsigned long *start,
>  					unsigned long *end) {}
>
> +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
> +					 unsigned long addr, pmd_t *pmdp,
> +					 struct folio *folio)
> +{
> +	return false;
> +}
> +
>  #define split_huge_pud(__vma, __pmd, __address)	\
>  	do { } while (0)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 145505a1dd05..90fdef847a88 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2690,6 +2690,79 @@ static void unmap_folio(struct folio *folio)
>  	try_to_unmap_flush();
>  }
>
> +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
> +				       unsigned long addr, pmd_t *pmdp,
> +				       struct folio *folio)
> +{
> +	struct mm_struct *mm =3D vma->vm_mm;
> +	int ref_count, map_count;
> +	pmd_t orig_pmd =3D *pmdp;
> +	struct mmu_gather tlb;
> +	struct page *page;
> +
> +	if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
> +		return false;
> +	if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
> +		return false;
> +
> +	page =3D pmd_page(orig_pmd);
> +	if (unlikely(page_folio(page) !=3D folio))
> +		return false;
> +
> +	tlb_gather_mmu(&tlb, mm);
> +	orig_pmd =3D pmdp_huge_get_and_clear(mm, addr, pmdp);
> +	tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
> +
> +	/*
> +	 * Syncing against concurrent GUP-fast:
> +	 * - clear PMD; barrier; read refcount
> +	 * - inc refcount; barrier; read PMD
> +	 */
> +	smp_mb();
> +
> +	ref_count =3D folio_ref_count(folio);
> +	map_count =3D folio_mapcount(folio);
> +
> +	/*
> +	 * Order reads for folio refcount and dirty flag
> +	 * (see comments in __remove_mapping()).
> +	 */
> +	smp_rmb();
> +
> +	/*
> +	 * If the PMD or folio is redirtied at this point, or if there are
> +	 * unexpected references, we will give up to discard this folio
> +	 * and remap it.
> +	 *
> +	 * The only folio refs must be one from isolation plus the rmap(s).
> +	 */
> +	if (ref_count !=3D map_count + 1 || folio_test_dirty(folio) ||
> +	    pmd_dirty(orig_pmd)) {
> +		set_pmd_at(mm, addr, pmdp, orig_pmd);
> +		return false;
> +	}
> +
> +	folio_remove_rmap_pmd(folio, page, vma);
> +	zap_deposited_table(mm, pmdp);
> +	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> +	folio_put(folio);
> +
> +	return true;
> +}
> +
> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> +			   pmd_t *pmdp, struct folio *folio)
> +{
> +	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> +	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> +	VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
> +
> +	if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> +		return __discard_trans_pmd_locked(vma, addr, pmdp, folio);
> +
> +	return false;
> +}
> +
>  static void remap_page(struct folio *folio, unsigned long nr)
>  {
>  	int i =3D 0;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 432601154583..1d3d30cb752c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1675,6 +1675,9 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
>  		}
>
>  		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> +			if (unmap_huge_pmd_locked(vma, range.start, pvmw.pmd,
> +						  folio))
> +				goto walk_done;

You might not need to check (flags & TTU_SPLIT_HUGE_PMD) for
unmap_huge_pmd_locked(), since you are unmapping a PMD here.
TTU_SPLIT_HUGE_PMD is here because try_to_unmap_one() was not able to unm=
ap
a PMD. You probably can remove it for callers that are unmapping
the folio but not the ones are swapping.



>  			/*
>  			 * We temporarily have to drop the PTL and start once
>  			 * again from that now-PTE-mapped page table.
> -- =

> 2.33.1


--
Best Regards,
Yan, Zi

--=_MailMate_AABD3D7D-A972-430C-9D2E-FBED6D4220F3_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmY6VLgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUMgUP/0uGoza1cCIGCMznDAcpjiqqx/uAbMcD+7di
JhIDK/be1xyTJIMxWUkra1406EKF/g5pI9QeX8wJl8YfTpVGx1wbPbVlco230Cyx
5794JLhTBCPyHeHspBE6HYzL1MsRtu12U7GBcxi24a4ewlv8R/N9h7PW7Iood+/T
7LFPuM23FCRpi20tN+OrbM1oBEnouogESvDspWQkYCIIH+rGtAjZN71stVGhQB4E
dI5IVAQqSUb1uwE0kh8k3ok3qsHgsoQWluv7qDamojaGeZN5PVyCzzoAnzord2eI
G06l0f3oy80Bd8XWEfEaUVGsEGDLiLahafznKKXpvbMILF2oLow9HjSufi0okiJj
3Wj7r8vvc1JOmIrs1YKK6T9VPCnYCSrxzw7LzGLWcjTyjneZIzVZDUMKK0juhkGi
EHbIZFl+LRvhr9HmCVZ289BcZGbr+k7U79R93iWQzQL0qWosPniY7bRziarkLVOw
5cjNHzupYTE0gJ6x9q2YeSqULG9XNIcp1TebqkWuZndWtwq9IJsu6NAPwal476qY
sJA4avq3mKrCX6Xli9PIXrjP9it7uTj63Qc2b4aesVjEkIiAyS3UETXl397CBRyT
PdhD21AcGZAbb04d2efl/hOPY+0TYbe5dZt/yCr6GD5hhZQoHhxd0zJ2cemTJ+CV
fsE4/9ss
=m29e
-----END PGP SIGNATURE-----

--=_MailMate_AABD3D7D-A972-430C-9D2E-FBED6D4220F3_=--

