Return-Path: <linux-kernel+bounces-208136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961F90214D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952AA289305
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4127C7E576;
	Mon, 10 Jun 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G4Lrfem6"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF90F54650
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021453; cv=none; b=JCxDQn70PvKgrhAGQZ5rCW2ut/SeoTJxb4oUBQz4R89Laa8Y3/xMGde0bn0bRd/zQokSbxNvxBiZNnABIz9mZtoJfE1YuyVXsQLpJ4tiix/5RoYVOpivvEs83zU7ujJAzJzYDDlCgKEUjlM7cFSqqolCqbiQuewpxIp02A//JYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021453; c=relaxed/simple;
	bh=iHyFnal0Hx/Ex/Y62g7f0hL0hex7+riesSthJ67fcz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=RBJ/z2kYeH0NIefPxooTn5L/7W224bwwHEAl/HWqn50TOb2tqBNcdqY2uTDgr4cbgm88GoWxmg95xFQullBC5y/CNbKm8Q5u2wxB9L+woGNPXqCajEAvkJJIbR8/WK+2ndHe+/LRsr0LgoP/XHDzStut8ivDV2ruqtwQAXjPiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=G4Lrfem6; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240610121041euoutp01e8271b38d72bc1fd0c655eb9ec865834~Xo2YQLidx2168721687euoutp01o
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:10:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240610121041euoutp01e8271b38d72bc1fd0c655eb9ec865834~Xo2YQLidx2168721687euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718021441;
	bh=rkkEM3mA3uk4SNgRfrq3+QmgSLD2WfsPubo4v3Su5qk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=G4Lrfem6gWfc01CzinCqkVf3znEwIIP3jcjIx3L1brRN6cnSriN+qlHsSL8b/hVxK
	 IhPiHeb1CmvJGi+X1j3CjuA79cbz9knHN3hfqcMwUGp7f+6EebDwEzlpGXIQuqHlIo
	 lNvwkubDzQ6wHzuxjSgbViRpeou1CK0CoSzdE5qw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240610121041eucas1p2d0460d1c4ce1103ba6b27d33646581a1~Xo2X6pgOG3102231022eucas1p2f;
	Mon, 10 Jun 2024 12:10:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id DF.3C.09624.14DE6666; Mon, 10
	Jun 2024 13:10:41 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240610121040eucas1p2ad07a27dec959bf1658ea9e5f0dd4697~Xo2XGVF8y3102231022eucas1p2e;
	Mon, 10 Jun 2024 12:10:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240610121040eusmtrp179b26fada87ae37141a6a01b432f5369~Xo2XFgDUS2993329933eusmtrp1g;
	Mon, 10 Jun 2024 12:10:40 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-b2-6666ed4118e3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F1.CD.08810.04DE6666; Mon, 10
	Jun 2024 13:10:40 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240610121040eusmtip1870fb5cae2f5ea39f32e5f2201f6d893~Xo2W44lUf2040020400eusmtip1P;
	Mon, 10 Jun 2024 12:10:40 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 10 Jun 2024 13:10:39 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Mon, 10 Jun
	2024 13:10:39 +0100
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
Subject: Re: [PATCH v4 0/6] add mTHP support for anonymous shmem
Thread-Topic: [PATCH v4 0/6] add mTHP support for anonymous shmem
Thread-Index: AQHatmiq95ivPAYXR0GYcZOSYxXaqbHA4NQA
Date: Mon, 10 Jun 2024 12:10:38 +0000
Message-ID: <qmbf362n2vtjaaeqvv6ta5xets3wyo5m3lfsocsrhvqjdso3vr@okzpmdbm3ogn>
In-Reply-To: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E2699B9BF68B94B9183A109A6B07B1E@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7djP87qOb9PSDDp+sFl8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktFpxYzGjR+Pk+o8XvH0CJk7Mm
	s1jMPnqP3YHPY828NYweO2fdZfdYsKnUo+XIW1aPzSu0PBbvecnksenTJHaPEzN+s3jsfGjp
	0dv8js3j/b6rbB6fN8kF8ERx2aSk5mSWpRbp2yVwZRyfoFBwWbviRcMDpgbGt4pdjJwcEgIm
	EmuO/2DsYuTiEBJYwSjRe6qbFcL5wigx8d5tZgjnM6NEd/80NpiWe+9+sUAkljNK/D92DqFq
	17bfbBDOGUaJQz8XQGVWMkrcPvaFHaSfTUBTYt/JTUA2B4eIgL5E71xfkBpmgemsEosv94Dt
	EBZwkHj/fikziC0i4Cgx984CRgjbSGLlnzNgNSwCqhIP73wGs3kFfCVuTfnICmJzAtU/6z7F
	AmIzCshKPFr5C2wvs4C4xK0n85kgfhCUWDR7DzOELSbxb9dDqN90JM5ef8IIYRtIbF26jwXC
	VpToOHaTDWKOjsSC3Z/YQO5nFrCUuDXXBCKsLbFs4WtmiHMEJU7OfALVupNL4tH+QgjbRaK1
	5TQrhC0s8er4FvYJjDqzkFw3C8mGWQgbZiHZMAvJhgWMrKsYxVNLi3PTU4sN81LL9YoTc4tL
	89L1kvNzNzECE+Tpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrxCGclpQrwpiZVVqUX58UWlOanF
	hxilOViUxHlVU+RThQTSE0tSs1NTC1KLYLJMHJxSDUwq39ZenP2ZI3jPOR3hA7riNnJvj3uq
	/1tpm8nTnvtuY+u5F0Gn1pZ+LLj/OWb2VGsz6Y1R/3MLw4PsLnwo+Hki7r9lcGJ+4efZlcbv
	itgcg2XvVHFbZ+7/e+zi3xlyUm/EF7nqPc6+/frBXgHXtbPfdBoJGAffF+E6ZvJmWc3GFWeW
	m8/g/3is7HtE/xH+pqIggZlt9iqGcn5Lt+u+U9Sq7zpSEGll/CpTcbZNbgCr91X7I/Zu9Uk/
	BWecqbNIL1sgH3ZlyrOwuIj4rzvP91XvnBEeZ364OP5Bn/qjw/3vbeb8bl+XpbyPacnuhjzR
	dNcDh8vVpp8zLt9ZW2o6L3AS/wv3Rfaz+4yuTZt7sUGJpTgj0VCLuag4EQAZ0aLo/wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsVy+t/xu7oOb9PSDG43CFp8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktFpxYzGjR+Pk+o8XvH0CJk7Mm
	s1jMPnqP3YHPY828NYweO2fdZfdYsKnUo+XIW1aPzSu0PBbvecnksenTJHaPEzN+s3jsfGjp
	0dv8js3j/b6rbB6fN8kF8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
	2aSk5mSWpRbp2yXoZRyfoFBwWbviRcMDpgbGt4pdjJwcEgImEvfe/WLpYuTiEBJYyijx9NVO
	FoiEjMTGL1dZIWxhiT/Xutggij4ySqxtbmeHcM4wSsw7vJYNpEpIYCWjxPlWMRCbTUBTYt/J
	TUBFHBwiAvoSvXN9QeqZBaazSiy+3ANWLyzgIPH+/VJmEFtEwFFi7p0FjBC2kcTKP2fAalgE
	VCUe3vkMZvMK+ErcmvKRFWKXg8SBB9PA6jmBep91nwK7mlFAVuLRyl/sIDazgLjErSfzmSA+
	EJBYsuc8M4QtKvHy8T+oz3Qkzl5/wghhG0hsXboP6ntFiY5jN9kg5uhILNj9iQ3kF2YBS4lb
	c00gwtoSyxa+ZoY4TVDi5MwnLBMYZWYh2TwLSfcshO5ZSLpnIelewMi6ilEktbQ4Nz232FCv
	ODG3uDQvXS85P3cTIzD1bTv2c/MOxnmvPuodYmTiYDzEKMHBrCTCK5SRnCbEm5JYWZValB9f
	VJqTWnyI0RQYchOZpUST84HJN68k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUI
	po+Jg1OqgWlO11nmfLc9xvKGE/QeJOwri6jLefto1vm2CeHp1hr/5b4sXTj99sG6hkXVLNUS
	h7d+7lEpZj12Uz38/J2A4mX+Z+1XP1kdqcQvEL5Htrok1jd2eyDLKePeqp6zr+pZOn/zPlvo
	8VElIH1TVXg381mfwvRNC3vn3vQurL6+4LHH45dnJ/T3pya88fnpYZXrGW5Ur2ako/zpfvmf
	V5JeFiczP1079XS5wZPHLo8Z2jLW9C/1/X3E70Df7a5vfG/PCwisnRMTV+LEkan/Oez7heda
	yxles9/xlXpea959afo5xbmNM1lj2MQOnF86ocY66tbmcwv3Wz/kd159R0Cz+7+Zm+KSJRf2
	Gt13P7nXIFCJpTgj0VCLuag4EQACdCAkBgQAAA==
X-CMS-MailID: 20240610121040eucas1p2ad07a27dec959bf1658ea9e5f0dd4697
X-Msg-Generator: CA
X-RootMTR: 20240610121040eucas1p2ad07a27dec959bf1658ea9e5f0dd4697
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240610121040eucas1p2ad07a27dec959bf1658ea9e5f0dd4697
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
	<CGME20240610121040eucas1p2ad07a27dec959bf1658ea9e5f0dd4697@eucas1p2.samsung.com>

Hi Baolin,

On Tue, Jun 04, 2024 at 06:17:44PM +0800, Baolin Wang wrote:
> Anonymous pages have already been supported for multi-size (mTHP) allocat=
ion
> through commit 19eaf44954df, that can allow THP to be configured through =
the
> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-=
XXkb/enabled'.
>=20
> However, the anonymous shmem will ignore the anonymous mTHP rule configur=
ed
> through the sysfs interface, and can only use the PMD-mapped THP, that is=
 not
> reasonable. Many implement anonymous page sharing through mmap(MAP_SHARED=
 |
> MAP_ANONYMOUS), especially in database usage scenarios, therefore, users =
expect
> to apply an unified mTHP strategy for anonymous pages, also including the
> anonymous shared pages, in order to enjoy the benefits of mTHP. For examp=
le,
> lower latency than PMD-mapped THP, smaller memory bloat than PMD-mapped T=
HP,
> contiguous PTEs on ARM architecture to reduce TLB miss etc.
>=20
> As discussed in the bi-weekly MM meeting[1], the mTHP controls should con=
trol
> all of shmem, not only anonymous shmem, but support will be added iterati=
vely.
> Therefore, this patch set starts with support for anonymous shmem.
>=20
> The primary strategy is similar to supporting anonymous mTHP. Introduce
> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
> which can have almost the same values as the top-level
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
> additional "inherit" option and dropping the testing options 'force' and
> 'deny'. By default all sizes will be set to "never" except PMD size, whic=
h
> is set to "inherit". This ensures backward compatibility with the anonymo=
us
> shmem enabled of the top level, meanwhile also allows independent control=
 of
> anonymous shmem enabled for each mTHP.
>=20
> Use the page fault latency tool to measure the performance of 1G anonymou=
s shmem

I'm not familiar with this tool. Could you share which repo/tool you are
referring to?

Also, are you running or are you aware of any other tools/tests available f=
or
shmem that we can use to make sure we do not introduce any regressions?

Thanks!
Daniel

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
> [1] https://lore.kernel.org/all/f1783ff0-65bd-4b2b-8952-52b6822a0835@redh=
at.com/
>=20
> Changes from v3:
>  - Drop 'force' and 'deny' testing options for each mTHP.
>  - Use new helper update_mmu_tlb_range(), per Lance.
>  - Update documentation to drop "anonymous thp" terminology, per David.
>  - Initialize the 'suitable_orders' in shmem_alloc_and_add_folio(),
>    reported by kernel test robot.
>  - Fix the highest mTHP order in shmem_get_unmapped_area().
>  - Update some commit message.
>=20
> Changes from v2:
>  - Rebased to mm/mm-unstable.
>  - Remove 'huge' parameter for shmem_alloc_and_add_folio(), per Lance.
>=20
> Changes from v1:
>  - Drop the patch that re-arranges the position of highest_order() and
>    next_order(), per Ryan.
>  - Modify the finish_fault() to fix VA alignment issue, per Ryan and
>    David.
>  - Fix some building issues, reported by Lance and kernel test robot.
>  - Update some commit message.
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
> Baolin Wang (6):
>   mm: memory: extend finish_fault() to support large folio
>   mm: shmem: add THP validation for PMD-mapped THP related statistics
>   mm: shmem: add multi-size THP sysfs interface for anonymous shmem
>   mm: shmem: add mTHP support for anonymous shmem
>   mm: shmem: add mTHP size alignment in shmem_get_unmapped_area
>   mm: shmem: add mTHP counters for anonymous shmem
>=20
>  Documentation/admin-guide/mm/transhuge.rst |  23 ++
>  include/linux/huge_mm.h                    |  23 ++
>  mm/huge_memory.c                           |  17 +-
>  mm/memory.c                                |  57 +++-
>  mm/shmem.c                                 | 344 ++++++++++++++++++---
>  5 files changed, 403 insertions(+), 61 deletions(-)
>=20
> --=20
> 2.39.3
> =

