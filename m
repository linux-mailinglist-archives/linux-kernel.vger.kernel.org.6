Return-Path: <linux-kernel+bounces-173159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B34F8BFC4C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E142B286942
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5CB8248E;
	Wed,  8 May 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V07IgPI1"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0B823BF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168385; cv=none; b=q6H3EsenRMuYwhBdTdUrGl0pC622QXonZBODHyPosmoG0GoviTqNGLvP1WSzVF1sagQHJCy5qg+5/QwnQ7XUj3LaqKKmVNXjUhbZWNDBRjQ+Lrek/GICQash6wflPDTRfNJHzMkuzOxl215136CohAaxrCUUKkp2AObGKPehcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168385; c=relaxed/simple;
	bh=9Qe5pZ+rjtqEDk3v9IAjxKJmQfwIKq6U4XC6r7G4KKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=HI40etRgMaATLKZ9gEAvQ+mDLVUV+v/++NuOIahkY1G34Uieq2BDoJ74X46kC563bm1oiumqCifSSqxpwYrRGfEZR4IxJo1OIi28421FMLZ6YSJJMQ78X8Mg8sq85q3e9uffTG3CxJCEe8rF+gfG9Apa1kyPMx7AxVpRB5AmIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=V07IgPI1; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240508113935euoutp01aa688a1142f61dad10a612ea541b5dd0~NgIzB0Bg62121021210euoutp01j
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:39:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240508113935euoutp01aa688a1142f61dad10a612ea541b5dd0~NgIzB0Bg62121021210euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715168375;
	bh=xkZiCUdvs+R8pen3miw27jBfj4tN5EP5emATPQt1vhg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=V07IgPI1yRCapIBFrxgveLc6RXmefaDuy+nqGGycBJKrx+8+AjR6/oZWfuZp5gsID
	 EK+AEF86iq4k1wwKZm7Ev+mqm8mzeEsE+ESouqlbRrWXLLsYBTlIr/6u9HDI6vxbgO
	 A1c5NDAHRqA8LVVhkLDASP4AVpw0xXeoW2O+NUBg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240508113934eucas1p29aeb818176adb3c58f9f020e5603507e~NgIyscc0X1611916119eucas1p22;
	Wed,  8 May 2024 11:39:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.EA.09875.6746B366; Wed,  8
	May 2024 12:39:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5~NgIyTK7Eo0806308063eucas1p1t;
	Wed,  8 May 2024 11:39:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240508113934eusmtrp179b478b5420c82c955c10898a5dc3d73~NgIySQ--01031510315eusmtrp1z;
	Wed,  8 May 2024 11:39:34 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-47-663b64763b96
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id AE.CB.09010.6746B366; Wed,  8
	May 2024 12:39:34 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240508113934eusmtip2a12ef41e3ebb50ec75e16f4e922f6f9a~NgIyGc4n81285312853eusmtip2E;
	Wed,  8 May 2024 11:39:34 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Wed, 8 May 2024 12:39:33 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Wed, 8 May
	2024 12:39:33 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hughd@google.com" <hughd@google.com>, "willy@infradead.org"
	<willy@infradead.org>, "david@redhat.com" <david@redhat.com>,
	"ioworker0@gmail.com" <ioworker0@gmail.com>, "wangkefeng.wang@huawei.com"
	<wangkefeng.wang@huawei.com>, "ying.huang@intel.com" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "shy828301@gmail.com" <shy828301@gmail.com>,
	"ziy@nvidia.com" <ziy@nvidia.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
Thread-Topic: [PATCH 0/8] add mTHP support for anonymous shmem
Thread-Index: AQHaoTxlCSlVdbHh/EKIyyNA4DF78w==
Date: Wed, 8 May 2024 11:39:32 +0000
Message-ID: <fqtaxc5pgu3zmvbdad4w6xty5iozye7v5z2b5ckqcjv273nz7b@hhdrjwf6rai3>
In-Reply-To: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8E4F56FA1AA5D4F90F8EFF2A1EDEC7D@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7djP87plKdZpBjNfalh8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktFpxYzGjR+Pk+o8XvH0CJk7Mm
	s1jMPnqP3YHPY828NYweO2fdZfdYsKnUo+XIW1aPzSu0PBbvecnksenTJHaPEzN+s3jsfGjp
	0dv8js3j/b6rbB6fN8kF8ERx2aSk5mSWpRbp2yVwZTz/eImtYJtKxbFbnxkbGH9LdzFyckgI
	mEgcm3mYvYuRi0NIYAWjxPUdL5kgnC+MEr82XYDKfGaUONj+lLmLkQOs5fcCUYj4ckaJq7dv
	sMEVHX7zAKrjNKPEnlfTmOEG376zkRVkI5uApsS+k5vYQUaJCOhL9M71BalhFvjIItGzvo8J
	pEZYwFZi0fkfbCC2iICdROPCaSwQtp7E8S8tYHNYBFQkvj7axwhi8wr4Smy4NBOsl1PAUWLe
	3OPMIDajgKzEo5W/2EFsZgFxiVtP5jNBfC0osWj2HmYIW0zi366HbBC2jsTZ608YIWwDia1L
	97FA2IoSHcduskHM0ZFYsPsTlG0p0XLiCguErS2xbOFrZoh7BCVOznzCAvKYhMBOLoklbZ1Q
	g1wk/k1rglosLPHq+Bb2CYw6s5DcNwvJjllIdsxCsmMWkh0LGFlXMYqnlhbnpqcWG+WllusV
	J+YWl+al6yXn525iBKbJ0/+Of9nBuPzVR71DjEwcjIcYJTiYlUR4j7abpwnxpiRWVqUW5ccX
	leakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUw1UQynDvbtDnnXWk7XwdLXYTn
	ma8Hr629ockTIHtg5r9iXakQqdtSlUz/I9OsJs6ZJzG39ndUGrvnW5E91cJN+xr3LJ6TobRy
	lotEsJao0O3iPnPeTfF+3lFR7yMO+8qxzG2p4t82v05tVfjyjzetzn75vqV48gyutWtF12yO
	qX3A/1hbkWOdzu1Am43pX3rnv81xrXx00e7zz8qPumUFNeHJWUaeW/rzV1c6KuvoOzg/2Ml4
	wHvZsUsJe/cySKuc4Sk6cPqGv5qPZGzEI0kJ3ij2mczHBDJ0ji5Z+8rtEd/zDc3p1S51+0XX
	szZ823Xp9CSLF+Ibb16IWDHt7G1HqW+CPvqdkdxTRcU43xkrsRRnJBpqMRcVJwIAg93gqAIE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsVy+t/xe7plKdZpBh2/+C0+3xWymLN+DZvF
	/73HGC2+rv/FbPH0Ux+LxaLfxhaXd81hs7i35j+rRc/uqYwWC04sZrRo/Hyf0eL3D6DEyVmT
	WSxmH73H7sDnsWbeGkaPnbPusnss2FTq0XLkLavH5hVaHov3vGTy2PRpErvHiRm/WTx2PrT0
	6G1+x+bxft9VNo/Pm+QCeKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTt
	bFJSczLLUov07RL0Mp5/vMRWsE2l4titz4wNjL+luxg5OCQETCR+LxDtYuTkEBJYyijx7r4p
	iC0hICOx8ctVVghbWOLPtS62LkYuoJqPjBJ3zv1kh3BOM0rMX9HEDNG9glGiZa0diM0moCmx
	7+QmdpAFIgL6Er1zfUHqmQXes0ismdfFDlIjLGArsej8DzYQW0TATqJx4TQWCFtP4viXFrDN
	LAIqEl8f7WMEsXkFfCU2XJrJBLHLQWLWmQawGk4BR4l5c4+D3cAoICvxaOUvsPnMAuISt57M
	Z4L4QEBiyZ7zzBC2qMTLx/+gPtOROHv9CSOEbSCxdek+FghbUaLj2E02iDk6Egt2f4KyLSVa
	TlxhgbC1JZYtfM0McZugxMmZT1gmMMrMQrJ6FpL2WUjaZyFpn4WkfQEj6ypGkdTS4tz03GIj
	veLE3OLSvHS95PzcTYzA5Lft2M8tOxhXvvqod4iRiYPxEKMEB7OSCO/RdvM0Id6UxMqq1KL8
	+KLSnNTiQ4ymwLCbyCwlmpwPTL95JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWp
	RTB9TBycUg1MBvs7dnN0SUqX2iy1OqC/U+L8ZpGub4wCuRw75mkWtlwoqJrK1ackeMc1w/3D
	rerVkv1q4Vplad9K/6maHp7e97Xrmur0JYd7buz4vGz+UbmNAu3y+innLFbfbvs6KW/P6lRt
	nZ1zb3B+kC2bxSpxVzzjafWZquniusfN/7s6GkWyvHyxKj+cbxrvD9HV2pHa2mLZ3ZvX/vp9
	bNWN2zFtCQuD+G72vtiXYs8VnGb66QTLXTHzI8efVelsiTDZJN72yvnR7vq4hFUSJRMrWy5V
	7st5um6nhq2NwNmoVI8dK+5+5rz8fhbTu18dnjwcq3/OV5BlbmqTOfbUbMV8P7nir8HGDiEm
	3jf/nKyIcKhTYinOSDTUYi4qTgQA41PtnQcEAAA=
X-CMS-MailID: 20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5
X-Msg-Generator: CA
X-RootMTR: 20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
	<CGME20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5@eucas1p1.samsung.com>

On Mon, May 06, 2024 at 04:46:24PM +0800, Baolin Wang wrote:
> Anonymous pages have already been supported for multi-size (mTHP) allocat=
ion
> through commit 19eaf44954df, that can allow THP to be configured through =
the
> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-=
XXkb/enabled'.
>=20
> However, the anonymous shared pages will ignore the anonymous mTHP rule
> configured through the sysfs interface, and can only use the PMD-mapped
> THP, that is not reasonable. Many implement anonymous page sharing throug=
h
> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
> therefore, users expect to apply an unified mTHP strategy for anonymous p=
ages,
> also including the anonymous shared pages, in order to enjoy the benefits=
 of
> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloa=
t
> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB mi=
ss etc.
>=20
> The primary strategy is similar to supporting anonymous mTHP. Introduce
> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
> which can have all the same values as the top-level
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
> additional "inherit" option. By default all sizes will be set to "never"
> except PMD size, which is set to "inherit". This ensures backward compati=
bility
> with the shmem enabled of the top level, meanwhile also allows independen=
t
> control of shmem enabled for each mTHP.

I'm trying to understand the adoption of mTHP and how it fits into the adop=
tion
of (large) folios that the kernel is moving towards. Can you, or anyone inv=
olved
here, explain this? How much do they overlap, and can we benefit from havin=
g
both? Is there any argument against the adoption of large folios here that =
I
might have missed?

>=20
> Use the page fault latency tool to measure the performance of 1G anonymou=
s shmem
> with 32 threads on my machine environment with: ARM64 Architecture, 32 co=
res,
> 125G memory:
> base: mm-unstable
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.04s        3.10s         83516.416                  2669684.890
>=20
> mm-unstable + patchset, anon shmem mTHP disabled
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.02s        3.14s         82936.359                  2630746.027
>=20
> mm-unstable + patchset, anon shmem 64K mTHP enabled
> user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> 0.08s        0.31s         678630.231                 17082522.495
>=20
> From the data above, it is observed that the patchset has a minimal impac=
t when
> mTHP is not enabled (some fluctuations observed during testing). When ena=
bling 64K
> mTHP, there is a significant improvement of the page fault latency.
>=20
> TODO:
>  - Support mTHP for tmpfs.
>  - Do not split the large folio when share memory swap out.
>  - Can swap in a large folio for share memory.
>=20
> Changes from RFC:
>  - Rebase the patch set against the new mm-unstable branch, per Lance.
>  - Add a new patch to export highest_order() and next_order().
>  - Add a new patch to align mTHP size in shmem_get_unmapped_area().
>  - Handle the uffd case and the VMA limits case when building mapping for
>    large folio in the finish_fault() function, per Ryan.
>  - Remove unnecessary 'order' variable in patch 3, per Kefeng.
>  - Keep the anon shmem counters' name consistency.
>  - Modify the strategy to support mTHP for anonymous shmem, discussed wit=
h
>    Ryan and David.
>  - Add reviewed tag from Barry.
>  - Update the commit message.
>=20
> Baolin Wang (8):
>   mm: move highest_order() and next_order() out of the THP config
>   mm: memory: extend finish_fault() to support large folio
>   mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
>   mm: shmem: add THP validation for PMD-mapped THP related statistics
>   mm: shmem: add multi-size THP sysfs interface for anonymous shmem
>   mm: shmem: add mTHP support for anonymous shmem
>   mm: shmem: add mTHP size alignment in shmem_get_unmapped_area
>   mm: shmem: add mTHP counters for anonymous shmem
>=20
>  Documentation/admin-guide/mm/transhuge.rst |  29 ++
>  include/linux/huge_mm.h                    |  35 ++-
>  mm/huge_memory.c                           |  17 +-
>  mm/memory.c                                |  43 ++-
>  mm/shmem.c                                 | 335 ++++++++++++++++++---
>  5 files changed, 387 insertions(+), 72 deletions(-)
>=20
> --=20
> 2.39.3
> =

