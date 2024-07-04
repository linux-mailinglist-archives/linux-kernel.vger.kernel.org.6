Return-Path: <linux-kernel+bounces-240687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D3927101
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63872B225E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB731A38E4;
	Thu,  4 Jul 2024 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hUZo2lFO"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E419DF4A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079790; cv=none; b=jRLxKqf6Eo6VhWTL3HHGR/OYJu6CuT99kq73MWEXSW0bsv+LHwDj9JB1A8Z3KFkcTBlBfN/qcPbOXCfCO+n9u8kbYhpqm2j/IE+QSZdR37x2alHWBM9GxM0kkKTfBlP1sPeY6DzSfdr5Mox8LsxcWvq6dgjmJMr7m7XZmNGXaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079790; c=relaxed/simple;
	bh=nJsXcRh8QdAcnpMVPzgSJc5Ql2XpNsjVAnlyj6Jj21k=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=bYb16TN9JPE84Bf/fgXIyfyyNJsDrD1Ovjfq1LFLsVfeBzHwpX0rjb/G1v+u5VEE+e/n51VWuULBgPnnFzRtYqD5S+fg61+TwwMjc5zEBIZmQqf2t7a/wUDXc5vBJMmU92VghZzWnPEqN27V1o2NEt/6tYil927GMhErFFxsuss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hUZo2lFO; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240704075623epoutp03f2a90459912633e6bbbcda702d9270cb~e83MWd2Q41204912049epoutp03o
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:56:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240704075623epoutp03f2a90459912633e6bbbcda702d9270cb~e83MWd2Q41204912049epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720079783;
	bh=nJsXcRh8QdAcnpMVPzgSJc5Ql2XpNsjVAnlyj6Jj21k=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=hUZo2lFO9JAVBbmKdTLqah9esllONPctYb0vygtxRSltCrxU436cg2pvLEsu9hWfr
	 uO6gRfZCVjjVH+9b125cD+h8W2J22sfJXeY2cq9m71M3ZFHPE0EavW2TIB667n37Xe
	 OwCEICWBRKLdLR/stWFHH3dxhreIAtHhd949UBxE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240704075622epcas2p3878696583b1c0cb0147035b39ab9565e~e83MAG6Bt1605416054epcas2p3X;
	Thu,  4 Jul 2024 07:56:22 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WF89L41yWz4x9Q4; Thu,  4 Jul
	2024 07:56:22 +0000 (GMT)
X-AuditID: b6c32a46-f3bff7000000250d-e2-668655a60689
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	A5.A5.09485.6A556866; Thu,  4 Jul 2024 16:56:22 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [PATCH] f2fs: fix null reference error when checking end of
 zone
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"daehojeong@google.com" <daehojeong@google.com>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Seokhwan Kim <sukka.kim@samsung.com>, Dongjin Kim
	<dongjin_.kim@samsung.com>, Yonggil Song <yonggil.song@samsung.com>, Jaeyoon
	Choi <j_yoon.choi@samsung.com>, Nayeon Kim <nayeoni.kim@samsung.com>, Siwoo
	Jung <siu.jung@samsung.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <460c4708-3ec6-4fbc-8f6c-7f8e5f901061@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240704075521epcms2p49cc9985b6624e4e1129907e883fbc1d9@epcms2p4>
Date: Thu, 04 Jul 2024 16:55:21 +0900
X-CMS-MailID: 20240704075521epcms2p49cc9985b6624e4e1129907e883fbc1d9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmme6y0LY0g4XPOCxOTz3LZPHykKbF
	1Pa9jBarHoRb/DhpYtG/u53F4sn6WcwWlxa5W1zeNYfNouWPk8X5ia+ZLFZ1zGW0mHr+CJMD
	r8eCTaUem1Z1snnsXvCZyaNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403N
	DAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUW
	pOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ5xct4W9YK5URfvGScwNjEcluxg5OSQETCR2
	/l7C3MXIxSEksINR4uD+j+xdjBwcvAKCEn93CIPUCAsESdw++ZgJxBYSUJJYf3EWO0RcT+LW
	wzWMIDabgI7E9BP3weIiApOZJPbdzwaZySwwg0li3uleNohlvBIz2p+yQNjSEtuXbwVr5hSw
	kzjw+jUTRFxD4seyXmYIW1Ti5uq37DD2+2PzGSFsEYnWe2ehagQlHvzcDRWXlLg9dxNUfb7E
	/yvLoewaiW0H5kHZ+hLXOjaC3cAr4Csxp7sP7DYWAVWJc4fnQc1xkWjfcxHsHmYBbYllC18z
	g8KEWUBTYv0ufRBTQkBZ4sgtFogKPomOw3/ZYT5s2PgbK3vHvCdQH6pJrPu5nmkCo/IsREDP
	QrJrFsKuBYzMqxjFUguKc9NTi40KjOBxm5yfu4kRnFC13HYwTnn7Qe8QIxMH4yFGCQ5mJRFe
	qffNaUK8KYmVValF+fFFpTmpxYcYTYG+nMgsJZqcD0zpeSXxhiaWBiZmZobmRqYG5krivPda
	56YICaQnlqRmp6YWpBbB9DFxcEo1MKkk/9aJXRJufO5QuvNJHRbGdRfWOjL9Lzfn97l4KVtw
	g2PUua+Hj9j58pnZXti6/hnLybDj+n92m3Fl2v1i33whNPPC4rf7GZ7xtbX5HD+X1G4rdJnx
	S0zpW8OZgoy+78ytb+cbPGrcb5wdPblcB5gT8vlu/uWpXCbI8/12itWV6qXvVjhd8UnIm7us
	cnJ0XFae8XGT+xNEFszaXchZ6boqcULL04kbC0V87zWf0byouvT5tCcuv5funNUQPmu/zLcb
	D2vtCucW1Ok0CnxYvauxlmVC1OOrphNMl/7yEjuuccxvR73jEXbHu3t9fI4Fc0pFTNbhXPzJ
	ba77ln1bm5nqziWtFPP/v37p5YYZMkosxRmJhlrMRcWJAJrXiIYxBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90
References: <460c4708-3ec6-4fbc-8f6c-7f8e5f901061@kernel.org>
	<20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
	<CGME20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>

Hi=C2=A0Chao=20Yu,=0D=0A>=C2=A0=0D=0A>---------=20Original=20Message=20----=
-----=0D=0A>Sender=20:=20Chao=20Yu=20<chao=40kernel.org>=0D=0A>Date=20:=202=
024-07-04=2016:16=20(GMT+9)=0D=0A>Title=20:=20Re:=20=5BPATCH=5D=20f2fs:=20f=
ix=20null=20reference=20error=20when=20checking=20end=20of=20zone=0D=0A>=C2=
=A0=0D=0A>On=202024/7/4=209:01,=20Daejun=20Park=20wrote:=0D=0A>>=20This=20p=
atch=20fixes=20a=20potentially=20null=20pointer=20being=20accessed=20by=0D=
=0A>>=20is_end_zone_blkaddr()=20that=20checks=20the=20last=20block=20of=20a=
=20zone=0D=0A>>=20when=20f2fs=20is=20mounted=20as=20a=20single=20device.=0D=
=0A>=0D=0A>blkzoned=20feature=20depends=20on=20multiple=20device=20feature?=
=20One=20regular=0D=0A>device=20and=20one=20seq-zone=20device?=0D=0A=0D=0AA=
ccording=20to=20mkfs.f2fs,=20if=20there=20are=20a=20sufficient=20number=20o=
f=0D=0Aconventional=20zones,=20a=20single=20zoned=20device=20can=20be=20use=
d.=0D=0A=0D=0AThanks,=0D=0ADaejun=0D=0A=0D=0A>=0D=0A>Thanks,=0D=0A>=0D=0A>>=
=0D=0A>>=20Fixes:=20e067dc3c6b9c=20(=22f2fs:=20maintain=20six=20open=20zone=
s=20for=20zoned=20devices=22)=0D=0A>>=20Signed-off-by:=20Daejun=20Park=20<d=
aejun7.park=40samsung.com>=0D=0A>>=20---=0D=0A>>=C2=A0=20fs/f2fs/data.c=204=
=20+++-=0D=0A>>=C2=A0=201=20file=20changed,=203=20insertions(+),=201=20dele=
tion(-)=0D=0A>>=0D=0A>>=20diff=20--git=20a/fs/f2fs/data.c=20b/fs/f2fs/data.=
c=0D=0A>>=20index=20b6dcb3bcaef7..1aa7eefa659c=20100644=0D=0A>>=20---=20a/f=
s/f2fs/data.c=0D=0A>>=20+++=20b/fs/f2fs/data.c=0D=0A>>=20=40=40=20-925,6=20=
+925,7=20=40=40=20int=20f2fs_merge_page_bio(struct=20f2fs_io_info=20*fio)=
=0D=0A>>=C2=A0=20=23ifdef=20CONFIG_BLK_DEV_ZONED=0D=0A>>=C2=A0=20static=20b=
ool=20is_end_zone_blkaddr(struct=20f2fs_sb_info=20*sbi,=20block_t=20blkaddr=
)=0D=0A>>=C2=A0=20=7B=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=
=20block_device=20*bdev=20=3D=20sbi->sb->s_bdev;=0D=0A>>=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0int=20devi=20=3D=200;=0D=0A>>=C2=A0=0D=0A>=
>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(f2fs_is_multi_dev=
ice(sbi))=20=7B=0D=0A>>=20=40=40=20-935,8=20+936,9=20=40=40=20static=20bool=
=20is_end_zone_blkaddr(struct=20f2fs_sb_info=20*sbi,=20block_t=20blkaddr)=
=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20false;=0D=
=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=7D=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0blkaddr=20-=3D=20FDEV(devi).start=
_blk;=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0bdev=20=3D=20FDEV(devi).bdev;=0D=0A>>=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0return=20bdev_is_zoned(FDEV(devi).bdev)=20&&=0D=0A>>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0return=20bdev_is_zoned(bdev)=20&&=0D=0A>>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0f2fs_blkz_is_seq(sbi,=20devi,=20blkaddr)=20&&=0D=0A>>=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0(blkad=
dr=20%=20sbi->blocks_per_blkz=20=3D=3D=20sbi->blocks_per_blkz=20-=201);=0D=
=0A>>=C2=A0=20=7D

