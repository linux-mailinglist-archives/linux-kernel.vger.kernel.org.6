Return-Path: <linux-kernel+bounces-440925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DDB9EC686
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2472815BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF40C1D2B0E;
	Wed, 11 Dec 2024 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="McQNHNRG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A41C5F2A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904347; cv=none; b=mkqqimmnfn1AX4uDnCDHqFtNT73AaoVsbuRjuuFt5dmgUM6AO6o3j7+EoQ2aRizaaEhqDf79D6Za/1y44JKq0JzAWrbvAfhKplJjTWTseyHKHSXXKrqt7oQY9a846EoL+3nH8CuRtcylI0xa1xg34PH+7PWNw0IqHS/A7dAzVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904347; c=relaxed/simple;
	bh=QEnmwPzDIU9jUJzJuSb2O4yK2OABfg/wIta/6X8xM1A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pvn9Y0UcTY+O/7BoD4JqXKJyZ+7LGxLYHO15muf9SPSYdssmjnUkYCYHLMNq8/GOQCplOMHfXuSDYhM29/KsTDM0dZajb9yF1QIqS2TgoAPZNeNip0WBPfYXn7hPzstyMEHa9K8dm3ejJ8lidXikUCzx17tIwBNa7YsJFKOc/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=McQNHNRG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43540bdb448so9986265e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904344; x=1734509144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5N9xpUoPzddmqIW9avhJXi0QOz8vquWORsydYTeL5sw=;
        b=McQNHNRGfKbzk7OiEcCEFWK2Jd8aFzcTlUwODJpR5/GpnrhNVW5WbwW4P4UAjd9dNT
         0WCuPDGp+PE35ce+rEvoVbWEk/xDHLrNaeRhgfM6MtQJLx6IKLm5sA8g2MHW7duFqlxG
         z1XLOWQuEA2AnTX7eYFfBCi3WvsZKGMzhYsMfNcaIEIHgicgVZj8PMLyP9NRXSAquiXw
         LFYDbSVKCnESiz9JkiKbfe1FFq18V6CRN1cbbitNFjyEpn47wxlRjLdCD9FNzmBCO2Gu
         JdeHYPU3kfXr0ska9ilXsk5ozaGs29a+6DGQ/J7589yr9qJlTTArGWP+SHuVRuANxG6+
         wOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904344; x=1734509144;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5N9xpUoPzddmqIW9avhJXi0QOz8vquWORsydYTeL5sw=;
        b=ckXa3qIFK+3f0uId5wln9ziFDmd8APLn3neeMOLMTcTonTqzDzzWgakBSTW/m1VuHe
         wKHy0umeD2TjFqgAgODZCMd/jrPXY8Pf8zU+xT7x7RqbYPxk2pKWUWAQGFz7u2Pk9Atk
         vPzoMXFSRRbX5UKOl/80bDONmwa2dv/kSctI0hUCbydYBJmjAi96T5RGpaNR9dAjE8sp
         pVsR4Pwpdybuu6LlaIwq9EAe+9JrN8K9o0Z788QMETiRzO06ag22yf/Q3YkwQPT1k+sa
         FqEMNUKB3N0fhwA3+YrLS+MH7X8LU0YxSS7zZ7EQegw9MqMLUMvuQT5o6U9/GuMgzKKI
         OnbA==
X-Forwarded-Encrypted: i=1; AJvYcCWWCQMfBule+xhDxobCVt5bIBlwlYeLe2sRoPa4fqiMLVsBlp36SaI/5I4ltdRBfsjhEMy3fByGNCY5GtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwF2c9xJrsSveIQ4UVcooRBZ6H79mnhplWQsxL5cb7EjRqphO
	njo3eCSSRioQ1G2xDQ8mFZ94iCICV0sLf1wwVsgtKFdnVmwv2FNPtWLpqg9/EOw=
X-Gm-Gg: ASbGncsbO27HjS/G39Xk0S5Gk0jHcRagWjQZYch1/nMJbCBBS/1ub+qwlInPU1CfIko
	NlihxUCek1j0C/nNhvvjsRS9+LgjhfJkI/EtmSREcUMVatW467gvD5sYXRm4UhNGxU7c+ZzU466
	McgNvmoLVr7SV5iLjF5NAKyU4nLRPgu4zVbcQcGHmCuIlrjxgmJgfdBHQRPUeD7ABIIC8TSBP4e
	ZP4ERfX16dxWP/qFvnmf6cuKk0wrDXmYKGGo6UHynk/mi9BnDORC6JLbu48gd20KUEZFQUHaQQf
	7YL/cHysi/853yNea8ifOBJRK2sGS9o=
X-Google-Smtp-Source: AGHT+IGfxf3QyybU4llNiNYfro4m4NrGy3ofkLiXxs/p70O11DK7pxZUAEgJGIVzqUbAraWoEhvpag==
X-Received: by 2002:a05:600c:468c:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-4361c387b63mr12481535e9.18.1733904343934;
        Wed, 11 Dec 2024 00:05:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d426:8f10:1673:5657? ([2a01:e0a:982:cbb0:d426:8f10:1673:5657])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526ac03sm259127205e9.4.2024.12.11.00.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:05:43 -0800 (PST)
Message-ID: <7ec587ac-0c3d-4228-83ee-964ff4e37a80@linaro.org>
Date: Wed, 11 Dec 2024 09:05:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] ASoC: dt-bindings: convert rt5682.txt to dt-schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bard Liao <bardliao@realtek.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241204-topic-misc-rt5682-convert-v1-1-0fedc4ab15e8@linaro.org>
 <uedkwiuuwi3tfqvi3zzcnays4ytl7l2phg5g6wqwire6ywc2ce@goouwpzb5hi6>
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
In-Reply-To: <uedkwiuuwi3tfqvi3zzcnays4ytl7l2phg5g6wqwire6ywc2ce@goouwpzb5hi6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/2024 10:29, Krzysztof Kozlowski wrote:
> On Wed, Dec 04, 2024 at 11:52:34AM +0100, Neil Armstrong wrote:
>> +  realtek,dmic-delay-ms:
>> +    description:
>> +      Set the delay time (ms) for the requirement of the particular DMIC.
>> +
>> +  realtek,amic-delay-ms:
>> +    description:
>> +      Set the delay time (ms) for the requirement of the particular platform or AMIC.
> 
> Please wrap at 80.

Ack

> 
> This wasn't present in the old binding, so mention reason of adding it
> in the commit msg.

Indeed, bad copy paste, will remove

> 
>> +
>> +  realtek,dmic-clk-driving-high:
>> +    type: boolean
>> +    description:
>> +      Set the high driving of the DMIC clock out.
>> +
>> +  clocks:
>> +    items:
>> +      - description: phandle and clock specifier for codec MCLK.
> 
> ...
> 
>> +
>> +  DBVDD-supply:
>> +    description: Regulator supplying I/O power through the DBVDD pin.
>> +
>> +  LDO1-IN-supply:
>> +    description: Regulator supplying power to the digital core and charge pump
>> +      through the LDO1_IN pin.
>> +
>> +unevaluatedProperties: false
> 
> And since I expect a new version: please move unevaluatedProps after
> required: block.

Ack

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - AVDD-supply
>> +  - VBAT-supply
>> +  - MICVDD-supply
>> +  - DBVDD-supply
>> +  - LDO1-IN-supply
> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Neil

