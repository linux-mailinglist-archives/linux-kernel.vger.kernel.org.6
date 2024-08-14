Return-Path: <linux-kernel+bounces-285968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0515C9514F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A31F2626C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7FD139D0A;
	Wed, 14 Aug 2024 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JOaTkZtg"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87CD3FBB2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619208; cv=none; b=ra8fk1QXLEIRrBdEZwXer5DCz+Dh7ePC4WH3O7fVI7fYUHsqL8fywpK2h/VbgoWlpwPBWmWE8xRmkdFbEmoMQd1YY7dBfTum8/20+J3YtjXDgvDe6N7ruqCqzeQaRXjRFqKBRHFjde8wgX4933DSXWOyPFG8ZyQp4N5h1lhG+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619208; c=relaxed/simple;
	bh=9M9jccDyJInBRUM9RF46BB6MR8jOPY4zQg+cKOGvI9A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kbDa9vnE9zZAI/foEk60pPfe+IPRCpfYqW5rLNFaOafGDjAXd6n2L/ULLkHt8TmL+QaFdaKyTzqUA7PJApYyTT9LPU/tR7+XwKZ6yERUx7al59Nua3uGqhHlDB/PIYpHMVzYQBIC8wUDRqjCp5Z0vwkWtK/3CKEsuPTXxxeASsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JOaTkZtg; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f921c418eso17302639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723619206; x=1724224006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sTHU8iXlEqUwgCimuhc001HOr+meABY+UioHyXt5kKk=;
        b=JOaTkZtgV6sr071EXrpHpXVTCDTDCxfK3rBzlSVu3ntZmg7oamZsEgNIqa51e+wU4D
         vrj/cViwW2wl5FceugpL/xMjvqov4dRjZn5w8NpP3rjnZg9E1qeT0pWTTTWwXmI/5VXr
         vva1joV17FgUSGy7QY59SRhPuNW0dn0NGxLYewFwQBmKBNU2aNryKhKnNKeYxHojAbBO
         S7lKud37x6L5ifTXkuy9CJbikqoSpxv3yCmWaWlMFeicTpN6uUNdf8E/8xWbT+h9qCht
         8Im89Gfw8ArsEB1UD14lsc75IRAGoC3/ci7aXfwXnvF9yW0e01nFsoBMkS8VOkMYyKDf
         HegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723619206; x=1724224006;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTHU8iXlEqUwgCimuhc001HOr+meABY+UioHyXt5kKk=;
        b=hIMa2s4XGV0glAxN3ZdOqvN45I5KZNlbFd/K7/kYypgaFCy3B/D9Zi7jNZlyf6zWap
         RcyVpdLw5EFfAeZwOcMLN8fW7ZuOV/y3mO7Jrgju0Q6EHf21jEnTCnAFUT0dRT05qygQ
         p9JYSYo8TeHBzV69t69jjfXj8rei6wWFuq15SqhW4DnsedCPS7XtO+z+IqCJQ8wGHKCB
         Uy6XF7zvCA7NEGR2hkaWYmeG/SW08BhEFkg2DRtNRAMj8hl82d8u3IQMsYpTfYgJCqup
         u/DlDUkdDAFuPHQFyReir06wRFZ9uYa7v9kK6ppN9rRBz0h00yl+SGinuc8amiDLeEqJ
         jOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUorr9qFIPapH6tJoEsowZuDfpTKvgHXtumDlGetC/1HqKp1DnU84kB/5bPK9JzzmjKXQnDSDuAcpdbzkPwjU5lua7Hin91oS2ig0qw
X-Gm-Message-State: AOJu0YyoakgbXrqGZiXnUrV7SxIj0tvbSZE7uxangFvjrKE0Sx3OqaX9
	VDfWaAEIxA8WFnegzSWclF/rnlA2JBzkymUvONTN2XBBdOSLsmAqlmKwSZds65FC53aLDQ5kJYU
	l
X-Google-Smtp-Source: AGHT+IE8PXEmWwI90MqleUnAtwAb5NwMj6pwE8gtAaHwtSBRjHy0C3ez5k93oexvd3ol6rI5FDBgoA==
X-Received: by 2002:a05:6e02:154d:b0:39d:184c:19b0 with SMTP id e9e14a558f8ab-39d184c1b38mr1818145ab.10.1723619205757;
        Wed, 14 Aug 2024 00:06:45 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca76a367e2sm3019621173.150.2024.08.14.00.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 00:06:45 -0700 (PDT)
Message-ID: <fc65fc29-4cd8-4e41-93e4-a35e3c8998d8@sifive.com>
Date: Wed, 14 Aug 2024 02:06:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] riscv: Add support for userspace pointer masking
From: Samuel Holland <samuel.holland@sifive.com>
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
 <dc8da1d4-435a-4786-b4bc-7f89590c2269@sifive.com>
Content-Language: en-US
In-Reply-To: <dc8da1d4-435a-4786-b4bc-7f89590c2269@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-08-13 8:54 PM, Samuel Holland wrote:
> Hi Alex,
> 
> Thanks for the review!
> 
> On 2024-08-13 3:58 AM, Alexandre Ghiti wrote:
>> Hi Samuel,
>>
>> On 25/06/2024 23:09, Samuel Holland wrote:
>>> RISC-V supports pointer masking with a variable number of tag bits
>>> (which is called "PMLEN" in the specification) and which is configured
>>> at the next higher privilege level.
>>>
>>> Wire up the PR_SET_TAGGED_ADDR_CTRL and PR_GET_TAGGED_ADDR_CTRL prctls
>>> so userspace can request a lower bound on the  number of tag bits and
>>> determine the actual number of tag bits. As with arm64's
>>> PR_TAGGED_ADDR_ENABLE, the pointer masking configuration is
>>> thread-scoped, inherited on clone() and fork() and cleared on execve().
>>>
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>>
>>> Changes in v2:
>>>   - Rebase on riscv/linux.git for-next
>>>   - Add and use the envcfg_update_bits() helper function
>>>   - Inline flush_tagged_addr_state()
>>>
>>>   arch/riscv/Kconfig                 | 11 ++++
>>>   arch/riscv/include/asm/processor.h |  8 +++
>>>   arch/riscv/include/asm/switch_to.h | 11 ++++
>>>   arch/riscv/kernel/process.c        | 99 ++++++++++++++++++++++++++++++
>>>   include/uapi/linux/prctl.h         |  3 +
>>>   5 files changed, 132 insertions(+)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index b94176e25be1..8f9980f81ea5 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -505,6 +505,17 @@ config RISCV_ISA_C
>>>           If you don't know what to do here, say Y.
>>>   +config RISCV_ISA_POINTER_MASKING
>>> +    bool "Smmpm, Smnpm, and Ssnpm extensions for pointer masking"
>>> +    depends on 64BIT
>>> +    default y
>>> +    help
>>> +      Add support for the pointer masking extensions (Smmpm, Smnpm,
>>> +      and Ssnpm) when they are detected at boot.
>>> +
>>> +      If this option is disabled, userspace will be unable to use
>>> +      the prctl(PR_{SET,GET}_TAGGED_ADDR_CTRL) API.
>>> +
>>>   config RISCV_ISA_SVNAPOT
>>>       bool "Svnapot extension support for supervisor mode NAPOT pages"
>>>       depends on 64BIT && MMU
>>> diff --git a/arch/riscv/include/asm/processor.h
>>> b/arch/riscv/include/asm/processor.h
>>> index 0838922bd1c8..4f99c85d29ae 100644
>>> --- a/arch/riscv/include/asm/processor.h
>>> +++ b/arch/riscv/include/asm/processor.h
>>> @@ -194,6 +194,14 @@ extern int set_unalign_ctl(struct task_struct *tsk,
>>> unsigned int val);
>>>   #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)   
>>> riscv_set_icache_flush_ctx(arg1, arg2)
>>>   extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long
>>> per_thread);
>>>   +#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
>>> +/* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
>>> +long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
>>> +long get_tagged_addr_ctrl(struct task_struct *task);
>>> +#define SET_TAGGED_ADDR_CTRL(arg)    set_tagged_addr_ctrl(current, arg)
>>> +#define GET_TAGGED_ADDR_CTRL()        get_tagged_addr_ctrl(current)
>>> +#endif
>>> +
>>>   #endif /* __ASSEMBLY__ */
>>>     #endif /* _ASM_RISCV_PROCESSOR_H */
>>> diff --git a/arch/riscv/include/asm/switch_to.h
>>> b/arch/riscv/include/asm/switch_to.h
>>> index 9685cd85e57c..94e33216b2d9 100644
>>> --- a/arch/riscv/include/asm/switch_to.h
>>> +++ b/arch/riscv/include/asm/switch_to.h
>>> @@ -70,6 +70,17 @@ static __always_inline bool has_fpu(void) { return false; }
>>>   #define __switch_to_fpu(__prev, __next) do { } while (0)
>>>   #endif
>>>   +static inline void envcfg_update_bits(struct task_struct *task,
>>> +                      unsigned long mask, unsigned long val)
>>> +{
>>> +    unsigned long envcfg;
>>> +
>>> +    envcfg = (task->thread.envcfg & ~mask) | val;
>>> +    task->thread.envcfg = envcfg;
>>> +    if (task == current)
>>> +        csr_write(CSR_ENVCFG, envcfg);
>>> +}
>>> +
>>>   static inline void __switch_to_envcfg(struct task_struct *next)
>>>   {
>>>       asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
>>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>>> index e4bc61c4e58a..dec5ccc44697 100644
>>> --- a/arch/riscv/kernel/process.c
>>> +++ b/arch/riscv/kernel/process.c
>>> @@ -7,6 +7,7 @@
>>>    * Copyright (C) 2017 SiFive
>>>    */
>>>   +#include <linux/bitfield.h>
>>>   #include <linux/cpu.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/sched.h>
>>> @@ -171,6 +172,10 @@ void flush_thread(void)
>>>       memset(&current->thread.vstate, 0, sizeof(struct __riscv_v_ext_state));
>>>       clear_tsk_thread_flag(current, TIF_RISCV_V_DEFER_RESTORE);
>>>   #endif
>>> +#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
>>> +    if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
>>> +        envcfg_update_bits(current, ENVCFG_PMM, ENVCFG_PMM_PMLEN_0);
>>> +#endif
>>
>> if (IS_ENABLED(CONFIG_RISCV_ISA_POINTER_MASKING) &&
>> riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
> 
> I will update this.
> 
>>>   }
>>>     void arch_release_task_struct(struct task_struct *tsk)
>>> @@ -233,3 +238,97 @@ void __init arch_task_cache_init(void)
>>>   {
>>>       riscv_v_setup_ctx_cache();
>>>   }
>>> +
>>> +#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
>>> +static bool have_user_pmlen_7;
>>> +static bool have_user_pmlen_16;
>>> +
>>> +long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
>>> +{
>>> +    unsigned long valid_mask = PR_PMLEN_MASK;
>>> +    struct thread_info *ti = task_thread_info(task);
>>> +    unsigned long pmm;
>>> +    u8 pmlen;
>>> +
>>> +    if (is_compat_thread(ti))
>>> +        return -EINVAL;
>>> +
>>> +    if (arg & ~valid_mask)
>>> +        return -EINVAL;
>>> +
>>> +    pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
>>> +    if (pmlen > 16) {
>>> +        return -EINVAL;
>>> +    } else if (pmlen > 7) {
>>> +        if (have_user_pmlen_16)
>>> +            pmlen = 16;
>>> +        else
>>> +            return -EINVAL;
>>> +    } else if (pmlen > 0) {
>>> +        /*
>>> +         * Prefer the smallest PMLEN that satisfies the user's request,
>>> +         * in case choosing a larger PMLEN has a performance impact.
>>> +         */
>>> +        if (have_user_pmlen_7)
>>> +            pmlen = 7;
>>> +        else if (have_user_pmlen_16)
>>> +            pmlen = 16;
>>> +        else
>>> +            return -EINVAL;
>>> +    }
>>> +
>>> +    if (pmlen == 7)
>>> +        pmm = ENVCFG_PMM_PMLEN_7;
>>> +    else if (pmlen == 16)
>>> +        pmm = ENVCFG_PMM_PMLEN_16;
>>> +    else
>>> +        pmm = ENVCFG_PMM_PMLEN_0;
>>> +
>>> +    envcfg_update_bits(task, ENVCFG_PMM, pmm);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +long get_tagged_addr_ctrl(struct task_struct *task)
>>> +{
>>> +    struct thread_info *ti = task_thread_info(task);
>>> +    long ret = 0;
>>> +
>>> +    if (is_compat_thread(ti))
>>> +        return -EINVAL;
>>> +
>>> +    switch (task->thread.envcfg & ENVCFG_PMM) {
>>> +    case ENVCFG_PMM_PMLEN_7:
>>> +        ret |= FIELD_PREP(PR_PMLEN_MASK, 7);
>>> +        break;
>>> +    case ENVCFG_PMM_PMLEN_16:
>>> +        ret |= FIELD_PREP(PR_PMLEN_MASK, 16);
>>> +        break;
>>> +    }
>>
>>
>> No need for the |=
> 
> This is used in the next patch since the returned value may include
> PR_TAGGED_ADDR_ENABLE as well, but it's not needed here, so I will make this change.
> 
>>> +
>>> +    return ret;
>>> +}
>>
>>
>> In all the code above, I'd use a macro for 7 and 16, something like PMLEN[7|16]?
> 
> I've done this using an enum in v4. Please let me know if it looks good to you.

Obviously I meant to say v3 here.

>>> +
>>> +static bool try_to_set_pmm(unsigned long value)
>>> +{
>>> +    csr_set(CSR_ENVCFG, value);
>>> +    return (csr_read_clear(CSR_ENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
>>> +}
>>> +
>>> +static int __init tagged_addr_init(void)
>>> +{
>>> +    if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
>>> +        return 0;
>>> +
>>> +    /*
>>> +     * envcfg.PMM is a WARL field. Detect which values are supported.
>>> +     * Assume the supported PMLEN values are the same on all harts.
>>> +     */
>>> +    csr_clear(CSR_ENVCFG, ENVCFG_PMM);
>>> +    have_user_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
>>> +    have_user_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
>>
>>
>> Shouldn't this depend on the satp mode? sv57 does not allow 16bits for the tag.
> 
> No, late last year the pointer masking spec was changed so that the valid values
> for PMM can no longer dynamically depend on satp.MODE. If an implementation
> chooses to support both Sv57 and PMLEN==16, then it does so by masking off some
> of the valid bits in the virtual address. (This is a valid if unusual use case
> considering that pointer masking does not apply to instruction fetches, so an
> application could place code at addresses above 2^47-1 and use the whole masked
> virtual address space for data. Or it could enable pointer masking for only
> certain threads, and those threads would be limited to a subset of data.)
> 
>>> +
>>> +    return 0;
>>> +}
>>> +core_initcall(tagged_addr_init);
>>
>>
>> Any reason it's not called from setup_arch()? I see the vector extension does
>> the same; just wondering if we should not centralize all this early extensions
>> decisions in setup_arch() (in my Zacas series, I choose the spinlock
>> implementation in setup_arch()).

Forgot to reply: no special reason, I copied this part of the code from arm64.
This code doesn't need to be called especially early; the only requirement is
that it runs before userspace starts. One advantage of core_initcall() is that
it happens after SMP bringup, so this way will have less impact on boot time.

Regards,
Samuel

>>> +#endif    /* CONFIG_RISCV_ISA_POINTER_MASKING */
>>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>>> index 35791791a879..6e84c827869b 100644
>>> --- a/include/uapi/linux/prctl.h
>>> +++ b/include/uapi/linux/prctl.h
>>> @@ -244,6 +244,9 @@ struct prctl_mm_map {
>>>   # define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
>>>   /* Unused; kept only for source compatibility */
>>>   # define PR_MTE_TCF_SHIFT        1
>>> +/* RISC-V pointer masking tag length */
>>> +# define PR_PMLEN_SHIFT            24
>>> +# define PR_PMLEN_MASK            (0x7fUL << PR_PMLEN_SHIFT)
>>
>>
>> I don't understand the need for this shift, can't userspace pass the pmlen value
>> directly without worrying about this?
> 
> No, because the PR_TAGGED_ADDR_ENABLE flag (bit 0, defined just a few lines
> above) is part of the the same argument word. It's just not used until the next
> patch.
> 
> Regards,
> Samuel
> 


