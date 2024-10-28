Return-Path: <linux-kernel+bounces-384019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B72D9B234A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792441C22680
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D05186616;
	Mon, 28 Oct 2024 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k42hSf4n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE217E016;
	Mon, 28 Oct 2024 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084058; cv=none; b=OCYDvGARydGbMAmpMGeKtJla7UZ3u5W4ojf3s9yGQ26LpubuFVDN/Ps+/6Jw44e4PThk8CpuFGsaUWPtSFOKE6A91zZMttHv86YOnAj6iQaFTfRuM/1J/Gzl1MRkjkYRB11tSE1GTCb84gxTMopZQ3oZVRl7zoDyvg7pFp0F17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084058; c=relaxed/simple;
	bh=ecVyzUwd0wuMFCUUyLBpM+3P4H8SU/a4LFzelsYnR1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwrsEz42pR637GO/QrmAfDLpoTSVlfihMrcOcP7vhXgLqqysh6yvtbBUcGpUmXHevWr6alyUUQzGh4GRZhFnpfracASXMV3SXmjCG9xLkvn4vNtc+p24E5ywdWCn1KlCmJm0bGc+dxaSLdGauWvM5e7j8WB0VCGR7IwDmxOjo6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k42hSf4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61569C4CEC3;
	Mon, 28 Oct 2024 02:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730084057;
	bh=ecVyzUwd0wuMFCUUyLBpM+3P4H8SU/a4LFzelsYnR1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k42hSf4ng8mDl8OJeWo+rxwyeyfytjzah8SwHLJRhUD240AFYz57uIfzoFM47cBz7
	 AQPGXpLpjbN1dE+Gz44pXiFi1mRGaG1UEdq9QlQtyS2JPTm6QU0U4q7qU8TLA+dcJX
	 ye6DTW78WeR0sPELJFwoC88sZUh1ot7MP3wCYYqKZvz0yeRNIaagyZJjrH7x40xuGc
	 c/rY7VlBEgbc6TqbzS/Xg/j7RlNp3+CXWdvh8znsfK3TiBStraC1JB8sToS0dk5btS
	 q+B1pLrnK3ihA/c+j4ti1TthbTXErvomOK73aQ08FdljT3ayE06irAi6LwdTAzHaFs
	 YgUnHsMvoW2yQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso7848699a12.0;
        Sun, 27 Oct 2024 19:54:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVe6cMghnJYKQm83TDzqZcDay9uz7mgOALfvmI89rhxmaxoXH21SXpJ7kKnytA8loIn0NzmzqWB8suGIG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTPSRIOF8NG4zpZEIcW6ZKowxgpNr1eyddbq7IfSI1k/bagUk
	ZjZnzFQGJOU0m6oZd0BKGvHfsv/S/dJnAy5IZrN91lHfpYprP64B2FjPiR4XDHwOXSWE43hyA4L
	QgycDRaCHDNh0Y9JO38TWo6vv/vk=
X-Google-Smtp-Source: AGHT+IFI4uJwqWiqfnsgzy+BaJOyDNHUW7eKApEia+Dv5RyczfboqsxIVf85+Bj6zpG+/iL0bP1xkxFYrIOVdW41PLc=
X-Received: by 2002:a17:907:eab:b0:a99:3db2:eb00 with SMTP id
 a640c23a62f3a-a9ad1add979mr1126355066b.28.1730084055978; Sun, 27 Oct 2024
 19:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008054615.43062-1-yang.li85200@gmail.com>
 <20241016095626.8162-1-yang.li85200@gmail.com> <CAJF2gTQ5D8fU9rSs7V28S9c5+ZPuQSJW7inQtoFsM6X6gBgOKg@mail.gmail.com>
 <CA+N+=zvG62nrmz=f1n1hCztu8k=KBg24_ZZKCWbn2Bhzd7cUdQ@mail.gmail.com>
In-Reply-To: <CA+N+=zvG62nrmz=f1n1hCztu8k=KBg24_ZZKCWbn2Bhzd7cUdQ@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 28 Oct 2024 10:54:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0bm_PSSJrXrzaL98zeJt-nguj85Dzg6zNG6Qy_JD+Vg@mail.gmail.com>
Message-ID: <CAJF2gTS0bm_PSSJrXrzaL98zeJt-nguj85Dzg6zNG6Qy_JD+Vg@mail.gmail.com>
Subject: Re: [PATCH v2] csky: fix csky_cmpxchg_fixup not working
To: yang li <yang.li85200@gmail.com>
Cc: linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi yang,


On Mon, Oct 21, 2024 at 3:51=E2=80=AFPM yang li <yang.li85200@gmail.com> wr=
ote:
>
> Hi Guo Ren:
> In C language, your conclusion is correct, but in assembly language,
>  global_symbol !=3D &global_symbol
> I did the following experiment:
>
> liyang@liyang-virtual-machine:~/Desktop/test$ ls
> main.c  test.s
> liyang@liyang-virtual-machine:~/Desktop/test$ cat test.s
>
> .globl test_symbol
> test_symbol:
>         nop
> liyang@liyang-virtual-machine:~/Desktop/test$ cat main.c
> #include <stdio.h>
>
> extern unsigned long test_symbol;
> int main(void)
> {
>         printf("test_symbol =3D 0x%lx\n",(unsigned long)test_symbol);
>         printf("&test_symbol =3D 0x%lx\n",(unsigned long)&test_symbol);
>
>         printf("main =3D 0x%lx\n",(unsigned long)main);
>         printf("&main =3D 0x%lx\n",(unsigned long)&main);
> }
> liyang@liyang-virtual-machine:~/Desktop/test$ gcc main.c test.s --static =
-o test
> liyang@liyang-virtual-machine:~/Desktop/test$ ls
> main.c  test  test.s
> liyang@liyang-virtual-machine:~/Desktop/test$ readelf test -s | grep test=
_symbol
>    884: 000000000040170c     0 NOTYPE  GLOBAL DEFAULT    7 test_symbol
> liyang@liyang-virtual-machine:~/Desktop/test$ readelf test -s | grep main=
 -w
>   1605: 0000000000401685   135 FUNC    GLOBAL DEFAULT    7 main
> liyang@liyang-virtual-machine:~/Desktop/test$ ./test
> test_symbol =3D 0x4b853001f0f90
> &test_symbol =3D 0x40170c
> main =3D 0x401685
> &main =3D 0x401685
>
> The above test can lead to the conclusion that:
> Both c_symbol and &c_symbol represent the address of a symbol, but
> &ASM_symbol represents the address of a symbol while ASM_symbol
>  represents the opcode stored at that address.
>
> On Thu, Oct 17, 2024 at 2:05=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Wed, Oct 16, 2024 at 5:56=E2=80=AFPM Yang Li <yang.li85200@gmail.com=
> wrote:
> > >
> > > In the csky_cmpxchg_fixup function, it is incorrect to use the global
> > >  variable csky_cmpxchg_stw to determine the address where the excepti=
on
> > >  occurred.The global variable csky_cmpxchg_stw stores the opcode at t=
he
> > >  time of the exception, while &csky_cmpxchg_stw shows the address whe=
re
> > >  the exception occurred.
> > >
> > > Signed-off-by: Yang Li <yang.li85200@gmail.com>

You convinced me. Applied to csky/linux-next, thanks!


> > > ---
> > > V1 -> V2:Eliminate compilation warnings
> > >
> > >  arch/csky/mm/fault.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> > > index a885518ce1dd..5226bc08c336 100644
> > > --- a/arch/csky/mm/fault.c
> > > +++ b/arch/csky/mm/fault.c
> > > @@ -45,8 +45,8 @@ static inline void csky_cmpxchg_fixup(struct pt_reg=
s *regs)
> > >         if (trap_no(regs) !=3D VEC_TLBMODIFIED)
> > >                 return;
> > >
> > > -       if (instruction_pointer(regs) =3D=3D csky_cmpxchg_stw)
> > > -               instruction_pointer_set(regs, csky_cmpxchg_ldw);
> > > +       if (instruction_pointer(regs) =3D=3D (unsigned long)&csky_cmp=
xchg_stw)
> > > +               instruction_pointer_set(regs, (unsigned long)&csky_cm=
pxchg_ldw);
> > csky_cmpxchg_ldw(stw) is a label symbol, not a variable.
> >
> > arch/csky/kernel/atomic.S:
> > GLOBAL(csky_cmpxchg_ldw)
> > GLOBAL(csky_cmpxchg_stw)
> >
> > Your modification does not affect the ASM output.
> >
> > (gdb) p main
> > $1 =3D {void (void)} 0x5fa <main>
> > (gdb) p &main
> > $2 =3D (void (*)(void)) 0x5fa <main>
> >
> > >         return;
> > >  }
> > >  #endif
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--
Best Regards
 Guo Ren

