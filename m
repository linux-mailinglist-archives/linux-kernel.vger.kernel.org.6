Return-Path: <linux-kernel+bounces-255135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BD9933C95
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D690CB23261
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2B180A70;
	Wed, 17 Jul 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6ugQwuJ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1A17FAB7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721217021; cv=none; b=SWDLyt/sw2H9ePXs6wVa66BuVUSJrE0lWywSWhTDw/X4BQ3fP2PNonVBnwE9KNGqm8CGi1d1LfMsSMOhiWMDMcGR3HTpDAQuOCQJPwLrcPqkdNfuWWsm+edxK3mMGFmVcaUS0dt81m1kVf04J6leNgwj4nNW4fr3UM1idlmHL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721217021; c=relaxed/simple;
	bh=JVaK0J/PZCJIrlXBQZhWas1UEmJYDEVgENMBtAexwr8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YmssVCJDweGEBzURe8Qw+5uKuaILBnb2sCmOuGmi0NE3ofkq/NcsXJBGdwGpo0E9Bk8rJoPy+vRovm7oPuiZIh4xT173blXjFQaadF2gZla2Wka8Hn3JPYpMwCc1f6ahu1yCPkl5KAtJeUazDD7KHOQop/YDbt5sIX/BR+8ZFW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F6ugQwuJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-368313809a4so307459f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721217017; x=1721821817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZyWxxmZgO29JkoC4TRc4yeVnGhqHgmh3XgcrnySTFg=;
        b=F6ugQwuJOdeG0ARoH3SHSCFh+s9LLZtbx9NlBDEoITFFtdwbXDn/Jqm9R4SKUalqth
         C21Ogjq1TLvp7aRyxRRdKWZHTpht4DnekRBnAdj/l19TBQUHBnzCySFYFYsrE5AY8ffl
         YG7vM7n4Q89QzlN/O7gsJ4WfVxlVOoAxyxTW9Qkh8+CVtvNB5jiIA4OUkR+v9LiMxgxt
         bUBH2UA0DQmuvLZ3RPdui8Br8VZM9EeT+KIutN1wVx3OFbKpegeKUHaYqoxt5xBf7ofI
         DrxgCocv1SB+VgvnI3CTF0qnL1vZBuR0/Ut5EYpa+T6SefKAi6RNPSqzZLAzvKgLh/4Y
         VZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721217017; x=1721821817;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aZyWxxmZgO29JkoC4TRc4yeVnGhqHgmh3XgcrnySTFg=;
        b=wbJmxtc+BHdXfVcmkfa4AnHy0gttJQxbLGD8KXxjd5uAYLJIfEMEzw7IjM6usoJB7G
         VwYlCgngNaH3HHV/O/RjbcejTle00fmn/A7TeMJbK2Xv+sJg9bKPKPG/cGBiq/D4bxIo
         Nb6rjzlvj9nCXqgL7n6BwMBuo50IpzKp3vec7YOZ7Zpm3g8/DtzjCWiyKdg7IHrZGBYv
         KkwNZr+PN+QS18b2WPQ9wqI/066B69PwJo4NnKPdRZi35jMCnl+4x85rTmFjlO0VZHx/
         hzYItxvU1vBrikmfHICD9vR3+m3LdB+7nDmLuyDLOEUHd2/brTcbaRCvgPyIFBP/b59y
         iIBg==
X-Forwarded-Encrypted: i=1; AJvYcCUJMYZg34r03XkhURHAwhYgQL8Zw/KhFNorkf2nbFM6mfwqLftz/1Dtwuh6w8etoVjp0Z0WfLmOz9haRLgIZoPFQ1H/8aw2sA94zgYY
X-Gm-Message-State: AOJu0Yzq0rsBC/1JsF4e1UpiiZWeFlcGTwr+sLZHOgTRHfa8FOCCNkf+
	PrLgCPw+lSZuaBA0baQG5PCCuS0ZvP1kXcj1xZhfbQ7INZ+nHM4PPuZnXgvNArE=
X-Google-Smtp-Source: AGHT+IEcgWXCyK0u5lje6xRBdygs3Cs0EZ635zARQLDVm418TfcKnE5nvtCxsO/FvQgIKp0ailMPiA==
X-Received: by 2002:a05:6000:1848:b0:366:df35:b64f with SMTP id ffacd0b85a97d-36827357473mr5056741f8f.4.1721217016937;
        Wed, 17 Jul 2024 04:50:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5b9:9b90:b1c4:1a1d? ([2a01:e0a:982:cbb0:c5b9:9b90:b1c4:1a1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3ee4sm11596014f8f.7.2024.07.17.04.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:50:16 -0700 (PDT)
Message-ID: <774f2efa-74c6-4cff-be14-e1a4a518404f@linaro.org>
Date: Wed, 17 Jul 2024 13:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 4/7] clk: qcom: dispcc-sm8650: Update the GDSC flags
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240717-dispcc-sm8550-fixes-v2-0-5c4a3128c40b@linaro.org>
 <20240717-dispcc-sm8550-fixes-v2-4-5c4a3128c40b@linaro.org>
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
In-Reply-To: <20240717-dispcc-sm8550-fixes-v2-4-5c4a3128c40b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 12:04, Dmitry Baryshkov wrote:
> Add missing POLL_CFG_GDSCR to the MDSS GDSC flags.
> 
> Fixes: 90114ca11476 ("clk: qcom: add SM8550 DISPCC driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/clk/qcom/dispcc-sm8550.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
> index 1604a6a4acdc..eebc4c2258d0 100644
> --- a/drivers/clk/qcom/dispcc-sm8550.c
> +++ b/drivers/clk/qcom/dispcc-sm8550.c
> @@ -1611,7 +1611,7 @@ static struct gdsc mdss_gdsc = {
>   		.name = "mdss_gdsc",
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = HW_CTRL | RETAIN_FF_ENABLE,
> +	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
>   };
>   
>   static struct gdsc mdss_int2_gdsc = {
> @@ -1620,7 +1620,7 @@ static struct gdsc mdss_int2_gdsc = {
>   		.name = "mdss_int2_gdsc",
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = HW_CTRL | RETAIN_FF_ENABLE,
> +	.flags = POLL_CFG_GDSCR | HW_CTRL | RETAIN_FF_ENABLE,
>   };
>   
>   static struct clk_regmap *disp_cc_sm8550_clocks[] = {
> 
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

