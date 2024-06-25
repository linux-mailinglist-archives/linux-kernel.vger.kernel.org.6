Return-Path: <linux-kernel+bounces-228648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E8E916441
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370741C227FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6431C14A61B;
	Tue, 25 Jun 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EXCPIaQI"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BA14A60C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309316; cv=none; b=FzLgCOx+v5RFg2mwe7inqNWrGxQ+xM9cXWCJP4vAylTX9LVnOgnAJZOb4V7VNJVxpYIAWf+vbfERtZdVCcrs9sYq0RVJP/bWN5ADG/pTYQ1YlSPwX1OiOTPiH+2Ztfqwsorv6sMe6lneAIdQf3UAbzNebpRaIN5V6aN5reDrX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309316; c=relaxed/simple;
	bh=QifjxGOTD6YmbzK6tF1G/6UDoDPfpn9s2Ye+w9Qa+bY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KqMHMKLEEX3hM601Sg8uW1dhe/vEPOfc2IPbv0k+EGMfA+lkbLIQwhoSzDLLwFsLnMnkcIAcp5G1d08yrplY9RJYGojQqTWTwCYwSl7RcYrXs7in7gbXrFXT0AYzy36T8rp+dkveTFTBdHMwBbsJppwfFyv/HgMErNNlXC3yVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EXCPIaQI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so59790301fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719309313; x=1719914113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kECwLGxqId1Ov65xGDMi5MpX17DgpZQ+tjYQbJXb13M=;
        b=EXCPIaQI+PeTknmbvvR9ZbjjXXCNJfeLng8145FRTKzyGfXEfsrSfacQld7nowfRxv
         pXdiko5Nbd9p9/1hmEiy37nFhb5w6hesJ4YwcM7jV8pe22kUWJ+jfTX5fRG9N7VV07LG
         afcJUbBhxYIibjT/tTx1hoy3c99nJZwjiEdPNaOTP1Fa5sdBEMlzVTekSlBRdQwI4K5P
         xWKduk1H3upYIIpJZfmuPLjLORIKiXlIT1dV+eYiAtfb4Q2X+diBQFgMp0qyhevBSBGO
         e+RF3WdH/EsGXuCXw8/75MWx24Fp88/Tn4TrD3FuJZkevTtGHy0XZc/Jp2kgVHXzUQqd
         tuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719309313; x=1719914113;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kECwLGxqId1Ov65xGDMi5MpX17DgpZQ+tjYQbJXb13M=;
        b=NYV4weLtyCXI2bmnzce8Ch1bMUZxTHdYmA6kSDxMunKTiBEr4+jsDFX/QKryi1HmrR
         JymKfYrMUR8O/HDh1XZ7+vMHQTiXaFswdWi/K1UfFBGFEZoEcROsABJyiTCoRSPgeTei
         Z9AxCVG9L+LmAgUEXQ4K/lgQwZNn8ZM/fCy2tem8GWpLosorWPb086+kXa2i5jceumOD
         RlejBRjGDPUw+Ke2bpNpmZ4NxBr17n2B13nW2NjVcn2TiE6BvISOUKxbFDP5ndUR1oiK
         C3GqLaEeHVmD2j8R6SaNU040TRh/y6OT62Q40yJGZxXeHwYkRFOtWEqZRvV0AZWUYx27
         T5hg==
X-Forwarded-Encrypted: i=1; AJvYcCVlBZj7YREuHdqVTp4JWYmsHIZdMXOzymR/iMEvu6MoUmetJ9NkHSe8FQrehLPH7JajSZKOKDddYBQuFh0cSfcrIPpp6+KesKd2I4Cu
X-Gm-Message-State: AOJu0YwATgbf9Abz9AHxlaeuQ8hjFe6R7zUnFuaNA0IHw+k45Jvwhofw
	H9zEt0adxvKrAlv0MuDVRVPapyCQGt/LgQfXmkcil/B0SmsgaCKYWAFCbTxe8Sk=
X-Google-Smtp-Source: AGHT+IFMwMhvOphtvO8C5EwWqvnT9WcF0/GsSlyeQT++HVrdddjTsK1XMZKeXdCDezbgFmejez8wQg==
X-Received: by 2002:a2e:2d12:0:b0:2ec:3180:d4f7 with SMTP id 38308e7fff4ca-2ec5b3460f7mr36941741fa.26.1719309312317;
        Tue, 25 Jun 2024 02:55:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bd71:2ff1:592d:f52a? ([2a01:e0a:982:cbb0:bd71:2ff1:592d:f52a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817b53f2sm172394305e9.25.2024.06.25.02.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:55:11 -0700 (PDT)
Message-ID: <ac0216ae-22c1-459e-829d-80233dd1b586@linaro.org>
Date: Tue, 25 Jun 2024 11:55:10 +0200
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
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240624-topic-amlogic-upstream-bindings-fixes-dts-round-2-v1-1-0a21f456eb8d@linaro.org>
 <1ad3429c-0bad-4662-bc9d-b912f88e7b3a@kernel.org>
 <4c4c7840-917e-4d00-b8a4-b97a01ca2e6a@linaro.org>
 <20240625095210.mnwer2d3bc5wkits@CAB-WSD-L081021>
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
In-Reply-To: <20240625095210.mnwer2d3bc5wkits@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2024 11:53, Dmitry Rokosov wrote:
> Hello Neil and Krzysztof,
> 
> Before posting any commit I've running dt_binding_check and dtbs_check.
> Which target should highlight the errors like mentioned in this fix?
> Please advise what I'm doing wrong.
> 
> My commands:
> 
> $ /usr/bin/make ARCH=arm64 INSTALL_MOD_PATH=$ROOT/out/$TARGET/target CROSS_COMPILE="$ROOT/out/$TARGET/host/bin/aarch64-buildroot-linux-gnu-" DEPMOD=$ROOT/out/$TARGET/host/sbin/depmod INSTALL_MOD_STRIP=1 -C $ROOT/out/$TARGET/build/linux-custom dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/example_device.yaml
> $ /usr/bin/make ARCH=arm64 INSTALL_MOD_PATH=$ROOT/out/$TARGET/target CROSS_COMPILE="$ROOT/out/$TARGET/host/bin/aarch64-buildroot-linux-gnu-" DEPMOD=$ROOT/out/$TARGET/host/sbin/depmod INSTALL_MOD_STRIP=1 -C $ROOT/out/$TARGET/build/linux-custom dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/example_device.yaml

Thus should work, but I use:
make ARCH=arm64 DTBS_CHECK=y $(cd arch/arm64/boot/dts; find amlogic/ -name "*.dts" | sed "s/dts/dtb/")

to only check amlogic dtbs.

Neil

> 
> On Mon, Jun 24, 2024 at 11:45:51AM +0200, Neil Armstrong wrote:
>> On 24/06/2024 11:28, Krzysztof Kozlowski wrote:
>>> On 24/06/2024 10:59, Neil Armstrong wrote:
>>>> Fixes the following:
>>>> thermal-zones: 'soc_thermal' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
>>>>           from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
>>>>
>>>> Fixes: 593ab951232b ("arm64: dts: amlogic: ad402: setup thermal-zones")
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
>>>> index 6883471a93b4..0d92f5253b64 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
>>>> @@ -86,7 +86,7 @@ vddio_1v8: regulator-vddio-1v8 {
>>>>    	};
>>>>    	thermal-zones {
>>>> -		soc_thermal: soc_thermal {
>>>> +		soc_thermal: soc-thermal {
>>>
>>> I was fixing all underscores... but then mentioned above commit
>>> re-introduced them.
>>
>> Sorry about that, I'm removing all dtbs check errors, so I'll be able to spot
>> this before merging anything now !
>>
>>>
>>> Some fixes need to be done more than once to stick. :)
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> >
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Thanks,
>> Neil
> 


