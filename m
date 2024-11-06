Return-Path: <linux-kernel+bounces-397857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726DC9BE17A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7CBB2164E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1741D6DAA;
	Wed,  6 Nov 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrGCzEPo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB551D47AC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883631; cv=none; b=JKFhqSRtUfIK2qEWpqc+CxzeFV4Kt4+jp0FQ0HTFt0rUrzKEhzv9lL1vda84ii4d+5Z7HiJyMr7AeQad+rsWeOaiQwpFUamqIsfXjJeY+GWzGVpPv5r6VzLgkoBR5KtSEyamAJxOnZfVtNhwiONyxT9Mc2LRYZlIIu1omUbEJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883631; c=relaxed/simple;
	bh=rpAbzHF9hYtSOly1g2U8wBFjXzH5rSbeI151F7BhAy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuRdO1wUeDxSzYT1dYeX+wgG2BT26+hjNAqSJSZsPRgl0Gx4HVi2EE/vXnzA9Wxc7lFY9/t/bVGp0AbmflmMl9L6grAMxxtrY+MUl+kDmPo6hp+0aMc3T0nqlfyoCujFBgBrmEsaD/9h5UEcLvP0/5FHJ/zY+LFtOCTrxVDe2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrGCzEPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAD2C4CECD;
	Wed,  6 Nov 2024 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730883630;
	bh=rpAbzHF9hYtSOly1g2U8wBFjXzH5rSbeI151F7BhAy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrGCzEPoWH4nwoCdR1BASgY6tldk1wIs+9gNOhcbXEejKXcopRf7n7xPSWPUGsOeG
	 VfH7Yn/GblUid0o0VeNyk7EyFzug0N2YuVuFS7303oqsBO+8igaE47pehfTJ5E7h9p
	 ng+UXYndfxrOM8CW6HwzIDhz41JuFy6TdxbF5RY9BU2CssEGbIBqmy2hlchLdWmGH+
	 IOXiThGQqyFsiH4IhOwG9fH+jsQIq4Hi+91EgcEzzKKch0euViRA4B6uT96CnlrMP/
	 iFwUB5SFNpx/6U08sgMbzCWX9vCUy4xDdP/lBmIvut3+MxBUsLXyiWWbZs6NMoVDx4
	 D+8TmslKaMf4A==
Date: Wed, 6 Nov 2024 09:00:27 +0000
From: Lee Jones <lee@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] mfd: tqmx86: make IRQ setup errors non-fatal
Message-ID: <20241106090027.GI1807686@google.com>
References: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
 <812ca50b33766b1b528a02a8d5226f21822b2851.1730717841.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <812ca50b33766b1b528a02a8d5226f21822b2851.1730717841.git.matthias.schiffer@ew.tq-group.com>

On Mon, 04 Nov 2024, Matthias Schiffer wrote:

> GPIO IRQ setup can fail either because an invalid IRQ was passed as a
> parameter, or because the GPIO controller does not support interrupts.
> Neither is severe enough to stop the whole probe; simply disable IRQ
> support in the GPIO resource when setup fails.
> 
> The code is made a bit more robust by introduing a define for the index
> of the IRQ resource in the resource list instead of assuming that it is
> at index 0.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: no changes (was patch 3/4)
> v3: replace IRQ 0 resource with an empty placeholder to simplify error handling
> v4: no changes
> v5: move placeholder to the end of the resource array, use define for index
> v6: no changes
> 
>  drivers/mfd/tqmx86.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> index 8aa448a67c9a5..1fd2212bf492c 100644
> --- a/drivers/mfd/tqmx86.c
> +++ b/drivers/mfd/tqmx86.c
> @@ -60,6 +60,9 @@ static uint gpio_irq;
>  module_param(gpio_irq, uint, 0);
>  MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
>  
> +/* Index of IRQ placeholder in resource list */
> +#define TQMX86_IRQ_GPIO 1
> +
>  static const struct resource tqmx_i2c_soft_resources[] = {
>  	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
>  };
> @@ -68,13 +71,10 @@ static const struct resource tqmx_watchdog_resources[] = {
>  	DEFINE_RES_IO(TQMX86_IOBASE_WATCHDOG, TQMX86_IOSIZE_WATCHDOG),
>  };
>  
> -/*
> - * The IRQ resource must be first, since it is updated with the
> - * configured IRQ in the probe function.
> - */
>  static struct resource tqmx_gpio_resources[] = {
> -	DEFINE_RES_IRQ(0),
>  	DEFINE_RES_IO(TQMX86_IOBASE_GPIO, TQMX86_IOSIZE_GPIO),
> +	/* Placeholder for IRQ resource - filled in by the probe function */

Drop the " - filled in ..." part.  This is a common practice.

> +	[TQMX86_IRQ_GPIO] = {},

Not quite.  What happens if someone comes along and inserts a resource
above this one?  You need to index all of them.  Use an enum.

>  };
>  
>  static struct i2c_board_info tqmx86_i2c_devices[] = {
> @@ -255,13 +255,8 @@ static int tqmx86_probe(struct platform_device *pdev)
>  	if (gpio_irq) {
>  		err = tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
>  				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
> -		if (err)
> -			return err;
> -
> -		/* Assumes the IRQ resource is first. */
> -		tqmx_gpio_resources[0].start = gpio_irq;
> -	} else {
> -		tqmx_gpio_resources[0].flags = 0;
> +		if (!err)
> +			tqmx_gpio_resources[TQMX86_IRQ_GPIO] = DEFINE_RES_IRQ(gpio_irq);

This section just became a lot nicer.

>  	}
>  
>  	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
> 

-- 
Lee Jones [李琼斯]

