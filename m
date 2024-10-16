Return-Path: <linux-kernel+bounces-368114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2589A0B63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB121F26779
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9517E208D88;
	Wed, 16 Oct 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ipi4p0ga"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF42076C7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085097; cv=none; b=D3ISr3iJap7dv5SsnuJEwiiP6kNr07r/aiUo/+sPQ5TnqA2cUtTOQXCFcglSKgV5gnsEAWwy7eC/jtco45eqn7gk7Up0HyJwKzbMd/N3rdg23TKlL1sAtOUw6PPzt13mPnf7vPtwO03JVh5RryHixo49LVU3EShHt6WqqfSxt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085097; c=relaxed/simple;
	bh=O2DtxSKRFoa6w13b2QI0egx5jI5/RBjmW94TnIqzqJc=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=bq2EAWBIzEvQeKeXox4hNkyBGUJ+Oc090v3bi/0gugLcDH96LA1pAaw3f0lXifT/ofv4w8eQpuKO0C51CLSPKedjeYreoRwVBlGmKA8oPkllq0k0Osmi5YmUBPAJrdex4ZLmNNFWPppNXg3x1K9XxqSabMstxrqVOxlEbo6czVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ipi4p0ga; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241016132453epoutp030889b5f497d1cb5c610c4875e2f46b2b~_8btN_UK21795617956epoutp03I
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:24:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241016132453epoutp030889b5f497d1cb5c610c4875e2f46b2b~_8btN_UK21795617956epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729085093;
	bh=O2DtxSKRFoa6w13b2QI0egx5jI5/RBjmW94TnIqzqJc=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=Ipi4p0gaRtKIQYCF8pfZio9sjggFH5FVkGUEXZYYm7H7MZorQm7ogtr4ldCkaFHoY
	 CTv9GjsZ2WFhlbNlf3lfcXS2zDTWxrcK2eU1dkjyfpDnXcBStRjSnE4lKg49WLttvn
	 OQgMS4B880gQFi7GgPMl9Xlo7XZWt/6DfJTiPOsY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20241016132453epcas1p385cc44fd57110dbe58a6043fadef37ee~_8bszBO5b3132331323epcas1p3v;
	Wed, 16 Oct 2024 13:24:53 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.227]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XTBXN68ZMz4x9Ps; Wed, 16 Oct
	2024 13:24:52 +0000 (GMT)
X-AuditID: b6c32a39-5f9f8700000024b6-48-670fbea40b89
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	99.14.09398.4AEBF076; Wed, 16 Oct 2024 22:24:52 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v2] vmscan: add a vmscan event for reclaim_pages
Reply-To: jaewon31.kim@samsung.com
Sender: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
From: =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To: Vlastimil Babka <vbabka@suse.cz>, =?UTF-8?B?6rmA7J6s7JuQ?=
	<jaewon31.kim@samsung.com>, "sj@kernel.org" <sj@kernel.org>,
	"minchan@kernel.org" <minchan@kernel.org>, "kaleshsingh@google.com"
	<kaleshsingh@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241016132452epcms1p6884ae0197aa83731baa193fb5714b0d2@epcms1p6>
Date: Wed, 16 Oct 2024 22:24:52 +0900
X-CMS-MailID: 20241016132452epcms1p6884ae0197aa83731baa193fb5714b0d2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmnu6SffzpBs/361nMWb+GzeLlIU2L
	7s0zGS16379ismjaN5Pd4vKuOWwW99b8Z7VY9vU9u8Xhr2+YLGY39jE6cHnsnHWX3WPBplKP
	Tas62Tw2fZrE7nFixm8Wj74tqxg9ziw4wu7xeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndw
	vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
	Elul1IKUnAKzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMlSe72QruZ1R0T29ibGBsS+1i5OSQ
	EDCR2L1iLWsXIxeHkMAORok1q3vYuhg5OHgFBCX+7hAGqREWcJGYceAmG4gtJKAkcfbHFXaI
	uLXE/kUzmEBsNgFLie03JzKCzBERmMkk8XjpH7ChzAKLGSXaVh5lgtjGKzGj/SkLhC0tsX35
	VkYIW1Ti5uq37DD2+2PzoeIiEq33zjJD2IISD37uZoTp/XP8ORuEXSyxrPMB1PwaiRXnVkHF
	zSUa3q4Es3kFfCX2tm0Gs1kEVCUe/GhhBnlSAuizximiIGFmAW2JZQtfg4WZBTQl1u/Shwjz
	Sbz72sMKc33Dxt/sMPaOeU+gtqpJtDz7ClUjI/H33zMo20Pi3tnpLJBwC5RYv/UmywRG+VmI
	0J2FZPEshMULGJlXMYqlFhTnpqcWGxaYwiM0OT93EyM4hWpZ7mCc/vaD3iFGJg7GQ4wSHMxK
	IryTunjThXhTEiurUovy44tKc1KLDzGaAn08kVlKNDkfmMTzSuINTSwNTMyMTCyMLY3NlMR5
	z1wpSxUSSE8sSc1OTS1ILYLpY+LglGpg4rkkfNhhjaIGs8Y2tqyujYv+nLvOUynKedkgtLPy
	6Oyshgn/gsK7vRe9zE/kLd6xbd/58xyB17W5LK+W+OpJCjG/ncj+n6uls/fPkqUsXnO516Y1
	WnXoZri9ee1hwHViT7VU9V7+ixzd5i1yB+skrv5d8TcuQ6Zd7c/ED0emXuzR3HnkLM+TXynB
	Hn0rxTVOvZp5/SIfx+5Pbb+iMvhW3JM9c3hqrvNuS5/T1j5H2wP489geBW+crDejqTOxUOD1
	hmsLVHalBO79wZAdp+LGP32RV/yluL2nriwp2eTquV8wSTvkX8hknuOJZ1WNlfxvnX391+61
	qZP5o/j1vq4/MwNbGGa8nxP+8vG3iI1pSizFGYmGWsxFxYkAmxQvqCoEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241011124931epcas1p176b2ce6a566f7557468dff1e12677a11
References: <CGME20241011124931epcas1p176b2ce6a566f7557468dff1e12677a11@epcms1p6>

>On 10/11/24 14:49, Jaewon Kim wrote:
>> The reclaim_folio_list uses a dummy reclaim_stat and is not being
>> used. To know the memory stat, add a new trace event. This is useful how
>> how many pages are not reclaimed or why.
>>=20
>> This is an example.
>> mm_vmscan_reclaim_pages: nid=3D0 nr_scanned=3D112 nr_reclaimed=3D112 nr_=
dirty=3D0 nr_writeback=3D0 nr_congested=3D0 nr_immediate=3D0 nr_activate_an=
on=3D0 nr_activate_file=3D0 nr_ref_keep=3D0 nr_unmap_fail=3D0
>>=20
>> Currenlty reclaim_folio_list is only called by reclaim_pages, and
>> reclaim_pages is used by damon and madvise. In the latest Android,
>> reclaim_pages is also used by shmem to reclaim all pages in a
>> address_space.
>>=20
>> Signed-off-by: Jaewon Kim <jaewon31.kim=40samsung.com>
>> ---
>> v2: remove reclaim_stat_add function and call the trace on each node
>> v1: introduce a new trace event
>> ---
>>=C2=A0=20include/trace/events/vmscan.h=20=7C=2045=20+++++++++++++++++++++=
++++++++++++++=0D=0A>>=C2=A0=20mm/vmscan.c=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=20=7C=2016=20+++++++++----=
=0D=0A>>=C2=A0=202=20files=20changed,=2056=20insertions(+),=205=20deletions=
(-)=0D=0A>>=20=0D=0A>>=20diff=20--git=20a/include/trace/events/vmscan.h=20b=
/include/trace/events/vmscan.h=0D=0A>>=20index=201a488c30afa5..490958fa10de=
=20100644=0D=0A>>=20---=20a/include/trace/events/vmscan.h=0D=0A>>=20+++=20b=
/include/trace/events/vmscan.h=0D=0A>>=20=40=40=20-346,6=20+346,51=20=40=40=
=20TRACE_EVENT(mm_vmscan_write_folio,=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0show_reclaim_flags(__ent=
ry->reclaim_flags))=0D=0A>>=C2=A0=20);=0D=0A>>=C2=A0=20=0D=0A>>=20+TRACE_EV=
ENT(mm_vmscan_reclaim_pages,=0D=0A>>=20+=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0TP_PROTO(int=20nid,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0unsigned=20long=20nr_scanned,=
=20unsigned=20long=20nr_reclaimed,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20reclaim_stat=20*stat)=
,=0D=0A>>=20+=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0TP_ARGS(nid,=
=20nr_scanned,=20nr_reclaimed,=20stat),=0D=0A>>=20+=0D=0A>>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0TP_STRUCT__entry(=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__field(int,=20nid)=0D=
=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0__field(unsigned=20long,=20nr_scanned)=0D=0A>>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__field(unsigned=20lo=
ng,=20nr_reclaimed)=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0__field(unsigned=20long,=20nr_dirty)=0D=0A>>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0__field(unsigned=20long,=20nr_writeback)=0D=0A>>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__field(unsigned=20lo=
ng,=20nr_congested)=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0__field(unsigned=20long,=20nr_immediate)=0D=
=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0__field(unsigned=20int,=20nr_activate0)=0D=0A>>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__field(unsigned=20in=
t,=20nr_activate1)=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0__field(unsigned=20long,=20nr_ref_keep)=0D=0A>>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0__field(unsigned=20long,=20nr_unmap_fail)=0D=0A>>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0),=0D=0A>>=20+=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0TP_fast_assign(=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->nid=20=3D=20nid;=0D=0A>>=20+=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->=
nr_scanned=20=3D=20nr_scanned;=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->nr_reclaimed=20=3D=20nr_rec=
laimed;=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0__entry->nr_dirty=20=3D=20stat->nr_dirty;=0D=0A>>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entr=
y->nr_writeback=20=3D=20stat->nr_writeback;=0D=0A>>=20+=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->nr_congested=
=20=3D=20stat->nr_congested;=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->nr_immediate=20=3D=20stat->=
nr_immediate;=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0__entry->nr_activate0=20=3D=20stat->nr_activate=5B0=
=5D;=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0__entry->nr_activate1=20=3D=20stat->nr_activate=5B1=5D;=0D=
=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0__entry->nr_ref_keep=20=3D=20stat->nr_ref_keep;=0D=0A>>=20+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->nr_=
unmap_fail=20=3D=20stat->nr_unmap_fail;=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0),=0D=0A>>=20+=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0T=
P_printk(=22nid=3D%d=20nr_scanned=3D%ld=20nr_reclaimed=3D%ld=20nr_dirty=3D%=
ld=20nr_writeback=3D%ld=20nr_congested=3D%ld=20nr_immediate=3D%ld=20nr_acti=
vate_anon=3D%d=20nr_activate_file=3D%d=20nr_ref_keep=3D%ld=20nr_unmap_fail=
=3D%ld=22,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0__entry->nid,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->nr_scanned,=20__entry=
->nr_reclaimed,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0__entry->nr_dirty,=20__entry->nr_writeback,=0D=0A>>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0__entry->nr_congested,=20__entry->nr_immediate,=0D=0A>>=20+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->nr_act=
ivate0,=20__entry->nr_activate1,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0__entry->nr_ref_keep,=20__entry->=
nr_unmap_fail)=0D=0A>>=20+);=0D=0A>>=20+=0D=0A>>=C2=A0=20TRACE_EVENT(mm_vms=
can_lru_shrink_inactive,=0D=0A>>=C2=A0=20=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0TP_PROTO(int=20nid,=0D=0A>>=20diff=20--git=20a/mm/vmsc=
an.c=20b/mm/vmscan.c=0D=0A>>=20index=20749cdc110c74..0c2c36bf4c5a=20100644=
=0D=0A>>=20---=20a/mm/vmscan.c=0D=0A>>=20+++=20b/mm/vmscan.c=0D=0A>>=20=40=
=40=20-2126,9=20+2126,10=20=40=40=20static=20void=20shrink_active_list(unsi=
gned=20long=20nr_to_scan,=0D=0A>>=C2=A0=20=7D=0D=0A>>=C2=A0=20=0D=0A>>=C2=
=A0=20static=20unsigned=20int=20reclaim_folio_list(struct=20list_head=20*fo=
lio_list,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20unsigned=20int=20nr_scanned,=0D=
=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20struct=20pglist_data=20*pgdat)=0D=0A>>=
=C2=A0=20=7B=0D=0A>>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20reclai=
m_stat=20dummy_stat;=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=
=20reclaim_stat=20stat;=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0unsigned=20int=20nr_reclaimed;=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0struct=20folio=20*folio;=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0struct=20scan_control=20sc=20=3D=20=7B=0D=0A>>=20=40=40=20-2=
139,12=20+2140,13=20=40=40=20static=20unsigned=20int=20reclaim_folio_list(s=
truct=20list_head=20*folio_list,=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0.no_demotion=20=3D=201,=0D=
=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D;=0D=0A>>=C2=A0=20=0D=
=0A>>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0nr_reclaimed=20=3D=20shrink_fo=
lio_list(folio_list,=20pgdat,=20&sc,=20&dummy_stat,=20true);=0D=0A>>=20+=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0nr_reclaimed=20=3D=20shrink_folio_list(fol=
io_list,=20pgdat,=20&sc,=20&stat,=20true);=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0while=20(=21list_empty(folio_list))=20=7B=0D=0A>>=C2=
=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0folio=20=3D=20lru_to_folio(folio_list);=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0list_del(&folio->l=
ru);=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0folio_putback_lru(folio);=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=7D=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0tra=
ce_mm_vmscan_reclaim_pages(pgdat->node_id,=20nr_scanned,=20nr_reclaimed,=20=
&stat);=0D=0A>=0D=0A>Why=20is=20the=20new=20calculation=20of=20nr_scanned=
=20needed?=20Could=20you=20just=20take=20a=20delta=0D=0A>of=20sc->nr_scanne=
d,=20i.e.=20after=20-=20before=20calling=20shrink_folio_list()=20?=0D=0A=0D=
=0AOh=20correct.=20=0D=0A=0D=0AExcept=20the=20case=20of=20(=21folio_trylock=
(folio)),=20shrink_folio_list=20would=20count=20on=20sc->nr_scanned.=0D=0AI=
=20don't=20understand=20why=20we=20do=20not=20count=20this=20lock=20case=20=
though.=0D=0A=0D=0ALet=20me=20try=20to=20change=20as=20you=20suggested.=0D=
=0AI=20think=20without=20'after=20-=20before',=20we=20can=20just=20use=20sc=
->nr_scanned=20after=20shrink_folio_list.=0D=0A=0D=0AThank=20you=0D=0A=0D=
=0A>=0D=0A>>=C2=A0=20=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0r=
eturn=20nr_reclaimed;=0D=0A>>=C2=A0=20=7D=0D=0A>>=20=40=40=20-2152,6=20+215=
4,7=20=40=40=20static=20unsigned=20int=20reclaim_folio_list(struct=20list_h=
ead=20*folio_list,=0D=0A>>=C2=A0=20unsigned=20long=20reclaim_pages(struct=
=20list_head=20*folio_list)=0D=0A>>=C2=A0=20=7B=0D=0A>>=C2=A0=20=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0int=20nid;=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0unsigned=20int=20nr_scanned=20=3D=200;=0D=0A>>=C2=A0=20=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0unsigned=20int=20nr_reclaimed=20=3D=200;=0D=
=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0LIST_HEAD(node_folio_list=
);=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0unsigned=20int=20nor=
eclaim_flag;=0D=0A>>=20=40=40=20-2168,15=20+2171,18=20=40=40=20unsigned=20l=
ong=20reclaim_pages(struct=20list_head=20*folio_list)=0D=0A>>=C2=A0=20=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(=
nid=20=3D=3D=20folio_nid(folio))=20=7B=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0folio_clear_active(folio);=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0list_move(&folio->lru,=20&node_folio_list);=0D=0A>>=20+=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0nr_scanned=20+=3D=20folio_nr_pages(folio);=
=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0continue;=0D=0A>>=C2=A0=
=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=7D=0D=0A>>=C2=A0=20=0D=0A>>=20-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0nr_reclaimed=20+=3D=20reclaim_folio_list(&nod=
e_folio_list,=20NODE_DATA(nid));=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0nr_reclaimed=20+=3D=20reclaim_fol=
io_list(&node_folio_list,=20nr_scanned,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=20NODE_DATA(nid));=0D=
=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0nr_scanned=20=3D=200;=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0nid=20=3D=20folio_nid(lru_to_foli=
o(folio_list));=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=7D=20w=
hile=20(=21list_empty(folio_list));=0D=0A>>=C2=A0=20=0D=0A>>=20-=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0nr_reclaimed=20+=3D=20reclaim_folio_list(&node_f=
olio_list,=20NODE_DATA(nid));=0D=0A>>=20-=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0nr_reclaimed=20+=3D=20reclaim_folio_list(&node_folio_list,=
=20nr_scanned,=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=C2=A0=20=20NODE_D=
ATA(nid));=0D=0A>>=C2=A0=20=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0memalloc_nor=
eclaim_restore(noreclaim_flag);=0D=0A>>=C2=A0=20=0D=0A>>=C2=A0=20=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0return=20nr_reclaimed;=0D=0A>

