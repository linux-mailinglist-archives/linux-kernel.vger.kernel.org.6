Return-Path: <linux-kernel+bounces-223801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CA0911847
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25BA283457
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EF982891;
	Fri, 21 Jun 2024 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kd5Kz+QZ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FA259C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935566; cv=fail; b=L3AIejVmp/EbDcNnnQfy9SYieNNeneMKZqj6W8jd2U5YtgjrTghJ+GYof2P6ZyLAxL4E1900Cos5TLJs6rJKPVbkdLuwtLWcIIBl7LAkeD+xIuStdYpyWQ0BeMvJOkwjlS++8SkhtfzBP9KOxRjBo/+68vhD62J+nFhE8IXsKmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935566; c=relaxed/simple;
	bh=M0ofR+QY16KHhjm1mk09UP6wKs0LGJVSEQYFOBMyQg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TuDGo3tqRRJID0b6m2W6T4mbIVhYNjRK01tKpnUjKMttT6IPvoE8vEvX+cKL86D5Su4CtUaw7SjC+hZb8z0V4xt2w7CiptknR+BtXQBwGaSYL15N5Kr+yZhsPX6F79TI3qX8qv/YFlB8hvnwuS9iPSXStfhmK1SwW+I1EN1rMgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kd5Kz+QZ; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPhbmMXHGf96WKVzb+neoTMs5Un003vl+SnSnA6nwUMwfSOrNmtFsyquDp+rcpVSmLTCp1BM6+h4aI03jV42Hi4/X0jcQTLzyJVJx4r0cDat4tfCj5duIfcRPcN6dXAm52Ees69uMvmMJLRWdf5cu8b/C8f4vEDchKVrf1FfAoTooNE10Xg6ePh773VQusQp4LQaif79loQ6p2587mB7xIuwXedHF5kIm/teRcVf/05e9635KGyHEQAFFKUVT67V+aeCrXmcngYi7AdUiwlt80JJARFqioyw2EuJC1+a66P2idlzCr76PpR2pIOeq+BVbgxTET0BAIavGDVtM11OoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x7knhTaALDjAFgBHMXMpIlvxRJefgFZIQM5xbMfbd0=;
 b=mB8b2DLgWPyRTWaoaUsELteKUiUQ+kHs9y0QVPdAjXl80Gifn8Y4Ud6RYV6mhSPMe6tkp08hQ3hx3LhhjRUK6LAGAoaWjOWuaktoHeeurTtp2YElGI8F18kZYe2XZRyOVeMT/rCCkHJK/ohXMBcckqz4UgXmhiNrwY6bzHBQwURPVZo4e7GEFQl1isfjhTYVvX/ZzZsl+W0RA5+LHHnp8GTdShkPOrfVFQYRYfMXypIBOcicl3vKWnufwEwiCyDfv+5SRqxZj2oAFu3UI2v63HzYKY+OQ7smb3MA/f0XuvJWaxeq8KJpQNnoHHrDv/yWVpjq+CX5Jo8sWyvnf/ZPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x7knhTaALDjAFgBHMXMpIlvxRJefgFZIQM5xbMfbd0=;
 b=kd5Kz+QZXwbGDGxxI/f468P1xWGEtGALTMGI9xKBr3w57vJpIeO0OBuUzu0cjblKqLmPtix/9vIr9r44+dOQV9jRlKDiMN6n6oJfUZGlt1KZ7L9jwQDZZqfdKmwWpcAoXEOOl3Kooos1YUbcBGe/F6CEtZ7OH3BKF9V8IvdRc/G82NYi57bDdICOLTLNwzH2noeqMG/6Vpo2vrRl66TWamygHd52e+43KAvT5jR6dIqVgNKBLYwLcMhbLnZkm3QlGNs/e2vi67xXcjsl/x8wihceFlbbxIj0I3OJOKFAv0oq6myEL17ZMlIj/+nw0pzc9xAxVYMu5ZaKtIvDOjVnDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Fri, 21 Jun 2024 02:06:01 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 02:06:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
Date: Thu, 20 Jun 2024 22:05:58 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <3F1DAB9F-2CC0-4FED-AD5E-D013E19EB998@nvidia.com>
In-Reply-To: <20240620212935.656243-3-david@redhat.com>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_01B41109-07BC-4C2F-9D7E-B69758F3C4F9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:208:236::20) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: 17743254-2ecd-45f8-ec71-08dc9196b2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o6cHAzRN7pX0Rok2pgoZH3+eJ/Dr78juxHvwUsCSwBTXpxrLzl5n9r6d9icq?=
 =?us-ascii?Q?QJJ2VMT8Vovf5rroOoPdXLZwEsCTVOxeGyKiGuQKjunhqo27+BkH5kMCCnSu?=
 =?us-ascii?Q?hJjKVxSxjX2Tn2zMdVlDWx3WuCiKOxAJSMWPS5qNAWs0Puyfk7ppRBdGGBRY?=
 =?us-ascii?Q?SsCWGc4cw9Rx7yKzl0/5sgtd1xSdCDZeN2u17Qnyumc3XwZqk7RQ36cJbfxL?=
 =?us-ascii?Q?AyxBPb4DI0GCAv+YJkLWLa180XyraOA2HOJm6s5kKTibf6elNi49E+g2fqgJ?=
 =?us-ascii?Q?AwnNEiAAxZy49/j9eCwQNFaCjrxV8Q8CTN26+ZorMk1vZbegP8NNPkmv1Pi1?=
 =?us-ascii?Q?U9b795e+dOZ+g9E7zv57XP3dE5Obl09jE+9SzZpn7HI1Z9rLt/qa9R4vuGnr?=
 =?us-ascii?Q?Xbd1IaQYPNLYoRdjYrK8p0d3qOCG2RhX1yhHqB9T2T+5ayUehKwmb47+pDhV?=
 =?us-ascii?Q?x1bhJWOMTVai6Tg00ThEv6kyG8cSP3ZZyLE7ZWLJZrdffmz5S63M8NJkTXNT?=
 =?us-ascii?Q?xfjHs4VjA4zt6c+W9WSiKFH2a7x4pYvXL5HMb4MGKh4BpPvPhKoP76umps3P?=
 =?us-ascii?Q?I0LTDYd8WsroViUsXM0/zto0VRs+b/NxVV1zaaJrZvgHWCBJFyswHk1S12ba?=
 =?us-ascii?Q?WdXtnfCjpqavDhobbxiurxCTsu9aCIX4zl05ENJAJqdyjyQMCWFxHl2pBFPM?=
 =?us-ascii?Q?eE6t/Ir6tavdXubJ6N4bMKaSWn6lDW6n+tjl3GbHU2roBy44nF5Yce+TdFlm?=
 =?us-ascii?Q?Mfz+ZQGyqzqTIPXOJ2QCVzh2k3iYJ1MvuHafXQnyd3EzE1DKVGnSloVzbIGq?=
 =?us-ascii?Q?bIYDxccv/zfq/u3zL57wGSdLfaCODazjD9Gi693TsaURmZEunTwbYn1/mtn3?=
 =?us-ascii?Q?D7K5DmkaggvpRh6wQbdJf4KFYbVDboCzHhL06YMzkrDye9WU7ifQRbNNyTTq?=
 =?us-ascii?Q?H/7n2sz45Sw4WqynI7NYVh+8Z774m7Yzke9fTcI1b5kRvoZPMAnERpI3nrwD?=
 =?us-ascii?Q?HPcrZZmKkEujlj8k7GEYu6y3qt1tiVea/v5+9as8w5trFODK98sGtl/hy2/x?=
 =?us-ascii?Q?zmVtuRsQ8cmiAkez4n4n0bPicenMpImc2Tlwf8Bbx7nA+cwc69jMiS4L5FP2?=
 =?us-ascii?Q?ZBnIh7XYgLonrt1mbS5Ztdlf0xAE1ub0F0onQiDm+DMxh4CV0yB8Qrx3pDK6?=
 =?us-ascii?Q?0lNyYpswxtoT/K+sAQfvG1Qk7X1fkjgYdIA/3MBdmpIIT1pzq59P+XPxq3Ri?=
 =?us-ascii?Q?TTbIhOsUdLrwaVZ58A/cG8YHblVMiiX0JR9fz2O4urSeZAL7Vy1f0Exd3b8+?=
 =?us-ascii?Q?phe3VBkvx86s6nAN3EQiBP2F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Luq2+vRfzU8LHgSTwkQclovQz9ju2iD9oljNOGRJuEIzN1nlvI6D+bZfIPtF?=
 =?us-ascii?Q?LY+U3nBvOzxH95Vodr6evwDyxqji6hibxvXRwJSbPFtvXQJ1um9mspFOa0MH?=
 =?us-ascii?Q?ErfQkpzNGdIEHumRJpIs7B2rxHOqh2EeVxejwRNA88HVitS+tS4bRm6fJV22?=
 =?us-ascii?Q?Z0OOhGIhp3hmecy0P6JRHUzB3ImS2d9349qjlZI3S8feFNZ70kIcfSijNS2H?=
 =?us-ascii?Q?kS5PDPvy5qWPFRhzULzcoH1JtMnCb97H5QV2nO7FUvpJYg56XDyEwK8osdCA?=
 =?us-ascii?Q?P/Cc2mLn2p/J9xm/rzg/KtsGq/L025Y89KqIEcb1f2vMD75ebEWrp+edWD3n?=
 =?us-ascii?Q?d60sdRxQPtvpnzqmT1+LD3aS3FXKZmU7g412xRqt9MuocxnLQ1wjufj2rqEN?=
 =?us-ascii?Q?oEee50FXvbirjK9hK9fOlOk2GVyQsBIE+3LgqBdrp6e3Oq9Z+2zESk+o36t4?=
 =?us-ascii?Q?0UW0VFKOfzsI1CeRBK1zaUWt/3yiISE7R9+jl8BpKvk3/AYGGQR1JPD88AiR?=
 =?us-ascii?Q?utHwXWDQgQoIUZCD5nxgKM7Hti4kayJYG3XKqnUI2Y3wCwjmrwvv2CAajZll?=
 =?us-ascii?Q?8JfPIod9gQmlS+c0daxYQenQxFt9+d4u2Tz+ZMyIDNMbkz4hcGfcYM6zOmGy?=
 =?us-ascii?Q?j9IU+guTsg7Ra8/zc5eFxiWqw6C2urfVOtT1hATSVdolMogJX1uycFJFOGSp?=
 =?us-ascii?Q?yGjypySgyLz6sz58XGVsa5/F0BRs2IvM45RnaLqQlhacW0Z5y17/g25jSLlU?=
 =?us-ascii?Q?SHw4qBKx1/avSVbLH7MnGDQYTx80nejL+EJt0Kr/HGpNOQEipFhilM7/Amri?=
 =?us-ascii?Q?GBMB7vWYIdIdRhl/RTlHPzs+nwCiZDSnRqg1a0ARQvJJbZNNYeCBEqydvMSk?=
 =?us-ascii?Q?C+ZT++u4nG4Ug26B4AEMcTp8QGIBiIQ2mpCsJAFm+4MivgbGF1mqJPMxOh5j?=
 =?us-ascii?Q?e/kGO3NIem61bowxFUdMferCbISQW5YwOOu0v/zvGBys8FU+vTBNqEIE0+Ia?=
 =?us-ascii?Q?vcFQKQr7OxmMeoshPqf8v2pghnQgj0hnWHv4pxZPsINQI8ZC8umexxDG7xwI?=
 =?us-ascii?Q?5n88SvD+RkOYKEpENVwBZcQFp8A1D/DrH7lXToYjODff8hINd26bnHLyfmUL?=
 =?us-ascii?Q?Qb7/QPLygiT97sH380MM/kNuskclkFEMC797EUdsxxWfUhDJLkJ6GHtq1C5L?=
 =?us-ascii?Q?YdC92gu6Qgk2ntQLn9s1p6m+ybHoFQnv5o8WOZj/+NTCpv9baOr3m9c9EoV5?=
 =?us-ascii?Q?36ydbO30SSYYh1R1dfWlMS6t59aslaIQMe+GS419fwdy59P2vPPX9aI9+NNy?=
 =?us-ascii?Q?ZqUwIXEBwHd8PunQsRFNcUMdqJkORZPGMMJaUOHh/puOPEemdpMBtDyttn+x?=
 =?us-ascii?Q?q/MiebWw4JWnHA5VI2MTbhaOxQbk7wrJCVNERs5Ehu8SOUjV+Dw1xQD2Qt5e?=
 =?us-ascii?Q?VyUDEc+y8Dq0L5J1op+LtNpiOOh7uYGF6Y/JfhOzfAL7kDbOv+mXK2gMvZa8?=
 =?us-ascii?Q?ChxoJucP5zuTPB6aQXe6Hm4WGsOlcHIOPjvFN62lGhrv1i3ll+Fxtb+z8u/d?=
 =?us-ascii?Q?ndtrSdbuA0FST8eMahEfGEXzs4E2+T+6o63hWCLG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17743254-2ecd-45f8-ec71-08dc9196b2a1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 02:06:00.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnwwlL/yP9TDpdGG5Y2pkyxC7poW0tk27H9Oku2KyTQB0cdoQvBiDjiIlul1xHVb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229

--=_MailMate_01B41109-07BC-4C2F-9D7E-B69758F3C4F9_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 Jun 2024, at 17:29, David Hildenbrand wrote:

> Currently we always take a folio reference even if migration will not
> even be tried or isolation failed, requiring us to grab+drop an additio=
nal
> reference.
>
> Further, we end up calling folio_likely_mapped_shared() while the folio=

> might have already been unmapped, because after we dropped the PTL, tha=
t
> can easily happen. We want to stop touching mapcounts and friends from
> such context, and only call folio_likely_mapped_shared() while the foli=
o
> is still mapped: mapcount information is pretty much stale and unreliab=
le
> otherwise.
>
> So let's move checks into numamigrate_isolate_folio(), rename that
> function to migrate_misplaced_folio_prepare(), and call that function
> from callsites where we call migrate_misplaced_folio(), but still with
> the PTL held.
>
> We can now stop taking temporary folio references, and really only take=

> a reference if folio isolation succeeded. Doing the
> folio_likely_mapped_shared() + golio isolation under PT lock is now sim=
ilar
> to how we handle MADV_PAGEOUT.
>
> While at it, combine the folio_is_file_lru() checks.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/migrate.h |  7 ++++
>  mm/huge_memory.c        |  8 ++--
>  mm/memory.c             |  9 +++--
>  mm/migrate.c            | 81 +++++++++++++++++++----------------------=

>  4 files changed, 55 insertions(+), 50 deletions(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index f9d92482d117..644be30b69c8 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -139,9 +139,16 @@ const struct movable_operations *page_movable_ops(=
struct page *page)
>  }
>
>  #ifdef CONFIG_NUMA_BALANCING
> +int migrate_misplaced_folio_prepare(struct folio *folio,
> +		struct vm_area_struct *vma, int node);
>  int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct=
 *vma,
>  			   int node);
>  #else
> +static inline int migrate_misplaced_folio_prepare(struct folio *folio,=

> +		struct vm_area_struct *vma, int node)
> +{
> +	return -EAGAIN; /* can't migrate now */
> +}
>  static inline int migrate_misplaced_folio(struct folio *folio,
>  					 struct vm_area_struct *vma, int node)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fc27dabcd8e3..4b2817bb2c7d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_faul=
t *vmf)
>  	if (node_is_toptier(nid))
>  		last_cpupid =3D folio_last_cpupid(folio);
>  	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags);
> -	if (target_nid =3D=3D NUMA_NO_NODE) {
> -		folio_put(folio);
> +	if (target_nid =3D=3D NUMA_NO_NODE)
> +		goto out_map;
> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> +		flags |=3D TNF_MIGRATE_FAIL;
>  		goto out_map;
>  	}
> -
> +	/* The folio is isolated and isolation code holds a folio reference. =
*/
>  	spin_unlock(vmf->ptl);
>  	writable =3D false;
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 118660de5bcc..4fd1ecfced4d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5207,8 +5207,6 @@ int numa_migrate_prep(struct folio *folio, struct=
 vm_fault *vmf,
>  {
>  	struct vm_area_struct *vma =3D vmf->vma;
>
> -	folio_get(folio);
> -
>  	/* Record the current PID acceesing VMA */
>  	vma_set_access_pid_bit(vma);

Without taking a reference here, is it safe to call mpol_misplaced() on t=
he folio
at the return? Can this folio be freed?

--
Best Regards,
Yan, Zi

--=_MailMate_01B41109-07BC-4C2F-9D7E-B69758F3C4F9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ04AcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUg4IP/jXkzt+yf6fSPMQ3rDu/9GgAgSfZBJIaDMA7
5ETes+tLWPyL52yFtxYCM5Csha5gP0KEggt79KvgxDKqMDSKb4f1qA6AG53RD7s0
PCYZNlUg909A12hf3MNtAbVC7tCK7m56uQcMW785M23uf5xs2tblER4ZdM5haCJs
3IqU0ahrSTiSQ6OHSOMJ0uC4ofVDj8atLHhzmZ2Mt9lFb1oKHeOeyByG1CPczluJ
MUpE1KQa7CmvvbFd1wUQc0EbL6ncoJBJZ6XDhklJxgON1FcJKJOenSv4mv3Jez0H
ulLFMmTow5sKet55jJGM0LbzzZXKuBedJcS85yH0iZDpulezqoNlh7jZH3PIqEkt
OmcSZaQmGjrlGyxn1ywI5BQbLYtoP3m4Eq8vQd2qzzI20MglPzMV0lQx6gVAc1Y3
9CN6vAD3s+bY5WzuUv0w1vwXAQZrG5m8RoEAcAMq6G3kyT8a7yil4FYt//wGZs+P
RCJeiqOkm7aaEi7NNzwVZpVO6ipcEgg+0JWBFl5uw/6G/i+C3Q1o2RcnLR7TVCIi
Ucx+/noFnAvdlaYZt9tlSfF8F03OZUcysdmA9OMtYQ3lUyNDNgL4y5omEZt2qgsn
WLPsOm8ayxGjoU9JCUVSldYbiTblZ2PE3ShAFj7UaXgOvthb3OsYV7GBXwP/Wwar
J3oauwYj
=Pni6
-----END PGP SIGNATURE-----

--=_MailMate_01B41109-07BC-4C2F-9D7E-B69758F3C4F9_=--

