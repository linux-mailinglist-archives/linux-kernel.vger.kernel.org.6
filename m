Return-Path: <linux-kernel+bounces-222198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C169790FE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD24B24EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A96C56B79;
	Thu, 20 Jun 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XZOCJOrU"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BB5D8F0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870266; cv=none; b=MJKzFnhVaDw3tAmpYcKU6zAhKunM8rtJxKBnkqXpo8Y4Ji+PMGTSMa5G2q7AirSICKv2l/tGMfefCy+oqX+/hrzih+APGLMTr9aM7EWpQhlZGG8GSUsNOdNw8rG0ewEydVmHVjUCdl5GnReJb2tvXLnfK4l+3ABY66QR76P/wmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870266; c=relaxed/simple;
	bh=VsPlIU7z0WQN6dg2eoLZqUdIRcUYZOwLQUQxBDukr0Y=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=oaRkSQTtIAAft8+8P7Db6IRfX+AR3cUVt7KgXVkQEVOPk4bzjqQqv8getX4q9ZP+6hkSKueIS8gAxEqckr1BQJntBEuX9qhcMj1VAtdeIFOQSHIzxjCbUe32kxIMvTLBYDadnAXVjnYyEwurwgN8g2bR1xwLKYDjWphxZ9TvvtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XZOCJOrU; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240620075736epoutp017c7a32cf734a388bbdf228f5a0aece46~ap2Qgv8390772907729epoutp01O
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:57:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240620075736epoutp017c7a32cf734a388bbdf228f5a0aece46~ap2Qgv8390772907729epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718870256;
	bh=VsPlIU7z0WQN6dg2eoLZqUdIRcUYZOwLQUQxBDukr0Y=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=XZOCJOrUJU4oTwe98SqmcCOZMT2orLjDD2CRD48hcryKbu4UZ7ekbnuyz8pPcGbQJ
	 vUesmcNgN5QenwKuQIztxKaj3LilOclXiyTXFK4jpNWsTnqGx9hCnEFseE0eKMu+/c
	 iPmQh9iKI6c8nDmtuGBB+9KNCAhmlFzZw1+GuiyA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240620075735epcas2p42abbc68a264c94163020bcc386ccd3e5~ap2QJLKgP1106411064epcas2p4J;
	Thu, 20 Jun 2024 07:57:35 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.92]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4W4XsC223zz4x9QL; Thu, 20 Jun
	2024 07:57:35 +0000 (GMT)
X-AuditID: b6c32a4d-001ff700000262f0-7d-6673e0eff6ad
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.C5.25328.FE0E3766; Thu, 20 Jun 2024 16:57:35 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) (2) (2) [f2fs-dev] [PATCH] Revert
 "f2fs: use flush command instead of FUA for zoned device"
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	Wenjie Cheng <cwjhust@gmail.com>
CC: "qwjhust@gmail.com" <qwjhust@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, Daejun Park
	<daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <e0d89f10-19b0-45db-948d-4c140c2dffa7@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240620075634epcms2p35d3bafffb5f60902b1df25bf3269a686@epcms2p3>
Date: Thu, 20 Jun 2024 16:56:34 +0900
X-CMS-MailID: 20240620075634epcms2p35d3bafffb5f60902b1df25bf3269a686
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTXPf9g+I0g3sHOS1OTz3LZPHykKZF
	z6Y1LBarHoRbPFk/i9ni0iJ3i8u75rBZXFt+l9GBw2PnrLvsHptWdbJ57F7wmcmjb8sqRo/P
	m+QCWKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
	DlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZ
	AhUmZGdcmJ5b0KVTsfp7J2sD43XNLkZODgkBE4kVv1YwdTFycQgJ7GGUONc0ibmLkYODV0BQ
	4u8OYZAaYYFcieOfrrOB2EICShLrL85ih4jrSdx6uIYRxGYT0JGYfuI+WFxEIEfiffsRdpCZ
	zAKvGSXutm9mgVjGKzGj/SmULS2xfflWsGZOATuJJ8sXMUHENSR+LOtlhrBFJW6ufssOY78/
	Np8RwhaRaL13FqpGUOLBz91QcUmJ23M3QdXnS/y/shzKrpHYdmAelK0vca1jI9gNvAK+Else
	3wSzWQRUJZ7tPgZV4yJxZskeVhCbWUBbYtnC1+AwYRbQlFi/Sx/ElBBQljhyiwWigk+i4/Bf
	dpgPGzb+xsreMe8J1IdqEut+rmeawKg8CxHQs5DsmoWwawEj8ypGqdSC4tz01GSjAkPdvNRy
	ePQm5+duYgSnSi3fHYyv1//VO8TIxMF4iFGCg1lJhPd5V1GaEG9KYmVValF+fFFpTmrxIUZT
	oE8nMkuJJucDk3VeSbyhiaWBiZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1M
	5QFvmQ8L7foxzXat9T+LfYU2/PISjkXr5baq/dK5rWrzJ1jzyc7L2gYX1f7dWLUqv7E/zqt9
	c7vwyjshgZXPJeZY6B06sF7nic70qjdvrtjYJT8NMZGvbbwQ9Usx45K2JQP7+xQ37pM+m0xr
	d93xVZxuoNDfMud4BWPqtkUWN3y7trHULZz0+hiHcFvGhPvfi/Km/uztW3/SqdjVyVKb9/Lu
	L1qX102c+PWG5J7yFwzBd3bxJQlyfntYt4vHOTlpWb2uTvOhOvU/OX1xn7zaerW2uPv0NLC0
	cV1uauqrWHHoh7vvJ3/hCaZOCa9CFuqX7On1nNafa/Nz7ZOyuZynFY7eYxO8WCJxPOf1s2dK
	LMUZiYZazEXFiQA3y0vvHgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240620032223epcas2p4d6b770a8e256d140e5296df8a386418e
References: <e0d89f10-19b0-45db-948d-4c140c2dffa7@kernel.org>
	<e2371e59-7be5-40dc-9a2a-aef90ac93b18@kernel.org>
	<2842767c-db80-407b-a5e5-2b9fa74b0d79@kernel.org>
	<20240614004841.103114-1-cwjhust@gmail.com>
	<20240620055648epcms2p11b9914d40f560fb02fa241a7d2599298@epcms2p1>
	<20240620072218epcms2p11597e482b28804dd5f66b9d42a21b22f@epcms2p1>
	<CGME20240620032223epcas2p4d6b770a8e256d140e5296df8a386418e@epcms2p3>

>On 2024/6/20 15:22, Daejun Park wrote:
>>> On 2024/6/20 13:56, Daejun Park wrote:
>>>> Hi Chao,
>>>>
>>>>> Jaegeuk,
>>>>>
>>>>> Quoted commit message from commit c550e25bca66 (=22f2fs: use flush co=
mmand
>>>>> instead of FUA for zoned device=22)
>>>>> =22
>>>>> The block layer for zoned disk can reorder the FUA'ed IOs. Let's use =
flush
>>>>> command to keep the write order.
>>>>> =22
>>>>>
>>>>> It seems mq-deadline use fifo queue and make queue depth of zone devi=
ce
>>>>> as 1 to IO order, so why FUA'ed write node IOs can be reordered by bl=
ock
>>>>> layer?
>>>>
>>>> While other writes are aligned by the mq-deadline, write with FUA is n=
ot passed
>>>> to the scheduler but handled at the block layer.
>>>
>>> Hi Daejun,
>>>
>>> IIUC, do you mean write w/ FUA may be handled directly in below path?
>>>
>>> - blk_mq_submit_bio
>>>=C2=A0=20=C2=A0=20-=20op_is_flush=20&&=20blk_insert_flush=0D=0A>>=0D=0A>=
>=20Hi=20Chao,=0D=0A>>=0D=0A>>=20Yes,=20I=20think=20the=20path=20caused=20a=
n=20unaligned=20write=20when=20the=20zone=20lock=20was=0D=0A>>=20being=20ap=
plied=20by=20mq-deadline.=0D=0A>=0D=0A>But,=20blk_insert_flush()=20may=20re=
turn=20false=20due=20to=20policy=20should=20be=0D=0A>REQ_FSEQ_DATA=20or=20R=
EQ_FSEQ_DATA=20REQ_FSEQ_POSTFLUSH,=20then=0D=0A>blk_mq_insert_request()=20a=
fter=20blk_insert_flush()=20will=20be=20called?=0D=0A>=0D=0A=0D=0AI=20was=
=20just=20discussing=20the=20handling=20of=20FUAs=20in=20commit=20c550e25bc=
a66,=0D=0Awhich=20is=20not=20an=20issue=20in=20the=20current=20code=20as=20=
FUAs=20are=20handled=20correctly.=0D=0A=0D=0AThanks,=0D=0A=0D=0A=0D=0A>Than=
ks,=0D=0A>=0D=0A>>=0D=0A>>>=0D=0A>>>=20Thanks,=0D=0A>>>=0D=0A>>>>=0D=0A>>>>=
=20Thanks,=0D=0A>>>>=20Daejun=0D=0A>>>>=0D=0A>>>>>=0D=0A>>>>>=20Thanks,=0D=
=0A>>>>>=0D=0A>>>>>=20On=202024/6/14=208:48,=20Wenjie=20Cheng=20wrote:=0D=
=0A>>>>>>=20This=20reverts=20commit=20c550e25bca660ed2554cbb48d32b82d0bb98e=
4b1.=0D=0A>>>>>>=0D=0A>>>>>>=20Commit=20c550e25bca660ed2554cbb48d32b82d0bb9=
8e4b1=20(=22f2fs:=20use=20flush=0D=0A>>>>>>=20command=20instead=20of=20FUA=
=20for=20zoned=20device=22)=20used=20additional=20flush=0D=0A>>>>>>=20comma=
nd=20to=20keep=20write=20order.=0D=0A>>>>>>=0D=0A>>>>>>=20Since=20Commit=20=
dd291d77cc90eb6a86e9860ba8e6e38eebd57d12=20(=22block:=0D=0A>>>>>>=20Introdu=
ce=20zone=20write=20plugging=22)=20has=20enabled=20the=20block=20layer=20to=
=0D=0A>>>>>>=20handle=20this=20order=20issue,=20there=20is=20no=20need=20to=
=20use=20flush=20command.=0D=0A>>>>>>=0D=0A>>>>>>=20Signed-off-by:=20Wenjie=
=20Cheng=20<cwjhust=40gmail.com>=0D=0A>>>>>>=20---=0D=0A>>>>>>=C2=A0=20=C2=
=A0=20=C2=A0=20fs/f2fs/file.c=203=20+--=0D=0A>>>>>>=C2=A0=20=C2=A0=20=C2=A0=
=20fs/f2fs/node.c=202=20+-=0D=0A>>>>>>=C2=A0=20=C2=A0=20=C2=A0=202=20files=
=20changed,=202=20insertions(+),=203=20deletions(-)=0D=0A>>>>>>=0D=0A>>>>>>=
=20diff=20--git=20a/fs/f2fs/file.c=20b/fs/f2fs/file.c=0D=0A>>>>>>=20index=
=20eae2e7908072..f08e6208e183=20100644=0D=0A>>>>>>=20---=20a/fs/f2fs/file.c=
=0D=0A>>>>>>=20+++=20b/fs/f2fs/file.c=0D=0A>>>>>>=20=40=40=20-372,8=20+372,=
7=20=40=40=20static=20int=20f2fs_do_sync_file(struct=20file=20*file,=20loff=
_t=20start,=20loff_t=20end,=0D=0A>>>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0f2fs_remove_ino_entry(sbi,=20ino,=20APPEND=
_INO);=0D=0A>>>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0clear_inode_flag(inode,=20FI_APPEND_WRITE);=0D=0A>>>>>>=C2=A0=
=20=C2=A0=20=C2=A0=20flush_out:=0D=0A>>>>>>=20-=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0if=20((=21atomic=20&&=20F2FS_OPTION(sbi).fsync_mode=20=21=3D=20FSY=
NC_MODE_NOBARRIER)=0D=0A>>>>>>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=
=A0=20=C2=A0=20(atomic=20&&=20=21test_opt(sbi,=20NOBARRIER)=20&&=20f2fs_sb_=
has_blkzoned(sbi)))=0D=0A>>>>>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=
=20(=21atomic=20&&=20F2FS_OPTION(sbi).fsync_mode=20=21=3D=20FSYNC_MODE_NOBA=
RRIER)=0D=0A>>>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ret=20=3D=20f2fs_issue_flus=
h(sbi,=20inode->i_ino);=0D=0A>>>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21ret)=20=7B=0D=0A>>>>>>=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0f2fs_remove_ino_entry(sbi,=20ino,=20UPDATE_INO);=0D=0A>>>=
>>>=20diff=20--git=20a/fs/f2fs/node.c=20b/fs/f2fs/node.c=0D=0A>>>>>>=20inde=
x=20144f9f966690..c45d341dcf6e=20100644=0D=0A>>>>>>=20---=20a/fs/f2fs/node.=
c=0D=0A>>>>>>=20+++=20b/fs/f2fs/node.c=0D=0A>>>>>>=20=40=40=20-1631,7=20+16=
31,7=20=40=40=20static=20int=20__write_node_page(struct=20page=20*page,=20b=
ool=20atomic,=20bool=20*submitted,=0D=0A>>>>>>=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0goto=20redirty_out;=0D=0A>>>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>>>>>>=C2=A0=0D=0A>>>>>>=20-=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(atomic=20&&=20=21test_opt(sbi,=20NOBARR=
IER)=20&&=20=21f2fs_sb_has_blkzoned(sbi))=0D=0A>>>>>>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0if=20(atomic=20&&=20=21test_opt(sbi,=20NOBARRIER))=0D=0A>=
>>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0fio.op_flags=20=3D=20REQ_PREFLUSH=20REQ=
_FUA;=0D=0A>>>>>>=C2=A0=0D=0A>>>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=20should=20add=20to=20global=20list=20befo=
re=20clearing=20PAGECACHE=20status=20*/

