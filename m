Return-Path: <linux-kernel+bounces-232114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C191A3AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAF01F233B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AFE13D62E;
	Thu, 27 Jun 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Y2phWd0I"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9013AA31
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483833; cv=none; b=Qg3EB6NQmZBd6zOJwki7H4cWweTdsweHi3GkDN6HlVYrbys9MMyHU/rsS00h389uaYIQu+jxMJjJToAfIGaN+nQNYCopi0fhm49UKv9AmgqIJckZtGNYtgjq0dW68hY0neGIXexoEfaRrB62xy0+eUsfHhh6kXG9/AaOqumQzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483833; c=relaxed/simple;
	bh=V2iCRNYIZfv8hzWiv0rUWwAWuz4BVLEmbUquLihadKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jT+iF7GuL8WQojoE02uS72lRYpMHUhSpwdSBmiuzFF/eoG2nIyNwli+516F4tfFApaVOoK+9z/qqDZn8MON5kv6d1bGPl5AzoYFKjAvAFuIi63Im1JmIiI4QmozdX2T6zySHAD0VohgzNl0RZxsrvMpTFPyhuE7/NKwdDp6wz4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Y2phWd0I; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48f760f89c3so952623137.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719483830; x=1720088630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4tiTxCE/s+Dw1a6GkDoGE0tXaKfxvAhXGFctBcchYc=;
        b=Y2phWd0I3GKuEjfG4RFUGbSb3wPR3dCy9jkai9F+hFwflNVfpmHfawCgP9N4yfH3EF
         VhBUxEe2GymVDTsQ9cJ40KZYGHZwMN/G23KzVhniOHv/Hplxn5mOfkCN4Ykmp9CuU//c
         T7BgO8bN3eMvAbHRPLokH2y+ZBaWRIt1I/6GW4TM1oMwwc8ETyv/XPo3v44fDjTlF80W
         MT72SUPt/UXBlKhnFRnFGgDKWgv9PXPc3Ls4NBvOqtBaQWkuD2cxdOnLNzmXHisKyT2r
         htGZV5U0Bf8/MNaDJOU4o2pMlTyn9hRhYN1ajT4nBW19IRKuaqdQIX76rzAmpgCN6txx
         474w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719483830; x=1720088630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4tiTxCE/s+Dw1a6GkDoGE0tXaKfxvAhXGFctBcchYc=;
        b=ABkq34pYu651Lmnpz4FvOME4Dk9xyNBPN8rXFXyfgI4AZFhJZ9ZP4CvTLG+Wz1uyoS
         GzLv6ivwFuSkEMo0Exn2Tp19f7Vkxheec618beBpdW2wHj7T1P/DT5Vaf/1zO+74vGJ2
         rjG1u1naQmK7+IkqTOKhfKEWtsTG16ZJACgyj9OCFiLc1GrcTpGkhaBxsn7ZK/VNkZdP
         gWfJmOWfDKtuhWT8ftKGuJ8/9Ht/rFFU0RcpXpU2FzQFjWJYV0FZFUMgtT1bAhmmMoMA
         9F/k1zXpVOUx+E+UONFZtqTPh0OQbKLpCrPIlyJZE6tKxIMr3jjyTqUXyDuuX2A9LdHB
         KeNw==
X-Forwarded-Encrypted: i=1; AJvYcCUNHC5cWC7GMIOf1lhfBdxxvOz7APWokIEoepHSG9sb+LL35lmbUxOedxJWgBjXsNeVvK8E9Ei7hOjl3RALaslz83OCffEJX8Jz/zgk
X-Gm-Message-State: AOJu0YzuFd5nbIj43lBIK8csUvsOVKFEyBzM+CZe89LD+weTBpQ8cLiM
	Vti9BeeRtoyylymbSldW3bM0blG5+yQPEHb+Ygbktog2ndhAPRTuSSFOX1llXhiDu2ER1iqgFwx
	2d4GkolNefe3vPzjkWaO0yOsw+s68LL04DBmS
X-Google-Smtp-Source: AGHT+IHDmkmKAFG735sI5VBOQUgWmEi6dVBx0++cMhpfNtbIPeMESeasdcYtz3re8mbbPiX2Bsw2pcJrJK82es+TJgI=
X-Received: by 2002:a05:6102:401:b0:48f:92db:8cc6 with SMTP id
 ada2fe7eead31-48f92dba4abmr553246137.1.1719483830137; Thu, 27 Jun 2024
 03:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
 <20240627071422.GA2626@altlinux.org> <9c102328-6bb3-46b6-bc2f-d011a284d5b0@gmail.com>
 <CA+FstbVf7TJx==WsY5fBoFrdeY8php5ETn8kMq5s6YScy-2O=A@mail.gmail.com> <20240627095258.GA2977@altlinux.org>
In-Reply-To: <20240627095258.GA2977@altlinux.org>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Date: Thu, 27 Jun 2024 12:23:39 +0200
Message-ID: <CA+FstbUhDy8tjvxZX9k6TOT9xn4CE57AXdjWOemZR19Y5xfsWQ@mail.gmail.com>
Subject: Re: [PATCH v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Celeste Liu <coelacanthushex@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Guo Ren <guoren@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andreas Schwab <schwab@suse.de>, David Laight <David.Laight@aculab.com>, 
	Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, 
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, "Ivan A. Melnikov" <iv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 11:52=E2=80=AFAM Dmitry V. Levin <ldv@strace.io> wr=
ote:
>
> On Thu, Jun 27, 2024 at 11:43:03AM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > On Thu, Jun 27, 2024 at 9:47=E2=80=AFAM Celeste Liu <coelacanthushex@gm=
ail.com> wrote:
> > > On 2024-06-27 15:14, Dmitry V. Levin wrote:
> > >
> > > > Hi,
> > > >
> > > > On Tue, Aug 01, 2023 at 10:15:16PM +0800, Celeste Liu wrote:
> > > >> When we test seccomp with 6.4 kernel, we found errno has wrong val=
ue.
> > > >> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we=
 will
> > > >> get ENOSYS instead. We got same result with commit 9c2598d43510 ("=
riscv:
> > > >> entry: Save a0 prior syscall_enter_from_user_mode()").
> > > >>
> > > >> After analysing code, we think that regs->a0 =3D -ENOSYS should on=
ly be
> > > >> executed when syscall !=3D -1. In __seccomp_filter, when seccomp r=
ejected
> > > >> this syscall with specified errno, they will set a0 to return numb=
er as
> > > >> syscall ABI, and then return -1. This return number is finally pas=
s as
> > > >> return number of syscall_enter_from_user_mode, and then is compare=
d with
> > > >> NR_syscalls after converted to ulong (so it will be ULONG_MAX). Th=
e
> > > >> condition syscall < NR_syscalls will always be false, so regs->a0 =
=3D -ENOSYS
> > > >> is always executed. It covered a0 set by seccomp, so we always get
> > > >> ENOSYS when match seccomp RET_ERRNO rule.
> > > >>
> > > >> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> > > >> Reported-by: Felix Yan <felixonmars@archlinux.org>
> > > >> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
> > > >> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
> > > >> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> > > >> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> > > >> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> > > >> Tested-by: Felix Yan <felixonmars@archlinux.org>
> > > >> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.co=
m>
> > > >> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > > >> Reviewed-by: Guo Ren <guoren@kernel.org>
> > > >> ---
> > > >>
> > > >> v4 -> v5: add Tested-by Emil Renner Berthing <emil.renner.berthing=
@canonical.com>
> > > >> v3 -> v4: use long instead of ulong to reduce type cast and avoid
> > > >>           implementation-defined behavior, and make the judgment o=
f syscall
> > > >>           invalid more explicit
> > > >> v2 -> v3: use if-statement instead of set default value,
> > > >>           clarify the type of syscall
> > > >> v1 -> v2: added explanation on why always got ENOSYS
> > > >>
> > > >>  arch/riscv/kernel/traps.c | 6 +++---
> > > >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >>
> > > >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > > >> index f910dfccbf5d2..729f79c97e2bf 100644
> > > >> --- a/arch/riscv/kernel/traps.c
> > > >> +++ b/arch/riscv/kernel/traps.c
> > > >> @@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_tr=
ap_break(struct pt_regs *regs)
> > > >>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct p=
t_regs *regs)
> > > >>  {
> > > >>      if (user_mode(regs)) {
> > > >> -            ulong syscall =3D regs->a7;
> > > >> +            long syscall =3D regs->a7;
> > > >>
> > > >>              regs->epc +=3D 4;
> > > >>              regs->orig_a0 =3D regs->a0;
> > > >> @@ -306,9 +306,9 @@ asmlinkage __visible __trap_section void do_tr=
ap_ecall_u(struct pt_regs *regs)
> > > >>
> > > >>              syscall =3D syscall_enter_from_user_mode(regs, syscal=
l);
> > > >>
> > > >> -            if (syscall < NR_syscalls)
> > > >> +            if (syscall >=3D 0 && syscall < NR_syscalls)
> > > >>                      syscall_handler(regs, syscall);
> > > >> -            else
> > > >> +            else if (syscall !=3D -1)
> > > >>                      regs->a0 =3D -ENOSYS;
> > > >>
> > > >>              syscall_exit_to_user_mode(regs);
> > > >
> > > > Unfortunately, this change introduced a regression: it broke strace
> > > > syscall tampering on riscv.  When the tracer changes syscall number=
 to -1,
> > > > the kernel fails to initialize a0 with -ENOSYS and subsequently fai=
ls to
> > > > return the error code of the failed syscall to userspace.
> > >
> > > In the patch v2, we actually do the right thing. But as Bj=C3=B6rn T=
=C3=B6pel's
> > > suggestion and we found cast long to ulong is implementation-defined
> > > behavior in C, so we change it to current form. So revert this patch =
and
> > > apply patch v2 should fix this issue. Patch v2 uses ths same way with
> > > other architectures.
> > >
> > > [1]: https://lore.kernel.org/all/20230718162940.226118-1-Coelacanthus=
Hex@gmail.com/
> >
> > Not reverting, but a fix to make sure that a0 is initialized to -ENOSYS=
, e.g.:
> >
> > --8<--
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index 05a16b1f0aee..51ebfd23e007 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -319,6 +319,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
> >
> >   regs->epc +=3D 4;
> >   regs->orig_a0 =3D regs->a0;
> > + regs->a0 =3D -ENOSYS;
>
> Given that struct user_regs_struct doesn't have orig_a0, wouldn't this
> clobber a0 too early so that the tracer will get -ENOSYS in place of the
> first syscall argument?

No, that's ok. It's handled by various wrappers where the arguments
are pulled out.


Bj=C3=B6rn

