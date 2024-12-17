Return-Path: <linux-kernel+bounces-448424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C53759F3FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E486A1882682
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D8C26AF5;
	Tue, 17 Dec 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQXnJFij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651E8467
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734398558; cv=none; b=GJg4wuAUyU7JSLoedp/tRmxYMlPc8ZPum4ud0434JKRgOoyE1yCMRJPh4RuGyzKyAPn3OQGf8Fq5okswokJXTOpPtF2/3zWyjwOLmT/JtMs0co4RhreDy53xJe6hSl+2O5bxYMg9HxdhjEi6DF1nMfsOvEIBp63x5wB5vBmLkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734398558; c=relaxed/simple;
	bh=ztbDHdD003AOFmkjJ9AhaS5FsmU905bwNd9pOiS40QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKwpsoe4EiDRvJSBNg9PoDsHnZ/sYR0tObLxkniLUhbvy0jXlzA4/oDgwrlyfEpFxJTmvuUkWOiw7z1bI1eNRw4REhZM+reiGT7LvqOEb+gyipgSZlLJ1mgh9vnR2QqMzVHj/h6IPGKGQ+cOmo7VMiDnLfsL/qRdU8Fn0eLJ1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQXnJFij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008A5C4CED7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734398558;
	bh=ztbDHdD003AOFmkjJ9AhaS5FsmU905bwNd9pOiS40QQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bQXnJFijtV5PYaCHuXV+fDuIxmLKmMaASLcShIDiz9au4NTHOgSCymUL1zC7V8OnP
	 qu+r3Jw+SlabWIdGRWMVSfJDCFn5coaS9H7vWFtEXZ+r8AX9hQlzoY4MUq0+7qyPiY
	 0fdiyrCcTQjooc0cAP1DToOXzWMo7kPUwzvdeeYri/IDHyd5WcIkX+QK4EdSqNzOJg
	 laZ1OqAbc3g/HHWTvePXK4G346BIK4lfa7EyUxQwdFRXAWx9EjWe/AlRoFriTiMBoz
	 EyowMJjlslrOceGMFSc3lE41CQMolxPgh75D5Qf+2stdpWY0updL/nf8q+SGUCPK/A
	 qhFT4m4Sm+v7w==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df91so6654264a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:22:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlF173pF70OiGR1Rl6NDEctE3vQNEo4+AJoDuiSpaYSfiT4yoCr17RMhP/ZhUp4GrK1OgZquciQ4QXlaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHYIccCnfF6wmmq9a7vC9EM0avf+hOXGtsp9ClfnO0gR0LVGd
	NFhZHijs2YE9OXWfvXo2XibPbWSkpXRMPzU/on5KgUp7NZIkSx6P5vu7A4yg44yk018I17vzSUX
	hd9gq0u3IBrEofBU4h6vIxGqCBro=
X-Google-Smtp-Source: AGHT+IGp8AFySWj1OjXr6Yj19dq7LENEnmWaczQRT6IvNs2FTaqIFLXG8Tco51vkdEVUnOPFQLjGN9K3Olb69FIPR8g=
X-Received: by 2002:a05:6402:518f:b0:5d2:729f:995b with SMTP id
 4fb4d7f45d1cf-5d63c3ad372mr13239770a12.24.1734398556585; Mon, 16 Dec 2024
 17:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216032253.685728-1-guoren@kernel.org> <20241216-2d9b35cb1911106971a54356@orel>
In-Reply-To: <20241216-2d9b35cb1911106971a54356@orel>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 17 Dec 2024 09:22:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRGJAKepU1HCaG-aw5WqJdyGftTox-Q+LyOrHPbxxn_nA@mail.gmail.com>
Message-ID: <CAJF2gTRGJAKepU1HCaG-aw5WqJdyGftTox-Q+LyOrHPbxxn_nA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Implement smp_cond_load8/16() with Zawrs
To: Andrew Jones <ajones@ventanamicro.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com, 
	conor@kernel.org, leobras@redhat.com, alexghiti@rivosinc.com, 
	christoph.muellner@vrull.eu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, parri.andrea@gmail.com, ericchancf@google.com, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 11:42=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Sun, Dec 15, 2024 at 10:22:53PM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > RISC-V code uses the queued spinlock implementation, which calls
> > the macros smp_cond_load_acquire for one byte. So, complement the
> > implementation of byte and halfword versions.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/cmpxchg.h | 38 +++++++++++++++++++++++++++++---
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index 4cadc56220fe..2bd42a11ff8f 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -365,16 +365,48 @@ static __always_inline void __cmpwait(volatile vo=
id *ptr,
> >  {
> >       unsigned long tmp;
> >
> > +     u32 *__ptr32b;
> > +     ulong __s, __val, __mask;
> > +
> >       asm goto(ALTERNATIVE("j %l[no_zawrs]", "nop",
> >                            0, RISCV_ISA_EXT_ZAWRS, 1)
> >                : : : : no_zawrs);
> >
> >       switch (size) {
> >       case 1:
> > -             fallthrough;
> > +             __ptr32b =3D (u32 *)((ulong)(ptr) & ~0x3);
> > +             __s =3D ((ulong)(ptr) & 0x3) * BITS_PER_BYTE;
> > +             __val =3D val << __s;
> > +             __mask =3D 0xf << __s;
>
> This mask should be 0xff and the mask below should be 0xffff.
Thx for catching it; it's hard to test it out. I will correct it in
the next version.

>
> > +
> > +             asm volatile(
> > +             "       lr.w    %0, %1\n"
> > +             "       and     %0, %0, %3\n"
> > +             "       xor     %0, %0, %2\n"
> > +             "       bnez    %0, 1f\n"
> > +                     ZAWRS_WRS_NTO "\n"
> > +             "1:"
> > +             : "=3D&r" (tmp), "+A" (*(__ptr32b))
> > +             : "r" (__val), "r" (__mask)
> > +             : "memory");
> > +             break;
> >       case 2:
> > -             /* RISC-V doesn't have lr instructions on byte and half-w=
ord. */
> > -             goto no_zawrs;
> > +             __ptr32b =3D (u32 *)((ulong)(ptr) & ~0x3);
> > +             __s =3D ((ulong)(ptr) & 0x2) * BITS_PER_BYTE;
> > +             __val =3D val << __s;
> > +             __mask =3D 0xff << __s;
> > +
> > +             asm volatile(
> > +             "       lr.w    %0, %1\n"
> > +             "       and     %0, %0, %3\n"
> > +             "       xor     %0, %0, %2\n"
> > +             "       bnez    %0, 1f\n"
> > +                     ZAWRS_WRS_NTO "\n"
> > +             "1:"
> > +             : "=3D&r" (tmp), "+A" (*(__ptr32b))
> > +             : "r" (__val), "r" (__mask)
> > +             : "memory");
> > +             break;
> >       case 4:
> >               asm volatile(
> >               "       lr.w    %0, %1\n"
> > --
> > 2.40.1
> >
>
> Thanks,
> drew



--=20
Best Regards
 Guo Ren

