Return-Path: <linux-kernel+bounces-365688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF4F99E62D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705931C234AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E341D9A42;
	Tue, 15 Oct 2024 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pouJ4Feg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB81E7669
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992325; cv=none; b=ApQckXtI7Zl+3QvZzAhpPSWCx75iTUwBRVgtR8HT5rKYc/AcNeADg0WUfej7NzYAclwmAty4UH6zw2GVanB6vhemtRj+sBEEy/SyaZ3Lnt1I/Px5edgoOEVvoRb+Qz8J1A0uuqDstwbjaDI1pslJ1vRzNWRXVmph1e+jsqDrrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992325; c=relaxed/simple;
	bh=KsRWXz5u8e6OVOdYCyQDUwhXWrP8yPzKCvpfJwOeZXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK4/POrTsLSC4qIMCwcttVpy2TN5Ezt4lJCI9uXVMt3UxomobCwrvjwyZEWad5jw9mCh0AYy35iUaoXlglBQFxLPjaoVV0PNqR1r7rVJrt4BSEzb3ooesdk36aWpmaWIMMHi8GozPXG63uo6jxft+VK5jDu3P4h8iJpCbrODC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pouJ4Feg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0754EC4CECF;
	Tue, 15 Oct 2024 11:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728992325;
	bh=KsRWXz5u8e6OVOdYCyQDUwhXWrP8yPzKCvpfJwOeZXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pouJ4FegQuYCCW2e/sUfaqciQg2sOVTOAAICttnqwEdCo34+z+pSJLmGOwpP1vsu/
	 ucr6xrWhZ46sozmRM6PvGdnsRMLCp2AHFkUapyXH77eccuxECLFu1GGQm/355H/mNV
	 SFnyHKMYqxWIXeKITWk4oZXa+JFwBaz+s9dfIa9gl75EPEEp3NfLJu83iM0FpPiL+5
	 0uuSp59cQtIdVFzq4Tkl/Pq1dU71km3foQ40/flFdqGOS+ZxXreknOkxKzxfj2iup9
	 AvE45bYAEILFX5eQJmTDh/p9y4qF8k6n+oNQEhlpJsf+aobPJOC1/S0I2u8EBK36go
	 39x1kGd7o4Lbg==
Date: Tue, 15 Oct 2024 12:38:41 +0100
From: Lee Jones <lee@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>
Subject: Re: [PATCH v4 5/5] mfd: tqmx86: add I2C IRQ support
Message-ID: <20241015113841.GH8348@google.com>
References: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
 <e44098d2e496fda8220f9965f7a6021c1026eb18.1728286453.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e44098d2e496fda8220f9965f7a6021c1026eb18.1728286453.git.matthias.schiffer@ew.tq-group.com>

On Mon, 07 Oct 2024, Matthias Schiffer wrote:

> From: Gregor Herburger <gregor.herburger@tq-group.com>
> 
> The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
> Add module parameter to allow configuring the IRQ number, similar to the
> handling of the GPIO IRQ.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: improve module parameter description (was patch 4/4)
> v3: replace IRQ 0 resource with an empty placeholder to simplify error handling
> v4: no changes
> 
>  drivers/mfd/tqmx86.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> index e444fcd2a3e9d..057d035b71d33 100644
> --- a/drivers/mfd/tqmx86.c
> +++ b/drivers/mfd/tqmx86.c
> @@ -50,6 +50,7 @@
>  #define TQMX86_REG_IO_EXT_INT_9			2
>  #define TQMX86_REG_IO_EXT_INT_12		3
>  #define TQMX86_REG_IO_EXT_INT_MASK		0x3
> +#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
>  #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
>  #define TQMX86_REG_SAUC		0x17
>  
> @@ -60,7 +61,16 @@ static uint gpio_irq;
>  module_param(gpio_irq, uint, 0);
>  MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
>  
> -static const struct resource tqmx_i2c_soft_resources[] = {
> +static uint i2c_irq;
> +module_param(i2c_irq, uint, 0);
> +MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (valid parameters: 7, 9, 12)");
> +
> +static struct resource tqmx_i2c_soft_resources[] = {
> +	/*
> +	 * Placeholder for IRQ resource - must come first to be filled in by the
> +	 * probe function.
> +	 */
> +	{},

Having a NULLed entry in the first slot doesn't sit well with me at all.

In order for us to avoid wasting memory, it would be better to place the
entry at the end of the array with a blank entry:

  DEFINE_RES_IRQ(0),

Later comes the matching code which updates the 0 value to something sane.

Before you call to the add the devices, check to see if the value has
changed.  If it hasn't, deprecate num_resources, effectively masking the
last entry in the array.  Then when platform_device_add_resources()
comes to duplicate the array, it will only copy the relevant entries.

>  	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
>  };
>  
> @@ -263,6 +273,14 @@ static int tqmx86_probe(struct platform_device *pdev)
>  	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
>  
>  	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
> +		if (i2c_irq) {
> +			err = tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
> +					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
> +			if (!err)
> +				/* Assumes the IRQ resource placeholder is first */
> +				tqmx_i2c_soft_resources[0] = DEFINE_RES_IRQ(i2c_irq);
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

