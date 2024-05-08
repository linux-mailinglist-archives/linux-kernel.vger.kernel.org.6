Return-Path: <linux-kernel+bounces-172983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4E38BF9B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23005284396
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59743768FC;
	Wed,  8 May 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wz4e9Iw1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1im8+bRk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947AC75803;
	Wed,  8 May 2024 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161400; cv=none; b=Bqv8MV3uIcxmi8PN2HU4ep0LPxg/kyPZc850BgYkOC6Iqmwd49phZOtJU6vbvfvL/nqd4U0qmQBX2ZnYMIs+Ii3fz6On7J6n+Tx3cNvjaXXDLm9GnI35fmGW6ccAco0QqXCtDOEroFNZ+Sm/iLlX2Dv94Xwp2clqfO25rfS1sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161400; c=relaxed/simple;
	bh=ARhtpo8Jmx37/QbwR78hdvenhm1/JHnfsdvXDDIGO6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hbdTPBI1lrajhD53ZJjWByRmmmDatd7Wg+ULtfyGiqEaT2t70mwvim8UREoAHy0awJ9ANH3IYfSwouHGNBL3YBS8A7nTr3jxbmGdtTJxSOKlqaFlDysVtkOso3MlZEQ8Yo+FmMtHlxZqcxZYW5CzJ93aThW3UNQVV/M2/77/nZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wz4e9Iw1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1im8+bRk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715161395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VprUFeKX/HznPHuWilhPGErbZk95Xg8FX1vIXsoDuLA=;
	b=wz4e9Iw1x59+8YDdk0VmJyh2X5frQd6HaTTt3IL9/qZO7qXS5ZX7ie8E7wzv7YsUnn98iy
	qvIP37sXHHsEOhj9/XWHfOCA6wbQc03Q/y24sXan1Kbnf4epwclmowY6Hyy9t3kJfC6lU7
	68+jOmFRewYhSr7NK7/uMgQ+0Wrx7icKe8ndODHmncqKl1BWaXUf63ps3csMpRIUduhjzB
	J0yt1HVwMcNf2mgJPz4JcsgaRRumpqxzfkxAMAbRiBb+U6zXaZ7NxmIEVtfNBc/RziK/Yp
	+FriqN2shkpM/7x+SpjBoTpyd2M8oOIPv2BrfcHDw4GI0zuh7sFzeXj7AJI8qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715161395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VprUFeKX/HznPHuWilhPGErbZk95Xg8FX1vIXsoDuLA=;
	b=1im8+bRkhkxb6649oVjaN6OiJpQhNiyYO7Q6N74UeHpn63IJFWL0w3U5c3AVaf8fn/g5+S
	4cN4bcQZGwJ3VABQ==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, chenhuacai@kernel.org,
 kernel@xen0n.name, jiaxun.yang@flygoat.com, gaoliang@loongson.cn,
 wangliupu@loongson.cn, lvjianmin@loongson.cn, zhangtianyang@loongson.cn,
 yijun@loongson.cn, mhocko@suse.com, akpm@linux-foundation.org,
 dianders@chromium.org, maobibo@loongson.cn, xry111@xry111.site,
 zhaotianrui@loongson.cn, nathan@kernel.org, yangtiezhu@loongson.cn,
 zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Loongarch:Support loongarch avec
In-Reply-To: <20240507125953.9117-1-zhangtianyang@loongson.cn>
References: <20240507125953.9117-1-zhangtianyang@loongson.cn>
Date: Wed, 08 May 2024 11:43:15 +0200
Message-ID: <87a5l0prkc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 07 2024 at 20:59, Tianyang Zhang wrote:
> From: zhangtianyang <zhangtianyang@loongson.cn>

Please use your real name for the From line.

> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/spinlock.h>
> +#include <linux/msi.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/radix-tree.h>

Please put the includes in alphabethical order.

> +#include <asm/loongarch.h>
> +#include <asm/setup.h>
> +
> +static phys_addr_t msi_base_v2;
> +
> +typedef struct irq_data *irq_map_t[NR_VECTORS];

No new pointless typedefs please.

struct irq_map {
	struct irq_data irqd[NR_VECTORS];
};

> +DECLARE_PER_CPU(irq_map_t, irq_map);

What's this declaration for?

> +DEFINE_PER_CPU(irq_map_t, irq_map) = {

Why is this global and not static? 

> +	[0 ... NR_VECTORS - 1] = NULL,

No need to initialize to NULL. It's zeroed by default.

> +};
> +
> +struct pending_list {
> +	struct list_head head;
> +	raw_spinlock_t	lock;
> +};

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

> +DEFINE_PER_CPU(struct pending_list, pending_list);

Why is this global?

> +struct loongarch_avec_chip {
> +	struct fwnode_handle	*fwnode;
> +	struct irq_domain	*domain;
> +	struct irq_matrix	*vector_matrix;
> +	raw_spinlock_t		lock;
> +} loongarch_avec;
> +
> +struct loongarch_avec_data {
> +	struct list_head entry;
> +	unsigned int cpu;
> +	unsigned int vec;
> +	unsigned int prev_cpu;
> +	unsigned int prev_vec;
> +};

See link above.

> +static int assign_irq_vector(struct irq_data *irqd, const struct cpumask *dest,
> +		unsigned int *cpu, int *vector)

Please read the line break section in the tip docomentation

> +{
> +	int ret;
> +
> +	ret = irq_matrix_alloc(loongarch_avec.vector_matrix, dest, false, cpu);
> +	if (ret < 0)
> +		return ret;
> +	*vector = ret;
> +
> +	return 0;

Why not simply returning the result of irq_matrix_alloc() and checking
it for negative value at the call site. If not negative then use it as
vector. That spares the whole indirection and makes the code readable.

> +static void loongarch_avec_sync(struct loongarch_avec_data *adata)
> +{
> +	struct loongarch_avec_data *data;
> +	struct pending_list *plist;
> +
> +	if (cpu_online(adata->prev_cpu)) {
> +		plist = per_cpu_ptr(&pending_list, adata->prev_cpu);
> +
> +		data = kmalloc(sizeof(struct loongarch_avec_data), GFP_KERNEL);

This is called from loongarch_avec_set_affinity() with raw spinlocks
held and interrupts disabled. So GFP_KERNEL cannot work. You clearly did
not test that code with proper debug options enabled.

But even GFP_ATOMIC won't work when you want to support PREEMPT_RT as
that does not allow allocations in such contexts.

Look how x86 solves exactly this problem without allocations required.

> +		if (!data) {
> +			pr_warn("NO space for clean data\n");
> +			return;
> +		}
> +		memcpy(data, adata, sizeof(struct loongarch_avec_data));
> +		INIT_LIST_HEAD(&data->entry);
> +
> +		list_add_tail(&data->entry, &plist->head);
> +		loongson_send_ipi_single(adata->prev_cpu, SMP_CLEAR_VECT);
> +	}
> +	adata->prev_cpu = adata->cpu;
> +	adata->prev_vec = adata->vec;
> +}
> +
> +static int loongarch_avec_set_affinity(struct irq_data *data,
> +		const struct cpumask *dest, bool force)
> +{
> +	struct cpumask intersect_mask;

No cpumasks on stack please. You can make that static as usage is always
serialized via loongarch_avec.lock

> +	struct loongarch_avec_data *adata;
> +	unsigned int cpu, vector;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
> +	adata = irq_data_get_irq_chip_data(data);
> +
> +	if (adata->vec && cpu_online(adata->cpu)
> +			&& cpumask_test_cpu(adata->cpu, dest)) {

Please align the condition proper when you need a line break:

	if (adata->vec && cpu_online(adata->cpu) &&
	    cpumask_test_cpu(adata->cpu, dest)) {

But you don't need a line break here because 

	if (adata->vec && cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest)) {

fits into the 100 character line width limit.

> +		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +		return 0;
> +	}
> +
> +	if (!cpumask_intersects(dest, cpu_online_mask)) {
> +		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	cpumask_and(&intersect_mask, dest, cpu_online_mask);

The above intersect check is pointless as the matrix allocator already
checks the cpumask and returns -EINVAL if empty.

> +
> +	ret = assign_irq_vector(data, &intersect_mask, &cpu, &vector);
> +	if (ret) {
> +		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +		return ret;
> +	}

> +void complete_irq_moving(int *restart)

What is the 'restart' argument for?

> +{
> +	struct pending_list *plist = this_cpu_ptr(&pending_list);
> +	struct loongarch_avec_data *adata, *tmp;
> +	int cpu, vector;
> +	u32 bias;
> +	u64 irr;
> +
> +	raw_spin_lock(&loongarch_avec.lock);
> +
> +	list_for_each_entry_safe(adata, tmp, &plist->head, entry) {
> +
> +		cpu = adata->prev_cpu;
> +		vector = adata->prev_vec;
> +		bias = vector/64;
> +
> +		switch (bias) {
> +		case 0x0:
> +			irr = csr_read64(LOONGARCH_CSR_IRR0);
> +			break;
> +		case 0x1:
> +			irr = csr_read64(LOONGARCH_CSR_IRR1);
> +			break;
> +		case 0x2:
> +			irr = csr_read64(LOONGARCH_CSR_IRR2);
> +			break;
> +		case 0x3:
> +			irr = csr_read64(LOONGARCH_CSR_IRR3);
> +			break;
> +		default:
> +			return;

How can that happen ?

> +		}

                irr = csr_read64(LOONGARCH_CSR_IRR0 + vector / 64);

should be good enough, no?

Also please use a proper constant instead of '64', e.g. VECTORS_PER_IRR

> +
> +		if (irr & (1UL << (vector % 64))) {
> +			loongson_send_ipi_single(cpu, SMP_CLEAR_VECT);

So this sends an IPI to the current CPU. What guarantees that the
pending interrupt is handled _before_ the IPI is handled again?

> +			continue;
> +		}
> +		list_del(&adata->entry);
> +		irq_matrix_free(loongarch_avec.vector_matrix, cpu, vector, false);
> +		this_cpu_ptr(irq_map)[vector] = 0;

s/0/NULL/ as this writes a pointer.

                this_cpu_write(irq_map.irqd[vector], NULL);

avoids the whole pointer indirection.

> +		kfree(adata);

Again this won't work with PREEMPT_RT.

> +	}
> +	raw_spin_unlock(&loongarch_avec.lock);
> +}
> +
> +static void loongarch_avec_dispatch(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct irq_data *d;
> +	unsigned long vector;
> +
> +	chained_irq_enter(chip, desc);
> +	vector = csr_read64(LOONGARCH_CSR_ILR);
> +	if (vector & 0x80000000)

No magic numbers. Please use proper constant defines.

> +		return;
> +
> +	vector &= 0xff;

Ditto.

> +
> +	d = raw_cpu_ptr(irq_map)[vector];

Why raw?

        d = __this_cpu_read(...);

Also, what is the point of storing irqdata in the irq_map if the only
thing you use is d->irq. You can simply store the interrupt number, no?

If you want to spare cycles for the lookup, then you want to store the
interrupt descriptor like x86 does.

> +	if (d)
> +		generic_handle_irq(d->irq);
> +	else
> +		pr_warn("IRQ ERROR:Unexpected irq  occur on cpu %d[vector %d]\n",
> +				smp_processor_id(), vector);

See bracket rules in the tip documentation.

> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int loongarch_avec_alloc(struct irq_domain *domain, unsigned int virq,
> +		unsigned int nr_irqs, void *arg)
> +{
> +	struct loongarch_avec_data *adata;
> +	struct irq_data *irqd;
> +	unsigned int cpu, vector;
> +	unsigned long flags;
> +	int i, err;

See variable declaration rules in the tip documentation

> +	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
> +	for (i = 0; i < nr_irqs; i++) {
> +		irqd = irq_domain_get_irq_data(domain, virq + i);
> +		adata = kzalloc(sizeof(*adata), GFP_KERNEL);
> +		if (!adata) {
> +			raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +			return -ENOMEM;
> +		}
> +		err = assign_irq_vector(irqd, cpu_online_mask, &cpu, &vector);
> +		if (err) {
> +			raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +			return err;
> +		}
> +		adata->prev_cpu = adata->cpu = cpu;
> +		adata->prev_vec = adata->vec = vector;
> +
> +		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irqd;

This needs to be set last, no?

> +		irq_domain_set_info(domain, virq + i, virq, &loongarch_avec_controller,
> +				adata, handle_edge_irq, NULL, NULL);
> +		irqd_set_single_target(irqd);
> +		irqd_set_affinity_on_activate(irqd);
> +	}
> +	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +
> +	return err;
> +}
> +
> +static void loongarch_avec_free(struct irq_domain *domain, unsigned int virq,
> +		unsigned int nr_irqs)
> +{
> +	struct loongarch_avec_data *adata;
> +	struct irq_data *d;
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
> +	for (i = 0; i < nr_irqs; i++) {
> +		d = irq_domain_get_irq_data(domain, virq + i);
> +		adata = irq_data_get_irq_chip_data(d);
> +		if (d) {
> +			irq_matrix_free(loongarch_avec.vector_matrix,
> +					adata->cpu,
> +					adata->vec, false);
> +			irq_domain_reset_irq_data(d);
> +		}

What cleans up the irq_map and pending cleanups? There is a UAF waiting
around the corner.

> +	}
> +
> +	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +}

> +static int __init loongarch_avec_init(struct irq_domain *parent)
> +{
> +	int ret = 0, parent_irq;
> +	unsigned long tmp;
> +
> +	tmp = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
> +	tmp |= IOCSR_MISC_FUNC_AVEC_EN;
> +	iocsr_write64(tmp, LOONGARCH_IOCSR_MISC_FUNC);

Enabling AVEC _before_ everything is set up is a patently bad idea.

> +	raw_spin_lock_init(&loongarch_avec.lock);
> +
> +	loongarch_avec.fwnode = irq_domain_alloc_named_fwnode("CORE_AVEC");
> +	if (!loongarch_avec.fwnode) {
> +		pr_err("Unable to allocate domain handle\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	loongarch_avec.domain = irq_domain_create_tree(loongarch_avec.fwnode,
> +			&loongarch_avec_domain_ops, NULL);
> +	if (!loongarch_avec.domain) {
> +		pr_err("core-vec: cannot create IRQ domain\n");
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
> +	irq_set_chained_handler_and_data(parent_irq, loongarch_avec_dispatch, NULL);
> +
> +	ret = irq_matrix_init();
> +	if (ret) {
> +		pr_err("Failed to init irq matrix\n");
> +		goto out_free_matrix;
> +	}
> +
> +	return ret;
> +
> +out_free_matrix:
> +	kfree(loongarch_avec.vector_matrix);
> +out_remove_domain:
> +	irq_domain_remove(loongarch_avec.domain);
> +out_free_handle:
> +	irq_domain_free_fwnode(loongarch_avec.fwnode);
> +out:
> +	return ret;
> +}
> +
> +static int loongarch_avec_offline_cpu(unsigned int cpu)
> +{
> +	unsigned long flags;
> +	struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
> +
> +	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
> +	if (list_empty(&plist->head)) {
> +		irq_matrix_offline(loongarch_avec.vector_matrix);
> +	} else {
> +		pr_warn("cpu %d advanced extioi is busy\n");
> +		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +		return -EBUSY;
> +	}
> +	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +	return 0;
> +}
> +
> +static int loongarch_avec_online_cpu(unsigned int cpu)
> +{
> +	struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
> +
> +	irq_matrix_online(loongarch_avec.vector_matrix);
> +
> +	INIT_LIST_HEAD(&plist->head);
> +
> +	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
> +	return 0;
> +}
> +#if defined(CONFIG_ACPI)

Missing newline before #if and also please use #ifdef CONFIG_ACPI

> +static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
> +		const unsigned long end)
> +{
> +	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
> +
> +	msi_base_v2 = pchmsi_entry->msg_address;
> +	return pch_msi_acpi_init_v2(loongarch_avec.domain, pchmsi_entry);
> +}
> +
> +static inline int __init acpi_cascade_irqdomain_init(void)
> +{
> +	return acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
> +}
> +
> +int __init loongarch_avec_acpi_init(struct irq_domain *parent)
> +{
> +	int ret = 0;
> +
> +	ret = loongarch_avec_init(parent);
> +	if (ret) {
> +		pr_err("Failed to init irq domain\n");
> +		return ret;
> +	}
> +
> +	ret = acpi_cascade_irqdomain_init();
> +	if (ret) {
> +		pr_err("Failed to cascade IRQ domain\n");
> +		return ret;
> +	}
> +
> +	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +			"loongarch_avec:online",
> +			loongarch_avec_online_cpu, loongarch_avec_offline_cpu);

You cannot online/offline the matrix and handle eventually pending
cleanups from a CPUHP_AP_ONLINE_DYN state. That needs to happen in the
STARTING section between CPUHP_AP_OFFLINE and CPUHP_AP_ONLINE

> +	if (ret < 0) {
> +		pr_err("loongarch_avec: failed to register hotplug callbacks.\n");
> +		return ret;
> +	}
> +
> +	return ret;

So if CONFIG_ACPI is disabled then loongarch_avec_init() is unused and
results in a defined but not used build warning...

> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
> index 6e1e1f011bb2..d1706080b4f4 100644
> --- a/drivers/irqchip/irq-loongson-pch-msi.c
> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
> @@ -16,7 +16,6 @@
>  #include <linux/slab.h>
>  
>  static int nr_pics;
> -
>  struct pch_msi_data {
>  	struct mutex	msi_map_lock;
>  	phys_addr_t	doorbell;
> @@ -100,6 +99,17 @@ static struct irq_chip middle_irq_chip = {
>  	.irq_compose_msi_msg	= pch_msi_compose_msi_msg,
>  };
>  
> +static struct irq_chip pch_msi_irq_chip_v2 = {
> +	.name			= "MSI",
> +	.irq_ack		= irq_chip_ack_parent,
> +};
> +
> +static struct msi_domain_info pch_msi_domain_info_v2 = {
> +	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
> +	.chip	= &pch_msi_irq_chip_v2,
> +};
> +
>  static int pch_msi_parent_domain_alloc(struct irq_domain *domain,
>  					unsigned int virq, int hwirq)
>  {
> @@ -268,6 +278,9 @@ struct fwnode_handle *get_pch_msi_handle(int pci_segment)
>  {
>  	int i;
>  
> +	if (cpu_has_avecint)
> +		return pch_msi_handle[0];
> +
>  	for (i = 0; i < MAX_IO_PICS; i++) {
>  		if (msi_group[i].pci_segment == pci_segment)
>  			return pch_msi_handle[i];
> @@ -289,4 +302,34 @@ int __init pch_msi_acpi_init(struct irq_domain *parent,
>  
>  	return ret;
>  }
> +
> +int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
> +		struct acpi_madt_msi_pic *msi_entry)
> +{
> +	struct irq_domain *msi_domain;
> +
> +	if (pch_msi_handle[0])
> +		return 0;
> +
> +	pch_msi_handle[0] = irq_domain_alloc_named_fwnode("msipic-v2");
> +	if (!pch_msi_handle[0]) {
> +		pr_err("Unable to allocate domain handle\n");
> +		kfree(pch_msi_handle[0]);
> +		return -ENOMEM;
> +	}
> +
> +	msi_domain = pci_msi_create_irq_domain(pch_msi_handle[0],
> +			&pch_msi_domain_info_v2,
> +			parent);
> +	if (!msi_domain) {
> +		pr_err("Failed to create PCI MSI domain\n");
> +		kfree(pch_msi_handle[0]);
> +		return -ENOMEM;
> +	}
> +
> +	pr_info("IRQ domain MSIPIC-V2 init done.\n");
> +	return 0;
> +}
> +
> +

Stray newlines. But as with the other CONFIG_ACPI part above a build
with CONFIG_ACPI=n will result in defined but not used warnings ....

Thanks,

        tglx

