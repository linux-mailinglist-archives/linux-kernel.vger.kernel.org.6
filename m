Return-Path: <linux-kernel+bounces-196870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCAF8D62CC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08081C26A66
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34742158A12;
	Fri, 31 May 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GYyzhZfJ"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1111E493
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161559; cv=none; b=Qc3sPx6RXhAPw7qxHwJi02eZtkMV6JknYWm03Vcqtr+pxKbwUU3dswzeicpSp7bw0crZCqn7AaekN6gabs+AODxG3HK7c/ZHu0MPraGSGZVFaO1sYrAeP97bS0fAL1+8ekRWqpMwYES5FjGPCeF4bZYQtt6MS/3zcyJbdQCwOj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161559; c=relaxed/simple;
	bh=C5SzmOKgN6rmbepJMSBo4eSB7PzzKEb8qr3es5MWrFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=Tc9/DI/6LuV3BdAg3u7nB9bydWad0l3c7b+U7v6nLmRqZ5WzkDwGED6u0bLMt95+psBkxCzQQGqie7vxZXAa00G7xjYhNmxW+poB9o8xoDZujbl0MrrQ5+T6LpcjeJkicVJbYhz4ZJux/88FtW75xbkIdJFpA40xMg1hWyexvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GYyzhZfJ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240531131908euoutp014614be13e9d7cc9a3d008a2ae3146217~UlVSYiHtv3196631966euoutp01U
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:19:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240531131908euoutp014614be13e9d7cc9a3d008a2ae3146217~UlVSYiHtv3196631966euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717161548;
	bh=EAjo6+X1ykS4Iw3Ml7/oQ9RwzklG2o7Fm3B2Y1G8CeQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=GYyzhZfJxDiZfdv0bKTlwsIJ10dA2UWs9MJ1/Mp20UTemJUh+yuk7S9MfU7QGXsz0
	 DMxs9hENMeKlTs2z8nMXhDznhIjGkR5Zj6qAHLlX4J7TczTfCfgNdzzez0TekFa6rv
	 LUgMiN5LD5MIKAU53+U2v2q0eI0rcaAsWe3ToO7E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240531131908eucas1p1a25bd6884da3afa40df636ac864ddd7d~UlVSDeKxD2910329103eucas1p1l;
	Fri, 31 May 2024 13:19:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 25.30.09620.B4EC9566; Fri, 31
	May 2024 14:19:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240531131907eucas1p202d27bba103549bd735691235ee24885~UlVRn5lIY2019220192eucas1p2K;
	Fri, 31 May 2024 13:19:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240531131907eusmtrp293b2fe8a3d7193fe4695a21c6f5820d9~UlVRhbyzE1324813248eusmtrp2k;
	Fri, 31 May 2024 13:19:07 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-18-6659ce4b5e0d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.E5.08810.B4EC9566; Fri, 31
	May 2024 14:19:07 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240531131907eusmtip2ff05dd19eb7844ea433d43704801d923~UlVRSvbMs2622226222eusmtip2Q;
	Fri, 31 May 2024 13:19:07 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 31 May 2024 14:19:06 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Fri, 31 May
	2024 14:19:06 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: David Hildenbrand <david@redhat.com>
CC: Baolin Wang <baolin.wang@linux.alibaba.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "hughd@google.com" <hughd@google.com>,
	"willy@infradead.org" <willy@infradead.org>, "wangkefeng.wang@huawei.com"
	<wangkefeng.wang@huawei.com>, "ying.huang@intel.com" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "shy828301@gmail.com" <shy828301@gmail.com>,
	"ziy@nvidia.com" <ziy@nvidia.com>, "ioworker0@gmail.com"
	<ioworker0@gmail.com>, Pankaj Raghav <p.raghav@samsung.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
Thread-Topic: [PATCH v3 0/6] add mTHP support for anonymous shmem
Thread-Index: AQHasjX9yP1IBMh0VkC4Fzv01OfbabGxBpEAgAA+eQA=
Date: Fri, 31 May 2024 13:19:06 +0000
Message-ID: <vlkkfcyumveggkddb6d44f55gtx4qonoiijxyofa63mtmkuofv@uf4nbw3r5ysh>
In-Reply-To: <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB5D4E3C4E838F4EA7796AFF71CDB619@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7djPc7o+5yLTDB4GW3y+K2QxZ/0aNov/
	e48xWnxd/4vZ4umnPhaLRb+NLS7vmsNmcW/Nf1aLnt1TGS0WnFjMaNH4+T6jxe8fQImTsyaz
	WMw+eo/dgc9jzbw1jB47Z91l91iwqdSj5chbVo/NK7Q8Fu95yeSx6dMkdo8TM36zeOx8aOnR
	2/yOzeP9vqtsHp83yQXwRHHZpKTmZJalFunbJXBlzJn4nK1gq2nF09X/WBoYZ2p1MXJwSAiY
	SBz/Y9PFyMUhJLCCUWL98//sEM4XRomtX0+zQDifGSWuzjjH3MXICdYxadszJojEckaJP6um
	scNV7WhdxQrhnGGUmDphCZSzklFiVscnVpB+NgFNiX0nN7GD2CICGhKb2jaAzWUWmMsqcbA9
	BMQWFnCQmLm4lxWixlHiRtNVNgjbSuLZhZtMIDaLgKrEtuNvwXp5BXwlFhxcDjaTU8BO4l/T
	JbBeRgFZiUcrf7FDzBeXuPVkPhPED4ISi2bvgfpHTOLfrodsELaOxNnrTxghbAOJrUv3sUDY
	ShJfZv9igpijI7Fg9yc2CNtS4sv+SSwQtrbEsoWvoe4RlDg58wlU71ouica9vBC2i8TuvQ/Y
	IWxhiVfHt7BPYNSZheS8WUhWzEKyYhaSFbOQrFjAyLqKUTy1tDg3PbXYOC+1XK84Mbe4NC9d
	Lzk/dxMjMEWe/nf86w7GFa8+6h1iZOJgPMQowcGsJML7Kz0iTYg3JbGyKrUoP76oNCe1+BCj
	NAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoGJ+d0paYHwA9azM9/VLIl+lebW2mvWHVDy
	ubilXfDQkt3aSZk1fiKqb3jmBk75Pc1hfhn3SQlr1sY5iz6+Pbzz0CGhq/c++teaTrG5u9/3
	owb7+h2TUguyXt4qPc39JcmTdQ/H1YXHSxw4NpX33DwReDBG/e97ltNmjWqG0yVSn66e53z/
	zCH/F2F3FB3NHTr2S8lvn2c96+fJ9cVP9sfsOZnVmWjg8fz8tl1iiYfXfr4VszzPI5qjdV7y
	lw0hzBmuUxj+LKmZoqh5qeBeofXfZV2z97Tllv5cJRn3tWRPnVycvVpC2zMxHZ2Ty49yd05R
	iunQ49y3Iu+k0s617xXFvHftvLLXe/57xrUWej+XKbEUZyQaajEXFScCAMnizdcABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsVy+t/xe7re5yLTDI4vkbf4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
	s0lJzcksSy3St0vQy5gz8TlbwVbTiqer/7E0MM7U6mLk5JAQMJGYtO0ZE4gtJLCUUeLs7iiI
	uIzExi9XWSFsYYk/17rYuhi5gGo+MgIlDjFDOGcYJZ69b2aG6F7JKPFlcySIzSagKbHv5CZ2
	EFtEQENiU9sGsBpmgbmsEgfbQ0BsYQEHiZmLe1khahwlbjRdZYOwrSSeXbgJdhGLgKrEtuNv
	wXp5BXwlFhxczg6x6wSjxM2mAhCbU8BO4l/TJbA5jAKyEo9W/mKH2CUucevJfCaIDwQkluw5
	zwxhi0q8fPwP6jMdibPXnzBC2AYSW5fuY4GwlSS+zP7FBDFHR2LB7k9sELalxJf9k1ggbG2J
	ZQtfQ90mKHFy5hOWCYwys5CsnoWkfRaS9llI2mchaV/AyLqKUSS1tDg3PbfYUK84Mbe4NC9d
	Lzk/dxMjMP1tO/Zz8w7Gea8+6h1iZOJgPMQowcGsJML7Kz0iTYg3JbGyKrUoP76oNCe1+BCj
	KTDsJjJLiSbnAxNwXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD
	E3f9wcWbUxRe50RlNxj/WNdasOq/wqZ1zB2zEudc3fVc9FnrRdaU26F+pxjdfgoLeGvar+O0
	6FNtfdG6eod1dmB791EHf1Y9g/XpF7592/o3y/cv0+eN5gyhkuyVpz/On7NY+zxnXlkVh8I/
	/r2dKz+aJnk5LPsoJmltYNDCtOlq4MP6mYa7bpY4fHwTXbYkx6f9uURp96nDx5ef5tM2lbvW
	4exS6TFtzYfY8LlC+9OdHdcZrq5gDdZkSX3CpbVn6azPpcetG7z2s3xwLXgYLN3RKGFaM3He
	o3mf8gQF5X/NPfv/t8Gs9GlzUuaVJK8La1xXnWrr/+TOMu+ddiYJ5Z/i/334/0B1/t0dDxos
	lFiKMxINtZiLihMBIXcmywgEAAA=
X-CMS-MailID: 20240531131907eucas1p202d27bba103549bd735691235ee24885
X-Msg-Generator: CA
X-RootMTR: 20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
	<CGME20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a@eucas1p2.samsung.com>
	<f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>

On Fri, May 31, 2024 at 11:35:30AM +0200, David Hildenbrand wrote:
> On 30.05.24 04:04, Baolin Wang wrote:
> > Anonymous pages have already been supported for multi-size (mTHP) alloc=
ation
> > through commit 19eaf44954df, that can allow THP to be configured throug=
h the
> > sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepag=
e-XXkb/enabled'.
> >=20
> > However, the anonymous shmem will ignore the anonymous mTHP rule config=
ured
> > through the sysfs interface, and can only use the PMD-mapped THP, that =
is not
> > reasonable. Many implement anonymous page sharing through mmap(MAP_SHAR=
ED |
> > MAP_ANONYMOUS), especially in database usage scenarios, therefore, user=
s expect
> > to apply an unified mTHP strategy for anonymous pages, also including t=
he
> > anonymous shared pages, in order to enjoy the benefits of mTHP. For exa=
mple,
> > lower latency than PMD-mapped THP, smaller memory bloat than PMD-mapped=
 THP,
> > contiguous PTEs on ARM architecture to reduce TLB miss etc.
> >=20
> > The primary strategy is similar to supporting anonymous mTHP. Introduce
> > a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
> > which can have all the same values as the top-level
> > '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
> > additional "inherit" option. By default all sizes will be set to "never=
"
> > except PMD size, which is set to "inherit". This ensures backward compa=
tibility
> > with the anonymous shmem enabled of the top level, meanwhile also allow=
s
> > independent control of anonymous shmem enabled for each mTHP.
> >=20
> > Use the page fault latency tool to measure the performance of 1G anonym=
ous shmem
> > with 32 threads on my machine environment with: ARM64 Architecture, 32 =
cores,
> > 125G memory:
> > base: mm-unstable
> > user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> > 0.04s        3.10s         83516.416                  2669684.890
> >=20
> > mm-unstable + patchset, anon shmem mTHP disabled
> > user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> > 0.02s        3.14s         82936.359                  2630746.027
> >=20
> > mm-unstable + patchset, anon shmem 64K mTHP enabled
> > user-time    sys_time    faults_per_sec_per_cpu     faults_per_sec
> > 0.08s        0.31s         678630.231                 17082522.495
> >=20
> >  From the data above, it is observed that the patchset has a minimal im=
pact when
> > mTHP is not enabled (some fluctuations observed during testing). When e=
nabling 64K
> > mTHP, there is a significant improvement of the page fault latency.
>=20
> Let me summarize the takeaway from the bi-weekly MM meeting as I understo=
od
> it, that includes Hugh's feedback on per-block tracking vs. mTHP:

Thanks David for the summary. Please, find below some follow up questions.

I want understand if zeropage scanning overhead is preferred over per-block
tracking complexity or if we still need to verify this.

>=20
> (1) Per-block tracking
>=20
> Per-block tracking is currently considered unwarranted complexity in
> shmem.c. We should try to get it done without that. For any test cases th=
at
> fail, we should consider if they are actually valid for shmem.

I agree it was unwarranted complexity but only if this is just to fix lseek=
() as
we can simply make the test pass by checking if holes are reported as data.=
 That
would be the minimum required for lseek() to be compliant with the syscall.

How can we use per-block tracking for reclaiming memory and what changes wo=
uld
be needed? Or is per-block really a non-viable option?

Clearly, if per-block is viable option, shmem_fault() bug would required to=
 be
fixed first. Any ideas on how to make it reproducible?

The alternatives discussed where sub-page refcounting and zeropage scanning=
.
The first one is not possible (IIUC) because of a refactor years back that
simplified the code and also requires extra complexity. The second option w=
ould
require additional overhead as we would involve scanning.

>=20
> To optimize FALLOC_FL_PUNCH_HOLE for the cases where splitting+freeing
> is not possible at fallcoate() time, detecting zeropages later and
> retrying to split+free might be an option, without per-block tracking.

>=20
> (2) mTHP controls
>=20
> As a default, we should not be using large folios / mTHP for any shmem, j=
ust
> like we did with THP via shmem_enabled. This is what this series currentl=
y
> does, and is aprt of the whole mTHP user-space interface design.

That was clear for me too. But what is the reason we want to boot in 'safe
mode'? What are the implications of not respecing that?

>=20
> Further, the mTHP controls should control all of shmem, not only "anonymo=
us
> shmem".

As I understood from the call, mTHP with sysctl knobs is preferred over
optimistic falloc/write allocation? But is still unclear to me why the form=
er
is preferred.

Is large folios a non-viable option?

>=20
> Also, we should properly fallback within the configured sizes, and not ju=
mp
> "over" configured sizes. Unless there is a good reason.
>=20
> (3) khugepaged
>=20
> khugepaged needs to handle larger folios properly as well. Until fixed,
> using smaller THP sizes as fallback might prohibit collapsing a PMD-sized
> THP later. But really, khugepaged needs to be fixed to handle that.
>=20
> (4) force/disable
>=20
> These settings are rather testing artifacts from the old ages. We should =
not
> add them to the per-size toggles. We might "inherit" it from the global o=
ne,
> though.
>=20
> "within_size" might have value, and especially for consistency, we should
> have them per size.
>=20
>=20
>=20
> So, this series only tackles anonymous shmem, which is a good starting
> point. Ideally, we'd get support for other shmem (especially during fault
> time) soon afterwards, because we won't be adding separate toggles for th=
at
> from the interface POV, and having inconsistent behavior between kernel
> versions would be a bit unfortunate.
>=20
>=20
> @Baolin, this series likely does not consider (4) yet. And I suggest we h=
ave
> to take a lot of the "anonymous thp" terminology out of this series,
> especially when it comes to documentation.
>=20
> @Daniel, Pankaj, what are your plans regarding that? It would be great if=
 we
> could get an understanding on the next steps on !anon shmem.

I realize I've raised so many questions, but it's essential for us to grasp=
 the
mm concerns and usage scenarios. This understanding will provide clarity on=
 the
direction regarding folios for !anon shmem.

>=20
> --=20
> Cheers,
>=20
> David / dhildenb
>=20

Daniel=

