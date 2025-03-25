Return-Path: <linux-kernel+bounces-575906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FE2A708C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721FB3BDFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50764264628;
	Tue, 25 Mar 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2SXiKEe"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958B264A81
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925870; cv=none; b=H0YNGlgUEJNyTeLt4Q7oDvsn/ig9q8HCHVGa0syZhN4NBBzt6V8BSB1PPSuiQaqH3RECjRn4eXzr+Hta21XrY0PuxoCIYUNOshTa31Gd5GKx8OYeE8Cjcd26rH/1OcEJvPZePuFH+k4gvtiW6pVOGmlEcnhZyjSZTSoYAJ1zKpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925870; c=relaxed/simple;
	bh=rTjTJEKZGu08Y3nV5h6fqKxC03MuFdMFJiI+QY7DgyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RueLH06m9RrcJOIg7TSBU/Jgwb27Cb/cuJZe1oDpYH+vQuN6VfOnG1i0ISQ5eE9NCHEWDFmDW+DJpjGgzVHSvz2VobWhgKaZwPEikLRxI2ehcwQ2YEUp8f+Vyzvj3FdusbECN4IsdYU3Gg+1PYZZ9/Tm7Qp4Hx1Nx4yxbVO+VGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q2SXiKEe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso27356235e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742925866; x=1743530666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0CayCPCDi0c+eScMJRQeYXJLtxxGmBOFsr527xiD2I=;
        b=q2SXiKEes9KsWr887jneMZxZmF8Q287lcGXd6u5hjBhhVhxdqqjqEt0q9QP5dT/Vjw
         eyJP7ZQfb5q5UUNWdH2loSxVtNwgnDvBio7wL9cc9hPEDjtSxn0FElP+vM/38GiVGASY
         M8bzQ581adiXGeUpe81YqUGS/BPQgcBtDYiK6ARNSVhWNayLCcYLy1ufbAP3OOtYZrgQ
         HBpzLFNnjxOwwTWRpEdBQiRQZhylS0k/z0wP5zOHlastdOnwj0OODziQBw9c0HkzpNPc
         bp9f21zcQeG3CfCuFTrdJPDdeIBHk8FkkpSE/HHWQAd1k1gZTjvBSubdU/QpHFnWGR5r
         vNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925866; x=1743530666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0CayCPCDi0c+eScMJRQeYXJLtxxGmBOFsr527xiD2I=;
        b=eVYr8pjgoEl5iJtuIEJF9dUjO5v6GnyYpcFLFPZm2U3j7cKpo0Egu47bXvSyV2F5IM
         qh+i6M+hpvdXf1HFQ3GY26/b4zH1PTaXynzF5tDqq0LufCD1Gc8L/6X+lyCAySrVd+Jw
         U5c1kLHa+lnJkkPcHIXv8bM3RdKwmtoDaCVdGeCUPQgL5IdEPb3XFbCLyLfrvn9GWGS/
         CFZnwS0NksKFp7FxWSnzY2je4mDcos7NiPs9eBMN/FVALYAxcpGO0nkcpWspARf0EY0J
         cG55Yt5MrNVjElt7ZOA0fEcUaUegl9I/jIZw1JUpgBySim8LIsfTQ+/BjC4mepVIburs
         YOFA==
X-Forwarded-Encrypted: i=1; AJvYcCWgIALRGrBVPKIjze9TjqqT+7CiMttlA08H0h2g5F5/hOm3FqzvsecFBDih6TRzI5lUQbCXMOph9AWIlXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAqJe3hTReQDLKefwqjKekJ3GTqY6mW9mWhnIoO8ZmxAWVpVpe
	cqVZLX7o5KnOFUv6LCvlQyA4UJ8w7y7Gi3+4nD5jEfc+nU9pyRQXo8BJyFhIfI8=
X-Gm-Gg: ASbGnctO19X/r9jrkM7wL4M7iHfdMzOZm8fg5w5P3YC3s/u1Sx0/BQJfalMHrZery6q
	moFxTvHkdzI1bBZC2oyaKECln3CO/GwKiCA28IQhjvzJJapk0BhVVmuBkq1FznGOmg53hTa2Qhy
	vVGXkHqGAPAOXYUZC7aJfEh4coKemi6NiOajqotjBBAtdGjF8QAg3e9yxbQEiDKIeuHUhsdGHI8
	JVfJRyffQIVfTGRaGRYpxtIPbeshqvILeaXhFJQl7uQ6sFxLgeNXBoqE4NVWnYzQQRDUaDnjZLg
	p4QWBbZ4G7F6aNnfXjJrRKUL8k32u638aF9p707H9FQOQha8dvZVwQH0T/1w3Zc=
X-Google-Smtp-Source: AGHT+IH/PB6BVarMqT4SU3RviqfCTKK1Z7vJ2U4Ut/r5poNYG8tGZE1NVFEihed/kHkNIgYqkBvHXg==
X-Received: by 2002:a05:600c:692:b0:43d:17f1:2640 with SMTP id 5b1f17b1804b1-43d58db54c7mr71879365e9.26.1742925865894;
        Tue, 25 Mar 2025 11:04:25 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9b565bsm14550986f8f.58.2025.03.25.11.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 11:04:25 -0700 (PDT)
Message-ID: <4654f21b-bf61-4b41-b073-407fab4bff6a@linaro.org>
Date: Tue, 25 Mar 2025 18:04:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: peda@axentia.se, broonie@kernel.org, andersson@kernel.org,
 krzk+dt@kernel.org, ivprusov@salutedevices.com, luca.ceresoli@bootlin.com,
 zhoubinbin@loongson.cn, paulha@opensource.cirrus.com, lgirdwood@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
 Christopher Obbard <christopher.obbard@linaro.org>
References: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
 <20250325114058.12083-6-srinivas.kandagatla@linaro.org>
 <vmhrs62ygu2xozcabc6tgy37ta5qskeyks5j3ldponzfijicl4@nudcmxonq7qj>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <vmhrs62ygu2xozcabc6tgy37ta5qskeyks5j3ldponzfijicl4@nudcmxonq7qj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/03/2025 13:36, Dmitry Baryshkov wrote:
> On Tue, Mar 25, 2025 at 11:40:57AM +0000, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> On some platforms to minimise pop and click during switching between
>> CTIA and OMTP headset an additional HiFi mux is used. Most common
>> case is that this switch is switched on by default, but on some
>> platforms this needs a regulator enable.
>>
>> move to using mux control to enable both regulator and handle gpios,
>> deprecate the usage of gpio.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
>> ---
>>   sound/soc/codecs/Kconfig   |  1 +
>>   sound/soc/codecs/wcd938x.c | 50 +++++++++++++++++++++++++++++---------
>>   2 files changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index ee35f3aa5521..a2829d76e108 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -2226,6 +2226,7 @@ config SND_SOC_WCD938X
>>   	tristate
>>   	depends on SOUNDWIRE || !SOUNDWIRE
>>   	select SND_SOC_WCD_CLASSH
>> +	select MULTIPLEXER
>>   
>>   config SND_SOC_WCD938X_SDW
>>   	tristate "WCD9380/WCD9385 Codec - SDW"
>> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
>> index dfaa3de31164..209d0b64c8be 100644
>> --- a/sound/soc/codecs/wcd938x.c
>> +++ b/sound/soc/codecs/wcd938x.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/regmap.h>
>>   #include <sound/soc.h>
>>   #include <sound/soc-dapm.h>
>> +#include <linux/mux/consumer.h>
>>   #include <linux/regulator/consumer.h>
>>   
>>   #include "wcd-clsh-v2.h"
>> @@ -178,6 +179,8 @@ struct wcd938x_priv {
>>   	int variant;
>>   	int reset_gpio;
>>   	struct gpio_desc *us_euro_gpio;
>> +	struct mux_control *us_euro_mux;
>> +	unsigned int mux_state;
>>   	u32 micb1_mv;
>>   	u32 micb2_mv;
>>   	u32 micb3_mv;
>> @@ -3237,15 +3240,22 @@ static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_pri
>>   
>>   static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
>>   {
>> -	int value;
>> -
>> -	struct wcd938x_priv *wcd938x;
>> -
>> -	wcd938x = snd_soc_component_get_drvdata(component);
>> +	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
>> +	struct device *dev = component->dev;
>> +	int ret;
>>   
>> -	value = gpiod_get_value(wcd938x->us_euro_gpio);
>> +	if (wcd938x->us_euro_mux) {
>> +		mux_control_deselect(wcd938x->us_euro_mux);
>> +		ret = mux_control_try_select(wcd938x->us_euro_mux, !wcd938x->mux_state);
>> +		if (ret) {
>> +			dev_err(dev, "Error (%d) Unable to select us/euro mux state\n", ret);
>> +			return false;
> 
> 
> I really don't see any improvement here. If mux_control_try_select()
> fails, then on the next toggle mux_control_deselect() would still try to
> deselect the mux, although the driver no longer owns it.
TBH, if the first select fails, there is no guarantee that next select 
will pass,

Something like this to conditionally check before deselecting should 
address some of your concerns:

---------------------------->cut<-----------------------------------
if (wcd938x->us_euro_mux) {
	if (wcd938x->mux_setup_done)
		mux_control_deselect(wcd938x->us_euro_mux);

	ret = mux_control_try_select(wcd938x->us_euro_mux, !wcd938x->mux_state);
	if (ret) {
		dev_err(dev, "Error (%d) Unable to select us/euro mux state\n", ret);
		wcd938x->mux_setup_done = false;
		return false;
	}
} else {
	gpiod_set_value(wcd938x->us_euro_gpio, !wcd938x->mux_state);
}

wcd938x->mux_state = !wcd938x->mux_state;
wcd938x->mux_setup_done = true;
---------------------------->cut<-----------------------------------

I wish we could be taken care in mux-core or even in the deselect api

--srini

  Likewise in the
> remove path the mux_control_deselect() is called unconditionally. I
> understand that this driver is the only user of the MUX, so currently
> there seems to be no need for any special handling. However if the
> hardware design gets more complicated, we can easily face the situation
> when selecting the MUX state errors out.
> 
>> +		}
>> +	} else {
>> +		gpiod_set_value(wcd938x->us_euro_gpio, !wcd938x->mux_state);
>> +	}
>>   
>> -	gpiod_set_value(wcd938x->us_euro_gpio, !value);
>> +	wcd938x->mux_state = !wcd938x->mux_state;
>>   
>>   	return true;
>>   }
> 
> [...]
> 
>> @@ -3581,6 +3604,9 @@ static void wcd938x_remove(struct platform_device *pdev)
>>   	pm_runtime_set_suspended(dev);
>>   	pm_runtime_dont_use_autosuspend(dev);
>>   
>> +	if (wcd938x->us_euro_mux)
>> +		mux_control_deselect(wcd938x->us_euro_mux);
>> +
>>   	regulator_bulk_disable(WCD938X_MAX_SUPPLY, wcd938x->supplies);
>>   	regulator_bulk_free(WCD938X_MAX_SUPPLY, wcd938x->supplies);
>>   }
>> -- 
>> 2.39.5
>>
> 

