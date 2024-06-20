Return-Path: <linux-kernel+bounces-223663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E17911663
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB991F234E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D63C14535A;
	Thu, 20 Jun 2024 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ap5xAW3l"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6C13CF82
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718924952; cv=none; b=LZneLD+5ITL9XigioNOKhytxM+UlhwtC6weJWdyt2PAYo3tPe3dysnXPMYRhdkF0cFKf4R/J5+u6qeOW9Hf0KKdYWp10Iwlz0o0iPsbpnQLgYpTiUQRlVbBhmmMgUYFfhOxgsw+5nG4KYnkNBf1taX8IhkMjqRODqFoQPwicNQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718924952; c=relaxed/simple;
	bh=H3O7bTcsqbMn8aI/cjrLiRBr3NS9OLBsKf7QhRRt/V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oe/R3k+runcgFcqIpViGh7K0nqVEY6seyo8/IhSvq9bYjTNDbPmxxuGpB70FfubdaDWFB1uHWeJg3tipbucdNo7uihiqVJgekx5QOmtBgsGUKFk1keA2lSZ4CbG8t1LwW1l985SYNGK/Ts8xw05SUDCe7mZ+I8I1HAyKld7Xrc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ap5xAW3l; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c327a0d4c9so1829480a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718924949; x=1719529749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJBfBf0lM7ftWKQI+6H7FKepZYuK5CzXC7keXkWcqjQ=;
        b=Ap5xAW3l8tQnY2+wo3hIVfq2YOsGvfizlMhKGtMpCPkWU99y1J9EEJzF9Qu+J0/18Q
         7LxAkvfvNdyV9QszMCjxNIaGnOIRghw2W9k5bodeBFPafjNzVFEfzEHfvaXoUoXC8zUl
         ozyF4Mylur/dvhRcGNBNoAYWqrFSyusG1XQKKBVcGtJL+swiV0Gw4jfi3/NlFq/FiOeO
         Oxjy4q5aUERxzTmXc8D99S3LeUe2dgydRJc+TFV6M1s4JrKbzNE9+Agw75SiJb5nl4MR
         lHcL2wZ62rsRukX8pVzhF2jQdJBKJqaAnBn/n00BnM8m0YqUJzVo1sclFGssEeRS2Och
         5Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718924949; x=1719529749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJBfBf0lM7ftWKQI+6H7FKepZYuK5CzXC7keXkWcqjQ=;
        b=rOL0Ae+KQ1mC6zdQo0zQc1YQNJl36nGEsmvPgEqieCan4yoiupHLMYxPmgr6z7x0X3
         fmtVfaW8Wmo6SbyFQU0SBq7MJ6EcRa7NFfG9J/ZsKDcQZwboxaDfZSjKG7Ii3+l6sVE7
         fMKEOUydjgn33eSc8wwXtXXT5K+uO0pNR+r41k8PKM0/hPiYsGEKf6HeoIbeHX1dh0M3
         FDEo7NzHAaXmZeZ6LuxMp2sbR9gXwyKN7gpCNorLYsjoW0/hLrVIrjNAYkwnRfWdE10F
         fIvVou49zXRCFM8cpjVNf8wxhU6L+3OGzastlwguflUflAdsm2cbEXAXHZazUo6OSLtx
         5d9g==
X-Forwarded-Encrypted: i=1; AJvYcCWCRv5vELihwkbNRWuwgF1gqktExBtQYaLJJ4eneC+dEoXqHe5eFFGy5WgdkZLAMU3uRbyXw+2w52gfHl9E3+VOWur84wXei7ZH9133
X-Gm-Message-State: AOJu0YycuJETZTBlSTM64WD0Js2/SmBSZ/7gX5Bk9EAWJX1L24HR+Qan
	EzxUYs+6Hx4nGeZpEdwUrfC9ejwRorlxPEhcuEfmh7wNP3jmUr17hrvikYW8ueY=
X-Google-Smtp-Source: AGHT+IGaLMPVL/dIHyh5i/i6j8OxuJBZ3JJusuPdQ5hnW7dyTBjGQLrPm/MrxpvvWWt6/xB3x2+bZg==
X-Received: by 2002:a17:90a:34c9:b0:2c2:d6ca:3960 with SMTP id 98e67ed59e1d1-2c7b3ba80b8mr9597170a91.17.1718924948384;
        Thu, 20 Jun 2024 16:09:08 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a62404sm223945a91.7.2024.06.20.16.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 16:09:07 -0700 (PDT)
Message-ID: <35d774b8-5240-4be2-b290-f3e07e392b9d@rivosinc.com>
Date: Thu, 20 Jun 2024 19:08:49 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] RISC-V: Detect unaligned vector accesses
 supported.
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Andy Chiu <andy.chiu@sifive.com>, Eric Biggers <ebiggers@google.com>,
 Greentime Hu <greentime.hu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-5-jesse@rivosinc.com> <ZnDmRK0ZtKzmWN5S@ghost>
 <ZnDsdzv4o/Xz9kWm@ghost> <e6f7a061-50f0-4a6a-a09b-468502703c20@rivosinc.com>
 <ZnSptpobfqjik3RM@ghost>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <ZnSptpobfqjik3RM@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/20/24 18:14, Charlie Jenkins wrote:
> On Thu, Jun 20, 2024 at 05:31:28PM -0400, Jesse Taube wrote:
>>
>>
>> On 6/17/24 22:09, Charlie Jenkins wrote:
>>> On Mon, Jun 17, 2024 at 06:43:32PM -0700, Charlie Jenkins wrote:
>>>> On Thu, Jun 13, 2024 at 03:16:13PM -0400, Jesse Taube wrote:
>>>>> Run a unaligned vector access to test if the system supports
>>>>> vector unaligned access. Add the result to a new key in hwprobe.
>>>>> This is useful for usermode to know if vector misaligned accesses are
>>>>> supported and if they are faster or slower than equivalent byte accesses.
>>>>>
>>>>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>>>>> ---
>>>>> V1 -> V2:
>>>>>    - Add Kconfig options
>>>>>    - Add insn_is_vector
>>>>>    - Add handle_vector_misaligned_load
>>>>>    - Fix build
>>>>>    - Seperate vector from scalar misaligned access
>>>>>    - This patch was almost completely rewritten
>>>>> ---
>>>>>    arch/riscv/Kconfig                         |  41 +++++++
>>>>>    arch/riscv/include/asm/cpufeature.h        |   7 +-
>>>>>    arch/riscv/include/asm/entry-common.h      |  11 --
>>>>>    arch/riscv/include/asm/hwprobe.h           |   2 +-
>>>>>    arch/riscv/include/asm/vector.h            |   1 +
>>>>>    arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
>>>>>    arch/riscv/kernel/Makefile                 |   4 +-
>>>>>    arch/riscv/kernel/sys_hwprobe.c            |  41 +++++++
>>>>>    arch/riscv/kernel/traps_misaligned.c       | 119 ++++++++++++++++++++-
>>>>>    arch/riscv/kernel/unaligned_access_speed.c |   9 +-
>>>>>    arch/riscv/kernel/vector.c                 |   2 +-
>>>>>    11 files changed, 221 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>>> index b94176e25be1..f12df0ca6c18 100644
>>>>> --- a/arch/riscv/Kconfig
>>>>> +++ b/arch/riscv/Kconfig
>>>>> @@ -723,6 +723,12 @@ config RISCV_MISALIGNED
>>>>>    	help
>>>>>    	  Embed support for emulating misaligned loads and stores.
>>>>> +config RISCV_VECTOR_MISALIGNED
>>>>> +	bool
>>>>> +	depends on RISCV_ISA_V
>>>>> +	help
>>>>> +	  Enable detecting support for vector misaligned loads and stores.
>>>>> +
>>>>>    choice
>>>>>    	prompt "Unaligned Accesses Support"
>>>>>    	default RISCV_PROBE_UNALIGNED_ACCESS
>>>>> @@ -774,6 +780,41 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
>>>>>    endchoice
>>>>> +choice
>>>>> +	prompt "Vector unaligned Accesses Support"
>>>>> +	depends on RISCV_ISA_V
>>>>> +	default RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>>>>> +	help
>>>>> +	  This determines the level of support for vector unaligned accesses. This
>>>>> +	  information is used by the kernel to perform optimizations. It is also
>>>>> +	  exposed to user space via the hwprobe syscall. The hardware will be
>>>>> +	  probed at boot by default.
>>>>> +
>>>>> +config RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
>>>>
>>>> This is not used anywhere, what is the reason for including it?
>>
>> This is so that we can check if they are supported or not, but not check the
>> speed of them. Similar to RISCV_EMULATED_UNALIGNED_ACCESS.
> 
> What do you mean? It isn't used anywhere so this "check if they are
> supported or not" is not guarded by this config.

It is not used anywhere because it just needs to enable 
RISCV_VECTOR_MISALIGNED and nothing else.

> 
>>
>>>>
>>>>> +	bool "Detect support for vector unaligned accesses"
>>>>> +	select RISCV_VECTOR_MISALIGNED
>>>>> +	help
>>>>> +	  During boot, the kernel will detect if the system supports vector
>>>>> +	  unaligned accesses.
>>>>> +
>>>>> +config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>>>>> +	bool "Probe speed of vector unaligned accesses"
>>>>> +	select RISCV_VECTOR_MISALIGNED
>>>>> +	help
>>>>> +	  During boot, the kernel will run a series of tests to determine the
>>>>> +	  speed of vector unaligned accesses if they are supported. This probing
>>>>> +	  will dynamically determine the speed of vector unaligned accesses on
>>>>> +	  the underlying system if they are supported.
>>>>> +
>>>>> +config CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED
>>>>
>>>> This should not be prefixed with CONFIG and does not include VECTOR in
>>>> the name.
>>
>> Huh thought it would warn fixed though
> 
> What do you mean by "warn fixed"?

Huh thought it would warn. fixed though.

As in I fixed it in V3.

> 
>>
>>> I assume you meant to put
>>>> "RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED" here?
>>
>> This is to leave a faster path like SLOW or FAST to say that unaligned
>> access arent suported.
> 
> I am not sure what you are responding to. This comment seems to be
> responding to my correction of
> CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED->RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED
> so I don't see how that ties into SLOW/FAST

Sorry for the confustion it was meant respond to the comment below...

> 
>>
>>>>
>>>> This was also intentionally left out on the scalar side [1]. The
>>>> implication here is that having this config will cause people to compile
>>>> kernels without unaligned access support which really shouldn't be
>>>> something we are explicitly supporting.
>>>>
>>>> If somebody does want to support hardware that does not handle vector
>>>> unaligned accesses, the solution should be to add emulation support to
>>>> the kernel.
>>
>> Yes but we dont have emulation support yet so I do think its a good idea.
> 
> I am hesitant because it is very likely that somebody will add support
> for unaligned vector emulation. When there is emulation support, this
> config option should not exist to be consistent with scalar. However if
> we add this option in now, we must expect a user to enable this config,
> and then we will have to get rid of it later. Users are not always happy
> when config options are removed.

I will remove it then.

> 
>>
>>>>
>>>> Link: https://lore.kernel.org/all/Zd4y5llkvTfKHf6b@ghost/ [1]
>>>>
>>>> - Charlie
>>>>
>>>>> +	bool "Assume the system does not support vector unaligned memory accesses"
>>>>> +	help
>>>>> +	  Assume that the system does not support vector unaligned memory accesses.
>>>>> +	  The kernel and userspace programs may run them successfully on systems
>>>>> +	  that do support vector unaligned memory accesses.
>>>>> +
>>>>> +endchoice
>>>>> +
>>>>>    endmenu # "Platform type"
>>>>>    menu "Kernel features"
>>>>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>>>>> index 347805446151..d0ea5921ab20 100644
>>>>> --- a/arch/riscv/include/asm/cpufeature.h
>>>>> +++ b/arch/riscv/include/asm/cpufeature.h
>>>>> @@ -33,8 +33,8 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
>>>>>    void riscv_user_isa_enable(void);
>>>>> -#if defined(CONFIG_RISCV_MISALIGNED)
>>>>>    bool check_unaligned_access_emulated_all_cpus(void);
>>>>> +#if defined(CONFIG_RISCV_MISALIGNED)
>>>>>    void unaligned_emulation_finish(void);
>>>>>    bool unaligned_ctl_available(void);
>>>>>    DECLARE_PER_CPU(long, misaligned_access_speed);
>>>>> @@ -45,6 +45,11 @@ static inline bool unaligned_ctl_available(void)
>>>>>    }
>>>>>    #endif
>>>>> +bool check_vector_unaligned_access_emulated_all_cpus(void);
>>>>> +#if defined(CONFIG_RISCV_VECTOR_MISALIGNED)
>>>>> +DECLARE_PER_CPU(long, vector_misaligned_access);
>>>>> +#endif
>>>>> +
>>>>>    #if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>>>>>    DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
>>>>> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
>>>>> index 2293e535f865..7b32d2b08bb6 100644
>>>>> --- a/arch/riscv/include/asm/entry-common.h
>>>>> +++ b/arch/riscv/include/asm/entry-common.h
>>>>> @@ -25,18 +25,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>>>>>    void handle_page_fault(struct pt_regs *regs);
>>>>>    void handle_break(struct pt_regs *regs);
>>>>> -#ifdef CONFIG_RISCV_MISALIGNED
>>>>>    int handle_misaligned_load(struct pt_regs *regs);
>>>>>    int handle_misaligned_store(struct pt_regs *regs);
>>>>> -#else
>>>>> -static inline int handle_misaligned_load(struct pt_regs *regs)
>>>>> -{
>>>>> -	return -1;
>>>>> -}
>>>>> -static inline int handle_misaligned_store(struct pt_regs *regs)
>>>>> -{
>>>>> -	return -1;
>>>>> -}
>>>>> -#endif
>>>>>    #endif /* _ASM_RISCV_ENTRY_COMMON_H */
>>>>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
>>>>> index 150a9877b0af..ef01c182af2b 100644
>>>>> --- a/arch/riscv/include/asm/hwprobe.h
>>>>> +++ b/arch/riscv/include/asm/hwprobe.h
>>>>> @@ -8,7 +8,7 @@
>>>>>    #include <uapi/asm/hwprobe.h>
>>>>> -#define RISCV_HWPROBE_MAX_KEY 7
>>>>> +#define RISCV_HWPROBE_MAX_KEY 8
>>>>>    static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>>>>    {
>>>>> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
>>>>> index be7d309cca8a..99b0f91db9ee 100644
>>>>> --- a/arch/riscv/include/asm/vector.h
>>>>> +++ b/arch/riscv/include/asm/vector.h
>>>>> @@ -21,6 +21,7 @@
>>>>>    extern unsigned long riscv_v_vsize;
>>>>>    int riscv_v_setup_vsize(void);
>>>>> +bool insn_is_vector(u32 insn_buf);
>>>>>    bool riscv_v_first_use_handler(struct pt_regs *regs);
>>>>>    void kernel_vector_begin(void);
>>>>>    void kernel_vector_end(void);
>>>>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
>>>>> index 023b7771d1b7..2fee870e41bb 100644
>>>>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>>>>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>>>>> @@ -75,6 +75,11 @@ struct riscv_hwprobe {
>>>>>    #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>>>>>    #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>>>>>    #define RISCV_HWPROBE_KEY_MISALIGNED_PERF	7
>>>>> +#define RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF	8
>>>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN		0
>>>>
>>>> I appreciate you leaving the key for EMULATED open!
>>>>
>>>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_SLOW		2
>>>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_FAST		3
>>>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED	4
>>>>>    /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>>>>    /* Flags */
>>>>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>>>> index 5b243d46f4b1..62ac19c029f1 100644
>>>>> --- a/arch/riscv/kernel/Makefile
>>>>> +++ b/arch/riscv/kernel/Makefile
>>>>> @@ -62,8 +62,8 @@ obj-y	+= probes/
>>>>>    obj-y	+= tests/
>>>>>    obj-$(CONFIG_MMU) += vdso.o vdso/
>>>>> -obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
>>>>> -obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
>>>>> +obj-y	+= traps_misaligned.o
>>>>> +obj-y	+= unaligned_access_speed.o
>>
>>> These files only need to be compiled if either CONFIG_RISCV_MISALIGNED
>>> or CONFIG_RISCV_VECTOR_MISALIGNED is selected. Can you refactor this
>>> code to replace CONFIG_RISCV_MISALIGNED with
>>> CONFIG_RISCV_SCALAR_MISALIGNED and then have
>>> CONFIG_RISCV_SCALAR_MISALIGNED and CONFIG_RISCV_VECTOR_MISALIGNED
>>> select CONFIG_RISCV_MISALIGNED in the Kconfig?
>>
>> Fixed!
>>
>>>>>    obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
>>>>>    obj-$(CONFIG_FPU)		+= fpu.o
>>>>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
>>>>> index e910e2971984..c40df314058b 100644
>>>>> --- a/arch/riscv/kernel/sys_hwprobe.c
>>>>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>>>>> @@ -194,6 +194,43 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>>>>>    }
>>>>>    #endif
>>>>> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
>>>>> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>>>>> +{
>>>>> +	int cpu;
>>>>> +	u64 perf = -1ULL;
>>>>> +
>>>>> +	if (IS_ENABLED(CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED))
>>>>> +		return RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>>>>> +
>>>>> +	/* Return if supported or not even if speed wasn't probed */
>>>>> +	for_each_cpu(cpu, cpus) {
>>>>> +		int this_perf = per_cpu(vector_misaligned_access, cpu);
>>>>> +
>>>>> +		if (perf == -1ULL)
>>>>> +			perf = this_perf;
>>>>> +
>>>>> +		if (perf != this_perf) {
>>>>> +			perf = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>>>> +			break;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	if (perf == -1ULL)
>>>>> +		return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>>>> +
>>>>> +	return perf;
>>>>> +}
>>>>> +#else
>>>>> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>>>>> +{
>>>>> +	if (IS_ENABLED(CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED))
>>>>> +		return RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>>>>> +
>>>>> +	return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>>    static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>>>>    			     const struct cpumask *cpus)
>>>>>    {
>>>>> @@ -222,6 +259,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>>>>    		pair->value = hwprobe_misaligned(cpus);
>>>>>    		break;
>>>>> +	case RISCV_HWPROBE_KEY_VEC_MISALIGNED_PERF:
>>>>> +		pair->value = hwprobe_vec_misaligned(cpus);
>>>>> +		break;
>>>>> +
>>>>>    	case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>>>>>    		pair->value = 0;
>>>>>    		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>>>>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>>>>> index 8fadbe00dd62..6f0264a8c9de 100644
>>>>> --- a/arch/riscv/kernel/traps_misaligned.c
>>>>> +++ b/arch/riscv/kernel/traps_misaligned.c
>>>>> @@ -16,6 +16,7 @@
>>>>>    #include <asm/entry-common.h>
>>>>>    #include <asm/hwprobe.h>
>>>>>    #include <asm/cpufeature.h>
>>>>> +#include <asm/vector.h>
>>>>>    #define INSN_MATCH_LB			0x3
>>>>>    #define INSN_MASK_LB			0x707f
>>>>> @@ -322,12 +323,37 @@ union reg_data {
>>>>>    	u64 data_u64;
>>>>>    };
>>>>> -static bool unaligned_ctl __read_mostly;
>>>>> -
>>>>>    /* sysctl hooks */
>>>>>    int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
>>>>> -int handle_misaligned_load(struct pt_regs *regs)
>>>>> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
>>>>> +static int handle_vector_misaligned_load(struct pt_regs *regs)
>>>>> +{
>>>>> +	unsigned long epc = regs->epc;
>>>>> +	unsigned long insn;
>>>>> +
>>>>> +	if (get_insn(regs, epc, &insn))
>>>>> +		return -1;
>>>>> +
>>>>> +	/* Only return 0 when in check_vector_unaligned_access_emulated */
>>>>> +	if (*this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN) {
>>>>> +		*this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>>>>> +		regs->epc = epc + INSN_LEN(insn);
>>>>> +		return 0;
>>>>> +	}
>>>>> +
>>>>> +	/* If vector instruction we don't emulate it yet */
>>>>> +	regs->epc = epc;
>>>>> +	return -1;
>>>>> +}
>>>>> +#else
>>>>> +static int handle_vector_misaligned_load(struct pt_regs *regs)
>>>>> +{
>>>>> +	return -1;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>> +static int handle_scalar_misaligned_load(struct pt_regs *regs)
>>>>>    {
>>>>>    	union reg_data val;
>>>>>    	unsigned long epc = regs->epc;
>>>>> @@ -435,7 +461,7 @@ int handle_misaligned_load(struct pt_regs *regs)
>>>>>    	return 0;
>>>>>    }
>>>>> -int handle_misaligned_store(struct pt_regs *regs)
>>>>> +static int handle_scalar_misaligned_store(struct pt_regs *regs)
>>>>>    {
>>>>>    	union reg_data val;
>>>>>    	unsigned long epc = regs->epc;
>>>>> @@ -526,6 +552,85 @@ int handle_misaligned_store(struct pt_regs *regs)
>>>>>    	return 0;
>>>>>    }
>>>>> +int handle_misaligned_load(struct pt_regs *regs)
>>>>> +{
>>>>> +	unsigned long epc = regs->epc;
>>>>> +	unsigned long insn;
>>>>> +
>>>>> +	if (IS_ENABLED(CONFIG_RISCV_VECTOR_MISALIGNED)) {
>>>>> +		if (get_insn(regs, epc, &insn))
>>>>> +			return -1;
>>>>> +
>>>>> +		if (insn_is_vector(insn))
>>>>> +			return handle_vector_misaligned_load(regs);
>>>>> +	}
>>>>> +
>>>>> +	if (IS_ENABLED(CONFIG_RISCV_MISALIGNED))
>>>>> +		return handle_scalar_misaligned_load(regs);
>>>>> +
>>>>> +	return -1;
>>>>> +}
>>>>> +
>>>>> +int handle_misaligned_store(struct pt_regs *regs)
>>>>> +{
>>>>> +	if (IS_ENABLED(CONFIG_RISCV_MISALIGNED))
>>>>> +		return handle_scalar_misaligned_store(regs);
>>>>> +
>>>>> +	return -1;
>>>>> +}
>>>>> +
>>>>> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
>>>>> +static void check_vector_unaligned_access_emulated(struct work_struct *unused)
>>>>> +{
>>>>> +	long *mas_ptr = this_cpu_ptr(&vector_misaligned_access);
>>>>> +	unsigned long tmp_var;
>>>>> +
>>>>> +	*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>>>> +
>>>>> +	local_irq_enable();
>> @Evan Green I forgot to remove this from when when I was using
>> smp_call_on_cpu and encountered the problem you descibed.
>> They can be removed.
>>
>>>>> +	kernel_vector_begin();
>>>>> +	__asm__ __volatile__ (
>>>>> +		".balign 4\n\t"
>>>>> +		".option push\n\t"
>>>>> +		".option arch, +zve32x\n\t"
>>>>> +		"       vsetivli zero, 1, e16, m1, ta, ma\n\t"	// Vectors of 16b
>>>>> +		"       vle16.v v0, (%[ptr])\n\t"		// Load bytes
>>>>> +		".option pop\n\t"
>>>>> +		: : [ptr] "r" ((u8 *)&tmp_var + 1) : "v0");
>>>>> +	kernel_vector_end();
>> 	if (*mas_ptr == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
>> 		*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_SLOW;
>>
>>>>> +}
>>>>> +
>>>>> +bool check_vector_unaligned_access_emulated_all_cpus(void)
>>>
>>> Hopefully I catch the final things I want to say in this email ;)
>>>
>>>>> +{
>>>>> +	int cpu;
>>>>> +	bool ret = true;
>>>>> +
>>>>> +	if (!has_vector()) {
>>>>> +		for_each_online_cpu(cpu)
>>>>> +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>>>>> +		return false;
>>>>> +	}
>>>>> +
>>>>> +	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
>>>>> +
>>>>> +	for_each_online_cpu(cpu)
>>>>> +		if (per_cpu(vector_misaligned_access, cpu)
>>>>> +		    != RISCV_HWPROBE_VEC_MISALIGNED_SLOW)
>>>>> +			return false;
>>>
>>> The default value of vector_misaligned_access is
>>> RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED so when the hardware supports
>>> unaligned accesses this will return false. If the hardware doesn't
>>> support unaligned accesses, then the trap will happen and the kernel
>>> will set this variable to UNSUPPORTED, causing this function to again
>>> return false.
>>>
>>> Having the default value be UNKNOWN and checking for UNKNOWN here and in
>>> check_vector_unaligned_access() can remedy this issue.
>>
>> I meant to set it to SLOW in check_vector_unaligned_access_emulated like
>> above.
> 
> What "it" are you referring to?

`per_cpu(vector_misaligned_access, cpu)`

> UNKNOWN should be the default internally
> here, not SLOW. Before probing is done, the speed is unknown, so UNKNOWN
> is the logical default.

The scalar hwprobe returns SLOW if misaligned accesses are not emulated. 
Rather then storing UNKNOWN in the kernel, I thought it would be better 
to set it to slow until we know its fast as it has the same affect as 
swaping unknown for slow in sys_hwprobe. The reason i want to keep the 
code like this is because if missaligned vector loads work then sudenly 
dont we wont ignore them in handle_vector_misaligned_load because the 
the instruction should have worked. I can change it to be unknown though 
and swap UNKNOWN for SLOW in hwprobe.

Thanks,
Jesse Taube
> 
>>
>>> - Charlie
>>>
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +#else
>>>>> +bool check_vector_unaligned_access_emulated_all_cpus(void)
>>>>> +{
>>>>> +	return false;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>> +#ifdef CONFIG_RISCV_MISALIGNED
>>>>> +
>>>>> +static bool unaligned_ctl __read_mostly;
>>>>> +
>>>>>    static void check_unaligned_access_emulated(struct work_struct *unused)
>>>>>    {
>>>>>    	int cpu = smp_processor_id();
>>>>> @@ -563,3 +668,9 @@ bool unaligned_ctl_available(void)
>>>>>    {
>>>>>    	return unaligned_ctl;
>>>>>    }
>>>>> +#else
>>>>> +bool check_unaligned_access_emulated_all_cpus(void)
>>>>> +{
>>>>> +	return false;
>>>>> +}
>>>>> +#endif
>>>>> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
>>>>> index 70c1588fc353..c6106bd4a25a 100644
>>>>> --- a/arch/riscv/kernel/unaligned_access_speed.c
>>>>> +++ b/arch/riscv/kernel/unaligned_access_speed.c
>>>>> @@ -19,7 +19,8 @@
>>>>>    #define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
>>>>>    #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>>>>> -DEFINE_PER_CPU(long, misaligned_access_speed);
>>>>> +DEFINE_PER_CPU(long, misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
>>>>> +DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>>>>>    #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>>>>>    static cpumask_t fast_misaligned_access;
>>>>> @@ -268,12 +269,18 @@ static int check_unaligned_access_all_cpus(void)
>>>>>    	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
>>>>>    		for_each_online_cpu(cpu) {
>>>>> +#ifdef CONFIG_RISCV_VECTOR_MISALIGNED
>>>>> +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_FAST;
>>>>> +#endif
>>>>> +#ifdef CONFIG_RISCV_MISALIGNED
>>>>>    			per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
>>>>> +#endif
>>>>>    		}
>>>>>    		return 0;
>>>>
>>>> Since this function returns 0 in both cases, can you wrap the rest of
>>>> the function with an else and remove this early return?
>>
>> I think its more readable in a guard clause style.
> 
> By guard clause style are you referring to how it is right now? 

yes.

> It's the
> same return value of 0 in both cases and the most common way of doing
> that is by having a single line for the return at the bottom of the
> function instead of duplicating the return.
> 
> - Charlie
> 
>>
>>
>> Thanks,
>> Jesse Taube
>>>> - Charlie
>>>>
>>>>>    	}
>>>>>    	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>>>>> +	check_vector_unaligned_access_emulated_all_cpus();
>>>>>    #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>>>>>    	if (!all_cpus_emulated)
>>>>> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
>>>>> index 682b3feee451..821818886fab 100644
>>>>> --- a/arch/riscv/kernel/vector.c
>>>>> +++ b/arch/riscv/kernel/vector.c
>>>>> @@ -66,7 +66,7 @@ void __init riscv_v_setup_ctx_cache(void)
>>>>>    #endif
>>>>>    }
>>>>> -static bool insn_is_vector(u32 insn_buf)
>>>>> +bool insn_is_vector(u32 insn_buf)
>>>>>    {
>>>>>    	u32 opcode = insn_buf & __INSN_OPCODE_MASK;
>>>>>    	u32 width, csr;
>>>>> -- 
>>>>> 2.43.0
>>>>>

