Return-Path: <linux-kernel+bounces-208233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B539022AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C85D1F21D18
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DC1824A3;
	Mon, 10 Jun 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CFbXnNlD"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D174048
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026082; cv=none; b=cYyIFNM5nuouTQEnKmss0mQTMxJw8UQFhRT3hBhu9h70jGX6qC+NmVYR0ZRsDCZpGwr5CtnchNBw63e72thIHQOffnWjefgOxeVEB0KGsLmJivtXPXDWGI5YlK9xf2S61O6aSbl4dWT+8eZUZqqBga/5VIIcfNFwX3DUS8+ffXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026082; c=relaxed/simple;
	bh=BLLcJ18hQRHi1YVb2W/k+PC570DXWwKLz5pNX/OhYnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=kcLIbvSiRr4GZs+MQoXIcSbp7ox1VCMAY/yLFce6IhDDpIsq9T+1cIqjzFYAv6rXOrqXTI64YLOucVKJAa3/+Rex8cnPqXuv4/QJ87ZToM2h6n7lhaWjMzwfmTexu8IyYNeodvXT/NXzoMINFKfNQ1klgPitPl2LN9L2JwCilpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CFbXnNlD; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240610132756euoutp026928bf495d4525068f3b46dea21854f1~Xp51PL4H22472324723euoutp02V
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:27:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240610132756euoutp026928bf495d4525068f3b46dea21854f1~Xp51PL4H22472324723euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718026076;
	bh=2Z8wXjlYIPERfzptUV3h5MdMM3rR60oXjr32nLTaL6E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=CFbXnNlDSK6gOG9nIzT+hJzC/nF8Muw6cgaGbE4CTQ81JPsNDIzuZVwZ2e3mec6ao
	 YhpCvc3Q6lGIg360HL4cqowFeWC19XmgqhdZ/1GlDj+SbWotoYg5p0fpPvbhDaSlE+
	 CvIRL5MCZmDrJu1O9HstjymL+mm9On6G+QrSvUAI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240610132756eucas1p20a0ddc30e24d8fdfa888adc5a738be9b~Xp507UIEj2617726177eucas1p29;
	Mon, 10 Jun 2024 13:27:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id BC.22.09624.C5FF6666; Mon, 10
	Jun 2024 14:27:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240610132756eucas1p1d892ccbabdb5f8fc4cff55c662f24d75~Xp50hlGva2803828038eucas1p1l;
	Mon, 10 Jun 2024 13:27:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610132756eusmtrp1c09aa9d774e4a09179c0522d65a17869~Xp50g79xe1090610906eusmtrp1K;
	Mon, 10 Jun 2024 13:27:56 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-10-6666ff5c8b01
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.CD.09010.B5FF6666; Mon, 10
	Jun 2024 14:27:56 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610132755eusmtip2a7310cd58c7606617cc1cc03cd441c5e~Xp50S9nLG1991019910eusmtip2W;
	Mon, 10 Jun 2024 13:27:55 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 10 Jun 2024 14:27:55 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 10 Jun
	2024 14:27:54 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hughd@google.com" <hughd@google.com>, "willy@infradead.org"
	<willy@infradead.org>, "david@redhat.com" <david@redhat.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
	"ying.huang@intel.com" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
	<ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>, Pankaj Raghav
	<p.raghav@samsung.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/6] mm: shmem: add mTHP support for anonymous shmem
Thread-Topic: [PATCH v4 4/6] mm: shmem: add mTHP support for anonymous shmem
Thread-Index: AQHatmirtcoE1ahYsESQwpFoX6NdQ7HA9mmA
Date: Mon, 10 Jun 2024 13:27:53 +0000
Message-ID: <kzoo6v5tc44yztltdhbf2qbor3uladm3wsxvuahhkf3zdytp63@wt4hww4oj7gq>
In-Reply-To: <9be6eeacd0304c82a1cb1b7487977a3e14d2b5df.1717495894.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F9DBEBECA11944D86EAED38E57CED8E@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7djP87ox/9PSDK5NVrD4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InisklJzcksSy3St0vgyth4s5GtYH1qxcK955kbGCcEdDFyckgI
	mEg8XfmFsYuRi0NIYAWjRPeqqUwQzhdGiX37JrFBOJ8ZJd6uOcPcxcgB1rJ2lglIt5DAckaJ
	h09T4GpW7XkM1XCGUeL/qsdQc1cySkycvpIZpIVNQFNi38lN7CCTRAT0JXrn+oLUMAtMZ5VY
	fLmHDSQuLOAt8f2gKUi5iICPxNJ1W1ghbCOJfycXM4LYLAKqErc/tLOA2LwCvhJHvv9hArE5
	BVIkersgVjEKyEo8WvmLHcRmFhCXuPVkPhPEz4ISi2bvYYawxST+7XrIBmHrSJy9/oQRwjaQ
	2Lp0HwuErSjRcewmG8QcHYkFuz9B2ZYSj7+0Qc3Xlli28DUzxD2CEidnPmEB+UtCYCeXxKJ7
	U6EWuEi82vCcHcIWlnh1fAv7BEadWUjum4VkxywkO2Yh2TELyY4FjKyrGMVTS4tz01OLDfNS
	y/WKE3OLS/PS9ZLzczcxAlPk6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8QhnJaUK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1MxZ+kFy3Ydff5P7mjvbN8
	PN5onl20ecUyVe2lKW+b2Y03rpLn3tPMfEFNJMl+509D92/n3yx+f7ZE7KJvwUFmpxlTN7Zc
	Sz9fGfM/lvntk6Nv895OnSQp+dzI+pz3yXKjr8IrAudXes1lreixM9b+6KU5ZfZl6SvTnWa7
	plnmP55RstSX7Ron84x/vn+vFZxr7lh2cNrpHT3dyxZGvLuSG5vA9Pi1vmxZxHr/24oik3Zr
	pSramm62/PxnVs6+cI7oyj42VbOzce6FnWf0Lvj1hTfGu5hnNx3hLnxdv+FT1j1mpsjJ/9mk
	G9etlnkRvlFA197OYa/Ssor3fXu0fvx5mvJxk+5jnkmuwaZz6156KbEUZyQaajEXFScCABgz
	v3cABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsVy+t/xe7ox/9PSDF5uZbb4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
	s0lJzcksSy3St0vQy9h4s5GtYH1qxcK955kbGCcEdDFycEgImEisnWXSxcjFISSwlFFi8rkW
	pi5GTqC4jMTGL1dZIWxhiT/Xutggij4yStzYepwVwjnDKDH19QUoZyWjxOW1e8Ha2QQ0Jfad
	3MQOskJEQF+id64vSA2zwHRWicWXe9hA4sIC3hLfD5qClIsI+EgsXbeFFcI2kvh3cjEjiM0i
	oCpx+0M7C4jNK+ArceT7H7DxQgKzGCX2T44CsTkFUiR6u1Yyg9iMArISj1b+YgexmQXEJW49
	mQ/1jYDEkj3nmSFsUYmXj/9BfaYjcfb6E0YI20Bi69J9LBC2okTHsZtsEHN0JBbs/gRlW0o8
	/tIGNV9bYtnC18wQtwlKnJz5hGUCo8wsJKtnIWmfhaR9FpL2WUjaFzCyrmIUSS0tzk3PLTbS
	K07MLS7NS9dLzs/dxAhMf9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8AplJKcJ8aYkVlalFuXH
	F5XmpBYfYjQFht1EZinR5HxgAs4riTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgt
	gulj4uCUamCapuKqW3ZE5iPLzGL7BVO+WHS0dhxXfuTl1LHrdpG/p1mZ9wy1m4YvUq8YcP+r
	el+s292VnfafL/rUr9NMbzTzJ+rmleRv9zX+tmJWb1vsWg/e1BajBU6BorWRB55rH9U1N7H1
	l9cVmJV8Yo2ehFCwmI/WlNI7SV8ZzlhIXbiWNPfjSfalFreuvdpl+d7mT86L5lUnnwXO3zrF
	LfnqV5a3p9Q8LTS6bafs5Vxynu/nisd/j9uYF006vrB7xjapwmtHXz1aVLEtY9/FYyEGM39q
	pgd0ie6UOXHOSu+mwc3448tkK9apRf+xz5j0Yo+nVrRCnvk7IV3O7H0LGO+9eLzx+dY9H8Uu
	3t3x+3duxfIMJZbijERDLeai4kQAbRrQhwgEAAA=
X-CMS-MailID: 20240610132756eucas1p1d892ccbabdb5f8fc4cff55c662f24d75
X-Msg-Generator: CA
X-RootMTR: 20240610132756eucas1p1d892ccbabdb5f8fc4cff55c662f24d75
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240610132756eucas1p1d892ccbabdb5f8fc4cff55c662f24d75
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
	<9be6eeacd0304c82a1cb1b7487977a3e14d2b5df.1717495894.git.baolin.wang@linux.alibaba.com>
	<CGME20240610132756eucas1p1d892ccbabdb5f8fc4cff55c662f24d75@eucas1p1.samsung.com>

On Tue, Jun 04, 2024 at 06:17:48PM +0800, Baolin Wang wrote:
> Commit 19eaf44954df adds multi-size THP (mTHP) for anonymous pages, that
> can allow THP to be configured through the sysfs interface located at
> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>=20
> However, the anonymous shmem will ignore the anonymous mTHP rule
> configured through the sysfs interface, and can only use the PMD-mapped
> THP, that is not reasonable. Users expect to apply the mTHP rule for
> all anonymous pages, including the anonymous shmem, in order to enjoy
> the benefits of mTHP. For example, lower latency than PMD-mapped THP,
> smaller memory bloat than PMD-mapped THP, contiguous PTEs on ARM architec=
ture
> to reduce TLB miss etc. In addition, the mTHP interfaces can be extended
> to support all shmem/tmpfs scenarios in the future, especially for the
> shmem mmap() case.
>=20
> The primary strategy is similar to supporting anonymous mTHP. Introduce
> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
> which can have almost the same values as the top-level
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
> additional "inherit" option and dropping the testing options 'force' and
> 'deny'. By default all sizes will be set to "never" except PMD size,
> which is set to "inherit". This ensures backward compatibility with the
> anonymous shmem enabled of the top level, meanwhile also allows independe=
nt
> control of anonymous shmem enabled for each mTHP.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/huge_mm.h |  10 +++
>  mm/shmem.c              | 187 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 167 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index fac21548c5de..909cfc67521d 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -575,6 +575,16 @@ static inline bool thp_migration_supported(void)
>  {
>  	return false;
>  }
> +
> +static inline int highest_order(unsigned long orders)
> +{
> +	return 0;
> +}
> +
> +static inline int next_order(unsigned long *orders, int prev)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> =20
>  static inline int split_folio_to_list_to_order(struct folio *folio,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 643ff7516b4d..9a8533482208 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1611,6 +1611,107 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t=
 limit_gfp)
>  	return result;
>  }
> =20
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static unsigned long anon_shmem_allowable_huge_orders(struct inode *inod=
e,

We want to get mTHP orders as well for tmpfs so, could we make this to work=
 for
both paths? If true, I'd remove the anon prefix.

> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge)

Why did you rename 'huge' variable to 'global_huge'? We were using 'huge' i=
n
shmem_alloc_and_add_folio() before this commit. I guess it's just odd to me=
 this
var rename without seen any name conflict inside it.

> +{
> +	unsigned long mask =3D READ_ONCE(huge_anon_shmem_orders_always);
> +	unsigned long within_size_orders =3D READ_ONCE(huge_anon_shmem_orders_w=
ithin_size);
> +	unsigned long vm_flags =3D vma->vm_flags;
> +	/*
> +	 * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
> +	 * are enabled for this vma.
> +	 */
> +	unsigned long orders =3D BIT(PMD_ORDER + 1) - 1;
> +	loff_t i_size;
> +	int order;
> +

We can start the mm anon path here but we should exclude the ones that do n=
ot
apply for tmpfs.

> +	if ((vm_flags & VM_NOHUGEPAGE) ||
> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +		return 0;
> +
> +	/* If the hardware/firmware marked hugepage support disabled. */
> +	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED=
))
> +		return 0;
> +
> +	/*
> +	 * Following the 'deny' semantics of the top level, force the huge
> +	 * option off from all mounts.
> +	 */
> +	if (shmem_huge =3D=3D SHMEM_HUGE_DENY)
> +		return 0;
> +
> +	/*
> +	 * Only allow inherit orders if the top-level value is 'force', which
> +	 * means non-PMD sized THP can not override 'huge' mount option now.
> +	 */
> +	if (shmem_huge =3D=3D SHMEM_HUGE_FORCE)
> +		return READ_ONCE(huge_anon_shmem_orders_inherit);
> +
> +	/* Allow mTHP that will be fully within i_size. */
> +	order =3D highest_order(within_size_orders);
> +	while (within_size_orders) {
> +		index =3D round_up(index + 1, order);
> +		i_size =3D round_up(i_size_read(inode), PAGE_SIZE);
> +		if (i_size >> PAGE_SHIFT >=3D index) {
> +			mask |=3D within_size_orders;
> +			break;
> +		}
> +
> +		order =3D next_order(&within_size_orders, order);
> +	}
> +
> +	if (vm_flags & VM_HUGEPAGE)
> +		mask |=3D READ_ONCE(huge_anon_shmem_orders_madvise);
> +
> +	if (global_huge)
> +		mask |=3D READ_ONCE(huge_anon_shmem_orders_inherit);
> +
> +	return orders & mask;
> +}
> +
> +static unsigned long anon_shmem_suitable_orders(struct inode *inode, str=
uct vm_fault *vmf,
> +					struct address_space *mapping, pgoff_t index,
> +					unsigned long orders)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
> +	unsigned long pages;
> +	int order;
> +
> +	orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);

This won't apply to tmpfs. I'm thinking if we can apply
shmem_mapping_size_order() [1] here for tmpfs path so we have the same suit=
able
orders for both paths.

[1] https://lore.kernel.org/all/v5acpezkt4ml3j3ufmbgnq5b335envea7xfobvowtae=
tvbt3an@v3pfkwly5jh2/#t

> +	if (!orders)
> +		return 0;
> +
> +	/* Find the highest order that can add into the page cache */
> +	order =3D highest_order(orders);
> +	while (orders) {
> +		pages =3D 1UL << order;
> +		index =3D round_down(index, pages);
> +		if (!xa_find(&mapping->i_pages, &index,
> +			     index + pages - 1, XA_PRESENT))
> +			break;
> +		order =3D next_order(&orders, order);
> +	}
> +
> +	return orders;
> +}
> +#else
> +static unsigned long anon_shmem_allowable_huge_orders(struct inode *inod=
e,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge)
> +{
> +	return 0;
> +}
> +
> +static unsigned long anon_shmem_suitable_orders(struct inode *inode, str=
uct vm_fault *vmf,
> +					struct address_space *mapping, pgoff_t index,
> +					unsigned long orders)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>  static struct folio *shmem_alloc_folio(gfp_t gfp, int order,
>  		struct shmem_inode_info *info, pgoff_t index)
>  {
> @@ -1625,38 +1726,55 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,=
 int order,
>  	return folio;
>  }
> =20
> -static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
> -		struct inode *inode, pgoff_t index,
> -		struct mm_struct *fault_mm, bool huge)
> +static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
> +		gfp_t gfp, struct inode *inode, pgoff_t index,
> +		struct mm_struct *fault_mm, unsigned long orders)
>  {
>  	struct address_space *mapping =3D inode->i_mapping;
>  	struct shmem_inode_info *info =3D SHMEM_I(inode);
> -	struct folio *folio;
> +	struct vm_area_struct *vma =3D vmf ? vmf->vma : NULL;
> +	unsigned long suitable_orders =3D 0;
> +	struct folio *folio =3D NULL;
>  	long pages;
> -	int error;
> +	int error, order;
> =20
>  	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> -		huge =3D false;
> +		orders =3D 0;
> =20
> -	if (huge) {
> -		pages =3D HPAGE_PMD_NR;
> -		index =3D round_down(index, HPAGE_PMD_NR);
> +	if (orders > 0) {

Can we get rid of this condition if we handle all allowable orders in 'orde=
rs'?
Including order-0 and PMD-order. I agree, we do not need the huge flag anym=
ore
since you have handled all cases in shmem_allowable_huge_orders().

> +		if (vma && vma_is_anon_shmem(vma)) {
> +			suitable_orders =3D anon_shmem_suitable_orders(inode, vmf,
> +							mapping, index, orders);
> +		} else if (orders & BIT(HPAGE_PMD_ORDER)) {
> +			pages =3D HPAGE_PMD_NR;
> +			suitable_orders =3D BIT(HPAGE_PMD_ORDER);
> +			index =3D round_down(index, HPAGE_PMD_NR);
> =20
> -		/*
> -		 * Check for conflict before waiting on a huge allocation.
> -		 * Conflict might be that a huge page has just been allocated
> -		 * and added to page cache by a racing thread, or that there
> -		 * is already at least one small page in the huge extent.
> -		 * Be careful to retry when appropriate, but not forever!
> -		 * Elsewhere -EEXIST would be the right code, but not here.
> -		 */
> -		if (xa_find(&mapping->i_pages, &index,
> -				index + HPAGE_PMD_NR - 1, XA_PRESENT))
> -			return ERR_PTR(-E2BIG);
> +			/*
> +			 * Check for conflict before waiting on a huge allocation.
> +			 * Conflict might be that a huge page has just been allocated
> +			 * and added to page cache by a racing thread, or that there
> +			 * is already at least one small page in the huge extent.
> +			 * Be careful to retry when appropriate, but not forever!
> +			 * Elsewhere -EEXIST would be the right code, but not here.
> +			 */
> +			if (xa_find(&mapping->i_pages, &index,
> +				    index + HPAGE_PMD_NR - 1, XA_PRESENT))
> +				return ERR_PTR(-E2BIG);
> +		}
> =20
> -		folio =3D shmem_alloc_folio(gfp, HPAGE_PMD_ORDER, info, index);
> -		if (!folio && pages =3D=3D HPAGE_PMD_NR)
> -			count_vm_event(THP_FILE_FALLBACK);
> +		order =3D highest_order(suitable_orders);
> +		while (suitable_orders) {
> +			pages =3D 1UL << order;
> +			index =3D round_down(index, pages);
> +			folio =3D shmem_alloc_folio(gfp, order, info, index);
> +			if (folio)
> +				goto allocated;
> +
> +			if (pages =3D=3D HPAGE_PMD_NR)
> +				count_vm_event(THP_FILE_FALLBACK);
> +			order =3D next_order(&suitable_orders, order);
> +		}
>  	} else {
>  		pages =3D 1;
>  		folio =3D shmem_alloc_folio(gfp, 0, info, index);
> @@ -1664,6 +1782,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_=
t gfp,
>  	if (!folio)
>  		return ERR_PTR(-ENOMEM);
> =20
> +allocated:
>  	__folio_set_locked(folio);
>  	__folio_set_swapbacked(folio);
> =20
> @@ -1958,7 +2077,8 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>  	struct mm_struct *fault_mm;
>  	struct folio *folio;
>  	int error;
> -	bool alloced;
> +	bool alloced, huge;
> +	unsigned long orders =3D 0;
> =20
>  	if (WARN_ON_ONCE(!shmem_mapping(inode->i_mapping)))
>  		return -EINVAL;
> @@ -2030,14 +2150,21 @@ static int shmem_get_folio_gfp(struct inode *inod=
e, pgoff_t index,
>  		return 0;
>  	}
> =20
> -	if (shmem_is_huge(inode, index, false, fault_mm,
> -			  vma ? vma->vm_flags : 0)) {
> +	huge =3D shmem_is_huge(inode, index, false, fault_mm,
> +			     vma ? vma->vm_flags : 0);
> +	/* Find hugepage orders that are allowed for anonymous shmem. */
> +	if (vma && vma_is_anon_shmem(vma))

I guess we do not want to check the anon path here either (in case you agre=
e to
merge this with tmpfs path).

> +		orders =3D anon_shmem_allowable_huge_orders(inode, vma, index, huge);
> +	else if (huge)
> +		orders =3D BIT(HPAGE_PMD_ORDER);

Why not handling this case inside allowable_huge_orders()?

> +
> +	if (orders > 0) {

Does it make sense to handle these case anymore? Before, we had the huge
path and order-0. If we handle all cases in allowable_orders() perhaps we c=
an
simplify this.

>  		gfp_t huge_gfp;
> =20
>  		huge_gfp =3D vma_thp_gfp_mask(vma);

We are also setting this flag regardless of the final order. Meaning that
suitable_orders() might return order-0 and yet we keep the huge gfp flag. I=
s
that right?

>  		huge_gfp =3D limit_gfp_mask(huge_gfp, gfp);
> -		folio =3D shmem_alloc_and_add_folio(huge_gfp,
> -				inode, index, fault_mm, true);
> +		folio =3D shmem_alloc_and_add_folio(vmf, huge_gfp,
> +				inode, index, fault_mm, orders);
>  		if (!IS_ERR(folio)) {
>  			if (folio_test_pmd_mappable(folio))
>  				count_vm_event(THP_FILE_ALLOC);
> @@ -2047,7 +2174,7 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>  			goto repeat;
>  	}
> =20
> -	folio =3D shmem_alloc_and_add_folio(gfp, inode, index, fault_mm, false)=
;
> +	folio =3D shmem_alloc_and_add_folio(vmf, gfp, inode, index, fault_mm, 0=
);
>  	if (IS_ERR(folio)) {
>  		error =3D PTR_ERR(folio);
>  		if (error =3D=3D -EEXIST)
> @@ -2058,7 +2185,7 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
> =20
>  alloced:
>  	alloced =3D true;
> -	if (folio_test_pmd_mappable(folio) &&
> +	if (folio_test_large(folio) &&
>  	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
>  					folio_next_index(folio) - 1) {
>  		struct shmem_sb_info *sbinfo =3D SHMEM_SB(inode->i_sb);
> --=20
> 2.39.3
> =

