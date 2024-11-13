Return-Path: <linux-kernel+bounces-407123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA6B9C6920
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C99B234B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D82015F40B;
	Wed, 13 Nov 2024 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rq7Tapz+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pjGfd1bi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CA5680;
	Wed, 13 Nov 2024 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478481; cv=none; b=AIynyCTmnr4XzL8umQtFtx6t0f6z4yoAVxDw3FLfTlMYE+nvx7giVPQd617z7Dw14wGnFcvLawUu91ooXNtb6lrCteXL5MWNkTuMh48G/yqIQqK3I9ZRMz654+IU4QF9VImenRzjVMqE7TvbOFF8i0XIj8zAS9UYcBAG9BILktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478481; c=relaxed/simple;
	bh=8BtdDJRNp0Cfx1DuuvOlCkADkTn3rpJuog60PwDeYgI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k5rTIPNG+2Beevbyjr99AeIcbGRmCLzM9Q3giaDCjp4g6qBAokOMnTBiXCQ8ilpN9JvuefdosC8MsgiZjf4a406EYancj19KFEaOpfWfPxnPHmZE4nVlJ8kNO720YDJb+BY5SMBil58gapW9K/tRiRALT0yVuLpcBNk9uCBEK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rq7Tapz+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pjGfd1bi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731478477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cgMAtnlfw/A5BHvVanJvGd3GgX27bwS1EVjoLb8bqPk=;
	b=Rq7Tapz+xLLZrlr5dZ33WEFhr/xsPMmGVUsR0LmY78mIsu+xUNNAo01kkOMYXirhcWY6Xf
	pLaO8LmRhNxv+rUZ3MlWsM7AKti/Xyvh7P2jjbMOXoEZBkKjTT5GibNA9OrVrcrDCrLqSd
	aL73Y8Rvha0CIfGEV/ZZ6sde9AJ9Y15Adbkxo1SmNr3Y++q1XzmLGv4I+J8ksbWlYgpMnh
	CczIGNx5TPF7vxbvSUa3WlyyjEHlbNnNgxy1NLXRft51qu3KtZK1DYxfw3hV4oykG5PQKM
	XAz7Th0QZZrVcD8t8Twz1DljXr7j1Ncc1kHqZEKSuw4NLv9DfvdqXPC/rihy5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731478477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cgMAtnlfw/A5BHvVanJvGd3GgX27bwS1EVjoLb8bqPk=;
	b=pjGfd1biRN03cvT0LaMUXmNND1jMJT/HrazDsrfs9u2KihtJGu3UrVKDBibon0dDv4ecnL
	bDyXanigAgBVpnBw==
To: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, arnd@arndb.de, unicorn_wang@outlook.com,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Subject: Re: [PATCH 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
In-Reply-To: <8076fe2af9f2b007a42c986ed193ba50ff674bfa.1731296803.git.unicorn_wang@outlook.com>
References: <cover.1731296803.git.unicorn_wang@outlook.com>
 <8076fe2af9f2b007a42c986ed193ba50ff674bfa.1731296803.git.unicorn_wang@outlook.com>
Date: Wed, 13 Nov 2024 07:14:52 +0100
Message-ID: <87cyizmzhf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024 at 12:01, Chen Wang wrote:
> +struct sg2042_msi_data {
> +	void __iomem	*reg_clr; /* clear reg, see TRM, 10.1.33, GP_INTR0_CLR */

Please make these tail comments tabular aligned so they actually stand
out.

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#comment-style

> +
> +	u64		doorbell_addr; /* see TRM, 10.1.32, GP_INTR0_SET */
> +
> +	u32		irq_first; /* The vector number that MSIs starts */
> +	u32		num_irqs;  /* The number of vectors for MSIs */
> +
> +	unsigned long	*msi_map;
> +	struct mutex	msi_map_lock; /* lock for msi_map */
> +};
> +
> +static int sg2042_msi_allocate_hwirq(struct sg2042_msi_data *priv, int num_req)
> +{
> +	int first;
> +
> +	mutex_lock(&priv->msi_map_lock);

Please use

       guard(mutex)(&priv->msi_map_lock);

which removes all the mutex_unlock() hackery and boils this down

> +
> +	first = bitmap_find_free_region(priv->msi_map, priv->num_irqs,
> +					get_count_order(num_req));
> +	if (first < 0) {
> +		mutex_unlock(&priv->msi_map_lock);
> +		return -ENOSPC;
> +	}
> +
> +	mutex_unlock(&priv->msi_map_lock);
> +
> +	return priv->irq_first + first;

to

	guard(mutex)(&priv->msi_map_lock);
	first = bitmap_find_free_region(priv->msi_map, priv->num_irqs,
					get_count_order(num_req));
	return first >= 0 ? priv->irq_first + first : -ENOSPC;

See?

> +}
> +
> +static void sg2042_msi_free_hwirq(struct sg2042_msi_data *priv,
> +				  int hwirq, int num_req)
> +{
> +	int first = hwirq - priv->irq_first;
> +
> +	mutex_lock(&priv->msi_map_lock);

Ditto.

> +	bitmap_release_region(priv->msi_map, first, get_count_order(num_req));
> +	mutex_unlock(&priv->msi_map_lock);
> +}

> +static void sg2042_msi_irq_compose_msi_msg(struct irq_data *data,
> +					   struct msi_msg *msg)
> +{
> +	struct sg2042_msi_data *priv = irq_data_get_irq_chip_data(data);
> +
> +	msg->address_hi = upper_32_bits(priv->doorbell_addr);
> +	msg->address_lo = lower_32_bits(priv->doorbell_addr);
> +	msg->data = 1 << (data->hwirq - priv->irq_first);
> +
> +	pr_debug("%s hwirq[%d]: address_hi[%#x], address_lo[%#x], data[%#x]\n",
> +		 __func__,

No point in having this line break. You have 100 characters. Please fix
this all over the place.

> +		 (int)data->hwirq, msg->address_hi, msg->address_lo, msg->data);

(int) ? Why can't you use the proper conversion specifier instead of %d?

> +static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain,
> +					  unsigned int virq,
> +					  unsigned int nr_irqs, void *args)
> +{
> +	struct sg2042_msi_data *priv = domain->host_data;
> +	int hwirq, err, i;
> +
> +	hwirq = sg2042_msi_allocate_hwirq(priv, nr_irqs);
> +	if (hwirq < 0)
> +		return hwirq;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		err = sg2042_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
> +		if (err)
> +			goto err_hwirq;
> +
> +		pr_debug("%s: virq[%d], hwirq[%d]\n",
> +			 __func__, virq + i, (int)hwirq + i);

No line break required.

> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &sg2042_msi_middle_irq_chip, priv);
> +	}

> +static int sg2042_msi_init_domains(struct sg2042_msi_data *priv,
> +				   struct device_node *node)
> +{
> +	struct irq_domain *plic_domain, *middle_domain;
> +	struct device_node *plic_node;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(node);

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +	if (!of_find_property(node, "interrupt-parent", NULL)) {
> +		pr_err("Can't find interrupt-parent!\n");
> +		return -EINVAL;
> +	}
> +
> +	plic_node = of_irq_find_parent(node);
> +	if (!plic_node) {
> +		pr_err("Failed to find the PLIC node!\n");
> +		return -ENXIO;
> +	}
> +
> +	plic_domain = irq_find_host(plic_node);
> +	of_node_put(plic_node);
> +	if (!plic_domain) {
> +		pr_err("Failed to find the PLIC domain\n");
> +		return -ENXIO;
> +	}
> +
> +	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, priv->num_irqs,
> +						    fwnode,
> +						    &pch_msi_middle_domain_ops,
> +						    priv);

So now you have created a domain. How is that supposed to be used by the
PCI layer?

> +	if (!middle_domain) {
> +		pr_err("Failed to create the MSI middle domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

> +static int sg2042_msi_probe(struct platform_device *pdev)
> +{

....

> +	data->msi_map = bitmap_zalloc(data->num_irqs, GFP_KERNEL);
> +	if (!data->msi_map)
> +		return -ENOMEM;
> +
> +	return sg2042_msi_init_domains(data, pdev->dev.of_node);

In case of error this leaks data->msi_map, no?

> +static struct platform_driver sg2042_msi_driver = {
> +	.driver = {
> +		.name = "sg2042-msi",
> +		.of_match_table = of_match_ptr(sg2042_msi_of_match),
> +	},
> +	.probe = sg2042_msi_probe,
> +};

Please see the documentation I pointed you to above and search for
struct initializers.

Thanks,

        tglx

