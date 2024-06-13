Return-Path: <linux-kernel+bounces-214114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF6907F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7971F22561
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C72214EC49;
	Thu, 13 Jun 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi7BiyAQ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B113BACC;
	Thu, 13 Jun 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322034; cv=none; b=oVXQboIeB9XxkWfKyxodWEwzp3HRkdFLunfkL4kVISu5fYBPKQLOLIzw7ArGFX7GRYA1ZFOmmiT3rau0KMAYfjx4Gc3uDS0VIfYbCIeSYmplxD9bZxs4M+AcXgauycUY7x9pR+YxImAoFpc1zWL5gqXNjgBbsau7FSlnTK/U6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322034; c=relaxed/simple;
	bh=0yietYB5x18GG9d3WRA7sQHtHeeeuW7CljXtXPluLCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7ahdrRxYha0y5cgURCvPV/baI2R6YBVa9WCaacs8KDePJ7RM/TdegzB3kM+nxXvo+YKyctYeIesRtR07LIOueQBiFamhUiJUqCuCuE5vHHL7OT5wGP/vlqEFanIRZKw3JKQ3VIOk47CWo856L9zGcJYcfHNGQMggcJhRHLp1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi7BiyAQ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c9b94951cfso878198b6e.3;
        Thu, 13 Jun 2024 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718322032; x=1718926832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sHYb+U0VhGSLTfYLvy+nz2BRypbacPOnHgXHwwt3Lxg=;
        b=Qi7BiyAQosEUwYJIDeFvTQBXtDu9qH0FCT6un3vqdbjpZfASGWEPS9GcDIrfALiyxG
         phE8iPoAN3BVJZjSHJWB3qt9GZ0SYNXcbi0yMR92xdmdCFy8axhVhmqhNGR/98boOVAd
         qSCys+mQK3i2wwqoEZ6UKdw2U4abe99IbQeoKmYjv36nmDN66bhYJCKGDu88P+D5kAye
         5nrSjhjyWjax9KY2DP5dLF7+CqzLVoOjuKVoHShNIBd1bjgI3XVoz4EhNoqYLIdvDd6W
         ZCFfpLCpSj4x8AjYu7e2ZN+kygNVAf1KYjNgh7sIY4Oup7/QevdLVfnpJjYcOoFrt3OY
         yc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718322032; x=1718926832;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHYb+U0VhGSLTfYLvy+nz2BRypbacPOnHgXHwwt3Lxg=;
        b=X1TV7jzs/Z9CL1hasGQ2czD3PfIo4+lsQqwLnHhZ1G8Wf/aKaIuHIs8W6W61NU01l2
         bs6gjQWYzMJIkulkvY78T3zHsYBg5AaG7AW5UVRbXZbplr3xZTFZjWIwUU1ZZ84pEkPo
         Fp45bL1iOTCiio83J3bihQcKc8NHuDg3G69Y+/mBsVhMV87+JDy9aPegh/6LS3egsF7i
         2Yx8xUvMrol1NH2xMIPa2ir2mbG09mq8JSSm3A7Tpnqj9XLBET+7s4k/zu1n4YjBQDZU
         Vs9YNxOAozwEwDq3JSoSryw4IGKbSG+jIWY1LAZRLQbDna5WbXXxEAi8YS+AbOnToSxY
         AGpw==
X-Forwarded-Encrypted: i=1; AJvYcCWSbVF1d/8JTi5WO+/Oi2JmnlM1ay1K3UtZm6ehkoVsaZajdK/zxw3r8BwSs9mvZ1SO+TqygASPxaCkw+qMLnrIWN/jPOjz21YfILXr
X-Gm-Message-State: AOJu0YxVuJnwdTSzrhcvb5h3G8l446FMOhz9XjI8qTuu3G/Jry6oo0iG
	TerbWpK5mqMRyhptZW4vW/8UwgZjxiglVKsFdUAosqlhH0BcULQUqEpn9Q==
X-Google-Smtp-Source: AGHT+IFoKafyaPmZKzT3hx+h4TKvJKGcsSZ6Jc+d9lu9gL+6dK3iirDOgPdb5TJpEl9NSr7cwKXJLw==
X-Received: by 2002:a05:6808:2004:b0:3c9:6e55:e24c with SMTP id 5614622812f47-3d24e8a725bmr1138594b6e.11.1718322031825;
        Thu, 13 Jun 2024 16:40:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6af74sm1962025b3a.148.2024.06.13.16.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 16:40:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <581675a0-7c47-4896-9950-8c5a3236a350@roeck-us.net>
Date: Thu, 13 Jun 2024 16:40:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (pmbus/mp9941) Add missing bitfield header
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Noah Wang <noahwang.wang@outlook.com>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240613-mp9941_bitfield_h-v1-1-681afa8aa498@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240613-mp9941_bitfield_h-v1-1-681afa8aa498@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 14:57, Javier Carrasco wrote:
> The recently added driver for the MP99441 is missing the bitfield
> header. Without it, gcc fails to find FIELD_PREP and FIELD_GET.
> 
> Add the missing <linux/bitfield.h>
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: c16fa6967781 ("hwmon: add MP9941 driver")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> This patch fixes the errors reported by the kernel test robot about
> the MP9941 in the hwmon subsystem. It does not close the error report
> from the BUILD REGRESSION 6906a84c482f098d31486df8dc98cead21cce2d0,
> that includes, among others, this issue. The report attached to the
> mentioned build regression actually covers a different bug.
> Hence why no Closes: tag was added.

Already fixed in hwmon-next, but thanks.

Guenter


> ---
>   drivers/hwmon/pmbus/mp9941.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/pmbus/mp9941.c b/drivers/hwmon/pmbus/mp9941.c
> index b7b0eda5b552..475221b738f5 100644
> --- a/drivers/hwmon/pmbus/mp9941.c
> +++ b/drivers/hwmon/pmbus/mp9941.c
> @@ -3,6 +3,7 @@
>    * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP9941)
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/i2c.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
> 
> ---
> base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
> change-id: 20240613-mp9941_bitfield_h-59cca83ae233
> 
> Best regards,


