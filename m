Return-Path: <linux-kernel+bounces-365002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D4999DC17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCB41F2162B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39BC15C128;
	Tue, 15 Oct 2024 02:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NJhZpBaX"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AE22AEE0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728958347; cv=none; b=VXRz3AimL06dzmHZtplocPlPECZpzt82+aYdfYiuERsGbpWtwWcNAkDV+6zawuWu57LsBtpOd1f/h+gHDs7XojjbagAo5cyR6skFr2prVLR2G98cQoRHiWQ61mIubU0jeEdpWBxpntmqy5R8Ch6LYDDdXLxaZLheY30XOr1/WkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728958347; c=relaxed/simple;
	bh=a0O9khp2+ow6nAS8rLHCCnkne93g+RH55PaDPWoGIfU=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=YB1h5whus6rVknQLUhWshAi/siAFHIZsKV3d/VNZsPMVYR2GlmMF1l4aIv+KXWcsI/H+XXL85pHKyt2pfXg5vygLc9DH0jepQKsPByjJ1xRsFbQio9kEVbisZyutFIY7HUFKbciMacvyUZ01PRp6auElugtELk52iNUq1kC/wWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NJhZpBaX; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241015021217epoutp02d73e227d579922459e00d209c5c8eb48~_fnJ53wRN2906529065epoutp02o
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:12:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241015021217epoutp02d73e227d579922459e00d209c5c8eb48~_fnJ53wRN2906529065epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728958337;
	bh=a0O9khp2+ow6nAS8rLHCCnkne93g+RH55PaDPWoGIfU=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=NJhZpBaXQFXGUwNjdVOGAe+Jigl76043Oyn3MMu+eyqMy4mwJ6V2dxES2DsD4fjjY
	 P86pbEZ8T8iSzKjfV8RAyJPgSGJ7nrOa80LeMGRKg+sdHG1Om226vp7cgcJIWyEc5M
	 HVekA2eOTEfRxUwne+jKInSwn7WT8XHxUaGpuWN0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20241015021216epcas2p156ab905c96afefb8a851037850d71a6f~_fnJkYLbD0950909509epcas2p1n;
	Tue, 15 Oct 2024 02:12:16 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XSHfm0mvJz4x9Pt; Tue, 15 Oct
	2024 02:12:16 +0000 (GMT)
X-AuditID: b6c32a47-aefff70000002630-47-670dcf7f7ed2
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	D8.13.09776.F7FCD076; Tue, 15 Oct 2024 11:12:15 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [f2fs-dev] [PATCH] f2fs: support dio write for zoned storage
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Daeho Jeong <daeho43@gmail.com>
CC: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dongjin Kim <dongjin_.kim@samsung.com>,
	Siwoo Jung <siu.jung@samsung.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CACOAw_x6iNOjAmm9imCM3_5O+aWT2knhxxZuCOdzmw1_5F43LQ@mail.gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241015021115epcms2p5e3e0c8c288fcbe19a0c41bc6fa3d0d40@epcms2p5>
Date: Tue, 15 Oct 2024 11:11:15 +0900
X-CMS-MailID: 20241015021115epcms2p5e3e0c8c288fcbe19a0c41bc6fa3d0d40
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTXLf+PG+6wa27Nhanp55lsnh5SNPi
	zZEzLBarHoRb/DhpYvFk/Sxmi0uL3C0u75rDZnF+4msmB06PnbPusntsWtXJ5rF7wWcmj74t
	qxg9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQ
	dcvMATpGSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJl
	aGBgZApUmJCd8fLEOqaCLwsZK761ZTQwHprL2MXIySEhYCJx8NUx1i5GLg4hgR2MEgta3jB1
	MXJw8AoISvzdIQxSIyzgI7F4/TUWEFtIQEli/cVZ7BBxPYlbD9eAzWET0JGYfuI+WFxEQFli
	2+WH7CAzmQXuM0lc3ryQHWIZr8SM9qcsELa0xPblWxlBdnEKBEpMWxwIEdaQ+LGslxnCFpW4
	ufotO4z9/th8qJtFJFrvnYWqEZR48HM3VFxS4vbcTVD1+RL/ryyHsmskth2YB2XrS1zr2Ah2
	Aq+Ar8TufT/AelkEVCUWzFnPDnKOhICLxOwzNSBhZgFtiWULXzODhJkFNCXW79KHqFCWOHKL
	BaKCT6Lj8F+4/xo2/sbK3jHvCROErSax7ud6pgmMyrMQwTwLya5ZCLsWMDKvYhRLLSjOTU8t
	Niowhkdtcn7uJkZwqtRy38E44+0HvUOMTByMhxglOJiVRHgndfGmC/GmJFZWpRblxxeV5qQW
	H2I0BXpyIrOUaHI+MFnnlcQbmlgamJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TB
	KdXAZHJQrfxBw2Ouvw4vhBpSGfxiY17X3Fwz/7blDLF9P6aEMHy/KZH2YkKky7YW26pX8UyS
	7VGPTv7T91rS1n6TU2n6kbXTeL9y9jT4e62UZ07uL1Bj3GHMemWP1oTyv10G5uciDu1gPxa3
	+e+Ps3Ypvik3j397sHjPJt8Yq21KBRmXgzK13ff2v/5fH3Kze4eJ4+Rtf7d87HRKfConp/sw
	/8sxj6SNT/63vFynd0Bl++Xvv/l/bXM0kNL6xyr01W3l5iixuAsJPwL5r4pvtVJTNEi8qiJX
	Hxay7aYLU/KXx0FxjEFtThn/jsS+Wyd3P636yY+YJ9vNxNXMjOL9Mxofr6/c7BGv+srwnc2z
	1drvlViKMxINtZiLihMB8zrajx4EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240927072239epcms2p48e5ae61717652c25e1fe3c87ce53573c
References: <CACOAw_x6iNOjAmm9imCM3_5O+aWT2knhxxZuCOdzmw1_5F43LQ@mail.gmail.com>
	<20240927072239epcms2p48e5ae61717652c25e1fe3c87ce53573c@epcms2p4>
	<CGME20240927072239epcms2p48e5ae61717652c25e1fe3c87ce53573c@epcms2p5>

>--------- Original Message ---------
>Sender : Daeho Jeong <daeho43=40gmail.com>
>Date : 2024-10-11 05:42 (GMT+9)
>Title : Re: =5Bf2fs-dev=5D =5BPATCH=5D f2fs: support dio write for zoned s=
torage
>=C2=A0=0D=0A>On=20Fri,=20Sep=2027,=202024=20at=2012:25=E2=80=AFAM=20Daejun=
=20Park=20<daejun7.park=40samsung.com>=20wrote:=0D=0A>>=0D=0A>>=20With=20zo=
ned=20storage,=20F2FS=20avoids=20direct=20IO=20writes=20and=20uses=20buffer=
ed=20writes=0D=0A>>=20with=20page=20cache=20flushes=20to=20prevent=20unalig=
ned=20writes.=20However,=20the=0D=0A>>=20unaligned=20write=20can=20be=20avo=
ided=20by=20allowing=20only=20a=20single=20thread=20per=20zone=0D=0A>>=20to=
=20perform=20direct=20writes.=0D=0A>>=0D=0A>>=20To=20achieve=20direct=20wri=
tes=20in=20zoned=20storage,=20it=20uses=20semephores=20to=20serialize=0D=0A=
>>=20block=20allocation=20and=20writes=20per=20zone.=0D=0A>>=0D=0A>>=20Sign=
ed-off-by:=20Daejun=20Park=20<daejun7.park=40samsung.com>=0D=0A>>=20---=0D=
=0A>>=C2=A0=20fs/f2fs/data.c=C2=A0=20=C2=A0=2028=20++++++++++++++++++++++++=
++-=0D=0A>>=C2=A0=20fs/f2fs/f2fs.h=C2=A0=20=C2=A0=20=C2=A0=207=20+++++--=0D=
=0A>>=C2=A0=20fs/f2fs/file.c=C2=A0=20=C2=A0=2048=20++++++++++++++++++++++++=
++++++++++++++++-------=0D=0A>>=C2=A0=20fs/f2fs/gc.c=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=204=20++--=0D=0A>>=C2=A0=20fs/f2fs/segment.c=20=C2=A0=206=20++=
+---=0D=0A>>=C2=A0=20fs/f2fs/super.c=C2=A0=20=C2=A0=205=20++++-=0D=0A>>=C2=
=A0=206=20files=20changed,=2082=20insertions(+),=2016=20deletions(-)=0D=0A>=
>=0D=0A>>=20diff=20--git=20a/fs/f2fs/data.c=20b/fs/f2fs/data.c=0D=0A>>=20in=
dex=20b94cf6eea2f9..fa2bd88a2ed2=20100644=0D=0A>>=20---=20a/fs/f2fs/data.c=
=0D=0A>>=20+++=20b/fs/f2fs/data.c=0D=0A>>=20=40=40=20-922,7=20+922,7=20=40=
=40=20int=20f2fs_merge_page_bio(struct=20f2fs_io_info=20*fio)=0D=0A>>=C2=A0=
=20=7D=0D=0A>>=0D=0A>>=C2=A0=20=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>>=20-s=
tatic=20bool=20is_end_zone_blkaddr(struct=20f2fs_sb_info=20*sbi,=20block_t=
=20blkaddr)=0D=0A>>=20+bool=20is_end_zone_blkaddr(struct=20f2fs_sb_info=20*=
sbi,=20block_t=20blkaddr)=0D=0A>>=C2=A0=20=7B=0D=0A>>=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20struct=20block_device=20*bdev=20=3D=20sbi->sb->s_bdev;=0D=0A=
>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20int=20devi=20=3D=200;=0D=0A>>=20=40=
=40=20-4207,6=20+4207,7=20=40=40=20static=20int=20f2fs_iomap_begin(struct=
=20inode=20*inode,=20loff_t=20offset,=20loff_t=20length,=0D=0A>>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20iomap=20*srcmap)=0D=0A>>=
=C2=A0=20=7B=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20f2fs_map_b=
locks=20map=20=3D=20=7B=7D;=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20struct=20=
f2fs_sb_info=20*sbi=20=3D=20F2FS_I_SB(inode);=0D=0A>>=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20pgoff_t=20next_pgofs=20=3D=200;=0D=0A>>=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20int=20err;=0D=0A>>=0D=0A>>=20=40=40=20-4218,6=20+4219,18=20=
=40=40=20static=20int=20f2fs_iomap_begin(struct=20inode=20*inode,=20loff_t=
=20offset,=20loff_t=20length,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=
=20(flags=20&=20IOMAP_WRITE)=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20map.m_may_create=20=3D=20true;=0D=0A>>=0D=
=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20if=20(f2fs_sb_has_blkzoned(sbi)=20&&=20=
=21f2fs_is_pinned_file(inode))=20=7B=0D=0A>=0D=0A>I=20think=20it's=20better=
=20that=20we=20can=20skip=20this=20for=20conventional=20LU=20by=0D=0A>exami=
ning=20the=20block=20address.=0D=0A=0D=0AAt=20this=20line,=20the=20examinin=
g=20is=20not=20possible=20because=20the=20block=20address=20has=20not=20bee=
n=20allocated=20yet.=0D=0A=0D=0A>=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20f2fs_rwsem=20*io_order_lock=20=3D=
=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20&sb=
i->io_order_lock=5Bmap.m_seg_type=5D;=0D=0A>>=20+=0D=0A>>=20+=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20f2fs_down_write(io_order=
_lock);=0D=0A>>=20+=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20/*=20set=20io=20order=20lock=20*/=0D=0A>>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20iomap->private=20=3D=
=20io_order_lock;=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=7D=20else=20=7B=0D=
=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20iom=
ap->private=20=3D=20NULL;=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=7D=0D=0A>>=
=20+=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20err=20=3D=20f2fs_map_blocks=
(inode,=20&map,=20F2FS_GET_BLOCK_DIO);=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20if=20(err)=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20return=20err;=0D=0A>>=20=40=40=20-4273,6=20+4286,19=
=20=40=40=20static=20int=20f2fs_iomap_begin(struct=20inode=20*inode,=20loff=
_t=20offset,=20loff_t=20length,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
return=200;=0D=0A>>=C2=A0=20=7D=0D=0A>>=0D=0A>>=20+static=20int=20f2fs_ioma=
p_end(struct=20inode=20*inode,=20loff_t=20pos,=20loff_t=20length,=0D=0A>>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20ssize_t=
=20written,=20unsigned=20int=20flags,=20struct=20iomap=20*iomap)=0D=0A>>=20=
+=7B=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20struct=20f2fs_rwsem=20*io_order_=
lock=20=3D=20iomap->private;=0D=0A>>=20+=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=
=A0=20/*=20ordered=20write=20*/=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20if=20=
(io_order_lock)=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20f2fs_up_write(io_order_lock);=0D=0A>>=20+=0D=0A>>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20return=200;=0D=0A>>=20+=7D=0D=0A>>=20+=0D=0A>>=C2=A0=
=20const=20struct=20iomap_ops=20f2fs_iomap_ops=20=3D=20=7B=0D=0A>>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20.iomap_begin=C2=A0=20=C2=A0=20=3D=20f2fs_iomap_b=
egin,=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20.iomap_end=C2=A0=20=C2=A0=20=C2=
=A0=20=3D=20f2fs_iomap_end,=0D=0A>>=C2=A0=20=7D;=0D=0A>>=20diff=20--git=20a=
/fs/f2fs/f2fs.h=20b/fs/f2fs/f2fs.h=0D=0A>>=20index=2033f5449dc22d..06ed132f=
22ad=20100644=0D=0A>>=20---=20a/fs/f2fs/f2fs.h=0D=0A>>=20+++=20b/fs/f2fs/f2=
fs.h=0D=0A>>=20=40=40=20-1582,8=20+1582,8=20=40=40=20struct=20f2fs_sb_info=
=20=7B=0D=0A>>=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20/*=20for=20bio=20=
operations=20*/=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20f2fs_bi=
o_info=20*write_io=5BNR_PAGE_TYPE=5D;=C2=A0=20/*=20for=20write=20bios=20*/=
=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20/*=20keep=20migration=20IO=20order=
=20for=20LFS=20mode=20*/=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20struct=20f2f=
s_rwsem=20io_order_lock;=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20/*=20keep=20=
IO=20order=20for=20LFS=20mode=20*/=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20st=
ruct=20f2fs_rwsem=20io_order_lock=5BNR_CURSEG_DATA_TYPE=5D;=0D=0A>>=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20pgoff_t=20page_eio_ofs=5BNR_PAGE_TYPE=5D;=C2=
=A0=20=C2=A0=20/*=20EIO=20page=20offset=20*/=0D=0A>>=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20int=20page_eio_cnt=5BNR_PAGE_TYPE=5D;=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20/*=20EIO=20count=20*/=0D=0A>>=0D=0A>>=20=40=40=20-3863,6=20+=
3863,9=20=40=40=20void=20f2fs_submit_merged_ipu_write(struct=20f2fs_sb_info=
=20*sbi,=0D=0A>>=C2=A0=20void=20f2fs_flush_merged_writes(struct=20f2fs_sb_i=
nfo=20*sbi);=0D=0A>>=C2=A0=20int=20f2fs_submit_page_bio(struct=20f2fs_io_in=
fo=20*fio);=0D=0A>>=C2=A0=20int=20f2fs_merge_page_bio(struct=20f2fs_io_info=
=20*fio);=0D=0A>>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>>=20+bool=20is_e=
nd_zone_blkaddr(struct=20f2fs_sb_info=20*sbi,=20block_t=20blkaddr);=0D=0A>>=
=20+=23endif=0D=0A>>=C2=A0=20void=20f2fs_submit_page_write(struct=20f2fs_io=
_info=20*fio);=0D=0A>>=C2=A0=20struct=20block_device=20*f2fs_target_device(=
struct=20f2fs_sb_info=20*sbi,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20block_t=20blk_addr,=20sector_t=20*secto=
r);=0D=0A>>=20diff=20--git=20a/fs/f2fs/file.c=20b/fs/f2fs/file.c=0D=0A>>=20=
index=2099903eafa7fe..fde49f3e54cf=20100644=0D=0A>>=20---=20a/fs/f2fs/file.=
c=0D=0A>>=20+++=20b/fs/f2fs/file.c=0D=0A>>=20=40=40=20-869,13=20+869,7=20=
=40=40=20static=20bool=20f2fs_force_buffered_io(struct=20inode=20*inode,=20=
int=20rw)=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20/*=20disallow=20direct=
=20IO=20if=20any=20of=20devices=20has=20unaligned=20blksize=20*/=0D=0A>>=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(f2fs_is_multi_device(sbi)=20&&=20=21=
sbi->aligned_blksize)=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20return=20true;=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=
=A0=20/*=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20for=20blkzoned=
=20device,=20fallback=20direct=20IO=20to=20buffered=20IO,=20so=0D=0A>>=20-=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20all=20IOs=20can=20be=20serialized=
=20by=20log-structured=20write.=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20*/=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20if=20(f2fs_sb_has_blkzoned(s=
bi)=20&&=20(rw=20=3D=3D=20WRITE)=20&&=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=21f2fs_is_pinned_file(inode))=0D=0A>>=20-=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20true;=0D=0A>>=
=20+=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(is_sbi_flag_set(sbi,=
=20SBI_CP_DISABLED))=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20return=20true;=0D=0A>>=0D=0A>>=20=40=40=20-4815,=
6=20+4809,17=20=40=40=20static=20int=20f2fs_dio_write_end_io(struct=20kiocb=
=20*iocb,=20ssize_t=20size,=20int=20error,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20return=200;=0D=0A>>=C2=A0=20=7D=0D=0A>>=0D=0A>>=20+=23ifdef=20C=
ONFIG_BLK_DEV_ZONED=0D=0A>>=20+static=20void=20f2fs_dio_zone_write_end_io(s=
truct=20bio=20*bio)=0D=0A>>=20+=7B=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20st=
ruct=20f2fs_bio_info=20*io=20=3D=20(struct=20f2fs_bio_info=20*)bio->bi_priv=
ate;=0D=0A>>=20+=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20bio->bi_private=20=
=3D=20io->bi_private;=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20complete(&io->z=
one_wait);=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20iomap_dio_bio_end_io(bio);=
=0D=0A>>=20+=7D=0D=0A>>=20+=23endif=0D=0A>>=20+=0D=0A>>=C2=A0=20static=20vo=
id=20f2fs_dio_write_submit_io(const=20struct=20iomap_iter=20*iter,=0D=0A>>=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20struct=20bio=20*bio,=20loff_t=20file_offset)=
=0D=0A>>=C2=A0=20=7B=0D=0A>>=20=40=40=20-4824,6=20+4829,31=20=40=40=20stati=
c=20void=20f2fs_dio_write_submit_io(const=20struct=20iomap_iter=20*iter,=0D=
=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20enum=20temp_type=20temp=20=3D=20f2=
fs_get_segment_temp(seg_type);=0D=0A>>=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20bio->bi_write_hint=20=3D=20f2fs_io_type_to_rw_hint(sbi,=20DATA,=20=
temp);=0D=0A>>=20+=0D=0A>>=20+=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>>=20+=
=C2=A0=20=C2=A0=20=C2=A0=20if=20(f2fs_sb_has_blkzoned(sbi)=20&&=20=21f2fs_i=
s_pinned_file(inode))=20=7B=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20struct=20f2fs_bio_info=20*io=20=3D=20sbi->write_=
io=5BDATA=5D=20+=20temp;=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20block_t=20last_blkaddr=20=3D=20SECTOR_TO_BLOCK(bio_=
end_sector(bio)=20-=201);=0D=0A>>=20+=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20f2fs_down_write(&io->io_rwsem);=0D=
=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=
=20(io->zone_pending_bio)=20=7B=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20wait_f=
or_completion_io(&io->zone_wait);=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20bio_pu=
t(io->zone_pending_bio);=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20io->zone_pendin=
g_bio=20=3D=20NULL;=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20io->bi_private=20=
=3D=20NULL;=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=7D=0D=0A>>=20+=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20if=20(is_end_zone_blkaddr(sbi,=20last_blkaddr))=
=20=7B=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20bio_get(bio);=0D=0A>>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20reinit_completion(&io->zone_wait);=0D=0A>>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20io->bi_private=20=3D=20bio->bi_private;=0D=0A>>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20bio->bi_private=20=3D=20io;=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20bio->bi_end_io=20=3D=20f2fs_dio_zone_write_end_io;=0D=0A>>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20io->zone_pending_bio=20=3D=20bio;=0D=0A>>=20+=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=7D=0D=0A>>=20+=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20f2fs_up_write(&io->io_rw=
sem);=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=7D=0D=0A>>=20+=23endif=0D=0A>>=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20submit_bio(bio);=0D=0A>>=C2=A0=20=7D=0D=
=0A>>=0D=0A>>=20=40=40=20-4897,6=20+4927,10=20=40=40=20static=20ssize_t=20f=
2fs_dio_write_iter(struct=20kiocb=20*iocb,=20struct=20iov_iter=20*from,=0D=
=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20dio_flags=20=3D=200;=0D=0A>>=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(pos=20+=20count=20>=20inode->i_size)=0D=
=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20dio_flags=20=3D=20IOMAP_DIO_FORCE_WAIT;=0D=0A>>=20+=0D=0A>>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20if=20(f2fs_sb_has_blkzoned(sbi)=20&&=20=21f2fs_is_pinned_=
file(inode))=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20dio_flags=20=3D=20IOMAP_DIO_FORCE_WAIT;=0D=0A>>=20+=0D=0A>>=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20dio=20=3D=20__iomap_dio_rw(iocb,=20from,=
=20&f2fs_iomap_ops,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20&f2fs_iomap_dio_write_ops,=20dio_flags,=20NULL,=200);=0D=0A>>=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(IS_ERR_OR_NULL(dio))=20=7B=0D=0A>=
>=20diff=20--git=20a/fs/f2fs/gc.c=20b/fs/f2fs/gc.c=0D=0A>>=20index=209322a7=
200e31..49270713f739=20100644=0D=0A>>=20---=20a/fs/f2fs/gc.c=0D=0A>>=20+++=
=20b/fs/f2fs/gc.c=0D=0A>>=20=40=40=20-1361,7=20+1361,7=20=40=40=20static=20=
int=20move_data_block(struct=20inode=20*inode,=20block_t=20bidx,=0D=0A>>=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20fio.new_blkaddr=20=3D=20fio.old_blkaddr=20=
=3D=20dn.data_blkaddr;=0D=0A>>=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20i=
f=20(lfs_mode)=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20f2fs_down_write(&fio.sbi->io_order_lock);=0D=0A>>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20f2fs_down_write(&f=
io.sbi->io_order_lock=5BCURSEG_COLD_DATA=5D);=0D=0A>>=0D=0A>>=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20mpage=20=3D=20f2fs_grab_cache_page(META_MAPPING(fio=
.sbi),=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20fio.old_blkaddr,=20false);=0D=
=0A>>=20=40=40=20-1444,7=20+1444,7=20=40=40=20static=20int=20move_data_bloc=
k(struct=20inode=20*inode,=20block_t=20bidx,=0D=0A>>=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20true,=20true,=20true);=0D=0A>>=C2=A0=20up_out:=0D=0A>>=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20if=20(lfs_mode)=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20f2fs_up_write(&fio.sbi->io_order_lock);=
=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
f2fs_up_write(&fio.sbi->io_order_lock=5BCURSEG_COLD_DATA=5D);=0D=0A>>=C2=A0=
=20put_out:=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20f2fs_put_dnode(&dn);=
=0D=0A>>=C2=A0=20out:=0D=0A>>=20diff=20--git=20a/fs/f2fs/segment.c=20b/fs/f=
2fs/segment.c=0D=0A>>=20index=201766254279d2..d602ae4d79e3=20100644=0D=0A>>=
=20---=20a/fs/f2fs/segment.c=0D=0A>>=20+++=20b/fs/f2fs/segment.c=0D=0A>>=20=
=40=40=20-3796,10=20+3796,10=20=40=40=20void=20f2fs_update_device_state(str=
uct=20f2fs_sb_info=20*sbi,=20nid_t=20ino,=0D=0A>>=C2=A0=20static=20void=20d=
o_write_page(struct=20f2fs_summary=20*sum,=20struct=20f2fs_io_info=20*fio)=
=0D=0A>>=C2=A0=20=7B=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20int=20type=
=20=3D=20__get_segment_type(fio);=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20boo=
l=20keep_order=20=3D=20(f2fs_lfs_mode(fio->sbi)=20&&=20type=20=3D=3D=20CURS=
EG_COLD_DATA);=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20bool=20keep_order=20=
=3D=20(f2fs_lfs_mode(fio->sbi)=20&&=20type=20<=3D=20CURSEG_COLD_DATA);=0D=
=0A>=0D=0A>ditto=0D=0A=0D=0AIt=20is=20the=20same=20as=20above.=0D=0A=0D=0AA=
fter=20the=20block=20allocation,=20the=20semaphore=20can=20be=20released=20=
early=20by=20checking=20zone=20type.=0D=0AHowever,=20I'm=20not=20sure=20if=
=20this=20is=20necessary.=0D=0A=0D=0AThanks=20for=20review.=0D=0ADaejun=0D=
=0A=0D=0A>=0D=0A>>=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(keep_or=
der)=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20f2fs_down_read(&fio->sbi->io_order_lock);=0D=0A>>=20+=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20f2fs_down_read(&fio->sbi->i=
o_order_lock=5Btype=5D);=0D=0A>>=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20if=20(f2fs_allocate_data_block(fio->sbi,=20fio->page,=20fio->old_blkaddr=
,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20&fio->new_blkaddr,=20sum,=20type,=
=20fio))=20=7B=0D=0A>>=20=40=40=20-3819,7=20+3819,7=20=40=40=20static=20voi=
d=20do_write_page(struct=20f2fs_summary=20*sum,=20struct=20f2fs_io_info=20*=
fio)=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20f2fs_update_device_state(fi=
o->sbi,=20fio->ino,=20fio->new_blkaddr,=201);=0D=0A>>=C2=A0=20out:=0D=0A>>=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(keep_order)=0D=0A>>=20-=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20f2fs_up_read(&fio->sb=
i->io_order_lock);=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20f2fs_up_read(&fio->sbi->io_order_lock=5Btype=5D);=0D=0A>>=
=C2=A0=20=7D=0D=0A>>=0D=0A>>=C2=A0=20void=20f2fs_do_write_meta_page(struct=
=20f2fs_sb_info=20*sbi,=20struct=20folio=20*folio,=0D=0A>>=20diff=20--git=
=20a/fs/f2fs/super.c=20b/fs/f2fs/super.c=0D=0A>>=20index=20fc2c586c7619..52=
89b6f5f6f3=20100644=0D=0A>>=20---=20a/fs/f2fs/super.c=0D=0A>>=20+++=20b/fs/=
f2fs/super.c=0D=0A>>=20=40=40=20-3833,7=20+3833,10=20=40=40=20static=20void=
=20init_sb_info(struct=20f2fs_sb_info=20*sbi)=0D=0A>>=0D=0A>>=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20INIT_LIST_HEAD(&sbi->s_list);=0D=0A>>=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20mutex_init(&sbi->umount_mutex);=0D=0A>>=20-=C2=A0=
=20=C2=A0=20=C2=A0=20init_f2fs_rwsem(&sbi->io_order_lock);=0D=0A>>=20+=0D=
=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20for=20(i=20=3D=200;=20i=20<=20NR_CURSEG=
_DATA_TYPE;=20i++)=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20init_f2fs_rwsem(&sbi->io_order_lock=5Bi=5D);=0D=0A>>=20+=
=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20spin_lock_init(&sbi->cp_lock);=
=0D=0A>>=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20sbi->dirty_device=20=3D=
=200;=0D=0A>>=20--=0D=0A>>=202.25.1=0D=0A>>=0D=0A>>=0D=0A>>=0D=0A>>=20_____=
__________________________________________=0D=0A>>=20Linux-f2fs-devel=20mai=
ling=20list=0D=0A>>=20Linux-f2fs-devel=40lists.sourceforge.net=0D=0A>>=20ht=
tps://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

