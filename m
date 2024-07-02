Return-Path: <linux-kernel+bounces-237783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C285923E0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DD81F23647
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3DE16B394;
	Tue,  2 Jul 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MYHpS2Hn"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4167E15B133
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924028; cv=none; b=lYNM6IDD/67lG0K+WS0nS0c48XQVWgoDVH0zjRBe272LzHTYtMQDhc29IL/BJifuJb3ewBxPmSTS5BzWTGbCLVa59p5fcrviuTt7SlFhpUbcce2OTTEHKyTkDpj0WgIuXYlGLCF9TTSvbcbG/O6AHX9CmftrDgNC6hehAFXpYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924028; c=relaxed/simple;
	bh=jfHELmxttAmwCwJwXwpeGRSMOYMHavMyjKZGSbp1adk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bh/cq/AhPIlCoEjluM/bmftoLnexDy3z/P5ZpYMaYdMVvyjviTUaJCXPzjEhqA8AJm/XIxkaN1n9NPt6Gmy6ppMA94PXitPiFHPh16oiaAlCPrSdI2Eo9oLi47FMYRnuxFpOz0Bf+FlobP6doq/axEbV27d7E4ezuGwvFxzyKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MYHpS2Hn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7194ce90afso487979266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719924024; x=1720528824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BF3ELPfBNC8DNMfjAp3MRSOzj/4A/rAnRdasV9MTFF8=;
        b=MYHpS2Hnv8sCsAvrh+WdJBLakpL3zDY35pXs5W8Q1nyPYhd/GWE52JpWW2qEw73bPB
         u7J2nNQA2SDAwqfkmvgxWxnJv44ZJWFiII4Rtbhpyp4pXTtBjD86+xf19+wUm05AkXx0
         qxLndMIzBK4sO9RprhfbqoGVlXuPFryJIBmO1zYB6mjWcgveWpKbHAzy/PE80aUz/j2F
         oY9MkV0gUEBeen6XPvUolA+hpkgS553dkv2E3bHcxgagx1hn52kUmlsxcHmi/BBjYx9e
         z3EXo6ix9A1NDs5lEG9f0qqLXSX4h9zqXzVGEOnCIcusDrIUgII6x43uOPSymsEHAN90
         xo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719924024; x=1720528824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BF3ELPfBNC8DNMfjAp3MRSOzj/4A/rAnRdasV9MTFF8=;
        b=gPBdRo4nPwmjVQ79//C1EInh4p0WDQv3O4hIMqdnk0kqiCyJAeUNqMRnSf5WZs8HYl
         cAG9BV3gpx5cOPg/bDslvh0n24gs/j9cM1jO101MX85RpezI2DaGNXi+TqRfuOKhyRyF
         fRBVQQLpquAkz3s0wa6y+fTBDmNCNZ+4quDRSoKZYEEjty9gdJbN+eOYVgoZTTVdtrYG
         Rp3S+Xw8FUEfeXuaFX9Zl57aSfasSofhqhl3H6v1MHX0hl9LMaPZRsocdTNs94rFyG5H
         cWuV3vMt9iJrle9YkWXrF8ctWlwWN/pelAdYni76LkVDxadyr4j+qQhcr6QcOg66MgId
         1xeg==
X-Forwarded-Encrypted: i=1; AJvYcCW8mYqoOavIOJT2Ckhc0wtJ1hEeUQkG2ZtLd9WnZNSMTtb5BQI91csl7q9OnoWBzq0Hikd5p/Y/786rWnRUC1N/0hv4+GXBD2bGp4nR
X-Gm-Message-State: AOJu0YwkL1R6vg46saamaZQWMB0s5FERbw8c3UF0/DHCN74oJc9uG7b+
	5qKypqZqJ6UHM0mdj8hpFWf8nMHEuAgcL22hERpGE6tTgdG5YTt02WbC19eqzX4h4Y/lqS/zlis
	Obq2xcI6JgoDMAP9ImxtmqTbGILP4C6+b6J+Cqw==
X-Google-Smtp-Source: AGHT+IFnmTCeoEZyMoWiAiHh9hYs3VD8AG3SNmIPvw8PmFvmBhLgN6J2SERNFbqQvm0XiH88GWZy+TLC6c5bOEWAixQ=
X-Received: by 2002:a17:907:84c:b0:a75:3c1d:f9c9 with SMTP id
 a640c23a62f3a-a753c1dfad2mr220975466b.28.1719924023482; Tue, 02 Jul 2024
 05:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702085034.48395-1-alexghiti@rivosinc.com>
 <20240702085034.48395-4-alexghiti@rivosinc.com> <CAAhSdy3_N7nubTwaR15WNeiysDDQ5BkB5qCq-6Fh2ZwDbV-6qw@mail.gmail.com>
In-Reply-To: <CAAhSdy3_N7nubTwaR15WNeiysDDQ5BkB5qCq-6Fh2ZwDbV-6qw@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 2 Jul 2024 14:40:06 +0200
Message-ID: <CAHVXubia1ArW1F4U=HmqmrXaCYj1Mad0K=DuH8rPcCEoJoUDRA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] riscv: Stop emitting preventive sfence.vma for new
 vmalloc mappings
To: Anup Patel <anup@brainfault.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Ved Shanbhogue <ved@rivosinc.com>, Matt Evans <mev@rivosinc.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup,

On Tue, Jul 2, 2024 at 12:13=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Tue, Jul 2, 2024 at 2:24=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
> >
> > In 6.5, we removed the vmalloc fault path because that can't work (see
> > [1] [2]). Then in order to make sure that new page table entries were
> > seen by the page table walker, we had to preventively emit a sfence.vma
> > on all harts [3] but this solution is very costly since it relies on IP=
I.
> >
> > And even there, we could end up in a loop of vmalloc faults if a vmallo=
c
> > allocation is done in the IPI path (for example if it is traced, see
> > [4]), which could result in a kernel stack overflow.
> >
> > Those preventive sfence.vma needed to be emitted because:
> >
> > - if the uarch caches invalid entries, the new mapping may not be
> >   observed by the page table walker and an invalidation may be needed.
> > - if the uarch does not cache invalid entries, a reordered access
> >   could "miss" the new mapping and traps: in that case, we would actual=
ly
> >   only need to retry the access, no sfence.vma is required.
> >
> > So this patch removes those preventive sfence.vma and actually handles
> > the possible (and unlikely) exceptions. And since the kernel stacks
> > mappings lie in the vmalloc area, this handling must be done very early
> > when the trap is taken, at the very beginning of handle_exception: this
> > also rules out the vmalloc allocations in the fault path.
> >
> > Link: https://lore.kernel.org/linux-riscv/20230531093817.665799-1-bjorn=
@kernel.org/ [1]
> > Link: https://lore.kernel.org/linux-riscv/20230801090927.2018653-1-dyla=
n@andestech.com [2]
> > Link: https://lore.kernel.org/linux-riscv/20230725132246.817726-1-alexg=
hiti@rivosinc.com/ [3]
> > Link: https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.o=
rg/ [4]
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/cacheflush.h  | 18 +++++-
> >  arch/riscv/include/asm/thread_info.h |  5 ++
> >  arch/riscv/kernel/asm-offsets.c      |  5 ++
> >  arch/riscv/kernel/entry.S            | 84 ++++++++++++++++++++++++++++
> >  arch/riscv/mm/init.c                 |  2 +
> >  5 files changed, 113 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/a=
sm/cacheflush.h
> > index ce79c558a4c8..8de73f91bfa3 100644
> > --- a/arch/riscv/include/asm/cacheflush.h
> > +++ b/arch/riscv/include/asm/cacheflush.h
> > @@ -46,7 +46,23 @@ do {                                                =
 \
> >  } while (0)
> >
> >  #ifdef CONFIG_64BIT
> > -#define flush_cache_vmap(start, end)           flush_tlb_kernel_range(=
start, end)
> > +extern u64 new_vmalloc[NR_CPUS / sizeof(u64) + 1];
>
> Why is this u64 and not "unsigned long" ?

I prefer the explicit types but I'm not opposed to using unsigned long
if you think so.

>
> Was this tested on rv32 ?

It is not intended to work on rv32 as rv32 still uses the vmalloc
fault path. But then new_vmalloc_check should only be called for rv64,
so I'll fix that in the next version, thanks for asking.

>
> > +extern char _end[];
> > +#define flush_cache_vmap flush_cache_vmap
> > +static inline void flush_cache_vmap(unsigned long start, unsigned long=
 end)
> > +{
> > +       if (is_vmalloc_or_module_addr((void *)start)) {
> > +               int i;
> > +
> > +               /*
> > +                * We don't care if concurrently a cpu resets this valu=
e since
> > +                * the only place this can happen is in handle_exceptio=
n() where
> > +                * an sfence.vma is emitted.
> > +                */
> > +               for (i =3D 0; i < ARRAY_SIZE(new_vmalloc); ++i)
> > +                       new_vmalloc[i] =3D -1ULL;
> > +       }
> > +}
> >  #define flush_cache_vmap_early(start, end)     local_flush_tlb_kernel_=
range(start, end)
> >  #endif
> >
> > diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/=
asm/thread_info.h
> > index 5d473343634b..32631acdcdd4 100644
> > --- a/arch/riscv/include/asm/thread_info.h
> > +++ b/arch/riscv/include/asm/thread_info.h
> > @@ -60,6 +60,11 @@ struct thread_info {
> >         void                    *scs_base;
> >         void                    *scs_sp;
> >  #endif
> > +       /*
> > +        * Used in handle_exception() to save a0, a1 and a2 before know=
ing if we
> > +        * can access the kernel stack.
> > +        */
> > +       unsigned long           a0, a1, a2;
> >  };
> >
> >  #ifdef CONFIG_SHADOW_CALL_STACK
> > diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-of=
fsets.c
> > index b09ca5f944f7..29c0734f2972 100644
> > --- a/arch/riscv/kernel/asm-offsets.c
> > +++ b/arch/riscv/kernel/asm-offsets.c
> > @@ -36,6 +36,8 @@ void asm_offsets(void)
> >         OFFSET(TASK_THREAD_S9, task_struct, thread.s[9]);
> >         OFFSET(TASK_THREAD_S10, task_struct, thread.s[10]);
> >         OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
> > +
> > +       OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
> >         OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
> >         OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_=
count);
> >         OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
> > @@ -43,6 +45,9 @@ void asm_offsets(void)
> >  #ifdef CONFIG_SHADOW_CALL_STACK
> >         OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
> >  #endif
> > +       OFFSET(TASK_TI_A0, task_struct, thread_info.a0);
> > +       OFFSET(TASK_TI_A1, task_struct, thread_info.a1);
> > +       OFFSET(TASK_TI_A2, task_struct, thread_info.a2);
> >
> >         OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
> >         OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 68a24cf9481a..822311266a12 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -19,6 +19,78 @@
> >
> >         .section .irqentry.text, "ax"
> >
> > +.macro new_vmalloc_check
> > +       REG_S   a0, TASK_TI_A0(tp)
> > +       REG_S   a1, TASK_TI_A1(tp)
> > +       REG_S   a2, TASK_TI_A2(tp)
> > +
> > +       csrr    a0, CSR_CAUSE
> > +       /* Exclude IRQs */
> > +       blt     a0, zero, _new_vmalloc_restore_context
> > +       /* Only check new_vmalloc if we are in page/protection fault */
> > +       li      a1, EXC_LOAD_PAGE_FAULT
> > +       beq     a0, a1, _new_vmalloc_kernel_address
> > +       li      a1, EXC_STORE_PAGE_FAULT
> > +       beq     a0, a1, _new_vmalloc_kernel_address
> > +       li      a1, EXC_INST_PAGE_FAULT
> > +       bne     a0, a1, _new_vmalloc_restore_context
> > +
> > +_new_vmalloc_kernel_address:
> > +       /* Is it a kernel address? */
> > +       csrr    a0, CSR_TVAL
> > +       bge     a0, zero, _new_vmalloc_restore_context
> > +
> > +       /* Check if a new vmalloc mapping appeared that could explain t=
he trap */
> > +
> > +       /*
> > +        * Computes:
> > +        * a0 =3D &new_vmalloc[BIT_WORD(cpu)]
> > +        * a1 =3D BIT_MASK(cpu)
> > +        */
> > +       REG_L   a2, TASK_TI_CPU(tp)
> > +       /*
> > +        * Compute the new_vmalloc element position:
> > +        * (cpu / 64) * 8 =3D (cpu >> 6) << 3
> > +        */
> > +       srli    a1, a2, 6
> > +       slli    a1, a1, 3
> > +       la      a0, new_vmalloc
> > +       add     a0, a0, a1
> > +       /*
> > +        * Compute the bit position in the new_vmalloc element:
> > +        * bit_pos =3D cpu % 64 =3D cpu - (cpu / 64) * 64 =3D cpu - (cp=
u >> 6) << 6
> > +        *         =3D cpu - ((cpu >> 6) << 3) << 3
> > +        */
> > +       slli    a1, a1, 3
> > +       sub     a1, a2, a1
> > +       /* Compute the "get mask": 1 << bit_pos */
> > +       li      a2, 1
> > +       sll     a1, a2, a1
> > +
> > +       /* Check the value of new_vmalloc for this cpu */
> > +       REG_L   a2, 0(a0)
> > +       and     a2, a2, a1
> > +       beq     a2, zero, _new_vmalloc_restore_context
> > +
> > +       /* Atomically reset the current cpu bit in new_vmalloc */
> > +       amoxor.w        a0, a1, (a0)
>
> Doing only 32bit atomic here, is this intentional ?

Oh my, that's a big mistake. Thanks

>
> > +
> > +       /* Only emit a sfence.vma if the uarch caches invalid entries *=
/
> > +       ALTERNATIVE("sfence.vma", "nop", 0, RISCV_ISA_EXT_SVVPTC, 1)
> > +
> > +       REG_L   a0, TASK_TI_A0(tp)
> > +       REG_L   a1, TASK_TI_A1(tp)
> > +       REG_L   a2, TASK_TI_A2(tp)
> > +       csrw    CSR_SCRATCH, x0
> > +       sret
> > +
> > +_new_vmalloc_restore_context:
> > +       REG_L   a0, TASK_TI_A0(tp)
> > +       REG_L   a1, TASK_TI_A1(tp)
> > +       REG_L   a2, TASK_TI_A2(tp)
> > +.endm
> > +
> > +
> >  SYM_CODE_START(handle_exception)
> >         /*
> >          * If coming from userspace, preserve the user thread pointer a=
nd load
> > @@ -30,6 +102,18 @@ SYM_CODE_START(handle_exception)
> >
> >  .Lrestore_kernel_tpsp:
> >         csrr tp, CSR_SCRATCH
> > +
> > +       /*
> > +        * The RISC-V kernel does not eagerly emit a sfence.vma after e=
ach
> > +        * new vmalloc mapping, which may result in exceptions:
> > +        * - if the uarch caches invalid entries, the new mapping would=
 not be
> > +        *   observed by the page table walker and an invalidation is n=
eeded.
> > +        * - if the uarch does not cache invalid entries, a reordered a=
ccess
> > +        *   could "miss" the new mapping and traps: in that case, we o=
nly need
> > +        *   to retry the access, no sfence.vma is required.
> > +        */
> > +       new_vmalloc_check
> > +
> >         REG_S sp, TASK_TI_KERNEL_SP(tp)
> >
> >  #ifdef CONFIG_VMAP_STACK
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index e3405e4b99af..2367a156c33b 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -36,6 +36,8 @@
> >
> >  #include "../kernel/head.h"
> >
> > +u64 new_vmalloc[NR_CPUS / sizeof(u64) + 1];
> > +
> >  struct kernel_mapping kernel_map __ro_after_init;
> >  EXPORT_SYMBOL(kernel_map);
> >  #ifdef CONFIG_XIP_KERNEL
> > --
> > 2.39.2
> >
> >
>
> Regards,
> Anup

Thanks for taking a look Anup,

Alex

