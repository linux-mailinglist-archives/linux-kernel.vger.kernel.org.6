Return-Path: <linux-kernel+bounces-571237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05340A6BAC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769AC466B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB52227BA1;
	Fri, 21 Mar 2025 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lj4NMOu3"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932191EE7C6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560542; cv=none; b=WbMwk39d24knZwy06vJ0wB0u9sZU7Zdk8QdgG5iKdiW+kL33iLMt+a5VTqpbNgyhFbMNigs0kBN7LtlBb89kEd/ZdnnHlBsIhbHD4bTHoKuXb/92fJIi63Z2bf3CRmw4+hapu+57VlohzLZh7iYCTn48J3XoLzqPUjqJZU+naWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560542; c=relaxed/simple;
	bh=6PRbJ7TQ5aODdbz0m2PU+5RLlhJgh3PHA4Yj0p5qlTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCTHjBRjPRYlTthil19hLtAe0Zov45M0X3yVf1uu4i1gybMbHRbZ8WXyw5cexVvNdy626yZ5UqBqvkWOllQ4rnUTMqFWRkyCOUvxHuBcsm1QMyCa1H/KW3EUrzJOlac5gECgELVG9uI7cAs0F/gZ1ZCcgAnPeVlQWsL2QQEjsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lj4NMOu3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso3404414a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742560538; x=1743165338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yv4lZ+YNLUl7ot9RW8qDQsIhZ1LLB6J6i6RU1rh9WlA=;
        b=lj4NMOu3omf+TEDG3c+kA8Vh7ru45E0TBhNissTlAmVNDHnwS7x2W5VO8KdUj1xv5j
         Px7PET9GHb04dmviaQMirOp0Gm4aNeSewG2COqhrDJnxAdRrhHcaWUcFK4NHIEImTGfk
         4oGCuaSzSXvzHL39ELS/YQZjMTxLucQTxI0/nMJ0hcpKy61NayLUktIBPGT4gnN6mIJm
         q4tRRhOkk6DiFko66uUqbIULKbx51Qx+vFw9nUaU39EQ1EsRQ6QJlJQj2SkdHA0Vrlq2
         sSGBlMUtsvaT3b/upJ3UInahdE1N2SbMWOknlKzX/4WU60cldwZ8AQ/jEpjfvkR8xXpP
         ZA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560538; x=1743165338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yv4lZ+YNLUl7ot9RW8qDQsIhZ1LLB6J6i6RU1rh9WlA=;
        b=Lfnr8fO9k/1oQcqbPVfz3ymzRon+bMBR/Wm/bdh5faEvp05zXVcysXUI4Gv3CJX9Vx
         EgRynCn0XddGflsxXdD3EwAxBY8yFU7hdcYICvwYNoeFshNrs3HHNOQrExKPfviW1RmH
         ttuYb87DTNt3vM5ru1bOU7Q5OTt5Oz6EFgGrluqtyM4sxEQkQ7VKYCuW1XE2oCKSiLFy
         4kNkh3frsHo3LWWxm0V8T5LEJSLaVJjIkShEjg0h8IpYq0qjKw0ax4aJc6M+UZUr5F0k
         BrOrotX1RlsyjVbhcEpfFl20mO5D/+D4xLKnrhiX/noqgupGOHVTOWvcwLTn5+7Vg9gk
         fmzA==
X-Forwarded-Encrypted: i=1; AJvYcCV5iYXNor8IcvmtTo2nFZSo011B/tIGVIaVs7ZSnhxCEM1fuu/nUU4mOm+JIqmnxUobH3mNr8ysfqoMqRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVObrBeVUPjWFIZkfZiG5EplAQReFK/klhpsX0aXuh5417h7z
	JcpaFZJ0t+N+YmCHQLivRcEQ9mQ+70CxXb8do9OyOcwXiF+yoOBKzbPtdq7BrMk=
X-Gm-Gg: ASbGncsCi+P53LjMJBz0Kv68OkN0mNONaCJser78Piy4yp5T31qdeCZmfLUiC/PBoK8
	X0i6fPa/vk3UdyMRrDV9RMTo/MLr5PDf8dabDjcV/cOwlihPFURnQK7ZZIkKrg/3SoLumMNSzzF
	I5kNECw759lCLy0lpACjr3D45KddRoxSCpc3RcbGhi5EEcGB3W6nPfM0rY8gzhybQcJAZ0J+vCl
	6SZJk2JXtu4NPNKkHk+2lL2rQL/kzthyDGzD26h2347ZNJTgCP2CdlVXrjKARipPnOolzjK+Bts
	x6R9tWR8wwi0PVW5KP1e/BwkBpxKC4PTTBDvKAWDoKjgypPsIWp3OByuV3gx90u2G/wfSYQXHw=
	=
X-Google-Smtp-Source: AGHT+IG2h1yWDQQeNTqSEG97hM0WQIsywT10+rmqmILs3H3/8OMMRH7lWKNJLMtf+dIGR5DUR3nMqA==
X-Received: by 2002:a05:6402:51d4:b0:5e0:8c55:501 with SMTP id 4fb4d7f45d1cf-5ebcd41677amr2789203a12.7.1742560537711;
        Fri, 21 Mar 2025 05:35:37 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c774esm1257920a12.59.2025.03.21.05.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 05:35:37 -0700 (PDT)
Message-ID: <b1aed195-b2e6-4f48-ba10-3049d74085a9@linaro.org>
Date: Fri, 21 Mar 2025 12:35:36 +0000
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

We want to move the codec to use gpio mux instead of using gpios directly

So this become codec specific, rather than platform.

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

We should be able to use it.. will fix it in next version for mux usecase.

--srini
> 
>> +	} else {
>> +		mux_control_deselect(wcd938x->us_euro_mux);
>> +		wcd938x->mux_state = !wcd938x->mux_state;
>> +		if (mux_control_select(wcd938x->us_euro_mux, wcd938x->mux_state))
> 
> Can't it just be 'mux_control_select(wcd938x->us_euro_mux, active)' ?
> 
>> +			dev_err(component->dev, "Unable to select us/euro mux state\n");
>> +	}
>>   
>>   	return true;
>>   }
> 

