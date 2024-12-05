Return-Path: <linux-kernel+bounces-432871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DE59E5149
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D951188205F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454A1D5179;
	Thu,  5 Dec 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmE33We1"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DAA18E028
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390870; cv=none; b=GJBMUr/jE92yV17viCQhutm2cJnORnTU9vARDWvfvyTuLw9ApPOjoaGKCQ5fMu1ccgQ4WnIAMImTYBEiEREf6vZIP70UXpIIr7Ko297L2sMe+dxRL/E3t7jjNP+OHShqtXjjzpU+2DFxVSfjRspFkgImtw3zOXu2PqZ8XENZ6Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390870; c=relaxed/simple;
	bh=94kE73ydMVyzonmik9TNYAGbHipWQtvOBZy1ZlXHCNw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ukmr/+6qph6IUBdHFaUrEH7VN9MfB+gPyiSkHJioKnagXreMueTqTj656g6cHfoUfsLD2doQpDJFXu7z15omkVC1A36u8R1nM8SIPoEK5VIdubW0+dxqmnFocsPoPdFtlZ7FRWwRf/2gfpqp1NSm2j1Xvt6Qz0xm2J2j68yrOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mmE33We1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385eed29d17so585288f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733390867; x=1733995667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xU7uFh5m21xrGuOQvVJCOSvoBR6jrAPhaeO+Zvdsqdc=;
        b=mmE33We1HTZRjYEn6svfeID/zUzkL/YscC0EmFiT9UPem+aN7yiHn+90Vi2ROrP+D8
         sp338P86Bthm3BZ4Z8b3QhcvxR8Xl3lcqmblhvi0Mqcl4vWA+t8j+5FblHsfv8dY9Boe
         9e4uLxDJEnJ0+OeFhjfg7vMqCAxMG974HfEF0wEHYH3jIv+WSfJ1bNig/PM7Ptu5FEBg
         Rsd2B5zWSk1QL4zzpwK1TS9XgJ/tAawDi9ZnYDeEumuNiltgfBJRaugSVofJ5cy6yTWj
         OzjQ8uCuYvBAPfrpIlVZesepvB8Bklez0VcYyRnygFzeMr2EWlcUlWtbzFoh26Ig7Cy4
         jixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733390867; x=1733995667;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xU7uFh5m21xrGuOQvVJCOSvoBR6jrAPhaeO+Zvdsqdc=;
        b=h4HLNdBf0SVK4aY9fWvsqkMnkuBSeF9l5Ulc+qeG1XNEP3np3NqQomvMCEzhuZD0/U
         +bv2DRzgLIyRMy8atP3wD43ga1wQXPMIB5JpzdFvvFnR2r/XWdlUNaINeH8GCEaj/lPA
         shwoh4TT7b1A0FpaVTkoQDTLRCpMWsAwIU4P5IfnqFyR69Dl7pwrM0UdptRfgbADCWLf
         dZgNCGZdszstfc9NMc0NIWHPz3QxhW4b9yscNUdHkk8tTjjfiipezkVmZBdXrfGqCgtR
         zOeRWTP6JxGeeKKqB7gUjJV89m7vgQzLqXZWdsAgpRGRxFzdxVzGJyhVqvfsJc+G/iq0
         Er1A==
X-Forwarded-Encrypted: i=1; AJvYcCVMxQGvW3MazK00ZYcrm5KWeyncqmR1fm+++ANrL6hjpDojRQLrlh/OdjRrABss2rSoIeH7MOuPn0DWkX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGrg1tKjNSrJLDgFP8/o6O7igUezv4ePsnTLxS1c1AYyNPuW8
	a568awF+rE5c5Yn0THcDUqHozaX6hspqfWKFJELoj2XVEO1xXHnCAKBWMypSbV0=
X-Gm-Gg: ASbGncvty0jGvgdePSnRjObrHOCOj2lvVy6cieMF7HZVIwxo7KRdk2kJqqEAoldyQXA
	03tVxd9jAC7hql//V54pz5sfvynO7RRYv+93wTMYrSd2y9KwK8D2YovDUN0g1x8YngfD8r+pisT
	goizOdP+KYEiQubZeRCBKNKDczwzQha1r0JtBA93uVyHf1GFvO15+0zhXjE4J3K03e+9KZ4+6Ay
	KjJRfT5XBv6RS/486QbDHdmHJcU2AhncA/tY0mFv0MDBqp3fdUpsXspmwFr6ZTbEwL1GC6pS9/I
	TP06EsTPj0Mwsyctce9Zgv0h4yg=
X-Google-Smtp-Source: AGHT+IHzKfFrugEilrYTWw7f5n4tGtcZQdBbXHOkNMbrOaUkslhVdrf16gD5Xz2rnOncYyiyTOOnkw==
X-Received: by 2002:a05:6000:1f88:b0:385:fb34:d585 with SMTP id ffacd0b85a97d-385fd422f21mr8022616f8f.34.1733390867017;
        Thu, 05 Dec 2024 01:27:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2fc6:5c45:ce54:e076? ([2a01:e0a:982:cbb0:2fc6:5c45:ce54:e076])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b158sm55748325e9.8.2024.12.05.01.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:27:46 -0800 (PST)
Message-ID: <2499c1b4-8cf7-4061-9cc8-d6c0c6aef0fb@linaro.org>
Date: Thu, 5 Dec 2024 10:27:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sdm845-db845c-navigation-mezzanine:
 fix ov7251 lane properties
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
 <20241204-topic-misc-dt-fixes-v1-2-6d320b6454e6@linaro.org>
 <vlvchjynnwvevr2raosrwggwmjd5bdrs5skbsztskmzxjjdg7v@6qkhrjyaxlsz>
 <0c1f4e6a-a77b-46d1-b944-9eb47d66556d@linaro.org>
 <cd754842-42f0-4938-b590-34ed7c4503c6@linaro.org>
 <eb7fc499-d60f-4a3f-8279-1c9de19c2328@linaro.org>
 <e9e8e34b-cd6a-41d8-a267-3b9336e3ca24@linaro.org>
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
In-Reply-To: <e9e8e34b-cd6a-41d8-a267-3b9336e3ca24@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2024 14:30, Vladimir Zapolskiy wrote:
> On 12/4/24 15:16, neil.armstrong@linaro.org wrote:
>> On 04/12/2024 14:10, Vladimir Zapolskiy wrote:
>>> On 12/4/24 14:16, Neil Armstrong wrote:
>>>> On 04/12/2024 12:05, Dmitry Baryshkov wrote:
>>>>> On Wed, Dec 04, 2024 at 11:56:54AM +0100, Neil Armstrong wrote:
>>>>>> Bindings documents data-lanes as a single entry with a separate
>>>>>> clock-lanes property, but DT uses 2 entries in data-lanes.
>>>>>>
>>>>>> This would suggest clock-lanes is missing, fix the DT using the
>>>>>> bindings example.
>>>>>>
>>>>>> This fixes:
>>>>>> sdm845-db845c-navigation-mezzanine.dtso: camera@60: port:endpoint:data-lanes: [0, 1] is too long
>>>>>>      from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
>>>>>>
>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso | 3 ++-
>>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>>>> index 0a87df806cafc8e726aacc07a772ca478d0ee3df..5a16f4c2b346b314af3d614266e1ca034057e643 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>>>> @@ -115,7 +115,8 @@ camera@60 {
>>>>>>             port {
>>>>>>                 ov7251_ep: endpoint {
>>>>>> -                data-lanes = <0 1>;
>>>>>> +                clock-lanes = <1>;
>>>>>> +                data-lanes = <0>;
>>>>>
>>>>> Is it really this way or the other way around, clock = <0>, data = <1>?
>>>>
>>>> No idea actually, on the schematics the lanes from the DB845 are :
>>>>
>>>> CSI0_P/N -> OV7251_CSI3_LANE0_P/N -> MIPI_CSI3_LANE0_P -> SoC
>>>> and
>>>> CLKP/N -> OV7251_CSI3_CLK_P/N -> MIPI_CSI3_CLK_P/N -> SoC
>>>>
>>>> So I assume the data-lane is 0, for clock-lane I just used
>>>> the example, but I found nothing in the code using those assignments
>>>>
>>>
>>> It's a sensor property, and OV7251 sensor has the non-selectable clock lane.
>>>
>>> If it's technically acceptable, I would rather suggest to deprecate and
>>> remove "clock-lanes" property and hard-code "data-lanes" value to <1>.
>>
>>
>> Ok indeed while looking at the OV7251 sensor datasheet, there's a single
>> fixed data lane and a single fixed clock lane, so on the sensor side we
>> can't select anything but how would we define lane0 is used on the SoC side ?
> 
> It's done right in the common way, there are clock-lanes and data-lanes
> properties on the ISP endpoint side.

For the ov8856 yes, but in the current state the ov7251 endpoint is not
connected to the csiphy3, so it's currently not usable and disabled,
so I'd rather remove this node completely instead of fixing an
untestable dtso.

Neil

> 
>>>
>>> By the way, this particular device tree bindings miss bus-type property,
>>> it could be either MIPI or LVDS serial output.
>>>
> 


