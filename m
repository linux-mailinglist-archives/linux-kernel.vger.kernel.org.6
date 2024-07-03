Return-Path: <linux-kernel+bounces-239010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13759254D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E1628CACD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32625137911;
	Wed,  3 Jul 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K46qRXMY"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CE2C879
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992536; cv=none; b=d2DR+JqlVUOfGYn5B89VhQoGKUpsQmsoF53OqTGGSCHklNN/tS0YvVgxTEtIXsw0qb4dqILX3A87GmIesjB+vZlNQQqOAk/GP/P4sv30w3wc3hqOwqd4DXDCPP+IKGoD9Ko1fFRFq0EY3mrkxriBl5ncQ8jNfsXsXr8zeTnVCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992536; c=relaxed/simple;
	bh=JjpR/zi9Yb1mSVMWaZ74RpK0MTrr1DdxMiOgX0twqnU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kIaPa+MaRBOJiGmh02ORgVVF/eyQskC9uT9CaMlkX8Tatq4c4wTX7AzCWKfT6WUKkscjKvA6SL8LlN0lZuIzz16fywMTulFeRxgyamU5ezwV4hpZrXosm7pinA+ejals1w6fyOWGevYsegB7EWg2XlNrhprshnSRykQ7ssiTET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K46qRXMY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so531009a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719992533; x=1720597333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tckfhFsEzLxO/FzhYuzYJZ7ZTtG1l9RlDBa9ctPpP/I=;
        b=K46qRXMYXSJUz4U4NaEQYd4GDPftBpLZOng0t5HO9l1WAaVKqiD2kTysGbhZpKX9YR
         d8+Fue58ovLn9zmR72iH0Patcbc2C+gewhD3f5rWEhcGDiAveQKfyhUiXcgGy7vb3Wbg
         5yAIZd/mUza7rkI9uyYZf8AcUKm/h6/bY3lNbNE0mOLng1n5AZpOFpMlZ7R7R7080tsk
         B7RCyf/9t1OW+KeheHephEyaRMKuoqlktua2ccp7GMHZ+DbimxXKs1V58HjZkuPtsVVX
         LjZUBdv25pGk4uF2UYADltCuocVo2J0XptwHGw5eiJHUKt4sx8JKk4xj9Tq2g0pZNGPc
         Fulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719992533; x=1720597333;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tckfhFsEzLxO/FzhYuzYJZ7ZTtG1l9RlDBa9ctPpP/I=;
        b=t4fPlbtDEqaDQDuY2zP3YiU8ehJJ14x5yRuaiLc420nnhuL2ktjQ/j06wQPyv8aW7X
         fFkkuVcqUStJvklhBUlMMA4+wI/TLDO54GQ6wzyMYw8QfDQkaLnUm0eBEC6LHmonWTL1
         8MZgWFknoJVD/OewYPW4+qaGjr68Cm5HaTpluJKL6V/P/wsbwOzeIM+fOlYyQ7hK48dt
         tc579O9vR9McfH6Q0dDCVamlDe8O1er+9EaKGzgdaxgSKXh43ZOKV11t9g2bpCcaVNF/
         XBewe8CuT34t+q6TGWs+eO2qwgKUl9JBnRapY8rrDdaT7+6rUQb0SwMES9p9f32n5qya
         ew+w==
X-Gm-Message-State: AOJu0YyBvKPHBGTU2n+OzkgKj3qYoT/dBBxPz9+SYtnxV97L+2xR1bd5
	xnQQOD+OdSM3LTQHbBaFrqON/2vfYH+d+8XUDQtidlK+wnDurmB4pTwVKp/jvIl+zASPvkKK/Fm
	67hQ=
X-Google-Smtp-Source: AGHT+IHBUXWvsQ+ZR0ipa89q0bV9qFwUW3amlH2ftgxHpU+HMJ25ZuKckN072GiRs/lu6I378XGvWQ==
X-Received: by 2002:a05:6402:13d2:b0:57c:bec1:ff4b with SMTP id 4fb4d7f45d1cf-58ce525f4e4mr773812a12.10.1719992532776;
        Wed, 03 Jul 2024 00:42:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ef03:73b5:7503:ee71? ([2a01:e0a:982:cbb0:ef03:73b5:7503:ee71])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614f3d4c4sm6697063a12.87.2024.07.03.00.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 00:42:12 -0700 (PDT)
Message-ID: <eea2d957-fb4d-4ede-9789-d1e24ef1663a@linaro.org>
Date: Wed, 3 Jul 2024 09:42:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic A4/A5 Reset Controller
To: zelong dong <zelong.dong@amlogic.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>,
 Rob Herring <robh@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 kelvin.zhang@amlogic.com
References: <20240703061610.37217-1-zelong.dong@amlogic.com>
 <20240703061610.37217-2-zelong.dong@amlogic.com>
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
In-Reply-To: <20240703061610.37217-2-zelong.dong@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 08:16, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add new compatible and DT bindings for Amlogic A4/A5 Reset Controller
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> ---
>   .../bindings/reset/amlogic,meson-reset.yaml   | 22 +++++++++++++------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> index f0c6c0df0ce3..80345af81d5a 100644
> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> @@ -12,13 +12,21 @@ maintainers:
>   
>   properties:
>     compatible:
> -    enum:
> -      - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
> -      - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
> -      - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
> -      - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
> -      - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
> -      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
> +              - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
> +              - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
> +              - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
> +              - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
> +              - amlogic,t7-reset
> +      - items:
> +          - enum:
> +              - amlogic,a4-reset
> +              - amlogic,a5-reset
> +              - amlogic,c3-reset
> +          - const: amlogic,meson-s4-reset

Here you're changing bindings for amlogic,c3-reset, move it in the other enum list.

Neil

>   
>     reg:
>       maxItems: 1


