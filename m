Return-Path: <linux-kernel+bounces-338286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663E9855EA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3B1B22E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B88615ADA7;
	Wed, 25 Sep 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9zOBSJ+"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407315625A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254556; cv=none; b=DuJS/RrjzqU1GM2+SN18JADyNKYgXby6Tchq8aLDAmFLxZGMlliV9NQOaWuSTmpjy8a+CGNxuXWRYwy1WrQ9z1oh4BL9Rr3kV51BwUY7Rwtv2hF5E05Ovu+sykLiXEvVGsBfCeUdymOSobyY8SfKUiSz4O/fjROYek0X2pglvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254556; c=relaxed/simple;
	bh=L2cfWSfU/aZG6u9fJj9953HqRS57PZAHhcjjkdkiWQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceLgCoCAh3bzgIWNvhAmruSk6cGqSA1GvTcLDNHQboKvQIdn/dRPEeCSpS5SaJGOwgVuYrj72bauJw/ZLsdEYdNdkppT/SYquXBQMoRMnLW6JFshEBh5sh0bXSxExKQ+9CevUdEVXMU5ooMxS74K2KWizQaHZc4JqNeYZtFPOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9zOBSJ+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365a9574b6so9423472e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727254553; x=1727859353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6atARInumd0ajBLknRLnDCyO4TUPGXZa439/ghpB+I=;
        b=R9zOBSJ+h09IkzEF/eIlVdQCfHueRvlUtUgMPmOSrvCwlUlyvdXYqNXBs2+htlAn5U
         3rs7WnYS6RPOS1FBh87HNVH647uWBB7sw+t+w8XmK7JlQJ41ryzm8YssyRtkOI7ezhlr
         F9/y0d/opg4SqzfSqaCyn8U85Fzd0Zzlt/yZXwpdZ1JPwsXMnLQOlK1bwZUU4i1swInF
         WDliClWOfXNLICGuUw1CmY4jgCNHTAWIOnR4KZmnVZRl1oU8bEv9Py6ZWoI2pe7u/M6F
         EGNKwflIEtp0+Hr5x6ESRnpjvvElUSXoqKcxqVej5Bv53AODtiYtr9Qy9KMfNB82FwGJ
         6bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727254553; x=1727859353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6atARInumd0ajBLknRLnDCyO4TUPGXZa439/ghpB+I=;
        b=Sxg2WDXCNETVBIfN6IOY1l3hO28eqSc2UxC8J5RFdjvtj9lJ6FZmAuLuVdj3f+n6wb
         LgrMaEpzpAKE88julc6TLHfY2mbBP1m8WbOpQ3u3f+EO9xJMoH03ub2pq1zwUQVEMf0a
         OangqIMb+9MMiPSVDnRriRNWiJS5Z9e/TaLIxNiJ/4C5TwZH9RNa89BrWmd6QPHoRU9l
         P1dKvBeYv/xfzS43/rKrz3tuvgtLU2O0dHdI9aaVkWfk4KtaJwzFU3WRNud2V0gCIEY3
         CDvYaiE5LnoQa+eCIqX/ZXFJdFulfhngRMF0UsqwvSUWSt4zahRqgOfwUH3eFRPoXK/s
         cDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVARoVhNCUlhws8e3KuLc5t3UEVoR8xydQXzJYF5zHHTWg+X+8By2eADIPNICU5wtonkLqfK9xeAV/FXK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDDFToeW767znhO5ZJ/WJGDYre5AaaEPaSTK4dtoofYeqoj8+Q
	aFWDj6MrblvyIaRGsXApBeqRZUplZfZto0CP4QSPAG4KGtaoLsGF
X-Google-Smtp-Source: AGHT+IEKHFR7ovj653CTdedrwwCFjx2odHYWLVB1M5ZrNoFZriaFW6bQlf6OE/pnjY9L43Er9ogTTw==
X-Received: by 2002:a05:6512:e89:b0:536:7d7d:c621 with SMTP id 2adb3069b0e04-5387048a6e2mr1613065e87.8.1727254552705;
        Wed, 25 Sep 2024 01:55:52 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a86402ddsm460151e87.150.2024.09.25.01.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 01:55:52 -0700 (PDT)
Message-ID: <0b7b6ca3-b05b-40f2-86cf-083beb72727c@gmail.com>
Date: Wed, 25 Sep 2024 11:55:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] regmap-irq: Consistently use memset32() in
 regmap_irq_thread()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240925082726.620622-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240925082726.620622-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 11:27, Andy Shevchenko wrote:
> The commit 4d60cac951fd ("regmap-irq: Add no_status support") adds
> an additional branch into IRQ thread handler in regmap. It wisely
> chose to use memset32() as it might be optimised on some architectures
> and hence give a performance benefit. At the same time the old code
> continue using simple memset(). Update the old code to use memset32().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/base/regmap/regmap-irq.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index a750e48a26b8..33ec28e3a802 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -364,14 +364,11 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
>   		memset32(data->status_buf, GENMASK(31, 0), chip->num_regs);
>   	} else if (chip->num_main_regs) {
>   		unsigned int max_main_bits;
> -		unsigned long size;
> -
> -		size = chip->num_regs * sizeof(unsigned int);
>   
>   		max_main_bits = (chip->num_main_status_bits) ?
>   				 chip->num_main_status_bits : chip->num_regs;
>   		/* Clear the status buf as we don't read all status regs */
> -		memset(data->status_buf, 0, size);
> +		memset32(data->status_buf, 0, chip->num_regs);
>   
>   		/* We could support bulk read for main status registers
>   		 * but I don't expect to see devices with really many main

Thanks Andy.

Can we guarantee the sizeof(unsigned int) == sizeof(uint32_t) on all 
supported architectures? (The status_buf is unsigned int, right?). If 
yes, then this looks nice to me.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


