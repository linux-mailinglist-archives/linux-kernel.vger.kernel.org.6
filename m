Return-Path: <linux-kernel+bounces-542654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028BFA4CC00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C491894ECB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED08232392;
	Mon,  3 Mar 2025 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4mGX424";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FiR+5zla"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8801C8604;
	Mon,  3 Mar 2025 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030296; cv=none; b=rKY0XOdbaoS5nLur0653T/dFppoMPZdQBrgrOBCrhCXrC8/6TvlzcJV8R4PXLahX+4tDU48j3SElSLoo33qwbARPyZEwEFzm4yf1OvQblERdqnCKtkw1UzHRItt39a9re/IaVNHhYV5vV76lGJWnLMqS0xJT6uJWqSqySzEj9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030296; c=relaxed/simple;
	bh=hHDNM+PiIH5WSoRSEO24mxsJGorFqWQF7bOmOynJ0AQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQ2dSyr4tMT2wFjtovBxo6wr6IJAKP0mM7YVp0R2ApHPOeRjZmJowEjVWDModrgxYR2g2w0TcrH547VhXp9WalhLs3hPyaEumIwlfdXEm8eJtn8P0m4A8lDA3dgaugK6xH2rYGpGb624cfgGghyDH8603oWbh2Od1x5Intz/008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o4mGX424; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FiR+5zla; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741030293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fx2InO2u3usf4WbNN/ZNNGuXaFAmHvYhKHK29R9jzIc=;
	b=o4mGX424slXTyDFZ2aMdolAv1azDiqVG1sW43+n5L4OA8uVUWcggkUFPTADrtrsYTvRTdn
	hT2ngNsZtEn3NodAYtBx44CDQCTo8ouZi1EgLfo2ZiLZ1dErK5fajA/UgrHSCCMGtNd0C5
	k75DULtB6CFz55YvdOAJkwus5nVJ5m5aPYsySQiMAsF19tytCB9Lmc8YI9MEL92cPjS8KB
	2xKc1juA1eyBPIir0kkDzO4JXje8VIqDK0PA4k/LeS3Eu0BwVKwvPA3keZQvEGPEV+Va1g
	CepZyqrW/xV4Yj+OwBm08vgxE0aA4oYxyrT0n++ASwmaKHPZWP1KKTIaSHxAgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741030293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fx2InO2u3usf4WbNN/ZNNGuXaFAmHvYhKHK29R9jzIc=;
	b=FiR+5zla1f10WxtgsNrKkRNPyNQkF5h9wLTcMzIhMidF4c7jj10my5Wyv0JfDYCZuEspzC
	D/ct61hFvL1ghWBQ==
To: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, Longbin Li
 <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] irqchip/sg2042-msi: Add the Sophgo SG2044 MSI
 interrupt controller
In-Reply-To: <20250303111648.1337543-3-inochiama@gmail.com>
References: <20250303111648.1337543-1-inochiama@gmail.com>
 <20250303111648.1337543-3-inochiama@gmail.com>
Date: Mon, 03 Mar 2025 20:31:32 +0100
Message-ID: <87y0xlc3mz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 03 2025 at 19:16, Inochi Amaoto wrote:
> Add support for Sophgo SG2044 MSI interrupt controller.

This patch fails to apply on top of:

     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers

Please always ensure that your patches apply against the tree/branch
into which they are supposed to be merged. Grabbing random patches from
the mailing list as base is not sufficient. It's clearly documented
against what you should work.
     
> +struct sg2042_msi_of_data {

There is nothing specific to OF in this data structure. This structure
contains the chip and the MSI parent ops of each variant. So something
like sg204x_chip_info is way more descriptive.

> +	const struct irq_chip		*irqchip;
> +	const struct msi_parent_ops	*parent_ops;
> +};
> +
>  struct sg2042_msi_chipdata {

and rename that one to sg204x_... as it is not longer sg2042 specific.

>  	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
>  
> @@ -29,8 +34,10 @@ struct sg2042_msi_chipdata {
>  	u32		irq_first;	// The vector number that MSIs starts
>  	u32		num_irqs;	// The number of vectors for MSIs
>  
> -	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
> +	unsigned long	*msi_map;
>  	struct mutex	msi_map_lock;	// lock for msi_map
> +
> +	const struct sg2042_msi_of_data	*data;

Please keep the tabular formatting of this struct. See:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#coding-style-notes

>  };
>  
>  static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_req)
> @@ -81,6 +88,37 @@ static const struct irq_chip sg2042_msi_middle_irq_chip = {
>  	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
>  };
>  
> +static void sg2044_msi_irq_ack(struct irq_data *d)
> +{
> +	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
> +
> +	writel(0, (unsigned int *)data->reg_clr + d->hwirq);
> +

Pointless newline

> +	irq_chip_ack_parent(d);
> +}
> +
> +static void sg2044_msi_irq_compose_msi_msg(struct irq_data *d,
> +					   struct msi_msg *msg)

No line break required. Please use up to 100 characters.

>  static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain,
>  					  unsigned int virq, int hwirq)
>  {
> @@ -119,7 +157,7 @@ static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain,
>  			goto err_hwirq;
>  
>  		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> -					      &sg2042_msi_middle_irq_chip, data);
> +					      data->data->irqchip, data);

The conversion of the existing code to this should be a preparatory patch
for ease of review and the support for the new chip built on top.

Also please come up with a sensible name for this new 'data' pointer.

     data->data->

is horribly unintuitive. It's not the same data type. 

     data->chip_info

or such makes it clear what this is about.

Thanks,

        tglx

