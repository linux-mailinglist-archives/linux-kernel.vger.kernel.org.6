Return-Path: <linux-kernel+bounces-245491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA592B341
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5301528392C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED941154434;
	Tue,  9 Jul 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSAuVL+e"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999EC7BAE3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516145; cv=none; b=JMNY4p8hJNf9IX4uoiXZDiobbITQFWXzI4EPvQS1mfoPZIrXbg/m/fCr/c/7qSEXbL1LYMOT3JAIl8RxX/QTfzmI45nXf+DFyd+gRyJbe3oVYckDnoXhUTcwOjyoNwdJlsSS/TWCg0Ayna0POgloXWACNWpBiPUZ/F1LFZGSD/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516145; c=relaxed/simple;
	bh=RQl3Dx44zpwGckcLP/FAebolV6ENhLYmDAM6cokmF3Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=g5bpYtfVUOUo2O796qVg6huq0jD5HrYXqW8sQSunCL/OBZ+Xy6wjDOjcbG9xaDjCebi9xbghWqJiUtIk7gQ++xQfLXyRk3QD3W5xAuq6AKm2pRqAryPeHBde5Wt8JS+vmSF2Sv/ww8q7eEbyDjjM0vlZEo5t2PoRrbG22nlVvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSAuVL+e; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-426526d30aaso26899165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720516141; x=1721120941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8d4w2O1nIUn5g/QRXw3npjVaRdNRoF0bZlM3zD4qDkE=;
        b=sSAuVL+e5MO4x5yuuLobCjteimewe/kEFW96f/fJj+U0AkOGdukG1e19vLGUw7dRe4
         Jim43sPPIX9xSFxhNYbH5NaRIeegiwmwBa+B8FeW+Fi06CfebmDtuhw9BPiEDqRubgxk
         q+MJzqNabjknP61EyjVAZgWb7IvFq8Q+F79JZYn6yyjgVWkAtfhLrYvJpmGWUlSFaioT
         5OqczkOjvqTZMcZ7dcriD53PKL5Cfk7nREQ+mA7KLsErCLBMOrGzJt/8/EKZkJ9mEi4K
         E8C91iN+WKeQfpqkq4Z4rcBTWQczNaDbwnidy/8NwP7o71lJW6NUPtMd8UqGdl+GZi/s
         V1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720516141; x=1721120941;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8d4w2O1nIUn5g/QRXw3npjVaRdNRoF0bZlM3zD4qDkE=;
        b=rcAWm76URQOlIKHHyOgDork06eEVs9VDhz9jVQQmcvZlpsrFPs3WXenC1JFY2I8ruD
         9HofnMGTDJS+KB+epyyhHW5kvvSNZGCt2/wOSqBFvOrr2hEZptvjjWKtKpTf3rbv/Syv
         zT1tbudFxuxni2rx9nVqUoYzEvRfSO5E/COP1gCIl+L4KsAAxXZCjxosFF5YtQLf10dz
         zhHfvef232hE7GHmMqv6P+/ifEuzYVZWGlIDZz8bt39nSnpPmIbMlrTuvhWSm4mUA130
         iQmGM9HHim25efRlejf1Pb62slgGNrEork+DBh5hkANIAU/Zkm+FdsCEyxMYh1IIjxGp
         OwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd+azAUjoGQ/qEanxJhDSiH8ci7m0L3jq+4FfODZRMgi9WWBFXjwXDt1m/dKiAvejlKvl3s+l60k3zLTx96wlVdFxUy12wiNhTUAjF
X-Gm-Message-State: AOJu0YzOiKshFcZesFbW0zjI0XsWpRIyAZ7FX5Bv8BZ/mrKsKgukai+9
	nIS4yDW1JohFgdhewAaeGVzdkEDWHKu7FCd2oe2lzssQ7zLnMhMpkMuDeLQB/Nw=
X-Google-Smtp-Source: AGHT+IFnE7Mlu/oA2xNs5yh5b3FAv23ZbeyVRI55U9NKiyV8/hCQ0+rhzKBcB/0jJITeoPaLM7W3Gw==
X-Received: by 2002:a5d:564a:0:b0:367:8811:5e3c with SMTP id ffacd0b85a97d-367cea6b768mr1343767f8f.20.1720516140977;
        Tue, 09 Jul 2024 02:09:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:b12a:8461:5e2a:dfe? ([2a01:e0a:cad:2140:b12a:8461:5e2a:dfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7df3dsm1953886f8f.16.2024.07.09.02.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 02:09:00 -0700 (PDT)
Message-ID: <570c715d-4f20-4c3e-8341-627ee975fd77@linaro.org>
Date: Tue, 9 Jul 2024 11:08:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] ARM: dts: amlogic: meson8b-ec100: align GPIO keys node
 name with bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240701165210.578817-1-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240701165210.578817-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2024 18:52, Krzysztof Kozlowski wrote:
> Bindings expect the GPIO keys node names to follow certain pattern, see
> dtbs_check warnings:
> 
>    meson8b-ec100.dtb: gpio-keys: '#address-cells', '#size-cells' do not match any of the regexes: '^(button|event|key|switch|(button|event|key|switch)...
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/amlogic/meson8b-ec100.dts | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/amlogic/meson8b-ec100.dts b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
> index 3da47349eaaf..49890eb12781 100644
> --- a/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
> +++ b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
> @@ -34,8 +34,6 @@ emmc_pwrseq: emmc-pwrseq {
>   
>   	gpio-keys {
>   		compatible = "gpio-keys-polled";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>   		poll-interval = <100>;
>   
>   		pal-switch {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

