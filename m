Return-Path: <linux-kernel+bounces-373843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBFE9A5D92
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CAE1F21049
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98221E0E05;
	Mon, 21 Oct 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcpea5Iv"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3CD1D1308;
	Mon, 21 Oct 2024 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497095; cv=none; b=aq8XbtJ4WqfiB6hkl87H6tWkAiDIpSztpzpJ9pbTkYONRizCROCbJ5IeFaA+m2xnyc72iUcyyJohlTfb3vBU1lBbwFNb0bpWnwQKJ6XNGrbQEsZSpo2+wyz842ib5dJCJ9byVzcyu7nn4cnAk0PsG4yiQ2prpqrnbF8AKC4HvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497095; c=relaxed/simple;
	bh=B/+QQSXeVAV8qhjBIr60FMU2TxAWb7d3IKRFyK1/9xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtE5gGcOLeHk3lb6O7ec8c1k0b15hZuxv1n/g4ItGUDbHNTtW0vneLBHztJIb37QEWLRSRwxRkWRMaIvG+7lVrzIsCVrfHCdv4yyfI1aHAxMahvIPjjo3ocHUEo0enDunyq8maLz1tlGsVnii8WJtJjWMhmGSRX29mhxb8AfSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lcpea5Iv; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso38390991fa.3;
        Mon, 21 Oct 2024 00:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729497091; x=1730101891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYx22NJnU8m5zMVc9qXfVExwyrt1nX+c8Lx7LpR9E7U=;
        b=Lcpea5Iv7dcABLRONIvriWaYX5bxGRLvo6tk/o6z5pv3evYDtqM7MZJjkxCudrXKZg
         1lXBZNuRroQ1qNgC1/vfW5BYdJvYr+KJ3FWW2byXsozeBcH1/MSIHGxZ5IZAXx6eKTNU
         QGZVnNtvkjxo7m768PcLQzR5x5u3zMaSFtHf266Z0xjwEXCTSK+0MmAjY1KZeU8XG3Hq
         yodUPqv1QbD0V5MhYV7PMriaF88J4dkaK4SkjeDsnwwwbPbkmsie4ve2MU2ZwURAU3xW
         lMFwNYF6YRK7cTRNwep4vxa1/VtnwZS0fc/0SlS7PMcUo72w21E90LnJqXzJitmWblvM
         88Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729497091; x=1730101891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYx22NJnU8m5zMVc9qXfVExwyrt1nX+c8Lx7LpR9E7U=;
        b=hu8QsPKt/LKi2qpqluww48eb+NEGmGjzmnrNiaa3fbFLkKvH/f4yIjYv3rN4wuMNOP
         +siCkknYlBoyzwM/50hE97OQYqYmljPePuq4aAhdIG/l5RuJCTdCssVNeB5Q/hFd81/7
         eOqXgXsTi6p91+XDJ5D7HGNcY9V30n4JT2rwDqaI7B9ZNISr5N6r3nABCEthQlP+vXs+
         UlIt293q30W9TrSD7sTkNpsdkZXwhWMm/u04ZI9LQwlp8BHoo/q7PiiuG8IPev6u5rGk
         IdDvtsPwNWnPM5pLXhwZwtxD+USAISQ/0LN1G/J6TS+JhFc6fZ7D4MAfBiWX+zNKOk6k
         Klqg==
X-Forwarded-Encrypted: i=1; AJvYcCWAh8DhdGoCG6NHTYcHaE0E5lo78HgDvRH+bk+QBZpb1fCuSc2D4xVFZTkp6kPcW3wumIq7cRUumSSCw6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4E//IVlSXNVW1AKaEly/Sgb4Rsi6wSUFqhKYv3BRe0bG2S0YS
	CGy2SEU3NKcvRsMV7i7vE2hkuP+FNOsKTIPBi0e+qMVRYp+8vl0DBLKhB+H3FZsxeSPQrdpqmWa
	WFUXtpG+hM0Q7UrmNCBcIlf4m+A0=
X-Google-Smtp-Source: AGHT+IFLOGfRY6ct8GZX60Bpp0Uwa+HWCtZXKnr+ZCoywSARUvYnfkMVWHh22+t6nOSTCIzfAZgCV7d8s1MikHvXzeI=
X-Received: by 2002:a2e:be0f:0:b0:2f7:4f84:50a2 with SMTP id
 38308e7fff4ca-2fb832020b6mr43469821fa.31.1729497090839; Mon, 21 Oct 2024
 00:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008054615.43062-1-yang.li85200@gmail.com>
 <20241016095626.8162-1-yang.li85200@gmail.com> <CAJF2gTQ5D8fU9rSs7V28S9c5+ZPuQSJW7inQtoFsM6X6gBgOKg@mail.gmail.com>
In-Reply-To: <CAJF2gTQ5D8fU9rSs7V28S9c5+ZPuQSJW7inQtoFsM6X6gBgOKg@mail.gmail.com>
From: yang li <yang.li85200@gmail.com>
Date: Mon, 21 Oct 2024 15:51:18 +0800
Message-ID: <CA+N+=zvG62nrmz=f1n1hCztu8k=KBg24_ZZKCWbn2Bhzd7cUdQ@mail.gmail.com>
Subject: Re: [PATCH v2] csky: fix csky_cmpxchg_fixup not working
To: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo Ren:
In C language, your conclusion is correct, but in assembly language,
 global_symbol !=3D &global_symbol
I did the following experiment:

liyang@liyang-virtual-machine:~/Desktop/test$ ls
main.c  test.s
liyang@liyang-virtual-machine:~/Desktop/test$ cat test.s

.globl test_symbol
test_symbol:
        nop
liyang@liyang-virtual-machine:~/Desktop/test$ cat main.c
#include <stdio.h>

extern unsigned long test_symbol;
int main(void)
{
        printf("test_symbol =3D 0x%lx\n",(unsigned long)test_symbol);
        printf("&test_symbol =3D 0x%lx\n",(unsigned long)&test_symbol);

        printf("main =3D 0x%lx\n",(unsigned long)main);
        printf("&main =3D 0x%lx\n",(unsigned long)&main);
}
liyang@liyang-virtual-machine:~/Desktop/test$ gcc main.c test.s --static -o=
 test
liyang@liyang-virtual-machine:~/Desktop/test$ ls
main.c  test  test.s
liyang@liyang-virtual-machine:~/Desktop/test$ readelf test -s | grep test_s=
ymbol
   884: 000000000040170c     0 NOTYPE  GLOBAL DEFAULT    7 test_symbol
liyang@liyang-virtual-machine:~/Desktop/test$ readelf test -s | grep main -=
w
  1605: 0000000000401685   135 FUNC    GLOBAL DEFAULT    7 main
liyang@liyang-virtual-machine:~/Desktop/test$ ./test
test_symbol =3D 0x4b853001f0f90
&test_symbol =3D 0x40170c
main =3D 0x401685
&main =3D 0x401685

The above test can lead to the conclusion that:
Both c_symbol and &c_symbol represent the address of a symbol, but
&ASM_symbol represents the address of a symbol while ASM_symbol
 represents the opcode stored at that address.

On Thu, Oct 17, 2024 at 2:05=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Oct 16, 2024 at 5:56=E2=80=AFPM Yang Li <yang.li85200@gmail.com> =
wrote:
> >
> > In the csky_cmpxchg_fixup function, it is incorrect to use the global
> >  variable csky_cmpxchg_stw to determine the address where the exception
> >  occurred.The global variable csky_cmpxchg_stw stores the opcode at the
> >  time of the exception, while &csky_cmpxchg_stw shows the address where
> >  the exception occurred.
> >
> > Signed-off-by: Yang Li <yang.li85200@gmail.com>
> > ---
> > V1 -> V2:Eliminate compilation warnings
> >
> >  arch/csky/mm/fault.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> > index a885518ce1dd..5226bc08c336 100644
> > --- a/arch/csky/mm/fault.c
> > +++ b/arch/csky/mm/fault.c
> > @@ -45,8 +45,8 @@ static inline void csky_cmpxchg_fixup(struct pt_regs =
*regs)
> >         if (trap_no(regs) !=3D VEC_TLBMODIFIED)
> >                 return;
> >
> > -       if (instruction_pointer(regs) =3D=3D csky_cmpxchg_stw)
> > -               instruction_pointer_set(regs, csky_cmpxchg_ldw);
> > +       if (instruction_pointer(regs) =3D=3D (unsigned long)&csky_cmpxc=
hg_stw)
> > +               instruction_pointer_set(regs, (unsigned long)&csky_cmpx=
chg_ldw);
> csky_cmpxchg_ldw(stw) is a label symbol, not a variable.
>
> arch/csky/kernel/atomic.S:
> GLOBAL(csky_cmpxchg_ldw)
> GLOBAL(csky_cmpxchg_stw)
>
> Your modification does not affect the ASM output.
>
> (gdb) p main
> $1 =3D {void (void)} 0x5fa <main>
> (gdb) p &main
> $2 =3D (void (*)(void)) 0x5fa <main>
>
> >         return;
> >  }
> >  #endif
> > --
> > 2.34.1
> >
>
>
> --
> Best Regards
>  Guo Ren

