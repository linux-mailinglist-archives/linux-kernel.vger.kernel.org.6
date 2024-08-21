Return-Path: <linux-kernel+bounces-294768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C803959250
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7621F231A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE744D8B1;
	Wed, 21 Aug 2024 01:47:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8BE12C486;
	Wed, 21 Aug 2024 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724204853; cv=none; b=qa8UCy/9f0dqZovaN4d5gcZBIpR+7mLMIhgPZvVCYKnEud15MZMwtSWIlwlvubz3DQHdlBzXJ5/cEqcjmI1GGntGXGvdvoDOUbu2XtgMPe0m8Vo6upzjcr7FR9YG6cP++uHrdL9pXGwVP6dVa7RBCcQNuyF/wyJGAMmyI+T4LHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724204853; c=relaxed/simple;
	bh=2m97ekdXZqDJ+lbtAaH6RYUqRyNuOw737fH402QMvAk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dCddoEOS2AZ7RGONrwfkCL8lDVZYZXdV5m7HiDXA7g8vXv4tFNOuf/J58fBTHm2BUhbeiEr1aDufEhM0NlJfS43TMXubGfNOW7nsaTJ3hd4ruRoDwhD94iUVbjzpC6XDQxPMOtHVf9f3TRV8yvN2+5hfnyIy6gDcVWFY04mDaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8AxmOkvR8VmbMAaAA--.56471S3;
	Wed, 21 Aug 2024 09:47:27 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowMAxz2cmR8Vm8SQcAA--.48465S3;
	Wed, 21 Aug 2024 09:47:19 +0800 (CST)
Subject: Re: [PATCH v10 2/2] irqchip/loongarch-avec: Add AVEC irqchip support
To: Thomas Gleixner <tglx@linutronix.de>, corbet@lwn.net, alexs@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
 gaoliang@loongson.cn, wangliupu@loongson.cn, lvjianmin@loongson.cn,
 yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
 dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site,
 zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
 zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20240815112608.26925-1-zhangtianyang@loongson.cn>
 <20240815112608.26925-3-zhangtianyang@loongson.cn> <87msl7jgye.ffs@tglx>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <40b3b302-14a1-c158-99ed-feb81d3fefc4@loongson.cn>
Date: Wed, 21 Aug 2024 09:47:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87msl7jgye.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxz2cmR8Vm8SQcAA--.48465S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Wr1fZF4rCry7JF4kCFyfGrX_yoWfKr1DpF
	W5AanrKr48JrWxWryjgw4Uury3Kw1xWr12qa1fCa4xCrWqkryIkF10yr9ruFy0vw48G3yj
	vF4Utas3uFn0y3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2pVbDUUUU

Hi, Thomas

在 2024/8/21 上午12:29, Thomas Gleixner 写道:
> On Thu, Aug 15 2024 at 19:26, Tianyang Zhang wrote:
>>   .../arch/loongarch/irq-chip-model.rst         |  32 ++
>>   .../zh_CN/arch/loongarch/irq-chip-model.rst   |  32 ++
>>   arch/loongarch/Kconfig                        |   1 +
>>   arch/loongarch/include/asm/cpu-features.h     |   1 +
>>   arch/loongarch/include/asm/cpu.h              |   2 +
>>   arch/loongarch/include/asm/hardirq.h          |   3 +-
>>   arch/loongarch/include/asm/hw_irq.h           |   2 +
>>   arch/loongarch/include/asm/irq.h              |  25 +-
>>   arch/loongarch/include/asm/loongarch.h        |  18 +-
>>   arch/loongarch/include/asm/smp.h              |   2 +
>>   arch/loongarch/kernel/cpu-probe.c             |   3 +-
>>   arch/loongarch/kernel/irq.c                   |  15 +-
>>   arch/loongarch/kernel/paravirt.c              |   5 +
>>   arch/loongarch/kernel/smp.c                   |   6 +
>>   drivers/irqchip/Makefile                      |   2 +-
>>   drivers/irqchip/irq-loongarch-avec.c          | 426 ++++++++++++++++++
>>   drivers/irqchip/irq-loongarch-cpu.c           |   5 +-
>>   drivers/irqchip/irq-loongson-eiointc.c        |   7 +-
>>   drivers/irqchip/irq-loongson-pch-msi.c        |  24 +-
>>   include/linux/cpuhotplug.h                    |   3 +-
> This patch is doing too many things at once and is absolutely not
> reviewable.
>
> Please split it up into the obvious bits and pieces:
>
>     1) The IRQ_NOPROBE change
>
>     2) See below
>
>     3) Documentation
>
>     4) Add the arch/loongson parts, i.e. all the defines and
>        basic required function prototypes with a little twist.
>        Add a Kconfig symbol:
>
> 	Kconfig IRQ_LOONGARCH_AVEC
>          	bool
>
>        in drivers/irqchip/Kconfig. This allows you to add all
>        arch/loongarch/ changes with the simple tweak:
>
>        #ifdef CONFIG_IRQ_LOONGARCH_AVEC
>        # define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
>        #else
>        # define cpu_has_avecint		false
>        #endif
>        
>        and
>        
>        #ifdef CONFIG_IRQ_LOONGARCH_AVEC
>        # define SMP_CLEAR_VECTOR		BIT(ACTION_CLEAR_VECTOR)
>        #else
>        # define SMP_CLEAR_VECTOR		(0)
>        #endif
>
>        That way the compiler will optimize out stuff like the
>        SMP_CLEAR_VECTOR handling and you only need the prototype of
>        complete_irq_moving(), but no implementation.
>
>     5) Change the CPU hotplug callback for EOINTC and do
>        the acpi_cascade_irqdomain_init() change.
>
>     6) Prepare get_pch_msi_handle() in the pch MSI driver
>
>     7) Implement the driver and select IRQ_LOONGARCH_AVEC
>        from IRQ_LOONGARCH_CPU
>
>     8) Remove the IRQ_LOONGARCH_AVEC helpers
Thanks for your guiding, we will complete the split as required
>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 70f169210b52..0e3abf7b0bd3 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -85,6 +85,7 @@ config LOONGARCH
>>   	select GENERIC_ENTRY
>>   	select GENERIC_GETTIMEOFDAY
>>   	select GENERIC_IOREMAP if !ARCH_IOREMAP
>> +	select GENERIC_IRQ_MATRIX_ALLOCATOR
> Please move this to IRQ_LOONGARCH_CPU in patch #7
OK, thanks
>
>> @@ -92,15 +103,21 @@ int liointc_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_lio_pic *acpi_liointc);
>>   int eiointc_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_eio_pic *acpi_eiointc);
>> +int avecintc_acpi_init(struct irq_domain *parent);
>> +
>> +void complete_irq_moving(void);
>>   
>>   int htvec_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_ht_pic *acpi_htvec);
>>   int pch_lpc_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_lpc_pic *acpi_pchlpc);
>> -int pch_msi_acpi_init(struct irq_domain *parent,
>> -					struct acpi_madt_msi_pic *acpi_pchmsi);
>>   int pch_pic_acpi_init(struct irq_domain *parent,
>>   					struct acpi_madt_bio_pic *acpi_pchpic);
>> +int pch_msi_acpi_init(struct irq_domain *parent,
>> +					struct acpi_madt_msi_pic *acpi_pchmsi);
>> +int pch_msi_acpi_init_v2(struct irq_domain *parent,
>> +					struct acpi_madt_msi_pic *acpi_pchmsi);
> This is really the wrong place for all these prototypes. They are only
> used in drivers/irqchip/... except for complete_irq_moving().
>
> So the proper place for them is drivers/irqchip/irq-loongarch.h
>
> Move them there. This is patch #2 which I referred to above.
Ok ,thanks
>
>> +static phys_addr_t msi_base_addr;
>>
> So you have everything related to the avec chip in loongarch_avec, so
> why don't you move that into that data structure?
Ok, thanks
>
>> It just looks more compatible with the previous one. It really doesn't make sense. We will delete it later+struct avecintc_chip {
>> +	struct fwnode_handle	*fwnode;
>> +	struct irq_domain	*domain;
>> +	struct irq_matrix	*vector_matrix;
>> +	raw_spinlock_t		lock;
>> +};
> The lock should be the first member as spinlocks have alignment
> requirements....
Ok ,thanks
> It just looks more compatible with the previous one. It really doesn't make sense. We will delete it later
>
>> +static int avecintc_domain_alloc(struct irq_domain *domain,
>> +				 unsigned int virq, unsigned int nr_irqs, void *arg)
>> +{
>> +	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
>> +
>> +	for (unsigned int i = 0; i < nr_irqs; i++) {
>> +		struct irq_data *irqd = irq_domain_get_irq_data(domain, virq + i);
>> +		struct avecintc_data *adata = kzalloc(sizeof(*adata), GFP_KERNEL);
> That was never tested with any debug. You _cannot_ do a GFP_KERNEL
> allocation with the raw spinlock held. And no, don't use
> GFP_ATOMIC. There is absolutely zero reason to hold the lock accross all
> of that. As you got your ideas from x86_vector_alloc_irqs(), you could
> have looked at how that's done correctly.
I got it , thanks
>
>> +		unsigned int cpu, ret;
>> +
>> +		if (!adata)
>> +			return -ENOMEM;
>> +
>> +		ret = irq_matrix_alloc(loongarch_avec.vector_matrix, cpu_online_mask, false, &cpu);
>> +		if (ret < 0) {
>> +			kfree(adata);
>> +			return ret;
>> +		}
>> +
>> +		adata->moving = 0;
> Redundant. The struct is allocated with kzalloc()...
sorry, this is my stupid mistake ..... ,thanks
>
>> +		adata->prev_cpu = adata->cpu = cpu;
>> +		adata->prev_vec = adata->vec = ret;
>> +		adata->managed = irqd_affinity_is_managed(irqd);
> If you want to support managed interrupts, then you cannot allocate
> from the CPU online mask. See x86...
Ok, we will reconsider these functions, thanks
>
>> +		irq_domain_set_info(domain, virq + i, virq + i, &avec_irq_controller,
>> +				    adata, handle_edge_irq, NULL, NULL);
>> +		irqd_set_single_target(irqd);
>> +		irqd_set_affinity_on_activate(irqd);
>> +
>> +		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);
> static int avecintc_alloc_vector(struct avecintc_adata *adata)
> {
>          int ret, cpu;
>
> 	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
> 	ret = irq_matrix_alloc(loongarch_avec.vector_matrix, cpu_online_mask, false, &cpu);
>          if (ret < 0)
>                return ret;
>
> 	adata->prev_cpu = adata->cpu = cpu;
> 	adata->prev_vec = adata->vec = ret;
>          per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);
>          return 0;
> }
>
> static int avecintc_domain_alloc(struct irq_domain *domain, ...)
> {
> 	for (unsigned int i = 0; i < nr_irqs; i++) {
> 		struct irq_data *irqd = irq_domain_get_irq_data(domain, virq + i);
> 		struct avecintc_data *adata = kzalloc(sizeof(*adata), GFP_KERNEL);
>                  int ret;
>
> 		if (!adata)
> 			return -ENOMEM;
>
> 		irq_domain_set_info(domain, virq + i, virq + i, &avec_irq_controller,
> 				    adata, handle_edge_irq, NULL, NULL);
> 		irqd_set_single_target(irqd);
> 		irqd_set_affinity_on_activate(irqd);
>
> 		ret = avecintc_alloc_vector(adata);
>                  if (ret < 0) {
> 			kfree(adata);
>                          return ret;
>                  }
>           }
> No?
OK , It really seems more appropriate, thanks
> It just looks more compatible with the previous one. It really doesn't make sense. We will delete it later
>
>> +static void clear_free_vector(struct irq_data *irqd)
>> +{
>> +	struct avecintc_data *adata = irq_data_get_irq_chip_data(irqd);
>> +	bool managed = irqd_affinity_is_managed(irqd);
> Don't even try. Your managed support is broken at the allocation side
> and at several other places.
OK, thanks
>> +	per_cpu(irq_map, adata->cpu)[adata->vec] = NULL;
>> +	irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->vec, managed);
>> +	adata->cpu = UINT_MAX;
>> +	adata->vec = UINT_MAX;
>> +
>> +#ifdef CONFIG_SMP
>> +	if (!adata->moving)
>> +		return;
>> +
>> +	per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] = NULL;
>> +	irq_matrix_free(loongarch_avec.vector_matrix,
>> +			adata->prev_cpu, adata->prev_vec, adata->managed);
>> +	adata->moving = 0;
>> +	adata->prev_vec = UINT_MAX;
>> +	adata->prev_cpu = UINT_MAX;
> What's all the clearing for when you kfree() it two lines further down?
OK, we will reconsider there ,thanks
>
>> +	list_del_init(&adata->entry);
>> +#endif
>> +	kfree(adata);
> And no, not under the lock .... Move the locking into this function and
> kfree() at the call site. There is zero reason to hold the lock over the
> full loop.
Ok ,thanks
>> +static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
>> +				     const unsigned long end)
>> +{
>> +	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
>> +
>> +	msi_base_addr = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
>> +
>> +	return pch_msi_acpi_init_v2(loongarch_avec.domain, pchmsi_entry);
>> +}
> ...
>
>> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent, struct acpi_madt_msi_pic *acpi_pchmsi)
> The second argument is required because?
It just looks more compatible with the previous one. It really doesn't 
make sense. We will delete it later, Thanks
>
> Thanks,
>
>          tglx

Thanks again

Tianyang


