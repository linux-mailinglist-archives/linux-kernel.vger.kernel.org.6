Return-Path: <linux-kernel+bounces-445163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D549F1239
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C261618A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0B13AD1C;
	Fri, 13 Dec 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGVPwLGO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4D57C9F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107545; cv=none; b=Z5N03Dqe5UAkVgguhBNCxcaGVrvLnHF4kE/2VeBDSq3l0S+JP4WOlgeQXLTssxLZUMp9Kp3AK7j3tyPEzvuZq9SzsnDhvTNVnXpqNXwF4vk39Lk5QhVcym5PZWs52Qw3L7hLYD76aeIMfegBQE4nM/m+Ofo04tTPHZDuetuTBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107545; c=relaxed/simple;
	bh=ZPYhrEJ4C9YCXdunFyqtw5wLjFVZJ3nAjA/yurNDUUo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L/TMvIl7uYKNVHwCJ0ZQZCboa4FJ6PrvByiTDun9FDM4XxPYZW7Xu12uUU2DxQILfpyWSAxBoMjQMkIlk4+Sva6f2f686pCRHlgOL1AC/+lykZq1HqsiH0dp9hwWWRguUMV2/Ry04jWEa1Afwjw+VcvgrAO1feOno8ZYxMTpbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SGVPwLGO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436249df846so14007265e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734107542; x=1734712342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEItgojaVXZbU1GN6003YTd4LyqNe/xYZINzdoL1yzo=;
        b=SGVPwLGOX0UeWPPGbYTsnaWgu/774dcg9otzMt0tspmqCC4ym3RoIaehVtlqCvVRiw
         QPx8ONgiRoOC990N/wp9alTprMXz6O/KTIhcWbVPxvnxexNA4Slm1dcBNYPS6wZS51nX
         hKZxTqQHGMCRbj+umkilIAcVEzDODpZ7XYgiButCJwo+tw90W6Owobxnps9Y5kpzFIBx
         OH23rdwxPnxo7C/g35kj7LcT9lUwE8q2XpxrNJ/MQ6erLTO/aVi8ZQsPEinWIzTbgGCf
         QgCXWv3X3eIL6lv66E583vN56hXW6QzLuenUKw/HB/wmjT9GGWVlq8ChrvWWGVimBIg+
         Va/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734107542; x=1734712342;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DEItgojaVXZbU1GN6003YTd4LyqNe/xYZINzdoL1yzo=;
        b=fMZFSvB+kQj//F0iIlVom+vIcpGUucfq8OFne2FMXFvR2ABWVC1TU6s6aaQTJu4DA4
         B4dYV7koWpHM/FjIu4wUU66VT+bPf/jPqP9eCjoXyKaZdV75W79OCE3XwW9l+7/j1P+a
         vx6TRFuBbGuqzu+lMXVYylLoTtkc84anHd07TlvNolblW/TKYz+vTfUYezaPZzHxHA0H
         ipSuB9zbb4eVQAsEpw9Yz3sHTO3ONgKoL9OsAnL4lD7mWWFGFIvbAE5CI6lEO3dIOfxv
         i8uUGCQcCPm0MddXAXEuzxG7XBO2PMq6CKzjD3gSUNtSJl6b4Rt4oqa9mu5n6rQxO11w
         P0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXC5s7nT95NqwiPZk832qJ5hRdEDyDPJT2yS5IJUY90b4tL+xD+wuLgNpiECy48fneSlmtqAdXO0EH9+zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Y4wEo7NMCzhdI1jWqozui2RRgM0QldwdZki3JatiOx2Foldp
	BsmdBxXK5pRGfcujIj+maVc0DMumWNkwdxNRvxOEHili0eSpayZODiSSstiUfG0=
X-Gm-Gg: ASbGncvmd2FNOSGbOIg8cMnIgRz/AN/fLwGpZR3o5U8J/iQeK8lF/6VKfkErDzTAcLC
	wsMpc6OWWsvJrXlCzbjEnl5mmJb7sCu/pC45c+61oLH5aUrO5Kn9BTueyX6SqnE9ADjiRpvxay6
	8rCOKn4FLAZytLNDWbutvl/XijIdVH4W7Jgu33Hit5tkSiXMcd9P4mphIXvWFLo2i6RJhf/nMIC
	NYi4IegI+J0htOuT4jPuKE702azJoeflF5nxMmH5z3UuYO82SQD0QD+UbAG7ARzIe1oRpEKD4M1
	4P10f2RfJbPyCO/GGe9u9CPCsUfwZ6mMSA==
X-Google-Smtp-Source: AGHT+IGi3FSQoKO9DoZDt5mN0jq76MoXzn0hU8XoMEuvmZepHPVL8hpQQir9gtzLFbj267rx685IwA==
X-Received: by 2002:a5d:64aa:0:b0:385:f38e:c0d3 with SMTP id ffacd0b85a97d-3888e0c15dfmr2184770f8f.58.1734107541936;
        Fri, 13 Dec 2024 08:32:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4795:2d16:2587:ed70? ([2a01:e0a:982:cbb0:4795:2d16:2587:ed70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4a25sm7571456f8f.27.2024.12.13.08.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 08:32:21 -0800 (PST)
Message-ID: <335fb7ff-35a0-44bb-981f-757204d829a8@linaro.org>
Date: Fri, 13 Dec 2024 17:32:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: defconfig: remove obsolete CONFIG_SM_DISPCC_8650
To: ross.burton@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20241213-clkmaster-v1-1-dcbf7fad37b1@arm.com>
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
In-Reply-To: <20241213-clkmaster-v1-1-dcbf7fad37b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+ linux-arm-msm

On 13/12/2024 17:12, Ross Burton via B4 Relay wrote:
> From: Ross Burton <ross.burton@arm.com>
> 
> This option was removed from the Kconfig in commit 802b83205519 ("clk:
> qcom: fold dispcc-sm8650 info dispcc-sm8550") but it was not removed
> from the defconfig.
> 
> Fixes: 802b83205519 ("clk: qcom: fold dispcc-sm8650 info dispcc-sm8550")
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/configs/defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c62831e6158633f07c1f3532fba62f09b31e7448..c6d6a31a8f48c7ce9c9ca74e29db3b8835bfd556 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1352,7 +1352,6 @@ CONFIG_SM_DISPCC_6115=m
>   CONFIG_SM_DISPCC_8250=y
>   CONFIG_SM_DISPCC_8450=m
>   CONFIG_SM_DISPCC_8550=m
> -CONFIG_SM_DISPCC_8650=m
>   CONFIG_SM_GCC_4450=y
>   CONFIG_SM_GCC_6115=y
>   CONFIG_SM_GCC_8350=y
> 
> ---
> base-commit: 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
> change-id: 20241213-clkmaster-558e5d7c966c
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

