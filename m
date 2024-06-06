Return-Path: <linux-kernel+bounces-204612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620388FF139
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E5C1F24E47
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411019755B;
	Thu,  6 Jun 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Pk8mzkoV"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE341974E7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689070; cv=none; b=AdIhosDeJ75mm82s5LFR44I3hCTnR6SAJvPKvOhusWbeyK9TZVTJtIN8ifAvueiohPhdp3aSi9sQ4SyYSdsQfbGzU2Qb0WiHomQIxYV8nPcfXZiPnIC0OAxqTmgQKXfBd741yFJl10lvH7nnzQvX5EaGxI2OzYobnuSBcez3+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689070; c=relaxed/simple;
	bh=adIEv1ABiv2Y/+wtwJ0SEGkRWG7wXeRgEZiP/ll5KEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9t3JwV9Vt/S1bzhn8iuwIz197Oj99XHp2QHpxwRU0RJwBBFLCo1K6TxwwndRiVoPPbAJaHPVltPIX3slYbOqhoCoBLYeYsDeH+QF8HoFbh+8Mv8R1DHWat0pS7Yp5XJn0XL0ehvgoJuSq5ANTLOb4qDjKAUY/oHvEnyQafvtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Pk8mzkoV; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c1b9152848so909732a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717689066; x=1718293866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDmlKGnxhvteIYdGoZUuN1H/FeEZVR1GpReejN7otNE=;
        b=Pk8mzkoV+pveD92SZ6BzoOTJxeD6reE57n33laI7mcOw9dqbNPGj89GOW7pPLz8CtT
         X1JzbsJkEiG5yaNgSV8vHLGszIYdVmJuGdT87iACuAtUZnG5V02D/FbUaCv7hF5GkkxX
         Ew9uIW8zfxynGcFnK0LYb+sXnDAgivC0z/6oXpn/Pnsi/lPuxfQdB7tmtC6pOcnkIiMw
         Yym+qq7fO0hcdVm+kok1JT99j+YxAfalky3uaEBsW+p3dOeiJEC/iDSi+ucRkU3Zxqlm
         dO56k9niIH//NeUKu2g5aWoRKx+4MAc34g4PHDE5N/R/GkfxzFhbEgukxevSREq243KH
         os6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717689066; x=1718293866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDmlKGnxhvteIYdGoZUuN1H/FeEZVR1GpReejN7otNE=;
        b=MarXRRpQONl5BSx1CMnipuGiNpCkRpbIljs8t0RUAvjsjqvseRf1vAaqT8st43Z9iz
         JIWMC/yX7Km5wctS4sfyvKx3TkQpaqDxXvUPEXNBABahXwm/zfmeYWKJJKeH1F5Jce0A
         XKJWL0foAhQZPvTp1orfVkGxOEJ4ofiLr6LDx9rC3ADB5Mi6Rs2Nm7Pc5IihVwmvdZ4z
         wbGqvxLk6gl0973GR8LQUzkgwvvzk2XECcntps6ug9CcbtXkTJnF5W/iPD5dkIrQSd4r
         4wRjtw7RUqtR4ZX0pvuiN+rxeRgbbubRT7GWDE3M+wiPnRB4KudxkhC6hyyfmNMK+7T5
         pkhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9H4MAfGRgjo8qbkunnTQUdFS9x6rSKjsvomlEc2YRda3lHIhWTlsminLi7DhFdBUmDwt6kSSQqEk760SlqbN5P8I4eLyQgOe+8l56
X-Gm-Message-State: AOJu0YwVZhXOq4rkj+cYBGXeTayxkSMZca2vJ/1/NFwlsuo/uKelzdea
	BGiiLsNKq26vzjKYz1S6ZBi/iM4PwGkER1WEPlbUGvVs4Zc6TpS7SdWliLQRC9Q=
X-Google-Smtp-Source: AGHT+IGDNf+n2WEFOQ3uys+exa6v8+p9xOEthb5+b/G77zFZwY+Wcx90+vRsnhUCfmsd12xUa2qWiA==
X-Received: by 2002:a17:90a:9ac:b0:2c2:5341:7ed6 with SMTP id 98e67ed59e1d1-2c27db58f5dmr6165630a91.38.1717689066272;
        Thu, 06 Jun 2024 08:51:06 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28063a7fcsm3756281a91.7.2024.06.06.08.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 08:51:05 -0700 (PDT)
Message-ID: <bd3b89cb-07fc-4b9f-9f10-9b0f3664ec5e@rivosinc.com>
Date: Thu, 6 Jun 2024 11:50:56 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
To: Zong Li <zong.li@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <CANXhq0pYNWvMxkkNPpYW4OrOXK19Rehdy3yO8u1sforyVjdTZg@mail.gmail.com>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <CANXhq0pYNWvMxkkNPpYW4OrOXK19Rehdy3yO8u1sforyVjdTZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/5/24 00:51, Zong Li wrote:
> On Sat, Jun 1, 2024 at 12:23 AM Jesse Taube <jesse@rivosinc.com> wrote:
>>
>> Dectect the Zkr extension and use it to seed the kernel base address.
>>
>> Detection of the extension can not be done in the typical fashion, as
>> this is very early in the boot process. Instead, add a trap handler
>> and run it to see if the extension is present.
>>
>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>> ---
>>   arch/riscv/kernel/pi/Makefile           |  2 +-
>>   arch/riscv/kernel/pi/archrandom_early.c | 71 +++++++++++++++++++++++++
>>   arch/riscv/mm/init.c                    |  3 ++
>>   3 files changed, 75 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/riscv/kernel/pi/archrandom_early.c
>>
>> diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
>> index 50bc5ef7dd2f..9025eb52945a 100644
>> --- a/arch/riscv/kernel/pi/Makefile
>> +++ b/arch/riscv/kernel/pi/Makefile
>> @@ -32,5 +32,5 @@ $(obj)/string.o: $(srctree)/lib/string.c FORCE
>>   $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
>>          $(call if_changed_rule,cc_o_c)
>>
>> -obj-y          := cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
>> +obj-y          := cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o archrandom_early.pi.o
>>   extra-y                := $(patsubst %.pi.o,%.o,$(obj-y))
>> diff --git a/arch/riscv/kernel/pi/archrandom_early.c b/arch/riscv/kernel/pi/archrandom_early.c
>> new file mode 100644
>> index 000000000000..311be9388b5c
>> --- /dev/null
>> +++ b/arch/riscv/kernel/pi/archrandom_early.c
>> @@ -0,0 +1,71 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * To avoid rewriteing code include asm/archrandom.h and create macros
>> + * for the functions that won't be included.
>> + */
>> +
>> +#define riscv_has_extension_likely(...) false
>> +#define pr_err_once(...)
>> +
>> +#include <linux/types.h>
>> +#include <asm/hwcap.h>
>> +#include <asm/archrandom.h>
>> +
>> +/*
>> + * Asm goto is needed so that the compiler does not remove the label.
>> + */
>> +
>> +#define csr_goto_swap(csr, val)                                                \
>> +({                                                                     \
>> +       unsigned long __v;                                              \
>> +       __asm__ __volatile__ goto("csrrw %0, " __ASM_STR(csr) ", %1"    \
>> +                                 : "=r" (__v) : "rK" (&&val)           \
>> +                                 : "memory" : val);                    \
>> +       __v;                                                            \
>> +})
>> +
>> +/*
>> + * Declare the functions that are exported (but prefixed) here so that LLVM
>> + * does not complain it lacks the 'static' keyword (which, if added, makes
>> + * LLVM complain because the function is actually unused in this file).
>> + */
>> +
>> +u64 get_kaslr_seed_zkr(void);
>> +
>> +/*
>> + * This function is called by setup_vm to check if the kernel has the ZKR.
>> + * Traps haven't been set up yet, but save and restore the TVEC to avoid
>> + * any side effects.
>> + */
>> +
>> +static inline bool __must_check riscv_has_zkr(void)
>> +{
>> +       unsigned long tvec;
>> +
>> +       tvec = csr_goto_swap(CSR_TVEC, not_zkr);
>> +       csr_swap(CSR_SEED, 0);
>> +       csr_write(CSR_TVEC, tvec);
>> +       return true;
>> +not_zkr:
>> +       csr_write(CSR_TVEC, tvec);
>> +       return false;
>> +}
>> +
>> +u64 get_kaslr_seed_zkr(void)
>> +{
>> +       const int needed_seeds = sizeof(u64) / sizeof(long);
>> +       int i = 0;
>> +       u64 seed = 0;
>> +       long *entropy = (long *)(&seed);
>> +
>> +       if (!riscv_has_zkr())
>> +               return 0;
>> +
>> +       for (i = 0; i < needed_seeds; i++) {
>> +               if (!csr_seed_long(&entropy[i]))
>> +                       return 0;
>> +       }
>> +
>> +       return seed;
>> +}
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 9940171c79f0..8ef1edd2cddd 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1025,6 +1025,7 @@ static void __init pt_ops_set_late(void)
>>   #ifdef CONFIG_RANDOMIZE_BASE
>>   extern bool __init __pi_set_nokaslr_from_cmdline(uintptr_t dtb_pa);
>>   extern u64 __init __pi_get_kaslr_seed(uintptr_t dtb_pa);
>> +extern u64 __init __pi_get_kaslr_seed_zkr(void);
>>
>>   static int __init print_nokaslr(char *p)
>>   {
>> @@ -1049,6 +1050,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>                  u32 kernel_size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
>>                  u32 nr_pos;
>>
>> +               if (kaslr_seed == 0)
>> +                       kaslr_seed = __pi_get_kaslr_seed_zkr();
> 
> Could you elaborate on why we try to get the seed from DT first,
> rather than from ZKR? 

The ordering preference doesn't matter to much,
but my thought was if someone wanted to set a seed they could override
the Zkr provided seed. Alexandre said privately to use the DT as a
fallback rather than the way we have it now.

> Also, I was wondering if, by any chance, it can
> leverage arch_get_random_seed_longs() to get the seed instead of
> __pi_get_kasler_seed_zkr()? Thanks


arch_get_random_seed_longs() is almost equivalent to
__pi_get_kasler_seed_zkr()
in the sense they do they will both use Zkr for entropy
if its accessible.

The problem is that we are very early in the boot process so the check 
arch_get_random_seed_longs uses to detect if Zkr is present 
(__riscv_isa_extension_available) is not set up yet. This is why 
riscv_has_zkr is used to check if Zkr is present. Unfortunately, which I 
didn't realize is that how riscv_has_zkr works isn't a valid way to 
check if Zkr is present.

The only solution seems to be parsing the ISA string from DT and ACPI.
The hard part is parsing ACPI this early in boot.

Thanks,
Jesse Taube

> 
>>                  /*
>>                   * Compute the number of positions available: we are limited
>>                   * by the early page table that only has one PUD and we must
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

