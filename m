Return-Path: <linux-kernel+bounces-385378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E69B3674
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDD61F230A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F21DED44;
	Mon, 28 Oct 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xX43Jrlv"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539E18893C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132958; cv=none; b=tGv2voQWkccMN5H9iU7O5RHeUlil8SUxKarKapr9D4eKZBQBsazAthFtgqyial9sxc1/fKigcrYzwaxsAybCYtYYmyLh7pPtQVJRv4ii2+LJ8n2+lFGSejgEU3c0Bp9HnW5D4Vih2ZroLaIBwM7rV0TYTJRCTBHy9SoEVJBx9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132958; c=relaxed/simple;
	bh=LsogkV8MMSpTMZyAQFV4xHQCtiVPllCRY3i1aLv2/7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tl2VjRvPtp+T2Ise/ztGi8K/TqyGNk1hafpMrok7NR6c1Wb62bSH7urEbxlRVKPZN6VXsaaYpBkbUpYuXA8L4bRASvfCSir9f9B3FqB2zEyHHatbyBkz3YBj25kpDCyAgHuFgs7TScUwxFMp4DWCgEeqh/x0lJBJJu4T1CaIrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xX43Jrlv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43155afca99so37961115e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730132954; x=1730737754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0q9eon96W1pu5tP9tseDZSmlbqAAqF4fnEIhuW/qWU=;
        b=xX43JrlvJL2PMPXDUbItvp4c2vX9cxYt3rNz8B0OCO1/8PlLuvn6p722UkT66lSjAC
         i4/VyKdoFQ48+50o7vUQ5Bfn2XpNMaizKFGC5BfczNZ2e0kPfNIF42oA269SOX51ZhJv
         gWAXZwkOVigjE6OyHaQtTf/ptzcisDAED51Ev4em3EPDbo8ZhgxpjnDhlfCyVyDSaPKg
         0/uyq/Gh22zZu5ALrdRzSvMPiWRlJ1X6ElyfFFYTwQE+1pRHXt+yHvbb0nZ6fXdJlgcS
         s5kX2JDqSnHbnFwHZVpw4DCbn6FlNFcmVX13bA3oEKV3j+ivb19PaK58Qms8CXOt6SdD
         dyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730132954; x=1730737754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0q9eon96W1pu5tP9tseDZSmlbqAAqF4fnEIhuW/qWU=;
        b=IcDaN4wFu7VbYFrkljE5iHayXRL+3kl0dtT7Ww9hHVdPGcVHyzoeNo6JpV6OWRYDC7
         64fElyoHD50D0/RXWtfBt/LPB3+6L8/JCQ2CurWG4B7/RfgyYEZ5RddxAZcBsssrwnWT
         tjaJy9loeVpRsJTdclMoP0Tz944R1MGQG7AfH4tX2kXhS31LOD5pRFeUi6pJeolhqWH1
         3stOZI1MQu86fLfB6GMTavygSPo3wRgwXDyUWeFz0nUbBbzoiPFxPkMETXHEyAAmQJv9
         +XJcvV7qrvsiZ2Q5/DPurTtb8E0f8H3J4K3JIHWZvGSIoxyxSQwt0gZ8pEOisi+d0pNE
         6EWg==
X-Forwarded-Encrypted: i=1; AJvYcCWNzpaRaHRLvQPuumn7BRvnY5cObVs7yD1pvsggGnu2cDhcSWvA073Z4dQSc3Sgm43h+2ew6C328tcVd8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++MDDnXpjo68GolPbs4LQDQ9J7vsO69zM5I6ghr90NdK9zmsP
	MOIYZC9FfToKnGW9jVUcRWTqM+g5y1qS2TnwnXu5y5Fpa//PRSOJ5PhP258I93U=
X-Google-Smtp-Source: AGHT+IE7h3M7/javSsI7ttCapSp/Wm86kAuzbrICR9NDlU8V+xaXLBpyMJUHbClCSzDb1pHT31Qodw==
X-Received: by 2002:a5d:44cc:0:b0:37d:4660:c027 with SMTP id ffacd0b85a97d-3808142da47mr147220f8f.24.1730132954291;
        Mon, 28 Oct 2024 09:29:14 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4318b567e23sm144244535e9.25.2024.10.28.09.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 09:29:13 -0700 (PDT)
Message-ID: <b7ebc645-3b3b-41a0-80e4-1537f7d41205@linaro.org>
Date: Mon, 28 Oct 2024 17:29:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clocksource: Add Ralink System Tick Counter driver
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 linux-mips@vger.kernel.org
Cc: tglx@linutronix.de, tsbogend@alpha.franken.de, john@phrozen.org,
 linux-kernel@vger.kernel.org, yangshiji66@outlook.com
References: <20240920075306.704665-1-sergio.paracuellos@gmail.com>
 <20240920075306.704665-2-sergio.paracuellos@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240920075306.704665-2-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/09/2024 09:53, Sergio Paracuellos wrote:
> System Tick Counter is present on Ralink SoCs RT3352 and MT7620. This
> driver has been in 'arch/mips/ralink' directory since the beggining of
> Ralink architecture support. However, it can be moved into a more proper
> place in 'drivers/clocksource'. Hence add it here adding also support for
> compile test targets.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>   drivers/clocksource/Kconfig        |  10 ++
>   drivers/clocksource/Makefile       |   1 +
>   drivers/clocksource/timer-ralink.c | 150 +++++++++++++++++++++++++++++
>   3 files changed, 161 insertions(+)
>   create mode 100644 drivers/clocksource/timer-ralink.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 95dd4660b5b6..50339f4d3201 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -753,4 +753,14 @@ config EP93XX_TIMER
>   	  Enables support for the Cirrus Logic timer block
>   	  EP93XX.
>   
> +config CLKSRC_RALINK

It is a timer

	RALINK_TIMER

> +	bool "Ralink System Tick Counter"

Silent option please if possible.

Let the platform Kconfig selects the driver

> +	depends on SOC_RT305X || SOC_MT7620 || COMPILE_TEST
> +	default y if SOC_RT305X || SOC_MT7620

You should have something similar the RISCV option, no default option

> +	select CLKSRC_MMIO
> +	select TIMER_OF
> +	help
> +	  Enables support for system tick counter present on
> +	  Ralink SoCs RT3352 and MT7620.
> +
>   endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 22743785299e..c9214afcb712 100644
> --- a/drivers/clocksource/Makefile

You should use git mv

Otherwise the code is like submitting a new driver



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

