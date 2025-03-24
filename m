Return-Path: <linux-kernel+bounces-573610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1216CA6D9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3F41894338
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB025D527;
	Mon, 24 Mar 2025 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fSG+scVS"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AB25E461
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817898; cv=none; b=RaiSX+5NjtenIwtDpHPXR9T+vfFQLe0PGsqzOeuKxPycDHglf2MuzMKsxTFc+crY47i7xxHzwXmQ1fEiUvex1Urs7FB1Kdvyx7i7XpDU9XVjB4amBT1qMpN+dLn9SeOBCYcnMN0GwKGL4qrl/FJnZhUyK0m3yxq2luNYcfeX10o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817898; c=relaxed/simple;
	bh=T0bcV7ndvlkFcGXkP0IW95I+2fEZ4Khe9o1iUDmieMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASwmmakBBmS8iOjkAsVTfMx+o3hKZpRjZUtohfF70L9TXSb4J2e6jRzkLnywOCOd/XbqLrqhz9Jn3uHqQ8hBCb6bPmJjyn++F+DO+jK1HiGHRR5DbztsYmRtxrznhqAjlQT70Z5kt3CQ6WXUc0eaSFueqF3ebg0+ntmBras6XGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fSG+scVS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf848528aso35914345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742817894; x=1743422694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEiHQPlDHFWVDqKplkUnb12Sej7sgBWo60DG3eT9ZwE=;
        b=fSG+scVSBfYoN4wQygj2ZoTa8QwcaWK2tKRdMp5ZPGFWgOJY+h3zj7BQxSnB9qe3DY
         4ZU9D1jRdlDQPsI3UgoiWey+cJ2Xub3zBcHp8JGG6edx/YcoeI1nzzPyAJvy7v5qHiYb
         ilQFCySJQoexTEvbzi6tJiALqgkPIsjQxCBKeO1S0npJCrHHv5R0/+gpBOajDQ3Qabpy
         RL5PSXoYFeI39gFkmOk/BLGvHE0IHyJgDmvZJY2qf2NKWdGYpp59yVn28KOixhPiglPb
         cxGSlU7R8JPXa/oesBZQxFw9Af3WoA56MplNeHJNp+xpI6mom4tYT6leh42XJ8C0ysdi
         ucOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742817894; x=1743422694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEiHQPlDHFWVDqKplkUnb12Sej7sgBWo60DG3eT9ZwE=;
        b=eY/712PE7uHOE0jXcyStXKbun+Q/UKSVOYPQnHA/m5nftcytxZSUMuD+TlSdlRdDBZ
         UBUyqY/tYcxxmp60sXtDY1jrl3WMJ3iLUvfvIxQgPs/ry1T5MHqnnlXGbLQPCvxvDtzp
         GNTTuD7mpORfxuKSS4tNfE+nFszEGpOlG+eUD9SC3ZPkTCX8BmN2ftpQPcak1fdGlJ4y
         DqXTYt4GS2u3e1rpT4DJuK8cjNHsBv0sMcEIiSYPD7Y2Ocz50subO/vLQx2lBJFqt1+i
         6LMkLlLwLtsECYlVyprf8qZ1OY1WUX6GmURKiiO8U/PYgLVQg2vptKmb2qwtqpdP3Ybr
         Eafw==
X-Forwarded-Encrypted: i=1; AJvYcCWk4AoY060AfcrQjYqXhdZXF9OCOxFiMeuLxfZfrdgIm9T2JrwlSdmxNcl4PBb/Ef8HPeeDr/hROVk918o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mTaZA5sSmk6c0ljkNuCJSUus2Kr9tto8MDTRR977UtWFDaeK
	0TSjMTgFCx8AclPr+MKOXi+1jTUZwCs1ZIt6ESFAA6XrxSPJZzSakyKxm7ZCg0Q=
X-Gm-Gg: ASbGncv+N67lVTwI1rjjzfH8HmTFZmBEdDNeHgqsKE4TlqdpEiVvnHl1z6bzozgwRGp
	LBC21mWdFbUUef/KvH+ks/zfrfDowkTarwr+hqkRrGPHBVGQfXBvKev5zO3NTbe7jbf921nj25J
	ArJn29uKxhobSSSPES3K2rIIt/qT8e70HuLFSZ1cV6yn5zZvQx3EXngzBd4UfRWeNB05a0Sa5vk
	hEw9G8XWZ2A7QxTMxJxA1B2jjTMfkXdubAEitwUkylJw5oTWpuwbUwEFPoi+CPWb4qWc1SEKea9
	Xw2EpTXMwaEx98Eoh24HLIqGBzsbtISV79S9+jhUeVzONiV0XfDnA0hIP3yleTQ=
X-Google-Smtp-Source: AGHT+IGviFIkVr8fo+EnJNNSPFp52zemYmg2/j6T6NycMIWANr5ACEdDLzVtzgMzC4WSGSPnCALLKg==
X-Received: by 2002:a05:600c:1548:b0:43c:f78d:82eb with SMTP id 5b1f17b1804b1-43d509f5985mr137326265e9.15.1742817894289;
        Mon, 24 Mar 2025 05:04:54 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9efe61sm10951273f8f.97.2025.03.24.05.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 05:04:53 -0700 (PDT)
Message-ID: <ac58b70a-b53a-4c91-8483-1b870623d5e9@linaro.org>
Date: Mon, 24 Mar 2025 12:04:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, peda@axentia.se,
 broonie@kernel.org, andersson@kernel.org, krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com, luca.ceresoli@bootlin.com,
 zhoubinbin@loongson.cn, paulha@opensource.cirrus.com, lgirdwood@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
 Christopher Obbard <christopher.obbard@linaro.org>
References: <20250324110606.32001-1-srinivas.kandagatla@linaro.org>
 <20250324110606.32001-6-srinivas.kandagatla@linaro.org>
 <7fc622e8-6f9d-4a14-bf5f-3122e6f81808@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <7fc622e8-6f9d-4a14-bf5f-3122e6f81808@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/03/2025 11:20, Dmitry Baryshkov wrote:
> On 24/03/2025 13:06, srinivas.kandagatla@linaro.org wrote:
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
>>   sound/soc/codecs/Kconfig   |  1 +
>>   sound/soc/codecs/wcd938x.c | 38 ++++++++++++++++++++++++++++++--------
>>   2 files changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index ee35f3aa5521..a2829d76e108 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -2226,6 +2226,7 @@ config SND_SOC_WCD938X
>>       tristate
>>       depends on SOUNDWIRE || !SOUNDWIRE
>>       select SND_SOC_WCD_CLASSH
>> +    select MULTIPLEXER
>>   config SND_SOC_WCD938X_SDW
>>       tristate "WCD9380/WCD9385 Codec - SDW"
>> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
>> index dfaa3de31164..948b5f6cc45a 100644
>> --- a/sound/soc/codecs/wcd938x.c
>> +++ b/sound/soc/codecs/wcd938x.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/regmap.h>
>>   #include <sound/soc.h>
>>   #include <sound/soc-dapm.h>
>> +#include <linux/mux/consumer.h>
>>   #include <linux/regulator/consumer.h>
>>   #include "wcd-clsh-v2.h"
>> @@ -178,6 +179,8 @@ struct wcd938x_priv {
>>       int variant;
>>       int reset_gpio;
>>       struct gpio_desc *us_euro_gpio;
>> +    struct mux_control *us_euro_mux;
>> +    u32 mux_state;
>>       u32 micb1_mv;
>>       u32 micb2_mv;
>>       u32 micb3_mv;
>> @@ -3243,9 +3246,16 @@ static bool wcd938x_swap_gnd_mic(struct 
>> snd_soc_component *component)
>>       wcd938x = snd_soc_component_get_drvdata(component);
>> -    value = gpiod_get_value(wcd938x->us_euro_gpio);
>> +    if (!wcd938x->us_euro_mux) {
>> +        value = gpiod_get_value(wcd938x->us_euro_gpio);
>> -    gpiod_set_value(wcd938x->us_euro_gpio, !value);
>> +        gpiod_set_value(wcd938x->us_euro_gpio, !value);
> 
> Is it possible to use mux_state for both GPIO and MUX paths?

Ideally I would like to do that the way that gpio is done, which is 
clear reflection of hw state, however mux f/w is lacking such api.


> 
>> +    } else {
>> +        mux_control_deselect(wcd938x->us_euro_mux);
>> +        wcd938x->mux_state = !wcd938x->mux_state;
>> +        if (mux_control_select(wcd938x->us_euro_mux, 
>> wcd938x->mux_state))
>> +            dev_err(component->dev, "Unable to select us/euro mux 
>> state\n");
> 
> This can lead to mux being deselected next time even if the 
> mux_control_select returned an error. I think mux_control API needs a 
> way to toggle the state without deselecting it first. Anyway, an error 
> from mux_control_select() must prevent you from calling 
> mux_control_deselect() next time.

We can rearrange deselect to be done only on successful select, that 
should cleanup some of this.

--srini
> 
>> +    }
>>       return true;
>>   }
> 
> 

