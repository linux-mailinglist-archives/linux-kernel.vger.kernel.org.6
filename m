Return-Path: <linux-kernel+bounces-359936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBED89992E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19588B287D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4501E2830;
	Thu, 10 Oct 2024 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOre5BX3"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7731CF2B3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589216; cv=none; b=BFUcHfgv503496DjAP4wFFH8bkOi5U4fvprjuWQe1WBg4yDyXbxeR89Nk8olGpXWZa/HEZvDsxqH4w3+et84MXHwZLo9Fe06rnqGl7cE2LjFKH+Q7lanbiOo1wAmN/25A8OUYykZt4S6AzGN9fs1d8iJXedvxi7P5Yr8MR3Qecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589216; c=relaxed/simple;
	bh=Hye3nDw1jtttwUJ61jl/l6DlLdBPK7kOiF/J4KWyD9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D833+G/CY0crefHlQls7M1PZ3Uow2yzdLaetEVNp9UXllA2BMs2YCLMuVDZWN5myJeVZWMgtb8aiYBSQz24Yl68l5vODkoc/8pfdolbBdErWRLqVM5SzApBn6GgQajfuyxlq9AqvFOnjP0k38vRrjJsGvOOm39Jg5LJias/K9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOre5BX3; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5e988c5813eso644010eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728589214; x=1729194014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/u7TPy5BjZaLYfGD4gZfyIHgo+2O/eJCYK+pY/z7ufQ=;
        b=WOre5BX3Di+fnG+00STkOp/wdHfEQazyrCJwW4LjY2nTXkSojCe1Hn5LopaO+MkOVt
         75cxJARXLi1EhT1BUhHH2w64OxwzUA3rjLvWhZgdMAQwUZYegbzOtoMHT1NnA8eg657u
         Um0QieeBlZ5HfrXulOAG5sMZtQ0CwDhefP7SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589214; x=1729194014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/u7TPy5BjZaLYfGD4gZfyIHgo+2O/eJCYK+pY/z7ufQ=;
        b=h7a9d0fnI0VdYHGKBn4R9MShxuwTt/8AJhqrhsxSGcpBwV3OkThX4FPb6smR81HnKj
         U3eqwGigdr7cFDa1hr/1b8TVdtj0sItZg4Obcj820vCuvNZzL49EgoFX6AE4CEn15gfC
         KC0N1gqI6FLpf/ch6qAGBG91JQDGP5m2PvUlM9Bzzq9ne6IJeaqAXoFtQUSqMaoSWZ75
         cPupZIXhG5BwU3F4avlaNIbCPYfKZiCLLYmMsqqspNBk/70WhUBOFT3yWWZ6DYMSuqQe
         3o+y1DGCpPa54RsGRSN0svUuBAgx3b24ORP1GCs1cjewnGHFThy7kaJaaMRxR9mwgyun
         baKg==
X-Forwarded-Encrypted: i=1; AJvYcCXpeVigesnUD+A32leHxfMnZO+0ByTV/pMzc4hZUACh6cGUFzgSInojmthlsLL4+XDoiOAzFQHZavHfWO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxORnd240RWvM6+mF+4J4Z6o1i1CJomZkY4Y/Uxqn0eYwIpoXPz
	GNfSQnKIQnAaAtndHikmaSQBBJpj1NWpxIMBLtncw4ENQUVcj9dXv6CVorMPiyU=
X-Google-Smtp-Source: AGHT+IHlBobIPH5lVju0BNVN+E124W/gKsWFcN4eUt66eehOQvTq1gxcMAnYFl6zGQ+E3sp69IN1ng==
X-Received: by 2002:a05:6820:615:b0:5e7:c925:b05 with SMTP id 006d021491bc7-5e98ff49e48mr3664116eaf.2.1728589214486;
        Thu, 10 Oct 2024 12:40:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-717cfed5f6asm304143a34.10.2024.10.10.12.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 12:40:14 -0700 (PDT)
Message-ID: <5f174552-a21c-4b87-bc9b-59956edecf69@linuxfoundation.org>
Date: Thu, 10 Oct 2024 13:40:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: rt722-sdca: Remove logically deadcode in
 rt722-sdca.c
To: "Everest K.C." <everestkc@everestkc.com.np>, oder_chiou@realtek.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241010175017.5215-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241010175017.5215-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 11:50, Everest K.C. wrote:
> As the same condition was checked in inner and outer if statements.
> The code never reaches the inner else statement.
> Fix this by removing the logically dead inner else statement.
> 
> Fixes: 7f5d6036ca00 ("ASoC: rt722-sdca: Add RT722 SDCA driver")
> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> Closes: https://lore.kernel.org/all/e44527e8-b7c6-4712-97a6-d54f02ad2dc9@linuxfoundation.org/
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>   sound/soc/codecs/rt722-sdca.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt722-sdca.c b/sound/soc/codecs/rt722-sdca.c
> index e5bd9ef812de..f9f7512ca360 100644
> --- a/sound/soc/codecs/rt722-sdca.c
> +++ b/sound/soc/codecs/rt722-sdca.c
> @@ -607,12 +607,8 @@ static int rt722_sdca_dmic_set_gain_get(struct snd_kcontrol *kcontrol,
>   
>   		if (!adc_vol_flag) /* boost gain */
>   			ctl = regvalue / boost_step;
> -		else { /* ADC gain */
> -			if (adc_vol_flag)
> -				ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
> -			else
> -				ctl = p->max - (((0 - regvalue) & 0xffff) / interval_offset);
> -		}
> +		else /* ADC gain */
> +			ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
>   
>   		ucontrol->value.integer.value[i] = ctl;
>   	}

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

