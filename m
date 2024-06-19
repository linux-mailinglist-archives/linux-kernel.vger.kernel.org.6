Return-Path: <linux-kernel+bounces-221871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4971A90F9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC3BB223FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7913BC35;
	Wed, 19 Jun 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="eXQ0Bv6m"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2C1E515
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841002; cv=none; b=YQPfm3r4If92hoELFg5SAXpulYhqupz1kvB24bDAalp7JBMrLO/XZQ9oEq7Ljk1MIWp0iJZxbLPIpiQiYT4PvcYIuvM9hLLOcv2/3rkRrEwl2HTXHGpwfjk9SNAd3hkebFtSE78gVag8QQpP30KcwFnFLQM/mt2QcmfIyYjRWW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841002; c=relaxed/simple;
	bh=8klFrfzkaF26Rqu+ukhyohIDOf7WPJGvzXByzPqQVi8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ir4IyGP8KWdgys5+AwgNgfYXuGisc+1Le7awizOi3hJ0Sk93cbsDp7p4HB5mgBPot0WcMCqrjw6OvSG055YMUIfGotEp0rVudOgVxaBl2ivkOzKNbQQO8EDrOM5VoycNPlg62jmmcPirX76w1ibShtOKEJN2FHObTBKQevDt8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=eXQ0Bv6m; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c7e46f549dso40333a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718841000; x=1719445800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bfFZAra+1fXqERkdfob+IZYD3tlGFaCOXNt2lG5GwtU=;
        b=eXQ0Bv6mxUnBoX4DwVwxhwM4wP4T3BMdIbEBBMxKlf/+bcmAtt2PlydHZbSqU1ZMKY
         j4x8SBsQfDFSAoLR3cbBOydpF/vSr2upaD0VZ3l4/pJSOXHW0N8ObWxe2C+EEa+Jsif4
         zQ22YzHw5Ely52jawp41nKWEnVOHBHTDe+Aq1kKoMVSnQ+4lfTgYCGmcWFbJxcxRsYjb
         70xj08tVoPEgwaDj3U5Krz1u+6crr18QKlzy5nxAYL8FLdRUK9KEDqth+HSrkPVVzEoJ
         YK5Gus8Z3swp3NYe0aS66j+d920nxkb2MdenE+8+o3JY2RX/41h8j0QM9fXK0eceiKKj
         lA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841000; x=1719445800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfFZAra+1fXqERkdfob+IZYD3tlGFaCOXNt2lG5GwtU=;
        b=fHwRwrq6gi+X9DzTGwCHk/IRBNNPZ7lidG/YEqlEoL+1G78Z126WdOjf4+M7/ePDMb
         /BIs8nKI2vV8cDMCuiRHXwLiyvKz25iBf6TwOerZpzIzAvKl7TvcszbAKtShLAtUcf9i
         hm9pOCsm5OmrrKvC2GRLgAdeJlS0jtPRlIziadwSlUQTSss9IngM7mwX/MZU82XBYKmU
         g7ANS8vYmvZclzdius0/lcorwLTK8C4TcmW/Pxfxucp4Lh2XBcYpW8m+8mFOHWACbvbi
         LqXp6ccl/ivsq0lt6cB/qcroq/94AA9wm7uItsJsR9bfGbplSB0Q/rQ58cgzm3oJevN+
         GBXw==
X-Forwarded-Encrypted: i=1; AJvYcCVOvOV7Cw+hxkDLLvIHzbWhFZTNhvWqAU6Y9qCy6nXDdZnoA/o8cpftd0ztYevOr4v6gTOUIk8Ewl/uMWGRFzFfq0Vt3J7MCgv3NBnZ
X-Gm-Message-State: AOJu0YwCaXCqNOdg65p78SbfN4LkzimjrDr0TQo2d0iAQFnHJXHYFywG
	lWllR35Axp07qsOyRDPsu0k/k+uaLPzsWnHHlbB7NT+IVmEuscmfnV+grnxvvOHZSz3OEc/VTYu
	kMqCY0feY5+oJh/6xOPDoPrfyT1DpihJ8krT4
X-Google-Smtp-Source: AGHT+IFBB6SUBJIBVp84ijUL67VPTYhaPRD6uRiUYzcmPYLoB7ShynwM2bUSgGlJDZsceaA+n4qRYrt3c3oq110MHfs=
X-Received: by 2002:a05:6a20:12d2:b0:1ba:e88c:c512 with SMTP id
 adf61e73a8af0-1bcbb73740amr3925598637.3.1718840999808; Wed, 19 Jun 2024
 16:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cyril Bur <cyrilbur@tenstorrent.com>
Date: Thu, 20 Jun 2024 09:49:48 +1000
Message-ID: <CANtDSipbOuhcFhbkHi9m8-v9Z3EOBos_2Ek1A1BL4pK4rjPAKw@mail.gmail.com>
Subject: Re: [PATCH 3/6] riscv: convert bottom half of exception handling to C
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:21=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> For readability, maintainability and future scalability, convert the
> bottom half of the exception handling to C.
>
> Mostly the assembly code is converted to C in a relatively
> straightforward manner.
>
> However, there are two modifications I need to mention:
>
> 1. the CSR_CAUSE reg reading and saving is moved to the C code
> because we need the cause to dispatch the exception handling,
> if we keep the cause reading and saving, we either pass it to
> do_traps() via. 2nd param or get it from pt_regs which an extra
> memory load is needed, I don't like any of the two solutions becase
> the exception handling sits in hot code path, every instruction
> matters.
>
> 2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
> alternative mechanism any more after the asm->c convertion. Just
> replace the excp_vect_table two entries.
>

HI Jisheng,

Patch looks great. I've been going through to understand, this is more
a learning exercise for me than anything else.
I have a question though.

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/errata/sifive/errata.c       | 25 ++++++++---
>  arch/riscv/include/asm/asm-prototypes.h |  1 +
>  arch/riscv/include/asm/errata_list.h    |  5 +--
>  arch/riscv/kernel/entry.S               | 58 +------------------------
>  arch/riscv/kernel/traps.c               | 41 +++++++++++++++++
>  5 files changed, 64 insertions(+), 66 deletions(-)
>
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive=
/errata.c
> index 716cfedad3a2..bbba99f207ca 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -10,9 +10,14 @@
>  #include <linux/bug.h>
>  #include <asm/patch.h>
>  #include <asm/alternative.h>
> +#include <asm/csr.h>
>  #include <asm/vendorid_list.h>
>  #include <asm/errata_list.h>
>
> +extern void (*excp_vect_table[])(struct pt_regs *regs);
> +extern void sifive_cip_453_insn_fault_trp(struct pt_regs *regs);
> +extern void sifive_cip_453_page_fault_trp(struct pt_regs *regs);
> +
>  struct errata_info_t {
>         char name[32];
>         bool (*check_func)(unsigned long  arch_id, unsigned long impid);
> @@ -20,6 +25,9 @@ struct errata_info_t {
>
>  static bool errata_cip_453_check_func(unsigned long  arch_id, unsigned l=
ong impid)
>  {
> +       if (!IS_ENABLED(CONFIG_ERRATA_SIFIVE_CIP_453))
> +               return false;
> +
>         /*
>          * Affected cores:
>          * Architecture ID: 0x8000000000000007
> @@ -51,10 +59,6 @@ static bool errata_cip_1200_check_func(unsigned long  =
arch_id, unsigned long imp
>  }
>
>  static struct errata_info_t errata_list[ERRATA_SIFIVE_NUMBER] =3D {
> -       {
> -               .name =3D "cip-453",
> -               .check_func =3D errata_cip_453_check_func
> -       },
>         {
>                 .name =3D "cip-1200",
>                 .check_func =3D errata_cip_1200_check_func
> @@ -62,11 +66,20 @@ static struct errata_info_t errata_list[ERRATA_SIFIVE=
_NUMBER] =3D {
>  };
>
>  static u32 __init_or_module sifive_errata_probe(unsigned long archid,
> -                                               unsigned long impid)
> +                                               unsigned long impid,
> +                                               unsigned int stage)
>  {
>         int idx;
>         u32 cpu_req_errata =3D 0;
>
> +       if (stage =3D=3D RISCV_ALTERNATIVES_BOOT) {
> +               if (IS_ENABLED(CONFIG_MMU) &&
> +                   errata_cip_453_check_func(archid, impid)) {
> +                       excp_vect_table[EXC_INST_ACCESS] =3D sifive_cip_4=
53_insn_fault_trp;
> +                       excp_vect_table[EXC_INST_PAGE_FAULT] =3D sifive_c=
ip_453_page_fault_trp;
> +               }
> +       }
> +
>         for (idx =3D 0; idx < ERRATA_SIFIVE_NUMBER; idx++)
>                 if (errata_list[idx].check_func(archid, impid))
>                         cpu_req_errata |=3D (1U << idx);
> @@ -99,7 +112,7 @@ void sifive_errata_patch_func(struct alt_entry *begin,=
 struct alt_entry *end,
>         if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
>                 return;
>
> -       cpu_req_errata =3D sifive_errata_probe(archid, impid);
> +       cpu_req_errata =3D sifive_errata_probe(archid, impid, stage);
>
>         for (alt =3D begin; alt < end; alt++) {
>                 if (alt->vendor_id !=3D SIFIVE_VENDOR_ID)
> diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include=
/asm/asm-prototypes.h
> index cd627ec289f1..81a1f27fa54f 100644
> --- a/arch/riscv/include/asm/asm-prototypes.h
> +++ b/arch/riscv/include/asm/asm-prototypes.h
> @@ -55,5 +55,6 @@ DECLARE_DO_ERROR_INFO(do_trap_break);
>  asmlinkage void handle_bad_stack(struct pt_regs *regs);
>  asmlinkage void do_page_fault(struct pt_regs *regs);
>  asmlinkage void do_irq(struct pt_regs *regs);
> +asmlinkage void do_traps(struct pt_regs *regs);
>
>  #endif /* _ASM_RISCV_PROTOTYPES_H */
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index 7c8a71a526a3..95b79afc4061 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -17,9 +17,8 @@
>  #endif
>
>  #ifdef CONFIG_ERRATA_SIFIVE
> -#define        ERRATA_SIFIVE_CIP_453 0
> -#define        ERRATA_SIFIVE_CIP_1200 1
> -#define        ERRATA_SIFIVE_NUMBER 2
> +#define        ERRATA_SIFIVE_CIP_1200 0
> +#define        ERRATA_SIFIVE_NUMBER 1
>  #endif
>
>  #ifdef CONFIG_ERRATA_THEAD
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 81dec627a8d4..401bfe85a098 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -62,13 +62,11 @@ SYM_CODE_START(handle_exception)
>         csrrc s1, CSR_STATUS, t0
>         csrr s2, CSR_EPC
>         csrr s3, CSR_TVAL
> -       csrr s4, CSR_CAUSE
>         csrr s5, CSR_SCRATCH
>         REG_S s0, PT_SP(sp)
>         REG_S s1, PT_STATUS(sp)
>         REG_S s2, PT_EPC(sp)
>         REG_S s3, PT_BADADDR(sp)
> -       REG_S s4, PT_CAUSE(sp)
>         REG_S s5, PT_TP(sp)
>
>         /*
> @@ -83,36 +81,9 @@ SYM_CODE_START(handle_exception)
>         /* Load the kernel shadow call stack pointer if coming from users=
pace */
>         scs_load_current_if_task_changed s5
>
> -#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
> -       move a0, sp
> -       call riscv_v_context_nesting_start
> -#endif

Along with removing this, can the asmlinkage in asm-prototypes.h be removed=
?
Or are you keeping the _start() in because the _end() needs to stay?

That leads me to think about leaving the call to
riscv_context_nesting_start() in asm
here for the symmetry of _start() and _end() being called from entry.S.

>         move a0, sp /* pt_regs */
> -
> -       /*
> -        * MSB of cause differentiates between
> -        * interrupts and exceptions
> -        */
> -       bge s4, zero, 1f
> -
> -       /* Handle interrupts */
> -       call do_irq
> -       j ret_from_exception
> -1:
> -       /* Handle other exceptions */
> -       slli t0, s4, RISCV_LGPTR
> -       la t1, excp_vect_table
> -       la t2, excp_vect_table_end
> -       add t0, t1, t0
> -       /* Check if exception code lies within bounds */
> -       bgeu t0, t2, 3f
> -       REG_L t1, 0(t0)
> -2:     jalr t1
> +       call do_traps
>         j ret_from_exception
> -3:
> -
> -       la t1, do_trap_unknown
> -       j 2b
>  SYM_CODE_END(handle_exception)
>  ASM_NOKPROBE(handle_exception)
>
> @@ -329,33 +300,6 @@ SYM_FUNC_START(__switch_to)
>         ret
>  SYM_FUNC_END(__switch_to)
>
> -#ifndef CONFIG_MMU
> -#define do_page_fault do_trap_unknown
> -#endif
> -
> -       .section ".rodata"
> -       .align LGREG
> -       /* Exception vector table */
> -SYM_DATA_START_LOCAL(excp_vect_table)
> -       RISCV_PTR do_trap_insn_misaligned
> -       ALT_INSN_FAULT(RISCV_PTR do_trap_insn_fault)
> -       RISCV_PTR do_trap_insn_illegal
> -       RISCV_PTR do_trap_break
> -       RISCV_PTR do_trap_load_misaligned
> -       RISCV_PTR do_trap_load_fault
> -       RISCV_PTR do_trap_store_misaligned
> -       RISCV_PTR do_trap_store_fault
> -       RISCV_PTR do_trap_ecall_u /* system call */
> -       RISCV_PTR do_trap_ecall_s
> -       RISCV_PTR do_trap_unknown
> -       RISCV_PTR do_trap_ecall_m
> -       /* instruciton page fault */
> -       ALT_PAGE_FAULT(RISCV_PTR do_page_fault)
> -       RISCV_PTR do_page_fault   /* load page fault */
> -       RISCV_PTR do_trap_unknown
> -       RISCV_PTR do_page_fault   /* store page fault */
> -SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
> -
>  #ifndef CONFIG_MMU
>  SYM_DATA_START(__user_rt_sigreturn)
>         li a7, __NR_rt_sigreturn
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 05a16b1f0aee..b44d4a8d4083 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -390,6 +390,47 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
>         irqentry_exit(regs, state);
>  }
>
> +void (*excp_vect_table[])(struct pt_regs *regs) __ro_after_init =3D {
> +       do_trap_insn_misaligned,        /*  0 Instruction address misalig=
ned */
> +       do_trap_insn_fault,             /*  1 Instruction access fault */
> +       do_trap_insn_illegal,           /*  2 Illegal instruction */
> +       do_trap_break,                  /*  3 Breakpoint */
> +       do_trap_load_misaligned,        /*  4 Load address misaligned */
> +       do_trap_load_fault,             /*  5 Load access fault */
> +       do_trap_store_misaligned,       /*  6 Store/AMO address misaligne=
d */
> +       do_trap_store_fault,            /*  7 Store/AMO access fault */
> +       do_trap_ecall_u,                /*  8 Environment call from U-mod=
e */
> +       do_trap_ecall_s,                /*  9 Environment call from S-mod=
e */
> +       do_trap_unknown,                /* 10 Reserved */
> +       do_trap_ecall_m,                /* 11 Environment call from M-mod=
e */
> +#ifdef CONFIG_MMU
> +       do_page_fault,                  /* 12 Instruciton page fault */
> +       do_page_fault,                  /* 13 Load page fault */
> +       do_trap_unknown,                /* 14 Reserved */
> +       do_page_fault,                  /* 15 Store/AMO page fault */
> +#endif
> +};
> +
> +asmlinkage void noinstr do_traps(struct pt_regs *regs)
> +{
> +       unsigned long cause =3D csr_read(CSR_CAUSE);
> +
> +       regs->cause =3D cause;
> +
> +#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
> +       riscv_v_context_nesting_start(regs);
> +#endif
> +       if (cause & CAUSE_IRQ_FLAG) {
> +               do_irq(regs);
> +       } else {
> +               if (cause >=3D ARRAY_SIZE(excp_vect_table)) {
> +                       do_trap_unknown(regs);
> +                       return;
> +               }
> +               excp_vect_table[cause](regs);
> +       }
> +}
> +
>  #ifdef CONFIG_GENERIC_BUG
>  int is_valid_bugaddr(unsigned long pc)
>  {
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

