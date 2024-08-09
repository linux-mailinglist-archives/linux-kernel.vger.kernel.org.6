Return-Path: <linux-kernel+bounces-280359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49394C979
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B691C22139
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D02168491;
	Fri,  9 Aug 2024 05:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcHrlwmF"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E27167DB8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723179824; cv=none; b=q0m8VP6DND+lKlLamcqEr0aWWkV7E/33n94pZse85SB3ltyAJFgo9tS/rHomHsnlzGcAx9cA0g83csyZ+h3SIskXLwf6r+xrMc8xlp9kU+uDQghc4THCFoY1kMmP3vO4UF6sOf9Cu+O+QSYiAwa7nU2a+kklDsSjTn4W+xD48Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723179824; c=relaxed/simple;
	bh=rITidkDISnWR760PL0E90/BH1W9wjogetByTS27sv4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=te6jdiBRUqgtf7SsLohY2KpCyew14TD8WAXD/TP748T+BbDPW5cVKU4DHh25Moycf4QHy1aOLFoIXpf0MQx2cRW01K3JmiHsEU3d3wReEAcP6kdB7WnepYuiC0s0Y3zi/821/93GXGZRPNw7r0pSlNrF/JjMAzCN4gLHQuR4RkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcHrlwmF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f189a2a841so15835661fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 22:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723179821; x=1723784621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahU7wuz36HVKomDPFA/AW5Ri2Gu+f74cB/od7YtNQZY=;
        b=kcHrlwmFN4qdkA1qAdK6KzloYqaxe7nVgHhSNVx5Q/1uS1LCWgaVUoppTu5NbKVwuU
         aOyK8VW6YZoZqPWoWGzVIEiIKRVyJ3JUuK07WKyDlXoIjWhiRSNz4hg3xWOp0Ix0KMWj
         wkARtp02qePw7rLZs21x9DzrvmUKcKGFd8Up3FwcrgWlWzOvd26gRB8y9UmVrE0ls9Dd
         NVS1NBeX0YPu/UwQ2NFqyBDpBk3OP9hpZ1kMSMfkD2Ei8zwIS5LskjdyjxvKvx7FMNf+
         /WgHeu7KB8gZXxg7EaaCqMPd2hjvVf2/JnEuFEhiWWcKiTs5CSHayXWrdlCBf0NTW8Li
         bSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723179821; x=1723784621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahU7wuz36HVKomDPFA/AW5Ri2Gu+f74cB/od7YtNQZY=;
        b=lHxcOgIRpFb16wLU3aEJeIYzWTtfyefmoGr6y3go5tvJqklY52BQY9MSDfMxgk9gli
         o7xBu6BWVMN/Uc63oMUMZXOMTAZ1qCU2+iL+AOeXEknF0650uAFCd8GI2tm9w4pRNFDT
         9A686kvRz2Mnxwm7U3XEjF1JkUw8VCY+YGZeJiT0vFq1SsdOJ+CciGc/8ntPpMMO9F5N
         SyPscLNpNC3yaBxlZX6NuGOyFXos1Oph1vr68SlwLmo143/8OtTVeWxj6PAsMAj7zdNo
         qyQf6DrYh+eUEu485TZbN4zAHOjO/N2k1yPRtNShRSz20bGKD7cWuF/egJlfatIB/njx
         noYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXuZXO+0Yr9RVcjEKL+x6BsYLYwYY0jxK4oTx+F2Ionv1Y8Qtg01gAWNaTTeFGZ9UxBW6OdOybsf6Ucd7R0L9fQSS2/SWA+xnMExCG
X-Gm-Message-State: AOJu0Yzi/P5zc5FVThsllEzmKOr8wDKTJS4Mbe4FaRF9P+5s2WMOEeXx
	Dd4Ubdum+KH4xe30BF0CRIbsosd0zcnK8ZNJiPbMmaYUzwOPrR7K
X-Google-Smtp-Source: AGHT+IH+bQfmVv26IW3h8wJ8YfybcKJe1lGe3U/30bwp1Jpy17SinCi0UOYxRn8o30+i1FLaH0d0dg==
X-Received: by 2002:a05:6512:3ba4:b0:530:c323:46a8 with SMTP id 2adb3069b0e04-530ee9bc0edmr229091e87.23.1723179820225;
        Thu, 08 Aug 2024 22:03:40 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de4022d6sm844372e87.112.2024.08.08.22.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 22:03:39 -0700 (PDT)
Message-ID: <3f77a70a-2bcb-4cb2-ac4f-a5d785f6f7ff@gmail.com>
Date: Fri, 9 Aug 2024 08:03:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2a 2/3] irqdomain: Allow giving name suffix for domain
To: Thomas Gleixner <tglx@linutronix.de>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <7a048c0139e79beb46d887b0cd5a620963ff8ef8.1723120028.git.mazziesaccount@gmail.com>
 <877ccqvkfm.ffs@tglx> <874j7uvkbm.ffs@tglx> <871q2yvk5x.ffs@tglx>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <871q2yvk5x.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 23:23, Thomas Gleixner wrote:
> 
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Devices can provide multiple interrupt lines. One reason for this is that
> a device has multiple subfunctions, each providing its own interrupt line.
> Another reason is that a device can be designed to be used (also) on a
> system where some of the interrupts can be routed to another processor.
> 
> A line often further acts as a demultiplex for specific interrupts
> and has it's respective set of interrupt (status, mask, ack, ...)
> registers.
> 
> Regmap supports the handling of these registers and demultiplexing
> interrupts, but the interrupt domain code ends up assigning the same name
> for the per interrupt line domains. This causes a naming collision in the
> debugFS code and leads to confusion, as /proc/interrupts shows two separate
> interrupts with the same domain name and hardware interrupt number.
> 
> Instead of adding a workaround in regmap or driver code, allow giving a
> name suffix for the domain name when the domain is created.
> 
> Add a name_suffix field in the irq_domain_info structure and make
> irq_domain_instantiate() use this suffix if it is given when a domain is
> created.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> Revision history:
> v2 => v2a:
>     Update to name allocation cleanup patch. Fix the invalid NULL return.
> v1 => v2:
>   - typofix in comment. 'collison' to 'collision'.
> ---
>   include/linux/irqdomain.h |    3 +++
>   kernel/irq/irqdomain.c    |   32 +++++++++++++++++++++++---------
>   2 files changed, 26 insertions(+), 9 deletions(-)
> 
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -295,6 +295,8 @@ struct irq_domain_chip_generic_info;
>    * @virq_base:		The first Linux interrupt number for legacy domains to
>    *			immediately associate the interrupts after domain creation
>    * @bus_token:		Domain bus token
> + * @name_suffix:	Optional name suffix to avoid collisions when multiple
> + *			domains are added using same fwnode
>    * @ops:		Domain operation callbacks
>    * @host_data:		Controller private data pointer
>    * @dgc_info:		Geneneric chip information structure pointer used to
> @@ -313,6 +315,7 @@ struct irq_domain_info {
>   	unsigned int				hwirq_base;
>   	unsigned int				virq_base;
>   	enum irq_domain_bus_token		bus_token;
> +	const char				*name_suffix;
>   	const struct irq_domain_ops		*ops;
>   	void					*host_data;
>   #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -140,11 +140,14 @@ static int alloc_name(struct irq_domain
>   }
>   
>   static int alloc_fwnode_name(struct irq_domain *domain, const struct fwnode_handle *fwnode,
> -			     enum irq_domain_bus_token bus_token)
> +			     enum irq_domain_bus_token bus_token, const char *suffix)
>   {
> -	char *name = bus_token ? kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
> -				 kasprintf(GFP_KERNEL, "%pfw", fwnode);
> +	const char *sep = suffix ? "-" : "";
> +	const char *suf = suffix ? : "";
> +	char *name;
>   
> +	name = bus_token ? kasprintf(GFP_KERNEL, "%pfw-%s%s%d", fwnode, suf, sep, bus_token) :
> +			   kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, suf);
>   	if (!name)
>   		return -ENOMEM;
>   

Thanks Thomas!
This looks much, much cleaner to me compared to my original version :)

> @@ -172,13 +175,24 @@ static int alloc_unknown_name(struct irq
>   	return 0;
>   }
>

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


