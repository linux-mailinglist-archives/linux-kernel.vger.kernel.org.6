Return-Path: <linux-kernel+bounces-243277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9029293EB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D9A1B22105
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A2071B3A;
	Sat,  6 Jul 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AraKd74W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CF4C3D0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720273791; cv=none; b=FU2yX+sfJ10ElYWdMoRTvMpIx72n+bAxliXlhapIT+XbPUjnrzLOoTkrdvXZ65sBQi84wjCjW0YHuMewxi2V1tqFmitybFcmu5N6eOg6fxKGFgdhZdkCjcbryVfCeKeclkmO+EOjrj38aU/1LzzUgBKIWB2GWzj1ZKhAjbP8YlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720273791; c=relaxed/simple;
	bh=WwtWGqd3b7WM+nXM9jFiZlnjseqVlB8/RHiBNoQSNnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKX36ZAk2Zrw0as2Cu3Qq1Upu1z9lc31TZUyaMV5q9Bm3jEH6qaluk9HVA0lpwS2QOk3NR/FnEHAwrMTwLdTdV9oOB4XNRPn49hYkDUiIYuEJsHEX9TylwP5AbfTXKuaIJAAK4rbKx8XCnYvgoA/Q0paPRLCnB/vVq5dKV3RSEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AraKd74W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81ABC4AF0B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720273790;
	bh=WwtWGqd3b7WM+nXM9jFiZlnjseqVlB8/RHiBNoQSNnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AraKd74WGwCrXja+sF7XhgkgSatRVC7niFdoj1uE44TAPqjk3GA9dfBZLzH1LRGmS
	 dPk2/zQTTjQ+k0sR71HET5EJ2k6em3sBbdaO6vr+H9pCO1C42TNv3gE6yRaejpPioN
	 DqaYh0aIYS8pw+DsroFQDobC2O5Xq8MgI++Tp8pH5lO9aPF9zuXdS+te8M1aigJAuH
	 CDondeIMCWYy/QS5Zf1JUjF5/c5XI1svdUU82tKiAEYNoEAvpMwqtpHmDLCvCTBSz1
	 /0OhiE5u2gtrQPI51nT3yKs9tV/v2g/zHrAEgsos0LsjSmBsoxpS1+pQhGebppX1JY
	 zY01yZgfr3ksQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77b550128dso313514066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 06:49:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0e9QKuYQ6er39k0H9K2twpF44irCc3qlwGcBN2KW2u0T5SG3KfBvZ9w5fKzUMAg/hZUqX17bADNJcROEbqYKW+O1PMoDEsg0vPj3J
X-Gm-Message-State: AOJu0Yy8sFur2uAh5BkmxqzKP6TCScIIIU8Sk4DtL7utuWkHccyGjqdB
	A9kEz3eaaIvJ74zvE2aY/h3nlgXOj5YGhXltjBCUTRnMcGbCpsVEV1khQPqc+nFAcRqBdj0Azmc
	B5JNqQtij690IhFx+kykS6lEUn1I=
X-Google-Smtp-Source: AGHT+IESGgckyWRKHZbg0sq8z9FEAOZ/7LM0DfdCM/NpkuRRuuAsW+3xXiTKLmrRqbU3XT7zJUed4tVMreQO5TRl/aA=
X-Received: by 2002:a17:906:aed1:b0:a77:b01b:f949 with SMTP id
 a640c23a62f3a-a77ba48cfc6mr558366566b.35.1720273789487; Sat, 06 Jul 2024
 06:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706073858.161035-1-xry111@xry111.site> <20240706073858.161035-2-xry111@xry111.site>
 <CAAhV-H6K7SXtXpv9Udo8md0sdn+40TGPTCdSPeM1HmbJqrhboQ@mail.gmail.com> <cb3c2038b97689371226c467befdbf9e13113744.camel@xry111.site>
In-Reply-To: <cb3c2038b97689371226c467befdbf9e13113744.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 6 Jul 2024 21:49:40 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4CQMmrLRv=vi8N63p2NXbdozpDakJLia8soFvVohCbqQ@mail.gmail.com>
Message-ID: <CAAhV-H4CQMmrLRv=vi8N63p2NXbdozpDakJLia8soFvVohCbqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Add support for relocating the kernel with
 RELR relocation
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Jinyang He <hejinyang@loongson.cn>, 
	Youling Tang <tangyouling@kylinos.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Fangrui Song <maskray@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 6:34=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Sat, 2024-07-06 at 18:29 +0800, Huacai Chen wrote:
>
> /* snip */
>
> > > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > > index ddc042895d01..03b3ef5edd24 100644
> > > --- a/arch/loongarch/Kconfig
> > > +++ b/arch/loongarch/Kconfig
> > > @@ -607,6 +607,7 @@ config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> > >
> > >  config RELOCATABLE
> > >         bool "Relocatable kernel"
> > > +       select ARCH_HAS_RELR
> > Why is this selection under RELOCATABLE? I know ARM64 is the same, but
> > why?
>
> Because if we just select it in CONFIG_LOONGARCH instead of
> CONFIG_RELOCATABLE, the users who have disabled CONFIG_RELOCATABLE will
> still see the entry for RELR in their configuration interface.  And
> they'll ask "hey what's this for?  Why my kernel needs relocation?"
RELR is not a similar conception to RELA, it is only used for
relocatable kernel?

Huacai

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

