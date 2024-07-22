Return-Path: <linux-kernel+bounces-258723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EE5938C23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBC6281C14
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590516B74D;
	Mon, 22 Jul 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KojORy2p"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF526ADB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640924; cv=none; b=Ao7DIMSY9MyT6P9bZmlE35ij3VsUwIXo20ZaSIZvPm4nyYnKmzE4AXF+aHgPoiCMrQhVGqchxmIt0e5NT4diWojU04CmVloQuVFGvXSFPdNL8Ck7HT1Wx4YDnQf14EY5nsWk6E8bYwpFfatyyxD6Ya1nmMn7S0tEGF+lMzcNeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640924; c=relaxed/simple;
	bh=X0rMaMHCRfgvbEOqAaQpWVELDFiAJTYZoLHg5QFes78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=DF7ivC0h5I92Yh5lHcJWppoUJhI726qtM5k1L3rVWI9cW4Z9cUlDhZfVEJidmYPIEqsM+ttz77Iky/UfJ1Vm5/ZE6G+M01cF5WwUogQwE31RtQgNL18uqQ3N1wQw80mqXMo2YPHdxgVjylQxlDn6PiFNLgYWDRSMFhNza5X35SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KojORy2p; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240722093513euoutp02201ef56f27914129413fcd44863c3563~kf0oc6up_1808118081euoutp02K
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:35:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240722093513euoutp02201ef56f27914129413fcd44863c3563~kf0oc6up_1808118081euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721640913;
	bh=JTOj1r/QirQnbxz+lycvoW95ymFanaa09xD21a8hr0g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=KojORy2pIswD1LP05X9sULVMz1WA9cnWc5uCvuNf+y7VIAHT9+8o7zqAtnq/fUDPP
	 9omZ4+6PMXv/fycLVf44qInG8O7c5FSLimSYwrboWn8t9HblDmz3I/30VGzo4NBQ8/
	 x2WI1fUymhzut/S0661k3EcULZKCXq1v4/2V5mlY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240722093513eucas1p20b9ceabff256c8cd34349094136a39f0~kf0oFC8JN0698806988eucas1p2h;
	Mon, 22 Jul 2024 09:35:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 43.41.09875.1D72E966; Mon, 22
	Jul 2024 10:35:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240722093512eucas1p1f52d83646c27ffbdcb59550c3c751dcb~kf0nghXz03093630936eucas1p1C;
	Mon, 22 Jul 2024 09:35:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240722093512eusmtrp1901a4a5aed72e38f092ed2bdf173d3f2~kf0nfq47X1407414074eusmtrp1D;
	Mon, 22 Jul 2024 09:35:12 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-10-669e27d16d9b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.39.08810.0D72E966; Mon, 22
	Jul 2024 10:35:12 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240722093512eusmtip178045709cd5e4d406541eadadb5a983e~kf0nN-Dfa1198511985eusmtip1y;
	Mon, 22 Jul 2024 09:35:12 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Mon, 22 Jul 2024 10:35:11 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Mon, 22 Jul
	2024 10:35:11 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Ryan Roberts <ryan.roberts@arm.com>
CC: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, Jonathan
	Corbet <corbet@lwn.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Barry Song <baohua@kernel.org>, Lance Yang <ioworker0@gmail.com>, Baolin
	Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>, Pankaj
	Raghav <kernel@pankajraghav.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 0/4] Control folio sizes used for page cache
 memory
Thread-Topic: [RFC PATCH v1 0/4] Control folio sizes used for page cache
	memory
Thread-Index: AQHa2BkH9+ISTh9tgUugWxPZu07/5LH6qAEAgAAEAQCAB8fsAA==
Date: Mon, 22 Jul 2024 09:35:11 +0000
Message-ID: <joisx5udw4tebjykvcs2s75qxzkugr2rlyvngzmml5xhm7jnvu@o4nvt7g735oj>
In-Reply-To: <99b33a29-e97a-4932-8d7a-85bc01885d18@arm.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50487096AD92124D8AAA80BBAF19F7A5@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTdxTG87/39nLbrMm16nrChgoOyRARdR8uY1vsosnd4hssmmlMXCPX
	gtKiLXVzmwnRTRhzZJFNoXZaYby066xWyqAdhFXWUgUNbxqYgn1hs4Axa3EKNTDaixvffuec
	55znnORQuCQoiKfyVUWcWiUvSCJFRJNr6taanpQLBzJKe5cyeouZZALOb3BmttWFmEB7CWKe
	WKZxJmhvwpjRUDnBVEc2MF3BMMH02fUkM2yeFTCnHd8jJvJMT24Us+YLZsS26O7HsQarlr3W
	kMpaTV+RrDV0Jo7trIwQbIs3k60prxCw3UYZ+7htgGTD1mU7XtojeiuXK8g/yqnXvvORKO/s
	n8X44ZaET1z9I0QxqpGWISEF9Bvwx+gjIsoSugGBpfV4GRLN8SSCK45HJB+EEZwasRAvOkq/
	rsf5Qj2Cbr0H/081WDcwH3QhaLdaMD4wIujoC8X6Sfp1aPNY46K8hE6BZ0PVKCrC6UkcZh56
	BdHCYnoH3Bjumhdlg9FSifH8Llz3PozlCToZvBW+2FAxvRUaHH4UZSGdBU2+iRgjOgF8xumY
	HqelMBS4iPFHLILq87/iPL8MM3YvyXMadN8NIJ4zwFbbNn90IpS6Bkl+ThoYHKE5puY4E/zu
	I3x6NdRdGsf5dRaBpypARO8C2iaC3/qN876boNJzXsDzYhhzN8Z9i9J0C9bTLbDQ/W+hW2Ch
	W2BhQAITknJajVLBadaruI/TNXKlRqtSpO8vVFrR3DfenHFPNqP6sb/TnQijkBMBhSctEQfG
	fjggEefKj33KqQv3qbUFnMaJXqGIJKk4OXc5J6EV8iLuEMcd5tQvqhgljC/Gtp9QbX41KFRH
	LCsPrsrd2HH5bM9fd6tDtuWtqVj/MsUJ/dadpKtXagsVfnb92HPDkewsx0+i9t0JU+/t9I90
	DjeeXLnL811+3vjqQx2+04U/T95z3+/AMppzfOax4yby3GjV44rb98Jn3s7pejMkrqvf9YFy
	wz/+VZuoiuD+4Npf/Lfbi0xbrJcczdzvGfFfhm/kfPHkKrO3NEWlVGx72iMfUNTMZh813bG/
	L6srm7hDntP+OPg8ccsp+8HE8ZMW+ebOB5LGktreLKHTWxJIni3CPoz482UT5Z+/ZvCAuEV2
	UdeZKS0RycIht80se3A5vuqpd3qNrbYvZXxoRfaKoantSYQmT74uFVdr5P8CLvYPR/wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsVy+t/xu7oX1OelGZw7qWExZ/0aNosnh3qZ
	Lf7vPcZo8eRAO6PF1/W/mC1e7trGZPH0Ux+LxaLfxhZnXn5msbi8aw6bxb01/1ktenZPZbT4
	/WMOmwOvx5p5axg9ds66y+6xYFOpx+YVWh6bVnWyeWz6NInd48SM3yweOx9aeizum8zqcXal
	o8f7fVfZPD5vkgvgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnN
	ySxLLdK3S9DLmPasgblgp2zFsSv3WRoYF4t3MXJySAiYSHR0L2cGsYUEljJK7FjqBhGXkdj4
	5SorhC0s8edaF1sXIxdQzUdGiQ37rrBBNJxhlJh3xAcisZJRYu+ZmWAdbAKaEvtObmIHsUUE
	1CV+3FrECFLELPCFWWLf1HVA6zg4hAX8JDYeYoOoCZTof3qEBcJ2kjj88AVYL4uAqsTDyY/A
	4rwCvhIrdj9mhFj2hVGiZV0LWBGngLXEtkdvGEFsRgFZiUcrf4HFmQXEJW49mc8E8YKAxJI9
	55khbFGJl4//Qb2mI3H2+hNGCNtAYuvSfSwQtqJEx7GbbBBzdCQW7P7EBnIzs4ClxOPjhRBh
	bYllC18zQ9wmKHFy5hOWCYwys5BsnoWkexZC9ywk3bOQdC9gZF3FKJJaWpybnltsqFecmFtc
	mpeul5yfu4kRmPK2Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuF98mpumhBvSmJlVWpRfnxRaU5q
	8SFGU2DQTWSWEk3OBybdvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYO
	TqkGJkXnH+tff73nmbPzop+gwkH/o8d8pqt9fNSx/OoDxYspqVfPvL971Hvrw3mhLGfy71y7
	x5yuZnLkbP+PE6dnvZb1Ze4ReXhb++UWngXrpX9+lgoT2uy6SX/5aYHG7Vcy5Wb9vef8/HCg
	V9Hxmwqq21VKglcxXf2wvFb95dkTNoesnn9sfvfKZfqnqczL6l24jndO/Xvm662C7zMbZ5qW
	HLjzvKNje0N2vHRQzPruow9nmL6wOh3C2vNYV5Z32ovI2ps3V8caTvgR1Xr/74q12cfdO2J6
	dk3/Me+hm0urqiP/vIc+WUYtz2dqvWp9NS1pYcfZg9ca3y5+/Pp2ieajvCT+5Vxyf+9V1uwx
	SerzmJT4WImlOCPRUIu5qDgRALSAGQkCBAAA
X-CMS-MailID: 20240722093512eucas1p1f52d83646c27ffbdcb59550c3c751dcb
X-Msg-Generator: CA
X-RootMTR: 20240717104555eucas1p25498323e279fcc42702329d0df60e48a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240717104555eucas1p25498323e279fcc42702329d0df60e48a
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
	<eb2d8027-6347-4cc5-b1f6-6e79dc9a02ef@redhat.com>
	<CGME20240717104555eucas1p25498323e279fcc42702329d0df60e48a@eucas1p2.samsung.com>
	<99b33a29-e97a-4932-8d7a-85bc01885d18@arm.com>

On Wed, Jul 17, 2024 at 11:45:48AM GMT, Ryan Roberts wrote:
> On 17/07/2024 11:31, David Hildenbrand wrote:
> > On 17.07.24 09:12, Ryan Roberts wrote:
> >> Hi All,
> >>
> >> This series is an RFC that adds sysfs and kernel cmdline controls to c=
onfigure
> >> the set of allowed large folio sizes that can be used when allocating
> >> file-memory for the page cache. As part of the control mechanism, it p=
rovides
> >> for a special-case "preferred folio size for executable mappings" mark=
er.
> >>
> >> I'm trying to solve 2 separate problems with this series:
> >>
> >> 1. Reduce pressure in iTLB and improve performance on arm64: This is a=
 modified
> >> approach for the change at [1]. Instead of hardcoding the preferred ex=
ecutable
> >> folio size into the arch, user space can now select it. This decouples=
 the arch
> >> code and also makes the mechanism more generic; it can be bypassed (th=
e default)
> >> or any folio size can be set. For my use case, 64K is preferred, but I=
've also
> >> heard from Willy of a use case where putting all text into 2M PMD-size=
d folios
> >> is preferred. This approach avoids the need for synchonous MADV_COLLAP=
SE (and
> >> therefore faulting in all text ahead of time) to achieve that.
> >>
> >> 2. Reduce memory fragmentation in systems under high memory pressure (=
e.g.
> >> Android): The theory goes that if all folios are 64K, then failure to =
allocate a
> >> 64K folio should become unlikely. But if the page cache is allocating =
lots of
> >> different orders, with most allocations having an order below 64K (as =
is the
> >> case today) then ability to allocate 64K folios diminishes. By providi=
ng control
> >> over the allowed set of folio sizes, we can tune to avoid crucial 64K =
folio
> >> allocation failure. Additionally I've heard (second hand) of the need =
to disable
> >> large folios in the page cache entirely due to latency concerns in som=
e
> >> settings. These controls allow all of this without kernel changes.
> >>
> >> The value of (1) is clear and the performance improvements are documen=
ted in
> >> patch 2. I don't yet have any data demonstrating the theory for (2) si=
nce I
> >> can't reproduce the setup that Barry had at [2]. But my view is that b=
y adding
> >> these controls we will enable the community to explore further, in the=
 same way
> >> that the anon mTHP controls helped harden the understanding for anonym=
ous
> >> memory.
> >>
> >> ---
> >=20
> > How would this interact with other requirements we get from the filesys=
tem (for
> > example, because of the device) [1].
> >=20
> > Assuming a device has a filesystem has a min order of X, but we disable=
 anything
> >>=3D X, how would we combine that configuration/information?
>=20
> Currently order-0 is implicitly the "always-on" fallback order. My thinki=
ng was
> that with [1], the specified min order just becomes that "always-on" fall=
back order.
>=20
> Today:
>=20
>   orders =3D file_orders_always() | BIT(0);
>=20
> Tomorrow:
>=20
>   orders =3D (file_orders_always() & ~(BIT(min_order) - 1)) | BIT(min_ord=
er);
>=20
> That does mean that in this case, a user-disabled order could still be us=
ed. So
> the controls are really hints rather than definitive commands.

In the scenario where a min order is not enabled in hugepages-<size>kB/
file_enabled, will the user still be allowed to automatically mkfs/mount wi=
th
blocksize=3Dmin_order, and will sysfs reflect this? Or, since it's a hint, =
will it
remain hidden but still allow mkfs/mount to proceed?

>=20
>=20
> >=20
> >=20
> > [1]
> > https://lore.kernel.org/all/20240715094457.452836-2-kernel@pankajraghav=
.com/T/#u
> >=20
> =

