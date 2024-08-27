Return-Path: <linux-kernel+bounces-302623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD3896011A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B952831BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7155273466;
	Tue, 27 Aug 2024 05:35:05 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879813A25B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724736904; cv=none; b=DdHvJjgy/YVUKYu/gln3koqx9kPRpAajY8r6E+kGZY9dSucA2vVz0MS8Pq7VxKrDv29y8Q/kLxq5AaNyXzMBywBRYtAaesVSs0g1Yj7PwZop+cdHMF2DUMRghTxT5lYZG6TK3yoBPdKs7HebEDIqirDPHdgvDGELp1WBipv/mVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724736904; c=relaxed/simple;
	bh=mTpraw9smTfz5cG74VQDt20WNaHXePCLzO+AXsdtK6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fb/QUR7kevyoDQJqOQQBtKmcNXZ2dFcpl74NhgJ14HrdBZmQ3JXTkV6/q0+Wued4CkDH5tunVFSnZ2p1517dZrqDs2P0DQDTm/0ZAZ6cyrJDV7MOR8w/0EaA0WYN01DN1Pa/gRWKcZrU6YXaaQcUv3Jo4EF8kmrNJ9G5ZHQaIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A3C6EC427F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:28:10 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D0CF60002;
	Tue, 27 Aug 2024 05:27:56 +0000 (UTC)
Message-ID: <9535776a-5e4a-49b0-b75f-6e1b94706f46@ghiti.fr>
Date: Tue, 27 Aug 2024 07:27:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: Fix RISCV_ALTERNATIVE_EARLY
Content-Language: en-US
To: zhangchunyan@iscas.ac.cn, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240826105737.106879-1-alexghiti@rivosinc.com>
 <CAOsKWHCCEAi-G=Ld9GJ2YUrbbV6dEzThXh5rOzYp6kWfUHfNHw@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAOsKWHCCEAi-G=Ld9GJ2YUrbbV6dEzThXh5rOzYp6kWfUHfNHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Chunyan,

On 27/08/2024 06:57, Chunyan Zhang wrote:
> Hi Alex,
>
> On Mon, 26 Aug 2024 at 18:58, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> RISCV_ALTERNATIVE_EARLY will issue sbi_ecall() very early in the boot
>> process, before the first memory mapping is setup so we can't have any
>> instrumentation happening here.
> I also found that when CONFIG_KASAN is enabled, and either
> RISCV_ALTERNATIVE_EARLY or CONFIG_DT_IDLE_GENPD is set, the kernel
> cannot boot.


Yes, I was initially fixing this report: 
https://lore.kernel.org/linux-riscv/00000000000065062c061fcec37b@google.com/

And that makes me think I forgot the syzbot tag:

Reported-by: syzbot+cfbcb82adf6d7279fd35@syzkaller.appspotmail.com


>
> This patch fixed the issue.
>
> Tested-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>


Thanks!

Alex


>
>> In addition, when the kernel is relocatable, we must also not issue any
>> relocation this early since they would have been patched virtually only.
>>
>> So, instead of disabling instrumentation for the whole kernel/sbi.c file
>> and compiling it with -fno-pie, simply move __sbi_ecall() and
>> __sbi_base_ecall() into their own file where this is fixed.
>>
>> Fixes: 1745cfafebdf ("riscv: don't use global static vars to store alternative data")
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/sbi.h  |  2 ++
>>   arch/riscv/kernel/Makefile    |  6 ++++-
>>   arch/riscv/kernel/sbi.c       | 44 --------------------------------
>>   arch/riscv/kernel/sbi_ecall.c | 48 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 55 insertions(+), 45 deletions(-)
>>   create mode 100644 arch/riscv/kernel/sbi_ecall.c
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index 7cffd4ffecd0..5843a10b380e 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -9,6 +9,7 @@
>>
>>   #include <linux/types.h>
>>   #include <linux/cpumask.h>
>> +#include <linux/jump_label.h>
>>
>>   #ifdef CONFIG_RISCV_SBI
>>   enum sbi_ext_id {
>> @@ -304,6 +305,7 @@ struct sbiret {
>>   };
>>
>>   void sbi_init(void);
>> +long __sbi_base_ecall(int fid);
>>   struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
>>                            unsigned long arg2, unsigned long arg3,
>>                            unsigned long arg4, unsigned long arg5,
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index 06d407f1b30b..7f88cc4931f5 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -20,17 +20,21 @@ endif
>>   ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
>>   CFLAGS_alternative.o := -mcmodel=medany
>>   CFLAGS_cpufeature.o := -mcmodel=medany
>> +CFLAGS_sbi_ecall.o := -mcmodel=medany
>>   ifdef CONFIG_FTRACE
>>   CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
>>   CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
>> +CFLAGS_REMOVE_sbi_ecall.o = $(CC_FLAGS_FTRACE)
>>   endif
>>   ifdef CONFIG_RELOCATABLE
>>   CFLAGS_alternative.o += -fno-pie
>>   CFLAGS_cpufeature.o += -fno-pie
>> +CFLAGS_sbi_ecall.o += -fno-pie
>>   endif
>>   ifdef CONFIG_KASAN
>>   KASAN_SANITIZE_alternative.o := n
>>   KASAN_SANITIZE_cpufeature.o := n
>> +KASAN_SANITIZE_sbi_ecall.o := n
>>   endif
>>   endif
>>
>> @@ -88,7 +92,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)  += mcount-dyn.o
>>
>>   obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
>>   obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
>> -obj-$(CONFIG_RISCV_SBI)                += sbi.o
>> +obj-$(CONFIG_RISCV_SBI)                += sbi.o sbi_ecall.o
>>   ifeq ($(CONFIG_RISCV_SBI), y)
>>   obj-$(CONFIG_SMP)              += sbi-ipi.o
>>   obj-$(CONFIG_SMP) += cpu_ops_sbi.o
>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>> index 837bdab2601b..ace9e2f59c41 100644
>> --- a/arch/riscv/kernel/sbi.c
>> +++ b/arch/riscv/kernel/sbi.c
>> @@ -14,9 +14,6 @@
>>   #include <asm/smp.h>
>>   #include <asm/tlbflush.h>
>>
>> -#define CREATE_TRACE_POINTS
>> -#include <asm/trace.h>
>> -
>>   /* default SBI version is 0.1 */
>>   unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
>>   EXPORT_SYMBOL(sbi_spec_version);
>> @@ -27,36 +24,6 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
>>                             unsigned long start, unsigned long size,
>>                             unsigned long arg4, unsigned long arg5) __ro_after_init;
>>
>> -struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
>> -                         unsigned long arg2, unsigned long arg3,
>> -                         unsigned long arg4, unsigned long arg5,
>> -                         int fid, int ext)
>> -{
>> -       struct sbiret ret;
>> -
>> -       trace_sbi_call(ext, fid);
>> -
>> -       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
>> -       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
>> -       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
>> -       register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
>> -       register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
>> -       register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
>> -       register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
>> -       register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
>> -       asm volatile ("ecall"
>> -                     : "+r" (a0), "+r" (a1)
>> -                     : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
>> -                     : "memory");
>> -       ret.error = a0;
>> -       ret.value = a1;
>> -
>> -       trace_sbi_return(ext, ret.error, ret.value);
>> -
>> -       return ret;
>> -}
>> -EXPORT_SYMBOL(__sbi_ecall);
>> -
>>   int sbi_err_map_linux_errno(int err)
>>   {
>>          switch (err) {
>> @@ -535,17 +502,6 @@ long sbi_probe_extension(int extid)
>>   }
>>   EXPORT_SYMBOL(sbi_probe_extension);
>>
>> -static long __sbi_base_ecall(int fid)
>> -{
>> -       struct sbiret ret;
>> -
>> -       ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
>> -       if (!ret.error)
>> -               return ret.value;
>> -       else
>> -               return sbi_err_map_linux_errno(ret.error);
>> -}
>> -
>>   static inline long sbi_get_spec_version(void)
>>   {
>>          return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
>> diff --git a/arch/riscv/kernel/sbi_ecall.c b/arch/riscv/kernel/sbi_ecall.c
>> new file mode 100644
>> index 000000000000..24aabb4fbde3
>> --- /dev/null
>> +++ b/arch/riscv/kernel/sbi_ecall.c
>> @@ -0,0 +1,48 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2024 Rivos Inc. */
>> +
>> +#include <asm/sbi.h>
>> +#define CREATE_TRACE_POINTS
>> +#include <asm/trace.h>
>> +
>> +long __sbi_base_ecall(int fid)
>> +{
>> +       struct sbiret ret;
>> +
>> +       ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
>> +       if (!ret.error)
>> +               return ret.value;
>> +       else
>> +               return sbi_err_map_linux_errno(ret.error);
>> +}
>> +EXPORT_SYMBOL(__sbi_base_ecall);
>> +
>> +struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
>> +                         unsigned long arg2, unsigned long arg3,
>> +                         unsigned long arg4, unsigned long arg5,
>> +                         int fid, int ext)
>> +{
>> +       struct sbiret ret;
>> +
>> +       trace_sbi_call(ext, fid);
>> +
>> +       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
>> +       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
>> +       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
>> +       register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
>> +       register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
>> +       register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
>> +       register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
>> +       register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
>> +       asm volatile ("ecall"
>> +                      : "+r" (a0), "+r" (a1)
>> +                      : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
>> +                      : "memory");
>> +       ret.error = a0;
>> +       ret.value = a1;
>> +
>> +       trace_sbi_return(ext, ret.error, ret.value);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL(__sbi_ecall);
>> --
>> 2.39.2
>>
>>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

