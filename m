Return-Path: <linux-kernel+bounces-282056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2683794DF3A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 01:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F285B20BF2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A98143746;
	Sat, 10 Aug 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIxVEUTJ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168F1370;
	Sat, 10 Aug 2024 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723332047; cv=none; b=pDcuv2S51PCDc8ZBGyVegUWWYyR+jcL8fYUyRNo1DY1UMPnNmTOjDiO0GYhFUldjsMum68Y7e/Hz6s/tHe40L9ODDWBnmQVYYsrpTTrjcvEVw6e7JtyKPE2KG2sCDkEdvOSpY9EUXOni9SO3Qfk4XoQ2cUcy1elNqcq4XSYTnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723332047; c=relaxed/simple;
	bh=DSyNIbwQ3UoaWbD8gs9LhCfHP4AEP8AdzS6su7wOb+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDB6TMrM9l7pAVS5B0E5ogfyzu1d0hLAdv2dn/cNy4xnkY7miokrJIAanHNub9rT5u9D0P0TNfqjhvVuN5xCPWWUPxoOHMKcW8cjQ3oDhralFN5V4RAY9kFRBah1MrjEqN3GjHmWZT8rTL9bm6PuErLFFL9a8ZFFeWUz43gKSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIxVEUTJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso3549921a12.2;
        Sat, 10 Aug 2024 16:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723332044; x=1723936844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYb0Vd1AjZzKI+beHilSPt6QZ/3F6KOCPd3kiG5Nh2w=;
        b=kIxVEUTJuK+nf9EZojnbGOYlqtjr18Togzmeo1YWhCg38WdCAH6EqxU9C9OIeCqOFl
         PkjpLOCjFgeWHaHMzO/NkcXxRoEUwVsex1DiAYgBZLbrIT41h2F+rgWIe1AMzJcP7nEK
         +w5OnRaCeJDoAAsHyTGen5kgmn81l/vU6saTVd5h5ePd9gQPl/AI5hYZCLcXqEcRe7Px
         xeAH6K8SEK+KrEb25VqVJXM6hpW5KmmJvofbDhXpSOOP8TsSd0z4VbFeJ0q2SSDsC7sK
         M19C+oZkW16diA1S4eLdN5jsEbRq5LDMIYOpgQyoTxPdLMMM5dMROfl+UYwUtpghEFSg
         BTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723332044; x=1723936844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYb0Vd1AjZzKI+beHilSPt6QZ/3F6KOCPd3kiG5Nh2w=;
        b=a/bJsvDoBuKVYKp1btbp7jcgKcC1kHaXtwbGeeabnPklPiqu1QZHSBcapFYJJp0nfr
         +Ne2ocXENDDt7iLmc7t8exQafB0vcxUaPqmmB2I+KgmWn7O0SuMOeSAOyLbiIX0YbI8X
         Qs1A+BHX90L97fVhqCkKOnwSDtRE1bEPtTGVhdvYE9/Ep5j9Fu74RMGhYqJRNSqzdyW+
         yNnbbligLDqTuFOd8YLY1e0vw4fkko2/Mv1k3VEgki/sQxJJ8rCv9PFni7JLMKZpyQkd
         9vORBLuiEVuZxkdk588A7uM28fyR8GnKrujv91SjRz4zHzTcbg4edg9FiEwffIuWdnA3
         mXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyDJWL+WHjvAV4wgZXCDjLLCmZOpzTEyCcsG/nCs+RF4Ch4poaPYdd2xFFkZ1w4xYylFu0YoD0DrSh6LIwtYJrywDtG6Y8UNreSx3IJSTLxFPCQj0Or8BL25WBdyG8VFTbxJzCMYSRt+I=
X-Gm-Message-State: AOJu0YxdKR3bsk51eGcn7J24JpFs6EA6StZujBfMb3i5t/AUKYUw5FtA
	l7kdHPbXxA4GZA8IsJoFKu6hXAksoEaMMFrCkYj/GS203+N/Ri73ukWxFA==
X-Google-Smtp-Source: AGHT+IFdh06SRJ60UzME5zhZr5jJ69toyYPmekG6/2eli2sDvVzJ1whysOa1epb12jH6INke9ojKwQ==
X-Received: by 2002:a17:907:f1cb:b0:a7a:9f0f:ab2c with SMTP id a640c23a62f3a-a80aa5dd43dmr436829066b.29.1723332043402;
        Sat, 10 Aug 2024 16:20:43 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1ccf15sm103285766b.134.2024.08.10.16.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 16:20:42 -0700 (PDT)
Message-ID: <0d8bc971-7780-42a2-8617-aeb3bb9bbfd1@gmail.com>
Date: Sun, 11 Aug 2024 01:20:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (surface_fan) Change dependency on
 SURFACE_AGGREGATOR_BUS to 'select'
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240810214709.425095-1-luzmaximilian@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20240810214709.425095-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/24 11:47 PM, Maximilian Luz wrote:
> The SURFACE_AGGREGATOR_BUS option specifies whether SAM bus support is
> build into the SAM controller driver or not. The surface_fan module
> requires this, due to which it has a dependency on the option.
> 
> However, from an end-user perspective, it makes more sense to
> automatically enable the option when choosing to include the fan driver,
> rather than requiring the user to know that they have to enable bus
> support first before they get shown the option for the fan driver.
> 
> Therefore change the 'depends on' to 'select'.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>   drivers/hwmon/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b60fe2e58ad6..e4d9a035a57a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2069,7 +2069,7 @@ config SENSORS_SFCTEMP
>   config SENSORS_SURFACE_FAN
>   	tristate "Surface Fan Driver"
>   	depends on SURFACE_AGGREGATOR
> -	depends on SURFACE_AGGREGATOR_BUS
> +	select SURFACE_AGGREGATOR_BUS
>   	help
>   	  Driver that provides monitoring of the fan on Surface Pro devices that
>   	  have a fan, like the Surface Pro 9.

I should have properly build-tested this, sorry. It seems that it
creates a recursion in Kconfig. So please disregard this, and let's
stick to "depends on" until I have figured this out.

Best regards,
Max

