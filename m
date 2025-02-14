Return-Path: <linux-kernel+bounces-515255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D215A36273
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8DE7A466A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064EE2673A7;
	Fri, 14 Feb 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Obkl0/L1"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23412673A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548658; cv=none; b=cDY9CmTCgjNp9/GIFPHOjURtap88Bxk+NB35k+gbF9wQmrhCvgLUnCR5flCYCKHQwiCGqg3h7UoXNg82xITQ56aLd+LIrdC6T+JUSOsOmIEKz7Z796plGFUfnehe8qyX5u8fIvixr34B8EXKMxpZZIDaiUkwq3od/qg4ZygY/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548658; c=relaxed/simple;
	bh=D1wbEsB7TFyizka/IHeRNqhm2Jh1CbExzVJuyDFMVEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbkPNqDp6lfUrKAIhQ/EK66blAj+dWHSbKcYgXQZToFOwP96xmjYd2VQtzx52y5sou6I1wAP8MJURwV8u0WPjKGg/GK1o+WXRx6L2WRIu7u3keeN8KnNc7bEMz3VtrC2rC7sAPLJeKx/RGgd0p1QALWpQJuhfKYz8+ryJNeDJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Obkl0/L1; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-543cc81ddebso2338434e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739548654; x=1740153454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHx17WFnnFivJUIFv2m7lVrUVyw09kYPGsIsDDqzOlQ=;
        b=Obkl0/L1x2AiN7doUxuzjyi0YeaCXQArwsDYJJLgVvCZes/rl7E1XKWDht/ipvDzRw
         hLTH3D52oNM0lIlQxkpmi0py1tSSAauL2dNlaPpCbff6hELXVrAg0FefXJPs1J/0Yz/G
         qoitE9y2dWuox0PRZrwvkZN1NXh1MyGbLAh36ZjmT0Sm+y//k7XT+FSgGIaxjbLjZXpw
         M8MzYevFpiKxMyo0TSoM+zRdtPd+RhxnqQjIw/Q0Xf0r8SXhJGBAooiSOqfe0NSvDzJS
         /Dv1JMzao1KCiXUts3qz/UcwIr1KOO4rIdpaOlI2MSxSIZJ7riwlWjDKCvL09OE9NzK0
         4SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548654; x=1740153454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHx17WFnnFivJUIFv2m7lVrUVyw09kYPGsIsDDqzOlQ=;
        b=f5QHMrjieE8CXZmjlnstLxXbSACHPeGQXAt1lAAPWEmqZQa4UIqnJdn3ITReqTfajh
         HPfEH1NzjdsXGwN1J5r8Fy0r+ECKxNzAW15h5RDo7CaabUXHf0/Tmphbx2cv3dK2vqgy
         zuLQ828bZa/x8dp5UEqi9RWqf1RXjSiZz/pCadj4cZSo+M8Va7/X0z6PctSbBeGCYc4C
         5aK7zPJt18zsDQKMJiLLhyP35572xJ3SWJs5ncs2a6ZPuGe0BP4yjrXgH9J7v4UGAbAT
         0Cx9j31YmF5XylbcinEv7U36CoM4TRYa814bubstYc9woOyHQO41vLPgWL42tCZ2ENZi
         1DdA==
X-Forwarded-Encrypted: i=1; AJvYcCUxXAAw607u5RlVKHcqSJBeifY1ddMwT768NajErWqdVDI0IjlEAzWLngDFwFItI8BqOKe8xnA+OLuK9Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo10i0c4Ff6DkYp4KNkyctw18WIElWXIcHnpyXBZK8ZjeodNgR
	33pHW4G8YoXfuxCs0t2rQlbq6GrKjk9TLhmRRLJzyXI2onWiIBFUHZk1GO9GdXtJgE7kDxE8MPh
	hIv3NyBNOoZrZFpfl4oRDo2SAjX+6TzII9yJd4Q==
X-Gm-Gg: ASbGncuXJIGJDyTqKwTb6+D83FUcBTMkS4CaIMj2YvUj8xe1zZyLxm8Dmgmm72gd3NH
	kp+hgmG4OVKJ9iW7BVzeqlbRc90kmBXL27Fm6R29T0S1zjhglQusl3NZQUqQxBfXO1/7GRf2Hay
	3m8/9/ekGMvRVIQAWyPwCMeBoWkSgKaA==
X-Google-Smtp-Source: AGHT+IF6cLtumKw5gwUmJWDnoposzLT4HXNcBKi3JpGDWlZkrz1UmThgne6q7oRD/FA6ofAqMRYp7Q+YqVZLueSHux0=
X-Received: by 2002:a05:6512:1111:b0:545:6cf:6f3e with SMTP id
 2adb3069b0e04-5451dde81aemr2973561e87.49.1739548653921; Fri, 14 Feb 2025
 07:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214105047.150835-1-marco.crivellari@suse.com>
 <20250214105047.150835-2-marco.crivellari@suse.com> <CAAhV-H4qY9FOm4C4kBCerM4j+CcezL-Dkitb8gbVZCYjjCxQDA@mail.gmail.com>
In-Reply-To: <CAAhV-H4qY9FOm4C4kBCerM4j+CcezL-Dkitb8gbVZCYjjCxQDA@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 14 Feb 2025 16:57:22 +0100
X-Gm-Features: AWEUYZk6Vjn3NzgRt01zDBdJAFiUfGq908c3RjrX1jgAjpL0SbUS3Wge4zdYVXs
Message-ID: <CAAofZF4PVYehyonsmyTC=gKTgucs-jZYzzoQ2dvFcqK9YgsKVw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix idle VS timer enqueue
To: Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thanks for the replies!

Huacai: I used the '1' label when I compiled the first time, but I
noticed this warning, so I decided to use the label to avoid this:

"WARNING: modpost: vmlinux: section mismatch in reference:
rollback_except_vec_vi+0x4 (section: .text) -> except_vec4 (section:
.init.text)"

By the way, I will use the 1 label like you suggested.

> For MIPS the rollback region is not 3 instructions, and so you cannot
> use 0xc below. I think there is no chance for the wait instruction
> after this patch.

About this, does it look better if i don't change this part of the
code (except for PTR_LA  k1, 1b) ?
eg.

@@ -136,7 +144,7 @@ LEAF(__r4k_wait)
       .set    push
       .set    noat
       MFC0    k0, CP0_EPC
-       PTR_LA  k1, __r4k_wait
+       PTR_LA  k1, 1b
       ori     k0, 0x1f        /* 32 byte rollback region */
       xori    k0, 0x1f
       bne     k0, k1, \handler

So the real change would be:

-       /* start of rollback region */
-       LONG_L  t0, TI_FLAGS($28)
+       /* start of idle interrupt region */
+       MFC0    k0, CP0_STATUS
       nop
-       andi    t0, _TIF_NEED_RESCHED
-       bnez    t0, 1f
-        nop
+       /* Enable Interrupt */
+       ori     k0, 0x1f
+       xori    k0, 0x1e
+       MTC0    k0, CP0_STATUS
       nop
       nop

Maybe what I'm going to say is silly...
But considering the region should be a power of 2, maybe can also be
changed with:
ori   k0, 0x0f
addi  k0, 1

Thanks for your time!

On Fri, Feb 14, 2025 at 3:47=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Marco,
>
> On Fri, Feb 14, 2025 at 6:51=E2=80=AFPM Marco Crivellari
> <marco.crivellari@suse.com> wrote:
> >
> > MIPS re-enables interrupts on its idle routine and performs
> > a TIF_NEED_RESCHED check afterwards before putting the CPU to sleep.
> >
> > The IRQs firing between the check and the 'wait' instruction may set th=
e
> > TIF_NEED_RESCHED flag. In order to deal with this possible race, IRQs
> > interrupting __r4k_wait() rollback their return address to the
> > beginning of __r4k_wait() so that TIF_NEED_RESCHED is checked
> > again before going back to sleep.
> >
> > However idle IRQs can also queue timers that may require a tick
> > reprogramming through a new generic idle loop iteration but those timer=
s
> > would go unnoticed here because __r4k_wait() only checks
> > TIF_NEED_RESCHED. It doesn't check for pending timers.
> >
> > Fix this with fast-forwarding idle IRQs return address to the end of th=
e
> > idle routine instead of the beginning, so that the generic idle loop
> > handles both TIF_NEED_RESCHED and pending timers.
> >
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> > ---
> >  arch/mips/kernel/genex.S | 36 ++++++++++++++++++++----------------
> >  arch/mips/kernel/idle.c  |  1 -
> >  2 files changed, 20 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> > index a572ce36a24f..a78d5132c940 100644
> > --- a/arch/mips/kernel/genex.S
> > +++ b/arch/mips/kernel/genex.S
> > @@ -104,18 +104,16 @@ handle_vcei:
> >
> >         __FINIT
> >
> > -       .align  5       /* 32 byte rollback region */
> > +       .align  5
> >  LEAF(__r4k_wait)
> >         .set    push
> >         .set    noreorder
> > -       /* start of rollback region */
> > -       LONG_L  t0, TI_FLAGS($28)
> > -       nop
> > -       andi    t0, _TIF_NEED_RESCHED
> > -       bnez    t0, 1f
> > -        nop
> > -       nop
> > -       nop
> > +       /* start of idle interrupt region */
> > +       MFC0    k0, CP0_STATUS
> > +       /* Enable Interrupt */
> > +       ori     k0, 0x1f
> > +       xori    k0, 0x1e
> > +       MTC0    k0, CP0_STATUS
> >  #ifdef CONFIG_CPU_MICROMIPS
> >         nop
> >         nop
> > @@ -123,11 +121,17 @@ LEAF(__r4k_wait)
> >         nop
> >  #endif
> >         .set    MIPS_ISA_ARCH_LEVEL_RAW
> > +       /*
> > +        * If an interrupt lands here, between enabling interrupts abov=
e and
> > +        * going idle on the next instruction, we must *NOT* go idle si=
nce the
> > +        * interrupt could have set TIF_NEED_RESCHED or caused a timer =
to need
> > +        * resched. Fall through -- see rollback_handler below -- and h=
ave
> > +        * the idle loop take care of things.
> > +        */
> >         wait
> > -       /* end of rollback region (the region size must be power of two=
) */
> > -1:
> > +       /* end of idle interrupt region (the region size must be power =
of two) */
> > +SYM_INNER_LABEL(__r4k_wait_exit, SYM_L_LOCAL)
> You can also use label 1 as the LoongArch version.
>
> >         jr      ra
> > -        nop
> >         .set    pop
> >         END(__r4k_wait)
> >
> > @@ -136,10 +140,10 @@ LEAF(__r4k_wait)
> >         .set    push
> >         .set    noat
> >         MFC0    k0, CP0_EPC
> > -       PTR_LA  k1, __r4k_wait
> > -       ori     k0, 0x1f        /* 32 byte rollback region */
> > -       xori    k0, 0x1f
> > -       bne     k0, k1, \handler
> > +       PTR_LA  k1, __r4k_wait_exit
> > +       /* 3 instructions rollback region */
> For MIPS the rollback region is not 3 instructions, and so you cannot
> use 0xc below. I think there is no chance for the wait instruction
> after this patch.
>
> Huacai
>
> > +       ori     k0, k0, 0x0c
> > +       bne     k0, k1, \handler
> >         MTC0    k0, CP0_EPC
> >         .set pop
> >         .endm
> > diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
> > index 5abc8b7340f8..1f74c0589f7e 100644
> > --- a/arch/mips/kernel/idle.c
> > +++ b/arch/mips/kernel/idle.c
> > @@ -37,7 +37,6 @@ static void __cpuidle r3081_wait(void)
> >
> >  void __cpuidle r4k_wait(void)
> >  {
> > -       raw_local_irq_enable();
> >         __r4k_wait();
> >         raw_local_irq_disable();
> >  }
> > --
> > 2.48.1
> >
> >



--=20

Marco Crivellari

L3 Support Engineer, Technology & Product




marco.crivellari@suse.com

