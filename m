Return-Path: <linux-kernel+bounces-199185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8DC8D8383
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6441C23DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAB412C814;
	Mon,  3 Jun 2024 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQieuMUj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989512C491
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420122; cv=none; b=bM35ZHkCRkt+zurl/pHCmHRRZz7Z73dV9OTDz2m+7EHa47AqgfvNqGn7ekW8iExmQLKSO8OM/IxLXifoufsgXLEK4wYdqVbfy1MlfN6VEBaiproeLVXLWCBNXbV55Gva/27jEVm0BwFk/Azjd2M0OWuIqgmB7isuHJAr+z3xq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420122; c=relaxed/simple;
	bh=9IDMboTpNoRCtYQ4p427Pn2NpWXZsyWe6afEdc7z5hQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kZ8SApdUvomUwmMov4SoY8rRy041GkZtt+WrVx3+bOVxA1bZvR9ZsB4sCjjLaeVIeWClGfu3Y2rdRAevZcMl51ek3N/VZiWhzdmM8kRJQUeSC9POnNDPYW87LkoJ+7CeEDA+uYbFQyi5benzyQdha93xXMioJWmJSJ6EcfDYTuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQieuMUj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4213a496a81so9075325e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717420119; x=1718024919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gx8F+Fp9SWNUY6Yomh+HNjqS3oRk4P5HF08WogPmZDs=;
        b=BQieuMUjZbH7GiyDd3DxFLMCmSGtdcwkqYEjSlGAb/UULpR7aE7UKrBNbvN8XKQtZm
         A360/tIQjGxKF1BAg1iBaom1de8OlYKXJLosMf76Y8O0/+ful/1k6ycwU7RifFFEoEgd
         2dlSnwtu41v6LuuMfefenbju1oswWh4dn3UwLImE+zL+NQiVREGbq2whNw21S2qHM3YP
         spxC0RaSzMam5yVpMsgqYFn8fvrK70EUoQNOZ4HKlI7AfUSPlghKvKTTEqZT4Es+mvCl
         /cTFdlcsGg2r/8IQOZgYqO/A+/tFTUTQViuppq7E9Wz9Q5ELYGrmdjiW3u67TM0Njoqy
         alDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717420119; x=1718024919;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gx8F+Fp9SWNUY6Yomh+HNjqS3oRk4P5HF08WogPmZDs=;
        b=rN/MJIkxDPKiSz498E6OifybowYk6+iW5RYLE9E9ScX9scf6fUtwFV6dJtdKFadQdL
         Bf9A8D0SfnE0ozZ0390D5cVolxDkZPyEwBQyaRxhWuAzgBvSsmv7rD4FKOA/G5uWllxi
         PGWjb7ee8MO1zc6wEqWq/HTpKjOybLAELuZElNVm/eE6acariGHeKn7cvNTuXIVwitYp
         AL4CX+ISTjfXrLk7Onkh+9n8cERzcAH5VmpJNkiRLPIhkWld5OgPF3qS0Aex7Tb9qVlA
         FGEgDq5LCkNkl5u5LsjqJ/JSdyA94+7Xl63ohTxxA7YOvBdb3LsQdVvzqWZKhifNF+f+
         F7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyuczrhw5IDde4iJNUN7RH7ruFxmLqL+vE5IupmDwvUbYgJpubws8VmkjqnkFcJg5uUY92xIMG2NSRd3Z8X2aEJi/Ic/iKiFg/WOSF
X-Gm-Message-State: AOJu0YxVrAS5aQK8ZVkaMDJe99zvyTKCXoSSkTW6ZM6+ziVjdmO4SmWt
	2pAKPV46sWq5Gk10unl+861tPKoZ/ExD0jDvh1vBiqXelJyGj3XoIXX/6iwlEn8=
X-Google-Smtp-Source: AGHT+IGk0uTd6E9uGLIil4o8K0nvJynzZnkSYzkdwscvLlhumYGzjCi6eNdCTeQ3QEO7F5aMBDsE0Q==
X-Received: by 2002:a05:600c:1550:b0:420:1fd2:e611 with SMTP id 5b1f17b1804b1-4212e0adf99mr54609955e9.27.1717420119183;
        Mon, 03 Jun 2024 06:08:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:79fe:b764:2b06:ab4b? ([2a01:e0a:982:cbb0:79fe:b764:2b06:ab4b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8b76f3sm115776355e9.47.2024.06.03.06.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 06:08:38 -0700 (PDT)
Message-ID: <ef60403f-078f-411a-867b-9b551e863f56@linaro.org>
Date: Mon, 3 Jun 2024 15:08:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/14] Add initial support for the Rockchip RK3588 HDMI TX
 Controller
To: Heiko Stuebner <heiko@sntech.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <a4b22708-e85d-448a-8145-244b49bca053@linaro.org>
 <ab0a6372-091b-4293-8907-a4b3ff4845c0@rock-chips.com>
 <11359776.NyiUUSuA9g@phil>
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
In-Reply-To: <11359776.NyiUUSuA9g@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 03/06/2024 15:03, Heiko Stuebner wrote:
> Am Montag, 3. Juni 2024, 14:14:17 CEST schrieb Andy Yan:
>> Hi Neil:
>>
>> On 6/3/24 16:55, Neil Armstrong wrote:
>>> Hi Christian,
>>>
>>> On 01/06/2024 15:12, Cristian Ciocaltea wrote:
>>>> The RK3588 SoC family integrates a Quad-Pixel (QP) variant of the
>>>> Synopsys DesignWare HDMI TX controller used in the previous SoCs.
>>>>
>>>> It is HDMI 2.1 compliant and supports the following features, among
>>>> others:
>>>>
>>> .
>>>
>>> ..
>>>
>>>> * SCDC I2C DDC access
>>>> * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
>>>> * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
>>>> * Multi-stream audio
>>>> * Enhanced Audio Return Channel (EARC)
>>> -> Those features were already supported by the HDMI 2.0a compliant HW, just
>>> list the _new_ features for HDMI 2.1
>>>
>>> I did a quick review of your patchset and I don't understand why you need
>>> to add a separate dw-hdmi-qp.c since you only need simple variants of the I2C
>>> bus, infoframe and bridge setup.
>>>
>>> Can you elaborate further ? isn't this Quad-Pixel (QP) TX controller version
>>> detectable at runtime ?
>>>
>>> I would prefer to keep a single dw-hdmi driver if possible.
>>
>>
>>
>> The QP HDMI controller is a completely different variant with totally different
>> registers layout, see PATCH 13/14.
>> I think make it a separate driver will be easier for development and maintenance.
> 
> I'm with Andy here. Trying to navigate a driver for two IP blocks really
> sounds taxing especially when both are so different.

I agree, I just wanted more details than "variant of the
Synopsys DesignWare HDMI TX controller", if the register mapping is 100%
different, and does not match at all with the old IP, then it's indeed time
to make a brand new driver, but instead of doing a mix up, it's time to extract
the dw-hdmi code that could be common helpers into a dw-hdmi-common module
and use them.

As I see, no "driver" code can be shared, only DRM plumbings, so perhaps those
plumbing code should go into the DRM core ?

In any case, please add more details on the cover letter, including the detailed
HW differrence and the design you chose so support this new IP.

Neil

> 
> Synopsis also created a new dsi controller for the DSI2 standard, with
> a vastly different registers layout.
> 
> I guess at some point there is time to say this really is a new IP ;-) .
> 
> 
> Though while on that thought, I don't fully understand why both a compiled
> under the dw_hdmi kconfig symbol. People going for a minimal kernel might
> want one or the other, but not both for their specific board.
> 
> 
> Heiko
> 
> 


