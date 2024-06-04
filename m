Return-Path: <linux-kernel+bounces-201092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B12B8FB93E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF91C22FA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9281487EF;
	Tue,  4 Jun 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hu+yZ02E"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F31E501
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519347; cv=none; b=grmsfe+C4sxdbso9UE6UY7UdjFDCHXKZEowfdxu/ql2uyVYdfqdyaQu2XuOntlZ6gPHEjkqkDBvLnasR8oJ+/zgo81zWOpjsz3TkSc5xXilS63mX0yACaWCW9NE1rUsoOsbV3bhpR64esfxyAIv3vQmUeenyzVq/qcxMQO6ivqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519347; c=relaxed/simple;
	bh=LBijQwyN473Pb7Grbj51uHr5B/gH6Gd8XgK99IWbfOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vo1xcwRc1+hhbAIIfb7G5cnrOMQI+wYu9lq8nz9eC7fCqrvV35r3eVlhDvux2Q+/3Bd1UzvKRE9zpb9KQKnWWYiky6vLF1guYcuHSymRV1At0QlqSdnHRKBUlGQaxVS5kvZS+oEuWDlaR9731B2rALfolfq1T062de6qdPyhxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hu+yZ02E; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f44b441b08so44156165ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717519345; x=1718124145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zv/YK08fJ+COCcELqsIid0IiDB52vCjZPthOO14kB9M=;
        b=hu+yZ02EyiU73KTtL26KMqKY6kqC9c9gGEsXFZFvF2cglgQANMT0eRT0ADHvl+s4vS
         s+dgPmKIhSuoSYFs8T8kUc7eqEEgFgCqahyNXUTpgXFmMoOWRSleIisZOn7GxKzCqsTE
         1efVJrxQSDoXKB+VZUOZNPPzLsD12qRfSYyl9O0uh2A3euA/BzkQrQC7LnRP4rXHgDLs
         4p1/H0q6UEppYiEWylFHCIllH3kgCkZ3PLVOHo2xTfSe0qDtsf5zxjE21xySYO6NK8SN
         BVtA89Nh8sybHDs1lp9xWKwA8zk7FGizdkGQAVuEcvwKSxbl/6digO8mfaftDfsirYf6
         jqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717519345; x=1718124145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zv/YK08fJ+COCcELqsIid0IiDB52vCjZPthOO14kB9M=;
        b=Rqa/XsqT7OekP2vGx6LePgqB5lB28dDN9c2bX7831plM8R4DVK4unvKfGMEhPqunTN
         BUIoIEWNeSzZ4OXVvObwD+bFwtAgul33MVxXU//3U0CNUqpG+oLOdBnyjgyhSTXgR3Vb
         MaoVjFB0SqRdo6t5DVDwl09G4++7eYZGLN15fpnJ7msdPikq8E3yZ50VZjNvR0VmhK3Y
         YW7wkKTP2w483FXUsc9neef5gjam5Bkwwh6RNf1rzsPN0jkdzdhQJDl6SQyhiVKS3Mw7
         hB9RFMGPTTZhgmh9QIuFPcQrRJaLw/Ttn4iewDhPgGMkSt0kGvvgnUVr9OAi1klpjjNu
         jN2g==
X-Forwarded-Encrypted: i=1; AJvYcCVs3zoLN2xbDB6hr53SfPfpPgPCHoJ0MAwxHr+RMTeHzrUM3yFBEWyHMM1cY9krljC294qRgNzPYgaUA4gPNKeQbaxRPqONC4oLHbz3
X-Gm-Message-State: AOJu0YweyZo8oE2x0WbIFxe5bSPMv1r36Ja9ZHcGVBkiLog3mfIoC1pe
	iX0h27piGKzVmJ5xboBfOJlNPByrEiI9ZrRvH9sLyn3elBr0TO9ZJw+1gdCvMlM=
X-Google-Smtp-Source: AGHT+IGGaYBewBW4FJkleZIrP7s89xWOfD2dyLgAPTyuEHDkrFv1HQrhVsVsyMxATbz8rhrXMmKzeQ==
X-Received: by 2002:a17:902:c946:b0:1f6:7b40:9852 with SMTP id d9443c01a7336-1f6a5a7bad2mr524705ad.68.1717519345326;
        Tue, 04 Jun 2024 09:42:25 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f65e3798fcsm57616575ad.171.2024.06.04.09.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 09:42:24 -0700 (PDT)
Message-ID: <8e2556d2-8021-4e4c-9380-7568ff74a84f@rivosinc.com>
Date: Tue, 4 Jun 2024 12:42:10 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v0] RISCV: Report vector unaligned accesses hwprobe
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>,
 Andy Chiu <andy.chiu@sifive.com>, Costa Shulyupin <costa.shul@redhat.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Erick Archer
 <erick.archer@gmx.com>, linux-kernel@vger.kernel.org
References: <20240604162457.3757417-1-jesse@rivosinc.com>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <20240604162457.3757417-1-jesse@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/24 12:24, Jesse Taube wrote:
> Detected if a system traps into the kernel on an vector unaligned access.
> Add the result to a new key in hwprobe.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>   arch/riscv/include/asm/cpufeature.h        |  3 ++
>   arch/riscv/include/asm/hwprobe.h           |  2 +-
>   arch/riscv/include/uapi/asm/hwprobe.h      |  6 +++
>   arch/riscv/kernel/sys_hwprobe.c            | 34 ++++++++++++
>   arch/riscv/kernel/traps_misaligned.c       | 60 ++++++++++++++++++++++
>   arch/riscv/kernel/unaligned_access_speed.c |  4 ++
>   6 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 347805446151..5ad69cf25b25 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -35,9 +35,12 @@ void riscv_user_isa_enable(void);
>   
>   #if defined(CONFIG_RISCV_MISALIGNED)
>   bool check_unaligned_access_emulated_all_cpus(void);
> +bool check_vector_unaligned_access_all_cpus(void);
> +
>   void unaligned_emulation_finish(void);
>   bool unaligned_ctl_available(void);
>   DECLARE_PER_CPU(long, misaligned_access_speed);
> +DECLARE_PER_CPU(long, vector_misaligned_access);
>   #else
>   static inline bool unaligned_ctl_available(void)
>   {
> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
> index 630507dff5ea..150a9877b0af 100644
> --- a/arch/riscv/include/asm/hwprobe.h
> +++ b/arch/riscv/include/asm/hwprobe.h
> @@ -8,7 +8,7 @@
>   
>   #include <uapi/asm/hwprobe.h>
>   
> -#define RISCV_HWPROBE_MAX_KEY 6
> +#define RISCV_HWPROBE_MAX_KEY 7
>   
>   static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>   {
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index 060212331a03..4474e98d17bd 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -68,6 +68,12 @@ struct riscv_hwprobe {
>   #define		RISCV_HWPROBE_MISALIGNED_UNSUPPORTED	(4 << 0)
>   #define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
>   #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE	6
> +#define RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF	7

There were talks about combining vecotor and scalar speed for the user 
facing API into RISCV_HWPROBE_KEY_CPUPERF_0, but adding another key 
seems easier.

> +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN		0
> +#define		RISCV_HWPROBE_VEC_MISALIGNED_EMULATED		1
> +#define		RISCV_HWPROBE_VEC_MISALIGNED_SLOW		2
> +#define		RISCV_HWPROBE_VEC_MISALIGNED_FAST		3
> +#define		RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED	4
>   /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>   
>   /* Flags */
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index b286b73e763e..ce641cc6e47a 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -184,6 +184,36 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
>   }
>   #endif
>   
> +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> +{
> +	int cpu;
> +	u64 perf = -1ULL;
> +
> +	for_each_cpu(cpu, cpus) {
> +		int this_perf = per_cpu(vector_misaligned_access, cpu);
> +
> +		if (perf == -1ULL)
> +			perf = this_perf;
> +
> +		if (perf != this_perf) {
> +			perf = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> +			break;
> +		}
> +	}
> +
> +	if (perf == -1ULL)
> +		return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> +
> +	return perf;
> +}
> +#else
> +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> +{
> +	return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> +}
> +#endif
> +
>   static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>   			     const struct cpumask *cpus)
>   {
> @@ -211,6 +241,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>   		pair->value = hwprobe_misaligned(cpus);
>   		break;
>   
> +	case RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF:
> +		pair->value = hwprobe_vec_misaligned(cpus);
> +		break;
> +
>   	case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
>   		pair->value = 0;
>   		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 2adb7c3e4dd5..0c07e990e9c5 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -16,6 +16,7 @@
>   #include <asm/entry-common.h>
>   #include <asm/hwprobe.h>
>   #include <asm/cpufeature.h>
> +#include <asm/vector.h>
>   
>   #define INSN_MATCH_LB			0x3
>   #define INSN_MASK_LB			0x707f
> @@ -426,6 +427,14 @@ int handle_misaligned_load(struct pt_regs *regs)
>   	if (get_insn(regs, epc, &insn))
>   		return -1;
>   

Is this an appropriate way to check if there is vector missaligned 
access? What if a unaligned vector load as called by the kernel before 
this check?

> +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> +	if (*this_cpu_ptr(&vector_misaligned_access) == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN) {
> +		*this_cpu_ptr(&vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED;
> +		regs->epc = epc + INSN_LEN(insn);
> +		return 0;
> +	}
> +#endif
> +
>   	regs->epc = 0;
>   
>   	if ((insn & INSN_MASK_LW) == INSN_MATCH_LW) {
> @@ -625,6 +634,57 @@ static bool check_unaligned_access_emulated(int cpu)
>   	return misaligned_emu_detected;
>   }
>   
> +#ifdef CONFIG_RISCV_ISA_V
> +static bool check_vector_unaligned_access(int cpu)
> +{
> +	long *mas_ptr = per_cpu_ptr(&vector_misaligned_access, cpu);
> +	struct riscv_isainfo *isainfo = &hart_isa[cpu];
> +	unsigned long tmp_var;
> +	bool misaligned_vec_suported;
> +
> +	if (!riscv_isa_extension_available(isainfo->isa, v))
> +		return false;
> +
> +	/* This case will only happen if a unaligned vector load
> +	 * was called by the kernel before this check
> +	 */
> +	if (*mas_ptr != RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
> +		return false;
> +
> +	kernel_vector_begin();
> +	__asm__ __volatile__ (
> +		".option push\n\t"
> +		".option arch, +v\n\t"
> +		"	li t1, 0x1\n"				//size
> +		"       vsetvli t0, t1, e16, m2, ta, ma\n\t"	// Vectors of 16b
> +		"       addi t0, %[ptr], 1\n\t"			// Misalign address
> +		"	vle16.v v0, (t0)\n\t"			// Load bytes
> +		".option pop\n\t"
> +		: : [ptr] "r" (&tmp_var) : "v0", "t0", "t1", "memory");
> +	kernel_vector_end();
> +
> +	misaligned_vec_suported = (*mas_ptr == RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN);
> +
> +	return misaligned_vec_suported;
> +}
> +#else
> +static bool check_vector_unaligned_access(int cpu)
> +{
> +	return false;
> +}
> +#endif
> +
> +bool check_vector_unaligned_access_all_cpus(void)
> +{
> +	int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		if (!check_vector_unaligned_access(cpu))
> +			return false;
> +
> +	return true;
> +}
> +
>   bool check_unaligned_access_emulated_all_cpus(void)
>   {
>   	int cpu;
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
> index a9a6bcb02acf..92a84239beaa 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -20,6 +20,7 @@
>   #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
>   
>   DEFINE_PER_CPU(long, misaligned_access_speed);
> +DEFINE_PER_CPU(long, vector_misaligned_access) = RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>   
>   #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>   static cpumask_t fast_misaligned_access;
> @@ -264,6 +265,8 @@ static int check_unaligned_access_all_cpus(void)
>   {
>   	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>  

There was talks about Zicclsm, but spike doesnt have support for Zicclsm 
afaik, but I was wondering if i should add Zicclsm to cpufeature and aswell.

If anyone wants to run this i tested with
spike --misaligned --isa=RV64IMAFDCV_zicntr_zihpm 
--kernel=arch/riscv/boot/Image 
opensbi/build/platform/generic/firmware/fw_jump.elf


Thanks,
Jesse Taube


> +	check_vector_unaligned_access_all_cpus();
> +
>   	if (!all_cpus_emulated)
>   		return check_unaligned_access_speed_all_cpus();
>   
> @@ -273,6 +276,7 @@ static int check_unaligned_access_all_cpus(void)
>   static int check_unaligned_access_all_cpus(void)
>   {
>   	check_unaligned_access_emulated_all_cpus();
> +	check_vector_unaligned_access_all_cpus();
>   
>   	return 0;
>   }

