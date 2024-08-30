Return-Path: <linux-kernel+bounces-308274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162199659A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E1B1F23EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C2316D4FB;
	Fri, 30 Aug 2024 08:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltBtzvt6"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CD16726E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005488; cv=none; b=pB5XBoYhLKePHwDldcnd6l9i8y7stCWky7sO5HssE/D4G/dZjMHMeEv16uEkdOANXKNkTLs2Dk0oilZDCuTnYg6FiUvgAbms3wuLKJ+mvImpBjHaSMA1BXDPAC82G6Sd0ZVmWGVzS++dPwijdAjCo4p3lhtnJhaAIf2LS61NaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005488; c=relaxed/simple;
	bh=bbgBYB5Rp1uJv9JwnKH/5yZXIS42XWcw/TLsy0TMJJo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LER1fov7iTJmfxX7Z5GbLCdvX+qQQTjXyuu0HYhZzz522B7vMa6556bdziNQdwIg6AxImiM1uBvYjnxFQf/l2HeLeo43XHQ9DsRnn9lERKb4VyI6Lz0oQRYC9bbXeRk1boUMiRYzGXt90D9KZYWOqDg1vUBc3ow98gTUzmUpO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ltBtzvt6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bb9d719d4so6858255e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725005484; x=1725610284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AWw6cuU4qnYJYiO0KkscvNgK+nvviO/5QOFUcQDLXc=;
        b=ltBtzvt6YkcGbHcxiZwrMfnyUHtF92CPS5pc62KRdn8FFhowtsUNpjtPWk9MlRJPnO
         lVLT+IszzVvWgZXkbw6fR9ReBCQ0b0jSLUuaVWu4ijHx9a7GwQTU4iR1KTYpTr//+W4/
         ngf1zoVXOnfpN+z8ZyJIZ5Q66syA0W3eCGEtuiW9w/qQKnEYpTEgJDhI1Um3XkXfiavh
         tlyhlvjeBOEferbMaaoKIjRpw7TE15YBWUM8Kp1ZcdEI3TC8WiMGOZfWL69+UnGPKTLR
         o3VZ+bURHB7tCInjpVrOtybT56a7UruPWg+W/SJepOmRN4rwZL0EAMfYHNv2T+LGQ0XU
         lamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005484; x=1725610284;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5AWw6cuU4qnYJYiO0KkscvNgK+nvviO/5QOFUcQDLXc=;
        b=VHgdLKi5T9lIkZ+rqOrFIHIxKHTzAygAYifGr7Fcpsuwx9EtoqS/A+2nEEHsiIc/n9
         vvQvQWRiaynWCAekU+PxLvSlr2hcnLFd8HtxU+y0eljT5dwo/aRTdVdk+7UD+os3rt55
         dimX3gkZKBKj/Hx9dC/Ejfc9qrC/dNi0t85Moz1IX59FPYPmmkUc1HWKWxsJVY2EVm7e
         jvXEDs3jlwPnYVjLPogeWMUg30OwOgk792JXkXv5SEbSaiU/ZMH/SJMPGs+Q64ZN2EcK
         +0kjeqW/RUy8/3FztYO94h78Damf9bzlF+BOHNN/bt3+38O+ZSKmABsBXLcjdOiRATtS
         viiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKXrTzJ+ZjBAVa6mJ0AWxxlTnnVL8tDnPljKamtgmOhMs+LHWDWIMx08HOaJRj/WctAD/XH2fs8xhdzFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFqxrPd3GK5G0UFjgKsXm7FQoRKzagYMPYj4RTKVDXlO9mBYQ
	KWl9KpWUOP5QMlwYBra1MkwGtR/ityDtpdDGI1mZqJFYcyTFuMLaO+EvoSzvOx4=
X-Google-Smtp-Source: AGHT+IEV5spCX0hbbp4UfJY+WGRKziPDTx2Krz+YblmLQl+3ltKa8h0jfNsfBitlfkYP2YeGxnySbQ==
X-Received: by 2002:a05:600c:4594:b0:426:64a2:5375 with SMTP id 5b1f17b1804b1-42bb0283665mr42641335e9.1.1725005483843;
        Fri, 30 Aug 2024 01:11:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5001:8e1b:dd18:1d3? ([2a01:e0a:982:cbb0:5001:8e1b:dd18:1d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb73e20b7sm36307285e9.14.2024.08.30.01.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:11:23 -0700 (PDT)
Message-ID: <79c735ca-008d-497b-bf5b-a21f6dcde796@linaro.org>
Date: Fri, 30 Aug 2024 10:11:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 1/3] dt-bindings: clock: fix C3 PLL input parameter
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: xianwei.zhao@amlogic.com, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240830-c3_add_node-v4-0-b56c0511e9dc@amlogic.com>
 <20240830-c3_add_node-v4-1-b56c0511e9dc@amlogic.com>
 <0e74dbc8-88ed-43db-95ef-0fe55d92091d@linaro.org>
 <1jplpqsa71.fsf@starbuckisacylon.baylibre.com>
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
In-Reply-To: <1jplpqsa71.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/08/2024 10:10, Jerome Brunet wrote:
> On Fri 30 Aug 2024 at 10:00, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> Hi Jerome,
>>
>> On 30/08/2024 07:26, Xianwei Zhao via B4 Relay wrote:
>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> Add C3 PLL controller input clock parameters "fix".
>>> The clock named "fix" was initially implemented in PLL clock controller
>>> driver. However, some registers required secure zone access, so we moved
>>> it to the secure zone (BL31) and accessed it through SCMI. Since the PLL
>>> clock driver needs to use this clock, the "fix" clock is used as an input
>>> source. We updated the driver but forgot to modify the binding accordingly,
>>> so we are adding it here.
>>> It is an ABI break but on a new and immature platform. Noboby could
>>> really
>>> use that platform at this stage, so nothing is going to break on anyone
>>> really.
>>> Fixes: 0e6be855a96d ("dt-bindings: clock: add Amlogic C3 PLL clock
>>> controller")
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> ---
>>>    Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml | 7 +++++--
>>
>> So you mind if I take this one via my arm64-dt tree ?
> 
> There is no conflicting change in my tree so it's fine, yes.

Thanks
Neil

> 
>>
>> Neil
>>
>> <snip>
> 


