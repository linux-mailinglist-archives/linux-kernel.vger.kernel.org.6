Return-Path: <linux-kernel+bounces-560607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF83AA60704
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C5C3BBEDD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D507DF60;
	Fri, 14 Mar 2025 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbEq2FtL"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1CA2E3374
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741915522; cv=none; b=DfxXpZq6LMT2yvY18d9vHivbZvh9xVPDU9AswzgLoN/DYV6r6x3p6PAbSQTPsuMNtxqgqmnw28v6p/AfMjGsHa+bOQxhRxhNzQGODS/ZoZLMRrBYJDOoQXqkXfsaLHJH4GicdYgKDqDfPOd+d2ohNj0d0MYfBAos8RhoPf+Q8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741915522; c=relaxed/simple;
	bh=pYR6POtptZTzDvs5AVhjHcD47+c/Tf1NxJgmYWlgvdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8uOp2rdfajWHVi7A/nYlN4egBX6Am8OjXZO6djfx84LneOPWJqqyMG1pAVf4WxnvyB/7hHexQYBfP39dPpeCUOSj89GcXqVrX93Bry7eAF0iQv9fMWCN9GaDI4BeflIQDrPUHmM+WJ4kOFh+N79YPpe7wnM3BUay4YBuL5yGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbEq2FtL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5499bd3084aso1589225e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741915519; x=1742520319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJUHBBzL/5px/4xfGZBmnoN11NHSw0VyPD+uekvDR+4=;
        b=jbEq2FtLPcPuVUOZ8gJ81mcEAHhZTQtKffOg3QwEyjJ8QNuq6Cn66DOEcxOk02aXfF
         v+1eEeXhhWHRMvd5KjSVwfjTvHGue8+xoaffakZi4UOImimzROcsBB54qCcOfHH3a+T4
         x8XkHyJfzn4YxFEhAbBnNyczBm2dbNB7aUQZG9Ajpbi/mrS7AcjFCofgtt37IW/yuRY5
         hHV190tCcUTEltPqFqY0fIYkFwmo2wxC+vCt5XWaWA5PCJkL4tnwlz/LDjXj3f0m7AS9
         K3ElAwWZEk9JKUcxNaLWGfzdZuX1Z0yMo/rwzK5wfwkxG71TEiQiBL1KS/a9WrConC8o
         AlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741915519; x=1742520319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJUHBBzL/5px/4xfGZBmnoN11NHSw0VyPD+uekvDR+4=;
        b=lJYmFfHjWwFWGg5YiKY1+xv7py3xOGLLW9d1ksOfI0VRSlmFdIyf6D5VldVJPpDwLo
         iWCJFHsQkVgZg4WuNbPBcViv/GnPNXcKq9jxzK/QLG+7dIvvD2kwaV1QBn0DbhGxU868
         /16UMDnhrfxGkR517c70k4iaOT8KFqu/FfGJPmXYGTcYFVGBq824ZkDqMpSkRHHXLJG5
         c1nvzKdvktPaohmNBNC4yblXf4Ok+0iOYWBo9pIj6fzMesAiJibL/L2WJiFqQ0Y8z4bK
         a9k3Zntv5KSgJ0PZh62WHIm3ctZ+gDCDYstbKC4QgX/iIyle6TuPCREwxJFM4/Xs27fQ
         2xoQ==
X-Gm-Message-State: AOJu0Yz0eBCUgDSZTiuMlXFUe04gu1yXDCvuRc2j5G44q27h3cnXUQgM
	f50POgO+CXIDpaOizIFMCE3wxinAlqt8iPzzDMmPU3lKNE5nTZ/VHpS7aAQOvhgaHQSxfDbeC5D
	kYkOj9GlVAYiL/QC0UCjZTPnAhg==
X-Gm-Gg: ASbGncslPGG3MjnGV3ZMbgcZTYf/dj+/7zC32FqKNR564BK93SPl18BpzTIfKYLtut6
	qD7DOmDBQpci4TK0vguRaoWv1UBMIQLxca/fkYuNb1VXd01/uXjxQW1tt+gREbutW+uNmAtPxnZ
	6WcXHV4D8rfZBLluD2kw7hL/ZzrFRq+EP7S7Y+R2tl
X-Google-Smtp-Source: AGHT+IH3eUsPhbcfN8V4FyyOJUpSRgPMnEVleUVSWCJjj/2SlKX3KF6zFdb4pZcM0Pj9DzPdSEsdJHuFFvw/nzCK6Gg=
X-Received: by 2002:a05:6512:ba9:b0:549:5b54:2c77 with SMTP id
 2adb3069b0e04-549c3924ecfmr187743e87.32.1741915518430; Thu, 13 Mar 2025
 18:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313182236.655724-1-brgerst@gmail.com> <20250313182236.655724-3-brgerst@gmail.com>
 <5ac97442-78b1-40ce-9282-06cd62d97a67@intel.com>
In-Reply-To: <5ac97442-78b1-40ce-9282-06cd62d97a67@intel.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Thu, 13 Mar 2025 21:25:06 -0400
X-Gm-Features: AQ5f1JqDOCXu7C8_LAVIJ_D8LrUKMbrDeBfIvbdRdnIdi-kBd_9zKMRZZc6O0XU
Message-ID: <CAMzpN2iu5NRe2PE-TYS9beJp7Ze439C9k8AWHjfcibXi_mGuug@mail.gmail.com>
Subject: Re: [PATCH 2/5] x86/syscall/32: Move 32-bit syscall dispatch code
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 7:45=E2=80=AFPM Sohil Mehta <sohil.mehta@intel.com>=
 wrote:
>
> On 3/13/2025 11:22 AM, Brian Gerst wrote:
>
> >  SYSCALL_DEFINE0(ni_syscall)
> >  {
> >       return -ENOSYS;
> > diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> > index 8cc9950d7104..7c286e89fd04 100644
> > --- a/arch/x86/entry/syscall_32.c
> > +++ b/arch/x86/entry/syscall_32.c
> > @@ -1,10 +1,23 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/* System call table for i386. */
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * 32-bit system call dispatch
> > + *
> > + * Copyright (c) 2015 Andrew Lutomirski
> > + *
> > + * Based on asm and ptrace code by many authors.  The code here origin=
ated
> > + * in ptrace.c and signal.c.
>
> Wondering if we can skip copying over some of these old comments? As the
> file grows, it's hard to discerne what specific code originated where.
> For example, the FRED code is all new.

I wasn't sure what the appropriate thing would be so I just copied it
over.  The git history is probably a better way to attribute this
though.

>
> > +#ifdef CONFIG_IA32_EMULATION
> > +static __always_inline bool int80_is_external(void)
> > +{
> > +     const unsigned int offs =3D (0x80 / 32) * 0x10;
> > +     const u32 bit =3D BIT(0x80 % 32);
> > +
> > +     /* The local APIC on XENPV guests is fake */
> > +     if (cpu_feature_enabled(X86_FEATURE_XENPV))
> > +             return false;
> > +
> > +     /*
> > +      * If vector 0x80 is set in the APIC ISR then this is an external
> > +      * interrupt. Either from broken hardware or injected by a VMM.
> > +      *
> > +      * Note: In guest mode this is only valid for secure guests where
> > +      * the secure module fully controls the vAPIC exposed to the gues=
t.
> > +      */
> > +     return apic_read(APIC_ISR + offs) & bit;
> > +}
> > +
> > +/**
> > + * do_int80_emulation - 32-bit legacy syscall C entry from asm
> > + * @regs: syscall arguments in struct pt_args on the stack.
> > + *
> > + * This entry point can be used by 32-bit and 64-bit programs to perfo=
rm
> > + * 32-bit system calls.  Instances of INT $0x80 can be found inline in
> > + * various programs and libraries.  It is also used by the vDSO's
> > + * __kernel_vsyscall fallback for hardware that doesn't support a fast=
er
> > + * entry method.  Restarted 32-bit system calls also fall back to INT
> > + * $0x80 regardless of what instruction was originally used to do the
> > + * system call.
> > + *
> > + * This is considered a slow path.  It is not used by most libc
> > + * implementations on modern hardware except during process startup.
> > + *
> > + * The arguments for the INT $0x80 based syscall are on stack in the
> > + * pt_regs structure:
> > + *   eax:                            system call number
> > + *   ebx, ecx, edx, esi, edi, ebp:   arg1 - arg 6
> > + */
> > +__visible noinstr void do_int80_emulation(struct pt_regs *regs)
> > +{
> > +     int nr;
> > +
> > +     /* Kernel does not use INT $0x80! */
> > +     if (unlikely(!user_mode(regs))) {
> > +             irqentry_enter(regs);
> > +             instrumentation_begin();
> > +             panic("Unexpected external interrupt 0x80\n");
> > +     }
> > +
> > +     /*
> > +      * Establish kernel context for instrumentation, including for
> > +      * int80_is_external() below which calls into the APIC driver.
> > +      * Identical for soft and external interrupts.
> > +      */
> > +     enter_from_user_mode(regs);
> > +
> > +     instrumentation_begin();
> > +     add_random_kstack_offset();
> > +
> > +     /* Validate that this is a soft interrupt to the extent possible =
*/
> > +     if (unlikely(int80_is_external()))
> > +             panic("Unexpected external interrupt 0x80\n");
> > +
> > +     /*
> > +      * The low level idtentry code pushed -1 into regs::orig_ax
> > +      * and regs::ax contains the syscall number.
> > +      *
> > +      * User tracing code (ptrace or signal handlers) might assume
> > +      * that the regs::orig_ax contains a 32-bit number on invoking
> > +      * a 32-bit syscall.
> > +      *
> > +      * Establish the syscall convention by saving the 32bit truncated
> > +      * syscall number in regs::orig_ax and by invalidating regs::ax.
> > +      */
> > +     regs->orig_ax =3D regs->ax & GENMASK(31, 0);
> > +     regs->ax =3D -ENOSYS;
> > +
> > +     nr =3D syscall_32_enter(regs);
> > +
> > +     local_irq_enable();
> > +     nr =3D syscall_enter_from_user_mode_work(regs, nr);
> > +     do_syscall_32_irqs_on(regs, nr);
> > +
> > +     instrumentation_end();
> > +     syscall_exit_to_user_mode(regs);
> > +}
> > +
> > +#ifdef CONFIG_X86_FRED
> > +/*
> > + * A FRED-specific INT80 handler is warranted for the follwing reasons=
:
> > + *
> > + * 1) As INT instructions and hardware interrupts are separate event
> > + *    types, FRED does not preclude the use of vector 0x80 for externa=
l
> > + *    interrupts. As a result, the FRED setup code does not reserve
> > + *    vector 0x80 and calling int80_is_external() is not merely
> > + *    suboptimal but actively incorrect: it could cause a system call
> > + *    to be incorrectly ignored.
> > + *
> > + * 2) It is called only for handling vector 0x80 of event type
> > + *    EVENT_TYPE_SWINT and will never be called to handle any external
> > + *    interrupt (event type EVENT_TYPE_EXTINT).
> > + *
> > + * 3) FRED has separate entry flows depending on if the event came fro=
m
> > + *    user space or kernel space, and because the kernel does not use
> > + *    INT insns, the FRED kernel entry handler fred_entry_from_kernel(=
)
> > + *    falls through to fred_bad_type() if the event type is
> > + *    EVENT_TYPE_SWINT, i.e., INT insns. So if the kernel is handling
> > + *    an INT insn, it can only be from a user level.
> > + *
> > + * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY. While FRED will
> > + *    likely take a different approach if it is ever needed: it
> > + *    probably belongs in either fred_intx()/ fred_other() or
> > + *    asm_fred_entrypoint_user(), depending on if this ought to be don=
e
> > + *    for all entries from userspace or only system
> > + *    calls.
> > + *
> > + * 5) INT $0x80 is the fast path for 32-bit system calls under FRED.
> > + */
> > +DEFINE_FREDENTRY_RAW(int80_emulation)
> > +{
> > +     int nr;
> > +
> > +     enter_from_user_mode(regs);
> > +
> > +     instrumentation_begin();
> > +     add_random_kstack_offset();
> > +
> > +     /*
> > +      * FRED pushed 0 into regs::orig_ax and regs::ax contains the
> > +      * syscall number.
> > +      *
> > +      * User tracing code (ptrace or signal handlers) might assume
> > +      * that the regs::orig_ax contains a 32-bit number on invoking
> > +      * a 32-bit syscall.
> > +      *
> > +      * Establish the syscall convention by saving the 32bit truncated
> > +      * syscall number in regs::orig_ax and by invalidating regs::ax.
> > +      */
> > +     regs->orig_ax =3D regs->ax & GENMASK(31, 0);
> > +     regs->ax =3D -ENOSYS;
> > +
> > +     nr =3D syscall_32_enter(regs);
> > +
> > +     local_irq_enable();
> > +     nr =3D syscall_enter_from_user_mode_work(regs, nr);
> > +     do_syscall_32_irqs_on(regs, nr);
> > +
> > +     instrumentation_end();
> > +     syscall_exit_to_user_mode(regs);
> > +}
> > +#endif
>
> Nit: Would it be useful to add /* CONFIG_X86_FRED */ here since there
> are nested #ifdefs?

These patches should be as close to a copy and paste as possible, so
that it's easy to prove that nothing changes.  This could be a
followup patch later though.


Brian Gerst

