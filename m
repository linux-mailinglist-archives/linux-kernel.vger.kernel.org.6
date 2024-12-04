Return-Path: <linux-kernel+bounces-431243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5009E3AF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4591689EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7F81BFE06;
	Wed,  4 Dec 2024 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lddk39Bb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DE11BD000
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318166; cv=none; b=tyiarpnlOhTJgz6dj+yQ3z29UYIBviov0ZNfTdPZpRwglpp3Pte6JlvABfojKHCRNp9tPpSZuzmoE0SxW5ZvX1JjHMCbpnjyuWs52f1dxJ5OQibywsk1cRXsn2Klq3x0pii/NXtigEUoNc1StFSiLNaN25jMMIkLLNNZq5hIXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318166; c=relaxed/simple;
	bh=URuQa7uP7ZGpf/U70tTYV9chqrKlWFG5Kvonk+sjNSU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G8MxDavApvgWmMXYiJJL5px+Ma2h8VOSzRn1SJzo1b7TyHxsuFrTFB6NsHo1MRBWbwbni+X47fDVIWHN/nLv07RzC/yu1t0PJpExAJGhRb2RkjGYQKMYFpZWoAPYR7kUuKkcoK/dLolRzwU2/8lJNzLIW+4J3FBmuixP2J4Wwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lddk39Bb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a1639637so62945175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733318162; x=1733922962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5WPSJaQuc/pY6TO8yAGp7t/3bbYIa0FAbkbKZP3asg=;
        b=Lddk39Bb7LYIt3LQJ72TmdelYnSApAg6i/vrCZw0adJx2KgltuUJEIQhScUbvylBba
         oOeyyJOpRzp1QrCXvi9TFfYxBoOdWo3WHC689hk2U/XZIn8ses6x8+sP8DyPhmSXLuRO
         Ueoa/cWsUOsOEn3dfcDgqj+h0DI0KrSz0jcHAYxFgAmP1/AKkzH5ABDWXC4EIxz9yvxL
         XU7PIiTa3v/1C4gtxIzO/ts8vtPedY/ba1x7ctL17Kw1ILP4ImbNdl2ZTiRERh0zD9eG
         f9os269RX0zl2af99ni02kWu08rNtdPTIKpJJDfpQMUP/c6eV4oxcFc8EgYMv2zQ+22G
         8N+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733318162; x=1733922962;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h5WPSJaQuc/pY6TO8yAGp7t/3bbYIa0FAbkbKZP3asg=;
        b=nw+U+ao9niZzBGaWGkGcfd4iUE3YQturT+OyJxKi1h8/aZcXaWHf5LwOgPKNTsnrY5
         eZsfWnjp2WefmFkfXJEOPbVvcPq79OZqu/JIUWDhMHcvDlMQBoeOWetnhy3OK2egUZX7
         xgxBSoKOKCOUPgcJ/wx9jBg2nEBLKkOMXoCqPy6I2mDdtean92xP8zON/I0sIa8XZh1C
         pgLkINPdvljh+rRz6D9wtVOvhE9zjkQrUUE+gNKVtYxg9SM65sNB6OG2zxgnc9QQ7/qJ
         IEyrfi1qjwdD1SN+vXhnBOJaomchtkFkJEpSaBC5qf/9LEcM85LUgF+IcY7vuilk/eyw
         +UNw==
X-Forwarded-Encrypted: i=1; AJvYcCXmuWSchYlT2UWphxjawvOQLUUTUdDQu37j4lTaNpi1/VLW8gT/JexrcylqiPqoHx2VZDqevjJhLm3eS5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGlTUAiwd88N8fOYHZdpgqX38iggfIDfsiC2RnMgSdjzYIvex
	qXMCoFzkcnOzDZ+WEWaVIlNtM0NHKAqx/4a09sZICeMqSV83QmDZaES5tMDxY2c=
X-Gm-Gg: ASbGnctFCTTXnC0OVI2neO4bmB/BUTkloc1WiRDb+RMYZ2We+EIkNq9nR6oYxgqPk7f
	5egTSAQSYL3hqFNSs3R0oqDwjfu1ic4of9S+LEACGel7gBjqkAao0bv8QOv1b+Tq2gkLjAB+JiJ
	bXWTmxKQaTz7x03BI9J0K91I46Poq0ppjZsxHmzEBEYv1oYRUh+KaWRCRM5IsTTgho4xQ+hAxUv
	tJbKtpMqWRTJaNB+QiCJD+LXfngOGDr9sn/2VS4S7kJqkpSNiMmKorOSk8YxJEvTtZ5C5q/LgvZ
	iwY0ukCFWMSzd10WEeENfjFp
X-Google-Smtp-Source: AGHT+IGb73ymDy0LsKpmLg/6f0WpjNR6M+puyEQHcq4JSzJMKcqkK0U4oVr7eaL3FwOY9Jr2K+TSlg==
X-Received: by 2002:a05:600c:83c8:b0:434:a962:2aa0 with SMTP id 5b1f17b1804b1-434d0a1533emr52300645e9.32.1733318162555;
        Wed, 04 Dec 2024 05:16:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:740:b323:3531:5c75? ([2a01:e0a:982:cbb0:740:b323:3531:5c75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385eed2510esm9921492f8f.69.2024.12.04.05.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 05:16:01 -0800 (PST)
Message-ID: <eb7fc499-d60f-4a3f-8279-1c9de19c2328@linaro.org>
Date: Wed, 4 Dec 2024 14:16:00 +0100
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
In-Reply-To: <cd754842-42f0-4938-b590-34ed7c4503c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2024 14:10, Vladimir Zapolskiy wrote:
> On 12/4/24 14:16, Neil Armstrong wrote:
>> On 04/12/2024 12:05, Dmitry Baryshkov wrote:
>>> On Wed, Dec 04, 2024 at 11:56:54AM +0100, Neil Armstrong wrote:
>>>> Bindings documents data-lanes as a single entry with a separate
>>>> clock-lanes property, but DT uses 2 entries in data-lanes.
>>>>
>>>> This would suggest clock-lanes is missing, fix the DT using the
>>>> bindings example.
>>>>
>>>> This fixes:
>>>> sdm845-db845c-navigation-mezzanine.dtso: camera@60: port:endpoint:data-lanes: [0, 1] is too long
>>>>     from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>> index 0a87df806cafc8e726aacc07a772ca478d0ee3df..5a16f4c2b346b314af3d614266e1ca034057e643 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>>>> @@ -115,7 +115,8 @@ camera@60 {
>>>>            port {
>>>>                ov7251_ep: endpoint {
>>>> -                data-lanes = <0 1>;
>>>> +                clock-lanes = <1>;
>>>> +                data-lanes = <0>;
>>>
>>> Is it really this way or the other way around, clock = <0>, data = <1>?
>>
>> No idea actually, on the schematics the lanes from the DB845 are :
>>
>> CSI0_P/N -> OV7251_CSI3_LANE0_P/N -> MIPI_CSI3_LANE0_P -> SoC
>> and
>> CLKP/N -> OV7251_CSI3_CLK_P/N -> MIPI_CSI3_CLK_P/N -> SoC
>>
>> So I assume the data-lane is 0, for clock-lane I just used
>> the example, but I found nothing in the code using those assignments
>>
> 
> It's a sensor property, and OV7251 sensor has the non-selectable clock lane.
> 
> If it's technically acceptable, I would rather suggest to deprecate and
> remove "clock-lanes" property and hard-code "data-lanes" value to <1>.


Ok indeed while looking at the OV7251 sensor datasheet, there's a single
fixed data lane and a single fixed clock lane, so on the sensor side we
can't select anything but how would we define lane0 is used on the SoC side ?

> 
> By the way, this particular device tree bindings miss bus-type property,
> it could be either MIPI or LVDS serial output.
> 
> -- 
> Best wishes,
> Vladimir


