Return-Path: <linux-kernel+bounces-184797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B53D8CAC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111E9280A07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDE73182;
	Tue, 21 May 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gJP93wTF"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2C76CDD8
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286682; cv=none; b=Dt6Lm/MA11JC8mObbhGvVZmnBaEBWXTIcPMcvzlALRf9KqCYEMzjuKYZ030Ac02Iu83J/n8jWkGXOkFR71ACCDRqUgs/kedWJlcoRWgfVEp5uZS6JFoAM+Uj+ZzQY4c1GYNMG277ZuTrjW+Rwz3BDfBYwL3abahX1hPJgnhnE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286682; c=relaxed/simple;
	bh=xNtfwsLj+AXhnT99jVhXBY0LB5g4T+lW3lcoU9wKeIQ=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=fERx/XpbIboLGUENWRhVXON66v/LNSDeC4wUX6QNUdbqyEtZna/+e029xuq3IKT4bxEqQWRoyLZzWF8ERMlfQ6lWxWKi+ziMKY/ziMOcuSXePO8QHaF/H8o0jc85LbrlJvbGGVuuYvlPVaY8ZhU7/2k320rUQ7SRTPqsXpB1T2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gJP93wTF; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240521101755epoutp01fdad356112021897e4afbad2580adb46~ReaNZxu680206902069epoutp01T
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:17:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240521101755epoutp01fdad356112021897e4afbad2580adb46~ReaNZxu680206902069epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716286675;
	bh=xNtfwsLj+AXhnT99jVhXBY0LB5g4T+lW3lcoU9wKeIQ=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=gJP93wTFQKdJyt38z2Vk87Yi3LnQrQcgoWMnByvx/qrgY8o61OaH7dThz7D7rPV89
	 XKsL5+hNFYPeS5REZxA1C1ZcqCZrUiMTZSX/jUH+VoG5YIejwsZuB3J/EOdtzz/Rmo
	 L14D+0wL9A+n9hDqrQA1/Wdn98yH9tXhZIYRVa1I=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240521101754epcas1p4faba0848f97da16868486c58b9039450~ReaMVjLtI0862408624epcas1p4q;
	Tue, 21 May 2024 10:17:54 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.223]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Vk9Ny04Pzz4x9Py; Tue, 21 May
	2024 10:17:54 +0000 (GMT)
X-AuditID: b6c32a35-053ff700000025be-ab-664c74d14045
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FA.1F.09662.1D47C466; Tue, 21 May 2024 19:17:53 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: Mike Rapoport <rppt@kernel.org>, Jaewon Kim <jaewon31.kim@samsung.com>
CC: "vbabka@suse.cz" <vbabka@suse.cz>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>, "tkjos@google.com"
	<tkjos@google.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZkxN0yQ7Fb0X26hT@kernel.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
Date: Tue, 21 May 2024 19:17:53 +0900
X-CMS-MailID: 20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmnu7FEp80g5u9xhZz1q9hs3h5SNOi
	e/NMRove96+YLC7vmsNmcW/Nf1aLI+u3M1m8n1xsMbuxj9GB02PnrLvsHgs2lXpsWtXJ5rHp
	0yR2jxMzfrN49G1ZxehxZsERdo/Pm+QCOKKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
	dQ0tLcyVFPISc1NtlVx8AnTdMnOAjlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
	FJgV6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdsPbWYvWCNQcX5GTtZGxh/6nUxcnJICJhIrGzu
	Y+1i5OIQEtjBKHH530a2LkYODl4BQYm/O4RBaoQFoiQuzD7FBmILCShJnP1xhR0irivR1L2a
	BcRmE9CWeL9gEitIq4iAl8Sdtx4gI5kFVjFJ9Ld3M0Ls4pWY0f6UBcKWlti+fCtYnFNAS+Lk
	3VZmiLioxM3Vb9lh7PfH5kP1iki03jsLVSMo8eDnbkaYOX+OP2eDsIsllnU+YIKwayRWnFsF
	FTeXaHi7EszmFfCVmPLwOtgcFgFViZZjZ6HqXSR+nd8FtpcZ6JdlC18zg/zCLKApsX6XPkSY
	T+Ld1x5WmFcaNv5mx8beMe8J1Eg1iZZnX6HqZST+/nsGZXtI3L22m2UCo+IsREDPQrJ4FsLi
	BYzMqxjFUguKc9NTiw0LDOFxm5yfu4kRnEy1THcwTnz7Qe8QIxMH4yFGCQ5mJRHeTVs804R4
	UxIrq1KL8uOLSnNSiw8xmgK9PJFZSjQ5H5jO80riDU0sDUzMjEwsjC2NzZTEec9cKUsVEkhP
	LEnNTk0tSC2C6WPi4JRqYLJdqVp/zKN2c7LKv6abt2/LqjtlHLObMOFLY4CKCbeee63cyisL
	p31bmrQm8K2X9751csHBu+b6nrkRe1Jj7fxg89j23V/mRWtIBdyd8Gu78uNZgmwrzq0ujtq9
	9LOkws+A39t6Mn9e3OeTV8NWXexwIlBzqfWNjJBF/GpZxgdZenUOLjgtObHkwvngNbOlTzeu
	/vpC/2PZ/p4weR/D05M3/jWTPPlMW+a90t03ndsnKx/WDBA7skTHwCtkuWV4g7XcJV+nCfed
	p1/fZ3ng8sKjWjviWd1kvm+7399spXq5v/bQ2+qlpy4qxTDorlCe+mmx2pz8dK96ZWcG/x19
	pm3fbq206dyWmSfxz3nmsQtKLMUZiYZazEXFiQCB18uOLwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76
References: <ZkxN0yQ7Fb0X26hT@kernel.org>
	<20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
	<CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p5>

>On Tue, May 21, 2024 at 11:53:29AM +0900, Jaewon Kim wrote:
>> >--------- Original Message ---------
>> >Sender : =EA=B9=80=EC=9E=AC=EC=9B=90=20<jaewon31.kim=40samsung.com>Syst=
em=20Performance=20Lab.(MX)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=0D=0A>>=20=
>Date=20=20=20:=202024-05-21=2011:40=20(GMT+9)=0D=0A>>=20>Title=20=20:=20=
=5BRESEND=20PATCH=2000/10=5D=20memblock:=20introduce=20memsize=20showing=20=
reserved=20memory=0D=0A>>=20>?=0D=0A>>=20>Some=20of=20memory=20regions=20ca=
n=20be=20reserved=20for=20a=20specific=20purpose.=20They=20are=0D=0A>>=20>u=
sually=20defined=20through=20reserved-memory=20in=20device=20tree.=20If=20o=
nly=20size=0D=0A>>=20>without=20address=20is=20specified=20in=20device=20tr=
ee,=20the=20address=20of=20the=20region=0D=0A>>=20>will=20be=20determined=
=20at=20boot=20time.=0D=0A>>=20>=0D=0A>>=20>We=20may=20find=20the=20address=
=20of=20the=20memory=20regions=20through=20booting=20log,=20but=0D=0A>>=20>=
it=20does=20not=20show=20all.=20And=20it=20could=20be=20hard=20to=20catch=
=20the=20very=20beginning=0D=0A>>=20>log.=20The=20memblock_dump_all=20shows=
=20all=20memblock=20status=20but=20it=20does=20not=0D=0A>>=20>show=20region=
=20name=20and=20its=20information=20is=20difficult=20to=20summarize.=0D=0A>=
>=20>=0D=0A>>=20>This=20patch=20introduce=20a=20debugfs=20node,=20memblock/=
memsize,=20to=20see=20reserved=0D=0A>>=20>memory=20easily.=0D=0A>>=20>=0D=
=0A>>=20>Here's=20an=20example=0D=0A>>=20>=0D=0A>>=20>=24=20cat=20debugfs/m=
emblock/memsize=0D=0A>>=20>=0D=0A>>=20>0x0000000000000000-0x000000000000000=
0=200x02000000=20(?=20=2032768=20KB=20)?=20=20map=20reusable=20linux,cma=0D=
=0A>>=20>0x0000000000000000-0x0000000000000000=200x01000000=20(?=20=2016384=
=20KB=20)?=20=20map=20reusable=20vxxxxx=0D=0A>>=20>...=0D=0A>>=20>0x0000000=
000000000-0x0000000000000000=200x004e0000=20(?=20?=204992=20KB=20)=20nomap=
=20unusable=20unknown=0D=0A>>=20>0x0000000000000000-0x0000000000000000=200x=
00400000=20(?=20?=204096=20KB=20)=20nomap=20unusable=20cxxxxx=0D=0A>>=20>0x=
0000000000000000-0x0000000000000000=200x00e00000=20(?=20=2014336=20KB=20)=
=20nomap=20unusable=20gxxxxx=0D=0A>>=20>=0D=0A>>=20>Reserved?=20?=20:=20122=
3856=20KB=0D=0A>>=20>=20.kernel?=20?=20:?=20275208=20KB=0D=0A>>=20>?=20.tex=
t?=20?=20=20:?=20=2016576=20KB=0D=0A>>=20>?=20.rwdata?=20=20:?=20?=201963=
=20KB=0D=0A>>=20>?=20.rodata?=20=20:?=20=2011920=20KB=0D=0A>>=20>?=20.bss?=
=20?=20?=20:?=20?=202450=20KB=0D=0A>>=20>?=20.memmap?=20=20:?=20186368=20KB=
=0D=0A>>=20>?=20.etc?=20?=20?=20:?=20=2055933=20KB=0D=0A>>=20>=20.unusable?=
=20:?=20948648=20KB=0D=0A>>=20>System?=20?=20?=20:=2011359056=20KB=0D=0A>>=
=20>=20.common?=20?=20:=2010306384=20KB=0D=0A>>=20>=20.reusable?=20:=201052=
672=20KB=0D=0A>>=20>Total?=20?=20?=20=20:=2012582912=20KB=20(=2012288.00=20=
MB=20)=0D=0A>>=20>=0D=0A>>=20>Jaewon=20Kim=20(10):=0D=0A>>=20>?=20memblock:=
=20introduce=20memsize=20showing=20reserved=20memory=0D=0A>>=20>?=20membloc=
k:=20detect=20hidden=20memory=20hole=20size=0D=0A>>=20>?=20memblock:=20hand=
le=20overlapped=20reserved=20memory=20region=0D=0A>>=20>?=20memblock:=20tak=
e=20a=20region=20intersecting=20an=20unknown=20region=0D=0A>>=20>?=20memblo=
ck:=20track=20memblock=20changed=20at=20early=20param=0D=0A>>=20>?=20memblo=
ck:=20recognize=20late=20freed=20size=20by=20checking=20PageReserved=0D=0A>=
>=20>?=20memblock:=20track=20kernel=20size=20on=20memsize=0D=0A>>=20>?=20me=
mblock:=20print=20memsize=20summary=20information=0D=0A>>=20>?=20memblock:=
=20print=20kernel=20internal=20size=0D=0A>>=20>?=20memblock:=20support=20me=
msize=20reusable=20to=20consider=20as=20reusable=0D=0A>>=20>=0D=0A>>=20>=20=
drivers/of/fdt.c?=20?=20?=20?=20?=20?=20=20=7C?=2011=20+=0D=0A>>=20>=20driv=
ers/of/of_reserved_mem.c=20=7C?=2012=20+-=0D=0A>>=20>=20include/linux/membl=
ock.h?=20?=20=20=7C?=2029=20++=0D=0A>>=20>=20init/main.c?=20?=20?=20?=20?=
=20?=20?=20?=20?=20=7C?=2013=20+-=0D=0A>>=20>=20kernel/dma/contiguous.c?=20=
?=20?=20=7C?=20=209=20+-=0D=0A>>=20>=20mm/Kconfig?=20?=20?=20?=20?=20?=20?=
=20?=20?=20=20=7C?=2016=20++=0D=0A>>=20>=20mm/memblock.c?=20?=20?=20?=20?=
=20?=20?=20?=20=7C=20502=20++++++++++++++++++++++++++++++++++-=0D=0A>>=20>=
=20mm/mm_init.c?=20?=20?=20?=20?=20?=20?=20?=20=20=7C?=20=206=20+-=0D=0A>>=
=20>=20mm/page_alloc.c?=20?=20?=20?=20?=20?=20?=20=7C?=2010=20+-=0D=0A>>=20=
>=209=20files=20changed,=20597=20insertions(+),=2011=20deletions(-)=0D=0A>>=
=20>=0D=0A>>=20>--=20=0D=0A>>=20>2.25.1=0D=0A>>=20=0D=0A>>=20Hello=20Mike=
=20=0D=0A>>=20=0D=0A>>=20This=20is=20actually=20RESEND=20as=20it=20was=20in=
troduced=202=20years=20ago.=0D=0A>>=20Please=20refer=20to=20https://lore.ke=
rnel.org/linux-mm/YkQB6Ah603yPR3qf=40kernel.org/=23t=0D=0A>>=20=0D=0A>>=20>=
=20But=20you=20never=20provided=20details=20about=20*why*=20you=20want=20th=
is=20information=20exposed.=0D=0A>>=20=0D=0A>>=20For=20your=20question,=20I=
'd=20like=20to=20say=20;=0D=0A>>=20We=20can=20see=20the=20same=20format=20a=
nd=20exact=20information=20between=20different=20version=20of=20kernel=20st=
atus.=0D=0A>>=20=0D=0A>>=201)=20Internally=20we=20can=20check=20if=20the=20=
reserved=20memory=20changes.=0D=0A>>=202)=20Externally=20we=20can=20communi=
cate=20between=20chipset=20vendors=20and=20OEM,=20with=20a=20same=20format.=
=0D=0A>=0D=0A>Why=20the=20existing=20debugfs=20interface=20is=20not=20suffi=
cient?=0D=0A=0D=0Adebugfs/memblock/memory=20&=20debugfs/memblock/reserved=
=20have=20changed=20its=20format=20but=20still=20does=20not=20show=20name,=
=20reusable,=20kernel=20size.=0D=0AIf=20memory=20is=20reserved=20from=20mem=
block,=20and=20did=20not=20freed=20back=20to=20memblock.=20Memblock=20does=
=20not=20know=20even=20after=20the=20memory=20is=20freed=20to=20system.=0D=
=0AI=20think=20a=20simple=20debug=20interface=20is=20needed=20to=20easily=
=20communicate=20with=20others=20or=20compare=20different=20SW=20releases.=
=0D=0A=0D=0A>=20=0D=0A>>=20This=20helps=20us=20to=20communitcate=20well,=20=
to=20easily=20detect=20changes=20or=20just=20to=20see=20differences.=0D=0A>=
>=20=0D=0A>>=20Jaewon=20Kim=0D=0A>>=20=0D=0A>=0D=0A>--=20=0D=0A>Sincerely=
=20yours,=0D=0A>Mike.=0D=0A=0D=0A

