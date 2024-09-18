Return-Path: <linux-kernel+bounces-332356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4860F97B8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEA6282A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C7916EB56;
	Wed, 18 Sep 2024 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d9v4Ge4c"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FFC15665D
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645929; cv=none; b=GNNuuVHbQE+XaGEQa7TiMW0kK7SjUMSQtO8l7yFNKjKNRuwImG7qSPPKLyTSieWMXUVEw2Z/3iEv/tv+mr3VpfjiQ8j6UOZcA0Xr12KsQNhDVzIbJbV7GKBtpMlPNhzkbf7l4Jf0NsEk4kVFutC9xp9VToUcl7ztZx61HtrQ8QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645929; c=relaxed/simple;
	bh=dwmLpLb28Qi0g6sGSTbcLlefi4lKGZH4fza9Bu+ksIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zikxiyo14yHhM70W8hOpm7SelBnvyTG+tw5WF6CvJrvqV7n6Vzv/omOVNalsRDImafV4cq27BUY3xltAmm6vTUn6DYdl6WOLTQW1I1Ff5aoNhnbLpoBNOoQvSw1a9oXLWaraOfIjSAPpiuJ6bT2YuTlBAC7FUwlzJIrQtZ3c81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d9v4Ge4c; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c4226a56a8so6160034a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726645924; x=1727250724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8vvDaINe/k4C7nZHDNu7iAyHGRFpVfe+nZPdNORStd4=;
        b=d9v4Ge4cGICRveogOuTQFJf87PJM/iNj3f+VTkNzmRIOqJ1KS6ft+fRRzEhSD+4FIR
         q55BxEUPJljeCmH8z9OqGmOjxE2wNAtxBjlz6QfcUg6Yyvqu+7ypcu9NdkPoqjGquAAW
         70tLDIbpKgvv6IWJe4wIDkijcuf/p4+ypgpvVGrQzQr9dpWStzZylfbXLN6V5PPYsyaK
         a720iw4JChDZdSDWimm0ym29ama6/2G/X5g6JnwoI9n+9XCpOF4x5KR1HyFa95pHijGJ
         WJ02sOJ9iaxfO1PUSFA2yiS66narvEXByjhpP5hNTW+Es5QF6zmQ0o/1eqETt/e5DP6w
         x3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726645924; x=1727250724;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vvDaINe/k4C7nZHDNu7iAyHGRFpVfe+nZPdNORStd4=;
        b=GfQrrqrfFQl3i1D3so4EDMLy2Yzs38RE+SAUr4fejI+o7prriD9nTJcZfjDrMMMzD9
         es8wpEadQAPK4QRSoGJXtwmT9dUucdmyYYrjHbpGrLZXNvPqLEw6lW91Vfoht7TcNICY
         AIrPvNUVbHiinVrleBkziJsQkke2iv9VTQFli48/jPm6spldQLyVAbEqo7oQIUQ9NEgw
         VLbajiXtNl2xCnM8V0pNy0XXOR8D0NbEzBQDmh3Ya0S9+6jYyEmjc/vCmqEEIrvT5wrA
         J/ELf3VdqHeLvizHG4Xl4TKENfqIuq3oNr47FuSVcc9FvQVNqUBJ/IWSF1jNS3kNxWj4
         c+/A==
X-Forwarded-Encrypted: i=1; AJvYcCWV0Z9B1xhbbe96aMaRsoM5JlZf/jYWOYIZoJN/piHKjBKy2JplMrys5rrB+VfL4ZVrK0b4ZtiB6LGvV1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2BXz4DKW/JVQniRqGbvvqO5yzNkjGbLGwrZ8L6Rp1gYrelrYw
	invLEbd1COfvKm/Eg9StTV+OBTbHimdOXIP+zvNBdRRmtmRohDdL7kkQ87qnLIM=
X-Google-Smtp-Source: AGHT+IHcW32lA5QE0buPnJOwR+AEIzaY3HcYU9r7Ejo6IGud9r1krqnHTeLIcQK+fP5LNvpy3alGew==
X-Received: by 2002:a17:907:72cb:b0:a8d:60e2:396b with SMTP id a640c23a62f3a-a9029678bf3mr2297919666b.65.1726645923469;
        Wed, 18 Sep 2024 00:52:03 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9060f39a8fsm549461666b.0.2024.09.18.00.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 00:52:03 -0700 (PDT)
Message-ID: <a3cf9786-7fda-4f31-8e96-8789a7d24699@suse.com>
Date: Wed, 18 Sep 2024 09:52:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drivers: provide
 devm_platform_get_and_ioremap_resource_byname()
To: Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chester Lin <chester62515@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>
References: <20240913082937.444367-1-andrei.stefanescu@oss.nxp.com>
 <20240913082937.444367-2-andrei.stefanescu@oss.nxp.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20240913082937.444367-2-andrei.stefanescu@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/09/2024 10:29, Andrei Stefanescu wrote:
> Similar to commit 890cc39a879906b63912482dfc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()")
> add a wrapper for "platform_get_resource_byname" and
> "devm_ioremap_resource". This new wrapper also returns the resource, if
> any, via a pointer.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@oss.nxp.com> > ---
>   drivers/base/platform.c         | 28 ++++++++++++++++++++++++++++
>   include/linux/platform_device.h | 13 +++++++++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 4c3ee6521ba5..ab48c02fcb2c 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -108,6 +108,34 @@ devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
>   }
>   EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);
>   
> +/**
> + * devm_platform_get_and_ioremap_resource_byname - call devm_ioremap_resource()
> + *					    for a platform device and get
> + *					    a resource by its name instead
> + *					    of the index

I think we don't need to describe what the function does not do.

With that:
Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> + *
> + * @pdev: platform device to use both for memory resource lookup as well as
> + *        resource management
> + * @name: resource name
> + * @res: optional output parameter to store a pointer to the obtained resource.
> + *
> + * Return: a pointer to the remapped memory or an ERR_PTR() encoded error code
> + * on failure.
> + */
> +void __iomem *
> +devm_platform_get_and_ioremap_resource_byname(struct platform_device *pdev,
> +					      const char *name,
> +					      struct resource **res)
> +{
> +	struct resource *r;
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> +	if (res)
> +		*res = r;
> +	return devm_ioremap_resource(&pdev->dev, r);
> +}
> +EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource_byname);
> +
>   /**
>    * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
>    *				    device
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index d422db6eec63..ab7f33f3c426 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -68,6 +68,12 @@ platform_find_device_by_driver(struct device *start,
>   extern void __iomem *
>   devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
>   				unsigned int index, struct resource **res);
> +
> +extern void __iomem *
> +devm_platform_get_and_ioremap_resource_byname(struct platform_device *pdev,
> +					      const char *name,
> +					      struct resource **res);
> +
>   extern void __iomem *
>   devm_platform_ioremap_resource(struct platform_device *pdev,
>   			       unsigned int index);
> @@ -83,6 +89,13 @@ devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
>   	return ERR_PTR(-EINVAL);
>   }
>   
> +static inline void __iomem *
> +devm_platform_get_and_ioremap_resource_byname(struct platform_device *pdev,
> +					      const char *name,
> +					      struct resource **res)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
>   
>   static inline void __iomem *
>   devm_platform_ioremap_resource(struct platform_device *pdev,

