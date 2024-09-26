Return-Path: <linux-kernel+bounces-339884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EE9986BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A851C21E15
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBC8173357;
	Thu, 26 Sep 2024 04:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHKoke40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884316FF26
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727325305; cv=none; b=FICHLRIGXhjnW/t1ULF0ucyhspE8xT5/Ap6QqBPR3q8r70Dli1kyfTsCXZpzdJ/nRZ5PoEFApRFJVG7OfUFQ8/PiD9cePFmSeGYspbKTxG/xT0otOqvV4nPKu1fjAk6VKs3mVquHufQqWx+VLB9XqE9GwGPOafebdymwv1pU2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727325305; c=relaxed/simple;
	bh=wfIMvQ4fYnzhH5AygqXMHaEwwRS1TFaeEGjlApjMzo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqRkR6LTozrAKrL1Ssm0EOO0GM/2ODzaB9GLcoVh1gTG2tayPZmkgl61xvutwQCGZzf9N+cPpj9h8teQ+qelYqgURQzOXROKLbGrtBAdM0K8JtQOryemldC0P2/Em1SdSarlR5MhhSjTX0cCSqNdeGDf1ENOdrAZpyq3lYGmu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHKoke40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2A7C4CECE
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727325304;
	bh=wfIMvQ4fYnzhH5AygqXMHaEwwRS1TFaeEGjlApjMzo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZHKoke40UBDxs0/2VBrBn+nAfAe0hH3yM1BY9Xm04+PbB7Hguo4MjxDMBQT2DZf7K
	 GCREVDNvzEefUMaNrFLz47G6srObooUndlEHetLk5jpeJzyzCywqg4iql2YPFy1i7T
	 RV/eM+0kO4d0NhQS6lyzB3uAO0QAK5y6FU9NpFtHasmZXMHvNWup4PTNaYdFbyr9y6
	 eX1WBRETlEtekWo1lfueeQq14dzHaGD17RsDTRidtxyI25w2G1fZ/u/5qDZlf1Rnf2
	 O8hOhntn+SpTKqiE6K6NjSrsx1vXHc66uJlE9R+yWNXD7EF79D25vH2HkKlgBoTqng
	 KXx02JN3sKX1w==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so546398a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 21:35:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWR5nSE0p5tPRiidUrczrwIMcJudfKZO7ri7bSEwIieOQMknlJTp31TjU9YO+GsMzk9ZPRiSd8IhEHa/LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjAbFU6ekSNCe/TKvmRXcOMZ4/Jih/pAIWn1CkWtDx1lWC/yZb
	o2XFvr/JEH4QO0QUx1yky1zx0zMZ74UyjPvCukIxDZguJpr80S01nOVYeZJrjisWjEWyREQtyU3
	w70BK5f/3mw4NqOYI01FtnPBQv1Y=
X-Google-Smtp-Source: AGHT+IFJqFZ5hxVVQ+qrewZ/Hyj5b46uHkNWoUcVH3QldGJ31Vt5CohlArjDD4sDbq272HTYtMvE2VxeGVq6V0nSuK4=
X-Received: by 2002:a05:6402:500a:b0:5c3:d18e:fc27 with SMTP id
 4fb4d7f45d1cf-5c720750e89mr3176187a12.33.1727325303197; Wed, 25 Sep 2024
 21:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925131547.42396-1-luxu.kernel@bytedance.com> <20240925131547.42396-2-luxu.kernel@bytedance.com>
In-Reply-To: <20240925131547.42396-2-luxu.kernel@bytedance.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 26 Sep 2024 12:34:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTzqcNyeSAxg0uTm0JVXvE0PYuKL5qeivVSUh87FTu95w@mail.gmail.com>
Message-ID: <CAJF2gTTzqcNyeSAxg0uTm0JVXvE0PYuKL5qeivVSUh87FTu95w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] riscv: process: Introduce idle thread using Zawrs extension
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	andy.chiu@sifive.com, christoph.muellner@vrull.eu, ajones@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lihangjing@bytedance.com, dengliang.1214@bytedance.com, 
	xieyongji@bytedance.com, chaiwen.cc@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 9:16=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> The Zawrs extension introduces a new instruction WRS.NTO, which will
> register a reservation set and causes the hart to temporarily stall
> execution in a low-power state until a store occurs to the reservation
> set or an interrupt is observed.
>
> This commit implements new version of idle thread for RISC-V via Zawrs
> extension.
>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> Reviewed-by: Hangjing Li <lihangjing@bytedance.com>
> Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
> Reviewed-by: Wen Chai <chaiwen.cc@bytedance.com>
> ---
>  arch/riscv/Kconfig                 | 10 ++++++++
>  arch/riscv/include/asm/cpuidle.h   | 11 +-------
>  arch/riscv/include/asm/processor.h | 18 +++++++++++++
>  arch/riscv/kernel/cpu.c            |  5 ++++
>  arch/riscv/kernel/process.c        | 41 +++++++++++++++++++++++++++++-
>  5 files changed, 74 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 939ea7f6a228..56cf6000d286 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -23,6 +23,7 @@ config RISCV
>         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>         select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>         select ARCH_HAS_BINFMT_FLAT
> +       select ARCH_HAS_CPU_FINALIZE_INIT
>         select ARCH_HAS_CURRENT_STACK_POINTER
>         select ARCH_HAS_DEBUG_VIRTUAL if MMU
>         select ARCH_HAS_DEBUG_VM_PGTABLE
> @@ -1153,6 +1154,15 @@ endmenu # "Power management options"
>
>  menu "CPU Power Management"
>
> +config RISCV_ZAWRS_IDLE
> +       bool "Idle thread using ZAWRS extensions"
> +       depends on RISCV_ISA_ZAWRS
> +       default y
> +       help
> +               Adds support to implement idle thread using ZAWRS extensi=
on.
> +
> +               If you don't know what to do here, say Y.
> +
>  source "drivers/cpuidle/Kconfig"
>
>  source "drivers/cpufreq/Kconfig"
> diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cp=
uidle.h
> index 71fdc607d4bc..94c9ecb46571 100644
> --- a/arch/riscv/include/asm/cpuidle.h
> +++ b/arch/riscv/include/asm/cpuidle.h
> @@ -10,15 +10,6 @@
>  #include <asm/barrier.h>
>  #include <asm/processor.h>
>
> -static inline void cpu_do_idle(void)
> -{
> -       /*
> -        * Add mb() here to ensure that all
> -        * IO/MEM accesses are completed prior
> -        * to entering WFI.
> -        */
> -       mb();
> -       wait_for_interrupt();
> -}
> +void cpu_do_idle(void);
>
>  #endif
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index efa1b3519b23..d0dcdb7e7392 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -12,6 +12,7 @@
>
>  #include <vdso/processor.h>
>
> +#include <asm/insn-def.h>
>  #include <asm/ptrace.h>
>
>  #define arch_get_mmap_end(addr, len, flags)                    \
> @@ -148,6 +149,21 @@ static inline void wait_for_interrupt(void)
>         __asm__ __volatile__ ("wfi");
>  }
>
> +static inline void wrs_nto(unsigned long *addr)
> +{
> +       int val;
> +
> +       __asm__ __volatile__(
> +#ifdef CONFIG_64BIT
> +                       "lr.d %[p], %[v]\n\t"
> +#else
> +                       "lr.w %[p], %[v]\n\t"
> +#endif
> +                       ZAWRS_WRS_NTO "\n\t"
> +                       : [p] "=3D&r" (val), [v] "+A" (*addr)
> +                       : : "memory");
> +}
> +
>  extern phys_addr_t dma32_phys_limit;
>
>  struct device_node;
> @@ -177,6 +193,8 @@ extern int set_unalign_ctl(struct task_struct *tsk, u=
nsigned int val);
>  #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2) riscv_set_icache_flush_ct=
x(arg1, arg2)
>  extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long p=
er_thread);
>
> +extern void select_idle_routine(void);
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_PROCESSOR_H */
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index f6b13e9f5e6c..97a7144fa6cd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -23,6 +23,11 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
>         return phys_id =3D=3D cpuid_to_hartid_map(cpu);
>  }
>
> +void __init arch_cpu_finalize_init(void)
> +{
> +       select_idle_routine();
> +}
> +
>  /*
>   * Returns the hart ID of the given device tree node, or -ENODEV if the =
node
>   * isn't an enabled and valid RISC-V hart node.
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index e4bc61c4e58a..77769965609e 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -15,6 +15,7 @@
>  #include <linux/tick.h>
>  #include <linux/ptrace.h>
>  #include <linux/uaccess.h>
> +#include <linux/static_call.h>
>
>  #include <asm/unistd.h>
>  #include <asm/processor.h>
> @@ -35,11 +36,49 @@ EXPORT_SYMBOL(__stack_chk_guard);
>
>  extern asmlinkage void ret_from_fork(void);
>
> -void noinstr arch_cpu_idle(void)
> +static __cpuidle void default_idle(void)
> +{
> +       /*
> +        * Add mb() here to ensure that all
> +        * IO/MEM accesses are completed prior
> +        * to entering WFI.
> +        */
> +       mb();
> +       wait_for_interrupt();
> +}
> +
> +static __cpuidle void wrs_idle(void)
> +{
> +       /*
> +        * Add mb() here to ensure that all
> +        * IO/MEM accesses are completed prior
> +        * to entering WRS.NTO.
> +        */
> +       mb();
> +       wrs_nto(&current_thread_info()->flags);
> +}
> +
> +DEFINE_STATIC_CALL_NULL(riscv_idle, default_idle);
> +
> +void __cpuidle cpu_do_idle(void)
> +{
> +       static_call(riscv_idle)();
> +}
> +
> +void __cpuidle arch_cpu_idle(void)
>  {
>         cpu_do_idle();
>  }
>
> +void __init select_idle_routine(void)
> +{
> +       if (IS_ENABLED(CONFIG_RISCV_ZAWRS_IDLE) &&
> +                       riscv_has_extension_likely(RISCV_ISA_EXT_ZAWRS))
> +               static_call_update(riscv_idle, wrs_idle);
> +       else
> +               static_call_update(riscv_idle, default_idle);
The hardware implementations of "WFI & WRS" are different.
- The WFI could enter a more profound power consumption-saving needed
to keep IRQ alive, but the WRS doesn't.
- WRS is designed for cond_load, which needs to keep cache coherency alive.

So, we couldn't simply & statically use an extension check to choose
WRS or WFI for idle.

> +}
> +
>  int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
>  {
>         if (!unaligned_ctl_available())
> --
> 2.20.1
>


--=20
Best Regards
 Guo Ren

