Return-Path: <linux-kernel+bounces-243658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE89298E5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E181C20C1B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE03D57A;
	Sun,  7 Jul 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qYyWUGoF"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAF1DFDE
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720370783; cv=none; b=rOQtneGnzNJIcUHXKHr4q+fJv1bIWLt4PxEWu+tk1QUVT75u3GoSG8vsUNgFxax24w2erUzP7KCkkwMRz0d4KnavdLlX3uPfdDlv/0bHNFHOdNci8KC3h6RxSkYXiHcScMv+VaaUxo5CjzqN/gIIuB5SIAJfl6Byz8pNZQ2Sk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720370783; c=relaxed/simple;
	bh=ruyvDLyXZnIuMaTIXzf5nHPYuLzMTAr8Jyc4ojWMkrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=p1DwjBvysfGn89pm2ekL1mDHmR1pkq+hI9OfSUapGA3QQCBc7R29PdHcSRNold64EosX6Fhk8dmgEI1U+ahMfXQQrJC9cBBoAF3ePyamWbzJSBfZGobgjX5fjrSlRXLtzjAJlQY0vutUEqKnugFxXt43wfwbmwA51+v8VBVOAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qYyWUGoF; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240707163928euoutp02865e0fd09e890f1abe3d81fe026e02f0~f_7wsvIzh2631626316euoutp02B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 16:39:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240707163928euoutp02865e0fd09e890f1abe3d81fe026e02f0~f_7wsvIzh2631626316euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720370368;
	bh=Ck7kOg6cm3eaDL4aJHN1z8N3YaVIAz2E2fFFluJKZ84=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=qYyWUGoFEpOl/wj6vm7gHLsbgwDcobUY19EitEYKRqCl5hXIt1/KAqoOz6FcopSco
	 8NWNaGF8NKcifNJdcVzQ7Hvst6yLoVgsdQl7v7rKsS0fenSPhHQh4T7680aSC3n4Kx
	 b/5VNRvFqKn900DGwkk0j6BvRf4DYH5l1Iety7BQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240707163927eucas1p22b0ff8a5973ee97e0e6a4e0db68c4bc8~f_7wZo77n1566215662eucas1p2o;
	Sun,  7 Jul 2024 16:39:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id E5.11.09875.FB4CA866; Sun,  7
	Jul 2024 17:39:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240707163926eucas1p10cba583480dcbb91b37796353d378473~f_7vRW6ms2145221452eucas1p1Q;
	Sun,  7 Jul 2024 16:39:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240707163926eusmtrp2875b553fc9767ce801f2b8f5c166cd6c~f_7vQuvTk2193921939eusmtrp2e;
	Sun,  7 Jul 2024 16:39:26 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-0b-668ac4bf4a95
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 2C.77.09010.EB4CA866; Sun,  7
	Jul 2024 17:39:26 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240707163926eusmtip2a69e87812e4ab0662a3f9cf8d2b3cda9~f_7vDBRZ93267732677eusmtip2t;
	Sun,  7 Jul 2024 16:39:26 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Sun, 7 Jul 2024 17:39:26 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Sun, 7 Jul
	2024 17:39:26 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: David Hildenbrand <david@redhat.com>
CC: Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang
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
Thread-Index: AQHau+f0u3UalAdLwEiKkul1osqzdLHm+4gAgAAFkYCAAARrAIAACHIAgACnJICAADGWgIAAA+UAgAOlSYA=
Date: Sun, 7 Jul 2024 16:39:25 +0000
Message-ID: <ihgsmfaqgpjcewxpjnpoo3ibdhm72s2balhpedkgr2aou5l355@ps7vb3l5j54n>
In-Reply-To: <32f04739-0cd0-4a9e-9419-c5a13c333c28@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <922FEAA4C15BB442800D27E7BD284862@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7djP87r7j3SlGSxbYWDx+a6QxZz1a9gs
	/u89xmjxdf0vZounn/pYLBb9Nra4vGsOm8W9Nf9ZLXp2T2W0WHBiMaNF4+f7jBa/fwAlTs6a
	zGIx++g9dgc+jzXz1jB67Jx1l91jwaZSj5Yjb1k9Nq/Q8li85yWTx6ZPk9g9Tsz4zeKx86Gl
	R2/zOzaP9/uusnl83iQXwBPFZZOSmpNZllqkb5fAldG3YAZrwVf5irenbzA1MH6X6GLk5JAQ
	MJH403+YqYuRi0NIYAWjxNdDP1khnC+MEvNaZ7BAOJ8ZJRpPTWaCafl77gNUYjmjxIW1S9ng
	qtb+3cgM4ZxmlPh87SYj3OR3R3+xgPSzCWhK7Du5iR3EFhHQkNjUtgGsg1mgh1XibsNrRpCE
	sICDxPV5/VBFjhIL55xkg7CTJO78eQ52CIuAisTd+0fA4rwCvhKrz70Hsjk4OAXsJM6eCwQJ
	MwrISjxa+QtsDLOAuMStJ/OhfhCUWDR7DzOELSbxb9dDNghbR+Ls9SeMELaBxNal+1hARkoI
	KEv8XyIOMUZP4sbUKWwQtqXE0b5JzBC2tsSyha+ZIa4RlDg58wk4iCQEtnJJrOv6BbXXReLV
	rltQu4QlXh3fwj6BUWcWkvNmIdkxC8mOWUh2zEKyYwEj6ypG8dTS4tz01GKjvNRyveLE3OLS
	vHS95PzcTYzANHn63/EvOxiXv/qod4iRiYPxEKMEB7OSCO/px+1pQrwpiZVVqUX58UWlOanF
	hxilOViUxHlVU+RThQTSE0tSs1NTC1KLYLJMHJxSDUzOPqf+1Uu29d6O+KJ050YH2633i11N
	7wc8ljjfKXVnjf//ZxbvfsYfv6NUpCuy6qDADs5XSqkr8yMPKpzdI8CQrnN6s9KcXw/uc0Z2
	Pb894T/LvUDWIuftTwx9Vyleil+hsUxhz5uXm7mPb99qI6XTfV2NSbQ3oONwvffzf65hm0yE
	PDzvMO7YatEVmMRosETw5GbWw2Zdat9fyebpxZ0+4Re+belqgROXH5fOjdCec+jow6+8zWIG
	Ja4nTv3eVR0hem3ybPelcSeO/Q890MKWrDj1eo+iQGiXbaW6RKUJ04G079obChTLnkfl9TSy
	XLcI4b608M0Suw8hrle275nw+nNnr3hO54RrEtqct84qsRRnJBpqMRcVJwIAqUp1KQIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsVy+t/xe7r7jnSlGaw4qm7x+a6QxZz1a9gs
	/u89xmjxdf0vZounn/pYLBb9Nra4vGsOm8W9Nf9ZLXp2T2W0WHBiMaNF4+f7jBa/fwAlTs6a
	zGIx++g9dgc+jzXz1jB67Jx1l91jwaZSj5Yjb1k9Nq/Q8li85yWTx6ZPk9g9Tsz4zeKx86Gl
	R2/zOzaP9/uusnl83iQXwBOlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
	Z5OSmpNZllqkb5egl9G3YAZrwVf5irenbzA1MH6X6GLk5JAQMJH4e+4DSxcjF4eQwFJGiflX
	njFDJGQkNn65ygphC0v8udbFBlH0kVFi54HrzBDOaUaJew83s0M4Kxglbj59zQjSwiagKbHv
	5CZ2EFtEQENiU9sGsA5mgR5WibsNEEXCAg4S1+f1QxU5Siycc5INwk6SuPPnOROIzSKgInH3
	/hGwOK+Ar8Tqc++h7vjALLHo6Fugyzk4OAXsJM6eCwSpYRSQlXi08hfYTGYBcYlbT+YzQfwg
	ILFkz3mo30QlXj7+B/WbjsTZ608YIWwDia1L94GNlBBQlvi/RBxijJ7EjalT2CBsS4mjfZOY
	IWxtiWULXzNDnCYocXLmE5YJjDKzkGyehaR9FpL2WUjaZyFpX8DIuopRJLW0ODc9t9hIrzgx
	t7g0L10vOT93EyMwBW479nPLDsaVrz7qHWJk4mA8xCjBwawkwnv6cXuaEG9KYmVValF+fFFp
	TmrxIUZTYNBNZJYSTc4HJuG8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+
	Jg5OqQYm1qP/kz6umeqaXmm8OvkC93ydnu1xQs2mJjJhnqu31CkrPVy/Iz6ufC1DHBvvAZ3P
	1v+Wvnt3eknKfxWTkvn5k6/3dHv6J93MWTPDzeb9iTf/Q5ke/Tp4qGadnLLZ7fy3xqujPlX4
	btNlvejvwXp90pQ24esN5ktPyh5uZWK4sGbH3ObDP1U9mrQvaCrWnd4vkHXAWPPpudPX3n84
	cvCkaKlb41Wlc8IHnkeJHV56QYYnzVpQ+Jz7vIhSZ7/5bxc4mUTzCshXGR4vldTccpqxc9LL
	rSnvjt/9YlaV8/9ViaPrxKDov/EdNzfcsbyVYNgU0qmR++xtnc2yq5bTHnl/uXvuzJnq15yZ
	pTPnXWGyVmIpzkg01GIuKk4EABR0DqEKBAAA
X-CMS-MailID: 20240707163926eucas1p10cba583480dcbb91b37796353d378473
X-Msg-Generator: CA
X-RootMTR: 20240705085911eucas1p17f1e79c871c6290b426737ca1738e529
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240705085911eucas1p17f1e79c871c6290b426737ca1738e529
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
	<ZobtTmzj0AmNXcav@casper.infradead.org>
	<27beaa0e-697e-4e30-9ac6-5de22228aec1@redhat.com>
	<6d4c0191-18a9-4c8f-8814-d4775557383e@redhat.com>
	<Zob8xI-LWe9H_iJs@casper.infradead.org>
	<e08b8245-bc8c-4a18-a1e0-53a139258826@linux.alibaba.com>
	<e826368d-499a-483b-8991-8c25aff88f00@arm.com>
	<CGME20240705085911eucas1p17f1e79c871c6290b426737ca1738e529@eucas1p1.samsung.com>
	<32f04739-0cd0-4a9e-9419-c5a13c333c28@redhat.com>

On Fri, Jul 05, 2024 at 10:59:02AM GMT, David Hildenbrand wrote:
> On 05.07.24 10:45, Ryan Roberts wrote:
> > On 05/07/2024 06:47, Baolin Wang wrote:
> > >=20
> > >=20
> > > On 2024/7/5 03:49, Matthew Wilcox wrote:
> > > > On Thu, Jul 04, 2024 at 09:19:10PM +0200, David Hildenbrand wrote:
> > > > > On 04.07.24 21:03, David Hildenbrand wrote:
> > > > > > > shmem has two uses:
> > > > > > >=20
> > > > > > >  =A0=A0=A0 - MAP_ANONYMOUS | MAP_SHARED (this patch set)
> > > > > > >  =A0=A0=A0 - tmpfs
> > > > > > >=20
> > > > > > > For the second use case we don't want controls *at all*, we w=
ant the
> > > > > > > same heiristics used for all other filesystems to apply to tm=
pfs.
> > > > > >=20
> > > > > > As discussed in the MM meeting, Hugh had a different opinion on=
 that.
> > > > >=20
> > > > > FWIW, I just recalled that I wrote a quick summary:
> > > > >=20
> > > > > https://lkml.kernel.org/r/f1783ff0-65bd-4b2b-8952-52b6822a0835@re=
dhat.com
> > > > >=20
> > > > > I believe the meetings are recorded as well, but never looked at =
recordings.
> > > >=20
> > > > That's not what I understood Hugh to mean.=A0 To me, it seemed that=
 Hugh
> > > > was expressing an opinion on using shmem as shmem, not as using it =
as
> > > > tmpfs.
> > > >=20
> > > > If I misunderstood Hugh, well, I still disagree.=A0 We should not h=
ave
> > > > separate controls for this.=A0 tmpfs is just not that special.
> >=20
> > I wasn't at the meeting that's being referred to, but I thought we prev=
iously
> > agreed that tmpfs *is* special because in some configurations its not b=
acked by
> > swap so is locked in ram?
>=20
> There are multiple things to that, like:
>=20
> * Machines only having limited/no swap configured
> * tmpfs can be configured to never go to swap
> * memfd/tmpfs files getting used purely for mmap(): there is no real
>   difference to MAP_ANON|MAP_SHARE besides the processes we share that
>   memory with.
>=20
> Especially when it comes to memory waste concerns and access behavior in
> some cases, tmpfs behaved much more like anonymous memory. But there are =
for
> sure other use cases where tmpfs is not that special.

Having controls to select the allowable folio order allocations for
tmpfs does not address any of these issues. The suggested filesystem
approach [1] involves allocating orders in larger chunks, but always
the same size you would allocate when using order-0 folios. So,
it's a conservative approach. Using mTHP knobs in tmpfs would cause:
* Over allocation when using mTHP and/ord THP under the 'always' flag.
* Allocate in bigger chunks in a non optimal way, when
not all mTHP and THP orders are enabled.
* Operate in a similar manner as in [1] when all mTHP and THP orders
are enabled and 'within_size' flag is used (assuming we use patch 11
from [1]).

[1] Last 3 patches of these series:
https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/

My understanding of why mTHP was preferred is to raise awareness in
user space and allow tmpfs mounts used at boot time to operate in
'safe' mode (no large folios). Does it make more sense to have a large
folios enable flag to control order allocation as in [1], instead of
every single order possible?

>=20
> My opinion is that we need to let people configure orders (if you feel li=
ke
> it, configure all), but *select* the order to allocate based on readahead
> information -- in contrast to anonymous memory where we start at the high=
est
> order and don't have readahead information available.
>=20
> Maybe we need different "order allcoation" logic for read/write vs. fault=
,
> not sure.

I would suggest [1] the file size of the write for the write
and fallocate paths. But when does make sense to use readahead
information? Maybe when swap is involved?

>=20
> But I don't maintain that code, so I can only give stupid suggestions and
> repeat what I understood from the meeting with Hugh and Kirill :)
>=20
> --=20
> Cheers,
>=20
> David / dhildenb
> =

