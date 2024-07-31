Return-Path: <linux-kernel+bounces-269918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992779438C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC07283FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4416D33D;
	Wed, 31 Jul 2024 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/mdeohq"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32E14B097
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464578; cv=none; b=AO8q6cf0b/HmwEu2fcfvGwSuTROtES3vRH3adFZogegfrQ8gCIftHz6Ad8PL/JdqVZPObuLfjHRkzuBsqbZ78rN2yUd6DE1FN1LmrOd20mDY5Y4zl17PfV1x6vD0ohRhl0WgoRao/ZbPii34aaZr7/GK0rWg2k34i2H7ci15034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464578; c=relaxed/simple;
	bh=Wct0Fwv4wsgfFcKl7SdX6qUXNy4WsyM0shvuM8+kKww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USMWOrNC52ht+tF7arvhSLLcMgU0fqhZatRQKv1JRf20IHPOPHHfWKyHi9xXO/hngN7KpG46EysWcREY7hgq209xb2lPptuiyEhC+3neXUUAtJ5lxDY7iI4r3zXL8CH+rwtS2iYyqYVKFirVDyB7M0WEbOhQHb22DDuuq2ldovA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/mdeohq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-71871d5e087so4813916a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722464576; x=1723069376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=p4civQS6RAaCPDUBssyrmp8dEj1PI4rO0BONlBZb0ag=;
        b=N/mdeohqtb3YM0uqLsWCUK4RzjUUutp/wfJddu7oJyl5EpXYxn6AsHX9FYeyF9j4yp
         GbFFe67W7fmalutA9mv9L485gH5EEm6rxfRVzvPza24wGxVk71S07FVCM2FjZZV/d5Kh
         QgzSIEmYybIGBUMh9+aKEjgz5gIZ73eRy0CQMWk7W+VsEaKNkcfIiBZ2a6Srt2wkMOYU
         oV+SyTlcOV3MknxbM3GLoPSQFY5X3n6/vIvRbgeWQPDcedoL3XSvLi4/bP0KIDffcxkz
         NUrwsw6HA2dDzO+C4rc+jcAUQH9j9P6ua84uptL2lpcClh6RletYV3bmwuWJrV8YyAJ0
         aqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464576; x=1723069376;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4civQS6RAaCPDUBssyrmp8dEj1PI4rO0BONlBZb0ag=;
        b=iwqlv6L0MXEbD9GTxjrlRVoJtoS85VSm8ND/32bRsyCzbYi1qSFd+5ZLrj5MDIcWZt
         5z2r0zAYFa3dgMVamIHU8DxdmljTh0zSU1hOAqRypGKe4JqtnCu2mr0mg+uv27XWoyr/
         yfBv2+/O7DNa8o1UlT3frz59gQnZNjNuJP0rQ26fuqzL6bYTdDckFF66ndqKUQmBQ0VZ
         2gfQJp8fNLF8iBtO7a/z2TIjdueFFL4CswhhVX4bugmzptwCy5zB5j2p8VpvB0GE2SKc
         ZNOJftirXK3NuEPbQnMOkfocVouFEkwuY5S0B0rjUfLDTqhtj0RuuWV81jVm7DwYtmQp
         1PuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ74x5qpLIOOgk9b9Jy+TRw72hDT5DtiO3dSLCQ6wPqEwrWkD4Gm775qdR92+cPwLmCl5wr0f28+xjXLdnf1NodmT5R1fR/E/JQkN0
X-Gm-Message-State: AOJu0YxeqrkKihjxBmQ855NmHOksHWGZfmTyBOCJ7lshzKA/N7M+6hdA
	Qe0d9q15I74QJaYlut4OIWnLdEZTuoC+O1vRRQpcC1DMyWI9RF5e
X-Google-Smtp-Source: AGHT+IFa0exT4zWgmWzw8uMLJqvEKoYId3m6kYFrlnJkgKJausyuRkbJw2ipt6/KWFyO5s4MPBIFtQ==
X-Received: by 2002:a17:90a:7081:b0:2c9:719f:b04b with SMTP id 98e67ed59e1d1-2cfe7b6fd0cmr774015a91.29.1722464576058;
        Wed, 31 Jul 2024 15:22:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf0f9sm1858001a91.46.2024.07.31.15.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 15:22:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d01798a0-5817-4645-8c8c-d61dcf668c25@roeck-us.net>
Date: Wed, 31 Jul 2024 15:22:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
References: <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
 <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
 <20240731163105.GG33588@noisy.programming.kicks-ass.net>
 <20240731165108.GH33588@noisy.programming.kicks-ass.net>
 <87bk2d5v83.ffs@tglx>
 <20240731212007.GW26599@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240731212007.GW26599@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 14:20, Peter Zijlstra wrote:
> On Wed, Jul 31, 2024 at 07:26:04PM +0200, Thomas Gleixner wrote:
>> On Wed, Jul 31 2024 at 18:51, Peter Zijlstra wrote:
>>> On Wed, Jul 31, 2024 at 06:31:05PM +0200, Peter Zijlstra wrote:
>>> Thomas, this all still relies on the full text section being PMD mapped,
>>> and since we don't have ALIGN_ENTRY_TEXT_END and _etext has PAGE_SIZE
>>> alignment, can't have a PAGE mapped tail which then doesn't get cloned?
>>>
>>> Do we want to make pto_clone_entry_text() use PTI_LEVEL_KERNEL_IMAGE
>>> such that it will clone whatever it has?
>>
>> Yes, I think so.
> 
> The alternative is ripping that level thing out entirely, and simply
> duplicate anything we find in the page-tables.
> 

The patch below (on top of the previous one, because otherwise it doesn't
apply) causes qemu to bail out hard, with

...
[    3.658327] sr 2:0:0:0: Attached scsi generic sg0 type 5
[    3.858040] sched_clock: Marking stable (3834034034, 23728553)->(3865222956, -7460369)
[    3.861469] registered taskstats version 1
[    3.861584] Loading compiled-in X.509 certificates
[    4.082031] Btrfs loaded, zoned=no, fsverity=no
[    4.096034] cryptomgr_test (69) used greatest stack depth: 6136 bytes left

No backtrace or other message, it just exits immediately.

Guenter

> We could add something like:
> 
> 	WARN_ON_ONCE(IS_ENABLED(CONFIG_X86_64));
> 
> in the PTE path, but do we really care?
> 
> ---
> --- a/arch/x86/mm/pti.c
> +++ b/arch/x86/mm/pti.c
> @@ -47,16 +47,6 @@
>   #define __GFP_NOTRACK	0
>   #endif
>   
> -/*
> - * Define the page-table levels we clone for user-space on 32
> - * and 64 bit.
> - */
> -#ifdef CONFIG_X86_64
> -#define	PTI_LEVEL_KERNEL_IMAGE	PTI_CLONE_PMD
> -#else
> -#define	PTI_LEVEL_KERNEL_IMAGE	PTI_CLONE_PTE
> -#endif
> -
>   static void __init pti_print_if_insecure(const char *reason)
>   {
>   	if (boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
> @@ -294,14 +284,7 @@ static void __init pti_setup_vsyscall(vo
>   static void __init pti_setup_vsyscall(void) { }
>   #endif
>   
> -enum pti_clone_level {
> -	PTI_CLONE_PMD,
> -	PTI_CLONE_PTE,
> -};
> -
> -static void
> -pti_clone_pgtable(unsigned long start, unsigned long end,
> -		  enum pti_clone_level level)
> +static void pti_clone_pgtable(unsigned long start, unsigned long end)
>   {
>   	unsigned long addr;
>   
> @@ -341,7 +324,7 @@ pti_clone_pgtable(unsigned long start, u
>   			continue;
>   		}
>   
> -		if (pmd_leaf(*pmd) || level == PTI_CLONE_PMD) {
> +		if (pmd_leaf(*pmd)) {
>   			target_pmd = pti_user_pagetable_walk_pmd(addr);
>   			if (WARN_ON(!target_pmd))
>   				return;
> @@ -375,37 +358,33 @@ pti_clone_pgtable(unsigned long start, u
>   			*target_pmd = *pmd;
>   
>   			addr = round_up(addr + 1, PMD_SIZE);
> +			continue;
> +		}
>   
> -		} else if (level == PTI_CLONE_PTE) {
> -
> -			/* Walk the page-table down to the pte level */
> -			pte = pte_offset_kernel(pmd, addr);
> -			if (pte_none(*pte)) {
> -				addr = round_up(addr + 1, PAGE_SIZE);
> -				continue;
> -			}
> -
> -			/* Only clone present PTEs */
> -			if (WARN_ON(!(pte_flags(*pte) & _PAGE_PRESENT)))
> -				return;
> +		/* Walk the page-table down to the pte level */
> +		pte = pte_offset_kernel(pmd, addr);
> +		if (pte_none(*pte)) {
> +			addr = round_up(addr + 1, PAGE_SIZE);
> +			continue;
> +		}
>   
> -			/* Allocate PTE in the user page-table */
> -			target_pte = pti_user_pagetable_walk_pte(addr);
> -			if (WARN_ON(!target_pte))
> -				return;
> +		/* Only clone present PTEs */
> +		if (WARN_ON(!(pte_flags(*pte) & _PAGE_PRESENT)))
> +			return;
>   
> -			/* Set GLOBAL bit in both PTEs */
> -			if (boot_cpu_has(X86_FEATURE_PGE))
> -				*pte = pte_set_flags(*pte, _PAGE_GLOBAL);
> +		/* Allocate PTE in the user page-table */
> +		target_pte = pti_user_pagetable_walk_pte(addr);
> +		if (WARN_ON(!target_pte))
> +			return;
>   
> -			/* Clone the PTE */
> -			*target_pte = *pte;
> +		/* Set GLOBAL bit in both PTEs */
> +		if (boot_cpu_has(X86_FEATURE_PGE))
> +			*pte = pte_set_flags(*pte, _PAGE_GLOBAL);
>   
> -			addr = round_up(addr + 1, PAGE_SIZE);
> +		/* Clone the PTE */
> +		*target_pte = *pte;
>   
> -		} else {
> -			BUG();
> -		}
> +		addr = round_up(addr + 1, PAGE_SIZE);
>   	}
>   }
>   
> @@ -475,7 +454,7 @@ static void __init pti_clone_user_shared
>   	start = CPU_ENTRY_AREA_BASE;
>   	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
>   
> -	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
> +	pti_clone_pgtable(start, end);
>   }
>   #endif /* CONFIG_X86_64 */
>   
> @@ -495,8 +474,7 @@ static void __init pti_setup_espfix64(vo
>   static void pti_clone_entry_text(void)
>   {
>   	pti_clone_pgtable((unsigned long) __entry_text_start,
> -			  (unsigned long) __entry_text_end,
> -			  PTI_CLONE_PMD);
> +			  (unsigned long) __entry_text_end);
>   }
>   
>   /*
> @@ -571,7 +549,7 @@ static void pti_clone_kernel_text(void)
>   	 * pti_set_kernel_image_nonglobal() did to clear the
>   	 * global bit.
>   	 */
> -	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
> +	pti_clone_pgtable(start, end_clone);
>   
>   	/*
>   	 * pti_clone_pgtable() will set the global bit in any PMDs


