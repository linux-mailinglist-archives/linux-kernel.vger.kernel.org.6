Return-Path: <linux-kernel+bounces-258951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29635938F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E5D281B83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E4B16CD21;
	Mon, 22 Jul 2024 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNHTqzI2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509BE16C6BE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721651460; cv=none; b=q40+DAYG6IQ90KIXBj+P6lh7qT24OkiLTPeJKYkiLd+RnVCPzcJU+/tLnwhUkJjI9Mi3Z8TY60g4ugiUKaiRPIRGeGuth3bsH9aacGePQUHuaTBhMmEQ5A06FMRvoshI+sjy4l2fsTYcfP0k1ybor/EhEInztdNonwmo0q2cTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721651460; c=relaxed/simple;
	bh=gIjoHrFPq0509AhPtxqjJXkPugptVrJEFz8qqYpTrIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/IO+P8y4l5Uzqwrn8q3ctcG2F3L4GKZzxyTK1qBqpw27KZD4qDQF8gdj98qPglsdF8HOYrTkgO+vNy1HUtRzryXote4OPY2GCbOW/ceYevT3ATr+rT0+lZDx04oAYJ/SulCoJ2ZZXz/dkYxN89S8rJxayc4XW2u9+B+7/bbcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNHTqzI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277C2C116B1;
	Mon, 22 Jul 2024 12:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721651459;
	bh=gIjoHrFPq0509AhPtxqjJXkPugptVrJEFz8qqYpTrIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MNHTqzI2f8X5puIeUoDnzPXdzN8wRtUZrhFCIVMJgddbKMmS/MWFtLHl9GvK06e7N
	 WY6Gv/vQpZ4Cds5pGQW/kkuv1hWGXoLbyeemBhJMpWztab2CyuqzTkQYJcHYMeLbP5
	 SyFMz4+34wULF6D9UKBtjUKNeSuiQNkcuyrEsw4CYWAndwJYm4F9wfuV2GmXRgRw/i
	 rttbPpc2nKjdExdgQ6niw6ZtfopF7+vIsyCBtdbTEGvQ2XZxbpNsbhr6stT7uJRiGu
	 wqpDtae4mQbxwXWIaAQ6U+4kvftRvXRaZ4j0cqfZ78drp3i9OMyNcZZownCXVlYWhG
	 E08j1haS3f0Jg==
Message-ID: <214fef44-f4d0-47e9-bcab-9c8b38e68d20@kernel.org>
Date: Mon, 22 Jul 2024 14:30:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 20/37] irqchip: Add irq-kvx-itgen driver
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>,
 Julian Vetter <jvetter@kalrayinc.com>,
 Clement Leger <clement@clement-leger.fr>,
 Vincent Chardon <vincent.chardon@elsys-design.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-21-ysionneau@kalrayinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240722094226.21602-21-ysionneau@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> The Kalray Coolidge SoC contains several interrupt generators (itgen).
> The itgen is both an interrupt-controller and a msi-client.
> 
> Peripheral Controllers such as PCIe, I2C, SPI, GPIO, etc.
> need to send interrupts to the Compute Clusters.
> The purpose of this module is to forward interrupts to the compute clusters
> through the AXI interconnect.

...

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

How is this possible?

> +


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
> +	cfg_val |= ((dest_addr >> MB_ADDR_MAILBOX_SHIFT) &
> +		     KVX_ITGEN_CFG_TARGET_MAILBOX_MASK)
> +		    << KVX_ITGEN_CFG_TARGET_MAILBOX_SHIFT;
> +
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

Why is this wrapped? Does not look like exceeding 80.

> +kvx_itgen_device_probe(struct platform_device *pdev)
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

Use proper wrapper over these two.

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
> +	if (!itgen->domain) {
> +		dev_err(&pdev->dev, "Failed to create device domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, itgen);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id itgen_of_match[] = {
> +	{ .compatible = "kalray,coolidge-itgen" },
> +	{ /* END */ }

Drop comment, that's really obvious.



Best regards,
Krzysztof


