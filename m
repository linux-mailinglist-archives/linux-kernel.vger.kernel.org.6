Return-Path: <linux-kernel+bounces-258407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BC1938795
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABACB20E24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 02:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A2DEAF1;
	Mon, 22 Jul 2024 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KZfG3q3O"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146154437
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721617042; cv=none; b=Oj/iLc4JdkInswCU9aKo/g0LhpzvEtc8hLDHgug9YH6ebziBqgfEUshDXkhRcwCai6qlBwkjUScSU+5/a6ddFhadDH8aNDlwhD7lDKcxoMI+lVjpYRvqaEpDzyYN0Rq98y0RQyi8wzgGtOkxD4Fd8jbKE0XVrDydFdFN5EelQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721617042; c=relaxed/simple;
	bh=HAkfLC+PKGm47dgQq9Zjaj+GMiGX0zsGCPVR4ql0G00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZISwx+G1g8Y2Sc0MwIKsFB9D/J8sru0ZsJPrgJPaLyauCsOuq+UKEB8X0SHrDx79ooE/86LqhJqsWP2W12/6qBS3UYu3TE73QNcxTixRwOjkis7M5e9UgGy2UeUF2TwOLfe5wn8zzPGQ31E8zU2Ps9Uwf+6KHB35rNxfdz+4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KZfG3q3O; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25d6dd59170so1814545fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 19:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721617040; x=1722221840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uF269dLG3DSvHPzvfk1TfdfasopOhhcCZ5ZSpqY2pxk=;
        b=KZfG3q3O292e6PlbGZoiO4j9yUKGgYh5pVkSQCFley96IRJutezPHwetjVQDuSjNgj
         i6XB+rUp1YfrRcBd6De/1xPgEFP6qNYmfuGhHo9gHeOwZRt881DUTG28TksAZRchzyjZ
         3epleYwyQIFSBvsJY8LloR/HGcThNVl/PY5dFLlqaOjCpsz8wH1XroSjZC+VRWcK1PeA
         6YNisqNpPfvOA00gnzmRe4CDqPN1beQ+YN82EHLDDuMLrWeWJ6ZQVyF7InFfbYrUt6pW
         SkjRFJ5uR5wc+aquYQbBKATUENhRNEfg2E49JntssbwUOqyJB8S8s4O0GclIpz1dzKad
         Nvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721617040; x=1722221840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uF269dLG3DSvHPzvfk1TfdfasopOhhcCZ5ZSpqY2pxk=;
        b=KRgJgeP9J5uK9przi33cXCFaa2cB0ZYje49sY3w7D9qZUtBRu2MfUl2sTf21Ij0kH6
         7dF+iVSRj7mwVUaqqBc2aGHjS48LQW148BUIBiM5jKG0mHcLYCAH4lAILzSItOtGS5+U
         TVYBTCrBo0c0z1LhavHlbzmmFH+mfL8bcp3gKhZfZTZ7NZ9Yj4Bjku8S7/P1DB9eEIHp
         mWteLa4l0Jh5pq6bURyq0o1uWcCv2CeEahmdsXWIgSfwPxupUgxmqrZImZE3Tn1r+NBk
         3RAF6xYStDYIR7VUgCUqhgOrwS0NoUTjyrYfhtn+ZiuhBNd4K2/45YhgDoSy+/z71ncG
         CnwA==
X-Forwarded-Encrypted: i=1; AJvYcCXCn9mS2JOzEKvARKqbT0udbofmX5ESnLYx2qc93LSBrXWpqwn1aJQ7u1+QnzE8hAssMaE0c/r4/Fk8aafSeHJ5FkOuG9zQjfE1W8qj
X-Gm-Message-State: AOJu0YwgNc774U45Z0tzEisCa09ml7lfAAiYYKaKheat/Ge2WcIWVl+e
	KAwZ2hO5BXrnOEyMQFxcWcHGVBzjnq1z3yBjpUJvBzSEWI8n6jdrdEWKbAzHiNqO8EMJ9Xab4hU
	g6fRj2KviaqQpLhNvNYR3TbOkde1qxbt8qTu/mg==
X-Google-Smtp-Source: AGHT+IExbEwOpVKYYta/J7YcIPxDB0N39rpcLEauff4Y27dV6diop2XxerWxFW2cUQMmrYKu70b0eX/q5e1l47vnZ+I=
X-Received: by 2002:a05:6870:b487:b0:260:8f6d:f01f with SMTP id
 586e51a60fabf-263ab6513cfmr2716697fac.39.1721617039859; Sun, 21 Jul 2024
 19:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717060125.139416-1-alexghiti@rivosinc.com> <20240717060125.139416-4-alexghiti@rivosinc.com>
In-Reply-To: <20240717060125.139416-4-alexghiti@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 22 Jul 2024 10:57:08 +0800
Message-ID: <CAEEQ3wnwAzpRVDJWhG1pKXZQYpgJhivUSHM5qPpU-mCbGDh9jw@mail.gmail.com>
Subject: Re: [External] [PATCH v4 3/4] riscv: Stop emitting preventive
 sfence.vma for new vmalloc mappings
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Ved Shanbhogue <ved@rivosinc.com>, Matt Evans <mev@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Wed, Jul 17, 2024 at 2:04=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
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
>  arch/riscv/include/asm/thread_info.h |  7 +++
>  arch/riscv/kernel/asm-offsets.c      |  7 +++
>  arch/riscv/kernel/entry.S            | 87 ++++++++++++++++++++++++++++
>  arch/riscv/mm/init.c                 |  2 +
>  5 files changed, 120 insertions(+), 1 deletion(-)
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
> index 5d473343634b..0ddf1123b5ba 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -60,6 +60,13 @@ struct thread_info {
>         void                    *scs_base;
>         void                    *scs_sp;
>  #endif
> +#ifdef CONFIG_64BIT
> +       /*
> +        * Used in handle_exception() to save a0, a1 and a2 before knowin=
g if we
> +        * can access the kernel stack.
> +        */
> +       unsigned long           a0, a1, a2;
> +#endif
>  };
>
>  #ifdef CONFIG_SHADOW_CALL_STACK
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offs=
ets.c
> index b09ca5f944f7..e94180ba432f 100644
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
> @@ -43,6 +45,11 @@ void asm_offsets(void)
>  #ifdef CONFIG_SHADOW_CALL_STACK
>         OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>  #endif
> +#ifdef CONFIG_64BIT
> +       OFFSET(TASK_TI_A0, task_struct, thread_info.a0);
> +       OFFSET(TASK_TI_A1, task_struct, thread_info.a1);
> +       OFFSET(TASK_TI_A2, task_struct, thread_info.a2);
> +#endif
>
>         OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>         OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 68a24cf9481a..d80b90f99bc1 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -19,6 +19,79 @@
>
>         .section .irqentry.text, "ax"
>
> +.macro new_vmalloc_check
> +       REG_S   a0, TASK_TI_A0(tp)
> +       csrr    a0, CSR_CAUSE
> +       /* Exclude IRQs */
> +       blt     a0, zero, _new_vmalloc_restore_context_a0
> +
> +       REG_S   a1, TASK_TI_A1(tp)
> +       /* Only check new_vmalloc if we are in page/protection fault */
> +       li      a1, EXC_LOAD_PAGE_FAULT
> +       beq     a0, a1, _new_vmalloc_kernel_address
> +       li      a1, EXC_STORE_PAGE_FAULT
> +       beq     a0, a1, _new_vmalloc_kernel_address
> +       li      a1, EXC_INST_PAGE_FAULT
> +       bne     a0, a1, _new_vmalloc_restore_context_a1
> +
> +_new_vmalloc_kernel_address:
> +       /* Is it a kernel address? */
> +       csrr    a0, CSR_TVAL
> +       bge     a0, zero, _new_vmalloc_restore_context_a1
> +
> +       /* Check if a new vmalloc mapping appeared that could explain the=
 trap */
> +       REG_S   a2, TASK_TI_A2(tp)
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
> +       amoxor.d        a0, a1, (a0)
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
> +       REG_L   a2, TASK_TI_A2(tp)
> +_new_vmalloc_restore_context_a1:
> +       REG_L   a1, TASK_TI_A1(tp)
> +_new_vmalloc_restore_context_a0:
> +       REG_L   a0, TASK_TI_A0(tp)
> +.endm
> +
> +
>  SYM_CODE_START(handle_exception)
>         /*
>          * If coming from userspace, preserve the user thread pointer and=
 load
> @@ -30,6 +103,20 @@ SYM_CODE_START(handle_exception)
>
>  .Lrestore_kernel_tpsp:
>         csrr tp, CSR_SCRATCH
> +
> +#ifdef CONFIG_64BIT
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
> +#endif
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

Reviewed-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thanks,
Yunhui

