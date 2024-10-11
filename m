Return-Path: <linux-kernel+bounces-361654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E4699AAF6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE5A1C22391
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09751C68BF;
	Fri, 11 Oct 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G5qw+Ppl"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232621A08BC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671045; cv=fail; b=YzjDNx0YZVN/CFthz6USoJDS73NslWNWP3T8fcvf1wR3ygR2AcR1IR6GnznKISz4SgTwmcZbChhoglNapaJoYCrpDO8FJtNTl9fwVlbEVUbZBx1EJIv8TzwEOJYanYH8KpK2USH0PTtxDXODMOTyCyXqhFBBEFCcciLrzbzVXb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671045; c=relaxed/simple;
	bh=UrQsbPIEtdWE0jlyn4j9dkjDNiHqv5amG2Q4ES50RP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rgBmbXGdpL4qFS2FOURrldyxz0rgMyZ8XoymZZQ2+/T8eQybkvMvNmJB48aApPHq+d6vekFdE5DZGlsaf84yL4nRVEJDC1xA3AR4977jwsOl7kL0VjqaFVlLU3Gw0lYrkIB6vV4rbII+fuTFaRbPFUXdGJh18vH1tqtDcV05j6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G5qw+Ppl; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9Lvfi7dfPe/JFtGSUwnSKW3VnNnCkMaV2EsQagrMEaH3r06U6YnIk+7Lha2ubFMbdpsMJ3fm0mDaceVod4L3aRMO+UUyibkNwfZKIxeYuu6n3T/uDEbJU7xHgnHq6+z/7kt4s9j+FPogc2MCvEyq6TPxHoyP3frXUmovUlAAjtRWMoWKMDm9ZEMJWMX4NoqbmtMqNn+QLR25leACZyoGDUbdwRjuF94YtzIkd6GFjznXlT+p/S6KtBoWM0Oyp2q44bKxqbFCeRhMKMFT1Ohnb1dEoOu1QOymCerpSVJH4JlgWDcSsarUUEKW5PmA4TNz/Bke5IbNfJs8DjKTV9kJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EU/jkAycfgeEQSRK5vEa+AyqtMIo4MiiHMf2LaSIzSY=;
 b=EQMrnWC8FDsLs/+paJdxwzJc04S5ZmXdUgc02mlmJk6GDsPdO8UGFB4ywd0jgJoABz693WiLdLwWTJPQH1QijwOnJ5Au7AGwufqSTkFxbvKo+OLa5Gg72hLJPujiLvKNkD6AV+zn/N1KYR5/IuaI/CbQBX0Pp1GgkXFvfXGpeWXYqb5cOw+btQJU7I0vy+q4rnQ7j0EsN63LzrotNRbk4AJhJvr62QomLYmfYRS8hv6VN8731nQ+dO0Z0Ja8HkWxDr+kGfNIzDt3PHZIv3ZmnD6WKLg7Rf9Grx4mAj53XwxdRZ41F4Nai5DJ+vsD04kv1Tp6baY9Ss9u/hbbCWHc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU/jkAycfgeEQSRK5vEa+AyqtMIo4MiiHMf2LaSIzSY=;
 b=G5qw+Pplhc1ytN7lYeDFS3MM2/90akG2rdCwOk5M8fMI87a3Jdn7OeJbvO83scha6LR4vK7CV2yTKasK0lmY/sgK4xoK0wa03am460Lv1ZI1XMPl/yOvdouidiH/ElJ7wjVKKSitpzF5mZn8F8GNkJXzGfEoEV74hBVq+drinzB6ztphdckWq3Oa7mvErTX0IiSYNl3Y+qarRwu357bySHH8JZ+UmaP3fSpaNR/UJMPgkGEOxtvtF7IalWQell7E1S6FuiHIZZLIdjE34LcgXOKmBu7j7x7NqBMN4ZAOdQj64IM8fMb4Opvpo3jGeXRIUmGiUL23U0Ukour0/sdoCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 18:23:59 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 18:23:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid zeroing user movable page twice with
 init_on_alloc=1
Date: Fri, 11 Oct 2024 14:23:56 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <9ED14870-39CF-40CA-875F-3A7FDE4D7DF3@nvidia.com>
In-Reply-To: <20241011150304.709590-1-ziy@nvidia.com>
References: <20241011150304.709590-1-ziy@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_27848405-103B-4C66-8A2B-4F426B37F132_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c96913-d69f-4588-4753-08dcea21dfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oiD3mFb/7Gm3wV5KGSm6r5nxQiOVDqRWzwMVI7VQN+plo7jN5WIdk5PjHDjm?=
 =?us-ascii?Q?IrsXQHPo0AdCjOJZjNf5bLrfNo80ZLy6xeQLMzu1gOVifi5fu6/qHYePy+Ku?=
 =?us-ascii?Q?Zcmq5tYOsffG3Yn2xcD2GwOwjHV6vIajexiKxEGj4XRiHgTRnZgJSqHoDUGU?=
 =?us-ascii?Q?qjTZlaSsX7Jc8awNanoh+uoIoKtci1BbWlJuyCU0AUah3SZfHxkiSVMRMXzT?=
 =?us-ascii?Q?kp9i3F7ywI1kdDMWZ3iJaBSEfRQMGeDw0ISIhzFUTi6urliOWSYbro8sAK4n?=
 =?us-ascii?Q?/crWrpzcxoSSqN3RhEOszUI0zhqvbUD+680XrOi6VxkWEfuYCj27W3txvfZt?=
 =?us-ascii?Q?9w5SBs/6DqCYuxoS9AwjhAKOPGk0x4g4DHXvciW2qD2TKNIkPuSjAjq2v8cC?=
 =?us-ascii?Q?LWUTjL3JZ6adS4qzHPS05E6qARJ04pm7YxBZM4rQZnP3KwW40D9HGGkUEP0E?=
 =?us-ascii?Q?T1hWAC/BRXOR09H/SYQREDYBVyFrrBNLTXDybhvzH17vCZsIvUwh3QsnoEBv?=
 =?us-ascii?Q?bnlsBFnitG/3BQS/8blYuHz4+zZwfe+HKC8qudjEULSew+aLE7RxkIOZq+q2?=
 =?us-ascii?Q?y6MBOH6D1+kckbUKMKJLbycYfeV+Xift7esmHKr9fOeo3Um2w7IakrkmKVPa?=
 =?us-ascii?Q?HU2rjFV2W1qvw9TYDc4qDiIQh1YrWh+dHHRC9Oyt6271XEispTsiy/AiqHX7?=
 =?us-ascii?Q?8LxO+JNpO3jZ6j2OxeWBdWdHdAHbp54SXb0zICGMYUZtpYLn/TfS76aLFpBC?=
 =?us-ascii?Q?zR+JV8sJ0rPR790CQR0q8gOoXLtWCpdkTByw9GcVT2DjWDEaopIwSZ3N39gy?=
 =?us-ascii?Q?bnc5l3IYm+oH9oK+fhGRzkNVWuDDaG5atQbGv9KvSZJvtEUIy3soaMKY4sRg?=
 =?us-ascii?Q?5xZFrbllbxC0kAKTRULQseH/nQ48zjQceycM4bFe9r2oVCzXJhSteN+yxTqF?=
 =?us-ascii?Q?B54UWkVdcSgNF3InEkgBNzjWf5TdGgLU5/gv2p4m4Y05V3WBGq3+HBzAJgyp?=
 =?us-ascii?Q?ghLlBGnrMytuW+IVlTEypIU/EpOFigNI0qf2QZqrXxrRagz96Da9fKEEUc+W?=
 =?us-ascii?Q?b+BcGSvKHNYN7j8g1oCcAN0xk9aoNrghrB/8kDsNXDvQFzkkWJLuPuGAbhwa?=
 =?us-ascii?Q?CHN7nfj4QpI6BrVwdGz8IxPTED6JsosO8CwEQhl70DCcEOJk4h9X36Q67n+R?=
 =?us-ascii?Q?wI6XiRBJivQfke6noHnvAiNWuDR2Omf/wz8shWZXcBkh9rhLlNv48PTkxuya?=
 =?us-ascii?Q?yYadtOBd1kqmcrgOD/BaYdqfnjkDsdOQaNMXi2iKDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pJ7YHatzagtc9gwgiz3gPch7L6yw6hO+YFgkeK0TSizOz3ADDsYb6bx0fdpM?=
 =?us-ascii?Q?q0maRko6egoGgvOd6X7Lmmyc1bKjDhaePre3mxX9Ke05sNwYLl+zW3mVIZ9a?=
 =?us-ascii?Q?4wvZ5XwCTeGc+AVqj0gJvtFoxdAw2ppqrmmaAveRNSCaA/cC35s12n4ZNAkm?=
 =?us-ascii?Q?9RFYFTpoaD1jrJdrnFiS8Wh9pF0dp8M7xX3FpssxasZeFXXnc4BcE4vGlKPB?=
 =?us-ascii?Q?EMOJgv+NHSE9Q+yUAGegluUOBc5iZg+FO5jwPE0oxM8Hv+FQ4LVP65gIuiQU?=
 =?us-ascii?Q?fd9gjOyKpN1GZpZdvCzQPO99I1HgL6xDFbFxSgP64kYetDqzlRpaf1hkfpzM?=
 =?us-ascii?Q?l6OZDYVGS4aiFmLS4wTIbafGGCHRp4oaycBnMudQduHO/rl+BEi/R0CsF4z8?=
 =?us-ascii?Q?yNuBL2KefXelH7XUscjWZBVPv6F4cQzTFGpZHSwWdh+9kbNvCi94SP9fHe3v?=
 =?us-ascii?Q?IAm/wY+jgcsITKQJ4SQbyx2aGrOOCiRywEoSz5Yala/IpHiGHpU/6FpPIgVF?=
 =?us-ascii?Q?YiehliMYGjBzWyiywblcO1XDrRmx3FcKHsM1ZA0wRsmpC2hLCsOS4w7Ajc0A?=
 =?us-ascii?Q?H4Syd6Xd1UgNgaHLb9IGUt/hgrlIYaMPuJ5tbn+Va3TTiqCW8isZaDu/hedu?=
 =?us-ascii?Q?w4RriN6oE8zsreVrC2ezjPAooKd8hqyfEiTOYdB4rAKeGSEnuJJ1ly0lb2aS?=
 =?us-ascii?Q?mIHYAE3VVMsBAQ286vPVU0grtTJNQaPewsNnQma4tP3BMJPvlh64T48zSzLV?=
 =?us-ascii?Q?ePnFeGDcdaUjVYJvgVdvi38HxWazQLjRTPq/TLE13K931yrOahOs1jbJzP98?=
 =?us-ascii?Q?sNVkPG0GxPywXAK3TvGnV/JA1CU9/2EN+FXz73qkf1qI7echfiXiDK9KS/tD?=
 =?us-ascii?Q?2ZxNLQSWtcnMX4+gQlRD/ZNjRKjcDoQ5IrH2v7I+tzcgZl37E2ijH7hx9J6X?=
 =?us-ascii?Q?Oax4Tk2Tc2/QfKVtTclGwhJY84fH5VFx05QcpWjyktRjonowR9rXx9Iybmwf?=
 =?us-ascii?Q?1OXbZladGVKa8rsUbuggya5+5xHELiS9L4TKA1DzLsmCNXTnhMbIy4kAWnhO?=
 =?us-ascii?Q?AC1fmDdzVd+01KYTjzNvONI7WQjxmwFWIfeX/kBRQy1mf+sTAs9APlCSgy3m?=
 =?us-ascii?Q?Ryn3QPnoEqzxCqDMFSIPIHlYq/J0ZOeyYMWVCV3svRyhbyJuHFrjZkev0RbN?=
 =?us-ascii?Q?SFaGoJXuRzXdF5ZsX+eKFyzRpOn1x3lZ0257mXLs47Jgx7DZSXWPSwRNICUQ?=
 =?us-ascii?Q?C9YZPYQWxTSjmBJ16glszlsRsR97KLOMWbBl6xNiEcocjmp4TqyCrIHpGZYE?=
 =?us-ascii?Q?d/MMD6aORjSyl5rpxnLxu0TRGJSutN4bcpqmDLevMEr8dvqAiNk+Dc6zVrAB?=
 =?us-ascii?Q?NcXbLgKSFRyv9ZJD+JOUtBAnNE+Ad+bWKtOW9Pm8ErkZYrKAnVKQQH91otxr?=
 =?us-ascii?Q?aQKJa6SLEGxqsBX9puk/i3vAkGU0l0l5xjluLTQhg73zck531BVhYmoslfBa?=
 =?us-ascii?Q?UbGaayT7xsExlZuBuJ/rkYgjBvb/x1grtpY3oUvojkPWd0NgGXs3cMh0PlvX?=
 =?us-ascii?Q?djIJGtLofnX6bDIo3kGDLoeBHFypXQ4A6fvMxkCT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c96913-d69f-4588-4753-08dcea21dfe9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 18:23:59.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NVHrHxjHcg3X0J3sIzBOiDYc1mumN1lqrnbTMlXebRrAeoHLnIose6427abjxj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807

--=_MailMate_27848405-103B-4C66-8A2B-4F426B37F132_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

+Vlastimil

On 11 Oct 2024, at 11:03, Zi Yan wrote:

> Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=3D1 and
> init_on_free=3D1 boot options") forces allocated page to be zeroed in
> post_alloc_hook() when init_on_alloc=3D1.
>
> For order-0 folios, if arch does not define
> vma_alloc_zeroed_movable_folio(), the default implementation again zero=
s
> the page return from the buddy allocator. So the page is zeroed twice.
> Fix it by passing __GFP_ZERO instead to avoid double page zeroing.
> At the moment, s390,arm64,x86,alpha,m68k are not impacted since they
> define their own vma_alloc_zeroed_movable_folio().
>
> For >0 order folios (mTHP and PMD THP), folio_zero_user() is called to
> zero the folio again. Fix it by calling folio_zero_user() only if
> init_on_alloc is set. All arch are impacted.
>
> Added alloc_zeroed() helper to encapsulate the init_on_alloc check.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/highmem.h | 8 +-------
>  mm/huge_memory.c        | 3 ++-
>  mm/internal.h           | 6 ++++++
>  mm/memory.c             | 3 ++-
>  4 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index bec9bd715acf..6e452bd8e7e3 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -224,13 +224,7 @@ static inline
>  struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vm=
a,
>  				   unsigned long vaddr)
>  {
> -	struct folio *folio;
> -
> -	folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
> -	if (folio)
> -		clear_user_highpage(&folio->page, vaddr);
> -
> -	return folio;
> +	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vad=
dr);
>  }
>  #endif
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 82f464865570..5dcbea96edb7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1176,7 +1176,8 @@ static struct folio *vma_alloc_anon_folio_pmd(str=
uct vm_area_struct *vma,
>  	}
>  	folio_throttle_swaprate(folio, gfp);
>
> -	folio_zero_user(folio, addr);
> +	if (!alloc_zeroed())
> +		folio_zero_user(folio, addr);
>  	/*
>  	 * The memory barrier inside __folio_mark_uptodate makes sure that
>  	 * folio_zero_user writes become visible before the set_pmd_at()
> diff --git a/mm/internal.h b/mm/internal.h
> index 906da6280c2d..508f7802dd2b 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1233,6 +1233,12 @@ void touch_pud(struct vm_area_struct *vma, unsig=
ned long addr,
>  void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	       pmd_t *pmd, bool write);
>
> +static inline bool alloc_zeroed(void)
> +{
> +	return static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> +			&init_on_alloc);
> +}
> +
>  enum {
>  	/* mark page accessed */
>  	FOLL_TOUCH =3D 1 << 16,
> diff --git a/mm/memory.c b/mm/memory.c
> index c67359ddb61a..88252f0e06d0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4719,7 +4719,8 @@ static struct folio *alloc_anon_folio(struct vm_f=
ault *vmf)
>  				goto next;
>  			}
>  			folio_throttle_swaprate(folio, gfp);
> -			folio_zero_user(folio, vmf->address);
> +			if (!alloc_zeroed())
> +				folio_zero_user(folio, vmf->address);
>  			return folio;
>  		}
>  next:
> -- =

> 2.45.2


Best Regards,
Yan, Zi

--=_MailMate_27848405-103B-4C66-8A2B-4F426B37F132_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcJbTwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKZkUP/3zSK1Ci2gmv+dnbTuxbfyJGfDqr3rTnNods
IlEg9NmYXdKXIYHgB38a2vNrfucN3QTantxzn1JnNtfoaFUrEWIRQ8+5RWxc8zxA
6yO1WhGu24Qqr0ivwwY0bLM0o+BY5MZpi+PuLw5TSNqLjPdTUZSKkDL4RYNVaGAU
ThvUmEsGfP8gDAip0E0WeL95LoWT1rm+4xs5HEG6gCmeXuDSwtZCKpS4q7oA11ev
MFA9okpHlJupKY7FDgg5uC80+0PJIB+m4rjilGBp/1AAzGlY/8v0HPj+YXMJAQun
K31LEu+ZQiDoifCbPY1L80+T4br7lD1hfP2wPfOcLvAwnMH8K0vmRmBVJR3Wbnmp
vcx+HXrQx8y1L9BFmSt2tpwK9IYPnkhr68IgpDrtHsyK+GfwP8p052hn530GXgLQ
39Osg4CBdtBtRoa1DwtwqORJ1zCnANz3DdqfW8JCDlQahOdiV2bv93S8JQ/lC9dK
eqxOW76SKVr0duB+URGUkyKZgedwvE1MD1JgoWHzBXZcLUWrdb7Hd9AH9cLqAR50
1p+JMF7MG8I5ZTZofDtfMOLPkER56Q0KHTbfEp+IeW+hTvFenuGYV8b6Z3vRNNYa
ccwmv59uAKAe4UqUV/n0c1WzF8QUWtYzA1t79UDK9L0mbjwqzmEmz8Rrp/B584zO
IBFPDspO
=50iN
-----END PGP SIGNATURE-----

--=_MailMate_27848405-103B-4C66-8A2B-4F426B37F132_=--

