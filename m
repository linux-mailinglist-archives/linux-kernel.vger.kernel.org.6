Return-Path: <linux-kernel+bounces-329069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9485A978CE6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 04:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA84FB21C5A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 02:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C6168BE;
	Sat, 14 Sep 2024 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NN7+fWD7"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2C14A90
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726282632; cv=none; b=GrURtZ0sxlIhd7IHDoA1YofnTz75ioLwWTp3kGjk0sHrJBjEz312tBL5sv8tx4szYWAs3gfjErAKX5ufnV6nAMRu+Hg667FZqK6EcSiDbBg9s+BHo72kDXk5hJj6tP/d9OS0zeqS3C+wKtoJKis3OCJ3tHxBY5/7RXHeiWrv/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726282632; c=relaxed/simple;
	bh=EF7k+FFc1hq546uavqghqZY+bf5mZkncv1cwI3VwZu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiTmbI/Nf6V8I14L31nNtdpborsQ43i2n8nG6jxHUT3ceUy06ICu4XAc3vILyK88tTbMXYW1bn3P/eMM9IFbams/2HKkY3OAeymzo6fKGR7PyjUFyu6vlb1bAl554W5SUZ/iumABtzENN0eIE6NxFk/y0kHNExcL7h0bqCNdE5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NN7+fWD7; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82d24e18dfcso94881039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 19:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1726282629; x=1726887429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pb+QdAWP89TAukwJGu2QJVdRrPw/zDWAXPkcoFz3eXo=;
        b=NN7+fWD766aKFw0hvsUVX+c0XsK08pB6Oq68GUsKDiepZWdNhSZcvozJqqMLQX3jix
         SNZt9dZAsXuhcPfOqrrq9w0M/zfzrv2QhlHXIF0fI1M/Dx2fdQjiFxsjkpRckWL2GZst
         cKIMQKime/Wlnk4YKmIW0kmfImfzcSSfHVcS0vIorvVZ/YuZA7Lvu3bJAB48dHw0Csla
         Cg349i/OrD2lpdGdgaRK8h+n65WWg/V1XOvQ9sTcbnCGeebU2CqSEOeeVP9l/OTUT7zv
         HnXHxlyVsDsTBX03HBeRGAnk6Dymr00Eofr4i10qNvUbNR438tQBowAvZtFzn4yuto+L
         bhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726282629; x=1726887429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pb+QdAWP89TAukwJGu2QJVdRrPw/zDWAXPkcoFz3eXo=;
        b=dmZm7/aCKYva4Z0lbBno6ua35+/hSNntvV+ZpQGTpwUFUxjVKYtyRy+L/EUfZV0yB7
         /PPcLFq9cRfI0ExWvfUL8Qh5udEQQIFMntQPhWZZ+fWifff0S+FWUXmObpQ2wLmAhijx
         DzkqUGOMdWx9dRlVfRkM7fy9SI6mxsTQiOHYBftQuDwKmBVahAlp3Hywxhup9bPvVHtk
         Ta9FJSLljfgVhFwI5wxMQ+9DiXL5oZ4tQMvuQaTS2/sOTRZ4fR+ahbDuFFgp3viT2ZuG
         ysnRP2PQlNk18fSITzb7QzmscwzONW/jM4cOV80biJvpyc3RCxJH/Lnqd2TJDSQGcq9F
         vJIw==
X-Forwarded-Encrypted: i=1; AJvYcCXVwqzVwlOLmSeOJ8/e9Y5AVY40zjSg+/lXsNuTOTirLzlhAc/08bJ/0uXkwgLma2aERJhKSGlKBnW5Iko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+XVxsqh0OBxyq3kXgvVed7FcB2dqWry8s207ih10ZfPZvv3yf
	NvVZ/xtyVv8nVGkLdYj+B8dtKURLAyR41jamm7IRCBXDF7+uhzH1tghfs+nDweo=
X-Google-Smtp-Source: AGHT+IFlqpN7MI41bzCJ3ml+1W2MQdnzy5SRXf7KXCYOGK0/zENcZ3yjIG7aJHvxKqOoTWVxlgNwnw==
X-Received: by 2002:a05:6602:3414:b0:82c:ed57:ebea with SMTP id ca18e2360f4ac-82d1f95f09amr1096525739f.13.1726282628881;
        Fri, 13 Sep 2024 19:57:08 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d4928ac38sm16179039f.17.2024.09.13.19.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 19:57:08 -0700 (PDT)
Message-ID: <b5b1b654-b603-4e22-ae9c-b712e4d6babe@sifive.com>
Date: Fri, 13 Sep 2024 21:57:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] riscv: Add support for the tagged address ABI
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com,
 Atish Patra <atishp@atishpatra.org>, Evgenii Stepanov <eugenis@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
 <20240829010151.2813377-6-samuel.holland@sifive.com> <ZuOnTvgMv2b/ki9e@ghost>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZuOnTvgMv2b/ki9e@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Charlie,

On 2024-09-12 9:45 PM, Charlie Jenkins wrote:
> On Wed, Aug 28, 2024 at 06:01:27PM -0700, Samuel Holland wrote:
>> When pointer masking is enabled for userspace, the kernel can accept
>> tagged pointers as arguments to some system calls. Allow this by
>> untagging the pointers in access_ok() and the uaccess routines. The
>> uaccess routines must peform untagging in software because U-mode and
>> S-mode have entirely separate pointer masking configurations. In fact,
>> hardware may not even implement pointer masking for S-mode.
>>
>> Since the number of tag bits is variable, untagged_addr_remote() needs
>> to know what PMLEN to use for the remote mm. Therefore, the pointer
>> masking mode must be the same for all threads sharing an mm. Enforce
>> this with a lock flag in the mm context, as x86 does for LAM. The flag
>> gets reset in init_new_context() during fork(), as the new mm is no
>> longer multithreaded.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
> 
> Not necessary, but what do you think about adding riscv to include/uapi/linux/prctl.h:
> 
> /* Tagged user address controls for arm64 */
> #define PR_SET_TAGGED_ADDR_CTRL		55
> #define PR_GET_TAGGED_ADDR_CTRL		56
> # define PR_TAGGED_ADDR_ENABLE		(1UL << 0)

Yes, I'll add this in v5.

> Also looks like this last line should probably be under SET rather than
> GET.

The same bit fields are used for both prctl() functions, so I think the current
grouping is okay (compare PR_RISCV_V_GET_CONTROL).

Regards,
Samuel

> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> 
>>
>> Changes in v4:
>>  - Combine __untagged_addr() and __untagged_addr_remote()
>>
>> Changes in v3:
>>  - Use IS_ENABLED instead of #ifdef when possible
>>  - Implement mm_untag_mask()
>>  - Remove pmlen from struct thread_info (now only in mm_context_t)
>>
>> Changes in v2:
>>  - Implement untagged_addr_remote()
>>  - Restrict PMLEN changes once a process is multithreaded
>>
>>  arch/riscv/include/asm/mmu.h         |  7 +++
>>  arch/riscv/include/asm/mmu_context.h | 13 +++++
>>  arch/riscv/include/asm/uaccess.h     | 43 ++++++++++++++--
>>  arch/riscv/kernel/process.c          | 73 ++++++++++++++++++++++++++--
>>  4 files changed, 126 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
>> index c9e03e9da3dc..1cc90465d75b 100644
>> --- a/arch/riscv/include/asm/mmu.h
>> +++ b/arch/riscv/include/asm/mmu.h
>> @@ -25,9 +25,16 @@ typedef struct {
>>  #ifdef CONFIG_BINFMT_ELF_FDPIC
>>  	unsigned long exec_fdpic_loadmap;
>>  	unsigned long interp_fdpic_loadmap;
>> +#endif
>> +	unsigned long flags;
>> +#ifdef CONFIG_RISCV_ISA_SUPM
>> +	u8 pmlen;
>>  #endif
>>  } mm_context_t;
>>  
>> +/* Lock the pointer masking mode because this mm is multithreaded */
>> +#define MM_CONTEXT_LOCK_PMLEN	0
>> +
>>  #define cntx2asid(cntx)		((cntx) & SATP_ASID_MASK)
>>  #define cntx2version(cntx)	((cntx) & ~SATP_ASID_MASK)
>>  
>> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
>> index 7030837adc1a..8c4bc49a3a0f 100644
>> --- a/arch/riscv/include/asm/mmu_context.h
>> +++ b/arch/riscv/include/asm/mmu_context.h
>> @@ -20,6 +20,9 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>>  static inline void activate_mm(struct mm_struct *prev,
>>  			       struct mm_struct *next)
>>  {
>> +#ifdef CONFIG_RISCV_ISA_SUPM
>> +	next->context.pmlen = 0;
>> +#endif
>>  	switch_mm(prev, next, NULL);
>>  }
>>  
>> @@ -30,11 +33,21 @@ static inline int init_new_context(struct task_struct *tsk,
>>  #ifdef CONFIG_MMU
>>  	atomic_long_set(&mm->context.id, 0);
>>  #endif
>> +	if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM))
>> +		clear_bit(MM_CONTEXT_LOCK_PMLEN, &mm->context.flags);
>>  	return 0;
>>  }
>>  
>>  DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
>>  
>> +#ifdef CONFIG_RISCV_ISA_SUPM
>> +#define mm_untag_mask mm_untag_mask
>> +static inline unsigned long mm_untag_mask(struct mm_struct *mm)
>> +{
>> +	return -1UL >> mm->context.pmlen;
>> +}
>> +#endif
>> +
>>  #include <asm-generic/mmu_context.h>
>>  
>>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */
>> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
>> index 72ec1d9bd3f3..fee56b0c8058 100644
>> --- a/arch/riscv/include/asm/uaccess.h
>> +++ b/arch/riscv/include/asm/uaccess.h
>> @@ -9,8 +9,41 @@
>>  #define _ASM_RISCV_UACCESS_H
>>  
>>  #include <asm/asm-extable.h>
>> +#include <asm/cpufeature.h>
>>  #include <asm/pgtable.h>		/* for TASK_SIZE */
>>  
>> +#ifdef CONFIG_RISCV_ISA_SUPM
>> +static inline unsigned long __untagged_addr_remote(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM)) {
>> +		u8 pmlen = mm->context.pmlen;
>> +
>> +		/* Virtual addresses are sign-extended; physical addresses are zero-extended. */
>> +		if (IS_ENABLED(CONFIG_MMU))
>> +			return (long)(addr << pmlen) >> pmlen;
>> +		else
>> +			return (addr << pmlen) >> pmlen;
>> +	}
>> +
>> +	return addr;
>> +}
>> +
>> +#define untagged_addr(addr) ({							\
>> +	unsigned long __addr = (__force unsigned long)(addr);			\
>> +	(__force __typeof__(addr))__untagged_addr_remote(current->mm, __addr);	\
>> +})
>> +
>> +#define untagged_addr_remote(mm, addr) ({					\
>> +	unsigned long __addr = (__force unsigned long)(addr);			\
>> +	mmap_assert_locked(mm);							\
>> +	(__force __typeof__(addr))__untagged_addr_remote(mm, __addr);		\
>> +})
>> +
>> +#define access_ok(addr, size) likely(__access_ok(untagged_addr(addr), size))
>> +#else
>> +#define untagged_addr(addr) (addr)
>> +#endif
>> +
>>  /*
>>   * User space memory access functions
>>   */
>> @@ -130,7 +163,7 @@ do {								\
>>   */
>>  #define __get_user(x, ptr)					\
>>  ({								\
>> -	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
>> +	const __typeof__(*(ptr)) __user *__gu_ptr = untagged_addr(ptr); \
>>  	long __gu_err = 0;					\
>>  								\
>>  	__chk_user_ptr(__gu_ptr);				\
>> @@ -246,7 +279,7 @@ do {								\
>>   */
>>  #define __put_user(x, ptr)					\
>>  ({								\
>> -	__typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
>> +	__typeof__(*(ptr)) __user *__gu_ptr = untagged_addr(ptr); \
>>  	__typeof__(*__gu_ptr) __val = (x);			\
>>  	long __pu_err = 0;					\
>>  								\
>> @@ -293,13 +326,13 @@ unsigned long __must_check __asm_copy_from_user(void *to,
>>  static inline unsigned long
>>  raw_copy_from_user(void *to, const void __user *from, unsigned long n)
>>  {
>> -	return __asm_copy_from_user(to, from, n);
>> +	return __asm_copy_from_user(to, untagged_addr(from), n);
>>  }
>>  
>>  static inline unsigned long
>>  raw_copy_to_user(void __user *to, const void *from, unsigned long n)
>>  {
>> -	return __asm_copy_to_user(to, from, n);
>> +	return __asm_copy_to_user(untagged_addr(to), from, n);
>>  }
>>  
>>  extern long strncpy_from_user(char *dest, const char __user *src, long count);
>> @@ -314,7 +347,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
>>  {
>>  	might_fault();
>>  	return access_ok(to, n) ?
>> -		__clear_user(to, n) : n;
>> +		__clear_user(untagged_addr(to), n) : n;
>>  }
>>  
>>  #define __get_kernel_nofault(dst, src, type, err_label)			\
>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>> index f39221ab5ddd..6e9c84a41c29 100644
>> --- a/arch/riscv/kernel/process.c
>> +++ b/arch/riscv/kernel/process.c
>> @@ -204,6 +204,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>  	unsigned long tls = args->tls;
>>  	struct pt_regs *childregs = task_pt_regs(p);
>>  
>> +	/* Ensure all threads in this mm have the same pointer masking mode. */
>> +	if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM) && p->mm && (clone_flags & CLONE_VM))
>> +		set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
>> +
>>  	memset(&p->thread.s, 0, sizeof(p->thread.s));
>>  
>>  	/* p->thread holds context to be restored by __switch_to() */
>> @@ -249,10 +253,16 @@ enum {
>>  static bool have_user_pmlen_7;
>>  static bool have_user_pmlen_16;
>>  
>> +/*
>> + * Control the relaxed ABI allowing tagged user addresses into the kernel.
>> + */
>> +static unsigned int tagged_addr_disabled;
>> +
>>  long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
>>  {
>> -	unsigned long valid_mask = PR_PMLEN_MASK;
>> +	unsigned long valid_mask = PR_PMLEN_MASK | PR_TAGGED_ADDR_ENABLE;
>>  	struct thread_info *ti = task_thread_info(task);
>> +	struct mm_struct *mm = task->mm;
>>  	unsigned long pmm;
>>  	u8 pmlen;
>>  
>> @@ -267,16 +277,41 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
>>  	 * in case choosing a larger PMLEN has a performance impact.
>>  	 */
>>  	pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
>> -	if (pmlen == PMLEN_0)
>> +	if (pmlen == PMLEN_0) {
>>  		pmm = ENVCFG_PMM_PMLEN_0;
>> -	else if (pmlen <= PMLEN_7 && have_user_pmlen_7)
>> +	} else if (pmlen <= PMLEN_7 && have_user_pmlen_7) {
>> +		pmlen = PMLEN_7;
>>  		pmm = ENVCFG_PMM_PMLEN_7;
>> -	else if (pmlen <= PMLEN_16 && have_user_pmlen_16)
>> +	} else if (pmlen <= PMLEN_16 && have_user_pmlen_16) {
>> +		pmlen = PMLEN_16;
>>  		pmm = ENVCFG_PMM_PMLEN_16;
>> -	else
>> +	} else {
>>  		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Do not allow the enabling of the tagged address ABI if globally
>> +	 * disabled via sysctl abi.tagged_addr_disabled, if pointer masking
>> +	 * is disabled for userspace.
>> +	 */
>> +	if (arg & PR_TAGGED_ADDR_ENABLE && (tagged_addr_disabled || !pmlen))
>> +		return -EINVAL;
>> +
>> +	if (!(arg & PR_TAGGED_ADDR_ENABLE))
>> +		pmlen = PMLEN_0;
>> +
>> +	if (mmap_write_lock_killable(mm))
>> +		return -EINTR;
>> +
>> +	if (test_bit(MM_CONTEXT_LOCK_PMLEN, &mm->context.flags) && mm->context.pmlen != pmlen) {
>> +		mmap_write_unlock(mm);
>> +		return -EBUSY;
>> +	}
>>  
>>  	envcfg_update_bits(task, ENVCFG_PMM, pmm);
>> +	mm->context.pmlen = pmlen;
>> +
>> +	mmap_write_unlock(mm);
>>  
>>  	return 0;
>>  }
>> @@ -289,6 +324,10 @@ long get_tagged_addr_ctrl(struct task_struct *task)
>>  	if (is_compat_thread(ti))
>>  		return -EINVAL;
>>  
>> +	/*
>> +	 * The mm context's pmlen is set only when the tagged address ABI is
>> +	 * enabled, so the effective PMLEN must be extracted from envcfg.PMM.
>> +	 */
>>  	switch (task->thread.envcfg & ENVCFG_PMM) {
>>  	case ENVCFG_PMM_PMLEN_7:
>>  		ret = FIELD_PREP(PR_PMLEN_MASK, PMLEN_7);
>> @@ -298,6 +337,9 @@ long get_tagged_addr_ctrl(struct task_struct *task)
>>  		break;
>>  	}
>>  
>> +	if (task->mm->context.pmlen)
>> +		ret |= PR_TAGGED_ADDR_ENABLE;
>> +
>>  	return ret;
>>  }
>>  
>> @@ -307,6 +349,24 @@ static bool try_to_set_pmm(unsigned long value)
>>  	return (csr_read_clear(CSR_ENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
>>  }
>>  
>> +/*
>> + * Global sysctl to disable the tagged user addresses support. This control
>> + * only prevents the tagged address ABI enabling via prctl() and does not
>> + * disable it for tasks that already opted in to the relaxed ABI.
>> + */
>> +
>> +static struct ctl_table tagged_addr_sysctl_table[] = {
>> +	{
>> +		.procname	= "tagged_addr_disabled",
>> +		.mode		= 0644,
>> +		.data		= &tagged_addr_disabled,
>> +		.maxlen		= sizeof(int),
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE,
>> +	},
>> +};
>> +
>>  static int __init tagged_addr_init(void)
>>  {
>>  	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
>> @@ -320,6 +380,9 @@ static int __init tagged_addr_init(void)
>>  	have_user_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
>>  	have_user_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
>>  
>> +	if (!register_sysctl("abi", tagged_addr_sysctl_table))
>> +		return -EINVAL;
>> +
>>  	return 0;
>>  }
>>  core_initcall(tagged_addr_init);
>> -- 
>> 2.45.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


