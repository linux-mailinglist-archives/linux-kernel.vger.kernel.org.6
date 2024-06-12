Return-Path: <linux-kernel+bounces-210923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE55904A47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B46E28662B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1410B282F1;
	Wed, 12 Jun 2024 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bOfLQw/b"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E96823769
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167876; cv=none; b=MqQhjAonSVJ+4jqEp09ghjAKfkppb4r3F2ITulOtE9CWm7a1mbudAhiT8Mfmz+zeDoX5lKwsFamLXc6Nmj1IQi9YbojPmvvOUa3uuK/eEm3+P0yFPbwmN6FfFRTtZAJybvbkAW43XwNUr89FbWB5yVA58t0iLySfR3Y4fnxTIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167876; c=relaxed/simple;
	bh=MS87o5SRN8topXTaNuvhNHgnc0qs7VmdJ0nDgVQVRsg=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=SgSZvYsVEmccIs+ydE3EK0d605F32X4nY10D4MierppmKNfLeIT6LlZNqkNVMK+voy/V8mHe67H53XcPFuSKojcO97sB7weAJ7NvkB+Uz3kmSMaHO9vqvqSJeMAVfG2X209+fPRDiNXn62GtDWO8icrscZc3qKTvsucNFnKG3xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bOfLQw/b; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240612045104epoutp0341e15d07112179509fe161706ca5f58b~YKJHS8wrD3115231152epoutp03Y
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:51:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240612045104epoutp0341e15d07112179509fe161706ca5f58b~YKJHS8wrD3115231152epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718167864;
	bh=MS87o5SRN8topXTaNuvhNHgnc0qs7VmdJ0nDgVQVRsg=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=bOfLQw/bSf7HgrsA5rqY28yBZ7Y5IeuekCuxrs2LrhFvKtfFjxj7qD3Sf9aa+H5P0
	 pTeMESMy6Xkl3bgJ9SKsijFzUngRwfiFuc91fzB+F5/X42cUYLy44K2+t2I0B1orsE
	 BYNTL32I8ctfIl2AQUP52mgpohhleCSSTw/olxp4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240612045103epcas2p37c6792f70352007d6bd91316ccf49774~YKJF42sYG0620806208epcas2p3L;
	Wed, 12 Jun 2024 04:51:03 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.100]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VzY5f5QMgz4x9Pp; Wed, 12 Jun
	2024 04:51:02 +0000 (GMT)
X-AuditID: b6c32a43-993ff7000000dbb1-ec-66692936f8c6
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.F8.56241.63929666; Wed, 12 Jun 2024 13:51:02 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [PATCH] f2fs: fix convert inline inode on readonly mode
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Dongjin Kim <dongjin_.kim@samsung.com>, Seokhwan Kim
	<sukka.kim@samsung.com>, Yonggil Song <yonggil.song@samsung.com>, Eunhee Rho
	<eunhee83.rho@samsung.com>, Jaeyoon Choi <j_yoon.choi@samsung.com>, Nayeon
	Kim <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>, Daejun
	Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <dfdf7dac-90e2-4ee7-8258-ffca0c777d9e@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240612045001epcms2p2338ee24b2e1f107a72f274f2a88b93e7@epcms2p2>
Date: Wed, 12 Jun 2024 13:50:01 +0900
X-CMS-MailID: 20240612045001epcms2p2338ee24b2e1f107a72f274f2a88b93e7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmma6ZZmaawccVWhanp55lsnh5SNNi
	1YNwix8nTSx+Pulgs+jf3c5i8WT9LGaLS4vcLS7vmsNm0fLHyeL8xNdMFqs65jJaTD1/hMmB
	12PTqk42j90LPjN59G1ZxejxeZNcAEtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
	pYW5kkJeYm6qrZKLT4CuW2YO0GlKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALz
	Ar3ixNzi0rx0vbzUEitDAwMjU6DChOyMZVt3sBZcFKs4un0DWwPjE5EuRk4OCQETiUuz57F3
	MXJxCAnsYJR4tXYlcxcjBwevgKDE3x3CIDXCAu4SO15NZgGxhQSUJNZfnMUOEdeTuPVwDSOI
	zSagIzH9xH2wOSICDxglptzYywbiMAscZJJ4uOosC8Q2XokZ7U+hbGmJ7cu3MoIs4xSwk/jT
	HAsR1pD4sayXGcIWlbi5+i07jP3+2HxGCFtEovXeWagaQYkHP3dDxSUlbs/dBFWfL/H/ynIo
	u0Zi24F5ULa+xLWOjSwQP/pK9L6pAAmzCKhKrNvVDDXGRWL6+zYwm1lAW2LZwtfgIGEW0JRY
	v0sfxJQQUJY4cosFooJPouPwX3aY/xo2/sbK3jHvCROErSax7ud6pgmMyrMQ4TwLya5ZCLsW
	MDKvYhRLLSjOTU9NNiowhEdtcn7uJkZwGtVy3sF4Zf4/vUOMTByMhxglOJiVRHjPxKSnCfGm
	JFZWpRblxxeV5qQWH2I0BfpyIrOUaHI+MJHnlcQbmlgamJiZGZobmRqYK4nz3mudmyIkkJ5Y
	kpqdmlqQWgTTx8TBKdXAdF3OjmOe7PqNVeLX7klYaatfaKu6Wzkr764Gd7+q3dmi3J3sYvz1
	+hnCB+sECsqOu2wodAj/vFR6nYbrsTDmrQeW7u+/OFdVil8pXWzWvQUuM9iOHhYR474e9ujm
	VJFpaw3CH5l58a11W6W5KfFq7J7ZIstXf167/h27Qt2/DTKGFdfTvJbpcHppZFX9i7Ff2j7V
	v65b/2r1QT2Z7e0rrC4xWfo3/DC86rI7Z+7RFnG/mIglzLN1VHZaz/irP9N97j6+krPLN8oG
	brn6xffH9T+zO2+sbjhoZxBs16CYU7fw9NQIg8vJL7VtnuzyPMqsufSpWo/HlOIMp25moX37
	2jelXS10fS2SI/1R4nuMEktxRqKhFnNRcSIAwl+gRywEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240612022012epcms2p77300b5130d18b0397c9fc2877704949d
References: <dfdf7dac-90e2-4ee7-8258-ffca0c777d9e@kernel.org>
	<20240612022012epcms2p77300b5130d18b0397c9fc2877704949d@epcms2p7>
	<CGME20240612022012epcms2p77300b5130d18b0397c9fc2877704949d@epcms2p2>

> On 2024/6/12 10:20, Daejun Park wrote:
> > syzbot reported a bug in f2fs_vm_page_mkwrite() which checks for
> > f2fs_has_inline_data(inode).
> > The bug was caused by f2fs_convert_inline_inode() not returning an
> > error when called on a read-only filesystem, but returning with the
> > inline attribute as set.
> > This patch fixes the problem by ensuring that f2fs_convert_inline_inode=
()
> > returns -EROFS on readonly.
> >
> > Fixes: ec2ddf499402 (=22f2fs: don't allow any writes on readonly mount=
=22)
> > Reported-by: syzbot+f195123a45ad487ca66c=40syzkaller.appspotmail.com
> > Closes: https://protect2.fireeye.com/v1/url?k=3D4fe36b34-10785251-4fe2e=
07b-000babff32e3-e4235a49bbe14a93&q=3D1&e=3Db7eda9c4-8db2-474e-801d-f3eb85d=
38066&u=3Dhttps%3A%2F%2Fsyzkaller.appspot.com%2Fbug%3Fextid%3Df195123a45ad4=
87ca66c
> > Signed-off-by: Daejun Park <daejun7.park=40samsung.com>
>=20
> Hi Daejun,
>=20
> I guess below patch has fixed this issue, so we need to tag the report
> as duplicated?
>=20
> https://lore.kernel.org/linux-f2fs-devel/20240603010745.2246488-1-chao=40=
kernel.org/T/=23u
>=20
> Thanks,

Hi Chao,

I didn't check that patch, please simply ignore it, thank you :)

Thanks,
Daejun

> > ---
> >=C2=A0=20fs/f2fs/inline.c=206=20++++--=0D=0A>=20>=C2=A0=201=20file=20cha=
nged,=204=20insertions(+),=202=20deletions(-)=0D=0A>=20>=0D=0A>=20>=20diff=
=20--git=20a/fs/f2fs/inline.c=20b/fs/f2fs/inline.c=0D=0A>=20>=20index=20763=
8d0d7b7ee..ae1d8f2d82c9=20100644=0D=0A>=20>=20---=20a/fs/f2fs/inline.c=0D=
=0A>=20>=20+++=20b/fs/f2fs/inline.c=0D=0A>=20>=20=40=40=20-203,10=20+203,12=
=20=40=40=20int=20f2fs_convert_inline_inode(struct=20inode=20*inode)=0D=0A>=
=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20page=20*ipage,=20=
*page;=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20int=20err=20=
=3D=200;=0D=0A>=20>=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20if=20(=21f2fs_=
has_inline_data(inode)=0D=0A>=20>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20f2fs_hw_is_r=
eadonly(sbi)=20f2fs_readonly(sbi->sb))=0D=0A>=20>=20+=C2=A0=20=C2=A0=20=C2=
=A0=20if=20(=21f2fs_has_inline_data(inode))=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=200;=0D=
=0A>=20>=0D=0A>=20>=20+=C2=A0=20=C2=A0=20=C2=A0=20if=20(unlikely(f2fs_hw_is=
_readonly(sbi)=20f2fs_readonly(sbi->sb)))=0D=0A>=20>=20+=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20-EROFS;=0D=0A>=20>=20=
+=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20err=20=3D=20f2fs_d=
quot_initialize(inode);=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20if=20(err)=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20err;=0D=0A>=20>=20--=0D=0A>=20>=
=202.25.1=0D=0A>=20>

