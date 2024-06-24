Return-Path: <linux-kernel+bounces-227796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EB79156A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF33E1F2312B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FA722615;
	Mon, 24 Jun 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dt2VRmtd"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457D107A0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254957; cv=none; b=dI/hOcgzvnN6DKM4GmXrUt23EOiI1PnT5J81Xx6k3358IJR2oVmN7fRW9DCjHgrNA5hi0ofNOGSndpBX2AFz5Pd21aiz9GHAgylOa05PFeEO+pFZBCKIygeDXt6zfwBRleW/arEv4fibWA1qOAsU1V/6kn2vvG6jb9XY+QM53EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254957; c=relaxed/simple;
	bh=I7XOYUx7oUv2pE47ElW/osIq9ittdXzigNpLZSURXPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udy6K/l7HrxcAkPOZcNV7EpZqeHn8qw1UznAJsDy5ROD6sZaHSXggU+P/APybQioTVW+ZSDioycWO3Kz+VW9WfgQbD5h1sb5iB/z+E/5NG/Z606nMd/YK3SxCmVn/qnZka99pXo8n4KQncoacF5xxo4W8gbW33Sm6WBz1abSfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dt2VRmtd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7066cba4ebbso1399996b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719254954; x=1719859754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXv5fTLeV2l8Cjtpvu8snH7tYxk20NhHSNWHbcWNWfM=;
        b=dt2VRmtdC5CCdM7bc65lYJR1qyGvZRNsnjsc+mxiT7mDAKZv5Yt/2O938Ghy/WhUOP
         V+egIGv2oE33vLBZVQCrUjE5jRF26/4UhxghH0FlDLq5KX8iGSAhSUTDOLwd364amerJ
         2mTe/xhQea16Pd6N1h5dAbnCfc0Rf1L8rBuPzHtBQDssJ3Ed5TukJyAMKFa36Tm/S2b/
         cRYe1xZmGtXvMmt2PC7/GLB5SXW7StQDZXMPYOdZyRO+7iWlfrG1nnMOAdN7JTWFHr4q
         SEqx7TBXIW5HEi1DgLNUKKVzo8CIdRYyLwiqseCdzSiFycjnoiV2ac6JGrBIFtWXOwim
         a8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719254954; x=1719859754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXv5fTLeV2l8Cjtpvu8snH7tYxk20NhHSNWHbcWNWfM=;
        b=YBf0qJ7AMOM62ui93V4qGLx4v9ofdXD5eeblpx/6ByJrTNS4NnHiyMn9BoilR9ipr/
         TicNTe3ztWPPILXeC98zmKdeAic0bnUczMIiv0/crSZS2heW3UBtNomddw3p0de/6e96
         XGLrtelrmy9HltHyUBmyue5tEd9v4faiJGtQmrgcn7kSY9IOy908ZFjOVpO52ufAhzGQ
         MXyDfoDDaFZAwA27jgYiQHid16uLPG8B+Dfp3K/OrVm74B/Vau9zdiIq+xP0SiCiX7wx
         gt87rbF7IkY7GhayC5fErQVDxBpN/MYiea2D4KwttgAwfR+aGjiaQ/SNwlKWKAozZdF/
         JxUw==
X-Forwarded-Encrypted: i=1; AJvYcCX2gptKKDlQ6KCLb3N6n62FiLI0UQYFAdeEVNQNDlWYVz7grRd+BS3ZUHiHCTqWCmJyOPNprt1HXZu/I7UDZNDQBQtoiw7CP3np6po6
X-Gm-Message-State: AOJu0Yxs2er5/OaYBnownbJ3KWfPGSQRTtRYfx4Bd2j+t5D/7LjfPw1/
	0QcoQLPH/RsYOsgXMwJWkq9cnFTl89a7tMoXOw0buXkdhtwi/g7mLaWTQRpKhvo=
X-Google-Smtp-Source: AGHT+IFAl4zjgOwZgfMgmlWaiUnJiW+uHfsZNX318jpNMNmDdLqbsP3JJ49XveytQZHiY1OLlhiZvA==
X-Received: by 2002:a05:6a20:4701:b0:1b4:772d:2892 with SMTP id adf61e73a8af0-1bcee7323b9mr5009947637.32.1719254954106;
        Mon, 24 Jun 2024 11:49:14 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5bf9sm66060955ad.122.2024.06.24.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:49:13 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:49:11 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anton Blanchard <antonb@tenstorrent.com>,
	Cyril Bur <cyrilbur@tenstorrent.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] riscv: convert bottom half of exception handling to C
Message-ID: <Znm/p4yw49e8ydW7@ghost>
References: <20240616170553.2832-1-jszhang@kernel.org>
 <20240616170553.2832-4-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616170553.2832-4-jszhang@kernel.org>

On Mon, Jun 17, 2024 at 01:05:50AM +0800, Jisheng Zhang wrote:
> For readability, maintainability and future scalability, convert the
> bottom half of the exception handling to C.

I would be interested to see the performance impact of this, since this
mostly eliminates the code from patch 1 and replaces it in C.
Anton/Cyril can you share the test case you used so that these changes
can also be benchmarked?

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
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/errata/sifive/errata.c       | 25 ++++++++---
>  arch/riscv/include/asm/asm-prototypes.h |  1 +
>  arch/riscv/include/asm/errata_list.h    |  5 +--
>  arch/riscv/kernel/entry.S               | 58 +------------------------
>  arch/riscv/kernel/traps.c               | 41 +++++++++++++++++
>  5 files changed, 64 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
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
>  	char name[32];
>  	bool (*check_func)(unsigned long  arch_id, unsigned long impid);
> @@ -20,6 +25,9 @@ struct errata_info_t {
>  
>  static bool errata_cip_453_check_func(unsigned long  arch_id, unsigned long impid)
>  {
> +	if (!IS_ENABLED(CONFIG_ERRATA_SIFIVE_CIP_453))
> +		return false;
> +
>  	/*
>  	 * Affected cores:
>  	 * Architecture ID: 0x8000000000000007
> @@ -51,10 +59,6 @@ static bool errata_cip_1200_check_func(unsigned long  arch_id, unsigned long imp
>  }
>  
>  static struct errata_info_t errata_list[ERRATA_SIFIVE_NUMBER] = {
> -	{
> -		.name = "cip-453",
> -		.check_func = errata_cip_453_check_func
> -	},
>  	{
>  		.name = "cip-1200",
>  		.check_func = errata_cip_1200_check_func
> @@ -62,11 +66,20 @@ static struct errata_info_t errata_list[ERRATA_SIFIVE_NUMBER] = {
>  };
>  
>  static u32 __init_or_module sifive_errata_probe(unsigned long archid,
> -						unsigned long impid)
> +						unsigned long impid,
> +						unsigned int stage)
>  {
>  	int idx;
>  	u32 cpu_req_errata = 0;
>  
> +	if (stage == RISCV_ALTERNATIVES_BOOT) {
> +		if (IS_ENABLED(CONFIG_MMU) &&
> +		    errata_cip_453_check_func(archid, impid)) {
> +			excp_vect_table[EXC_INST_ACCESS] = sifive_cip_453_insn_fault_trp;
> +			excp_vect_table[EXC_INST_PAGE_FAULT] = sifive_cip_453_page_fault_trp;
> +		}
> +	}
> +
>  	for (idx = 0; idx < ERRATA_SIFIVE_NUMBER; idx++)
>  		if (errata_list[idx].check_func(archid, impid))
>  			cpu_req_errata |= (1U << idx);
> @@ -99,7 +112,7 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>  		return;
>  
> -	cpu_req_errata = sifive_errata_probe(archid, impid);
> +	cpu_req_errata = sifive_errata_probe(archid, impid, stage);
>  
>  	for (alt = begin; alt < end; alt++) {
>  		if (alt->vendor_id != SIFIVE_VENDOR_ID)
> diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
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
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 7c8a71a526a3..95b79afc4061 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -17,9 +17,8 @@
>  #endif
>  
>  #ifdef CONFIG_ERRATA_SIFIVE
> -#define	ERRATA_SIFIVE_CIP_453 0
> -#define	ERRATA_SIFIVE_CIP_1200 1
> -#define	ERRATA_SIFIVE_NUMBER 2
> +#define	ERRATA_SIFIVE_CIP_1200 0
> +#define	ERRATA_SIFIVE_NUMBER 1
>  #endif
>  
>  #ifdef CONFIG_ERRATA_THEAD
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 81dec627a8d4..401bfe85a098 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -62,13 +62,11 @@ SYM_CODE_START(handle_exception)
>  	csrrc s1, CSR_STATUS, t0
>  	csrr s2, CSR_EPC
>  	csrr s3, CSR_TVAL
> -	csrr s4, CSR_CAUSE
>  	csrr s5, CSR_SCRATCH
>  	REG_S s0, PT_SP(sp)
>  	REG_S s1, PT_STATUS(sp)
>  	REG_S s2, PT_EPC(sp)
>  	REG_S s3, PT_BADADDR(sp)
> -	REG_S s4, PT_CAUSE(sp)
>  	REG_S s5, PT_TP(sp)
>  
>  	/*
> @@ -83,36 +81,9 @@ SYM_CODE_START(handle_exception)
>  	/* Load the kernel shadow call stack pointer if coming from userspace */
>  	scs_load_current_if_task_changed s5
>  
> -#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
> -	move a0, sp
> -	call riscv_v_context_nesting_start
> -#endif
>  	move a0, sp /* pt_regs */
> -
> -	/*
> -	 * MSB of cause differentiates between
> -	 * interrupts and exceptions
> -	 */
> -	bge s4, zero, 1f
> -
> -	/* Handle interrupts */
> -	call do_irq
> -	j ret_from_exception
> -1:
> -	/* Handle other exceptions */
> -	slli t0, s4, RISCV_LGPTR
> -	la t1, excp_vect_table
> -	la t2, excp_vect_table_end
> -	add t0, t1, t0
> -	/* Check if exception code lies within bounds */
> -	bgeu t0, t2, 3f
> -	REG_L t1, 0(t0)
> -2:	jalr t1
> +	call do_traps
>  	j ret_from_exception
> -3:
> -
> -	la t1, do_trap_unknown
> -	j 2b
>  SYM_CODE_END(handle_exception)
>  ASM_NOKPROBE(handle_exception)
>  
> @@ -329,33 +300,6 @@ SYM_FUNC_START(__switch_to)
>  	ret
>  SYM_FUNC_END(__switch_to)
>  
> -#ifndef CONFIG_MMU
> -#define do_page_fault do_trap_unknown
> -#endif
> -
> -	.section ".rodata"
> -	.align LGREG
> -	/* Exception vector table */
> -SYM_DATA_START_LOCAL(excp_vect_table)
> -	RISCV_PTR do_trap_insn_misaligned
> -	ALT_INSN_FAULT(RISCV_PTR do_trap_insn_fault)
> -	RISCV_PTR do_trap_insn_illegal
> -	RISCV_PTR do_trap_break
> -	RISCV_PTR do_trap_load_misaligned
> -	RISCV_PTR do_trap_load_fault
> -	RISCV_PTR do_trap_store_misaligned
> -	RISCV_PTR do_trap_store_fault
> -	RISCV_PTR do_trap_ecall_u /* system call */
> -	RISCV_PTR do_trap_ecall_s
> -	RISCV_PTR do_trap_unknown
> -	RISCV_PTR do_trap_ecall_m
> -	/* instruciton page fault */
> -	ALT_PAGE_FAULT(RISCV_PTR do_page_fault)
> -	RISCV_PTR do_page_fault   /* load page fault */
> -	RISCV_PTR do_trap_unknown
> -	RISCV_PTR do_page_fault   /* store page fault */
> -SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
> -
>  #ifndef CONFIG_MMU
>  SYM_DATA_START(__user_rt_sigreturn)
>  	li a7, __NR_rt_sigreturn
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 05a16b1f0aee..b44d4a8d4083 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -390,6 +390,47 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
>  	irqentry_exit(regs, state);
>  }
>  
> +void (*excp_vect_table[])(struct pt_regs *regs) __ro_after_init = {
> +	do_trap_insn_misaligned,	/*  0 Instruction address misaligned */
> +	do_trap_insn_fault,		/*  1 Instruction access fault */
> +	do_trap_insn_illegal,		/*  2 Illegal instruction */
> +	do_trap_break,			/*  3 Breakpoint */
> +	do_trap_load_misaligned,	/*  4 Load address misaligned */
> +	do_trap_load_fault,		/*  5 Load access fault */
> +	do_trap_store_misaligned,	/*  6 Store/AMO address misaligned */
> +	do_trap_store_fault,		/*  7 Store/AMO access fault */
> +	do_trap_ecall_u,		/*  8 Environment call from U-mode */
> +	do_trap_ecall_s,		/*  9 Environment call from S-mode */
> +	do_trap_unknown,		/* 10 Reserved */
> +	do_trap_ecall_m,		/* 11 Environment call from M-mode */
> +#ifdef CONFIG_MMU
> +	do_page_fault,			/* 12 Instruciton page fault */
> +	do_page_fault,			/* 13 Load page fault */
> +	do_trap_unknown,		/* 14 Reserved */
> +	do_page_fault,			/* 15 Store/AMO page fault */
> +#endif
> +};
> +
> +asmlinkage void noinstr do_traps(struct pt_regs *regs)
> +{
> +	unsigned long cause = csr_read(CSR_CAUSE);
> +
> +	regs->cause = cause;
> +
> +#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
> +	riscv_v_context_nesting_start(regs);
> +#endif
> +	if (cause & CAUSE_IRQ_FLAG) {
> +		do_irq(regs);
> +	} else {
> +		if (cause >= ARRAY_SIZE(excp_vect_table)) {

Using unlikely here may optimize the hotpath here slightly.

- Charlie

> +			do_trap_unknown(regs);
> +			return;
> +		}
> +		excp_vect_table[cause](regs);
> +	}
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

