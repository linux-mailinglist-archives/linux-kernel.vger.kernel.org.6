Return-Path: <linux-kernel+bounces-264147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0BC93DF7F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72361B212AC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443AD145B24;
	Sat, 27 Jul 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0wRmuSSw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CT0kvH76"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F925145B16
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722085843; cv=none; b=gmdrGFj2W+QBdBPhlEkme1PHieiQawIj4ZFYDXj0Bew58p/QgGZcTXHj1lkDbPBGISpJPp5Vq1MlViJMxQCxoELnOdUjHTwfInN8jptsKnXQPARnsSUX5xDMTg3tJsj86xuh8q41GBDmHQaxjwLM7SD2mg85xwT2P1Zkb96Ntxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722085843; c=relaxed/simple;
	bh=8LcZwIcVxLX8DJKUcg1J6hk7v9u1J4PLkxdT9Najpm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GA6D7gw56bZiYF0WDqurLppQaDSq9arh8M2Hj0D8sMIWRKC83YxGHcmj5VOFAWCr2ocyJlW7vkHHPM8Qq8xEUrQtbLgE4ENuKiv1s/n6mYdoAcFiLk6Vdf7Pa9yxXQJ+hfATzlED+a6Fi9thbMIM5LuCAbo+wQE5YK3kyCgSFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0wRmuSSw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CT0kvH76; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722085839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mFCsmtjcKjYimExJfHjihgppXboAjDYfec4GDPTKq7Q=;
	b=0wRmuSSwRutDRsxEC/cMiwN2GspF0GTWCoWEw8lngdKKGOk6w8axvtUG6+HBaqcLSHn5u7
	/depEL+4Q7o+SnaZQa10/OTagqj6eXaRgN1h/v7nyA0SxfSUy8NibO+muIN6Tz8SpA9aVL
	Yct8v4YZ+ndRMgHlwgzCjKRybnnAhsBGDu0kR3ZDk7guPErX/zqi0t7B/ncLeDNWsbAZ8E
	mzcVNSiEylAq9cengM2p/1olUhXjiOPld+YWuKTtn/q2tfPHE6gDctUrxTvGF/wtLfc9e9
	2KHwbJ4mc7WPEJthYdlYVPx1Q7BP9hNQfAK/SQ7fN1EFRh0PecWm1D/eb/pJGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722085839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mFCsmtjcKjYimExJfHjihgppXboAjDYfec4GDPTKq7Q=;
	b=CT0kvH76maB/M6JxqTgbglVUD/REcWHP8vkDqGR6ZUVTxfwU4L3phivBF81C7JGcFUJN+7
	JpEueHBnLRH2YbDw==
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Vincent Chardon
 <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH v3 19/37] irqchip: Add irq-kvx-apic-gic driver
In-Reply-To: <20240722094226.21602-20-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-20-ysionneau@kalrayinc.com>
Date: Sat, 27 Jul 2024 15:10:38 +0200
Message-ID: <87wml7t1yp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yann!

On Mon, Jul 22 2024 at 11:41, ysionneau@kalrayinc.com wrote:
> +
> +/**
> + * For each CPU, there is 4 output lines coming from the apic GIC.
> + * We only use 1 line and this structure represent this line.
> + * @base Output line base address
> + * @cpu CPU associated to this line

This is not valid kernel doc. 

> + */
> +struct gic_out_irq_line {
> +	void __iomem *base;
> +	unsigned int cpu;
> +};

Please read

       https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

which contains coding style information. Fix it up all over the place.

> +struct gic_in_irq_line {
> +	bool enabled;
> +	struct gic_out_irq_line *out_line;
> +	unsigned int it_num;
> +};

Please use proper ordering so that you don't have gaps in the
structure. pahole helps you to look at that.

> +/**
> + * Enable/Disable an output irq line
> + * This function is used by both mask/unmask to disable/enable the line.

Again invalid kernel doc

> + */
> +static void irq_line_set_enable(struct gic_out_irq_line *irq_line,
> +				struct gic_in_irq_line *in_irq_line,
> +				int enable)

bool enable or 'u8 val' and then supply the proper constants from the
call sites: LINE_ENABLE, LINE_DISABLE or such.

> +{
> +	void __iomem *enable_line_addr = irq_line->base +
> +	       KVX_GIC_ENABLE_OFFSET +
> +	       in_irq_line->it_num * KVX_GIC_ENABLE_ELEM_SIZE;

This is really unreadable.

	void __iomem *enable_line_addr = irq_line->base + KVX_GIC_ENABLE_OFFSET +
					 in_irq_line->it_num * KVX_GIC_ENABLE_ELEM_SIZE;

Also line->it_num is only used here, so you can do the multiplication at
the site which initializes 'line', no?

> +	writeb((uint8_t) enable ? 1 : 0, enable_line_addr);

The above spares you the typecast and please use 'u8' and friends for
kernel code.

> +	in_irq_line->enabled = enable;
> +}
> +
> +static void kvx_apic_gic_set_line(struct irq_data *data, int enable)
> +{
> +	struct kvx_apic_gic *gic = irq_data_get_irq_chip_data(data);
> +	unsigned int in_irq = irqd_to_hwirq(data);
> +	struct gic_in_irq_line *in_line = &gic->input_irq[in_irq];
> +	struct gic_out_irq_line *out_line = in_line->out_line;
> +
> +	raw_spin_lock(&gic->lock);

Please use guard() 

> +	/* Set line enable on currently assigned cpu */
> +	irq_line_set_enable(out_line, in_line, enable);
> +	raw_spin_unlock(&gic->lock);
> +}
> +
> +static void kvx_apic_gic_mask(struct irq_data *data)
> +{
> +	kvx_apic_gic_set_line(data, 0);
> +}
> +
> +static void kvx_apic_gic_unmask(struct irq_data *data)
> +{
> +	kvx_apic_gic_set_line(data, 1);
> +}
> +
> +#ifdef CONFIG_SMP
> +
> +static int kvx_apic_gic_set_affinity(struct irq_data *d,
> +				     const struct cpumask *cpumask,
> +				     bool force)
> +{
> +	struct kvx_apic_gic *gic = irq_data_get_irq_chip_data(d);
> +	unsigned int new_cpu;
> +	unsigned int hw_irq = irqd_to_hwirq(d);
> +	struct gic_in_irq_line *input_line = &gic->input_irq[hw_irq];
> +	struct gic_out_irq_line *new_out_line;
> +
> +	/* We assume there is only one cpu in the mask */

That's an invalid assumption. The mask can contain multiple CPUs. It's a
different story whether you select a single target CPU in your code.

> +	new_cpu = cpumask_first(cpumask);

Also cpumask_first() is wrong as the mask can contain offline CPUs. You
want to use cpumask_any_and(mask, cpu_online_mask) or such.

That still has the problem that this will select the first CPU for all
interrupts by default, so on boot you end up with all interrupts on
CPU0. You might want to use something like cpumask_pick_least_loaded().

> +	new_out_line = &gic->output_irq[new_cpu];
> +
> +	raw_spin_lock(&gic->lock);
> +
> +	/* Nothing to do, line is the same */
> +	if (new_out_line == input_line->out_line)
> +		goto out;
> +
> +	/* If old line was enabled, enable the new one before disabling
> +	 * the old one
> +	 */
> +	if (input_line->enabled)
> +		irq_line_set_enable(new_out_line, input_line, 1);
> +
> +	/* Disable it on old line */
> +	irq_line_set_enable(input_line->out_line, input_line, 0);
> +
> +	/* Assign new output line to input IRQ */
> +	input_line->out_line = new_out_line;
> +
> +out:
> +	raw_spin_unlock(&gic->lock);

        scoped_guard(raw_spinlock)(&gic->lock) {
                if (outline != input_line->out_line) {
                   	.....
                }
        }

which spares the goto and has a well defined scope.

> +	irq_data_update_effective_affinity(d, cpumask_of(new_cpu));
> +
> +	return IRQ_SET_MASK_OK;
> +}
> +#endif
> +
> +static struct irq_chip kvx_apic_gic_chip = {
> +	.name           = "kvx apic gic",
> +	.irq_mask	= kvx_apic_gic_mask,
> +	.irq_unmask	= kvx_apic_gic_unmask,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity = kvx_apic_gic_set_affinity,
> +#endif
> +};
> +
> +static int kvx_apic_gic_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *args)
> +{
> +	int i;
> +	struct irq_fwspec *fwspec = args;
> +	int hwirq = fwspec->param[0];
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &kvx_apic_gic_chip,
> +				    domain->host_data, handle_simple_irq,
> +				    NULL, NULL);

Please use the full 100 character width.

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops kvx_apic_gic_domain_ops = {
> +	.alloc  = kvx_apic_gic_alloc,
> +	.free   = irq_domain_free_irqs_common,
> +};
> +
> +static void irq_line_get_status_lac(struct gic_out_irq_line *out_irq_line,
> +			uint64_t status[KVX_GIC_STATUS_LAC_ARRAY_SIZE])
> +{
> +	int i;
> +
> +	for (i = 0; i < KVX_GIC_STATUS_LAC_ARRAY_SIZE; i++) {
> +		status[i] = readq(out_irq_line->base +
> +				  KVX_GIC_STATUS_LAC_OFFSET +
> +				  i * KVX_GIC_STATUS_LAC_ELEM_SIZE);
> +	}
> +}
> +
> +static void kvx_apic_gic_handle_irq(struct irq_desc *desc)
> +{
> +	struct kvx_apic_gic *gic_data = irq_desc_get_handler_data(desc);
> +	struct gic_out_irq_line *out_line;
> +	uint64_t status[KVX_GIC_STATUS_LAC_ARRAY_SIZE];
> +	unsigned long irqn, cascade_irq;
> +	unsigned long cpu = smp_processor_id();
> +
> +	out_line = &gic_data->output_irq[cpu];
> +
> +	irq_line_get_status_lac(out_line, status);
> +
> +	for_each_set_bit(irqn, (unsigned long *) status,
> +			KVX_GIC_STATUS_LAC_ARRAY_SIZE * BITS_PER_LONG) {

  sizeof(status) * 8 ?

> +
> +		cascade_irq = irq_find_mapping(gic_data->domain, irqn);
> +
> +		generic_handle_irq(cascade_irq);
> +	}
> +}
> +
> +static void __init apic_gic_init(struct kvx_apic_gic *gic)
> +{
> +	unsigned int cpu, line;
> +	struct gic_in_irq_line *input_irq_line;
> +	struct gic_out_irq_line *output_irq_line;
> +	uint64_t status[KVX_GIC_STATUS_LAC_ARRAY_SIZE];
> +
> +	/* Initialize all input lines (device -> )*/
> +	for (line = 0; line < KVX_GIC_INPUT_IT_COUNT; line++) {
> +		input_irq_line = &gic->input_irq[line];
> +		input_irq_line->enabled = false;
> +		/* All input lines map on output 0 */
> +		input_irq_line->out_line = &gic->output_irq[0];
> +		input_irq_line->it_num = line;
> +	}
> +
> +	/* Clear all output lines (-> cpus) */
> +	for (cpu = 0; cpu < KVX_GIC_OUTPUT_IT_COUNT; cpu++) {
> +		output_irq_line = &gic->output_irq[cpu];
> +		output_irq_line->cpu = cpu;
> +		output_irq_line->base = gic->base +
> +			cpu * (KVX_GIC_ELEM_SIZE * KVX_GIC_PER_CPU_IT_COUNT);
> +
> +		/* Disable all external lines on this core */
> +		for (line = 0; line < KVX_GIC_INPUT_IT_COUNT; line++)
> +			irq_line_set_enable(output_irq_line,
> +					&gic->input_irq[line], 0x0);

See bracket rules

> +		irq_line_get_status_lac(output_irq_line, status);
> +	}
> +}

A general observation. I understand that you want to use self
explanatory variable names, but some of them are really overdone for my
taste.

Thanks,

        tglx

