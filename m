Return-Path: <linux-kernel+bounces-254665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1855C933604
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71521B21948
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D63AD59;
	Wed, 17 Jul 2024 04:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mm+2hurS"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A674469D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721190373; cv=none; b=Bnxjz+du8ZvOA54iAHyOv+hnERTyGE8SsUai7A7y201siwmStpNEhvDBzEnTfgdPKmuLUMVUO5HGYUSpN+RoxaknN7VGaD+32SBzTKNfq7diXw1Vqosvr7VbOlafPhLJB/A4KejSUXMnAkia2lDknmI6VKNG562kLlCFBavlgvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721190373; c=relaxed/simple;
	bh=3XPPRr7cbpej+91mhkCoe+o4ot+Bm+g0xiqNV78Es3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/aJibrOHqUjsqQDn7LAOYE3svj/UUX+da3zzfB0otKjIQvae0HE243UQ//Pxx09iyUe7xU0rcjFsKs4rUnFYewevp0atGZS3sky1FkgQ81sAut0okzRJ1sGfiRAIeSZqhW7hoFT/UspL5qI1OlEddULLC83kGwet3l1VQ8bSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mm+2hurS; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d9dd7e5f6eso2873906b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721190370; x=1721795170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXnSqB53ypalb79JsjmfTojQHgmtyv8xjoLiawhXV4A=;
        b=mm+2hurSuSeglPhNatcS/oIIqIg4rq82eMF6+bq6FDDfuLSmnaq8rDwZg76m1hU+qz
         ar1jixuk+hjMKy9hgkOPvwiuc4GWPhTmscq4tdWMZhUaxhbpp3iUogUTzS6yPQ0eyZPL
         svyBRmLfuQlPcT6oUngJVvloSdI15risxn6yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721190370; x=1721795170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXnSqB53ypalb79JsjmfTojQHgmtyv8xjoLiawhXV4A=;
        b=a/DW1HNZB63g0YsVAaKdv0Jxed0O620pSNtYWrk7v2t1lCGv1+1kgBhvcWW1JDKSJN
         baU9er5NM+RDldjFWzKL0qZcwK6rW3IxF6z9Bb+jmkl5JgBMntua9sapozjIAHIUXkyj
         fpk3ti9/lEugrs29ZvukBzfUaxVxoq8yTD56xhv5/hW/XAD6XHF1nLCR+f+LawZVmmdN
         paxWr3Sw0pZHb5QC2Mf5z9FSCXni7MVaDWHU+Ytfu0RHFTpYEl0iuaPiiCze82RNs5Tx
         aEJvlZt0SROvkirZ9e5N0GVY3lHMoWWIR7RdyWtAF04WOOpj4kkhIUJUUFuNphZagTIb
         /dOg==
X-Gm-Message-State: AOJu0YxkbBsO8DUujRkgSAsXHDkigJF/rhSntbjb87x7wXsHhcFlUDUl
	YpLu9G5bCtNFVl+T4Sjx89I41irH5Y143NivRnSSzZOaKo+emVTTzuMKc7qtLohuSgfNkarZ1bu
	7dnG7y+1otVZX6RoxwGWmMCii+tad0oR3F3bsk75+J0z+wpjkeA==
X-Google-Smtp-Source: AGHT+IGEOJHXJWTpgSK+lc7xnTg8mfxzE2Ij3IaDnovxrFuo1+ZdN0KwfpkS2KVh0mSKJ2kkawxQxcnKAOlJJTP/zmo=
X-Received: by 2002:a05:6870:9591:b0:25d:ff4c:bc64 with SMTP id
 586e51a60fabf-260d9008010mr461300fac.6.1721190370195; Tue, 16 Jul 2024
 21:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627211737.323214-1-aruna.ramakrishna@oracle.com> <20240627211737.323214-2-aruna.ramakrishna@oracle.com>
In-Reply-To: <20240627211737.323214-2-aruna.ramakrishna@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 16 Jul 2024 21:25:58 -0700
Message-ID: <CABi2SkV_vvmS=mLzJ+a7JEHEGGhDRu5kkjiPa+Z7Nh+7mWpQVg@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] x86/pkeys: Add PKRU as a parameter in signal
 handling functions
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, 
	tglx@linutronix.de, mingo@kernel.org, keith.lucas@oracle.com, 
	rick.p.edgecombe@intel.com, Jann Horn <jannh@google.com>, 
	=?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, linux-mm@kvack.org, 
	Kees Cook <keescook@chromium.org>, Jeff Xu <jeffxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:17=E2=80=AFPM Aruna Ramakrishna
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
> PKRU as an additional parameter down the chain from handle_signal:
>         setup_rt_frame()
>           xxx_setup_rt_frame()
Above two functions don't access altstack, therefore we can keep it
the same as before.

>             get_sigframe()
>               copy_fpstate_to_sigframe()
>                 copy_fpregs_to_sigframe()
>
> There are no functional changes in this patch.
>
> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> ---
>  arch/x86/include/asm/fpu/signal.h  |  2 +-
>  arch/x86/include/asm/sighandling.h | 10 +++++-----
>  arch/x86/kernel/fpu/signal.c       |  6 +++---
>  arch/x86/kernel/signal.c           | 19 ++++++++++---------
>  arch/x86/kernel/signal_32.c        |  8 ++++----
>  arch/x86/kernel/signal_64.c        |  8 ++++----
>  6 files changed, 27 insertions(+), 26 deletions(-)
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
> diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/si=
ghandling.h
> index e770c4fc47f4..de458354a3ea 100644
> --- a/arch/x86/include/asm/sighandling.h
> +++ b/arch/x86/include/asm/sighandling.h
> @@ -17,11 +17,11 @@ void signal_fault(struct pt_regs *regs, void __user *=
frame, char *where);
>
>  void __user *
>  get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_si=
ze,
> -            void __user **fpstate);
> +            void __user **fpstate, u32 pkru);
>
> -int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
> -int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
> -int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
> -int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
> +int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkr=
u);
> +int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 =
pkru);
> +int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 p=
kru);
> +int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 p=
kru);
>
>  #endif /* _ASM_X86_SIGHANDLING_H */
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
> index 31b6f5dddfc2..94b894437327 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -74,7 +74,7 @@ static inline int is_x32_frame(struct ksignal *ksig)
>   */
>  void __user *
>  get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_si=
ze,
> -            void __user **fpstate)
> +            void __user **fpstate, u32 pkru)
we can keep the signature the same, i.e. not adding pkru.

>  {
>         struct k_sigaction *ka =3D &ksig->ka;
>         int ia32_frame =3D is_ia32_frame(ksig);
> @@ -139,7 +139,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *re=
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
> @@ -206,7 +206,7 @@ unsigned long get_sigframe_size(void)
>  }
>
>  static int
> -setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
> +setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
>  {
>         /* Perform fixup for the pre-signal frame. */
>         rseq_signal_deliver(ksig, regs);
> @@ -214,21 +214,22 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs=
 *regs)
>         /* Set up the stack frame */
>         if (is_ia32_frame(ksig)) {
>                 if (ksig->ka.sa.sa_flags & SA_SIGINFO)
> -                       return ia32_setup_rt_frame(ksig, regs);
> +                       return ia32_setup_rt_frame(ksig, regs, pkru);
>                 else
> -                       return ia32_setup_frame(ksig, regs);
> +                       return ia32_setup_frame(ksig, regs, pkru);
>         } else if (is_x32_frame(ksig)) {
> -               return x32_setup_rt_frame(ksig, regs);
> +               return x32_setup_rt_frame(ksig, regs, pkru);
>         } else {
> -               return x64_setup_rt_frame(ksig, regs);
> +               return x64_setup_rt_frame(ksig, regs, pkru);
>         }
>  }
>
>  static void
>  handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>  {
> -       bool stepping, failed;
>         struct fpu *fpu =3D &current->thread.fpu;
> +       u32 pkru =3D read_pkru();
This can be moved to get_sigframe(), the same for setting pkru=3D0

> +       bool stepping, failed;
>
>         if (v8086_mode(regs))
>                 save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIG=
NAL);
> @@ -264,7 +265,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *r=
egs)
>         if (stepping)
>                 user_disable_single_step(current);
>
> -       failed =3D (setup_rt_frame(ksig, regs) < 0);
> +       failed =3D (setup_rt_frame(ksig, regs, pkru) < 0);
The failure case can be handled in get_sigframe().

>         if (!failed) {
>                 /*
>                  * Clear the direction flag as per the ABI for function e=
ntry.
> diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
> index ef654530bf5a..b437d02ecfd7 100644
> --- a/arch/x86/kernel/signal_32.c
> +++ b/arch/x86/kernel/signal_32.c
no change to signal_64.c if you keep pkru inside get_sigframe.

> @@ -228,7 +228,7 @@ do {                                                 =
                       \
>                 goto label;                                             \
>  } while(0)
>
> -int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
> +int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkr=
u)
ia32 doesn't support pkru iiuc, so no need to change the signature here.
Same comments for x32 related code path.

>  {
>         sigset32_t *set =3D (sigset32_t *) sigmask_to_save();
>         struct sigframe_ia32 __user *frame;
> @@ -246,7 +246,7 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_=
regs *regs)
>                 0x80cd,         /* int $0x80 */
>         };
>
> -       frame =3D get_sigframe(ksig, regs, sizeof(*frame), &fp);
> +       frame =3D get_sigframe(ksig, regs, sizeof(*frame), &fp, pkru);
>
>         if (ksig->ka.sa.sa_flags & SA_RESTORER) {
>                 restorer =3D ksig->ka.sa.sa_restorer;
> @@ -299,7 +299,7 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_=
regs *regs)
>         return -EFAULT;
>  }
>
> -int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
> +int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 =
pkru)
>  {
>         sigset32_t *set =3D (sigset32_t *) sigmask_to_save();
>         struct rt_sigframe_ia32 __user *frame;
> @@ -319,7 +319,7 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct =
pt_regs *regs)
>                 0,
>         };
>
> -       frame =3D get_sigframe(ksig, regs, sizeof(*frame), &fp);
> +       frame =3D get_sigframe(ksig, regs, sizeof(*frame), &fp, pkru);
>
>         if (!user_access_begin(frame, sizeof(*frame)))
>                 return -EFAULT;
> diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
> index 8a94053c5444..ccfb7824ab2c 100644
> --- a/arch/x86/kernel/signal_64.c
> +++ b/arch/x86/kernel/signal_64.c
no change to signal_64.c if you keep pkru inside get_sigframe.

> @@ -161,7 +161,7 @@ static unsigned long frame_uc_flags(struct pt_regs *r=
egs)
>         return flags;
>  }
>
> -int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
> +int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 p=
kru)
no change to this function, because it doesn't access altstack.

>  {
>         sigset_t *set =3D sigmask_to_save();
>         struct rt_sigframe __user *frame;
> @@ -172,7 +172,7 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct p=
t_regs *regs)
>         if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
>                 return -EFAULT;
>
> -       frame =3D get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &f=
p);
> +       frame =3D get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &f=
p, pkru);
>         uc_flags =3D frame_uc_flags(regs);
>
>         if (!user_access_begin(frame, sizeof(*frame)))
> @@ -300,7 +300,7 @@ int copy_siginfo_to_user32(struct compat_siginfo __us=
er *to,
>         return __copy_siginfo_to_user32(to, from);
>  }
>
> -int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
> +int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 p=
kru)
>  {
>         compat_sigset_t *set =3D (compat_sigset_t *) sigmask_to_save();
>         struct rt_sigframe_x32 __user *frame;
> @@ -311,7 +311,7 @@ int x32_setup_rt_frame(struct ksignal *ksig, struct p=
t_regs *regs)
>         if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
>                 return -EFAULT;
>
> -       frame =3D get_sigframe(ksig, regs, sizeof(*frame), &fp);
> +       frame =3D get_sigframe(ksig, regs, sizeof(*frame), &fp, pkru);
>
>         uc_flags =3D frame_uc_flags(regs);
>
> --
> 2.39.3
>

