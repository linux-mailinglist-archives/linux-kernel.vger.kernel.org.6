Return-Path: <linux-kernel+bounces-263431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6134193D5BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1745928395B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED3B178CC8;
	Fri, 26 Jul 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hh2gP9Cl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rHQ3xv59"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B617A581;
	Fri, 26 Jul 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006765; cv=none; b=dLiZ2cLZAyB8QEJ6zWaRUfZKZIyDfxYQS4GjhitDTietp/wVusflrOVFYaMxo4ZT3O+EdPxKJpVbpH3R9bgQhFtfRqQnPFeCBIUs04+q18+s6PMeWbkTqALbzVxpnHfzxPH1nj+6yi25DcgLMmNEyVylMPuqgJse85DRnLI4zwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006765; c=relaxed/simple;
	bh=yDgTbGAfOjjluA4iJOUZiVejv5Wbq/5iirRMEumBjLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GoncI/wNKhaRyPoCixmu06C39z8xxyPrBVvM8GtvlWBG/yncf+Y6gNZJPy3QicVrxyVBnKlMTKp0Z+LHa20hm/XMbfzhVfJZsSeg5jqSGfvOM1ufJSUR6e5kYMD1oWgYU/o1mUJXbtKdgC7mslUfilk6eBUcAHdiHprgTQxdsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hh2gP9Cl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rHQ3xv59; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722006761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogqL/hg/pnvLqbooyNM3CMI8yfnhV8Cc2ZPYlo4agcY=;
	b=Hh2gP9Cl3Ek28v7XwQoC1iD72rNlHUJCX69ipppt7PRGFrvY0+lmiV8AlWi4pIKfBohE7E
	SpCmLUoc8e5pSCMi5K/s9Rt5rHgLPhBbbMmL7HcdH6uA1YyXwci5iLBKaMomiMU4g2SUcP
	Hfl08Q1plMxgEv6xbNzKmjH4kYBM260EB0gKoAH8gzP2e9xUOe3+1l0vKbbYpaF9AANJ0f
	FWhjpukg6hxCTNwjptGzjj8Nd5rBQp4s3MfoOUVxGk3Rqj0kEItGwhkfnccbNprheRmo5E
	B+VeRvPjNTtY9WoJ0Eva0HpqfCLgRSgT1Kf5MxrAGkfVpLHn8Jdl+Ow51T9P2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722006761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ogqL/hg/pnvLqbooyNM3CMI8yfnhV8Cc2ZPYlo4agcY=;
	b=rHQ3xv59tLDvL0qOzO5+vZXKs3OLSXspr6rTsPXOkYqL6EQMXFlIQfROX0pcQLLFTHlZyx
	Ql0d/GhxhOqrckBA==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net,
 alexs@kernel.org, siyanteng@loongson.cn, chenhuacai@kernel.org,
 kernel@xen0n.name, jiaxun.yang@flygoat.com, gaoliang@loongson.cn,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, zhangtianyang@loongson.cn,
 yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
 dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site,
 zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
 zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V7] LoongArch: Add AVEC irqchip support
In-Reply-To: <20240726102443.12471-1-zhangtianyang@loongson.cn>
References: <20240726102443.12471-1-zhangtianyang@loongson.cn>
Date: Fri, 26 Jul 2024 17:12:41 +0200
Message-ID: <87o76kuqza.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 26 2024 at 18:24, Tianyang Zhang wrote:
> +static int avecintc_set_affinity(struct irq_data *data, const struct cpumask *dest,
> +				       bool force)

Please align arguments according to documentation. In this case don't
use a line break. Just use the full 100 character width all over the place

> +{
> +	unsigned int cpu, ret, vector;
> +	unsigned long flags;
> +	struct avecintc_data *adata;

Please look for variable declarations in:

       https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

and fix it up all over the place.

> +
> +	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);

This does not need irqsave because the function is always called with
interrupts disabled.

> +	adata = irq_data_get_irq_chip_data(data);
> +
> +	if (adata->vec && cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest)) {
> +		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +		return 0;
> +	}
> +
> +	if (adata->moving)
> +		return -EBUSY;

This leaks loongarch_avec.lock. Please use

     scoped_guard(raw_spin_lock)(&loongarch_avec.lock);

above so you spare all the unlocks and cannot miss one.

> +	cpumask_and(&intersect_mask, dest, cpu_online_mask);
> +
> +	ret = irq_matrix_alloc(loongarch_avec.vector_matrix, &intersect_mask, false, &cpu);
> +	if (ret < 0) {
> +		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +		return ret;
> +	}
> +
> +	vector = ret;
> +	adata->cpu = cpu;
> +	adata->vec = vector;
> +	per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(data);
> +	avecintc_sync(adata);
> +
> +	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +	irq_data_update_effective_affinity(data, cpumask_of(cpu));
> +
> +	return IRQ_SET_MASK_OK;
> +}
> +
> +static int avecintc_cpu_online(unsigned int cpu)
> +{
> +	unsigned long flags;
> +
> +	if (!loongarch_avec.vector_matrix)
> +		return 0;
> +
> +	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);

  guard(raw_spin_lock)

interrupts are disabled.

> +	irq_matrix_online(loongarch_avec.vector_matrix);
> +
> +	pending_list_init(cpu);
> +
> +	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +
> +	return 0;
> +}
> +
> +static int avecintc_cpu_offline(unsigned int cpu)
> +{
> +	unsigned long flags;
> +	struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
> +
> +	if (!loongarch_avec.vector_matrix)
> +		return 0;
> +
> +	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);

Ditto.

> +	if (list_empty(&plist->head))
> +		irq_matrix_offline(loongarch_avec.vector_matrix);
> +	else
> +		pr_warn("CPU#%d advanced vector is busy\n", cpu);

Seriously? You leave the matrix online so allocation can be made from an
offline CPU?

> +	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +
> +	return 0;
> +}
> +
> +void complete_irq_moving(void)
> +{
> +	struct pending_list *plist = this_cpu_ptr(&pending_list);
> +	struct avecintc_data *adata, *tdata;
> +	int cpu, vector, bias;
> +	uint64_t isr;
> +
> +	raw_spin_lock(&loongarch_avec.lock);

  guard()

> +	list_for_each_entry_safe(adata, tdata, &plist->head, entry) {
> +		cpu = adata->prev_cpu;
> +		vector = adata->prev_vec;
> +		bias = vector / VECTORS_PER_REG;
> +		switch (bias) {
> +		case 0:
> +			isr = csr_read64(LOONGARCH_CSR_ISR0);
> +		case 1:
> +			isr = csr_read64(LOONGARCH_CSR_ISR1);
> +		case 2:
> +			isr = csr_read64(LOONGARCH_CSR_ISR2);
> +		case 3:
> +			isr = csr_read64(LOONGARCH_CSR_ISR3);
> +		}
> +
> +		if (isr & (1UL << (vector % VECTORS_PER_REG))) {
> +			mp_ops.send_ipi_single(cpu, ACTION_CLEAR_VECTOR);

Is it guaranteed that the device vector is handled _before_ the next
IPI is handled? If not this is a live lock.

> +			continue;
> +		}
> +		list_del(&adata->entry);
> +		irq_matrix_free(loongarch_avec.vector_matrix, cpu, vector, adata->managed);
> +		this_cpu_write(irq_map[vector], NULL);
> +		adata->prev_cpu = adata->cpu;
> +		adata->prev_vec = adata->vec;
> +		adata->moving = 0;
> +	}
> +
> +	raw_spin_unlock(&loongarch_avec.lock);
> +}
> +#endif
> +
> +static void avecintc_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
> +{
> +	struct avecintc_data *adata;
> +
> +	adata = irq_data_get_irq_chip_data(d);

Move the assignement up to the declaration.


> +	msg->address_hi = 0x0;
> +	msg->address_lo = (msi_base_addr | (adata->vec & 0xff) << 4) |
> +			  ((cpu_logical_map(adata->cpu & 0xffff)) << 12);
> +	msg->data = 0x0;
> +}
> +
> +static struct irq_chip avec_irq_controller = {
> +	.name			= "AVECINTC",
> +	.irq_ack		= avecintc_ack_irq,
> +	.irq_mask		= avecintc_mask_irq,
> +	.irq_unmask		= avecintc_unmask_irq,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity	= avecintc_set_affinity,
> +#endif
> +	.irq_compose_msi_msg	= avecintc_compose_msi_msg,
> +};
> +
> +static void avecintc_irq_dispatch(struct irq_desc *desc)
> +{
> +	unsigned long vector;
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct irq_desc *d;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	while (true) {
> +		vector = csr_read64(LOONGARCH_CSR_IRR);
> +		if (vector & IRR_INVALID_MASK)
> +			break;
> +
> +		vector &= IRR_VECTOR_MASK;
> +
> +		d = this_cpu_read(irq_map[vector]);
> +		if (d)
> +			generic_handle_irq_desc(d);
> +		else {

See bracket rules.

> +			spurious_interrupt();
> +			pr_warn("Unexpected IRQ occurs on CPU#%d [vector %ld]\n", smp_processor_id(), vector);
> +		}

> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int avecintc_domain_alloc(struct irq_domain *domain,
> +				 unsigned int virq, unsigned int nr_irqs, void *arg)
> +{
> +	unsigned int cpu, i, ret;
> +	unsigned long flags;
> +	struct irq_data *irqd;
> +	struct avecintc_data *adata;
> +
> +	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);


  guard(raw_spinlock_irqsave)(....);

> +	for (i = 0; i < nr_irqs; i++) {
> +		irqd = irq_domain_get_irq_data(domain, virq + i);
> +		adata = kzalloc(sizeof(*adata), GFP_KERNEL);
> +		if (!adata) {
> +			raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +			return -ENOMEM;
> +		}
> +
> +		ret = irq_matrix_alloc(loongarch_avec.vector_matrix, cpu_online_mask, false, &cpu);
> +		if (ret < 0) {
> +			raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +			return ret;
> +		}
> +
> +		adata->prev_cpu = adata->cpu = cpu;
> +		adata->prev_vec = adata->vec = ret;
> +		adata->managed = irqd_affinity_is_managed(irqd);
> +		irq_domain_set_info(domain, virq + i, virq + i, &avec_irq_controller,
> +				    adata, handle_edge_irq, NULL, NULL);
> +		adata->moving = 0;

Initialize first before doing enything else.

> +		irqd_set_single_target(irqd);
> +		irqd_set_affinity_on_activate(irqd);
> +
> +		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);
> +	}
> +	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +
> +	return 0;
> +}
> +
> +static void clear_free_vector(struct irq_data *irqd)
> +{
> +	bool managed = irqd_affinity_is_managed(irqd);
> +	struct avecintc_data *adata = irq_data_get_irq_chip_data(irqd);
> +
> +	per_cpu(irq_map, adata->cpu)[adata->vec] = NULL;
> +	irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->vec, managed);
> +	adata->cpu = 0;

0 is a valid CPU number, no?

> +	adata->vec = 0;
> +
> +#ifdef CONFIG_SMP
> +	if (!adata->moving)
> +		return;
> +
> +	per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] = NULL;
> +	irq_matrix_free(loongarch_avec.vector_matrix,
> +			adata->prev_cpu, adata->prev_vec, adata->managed);
> +	adata->moving = 0;
> +	adata->prev_vec = 0;
> +	adata->prev_cpu = 0;
> +	list_del_init(&adata->entry);
> +#endif
> +}
> +
> +static void avecintc_domain_free(struct irq_domain *domain,
> +				 unsigned int virq, unsigned int nr_irqs)
> +{
> +	unsigned int i;
> +	unsigned long flags;
> +	struct irq_data *d;
> +
> +	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);

guard()

> +	for (i = 0; i < nr_irqs; i++) {
> +		d = irq_domain_get_irq_data(domain, virq + i);
> +		if (d) {
> +			clear_free_vector(d);
> +			irq_domain_reset_irq_data(d);
> +
> +		}
> +	}
> +
> +	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +}
> +
> +static const struct irq_domain_ops avecintc_domain_ops = {
> +	.alloc		= avecintc_domain_alloc,
> +	.free		= avecintc_domain_free,
> +};
> +
> +static int __init irq_matrix_init(void)
> +{
> +	int i;
> +
> +	loongarch_avec.vector_matrix = irq_alloc_matrix(NR_VECTORS, 0, NR_VECTORS - 1);
> +	if (!loongarch_avec.vector_matrix)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < NR_LEGACY_VECTORS; i++)
> +		irq_matrix_assign_system(loongarch_avec.vector_matrix, i, false);
> +
> +	irq_matrix_online(loongarch_avec.vector_matrix);
> +
> +	return 0;
> +}
> +
> +static int __init avecintc_init(struct irq_domain *parent)
> +{
> +	int ret, parent_irq;
> +	unsigned long value;
> +
> +	raw_spin_lock_init(&loongarch_avec.lock);
> +
> +	loongarch_avec.fwnode = irq_domain_alloc_named_fwnode("AVECINTC");
> +	if (!loongarch_avec.fwnode) {
> +		pr_err("Unable to allocate domain handle\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	loongarch_avec.domain = irq_domain_create_tree(loongarch_avec.fwnode,
> +						       &avecintc_domain_ops, NULL);
> +	if (!loongarch_avec.domain) {
> +		pr_err("Unable to create IRQ domain\n");
> +		ret = -ENOMEM;
> +		goto out_free_handle;
> +	}
> +
> +	parent_irq = irq_create_mapping(parent, INT_AVEC);
> +	if (!parent_irq) {
> +		pr_err("Failed to mapping hwirq\n");
> +		ret = -EINVAL;
> +		goto out_remove_domain;
> +	}
> +	irq_set_chained_handler_and_data(parent_irq, avecintc_irq_dispatch, NULL);
> +
> +	ret = irq_matrix_init();
> +	if (ret < 0) {
> +		pr_err("Failed to init irq matrix\n");
> +		goto out_free_matrix;
> +	}
> +#ifdef CONFIG_SMP
> +	pending_list_init(0);
> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_AVECINTC_STARTING,
> +					"irqchip/loongarch/avecintc:starting",
> +					avecintc_cpu_online, avecintc_cpu_offline);
> +#endif
> +	value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
> +	value |= IOCSR_MISC_FUNC_AVEC_EN;
> +	iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
> +
> +	return ret;
> +
> +out_free_matrix:
> +	kfree(loongarch_avec.vector_matrix);

The code above just failed to allocate the matrix, so why are you trying
to free it?

And this happily fails to uninstall the chained handler. 

> +out_remove_domain:
> +	irq_domain_remove(loongarch_avec.domain);
> +out_free_handle:
> +	irq_domain_free_fwnode(loongarch_avec.fwnode);
> +out:
> +	return ret;
> +}
> +
> +static struct irq_chip pch_msi_irq_chip_v2 = {
> +	.name			= "PCH PCI MSI",
> +	.irq_ack		= irq_chip_ack_parent,
> +};
> +
> +static struct msi_domain_info pch_msi_domain_info_v2 = {
> +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
> +	.chip	= &pch_msi_irq_chip_v2,
> +};
> +
> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
> +					struct acpi_madt_msi_pic *acpi_pchmsi)
> +{
> +	struct irq_domain *msi_domain;
> +
> +	if (pch_msi_handle[0])
> +		return 0;
> +
> +	pch_msi_handle[0] = irq_domain_alloc_fwnode(&acpi_pchmsi->msg_address);
> +	if (!pch_msi_handle[0]) {
> +		pr_err("Unable to allocate domain handle\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi_domain = pci_msi_create_irq_domain(pch_msi_handle[0],
> +					       &pch_msi_domain_info_v2, parent);

Please don't do that. Convert this to use per device MSI domains.

Thanks,

        tglx

