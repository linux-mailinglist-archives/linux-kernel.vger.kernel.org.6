Return-Path: <linux-kernel+bounces-410778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E33B9CE129
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9930B32682
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2281F1CDA04;
	Fri, 15 Nov 2024 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rCr3i7Al"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E661B85EB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679380; cv=none; b=K1cXkZuYg1Hk+/elqFQgHh+Mn8x7I3f7Se15n3Wo292XD8HHkqRlw+MXoZl5G7EEPnt3OqqozfdsGn3KtkT38vbGc/wJKAFEhO/W1P1bxO8nDiXIG9WdWBuVNWfnk1+VQdQaeRcX9F/VsKTI8rq0XZuRoFRMZ/hyuwaSEo0v4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679380; c=relaxed/simple;
	bh=klOpEr/NIxkUIHd9/oMH45FxD7tTatkfLJz5KZ6+jmU=;
	h=MIME-Version:Content-Type:Date:Message-ID:To:From:Subject:CC:
	 In-Reply-To:References; b=HXhjy8P2/n17O2jG4aSaquABBL5K/zxhbOsHaFegobTX8THNplCrcdWfUhhxnbnJcdS1ELWqMbPrgHZBIcMKW9bbmuxKMCesnvOlFllYBAcjzh4KUWGhtivZR/BBaTIs2SZ6zMy2mOVi7DZsCjRUNE6fNQM4j+PxouUePz9WZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rCr3i7Al; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241115140255euoutp028066c36e38ac1cccc24ce48d07432751~IKTeGxeCv1720817208euoutp02F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:02:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241115140255euoutp028066c36e38ac1cccc24ce48d07432751~IKTeGxeCv1720817208euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731679375;
	bh=IhstviW7ozYf7JTwvetHFmbz8Lit5rg3EcQY2QAqs1w=;
	h=Date:To:From:Subject:CC:In-Reply-To:References:From;
	b=rCr3i7AlkEfVo4N/CsqQXQDMvSxf1oyLzq2a2lYBov9HqLdHM1owknpbwYpPS+yWT
	 8lT4tgihkG0AkYGF0YxmkooH8je6V0o4jZha1pwV3dar5DaN+F2fMkmn1D/VPNBpkn
	 pji3+Fha3sXihWRhOz7D6lsde45xdtrBvaBDYFbU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241115140254eucas1p26d5b668caf97036d9c566aeb50f3d34d~IKTdyo1Qs2794627946eucas1p2I;
	Fri, 15 Nov 2024 14:02:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 70.3A.20409.E8457376; Fri, 15
	Nov 2024 14:02:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241115140254eucas1p2e77d484813d39b8e6c8c0dbd6046f3c4~IKTdZNrZr2804128041eucas1p2B;
	Fri, 15 Nov 2024 14:02:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241115140254eusmtrp1a4e280d0b0facbf4ae7403404586e6b2~IKTdYh0gB1681016810eusmtrp1S;
	Fri, 15 Nov 2024 14:02:54 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-7d-6737548e98c6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.75.19920.E8457376; Fri, 15
	Nov 2024 14:02:54 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241115140253eusmtip203cd16909d13e6003f7adf4ff86c7ffa~IKTc-bMJo1398113981eusmtip2T;
	Fri, 15 Nov 2024 14:02:53 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 15 Nov 2024 14:02:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Nov 2024 15:02:52 +0100
Message-ID: <D5MT3TF12PO7.1A65Y7SMUHI7N@samsung.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	<akpm@linux-foundation.org>, <hughd@google.com>
From: Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH v2 4/5] mm: shmem: add a kernel command line to change
 the default huge policy for tmpfs
CC: <willy@infradead.org>, <david@redhat.com>, <wangkefeng.wang@huawei.com>,
	<21cnbao@gmail.com>, <ryan.roberts@arm.com>, <ioworker0@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <64091a3d5a8c5edb0461fae203cfcf6f302a19ce.1731397290.git.baolin.wang@linux.alibaba.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUwTQRjFM93tdqlps6wQxltq0Qha8YhdomCNqIsx8YhRJBotdl2I0GIr
	njERIiotQa3BY0UFg8qlaIsFPMAURRFCFI+gYqGiKKiAoIhySdma8N/ve/PefJmXwRGyWDgW
	j9buYvRadYwME6O2ij81M1PXKdlAriWA6npPUukF+Rg1eL8CUL8K/iLUp85UlLrcO5d6cScd
	oxz5g0Iq5W4aoBK6GgDV25OOqUbR+RfzAV3CvRfRGZZ4+vDD70Lamu1PWzrNIvrJ2V6ULnEG
	0e2lrzC6yzJxtThCvFDDxETvZvSzQraKo77l5KBxSVP22pJuiw6B6vFG4IFDYh6sLbQLjUCM
	k0Q2gG15GYAffgKY8sCCuVwk0QWgNWGnEeDDiYxfy3nPNQC/NHMYPwx5+u73uAcrgKeTXgpd
	aQnhCSvPfURdjBAB8GrmV4Tn6TCpqFfkuhUl/GD9OS/ePg82m4zDUS8iEiZcKB62Y0P20kqL
	yMWjCS00WUwC1y6EqASQa0jE+PdMhYPHTw7v8iA0sDux2a37wrMnc1CeD8KnhW8FPOd5wOSO
	EJ5DYdOLKiHPo2Hr40IRz+Nh1akUd5aFWTc4N8fBe+84Id/KAphaHcPLi2FdjQPhZSms++7J
	v1YKzbYzblkCjx0hTwA5N6IfbkQ/3Ih+MgCSC3yYeEMsyxjmaJk9CoM61hCvZRXbdLEWMPS5
	qgYe/ywG11p/KOxAgAM7gDgi85LULlWypESj3ref0eu26ONjGIMdjMNRmY/ETzOJIQlWvYvZ
	wTBxjP7/qQD3GHtIMNm7eOWi+hnplo2qZfXG6rDc7rAW07OjA5mihzOkRdik8K+hAw6fxu0h
	l6xNk9va7zgE9cHO+chTe+AN5dZ1wR/VflsinblNCVmbzcqQtSUT2TpK3lr7+fU0VYU8yxwc
	1hDRnZ2XrGhfYFtvexRQxqwJbvQEAuDPzFSO6ZCIWMlgi93RvDstaAXwTX7zrQPRxZZn+to7
	u4OWFuxb+cRp29v/oX1nWaGcnL46vIz036AYVZHCWq9WmmSne2qt0csfyYoaJ6xdUh5YBvar
	Agzn+6pqfmu9r/it+u19M7S/bVO/0rlJ7i1MfC7ZrL6l0UUdqDbrxpHEEqnKXHq9TypDDVHq
	2f6I3qD+B7O4BWbLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7p9IebpBjt/Clt8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktGj/fZ7T4/WMOmwO3x5p5axg9
	ds66y+6xYFOpR8uRt6wem1doeWz6NInd48SM3yweOx9aerzfd5XN4/MmuQCuKD2bovzSklSF
	jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MNytXshS0Kldsa93K
	3sB4RqaLkYNDQsBEYsFX9y5GLg4hgaWMEp8WfWbrYuQEistIbPxylRXCFpb4c62LDaLoI6PE
	hVOHmCCczYwSDz4tAqviFRCUODnzCQuIzSygLbFs4WtmCFtTonX7b3aQbSwCqhJ3ZopAlJtI
	POvuAmsVEUiSuLdnJ1grG1D5vpOb2EFsYYE8ie5N3WC7mAVOMkrMut8EdZ2axP/+iSwQR8xi
	lNix+RMTSIJTIEXiW9MzqCJFiRkTV7JA2LUSn/8+Y5zAKDILya2zkNw6C8mtCxiZVzGKpJYW
	56bnFhvqFSfmFpfmpesl5+duYgTG97ZjPzfvYJz36qPeIUYmDsZDjBIczEoivJdczdOFeFMS
	K6tSi/Lji0pzUosPMZoCPT2RWUo0OR+YYPJK4g3NDEwNTcwsDUwtzYyVxHndLp9PExJITyxJ
	zU5NLUgtgulj4uCUamDqOlR5Xubf/U+bT9my2Ky0Kn2//NXR4/cZqi0uWNdI/V4dnnqb//38
	Y02sAQFLMj/FfLLkLKjI+PChIKea5eGEuVnL5FRv8ar47Def1PIis+3Sp0+3ii/FPk8Su110
	s+6K8TxPy4jqdmFFBjmXpu39Mu8tTffsWPMtz1H3bv9j1umH+/K/2b1Zd6zgkOy9sk03NBew
	ZPEl9k5u/MIS4MhieW5G7gH3+08e17z5/UpuLWv4n9/VLOFe4dH8lxeHHf/+aOuyx00s1/8H
	Cc9eU+pWeqXnZqW9yOxO/3CG+0EPLHaujHk0a8UlTa18cdtVx6zDHwmUxgrc6WZ93DSBq26h
	+BNF9d9i/MvEX+6R+vVDiaU4I9FQi7moOBEAZuVPFHgDAAA=
X-CMS-MailID: 20241115140254eucas1p2e77d484813d39b8e6c8c0dbd6046f3c4
X-Msg-Generator: CA
X-RootMTR: 20241115140254eucas1p2e77d484813d39b8e6c8c0dbd6046f3c4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241115140254eucas1p2e77d484813d39b8e6c8c0dbd6046f3c4
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
	<64091a3d5a8c5edb0461fae203cfcf6f302a19ce.1731397290.git.baolin.wang@linux.alibaba.com>
	<CGME20241115140254eucas1p2e77d484813d39b8e6c8c0dbd6046f3c4@eucas1p2.samsung.com>

On Tue Nov 12, 2024 at 8:45 AM CET, Baolin Wang wrote:
> Now the tmpfs can allow to allocate any sized large folios, and the defau=
lt
> huge policy is still 'never'. Thus adding a new command line to change
> the default huge policy will be helpful to use the large folios for tmpfs=
,
> which is similar to the 'transparent_hugepage_shmem' cmdline for shmem.


I think it would be good to include a summary of why tmpfs is not
enabling large folios by default as the other fs. David has been
pretty good at repeating the reasons over and over and it would be very
valuable to have them included here.

>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  7 ++++++
>  Documentation/admin-guide/mm/transhuge.rst    |  6 +++++
>  mm/shmem.c                                    | 23 ++++++++++++++++++-
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index b48d744d99b0..007e6cfada3e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6943,6 +6943,13 @@
>  			See Documentation/admin-guide/mm/transhuge.rst
>  			for more details.
> =20
> +	transparent_hugepage_tmpfs=3D [KNL]
> +			Format: [always|within_size|advise|never]
> +			Can be used to control the default hugepage allocation policy
> +			for the tmpfs mount.
> +			See Documentation/admin-guide/mm/transhuge.rst
> +			for more details.
> +
>  	trusted.source=3D	[KEYS]
>  			Format: <string>
>  			This parameter identifies the trust source as a backend
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 5034915f4e8e..9ae775eaacbe 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -332,6 +332,12 @@ allocation policy for the internal shmem mount by us=
ing the kernel parameter
>  seven valid policies for shmem (``always``, ``within_size``, ``advise``,
>  ``never``, ``deny``, and ``force``).
> =20
> +Similarly to ``transparent_hugepage_shmem``, you can control the default
> +hugepage allocation policy for the tmpfs mount by using the kernel param=
eter
> +``transparent_hugepage_tmpfs=3D<policy>``, where ``<policy>`` is one of =
the
> +four valid policies for tmpfs (``always``, ``within_size``, ``advise``,
> +``never``). The tmpfs mount default policy is ``never``.
> +
>  In the same manner as ``thp_anon`` controls each supported anonymous THP
>  size, ``thp_shmem`` controls each supported shmem THP size. ``thp_shmem`=
`
>  has the same format as ``thp_anon``, but also supports the policy
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a3203cf8860f..021760e91cea 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -548,6 +548,7 @@ static bool shmem_confirm_swap(struct address_space *=
mapping,
>  /* ifdef here to avoid bloating shmem.o when not necessary */
> =20
>  static int shmem_huge __read_mostly =3D SHMEM_HUGE_NEVER;
> +static int tmpfs_huge __read_mostly =3D SHMEM_HUGE_NEVER;
> =20
>  /**
>   * shmem_mapping_size_orders - Get allowable folio orders for the given =
file size.
> @@ -4780,7 +4781,12 @@ static int shmem_fill_super(struct super_block *sb=
, struct fs_context *fc)
>  	sbinfo->gid =3D ctx->gid;
>  	sbinfo->full_inums =3D ctx->full_inums;
>  	sbinfo->mode =3D ctx->mode;
> -	sbinfo->huge =3D ctx->huge;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (ctx->seen & SHMEM_SEEN_HUGE)
> +		sbinfo->huge =3D ctx->huge;
> +	else
> +		sbinfo->huge =3D tmpfs_huge;
> +#endif
>  	sbinfo->mpol =3D ctx->mpol;
>  	ctx->mpol =3D NULL;
> =20
> @@ -5259,6 +5265,21 @@ static int __init setup_transparent_hugepage_shmem=
(char *str)
>  }
>  __setup("transparent_hugepage_shmem=3D", setup_transparent_hugepage_shme=
m);
> =20
> +static int __init setup_transparent_hugepage_tmpfs(char *str)
> +{
> +	int huge;
> +
> +	huge =3D shmem_parse_huge(str);
> +	if (huge < 0) {
> +		pr_warn("transparent_hugepage_tmpfs=3D cannot parse, ignored\n");
> +		return huge;
> +	}
> +
> +	tmpfs_huge =3D huge;
> +	return 1;
> +}
> +__setup("transparent_hugepage_tmpfs=3D", setup_transparent_hugepage_tmpf=
s);
> +
>  static char str_dup[PAGE_SIZE] __initdata;
>  static int __init setup_thp_shmem(char *str)
>  {


