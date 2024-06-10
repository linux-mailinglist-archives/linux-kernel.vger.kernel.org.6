Return-Path: <linux-kernel+bounces-208854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EFF9029E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3AA1F24962
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764D2E859;
	Mon, 10 Jun 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="inGjXsBn"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483B405E6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050694; cv=none; b=cycjsGF26pfUy44m+s+iuLvkfuO3x7TCEBt0NRt9IR2BGAvMUjojxuzkF9l84jR45qxYq2VdNuM0o+4fjldKLCwR7ICJ9sKMVBGbQCro7D0QDjVPEx45bYeJsmQClLDIwQjzWzXri0Oh0fvd3PAGl7dykQTLmPpaLrQ4pwfD4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050694; c=relaxed/simple;
	bh=XLvDQMRnxnxR1QpuBv3otWyLwyAS26uJa/S62PwMgc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QC4kjDvOM0Nry5y1ie98odbXTuY92/Qf45f/PeEFfryoP7KCxv7hbNCXcMl4pZEj+Gntm5GPKlwKJWSqUXWr2hUW/lDJdxBn+Scm20WZhy88TJIzo1kgxmRo/P15SnU4RMeWmF1jajzJlyc1Iq2plFtfmlGYK/omI0VnU9N5xqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=inGjXsBn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7046e87e9afso308348b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718050692; x=1718655492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKkcb2jM+ppusduMNChAJbzryvmYnsifTYRBBBChgrY=;
        b=inGjXsBn2F3NQnDiYPosVg04/cSukY93I+bpExPYhHwk8Qm4AC+d+d9jeVUadTDZml
         b+2z9Pwa5vawMOo4Wx9KWTC6o8N5DB7gmq29U/mb7DrWNChNt0o/r4dbcc96oR5D7qWN
         0vA22AniME5U7IBKYrRxbsvSVFJM3Gupe0MINemBd6oHWB9wJ10klAxltPC0zF6poaU4
         fbBv9dbiKKweJew3dGsne4DR+ifdJ4njX2SCeovXpqiMF7YwayxXJ7uSHtjKJHpxVWMe
         c5yLFmJgNSewYioLeiSrNaaGz2JC7EFJGyI7I5lKskwstUyQuBhU0Gm3MNJa95u3pX+D
         F3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718050692; x=1718655492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKkcb2jM+ppusduMNChAJbzryvmYnsifTYRBBBChgrY=;
        b=LAkb1Ow+pukDi/h4nZdW5pxaHiNQWuKFHUzRgSyM0ayzjVu5xuNhqnhFro9cx+7Ihq
         Ol+62SQOCn+ejiekJH1OZ8iuMAnRlmQRni/6RrN1p75ruGzpSoe1YMX6+oTV0vXcay5d
         g2CG9xIwQWWEKi/McNK0SDVApPLH5JtpM0l7x0OQf7CYtHXFyt0WbnUNgSBLnJ2kt4C6
         SGbi0SaVLrxqJSXzBLU1mwS8Y3dFxnRo84XoLs1vB56ougrj+aB0vPGrpsKvkJnUhYUZ
         8xxDikFZ2ZN0ynNrtaa5+Yo3iatjQ55aZZzzqInEJt6vDB3SVc++Hos2s3FMaTi5zQhg
         Qm3w==
X-Forwarded-Encrypted: i=1; AJvYcCXXFRQsUsVBkP3xcf8v+4ooEnPRF8EhmCuM+V3xwfc0FRiCUkKUA6MmJPc4w6arS+Ef++FBZm52NYmcOOepU68UsxmiBtxNFM7aUZau
X-Gm-Message-State: AOJu0YwwsbpauwhiayU88p3N5j7mz0UvXAT95VwhF619qvLsNB7cRQeC
	oQVSXDLV7PA3S81YzNQkxHQqKS7f2V1lfNdxPu/aXmqdlRA9BqihbIQb9LVqDBg=
X-Google-Smtp-Source: AGHT+IGtX0mOQaeyJ7B4/4ZfngkkRnMuLSJkJ0kxXpLB8KDJspPlM8KiqqKvpe/+bS+7e2p1GCfXsQ==
X-Received: by 2002:a05:6a00:190c:b0:704:3afb:e9cd with SMTP id d2e1a72fcca58-7043afbeff3mr3861856b3a.34.1718050691723;
        Mon, 10 Jun 2024 13:18:11 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041ec6f9cesm4781831b3a.78.2024.06.10.13.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 13:18:11 -0700 (PDT)
Message-ID: <192d7bf0-9e9f-45b9-8c15-be249c40ce2f@rivosinc.com>
Date: Mon, 10 Jun 2024 16:17:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] RISC-V: Detect unaligned vector accesses supported.
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley
 <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Xiao Wang <xiao.w.wang@intel.com>,
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
 <5284ad23-9870-41cd-893e-f17170af90f8@rivosinc.com>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <5284ad23-9870-41cd-893e-f17170af90f8@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/10/24 04:23, Clément Léger wrote:
> 
> 
> On 06/06/2024 23:29, Charlie Jenkins wrote:
>> On Thu, Jun 06, 2024 at 02:32:14PM -0400, Jesse Taube wrote:
>>> Run a unaligned vector access to test if the system supports
>>> vector unaligned access. Add the result to a new key in hwprobe.
>>> This is useful for usermode to know if vector misaligned accesses are
>>> supported and if they are faster or slower than equivalent byte accesses.
>>>
>>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>>> ---
>>>   arch/riscv/include/asm/cpufeature.h        |  2 +
>>>   arch/riscv/include/asm/hwprobe.h           |  2 +-
>>>   arch/riscv/include/asm/vector.h            |  1 +
>>>   arch/riscv/include/uapi/asm/hwprobe.h      |  6 ++
>>>   arch/riscv/kernel/sys_hwprobe.c            | 34 +++++++++
>>>   arch/riscv/kernel/traps_misaligned.c       | 84 ++++++++++++++++++++--
>>>   arch/riscv/kernel/unaligned_access_speed.c |  4 ++
>>>   arch/riscv/kernel/vector.c                 |  2 +-
>>>   8 files changed, 129 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>>> index 347805446151..a012c8490a27 100644
>>> --- a/arch/riscv/include/asm/cpufeature.h
>>> +++ b/arch/riscv/include/asm/cpufeature.h
>>> @@ -35,9 +35,11 @@ void riscv_user_isa_enable(void);
>>>   
>>>   #if defined(CONFIG_RISCV_MISALIGNED)
>>>   bool check_unaligned_access_emulated_all_cpus(void);
>>> +bool check_vector_unaligned_access_all_cpus(void);
>>>   void unaligned_emulation_finish(void);
>>>   bool unaligned_ctl_available(void);
>>>   DECLARE_PER_CPU(long, misaligned_access_speed);
>>> +DECLARE_PER_CPU(long, vector_misaligned_access);
>>>   #else
>>>   static inline bool unaligned_ctl_available(void)
>>>   {
>>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
>>> index 630507dff5ea..150a9877b0af 100644
>>> --- a/arch/riscv/include/asm/hwprobe.h
>>> +++ b/arch/riscv/include/asm/hwprobe.h
>>> @@ -8,7 +8,7 @@
>>>   
>>>   #include <uapi/asm/hwprobe.h>
>>>   
>>> -#define RISCV_HWPROBE_MAX_KEY 6
>>> +#define RISCV_HWPROBE_MAX_KEY 7
>>>   
>>>   static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>>   {
>>> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
>>> index 731dcd0ed4de..776af9b37e23 100644
>>> --- a/arch/riscv/include/asm/vector.h
>>> +++ b/arch/riscv/include/asm/vector.h
>>> @@ -21,6 +21,7 @@
>>>   
>>>   extern unsigned long riscv_v_vsize;
>>>   int riscv_v_setup_vsize(void);
>>> +bool insn_is_vector(u32 insn_buf);
>>>   bool riscv_v_first_use_handler(struct pt_regs *regs);
>>>   void kernel_vector_begin(void);
>>>   void kernel_vector_end(void);
>>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
>>> index 060212331a03..ebacff86f134 100644
>>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>>> @@ -68,6 +68,12 @@ struct riscv_hwprobe {
>>>   #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
>>>   #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>>>   #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
>>> +#define RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF	7
>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN		0
>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED		1
>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_SLOW		2
>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_FAST		3
>>> +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED	4
>>>   /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>>   
>>>   /* Flags */
>>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
>>> index b286b73e763e..ce641cc6e47a 100644
>>> --- a/arch/riscv/kernel/sys_hwprobe.c
>>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>>> @@ -184,6 +184,36 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>>>   }
>>>   #endif
>>>   
>>> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>>> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>>> +{
>>> +	int cpu;
>>> +	u64 perf = -1ULL;
>>> +
>>> +	for_each_cpu(cpu, cpus) {
>>> +		int this_perf = per_cpu(vector_misaligned_access, cpu);
>>> +
>>> +		if (perf == -1ULL)
>>> +			perf = this_perf;
>>> +
>>> +		if (perf != this_perf) {
>>> +			perf = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	if (perf == -1ULL)
>>> +		return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>> +
>>> +	return perf;
>>> +}
>>> +#else
>>> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>>> +{
>>> +	return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>> +}
>>> +#endif
>>> +
>>>   static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>>   			     const struct cpumask *cpus)
>>>   {
>>> @@ -211,6 +241,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>>   		pair->value = hwprobe_misaligned(cpus);
>>>   		break;
>>>   
>>> +	case RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF:
>>> +		pair->value = hwprobe_vec_misaligned(cpus);
>>> +		break;
>>> +
>>>   	case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>>>   		pair->value = 0;
>>>   		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>>> index 2adb7c3e4dd5..8f26c3d92230 100644
>>> --- a/arch/riscv/kernel/traps_misaligned.c
>>> +++ b/arch/riscv/kernel/traps_misaligned.c
>>> @@ -16,6 +16,7 @@
>>>   #include <asm/entry-common.h>
>>>   #include <asm/hwprobe.h>
>>>   #include <asm/cpufeature.h>
>>> +#include <asm/vector.h>
>>>   
>>>   #define INSN_MATCH_LB			0x3
>>>   #define INSN_MASK_LB			0x707f
>>> @@ -413,10 +414,6 @@ int handle_misaligned_load(struct pt_regs *regs)
>>>   
>>>   	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>>>   
>>> -#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>>> -	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
>>> -#endif
>>> -
>>>   	if (!unaligned_enabled)
>>>   		return -1;
>>>   
>>> @@ -426,6 +423,17 @@ int handle_misaligned_load(struct pt_regs *regs)
>>>   	if (get_insn(regs, epc, &insn))
>>>   		return -1;
>>>   
>>> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>>> +	if (insn_is_vector(insn) &&
>>> +	    *this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED) {
>>> +		*this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>>> +		regs->epc = epc + INSN_LEN(insn);
>>> +		return 0;
>>> +	}

I'm going to add


+	/* If vector instruction we don't emulate it yet */
+	if (insn_is_vector(insn)) {
+		regs->epc = epc;
+		return -1;
+	}

>>> +
>>> +	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
>>
>> This unconditionally sets scalar unaligned accesses even if the
>> unaligned access is caused by vector. Scalar unaligned accesses should
>> only be set to emulated if this function is entered from a scalar
>> unaligned load.
>>

Im sorry I missunderstood what you were reffering to. The check above 
does return, but you are saying when a misaligned vector does come here.

If a misaligned vector load trap does happen when we arent checking
it will still cause a fault as `vector_misaligned_access != 
RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED`. Basicaly the return 0 above 
will only ever be posible duing check_vector_unaligned_access.

>> The rest of this function handles how scalar unaligned accesses are
>> emulated, and the equivalent needs to happen for vector.

I am hesitant to do so because I have very little knowlage of how RVV 
works. It will maintain the previous behavoir of trapping if
VEC_MISALIGNED_UNSUPPORTED.

> You need to add
>> routines that manually load the data from the memory address into the
>> vector register. When Clément did this for scalar, he provided a test
>> case to help reviewers [1]. Please add onto these test cases or make
>> your own for vector.
>>
>> Link: https://github.com/clementleger/unaligned_test [1]

I will add a test.

> 
> Hi Jesse,
> 
> I already mentionned that in a previous message and got no answer [1].
> Please address all feedback before sending another version. Adding a
> cover letter for such series would also be appreciated.

Sorry I didnt understand and thought your question was the same as
charlies.

Thanks,
Jesse Taube

> 
> Thanks,
> 
> Clément
> 
> Link :https://lore.kernel.org/all/2c355b76-c768-46b1-9f37
> fd1991a54bfd@rivosinc.com/ [1]
> 
>>
>>> +#endif
>>> +
>>>   	regs->epc = 0;
>>>   
>>>   	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
>>> @@ -625,6 +633,74 @@ static bool check_unaligned_access_emulated(int cpu)
>>>   	return misaligned_emu_detected;
>>>   }
>>>   
>>> +#ifdef CONFIG_RISCV_ISA_V
>>> +static void check_vector_unaligned_access(struct work_struct *unused)
>>
>> Can you standardize this name with the scalar version by writing
>> emulated in it?
>>
>> "check_vector_unaligned_access_emulated_all_cpus"
>>
>>> +{
>>> +	int cpu = smp_processor_id();
>>> +	long *mas_ptr = this_cpu_ptr(&vector_misaligned_access);
>>> +	unsigned long tmp_var;
>>> +
>>> +	if (!riscv_isa_extension_available(hart_isa[cpu].isa, v))
>>> +		return;
>>> +
>>> +	*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
>>> +
>>> +	local_irq_enable();
>>> +	kernel_vector_begin();
>>> +	__asm__ __volatile__ (
>>> +		".balign 4\n\t"
>>> +		".option push\n\t"
>>> +		".option arch, +v\n\t"
>>> +		"       vsetivli zero, 1, e16, m1, ta, ma\n\t"	// Vectors of 16b
>>> +		"	vle16.v v0, (%[ptr])\n\t"		// Load bytes
>>> +		".option pop\n\t"
>>> +		: : [ptr] "r" ((u8 *)&tmp_var + 1) : "v0", "memory");
>>
>> memory is being read from, but not written to, so there is no need to
>> have a memory clobber.
>>
>>> +	kernel_vector_end();
>>> +
>>> +	if (*mas_ptr == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
>>> +		*mas_ptr = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
>>> +}
>>> +
>>> +bool check_vector_unaligned_access_all_cpus(void)
>>> +{
>>> +	int cpu;
>>> +	bool ret = true;
>>> +
>>> +	for_each_online_cpu(cpu)
>>> +		if (riscv_isa_extension_available(hart_isa[cpu].isa, ZICCLSM))
>>
>> zicclsm is not specific to vector so it can be extracted out of this
>> vector specific function. Assuming that hardware properly reports the
>> extension, if zicclsm is present then it is known that both vector and
>> scalar unaligned accesses are supported.
>>
>>> +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
>>
>> Please use the exising UNKNOWN terminology instead of renaming to
>> SUPPORTED. Any option that is not UNSUPPORTED implies that unaligned
>> accesses are supported.
>>
>>> +		else
>>> +			ret = false;
>>> +
>>> +
>>> +	if (ret)
>>> +		return true;
>>> +	ret = true;
>>> +
>>> +	schedule_on_each_cpu(check_vector_unaligned_access);
>>> +
>>> +	for_each_online_cpu(cpu)
>>> +		if (per_cpu(vector_misaligned_access, cpu)
>>> +		    != RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED)
>>> +			return false;
>>> +
>>> +	return ret;
>>> +}
>>> +#else
>>
>> If CONFIG_RISCV_ISA_V is not set, there is no value in checking if
>> vector unaligned accesses are supported because userspace will not be
>> allowed to use vector instructions anyway.
>>
>> - Charlie
>>
>>> +bool check_vector_unaligned_access_all_cpus(void)
>>> +{
>>> +	int cpu;
>>> +
>>> +	for_each_online_cpu(cpu)
>>> +		if (riscv_isa_extension_available(hart_isa[cpu].isa, ZICCLSM))
>>> +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_SUPPORTED;
>>> +		else
>>> +			per_cpu(vector_misaligned_access, cpu) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>>> +
>>> +	return false;
>>> +}
>>> +#endif
>>> +
>>>   bool check_unaligned_access_emulated_all_cpus(void)
>>>   {
>>>   	int cpu;
>>> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
>>> index a9a6bcb02acf..92a84239beaa 100644
>>> --- a/arch/riscv/kernel/unaligned_access_speed.c
>>> +++ b/arch/riscv/kernel/unaligned_access_speed.c
>>> @@ -20,6 +20,7 @@
>>>   #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>>>   
>>>   DEFINE_PER_CPU(long, misaligned_access_speed);
>>> +DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>>   
>>>   #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>>>   static cpumask_t fast_misaligned_access;
>>> @@ -264,6 +265,8 @@ static int check_unaligned_access_all_cpus(void)
>>>   {
>>>   	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>>>   
>>> +	check_vector_unaligned_access_all_cpus();
>>> +
>>>   	if (!all_cpus_emulated)
>>>   		return check_unaligned_access_speed_all_cpus();
>>>   
>>> @@ -273,6 +276,7 @@ static int check_unaligned_access_all_cpus(void)
>>>   static int check_unaligned_access_all_cpus(void)
>>>   {
>>>   	check_unaligned_access_emulated_all_cpus();
>>> +	check_vector_unaligned_access_all_cpus();
>>>   
>>>   	return 0;
>>>   }
>>> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
>>> index 6727d1d3b8f2..2cceab739b2c 100644
>>> --- a/arch/riscv/kernel/vector.c
>>> +++ b/arch/riscv/kernel/vector.c
>>> @@ -66,7 +66,7 @@ void __init riscv_v_setup_ctx_cache(void)
>>>   #endif
>>>   }
>>>   
>>> -static bool insn_is_vector(u32 insn_buf)
>>> +bool insn_is_vector(u32 insn_buf)
>>>   {
>>>   	u32 opcode = insn_buf & __INSN_OPCODE_MASK;
>>>   	u32 width, csr;
>>> -- 
>>> 2.43.0
>>>

