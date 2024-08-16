Return-Path: <linux-kernel+bounces-288890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82D954014
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E0C1F22BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984A776F17;
	Fri, 16 Aug 2024 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G2XZcvrw"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AD6F2F8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723779474; cv=none; b=qmtu76cxUjJfMwFCsargchVw7EOpnNffLto/R0qmSqNdnzji/paVsWj49LRWPaU3tWt3AGgLQUaaS3CJc5vw+Y3U29ZL0q1mXHyBL5iNn+Vqes+jEWrUAwX7jmFLbdPYUDBEICZVKa7YqWXAmG7KtLJrSheBFTMNSVvKiCoOnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723779474; c=relaxed/simple;
	bh=GKT9n0LE/jRTJ8z1XbxXBjjNKVz+g51Bm3M2MeL+xOg=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=IUB11n/DwC94t49wlN+rzrSaVOAEEWnmQPHI7yXnDZuTdgsCMcPqrpNqQ4bh8HM7iAPpWsCyuKHo/x+niW2sLDkMm82ANRGS/IwMf1UaUZjpIshl49AY1LMUxLOywfj4YDphM/A65GVnDCkiYx/WrNyHug9cqLHjs7om25wxGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=G2XZcvrw; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240816033749epoutp01362bf49d82456aea9da5c38943ec1df2~sGEtgWqWE0031000310epoutp01_
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:37:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240816033749epoutp01362bf49d82456aea9da5c38943ec1df2~sGEtgWqWE0031000310epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723779469;
	bh=GKT9n0LE/jRTJ8z1XbxXBjjNKVz+g51Bm3M2MeL+xOg=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=G2XZcvrwxIqrDUfpmo7lvT8Fh+V2/q/2YntDB/72s95vENs0qrPwk8EqPRm7DIcuZ
	 yGvyI5/U0f81NqLLyrnkl5SgJH6yGRv8J+DdFutgfkPp4KHqquxQGcycC7dy/oZeWz
	 EPL/dyak5lyAl0WRyvnXIOQA7pgfVtQ10AQ22yak=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240816033748epcas2p21e8082e28157ac62f689a9898fad1f4b~sGEtEzYOo1534215342epcas2p2B;
	Fri, 16 Aug 2024 03:37:48 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.70]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WlSP82RrBz4x9Q1; Fri, 16 Aug
	2024 03:37:48 +0000 (GMT)
X-AuditID: b6c32a43-a61b8700000022c5-8f-66bec98c553b
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	49.59.08901.C89CEB66; Fri, 16 Aug 2024 12:37:48 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) (2) [PATCH] f2fs: avoid unused block when dio write in LFS
 mode
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
In-Reply-To: <5b892d6a-620d-47f4-b870-214dcf4bc480@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240816033647epcms2p69f1121d4e0ac69d5b0ebf03288fefba7@epcms2p6>
Date: Fri, 16 Aug 2024 12:36:47 +0900
X-CMS-MailID: 20240816033647epcms2p69f1121d4e0ac69d5b0ebf03288fefba7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmmW7PyX1pBpcfs1ucnnqWyeLlIU2L
	VQ/CLX6cNLHo393OYvFk/Sxmi/tbrzFaXFrkbnF51xw2i5Y/ThbnJ75msljVMZfRYur5I0wO
	vB6bVnWyeexe8JnJo2/LKkaPz5vkAliism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
	LS3MlRTyEnNTbZVcfAJ03TJzgE5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
	F+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnHF+3grFgrVHF5OMH2RsYGw27GDk5JARMJK7+ecva
	xcjFISSwg1FiyZ9l7F2MHBy8AoISf3cIg9QICwRKrH9/hR3EFhJQklh/cRY7RFxP4tbDNYwg
	NpuAjsT0E/fZQeaICDxglJhyYy8bSIJZYC+TRNPyMohlvBIz2p+yQNjSEtuXbwVr5hSwk3hx
	cx0rRFxD4seyXmYIW1Ti5uq37DD2+2PzGSFsEYnWe2ehagQlHvzcDRWXlLg9dxNUfb7E/yvL
	oewaiW0H5kHZ+hLXOjayQPzoK7F4fyhImEVAVeLfqvVQI10kGue/YYE4X1ti2cLXzCDlzAKa
	Eut36YOYEgLKEkduQVXwSXQc/ssO82DDxt9Y2TvmPWGCsNUk1v1czzSBUXkWIpxnIdk1C2HX
	AkbmVYxiqQXFuempyUYFhvCoTc7P3cQITqNazjsYr8z/p3eIkYmD8RCjBAezkgjv0y9704R4
	UxIrq1KL8uOLSnNSiw8xmgJ9OZFZSjQ5H5jI80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhP
	LEnNTk0tSC2C6WPi4JRqYPLyOiRbcVdw9fvH+S4Zdq+2bXxtr+Kpv1JNUPqh5R+N73tLNwhI
	rXvoF/wixPuK06KQi5nsOSY9GStk9q34ccHtxTMji1bJzvWqmsKFmnXyPNEiV6w9tJitHwtK
	T6pb4cy9hf1Ap9Li3Vc4jJtm/z8Vwaj2xHznxKM+z5hfPmyo11/zeF3R+4/p4T+XuxUXuLdc
	YGDLqkl3ipY6I7t5Ytgzg9Dui0/i3GcK+E+eXZCaPPMCi2gh09Tn2ltmtRwU8WKOeTdD567Y
	80C3VMHVD1wXzP5kFnpD6q+fTHHz4WOblRZy1dXo/Vlwpdb9a6592f6ip+7xE25nti227bkq
	bZA8i7kg+8TB0nz2PU/NlFiKMxINtZiLihMBDzRXWCwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b
References: <5b892d6a-620d-47f4-b870-214dcf4bc480@kernel.org>
	<7860b050-3948-4e23-b40f-a3df522477cd@kernel.org>
	<20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p7>
	<20240816001700epcms2p37f406e9cd3a1d6438a866e7a7a3d5c31@epcms2p3>
	<CGME20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p6>

Hi Chao Yu,

>=C2=A0=0D=0A>---------=20Original=20Message=20---------=0D=0A>Sender=20:=
=20Chao=20Yu=20<chao=40kernel.org>=0D=0A>Date=20:=202024-08-16=2010:56=20(G=
MT+9)=0D=0A>Title=20:=20Re:=20(2)=20=5BPATCH=5D=20f2fs:=20avoid=20unused=20=
block=20when=20dio=20write=20in=20LFS=20mode=0D=0A>=C2=A0=0D=0A>On=202024/8=
/16=208:17,=20Daejun=20Park=20wrote:=0D=0A>>=20Hi=20Chao=20Yu,=0D=0A>>>=C2=
=A0=0D=0A>>>=20---------=20Original=20Message=20---------=0D=0A>>>=20Sender=
=20:=20Chao=20Yu=20<chao=40kernel.org>=0D=0A>>>=20Date=20:=202024-08-14=201=
8:50=20(GMT+9)=0D=0A>>>=20Title=20:=20Re:=20=5BPATCH=5D=20f2fs:=20avoid=20u=
nused=20block=20when=20dio=20write=20in=20LFS=20mode=0D=0A>>>=C2=A0=0D=0A>>=
>=20On=202024/8/1=2015:47,=20Daejun=20Park=20wrote:=0D=0A>>>>=20This=20patc=
h=20addresses=20the=20problem=20that=20when=20using=20LFS=20mode,=20unused=
=20blocks=0D=0A>>>>=20may=20occur=20in=20f2fs_map_blocks()=20during=20block=
=20allocation=20for=20dio=20writes.=0D=0A>>>>=0D=0A>>>>=20If=20a=20new=20se=
ction=20is=20allocated=20during=20block=20allocation,=20it=20will=20not=20b=
e=0D=0A>>>>=20included=20in=20the=20map=20struct=20by=20map_is_mergeable()=
=20if=20the=20LBA=20of=20the=0D=0A>>>=0D=0A>>>=20I=20didn't=20get=20it,=20w=
hy=20below=20condition=20in=20map_is_mergeable()=20can=20not=20catch=20this=
=0D=0A>>>=20case?=20Can=20you=20please=20explain=20more?=0D=0A>>>=0D=0A>>>=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(map->m_pblk=20=21=3D=20NEW_=
ADDR=20&&=20blkaddr=20=3D=3D=20(map->m_pblk=20+=20ofs))=0D=0A>>>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=
=20true;=0D=0A>>>=0D=0A>>=0D=0A>>=20Thank=20you=20for=20your=20review.=0D=
=0A>>=20map_is_mergeable()=20returns=20true=20when=20the=20last=20block=20i=
n=20the=20section=20is=20merged.=0D=0A>>=20The=20problem=20is=20the=20next=
=20block=20allocation,=20which=20happens=20consecutively.=0D=0A>>=20Since=
=20it=20will=20be=20allocated=20a=20new=20section,=20its=20block=20will=20b=
e=20the=20first=0D=0A>>=20block=20in=20the=20section.=0D=0A>>=20If=20the=20=
newly=20allocated=20section=20is=20not=20contiguous=20with=20the=20previous=
=20section,=0D=0A>>=20map_is_mergeable()=20will=20return=20false.=0D=0A>>=
=20So=20the=20block=20is=20allocated=20but=20unused.=0D=0A>>=20However,=20i=
t=20is=20not=20freed,=20so=20the=20block=20is=20unusable.=0D=0A>>=20If=20my=
=20explanation=20was=20not=20clear=20enough,=20please=20feel=20free=20to=20=
ask=20questions.=0D=0A>=0D=0A>It's=20clear=20to=20me=20now,=20thanks=20for=
=20your=20explanation.=0D=0A>=0D=0A>>=0D=0A>>=20Thanks=0D=0A>>=20Daejun=0D=
=0A>>=0D=0A>>>=20Thanks,=0D=0A>>>=0D=0A>>>>=20allocated=20block=20is=20not=
=20contiguous.=20However,=20the=20block=20already=20allocated=0D=0A>>>>=20i=
n=20this=20process=20will=20remain=20unused=20due=20to=20the=20LFS=20mode.=
=0D=0A>>>>=0D=0A>>>>=20This=20patch=20avoids=20the=20possibility=20of=20unu=
sed=20blocks=20by=20escaping=0D=0A>>>>=20f2fs_map_blocks()=20when=20allocat=
ing=20the=20last=20block=20in=20a=20section.=0D=0A>>>>=0D=0A>>>>=20Signed-o=
ff-by:=20Daejun=20Park=20<daejun7.park=40samsung.com>=0D=0A>>>>=20---=0D=0A=
>>>>=C2=A0=20=C2=A0=20fs/f2fs/data.c=2013=20+++++++++++++=0D=0A>>>>=C2=A0=
=20=C2=A0=201=20file=20changed,=2013=20insertions(+)=0D=0A>>>>=0D=0A>>>>=20=
diff=20--git=20a/fs/f2fs/data.c=20b/fs/f2fs/data.c=0D=0A>>>>=20index=20b6dc=
b3bcaef7..b27a3f448f32=20100644=0D=0A>>>>=20---=20a/fs/f2fs/data.c=0D=0A>>>=
>=20+++=20b/fs/f2fs/data.c=0D=0A>>>>=20=40=40=20-1711,6=20+1711,19=20=40=40=
=20int=20f2fs_map_blocks(struct=20inode=20*inode,=20struct=20f2fs_map_block=
s=20*map,=20int=20flag)=0D=0A>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0dn.ofs_in_node=20=3D=
=20end_offset;=0D=0A>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=7D=0D=0A>>>>=C2=A0=0D=0A>>>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0if=20(flag=20=3D=3D=20F2FS_GET_BLOCK_DIO=20&&=20f2fs_lfs_mode(sbi))=20=
=7B=0D=0A>=0D=0A>The=20condition=20should=20check=20map->m_may_create=20as=
=20well,=20otherwise=20f2fs_map_blocks()=0D=0A>from=20read=20path=20will=20=
break=20here?=0D=0A=0D=0AI=20will=20add=20checking=20map->m_may_create.=0D=
=0A=0D=0A>=0D=0A>>>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0int=20segno=20=3D=20GET_SEGNO(sbi,=20blkaddr);=0D=0A>>=
>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0bool=20last_seg,=20last_blk;=0D=0A>>>>=20+=0D=0A>>>>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0last_seg=20=3D=20=
=21((segno=20+=201)=20%=20SEGS_PER_SEC(sbi));=0D=0A>=0D=0A>Should=20conside=
r=20the=20case=20that=20segno=20=23(SEGS_PER_SEC=20-=201)=20is=20not=20vali=
d?=0D=0A>e.g.=20SEGS_PER_SEC=20is=204,=20CAP_SEGS_PER_SEC=20is=202?=0D=0A>=
=0D=0A>>>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0last_blk=20=3D=20(f2fs_usable_blks_in_seg(sbi,=20segno)=20-=201=
)=20=3D=3D=0D=0A>>>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0GET_BLKOFF_FROM_SEG0(sbi,=20blkaddr);=0D=0A>=0D=0A>if=20(=
GET_SEGOFF_FROM_SEG0()=20%=20BLKS_PER_SEC()=20=3D=3D=20CAP_BLKS_PER_SEC()=
=20-=201)=0D=0A>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0goto=20sync_out;=0D=0A=0D=
=0AI=20will=20use=20the=20suggested=20checking=20code.=0D=0A=0D=0AThanks,=
=0D=0ADaejun=0D=0A=0D=0A>=0D=0A>Thanks,=0D=0A>=0D=0A>>>>=20+=0D=0A>>>>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0/*=
=20LBA=20of=20the=20next=20block=20to=20be=20allocated=20may=20not=20be=20c=
ontiguous.=20*/=0D=0A>>>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0if=20(last_seg=20&&=20last_blk)=0D=0A>>>>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0goto=20sync_out;=0D=0A>>>>=20+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=7D=0D=0A>>>>=20+=0D=0A>>>>=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(pgofs=20>=3D=20end)=0D=0A>>>>=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0goto=20sync_out;=0D=0A>>>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0else=20if=20(dn.ofs_in_node=20<=20end_offset)

