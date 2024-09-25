Return-Path: <linux-kernel+bounces-339081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC27198601D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED27C1C2609C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082F0198A0D;
	Wed, 25 Sep 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WeiJ1gt+"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89653196450
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267196; cv=none; b=hD8t2+s9DsR46h1D1vmoS+T71K2gUnEVXRneX9GD4bU2Q5hRv19OaxA+xalKzEG3PMIpYemWVS71Hqq/aUEyBfhLCCGjMy3y74vcOjRZXJXROXiYlJ9zJhdYbwm4oYT7SXir73c8PWCdMJomF6MCW1X3EpAjT3xxrlfvyx2YZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267196; c=relaxed/simple;
	bh=44dUcyb4pojWlalreytAu2YYfrk2bYX8H5gach7S1VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTiOoRCBQYEJICxOb9R9qbV0EXjRA/IuShEsOdBBA2QftP2x4Pvk8og5INsnkPZSDDJpQslAo/4pwKjetQZZzMKqBQ5KthuEqvpGr/JlkjmiJD7SQ8RLXKVrToTbvUgYGscSwenn0QVuv/dAR85OrS6JpSnohM4GpzpR1CI9sEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WeiJ1gt+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso172802666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1727267191; x=1727871991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXObrB9SCWT0qsHW/jrZ3wivuu5nQ72fsLR3yoLGNyQ=;
        b=WeiJ1gt+TudydtSt5RAr16NiwqsyLZtmNGcfNJ3ZNj87QCY+QtMx7MHDUQQspKrIkA
         mmKOd0IXDDgbMPc2hWXqUvGaEkdN3An3TSz8Jj+QK/oxuCOh7VaI6myi2oCAzPQr8zFr
         5ESFl4p6/DEdziGnFn126vEYd7g+fG0r1rr8GNMaujGqR4cMIU5WkfnlVfJ4PMtJztw6
         mNayxsnYa+L3vUksKgUbfee//BGBfBpItlhtBjnT76GpWeVXgYB1Nl75M6/cuISJ96yX
         vIkqwCTas2MMD0IzWm4zDCInTFkM2npiwCyW6bc/eMPFlItYAOjiKFZE0Q0pu7cLX9LS
         01hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727267191; x=1727871991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXObrB9SCWT0qsHW/jrZ3wivuu5nQ72fsLR3yoLGNyQ=;
        b=nUBn97WHuhbcW4YgY3amlUELov5NEUPhqYDitqCTrpwsnAHxyYyxiKG71BeFD9yk4l
         zzPSD+O2dKJukzYyDOJ5tQXOM51EMkiZGNsLQClxJdODQFq4b4W51sMBSvvLvSREbiT5
         ngULX0Di9vueqZTIvWj9okTVFknObRMuVNDJFZ+TDFz0f48Bo0XzF0TJAe/4qYoUk5B/
         OkXAb8ai6EuSTP+nGTcjV7bjq+icti0/E2bbXe272eUnLegRUVy5aTRQGyzNZvf1iW8C
         Xtx5NIyyD2PL1WOyTh9iAhN+Lc6p7Jl7rPqhtWlBJ3R9KIqgQZdtPhGsUZA5zbsjQ4tF
         B5+A==
X-Gm-Message-State: AOJu0YwABId8VHm91w9ev/p1E2mBKxzpt4rwkzZsAdZZqOddiu6wMGLJ
	77XgbN6DwjSMT6HkXUrN5aM8ViyUjhTCw+kQq9RFU8Z5zu/1ZJhVjF+5DIHbKek=
X-Google-Smtp-Source: AGHT+IFGt9TvMcN8PokSCKK6m9lqKpNnIJl+qSPpLG4Ds1hb9WW4j8dhPYticmSgUnzrpD/liLTKmw==
X-Received: by 2002:a17:907:2da2:b0:a7d:c464:d5f3 with SMTP id a640c23a62f3a-a93a16cfb5dmr274302866b.11.1727267191398;
        Wed, 25 Sep 2024 05:26:31 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93a5fdc3c4sm59145566b.220.2024.09.25.05.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 05:26:30 -0700 (PDT)
Message-ID: <12fed7ff-6ca5-409a-8215-e3eb955eaa1d@tuxon.dev>
Date: Wed, 25 Sep 2024 15:26:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for MICROCHIP ASOC
 and MCP16502 drivers
Content-Language: en-US
To: Andrei Simion <andrei.simion@microchip.com>, nicolas.ferre@microchip.com
Cc: linux-kernel@vger.kernel.org, cristian.birsan@microchip.com
References: <20240925120224.120032-1-andrei.simion@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240925120224.120032-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Andrei,

On 25.09.2024 15:02, Andrei Simion wrote:
> To help Claudiu and offload the work, add myself to the maintainer list for
> those drivers.
> 
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09d0f09c36cc..7f2f87a2483a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15088,6 +15088,7 @@ F:	drivers/spi/spi-at91-usart.c
>  
>  MICROCHIP AUDIO ASOC DRIVERS
>  M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +M:	Andrei Simion <andrei.simion@microchip.com>

I think you may also want to update the MICROCHIP SSC DRIVER section.

Other than this:
Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/sound/atmel*
> @@ -15196,6 +15197,7 @@ F:	include/video/atmel_lcdc.h
>  
>  MICROCHIP MCP16502 PMIC DRIVER
>  M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +M:	Andrei Simion <andrei.simion@microchip.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
> 
> base-commit: 2b7275670032a98cba266bd1b8905f755b3e650f

