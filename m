Return-Path: <linux-kernel+bounces-253800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BFD93272B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2B4B21402
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158FB19AD59;
	Tue, 16 Jul 2024 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uuS6wkyt"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F8145345
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135490; cv=none; b=JR1fvTgbkrQoOVwu+BNGBaqCGho/VIWe2c33HegCgHlGV5Y4J6oGN6BIVWffY+nCoilYzBdM1UiWxhRDdKFhaEpu8XxnLMcn1sEdXSB6fWpq54tiFTuozNVBAn3gxlzr/EVJjeqeoKInU3h4jl67fhYi/w610RKp0yB4oWXcdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135490; c=relaxed/simple;
	bh=323fBDBU/FdAot3IkidyscC/NTdNODDJnUhuDGQw+NI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=KpotGczyy37WGS4I518+QDHDE4x5cKQ5w+lYb/xBG8j2+wviyZJsJGaccCK7mwbz+xUGTgGgG6GPs4wm1sEG3EB4u4g6kPSl1BJdvtHBZJlqEoeMzGPeZwbu0fNfDgM6G3UDRo6Mn0ea336aUtiVWG1gHiECZpnrboJ8neaqVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uuS6wkyt; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240716131126euoutp0239753b72649c97e1565c6badd7b408d0~is5sG99zg2674826748euoutp02C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:11:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240716131126euoutp0239753b72649c97e1565c6badd7b408d0~is5sG99zg2674826748euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721135486;
	bh=L7RwQO64YsZp/3e1EZUhIQA+/G8V9RAhouLg8izaznU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=uuS6wkyt53krkEV9m9vzioxFr1LnBa4trb+TXWT3d/f1tzJ83FzIzCY2R5/NXO1dQ
	 5EBsL3v+0Uf3FkeGlQgbeK8jL7mGNOU64FwE1xcYKnd0/fBFQmyjHR47XiHU6omx1Y
	 rFTUXkcDc7UoBuNzicgcFR059u8DeEUP3/E7p/6A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240716131125eucas1p1f5dd22a64167a15175f599f0e1f0a409~is5r1uneN0686406864eucas1p1l;
	Tue, 16 Jul 2024 13:11:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2B.B8.09624.D7176966; Tue, 16
	Jul 2024 14:11:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240716131125eucas1p27622651f220cb40bed7388bc9ae16557~is5rTHVm_1928919289eucas1p2J;
	Tue, 16 Jul 2024 13:11:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240716131125eusmtrp1a8f1b52d7c80e44861e3cffc708ee367~is5rSQZrF3155031550eusmtrp12;
	Tue, 16 Jul 2024 13:11:25 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-50-6696717dcf5f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 8B.29.08810.C7176966; Tue, 16
	Jul 2024 14:11:25 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240716131124eusmtip17987d7b569d94fcf0195bc91f0d386d5~is5rCoBh53114431144eusmtip1N;
	Tue, 16 Jul 2024 13:11:24 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 16 Jul 2024 14:11:24 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Tue, 16 Jul
	2024 14:11:24 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Ryan Roberts <ryan.roberts@arm.com>
CC: David Hildenbrand <david@redhat.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Matthew Wilcox <willy@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "hughd@google.com"
	<hughd@google.com>, "wangkefeng.wang@huawei.com"
	<wangkefeng.wang@huawei.com>, "ying.huang@intel.com" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "shy828301@gmail.com"
	<shy828301@gmail.com>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"ioworker0@gmail.com" <ioworker0@gmail.com>, Pankaj Raghav
	<p.raghav@samsung.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] add mTHP support for anonymous shmem
Thread-Topic: [PATCH v5 0/6] add mTHP support for anonymous shmem
Thread-Index: AQHau+f0u3UalAdLwEiKkul1osqzdLHm+4gAgAAFkYCAAARrAIAACHIAgACnJICAADGWgIAAA+UAgAOlSYCAApuYAIALT0UA
Date: Tue, 16 Jul 2024 13:11:23 +0000
Message-ID: <pxeazv32rilu75pxzfw6ksx3fmlij5brih2247d73c3vq6mokc@qcnuqbqs4buj>
In-Reply-To: <e83e1687-3e3c-40d0-bf0e-225871647092@arm.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <317EA000D9E63145B7DE4B26E0916BB2@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7djPc7q1hdPSDGbMV7X4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InisklJzcksSy3St0vgypg35SRjQZ9pRX/3K9YGxt+aXYwcHBIC
	JhL9Z0u7GLk4hARWMEpcuPqDHcL5wiix+l8zG4TzmVFiz73HQA4nWMfzaz0sEInljBLdk5Yg
	VE2cf4YJwjnDKLH94HVWkBYhgZWMEvM6PEBsNgFNiX0nN7GD2CIC6hI/bi1iBGlgFuhllbjw
	8xJYg7CAg8T1ef1QRY4SC+ecZIOw8yS2914Bs1kEVCXWbGphBLF5BXwl7mxeCRbnFLCWuDn5
	G1gvo4CsxKOVv8BsZgFxiVtP5jNB/CAosWj2HmYIW0zi366HUL/pSJy9/oQRwjaQ2Lp0HwuE
	rSjRcewmG8QcPYkbU6dA2ZYSf3ZPYoSwtSWWLXzNDHGPoMTJmU/AYSQhsJFLYvGrL+yQ4HaR
	eLMtD2KmsMSr41vYJzDqzEJy3iwkK2YhWTELyYpZSFYsYGRdxSieWlqcm55abJiXWq5XnJhb
	XJqXrpecn7uJEZgkT/87/mkH49xXH/UOMTJxMB5ilOBgVhLhncA4LU2INyWxsiq1KD++qDQn
	tfgQozQHi5I4r2qKfKqQQHpiSWp2ampBahFMlomDU6qBiX9neCxz56N9RcejXyZp3puw32v7
	M2W3OwHK5b9D7A5bcR67FXextuOG/9mzX3IM7TN4qz9dvuas/cPqn0z14qdfNPXSdyh4bXC7
	2io7P/rZy8v/mm5sD/pyw0PYYubrxOslJcKPPqt/FowR2XZPxOLlljd933cwun3zXl3kbMHK
	rrF7bsaLm9p3Av/d5Fna7dGwVcQpQ+cof+kqzyfSujNXvbo97xn7BtlXcjfuux/7uWv/b/1V
	TM7x/YHrbq2r9mG/3qpdXxDjal5vKuW+N9iuITz+0M0dd/n5my1ETtWcONt4+UVDl/GTWTnN
	LGs2KC45Va6k7hb2+/ZutX17mwS0Y0zX9F/v7+jdrnfmlBJLcUaioRZzUXEiAHm16iMBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsVy+t/xu7q1hdPSDNp3MFl8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktFpxYzGjR+Pk+o8XvH0CJk7Mm
	s1jMPnqP3YHPY828NYweO2fdZfdYsKnUo+XIW1aPzSu0PBbvecnksenTJHaPEzN+s3jsfGjp
	0dv8js3j/b6rbB6fN8kF8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
	2aSk5mSWpRbp2yXoZcybcpKxoM+0or/7FWsD42/NLkZODgkBE4nn13pYuhi5OIQEljJK3LrU
	wgKRkJHY+OUqK4QtLPHnWhcbRNFHRokb62azQjhnGCWe3pwPViUksJJR4uvNPBCbTUBTYt/J
	TewgtoiAusSPW4sYQRqYBXpZJS78vATWICzgIHF9Xj9UkaPEwjkn2SDsPIntvVfAbBYBVYk1
	m1oYQWxeAV+JO5tXQp2xjkWic9sjsASngLXEzcnfwAYxCshKPFr5C8xmFhCXuPVkPhPEDwIS
	S/acZ4awRSVePv4H9ZuOxNnrTxghbAOJrUv3Qf2vKNFx7CYbxBw9iRtTp0DZlhJ/dk9ihLC1
	JZYtfM0McZygxMmZT1gmMMrMQrJ6FpL2WUjaZyFpn4WkfQEj6ypGkdTS4tz03GJDveLE3OLS
	vHS95PzcTYzAJLjt2M/NOxjnvfqod4iRiYPxEKMEB7OSCO8ExmlpQrwpiZVVqUX58UWlOanF
	hxhNgYE3kVlKNDkfmIbzSuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4
	pRqYRHr/Hp/hu7XjnNM1cdvWbac7dotrqNv+zdU+4WL0JvDzDCO33ClvNN/YHr8x7axFKO+J
	baInFkWnCn38xh6svoI1Tdf9oXDgdLNTeuJWMw7sNBT6UjutY17flt192adXPJt0/O2NDM+J
	MW8zRTWcf9uLWMwt+nhRhPmLgYBB0N8usURBX9eshLhPhTMmBgb3uJpv28pw+VVRKVOsZ2Og
	56e38UHGf2yqj6t2T9Fm2LBg2/rIlIyKJSe19pypsCvOUbJ3bNsiMG/Xj81Nrz7tnGi+snyW
	3mx7LlXt27dUuV5MYn0mLKszv+jS77vnTluXb5S1SN775yJP/XF3R7UDFv8PTYi+eF7q2/JI
	N+EGJZbijERDLeai4kQAnU4bhgsEAAA=
X-CMS-MailID: 20240716131125eucas1p27622651f220cb40bed7388bc9ae16557
X-Msg-Generator: CA
X-RootMTR: 20240705085911eucas1p17f1e79c871c6290b426737ca1738e529
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240705085911eucas1p17f1e79c871c6290b426737ca1738e529
References: <ZobtTmzj0AmNXcav@casper.infradead.org>
	<27beaa0e-697e-4e30-9ac6-5de22228aec1@redhat.com>
	<6d4c0191-18a9-4c8f-8814-d4775557383e@redhat.com>
	<Zob8xI-LWe9H_iJs@casper.infradead.org>
	<e08b8245-bc8c-4a18-a1e0-53a139258826@linux.alibaba.com>
	<e826368d-499a-483b-8991-8c25aff88f00@arm.com>
	<CGME20240705085911eucas1p17f1e79c871c6290b426737ca1738e529@eucas1p1.samsung.com>
	<32f04739-0cd0-4a9e-9419-c5a13c333c28@redhat.com>
	<ihgsmfaqgpjcewxpjnpoo3ibdhm72s2balhpedkgr2aou5l355@ps7vb3l5j54n>
	<e83e1687-3e3c-40d0-bf0e-225871647092@arm.com>

On Tue, Jul 09, 2024 at 09:28:48AM GMT, Ryan Roberts wrote:
> On 07/07/2024 17:39, Daniel Gomez wrote:
> > On Fri, Jul 05, 2024 at 10:59:02AM GMT, David Hildenbrand wrote:
> >> On 05.07.24 10:45, Ryan Roberts wrote:
> >>> On 05/07/2024 06:47, Baolin Wang wrote:
> >>>>
> >>>>
> >>>> On 2024/7/5 03:49, Matthew Wilcox wrote:
> >>>>> On Thu, Jul 04, 2024 at 09:19:10PM +0200, David Hildenbrand wrote:
> >>>>>> On 04.07.24 21:03, David Hildenbrand wrote:
> >>>>>>>> shmem has two uses:
> >>>>>>>>
> >>>>>>>>  =A0=A0=A0 - MAP_ANONYMOUS | MAP_SHARED (this patch set)
> >>>>>>>>  =A0=A0=A0 - tmpfs
> >>>>>>>>
> >>>>>>>> For the second use case we don't want controls *at all*, we want=
 the
> >>>>>>>> same heiristics used for all other filesystems to apply to tmpfs=
.
> >>>>>>>
> >>>>>>> As discussed in the MM meeting, Hugh had a different opinion on t=
hat.
> >>>>>>
> >>>>>> FWIW, I just recalled that I wrote a quick summary:
> >>>>>>
> >>>>>> https://lkml.kernel.org/r/f1783ff0-65bd-4b2b-8952-52b6822a0835@red=
hat.com
> >>>>>>
> >>>>>> I believe the meetings are recorded as well, but never looked at r=
ecordings.
> >>>>>
> >>>>> That's not what I understood Hugh to mean.=A0 To me, it seemed that=
 Hugh
> >>>>> was expressing an opinion on using shmem as shmem, not as using it =
as
> >>>>> tmpfs.
> >>>>>
> >>>>> If I misunderstood Hugh, well, I still disagree.=A0 We should not h=
ave
> >>>>> separate controls for this.=A0 tmpfs is just not that special.
> >>>
> >>> I wasn't at the meeting that's being referred to, but I thought we pr=
eviously
> >>> agreed that tmpfs *is* special because in some configurations its not=
 backed by
> >>> swap so is locked in ram?
> >>
> >> There are multiple things to that, like:
> >>
> >> * Machines only having limited/no swap configured
> >> * tmpfs can be configured to never go to swap
> >> * memfd/tmpfs files getting used purely for mmap(): there is no real
> >>   difference to MAP_ANON|MAP_SHARE besides the processes we share that
> >>   memory with.
> >>
> >> Especially when it comes to memory waste concerns and access behavior =
in
> >> some cases, tmpfs behaved much more like anonymous memory. But there a=
re for
> >> sure other use cases where tmpfs is not that special.
> >=20
> > Having controls to select the allowable folio order allocations for
> > tmpfs does not address any of these issues. The suggested filesystem
> > approach [1] involves allocating orders in larger chunks, but always
> > the same size you would allocate when using order-0 folios.=20
>=20
> Well you can't know that you will never allocate more. If you allocate a =
2M

In the fs large folio approach implementation [1], the allocation of a 2M (=
or
any non order-0) occurs when the size of the write/fallocate is 2M (and ind=
ex
is aligned).

> block, you probably have some good readahead data that tells you you are =
likely
> to keep reading sequentially, but you don't know for sure that the applic=
ation
> won't stop after just 4K.

Is shmem_file_read_iter() getting readahead data to perform the read? or wh=
at do
you mean exactly?

In [1], read is perform in chunks of 4k, so I think this does not apply.

>=20
> > So,
> > it's a conservative approach. Using mTHP knobs in tmpfs would cause:
> > * Over allocation when using mTHP and/ord THP under the 'always' flag.
> > * Allocate in bigger chunks in a non optimal way, when
> > not all mTHP and THP orders are enabled.
> > * Operate in a similar manner as in [1] when all mTHP and THP orders
> > are enabled and 'within_size' flag is used (assuming we use patch 11
> > from [1]).
>=20
> Large folios may still be considered scarce resources even if the amount =
of
> memory allocated is still the same. And if shmem isn't backed by swap the=
n once
> you have allocated a large folio for shmem, it is stuck in shmem, even if=
 it
> would be better used somewhere else.

Is that true for tmpfs as well? We have shmem_unused_huge_shrink() that wil=
l
reclaim unused large folios (when ENOSPC and free_cached_objects()). Can't =
we
reuse that when the system is under memory pressure?

>=20
> And it's possible (likely even, in my opinion) that allocating lots of di=
fferent
> folio sizes will exacerbate memory fragmentation, leading to more order-0
> fallbacks, which would hurt the overall system performance in the long ru=
n, vs
> restricting to a couple of folio sizes.

Since we are transitioning to large folios in other filesystems, the impact
of restricting the order here will only depend on the extent of tmpfs usage
relative to the rest of the system. Luis discussed the topic of mm fragment=
ation
and measurment in a session at LSFMM this year [2].

[2] https://lore.kernel.org/all/ZkUOXQvVjXP1T6Nk@bombadil.infradead.org/

>=20
> I'm starting some work to actually measure how limiting the folio sizes
> allocated for page cache memory can help reduce large folio allocation fa=
ilure

It would be great to hear more about that effort.

> overall. My hypothesis is that the data will show us that in an environme=
nt like
> Android, where memory pressure is high, limiting everything to order-0 an=
d
> order-4 will significantly improve the allocation success rate of order-4=
. Let's
> see.
>=20
> >=20
> > [1] Last 3 patches of these series:
> > https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com=
/
> >=20
> > My understanding of why mTHP was preferred is to raise awareness in
> > user space and allow tmpfs mounts used at boot time to operate in
> > 'safe' mode (no large folios). Does it make more sense to have a large
> > folios enable flag to control order allocation as in [1], instead of
> > every single order possible?
>=20
> My intuition is towards every order possible, as per above. Let's see wha=
t the
> data tells us.
>=20
> >=20
> >>
> >> My opinion is that we need to let people configure orders (if you feel=
 like
> >> it, configure all), but *select* the order to allocate based on readah=
ead
> >> information -- in contrast to anonymous memory where we start at the h=
ighest
> >> order and don't have readahead information available.
> >>
> >> Maybe we need different "order allcoation" logic for read/write vs. fa=
ult,
> >> not sure.
> >=20
> > I would suggest [1] the file size of the write for the write
> > and fallocate paths. But when does make sense to use readahead
> > information? Maybe when swap is involved?
> >=20
> >>
> >> But I don't maintain that code, so I can only give stupid suggestions =
and
> >> repeat what I understood from the meeting with Hugh and Kirill :)
> >>
> >> --=20
> >> Cheers,
> >>
> >> David / dhildenb
> =

