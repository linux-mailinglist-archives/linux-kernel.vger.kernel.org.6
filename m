Return-Path: <linux-kernel+bounces-191987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69B8D16E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4F7B239A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D313D29B;
	Tue, 28 May 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUcK+Hhs"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DF58AB4
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887287; cv=none; b=MFTaCMLYnwPES0IaooykFZpyMDjO7uuHHFTAE3yHf6tm8hPIG8Oc+c1b6QuQWFie46TdDqJX/Q4nmV23XHRkS1fUSw6/XngFhO4ByMIOz/ctFnRw1exF+6pjp7ChMXx3uG7fvnIrHwM/OPY38lyunozoo1/zAU14w2NcLY85psk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887287; c=relaxed/simple;
	bh=9+CGOjqCFI8cBZqMQUSyJVRaj598mOEhBKpeMA2uMMY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wz29aSc85Q4kZXizOZo4mDZBKrpyLCkdrHZKlSj3bs853A5g/E/azQL18dW/bC77tLg6RJn3TamrZrABZRtyWkgrcSGcamhLMksueUsf8yU9qQGBoVqnsYCV4yiPwYRs4977BpAbhtOQKSs4vNLF9o3cWq7bEDH12zfaJV3QfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IUcK+Hhs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so4662585e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716887284; x=1717492084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3SQwXIIXHjRM5uNeBKtEGihfqD66qoKItzKJ4EdXAo=;
        b=IUcK+Hhs1shSX/so/CSGKdfwUlBwf+/zKWTFhP4T44UQK2MCURsKkU56ec+C86Uof1
         QfvkBtKXm9MK3gc9vakfiSAqp7BesOtlhMKAL1tOwriQMQdCMfbNC7L2zeROeZXJCLgG
         v80QdUVfZhllyakBy2mgx2a7PBrEroKK3VZGgLmB1kFfnL83ax9cvQOSCtmbbzra/F/q
         imEVG7xIhKjA9kAY0UoRmCXZ+UhfkjkIWiexXcBRn9syGI8xQBiCXu+jTOWgIZeqD8TR
         NPgb5vh6gZa9HtnLwHlYGiKqtllc+aP2FKE66Y7x5ggzorKSAoIVrgGvbiK9qeC9CiRK
         N2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716887284; x=1717492084;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a3SQwXIIXHjRM5uNeBKtEGihfqD66qoKItzKJ4EdXAo=;
        b=a+nSDwelBBUnPd/rmJe/W9LbFbnIPBK/uQfFRWWC5vVXiqlEyKbR2dtigZCmggLxTP
         /iNcOdCc8EpHc8m0hxpM9MADH2+2nwyT56sZEkTnB1g55sK9X72Thak2IqK7pCHNNol6
         xR+VqMbZ9ZgGu1D1QJ+WmZ2xKm1rtEBcS3z5t80wvDQVMtp8rQHSLg6kl6PmG0ReZNZt
         bJLaZh3lvIGB0oIO5PaUMwxSwWCspxgirFxSZgY4cip04OYJC0c7R1hFw5xX7a1aoXZY
         W1gSBbw5a7dj+4m4xj2T2sSRjqckqFZlZzRulIiHOBJNCCz+vdGccXJhsGqnSuOZwGXi
         AfQg==
X-Forwarded-Encrypted: i=1; AJvYcCWdVStljh6IMF3XvITla64TlWOLEa7n6UPMSPjtPXFFakuPesPemrbeGpEl2YQirhuZpG5KM0BV8TKebHqJqQl3J0EhxzURfBgO8wI9
X-Gm-Message-State: AOJu0Yy+l45RWtBllAinDvSP+LjIZUjgCKaavF+tXbHjKq8A63835hly
	w2sZNrbKmkDetVwsc2yW4Lyd8ykAmQD4amJF46ubh7Bsro73v7CNeXNDl5kmK8Y=
X-Google-Smtp-Source: AGHT+IEe5BlH9PQdZyM3Yr+PHsNxwDNOOPiWSviwZgKb7/NFJzJaatF7rZUzlXn8gDyUKiEed9NoCA==
X-Received: by 2002:a05:600c:4f03:b0:41b:a8e8:3ff6 with SMTP id 5b1f17b1804b1-42108a59341mr95487685e9.11.1716887283658;
        Tue, 28 May 2024 02:08:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8f19:f965:3f93:6385? ([2a01:e0a:982:cbb0:8f19:f965:3f93:6385])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae96bsm135209155e9.35.2024.05.28.02.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 02:08:03 -0700 (PDT)
Message-ID: <fbafc16d-d6fa-4c57-8fc8-a1db09d03e05@linaro.org>
Date: Tue, 28 May 2024 11:08:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] arm64: dts: amlogic: a4: add power domain controller
 node
To: Xianwei Zhao <xianwei.zhao@amlogic.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com>
 <20240528-a4_secpowerdomain-v1-3-2a9d7df9b128@amlogic.com>
 <c97b12bb-8b56-4129-a292-588226a0ec42@linaro.org>
 <70083d10-483e-4daf-a408-020f0147c5cf@amlogic.com>
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
In-Reply-To: <70083d10-483e-4daf-a408-020f0147c5cf@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 11:00, Xianwei Zhao wrote:
> Hi Neil,
>     Thanks for your quickly reply.
> 
> On 2024/5/28 16:46, Neil Armstrong wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 28/05/2024 10:39, Xianwei Zhao via B4 Relay wrote:
>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>
>>> Add power domain controller node for Amlogic A4 SoC
>>>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> ---
>>>   arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 4 ++++
>>>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 5 +++++
>>>   2 files changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
>>> index b6106ad4a072..eebde77ae5b4 100644
>>> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
>>> @@ -27,6 +27,10 @@ xtal: xtal-clk {
>>>               #clock-cells = <0>;
>>>       };
>>>
>>> +     sm: secure-monitor {
>>> +             compatible = "amlogic,meson-gxbb-sm";
>>> +     };
>>> +
>>>       soc {
>>>               compatible = "simple-bus";
>>>               #address-cells = <2>;
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>>> index 73ca1d7eed81..917c05219b9c 100644
>>> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
>>> @@ -37,4 +37,9 @@ cpu3: cpu@3 {
>>>                       enable-method = "psci";
>>>               };
>>>       };
>>> +
>>> +     pwrc: power-controller {
>>> +             compatible = "amlogic,a4-pwrc";
>>> +             #power-domain-cells = <1>;
>>> +     };
>>
>> pwrc is supposed to be a child of secure-monitor.
>>
> Considered writing it like this when I wrote this.
> 
> Here are two approaches: one is to include secure-monitor in the comm dtsi and fill power-controller by aliases in dtsi of each chip, while the other is to directly include secure-monitor in the dtsi of each chip. Which one do you suggest?

The bindings mandates it to be a child of the secure monitor.

Neil

> 
>> Neil
>>
>>>   };
>>>
>>


