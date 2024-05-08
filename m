Return-Path: <linux-kernel+bounces-173399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51238BFFF7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0881F2557A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0887C85639;
	Wed,  8 May 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rICGJAuT"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5621DA22
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178538; cv=none; b=liR7i7pV2SfnCXuD5cMVXJlZR3CM8uGqQfzfGvXlZ/hcG1CrAAbAXOv+SvtZv/exUjJ3BIj0cXwqPNwPwMep2MQipI4Hoa/5moVBjeMXTjYySsvvigoLMZfIAu5kcR0QflsdOkdT0CRe5qlKQTqHVw1tMyGtUFHTcdRdNRKTH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178538; c=relaxed/simple;
	bh=Ee/8LWKE8Bdug161RpQzHHNP1V/kv8tqluZ12pcxmBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=BoL3UlHifZINPo83ZOR6Q7P0ZlIbwxQBF4FGMrrH5q3vJatm7XI/SwsJCKfvjnFnf1uqzYD9WDSssPDyUPJP6w3bx/Gd2owqJwyA1CdgOSdq3Iq2/SCNT7WAOcTX3OTCtidCHUNGjXmB7JcFzVZQTnyrmNwx1zUQWDXWeReIoAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rICGJAuT; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240508142852euoutp0205f6bf9abf2c903971c61396417eafd4~NicnH8AmN1216812168euoutp02Z
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 14:28:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240508142852euoutp0205f6bf9abf2c903971c61396417eafd4~NicnH8AmN1216812168euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715178532;
	bh=Ee/8LWKE8Bdug161RpQzHHNP1V/kv8tqluZ12pcxmBc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=rICGJAuTcwWu18Y1Bngi1eCeR9cDKLBeS1XhgvX+N7TJywIExS/SMM2pIPWxC3KlS
	 MvNVsZFndImYlqo+i/Ao6PbU5eSr2o/sDr/K5ajqu4bdrCqJZHZWvNGI6sd0QGbxWU
	 tc1qcpSMmrWiSXPx0bNnQbCv0daWcyibovWoqoks=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240508142852eucas1p2271d3539aa9161565a63cbd5690eb124~NicmrZ3EY2404324043eucas1p2p;
	Wed,  8 May 2024 14:28:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 6D.ED.09875.42C8B366; Wed,  8
	May 2024 15:28:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240508142851eucas1p16cd083e4d21fe5cbdabdbf2432ebe9d4~NicmPUZvq3031130311eucas1p1F;
	Wed,  8 May 2024 14:28:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240508142851eusmtrp18ffb71634008356173920ca41af363f7~NicmOpfTL1461514615eusmtrp1M;
	Wed,  8 May 2024 14:28:51 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-d3-663b8c247382
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.7B.08810.32C8B366; Wed,  8
	May 2024 15:28:51 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240508142851eusmtip181074c251253d1307a2fc8f7e5adaee1~NicmDybmA0363603636eusmtip16;
	Wed,  8 May 2024 14:28:51 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Wed, 8 May 2024 15:28:51 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Wed, 8 May
	2024 15:28:51 +0100
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
Thread-Index: AQHaoTxlCSlVdbHh/EKIyyNA4DF787GNKsyAgAAqDYA=
Date: Wed, 8 May 2024 14:28:50 +0000
Message-ID: <qye6lbmybiivdrr2vtlwgzzqelp7zoekezgiwo6mpirrl2576z@voszmqjbnm2q>
In-Reply-To: <f44dc19a-e117-4418-9114-b723c5dc1178@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCA90340567A254D9C51DF28E372D55C@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7djP87oqPdZpBvebBSw+3xWymLN+DZvF
	/73HGC2+rv/FbPH0Ux+LxaLfxhaXd81hs7i35j+rRc/uqYwWC04sZrRo/Hyf0eL3D6DEyVmT
	WSxmH73H7sDnsWbeGkaPnbPusnss2FTq0XLkLavH5hVaHov3vGTy2PRpErvHiRm/WTx2PrT0
	6G1+x+bxft9VNo/Pm+QCeKK4bFJSczLLUov07RK4Ml6e2chY8Eum4uf0ftYGxlbxLkZODgkB
	E4mT178zdzFycQgJrGCUWNO2nAXC+cIo8XnFE3YI5zOjxJHLL9hhWs6sfgiVWM4oseDLDCa4
	qr5Fe6CGnWaUaFjwjgmkBWzy9448EJtNQFNi38lNYKNEBDQkNrVtAGtgFvjOItH7/xRYQljA
	VmLR+R9sEEV2Eo0Lp7FA2FYS9z//AxvKIqAi8WRhA1g9r4CvROOX38wgNidQ/d0nf8HqGQVk
	JR6t/AVWwywgLnHryXwmiB8EJRbN3sMMYYtJ/Nv1kA3C1pE4e/0JI4RtILF16T4WCFtRouPY
	TTaIOToSC3Z/grItJVbNugA1X1ti2cLXzBD3CEqcnPkEHJISAhu5JNa+OMoKMchF4lnrGqgj
	hCVeHd/CPoFRZxaS+2Yh2TELyY5ZSHbMQrJjASPrKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k
	/NxNjMBEefrf8S87GJe/+qh3iJGJg/EQowQHs5IIb1WNdZoQb0piZVVqUX58UWlOavEhRmkO
	FiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QDU3uC28dlqt2H7888O8fwxF6BxPdVPXOOik1o
	a9T2XKY6y8DxClOZ0r6jeRXyP6rSD3deydv9+6Syn1XMB23Gctfor5/Op33mq59/7tVUW4WZ
	l8/FxOYJyM3L53jSO3fGF4EVnA/X5sdxnL656FPV8vj/z6Zfkm9Ont89OWMy/4QugdnfFUOt
	uryy0261ruSPubBp5a3KrP25GvFavmV1y2qnO/lUpb5eEzGPIyXQ832LgrGM1VanwNP2uhwx
	eRyTgtRPWlR9a3h2wlLk7j2Zb0qnfpuqnPvc8K7rfpYb220r605x6QsLCr9HPn+8SFBAeOfL
	y7MFVodoTa43kejjUPPxW9uk/Td9RkzwT4EfSizFGYmGWsxFxYkA0MKCpQMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsVy+t/xu7rKPdZpBsefGlp8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktFpxYzGjR+Pk+o8XvH0CJk7Mm
	s1jMPnqP3YHPY828NYweO2fdZfdYsKnUo+XIW1aPzSu0PBbvecnksenTJHaPEzN+s3jsfGjp
	0dv8js3j/b6rbB6fN8kF8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
	2aSk5mSWpRbp2yXoZbw8s5Gx4JdMxc/p/awNjK3iXYycHBICJhJnVj9k72Lk4hASWMoo8WX3
	PxaIhIzExi9XWSFsYYk/17rYIIo+Mkr8ONME5ZxmlOif/IEVwlnBKHFu5hGwFjYBTYl9Jzex
	g9giAhoSm9o2MIMUMQt8ZZH4vWUS2A5hAVuJRed/sEEU2Uk0LpzGAmFbSdz//I8JxGYRUJF4
	srABbBCvgK9E45ffzBDbepgk7r/8BbaNE6j57pO/YM2MArISj1b+AmtgFhCXuPVkPhPEEwIS
	S/acZ4awRSVePv4H9ZyOxNnrTxghbAOJrUv3QQNAUaLj2E02iDk6Egt2f4KyLSVWzboANV9b
	YtnC18wQxwlKnJz5hGUCo8wsJKtnIWmfhaR9FpL2WUjaFzCyrmIUSS0tzk3PLTbUK07MLS7N
	S9dLzs/dxAhMg9uO/dy8g3Heq496hxiZOBgPMUpwMCuJ8FbVWKcJ8aYkVlalFuXHF5XmpBYf
	YjQFBt5EZinR5HxgIs4riTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCU
	amDadH+b7gO1K2d2zmj83x6xv61Zpr+46GhqwKrqSRsXHt0f0L/xhG/7+q/5RftOXFH5tlSG
	5cKvzrPLPq0o3b3wYeYizUlPPyimNtQufGfbn+l4bPts10URRT7P2AWDv6kE3HthtO+/If+y
	6a/a3/E7pe1esYXVJGsiR5B3kf/31z13ppXlVP98L7xdspN15/bkVwcSb2xI2Oalurqg5MWM
	G4pfP2rvWJF57dSXQ9KGX29/qIyN83m6sbOnS673+vmCaJGXSpyPItZzF//Yf9RrqfRMnQcM
	jlufGaQqPuz9HPClIlfJ80zJDMap8SEnv9S+CfbNUr0vnPHQz2Pm5sy1YTetVq90nbyszzR6
	o3dqgxJLcUaioRZzUXEiAJLjG3cMBAAA
X-CMS-MailID: 20240508142851eucas1p16cd083e4d21fe5cbdabdbf2432ebe9d4
X-Msg-Generator: CA
X-RootMTR: 20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
	<CGME20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5@eucas1p1.samsung.com>
	<fqtaxc5pgu3zmvbdad4w6xty5iozye7v5z2b5ckqcjv273nz7b@hhdrjwf6rai3>
	<f44dc19a-e117-4418-9114-b723c5dc1178@redhat.com>

On Wed, May 08, 2024 at 01:58:19PM +0200, David Hildenbrand wrote:
> On 08.05.24 13:39, Daniel Gomez wrote:
> > On Mon, May 06, 2024 at 04:46:24PM +0800, Baolin Wang wrote:
> > > Anonymous pages have already been supported for multi-size (mTHP) all=
ocation
> > > through commit 19eaf44954df, that can allow THP to be configured thro=
ugh the
> > > sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugep=
age-XXkb/enabled'.
> > >=20
> > > However, the anonymous shared pages will ignore the anonymous mTHP ru=
le
> > > configured through the sysfs interface, and can only use the PMD-mapp=
ed
> > > THP, that is not reasonable. Many implement anonymous page sharing th=
rough
> > > mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenar=
ios,
> > > therefore, users expect to apply an unified mTHP strategy for anonymo=
us pages,
> > > also including the anonymous shared pages, in order to enjoy the bene=
fits of
> > > mTHP. For example, lower latency than PMD-mapped THP, smaller memory =
bloat
> > > than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TL=
B miss etc.
> > >=20
> > > The primary strategy is similar to supporting anonymous mTHP. Introdu=
ce
> > > a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled=
',
> > > which can have all the same values as the top-level
> > > '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a ne=
w
> > > additional "inherit" option. By default all sizes will be set to "nev=
er"
> > > except PMD size, which is set to "inherit". This ensures backward com=
patibility
> > > with the shmem enabled of the top level, meanwhile also allows indepe=
ndent
> > > control of shmem enabled for each mTHP.
> >=20
> > I'm trying to understand the adoption of mTHP and how it fits into the =
adoption
> > of (large) folios that the kernel is moving towards. Can you, or anyone=
 involved
> > here, explain this? How much do they overlap, and can we benefit from h=
aving
> > both? Is there any argument against the adoption of large folios here t=
hat I
> > might have missed?
>=20
> mTHP are implemented using large folios, just like traditional PMD-sized =
THP
> are. (you really should explore the history of mTHP and how it all works
> internally)

I'll check more in deep the code. By any chance are any of you going to be =
at
LSFMM this year? I have this session [1] scheduled for Wednesday and it wou=
ld
be nice to get your feedback on it and if you see this working together wit=
h
mTHP/THP.

[1] https://lore.kernel.org/all/4ktpayu66noklllpdpspa3vm5gbmb5boxskcj2q6qn7=
md3pwwt@kvlu64pqwjzl/

>=20
> The biggest challenge with memory that cannot be evicted on memory pressu=
re
> to be reclaimed (in contrast to your ordinary files in the pagecache) is
> memory waste, well, and placement of large chunks of memory in general,
> during page faults.
>=20
> In the worst case (no swap), you allocate a large chunk of memory once an=
d
> it will stick around until freed: no reclaim of that memory.

I can see that path being triggered by some fstests but only for THP (where=
 we
can actually reclaim memory).

>=20
> That's the reason why THP for anonymous memory and SHMEM have toggles to
> manually enable and configure them, in contrast to the pagecache. The sam=
e
> was done for mTHP for anonymous memory, and now (anon) shmem follows.
>=20
> There are plans to have, at some point, have it all working automatically=
,
> but a lot for that for anonymous memory (and shmem similarly) is still
> missing and unclear.

Thanks.

>=20
> --=20
> Cheers,
>=20
> David / dhildenb
> =

