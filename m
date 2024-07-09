Return-Path: <linux-kernel+bounces-246195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562AF92BEE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1234E281539
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E419D8A2;
	Tue,  9 Jul 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MM4sPECc"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70019D072
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540562; cv=none; b=G92VdQgO+3mhD+BtvkkNRVwtEvdC/IOXtgSMrEErvBoL6D/uUOVQC4gJ6RfXw3t2Pvke3ocjqsvPQZEvyobalAl9ZAq3z8+mUiarTJ4ToHVlbCw0Khl6Q/9nCECUP0eVnGhHdYkEKZNEq0nfdvQ5otMRq7MWhUl7OVS0QV7lA+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540562; c=relaxed/simple;
	bh=XEnjqKzZBzYWAQR9CwjdJSaL+DHE3+UQikxNM+smtTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXKzHMXmcrs5xSMYaEkmTEBV1EiyiuvtvweOXfcso4oxa1PXczSoqp1HUQKGkRtCPMiDl/x/ZEXZaRhOIw+yHEqnc5l/T9uAwjwEv265z83JtHeW+nY3/6669nY6uSmGUob6XhGPdgVxu+9darIzvtcNTamqKgz6niP08DbgwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MM4sPECc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e94eaf5efso6376668e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720540558; x=1721145358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kb8hNs2hghjQ2m4soHqnNroceNfOKpKVZ1P76gG8ZLw=;
        b=MM4sPECc3Q/+kbq8qNTfJVV2w4OGZ5DgKEB48s9rK/QLvtZwiyqUhWfZa+oKRdjWJ8
         GJqNI67GZxu/aamk/CfDIbAm+lcl5Sv3FZybtdqmH9iUC18kQhnJAtXvhUJrAy103Z7L
         pN5LxqtMx/LXj/haAEAe2tH5j9PoOD43SQ/2JCymqX9bMDZkVBEnm/dCMdwmS3AMDacM
         Qsi2MKZlvrhvpj08A+9OUllvjf9VRjlJK4hxipDI1qhv6K2OjYvhllIIE0WNQxesjZg5
         IENLkZ9pRDz2PyVkumS+nLUF3xtyNkSqyWHzfaKJDQ8ir2QUjVzpbMYrxFFkr7ttYEZL
         xERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720540558; x=1721145358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb8hNs2hghjQ2m4soHqnNroceNfOKpKVZ1P76gG8ZLw=;
        b=Kp9RG6OUp+YY9Qxvz02duP34Hm1eXY3kKi3BXcnHkk3TxGBhOhEBTpUW1RxA9qNIW8
         mSLzVtkYU7yszqLizKpnDV+NiN1G6d6Ws3cJwS+MQu8AsXcjwMu9bZCYEV4eF6Xrai6S
         bEjtEukOq/fsJDbhAnp3wRpT6GAbGdxqdxXJSpUd6sIKWP67r2MJ3riF6pzsuUh31mGf
         PwZkz5Joey0UVnpJRE9w46mV66FBG/v9UAr1u7Eekyt76E3tE/anhFvd7XKrK7rJvYO+
         vQpDKH2fVm0+H4poK9q+9VUDPxOkmvUW98JeFN8QDNB8Mu+FEXIsiXsSvUnWzLmqeY0L
         /k8A==
X-Gm-Message-State: AOJu0YzRXSTQGITgt39T1L3GeWxWW0H+HTuxXT3d5gce48IGXFlH7zvP
	Iy7C9JfqdVsLo5udOrNJjVPqHaom3qmTbuHUl2rKaPRhI5y+R3z3wsmylo5w/BBunrTGNNbrCMv
	K
X-Google-Smtp-Source: AGHT+IG4bemecMAsKEDijoZ6HieHROjC0kyQfAlSqxupPftR6S/IFNAB3A7X4FibcRnKEA197tCEBQ==
X-Received: by 2002:a05:6512:1051:b0:52b:c0b1:ab9e with SMTP id 2adb3069b0e04-52eb999124fmr1787618e87.5.1720540558327;
        Tue, 09 Jul 2024 08:55:58 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cf24:cce:17df:12ab? ([2a05:6e02:1041:c10:cf24:cce:17df:12ab])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5a32sm46822925e9.24.2024.07.09.08.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 08:55:57 -0700 (PDT)
Message-ID: <6806bceb-33c9-4417-aa99-f34dd325d24f@linaro.org>
Date: Tue, 9 Jul 2024 17:55:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] clocksource: realtek: Add timer driver for
 rtl-otto platforms
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, tglx@linutronix.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 tsbogend@alpha.franken.de, paulburton@kernel.org, peterz@infradead.org,
 mail@birger-koblitz.de, bert@biot.com, john@phrozen.org, sander@svanheule.net
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, kabel@kernel.org, ericwouds@gmail.com,
 Markus Stockhausen <markus.stockhausen@gmx.de>
References: <20240705021520.2737568-1-chris.packham@alliedtelesis.co.nz>
 <20240705021520.2737568-8-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240705021520.2737568-8-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/07/2024 04:15, Chris Packham wrote:
> The timer/counter block on the Realtek SoCs provides up to 5 timers. It
> also includes a watchdog timer which is handled by the
> realtek_otto_wdt.c driver.
> 
> One timer will be used per CPU as a local clock event generator. An
> additional timer will be used as an overal stable clocksource.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>      This is derrived from openwrt[1],[2]. I've retained the original signoff
>      and added my own.
>      
>      [1] https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob_plain;f=target/linux/realtek/files-5.15/drivers/clocksource/timer-rtl-otto.c;hb=HEAD
>      [2] https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob_plain;f=target/linux/realtek/patches-5.15/302-clocksource-add-otto-driver.patch;hb=HEAD
>      
>      Changes in v4:
>      - Reword comment about watchdog timer
>      - Add includes for cpumask.h, io.h, jiffies.h and printk.h
>      - Remove unnecessary casts
>      Changes in v3:
>      - Remove unnecessary select COMMON_CLK
>      - Use %p when printing pointer
>      Changes in v2
>      - None
> 
>   drivers/clocksource/Kconfig          |  10 +
>   drivers/clocksource/Makefile         |   1 +
>   drivers/clocksource/timer-rtl-otto.c | 291 +++++++++++++++++++++++++++
>   include/linux/cpuhotplug.h           |   1 +
>   4 files changed, 303 insertions(+)
>   create mode 100644 drivers/clocksource/timer-rtl-otto.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 34faa0320ece..70ba57210862 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -134,6 +134,16 @@ config RDA_TIMER
>   	help
>   	  Enables the support for the RDA Micro timer driver.
>   
> +config REALTEK_OTTO_TIMER
> +	bool "Clocksource/timer for the Realtek Otto platform"
> +	select TIMER_OF
> +	help
> +	  This driver adds support for the timers found in the Realtek RTL83xx
> +	  and RTL93xx SoCs series. This includes chips such as RTL8380, RTL8381
> +	  and RTL832, as well as chips from the RTL839x series, such as RTL8390
> +	  RT8391, RTL8392, RTL8393 and RTL8396 and chips of the RTL930x series
> +	  such as RTL9301, RTL9302 or RTL9303.

Please make this option silent and selected by the platform. You can 
refer to the different options in the Kconfig.

eg.

config REALTEK_OTTO_TIMER
	bool "Clocksource/timer for the Realtek Otto platform" if COMPILE_TEST

...

The rest of the code looks fine to me. Thanks for commenting your code.

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


