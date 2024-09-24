Return-Path: <linux-kernel+bounces-337391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B15984973
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437581C22F61
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249A1AB538;
	Tue, 24 Sep 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrcAeGX0"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AED531
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194828; cv=none; b=qHm7CSFKg4aPE/5tPVMg4cRgOLkvKXPGIsIXs9feU/hAuKR7y7pAeJPSA5fwoUptb4YsKek9ZVNda30+LZoN6SME8BxxM02dxriQAR6imj6mtdy/HjsujSaXakZME6dT/vVsAjSXTobjLuBa6SIZ6KexxkfF4SzNgihWkuGTh7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194828; c=relaxed/simple;
	bh=zUw28ah+6mVGctY/poCZa/6VYZm3f4108I3yv/dMw10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuRymcVKJf+LInl2+Dcxy9tl7yKXjBHADdWJi+mXJO9TpC1NGNjzj3qsaS39ySEmh2ByaawEA4sqNp8u6yjEg0Rio9yYC/EH8mTOWvoYmtR4T1URd/iIivzaxz0XqgSqakObuzsvkbaQEUezqCzmC6C7g2TfwtVbFZztKAH3yUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RrcAeGX0; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82cdb749598so335413039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727194825; x=1727799625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkE5EEVz39h0z7D6mTZGqT98JRMrECJ/HNlNwqISMrg=;
        b=RrcAeGX0gjsuq4gXW+vFMXVifvlA0GT7aJ2+xkrL9vXPlqZuddDPyFYkdIdmtBzUq+
         +rrcmwmNZ6cRUij6bMMGPb0spYA0Zm1RJ9VoQaL6zD6xprxjn7QNjrDLKsc2RUIulMFP
         zlf0fgaoop23jJmAysdW64seK4tzltbuoojHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727194825; x=1727799625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkE5EEVz39h0z7D6mTZGqT98JRMrECJ/HNlNwqISMrg=;
        b=qMwQYllZ0hd/jPWxddjC52UOxQXuszclDIrD5OQfRA+YeHXgFbXuznfxgBaLrClGAI
         sNdmqsu4czm3mKvc3Zh9x450CX88eTy1ffeiau631l+INzXXzqJDTBPpMMpiJHcaeXo/
         hiLwa4Xj4JjmEMDF35eqHrhBjrhCZ+SM45qGeUsDO5ye1zQ8Rkm4G0NZT0SxxC8ntfnv
         S5+idLXYtve9XUuKMJwPv/kBuFflTJg3IrYpDNDBNiVr0LQTgoLFOFOzYaca0xYqscCq
         0ydwTNoNcfeJ4qmKmJr0RZ411EvRMaCY5KFnREz+iMiO67g4Zzn7W37/VvrOqmHFHyw2
         YzWw==
X-Gm-Message-State: AOJu0Ywj7nB3XUV96QG2tu2FrhGxYr8WLSYrNkAvZs1TQE9DaaAQ3pgi
	9F2jqimpZlTqjLwgT3S/SaPEUFtItvd8daXRq3oZENroPIDQVDk+puJEWSLDSjI=
X-Google-Smtp-Source: AGHT+IFYkn1+9ENAiRN9ADnr88Pk7qHZFLKOsJb7eXEADSOPGQOc8ujHHxUnWVRGg7bQR/m3wAHksg==
X-Received: by 2002:a05:6602:1586:b0:82b:42f:41d5 with SMTP id ca18e2360f4ac-83247f88e3amr2796439f.16.1727194825191;
        Tue, 24 Sep 2024 09:20:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f416082sm490982173.174.2024.09.24.09.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 09:20:23 -0700 (PDT)
Message-ID: <eb73ec97-dcf7-41ac-ae88-20611fcff72b@linuxfoundation.org>
Date: Tue, 24 Sep 2024 10:20:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: ti: knav_qmss_queue: remove useless statement
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, nm@ti.com,
 ssantosh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 anupnewsmail@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240924132025.22046-1-alessandro.zanni87@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240924132025.22046-1-alessandro.zanni87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 07:20, Alessandro Zanni wrote:
> Remove the statement "continue" at the end of the loop where it
> becomes useless.

How did you find the problem? Change log should say how you found
it.

> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>   drivers/soc/ti/knav_qmss_queue.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index 6c98738e548a..1cc54905b398 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -723,7 +723,6 @@ static void kdesc_empty_pool(struct knav_pool *pool)
>   		if (!desc) {
>   			dev_dbg(pool->kdev->dev,
>   				"couldn't unmap desc, continuing\n");
> -			continue;
>   		}
>   	}
>   	WARN_ON(i != pool->num_desc);

thanks,
-- Shuah

