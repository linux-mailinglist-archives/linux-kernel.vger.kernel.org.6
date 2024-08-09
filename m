Return-Path: <linux-kernel+bounces-281304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3794D547
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615641F22306
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE73B6F066;
	Fri,  9 Aug 2024 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EmeuUboA"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431128689
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223820; cv=none; b=la469MmS6Z+iMmL23cgncFu1z5TjTN0IUCxxooDOF3Kx6P5iwYXstN9PNBwxsUfL+xwhdPAa21X3j2NrNn8YKY79lA//D1WIjVixT5yKzG+/Nrr27E80JfXgFwHbHzIJvQvQ8FYN7jOLXZeLKIsTixxFntuGkmGAoBO+AaysnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223820; c=relaxed/simple;
	bh=b00zOCLKOtV9b36fkT0RZXOnjkK88NHG8svLS5DMFvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AANFgis6vHTwTWuANPSkIpfhylroVqUIR/WBU/r/8vsFJs5kT2VYzvp2/gMAT0KCwGmrVU4W2ES9MVZIV20y+r2ZjfCQNE3RVnuKLssSXqsLCBXxm8C9yD2LlItOqveODVMW+blml7SZM82OhZeoaF69qXc29S9z700QqZWNiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EmeuUboA; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-268daf61e8bso830239fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723223818; x=1723828618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/fAYz42YIT47Goo/L2J1KADvnu11AHx4qa4iqxm2BE=;
        b=EmeuUboAN3qMfmK5cJTzdyiCKvaTri2f9biSUgFK3W7dYpYVB+t6B6k/gB0GwTf/FG
         bIjOZwsmFfyANtyh1F4qxMCAy4Ob2CSSlmjnAM/4cJh7uoG2+etCmCXp8c1WtLkcnvGC
         6dgNXIlPIstb4H0qjkbVBAHtsieReeZUOPS7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723223818; x=1723828618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/fAYz42YIT47Goo/L2J1KADvnu11AHx4qa4iqxm2BE=;
        b=I5TEHIlc4xEO/5DtjxivBdr2n60XqNDVEHOwwgjcAEIaN2Vhn3wyUZjAjLEcKEqJ77
         bfiXZfgf443tSAtxXD2YU46F8gqymTx8V/Skkdw6tz5v1qWXxQB6l1us6NcoMRr2hmeG
         D2ZP2SIho2u0Qt4BNiRv5T+f8FAY1fPmWA0iGczO2xrtTNFgmlDP2bPeWHfT1NVeTWmF
         OB6nAe9Z2gGANmkrrW8L3w9/EgGUZrvPlUmWsXlNUrfvqgcgiu1V7bNr3QW0m4W5y8wC
         PqIRLzu9+eULHgRioPU0YBuY9k9/eYUmbUuRaBDvRZbraLUN9CkTR/TAg1rFeAhi1Fqh
         M+ow==
X-Gm-Message-State: AOJu0YzQyCV6ZV0VXWQ3D/mWRnD7BYRw8/Q/cF4FPedMXsa7pWUY6x3H
	73HNSvPZj6AVh8bLH5No+Bm+JUbrYvcTo6b3K1fRiLbJtCaQmLALosiqBrn3pufm3eIFefnIKdu
	2jAwRbg4pqPejEPQwsrt723K8+RCmFKjDH7cp
X-Google-Smtp-Source: AGHT+IF5FbaYM01wWxPU0jt/1SPd+pa+ksh5VmBehXTLUGrOb3ooRbFC680Hubd+zcObF+xh/FidrIvTSqNSkWcanCk=
X-Received: by 2002:a05:6871:3a25:b0:261:1be0:b5b9 with SMTP id
 586e51a60fabf-26c6291fc7fmr2528193fac.0.1723223817876; Fri, 09 Aug 2024
 10:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com> <20240802061318.2140081-2-aruna.ramakrishna@oracle.com>
In-Reply-To: <20240802061318.2140081-2-aruna.ramakrishna@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 9 Aug 2024 10:16:47 -0700
Message-ID: <CABi2SkX6sB0ZtQk+Onv2EQA8fzhzG8_GpAepTYDWbs02u0p5mw@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] x86/pkeys: Add PKRU as a parameter in signal
 handling functions
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, 
	tglx@linutronix.de, mingo@kernel.org, linux-mm@kvack.org, 
	keith.lucas@oracle.com, rick.p.edgecombe@intel.com, jorgelo@chromium.org, 
	keescook@chromium.org, sroettger@google.com, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aruna,

On Thu, Aug 1, 2024 at 11:13=E2=80=AFPM Aruna Ramakrishna
<aruna.ramakrishna@oracle.com> wrote:
>
> Problem description:
> Let's assume there's a multithreaded application that runs untrusted
> user code. Each thread has its stack/code protected by a non-zero pkey,
> and the PKRU register is set up such that only that particular non-zero
> pkey is enabled. Each thread also sets up an alternate signal stack to
> handle signals, which is protected by pkey zero. The pkeys man page
> documents that the PKRU will be reset to init_pkru when the signal
> handler is invoked, which means that pkey zero access will be enabled.
> But this reset happens after the kernel attempts to push fpu state
> to the alternate stack, which is not (yet) accessible by the kernel,
> which leads to a new SIGSEGV being sent to the application, terminating
> it.
>
> Enabling both the non-zero pkey (for the thread) and pkey zero in
> userspace will not work for this use case. We cannot have the alt stack
> writeable by all - the rationale here is that the code running in that
> thread (using a non-zero pkey) is untrusted and should not have access
> to the alternate signal stack (that uses pkey zero), to prevent the
> return address of a function from being changed. The expectation is that
> kernel should be able to set up the alternate signal stack and deliver
> the signal to the application even if pkey zero is explicitly disabled
> by the application. The signal handler accessibility should not be
> dictated by whatever PKRU value the thread sets up.
>
While the above use case is correct, there are also other use cases
that can benefit from this patch:
Setup:
The thread's normal operation has RW permission to PKEY 0, and RO or
None to PKEY 1.
The Thread uses sigaltstack() to register a mapping which has PKEY1 assigne=
d.
Before this patch:
When the kernel is dispatching the signal, the thread will get SIGSEGV
inside get_sigframe, because the thread either doesn't have read
access or write access to the mapping  which is protected by PKEY1.
Because of SIGSEGV, the signal is not delivered to userspace.
After this patch:
There won't be SIGSEGV and the signal is delivered to userspace.

The scenario is useful to protect signal stack: Jann Horn had this
idea originally, and Chrome is planning to use it in V8 [1].  There
were discussions in the past to enable this feature [2]

Is that possible to include above in the cover letter to support this
patch series for upstream?
(upstream does like to see there are multiple user cases)

Thanks
-Jeff

[1] https://docs.google.com/document/d/1DjPhBq-5gRKtTeaknQDTWfvqRBCONmYqkU1=
I6k-3Ai8/edit?resourcekey=3D0-GGQta3_yhKqK7xV5SxIrVQ&tab=3Dt.0

[2] https://lore.kernel.org/lkml/202208221331.71C50A6F@keescook/



> Solution:
> The PKRU register is managed by XSAVE, which means the sigframe contents
> must match the register contents - which is not the case here. We want
> the sigframe to contain the user-defined PKRU value (so that it is
> restored correctly from sigcontext) but the actual register must be
> reset to init_pkru so that the alt stack is accessible and the signal
> can be delivered to the application. It seems that the proper fix here
> would be to remove PKRU from the XSAVE framework and manage it
> separately, which is quite complicated. As a workaround, do this:
>
>         orig_pkru =3D rdpkru();
>         wrpkru(orig_pkru & init_pkru_value);
>         xsave_to_user_sigframe();
>         put_user(pkru_sigframe_addr, orig_pkru)
>
> This change is split over multiple patches.
>
> In preparation for writing PKRU to sigframe in a later patch, pass in
> PKRU as an additional parameter down the chain from get_sigframe():
>         get_sigframe()
>           copy_fpstate_to_sigframe()
>             copy_fpregs_to_sigframe()
>
> There are no functional changes in this patch.
>
> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> ---
>  arch/x86/include/asm/fpu/signal.h | 2 +-
>  arch/x86/kernel/fpu/signal.c      | 6 +++---
>  arch/x86/kernel/signal.c          | 3 ++-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu=
/signal.h
> index 611fa41711af..eccc75bc9c4f 100644
> --- a/arch/x86/include/asm/fpu/signal.h
> +++ b/arch/x86/include/asm/fpu/signal.h
> @@ -29,7 +29,7 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
>
>  unsigned long fpu__get_fpstate_size(void);
>
> -extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, =
int size);
> +extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, =
int size, u32 pkru);
>  extern void fpu__clear_user_states(struct fpu *fpu);
>  extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
>
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 247f2225aa9f..2b3b9e140dd4 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -156,7 +156,7 @@ static inline bool save_xstate_epilog(void __user *bu=
f, int ia32_frame,
>         return !err;
>  }
>
> -static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf=
)
> +static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf=
, u32 pkru)
>  {
>         if (use_xsave())
>                 return xsave_to_user_sigframe(buf);
> @@ -185,7 +185,7 @@ static inline int copy_fpregs_to_sigframe(struct xreg=
s_state __user *buf)
>   * For [f]xsave state, update the SW reserved fields in the [f]xsave fra=
me
>   * indicating the absence/presence of the extended state to the user.
>   */
> -bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int=
 size)
> +bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int=
 size, u32 pkru)
>  {
>         struct task_struct *tsk =3D current;
>         struct fpstate *fpstate =3D tsk->thread.fpu.fpstate;
> @@ -228,7 +228,7 @@ bool copy_fpstate_to_sigframe(void __user *buf, void =
__user *buf_fx, int size)
>                 fpregs_restore_userregs();
>
>         pagefault_disable();
> -       ret =3D copy_fpregs_to_sigframe(buf_fx);
> +       ret =3D copy_fpregs_to_sigframe(buf_fx, pkru);
>         pagefault_enable();
>         fpregs_unlock();
>
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 31b6f5dddfc2..1f1e8e0ac5a3 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -84,6 +84,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs=
, size_t frame_size,
>         unsigned long math_size =3D 0;
>         unsigned long sp =3D regs->sp;
>         unsigned long buf_fx =3D 0;
> +       u32 pkru =3D read_pkru();
>
>         /* redzone */
>         if (!ia32_frame)
> @@ -139,7 +140,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *re=
gs, size_t frame_size,
>         }
>
>         /* save i387 and extended state */
> -       if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, ma=
th_size))
> +       if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, ma=
th_size, pkru))
>                 return (void __user *)-1L;
>
>         return (void __user *)sp;
> --
> 2.39.3
>

