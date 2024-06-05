Return-Path: <linux-kernel+bounces-202658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368768FCF3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308D51C22A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231931C7D9A;
	Wed,  5 Jun 2024 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwrRvdjE"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E78192B6E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591884; cv=none; b=JlrgvFlJh0v0wh+Wo68ggEkp2Z3bv7OUEFqd2mX72V7jGegzejtdy5G2ce+ow4gLNThd5pQ9IYJIZRt7wzOU4xmCDU18ZgOHGV9KppUfkEEg40nK4eUvnJD+5H+xA4HPq+RoSSj3PzkKqiLvM2ZreK+sURi37HIl09GbsVgptXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591884; c=relaxed/simple;
	bh=s4tQuO4gtb9mHIPiOUcfl3LW8/+TfAROs1Fqm267Lv0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S2g+hINcE2QpoP9zHTtTp3zhDLLLZcQjr/wOph4Xn09jVQ65ASIXUKVEtWfBWXkffce9wWJCZ0NeaFq5abHXw296Yt1CwgOrlXHT5NvsaOoBijrqed3/tVTIZq/nHrBS0vIHkBBklIrRFH9r5m/oe5TyzzICxx3OXyCVvDGG+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WwrRvdjE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421208c97a2so59371105e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717591880; x=1718196680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMSsD26Ds19NUWWhG41b+9GiSlFb7bQY+XAl878iz7M=;
        b=WwrRvdjEnmcRp7Dc0WKwQAwGnw2k69bfNoZ7JEI0O82pvGgfslPFOfjBD3wV+bz9V3
         i2zoPBeVPLyHy3bfoPViwQTZ6TWHaEmWZ3S4ovV5gsMR3ZHpydt+2r2v65+6hrBtiSgb
         9lO06EVn6ImZ5UKMgsp8VLxPEl41tzcEvz5UPKRB2JoyDU15QwT0Dn+s7acAgwzyV49P
         NDazMX913UAE5piUF5b6SxyhkTr92pl6sMkZkNP/ZlO779sMcIsybgZcnCHdqdsChNFJ
         1M++tEbJY0uFCVnwxN1yfhpVhPiDx2ISBVCw2VrFl8a5hXOLEZbY/7lAD6wiRKfvoUdC
         yrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717591880; x=1718196680;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kMSsD26Ds19NUWWhG41b+9GiSlFb7bQY+XAl878iz7M=;
        b=cMpqKr5HTLj0cJqeauQVk0j2bJHT+cTvSwhp6H4us5/k0vT9XKmekNDunhD7J+HMSn
         LInX2K5zomrgDFfZ9feT2K8rAZG5/4rarGue6zrRAyN1M0Nd4eogjCU/Gu2j/5S6fPrE
         xWes6QodP815r9uQff7p2lA6DMjbmCssnFC36SbQJYCEpy53YeMpw/pCvEI53IvWylcl
         ntE6EF1mp1c3S3Yqdmi3FNlER9larKKqtlMS1PCHuDZoEXUTLARmNp/Wf7Ib4IN5CNEJ
         RGZEP65HM8ZN6PsDmnZlyU/ZBtoX3mCJJZtGp9H0Eb7T7YQaTJv3QVQRIcThI16kQzJp
         5lGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/9e0CBkvL/kjrRr4U4SwuuRabQLSNx1KX4IiiatuLj972dFDgYPwm1UEN6Lo6ZEEX2vJA7wJtKq52U3dF5Dj/I2rpmkNz73tgLyv6
X-Gm-Message-State: AOJu0Yzx3/W3RukwPTsF0+BOKo0UFD7GWlAssCbu/GrR354n5M77vWKL
	SJq4tIXqB38s+9oXSu5EOrUX/VvH+rznGF9rxtWI39TJA/0Hj6aBHrUoOpTAOug=
X-Google-Smtp-Source: AGHT+IEdw+NjPUC8CNFC2C1Mb6/XwSgh65Ld06+qd5VCa43rwmvBu3mF0pQgK9qPPHf23DP2Q0bRvQ==
X-Received: by 2002:a05:600c:4f0f:b0:421:2a43:6518 with SMTP id 5b1f17b1804b1-4215634cc35mr17452075e9.33.1717591879545;
        Wed, 05 Jun 2024 05:51:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c7ce:7756:462d:a8bd? ([2a01:e0a:982:cbb0:c7ce:7756:462d:a8bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f0besm21458115e9.43.2024.06.05.05.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 05:51:19 -0700 (PDT)
Message-ID: <c11bfe7e-e917-4ecd-ab2c-548332a4d22d@linaro.org>
Date: Wed, 5 Jun 2024 14:51:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/3] Add support for Amlogic T7 reset controller
To: kelvin.zhang@amlogic.com, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
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
In-Reply-To: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philipp,

On 22/04/2024 13:11, Kelvin Zhang via B4 Relay wrote:
> Add a new compatible and device node for Amlogic T7 reset controller.
> And modify the driver accordingly.
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
> Changes in v2:
> - Drop the compatible comment in dt-binding.
> - Move t7-reset.h to arch/arm64/boot/dts/amlogic.
> - Link to v1: https://lore.kernel.org/r/20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com
> 
> ---
> Zelong Dong (3):
>        dt-bindings: reset: Add Amlogic T7 reset controller
>        reset: reset-meson: Add support for Amlogic T7 SoC reset controller
>        arm64: dts: amlogic: Add Amlogic T7 reset controller
> 
>   .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
>   arch/arm64/boot/dts/amlogic/amlogic-t7-reset.h     | 197 +++++++++++++++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |   7 +

I applied the DT change, could you pick the bindings & driver change ?

Thanks,
Neil

>   drivers/reset/reset-meson.c                        |   6 +
>   4 files changed, 211 insertions(+)
> ---
> base-commit: f529a6d274b3b8c75899e949649d231298f30a32
> change-id: 20240329-t7-reset-f87e8346fadb
> 
> Best regards,


