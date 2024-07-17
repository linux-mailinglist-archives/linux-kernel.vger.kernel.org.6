Return-Path: <linux-kernel+bounces-255134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EC5933C91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCC5282EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6043617FAAE;
	Wed, 17 Jul 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojpLL7J/"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A417F51A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721217015; cv=none; b=S1Esyz8+GCHqz7BZNVMvmEq5a4Wb7mDYFHJvo5dMhoNRGGKZyt5S1CuZ0CgytHkdb4zeEq7T/Co8o7Sk6TQDDrK+fz5BRK1tlC9/x5mVKXGH1DDRGWwJYSZdIkowxNRT48quCRc937uEFP4lRN5p3xVUfCmXNDElwSLULBseL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721217015; c=relaxed/simple;
	bh=3HRGuFAcx9cPJcr518Ed16jroDs9NC8wDqUExXpw8yA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=obi3/yiaRE2DlEJofrNnHF/atymwJbuqmkBkZ4wHsFidPr4ORWgoTngDXMx/xwZ4EXoQRT+dq3M5PpirW9eb5b/dyGwggTN82xrlyDU+H2nivIIS7Z7GglqPNWCZJDnZIbckT1tsMm5CuvdGksrWIR9EGQWQU1H0P+C+xhx+CU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ojpLL7J/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266edee10cso43593025e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721217011; x=1721821811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jM1BOK8q6Z7g9qfd6Tl2qWqvkyuhYcwkcK8NcYEOfSU=;
        b=ojpLL7J/4WkwapwpzZF7Zq4krtL+xME76adiGBa0oy1J5aK+XoF6A1EqDvUDnLL8YI
         Lkvp5xxR1DC9pNDpabUVs/PFMUFSbuyPql2elt5eZ2wnVKdK4iEKGO466CCYh99aFoYH
         uwjc8JbG2HQOw5ZBqySDaaZXYTzQiAP0L96wHxMkjVybhKxwwxPaFLuivR0RNEzQRkYx
         TrvXDFilvO4IAAwSVoKNia36l+jKQH6bX/y7aW/NM/fK+LAwR3KyRn5zmLQBkOuqMCy2
         6LgnEpoUoQeDvsSLy4kzSMDI3zKO+ieOwvliQVdBChx8a5R4jF5Bu8d2zgU47TiK67wC
         Bflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721217011; x=1721821811;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jM1BOK8q6Z7g9qfd6Tl2qWqvkyuhYcwkcK8NcYEOfSU=;
        b=p8tvhJhZJzixDimSij/Qhnv7jh096/Z7GtwQJ3t37uhztXuLHiO7lHv3ikEGzwiQMD
         YSLqKTV0jHWn6rJzkApC7Oh9A+G1IWhE7eQ4a4458j6xFlICgQYKdN7SbJxJWPjTPLza
         Zixuv+Hro9bnnQrY69Kbpl6fvh/GOhQz6Ad+JkHh5kBtg5BxwpESgUW2U/cyq/6Ss+nA
         8iSDyVBfgt6jAkxd4Yh0BuhdVtWM58KD1kMn6K9WhnJ2+GyLGkBykc7fV9lHdxva/YOV
         VI1WkK+Im48AoUc6H4kG6deC3QObn8jw/bigIRDotnI4LrWpOQa0KozTBoB/EHBu6B0G
         E8+g==
X-Forwarded-Encrypted: i=1; AJvYcCXgWzOGRQt+1aoH93NMES8gct2yYHqMNFzkMjZRSbAsK+4hj2MY5OB48N8qrnd3inztH7oBv/Ea86hHLrsLPUnIKnqIzk0EiqVhjNRd
X-Gm-Message-State: AOJu0YzvhkytSjlf2ZnPgBsR0UQRoMrwapw8YF7vudxJ6tyhumeugMRu
	nn0XSIMEC10DBGJXweVbTytqYJQ6pnvpcxwqQ8c+IoGDrbP3fVwjJQQDsplSXSM=
X-Google-Smtp-Source: AGHT+IELujU8A61JmDMp+vnnbsnW29YB3XkM1tLVK4fEbUnGtQVH+wVjXBAbb4hjjl+XYQymFj+Sbg==
X-Received: by 2002:adf:e10a:0:b0:367:96a1:2b91 with SMTP id ffacd0b85a97d-3683165e996mr996547f8f.26.1721217010653;
        Wed, 17 Jul 2024 04:50:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5b9:9b90:b1c4:1a1d? ([2a01:e0a:982:cbb0:c5b9:9b90:b1c4:1a1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3ee4sm11596014f8f.7.2024.07.17.04.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:50:10 -0700 (PDT)
Message-ID: <9cc7e025-3e79-4591-adc3-3ca15520575d@linaro.org>
Date: Wed, 17 Jul 2024 13:50:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/7] clk: qcom: dispcc-sm8550: make struct
 clk_init_data const
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240717-dispcc-sm8550-fixes-v2-0-5c4a3128c40b@linaro.org>
 <20240717-dispcc-sm8550-fixes-v2-3-5c4a3128c40b@linaro.org>
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
In-Reply-To: <20240717-dispcc-sm8550-fixes-v2-3-5c4a3128c40b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 12:04, Dmitry Baryshkov wrote:
> The clk_init_data instances are not changed at runtime. Mark them as
> constant data.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/clk/qcom/dispcc-sm8550.c | 160 +++++++++++++++++++--------------------
>   1 file changed, 80 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
> index a98230540782..1604a6a4acdc 100644
> --- a/drivers/clk/qcom/dispcc-sm8550.c
> +++ b/drivers/clk/qcom/dispcc-sm8550.c
> @@ -95,7 +95,7 @@ static struct clk_alpha_pll disp_cc_pll0 = {
>   	.num_vco = ARRAY_SIZE(lucid_ole_vco),
>   	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
>   	.clkr = {
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_pll0",
>   			.parent_data = &(const struct clk_parent_data) {
>   				.index = DT_BI_TCXO,
> @@ -126,7 +126,7 @@ static struct clk_alpha_pll disp_cc_pll1 = {
>   	.num_vco = ARRAY_SIZE(lucid_ole_vco),
>   	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
>   	.clkr = {
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_pll1",
>   			.parent_data = &(const struct clk_parent_data) {
>   				.index = DT_BI_TCXO,
> @@ -286,7 +286,7 @@ static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_6,
>   	.freq_tbl = ftbl_disp_cc_mdss_ahb_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_ahb_clk_src",
>   		.parent_data = disp_cc_parent_data_6,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
> @@ -306,7 +306,7 @@ static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_2,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_byte0_clk_src",
>   		.parent_data = disp_cc_parent_data_2,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> @@ -321,7 +321,7 @@ static struct clk_rcg2 disp_cc_mdss_byte1_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_2,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_byte1_clk_src",
>   		.parent_data = disp_cc_parent_data_2,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> @@ -336,7 +336,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_0,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx0_aux_clk_src",
>   		.parent_data = disp_cc_parent_data_0,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> @@ -350,7 +350,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
>   	.mnd_width = 0,
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_7,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx0_link_clk_src",
>   		.parent_data = disp_cc_parent_data_7,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_7),
> @@ -365,7 +365,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_pixel0_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_4,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx0_pixel0_clk_src",
>   		.parent_data = disp_cc_parent_data_4,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
> @@ -380,7 +380,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_pixel1_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_4,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx0_pixel1_clk_src",
>   		.parent_data = disp_cc_parent_data_4,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
> @@ -395,7 +395,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_aux_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_0,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx1_aux_clk_src",
>   		.parent_data = disp_cc_parent_data_0,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> @@ -409,7 +409,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
>   	.mnd_width = 0,
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_3,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx1_link_clk_src",
>   		.parent_data = disp_cc_parent_data_3,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> @@ -424,7 +424,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_pixel0_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_1,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx1_pixel0_clk_src",
>   		.parent_data = disp_cc_parent_data_1,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> @@ -439,7 +439,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_pixel1_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_1,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx1_pixel1_clk_src",
>   		.parent_data = disp_cc_parent_data_1,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> @@ -454,7 +454,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_aux_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_0,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx2_aux_clk_src",
>   		.parent_data = disp_cc_parent_data_0,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> @@ -468,7 +468,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
>   	.mnd_width = 0,
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_3,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx2_link_clk_src",
>   		.parent_data = disp_cc_parent_data_3,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> @@ -483,7 +483,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_pixel0_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_1,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx2_pixel0_clk_src",
>   		.parent_data = disp_cc_parent_data_1,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> @@ -498,7 +498,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_pixel1_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_1,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx2_pixel1_clk_src",
>   		.parent_data = disp_cc_parent_data_1,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> @@ -513,7 +513,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_aux_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_0,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx3_aux_clk_src",
>   		.parent_data = disp_cc_parent_data_0,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> @@ -527,7 +527,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
>   	.mnd_width = 0,
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_3,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx3_link_clk_src",
>   		.parent_data = disp_cc_parent_data_3,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
> @@ -542,7 +542,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_pixel0_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_1,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx3_pixel0_clk_src",
>   		.parent_data = disp_cc_parent_data_1,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
> @@ -557,7 +557,7 @@ static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_5,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_esc0_clk_src",
>   		.parent_data = disp_cc_parent_data_5,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
> @@ -572,7 +572,7 @@ static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_5,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_esc1_clk_src",
>   		.parent_data = disp_cc_parent_data_5,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
> @@ -600,7 +600,7 @@ static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_8,
>   	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_mdp_clk_src",
>   		.parent_data = disp_cc_parent_data_8,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_8),
> @@ -615,7 +615,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_2,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_pclk0_clk_src",
>   		.parent_data = disp_cc_parent_data_2,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> @@ -630,7 +630,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_2,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_pclk1_clk_src",
>   		.parent_data = disp_cc_parent_data_2,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
> @@ -645,7 +645,7 @@ static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_0,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_vsync_clk_src",
>   		.parent_data = disp_cc_parent_data_0,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
> @@ -665,7 +665,7 @@ static struct clk_rcg2 disp_cc_sleep_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_9,
>   	.freq_tbl = ftbl_disp_cc_sleep_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_sleep_clk_src",
>   		.parent_data = disp_cc_parent_data_9,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_9),
> @@ -680,7 +680,7 @@ static struct clk_rcg2 disp_cc_xo_clk_src = {
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_0,
>   	.freq_tbl = ftbl_disp_cc_mdss_byte0_clk_src,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_xo_clk_src",
>   		.parent_data = disp_cc_parent_data_0_ao,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0_ao),
> @@ -693,7 +693,7 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
>   	.reg = 0x8120,
>   	.shift = 0,
>   	.width = 4,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_byte0_div_clk_src",
>   		.parent_hws = (const struct clk_hw*[]) {
>   			&disp_cc_mdss_byte0_clk_src.clkr.hw,
> @@ -707,7 +707,7 @@ static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
>   	.reg = 0x813c,
>   	.shift = 0,
>   	.width = 4,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_byte1_div_clk_src",
>   		.parent_hws = (const struct clk_hw*[]) {
>   			&disp_cc_mdss_byte1_clk_src.clkr.hw,
> @@ -721,7 +721,7 @@ static struct clk_regmap_div disp_cc_mdss_dptx0_link_div_clk_src = {
>   	.reg = 0x8188,
>   	.shift = 0,
>   	.width = 4,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx0_link_div_clk_src",
>   		.parent_hws = (const struct clk_hw*[]) {
>   			&disp_cc_mdss_dptx0_link_clk_src.clkr.hw,
> @@ -736,7 +736,7 @@ static struct clk_regmap_div disp_cc_mdss_dptx1_link_div_clk_src = {
>   	.reg = 0x821c,
>   	.shift = 0,
>   	.width = 4,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx1_link_div_clk_src",
>   		.parent_hws = (const struct clk_hw*[]) {
>   			&disp_cc_mdss_dptx1_link_clk_src.clkr.hw,
> @@ -751,7 +751,7 @@ static struct clk_regmap_div disp_cc_mdss_dptx2_link_div_clk_src = {
>   	.reg = 0x8250,
>   	.shift = 0,
>   	.width = 4,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx2_link_div_clk_src",
>   		.parent_hws = (const struct clk_hw*[]) {
>   			&disp_cc_mdss_dptx2_link_clk_src.clkr.hw,
> @@ -766,7 +766,7 @@ static struct clk_regmap_div disp_cc_mdss_dptx3_link_div_clk_src = {
>   	.reg = 0x82cc,
>   	.shift = 0,
>   	.width = 4,
> -	.clkr.hw.init = &(struct clk_init_data) {
> +	.clkr.hw.init = &(const struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx3_link_div_clk_src",
>   		.parent_hws = (const struct clk_hw*[]) {
>   			&disp_cc_mdss_dptx3_link_clk_src.clkr.hw,
> @@ -783,7 +783,7 @@ static struct clk_branch disp_cc_mdss_accu_clk = {
>   	.clkr = {
>   		.enable_reg = 0xe058,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_accu_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_xo_clk_src.clkr.hw,
> @@ -801,7 +801,7 @@ static struct clk_branch disp_cc_mdss_ahb1_clk = {
>   	.clkr = {
>   		.enable_reg = 0xa020,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_ahb1_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_ahb_clk_src.clkr.hw,
> @@ -819,7 +819,7 @@ static struct clk_branch disp_cc_mdss_ahb_clk = {
>   	.clkr = {
>   		.enable_reg = 0x80a4,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_ahb_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_ahb_clk_src.clkr.hw,
> @@ -837,7 +837,7 @@ static struct clk_branch disp_cc_mdss_byte0_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8028,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_byte0_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_byte0_clk_src.clkr.hw,
> @@ -855,7 +855,7 @@ static struct clk_branch disp_cc_mdss_byte0_intf_clk = {
>   	.clkr = {
>   		.enable_reg = 0x802c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_byte0_intf_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_byte0_div_clk_src.clkr.hw,
> @@ -873,7 +873,7 @@ static struct clk_branch disp_cc_mdss_byte1_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8030,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_byte1_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_byte1_clk_src.clkr.hw,
> @@ -891,7 +891,7 @@ static struct clk_branch disp_cc_mdss_byte1_intf_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8034,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_byte1_intf_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_byte1_div_clk_src.clkr.hw,
> @@ -909,7 +909,7 @@ static struct clk_branch disp_cc_mdss_dptx0_aux_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8058,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx0_aux_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx0_aux_clk_src.clkr.hw,
> @@ -927,7 +927,7 @@ static struct clk_branch disp_cc_mdss_dptx0_crypto_clk = {
>   	.clkr = {
>   		.enable_reg = 0x804c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx0_crypto_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx0_link_clk_src.clkr.hw,
> @@ -945,7 +945,7 @@ static struct clk_branch disp_cc_mdss_dptx0_link_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8040,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx0_link_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx0_link_clk_src.clkr.hw,
> @@ -963,7 +963,7 @@ static struct clk_branch disp_cc_mdss_dptx0_link_intf_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8048,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx0_link_intf_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> @@ -981,7 +981,7 @@ static struct clk_branch disp_cc_mdss_dptx0_pixel0_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8050,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx0_pixel0_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx0_pixel0_clk_src.clkr.hw,
> @@ -999,7 +999,7 @@ static struct clk_branch disp_cc_mdss_dptx0_pixel1_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8054,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx0_pixel1_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx0_pixel1_clk_src.clkr.hw,
> @@ -1017,7 +1017,7 @@ static struct clk_branch disp_cc_mdss_dptx0_usb_router_link_intf_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8044,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx0_usb_router_link_intf_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> @@ -1035,7 +1035,7 @@ static struct clk_branch disp_cc_mdss_dptx1_aux_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8074,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx1_aux_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx1_aux_clk_src.clkr.hw,
> @@ -1053,7 +1053,7 @@ static struct clk_branch disp_cc_mdss_dptx1_crypto_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8070,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx1_crypto_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx1_link_clk_src.clkr.hw,
> @@ -1071,7 +1071,7 @@ static struct clk_branch disp_cc_mdss_dptx1_link_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8064,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx1_link_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx1_link_clk_src.clkr.hw,
> @@ -1089,7 +1089,7 @@ static struct clk_branch disp_cc_mdss_dptx1_link_intf_clk = {
>   	.clkr = {
>   		.enable_reg = 0x806c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx1_link_intf_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx1_link_div_clk_src.clkr.hw,
> @@ -1107,7 +1107,7 @@ static struct clk_branch disp_cc_mdss_dptx1_pixel0_clk = {
>   	.clkr = {
>   		.enable_reg = 0x805c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx1_pixel0_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx1_pixel0_clk_src.clkr.hw,
> @@ -1125,7 +1125,7 @@ static struct clk_branch disp_cc_mdss_dptx1_pixel1_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8060,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx1_pixel1_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx1_pixel1_clk_src.clkr.hw,
> @@ -1143,7 +1143,7 @@ static struct clk_branch disp_cc_mdss_dptx1_usb_router_link_intf_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8068,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx1_usb_router_link_intf_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx0_link_div_clk_src.clkr.hw,
> @@ -1161,7 +1161,7 @@ static struct clk_branch disp_cc_mdss_dptx2_aux_clk = {
>   	.clkr = {
>   		.enable_reg = 0x808c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx2_aux_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx2_aux_clk_src.clkr.hw,
> @@ -1179,7 +1179,7 @@ static struct clk_branch disp_cc_mdss_dptx2_crypto_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8088,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx2_crypto_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx2_link_clk_src.clkr.hw,
> @@ -1197,7 +1197,7 @@ static struct clk_branch disp_cc_mdss_dptx2_link_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8080,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx2_link_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx2_link_clk_src.clkr.hw,
> @@ -1215,7 +1215,7 @@ static struct clk_branch disp_cc_mdss_dptx2_link_intf_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8084,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx2_link_intf_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx2_link_div_clk_src.clkr.hw,
> @@ -1233,7 +1233,7 @@ static struct clk_branch disp_cc_mdss_dptx2_pixel0_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8078,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx2_pixel0_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx2_pixel0_clk_src.clkr.hw,
> @@ -1251,7 +1251,7 @@ static struct clk_branch disp_cc_mdss_dptx2_pixel1_clk = {
>   	.clkr = {
>   		.enable_reg = 0x807c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx2_pixel1_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx2_pixel1_clk_src.clkr.hw,
> @@ -1269,7 +1269,7 @@ static struct clk_branch disp_cc_mdss_dptx3_aux_clk = {
>   	.clkr = {
>   		.enable_reg = 0x809c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx3_aux_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx3_aux_clk_src.clkr.hw,
> @@ -1287,7 +1287,7 @@ static struct clk_branch disp_cc_mdss_dptx3_crypto_clk = {
>   	.clkr = {
>   		.enable_reg = 0x80a0,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx3_crypto_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx3_link_clk_src.clkr.hw,
> @@ -1305,7 +1305,7 @@ static struct clk_branch disp_cc_mdss_dptx3_link_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8094,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx3_link_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx3_link_clk_src.clkr.hw,
> @@ -1323,7 +1323,7 @@ static struct clk_branch disp_cc_mdss_dptx3_link_intf_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8098,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx3_link_intf_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx3_link_div_clk_src.clkr.hw,
> @@ -1341,7 +1341,7 @@ static struct clk_branch disp_cc_mdss_dptx3_pixel0_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8090,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_dptx3_pixel0_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_dptx3_pixel0_clk_src.clkr.hw,
> @@ -1359,7 +1359,7 @@ static struct clk_branch disp_cc_mdss_esc0_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8038,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_esc0_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_esc0_clk_src.clkr.hw,
> @@ -1377,7 +1377,7 @@ static struct clk_branch disp_cc_mdss_esc1_clk = {
>   	.clkr = {
>   		.enable_reg = 0x803c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_esc1_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_esc1_clk_src.clkr.hw,
> @@ -1395,7 +1395,7 @@ static struct clk_branch disp_cc_mdss_mdp1_clk = {
>   	.clkr = {
>   		.enable_reg = 0xa004,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_mdp1_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_mdp_clk_src.clkr.hw,
> @@ -1413,7 +1413,7 @@ static struct clk_branch disp_cc_mdss_mdp_clk = {
>   	.clkr = {
>   		.enable_reg = 0x800c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_mdp_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_mdp_clk_src.clkr.hw,
> @@ -1431,7 +1431,7 @@ static struct clk_branch disp_cc_mdss_mdp_lut1_clk = {
>   	.clkr = {
>   		.enable_reg = 0xa010,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_mdp_lut1_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_mdp_clk_src.clkr.hw,
> @@ -1449,7 +1449,7 @@ static struct clk_branch disp_cc_mdss_mdp_lut_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8018,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_mdp_lut_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_mdp_clk_src.clkr.hw,
> @@ -1467,7 +1467,7 @@ static struct clk_branch disp_cc_mdss_non_gdsc_ahb_clk = {
>   	.clkr = {
>   		.enable_reg = 0xc004,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_non_gdsc_ahb_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_ahb_clk_src.clkr.hw,
> @@ -1485,7 +1485,7 @@ static struct clk_branch disp_cc_mdss_pclk0_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8004,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_pclk0_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_pclk0_clk_src.clkr.hw,
> @@ -1503,7 +1503,7 @@ static struct clk_branch disp_cc_mdss_pclk1_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8008,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_pclk1_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_pclk1_clk_src.clkr.hw,
> @@ -1521,7 +1521,7 @@ static struct clk_branch disp_cc_mdss_rscc_ahb_clk = {
>   	.clkr = {
>   		.enable_reg = 0xc00c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_rscc_ahb_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_ahb_clk_src.clkr.hw,
> @@ -1539,7 +1539,7 @@ static struct clk_branch disp_cc_mdss_rscc_vsync_clk = {
>   	.clkr = {
>   		.enable_reg = 0xc008,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_rscc_vsync_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_vsync_clk_src.clkr.hw,
> @@ -1557,7 +1557,7 @@ static struct clk_branch disp_cc_mdss_vsync1_clk = {
>   	.clkr = {
>   		.enable_reg = 0xa01c,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_vsync1_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_vsync_clk_src.clkr.hw,
> @@ -1575,7 +1575,7 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
>   	.clkr = {
>   		.enable_reg = 0x8024,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_mdss_vsync_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_mdss_vsync_clk_src.clkr.hw,
> @@ -1593,7 +1593,7 @@ static struct clk_branch disp_cc_sleep_clk = {
>   	.clkr = {
>   		.enable_reg = 0xe074,
>   		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data) {
> +		.hw.init = &(const struct clk_init_data) {
>   			.name = "disp_cc_sleep_clk",
>   			.parent_hws = (const struct clk_hw*[]) {
>   				&disp_cc_sleep_clk_src.clkr.hw,
> 
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

