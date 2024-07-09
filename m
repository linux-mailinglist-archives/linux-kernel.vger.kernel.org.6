Return-Path: <linux-kernel+bounces-245134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A6992AED3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286F7281719
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4D770FB;
	Tue,  9 Jul 2024 03:35:56 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5356F31E;
	Tue,  9 Jul 2024 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720496153; cv=none; b=Wrw2VMYr+ClXPoexoZeVwC6kZHK2cILE+NUV/8qZ0G79WCnnLj1qU1Gk+4RKX957h5mr519YACzwk2iUt9u9O7g1QMpPiRCJh4MToO4jtQAxot+/7tNuFDCH/iJJ6rhTuZ1qbvOrD7Ay5T8r5cXHCM8PEeA41NM261Fvhu1AzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720496153; c=relaxed/simple;
	bh=Z0Zwmfou9R65BCY6ORUwge/sct0XTH6wnE7tBp/wLR4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fC0ThXNwTf/Wi2dxBtGS5GKGwLiuKb/3zM+ClVtpuY1QLY+7NXaD85VMZRk09Lo0HOJ96Tw/3X7JssejmQFbJM4+vLM6NPWQ1anhwknSLl3MJq2OyeSfFHVrrgFuHdpZXkKzekKBrdEh83nB3fz1KLdDxU3s1u3vjTOBbfrbXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8BxXesRsIxmvEICAA--.6734S3;
	Tue, 09 Jul 2024 11:35:45 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjscMsIxmyoBAAA--.16989S3;
	Tue, 09 Jul 2024 11:35:42 +0800 (CST)
Subject: Re: [PATCH V2 2/2] LoongArch: Add AVEC irqchip support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, tglx@linutronix.de, jiaxun.yang@flygoat.com,
 gaoliang@loongson.cn, wangliupu@loongson.cn, lvjianmin@loongson.cn,
 yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
 dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site,
 zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
 zhoubinbin@loongson.cn, loongarch@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240705015315.16541-1-zhangtianyang@loongson.cn>
 <CAAhV-H7-pWhXh7cruA97WfumZydJQnsWkPB2f47qrnw=sTcC6g@mail.gmail.com>
 <732083e2-1cee-094e-4a72-3ac3f2b21f32@loongson.cn>
 <CAAhV-H6heORGsTeBpb4SoN-fmwXM3aNDUyB2jYm0HXW7tXxbGg@mail.gmail.com>
 <f2578dff-921f-9332-2eaf-35654b082471@loongson.cn>
 <CAAhV-H4iF8YpySYt59cb71O=kZj+uiGTR+A+PqL1B1TnYpEJ0w@mail.gmail.com>
 <4b02b946-fbd0-2d54-e96a-f5a947e311fd@loongson.cn>
 <CAAhV-H5faVDmPY6eLz0nGCJ8wA8__MjTtiofqaz9RFW0+77gCg@mail.gmail.com>
 <f798e8d8-4143-9da8-72ed-cfdf4fbc4cfc@loongson.cn>
 <CAAhV-H5GAGA18d3r8Yt55fRSHWGX-G5KedEQVO-S_ahHsgu_uw@mail.gmail.com>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <ad470cd6-f497-b70c-0062-eca046f3af59@loongson.cn>
Date: Tue, 9 Jul 2024 11:35:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5GAGA18d3r8Yt55fRSHWGX-G5KedEQVO-S_ahHsgu_uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8AxjscMsIxmyoBAAA--.16989S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWDCF18CryrKF4rKF1DurWkZrc_yoWrCw1xJo
	W5JF1xJr18Jr1UJr1UJ34qqr1jyw1UJr1UAryUJr4DAr1Utw1UAr1UGr1UJF47GF18Jr1U
	Ja4UJr18ZFW7Xr15l-sFpf9Il3svdjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUOn7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3
	UUUUU==


在 2024/7/9 上午10:42, Huacai Chen 写道:
> On Tue, Jul 9, 2024 at 9:42 AM Tianyang Zhang <zhangtianyang@loongson.cn> wrote:
>>
>> 在 2024/7/8 下午6:20, Huacai Chen 写道:
>>> On Mon, Jul 8, 2024 at 6:05 PM Tianyang Zhang <zhangtianyang@loongson.cn> wrote:
>>>> Hi, Huacai
>>>>
>>>> 在 2024/7/8 下午4:24, Huacai Chen 写道:
>>>>> On Mon, Jul 8, 2024 at 10:17 AM Tianyang Zhang
>>>>> <zhangtianyang@loongson.cn> wrote:
>>>>>> 在 2024/7/6 下午12:50, Huacai Chen 写道:
>>>>>>> On Sat, Jul 6, 2024 at 10:46 AM Tianyang Zhang
>>>>>>> <zhangtianyang@loongson.cn> wrote:
>>>>>>>> 在 2024/7/5 下午2:58, Huacai Chen 写道:
>>>>>>>>> Hi, Tianyang,
>>>>>>>>>
>>>>>>>>> You can squash two patches into one, as Song does:
>>>>>>>>> https://lore.kernel.org/lkml/20240624084410.1026648-1-gaosong@loongson.cn/
>>>>>>>> Ok. I have resend the patch with two-in-one mode
>>>>>>> I ask several questions but you only take this one.
>>>>>>>
>>>>>>> Huacai
>>>>>> Hi ,Huacai
>>>>>>
>>>>>> Sorry for my careless first.
>>>>>>
>>>>>>>>> On Fri, Jul 5, 2024 at 9:53 AM Tianyang Zhang <zhangtianyang@loongson.cn> wrote:
>>>>>>>>>> Introduce the advanced extended interrupt controllers. This feature will
>>>>>>>>>> allow each core to have 256 independent interrupt vectors and MSI
>>>>>>>>>> interrupts can be independently routed to any vector on any CPU.
>>>>>>>>>>
>>>>>>>>>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>>>>>>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>>>>>>>>> Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
>>>>>>>>>> Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
>>>>>>>>>> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
>>>>>>>>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>>>>>>>>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
>>>>>>>>>> ---
>>>>>>>>>>       arch/loongarch/Kconfig                    |   1 +
>>>>>>>>>>       arch/loongarch/include/asm/cpu-features.h |   1 +
>>>>>>>>>>       arch/loongarch/include/asm/cpu.h          |   2 +
>>>>>>>>>>       arch/loongarch/include/asm/hw_irq.h       |  10 +
>>>>>>>>>>       arch/loongarch/include/asm/irq.h          |  12 +-
>>>>>>>>>>       arch/loongarch/include/asm/loongarch.h    |  20 +-
>>>>>>>>>>       arch/loongarch/include/asm/smp.h          |   2 +
>>>>>>>>>>       arch/loongarch/kernel/cpu-probe.c         |   3 +-
>>>>>>>>>>       arch/loongarch/kernel/smp.c               |   5 +
>>>>>>>>>>       drivers/irqchip/Makefile                  |   2 +-
>>>>>>>>>>       drivers/irqchip/irq-loongarch-avec.c      | 440 ++++++++++++++++++++++
>>>>>>>>>>       drivers/irqchip/irq-loongarch-cpu.c       |   4 +-
>>>>>>>>>>       drivers/irqchip/irq-loongson-eiointc.c    |   3 +
>>>>>>>>>>       drivers/irqchip/irq-loongson-pch-msi.c    |  43 ++-
>>>>>>>>>>       14 files changed, 538 insertions(+), 10 deletions(-)
>>>>>>>>>>       create mode 100644 drivers/irqchip/irq-loongarch-avec.c
>>>>>>>>>>
>>>>>>>>>> Changes log:
>>>>>>>>>> V0->V1:
>>>>>>>>>>              1.Modified some formats and declarations
>>>>>>>>>>              2.Removed kmalloc/kfree when adding affinity related data to pending_list,
>>>>>>>>>>                and used moving tag to replace the original behavior
>>>>>>>>>>              3.Adjusted the process that enables AVEC interrupts, now it is at the end of all processes
>>>>>>>>>>              4.Removed CPUHP related callbacks, now irq_matrix_online/irq_matrix_offline is completed in start_secondary/loongson_cpu_disable
>>>>>>>>>>              5.Adjusted compatibility issues for CONFIG_ACPI
>>>>>>>>>>              6.About question:
>>>>>>>>>>              > irr = csr_read64(LOONGARCH_CSR_IRR0 + vector / 64);
>>>>>>>>>>              > should be good enough, no?
>>>>>>>>>>              csr_read64 was built-in as __csrrd_d, it doesn't seem to support variables as parameters
>>>>>>>>>>              >>>>
>>>>>>>>>>              drivers/irqchip/irq-loongarch-avec.c: In function ‘complete_irq_moving’:
>>>>>>>>>>              ./arch/loongarch/include/asm/loongarch.h:164:25: error: invalid argument to built-in function
>>>>>>>>>>                164 | #define csr_read64(reg) __csrrd_d(reg)
>>>>>>>>>>                    |                         ^~~~~~~~~
>>>>>>>>>>              drivers/irqchip/irq-loongarch-avec.c:170:23: note: in expansion of macro ‘csr_read64’
>>>>>>>>>>                170 |                 irr = csr_read64(LOONGARCH_CSR_IRR_BASE + vector / VECTORS_PER_REG);
>>>>>>>>>>                    |                       ^~~~~~~~~~
>>>>>>>>>>              >>>>
>>>>>>>>>>              So we have temporarily retained the previous implementation.
>>>>>>>>>>
>>>>>>>>>> V1->V2:
>>>>>>>>>>              Fixed up coding style. Made on/offline functions void
>>>>>>>>>>              Added compatibility when CONFIG_SMP is turned off
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>>>>>>>>> index e38139c576ee..a66e49b5a68c 100644
>>>>>>>>>> --- a/arch/loongarch/Kconfig
>>>>>>>>>> +++ b/arch/loongarch/Kconfig
>>>>>>>>>> @@ -83,6 +83,7 @@ config LOONGARCH
>>>>>>>>>>              select GENERIC_ENTRY
>>>>>>>>>>              select GENERIC_GETTIMEOFDAY
>>>>>>>>>>              select GENERIC_IOREMAP if !ARCH_IOREMAP
>>>>>>>>>> +       select GENERIC_IRQ_MATRIX_ALLOCATOR
>>>>>>>>>>              select GENERIC_IRQ_MULTI_HANDLER
>>>>>>>>>>              select GENERIC_IRQ_PROBE
>>>>>>>>>>              select GENERIC_IRQ_SHOW
>>>>>>>>>> diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
>>>>>>>>>> index 2eafe6a6aca8..16a716f88a5c 100644
>>>>>>>>>> --- a/arch/loongarch/include/asm/cpu-features.h
>>>>>>>>>> +++ b/arch/loongarch/include/asm/cpu-features.h
>>>>>>>>>> @@ -65,5 +65,6 @@
>>>>>>>>>>       #define cpu_has_guestid                cpu_opt(LOONGARCH_CPU_GUESTID)
>>>>>>>>>>       #define cpu_has_hypervisor     cpu_opt(LOONGARCH_CPU_HYPERVISOR)
>>>>>>>>>>       #define cpu_has_ptw            cpu_opt(LOONGARCH_CPU_PTW)
>>>>>>>>>> +#define cpu_has_avecint                cpu_opt(LOONGARCH_CPU_AVECINT)
>>>>>>>>>>
>>>>>>>>>>       #endif /* __ASM_CPU_FEATURES_H */
>>>>>>>>>> diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
>>>>>>>>>> index 48b9f7168bcc..843f9c4ec980 100644
>>>>>>>>>> --- a/arch/loongarch/include/asm/cpu.h
>>>>>>>>>> +++ b/arch/loongarch/include/asm/cpu.h
>>>>>>>>>> @@ -99,6 +99,7 @@ enum cpu_type_enum {
>>>>>>>>>>       #define CPU_FEATURE_GUESTID            24      /* CPU has GuestID feature */
>>>>>>>>>>       #define CPU_FEATURE_HYPERVISOR         25      /* CPU has hypervisor (running in VM) */
>>>>>>>>>>       #define CPU_FEATURE_PTW                        26      /* CPU has hardware page table walker */
>>>>>>>>>> +#define CPU_FEATURE_AVECINT            27      /* CPU has avec interrupt */
>>>>>>>>>>
>>>>>>>>>>       #define LOONGARCH_CPU_CPUCFG           BIT_ULL(CPU_FEATURE_CPUCFG)
>>>>>>>>>>       #define LOONGARCH_CPU_LAM              BIT_ULL(CPU_FEATURE_LAM)
>>>>>>>>>> @@ -127,5 +128,6 @@ enum cpu_type_enum {
>>>>>>>>>>       #define LOONGARCH_CPU_GUESTID          BIT_ULL(CPU_FEATURE_GUESTID)
>>>>>>>>>>       #define LOONGARCH_CPU_HYPERVISOR       BIT_ULL(CPU_FEATURE_HYPERVISOR)
>>>>>>>>>>       #define LOONGARCH_CPU_PTW              BIT_ULL(CPU_FEATURE_PTW)
>>>>>>>>>> +#define LOONGARCH_CPU_AVECINT          BIT_ULL(CPU_FEATURE_AVECINT)
>>>>>>>>>>
>>>>>>>>>>       #endif /* _ASM_CPU_H */
>>>>>>>>>> diff --git a/arch/loongarch/include/asm/hw_irq.h b/arch/loongarch/include/asm/hw_irq.h
>>>>>>>>>> index af4f4e8fbd85..772692e765c0 100644
>>>>>>>>>> --- a/arch/loongarch/include/asm/hw_irq.h
>>>>>>>>>> +++ b/arch/loongarch/include/asm/hw_irq.h
>>>>>>>>>> @@ -9,6 +9,16 @@
>>>>>>>>>>
>>>>>>>>>>       extern atomic_t irq_err_count;
>>>>>>>>>>
>>>>>>>>>> +/*
>>>>>>>>>> + * 256 vectors Map:
>>>>>>>>>> + *
>>>>>>>>>> + * 0 - 15: mapping legacy IPs, e.g. IP0-12.
>>>>>>>>>> + * 16 - 255: mapping a vector for external IRQ.
>>>>>>>>> In handle_cpu_irq() we handle CPUINTC irqs from low to high, which
>>>>>>>>> means when we handle AVECINTC (IP13), IP0-12 have been handled
>>>>>>>>> already, so should we really mapping IP012 to AVECINTC?
>>>>>> In fact, retaining 0-15 vector is for compatibility with future
>>>>>> extensions, and currently it has not been done in practice.
>>>>>>
>>>>>> The AVEC interrupt controller can completely replace the current core-ip
>>>>>> 0-12 interrupt. When we implement the
>>>>>>
>>>>>> function described above, core-ip 0-12 will no longer have its original
>>>>>> function
>>>>>>
>>>>>> Of course, this is a long-term plan
>>>>>>>>>> + *
>>>>>>>>>> + */
>>>>>>>>>> +#define NR_VECTORS             256
>>>>>>>>>> +#define IRQ_MATRIX_BITS                NR_VECTORS
>>>>>>>>>> +#define NR_LEGACY_VECTORS      16
>>>>>>>>> Should we define them in irq.h and update NR_IRQS there?]
>>>>>> Yes, you are right, this may indeed cause potential problems
>>>>>>>>>>       /*
>>>>>>>>>>        * interrupt-retrigger: NOP for now. This may not be appropriate for all
>>>>>>>>>>        * machines, we'll see ...
>>>>>>>>>> diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
>>>>>>>>>> index 480418bc5071..cf3b635a9b86 100644
>>>>>>>>>> --- a/arch/loongarch/include/asm/irq.h
>>>>>>>>>> +++ b/arch/loongarch/include/asm/irq.h
>>>>>>>>>> @@ -65,7 +65,7 @@ extern struct acpi_vector_group msi_group[MAX_IO_PICS];
>>>>>>>>>>       #define LOONGSON_LPC_LAST_IRQ          (LOONGSON_LPC_IRQ_BASE + 15)
>>>>>>>>>>
>>>>>>>>>>       #define LOONGSON_CPU_IRQ_BASE          16
>>>>>>>>>> -#define LOONGSON_CPU_LAST_IRQ          (LOONGSON_CPU_IRQ_BASE + 14)
>>>>>>>>>> +#define LOONGSON_CPU_LAST_IRQ          (LOONGSON_CPU_IRQ_BASE + 15)
>>>>>>>>>>
>>>>>>>>>>       #define LOONGSON_PCH_IRQ_BASE          64
>>>>>>>>>>       #define LOONGSON_PCH_ACPI_IRQ          (LOONGSON_PCH_IRQ_BASE + 47)
>>>>>>>>>> @@ -101,6 +101,16 @@ int pch_msi_acpi_init(struct irq_domain *parent,
>>>>>>>>>>                                              struct acpi_madt_msi_pic *acpi_pchmsi);
>>>>>>>>>>       int pch_pic_acpi_init(struct irq_domain *parent,
>>>>>>>>>>                                              struct acpi_madt_bio_pic *acpi_pchpic);
>>>>>>>>>> +
>>>>>>>>>> +#ifdef CONFIG_ACPI
>>>>>>>>> No #ifdef needed.
>>>>>> ok , I adjust here next patch
>>>>>>>>>> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
>>>>>>>>>> +               struct acpi_madt_msi_pic *pch_msi_entry);
>>>>>>>>> No line break needed.
>>>>>> ok
>>>>>>>>>> +int __init loongarch_avec_acpi_init(struct irq_domain *parent);
>>>>>>>>>> +void complete_irq_moving(void);
>>>>>>>>>> +void loongarch_avec_offline_cpu(unsigned int cpu);
>>>>>>>>>> +void loongarch_avec_online_cpu(unsigned int cpu);
>>>>>>>>>> +#endif
>>>>>>>>>> +
>>>>>>>>>>       int find_pch_pic(u32 gsi);
>>>>>>>>>>       struct fwnode_handle *get_pch_msi_handle(int pci_segment);
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
>>>>>>>>>> index eb09adda54b7..16a910359977 100644
>>>>>>>>>> --- a/arch/loongarch/include/asm/loongarch.h
>>>>>>>>>> +++ b/arch/loongarch/include/asm/loongarch.h
>>>>>>>>>> @@ -72,7 +72,6 @@
>>>>>>>>>>       #define  CPUCFG1_RPLV                  BIT(23)
>>>>>>>>>>       #define  CPUCFG1_HUGEPG                        BIT(24)
>>>>>>>>>>       #define  CPUCFG1_CRC32                 BIT(25)
>>>>>>>>>> -#define  CPUCFG1_MSGINT                        BIT(26)
>>>>>>>>>>
>>>>>>>>>>       #define LOONGARCH_CPUCFG2              0x2
>>>>>>>>>>       #define  CPUCFG2_FP                    BIT(0)
>>>>>>>>>> @@ -252,8 +251,8 @@
>>>>>>>>>>       #define  CSR_ESTAT_EXC_WIDTH           6
>>>>>>>>>>       #define  CSR_ESTAT_EXC                 (_ULCAST_(0x3f) << CSR_ESTAT_EXC_SHIFT)
>>>>>>>>>>       #define  CSR_ESTAT_IS_SHIFT            0
>>>>>>>>>> -#define  CSR_ESTAT_IS_WIDTH            14
>>>>>>>>>> -#define  CSR_ESTAT_IS                  (_ULCAST_(0x3fff) << CSR_ESTAT_IS_SHIFT)
>>>>>>>>>> +#define  CSR_ESTAT_IS_WIDTH            15
>>>>>>>>>> +#define  CSR_ESTAT_IS                  (_ULCAST_(0x7fff) << CSR_ESTAT_IS_SHIFT)
>>>>>>>>>>
>>>>>>>>>>       #define LOONGARCH_CSR_ERA              0x6     /* ERA */
>>>>>>>>>>
>>>>>>>>>> @@ -999,10 +998,18 @@
>>>>>>>>>>       #define CSR_FWPC_SKIP_SHIFT            16
>>>>>>>>>>       #define CSR_FWPC_SKIP                  (_ULCAST_(1) << CSR_FWPC_SKIP_SHIFT)
>>>>>>>>>>
>>>>>>>>>> +#define LOONGARCH_CSR_IRR0             0xa0
>>>>>>>>>> +#define LOONGARCH_CSR_IRR1             0xa1
>>>>>>>>>> +#define LOONGARCH_CSR_IRR2             0xa2
>>>>>>>>>> +#define LOONGARCH_CSR_IRR3             0xa3
>>>>>>>>>> +#define LOONGARCH_CSR_IRR_BASE         LOONGARCH_CSR_IRR0
>>>>>>>>>> +
>>>>>>>>>> +#define        LOONGARCH_CSR_ILR               0xa4
>>>>>>>>> What is ILR stand for?
>>>>>> Interrupt Load Register, ILR
>>>>> According to the user manual, IRR here should be ISR, and ILR here
>>>>> should be IRR.
>>>> Perhaps my manual version is too old, I will confirm after updating it
>>>>>>>>>> +
>>>>>>>>>>       /*
>>>>>>>>>>        * CSR_ECFG IM
>>>>>>>>>>        */
>>>>>>>>>> -#define ECFG0_IM               0x00001fff
>>>>>>>>>> +#define ECFG0_IM               0x00005fff
>>>>>>>>>>       #define ECFGB_SIP0             0
>>>>>>>>>>       #define ECFGF_SIP0             (_ULCAST_(1) << ECFGB_SIP0)
>>>>>>>>>>       #define ECFGB_SIP1             1
>>>>>>>>>> @@ -1045,6 +1052,7 @@
>>>>>>>>>>       #define  IOCSRF_EIODECODE              BIT_ULL(9)
>>>>>>>>>>       #define  IOCSRF_FLATMODE               BIT_ULL(10)
>>>>>>>>>>       #define  IOCSRF_VM                     BIT_ULL(11)
>>>>>>>>>> +#define  IOCSRF_AVEC                   BIT_ULL(15)
>>>>>>>>>>
>>>>>>>>>>       #define LOONGARCH_IOCSR_VENDOR         0x10
>>>>>>>>>>
>>>>>>>>>> @@ -1055,6 +1063,7 @@
>>>>>>>>>>       #define LOONGARCH_IOCSR_MISC_FUNC      0x420
>>>>>>>>>>       #define  IOCSR_MISC_FUNC_TIMER_RESET   BIT_ULL(21)
>>>>>>>>>>       #define  IOCSR_MISC_FUNC_EXT_IOI_EN    BIT_ULL(48)
>>>>>>>>>> +#define  IOCSR_MISC_FUNC_AVEC_EN       BIT_ULL(51)
>>>>>>>>>>
>>>>>>>>>>       #define LOONGARCH_IOCSR_CPUTEMP                0x428
>>>>>>>>>>
>>>>>>>>>> @@ -1375,9 +1384,10 @@ __BUILD_CSR_OP(tlbidx)
>>>>>>>>>>       #define INT_TI         11      /* Timer */
>>>>>>>>>>       #define INT_IPI                12
>>>>>>>>>>       #define INT_NMI                13
>>>>>>>>>> +#define INT_AVEC       14
>>>>>>>>>>
>>>>>>>>>>       /* ExcCodes corresponding to interrupts */
>>>>>>>>>> -#define EXCCODE_INT_NUM                (INT_NMI + 1)
>>>>>>>>>> +#define EXCCODE_INT_NUM                (INT_AVEC + 1)
>>>>>>>>>>       #define EXCCODE_INT_START      64
>>>>>>>>>>       #define EXCCODE_INT_END                (EXCCODE_INT_START + EXCCODE_INT_NUM - 1)
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
>>>>>>>>>> index 278700cfee88..2399004596a3 100644
>>>>>>>>>> --- a/arch/loongarch/include/asm/smp.h
>>>>>>>>>> +++ b/arch/loongarch/include/asm/smp.h
>>>>>>>>>> @@ -69,9 +69,11 @@ extern int __cpu_logical_map[NR_CPUS];
>>>>>>>>>>       #define ACTION_BOOT_CPU        0
>>>>>>>>>>       #define ACTION_RESCHEDULE      1
>>>>>>>>>>       #define ACTION_CALL_FUNCTION   2
>>>>>>>>>> +#define ACTION_CLEAR_VECT      3
>>>>>>>>>>       #define SMP_BOOT_CPU           BIT(ACTION_BOOT_CPU)
>>>>>>>>>>       #define SMP_RESCHEDULE         BIT(ACTION_RESCHEDULE)
>>>>>>>>>>       #define SMP_CALL_FUNCTION      BIT(ACTION_CALL_FUNCTION)
>>>>>>>>>> +#define SMP_CLEAR_VECT         BIT(ACTION_CLEAR_VECT)
>>>>>>>>>>
>>>>>>>>>>       struct secondary_data {
>>>>>>>>>>              unsigned long stack;
>>>>>>>>>> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
>>>>>>>>>> index 55320813ee08..3b2e72e8f9bd 100644
>>>>>>>>>> --- a/arch/loongarch/kernel/cpu-probe.c
>>>>>>>>>> +++ b/arch/loongarch/kernel/cpu-probe.c
>>>>>>>>>> @@ -106,7 +106,6 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
>>>>>>>>>>                      elf_hwcap |= HWCAP_LOONGARCH_CRC32;
>>>>>>>>>>              }
>>>>>>>>>>
>>>>>>>>>> -
>>>>>>>>>>              config = read_cpucfg(LOONGARCH_CPUCFG2);
>>>>>>>>>>              if (config & CPUCFG2_LAM) {
>>>>>>>>>>                      c->options |= LOONGARCH_CPU_LAM;
>>>>>>>>>> @@ -176,6 +175,8 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
>>>>>>>>>>                      c->options |= LOONGARCH_CPU_EIODECODE;
>>>>>>>>>>              if (config & IOCSRF_VM)
>>>>>>>>>>                      c->options |= LOONGARCH_CPU_HYPERVISOR;
>>>>>>>>>> +       if (config & IOCSRF_AVEC)
>>>>>>>>>> +               c->options |= LOONGARCH_CPU_AVECINT;
>>>>>>>>>>
>>>>>>>>>>              config = csr_read32(LOONGARCH_CSR_ASID);
>>>>>>>>>>              config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
>>>>>>>>>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
>>>>>>>>>> index 0dfe2388ef41..6dfedef306f3 100644
>>>>>>>>>> --- a/arch/loongarch/kernel/smp.c
>>>>>>>>>> +++ b/arch/loongarch/kernel/smp.c
>>>>>>>>>> @@ -234,6 +234,9 @@ static irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
>>>>>>>>>>                      per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
>>>>>>>>>>              }
>>>>>>>>>>
>>>>>>>>>> +       if (action & SMP_CLEAR_VECT)
>>>>>>>>>> +               complete_irq_moving();
>>>>>>>>> SMP_CLEAR_VECT trigger complete_irq_moving(), but in
>>>>>>>>> complete_irq_moving() it calls mp_ops.send_ipi_single(cpu,
>>>>>>>>> ACTION_CLEAR_VECT), which will trigger loongson_ipi_interrupt() again.
>>>>>>>>> I'm a bit confused here. Could you please explain the design goal of
>>>>>>>>> SMP_CLEAR_VECT here?
>>>>>> SMP_CLEAR_VECT is used to release the affinity of interrupts on old CPUs
>>>>>>
>>>>>> Due to the possibility of certain interrupts occurring during interrupt
>>>>>> affinity modification,
>>>>>>
>>>>>> which can result in the original CPU receiving this interrupt vector, it
>>>>>> is necessary to
>>>>>>
>>>>>> determine whether the interrupt has been processed through the original CPU.
>>>>>>
>>>>>> When the original CPU discovers that an interrupt that needs to clear
>>>>>> affinity has not
>>>>>>
>>>>>> been processed locally in the SMP_CLEAR_VECT process, it will suspend
>>>>>> SMP_CLEAR_VECT
>>>>>>
>>>>>> again and end the process, allowing the avec interrupt that has already
>>>>>> been routed
>>>>>>
>>>>>> to the current CPU to be processed.
>>>>>>
>>>>>> Then, it will enter the SMP_CLEAR_VECT process again for judgment
>>>>> When setting affinity from CPU A to CPU B, trigger SMP_CLEAR_VECT on
>>>>> A, A calls complete_irq_moving() to see if the irq is processed. If
>>>>> not, it triggers SMP_CLEAR_VECT again and again, until B has processed
>>>>> this irq.
>>>>> Am I right (correct me if not)?
>>>>>
>>>>> Huacai
>>>> Releasing affinity  of interrupt in the old CPU does not depend on the
>>>> state of the new CPU.
>>>>
>>>> It only determines whether the interrupt has been processed on old CPU.
>>>> This is to avoid
>>>>
>>>> software cleaning data that may cause kernel crashes before interrupts
>>>> generated at
>>>>
>>>> critical times are properly processed
>>>>
>>>> So I think a description should be as follows:
>>>>
>>>> When setting affinity from CPU A to CPU B, trigger SMP_CLEAR_VECT on
>>>> A, A calls complete_irq_moving() to see if the irq has been processed on CPU A.
>>>> If not, CPU A self-retriggers SMP_CLEAR_VECT again and again, until A has processed
>>>> all this irq.
>>> But CPU A is running complete_irq_moving() again and again, how does
>>> it process the pending irq?
>>>
>>> Huacai
>> Hi, Huacai
>>
>> in driver/irqchip/irq-loongarch-cpu.c:
>>
>> static void handle_cpu_irq(struct pt_regs *regs)
>> {
>>           int hwirq;
>>           unsigned int estat = read_csr_estat() & CSR_ESTAT_IS;
>>
>>           while ((hwirq = ffs(estat))) {
>>                   estat &= ~BIT(hwirq - 1);
>>
>> --------------------------------------------------
>>
>> Every time we enter the CPU interrupt, we will save the value of
>> CSR_ESTAT_IS to estat,
>>
>> and then process the interrupt indicated by the corresponding bit one by
>> one.
>>
>>    In our design, avec is routed to core ip-14, so when ipi exits, the
>> avec interrupt will
>>
>> be executed and the corresponding register flag bits will be cleared
> OK, I got it, now you can fix other issues and then submit V4.
>
> Huacai

OK, I will complete it as soon as possible.

Thank you for your feedback and guidance

Tianyang

>
>>
>> Tianyang
>>
>>                   generic_handle_domain_irq(irq_domain, hwirq - 1);
>>           }
>> }
>>
>>>> Tianyang
>>>>
>>>>
>>>>>>>>>> +
>>>>>>>>>>              return IRQ_HANDLED;
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>> @@ -388,6 +391,7 @@ int loongson_cpu_disable(void)
>>>>>>>>>>              irq_migrate_all_off_this_cpu();
>>>>>>>>>>              clear_csr_ecfg(ECFG0_IM);
>>>>>>>>>>              local_irq_restore(flags);
>>>>>>>>>> +       loongarch_avec_offline_cpu(cpu);
>>>>>>>>>>              local_flush_tlb_all();
>>>>>>>>>>
>>>>>>>>>>              return 0;
>>>>>>>>>> @@ -566,6 +570,7 @@ asmlinkage void start_secondary(void)
>>>>>>>>>>               * early is dangerous.
>>>>>>>>>>               */
>>>>>>>>>>              WARN_ON_ONCE(!irqs_disabled());
>>>>>>>>>> +       loongarch_avec_online_cpu(cpu);
>>>>>>>>>>              loongson_smp_finish();
>>>>>>>>>>
>>>>>>>>>>              cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
>>>>>>>>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>>>>>>>>> index 2df72b7b165b..de091a9f7c88 100644
>>>>>>>>>> --- a/drivers/irqchip/Makefile
>>>>>>>>>> +++ b/drivers/irqchip/Makefile
>>>>>>>>>> @@ -110,7 +110,7 @@ obj-$(CONFIG_LS1X_IRQ)                      += irq-ls1x.o
>>>>>>>>>>       obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)      += irq-ti-sci-intr.o
>>>>>>>>>>       obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)      += irq-ti-sci-inta.o
>>>>>>>>>>       obj-$(CONFIG_TI_PRUSS_INTC)            += irq-pruss-intc.o
>>>>>>>>>> -obj-$(CONFIG_IRQ_LOONGARCH_CPU)                += irq-loongarch-cpu.o
>>>>>>>>>> +obj-$(CONFIG_IRQ_LOONGARCH_CPU)                += irq-loongarch-cpu.o irq-loongarch-avec.o
>>>>>>>>>>       obj-$(CONFIG_LOONGSON_LIOINTC)         += irq-loongson-liointc.o
>>>>>>>>>>       obj-$(CONFIG_LOONGSON_EIOINTC)         += irq-loongson-eiointc.o
>>>>>>>>>>       obj-$(CONFIG_LOONGSON_HTPIC)           += irq-loongson-htpic.o
>>>>>>>>>> diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
>>>>>>>>>> new file mode 100644
>>>>>>>>>> index 000000000000..81dbccbea5a2
>>>>>>>>>> --- /dev/null
>>>>>>>>>> +++ b/drivers/irqchip/irq-loongarch-avec.c
>>>>>>>>>> @@ -0,0 +1,440 @@
>>>>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>>>>> +/*
>>>>>>>>>> + * Copyright (C) 2020-2024 Loongson Technologies, Inc.
>>>>>>>>>> + */
>>>>>>>>>> +
>>>>>>>>>> +#include <linux/cpuhotplug.h>
>>>>>>>>>> +#include <linux/init.h>
>>>>>>>>>> +#include <linux/interrupt.h>
>>>>>>>>>> +#include <linux/irq.h>
>>>>>>>>>> +#include <linux/irqchip.h>
>>>>>>>>>> +#include <linux/irqchip/chained_irq.h>
>>>>>>>>>> +#include <linux/irqdomain.h>
>>>>>>>>>> +#include <linux/kernel.h>
>>>>>>>>>> +#include <linux/msi.h>
>>>>>>>>>> +#include <linux/radix-tree.h>
>>>>>>>>>> +#include <linux/spinlock.h>
>>>>>>>>>> +
>>>>>>>>>> +#include <asm/loongarch.h>
>>>>>>>>>> +#include <asm/setup.h>
>>>>>>>>>> +
>>>>>>>>>> +#define VECTORS_PER_REG                64
>>>>>>>>>> +#define ILR_INVALID_MASK       0x80000000UL
>>>>>>>>>> +#define ILR_VECTOR_MASK                0xffUL
>>>>>>>>>> +#define AVEC_MSG_OFFSET                0x100000
>>>>>>>>>> +
>>>>>>>>>> +static phys_addr_t msi_base_v2;
>>>>>>>>>> +static DEFINE_PER_CPU(struct irq_desc * [NR_VECTORS], irq_map);
>>>>>>>>>> +
>>>>>>>>>> +#ifdef CONFIG_SMP
>>>>>>>>>> +struct pending_list {
>>>>>>>>>> +       struct list_head        head;
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static DEFINE_PER_CPU(struct pending_list, pending_list);
>>>>>>>>>> +#endif
>>>>>>>>>> +
>>>>>>>>>> +struct loongarch_avec_chip {
>>>>>>>>>> +       struct fwnode_handle    *fwnode;
>>>>>>>>>> +       struct irq_domain       *domain;
>>>>>>>>>> +       struct irq_matrix       *vector_matrix;
>>>>>>>>>> +       raw_spinlock_t          lock;
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static struct loongarch_avec_chip loongarch_avec;
>>>>>>>>>> +
>>>>>>>>>> +struct loongarch_avec_data {
>>>>>>>>>> +       struct list_head        entry;
>>>>>>>>>> +       unsigned int            cpu;
>>>>>>>>>> +       unsigned int            vec;
>>>>>>>>>> +       unsigned int            prev_cpu;
>>>>>>>>>> +       unsigned int            prev_vec;
>>>>>>>>>> +       unsigned int            moving          : 1,
>>>>>>>>>> +                               managed         : 1;
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static struct cpumask intersect_mask;
>>>>>>>>>> +
>>>>>>>>>> +static int assign_irq_vector(struct irq_data *irqd, const struct cpumask *dest,
>>>>>>>>>> +                            unsigned int *cpu)
>>>>>>>>>> +{
>>>>>>>>>> +       return irq_matrix_alloc(loongarch_avec.vector_matrix, dest, false, cpu);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline void loongarch_avec_ack_irq(struct irq_data *d)
>>>>>>>>>> +{
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline void loongarch_avec_unmask_irq(struct irq_data *d)
>>>>>>>>>> +{
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline void loongarch_avec_mask_irq(struct irq_data *d)
>>>>>>>>>> +{
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +#ifdef CONFIG_SMP
>>>>>>>>>> +static inline void pending_list_init(int cpu)
>>>>>>>>>> +{
>>>>>>>>>> +       struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
>>>>>>>>>> +
>>>>>>>>>> +       INIT_LIST_HEAD(&plist->head);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static void loongarch_avec_sync(struct loongarch_avec_data *adata)
>>>>>>>>>> +{
>>>>>>>>>> +       struct pending_list *plist;
>>>>>>>>>> +
>>>>>>>>>> +       if (cpu_online(adata->prev_cpu)) {
>>>>>>>>>> +               plist = per_cpu_ptr(&pending_list, adata->prev_cpu);
>>>>>>>>>> +               list_add_tail(&adata->entry, &plist->head);
>>>>>>>>>> +               adata->moving = true;
>>>>>>>>>> +               mp_ops.send_ipi_single(adata->prev_cpu, ACTION_CLEAR_VECT);
>>>>>>>>>> +       }
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int loongarch_avec_set_affinity(struct irq_data *data, const struct cpumask *dest,
>>>>>>>>>> +                                      bool force)
>>>>>>>>>> +{
>>>>>>>>>> +       struct loongarch_avec_data *adata;
>>>>>>>>>> +       unsigned int cpu, vector;
>>>>>>>>>> +       unsigned long flags;
>>>>>>>>>> +       int ret;
>>>>>>>>>> +
>>>>>>>>>> +       raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>>>>>>>>>> +       adata = irq_data_get_irq_chip_data(data);
>>>>>>>>>> +
>>>>>>>>>> +       if (adata->vec && cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest)) {
>>>>>>>>>> +               raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>>>>>>>>> +               return 0;
>>>>>>>>>> +       }
>>>>>>>>>> +       if (adata->moving)
>>>>>>>>>> +               return -EBUSY;
>>>>>>>>>> +
>>>>>>>>>> +       cpumask_and(&intersect_mask, dest, cpu_online_mask);
>>>>>>>>>> +
>>>>>>>>>> +       ret = assign_irq_vector(data, &intersect_mask, &cpu);
>>>>>>>>>> +       if (ret < 0) {
>>>>>>>>>> +               raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>>>>>>>>> +               return ret;
>>>>>>>>>> +       }
>>>>>>>>>> +       vector = ret;
>>>>>>>>>> +       adata->cpu = cpu;
>>>>>>>>>> +       adata->vec = vector;
>>>>>>>>>> +       per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(data);
>>>>>>>>>> +       loongarch_avec_sync(adata);
>>>>>>>>>> +
>>>>>>>>>> +       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>>>>>>>>> +       irq_data_update_effective_affinity(data, cpumask_of(cpu));
>>>>>>>>>> +
>>>>>>>>>> +       return IRQ_SET_MASK_OK;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +void complete_irq_moving(void)
>>>>>>>>>> +{
>>>>>>>>>> +       struct pending_list *plist = this_cpu_ptr(&pending_list);
>>>>>>>>>> +       struct loongarch_avec_data *adata, *tmp;
>>>>>>>>>> +       int cpu, vector, bias;
>>>>>>>>>> +       u64 irr;
>>>>>>>>>> +
>>>>>>>>>> +       raw_spin_lock(&loongarch_avec.lock);
>>>>>>>>>> +
>>>>>>>>>> +       list_for_each_entry_safe(adata, tmp, &plist->head, entry) {
>>>>>>>>>> +               cpu = adata->prev_cpu;
>>>>>>>>>> +               vector = adata->prev_vec;
>>>>>>>>>> +               bias = vector / VECTORS_PER_REG;
>>>>>>>>>> +               switch (bias) {
>>>>>>>>>> +               case 0:
>>>>>>>>>> +                       irr = csr_read64(LOONGARCH_CSR_IRR0);
>>>>>>>>>> +               case 1:
>>>>>>>>>> +                       irr = csr_read64(LOONGARCH_CSR_IRR1);
>>>>>>>>>> +               case 2:
>>>>>>>>>> +                       irr = csr_read64(LOONGARCH_CSR_IRR2);
>>>>>>>>>> +               case 3:
>>>>>>>>>> +                       irr = csr_read64(LOONGARCH_CSR_IRR3);
>>>>>>>>>> +               }
>>>>>>>>>> +
>>>>>>>>>> +               if (irr & (1UL << (vector % VECTORS_PER_REG))) {
>>>>>>>>>> +                       mp_ops.send_ipi_single(cpu, ACTION_CLEAR_VECT);
>>>>>>>>>> +                       continue;
>>>>>>>>>> +               }
>>>>>>>>>> +               list_del(&adata->entry);
>>>>>>>>>> +               irq_matrix_free(loongarch_avec.vector_matrix, cpu, vector, adata->managed);
>>>>>>>>>> +               this_cpu_write(irq_map[vector], NULL);
>>>>>>>>>> +               adata->prev_cpu = adata->cpu;
>>>>>>>>>> +               adata->prev_vec = adata->vec;
>>>>>>>>>> +               adata->moving = 0;
>>>>>>>>>> +       }
>>>>>>>>>> +       raw_spin_unlock(&loongarch_avec.lock);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +void loongarch_avec_offline_cpu(unsigned int cpu)
>>>>>>>>>> +{
>>>>>>>>>> +       struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
>>>>>>>>>> +       unsigned long flags;
>>>>>>>>>> +
>>>>>>>>>> +       if (!loongarch_avec.vector_matrix)
>>>>>>>>>> +               return;
>>>>>>>>>> +
>>>>>>>>>> +       raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>>>>>>>>>> +       if (list_empty(&plist->head))
>>>>>>>>>> +               irq_matrix_offline(loongarch_avec.vector_matrix);
>>>>>>>>>> +       else
>>>>>>>>>> +               pr_warn("cpu %d advanced extioi is busy\n", cpu);
>>>>>>>>>> +       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +void loongarch_avec_online_cpu(unsigned int cpu)
>>>>>>>>>> +{
>>>>>>>>>> +       unsigned long flags;
>>>>>>>>>> +
>>>>>>>>>> +       if (!loongarch_avec.vector_matrix)
>>>>>>>>>> +               return;
>>>>>>>>>> +
>>>>>>>>>> +       raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>>>>>>>>>> +
>>>>>>>>>> +       irq_matrix_online(loongarch_avec.vector_matrix);
>>>>>>>>>> +
>>>>>>>>>> +       pending_list_init(cpu);
>>>>>>>>>> +
>>>>>>>>>> +       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +#else
>>>>>>>>>> +#define loongarch_avec_set_affinity            NULL
>>>>>>>>> Empty function is prefered here.
>>>>>> ok ,I got it
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Tianyang
>>>>>>
>>>>>>>>> Huacai
>>>>>>>>>
>>>>>>>>>> +#endif
>>>>>>>>>> +
>>>>>>>>>> +static void loongarch_avec_compose_msg(struct irq_data *d,
>>>>>>>>>> +               struct msi_msg *msg)
>>>>>>>>>> +{
>>>>>>>>>> +       struct loongarch_avec_data *avec_data;
>>>>>>>>>> +
>>>>>>>>>> +       avec_data = irq_data_get_irq_chip_data(d);
>>>>>>>>>> +
>>>>>>>>>> +       msg->address_hi = 0xfd;
>>>>>>>>>> +       msg->address_lo = ((avec_data->vec & 0xff) << 4) |
>>>>>>>>>> +                         ((cpu_logical_map(avec_data->cpu & 0xffff)) << 12);
>>>>>>>>>> +       msg->data = 0x0;
>>>>>>>>>> +
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static struct irq_chip loongarch_avec_controller = {
>>>>>>>>>> +       .name                   = "AVECINTC",
>>>>>>>>>> +       .irq_ack                = loongarch_avec_ack_irq,
>>>>>>>>>> +       .irq_mask               = loongarch_avec_mask_irq,
>>>>>>>>>> +       .irq_unmask             = loongarch_avec_unmask_irq,
>>>>>>>>>> +       .irq_set_affinity       = loongarch_avec_set_affinity,
>>>>>>>>>> +       .irq_compose_msi_msg    = loongarch_avec_compose_msg,
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static void loongarch_avec_dispatch(struct irq_desc *desc)
>>>>>>>>>> +{
>>>>>>>>>> +       struct irq_chip *chip = irq_desc_get_chip(desc);
>>>>>>>>>> +       unsigned long vector;
>>>>>>>>>> +       struct irq_desc *d;
>>>>>>>>>> +
>>>>>>>>>> +       chained_irq_enter(chip, desc);
>>>>>>>>>> +       vector = csr_read64(LOONGARCH_CSR_ILR);
>>>>>>>>>> +       if (vector & ILR_INVALID_MASK)
>>>>>>>>>> +               return;
>>>>>>>>>> +
>>>>>>>>>> +       vector &= ILR_VECTOR_MASK;
>>>>>>>>>> +
>>>>>>>>>> +       d = this_cpu_read(irq_map[vector]);
>>>>>>>>>> +       if (d) {
>>>>>>>>>> +               generic_handle_irq_desc(d);
>>>>>>>>>> +       } else {
>>>>>>>>>> +               pr_warn("IRQ ERROR:Unexpected irq  occur on cpu %d[vector %ld]\n",
>>>>>>>>>> +                       smp_processor_id(), vector);
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       chained_irq_exit(chip, desc);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int loongarch_avec_alloc(struct irq_domain *domain, unsigned int virq,
>>>>>>>>>> +                               unsigned int nr_irqs, void *arg)
>>>>>>>>>> +{
>>>>>>>>>> +       struct loongarch_avec_data *adata;
>>>>>>>>>> +       struct irq_data *irqd;
>>>>>>>>>> +       unsigned int cpu, vector, i, ret;
>>>>>>>>>> +       unsigned long flags;
>>>>>>>>>> +
>>>>>>>>>> +       raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>>>>>>>>>> +       for (i = 0; i < nr_irqs; i++) {
>>>>>>>>>> +               irqd = irq_domain_get_irq_data(domain, virq + i);
>>>>>>>>>> +               adata = kzalloc(sizeof(*adata), GFP_KERNEL);
>>>>>>>>>> +               if (!adata) {
>>>>>>>>>> +                       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>>>>>>>>> +                       return -ENOMEM;
>>>>>>>>>> +               }
>>>>>>>>>> +               ret = assign_irq_vector(irqd, cpu_online_mask, &cpu);
>>>>>>>>>> +               if (ret < 0) {
>>>>>>>>>> +                       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>>>>>>>>> +                       return ret;
>>>>>>>>>> +               }
>>>>>>>>>> +               vector = ret;
>>>>>>>>>> +               adata->prev_cpu = adata->cpu = cpu;
>>>>>>>>>> +               adata->prev_vec = adata->vec = vector;
>>>>>>>>>> +               adata->managed = irqd_affinity_is_managed(irqd);
>>>>>>>>>> +               irq_domain_set_info(domain, virq + i, virq + i, &loongarch_avec_controller,
>>>>>>>>>> +                               adata, handle_edge_irq, NULL, NULL);
>>>>>>>>>> +               adata->moving = 0;
>>>>>>>>>> +               irqd_set_single_target(irqd);
>>>>>>>>>> +               irqd_set_affinity_on_activate(irqd);
>>>>>>>>>> +
>>>>>>>>>> +               per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);
>>>>>>>>>> +       }
>>>>>>>>>> +       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>>>>>>>>> +
>>>>>>>>>> +       return 0;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static void clear_free_vector(struct irq_data *irqd)
>>>>>>>>>> +{
>>>>>>>>>> +       struct loongarch_avec_data *adata = irq_data_get_irq_chip_data(irqd);
>>>>>>>>>> +       bool managed = irqd_affinity_is_managed(irqd);
>>>>>>>>>> +
>>>>>>>>>> +       per_cpu(irq_map, adata->cpu)[adata->vec] = NULL;
>>>>>>>>>> +       irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->vec, managed);
>>>>>>>>>> +       adata->cpu = 0;
>>>>>>>>>> +       adata->vec = 0;
>>>>>>>>>> +#ifdef CONFIG_SMP
>>>>>>>>>> +       if (!adata->moving)
>>>>>>>>>> +               return;
>>>>>>>>>> +
>>>>>>>>>> +       per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] = 0;
>>>>>>>>>> +       irq_matrix_free(loongarch_avec.vector_matrix, adata->prev_cpu,
>>>>>>>>>> +                       adata->prev_vec, adata->managed);
>>>>>>>>>> +       adata->prev_vec = 0;
>>>>>>>>>> +       adata->prev_cpu = 0;
>>>>>>>>>> +       adata->moving = 0;
>>>>>>>>>> +       list_del_init(&adata->entry);
>>>>>>>>>> +#endif
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static void loongarch_avec_free(struct irq_domain *domain, unsigned int virq,
>>>>>>>>>> +               unsigned int nr_irqs)
>>>>>>>>>> +{
>>>>>>>>>> +       struct irq_data *d;
>>>>>>>>>> +       unsigned long flags;
>>>>>>>>>> +       unsigned int i;
>>>>>>>>>> +
>>>>>>>>>> +       raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>>>>>>>>>> +       for (i = 0; i < nr_irqs; i++) {
>>>>>>>>>> +               d = irq_domain_get_irq_data(domain, virq + i);
>>>>>>>>>> +               if (d) {
>>>>>>>>>> +                       clear_free_vector(d);
>>>>>>>>>> +                       irq_domain_reset_irq_data(d);
>>>>>>>>>> +
>>>>>>>>>> +               }
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static const struct irq_domain_ops loongarch_avec_domain_ops = {
>>>>>>>>>> +       .alloc          = loongarch_avec_alloc,
>>>>>>>>>> +       .free           = loongarch_avec_free,
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static int __init irq_matrix_init(void)
>>>>>>>>>> +{
>>>>>>>>>> +       int i;
>>>>>>>>>> +
>>>>>>>>>> +       loongarch_avec.vector_matrix = irq_alloc_matrix(NR_VECTORS, 0, NR_VECTORS - 1);
>>>>>>>>>> +       if (!loongarch_avec.vector_matrix)
>>>>>>>>>> +               return -ENOMEM;
>>>>>>>>>> +       for (i = 0; i < NR_LEGACY_VECTORS; i++)
>>>>>>>>>> +               irq_matrix_assign_system(loongarch_avec.vector_matrix, i, false);
>>>>>>>>>> +
>>>>>>>>>> +       irq_matrix_online(loongarch_avec.vector_matrix);
>>>>>>>>>> +
>>>>>>>>>> +       return 0;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int __init loongarch_avec_init(struct irq_domain *parent)
>>>>>>>>>> +{
>>>>>>>>>> +       int ret = 0, parent_irq;
>>>>>>>>>> +       unsigned long tmp;
>>>>>>>>>> +
>>>>>>>>>> +       raw_spin_lock_init(&loongarch_avec.lock);
>>>>>>>>>> +
>>>>>>>>>> +       loongarch_avec.fwnode = irq_domain_alloc_named_fwnode("CORE_AVEC");
>>>>>>>>>> +       if (!loongarch_avec.fwnode) {
>>>>>>>>>> +               pr_err("Unable to allocate domain handle\n");
>>>>>>>>>> +               ret = -ENOMEM;
>>>>>>>>>> +               goto out;
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       loongarch_avec.domain = irq_domain_create_tree(loongarch_avec.fwnode,
>>>>>>>>>> +                       &loongarch_avec_domain_ops, NULL);
>>>>>>>>>> +       if (!loongarch_avec.domain) {
>>>>>>>>>> +               pr_err("core-vec: cannot create IRQ domain\n");
>>>>>>>>>> +               ret = -ENOMEM;
>>>>>>>>>> +               goto out_free_handle;
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       parent_irq = irq_create_mapping(parent, INT_AVEC);
>>>>>>>>>> +       if (!parent_irq) {
>>>>>>>>>> +               pr_err("Failed to mapping hwirq\n");
>>>>>>>>>> +               ret = -EINVAL;
>>>>>>>>>> +               goto out_remove_domain;
>>>>>>>>>> +       }
>>>>>>>>>> +       irq_set_chained_handler_and_data(parent_irq, loongarch_avec_dispatch, NULL);
>>>>>>>>>> +
>>>>>>>>>> +       ret = irq_matrix_init();
>>>>>>>>>> +       if (ret) {
>>>>>>>>>> +               pr_err("Failed to init irq matrix\n");
>>>>>>>>>> +               goto out_free_matrix;
>>>>>>>>>> +       }
>>>>>>>>>> +#ifdef CONFIG_SMP
>>>>>>>>>> +       pending_list_init(0);
>>>>>>>>>> +#endif
>>>>>>>>>> +       tmp = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
>>>>>>>>>> +       tmp |= IOCSR_MISC_FUNC_AVEC_EN;
>>>>>>>>>> +       iocsr_write64(tmp, LOONGARCH_IOCSR_MISC_FUNC);
>>>>>>>>>> +
>>>>>>>>>> +       return ret;
>>>>>>>>>> +
>>>>>>>>>> +out_free_matrix:
>>>>>>>>>> +       kfree(loongarch_avec.vector_matrix);
>>>>>>>>>> +out_remove_domain:
>>>>>>>>>> +       irq_domain_remove(loongarch_avec.domain);
>>>>>>>>>> +out_free_handle:
>>>>>>>>>> +       irq_domain_free_fwnode(loongarch_avec.fwnode);
>>>>>>>>>> +out:
>>>>>>>>>> +       return ret;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
>>>>>>>>>> +                                    const unsigned long end)
>>>>>>>>>> +{
>>>>>>>>>> +       struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
>>>>>>>>>> +
>>>>>>>>>> +       msi_base_v2 = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
>>>>>>>>>> +       return pch_msi_acpi_init_v2(loongarch_avec.domain, pchmsi_entry);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static inline int __init acpi_cascade_irqdomain_init(void)
>>>>>>>>>> +{
>>>>>>>>>> +       return acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +int __init loongarch_avec_acpi_init(struct irq_domain *parent)
>>>>>>>>>> +{
>>>>>>>>>> +       int ret = 0;
>>>>>>>>>> +
>>>>>>>>>> +       ret = loongarch_avec_init(parent);
>>>>>>>>>> +       if (ret) {
>>>>>>>>>> +               pr_err("Failed to init irq domain\n");
>>>>>>>>>> +               return ret;
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       ret = acpi_cascade_irqdomain_init();
>>>>>>>>>> +       if (ret) {
>>>>>>>>>> +               pr_err("Failed to cascade IRQ domain\n");
>>>>>>>>>> +               return ret;
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       return ret;
>>>>>>>>>> +}
>>>>>>>>>> diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
>>>>>>>>>> index 9d8f2c406043..1ecac59925c6 100644
>>>>>>>>>> --- a/drivers/irqchip/irq-loongarch-cpu.c
>>>>>>>>>> +++ b/drivers/irqchip/irq-loongarch-cpu.c
>>>>>>>>>> @@ -138,7 +138,9 @@ static int __init acpi_cascade_irqdomain_init(void)
>>>>>>>>>>              if (r < 0)
>>>>>>>>>>                      return r;
>>>>>>>>>>
>>>>>>>>>> -       return 0;
>>>>>>>>>> +       if (cpu_has_avecint)
>>>>>>>>>> +               r = loongarch_avec_acpi_init(irq_domain);
>>>>>>>>>> +       return r;
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>>       static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
>>>>>>>>>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
>>>>>>>>>> index c7ddebf312ad..1f9a30488137 100644
>>>>>>>>>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>>>>>>>>>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>>>>>>>>>> @@ -359,6 +359,9 @@ static int __init acpi_cascade_irqdomain_init(void)
>>>>>>>>>>              if (r < 0)
>>>>>>>>>>                      return r;
>>>>>>>>>>
>>>>>>>>>> +       if (cpu_has_avecint)
>>>>>>>>>> +               return 0;
>>>>>>>>>> +
>>>>>>>>>>              r = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
>>>>>>>>>>              if (r < 0)
>>>>>>>>>>                      return r;
>>>>>>>>>> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
>>>>>>>>>> index dd4d699170f4..1926857f9a41 100644
>>>>>>>>>> --- a/drivers/irqchip/irq-loongson-pch-msi.c
>>>>>>>>>> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
>>>>>>>>>> @@ -16,7 +16,6 @@
>>>>>>>>>>       #include <linux/slab.h>
>>>>>>>>>>
>>>>>>>>>>       static int nr_pics;
>>>>>>>>>> -
>>>>>>>>>>       struct pch_msi_data {
>>>>>>>>>>              struct mutex    msi_map_lock;
>>>>>>>>>>              phys_addr_t     doorbell;
>>>>>>>>>> @@ -100,6 +99,17 @@ static struct irq_chip middle_irq_chip = {
>>>>>>>>>>              .irq_compose_msi_msg    = pch_msi_compose_msi_msg,
>>>>>>>>>>       };
>>>>>>>>>>
>>>>>>>>>> +static struct irq_chip pch_msi_irq_chip_v2 = {
>>>>>>>>>> +       .name                   = "MSI",
>>>>>>>>>> +       .irq_ack                = irq_chip_ack_parent,
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static struct msi_domain_info pch_msi_domain_info_v2 = {
>>>>>>>>>> +       .flags          = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>>>>>>>>> +                       MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
>>>>>>>>>> +       .chip   = &pch_msi_irq_chip_v2,
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>>       static int pch_msi_parent_domain_alloc(struct irq_domain *domain,
>>>>>>>>>>                                              unsigned int virq, int hwirq)
>>>>>>>>>>       {
>>>>>>>>>> @@ -268,6 +278,9 @@ struct fwnode_handle *get_pch_msi_handle(int pci_segment)
>>>>>>>>>>       {
>>>>>>>>>>              int i;
>>>>>>>>>>
>>>>>>>>>> +       if (cpu_has_avecint)
>>>>>>>>>> +               return pch_msi_handle[0];
>>>>>>>>>> +
>>>>>>>>>>              for (i = 0; i < MAX_IO_PICS; i++) {
>>>>>>>>>>                      if (msi_group[i].pci_segment == pci_segment)
>>>>>>>>>>                              return pch_msi_handle[i];
>>>>>>>>>> @@ -289,4 +302,32 @@ int __init pch_msi_acpi_init(struct irq_domain *parent,
>>>>>>>>>>
>>>>>>>>>>              return ret;
>>>>>>>>>>       }
>>>>>>>>>> +
>>>>>>>>>> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
>>>>>>>>>> +               struct acpi_madt_msi_pic *msi_entry)
>>>>>>>>>> +{
>>>>>>>>>> +       struct irq_domain *msi_domain;
>>>>>>>>>> +
>>>>>>>>>> +       if (pch_msi_handle[0])
>>>>>>>>>> +               return 0;
>>>>>>>>>> +
>>>>>>>>>> +       pch_msi_handle[0] = irq_domain_alloc_named_fwnode("msipic-v2");
>>>>>>>>>> +       if (!pch_msi_handle[0]) {
>>>>>>>>>> +               pr_err("Unable to allocate domain handle\n");
>>>>>>>>>> +               kfree(pch_msi_handle[0]);
>>>>>>>>>> +               return -ENOMEM;
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       msi_domain = pci_msi_create_irq_domain(pch_msi_handle[0],
>>>>>>>>>> +                       &pch_msi_domain_info_v2,
>>>>>>>>>> +                       parent);
>>>>>>>>>> +       if (!msi_domain) {
>>>>>>>>>> +               pr_err("Failed to create PCI MSI domain\n");
>>>>>>>>>> +               kfree(pch_msi_handle[0]);
>>>>>>>>>> +               return -ENOMEM;
>>>>>>>>>> +       }
>>>>>>>>>> +
>>>>>>>>>> +       pr_info("IRQ domain MSIPIC-V2 init done.\n");
>>>>>>>>>> +       return 0;
>>>>>>>>>> +}
>>>>>>>>>>       #endif
>>>>>>>>>> --
>>>>>>>>>> 2.20.1
>>>>>>>>>>
>>>>>>>>>>


