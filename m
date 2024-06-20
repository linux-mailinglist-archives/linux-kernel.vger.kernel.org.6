Return-Path: <linux-kernel+bounces-222155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B3F90FD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3231EB23018
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAE043AD2;
	Thu, 20 Jun 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HrXN57BF"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E960482ED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868211; cv=none; b=ZKPEgG+rU0Jt+u+R5ianLNu9stBeftEfJZYqdX5CHz72z5mVo/18waWUj4hllne4RZEAEwAUqlnMFxrMngEgr3TIXH4MXT1iZUEVRr7fH9hJOt9zubJo0xCVuMzvfDk0B0NC5JAsOIRuaIK7vF10wOqe0WxOk77caQwT99v8lUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868211; c=relaxed/simple;
	bh=ZMD+eUNPkTvI8EzE/tK4EjSojliihh5xZOfubO866Oo=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=QBA9MBSpozSQWei/Nw0mqwWwSzOxuoieDSSKB569xchRZuEwgtHeNWW35MPVtdXfghlCW61Ukw5ps4GbzFeIVD5bI5IH5RMhabX7mrTcNVkX+1RdHbSwM1CSW9GXUK9Nt8FnwJKmoy0tvsGBz9QolBQdBbTZ+DEd9AgTqU0TN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HrXN57BF; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240620072320epoutp02a278de28eb3832255d4f3e6312d26db7~apYVrUCAx2815528155epoutp02D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:23:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240620072320epoutp02a278de28eb3832255d4f3e6312d26db7~apYVrUCAx2815528155epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718868200;
	bh=ZMD+eUNPkTvI8EzE/tK4EjSojliihh5xZOfubO866Oo=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=HrXN57BFujvL90h6J0Tcs71hrVG6wMVDDYh62Gymxa1qvaX6Dp+I1F5dqtf7HcD4X
	 6HN30EnSZYdNvKWTbqrypenC70W+bi2x9KFpzKngWwV926cIKSfmruj06o6rqR/W8c
	 BFL3EmB0zsKaCvmAFKb6O1Dp7GfoVJB92zFkn4gA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240620072319epcas2p4fa0015bca03ed230be409c525e8b0e64~apYVLDKDS0981009810epcas2p4T;
	Thu, 20 Jun 2024 07:23:19 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.92]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4W4X5g2J23z4x9QF; Thu, 20 Jun
	2024 07:23:19 +0000 (GMT)
X-AuditID: b6c32a43-993ff7000000dbb1-7e-6673d8e7222d
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.DD.56241.7E8D3766; Thu, 20 Jun 2024 16:23:19 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) (2) [f2fs-dev] [PATCH] Revert
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
In-Reply-To: <e2371e59-7be5-40dc-9a2a-aef90ac93b18@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240620072218epcms2p11597e482b28804dd5f66b9d42a21b22f@epcms2p1>
Date: Thu, 20 Jun 2024 16:22:18 +0900
X-CMS-MailID: 20240620072218epcms2p11597e482b28804dd5f66b9d42a21b22f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTXPf5jeI0gw1LBCxOTz3LZPHykKZF
	z6Y1LBarHoRbPFk/i9ni0iJ3i8u75rBZXFt+l9GBw2PnrLvsHptWdbJ57F7wmcmjb8sqRo/P
	m+QCWKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
	DlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZ
	AhUmZGe87Z/PXtCjWtHZ/o2xgfGXUhcjJ4eEgInEynkXWbsYuTiEBHYwSiz58oOxi5GDg1dA
	UOLvDmGQGmGBTIln724xgthCAkoS6y/OYoeI60ncergGLM4moCMx/cR9sLiIQI7E+/Yj7CAz
	mQVeM0rcbd/MArGMV2JG+1MoW1pi+/KtYM2cAnYSl3++ZoaIa0j8WNYLZYtK3Fz9lh3Gfn9s
	PiOELSLReu8sVI2gxIOfu6HikhK3526Cqs+X+H9lOZRdI7HtwDwoW1/iWsdGsBt4BXwlvm56
	wQZiswioSvSv3s8GUeMicefECbAaZgFtiWULQW7jALI1Jdbv0gcxJQSUJY7cgqrgk+g4/Jcd
	5sOGjb+xsnfMe8IEYatJrPu5nmkCo/IsREDPQrJrFsKuBYzMqxjFUguKc9NTk40KDOFxm5yf
	u4kRnCS1nHcwXpn/T+8QIxMH4yFGCQ5mJRHe511FaUK8KYmVValF+fFFpTmpxYcYTYG+nMgs
	JZqcD0zTeSXxhiaWBiZmZobmRqYG5krivPda56YICaQnlqRmp6YWpBbB9DFxcEo1MPluXcl6
	yabV53co+9Ywf81laSESrKlveAuWLrhgHbcia/vtJcJdD+rXJNkbSRmtM95uf+3mL8HWTcf3
	/fao21Gz7p37pgaXS2tPrAkPtFrOoF3Qznbv+VkBjYPVC5n7vp/e0rZLg0/XkPVhMetB5W2r
	b4ikrTlQobGvZ/V2l+1z/mkuensyulqR8/DXF6afOVSUZmu87ztxyuvF/ve/vx9W+CJtNv+B
	4+JnWqcWO2m/PGryrqRsL4/6wbDD6lv9FnUs9Ux8k9IWWl7dP9XN4uasDfd/vp1fx3DUU3vx
	r90TFFLdy1dq3VY92MLy/JQVv8APydzI4Nv7LhRbnLsSl7SZ2UBGbq9R4t0v//+lbLupxFKc
	kWioxVxUnAgANMXXyRsEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240620032223epcas2p4d6b770a8e256d140e5296df8a386418e
References: <e2371e59-7be5-40dc-9a2a-aef90ac93b18@kernel.org>
	<2842767c-db80-407b-a5e5-2b9fa74b0d79@kernel.org>
	<20240614004841.103114-1-cwjhust@gmail.com>
	<20240620055648epcms2p11b9914d40f560fb02fa241a7d2599298@epcms2p1>
	<CGME20240620032223epcas2p4d6b770a8e256d140e5296df8a386418e@epcms2p1>

>On 2024/6/20 13:56, Daejun Park wrote:
>> Hi Chao,
>>
>>> Jaegeuk,
>>>
>>> Quoted commit message from commit c550e25bca66 (=22f2fs: use flush comm=
and
>>> instead of FUA for zoned device=22)
>>> =22
>>> The block layer for zoned disk can reorder the FUA'ed IOs. Let's use fl=
ush
>>> command to keep the write order.
>>> =22
>>>
>>> It seems mq-deadline use fifo queue and make queue depth of zone device
>>> as 1 to IO order, so why FUA'ed write node IOs can be reordered by bloc=
k
>>> layer?
>>
>> While other writes are aligned by the mq-deadline, write with FUA is not=
 passed
>> to the scheduler but handled at the block layer.
>
>Hi Daejun,
>
>IIUC, do you mean write w/ FUA may be handled directly in below path?
>
>- blk_mq_submit_bio
>=C2=A0=20-=20op_is_flush=20&&=20blk_insert_flush=0D=0A=0D=0AHi=20Chao,=0D=
=0A=0D=0AYes,=20I=20think=20the=20path=20caused=20an=20unaligned=20write=20=
when=20the=20zone=20lock=20was=0D=0Abeing=20applied=20by=20mq-deadline.=0D=
=0A=0D=0A>=0D=0A>Thanks,=0D=0A>=0D=0A>>=0D=0A>>=20Thanks,=0D=0A>>=20Daejun=
=0D=0A>>=0D=0A>>>=0D=0A>>>=20Thanks,=0D=0A>>>=0D=0A>>>=20On=202024/6/14=208=
:48,=20Wenjie=20Cheng=20wrote:=0D=0A>>>>=20This=20reverts=20commit=20c550e2=
5bca660ed2554cbb48d32b82d0bb98e4b1.=0D=0A>>>>=0D=0A>>>>=20Commit=20c550e25b=
ca660ed2554cbb48d32b82d0bb98e4b1=20(=22f2fs:=20use=20flush=0D=0A>>>>=20comm=
and=20instead=20of=20FUA=20for=20zoned=20device=22)=20used=20additional=20f=
lush=0D=0A>>>>=20command=20to=20keep=20write=20order.=0D=0A>>>>=0D=0A>>>>=
=20Since=20Commit=20dd291d77cc90eb6a86e9860ba8e6e38eebd57d12=20(=22block:=
=0D=0A>>>>=20Introduce=20zone=20write=20plugging=22)=20has=20enabled=20the=
=20block=20layer=20to=0D=0A>>>>=20handle=20this=20order=20issue,=20there=20=
is=20no=20need=20to=20use=20flush=20command.=0D=0A>>>>=0D=0A>>>>=20Signed-o=
ff-by:=20Wenjie=20Cheng=20<cwjhust=40gmail.com>=0D=0A>>>>=20---=0D=0A>>>>=
=C2=A0=20=C2=A0=20fs/f2fs/file.c=203=20+--=0D=0A>>>>=C2=A0=20=C2=A0=20fs/f2=
fs/node.c=202=20+-=0D=0A>>>>=C2=A0=20=C2=A0=202=20files=20changed,=202=20in=
sertions(+),=203=20deletions(-)=0D=0A>>>>=0D=0A>>>>=20diff=20--git=20a/fs/f=
2fs/file.c=20b/fs/f2fs/file.c=0D=0A>>>>=20index=20eae2e7908072..f08e6208e18=
3=20100644=0D=0A>>>>=20---=20a/fs/f2fs/file.c=0D=0A>>>>=20+++=20b/fs/f2fs/f=
ile.c=0D=0A>>>>=20=40=40=20-372,8=20+372,7=20=40=40=20static=20int=20f2fs_d=
o_sync_file(struct=20file=20*file,=20loff_t=20start,=20loff_t=20end,=0D=0A>=
>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0f2fs_remove_=
ino_entry(sbi,=20ino,=20APPEND_INO);=0D=0A>>>>=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0clear_inode_flag(inode,=20FI_APPEND_WRITE)=
;=0D=0A>>>>=C2=A0=20=C2=A0=20flush_out:=0D=0A>>>>=20-=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0if=20((=21atomic=20&&=20F2FS_OPTION(sbi).fsync_mode=20=21=3D=
=20FSYNC_MODE_NOBARRIER)=0D=0A>>>>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=C2=A0=20=C2=A0=20(atomic=20&&=20=21test_opt(sbi,=20NOBARRIER)=20&&=20f2fs_=
sb_has_blkzoned(sbi)))=0D=0A>>>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=
=20(=21atomic=20&&=20F2FS_OPTION(sbi).fsync_mode=20=21=3D=20FSYNC_MODE_NOBA=
RRIER)=0D=0A>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ret=20=3D=20f2fs_issue_flush(sbi,=20=
inode->i_ino);=0D=0A>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0if=20(=21ret)=20=7B=0D=0A>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0f2fs_remove_ino=
_entry(sbi,=20ino,=20UPDATE_INO);=0D=0A>>>>=20diff=20--git=20a/fs/f2fs/node=
.c=20b/fs/f2fs/node.c=0D=0A>>>>=20index=20144f9f966690..c45d341dcf6e=201006=
44=0D=0A>>>>=20---=20a/fs/f2fs/node.c=0D=0A>>>>=20+++=20b/fs/f2fs/node.c=0D=
=0A>>>>=20=40=40=20-1631,7=20+1631,7=20=40=40=20static=20int=20__write_node=
_page(struct=20page=20*page,=20bool=20atomic,=20bool=20*submitted,=0D=0A>>>=
>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0goto=20redirty_out;=0D=0A>>>>=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>>>>=C2=A0=0D=0A>>>>=20-=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(atomic=20&&=20=21test_opt(sbi,=20NOB=
ARRIER)=20&&=20=21f2fs_sb_has_blkzoned(sbi))=0D=0A>>>>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0if=20(atomic=20&&=20=21test_opt(sbi,=20NOBARRIER))=0D=
=0A>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0fio.op_flags=20=3D=20REQ_PREFLUSH=20REQ_FUA;=
=0D=0A>>>>=C2=A0=0D=0A>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0/*=20should=20add=20to=20global=20list=20before=20clearing=20PA=
GECACHE=20status=20*/

