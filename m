Return-Path: <linux-kernel+bounces-184393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0BB8CA666
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C64BB216DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F86ED520;
	Tue, 21 May 2024 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NIjW9hxV"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E6CA40
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260015; cv=none; b=FX9awHfa6WQq2Ss8gSM972c4D0x7uHxW2s7Wvs6orH2NXWX2A0jGscpSHlcL09ftCAGVmF7RoJ2ghDVQyWwPbrFr/j0D5WDtCQxcrab/r4aveB+mZLqZKlxIEwD2M+lO0BHh0ApRwFi4rW6ggz65BwWxct0d1+uS4QI84SIe07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260015; c=relaxed/simple;
	bh=MB+TtiSD6Cd1t17tquKgP8i2c8ExALiwPjCgQVMlpiM=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=pDB352SH6nlFzcTRy6kU24e7qA/PYnmQ44qZ73QiiqYQ5FHP1p+8KV5sMBrrNew6gi3QOvmwb98C9KTo7mAVp/EgrcSP9ATPnHHQ0BDdqrxdJ0NpZolDH0smfdz1XO50/GY1FbVnvt+t2Gukppdf36iwkG9M/4jTKCHPW1fdjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NIjW9hxV; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240521025330epoutp038b6fc59c9ff1b27ecfc1b085e8b3a671~RYWMHorD72163121631epoutp03h
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:53:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240521025330epoutp038b6fc59c9ff1b27ecfc1b085e8b3a671~RYWMHorD72163121631epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716260011;
	bh=MB+TtiSD6Cd1t17tquKgP8i2c8ExALiwPjCgQVMlpiM=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=NIjW9hxVJUQh32TV/axNgXlUf0mHqcmXVZO+VEh6g7yp+ymwXH0E/Ehiy4jt56kDk
	 oeLXQxupTGr1R6vQ5s4w4mNhYfZGiTE4m1Ef2gdJJDFr1OmhZFKIpzsXUhU4gy8XQ1
	 5m4gvPnG/OfhDbcy1eKJdiTDrxwSepTzU15MY9yo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240521025330epcas1p2a345947c7794f54f0801b14f7d44500e~RYWLuGQMQ1275512755epcas1p2B;
	Tue, 21 May 2024 02:53:30 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VjzXB09m4z4x9Pp; Tue, 21 May
	2024 02:53:30 +0000 (GMT)
X-AuditID: b6c32a38-b41fa700000027ae-44-664c0ca93284
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.25.10158.9AC0C466; Tue, 21 May 2024 11:53:29 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: Jaewon Kim <jaewon31.kim@samsung.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>, "tkjos@google.com"
	<tkjos@google.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
Date: Tue, 21 May 2024 11:53:29 +0900
X-CMS-MailID: 20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmvu5KHp80g9XrrCzmrF/DZvHykKZF
	9+aZjBa9718xWVzeNYfN4t6a/6wWR9ZvZ7J4P7nYYnZjH6MDp8fOWXfZPRZsKvXYtKqTzWPT
	p0nsHidm/Gbx6NuyitHjzIIj7B6fN8kFcERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
	6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
	KTAr0CtOzC0uzUvXy0stsTI0MDAyBSpMyM64evcIe8E/tYo9l1+wNTB+V+1i5OSQEDCR+NT/
	mrWLkYtDSGAHo8Sb1+eYuhg5OHgFBCX+7hAGqREWCJeYs38VE4gtJKAkcfbHFXaIuK5EU/dq
	FhCbTUBb4v2CSWBzRATWMUo0t55iAXGYBc4wSry/vIsFYhuvxIz2p1C2tMT25VsZQWxOAQeJ
	+VMWs0PERSVurn4LZ78/Np8RwhaRaL13lhnCFpR48HM3I8ycP8efs0HYxRLLOh8wQdg1EivO
	rYKKm0s0vF0JZvMK+EosaPsPVsMioCrR/fMTVI2LxMq5G8D2MgN9s2zha2ZQQDALaEqs36UP
	EeaTePe1hxXmlYaNv9mxsXfMewJ1gppEy7OvUPUyEn//PYOyPSTuXtvNMoFRcRYiqGchWTwL
	YfECRuZVjGKpBcW56anFhgUm8NhNzs/dxAhOqFoWOxjnvv2gd4iRiYPxEKMEB7OSCO+mLZ5p
	QrwpiZVVqUX58UWlOanFhxhNgV6eyCwlmpwPTOl5JfGGJpYGJmZGJhbGlsZmSuK8Z66UpQoJ
	pCeWpGanphakFsH0MXFwSjUwlah94y1zWmtmPVVyyf7KBAWjzmluald5bmR5f5kUu08sXvf2
	R9YXChc0T4trG25baM/KbMn+2/mSxwHvhPLk5tmHVBlKXiu4p5/mCX296ObGw/+YdlWsv8O0
	XCtOLuANzxXzfVOS3hT7/nvTeUbjtZHKlLeKn3tcby9f9i9Dy6BoptHc3Yt3v6ya9VqUJenl
	FmvvL5Zx+m/TX6etFH8W3HTxW/Y749XlmYL8819+iP+xuODOsmzxv0f73Mo+rLDtC+tLP5Sn
	dmCO0vlJUwI36WifPt+16L1J3fuDU/iu6grmTJ1sdzSGaZbr08YTtX0TQt4d2DbTiZHr07N9
	p+a8D+nZ8WzOt66CvS29G2zSbiixFGckGmoxFxUnAgDFa8dbMQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p6>

>--------- Original Message ---------
>Sender : =EA=B9=80=EC=9E=AC=EC=9B=90=20<jaewon31.kim=40samsung.com>System=
=20Performance=20Lab.(MX)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=0D=0A>Date=
=20=20=20:=202024-05-21=2011:40=20(GMT+9)=0D=0A>Title=20=20:=20=5BRESEND=20=
PATCH=2000/10=5D=20memblock:=20introduce=20memsize=20showing=20reserved=20m=
emory=0D=0A>?=0D=0A>Some=20of=20memory=20regions=20can=20be=20reserved=20fo=
r=20a=20specific=20purpose.=20They=20are=0D=0A>usually=20defined=20through=
=20reserved-memory=20in=20device=20tree.=20If=20only=20size=0D=0A>without=
=20address=20is=20specified=20in=20device=20tree,=20the=20address=20of=20th=
e=20region=0D=0A>will=20be=20determined=20at=20boot=20time.=0D=0A>=0D=0A>We=
=20may=20find=20the=20address=20of=20the=20memory=20regions=20through=20boo=
ting=20log,=20but=0D=0A>it=20does=20not=20show=20all.=20And=20it=20could=20=
be=20hard=20to=20catch=20the=20very=20beginning=0D=0A>log.=20The=20memblock=
_dump_all=20shows=20all=20memblock=20status=20but=20it=20does=20not=0D=0A>s=
how=20region=20name=20and=20its=20information=20is=20difficult=20to=20summa=
rize.=0D=0A>=0D=0A>This=20patch=20introduce=20a=20debugfs=20node,=20membloc=
k/memsize,=20to=20see=20reserved=0D=0A>memory=20easily.=0D=0A>=0D=0A>Here's=
=20an=20example=0D=0A>=0D=0A>=24=20cat=20debugfs/memblock/memsize=0D=0A>=0D=
=0A>0x0000000000000000-0x0000000000000000=200x02000000=20(?=20=2032768=20KB=
=20)?=20=20map=20reusable=20linux,cma=0D=0A>0x0000000000000000-0x0000000000=
000000=200x01000000=20(?=20=2016384=20KB=20)?=20=20map=20reusable=20vxxxxx=
=0D=0A>...=0D=0A>0x0000000000000000-0x0000000000000000=200x004e0000=20(?=20=
?=204992=20KB=20)=20nomap=20unusable=20unknown=0D=0A>0x0000000000000000-0x0=
000000000000000=200x00400000=20(?=20?=204096=20KB=20)=20nomap=20unusable=20=
cxxxxx=0D=0A>0x0000000000000000-0x0000000000000000=200x00e00000=20(?=20=201=
4336=20KB=20)=20nomap=20unusable=20gxxxxx=0D=0A>=0D=0A>Reserved?=20?=20:=20=
1223856=20KB=0D=0A>=20.kernel?=20?=20:?=20275208=20KB=0D=0A>?=20.text?=20?=
=20=20:?=20=2016576=20KB=0D=0A>?=20.rwdata?=20=20:?=20?=201963=20KB=0D=0A>?=
=20.rodata?=20=20:?=20=2011920=20KB=0D=0A>?=20.bss?=20?=20?=20:?=20?=202450=
=20KB=0D=0A>?=20.memmap?=20=20:?=20186368=20KB=0D=0A>?=20.etc?=20?=20?=20:?=
=20=2055933=20KB=0D=0A>=20.unusable?=20:?=20948648=20KB=0D=0A>System?=20?=
=20?=20:=2011359056=20KB=0D=0A>=20.common?=20?=20:=2010306384=20KB=0D=0A>=
=20.reusable?=20:=201052672=20KB=0D=0A>Total?=20?=20?=20=20:=2012582912=20K=
B=20(=2012288.00=20MB=20)=0D=0A>=0D=0A>Jaewon=20Kim=20(10):=0D=0A>?=20membl=
ock:=20introduce=20memsize=20showing=20reserved=20memory=0D=0A>?=20memblock=
:=20detect=20hidden=20memory=20hole=20size=0D=0A>?=20memblock:=20handle=20o=
verlapped=20reserved=20memory=20region=0D=0A>?=20memblock:=20take=20a=20reg=
ion=20intersecting=20an=20unknown=20region=0D=0A>?=20memblock:=20track=20me=
mblock=20changed=20at=20early=20param=0D=0A>?=20memblock:=20recognize=20lat=
e=20freed=20size=20by=20checking=20PageReserved=0D=0A>?=20memblock:=20track=
=20kernel=20size=20on=20memsize=0D=0A>?=20memblock:=20print=20memsize=20sum=
mary=20information=0D=0A>?=20memblock:=20print=20kernel=20internal=20size=
=0D=0A>?=20memblock:=20support=20memsize=20reusable=20to=20consider=20as=20=
reusable=0D=0A>=0D=0A>=20drivers/of/fdt.c?=20?=20?=20?=20?=20?=20=20=7C?=20=
11=20+=0D=0A>=20drivers/of/of_reserved_mem.c=20=7C?=2012=20+-=0D=0A>=20incl=
ude/linux/memblock.h?=20?=20=20=7C?=2029=20++=0D=0A>=20init/main.c?=20?=20?=
=20?=20?=20?=20?=20?=20?=20=7C?=2013=20+-=0D=0A>=20kernel/dma/contiguous.c?=
=20?=20?=20=7C?=20=209=20+-=0D=0A>=20mm/Kconfig?=20?=20?=20?=20?=20?=20?=20=
?=20?=20=20=7C?=2016=20++=0D=0A>=20mm/memblock.c?=20?=20?=20?=20?=20?=20?=
=20?=20=7C=20502=20++++++++++++++++++++++++++++++++++-=0D=0A>=20mm/mm_init.=
c?=20?=20?=20?=20?=20?=20?=20?=20=20=7C?=20=206=20+-=0D=0A>=20mm/page_alloc=
c?=20?=20?=20?=20?=20?=20?=20=7C?=2010=20+-=0D=0A>=209=20files=20changed,=
=20597=20insertions(+),=2011=20deletions(-)=0D=0A>=0D=0A>--=20=0D=0A>2.25.1=
=0D=0A=0D=0AHello=20Mike=20=0D=0A=0D=0AThis=20is=20actually=20RESEND=20as=
=20it=20was=20introduced=202=20years=20ago.=0D=0APlease=20refer=20to=20http=
s://lore.kernel.org/linux-mm/YkQB6Ah603yPR3qf=40kernel.org/=23t=0D=0A=0D=0A=
>=20But=20you=20never=20provided=20details=20about=20*why*=20you=20want=20t=
his=20information=20exposed.=0D=0A=0D=0AFor=20your=20question,=20I'd=20like=
=20to=20say=20;=0D=0AWe=20can=20see=20the=20same=20format=20and=20exact=20i=
nformation=20between=20different=20version=20of=20kernel=20status.=0D=0A=0D=
=0A1)=20Internally=20we=20can=20check=20if=20the=20reserved=20memory=20chan=
ges.=0D=0A2)=20Externally=20we=20can=20communicate=20between=20chipset=20ve=
ndors=20and=20OEM,=20with=20a=20same=20format.=0D=0A=0D=0AThis=20helps=20us=
=20to=20communitcate=20well,=20to=20easily=20detect=20changes=20or=20just=
=20to=20see=20differences.=0D=0A=0D=0AJaewon=20Kim=0D=0A

