Return-Path: <linux-kernel+bounces-237535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD85C923A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA1B283821
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079E6156962;
	Tue,  2 Jul 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dpw+rOSr"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4833A8D0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913701; cv=none; b=AXt0Dtb25cBQK9yL5xlz2MGMNEKhZk97K5BddU40pD/aT97IUZga6uB6ciuCbyB2nunstnLHShzs6EgQCQ84hU1IcsPl9//XVSzmBLUkkH2VrLmFnj9hkD8Ym+HnJnRIFunJh30s3vFd6woKx4X3MH7ScszX2cisLPPuLb0b8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913701; c=relaxed/simple;
	bh=us3L0Hn9gdRrrP3eLVyCFt+JTrBZQUuK9cwCO+Rvlgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGrYG+mCRZF8tAQmdTE/Slcl/PeWlj+wihvu9vOut6D/p8gjNE/fmRHX7dFgUxoZKvvXmBTeROshxyaIGpFcUEN/D/X6eHfOFwDvFncVTuN4Gta0QyFUORtU/+Ah14P1WfzB1TIKPTDLImo804LibHdOqJ2QXliupEZMJjynouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dpw+rOSr; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25cc31f3716so1885649fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719913698; x=1720518498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgjTYztQF+lkm21+SoAtUw0LB3SZvPXk8Y+NeUr3Seg=;
        b=dpw+rOSrrJQPvpoFVx0ZlJl18n3eju3cPCmO0hS7DG9OMKel1taesC03PH0M6jTEEx
         sqHBXYIKPOwbMlodA3u9gpf6rLCs/Xzz+ZK4JKeq6ds8Gf7CJUm8Bn8E4M+kRmPy9kDf
         XgSbjohobMUFqDgzDl4t9zufXnuxhzMtQBhAPpJuUbWw+EfrngHms07oe1gmz2sqLxp5
         vuUosjJkZYYAR5xZIdYN7q4l9bYEosZc88o2rYalS3ZKrogJOSpPOmod15MdwL7RPCwj
         DZJDQ3/8Pla3b/tjz0ewkAkqSAvHC6MrAwBZhhoxZc1r97emdGCa1EA1mHO1L/tipSmS
         ETWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913698; x=1720518498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgjTYztQF+lkm21+SoAtUw0LB3SZvPXk8Y+NeUr3Seg=;
        b=ZcY48OMm+tV+eyuQj/JU4Fs+SQGYRVUgHx/GmPjqDKhDZaclHR408sg4Gu43gQcqdF
         rCRX5HvvMmMVNQTYR5gEihH/eDcTQ2Kp66HeV5ExNxUgY8A05vIG/m90/zAEf5iTDLwM
         mrcVzgFlbvOkZK9fq0vc19ZRYF8NwkfZuQiy/xipsviUU4tpRp+VFF90j7vfSHWLz9o0
         aO6K2edBJA+eUV4+6KgtP4lLzb8KlWWIfKxHWDnZuGfX2iQMjLH9gSCBcgj03y7DT+Mo
         h63LllHfXPyYIInpz6bTTN+A3LLSlzqp7TvqUu2W+y+4GheBe0Ves7090evkAPQF+LTJ
         FoBg==
X-Forwarded-Encrypted: i=1; AJvYcCXabbuFFXYbo1Fi5+Asu5sHKzWme9IXNlrsL43jNnSJrkuMQAMITkijn7YOeiARdh6b27Pfj8CmAbjy47Do4ROtN09yZlA9fVCp4JhJ
X-Gm-Message-State: AOJu0YycodcCfvAP92ncCwpo0ckGx5PcXppByn970M6QpflDhwyIWHvU
	PL4Bu/AqPcZvuHeQI1Y63cfTnbmT6hytXUs/twWlKro/cTjf/CivbZuFze6X8X/r/ZWsoRak70l
	2bcO1lcaV1R6fGBS3b0WhyFRutugaKd35DRxDjEpq1weK2OxYcIuxZA==
X-Google-Smtp-Source: AGHT+IE+hwvcI4rPV5fEyMAe5ajx33FbIOKjumywSKTu9fNWODlJZdO8iiM1gDSOozd/mXR/kCQVWaNqqndJx3aaiXY=
X-Received: by 2002:a05:6871:522a:b0:250:7465:d221 with SMTP id
 586e51a60fabf-25db3447b45mr7876010fac.28.1719913698401; Tue, 02 Jul 2024
 02:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702085034.48395-1-alexghiti@rivosinc.com> <20240702085034.48395-4-alexghiti@rivosinc.com>
In-Reply-To: <20240702085034.48395-4-alexghiti@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 2 Jul 2024 17:48:06 +0800
Message-ID: <CAEEQ3wnxBOTvzwswahP6ciOXKMuCbec_Ns+-H0tj9UK-WNow_A@mail.gmail.com>
Subject: Re: [External] [PATCH v3 3/4] riscv: Stop emitting preventive
 sfence.vma for new vmalloc mappings
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Ved Shanbhogue <ved@rivosinc.com>, Matt Evans <mev@rivosinc.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Tue, Jul 2, 2024 at 4:54=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> In 6.5, we removed the vmalloc fault path because that can't work (see
> [1] [2]). Then in order to make sure that new page table entries were
> seen by the page table walker, we had to preventively emit a sfence.vma
> on all harts [3] but this solution is very costly since it relies on IPI.
>
> And even there, we could end up in a loop of vmalloc faults if a vmalloc
> allocation is done in the IPI path (for example if it is traced, see
> [4]), which could result in a kernel stack overflow.
>
> Those preventive sfence.vma needed to be emitted because:
>
> - if the uarch caches invalid entries, the new mapping may not be
>   observed by the page table walker and an invalidation may be needed.
> - if the uarch does not cache invalid entries, a reordered access
>   could "miss" the new mapping and traps: in that case, we would actually
>   only need to retry the access, no sfence.vma is required.
>
> So this patch removes those preventive sfence.vma and actually handles
> the possible (and unlikely) exceptions. And since the kernel stacks
> mappings lie in the vmalloc area, this handling must be done very early
> when the trap is taken, at the very beginning of handle_exception: this
> also rules out the vmalloc allocations in the fault path.
>
> Link: https://lore.kernel.org/linux-riscv/20230531093817.665799-1-bjorn@k=
ernel.org/ [1]
> Link: https://lore.kernel.org/linux-riscv/20230801090927.2018653-1-dylan@=
andestech.com [2]
> Link: https://lore.kernel.org/linux-riscv/20230725132246.817726-1-alexghi=
ti@rivosinc.com/ [3]
> Link: https://lore.kernel.org/lkml/20200508144043.13893-1-joro@8bytes.org=
/ [4]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/cacheflush.h  | 18 +++++-
>  arch/riscv/include/asm/thread_info.h |  5 ++
>  arch/riscv/kernel/asm-offsets.c      |  5 ++
>  arch/riscv/kernel/entry.S            | 84 ++++++++++++++++++++++++++++
>  arch/riscv/mm/init.c                 |  2 +
>  5 files changed, 113 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm=
/cacheflush.h
> index ce79c558a4c8..8de73f91bfa3 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -46,7 +46,23 @@ do {                                                 \
>  } while (0)
>
>  #ifdef CONFIG_64BIT
> -#define flush_cache_vmap(start, end)           flush_tlb_kernel_range(st=
art, end)
> +extern u64 new_vmalloc[NR_CPUS / sizeof(u64) + 1];
> +extern char _end[];
> +#define flush_cache_vmap flush_cache_vmap
> +static inline void flush_cache_vmap(unsigned long start, unsigned long e=
nd)
> +{
> +       if (is_vmalloc_or_module_addr((void *)start)) {
> +               int i;
> +
> +               /*
> +                * We don't care if concurrently a cpu resets this value =
since
> +                * the only place this can happen is in handle_exception(=
) where
> +                * an sfence.vma is emitted.
> +                */
> +               for (i =3D 0; i < ARRAY_SIZE(new_vmalloc); ++i)
> +                       new_vmalloc[i] =3D -1ULL;
> +       }
> +}
>  #define flush_cache_vmap_early(start, end)     local_flush_tlb_kernel_ra=
nge(start, end)
>  #endif
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index 5d473343634b..32631acdcdd4 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -60,6 +60,11 @@ struct thread_info {
>         void                    *scs_base;
>         void                    *scs_sp;
>  #endif
> +       /*
> +        * Used in handle_exception() to save a0, a1 and a2 before knowin=
g if we
> +        * can access the kernel stack.
> +        */
> +       unsigned long           a0, a1, a2;
>  };
>
>  #ifdef CONFIG_SHADOW_CALL_STACK
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offs=
ets.c
> index b09ca5f944f7..29c0734f2972 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -36,6 +36,8 @@ void asm_offsets(void)
>         OFFSET(TASK_THREAD_S9, task_struct, thread.s[9]);
>         OFFSET(TASK_THREAD_S10, task_struct, thread.s[10]);
>         OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
> +
> +       OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
>         OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
>         OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_co=
unt);
>         OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
> @@ -43,6 +45,9 @@ void asm_offsets(void)
>  #ifdef CONFIG_SHADOW_CALL_STACK
>         OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>  #endif
> +       OFFSET(TASK_TI_A0, task_struct, thread_info.a0);
> +       OFFSET(TASK_TI_A1, task_struct, thread_info.a1);
> +       OFFSET(TASK_TI_A2, task_struct, thread_info.a2);
>
>         OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>         OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 68a24cf9481a..822311266a12 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -19,6 +19,78 @@
>
>         .section .irqentry.text, "ax"
>
> +.macro new_vmalloc_check
> +       REG_S   a0, TASK_TI_A0(tp)
> +       REG_S   a1, TASK_TI_A1(tp)
> +       REG_S   a2, TASK_TI_A2(tp)

We discussed in the previous version that when executing blt a0, zero,
_new_vmalloc_restore_context, there is no need to save a1, a2 first,
right?

> +
> +       csrr    a0, CSR_CAUSE
> +       /* Exclude IRQs */
> +       blt     a0, zero, _new_vmalloc_restore_context
> +       /* Only check new_vmalloc if we are in page/protection fault */
> +       li      a1, EXC_LOAD_PAGE_FAULT
> +       beq     a0, a1, _new_vmalloc_kernel_address
> +       li      a1, EXC_STORE_PAGE_FAULT
> +       beq     a0, a1, _new_vmalloc_kernel_address
> +       li      a1, EXC_INST_PAGE_FAULT
> +       bne     a0, a1, _new_vmalloc_restore_context
> +
> +_new_vmalloc_kernel_address:
> +       /* Is it a kernel address? */
> +       csrr    a0, CSR_TVAL
> +       bge     a0, zero, _new_vmalloc_restore_context
> +
> +       /* Check if a new vmalloc mapping appeared that could explain the=
 trap */
> +
> +       /*
> +        * Computes:
> +        * a0 =3D &new_vmalloc[BIT_WORD(cpu)]
> +        * a1 =3D BIT_MASK(cpu)
> +        */
> +       REG_L   a2, TASK_TI_CPU(tp)
> +       /*
> +        * Compute the new_vmalloc element position:
> +        * (cpu / 64) * 8 =3D (cpu >> 6) << 3
> +        */
> +       srli    a1, a2, 6
> +       slli    a1, a1, 3
> +       la      a0, new_vmalloc
> +       add     a0, a0, a1
> +       /*
> +        * Compute the bit position in the new_vmalloc element:
> +        * bit_pos =3D cpu % 64 =3D cpu - (cpu / 64) * 64 =3D cpu - (cpu =
>> 6) << 6
> +        *         =3D cpu - ((cpu >> 6) << 3) << 3
> +        */
> +       slli    a1, a1, 3
> +       sub     a1, a2, a1
> +       /* Compute the "get mask": 1 << bit_pos */
> +       li      a2, 1
> +       sll     a1, a2, a1
> +
> +       /* Check the value of new_vmalloc for this cpu */
> +       REG_L   a2, 0(a0)
> +       and     a2, a2, a1
> +       beq     a2, zero, _new_vmalloc_restore_context
> +
> +       /* Atomically reset the current cpu bit in new_vmalloc */
> +       amoxor.w        a0, a1, (a0)
> +
> +       /* Only emit a sfence.vma if the uarch caches invalid entries */
> +       ALTERNATIVE("sfence.vma", "nop", 0, RISCV_ISA_EXT_SVVPTC, 1)
> +
> +       REG_L   a0, TASK_TI_A0(tp)
> +       REG_L   a1, TASK_TI_A1(tp)
> +       REG_L   a2, TASK_TI_A2(tp)
> +       csrw    CSR_SCRATCH, x0
> +       sret
> +
> +_new_vmalloc_restore_context:
> +       REG_L   a0, TASK_TI_A0(tp)
> +       REG_L   a1, TASK_TI_A1(tp)
> +       REG_L   a2, TASK_TI_A2(tp)
> +.endm
> +
> +
>  SYM_CODE_START(handle_exception)
>         /*
>          * If coming from userspace, preserve the user thread pointer and=
 load
> @@ -30,6 +102,18 @@ SYM_CODE_START(handle_exception)
>
>  .Lrestore_kernel_tpsp:
>         csrr tp, CSR_SCRATCH
> +
> +       /*
> +        * The RISC-V kernel does not eagerly emit a sfence.vma after eac=
h
> +        * new vmalloc mapping, which may result in exceptions:
> +        * - if the uarch caches invalid entries, the new mapping would n=
ot be
> +        *   observed by the page table walker and an invalidation is nee=
ded.
> +        * - if the uarch does not cache invalid entries, a reordered acc=
ess
> +        *   could "miss" the new mapping and traps: in that case, we onl=
y need
> +        *   to retry the access, no sfence.vma is required.
> +        */
> +       new_vmalloc_check
> +
>         REG_S sp, TASK_TI_KERNEL_SP(tp)
>
>  #ifdef CONFIG_VMAP_STACK
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e3405e4b99af..2367a156c33b 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -36,6 +36,8 @@
>
>  #include "../kernel/head.h"
>
> +u64 new_vmalloc[NR_CPUS / sizeof(u64) + 1];
> +
>  struct kernel_mapping kernel_map __ro_after_init;
>  EXPORT_SYMBOL(kernel_map);
>  #ifdef CONFIG_XIP_KERNEL
> --
> 2.39.2
>

Thanks=EF=BC=8C
Yunhui

