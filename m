Return-Path: <linux-kernel+bounces-264152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D7993DF8B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5161F21A9F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7BA16E865;
	Sat, 27 Jul 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJbbYJv/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wMgseHst"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6816D32C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722087335; cv=none; b=eYys1BwItmjzcn2fiyse3omY1JgcdHZfeUcDnMdcqA+/0bjbhoHJyOv0YjiGJQXCddsdwxyj04F90s1Cl67NWlbPBr2hv1dO5SpPV+vxiQwfFqqBRFK+/6JNizcTt8bldKpnuQk45Df8UWsgsdxPDAbXxQajwP+6RewMwoBjcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722087335; c=relaxed/simple;
	bh=PXRc8F2qPgjfG1DwN2Unj+ehVfpkBvCx3g+UxoMOi1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cdBPuOXyJ/Q/BvnAMDFpZK5aqVEnha92h0a+cENjpIaa4M5kjnzRttaan37QpXvINv2xNFgg03D0I19QeDldxRk3Hutn0h7o+rXG+WqHpLW16MqlHp2cZ9oDBJ7wd3dy4hLH7VsuqpeIahVCfQD7CCizXJWD9LUTMRPi1wUuSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJbbYJv/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wMgseHst; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722087330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bf72eihUAjt1FUhNpLvLF0Nk4v+m69dtaHeNP2FNVM0=;
	b=jJbbYJv/XA2lVXasnKhUtJwCrDwOCCkS7kMMOziqb1QT+a1Keh6bfji/tUFoUtWIJYHF4L
	dDQjSDGlqG6yVmMNJOJf/P/fHFxDiJdE8NQDxRpTJuEMUqBqonKQjkC+uzBMhHa5XesdJV
	RLLcD4Sfloa12HtWHAFM8moVPFbrf0QJiCYu4P6IniACdho81+NMBcNUSnv4I6LXHgz/b8
	2FX6zBmkegHdhoM430BTKFxHtbko+FGpTUWzqi90HK7SvFzshlr1OenaPhSevwgfiWWDeC
	/nhA7rgz+IvcZQvXdQlrqru7rFKvuIA6hXwQgBQJiEfdruCorRsJ0E3CK/f2fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722087330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bf72eihUAjt1FUhNpLvLF0Nk4v+m69dtaHeNP2FNVM0=;
	b=wMgseHstAPTBZJ7LSMckUq0YZx7G1qtvAfmdJuye+K5md5PWcQBcvgDO+BUD7/VezaK85+
	GnlVnMuypXwB6/BA==
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Jules Maselbas <jmaselbas@zdiv.net>, Luc
 Michel <luc@lmichel.fr>
Subject: Re: [RFC PATCH v3 21/37] irqchip: Add irq-kvx-apic-mailbox driver
In-Reply-To: <20240722094226.21602-22-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-22-ysionneau@kalrayinc.com>
Date: Sat, 27 Jul 2024 15:35:29 +0200
Message-ID: <87r0bft0ta.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 22 2024 at 11:41, ysionneau@kalrayinc.com wrote:
> +/**
> + * struct kvx_apic_mailbox - kvx apic mailbox
> + * @base: base address of the controller
> + * @device_domain: IRQ device domain for mailboxes
> + * @msi_domain: platform MSI domain for MSI interface
> + * @domain_info: Domain information needed for the MSI domain
> + * @mb_count: Count of mailboxes we are handling
> + * @available: bitmap of availables bits in mailboxes
> + * @mailboxes_lock: lock for irq migration
> + * @mask_lock: lock for irq masking
> + * @mb_data: data associated to each mailbox
> + */
> +struct kvx_apic_mailbox {
> +	void __iomem *base;
> +	phys_addr_t phys_base;
> +	struct irq_domain *device_domain;
> +	struct irq_domain *msi_domain;
> +	struct msi_domain_info domain_info;
> +	/* Start and count of device mailboxes */

Please put the relevant information into the kernel doc above.

> +	unsigned int mb_count;
> +	/* Bitmap of allocated bits in mailboxes */

and refrain from contradicting information. What is this bitmap for:

    available bits as claimed above or allocated bits as claimed here?

If the latter then the name 'available' is just wrong.

> +	DECLARE_BITMAP(available, MAILBOXES_MAX_BIT_COUNT);

> +static void kvx_mailbox_set_irq_enable(struct irq_data *data,
> +				     bool enabled)
> +{
> +	struct kvx_irq_data *kd = irq_data_get_irq_chip_data(data);
> +	struct kvx_apic_mailbox *mb = kd->mb;
> +	unsigned int mb_num, mb_bit;
> +	void __iomem *mb_addr;
> +	u64 mask_value, mb_value;
> +
> +	kvx_mailbox_get_from_hwirq(irqd_to_hwirq(data), &mb_num, &mb_bit);
> +	mb_addr = kvx_mailbox_get_addr(mb, mb_num);
> +
> +	raw_spin_lock(&mb->mask_lock);

  guard()

> +	mask_value = readq(mb_addr + KVX_MAILBOX_MASK_OFFSET);
> +	if (enabled)
> +		mask_value |= BIT_ULL(mb_bit);
> +	else
> +		mask_value &= ~BIT_ULL(mb_bit);
> +
> +	writeq(mask_value, mb_addr + KVX_MAILBOX_MASK_OFFSET);
> +
> +	raw_spin_unlock(&mb->mask_lock);
> +
> +	/**

No kernel doc opener on regular comments please.

> +	 * Since interrupts on mailboxes are edge triggered and are only
> +	 * triggered when writing the value, we need to trigger it manually
> +	 * after updating the mask if enabled. If the interrupt was triggered by
> +	 * the device just after the mask write, we can trigger a spurious
> +	 * interrupt but that is still better than missing one...
> +	 * Moreover, the mailbox is configured in OR mode which means that even
> +	 * if we write a single bit, all other bits will be kept intact.
> +	 */
> +	if (enabled) {
> +		mb_value = readq(mb_addr + KVX_MAILBOX_VALUE_OFFSET);
> +		if (mb_value & BIT_ULL(mb_bit))
> +			writeq(BIT_ULL(mb_bit),
> +			       mb_addr + KVX_MAILBOX_VALUE_OFFSET);
> +	}
> +}

> +static void kvx_mailbox_free_bit(struct kvx_apic_mailbox *mb, int hw_irq)
> +{
> +	unsigned int mb_num, mb_bit;
> +
> +	kvx_mailbox_get_from_hwirq(hw_irq, &mb_num, &mb_bit);
> +	bitmap_clear(mb->available, hw_irq, 1);
> +
> +	/* If there is no more IRQ on this mailbox, reset it to CPU 0 */
> +	if (mb->available[mb_num] == 0)
> +		kvx_mailbox_set_cpu(mb, mb_num, 0);
> +}
> +
> +struct irq_chip kvx_apic_mailbox_irq_chip = {
> +	.name = "kvx apic mailbox",
> +	.irq_compose_msi_msg = kvx_mailbox_msi_compose_msg,
> +	.irq_mask = kvx_mailbox_mask,
> +	.irq_unmask = kvx_mailbox_unmask,
> +};
> +
> +static int kvx_mailbox_allocate_bits(struct kvx_apic_mailbox *mb, int num_req)
> +{
> +	int first, align_mask = 0;
> +
> +	/* This must be a power of 2 for bitmap_find_next_zero_area to work */
> +	BUILD_BUG_ON((MAILBOXES_BITS_PER_PAGE & (MAILBOXES_BITS_PER_PAGE - 1)));
> +
> +	/*
> +	 * If user requested more than 1 mailbox, we must make sure it will be
> +	 * aligned on a page size for iommu_dma_prepare_msi to be correctly
> +	 * mapped in a single page.
> +	 */
> +	if (num_req > 1)
> +		align_mask = (MAILBOXES_BITS_PER_PAGE - 1);
> +
> +	spin_lock(&mb->mailboxes_lock);

  guard()

> +	first = bitmap_find_next_zero_area(mb->available,
> +			mb->mb_count * MAILBOXES_BIT_SIZE, 0,
> +			num_req, align_mask);
> +	if (first >= MAILBOXES_MAX_BIT_COUNT) {
> +		spin_unlock(&mb->mailboxes_lock);
> +		return -ENOSPC;
> +	}
> +
> +	bitmap_set(mb->available, first, num_req);
> +
> +	spin_unlock(&mb->mailboxes_lock);
> +
> +	return first;
> +}
> +
> +static int kvx_apic_mailbox_msi_alloc(struct irq_domain *domain,
> +				      unsigned int virq,
> +				      unsigned int nr_irqs, void *args)
> +{
> +	int i, err;
> +	int hwirq = 0;
> +	u64 mb_addr;
> +	struct irq_data *d;
> +	struct kvx_irq_data *kd;
> +	struct kvx_apic_mailbox *mb = domain->host_data;
> +	struct msi_alloc_info *msi_info = (struct msi_alloc_info *)args;
> +	struct msi_desc *desc = msi_info->desc;
> +	unsigned int mb_num, mb_bit;
> +
> +	/* We will not be able to guarantee page alignment ! */
> +	if (nr_irqs > MAILBOXES_BITS_PER_PAGE)
> +		return -EINVAL;
> +
> +	hwirq = kvx_mailbox_allocate_bits(mb, nr_irqs);
> +	if (hwirq < 0)
> +		return hwirq;
> +
> +	kvx_mailbox_get_from_hwirq(hwirq, &mb_num, &mb_bit);
> +	mb_addr = (u64) kvx_mailbox_get_phys_addr(mb, mb_num);
> +	err = iommu_dma_prepare_msi(desc, mb_addr);
> +	if (err)
> +		goto free_mb_bits;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		kd = kmalloc(sizeof(*kd), GFP_KERNEL);
> +		if (!kd) {
> +			err = -ENOMEM;
> +			goto free_irq_data;
> +		}
> +
> +		kd->mb = mb;
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &kvx_apic_mailbox_irq_chip,
> +				    kd, handle_simple_irq,
> +				    NULL, NULL);
> +	}
> +
> +	return 0;
> +
> +free_irq_data:
> +	for (i--; i >= 0; i--) {
> +		d = irq_domain_get_irq_data(domain, virq + i);
> +		kd = irq_data_get_irq_chip_data(d);
> +		kfree(kd);
> +	}
> +
> +free_mb_bits:
> +	spin_lock(&mb->mailboxes_lock);
> +	bitmap_clear(mb->available, hwirq, nr_irqs);
> +	spin_unlock(&mb->mailboxes_lock);

kvx_mailbox_free_bit() does some magic vs. the mailbox and reset to
CPU0. Why is this not required here?

> +	return err;
> +}
> +
> +
> +static void __init
> +apic_mailbox_reset(struct kvx_apic_mailbox *mb)

Pointless line break. Please get rid of all of them.

> +{
> +	unsigned int i;
> +	unsigned int mb_end = mb->mb_count;
> +	void __iomem *mb_addr;
> +	u64 funct_val = (KVX_MAILBOX_MODE_OR << KVX_MAILBOX_FUNCT_MODE_SHIFT) |
> +		(KVX_MAILBOX_TRIG_DOORBELL << KVX_MAILBOX_FUNCT_TRIG_SHIFT);
> +
> +	for (i = 0; i < mb_end; i++) {
> +		mb_addr = kvx_mailbox_get_addr(mb, i);
> +		/* Disable all interrupts */
> +		writeq(0ULL, mb_addr + KVX_MAILBOX_MASK_OFFSET);
> +		/* Set mailbox to OR mode + trigger */
> +		writeq(funct_val, mb_addr + KVX_MAILBOX_FUNCT_OFFSET);
> +		/* Load & Clear mailbox value */
> +		readq(mb_addr + KVX_MAILBOX_LAC_OFFSET);
> +	}
> +}
> +
> +static struct msi_domain_ops kvx_msi_domain_ops = {
> +};
> +
> +static struct msi_domain_info kvx_msi_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
> +	.ops	= &kvx_msi_domain_ops,
> +	.chip	= &kvx_msi_irq_chip,
> +};
> +
> +static int __init
> +kvx_init_apic_mailbox(struct device_node *node,
> +		      struct device_node *parent)
> +{
> +	struct kvx_apic_mailbox *mb;
> +	unsigned int parent_irq, irq_count;
> +	struct resource res;
> +	int ret, i;
> +
> +	mb = kzalloc(sizeof(*mb), GFP_KERNEL);
> +	if (!mb)
> +		return -ENOMEM;
> +
> +	ret = of_address_to_resource(node, 0, &res);
> +	if (ret)
> +		return -EINVAL;
> +
> +	mb->phys_base = res.start;
> +	mb->base = of_io_request_and_map(node, 0, node->name);
> +	if (!mb->base) {
> +		ret = -EINVAL;
> +		goto err_kfree;
> +	}
> +
> +	spin_lock_init(&mb->mailboxes_lock);
> +	raw_spin_lock_init(&mb->mask_lock);
> +
> +	irq_count = of_irq_count(node);
> +	if (irq_count == 0 || irq_count > MAILBOXES_MAX_COUNT) {
> +		ret = -EINVAL;
> +		goto err_kfree;
> +	}
> +	mb->mb_count = irq_count;
> +
> +	apic_mailbox_reset(mb);
> +
> +	mb->device_domain = irq_domain_add_tree(node,
> +						&kvx_apic_mailbox_domain_ops,
> +						mb);
> +	if (!mb->device_domain) {
> +		pr_err("Failed to setup device domain\n");
> +		ret = -EINVAL;
> +		goto err_iounmap;
> +	}
> +
> +	mb->msi_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
> +						     &kvx_msi_domain_info,
> +						     mb->device_domain);

Function does not exist anymore.

> +	if (!mb->msi_domain) {
> +		ret = -EINVAL;
> +		goto err_irq_domain_add_tree;
> +	}

Thanks,

        tglx

