Return-Path: <linux-kernel+bounces-397859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C50B9BE17F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AEB284680
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04121D223C;
	Wed,  6 Nov 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urykG7TM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAB1CC882
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883669; cv=none; b=pA2rOomWmy/7po9aPyh9VxnkcGGUitfMZNsqJ1znM1KrcXGcyQg4xxtFk27P9srHHdnLmfsBaUrxFfW66mEl28lF9Gt8Hb5qXVfYrk98AeB+sAa3jsunIjRwjMsuXQQcTWwvX8N7l0A+QtRStd3lfUbZ0EpOD4J6NgPLn7hf9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883669; c=relaxed/simple;
	bh=BMob3cMX0DyJKaBZ81jrKn8WzYHySRivbyxCqzsNcyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNaADag+piRGopcmmCiZp3bf9OWrlH2S+eJeUqZrpcu4CmAtpb7VKN6KvRBEK5cum6EldZB5VtZ7f7EKGACCN2O0yAnQ4JyDmpFSzGG5MXUgoS7exo7Wyl7BeoHaKB3X9qYhSEQHqU6B8Eo8LgJ3PW7Vx077dDnN7mkEBSWzkfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urykG7TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAF8C4CECD;
	Wed,  6 Nov 2024 09:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730883668;
	bh=BMob3cMX0DyJKaBZ81jrKn8WzYHySRivbyxCqzsNcyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urykG7TMM1wOq2MqzmcPI35ZPDFC7UlzjZe7PJ7AAPBo4QWY/l8lN/7BMb7uAici8
	 9E7o4mkYgKLM30BPLIAgkW0y7rhVe/uE7Awa7RTRLvmyIRVsVQOzGuE3rU2BYocVnV
	 IQ3n1tc6USwqQpsv6hc2G/ZVsKkCXXRjVLbxMRDDpuGOj3b3EsP3XkChOKTFYvzYxx
	 IlMgD8+zn/VwCwtgocQ8XTz4KhNBk4FLoMWJXNy5RorMlUOEqU8EJHqiMAb+D/qVQo
	 F0I0qEBA8kgzglG42bj+ezlUelnkthCqhR6eL0hINTVnJNvw4k1uHf267QuGg0R0pi
	 ejgZBJJ+rsV7A==
Date: Wed, 6 Nov 2024 09:01:05 +0000
From: Lee Jones <lee@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>
Subject: Re: [PATCH v6 5/5] mfd: tqmx86: add I2C IRQ support
Message-ID: <20241106090105.GJ1807686@google.com>
References: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
 <db981ff0a5c4f5cae898e6cd4ffcc530e5b09ba8.1730717841.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db981ff0a5c4f5cae898e6cd4ffcc530e5b09ba8.1730717841.git.matthias.schiffer@ew.tq-group.com>

On Mon, 04 Nov 2024, Matthias Schiffer wrote:

> From: Gregor Herburger <gregor.herburger@tq-group.com>
> 
> The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
> Add module parameter to allow configuring the IRQ number, similar to the
> handling of the GPIO IRQ.
> 
> The new code and module parameter refer to the I2C controller as "I2C1",
> as the TQMx86 PLD actually contains a second I2C controller, for which
> driver support will be added in the future.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: improve module parameter description (was patch 4/4)
> v3: replace IRQ 0 resource with an empty placeholder to simplify error handling
> v4: no changes
> v5: move placeholder to the end of the resource array, use define for index
> v6:
>   - remove obsolete comment
>   - refer to I2C controller as "I2C1"
> 
>  drivers/mfd/tqmx86.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> index 1fd2212bf492c..7dd971b762578 100644
> --- a/drivers/mfd/tqmx86.c
> +++ b/drivers/mfd/tqmx86.c
> @@ -50,6 +50,7 @@
>  #define TQMX86_REG_IO_EXT_INT_9			2
>  #define TQMX86_REG_IO_EXT_INT_12		3
>  #define TQMX86_REG_IO_EXT_INT_MASK		0x3
> +#define TQMX86_REG_IO_EXT_INT_I2C1_SHIFT	0
>  #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
>  #define TQMX86_REG_SAUC		0x17
>  
> @@ -60,11 +61,18 @@ static uint gpio_irq;
>  module_param(gpio_irq, uint, 0);
>  MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
>  
> +static uint i2c1_irq;
> +module_param(i2c1_irq, uint, 0);
> +MODULE_PARM_DESC(i2c1_irq, "I2C1 IRQ number (valid parameters: 7, 9, 12)");
> +
>  /* Index of IRQ placeholder in resource list */
>  #define TQMX86_IRQ_GPIO 1
> +#define TQMX86_IRQ_I2C1 1
>  
> -static const struct resource tqmx_i2c_soft_resources[] = {
> +static struct resource tqmx_i2c_soft_resources[] = {
>  	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),

Same here.

> +	/* Placeholder for IRQ resource - filled in by the probe function */
> +	[TQMX86_IRQ_I2C1] = {},
>  };
>  
>  static const struct resource tqmx_watchdog_resources[] = {
> @@ -262,6 +270,13 @@ static int tqmx86_probe(struct platform_device *pdev)
>  	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
>  
>  	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
> +		if (i2c1_irq) {
> +			err = tqmx86_setup_irq(dev, "I2C1", i2c1_irq, io_base,
> +					       TQMX86_REG_IO_EXT_INT_I2C1_SHIFT);
> +			if (!err)
> +				tqmx_i2c_soft_resources[TQMX86_IRQ_I2C1] = DEFINE_RES_IRQ(i2c1_irq);
> +		}
> +
>  		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>  					   tqmx86_i2c_soft_dev,
>  					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
> 

-- 
Lee Jones [李琼斯]

