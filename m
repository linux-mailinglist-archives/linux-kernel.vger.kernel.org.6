Return-Path: <linux-kernel+bounces-292584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9373D957179
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA13D1C22D87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A2B189BA1;
	Mon, 19 Aug 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="my8Aiq/p"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8B17B4ED
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087019; cv=none; b=XDTAErh/NMDnD3TCDUVHIGgyJTexYy07q6PKZ7bwpQQ1Xuykej7sc8SrWmeh6CdXJT9oiFiNXgHkn83/Wv+vEOW5gceV0i/fSijl9mlkVY1Vd5ExIhfPB8PoMJfBU5PZr+wbLrmyZr+elYzX9OWBBzcn+Y+QpDE2Cf+Ze/2PZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087019; c=relaxed/simple;
	bh=Vs8vBqOi5Csp7El794yWugtNdnWLHm37oVAojuSdt78=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pZhcz9On/dLg4UHABO5Ne8bCEjhJmM60puZYxGJSnZebXQT9ZF/nPxn9PKRvGZ4DsxVELnSFNSiasy+7iF2gdPoatFuTWX60mLN0TcPVHl6/8YrAIUONy/2I1Bg3b/mwHHiqnlw6+cmvoJ0iJ3y5di4okHAukvvJibkkrAp7Fec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=my8Aiq/p; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-371b015572cso1738426f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724087016; x=1724691816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnDFSTAKv2CbUB/GFxo8WQKI+dvEV3GJoZctb6HdaJg=;
        b=my8Aiq/pxPKHeIfzKvAd6kvC5qhWqY30BsmUuoDcIhIc+V4i7nYtcC32LBUOJUVXyj
         MxMA+3JUOwPU3DWDYxVsv1UFsHJWsp5dhF+bYq4pY8S7JlfNkZ5ESLTKdb2+YTtvjDXX
         zHMFmCRBRmEmQUoscMCKSZYcP4IhBhOr7sFZkwIiaSXyCNWBHRjS2kzH6fygsoUQsZXt
         7MnwQPI6TY8w8VN/xNbJuqeppetLWwSwkYM/Wn7hymXKj9i1ZOi+iyUdKGaTwEMIlWf4
         zgFG5KtM22XjHOueglhhygouvfASL+jsAjIVVfy4ikFcTUguHd5ZwhzNdgocV54nwrlp
         /NwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087016; x=1724691816;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fnDFSTAKv2CbUB/GFxo8WQKI+dvEV3GJoZctb6HdaJg=;
        b=UndzGqqZbMPbZjt8gaHtqzWN75+MrVA1VEo37QR9XApOywCWlRYGzv61CkYyaVsdOJ
         xekhBQLfLIDP6PnY/++P3JwjBgIxzTK2mu6UAgxovjpKSgUv7eSNluoxhcHuP3OIrARl
         VfSiHuLI7ie7FtgJonRRKHADKwpJlf/TsXXFXw9VIO+p+oOimq+SMJLPlTAAY4qLXz/V
         3LaTZ7+r5Pu/Kd1iTpFndVBVD/FRVQ6k3dHMOq9N7vRUPS4RPcSnReiDHJ04gNoHK1J3
         tmfhgeqTw+Pl8h1aE9uYta8R2b829rycBVNkBlq4LU0vvEgC+gBmIhJwv/st1/NhFKXP
         LqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz4tqCf76zdD8nbM6UVMsXZ96gwCBSeMBv9k6cDhtIcY/93J3LLakEaW+uIhCuRXQa3o0Zv0ps0WzOJlOgqdVnE0zAqp1FBRt2boz9
X-Gm-Message-State: AOJu0YyWKrVGEt5T6ccukGx4+Or+ZHwnPKdW9gxNe3FIJZWsxgPlufbb
	7Izjgdd49wnRozRzxYyzzazhv8srd3sauoCTatwhpYb94x22BxHmLn4W0WBMHuEAZBTdh7P5GUT
	c
X-Google-Smtp-Source: AGHT+IGQ5kx82xhxsw7wqB/29WGVSG0vwg+ZmcFDHp0t1PUqrHJXqfXV9Jrt9OgVCooQy8mfz0TeRQ==
X-Received: by 2002:a05:6000:ec4:b0:371:844f:e07 with SMTP id ffacd0b85a97d-37194315732mr9821639f8f.10.1724087015346;
        Mon, 19 Aug 2024 10:03:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849697sm10964887f8f.37.2024.08.19.10.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:03:34 -0700 (PDT)
Message-ID: <35e56911-a99b-4818-8b31-78baa680f8fe@linaro.org>
Date: Mon, 19 Aug 2024 19:03:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/9] reset: amlogic: add driver parameters
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
 <20240808102742.4095904-5-jbrunet@baylibre.com>
 <614de1b0-fcaf-457c-9183-1f3cd7f91b38@linaro.org>
 <1jzfp8wjod.fsf@starbuckisacylon.baylibre.com>
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
In-Reply-To: <1jzfp8wjod.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2024 18:40, Jerome Brunet wrote:
> On Mon 19 Aug 2024 at 17:57, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>>> +	assert ^= data->param->level_low_reset;
>>>      	return regmap_update_bits(data->map, offset,
>>> -				  BIT(bit), assert ? 0 : BIT(bit));
>>> +				  BIT(bit), assert ? BIT(bit) : 0);
>>>    }
>>>      static int meson_reset_assert(struct reset_controller_dev *rcdev,
>>> @@ -84,17 +88,23 @@ static const struct reset_control_ops meson_reset_ops = {
>>>      static const struct meson_reset_param meson8b_param = {
>>>    	.reg_count	= 8,
>>> +	.reset_offset	= 0x0,
>>>    	.level_offset	= 0x7c,
>>> +	.level_low_reset = true,
>>>    };
>>>      static const struct meson_reset_param meson_a1_param = {
>>>    	.reg_count	= 3,
>>> +	.reset_offset	= 0x0,
>>>    	.level_offset	= 0x40,
>>> +	.level_low_reset = true,
>>>    };
>>>      static const struct meson_reset_param meson_s4_param = {
>>>    	.reg_count	= 6,
>>> +	.reset_offset	= 0x0,
>>>    	.level_offset	= 0x40,
>>> +	.level_low_reset = true,
>>
>> Just a comment, I would rather leave the "default" users of this driver with the default value
>> and use level_high_reset = true for the clock ones
> 
> In every other place in the kernel, we specify that kind of thing if it
> is acitve low. Your request make things up-side-down and harder to
> follow IMO.
> 
> There is no 'default' user, there is the platform ones and auxiliary ones.
> Platform ones tend to active low reset line. It is clearly shown above
> and hard to miss when adding new platforms.

It's only a suggestion, we tend to not add `= true` to existing users and keep
the new boolean properties for the new users, whatever the logic, and since
the driver originally did set the reset as low lever by default, it makes sense
use level_high_reset whatever other drivers does.

> 
>>
>> Neil
>>
>>>    };
>>>      static const struct of_device_id meson_reset_dt_ids[] = {
> 


