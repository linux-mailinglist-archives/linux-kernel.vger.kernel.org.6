Return-Path: <linux-kernel+bounces-206688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DA5900CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD751F22FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4470914A4C3;
	Fri,  7 Jun 2024 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fQv1RcDd"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF0A20
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791082; cv=none; b=e5FTxpDNfWk7Rit2ZopcHTLfJB/zKdkrQ5mqbTO7o5K8bHa3XEP6AI1qJwLvzH1aGnjYAB9E0VVbvH5WSWyvy81zQ8VUCviKMwDgq69SVmcqR8JTA/6eBMQS40A1cDSu151Ws/iGLVungSroxU3xejM9F/NN2O+9kUOSO6RGs98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791082; c=relaxed/simple;
	bh=m7jIn9u3tRkm6Nj8l4m9YISdz2M4lx527TLTMzNkWLg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pKOsJzqAnOF+z32LOXCV3V+KVPYcnsz1vyKsfEnHS099KQkN3t3MlAt/0cyck7LwU0FFlSU9ty2s0WYuKNGeKki7USFnjfSEscAF+27sIH0Zg7DYTgp4p3/gA9bZibuIpvr7nk7OTQGPqihylu92D6S/fpHJZct0y7Q5mnCF/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fQv1RcDd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7025c5e6b94so2100195b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717791079; x=1718395879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMGkjpYn+jV6b3kp9qg5TmurkoWSYutcUIhlVSBuPJY=;
        b=fQv1RcDd/3/GLgVLQrqV9YXgWHFgzRQYoi3LdPPFgyv7o+cH6G4SVklGZ1iHG7qSez
         vLaSrQ0yOUeN3bf99N05Bd9BTexB/c7rMkoHkpaqiHokpr14W8/6sE505pSAbDMHQ6IO
         z/N9Y918Wd9kSV6mmPsINmR3uyIrbJbRcbA12jyTtR7GYWgUI3PH2rThO1RcomPBDyFv
         6BA1JAmfy5HwvnwZiWhwCfAcvd667+gmxMRZWSpzZvxc6DDC5wjAQ4dcKMXp7rTwsyzG
         hTgBwZ1wDIc8E9EX6oky8tvp6HMwf6qx2scWea3Fp+szMyMGEgsYkg6ATplxumsDQWof
         DHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717791079; x=1718395879;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMGkjpYn+jV6b3kp9qg5TmurkoWSYutcUIhlVSBuPJY=;
        b=ehKqd8S8kIgAl5EPH+vMTIAJNBAw3uYLu+fPumgFL2M8l4CyQ3BSRdhwP1DdRbLktG
         yj0V9+uxik/wb2BEUN322zT08ootudTpbKNTw3rKSnwnRLYQmTAVLjfGq/OSqIUQsLuu
         Ghx0CsmB/E3+fl98mVy5Vb9CRlX3NPXDbj+JvNi5VpIxzzmGR8XXD8EW5Y5k8VJZZs3+
         8TDWliXtNPZdvGKzOdVvmDH+2ZAFncuy4E2RRvpinAT/44Fv4bJXpc3NIyE5TmJ8fZhD
         qCONLMkNn/IcFzJMhN0DfZH11GPPXRQy6lN6FUYW22Ut93rtPclJJ62KDScZCQGISOQx
         QUcg==
X-Forwarded-Encrypted: i=1; AJvYcCWREI+e6//Dl7j6vTnOSnpdQcPZTWqTbQhvEYFwHhQB9wZxyC8U9/0nR/TEeVdY2Dg3psl/NdsfPLdTQ0y6RBsX/CVn8IVB9vc656LB
X-Gm-Message-State: AOJu0Yz5NPCLaPN+Ed9SxnZdTk7cnfJIyOs419oW6oLpruGuVsrm/8s9
	1PdNDaIm1jLq5+4FovlCao0WNZrD9CqBibKiJG8fXQIf3jSxRRil4wwiPsxEPM0=
X-Google-Smtp-Source: AGHT+IHEAGGVS2q5mKXSE02SNDqd/1zaFvS6jCYDtkIV/Gc+Y296PvvfudxJ9Hne4J3iAVVaOOzKLA==
X-Received: by 2002:a05:6a20:4306:b0:1b2:7004:5103 with SMTP id adf61e73a8af0-1b2f9cb8da0mr4038487637.47.1717791078979;
        Fri, 07 Jun 2024 13:11:18 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c4928cesm3992783a91.51.2024.06.07.13.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:11:18 -0700 (PDT)
Message-ID: <09d72f4e-170c-4f62-83ff-3053804038a7@rivosinc.com>
Date: Fri, 7 Jun 2024 16:11:04 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] RISC-V: Detect unaligned vector accesses supported.
From: Jesse Taube <jesse@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley
 <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Xiao Wang <xiao.w.wang@intel.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Andy Chiu <andy.chiu@sifive.com>, Greentime Hu <greentime.hu@sifive.com>,
 Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Erick Archer <erick.archer@gmx.com>,
 Vincent Chen <vincent.chen@sifive.com>,
 Joel Granados <j.granados@samsung.com>, linux-kernel@vger.kernel.org
References: <20240606183215.416829-1-jesse@rivosinc.com>
 <20240606183215.416829-2-jesse@rivosinc.com> <ZmIqM3Cuui0HAwN1@ghost>
 <ZmJCq7bsglq7olSB@ghost> <a16ccf51-4b06-4c6d-94a1-cb43dc3f2945@rivosinc.com>
Content-Language: en-US
In-Reply-To: <a16ccf51-4b06-4c6d-94a1-cb43dc3f2945@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/7/24 15:53, Jesse Taube wrote:
> 
> 
> On 6/6/24 19:13, Charlie Jenkins wrote:
>> On Thu, Jun 06, 2024 at 02:29:23PM -0700, Charlie Jenkins wrote:
>>> On Thu, Jun 06, 2024 at 02:32:14PM -0400, Jesse Taube wrote:
>>>> Run a unaligned vector access to test if the system supports
>>>> vector unaligned access. Add the result to a new key in hwprobe.
>>>> This is useful for usermode to know if vector misaligned accesses are
>>>> supported and if they are faster or slower than equivalent byte accesses.
>>>>
>>>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>>>> ---
>>>>    arch/riscv/include/asm/cpufeature.h        |  2 +
>>>>    arch/riscv/include/asm/hwprobe.h           |  2 +-
>>>>    arch/riscv/include/asm/vector.h            |  1 +
>>>>    arch/riscv/include/uapi/asm/hwprobe.h      |  6 ++
>>>>    arch/riscv/kernel/sys_hwprobe.c            | 34 +++++++++
>>>>    arch/riscv/kernel/traps_misaligned.c       | 84 ++++++++++++++++++++--
>>>>    arch/riscv/kernel/unaligned_access_speed.c |  4 ++
>>>>    arch/riscv/kernel/vector.c                 |  2 +-
>>>>    8 files changed, 129 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>>>> index 347805446151..a012c8490a27 100644
>>>> --- a/arch/riscv/include/asm/cpufeature.h
>>>> +++ b/arch/riscv/include/asm/cpufeature.h
>>>> @@ -35,9 +35,11 @@ void riscv_user_isa_enable(void);
>>>>    
>>>>    #if defined(CONFIG_RISCV_MISALIGNED)
>>>>    bool check_unaligned_access_emulated_all_cpus(void);
>>>> +bool check_vector_unaligned_access_all_cpus(void);
>>>>    void unaligned_emulation_finish(void);
>>>>    bool unaligned_ctl_available(void);
>>>>    DECLARE_PER_CPU(long, misaligned_access_speed);
>>>> +DECLARE_PER_CPU(long, vector_misaligned_access);
>>>>    #else
>>>>    static inline bool unaligned_ctl_available(void)
>>>>    {
>>>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
>>>> index 630507dff5ea..150a9877b0af 100644
>>>> --- a/arch/riscv/include/asm/hwprobe.h
>>>> +++ b/arch/riscv/include/asm/hwprobe.h
>>>> @@ -8,7 +8,7 @@
>>>>    
>>>>    #include <uapi/asm/hwprobe.h>
>>>>    
>>>> -#define RISCV_HWPROBE_MAX_KEY 6
>>>> +#define RISCV_HWPROBE_MAX_KEY 7
>>>>    
>>>>    static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>>>    {
>>>> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
>>>> index 731dcd0ed4de..776af9b37e23 100644
>>>> --- a/arch/riscv/include/asm/vector.h
>>>> +++ b/arch/riscv/include/asm/vector.h
>>>> @@ -21,6 +21,7 @@
>>>>    
>>>>    extern unsigned long riscv_v_vsize;
>>>>    int riscv_v_setup_vsize(void);
>>>> +bool insn_is_vector(u32 insn_buf);
>>>>    bool riscv_v_first_use_handler(struct pt_regs *regs);
>>>>    void kernel_vector_begin(void);
>>>>    void kernel_vector_end(void);
>>>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
>>>> index 060212331a03..ebacff86f134 100644
>>>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>>>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>>>> @@ -68,6 +68,12 @@ struct riscv_hwprobe {
>>>>    #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
>>>>    #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>>>>    #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>>>> +#define RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF	7
>>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN		0
>>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED		1
>>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_SLOW		2
>>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_FAST		3
>>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED	4
>>>>    /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>>>    
>>>>    /* Flags */
>>>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
>>>> index b286b73e763e..ce641cc6e47a 100644
>>>> --- a/arch/riscv/kernel/sys_hwprobe.c
>>>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>>>> @@ -184,6 +184,36 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>>>>    }
>>>>    #endif
>>>>    
>>>> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>>>> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>>>> +{
>>>> +	int cpu;
>>>> +	u64 perf = -1ULL;
>>>> +
>>>> +	for_each_cpu(cpu, cpus) {
>>>> +		int this_perf = per_cpu(vector_misaligned_access, cpu);
>>>> +
>>>> +		if (perf == -1ULL)
>>>> +			perf = this_perf;
>>>> +
>>>> +		if (perf != this_perf) {
>>>> +			perf = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (perf == -1ULL)
>>>> +		return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>>> +
>>>> +	return perf;
>>>> +}
>>>> +#else
>>>> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>>>> +{
>>
>> I meant to mention this in my last message!
>>
>> The scalar version has cutouts for configs here like:
>>
>> 	if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS))
>> 		return RISCV_HWPROBE_MISALIGNED_FAST;
>>
> 

For both scalar and vector CONFIG_RISCV_PROBE_UNALIGNED_ACCESS probes 
the speed not support. So misaligned_access_speed will have a valid value.

```

	if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_VEC_UNALIGNED_ACCESS))
		return RISCV_HWPROBE_MISALIGNED_FAST;

	if(IS_ENABLED(CONFIG_RISCV_SLOW_VEC_UNALIGNED_ACCESS))
		return RISCV_HWPROBE_VEC_MISALIGNED_SLOW;

	if(IS_ENABLED(CONFIG_RISCV_VEC_UNALIGNED_ACCESS))
		
/* Sence we cant gurentee that we do have UNALIGNED_ACCESS we can return 
the result from the test */

		return per_cpu(vector_misaligned_access, cpu);

	return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
```

> Will add
> 
>> Having this functionality on vector as well would be much appreciated.
>> I don't think it's valid to assume that vector and scalar have the same
>> speed, so this would require a vector version of the RISCV_MISALIGNED
>> tree in arch/riscv/Kconfig.
>>
>> - Charlie
>>
>>>> +	return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>>> +}
>>>> +#endif
>>>> +
>>>>    static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>>>    			     const struct cpumask *cpus)
>>>>    {
>>>> @@ -211,6 +241,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>>>    		pair->value = hwprobe_misaligned(cpus);
>>>>    		break;
>>>>    
>>>> +	case RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF:
>>>> +		pair->value = hwprobe_vec_misaligned(cpus);
>>>> +		break;
>>>> +
>>>>    	case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>>>>    		pair->value = 0;
>>>>    		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>>>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>>>> index 2adb7c3e4dd5..8f26c3d92230 100644
>>>> --- a/arch/riscv/kernel/traps_misaligned.c
>>>> +++ b/arch/riscv/kernel/traps_misaligned.c
>>>> @@ -16,6 +16,7 @@
>>>>    #include <asm/entry-common.h>
>>>>    #include <asm/hwprobe.h>
>>>>    #include <asm/cpufeature.h>
>>>> +#include <asm/vector.h>
>>>>    
>>>>    #define INSN_MATCH_LB			0x3
>>>>    #define INSN_MASK_LB			0x707f
>>>> @@ -413,10 +414,6 @@ int handle_misaligned_load(struct pt_regs *regs)
>>>>    
>>>>    	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>>>>    
>>>> -#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>>>> -	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
>>>> -#endif
>>>> -
>>>>    	if (!unaligned_enabled)
>>>>    		return -1;
>>>>    
>>>> @@ -426,6 +423,17 @@ int handle_misaligned_load(struct pt_regs *regs)
>>>>    	if (get_insn(regs, epc, &insn))
>>>>    		return -1;
>>>>    
>>>> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>>>> +	if (insn_is_vector(insn) &&
>>>> +	    *this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED) {
>>>> +		*this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>>>> +		regs->epc = epc + INSN_LEN(insn);
>>>> +		return 0;
> 
> There is a return before scalar speed is set.
> 
>>>> +	}
>>>> +
>>>> +	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
>>>
>>> This unconditionally sets scalar unaligned accesses even if the
>>> unaligned access is caused by vector. Scalar unaligned accesses should
>>> only be set to emulated if this function is entered from a scalar
>>> unaligned load.
>>>
>>> The rest of this function handles how scalar unaligned accesses are
>>> emulated, and the equivalent needs to happen for vector. You need to add
>>> routines that manually load the data from the memory address into the
>>> vector register. When Clément did this for scalar, he provided a test
>>> case to help reviewers [1]. Please add onto these test cases or make
>>> your own for vector.
> 
> I wansnt planing on adding emulation in this patch. I can if needed.
> 
>>>
>>> Link: https://github.com/clementleger/unaligned_test [1]
>>>
>>>> +#endif
>>>> +
>>>>    	regs->epc = 0;
>>>>    
>>>>    	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
>>>> @@ -625,6 +633,74 @@ static bool check_unaligned_access_emulated(int cpu)
>>>>    	return misaligned_emu_detected;
>>>>    }
>>>>    
>>>> +#ifdef CONFIG_RISCV_ISA_V
>>>> +static void check_vector_unaligned_access(struct work_struct *unused)
>>>
>>> Can you standardize this name with the scalar version by writing
>>> emulated in it?
> 
> We dont emulate it so that wouldn't make sence.
> 
>>>
>>> "check_vector_unaligned_access_emulated_all_cpus"
>>>
>>>> +{
>>>> +	int cpu = smp_processor_id();
>>>> +	long *mas_ptr = this_cpu_ptr(&vector_misaligned_access);
>>>> +	unsigned long tmp_var;
>>>> +
>>>> +	if (!riscv_isa_extension_available(hart_isa[cpu].isa, v))
>>>> +		return;
>>>> +
>>>> +	*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
>>>> +
>>>> +	local_irq_enable();
>>>> +	kernel_vector_begin();
>>>> +	__asm__ __volatile__ (
>>>> +		".balign 4\n\t"
>>>> +		".option push\n\t"
>>>> +		".option arch, +v\n\t"
>>>> +		"       vsetivli zero, 1, e16, m1, ta, ma\n\t"	// Vectors of 16b
>>>> +		"	vle16.v v0, (%[ptr])\n\t"		// Load bytes
>>>> +		".option pop\n\t"
>>>> +		: : [ptr] "r" ((u8 *)&tmp_var + 1) : "v0", "memory");
>>>
>>> memory is being read from, but not written to, so there is no need to
>>> have a memory clobber.
> 
> fixed.
> 
>>>
>>>> +	kernel_vector_end();
>>>> +
>>>> +	if (*mas_ptr == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
>>>> +		*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
>>>> +}
>>>> +
>>>> +bool check_vector_unaligned_access_all_cpus(void)
>>>> +{
>>>> +	int cpu;
>>>> +	bool ret = true;
>>>> +
>>>> +	for_each_online_cpu(cpu)
>>>> +		if (riscv_isa_extension_available(hart_isa[cpu].isa, ZICCLSM))
>>>
>>> zicclsm is not specific to vector so it can be extracted out of this
>>> vector specific function. Assuming that hardware properly reports the
>>> extension, if zicclsm is present then it is known that both vector and
>>> scalar unaligned accesses are supported.
> 
> Added so we don't need to waste cycles testing support.
> 
>>>> +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
>>>
>>> Please use the exising UNKNOWN terminology instead of renaming to
>>> SUPPORTED. Any option that is not UNSUPPORTED implies that unaligned
>>> accesses are supported.
> 
> Conor didnt like using UNKNOWN a proxy for "SUPPORTED"
> Having SUPPORTED is better then assuing the speed to be slow.
> 
>>>
>>>> +		else
>>>> +			ret = false;
>>>> +
>>>> +
>>>> +	if (ret)
>>>> +		return true;
>>>> +	ret = true;
>>>> +
>>>> +	schedule_on_each_cpu(check_vector_unaligned_access);
>>>> +
>>>> +	for_each_online_cpu(cpu)
>>>> +		if (per_cpu(vector_misaligned_access, cpu)
>>>> +		    != RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED)
>>>> +			return false;
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +#else
>>>
>>> If CONFIG_RISCV_ISA_V is not set, there is no value in checking if
>>> vector unaligned accesses are supported because userspace will not be
>>> allowed to use vector instructions anyway.
> 
> Oh I'm silly meant to be seting to all UNSUPPORTED.
> 
> 
> Thanks,
> Jesse Taube
> 
>>>
>>> - Charlie
>>>
>>>> +bool check_vector_unaligned_access_all_cpus(void)
>>>> +{
>>>> +	int cpu;
>>>> +
>>>> +	for_each_online_cpu(cpu)
>>>> +		if (riscv_isa_extension_available(hart_isa[cpu].isa, ZICCLSM))
>>>> +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
>>>> +		else
>>>> +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>>>> +
>>>> +	return false;
>>>> +}
>>>> +#endif
>>>> +
>>>>    bool check_unaligned_access_emulated_all_cpus(void)
>>>>    {
>>>>    	int cpu;
>>>> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
>>>> index a9a6bcb02acf..92a84239beaa 100644
>>>> --- a/arch/riscv/kernel/unaligned_access_speed.c
>>>> +++ b/arch/riscv/kernel/unaligned_access_speed.c
>>>> @@ -20,6 +20,7 @@
>>>>    #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>>>>    
>>>>    DEFINE_PER_CPU(long, misaligned_access_speed);
>>>> +DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>>>    
>>>>    #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>>>>    static cpumask_t fast_misaligned_access;
>>>> @@ -264,6 +265,8 @@ static int check_unaligned_access_all_cpus(void)
>>>>    {
>>>>    	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>>>>    
>>>> +	check_vector_unaligned_access_all_cpus();
>>>> +
>>>>    	if (!all_cpus_emulated)
>>>>    		return check_unaligned_access_speed_all_cpus();
>>>>    
>>>> @@ -273,6 +276,7 @@ static int check_unaligned_access_all_cpus(void)
>>>>    static int check_unaligned_access_all_cpus(void)
>>>>    {
>>>>    	check_unaligned_access_emulated_all_cpus();
>>>> +	check_vector_unaligned_access_all_cpus();
>>>>    
>>>>    	return 0;
>>>>    }
>>>> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
>>>> index 6727d1d3b8f2..2cceab739b2c 100644
>>>> --- a/arch/riscv/kernel/vector.c
>>>> +++ b/arch/riscv/kernel/vector.c
>>>> @@ -66,7 +66,7 @@ void __init riscv_v_setup_ctx_cache(void)
>>>>    #endif
>>>>    }
>>>>    
>>>> -static bool insn_is_vector(u32 insn_buf)
>>>> +bool insn_is_vector(u32 insn_buf)
>>>>    {
>>>>    	u32 opcode = insn_buf & __INSN_OPCODE_MASK;
>>>>    	u32 width, csr;
>>>> -- 
>>>> 2.43.0
>>>>

