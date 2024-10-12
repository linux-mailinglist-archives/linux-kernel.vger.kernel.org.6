Return-Path: <linux-kernel+bounces-362056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FC999B068
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D1DBB237CC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53686277;
	Sat, 12 Oct 2024 03:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XhMM/G5Y"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3578C07
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728703402; cv=none; b=oDlpPmojxwBYfnCgmJt8yY2KK/nSKkyVsK0vpxcbFl2Qw3/e5CFLMaepMCE5QFVeWTEjJ0zRYLuNl2+3DBcnnwSZhxoK7UI3qw0wj/jEGQLii9tHc29YiFLXh3SuocO+tpjb0/9hPrR/BJ/RpwEDJPpEvzgdWMT3oSTNnFvNCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728703402; c=relaxed/simple;
	bh=WZh8A8esidVq4Wdah9lhkYEjv01CeyMgH6tCJXDA91Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bcnuXWD0nfn1rWIIN+1yDUnsA+o47P0b1TSFMmLtvhoZj42uJCtx8h9WEn52ln04SgzRa0O6SkeYZK7mTVoVpTFJQ3iwdDYM++fXced4d1fB5NvrOhpjlo/rJs1cySOnKjy3z4OxlnAZTR5kcr1Ix7PaZWdvskmsiVNzP3VPgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XhMM/G5Y; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728703397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79Mzw15mpNKD+frrr201ZwC3OMDjPfjgdZyLyMlzeCw=;
	b=XhMM/G5Y3Ucc3o9uUr2OV7jmiwh7AfKajKQxx1vDgkz4UIhNyN1873N20P2ECySFu8MifW
	+6mMVa+fuEOcMCdHLZM+w8g8USEhL7u1xEGM16JpopXTPe3DJ4owHUuCOtY+3X9MbyM1id
	ZRYeqhWYjeyh3Sy1aiclAgquIDtrG6Q=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] mm/hugetlb: Concentrated releases memory when cmdline
 specifies node requests for large pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20241011080543.2422-1-suhua1@kingsoft.com>
Date: Sat, 12 Oct 2024 11:22:20 +0800
Cc: akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 suhua <suhua1@kingsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1125584-8165-473F-8E11-44CD4BD90BDF@linux.dev>
References: <20241011080543.2422-1-suhua1@kingsoft.com>
To: suhua <suhua.tanke@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Oct 11, 2024, at 16:05, suhua <suhua.tanke@gmail.com> wrote:
>=20
> When HVO is enabled and huge page memory allocs are made, the freed =
memory
> can be aggregated into higher order memory in the following paths, =
which
> facilitates further allocs for higher order memory.
>=20
> echo 200000 > /proc/sys/vm/nr_hugepages
> echo 200000 > =
/sys/devices/system/node/node*/hugepages/hugepages-2048kB/nr_hugepages
> grub=EF=BC=9A default_hugepagesz=3D2M hugepagesz=3D2M hugepages=3D200000=

>=20
> Currently not support for releasing aggregations to higher order in =
the
> following way, which will releasing to lower order.
>=20
> grub: default_hugepagesz=3D2M hugepagesz=3D2M =
hugepages=3D0:100000,1:100000
>=20
> This patch supports the release of huge page optimizations aggregates =
to
> higher order memory.
>=20
> eg:
> cat /proc/cmdline
> BOOT_IMAGE=3D/boot/vmlinuz-xxx ... default_hugepagesz=3D2M =
hugepagesz=3D2M hugepages=3D0:100000,1:100000
>=20
> Before:
> Free pages count per migrate type at order       0      1      2      =
3      4      5      6      7      8      9     10
> ...
> Node    0, zone   Normal, type    Unmovable  55282  97039  99307      =
0      1      1      0      1      1      1      0
> Node    0, zone   Normal, type      Movable     25     11    345     =
87     48     21      2     20      9      3  75061
> Node    0, zone   Normal, type  Reclaimable      4      2      2      =
4      3      0      2      1      1      1      0
> Node    0, zone   Normal, type   HighAtomic      0      0      0      =
0      0      0      0      0      0      0      0
> ...
> Free pages count per migrate type at order       0      1      2      =
3      4      5      6      7      8      9     10
> Node    1, zone   Normal, type    Unmovable  98888  99650  99679      =
2      3      1      2      2      2      0      0
> Node    1, zone   Normal, type      Movable      1      1      0      =
1      1      0      1      0      1      1  75937
> Node    1, zone   Normal, type  Reclaimable      0      0      0      =
0      0      0      0      0      0      0      0
> Node    1, zone   Normal, type   HighAtomic      0      0      0      =
0      0      0      0      0      0      0      0
>=20
> After:
> Free pages count per migrate type at order       0      1      2      =
3      4      5      6      7      8      9     10
> ...
> Node    0, zone   Normal, type    Unmovable    152    158     37      =
2      2      0      3      4      2      6    717
> Node    0, zone   Normal, type      Movable      1     37     53      =
3     55     49     16      6      2      1  75000
> Node    0, zone   Normal, type  Reclaimable      1      4      3      =
1      2      1      1      1      1      1      0
> Node    0, zone   Normal, type   HighAtomic      0      0      0      =
0      0      0      0      0      0      0      0
> ...
> Free pages count per migrate type at order       0      1      2      =
3      4      5      6      7      8      9     10
> Node    1, zone   Normal, type    Unmovable      5      3      2      =
1      3      4      2      2      2      0    779
> Node    1, zone   Normal, type      Movable      1      0      1      =
1      1      0      1      0      1      1  75849
> Node    1, zone   Normal, type  Reclaimable      0      0      0      =
0      0      0      0      0      0      0      0
> Node    1, zone   Normal, type   HighAtomic      0      0      0      =
0      0      0      0      0      0      0      0

A good result. But the subject could be changed to:

	"mm/hugetlb: perform vmemmap optimization batchly for specific =
node allocation"

>=20
> Signed-off-by: suhua <suhua1@kingsoft.com>
> ---
> mm/hugetlb.c | 37 +++++++++++++++++++++++++++++++++----
> 1 file changed, 33 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 190fa05635f4..3441d380c90b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2077,6 +2077,24 @@ static struct folio =
*only_alloc_fresh_hugetlb_folio(struct hstate *h,
> 	return folio;
> }
>=20
> +static struct folio *only_alloc_and_account_fresh_hugetlb_folio(
> + 		struct hstate *h, gfp_t gfp_mask,
> + 		int nid, nodemask_t *nmask)
> +{
> + 	struct folio *folio;
> +
> + 	folio =3D only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, =
nmask, NULL);
> + 	if (!folio)
> + 		return NULL;
> +
> + 	spin_lock_irq(&hugetlb_lock);
> + 	h->nr_huge_pages++;
> + 	h->nr_huge_pages_node[nid]++;
> + 	spin_unlock_irq(&hugetlb_lock);
> +
> + 	return folio;
> +}
> +
> /*
>  * Common helper to allocate a fresh hugetlb page. All specific =
allocators
>  * should use this function to get new hugetlb pages
> @@ -3301,23 +3319,34 @@ static void __init =
hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
> {
> 	unsigned long i;
> 	char buf[32];
> + 	LIST_HEAD(folio_list);
> + 	struct folio *folio, *tmp_f;
>=20
> 	for (i =3D 0; i < h->max_huge_pages_node[nid]; ++i) {
> 		if (hstate_is_gigantic(h)) {
> 			if (!alloc_bootmem_huge_page(h, nid))
> 				break;
> 		} else {
> - 			struct folio *folio;
> 			gfp_t gfp_mask =3D htlb_alloc_mask(h) | =
__GFP_THISNODE;
>=20
> - 			folio =3D alloc_fresh_hugetlb_folio(h, gfp_mask, =
nid,
> - 					&node_states[N_MEMORY]);
> + 			folio =3D =
only_alloc_and_account_fresh_hugetlb_folio(h,
> + 					gfp_mask, nid, =
&node_states[N_MEMORY]);

I think we could use only_alloc_fresh_hugetlb_folio plus =
prep_and_add_allocated_folios
to achieve the same goal but more simpler, right?

> 			if (!folio)
> 				break;
> - 			free_huge_folio(folio); /* free it into the =
hugepage allocator */
> + 			list_add(&folio->lru, &folio_list);
> 		}
> 		cond_resched();
> 	}
> +
> + 	if (!list_empty(&folio_list)) {
> + 		/* Send list for bulk vmemmap optimization processing */
> + 		hugetlb_vmemmap_optimize_folios(h, &folio_list);
> +
> + 		list_for_each_entry_safe(folio, tmp_f, &folio_list, lru) =
{
> + 			free_huge_folio(folio); /* free it into the =
hugepage allocator */
> + 		}
> + 	}

We could use prep_and_add_allocated_folios here.

Thanks.

> +
> 	if (i =3D=3D h->max_huge_pages_node[nid])
> 		return;
>=20
> --=20
> 2.34.1
>=20


