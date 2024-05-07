Return-Path: <linux-kernel+bounces-170628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4498BD9E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F252836F9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69B542AAE;
	Tue,  7 May 2024 03:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="RDJpjWhb"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D654BCA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715054120; cv=none; b=f0uLSFBitrj1vT3ndzz8HtkGvzbiNoGpr8D+GHNrmHyY16+xIHOOpY0AXlJw/eUR8rVYePOcszZNMTuGez6tv5HTMBh3oTMkkI3diO5u2Xq978jrXZFmoJXbE3bdJk/t6Bqj1s80k5+d+F5vyTong05t3ZxVIVvnLQ7MK1AfRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715054120; c=relaxed/simple;
	bh=6BmP39qRpEEc80LOA77CqS1rXn96VFp5nZ6GI++nr+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QUTEAATU8IMxrNvGrRqEPZjc7hB/plLE2ic4+QREJc7DGsNHNQgGgofVGh6IhazweYvD6V5aZNf3WXBLUhdbgArghE292RKt1RkGcUFoXvK9NBOUTT9cbRERdFLTj5HT4CSIOk2EJEQxaG8utWfT8ULuo7o9ymxPfTQMe2mmpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=RDJpjWhb; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1715054116;
	bh=6BmP39qRpEEc80LOA77CqS1rXn96VFp5nZ6GI++nr+I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RDJpjWhbaAmmj1aWNTXszCuxtC45rb7rDobToUAAyKi/hsNG3FAfFrM36wL8wt1Jp
	 IL/dpcJITfF5jU2EHf81tlcDVqhQyCjP3AlWMCpYh6u/vpTRpELreDXXe0nUn2Skd1
	 sexfXdsnYir/HZRjfGyaeMd75TxsEYf+y5iBj3yE=
Received: from [IPv6:240e:358:116c:3f00:dc73:854d:832e:6] (unknown [IPv6:240e:358:116c:3f00:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E8DF567594;
	Mon,  6 May 2024 23:55:12 -0400 (EDT)
Message-ID: <cf5df629b88fe38ae04cfa5714b9de2a44792704.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Update the flush cache policy
From: Xi Ruoyao <xry111@xry111.site>
To: lijun <lijun01@kylinos.cn>, chenhuacai@kernel.org, kernel@xen0n.name, 
	lvjianmin@loongson.cn, dongbiao@loongson.cn, zhangbaoqi@loongson.cn
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 07 May 2024 11:55:08 +0800
In-Reply-To: <8809f5a7-de6e-0794-feab-726c26f87344@kylinos.cn>
References: <20240506092419.4109941-1-lijun01@kylinos.cn>
	 <8a8135eb0f1dc724cfbb4402dc6daf08db5b0bc7.camel@xry111.site>
	 <cbb24599-8b40-cd27-6ce7-215476c0ddf4@kylinos.cn>
	 <cbd6ed9d5be1d7112d69117a72e0cb0081f9b64b.camel@xry111.site>
	 <8809f5a7-de6e-0794-feab-726c26f87344@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-07 at 08:53 +0800, lijun wrote:
> The value of addr changes very very quickly, and 'volatile' ensures that=
=20
> every change can be read

No, volatile has nothing to do with changing quickly or not.

It's only useful when the compiler cannot know the change, for example
it's changed by the hardware or another thread.

And in the Linux kernel memory model for the hardware change you should
use READ_ONCE/WRITE_ONCE instead (they are actually wrappers of volatile
so in the kernel you should almost never need to directly use volatile),
for the change from another thread using volatile is just wrong and you
should use some atomic or locked operation instead.

See
https://www.kernel.org/doc/html/latest/process/volatile-considered-harmful.=
html.

In this case I'd like to ask first: why won't a simple addr +=3D cdesc-
>linesz * cdesc->sets * cdesc->ways * 3 work?  Which value(s) of addr,
cdesc, or cdesc->{linesz,sets,ways} may change w/o the compiler's
knowledge?

> =E5=9C=A8 2024/5/6 18:17, Xi Ruoyao =E5=86=99=E9=81=93:
> > On Mon, 2024-05-06 at 18:08 +0800, lijun wrote:
> > > volatile prevents compiler optimization by allowing the compiler
> > >=20
> > > =C2=A0=C2=A0=C2=A0to reread the address value of addr every time
> > But why is this ever needed?=C2=A0 What's wrong if the compiler optimiz=
es
> > it?
> >=20
> > If the problem is the compiler may optimize it to cdesc->ways * 3 *
> > cdesc->sets * cdesc->linesz, unknowing cdesc->ways etc may magically
> > change, you should use READ_ONCE(cdesc->ways) etc.
> >=20
> > I.e. use READ_ONCE on the expression which may magically change,
> > instead
> > of hacking addr.=C2=A0 addr won't magically change.
> >=20
> > > =E5=9C=A8 2024/5/6 17:28, Xi Ruoyao =E5=86=99=E9=81=93:
> > > > On Mon, 2024-05-06 at 17:24 +0800, Li Jun wrote:
> > > > > fix when LoongArch s3 resume, Can't find image information
> > > > >=20
> > > > > Signed-off-by: Li Jun <lijun01@kylinos.cn>
> > > > > Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> > > > > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > > > > Signed-off-by: Biao Dong <dongbiao@loongson.cn>
> > > > > ---
> > > > > =C2=A0=C2=A0=C2=A0arch/loongarch/mm/cache.c | 24 ++++++++++++++++=
+++++++-
> > > > > =C2=A0=C2=A0=C2=A01 file changed, 23 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/arch/loongarch/mm/cache.c
> > > > > b/arch/loongarch/mm/cache.c
> > > > > index 6be04d36ca07..52872fa0e5d8 100644
> > > > > --- a/arch/loongarch/mm/cache.c
> > > > > +++ b/arch/loongarch/mm/cache.c
> > > > > @@ -63,6 +63,28 @@ static void flush_cache_leaf(unsigned int
> > > > > leaf)
> > > > > =C2=A0=C2=A0=C2=A0	} while (--nr_nodes > 0);
> > > > > =C2=A0=C2=A0=C2=A0}
> > > > > =C2=A0=C2=A0=20
> > > > > +static void flush_cache_last_level(unsigned int leaf)
> > > > > +{
> > > > > +	u64 addr;
> > > > > +	int i, j, nr_nodes, way_size;
> > > > > +	struct cache_desc *cdesc =3D
> > > > > current_cpu_data.cache_leaves
> > > > > +
> > > > > leaf;
> > > > > +
> > > > > +	nr_nodes =3D loongson_sysconf.nr_nodes;
> > > > > +
> > > > > +	addr =3D CSR_DMW1_BASE;
> > > > > +	iocsr_write32(0x1, 0x280);
> > > > > +	way_size =3D cdesc->sets * cdesc->linesz;
> > > > > +	do {
> > > > > +		for (i =3D 0; i < (cdesc->ways * 3); i++) {
> > > > > +			for (j =3D 0; j < (cdesc->sets); j++) {
> > > > > +				*(volatile u32 *)addr;
> > > > ??? what does this line do?
> > > >=20
>=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

