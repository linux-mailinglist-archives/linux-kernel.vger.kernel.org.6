Return-Path: <linux-kernel+bounces-200564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB6B8FB1C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1675E1F25CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74519145B07;
	Tue,  4 Jun 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NmiNsJm4"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459D145B24
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502714; cv=none; b=rHJy/Ii3uPPhtMhmNi5dF81GV8kQ+QrhIOXszCNM4ZCzulBVRggrUeFx633lbVwgUMo4SOcO7Kxk3l3kEEFqtTwbHJ1713k9fboijfPo+7HbQjyb/Ut/GIL3RBt+iFjLKfRlHEyk94gX505nwFlHC9wMmw1AcSN6XvtulAA36vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502714; c=relaxed/simple;
	bh=gzyR+r4MVcGEy80LuGTWvExKbsENizJiN8bfQ5ueIp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=jxJrImsp08bxIQBy0Hu9IxCnfT8gEKROnb2ZJ+qYPG3jxem71tRMFS33WJa3KRJu6DJbDSv6VfdXS3tfacpgFs7sCDs8zu7qH9FurGkAVAUAor5dlcvi6U8o+dwMwJS3j1tJQIf31LTdX66mIv7/vawqclq96kbMdbm+9rwsPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NmiNsJm4; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240604120509euoutp015fb32338397690d257638a0791b42b3a~Vy50-gWJw0114701147euoutp013
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:05:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240604120509euoutp015fb32338397690d257638a0791b42b3a~Vy50-gWJw0114701147euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717502709;
	bh=ujyDAueFU0ueHoZ2LCjEyMg709fGrZxMD4K6XjPZZao=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=NmiNsJm4ePp5Czbfy7Su7lCitlodaJwxTnfJBLP6XyXDEhZ9HxPfzqi9vUc1plb/E
	 j5Q7b0Y3ok3458aCWoKc9a8vWc78BTtETL5J4iv1nCNp72S2YVGrdn5iiO641skK2k
	 jXq7CSgIh3Ow4PDtgX1VkAAIhutkDQl7Wwxduheg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240604120508eucas1p18d8f0008c10da141f946a64f3592a5a1~Vy50pqr6q2995429954eucas1p1K;
	Tue,  4 Jun 2024 12:05:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F2.EC.09620.4F20F566; Tue,  4
	Jun 2024 13:05:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240604120508eucas1p2720dde9043fea10eecf7a657b73654dd~Vy50SPvDF0293202932eucas1p2B;
	Tue,  4 Jun 2024 12:05:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240604120508eusmtrp25275453ff6e892870081832102dd2d24~Vy50L27ti2140521405eusmtrp28;
	Tue,  4 Jun 2024 12:05:08 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-b3-665f02f488ea
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id EF.22.08810.4F20F566; Tue,  4
	Jun 2024 13:05:08 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240604120508eusmtip264ee581e43ea58d86f738648299a37bf~Vy5z_GFHf0717107171eusmtip2w;
	Tue,  4 Jun 2024 12:05:08 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 4 Jun 2024 13:05:07 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Tue, 4 Jun
	2024 13:05:07 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
CC: David Hildenbrand <david@redhat.com>, "akpm@linux-foundation.org"
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
Thread-Index: AQHasjX9yP1IBMh0VkC4Fzv01OfbabGxBpEAgAAKfoCAABD5AIAGGG2AgAAYLgCAACcNAA==
Date: Tue, 4 Jun 2024 12:05:07 +0000
Message-ID: <5mezgqzg7wmd4iq2d2q3aentziosetwcll3tgdbl3mhriseyv3@pgxsux7qvxno>
In-Reply-To: <f11c1b52-67d1-4c2a-834b-47302b0054bc@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F19C76AAA3B474A9E43CDC9B90258A6@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7djPc7pfmOLTDGad0Lb4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InisklJzcksSy3St0vgyli5u5+1YLNExfqrTawNjLuFuhg5OSQE
	TCT2zp/KCGILCaxglPi1ObaLkQvI/sIo8XrRdmYI5zOjxLsNjxhhOg4seQSVWM4osWLWD3a4
	qsvnZkJlTjNKbG+5ygjhAA1uabrKBtLPJqApse/kJqAWDg4RAX2J3rm+IDXMAtNYJTp/3wfb
	ISzgIDFzcS8riC0i4ChxA6pXRCBMouXkASYQm0VAReLnjh0sIHN4BXwlVs9RBglzCrhKXGxc
	ATaGUUBW4tHKX+wgNrOAuMStJ/OZIF4QlFg0ew8zhC0m8W/XQzYIW0fi7PUnUG8aSGxduo8F
	wlaU6Dh2kw1ijo7Egt2foGxLif0PTjBD2NoSyxa+BrN5geafnPkEqncnl8S+VVwQtovE9zkf
	oW4Qlnh1fAv7BEadWUjOm4VkxSwkK2YhWTELyYoFjKyrGMVTS4tz01OLjfNSy/WKE3OLS/PS
	9ZLzczcxAlPk6X/Hv+5gXPHqo94hRiYOxkOMEhzMSiK8fXXRaUK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1MUp8FzQ07aj+tvr4rPtbhk7B74YKdnmI1
	utke6Z/nLFzhZ6m54Gpl5+Ri2zW/ZieqMvs8OmRd99yk4/arE9N72DMkdp942v7zjd7rHo2p
	FvJirXN/fbn9eNXcGS1hvXXJj9eq7dn54ni6DtvLdAnHDQ5t6wWd7901cnn5inVfx60Tnzim
	3yo45bxmbmuJe9uM7lcG4f9/cdqvETG50NWY2mnP9/n+v2tHd3p0zZOtSjlz+H6l0HT1P9fN
	o6/6O0cobLjGOONetew1Tev7k5iiX/guKcmSn3h9ywSPFcWF4U/bUpY2yeS7M++dZ+NV9p/t
	NXes9FGeRStO1/zhk09M1+fNWbbHyFc47M7t1y9WKrEUZyQaajEXFScCAFNZnaoABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsVy+t/xe7pfmOLTDFbP5Lb4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
	s0lJzcksSy3St0vQy1i5u5+1YLNExfqrTawNjLuFuhg5OSQETCQOLHnE3MXIxSEksJRRYsGm
	40wQCRmJjV+uskLYwhJ/rnWxQRR9ZJQ49OcGlHOaUWL2hNMsEM4KRolL5w6xgLSwCWhK7Du5
	ib2LkYNDREBfoneuL0gNs8A0VonO3/cZQWqEBRwkZi7uBVshIuAocaPpKhuEHSbRcvIA2Bks
	AioSP3fsYAGZwyvgK7F6jjLErm3MEpf/3QOr5xRwlbjYuAJsJqOArMSjlb/YQWxmAXGJW0/m
	Q70jILFkz3lmCFtU4uXjf1Cv6Uicvf6EEcI2kNi6dB8LhK0o0XHsJhvEHB2JBbs/QdmWEvsf
	nGCGsLUlli18DWbzCghKnJz5hGUCo8wsJKtnIWmfhaR9FpL2WUjaFzCyrmIUSS0tzk3PLTbU
	K07MLS7NS9dLzs/dxAhMgduO/dy8g3Heq496hxiZOBgPMUpwMCuJ8PbVRacJ8aYkVlalFuXH
	F5XmpBYfYjQFht1EZinR5HxgEs4riTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgt
	gulj4uCUamAy4N549ef+Y52lMZvPKU2NkEs+uv+ow/uX5/3ZC904G5YYtF/e0LTc3zk/Yruj
	unlaUNqKFRH3JWvN9K/cONiz7KpG1l5+5p+OW82/y83Keikvudx0W/YZLb6lbBOWXm9p1Dig
	PPeXtLiCReCyntnNy/ozeZx3Zp1/yhUk7r3T+V3nC5VpnswrJgudvvYmovnKtJUX4iIXTDfc
	ui7CcLkY4zV1lab5pmv4VvULXXsV/O5IwUOu7x9Y+hZlHZnDLD3zxOOPP28tK7q8+8esKzxZ
	9TvOzr0f1GfywHvHwf6ip54/En4+an9wTnyFi8rOxdqM+sX3515jnb54p32+Jvuh9kf3espk
	ywPuRdooeh19pcRSnJFoqMVcVJwIAM+FgBQKBAAA
X-CMS-MailID: 20240604120508eucas1p2720dde9043fea10eecf7a657b73654dd
X-Msg-Generator: CA
X-RootMTR: 20240531111357eucas1p2338be7f326d8d9176d2ee212a10fc9db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531111357eucas1p2338be7f326d8d9176d2ee212a10fc9db
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
	<f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
	<db3517d0-54b1-4d3a-b798-1c13572d07be@linux.alibaba.com>
	<CGME20240531111357eucas1p2338be7f326d8d9176d2ee212a10fc9db@eucas1p2.samsung.com>
	<502fb3df-b42b-4f0c-a98d-348c3d544721@redhat.com>
	<slkkien5nc3weyzebdlxs5jjvealqzmctbom7sfvijvkolhsjj@athcc2aqq77p>
	<f11c1b52-67d1-4c2a-834b-47302b0054bc@linux.alibaba.com>

On Tue, Jun 04, 2024 at 05:45:20PM +0800, Baolin Wang wrote:
>=20
>=20
> On 2024/6/4 16:18, Daniel Gomez wrote:
> > On Fri, May 31, 2024 at 01:13:48PM +0200, David Hildenbrand wrote:
> > > > >=20
> > > > > As a default, we should not be using large folios / mTHP for any =
shmem,
> > > > > just like we did with THP via shmem_enabled. This is what this se=
ries
> > > > > currently does, and is aprt of the whole mTHP user-space interfac=
e design.
> > > > >=20
> > > > > Further, the mTHP controls should control all of shmem, not only
> > > > > "anonymous shmem".
> > > >=20
> > > > Yes, that's what I thought and in my TODO list.
> > >=20
> > > Good, it would be helpful to coordinate with Daniel and Pankaj.
> >=20
> > I've integrated patches 11 and 12 from the lsf RFC thread [1] on top of=
 Baolin's
> > v3 patches. You may find a version in my integration branch here [2]. I=
 can
> > attach them here if it's preferred.
> >=20
> > [1] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung=
.com/
> > [2] https://protect2.fireeye.com/v1/url?k=3Da23e7c06-c3b56926-a23ff749-=
74fe485fb347-371ca2bfd5d9869f&q=3D1&e=3D6974304e-a786-4255-93a7-57498540241=
c&u=3Dhttps%3A%2F%2Fgitlab.com%2Fdkruces%2Flinux-next%2F-%2Fcommits%2Fnext-=
20240604-shmem-mthp
> >=20
> > The point here is to combine the large folios strategy I proposed with =
mTHP
> > user controls. Would it make sense to limit the orders to the mapping o=
rder
> > calculated based on the size and index?
>=20
> IMO, for !anon shmem, this change makes sense to me. We should respect th=
e
> size and mTHP should act as a order filter.

What about respecing the size when within_size flag is enabled? Then, 'alwa=
ys'
would allocate mTHP enabled folios, regardless of the size. And 'never'
would ignore mTHP and size. So, 'never' can be used for this 'safe' boot ca=
se
mentioned in the discussion.

>=20
> For anon shmem, we should ignore the length, which you always set it to
> PAGE_SIZE in patch [1].
>=20
> [1] https://protect2.fireeye.com/v1/url?k=3D0d75a0c6-6cfeb5e6-0d742b89-74=
fe485fb347-904fa75c8efebdc2&q=3D1&e=3D6974304e-a786-4255-93a7-57498540241c&=
u=3Dhttps%3A%2F%2Fgitlab.com%2Fdkruces%2Flinux-next%2F-%2Fcommit%2Fedf02311=
fd6d86b355d3aeb74e67c8da6de3c569

Since we are ignoring the length, we should ignore any value being passed.

>=20
> > @@ -1765,6 +1798,10 @@ static struct folio *shmem_alloc_and_add_folio(s=
truct vm_fault *vmf,
> >=20
> >                  order =3D highest_order(suitable_orders);
> >                  while (suitable_orders) {
> > +                       if (order > mapping_order) {
> > +                               order =3D next_order(&suitable_orders, =
order);
> > +                               continue;
> > +                       }
> >                          pages =3D 1UL << order;
> >                          index =3D round_down(index, pages);
> >                          folio =3D shmem_alloc_folio(gfp, order, info, =
index);
> >=20
> > Note: The branch still need to be adapted to include !anon mm.=

