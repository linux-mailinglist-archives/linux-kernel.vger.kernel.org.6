Return-Path: <linux-kernel+bounces-211682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72154905550
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94D91F23E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3F317E475;
	Wed, 12 Jun 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olJM5ahl"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C30169ACA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203081; cv=none; b=fudA8Kba2Ji8xAOHWvsgXNtz2NlZSWpRoQSPj5E7g91W7jzjJeL4nJWUGwavCR7RADj6tsNftUZd+iASEmjfoSMlUc8ll3rgrxWlDKteaEq1I4Zzp9EyGnj736gQx2OJnYmUZbbxsU5KY0BaNc4wyfAwLl9haZ8U7w48XH0yK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203081; c=relaxed/simple;
	bh=CTYOhhQlTsoO4oIyaYO/EgA0AeZ/eZ/nx2RqqUkiaGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fijtL8Yza50BQN9GjNjlfvR7/mnBZaF6bmgnSDYRQmOpFb4NKLTi1hiYuoxP0EqEDpqRm6QvrShNHEOFrM00kCMniBDtN7iFICbKLXLIYoFFXh0GDZ9LCYHLUf7iuCjSRfEq3T33OK+A1yVYIthYIjq5b7sT+C9CFeHtIXmihAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=olJM5ahl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f1da33826so317337366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718203078; x=1718807878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fjaZfrJZ3QIeFP/iVn+xJccYn+xXruLly+6B31t6tg=;
        b=olJM5ahlzzR1wF810pHdppeEQ5Di8CoM5gBKr34HFMlDgVxL7uWY66ZI789h/qcSof
         GNfgwgBMz1eL7M4xK/FSRRHCfsbIIexPz9yXfHFOxQwrjwktpH0BbpPR4gs5yK0Hyn16
         FhhfJtQjpCrfqmfGnlUGpP5tdSNmuUSYWVAAUEg7lNe3+7QYxvJcm90j5X2n1A2WTMpc
         aMuRxJ+6KOhdlYQGCAJ11S+uzmz2tjiUW6OkOWnjSztPTdQc3ta2lcU2wXTygaUCwgbg
         AIhaPFHwvQdQUMHR8ABhJ2Aurm3WcXi1611yANurk1zNONeUGcyykeQ5ecVqJQScUSFK
         nxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203078; x=1718807878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fjaZfrJZ3QIeFP/iVn+xJccYn+xXruLly+6B31t6tg=;
        b=BanY9h2kKZsqjDaSitKM6JYC96LA2zfhaffbNg24AarphBttq6tGU0T1xdFLLnpSjq
         4AoCcGpUPcUWjuLyAy7xvcR8yHX4hodF+DWkuqbZNRDu7IHU8gLjCh/y30XK0EqQd3GZ
         eHAEHuVdxF56ilyOLhCn/VutXmnC2uj83yBxcHentRY4SgVUrDB8u78q8A1hIm2xJ+F6
         HzwBoNpXp8tsB137vxO48TrC1w+KrW7DU7+iSuw9qUJ3E31nIuiIAeK7KiY+E/nNf8m5
         wj/sxv8DhHMOkPZ50cbKM7VZ5eJKQ9Q8KDNZRfvElvH0TFWirGiu/AARdqBHtE/6WKky
         /Chw==
X-Forwarded-Encrypted: i=1; AJvYcCUwuAEKU9bllO3h7Bqxv6Adt63Yi19D+wtT2uRsBsXFrqQz8MT+7HwrrsyHAMCv17Md9HY/diPauLlOBN6vU6k9R4MS/E+ccAChYr3h
X-Gm-Message-State: AOJu0YwOWBhqj5PzMc4RsXrmtEIL6Hb82dcz4Sn4rAKWbr0i0pUbUEWX
	vyO5cZ4zA2qSdnXKL+YYZi+ioGFwSe/X8lyBXvgUgWiFirzZyzH9kI582to2NeI=
X-Google-Smtp-Source: AGHT+IFaoHUQSMxx6j+MTMcufV4ec8ectABjdUjrL9TYkcI9tXI2C/BHxmQlOwnr29Szys5kmNlntw==
X-Received: by 2002:a17:906:c9c7:b0:a6e:139b:996d with SMTP id a640c23a62f3a-a6f47f5a03emr169143166b.32.1718203077766;
        Wed, 12 Jun 2024 07:37:57 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6f34591542sm248835366b.55.2024.06.12.07.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:37:57 -0700 (PDT)
Message-ID: <5bf5ee5e-d24f-476f-9500-9d1b7adcfc72@linaro.org>
Date: Wed, 12 Jun 2024 15:37:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ASoC: codec: lpass-rx-macro: add suppor for 2.5
 codec version
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: broonie@kernel.org, perex@perex.cz, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org,
 neil.armstrong@linaro.org, krzysztof.kozlowski@linaro.org
References: <20240606122559.116698-1-srinivas.kandagatla@linaro.org>
 <20240606122559.116698-3-srinivas.kandagatla@linaro.org>
 <qjyuvejxvjfanhqi3xpgobqjuugh52okxiutdprprx43emee7t@gzh7go6yc77z>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <qjyuvejxvjfanhqi3xpgobqjuugh52okxiutdprprx43emee7t@gzh7go6yc77z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/06/2024 12:03, Dmitry Baryshkov wrote:
> On Thu, Jun 06, 2024 at 01:25:59PM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> LPASS Codec v2.5 has significant changes in the rx register offsets.
>> Due to this headset playback on SM8550, SM8650, x1e80100 and all SoCs
>> after SM8450 have only Left working.
>>
>> This patch adjusts the registers to accomdate 2.5 changes. With this
>> fixed now L and R are functional on Headset playback.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/codecs/lpass-rx-macro.c | 565 ++++++++++++++++++++++--------
>>   1 file changed, 410 insertions(+), 155 deletions(-)
>>
>> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
>> index f35187d69cac..bb8ede0e7076 100644
>> --- a/sound/soc/codecs/lpass-rx-macro.c
>> +++ b/sound/soc/codecs/lpass-rx-macro.c
>>   
>>   static int rx_macro_probe(struct platform_device *pdev)
>>   {
>> +	struct reg_default *reg_defaults;
>>   	struct device *dev = &pdev->dev;
>>   	kernel_ulong_t flags;
>>   	struct rx_macro *rx;
>>   	void __iomem *base;
>> -	int ret;
>> +	int ret, def_count;
>>   
>>   	flags = (kernel_ulong_t)device_get_match_data(dev);
>>   
>> @@ -3567,6 +3793,33 @@ static int rx_macro_probe(struct platform_device *pdev)
>>   		goto err;
>>   	}
>>   
>> +	rx->codec_version = lpass_macro_get_codec_version();
> 
> What guarantees that VA macro has been probed already? If I'm not
> mistaken, we might easily get a default '0' here instead of a correct
> version.

fsgen(Frame sync gen) clk is derived from VA macro, so if we are here 
that means the va macro is probed.

> 
>> +	switch (rx->codec_version) {
>> +	case LPASS_CODEC_VERSION_2_5 ... LPASS_CODEC_VERSION_2_8:
>> +		rx->rxn_reg_offset = 0xc0;
>> +		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_2_5_defaults);
>> +		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
>> +		if (!reg_defaults)
>> +			return -ENOMEM;
>> +		memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
>> +		memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
>> +				rx_2_5_defaults, sizeof(rx_2_5_defaults));
>> +		break;
>> +	default:
>> +		rx->rxn_reg_offset = 0x80;
>> +		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_pre_2_5_defaults);
>> +		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
>> +		if (!reg_defaults)
>> +			return -ENOMEM;
>> +		memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
>> +		memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
>> +				rx_pre_2_5_defaults, sizeof(rx_pre_2_5_defaults));
>> +		break;
>> +	}
>> +
>> +	rx_regmap_config.reg_defaults = reg_defaults,
>> +	rx_regmap_config.num_reg_defaults = def_count;
>> +
>>   	rx->regmap = devm_regmap_init_mmio(dev, base, &rx_regmap_config);
>>   	if (IS_ERR(rx->regmap)) {
>>   		ret = PTR_ERR(rx->regmap);
>> @@ -3629,6 +3882,7 @@ static int rx_macro_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto err_clkout;
>>   
>> +	kfree(reg_defaults);
>>   	return 0;
>>   
>>   err_clkout:
>> @@ -3642,6 +3896,7 @@ static int rx_macro_probe(struct platform_device *pdev)
>>   err_dcodec:
>>   	clk_disable_unprepare(rx->macro);
>>   err:
>> +	kfree(reg_defaults);
>>   	lpass_macro_pds_exit(rx->pds);
>>   
>>   	return ret;
>> -- 
>> 2.21.0
>>
> 

