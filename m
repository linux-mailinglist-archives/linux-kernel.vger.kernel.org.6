Return-Path: <linux-kernel+bounces-232334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D514391A6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BFF1F27198
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E53179652;
	Thu, 27 Jun 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L31l/y1Q"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9B17839F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492716; cv=none; b=bEbFKgFqQo2WM2n+Nxmg3XpxyBpA7pLTIHou/y8qVSoLyDJWoEopYdWC20o9ImMSmyMML4N3Ejpt6bBhZHIqundvLi2ySIIGcQcvXO6a1b0OploA32n6FVTQ209dJcr1pSG9q0xx7ON3ZFsYO13b6Ndo+l7XsDMB80+eJ6xCyC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492716; c=relaxed/simple;
	bh=XtdvjmExmK9D2dS6fGUdUIVDepbUx+JmHx/WT1CKyFQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ngX5NDO7R+vz/qGkqxDeAt9x1/K8qSkPIP3g+uFEzYCZWQ0RZIklSCyYsWBmYzKvd40xqLS4iznw0vyxRw6zr0u0yimnYdy+Us4urw5FCKFCe8mn4FjtgproAGmAkxzqeY0bFjsppqXC+SEzoINV80wMdS1tdJN+KnnXRU54BNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L31l/y1Q; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367339bd00aso958921f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719492714; x=1720097514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnYEn+08jqkRCijrF6N5I7CtgtXywXX5Pko+EhFcF/E=;
        b=L31l/y1QDiu8q1GXO/OT/ybb//9oV1hJpaOHdLo7fjbsv+0FqcpD2H0GTWlDbwzlKT
         vR7GdlC8P4iwMt4qMfDx+d4SgwONRnYtnfg1A2Wh/4gug3psmH27YrsQaLLr5DB3m/Ny
         CLV+Ax2MRYyioVSEfzCIQwF1KYWezhB38JXBk5BJ69UW/z9ic7gD4bVS/xLk5G66WyQv
         vHgrMGS4PRdUWO6HwwWMDYHP1PhYQpCqQj6QcJmuVqCzvaDbdP7kWmWu4LbMiRGhX0pY
         FlVuUt4EXjMhLZZHWkcY7MN7GHMDsI9S6CXrbZRmg4JeTGe6caOxryt0sJ6D1KGhD/dK
         5gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492714; x=1720097514;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fnYEn+08jqkRCijrF6N5I7CtgtXywXX5Pko+EhFcF/E=;
        b=tlE7SkXCpWj/kJmMXS2evOqTNF64kzKPL8h1xputxmjEPpKEJuYL3kC7gYXpDdYWcq
         Kj6vIOYg8x9U0HxN7M4AMvlBJyvL95UstknSw71BTCnJVdcB7J3iZ5y+/J8EzFSlDW8w
         QAo0UVUcV/t/p/psd+0oMQnvss5oZtjH3Fg9iNzdJJD6NnIS1M9Ri7FqwJ9dZ+N6leh4
         U/SSZxOa4f44ZVgyMB1uunO61FQcK2NaZ5NNfuZ2TEU6vaaSSCLgEwRDB+/xhIJ0i/Ax
         +/upT7Efgy1nLR4AYE4NEy6Wyu+SkXDXLXhohfwnxG25KF6ri0gCSRc65otNuCQZxNun
         7Ylw==
X-Forwarded-Encrypted: i=1; AJvYcCXjrZsUN9VOKZst6u4g/jqxyuY8f+M1LxCKPpsCw1dht1Jxiin8QNnRbEyyLiGSMpxlpEmOTj+GL0lfa2eQoGbtGQbByGqlylvPx0Hn
X-Gm-Message-State: AOJu0Yz7hciTCSQyq4PGoJpKNu0/5m5t42+O82VEKqrwQIosR+MDv+41
	nZD6QDxomhw3+8lD3qUCKGJhgWgvEepCUZmUyV6txNsLK9vxQf+wKQj956jybkY=
X-Google-Smtp-Source: AGHT+IEdepWeFKby2pWGXn4ajKkwBMT3yEWL/Z2uvHjUQvfydEqGgmbC1o+puPl/54j5hAOcRfQ47w==
X-Received: by 2002:adf:ec43:0:b0:366:eaa7:1133 with SMTP id ffacd0b85a97d-366eaa711damr8511782f8f.46.1719492713031;
        Thu, 27 Jun 2024 05:51:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:feeb:faed:66fa:9e6a? ([2a01:e0a:982:cbb0:feeb:faed:66fa:9e6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674357ff28sm1774577f8f.47.2024.06.27.05.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 05:51:52 -0700 (PDT)
Message-ID: <c71feb6b-4da5-4181-8b4a-2f5dac195135@linaro.org>
Date: Thu, 27 Jun 2024 14:51:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/6] ASoC: codecs: wsa88xx: add support for static port
 mapping.
To: srinivas.kandagatla@linaro.org, Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Manikantan R <quic_manrav@quicinc.com>
References: <20240626-port-map-v1-0-bd8987d2b332@linaro.org>
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
In-Reply-To: <20240626-port-map-v1-0-bd8987d2b332@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2024 13:55, srinivas.kandagatla@linaro.org wrote:
> Existing way of allocating soundwire master ports on Qualcommm platforms is
> dynamic, and in linear order starting from 1 to MAX_PORTS.
> This will work as long as soundwire device ports are 1:1 mapped
> linearly. However on most Qcom SoCs like SM8550, SM8650, x1e80100, these
> are NOT mapped in that order.
> 
> The result of this is that only one speaker among the pair of speakers
> is always silent, With recent changes for WSA codec to support codec
> versions and along with these patches we are able to get all speakers
> working on these SoCs.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Manikantan R (1):
>        ASoC: dt-bindings: wsa883x: Document port mapping property
> 
> Srinivas Kandagatla (5):
>        ASoC: codecs: wsa883x: parse port-mapping information
>        ASoC: dt-bindings: wsa8840: Document port mapping property
>        ASoC: codecs: wsa884x: parse port-mapping information
>        arm64: dts: x1e80100-crd: fix wsa soundwire port mapping
>        arm64: dts: x1e80100-qcp: fix wsa soundwire port mapping
> 
>   Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml | 8 ++++++++
>   Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml | 8 ++++++++
>   arch/arm64/boot/dts/qcom/x1e80100-crd.dts                 | 4 ++++
>   arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                 | 2 ++
>   sound/soc/codecs/wsa883x.c                                | 8 ++++++++
>   sound/soc/codecs/wsa884x.c                                | 8 ++++++++
>   6 files changed, 38 insertions(+)
> ---
> base-commit: 9935be184a55dd84fc3275094f2df095491f6ea1
> change-id: 20240626-port-map-ef50c3304d4a
> 
> Best regards,

I now have both speakers working !

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

Thanks!
Neil

