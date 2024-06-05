Return-Path: <linux-kernel+bounces-201915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E978FC539
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB641C220CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F363F18F2CD;
	Wed,  5 Jun 2024 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="F6pv4QMl"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631BB200CD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574144; cv=none; b=geMU17bjWcUxh4tVF9u6Z79KY+KhNDxoh8nJnAle9GH8s7ZSyTyjR3juYx6Xz09vGmqOKoz9OOkU+hiLTLyncmI/ZLkha/9xkIwp5KV+tduHfw+UHRnpOj9I5+NEez5BL8u/tGAXEF+HDpKvh0znZ4C79NPAGfUNTnRYNRS1NrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574144; c=relaxed/simple;
	bh=R6eVWGmwUNFObFuh3GGvG6aDWxYF/lO0Tk4YFTbszKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XW8pn39ro9fH1LtOBqVIlQ7FrCVbfP3PZH5C3P/61mIWmuuTTZiObUouLX6az4ELCwgXezonH5BQvENU7TX9YT6iaca+Bje4ZDysCVzpEsRoNicvYCagy+8n/lLvydlsnjp2MZweZoKASkLwtJobmehKP8w07Wq4sFzrc/2EKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=F6pv4QMl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35e544aa9a9so426884f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717574140; x=1718178940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPLrI0A3Rk3KdNIAp7j8P5+G+sP3HYu8ROkG8ul33Lo=;
        b=F6pv4QMlU4N9kaofy9/JDDWljqTcHctsxNZfF/sDxCflGpQ/4a6Saj3+nseAZcLRgq
         fnpaylLxJdf1nEEKpX1aW+239rN1eouYFRWvGzEtKUMK7FW0+bqMNjlrMwPM1P5F9uMZ
         6aHMcm3WCSnbo36184PRO2Rh/wL+Tqm2ujYrrxOvjpVLCfALXP4iiOqnNs0t5pSVz3bX
         EOMehiFXEvnrgoTJaqxrdzq36/uuiVajxD4UPcnNddGZy4S1lZq2Meudy+Q1GVEgHnT0
         j8F+c1LTQmJ6HRR4qnOtvwg2m8FSSjQdzTwmxJbxDY5ijkvzJNQGZTneF7gxWoyGUpnm
         bCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574140; x=1718178940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPLrI0A3Rk3KdNIAp7j8P5+G+sP3HYu8ROkG8ul33Lo=;
        b=xCTGZw7cs7jarm1syT5okbhKSvpurf0EmZYdrhe70LrKevngSMLe+C0Ys4zo1Ml8Cc
         Ga9SV8blVcmm9BJsGLy2GQetSttOqGNSbYAlPwtKsT1OKcux4dJO5+lsWENvPrH1Sgbb
         h3rLOynS9Rmw+0LsnfA42+T/SD8GT0w1VbXH5arK6f5pYfi1RI+4QgsxqbvhSUiYJPDC
         UEQsnvWdmBdgbbB3bLcjGPEUQzeRvqGaqy3NcXGrQFEADf6DVtGOfNZaxxzwEW5gf5XY
         H8s/EnRKkfEX6VHp1zgmrNPRg9//jprClF7yEbZpQiUtB615jGCTw08k4Zfdyv/5VrzP
         Rdlg==
X-Forwarded-Encrypted: i=1; AJvYcCUtuWcb5Lr18KEZifWoUKhQ+PcuTp6lBZ1pD7bNXmQaP8vjB7XPyb044gTHARl8dOIB5UAHHMmdf/tQeDHeKFXIuwyIJIF9UikL7wwb
X-Gm-Message-State: AOJu0Yz0m9ZhEbG3sz+3Mgvet2xG6Wfzj3onMXcX36Xeo1Oi2ZZlbDJ8
	V3ir4dM1PjoH/yQ8IhQp5S4J4JQnYIlhK9+AEyN/9D2X/wM59/+hw3aUmo70huw=
X-Google-Smtp-Source: AGHT+IHP5ackB3i6LJcSNtvnYK60YV7xFQA3nkzVhKfYL3wc34b4K6BdQGihgL2g7xrGASTTRHDQBg==
X-Received: by 2002:a05:6000:bd0:b0:355:3ec:c7e7 with SMTP id ffacd0b85a97d-35e84057ebemr1199869f8f.2.1717574140565;
        Wed, 05 Jun 2024 00:55:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:d664:3582:51f4:7a32? ([2a01:e0a:999:a3a0:d664:3582:51f4:7a32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d94e6sm13605483f8f.51.2024.06.05.00.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 00:55:39 -0700 (PDT)
Message-ID: <2c355b76-c768-46b1-9f37-fd1991a54bfd@rivosinc.com>
Date: Wed, 5 Jun 2024 09:55:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v0] RISCV: Report vector unaligned accesses hwprobe
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Andy Chiu <andy.chiu@sifive.com>, Costa Shulyupin <costa.shul@redhat.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Erick Archer
 <erick.archer@gmx.com>, linux-kernel@vger.kernel.org
References: <20240604162457.3757417-1-jesse@rivosinc.com>
 <8e2556d2-8021-4e4c-9380-7568ff74a84f@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <8e2556d2-8021-4e4c-9380-7568ff74a84f@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/06/2024 18:42, Jesse Taube wrote:
> 
> 
> On 6/4/24 12:24, Jesse Taube wrote:
>> Detected if a system traps into the kernel on an vector unaligned access.
>> Add the result to a new key in hwprobe.
>>
>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/cpufeature.h        |  3 ++
>>   arch/riscv/include/asm/hwprobe.h           |  2 +-
>>   arch/riscv/include/uapi/asm/hwprobe.h      |  6 +++
>>   arch/riscv/kernel/sys_hwprobe.c            | 34 ++++++++++++
>>   arch/riscv/kernel/traps_misaligned.c       | 60 ++++++++++++++++++++++
>>   arch/riscv/kernel/unaligned_access_speed.c |  4 ++
>>   6 files changed, 108 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h
>> b/arch/riscv/include/asm/cpufeature.h
>> index 347805446151..5ad69cf25b25 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -35,9 +35,12 @@ void riscv_user_isa_enable(void);
>>     #if defined(CONFIG_RISCV_MISALIGNED)
>>   bool check_unaligned_access_emulated_all_cpus(void);
>> +bool check_vector_unaligned_access_all_cpus(void);
>> +
>>   void unaligned_emulation_finish(void);
>>   bool unaligned_ctl_available(void);
>>   DECLARE_PER_CPU(long, misaligned_access_speed);
>> +DECLARE_PER_CPU(long, vector_misaligned_access);
>>   #else
>>   static inline bool unaligned_ctl_available(void)
>>   {
>> diff --git a/arch/riscv/include/asm/hwprobe.h
>> b/arch/riscv/include/asm/hwprobe.h
>> index 630507dff5ea..150a9877b0af 100644
>> --- a/arch/riscv/include/asm/hwprobe.h
>> +++ b/arch/riscv/include/asm/hwprobe.h
>> @@ -8,7 +8,7 @@
>>     #include <uapi/asm/hwprobe.h>
>>   -#define RISCV_HWPROBE_MAX_KEY 6
>> +#define RISCV_HWPROBE_MAX_KEY 7
>>     static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>   {
>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h
>> b/arch/riscv/include/uapi/asm/hwprobe.h
>> index 060212331a03..4474e98d17bd 100644
>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> @@ -68,6 +68,12 @@ struct riscv_hwprobe {
>>   #define        RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
>>   #define        RISCV_HWPROBE_MISALIGNED_MASK        (7 << 0)
>>   #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
>> +#define RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF    7
> 
> There were talks about combining vecotor and scalar speed for the user
> facing API into RISCV_HWPROBE_KEY_CPUPERF_0, but adding another key
> seems easier.
> 
>> +#define        RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN        0
>> +#define        RISCV_HWPROBE_VEC_MISALIGNED_EMULATED        1
>> +#define        RISCV_HWPROBE_VEC_MISALIGNED_SLOW        2
>> +#define        RISCV_HWPROBE_VEC_MISALIGNED_FAST        3
>> +#define        RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED    4
>>   /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>     /* Flags */
>> diff --git a/arch/riscv/kernel/sys_hwprobe.c
>> b/arch/riscv/kernel/sys_hwprobe.c
>> index b286b73e763e..ce641cc6e47a 100644
>> --- a/arch/riscv/kernel/sys_hwprobe.c
>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>> @@ -184,6 +184,36 @@ static u64 hwprobe_misaligned(const struct
>> cpumask *cpus)
>>   }
>>   #endif
>>   +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>> +{
>> +    int cpu;
>> +    u64 perf = -1ULL;
>> +
>> +    for_each_cpu(cpu, cpus) {
>> +        int this_perf = per_cpu(vector_misaligned_access, cpu);
>> +
>> +        if (perf == -1ULL)
>> +            perf = this_perf;
>> +
>> +        if (perf != this_perf) {
>> +            perf = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (perf == -1ULL)
>> +        return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>> +
>> +    return perf;
>> +}
>> +#else
>> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>> +{
>> +    return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>> +}
>> +#endif
>> +
>>   static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>                    const struct cpumask *cpus)
>>   {
>> @@ -211,6 +241,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe
>> *pair,
>>           pair->value = hwprobe_misaligned(cpus);
>>           break;
>>   +    case RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF:
>> +        pair->value = hwprobe_vec_misaligned(cpus);
>> +        break;
>> +
>>       case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>>           pair->value = 0;
>>           if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>> diff --git a/arch/riscv/kernel/traps_misaligned.c
>> b/arch/riscv/kernel/traps_misaligned.c
>> index 2adb7c3e4dd5..0c07e990e9c5 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -16,6 +16,7 @@
>>   #include <asm/entry-common.h>
>>   #include <asm/hwprobe.h>
>>   #include <asm/cpufeature.h>
>> +#include <asm/vector.h>
>>     #define INSN_MATCH_LB            0x3
>>   #define INSN_MASK_LB            0x707f
>> @@ -426,6 +427,14 @@ int handle_misaligned_load(struct pt_regs *regs)
>>       if (get_insn(regs, epc, &insn))
>>           return -1;
>>   
> 
> Is this an appropriate way to check if there is vector missaligned
> access? What if a unaligned vector load as called by the kernel before
> this check?
> 
>> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>> +    if (*this_cpu_ptr(&vector_misaligned_access) ==
>> RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN) {
>> +        *this_cpu_ptr(&vector_misaligned_access) =
>> RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
>> +        regs->epc = epc + INSN_LEN(insn);
>> +        return 0;
>> +    }
>> +#endif

Since this code will be called for standard load/store misaligned
accesses your, I guess this needs to check if the faulty instruction
itself is a vector related one before setting it to supported. I don't
know what the specs says about that but I guess it shoukld be checked if
vector load/store and standard load/store could have different behaviors
with respect to misaligned accesses.

Regardless of that (except if I missed something), the emulation code
does not actually support vector load/store instructions.
So, support for misaligned vector load/store should be added in a first
place before reporting that it is actually "supported".

Thanks,

Clément

>> +
>>       regs->epc = 0;
>>         if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
>> @@ -625,6 +634,57 @@ static bool check_unaligned_access_emulated(int cpu)
>>       return misaligned_emu_detected;
>>   }
>>   +#ifdef CONFIG_RISCV_ISA_V
>> +static bool check_vector_unaligned_access(int cpu)
>> +{
>> +    long *mas_ptr = per_cpu_ptr(&vector_misaligned_access, cpu);
>> +    struct riscv_isainfo *isainfo = &hart_isa[cpu];
>> +    unsigned long tmp_var;
>> +    bool misaligned_vec_suported;
>> +
>> +    if (!riscv_isa_extension_available(isainfo->isa, v))
>> +        return false;
>> +
>> +    /* This case will only happen if a unaligned vector load
>> +     * was called by the kernel before this check
>> +     */
>> +    if (*mas_ptr != RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
>> +        return false;
>> +
>> +    kernel_vector_begin();
>> +    __asm__ __volatile__ (
>> +        ".option push\n\t"
>> +        ".option arch, +v\n\t"
>> +        "    li t1, 0x1\n"                //size
>> +        "       vsetvli t0, t1, e16, m2, ta, ma\n\t"    // Vectors of
>> 16b
>> +        "       addi t0, %[ptr], 1\n\t"            // Misalign address
>> +        "    vle16.v v0, (t0)\n\t"            // Load bytes
>> +        ".option pop\n\t"
>> +        : : [ptr] "r" (&tmp_var) : "v0", "t0", "t1", "memory");
>> +    kernel_vector_end();
>> +
>> +    misaligned_vec_suported = (*mas_ptr ==
>> RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN);
>> +
>> +    return misaligned_vec_suported;
>> +}
>> +#else
>> +static bool check_vector_unaligned_access(int cpu)
>> +{
>> +    return false;
>> +}
>> +#endif
>> +
>> +bool check_vector_unaligned_access_all_cpus(void)
>> +{
>> +    int cpu;
>> +
>> +    for_each_online_cpu(cpu)
>> +        if (!check_vector_unaligned_access(cpu))
>> +            return false;
>> +
>> +    return true;
>> +}
>> +
>>   bool check_unaligned_access_emulated_all_cpus(void)
>>   {
>>       int cpu;
>> diff --git a/arch/riscv/kernel/unaligned_access_speed.c
>> b/arch/riscv/kernel/unaligned_access_speed.c
>> index a9a6bcb02acf..92a84239beaa 100644
>> --- a/arch/riscv/kernel/unaligned_access_speed.c
>> +++ b/arch/riscv/kernel/unaligned_access_speed.c
>> @@ -20,6 +20,7 @@
>>   #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>>     DEFINE_PER_CPU(long, misaligned_access_speed);
>> +DEFINE_PER_CPU(long, vector_misaligned_access) =
>> RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>     #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>>   static cpumask_t fast_misaligned_access;
>> @@ -264,6 +265,8 @@ static int check_unaligned_access_all_cpus(void)
>>   {
>>       bool all_cpus_emulated =
>> check_unaligned_access_emulated_all_cpus();
>>  
> 
> There was talks about Zicclsm, but spike doesnt have support for Zicclsm
> afaik, but I was wondering if i should add Zicclsm to cpufeature and
> aswell.
> 
> If anyone wants to run this i tested with
> spike --misaligned --isa=RV64IMAFDCV_zicntr_zihpm
> --kernel=arch/riscv/boot/Image
> opensbi/build/platform/generic/firmware/fw_jump.elf

AFAIK, --misaligned tells spike to actually handle misaligned load/store
in "hardware" and not generate a misaligned trap so I guess you would
need to remove that flag and use a specific openSBI version that always
delegate the misaligned load/store traps if you want to be sure that the
kernel actually handles the vector misaligned load/store traps.

I previously made a small test utility to verify that the kernel
correctly gets the misaligned traps [1]. If it fails then, your kernel
probably do not get any trap :)

Link: https://github.com/clementleger/unaligned_test [1]
> 
> 
> Thanks,
> Jesse Taube
> 
> 
>> +    check_vector_unaligned_access_all_cpus();
>> +
>>       if (!all_cpus_emulated)
>>           return check_unaligned_access_speed_all_cpus();
>>   @@ -273,6 +276,7 @@ static int check_unaligned_access_all_cpus(void)
>>   static int check_unaligned_access_all_cpus(void)
>>   {
>>       check_unaligned_access_emulated_all_cpus();
>> +    check_vector_unaligned_access_all_cpus();
>>         return 0;
>>   }

