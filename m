Return-Path: <linux-kernel+bounces-274694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0077F947B80
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB171C211E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A17158DDF;
	Mon,  5 Aug 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWgd2tVL"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C01514C9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863092; cv=none; b=SX826nh/28tzDyGR+3vAqjvJWE7TGFgaQmvxZmAOljGW/icVZYSsAlBrhcodPaeYKwuzsCtHaYwmfiBCPSznZj/DcMikpBAVr44HrZmF4XVgpSzED9b6v5jkxHxQYPa+vlB1X0STuVAn+LlRlZFsiQ5gLTaKXIhM86oCjP1WSXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863092; c=relaxed/simple;
	bh=RG90HHYc6OzXo+NplACTRv1RrfkRqZ3iehbTnowNAts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fclva9NUMAvpfnzy9puBL7s2yAtlHwfiJFDpUTOK48PoZ0/rm1Qs3BziPaLO3E+hSZHTu7zFw7w1IUDQ1MfT55DKiDahVv/Cjy8I9vPxYWl1eO6F7gOBnUR03eBlU6amgltRN5UfgIODKqTYoQNpeqSVc5TGHBU9FEwMaxSIpho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWgd2tVL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so160850471fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722863089; x=1723467889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UPvoFWAosmkQZfJ1jeoAAcWQJYWloLjtPs3i8I2HZNc=;
        b=NWgd2tVLK3/iuPbo+Dx8+V8TS0fmzx6yE++Wl3nC80X6cEcVLq6xeEzBfhQotuVPxY
         sMBankLpDwK+TFOkBzZ0t987Dh1Gt5t2w4CSgwNLNvg9kjFkFC0SKpsGNGciSXd0SpmP
         MVCBdKLVAd2x/n+CaxpBTTi+UxR96yH64woe8Z6KC4ahWrGSruGjW7zfZI+s9CuEYlRD
         tZzkwfDFW4YADCfwsEg05h8s01Y90N/xFwS/ZdnIsPVfpaFTAf2o6F0+4f7m5MnbI8mT
         khxAPPXsuOcZfkkEpqDSiAPYYTn+vgt0Kp4YUPz9/T2pmncvwKOyqWtsTb+DvUS3/SJw
         V1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722863089; x=1723467889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPvoFWAosmkQZfJ1jeoAAcWQJYWloLjtPs3i8I2HZNc=;
        b=ujBJDiX0cmbhbcTLRKIeCIYGGim3FXBo0T35eUk93BSnNx0YgaCaX2b2N+z+LvRWxb
         aDtmeFR723WOzGRQWYjHS7+bjLxou9VxF9pda33LmD/pvDybiKpKAoG4fWErHQPoIBfe
         S6o1T+q1JefAgjJDnPprIBUmJDHfJg1F3pJLHZBZZ08Q9TPLikMfIs2Ap+8gXnf2fRX6
         eUMXAY8wPLk1FWlKEQkmrUtI8E8R8f1LyyzbSwD1LayebpHafoMiv4LZLKaDh67038ij
         TS2MRrnOEr3IMa1/MlGXeG70308cVOJ+TnLomYTTRGnXasH2FvCRIaTgzjj08sLg0G1Z
         bmVg==
X-Forwarded-Encrypted: i=1; AJvYcCVZydwKJmXSkiaYyVO2uK9gTLInrtoDLSn12NIxqfvrG+CZJI3VGn60eIzRtKIutFDC1lkZsajJnUfvuAcEExUzRXs5O11sDaqKlTNs
X-Gm-Message-State: AOJu0YyKUmycEhi+qH0QgORyToixIU9bX0c1QP8+PC3ILl8rEpWzm0cX
	Vj3DkSlPd9mcDO6qSgOXqhBp8Fyz+RJ6fBhnEVe6JCnRNhKvxRvJS0LQrQ==
X-Google-Smtp-Source: AGHT+IEwn+QFz6JmOnQEya83uTR3iB202OZ14NI9Y2TfGle0gVpUFi868MPuS3f7VwgLro3+WDiVeA==
X-Received: by 2002:a2e:8ed6:0:b0:2ef:21b3:cdef with SMTP id 38308e7fff4ca-2f15aabd054mr74530251fa.25.1722863087987;
        Mon, 05 Aug 2024 06:04:47 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1864f6sm10868151fa.22.2024.08.05.06.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 06:04:47 -0700 (PDT)
Message-ID: <dd2f4a1e-1861-4838-9ba2-668bcde0e2b5@gmail.com>
Date: Mon, 5 Aug 2024 16:04:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] regmap: Allow setting IRQ domain name suffix
To: Thomas Gleixner <tglx@linutronix.de>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1719830185.git.mazziesaccount@gmail.com>
 <fd13fcc9dd785d69b8450c8e9c26d860fcab7da8.1719830185.git.mazziesaccount@gmail.com>
 <87plrpvzmg.ffs@tglx> <12228ec5-cf2f-47b2-842d-ce336d921260@gmail.com>
 <87jzhpscql.ffs@tglx>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <87jzhpscql.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/13/24 15:22, Thomas Gleixner wrote:
> Matti!
> 
> On Mon, Jul 08 2024 at 15:40, Matti Vaittinen wrote:
>> On 7/7/24 21:13, Thomas Gleixner wrote:
>>>
>>> I wonder whether this can be handled at the core. Let me stare at it.
>>
>> Thanks Thomas! I'll wait for your ideas before re-spinning this series :)
> 
> Something like the untested below should work.

Thanks Thomas!

Sorry for a very late reply. I have tried to minimize my "computer time" 
during the last 1.5 months (I really needed a break) - but now I'm 
getting back to the business...

I used your patch below with the BD96801 driver and tested the changes 
to the extent that the IRQ domains were successfully created and names 
and numbers seemed reasonable. (I didn't yet try to make the PMIC to do 
a real IRQ though although it should be doable using the WDG.)

Do you want me to include this in my series (keeping you as author), or 
do you prefer going through the patch process yourself?

Yours,
	-- Matti

> ---
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -291,6 +291,9 @@ struct irq_domain_chip_generic_info;
>    * @hwirq_max:		Maximum number of interrupts supported by controller
>    * @direct_max:		Maximum value of direct maps;
>    *			Use ~0 for no limit; 0 for no direct mapping
> + * @hwirq_base:		The first hardware interrupt number (legacy domains only)
> + * @virq_base:		The first Linux interrupt number for legacy domains to
> + *			immediately associate the interrupts after domain creation
>    * @bus_token:		Domain bus token
>    * @ops:		Domain operation callbacks
>    * @host_data:		Controller private data pointer
> @@ -307,6 +310,8 @@ struct irq_domain_info {
>   	unsigned int				size;
>   	irq_hw_number_t				hwirq_max;
>   	int					direct_max;
> +	unsigned int				hwirq_base;
> +	unsigned int				virq_base;
>   	enum irq_domain_bus_token		bus_token;
>   	const struct irq_domain_ops		*ops;
>   	void					*host_data;
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -267,13 +267,20 @@ static void irq_domain_free(struct irq_d
>   	kfree(domain);
>   }
>   
> -/**
> - * irq_domain_instantiate() - Instantiate a new irq domain data structure
> - * @info: Domain information pointer pointing to the information for this domain
> - *
> - * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
> - */
> -struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
> +static void irq_domain_instantiate_descs(const struct irq_domain_info *info)
> +{
> +	if (!IS_ENABLED(CONFIG_SPARSE_IRQ))
> +		return;
> +
> +	if (irq_alloc_descs(info->virq_base, info->virq_base, info->size,
> +			    of_node_to_nid(to_of_node(info->fwnode))) < 0) {
> +		pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
> +			info->virq_base);
> +	}
> +}
> +
> +static struct irq_domain *__irq_domain_instantiate(const struct irq_domain_info *info,
> +						   bool cond_alloc_descs)
>   {
>   	struct irq_domain *domain;
>   	int err;
> @@ -306,6 +313,13 @@ struct irq_domain *irq_domain_instantiat
>   
>   	__irq_domain_publish(domain);
>   
> +	if (cond_alloc_descs && info->virq_base > 0)
> +		irq_domain_instantiate_descs(info);
> +
> +	/* Legacy interrupt domains have a fixed Linux interrupt number */
> +	if (info->virq_base > 0)
> +		irq_domain_associate_many(domain, info->virq_base, info->hwirq_base, info->size);
> +
>   	return domain;
>   
>   err_domain_gc_remove:
> @@ -315,6 +329,17 @@ struct irq_domain *irq_domain_instantiat
>   	irq_domain_free(domain);
>   	return ERR_PTR(err);
>   }
> +
> +/**
> + * irq_domain_instantiate() - Instantiate a new irq domain data structure
> + * @info: Domain information pointer pointing to the information for this domain
> + *
> + * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
> + */
> +struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
> +{
> +	return __irq_domain_instantiate(info, false);
> +}
>   EXPORT_SYMBOL_GPL(irq_domain_instantiate);
>   
>   /**
> @@ -413,28 +438,13 @@ struct irq_domain *irq_domain_create_sim
>   		.fwnode		= fwnode,
>   		.size		= size,
>   		.hwirq_max	= size,
> +		.virq_base	= first_irq,
>   		.ops		= ops,
>   		.host_data	= host_data,
>   	};
> -	struct irq_domain *domain;
> -
> -	domain = irq_domain_instantiate(&info);
> -	if (IS_ERR(domain))
> -		return NULL;
> -
> -	if (first_irq > 0) {
> -		if (IS_ENABLED(CONFIG_SPARSE_IRQ)) {
> -			/* attempt to allocated irq_descs */
> -			int rc = irq_alloc_descs(first_irq, first_irq, size,
> -						 of_node_to_nid(to_of_node(fwnode)));
> -			if (rc < 0)
> -				pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
> -					first_irq);
> -		}
> -		irq_domain_associate_many(domain, first_irq, 0, size);
> -	}
> +	struct irq_domain *domain = __irq_domain_instantiate(&info, true);
>   
> -	return domain;
> +	return IS_ERR(domain) ? NULL : domain;
>   }
>   EXPORT_SYMBOL_GPL(irq_domain_create_simple);
>   
> @@ -476,18 +486,14 @@ struct irq_domain *irq_domain_create_leg
>   		.fwnode		= fwnode,
>   		.size		= first_hwirq + size,
>   		.hwirq_max	= first_hwirq + size,
> +		.hwirq_base	= first_hwirq,
> +		.virq_base	= first_irq,
>   		.ops		= ops,
>   		.host_data	= host_data,
>   	};
> -	struct irq_domain *domain;
> +	struct irq_domain *domain = irq_domain_instantiate(&info);
>   
> -	domain = irq_domain_instantiate(&info);
> -	if (IS_ERR(domain))
> -		return NULL;
> -
> -	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
> -
> -	return domain;
> +	return IS_ERR(domain) ? NULL : domain;
>   }
>   EXPORT_SYMBOL_GPL(irq_domain_create_legacy);
>   

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


