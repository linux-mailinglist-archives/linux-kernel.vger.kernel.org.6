Return-Path: <linux-kernel+bounces-202095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C16A68FC7C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ADA6B24D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C503918FC7A;
	Wed,  5 Jun 2024 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9IE8tc/"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24B18F2CD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579726; cv=none; b=miARDGDQzhmikpkYPfsdnz80U29l2LhBewfdB78dku0RLDevCbmIc+5aY/aKvJU1TrL4ov2xjvBXNWp1wV0QW1iykkljUIA9AbZ2cQRk8JDJfkEACvGjAtEwQmHCY3U7nLDZBAni0GyFQF3d2/Z53cr59/GrmTtr9jNWnF+XyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579726; c=relaxed/simple;
	bh=EJXpSOgGuoa4/HZZtSlGPirWM12RV8lC1Y/RC/F9HFA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QuNwX5nCYepwCvE5xd7kwzslUBBfGpe5yEEXCe1iGfco/cudCpPqH/iRvVVRtP0rlimEFozAwjlVm0KrjFZdAN3g0JljhyiKQwIltZQgv4OoOwhcgpKiEn4MvtuR+A/CPtwnOPXI+MxUvMsONaIB6sIx8vNJhpTtNHmCkTGV9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9IE8tc/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35dce6102f4so1771562f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717579723; x=1718184523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aZp3wyE5ekzsTIWHpWbrt8XuH/G5p0iFSTouqyj9Bg=;
        b=m9IE8tc/NFb2SKk7qGjGfeM1h8dMjii4qwJD6iqfFI8kPwz4Tt1y+D3vt+UdRfZOJ4
         KNfXylTfayfO6nQ3jRBcQy9nqsAfxymAQii7nzQbh/AYlH2cI5XWojU1sG2Ibe62iznR
         l9fcWs0QmdGYFndXt7zBgT+4zSb7RuR1ElYFVmNZ6mOzTnnuA0FcYqfcbZqd5mLyMBMg
         hWCVnKNoUPWnD2njoR7ldWGPrn/UxM+6Avh/FRy8bdn0VIoaM4WF8gijF6cEgYqecEVl
         AF60XLDOeppD+LcjxYY1uRipnljV1c4avCl+8jjB42PrvH+60IPRk/f3pwllJuhTxPhS
         aT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579723; x=1718184523;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9aZp3wyE5ekzsTIWHpWbrt8XuH/G5p0iFSTouqyj9Bg=;
        b=u3G/y41FCvGESCkXBlpOxBYM1rDDPZzi3UGkaJZsQIZNOaxmr9ZXdYBpgbBa7PPuNp
         2i7ZCkHwsT+MwtQ0/EN6q/30P8eR2F+6uliObNJK0w0Y4XiOFz5HpuwvbQnuG+GKy9Gp
         OtVGnKXAVqcpTbROti83lvNilhE9EknUUokEC92HuEsD9mJUwcVmsiqVt5fOcNNaIthC
         FNBKAqy83kFTV6qGTaDFlONZqa6ehQ8BwK1qWzvaIMP+jluP5JS90Jz+xeJgC8RY+9Vy
         duBq9rpPYXzefH570+oEon2k1OLwGac3GNBXhN1seR1ThrEUMCiXQxQVZ/6g2UE5MHb7
         5luw==
X-Forwarded-Encrypted: i=1; AJvYcCXb3tu0kgk+mB3NynqdegYCTH2cJQnAipOJQrGffbo0fQcqF1xDqbaELMZBGwZ+IAAcnOpLQUbOhkLhodsb+BOPGMXldYY3SxzC2Pna
X-Gm-Message-State: AOJu0YzQ4rLed3R+UbkRAXRwriK5ERPnbC/AMia1nq+pO5KXfSL27f5e
	OVH3BUR8zSI75TFcyLVyJw7N7W17XUV04W5PVZTexT3Gw+Zh0EHqMTuhsobO+Wg=
X-Google-Smtp-Source: AGHT+IG4DNIDSVe9T92rRq3LMxr5LieWsgduZLuBSwgYLoAnxR2RRrOizcT2CkEWD5xDDP8HNuZKsg==
X-Received: by 2002:a5d:4645:0:b0:35d:ca3b:4d11 with SMTP id ffacd0b85a97d-35e8ef97043mr1413209f8f.61.1717579723202;
        Wed, 05 Jun 2024 02:28:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c7ce:7756:462d:a8bd? ([2a01:e0a:982:cbb0:c7ce:7756:462d:a8bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064aa6csm13842822f8f.93.2024.06.05.02.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 02:28:42 -0700 (PDT)
Message-ID: <01bde68a-88a7-46eb-860c-1375aa730bec@linaro.org>
Date: Wed, 5 Jun 2024 11:28:41 +0200
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
To: Andy Yan <andyshrk@163.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <a4b22708-e85d-448a-8145-244b49bca053@linaro.org>
 <ab0a6372-091b-4293-8907-a4b3ff4845c0@rock-chips.com>
 <11359776.NyiUUSuA9g@phil> <ef60403f-078f-411a-867b-9b551e863f56@linaro.org>
 <b8066150-c147-4eb6-9f7a-2bd0268c274e@collabora.com>
 <4456bc5a.9b2d.18fe7b76790.Coremail.andyshrk@163.com>
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
In-Reply-To: <4456bc5a.9b2d.18fe7b76790.Coremail.andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 05/06/2024 11:25, Andy Yan wrote:
> 
> Hi,
> 
> At 2024-06-05 04:33:57, "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com> wrote:
>> On 6/3/24 4:08 PM, neil.armstrong@linaro.org wrote:
>>> Hi,
>>>
>>> On 03/06/2024 15:03, Heiko Stuebner wrote:
>>>> Am Montag, 3. Juni 2024, 14:14:17 CEST schrieb Andy Yan:
>>>>> Hi Neil:
>>>>>
>>>>> On 6/3/24 16:55, Neil Armstrong wrote:
>>>>>> Hi Christian,
>>>>>>
>>>>>> On 01/06/2024 15:12, Cristian Ciocaltea wrote:
>>>>>>> The RK3588 SoC family integrates a Quad-Pixel (QP) variant of the
>>>>>>> Synopsys DesignWare HDMI TX controller used in the previous SoCs.
>>>>>>>
>>>>>>> It is HDMI 2.1 compliant and supports the following features, among
>>>>>>> others:
>>>>>>>
>>>>>> .
>>>>>>
>>>>>> ..
>>>>>>
>>>>>>> * SCDC I2C DDC access
>>>>>>> * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
>>>>>>> * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
>>>>>>> * Multi-stream audio
>>>>>>> * Enhanced Audio Return Channel (EARC)
>>>>>> -> Those features were already supported by the HDMI 2.0a compliant
>>>>>> HW, just
>>>>>> list the _new_ features for HDMI 2.1
>>>>>>
>>>>>> I did a quick review of your patchset and I don't understand why you
>>>>>> need
>>>>>> to add a separate dw-hdmi-qp.c since you only need simple variants
>>>>>> of the I2C
>>>>>> bus, infoframe and bridge setup.
>>>>>>
>>>>>> Can you elaborate further ? isn't this Quad-Pixel (QP) TX controller
>>>>>> version
>>>>>> detectable at runtime ?
>>>>>>
>>>>>> I would prefer to keep a single dw-hdmi driver if possible.
>>>>>
>>>>>
>>>>>
>>>>> The QP HDMI controller is a completely different variant with totally
>>>>> different
>>>>> registers layout, see PATCH 13/14.
>>>>> I think make it a separate driver will be easier for development and
>>>>> maintenance.
>>>>
>>>> I'm with Andy here. Trying to navigate a driver for two IP blocks really
>>>> sounds taxing especially when both are so different.
>>
>> Thank you all for the valuable feedback!
>>
>>> I agree, I just wanted more details than "variant of the
>>> Synopsys DesignWare HDMI TX controller", if the register mapping is 100%
>>> different, and does not match at all with the old IP, then it's indeed time
>>> to make a brand new driver, but instead of doing a mix up, it's time to
>>> extract
>>> the dw-hdmi code that could be common helpers into a dw-hdmi-common module
>>> and use them.
>>
>> Sounds good, will handle this in v2.
>>
>>> As I see, no "driver" code can be shared, only DRM plumbings, so perhaps
>>> those
>>> plumbing code should go into the DRM core ?
>>>
>>> In any case, please add more details on the cover letter, including the
>>> detailed
>>> HW differrence and the design you chose so support this new IP.
>>
>> Andy, could you please help with a summary of the HW changes?
>> The information I could provide is rather limited, since I don't have
>> access to any DW IP datasheets and I'm also not familiar enough with the
>> old variant.
>>
>   Accurately, we should refer to it as an entirely new IP，it has nothing in common with
> the current mainline dw-hdmi。 The only  commonality is that they both come from
> Synopsys DesignWare：
> （1）It has a 100% different register mapping
> （2）It supports FRL and DSC
> （3）different configuration flow in many places。
> 
> So I have the same feeling with Heiko and Maxime：
> The DW_HDMI_QP should have a  separate driver and with it's  own CONFIG  such as DRM_DW_HDMI_QP  in Kconfig.
> and the rockchip part should also be split from dw_hdmi-rockchip.c.
> I am sorry we mixed them in dw_hdmi-rockchip.c when we develop the bsp driver，but we really regretted this decision
> when  we repeatedly broke compatibility with dw-hdmi on other socs。

Yes please, and as I say, if there's code common with the old dw-hdmi, please add a common
module if this code can't be moved in core bridge helpers.

Neil

> 
> 
> 
>>> Neil
>>>
>>>>
>>>> Synopsis also created a new dsi controller for the DSI2 standard, with
>>>> a vastly different registers layout.
>>>>
>>>> I guess at some point there is time to say this really is a new IP ;-) .
>>>>
>>>>
>>>> Though while on that thought, I don't fully understand why both a
>>>> compiled
>>>> under the dw_hdmi kconfig symbol. People going for a minimal kernel might
>>>> want one or the other, but not both for their specific board.
>>
>> Indeed, it makes sense to have a dedicated Kconfig option. This is
>> mostly a leftover from downstream implementation, will fix in v2.
>>
>> Thanks again,
>> Cristian
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


