Return-Path: <linux-kernel+bounces-246973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5569E92C97E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A725E1F23FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82B3D96D;
	Wed, 10 Jul 2024 04:06:27 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E815D1;
	Wed, 10 Jul 2024 04:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584385; cv=none; b=QhICsMvN+0PK3pqgVjvONOBr80JKsROGZxtXQ5y++fvo9wyu26v1XRIXl/YbY80noVnU4zA/0F379lpRDxGPs1jswiC+GcraUYvAqNCk+ArdnO//NjrkTdzsm4HUXGIbDN+jopa+/dolCqD76h1+4nbi6FT9/88AheOiA3Xtrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584385; c=relaxed/simple;
	bh=X0tE772u0WjSeFNZl43b/8U1wSOGizXdU8ivz6boD5w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iwpXQSYoxjZzLPHmQOwY+Qsi+Yj1LJrC/Nikqtvo8Z3Q3ebls2SEdAi8h9QBted+TZ6WW66IVgIPxCazc26Pn8AvfGhYXrhz903aKSSHm2F5MMRfVqYICq+NIhramMOhTLUWcYOYlU1gHeLfaXWvg7tA/54Z+rYMykFYX1T8q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxDvG7CI5m2rUCAA--.8297S3;
	Wed, 10 Jul 2024 12:06:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxhsW3CI5mSv5BAA--.9999S3;
	Wed, 10 Jul 2024 12:06:17 +0800 (CST)
Subject: Re: [PATCH V4] LoongArch: Add AVEC irqchip support
To: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net,
 alexs@kernel.org, siyanteng@loongson.cn, chenhuacai@kernel.org,
 kernel@xen0n.name, tglx@linutronix.de, jiaxun.yang@flygoat.com,
 gaoliang@loongson.cn, wangliupu@loongson.cn, lvjianmin@loongson.cn,
 yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
 dianders@chromium.org, xry111@xry111.site, zhaotianrui@loongson.cn,
 nathan@kernel.org, yangtiezhu@loongson.cn, zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240710031414.6069-1-zhangtianyang@loongson.cn>
 <9c6ec105-ea1c-3fe7-dea8-49b66a0867e3@loongson.cn>
 <2b4fb2ec-ace4-1514-d8b5-66edaa6164af@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <62809a92-3eb6-3360-208d-717dda4227f9@loongson.cn>
Date: Wed, 10 Jul 2024 12:06:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2b4fb2ec-ace4-1514-d8b5-66edaa6164af@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxhsW3CI5mSv5BAA--.9999S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoWDXFW7JFy5Kw1rJFWDZrW3CFX_yoWrur4fAo
	WYgF1fAr1rJr1jgryUJr4Utry3JF1UJr1DA347Gry7Gr18AF1UA3yUGryUKay7Jr18Gr1U
	Ja4UXry0vFy2qr15l-sFpf9Il3svdjkaLaAFLSUrUUUU5b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUOn7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3
	UUUUU==



On 2024/7/10 上午11:48, Tianyang Zhang wrote:
> 在 2024/7/10 上午11:37, maobibo 写道:
>> Tianyang,
>>
>> On 2024/7/10 上午11:14, Tianyang Zhang wrote:
>>> Introduce the advanced extended interrupt controllers. This feature will
>>> allow each core to have 256 independent interrupt vectors and MSI
>>> interrupts can be independently routed to any vector on any CPU.
>>>
>>> Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
>>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
>>> Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
>>> Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
>>> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
>>> ---
>>>   .../arch/loongarch/irq-chip-model.rst         |  33 ++
>>>   .../zh_CN/arch/loongarch/irq-chip-model.rst   |  37 +-
>>>   arch/loongarch/Kconfig                        |   1 +
>>>   arch/loongarch/include/asm/cpu-features.h     |   1 +
>>>   arch/loongarch/include/asm/cpu.h              |   2 +
>>>   arch/loongarch/include/asm/irq.h              |  23 +-
>>>   arch/loongarch/include/asm/loongarch.h        |  19 +-
>>>   arch/loongarch/include/asm/smp.h              |   2 +
>>>   arch/loongarch/kernel/cpu-probe.c             |   3 +-
>>>   arch/loongarch/kernel/smp.c                   |   5 +
>>>   drivers/irqchip/Makefile                      |   2 +-
>>>   drivers/irqchip/irq-loongarch-avec.c          | 433 ++++++++++++++++++
>>>   drivers/irqchip/irq-loongarch-cpu.c           |   4 +-
>>>   drivers/irqchip/irq-loongson-eiointc.c        |   3 +
>>>   drivers/irqchip/irq-loongson-pch-msi.c        |  42 +-
>>>   15 files changed, 596 insertions(+), 14 deletions(-)
>>>   create mode 100644 drivers/irqchip/irq-loongarch-avec.c
>>>
>>> Changes log:
>>> V0->V1:
>>>          1.Modified some formats and declarations
>>>          2.Removed kmalloc/kfree when adding affinity related data to 
>>> pending_list,
>>>            and used moving tag to replace the original behavior
>>>          3.Adjusted the process that enables AVEC interrupts, now it 
>>> is at the end of all processes
>>>          4.Removed CPUHP related callbacks, now 
>>> irq_matrix_online/irq_matrix_offline is completed in 
>>> start_secondary/loongson_cpu_disable
>>>          5.Adjusted compatibility issues for CONFIG_ACPI
>>>          6.About question:
>>>          > irr = csr_read64(LOONGARCH_CSR_IRR0 + vector / 64);
>>>          > should be good enough, no?
>>>          csr_read64 was built-in as __csrrd_d, it doesn't seem to 
>>> support variables as parameters
>>>          >>>>
>>>          drivers/irqchip/irq-loongarch-avec.c: In function 
>>> ‘complete_irq_moving’:
>>>          ./arch/loongarch/include/asm/loongarch.h:164:25: error: 
>>> invalid argument to built-in function
>>>            164 | #define csr_read64(reg) __csrrd_d(reg)
>>>                |                         ^~~~~~~~~
>>>          drivers/irqchip/irq-loongarch-avec.c:170:23: note: in 
>>> expansion of macro ‘csr_read64’
>>>            170 |                 irr = 
>>> csr_read64(LOONGARCH_CSR_IRR_BASE + vector / VECTORS_PER_REG);
>>>                |                       ^~~~~~~~~~
>>>          >>>>
>>>          So we have temporarily retained the previous implementation.
>>>
>>> V1->V2:
>>>          Fixed up coding style. Made on/offline functions void
>>>          Added compatibility when CONFIG_SMP is turned off
>>>
>>> V2->V3:
>>>     Squash two patches into one
>>>
>>> V3->V4:
>>>     Update NR_IRQS
>>>     Update Register's name
>>>     Fixed up coding style
>>>
>>> diff --git a/Documentation/arch/loongarch/irq-chip-model.rst 
>>> b/Documentation/arch/loongarch/irq-chip-model.rst
>>> index 7988f4192363..a90c78c8e5bb 100644
>>> --- a/Documentation/arch/loongarch/irq-chip-model.rst
>>> +++ b/Documentation/arch/loongarch/irq-chip-model.rst
>>> @@ -85,6 +85,39 @@ to CPUINTC directly::
>>>       | Devices |
>>>       +---------+
>>>   +Advanced Extended IRQ model
>>> +===========================
>>> +
>>> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer 
>>> interrupt go
>>> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, PCH-MSI 
>>> interrupts go to AVEC,
>>> +and then go to CPUINTC, Other devices interrupts go to 
>>> PCH-PIC/PCH-LPC and gathered
>>> +by EIOINTC, and then go to CPUINTC directly::
>>> +
>>> + +-----+     +--------------------------+     +-------+
>>> + | IPI | --> |           CPUINTC        | <-- | Timer |
>>> + +-----+     +--------------------------+     +-------+
>>> +              ^        ^             ^
>>> +              |        |             |
>>> +      +--------+  +---------+ +---------+     +-------+
>>> +      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
>>> +      +--------+  +---------+ +---------+     +-------+
>>> +           ^            ^
>>> +           |            |
>>> +         +---------+  +---------+
>>> +         | PCH-MSI |  | PCH-PIC |
>>> +         +---------+  +---------+
>>> +            ^          ^       ^
>>> +            |          |       |
>>> +    +---------+ +---------+ +---------+
>>> +    | Devices | | PCH-LPC | | Devices |
>>> +    +---------+ +---------+ +---------+
>>> +                     ^
>>> +                     |
>>> +                +---------+
>>> +                | Devices |
>>> +                +---------+
>>> +
>>> +
>>>   ACPI-related definitions
>>>   ========================
>>>   diff --git 
>>> a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst 
>>> b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
>>> index f1e9ab18206c..b54567380c90 100644
>>> --- a/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
>>> +++ b/Documentation/translations/zh_CN/arch/loongarch/irq-chip-model.rst
>>> @@ -9,9 +9,8 @@
>>>   LoongArch的IRQ芯片模型（层级关系）
>>>   ==================================
>>> -目前，基于LoongArch的处理器（如龙芯3A5000）只能与LS7A芯片组配合工 
>>> 作。LoongArch计算机
>>> -中的中断控制器（即IRQ芯片）包括CPUINTC（CPU Core Interrupt 
>>> Controller）、LIOINTC（
>>> -Legacy I/O Interrupt Controller）、EIOINTC（Extended I/O Interrupt 
>>> Controller）、
>>> +LoongArch计算机中的中断控制器（即IRQ芯片）包括CPUINTC（CPU Core 
>>> Interrupt Controller）、
>>> +LIOINTC（Legacy I/O Interrupt Controller）、EIOINTC（Extended I/O 
>>> Interrupt Controller）、
>>>   HTVECINTC（Hyper-Transport Vector Interrupt Controller）、PCH- 
>>> PIC（LS7A芯片组的主中
>>> 断控制器）、PCH-LPC（LS7A芯片组的LPC中断控制器）和PCH-MSI（MSI中断控 
>>> 制器）。
>>>   @@ -87,6 +86,38 @@ PCH-LPC/PCH-MSI，然后被EIOINTC统一收集，再直接到 
>>> 达CPUINTC::
>>>       | Devices |
>>>       +---------+
>>>   +高级扩展IRQ模型
>>> +=======================
>>> +
>>> +在这种模型里面，IPI（Inter-Processor Interrupt）和CPU本地时钟中断直 
>>> 接发送到CPUINTC，
>>> +CPU串口（UARTs）中断发送到LIOINTC，PCH-MSI中断发送到AVEC，而后通过 
>>> AVEC送达CPUINTC，而
>>> +其他所有设备的中断则分别发送到所连接的PCH-PIC/PCH-LPC，然后由EIOINTC 
>>> 统一收集，再直
>>> +接到达CPUINTC::
>>> +
>>> + +-----+     +--------------------------+     +-------+
>>> + | IPI | --> |           CPUINTC        | <-- | Timer |
>>> + +-----+     +--------------------------+     +-------+
>>> +              ^        ^             ^
>>> +              |        |             |
>>> +      +--------+  +---------+ +---------+     +-------+
>>> +      | AVEC   |  | EIOINTC | | LIOINTC | <-- | UARTs |
>>> +      +--------+  +---------+ +---------+     +-------+
>>> +              ^        ^
>>> +              |        |
>>> +      +---------+  +-------------+
>>> +      | PCH-MSI |  |   PCH-PIC   |
>>> +      +---------+  +-------------+
>>> +            ^          ^       ^
>>> +            |          |       |
>>> +    +---------+ +---------+ +---------+
>>> +    | Devices | | PCH-LPC | | Devices |
>>> +    +---------+ +---------+ +---------+
>>> +                     ^
>>> +                     |
>>> +                +---------+
>>> +                | Devices |
>>> +                +---------+
>>> +
>>>   ACPI相关的定义
>>>   ==============
>>>   diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>> index e38139c576ee..a66e49b5a68c 100644
>>> --- a/arch/loongarch/Kconfig
>>> +++ b/arch/loongarch/Kconfig
>>> @@ -83,6 +83,7 @@ config LOONGARCH
>>>       select GENERIC_ENTRY
>>>       select GENERIC_GETTIMEOFDAY
>>>       select GENERIC_IOREMAP if !ARCH_IOREMAP
>>> +    select GENERIC_IRQ_MATRIX_ALLOCATOR
>>>       select GENERIC_IRQ_MULTI_HANDLER
>>>       select GENERIC_IRQ_PROBE
>>>       select GENERIC_IRQ_SHOW
>>> diff --git a/arch/loongarch/include/asm/cpu-features.h 
>>> b/arch/loongarch/include/asm/cpu-features.h
>>> index 2eafe6a6aca8..16a716f88a5c 100644
>>> --- a/arch/loongarch/include/asm/cpu-features.h
>>> +++ b/arch/loongarch/include/asm/cpu-features.h
>>> @@ -65,5 +65,6 @@
>>>   #define cpu_has_guestid        cpu_opt(LOONGARCH_CPU_GUESTID)
>>>   #define cpu_has_hypervisor cpu_opt(LOONGARCH_CPU_HYPERVISOR)
>>>   #define cpu_has_ptw        cpu_opt(LOONGARCH_CPU_PTW)
>>> +#define cpu_has_avecint        cpu_opt(LOONGARCH_CPU_AVECINT)
>>>     #endif /* __ASM_CPU_FEATURES_H */
>>> diff --git a/arch/loongarch/include/asm/cpu.h 
>>> b/arch/loongarch/include/asm/cpu.h
>>> index 48b9f7168bcc..843f9c4ec980 100644
>>> --- a/arch/loongarch/include/asm/cpu.h
>>> +++ b/arch/loongarch/include/asm/cpu.h
>>> @@ -99,6 +99,7 @@ enum cpu_type_enum {
>>>   #define CPU_FEATURE_GUESTID        24    /* CPU has GuestID feature */
>>>   #define CPU_FEATURE_HYPERVISOR        25    /* CPU has hypervisor 
>>> (running in VM) */
>>>   #define CPU_FEATURE_PTW            26    /* CPU has hardware page 
>>> table walker */
>>> +#define CPU_FEATURE_AVECINT        27    /* CPU has avec interrupt */
>>>     #define LOONGARCH_CPU_CPUCFG BIT_ULL(CPU_FEATURE_CPUCFG)
>>>   #define LOONGARCH_CPU_LAM        BIT_ULL(CPU_FEATURE_LAM)
>>> @@ -127,5 +128,6 @@ enum cpu_type_enum {
>>>   #define LOONGARCH_CPU_GUESTID BIT_ULL(CPU_FEATURE_GUESTID)
>>>   #define LOONGARCH_CPU_HYPERVISOR BIT_ULL(CPU_FEATURE_HYPERVISOR)
>>>   #define LOONGARCH_CPU_PTW        BIT_ULL(CPU_FEATURE_PTW)
>>> +#define LOONGARCH_CPU_AVECINT BIT_ULL(CPU_FEATURE_AVECINT)
>>>     #endif /* _ASM_CPU_H */
>>> diff --git a/arch/loongarch/include/asm/irq.h 
>>> b/arch/loongarch/include/asm/irq.h
>>> index 480418bc5071..899e6f9a9eaa 100644
>>> --- a/arch/loongarch/include/asm/irq.h
>>> +++ b/arch/loongarch/include/asm/irq.h
>>> @@ -39,11 +39,22 @@ void spurious_interrupt(void);
>>>     #define NR_IRQS_LEGACY 16
>>>   +/*
>>> + * 256 vectors Map:
>>> + *
>>> + * 0 - 15: mapping legacy IPs, e.g. IP0-12.
>>> + * 16 - 255: mapping a vector for external IRQ.
>>> + *
>>> + */
>>> +#define NR_VECTORS        256
>>> +#define IRQ_MATRIX_BITS        NR_VECTORS
>>> +#define NR_LEGACY_VECTORS    16
>>> +
>>>   #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
>>>   void arch_trigger_cpumask_backtrace(const struct cpumask *mask, int 
>>> exclude_cpu);
>>>     #define MAX_IO_PICS 2
>>> -#define NR_IRQS    (64 + (256 * MAX_IO_PICS))
>>> +#define NR_IRQS    ((64 + (64 * MAX_IO_PICS)) + NR_VECTORS * NR_CPUS)
>>>     struct acpi_vector_group {
>>>       int node;
>>> @@ -65,7 +76,7 @@ extern struct acpi_vector_group 
>>> msi_group[MAX_IO_PICS];
>>>   #define LOONGSON_LPC_LAST_IRQ        (LOONGSON_LPC_IRQ_BASE + 15)
>>>     #define LOONGSON_CPU_IRQ_BASE        16
>>> -#define LOONGSON_CPU_LAST_IRQ        (LOONGSON_CPU_IRQ_BASE + 14)
>>> +#define LOONGSON_CPU_LAST_IRQ        (LOONGSON_CPU_IRQ_BASE + 15)
>>>     #define LOONGSON_PCH_IRQ_BASE        64
>>>   #define LOONGSON_PCH_ACPI_IRQ        (LOONGSON_PCH_IRQ_BASE + 47)
>>> @@ -101,6 +112,14 @@ int pch_msi_acpi_init(struct irq_domain *parent,
>>>                       struct acpi_madt_msi_pic *acpi_pchmsi);
>>>   int pch_pic_acpi_init(struct irq_domain *parent,
>>>                       struct acpi_madt_bio_pic *acpi_pchpic);
>>> +
>>> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
>>> +        struct acpi_madt_msi_pic *pch_msi_entry);
>>> +int __init loongarch_avec_acpi_init(struct irq_domain *parent);
>>> +void complete_irq_moving(void);
>>> +void loongarch_avec_offline_cpu(unsigned int cpu);
>>> +void loongarch_avec_online_cpu(unsigned int cpu);
>>> +
>>>   int find_pch_pic(u32 gsi);
>>>   struct fwnode_handle *get_pch_msi_handle(int pci_segment);
>>>   diff --git a/arch/loongarch/include/asm/loongarch.h 
>>> b/arch/loongarch/include/asm/loongarch.h
>>> index eb09adda54b7..805f51eaac06 100644
>>> --- a/arch/loongarch/include/asm/loongarch.h
>>> +++ b/arch/loongarch/include/asm/loongarch.h
>>> @@ -72,7 +72,6 @@
>>>   #define  CPUCFG1_RPLV            BIT(23)
>>>   #define  CPUCFG1_HUGEPG            BIT(24)
>>>   #define  CPUCFG1_CRC32            BIT(25)
>>> -#define  CPUCFG1_MSGINT            BIT(26)
>>>     #define LOONGARCH_CPUCFG2        0x2
>>>   #define  CPUCFG2_FP            BIT(0)
>>> @@ -252,8 +251,8 @@
>>>   #define  CSR_ESTAT_EXC_WIDTH        6
>>>   #define  CSR_ESTAT_EXC            (_ULCAST_(0x3f) << 
>>> CSR_ESTAT_EXC_SHIFT)
>>>   #define  CSR_ESTAT_IS_SHIFT        0
>>> -#define  CSR_ESTAT_IS_WIDTH        14
>>> -#define  CSR_ESTAT_IS            (_ULCAST_(0x3fff) << 
>>> CSR_ESTAT_IS_SHIFT)
>>> +#define  CSR_ESTAT_IS_WIDTH        15
>>> +#define  CSR_ESTAT_IS            (_ULCAST_(0x7fff) << 
>>> CSR_ESTAT_IS_SHIFT)
>>>     #define LOONGARCH_CSR_ERA        0x6    /* ERA */
>>>   @@ -999,10 +998,17 @@
>>>   #define CSR_FWPC_SKIP_SHIFT        16
>>>   #define CSR_FWPC_SKIP            (_ULCAST_(1) << CSR_FWPC_SKIP_SHIFT)
>>>   +#define LOONGARCH_CSR_ISR0        0xa0
>>> +#define LOONGARCH_CSR_ISR1        0xa1
>>> +#define LOONGARCH_CSR_ISR2        0xa2
>>> +#define LOONGARCH_CSR_ISR3        0xa3
>>> +
>>> +#define    LOONGARCH_CSR_IRR        0xa4
>>> +
>>>   /*
>>>    * CSR_ECFG IM
>>>    */
>>> -#define ECFG0_IM        0x00001fff
>>> +#define ECFG0_IM        0x00005fff
>>>   #define ECFGB_SIP0        0
>>>   #define ECFGF_SIP0        (_ULCAST_(1) << ECFGB_SIP0)
>>>   #define ECFGB_SIP1        1
>>> @@ -1045,6 +1051,7 @@
>>>   #define  IOCSRF_EIODECODE        BIT_ULL(9)
>>>   #define  IOCSRF_FLATMODE        BIT_ULL(10)
>>>   #define  IOCSRF_VM            BIT_ULL(11)
>>> +#define  IOCSRF_AVEC            BIT_ULL(15)
>>>     #define LOONGARCH_IOCSR_VENDOR        0x10
>>>   @@ -1055,6 +1062,7 @@
>>>   #define LOONGARCH_IOCSR_MISC_FUNC    0x420
>>>   #define  IOCSR_MISC_FUNC_TIMER_RESET    BIT_ULL(21)
>>>   #define  IOCSR_MISC_FUNC_EXT_IOI_EN    BIT_ULL(48)
>>> +#define  IOCSR_MISC_FUNC_AVEC_EN    BIT_ULL(51)
>>>     #define LOONGARCH_IOCSR_CPUTEMP        0x428
>>>   @@ -1375,9 +1383,10 @@ __BUILD_CSR_OP(tlbidx)
>>>   #define INT_TI        11    /* Timer */
>>>   #define INT_IPI        12
>>>   #define INT_NMI        13
>>> +#define INT_AVEC    14
>>>     /* ExcCodes corresponding to interrupts */
>>> -#define EXCCODE_INT_NUM        (INT_NMI + 1)
>>> +#define EXCCODE_INT_NUM        (INT_AVEC + 1)
>>>   #define EXCCODE_INT_START    64
>>>   #define EXCCODE_INT_END        (EXCCODE_INT_START + EXCCODE_INT_NUM 
>>> - 1)
>>>   diff --git a/arch/loongarch/include/asm/smp.h 
>>> b/arch/loongarch/include/asm/smp.h
>>> index 278700cfee88..2399004596a3 100644
>>> --- a/arch/loongarch/include/asm/smp.h
>>> +++ b/arch/loongarch/include/asm/smp.h
>>> @@ -69,9 +69,11 @@ extern int __cpu_logical_map[NR_CPUS];
>>>   #define ACTION_BOOT_CPU    0
>>>   #define ACTION_RESCHEDULE    1
>>>   #define ACTION_CALL_FUNCTION    2
>>> +#define ACTION_CLEAR_VECT    3
>>>   #define SMP_BOOT_CPU        BIT(ACTION_BOOT_CPU)
>>>   #define SMP_RESCHEDULE        BIT(ACTION_RESCHEDULE)
>>>   #define SMP_CALL_FUNCTION    BIT(ACTION_CALL_FUNCTION)
>>> +#define SMP_CLEAR_VECT        BIT(ACTION_CLEAR_VECT)
>>>     struct secondary_data {
>>>       unsigned long stack;
>>> diff --git a/arch/loongarch/kernel/cpu-probe.c 
>>> b/arch/loongarch/kernel/cpu-probe.c
>>> index 55320813ee08..3b2e72e8f9bd 100644
>>> --- a/arch/loongarch/kernel/cpu-probe.c
>>> +++ b/arch/loongarch/kernel/cpu-probe.c
>>> @@ -106,7 +106,6 @@ static void cpu_probe_common(struct 
>>> cpuinfo_loongarch *c)
>>>           elf_hwcap |= HWCAP_LOONGARCH_CRC32;
>>>       }
>>>   -
>>>       config = read_cpucfg(LOONGARCH_CPUCFG2);
>>>       if (config & CPUCFG2_LAM) {
>>>           c->options |= LOONGARCH_CPU_LAM;
>>> @@ -176,6 +175,8 @@ static void cpu_probe_common(struct 
>>> cpuinfo_loongarch *c)
>>>           c->options |= LOONGARCH_CPU_EIODECODE;
>>>       if (config & IOCSRF_VM)
>>>           c->options |= LOONGARCH_CPU_HYPERVISOR;
>>> +    if (config & IOCSRF_AVEC)
>>> +        c->options |= LOONGARCH_CPU_AVECINT;
>>>         config = csr_read32(LOONGARCH_CSR_ASID);
>>>       config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
>>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
>>> index 0dfe2388ef41..6dfedef306f3 100644
>>> --- a/arch/loongarch/kernel/smp.c
>>> +++ b/arch/loongarch/kernel/smp.c
>>> @@ -234,6 +234,9 @@ static irqreturn_t loongson_ipi_interrupt(int 
>>> irq, void *dev)
>>>           per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
>>>       }
>>>   +    if (action & SMP_CLEAR_VECT)
>>> +        complete_irq_moving();
>>> +
>>>       return IRQ_HANDLED;
>>>   }
>>>   @@ -388,6 +391,7 @@ int loongson_cpu_disable(void)
>>>       irq_migrate_all_off_this_cpu();
>>>       clear_csr_ecfg(ECFG0_IM);
>>>       local_irq_restore(flags);
>>> +    loongarch_avec_offline_cpu(cpu);
>>>       local_flush_tlb_all();
>>>         return 0;
>>> @@ -566,6 +570,7 @@ asmlinkage void start_secondary(void)
>>>        * early is dangerous.
>>>        */
>>>       WARN_ON_ONCE(!irqs_disabled());
>>> +    loongarch_avec_online_cpu(cpu);
>>>       loongson_smp_finish();
>>>         cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>> index 2df72b7b165b..de091a9f7c88 100644
>>> --- a/drivers/irqchip/Makefile
>>> +++ b/drivers/irqchip/Makefile
>>> @@ -110,7 +110,7 @@ obj-$(CONFIG_LS1X_IRQ)            += irq-ls1x.o
>>>   obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)    += irq-ti-sci-intr.o
>>>   obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)    += irq-ti-sci-inta.o
>>>   obj-$(CONFIG_TI_PRUSS_INTC)        += irq-pruss-intc.o
>>> -obj-$(CONFIG_IRQ_LOONGARCH_CPU)        += irq-loongarch-cpu.o
>>> +obj-$(CONFIG_IRQ_LOONGARCH_CPU)        += irq-loongarch-cpu.o 
>>> irq-loongarch-avec.o
>>>   obj-$(CONFIG_LOONGSON_LIOINTC)        += irq-loongson-liointc.o
>>>   obj-$(CONFIG_LOONGSON_EIOINTC)        += irq-loongson-eiointc.o
>>>   obj-$(CONFIG_LOONGSON_HTPIC)        += irq-loongson-htpic.o
>>> diff --git a/drivers/irqchip/irq-loongarch-avec.c 
>>> b/drivers/irqchip/irq-loongarch-avec.c
>>> new file mode 100644
>>> index 000000000000..9a6832986b3d
>>> --- /dev/null
>>> +++ b/drivers/irqchip/irq-loongarch-avec.c
>>> @@ -0,0 +1,433 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2020-2024 Loongson Technologies, Inc.
>>> + */
>>> +
>>> +#include <linux/cpuhotplug.h>
>>> +#include <linux/init.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/irqchip.h>
>>> +#include <linux/irqchip/chained_irq.h>
>>> +#include <linux/irqdomain.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/msi.h>
>>> +#include <linux/radix-tree.h>
>>> +#include <linux/spinlock.h>
>>> +
>>> +#include <asm/loongarch.h>
>>> +#include <asm/setup.h>
>>> +
>>> +#define VECTORS_PER_REG        64
>>> +#define IRR_INVALID_MASK    0x80000000UL
>>> +#define IRR_VECTOR_MASK        0xffUL
>>> +#define AVEC_MSG_OFFSET        0x100000
>>> +
>>> +static phys_addr_t msi_base_v2;
>>> +static DEFINE_PER_CPU(struct irq_desc * [NR_VECTORS], irq_map);
>>> +
>>> +#ifdef CONFIG_SMP
>>> +struct pending_list {
>>> +    struct list_head    head;
>>> +};
>>> +
>>> +static DEFINE_PER_CPU(struct pending_list, pending_list);
>>> +static struct cpumask intersect_mask;
>>> +#endif
>>> +
>>> +struct loongarch_avec_chip {
>>> +    struct fwnode_handle    *fwnode;
>>> +    struct irq_domain    *domain;
>>> +    struct irq_matrix    *vector_matrix;
>>> +    raw_spinlock_t        lock;
>>> +};
>>> +
>>> +static struct loongarch_avec_chip loongarch_avec;
>>> +
>>> +struct loongarch_avec_data {
>>> +    struct list_head    entry;
>>> +    unsigned int        cpu;
>>> +    unsigned int        vec;
>>> +    unsigned int        prev_cpu;
>>> +    unsigned int        prev_vec;
>>> +    unsigned int        moving        : 1,
>>> +                managed        : 1;
>>> +};
>>> +
>>> +static inline void loongarch_avec_ack_irq(struct irq_data *d)
>>> +{
>>> +}
>>> +
>>> +static inline void loongarch_avec_unmask_irq(struct irq_data *d)
>>> +{
>>> +}
>>> +
>>> +static inline void loongarch_avec_mask_irq(struct irq_data *d)
>>> +{
>>> +}
>>> +
>>> +#ifdef CONFIG_SMP
>>> +static inline void pending_list_init(int cpu)
>>> +{
>>> +    struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
>>> +
>>> +    INIT_LIST_HEAD(&plist->head);
>>> +}
>>> +
>>> +static void loongarch_avec_sync(struct loongarch_avec_data *adata)
>>> +{
>>> +    struct pending_list *plist;
>>> +
>>> +    if (cpu_online(adata->prev_cpu)) {
>>> +        plist = per_cpu_ptr(&pending_list, adata->prev_cpu);
>>> +        list_add_tail(&adata->entry, &plist->head);
>>> +        adata->moving = true;
>>> +        mp_ops.send_ipi_single(adata->prev_cpu, ACTION_CLEAR_VECT);
>>> +    }
>>> +}
>>> +
>>> +static int loongarch_avec_set_affinity(struct irq_data *data, const 
>>> struct cpumask *dest,
>>> +                       bool force)
>>> +{
>>> +    struct loongarch_avec_data *adata;
>>> +    unsigned int cpu, vector;
>>> +    unsigned long flags;
>>> +    int ret;
>>> +
>>> +    raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>>> +    adata = irq_data_get_irq_chip_data(data);
>>> +
>>> +    if (adata->vec && cpu_online(adata->cpu) && 
>>> cpumask_test_cpu(adata->cpu, dest)) {
>>> +        raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>> +        return 0;
>>> +    }
>>> +    if (adata->moving)
>>> +        return -EBUSY;
>>> +
>>> +    cpumask_and(&intersect_mask, dest, cpu_online_mask);
>>> +
>>> +    ret = irq_matrix_alloc(loongarch_avec.vector_matrix, 
>>> &intersect_mask, false, &cpu);
>>> +    if (ret < 0) {
>>> +        raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>> +        return ret;
>>> +    }
>>> +    vector = ret;
>>> +    adata->cpu = cpu;
>>> +    adata->vec = vector;
>>> +    per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = 
>>> irq_data_to_desc(data);
>>> +    loongarch_avec_sync(adata);
>>> +
>>> +    raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>> +    irq_data_update_effective_affinity(data, cpumask_of(cpu));
>>> +
>>> +    return IRQ_SET_MASK_OK;
>>> +}
>>> +
>>> +void complete_irq_moving(void)
>>> +{
>>> +    struct pending_list *plist = this_cpu_ptr(&pending_list);
>>> +    struct loongarch_avec_data *adata, *tmp;
>>> +    int cpu, vector, bias;
>>> +    u64 irr;
>>> +
>>> +    raw_spin_lock(&loongarch_avec.lock);
>>> +
>>> +    list_for_each_entry_safe(adata, tmp, &plist->head, entry) {
>>> +        cpu = adata->prev_cpu;
>>> +        vector = adata->prev_vec;
>>> +        bias = vector / VECTORS_PER_REG;
>>> +        switch (bias) {
>>> +        case 0:
>>> +            irr = csr_read64(LOONGARCH_CSR_ISR0);
>>> +        case 1:
>>> +            irr = csr_read64(LOONGARCH_CSR_ISR1);
>>> +        case 2:
>>> +            irr = csr_read64(LOONGARCH_CSR_ISR2);
>>> +        case 3:
>>> +            irr = csr_read64(LOONGARCH_CSR_ISR3);
>>> +        }
>>> +
>>> +        if (irr & (1UL << (vector % VECTORS_PER_REG))) {
>>> +            mp_ops.send_ipi_single(cpu, ACTION_CLEAR_VECT);
>>> +            continue;
>>> +        }
>>> +        list_del(&adata->entry);
>>> +        irq_matrix_free(loongarch_avec.vector_matrix, cpu, vector, 
>>> adata->managed);
>>> +        this_cpu_write(irq_map[vector], NULL);
>>> +        adata->prev_cpu = adata->cpu;
>>> +        adata->prev_vec = adata->vec;
>>> +        adata->moving = 0;
>>> +    }
>>> +    raw_spin_unlock(&loongarch_avec.lock);
>>> +}
>>> +
>>> +void loongarch_avec_offline_cpu(unsigned int cpu)
>>> +{
>>> +    struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
>>> +    unsigned long flags;
>>> +
>>> +    if (!loongarch_avec.vector_matrix)
>>> +        return;
>>> +
>>> +    raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>>> +    if (list_empty(&plist->head))
>>> +        irq_matrix_offline(loongarch_avec.vector_matrix);
>>> +    else
>>> +        pr_warn("cpu %d advanced extioi is busy\n", cpu);
>>> +    raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>> +}
>>> +
>>> +void loongarch_avec_online_cpu(unsigned int cpu)
>>> +{
>>> +    unsigned long flags;
>>> +
>>> +    if (!loongarch_avec.vector_matrix)
>>> +        return;
>>> +
>>> +    raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>>> +
>>> +    irq_matrix_online(loongarch_avec.vector_matrix);
>>> +
>>> +    pending_list_init(cpu);
>>> +
>>> +    raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>> +}
>>> +
>>> +#else
>>> +#define loongarch_avec_set_affinity        NULL
>>> +#endif
>>> +
>>> +static void loongarch_avec_compose_msg(struct irq_data *d,
>>> +        struct msi_msg *msg)
>>> +{
>>> +    struct loongarch_avec_data *avec_data;
>>> +
>>> +    avec_data = irq_data_get_irq_chip_data(d);
>>> +
>>> +    msg->address_hi = 0xfd;
>>> +    msg->address_lo = ((avec_data->vec & 0xff) << 4) |
>>> +              ((cpu_logical_map(avec_data->cpu & 0xffff)) << 12);
>>> +    msg->data = 0x0;
>> It is strange here, What is the base MSI address on earth, hardcoded 
>> address 0xFD00000000? and What is the relationship with address parsed 
>> from MADT table pchmsi_entry->msg_address?
> Thank you for your correction. Here is my verification that different 
> platforms have a legacy issue that should be fixed to its previous state
> I will resend this patch
Ok, need not be so hurry.

>>
>>> +
>>> +}
>>> +
>>> +static struct irq_chip loongarch_avec_controller = {
>>> +    .name            = "AVECINTC",
>>> +    .irq_ack        = loongarch_avec_ack_irq,
>>> +    .irq_mask        = loongarch_avec_mask_irq,
>>> +    .irq_unmask        = loongarch_avec_unmask_irq,
>>> +    .irq_set_affinity    = loongarch_avec_set_affinity,
>>> +    .irq_compose_msi_msg    = loongarch_avec_compose_msg,
>>> +};
>>> +
>>> +static void loongarch_avec_dispatch(struct irq_desc *desc)
>>> +{
>>> +    struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +    unsigned long vector;
>>> +    struct irq_desc *d;
>>> +
>>> +    chained_irq_enter(chip, desc);
>>> +    vector = csr_read64(LOONGARCH_CSR_IRR);
>>> +    if (vector & IRR_INVALID_MASK)
>>> +        return;
>>> +
>>> +    vector &= IRR_VECTOR_MASK;
>>> +
>>> +    d = this_cpu_read(irq_map[vector]);
>>> +    if (d) {
>>> +        generic_handle_irq_desc(d);
>>> +    } else {
>>> +        pr_warn("IRQ ERROR:Unexpected irq  occur on cpu %d[vector 
>>> %ld]\n",
>>> +            smp_processor_id(), vector);
>>> +    }
>>> +
>>> +    chained_irq_exit(chip, desc);
>>> +}
>>> +
>>> +static int loongarch_avec_alloc(struct irq_domain *domain, unsigned 
>>> int virq,
>>> +                unsigned int nr_irqs, void *arg)
>>> +{
>>> +    struct loongarch_avec_data *adata;
>>> +    struct irq_data *irqd;
>>> +    unsigned int cpu, vector, i, ret;
>>> +    unsigned long flags;
>>> +
>>> +    raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>>> +    for (i = 0; i < nr_irqs; i++) {
>>> +        irqd = irq_domain_get_irq_data(domain, virq + i);
>>> +        adata = kzalloc(sizeof(*adata), GFP_KERNEL);
>>> +        if (!adata) {
>>> + raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>> +            return -ENOMEM;
>>> +        }
>>> +        ret = irq_matrix_alloc(loongarch_avec.vector_matrix, 
>>> cpu_online_mask, false, &cpu);
>>> +        if (ret < 0) {
>>> + raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>> +            return ret;
>>> +        }
>>> +        vector = ret;
>>> +        adata->prev_cpu = adata->cpu = cpu;
>>> +        adata->prev_vec = adata->vec = vector;
>>> +        adata->managed = irqd_affinity_is_managed(irqd);
>>> +        irq_domain_set_info(domain, virq + i, virq + i, 
>>> &loongarch_avec_controller,
>>> +                adata, handle_edge_irq, NULL, NULL);
>>> +        adata->moving = 0;
>>> +        irqd_set_single_target(irqd);
>>> +        irqd_set_affinity_on_activate(irqd);
>>> +
>>> +        per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = 
>>> irq_data_to_desc(irqd);
>>> +    }
>>> +    raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void clear_free_vector(struct irq_data *irqd)
>>> +{
>>> +    struct loongarch_avec_data *adata = 
>>> irq_data_get_irq_chip_data(irqd);
>>> +    bool managed = irqd_affinity_is_managed(irqd);
>>> +
>>> +    per_cpu(irq_map, adata->cpu)[adata->vec] = NULL;
>>> +    irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, 
>>> adata->vec, managed);
>>> +    adata->cpu = 0;
>>> +    adata->vec = 0;
>>> +#ifdef CONFIG_SMP
>>> +    if (!adata->moving)
>>> +        return;
>>> +
>>> +    per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] = 0;
>>> +    irq_matrix_free(loongarch_avec.vector_matrix, adata->prev_cpu,
>>> +            adata->prev_vec, adata->managed);
>>> +    adata->prev_vec = 0;
>>> +    adata->prev_cpu = 0;
>>> +    adata->moving = 0;
>>> +    list_del_init(&adata->entry);
>>> +#endif
>>> +}
>>> +
>>> +static void loongarch_avec_free(struct irq_domain *domain, unsigned 
>>> int virq,
>>> +        unsigned int nr_irqs)
>>> +{
>>> +    struct irq_data *d;
>>> +    unsigned long flags;
>>> +    unsigned int i;
>>> +
>>> +    raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
>>> +    for (i = 0; i < nr_irqs; i++) {
>>> +        d = irq_domain_get_irq_data(domain, virq + i);
>>> +        if (d) {
>>> +            clear_free_vector(d);
>>> +            irq_domain_reset_irq_data(d);
>>> +
>>> +        }
>>> +    }
>>> +
>>> +    raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
>>> +}
>>> +
>>> +static const struct irq_domain_ops loongarch_avec_domain_ops = {
>>> +    .alloc        = loongarch_avec_alloc,
>>> +    .free        = loongarch_avec_free,
>>> +};
>>> +
>>> +static int __init irq_matrix_init(void)
>>> +{
>>> +    int i;
>>> +
>>> +    loongarch_avec.vector_matrix = irq_alloc_matrix(NR_VECTORS, 0, 
>>> NR_VECTORS - 1);
>>> +    if (!loongarch_avec.vector_matrix)
>>> +        return -ENOMEM;
>>> +    for (i = 0; i < NR_LEGACY_VECTORS; i++)
>>> +        irq_matrix_assign_system(loongarch_avec.vector_matrix, i, 
>>> false);
>>> +
>>> +    irq_matrix_online(loongarch_avec.vector_matrix);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int __init loongarch_avec_init(struct irq_domain *parent)
>>> +{
>>> +    int ret = 0, parent_irq;
>>> +    unsigned long tmp;
>>> +
>>> +    raw_spin_lock_init(&loongarch_avec.lock);
>>> +
>>> +    loongarch_avec.fwnode = irq_domain_alloc_named_fwnode("CORE_AVEC");
>>> +    if (!loongarch_avec.fwnode) {
>>> +        pr_err("Unable to allocate domain handle\n");
>>> +        ret = -ENOMEM;
>>> +        goto out;
>>> +    }
>>> +
>>> +    loongarch_avec.domain = 
>>> irq_domain_create_tree(loongarch_avec.fwnode,
>>> +            &loongarch_avec_domain_ops, NULL);
>>> +    if (!loongarch_avec.domain) {
>>> +        pr_err("core-vec: cannot create IRQ domain\n");
>>> +        ret = -ENOMEM;
>>> +        goto out_free_handle;
>>> +    }
>>> +
>>> +    parent_irq = irq_create_mapping(parent, INT_AVEC);
>>> +    if (!parent_irq) {
>>> +        pr_err("Failed to mapping hwirq\n");
>>> +        ret = -EINVAL;
>>> +        goto out_remove_domain;
>>> +    }
>>> +    irq_set_chained_handler_and_data(parent_irq, 
>>> loongarch_avec_dispatch, NULL);
>>> +
>>> +    ret = irq_matrix_init();
>>> +    if (ret) {
>>> +        pr_err("Failed to init irq matrix\n");
>>> +        goto out_free_matrix;
>>> +    }
>>> +#ifdef CONFIG_SMP
>>> +    pending_list_init(0);
>>> +#endif
>>> +    tmp = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
>>> +    tmp |= IOCSR_MISC_FUNC_AVEC_EN;
>>> +    iocsr_write64(tmp, LOONGARCH_IOCSR_MISC_FUNC);
>>> +
>>> +    return ret;
>>> +
>>> +out_free_matrix:
>>> +    kfree(loongarch_avec.vector_matrix);
>>> +out_remove_domain:
>>> +    irq_domain_remove(loongarch_avec.domain);
>>> +out_free_handle:
>>> +    irq_domain_free_fwnode(loongarch_avec.fwnode);
>>> +out:
>>> +    return ret;
>>> +}
>>> +
>>> +static int __init pch_msi_parse_madt(union acpi_subtable_headers 
>>> *header,
>>> +                     const unsigned long end)
>>> +{
>>> +    struct acpi_madt_msi_pic *pchmsi_entry = (struct 
>>> acpi_madt_msi_pic *)header;
>>> +
>>> +    msi_base_v2 = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
Can we add a bit in IOCSR register indicating the relationship for this 
to solve legacy compatible problem?

I do not think that it it true in later for all HW design to minus 
AVEC_MSG_OFFSET from MADT table base address, normally it should be the 
same with MADT table.

Regards
Bibo Mao

>> Variable msi_base_v2 is never used.
>>
>> Regards
>> Bibo Mao
>>
>>> +    return pch_msi_acpi_init_v2(loongarch_avec.domain, pchmsi_entry);
>>> +}
>>> +
>>> +static inline int __init acpi_cascade_irqdomain_init(void)
>>> +{
>>> +    return acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, 
>>> pch_msi_parse_madt, 1);
>>> +}
>>> +
>>> +int __init loongarch_avec_acpi_init(struct irq_domain *parent)
>>> +{
>>> +    int ret = 0;
>>> +
>>> +    ret = loongarch_avec_init(parent);
>>> +    if (ret) {
>>> +        pr_err("Failed to init irq domain\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = acpi_cascade_irqdomain_init();
>>> +    if (ret) {
>>> +        pr_err("Failed to cascade IRQ domain\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> diff --git a/drivers/irqchip/irq-loongarch-cpu.c 
>>> b/drivers/irqchip/irq-loongarch-cpu.c
>>> index 9d8f2c406043..1ecac59925c6 100644
>>> --- a/drivers/irqchip/irq-loongarch-cpu.c
>>> +++ b/drivers/irqchip/irq-loongarch-cpu.c
>>> @@ -138,7 +138,9 @@ static int __init acpi_cascade_irqdomain_init(void)
>>>       if (r < 0)
>>>           return r;
>>>   -    return 0;
>>> +    if (cpu_has_avecint)
>>> +        r = loongarch_avec_acpi_init(irq_domain);
>>> +    return r;
>>>   }
>>>     static int __init cpuintc_acpi_init(union acpi_subtable_headers 
>>> *header,
>>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c 
>>> b/drivers/irqchip/irq-loongson-eiointc.c
>>> index c7ddebf312ad..1f9a30488137 100644
>>> --- a/drivers/irqchip/irq-loongson-eiointc.c
>>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
>>> @@ -359,6 +359,9 @@ static int __init acpi_cascade_irqdomain_init(void)
>>>       if (r < 0)
>>>           return r;
>>>   +    if (cpu_has_avecint)
>>> +        return 0;
>>> +
>>>       r = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, 
>>> pch_msi_parse_madt, 1);
>>>       if (r < 0)
>>>           return r;
>>> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c 
>>> b/drivers/irqchip/irq-loongson-pch-msi.c
>>> index dd4d699170f4..8b7aae22e782 100644
>>> --- a/drivers/irqchip/irq-loongson-pch-msi.c
>>> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
>>> @@ -16,7 +16,6 @@
>>>   #include <linux/slab.h>
>>>     static int nr_pics;
>>> -
>>>   struct pch_msi_data {
>>>       struct mutex    msi_map_lock;
>>>       phys_addr_t    doorbell;
>>> @@ -100,6 +99,17 @@ static struct irq_chip middle_irq_chip = {
>>>       .irq_compose_msi_msg    = pch_msi_compose_msi_msg,
>>>   };
>>>   +static struct irq_chip pch_msi_irq_chip_v2 = {
>>> +    .name            = "MSI",
>>> +    .irq_ack        = irq_chip_ack_parent,
>>> +};
>>> +
>>> +static struct msi_domain_info pch_msi_domain_info_v2 = {
>>> +    .flags        = MSI_FLAG_USE_DEF_DOM_OPS | 
>>> MSI_FLAG_USE_DEF_CHIP_OPS |
>>> +            MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
>>> +    .chip    = &pch_msi_irq_chip_v2,
>>> +};
>>> +
>>>   static int pch_msi_parent_domain_alloc(struct irq_domain *domain,
>>>                       unsigned int virq, int hwirq)
>>>   {
>>> @@ -268,6 +278,9 @@ struct fwnode_handle *get_pch_msi_handle(int 
>>> pci_segment)
>>>   {
>>>       int i;
>>>   +    if (cpu_has_avecint)
>>> +        return pch_msi_handle[0];
>>> +
>>>       for (i = 0; i < MAX_IO_PICS; i++) {
>>>           if (msi_group[i].pci_segment == pci_segment)
>>>               return pch_msi_handle[i];
>>> @@ -289,4 +302,31 @@ int __init pch_msi_acpi_init(struct irq_domain 
>>> *parent,
>>>         return ret;
>>>   }
>>> +
>>> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent, struct 
>>> acpi_madt_msi_pic *msi_entry)
>>> +{
>>> +    struct irq_domain *msi_domain;
>>> +
>>> +    if (pch_msi_handle[0])
>>> +        return 0;
>>> +
>>> +    pch_msi_handle[0] = irq_domain_alloc_named_fwnode("msipic-v2");
>>> +    if (!pch_msi_handle[0]) {
>>> +        pr_err("Unable to allocate domain handle\n");
>>> +        kfree(pch_msi_handle[0]);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    msi_domain = pci_msi_create_irq_domain(pch_msi_handle[0],
>>> +            &pch_msi_domain_info_v2,
>>> +            parent);
>>> +    if (!msi_domain) {
>>> +        pr_err("Failed to create PCI MSI domain\n");
>>> +        kfree(pch_msi_handle[0]);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    pr_info("IRQ domain MSIPIC-V2 init done.\n");
>>> +    return 0;
>>> +}
>>>   #endif
>>>
> 


