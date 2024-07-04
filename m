Return-Path: <linux-kernel+bounces-241429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40079927B58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C28BB260EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DFA1B3746;
	Thu,  4 Jul 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcQs575z"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A81B3721
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111286; cv=none; b=mqq5W4KgJ8n8/KO+2wbizAolmjVU6MpDs/XC0lgvyVe7jjdUqj5S8Em6a9JM8WO94GcZe16IyorK9aYlHRAbB8xysnd/ggxR17NOPQHFQdrHLTMfseQhHHUD+xYsD1QR1OHiuy0PtK8YnX+bYJM5b8u22provGt8gz36zxboa6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111286; c=relaxed/simple;
	bh=j0MJRtYH6MPSRQ8QRM4Y07T56kAL7fwsjh0T91jkD/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6UucB1zaoFLoyStHQOMMPTUDyC/TuYbpG7PZZZC6gSp7VGs751Pl+h0J57x+/h6mtsGGeXs+UmPbqm5F+F8oEot0FEzqmrp/V/Ho61Ctr5Vq0OJpFnDBLhVXKNRYndMrFG1nxiHZ8qAzxO+uxgK9GPKBnJ8O8CCpATUvZ5eyPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcQs575z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42562a984d3so5432075e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720111283; x=1720716083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbhCAHjzwKa/kbyfp+8ibcL3AZKOrE0W6Q1q/9j6rtk=;
        b=xcQs575zteoOlLhw8A/TFwO4dzIV5wKz8c1za1J+hQg9ErHN7hGNucDDKztKa6eTDQ
         zbKTiPAaTV4sg9h6yniyiJJiPJh3Mc+r9jc+Qlu8xa5mF0B0X8/ecXd99wK4kW5Lzr7s
         KaGQnPA5X/heDW12JZ/NameQJPwY6EnnG4dhWaEjUsK6sF0bdyhH/OE2eYsiCVEvkjd5
         4WOAu+SGgGjQw70Sq7p+HRHMPosrQh12DfNLcuA8ZwYfB12DJiPdj9awBnVdbqkMXQUN
         SA6kL18fNKvhRLFqdsGHbnLgnzte5Ju+SnQPP6pUxClZIvHBlLvkMEyQJbdsafwUfDdh
         XX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720111283; x=1720716083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbhCAHjzwKa/kbyfp+8ibcL3AZKOrE0W6Q1q/9j6rtk=;
        b=DGsRIJiz7TBOpAzeblQD5m65N8+5JEGsMak/ETUogv/I2pFGZF2qbRZ6zd2EN1/+yw
         HqAOFWQGRZHtShcpMZZjEkDqR+FVqvnlE0L1RwjxxdxUF69cLNjRbygVs4Q6+1x5+YD5
         tSbuBB1L7l0H/S+T2CTEqwvE2neKVGYMxtr5+V0EIuS96CYGM+cw2A/DWPIUjc/bW3rn
         kC+8ekkgsq9xZj42eY9dmheM0+0ksC9FZqHZncALrPznXAgKafiranccX6fdulHg1k/w
         41zZ9Na+LNGalBXvucy9uPt+CHAcpq9N9/lcifndzjXjKMiTgksIW2kZ6jTlgzqKcqgF
         jjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3vBhrvuFNSqb+sB/8MRBCMZnsCkwT36FYzaabaHQFT/ZO7y2Uzo50J0Hf5s62M9kLeVv8+zeZ8icYwCn+8pLDWMsP4D4xOWQw3BG
X-Gm-Message-State: AOJu0YxCFzky7MjHctO5tc2+nDb2E/2/qOyZOalP4mGm2sBykU6GaLDo
	pAsCHJa7uB/mtpzR0MsPcDgNo5lbH5KxTDdrSmr+scToPGsNCZYGGafdZArKnjc=
X-Google-Smtp-Source: AGHT+IEmjMnbNWTHVuKayDN1gPs03b/0eR6prKKemb8Ks2ETqeMZmhbCsamzyB5Q/aNz5Z43oBc85A==
X-Received: by 2002:a05:600c:3420:b0:424:a588:ff08 with SMTP id 5b1f17b1804b1-4264a3dc76dmr16158095e9.23.1720111282853;
        Thu, 04 Jul 2024 09:41:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-367900fd1e5sm5477556f8f.63.2024.07.04.09.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 09:41:22 -0700 (PDT)
Message-ID: <a50eb87a-4dcc-4272-b897-fb8170bfe58b@linaro.org>
Date: Thu, 4 Jul 2024 18:41:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: core: return -EAGAIN on uninitialized read
 temp
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rhyland Klein <rklein@nvidia.com>, Anton Vorontsov <cbouatmailru@gmail.com>,
 Jenny TC <jenny.tc@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/07/2024 10:52, Neil Armstrong wrote:
> If the thermal core tries to update the temperature from an
> uninitialized power supply, it will swawn the following warning:
> thermal thermal_zoneXX: failed to read out thermal zone (-19)
> 
> But reading from an uninitialized power supply should not be
> considered as a fatal error, but the thermal core expects
> the -EAGAIN error to be returned in this particular case.
> 
> So convert -ENODEV as -EAGAIN to express the fact that reading
> temperature from an uninitialized power supply shouldn't be
> a fatal error, but should indicate to the thermal zone it should
> retry later.
> 
> It notably removes such messages on Qualcomm platforms using the
> qcom_battmgr driver spawning warnings until the aDSP firmware
> gets up and the battery manager reports valid data.

Is it possible to have the aDSP firmware ready first ?

> Link: https://lore.kernel.org/all/2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org/
> Fixes: 5bc28b93a36e ("power_supply: power_supply_read_temp only if use_cnt > 0")
> Fixes: 3be330bf8860 ("power_supply: Register battery as a thermal zone")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/power/supply/power_supply_core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 8f6025acd10a..b38bff4dbfc7 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1287,8 +1287,13 @@ static int power_supply_read_temp(struct thermal_zone_device *tzd,
>   	WARN_ON(tzd == NULL);
>   	psy = thermal_zone_device_priv(tzd);
>   	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_TEMP, &val);
> +	/*
> +	 * The thermal core expects -EAGAIN as non-fatal error,
> +	 * convert -ENODEV as -EAGAIN since -ENODEV is returned
> +	 * when a power supply device isn't initialized
> +	 */
>   	if (ret)
> -		return ret;
> +		return ret == -ENODEV ? -EAGAIN : ret;
>   
>   	/* Convert tenths of degree Celsius to milli degree Celsius. */
>   	*temp = val.intval * 100;
> 
> ---
> base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
> change-id: 20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-077166861efb
> 
> Best regards,

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


