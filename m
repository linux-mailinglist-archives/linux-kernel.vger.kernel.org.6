Return-Path: <linux-kernel+bounces-531496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A92A44130
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFB63BA6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0342E2690F8;
	Tue, 25 Feb 2025 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDaGR7Pb"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA52698BB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491027; cv=none; b=ZK8pgZJzQqy5mwNwazSbKHbfcwXGgOSQFX0gFOrV/T57h01b9E3DM96vH6ydrHAD7rz9OvB9yjxh0UWS4F+NxvDgD1ZDBSGx+A71EGURwX4Ri91NllJfbpdzQouEBMvtjxXjGU6nU9192UJoxtlmoD7gDmTx6SGg7+9/Q7Vh9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491027; c=relaxed/simple;
	bh=CIhJ39xRLf3XqameiIOMNADMAF/denabJo6+CtsvDpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJHN7B6ZOFd2paP0rBgOvJDrlQ5z/fT6YVBxGcoflx/q5Sl60G+IJ5+jMh6a2PX8YmSF3ukZ3dk0VzyWbgC3BP8O/+j40vPRHSLiGseDT5YlEv+e2zHnMzY84jOibx6MDgT/IklV/HGGz6OtVrDEgyAIfmlbdKQBxNFyItouGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDaGR7Pb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so9800546a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740491023; x=1741095823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaY6qiC9dtNVL0E46uMKcPgTJi90bYH70FnlWXnXBVA=;
        b=HDaGR7PbRTSdsCQiC/mtDYKBHXiOTPGX1/IWOsZVYFWmooRWhvqp45ZSXremZgT9Xr
         lXgknx418psHzIdQAvJOYHsN4OuA/V4W1sqzJQO5AyReTBSXdxaWTpzHkPZ1DqjDK5kZ
         dgeIJ75al2UltBxV+k42KZzAG7cTzOvBFVEUjXm2I5sC5l/OELj66OTKFFpY1teD2dBY
         yMtB1AFVJ0WiiaN74Rvs7eyhb7A+8Gp6VRZTk9mxxQrNoVAwFizRbCiOOiZiTPGJ+gII
         Sguv8HX4H5LpFvAUFTtuvWUPl7AGiFjiEPc2Zi+a/NMDkcna0jn/NXFQpUjspjiD/+AD
         Y68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491023; x=1741095823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaY6qiC9dtNVL0E46uMKcPgTJi90bYH70FnlWXnXBVA=;
        b=kF4LgSky2+9JD0HT84V8q0ehXYaK9I8SQRDxRFkeKqcOGtIYWKceEPdnyG9gzGJFvB
         aXts1Pz0cl67ZLdi8DMrQ+AaQqSQR59WQ+6T9rCqcLSwLvCz0cnN5xpaGbsl/j5Ys9kP
         2IamhATxNjZ3W87QT/f+ghuT1DNNj3nrliFF+Jy4UDr1CJAMyMxZ8jVxnsLO42KF/MI1
         wtoPqR5zbneq9w5o6RxNcY/i/VgcPJhTx4B9Yjp4NY+TE7k/g5gZq6jGX0M5fOR7pS7j
         sWc+4l5dji97XhlgDTW9Yop2/iIkfonSIKQSYZWyPVE+VUaTX+rCZZw7oJF2mHnRTWDN
         IIhg==
X-Gm-Message-State: AOJu0Yx14x+wB52UVt7TWqVJdZSKZQiJyI2p4K+JBM54In+yoXtedHdM
	xrkSnksrNiWksgsYUR1R5uemFZSnGgz22l3aelmg6xD+Gr/cHFAzKS2SeoeAFqTxe9mNDlothEt
	K7U1MnCgcr8/XZPjo8H6S14YJae0=
X-Gm-Gg: ASbGncttiv0V+sle7YA+zplyDf/NeVw3l2IGY8KKS/c61eLbdvwNtEDviLLNyUVg6r+
	tLfr9MrF9EVcfXD/5wU1NEu5EalWUBQUcnLz5PDhpC5Pqp2zsTnhDBOtx+ITXS1MY8EP73jh2wy
	ulvrg09f0=
X-Google-Smtp-Source: AGHT+IE6wBSiBR3SBVInUV6ln/NCuMO1QqN3E5AKpJkbtw9Td23AtmbaP7RuQgUhN4NfQF/TLS42GFgO9mbQAUxZJ3M=
X-Received: by 2002:a05:6402:51d1:b0:5e0:8a27:cd36 with SMTP id
 4fb4d7f45d1cf-5e0a125f6a2mr17243651a12.8.1740491023128; Tue, 25 Feb 2025
 05:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1430848712-28064-1-git-send-email-mingo@kernel.org>
 <1430848712-28064-46-git-send-email-mingo@kernel.org> <2opxpt7mglwwb4fcetaeautgrxkzrgyhs4vke2hygm7qxc4hu3@cncmkleunmli>
In-Reply-To: <2opxpt7mglwwb4fcetaeautgrxkzrgyhs4vke2hygm7qxc4hu3@cncmkleunmli>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Feb 2025 14:43:30 +0100
X-Gm-Features: AQ5f1JojekcMtKTw5bcZ0v9cPCivhRav2az8JQ4bzkRc4Wd5QDUJu7QJW1ObJnQ
Message-ID: <CAGudoHFSmv8F1AgwAXpBVq0UrqziuU5R9ine64Z3X1KxU41DUw@mail.gmail.com>
Subject: Re: [PATCH 206/208] x86/fpu: Add CONFIG_X86_DEBUG_FPU=y FPU debugging code
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 12:02=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Tue, May 05, 2015 at 07:58:30PM +0200, Ingo Molnar wrote:
> > There are various internal FPU state debugging checks that never
> > trigger in practice, but which are useful for FPU code development.
> >
> > Separate these out into CONFIG_X86_DEBUG_FPU=3Dy, and also add a
> > couple of new ones.
> >
> > The size difference is about 0.5K of code on defconfig:
> >
> >    text        data     bss          filename
> >    15028906    2578816  1638400      vmlinux
> >    15029430    2578816  1638400      vmlinux
> >
> > ( Keep this enabled by default until the new FPU code is debugged. )
> >
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  arch/x86/Kconfig.debug              | 12 ++++++++++++
> >  arch/x86/include/asm/fpu/internal.h | 17 ++++++++++++++++-
> >  arch/x86/kernel/fpu/core.c          | 18 +++++++++---------
> >  arch/x86/kernel/fpu/init.c          | 12 +++++++++++-
> >  arch/x86/kernel/fpu/xstate.c        | 11 ++++++++++-
> >  5 files changed, 58 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> > index 72484a645f05..2fd3ebbb4e33 100644
> > --- a/arch/x86/Kconfig.debug
> > +++ b/arch/x86/Kconfig.debug
> > @@ -332,4 +332,16 @@ config X86_DEBUG_STATIC_CPU_HAS
> >
> >         If unsure, say N.
> >
> > +config X86_DEBUG_FPU
> > +     bool "Debug the x86 FPU code"
> > +     depends on DEBUG_KERNEL
> > +     default y
> > +     ---help---
> > +       If this option is enabled then there will be extra sanity
> > +       checks and (boot time) debug printouts added to the kernel.
> > +       This debugging adds some small amount of runtime overhead
> > +       to the kernel.
> > +
> > +       If unsure, say N.
> > +
>
> This still defaults to yes today and what's more distros like Debian and
> Ubuntu have it enabled.
>
> If this is not considered relevant for production kernels anymore would
> you mind flipping it to off by default? Will probably give me easier
> time convcing these distros to change their configs.
>
> I'm too lazy to check the specific impact of this opt, but I do see it
> on perf top when looking at syscalls on a CPU which is not shafted by
> meltdown et al.
>

ping?

the commit message says:
> > ( Keep this enabled by default until the new FPU code is debugged. )

2015 vintage

is the FPU code considered debugged yet? :)

> >  endmenu
> > diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm=
/fpu/internal.h
> > index a4c1b7dbf70e..d2a281bd5f45 100644
> > --- a/arch/x86/include/asm/fpu/internal.h
> > +++ b/arch/x86/include/asm/fpu/internal.h
> > @@ -59,6 +59,15 @@ extern void fpu__clear(struct fpu *fpu);
> >  extern void fpu__init_check_bugs(void);
> >  extern void fpu__resume_cpu(void);
> >
> > +/*
> > + * Debugging facility:
> > + */
> > +#ifdef CONFIG_X86_DEBUG_FPU
> > +# define WARN_ON_FPU(x) WARN_ON_ONCE(x)
> > +#else
> > +# define WARN_ON_FPU(x) ({ 0; })
> > +#endif
> > +
> >  DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
> >
> >  /*
> > @@ -296,6 +305,8 @@ static inline void __fpregs_deactivate_hw(void)
> >  /* Must be paired with an 'stts' (fpregs_deactivate_hw()) after! */
> >  static inline void __fpregs_deactivate(struct fpu *fpu)
> >  {
> > +     WARN_ON_FPU(!fpu->fpregs_active);
> > +
> >       fpu->fpregs_active =3D 0;
> >       this_cpu_write(fpu_fpregs_owner_ctx, NULL);
> >  }
> > @@ -303,6 +314,8 @@ static inline void __fpregs_deactivate(struct fpu *=
fpu)
> >  /* Must be paired with a 'clts' (fpregs_activate_hw()) before! */
> >  static inline void __fpregs_activate(struct fpu *fpu)
> >  {
> > +     WARN_ON_FPU(fpu->fpregs_active);
> > +
> >       fpu->fpregs_active =3D 1;
> >       this_cpu_write(fpu_fpregs_owner_ctx, fpu);
> >  }
> > @@ -433,8 +446,10 @@ switch_fpu_prepare(struct fpu *old_fpu, struct fpu=
 *new_fpu, int cpu)
> >  static inline void switch_fpu_finish(struct fpu *new_fpu, fpu_switch_t=
 fpu_switch)
> >  {
> >       if (fpu_switch.preload) {
> > -             if (unlikely(copy_fpstate_to_fpregs(new_fpu)))
> > +             if (unlikely(copy_fpstate_to_fpregs(new_fpu))) {
> > +                     WARN_ON_FPU(1);
> >                       fpu__clear(new_fpu);
> > +             }
> >       }
> >  }
> >
> > diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> > index 421a98103820..9df2a09f1bbe 100644
> > --- a/arch/x86/kernel/fpu/core.c
> > +++ b/arch/x86/kernel/fpu/core.c
> > @@ -38,13 +38,13 @@ DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
> >
> >  static void kernel_fpu_disable(void)
> >  {
> > -     WARN_ON(this_cpu_read(in_kernel_fpu));
> > +     WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
> >       this_cpu_write(in_kernel_fpu, true);
> >  }
> >
> >  static void kernel_fpu_enable(void)
> >  {
> > -     WARN_ON_ONCE(!this_cpu_read(in_kernel_fpu));
> > +     WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
> >       this_cpu_write(in_kernel_fpu, false);
> >  }
> >
> > @@ -109,7 +109,7 @@ void __kernel_fpu_begin(void)
> >  {
> >       struct fpu *fpu =3D &current->thread.fpu;
> >
> > -     WARN_ON_ONCE(!irq_fpu_usable());
> > +     WARN_ON_FPU(!irq_fpu_usable());
> >
> >       kernel_fpu_disable();
> >
> > @@ -127,7 +127,7 @@ void __kernel_fpu_end(void)
> >       struct fpu *fpu =3D &current->thread.fpu;
> >
> >       if (fpu->fpregs_active) {
> > -             if (WARN_ON(copy_fpstate_to_fpregs(fpu)))
> > +             if (WARN_ON_FPU(copy_fpstate_to_fpregs(fpu)))
> >                       fpu__clear(fpu);
> >       } else {
> >               __fpregs_deactivate_hw();
> > @@ -187,7 +187,7 @@ EXPORT_SYMBOL_GPL(irq_ts_restore);
> >   */
> >  void fpu__save(struct fpu *fpu)
> >  {
> > -     WARN_ON(fpu !=3D &current->thread.fpu);
> > +     WARN_ON_FPU(fpu !=3D &current->thread.fpu);
> >
> >       preempt_disable();
> >       if (fpu->fpregs_active) {
> > @@ -233,7 +233,7 @@ EXPORT_SYMBOL_GPL(fpstate_init);
> >   */
> >  static void fpu_copy(struct fpu *dst_fpu, struct fpu *src_fpu)
> >  {
> > -     WARN_ON(src_fpu !=3D &current->thread.fpu);
> > +     WARN_ON_FPU(src_fpu !=3D &current->thread.fpu);
> >
> >       /*
> >        * Don't let 'init optimized' areas of the XSAVE area
> > @@ -284,7 +284,7 @@ int fpu__copy(struct fpu *dst_fpu, struct fpu *src_=
fpu)
> >   */
> >  void fpu__activate_curr(struct fpu *fpu)
> >  {
> > -     WARN_ON_ONCE(fpu !=3D &current->thread.fpu);
> > +     WARN_ON_FPU(fpu !=3D &current->thread.fpu);
> >
> >       if (!fpu->fpstate_active) {
> >               fpstate_init(&fpu->state);
> > @@ -321,7 +321,7 @@ EXPORT_SYMBOL_GPL(fpu__activate_curr);
> >   */
> >  void fpu__activate_stopped(struct fpu *child_fpu)
> >  {
> > -     WARN_ON_ONCE(child_fpu =3D=3D &current->thread.fpu);
> > +     WARN_ON_FPU(child_fpu =3D=3D &current->thread.fpu);
> >
> >       if (child_fpu->fpstate_active) {
> >               child_fpu->last_cpu =3D -1;
> > @@ -407,7 +407,7 @@ static inline void copy_init_fpstate_to_fpregs(void=
)
> >   */
> >  void fpu__clear(struct fpu *fpu)
> >  {
> > -     WARN_ON_ONCE(fpu !=3D &current->thread.fpu); /* Almost certainly =
an anomaly */
> > +     WARN_ON_FPU(fpu !=3D &current->thread.fpu); /* Almost certainly a=
n anomaly */
> >
> >       if (!use_eager_fpu()) {
> >               /* FPU state will be reallocated lazily at the first use.=
 */
> > diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> > index a9e506a99a83..e9f1d6e62146 100644
> > --- a/arch/x86/kernel/fpu/init.c
> > +++ b/arch/x86/kernel/fpu/init.c
> > @@ -143,6 +143,11 @@ EXPORT_SYMBOL_GPL(xstate_size);
> >   */
> >  static void __init fpu__init_system_xstate_size_legacy(void)
> >  {
> > +     static int on_boot_cpu =3D 1;
> > +
> > +     WARN_ON_FPU(!on_boot_cpu);
> > +     on_boot_cpu =3D 0;
> > +
> >       /*
> >        * Note that xstate_size might be overwriten later during
> >        * fpu__init_system_xstate().
> > @@ -214,7 +219,12 @@ __setup("eagerfpu=3D", eager_fpu_setup);
> >   */
> >  static void __init fpu__init_system_ctx_switch(void)
> >  {
> > -     WARN_ON(current->thread.fpu.fpstate_active);
> > +     static bool on_boot_cpu =3D 1;
> > +
> > +     WARN_ON_FPU(!on_boot_cpu);
> > +     on_boot_cpu =3D 0;
> > +
> > +     WARN_ON_FPU(current->thread.fpu.fpstate_active);
> >       current_thread_info()->status =3D 0;
> >
> >       /* Auto enable eagerfpu for xsaveopt */
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.=
c
> > index 201f08feb259..5724098adf1b 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -262,6 +262,11 @@ static void __init setup_xstate_comp(void)
> >   */
> >  static void __init setup_init_fpu_buf(void)
> >  {
> > +     static int on_boot_cpu =3D 1;
> > +
> > +     WARN_ON_FPU(!on_boot_cpu);
> > +     on_boot_cpu =3D 0;
> > +
> >       if (!cpu_has_xsave)
> >               return;
> >
> > @@ -317,6 +322,10 @@ static void __init init_xstate_size(void)
> >  void __init fpu__init_system_xstate(void)
> >  {
> >       unsigned int eax, ebx, ecx, edx;
> > +     static int on_boot_cpu =3D 1;
> > +
> > +     WARN_ON_FPU(!on_boot_cpu);
> > +     on_boot_cpu =3D 0;
> >
> >       if (!cpu_has_xsave) {
> >               pr_info("x86/fpu: Legacy x87 FPU detected.\n");
> > @@ -324,7 +333,7 @@ void __init fpu__init_system_xstate(void)
> >       }
> >
> >       if (boot_cpu_data.cpuid_level < XSTATE_CPUID) {
> > -             WARN(1, "x86/fpu: XSTATE_CPUID missing!\n");
> > +             WARN_ON_FPU(1);
> >               return;
> >       }
> >
> > --
> > 2.1.0
> >



--=20
Mateusz Guzik <mjguzik gmail.com>

