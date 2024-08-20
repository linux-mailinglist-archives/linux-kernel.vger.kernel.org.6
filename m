Return-Path: <linux-kernel+bounces-294319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E304F958C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F509284C75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E3F1B3F08;
	Tue, 20 Aug 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JgesEHAQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SserZbP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDD190671;
	Tue, 20 Aug 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171373; cv=none; b=P1NOUEfsjx5VmdPhhatQgIjU4QBViQCLyGGM406aeejRQql2Vm51VS3iQPCrFUwfzRy8WBIygRPrztoQFob6pe45/DR/Nhcqt+YB76Rm+5rdE+WGi8/vX8FTUgg1Dg9dEoKi9sOqUuZ4z/z3SCScWadX7HvlU+cQMd7S3IahyYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171373; c=relaxed/simple;
	bh=Voq048pM2Kl4TdkOvYya7BvdxsDdu+6WpfYu5FJSLuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hZmhV/OTXXa8h3gSVI14BFdANKk3iAl1rClBtmDPsxV+IlHA7oIEsREMZg38pnzemzF8wUJfkvSucKpgtgCYw1WH7hzXErqm6k+EjTTFVUrnh5qesRysK3x0gVgeP48Nr4l9zP1mWhteMOCMINufLAqHmKAjfsuei1sZYLwIwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JgesEHAQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SserZbP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724171370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rt+qJPRnUlTdCxy+HqQKlWVloB8PPTVjPXwBqnEDk+0=;
	b=JgesEHAQZzySxLXlM36vPyH8lHIylwIOzBytwcMjS6F/VggEzQzyyuauwnSSAwKu4ew2H9
	Aw3aSxvx6LUKU7m1uJ0Vn99VBH6APahmXOygHG1DsQY3+qx6tKe+HK8BhnotdL83+1g3oB
	uoVCzgKN0FCpY4LEOQpYZcvptY0d2AN6RDAzYzUsFiIv5hvc079Do28bHDQ68ZZ7hPhhO2
	DpdRgGRhlxZ+jWqPIqtl9ZrN+DjuDFQBupZZbp2G+v9HzSIljvmxcQUWCJCUmR+bLMzbZm
	TAluBf+s4bW5PBnXUubmUYcbKMPbGC05MpxZPuBabxwMwc4sCDKLIhVMDv8GwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724171370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rt+qJPRnUlTdCxy+HqQKlWVloB8PPTVjPXwBqnEDk+0=;
	b=1SserZbPrG1HBE+Xmwsgt8bB7uIp0spb8ECHVnnPvzheXB/NaxtoJ+pu/igEiUwJBmEt9v
	5zopFYzdN/5ZtWCQ==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net,
 alexs@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 jiaxun.yang@flygoat.com, gaoliang@loongson.cn, wangliupu@loongson.cn,
 lvjianmin@loongson.cn, zhangtianyang@loongson.cn, yijun@loongson.cn,
 mhocko@suse.com, akpm@linux-foundation.org, dianders@chromium.org,
 maobibo@loongson.cn, xry111@xry111.site, zhaotianrui@loongson.cn,
 nathan@kernel.org, yangtiezhu@loongson.cn, zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v10 2/2] irqchip/loongarch-avec: Add AVEC irqchip support
In-Reply-To: <20240815112608.26925-3-zhangtianyang@loongson.cn>
References: <20240815112608.26925-1-zhangtianyang@loongson.cn>
 <20240815112608.26925-3-zhangtianyang@loongson.cn>
Date: Tue, 20 Aug 2024 18:29:29 +0200
Message-ID: <87msl7jgye.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 19:26, Tianyang Zhang wrote:
>  .../arch/loongarch/irq-chip-model.rst         |  32 ++
>  .../zh_CN/arch/loongarch/irq-chip-model.rst   |  32 ++
>  arch/loongarch/Kconfig                        |   1 +
>  arch/loongarch/include/asm/cpu-features.h     |   1 +
>  arch/loongarch/include/asm/cpu.h              |   2 +
>  arch/loongarch/include/asm/hardirq.h          |   3 +-
>  arch/loongarch/include/asm/hw_irq.h           |   2 +
>  arch/loongarch/include/asm/irq.h              |  25 +-
>  arch/loongarch/include/asm/loongarch.h        |  18 +-
>  arch/loongarch/include/asm/smp.h              |   2 +
>  arch/loongarch/kernel/cpu-probe.c             |   3 +-
>  arch/loongarch/kernel/irq.c                   |  15 +-
>  arch/loongarch/kernel/paravirt.c              |   5 +
>  arch/loongarch/kernel/smp.c                   |   6 +
>  drivers/irqchip/Makefile                      |   2 +-
>  drivers/irqchip/irq-loongarch-avec.c          | 426 ++++++++++++++++++
>  drivers/irqchip/irq-loongarch-cpu.c           |   5 +-
>  drivers/irqchip/irq-loongson-eiointc.c        |   7 +-
>  drivers/irqchip/irq-loongson-pch-msi.c        |  24 +-
>  include/linux/cpuhotplug.h                    |   3 +-

This patch is doing too many things at once and is absolutely not
reviewable.

Please split it up into the obvious bits and pieces:

   1) The IRQ_NOPROBE change

   2) See below

   3) Documentation

   4) Add the arch/loongson parts, i.e. all the defines and
      basic required function prototypes with a little twist.
      Add a Kconfig symbol:

	Kconfig IRQ_LOONGARCH_AVEC
        	bool  

      in drivers/irqchip/Kconfig. This allows you to add all
      arch/loongarch/ changes with the simple tweak:

      #ifdef CONFIG_IRQ_LOONGARCH_AVEC
      # define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
      #else
      # define cpu_has_avecint		false
      #endif
      
      and
      
      #ifdef CONFIG_IRQ_LOONGARCH_AVEC
      # define SMP_CLEAR_VECTOR		BIT(ACTION_CLEAR_VECTOR)
      #else
      # define SMP_CLEAR_VECTOR		(0)
      #endif

      That way the compiler will optimize out stuff like the
      SMP_CLEAR_VECTOR handling and you only need the prototype of
      complete_irq_moving(), but no implementation.

   5) Change the CPU hotplug callback for EOINTC and do
      the acpi_cascade_irqdomain_init() change.

   6) Prepare get_pch_msi_handle() in the pch MSI driver

   7) Implement the driver and select IRQ_LOONGARCH_AVEC
      from IRQ_LOONGARCH_CPU

   8) Remove the IRQ_LOONGARCH_AVEC helpers

> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 70f169210b52..0e3abf7b0bd3 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -85,6 +85,7 @@ config LOONGARCH
>  	select GENERIC_ENTRY
>  	select GENERIC_GETTIMEOFDAY
>  	select GENERIC_IOREMAP if !ARCH_IOREMAP
> +	select GENERIC_IRQ_MATRIX_ALLOCATOR

Please move this to IRQ_LOONGARCH_CPU in patch #7

> @@ -92,15 +103,21 @@ int liointc_acpi_init(struct irq_domain *parent,
>  					struct acpi_madt_lio_pic *acpi_liointc);
>  int eiointc_acpi_init(struct irq_domain *parent,
>  					struct acpi_madt_eio_pic *acpi_eiointc);
> +int avecintc_acpi_init(struct irq_domain *parent);
> +
> +void complete_irq_moving(void);
>  
>  int htvec_acpi_init(struct irq_domain *parent,
>  					struct acpi_madt_ht_pic *acpi_htvec);
>  int pch_lpc_acpi_init(struct irq_domain *parent,
>  					struct acpi_madt_lpc_pic *acpi_pchlpc);
> -int pch_msi_acpi_init(struct irq_domain *parent,
> -					struct acpi_madt_msi_pic *acpi_pchmsi);
>  int pch_pic_acpi_init(struct irq_domain *parent,
>  					struct acpi_madt_bio_pic *acpi_pchpic);
> +int pch_msi_acpi_init(struct irq_domain *parent,
> +					struct acpi_madt_msi_pic *acpi_pchmsi);
> +int pch_msi_acpi_init_v2(struct irq_domain *parent,
> +					struct acpi_madt_msi_pic *acpi_pchmsi);

This is really the wrong place for all these prototypes. They are only
used in drivers/irqchip/... except for complete_irq_moving().

So the proper place for them is drivers/irqchip/irq-loongarch.h

Move them there. This is patch #2 which I referred to above.

>
> +static phys_addr_t msi_base_addr;
>

So you have everything related to the avec chip in loongarch_avec, so
why don't you move that into that data structure?

> +struct avecintc_chip {
> +	struct fwnode_handle	*fwnode;
> +	struct irq_domain	*domain;
> +	struct irq_matrix	*vector_matrix;
> +	raw_spinlock_t		lock;
> +};

The lock should be the first member as spinlocks have alignment
requirements....

> +static int avecintc_domain_alloc(struct irq_domain *domain,
> +				 unsigned int virq, unsigned int nr_irqs, void *arg)
> +{
> +	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
> +
> +	for (unsigned int i = 0; i < nr_irqs; i++) {
> +		struct irq_data *irqd = irq_domain_get_irq_data(domain, virq + i);
> +		struct avecintc_data *adata = kzalloc(sizeof(*adata), GFP_KERNEL);

That was never tested with any debug. You _cannot_ do a GFP_KERNEL
allocation with the raw spinlock held. And no, don't use
GFP_ATOMIC. There is absolutely zero reason to hold the lock accross all
of that. As you got your ideas from x86_vector_alloc_irqs(), you could
have looked at how that's done correctly.

> +		unsigned int cpu, ret;
> +
> +		if (!adata)
> +			return -ENOMEM;
> +
> +		ret = irq_matrix_alloc(loongarch_avec.vector_matrix, cpu_online_mask, false, &cpu);
> +		if (ret < 0) {
> +			kfree(adata);
> +			return ret;
> +		}
> +
> +		adata->moving = 0;

Redundant. The struct is allocated with kzalloc()...

> +		adata->prev_cpu = adata->cpu = cpu;
> +		adata->prev_vec = adata->vec = ret;
> +		adata->managed = irqd_affinity_is_managed(irqd);

If you want to support managed interrupts, then you cannot allocate
from the CPU online mask. See x86...

> +		irq_domain_set_info(domain, virq + i, virq + i, &avec_irq_controller,
> +				    adata, handle_edge_irq, NULL, NULL);
> +		irqd_set_single_target(irqd);
> +		irqd_set_affinity_on_activate(irqd);
> +
> +		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);

static int avecintc_alloc_vector(struct avecintc_adata *adata)
{
        int ret, cpu;

	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
	ret = irq_matrix_alloc(loongarch_avec.vector_matrix, cpu_online_mask, false, &cpu);
        if (ret < 0)
              return ret;

	adata->prev_cpu = adata->cpu = cpu;
	adata->prev_vec = adata->vec = ret;
        per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);
        return 0;
}

static int avecintc_domain_alloc(struct irq_domain *domain, ...)
{
	for (unsigned int i = 0; i < nr_irqs; i++) {
		struct irq_data *irqd = irq_domain_get_irq_data(domain, virq + i);
		struct avecintc_data *adata = kzalloc(sizeof(*adata), GFP_KERNEL);
                int ret;

		if (!adata)
			return -ENOMEM;

		irq_domain_set_info(domain, virq + i, virq + i, &avec_irq_controller,
				    adata, handle_edge_irq, NULL, NULL);
		irqd_set_single_target(irqd);
		irqd_set_affinity_on_activate(irqd);

		ret = avecintc_alloc_vector(adata);
                if (ret < 0) {
			kfree(adata);
                        return ret;
                }
         }
No?

> +static void clear_free_vector(struct irq_data *irqd)
> +{
> +	struct avecintc_data *adata = irq_data_get_irq_chip_data(irqd);
> +	bool managed = irqd_affinity_is_managed(irqd);

Don't even try. Your managed support is broken at the allocation side
and at several other places.

> +	per_cpu(irq_map, adata->cpu)[adata->vec] = NULL;
> +	irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->vec, managed);
> +	adata->cpu = UINT_MAX;
> +	adata->vec = UINT_MAX;
> +
> +#ifdef CONFIG_SMP
> +	if (!adata->moving)
> +		return;
> +
> +	per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] = NULL;
> +	irq_matrix_free(loongarch_avec.vector_matrix,
> +			adata->prev_cpu, adata->prev_vec, adata->managed);
> +	adata->moving = 0;
> +	adata->prev_vec = UINT_MAX;
> +	adata->prev_cpu = UINT_MAX;

What's all the clearing for when you kfree() it two lines further down?

> +	list_del_init(&adata->entry);
> +#endif
> +	kfree(adata);

And no, not under the lock .... Move the locking into this function and
kfree() at the call site. There is zero reason to hold the lock over the
full loop.

> +static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
> +				     const unsigned long end)
> +{
> +	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
> +
> +	msi_base_addr = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
> +
> +	return pch_msi_acpi_init_v2(loongarch_avec.domain, pchmsi_entry);
> +}

...

> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent, struct acpi_madt_msi_pic *acpi_pchmsi)

The second argument is required because?

Thanks,

        tglx

