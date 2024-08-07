Return-Path: <linux-kernel+bounces-278626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC394B2A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626F81F22130
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6011514F8;
	Wed,  7 Aug 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i26YnVyi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7W9h2+/L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76984037;
	Wed,  7 Aug 2024 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068073; cv=none; b=BJiK1znPZEWpzFcGa49+4ZrIcGlOjanW5ejIn6IJ5lmsFPCdAPnKqbBD7oOVP1jxa4DN1295jNppBvww8uotbNHUsKWboffLU6Jso12QZCHLerPGtOz+WMYSzb4b6wlse9Hh3y9aa4dyrsY9aZdKr57jqtjEri2+UmBcShI00CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068073; c=relaxed/simple;
	bh=fbP6I94cC11A+/Klo9i9LHD+7edC8zMM0JK4Nprg13Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y7iflkGTxaJu76SUUxSrV62w9FGpTcJN5xECujeCDCCzsmyhWmNtJg6JUReo8HEJRZYO97Xx+hjdz8n4ukLvDy9iuQl3lG2B180VkNK6EH9FSa95TtspIQPm6FupmXCsH0SBhFUtvMkcnr6t6vDvbwwVn6ka2XzPOcJOb0rZRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i26YnVyi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7W9h2+/L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723068069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bv0zq0hPh37yTMB1NnE0Ct8OVD77IDzgxdULwEk9pDU=;
	b=i26YnVyiNYJt8WwVF3qADnCajMtYZFZEThE8wJK1wwgsFARvWcWuJQC345eipIppOS6xVp
	tzre3FbyxA0jip3jTRRclbsttjGav4weopnOf3+l5rEzU3uqrFp5Ws4P+HGGlGa3zr38LJ
	ejQD++K4OYkf5fR1xUdLFR59BdMcB+H1QwT6MX4mxQxVhcQVBYD6jECgOPUSQUx8tl8x9I
	otQfx7wk6f9OdMXLv530Evo4fWMn5JtNuc7sFT8yAWINuYI9ILmbgL4ivRDuN9ocvR8LdI
	4xw3ZwYS1RvVJwnm2qs/Q3UbwWQmJYnxe6MSQa97UcVzv4TjROoCTasXXW7org==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723068069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bv0zq0hPh37yTMB1NnE0Ct8OVD77IDzgxdULwEk9pDU=;
	b=7W9h2+/LyabBZNrnvGykFbEcaCEADp2zP6XuMRxfOkVmm5/ZTg+JCtXSvoipoz5rWGpsfr
	rFh/0aZHf4/f3lCA==
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
Subject: Re: [PATCH V8 2/2] irqchip/loongarch-avec: Add AVEC irqchip support
In-Reply-To: <20240806115557.4750-1-zhangtianyang@loongson.cn>
References: <20240806115557.4750-1-zhangtianyang@loongson.cn>
Date: Thu, 08 Aug 2024 00:01:08 +0200
Message-ID: <87le180z8b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tianyang!

On Tue, Aug 06 2024 at 19:55, Tianyang Zhang wrote:
> +int __init arch_probe_nr_irqs(void)
> +{
> +	int nr_io_pics = bitmap_weight(loongson_sysconf.cores_io_master, NR_CPUS);
> +
> +	if (!cpu_has_avecint)
> +		nr_irqs = (64 + NR_VECTORS * nr_io_pics);
> +	else
> +		nr_irqs = (64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
> +
> +	return NR_IRQS_LEGACY;
> +}
> +
>  void __init init_IRQ(void)
>  {
>  	int i;
> @@ -102,7 +114,7 @@ void __init init_IRQ(void)
>  	mp_ops.init_ipi();
>  #endif
>  
> -	for (i = 0; i < NR_IRQS; i++)
> +	for (i = 0; i < nr_irqs; i++)
>  		irq_set_noprobe(i);

This is wrong because at that point only the legacy interrupts are
allocated. Nothing will set the NOPROBE flag on any interrupt which is
allocated afterwards.

#define ARCH_IRQ_INIT_FLAGS   IRQ_NOPROBE

in asm/hwirq.h and the core will automatically set the flag for all
interrupts and you can remove this gunk completely.

> +static int avecintc_set_affinity(struct irq_data *data, const struct cpumask *dest, bool force)
> +{
> +	unsigned int cpu, ret, vector;
> +	struct avecintc_data *adata;
> +
> +	scoped_guard(raw_spinlock, &loongarch_avec.lock) {
> +		adata = irq_data_get_irq_chip_data(data);
> +
> +		if (adata->vec && cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest))
> +			return 0;

For invalid vectors you set adata->vec to UINT_MAX, so how is the
adata->vec check here useful? 0 is a valid vector if I'm reading the
code correctly as it's one of the legacy vectors.

> +void complete_irq_moving(void)
> +{
> +	struct pending_list *plist = this_cpu_ptr(&pending_list);
> +	struct avecintc_data *adata, *tdata;
> +	int cpu, vector, bias;
> +	uint64_t isr;
> +
> +	guard(raw_spinlock)(&loongarch_avec.lock);
> +
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

This switch case is broken. It will always read from LOONGARCH_CSR_ISR3,
unless you add a few 'break;' statements, no?

> +		if (isr & (1UL << (vector % VECTORS_PER_REG))) {
> +			mp_ops.send_ipi_single(cpu, ACTION_CLEAR_VECTOR);
> +			continue;
> +		}
> +		list_del(&adata->entry);
> +		irq_matrix_free(loongarch_avec.vector_matrix, cpu, vector, adata->managed);
> +		this_cpu_write(irq_map[vector], NULL);
> +		adata->moving = 0;
> +		adata->prev_cpu = adata->cpu;
> +		adata->prev_vec = adata->vec;
> +	}
> +}
> +#endif
> +
> +static void avecintc_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
> +{
> +	struct avecintc_data *adata = irq_data_get_irq_chip_data(d);
> +
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

This still uses random order of variable declarations. See
Documentation...

> +	chained_irq_enter(chip, desc);
> +
> +	while (true) {

        for (;;) {

> +		vector = csr_read64(LOONGARCH_CSR_IRR);

Please move the vector declaration into the scope where it's used

		unsigned long vector = csr_read64(LOONGARCH_CSR_IRR);
...

> +		if (vector & IRR_INVALID_MASK)
> +			break;
> +
> +		vector &= IRR_VECTOR_MASK;
> +
> +		d = this_cpu_read(irq_map[vector]);
> +		if (d) {
> +			generic_handle_irq_desc(d);
> +		} else {
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
> +	struct irq_data *irqd;
> +	struct avecintc_data *adata;

Ditto. And move all variables except i into the for loop and 

> +	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
> +
> +	for (i = 0; i < nr_irqs; i++) {

make that

	for (unsigned int i = 0; ....) {

> +		irqd = irq_domain_get_irq_data(domain, virq + i);
> +		adata = kzalloc(sizeof(*adata), GFP_KERNEL);
> +		if (!adata)
> +			return -ENOMEM;
> +
> +		ret = irq_matrix_alloc(loongarch_avec.vector_matrix, cpu_online_mask, false, &cpu);
> +		if (ret < 0)
> +			return ret;
> +
> +		adata->moving = 0;
> +		adata->prev_cpu = adata->cpu = cpu;
> +		adata->prev_vec = adata->vec = ret;
> +		adata->managed = irqd_affinity_is_managed(irqd);
> +		irq_domain_set_info(domain, virq + i, virq + i, &avec_irq_controller,
> +				    adata, handle_edge_irq, NULL, NULL);
> +		irqd_set_single_target(irqd);
> +		irqd_set_affinity_on_activate(irqd);
> +
> +		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);
> +	}
> +
> +	return 0;
> +}
> +
> +static void clear_free_vector(struct irq_data *irqd)
> +{
> +	bool managed = irqd_affinity_is_managed(irqd);
> +	struct avecintc_data *adata = irq_data_get_irq_chip_data(irqd);

Sigh.

> +	per_cpu(irq_map, adata->cpu)[adata->vec] = NULL;
> +	irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->vec, managed);

> +static void avecintc_domain_free(struct irq_domain *domain,
> +				 unsigned int virq, unsigned int nr_irqs)
> +{
> +	unsigned int i;
> +	struct irq_data *d;

See comments above...

> +	guard(raw_spinlock_irqsave)(&loongarch_avec.lock);
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		d = irq_domain_get_irq_data(domain, virq + i);
> +		if (d) {
> +			clear_free_vector(d);
> +			irq_domain_reset_irq_data(d);
> +

Stray newline, but the more important question is what kfree()'s 'd'?

AFAICT, nothing. So that's a memory leak, no?

> +		}
> +	}
> +}
> +
> +static const struct irq_domain_ops avecintc_domain_ops = {
> +	.alloc		= avecintc_domain_alloc,
> +	.free		= avecintc_domain_free,
> +	.select		= msi_lib_irq_domain_select,
> +};
> +
> +static int __init irq_matrix_init(void)
> +{
> +	int i;

...

> +static int __init avecintc_init(struct irq_domain *parent)
> +{
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
> +		goto out_remove_domain;

Which still leaves the disfunct chained handler installed and the
mapping intact. 

> +	}
> +#ifdef CONFIG_SMP
> +	pending_list_init(0);
> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_AVECINTC_STARTING,
> +					"irqchip/loongarch/avecintc:starting",
> +					avecintc_cpu_online, avecintc_cpu_offline);

And if that would fail, you happily continue despite knowing that SMP
won't work.

But as this can't fail because of '_nocalls' and the decicated state,
the assignment to ret is pointless.

> +#endif
> +	value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
> +	value |= IOCSR_MISC_FUNC_AVEC_EN;
> +	iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
> +
> +	return ret;
> +
> +out_remove_domain:
> +	irq_domain_remove(loongarch_avec.domain);
> +out_free_handle:
> +	irq_domain_free_fwnode(loongarch_avec.fwnode);
> +out:
> +	return ret;
> +}
> +
> +static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
> +				     const unsigned long end)
> +{
> +	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
> +
> +	msi_base_addr = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;

What validates that msi_base_addr has none of the lower 16 bits set, as
they are required to be zero to make MSI message composing work, right?

> +int __init avecintc_acpi_init(struct irq_domain *parent)
> +{
> +	int ret;
> +
> +	ret = avecintc_init(parent);

        int ret = ....

> +	if (ret < 0) {
> +		pr_err("Failed to init IRQ domain\n");
> +		return ret;
> +	}
> +
> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
> index 2242f63c66fc..ec0b3dba238f 100644
> --- a/drivers/irqchip/irq-loongson-pch-msi.c
> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
> @@ -256,11 +256,14 @@ struct fwnode_handle *get_pch_msi_handle(int pci_segment)
>  {
>  	int i;

Please move this into the for() while at it.

> +	if (cpu_has_avecint)
> +		return pch_msi_handle[0];
> +
>  	for (i = 0; i < MAX_IO_PICS; i++) {
>  		if (msi_group[i].pci_segment == pci_segment)
>  			return pch_msi_handle[i];
>  	}
> -	return NULL;
> +	return pch_msi_handle[0];
>  }
>  
>  int __init pch_msi_acpi_init(struct irq_domain *parent,
> @@ -277,4 +280,19 @@ int __init pch_msi_acpi_init(struct irq_domain *parent,
>  
>  	return ret;
>  }
> +
> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
> +					struct acpi_madt_msi_pic *acpi_pchmsi)

Is it really so hard to use the 100 character width or to align the
second line properly as documented?

Thanks,

        tglx


