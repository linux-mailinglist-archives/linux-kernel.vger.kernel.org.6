Return-Path: <linux-kernel+bounces-535395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB0A471FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFEE7A465E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FF51487F6;
	Thu, 27 Feb 2025 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4wMa19/"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD48145B25
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622234; cv=none; b=OzCRCqaD5zq27nDvSniBO/fB8VIRtSJ02gj8Od8+XM7W6CPBAZdXMdtWB3SLlrGu0d37kIqaPhS0jaaa9kbgo+RbprCs5O+sdo/5hkKjtmSdpazmDUWomP3A5l8SMJ25NMRg2lUPkGOr/rMPmIOhtfJJGGVvCmuIoVOC0jVouEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622234; c=relaxed/simple;
	bh=gc6S2JpMkh9+SlpVNws8xnI278iajsYgxd5Nj4QiLGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajSer+Q2ycVMn9Apz82ho3i5wvTZg4MttKk52fOv9/F+XryllmtPkj7iJ71StteqnT1WO6kl2SsqspqTB64vjp3SRurb2eS/N4oxfBjLwYfQf4aBCmIe5Q2QyJr1XENw1ygC5T25+odvn3/XfGWeXVHnwfoXqAptsj4gmAjFqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4wMa19/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a04so5083931fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740622231; x=1741227031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyNS7yiZ0M+hACoIoTjs4K2E1oZHkiWIyiPKi+q6bCo=;
        b=k4wMa19/aoA5z5t7b34J8y66hg2v0Rzz7f+o177V4AWWcD6rJYA664ISyAJCAscaIf
         V+/BOxJOPjWc9IOLhzffn/1rRbasO7sy7PjkXVV2il5R+89ErBUS0DqNP2rRSkxlxste
         HgYO0mqmIH7MKTFyw+0Yy0lMQeXCH3XN+5eGrHGHu4Mks4y0YJ9qGcw4zjel8FvaNDCV
         4dMExSY1QFf63Z0g8eozPLIouFFLaGh+7AMxfS0JeC6HUpysI0wT1m7i/qPp2z5rr/1a
         RhE7XY/Mr47GkB+g1I2xTJzV77d8b5irfTrDmp5Vbe8r0/ePA9ltDri41V1eGfJvtYSD
         EaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622231; x=1741227031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyNS7yiZ0M+hACoIoTjs4K2E1oZHkiWIyiPKi+q6bCo=;
        b=lvQV9FESLNoNQ/pbSHq+R9slgXUDB+5WdmHzT4GOaKJJ9twEo6i2lJH5Rd8koN+Yq3
         8x/y6iqyF0Q/qyA8RGOUXI+Yf7SvjcqIXq52p0KuqLTeG9D4XnV/Hvsa8WZVuBTtC7op
         U9d4NS6NbBuJ3KW9/XnMm3GCVwkZLcLZSB1I0P1Nwq1/2/5qD/d6twjUkXdpnsVSFC4w
         kwynNYMAIBZrui4Me2RfGs+bLQVuzEunfw3fZatgvcQ5vIVsO6mmbXgKYYm/gxfSir2m
         RNvMy3EHPrxjLqWuW896lrMa3dY0o4h9Md4w4Vap/USUi97qDRC+jzPqR9jIEPuzv1td
         zK3w==
X-Gm-Message-State: AOJu0YwjFVgZ5VpEpl0RBnJiTjMAqr21Qd1BU+M0l7txFl0CcFKK4w1e
	EKCEu8fHqVGl6pjMPXuy+C90OGb0Vfhdsl5wnEwfHaN9TFVi8fnxsMwoCFh6amijpX0kMte6v0s
	mQw1LeEfF5ATVJD4wNDZ7tyFgUA==
X-Gm-Gg: ASbGnctVLvjtRASqtmEtgD87yLa2pba7hMapafyC71U/53W26t0FlaoGMKfv9HRvj4Y
	2SDm95GTWRRDi0RomOMztZw3T0eXzvlQpIxfLfmEYNYHlnJAMO2t/yJSDHXFLX+EjKT359yBlo6
	LS3/+ZlEuy6eWiymlUV0CPoQ==
X-Google-Smtp-Source: AGHT+IHVoTjdYNOhqXcZUrAev/CIB5qQETknQlAYdeVHPsRHD+qg0Slqqcqp2PhmFU510rwPrmN/r24+nuTPV12h3/c=
X-Received: by 2002:a05:6512:3f0d:b0:545:2544:6ae2 with SMTP id
 2adb3069b0e04-5483913f60cmr12306773e87.16.1740622230714; Wed, 26 Feb 2025
 18:10:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226180531.1242429-1-brgerst@gmail.com> <20250226180531.1242429-9-brgerst@gmail.com>
 <CAFULd4Z3o18zRebbqTgNH9QrPkoSLtbS=_mZGfheJYoeMawUaw@mail.gmail.com>
In-Reply-To: <CAFULd4Z3o18zRebbqTgNH9QrPkoSLtbS=_mZGfheJYoeMawUaw@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 26 Feb 2025 21:10:19 -0500
X-Gm-Features: AQ5f1JqriTP8IY8FXxbMn0qZLNCSU7mDbVaPZXf6wEDHCBwSZryC7RHaQgZIN_s
Message-ID: <CAMzpN2j56_fCuToxtSfEYy7iGddJPR41jB4QvC1S_kF-wherOA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] x86/percpu: Move top_of_stack to percpu hot section
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:08=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Feb 26, 2025 at 7:06=E2=80=AFPM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > No functional change.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  arch/x86/entry/entry_32.S        | 4 ++--
> >  arch/x86/entry/entry_64.S        | 6 +++---
> >  arch/x86/entry/entry_64_compat.S | 4 ++--
> >  arch/x86/include/asm/current.h   | 1 -
> >  arch/x86/include/asm/percpu.h    | 2 +-
> >  arch/x86/include/asm/processor.h | 8 ++++++--
> >  arch/x86/kernel/asm-offsets.c    | 1 -
> >  arch/x86/kernel/cpu/common.c     | 3 ++-
> >  arch/x86/kernel/process_32.c     | 4 ++--
> >  arch/x86/kernel/process_64.c     | 2 +-
> >  arch/x86/kernel/smpboot.c        | 2 +-
> >  arch/x86/kernel/vmlinux.lds.S    | 1 +
> >  12 files changed, 21 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> > index 20be5758c2d2..92c0b4a94e0a 100644
> > --- a/arch/x86/entry/entry_32.S
> > +++ b/arch/x86/entry/entry_32.S
> > @@ -1153,7 +1153,7 @@ SYM_CODE_START(asm_exc_nmi)
> >          * is using the thread stack right now, so it's safe for us to =
use it.
> >          */
> >         movl    %esp, %ebx
> > -       movl    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esp
> > +       movl    PER_CPU_VAR(cpu_current_top_of_stack), %esp
> >         call    exc_nmi
> >         movl    %ebx, %esp
> >
> > @@ -1217,7 +1217,7 @@ SYM_CODE_START(rewind_stack_and_make_dead)
> >         /* Prevent any naive code from trying to unwind to our caller. =
*/
> >         xorl    %ebp, %ebp
> >
> > -       movl    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esi
> > +       movl    PER_CPU_VAR(cpu_current_top_of_stack), %esi
> >         leal    -TOP_OF_KERNEL_STACK_PADDING-PTREGS_SIZE(%esi), %esp
> >
> >         call    make_task_dead
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index 33a955aa01d8..9baf32a7a118 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -92,7 +92,7 @@ SYM_CODE_START(entry_SYSCALL_64)
> >         /* tss.sp2 is scratch space. */
> >         movq    %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
> >         SWITCH_TO_KERNEL_CR3 scratch_reg=3D%rsp
> > -       movq    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
> > +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
> >
> >  SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
> >         ANNOTATE_NOENDBR
> > @@ -1166,7 +1166,7 @@ SYM_CODE_START(asm_exc_nmi)
> >         FENCE_SWAPGS_USER_ENTRY
> >         SWITCH_TO_KERNEL_CR3 scratch_reg=3D%rdx
> >         movq    %rsp, %rdx
> > -       movq    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
> > +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
> >         UNWIND_HINT_IRET_REGS base=3D%rdx offset=3D8
> >         pushq   5*8(%rdx)       /* pt_regs->ss */
> >         pushq   4*8(%rdx)       /* pt_regs->rsp */
> > @@ -1484,7 +1484,7 @@ SYM_CODE_START_NOALIGN(rewind_stack_and_make_dead=
)
> >         /* Prevent any naive code from trying to unwind to our caller. =
*/
> >         xorl    %ebp, %ebp
> >
> > -       movq    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rax
> > +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rax
> >         leaq    -PTREGS_SIZE(%rax), %rsp
> >         UNWIND_HINT_REGS
> >
> > diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64=
_compat.S
> > index ed0a5f2dc129..a45e1125fc6c 100644
> > --- a/arch/x86/entry/entry_64_compat.S
> > +++ b/arch/x86/entry/entry_64_compat.S
> > @@ -57,7 +57,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
> >         SWITCH_TO_KERNEL_CR3 scratch_reg=3D%rax
> >         popq    %rax
> >
> > -       movq    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
> > +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
> >
> >         /* Construct struct pt_regs on stack */
> >         pushq   $__USER_DS              /* pt_regs->ss */
> > @@ -193,7 +193,7 @@ SYM_CODE_START(entry_SYSCALL_compat)
> >         SWITCH_TO_KERNEL_CR3 scratch_reg=3D%rsp
> >
> >         /* Switch to the kernel stack */
> > -       movq    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
> > +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
> >
> >  SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
> >         ANNOTATE_NOENDBR
> > diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/curr=
ent.h
> > index 6fad5a4c21d7..3d1b123c2ee3 100644
> > --- a/arch/x86/include/asm/current.h
> > +++ b/arch/x86/include/asm/current.h
> > @@ -14,7 +14,6 @@ struct task_struct;
> >
> >  struct pcpu_hot {
> >         struct task_struct      *current_task;
> > -       unsigned long           top_of_stack;
> >  };
> >
> >  DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
> > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percp=
u.h
> > index 7cb4f64b2e60..044410462d36 100644
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -554,7 +554,7 @@ do {                                               =
                         \
> >   * it is accessed while this_cpu_read_stable() allows the value to be =
cached.
> >   * this_cpu_read_stable() is more efficient and can be used if its val=
ue
> >   * is guaranteed to be valid across CPUs.  The current users include
> > - * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
> > + * pcpu_hot.current_task and cpu_current_top_of_stack, both of which a=
re
> >   * actually per-thread variables implemented as per-CPU variables and
> >   * thus stable for the duration of the respective task.
> >   */
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/pr=
ocessor.h
> > index 54fce8d7504d..b4d51de071f2 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -427,6 +427,10 @@ DECLARE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inus=
e);
> >  DECLARE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
> >  #endif
> >
> > +DECLARE_PER_CPU_CACHE_HOT(unsigned long, cpu_current_top_of_stack);
> > +/* const-qualified alias provided by the linker. */
> > +DECLARE_PER_CPU_CACHE_HOT(const unsigned long __percpu_seg_override, c=
onst_cpu_current_top_of_stack);
>
> Please split the above line, like you did with const_current_task declara=
tion.

Fixed in the next version.


Brian Gerst

