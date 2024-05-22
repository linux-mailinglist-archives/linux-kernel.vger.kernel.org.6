Return-Path: <linux-kernel+bounces-185949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CAA8CBD32
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B43282B70
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD480039;
	Wed, 22 May 2024 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pUzlynIf"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637752F7A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367664; cv=none; b=PbHRlz8fmIC7XHQQXJvEW7sDHpiCU+16FA3F49nd//J9H036lQ6WJ8MjDrQPDeiVOuYMuoSNbfSc2rYBeNxxxJVXhuTOqO6Hd1xi/T3rwG/BOR8W4Iujpcw3n4sqB9ZQb78w/Cy+7/XItGvFPFpoIZw0PG2vGzfXCvX6lDGidAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367664; c=relaxed/simple;
	bh=50VXnMxJSNkPmkgscx0DHxvrGAkH/2hNhQErC44Hgew=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=lVmYmthz4MiERn+pU4SNcYlJZ5vRmmZXqGFvZOqWI+LNVZ1pu9ZlMkGIrdKf7/2lSDkTGPZ4hOW7REEsqLpEhVK5gP87Nz2I+uHgJMglNTpUBmenXXyKdAMUAlIlmb+HElc7B/9vDlECrvew4W5VjHSv9a8CM596EUTMshj7JEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pUzlynIf; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240522084739epoutp02d5accdc8be1f6e2d6c42edbb367804c8~Rw0rfIztL0265802658epoutp02U
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:47:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240522084739epoutp02d5accdc8be1f6e2d6c42edbb367804c8~Rw0rfIztL0265802658epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716367659;
	bh=sApdrTDcxJLh0HLqv5y8ADHj/I20cdtvXEXkLtEjN0g=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=pUzlynIfCQulHOwhCS6U0bS2kw3/eUmJpIiC6ZNUAZFWXwniFqPvTBAiTtzPcTdkC
	 U1qAgOhOZpA3KRVmmGHZsCkSSW0KdqHYrS590OraYhl07/Fvo9MxmNghzqVzZ71iwH
	 27eaGHfOZBW5gmEcZ7bOMPV/7bMjFc171adxmOZ4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240522084738epcas1p4713c0abfa4742bbe63c044a18340781e~Rw0rDtVlH2790827908epcas1p4N;
	Wed, 22 May 2024 08:47:38 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.241]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VklLL3Xccz4x9Q2; Wed, 22 May
	2024 08:47:38 +0000 (GMT)
X-AuditID: b6c32a38-164c8a80000027ae-2d-664db12a8290
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.1F.10158.A21BD466; Wed, 22 May 2024 17:47:38 +0900 (KST)
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
To: "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, Jaewon Kim
	<jaewon31.kim@samsung.com>
CC: Mike Rapoport <rppt@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jaewon31.kim@gmail.com"
	<jaewon31.kim@gmail.com>, "tkjos@google.com" <tkjos@google.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240522081647.zlwenenrbrjemlp6@master>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240522084738epcms1p80845ffecee4fbab97b34fdf2ce1595a7@epcms1p8>
Date: Wed, 22 May 2024 17:47:38 +0900
X-CMS-MailID: 20240522084738epcms1p80845ffecee4fbab97b34fdf2ce1595a7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmrq7WRt80g7vNUhZz1q9hs3h5SNOi
	e/NMRove96+YLC7vmsNmcW/Nf1aLO32vWCyOrN/OZPF+crHF7MY+Rgcuj52z7rJ7LNhU6rFp
	VSebx6ZPk9g9Tsz4zeLRt2UVo8eZBUfYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53
	jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6UEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
	q5RakJJTYFagV5yYW1yal66Xl1piZWhgYGQKVJiQnfHv/wSWgic+FaeWbmZrYFzj1cXIySEh
	YCIxY+I1pi5GLg4hgR2MEg/b57J2MXJw8AoISvzdIQxSIywQLjFn/yomEFtIQEni7I8r7BBx
	XYmm7tUsIDabgLbE+wWTWEFsEYEUidZFh9lBZjILnGaS2PXpOgvEMl6JGe1PoWxpie3LtzKC
	2JwCphLn/76EiotK3Fz9lh3Gfn9sPiOELSLReu8sM4QtKPHg525GmDl/jj9ng7CLJZZ1PmCC
	sGskVpxbBRU3l2h4uxLM5hXwlfjf1w1WwyKgKrFs+yKoXS4S3Xv2gsWZgZ5ZtvA1MygcmAU0
	Jdbv0ocI80m8+9rDCvNKw8bf7NjYO+Y9gTpBTaLl2VeoehmJv/+eQdkeEnev7WaZwKg4CxHS
	s5AsnoWweAEj8ypGsdSC4tz01GLDAhN45Cbn525iBCdWLYsdjHPfftA7xMjEwXiIUYKDWUmE
	N3qlb5oQb0piZVVqUX58UWlOavEhRlOglycyS4km5wNTe15JvKGJpYGJmZGJhbGlsZmSOO+Z
	K2WpQgLpiSWp2ampBalFMH1MHJxSDUwWF2X8Tu6N81h5qlmpuMMg5qjq2vnMGvmtns7rmVUe
	ZKjNiFx95MYCho8h+fUhNa8LHFb0C8SoJLSV656syawPVZ0wK1+w4HOIQ3heoK+M/jfv78LT
	TqyNaes+O2kJo3LqpsjZ/GzPEmY7Rnsc/fzc6EQX14HlLxU8YyS9D1UfkvcUf3rEv1Yg+ACb
	lO7VnE8CFf88+j1mZvS4XL3O5Gt+vY+1aPX1QJcZyRs0HH7GTHzB+OHInFcfM2TYu5TnTJp/
	UXDy8b6zbayRm/e23LjcfcfiziUTvoay8q1N/0pyb08zEJ+x5FOoavkGR/cWK9tvcZUvz8SH
	XNaaXvvl5hL15RbN1rkti2fcu/D0oRJLcUaioRZzUXEiAFbV2j01BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76
References: <20240522081647.zlwenenrbrjemlp6@master>
	<ZkxN0yQ7Fb0X26hT@kernel.org>
	<20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
	<20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
	<CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p8>

>Sender : Wei Yang <richard.weiyang=40gmail.com>
>Date   : 2024-05-22 17:16 (GMT+9)
>Title  : Re: (2) =5BRESEND PATCH 00/10=5D memblock: introduce memsize show=
ing reserved memory
>?
>On Tue, May 21, 2024 at 07:17:53PM +0900, Jaewon Kim wrote:
>>>On Tue, May 21, 2024 at 11:53:29AM +0900, Jaewon Kim wrote:
>>>> >--------- Original Message ---------
>>>> >Sender : =EA=B9=80=EC=9E=AC=EC=9B=90=20<jaewon31.kim=40samsung.com>Sy=
stem=20Performance=20Lab.(MX)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=0D=0A>>>=
>=20>Date?=20=20:=202024-05-21=2011:40=20(GMT+9)=0D=0A>>>>=20>Title?=20:=20=
=5BRESEND=20PATCH=2000/10=5D=20memblock:=20introduce=20memsize=20showing=20=
reserved=20memory=0D=0A>>>>=20>?=0D=0A>>>>=20>Some=20of=20memory=20regions=
=20can=20be=20reserved=20for=20a=20specific=20purpose.=20They=20are=0D=0A>>=
>>=20>usually=20defined=20through=20reserved-memory=20in=20device=20tree.=
=20If=20only=20size=0D=0A>>>>=20>without=20address=20is=20specified=20in=20=
device=20tree,=20the=20address=20of=20the=20region=0D=0A>>>>=20>will=20be=
=20determined=20at=20boot=20time.=0D=0A>>>>=20>=0D=0A>>>>=20>We=20may=20fin=
d=20the=20address=20of=20the=20memory=20regions=20through=20booting=20log,=
=20but=0D=0A>>>>=20>it=20does=20not=20show=20all.=20And=20it=20could=20be=
=20hard=20to=20catch=20the=20very=20beginning=0D=0A>>>>=20>log.=20The=20mem=
block_dump_all=20shows=20all=20memblock=20status=20but=20it=20does=20not=0D=
=0A>>>>=20>show=20region=20name=20and=20its=20information=20is=20difficult=
=20to=20summarize.=0D=0A>>>>=20>=0D=0A>>>>=20>This=20patch=20introduce=20a=
=20debugfs=20node,=20memblock/memsize,=20to=20see=20reserved=0D=0A>>>>=20>m=
emory=20easily.=0D=0A>>>>=20>=0D=0A>>>>=20>Here's=20an=20example=0D=0A>>>>=
=20>=0D=0A>>>>=20>=24=20cat=20debugfs/memblock/memsize=0D=0A>>>>=20>=0D=0A>=
>>>=20>0x0000000000000000-0x0000000000000000=200x02000000=20(??=2032768=20K=
B=20)??=20map=20reusable=20linux,cma=0D=0A>>>>=20>0x0000000000000000-0x0000=
000000000000=200x01000000=20(??=2016384=20KB=20)??=20map=20reusable=20vxxxx=
x=0D=0A>>>>=20>...=0D=0A>>>>=20>0x0000000000000000-0x0000000000000000=200x0=
04e0000=20(?=20?=204992=20KB=20)=20nomap=20unusable=20unknown=0D=0A>>>>=20>=
0x0000000000000000-0x0000000000000000=200x00400000=20(?=20?=204096=20KB=20)=
=20nomap=20unusable=20cxxxxx=0D=0A>>>>=20>0x0000000000000000-0x000000000000=
0000=200x00e00000=20(??=2014336=20KB=20)=20nomap=20unusable=20gxxxxx=0D=0A>=
>>>=20>=0D=0A>>>>=20>Reserved?=20?=20:=201223856=20KB=0D=0A>>>>=20>=20.kern=
el?=20?=20:?=20275208=20KB=0D=0A>>>>=20>?=20.text?=20??=20:??=2016576=20KB=
=0D=0A>>>>=20>?=20.rwdata??=20:?=20?=201963=20KB=0D=0A>>>>=20>?=20.rodata??=
=20:??=2011920=20KB=0D=0A>>>>=20>?=20.bss?=20?=20?=20:?=20?=202450=20KB=0D=
=0A>>>>=20>?=20.memmap??=20:?=20186368=20KB=0D=0A>>>>=20>?=20.etc?=20?=20?=
=20:??=2055933=20KB=0D=0A>>>>=20>=20.unusable?=20:?=20948648=20KB=0D=0A>>>>=
=20>System?=20?=20?=20:=2011359056=20KB=0D=0A>>>>=20>=20.common?=20?=20:=20=
10306384=20KB=0D=0A>>>>=20>=20.reusable?=20:=201052672=20KB=0D=0A>>>>=20>To=
tal?=20?=20??=20:=2012582912=20KB=20(=2012288.00=20MB=20)=0D=0A>>>>=20>=0D=
=0A>>>>=20>Jaewon=20Kim=20(10):=0D=0A>>>>=20>?=20memblock:=20introduce=20me=
msize=20showing=20reserved=20memory=0D=0A>>>>=20>?=20memblock:=20detect=20h=
idden=20memory=20hole=20size=0D=0A>>>>=20>?=20memblock:=20handle=20overlapp=
ed=20reserved=20memory=20region=0D=0A>>>>=20>?=20memblock:=20take=20a=20reg=
ion=20intersecting=20an=20unknown=20region=0D=0A>>>>=20>?=20memblock:=20tra=
ck=20memblock=20changed=20at=20early=20param=0D=0A>>>>=20>?=20memblock:=20r=
ecognize=20late=20freed=20size=20by=20checking=20PageReserved=0D=0A>>>>=20>=
?=20memblock:=20track=20kernel=20size=20on=20memsize=0D=0A>>>>=20>?=20membl=
ock:=20print=20memsize=20summary=20information=0D=0A>>>>=20>?=20memblock:=
=20print=20kernel=20internal=20size=0D=0A>>>>=20>?=20memblock:=20support=20=
memsize=20reusable=20to=20consider=20as=20reusable=0D=0A>>>>=20>=0D=0A>>>>=
=20>=20drivers/of/fdt.c?=20?=20?=20?=20?=20??=20=7C?=2011=20+=0D=0A>>>>=20>=
=20drivers/of/of_reserved_mem.c=20=7C?=2012=20+-=0D=0A>>>>=20>=20include/li=
nux/memblock.h?=20??=20=7C?=2029=20++=0D=0A>>>>=20>=20init/main.c?=20?=20?=
=20?=20?=20?=20?=20?=20?=20=7C?=2013=20+-=0D=0A>>>>=20>=20kernel/dma/contig=
uous.c?=20?=20?=20=7C??=209=20+-=0D=0A>>>>=20>=20mm/Kconfig?=20?=20?=20?=20=
?=20?=20?=20?=20??=20=7C?=2016=20++=0D=0A>>>>=20>=20mm/memblock.c?=20?=20?=
=20?=20?=20?=20?=20?=20=7C=20502=20++++++++++++++++++++++++++++++++++-=0D=
=0A>>>>=20>=20mm/mm_init.c?=20?=20?=20?=20?=20?=20?=20??=20=7C??=206=20+-=
=0D=0A>>>>=20>=20mm/page_alloc.c?=20?=20?=20?=20?=20?=20?=20=7C?=2010=20+-=
=0D=0A>>>>=20>=209=20files=20changed,=20597=20insertions(+),=2011=20deletio=
ns(-)=0D=0A>>>>=20>=0D=0A>>>>=20>--=20=0D=0A>>>>=20>2.25.1=0D=0A>>>>=20=0D=
=0A>>>>=20Hello=20Mike=20=0D=0A>>>>=20=0D=0A>>>>=20This=20is=20actually=20R=
ESEND=20as=20it=20was=20introduced=202=20years=20ago.=0D=0A>>>>=20Please=20=
refer=20to=20https://lore.kernel.org/linux-mm/YkQB6Ah603yPR3qf=40kernel.org=
/=23t=0D=0A>>>>=20=0D=0A>>>>=20>=20But=20you=20never=20provided=20details=
=20about=20*why*=20you=20want=20this=20information=20exposed.=0D=0A>>>>=20=
=0D=0A>>>>=20For=20your=20question,=20I'd=20like=20to=20say=20;=0D=0A>>>>=
=20We=20can=20see=20the=20same=20format=20and=20exact=20information=20betwe=
en=20different=20version=20of=20kernel=20status.=0D=0A>>>>=20=0D=0A>>>>=201=
)=20Internally=20we=20can=20check=20if=20the=20reserved=20memory=20changes.=
=0D=0A>>>>=202)=20Externally=20we=20can=20communicate=20between=20chipset=
=20vendors=20and=20OEM,=20with=20a=20same=20format.=0D=0A=0D=0A=0D=0AHi=0D=
=0A=0D=0A>=20Maybe=20you=20can=20show=20the=20log=20difference,=20so=20that=
=20we=20can=20see=20how=20it=20helps=20you.=0D=0A=0D=0AFor=20your=20new=20e=
mail,=20could=20you=20elaborate=20the=20difference=20you=20meant?=20=0D=0AD=
o=20you=20mean=20difference=20between=20existing=20debugfs=20membock=20inte=
rfaces=20and=20the=20one=20I=20introdued=20here?=0D=0A=0D=0A=0D=0A>>>=0D=0A=
>>>Why=20the=20existing=20debugfs=20interface=20is=20not=20sufficient?=0D=
=0A>>=0D=0A>>debugfs/memblock/memory=20&=20debugfs/memblock/reserved=20have=
=20changed=20its=20format=20but=20still=20does=20not=20show=20name,=20reusa=
ble,=20kernel=20size.=0D=0A>=0D=0A>Would=20you=20mind=20showing=20which=20i=
nformation=20matters=20to=20you=20most=20in=20the=20following=0D=0A>example=
=20log=20message?=20What=20you=20expect=20to=20see=20and=20helps=20you=20on=
=20locating=20problem?=0D=0A>=0D=0A>0x0000000000000000-0x0000000000000000=
=200x02000000=20(?=20=2032768=20KB=20)?=20=20map=20reusable=20linux,cma=0D=
=0A>0x0000000000000000-0x0000000000000000=200x01000000=20(?=20=2016384=20KB=
=20)?=20=20map=20reusable=20vxxxxx=0D=0A>..=0D=0A>0x0000000000000000-0x0000=
000000000000=200x004e0000=20(?=20?=204992=20KB=20)=20nomap=20unusable=20unk=
nown=0D=0A>0x0000000000000000-0x0000000000000000=200x00400000=20(?=20?=2040=
96=20KB=20)=20nomap=20unusable=20cxxxxx=0D=0A>0x0000000000000000-0x00000000=
00000000=200x00e00000=20(?=20=2014336=20KB=20)=20nomap=20unusable=20gxxxxx=
=0D=0A>=0D=0A>Reserved?=20?=20:=201223856=20KB=0D=0A>=20.kernel?=20?=20:?=
=20275208=20KB=0D=0A>?=20.text?=20?=20=20:?=20=2016576=20KB=0D=0A>?=20.rwda=
ta?=20=20:?=20?=201963=20KB=0D=0A>?=20.rodata?=20=20:?=20=2011920=20KB=0D=
=0A>?=20.bss?=20?=20?=20:?=20?=202450=20KB=0D=0A>?=20.memmap?=20=20:?=20186=
368=20KB=0D=0A>?=20.etc?=20?=20?=20:?=20=2055933=20KB=0D=0A>=20.unusable?=
=20:?=20948648=20KB=0D=0A>System?=20?=20?=20:=2011359056=20KB=0D=0A>=20.com=
mon?=20?=20:=2010306384=20KB=0D=0A>=20.reusable?=20:=201052672=20KB=0D=0A>T=
otal?=20?=20?=20=20:=2012582912=20KB=20(=2012288.00=20MB=20)=0D=0A>=0D=0A=
=0D=0A=0D=0AI=20need=20all=20those=20information=20actually.=20address,=20s=
ize,=20map/nomap,=20reusable/unusable,=0D=0Aname.=20For=20me=20it=20was=20v=
ery=20helpful=20to=20rearrange=20the=20memory=20regions=20as=20it=20shows=
=20clearly.=0D=0AThe=20address=20could=20be=20seen=20after=20allowing=20it=
=20through=20/proc/sys/kernel/kptr_restrict.=0D=0A=0D=0AKernel=20size=20inf=
ormation=20is=20also=20helpful=20to=20me.=20The=20memmap=20size=20for=20str=
uct=20pages=0D=0Acould=20be=20increased=20according=20to=20DRAM=20memory=20=
size.=20By=20rearranging=20the=20reserved=20regions=0D=0Ato=20be=20packed=
=20we=20can=20save=20memmap=20memory,=20then=20we=20can=20see=20the=20resul=
ts=20easily=20from=20this.=0D=0AWe=20can=20compare=20other=20text,=20ro,=20=
rw,=20etc=20so=20that=20we=20can=20find=20which=20part=20of=20kernel=20has=
=0D=0Achanged.=0D=0A=0D=0A=0D=0A>>If=20memory=20is=20reserved=20from=20memb=
lock,=20and=20did=20not=20freed=20back=20to=20memblock.=20Memblock=20does=
=20not=20know=20even=20after=20the=20memory=20is=20freed=20to=20system.=0D=
=0A>=0D=0A>You=20mean=20we=20may=20reserve=20memory=20in=20memblock.reserve=
d,=20but=20still=20have=20it=20freed=0D=0A>to=20system?=20This=20sounds=20a=
=20bug=20to=20me.=0D=0A=0D=0AI=20mean=20something=20like=20free_reserved_ar=
ea.=20The=20reserved=20free=20pages=20would=20be=20free=20to=0D=0Asystem=20=
buddy=20allocator=20directly=20without=20reporting=20it=20to=20memblock.=0D=
=0A=0D=0A>=0D=0A>>I=20think=20a=20simple=20debug=20interface=20is=20needed=
=20to=20easily=20communicate=20with=20others=20or=20compare=20different=20S=
W=20releases.=0D=0A>>=0D=0A>>>=20=0D=0A>>>>=20This=20helps=20us=20to=20comm=
unitcate=20well,=20to=20easily=20detect=20changes=20or=20just=20to=20see=20=
differences.=0D=0A>>>>=20=0D=0A>>>>=20Jaewon=20Kim=0D=0A>>>>=20=0D=0A>>>=0D=
=0A>>>--=20=0D=0A>>>Sincerely=20yours,=0D=0A>>>Mike.=0D=0A>>=0D=0A>>=0D=0A>=
=0D=0A>--=20=0D=0A>Wei=20Yang=0D=0A>Help=20you,=20Help=20me=0D=0A>=0D=0A=0D=
=0A=0D=0A

