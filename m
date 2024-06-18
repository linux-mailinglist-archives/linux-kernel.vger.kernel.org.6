Return-Path: <linux-kernel+bounces-220279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB03D90DEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239E22856A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFE01779A9;
	Tue, 18 Jun 2024 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2fUyRph"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22561C2BD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718748172; cv=none; b=gaIqQ9OYVqldny6M3rYLuOWu42ypopVfNDl1kAQaUy7Z5EWQSJXzL6rZYu9dI+6tZxfyxVoYAIL7yYkdj2kUiV0MYvpqLtw5T7nOQerMebFWxYkIHCVGOFeEq2cEX15Bveyg1kG2fxuUEv7Ss3SjHGyr8qvlmMAs5Pv2/dhC1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718748172; c=relaxed/simple;
	bh=7DGpMJLYIXVTHgZcIOd3gbKWNpQEgUtd1gQsJXGnhjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0vPvcl82tpbJ24CExkooEX5JUVPEA4zaDleHOe7m1tIQ2Q7xX6R5EH2Ojv+C2LxAeGaSS2HV66n2AhSBp2NT7lVIOYPtDHQsMYyk9yh+RCwptolBvPV9hWpYX64rMmOzKnpy3zPnsbt+fhT/8AMyqkjusES1tHM+ZlMMPRTd2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2fUyRph; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so50701095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718748169; x=1719352969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9Ti1rPFPqDuS7hspRTYTnkYQU12khMqwxR3h0O2YqI=;
        b=m2fUyRphg4tnBnXOwxfLQmtHaExcBGpGnrEWKwHZs3phCgid7J6uTgG/MkJtmZ65dN
         f0esSaReDykAy9q4+HhR3tn0vWCBf+VmKwZht0WdrTOuIA1ymt5hhjvQRbiU1AM//EvT
         OvSoBalVqThrQJNfm++Grs9/ZWFZqbCnGU+GAu08v/ZHxo/eP+XkRRJUyDnmkbIGT9r8
         2VLDgBRpTbkd500dJBTRBgojXb2Zzr2fBF/AYl4lG437MX1Jz1cE6eIdatsbT+akZuIH
         2uQ4qyjKIEQpTkR3gr0sTUWzPM7cENBpuoYMok7YKoIqxQ6zQ9SKYiSseKnNg6eDNrQ8
         K1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718748169; x=1719352969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9Ti1rPFPqDuS7hspRTYTnkYQU12khMqwxR3h0O2YqI=;
        b=KnMD4kK30A16Xcv0UTVc9zw0EJboTvXv4j3He0hMWMIvaE7+QKwDnQFBDxGvtS8m9x
         mZSaXIJWMV0uqqzciEYsLBYDV9CMXncRDun2waByCFPvKaB6GeXgZHq/5DA5Krc7oIcc
         uVaLn6y7asaNoaqfuD8Ll2KLXlx1/QzOoxx+g+vLNDfgvL6Y8EX3TINwnunKvcYEF/wx
         4c38HqbL4zDML5p4A+vEWguJddGj+dyEUgJ+EeaCI48Zxy36eYpRDTq0bwjfZHaZlo1/
         bCgU4k0ynOB6jTlyWa8mMBsfHJbDSOGji1GwouKAw/eN90lZ+HAIyZb1Wk2Ni3bXvOt5
         PYPQ==
X-Gm-Message-State: AOJu0YzKDQdVUT8ZJW0zU98zk7t1MuZaZ9jSvkJDoEx6HI+b4RKOBk2l
	m6Bop/8EGMDs8HhtTWxjlx1euXYOW1HPz0o3DhSxHhr4LXFkaseL
X-Google-Smtp-Source: AGHT+IGs4sivzCYGF5hQZhcuVMFkAx2W5ppBKKYUCRRt9rMhXrmgq0TNsdH/+xDrZCZtoSxpTeljxw==
X-Received: by 2002:a05:600c:4a22:b0:423:b740:fa1 with SMTP id 5b1f17b1804b1-424751755f9mr4324775e9.15.1718748168927;
        Tue, 18 Jun 2024 15:02:48 -0700 (PDT)
Received: from f (cst-prg-30-39.cust.vodafone.cz. [46.135.30.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602f620sm202348495e9.19.2024.06.18.15.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 15:02:48 -0700 (PDT)
Date: Wed, 19 Jun 2024 00:02:32 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 206/208] x86/fpu: Add CONFIG_X86_DEBUG_FPU=y FPU
 debugging code
Message-ID: <2opxpt7mglwwb4fcetaeautgrxkzrgyhs4vke2hygm7qxc4hu3@cncmkleunmli>
References: <1430848712-28064-1-git-send-email-mingo@kernel.org>
 <1430848712-28064-46-git-send-email-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1430848712-28064-46-git-send-email-mingo@kernel.org>

On Tue, May 05, 2015 at 07:58:30PM +0200, Ingo Molnar wrote:
> There are various internal FPU state debugging checks that never
> trigger in practice, but which are useful for FPU code development.
> 
> Separate these out into CONFIG_X86_DEBUG_FPU=y, and also add a
> couple of new ones.
> 
> The size difference is about 0.5K of code on defconfig:
> 
>    text        data     bss          filename
>    15028906    2578816  1638400      vmlinux
>    15029430    2578816  1638400      vmlinux
> 
> ( Keep this enabled by default until the new FPU code is debugged. )
> 
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/Kconfig.debug              | 12 ++++++++++++
>  arch/x86/include/asm/fpu/internal.h | 17 ++++++++++++++++-
>  arch/x86/kernel/fpu/core.c          | 18 +++++++++---------
>  arch/x86/kernel/fpu/init.c          | 12 +++++++++++-
>  arch/x86/kernel/fpu/xstate.c        | 11 ++++++++++-
>  5 files changed, 58 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index 72484a645f05..2fd3ebbb4e33 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -332,4 +332,16 @@ config X86_DEBUG_STATIC_CPU_HAS
>  
>  	  If unsure, say N.
>  
> +config X86_DEBUG_FPU
> +	bool "Debug the x86 FPU code"
> +	depends on DEBUG_KERNEL
> +	default y
> +	---help---
> +	  If this option is enabled then there will be extra sanity
> +	  checks and (boot time) debug printouts added to the kernel.
> +	  This debugging adds some small amount of runtime overhead
> +	  to the kernel.
> +
> +	  If unsure, say N.
> +

This still defaults to yes today and what's more distros like Debian and
Ubuntu have it enabled.

If this is not considered relevant for production kernels anymore would
you mind flipping it to off by default? Will probably give me easier
time convcing these distros to change their configs.

I'm too lazy to check the specific impact of this opt, but I do see it
on perf top when looking at syscalls on a CPU which is not shafted by
meltdown et al.

>  endmenu
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index a4c1b7dbf70e..d2a281bd5f45 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -59,6 +59,15 @@ extern void fpu__clear(struct fpu *fpu);
>  extern void fpu__init_check_bugs(void);
>  extern void fpu__resume_cpu(void);
>  
> +/*
> + * Debugging facility:
> + */
> +#ifdef CONFIG_X86_DEBUG_FPU
> +# define WARN_ON_FPU(x) WARN_ON_ONCE(x)
> +#else
> +# define WARN_ON_FPU(x) ({ 0; })
> +#endif
> +
>  DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
>  
>  /*
> @@ -296,6 +305,8 @@ static inline void __fpregs_deactivate_hw(void)
>  /* Must be paired with an 'stts' (fpregs_deactivate_hw()) after! */
>  static inline void __fpregs_deactivate(struct fpu *fpu)
>  {
> +	WARN_ON_FPU(!fpu->fpregs_active);
> +
>  	fpu->fpregs_active = 0;
>  	this_cpu_write(fpu_fpregs_owner_ctx, NULL);
>  }
> @@ -303,6 +314,8 @@ static inline void __fpregs_deactivate(struct fpu *fpu)
>  /* Must be paired with a 'clts' (fpregs_activate_hw()) before! */
>  static inline void __fpregs_activate(struct fpu *fpu)
>  {
> +	WARN_ON_FPU(fpu->fpregs_active);
> +
>  	fpu->fpregs_active = 1;
>  	this_cpu_write(fpu_fpregs_owner_ctx, fpu);
>  }
> @@ -433,8 +446,10 @@ switch_fpu_prepare(struct fpu *old_fpu, struct fpu *new_fpu, int cpu)
>  static inline void switch_fpu_finish(struct fpu *new_fpu, fpu_switch_t fpu_switch)
>  {
>  	if (fpu_switch.preload) {
> -		if (unlikely(copy_fpstate_to_fpregs(new_fpu)))
> +		if (unlikely(copy_fpstate_to_fpregs(new_fpu))) {
> +			WARN_ON_FPU(1);
>  			fpu__clear(new_fpu);
> +		}
>  	}
>  }
>  
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 421a98103820..9df2a09f1bbe 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -38,13 +38,13 @@ DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
>  
>  static void kernel_fpu_disable(void)
>  {
> -	WARN_ON(this_cpu_read(in_kernel_fpu));
> +	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
>  	this_cpu_write(in_kernel_fpu, true);
>  }
>  
>  static void kernel_fpu_enable(void)
>  {
> -	WARN_ON_ONCE(!this_cpu_read(in_kernel_fpu));
> +	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
>  	this_cpu_write(in_kernel_fpu, false);
>  }
>  
> @@ -109,7 +109,7 @@ void __kernel_fpu_begin(void)
>  {
>  	struct fpu *fpu = &current->thread.fpu;
>  
> -	WARN_ON_ONCE(!irq_fpu_usable());
> +	WARN_ON_FPU(!irq_fpu_usable());
>  
>  	kernel_fpu_disable();
>  
> @@ -127,7 +127,7 @@ void __kernel_fpu_end(void)
>  	struct fpu *fpu = &current->thread.fpu;
>  
>  	if (fpu->fpregs_active) {
> -		if (WARN_ON(copy_fpstate_to_fpregs(fpu)))
> +		if (WARN_ON_FPU(copy_fpstate_to_fpregs(fpu)))
>  			fpu__clear(fpu);
>  	} else {
>  		__fpregs_deactivate_hw();
> @@ -187,7 +187,7 @@ EXPORT_SYMBOL_GPL(irq_ts_restore);
>   */
>  void fpu__save(struct fpu *fpu)
>  {
> -	WARN_ON(fpu != &current->thread.fpu);
> +	WARN_ON_FPU(fpu != &current->thread.fpu);
>  
>  	preempt_disable();
>  	if (fpu->fpregs_active) {
> @@ -233,7 +233,7 @@ EXPORT_SYMBOL_GPL(fpstate_init);
>   */
>  static void fpu_copy(struct fpu *dst_fpu, struct fpu *src_fpu)
>  {
> -	WARN_ON(src_fpu != &current->thread.fpu);
> +	WARN_ON_FPU(src_fpu != &current->thread.fpu);
>  
>  	/*
>  	 * Don't let 'init optimized' areas of the XSAVE area
> @@ -284,7 +284,7 @@ int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
>   */
>  void fpu__activate_curr(struct fpu *fpu)
>  {
> -	WARN_ON_ONCE(fpu != &current->thread.fpu);
> +	WARN_ON_FPU(fpu != &current->thread.fpu);
>  
>  	if (!fpu->fpstate_active) {
>  		fpstate_init(&fpu->state);
> @@ -321,7 +321,7 @@ EXPORT_SYMBOL_GPL(fpu__activate_curr);
>   */
>  void fpu__activate_stopped(struct fpu *child_fpu)
>  {
> -	WARN_ON_ONCE(child_fpu == &current->thread.fpu);
> +	WARN_ON_FPU(child_fpu == &current->thread.fpu);
>  
>  	if (child_fpu->fpstate_active) {
>  		child_fpu->last_cpu = -1;
> @@ -407,7 +407,7 @@ static inline void copy_init_fpstate_to_fpregs(void)
>   */
>  void fpu__clear(struct fpu *fpu)
>  {
> -	WARN_ON_ONCE(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
> +	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
>  
>  	if (!use_eager_fpu()) {
>  		/* FPU state will be reallocated lazily at the first use. */
> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> index a9e506a99a83..e9f1d6e62146 100644
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -143,6 +143,11 @@ EXPORT_SYMBOL_GPL(xstate_size);
>   */
>  static void __init fpu__init_system_xstate_size_legacy(void)
>  {
> +	static int on_boot_cpu = 1;
> +
> +	WARN_ON_FPU(!on_boot_cpu);
> +	on_boot_cpu = 0;
> +
>  	/*
>  	 * Note that xstate_size might be overwriten later during
>  	 * fpu__init_system_xstate().
> @@ -214,7 +219,12 @@ __setup("eagerfpu=", eager_fpu_setup);
>   */
>  static void __init fpu__init_system_ctx_switch(void)
>  {
> -	WARN_ON(current->thread.fpu.fpstate_active);
> +	static bool on_boot_cpu = 1;
> +
> +	WARN_ON_FPU(!on_boot_cpu);
> +	on_boot_cpu = 0;
> +
> +	WARN_ON_FPU(current->thread.fpu.fpstate_active);
>  	current_thread_info()->status = 0;
>  
>  	/* Auto enable eagerfpu for xsaveopt */
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 201f08feb259..5724098adf1b 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -262,6 +262,11 @@ static void __init setup_xstate_comp(void)
>   */
>  static void __init setup_init_fpu_buf(void)
>  {
> +	static int on_boot_cpu = 1;
> +
> +	WARN_ON_FPU(!on_boot_cpu);
> +	on_boot_cpu = 0;
> +
>  	if (!cpu_has_xsave)
>  		return;
>  
> @@ -317,6 +322,10 @@ static void __init init_xstate_size(void)
>  void __init fpu__init_system_xstate(void)
>  {
>  	unsigned int eax, ebx, ecx, edx;
> +	static int on_boot_cpu = 1;
> +
> +	WARN_ON_FPU(!on_boot_cpu);
> +	on_boot_cpu = 0;
>  
>  	if (!cpu_has_xsave) {
>  		pr_info("x86/fpu: Legacy x87 FPU detected.\n");
> @@ -324,7 +333,7 @@ void __init fpu__init_system_xstate(void)
>  	}
>  
>  	if (boot_cpu_data.cpuid_level < XSTATE_CPUID) {
> -		WARN(1, "x86/fpu: XSTATE_CPUID missing!\n");
> +		WARN_ON_FPU(1);
>  		return;
>  	}
>  
> -- 
> 2.1.0
> 

