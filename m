Return-Path: <linux-kernel+bounces-354663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F7A9940B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4153B28455D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5F1DED62;
	Tue,  8 Oct 2024 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c81k6ZFE"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02923A0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372385; cv=none; b=H8iBiKvgeMcar7xFHC2Pb88/WBG7VELu5QQqyj6tgel4UDa7UYnVMMgt3WjEf2DGV+9BfI6MNrIcngWcPbWbzhEUfu7NUbLPOVWQOUJFYQ9hQ41dXQc8l7FkNUVes//ChG33bpfykKedtunmUwpwd9sEb+aXZ6SQ/ftJc299e3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372385; c=relaxed/simple;
	bh=YDulYG3j3Eeybv4/71XyZnv7MUvuCj1KoMSungfbKzo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dZx46771PVIJjLgXThgmaLuITTRubLJy8IVb4bm9WMmot8dBq7VxTW8n8vBDFFv9PRplvUupGDRXM4OsztpOyHDbww2hgghywhNSo66oZZCh63ld8M6z1ojQUijgKTSKSXbZKUisNkVp83srP3vJnmK0ytEiQK+iRiWuKnhh280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c81k6ZFE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ccc600466so2667340f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728372382; x=1728977182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tde6naARiuFB2gj8gABk4yLz1i061Dy0b7ny+fgB1AI=;
        b=c81k6ZFEfdrX8Lgbp/u1Gmgodozj37azSFUaiJ7M3L6qBG6N1ZzWkDr4Yx6cExJ5uo
         w09ZwmjDVFTTWkjdQXABXNy7SullHHcN5C3Squa48kC41+ofvDsyb7oTua6Rs0Ykf8/S
         RTGRIgOvPNopFpR6b9QG9QY1s4OUI1Ev+dIPZrZcmPIU/lYyEeh6hIrEtPOeJ9jqoyfD
         dtkORHYyi7Fon/yyZLDxc9YgAVrQKQsQNG8YAxtR8ZKEHjNZfgEeUFDO3KTRKQEBZy1h
         hxLpOFlFZmeJ34omq8tf92wN1Uzwhc71ZIVAzRkjs9B7pirGZ2oSYJ35ZN5R/xJoIc44
         iXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372382; x=1728977182;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tde6naARiuFB2gj8gABk4yLz1i061Dy0b7ny+fgB1AI=;
        b=VACFZWug7RlCbM5X3wfk5rMm/3cE0G7t+ojmiLBeWfp/4OAnz3h4pzSOA3Suvemldf
         wIBTLn4r/yAPQp6cwNqRKnSd1Log6BIIjwelny5FELmkynIqArCt89IstV+cCIKmzCB8
         OLRUngg7s2FguT6VRrn6i7WqajukMjZ0cCQ91XcWIl6YfJ+TLkojDi0yYwuBN1N38PHU
         FQDDJbNtpNbcsta19qzWAVpOnKDHPKk5r3xvnJqDaNPZUkAg2qrhrjVshasmXtsuceml
         Vd0SGtiLW2Rg4KK1vQ3zgJRGdECr+u4X3eVAiLQicb+FrNZND+M5GCi1+UFrTizdYcVM
         JG9g==
X-Forwarded-Encrypted: i=1; AJvYcCUtzstUdX2QT78vVdZu9wrsshRtN89Rxwn9Snv1FK5Z+hV4DVE7cq7e3AIp4hVws4EgJoJ7mBosS8/e3Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEsY6GxoYrtVit6HtmfKmdCN9pQi6ZtnM+QAfc9wfkUu0yVxX6
	a8JTaiWC4888k7XG6iacMKNwuzUDLFVZ4zpITWS9WW7ZWcjJUO73BCs/RcMJr50=
X-Google-Smtp-Source: AGHT+IGFT9Rs5w4u61S51MLKNuVCCfuA33nAIecdHnPzSR0BOYT1oFGdenXpd4JxBOZV/8fyyDDrnA==
X-Received: by 2002:a5d:47ae:0:b0:37d:3173:e018 with SMTP id ffacd0b85a97d-37d3173e40cmr543467f8f.40.1728372381784;
        Tue, 08 Oct 2024 00:26:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19? ([2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e9b6sm7391552f8f.76.2024.10.08.00.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:26:21 -0700 (PDT)
Message-ID: <2e3f719c-82e8-4d95-b159-c8c31dec4293@linaro.org>
Date: Tue, 8 Oct 2024 09:26:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl: Document
 the System Control registers found on early Meson SoC
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-hhi-sysctrl-meson8-v1-1-896b24e6c3c8@linaro.org>
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
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-hhi-sysctrl-meson8-v1-1-896b24e6c3c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jerome,

On 07/10/2024 16:09, Neil Armstrong wrote:
> The early Amlogic SoCs also has a System Control registers register set,
> document it in the amlogic,meson-gx-hhi-sysctrl now the clock controller
> has been converted to yaml dt-schema.

Could you take it via the meson-clk tree since the amlogic,meson8-clkc.yaml dependency is in it ?

Thanks,
Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   .../bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
> index c6bce40946d4..3dc66f1de023 100644
> --- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
> @@ -13,6 +13,7 @@ properties:
>     compatible:
>       items:
>         - enum:
> +          - amlogic,meson-hhi-sysctrl
>             - amlogic,meson-gx-hhi-sysctrl
>             - amlogic,meson-gx-ao-sysctrl
>             - amlogic,meson-axg-hhi-sysctrl
> @@ -36,6 +37,19 @@ properties:
>       type: object
>   
>   allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amlogic,meson-hhi-sysctrl
> +    then:
> +      properties:
> +        clock-controller:
> +          $ref: /schemas/clock/amlogic,meson8-clkc.yaml#
> +
> +        pinctrl: false
> +        phy: false
> +
>     - if:
>         properties:
>           compatible:
> 
> ---
> base-commit: 2e99ba3e918f5f1a987c86e559fe8f14d9c4048c
> change-id: 20241007-topic-amlogic-arm32-upstream-bindings-fixes-hhi-sysctrl-meson8-158da98bee95
> 
> Best regards,


