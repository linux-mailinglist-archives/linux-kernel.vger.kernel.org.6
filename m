Return-Path: <linux-kernel+bounces-394177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256CF9BAB7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4982C1C21BA8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA147165F04;
	Mon,  4 Nov 2024 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f4fX4Hso"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE4178CF6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691082; cv=none; b=hkbhOiTmRAKIn+khZpXSfXIe2zQXvBbszEZTFp+JxGYVFVbznJUccCdFavZasbWOhrvvmMRW5YfYppCGgxSgV07JscCFmDFLLQYtge9qSU/Vs5NJEF1O1IHde9TzMDAe5UHRK+sSngG8HZvYE0zyaFd6FdDQz4+pz+6UQeuhyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691082; c=relaxed/simple;
	bh=XW7Tr0AzfONF9JAh8jwgreE8dCgwPj6E80Ah/QrwGYE=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=N6txnSl+LHZxjhK5fT5HRayzDOvc5ZarEGHpvM42Qfm2F/DIgE5qjL74O9ORk/9dNjiJeiI0AqihKTLzyy/6KHMUcCNPgdtmXofT0DGolzowrQBtwXhr2xcCwfv7vfq4jqbckkUHT4oOWkFmjiFskn+wkx+t3y6kBA7MS0fcDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=f4fX4Hso; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241104033116epoutp024560b71c5759faf4d068f2c2e3d5b874~Epl1eCZUC1463614636epoutp02P
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:31:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241104033116epoutp024560b71c5759faf4d068f2c2e3d5b874~Epl1eCZUC1463614636epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730691076;
	bh=XW7Tr0AzfONF9JAh8jwgreE8dCgwPj6E80Ah/QrwGYE=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=f4fX4Hsoj1Fis/zHlJjhCuZW7QL2Uggc7xQ56N4u14svGw1WFs0mek7da5weLj5+N
	 dcrake166IpgQRHUlvRT+kwYFzFSbF1vpwozbiuKTbHeZ3Jyxf4aO7/v0ymQs/bEp4
	 IdQBZnLcjtacSp2wurkTwHxTana67QPjIcFhOLW4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20241104033116epcas2p38388eac36a1640bced9169419b71eed9~Epl1OeVNl0642706427epcas2p3C;
	Mon,  4 Nov 2024 03:31:16 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XhcSg6ghQz4x9Q7; Mon,  4 Nov
	2024 03:31:15 +0000 (GMT)
X-AuditID: b6c32a46-638d9a800000262a-14-67284003751b
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.0E.09770.30048276; Mon,  4 Nov 2024 12:31:15 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid forcing direct write to
 use buffered IO on inline_data ino
Reply-To: jinsu1.lee@samsung.com
Sender: Jinsu Lee <jinsu1.lee@samsung.com>
From: Jinsu Lee <jinsu1.lee@samsung.com>
To: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>
CC: "chao@kernel.org" <chao@kernel.org>, "jaegeuk@kernel.org"
	<jaegeuk@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241104033115epcms2p2867a532b5cdb012b1612931597cedf4a@epcms2p2>
Date: Mon, 04 Nov 2024 12:31:15 +0900
X-CMS-MailID: 20241104033115epcms2p2867a532b5cdb012b1612931597cedf4a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmuS6zg0a6wdobKhanp55lsniyfhaz
	xaVF7haXd81hc2Dx2LSqk81j94LPTB6fN8kFMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8eb
	mhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYALVNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2Cql
	FqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGf0bTzOXDBTomLB0b1sDYzzxbsYOTkkBEwk
	Pnycy9LFyMUhJLCDUeJD2x7mLkYODl4BQYm/O4RBaoQF8iWWHlvGCmILCShITG3ZxAYR15I4
	vvQ/E4jNJqAh8eX+L3YQW0QgXGL+8h3sIDOZBaYySnx7soEFYhmvxIz2p1C2tMT25VsZIWwN
	iR/LepkhbFGJm6vfssPY74/Nh6oRkWi9dxaqRlDiwc/dUHFJiZ0tC6Hi+RIPzz9iBVksIdDC
	KHF6zhSoIn2JbX9mgy3mFfCVaDt9GCzOIqAqsfHTJnaQhyUEXCTm3wsCCTMLaEssW/gaHA7M
	ApoS63fpQ1QoSxy5xQJRwSfRcfgvO8xXO+Y9YYKwVSRWz90HdY2UxJwVk6AO8JDYOh3CFhII
	lPjUs5BtAqPCLERAz0KydxbC3gWMzKsYxVILinPTU4uNCozgcZucn7uJEZzstNx2ME55+0Hv
	ECMTB+MhRgkOZiUR3nmp6ulCvCmJlVWpRfnxRaU5qcWHGE2BHp7ILCWanA9Mt3kl8YYmlgYm
	ZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTAl1mdpxFziXMybYaSUssDu5a6t
	zd9Fi1uWbN7oN3NT5q/iNSeX730f2eWiFn2rMstt5iOV6etOrluUfPISw7Mqq8zXTxzcJupZ
	Wjg22DcatHNOSPxa91Iv2rr/flz0nhDDqjmLWeN+brx09J/qJaYNp5yOz+19bOk52/RVsRH3
	rw83smYpJzu/FbudfGs3z7JL5llXd8QsWH760b97dVYfzz7fInG5VXynvpiB2EKR5tDMUzxp
	u71Ng1fOvXyK8XfH03dLFje4Hf11szPNb/H//Fnm29M1jk1yiXz/q6Xt39NZHU2uX4wfWPH9
	t7LcZDM5SNGdXcL/huW50wq7G4Nv7z/7wMKsxkp/fv2Uc8GTlFiKMxINtZiLihMBxHUz2/8D
	AAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241104033115epcms2p2867a532b5cdb012b1612931597cedf4a
References: <CGME20241104033115epcms2p2867a532b5cdb012b1612931597cedf4a@epcms2p2>

> Jinsu Lee reported aperformance regression issue, after commit
> 5c8764f8679e (=22f2fs: fixto force buffered IO on inline_data
> inode=22), we forced directwrite to use buffered IO on inline_data
> inode, it will causeperformace regression due to memory copy
> and data flush.
=C2=A0=0D=0A>=20It's=20fine=20to=20not=20force=20directwrite=20to=20use=20b=
uffered=20IO,=20as=20it=0D=0A>=20can=20convert=20inline=20inodebefore=20com=
mitting=20direct=20write=20IO.=0D=0A=C2=A0=0D=0A>=20Fixes:=205c8764f8679e(=
=22f2fs:=20fix=20to=20force=20buffered=20IO=20on=20inline_data=20inode=22)=
=0D=0A>=20Reported-by:=20Jinsu=20Lee<jinsu1.lee=40samsung.com>=0D=0A>=20Clo=
ses:https://lore.kernel.org/linux-f2fs-devel/af03dd2c-e361-4f80-b2fd-394407=
66cf6e=40kernel.org=0D=0A>=20Signed-off-by:=20Chao=20Yu<chao=40kernel.org>=
=0D=0A>=20---=0D=0A>=20fs/f2fs/file.c=206=20+++++-=0D=0A>=201=20file=20chan=
ged,=205insertions(+),=201=20deletion(-)=0D=0A=C2=A0=0D=0A>=20diff=20--git=
=20a/fs/f2fs/file.cb/fs/f2fs/file.c=0D=0A>=20index0e7a0195eca8..377a10b81bf=
3=20100644=0D=0A>=20---=20a/fs/f2fs/file.c=0D=0A>=20+++=20b/fs/f2fs/file.c=
=0D=0A>=20=40=40=20-883,7=20+883,11=20=40=40=20staticbool=20f2fs_force_buff=
ered_io(struct=20inode=20*inode,=20int=20rw)=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=20true;=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if(f2fs_compressed_file(inode))=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return=20true;=0D=0A>=20-=20=C2=A0=C2=A0=C2=A0=C2=
=A0if=20(f2fs_has_inline_data(inode))=0D=0A>=20+=20=C2=A0=C2=A0=C2=A0=C2=A0=
/*=0D=0A>=20+=20=C2=A0=C2=A0=C2=A0=C2=A0*=20only=20force=20direct=20read=20=
to=20use=20bufferedIO,=20for=20direct=20write,=0D=0A>=20+=20=C2=A0=C2=A0=C2=
=A0=C2=A0*=20it=20expects=20inline=20data=20conversion=20beforecommitting=
=20IO.=0D=0A>=20+=20=C2=A0=C2=A0=C2=A0=C2=A0*/=0D=0A>=20+=20=C2=A0=C2=A0=C2=
=A0=C2=A0if=20(f2fs_has_inline_data(inode)=20&&rw=20=3D=3D=20READ)=0D=0A=C2=
=A0=0D=0AHi,=20Chao=20Yu=0D=0AThe=20fio=20direct=20performance=20problem=20=
I=20reported=20did=20not=20improve=20when=20reflecting=20this=20commit.=0D=
=0ARather,=20it=20has=20been=20improved=20when=20reflecting=20your=20commit=
=20below.=0D=0A=C2=A0=0D=0AThe=20previous=20commit=20seems=20to=20be=20mist=
itled=20as=20read=20and=20the=20following=20commit=20appears=20to=20be=20th=
e=20final=20version.=C2=A0=0D=0A=0D=0A=20=20=20=20commit=202b6bb0cd3bdcb110=
8189301ec4ec76c89f939310=0D=0A=20=20=20=20Author:=20Chao=20Yu=20via=20Linux=
-f2fs-devel=20<linux-f2fs-devel=40lists.sourceforge.net>=0D=0A=20=20=20=20D=
ate:=20=20=20Mon=20Nov=204=2009:35:51=202024=20+0800=0D=0A=0D=0A=20=20=20=
=20=20=20=20=20=5Bf2fs-dev=5D=20=5BPATCH=20v2=5D=20f2fs:=20fix=20to=20map=
=20blocks=20correctly=20for=20direct=20write=0D=0A=0D=0A=0D=0Athe=20reason=
=20for=20the=20improvement=20to=20commit=20(2b6bb0cd3bdc)=20seems=20to=20be=
=20because=20of=20the=20=22m_may_create=22=20condition.=0D=0Awhen=20perform=
ing=20=22io_submit=22=20directly,=20so=20performance=20regression=20issue=
=20may=20occur.=0D=0A

