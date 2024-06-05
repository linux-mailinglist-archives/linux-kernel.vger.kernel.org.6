Return-Path: <linux-kernel+bounces-202906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 928CB8FD2CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C0D1F24042
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB03188CC9;
	Wed,  5 Jun 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RWAYU8Hr"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC014D28E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604382; cv=none; b=Qr4+BOZutkujspPOOKS0MA31ynPUr7coyYMFvbjXbFjmK6d0nujsY/Wn03A523gvDM1t0p7FqFwpeT3d/VGY97SvOBhIXym+P/TsHfoTwU60uaS4KzUYiDMKD6BertLJCtMgCRUDp8h0Q9xmvAbg37QXaD1CzLEyTjimV06vQOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604382; c=relaxed/simple;
	bh=vzlZGXut6d868FfMrCLoAr4MvBJ5UTt4WL8ieh/O5ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmmuyBfGVYWn0QRszU3Y9C2kDhIrN1c12tntQitzjb75BRAydlwobq5gR0YJs6b4sfUygSarlR/KRiUZH2FwSiwkEFviVJBYY1G6fvJajRUobGQd40W3oc54fBOaYjcFF159X/cIHiiOMYcMy+3w3wjG7uZvUrHBAYhhz3XeYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RWAYU8Hr; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d2026f5b33so906163b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717604380; x=1718209180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iko996D4Mb1kYI4Dm3IbnaDyW4jb6FzfDHMfW1qMDyk=;
        b=RWAYU8Hr+Kr3Z5HpZ3ZAJ31jrVvOXwGp3q9LDcBfRA8kdn2/9UHonRt90hqo3V4Pzy
         no2H3QqPaDpGdCnKZA1EkfVbEytlFQSjooi2WVkzVhiD81m5XjhoRJDcwrG1zPfP0FCt
         uP6KRYLVpVA1Ilx/nu3H/lkt79gqOX3gY3qb100Pj363Cuc5UyhT3yY+tTDRgrq96Kft
         QvBARBlY436mi3HglL/rl49mMCsQJo8ukU8AXKpfjdalGQj6vBfl5zvo2mwqJicmqC83
         Ch9WDNfzZR6yABB2ezoWVopxEVH8+E9Bic8vr/YUxyOhwZJ4mcsbQy/f8CvHENQWEboM
         1i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717604380; x=1718209180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iko996D4Mb1kYI4Dm3IbnaDyW4jb6FzfDHMfW1qMDyk=;
        b=ukbFXo6nWG0SGxuMDy1AAJAv96J67dMC6mOhhFNApFogYSlBF5LnodkZqypqwiu1oL
         30kGX8+xepEX5JKU2n2ZS+nO2LDuvmvRiLqUo3YuJsLRcOf/ZMF4invKjNaJkxrn53lr
         OB7MV/txii6/zUk9Vbo5+oBKdzIAu+HXr4PbUX3MmECM9cQrL51EdO6eazjYLIF+Bu3u
         lJvpMi3/wDRDN1NWKRBsaGgIHEp6YeEDcGvceiJmto9OZE4mTcLHTDbleDbET6Sg3h0f
         Q2XewpcMw4Y5MXY+87nVP0KZCjzLhS8+JA2bsbGqkm/Rts0BhF6hR7DnSIVdQMjdJP67
         10ag==
X-Forwarded-Encrypted: i=1; AJvYcCUoyLesm0PU+Bs/J95epozCqIT4cM85A/X/QrnNSeTR+yqXjsZh58YQI1AU6ReQJXdkt4ThbdK3jv9QyKMoeppPw9irwux7egimGqjI
X-Gm-Message-State: AOJu0YzawUz8oNplMFf0hxM+vE861OMGwODIqsuZK5t1bJ6d0pXv4xCK
	TApTOHYN/HngsbJPphXYvb+w8wqA/BNPxWHlkD5sLH1vcSJdgXaJ20bUDtEWODY=
X-Google-Smtp-Source: AGHT+IHhOmjx2vg5PasWqom+cN1RxNf9wAxbhvj1uIPlHEejkmAhEFYjlAXvcrGfFIH1ZJU7zrjeEQ==
X-Received: by 2002:a54:4015:0:b0:3c9:bdfb:d358 with SMTP id 5614622812f47-3d2043a7216mr2976183b6e.26.1717604379561;
        Wed, 05 Jun 2024 09:19:39 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f2f042e6sm456367985a.6.2024.06.05.09.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 09:19:39 -0700 (PDT)
Message-ID: <f1090399-c035-4155-bbb9-b5cd47501a59@rivosinc.com>
Date: Wed, 5 Jun 2024 12:19:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v0] RISCV: Report vector unaligned accesses hwprobe
To: Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley
 <conor.dooley@microchip.com>, Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Andy Chiu <andy.chiu@sifive.com>, Costa Shulyupin <costa.shul@redhat.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Erick Archer
 <erick.archer@gmx.com>, linux-kernel@vger.kernel.org
References: <20240604162457.3757417-1-jesse@rivosinc.com>
 <CALs-Hsu5LakOVKvGRP0-sbq5ptH8FLPGhBAkupv3tRLKVAdnUA@mail.gmail.com>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <CALs-Hsu5LakOVKvGRP0-sbq5ptH8FLPGhBAkupv3tRLKVAdnUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/5/24 11:54, Evan Green wrote:
> On Tue, Jun 4, 2024 at 9:25 AM Jesse Taube <jesse@rivosinc.com> wrote:
>>
>> Detected if a system traps into the kernel on an vector unaligned access.
>> Add the result to a new key in hwprobe.
>>
>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> 
> For the scalar world, we wanted to know whether misaligned accesses
> were faster or slower than equivalent byte accesses, so usermode could
> know for something like memcpy which option had better bandwidth. 

Yes that will be in another patch and will set it to either fast or slow.
This patch will just detect if we can run it.

> Is
> the motivation here the same, where we're going to use vector
> registers for memcpy and we want to know which size load to use? Or
> will usermode be consuming this info for a different purpose as well?
> I know this is a basic question, but having the motivation helps me
> get the right lens for reviewing it. Perhaps that should be added to
> the commit message as well.
> 
>> ---
>>   arch/riscv/include/asm/cpufeature.h        |  3 ++
>>   arch/riscv/include/asm/hwprobe.h           |  2 +-
>>   arch/riscv/include/uapi/asm/hwprobe.h      |  6 +++
>>   arch/riscv/kernel/sys_hwprobe.c            | 34 ++++++++++++
>>   arch/riscv/kernel/traps_misaligned.c       | 60 ++++++++++++++++++++++
>>   arch/riscv/kernel/unaligned_access_speed.c |  4 ++
>>   6 files changed, 108 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>> index 347805446151..5ad69cf25b25 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -35,9 +35,12 @@ void riscv_user_isa_enable(void);
>>
>>   #if defined(CONFIG_RISCV_MISALIGNED)
>>   bool check_unaligned_access_emulated_all_cpus(void);
>> +bool check_vector_unaligned_access_all_cpus(void);
>> +
>>   void unaligned_emulation_finish(void);
>>   bool unaligned_ctl_available(void);
>>   DECLARE_PER_CPU(long, misaligned_access_speed);
>> +DECLARE_PER_CPU(long, vector_misaligned_access);
>>   #else
>>   static inline bool unaligned_ctl_available(void)
>>   {
>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
>> index 630507dff5ea..150a9877b0af 100644
>> --- a/arch/riscv/include/asm/hwprobe.h
>> +++ b/arch/riscv/include/asm/hwprobe.h
>> @@ -8,7 +8,7 @@
>>
>>   #include <uapi/asm/hwprobe.h>
>>
>> -#define RISCV_HWPROBE_MAX_KEY 6
>> +#define RISCV_HWPROBE_MAX_KEY 7
>>
>>   static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>   {
>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
>> index 060212331a03..4474e98d17bd 100644
>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>> @@ -68,6 +68,12 @@ struct riscv_hwprobe {
>>   #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
>>   #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
>>   #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
>> +#define RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF  7
>> +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN            0
>> +#define                RISCV_HWPROBE_VEC_MISALIGNED_EMULATED           1
>> +#define                RISCV_HWPROBE_VEC_MISALIGNED_SLOW               2
>> +#define                RISCV_HWPROBE_VEC_MISALIGNED_FAST               3
>> +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED        4
> 
> This needs to be added to the documentation as well.
> 
> What value should be returned when V is not enabled in the kernel, or
> V is not supported in the hardware? Currently in the code it would be
> UNKNOWN, right?

Yes. It would be trivial to set it to unsupported if V is not enabled.

> Is that what we want, or is it worth differentiating
> "no support for V" from "I don't know the speed of misaligned loads"?
> Maybe UNKNOWN is the right value, as there are other values to tell
> you V is not enabled.
> 
> 
>>   /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>
>>   /* Flags */
>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
>> index b286b73e763e..ce641cc6e47a 100644
>> --- a/arch/riscv/kernel/sys_hwprobe.c
>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>> @@ -184,6 +184,36 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>>   }
>>   #endif
>>
>> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
>> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>> +{
>> +       int cpu;
>> +       u64 perf = -1ULL;
>> +
>> +       for_each_cpu(cpu, cpus) {
>> +               int this_perf = per_cpu(vector_misaligned_access, cpu);
>> +
>> +               if (perf == -1ULL)
>> +                       perf = this_perf;
>> +
>> +               if (perf != this_perf) {
>> +                       perf = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       if (perf == -1ULL)
>> +               return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>> +
>> +       return perf;
>> +}
>> +#else
>> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>> +{
>> +       return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>> +}
>> +#endif
>> +
>>   static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>                               const struct cpumask *cpus)
>>   {
>> @@ -211,6 +241,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>                  pair->value = hwprobe_misaligned(cpus);
>>                  break;
>>
>> +       case RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF:
>> +               pair->value = hwprobe_vec_misaligned(cpus);
>> +               break;
>> +
>>          case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>>                  pair->value = 0;
>>                  if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index 2adb7c3e4dd5..0c07e990e9c5 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -16,6 +16,7 @@
>>   #include <asm/entry-common.h>
>>   #include <asm/hwprobe.h>
>>   #include <asm/cpufeature.h>
>> +#include <asm/vector.h>
>>
>>   #define INSN_MATCH_LB                  0x3
>>   #define INSN_MASK_LB                   0x707f
>> @@ -426,6 +427,14 @@ int handle_misaligned_load(struct pt_regs *regs)
>>          if (get_insn(regs, epc, &insn))
>>                  return -1;
>>
>> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>> +       if (*this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN) {
>> +               *this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> 
> Shouldn't this be EMULATED, given we were just delegated this trap? I
> guess it depends on whether you're going to add support for actually
> handling the misaligned vector trap, as Clément mentioned.

Yeah I accedentaly forgot to check if the trap was caused by a vector 
instruction. I was not planing on emulating them, this is just a 
one-time check.

> 
> Scalar misaligned loads had a history to lean on since the specs were
> always explicit that misaligned loads/store had to be supported one
> way or another. So UNSUPPORTED was a future theoretical value. I
> haven't dug through the specs yet, do you know what the story is for V
> and misaligned loads?

"
8. Vector Memory Alignment Constraints
  If an element accessed by a vector memory instruction is not naturally 
aligned to the size of the element, either the element is transferred 
successfully or an address misaligned exception is raised on that element.
Support for misaligned vector memory accesses is independent of an 
implementation’s support for misaligned scalar memory accesses.
"

It is if the load/store is naturally aligned to the size of the element.

  My sub-question is what the rules are for
> detecting the difference between EMULATED and UNSUPPORTED.

For vector EMULATED isnt used thought it can be added if I add emulation.
Idealy that would be done in the SBI.

> 
>> +               regs->epc = epc + INSN_LEN(insn);
>> +               return 0;
>> +       }
>> +#endif
>> +
>>          regs->epc = 0;
>>
>>          if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
>> @@ -625,6 +634,57 @@ static bool check_unaligned_access_emulated(int cpu)
>>          return misaligned_emu_detected;
>>   }
>>
>> +#ifdef CONFIG_RISCV_ISA_V
>> +static bool check_vector_unaligned_access(int cpu)
>> +{
>> +       long *mas_ptr = per_cpu_ptr(&vector_misaligned_access, cpu);
>> +       struct riscv_isainfo *isainfo = &hart_isa[cpu];
>> +       unsigned long tmp_var;
>> +       bool misaligned_vec_suported;
>> +
>> +       if (!riscv_isa_extension_available(isainfo->isa, v))
>> +               return false;
>> +
>> +       /* This case will only happen if a unaligned vector load
>> +        * was called by the kernel before this check
>> +        */
>> +       if (*mas_ptr != RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
>> +               return false;
>> +
>> +       kernel_vector_begin();
>> +       __asm__ __volatile__ (
>> +               ".option push\n\t"
>> +               ".option arch, +v\n\t"
>> +               "       li t1, 0x1\n"                           //size
>> +               "       vsetvli t0, t1, e16, m2, ta, ma\n\t"    // Vectors of 16b
>> +               "       addi t0, %[ptr], 1\n\t"                 // Misalign address
>> +               "       vle16.v v0, (t0)\n\t"                   // Load bytes
>> +               ".option pop\n\t"
>> +               : : [ptr] "r" (&tmp_var) : "v0", "t0", "t1", "memory");
>> +       kernel_vector_end();
>> +
>> +       misaligned_vec_suported = (*mas_ptr == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN);
>> +
>> +       return misaligned_vec_suported;
>> +}
>> +#else
>> +static bool check_vector_unaligned_access(int cpu)
>> +{
>> +       return false;
>> +}
>> +#endif
>> +
>> +bool check_vector_unaligned_access_all_cpus(void)
>> +{
>> +       int cpu;
>> +
>> +       for_each_online_cpu(cpu)
>> +               if (!check_vector_unaligned_access(cpu))
>> +                       return false;
>> +
>> +       return true;
>> +}
> 
> These functions return a bool, but the bool is never checked. I'm
> guessing that's because you're going to check it in a future patch
> where you decide whether or not to probe for fast/slow?

Yes. Relating to your first question. The values should have the same 
meaning as scalar. So UNKNOWN whould mean it's supported, we dont know 
the speed.

> 
> 
>> +
>>   bool check_unaligned_access_emulated_all_cpus(void)
>>   {
>>          int cpu;
>> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
>> index a9a6bcb02acf..92a84239beaa 100644
>> --- a/arch/riscv/kernel/unaligned_access_speed.c
>> +++ b/arch/riscv/kernel/unaligned_access_speed.c
>> @@ -20,6 +20,7 @@
>>   #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>>
>>   DEFINE_PER_CPU(long, misaligned_access_speed);
>> +DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>
>>   #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>>   static cpumask_t fast_misaligned_access;
>> @@ -264,6 +265,8 @@ static int check_unaligned_access_all_cpus(void)
>>   {
>>          bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>>
>> +       check_vector_unaligned_access_all_cpus();
>> +
>>          if (!all_cpus_emulated)
>>                  return check_unaligned_access_speed_all_cpus();
>>
>> @@ -273,6 +276,7 @@ static int check_unaligned_access_all_cpus(void)
>>   static int check_unaligned_access_all_cpus(void)
>>   {
>>          check_unaligned_access_emulated_all_cpus();
>> +       check_vector_unaligned_access_all_cpus();
>>
>>          return 0;
>>   }
>> --
>> 2.43.0
>>

