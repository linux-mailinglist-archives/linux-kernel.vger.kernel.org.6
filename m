Return-Path: <linux-kernel+bounces-285720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AEB9511BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601F2285E33
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ADD18B14;
	Wed, 14 Aug 2024 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="e6svQxP4"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97517C68
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600467; cv=none; b=PXFJvzmJr79veiBqOPgg8BDdh3I/gKWwSFx3crH3oPYLhVCFmh2CRYE0EvdQ/Te9q00sYXdFtpKhr/efNB4LpozXojEKK3mOAQaDPC8Mg7/I2iKFb5QcYVyN+ubUp2ibohVHyUkXhT9DgNFQB16ZOQZW6bqcc6aDFBIxnHGMuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600467; c=relaxed/simple;
	bh=qPcLEe0Y3srOUd9t6dlKzpEgI+poh6U7DVd+TUP248c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzdRs+TGVOTKYiGH0qIZzqbzbH+Uxx2OUiZdvwqmfhhLMgvBC0kPgRKI9OpU6K6magjZVDg9gtovDE/ViJzzPakJ7dsUYwgb7zWY9WZLIhuwv+l8Gx89m3DHaU9/UlFDw0AUXPlLwzTOLXtAQnyBZe+KuCXwl5zzO2n+qY3RmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=e6svQxP4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81fd1e1d38bso318651839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723600463; x=1724205263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p6pmULMAGWWHjRqkutdIwNmS0SAJKLB9nOZJ5sh6Gzk=;
        b=e6svQxP4CbSbYjvyQy2AWh7muEzwfNw/D0I1J1DQCXj3PnnX2CEB8o4nph067ASPAE
         jFc3lrWkaM+n3mF/dYVFHH3If/aMpdqrxRKfYkPdMc5kUhy6KYxX/h7DZXNcufI+IpQo
         WPPOB8PEdpR/QHKKga9whpkpz1jmvpXxa8FL/v4WMgre3QxjP3+WWT034pH1Fi5GlQcP
         8TSWPqiCvxyi9lZz56aVaSZxuF3uIahJY/q9WCbCOvD8Fgk8x5eNBoRMxJWem0/aFbpd
         AIATzTYLbQPdDqH7OPtRED6O0EUggnunE54VXaE6DNfNajdyWrr/iYMBPrHKPckRppVq
         NVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723600463; x=1724205263;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6pmULMAGWWHjRqkutdIwNmS0SAJKLB9nOZJ5sh6Gzk=;
        b=fJa1pQuBdQ9UxVdNJIPBTj/AEUzjfLy/b6xtAPdSZ4YosniMvUmhuAM+Y3N7O3lZnz
         M9plyhD0OAUVUfWWHPano97sowtPg3HzdvJjjgLog76Kvzrp4sNsI8W/uOjr0Lvr/GSh
         BH8L7btQc6rNUZ6zwPlekWOi6KXBmny5j3Ej+tTnc/2lhF7jkr32RJMNVaYdNGYdcBpQ
         7mXDYxM+vsyL4S0VfLqY+bCqbn3SQHJAxjWhTOQNTkA2gegG8cjMQOKqOuii6jhdvkFi
         JeCflaGCISlnewwoj3VKj8LZ+9O/TXrQpIjaEMzsANS+SwjBP+EqRT6aXDSNQ6dLD/DR
         zg7g==
X-Forwarded-Encrypted: i=1; AJvYcCVJunsnK6Lcjif0HifGP0aQTB8jSNIozp7RC38BwutasSE/M3CWrRYgwSSGMGHWmCLTdluuSU0cTXzpMV8+1VL9K+4y0q9qm3+ZeuA4
X-Gm-Message-State: AOJu0Yxi58RhGE3IWVzJgz8x616rbBI6XUm4I/VfI1KoK3snni3J7WGD
	/5HtDmDNB/mUFe6AjchuN75hun+ukEAjb+GNr1X+sclq67E10Vmkh4A6r1aayPA=
X-Google-Smtp-Source: AGHT+IE46kXd8oJ9fQY+S7XvoGy6ks+3JlzTSFcLeBH6FyLIJCxXaB6zmkbU7iEZyTSa78XeFhkUFg==
X-Received: by 2002:a05:6602:3f91:b0:822:3d11:107a with SMTP id ca18e2360f4ac-824dacda2ecmr182325039f.4.1723600463386;
        Tue, 13 Aug 2024 18:54:23 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca7695d26csm2890726173.84.2024.08.13.18.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 18:54:22 -0700 (PDT)
Message-ID: <dc8da1d4-435a-4786-b4bc-7f89590c2269@sifive.com>
Date: Tue, 13 Aug 2024 20:54:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] riscv: Add support for userspace pointer masking
To: Alexandre Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com,
 Atish Patra <atishp@atishpatra.org>, Evgenii Stepanov <eugenis@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20240625210933.1620802-1-samuel.holland@sifive.com>
 <20240625210933.1620802-5-samuel.holland@sifive.com>
 <440ca2a7-9dfb-45cd-8331-a8d0afff47d0@ghiti.fr>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <440ca2a7-9dfb-45cd-8331-a8d0afff47d0@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

Thanks for the review!

On 2024-08-13 3:58 AM, Alexandre Ghiti wrote:
> Hi Samuel,
> 
> On 25/06/2024 23:09, Samuel Holland wrote:
>> RISC-V supports pointer masking with a variable number of tag bits
>> (which is called "PMLEN" in the specification) and which is configured
>> at the next higher privilege level.
>>
>> Wire up the PR_SET_TAGGED_ADDR_CTRL and PR_GET_TAGGED_ADDR_CTRL prctls
>> so userspace can request a lower bound on the  number of tag bits and
>> determine the actual number of tag bits. As with arm64's
>> PR_TAGGED_ADDR_ENABLE, the pointer masking configuration is
>> thread-scoped, inherited on clone() and fork() and cleared on execve().
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> Changes in v2:
>>   - Rebase on riscv/linux.git for-next
>>   - Add and use the envcfg_update_bits() helper function
>>   - Inline flush_tagged_addr_state()
>>
>>   arch/riscv/Kconfig                 | 11 ++++
>>   arch/riscv/include/asm/processor.h |  8 +++
>>   arch/riscv/include/asm/switch_to.h | 11 ++++
>>   arch/riscv/kernel/process.c        | 99 ++++++++++++++++++++++++++++++
>>   include/uapi/linux/prctl.h         |  3 +
>>   5 files changed, 132 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index b94176e25be1..8f9980f81ea5 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -505,6 +505,17 @@ config RISCV_ISA_C
>>           If you don't know what to do here, say Y.
>>   +config RISCV_ISA_POINTER_MASKING
>> +    bool "Smmpm, Smnpm, and Ssnpm extensions for pointer masking"
>> +    depends on 64BIT
>> +    default y
>> +    help
>> +      Add support for the pointer masking extensions (Smmpm, Smnpm,
>> +      and Ssnpm) when they are detected at boot.
>> +
>> +      If this option is disabled, userspace will be unable to use
>> +      the prctl(PR_{SET,GET}_TAGGED_ADDR_CTRL) API.
>> +
>>   config RISCV_ISA_SVNAPOT
>>       bool "Svnapot extension support for supervisor mode NAPOT pages"
>>       depends on 64BIT && MMU
>> diff --git a/arch/riscv/include/asm/processor.h
>> b/arch/riscv/include/asm/processor.h
>> index 0838922bd1c8..4f99c85d29ae 100644
>> --- a/arch/riscv/include/asm/processor.h
>> +++ b/arch/riscv/include/asm/processor.h
>> @@ -194,6 +194,14 @@ extern int set_unalign_ctl(struct task_struct *tsk,
>> unsigned int val);
>>   #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)   
>> riscv_set_icache_flush_ctx(arg1, arg2)
>>   extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long
>> per_thread);
>>   +#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
>> +/* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
>> +long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
>> +long get_tagged_addr_ctrl(struct task_struct *task);
>> +#define SET_TAGGED_ADDR_CTRL(arg)    set_tagged_addr_ctrl(current, arg)
>> +#define GET_TAGGED_ADDR_CTRL()        get_tagged_addr_ctrl(current)
>> +#endif
>> +
>>   #endif /* __ASSEMBLY__ */
>>     #endif /* _ASM_RISCV_PROCESSOR_H */
>> diff --git a/arch/riscv/include/asm/switch_to.h
>> b/arch/riscv/include/asm/switch_to.h
>> index 9685cd85e57c..94e33216b2d9 100644
>> --- a/arch/riscv/include/asm/switch_to.h
>> +++ b/arch/riscv/include/asm/switch_to.h
>> @@ -70,6 +70,17 @@ static __always_inline bool has_fpu(void) { return false; }
>>   #define __switch_to_fpu(__prev, __next) do { } while (0)
>>   #endif
>>   +static inline void envcfg_update_bits(struct task_struct *task,
>> +                      unsigned long mask, unsigned long val)
>> +{
>> +    unsigned long envcfg;
>> +
>> +    envcfg = (task->thread.envcfg & ~mask) | val;
>> +    task->thread.envcfg = envcfg;
>> +    if (task == current)
>> +        csr_write(CSR_ENVCFG, envcfg);
>> +}
>> +
>>   static inline void __switch_to_envcfg(struct task_struct *next)
>>   {
>>       asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>> index e4bc61c4e58a..dec5ccc44697 100644
>> --- a/arch/riscv/kernel/process.c
>> +++ b/arch/riscv/kernel/process.c
>> @@ -7,6 +7,7 @@
>>    * Copyright (C) 2017 SiFive
>>    */
>>   +#include <linux/bitfield.h>
>>   #include <linux/cpu.h>
>>   #include <linux/kernel.h>
>>   #include <linux/sched.h>
>> @@ -171,6 +172,10 @@ void flush_thread(void)
>>       memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
>>       clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
>>   #endif
>> +#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
>> +    if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
>> +        envcfg_update_bits(current, ENVCFG_PMM, ENVCFG_PMM_PMLEN_0);
>> +#endif
> 
> if (IS_ENABLED(CONFIG_RISCV_ISA_POINTER_MASKING) &&
> riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))

I will update this.

>>   }
>>     void arch_release_task_struct(struct task_struct *tsk)
>> @@ -233,3 +238,97 @@ void __init arch_task_cache_init(void)
>>   {
>>       riscv_v_setup_ctx_cache();
>>   }
>> +
>> +#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
>> +static bool have_user_pmlen_7;
>> +static bool have_user_pmlen_16;
>> +
>> +long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
>> +{
>> +    unsigned long valid_mask = PR_PMLEN_MASK;
>> +    struct thread_info *ti = task_thread_info(task);
>> +    unsigned long pmm;
>> +    u8 pmlen;
>> +
>> +    if (is_compat_thread(ti))
>> +        return -EINVAL;
>> +
>> +    if (arg & ~valid_mask)
>> +        return -EINVAL;
>> +
>> +    pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
>> +    if (pmlen > 16) {
>> +        return -EINVAL;
>> +    } else if (pmlen > 7) {
>> +        if (have_user_pmlen_16)
>> +            pmlen = 16;
>> +        else
>> +            return -EINVAL;
>> +    } else if (pmlen > 0) {
>> +        /*
>> +         * Prefer the smallest PMLEN that satisfies the user's request,
>> +         * in case choosing a larger PMLEN has a performance impact.
>> +         */
>> +        if (have_user_pmlen_7)
>> +            pmlen = 7;
>> +        else if (have_user_pmlen_16)
>> +            pmlen = 16;
>> +        else
>> +            return -EINVAL;
>> +    }
>> +
>> +    if (pmlen == 7)
>> +        pmm = ENVCFG_PMM_PMLEN_7;
>> +    else if (pmlen == 16)
>> +        pmm = ENVCFG_PMM_PMLEN_16;
>> +    else
>> +        pmm = ENVCFG_PMM_PMLEN_0;
>> +
>> +    envcfg_update_bits(task, ENVCFG_PMM, pmm);
>> +
>> +    return 0;
>> +}
>> +
>> +long get_tagged_addr_ctrl(struct task_struct *task)
>> +{
>> +    struct thread_info *ti = task_thread_info(task);
>> +    long ret = 0;
>> +
>> +    if (is_compat_thread(ti))
>> +        return -EINVAL;
>> +
>> +    switch (task->thread.envcfg & ENVCFG_PMM) {
>> +    case ENVCFG_PMM_PMLEN_7:
>> +        ret |= FIELD_PREP(PR_PMLEN_MASK, 7);
>> +        break;
>> +    case ENVCFG_PMM_PMLEN_16:
>> +        ret |= FIELD_PREP(PR_PMLEN_MASK, 16);
>> +        break;
>> +    }
> 
> 
> No need for the |=

This is used in the next patch since the returned value may include
PR_TAGGED_ADDR_ENABLE as well, but it's not needed here, so I will make this change.

>> +
>> +    return ret;
>> +}
> 
> 
> In all the code above, I'd use a macro for 7 and 16, something like PMLEN[7|16]?

I've done this using an enum in v4. Please let me know if it looks good to you.

>> +
>> +static bool try_to_set_pmm(unsigned long value)
>> +{
>> +    csr_set(CSR_ENVCFG, value);
>> +    return (csr_read_clear(CSR_ENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
>> +}
>> +
>> +static int __init tagged_addr_init(void)
>> +{
>> +    if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
>> +        return 0;
>> +
>> +    /*
>> +     * envcfg.PMM is a WARL field. Detect which values are supported.
>> +     * Assume the supported PMLEN values are the same on all harts.
>> +     */
>> +    csr_clear(CSR_ENVCFG, ENVCFG_PMM);
>> +    have_user_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
>> +    have_user_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
> 
> 
> Shouldn't this depend on the satp mode? sv57 does not allow 16bits for the tag.

No, late last year the pointer masking spec was changed so that the valid values
for PMM can no longer dynamically depend on satp.MODE. If an implementation
chooses to support both Sv57 and PMLEN==16, then it does so by masking off some
of the valid bits in the virtual address. (This is a valid if unusual use case
considering that pointer masking does not apply to instruction fetches, so an
application could place code at addresses above 2^47-1 and use the whole masked
virtual address space for data. Or it could enable pointer masking for only
certain threads, and those threads would be limited to a subset of data.)

>> +
>> +    return 0;
>> +}
>> +core_initcall(tagged_addr_init);
> 
> 
> Any reason it's not called from setup_arch()? I see the vector extension does
> the same; just wondering if we should not centralize all this early extensions
> decisions in setup_arch() (in my Zacas series, I choose the spinlock
> implementation in setup_arch()).
> 
> 
>> +#endif    /* CONFIG_RISCV_ISA_POINTER_MASKING */
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 35791791a879..6e84c827869b 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -244,6 +244,9 @@ struct prctl_mm_map {
>>   # define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
>>   /* Unused; kept only for source compatibility */
>>   # define PR_MTE_TCF_SHIFT        1
>> +/* RISC-V pointer masking tag length */
>> +# define PR_PMLEN_SHIFT            24
>> +# define PR_PMLEN_MASK            (0x7fUL << PR_PMLEN_SHIFT)
> 
> 
> I don't understand the need for this shift, can't userspace pass the pmlen value
> directly without worrying about this?

No, because the PR_TAGGED_ADDR_ENABLE flag (bit 0, defined just a few lines
above) is part of the the same argument word. It's just not used until the next
patch.

Regards,
Samuel


