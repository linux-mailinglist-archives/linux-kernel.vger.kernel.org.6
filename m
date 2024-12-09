Return-Path: <linux-kernel+bounces-437077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D89E8ED1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C971639D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F99215716;
	Mon,  9 Dec 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLOsVyhe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66412BA4B;
	Mon,  9 Dec 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736858; cv=none; b=u6edU1FSTVdWw6si69wxwH3KcI0U3iv2SZoWD4y5GxEN+X+59E17BQ4c6YZGqdb4lkmneBED6nz0UepocweBUs5iKkyZ1dG9tXEcYbC5Hey1qR3M5HvglVl2y4NlHmoq5S5mFEREILr7JMT71/AGUErISG7JIWev07GOgihGo98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736858; c=relaxed/simple;
	bh=IzV+3HCjgE7OTmGjpz+XMnwaut0tfpKGJVLufWU0mVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+wX2Q0V4kBHeEN0IR7WBLqwETvZpkbkslgL+n74hMK2dpuVZ5kCkJ22wVw7G8Xs5Y8T0891aBAzTH3o5UlENUAFTRIniS3EzsPFmpE660MN/BsaWJibUFuNDRWvHYRWy4UVYFU342Yw73ZsDSNrTokQFLjcfdu3Qph7GO7F8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLOsVyhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE96EC4CED1;
	Mon,  9 Dec 2024 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733736858;
	bh=IzV+3HCjgE7OTmGjpz+XMnwaut0tfpKGJVLufWU0mVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLOsVyheykMvVt0+tlREeXQE2g6gYKe0GjHqgBDNvliriYOD+n4e9Lo6pMBaXlfUp
	 6Gmki8zPupghf+PE9X7AUPHpkBZ67tdCFG0NXClw14zDZ7suB6RLDdt3wv9cEDOF3A
	 pGwnT6O/0VBNTVqfQmiPIo90pBmDRQqu3zn7XHIS+7YfW/+T+YBoR/4phy4C5j4m9R
	 SulkZBRFxQc/a0IKvho+y2yX9VNKBnP135zEifhdvNkmBtU0ksmvM/c4+yXqv+YMfx
	 1i2D9xH5xX+tpUI6FYj+HGWwzKfWYMZGSUG2zojPx02w/SsPM608q1n//IJHvvMo/p
	 Yg+l7VSv1GqCA==
Date: Mon, 9 Dec 2024 10:34:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de, 
	unicorn_wang@outlook.com, conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com, 
	krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	tglx@linutronix.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
	fengchun.li@sophgo.com
Subject: Re: [PATCH v2 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
Message-ID: <kdwwyx4digujlculbu4ivyiedqbmivuuddpfadpp7tup2gmvjv@6j53b4wqxbd7>
References: <cover.1733726057.git.unicorn_wang@outlook.com>
 <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>

On Mon, Dec 09, 2024 at 03:12:00PM +0800, Chen Wang wrote:
> +static void sg2042_msi_irq_ack(struct irq_data *d)
> +{
> +	struct sg2042_msi_data *data  = irq_data_get_irq_chip_data(d);
> +	int bit_off = d->hwirq - data->irq_first;
> +
> +	writel(1 << bit_off, (unsigned int *)data->reg_clr);
> +
> +	irq_chip_ack_parent(d);
> +}
> +
> +static void sg2042_msi_irq_compose_msi_msg(struct irq_data *data,
> +					   struct msi_msg *msg)
> +{
> +	struct sg2042_msi_data *priv = irq_data_get_irq_chip_data(data);
> +
> +	msg->address_hi = upper_32_bits(priv->doorbell_addr);
> +	msg->address_lo = lower_32_bits(priv->doorbell_addr);
> +	msg->data = 1 << (data->hwirq - priv->irq_first);
> +
> +	pr_debug("%s hwirq[%ld]: address_hi[%#x], address_lo[%#x], data[%#x]\n",
> +		 __func__, data->hwirq, msg->address_hi, msg->address_lo, msg->data);

Don't print addresses, it is useless - it will be a constant.

> +}
> +
> +static struct irq_chip sg2042_msi_middle_irq_chip = {
> +	.name			= "SG2042 MSI",
> +	.irq_ack		= sg2042_msi_irq_ack,
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +#endif
> +	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
> +};

...

> +static int sg2042_msi_probe(struct platform_device *pdev)
> +{
> +	struct of_phandle_args args = {};
> +	struct sg2042_msi_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(struct sg2042_msi_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
> +	if (IS_ERR(data->reg_clr)) {
> +		dev_err(&pdev->dev, "Failed to map clear register\n");
> +		return PTR_ERR(data->reg_clr);
> +	}
> +
> +	if (of_property_read_u64(pdev->dev.of_node, "sophgo,msi-doorbell-addr",
> +				 &data->doorbell_addr)) {
> +		dev_err(&pdev->dev, "Unable to parse MSI doorbell addr\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_parse_phandle_with_args(pdev->dev.of_node, "msi-ranges",
> +					 "#interrupt-cells", 0, &args);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to parse MSI vec base\n");
> +		return ret;
> +	}

You leak the phandle. You leak much more, btw...

> +	data->irq_first = (u32)args.args[0];
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "msi-ranges",
> +					 args.args_count + 1, &data->num_irqs);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to parse MSI vec number\n");
> +		return ret;
> +	}
> +
> +	if (data->irq_first < SG2042_VECTOR_MIN ||
> +	    (data->irq_first + data->num_irqs - 1) > SG2042_VECTOR_MAX) {
> +		dev_err(&pdev->dev, "msi-ranges is incorrect!\n");
> +		return -EINVAL;
> +	}
> +
> +	mutex_init(&data->msi_map_lock);
> +
> +	data->msi_map = bitmap_zalloc(data->num_irqs, GFP_KERNEL);

This also leaks during removal.

> +	if (!data->msi_map)
> +		return -ENOMEM;
> +
> +	ret = sg2042_msi_init_domains(data, pdev->dev.of_node);
> +	if (ret)
> +		bitmap_free(data->msi_map);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id sg2042_msi_of_match[] = {
> +	{ .compatible	= "sophgo,sg2042-msi" },
> +	{}
> +};
> +
> +static struct platform_driver sg2042_msi_driver = {
> +	.driver = {
> +		.name		= "sg2042-msi",
> +		.of_match_table	= of_match_ptr(sg2042_msi_of_match),

Drop of_match_ptr(), unnecessary and might lead to warnings even if this
is not a module.

Best regards,
Krzysztof


