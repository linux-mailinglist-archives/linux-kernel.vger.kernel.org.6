Return-Path: <linux-kernel+bounces-264149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB73893DF85
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB92282427
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D715666A;
	Sat, 27 Jul 2024 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWRz/nh9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rttw5g6z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC414A05
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722086303; cv=none; b=mWPn+9anS0bJUcESo7F0eyUQcox9QqwyJAg8JoYQ1en3m4m82ix7Qm0YYaeeK5zEBt08HMP1HYWOPAm1H+LWv4Wbhu2j2g4JUyrgMpwGWugOcMK1LEyYlN3Zx72kcMO9sxh/fo5wrc4MNfz2RMyh1iTZvMeQLIqZHJjtouy8mOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722086303; c=relaxed/simple;
	bh=CRo33d3+IlgOwgsl/An+cSbRS/RYy8uzvzF8IlC5E5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BkpvD4AmOQ/3tTYsQ2tZ/M7VsQ37hGAyPPH0xaMTMDIEcDcA6yHnMc/KnFCPZKdKg9ZfD3c4zaVsDp4Xci0j+bn/IHEYGKLXHoT1fDurnEGH4is/gJKd5zXzSutrpoTxBB5dNudqTiwRp3H5iZjS47r79Amhx6U3Wu1rTt6vA3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pWRz/nh9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rttw5g6z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722086300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEKPvWNF26FpZqYKEbY/3mMMPQLgcFsKgxOO0cpAK2k=;
	b=pWRz/nh96iQ6qAFbysZJvPpkgVztzKcaRy5d7RNKuxyfqf0XYp7k5sN4sTdtTTvOQke+cQ
	b3Mh0pXDiwKVS/Z5Me0pzp7CdnSja3Y75//fgfMS29v2H3c/uB+nsNSBGBZ8e9wmFFfRjt
	NTUnkB2Vx01hYPxDGgOPMFo3mt+YwJLxZx3jM47v+JJ105Mv5iRCoDxoLIsQoxaFMojj/N
	7jAwY0bq+ivXxdJKpDDId3QYEz1TE2HkHWg7tLp0QM7vGD9KW7YBi031Pr4GGuJkXXoWm3
	6Ol9NxB6EGQg9OwITiLaiXmXyaKoMa+Aegf9XE8PnFxil52sGp3mqgVecxJm/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722086300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GEKPvWNF26FpZqYKEbY/3mMMPQLgcFsKgxOO0cpAK2k=;
	b=rttw5g6zoRHss2u4A3uhSHOQvo9zfmOhcQ9gVPmptYqBPm+uE9YaAynTPRxWByR/L9dkWN
	XCXWhl4B+iULnWBQ==
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Vincent Chardon
 <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH v3 20/37] irqchip: Add irq-kvx-itgen driver
In-Reply-To: <20240722094226.21602-21-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-21-ysionneau@kalrayinc.com>
Date: Sat, 27 Jul 2024 15:18:19 +0200
Message-ID: <87ttgbt1lw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 22 2024 at 11:41, ysionneau@kalrayinc.com wrote:
> +
> +static void kvx_itgen_mask(struct irq_data *data)
> +{
> +	kvx_itgen_enable(data, 0x0);
> +	irq_chip_mask_parent(data);
> +}
> +
> +static void kvx_itgen_unmask(struct irq_data *data)
> +{
> +	kvx_itgen_enable(data, 0x1);
> +	irq_chip_unmask_parent(data);

The ordering is asymmetric vs. mask().

> +#define ITGEN_UNSUPPORTED_TYPES (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)
> +
> +static int kvx_itgen_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *args)
> +{
> +	int i, err;
> +	struct irq_fwspec *fwspec = args;
> +	int hwirq = fwspec->param[0];
> +	int type = IRQ_TYPE_NONE;
> +	struct kvx_itgen *itgen;
> +
> +	if (fwspec->param_count >= 2)
> +		type = fwspec->param[1];
> +
> +	WARN_ON(type & ITGEN_UNSUPPORTED_TYPES);

So you warn here and then continue without fixing type up?

> +	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);

This function is gone as of 6.11-rc1. Please convert to parent MSI domain.

> +	if (err)
> +		return err;
> +

> +static void kvx_itgen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct irq_data *d = irq_get_irq_data(desc->irq);
> +	struct kvx_itgen *itgen = irq_data_get_irq_chip_data(d);
> +	uint32_t cfg_val = 0;
> +	uintptr_t dest_addr = ((uint64_t) msg->address_hi << 32) |
> +							msg->address_lo;
> +	void __iomem *cfg = get_itgen_cfg_offset(itgen, irqd_to_hwirq(d));
> +
> +	/*
> +	 * The address passed in the msi data is the address of the target
> +	 * mailbox. The itgen however writes to the mailbox based on the mppa
> +	 * id, cluster id and mailbox id instead of an address. So, extract
> +	 * these information from the mailbox address.
> +	 */
> +
> +	cfg_val |= (((kvx_sfr_get(PCR) & KVX_SFR_PCR_CID_MASK) >>
> +				 KVX_SFR_PCR_CID_SHIFT)
> +				<< KVX_ITGEN_CFG_TARGET_CLUSTER_SHIFT);

Please create proper inline functions or macros for this 

> +	cfg_val |= ((dest_addr >> MB_ADDR_MAILBOX_SHIFT) &
> +		     KVX_ITGEN_CFG_TARGET_MAILBOX_MASK)
> +		    << KVX_ITGEN_CFG_TARGET_MAILBOX_SHIFT;

and this.

> +	/*
> +	 * msg->data contains the bit number to be written and is included in
> +	 * the itgen config
> +	 */
> +	cfg_val |= ((msg->data << KVX_ITGEN_CFG_TARGET_SELECT_BIT_SHIFT)
> +		    & KVX_ITGEN_CFG_TARGET_SELECT_BIT_MASK);
> +
> +	dev_dbg(&itgen->pdev->dev,
> +		"Writing dest_addr %lx, value %x to cfg %p\n",
> +		dest_addr, cfg_val, cfg);
> +
> +	writel(cfg_val, cfg);
> +}
> +
> +static int
> +kvx_itgen_device_probe(struct platform_device *pdev)

Pointless line break.

> +{
> +	struct kvx_itgen *itgen;
> +	u32 it_count;
> +	struct resource *mem;
> +
> +	itgen = devm_kzalloc(&pdev->dev, sizeof(*itgen), GFP_KERNEL);
> +	if (!itgen)
> +		return -ENOMEM;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	itgen->base = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(itgen->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(itgen->base),
> +				     "Failed to ioremap itgen\n");
> +
> +	itgen->pdev = pdev;
> +	it_count = readl(get_itgen_param_offset(itgen) +
> +				KVX_ITGEN_PARAM_IT_NUM_OFFSET);
> +
> +	itgen->domain = platform_msi_create_device_domain(&pdev->dev,
> +						   it_count,
> +						   kvx_itgen_write_msg,
> +						   &itgen_domain_ops,
> +						   itgen);

This function is gone as of 6.11-rc1. Please convert to parent MSI domain.

Thanks,

        tglx

