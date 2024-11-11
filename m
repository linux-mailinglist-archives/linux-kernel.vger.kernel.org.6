Return-Path: <linux-kernel+bounces-404766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF519C47D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908811F22094
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B3A1B3B28;
	Mon, 11 Nov 2024 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jutLyyHu"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B4019F46D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359705; cv=none; b=li4HQeg2YaJqAUReLlBSyYPkepbh117uaGoA31zyuYAZstiuWXPjaaIKj7ycZP6GhvEMAhse+G8e0aBVbl07m4o5+PxlUX4fNkQxQBNejrjD+swGKm3+k8taCrA83LfkxUmpBWi2sPjoeh8Dmk1ZFcMg9ah+s49dbnynG9yYu20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359705; c=relaxed/simple;
	bh=UEUEi0g5baFKPd/yPrSTFO2qUqenSovbQvK2ijrjRVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INQJgSegQaxj8shWDx0zD6v21q7tcXCvoHmJRRrII/3GNZXpRzZzNnQtKGmhJI/bb3kfx57uoAjpR9lcoATtsEWNj6fa7W8hmvdEHs+hqbFavJUUEIV65T8FE1I8OSt2eUlM5wl0PiDysJFUrWurBLXtzqd7itpv1NzHw1+s6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jutLyyHu; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ebc52deca0so2492956eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731359701; x=1731964501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKvPigbrA0Z/Q/kUzViZAw8L2iJnfB5YOIybKqYcsY8=;
        b=jutLyyHuY7Z8mo0iZ+cQZP9vQugjxBCpFj+qo+EVUrLaFP3zIhc+UswzEbtL7vvG/J
         jI4S9wssX0HdUtrZPrga/IuABGh17HJ4taBpNSpZjlK+CXPB1yPlxtP40h6aaQtcILul
         EITo0i/FbB/IiQ/uQHKXWCwTz5OzIl1gNfCxXTlKauRvhdxRN76j7v3LNfbFGMB23rI/
         ZV2YwYtjA8b3tsva9o4/NgdvTs4q+aQApvR3V4pFHbTUfiEJrtyqEJ+IJKoZ4gHWyoFQ
         mwdamYv1MZOd6hMfHHt6iR6JZAWMqSuwfr+Y8jivPfeaFK8xYvXFbgTW2J0ezc9Rh2wB
         JrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731359701; x=1731964501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKvPigbrA0Z/Q/kUzViZAw8L2iJnfB5YOIybKqYcsY8=;
        b=hUJh26Dev89/VS2aM5PlDKXSaET8hX299n8MB4ey+nqUtjeSeqtBv3zwTaQ8bYRBQf
         EH7N79XcIRMHzNQbneWKfVVec/S0oHfF3ae0/sEPGDun8tiAw5Ev2H1Z65UcBLXJsJPJ
         NCjcQCzs6+7IK4d7hjsaLKNnBdFjc79Szgw5aX5JkE0241PP/k1Q8dk/UXJaLsKAhgec
         y1DudSHYnO2m+OjanJpfyQni6qv2qA1S3GxysVKtVGNiWlt+Ce7j6Y+vv5vMEAPqj6V/
         R+5NrosTmlFHgXCHkrWvPclrIuHTuyxNeZajgmBIEGCL5vib6Oh7GG+3Np1QR+fFGdRR
         WreQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIHIrK7n+VyK9kq94xyor30tND0yg6hGYrB3toWKT6i/Ru3QA2AdCRGER4RrluuYWTHA23P8ncBZpMhvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL4Qb4765IdgMYSJo0MhiaESPLpthEXhmlwsXL4mXs2sm4hj53
	0JhGTd01KYFzn+64jLHppZbH9GkHPjh1LGUiF6l9m0R1WgAF0DzanoqHJmmGEpo=
X-Google-Smtp-Source: AGHT+IGnDhH00NIUNGxRkfa8oULGq+weqFX/R55G+H4lngweXnOIQ7C2jE6iYgJfdqCvn2ECiusFDA==
X-Received: by 2002:a05:6820:1f08:b0:5eb:d1ac:21c4 with SMTP id 006d021491bc7-5ee57d2887amr9655428eaf.8.1731359700898;
        Mon, 11 Nov 2024 13:15:00 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee494fb095sm2064551eaf.6.2024.11.11.13.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 13:14:59 -0800 (PST)
Message-ID: <b2f6db15-51a8-498d-ab5b-52f0f6a2e098@baylibre.com>
Date: Mon, 11 Nov 2024 15:14:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: trigger: stm32-timer-trigger: Add check for
 clk_enable()
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com,
 tgamblin@baylibre.com, fabrice.gasnier@st.com, benjamin.gaignard@linaro.org,
 lee@kernel.org, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241111191934.17231-1-jiashengjiangcool@gmail.com>
 <8505aa28-5f88-4fcd-b3bc-cb5db89d2a08@baylibre.com>
 <CANeGvZVE6fX5hV-p1xXsGR=Z=pABzDtvV9wY_XBbLwJUWNVtyQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CANeGvZVE6fX5hV-p1xXsGR=Z=pABzDtvV9wY_XBbLwJUWNVtyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/24 2:36 PM, Jiasheng Jiang wrote:
> On Mon, Nov 11, 2024 at 2:45 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 11/11/24 1:19 PM, Jiasheng Jiang wrote:
>>> Add check for the return value of clk_enable() in order to catch the
>>> potential exception.
>>>
>>> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>>> ---
>>> Changelog:
>>>
>>> v2 -> v3:
>>>
>>> 1. Simplify code with cleanup helpers.
>>>
>>> v1 -> v2:
>>>
>>> 1. Remove unsuitable dev_err_probe().
>>> ---
>>
>> ...
>>
>>> @@ -492,21 +495,25 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>>>               return -EINVAL;
>>>
>>>       case IIO_CHAN_INFO_ENABLE:
>>> -             mutex_lock(&priv->lock);
>>> -             if (val) {
>>> -                     if (!priv->enabled) {
>>> -                             priv->enabled = true;
>>> -                             clk_enable(priv->clk);
>>> -                     }
>>> -                     regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>> -             } else {
>>> -                     regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>> -                     if (priv->enabled) {
>>> -                             priv->enabled = false;
>>> -                             clk_disable(priv->clk);
>>> +
>>> +             scoped_guard(mutex, &priv->lock) {
>>> +                     if (val) {
>>> +                             if (!priv->enabled) {
>>> +                                     priv->enabled = true;
>>> +                                     ret = clk_enable(priv->clk);
>>> +                                     if (ret)
>>> +                                             return ret;
>>> +                             }
>>> +                             regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>> +                     } else {
>>> +                             regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>> +                             if (priv->enabled) {
>>> +                                     priv->enabled = false;
>>> +                                     clk_disable(priv->clk);
>>> +                             }
>>>                       }
>>>               }
>>> -             mutex_unlock(&priv->lock);
>>> +
>>>               return 0;
>>>       }
>>
>>
>> Another way to do this that avoids changing the indent
>> so much is placing braces around the case body like this.
>> This also avoids the compile error from using guard after
>> case directly.
>>
>>
>>         case IIO_CHAN_INFO_ENABLE: {
>>                 guard(mutex)(&priv->lock);
>>
>>                 if (val) {
>>                         if (!priv->enabled) {
>>                                 priv->enabled = true;
>>                                 ret = clk_enable(priv->clk);
>>                                 if (ret)
>>                                         return ret;
>>                         }
>>                         regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>                 } else {
>>                         regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>                         if (priv->enabled) {
>>                                 priv->enabled = false;
>>                                 clk_disable(priv->clk);
>>                         }
>>                 }
>>
>>                 return 0;
>>         }
>>
> 
> Looks great.
> But there is no indentation between "switch" and "case".
> As a result, the closing braces of "switch" and "case" will
> be placed in the same column.
> 
> Like this:
> 
> switch(mask) {
> case IIO_CHAN_INFO_ENABLE: {
> 
> }
> }
> 
> -Jiasheng


Usually, there is a default: case as well, so we could move the
final return and make it look like this:

	switch (mask) {
	case IIO_CHAN_INFO_RAW:
		return regmap_write(priv->regmap, TIM_CNT, val);

	case IIO_CHAN_INFO_SCALE:
		/* fixed scale */
		return -EINVAL;

	case IIO_CHAN_INFO_ENABLE: {
		guard(mutex)(&priv->lock);
		if (val) {
			if (!priv->enabled) {
				priv->enabled = true;
				clk_enable(priv->clk);
			}
			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
		} else {
			regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
			if (priv->enabled) {
				priv->enabled = false;
				clk_disable(priv->clk);
			}
		}
		return 0;
	}
		default:
			return -EINVAL;
	}


And it is unusual, but I found kvm_arm_pmu_v3_get_attr() that
also has this double inline brace at the end of a switch statement.

	}
	}

So even if it doesn't look so nice, it does seem to be the
"correct" style.

