Return-Path: <linux-kernel+bounces-345765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C8298BAD0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820CC1C20D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BBD19DFBF;
	Tue,  1 Oct 2024 11:17:44 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF637155738
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781464; cv=none; b=KEV2gOYhshDvAS4b6kX5+NWKKVxXD1RHyezk/fJgjHITBREQsSaWGMBJGVU5n4jRh7Qnh9hohG7GSZxu7uAUqmBsJE9U2jbzxA/6+8TMyhHZFWNBAk1spc1loM8ZQOTCnfpGp9CrJN+cBauF4rLy8SdlURtpghtMzGe9mQuW8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781464; c=relaxed/simple;
	bh=pNSGtahvKOZzlvn+VoMoqCWISJbd2yFW86A/l2Tc8Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q39vH40x2zUU/FzPatDB+r0AipWe1EIHJT8PNIyoYrmgr0lx1JRZFke83qDOL2TmNjVJQL6czRNFheJ/L4Q9LYWz0Grv9ej/MWzOxKp4oeEtaJG8yZfsU8wWty1fpk7iBkTWPofu2dNp2D5NLPlSlXBclexcXUFqSYBgonAVikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DB1E240007;
	Tue,  1 Oct 2024 11:17:38 +0000 (UTC)
Message-ID: <a29ee3f5-9f2f-4278-94be-72f05bc9cf6a@ghiti.fr>
Date: Tue, 1 Oct 2024 13:17:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/sifive-plic: Fix error codes
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 kernel test robot <lkp@intel.com>
References: <20240903-correct_error_codes_sifive_plic-v1-1-d929b79663a2@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240903-correct_error_codes_sifive_plic-v1-1-d929b79663a2@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Charlie,

On 04/09/2024 01:36, Charlie Jenkins wrote:
> Set error to -ENOMEM if kcalloc() fails or if irq_domain_add_linear()
> fails inside of plic_probe().
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202409031122.yBh8HrxA-lkp@intel.com/


I found the following Fixes tag:

Fixes: 4d936f10ff80 ("irqchip/sifive-plic: Probe plic driver early for 
Allwinner D1 platform")


> ---
>   drivers/irqchip/irq-sifive-plic.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 2f6ef5c495bd..0b730e305748 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -626,8 +626,10 @@ static int plic_probe(struct fwnode_handle *fwnode)
>   
>   		handler->enable_save = kcalloc(DIV_ROUND_UP(nr_irqs, 32),
>   					       sizeof(*handler->enable_save), GFP_KERNEL);
> -		if (!handler->enable_save)
> +		if (!handler->enable_save) {
> +			error = -ENOMEM;


This is correct.


>   			goto fail_cleanup_contexts;
> +		}
>   done:
>   		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
>   			plic_toggle(handler, hwirq, 0);
> @@ -639,8 +641,10 @@ static int plic_probe(struct fwnode_handle *fwnode)
>   
>   	priv->irqdomain = irq_domain_create_linear(fwnode, nr_irqs + 1,
>   						   &plic_irqdomain_ops, priv);
> -	if (WARN_ON(!priv->irqdomain))
> +	if (WARN_ON(!priv->irqdomain)) {
> +		error = -ENOMEM;


Here though I found drivers that return either ENODEV 
(https://elixir.bootlin.com/linux/v6.11/source/drivers/irqchip/irq-gic.c#L1210) 
or ENOMEM 
(https://elixir.bootlin.com/linux/v6.11/source/drivers/irqchip/irq-imx-mu-msi.c#L229).

Before the commit I mentioned above, we used to return ENOMEM. IMHO it's 
not a big deal as long as we return something different from 0 in that 
case, I just mention it if someone thinks differently.

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

And I would also add:

Cc: stable@vger.kernel.org

Thanks,

Alex


>   		goto fail_cleanup_contexts;
> +	}
>   
>   	/*
>   	 * We can have multiple PLIC instances so setup global state
>
> ---
> base-commit: 6804f0edbe7747774e6ae60f20cec4ee3ad7c187
> change-id: 20240903-correct_error_codes_sifive_plic-4611f59291df

