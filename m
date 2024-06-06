Return-Path: <linux-kernel+bounces-204295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D758FE6DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB42285189
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0404C195B10;
	Thu,  6 Jun 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkiPVXSZ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F07195B13
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678389; cv=none; b=KQf+85ZSk7vzTYE7JEK5mG1cVS1Xl9OH8M248he8ZNIddxf1NLg5HfFBiIdUJ8y/iMR70uAxgLQ0He2Uay9GnJkDkBsucdTE5EWeJwDOdSpfKuzvX2gnJF4vtcjPK8ox8lioy7BmP9MeHPijXekkaLwCN3c3tkFCfDr1UF2FdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678389; c=relaxed/simple;
	bh=wDt1T4iYcHh7xmCRkVMv65w9F3CbVWI0MMHsPQ+qtPY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BywofJEWePNqF75Fud7LORqeJXSQrWLTE3e6hnRUOF6IdppZUh+oAYpfhZyHWUIgvXcaNWlpX+Px55dIt4mpVL6oPFgHjdcz+tWaGYurKEshbUo4zJf74jSzyjXiCzRl1vqpzNb2GbnYfuEg0+mIQs57ysEJ1+gm3t0sZfeEKxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kkiPVXSZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4214fe0067fso10060225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717678386; x=1718283186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbhjQh1kXkYXaZMBQ6kqGmTZtLl7tjoM2ZaoFySB5to=;
        b=kkiPVXSZxZGmL9IejyV1s6LUFVnYqsbi05TP1qbtGPOxvwz9VRrg26W4EaUJfHd32f
         KM/4Blkq16Cf24xTP2xyHDoYkfl+Ul1s9J+wLC/UxXQ9jyoIL+4EgQarAgwh7dOoKtrE
         i1eG8POuIac6f6/GwJbIYZcI8llHH3IZMX0Pv6MsAMEiAOMjkSwxK840KA66RZTVKZ/9
         ASjO9bjI1GxaJNlLk13PMW8JuoQ3IQC+rH0UBkvCIpUdJ+bO+zUmpEGUn4OHm8Vc7NrV
         yEbqiuKtyZuOcA1i2gwJP1zo9sFLMIyrvhJqyUwb7pkiuOAzAVbPGvhTWqkYfrHLH6Sr
         ptDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717678386; x=1718283186;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XbhjQh1kXkYXaZMBQ6kqGmTZtLl7tjoM2ZaoFySB5to=;
        b=CGBHeKBgMFFDAdLwAaydi4TSQhH2RYt4NNiXjTVq3Lqjkxnw9MNth/6E0YoJ+1XN1o
         8VoYrHPjiBokq20sC/x6bB3/7i5MxkJ+/P2da6fdi+9TJ2wLibypaWL9jxelpHrNOGXf
         jueB5wKrXm30fk8FBeKDGJ8SHxDS9z3EgniMiNX4xnj7tFqs3WJpIgZUvAfuSjv+oaD/
         8NUVW+bpMnkAu+S3Ur8y5zQfGcm71IU6TakofsuBbhCDsCNpOXk1KfY98aylDWFAVHND
         DlfHWLn5uR9kq4+H7Kz13IKANFWSBImxABlvCpiui0TOtYZHdYM+RYvLmK2lomGABy3+
         5yNg==
X-Forwarded-Encrypted: i=1; AJvYcCWEqMOAXXsE1Y2VWMCrMu5r3DAYWjKYOb0UrGvcWlLLsdAptFhXPTRBOKeEKY9xh6zPLsW7vTXmjH967U9jqOS/xo9JUfUoYFEGzbmS
X-Gm-Message-State: AOJu0YyHIGvAmAXaa/Kd1nHfOG9SIA/04GvmlXxcP5l6lAGHIp1KAjAF
	fovDZV+pDGa+AiJxPW7XtyMeggk2KQFV2/tBXff92OJ2feyFKUfb2s6HCynhtbc=
X-Google-Smtp-Source: AGHT+IHPZ9gVu9ORbE2PBwa+D3PLXsVXUo7nY7W1M7K5HKkbTKSbE1MsF/bG67tE9aVapyya+yWK2w==
X-Received: by 2002:adf:eec9:0:b0:35e:efda:6b5f with SMTP id ffacd0b85a97d-35eefda6db9mr2531709f8f.13.1717678385694;
        Thu, 06 Jun 2024 05:53:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6d66:dc6b:6c6b:f7aa? ([2a01:e0a:982:cbb0:6d66:dc6b:6c6b:f7aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d66d0esm1478907f8f.51.2024.06.06.05.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 05:53:05 -0700 (PDT)
Message-ID: <5fcfa552-7b1e-4329-8ffa-dbe7cf34695a@linaro.org>
Date: Thu, 6 Jun 2024 14:53:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] usb: typec-mux: ptn36502: broadcast typec state to
 next mux
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss
 <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240527-topic-sm8x50-upstream-retimer-broadcast-mode-v1-0-79ec91381aba@linaro.org>
 <20240527-topic-sm8x50-upstream-retimer-broadcast-mode-v1-1-79ec91381aba@linaro.org>
 <llt5o2btdlz5ckvhd3a73kxxkrm544wi3b2xhnytwg62ekcm3l@ck6wqglx35d6>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <llt5o2btdlz5ckvhd3a73kxxkrm544wi3b2xhnytwg62ekcm3l@ck6wqglx35d6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/05/2024 11:16, Dmitry Baryshkov wrote:
> On Mon, May 27, 2024 at 09:45:29AM +0200, Neil Armstrong wrote:
>> In the Type-C graph, the ptn36502 retimer is in between the USB-C
>> connector and the USB3/DP combo PHY, and this PHY also requires the
>> USB-C mode events to properly set-up the SuperSpeed Lanes functions
>> to setup USB3-only, USB3 + DP Altmode or DP Altmode only on the 4 lanes.
>>
>> Update the ptn36502 retimer to get an optional type-c mux on the next
>> endpoint, and broadcast the received mode to it.
>>
>> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> --
>>
>> Reported Tested by Luca in [1]
>>
>> [1] https://lore.kernel.org/all/D1HOCBW6RG72.1B2RKGKW2Q5VC@fairphone.com/
>> ---
>>   drivers/usb/typec/mux/ptn36502.c | 33 ++++++++++++++++++++++++++++++---
>>   1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/typec/mux/ptn36502.c b/drivers/usb/typec/mux/ptn36502.c
>> index 0ec86ef32a87..129d9d24b932 100644
>> --- a/drivers/usb/typec/mux/ptn36502.c
>> +++ b/drivers/usb/typec/mux/ptn36502.c
>> @@ -67,6 +67,7 @@ struct ptn36502 {
>>   	struct typec_retimer *retimer;
>>   
>>   	struct typec_switch *typec_switch;
>> +	struct typec_mux *typec_mux;
>>   
>>   	struct mutex lock; /* protect non-concurrent retimer & switch */
>>   
>> @@ -235,6 +236,7 @@ static int ptn36502_sw_set(struct typec_switch_dev *sw, enum typec_orientation o
>>   static int ptn36502_retimer_set(struct typec_retimer *retimer, struct typec_retimer_state *state)
>>   {
>>   	struct ptn36502 *ptn = typec_retimer_get_drvdata(retimer);
>> +	struct typec_mux_state mux_state;
>>   	int ret = 0;
>>   
>>   	mutex_lock(&ptn->lock);
>> @@ -252,7 +254,14 @@ static int ptn36502_retimer_set(struct typec_retimer *retimer, struct typec_reti
>>   
>>   	mutex_unlock(&ptn->lock);
>>   
>> -	return ret;
>> +	if (ret)
>> +		return ret;
>> +
>> +	mux_state.alt = state->alt;
>> +	mux_state.data = state->data;
>> +	mux_state.mode = state->mode;
>> +
>> +	return typec_mux_set(ptn->typec_mux, &mux_state);
>>   }
>>   
>>   static int ptn36502_detect(struct ptn36502 *ptn)
>> @@ -321,9 +330,18 @@ static int ptn36502_probe(struct i2c_client *client)
>>   		return dev_err_probe(dev, PTR_ERR(ptn->typec_switch),
>>   				     "Failed to acquire orientation-switch\n");
>>   
>> +	ptn->typec_mux = fwnode_typec_mux_get(dev->fwnode);
>> +	if (IS_ERR(ptn->typec_mux)) {
>> +		ret = dev_err_probe(dev, PTR_ERR(ptn->typec_mux),
>> +				    "Failed to acquire mode-switch\n");
>> +		goto err_switch_put;
>> +	}
>> +
>>   	ret = regulator_enable(ptn->vdd18_supply);
>> -	if (ret)
>> -		return dev_err_probe(dev, ret, "Failed to enable vdd18\n");
>> +	if (ret) {
>> +		ret = dev_err_probe(dev, ret, "Failed to enable vdd18\n");
>> +		goto err_mux_put;
>> +	}
>>   
>>   	ret = ptn36502_detect(ptn);
>>   	if (ret)
>> @@ -363,6 +381,12 @@ static int ptn36502_probe(struct i2c_client *client)
>>   err_disable_regulator:
>>   	regulator_disable(ptn->vdd18_supply);
>>   
>> +err_mux_put:
>> +	typec_mux_put(ptn->typec_mux);
>> +
>> +err_switch_put:
>> +	typec_switch_put(ptn->typec_switch);
> 
> Please split typec_switch_put() to a separate patch, it's a fix.

I was lazy, I'll do that,

Thanks

> 
>> +
>>   	return ret;
>>   }
>>   
>> @@ -374,6 +398,9 @@ static void ptn36502_remove(struct i2c_client *client)
>>   	typec_switch_unregister(ptn->sw);
>>   
>>   	regulator_disable(ptn->vdd18_supply);
>> +
>> +	typec_mux_put(ptn->typec_mux);
>> +	typec_switch_put(ptn->typec_switch);
>>   }
>>   
>>   static const struct i2c_device_id ptn36502_table[] = {
>>
>> -- 
>> 2.34.1
>>
> 


