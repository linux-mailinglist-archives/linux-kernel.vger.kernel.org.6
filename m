Return-Path: <linux-kernel+bounces-431160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE089E39B0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF912164E41
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960341B87E4;
	Wed,  4 Dec 2024 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wM1/Jb56"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A21B3945
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314610; cv=none; b=NscfJhv23FubsS67JrWSw7SWu2ttdY26cy6c6MzR5P53chBJn7XI0m6wQBXlvax5B4CGUIH5pGFsu0uxegdkciNIapJ6gOfcumAue0fEbl4S/2HS0B724wB8uulZWLjte8sJ/Xqz3dmnD5Ul/1s8YXlj/o2pxVeIsuCX6Fhf69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314610; c=relaxed/simple;
	bh=KXAAx1ZKzifV7TLp8TeLj1Qr6IjBc4QuuslfgHre3LI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fLr4kOaJc6znbHWCZ23COvojf1XupOYGi8V+hV2cknRLsYDkacWkmRUEDL5U3kk3zAw/FNJENaBrSYXhY7C1niRhe63p0fopGk0SYoq2TIplPOI9OSx8kB0aSjwZZa4wJ/n0/okpqk34vJQLCty8Zybp4S24QGPmKs3AW3/4tas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wM1/Jb56; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434ab114753so57047935e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733314607; x=1733919407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsrlpBP8obJw6VCACGbPEH2Vr95rnfvemDgmT8o7KPQ=;
        b=wM1/Jb56h8rPS4wbamlYA7r66qiTvGUMsc821nkUl4hco9+jvXTIQvhiKZm0eDaPda
         //BxvK360WX8PYUafNUMTzMe1nOY1oo7SQGwsdqFLw4u7n/Bd4EzeLNudZPvRm1iH1gk
         tWIg16mNzqdFHVffAIv3T9GxnBAyr7vg/wUgtWiLOsZuL7HqqrngjGIkp1pnTuateuBA
         LQk3o/ZB7UYumnLYRm/tGU9csnpbxDha0iYfneBGNfOp+295u//mAEkkSwDDn6cBNKSx
         lg35S7ehPbox0TQ6oXCQzyv0yVHjubjhw3HF9Aw7HiWP/68oQSs8WDAZddC3O8gS0urH
         P3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314607; x=1733919407;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OsrlpBP8obJw6VCACGbPEH2Vr95rnfvemDgmT8o7KPQ=;
        b=X/yEqpH9t/aHKuPwHKWwyAV+mqXy5y64l4BAEya3xPeCoo7B5dGzb1H2hni9ackHDP
         G31u9RPpXQHCT53VyYzATX753HxUS3I1tnKt6eNO+T09tX08pMSDPulfcvXw+3Zpd8WC
         QG72Fb6ImM/xi6wF7NgfgVAidprKLlmbavVAERFFSbWZiJzzUgtGQdzm0W6/NyekOP9w
         AMP2/rykFUzZ3KMfi2CmabeyXwI0xYz8vxTg1oajYr/vK2ZVKtwcTsngfnpJswzVZUkS
         X1nLx8wlj2I85EE+8Z2CVGaFptP8eRQddcqUtFzhsYZjNeC83eA/IkMHYunrz6IDtrca
         eJjw==
X-Forwarded-Encrypted: i=1; AJvYcCXiJdceDMPt/4WjrSa52W547sYSKabm7J79Mi2oNiTQePP+f8FMpnfXOHo/cin/WgtNXVag/xSc/OQQMys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDXdr1mCyTek8Yl3ido/56936FJOMclK5cFuZCR33zBeJD6ds
	fwlWpfi821oCO8f8FWYKAiIo/23W4k1TBjloRAmgZzXAIKqvUvK6PPidsk+CMug=
X-Gm-Gg: ASbGnct8VXqaLXI0DdMeDE/DwgDvxOE/b6YEW/hzphYRWybPu3E7xwCShRuTRrntYWi
	ElJSFrzsfn12hX/evQhSnw9vEuFfamV1pNX2Bak+rQL7GtASST0E8PkwI1Q7pUFOy5SATOrJ972
	5sF1n5WiRhQLOX8lxOPGI/aZ5WqTqDAFjVbnO5OsaAoUy0/3HfkAs53IoIxjz9eyZ8L9nRmqXpp
	uMmRnFKoK4aE2kE3g1oF5BwE3XbkRG3xCjSADfwDJmIQLIzTK4MZHxMzogNYRx+2MOsT5GO2fBw
	4ATLei6PJqHEfcvMsIr9VtmH
X-Google-Smtp-Source: AGHT+IE2rtqMWa9+kZfR6jcHTdOC6kwhGO00zx/AmvAzhEp4BTAiotGeRPIG83pyVvpHpOaI0tu0Ow==
X-Received: by 2002:a05:6000:4713:b0:385:f5c4:b30d with SMTP id ffacd0b85a97d-385fd429ae3mr5535200f8f.39.1733314607498;
        Wed, 04 Dec 2024 04:16:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:740:b323:3531:5c75? ([2a01:e0a:982:cbb0:740:b323:3531:5c75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8badc9esm11882932f8f.39.2024.12.04.04.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:16:47 -0800 (PST)
Message-ID: <0c1f4e6a-a77b-46d1-b944-9eb47d66556d@linaro.org>
Date: Wed, 4 Dec 2024 13:16:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sdm845-db845c-navigation-mezzanine:
 fix ov7251 lane properties
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
 <20241204-topic-misc-dt-fixes-v1-2-6d320b6454e6@linaro.org>
 <vlvchjynnwvevr2raosrwggwmjd5bdrs5skbsztskmzxjjdg7v@6qkhrjyaxlsz>
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
In-Reply-To: <vlvchjynnwvevr2raosrwggwmjd5bdrs5skbsztskmzxjjdg7v@6qkhrjyaxlsz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/12/2024 12:05, Dmitry Baryshkov wrote:
> On Wed, Dec 04, 2024 at 11:56:54AM +0100, Neil Armstrong wrote:
>> Bindings documents data-lanes as a single entry with a separate
>> clock-lanes property, but DT uses 2 entries in data-lanes.
>>
>> This would suggest clock-lanes is missing, fix the DT using the
>> bindings example.
>>
>> This fixes:
>> sdm845-db845c-navigation-mezzanine.dtso: camera@60: port:endpoint:data-lanes: [0, 1] is too long
>> 	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>> index 0a87df806cafc8e726aacc07a772ca478d0ee3df..5a16f4c2b346b314af3d614266e1ca034057e643 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
>> @@ -115,7 +115,8 @@ camera@60 {
>>   
>>   		port {
>>   			ov7251_ep: endpoint {
>> -				data-lanes = <0 1>;
>> +				clock-lanes = <1>;
>> +				data-lanes = <0>;
> 
> Is it really this way or the other way around, clock = <0>, data = <1>?

No idea actually, on the schematics the lanes from the DB845 are :

CSI0_P/N -> OV7251_CSI3_LANE0_P/N -> MIPI_CSI3_LANE0_P -> SoC
and
CLKP/N -> OV7251_CSI3_CLK_P/N -> MIPI_CSI3_CLK_P/N -> SoC

So I assume the data-lane is 0, for clock-lane I just used
the example, but I found nothing in the code using those assignments

Neil

> 
>>   /*				remote-endpoint = <&csiphy3_ep>; */
>>   			};
>>   		};
>>
>> -- 
>> 2.34.1
>>
> 


