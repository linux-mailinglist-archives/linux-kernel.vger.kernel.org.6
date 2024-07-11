Return-Path: <linux-kernel+bounces-249825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495D392F06A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB8428340F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD40819EEB5;
	Thu, 11 Jul 2024 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Um1V4g21"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E171B51
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730169; cv=none; b=fDP1y9C3hLYeSS+mtwFhQ/O1QvNVueIN/IrZTzFHr6WrQucRYxBp6gfHbklMJj2RLUxFDpEBgVfkYr2tMM2jZ6FUT35kwzSG9SMX524Pzrkm9syUtSEYahzTvHxPMdFIEnOezTbC2AeuVnz2pZuDQZ9FG5ooAoPoZJrN0FGKeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730169; c=relaxed/simple;
	bh=PeO9iJ4qGaey0O4CTQarCIf1753t50Uh90bSze4RBOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9PEKc300tobHS8hMxUYp0dW0zdxidXb+g7tOAyn0AJq1ULcFKhCvW4q8in1EgN7SUmPH6sMFK841xnl7+VQ8JdePycQ4vnwaNQcGqn3EMPveeR+U7SSTyJAlUDYo5Km5bYA9sf8I2UbgvYGh3TgOEwnI4S2ZFU7ksilUEG5W/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Um1V4g21; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c9a10728abso1030040a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720730167; x=1721334967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XM23m68bbafkYGbjSkRQrCkp+qVdrLKXy7oG+vwEN1M=;
        b=Um1V4g21tizzIwR68/1IcKvZvfA2ekP92+V1/v/yWGezuBjCNsFyMJp2a02RVXY5to
         sLKzPgv9MFEsITTj8c+z3m3vvALPYtAIOitiSjN7g3X6fMp47cWbiiyY0a697XpeK0c9
         U47XMKQ/n8fHSIUsIVSylmrJpOkV9BIpMNDkBy/ayynsooLm4LeWyAR7Zt7p4Emqs+xc
         gqm0U4/Q97XuDtvfY6f7VH60eOHN0a/7BtS+2/PFuRE4RLye6TYkuIGMvaTc0rPu2yGw
         bncxBJEHK2CVTEqVqjATvHgtLKfE94l/iYNIFf05qMbSFUudSWRX37b7BnChtnqklq89
         2s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720730167; x=1721334967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XM23m68bbafkYGbjSkRQrCkp+qVdrLKXy7oG+vwEN1M=;
        b=L92C1VLQG5eyUCakvYaXszFhGfWYkvCKYWZZy6fNuE63pBY5axLIm0YEcHWsDEvujO
         pz59lNA8r/ORCmPzR4YZYwUO65wjoadpp4j0lYhFAjIroPoJPgvDr7kdeniKiNN02bJX
         9sPQnevmRTFBtPXWFUvo4GU8baG9Mkc7NIFBFZuDfnSRTe3nL9EWdATMdY8am+qhmGhf
         goSqm0bfFHvb/SZcY+vgNnO0FhFkd4vegoXOGcvHLOdLD5Yq0QAGd2t5yqtA8I/rPX/5
         LMbDSFG6yZ+zsp5262o3lwwDCpGPbNvQwuazGtX1mNmzSG1ltu0J7YRZCbaGw1dfM1R7
         2zUw==
X-Forwarded-Encrypted: i=1; AJvYcCVpBzO0TN6FyaX+0Msj2aVTBHvG/SC80YKkKV4AAyXg0PmqNzAxZXGJsVMqMkW10D1MhZXLguId2GzsTQ2KdRVzq6ot10b5+qObggdy
X-Gm-Message-State: AOJu0YxImQYcolSOYRvcpr7U8eihjTb+EzVtogQ+1/Rhh93sBh/d0ZVc
	1qzb855Issiy9FEvbmqJhCLiP6M5lFp/mniwy/yRBfiqkJNb3OnYHQSs+fCD98c=
X-Google-Smtp-Source: AGHT+IHNODoHTSGizbX9XTfhAoUDG9qisOWj3sy23uhOTBaLFohn3DacZivVAWS8oFPLcotjpXXYkg==
X-Received: by 2002:a17:90a:f58c:b0:2c9:6a15:640 with SMTP id 98e67ed59e1d1-2ca35bde1a6mr7781858a91.4.1720730166557;
        Thu, 11 Jul 2024 13:36:06 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd657fa5sm6860a91.38.2024.07.11.13.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 13:36:06 -0700 (PDT)
Message-ID: <fffa46a0-e458-401f-ac90-8c4d7bbea8eb@rivosinc.com>
Date: Thu, 11 Jul 2024 16:35:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] RISC-V: Report vector unaligned access speed
 hwprobe
To: Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>,
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
References: <20240625005001.37901-1-jesse@rivosinc.com>
 <20240625005001.37901-8-jesse@rivosinc.com>
 <CALs-HssQdKqNGZPUE8b+J57NTQyarYbk=DHR10-+YizZE1uQ+w@mail.gmail.com>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <CALs-HssQdKqNGZPUE8b+J57NTQyarYbk=DHR10-+YizZE1uQ+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/1/24 18:51, Evan Green wrote:
> On Mon, Jun 24, 2024 at 5:52 PM Jesse Taube <jesse@rivosinc.com> wrote:
>>
>> Detect if vector misaligned accesses are faster or slower than
>> equivalent vector byte accesses. This is useful for usermode to know
>> whether vector byte accesses or vector misaligned accesses have a better
>> bandwidth for operations like memcpy.
>>
>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>> ---
>> V1 -> V2:
>>   - Add Kconfig options
>>   - Add WORD_EEW to vec-copy-unaligned.S
>> V2 -> V3:
>>   - Remove unnecessary comment
>>   - Remove local_irq_enable
>> ---
>>   arch/riscv/Kconfig                         |  18 +++
>>   arch/riscv/kernel/Makefile                 |   3 +-
>>   arch/riscv/kernel/copy-unaligned.h         |   5 +
>>   arch/riscv/kernel/sys_hwprobe.c            |   6 +
>>   arch/riscv/kernel/unaligned_access_speed.c | 132 ++++++++++++++++++++-
>>   arch/riscv/kernel/vec-copy-unaligned.S     |  58 +++++++++
>>   6 files changed, 219 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index ffbe0fdd7fb3..6f9fd3748916 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -807,6 +807,24 @@ config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>>            will dynamically determine the speed of vector unaligned accesses on
>>            the underlying system if they are supported.
>>
>> +config RISCV_SLOW_VEC_UNALIGNED_ACCESS
>> +       bool "Assume the system supports slow vector unaligned memory accesses"
>> +       depends on NONPORTABLE
>> +       help
>> +         Assume that the system supports slow vector unaligned memory accesses. The
>> +         kernel and userspace programs may not be able to run at all on systems
>> +         that do not support unaligned memory accesses.
>> +
>> +config RISCV_EFFICIENT_VEC_UNALIGNED_ACCESS
>> +       bool "Assume the system supports fast vector unaligned memory accesses"
>> +       depends on NONPORTABLE
>> +       help
>> +         Assume that the system supports fast vector unaligned memory accesses. When
>> +         enabled, this option improves the performance of the kernel on such
>> +         systems. However, the kernel and userspace programs will run much more
>> +         slowly, or will not be able to run at all, on systems that do not
>> +         support efficient unaligned memory accesses.
>> +
>>   endchoice
>>
>>   endmenu # "Platform type"
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index 5b243d46f4b1..291935a084d5 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -64,7 +64,8 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
>>
>>   obj-$(CONFIG_RISCV_MISALIGNED) += traps_misaligned.o
>>   obj-$(CONFIG_RISCV_MISALIGNED) += unaligned_access_speed.o
>> -obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)     += copy-unaligned.o
>> +obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)             += copy-unaligned.o
>> +obj-$(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)      += vec-copy-unaligned.o
>>
>>   obj-$(CONFIG_FPU)              += fpu.o
>>   obj-$(CONFIG_FPU)              += kernel_mode_fpu.o
>> diff --git a/arch/riscv/kernel/copy-unaligned.h b/arch/riscv/kernel/copy-unaligned.h
>> index e3d70d35b708..85d4d11450cb 100644
>> --- a/arch/riscv/kernel/copy-unaligned.h
>> +++ b/arch/riscv/kernel/copy-unaligned.h
>> @@ -10,4 +10,9 @@
>>   void __riscv_copy_words_unaligned(void *dst, const void *src, size_t size);
>>   void __riscv_copy_bytes_unaligned(void *dst, const void *src, size_t size);
>>
>> +#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>> +void __riscv_copy_vec_words_unaligned(void *dst, const void *src, size_t size);
>> +void __riscv_copy_vec_bytes_unaligned(void *dst, const void *src, size_t size);
>> +#endif
>> +
>>   #endif /* __RISCV_KERNEL_COPY_UNALIGNED_H */
>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
>> index 5b78ea5a84d1..46de3f145154 100644
>> --- a/arch/riscv/kernel/sys_hwprobe.c
>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>> @@ -221,6 +221,12 @@ static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>>   #else
>>   static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
>>   {
>> +       if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_VEC_UNALIGNED_ACCESS))
>> +               return RISCV_HWPROBE_VEC_MISALIGNED_FAST;
>> +
>> +       if (IS_ENABLED(CONFIG_RISCV_SLOW_VEC_UNALIGNED_ACCESS))
>> +               return RISCV_HWPROBE_VEC_MISALIGNED_SLOW;
>> +
>>          return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
>>   }
>>   #endif
>> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
>> index 8489e012cf23..a2a8f948500b 100644
>> --- a/arch/riscv/kernel/unaligned_access_speed.c
>> +++ b/arch/riscv/kernel/unaligned_access_speed.c
>> @@ -8,9 +8,11 @@
>>   #include <linux/jump_label.h>
>>   #include <linux/mm.h>
>>   #include <linux/smp.h>
>> +#include <linux/kthread.h>
>>   #include <linux/types.h>
>>   #include <asm/cpufeature.h>
>>   #include <asm/hwprobe.h>
>> +#include <asm/vector.h>
>>
>>   #include "copy-unaligned.h"
>>
>> @@ -267,9 +269,129 @@ static int check_unaligned_access_speed_all_cpus(void)
>>   }
>>   #endif
>>
>> +#ifdef CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
>> +static void check_vector_unaligned_access(struct work_struct *unused)
>> +{
>> +       int cpu = smp_processor_id();
>> +       u64 start_cycles, end_cycles;
>> +       u64 word_cycles;
>> +       u64 byte_cycles;
>> +       int ratio;
>> +       unsigned long start_jiffies, now;
>> +       struct page *page;
>> +       void *dst;
>> +       void *src;
>> +       long speed = RISCV_HWPROBE_VEC_MISALIGNED_SLOW;
>> +
>> +       if (per_cpu(vector_misaligned_access, cpu) != RISCV_HWPROBE_VEC_MISALIGNED_SLOW)
>> +               return;
>> +
>> +       page = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
>> +       if (!page) {
>> +               pr_warn("Allocation failure, not measuring vector misaligned performance\n");
>> +               return;
>> +       }
>> +
>> +       /* Make an unaligned destination buffer. */
>> +       dst = (void *)((unsigned long)page_address(page) | 0x1);
>> +       /* Unalign src as well, but differently (off by 1 + 2 = 3). */
>> +       src = dst + (MISALIGNED_BUFFER_SIZE / 2);
>> +       src += 2;
>> +       word_cycles = -1ULL;
>> +
>> +       /* Do a warmup. */
>> +       kernel_vector_begin();
> 
> Should there be a preempt_disable() in here too, or is that implied
> already by schedule_on_each_cpu? Mainly we want to minimize the amount
> of things that might soak up our jiffy and steal iterations from the
> loop.

To test I put a schedule here and it says OOPS we are attomic.

I added preempt_disable and preempt_enable to be sure preemption is 
disabled anyway.

> 
>> +       __riscv_copy_vec_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
>> +
>> +       start_jiffies = jiffies;
>> +       while ((now = jiffies) == start_jiffies)
>> +               cpu_relax();
>> +
>> +       /*
>> +        * For a fixed amount of time, repeatedly try the function, and take
>> +        * the best time in cycles as the measurement.
>> +        */
>> +       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
>> +               start_cycles = get_cycles64();
>> +               /* Ensure the CSR read can't reorder WRT to the copy. */
>> +               mb();
>> +               __riscv_copy_vec_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
>> +               /* Ensure the copy ends before the end time is snapped. */
>> +               mb();
>> +               end_cycles = get_cycles64();
>> +               if ((end_cycles - start_cycles) < word_cycles)
>> +                       word_cycles = end_cycles - start_cycles;
>> +       }
>> +
>> +       byte_cycles = -1ULL;
>> +       __riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
>> +       start_jiffies = jiffies;
>> +       while ((now = jiffies) == start_jiffies)
>> +               cpu_relax();
>> +
>> +       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
>> +               start_cycles = get_cycles64();
>> +               mb();
>> +               __riscv_copy_vec_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
>> +               mb();
>> +               end_cycles = get_cycles64();
>> +               if ((end_cycles - start_cycles) < byte_cycles)
>> +                       byte_cycles = end_cycles - start_cycles;
>> +       }
>> +
>> +       kernel_vector_end();
>> +
>> +       /* Don't divide by zero. */
>> +       if (!word_cycles || !byte_cycles) {
>> +               pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned vector access speed\n",
>> +                       cpu);
>> +
>> +               return;
>> +       }
>> +
>> +       if (word_cycles < byte_cycles)
>> +               speed = RISCV_HWPROBE_VEC_MISALIGNED_FAST;
>> +
>> +       ratio = div_u64((byte_cycles * 100), word_cycles);
>> +       pr_info("cpu%d: Ratio of vector byte access time to vector unaligned word access is %d.%02d, unaligned accesses are %s\n",
>> +               cpu,
>> +               ratio / 100,
>> +               ratio % 100,
>> +               (speed ==  RISCV_HWPROBE_VEC_MISALIGNED_FAST) ? "fast" : "slow");
>> +
>> +       per_cpu(vector_misaligned_access, cpu) = speed;
>> +}
>> +
>> +static int riscv_online_cpu_vec(unsigned int cpu)
>> +{
>> +       check_vector_unaligned_access(NULL);
>> +       return 0;
>> +}
>> +
>> +/* Measure unaligned access speed on all CPUs present at boot in parallel. */
>> +static int vec_check_unaligned_access_speed_all_cpus(void *unused)
>> +{
>> +       schedule_on_each_cpu(check_vector_unaligned_access);
>> +
>> +       /*
>> +        * Setup hotplug callbacks for any new CPUs that come online or go
>> +        * offline.
>> +        */
>> +       cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
>> +                                 riscv_online_cpu_vec, NULL);
>> +
>> +       return 0;
>> +}
>> +#else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
>> +static int vec_check_unaligned_access_speed_all_cpus(void *unused)
>> +{
>> +       return 0;
>> +}
>> +#endif
>> +
>>   static int check_unaligned_access_all_cpus(void)
>>   {
>> -       bool all_cpus_emulated;
>> +       bool all_cpus_emulated, all_cpus_vec_supported;
>>          int cpu;
>>
>>          if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
>> @@ -285,7 +407,13 @@ static int check_unaligned_access_all_cpus(void)
>>          }
>>
>>          all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>> -       check_vector_unaligned_access_emulated_all_cpus();
>> +       all_cpus_vec_supported = check_vector_unaligned_access_emulated_all_cpus();
>> +
>> +       if (all_cpus_vec_supported &&
> 
> Note that with this here, if a heterogeneous system ever shows up with
> a mix of supported/unsupported, the supported cpus will end up with a
> misaligned vector speed of UNKNOWN. It might be nicer to change the
> semantics of that return value from all_cpus_vec_supported (aka
> entirely_supported) to entirely_unsupported. Then you'd only fire up
> the thread if (!entirely_unsupported). If you did that, you'd also
> need to bail early in the check on any CPUs that already had their
> value set to UNSUPPORTED.

Fortunatly check_vector_unaligned_access already checks this.

> That way we can still avoid firing up this
> thread for machines that don't have misaligned V (or V at all), but
> not leave the question UNKNOWN in some cases.

That makes a lot of sence I'm not sure why I didnt think ot that.
I changed it to `all_cpus_vec_unsupported` so it will check the speed if 
atleast one cpu has unaligned vector support.

Thanks,
Jesse taube

> 
>> +           IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
>> +               kthread_run(vec_check_unaligned_access_speed_all_cpus,
>> +                           NULL, "vec_check_unaligned_access_speed_all_cpus");
>> +       }
>>
>>          if (!all_cpus_emulated)
>>                  return check_unaligned_access_speed_all_cpus();
>> diff --git a/arch/riscv/kernel/vec-copy-unaligned.S b/arch/riscv/kernel/vec-copy-unaligned.S
>> new file mode 100644
>> index 000000000000..e5bc94917e60
>> --- /dev/null
>> +++ b/arch/riscv/kernel/vec-copy-unaligned.S
>> @@ -0,0 +1,58 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2024 Rivos Inc. */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/asm.h>
>> +#include <linux/args.h>
>> +
>> +       .text
>> +
>> +#define WORD_EEW 32
>> +
>> +#define WORD_SEW CONCATENATE(e, WORD_EEW)
>> +#define VEC_L CONCATENATE(vle, WORD_EEW).v
>> +#define VEC_S CONCATENATE(vle, WORD_EEW).v
>> +
>> +/* void __riscv_copy_vec_words_unaligned(void *, const void *, size_t) */
>> +/* Performs a memcpy without aligning buffers, using word loads and stores. */
>> +/* Note: The size is truncated to a multiple of WORD_EEW */
>> +SYM_FUNC_START(__riscv_copy_vec_words_unaligned)
>> +       andi  a4, a2, ~(WORD_EEW-1)
>> +       beqz  a4, 2f
>> +       add   a3, a1, a4
>> +       .option push
>> +       .option arch, +zve32x
>> +1:
>> +       vsetivli t0, 8, WORD_SEW, m8, ta, ma
>> +       VEC_L v0, (a1)
>> +       VEC_S v0, (a0)
>> +       addi  a0, a0, WORD_EEW
>> +       addi  a1, a1, WORD_EEW
>> +       bltu  a1, a3, 1b
>> +
>> +2:
>> +       .option pop
>> +       ret
>> +SYM_FUNC_END(__riscv_copy_vec_words_unaligned)
>> +
>> +/* void __riscv_copy_vec_bytes_unaligned(void *, const void *, size_t) */
>> +/* Performs a memcpy without aligning buffers, using only byte accesses. */
>> +/* Note: The size is truncated to a multiple of 8 */
>> +SYM_FUNC_START(__riscv_copy_vec_bytes_unaligned)
>> +       andi a4, a2, ~(8-1)
>> +       beqz a4, 2f
>> +       add  a3, a1, a4
>> +       .option push
>> +       .option arch, +zve32x
>> +1:
>> +       vsetivli t0, 8, e8, m8, ta, ma
>> +       vle8.v v0, (a1)
>> +       vse8.v v0, (a0)
>> +       addi a0, a0, 8
>> +       addi a1, a1, 8
>> +       bltu a1, a3, 1b
>> +
>> +2:
>> +       .option pop
>> +       ret
>> +SYM_FUNC_END(__riscv_copy_vec_bytes_unaligned)
>> --
>> 2.45.2
>>

