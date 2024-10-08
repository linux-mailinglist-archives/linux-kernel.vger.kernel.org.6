Return-Path: <linux-kernel+bounces-356032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FAD995B37
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6717D1F244A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BEE21503B;
	Tue,  8 Oct 2024 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iCahrbZK"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DF5212D14
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428204; cv=none; b=kGdrkMCedakVz9rsUtOX8Ft4+w56SynyFuSvoPT03aT37bdyA1ZQQ9kRO56QD/TmOP0DgbJiEEisdgt4JWn6lhp5Xkm/tQYZW+uYSSSOCHe9fCddceOhguph4GkpJuikX83CdMpCziDDq9CLE3bp2EL4WvOvWU+hUgZCdz7HQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428204; c=relaxed/simple;
	bh=W4qAhJNOoB5PxLZ+o81saA+Vr8YRJUGJiJ9OXszqCp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2xY1zolsAWPM3Hdp/twVRH0AZfmQJntkxJo3r2Hbx54Uwfbdk8aGmMKEIiKw95Dkf1SJar+3e4VjX+juC2+ko9SC4EujHxHj5DRjkJyX+9KC1SA1BI9D7URU/NNcl9wI2n12NAiJXD3GwiMxNAA8wLZftDe3WL6ES7Y9pvepVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iCahrbZK; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8353f5862a7so2017939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728428201; x=1729033001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dm5KR3yKJ7nb82RatWgCtQxq9u1gR67HhrKDYKDVxZU=;
        b=iCahrbZKw1BmgTj+wjJnxp4orGeVV50NGuxwS5OnISzp/EREr2si/gFK3IBCzfKHgG
         3XWk/PqrIS6lDNi1KMMmmCT6Gmydr5fQn19QJHqwn7+QWzhAIDvyZtK/UWGAk2lzMMWz
         3pd/fkXjZN7HMZc3Xy9H/dl/5KfhjWYjP8Pgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728428201; x=1729033001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dm5KR3yKJ7nb82RatWgCtQxq9u1gR67HhrKDYKDVxZU=;
        b=EgMi//XVyy2c/cq64/P5ZVa5igbfQt7IlDNqbl1GPzuE67yKnVCL8VX/9Rr9i8uDPj
         A2oblN1VN3PDbOr412xRCtpTZA6YdUoTac/TMEvDsLmqFVhT2QH1ux9S+VzXfEogVGbI
         OvdQ5zw86YoYWMmoZfSPwpyzK2Qa9IQm+3y1qW8k7Xpgczdb4bpWDaCbgIU6+nb8ZIrT
         lpgFJ/tRqFRQ1+1J8fObn8jT/8YCvVtOV3IW9E3k92KQE3b/SLQk+fUyd7OFcSYWfxFG
         BCHoN9NrsHNgTnLFtcT9SanrPcQ8O+aPt8TrEVhO0icp2jQehjaGARaDbOQV/RBP3dpJ
         dA/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTpgLsKGvKolA0yFa5D/GjIkFo/oUDyhYtOIAP5qOqSplX/nIHCZ+crqkUZSJhIlPooVYjF6pWEIsixtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vHl2KQyPywaA/gLHItXnj6XSnAHNZS/kAvwn8z5KTWFFHPgM
	1K3WtqWJmxlbHRiEsgflXCgkZG+nAeRDHv22pzxu8JQjkQPaXUmhnXXOrVyGTs4=
X-Google-Smtp-Source: AGHT+IHcsPiG3ayrLelizRE8PQU9rWi1sE+ha97beZLJ2/BTCyNLZxeFA29tgEJkFwYG9+z86gqNAg==
X-Received: by 2002:a05:6602:1655:b0:831:e9a8:ce28 with SMTP id ca18e2360f4ac-8353d50470fmr49903439f.11.1728428201275;
        Tue, 08 Oct 2024 15:56:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ebf0adbsm1827800173.115.2024.10.08.15.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 15:56:40 -0700 (PDT)
Message-ID: <aab81b14-415f-45ab-84f1-be9ed11e2a18@linuxfoundation.org>
Date: Tue, 8 Oct 2024 16:56:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: rt721-sdca: Clean logically deadcode in
 rt721-sdca.c
To: "Everest K.C." <everestkc@everestkc.com.np>, oder_chiou@realtek.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008174122.4696-1-everestkc@everestkc.com.np>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008174122.4696-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 11:41, Everest K.C. wrote:
> As the same condition was checked in inner and outer if
> statements. The code never reaches the inner else statement.
> 

Looks like this file is only on next. Use next in the prefix
[PATCH-next]

How did you find this problem? Include it in the change log.

> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>   sound/soc/codecs/rt721-sdca.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt721-sdca.c b/sound/soc/codecs/rt721-sdca.c
> index 36056cb7a3ca..4fd26e490610 100644
> --- a/sound/soc/codecs/rt721-sdca.c
> +++ b/sound/soc/codecs/rt721-sdca.c
> @@ -611,13 +611,9 @@ static int rt721_sdca_dmic_set_gain_get(struct snd_kcontrol *kcontrol,
>   
>   		if (!adc_vol_flag) /* boost gain */
>   			ctl = regvalue / boost_step;
> -		else { /* ADC gain */
> -			if (adc_vol_flag)
> -				ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
> -			else
> -				ctl = p->max - (((0 - regvalue) & 0xffff) / interval_offset);
> -		}
> -
> +		else /* ADC gain */
> +			ctl = p->max - (((vol_max - regvalue) & 0xffff) / interval_offset);
> +
>   		ucontrol->value.integer.value[i] = ctl;
>   	}
>   

Looks reasonable to me. I don't see adc_vol_flag changing.
Possible copy error from sound/soc/codecs/rt722-sdca.c

Perhaps rt722-sdca.c came from sound/soc/codecs/rt712-sdca.c
in which the logic seems to be correct.

In any case, I will leave it to sound experts to comment whether this
patch is correct or not.

thanks,
-- Shuah

