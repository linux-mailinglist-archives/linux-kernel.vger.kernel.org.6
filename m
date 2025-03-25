Return-Path: <linux-kernel+bounces-574993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA667A6EC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2F37A383A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DF725290C;
	Tue, 25 Mar 2025 09:12:31 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71C1F940A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893950; cv=none; b=P0ukkeje/ywrfjz36yJ8AJYB3xEvgxgvKnCDqCvXwlt6NNZmVQQc7p17dSbFf3jjE56gr14nrcIi5zvim8wgFepj5ioRbPqgyLfXsgQ7ISj8anhpCxJa9XFnWWzjUk6K+ci9L1eQl9uPkwSK+3zsFlgM+3V5NLJ7zm3R9233Iz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893950; c=relaxed/simple;
	bh=b9he5cC70vuyc5wkpSLIy0f1koMsdlqyCxHaRZctk6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjMO5hPamYKA4yUgjLLswdlivoFV4e34Dr7uQAmSJNJU0RDbPLuExQNfRY3DIAEoLnoToVIKdfvQWaEt6yGNZF3EJkVM0kqaH302RemrLuJJwvMk71J3b/XY7autNZt9+RKaSnK/Vzyzyz0e0OBVQ5dVSiNBqHQSqeHOYgKodow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 816784341A;
	Tue, 25 Mar 2025 09:12:22 +0000 (UTC)
Message-ID: <c6d329e3-f712-4da9-879b-26f52086fc36@ghiti.fr>
Date: Tue, 25 Mar 2025 10:12:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv: Fix the PAUSE Opcode for MIPS P8700.
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "arikalo@gmail.com" <arikalo@gmail.com>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
 "christoph.muellner@vrull.eu" <christoph.muellner@vrull.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250129131703.733098-1-arikalo@gmail.com>
 <mhng-c1c0b3c0-f358-40ce-ba1d-e33d2b85d9cc@palmer-ri-x1c9>
 <AS4PR09MB651829E38B4857711DD6799CF7D92@AS4PR09MB6518.eurprd09.prod.outlook.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <AS4PR09MB651829E38B4857711DD6799CF7D92@AS4PR09MB6518.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeeffffgheehfeeltefhveehkeethedtjeegkedvffdutddtgfeuhfdtvdelffdtffenucffohhmrghinheprghkrgdrmhhspdgvnhhtrhihrdhssgdpihhnfhhrrgguvggrugdrohhrghenucfkphepfedurdefvddrkedurddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurdefvddrkedurddukeejpdhhvghloheplgduledvrdduieekrddvuddrvdehngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepffhjohhrughjvgdrvfhoughorhhovhhitgeshhhtvggtghhrohhuphdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrrhhikhgrlhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdpr
 hgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheprghjohhnvghssehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopegthhhrihhsthhophhhrdhmuhgvlhhlnhgvrhesvhhruhhllhdrvghu
X-GND-Sasl: alex@ghiti.fr

Hi Djordje,

On 19/03/2025 13:26, Djordje Todorovic wrote:
> HTEC Public
>
> Hi everyone,
>
> Thank you a lot for your comments.
> I am wondering how we should proceed from here.


I don't think there is a requirement for exposing this new encoding to 
userspace, you just need to make sure that Zihintpause is not advertised 
though.

So either you expose a new vendor extension to userspace so that the 
difference in the encoding can be dealt with or you make sure you don't 
expose Zihintpause.

Thanks,

Alex


>
> Best,
> Djordje
>
> ________________________________________
> From: Palmer Dabbelt <palmer@dabbelt.com>
> Sent: Wednesday, February 5, 2025 4:44 PM
> To: arikalo@gmail.com <arikalo@gmail.com>
> Cc: linux-riscv@lists.infradead.org <linux-riscv@lists.infradead.org>; Paul Walmsley <paul.walmsley@sifive.com>; aou@eecs.berkeley.edu <aou@eecs.berkeley.edu>; ajones@ventanamicro.com <ajones@ventanamicro.com>; christoph.muellner@vrull.eu <christoph.muellner@vrull.eu>; arikalo@gmail.com <arikalo@gmail.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Subject: Re: [PATCH v3] riscv: Fix the PAUSE Opcode for MIPS P8700.
>
> [You don't often get email from palmer@dabbelt.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Wed, 29 Jan 2025 05:17:03 PST (-0800), arikalo@gmail.com wrote:
>> From: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>>
>> The riscv MIPS P8700 uses a different opcode for PAUSE.
>> It is a ‘hint’ encoding of the SLLI instruction, with rd=0, rs1=0 and
>> imm=5. It will behave as a NOP instruction if no additional behavior
>> beyond that of SLLI is implemented.
> We need to expose it to userspace, then, as it's a user-visible erratum
> -- really it's just a totally different custom extension than
> Zihintpause, but I don't think it really makes much of a difference what
> we call it.
>
> If you have other custom stuff it's probably a good time to expose
> those, too, as then it'll be easier for userspace to sort out.
>
>> Add ERRATA_MIPS and ERRATA_MIPS_P8700_PAUSE_OPCODE configs.
>> Handle errata for MIPS CPUs.
>>
>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>> Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
>> Signed-off-by: Raj Vishwanathan4 <rvishwanathan@mips.com>
>> ---
>>   arch/riscv/Kconfig.errata                     | 23 +++++++++++
>>   arch/riscv/errata/Makefile                    |  1 +
>>   arch/riscv/errata/mips/Makefile               |  5 +++
>>   arch/riscv/errata/mips/errata.c               | 41 +++++++++++++++++++
>>   arch/riscv/include/asm/alternative.h          |  3 ++
>>   arch/riscv/include/asm/cmpxchg.h              |  3 +-
>>   arch/riscv/include/asm/errata_list.h          | 20 ++++++++-
>>   arch/riscv/include/asm/vdso/processor.h       |  4 +-
>>   arch/riscv/include/asm/vendorid_list.h        |  1 +
>>   arch/riscv/kernel/alternative.c               |  5 +++
>>   arch/riscv/kernel/entry.S                     |  2 +
>>   arch/riscv/mm/init.c                          |  1 +
>>   tools/arch/riscv/include/asm/vdso/processor.h |  5 ++-
>>   13 files changed, 110 insertions(+), 4 deletions(-)
>>   create mode 100644 arch/riscv/errata/mips/Makefile
>>   create mode 100644 arch/riscv/errata/mips/errata.c
>>
>> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
>> index 2acc7d876e1f..1589528fdc30 100644
>> --- a/arch/riscv/Kconfig.errata
>> +++ b/arch/riscv/Kconfig.errata
>> @@ -21,6 +21,29 @@ config ERRATA_ANDES_CMO
>>
>>          If you don't know what to do here, say "Y".
>>
>> +config ERRATA_MIPS
>> +     bool "MIPS errata"
>> +     depends on RISCV_ALTERNATIVE
>> +     help
>> +       All MIPS errata Kconfig depend on this Kconfig. Disabling
>> +       this Kconfig will disable all MIPS errata. Please say "Y"
>> +       here if your platform uses MIPS CPU cores.
>> +
>> +       Otherwise, please say "N" here to avoid unnecessary overhead.
>> +
>> +config ERRATA_MIPS_P8700_PAUSE_OPCODE
>> +     bool "Fix the PAUSE Opcode for MIPS P8700"
>> +     depends on ERRATA_MIPS && 64BIT
>> +     default n
>> +     help
>> +        The RISCV MIPS P8700 uses a different opcode for PAUSE.
>> +        It is a 'hint' encoding of the SLLI instruction,
>> +        with rd=0, rs1=0 and imm=5. It will behave as a NOP
>> +        instruction if no additional behavior beyond that of
>> +        SLLI is implemented.
>> +
>> +        If you are not using the P8700 processor, say n.
>> +
>>   config ERRATA_SIFIVE
>>        bool "SiFive errata"
>>        depends on RISCV_ALTERNATIVE
>> diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
>> index f0da9d7b39c3..156cafb338c1 100644
>> --- a/arch/riscv/errata/Makefile
>> +++ b/arch/riscv/errata/Makefile
>> @@ -9,5 +9,6 @@ endif
>>   endif
>>
>>   obj-$(CONFIG_ERRATA_ANDES) += andes/
>> +obj-$(CONFIG_ERRATA_MIPS) += mips/
>>   obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
>>   obj-$(CONFIG_ERRATA_THEAD) += thead/
>> diff --git a/arch/riscv/errata/mips/Makefile b/arch/riscv/errata/mips/Makefile
>> new file mode 100644
>> index 000000000000..6278c389b801
>> --- /dev/null
>> +++ b/arch/riscv/errata/mips/Makefile
>> @@ -0,0 +1,5 @@
>> +ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
>> +CFLAGS_errata.o := -mcmodel=medany
>> +endif
>> +
>> +obj-y += errata.o
>> diff --git a/arch/riscv/errata/mips/errata.c b/arch/riscv/errata/mips/errata.c
>> new file mode 100644
>> index 000000000000..998bbcaa50d1
>> --- /dev/null
>> +++ b/arch/riscv/errata/mips/errata.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2025 MIPS.
>> + */
>> +
>> +#include <linux/memory.h>
>> +#include <linux/module.h>
>> +#include <asm/text-patching.h>
>> +#include <asm/alternative.h>
>> +#include <asm/errata_list.h>
>> +#include <asm/vendorid_list.h>
>> +#include <asm/vendor_extensions.h>
>> +
>> +void mips_errata_patch_func(struct alt_entry *begin,
>> +                                          struct alt_entry *end,
>> +                                          unsigned long archid,
>> +                                          unsigned long impid,
>> +                                          unsigned int stage)
>> +{
>> +     struct alt_entry *alt;
>> +
>> +     BUILD_BUG_ON(ERRATA_MIPS_NUMBER >= RISCV_VENDOR_EXT_ALTERNATIVES_BASE);
>> +
>> +     if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>> +             return;
>> +
>> +     for (alt = begin; alt < end; alt++) {
>> +             if (alt->vendor_id != MIPS_VENDOR_ID)
>> +                     continue;
>> +
>> +             if (alt->patch_id >= ERRATA_MIPS_NUMBER) {
>> +                     WARN(1, "MIPS errata id:%d not in kernel errata list\n",
>> +                          alt->patch_id);
>> +                     continue;
>> +             }
>> +
>> +             mutex_lock(&text_mutex);
>> +             patch_text_nosync(ALT_OLD_PTR(alt), ALT_ALT_PTR(alt), alt->alt_len);
>> +             mutex_unlock(&text_mutex);
>> +     }
>> +}
>> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
>> index 3c2b59b25017..bc3ada8190a9 100644
>> --- a/arch/riscv/include/asm/alternative.h
>> +++ b/arch/riscv/include/asm/alternative.h
>> @@ -48,6 +48,9 @@ struct alt_entry {
>>   void andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>>                             unsigned long archid, unsigned long impid,
>>                             unsigned int stage);
>> +void mips_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>> +                           unsigned long archid, unsigned long impid,
>> +                           unsigned int stage);
>>   void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>>                              unsigned long archid, unsigned long impid,
>>                              unsigned int stage);
>> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
>> index 4cadc56220fe..2f5705f49dcc 100644
>> --- a/arch/riscv/include/asm/cmpxchg.h
>> +++ b/arch/riscv/include/asm/cmpxchg.h
>> @@ -13,6 +13,7 @@
>>   #include <asm/hwcap.h>
>>   #include <asm/insn-def.h>
>>   #include <asm/cpufeature-macros.h>
>> +#include <asm/errata_list.h>
>>
>>   #define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,             \
>>                           swap_append, r, p, n)                                \
>> @@ -404,7 +405,7 @@ static __always_inline void __cmpwait(volatile void *ptr,
>>        return;
>>
>>   no_zawrs:
>> -     asm volatile(RISCV_PAUSE : : : "memory");
>> +     ALT_RISCV_PAUSE();
>>   }
>>
>>   #define __cmpwait_relaxed(ptr, val) \
>> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
>> index 7c8a71a526a3..68c46ccb9b7c 100644
>> --- a/arch/riscv/include/asm/errata_list.h
>> +++ b/arch/riscv/include/asm/errata_list.h
>> @@ -5,7 +5,6 @@
>>   #ifndef ASM_ERRATA_LIST_H
>>   #define ASM_ERRATA_LIST_H
>>
>> -#include <asm/alternative.h>
>>   #include <asm/csr.h>
>>   #include <asm/insn-def.h>
>>   #include <asm/hwcap.h>
>> @@ -28,6 +27,11 @@
>>   #define      ERRATA_THEAD_NUMBER 2
>>   #endif
>>
>> +#ifdef CONFIG_ERRATA_MIPS
>> +#define ERRATA_MIPS_P8700_PAUSE_OPCODE 0
>> +#define ERRATA_MIPS_NUMBER 1
>> +#endif
>> +
>>   #ifdef __ASSEMBLY__
>>
>>   #define ALT_INSN_FAULT(x)                                            \
>> @@ -58,6 +62,20 @@ asm(ALTERNATIVE("sfence.vma %0, %1", "sfence.vma", SIFIVE_VENDOR_ID,       \
>>                ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)  \
>>                : : "r" (addr), "r" (asid) : "memory")
>>
>> +#ifdef CONFIG_ERRATA_MIPS_P8700_PAUSE_OPCODE
>> +#define ALT_RISCV_PAUSE()                                               \
>> +asm volatile(ALTERNATIVE(                                               \
>> +    RISCV_PAUSE,                /* Original RISC‑V pause insn */        \
>> +    ".4byte 0x00501013",        /* Replacement for MIPS P8700 */        \
>> +    MIPS_VENDOR_ID,             /* Vendor ID to match */                \
>> +    ERRATA_MIPS_P8700_PAUSE_OPCODE, /* patch_id */                      \
>> +    CONFIG_ERRATA_MIPS_P8700_PAUSE_OPCODE)                              \
>> +    : /* no outputs */ : /* no inputs */ : "memory")
>> +#else
>> +#define ALT_RISCV_PAUSE() \
>> +    asm volatile(RISCV_PAUSE : : : "memory")
>> +#endif
>> +
>>   /*
>>    * _val is marked as "will be overwritten", so need to set it to 0
>>    * in the default case.
>> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
>> index 8f383f05a290..8f749552ecfe 100644
>> --- a/arch/riscv/include/asm/vdso/processor.h
>> +++ b/arch/riscv/include/asm/vdso/processor.h
>> @@ -5,6 +5,8 @@
>>   #ifndef __ASSEMBLY__
>>
>>   #include <asm/barrier.h>
>> +
>> +#include <asm/errata_list.h>
>>   #include <asm/insn-def.h>
>>
>>   static inline void cpu_relax(void)
>> @@ -19,7 +21,7 @@ static inline void cpu_relax(void)
>>         * Reduce instruction retirement.
>>         * This assumes the PC changes.
>>         */
>> -     __asm__ __volatile__ (RISCV_PAUSE);
>> +     ALT_RISCV_PAUSE();
>>        barrier();
>>   }
>>
>> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
>> index a5150cdf34d8..3b09874d7a6d 100644
>> --- a/arch/riscv/include/asm/vendorid_list.h
>> +++ b/arch/riscv/include/asm/vendorid_list.h
>> @@ -9,5 +9,6 @@
>>   #define MICROCHIP_VENDOR_ID  0x029
>>   #define SIFIVE_VENDOR_ID     0x489
>>   #define THEAD_VENDOR_ID              0x5b7
>> +#define MIPS_VENDOR_ID               0x722
>>
>>   #endif
>> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
>> index 7eb3cb1215c6..7642704c7f18 100644
>> --- a/arch/riscv/kernel/alternative.c
>> +++ b/arch/riscv/kernel/alternative.c
>> @@ -47,6 +47,11 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info
>>                cpu_mfr_info->patch_func = andes_errata_patch_func;
>>                break;
>>   #endif
>> +#ifdef CONFIG_ERRATA_MIPS
>> +     case MIPS_VENDOR_ID:
>> +             cpu_mfr_info->patch_func = mips_errata_patch_func;
>> +             break;
>> +#endif
>>   #ifdef CONFIG_ERRATA_SIFIVE
>>        case SIFIVE_VENDOR_ID:
>>                cpu_mfr_info->patch_func = sifive_errata_patch_func;
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 33a5a9f2a0d4..2007d9de7f27 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -15,6 +15,8 @@
>>   #include <asm/thread_info.h>
>>   #include <asm/asm-offsets.h>
>>   #include <asm/errata_list.h>
>> +#include <asm/alternative.h>
>> +
>>   #include <linux/sizes.h>
>>
>>        .section .irqentry.text, "ax"
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 722178ae3488..ee8a2c5b40f8 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -35,6 +35,7 @@
>>   #include <asm/soc.h>
>>   #include <asm/sparsemem.h>
>>   #include <asm/tlbflush.h>
>> +#include <asm/alternative.h>
>>
>>   #include "../kernel/head.h"
>>
>> diff --git a/tools/arch/riscv/include/asm/vdso/processor.h b/tools/arch/riscv/include/asm/vdso/processor.h
>> index 662aca039848..880f26a24f69 100644
>> --- a/tools/arch/riscv/include/asm/vdso/processor.h
>> +++ b/tools/arch/riscv/include/asm/vdso/processor.h
>> @@ -14,7 +14,10 @@ static inline void cpu_relax(void)
>>        __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>>   #endif
>>
>> -#ifdef CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
>> +#ifdef CONFIG_ERRATA_MIPS_P8700_PAUSE_OPCODE
>> +    /* MIPS P8700 pause opcode */
>> +    __asm__ __volatile__ (".4byte 0x00501013");
>> +#elif CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
>>        /*
>>         * Reduce instruction retirement.
>>         * This assumes the PC changes.
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

