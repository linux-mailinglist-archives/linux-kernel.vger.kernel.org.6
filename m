Return-Path: <linux-kernel+bounces-269945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1594391F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F1728706C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061DC16D4EF;
	Wed, 31 Jul 2024 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RSVPX/3U"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC5416D31F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466576; cv=none; b=KoC60ZZE7YA5kwIZoLHhIT5RuiVN1wfiU22yd5ozynUeG+MEEXHTO9P75yFiNDx/VHxy4c/zEV/7/TIpoyzBwrS4i3GGuKCLfsMHEqhEH8NOt6K3aV+rtjubpeqght7ytQmD62nKjEgHH75AsRqDS0ONKiOOkFZXqyfUQUqlvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466576; c=relaxed/simple;
	bh=fLySaJI+s42acrq3KrESb0qOTBcq76j0GOR33/fT5iU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Tgv/FmWkBBg+o6QWLNu4NOu4fu+6nu/TI68Bb09QhS0OMXodyhi4mzIilmyvByxMJVmxnKIA2eQgxHKLwXfMaSXzwqzcyew96LJ4irxWynIMEDH0jW7A6MbgRdxQzcdSJa9UZfbJKaKAYPHNGEgA8OsD66Z+DjYgFTh29BUINsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RSVPX/3U; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240731225611epoutp02709c0eca67bfd17f68417ad4ab5e5bea~nbjh63qP82653426534epoutp02e
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:56:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240731225611epoutp02709c0eca67bfd17f68417ad4ab5e5bea~nbjh63qP82653426534epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722466571;
	bh=zlqpRjHz/IRIwWhYTrNNvNI1h1x+gZwWuAq932L6Pgg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=RSVPX/3U0fUVPfYNm8Lz7SIog3r+IZUCOnB6JvbkK+4kXlmmiFxA5aKwep9vtHy3n
	 ytp1H/4c/02ywyAmyTEkgjX7arnpLwrmMFodP0W6Z/PkuVUyHIbiqlnMyiMT23QrVO
	 xo6K1Nm/5SMgkqYPf+pjb8JVX+6+Fu6LKY/v6OYY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240731225611epcas1p48bf79e684460ac556ed6d0b5778323c2~nbjhqDZ5T2031620316epcas1p4n;
	Wed, 31 Jul 2024 22:56:11 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.222]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WZ6s62z7Xz4x9Q1; Wed, 31 Jul
	2024 22:56:10 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.BD.09734.A01CAA66; Thu,  1 Aug 2024 07:56:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240731225609epcas1p41a12adeeb344f020842e89e0d86f0c06~nbjgllz8U2031620316epcas1p4k;
	Wed, 31 Jul 2024 22:56:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240731225609epsmtrp2e93ce6cc809bf201e329c9a1cea975bb~nbjgk2JOB0771307713epsmtrp2R;
	Wed, 31 Jul 2024 22:56:09 +0000 (GMT)
X-AuditID: b6c32a35-babff70000002606-1d-66aac10a423e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.B0.07567.901CAA66; Thu,  1 Aug 2024 07:56:09 +0900 (KST)
Received: from manjaecho04 (unknown [10.89.15.251]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240731225609epsmtip1539848ee8db9bc3fb38b32e455852013~nbjgVlBuU2780127801epsmtip1a;
	Wed, 31 Jul 2024 22:56:09 +0000 (GMT)
From: "Manjae Cho" <manjae.cho@samsung.com>
To: "'Philipp Hortmann'" <philipp.g.hortmann@gmail.com>, "'Greg KH'"
	<gregkh@linuxfoundation.org>
Cc: <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
In-Reply-To: <8f82f816-b677-4f6d-b381-d25f0bb04521@gmail.com>
Subject: RE: [PATCH v2] staging: rtl8723bs: Improve clarity of MAR usage
Date: Thu, 1 Aug 2024 07:56:09 +0900
Message-ID: <009001dae39c$d5768a90$80639fb0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGq6u6gQ38G25DvcpxmdxsIcN+z7AFABfaHAm6cAkiyU+2rAA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTQJfr4Ko0g60b+S2aF69ns7i8aw6b
	xZHPqRaTl01kdGDx2DnrLrvH/rlr2D1ebJ7J6PF5k1wAS1S2TUZqYkpqkUJqXnJ+SmZeuq2S
	d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QRiWFssScUqBQQGJxsZK+nU1RfmlJqkJG
	fnGJrVJqQUpOgVmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbjtxfZCw6JVSx/M4m9gXGrUBcj
	J4eEgInErNM/WboYuTiEBHYwSpztv80OkhAS+MQoceecD0TiG6PE710/mWE6fvy8xQqR2Mso
	sXxeKyOE84JR4vaTkywgVWwC2hL7t70A6xARSJb4/6kZLM4s4Cyxtmsx2ApOAVuJK1u/g9UI
	C3hIPFm0DijOwcEioCLR+E4QJMwrYCkx5+d/FghbUOLkzCdQY7Qlli18DXWQgsTPp8tYIVY5
	STR+2cUGUSMiMbuzjRnkNgmBr+wSN3b/hmpwkfi69RIrhC0s8er4FnYIW0ri87u9bBB2scTS
	P5tYIOwaiaetM6BsY4mf5z4xg9zJLKApsX6XPsQuPol3X3tYQcISArwSHW3Q0FWROL9qAxNE
	WEqi4aAhRNhD4kzzJuYJjIqzkDw2C8ljs5A8MAth1wJGllWMYqkFxbnpqcWGBYbwqE7Oz93E
	CE6KWqY7GCe+/aB3iJGJg/EQowQHs5IIr9DJlWlCvCmJlVWpRfnxRaU5qcWHGE2BIT2RWUo0
	OR+YlvNK4g1NLA1MzIxMLIwtjc2UxHnPXClLFRJITyxJzU5NLUgtgulj4uCUamBKK5nzSoV/
	WZyq63mDkBK392xVe/ckM252ke/s0rxgtvvYPql3XzxjbO6F1bPFF530/ummJTY9eCOrz+mN
	5TnrD2ZeD5tUNnuq5tuSx/8OPzyg/eHV1ttvXjKdbTy2IO0rz7rp1TlhezxkNlzXvTVjSnl0
	Zcxmo9l37x6YYMG+5twhlt1rz+yetc49913e2qi7X2/u252+132+wI1p0T/TdDVNVTZ61KvN
	beadbPPGU/MSzwM202zbCWp8fHsPpx5o6WMXniu474T2kwdbN0o3nMq7XC+ZbH7h6Py+vZ/W
	WxbzH+7TfiKo81Tq2KRzmzifeN1XvKC9w2OXwLF821WvLmk6bPX6m/DB7Ju+SsChUiWW4oxE
	Qy3mouJEAGM3hbITBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSnC7nwVVpBo9W6Vo0L17PZnF51xw2
	iyOfUy0mL5vI6MDisXPWXXaP/XPXsHu82DyT0ePzJrkAligum5TUnMyy1CJ9uwSujJl3rzMX
	bBKrOPDjJ2MD41yhLkZODgkBE4kfP2+xdjFycQgJ7GaU2LbnKhtEQkriflsTcxcjB5AtLHH4
	cDFEzTNGibNNS9hBatgEtCX2b3vBDGKLCCRLTOxZzgpiMwu4SmyevpoJomE/o8SamU1gQzkF
	bCWubP0O1iAs4CHxZNE6dpAFLAIqEo3vBEHCvAKWEnN+/meBsAUlTs58wgIxU1vi6c2ncPay
	ha+ZIe5UkPj5dBkrxA1OEo1fdrFB1IhIzO5sY57AKDwLyahZSEbNQjJqFpKWBYwsqxglUwuK
	c9Nzkw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNES2MH4735//QOMTJxMB5ilOBgVhLhFTq5Mk2I
	NyWxsiq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZqakFqUUwWSYOTqkGplVsod2SywLk
	3wl/XXqMT69LXfK6S6PZlFydsCYuxmOZ02fdtexRu9NUbu3udf9XQ+Ym3TQT7oRg+3vlAkbn
	Ju+rTPY5MOWL6+9uw1SjA+ni4rKV55ReWgdOCr7pJ5ShEVmdlPBu95N2JSv7F6ffRPnuCrsV
	cf8dy5W9J4Vepr5nZ417lMzwUrR3yZaAH6s75K72z5oYFpN39Or66YGuv19Ha/isldF/t8Zc
	jvlv8Zm7532nFZ0sy39SPF3lusD137uTv2m+fbHH/2TRSb2Z1wJ+hOqszkne5rvw6I3bH+dP
	XMdkbDltSfBJr7+5/4KzfWS2FFZv1rK2WtMzc93MNS/qC8+z8JzlOxFZLf/RVImlOCPRUIu5
	qDgRAKw1GsoAAwAA
X-CMS-MailID: 20240731225609epcas1p41a12adeeb344f020842e89e0d86f0c06
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240731081603epcas1p1d140964329ddaf9146bacb6bd1111506
References: <CGME20240731081603epcas1p1d140964329ddaf9146bacb6bd1111506@epcas1p1.samsung.com>
	<20240731081540.912533-1-manjae.cho@samsung.com>
	<8f82f816-b677-4f6d-b381-d25f0bb04521@gmail.com>

> On 7/31/24 10:15, Manjae Cho wrote:
> > This patch improves the readability of the code related to the
> > Multicast Address Register (REG_MAR) in the rtl8723bs driver. It adds
> > comments to clarify the purpose and offset of the register, making the
> > code more self-documenting without introducing new macros.
> >
> > Signed-off-by: Manjae Cho <manjae.cho=40samsung.com>
> > ---
> >
> > v2: Add comments for clarity instead of new macros
> >
> >   drivers/staging/rtl8723bs/hal/sdio_halinit.c =7C 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > index c9cd6578f7f8..535cd439121d 100644
> > --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> > =40=40 -380,8 +380,8 =40=40 static void _InitWMACSetting(struct adapter
> *padapter)
> >   	rtw_write32(padapter, REG_RCR, pHalData->ReceiveConfig);
> >
> >   	/*  Accept all multicast address */
> > -	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);
> > -	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);
> > +	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);	/* Offset 0x0620-
> 0x0623 */
> > +	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);	/* Offset
> 0x0624-0x0627 */
> >
> >   	/*  Accept all data frames */
> >   	value16 =3D 0xFFFF;
>=20
> Hi Manjae,
>=20
> may be this is version v2 of this patch with this subject. But the versio=
n
> is not about the subject. It is about the code change itself.
>=20
> So I can see that this patch was send in with the following subjects:
> =5BPATCH=5D Improve MAR register definition and usage for rtl8723 =5BPATC=
H v2=5D
> staging: rtl8723bs: Improve MAR register definition and usage =5BPATCH=5D
> staging: rtl8723bs: Improve MAR register definition and usage =5BPATCH v2=
=5D
> staging: rtl8723bs: Improve clarity of MAR usage
>=20
> To me the last patch should be a v4. The next patch you send is the v5.
> A change history is expected.
>=20
> Description from Dan under:
> https://protect2.fireeye.com/v1/url?k=3Dc5b934df-a4c29e56-c5b8bf90-
> 74fe48600034-85e35d54190727cc&q=3D1&e=3Dba0ae6e7-57f8-40be-8018-
> 0e0bdfedbf8e&u=3Dhttps%3A%2F%2Fstaticthinking.wordpress.com%2F2022%2F07%2=
F27
> %2Fhow-to-send-a-v2-patch%2F
>=20
> Thanks for your support.
>=20
> Bye Philipp

Dear Philipp,

Thank you for your detailed feedback and guidance on the patch versioning a=
nd change history.
I appreciate your guidance.

I will implement these improvements in the next version (v5):

1. Use consistent patch versioning
2. Include a complete change history
3. Maintain a consistent subject line

I'll submit the revised v5 patch soon, incorporating these changes.

Thanks again for your support.

Best regards,
Manjae Cho





