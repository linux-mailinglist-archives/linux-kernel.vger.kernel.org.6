Return-Path: <linux-kernel+bounces-171691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26C8BE760
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12312838D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B717C1635BD;
	Tue,  7 May 2024 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qQ3xhX2B"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A4160862
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095574; cv=fail; b=ncELf67ujMr42dPqholj5O15EqxUrIAVTp9AH7yCvvHdQaxjADxhb6f6Z1CK1dz9oF/LT9zeqine0tf4D6fcoXkNe0hGWtezd/uVOqdh0aQv1P8BZv2V/cADarXxGdV5XR5SBxFOp9sALyMZBW+mcefsRljOEwQRkaazuGhecVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095574; c=relaxed/simple;
	bh=+sCzvqBhSxLQ2tK/9XE1BsGUfhjpi6NEJKyUffzwErc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VC86KYbFL9Gkb626khnc3RaObMVcuMH3W6rBUf0Hm8GrA3PiZBWWd5s9x7WrirP0kfFlFqxpI/otkpx8OSF11iug5XrogVThmWJ243CSWprf9v1zfq9RdqeLyHgozMoS/B/XyIAvMDaR15jqN2flHmnJzV+v7p6yV/PxVLxxAMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qQ3xhX2B; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZNp7KOe4gAZt1wdkM2FpvhEuEz4jKKcLdbxqk1gGE1Il8GanzoQiarZXgh7arMHsefF6WPmTvPm8SMY52rYWIJFesrsHi52wZXdC8LSfRGf1wWAH0oYXfCU9o/M1rgS5LU69csehRaZ4PzG/8uasIjFBJ4eLjkKMgVZ5l4v0PiSkQhQKpbXrbOUFIbMMVPg80/jeFQOsZcspLl/6iy0zt5bQCp5RXfmeGQyS+reOQjLGfjBjvpGEnA2zmLUl1vzpZ6Ce4ZAObjDnw+D8HCv3Fl32XgfnhNk8ZRuRjFndh5gJXnkqFgaMdESF5yvbxNYtXbGy9BLMMW5XqxKJ7Jm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAOhp1vFQutAj2Jo1sCYjLCkYl/Jl7aFvWROoFytbKE=;
 b=XmEsEaGf8cDP8zEJ/r3dlvOMTlPKPQg0ZPkBUZYSTCemy01RPiVILS1frsn3/tTCuitrjVFT1Wv4ThLj/K+nihAmJHAtz7LR+J2Br5DA9sS577xxlULVQfYMO8jaBtgDVp+iv5DeluIgfYzHg70jclNxQspd7RKfGvuTEs2Unuzra2EUpnTZQX3rsOh253Rkco4GF9Z0lHHeurCprx/plglwRYYpjTxbz08iE3DIrV/J2IzL+nMD0LzMDh+xqysIQbeUC8kj1Bs/B7bLI0Kr6bnFiK1KSW0E11Rp3uvfATpHrCAd1M+V7XAG5CqbbwQfXNsTd5ZCzWZIvdh1LcfhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAOhp1vFQutAj2Jo1sCYjLCkYl/Jl7aFvWROoFytbKE=;
 b=qQ3xhX2B4C8oAedqSVQ/in4t/a7IVPycZW2boIaEjlnUJoQnTMpBLyzbNw2WRIUv35YAYbO9QrCuHPtN0bLuXCDaDB2xsQzs5eWm5yC0tAKJ29s57yy/MuQ17zHVmZxn2sZ0nJt2k31JG1OTplGzt2TKZFfXtnJUqv9JxVvhKQLV7xvyf0WWTtoFH0lIFv+JfU0MbWFBEKDyxIacZ5fcTCs7FuJ00P0cffGCuFqqvCaxhm+ZFSFmrtAdbytbqby4Zw4TCU7cQhfoBhWcJkmrHRpDG3FIKlaSPHSwzz61hUHxlLH9di11+A4lzClYfMxt2pYwZCONQVZwiSBoLlYsMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:26:08 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:26:08 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ryan.roberts@arm.com, david@redhat.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
Date: Tue, 07 May 2024 11:26:05 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com>
In-Reply-To: <20240501042700.83974-3-ioworker0@gmail.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2805D75D-ACDA-49E1-81EF-2AEBB181642D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: f9095ffb-751f-4388-9caa-08dc6eaa04b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fgPdDL1AUzvKE27Yod7vrZTGTpnMn/cntRwss4W2cULociZXfHyUqxHLEqVk?=
 =?us-ascii?Q?ClDWXgpXDhwmx4N93vk6iK19JdCGjdQIoARLKjcokmod9pFvx2xxwpZ/qWdk?=
 =?us-ascii?Q?O6l8rYYf5CKg8cDs1RZ+VkF/kbCS/GrFqzTHcRYLml02y1zLZEsovSA3Mc29?=
 =?us-ascii?Q?kpnp+LbBz/LJEiNKeNKOzMeqNjGl/EjZGAOOvyAj1KJL2mT0SJLwrQpqSUyR?=
 =?us-ascii?Q?gMTPnjQRA4xmliOnKIvN88IsB9GBc3x/0CresOJXQ7gwNPsz9TDMDFwo4rpi?=
 =?us-ascii?Q?HRqRWJGtIvE9SvyIX25putd3V1ofidrP5Dv3O5zAPhwZELTRXeoxrGoPI4/A?=
 =?us-ascii?Q?o95iDEIWPC9RGNXIkr9JEpNshfvbU2nKuB/GUoI81J+pZjk+TDV9vyeckeCp?=
 =?us-ascii?Q?OJp7005/x4sW3ddZ3eiY6ust89cD4vhk7KppPoAKp6wgs1aDlrF+CDFCslK2?=
 =?us-ascii?Q?rh8k3kQxfd5u8d4zpedWbNWj/MJCJN6OOk4vX85JcNMIcTVJiynDcdyBOhOw?=
 =?us-ascii?Q?98h4UOe1eJ8IGJT5x5bWXajwBpXiWjpKjol9BkrNycvUDuYDKQqCIqhj+UX4?=
 =?us-ascii?Q?jqA/FZEW1O65p1FlStJx8ezLvIaYPDrbRX7f+Rf0APJpaaRstfkMDHJZc5Lp?=
 =?us-ascii?Q?Jo1/4RiQbBgQz8XRdERe0DuTOOMf0KmgbLj81odukzAtVZmXOYLuhWFm5gPC?=
 =?us-ascii?Q?/IzOT00D1xBrkqdOMjgPeLSU8gZD9DIg8OOiPCZalKOohlSpopQiDJVQ7Ri/?=
 =?us-ascii?Q?wn8ZvHYQHo3zpNQ4l/nQQZkjIGLKzA/P3/gvagQ3Gb2qv+G/ikSn/SXCybZr?=
 =?us-ascii?Q?4yj5x0FpUau4iUH+758pxWsasA5vQvm8tqWL0EmYt8s6Zv99uKvPv7WHw0g0?=
 =?us-ascii?Q?XsE9h0cn5eWnkNPLenuMmKLXFTaoIG3+Kf3H57JG8+DqzWghe2Vs4AB6DaRM?=
 =?us-ascii?Q?/4tjTQgyZC4T6btTnBFvl8XWlwdzgX8k8DETqevTi5HGnGMViv9VuNYGEki4?=
 =?us-ascii?Q?kFXDJnc1F2jow6icNLv73m9fAiJ0rlfuJRM91luGm4YPdCyHGgZKMQJSpshB?=
 =?us-ascii?Q?o8vWCVNtwcPbjF1nt2i0w8mCROb18weOsAL1RC3JG/gNhHtGUXRCXJfIiRkF?=
 =?us-ascii?Q?JPvO+KX9s16JP+I5LmMUNk+8SAzNjBKsnHeSkHTwul6tp3OxUzjpoGqLlIbv?=
 =?us-ascii?Q?M+lFmL9cekVyNXSexM7V1cvevx6InH6DleoiCPPZdjfjEBtO84WXWXnA0Cip?=
 =?us-ascii?Q?WAQmQtI8lYcL2DGv0xLFeSWGM28e4yHQ5HNSSlplGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3sFCOEMawDsZ3Vrs8UhXRj51mIt+KqveIE15z8IknQS+bNKZuaV5WIwzjqEm?=
 =?us-ascii?Q?jooF8Xt6LYJjits0P4UY9IHSu9lhbO5LlnZ/uSGhV+7RPwmQDNcI8deI6UTh?=
 =?us-ascii?Q?O9n6cX+Q8hmDsVWA6jinrekiskF2Hti8xThfsJ7lhQlAzRKYrsyT4cvmjZ6W?=
 =?us-ascii?Q?xaXo2k2i0+tlNxvtDfzHM9CHcfZUUQH2sKAiWkmoZ78bckIs895rDcxl42uZ?=
 =?us-ascii?Q?nPSorx8pSXyOixfAyCX/VVtVlDVtbsxcaRJtidb3zpxN42yXc2sWuWEAwWLs?=
 =?us-ascii?Q?pc7szeedsZPrFj3VMiBi1OHy3BtovPozEmd+MV13KE4Bb8DsIGmi7NVBcUOd?=
 =?us-ascii?Q?vToO7+TMKTcIuzhvivOXK2QAUkle/olcc4Gcbe7tCGoVBmkBftE3XNk3rC12?=
 =?us-ascii?Q?eG0lAf/TLJtwa8SMBdSLmpsN4TwI4km3Lkkqch4B6hExPXTINHsiBdaL8phw?=
 =?us-ascii?Q?yMWEprgY9nBMspIKEuyzgJFGRWJuILPC8uTBKLj6YiVfAae4nJCmr9WByjmZ?=
 =?us-ascii?Q?RX5L7bvW7ObznMFmCYH8ZBoLrpD9QxJi/8bWjIv6FqS6cjyh/uDC87q2BoQO?=
 =?us-ascii?Q?HyGqZrPCTcDsSQRnIR2pJK8hwlijCjGK+p/4IbCCG/z5t7dnpJhygKzaBJNj?=
 =?us-ascii?Q?+UIyDiK4eHDc8EsiIb8lX2ccy21Yk4M6TECZIdB5Vr/kq68Drst3eLFA7eQZ?=
 =?us-ascii?Q?CcYiDmGYzjrRttrLKqH3tNE872wSeZxLExA21XlRz6RoPuipBuaj5pc6WCgl?=
 =?us-ascii?Q?4IZN5sdx4VMltOWQ/6h0OUtwRSOJoTsk7Ppd4/vQHI8Pai+mrqmgWAzmXqoo?=
 =?us-ascii?Q?Wxslj+2Xd3rSXw0rUMz2wfofUOc9Ff8GMSb9JSe40nGYyR4nUndiEPtYzXqm?=
 =?us-ascii?Q?rwMpy52FwlzJVzLPjWgH/jFs9mEWFEr75OYu1K8rlazG6DS2/Otua9o/JVje?=
 =?us-ascii?Q?5EglfmDOnJ32bYGl+/twaB7AIc8P2t8EZRhqt7+N0FZUddQ9BXCNp/6VM2zz?=
 =?us-ascii?Q?q7z+QXgsK3p4K2df4p7Z9g+AO2upYlIxmwZzuNY39+KsLOW0jDBZtxXxwcQJ?=
 =?us-ascii?Q?1W66SlLMuJ5/YrudAdH6Z9JL/4XK5MoTg2VykXbuwfuVT3azK8qYdfxiKcWh?=
 =?us-ascii?Q?R1IlQtvi7P7FtyfATenW1N5gTTkxvgP+HppXIAt8K+RFX2GbEqla8cAI3ewR?=
 =?us-ascii?Q?+RsmljiaFD2Z47RqOTIVW5td7yN/UKvRVDz549QjnCwRsoVfKIumcSFfQL83?=
 =?us-ascii?Q?U5ZzWvY50Gin0AmFyUq+jMP468tMDRYmFvQlvMaYW520gL0i9FvOddoZU+Hv?=
 =?us-ascii?Q?lsB8L93XGuwF12EKF60f67zSmvsJFkH2dg1ONmSud3v2aySEOPwPAHfQ71bi?=
 =?us-ascii?Q?s95Xmcpwt8Z3y3RxAk2RBhf2ze5Wg9w9cCg1OljD6GEr+cxfV/W4fVTklFds?=
 =?us-ascii?Q?umCfOD/R/L+GYuYGUszUwJ4cQDQ+ZWVIHqFPJKW7OdJyRip7j+zbEtmOsIPQ?=
 =?us-ascii?Q?TXV1gQ08eVYr2faTRreXpioe1CMQSRFNEVI52vRqf6kdsy68taMLQ1BNL0UF?=
 =?us-ascii?Q?jZYGNhdmOKZXh4JoKZ8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9095ffb-751f-4388-9caa-08dc6eaa04b5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:26:08.4157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1JrzqcAbF+FxRoLA4xhMso082vdF2G+mQYc/pK99ZmMUJCC5FC4Rs/Km9lAsSqpq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595

--=_MailMate_2805D75D-ACDA-49E1-81EF-2AEBB181642D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 1 May 2024, at 0:26, Lance Yang wrote:

> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
> folios, start the pagewalk first, then call split_huge_pmd_address()
> to split the folio.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/huge_mm.h | 20 ++++++++++++++++++++
>  mm/huge_memory.c        | 42 +++++++++++++++++++++--------------------=

>  mm/rmap.c               | 24 +++++++++++++++++------
>  3 files changed, 60 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c8d3ec116e29..38c4b5537715 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -409,6 +409,20 @@ static inline bool thp_migration_supported(void)
>  	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
>  }
>
> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddress,
> +			   pmd_t *pmd, bool freeze, struct folio *folio);
> +
> +static inline void align_huge_pmd_range(struct vm_area_struct *vma,
> +					unsigned long *start,
> +					unsigned long *end)
> +{
> +	*start =3D ALIGN(*start, HPAGE_PMD_SIZE);
> +	*end =3D ALIGN_DOWN(*end, HPAGE_PMD_SIZE);
> +
> +	VM_WARN_ON_ONCE(vma->vm_start > *start);
> +	VM_WARN_ON_ONCE(vma->vm_end < *end);
> +}
> +
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  static inline bool folio_test_pmd_mappable(struct folio *folio)
> @@ -471,6 +485,12 @@ static inline void __split_huge_pmd(struct vm_area=
_struct *vma, pmd_t *pmd,
>  		unsigned long address, bool freeze, struct folio *folio) {}
>  static inline void split_huge_pmd_address(struct vm_area_struct *vma,
>  		unsigned long address, bool freeze, struct folio *folio) {}
> +static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
> +					 unsigned long address, pmd_t *pmd,
> +					 bool freeze, struct folio *folio) {}
> +static inline void align_huge_pmd_range(struct vm_area_struct *vma,
> +					unsigned long *start,
> +					unsigned long *end) {}
>
>  #define split_huge_pud(__vma, __pmd, __address)	\
>  	do { } while (0)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8261b5669397..145505a1dd05 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2584,6 +2584,27 @@ static void __split_huge_pmd_locked(struct vm_ar=
ea_struct *vma, pmd_t *pmd,
>  	pmd_populate(mm, pmd, pgtable);
>  }
>
> +void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddress,
> +			   pmd_t *pmd, bool freeze, struct folio *folio)
> +{
> +	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
> +	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
> +	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> +	VM_BUG_ON(freeze && !folio);
> +
> +	/*
> +	 * When the caller requests to set up a migration entry, we
> +	 * require a folio to check the PMD against. Otherwise, there
> +	 * is a risk of replacing the wrong folio.
> +	 */
> +	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> +	    is_pmd_migration_entry(*pmd)) {
> +		if (folio && folio !=3D pmd_folio(*pmd))
> +			return;
> +		__split_huge_pmd_locked(vma, pmd, address, freeze);
> +	}
> +}
> +
>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  		unsigned long address, bool freeze, struct folio *folio)
>  {
> @@ -2595,26 +2616,7 @@ void __split_huge_pmd(struct vm_area_struct *vma=
, pmd_t *pmd,
>  				(address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE);
>  	mmu_notifier_invalidate_range_start(&range);
>  	ptl =3D pmd_lock(vma->vm_mm, pmd);
> -
> -	/*
> -	 * If caller asks to setup a migration entry, we need a folio to chec=
k
> -	 * pmd against. Otherwise we can end up replacing wrong folio.
> -	 */
> -	VM_BUG_ON(freeze && !folio);
> -	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> -
> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> -	    is_pmd_migration_entry(*pmd)) {
> -		/*
> -		 * It's safe to call pmd_page when folio is set because it's
> -		 * guaranteed that pmd is present.
> -		 */
> -		if (folio && folio !=3D pmd_folio(*pmd))
> -			goto out;
> -		__split_huge_pmd_locked(vma, pmd, range.start, freeze);
> -	}
> -
> -out:
> +	split_huge_pmd_locked(vma, range.start, pmd, freeze, folio);
>  	spin_unlock(ptl);
>  	mmu_notifier_invalidate_range_end(&range);
>  }
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 7e2575d669a9..432601154583 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1636,9 +1636,6 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
>  	if (flags & TTU_SYNC)
>  		pvmw.flags =3D PVMW_SYNC;
>
> -	if (flags & TTU_SPLIT_HUGE_PMD)
> -		split_huge_pmd_address(vma, address, false, folio);
> -
>  	/*
>  	 * For THP, we have to assume the worse case ie pmd for invalidation.=

>  	 * For hugetlb, it could be much worse if we need to do pud
> @@ -1650,6 +1647,8 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
>  	range.end =3D vma_address_end(&pvmw);
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
>  				address, range.end);
> +	if (flags & TTU_SPLIT_HUGE_PMD)
> +		align_huge_pmd_range(vma, &range.start, &range.end);
>  	if (folio_test_hugetlb(folio)) {
>  		/*
>  		 * If sharing is possible, start and end will be adjusted
> @@ -1664,9 +1663,6 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
>  	mmu_notifier_invalidate_range_start(&range);
>
>  	while (page_vma_mapped_walk(&pvmw)) {
> -		/* Unexpected PMD-mapped THP? */
> -		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> -
>  		/*
>  		 * If the folio is in an mlock()d vma, we must not swap it out.
>  		 */
> @@ -1678,6 +1674,22 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
>  			goto walk_done_err;
>  		}
>
> +		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> +			/*
> +			 * We temporarily have to drop the PTL and start once
> +			 * again from that now-PTE-mapped page table.
> +			 */
> +			split_huge_pmd_locked(vma, range.start, pvmw.pmd, false,
> +					      folio);

Just in case you might miss here, since you will no longer align
range.start as Baolin mentioned in another email and you have a VM_WARN_O=
NCE
in split_huge_pmd_locked(), you will need to align the input address now.=


> +			pvmw.pmd =3D NULL;
> +			spin_unlock(pvmw.ptl);
> +			flags &=3D ~TTU_SPLIT_HUGE_PMD;
> +			continue;
> +		}
> +
> +		/* Unexpected PMD-mapped THP? */
> +		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> +
>  		pfn =3D pte_pfn(ptep_get(pvmw.pte));
>  		subpage =3D folio_page(folio, pfn - folio_pfn(folio));
>  		address =3D pvmw.address;
> -- =

> 2.33.1


--
Best Regards,
Yan, Zi

--=_MailMate_2805D75D-ACDA-49E1-81EF-2AEBB181642D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmY6SA0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUNP4P/iuU/57f/K5ESgOe5C5TbjOuMOJgjKNUDI2b
Q5EW7Ms+Ssjxb+lKgx1mTOxpYLOBlCkv1sKjxNk/1iofnAwRauImCcKXw6IOFomJ
IK00zmEETSEKHLtBqIDAVT/ucLXC5ikQwhVMGGf/LC02nNW1ixMF20uhAy4ArNy4
OfDrK4Mq3+GpHA8Irgm5kAJxkQEg7SxMll/Lchiim+Kl8IDAHzweZK4DAzUPy5J6
OBixB5/ulbrF25pSwrqehOgaPMl10T4C6R+mygjHewKNVqbCdzxiUD1mL0oxnwT0
R+yJCLbFbaXd8RokdPrPjnu0oGil5KUHObXqYRnSx6LDs/tmhBw+S/XojPQjTTSu
AZRXofGscP29hSphWiDxwHDX/bTwbn4vK0WfTwIN+BGIP0rjJB5Rg8AyrnO9E/63
b2xaN5PDhshJdmIA+6UwnwwT8EIGdkQKD/PJPNxmoDRZm69zj65FUn3mvsRiuOB4
RgX/HJWyKY/0kJwN7mWHNPTfoc3w+plQiIL0xs009Z+Yt+xiAwIooHpjIgrJFobT
pVFiucG1onxBy9CJnHKui7YvhcUUpBkJukgqEj1xtD7DKo8rPIb3kNckv9GDm+kk
LYyjQueAtHN6LGOhJk6D7R3cWHU3XFREPVL0pUmCGyHcjWmhdih82huk/GH6LHFo
nXoJ6lT6
=xOep
-----END PGP SIGNATURE-----

--=_MailMate_2805D75D-ACDA-49E1-81EF-2AEBB181642D_=--

