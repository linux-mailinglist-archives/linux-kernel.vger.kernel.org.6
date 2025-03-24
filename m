Return-Path: <linux-kernel+bounces-573662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3212A6DA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C247A20FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38CE25EFAE;
	Mon, 24 Mar 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWMwYs63"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A983B25DB07
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820727; cv=none; b=ttCbULehxvcqVgxlED+DsFDuv8k2lt3cfammE1X708iH1y9IXOljIexSNowhy1HsALQTXYlrGAw/Ez99tMHOY0NSkm2Cvx7LrohtM7vt1DiDItN9nHvU/CQnwpkqUxgbTybxlMjb+1YKrROcaWl4TY8/7pCEjBze5mNfiouC8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820727; c=relaxed/simple;
	bh=mHhllHjm+p74J5dFBl6gDV9/cphe/QRNlrK1PzJ0idg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNOLRQzPxkAhwMQEJr8HgAfZSp/UIIjA4DX5rTJ5+0hXli2rjyycMZinAaGFXXFoAhYRZAP/21yk5vSJyFgqkWEqhNKgARblbDHXqvJLMMMKC7CeHCd4fV3KwlO3Jju/rEU0NAdzw+p3I4MM5U5BFcUjIspSqRkyg+hRHSiNWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWMwYs63; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so20699455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820724; x=1743425524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M96fzSOjd5lMa8AePRbILOLbgS23Y2+wDGZKhoW4JZQ=;
        b=IWMwYs63jb6UcrbfB3ZCkwc7IVgrfBCf7QlLs6RP4b2GeOqbKooYBq/A0gBn26L2cN
         ty9rWiZDJdSzjImdAn6fjc5wv+4Kjr+PaiKTje4HqiAneQbgSGpqoqKWqFCFvlq856Cp
         wd88kagNqZmbBEFrsSxp0mrm2/Witqf+M9ml/flC7cxPCcbokRXetpArbWTnX5tJo+5w
         ST9UIBE7ig+l6lYZulO0AX1v2iol2pBtiKNLHLhL71nDBHzj0+K7DA/QE0hFLuSLmFHq
         5yHnzMopFBdgBN/uV9YuIr7ticUcxPOea/Pjq77lwNlhpWuBhblfE2hVWcNBVi8IsIGQ
         Oe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820724; x=1743425524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M96fzSOjd5lMa8AePRbILOLbgS23Y2+wDGZKhoW4JZQ=;
        b=FFH8VukfapnNT0CJm3jpqJFJSO4tW0e6zlgWDeVXdRjxsi/g0itHcV4RLbflnktwit
         8F+7OQ39N1B4Z18xeyuF9hYDyXc7lC7VwMvtna3bH7lNSn8dJj2UWsYzRTVcc9/Gig6B
         6trqe+Jich+9+P0h28IfQ7sVfSz+16GoHyd91hpmck2DImCIjg2Kh5ck8KZtZmJTA82I
         KoDtF86lKW38ZmGwUiBODvnKMl8RbY9ph50aejBCRIwUVBxpF+zdskymW0sgMl9G8hmf
         M1/UEPytRVOor7C5TnG0pOMODTYqAoUjLoR9ug8VePTyr7eHnGQywOVwyf3gdNA664XH
         dp6w==
X-Forwarded-Encrypted: i=1; AJvYcCUQqfHc97GU2RmFUGNOtSOADLqSdmvr5Czjg3TEEFZYDDA0xIpzFlrW3HGbDkmU2JvS8NH52OOYj+NZpc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/aCTjHPJteo34XS+5Bdolr8SI4eJ1T4f4vQCXi8Ct6GEautL
	Ij8iKgPUZ8I7QEmAKTlBVfHgCg3PkaBL81RDMZUHTNRPdY4SMzQ7OCBOwIdhdXE=
X-Gm-Gg: ASbGncsbBBNQAeTbe7vuejtJ6l8aQjiVCiTk5OCFR1sUy/rUTP5FTbcwoI3VBH+T3m8
	GxmfvJ4fwGPTlpMko1P+mjRaXwqMk0Xl58dMzRz1L+fZKfp8r2hNkjKj5272nABZMaugVuChUcH
	e+miycL3MfC+ytGzSN66ZP2qiu1lGTIFOcNZkTPYrLqcfisaaupn19/aQJCWEmgq1xN6uSUyykc
	pjV6Of2aZ/Uw/Uxr0+57meW+/ghH1GPPJakRPXHDGv5mglBWe9mXb1EEaUw8v/M4mC72xiMfoWU
	VJKvxvGb43zd557VW/fwBT3LwHJiZhEjGv5JnP3kSFBYBnY/20m8CGQ=
X-Google-Smtp-Source: AGHT+IFUAo3zCdLK5ulVRumGRwS+0X9ngGXDVA3/EPbZr6WWjFqGe5yC9iRs2jeidcq5aHVNS2UrhQ==
X-Received: by 2002:a05:600c:44c6:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-43d5114e467mr93482935e9.11.1742820723929;
        Mon, 24 Mar 2025 05:52:03 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd277d5sm120604745e9.19.2025.03.24.05.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 05:52:03 -0700 (PDT)
Message-ID: <ed56c2eb-5bd7-49cf-bf2c-5826e3c42077@linaro.org>
Date: Mon, 24 Mar 2025 12:52:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] firmware: exynos-acpm: use ktime APIs for timeout
 detection
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250321-acpm-atomic-v1-0-fb887bde7e61@linaro.org>
 <20250321-acpm-atomic-v1-1-fb887bde7e61@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250321-acpm-atomic-v1-1-fb887bde7e61@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/21/25 4:40 PM, André Draszik wrote:
> acpm_dequeue_by_polling() uses a loop counter and assumes that each
> iteration of the loop takes 20us. It may take longer, though, because
> usleep_range() may sleep a different amount.
> 
> Switch to using ktime_get() / ktime_after() to detect the timeout
> condition more reliably.
> 
> This change also makes the code easier to follow and it allows us to
> adjust the sleep without having to adjust the loop counter exit
> condition. This will come in useful in a follow-up patch that changes
> the delays.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  drivers/firmware/samsung/exynos-acpm.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
> index a85b2dbdd9f0d7b1f327f54a0a283e4f32587a98..d7ed6b77a957af5db5beba7deecce13ac7b30fd2 100644
> --- a/drivers/firmware/samsung/exynos-acpm.c
> +++ b/drivers/firmware/samsung/exynos-acpm.c
> @@ -32,8 +32,7 @@
>  
>  #define ACPM_PROTOCOL_SEQNUM		GENMASK(21, 16)
>  
> -/* The unit of counter is 20 us. 5000 * 20 = 100 ms */
> -#define ACPM_POLL_TIMEOUT		5000
> +#define ACPM_POLL_TIMEOUT_US		(100 * USEC_PER_MSEC)
>  #define ACPM_TX_TIMEOUT_US		500000
>  
>  #define ACPM_GS101_INITDATA_BASE	0xa000
> @@ -284,12 +283,13 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
>  				   const struct acpm_xfer *xfer)
>  {
>  	struct device *dev = achan->acpm->dev;
> -	unsigned int cnt_20us = 0;
> +	ktime_t timeout;

#include <linux/ktime.h>

>  	u32 seqnum;
>  	int ret;
>  
>  	seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, xfer->txd[0]);
>  
> +	timeout = ktime_add_us(ktime_get(), ACPM_POLL_TIMEOUT_US);
>  	do {
>  		ret = acpm_get_rx(achan, xfer);
>  		if (ret)
> @@ -300,11 +300,10 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
>  
>  		/* Determined experimentally. */
>  		usleep_range(20, 30);
> -		cnt_20us++;
> -	} while (cnt_20us < ACPM_POLL_TIMEOUT);
> +	} while (!ktime_after(ktime_get(), timeout));

ktime_before()

With these addressed:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

