Return-Path: <linux-kernel+bounces-519610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138FBA39EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F17175022
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA83426A0BC;
	Tue, 18 Feb 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="cisU6zu+"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AD269D1B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888465; cv=none; b=aI1pGsGJBaSJy0MZXCN0QXvMmXdYQPZjpOM9uufMX2aCC+plokajhI4wT2BkhVa9OvZjw+ItDBLdLyaFC28W10JA8V+xu7iagFRqQRZzvDihf5YxZV6rYBqDYqHTkJJGTpnOq/YEvXyTb8IjJiiQbO6DENn9mp3o+c8UfbMB25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888465; c=relaxed/simple;
	bh=PHX9eFphN5fQHkjD5X6XVryLhS61bphBF0uF5eEXZso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdEWCHuup7TENrajywTfTbOndkm5YBRcfRByAO90um/kcQ+D8UU9gTlXRGAqbQQt3WgNFTboII3nrqfhwdKh8v8H7iCnQqRJ2x04h3M8FUEpbGdt2AgnpllFaysBKSBStLX5R46S/030jo8yEfMGmBZcRYHPSXvHp7VYyexbzAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=cisU6zu+; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 2CF83240027
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:20:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1739888455; bh=PHX9eFphN5fQHkjD5X6XVryLhS61bphBF0uF5eEXZso=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=cisU6zu+rnd1s1mtjEPgIt4ueTODrMCnMd//MamgwGEsAFQcvJYUkbxc/Qk7JpAAA
	 c8alNeb++xQetVw+zPRioHe2c0qaUQx74l1MwimQ+MYraUnmVM8judpuKvipXzxT4O
	 C6feEc37oi7bUxqlKxQVU0/IErEmYM5LpNGjyvJwtPyxyZ6IgJf5+4xCAyTWptAbxM
	 RiQW6RL22lmEJF6Yv3V/TXfnU+et4v0gSERvLD8BT3ioLHG3s0Ri/pDyMlq+bWYA/I
	 rrSZM1PGhOk5N95K7d48+qBWFG8AiL6i0Yg+Y6dzRzwcfCouHMrjhZvdcLrJvEDHQc
	 p/qR9q43etqBA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Yy1sK4BGLz9rxN;
	Tue, 18 Feb 2025 15:20:53 +0100 (CET)
Date: Tue, 18 Feb 2025 14:20:53 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: : Switch to use for_each_gpiochip_node()
 helper
Message-ID: <Z7SXRZtrClEVBMDx@probook>
References: <20250213193152.3120396-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213193152.3120396-1-andriy.shevchenko@linux.intel.com>

On Thu, Feb 13, 2025 at 09:31:52PM +0200, Andy Shevchenko wrote:
> Switch the code to use for_each_gpiochip_node() helper.
> 
> While at it, correct header inclusion as device property APIs
> are provided in property.h.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Looks good, thanks!

Reviewed-by: J. Neuschäfer <j.ne@posteo.net>

>  drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
> index cdad4ef11a2f..2f97accef837 100644
> --- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
> +++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
> @@ -10,7 +10,6 @@
>  //   block, shared between all GPIO banks
>  
>  #include <linux/device.h>
> -#include <linux/fwnode.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -18,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  
>  #include <linux/pinctrl/pinconf.h>
> @@ -1033,7 +1033,7 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
>  		return dev_err_probe(dev, PTR_ERR(pctrl->gpio_base),
>  				     "Resource fail for GPIO controller\n");
>  
> -	device_for_each_child_node(dev, child)  {
> +	for_each_gpiochip_node(dev, child) {
>  		void __iomem *dat = NULL;
>  		void __iomem *set = NULL;
>  		void __iomem *dirout = NULL;
> @@ -1044,9 +1044,6 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
>  		u32 reg;
>  		int i;
>  
> -		if (!fwnode_property_read_bool(child, "gpio-controller"))
> -			continue;
> -
>  		ret = fwnode_property_read_u32(child, "reg", &reg);
>  		if (ret < 0)
>  			return ret;
> -- 
> 2.45.1.3035.g276e886db78b
> 

