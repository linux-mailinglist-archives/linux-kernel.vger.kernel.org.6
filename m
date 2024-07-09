Return-Path: <linux-kernel+bounces-245466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C7C92B2DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5F81C22229
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBFF154420;
	Tue,  9 Jul 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSUXXadb"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B7A153838
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515519; cv=none; b=Uo3ZOfknCInL+8mRIHQajREqzKHYnZ5nhD4BWMOSJQ9MqCuovAddN3cPrFPky5YypriGZ41a0Lw3+DyhUmWMZAbMSSCHSsl4sFpx8INBeNg53k1a+UA4ccU9xOFpaaVUktmI3for1TDMW45a62adNY+0KOIUH98iJsT6zfyrykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515519; c=relaxed/simple;
	bh=cDG7LCeKdCrSa1DArvFTZVp1gNiidpnRzBdKIn9Z++w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sU+9ubb8xSSA9Vinj96mVbygnaA4peL8jyAWy4uvAHYt2K96wNvVOuLMIOjzh08i5Fh+XLHwYEDWd94Uj9L5JoqqQER4V9U9OVLZPfKSc/A3Nr3BlFYKm9McF45C8bMgQcZRn8qS2L9yjWhfOm4/a8qoXwb9zlGba3X1+qboWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PSUXXadb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e99060b41so5215717e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720515515; x=1721120315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5V/t+3meFrE06/A4Ix9ucw4QHhHNPHYbOa3q8Ar5d5w=;
        b=PSUXXadbPLxm32SmbyoaYQJ8HNdu7QAwj1vLUrHDSUji7ousXd5ofczGZ4ooiDrNDW
         3fP2v15eYx59Fj5Md05qcz2r7jdtaSWUyWVMXrc2COPtEtmcwm+6AHPVrwWVnoRxRUMK
         RqjbxNPY4lkiVdb7c+UVL4g12IRJVpJ8v6kNY6XnSnT3u6kDKr8op5KBSS/vtjPfL5jf
         6RgF4gWmyL5IfvXoGlaFdCrJ0itV9MIzWjS7XXF5Kz4liKz8vAq7PlCnSuyXsvvCVZap
         xIvwOeCnBCapvaur2k0WIr54iLSxrWXRI5bRzA94jzG3HKfx+QL9+HEWml02HYAQF7Wq
         ZhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720515515; x=1721120315;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5V/t+3meFrE06/A4Ix9ucw4QHhHNPHYbOa3q8Ar5d5w=;
        b=Z+hIQ0Eki1PlcEY1kylgWA/j3qx2+58l4TwGsTq6EwLp8JcwiKjPEJcquZaWjex/RF
         lnEWHBEc5NNwccUfPvCT4JZGZTVytG46v8PE0KNVaUbUQFML0XR9a4pedkrDHPLHimDF
         /FPyYKmhtbr3iCzDWSOfQE1hZ8QC+9XAXdEz+bPNR95KbRJdzFzdb8eQMxTEjyKbyG+y
         rZtxugzTGYH8iE8/eH+/fjQYfrhjtCGwi3Jl/tPVSbF92DUdm0Cn0afUI6i+01urttV/
         TxcvqPfaBn7JTog6tpV0770GYTQmwKdwKKRXgbuigBiTB0f0gqO3mBI1Le0/gJuwabk1
         iB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGgItDKUwaWUtV70ufBh64ts7/7dYDgHzpbzgFGaw9YMyeuyEgaEZz0GtFiMcj/E4BrCnn5DHjvSoqsqrmBPHTmLCezIiEi9K2O9zt
X-Gm-Message-State: AOJu0YwurjWoF1y9HJRF7kLSKjv6ZrO9i2wIO2V1AGfyd5I0QLRpEFpD
	3Z2XQrs/0/WqL1Rts50EEggiBM/6ebd7Op5PTt06NsOyVZpAd3doZGnvMU46a/o=
X-Google-Smtp-Source: AGHT+IG17y+9eHvBGXXOKoXsteB+mAkpljn2ulSXpM2ij/uchHhlZVAGoRmkKWpsanM/2V5dS5uvTQ==
X-Received: by 2002:a19:a414:0:b0:52d:582e:8093 with SMTP id 2adb3069b0e04-52eb9995541mr832557e87.23.1720515514583;
        Tue, 09 Jul 2024 01:58:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:b12a:8461:5e2a:dfe? ([2a01:e0a:cad:2140:b12a:8461:5e2a:dfe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7361b5sm31043765e9.29.2024.07.09.01.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 01:58:34 -0700 (PDT)
Message-ID: <595ae759-0d5c-4f46-bab2-91bf616acd5c@linaro.org>
Date: Tue, 9 Jul 2024 10:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] arm64: dts: amlogic: add watchdog node for A4 SoCs
To: xianwei.zhao@amlogic.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, Huqiang Qin <huqiang.qin@amlogic.com>
References: <20240709-a4-a5_watchdog-v1-0-2ae852e05ec2@amlogic.com>
 <20240709-a4-a5_watchdog-v1-2-2ae852e05ec2@amlogic.com>
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
In-Reply-To: <20240709-a4-a5_watchdog-v1-2-2ae852e05ec2@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2024 10:48, Xianwei Zhao via B4 Relay wrote:
> From: Huqiang Qin <huqiang.qin@amlogic.com>
> 
> Add watchdog device.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> index b6106ad4a072..496c3a2bcf25 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> @@ -52,6 +52,12 @@ apb: bus@fe000000 {
>   			#size-cells = <2>;
>   			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>   
> +			watchdog@2100 {
> +				compatible = "amlogic,a4-wdt", "amlogic,t7-wdt";
> +				reg = <0x0 0x2100 0x0 0x10>;
> +				clocks = <&xtal>;
> +			};
> +
>   			uart_b: serial@7a000 {
>   				compatible = "amlogic,a4-uart",
>   					     "amlogic,meson-s4-uart";
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

