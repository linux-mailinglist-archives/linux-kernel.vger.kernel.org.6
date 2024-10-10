Return-Path: <linux-kernel+bounces-358239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B763997BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178431F248E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184AB16A395;
	Thu, 10 Oct 2024 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i5wDlgin"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB003D66
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534690; cv=none; b=n2rFbd0mHPN3UbInDEtbnqAXzAhwcgeuBoq+Yc/ltA0yd1T2NYZ08/69wOmKG972FEDXY7XZT39zL00WouxpxE2kgR20vS8OfrFDeKSnynH1lGEmTwYqOlU6NHX+hRA1Row0PUaEKWsD4S3mfKx9sYhmeUDPKTvtuLKFoyLaS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534690; c=relaxed/simple;
	bh=xoAWVFlyXWDGuHOloM95BFE5g5yQzGWtKSJ04M2FqC4=;
	h=Mime-Version:Subject:From:To:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=Qej+Y+GHPOOKswuyaCPgeBzCA1LhznTLI8P96e+zUJ72jLewryVr3h/JgAlyiszI9TgMx9KMrCFBfT7BDwmR6RuSS3zEP1UEMa527d63p3ZGfhBo34fjhFuJcy6KRF68Hcg5rdf7W5j1/nwesKprSA6XRUltrZWkaqMI4Qz2CcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=i5wDlgin; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241010043124epoutp0259d2ce7a8b021a257e6d1f180caf0821~8-SM4Uzi91348913489epoutp02f
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:31:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241010043124epoutp0259d2ce7a8b021a257e6d1f180caf0821~8-SM4Uzi91348913489epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728534684;
	bh=liYFFMSBTTST7ShgTxu6v581/PBjKd9MlqCCOtTNcgM=;
	h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
	b=i5wDlginYwpcplTcjhdHr6eD9ZguObWUzG7oEobasZoh8eI/e+9zM2wP2ZSQmpLay
	 wZlGi8hB4vD2RNiX+wfBD716KI8+75T9y5z22dNRpS8NzvpZoQjam6Xop3e9JkK5CE
	 S/bezwNIVv07v1zzkonNuRVCLY22RWCDmvzjmUio=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20241010043124epcas2p3c0600ef9ce4becc1ebd7346fe4b95c47~8-SMbVEqT2713427134epcas2p39;
	Thu, 10 Oct 2024 04:31:24 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XPGzb4KPKz4x9Q0; Thu, 10 Oct
	2024 04:31:23 +0000 (GMT)
X-AuditID: b6c32a47-d53fa70000002630-7e-6707589bec00
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.01.09776.B9857076; Thu, 10 Oct 2024 13:31:23 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(3) [PATCH] libf2fs: Fix calculation of usable segments for
 single zoned
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From: Yonggil Song <yonggil.song@samsung.com>
To: Yonggil Song <yonggil.song@samsung.com>, Chao Yu <chao@kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dongjin Kim <dongjin_.kim@samsung.com>,
	Siwoo Jung <siu.jung@samsung.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20241010021506epcms2p21d877e3c72389b41805db31f391d2b42@epcms2p2>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241010043123epcms2p2ad514eb5e4a94413d8b26aea56f772a8@epcms2p2>
Date: Thu, 10 Oct 2024 13:31:23 +0900
X-CMS-MailID: 20241010043123epcms2p2ad514eb5e4a94413d8b26aea56f772a8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQnd2BHu6wbcL8hanp55lslj1INzi
	x0kTiyfrZzFbXFrkbnF51xw2i/MTXzNZTD1/hMmBw2PTqk42j90LPjN59G1ZxejxeZNcAEtU
	tk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0A1KCmWJ
	OaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM
	1v+7WQo+8lXMmPCSrYFxL3cXIyeHhICJxI+mj4xdjFwcQgI7GCWWf/zA2sXIwcErICjxd4cw
	SI2wQJjExn/7GUFsIQEliWsHelkg4voSmxcvYwex2QR0Jf5uWM4OMkdEoIFZYvfTTUwQC3gl
	ZrQ/ZYGwpSW2L98KNohTwE/i6bvVbBBxDYkfy3qZIWxRiZur37LD2O+PzWeEsEUkWu+dhaoR
	lHjwczdUXFJi0aHzULvyJf6uuA41s0Zia0MbVFxf4lrHRrAbeAV8JRq+HgazWQRUJW5cv88K
	UeMiMav7LtheZgF5ie1v5zCDwoFZQFNi/S59EFNCQFniyC0WiAo+iY7Df9lhPtwx7wnUJjWJ
	zZs2Q02UkbjwuI0RotVD4uznIEgI9jJJnDkhNYFRYRYinGchWTsLYe0CRuZVjGKpBcW56anF
	RgXG8KhNzs/dxAhOjFruOxhnvP2gd4iRiYPxEKMEB7OSCK/uQtZ0Id6UxMqq1KL8+KLSnNTi
	Q4ymQA9PZJYSTc4Hpua8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4
	pRqYDN6H/M6dr3HNT0D7CPPyNyrbcvhy/4e8TN+2ui9YpHSPhqWjSNOCRXZ3ddWmfXyX7Wuk
	feOJYLHVVM8kta9Hn3Kbd8ltOjD7+vvl216IreAV1+fYts5ybY5ir/LM00sr6haaPHrQOf2v
	cWTqBJljErcC/s86Xbz3zZzEpm/XpnSd9Fn2+u5F81+nf8QFel1S93x1uORiDV/mEsczVWzH
	OQ8a5f76HS6f3v9A8J1SrtiMnl8tjF3Knf/9d9k/WVKw4f/m8PrG1QdNJ10IrejkyNifW2Xc
	oHBvupyqvLOM1yme58nTjr3dvf7vROfJj/z2Juj8u1MgvattwimNOtUTrvrdTzjZf1btvpWp
	a9DnrcRSnJFoqMVcVJwIAO8X6L8VBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303
References: <20241010021506epcms2p21d877e3c72389b41805db31f391d2b42@epcms2p2>
	<e26d7399-a0a7-4646-8e93-267cb20018cf@kernel.org>
	<20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
	<CGME20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p2>

> > On 2024/10/7 13:21, Yonggil Song wrote:
> > > There was a bug that did not subtract the super block area when calculating
> > > the usable segments for a single zoned device with a conventional zone.
> > > This bug resulted in incorrect the overprovision and reserved area.
> > > 
> > > 	<256MiB legacy block + zoned block w/ 32MiB zone size>
> > > 	Info: Overprovision ratio = 3.570%
> > > 	Info: Overprovision segments = 656 (GC reserved = 560)
> > > 
> > > 	<8 conventional zone + 1016 sequential zone w/ 32MiB zone size>
> > > 	Info: Overprovision ratio = 3.700%
> > > 	Info: Overprovision segments = 676 (GC reserved = 578)
> > > 
> > > This patch fixes the bug by subtracting the super block area when there is
> > > only one zoned device.
> > > 
> > > Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> > > ---
> > >   lib/libf2fs_zoned.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
> > > index 89ba5ad73a76..cc5c064b7e3e 100644
> > > --- a/lib/libf2fs_zoned.c
> > > +++ b/lib/libf2fs_zoned.c
> > > @@ -555,6 +555,11 @@ uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
> > >   	}
> > >   	usable_segs -= (get_sb(main_blkaddr) - get_sb(segment0_blkaddr)) >>
> > >   						get_sb(log_blocks_per_seg);
> > > +
> > > +	/* single zoned device needs to remove a super block area */
> > 
> > If we don't format zoned device, it doesn't need to do this?
> > 
> > Thanks,
> > 
> Yes, single zoned block only needs this.
> 
> legacy block just return a segment_count_main.
> 
> thanks.
Sorry, I misunderstood.
I'll resend v2 with zoned block checker.

thanks.
> > > +	if (c.ndevs == 1)
> >  > +		usable_segs -= (get_sb(segment0_blkaddr) >> get_sb(log_blocks_per_seg));> +
> > >   	return usable_segs;
> > >   #endif
> > >   	return get_sb(segment_count_main);

