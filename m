Return-Path: <linux-kernel+bounces-174816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D668C155F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8632F1F230A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17D127E27;
	Thu,  9 May 2024 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b13m93u4"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D97F7DD
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282294; cv=none; b=o9D0xARI/7yPMnWzXFmKC3sj+BRM1mr1gaK/ImadqRwI3FINVogdmeuPMGWmMpkfSf3v0R9PQXGpBw3ceCKX33jz8zNcBHX1lE5IvcdWRr4Bb6wvDRc2t6SdhCu5IG+94/nR+aOI+hzdT6BqmjjDtpXlRw2DEoMoTo7Z41cPDqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282294; c=relaxed/simple;
	bh=vqONeDvcgdkJM1J9mpFNx3A6NOv5X1RScOsC2jgEsJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=b9MK5BtAh4ceXFEsBAOdWAE6IE/LR9TFhdd0Raoirldz2joI9tl4NN1hpRdPcFbnFrkgfxDtyZvMXnyQHzQwsfZ1XozSjwlCKK34eKntKdBgn86Xy373Iu2+XAymvwkwVvWdm0wrKtWVM5Zb5/NJRNujiroR/GsG3wjt3lo+MnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=b13m93u4; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240509191806euoutp02d9759c0a69ef43f1ee17f8ffe0124621~N6CbWrZYk1210312103euoutp02h
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 19:18:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240509191806euoutp02d9759c0a69ef43f1ee17f8ffe0124621~N6CbWrZYk1210312103euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715282286;
	bh=vqONeDvcgdkJM1J9mpFNx3A6NOv5X1RScOsC2jgEsJA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=b13m93u48H/8WyyPPu93nEKul9vRAUVdoMhad8CI3Xv70N+D9KN3qUMwBB9F6aB9d
	 Ah11/6YSMczWcIvZaUhQE401o8sxBqd4P+ftA7W4NHnaNDYES0n6mI1Cq3zIYdZYhs
	 XMSOdoc9QiYnfSaJ8nuQZnb/1754Ao/AshrPMogA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240509191806eucas1p27abe25dea6bd2327ec2a094e63311ab0~N6Ca8RkpG0373903739eucas1p2f;
	Thu,  9 May 2024 19:18:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.49.09620.E612D366; Thu,  9
	May 2024 20:18:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240509191805eucas1p285e8681c5a48d9ec9261839016720a32~N6Cah-OiA0375903759eucas1p2b;
	Thu,  9 May 2024 19:18:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240509191805eusmtrp2c2eb326e47f85bda8b3bae4396fd63d3~N6CahZc4o2950329503eusmtrp2b;
	Thu,  9 May 2024 19:18:05 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-10-663d216eb4a8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 66.35.09010.D612D366; Thu,  9
	May 2024 20:18:05 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240509191805eusmtip1236de4a4534946a21b94901ab2cfeec3~N6CaSeGio0706307063eusmtip1N;
	Thu,  9 May 2024 19:18:05 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Thu, 9 May 2024 20:18:04 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Thu, 9 May
	2024 20:18:04 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: David Hildenbrand <david@redhat.com>
CC: Baolin Wang <baolin.wang@linux.alibaba.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "hughd@google.com" <hughd@google.com>,
	"willy@infradead.org" <willy@infradead.org>, "ioworker0@gmail.com"
	<ioworker0@gmail.com>, "wangkefeng.wang@huawei.com"
	<wangkefeng.wang@huawei.com>, "ying.huang@intel.com" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "shy828301@gmail.com" <shy828301@gmail.com>,
	"ziy@nvidia.com" <ziy@nvidia.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
Thread-Topic: [PATCH 0/8] add mTHP support for anonymous shmem
Thread-Index: AQHaoTxlCSlVdbHh/EKIyyNA4DF787GNKsyAgAAqDYCAACtYgIABt8sA
Date: Thu, 9 May 2024 19:18:03 +0000
Message-ID: <npn7qn4lmmyn5ed5zilcgoxr7z2immt6cwidma36nlufq2n56j@uq4maeua5yas>
In-Reply-To: <de9f9d07-6534-419b-86a8-628e13020c1e@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <480D98AC2B091542A5BBA7A1610C0D2D@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7djPc7p5irZpBg9/sVp8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktFpxYzGjR+Pk+o8XvH0CJk7Mm
	s1jMPnqP3YHPY828NYweO2fdZfdYsKnUo+XIW1aPzSu0PBbvecnksenTJHaPEzN+s3jsfGjp
	0dv8js3j/b6rbB6fN8kF8ERx2aSk5mSWpRbp2yVwZRw8f5ulYJ5xxfF1XYwNjJs0uhg5OSQE
	TCRWb17I3MXIxSEksIJRYtnlb6wQzhdGifevLkBlPjNKXFw4gxmm5fmePVCJ5YwSx2a9Z4er
	ur/sAhuEc5pRYtuElQiTF849wQjSzyagKbHv5CZ2EFtEQENiU9sGsCJmge8sEr3/T4ElhAVs
	JRad/8EGUWQn0bhwGguE7SbxYOZDVhCbRUBF4t7Jf2A2r4CvxKXNW8B6OYHq756YC2YzCshK
	PFr5C8xmFhCXuPVkPhPEE4ISi2bvgXpITOLfrodsELaOxNnrTxghbAOJrUv3sUDYyhLr37Ux
	QczRkViw+xNQPTuQbSnRVQoR1ZZYtvA1M8Q1ghInZz5hAXlLQmArl8SkrfegxrhIfDvUwA5h
	C0u8Or6FfQKjziwk181CsmEW3IZZSDbMQrJhASPrKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k
	/NxNjMAUefrf8a87GFe8+qh3iJGJg/EQowQHs5IIb1WNdZoQb0piZVVqUX58UWlOavEhRmkO
	FiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QDk4hLSXw+T+vcpWsrPb/omF+u/928XPLA83sv
	F5V0RIXoSX8KO+tz9Wei+vbTL6Zemz/poXNRrmuNnvr5uF0aG2bu454Z3m+97javguq2N5eS
	lFd/NOz+t/yOubHEQSkV2c8ykkr3hKZnH54YI9/w9cT/uXN+npv2v1397glj85Jd1tMnnJO9
	06MT7HxDV3kS96kdSutuiJxed8s8a5mgTF5qcefEpOUL89l0vyxhY/RSOZH2aZLLF9lnqq9z
	cx02b3j3LkXJbjF/kb7jM/O5DQeDOwQWMtT8ynt2Wm//g3Va9x4eDjpe/15EYr/Hd8ldDNb5
	qycpTdPy2X3uy4M2Wd15fIuWyJls2dxVIhG9N0iJpTgj0VCLuag4EQBeQT7AAAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsVy+t/xu7q5irZpBitOKVt8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktFpxYzGjR+Pk+o8XvH0CJk7Mm
	s1jMPnqP3YHPY828NYweO2fdZfdYsKnUo+XIW1aPzSu0PBbvecnksenTJHaPEzN+s3jsfGjp
	0dv8js3j/b6rbB6fN8kF8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
	2aSk5mSWpRbp2yXoZRw8f5ulYJ5xxfF1XYwNjJs0uhg5OSQETCSe79nD3MXIxSEksJRR4tan
	BhaIhIzExi9XWSFsYYk/17rYIIo+MkpsenWcBcI5zSjRsekaI4SzglGiedYnRpAWNgFNiX0n
	N7GD2CICGhKb2jaA7WAW+Moi8XvLJLAdwgK2EovO/2CDKLKTaFw4jQXCdpN4MPMh2G4WARWJ
	eyf/gdm8Ar4SlzZvYYfY1sIsMWnpQrANnEDNd0/MBbMZBWQlHq38BWYzC4hL3HoynwniCQGJ
	JXvOM0PYohIvH/+Dek5H4uz1J4wQtoHE1qX7oAGgLLH+XRsTxBwdiQW7PwEdyg5kW0p0lUJE
	tSWWLXzNDHGaoMTJmU9YJjDKzEKyeBaS5llwzbOQNM9C0ryAkXUVo0hqaXFuem6xkV5xYm5x
	aV66XnJ+7iZGYPrbduznlh2MK1991DvEyMTBeIhRgoNZSYS3qsY6TYg3JbGyKrUoP76oNCe1
	+BCjKTDgJjJLiSbnAxNwXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMH
	p1QD09T89fvDjna/0vzya/m2a/kZUgdvVT1k2h/5jiltcUbgvcvfLA7P2PjvYdKXS3Jt62s/
	7rz8xeX+NZ+v+1yZjUO3czfnSh+xv+xr7iWhvOur152pewTWZy9y7ha6Jah5t+aLQtDyr/e2
	PeFcc6peV2ouV+/VyMP/g4o23Ux57PdQ+9jExw+ufiuMu1+znuPTxR0l/7Jrxb6tsmx7JXU/
	yLcmbvP6Gd/fe26TfMYalfBe6LDQtH9sEkas8v9fG1bWTtuhG2GQkrz+yfzo3idrtxa797et
	cfEynB7Y9eZ2y5Kra2976xV+eRTeVhNyUeb9uYNpsksNu3Z5vW0qWfpQw6TmboHexieB5783
	e6QsynysxFKckWioxVxUnAgATpcvHggEAAA=
X-CMS-MailID: 20240509191805eucas1p285e8681c5a48d9ec9261839016720a32
X-Msg-Generator: CA
X-RootMTR: 20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
	<CGME20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5@eucas1p1.samsung.com>
	<fqtaxc5pgu3zmvbdad4w6xty5iozye7v5z2b5ckqcjv273nz7b@hhdrjwf6rai3>
	<f44dc19a-e117-4418-9114-b723c5dc1178@redhat.com>
	<qye6lbmybiivdrr2vtlwgzzqelp7zoekezgiwo6mpirrl2576z@voszmqjbnm2q>
	<de9f9d07-6534-419b-86a8-628e13020c1e@redhat.com>

On Wed, May 08, 2024 at 07:03:57PM +0200, David Hildenbrand wrote:
> On 08.05.24 16:28, Daniel Gomez wrote:
> > On Wed, May 08, 2024 at 01:58:19PM +0200, David Hildenbrand wrote:
> > > On 08.05.24 13:39, Daniel Gomez wrote:
> > > > On Mon, May 06, 2024 at 04:46:24PM +0800, Baolin Wang wrote:
> > > > > Anonymous pages have already been supported for multi-size (mTHP)=
 allocation
> > > > > through commit 19eaf44954df, that can allow THP to be configured =
through the
> > > > > sysfs interface located at '/sys/kernel/mm/transparent_hugepage/h=
ugepage-XXkb/enabled'.
> > > > >=20
> > > > > However, the anonymous shared pages will ignore the anonymous mTH=
P rule
> > > > > configured through the sysfs interface, and can only use the PMD-=
mapped
> > > > > THP, that is not reasonable. Many implement anonymous page sharin=
g through
> > > > > mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage sc=
enarios,
> > > > > therefore, users expect to apply an unified mTHP strategy for ano=
nymous pages,
> > > > > also including the anonymous shared pages, in order to enjoy the =
benefits of
> > > > > mTHP. For example, lower latency than PMD-mapped THP, smaller mem=
ory bloat
> > > > > than PMD-mapped THP, contiguous PTEs on ARM architecture to reduc=
e TLB miss etc.
> > > > >=20
> > > > > The primary strategy is similar to supporting anonymous mTHP. Int=
roduce
> > > > > a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_ena=
bled',
> > > > > which can have all the same values as the top-level
> > > > > '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding =
a new
> > > > > additional "inherit" option. By default all sizes will be set to =
"never"
> > > > > except PMD size, which is set to "inherit". This ensures backward=
 compatibility
> > > > > with the shmem enabled of the top level, meanwhile also allows in=
dependent
> > > > > control of shmem enabled for each mTHP.
> > > >=20
> > > > I'm trying to understand the adoption of mTHP and how it fits into =
the adoption
> > > > of (large) folios that the kernel is moving towards. Can you, or an=
yone involved
> > > > here, explain this? How much do they overlap, and can we benefit fr=
om having
> > > > both? Is there any argument against the adoption of large folios he=
re that I
> > > > might have missed?
> > >=20
> > > mTHP are implemented using large folios, just like traditional PMD-si=
zed THP
> > > are. (you really should explore the history of mTHP and how it all wo=
rks
> > > internally)
> >=20
> > I'll check more in deep the code. By any chance are any of you going to=
 be at
> > LSFMM this year? I have this session [1] scheduled for Wednesday and it=
 would
> > be nice to get your feedback on it and if you see this working together=
 with
> > mTHP/THP.
> >=20
>=20
> I'll be around and will attend that session! But note that I am still
> scratching my head what to do with "ordinary" shmem, especially because o=
f
> the weird way shmem behaves in contrast to real files (below). Some input
> from Hugh might be very helpful.

I'm looking forward to meet you there and have your feedback!

>=20
> Example: you write() to a shmem file and populate a 2M THP. Then, nobody
> touches that file for a long time. There are certainly other mmap() users
> that could better benefit from that THP ... and without swap that THP wil=
l
> be trapped there possibly a long time (unless I am missing an important
> piece of shmem THP design :) )? Sure, if we only have THP's it's nice,
> that's just not the reality unfortunately. IIRC, that's one of the reason=
s
> why THP for shmem can be enabled/disabled. But again, still scratching my
> head ...
>=20
>=20
> Note that this patch set only tackles anonymous shmem (MAP_SHARED|MAP_ANO=
N),
> which is in 99.999% of all cases only accessed via page tables (memory
> allocated during page faults). I think there are ways to grab the fd
> (/proc/self/fd), but IIRC only corner cases read/write that.
>=20
> So in that sense, anonymous shmem (this patch set) behaves mostly like
> ordinary anonymous memory, and likely there is not much overlap with othe=
r
> "allocate large folios during read/write/fallocate" as in [1]. swap might
> have an overlap.
>=20
>=20
> The real confusion begins when we have ordinary shmem: some users never m=
map
> it and only read/write, some users never read/write it and only mmap it a=
nd
> some (less common?) users do both.
>=20
> And shmem really is special: it looks like "just another file", but
> memory-consumption and reclaim wise it behaves just like anonymous memory=
.
> It might be swappable ("usually very limited backing disk space available=
")
> or it might not.
>=20
> In a subthread here we are discussing what to do with that special
> "shmem_enabled =3D force" mode ... and it's all complicated I think.
>=20
> > [1] https://lore.kernel.org/all/4ktpayu66noklllpdpspa3vm5gbmb5boxskcj2q=
6qn7md3pwwt@kvlu64pqwjzl/
> >=20
> > >=20
> > > The biggest challenge with memory that cannot be evicted on memory pr=
essure
> > > to be reclaimed (in contrast to your ordinary files in the pagecache)=
 is
> > > memory waste, well, and placement of large chunks of memory in genera=
l,
> > > during page faults.
> > >=20
> > > In the worst case (no swap), you allocate a large chunk of memory onc=
e and
> > > it will stick around until freed: no reclaim of that memory.
> >=20
> > I can see that path being triggered by some fstests but only for THP (w=
here we
> > can actually reclaim memory).
>=20
> Is that when we punch-hole a partial THP and split it? I'd be interested =
in
> what that test does.

The reclaim path I'm referring to is triggered when we reach max capacity
(-ENOSPC) in shmem_alloc_and_add_folio(). We reclaim space by splitting lar=
ge
folios (regardless of their dirty or uptodate condition).

One of the tests that hits this path is generic/100 (with huge option enabl=
ed).
- First, it creates a directory structure in $TEMP_DIR (/tmp). Dir size is
around 26M.
- Then, it tars it up into $TEMP_DIR/temp.tar.
- Finally, untars the compressed file into $TEST_DIR (/media/test, which is=
 the
huge tmpfs mountdir). What happens in generic/100 under the huge=3Dalways c=
ase
is that you fill up the dedicated space very quickly (this is 1G in xfstest=
s
for tmpfs) and then you start reclaiming.

>=20
>=20
>=20
> --=20
> Cheers,
>=20
> David / dhildenb
> =

