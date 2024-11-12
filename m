Return-Path: <linux-kernel+bounces-405128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1079C4D43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F57428291C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6B207A03;
	Tue, 12 Nov 2024 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="mCDXFkoV"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4920494F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381893; cv=none; b=LVzeJwc/F9WRMGs1dT9ax0QnDtII0pjpOIkB7BUIt3ZP0fXRe/7Rdd0vmpioqQjwxZgiOt6jRMw+lcV2fOXOPIa9hKPrNDRuzlBurK5+e94yD9aVKlWryYvhp26VnoAXgGeTWN+dA4PXu1ELcjiU7AhNE5A6eXrrYZ2Cg+lR+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381893; c=relaxed/simple;
	bh=K6sqA5yqiEr7eaNNdx6WcAiCsF8cbuisbgsN4OB9/YA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UumuBTdpAJpt3JuOH3RUbwWU639kCf4u/MIHF8N/pV5RpfaHj7zZTNVAp78d3YyXImJk1t7+pLkF/9BdYwvTF2hgxBDBmf1MvSO/FCFXFvGP67IGZX7xX2GwHAaRUSzYVR1pVR/Btzrws5PcEDKYwykngiXlHd+mg3W7KCf7VQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=mCDXFkoV; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1731381350;
	bh=Og4VNwKYjtqHGB4zxLbfFKUt6m6DLbxtgZ0UXOCq+p4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mCDXFkoVT/ZqSHhTauszPD5+mwUKVgrswTWDOgFcWcGHQhvbOqxWu7Ew6+rWFyZtn
	 TjEnlvP5q7nWFdfVnrpfJ5hckKKFqbDi/zff99BhXLcm79BVraYTHOHvDOMMZI6XdU
	 ghCfkMEskHEKPPH4UT2bhGiW2cy+r/sUfyDu7ll0=
Received: from [IPv6:240e:358:1159:9900:dc73:854d:832e:5] (unknown [IPv6:240e:358:1159:9900:dc73:854d:832e:5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 71EDB66FC9;
	Mon, 11 Nov 2024 22:15:47 -0500 (EST)
Message-ID: <9589c5b673f45f02e2b0fa9d9a96eff0f0df0920.camel@xry111.site>
Subject: Re: [PATCH v2 5/5] LoongArch: Enable jump table with GCC for objtool
From: Xi Ruoyao <xry111@xry111.site>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, 	loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Tue, 12 Nov 2024 11:15:41 +0800
In-Reply-To: <62df4c24-68ed-fbfc-ed98-2df796697d89@loongson.cn>
References: <20241105123906.26072-1-yangtiezhu@loongson.cn>
	 <20241105123906.26072-6-yangtiezhu@loongson.cn>
	 <20241105141530.GE10375@noisy.programming.kicks-ass.net>
	 <62df4c24-68ed-fbfc-ed98-2df796697d89@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-06 at 13:03 +0800, Tiezhu Yang wrote:
> On 11/05/2024 10:15 PM, Peter Zijlstra wrote:
> > On Tue, Nov 05, 2024 at 08:39:06PM +0800, Tiezhu Yang wrote:
> > > For now, it is time to remove the compiler option -fno-jump-tables
> > > to enable jump table for objtool if the compiler is GCC and it has
> > > the compiler option -mannotate-tablejump, otherwise still keep the
> > > compiler option -fno-jump-tables to maintain compatibility with the
> > > older compilers.
>=20
> ...
>=20
> > >=20
> > > =C2=A0ifdef CONFIG_OBJTOOL
> > > +ifdef CONFIG_CC_IS_GCC
> > > +ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
> > > +KBUILD_CFLAGS			+=3D $(call cc-option,-mannotate-tablejump)
> > > +else
> > > =C2=A0KBUILD_CFLAGS			+=3D -fno-jump-tables
> > > =C2=A0endif
> > > +endif
> > > +ifdef CONFIG_CC_IS_CLANG
> > > +KBUILD_CFLAGS			+=3D -fno-jump-tables
> > > +endif
> > > +endif
> >=20
> > This seems excessive. Why split between GCC and Clang, isn't
> > CC_HAS_ANNOTATE_JUMPTABLE sufficient?
>=20
> Thanks for your reply.
>=20
> In theory, it is sufficient to only check CC_HAS_ANNOTATE_JUMPTABLE
> to use -fno-jump-tables or not, and also this is my initial aim.
>=20
> In fact, when compling with Clang on LoongArch, if the compiler has
> the option -mannotate-tablejump and config CC_HAS_ANNOTATE_TABLEJUMP
> is set, there still exists some objtool warnings if remove the option
> -fno-jump-tables, this is because there are some special cases such
> as different rodata relocation type and rodata entry size generated
> by Clang, I am working in progress to address the corner issues, and
> the final code looks something like this:
>=20
> ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
> KBUILD_CFLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D $(call cc-option,-man=
notate-tablejump)
> else
> KBUILD_CFLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D -fno-jump-tables
> endif

Has -mannotate-tablejump been added to Clang?  IMO it's better to add it
to Clang first, and add Clang & GCC support at once into objtool.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

