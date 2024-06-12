Return-Path: <linux-kernel+bounces-211982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2E39059A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFCF285332
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991A21822EB;
	Wed, 12 Jun 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBe9LANT"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57F1822CE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212186; cv=none; b=NMbOTVh1eg1k6eq+fJgc1ErbuUs1jUzKiHhYkvHIK8Ay0vcndefh1CYtYkWMu3c7hzd72nQtq4YNeU2Jmh4IH2xlq5TjL4/f/0jSGVxpaGEawR7tccgdhaiSYqeVUZnoSlP8jduyEdbzGwgK/Mguj8ofDb4GK+BALsrkJqr2o4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212186; c=relaxed/simple;
	bh=APRCpEbcPVzVX5FRd/J5uFNU7G8xET1wqhsXQzfeSxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7NPt4XWpXXNXDeoC09flRllk038s6ESdrdbI7ob24nOWwtWkC3+R20bOApyuFUSe85aksxZ4LeY59mHncQWLdzO7s7/nu80EUOnAKeh7o+M7jehv9qn+o7+xo0sNSeFjMFjgqUxufPGoQqIiYmawjCtV8wWCoQXG3PmoIDUbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TBe9LANT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6efacd25ecso8003166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718212183; x=1718816983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahQlEzrfJdhiFn9OIYrhMiyVBnesYeffSvKfXGQvn6E=;
        b=TBe9LANTBC6jTr31Gequ7sBCctMsoxXwpCNZfv3+bD9Aio1j+y4b/w+f2i/0LPxT4H
         J0OOye5IgDtoKCc1Bor1nmQpvNyZcgXpdaXO+mZXlDFotxZE8d8fSdbHHry5Dcmvkzmb
         GwISdAVmWsxo764J0i8BfJYRgdDUow+ycmAGyuPIFvO3DkTpy6Asl8uyCQtyp2AQmV3o
         oIAZAOaM09rYSDAt7os7wVvl1/EHObF/jgipnofvr2TnkL22mRgmOpnC9Xpj2ZDN6BAA
         Gi1FNGKlvaDETyC4E3AXLWWSuHqUnMFh+pSFsQQ7xin9YDrd0h/rCVgw+7HYblELxb7j
         SKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718212183; x=1718816983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahQlEzrfJdhiFn9OIYrhMiyVBnesYeffSvKfXGQvn6E=;
        b=K9UlTxxyt59dROyMv4zgwBlqoH1lAhu7y8B5HagxEDmcDgcFpwU1w2fU4npdBEWGMo
         t4KONK7jAU+NOx23j8+XiTLXLPplKbzZtjIa7PGz+r29gJA8j4VqzMCEB5Rl4IuflMei
         sbjKlzlzKn212YKfiELCOHIqVMXVBin67kd1f7OitXN0z7qC8IU4TnJdIi8ONutCaDOS
         ZVQz39IMrEzOKiFWcHj8A+1/eO9n0sQPJcgqI02YSkON4OqCm9HKfDugbcjOgUZbfIpp
         nyiELm+mP3GAIzB2IJ6xgEWxgaPwoJSTYSW2W6xeorfo+Pgt1ROdQncaL9p48PbT6oqv
         SeAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcjuxw1NnAR1zdhxroGPG+BWSpEz40xvDDINHoMXLkBCV0oMXS1ixmMCfshCqQNmBPwTmJg/bS1pAzQql96oD17AfgNE4gjatNu6BC
X-Gm-Message-State: AOJu0YwFI3e3wrj4LKJBqYTfn2D52bdrdNvB9x8RMSj1vh/EB9T7TXIY
	zN2kxdxNnkKMUHWUSyCsyUE2RgL1Q/M2gvrj57ERqgpIfruVD8WD7/QGjwzA6Ns=
X-Google-Smtp-Source: AGHT+IGjbcYcIlqz5xpwvHlCgTeNzmT7XcU2BZbyl54Q86rVmVK+MD5/8wFrHjsg4H01yc1UrsqH2g==
X-Received: by 2002:a50:cd1b:0:b0:56e:3293:3777 with SMTP id 4fb4d7f45d1cf-57caaabd1f3mr1875774a12.17.1718212182970;
        Wed, 12 Jun 2024 10:09:42 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cae50adc2sm824764a12.75.2024.06.12.10.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 10:09:42 -0700 (PDT)
Message-ID: <171afc10-b69b-4c76-be34-7e93ec03355c@linaro.org>
Date: Wed, 12 Jun 2024 18:09:41 +0100
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
 <5bf5ee5e-d24f-476f-9500-9d1b7adcfc72@linaro.org>
 <mpm4pmt5ieofmpxmq5putvytyuiepbmnv5flsfqiwbtc54sb6k@jpoeaeojzzis>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <mpm4pmt5ieofmpxmq5putvytyuiepbmnv5flsfqiwbtc54sb6k@jpoeaeojzzis>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2024 17:52, Dmitry Baryshkov wrote:
> On Wed, Jun 12, 2024 at 03:37:56PM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 07/06/2024 12:03, Dmitry Baryshkov wrote:
>>> On Thu, Jun 06, 2024 at 01:25:59PM +0100, srinivas.kandagatla@linaro.org wrote:
>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>
>>>> LPASS Codec v2.5 has significant changes in the rx register offsets.
>>>> Due to this headset playback on SM8550, SM8650, x1e80100 and all SoCs
>>>> after SM8450 have only Left working.
>>>>
>>>> This patch adjusts the registers to accomdate 2.5 changes. With this
>>>> fixed now L and R are functional on Headset playback.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>    sound/soc/codecs/lpass-rx-macro.c | 565 ++++++++++++++++++++++--------
>>>>    1 file changed, 410 insertions(+), 155 deletions(-)
>>>>
>>>> diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
>>>> index f35187d69cac..bb8ede0e7076 100644
>>>> --- a/sound/soc/codecs/lpass-rx-macro.c
>>>> +++ b/sound/soc/codecs/lpass-rx-macro.c
>>>>    static int rx_macro_probe(struct platform_device *pdev)
>>>>    {
>>>> +	struct reg_default *reg_defaults;
>>>>    	struct device *dev = &pdev->dev;
>>>>    	kernel_ulong_t flags;
>>>>    	struct rx_macro *rx;
>>>>    	void __iomem *base;
>>>> -	int ret;
>>>> +	int ret, def_count;
>>>>    	flags = (kernel_ulong_t)device_get_match_data(dev);
>>>> @@ -3567,6 +3793,33 @@ static int rx_macro_probe(struct platform_device *pdev)
>>>>    		goto err;
>>>>    	}
>>>> +	rx->codec_version = lpass_macro_get_codec_version();
>>>
>>> What guarantees that VA macro has been probed already? If I'm not
>>> mistaken, we might easily get a default '0' here instead of a correct
>>> version.
>>
>> fsgen(Frame sync gen) clk is derived from VA macro, so if we are here that
>> means the va macro is probed.
> 
> Is this written in stone or is it just a current way how these codecs
> are connected?

LPASS Codec IP which encompasses 5 other codec macros blocks (wsa, wsa2, 
tx, rx, va) all the codec macros receive framesync from VA codec block, 
this is the hw design.

Not sure what do you mean by written in stone, but this is LPASS Codec 
design, at-least to the codec versions that this driver supports.

> 
>>>> +	switch (rx->codec_version) {
>>>> +	case LPASS_CODEC_VERSION_2_5 ... LPASS_CODEC_VERSION_2_8:
>>>> +		rx->rxn_reg_offset = 0xc0;
>>>> +		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_2_5_defaults);
>>>> +		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
>>>> +		if (!reg_defaults)
>>>> +			return -ENOMEM;
>>>> +		memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
>>>> +		memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
>>>> +				rx_2_5_defaults, sizeof(rx_2_5_defaults));
>>>> +		break;
>>>> +	default:
>>>> +		rx->rxn_reg_offset = 0x80;
>>>> +		def_count = ARRAY_SIZE(rx_defaults) + ARRAY_SIZE(rx_pre_2_5_defaults);
>>>> +		reg_defaults = kmalloc_array(def_count, sizeof(struct reg_default), GFP_KERNEL);
>>>> +		if (!reg_defaults)
>>>> +			return -ENOMEM;
>>>> +		memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
>>>> +		memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
>>>> +				rx_pre_2_5_defaults, sizeof(rx_pre_2_5_defaults));
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	rx_regmap_config.reg_defaults = reg_defaults,
>>>> +	rx_regmap_config.num_reg_defaults = def_count;
>>>> +
>>>>    	rx->regmap = devm_regmap_init_mmio(dev, base, &rx_regmap_config);
>>>>    	if (IS_ERR(rx->regmap)) {
>>>>    		ret = PTR_ERR(rx->regmap);
>>>> @@ -3629,6 +3882,7 @@ static int rx_macro_probe(struct platform_device *pdev)
>>>>    	if (ret)
>>>>    		goto err_clkout;
>>>> +	kfree(reg_defaults);
>>>>    	return 0;
>>>>    err_clkout:
>>>> @@ -3642,6 +3896,7 @@ static int rx_macro_probe(struct platform_device *pdev)
>>>>    err_dcodec:
>>>>    	clk_disable_unprepare(rx->macro);
>>>>    err:
>>>> +	kfree(reg_defaults);
>>>>    	lpass_macro_pds_exit(rx->pds);
>>>>    	return ret;
>>>> -- 
>>>> 2.21.0
>>>>
>>>
> 

