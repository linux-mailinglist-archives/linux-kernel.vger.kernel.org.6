Return-Path: <linux-kernel+bounces-438855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33019EA759
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8432891A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E819DF7D;
	Tue, 10 Dec 2024 04:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kHvEdHXu"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031B146D6B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733806337; cv=none; b=opl6NgLge1jOgXdR/nWmcY0LmaXznb/BAzCkhmP8ZQEfYvt8+ImKvEMb7W3puYpo4xg5CWvfP2zW8NuRtsapecQh3zWq9HGSt0+kLdh6F0nQ5GMPq+cYOvR1KJQt2TCbySTRgmRYD7kZlycsHkqyvAprlW+jkscRodQ5liFnlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733806337; c=relaxed/simple;
	bh=eSBvu2CbiONLB8in58zkQGWkDqfhXMIiz09Jf7lOnG8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tPsnFJoS/FscUKdgI3fECUmtMCNxwT35lTeeWUpvduJPh3cE+DWr+Y40zpRBk6Y/KcXfFpHEt87vmUXcteRbvzNdB6f/sp5r/OFSi/Pfg1Sedhs29uO4CNVDHNoU/RnOZA7nkTU71F4lwTd+JdDve1M9s7RKxMSAamrtbdzjNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kHvEdHXu; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc93152edcso4054349a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 20:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1733806335; x=1734411135; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQaFe1kydys1HEHxGLmnQtwgKTg8tf9qQFrqiJzBrX8=;
        b=kHvEdHXuzHwH8pvV6+FgcOM3CcPf/sYxaChFMVcK1M2yZOXjeoxifZU/t9SqjIgSve
         QwUMYkMmnolSbfcCcUSWAhjnJ4S9LeEL89oW5dcXViSPjN2WWS4p7XNuFLp4SJk79wdR
         +kGoV3kMiWe7Hrqqx8kCvWIFZNpws86DeAKGW5q7rTYVFDbFLOmOjxznaPh84dguQ5SE
         c9jDYMPTW2yh826v1uUxsGDh289hXD+HyLW49kFvOb3HruhX4Sr6jAJugBLhcenu6aam
         jhibbm869zHw31x39KjSmRNDm0cg/wJJumJB+jykU9bUbePysyn31Qqyqq9zIIjQbfqi
         aNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733806335; x=1734411135;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQaFe1kydys1HEHxGLmnQtwgKTg8tf9qQFrqiJzBrX8=;
        b=WB3fLImNQKovlckbaVkZA1/r5UmLp60AWjj0WQOGYtbqnL8I+eiF8EKj0hTXElYXHJ
         SkCCJGkNZVxhoLXwzKFYfZIFe7Jnvuc0Wv1KXnFqtkw67QHKl10/aMzsRekUZJ4giJKm
         3t0XpgGc0ZXowpuC7RETXe0i2vQ9tat/z21OyPrIFYTaHS7LA1aDxegOtCe7VUN1dwDv
         T63o9/LPJanvXcb3BWJ6QA2udHg3DqkOSa7jyAJZ6RIEzUweUMXIEA7bFbmyqNu3a4Oy
         hf8pn3EcOQAFdOoWHFO808/UzG6vw8DdGPmkXlZ6EJ9+icRuIvb8OHMuqwIJtz5hfRWe
         iGBw==
X-Forwarded-Encrypted: i=1; AJvYcCVEDGcGzV+LLHivIrxZ/aNdR0b/w1SswSORqhq+gglrczn6pfN32pClOF0V+Mm+jBSsXFZbpD8EfxC8qf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOe0yiXhcHpqmhqIKCkifTfn6UoPnXn0YGJztTH/XoN5WPM68u
	LludtDRjpbaOSfi//rqFqInzYuadNhloVSRKpK4shCzYzOktWDDsfEE+dbcNG5wqMzGqOT1xvg6
	B
X-Gm-Gg: ASbGncthmXFmj/wYdUAh7dDCJ2Zg3u0ENnX1PoUxuUebODAsfJ3Xg98Dyuc1RNlSaT9
	1p/Ye9LcK+XfPbSSxSbSm6oS9Gv1oDTGasiRTFlCtRuj88EyEqO32IgkZn7lX02sY8lRM8146gc
	WCz/KUCDXXLnv/r9o9LyPrZuG0tmZFsrThdLsgO+YWXDfwefsIKuIqiZQy8GSGQwkjB1YZO1WdO
	Ca2JAdZ+E99/l8oAKLUMEzQydJvNWTIdzuKdULNACz7faX9Rax3HIvxsGydc1GhGNY5ADYathp4
	cdksr3PG9Ez9
X-Google-Smtp-Source: AGHT+IGRFz0l54/59Ln8A2J7L1/L9T4tyHgKKXs5HSjPXBZ1uS/u/5Y4aTfvebzl9yZNscuTY4r2tg==
X-Received: by 2002:a05:6a21:789a:b0:1e0:c99e:1f41 with SMTP id adf61e73a8af0-1e1b43f6d3cmr3153206637.8.1733806334664;
        Mon, 09 Dec 2024 20:52:14 -0800 (PST)
Received: from smtpclient.apple ([2405:201:d019:c0ce:91be:65fe:1d52:6605])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e2f2d5f0sm3860721b3a.40.2024.12.09.20.52.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2024 20:52:14 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3 2/4] riscv: add support for SBI Supervisor Software
 Events extension
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
In-Reply-To: <20241206163102.843505-3-cleger@rivosinc.com>
Date: Tue, 10 Dec 2024 10:21:38 +0530
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Anup Patel <apatel@ventanamicro.com>,
 Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDD40494-D31E-46E5-89C6-0B2A50C1B953@ventanamicro.com>
References: <20241206163102.843505-1-cleger@rivosinc.com>
 <20241206163102.843505-3-cleger@rivosinc.com>
To: Clement Leger <cleger@rivosinc.com>
X-Mailer: Apple Mail (2.3826.200.121)

Hi Clement,

> On 6 Dec 2024, at 22:00, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com> =
wrote:
>=20
> The SBI SSE extension allows the supervisor software to be notified by
> the SBI of specific events that are not maskable. The context switch =
is
> handled partially by the firmware which will save registers a6 and a7.
> When entering kernel we can rely on these 2 registers to setup the =
stack
> and save all the registers.
>=20
> Since SSE events can be delivered at any time to the kernel (including
> during exception handling, we need a way to locate the current_task =
for
> context tracking. On RISC-V, it is sotred in scratch when in user =
space
> or tp when in kernel space (in which case SSCRATCH is zero). But at a
> at the beginning of exception handling, SSCRATCH is used to swap tp =
and
> check the origin of the exception. If interrupted at that point, then,
> there is no way to reliably know were is located the current
> task_struct. Even checking the interruption location won't work as SSE
> event can be nested on top of each other so the original interruption
> site might be lost at some point. In order to retrieve it reliably,
> store the current task in an additionnal __sse_entry_task per_cpu =
array.
> This array is then used to retrieve the current task based on the
> hart ID that is passed to the SSE event handler in a6.
>=20
> That being said, the way the current task struct is stored should
> probably be reworked to find a better reliable alternative.
>=20
> Since each events (and each CPU for local events) have their own
> context and can preempt each other, allocate a stack (and a shadow =
stack
> if needed for each of them (and for each cpu for local events).
>=20
> When completing the event, if we were coming from kernel with =
interrupts
> disabled, simply return there. If coming from userspace or kernel with
> interrupts enabled, simulate an interrupt exception by setting IE_SIE =
in
> CSR_IP to allow delivery of signals to user task. For instance this =
can
> happen, when a RAS event has been generated by a user application and =
a
> SIGBUS has been sent to a task.
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
> arch/riscv/include/asm/asm.h         |  14 ++-
> arch/riscv/include/asm/scs.h         |   7 ++
> arch/riscv/include/asm/sse.h         |  38 ++++++
> arch/riscv/include/asm/switch_to.h   |  14 +++
> arch/riscv/include/asm/thread_info.h |   1 +
> arch/riscv/kernel/Makefile           |   1 +
> arch/riscv/kernel/asm-offsets.c      |  12 ++
> arch/riscv/kernel/sse.c              | 134 +++++++++++++++++++++
> arch/riscv/kernel/sse_entry.S        | 171 +++++++++++++++++++++++++++
> 9 files changed, 389 insertions(+), 3 deletions(-)
> create mode 100644 arch/riscv/include/asm/sse.h
> create mode 100644 arch/riscv/kernel/sse.c
> create mode 100644 arch/riscv/kernel/sse_entry.S
>=20
> diff --git a/arch/riscv/include/asm/asm.h =
b/arch/riscv/include/asm/asm.h
> index 776354895b81..de8427c58f02 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -89,16 +89,24 @@
> #define PER_CPU_OFFSET_SHIFT 3
> #endif
>=20
> -.macro asm_per_cpu dst sym tmp
> - REG_L \tmp, TASK_TI_CPU_NUM(tp)
> - slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
> + slli  \tmp, \cpu, PER_CPU_OFFSET_SHIFT
> la    \dst, __per_cpu_offset
> add   \dst, \dst, \tmp
> REG_L \tmp, 0(\dst)
> la    \dst, \sym
> add   \dst, \dst, \tmp
> .endm
> +
> +.macro asm_per_cpu dst sym tmp
> + REG_L \tmp, TASK_TI_CPU_NUM(tp)
> + asm_per_cpu_with_cpu \dst \sym \tmp \tmp
> +.endm
> #else /* CONFIG_SMP */
> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
> + la    \dst, \sym
> +.endm
> +
> .macro asm_per_cpu dst sym tmp
> la    \dst, \sym
> .endm
> diff --git a/arch/riscv/include/asm/scs.h =
b/arch/riscv/include/asm/scs.h
> index 0e45db78b24b..62344daad73d 100644
> --- a/arch/riscv/include/asm/scs.h
> +++ b/arch/riscv/include/asm/scs.h
> @@ -18,6 +18,11 @@
> load_per_cpu gp, irq_shadow_call_stack_ptr, \tmp
> .endm
>=20
> +/* Load the per-CPU IRQ shadow call stack to gp. */
> +.macro scs_load_sse_stack reg_evt
> + REG_L gp, SSE_REG_EVT_SHADOW_STACK(\reg_evt)
> +.endm
> +
> /* Load task_scs_sp(current) to gp. */
> .macro scs_load_current
> REG_L gp, TASK_TI_SCS_SP(tp)
> @@ -41,6 +46,8 @@
> .endm
> .macro scs_load_irq_stack tmp
> .endm
> +.macro scs_load_sse_stack reg_evt
> +.endm
> .macro scs_load_current
> .endm
> .macro scs_load_current_if_task_changed prev
> diff --git a/arch/riscv/include/asm/sse.h =
b/arch/riscv/include/asm/sse.h
> new file mode 100644
> index 000000000000..431a19d4cd9c
> --- /dev/null
> +++ b/arch/riscv/include/asm/sse.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +#ifndef __ASM_SSE_H
> +#define __ASM_SSE_H
> +
> +#ifdef CONFIG_RISCV_SSE
> +
> +struct sse_event_interrupted_state {
> + unsigned long a6;
> + unsigned long a7;
> +};
> +
> +struct sse_event_arch_data {
> + void *stack;
> + void *shadow_stack;
> + unsigned long tmp;
> + struct sse_event_interrupted_state interrupted;
> + unsigned long interrupted_state_phys;
> + u32 evt_id;
> +};
> +
> +struct sse_registered_event;
> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 =
evt_id,
> + int cpu);
> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt);
> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt);
> +
> +void sse_handle_event(struct sse_event_arch_data *arch_evt,
> +      struct pt_regs *regs);
> +asmlinkage void handle_sse(void);
> +asmlinkage void do_sse(struct sse_event_arch_data *arch_evt,
> + struct pt_regs *reg);
> +
> +#endif
> +
> +#endif
> diff --git a/arch/riscv/include/asm/switch_to.h =
b/arch/riscv/include/asm/switch_to.h
> index 94e33216b2d9..e166fabe04ab 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -88,6 +88,19 @@ static inline void __switch_to_envcfg(struct =
task_struct *next)
> :: "r" (next->thread.envcfg) : "memory");
> }
>=20
> +#ifdef CONFIG_RISCV_SSE
> +DECLARE_PER_CPU(struct task_struct *, __sse_entry_task);
> +
> +static inline void __switch_sse_entry_task(struct task_struct *next)
> +{
> + __this_cpu_write(__sse_entry_task, next);
> +}
> +#else
> +static inline void __switch_sse_entry_task(struct task_struct *next)
> +{
> +}
> +#endif
> +
> extern struct task_struct *__switch_to(struct task_struct *,
>       struct task_struct *);
>=20
> @@ -122,6 +135,7 @@ do { \
> if (switch_to_should_flush_icache(__next)) \
> local_flush_icache_all(); \
> __switch_to_envcfg(__next); \
> + __switch_sse_entry_task(__next); \
> ((last) =3D __switch_to(__prev, __next)); \
> } while (0)
>=20
> diff --git a/arch/riscv/include/asm/thread_info.h =
b/arch/riscv/include/asm/thread_info.h
> index f5916a70879a..28e9805e61fc 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -36,6 +36,7 @@
> #define OVERFLOW_STACK_SIZE     SZ_4K
>=20
> #define IRQ_STACK_SIZE THREAD_SIZE
> +#define SSE_STACK_SIZE THREAD_SIZE
>=20
> #ifndef __ASSEMBLY__
>=20
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 063d1faf5a53..1e8fb83b1162 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE) +=3D mcount-dyn.o
> obj-$(CONFIG_PERF_EVENTS) +=3D perf_callchain.o
> obj-$(CONFIG_HAVE_PERF_REGS) +=3D perf_regs.o
> obj-$(CONFIG_RISCV_SBI) +=3D sbi.o sbi_ecall.o
> +obj-$(CONFIG_RISCV_SSE) +=3D sse.o sse_entry.o
> ifeq ($(CONFIG_RISCV_SBI), y)
> obj-$(CONFIG_SMP) +=3D sbi-ipi.o
> obj-$(CONFIG_SMP) +=3D cpu_ops_sbi.o
> diff --git a/arch/riscv/kernel/asm-offsets.c =
b/arch/riscv/kernel/asm-offsets.c
> index e89455a6a0e5..60590a3d9519 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -14,6 +14,8 @@
> #include <asm/ptrace.h>
> #include <asm/cpu_ops_sbi.h>
> #include <asm/stacktrace.h>
> +#include <asm/sbi.h>
> +#include <asm/sse.h>
> #include <asm/suspend.h>
>=20
> void asm_offsets(void);
> @@ -511,4 +513,14 @@ void asm_offsets(void)
> DEFINE(FREGS_A6,    offsetof(struct __arch_ftrace_regs, a6));
> DEFINE(FREGS_A7,    offsetof(struct __arch_ftrace_regs, a7));
> #endif
> +
> +#ifdef CONFIG_RISCV_SSE
> + OFFSET(SSE_REG_EVT_STACK, sse_event_arch_data, stack);
> + OFFSET(SSE_REG_EVT_SHADOW_STACK, sse_event_arch_data, shadow_stack);
> + OFFSET(SSE_REG_EVT_TMP, sse_event_arch_data, tmp);
> +
> + DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
> + DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
> + DEFINE(NR_CPUS, NR_CPUS);
> +#endif
> }
> diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
> new file mode 100644
> index 000000000000..b48ae69dad8d
> --- /dev/null
> +++ b/arch/riscv/kernel/sse.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +#include <linux/nmi.h>
> +#include <linux/scs.h>
> +#include <linux/bitfield.h>
> +#include <linux/riscv_sse.h>
> +#include <linux/percpu-defs.h>
> +
> +#include <asm/asm-prototypes.h>
> +#include <asm/switch_to.h>
> +#include <asm/irq_stack.h>
> +#include <asm/sbi.h>
> +#include <asm/sse.h>
> +
> +DEFINE_PER_CPU(struct task_struct *, __sse_entry_task);
> +
> +void __weak sse_handle_event(struct sse_event_arch_data *arch_evt, =
struct pt_regs *regs)
> +{
> +}
> +
> +void do_sse(struct sse_event_arch_data *arch_evt, struct pt_regs =
*regs)
> +{
> + nmi_enter();
> +
> + /* Retrieve missing GPRs from SBI */
> + sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt_id,
> +  SBI_SSE_ATTR_INTERRUPTED_A6,
> +  (SBI_SSE_ATTR_INTERRUPTED_A7 - SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
> +  arch_evt->interrupted_state_phys, 0, 0);
> +
> + memcpy(&regs->a6, &arch_evt->interrupted, =
sizeof(arch_evt->interrupted));
> +
> + sse_handle_event(arch_evt, regs);
> +
> + /*
> + * The SSE delivery path does not uses the "standard" exception path =
and
> + * thus does not process any pending signal/softirqs. Some drivers =
might
> + * enqueue pending work that needs to be handled as soon as possible.
> + * For that purpose, set the software interrupt pending bit which =
will
> + * be serviced once interrupts are reenabled
> + */
> + csr_set(CSR_IP, IE_SIE);
> +
> + nmi_exit();
> +}
> +
> +#ifdef CONFIG_VMAP_STACK
> +static unsigned long *sse_stack_alloc(unsigned int cpu, unsigned int =
size)
> +{
> + return arch_alloc_vmap_stack(size, cpu_to_node(cpu));
> +}
> +
> +static void sse_stack_free(unsigned long *stack)
> +{
> + vfree(stack);
> +}
> +#else /* CONFIG_VMAP_STACK */
> +
> +static unsigned long *sse_stack_alloc(unsigned int cpu, unsigned int =
size)
> +{
> + return kmalloc(size, GFP_KERNEL);
> +}
> +
> +static void sse_stack_free(unsigned long *stack)
> +{
> + kfree(stack);
> +}
> +
> +#endif /* CONFIG_VMAP_STACK */
> +
> +static int sse_init_scs(int cpu, struct sse_event_arch_data =
*arch_evt)
> +{
> + void *stack;
> +
> + if (!scs_is_enabled())
> + return 0;
> +
> + stack =3D scs_alloc(cpu_to_node(cpu));
> + if (!stack)
> + return 1;
> +
> + arch_evt->shadow_stack =3D stack;
> +
> + return 0;
> +}
> +
> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 =
evt_id, int cpu)
> +{
> + void *stack;
> +
> + arch_evt->evt_id =3D evt_id;
> + stack =3D sse_stack_alloc(cpu, SSE_STACK_SIZE);
> + if (!stack)
> + return -ENOMEM;
> +
> + arch_evt->stack =3D stack + SSE_STACK_SIZE;
> +
> + if (sse_init_scs(cpu, arch_evt))
> + goto free_stack;
> +
> + if (is_kernel_percpu_address((unsigned long)&arch_evt->interrupted)) =
{
> + arch_evt->interrupted_state_phys =3D
> + per_cpu_ptr_to_phys(&arch_evt->interrupted);
> + } else {
> + arch_evt->interrupted_state_phys =3D
> + virt_to_phys(&arch_evt->interrupted);
> + }
> +
> + return 0;
> +
> +free_stack:
> + sse_stack_free(arch_evt->stack - SSE_STACK_SIZE);
> +
> + return -ENOMEM;
> +}
> +
> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt)
> +{
> + scs_free(arch_evt->shadow_stack);
> + sse_stack_free(arch_evt->stack - SSE_STACK_SIZE);
> +}
> +
> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt)
> +{
> + struct sbiret sret;
> +
> + sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_REGISTER, =
arch_evt->evt_id,
> + (unsigned long) handle_sse, (unsigned long) arch_evt,
> + 0, 0, 0);
> +
> + return sbi_err_map_linux_errno(sret.error);
> +}
> diff --git a/arch/riscv/kernel/sse_entry.S =
b/arch/riscv/kernel/sse_entry.S
> new file mode 100644
> index 000000000000..0b2f890edd89
> --- /dev/null
> +++ b/arch/riscv/kernel/sse_entry.S
> @@ -0,0 +1,171 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +
> +#include <asm/asm.h>
> +#include <asm/csr.h>
> +#include <asm/scs.h>
> +
> +/* When entering handle_sse, the following registers are set:
> + * a6: contains the hartid
> + * a6: contains struct sse_registered_event pointer

Please fix this comment.

Regards
Himanshu

> + */
> +SYM_CODE_START(handle_sse)
> + /* Save stack temporarily */
> + REG_S sp, SSE_REG_EVT_TMP(a7)
> + /* Set entry stack */
> + REG_L sp, SSE_REG_EVT_STACK(a7)
> +
> + addi sp, sp, -(PT_SIZE_ON_STACK)
> + REG_S ra, PT_RA(sp)
> + REG_S s0, PT_S0(sp)
> + REG_S s1, PT_S1(sp)
> + REG_S s2, PT_S2(sp)
> + REG_S s3, PT_S3(sp)
> + REG_S s4, PT_S4(sp)
> + REG_S s5, PT_S5(sp)
> + REG_S s6, PT_S6(sp)
> + REG_S s7, PT_S7(sp)
> + REG_S s8, PT_S8(sp)
> + REG_S s9, PT_S9(sp)
> + REG_S s10, PT_S10(sp)
> + REG_S s11, PT_S11(sp)
> + REG_S tp, PT_TP(sp)
> + REG_S t0, PT_T0(sp)
> + REG_S t1, PT_T1(sp)
> + REG_S t2, PT_T2(sp)
> + REG_S t3, PT_T3(sp)
> + REG_S t4, PT_T4(sp)
> + REG_S t5, PT_T5(sp)
> + REG_S t6, PT_T6(sp)
> + REG_S gp, PT_GP(sp)
> + REG_S a0, PT_A0(sp)
> + REG_S a1, PT_A1(sp)
> + REG_S a2, PT_A2(sp)
> + REG_S a3, PT_A3(sp)
> + REG_S a4, PT_A4(sp)
> + REG_S a5, PT_A5(sp)
> +
> + /* Retrieve entry sp */
> + REG_L a4, SSE_REG_EVT_TMP(a7)
> + /* Save CSRs */
> + csrr a0, CSR_EPC
> + csrr a1, CSR_SSTATUS
> + csrr a2, CSR_STVAL
> + csrr a3, CSR_SCAUSE
> +
> + REG_S a0, PT_EPC(sp)
> + REG_S a1, PT_STATUS(sp)
> + REG_S a2, PT_BADADDR(sp)
> + REG_S a3, PT_CAUSE(sp)
> + REG_S a4, PT_SP(sp)
> +
> + /* Disable user memory access and floating/vector computing */
> + li t0, SR_SUM | SR_FS_VS
> + csrc CSR_STATUS, t0
> +
> + load_global_pointer
> + scs_load_sse_stack a7
> +
> + /* Restore current task struct from __sse_entry_task */
> + li t1, NR_CPUS
> + move t3, zero
> +
> +#ifdef CONFIG_SMP
> + /* Find the CPU id associated to the hart id */
> + la t0, __cpuid_to_hartid_map
> +.Lhart_id_loop:
> + REG_L t2, 0(t0)
> + beq t2, a6, .Lcpu_id_found
> +
> + /* Increment pointer and CPU number */
> + addi t3, t3, 1
> + addi t0, t0, RISCV_SZPTR
> + bltu t3, t1, .Lhart_id_loop
> +
> + /*
> + * This should never happen since we expect the hart_id to match one
> + * of our CPU, but better be safe than sorry
> + */
> + la tp, init_task
> + la a0, sse_hart_id_panic_string
> + la t0, panic
> + jalr t0
> +
> +.Lcpu_id_found:
> +#endif
> + asm_per_cpu_with_cpu t2 __sse_entry_task t1 t3
> + REG_L tp, 0(t2)
> +
> + move a1, sp /* pt_regs on stack */
> + /* Kernel was interrupted, create stack frame */
> + beqz s1, .Lcall_do_sse
> +
> +.Lcall_do_sse:
> + /*
> + * Save sscratch for restoration since we might have interrupted the
> + * kernel in early exception path and thus, we don't know the content =
of
> + * sscratch.
> + */
> + csrr s4, CSR_SSCRATCH
> + /* In-kernel scratch is 0 */
> + csrw CSR_SCRATCH, x0
> +
> + move a0, a7
> +
> + call do_sse
> +
> + csrw CSR_SSCRATCH, s4
> +
> + REG_L a0, PT_EPC(sp)
> + REG_L a1, PT_STATUS(sp)
> + REG_L a2, PT_BADADDR(sp)
> + REG_L a3, PT_CAUSE(sp)
> + csrw CSR_EPC, a0
> + csrw CSR_SSTATUS, a1
> + csrw CSR_STVAL, a2
> + csrw CSR_SCAUSE, a3
> +
> + REG_L ra, PT_RA(sp)
> + REG_L s0, PT_S0(sp)
> + REG_L s1, PT_S1(sp)
> + REG_L s2, PT_S2(sp)
> + REG_L s3, PT_S3(sp)
> + REG_L s4, PT_S4(sp)
> + REG_L s5, PT_S5(sp)
> + REG_L s6, PT_S6(sp)
> + REG_L s7, PT_S7(sp)
> + REG_L s8, PT_S8(sp)
> + REG_L s9, PT_S9(sp)
> + REG_L s10, PT_S10(sp)
> + REG_L s11, PT_S11(sp)
> + REG_L tp, PT_TP(sp)
> + REG_L t0, PT_T0(sp)
> + REG_L t1, PT_T1(sp)
> + REG_L t2, PT_T2(sp)
> + REG_L t3, PT_T3(sp)
> + REG_L t4, PT_T4(sp)
> + REG_L t5, PT_T5(sp)
> + REG_L t6, PT_T6(sp)
> + REG_L gp, PT_GP(sp)
> + REG_L a0, PT_A0(sp)
> + REG_L a1, PT_A1(sp)
> + REG_L a2, PT_A2(sp)
> + REG_L a3, PT_A3(sp)
> + REG_L a4, PT_A4(sp)
> + REG_L a5, PT_A5(sp)
> +
> + REG_L sp, PT_SP(sp)
> +
> + li a7, SBI_EXT_SSE
> + li a6, SBI_SSE_EVENT_COMPLETE
> + ecall
> +
> +SYM_CODE_END(handle_sse)
> +
> +sse_hart_id_panic_string:
> +    .ascii "Unable to match hart_id with cpu\0"
> --=20
> 2.45.2
>=20


