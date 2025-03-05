Return-Path: <linux-kernel+bounces-547361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55116A50644
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964AA3A8BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BF51A4F09;
	Wed,  5 Mar 2025 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmJ4ZI91"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B6567D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195391; cv=none; b=Te15B9+IxLtnM+0+kBnEzFgRFowch3u2ZIOB4JDRTnkmvCsSsar9e3b2I2JpJnxVEvgFH2Nrh1F86ewZO1mv3VrMiek7cVJ/nipUrNAhnYjn5Dk2NSG34VePyQEotv0XuxmU8bzE9Gavd63gupfYkhjhAn4LlzXaNvR2rGvj0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195391; c=relaxed/simple;
	bh=HJfR+xHb9jE57f61TzWWYQYP4wsfQGvXPp263t9iA/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqR3lr33cjGuOYvNi4Aypdu+BGJfvoS9jRrzEEtzim41StbDCTz6yDfG8LNfwVBlP4nlWe250s6AQ8sWhKSXc3S0ltxm6TLH9P/xCi7+9X4h1JvDI8fj9tM2oer4KQ1W/5MWPIsW3Cv0Hw4t6Xyc/qZReQLk5sAl9uh7AArReGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmJ4ZI91; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a823036so65131485e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741195387; x=1741800187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alT+zALmOJxTVW5BnA8w1UfBmWenGfChKrkcnTMAdpQ=;
        b=GmJ4ZI91qBstfwzfRPJpGnZpaJj/ypJt0Yc9KuQRyNz+l8Qs65id4aNQloTWekdoJ/
         nNPCkwIliPlzCs02/VIGCcsoILkkpOj9e+S6icLFITIQftIfaqajn7if08IR0eL4X9vj
         aUzXNmhkaWsJ1OseJ4G7TvefANOh17nj27vjsNCl4fkPOqfawApa8SUK0J2fz+u0FmOG
         c3J/IvzcndUltDmEziWvsmmBcWLSe6XPWPh+7eYlob/12cOy5rWs/K1ePFRT6HH8w+Uy
         +7OevSg1YfvYi3ESn88WL4u894lrJlNW68vW4P/BXaf5HPAwUcJ/rMxKTv2O1rss5DWh
         oaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195387; x=1741800187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alT+zALmOJxTVW5BnA8w1UfBmWenGfChKrkcnTMAdpQ=;
        b=tyfGKwvFoOlX6RaJsisMFuM4JWoChHP29DeEY9adKHDjaFC6XJ4ReyxZ8Mx1bUFd47
         8YibwPiESSK5aJTg3doZPID4Dzg4qkdxXKj4GYxJVC8IEx8k3EjceKIX5L93YKfL7Tp8
         Q8GN9mBcFqBu4Av6AORNACymq7FoV0Yi5OLdZdDOjIsNZBS2IIuQyCTsD8WJO/LFd3kf
         keRRcSEIF4iJRgRBi1qOm5WPr3NjwfPH5Tqh+OgBTsHZlNusHlO5v/T4Fygb5dO8Y4x6
         ShxA5u4RoeFS5Zp/rdH9Bf1kNNhszBEBCitfk3IBlFoZpiw1BpXndjluy0CbGzrHE6Wn
         Pnwg==
X-Forwarded-Encrypted: i=1; AJvYcCWYa/gWfsXpd39iI+MwbV9RaIRG7hua7KjzrzzlMdAyOyYOYmQA9pLXM/p8ppgO23eaVQLQwdLpUTOUSOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd7NQV4NhuigY1GiWsC4UR3fBeAjBt/m/N1t5KnPUuLBS0A/oQ
	3/E/WjhYSm7j1DFeMn9InysVJ82s9qztWEgp/7Sy8BE6nN5whJ1WaJGy03DrR0Q=
X-Gm-Gg: ASbGnct6mlWD/SpNjmfuTqerUOEPT7HBCObbpyodfnQB62iU76gEry/jf0hqlbMF1dn
	LFTVw8oCHVlQJw8VIhyogIJBKgXIJbZ2jvNIh6Md7SXa747Q1LuuOuljHyLd9slq6nc6nzAGLz8
	VewimLVD3oug7/cklzQSIpcnQlXQNlja2AIWj8zcypK3B91M5Y8AsTarFfqm6wSgpD4IpM5EXCm
	D9VRvIJwK7mEJfYGmsQM2AVGphdhOGWyDkg8qqwkBhH8nMe8XPkZm/d5NNH/7RO6QpAn+yVHup2
	aUT5upQZl986J+HsnPzwEmaXtwcUTo1K/0v6eSXgI6SXmmEimeRgJqsv8HLts306ZkbtG4r7gFk
	wrIUv4kD3
X-Google-Smtp-Source: AGHT+IGpqFVx176QiSlOJSi7wc2dopFl/WDHZbSXP9T991xV1xy9GzI6/Dnmfiz+XboGhP5rub1OWw==
X-Received: by 2002:a05:600c:1d0e:b0:439:969e:d80f with SMTP id 5b1f17b1804b1-43bd2aefa41mr32049945e9.31.1741195387395;
        Wed, 05 Mar 2025 09:23:07 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43bd42c8050sm23402385e9.21.2025.03.05.09.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 09:23:06 -0800 (PST)
Message-ID: <a7489f16-ca31-4530-8ef1-33079b3c99a9@linaro.org>
Date: Wed, 5 Mar 2025 18:23:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: stm32-lptimer: use wakeup capable instead of
 init wakeup
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, tglx@linutronix.de
Cc: alexandre.torgue@foss.st.com, olivier.moysan@foss.st.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250305125146.1858978-1-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250305125146.1858978-1-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/03/2025 13:51, Fabrice Gasnier wrote:
> From: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> "wakeup-source" property describes a device which has wakeup capability
> but should not force this device as a wakeup source.

Is that a fix to be carried on ?

> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>   drivers/clocksource/timer-stm32-lp.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
> index 96d975adf7a4..f08baa6720f8 100644
> --- a/drivers/clocksource/timer-stm32-lp.c
> +++ b/drivers/clocksource/timer-stm32-lp.c
> @@ -186,9 +186,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
>   	}
>   
>   	if (of_property_read_bool(pdev->dev.parent->of_node, "wakeup-source")) {
> -		ret = device_init_wakeup(&pdev->dev, true);
> -		if (ret)
> -			goto out_clk_disable;
> +		device_set_wakeup_capable(&pdev->dev, true);
>   
>   		ret = dev_pm_set_wake_irq(&pdev->dev, irq);
>   		if (ret)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

