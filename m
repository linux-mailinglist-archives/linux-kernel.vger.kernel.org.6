Return-Path: <linux-kernel+bounces-300099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5295DECB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1056B219FC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77ED156972;
	Sat, 24 Aug 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AWcZgZTO"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4331547C0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724514847; cv=none; b=hAD7ifJ9BA6mhG+1uXxw+iHZB7FYVhpPSd+PVLtde9UZiQMzxa8FfoiO7oMhCW0PvRTBWU0wZbtFNGBEtGhiBYBg6G4LK4vFJCKNVAWLtoG1ih7JF2DXDC3tqnFkiUqUE3J2cT8CuEGb0zVIs2Iyy1KMxyQpuz04Vvar2TyKVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724514847; c=relaxed/simple;
	bh=J016U7PSO8GNBZzQogCWi62NNaDW1tsc/VWTmKocZfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM1rqotx1F6Kown90+zluFsw9vlH4gQnFutBibLNwy6itdiz/pNDP7cgk23LeJSyfTHjjhhC3HShJgr+JyXUBXn5uNSMXBVHjX/7Lo6t/YYSQJlNu9E4HICGd8IwoHlwQnnQ+ufYcYrmAHhDEpF/4BSrgP1tOJ0fnt7Z/eAkcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AWcZgZTO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so6856059a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724514844; x=1725119644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8RIxa9kABQkwtvml7wisQtNg7Z3R0IakjW6+eQyyu8=;
        b=AWcZgZTOAQW4tJ4oyeVFbAJoEOvhR5lm8JeSf5biNO+8+gxUf2hM2uUtxVc5+LSo0+
         o9G345bc8FWJEW2AkgaNt76aAmdj7AZFxmbNDiuNCEWtPPMKexdYHTwD5RCf8MTsZelI
         v+lB8H+fdmtbyBOuKAdC48CV5Q3ZdfTzQk3lDwwDO1F52roUx6Ki2V2iXPBLYmow5j+U
         I7/rGM1Yv4aZFSsvnf2fZNzcjlEKcHkWDixjJco2zCb8MdfqUBVKQqi2dhLjzZmYagWI
         msIjGL+0rvRFYowUasdDs2g4ewNlN5x6HOwU/WR/g4/cAHmgfONy3nL8gXlfOd9BWBVJ
         Ag4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724514844; x=1725119644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8RIxa9kABQkwtvml7wisQtNg7Z3R0IakjW6+eQyyu8=;
        b=DLd7SwUViIRMe7qaL5y3eqfer2N9c8fsshjHDynegkLOBWANk5xTD/qj5Re+qqRe24
         +mXkQNB5zjbcz2vO4rzpWQthS1C2Dsf5cmtbi6p5w0NqBoIkUZzSxCuEN+GbmAp8OhNx
         oPLykCEAndYk+dU5Y1jBAJqQQ6MbPYIUlgPAX5xC8IrtuC9Pf2moCZH5fio0ciGt7fMI
         VYEXhZppDP9z0tvsCQ7MjHskk4Kqggxh19XZgP6UHbwoG71cK/TdsqnFZa/9uZl9oAyx
         62jqSZvTRPvDNXvr4kEek9pHun5ATMiaJG5PoqCUHSu34KRn9HI45xr1yxDRThtkofr1
         SVNg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Ki1TF7X7jPaLoe5LlfKuxIpv1QMPZcnJRbTckdjOg+UdCwaNOAaJ4TFVXQoVTe4F4fhifAW0QKXDMYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL75FScOSzDfdLlSRRFV4dg9QYfwVS8NATn62A3IZJJH+smYge
	V4GzvJmNFI3EAQuy+t0vPocc6DEKGU4MF4YuXxUUww+uF4LT7bXMh7IaEhb5EDQ=
X-Google-Smtp-Source: AGHT+IG6XwF7HPlrwz2Z3mb7AjMY5EOkA1Zi/GfdGHr7Y9e07xifT2kGqWxTSR6b/UkRsnw/qzOdBA==
X-Received: by 2002:a05:6402:909:b0:585:5697:b882 with SMTP id 4fb4d7f45d1cf-5bf2bdbe124mr9155778a12.3.1724514844007;
        Sat, 24 Aug 2024 08:54:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ca4d2sm3434336a12.36.2024.08.24.08.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 08:54:03 -0700 (PDT)
Message-ID: <5228af83-b423-4f51-820a-edfc40017ca8@tuxon.dev>
Date: Sat, 24 Aug 2024 18:54:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/12] nvmem: microchip-otpc: Add missing register
 definitions
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>
Cc: Christian Melki <christian.melki@t2data.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:MICROCHIP OTPC DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-8-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240821105943.230281-8-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.08.2024 13:59, Alexander Dahl wrote:
> According to datasheets DS60001765B for SAMA7G5 and DS60001579G for
> SAM9X60.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/nvmem/microchip-otpc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index b8ed7412dbca..4630e96243ac 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -21,9 +21,24 @@
>  #define MCHP_OTPC_AR			(0x8)
>  #define MCHP_OTPC_SR			(0xc)
>  #define MCHP_OTPC_SR_READ		BIT(6)
> +#define MCHP_OTPC_IER			(0x10)
> +#define MCHP_OTPC_IDR			(0x14)
> +#define MCHP_OTPC_IMR			(0x18)
> +#define MCHP_OTPC_ISR			(0x1C)
> +#define MCHP_OTPC_ISR_COERR		BIT(13)
>  #define MCHP_OTPC_HR			(0x20)
>  #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
>  #define MCHP_OTPC_DR			(0x24)
> +#define MCHP_OTPC_BAR			(0x30)
> +#define MCHP_OTPC_CAR			(0x34)
> +#define MCHP_OTPC_UHC0R			(0x50)
> +#define MCHP_OTPC_UHC1R			(0x54)
> +#define MCHP_OTPC_UID0R			(0x60)
> +#define MCHP_OTPC_UID1R			(0x64)
> +#define MCHP_OTPC_UID2R			(0x68)
> +#define MCHP_OTPC_UID3R			(0x6C)
> +#define MCHP_OTPC_WPMR			(0xE4)
> +#define MCHP_OTPC_WPSR			(0xE8)

Are all these used in driver?

>  
>  #define MCHP_OTPC_NAME			"mchp-otpc"
>  #define MCHP_OTPC_SIZE			(11 * 1024)

