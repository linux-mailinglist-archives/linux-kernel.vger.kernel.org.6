Return-Path: <linux-kernel+bounces-399770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37569C03F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4526FB212A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55381F756C;
	Thu,  7 Nov 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjW/Q56y"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C504D1DF72F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978937; cv=none; b=UzEC3XBjUkzwEaSK9mLJS69KJS2tuE9KDYKZne5/ywZ8BrAe8uV9OLgEtk8vZhGuer7Ac8tLkDHa0FBuqVQcg5iYAZC7uhLLVoe8RZZkdPkPbmZDeP4exLhJyXsCV/7ItWS6enXjgFD72QRCPNi2m9zJ09XQW4FKddl81aYgNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978937; c=relaxed/simple;
	bh=8SheyuXeEdQdAwiBtv1yOd5D2B7qTLd6nSStBhg3Sl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1m+vvEZaxlJqqVf/1FNrbXIh4rCKX8On6FJe8DHHPMHQd/ROK8IJG+6hVJpWKXOHdutyvavjL6Gka0/dYQWaPmka82K+qpHEr+N3jsMHDC+BlgNksIn7XpaCBtTBrL+GYdxSV+6RwSopzlwqvurMoGBt+eYKInHqgiI6kQ1IEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjW/Q56y; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb58980711so7753701fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730978934; x=1731583734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH2TvGyMXY9YW97VJ5we4gA42rGwD5BZuhtAWqoCJdU=;
        b=fjW/Q56yAoizjNLmDWM0aulJ1D4y6H8n20Qx38we/y1knYC2fV9SBTcCDxFMgw+EXe
         kihmEFzGbMxDtnkx42BuKzXPPbavI3+Wf31AbHDzwnruCLV+VH2wDIUguEgC8EgmyKg0
         baqZmXiPRAp3wUUR7ldAT6NjKvFsxE2HduTwNThz6j5VvIFcmK+QD+kSHyTUTmptrCCf
         4Pk6PaGiRORYKzpPcTzWMGZttfGJNArfO5mId9qY8ZkVZEpFgrkv1fWUD8nFAwcik5nb
         lBAT69+ON6BKoYbeheN3kl482tQnO8PZkC7WwvHv6ETwGmT1SYaFUOri69uiZgEOEEzt
         /01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978934; x=1731583734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KH2TvGyMXY9YW97VJ5we4gA42rGwD5BZuhtAWqoCJdU=;
        b=FldDLoT3Defwihat+b9brzdU0JKuCozKMDjN4RYeK2cG/Q9a7DcT+88v9XU3Hrsw8P
         DF+cJ/pzH64NzVSnBI2k7KQc4cgvw9RIID3yGpLCz9lSAQ4GyAe0SdXBhLudzI5AuK/2
         BiNeoOIZf2uHQZUHluE9MtMWZsb/vi1R2E7ur1XgEH95UoZktm8eVYfYPgAQ4A3DNyPA
         CmoRHFlphSwtrrwGuZ3En2QM2ysNg+QhMBJgHRJBFcOSAPgCyUm2cHf8S463PKG5ICBV
         FlBnwU6OksQNeTZMSCHn31tElXMiHeX5oHI8518oGxo+tSxPyoIdZxsvC4IweqHaTwto
         1Vfw==
X-Gm-Message-State: AOJu0YwnIiDNDoK7JU5ETKSFo5pTIA2zDHS9wJimGlXe5o2Cf2XxxxcW
	TOc8GBJQJ1+fLUIDN9odBkQ3D8nHPnNA9rBugW+oBAdmRgCiKfCvZKHhwlJaU4I+eEh1bAoAkp7
	WaGyMxWB2m38y6vIeS8kEmqNmhiY=
X-Google-Smtp-Source: AGHT+IGE+6Sed1lbI+/2K7h2+B9i7ga+9xMaq9BcktQWMzDex+t3m5yOEc+2JEcEAvhpfwuFSin1UI/e46fP1JaTtgo=
X-Received: by 2002:a2e:a0cd:0:b0:2f7:4c9d:7a83 with SMTP id
 38308e7fff4ca-2fcbe078a64mr168375911fa.40.1730978933446; Thu, 07 Nov 2024
 03:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-10-brgerst@gmail.com>
In-Reply-To: <20241105155801.1779119-10-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 12:28:42 +0100
Message-ID: <CAFULd4YA0g0Mx0AKBfM-nK_OuTf0pY_fAnR5CCiJeh0cKPLMnQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/16] x86/percpu/64: Use relative percpu offsets
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> The percpu section is currently linked at absolute address 0, because
> older compilers hardcoded the stack protector canary value at a fixed
> offset from the start of the GS segment.  Now that the canary is a
> normal percpu variable, the percpu section does not need to be linked
> at a specific address.
>
> x86-64 will now calculate the percpu offsets as the delta between the
> initial percpu address and the dynamically allocated memory, like other
> architectures.  Note that GSBASE is limited to the canonical address
> width (48 or 57 bits, sign-extended).  As long as the kernel text,
> modules, and the dynamically allocated percpu memmory are all in the
> negative address space, the delta will not overflow this limit.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/include/asm/processor.h |  6 +++++-
>  arch/x86/kernel/head_64.S        | 19 +++++++++----------
>  arch/x86/kernel/setup_percpu.c   | 12 ++----------
>  arch/x86/kernel/vmlinux.lds.S    | 29 +----------------------------
>  arch/x86/platform/pvh/head.S     |  5 ++---
>  arch/x86/tools/relocs.c          | 10 +++-------
>  arch/x86/xen/xen-head.S          |  9 ++++-----
>  init/Kconfig                     |  2 +-
>  8 files changed, 27 insertions(+), 65 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index a113c3f4f558..ae50d5d4fa26 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -428,7 +428,11 @@ DECLARE_INIT_PER_CPU(fixed_percpu_data);
>
>  static inline unsigned long cpu_kernelmode_gs_base(int cpu)
>  {
> -       return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
> +#ifdef CONFIG_SMP
> +       return per_cpu_offset(cpu);
> +#else
> +       return 0;
> +#endif
>  }
>
>  extern asmlinkage void entry_SYSCALL32_ignore(void);
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index c3028b4df85f..ffbcb0aea450 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -61,11 +61,14 @@ SYM_CODE_START_NOALIGN(startup_64)
>         /* Set up the stack for verify_cpu() */
>         leaq    __top_init_kernel_stack(%rip), %rsp
>
> -       /* Setup GSBASE to allow stack canary access for C code */
> +       /*
> +        * Set up GSBASE.
> +        * Note that, on SMP, the boot cpu uses init data section until
> +        * the per cpu areas are set up.
> +        */
>         movl    $MSR_GS_BASE, %ecx
> -       leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> -       movl    %edx, %eax
> -       shrq    $32,  %rdx
> +       xorl    %eax, %eax
> +       xorl    %edx, %edx

You can use cltd after "xor %eax, %eax", it is one byte shorter with
the same effect ...

>         wrmsr
>
>         call    startup_64_setup_gdt_idt
> @@ -353,16 +356,12 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
>         movl %eax,%fs
>         movl %eax,%gs
>
> -       /* Set up %gs.
> -        *
> -        * The base of %gs always points to fixed_percpu_data.
> +       /*
> +        * Set up GSBASE.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
>         movl    $MSR_GS_BASE,%ecx
> -#ifndef CONFIG_SMP
> -       leaq    INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> -#endif
>         movl    %edx, %eax
>         shrq    $32, %rdx
>         wrmsr
> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percp=
u.c
> index b30d6e180df7..1e7be9409aa2 100644
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -23,18 +23,10 @@
>  #include <asm/cpumask.h>
>  #include <asm/cpu.h>
>
> -#ifdef CONFIG_X86_64
> -#define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
> -#else
> -#define BOOT_PERCPU_OFFSET 0
> -#endif
> -
> -DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off) =3D BOOT_PERCPU_=
OFFSET;
> +DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
>  EXPORT_PER_CPU_SYMBOL(this_cpu_off);
>
> -unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init =3D {
> -       [0 ... NR_CPUS-1] =3D BOOT_PERCPU_OFFSET,
> -};
> +unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;
>  EXPORT_SYMBOL(__per_cpu_offset);
>
>  /*
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index d61c3584f3e6..42d1c05b0207 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -99,12 +99,6 @@ const_pcpu_hot =3D pcpu_hot;
>  PHDRS {
>         text PT_LOAD FLAGS(5);          /* R_E */
>         data PT_LOAD FLAGS(6);          /* RW_ */
> -#ifdef CONFIG_X86_64
> -#ifdef CONFIG_SMP
> -       percpu PT_LOAD FLAGS(6);        /* RW_ */
> -#endif
> -       init PT_LOAD FLAGS(7);          /* RWE */
> -#endif
>         note PT_NOTE FLAGS(0);          /* ___ */
>  }
>
> @@ -199,21 +193,7 @@ SECTIONS
>                 __init_begin =3D .; /* paired with __init_end */
>         }
>
> -#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
> -       /*
> -        * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes =
the
> -        * output PHDR, so the next output section - .init.text - should
> -        * start another segment - init.
> -        */
> -       PERCPU_VADDR(INTERNODE_CACHE_BYTES, 0, :percpu)
> -       ASSERT(SIZEOF(.data..percpu) < CONFIG_PHYSICAL_START,
> -              "per-CPU data too large - increase CONFIG_PHYSICAL_START")
> -#endif
> -
>         INIT_TEXT_SECTION(PAGE_SIZE)
> -#ifdef CONFIG_X86_64
> -       :init
> -#endif
>
>         /*
>          * Section for code used exclusively before alternatives are run.=
 All
> @@ -330,9 +310,7 @@ SECTIONS
>                 EXIT_DATA
>         }
>
> -#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
>         PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> -#endif
>
>         RUNTIME_CONST_VARIABLES
>         RUNTIME_CONST(ptr, USER_PTR_MAX)
> @@ -476,16 +454,11 @@ PROVIDE(__ref_stack_chk_guard =3D __stack_chk_guard=
);
>   * Per-cpu symbols which need to be offset from __per_cpu_load
>   * for the boot processor.
>   */
> -#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x) + __per_cpu_lo=
ad
> +#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x)
>  INIT_PER_CPU(gdt_page);
>  INIT_PER_CPU(fixed_percpu_data);
>  INIT_PER_CPU(irq_stack_backing_store);
>
> -#ifdef CONFIG_SMP
> -. =3D ASSERT((fixed_percpu_data =3D=3D 0),
> -           "fixed_percpu_data is not at start of per-cpu area");
> -#endif
> -
>  #ifdef CONFIG_MITIGATION_UNRET_ENTRY
>  . =3D ASSERT((retbleed_return_thunk & 0x3f) =3D=3D 0, "retbleed_return_t=
hunk not cacheline-aligned");
>  #endif
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
> index b0a9a58952aa..c931e680ef15 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -165,9 +165,8 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>          * the per cpu areas are set up.
>          */
>         movl $MSR_GS_BASE,%ecx
> -       leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> -       movq %edx, %eax
> -       shrq $32, %rdx
> +       xorl %eax, %eax
> +       xorl %edx, %edx

... also here ...

>         wrmsr
>
>         /*
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 7d7fc7f0a250..8b5e2bc3d241 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -834,12 +834,7 @@ static void percpu_init(void)
>   */
>  static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
>  {
> -       int shndx =3D sym_index(sym);
> -
> -       return (shndx =3D=3D per_cpu_shndx) &&
> -               strcmp(symname, "__init_begin") &&
> -               strcmp(symname, "__per_cpu_load") &&
> -               strncmp(symname, "init_per_cpu_", 13);
> +       return 0;
>  }
>
>
> @@ -1055,7 +1050,8 @@ static int cmp_relocs(const void *va, const void *v=
b)
>
>  static void sort_relocs(struct relocs *r)
>  {
> -       qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
> +       if (r->count)
> +               qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relo=
cs);
>  }
>
>  static int write32(uint32_t v, FILE *f)
> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index ae4672ea00bb..1796884b727d 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -51,15 +51,14 @@ SYM_CODE_START(startup_xen)
>
>         leaq    __top_init_kernel_stack(%rip), %rsp
>
> -       /* Set up %gs.
> -        *
> -        * The base of %gs always points to fixed_percpu_data.
> +       /*
> +        * Set up GSBASE.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
>         movl    $MSR_GS_BASE,%ecx
> -       movq    $INIT_PER_CPU_VAR(fixed_percpu_data),%rax
> -       cdq
> +       xorl    %eax, %eax
> +       xorl    %edx, %edx

... and here.

Uros.

>         wrmsr
>
>         mov     %rsi, %rdi
> diff --git a/init/Kconfig b/init/Kconfig
> index c521e1421ad4..b374c0de5cfd 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1849,7 +1849,7 @@ config KALLSYMS_ALL
>  config KALLSYMS_ABSOLUTE_PERCPU
>         bool
>         depends on KALLSYMS
> -       default X86_64 && SMP
> +       default n
>
>  # end of the "standard kernel features (expert users)" menu
>
> --
> 2.47.0
>

