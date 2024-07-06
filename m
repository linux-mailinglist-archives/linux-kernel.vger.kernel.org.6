Return-Path: <linux-kernel+bounces-243294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A98929427
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6551F22003
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11D413A86C;
	Sat,  6 Jul 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="EAJe+rPc"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878B13A41D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277231; cv=none; b=T9thr7pgb0PSvdHUuKmPFxCkz4xWdnICoVvTCczjG4L0qqQbyL+51UF0vJwtZDSfHpi9W48j1bdW3HRcScMridZTy4r2AlZ4EbPszviBLFMGVSNbNXhKaf2syqR7gJBhaNArDcS2TMpEF8neiHcWNM2KRI/omDkqtomuHyW1A8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277231; c=relaxed/simple;
	bh=6ZA2YmJ9hyk9M1Xu80OoaScP500Lyoc/mjOR70ZnFyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVQ3Ogvs8kyZSAuyoljSCYKomcegKzw5iSRuSLs/5naaFPOFBge5qBvrmVj0uM3LrkL1p44iS0i3daP0khBhmuy4xIDISP9Q7cDZg0wM+tOX2JdGbp1iasNsxZonPOrHSz/oIUSw6R2PpnPf7BX0EJB10CCx0fiGzsFAonpfzfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=EAJe+rPc; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1720277227;
	bh=6ZA2YmJ9hyk9M1Xu80OoaScP500Lyoc/mjOR70ZnFyM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EAJe+rPcvmqWZbNtrlXJo29XFiO+mKUDVaU8fNC9GQeSV2H7UOZzOcLDPBJ0L5irJ
	 nYkSoxRVeooUoXQc6/Kq2I4WFq4AgG/FKPfGaahkgXjjQ9UOCnag/I6xX+aIFNspdM
	 IVlAqieApyKN815JOBiKuYQOZJ5jUSmZmBhNDV/k=
Received: from [IPv6:240e:358:11fb:d500:dc73:854d:832e:5] (unknown [IPv6:240e:358:11fb:d500:dc73:854d:832e:5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 594E9664FA;
	Sat,  6 Jul 2024 10:46:58 -0400 (EDT)
Message-ID: <1f1453927318478bf5404ad9e2b692b9e5630221.camel@xry111.site>
Subject: Re: [PATCH 2/2] LoongArch: Add support for relocating the kernel
 with RELR relocation
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Jinyang He <hejinyang@loongson.cn>, 
 Youling Tang <tangyouling@kylinos.cn>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, Fangrui Song <maskray@google.com>,  Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
  loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Date: Sat, 06 Jul 2024 22:46:50 +0800
In-Reply-To: <CAAhV-H4CQMmrLRv=vi8N63p2NXbdozpDakJLia8soFvVohCbqQ@mail.gmail.com>
References: <20240706073858.161035-1-xry111@xry111.site>
	 <20240706073858.161035-2-xry111@xry111.site>
	 <CAAhV-H6K7SXtXpv9Udo8md0sdn+40TGPTCdSPeM1HmbJqrhboQ@mail.gmail.com>
	 <cb3c2038b97689371226c467befdbf9e13113744.camel@xry111.site>
	 <CAAhV-H4CQMmrLRv=vi8N63p2NXbdozpDakJLia8soFvVohCbqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-07-06 at 21:49 +0800, Huacai Chen wrote:
> On Sat, Jul 6, 2024 at 6:34=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
> >=20
> > On Sat, 2024-07-06 at 18:29 +0800, Huacai Chen wrote:
> >=20
> > /* snip */
> >=20
> > > > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > > > index ddc042895d01..03b3ef5edd24 100644
> > > > --- a/arch/loongarch/Kconfig
> > > > +++ b/arch/loongarch/Kconfig
> > > > @@ -607,6 +607,7 @@ config
> > > > ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> > > >=20
> > > > =C2=A0config RELOCATABLE
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Relocatable kernel=
"
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAS_RELR
> > > Why is this selection under RELOCATABLE? I know ARM64 is the same,
> > > but
> > > why?
> >=20
> > Because if we just select it in CONFIG_LOONGARCH instead of
> > CONFIG_RELOCATABLE, the users who have disabled CONFIG_RELOCATABLE
> > will
> > still see the entry for RELR in their configuration interface.=C2=A0 An=
d
> > they'll ask "hey what's this for?=C2=A0 Why my kernel needs relocation?=
"
> RELR is not a similar conception to RELA, it is only used for
> relocatable kernel?

It replaces R_LARCH_RELATIVE relocs in RELA (basically represent the
same info in a much more compact form).  For non-relocatable kernel both
RELR and RELA shouldn't exist.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

