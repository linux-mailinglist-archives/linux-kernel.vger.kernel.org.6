Return-Path: <linux-kernel+bounces-232307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5FD91A69E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8942828F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D5715ECF5;
	Thu, 27 Jun 2024 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSjMZhra"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102F15E5DB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491595; cv=none; b=tpjwBvrn6MpMNn62zAEq7EWMIBAj76cdGSXIhwmSyMEHtA+7SWCaXcXZD9Lr1ApbT93EsYhpg//TDLmPW9J1t6VYK4r8virXWKpypRnDE25FLrjhH08XOQLj2TMzMMvhbBMDIAR6YXfRU6GI+7twMWJPKB7+pCsEmZAsMH9oxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491595; c=relaxed/simple;
	bh=rKImNuNyP0kUWfD10+YakRIi9Im2VwsKi4y6b22VpIg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=CWp/ZRKRTI6Ao69pjcNokl1LMdn1bRL10rAtwCd76VXyQO4pC4JH8SGYzNx1/vvzd7qPrIjeKOeiERlOFOrlhDb0yePo6TRTOEGYNAhLPMDiEbvPX9OxZAiO76Yd04Bb+tzom3KkGchIrKeKqRWgeULTUh9WZmVKi5LYBgd2MK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KSjMZhra; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4248e28de9eso40585585e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719491592; x=1720096392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsUYI8ZdgTNmZjR3ci5nVBsqVIiuWb+7e/emhFAHzOc=;
        b=KSjMZhrasCwE8wALo6ZsNOqMHEczoEoPp8G5gvS0DsL3NV4kg2Ipnz+fYT6jStySq6
         rzMNyjQ/Em6I8dE7xcMjSZJELcPYa3jgOSaoJqyHP+gRr4ySKlAfGGvghyjUiTYBWWvv
         zn5qABBHkMl+QkxfSwDUPLRiSYHVuOs9ibx2vMe57nGdi3dweBlKkHzTERm1jK2lXJr0
         UbFeBKoBaSgJL9Y5zIReY25XwI9QXFRSD8Mlg6v6BOGzWciFrQ10kJH89jFZuY5Aqv9p
         SNmgIGxshU2d7k9hkS3JQ5q5Ni9NzaJYEAPUPzLfGQrVlQYBbQz5Y3ciOmPRMxZMLs31
         uzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719491592; x=1720096392;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DsUYI8ZdgTNmZjR3ci5nVBsqVIiuWb+7e/emhFAHzOc=;
        b=JoFlrxopYB5VCQ4s5X15nuYI9n0aNK2Lp2v0F2JCuOcgYBiMbSIn/eWeRkSDVfZg/W
         Z6yMPAdbm2S2hh1GA4CGpA5nKoz+rFBvLniNyAgS1QDL/cAA7cKWsTAnU7uQF8KWgLOx
         NOQzoicUIbx/NiyjDLK1sCkUnQ0OsVE5UWScNzIdnLjpZ8OTgM0YYahBIRVefJ1jZVtN
         rbLPF1xAmF6STYtKD1AmrYneOnQogDk+nQ+3Ke4Lxxph7OHuoWt/h+GZBjNuVfZLFkr/
         46ooKFufjpJ8+RsDr0959vcBDxKVa1wyFNSeql3ILhsG4V/vkeeHZA73wLqCMXXLwM9x
         J2/w==
X-Forwarded-Encrypted: i=1; AJvYcCW+4ROhGAfLmkFrHoZA+1xNcMGzQFB+I8t0pFnnk4mEyHwTXpVOwCp3iIdavfe89vIJDlUFdJLg9y742RcCJFKSqG0Z5AzSBHwximdB
X-Gm-Message-State: AOJu0YxY/6N+GO5v1uwCIfjsjz3tLlCsCzy3Gcvk6z8FDkT2bJjsSHiU
	R445ZKA4B0MKlh33dfXxXykhpv3y1fzHZr4zQfqA6fakfFnK1qGzmnlyls95IBMQ5Eo0490HQ/g
	LYns=
X-Google-Smtp-Source: AGHT+IGVkUw6MyHynhoz12govxVzmDm7rLZL+1VOOWb5KCDHRNDLFRSo4bzE5gM3iWckNvaVBv1eIQ==
X-Received: by 2002:a05:600c:3ca5:b0:424:9023:a7f1 with SMTP id 5b1f17b1804b1-4249023a855mr78213105e9.25.1719491591329;
        Thu, 27 Jun 2024 05:33:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:feeb:faed:66fa:9e6a? ([2a01:e0a:982:cbb0:feeb:faed:66fa:9e6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b7d1b3sm25263495e9.26.2024.06.27.05.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 05:33:10 -0700 (PDT)
Message-ID: <c448c177-e4df-4c9c-8c6b-788d1b55e0f4@linaro.org>
Date: Thu, 27 Jun 2024 14:33:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8550-mtp: add port mapping to
 speakers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240627122015.30945-1-krzysztof.kozlowski@linaro.org>
 <20240627122015.30945-2-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240627122015.30945-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2024 14:20, Krzysztof Kozlowski wrote:
> Add appropriate mappings of Soundwire ports of WSA8845 speaker.  This
> solves second (right) speaker sound distortions when playing audio.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Bindings:
> https://lore.kernel.org/all/20240626-port-map-v1-3-bd8987d2b332@linaro.org/
> 
> Can be applied independently, if bindings are fine.
> ---
>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> index 26dfca0c3e05..ab447fc252f7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> @@ -842,6 +842,7 @@ left_spkr: speaker@0,0 {
>   		sound-name-prefix = "SpkrLeft";
>   		vdd-1p8-supply = <&vreg_l15b_1p8>;
>   		vdd-io-supply = <&vreg_l3g_1p2>;
> +		qcom,port-mapping = <1 2 3 7 10 13>;
>   	};
>   
>   	/* WSA8845 */
> @@ -855,6 +856,7 @@ right_spkr: speaker@0,1 {
>   		sound-name-prefix = "SpkrRight";
>   		vdd-1p8-supply = <&vreg_l15b_1p8>;
>   		vdd-io-supply = <&vreg_l3g_1p2>;
> +		qcom,port-mapping = <4 5 6 7 11 13>;
>   	};
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

