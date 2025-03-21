Return-Path: <linux-kernel+bounces-571400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EEFA6BCBB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1624417BAF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C5145A03;
	Fri, 21 Mar 2025 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRJ+mYwV"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F513AD38
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566476; cv=none; b=njO/Fd0zyAo+vkH5QeKLizH1coUZgVr6BGes62Z6ys8Q0PfHKEDWF9rNmFnPde6GgpkGM8S7FDUoplu6mldVGXhl5X7Uqx3T1TT3+jVvCPXKp1cNUBis5rrWQuwprRB8TbFUJLcBv9YKPR6c7nQpT4B9RaWE87uP2CgwuGjt4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566476; c=relaxed/simple;
	bh=ZZhBC4ZUh/6PRkPvmx69qNRirNMiGADybEAm/mIRUqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YB65l8uqo3jq4JJNXRau6TIaVZGKk7Ea0pDCUxh2AeQReZu0WQ7qSQG4tl8uvtlo8ZVjMnurUPoh2k/zlu8Qs2PysRpMzgkVuf0J4C93nENbeKNWH58INhxMkGqgGUQZlwhfDuaIK8s608NOacTz0qMRcwl4njllJfsFafWBa/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uRJ+mYwV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-391342fc148so1336887f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742566472; x=1743171272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxphMk5gHuL/ibLKGMHwC3/28Tm/GP6rXuS1fj8+YA8=;
        b=uRJ+mYwVfGZWja7qSQlzlUl22gMyKzmNlCO7k+vYcL/uFuhOLty8vFqRkaalzlf7Mn
         Rw1+ZgmLN2Zm3On5K76OA687wHKBh8s7tZ6LUZyP94wWiPHl1YEHCBpWg0u4271KJoXW
         xHhTdArdKZN1Mpm3NobfTQE2pHk4LXX/OJKlIVe/FDF15nSV8DfiNWcxgjgjDIvY8UB1
         fgATGhGZjaSQ4xur8Br2plWfM4KGxiOteoxkCieX0ylcwlLvNPeLfu20mvsqDCabRB+4
         AqxpjCR/5dwcOO/MFqV2KKpX/yZN4gYXz134D+wqMIOd5v6ANQss0YsZXIna3BcF16cJ
         sWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742566472; x=1743171272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxphMk5gHuL/ibLKGMHwC3/28Tm/GP6rXuS1fj8+YA8=;
        b=Xac3ZYl0UfdS3FU9LwQpzez7ZHyiQ2/wRlRLs1deFiop7/Bi2+73iyHP0DllbyUEfx
         m6rPaPnoAg9Yqk+818ttCyhPvZQ3DfrDCGG7qAkCxczpWHYohrAneq8+/Qd4+4P20z5g
         gLkrN1TliBGAIbOrkFXRuXSQMDXZtqyPHPGOxhmpldDzP7wz1NGX82Xz4dD8rjluu9BN
         ejwrhyrJScqXyqyIHleqWpKepQTfvZc+TqB7G/T5Sr3G9OwV7AWSe6PU5hhaD6sUYkh+
         cpcVlBNNYJd10WSc6Rw+Z56uSH77RLJ/mEPXsMoD44BxQsIvCyShWOx/Wa20AA3KZPYB
         6IlA==
X-Forwarded-Encrypted: i=1; AJvYcCWXdPQmWXsCcw1LU0fyw49X9/FijgWESi80o2QtKhDe1CIn033B/56yMZIi9xpy/UUT9K+SOelVpKEnk4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+1s0RXbOcZLareFGH3LSM2BRj1i65Xj1EvXBtYAmcTV4jrzM
	pP6ZIONmsJqMDkdtywkwKCeIx9sahLDJhYF0VHcKFELzISDtUEIEe7Oq4gttR6I=
X-Gm-Gg: ASbGnctxLG5I4jItQkbfqbOpoHtBLf/CfLHJVfJnNNcQDXhA3BcEfSi4zWd9joj2elJ
	cCm039R85waFcVgrntzlfq5dGDddou573eYCPLEOeA6PyS5ovvQ42Eks+2qZIQKGv5KRQkr9Qrb
	IXbWmQelIGFrW1ldn/PVzRsBnSOOWdugiILpJj0jQbqLZjaZb44cwBtenlAdCOuP+lTFOcIgN5R
	1kMq8LbQFECymDN1fBkvojfZadtXQ81TqaCj/mQm+vPrAueimZdaqp2IsN+UOw1wK2+3Bv8ZP0e
	b3L0BtgqzCGEepecsY17No3thr9NJ1j/sEsi8vosdwvJm5imyCPi3FX5WfKUh7E=
X-Google-Smtp-Source: AGHT+IENBehotMhwohtyGw9XcCRtOfJcARUzAAQZMbCLVLVjodl3cnOOUdTsf5h+Agrt7LuxVVy5wg==
X-Received: by 2002:a05:6000:2d86:b0:390:fbba:e65e with SMTP id ffacd0b85a97d-3997f90edf9mr2640161f8f.32.1742566472274;
        Fri, 21 Mar 2025 07:14:32 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9b5b8dsm2517680f8f.59.2025.03.21.07.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 07:14:31 -0700 (PDT)
Message-ID: <adfecf33-6ab2-4c3e-b7d9-3d6481ebd3f8@linaro.org>
Date: Fri, 21 Mar 2025 14:14:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: peda@axentia.se, broonie@kernel.org, andersson@kernel.org,
 krzk+dt@kernel.org, ivprusov@salutedevices.com, luca.ceresoli@bootlin.com,
 zhoubinbin@loongson.cn, paulha@opensource.cirrus.com, lgirdwood@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, johan+linaro@kernel.org
References: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
 <20250320115633.4248-5-srinivas.kandagatla@linaro.org>
 <rdvsnxuc6by6sci56sh7thzpxo5cqi7q24fnmc7hi5yrfszwrg@kqjpiilko3xo>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <rdvsnxuc6by6sci56sh7thzpxo5cqi7q24fnmc7hi5yrfszwrg@kqjpiilko3xo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/03/2025 14:03, Dmitry Baryshkov wrote:
> On Thu, Mar 20, 2025 at 11:56:32AM +0000, srinivas.kandagatla@linaro.org wrote:
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
>> ---
>>   sound/soc/codecs/Kconfig   |  2 ++
>>   sound/soc/codecs/wcd938x.c | 38 ++++++++++++++++++++++++++++++--------
>>   2 files changed, 32 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index ee35f3aa5521..b04076282c8b 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -2226,6 +2226,8 @@ config SND_SOC_WCD938X
>>   	tristate
>>   	depends on SOUNDWIRE || !SOUNDWIRE
>>   	select SND_SOC_WCD_CLASSH
>> +	select MULTIPLEXER
>> +	imply MUX_GPIO
> 
> Why? This is true for a particular platform, isn't it?
> 
>>   
>>   config SND_SOC_WCD938X_SDW
>>   	tristate "WCD9380/WCD9385 Codec - SDW"
>> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
>> index f2a4f3262bdb..b7a235eef6ba 100644
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
>> +	u32 mux_state;
>>   	u32 micb1_mv;
>>   	u32 micb2_mv;
>>   	u32 micb3_mv;
>> @@ -3243,9 +3246,16 @@ static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component, bool activ
>>   
>>   	wcd938x = snd_soc_component_get_drvdata(component);
>>   
>> -	value = gpiod_get_value(wcd938x->us_euro_gpio);
>> +	if (!wcd938x->us_euro_mux) {
>> +		value = gpiod_get_value(wcd938x->us_euro_gpio);
>>   
>> -	gpiod_set_value(wcd938x->us_euro_gpio, !value);
>> +		gpiod_set_value(wcd938x->us_euro_gpio, !value);
> 
> This looks like a separate topic, but why is 'active' being ignored?
> 
>> +	} else {
>> +		mux_control_deselect(wcd938x->us_euro_mux);
>> +		wcd938x->mux_state = !wcd938x->mux_state;
>> +		if (mux_control_select(wcd938x->us_euro_mux, wcd938x->mux_state))
> 
> Can't it just be 'mux_control_select(wcd938x->us_euro_mux, active)' ?
> 

No, the way this is supposed to work is that if the codec detects cross 
connection, It will try to switch the mux to other option.

So using active will just work if we try to pulg one type of headset all 
the time. But if we change the headset type the mux will still be 
configured to use the old headset type and not work.

fyi, active is always set to true

I agree the argument to api is poorly labeled. It should be labeled as 
flip or something on those lines?


thanks,
Srini
>> +			dev_err(component->dev, "Unable to select us/euro mux state\n");
>> +	}
>>   
>>   	return true;
>>   }
> 

