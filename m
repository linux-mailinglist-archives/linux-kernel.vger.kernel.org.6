Return-Path: <linux-kernel+bounces-213606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A15A907793
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4232286B81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEBB12EBC7;
	Thu, 13 Jun 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0g3rWO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15684206C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294040; cv=none; b=JQJB7q5yyl6LpTAKM2BZaH1T8wcVm5OUXUI6wPh6r0dOgAcWpMZevubPQbyiF9GEBEqfIWkdATzhdXePWbCyQLYHgwXsdxosIzM101f39nEPSt3lOIZnkoEp6uBj1HdC/lFd8H90YIAT9PctdauBRICc6rPhQBFzPpw9aRi4Dg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294040; c=relaxed/simple;
	bh=9bX6aH9TVgdh3z6dFkWKTbbnUkvQT6dIwcBQGXzkhpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHa6ABM6oP0D/uavBOB18t8zttQUpJVRGA417/IoKpo6jqLoHgfLtZ2i29PuBwXqqfD1JqGRl4Ko6UOI2SWb3xQVy7otHVREG0oZSZH6/uy/1A6Pb3D1WO11X2FJ01PF79J9g+zP8SC8MosmR69PP3lY7LgqS1SNTCZJZjTbFdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0g3rWO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC2FC2BBFC;
	Thu, 13 Jun 2024 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718294039;
	bh=9bX6aH9TVgdh3z6dFkWKTbbnUkvQT6dIwcBQGXzkhpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0g3rWO2ziEBFskClc+W1HAolP55Z8cvoURcyA4lvGyoWj55U4WoNiU1svwwfjHLS
	 fcSTpbZgEiN5nX0ojh+srOz+SSj1I+/dfgpnE6xUC/jW58oGoTas9nnqCjzghyM/SB
	 gvet3ZBQdkUWgMwgELpe81VgoDEXfSOtVCbxO29elI+BpmBmnv2+WBoDO3XKk+jxns
	 3RCcPfWtURXC+HAhs/3320jpT/b++iwLKqtxU/jtIofF9CyficzvfiGUj3Lfyqcaja
	 Myj6FjlHfenzs8cfiibaPOGEdNFMPc9cO98UlltTJ9Xti7j+KnBBhB4cdiSHkmB822
	 PE5JJQFplzp4Q==
Date: Thu, 13 Jun 2024 16:53:56 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/1] mfd: lm3533: Move to new GPIO descriptor-based
 APIs
Message-ID: <20240613155356.GK2561462@google.com>
References: <20240605191458.2536819-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605191458.2536819-1-andriy.shevchenko@linux.intel.com>

On Wed, 05 Jun 2024, Andy Shevchenko wrote:

> Legacy GPIO APIs are subject to remove. Convert the driver to new APIs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: left platform data in place (Johan), and rebased this patch
>  drivers/mfd/lm3533-core.c  | 24 +++++++-----------------
>  include/linux/mfd/lm3533.h |  5 ++---
>  2 files changed, 9 insertions(+), 20 deletions(-)

It would be nice to get Johan's RB on this.

> diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
> index c1219e608c5f..0a2409d00b2e 100644
> --- a/drivers/mfd/lm3533-core.c
> +++ b/drivers/mfd/lm3533-core.c
> @@ -11,7 +11,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/mfd/core.h>
>  #include <linux/regmap.h>
> @@ -225,14 +225,12 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
>  
>  static void lm3533_enable(struct lm3533 *lm3533)
>  {
> -	if (gpio_is_valid(lm3533->gpio_hwen))
> -		gpio_set_value(lm3533->gpio_hwen, 1);
> +	gpiod_set_value(lm3533->hwen, 1);
>  }
>  
>  static void lm3533_disable(struct lm3533 *lm3533)
>  {
> -	if (gpio_is_valid(lm3533->gpio_hwen))
> -		gpio_set_value(lm3533->gpio_hwen, 0);
> +	gpiod_set_value(lm3533->hwen, 0);
>  }
>  
>  enum lm3533_attribute_type {
> @@ -483,18 +481,10 @@ static int lm3533_device_init(struct lm3533 *lm3533)
>  		return -EINVAL;
>  	}
>  
> -	lm3533->gpio_hwen = pdata->gpio_hwen;
> -
> -	if (gpio_is_valid(lm3533->gpio_hwen)) {
> -		ret = devm_gpio_request_one(lm3533->dev, lm3533->gpio_hwen,
> -					GPIOF_OUT_INIT_LOW, "lm3533-hwen");
> -		if (ret < 0) {
> -			dev_err(lm3533->dev,
> -				"failed to request HWEN GPIO %d\n",
> -				lm3533->gpio_hwen);
> -			return ret;
> -		}
> -	}
> +	lm3533->hwen = devm_gpiod_get(lm3533->dev, NULL, GPIOD_OUT_LOW);
> +	if (IS_ERR(lm3533->hwen))
> +		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen), "failed to request HWEN GPIO\n");
> +	gpiod_set_consumer_name(lm3533->hwen, "lm3533-hwen");
>  
>  	lm3533_enable(lm3533);
>  
> diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
> index 77092f6363ad..69059a7a2ce5 100644
> --- a/include/linux/mfd/lm3533.h
> +++ b/include/linux/mfd/lm3533.h
> @@ -16,6 +16,7 @@
>  	DEVICE_ATTR(_name, S_IRUGO | S_IWUSR , show_##_name, store_##_name)
>  
>  struct device;
> +struct gpio_desc;
>  struct regmap;
>  
>  struct lm3533 {
> @@ -23,7 +24,7 @@ struct lm3533 {
>  
>  	struct regmap *regmap;
>  
> -	int gpio_hwen;
> +	struct gpio_desc *hwen;
>  	int irq;
>  
>  	unsigned have_als:1;
> @@ -69,8 +70,6 @@ enum lm3533_boost_ovp {
>  };
>  
>  struct lm3533_platform_data {
> -	int gpio_hwen;
> -
>  	enum lm3533_boost_ovp boost_ovp;
>  	enum lm3533_boost_freq boost_freq;
>  
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

-- 
Lee Jones [李琼斯]

