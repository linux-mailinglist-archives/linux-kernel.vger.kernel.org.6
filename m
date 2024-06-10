Return-Path: <linux-kernel+bounces-208477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CE902591
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB601F23737
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2605150993;
	Mon, 10 Jun 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LeGw68Ls"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBF150991
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032994; cv=none; b=pegG0EYOEhoodBf5JnY7O4edgp1UVin/wJeOQ42BfLrF7fYh1f/zVQjMSxBrq6LJCSbdNwyWemKpOLFAG2e7cM9WEXWnUlYSyLIMccG+gNor4U0w2OFHgShjt3sfL1lfZQNBO0iBiPMlDM4zjU0Dx1LTlElMLAlbnk4jePkvh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032994; c=relaxed/simple;
	bh=MeURfKp4npVnwlWE8hV6JLcA+wNUiMHoeT8QM74Um5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=AJfVZKMeA4kWaXevLy9jUgUiPDbWHpm+VHpnz3nuXEh2+Qzyq02ZkJpPJBDuONOAai8b356ppsQv8kW8K1cex9S8s457dnBI1A65nxVOMrRd1a62xAwPrffMlC0jB0YdVbhqlC0tsvCytqgCDIU05snJyQKzXREtq7hMoWuf8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LeGw68Ls; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240610152309euoutp019da7397ffb5cc01b761d793ed8bf34e8~Xrea5BrQp1000410004euoutp01j
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:23:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240610152309euoutp019da7397ffb5cc01b761d793ed8bf34e8~Xrea5BrQp1000410004euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718032989;
	bh=xsQRh9XT0ssETz1BZhE8jFAxkkrZ+caHg8QHRypEaZQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=LeGw68Ls+3L0S5kx8X7KkJoqbMbJUquiIj57f47YwBnTfC+O2tX/YJg3EBm60a7pt
	 srtcibqQJwjnijZjmx/rq5tGiVsXp1rfkEW1FUdixWVPOz06tBYt7B9w7kFrT5H5AK
	 uLW6JRWg5nV9sQwfKGhP0/zUbLtI6zthpzAgUmgA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240610152308eucas1p254c0bd8c8ab1b3d99e3abce355e2a8c7~XreajaHdv0828808288eucas1p28;
	Mon, 10 Jun 2024 15:23:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F7.09.09620.C5A17666; Mon, 10
	Jun 2024 16:23:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240610152307eucas1p10417f113fcc5e1729bdf638f370d54e4~XreZhT2xA2197921979eucas1p1U;
	Mon, 10 Jun 2024 15:23:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610152307eusmtrp135eb1e0ff64ac806e8eaf41de73053fe~XreZfPx8Q1787017870eusmtrp1G;
	Mon, 10 Jun 2024 15:23:07 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-a2-66671a5caf40
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A5.63.08810.B5A17666; Mon, 10
	Jun 2024 16:23:07 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240610152307eusmtip1db04ad59f2b5fa6cf768636ea5fcf278~XreZN62xP0569405694eusmtip1j;
	Mon, 10 Jun 2024 15:23:07 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 10 Jun 2024 16:23:06 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 10 Jun
	2024 16:23:06 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hughd@google.com" <hughd@google.com>, "willy@infradead.org"
	<willy@infradead.org>, "david@redhat.com" <david@redhat.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
	"chrisl@kernel.org" <chrisl@kernel.org>, "ying.huang@intel.com"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "shy828301@gmail.com"
	<shy828301@gmail.com>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"ioworker0@gmail.com" <ioworker0@gmail.com>, Pankaj Raghav
	<p.raghav@samsung.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] mm: add new 'orders' parameter for
 find_get_entries() and find_lock_entries()
Thread-Topic: [PATCH 5/7] mm: add new 'orders' parameter for
	find_get_entries() and find_lock_entries()
Thread-Index: AQHauAk68+kKkF9tKUiB4eqFXoRvB7HBE1kA
Date: Mon, 10 Jun 2024 15:23:06 +0000
Message-ID: <v3dqmzgrfpqmfckqnl4voelofevm56q4n4lbk2fq5o5rfclylb@wmtz6ms22ep2>
In-Reply-To: <5304c4c54868336985b396d2c46132c2e0cdf803.1717673614.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9399C4818E7B364CA97436B94E4A03A5@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7djP87oxUulpBqf+m1p8vitkMWf9GjaL
	/3uPMVo0PXjEZPF1/S9mi6ef+lgsFv02tri8aw6bxb01/1ktenZPZbRYcGIxo0Xj5/uMFr9/
	ACVOzprMYjH76D12B36PNfPWMHrsnHWX3WPBplKPliNvWT02r9DyWLznJZPHplWdbB6bPk1i
	9zgx4zeLx86Hlh69ze/YPN7vu8rm8XmTXABvFJdNSmpOZllqkb5dAlfG9ZbbLAW/PCu6Lt5l
	aWA8adXFyMkhIWAise7UF8YuRi4OIYEVjBJvrl5jgXC+MEocaJ/ADuF8ZpTYefILC1zL3D2s
	EInljBJ/W1aywFX1H5oH5ZxhlFi37CkbhLMSaPKSt0wg/WwCmhL7Tm4CGszBISKgL9E71xek
	hlngEKtE49lzjCA1wgIZEic2rQSrFxHIlGj+dIURwjaSaLu1lg2kl0VAVWLHJ1WQMK+Ar0R3
	/zF2EJtTIEViU+9WsFZGAVmJRyt/gcWZBcQlbj2ZzwTxgqDEotl7mCFsMYl/ux6yQdg6Emev
	P2GEsA0kti7dB/WyokTHsZtsEHN0JBbs/gRlW0rs3/oIytaWWLbwNTPEPYISJ2c+AQeEhMBR
	Lol3D9ayQgxykXg45SnUEcISr45vYZ/AqDMLyX2zkOyYhWTHLCQ7ZiHZsYCRdRWjeGppcW56
	arFxXmq5XnFibnFpXrpecn7uJkZg6jz97/jXHYwrXn3UO8TIxMF4iFGCg1lJhFcoIzlNiDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqgcluQd//E03HfrLb
	yh7xul4VcX6VuTrDpBPGwlqdXgeX/g35w6P2t7YuLTFTo6Pshodx2XrnOqF7qzRVEtriEg2C
	z+VesAo9+2G9qE2ZU+/KC1ETv3jMO+V2QSPByig+xK/AdpeNtuEyly92HOVhVWohq05NqAsU
	LE3Yw5fH3Mx9u2v57f7D27LKtvTNOHGyScPli1qm4rn0SbvvnhGNmsjXoqD4afsPefdS5afM
	cr+fulkLvFi5tuPqRS/3hYfcp3hNyDo0800Aaw/nDfe027UxzVuavSRjr9kwbDRdFS8iWf6o
	4Pp12akR+5O6mz8+b1vu1iS7/Fb189+qi3zf7I0IsLheF5f15cPJ9MnhSizFGYmGWsxFxYkA
	mbeB5AwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42I5/e/4Xd1oqfQ0g88f1C0+3xWymLN+DZvF
	/73HGC2aHjxisvi6/hezxdNPfSwWi34bW1zeNYfN4t6a/6wWPbunMlosOLGY0aLx831Gi98/
	gBInZ01msZh99B67A7/HmnlrGD12zrrL7rFgU6lHy5G3rB6bV2h5LN7zkslj06pONo9Nnyax
	e5yY8ZvFY+dDS4/e5ndsHu/3XWXz+LxJLoA3Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
	z9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jesttloJfnhVdF++yNDCetOpi5OSQEDCRWDd3D2sX
	IxeHkMBSRolzb++xQiRkJDZ+uQplC0v8udbFBlH0kVHixY6tUM4ZRonpcw9DOSsZJebMOQrW
	wiagKbHv5Cb2LkYODhEBfYneub4gNcwCh1glGs+eYwSpERbIkPjXf4sRoiZT4vf9cpCwiICR
	RNuttWwgYRYBVYkdn1RBwrwCvhLd/cfYIVbNYpTonTeHDSTBKZAisal3KxOIzSggK/Fo5S92
	EJtZQFzi1pP5TBAfCEgs2XOeGcIWlXj5+B/UZzoSZ68/YYSwDSS2Lt3HAmErSnQcu8kGMUdH
	YsHuT1C2pcT+rY+gbG2JZQtfM0McJyhxcuYTlgmMMrOQrJ6FpH0WkvZZSNpnIWlfwMi6ilEk
	tbQ4Nz232FCvODG3uDQvXS85P3cTIzApbjv2c/MOxnmvPuodYmTiYDzEKMHBrCTCK5SRnCbE
	m5JYWZValB9fVJqTWnyI0RQYdhOZpUST84FpOa8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9
	sSQ1OzW1ILUIpo+Jg1OqgWl2TOCNta+tlluErnnwwWqy8L4XTG/OaXPP2Lyv7Efp+WrzaQYu
	xzj2V9xXTV10S4rtkrb57uVMPmx3pFbMnSPJmlG+6NG+4oe7mnZ7H5rwz+bqE+8rq64uZNOs
	OXF95sPJejHOF/ZdVJ+avFxx3Y19gRluW8qnOLd8rT1dU9ybd+fp5qKFh47fmr6Ip1Yp7NVy
	Ncm/H1QN12WyvK9ne+N/3aGg4PyPYNfM9h3VBwyd6zITpV8Y39X0aarwlftRcH1Py77TUy1n
	Prnew3sopUngXrp92J5tW1Z+NspnkTjJZhxcmf2uOu+FhWvA4upZH7ntu2TttL5ujTESbn1q
	seHbClP+/PomwzXfZJv3T/FQYinOSDTUYi4qTgQADOPzoBMEAAA=
X-CMS-MailID: 20240610152307eucas1p10417f113fcc5e1729bdf638f370d54e4
X-Msg-Generator: CA
X-RootMTR: 20240610152307eucas1p10417f113fcc5e1729bdf638f370d54e4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240610152307eucas1p10417f113fcc5e1729bdf638f370d54e4
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
	<5304c4c54868336985b396d2c46132c2e0cdf803.1717673614.git.baolin.wang@linux.alibaba.com>
	<CGME20240610152307eucas1p10417f113fcc5e1729bdf638f370d54e4@eucas1p1.samsung.com>

Hi Baolin,

On Thu, Jun 06, 2024 at 07:58:55PM +0800, Baolin Wang wrote:
> In the following patches, shmem will support the swap out of large folios=
,
> which means the shmem mappings may contain large order swap entries, so a=
n
> 'orders' array is added for find_get_entries() and find_lock_entries() to
> obtain the order size of shmem swap entries, which will help in the relea=
se
> of shmem large folio swap entries.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/filemap.c  | 27 +++++++++++++++++++++++++--
>  mm/internal.h |  4 ++--
>  mm/shmem.c    | 17 +++++++++--------
>  mm/truncate.c |  8 ++++----
>  4 files changed, 40 insertions(+), 16 deletions(-)
>=20
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 37061aafd191..47fcd9ee6012 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2036,14 +2036,24 @@ static inline struct folio *find_get_entry(struct=
 xa_state *xas, pgoff_t max,
>   * Return: The number of entries which were found.
>   */
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
> -		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
> +		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices,
> +		int *orders)
>  {
>  	XA_STATE(xas, &mapping->i_pages, *start);
>  	struct folio *folio;
> +	int order;
> =20
>  	rcu_read_lock();
>  	while ((folio =3D find_get_entry(&xas, end, XA_PRESENT)) !=3D NULL) {
>  		indices[fbatch->nr] =3D xas.xa_index;
> +		if (orders) {
> +			if (!xa_is_value(folio))
> +				order =3D folio_order(folio);
> +			else
> +				order =3D xa_get_order(xas.xa, xas.xa_index);
> +
> +			orders[fbatch->nr] =3D order;
> +		}
>  		if (!folio_batch_add(fbatch, folio))
>  			break;
>  	}
> @@ -2056,6 +2066,8 @@ unsigned find_get_entries(struct address_space *map=
ping, pgoff_t *start,
>  		folio =3D fbatch->folios[idx];
>  		if (!xa_is_value(folio))
>  			nr =3D folio_nr_pages(folio);
> +		else if (orders)
> +			nr =3D 1 << orders[idx];
>  		*start =3D indices[idx] + nr;
>  	}
>  	return folio_batch_count(fbatch);
> @@ -2082,10 +2094,12 @@ unsigned find_get_entries(struct address_space *m=
apping, pgoff_t *start,
>   * Return: The number of entries which were found.
>   */
>  unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start=
,
> -		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
> +		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices,
> +		int *orders)
>  {
>  	XA_STATE(xas, &mapping->i_pages, *start);
>  	struct folio *folio;
> +	int order;
> =20
>  	rcu_read_lock();
>  	while ((folio =3D find_get_entry(&xas, end, XA_PRESENT))) {
> @@ -2099,9 +2113,16 @@ unsigned find_lock_entries(struct address_space *m=
apping, pgoff_t *start,
>  			if (folio->mapping !=3D mapping ||
>  			    folio_test_writeback(folio))
>  				goto unlock;
> +			if (orders)
> +				order =3D folio_order(folio);
>  			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
>  					folio);
> +		} else if (orders) {
> +			order =3D xa_get_order(xas.xa, xas.xa_index);
>  		}
> +
> +		if (orders)
> +			orders[fbatch->nr] =3D order;
>  		indices[fbatch->nr] =3D xas.xa_index;
>  		if (!folio_batch_add(fbatch, folio))
>  			break;
> @@ -2120,6 +2141,8 @@ unsigned find_lock_entries(struct address_space *ma=
pping, pgoff_t *start,
>  		folio =3D fbatch->folios[idx];
>  		if (!xa_is_value(folio))
>  			nr =3D folio_nr_pages(folio);
> +		else if (orders)
> +			nr =3D 1 << orders[idx];
>  		*start =3D indices[idx] + nr;
>  	}
>  	return folio_batch_count(fbatch);
> diff --git a/mm/internal.h b/mm/internal.h
> index 3419c329b3bc..0b5adb6c33cc 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -339,9 +339,9 @@ static inline void force_page_cache_readahead(struct =
address_space *mapping,
>  }
> =20
>  unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start=
,
> -		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
> +		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices, int *orders=
);
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
> -		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
> +		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices, int *orders=
);
>  void filemap_free_folio(struct address_space *mapping, struct folio *fol=
io);
>  int truncate_inode_folio(struct address_space *mapping, struct folio *fo=
lio);
>  bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0ac71580decb..28ba603d87b8 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -840,14 +840,14 @@ static void shmem_delete_from_page_cache(struct fol=
io *folio, void *radswap)
>   * Remove swap entry from page cache, free the swap and its page cache.
>   */
>  static int shmem_free_swap(struct address_space *mapping,
> -			   pgoff_t index, void *radswap)
> +			   pgoff_t index, void *radswap, int order)
>  {
>  	void *old;

Matthew Wilcox suggested [1] returning the number of pages freed in shmem_f=
ree_swap().

[1] https://lore.kernel.org/all/ZQRf2pGWurrE0uO+@casper.infradead.org/

Which I submitted here:
https://lore.kernel.org/all/20231028211518.3424020-5-da.gomez@samsung.com/

Do you agree with the suggestion? If so, could we update my patch to use
free_swap_and_cache_nr() or include that here?

> =20
>  	old =3D xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
>  	if (old !=3D radswap)
>  		return -ENOENT;
> -	free_swap_and_cache(radix_to_swp_entry(radswap));
> +	free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
>  	return 0;
>  }
> =20
> @@ -981,6 +981,7 @@ static void shmem_undo_range(struct inode *inode, lof=
f_t lstart, loff_t lend,
>  	pgoff_t end =3D (lend + 1) >> PAGE_SHIFT;
>  	struct folio_batch fbatch;
>  	pgoff_t indices[PAGEVEC_SIZE];
> +	int orders[PAGEVEC_SIZE];
>  	struct folio *folio;
>  	bool same_folio;
>  	long nr_swaps_freed =3D 0;
> @@ -996,15 +997,15 @@ static void shmem_undo_range(struct inode *inode, l=
off_t lstart, loff_t lend,
>  	folio_batch_init(&fbatch);
>  	index =3D start;
>  	while (index < end && find_lock_entries(mapping, &index, end - 1,
> -			&fbatch, indices)) {
> +			&fbatch, indices, orders)) {
>  		for (i =3D 0; i < folio_batch_count(&fbatch); i++) {
>  			folio =3D fbatch.folios[i];
> =20
>  			if (xa_is_value(folio)) {
>  				if (unfalloc)
>  					continue;
> -				nr_swaps_freed +=3D !shmem_free_swap(mapping,
> -							indices[i], folio);
> +				if (!shmem_free_swap(mapping, indices[i], folio, orders[i]))
> +					nr_swaps_freed +=3D 1 << orders[i];
>  				continue;
>  			}
> =20
> @@ -1058,7 +1059,7 @@ static void shmem_undo_range(struct inode *inode, l=
off_t lstart, loff_t lend,
>  		cond_resched();
> =20
>  		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
> -				indices)) {
> +				indices, orders)) {
>  			/* If all gone or hole-punch or unfalloc, we're done */
>  			if (index =3D=3D start || end !=3D -1)
>  				break;
> @@ -1072,12 +1073,12 @@ static void shmem_undo_range(struct inode *inode,=
 loff_t lstart, loff_t lend,
>  			if (xa_is_value(folio)) {
>  				if (unfalloc)
>  					continue;
> -				if (shmem_free_swap(mapping, indices[i], folio)) {
> +				if (shmem_free_swap(mapping, indices[i], folio, orders[i])) {
>  					/* Swap was replaced by page: retry */
>  					index =3D indices[i];
>  					break;
>  				}
> -				nr_swaps_freed++;
> +				nr_swaps_freed +=3D 1 << orders[i];
>  				continue;
>  			}
> =20
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 5ce62a939e55..3a4bc9dba451 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -352,7 +352,7 @@ void truncate_inode_pages_range(struct address_space =
*mapping,
>  	folio_batch_init(&fbatch);
>  	index =3D start;
>  	while (index < end && find_lock_entries(mapping, &index, end - 1,
> -			&fbatch, indices)) {
> +			&fbatch, indices, NULL)) {
>  		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
>  		for (i =3D 0; i < folio_batch_count(&fbatch); i++)
>  			truncate_cleanup_folio(fbatch.folios[i]);
> @@ -392,7 +392,7 @@ void truncate_inode_pages_range(struct address_space =
*mapping,
>  	while (index < end) {
>  		cond_resched();
>  		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
> -				indices)) {
> +				indices, NULL)) {
>  			/* If all gone from start onwards, we're done */
>  			if (index =3D=3D start)
>  				break;
> @@ -496,7 +496,7 @@ unsigned long mapping_try_invalidate(struct address_s=
pace *mapping,
>  	int i;
> =20
>  	folio_batch_init(&fbatch);
> -	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
> +	while (find_lock_entries(mapping, &index, end, &fbatch, indices, NULL))=
 {
>  		for (i =3D 0; i < folio_batch_count(&fbatch); i++) {
>  			struct folio *folio =3D fbatch.folios[i];
> =20
> @@ -622,7 +622,7 @@ int invalidate_inode_pages2_range(struct address_spac=
e *mapping,
> =20
>  	folio_batch_init(&fbatch);
>  	index =3D start;
> -	while (find_get_entries(mapping, &index, end, &fbatch, indices)) {
> +	while (find_get_entries(mapping, &index, end, &fbatch, indices, NULL)) =
{
>  		for (i =3D 0; i < folio_batch_count(&fbatch); i++) {
>  			struct folio *folio =3D fbatch.folios[i];
> =20
> --=20
> 2.39.3
>=20

Daniel=

