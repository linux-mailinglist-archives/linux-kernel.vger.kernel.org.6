Return-Path: <linux-kernel+bounces-239344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A45925B52
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41FE1F23548
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29901849C0;
	Wed,  3 Jul 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvqKMG1l"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC1184133
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004103; cv=none; b=aYxz5B361B8kgzfDvT1DcAmJi9bH7312b+1+ToyHjizJ93lZmAEOSn4ggjzNLDtSJqPlMh03w24I6zCyp/DltyGddKqd3T6DCsL/wgDCpDM3FII+osoluYbj/7UOasAyRyMbMy5IgheP+MO44/bNA7Vwty/qvDnvVd8L7qlGWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004103; c=relaxed/simple;
	bh=PRyBF8w2mM4L9v+3ex4yKSzEav1jn/K4HcGMXSK9asA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QRQ/vG5Ix+7zfR65RKACDt99Inzc2WKdfUjY6DP2BAwlAe60xyE5f9I449333qJcb5KWCXjZZd2HsbpBBGQSJ+F5waT67N0im5UBfzPVTrGe8zuPv47reSBwTJRMptq1u8O0GeAc0B5E+YTusJJdWBqZYK9LaS0vzNDdNoCVcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GvqKMG1l; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-361785bfa71so3608870f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720004100; x=1720608900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39lfOtZEVbcBoFS5FGsq6qRJkxvsQmXq431HRSu2z/o=;
        b=GvqKMG1l4H+08yidEZBbSyT6Ydv2cBB9F66ruPADoAg4IlcWYilZ3W4vt5159d/dys
         M3a/BVW4FK7Swr/FXonrDqxPaNi9gN7EC4qwgVxztbydL/zH1aMJvNko+GXgswGoRp+/
         8iFB93nYGgxez4WeWG3pIL8rsvlhVOQPbghX7Y3CNOMyKiyTTDDnVnCyLGkYGCerQSMx
         dm5vRuXYIZaMPdElXLNvGSv446eAsZByI/+puF5RwS6A7oJ7kNJhiomE2pV5BGZsGXzg
         djG/OTS/06Cba/c8cbI083L4eCApj+eW4EbgTS8+1YbrUAQ4NvkUh0BOYbP6UEo8l9ag
         BdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720004100; x=1720608900;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=39lfOtZEVbcBoFS5FGsq6qRJkxvsQmXq431HRSu2z/o=;
        b=d9mzmfMkd+/4WXRf76Th2wY1SivDAbCsnI8mJPmhnwJqP3G2nL89ROlx0DdCPFM+Bx
         FY0BT4sCLxbNOwXlmSUPVmhpX09logSfalAWHQDG5e5swCKuIRgcbrbU7ZrjnJ4p6rjp
         OpTOZ/c/h5ogyam3x17aMxZOobm2eTjkQIsft/KHtOpDQ+gXzhHKtQu9xrQmDS25lLn1
         HOgi8r6pP9eougjyc4purpVqCSOeg/y9xhuNfqqKMh83zamkZ1ySTg8aBdTV0JVM6yGh
         nXcnyFON1NzeLjAEtSrsvsXO7Szol3RvFOtXlhpuhi6/kmSkBuoFNRo2Bi4j4ZfQCZDK
         DLJA==
X-Forwarded-Encrypted: i=1; AJvYcCVrmRtg+jkMmHzGVs6wAnzp+kNwxJXjz1WeZIRTUqaWZDOAHnf6F5lnvj80YTcsQiGFBPpKQOkA8LAc9T9maIgYCQPtDwZI8O7gPnkW
X-Gm-Message-State: AOJu0Yz7feDXFeWb5qDjNQbdfzr9oR+rn3p2sJOGQBT2DICCmT5bwgh+
	5quSPQSo/GhwGBUA1+kUt2B1tsEFv29cu6ADASAReBIc/eqCCzlq/SwsC4cqi68=
X-Google-Smtp-Source: AGHT+IEcN08kGTuo+p8lg5Oe+R73RxZm6SDE437gKhrh99xNbgW0DEafkie8T38BqJTZPAXiHtGA0g==
X-Received: by 2002:a05:6000:156c:b0:367:4dfe:3e8d with SMTP id ffacd0b85a97d-36775699ed0mr7406301f8f.13.1720004099586;
        Wed, 03 Jul 2024 03:54:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ef03:73b5:7503:ee71? ([2a01:e0a:982:cbb0:ef03:73b5:7503:ee71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fbbfesm15660302f8f.66.2024.07.03.03.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 03:54:59 -0700 (PDT)
Message-ID: <7227a1ff-8383-4250-8336-79e058efc583@linaro.org>
Date: Wed, 3 Jul 2024 12:54:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 06/10] clk: meson: s4: pll: Constify struct regmap_config
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Bjorn Andersson <andersson@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20240703-clk-const-regmap-v1-0-7d15a0671d6f@gmail.com>
 <20240703-clk-const-regmap-v1-6-7d15a0671d6f@gmail.com>
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
In-Reply-To: <20240703-clk-const-regmap-v1-6-7d15a0671d6f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 11:50, Javier Carrasco wrote:
> `clkc_regmap_config` is not modified and can be declared as const to
>   move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/clk/meson/s4-pll.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
> index c2afade24f9f..27c10fc499be 100644
> --- a/drivers/clk/meson/s4-pll.c
> +++ b/drivers/clk/meson/s4-pll.c
> @@ -799,7 +799,7 @@ static const struct reg_sequence s4_init_regs[] = {
>   	{ .reg = ANACTRL_MPLL_CTRL0,	.def = 0x00000543 },
>   };
>   
> -static struct regmap_config clkc_regmap_config = {
> +static const struct regmap_config clkc_regmap_config = {
>   	.reg_bits       = 32,
>   	.val_bits       = 32,
>   	.reg_stride     = 4,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

