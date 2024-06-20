Return-Path: <linux-kernel+bounces-222068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C9D90FC65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131BC1F227A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804DC38DCD;
	Thu, 20 Jun 2024 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AsEzZKz6"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591D23A1B0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863075; cv=none; b=qf1k23ugocTAmunlpFE6sIKBHA5ALAFLju7Lra+AiWaojamoB5q9oNANbh++r3ebHuWxtb9gsDkqB4OT2mp/jR0vIQfQ7ROtZJHzFZLtKEl5HbvDumdDdUQlz67LFzBceWgRUejbu+BsY6CAI5mn+6wq8MOCCx22pYn/XxvSIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863075; c=relaxed/simple;
	bh=XWd0eOqJ3H70PRWruPY2eUSIR/sRJJ3e8L4n4gwUeoA=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=hBdItb6Xe57x0S43fg3Nrrxh/IzZV5Z6oF/nA7+NlqyM4dqBQnOWVy/7QRuPZL9uSLUTGvrF6sA7UOwMEEOpDoR87KaDrm3MIkmRXyWwhZ6c6FfQLkSC/mm2BS7D5Ll0kqq2U8dHBw3qr2k8aCHEBg/Z/VUD5ZIgpBlt+btlGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AsEzZKz6; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240620055749epoutp03c6933bc53f9150ccd07a63580524085a~aoNrd1enW0785107851epoutp03P
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:57:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240620055749epoutp03c6933bc53f9150ccd07a63580524085a~aoNrd1enW0785107851epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718863069;
	bh=XWd0eOqJ3H70PRWruPY2eUSIR/sRJJ3e8L4n4gwUeoA=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=AsEzZKz6fyvQJx5nM+WbAhHAlkX0oCLJ2PaEefOBbvTx1NVBuclKnH3zosr9mvyXb
	 LrdDaE/LBureMFkicXPZzK8SeNt5M41krmzGI2lFVXnjeyblSc8A9nAMDB7/64WL8U
	 VrRGS7DcJPx4wdUaGDbWsCYKaeyFuySAvOwNxDJs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240620055749epcas2p111ce2c2c97dc7539b2134cf64ed5cb30~aoNq9h_z81179011790epcas2p1m;
	Thu, 20 Jun 2024 05:57:49 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4W4VC05gBBz4x9Q0; Thu, 20 Jun
	2024 05:57:48 +0000 (GMT)
X-AuditID: b6c32a46-f3bff7000000250d-22-6673c4dcd196
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.E1.09485.CD4C3766; Thu, 20 Jun 2024 14:57:48 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [f2fs-dev] [PATCH] Revert
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
In-Reply-To: <2842767c-db80-407b-a5e5-2b9fa74b0d79@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240620055648epcms2p11b9914d40f560fb02fa241a7d2599298@epcms2p1>
Date: Thu, 20 Jun 2024 14:56:48 +0900
X-CMS-MailID: 20240620055648epcms2p11b9914d40f560fb02fa241a7d2599298
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTTPfOkeI0g8/HdC1OTz3LZPHykKZF
	z6Y1LBarHoRbPFk/i9ni0iJ3i8u75rBZXFt+l9GBw2PnrLvsHptWdbJ57F7wmcmjb8sqRo/P
	m+QCWKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
	DlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZ
	AhUmZGc83PSMveCmXMWjgzUNjLNluhg5OSQETCR+TPjO3sXIxSEksINR4vjfWyxdjBwcvAKC
	En93CIPUCAukSlzreMsOYgsJKEmsvziLHSKuJ3Hr4RpGEJtNQEdi+on7YHERgRyJ9+1HwGYy
	C7xmlLjbvpkFYhmvxIz2p1C2tMT25VsZQXZxCthJnPlaCBHWkPixrJcZwhaVuLkaYi+I/f7Y
	fEYIW0Si9d5ZqBpBiQc/d0PFJSVuz90EVZ8v8f/Kcii7RmLbgXlQtj7QLxvBTuAV8JW4fGIG
	G4jNIqAq8arrEdRMF4ntc1vAbGYBbYllC18zg5zJLKApsX6XPogpIaAsceQWC0QFn0TH4b/s
	MA82bPyNlb1j3hMmCFtNYt3P9UwTGJVnIcJ5FpJdsxB2LWBkXsUollpQnJueWmxUYASP2eT8
	3E2M4ASp5baDccrbD3qHGJk4GA8xSnAwK4nwPu8qShPiTUmsrEotyo8vKs1JLT7EaAr05URm
	KdHkfGCKziuJNzSxNDAxMzM0NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1Oqgel65/Tg
	vzlOyvpVgY/nJWfFGAvuTQi596DIRefh+zer5P9nT77gs/vCxKKLecv3H1T7Eymsd+jchgod
	i7jnbBZ1J5j9zvYo7Ap/vXRC6KwWhby172oXLpfWmRkY8Llic/+ZSF7N6IX5gZrcAkcO2pa1
	q3DLfy9yibT9aXH0wr/NRunxzfqG+7+fbdh1PcGv/d+y0rLbicuDTsUxmk886Wl9lJdrSZDH
	PI6dZp2xM+Yefnn04VsBbhGe6Y0af616M9jmf1jFwrBG/5+f8Wf3+D8b2WbweG10U16XdNzw
	3qlJBgfdbTzV+ybeTb2Y/aT6+PYZyq7NNs+m+58/cUXM+5cFk0iUp+3uKTzlBwxUZiixFGck
	GmoxFxUnAgCPQ2VpGQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240620032223epcas2p4d6b770a8e256d140e5296df8a386418e
References: <2842767c-db80-407b-a5e5-2b9fa74b0d79@kernel.org>
	<20240614004841.103114-1-cwjhust@gmail.com>
	<CGME20240620032223epcas2p4d6b770a8e256d140e5296df8a386418e@epcms2p1>

Hi Chao,

> Jaegeuk,
>=20
> Quoted commit message from commit c550e25bca66 (=22f2fs: use flush comman=
d
> instead of FUA for zoned device=22)
> =22
> The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flus=
h
> command to keep the write order.
> =22
>=20
> It seems mq-deadline use fifo queue and make queue depth of zone device
> as 1 to IO order, so why FUA'ed write node IOs can be reordered by block
> layer?

While other writes are aligned by the mq-deadline, write with FUA is not pa=
ssed
to the scheduler but handled at the block layer.

Thanks,
Daejun

>=20
> Thanks,
>=20
> On 2024/6/14 8:48, Wenjie Cheng wrote:
> > This reverts commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1.
> >
> > Commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1 (=22f2fs: use flush
> > command instead of FUA for zoned device=22) used additional flush
> > command to keep write order.
> >
> > Since Commit dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 (=22block:
> > Introduce zone write plugging=22) has enabled the block layer to
> > handle this order issue, there is no need to use flush command.
> >
> > Signed-off-by: Wenjie Cheng <cwjhust=40gmail.com>
> > ---
> >=C2=A0=20fs/f2fs/file.c=203=20+--=0D=0A>=20>=C2=A0=20fs/f2fs/node.c=202=
=20+-=0D=0A>=20>=C2=A0=202=20files=20changed,=202=20insertions(+),=203=20de=
letions(-)=0D=0A>=20>=0D=0A>=20>=20diff=20--git=20a/fs/f2fs/file.c=20b/fs/f=
2fs/file.c=0D=0A>=20>=20index=20eae2e7908072..f08e6208e183=20100644=0D=0A>=
=20>=20---=20a/fs/f2fs/file.c=0D=0A>=20>=20+++=20b/fs/f2fs/file.c=0D=0A>=20=
>=20=40=40=20-372,8=20+372,7=20=40=40=20static=20int=20f2fs_do_sync_file(st=
ruct=20file=20*file,=20loff_t=20start,=20loff_t=20end,=0D=0A>=20>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0f2fs_remove_ino_entry(sbi,=20ino,=
=20APPEND_INO);=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0clear_inode_flag(inode,=20FI_APPEND_WRITE);=0D=0A>=20>=C2=A0=20flush_out=
:=0D=0A>=20>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20((=21atomic=20&&=
=20F2FS_OPTION(sbi).fsync_mode=20=21=3D=20FSYNC_MODE_NOBARRIER)=0D=0A>=20>=
=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20(atomic=20&&=20=
=21test_opt(sbi,=20NOBARRIER)=20&&=20f2fs_sb_has_blkzoned(sbi)))=0D=0A>=20>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21atomic=20&&=20F2FS_OPTION(=
sbi).fsync_mode=20=21=3D=20FSYNC_MODE_NOBARRIER)=0D=0A>=20>=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0ret=
=20=3D=20f2fs_issue_flush(sbi,=20inode->i_ino);=0D=0A>=20>=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=21ret)=20=7B=0D=0A>=20>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0f2fs_remove_ino_entry(sbi,=20ino,=20UPDATE_INO);=0D=0A>=20>=20diff=20--g=
it=20a/fs/f2fs/node.c=20b/fs/f2fs/node.c=0D=0A>=20>=20index=20144f9f966690.=
.c45d341dcf6e=20100644=0D=0A>=20>=20---=20a/fs/f2fs/node.c=0D=0A>=20>=20+++=
=20b/fs/f2fs/node.c=0D=0A>=20>=20=40=40=20-1631,7=20+1631,7=20=40=40=20stat=
ic=20int=20__write_node_page(struct=20page=20*page,=20bool=20atomic,=20bool=
=20*submitted,=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0goto=20redirty_out;=0D=0A>=20>=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A>=20>=C2=A0=0D=0A>=20=
>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(atomic=20&&=20=21test_opt(sb=
i,=20NOBARRIER)=20&&=20=21f2fs_sb_has_blkzoned(sbi))=0D=0A>=20>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(atomic=20&&=20=21test_opt(sbi,=20NOBARR=
IER))=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0fio.op_flags=20=3D=20REQ_PREFLUSH=20REQ_FUA;=
=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0/*=20should=20add=20to=20global=20list=20before=20clearing=20PAGECACH=
E=20status=20*/

