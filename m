Return-Path: <linux-kernel+bounces-200349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20BA8FAEC5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE7A1F2173C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F60143C4C;
	Tue,  4 Jun 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BDSjoCzz"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555314387B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493375; cv=none; b=jgNDYLzZ0id/bsewzLRUAm4fQ+GnSpWwpGTnF1VLSgSsXFdJ3ksllQ1X/E34yH7WohPoovrKFIhArx1gUhH88foZlFtgJuVeVKBjpqA+uBY2vUelUmZemsxyYf3X6H989mR+5bXy9mKop23VLoAwgH3aRK3CXINI31QPi7eQImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493375; c=relaxed/simple;
	bh=Yc5jW4lxOdcDfqizFQVJgSqliOCL3B12pvN7jexmqkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=rlOhB5MmVbTisVH8HS0enAMhjHIJ3++9P/sFJGKcip3y2bwnQSdAM+pmRXiTjbqvsbfWav7103JBOhitSkgws+D6uhGIQMEhaIaRAjYQsQlT973qNQSVOVIYq3vA7Frq0s3+da1T/Wd4treIoKIIHcxnjwBCnfZcI/n73c1zqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BDSjoCzz; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240604092930euoutp01f7c6b260a7d62379d48563a5cc6f8f0e~Vwx7XT0ry2062920629euoutp01V
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:29:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240604092930euoutp01f7c6b260a7d62379d48563a5cc6f8f0e~Vwx7XT0ry2062920629euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717493370;
	bh=Yc5jW4lxOdcDfqizFQVJgSqliOCL3B12pvN7jexmqkE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BDSjoCzzKl2wP5PRsR085oX2F5IiRJBUZNq4YB4Ulm1kG+2rQaItkjW33Zk/hFQGF
	 FL4nL+U0yqj1I7b/5PeDOXAgRy94SSPb2re1moHjwv+wAc55KUhyaO06Yj2RbnPQv/
	 TVU26tKpajIUS57nWPKUI1CYQGdo68GELjpm2uq0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240604092929eucas1p16ab4b299453b7079e5756d66992fff93~Vwx6x5Gf60520305203eucas1p1G;
	Tue,  4 Jun 2024 09:29:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 44.0F.09624.97EDE566; Tue,  4
	Jun 2024 10:29:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240604092929eucas1p220b12ab9df8d97b63d7986788a57f0f0~Vwx6Vq6-N1370913709eucas1p2x;
	Tue,  4 Jun 2024 09:29:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240604092929eusmtrp19911c8d83e99216dd68dabc40c6e574b~Vwx6Uya8M1368113681eusmtrp1w;
	Tue,  4 Jun 2024 09:29:29 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-24-665ede796643
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 91.75.09010.87EDE566; Tue,  4
	Jun 2024 10:29:28 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240604092928eusmtip238958ac1606802e288b01c6821150426~Vwx6IQ2J22194621946eusmtip2v;
	Tue,  4 Jun 2024 09:29:28 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Tue, 4 Jun 2024 10:29:27 +0100
Received: from CAMSVWEXC01.scsc.local ([::1]) by CAMSVWEXC01.scsc.local
	([fe80::7d73:5123:34e0:4f73%13]) with mapi id 15.00.1497.012; Tue, 4 Jun
	2024 10:29:27 +0100
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
Thread-Index: AQHasjX9yP1IBMh0VkC4Fzv01OfbabGxBpEAgAA+eQCAABeXAIAF8ZEA
Date: Tue, 4 Jun 2024 09:29:26 +0000
Message-ID: <zz23hukm6kpguehfsxmzdtam34bj2opt63oesspwsikw57bpqy@eftgscqy3bly>
In-Reply-To: <f0618bca-119b-417a-a19d-699084476f88@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <797394D7AE3BE04F92D50A4ED07A2A04@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7djP87qV9+LSDB7MlbD4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InisklJzcksSy3St0vgypj0ZiVLwV+riqeHnjM2MC7R62Lk5JAQ
	MJGYuOs5UxcjF4eQwApGie/LPjNCOF8YJe4+vMUMUiUk8JlRYulVTpiO761r2SCKljNKrFx4
	lB2u6OYLUYjEaUaJiaufs8HNffX9LSNIFZuApsS+k5vAOkQENCQ2tW0AW8EsMJdV4mB7CIgt
	LOAgMXNxLytEjaPEjaarbBC2m8Savm4mEJtFQEWibe58sDm8Ar4S3//eAJvPKWAn0XhkP1gv
	o4CsxKOVv9gh5otL3HoynwniBUGJRbP3MEPYYhL/dj1kg7B1JM5ef8IIYRtIbF26jwXCVpTo
	OHaTDWKOjsSC3Z+gbEuJXy/+s0DY2hLLFr5mhrhHUOLkzCcsIM9LCGzkkjjycgMrxCAXiU93
	Z7JD2MISr45vYZ/AqDMLyX2zkOyYhWTHLCQ7ZiHZsYCRdRWjeGppcW56arFhXmq5XnFibnFp
	Xrpecn7uJkZgkjz97/inHYxzX33UO8TIxMF4iFGCg1lJhLevLjpNiDclsbIqtSg/vqg0J7X4
	EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqgSnFKt9U6Z73DO6G33JXqrbsT0k1FAjv
	eMo2q9poJ0v0ty0h1f8i9AOFtdoyzE3Z9vy4vH/rHhX1W+kJsovfZVsbs54/Z/HuzYv2FjYj
	c87KDdMZpu5jUzGtu9n6u0jjjeouvUaPvDnM3/ICZr4TbSn+4PdhjtzeBdLXI1/e+xgqYSOm
	pyx6xzVdi+fnmRJfDt2vb098yG669ND+Wpd9x66o9VsqWUXjnK7vt3lWLOs7K/1CaNctsee9
	3qw1jRXNH/raNmQ7tuRNTk1e8eUnR9p7dzE7jSVls+33KuqvFdKfMIs1+ryG1O0VH+9tX++r
	9l/zEPtdPpfwrLCTm361rv0UIzW5ZG/17b18UzeKKrEUZyQaajEXFScCAGAcUuUBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsVy+t/xe7oV9+LSDFaut7L4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaLDixmNGi8fN9RovfP4ASJ2dN
	ZrGYffQeuwOfx5p5axg9ds66y+6xYFOpR8uRt6wem1doeSze85LJY9OnSeweJ2b8ZvHY+dDS
	o7f5HZvH+31X2Tw+b5IL4InSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3
	s0lJzcksSy3St0vQy5j0ZiVLwV+riqeHnjM2MC7R62Lk5JAQMJH43rqWrYuRi0NIYCmjxJc1
	bSwQCRmJjV+uskLYwhJ/rnVBFX1klOjo+scC4ZxmlOi7c58NpEpIYAWjxNefLiA2m4CmxL6T
	m9hBbBEBDYlNbRuYQWxmgbmsEgfbQ0BsYQEHiZmLe1khahwlbjRdZYOw3STW9HUzgdgsAioS
	bXPng83hFfCV+P73BiPE4gNMEitnzwYbyilgJ9F4ZD/YIEYBWYlHK3+xQywTl7j1ZD4TxAsC
	Ekv2nGeGsEUlXj7+B/WajsTZ608YIWwDia1L90G9ryjRcewmG8QcHYkFuz9B2ZYSv178Z4Gw
	tSWWLXzNDHGcoMTJmU9YJjDKzEKyehaS9llI2mchaZ+FpH0BI+sqRpHU0uLc9NxiI73ixNzi
	0rx0veT83E2MwBS47djPLTsYV776qHeIkYmD8RCjBAezkghvX110mhBvSmJlVWpRfnxRaU5q
	8SFGU2DgTWSWEk3OBybhvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYO
	TqkGpo2emWeuJjR9Lp299KfNp9/F7JcKvq/knv/hStn7d3kpHn3FF08Y9oRkWh3496K42Ou3
	5vqfAjpHT3ondM5Ye95LaVNXYXtHHpO+dLyMt7tXgO2F6x/ymW+EXvytx2s+X6NmZlLoE/2S
	nM6+N4Z9/nOtwoUN5nbkNJ19vnQO+7KOR0rzo4rOVn7wPR4X/KxjWon2zqX/UqYkxjJe+PXw
	nM3jZRMsJKezlW7458AkZhZ7qS9uwSSmPIWJXF8OWm+KezQ/5rfHatuAeMY/rhbR+Rekq76f
	PM6a+M3HY0e3odGjw8WeygkNczvbzTMnb19TI/PggcxygecxOce26sSlfIzTOdZ3UOmoWcBr
	H+5EJZbijERDLeai4kQASv8mhAoEAAA=
X-CMS-MailID: 20240604092929eucas1p220b12ab9df8d97b63d7986788a57f0f0
X-Msg-Generator: CA
X-RootMTR: 20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
	<CGME20240531093540eucas1p257ec781a06607de130ea1fff8cfa080a@eucas1p2.samsung.com>
	<f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
	<vlkkfcyumveggkddb6d44f55gtx4qonoiijxyofa63mtmkuofv@uf4nbw3r5ysh>
	<f0618bca-119b-417a-a19d-699084476f88@redhat.com>

On Fri, May 31, 2024 at 04:43:32PM +0200, David Hildenbrand wrote:
> Hi Daniel,
>=20
> > > Let me summarize the takeaway from the bi-weekly MM meeting as I unde=
rstood
> > > it, that includes Hugh's feedback on per-block tracking vs. mTHP:
> >=20
> > Thanks David for the summary. Please, find below some follow up questio=
ns.
> >=20
> > I want understand if zeropage scanning overhead is preferred over per-b=
lock
> > tracking complexity or if we still need to verify this.
> >=20
> > >=20
> > > (1) Per-block tracking
> > >=20
> > > Per-block tracking is currently considered unwarranted complexity in
> > > shmem.c. We should try to get it done without that. For any test case=
s that
> > > fail, we should consider if they are actually valid for shmem.
> >=20
> > I agree it was unwarranted complexity but only if this is just to fix l=
seek() as
> > we can simply make the test pass by checking if holes are reported as d=
ata. That
> > would be the minimum required for lseek() to be compliant with the sysc=
all.
> >=20
> > How can we use per-block tracking for reclaiming memory and what change=
s would
> > be needed? Or is per-block really a non-viable option?
>=20
> The interesting thing is: with mTHP toggles it is opt-in -- like for
> PMD-sized THP with shmem_enabled -- and we don't have to be that concerne=
d
> about this problem right now.

Without respecting the size when allocating large folios, mTHP toggles woul=
d
over allocate. My proposal added earlier to this thread is to combine the 2
to avoid that case. Otherwise, shouldn't we try to find a solution for the
reclaiming path?

>=20
> >=20
> > Clearly, if per-block is viable option, shmem_fault() bug would require=
d to be
> > fixed first. Any ideas on how to make it reproducible?
> >=20
> > The alternatives discussed where sub-page refcounting and zeropage scan=
ning.
>=20
> Yeah, I don't think sub-page refcounting is a feasible (and certainly not
> desired ;) ) option in the folio world.
>=20
> > The first one is not possible (IIUC) because of a refactor years back t=
hat
> > simplified the code and also requires extra complexity. The second opti=
on would
> > require additional overhead as we would involve scanning.
>=20
> We'll likely need something similar (scanning, tracking?) for anonymous
> memory as well. There was a proposal for a THP shrinker some time ago, th=
at
> would solve part of the problem.

It's good to know we have the same problem in different places. I'm more
inclined to keep the information rather than adding an extra overhead. Unle=
ss
the complexity is really overwhelming. Considering the concerns here, not s=
ure
how much should we try merging with iomap as per Ritesh's suggestion.

The THP shrinker, could you please confirm if it is this following thread?

https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/

>=20
> For example, for shmem you could simply flag folios that failed splitting
> during fallocate() as reclaim candidates and try to reclaim memory later.=
 So
> you don't have to scan arbitrary folios (which might also be desired,
> though).

Thanks for the suggestion. I'll look into this.

>=20
> >=20
> > >=20
> > > To optimize FALLOC_FL_PUNCH_HOLE for the cases where splitting+freein=
g
> > > is not possible at fallcoate() time, detecting zeropages later and
> > > retrying to split+free might be an option, without per-block tracking=
.
> >=20
> > >=20
> > > (2) mTHP controls
> > >=20
> > > As a default, we should not be using large folios / mTHP for any shme=
m, just
> > > like we did with THP via shmem_enabled. This is what this series curr=
ently
> > > does, and is aprt of the whole mTHP user-space interface design.
> >=20
> > That was clear for me too. But what is the reason we want to boot in 's=
afe
> > mode'? What are the implications of not respecing that?
>=20
> [...]
>=20
> >=20
> > As I understood from the call, mTHP with sysctl knobs is preferred over
> > optimistic falloc/write allocation? But is still unclear to me why the =
former
> > is preferred.
>=20
> I think Hugh's point was that this should be an opt-in feature, just like
> PMD-sized THP started out, and still is, an opt-in feature.

I'd be keen to understand the use case for this. Even the current THP contr=
ols
we have in tmpfs. I guess these are just scenarios with no swap involved?
Are these use cases the same for both tmpfs and shmem anon mm?

>=20
> Problematic interaction with khugepaged (that will be fixed) is one thing=
,
> interaction with memory reclaim (without any kind of memory reclaim
> mechanisms in place) might be another one. Controlling and tuning for
> specific folio sizes might be another one Hugh raised. [summarizing what =
I
> recall from the discussion, there might be more].
>=20
> >=20
> > Is large folios a non-viable option?
>=20
> I think you mean "allocating large folios without user space control".

Yes.

>=20
> Because mTHP gives user space full control, to the point where you can
> enable all sizes and obtain the same result.

Agree.

>=20
> >=20
> > >=20
> > > Also, we should properly fallback within the configured sizes, and no=
t jump
> > > "over" configured sizes. Unless there is a good reason.
> > >=20
> > > (3) khugepaged
> > >=20
> > > khugepaged needs to handle larger folios properly as well. Until fixe=
d,
> > > using smaller THP sizes as fallback might prohibit collapsing a PMD-s=
ized
> > > THP later. But really, khugepaged needs to be fixed to handle that.
> > >=20
> > > (4) force/disable
> > >=20
> > > These settings are rather testing artifacts from the old ages. We sho=
uld not
> > > add them to the per-size toggles. We might "inherit" it from the glob=
al one,
> > > though.
> > >=20
> > > "within_size" might have value, and especially for consistency, we sh=
ould
> > > have them per size.
> > >=20
> > >=20
> > >=20
> > > So, this series only tackles anonymous shmem, which is a good startin=
g
> > > point. Ideally, we'd get support for other shmem (especially during f=
ault
> > > time) soon afterwards, because we won't be adding separate toggles fo=
r that
> > > from the interface POV, and having inconsistent behavior between kern=
el
> > > versions would be a bit unfortunate.
> > >=20
> > >=20
> > > @Baolin, this series likely does not consider (4) yet. And I suggest =
we have
> > > to take a lot of the "anonymous thp" terminology out of this series,
> > > especially when it comes to documentation.
> > >=20
> > > @Daniel, Pankaj, what are your plans regarding that? It would be grea=
t if we
> > > could get an understanding on the next steps on !anon shmem.
> >=20
> > I realize I've raised so many questions, but it's essential for us to g=
rasp the
> > mm concerns and usage scenarios. This understanding will provide clarit=
y on the
> > direction regarding folios for !anon shmem.
>=20
> If I understood correctly, Hugh had strong feelings against not respectin=
g
> mTHP toggles for shmem. Without per-block tracking, I agree with that.

My understanding was the same. But I have this follow-up question: should
we respect mTHP toggles without considering mapping constraints (size and
index)? Or perhaps we should use within_size where we can fit this intermed=
iate
approach, as long as mTHP granularity is respected?

Daniel

>=20
> --=20
> Cheers,
>=20
> David / dhildenb
> =

