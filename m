Return-Path: <linux-kernel+bounces-311174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B3096859E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85CB1C221BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBD183CD8;
	Mon,  2 Sep 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4b+9iUm"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D91D27A9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274783; cv=none; b=eNyixIxtQIo6Y+xIZnO3hK/qXMENhdxOmSwNnc2dZfq8gAjKNciSK8Cs5QB/JJRcIQUcHxW+G+K9DUcCC4YR0H/Jt81c7Yo9XE30KXh/2sjHw9sBZLYQHIJ0Zx0qHcieIVMHhJvPaPbL2PyDifbKbq9WKOy5aOvczzOwJsCUZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274783; c=relaxed/simple;
	bh=wSd/Eo7R1BJ4F9MO1ydF0Sp7AugopbqhgwNsWlqBoGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlfxfkWZg+VAs9EvnfulhBIx5q849ww51gaNWRxsWS6sgbQFsr+TQ1cIHUWnhE0UfqsZ2FTC5GWuqAETT957cCrB4i0bKvt8s03mGhFE+Rr4uf8ofau/FplODK9e7qF+k+YJgoNlqdP7BCoKMGy3c75p/gUBCjLKPGInYeOuWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d4b+9iUm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bbd3bed1bso3838175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725274780; x=1725879580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IE7X1McDmWnrZdJLkqa3vbwEqyyfI/WuVigow1tXc8U=;
        b=d4b+9iUmzN2tvql8HXlBA+J59qAr+84gGDvrDZI7BNRVfYQtg3HqHrHSuTQE9crKk4
         yaluLftgQ+ofp1MOX8C286QT+3DPyQiU3UwDkowMVdJeFa6jvXrHCqL98H9S/Msh7vWc
         zrNAHb7WahhOLGw0iwjUxwTrjZ2on+D8sq3/JpRf1uPgRZUoAMCnZEDUEBnMhOm6LL42
         WlVP3pbVzbOce3XVF2HLRHcS3pLiTR/yf7Ao387glU42qeNyKRO7VuhF+PkyZSijr9sm
         h4clssdUpJeTiVBHu4I48WCuMnC5MySniB90atF/KcKkICxyVwPUvlndBLq6sAe2zZ5I
         aIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274780; x=1725879580;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IE7X1McDmWnrZdJLkqa3vbwEqyyfI/WuVigow1tXc8U=;
        b=DD6/NAuhdkatBSZfJT+8pCcTr1XqZoAnx7zjGwQ6bkRREJwROskmGNMnam6o3TeTeg
         l0IfqwHLW5BttAM/0lQpFNnJ2kXRI/aPfUCkKsIlNIMWJkLIx+dQFGQ7KWA0gYFdbgwA
         xHTvdN+a9LEKYVsOnUSHXl5ZcbJhyWj+czzI9p29PKx23rHdfig7KRLgQa16hoKfn0u3
         54DpoVV0g3ecKle+cxKdfgD+C4CMApSommz4zQhZf3w/M5lFroKwyBpif9rcOSYgdlbp
         fHSpAT1GxjzXg7uYDR0ArxTxhV8R5U/yeSxRwPUkOtSm++l2TqtaHzQhPnOIT6Ky7ttW
         vTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh0vz04qM05TFWDk6CdyJxA6Yq28jWtanDoEWgp+dkFd4GsRcj5Rvbl/zFWAYYW5dI7qeT9X1bIR+dySI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQIvBY4r6RAdwaA0KlLlv2mQiArq72W5KcdkRwDmxhqCLM4l+
	E+0Anl+8MVai7eEzz7CRuFB+/5oxcG1YHqG3PM9kgHpvTZmD2C0jMmb9Lec/1b4=
X-Google-Smtp-Source: AGHT+IHMSQcNGlrslcjYxClbm93xqtFH4EJ8YFSlB2X890aLSJu8AKnz6Np+du645tZJoW+16AJrhA==
X-Received: by 2002:a05:600c:1554:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-42bbb43d5e4mr40381915e9.4.1725274779523;
        Mon, 02 Sep 2024 03:59:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639671dsm169616265e9.5.2024.09.02.03.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 03:59:38 -0700 (PDT)
Message-ID: <842861a7-861e-42d5-80c2-854ee22707ec@linaro.org>
Date: Mon, 2 Sep 2024 12:59:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: rockchip: fix OF node leak in probe()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Heiko Stuebner
 <heiko@sntech.de>, Jianqun Xu <jay.xu@rock-chips.com>,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240826150832.65657-1-krzysztof.kozlowski@linaro.org>
 <CAMRc=MfzApzPVauqTm75PTGogRsW=cHH_zu_mCKnysvDTY8R7Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMRc=MfzApzPVauqTm75PTGogRsW=cHH_zu_mCKnysvDTY8R7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/09/2024 12:23, Bartosz Golaszewski wrote:
> On Mon, Aug 26, 2024 at 5:08 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Driver code is leaking OF node reference from of_get_parent() in
>> probe().
>>
>> Fixes: 936ee2675eee ("gpio/rockchip: add driver for rockchip gpio")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/gpio/gpio-rockchip.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
>> index 0bd339813110..365ab947983c 100644
>> --- a/drivers/gpio/gpio-rockchip.c
>> +++ b/drivers/gpio/gpio-rockchip.c
>> @@ -713,6 +713,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
>>                 return -ENODEV;
>>
>>         pctldev = of_pinctrl_get(pctlnp);
>> +       of_node_put(pctlnp);
>>         if (!pctldev)
>>                 return -EPROBE_DEFER;
>>
>> --
>> 2.43.0
>>
> 
> How about using __free(device_node)?

I can but I find it less readable. Existing code, after my patch, is
pretty straightforward:

        struct device_node *np = dev->of_node;
        struct device_node *pctlnp = of_get_parent(np);
        struct pinctrl_dev *pctldev = NULL;
        ...

        if (!np || !pctlnp)
                return -ENODEV;

        pctldev = of_pinctrl_get(pctlnp);
        of_node_put(pctlnp);
        if (!pctldev)
                return -EPROBE_DEFER;


So __free() would safe only one of_node_put() and grow its scope
significantly. Above pattern - of_get + use + of_node_put - is pretty
self-contained and readable.

Best regards,
Krzysztof


