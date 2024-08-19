Return-Path: <linux-kernel+bounces-292136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871F2956B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8B5B24200
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A516C42C;
	Mon, 19 Aug 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWeyp7gB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0B1667E1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073436; cv=none; b=bF1qHhOnblPEnrFNAb7FzCZXbbSupTuCqNSPh+pYmt5j7k8zmIRo/m70vt+BIc7fddqMxfSm+IS9FLOK1ot3nOe4c7RSAhlCbm3hAGjrZKEO+5m9CGE4Itz90F7ty6DDN0GUBTvi3hHn2nUJF7PMZw3TjkSA86jo1UqE9jCKCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073436; c=relaxed/simple;
	bh=vIwi+Ho3hcTzwljg2H57BFDuQAi75Ju4VGTPIMbZtJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cauaDsdUY8Jb7nB5A1puB3yz7CzHbDXWk6SWPA+R8jdq4TG6ugpiAME+VzusM7Et2CCgsmuzP4InrRUOwp0M8Tra7bJ5oHrFI7ZnKG4Udo9JO6nqoxGtVeHxUCxXr0yPOGUhPVJ9isvLbUooPtqCYT3RtQ82RfqpmcOzJLGfW40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWeyp7gB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724073433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RZOxsSOUpslXvj4HgMWa1YWBn0fhZwVZ+lWFi2Py/0=;
	b=jWeyp7gBQXkB8Ro/e4iteyyk61WqD0RLpYj09iCFBtOnUjY6xMUYEAOL07nRbx1kaHZZTn
	li/iin+cwSnDPrwsYoDgaSwQgd8pcTNsJ/tFUqsB85/qny/XlbaTHjnuWlBT8xgjshiMug
	ni4lpqfqt/h2GY/w8ISmpUitNPP7F34=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-kfBxdwr8Oy6YqshpwvIBJg-1; Mon, 19 Aug 2024 09:17:11 -0400
X-MC-Unique: kfBxdwr8Oy6YqshpwvIBJg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5bedb783908so902433a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073431; x=1724678231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RZOxsSOUpslXvj4HgMWa1YWBn0fhZwVZ+lWFi2Py/0=;
        b=MrOTjBytmQjONJGIQE5JtIZI5Kw5sK+g6u77lfFI2BZxkiSHQ7ebZC6yYmuU3fV9QG
         0Ve02t4V4TpVH8HkcKKn16OMCv1GwomyLob3cMK9osZbH3xe7jhK0YkmxidCgMjlErG8
         za+1gQ85z87cKjwak4IyeerfS684oOKlMSArrYNIkKlQ77HHT3Uu2Y294qYlC/D6LIa4
         MTtTeDDt0qCm3gmh1wCXovOLPIOZBY2APlhRLagUXhE7jHDwI3ltIlz1OnvZpeSiIwbz
         GT1O8TM/NTv/uRCEzmEP3iNlVD7luwVslX9mP8l0KhdUcMXacKyNnWwc7zf63nhZ3E+s
         ONow==
X-Forwarded-Encrypted: i=1; AJvYcCU26uaYK3723dy3KKLnuDhzF5EgOwih/f4oRufq5nFViwWcQjsiI+2TV46mBK03a5mv4qDSz6ZXXR5qSbil3A2mBkMNGBluIRNkkV8u
X-Gm-Message-State: AOJu0Yz4n5rd1pfqG4rfhcRJwoh8WamX8pP/cYbs2CP2WxTKnPKnLZWC
	pjwpv/VqkK8WOS/htfoLOGtW5VImm1Ip6CaqNIiz0faCw/MxevbU9JmQhWAvJUtggnDPfVRLZlY
	ch9TBTcTDXMkWtj35PPCrSYwUPRu61GwuuMMFtiXVG2O2PBzYo1t/Lm3ff0fqTQ==
X-Received: by 2002:a05:6402:2681:b0:5be:dd2d:83 with SMTP id 4fb4d7f45d1cf-5bedd2d02e2mr5286434a12.6.1724073430585;
        Mon, 19 Aug 2024 06:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRjAeOgQEM8IvDHQXEfwHvUn1ankhtBMfeAHX9eXd6GBDhylg0X3WB0PuQoK1JlETbRBPJmg==
X-Received: by 2002:a05:6402:2681:b0:5be:dd2d:83 with SMTP id 4fb4d7f45d1cf-5bedd2d02e2mr5286412a12.6.1724073429979;
        Mon, 19 Aug 2024 06:17:09 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081ad6sm5524484a12.89.2024.08.19.06.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:17:09 -0700 (PDT)
Message-ID: <a44bb4d0-c149-4dd7-882b-f87497725dd9@redhat.com>
Date: Mon, 19 Aug 2024 15:17:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: serial-multi-instantiate: Don't require
 both I2C and SPI
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
References: <20240814132939.308696-1-rf@opensource.cirrus.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240814132939.308696-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/14/24 3:29 PM, Richard Fitzgerald wrote:
> Change the Kconfig dependency so that it doesn't require both I2C and SPI
> subsystems to be built. Make a few small changes to the code so that the
> code for a bus is only called if the bus is being built.
> 
> When SPI support was added to serial-multi-instantiate it created a
> dependency that both CONFIG_I2C and CONFIG_SPI must be enabled.
> Typically they are, but there's no reason why this should be a
> requirement. A specific kernel build could have only I2C devices
> or only SPI devices. It should be possible to use serial-multi-instantiate
> if only I2C or only SPI is enabled.
> 
> The dependency formula used is:
> 
>   depends on (I2C && !SPI) || (!I2C && SPI) || (I2C && SPI)
> 
> The advantage of this approach is that if I2C=m or SPI=m then
> SERIAL_MULTI_INSTANTIATE is limited to n/m.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> Changes from V1:
> Use a different 'depends on' formula so that serial-multi-instantiate
> must be built as a module if any dependencies are a module.
> 
>  drivers/platform/x86/Kconfig                  |  3 +-
>  .../platform/x86/serial-multi-instantiate.c   | 32 ++++++++++++++-----
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 665fa9524986..0dcf4d8eac56 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -999,7 +999,8 @@ config TOPSTAR_LAPTOP
>  
>  config SERIAL_MULTI_INSTANTIATE
>  	tristate "Serial bus multi instantiate pseudo device driver"
> -	depends on I2C && SPI && ACPI
> +	depends on ACPI
> +	depends on (I2C && !SPI) || (!I2C && SPI) || (I2C && SPI)
>  	help
>  	  Some ACPI-based systems list multiple devices in a single ACPI
>  	  firmware-node. This driver will instantiate separate clients
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index 3be016cfe601..7c04cc9e5891 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -83,11 +83,15 @@ static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
>  
>  static void smi_devs_unregister(struct smi *smi)
>  {
> +#if IS_REACHABLE(CONFIG_I2C)
>  	while (smi->i2c_num--)
>  		i2c_unregister_device(smi->i2c_devs[smi->i2c_num]);
> +#endif
>  
> -	while (smi->spi_num--)
> -		spi_unregister_device(smi->spi_devs[smi->spi_num]);
> +	if (IS_REACHABLE(CONFIG_SPI)) {
> +		while (smi->spi_num--)
> +			spi_unregister_device(smi->spi_devs[smi->spi_num]);
> +	}
>  }
>  
>  /**
> @@ -258,9 +262,15 @@ static int smi_probe(struct platform_device *pdev)
>  
>  	switch (node->bus_type) {
>  	case SMI_I2C:
> -		return smi_i2c_probe(pdev, smi, node->instances);
> +		if (IS_REACHABLE(CONFIG_I2C))
> +			return smi_i2c_probe(pdev, smi, node->instances);
> +
> +		return -ENODEV;
>  	case SMI_SPI:
> -		return smi_spi_probe(pdev, smi, node->instances);
> +		if (IS_REACHABLE(CONFIG_SPI))
> +			return smi_spi_probe(pdev, smi, node->instances);
> +
> +		return -ENODEV;
>  	case SMI_AUTO_DETECT:
>  		/*
>  		 * For backwards-compatibility with the existing nodes I2C
> @@ -270,10 +280,16 @@ static int smi_probe(struct platform_device *pdev)
>  		 * SpiSerialBus nodes that were previously ignored, and this
>  		 * preserves that behavior.
>  		 */
> -		ret = smi_i2c_probe(pdev, smi, node->instances);
> -		if (ret != -ENOENT)
> -			return ret;
> -		return smi_spi_probe(pdev, smi, node->instances);
> +		if (IS_REACHABLE(CONFIG_I2C)) {
> +			ret = smi_i2c_probe(pdev, smi, node->instances);
> +			if (ret != -ENOENT)
> +				return ret;
> +		}
> +
> +		if (IS_REACHABLE(CONFIG_SPI))
> +			return smi_spi_probe(pdev, smi, node->instances);
> +
> +		return -ENODEV;
>  	default:
>  		return -EINVAL;
>  	}


