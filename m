Return-Path: <linux-kernel+bounces-279318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1066094BBC8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1619AB20D93
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485E618A958;
	Thu,  8 Aug 2024 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pCuUGi2y"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6C13A257
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114677; cv=none; b=ur8VGfrT8+Vuv8hyeBWJJqn3ATRHG917+3hDabdfkmU/bv1k8VIULO/Wk+uSNpndKCieIBMSHjYL1c1n52RHyLfDSqcK8PsgFH/Ms/hy4+Ukb4ycY+9LblKYQiB2yy4J+BcdhWzbK2ya6rITIy4fpdXiB0R9PKxqHallu6N3Vi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114677; c=relaxed/simple;
	bh=nm9oUfexL9dK/UpTaKeJ7N6taEQjf+EMVarp5NblRtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=cR3C0dBIb6rppfibYkb2IKgEpMVCo4/0zcvjooalRH1unLHu5TADhPHflLg7uztkmmSiglZDmSrSBO/qxET/6exMEuTTTzdmf/0sYM7c7o7GR7TSOWYAEiSM4QbJQ0PxPSDyzBeiF/NCEU1HflYqv3feiSDsByhK0R6hp4Kj7iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pCuUGi2y; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240808105752euoutp029538c8445ea4c440ea55d8b56829275a~pu6o7FvM60699806998euoutp02p
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:57:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240808105752euoutp029538c8445ea4c440ea55d8b56829275a~pu6o7FvM60699806998euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723114672;
	bh=UdCqsamErtOExDokIfv4lR+wt5cnPl/8g43dIPXDmdw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=pCuUGi2yOzQsJegyv5NtMR1D4XYOxDCTfL8UelMnjMGp8JRXH+KlkheCg1iir2NzO
	 OIK51VeAVrGTb6mNahJlwK17MRjVX7BmzYo56meYHx1ZGlKU3cYgat6bkaG9IfRGRy
	 PLRTMzagAGBg90cmItqNjE5EySmNJtWVrPY0+IZc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240808105751eucas1p245431fb6d906c5d8a57e42ea127a1414~pu6oph_e40914809148eucas1p2-;
	Thu,  8 Aug 2024 10:57:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id AA.B0.09875.FA4A4B66; Thu,  8
	Aug 2024 11:57:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240808105751eucas1p2085e25dc3cdc22967f2eb839d755d6b2~pu6oFagdy1785417854eucas1p2L;
	Thu,  8 Aug 2024 10:57:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240808105751eusmtrp2d9aceb34779cbfcce8873d7c1f2de558~pu6oEb-ht3133231332eusmtrp2n;
	Thu,  8 Aug 2024 10:57:51 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-c9-66b4a4affeaf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 18.AA.09010.FA4A4B66; Thu,  8
	Aug 2024 11:57:51 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240808105750eusmtip2cd8af20870aedafa78d9a0a539d2c212~pu6nvoo-f1233112331eusmtip2o;
	Thu,  8 Aug 2024 10:57:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Thu, 8 Aug 2024 11:57:50 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Thu, 8 Aug
	2024 11:57:50 +0100
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
Thread-Index: AQHa6JwF/rLovMCwfku9sbcwP+6s8LIb4fUAgACzk4CAAGjQgIAADBoAgAAUroCAAAKAAA==
Date: Thu, 8 Aug 2024 10:57:49 +0000
Message-ID: <gyeyk436eopfyhwzjfuc2pfsyg7aemjrmpi3xbby6bqfxhlkqj@cpw4kqbww4ym>
In-Reply-To: <4dmzlg3rlhxnl3eihghe7enhtk67ooqpak3w5xlzehka6sfzf6@ahmahak2wyvj>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A37D69385C9108458BC4044346695625@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZduznOd31S7akGbxYpWfx+a6QxZz1a9gs
	/u89xmjx+vAnRoumB4+YLL6u/8Vs8fRTH4vFot/GFpd3zWGzuLfmP6vFjQlPGS16dk9ltFhw
	YjGjRePn+4wWv38AZU/OmsxiMfvoPXYHQY8189YweuycdZfdY8GmUo+WI29ZPTav0PJYvOcl
	k8emVZ1sHps+TWL3ODHjN4vHzoeWHr3N79g83u+7yubxeZNcAG8Ul01Kak5mWWqRvl0CV8aC
	xb1MBV+SKzb/F21g7HLpYuTkkBAwkbg6qYW1i5GLQ0hgBaPEt9lbmUESQgJfGCVeNydCJD4z
	SjR9W88C09GyexobRNFyRonZLzzgig6tew416jSjxJ+vV1kgqoDmPtvoBmKzCWhK7Du5ib2L
	kYNDREBfoneuL0g9s8BENokX254xgtQIC8RITD/fxQ5iiwjEStz+sxHKDpPoObgSbCaLgIrE
	9ZvLWUFsXgFfibXr94KdzSngJ7H50BawOYwCshKPVv4C62UWEJe49WQ+E8QHghKLZu9hhrDF
	JP7tesgGYetInL3+hBHCNpDYunQf1MdKEnNvzGSGmKMncWPqFDYI21Jiz+cDrBC2tsSyha+Z
	Ie4RlDg58wkLyGMSAhe5JC7PPQa12EXiwoKnUAuEJV4d38I+gVFnFpL7ZiHZMQvJjllIdsxC
	smMBI+sqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwER6+t/xLzsYl7/6qHeIkYmD8RCj
	BAezkghvc/imNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5O
	qQYmk+mZB/2uMb/uMwzkapLq3fhwb7qQ51OHVCML8ZOXFY/x7FybnnJ65Q+bL7dzVplfu37k
	a/d7SR1Zv0v/zEwrl9X/i46p1lYOdnvcEPHy+6eJ32zulx4sn7PzY1oy8/kUL8e/ejvnt+ba
	bm3yD7jo8yaq8s6qJ+8P1F3J/j33oP75z9Ne5Ii8YfL3vDpzDsv2XSGVZ32u6SyXjyqc9fBF
	8Fvr7m9X3i68fu/I7ts6v3q3T7tnGvc3+3Nu2PVlC5XqWmZelZj+Ym6c5TuG/Dvqj2d+EVzp
	rvLwxXbT57uOvznssmObrlRndKSx6u7PBjZNtz8nvjixxlJWyLzlalKHqteSytVKLVG/t8iw
	n+DnqlBiKc5INNRiLipOBAAHC4pyEwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42I5/e/4Pd31S7akGfx9z27x+a6QxZz1a9gs
	/u89xmjx+vAnRoumB4+YLL6u/8Vs8fRTH4vFot/GFpd3zWGzuLfmP6vFjQlPGS16dk9ltFhw
	YjGjRePn+4wWv38AZU/OmsxiMfvoPXYHQY8189YweuycdZfdY8GmUo+WI29ZPTav0PJYvOcl
	k8emVZ1sHps+TWL3ODHjN4vHzoeWHr3N79g83u+7yubxeZNcAG+Unk1RfmlJqkJGfnGJrVK0
	oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaCxb1MBV+SKzb/F21g7HLpYuTk
	kBAwkWjZPY2ti5GLQ0hgKaPEoqdPWCASMhIbv1xlhbCFJf5c64Iq+sgosXzbJijnNKPEqzdn
	mSCcFYwSl3btZwdpYRPQlNh3chOQzcEhIqAv0TvXF6SGWWAim8SLbc8YQWqEBWIk1q1cDmaL
	CMRK9K26zw5hh0n0HFwJdgaLgIrE9ZvLwc7gFfCVWLt+LzPEsgksEruPXgBr4BTwk9h8aAvY
	IEYBWYlHK3+BxZkFxCVuPZnPBPGDgMSSPeeZIWxRiZeP/0H9piNx9voTRgjbQGLr0n1Q/ytJ
	zL0xkxlijp7EjalT2CBsS4k9nw+wQtjaEssWvmaGOE5Q4uTMJywTGGVmIVk9C0n7LCTts5C0
	z0LSvoCRdRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgqtx27OeWHYwrX33UO8TIxMF4iFGC
	g1lJhLc5fFOaEG9KYmVValF+fFFpTmrxIUZTYOBNZJYSTc4HJuu8knhDMwNTQxMzSwNTSzNj
	JXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamnX+S1qzQDfJnLl3yjsV2TbvGNXf+H3OutB94
	/7L4ib2PKONz40n/a+90unE0s3JNTnUR3vmhJIJxqq7fcsXLLvKb3t2JPHt2jZ9r3iHbB7Xm
	3pp3D+r90OS4vucXj0SYkYB7vEojr/iEsOyYC98Otp3ezPor4E3H/t1xARLOUZrK96KruKKX
	R5hqJe7+2x2+JOuIZGT52TOfgi8o6kwI8pYX9J/641y5S3GR6O6ra1M6uvQsQs+ohO6qWHC+
	SJl/423p7DU2dzwvrXxkPv/00pgfs7XnPtNbJcSRem2B3ZE5E7+f37wzM+Y3x7vMqBesi9cl
	fz8bo19/c8+frd+KeTtcl3qL9Gom1r3o2cymxFKckWioxVxUnAgABRc72x4EAAA=
X-CMS-MailID: 20240808105751eucas1p2085e25dc3cdc22967f2eb839d755d6b2
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
	<4dmzlg3rlhxnl3eihghe7enhtk67ooqpak3w5xlzehka6sfzf6@ahmahak2wyvj>

On Thu, Aug 08, 2024 at 12:48:52PM GMT, Daniel Gomez wrote:
> On Thu, Aug 08, 2024 at 05:34:50PM GMT, Baolin Wang wrote:
> >=20
> >=20
> > On 2024/8/8 16:51, David Hildenbrand wrote:
> > > On 08.08.24 04:36, Baolin Wang wrote:
> > > >=20
> > > >=20
> > > > On 2024/8/7 23:53, David Hildenbrand wrote:
> > > > > On 07.08.24 09:31, Baolin Wang wrote:
> > > > > > Page reclaim will not scan anon LRU if no swap space, however
> > > > > > MADV_PAGEOUT
> > > > > > can still split shmem large folios even without a swap device. =
Thus add
> > > > > > swap available space validation before spliting shmem large fol=
io to
> > > > > > avoid redundant split.
> > > > > >=20
> > > > > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > > > > ---
> > > > > > =A0=A0 mm/vmscan.c | 8 ++++++++
> > > > > > =A0=A0 1 file changed, 8 insertions(+)
> > > > > >=20
> > > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > > index 31d13462571e..796f65781f4f 100644
> > > > > > --- a/mm/vmscan.c
> > > > > > +++ b/mm/vmscan.c
> > > > > > @@ -1259,6 +1259,14 @@ static unsigned int shrink_folio_list(st=
ruct
> > > > > > list_head *folio_list,
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (folio_test_swapbacked=
(folio) &&
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 folio_test_=
large(folio)) {
> > > > > > +
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Do not split shmem foli=
o if no swap memory
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * available.
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!total_swap_pages)
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto activate_lo=
cked;
> > > > > > +
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Split shmem folio=
 */
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (split_folio_to_l=
ist(folio, folio_list))
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto kee=
p_locked;
> > > > >=20
> > > > > Reminds me of
> > > > >=20
> > > > > commit 9a976f0c847b67d22ed694556a3626ed92da0422
> > > > > Author: Luis Chamberlain <mcgrof@kernel.org>
> > > > > Date:=A0=A0 Thu Mar 9 15:05:43 2023 -0800
> > > > >=20
> > > > > =A0 =A0=A0=A0 shmem: skip page split if we're not reclaiming
> > > > > =A0 =A0=A0=A0 In theory when info->flags & VM_LOCKED we should no=
t be getting
> > > > > =A0 =A0=A0=A0 shem_writepage() called so we should be verifying t=
his with a
> > > > > =A0 =A0=A0=A0 WARN_ON_ONCE().=A0 Since we should not be swapping =
then best to
> > > > > ensure we
> > > > > =A0 =A0=A0=A0 also don't do the folio split earlier too.=A0 So ju=
st move the check
> > > > > early
> > > > > =A0 =A0=A0=A0 to avoid folio splits in case its a dubious call.
> > > > > =A0 =A0=A0=A0 We also have a similar early bail when !total_swap_=
pages so just
> > > > > move that
> > > > > =A0 =A0=A0=A0 earlier to avoid the possible folio split in the sa=
me situation.
> > > > >=20
> > > > >=20
> > > > > But indeed, pageout() -> writepage() is called *after* the split =
in the
> > > > > vmscan path.
> > > > >=20
> > > > > In that "noswap" context, I wonder if we also want to skip folios=
 part
> > > > > of shmem
> > > > > with disabled swapping?
> > > >=20
> > > > Yes, I think so.
> > > >=20
> > > > >=20
> > > > > But now I am wondering under which circumstances we end up callin=
g
> > > > > shmem_writepage() with a large folio. And I think the answer is t=
he
> > > > > comment of
> > > > > folio_test_large(): via drivers/gpu/drm/i915/gem/i915_gem_shmem.c=
.
> > > > >=20
> > > > >=20
> > > > > ... so if shmem_writepage() handles+checks that, could we do
> > > > >=20
> > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > index a332cb80e928..7dfa3d6e8ba7 100644
> > > > > --- a/mm/vmscan.c
> > > > > +++ b/mm/vmscan.c
> > > > > @@ -1257,11 +1257,6 @@ static unsigned int shrink_folio_list(stru=
ct
> > > > > list_head *folio_list,
> > > > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 goto
> > > > > activate_locked_split;
> > > > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 }
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (folio_test=
_swapbacked(folio) &&
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 folio_test_large(folio)) {
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 /* Split shmem folio */
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 if (split_folio_to_list(folio, folio_list))
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto keep_locked;
> > > > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > >=20
> > > > > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> > > > >=20
> > > > > instead?
> > > >=20
> > > > Seems reasonable to me. But we should pass the 'folio_list' to
> > > > shmem_writepage() to list the subpages of the large folio. Let me t=
ry.
> > >=20
> > > Ah, yes, good point. Alternatively, we'd have to split and try writin=
g
> > > all subpages in there. I wonder what to do if we fail to write some, =
and
> > > if we could handle that transparently, without the folio_list.
> >=20
> > After some investigation, I prefer to pass 'folio_list' to shmem_writep=
age()
> > via 'struct writeback_control', which could simplify the logic a lot.
> > Otherwise, we need to handle each subpage's writeback/reclaim/dirty sta=
te,
> > as well as tracking each subpage's write result, which seems more
> > complicated.
> >=20
> > I made a quick change by passing 'folio_list', and it looks simple and =
works
> > as expected.
> >=20
> > diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> > index 75196b0f894f..10100e22d5c6 100644
> > --- a/include/linux/writeback.h
> > +++ b/include/linux/writeback.h
> > @@ -80,6 +80,9 @@ struct writeback_control {
> >          */
> >         struct swap_iocb **swap_plug;
> >=20
> > +       /* Target list for splitting a large folio */
> > +       struct list_head *list;
> > +
> >         /* internal fields used by the ->writepages implementation: */
> >         struct folio_batch fbatch;
> >         pgoff_t index;
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 05525e9e7423..0a5a68f7d0a0 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1496,9 +1496,10 @@ static int shmem_writepage(struct page *page, st=
ruct
> > writeback_control *wbc)
> >          * and its shmem_writeback() needs them to be split when swappi=
ng.
> >          */
> >         if (wbc->split_large_folio && folio_test_large(folio)) {
> > +try_split:
> >                 /* Ensure the subpages are still dirty */
> >                 folio_test_set_dirty(folio);
> > -               if (split_huge_page(page) < 0)
> > +               if (split_huge_page_to_list_to_order(page, wbc->list, 0=
))
>=20
> We check for split_large_folio, but we still send the wbc->list for i915
> writepage() case. Previously, we were sending a NULL list. Shouldn't we a=
ddress
> that case too?

I guess I was missing wbc initialization snippet:

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i9=
15/gem/i915_gem_shmem.c
index fe69f2c8527d..174b95a9a988 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -308,6 +308,7 @@ void __shmem_writeback(size_t size, struct address_spac=
e *mapping)
                .range_start =3D 0,
                .range_end =3D LLONG_MAX,
                .for_reclaim =3D 1,
+               .list =3D NULL,
        };
        unsigned long i;

> >                         goto redirty;
> >                 folio =3D page_folio(page);
> >                 folio_clear_dirty(folio);
> > @@ -1540,8 +1541,12 @@ static int shmem_writepage(struct page *page, st=
ruct
> > writeback_control *wbc)
> >         }
> >=20
> >         swap =3D folio_alloc_swap(folio);
> > -       if (!swap.val)
> > +       if (!swap.val) {
> > +               if (nr_pages > 1)
> > +                       goto try_split;
> > +
> >                 goto redirty;
> > +       }
> >=20
> >         /*
> >          * Add inode to shmem_unuse()'s list of swapped-out inodes,
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 277571815789..cf982cf2454f 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -628,7 +628,7 @@ typedef enum {
> >   * Calls ->writepage().
> >   */
> >  static pageout_t pageout(struct folio *folio, struct address_space
> > *mapping,
> > -                        struct swap_iocb **plug)
> > +                        struct swap_iocb **plug, struct list_head
> > *folio_list)
> >  {
> >         /*
> >          * If the folio is dirty, only perform writeback if that write
> > @@ -676,6 +676,11 @@ static pageout_t pageout(struct folio *folio, stru=
ct
> > address_space *mapping,
> >                         .swap_plug =3D plug,
> >                 };
> >=20
> > +               if (shmem_mapping(mapping)) {
> > +                       wbc.list =3D folio_list;
> > +                       wbc.split_large_folio =3D
> > !IS_ENABLED(CONFIG_THP_SWAP);
> > +               }
> > +
> >                 folio_set_reclaim(folio);
> >                 res =3D mapping->a_ops->writepage(&folio->page, &wbc);
> >                 if (res < 0)
> > @@ -1259,23 +1264,6 @@ static unsigned int shrink_folio_list(struct
> > list_head *folio_list,
> >                                                 goto activate_locked_sp=
lit;
> >                                 }
> >                         }
> > -               } else if (folio_test_swapbacked(folio) &&
> > -                          folio_test_large(folio)) {
> > -
> > -                       /*
> > -                        * Do not split shmem folio if no swap memory
> > -                        * available.
> > -                        */
> > -                       if (!total_swap_pages)
> > -                               goto activate_locked;
> > -
> > -                       /*
> > -                        * Only split shmem folio when CONFIG_THP_SWAP
> > -                        * is not enabled.
> > -                        */
> > -                       if (!IS_ENABLED(CONFIG_THP_SWAP) &&
> > -                           split_folio_to_list(folio, folio_list))
> > -                               goto keep_locked;
> >                 }
> >=20
> >                 /*
> > @@ -1377,18 +1365,21 @@ static unsigned int shrink_folio_list(struct
> > list_head *folio_list,
> >                          * starts and then write it out here.
> >                          */
> >                         try_to_unmap_flush_dirty();
> > -try_pageout:
> > -                       switch (pageout(folio, mapping, &plug)) {
> > +                       switch (pageout(folio, mapping, &plug, folio_li=
st))
> > {
> >                         case PAGE_KEEP:
> >                                 goto keep_locked;
> >                         case PAGE_ACTIVATE:
> > -                               if (shmem_mapping(mapping) &&
> > folio_test_large(folio) &&
> > -                                   !split_folio_to_list(folio, folio_l=
ist))
> > {
> > +                               /* Shmem can be split when writeback to=
 swap
> > */
> > +                               if ((nr_pages > 1) &&
> > !folio_test_large(folio)) {
> > +                                       sc->nr_scanned -=3D (nr_pages -=
 1);
> >                                         nr_pages =3D 1;
> > -                                       goto try_pageout;
> >                                 }
> >                                 goto activate_locked;
> >                         case PAGE_SUCCESS:
> > +                               if ((nr_pages > 1) &&
> > !folio_test_large(folio)) {
> > +                                       sc->nr_scanned -=3D (nr_pages -=
 1);
> > +                                       nr_pages =3D 1;
> > +                               }
> >                                 stat->nr_pageout +=3D nr_pages;
> >=20
> >                                 if (folio_test_writeback(folio)) {=

