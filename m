Return-Path: <linux-kernel+bounces-400051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FDD9C0847
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0D51F21ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35421263A;
	Thu,  7 Nov 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxNz1z7E"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0329212630
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987997; cv=none; b=HFNrmnYe6d6oCLzE/RROxqylmK0Q2cxrcKgmPkqXQeL0OgTdbG1kF3gflk6WP0qHsDMwG1AYRQSzKQV2DCXoyK3WJ2u2jl6q2dkDBovh5435WFCulW8kUN84pv0dUJwLk8lDqL3VxAkYqrZwEPfcjyYIX5VVYplwYuZ9X+Se/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987997; c=relaxed/simple;
	bh=9gjaCthhBgzUI2kbKN07HoA89+jMw9reh/3FoLDPxEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUE6oMU98p2tyV7KOjpyK9iqOJASUj2uqnVO7P4KhfG9dP+mA0PPTjkLJI546MwwbUJ+bj9gZlX8KAxIZ1EIBRxR6ajxUoyYoX/GD648knZ/f43w2QSfPttlr6ozb41PxsEGBaeDjEgSb5pGLJjDcOcsPurv+HnnCUDX+H6NjOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxNz1z7E; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5743074bso8543991fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730987994; x=1731592794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BARHlqTGe5RbYgWsXP6I2IN6vIGR0CTc5Yeafyscpmk=;
        b=OxNz1z7EbzsdGE72rtVi9c/aONXEktKyJmvKDJMOw8M4LimbyprrHqzcsRZHzzS/6R
         DECZPqDRRr9BBwEIMYN9rbRmyy/3EETU8OwBZTmDbXWRprjiTNnBRsukMPDbQnir8Gzm
         F4MTRijQ7HqjMwo8zEGbShSUpbPijVVJVw1uybdyQLz9A4MU4NQnCgHAdf6aZFIU/syf
         tYc3GwVHnz+2p8pw4mmZrEQejC+ykpOwh9odg1Sk3gd3txab68CyBQSIkH9T6cvHzASD
         hkb5iy9KDqRxSx0n2g1aEWyWLtgFvLMH7tAXbyfho1YL9aH3ojR+Pe28ZEXH2fAsN/fD
         UWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987994; x=1731592794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BARHlqTGe5RbYgWsXP6I2IN6vIGR0CTc5Yeafyscpmk=;
        b=WFUeexxYM3vFSLmQqsn+EiwfNipsc/TVdWwcfmM9UZD8Q7sYkWnjbYvyuSP518ZFUr
         OFr1K2oDvj59pjsf0OKA6SIvfShH5Pxc5R3GKcMxbOD3hXT0gH1dTrOO+CbdGL7l3NCI
         bfEl3v7Nj6LLG2JwuY+v1zXy8dFALiblXzL6idrlJFbiBbuBHYFdBetoTAmD4wzbM5h5
         6Qfu5IbBhXNDKiSmi6wyUpksYEvO8V3sMXf0NYmQWOddoYGJut0AOReJLlDesjdxtRbH
         ZQx//s3uuruWsrtCQgCQ9eAaa4SA4bHSTCiCyYqCxhmR3ooCiOqp2J/VsghiR22KTj+Y
         GmwA==
X-Gm-Message-State: AOJu0YxSaVW9bIfZisRm1pO/3kcL+1qpLCws5dmIOwlJuYGFOKHP9zvO
	P3k1jX0vSfUzj0l81JYkWgkIQBzl7rVbudQwamF+m0fa+ObSXVdYTBAEZOzJAD1erMaA2Ihc7Lv
	3nHmLCb8Zhsiu896DjTM0GOciST8=
X-Google-Smtp-Source: AGHT+IFx0ueCTDe8dUKa/hme2a26Q3u0daEEGh/AtEUzp+RNfjSJ7j7WRUWECf6KHEPxNq0K0rB3c4d5C3k3hClheJE=
X-Received: by 2002:a05:651c:892:b0:2fb:3881:35be with SMTP id
 38308e7fff4ca-2ff1e900599mr256491fa.9.1730987993767; Thu, 07 Nov 2024
 05:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105155801.1779119-1-brgerst@gmail.com> <20241105155801.1779119-13-brgerst@gmail.com>
In-Reply-To: <20241105155801.1779119-13-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 7 Nov 2024 14:59:42 +0100
Message-ID: <CAFULd4YwuJ_xrxHw-x2qw8qrQpYub6bmLwt09gQ4jkUa-n-HSg@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] x86/percpu/64: Remove INIT_PER_CPU macros
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:58=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wrot=
e:
>
> Now that the load and link addresses of percpu variables are the same,
> these macros are no longer necessary.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

Reviewed-by: Uros Bizjak <ubizjak@gmail.com>

> ---
>  arch/x86/include/asm/desc.h   |  1 -
>  arch/x86/include/asm/percpu.h | 22 ----------------------
>  arch/x86/kernel/head64.c      |  2 +-
>  arch/x86/kernel/irq_64.c      |  1 -
>  arch/x86/kernel/vmlinux.lds.S |  7 -------
>  arch/x86/tools/relocs.c       |  1 -
>  6 files changed, 1 insertion(+), 33 deletions(-)
>
> diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
> index 62dc9f59ea76..ec95fe44fa3a 100644
> --- a/arch/x86/include/asm/desc.h
> +++ b/arch/x86/include/asm/desc.h
> @@ -46,7 +46,6 @@ struct gdt_page {
>  } __attribute__((aligned(PAGE_SIZE)));
>
>  DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
> -DECLARE_INIT_PER_CPU(gdt_page);
>
>  /* Provide the original GDT */
>  static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.=
h
> index c55a79d5feae..1ded1207528d 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -20,12 +20,6 @@
>
>  #define PER_CPU_VAR(var)       __percpu(var)__percpu_rel
>
> -#ifdef CONFIG_X86_64_SMP
> -# define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
> -#else
> -# define INIT_PER_CPU_VAR(var)  var
> -#endif
> -
>  #else /* !__ASSEMBLY__: */
>
>  #include <linux/build_bug.h>
> @@ -97,22 +91,6 @@
>  #define __percpu_arg(x)                __percpu_prefix "%" #x
>  #define __force_percpu_arg(x)  __force_percpu_prefix "%" #x
>
> -/*
> - * Initialized pointers to per-CPU variables needed for the boot
> - * processor need to use these macros to get the proper address
> - * offset from __per_cpu_load on SMP.
> - *
> - * There also must be an entry in vmlinux_64.lds.S
> - */
> -#define DECLARE_INIT_PER_CPU(var) \
> -       extern typeof(var) init_per_cpu_var(var)
> -
> -#ifdef CONFIG_X86_64_SMP
> -# define init_per_cpu_var(var)  init_per_cpu__##var
> -#else
> -# define init_per_cpu_var(var)  var
> -#endif
> -
>  /*
>   * For arch-specific code, we can use direct single-insn ops (they
>   * don't give an lvalue though).
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 4b9d4557fc94..d4398261ad81 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -559,7 +559,7 @@ void early_setup_idt(void)
>   */
>  void __head startup_64_setup_gdt_idt(void)
>  {
> -       struct desc_struct *gdt =3D (void *)(__force unsigned long)init_p=
er_cpu_var(gdt_page.gdt);
> +       struct desc_struct *gdt =3D (void *)(__force unsigned long)gdt_pa=
ge.gdt;
>         void *handler =3D NULL;
>
>         struct desc_ptr startup_gdt_descr =3D {
> diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
> index ade0043ce56e..56bdeecd8ee0 100644
> --- a/arch/x86/kernel/irq_64.c
> +++ b/arch/x86/kernel/irq_64.c
> @@ -27,7 +27,6 @@
>  #include <asm/apic.h>
>
>  DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) _=
_visible;
> -DECLARE_INIT_PER_CPU(irq_stack_backing_store);
>
>  #ifdef CONFIG_VMAP_STACK
>  /*
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index 859ff7c0dc02..fd1ecb1dbc1d 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -450,13 +450,6 @@ SECTIONS
>  PROVIDE(__ref_stack_chk_guard =3D __stack_chk_guard);
>
>  #ifdef CONFIG_X86_64
> -/*
> - * Per-cpu symbols which need to be offset from __per_cpu_load
> - * for the boot processor.
> - */
> -#define INIT_PER_CPU(x) init_per_cpu__##x =3D ABSOLUTE(x)
> -INIT_PER_CPU(gdt_page);
> -INIT_PER_CPU(irq_stack_backing_store);
>
>  #ifdef CONFIG_MITIGATION_UNRET_ENTRY
>  . =3D ASSERT((retbleed_return_thunk & 0x3f) =3D=3D 0, "retbleed_return_t=
hunk not cacheline-aligned");
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 8d9e82748615..c3124aac7ab3 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -89,7 +89,6 @@ static const char * const     sym_regex_kernel[S_NSYMTY=
PES] =3D {
>         "__initramfs_start|"
>         "(jiffies|jiffies_64)|"
>  #if ELF_BITS =3D=3D 64
> -       "init_per_cpu__.*|"
>         "__end_rodata_hpage_align|"
>  #endif
>         "_end)$"
> --
> 2.47.0
>

