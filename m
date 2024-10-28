Return-Path: <linux-kernel+bounces-384564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46BF9B2BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC231C219D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF77193404;
	Mon, 28 Oct 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfe+evnj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE41990DB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108695; cv=none; b=A8G2cYbQRu2ORqGMEpCfHb7QrGokgfMhxdhZGL7K3FBfWuKDzLf5LuWQZ7fwWy35beqquMJsH0ZKR3Otcisf0akU8gnP0L43KS1rg9on7BQVWme5EX0n3F7eQA56J+3nDr34fvBh9obo3kKmh+h1fJEkJOCFxd+J9Hxv/ErSPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108695; c=relaxed/simple;
	bh=i8WNTcaN5PWAzcehUDptB8suCbaVFwo9puUW+aLUTH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfCG7B4FfeJka+o1LednX/xQdFYLeVUauHr5rC04d/SBYChKo6BO/0t2oK4DD/WalBqxFSTkv0Zpaiz/9nq8DcdnDiNIg2z1Bh1agIrZwCZsx3Cuxz2li9Gr7I6t6hpb4Z6BLAKnIAhPD5MWS+FsS4PzcsxQfm/2Z4pRRqkXPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfe+evnj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431616c23b5so28698285e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730108691; x=1730713491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYW2nBqpOT7rpdJAt6yBdXzUTt5ThWvwR8AKSh6PMWk=;
        b=zfe+evnj40bBnwMyBnXsFxPwpa0OWtoI3CI5d1hT9AMT5cR+JFMGuMXD8Occ/WpI+V
         DJeQpp4O/7vKtdMi85M+H6tWsZImU8vkixKx9TB6rZylEeIa6PY8BG5FDxVZ6W8obDFl
         rXY5bdSxOh/uXJLKEJvgO0hBOFuiLqo31Mvi4upsicY/KyBRtkA9pXoySb/JDmHO4iZ1
         8T4fTU8LEXUnJKSi1LXN+ck6HG6MShwQb3Ok+QvLoIWQTiHWLdUEWGreVnt708NWIq44
         6T61/ZEOvZ1fNSs6QYwGxaZuyk1WEXL46LE+WkJPxzqLLP4AGKOjg1xclkuAXQVhJtvT
         zMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730108691; x=1730713491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYW2nBqpOT7rpdJAt6yBdXzUTt5ThWvwR8AKSh6PMWk=;
        b=V88cREezNCLsRfqZ2QKC/0EnFjnswgzMMaYV7fi51pDUABVvNbwejUjsRt5qehndBI
         YIMYaPx5WyvTQ/ytUZlYy9Zvr+Zzblto/mx6jjbGY4heUrSDE1jC3wdizMwm2azir5Vm
         8pxwNyyqXJF7NLcgLtyWY4TeuXjFIdKpnGaxinFXCzqp4wfQDef8D1jErKNGynP/rh3H
         GbH+R/99Edd7EFg2lmlrc/hOnBOwldfnzX9rIqlniV5jhJqH00UVytUomt7LQrz6qtqZ
         3SOe7t5lfhgXp3G69Ka+/toovDHKa39tspHRWRwLTtpDOfunKxRzsAFUJBK0u70JoDnp
         lKEA==
X-Forwarded-Encrypted: i=1; AJvYcCUFehB1Oe6s+8r7Eq9WPIE5WdHYKo0R46lhY4q6GK78BmXZy9aeDnF3LtjgOuMZrY3A+HHxKd6WIBpdJas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4MvW18CC2Yq3rKxWZEDZzQMHtot7xsH2LTnXI2VFvrBAyFna
	g9KBaSOuW4JbiqOVXyQ43t1xfPK+67rTxZe8dDYHZwLD88cdrnqhsmrjHINWR8Tv8f4ySWags92
	h
X-Google-Smtp-Source: AGHT+IEGI3A08qAUBhd5v0Oc5FZbvghNJQAwXWa8dsiUdujloWteFAWUVUDMhuvgj34CSetfJervcg==
X-Received: by 2002:a05:600c:4e8c:b0:431:7c25:8600 with SMTP id 5b1f17b1804b1-4318b587dd1mr99781975e9.2.1730108691401;
        Mon, 28 Oct 2024 02:44:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b70c44sm8958669f8f.80.2024.10.28.02.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 02:44:51 -0700 (PDT)
Message-ID: <5f7179ec-e4ce-4644-8a60-ce407a4d2f11@linaro.org>
Date: Mon, 28 Oct 2024 10:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clocksource/drivers/timer-riscv: Stop stimecmp
 when cpu hotplug
To: Nick Hu <nick.hu@sifive.com>, greentime.hu@sifive.com,
 zong.li@sifive.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@linutronix.de>, Andrew Jones
 <ajones@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Sunil V L <sunilvl@ventanamicro.com>, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Anup Patel <anup@brainfault.org>
References: <20241028033928.223218-1-nick.hu@sifive.com>
 <20241028033928.223218-3-nick.hu@sifive.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241028033928.223218-3-nick.hu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/10/2024 04:39, Nick Hu wrote:
> Stop the timer when the cpu is going to be offline otherwise the
> timer interrupt may be pending while performing power-down.
> 
> Suggested-by: Anup Patel <anup@brainfault.org>
> Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>   drivers/clocksource/timer-riscv.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 48ce50c5f5e6..166dee14e46b 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -127,6 +127,12 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>   static int riscv_timer_dying_cpu(unsigned int cpu)
>   {
>   	disable_percpu_irq(riscv_clock_event_irq);
> +	/*
> +	 * Stop the timer when the cpu is going to be offline otherwise
> +	 * the timer interrupt may be pending while performing power-down.
> +	 */
> +	riscv_clock_event_stop();
> +
>   	return 0;
>   }

Should it not be the opposite?

First stop the clock which clears the interrupt and then disable the irq?





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

