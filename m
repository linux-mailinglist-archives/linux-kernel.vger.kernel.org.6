Return-Path: <linux-kernel+bounces-189930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89D78CF74A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6E91C20EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 01:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24E2107;
	Mon, 27 May 2024 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A0ik71HB"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A944463D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716773709; cv=none; b=I84L4WNkMkzCnGdblOY7u0jBosnyEBThvxF6CpZo/XKz13MAHMBamXW3Z4YLKH601eYqf75rdV2HntRmGYVhLuQ50iUN+MTvToSBua+xBeeEvFNhyzDV1nyguXMB7pQ7QkdeR755qTO+wJPpumiEPraqQI+Bu80hOBpMk5rw6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716773709; c=relaxed/simple;
	bh=VhkcBTFsilD3kzGdUGyaDcmo1XW4ngHBFrWK9pil7zU=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=c8gTeFRRiutErkMWA17pdSlW0bByKDRJ3cfnOKLFDjVX/aYK8WCOgAM+p82gWi0Azt9nULnBw/fMfz9iZ4swVqmduRIFPPHOs5uCBxYjxULr1xi4y5QdTmmAbwZ+/W+ixoH4HL4NI8qJ5uuoXFGh5xVK18urAYvEGhGBCFD3D7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A0ik71HB; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240527013505epoutp030cea623765171b3f28b1f05457ab81b4~TNJbnICAA1448114481epoutp03G
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:35:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240527013505epoutp030cea623765171b3f28b1f05457ab81b4~TNJbnICAA1448114481epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716773705;
	bh=VhkcBTFsilD3kzGdUGyaDcmo1XW4ngHBFrWK9pil7zU=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=A0ik71HBWSXZVgH7BuGC+8tFpnFE97PaUntGAtsl5Jy7/ZoupBpv9lSnajoHv5c4F
	 AzbBH1II/GcWtDQdXG3JdcwjefcwdmUbS1hrF9TSJiPkZBg/G1jHOJ6egGsmGtX7JX
	 dkxJGegs2mzsHog7oHIGLEseAoWCsjrDfcieoVPA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240527013505epcas1p38d5cc243e76ad3a7934c1d561f4d9db2~TNJa-fxkE0347403474epcas1p3R;
	Mon, 27 May 2024 01:35:05 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.227]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VndVw4NV4z4x9Q5; Mon, 27 May
	2024 01:35:04 +0000 (GMT)
X-AuditID: b6c32a37-6ae6aa8000002596-48-6653e348ceef
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.21.09622.843E3566; Mon, 27 May 2024 10:35:04 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: Mike Rapoport <rppt@kernel.org>, Jaewon Kim <jaewon31.kim@samsung.com>
CC: "vbabka@suse.cz" <vbabka@suse.cz>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>, "tkjos@google.com"
	<tkjos@google.com>, Wei Yang <richard.weiyang@gmail.com>, Pintu Agarwal
	<pintu.ping@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZlM_Ndng_JstAee3@kernel.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>
Date: Mon, 27 May 2024 10:35:04 +0900
X-CMS-MailID: 20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmga7H4+A0gz1fFC3mrF/DZvHykKZF
	9+aZjBa9718xWVzeNYfN4t6a/6wW119OY7G40/eKxeLI+u1MFu8nF1vMbuxjdOD22DnrLrvH
	gk2lHptWdbJ5bPo0id3jxIzfLB59W1YxepxZcITd4/MmuQCOqGybjNTElNQihdS85PyUzLx0
	WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAzlRTKEnNKgUIBicXFSvp2NkX5pSWp
	Chn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGWcf2hYcdqrofmTZwNjp0MXI
	ySEhYCJxbfJSli5GLg4hgR2MEu+WP2DqYuTg4BUQlPi7QxikRlggWmLm9BYWEFtIQEni7I8r
	7BBxXYmm7tVgcTYBbYn3CyaxgrSKCHhJ3HnrATKSWeAHk8TO7xMYIXbxSsxof8oCYUtLbF++
	FSzOKaAlMfnuWlaIuKjEzdVv2WHs98fmQ/WKSLTeO8sMYQtKPPi5mxFmzp/jz9kg7GKJZZ0g
	54PYNRIrzq2CiptLNLxdCWbzCvhKdDzfAbaLRUBVYvnsOVBzXCQ2bPkEtpcZ6JdlC18zg/zC
	LKApsX6XPkSYT+Ld1x5WmFcaNv5mx8beMe8J1AlqEi3PvkLVy0j8/fcMyvaQuHttN8sERsVZ
	iICehWTxLITFCxiZVzGKpRYU56anFhsWGMNjNjk/dxMjOLlqme9gnPb2g94hRiYOxkOMEhzM
	SiK8IvMC04R4UxIrq1KL8uOLSnNSiw8xmgK9PJFZSjQ5H5je80riDU0sDUzMjEwsjC2NzZTE
	ec9cKUsVEkhPLEnNTk0tSC2C6WPi4JRqYKqrXWDzM9rI8kvQjZR16/V911RebvyT0WybsFdA
	lP19uZxC7uEXsz8tfvfV+E9wQ95G3w79G2tZPnG3T1nB+LRggqTxGsvemLqTz/fUeF3XN9XO
	/LB0e8Pmc4Us/668nL6v8JJc0cuulnVyu5wdE96+T5y56sA20/u5E6P6A489Cb27TdnxX2mF
	t7XBmo8lzfzx8b8m83p38O47tet/wNGIWRarb7ksafu4y50p65pJyKe7tdeqrJdHzAhdUPTg
	tqPivvllnwp+fGM6tvNjjL+1bRLzetVm5n0TPvE9DVVfVbLnm/oX1pzqABdd4877zjazMtY7
	5C/s2xwzZe08d68vK01tTB76eTy7vn33kRQlluKMREMt5qLiRACFglYhNwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76
References: <ZlM_Ndng_JstAee3@kernel.org> <Zk9UCsZdizqC1_36@kernel.org>
	<ZkxN0yQ7Fb0X26hT@kernel.org>
	<20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
	<20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
	<20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
	<CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p2>

>Hi Jaewon,
>
>Please use reply-all=21
>
>I just realized my previous reply went off-list :(

Oh I'm very sorry I didn't know that. I just found that I had sent the mail=
 to all as
email secret recipient.

>
>On Fri, May 24, 2024 at 06:07:15PM +0900, Jaewon Kim wrote:
>> >On Tue, May 21, 2024 at 07:17:53PM +0900, Jaewon Kim wrote:
>> >> >On Tue, May 21, 2024 at 11:53:29AM +0900, Jaewon Kim wrote:
>> >> >> >--------- Original Message ---------
>> >> >> >Sender : =EA=B9=80=EC=9E=AC=EC=9B=90=20<jaewon31.kim=40samsung.co=
m>System=20Performance=20Lab.(MX)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=0D=
=0A>>=20>>=20>>=20>Date=20=20=20:=202024-05-21=2011:40=20(GMT+9)=0D=0A>>=20=
>>=20>>=20>Title=20=20:=20=5BRESEND=20PATCH=2000/10=5D=20memblock:=20introd=
uce=20memsize=20showing=20reserved=20memory=0D=0A>>=20>>=20>>=20>?=0D=0A>>=
=20>>=20>>=20>Some=20of=20memory=20regions=20can=20be=20reserved=20for=20a=
=20specific=20purpose.=20They=20are=0D=0A>>=20>>=20>>=20>usually=20defined=
=20through=20reserved-memory=20in=20device=20tree.=20If=20only=20size=0D=0A=
>>=20>>=20>>=20>without=20address=20is=20specified=20in=20device=20tree,=20=
the=20address=20of=20the=20region=0D=0A>>=20>>=20>>=20>will=20be=20determin=
ed=20at=20boot=20time.=0D=0A>>=20>>=20>>=20>=0D=0A>>=20>>=20>>=20>We=20may=
=20find=20the=20address=20of=20the=20memory=20regions=20through=20booting=
=20log,=20but=0D=0A>>=20>>=20>>=20>it=20does=20not=20show=20all.=20And=20it=
=20could=20be=20hard=20to=20catch=20the=20very=20beginning=0D=0A>>=20>>=20>=
>=20>log.=20The=20memblock_dump_all=20shows=20all=20memblock=20status=20but=
=20it=20does=20not=0D=0A>>=20>>=20>>=20>show=20region=20name=20and=20its=20=
information=20is=20difficult=20to=20summarize.=0D=0A>>=20>>=20>>=20>=0D=0A>=
>=20>>=20>>=20>This=20patch=20introduce=20a=20debugfs=20node,=20memblock/me=
msize,=20to=20see=20reserved=0D=0A>>=20>>=20>>=20>memory=20easily.=0D=0A>>=
=20>>=20>>=20=0D=0A>>=20>>=20>>=20This=20is=20actually=20RESEND=20as=20it=
=20was=20introduced=202=20years=20ago.=0D=0A>>=20>>=20>>=20Please=20refer=
=20to=20https://lore.kernel.org/linux-mm/YkQB6Ah603yPR3qf=40kernel.org/=23t=
=0D=0A>>=20>>=20>>=20=0D=0A>>=20>>=20>>=20>=20But=20you=20never=20provided=
=20details=20about=20*why*=20you=20want=20this=20information=20exposed.=0D=
=0A>>=20>>=20>>=20=0D=0A>>=20>>=20>>=20For=20your=20question,=20I'd=20like=
=20to=20say=20;=0D=0A>>=20>>=20>>=20We=20can=20see=20the=20same=20format=20=
and=20exact=20information=20between=20different=20version=20of=20kernel=20s=
tatus.=0D=0A>>=20>>=20>>=20=0D=0A>>=20>>=20>>=201)=20Internally=20we=20can=
=20check=20if=20the=20reserved=20memory=20changes.=0D=0A>>=20>>=20>>=202)=
=20Externally=20we=20can=20communicate=20between=20chipset=20vendors=20and=
=20OEM,=20with=20a=20same=20format.=0D=0A>>=20>>=20>=0D=0A>>=20>>=20>Why=20=
the=20existing=20debugfs=20interface=20is=20not=20sufficient?=0D=0A>>=20>>=
=20=0D=0A>>=20>>=20debugfs/memblock/memory=20&=20debugfs/memblock/reserved=
=20have=20changed=20its=0D=0A>>=20>>=20format=20but=20still=20does=20not=20=
show=20name,=20reusable,=20kernel=20size.=20=20If=20memory=20is=0D=0A>>=20>=
>=20reserved=20from=20memblock,=20and=20did=20not=20freed=20back=20to=20mem=
block.=20Memblock=20does=0D=0A>>=20>>=20not=20know=20even=20after=20the=20m=
emory=20is=20freed=20to=20system.=20=20I=20think=20a=20simple=0D=0A>>=20>>=
=20debug=20interface=20is=20needed=20to=20easily=20communicate=20with=20oth=
ers=20or=20compare=0D=0A>>=20>>=20different=20SW=20releases.=0D=0A>>=20>=0D=
=0A>>=20>I=20still=20don't=20understand=20what=20problem=20are=20you=20tryi=
ng=20to=20solve=20with=20these=0D=0A>>=20>patches.=20=0D=0A>>=20=0D=0A>>=20=
I=20think=20we=20need=20a=20common=20API=20to=20easily=20see=20the=20reserv=
ed=20memory=20status.=0D=0A>>=20Through=20MemTotal=20on=20/proc/meminfo,=20=
we=20can=20only=20see=20only=20the=20total=20size=0D=0A>>=20of=20reserved=
=20memory.=20We=20don't=20how=20big=20kernel=20init=20size=20within=20the=
=20the=0D=0A>>=20total=20size.=20I=20think=20this=20really=20helps=20to=20c=
ompare=20different=20kernel=20and=0D=0A>>=20communicate=20with=20others.=0D=
=0A>=0D=0A>As=20was=20already=20mentioned=20on=20this=20thread,=20something=
=20like=0D=0A>=0D=0A>=24=20dmesg=20=7C=20grep=20Memory:=0D=0A>=5B=20=20=20=
=200.000000=5D=20Memory:=208058204K/8388608K=20available=20(35392K=20kernel=
=20code,=208706K=20rwdata,=2023320K=20rodata,=2016832K=20init,=20848K=20bss=
,=20297636K=20reserved,=2032768K=20cma-reserved)=0D=0A>=0D=0A>already=20sho=
ws=20init,=20rodata=20and=20bss=20sizes.=0D=0A>=0D=0A>And=20size=20-A=20vml=
inux=20provides=20detailed=20breakdown=20of=20the=20kernel=20image=20into=
=0D=0A>sections.=0D=0A>=20=0D=0A>>=20I=20think=20the=20debugfs=20API=20or=
=20early=20boot=20log=20shows=20quite=20much=20information=0D=0A>>=20for=20=
the=20reserved=20memory=20information=20defined=20in=20device=20tree.=20But=
=20it=20is=0D=0A>>=20difficult=20to=20see=20after=20boot,=20as=20the=20boot=
=20log=20already=20was=20removed=20ouf=20of=0D=0A>>=20the=20kernel=20log=20=
buffer.=0D=0A>=0D=0A>Kernel=20log=20is=20persisted,=20isn't=20it?=0D=0A=0D=
=0AEarly=20kernel=20log=20is=20removed=20after=20other=20log=20is=20written=
=20to=20the=20log=20buffer.=20I=20may=0D=0Anot=20be=20able=20to=20get=20it,=
=20after=20waiting=20for=20the=20target=20device=20is=20ready=20to=20be=0D=
=0Aconnected=20from=20host=20PC.=20I=20wanted=20to=20keep=20that=20informat=
ion.=0D=0A=0D=0AActually=20the=20commit=20aeb9267eb6b1=20(=22of:=20reserved=
-mem:=20print=20out=20reserved-mem=0D=0Adetails=20during=20boot=22)=20seems=
=20to=20show=20most=20of=20information=20if=20I=20can=20get=20the=20early=
=0D=0Aboot=20log.=0D=0A=0D=0AIf=20you=20don't=20mind,=20let=20me=20ask=20on=
e=20question.=20How=20can=20we=20easily=20find=20the=20undefined=0D=0ADRAM=
=20memory=20regions=20in=20kernel=20persective.=20Do=20we=20have=20to=20loo=
k=20into=20the=20debugfs=20=0D=0Amemblock/memory=20and=20combine=20the=20in=
formation=20with=20the=20kernel=20log=20information?=0D=0A=0D=0Acase1)=20Ac=
tual=20DRAM=20is=20mapped=20as=20two=20regions=20like,=0D=0A=20=20=202GB=20=
=40=200x00000000_80000000=20and=206GB=20=40=200x00000008_80000000,=0D=0A=20=
=20=20how=20can=20we=20find=20the=20hole,=200x00000000_80000000--0x00000008=
_7FFFFFFF=20?=0D=0A=0D=0Acase2)=20If=20some=20region=20is=20already=20carve=
d=20out=20at=20bootloader=20stage=20like.=0D=0A=20=20=200x00000000_81200000=
-0x00000000_812FFFFF=20was=20not=20initinally=20on=20memblock.=0D=0A=20=20=
=200x00000000_80000000-0x00000000_81200000=20was=20removed=20as=20no-map=20=
through=20device=20tree.=0D=0A=20=20=20how=20can=20we=20find=20the=20hole,=
=200x00000000_81200000-0x00000000_812FFFFF=20?=0D=0A=0D=0A>=0D=0A>>=20And=
=20it=20does=20not=20show=20some=20information=20like=20kernel=20init=20siz=
e,=20late=20free=0D=0A>>=20pages.=20AFAIK=20if=20some=20memblocks=20are=20m=
erged=20to=20a=20memblock=20data=20structure,=0D=0A>>=20the=20debugfs=20mem=
block=20API=20show=20it=20a=20one=20memblock=20rather=20than=20showing=20wh=
at=0D=0A>>=20each=20memblock=20request.=0D=0A>=0D=0A>The=20reason=20to=20me=
rge=20reserved=20regions=20is=20to=20save=20memory=20and=20CPU=20and=20in=
=20vast=0D=0A>majority=20of=20cases=20it=20is=20not=20important=20from=20wh=
ere=20memblock_reserve()=20was=0D=0A>called.=20If=20it's=20really=20importa=
nt=20to=20keep=20some=20of=20the=20reservations=20distinct,=0D=0A>it=20can=
=20be=20achieved=20by=20e.g.=20using=20.flags=20field=20in=20the=20reserved=
=20regions.=0D=0A>=0D=0A>Your=20repost=20of=20the=20patches=20still=20does=
=20not=20address=20my=20comment=20from=20two=0D=0A>years=20ago:=0D=0A>=0D=
=0A>=09You=20propose=20complex=20mechanism=20that=20seems=20to=20fit=20very=
=20particular=0D=0A>=09scenario=20and=20sprinkle=20some=20calls=20to=20this=
=20mechanism=20at=20random=20places=0D=0A>=09because=20you=20need=20to=20=
=22compare=20reserved=20memory=20map=20with=20other=20map=22.=0D=0A>=0D=0A>=
As=20I=20said=20then,=20I=20don't=20mind=20providing=20more=20visibility=20=
into=20reserved=20memory=0D=0A>attributes=20in=20general,=20but=20I'd=20lik=
e=20to=20see=20something=20way=20more=20simple=20and=0D=0A>localized=20with=
=20a=20clear=20description=20what=20problem=20it=20solves=20and=20how=20it=
=20works=0D=0A>in=20a=20general=20case.=0D=0A>=20=0D=0A>>=20BR=0D=0A>>=20Ja=
ewon=20Kim=0D=0A>=0D=0A>--=20=0D=0A>Sincerely=20yours,=0D=0A>Mike.

