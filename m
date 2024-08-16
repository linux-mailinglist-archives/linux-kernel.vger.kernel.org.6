Return-Path: <linux-kernel+bounces-288763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B9953E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DBB2826DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B990168D0;
	Fri, 16 Aug 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fdsqe35z"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106BBA27
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767488; cv=none; b=D4CCSvSsG1E6k2N1L90GxKQL0gyAWfMfE4+tFOSfbmbkSMISM8b7X5vliIK/SKgpuuoB3FXKbYDTduzA7ix4t4YXJzZ5StVpWr6GM9zf45sIvVw3LBvwJYx9nhZsOcZXMfep/uoitpyJqa5tLURA+XHcc8HPsCNxwsFkRKo9Nm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767488; c=relaxed/simple;
	bh=oZq7+8Jey8nXoq/5fEm7s6H29csgMZEGH1l/2dFmk+k=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=d/s8yACaA4SG2kjQmfbEbO7K6a9t9ahTI3/NrbFcDfjm6ytug/SLd69H8ptKyPUxDZJoCcmaI8BQ6bEwWjuLlLLnmOridbdoNxVYx2vRucD6QCJ7347WH0JUBrtalWUAgCgcSurYW7VomJZ8OJEwQFj6cXrddv6t3DnbIQo2/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fdsqe35z; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240816001803epoutp0257f16111cf14ef49ce33eb7ddf378e7e~sDWSdZrc61530515305epoutp02Q
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240816001803epoutp0257f16111cf14ef49ce33eb7ddf378e7e~sDWSdZrc61530515305epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723767483;
	bh=oZq7+8Jey8nXoq/5fEm7s6H29csgMZEGH1l/2dFmk+k=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=fdsqe35zK1E6gAP1FTSLGlJEys8hQyFpAznqUQc5X+G2N/bVianA/ohgo60hI57wM
	 WRLSIIKKzL7e7Ml3uto8AV1mYf6EYOfAq1w3SpOFe/xI5L2LyWYUnvaRHDJ28hG668
	 JYBMD2ItivP+AJc5X3h9I413eMOLi9sYT7sdqrkE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240816001802epcas2p2e105e0671748fd6df00ed28d8277046d~sDWRZCAnc2715127151epcas2p2L;
	Fri, 16 Aug 2024 00:18:02 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.91]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WlMyd2vPwz4x9QG; Fri, 16 Aug
	2024 00:18:01 +0000 (GMT)
X-AuditID: b6c32a43-a0fff700000022c5-80-66be9ab88a71
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A2.21.08901.8BA9EB66; Fri, 16 Aug 2024 09:18:01 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [PATCH] f2fs: avoid unused block when dio write in LFS mode
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Seokhwan Kim <sukka.kim@samsung.com>, Dongjin Kim
	<dongjin_.kim@samsung.com>, Yonggil Song <yonggil.song@samsung.com>, Jaeyoon
	Choi <j_yoon.choi@samsung.com>, Jeuk Kim <jeuk20.kim@samsung.com>, Nayeon
	Kim <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>, Daejun
	Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <7860b050-3948-4e23-b40f-a3df522477cd@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240816001700epcms2p37f406e9cd3a1d6438a866e7a7a3d5c31@epcms2p3>
Date: Fri, 16 Aug 2024 09:17:00 +0900
X-CMS-MailID: 20240816001700epcms2p37f406e9cd3a1d6438a866e7a7a3d5c31
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmme7OWfvSDGYsZbY4PfUsk8XLQ5oW
	qx6EW/w4aWLRv7udxeLJ+lnMFve3XmO0uLTI3eLyrjlsFi1/nCzOT3zNZLGqYy6jxdTzR5gc
	eD02repk89i94DOTR9+WVYwenzfJBbBEZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
	WlqYKynkJeam2iq5+AToumXmAJ2mpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkw
	L9ArTswtLs1L18tLLbEyNDAwMgUqTMjO6L91hqXgnlrFzFPNLA2Mt1S7GDk5JARMJN49amDp
	YuTiEBLYwShxcOVJxi5GDg5eAUGJvzuEQWqEBbwlzr/uYgGxhQSUJNZfnMUOEdeTuPVwDSOI
	zSagIzH9xH12kDkiAg8YJabc2MsGkmAW2Msk0bS8DGIZr8SM9qcsELa0xPblW8GaOQXsJK6+
	eMUMEdeQ+LGsF8oWlbi5+i07jP3+2HxGCFtEovXeWagaQYkHP3dDxSUlbs/dBFWfL/H/ynIo
	u0Zi24F5ULa+xLWOjWA38Ar4Sqzuuwc2h0VAVaJtxw82iBoXie5pq1kh7teWWLbwNTMoTJgF
	NCXW79IHMSUElCWO3GKBqOCT6Dj8lx3mw4aNv7Gyd8x7wgRhq0ms+7meaQKj8ixEQM9CsmsW
	wq4FjMyrGMVSC4pz01OTjQoM4XGbnJ+7iRGcSLWcdzBemf9P7xAjEwfjIUYJDmYlEd6nX/am
	CfGmJFZWpRblxxeV5qQWH2I0BfpyIrOUaHI+MJXnlcQbmlgamJiZGZobmRqYK4nz3mudmyIk
	kJ5YkpqdmlqQWgTTx8TBKdXAVLwmYf6Gun3OjKIJHHV1E6fqf3ojby6dnj/71ITvOVePLAvb
	Wn+BvyJ/WZlO5c+bbld6unT1tz1iVtt3yTf+qFTqA2/P/H1rbkRf8TL/P1fcZ76tdPn8ORtZ
	mY+Uf2zrL/VJ/VK4IGiBubP0JqdZZzpuKV75eEUjUdj7aHjO22vs558YXWux+fD/yTLRVY1p
	2WdXmG1esPVOc9JjvdXL9H+cizgVfvfCHd+Jx7QPFiybcjuazzBqXYfLYyZPQUWNtcH9X99J
	pLnqfNj54okH7zOzCUc8L9kfELVYmvNUdEHDK1U3KWmDRT4XL3N/nsXw7Uj3ckvPU0vDgrpW
	t8mHrV4z52Ynp+HUWCX+vN7sMCWW4oxEQy3mouJEAPGhE5stBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b
References: <7860b050-3948-4e23-b40f-a3df522477cd@kernel.org>
	<20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p7>
	<CGME20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p3>

Hi Chao Yu,
>=C2=A0=0D=0A>---------=20Original=20Message=20---------=0D=0A>Sender=20:=
=20Chao=20Yu=20<chao=40kernel.org>=0D=0A>Date=20:=202024-08-14=2018:50=20(G=
MT+9)=0D=0A>Title=20:=20Re:=20=5BPATCH=5D=20f2fs:=20avoid=20unused=20block=
=20when=20dio=20write=20in=20LFS=20mode=0D=0A>=C2=A0=0D=0A>On=202024/8/1=20=
15:47,=20Daejun=20Park=20wrote:=0D=0A>>=20This=20patch=20addresses=20the=20=
problem=20that=20when=20using=20LFS=20mode,=20unused=20blocks=0D=0A>>=20may=
=20occur=20in=20f2fs_map_blocks()=20during=20block=20allocation=20for=20dio=
=20writes.=0D=0A>>=0D=0A>>=20If=20a=20new=20section=20is=20allocated=20duri=
ng=20block=20allocation,=20it=20will=20not=20be=0D=0A>>=20included=20in=20t=
he=20map=20struct=20by=20map_is_mergeable()=20if=20the=20LBA=20of=20the=0D=
=0A>=0D=0A>I=20didn't=20get=20it,=20why=20below=20condition=20in=20map_is_m=
ergeable()=20can=20not=20catch=20this=0D=0A>case?=20Can=20you=20please=20ex=
plain=20more?=0D=0A>=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(map->m_pb=
lk=20=21=3D=20NEW_ADDR=20&&=20blkaddr=20=3D=3D=20(map->m_pblk=20+=20ofs))=
=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0return=20true;=0D=0A>=0D=0A=0D=0AThank=20you=20for=20your=20review.=0D=
=0Amap_is_mergeable()=20returns=20true=20when=20the=20last=20block=20in=20t=
he=20section=20is=20merged.=0D=0AThe=20problem=20is=20the=20next=20block=20=
allocation,=20which=20happens=20consecutively.=0D=0ASince=20it=20will=20be=
=20allocated=20a=20new=20section,=20its=20block=20will=20be=20the=20first=
=20=0D=0Ablock=20in=20the=20section.=0D=0AIf=20the=20newly=20allocated=20se=
ction=20is=20not=20contiguous=20with=20the=20previous=20section,=0D=0Amap_i=
s_mergeable()=20will=20return=20false.=0D=0ASo=20the=20block=20is=20allocat=
ed=20but=20unused.=0D=0AHowever,=20it=20is=20not=20freed,=20so=20the=20bloc=
k=20is=20unusable.=0D=0AIf=20my=20explanation=20was=20not=20clear=20enough,=
=20please=20feel=20free=20to=20ask=20questions.=0D=0A=0D=0AThanks=0D=0ADaej=
un=0D=0A=0D=0A>Thanks,=0D=0A>=0D=0A>>=20allocated=20block=20is=20not=20cont=
iguous.=20However,=20the=20block=20already=20allocated=0D=0A>>=20in=20this=
=20process=20will=20remain=20unused=20due=20to=20the=20LFS=20mode.=0D=0A>>=
=0D=0A>>=20This=20patch=20avoids=20the=20possibility=20of=20unused=20blocks=
=20by=20escaping=0D=0A>>=20f2fs_map_blocks()=20when=20allocating=20the=20la=
st=20block=20in=20a=20section.=0D=0A>>=0D=0A>>=20Signed-off-by:=20Daejun=20=
Park=20<daejun7.park=40samsung.com>=0D=0A>>=20---=0D=0A>>=C2=A0=20fs/f2fs/d=
ata.c=2013=20+++++++++++++=0D=0A>>=C2=A0=201=20file=20changed,=2013=20inser=
tions(+)=0D=0A>>=0D=0A>>=20diff=20--git=20a/fs/f2fs/data.c=20b/fs/f2fs/data=
.c=0D=0A>>=20index=20b6dcb3bcaef7..b27a3f448f32=20100644=0D=0A>>=20---=20a/=
fs/f2fs/data.c=0D=0A>>=20+++=20b/fs/f2fs/data.c=0D=0A>>=20=40=40=20-1711,6=
=20+1711,19=20=40=40=20int=20f2fs_map_blocks(struct=20inode=20*inode,=20str=
uct=20f2fs_map_blocks=20*map,=20int=20flag)=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dn.ofs_in_no=
de=20=3D=20end_offset;=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=7D=0D=0A>>=C2=A0=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=
=20(flag=20=3D=3D=20F2FS_GET_BLOCK_DIO=20&&=20f2fs_lfs_mode(sbi))=20=7B=0D=
=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0int=20segno=20=3D=20GET_SEGNO(sbi,=20blkaddr);=0D=0A>>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0bool=20last_=
seg,=20last_blk;=0D=0A>>=20+=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0last_seg=20=3D=20=21((segno=20+=201)=
=20%=20SEGS_PER_SEC(sbi));=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0last_blk=20=3D=20(f2fs_usable_blks_in_s=
eg(sbi,=20segno)=20-=201)=20=3D=3D=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0GET_BLKOFF_FROM_SEG0(sbi,=20blkad=
dr);=0D=0A>>=20+=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0/*=20LBA=20of=20the=20next=20block=20to=20be=20a=
llocated=20may=20not=20be=20contiguous.=20*/=0D=0A>>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(last_seg=20&&=
=20last_blk)=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0goto=20sync_out;=
=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>>=20+=0D=0A>>=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(pgofs=20>=3D=20end)=
=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0goto=20sync_out;=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0else=20if=20(dn.ofs_in_node=20<=20end_offset)

