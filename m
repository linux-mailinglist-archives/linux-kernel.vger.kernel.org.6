Return-Path: <linux-kernel+bounces-279309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4994BBA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B29E1F216A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6518B471;
	Thu,  8 Aug 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KrGApBqC"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFA18A6AB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114140; cv=none; b=mjeifM9s/ZaGA1aFCQeoudflkKnt8i1orJh8uwxm2Wo897RIlYr5cPGLeVy6CWefn9RWwWwK+GN44yPaRa/IpdQv6YkvZXmxL5XI6Yrpf/gEqT5CojP+sbc8Tc6rWReI0ietqdXfMfxKYlN1yILdTTL2LuctHwCf6PhZ3076BYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114140; c=relaxed/simple;
	bh=6dos6900CbAGJhfvGiN0DcMWUzH70AMXOcwTi2UFjek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=keIDYp3PeB+PF++YbknuYkxd9wuoKpJjvNJaz3PHPBKnRxCDVmKDJkzW2zxLVfr38tcU20jrHf1XlgwppGLJEwUGPn/kid6LiOsyIQU+SLvhyn140QYRC6ki/aFLx+LsBusE6XNGIrQepYS5I1VhSoTUan4ZdXM22llO2V9Ukas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KrGApBqC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240808104855euoutp0241baee9b7483591c849f08ad710d7ead~puy1eUOwO2796727967euoutp02F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:48:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240808104855euoutp0241baee9b7483591c849f08ad710d7ead~puy1eUOwO2796727967euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723114136;
	bh=7FCk0fNXhonYa/73V68IMNBsumsEDlAke08GxedaK2s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=KrGApBqCi3DgqfBW2f6IwIqois+wS6CnCXr+ZxPSszRN/hr+V7O33rs4CIYw+bGq0
	 Ay2NKdiooxO6auUdHQvscf6P24afTnzviNht9T0XcmpgiIYhb3sz68S3Sj7nPMA/hK
	 2dW9EZDCbzO/WIrHSQsR844vGs30wd7D/jlW9bpc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240808104855eucas1p140ec7f0d60289774225239c54e1e782d~puy0nrBdi1367413674eucas1p1D;
	Thu,  8 Aug 2024 10:48:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 9F.7E.09875.692A4B66; Thu,  8
	Aug 2024 11:48:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240808104854eucas1p15dd740e94790fbdf2308d20d93444639~puy0FRp-N1848918489eucas1p1S;
	Thu,  8 Aug 2024 10:48:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240808104854eusmtrp1164e08ad996637591c7be21aaca91308~puy0EkZlB0364503645eusmtrp1H;
	Thu,  8 Aug 2024 10:48:54 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-36-66b4a296a41e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 6D.6D.08810.692A4B66; Thu,  8
	Aug 2024 11:48:54 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240808104853eusmtip1c1e96078ff5659ecc0040529e755a910~puyzdehqs0841108411eusmtip1b;
	Thu,  8 Aug 2024 10:48:53 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Thu, 8 Aug 2024 11:48:53 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Thu, 8 Aug
	2024 11:48:52 +0100
From: Daniel Gomez <da.gomez@samsung.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
CC: David Hildenbrand <david@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "hughd@google.com" <hughd@google.com>,
	"willy@infradead.org" <willy@infradead.org>, "wangkefeng.wang@huawei.com"
	<wangkefeng.wang@huawei.com>, "chrisl@kernel.org" <chrisl@kernel.org>,
	"ying.huang@intel.com" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
	<ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>, Pankaj Raghav
	<p.raghav@samsung.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 01/10] mm: vmscan: add validation before spliting
 shmem large folio
Thread-Topic: [PATCH v4 01/10] mm: vmscan: add validation before spliting
	shmem large folio
Thread-Index: AQHa6JwF/rLovMCwfku9sbcwP+6s8LIb4fUAgACzk4CAAGjQgIAADBoAgAAUroA=
Date: Thu, 8 Aug 2024 10:48:52 +0000
Message-ID: <4dmzlg3rlhxnl3eihghe7enhtk67ooqpak3w5xlzehka6sfzf6@ahmahak2wyvj>
In-Reply-To: <1c4e67f1-caf5-4913-857d-b9cfbc30321e@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E8CE15E899783D4A8BBA8C7AFB51DAC9@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZduznOd1pi7akGfRNNLL4fFfIYs76NWwW
	//ceY7R4ffgTo0XTg0dMFl/X/2K2ePqpj8Vi0W9ji8u75rBZ3Fvzn9XixoSnjBY9u6cyWiw4
	sZjRovHzfUaL3z+AsidnTWaxmH30HruDoMeaeWsYPXbOusvusWBTqUfLkbesHptXaHks3vOS
	yWPTqk42j02fJrF7nJjxm8Vj50NLj97md2we7/ddZfP4vEkugDeKyyYlNSezLLVI3y6BK6Nz
	0VSWgmdRFYtv7WFrYFxk18XIySEhYCJxcHsHK4gtJLCCUWLteY4uRi4g+wujxLbPbWwQzmdG
	ic19O9lhOj7t3scKkVjOKNHzbipC1bTVd6BmnWaUeNYnB5EAmnvu7AywBJuApsS+k5uARnFw
	iAjoS/TO9QWpYRaYyCbxYtszRpAaYYEYiennu8DWiQjEStz+sxHK9pM48/IlG4jNIqAicePj
	F7A4r4CvxJIZU5lAbE4BV4kpn9+A2YwCshKPVv4Cq2EWEJe49WQ+E8QLghKLZu9hhrDFJP7t
	esgGYetInL3+hBHCNpDYunQfC4StJDH3xkxmiDl6EjemTmGDsC0lvv77wApha0ssW/iaGeIe
	QYmTM5+wgDwmIXCVS6LjYwfUIBeJPbfXsELYwhKvjm9hn8CoMwvJfbOQ7JiFZMcsJDtmIdmx
	gJF1FaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmAyPf3v+JcdjMtffdQ7xMjEwXiIUYKD
	WUmEtzl8U5oQb0piZVVqUX58UWlOavEhRmkOFiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QD
	k8hOUU2jry1+qxeZH8q6nydmoRb/28XogINPlsHMDDPDqbvWTxC/nuMQMnEvt5DJeranbryT
	p6/3/ue7y2217KT8CRdkUo1v/r78WXELw8+nteGSrx8e1du/5yL7//n5lm0xX6zz9p31iFOd
	3MMWmMLEObdFX3r/8eIrZg+10zYfmnDZ5ZqZs9kK19V1Is69iSecT5Udivt79nnOW9mbhwR+
	aJzJWCzOeqU2W6r00201PfUEY8O/FX/PxsRc3c2hdvHPjH+ZOare2+c8CXlqVjtpxicPL9mA
	u1f0ladN4u0L3Cl8Tc4yQfWbDIvkO2afnrOTfe4fvR74W7O5u0Nzl/spuf2GBYvt47Kebo3Z
	psRSnJFoqMVcVJwIAP4V5sIVBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42I5/e/4Xd1pi7akGczZJmTx+a6QxZz1a9gs
	/u89xmjx+vAnRoumB4+YLL6u/8Vs8fRTH4vFot/GFpd3zWGzuLfmP6vFjQlPGS16dk9ltFhw
	YjGjRePn+4wWv38AZU/OmsxiMfvoPXYHQY8189YweuycdZfdY8GmUo+WI29ZPTav0PJYvOcl
	k8emVZ1sHps+TWL3ODHjN4vHzoeWHr3N79g83u+7yubxeZNcAG+Unk1RfmlJqkJGfnGJrVK0
	oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXkbnoqksBc+iKhbf2sPWwLjIrouR
	k0NCwETi0+59rF2MXBxCAksZJWZd62aESMhIbPxylRXCFpb4c62LDaLoI6PEwk03wIqEBE4z
	Stxf7geRWMEoce3RZbAONgFNiX0nN7F3MXJwiAjoS/TO9QWpYRaYyCbxYtszsGZhgRiJdSuX
	g9kiArESfavus0PYfhJnXr5kA7FZBFQkbnz8AhbnFfCVWDJjKhPEsjPMEntefWACSXAKuEpM
	+fwGzGYUkJV4tPIXWAOzgLjErSfzmSBeEJBYsuc8M4QtKvHy8T+o13Qkzl5/AvWygcTWpftY
	IGwlibk3ZjJDzNGTuDF1ChuEbSnx9d8HVghbW2LZwtfMEMcJSpyc+YRlAqPMLCSrZyFpn4Wk
	fRaS9llI2hcwsq5iFEktLc5Nzy021CtOzC0uzUvXS87P3cQITJXbjv3cvINx3quPeocYmTgY
	DzFKcDArifA2h29KE+JNSaysSi3Kjy8qzUktPsRoCgy8icxSosn5wGSdVxJvaGZgamhiZmlg
	amlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXA1J5h+LzujJj65G+1Yl7vZ0uGZJ08ciXg
	iZ+Plsz7JVMuslld6be0lFtbVtr106G/vrJ/sq1yQuqE8A2ZCuL28S1xuSkzBZb9O37IcuVk
	PfZC2bcJNrP2J2s+2mEjlNx9a82Lh1++1O3o9q9itWDJDZ6+x/NrhMXUiaE3pSR3CydfXngu
	sWje5pqb5xZ5flZcHrqTWX8nT8SqJ4n/FISZN86yPD5DYsXtM2Fnz/yyVXSesP3NAdXYuTtX
	CVwyCGz+cv7So/J8jV+3Zz4q3tgdlhTteueVx36NOf+bwl7qmgjW9zzZfCg8wzq2TGRDj6XP
	06Cys9xtL6MeRcyLW/PP6t2KjXf+1mWlzuBZe/qqmhJLcUaioRZzUXEiAEWNW/UeBAAA
X-CMS-MailID: 20240808104854eucas1p15dd740e94790fbdf2308d20d93444639
X-Msg-Generator: CA
X-RootMTR: 20240808093456eucas1p17940e959eb7a34d03d921f56570a0b6a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240808093456eucas1p17940e959eb7a34d03d921f56570a0b6a
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
	<8a8c6dc9df0bc9f6f7f937bea446062be19611b3.1723012159.git.baolin.wang@linux.alibaba.com>
	<9b45a0dc-fa12-428a-8702-c7690c26aedc@redhat.com>
	<770190a2-3938-4ba9-9aaf-7320b34addf4@linux.alibaba.com>
	<03a7c798-7a0d-4873-8fcb-8940d8dadc00@redhat.com>
	<CGME20240808093456eucas1p17940e959eb7a34d03d921f56570a0b6a@eucas1p1.samsung.com>
	<1c4e67f1-caf5-4913-857d-b9cfbc30321e@linux.alibaba.com>

On Thu, Aug 08, 2024 at 05:34:50PM GMT, Baolin Wang wrote:
>=20
>=20
> On 2024/8/8 16:51, David Hildenbrand wrote:
> > On 08.08.24 04:36, Baolin Wang wrote:
> > >=20
> > >=20
> > > On 2024/8/7 23:53, David Hildenbrand wrote:
> > > > On 07.08.24 09:31, Baolin Wang wrote:
> > > > > Page reclaim will not scan anon LRU if no swap space, however
> > > > > MADV_PAGEOUT
> > > > > can still split shmem large folios even without a swap device. Th=
us add
> > > > > swap available space validation before spliting shmem large folio=
 to
> > > > > avoid redundant split.
> > > > >=20
> > > > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > > > ---
> > > > > =A0=A0 mm/vmscan.c | 8 ++++++++
> > > > > =A0=A0 1 file changed, 8 insertions(+)
> > > > >=20
> > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > index 31d13462571e..796f65781f4f 100644
> > > > > --- a/mm/vmscan.c
> > > > > +++ b/mm/vmscan.c
> > > > > @@ -1259,6 +1259,14 @@ static unsigned int shrink_folio_list(stru=
ct
> > > > > list_head *folio_list,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (folio_test_swapbacked(f=
olio) &&
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 folio_test_la=
rge(folio)) {
> > > > > +
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Do not split shmem folio =
if no swap memory
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * available.
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!total_swap_pages)
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto activate_lock=
ed;
> > > > > +
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Split shmem folio *=
/
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (split_folio_to_lis=
t(folio, folio_list))
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto keep_=
locked;
> > > >=20
> > > > Reminds me of
> > > >=20
> > > > commit 9a976f0c847b67d22ed694556a3626ed92da0422
> > > > Author: Luis Chamberlain <mcgrof@kernel.org>
> > > > Date:=A0=A0 Thu Mar 9 15:05:43 2023 -0800
> > > >=20
> > > > =A0 =A0=A0=A0 shmem: skip page split if we're not reclaiming
> > > > =A0 =A0=A0=A0 In theory when info->flags & VM_LOCKED we should not =
be getting
> > > > =A0 =A0=A0=A0 shem_writepage() called so we should be verifying thi=
s with a
> > > > =A0 =A0=A0=A0 WARN_ON_ONCE().=A0 Since we should not be swapping th=
en best to
> > > > ensure we
> > > > =A0 =A0=A0=A0 also don't do the folio split earlier too.=A0 So just=
 move the check
> > > > early
> > > > =A0 =A0=A0=A0 to avoid folio splits in case its a dubious call.
> > > > =A0 =A0=A0=A0 We also have a similar early bail when !total_swap_pa=
ges so just
> > > > move that
> > > > =A0 =A0=A0=A0 earlier to avoid the possible folio split in the same=
 situation.
> > > >=20
> > > >=20
> > > > But indeed, pageout() -> writepage() is called *after* the split in=
 the
> > > > vmscan path.
> > > >=20
> > > > In that "noswap" context, I wonder if we also want to skip folios p=
art
> > > > of shmem
> > > > with disabled swapping?
> > >=20
> > > Yes, I think so.
> > >=20
> > > >=20
> > > > But now I am wondering under which circumstances we end up calling
> > > > shmem_writepage() with a large folio. And I think the answer is the
> > > > comment of
> > > > folio_test_large(): via drivers/gpu/drm/i915/gem/i915_gem_shmem.c.
> > > >=20
> > > >=20
> > > > ... so if shmem_writepage() handles+checks that, could we do
> > > >=20
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index a332cb80e928..7dfa3d6e8ba7 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -1257,11 +1257,6 @@ static unsigned int shrink_folio_list(struct
> > > > list_head *folio_list,
> > > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 goto
> > > > activate_locked_split;
> > > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 }
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (folio_test_s=
wapbacked(folio) &&
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 folio_test_large(folio)) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 /* Split shmem folio */
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 if (split_folio_to_list(folio, folio_list))
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 goto keep_locked;
> > > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > >=20
> > > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> > > >=20
> > > > instead?
> > >=20
> > > Seems reasonable to me. But we should pass the 'folio_list' to
> > > shmem_writepage() to list the subpages of the large folio. Let me try=
.
> >=20
> > Ah, yes, good point. Alternatively, we'd have to split and try writing
> > all subpages in there. I wonder what to do if we fail to write some, an=
d
> > if we could handle that transparently, without the folio_list.
>=20
> After some investigation, I prefer to pass 'folio_list' to shmem_writepag=
e()
> via 'struct writeback_control', which could simplify the logic a lot.
> Otherwise, we need to handle each subpage's writeback/reclaim/dirty state=
,
> as well as tracking each subpage's write result, which seems more
> complicated.
>=20
> I made a quick change by passing 'folio_list', and it looks simple and wo=
rks
> as expected.
>=20
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 75196b0f894f..10100e22d5c6 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -80,6 +80,9 @@ struct writeback_control {
>          */
>         struct swap_iocb **swap_plug;
>=20
> +       /* Target list for splitting a large folio */
> +       struct list_head *list;
> +
>         /* internal fields used by the ->writepages implementation: */
>         struct folio_batch fbatch;
>         pgoff_t index;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 05525e9e7423..0a5a68f7d0a0 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1496,9 +1496,10 @@ static int shmem_writepage(struct page *page, stru=
ct
> writeback_control *wbc)
>          * and its shmem_writeback() needs them to be split when swapping=
.
>          */
>         if (wbc->split_large_folio && folio_test_large(folio)) {
> +try_split:
>                 /* Ensure the subpages are still dirty */
>                 folio_test_set_dirty(folio);
> -               if (split_huge_page(page) < 0)
> +               if (split_huge_page_to_list_to_order(page, wbc->list, 0))

We check for split_large_folio, but we still send the wbc->list for i915
writepage() case. Previously, we were sending a NULL list. Shouldn't we add=
ress
that case too?

>                         goto redirty;
>                 folio =3D page_folio(page);
>                 folio_clear_dirty(folio);
> @@ -1540,8 +1541,12 @@ static int shmem_writepage(struct page *page, stru=
ct
> writeback_control *wbc)
>         }
>=20
>         swap =3D folio_alloc_swap(folio);
> -       if (!swap.val)
> +       if (!swap.val) {
> +               if (nr_pages > 1)
> +                       goto try_split;
> +
>                 goto redirty;
> +       }
>=20
>         /*
>          * Add inode to shmem_unuse()'s list of swapped-out inodes,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 277571815789..cf982cf2454f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -628,7 +628,7 @@ typedef enum {
>   * Calls ->writepage().
>   */
>  static pageout_t pageout(struct folio *folio, struct address_space
> *mapping,
> -                        struct swap_iocb **plug)
> +                        struct swap_iocb **plug, struct list_head
> *folio_list)
>  {
>         /*
>          * If the folio is dirty, only perform writeback if that write
> @@ -676,6 +676,11 @@ static pageout_t pageout(struct folio *folio, struct
> address_space *mapping,
>                         .swap_plug =3D plug,
>                 };
>=20
> +               if (shmem_mapping(mapping)) {
> +                       wbc.list =3D folio_list;
> +                       wbc.split_large_folio =3D
> !IS_ENABLED(CONFIG_THP_SWAP);
> +               }
> +
>                 folio_set_reclaim(folio);
>                 res =3D mapping->a_ops->writepage(&folio->page, &wbc);
>                 if (res < 0)
> @@ -1259,23 +1264,6 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
>                                                 goto activate_locked_spli=
t;
>                                 }
>                         }
> -               } else if (folio_test_swapbacked(folio) &&
> -                          folio_test_large(folio)) {
> -
> -                       /*
> -                        * Do not split shmem folio if no swap memory
> -                        * available.
> -                        */
> -                       if (!total_swap_pages)
> -                               goto activate_locked;
> -
> -                       /*
> -                        * Only split shmem folio when CONFIG_THP_SWAP
> -                        * is not enabled.
> -                        */
> -                       if (!IS_ENABLED(CONFIG_THP_SWAP) &&
> -                           split_folio_to_list(folio, folio_list))
> -                               goto keep_locked;
>                 }
>=20
>                 /*
> @@ -1377,18 +1365,21 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
>                          * starts and then write it out here.
>                          */
>                         try_to_unmap_flush_dirty();
> -try_pageout:
> -                       switch (pageout(folio, mapping, &plug)) {
> +                       switch (pageout(folio, mapping, &plug, folio_list=
))
> {
>                         case PAGE_KEEP:
>                                 goto keep_locked;
>                         case PAGE_ACTIVATE:
> -                               if (shmem_mapping(mapping) &&
> folio_test_large(folio) &&
> -                                   !split_folio_to_list(folio, folio_lis=
t))
> {
> +                               /* Shmem can be split when writeback to s=
wap
> */
> +                               if ((nr_pages > 1) &&
> !folio_test_large(folio)) {
> +                                       sc->nr_scanned -=3D (nr_pages - 1=
);
>                                         nr_pages =3D 1;
> -                                       goto try_pageout;
>                                 }
>                                 goto activate_locked;
>                         case PAGE_SUCCESS:
> +                               if ((nr_pages > 1) &&
> !folio_test_large(folio)) {
> +                                       sc->nr_scanned -=3D (nr_pages - 1=
);
> +                                       nr_pages =3D 1;
> +                               }
>                                 stat->nr_pageout +=3D nr_pages;
>=20
>                                 if (folio_test_writeback(folio)) {=

