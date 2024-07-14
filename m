Return-Path: <linux-kernel+bounces-251815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E3930A32
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDD4B21524
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28471369A3;
	Sun, 14 Jul 2024 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NoGmXG+q"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A381013210F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964347; cv=none; b=JB7yU/q2h+q46+ou3lbLAknjvwD0Tj+3BnXioIOmDzYvKGpWQTCvkgqJY1Q5PZux6VSrOhEsOFzlaOQyMiFQIsYnWfYr1Bx+jdSTcv2rockkpr/9YoGpKO2rGA4MgSkHRQ52PXkAl0sKi3LT8FR1KixLfi5nWWgBPXVYlweVNxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964347; c=relaxed/simple;
	bh=uvUoYmcJOqnz2JMNF7K9Zgwg80iX4tnkQCk0ossSdgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CocBiNmmFXJB8T9D2Jb2t0f+PUk7WDVMRXHQckOfYK0t1T3AdgO1c30LbylL9rYlwQHSyAYWb9I2/AwENa2139NxZKn+nuw5FgmowaAKJv8IXEQah7K1e/jMv7KfLqvH0SmZoysm2nzDwXbdzFpSqe+CsH812GdKhB8JWovspaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NoGmXG+q; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367940c57ddso2158977f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964344; x=1721569144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdvITy0aYi5fq6HtZief+0cpGX3BBKrYLZ5ln2thvbY=;
        b=NoGmXG+qhzZsTFR1v+77gOPNV1F4gXbcrE7k5Ips9xYuEcuUB3ShqGKss3ealCapJt
         Bs6OY1oRD0s8lTpRfOiJB9mD0r4H0g6cFLBvOcYDVK71EPofynUlHVKoMaez2TORTeSo
         BpLfcklO9H6CdjpBWBOksC8Fag2eDDKtgwRJXPhFj7VEFWdLFdfYsviev1salAetfA5H
         q/vAb7/pHuRe5gk57ndV9kDjH/z7kwIT9Pri2XDZ2uah5QnMpD0E2Xfol3OcjH2VDZLS
         d3qBAAk501DmTAqmWvCIla+tp7j8tQVgLaMhT8KBCHdqRbwUj1rDKz4rq48ZMXajNqCG
         I0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964344; x=1721569144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdvITy0aYi5fq6HtZief+0cpGX3BBKrYLZ5ln2thvbY=;
        b=WIriPrfoDouUc/72BZwyRpjgK4TXa76trlwHyWfU6vfzx/tBmw/s3tTDvwGXCOzuB6
         Ay2OhTtyvfRPrxIP6dUlRIaC5whxd9ye/5Aa7e2I7S9Jc5wIwDVMzxpazFyBtL6TKh8l
         wac74QMQM/Nq3Mp8tmPLm6FWU+edFlzRTSB6EAtHE/tR4bNfa6M+Yj2KtRMP7PUE/hd6
         x9x0FSRcB08ydpndps7ym4aB/7/wkRHFqrB0szHeUtqVuJgdbqkVHBnpS3aJFiY40iDF
         6/VjuQYtiZdbPqfPrVPGQSA3V9nc70XUaZSxa/OqJIVp+BxbYIXGEt+issQODBlDF2Il
         TUmg==
X-Forwarded-Encrypted: i=1; AJvYcCWCdPCvSimk53uzGsaP2UeUhUETGD3Tm0O1nXxz4h35ZT6qM07CYrEghallfCo+FmuXtI5hg/4Rz1xvW1XuPREPRfuu+g3wy1OC+Dmz
X-Gm-Message-State: AOJu0YyBSt8LNiLP/JsZgPiNYMD3RdK3UFTexsGrlZZzh6TcaGqE53nU
	EeyjWyYVnHpkeh3fR48UbLfc1vE0yWwNIf2jA504bRDKCHnidr8v47sU7CUTlyGyTc5afdqZhSk
	1
X-Google-Smtp-Source: AGHT+IGUJX4DRyuyPF4tBew5srP29MgpTUTGsgWhI1e0ohL2CkQ4uXr1zC4O0IM9DCdjNEFP0tQ9pg==
X-Received: by 2002:adf:a386:0:b0:366:ead5:f17 with SMTP id ffacd0b85a97d-367cea46409mr9870722f8f.9.1720964344058;
        Sun, 14 Jul 2024 06:39:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:39:03 -0700 (PDT)
Message-ID: <30cdb4fe-d2d5-4ac0-ae64-d4d1ccbf4487@tuxon.dev>
Date: Sun, 14 Jul 2024 16:39:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/27] power: reset: at91-reset: add sdhwc support for
 sam9x7 SoC
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>, sre@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102849.196305-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102849.196305-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:28, Varshini Rajendran wrote:
> Add shutdown controller support for SAM9X7 SoC.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/power/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index e3ebebc1f80d..dafb0126f683 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -34,7 +34,7 @@ config POWER_RESET_AT91_RESET
>  config POWER_RESET_AT91_SAMA5D2_SHDWC
>  	tristate "Atmel AT91 SAMA5D2-Compatible shutdown controller driver"
>  	depends on ARCH_AT91
> -	default SOC_SAM9X60 || SOC_SAMA5
> +	default SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
>  	help
>  	  This driver supports the alternate shutdown controller for some Atmel
>  	  SAMA5 SoCs. It is present for example on SAMA5D2 SoC.

