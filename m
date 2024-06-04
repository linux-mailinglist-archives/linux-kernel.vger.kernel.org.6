Return-Path: <linux-kernel+bounces-200238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92B88FAD59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216F7B21F11
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A11422A7;
	Tue,  4 Jun 2024 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k7wRSzgq"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E53139CFF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489135; cv=none; b=BIsOZGonTres63Zu2s8A/v3VATQwDyxKfHV6VUYVIu1pZqKHiH+lIeKqZhVk1M8Ocd5Sulu1ViaUEQW/jaQSyZesBZBLN0wO4ooHHk2uE5WRrbRQJIyT2CXrmsGwVpeQd6jNNRgLlNAMjHs7L8LSaNSnSunk0K9gTbvFPK/9Pwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489135; c=relaxed/simple;
	bh=x5ZqEQSizYWGhruT4c8lIiz164hwxvA5julTkLNsKYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=TFAwrCsYI/nAnApoFMl3Io/eyaN/zuJV9Q26ghvAo204TSDtUqwi/A3GAT29PegEEyBjh4tMYF3Vg2egkMpmGcnZTq4p018FqfhT97fUy8ggVdyCmc9oJSj4RddP5Eb53lBKpvksjXpOL8guv3rfvAFgx3BF5zmUaDMJUT8ZRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=k7wRSzgq; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240604081850euoutp0141978b128b48ba8f1f8f87f7d065076a~Vv0O78mvU0856608566euoutp01x
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:18:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240604081850euoutp0141978b128b48ba8f1f8f87f7d065076a~Vv0O78mvU0856608566euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717489130;
	bh=3uVJ03wHHaJoCeSH6rZGt0UVQDtWvA6kGyOdcJXdKr8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=k7wRSzgqzmP+nXWj45q5oO2HOh6sjbtKCeUNkmLq9008FVHXfJzdfptDy6PraWFNM
	 4yeNQY/KcY5/2Sdfocyw6Azyu9CPxBIymtSaATrav2nzuvqgQJ3dkalaHSRiCk5lWf
	 hyj+jKfBfQsvrZNNT2BjIw1N3xy5BFl1RKuDn1Hk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240604081850eucas1p2c7c6ea5d8c237786ba22a4edb2489300~Vv0OqpWvm1807418074eucas1p2a;
	Tue,  4 Jun 2024 08:18:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B5.5D.09624.AEDCE566; Tue,  4
	Jun 2024 09:18:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240604081849eucas1p1ea15f8fe8c27c90fae6b7614dfd98b37~Vv0OIIxnl0373503735eucas1p12;
	Tue,  4 Jun 2024 08:18:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240604081849eusmtrp2f3bcefffc5a58f14e77c1345e76c32e0~Vv0OHTubW2263022630eusmtrp2O;
	Tue,  4 Jun 2024 08:18:49 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-3b-665ecdea347b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 21.C6.09010.9EDCE566; Tue,  4
	Jun 2024 09:18:49 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240604081849eusmtip176168a20bb66ea38ab6d2f3d74fa2db7~Vv0NylVOW0291302913eusmtip1h;
	Tue,  4 Jun 2024 08:18:49 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 4 Jun 2024 09:18:48 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Tue, 4 Jun
	2024 09:18:47 +0100
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
Thread-Index: AQHasjX9yP1IBMh0VkC4Fzv01OfbabGxBpEAgAAKfoCAABD5AIAGGG2A
Date: Tue, 4 Jun 2024 08:18:47 +0000
Message-ID: <slkkien5nc3weyzebdlxs5jjvealqzmctbom7sfvijvkolhsjj@athcc2aqq77p>
In-Reply-To: <502fb3df-b42b-4f0c-a98d-348c3d544721@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F756A7429FB0844D968B2E9DCEEE54D5@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7djP87qvzsalGXz7wGnx+a6QxZz1a9gs
	/u89xmjxdf0vZounn/pYLBb9Nra4vGsOm8W9Nf9ZLXp2T2W0WHBiMaNF4+f7jBa/fwAlTs6a
	zGIx++g9dgc+jzXz1jB67Jx1l91jwaZSj5Yjb1k9Nq/Q8li85yWTx6ZPk9g9Tsz4zeKx86Gl
	R2/zOzaP9/uusnl83iQXwBPFZZOSmpNZllqkb5fAlfFr4UTmgnNyFQ/nzGJvYHwm1sXIySEh
	YCKxY9MR1i5GLg4hgRWMEq/6HzFCOF8YJZb13IVyPjNKbDu7lR2mZeW/k1CJ5YwSZ+d8YYKr
	enPmB1TmNKPErI6XTHCT+/d3MIH0swloSuw7uQlsloiAhsSmtg3MIDazwFxWiYPtISC2sICD
	xMzFvawQNY4SN5quskHYbhKd358B1XNwsAioSBxfwg1i8gr4Smw8xQNSwSlgJ9He9wGsk1FA
	VuLRyl/sENPFJW49mc8E8YGgxKLZe5ghbDGJf7seskHYOhJnrz9hhLANJLYu3ccCYStKdBy7
	yQYxR0diwe5PULalxOWdP6FsbYllC1+DzeQFmn9y5hMWkNclBNZyScxavp4VYpCLxM//G6CW
	CUu8Or6FfQKjziwk981CsmMWkh2zkOyYhWTHAkbWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ
	+bmbGIFJ8vS/4592MM599VHvECMTB+MhRgkOZiUR3r666DQh3pTEyqrUovz4otKc1OJDjNIc
	LErivKop8qlCAumJJanZqakFqUUwWSYOTqkGpr6vU22bFHhvSjyxacx91p60PMeiqIyl2Ejq
	ivVDqx3bMlqmLVxkue2RUOePvzuEWprn3qiqePjxl42dhPnpjV+/N74L3Slz+xLPiwk74uel
	z6tkLHzHuOJATnxQDdfcdY/cyt7evVqW+PPLzJ1bLCwKRO5bGoWf4ivrc7NUnt9ZXDlXdonj
	FDWprdPvFr72F7EVvSe75Hp3U2x5VLhpSW+p8MJs5hMMqxwsu+Jj/Y+leCoXREj5lXzSDV7O
	Fcv8s+7iz7c/076+1S3t2P2wtTn9cChLvXyDmdK5K287tkWksT/K3re/j+nNjrqUh5GCUn1v
	BJn0GVtNHbYe1sz95cG24UvUs965YeHX7jxTYinOSDTUYi4qTgQAbYDLhwEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsVy+t/xu7ovz8alGXx6pmTx+a6QxZz1a9gs
	/u89xmjxdf0vZounn/pYLBb9Nra4vGsOm8W9Nf9ZLXp2T2W0WHBiMaNF4+f7jBa/fwAlTs6a
	zGIx++g9dgc+jzXz1jB67Jx1l91jwaZSj5Yjb1k9Nq/Q8li85yWTx6ZPk9g9Tsz4zeKx86Gl
	R2/zOzaP9/uusnl83iQXwBOlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
	Z5OSmpNZllqkb5egl/Fr4UTmgnNyFQ/nzGJvYHwm1sXIySEhYCKx8t9Jxi5GLg4hgaWMEoca
	djJDJGQkNn65ygphC0v8udbFBlH0kVFi6bwprBDOaUaJI/eeQ7WvYJR4d249WDubgKbEvpOb
	2EFsEQENiU1tG8DizAJzWSUOtoeA2MICDhIzF/eyQtQ4StxousoGYbtJdH5/BlTPwcEioCJx
	fAk3iMkr4Cux8RQPxKrtTBI73hwDa+UUsJNo7/sAZjMKyEo8WvmLHWKVuMStJ/OZID4QkFiy
	5zzUZ6ISLx//g/pMR+Ls9SeMELaBxNal+1ggbEWJjmM32SDm6Egs2P0JyraUuLzzJ5StLbFs
	4WuwmbwCghInZz5hmcAoMwvJ6llI2mchaZ+FpH0WkvYFjKyrGEVSS4tz03OLjfSKE3OLS/PS
	9ZLzczcxAhPgtmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8fXXRaUK8KYmVValF+fFFpTmpxYcY
	TYFBN5FZSjQ5H5iC80riDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUa
	mKalb9D4bpBSE37C/sbO0w1GR4w3p86K/vGivER3prXjuklVfw8ruD7q8eS/yXgq8Z35jTrR
	/QGLJk7YXtminx8azSoQtfxU+P6De1Q4UuZ1mCx3mTprSrZl7jKxezlr/npF/JF3On7z6yOT
	BXvdgh5ZrglNXb3w/tz5/1flJHAu0+VZntv2O0i4dM6MMhkOCUHl0/MVbvyaXDGvpsRfu44z
	0z7T+3p1RkLnsuufpR0FQ07daGJt4MlInqNlZbVTc0Wd4u4t3GH+5fKlDo59vwrfKj+vnF6y
	X8786c7D3/4y9S3cFDOD4/aDvOr4WBeeyUc+y/+9LGC60mrVz6TZ99rs++5926C5SsM0zGnZ
	cSWW4oxEQy3mouJEAK0yddUJBAAA
X-CMS-MailID: 20240604081849eucas1p1ea15f8fe8c27c90fae6b7614dfd98b37
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

On Fri, May 31, 2024 at 01:13:48PM +0200, David Hildenbrand wrote:
> > >=20
> > > As a default, we should not be using large folios / mTHP for any shme=
m,
> > > just like we did with THP via shmem_enabled. This is what this series
> > > currently does, and is aprt of the whole mTHP user-space interface de=
sign.
> > >=20
> > > Further, the mTHP controls should control all of shmem, not only
> > > "anonymous shmem".
> >=20
> > Yes, that's what I thought and in my TODO list.
>=20
> Good, it would be helpful to coordinate with Daniel and Pankaj.

I've integrated patches 11 and 12 from the lsf RFC thread [1] on top of Bao=
lin's
v3 patches. You may find a version in my integration branch here [2]. I can
attach them here if it's preferred.

[1] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com=
/
[2] https://gitlab.com/dkruces/linux-next/-/commits/next-20240604-shmem-mth=
p

The point here is to combine the large folios strategy I proposed with mTHP
user controls. Would it make sense to limit the orders to the mapping order
calculated based on the size and index?

@@ -1765,6 +1798,10 @@ static struct folio *shmem_alloc_and_add_folio(struc=
t vm_fault *vmf,

                order =3D highest_order(suitable_orders);
                while (suitable_orders) {
+                       if (order > mapping_order) {
+                               order =3D next_order(&suitable_orders, orde=
r);
+                               continue;
+                       }
                        pages =3D 1UL << order;
                        index =3D round_down(index, pages);
                        folio =3D shmem_alloc_folio(gfp, order, info, index=
);

Note: The branch still need to be adapted to include !anon mm.

>=20
> >=20
> > >=20
> > > Also, we should properly fallback within the configured sizes, and no=
t
> > > jump "over" configured sizes. Unless there is a good reason.
> > >=20
> > > (3) khugepaged
> > >=20
> > > khugepaged needs to handle larger folios properly as well. Until fixe=
d,
> > > using smaller THP sizes as fallback might prohibit collapsing a
> > > PMD-sized THP later. But really, khugepaged needs to be fixed to hand=
le
> > > that. >
> > > (4) force/disable
> > >=20
> > > These settings are rather testing artifacts from the old ages. We sho=
uld
> > > not add them to the per-size toggles. We might "inherit" it from the
> > > global one, though.
> >=20
> > Sorry, I missed this. So I thould remove the 'force' and 'deny' option
> > for each mTHP, right?
>=20
> Yes, that's my understanding. But we have to keep them on the top level f=
or
> any possible user out there.
>=20
> >=20
> > >=20
> > > "within_size" might have value, and especially for consistency, we
> > > should have them per size.
> > >=20
> > >=20
> > >=20
> > > So, this series only tackles anonymous shmem, which is a good startin=
g
> > > point. Ideally, we'd get support for other shmem (especially during
> > > fault time) soon afterwards, because we won't be adding separate togg=
les
> > > for that from the interface POV, and having inconsistent behavior
> > > between kernel versions would be a bit unfortunate.
> > >=20
> > >=20
> > > @Baolin, this series likely does not consider (4) yet. And I suggest =
we
> > > have to take a lot of the "anonymous thp" terminology out of this
> > > series, especially when it comes to documentation.
> >=20
> > Sure. I will remove the "anonymous thp" terminology from the
> > documentation, but want to still keep it in the commit message, cause I
> > want to start from the anonymous shmem.
>=20
> For commit message and friends makes sense. The story should be "controls
> all of shmem/tmpfs, but support will be added iteratively. The first step=
 is
> anonymous shmem."
>=20
> --=20
> Cheers,
>=20
> David / dhildenb
> =

