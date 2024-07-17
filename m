Return-Path: <linux-kernel+bounces-255130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615FB933C84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904B31C22B26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4464F17F515;
	Wed, 17 Jul 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ji5GO0IC"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E931CF9B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216992; cv=none; b=HBtzTxzNn4NLnT2lYzW3RHn09ujblg3NhPsdWmwOxpJxp2GUQswYdILKI335EzPaQ66x2a1n0bHixppxEQ2CbCGR0nQ0ZgQVfNFlzQQTKK87cYMaywjsw46ccK7Gny0ZMuwBeb5fQM33IUrjtTQV9ObztQIc9ct6fomV/FUv68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216992; c=relaxed/simple;
	bh=dijBvA8h/mlP/b+fvArsYP+PU32DDSBuOiQSn/Tbt4c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G6qPAeIU/HxkLt/0GQ1C49S2kw7QAJkXCkZUlsMQ41X0GNuFRU9RZWiY0qbC9JSQYqxfIlo7MLmnYjxgZ7NSGEIUlA1KQgxCjZEkpVhBlHV3ulJx8ILGpdIdeomASCiw1UAdVS/d7oSWk7HtDxCJXJEHcfVuk/FDQKsqc4xpjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ji5GO0IC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367a3d1a378so5822587f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721216989; x=1721821789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7CH0wJPE8C8VJb/gooS5KDoMKf7Vw1Vu0ciAJ2zlEg=;
        b=ji5GO0ICVJNMHnyxxlJ7M5VdaSADD92lrSs39huxqZbNzi4Y/RMvMeId1oXokZ7ggA
         MgjPWP4T3/d7Q3QOb9+7FESRIuojA3K98c6dtRNqf6IRnOUG0DlLUlex7mPtzSZmRI/A
         xiMjQeTvWCaMUZbYJTsAmmhBJxr7yNFHwSijx9SDzUovcDbBmkOyEsgtwcE1Bzl0Yajh
         VU//+rZ/ks+OfrZFxvgpBYwQA3SKxKWR3HvrvAYzxd/Qj3W/J+Xp9WFJ4KjP6JxgR+Tj
         kWKMXAQA94DAzdD02YybPjF9AeIQGE5n25mvuTQ2xWL3kceHD7MYGuHFnjKdO7NLjphM
         2MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721216989; x=1721821789;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w7CH0wJPE8C8VJb/gooS5KDoMKf7Vw1Vu0ciAJ2zlEg=;
        b=tgEVPiI/g1xwslrKlq8K0M4p9UWRuHn7FEEzrQB8Z6TJ5B7Wwx8Yjv+mjbH7TjJV4s
         4roXDWlwcG89hpmW6KQcAtvMqDg3vuBOjfzo32mtK0jB+FEnYCqZqRsQObZRqp1RiMba
         5BXwIDPMhfY8gw5OXTev4tsU4oX7RDq+YquPuRWNJqKzPTLRJVJaqRro5vAIUJWT4eF+
         8ckE9wXnnnBExd3kTTQ5LCseZNgpn3cFqINMCjOtANGC85IyXo122qX2S+ZxYRLuPQeX
         VISAhsJSNsxWcQxOEUE74Sns16GHGugpLxgq+KtuMHpVoI44rZLdiUV9qyx+j/8hch91
         itvA==
X-Forwarded-Encrypted: i=1; AJvYcCXc4M0zbK/Mr3w8EHOAvcxhAPFdv34Jmr6Nt8T/VnJS88bdvlS4CBayIwBUxP2NnVcTYLyZeu3ReRdshaHWkUBaRYT3znl0o732t3aQ
X-Gm-Message-State: AOJu0Ywxim4vJuyQ1Ur3jugIC7eiEUpDcMK6LN00UhqNaT0L0VN+zcfM
	7m6+6fkEsF5Ia9SybGPxBCmbYN+8GHqsdAaeE1xdllg9N3qlkHxWYbCZ7+hdqw0=
X-Google-Smtp-Source: AGHT+IGKb1tKho0NosZx3IwinDD1gQWRFtfkFatWsFodE/ye30ACn8akaZbOBaV+w2cWepVpfMowrw==
X-Received: by 2002:adf:e591:0:b0:367:99fc:238a with SMTP id ffacd0b85a97d-36831650cedmr1325248f8f.32.1721216988693;
        Wed, 17 Jul 2024 04:49:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5b9:9b90:b1c4:1a1d? ([2a01:e0a:982:cbb0:c5b9:9b90:b1c4:1a1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf0e4sm11490435f8f.33.2024.07.17.04.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:49:48 -0700 (PDT)
Message-ID: <be058ef9-2ea5-4bcf-8b74-c73d95e13198@linaro.org>
Date: Wed, 17 Jul 2024 13:49:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/7] clk: qcom: dispcc-sm8550: fix several supposed
 typos
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240717-dispcc-sm8550-fixes-v2-0-5c4a3128c40b@linaro.org>
 <20240717-dispcc-sm8550-fixes-v2-1-5c4a3128c40b@linaro.org>
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
In-Reply-To: <20240717-dispcc-sm8550-fixes-v2-1-5c4a3128c40b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 12:04, Dmitry Baryshkov wrote:
> Fix seveal odd-looking places in SM8550's dispcc driver:
> 
> - duplicate entries in disp_cc_parent_map_4 and disp_cc_parent_map_5
> - using &disp_cc_mdss_dptx0_link_div_clk_src as a source for
>    disp_cc_mdss_dptx1_usb_router_link_intf_clk
> 
> The SM8650 driver has been used as a reference.
> 
> Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/clk/qcom/dispcc-sm8550.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
> index 31ae46f180a5..954b0f6fcea2 100644
> --- a/drivers/clk/qcom/dispcc-sm8550.c
> +++ b/drivers/clk/qcom/dispcc-sm8550.c
> @@ -196,7 +196,7 @@ static const struct clk_parent_data disp_cc_parent_data_3[] = {
>   static const struct parent_map disp_cc_parent_map_4[] = {
>   	{ P_BI_TCXO, 0 },
>   	{ P_DP0_PHY_PLL_LINK_CLK, 1 },
> -	{ P_DP1_PHY_PLL_VCO_DIV_CLK, 2 },
> +	{ P_DP0_PHY_PLL_VCO_DIV_CLK, 2 },
>   	{ P_DP3_PHY_PLL_VCO_DIV_CLK, 3 },
>   	{ P_DP1_PHY_PLL_VCO_DIV_CLK, 4 },
>   	{ P_DP2_PHY_PLL_VCO_DIV_CLK, 6 },
> @@ -213,7 +213,7 @@ static const struct clk_parent_data disp_cc_parent_data_4[] = {
>   
>   static const struct parent_map disp_cc_parent_map_5[] = {
>   	{ P_BI_TCXO, 0 },
> -	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 4 },
> +	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 2 },
>   	{ P_DSI1_PHY_PLL_OUT_BYTECLK, 4 },
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

