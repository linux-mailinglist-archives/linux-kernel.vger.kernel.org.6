Return-Path: <linux-kernel+bounces-232306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C03291A69B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99EE1F2719E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B615EFB6;
	Thu, 27 Jun 2024 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMu51P7F"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD415E5DB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491584; cv=none; b=uaHMIsRoTfsYau3RdRS6J9jJjqoHrHQjxfxw6ED14gAB3HqGxJYvP2lJUpPznxu7Tc6924wP0wgWOikRKxfWkiXipJLE9rG3mmB/x01R9UnMTx52KTXVyT+McqV77ahzZR5rTpfxq/svfJ+SWJquztE11U6dLpac6DznYAAW+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491584; c=relaxed/simple;
	bh=HOQlVvB6ONgJGpF5LO61XvacpwRZojOWxOnMTQxDv5g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=gvBc/enjmJ0D2ewgJFHEr4Mw3ln5L5Cd4oXUMJGcVq0ThJ/0tG08AnA90C89vyosPKwXfMSV1gNlAnM7KvhxA1JyRgOgLIKLqNPsWA13uLqBiP+gXzz8RtgGz4SEUBzF3VFdfKHjQSvjoBMS7Z/nKehjpHUwG/zOwn/wy/Olvws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SMu51P7F; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso84417681fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719491581; x=1720096381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgL5RlzT052Xo6m0Ii8rB0nB/3yeo2P8PyN4dZnkXV0=;
        b=SMu51P7FfHFIFr6xRoEuBplNlXdTaPD9Q7DgodoU1doW/iBuki+NKmyUD8titlgvsK
         uA4I9yYhA8ZAJ6kZfS9aqhUgvS742GCTiZWntACW00A5hIVMYTgTOZ8fcR3Ek1KrjajF
         xSCIfpcwOEYFP3AIm4CRLqP1kG8A9fBaMni+XfZo8V/gguZH2S0vcgLufX2Gt5fzKKk6
         iXrnE7FhT4u9c7caT3F0OLVuBa1KohUM9i2ZECECDXNYruD4uuWGBFHgYLqRIZ3WgwMw
         qE+BvHvgW+Y1ArzvUTHfX6cMUGYt3o3eNIiYaLpU3729B9trEBM/NjO5M8pbjvOZ3wu0
         JaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719491581; x=1720096381;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bgL5RlzT052Xo6m0Ii8rB0nB/3yeo2P8PyN4dZnkXV0=;
        b=xNoyBDuRjhfVjbJIAuyzHsQb6kjj4cqm2BS2svj3PvPbe/4jHy2sDZSBNK9957xxQ3
         Fi0OsVF5LWud2q3PQ+F/KXCSzN/I9947Yl2r6qpQej0BeMh+6MbXkeudqu5CFZiQ/mHT
         h3shuXUIYTXcZM6gtwOZCNsCW3lVq3I3OOxNykTVQGOmTwshSy9ld/1V4/6XCTMCookO
         Oy8k3dBaWWMRk07hc+I581e53gLxM4LJQSn6VL8PhxhF9m4dU43UdpA6df/kJ3Zzty/+
         FoRBU/DheVx/w+qbiz4xXBodApwwByxXSqyNavrAwP4SAXZM0frotyvmA+bQY/ojpAkf
         jbxg==
X-Forwarded-Encrypted: i=1; AJvYcCVT1zRh1eY1eGqFomnxzE0nL6FnzRnCdtKhR1O/S2KaPtsmTqHyKFa4FHtCWBnr8t4xMjU3lgDJ/o33zvlU57A1liZabrwnKXafn8h6
X-Gm-Message-State: AOJu0YwvOb6fWtaNvT0Wp8HJ9WqExGdNMQA3XHsuBhSG2UpRrDzzxOI3
	yWXIMBdhAGhOtcZLwlmaWD+KyqA3NeXzjF5TxFbSTUoYci5ONZuFjrw7TLeMA1g=
X-Google-Smtp-Source: AGHT+IF4pp20DjWohnq1wdqVv5cvhH5Eu1hShIg/CqHNa2hXHfSeWtjmXq7F9YQnMjBuDA/BbSnkYQ==
X-Received: by 2002:a2e:890d:0:b0:2eb:e258:717f with SMTP id 38308e7fff4ca-2ec5b2f0400mr82649941fa.42.1719491580730;
        Thu, 27 Jun 2024 05:33:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:feeb:faed:66fa:9e6a? ([2a01:e0a:982:cbb0:feeb:faed:66fa:9e6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82463d4sm64911665e9.10.2024.06.27.05.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 05:33:00 -0700 (PDT)
Message-ID: <acf50dcb-fbb4-4ed1-8fb1-ef0b4c78916b@linaro.org>
Date: Thu, 27 Jun 2024 14:32:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8550-qrd: add port mapping to
 speakers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240627122015.30945-1-krzysztof.kozlowski@linaro.org>
 <20240627122015.30945-3-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240627122015.30945-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2024 14:20, Krzysztof Kozlowski wrote:
> Add appropriate mappings of Soundwire ports of WSA8845 speaker.  This
> solves second (south) speaker sound distortions when playing audio.
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
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index d27820fb5fc0..de40cb623c8c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -935,6 +935,7 @@ north_spkr: speaker@0,0 {
>   		sound-name-prefix = "SpkrLeft";
>   		vdd-1p8-supply = <&vreg_l15b_1p8>;
>   		vdd-io-supply = <&vreg_l3g_1p2>;
> +		qcom,port-mapping = <1 2 3 7 10 13>;
>   	};
>   
>   	/* WSA8845, Speaker South */
> @@ -948,6 +949,7 @@ south_spkr: speaker@0,1 {
>   		sound-name-prefix = "SpkrRight";
>   		vdd-1p8-supply = <&vreg_l15b_1p8>;
>   		vdd-io-supply = <&vreg_l3g_1p2>;
> +		qcom,port-mapping = <4 5 6 7 11 13>;
>   	};
>   };
>   

At some point I got the exact same change, but I guess I was missing the WSA macro register
shift so this did nothing...

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

