Return-Path: <linux-kernel+bounces-399989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0191B9C076C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A0A1C21FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DA1213134;
	Thu,  7 Nov 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCDoZplk"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637822101A3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986157; cv=none; b=djTTU3Ztd+BUIhTqRN4S9ocrDVpb38jyueTMKEiQRWga34Rw7DYJKNSN/IuwqohLSDGyUvvf58G/+kbtXDqZuEylqwX54+j+T0KdodRVhgnrjt9RlmibaSiBXjw20oWs2lPmm5ntFv14/j/Ds+jx6WweIyTuq80QmAJZaOghh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986157; c=relaxed/simple;
	bh=frEeIr4QQ/jyIhArzcDptSMU5d1IAQTmI1LA8NqPNfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OF7rItY9dx+eXe1S+058ihTnsgmnoiXccF+JYO9hBYR+/6uH+n3nTJXkgsVk4TACQxn0VRftfyYkJPBIGMvZpXbZJImnDldjZxCe2rPRLf/vR9bcEGv3ZibBZBPBLydN03ZO+buM3qRLg1h1jnjRakQr3YwzaeYAyxzRR9NgWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCDoZplk; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so8637321fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986152; x=1731590952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtAcGandP8XNzuySDSf/9mTlVqlPK+EK5o+fCAx97e4=;
        b=BCDoZplkvEIKncAP1l33TOQXf+bR74eVLvii7BsuGhIsHYFqj5E4W1mpxEV++M3qAQ
         SdrK9sf4JC46tHlGGsjmwIZjiykaZv+SWeQXdo7oPxVDNrJkAXYbmErncuMioARsXGsW
         kW3Xpvilfb7/uugjmUPHhbQ2uR+1H2bmX1hToRDx99INPKSH1sQQp0rFu50XIEQDXyDK
         FvJU8dUokiyk8GovH86NV02cI8CqvFDHsgI57M7Fq3aU2KGQfzS+2IfZ7r+DsmVX6KcU
         rcfptnqqJS/iJv3n5899Is8yjDF7OQWb2fZweRrvhVbCvof1arX0hxTEmMhjdex+wvte
         0TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986152; x=1731590952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtAcGandP8XNzuySDSf/9mTlVqlPK+EK5o+fCAx97e4=;
        b=TftG7R4e58k7ZLd9k3OTvB447y3ysEN3uwlXYOCO6huFKlm24NtKalsuaC2mnIDV0F
         MWbGcpLQpCGvF9WvatPc0iSpqyUVl1psSRyKecE/TMcs8aPNvMAyFn0kRNYyyUxBrNGz
         /cbPXhaDItmHkRiEHw162qvna/TeCBsBL2D2A/GCmxeGgjZOczLxwkM6CBY0oOhicJUO
         d4BVUlavccx8f0uWo5bSjMk71N30adUz+TiK+a8ZjCSzLfmmAln4XEXkixWH45Q2mTAK
         PYlb/DzEQ4Y9cvE4ZCeFwz1lIAVbYDc6PZw6aguZOvHOdpmzU/EuEhPZOWiCPxzUvBhA
         SLtQ==
X-Gm-Message-State: AOJu0YyGEco/+G/ad0R30ZAw7mDAoEhZd1HksCjlo6n0FLc1GtUHz1eq
	ovGMAUrw9Wb8RmrY41C7o3dPT6yrNJPJzsu6E4VfFwyBDYEhOWsc7cLMzvdVbRJT60r7pD2q47N
	T8g7VDIbJim39jIvMx0UEBO4b7Ec=
X-Google-Smtp-Source: AGHT+IG/42uI61XcqREStgvabn2WRz+IM7l0nkZVD7yfdQeZlcOMkJbmSv4FQVeNcc7ET06cqI0iAd3xYKXIX9EchdE=
X-Received: by 2002:a2e:bc19:0:b0:2f7:58bc:f497 with SMTP id
 38308e7fff4ca-2ff1a9e117amr9593591fa.28.1730986152094; Thu, 07 Nov 2024
 05:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-9-brgerst@gmail.com>
In-Reply-To: <20241105155801.1779119-9-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 14:29:00 +0100
Message-ID: <CAFULd4Yc6JSH3BBCQ=Hr8Noxrc5HTw4FNxQk2jd5BRrRiU3Cow@mail.gmail.com>
Subject: Re: [PATCH v5 08/16] x86/stackprotector/64: Convert to normal percpu variable
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> Older versions of GCC fixed the location of the stack protector canary
> at %gs:40.  This constraint forced the percpu section to be linked at
> absolute address 0 so that the canary could be the first data object in
> the percpu section.  Supporting the zero-based percpu section requires
> additional code to handle relocations for RIP-relative references to
> percpu data, extra complexity to kallsyms, and workarounds for linker
> bugs due to the use of absolute symbols.
>
> GCC 8.1 supports redefining where the canary is located, allowng it to
> become a normal percpu variable instead of at a fixed location.  This
> removes the contraint that the percpu section must be zero-based.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/Makefile                     | 20 +++++++++------
>  arch/x86/entry/entry.S                |  2 --
>  arch/x86/entry/entry_64.S             |  2 +-
>  arch/x86/include/asm/processor.h      | 16 ++----------
>  arch/x86/include/asm/stackprotector.h | 36 ++++-----------------------
>  arch/x86/kernel/asm-offsets_64.c      |  6 -----
>  arch/x86/kernel/cpu/common.c          |  5 +---
>  arch/x86/kernel/head_64.S             |  3 +--
>  arch/x86/xen/xen-head.S               |  3 +--
>  9 files changed, 23 insertions(+), 70 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 5b773b34768d..88a1705366f9 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -140,14 +140,7 @@ ifeq ($(CONFIG_X86_32),y)
>          # temporary until string.h is fixed
>          KBUILD_CFLAGS +=3D -ffreestanding
>
> -    ifeq ($(CONFIG_STACKPROTECTOR),y)
> -        ifeq ($(CONFIG_SMP),y)
> -            KBUILD_CFLAGS +=3D -mstack-protector-guard-reg=3Dfs \
> -                             -mstack-protector-guard-symbol=3D__ref_stac=
k_chk_guard
> -        else
> -            KBUILD_CFLAGS +=3D -mstack-protector-guard=3Dglobal
> -        endif
> -    endif
> +        percpu_seg :=3D fs
>  else
>          BITS :=3D 64
>          UTS_MACHINE :=3D x86_64
> @@ -197,6 +190,17 @@ else
>          KBUILD_CFLAGS +=3D -mcmodel=3Dkernel
>          KBUILD_RUSTFLAGS +=3D -Cno-redzone=3Dy
>          KBUILD_RUSTFLAGS +=3D -Ccode-model=3Dkernel
> +
> +        percpu_seg :=3D gs
> +endif
> +
> +ifeq ($(CONFIG_STACKPROTECTOR),y)
> +    ifeq ($(CONFIG_SMP),y)
> +       KBUILD_CFLAGS +=3D -mstack-protector-guard-reg=3D$(percpu_seg)
> +       KBUILD_CFLAGS +=3D -mstack-protector-guard-symbol=3D__ref_stack_c=
hk_guard
> +    else
> +       KBUILD_CFLAGS +=3D -mstack-protector-guard=3Dglobal
> +    endif
>  endif
>
>  #
> diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
> index b7ea3e8e9ecc..fe5344a249a1 100644
> --- a/arch/x86/entry/entry.S
> +++ b/arch/x86/entry/entry.S
> @@ -52,7 +52,6 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
>
>  THUNK warn_thunk_thunk, __warn_thunk
>
> -#ifndef CONFIG_X86_64
>  /*
>   * Clang's implementation of TLS stack cookies requires the variable in
>   * question to be a TLS variable. If the variable happens to be defined =
as an
> @@ -66,4 +65,3 @@ THUNK warn_thunk_thunk, __warn_thunk
>  #ifdef CONFIG_STACKPROTECTOR
>  EXPORT_SYMBOL(__ref_stack_chk_guard);
>  #endif
> -#endif
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 1b5be07f8669..f78ef9667c39 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -192,7 +192,7 @@ SYM_FUNC_START(__switch_to_asm)
>
>  #ifdef CONFIG_STACKPROTECTOR
>         movq    TASK_stack_canary(%rsi), %rbx
> -       movq    %rbx, PER_CPU_VAR(fixed_percpu_data + FIXED_stack_canary)
> +       movq    %rbx, PER_CPU_VAR(__stack_chk_guard)
>  #endif
>
>         /*
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index c0975815980c..a113c3f4f558 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -419,16 +419,8 @@ struct irq_stack {
>
>  #ifdef CONFIG_X86_64
>  struct fixed_percpu_data {
> -       /*
> -        * GCC hardcodes the stack canary as %gs:40.  Since the
> -        * irq_stack is the object at %gs:0, we reserve the bottom
> -        * 48 bytes of the irq stack for the canary.
> -        *
> -        * Once we are willing to require -mstack-protector-guard-symbol=
=3D
> -        * support for x86_64 stackprotector, we can get rid of this.
> -        */
>         char            gs_base[40];
> -       unsigned long   stack_canary;
> +       unsigned long   reserved;
>  };
>
>  DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __vis=
ible;
> @@ -443,11 +435,7 @@ extern asmlinkage void entry_SYSCALL32_ignore(void);
>
>  /* Save actual FS/GS selectors and bases to current->thread */
>  void current_save_fsgs(void);
> -#else  /* X86_64 */
> -#ifdef CONFIG_STACKPROTECTOR
> -DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
> -#endif
> -#endif /* !X86_64 */
> +#endif /* X86_64 */
>
>  struct perf_event;
>
> diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm=
/stackprotector.h
> index 00473a650f51..d43fb589fcf6 100644
> --- a/arch/x86/include/asm/stackprotector.h
> +++ b/arch/x86/include/asm/stackprotector.h
> @@ -2,26 +2,10 @@
>  /*
>   * GCC stack protector support.
>   *
> - * Stack protector works by putting predefined pattern at the start of
> + * Stack protector works by putting a predefined pattern at the start of
>   * the stack frame and verifying that it hasn't been overwritten when
> - * returning from the function.  The pattern is called stack canary
> - * and unfortunately gcc historically required it to be at a fixed offse=
t
> - * from the percpu segment base.  On x86_64, the offset is 40 bytes.
> - *
> - * The same segment is shared by percpu area and stack canary.  On
> - * x86_64, percpu symbols are zero based and %gs (64-bit) points to the
> - * base of percpu area.  The first occupant of the percpu area is always
> - * fixed_percpu_data which contains stack_canary at the appropriate
> - * offset.  On x86_32, the stack canary is just a regular percpu
> - * variable.
> - *
> - * Putting percpu data in %fs on 32-bit is a minor optimization compared=
 to
> - * using %gs.  Since 32-bit userspace normally has %fs =3D=3D 0, we are =
likely
> - * to load 0 into %fs on exit to usermode, whereas with percpu data in
> - * %gs, we are likely to load a non-null %gs on return to user mode.
> - *
> - * Once we are willing to require GCC 8.1 or better for 64-bit stackprot=
ector
> - * support, we can remove some of this complexity.
> + * returning from the function.  The pattern is called the stack canary
> + * and is a unique value for each task.
>   */
>
>  #ifndef _ASM_STACKPROTECTOR_H
> @@ -36,6 +20,8 @@
>
>  #include <linux/sched.h>
>
> +DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
> +
>  /*
>   * Initialize the stackprotector canary value.
>   *
> @@ -51,25 +37,13 @@ static __always_inline void boot_init_stack_canary(vo=
id)
>  {
>         unsigned long canary =3D get_random_canary();
>
> -#ifdef CONFIG_X86_64
> -       BUILD_BUG_ON(offsetof(struct fixed_percpu_data, stack_canary) !=
=3D 40);
> -#endif
> -
>         current->stack_canary =3D canary;
> -#ifdef CONFIG_X86_64
> -       this_cpu_write(fixed_percpu_data.stack_canary, canary);
> -#else
>         this_cpu_write(__stack_chk_guard, canary);
> -#endif
>  }
>
>  static inline void cpu_init_stack_canary(int cpu, struct task_struct *id=
le)
>  {
> -#ifdef CONFIG_X86_64
> -       per_cpu(fixed_percpu_data.stack_canary, cpu) =3D idle->stack_cana=
ry;
> -#else
>         per_cpu(__stack_chk_guard, cpu) =3D idle->stack_canary;
> -#endif
>  }
>
>  #else  /* STACKPROTECTOR */
> diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offse=
ts_64.c
> index bb65371ea9df..590b6cd0eac0 100644
> --- a/arch/x86/kernel/asm-offsets_64.c
> +++ b/arch/x86/kernel/asm-offsets_64.c
> @@ -54,11 +54,5 @@ int main(void)
>         BLANK();
>  #undef ENTRY
>
> -       BLANK();
> -
> -#ifdef CONFIG_STACKPROTECTOR
> -       OFFSET(FIXED_stack_canary, fixed_percpu_data, stack_canary);
> -       BLANK();
> -#endif
>         return 0;
>  }
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 9d42bd15e06c..1f33d5feb050 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2086,8 +2086,7 @@ void syscall_init(void)
>         if (!cpu_feature_enabled(X86_FEATURE_FRED))
>                 idt_syscall_init();
>  }
> -
> -#else  /* CONFIG_X86_64 */
> +#endif /* CONFIG_X86_64 */
>
>  #ifdef CONFIG_STACKPROTECTOR
>  DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
> @@ -2096,8 +2095,6 @@ EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
>  #endif
>  #endif
>
> -#endif /* CONFIG_X86_64 */
> -
>  /*
>   * Clear all 6 debug registers:
>   */
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 56163e2124cf..c3028b4df85f 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -355,8 +355,7 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
>
>         /* Set up %gs.
>          *
> -        * The base of %gs always points to fixed_percpu_data. If the
> -        * stack protector canary is enabled, it is located at %gs:40.
> +        * The base of %gs always points to fixed_percpu_data.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index 758bcd47b72d..ae4672ea00bb 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -53,8 +53,7 @@ SYM_CODE_START(startup_xen)
>
>         /* Set up %gs.
>          *
> -        * The base of %gs always points to fixed_percpu_data.  If the
> -        * stack protector canary is enabled, it is located at %gs:40.
> +        * The base of %gs always points to fixed_percpu_data.
>          * Note that, on SMP, the boot cpu uses init data section until
>          * the per cpu areas are set up.
>          */
> --
> 2.47.0
>

