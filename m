Return-Path: <linux-kernel+bounces-208408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F69024AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530231C21529
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C775132132;
	Mon, 10 Jun 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gNS0cPAE"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693424D8A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031212; cv=none; b=bRugqESUz3ZEpLGMQO8k9nvGzwsfxROn5vwhinI0Y65jhnAvbO8qHeffH/kLWnMwGlPKOpSUBwlnkcsGG6/2jlJOYYNpHGCTCcLrzWY2ZGo9aEyshHqXoHA6rm9z219hovh/MPIYJIFS4bHmsecbD/P69jATTFAAYGTfhguvUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031212; c=relaxed/simple;
	bh=cFCtKmibtnEofTi3RJ4LEudHKjP5jQ0jx9+QlvPJdt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=IxGSEOc9T6nmawnC/3LLj9cbaj99DrGGr3qfLknY2WHZGbF4J0SAU48G8kbQ/46lSrJWr6DsAXQpifAvzW5UXeiLoC3yd5UQu812xg9QiYVQyA6/i0DD2cqlx8uHg4w4bVdi1xmdEYv8XSV6KPfURnFz6s+jqwFHZoCAGQtygCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gNS0cPAE; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240610145328euoutp020a6bf53500ca534f997f77b09a0c06b0~XrEgGYpAz2464324643euoutp02g
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:53:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240610145328euoutp020a6bf53500ca534f997f77b09a0c06b0~XrEgGYpAz2464324643euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718031208;
	bh=o9UpQ8SinD6WVcDO33xVDCTBVusEJQKNKyZBqbuV5A0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=gNS0cPAEa3WOB5qEC5DXD6pRnB1FIVFjO8YrNdLwQeOfXmqfChcu4Aix13FOG6/X9
	 Cdmk8FCBIFhsihrk5pkLWbKKQmmjXToWy1E+BJtGz/HaIoh4wN/jl+cMRFfyP0Wy4/
	 Zr/Q7Xzn9d6OYT8XC/3Vfh/qT6H4G7FyEklkJQ74=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240610145327eucas1p1dd85462827a14c8df503fabed8349988~XrEfzkLL90858308583eucas1p13;
	Mon, 10 Jun 2024 14:53:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id C0.A3.09620.76317666; Mon, 10
	Jun 2024 15:53:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240610145327eucas1p1bb32a985f8eaddf8cdda0b5415c1868c~XrEfYjiPx0884708847eucas1p1K;
	Mon, 10 Jun 2024 14:53:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610145327eusmtrp112e0bdac246d1499209a8cd444a47dc3~XrEfX28Vw2921429214eusmtrp1Y;
	Mon, 10 Jun 2024 14:53:27 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-da-66671367850f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 82.1E.09010.76317666; Mon, 10
	Jun 2024 15:53:27 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240610145327eusmtip2cf537ea4cf511ac2d8cd0ac1e4292a7d~XrEfLZTwF0509505095eusmtip2W;
	Mon, 10 Jun 2024 14:53:27 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 10 Jun 2024 15:53:22 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 10 Jun
	2024 15:53:22 +0100
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
Subject: Re: [PATCH 4/7] mm: shmem: extend shmem_partial_swap_usage() to
 support large folio swap
Thread-Topic: [PATCH 4/7] mm: shmem: extend shmem_partial_swap_usage() to
	support large folio swap
Thread-Index: AQHauAk6tPOy90LG0EqwmRY04o2YSLHBCwmA
Date: Mon, 10 Jun 2024 14:53:22 +0000
Message-ID: <qlk2dpg2fmro5vzjks45ciwt3qk6nzlurfmlqnjr4ecskgg7ln@w5ba55tgtcsb>
In-Reply-To: <358924679107339e6b17a5d8b1b2e10ae6306227.1717673614.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FF719F11960B546A2F926BF1CD6BC46@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7djPc7rpwulpBo3LDCw+3xWymLN+DZvF
	/73HGC2aHjxisvi6/hezxdNPfSwWi34bW1zeNYfN4t6a/6wWPbunMlosOLGY0aLx831Gi98/
	gBInZ01msZh99B67A7/HmnlrGD12zrrL7rFgU6lHy5G3rB6bV2h5LN7zkslj06pONo9Nnyax
	e5yY8ZvFY+dDS4/e5ndsHu/3XWXz+LxJLoA3issmJTUnsyy1SN8ugSuj++BC1oKNnBVTr8g2
	MC5g72Lk5JAQMJGY+fwLI4gtJLCCUeL055ouRi4g+wujxM0lT9khnM+MEq9mnWKF6Xj64ABU
	YjmjxMftJ5jhqnZvbWCEcM4wSvR+/cwK4axklHj65ApYP5uApsS+k5uA+jk4RAT0JXrn+oLU
	MAscYpVoPHsO7BJhgWSJ/5NmgtWLCKRITP8+mQnCNpKYfGwiG4jNIqAqsf3lPWaQObwCvhLn
	/kaChDmByht6ZoG1MgrISjxa+QvsUWYBcYlbT+YzQbwgKLFo9h5mCFtM4t+uh2wQto7E2etP
	GCFsA4mtS/exQNiKEh3HbrJBzNGRWLD7E5RtKbFl50oWCFtbYtnC12AzeYHmn5z5BKp3L5fE
	nuMlELaLxJUJy6H2Cku8Or6FfQKjziwk581CsmIWkhWzkKyYhWTFAkbWVYziqaXFuempxcZ5
	qeV6xYm5xaV56XrJ+bmbGIFJ8/S/4193MK549VHvECMTB+MhRgkOZiURXqGM5DQh3pTEyqrU
	ovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGJuanrBIu60tSbM+KyHT6
	hDuc2xhctUEnjO3ervrrf49GiXbf//tf03nzk7msH+z32E/xuyV400P2b9Sqxm8nXf0tn+5R
	vNYpZ+g/edFHVUG3b1xfr5S+yGhQrmxfHMd26MK2ZZMW/mmNYlP6z1uSFcXzoktLwXOGrPK9
	x+umVm9ub1yaJTE7gmtK53m/7EVphpLf+y1lVgWndL5epXSiUbi4b/1Cg9VrDJfZvn37efKq
	OH2vZf+v6Zw7GeKjlJ/XKy7heEM3/fwZ+2pnxpJfJdl2UhL5u7byM0/8e1J715MFS5d97fh/
	6sBDPqvkDdtzJu6xlexdubdEbf2UtLzwz1avHutKls59Ias0/+uj20osxRmJhlrMRcWJANKE
	EXkJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsVy+t/xe7rpwulpBjPWi1p8vitkMWf9GjaL
	/3uPMVo0PXjEZPF1/S9mi6ef+lgsFv02tri8aw6bxb01/1ktenZPZbRYcGIxo0Xj5/uMFr9/
	ACVOzprMYjH76D12B36PNfPWMHrsnHWX3WPBplKPliNvWT02r9DyWLznJZPHplWdbB6bPk1i
	9zgx4zeLx86Hlh69ze/YPN7vu8rm8XmTXABvlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
	nqGxeayVkamSvp1NSmpOZllqkb5dgl5G98GFrAUbOSumXpFtYFzA3sXIySEhYCLx9MEBIJuL
	Q0hgKaNEz5NdUAkZiY1frrJC2MISf651sUEUfWSUuPS8F6xISOAMo8SNve4QiZWMEm1/XoEl
	2AQ0Jfad3ARkc3CICOhL9M71BalhFjjEKtF49hwjSI2wQLLE/0kzwTaICKRIbO46wQ5hG0lM
	PjaRDcRmEVCV2P7yHjPIHF4BX4lzfyMhds1ilLj/7ShYLydQb0PPLDCbUUBW4tHKX2BzmAXE
	JW49mc8E8YGAxJI955khbFGJl4//QX2mI3H2+hNGCNtAYuvSfSwQtqJEx7GbbBBzdCQW7P4E
	ZVtKbNm5kgXC1pZYtvA12ExeAUGJkzOfsExglJmFZPUsJO2zkLTPQtI+C0n7AkbWVYwiqaXF
	uem5xUZ6xYm5xaV56XrJ+bmbGIEpcduxn1t2MK589VHvECMTB+MhRgkOZiURXqGM5DQh3pTE
	yqrUovz4otKc1OJDjKbAsJvILCWanA9Mynkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp
	2ampBalFMH1MHJxSDUzbp/qVvln0IqZl1dQtG4rnvlz2xC+Hp6vMN+jexcrWLO5zip9YWCoa
	DbTy7zYsbNKT4ZoQwH+BX0hv/vVJjmHcCju+HZJVdrGYItDcUJgn8VDI8Gak8ey/3B/qP2js
	fTYrpNdlvuvhY81Ldxfv03x/uaBYu0bloFKbN9MFz63FXlfLD8eGdJ552NS77MP9S3E9RmHS
	NXpbxf4Ybqx+Gl7zZLPm3Kv/Sud47FcOLbNj3/CiUc1NuzgyJz2gWM8s0nhVBPdCntLtZ60V
	HP38JzFGK++WdHp1LtFU8UV+aLhLwFLJs6/ai5dm8Qe9qtl0snZO4hN/5ZBbM1901LWwZsu1
	/2GquVR1aeFflmAPJZbijERDLeai4kQAgaTV1RIEAAA=
X-CMS-MailID: 20240610145327eucas1p1bb32a985f8eaddf8cdda0b5415c1868c
X-Msg-Generator: CA
X-RootMTR: 20240610145327eucas1p1bb32a985f8eaddf8cdda0b5415c1868c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240610145327eucas1p1bb32a985f8eaddf8cdda0b5415c1868c
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
	<358924679107339e6b17a5d8b1b2e10ae6306227.1717673614.git.baolin.wang@linux.alibaba.com>
	<CGME20240610145327eucas1p1bb32a985f8eaddf8cdda0b5415c1868c@eucas1p1.samsung.com>

Hi Baolin,
On Thu, Jun 06, 2024 at 07:58:54PM +0800, Baolin Wang wrote:
> To support shmem large folio swapout in the following patches, using
> xa_get_order() to get the order of the swap entry to calculate the swap
> usage of shmem.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/shmem.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/shmem.c b/mm/shmem.c
> index eefdf5c61c04..0ac71580decb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -865,13 +865,16 @@ unsigned long shmem_partial_swap_usage(struct addre=
ss_space *mapping,
>  	struct page *page;
>  	unsigned long swapped =3D 0;
>  	unsigned long max =3D end - 1;
> +	int order;
> =20
>  	rcu_read_lock();
>  	xas_for_each(&xas, page, max) {
>  		if (xas_retry(&xas, page))
>  			continue;
> -		if (xa_is_value(page))
> -			swapped++;
> +		if (xa_is_value(page)) {
> +			order =3D xa_get_order(xas.xa, xas.xa_index);
> +			swapped +=3D 1 << order;

I'd get rid of order and simply do:

	swapped +=3D 1UL << xa_get_order()


> +		}
>  		if (xas.xa_index =3D=3D max)
>  			break;
>  		if (need_resched()) {
> --=20
> 2.39.3
> =

