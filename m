Return-Path: <linux-kernel+bounces-358125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6B997A78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7AE1C23000
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFABE6F;
	Thu, 10 Oct 2024 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uoLKtioK"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3B224CF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526520; cv=none; b=tDoi3DM+36K13rE5cIMZ3w5BgEV29aLXrSUScd5WL+V2v0MOAzGONw6fsijelk/bgovfvGsj3tld9qqDM0c4qCzt1MNaUPi89V0pa9APHF0Z+WjqIzKuaMUkzJFMr5iZLmSWYOTGhn49lETHc8zClB9V4MvAypT9CGSa6PEGjrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526520; c=relaxed/simple;
	bh=1QcBiu8yj40Szwbkn6iYTlcbBVpRSwx3E8lhYmcevTk=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=tUbitB1ob94rf2Zs83p3T766FhoiIE1n4LVix8CpUpiaV3bCGqFEfPiVNrUVbIXxz7y8RmTpcmg3WQDVP9+N7xx3Ufcr8+f0S03r2HfHJ3eYRQlV90GYUswG+I/zd/a4DC2wmxGZ1P2A7H27HShmToVDVT8PoMYUiV0VoNq7Boo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uoLKtioK; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241010021507epoutp028e026a88004ab77d72227d82d6bebf0f~89bNVkTXo1184811848epoutp021
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:15:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241010021507epoutp028e026a88004ab77d72227d82d6bebf0f~89bNVkTXo1184811848epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728526507;
	bh=KwezmccuvsEkQ3QUmoSF817fDPmnmjO8YiMhahZ8F4c=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=uoLKtioK0savDC0GARSv3+Owb+giaGWDPWhQUIyRW9a1896bf0CFYBzoRQS0FsOGd
	 mKYU3LoRMqaFVVgRNI6nK0O4bay1d63n9WKwgfv1IokhCu79NkXk0NQI1k3UR4oIgv
	 CKeCE79lGSJnvbBB91V6nRVpEpHg1sZWEEjhfLBQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20241010021507epcas2p28f7b82e37d616365652e2b17f1c0cf4d~89bM62zuL2751627516epcas2p2y;
	Thu, 10 Oct 2024 02:15:07 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XPCyL40hYz4x9Q3; Thu, 10 Oct
	2024 02:15:06 +0000 (GMT)
X-AuditID: b6c32a48-7f9ff70000002653-7c-670738aafec8
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	31.E5.09811.AA837076; Thu, 10 Oct 2024 11:15:06 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [PATCH] libf2fs: Fix calculation of usable segments for
 single zoned
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From: Yonggil Song <yonggil.song@samsung.com>
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dongjin Kim <dongjin_.kim@samsung.com>,
	Siwoo Jung <siu.jung@samsung.com>, Daejun Park <daejun7.park@samsung.com>
CC: Yonggil Song <yonggil.song@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <e26d7399-a0a7-4646-8e93-267cb20018cf@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241010021506epcms2p21d877e3c72389b41805db31f391d2b42@epcms2p2>
Date: Thu, 10 Oct 2024 11:15:06 +0900
X-CMS-MailID: 20241010021506epcms2p21d877e3c72389b41805db31f391d2b42
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTQneVBXu6wdyPohanp55lslj1INzi
	x0kTiyfrZzFbXFrkbnF51xw2i/MTXzNZTD1/hMmBw2PTqk42j90LPjN59G1ZxejxeZNcAEtU
	tk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0A1KCmWJ
	OaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM
	WfP3sBcc5604vO8ySwPjRa4uRk4OCQETie0b17N0MXJxCAnsYJRY9/EAcxcjBwevgKDE3x3C
	IDXCAmESz3p2sYHYQgJKEtcO9LJAxPUlNi9exg5iswnoSvzdsBzMFhG4yiQx8b8BiM0soC2x
	cfZZJohdvBIz2p+yQNjSEtuXb2UEsTkF7CRm3JvCDhHXkPixrJcZwhaVuLn6LTuM/f7YfEYI
	W0Si9d5ZqBpBiQc/d0PFJSUWHToPtStf4u+K62wQdo3E1oY2qLi+xLWOjWA38Ar4SvROPQE2
	n0VAVeLvrJ9Qt7lIzHp2lBXifnmJ7W/ngIOEWUBTYv0ufRBTQkBZ4sgtFogKPomOw3/ZYT7c
	Me8J1CY1ic2bNrNC2DISFx63MUK0ekic/Rw0gVFxFiKYZyFZNQth1QJG5lWMYqkFxbnpqcVG
	BSbwmE3Oz93ECE6LWh47GGe//aB3iJGJg/EQowQHs5IIr+5C1nQh3pTEyqrUovz4otKc1OJD
	jKZAT05klhJNzgcm5rySeEMTSwMTMzNDcyNTA3Mlcd57rXNThATSE0tSs1NTC1KLYPqYODil
	Gpi4DltK36qonN608+ojv0XVC348+LPkSO+0TOMtK++ceXHS+fxdudy1u4tkC6X/nTQ05VM4
	V3vG+qHJ3sY1yolLls+c3v2Zbcu7pRE7E5YVXls1P0XvYETtfuY5m2/2vL/JKtgU19eRHNnA
	U+cwudtx+a89ElzyD4vTpk0qW7VlaZTFN7Zm2+/3rKJ5yjd1G3x/JBCTJslVuKP37OQXbi+9
	o1XPr/t84HFffezF1tN+u43FVWqCXLkuLjl43ZflkZLDpith21em/8mcky6oudp5lzUDi8Jt
	zeZ+Z23OevVvEZNM3Mrymcq954TOf1BXnu/tknxqssyaTOG9h6feFrrx+uod1mqtFOHwlGVP
	z9UqsRRnJBpqMRcVJwIAJLSZzhQEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303
References: <e26d7399-a0a7-4646-8e93-267cb20018cf@kernel.org>
	<20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
	<CGME20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p2>

> On 2024/10/7 13:21, Yonggil Song wrote:
> > There was a bug that did not subtract the super block area when calculating
> > the usable segments for a single zoned device with a conventional zone.
> > This bug resulted in incorrect the overprovision and reserved area.
> > 
> > 	<256MiB legacy block + zoned block w/ 32MiB zone size>
> > 	Info: Overprovision ratio = 3.570%
> > 	Info: Overprovision segments = 656 (GC reserved = 560)
> > 
> > 	<8 conventional zone + 1016 sequential zone w/ 32MiB zone size>
> > 	Info: Overprovision ratio = 3.700%
> > 	Info: Overprovision segments = 676 (GC reserved = 578)
> > 
> > This patch fixes the bug by subtracting the super block area when there is
> > only one zoned device.
> > 
> > Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> > ---
> >   lib/libf2fs_zoned.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
> > index 89ba5ad73a76..cc5c064b7e3e 100644
> > --- a/lib/libf2fs_zoned.c
> > +++ b/lib/libf2fs_zoned.c
> > @@ -555,6 +555,11 @@ uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
> >   	}
> >   	usable_segs -= (get_sb(main_blkaddr) - get_sb(segment0_blkaddr)) >>
> >   						get_sb(log_blocks_per_seg);
> > +
> > +	/* single zoned device needs to remove a super block area */
> 
> If we don't format zoned device, it doesn't need to do this?
> 
> Thanks,
> 
Yes, single zoned block only needs this.

legacy block just return a segment_count_main.

thanks.
> > +	if (c.ndevs == 1)
>  > +		usable_segs -= (get_sb(segment0_blkaddr) >> get_sb(log_blocks_per_seg));> +
> >   	return usable_segs;
> >   #endif
> >   	return get_sb(segment_count_main);

