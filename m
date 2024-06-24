Return-Path: <linux-kernel+bounces-226979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C049146A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BACA282002
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA145135A6F;
	Mon, 24 Jun 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pImmXOhd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D521353FF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222356; cv=none; b=fnHz1oNTxcXDAy9c+I26kZF9k8SRNgEKiZXVm8Rs/LjuGPujavtO3Z3GPG3SheSzWAJb0KCXcFZ0lrvTUmijwIduZF46v/NmoxHx+wk6kmc9R6323UuArH14f4avB/lY/LdpxJ3VOwEPBkLmSQggMj+94xSvWtN0nzJ2ifGZHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222356; c=relaxed/simple;
	bh=yj10UWg6ET8en8Pb0uVEg3MguJ2yuzhVyQcEX9nr6kc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c81W3NLXEJ8wCSpexZKS73N5HgtiR1ZtCR7bXmOOe5AELvK4Hry5nieBgX687DmKul5lD1pPmnMC8ymcjIBMXBNfVAJUpJuF83qpIePzHQqwcdh1ColSgoiQPk0ExOoxSgFY0zYN7cGAcqyUJQwl/mKRXPuwi8DCh69GI8nM0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pImmXOhd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42278f3aea4so34204005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719222353; x=1719827153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSpYP2Iym3bwarcuBRBNMRWDCe6BmBEhKzjcWG+ymbg=;
        b=pImmXOhduTCcEB/5V/BktZ8aAS9kRebttxvn16tvwdIVCNitqAMVcbZGM53pfWhBfc
         O9xkM99/yZGLR1VmDdvDEf4JlGuVH09mOiIME+6KgE8V25SpmFq/hLqSJVgqKBSJ30Kt
         SJoB192uFsnROuumZQQzmp61AyxTX0KFMvuN5tz9BIljG/WaJO86iGQTFX8VK6bzLkvG
         pJuct2sOq/1GgnnBPhLwpFx7RiO7E2wdrIvovGtundif+vbZaRoMz4PuWJiv88s1K6Z/
         Eoau/d/jlB0pOwOyJPm4E5fV3fDRqPltRntSY/lRmGHXvP4NwQDzOOHANT9/9+JnTzzH
         sFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719222353; x=1719827153;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xSpYP2Iym3bwarcuBRBNMRWDCe6BmBEhKzjcWG+ymbg=;
        b=DxsksF193fQ9woW1jvcnLk2p4qmOdD4IDIUVyZG1ZFzt6qxSkQmTeMDoWNsKm3GuUA
         +bJ36Co0fxgNSEklGMb4/3MqUMwGMyYik8MQQCcmfZW8wA3Gp2qLwgBb9IPdKw/nVFZl
         8N1/mLZ1r+fy8+RmgrJ3ZtMZTPKuVMIwzo5VKMDLtkeD8auwG5ENHcTNdMXW1ixG8k0l
         d2Z0dKAZpEykxGwrL86I3A6sG9S4V/hZHYJZkNY54bp3uPqzLePxIRbTzs517UYxUTlB
         aK3oybFz3Ch3XtB/mGnEtxQuqGAoh48Tzl5zGxxjC0OHEoLiFH2cDK7sawMtBqsndXY8
         iPOg==
X-Forwarded-Encrypted: i=1; AJvYcCVkq3U1LVA/LoF9nPYlsewbKC66uPHf6CIwVaS/r6E0OtjmZNtw4OFy3Z3W7jZPx76g1AhTZvrn6t+6XH+MvdJQE5s91yhpS8f0CIWo
X-Gm-Message-State: AOJu0YxwEGFw4cvPOBZ27D9z7pF5fNiGGarDOwoknC8jTqDNkOoMS38h
	73n8AmSFYCSNDWlw9c+GRuVFJXg9aurtLSSWP04oOr+x+s7doR9fNYQ2+1vd16M=
X-Google-Smtp-Source: AGHT+IHwmyNB9aKoz1MIv6/1l04rb0OspYjduoAUVUkNgENHzl/1WE4d0EqJCub9g86nEDKLZz6Q6Q==
X-Received: by 2002:a05:600c:2256:b0:424:9582:abf with SMTP id 5b1f17b1804b1-42495820dabmr8860815e9.26.1719222352479;
        Mon, 24 Jun 2024 02:45:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74? ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0bea05sm167078615e9.18.2024.06.24.02.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 02:45:52 -0700 (PDT)
Message-ID: <4c4c7840-917e-4d00-b8a4-b97a01ca2e6a@linaro.org>
Date: Mon, 24 Jun 2024 11:45:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: ad402: fix thermal zone node name
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240624-topic-amlogic-upstream-bindings-fixes-dts-round-2-v1-1-0a21f456eb8d@linaro.org>
 <1ad3429c-0bad-4662-bc9d-b912f88e7b3a@kernel.org>
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
In-Reply-To: <1ad3429c-0bad-4662-bc9d-b912f88e7b3a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2024 11:28, Krzysztof Kozlowski wrote:
> On 24/06/2024 10:59, Neil Armstrong wrote:
>> Fixes the following:
>> thermal-zones: 'soc_thermal' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
>>          from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
>>
>> Fixes: 593ab951232b ("arm64: dts: amlogic: ad402: setup thermal-zones")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
>> index 6883471a93b4..0d92f5253b64 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
>> @@ -86,7 +86,7 @@ vddio_1v8: regulator-vddio-1v8 {
>>   	};
>>   
>>   	thermal-zones {
>> -		soc_thermal: soc_thermal {
>> +		soc_thermal: soc-thermal {
> 
> I was fixing all underscores... but then mentioned above commit
> re-introduced them.

Sorry about that, I'm removing all dtbs check errors, so I'll be able to spot
this before merging anything now !

> 
> Some fixes need to be done more than once to stick. :)
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> >
> Best regards,
> Krzysztof
> 

Thanks,
Neil

