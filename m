Return-Path: <linux-kernel+bounces-371481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0089A3BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868592810B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67724201112;
	Fri, 18 Oct 2024 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idakSHy6"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60C20101C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247654; cv=none; b=ngDwmBOEZU8u/mX5t/YgP7ynApbkIP46rQY0YnoZWKHWMJirTL4u8WylZGqMevrq8+Y9DEjHAsepFrCmNqCWD8R6uxD9WWcm22GSpR6ku6rPfzhJ4A95wc3EjVl59etfX3EL4176dhHOgTewj+pcIb3e7Ps0gNXLLmKbAra3TTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247654; c=relaxed/simple;
	bh=mA2KOXf3Z7bwRh07kEeE6r06chstYOPzx3Jp7aOFLBc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZuOzt3TpR6sNBfPvhe+Rrz1K0Hz5c6QtQxnUf9J3qrcJaO1QFaEnrqGWzTaX1F7Q2t3VGiFZ95TWd1TH3jZcPC93l89IgNg7yfw3cr64Vkz7aYRkQnKlmKUy5mfaPYAHVanYm7j4QpX+VKv2QziopVHywGhTT7dHrziTTBCNrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idakSHy6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so1300012f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729247650; x=1729852450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9HaPGj36d/cYoGWTqva/i0G1iTFOrr3BULtRnZFT68=;
        b=idakSHy6Lo38qIE26Mp1f6IJGJHCYzE52BU7GnLJupPzcMq0evXglAtQ4Bs34GpGOu
         tuzHo7D8Fy83gaWfGZ79T0RWpyV8p4ZYDpbYx7BnFUkS1yjl9JEAIPah96rlxXjB8eUF
         3FK2Jgkq8RLofO4bq9ED0wLLCs/Wwy16bMULBstNiU5Bnkdl129buOeKattNYvN5VXCh
         cFJhcFuCD58TGzWdSIUEZ1077RSEgBQwNh5pG76bAiDy+U6KDRd2Rpw+cExVYH72MyxY
         e+BC9CEpMptaXKFKlFoplrxXY6pXrzTGcBftLTrIbDLMa0N4J7klVqOqQmjblV6Omjev
         N/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247650; x=1729852450;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/9HaPGj36d/cYoGWTqva/i0G1iTFOrr3BULtRnZFT68=;
        b=axlf9civ1otSXuz43pQC5j0FHrUhHouGUhJvTixagbEUExiEt5vzlpYtQxvt9FGF7k
         m9OblrL8Flien/zaLqkFV6D+3XidUO66L7DcMfHowS6R4+IpHSyvn5SAopQEmoRz9Nya
         BpLuEA0LQ6o7oiQTLtrWt9P5ZGfthgUhSlaBcwrt2L/slqZ4C7fEgsrHLpZDWL7oNfSH
         CE5KYyRDQycac5KnTjqIStOElOOVb7mHDKLqebmeAKQNuNJUlo+MkrvhMGgLZqMB2YpS
         wq9PyMZOR+nk6xhAISS8XzK2wdtY/LUxei8Jm+Mu0WwyO5xBnfX/GOxwh6+6cVuCNf1h
         gVGw==
X-Forwarded-Encrypted: i=1; AJvYcCV4voJZ/hgcvHq6txVtNvH0QDigLY8EtZ0YHM/aoU2QaVCG5ONbgeeKsWZajlaf17wZHsSdckVPplhWzLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuxW7LYr53JC/+nWC+IT7sRdud1WCn9H7h6vdl5yqJBdvfBHQ/
	44iYq4sWBhckO83h/cMaOeiRzOD9KQhrCSlY+1tZjnOZTmcUlisriT0a5FxG1rA=
X-Google-Smtp-Source: AGHT+IG6ZDIajn6ShPY3FAqnQ4bAfURvGcVHOxUhQQT02CMSmKBZf/ad6QQ/DVZsaMQDhk80rkx34g==
X-Received: by 2002:a5d:4e05:0:b0:374:af19:7992 with SMTP id ffacd0b85a97d-37ea2140176mr1126087f8f.7.1729247650225;
        Fri, 18 Oct 2024 03:34:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b623:41fc:e293:c9b1? ([2a01:e0a:982:cbb0:b623:41fc:e293:c9b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf062dd8sm1579482f8f.35.2024.10.18.03.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:34:09 -0700 (PDT)
Message-ID: <20fc022c-874f-489f-8ac8-843db2726393@linaro.org>
Date: Fri, 18 Oct 2024 12:34:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: document the Allegro
 MicroSystems ALS31300 3-D Linear Hall Effect Sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
 <20241007-topic-input-upstream-als31300-v1-2-2c240ea5cb77@linaro.org>
 <20241012152051.644e0e61@jic23-huawei>
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
In-Reply-To: <20241012152051.644e0e61@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 12/10/2024 16:20, Jonathan Cameron wrote:
> On Mon, 07 Oct 2024 15:14:39 +0200
> Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> Document the bindings for the Allegro MicroSystems ALS31300 3-D Linear Hall
>> Effect Sensor controller by an I2C interface, mainly used in 3D head-on
>> motion sensing applications.
>>
>> The device can be configured with different sensitivities in factory,
>> but the sensitivity value used to calculate value into the Gauss
>> unit is not available from registers, thus the sensitivity is
>> provided by the compatible/device-id string which is based
>> on the part number as described in the datasheet page 2.
>>
>> The datasheet is available on the product website at [1].
>>
>> [1] https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300
> Use Datasheet tag. It's not that common but it makes it clear what this is and some scripting
> can pick it up.

Ack sure I'll use that instead

> 
>>
> Datasheet: https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Hi Neil,
> 
>> ---
>>   .../iio/magnetometer/allegro,als31300.yaml         | 43 ++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml b/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml
>> new file mode 100644
>> index 000000000000..0a08e769f3aa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml
> 
> Rob's bot has better eyes than me.  Filename needs to be allegromicro,als31300.yaml

Yeah I did modifications without testing it, bad habit....

> 
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/magnetometer/allegromicro,als31300.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Allegro MicroSystems ALS31300 3-D Linear Hall Effect sensor
>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: '^magnetometer@[0-9a-f]+$'
>> +
>> +  compatible:
>> +    enum:
>> +      - allegromicro,als31300-500 # Factory configured at 500 Gauss input range
>> +      - allegromicro,als31300-1000 # Factory configured at 1000 Gauss input range
>> +      - allegromicro,als31300-2000 # Factory configured at 2000 Gauss input range
> 
> I was wondering if the range should be a separate property, but given these
> are the part numbers the parts are sold under, I think compatibles are fine.

Yeah, I had the same conclusion

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vcc-supply:
>> +    description: 5.5V supply
> A quick glance at the pinout google fed me suggests an interrupt pin.
> Even though the driver doesn't yet support it (I assume as I've not looked at that yet)
> the binding should include it.

Sure I'll add it even if how it's configured in the epprom, it's barely usable by default.

> 
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      sensor@61 {
> 
> magnetometer@61 {

Ack

> 
>> +        compatible = "allegromicro,als31300";
>> +        reg = <0x61>;
>> +        vcc-supply = <&hall_vcc>;
>> +      };
>> +    };
>>
> 

Thanks for the review,
Neil

