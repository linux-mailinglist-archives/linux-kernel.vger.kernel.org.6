Return-Path: <linux-kernel+bounces-536826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34150A484BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F4B18969C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10725F975;
	Thu, 27 Feb 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="eidkHi4r"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CCF1DE3C1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672777; cv=none; b=qSqLRdk5qyrq61CRwwf9wp0UKBwHMN061JKYErNN5M1u2njL0XOqBS437Pfh4W/j2Dy4alwYByAk+hqiR5amUBdgfylns7hcS5yYuLigtdZFGprYne4VvmME92/Qp2VxMfzxazaLbU6uv4J7YEbE3R1vR7GwMTf9EgQq++pi8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672777; c=relaxed/simple;
	bh=u/jEDuM2cZEF60dp/4fSw3VAkOYWYed4gReCbmcZt2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbFQNZqD3/PM1DsBbgBj8J3t1VeiwCrI1ZHexyw86Gs+hG7ud057jUwOyUBRp0XWvSykMG8Fr8+hhqIXdVeMZai66oyKbpTyXUpVeNjM/AdnLwESWW033P9+WSH0Gd05roXJxDHby7CDBDXzzaDVYq9cuWByCkxJNhTU9xlIj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=eidkHi4r; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce87d31480so3912995ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1740672774; x=1741277574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4a+PIYpn9cYVWDOKIU06eghAJvUip+lThQ1gAkAfoE=;
        b=eidkHi4r87Fldfjn8a20pDRsC5czfcZEKFOpY4yI9jU3uuvB/0NPzEwwHG0HK7V0uz
         Px9JEXICNZ7IUq3XNhB9eNDggzSNiAxdP6spz0YpSt0eVMf8q+Q2uAz6242vrs+cXpda
         ZW1pSPKmHmVTf6W8Tfx7BISbP5dtXecGlRMnvRJlDAUqJgdZ/Fvlmxs7RzUz64MLDKOu
         zgYhspehtPd+Wk0KhKkPmIfKFoMxv3mq31cWgtabi1yoR1QHSokfnJwVU7m9w9plrlpx
         38H3S0RRrtpnGwl14RB6HeYtD1wlSI7w1enZ1GOW4gTvwkvU3SbxSfXhCGs/FAV9giUP
         ETSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672774; x=1741277574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4a+PIYpn9cYVWDOKIU06eghAJvUip+lThQ1gAkAfoE=;
        b=L8tZg7UYb3jByAlDLZK179/ot3Y+RvWLKkzZreQ0S5N63KcRh1PVerLanQ2OlVpZ5q
         OULIHX2o5IpJ5+FlRA6OzliNgpImdvyPNkdjyHdTkJDG61h+zyulOt7HpOX91OZm7C0H
         lSkrK3VSP+9RHKJbq4pFNNfMRqAEcI3t54KxljQWUQ3zm82kq6X7zR7g43gbB//E4DZh
         0rV7keiMNytzSb8JLLCMyX90o9ivMWDq6luTNjp84pLtOWpNGo5YVFVZKx4+Icao9/Tx
         UjRFOuZTvLmvQjwrXxMottTv4jaz5+EeBecSXGnUOrYAN705OqYMJQY8ltbCs6lbFkW2
         k0cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQRUgIet+vKImhZnc0OcT3UV5AupIXYbv6r9WbOkuibhiqdeuIl36FVc//uhnP3PHqFuVHVOjJixhgBvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTEOfS4lGBI5rHqXFzbgSKoDbBfzdxSwCaFfMH4EQE2rqVx6Z
	hUnWyBkwbcAwJoKRkYMaENht1DYMO15zcb6bIQKbScP4E2tKVge+btnrVhv9/M4=
X-Gm-Gg: ASbGncvXfppHJo+JCj6t+HHhNM658rj1BNNbFjThWsaObEEtgDVdJnzWaM5Pse3l5K7
	RbK1NJ0ZaaYPwabQSCd6R491pOqQjZb/Mmbb/nXxJxSU149E6tcdysacnRnGJ0UsQNVwQpDEzJB
	hCJJYuqSI12/EXHhubAo+Bbl0zTqm9MROTeVishMRVgqTsJsBiT1fpFz2tQS9ItUJ/UW8+DJ/10
	ryWbBfPFBoA7O66Bj0fazmfEu3DicROdh+NwAQXazZJEawNpBhA8QNDHMpnA1oAzuHZhLxxMzCv
	EMEIeTgp3X5Idu9puhom7BlfNi1lx94VGRJFM3hUZ1ouyI/V7m6rrfZtvPG+2dXvjQ==
X-Google-Smtp-Source: AGHT+IECEOEF/3IgUpjExo3hn+o7d72t1ArCxVXIIzsvV1Vpk9+T4m/ul07rs6wpKxf4ijf45waAXQ==
X-Received: by 2002:a92:c545:0:b0:3d1:79ec:bef2 with SMTP id e9e14a558f8ab-3d2fecce699mr113973395ab.6.1740672773762;
        Thu, 27 Feb 2025 08:12:53 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3deeca7ffsm3742305ab.53.2025.02.27.08.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:12:53 -0800 (PST)
Message-ID: <8fce8a9c-7946-4e3c-bbf3-25f8b4f4466f@riscstar.com>
Date: Thu, 27 Feb 2025 10:12:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] irqdomain: support three-cell scheme interrupts
To: Yixun Lan <dlan@gentoo.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>
Cc: Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
References: <20250227-04-gpio-irq-threecell-v1-0-4ae4d91baadc@gentoo.org>
 <20250227-04-gpio-irq-threecell-v1-1-4ae4d91baadc@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250227-04-gpio-irq-threecell-v1-1-4ae4d91baadc@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 5:24 AM, Yixun Lan wrote:
> The is a prerequisite patch to support parsing three-cell
> interrupts which encoded as <instance hwirq irqflag>,
> the translate function will always retrieve irq number and
> flag from last two cells.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>   kernel/irq/irqdomain.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index ec6d8e72d980f604ded2bfa2143420e0e0095920..cb874ab5e54a4763d601122becd63b6d759e55d2 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1208,10 +1208,17 @@ int irq_domain_translate_twocell(struct irq_domain *d,
>   				 unsigned long *out_hwirq,
>   				 unsigned int *out_type)
>   {

This function is meant for "twocell".  There is also another function
irq_domain_translate_onecell().  Why don't you just create
irq_domain_translate_threecell" instead?

					-Alex


> +	u32 irq, type;
> +
>   	if (WARN_ON(fwspec->param_count < 2))
>   		return -EINVAL;
> -	*out_hwirq = fwspec->param[0];
> -	*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> +
> +	irq = fwspec->param_count - 2;
> +	type = fwspec->param_count - 1;
> +
> +	*out_hwirq = fwspec->param[irq];
> +	*out_type = fwspec->param[type] & IRQ_TYPE_SENSE_MASK;
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(irq_domain_translate_twocell);
> 


