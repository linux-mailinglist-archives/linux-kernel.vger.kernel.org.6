Return-Path: <linux-kernel+bounces-243157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB3929297
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009C7281744
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0262561FCE;
	Sat,  6 Jul 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="FAtDbflc"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2365482C6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720262041; cv=none; b=cP1T61cB6sVHv3V4uyRMMqxoRyG/g5uKJmHMSe7T5GFTDJxNLnaRDQ1iF8oe9Defn+1zk6NMa0XF6zJ2C/4G4gg7yIdyw0KkXmcDSlLwzQHAdTrowp5MvExxICxPJslqdRYLMpwyLg/LISsL8D+vhaNurWOj+8IeMrfVLJ388JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720262041; c=relaxed/simple;
	bh=bTtWeZRzbbPRWBKxo6xX5E59qwVMl0ItQh6g88f4jzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYHLEXOPbLQEB5VBaDmyBRBQbGV5cYO3XwzyltxpkEljry7nQZWNEPM+8SXiDqdU9ny49JF3h7oIbjxJSXSsK1ommWNO2PCapD8VXbQs8qetKKVnuqIvZb/BJ4nXaxf+Bdhp5NKlv1QmZHZwqr1b6LmPf9AKk7MY080NezaSkL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=FAtDbflc; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1720262037;
	bh=bTtWeZRzbbPRWBKxo6xX5E59qwVMl0ItQh6g88f4jzo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FAtDbflcwVxItID1+bTWivDzc9tvnzzeHOpdZIV9kzv2akw8YgvTlH8oInVTmHqV5
	 eWvSpzHTizW2JRqH8oJjS0ZQNNeL4gv2HXIL6guP1+RID1RHZ2LDR3ki811o55BzXz
	 6P3CLAYE6ktE2jlRsdrRgS0moAJFd9ximJoHoKtk=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 7F9F366E91;
	Sat,  6 Jul 2024 06:33:55 -0400 (EDT)
Message-ID: <cb3c2038b97689371226c467befdbf9e13113744.camel@xry111.site>
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
Date: Sat, 06 Jul 2024 18:33:53 +0800
In-Reply-To: <CAAhV-H6K7SXtXpv9Udo8md0sdn+40TGPTCdSPeM1HmbJqrhboQ@mail.gmail.com>
References: <20240706073858.161035-1-xry111@xry111.site>
	 <20240706073858.161035-2-xry111@xry111.site>
	 <CAAhV-H6K7SXtXpv9Udo8md0sdn+40TGPTCdSPeM1HmbJqrhboQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-07-06 at 18:29 +0800, Huacai Chen wrote:

/* snip */

> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index ddc042895d01..03b3ef5edd24 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -607,6 +607,7 @@ config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> >=20
> > =C2=A0config RELOCATABLE
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Relocatable kernel"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAS_RELR
> Why is this selection under RELOCATABLE? I know ARM64 is the same, but
> why?

Because if we just select it in CONFIG_LOONGARCH instead of
CONFIG_RELOCATABLE, the users who have disabled CONFIG_RELOCATABLE will
still see the entry for RELR in their configuration interface.  And
they'll ask "hey what's this for?  Why my kernel needs relocation?"

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

