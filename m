Return-Path: <linux-kernel+bounces-276080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DE7948E24
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5581F2699C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B7F1C379E;
	Tue,  6 Aug 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+ErW/qJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80A2A1CF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945066; cv=none; b=KcfaixXkx4efinowM79MvJ7J4H1M62aeS+vmGTjshSkv2NZRW3vqfdrrPINK1WC+kk1f3XzeLPR7KUPCwsT5ILD+lY2xOlUdYawRlKbFXAn2lcdJAchkGfOIYinUBVJAEVDv5k744eCWfPPSfFppTEEzf7OafSTUdp9t2zW2Q4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945066; c=relaxed/simple;
	bh=xvlWmoNogUmD3qBGQ19TVoZYTYc8M1BKmEGyuD33m8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LT586Wru89azUKZaxtAnDGLcKpD4DM7IYefMplhHJx1IVl0uOmuKAnymYrD+Nbj5EEejRJuVKIlnPZBJoZ0Qeqab1e1EKiu+/DdwFS2A0X0RVcLdeLX8h9i+xPwJCkjHRfY2zjfTAo8rroMvvosQmOtWCWF0547r3kSRpNJFtiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+ErW/qJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f024f468bso568237e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722945063; x=1723549863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnhDi/0kjN5mJjNXaKoVC7EZM9INIn8DBiyXxmsOlM4=;
        b=L+ErW/qJEWYWu4bAUrtvy/GFj28MuRjVjzyDe6KeZWEWULEQ4xe1f/YltsRlP5j0mn
         Erf1NPl3pzSUNzjz+4Rmu97n6xwIMJb4UgyOvK0WQ42euSWTaQAIi8Yn9O0EXEe/bEtE
         jtV6JkFnSGjJtJJVXcjuV++UcQxqh+yx53VS6EjJSw6hxT/AQmn3fEp6iaPLFFn+2UmI
         z49ZAP62GfYjPFjhWK68ayKI7ZLxBGB5/fEGmz1mpgec4C4BrEbID8lv7xJz52zjUXBg
         9Iwxmj2ip6UUvTEzt2lnwRWHpibUjWhDGc5bE+3pdkeZX1VdK3UpaKuUXCR7hmFoYF7g
         qmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722945063; x=1723549863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnhDi/0kjN5mJjNXaKoVC7EZM9INIn8DBiyXxmsOlM4=;
        b=Ao2un0eRLbngrahu9Sb9Qp3IU954EFd+Tbetua2Gm5JnLj2iD5HVoJrjYXQUZ4Zw6O
         zfTQv8QSwQtkeoGlXQvP1i0UtcARMRi3ogv8P4gVL3JuRc9x/Ye1QiWL+N23NjD8Xjuv
         gYtRMD089Ov2Otgck8/QwvvBFl+zc4Qfq0nuRNGmFXzHDdIIz3dWS6jy+VRcntEcqAZF
         15xVHnpTecfpuMf0fun+QBpqmAjFmyILgq2EcUfadGp747kMfP18wFSd2+MUAVhYDVI0
         S2qAfKJhz1jxt+lpiAdTh4QfFxw/2Gtr4nA0XYE8hyER2iTMrgsuzw0pKZeJvzXKH3NF
         HJLA==
X-Forwarded-Encrypted: i=1; AJvYcCWTKPX3lK7/bDeKLM0bG9Hh7cMnqlZZOVLVW0qxTKJTiAiWO/DgxObq7PgKrTeDCIp+576cSFW5hXpW+Usv0IanKxMoJy2pt1nAhM7T
X-Gm-Message-State: AOJu0Yyac4vWrjMHA2u5lHpdd5+1n9v1jCJnix5OyVpNuz6Tzx2gTXRy
	dbFCkeMrJt/BiDGfOoOiaWUe8IPUR5Cgjqw/MNAvmDqEfCC3Xsr7
X-Google-Smtp-Source: AGHT+IHrRQTrrhm7mQcTDSmfMXD1VcaAFRx9t0p+O74E63ZhWKFmHdtr2zzGpPGaJJifRMqc9dpetA==
X-Received: by 2002:a05:6512:1dc:b0:530:c2f0:4a98 with SMTP id 2adb3069b0e04-530c2f04b82mr6248783e87.51.1722945061899;
        Tue, 06 Aug 2024 04:51:01 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba10fd9sm1451469e87.99.2024.08.06.04.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 04:51:01 -0700 (PDT)
Message-ID: <2eb39a8f-cc58-4774-836c-e6293300a4d9@gmail.com>
Date: Tue, 6 Aug 2024 14:51:00 +0300
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

Hello again!

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
> Something like the untested below should work. That would make your
> info:
> 
> 	struct irq_domain_info info = {
> 		.fwnode		= fwnode,
> 		.size		= chip->num_irqs,

Based on my code reading, the .size is used for allocating the "revmap". 
Looking at the info struct for existing implementation of the 
irq_domain_create_legacy(), the .size is set as:

.size		= first_hwirq + size,

> 		.hwirq_max	= chip->num_irqs,

Also, the irq_domain_create_legacy() sets hwirq_max as:

.hwirq_max	= first_hwirq + size.

see:

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

Lookin at this, the existing code calls irq_domain_associate_many() with 
the given size parameter (without the + first_hwirq which is assigned to 
.size).

I think this is not aligned with what the patch below results (and yes, 
I know Thomas told it's untested).

I'd better admit I am not 100% sure how the legacy domains work and that 
I don't (any more) fully trust on my ability to flawlessly interpret the 
code ;) Hence I'd rather learn from a small explanation (what is the 
expected .size) than by fixing this after I see regression reports from 
real users of the irq_domain_create_legacy() :)

So, any guidance as to what the revmap allocation size should be (the 
info->size), and what should be the size for the 
irq_domain_associate_many()?

Thanks...

  Yours,
	-- Matti

>                  .virq_base	= irq_base,
> 		.ops		= &regmap_domain_ops,
> 		.host_data	= d,
> 		.name_suffix	= chip->domain_suffix,
> 	};
> 
> Thanks,
> 
>          tglx
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


