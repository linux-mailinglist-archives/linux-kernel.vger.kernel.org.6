Return-Path: <linux-kernel+bounces-228058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2273915A44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2F01F24501
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FF81A2568;
	Mon, 24 Jun 2024 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="KXX4mSB6"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DC219FA92
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719270610; cv=none; b=kG0KdAUBJSYi2bVTcUgAF56pfdnVGb028+qwPssWS50xh/+UxmTxECqzrEVGk7Jn9MPRgGk2aFqR0x/sqMWoQYoSWce0Se4pB8tWm+tVhABBReMnw+Osgn5m1/C78FCk2Nfit5uVpeTfJdHeCYcaHI0B+NsiZANNPt4jdGv3vEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719270610; c=relaxed/simple;
	bh=kPlbiTmZWaUT4DsN/ADREKE1l/54/0YxCIpFu84I57c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLHx/9uvLY7jZwB8AogaBWb/80mK/Wj7ijpD60p2YWpfrchkpAp5eA2dPATyW1N0VSkNk+m9Y7DJuuqsZb4ws1bosVDYylRbPdGazj7Wb7wKoocrznZgxWeKLO3E0Y0MWuqRKChAbOgUQR4Y7yensMj09ZaJdsS8KyQZWaXXMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=KXX4mSB6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c70c65ca5eso855645a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1719270608; x=1719875408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z12W7bYjq/I0j7BT73TFDTeojIsVunyLNslVLjDM0nw=;
        b=KXX4mSB6p1GIZpLzo18lNYFvIrV44hxsEA357nV17Rbwa/LqdIqb8UpDVOu5tmHXCm
         J9QEP1cCvVxNQDLSF9l+ZAaT+mmkJasRIP40RD54LFaOPfVGVYIXZQfD46/4VgLPDjfz
         CqMfpYUMEqAIypmDuc2dg7ZZiv5yhiQRgr0mjs4oMP8aQQ1es66U1DpsMicWaeO78A1N
         /SgEIRpK/r14QMatR3phwe9XwJTxXN3M9VkpdjallmHhotE6rNZkMxgOBHV1uyhmoGdy
         oDVrvj5HY7Jr0VyZPIoBJiPxXmjX0IYZIO+ly3j+X+HzmwNyI72fFFYDpz89ZrRFsYGW
         Xz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719270608; x=1719875408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z12W7bYjq/I0j7BT73TFDTeojIsVunyLNslVLjDM0nw=;
        b=ZwWk8LBBWglJkAKobXDZi92jP+8DM0C0cb63MhYSXixHlTWYziBO0O6wcYXPCN32Tx
         pzc14dgkKP8DesgNyp9XhXqr54ycHijv2fP6jO3SMfDxH8lAWv8Pwr2P0rWY/E64cRVg
         CrBAu/e8dMmWfPHodl/vg2lqnLFRs9KHuLqef65bqBioTjAxJhYdxvCaWI/eHWpwOEhl
         ncayc7P04HGJgIbaih6RNaFoteIwN7TqoqpKDFAHxObRsFycq9MMCdzaKLUVyfJOZl8Q
         sG928VS2CzZeo6DJ3YvgIioe5imA54cGD9lDWStJSXoOwwEqC0HkC6+63oJkWlJQBlfn
         6Edg==
X-Forwarded-Encrypted: i=1; AJvYcCWR03JyzYAqnUUefVjObl/FJAqes5YWWcwUKSahgGXfCt3476n+rVUt6Vh6oXfGyYbIdkD8m+zItxllM5aj3fKO0WSVc71GiGk1c19z
X-Gm-Message-State: AOJu0Yy7LdSzgBib40SeE8jaSbVWPzarj5ylhilAgSBN14zdQkQbuh6q
	ACRBHctZuJ+Hc4+uWIqyUQRlzWcPrYNMcU080r2YXuz1/kp9qXw63Xaq2j9MIA==
X-Google-Smtp-Source: AGHT+IE4RDeRw39GrmtYqnBgQqmFU1GizvUrLUHe33nwfuuqCM1ccLL3aLdqG/VUUFV3ux4YtCIMeQ==
X-Received: by 2002:a05:6a20:9483:b0:1b5:6b5e:c100 with SMTP id adf61e73a8af0-1bcea5f5f95mr7003728637.5.1719270607557;
        Mon, 24 Jun 2024 16:10:07 -0700 (PDT)
Received: from [192.168.50.113] ([27.96.222.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065124e1b8sm6731363b3a.106.2024.06.24.16.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 16:10:07 -0700 (PDT)
Message-ID: <7a64739d-f580-4155-b2c0-c04b260d71cb@tenstorrent.com>
Date: Tue, 25 Jun 2024 09:10:01 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] riscv: convert bottom half of exception handling to C
To: Charlie Jenkins <charlie@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Samuel Holland <samuel.holland@sifive.com>,
 Anton Blanchard <antonb@tenstorrent.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240616170553.2832-1-jszhang@kernel.org>
 <20240616170553.2832-4-jszhang@kernel.org> <Znm/p4yw49e8ydW7@ghost>
Content-Language: en-US
From: Cyril Bur <cyrilbur@tenstorrent.com>
In-Reply-To: <Znm/p4yw49e8ydW7@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/6/2024 4:49 am, Charlie Jenkins wrote:
> On Mon, Jun 17, 2024 at 01:05:50AM +0800, Jisheng Zhang wrote:
>> For readability, maintainability and future scalability, convert the
>> bottom half of the exception handling to C.
> 
> I would be interested to see the performance impact of this, since this
> mostly eliminates the code from patch 1 and replaces it in C.
> Anton/Cyril can you share the test case you used so that these changes
> can also be benchmarked?

I ran the series as a whole and it keeps the performance improvement. I 
think that makes sense because C shouldn't be modifying return addresses.

The benchmark is a tweaked (for obvious reasons) of 
tools/testing/selftests/powerpc/benchmarks/null_syscall.c.

> 
>>
>> Mostly the assembly code is converted to C in a relatively
>> straightforward manner.
>>
>> However, there are two modifications I need to mention:
>>
>> 1. the CSR_CAUSE reg reading and saving is moved to the C code
>> because we need the cause to dispatch the exception handling,
>> if we keep the cause reading and saving, we either pass it to
>> do_traps() via. 2nd param or get it from pt_regs which an extra
>> memory load is needed, I don't like any of the two solutions becase
>> the exception handling sits in hot code path, every instruction
>> matters.
>>
>> 2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
>> alternative mechanism any more after the asm->c convertion. Just
>> replace the excp_vect_table two entries.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>   arch/riscv/errata/sifive/errata.c       | 25 ++++++++---
>>   arch/riscv/include/asm/asm-prototypes.h |  1 +
>>   arch/riscv/include/asm/errata_list.h    |  5 +--
>>   arch/riscv/kernel/entry.S               | 58 +------------------------
>>   arch/riscv/kernel/traps.c               | 41 +++++++++++++++++
>>   5 files changed, 64 insertions(+), 66 deletions(-)
>>
>> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
>> index 716cfedad3a2..bbba99f207ca 100644
>> --- a/arch/riscv/errata/sifive/errata.c
>> +++ b/arch/riscv/errata/sifive/errata.c
>> @@ -10,9 +10,14 @@
>>   #include <linux/bug.h>
>>   #include <asm/patch.h>
>>   #include <asm/alternative.h>
>> +#include <asm/csr.h>
>>   #include <asm/vendorid_list.h>
>>   #include <asm/errata_list.h>
>>   
>> +extern void (*excp_vect_table[])(struct pt_regs *regs);
>> +extern void sifive_cip_453_insn_fault_trp(struct pt_regs *regs);
>> +extern void sifive_cip_453_page_fault_trp(struct pt_regs *regs);
>> +
>>   struct errata_info_t {
>>   	char name[32];
>>   	bool (*check_func)(unsigned long  arch_id, unsigned long impid);
>> @@ -20,6 +25,9 @@ struct errata_info_t {
>>   
>>   static bool errata_cip_453_check_func(unsigned long  arch_id, unsigned long impid)
>>   {
>> +	if (!IS_ENABLED(CONFIG_ERRATA_SIFIVE_CIP_453))
>> +		return false;
>> +
>>   	/*
>>   	 * Affected cores:
>>   	 * Architecture ID: 0x8000000000000007
>> @@ -51,10 +59,6 @@ static bool errata_cip_1200_check_func(unsigned long  arch_id, unsigned long imp
>>   }
>>   
>>   static struct errata_info_t errata_list[ERRATA_SIFIVE_NUMBER] = {
>> -	{
>> -		.name = "cip-453",
>> -		.check_func = errata_cip_453_check_func
>> -	},
>>   	{
>>   		.name = "cip-1200",
>>   		.check_func = errata_cip_1200_check_func
>> @@ -62,11 +66,20 @@ static struct errata_info_t errata_list[ERRATA_SIFIVE_NUMBER] = {
>>   };
>>   
>>   static u32 __init_or_module sifive_errata_probe(unsigned long archid,
>> -						unsigned long impid)
>> +						unsigned long impid,
>> +						unsigned int stage)
>>   {
>>   	int idx;
>>   	u32 cpu_req_errata = 0;
>>   
>> +	if (stage == RISCV_ALTERNATIVES_BOOT) {
>> +		if (IS_ENABLED(CONFIG_MMU) &&
>> +		    errata_cip_453_check_func(archid, impid)) {
>> +			excp_vect_table[EXC_INST_ACCESS] = sifive_cip_453_insn_fault_trp;
>> +			excp_vect_table[EXC_INST_PAGE_FAULT] = sifive_cip_453_page_fault_trp;
>> +		}
>> +	}
>> +
>>   	for (idx = 0; idx < ERRATA_SIFIVE_NUMBER; idx++)
>>   		if (errata_list[idx].check_func(archid, impid))
>>   			cpu_req_errata |= (1U << idx);
>> @@ -99,7 +112,7 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>>   	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>>   		return;
>>   
>> -	cpu_req_errata = sifive_errata_probe(archid, impid);
>> +	cpu_req_errata = sifive_errata_probe(archid, impid, stage);
>>   
>>   	for (alt = begin; alt < end; alt++) {
>>   		if (alt->vendor_id != SIFIVE_VENDOR_ID)
>> diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
>> index cd627ec289f1..81a1f27fa54f 100644
>> --- a/arch/riscv/include/asm/asm-prototypes.h
>> +++ b/arch/riscv/include/asm/asm-prototypes.h
>> @@ -55,5 +55,6 @@ DECLARE_DO_ERROR_INFO(do_trap_break);
>>   asmlinkage void handle_bad_stack(struct pt_regs *regs);
>>   asmlinkage void do_page_fault(struct pt_regs *regs);
>>   asmlinkage void do_irq(struct pt_regs *regs);
>> +asmlinkage void do_traps(struct pt_regs *regs);
>>   
>>   #endif /* _ASM_RISCV_PROTOTYPES_H */
>> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
>> index 7c8a71a526a3..95b79afc4061 100644
>> --- a/arch/riscv/include/asm/errata_list.h
>> +++ b/arch/riscv/include/asm/errata_list.h
>> @@ -17,9 +17,8 @@
>>   #endif
>>   
>>   #ifdef CONFIG_ERRATA_SIFIVE
>> -#define	ERRATA_SIFIVE_CIP_453 0
>> -#define	ERRATA_SIFIVE_CIP_1200 1
>> -#define	ERRATA_SIFIVE_NUMBER 2
>> +#define	ERRATA_SIFIVE_CIP_1200 0
>> +#define	ERRATA_SIFIVE_NUMBER 1
>>   #endif
>>   
>>   #ifdef CONFIG_ERRATA_THEAD
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 81dec627a8d4..401bfe85a098 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -62,13 +62,11 @@ SYM_CODE_START(handle_exception)
>>   	csrrc s1, CSR_STATUS, t0
>>   	csrr s2, CSR_EPC
>>   	csrr s3, CSR_TVAL
>> -	csrr s4, CSR_CAUSE
>>   	csrr s5, CSR_SCRATCH
>>   	REG_S s0, PT_SP(sp)
>>   	REG_S s1, PT_STATUS(sp)
>>   	REG_S s2, PT_EPC(sp)
>>   	REG_S s3, PT_BADADDR(sp)
>> -	REG_S s4, PT_CAUSE(sp)
>>   	REG_S s5, PT_TP(sp)
>>   
>>   	/*
>> @@ -83,36 +81,9 @@ SYM_CODE_START(handle_exception)
>>   	/* Load the kernel shadow call stack pointer if coming from userspace */
>>   	scs_load_current_if_task_changed s5
>>   
>> -#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
>> -	move a0, sp
>> -	call riscv_v_context_nesting_start
>> -#endif
>>   	move a0, sp /* pt_regs */
>> -
>> -	/*
>> -	 * MSB of cause differentiates between
>> -	 * interrupts and exceptions
>> -	 */
>> -	bge s4, zero, 1f
>> -
>> -	/* Handle interrupts */
>> -	call do_irq
>> -	j ret_from_exception
>> -1:
>> -	/* Handle other exceptions */
>> -	slli t0, s4, RISCV_LGPTR
>> -	la t1, excp_vect_table
>> -	la t2, excp_vect_table_end
>> -	add t0, t1, t0
>> -	/* Check if exception code lies within bounds */
>> -	bgeu t0, t2, 3f
>> -	REG_L t1, 0(t0)
>> -2:	jalr t1
>> +	call do_traps
>>   	j ret_from_exception
>> -3:
>> -
>> -	la t1, do_trap_unknown
>> -	j 2b
>>   SYM_CODE_END(handle_exception)
>>   ASM_NOKPROBE(handle_exception)
>>   
>> @@ -329,33 +300,6 @@ SYM_FUNC_START(__switch_to)
>>   	ret
>>   SYM_FUNC_END(__switch_to)
>>   
>> -#ifndef CONFIG_MMU
>> -#define do_page_fault do_trap_unknown
>> -#endif
>> -
>> -	.section ".rodata"
>> -	.align LGREG
>> -	/* Exception vector table */
>> -SYM_DATA_START_LOCAL(excp_vect_table)
>> -	RISCV_PTR do_trap_insn_misaligned
>> -	ALT_INSN_FAULT(RISCV_PTR do_trap_insn_fault)
>> -	RISCV_PTR do_trap_insn_illegal
>> -	RISCV_PTR do_trap_break
>> -	RISCV_PTR do_trap_load_misaligned
>> -	RISCV_PTR do_trap_load_fault
>> -	RISCV_PTR do_trap_store_misaligned
>> -	RISCV_PTR do_trap_store_fault
>> -	RISCV_PTR do_trap_ecall_u /* system call */
>> -	RISCV_PTR do_trap_ecall_s
>> -	RISCV_PTR do_trap_unknown
>> -	RISCV_PTR do_trap_ecall_m
>> -	/* instruciton page fault */
>> -	ALT_PAGE_FAULT(RISCV_PTR do_page_fault)
>> -	RISCV_PTR do_page_fault   /* load page fault */
>> -	RISCV_PTR do_trap_unknown
>> -	RISCV_PTR do_page_fault   /* store page fault */
>> -SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
>> -
>>   #ifndef CONFIG_MMU
>>   SYM_DATA_START(__user_rt_sigreturn)
>>   	li a7, __NR_rt_sigreturn
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index 05a16b1f0aee..b44d4a8d4083 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -390,6 +390,47 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
>>   	irqentry_exit(regs, state);
>>   }
>>   
>> +void (*excp_vect_table[])(struct pt_regs *regs) __ro_after_init = {
>> +	do_trap_insn_misaligned,	/*  0 Instruction address misaligned */
>> +	do_trap_insn_fault,		/*  1 Instruction access fault */
>> +	do_trap_insn_illegal,		/*  2 Illegal instruction */
>> +	do_trap_break,			/*  3 Breakpoint */
>> +	do_trap_load_misaligned,	/*  4 Load address misaligned */
>> +	do_trap_load_fault,		/*  5 Load access fault */
>> +	do_trap_store_misaligned,	/*  6 Store/AMO address misaligned */
>> +	do_trap_store_fault,		/*  7 Store/AMO access fault */
>> +	do_trap_ecall_u,		/*  8 Environment call from U-mode */
>> +	do_trap_ecall_s,		/*  9 Environment call from S-mode */
>> +	do_trap_unknown,		/* 10 Reserved */
>> +	do_trap_ecall_m,		/* 11 Environment call from M-mode */
>> +#ifdef CONFIG_MMU
>> +	do_page_fault,			/* 12 Instruciton page fault */
>> +	do_page_fault,			/* 13 Load page fault */
>> +	do_trap_unknown,		/* 14 Reserved */
>> +	do_page_fault,			/* 15 Store/AMO page fault */
>> +#endif
>> +};
>> +
>> +asmlinkage void noinstr do_traps(struct pt_regs *regs)
>> +{
>> +	unsigned long cause = csr_read(CSR_CAUSE);
>> +
>> +	regs->cause = cause;
>> +
>> +#ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
>> +	riscv_v_context_nesting_start(regs);
>> +#endif
>> +	if (cause & CAUSE_IRQ_FLAG) {
>> +		do_irq(regs);
>> +	} else {
>> +		if (cause >= ARRAY_SIZE(excp_vect_table)) {
> 
> Using unlikely here may optimize the hotpath here slightly.
> 
> - Charlie
> 
>> +			do_trap_unknown(regs);
>> +			return;
>> +		}
>> +		excp_vect_table[cause](regs);
>> +	}
>> +}
>> +
>>   #ifdef CONFIG_GENERIC_BUG
>>   int is_valid_bugaddr(unsigned long pc)
>>   {
>> -- 
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

