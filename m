Return-Path: <linux-kernel+bounces-447967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21059F395A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EF7188AA0A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633CA207E1A;
	Mon, 16 Dec 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0xqpOrZ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1A207E15
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375235; cv=none; b=ngxs2a4SxL8uqX6+8acPf3qY3USL6EDOOAiLVRakboJhIuTyR2yXspa+xEmH6FRmVnZIVe1AmuZd2cvbtimcskdDhehO2wOM6j6PDCUcE0BzEM9bon3jFQNfmjUOITB56P4mR3roTkd1+JQAWFR69whCmGE0A7xzetK4dP5RqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375235; c=relaxed/simple;
	bh=WL+c9MsMLCftMhyW+I2h5TrtsdsOlsdR2umauGA3zpo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RI1ZK2aHi0kAc+cOsqxZVAY7WpUg26C2yZ5X0bE5Pgmt8tBiuA530P9cLwXcETHzpJSfBHlfsSElBkibeBMKyrF2IvzgMAT0KuuzG8F3n72jBWpdcYX6PDCJXFFJ/hXyEQBjEyR5yy70mVnyRf/0ETm/mftY6lHzZzz3ikzstVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o0xqpOrZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4363ae65100so20628185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734375232; x=1734980032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9TdY8wDAQIhgT2ZvDa2oy0Rrrdx753hIU59bQKGYyc=;
        b=o0xqpOrZlPFIA4H9bAE+hYiZwJ+SoEz3eNc+pgQA9rrM7Fkdc0av2mlc818RCvAGwE
         gs1sRRWfUuMp3gKzSXzjfNuk3DKPcxj8jaHZcvH1dAT8YLOB1gNH45Kr64nRNVHYSmxW
         fQtHC7Kxilk+phxyhCi1UmPcWZhzhwit7CzoAIH9OvqJ8Wj5nlxgE+Feq0mMUUV8dYk5
         iM5nvzvxAx/PUa/M3JOnLElfX5w2c22HM0s/jYKFhxlb4OddiV4ElS6iR5egNuYXFijo
         WCdPdY2J31Dufr2aIo6d/tVAKNGk3eOw7Zg8w2B/UqDgzPoJbSBnHmYqSYWeyFHZA1En
         A9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734375232; x=1734980032;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O9TdY8wDAQIhgT2ZvDa2oy0Rrrdx753hIU59bQKGYyc=;
        b=jyVhYJWe1g2jRN+bs7HLWDIpSc6+RB+bsllDvOwCWnHKMWV2WBsupufcSL1OXfo5cB
         lmQxV3Ng4t8uW3uEBa57vJqIrRPjBBTZrwbK69JtzOCxdcKb5hIn35NNQnQTmWETLzby
         6yfj+Cotz+Z6ZLUFZ6KT7ztpfBAfzVsJ97teKfljIl6F2c6gkIPymMdGjpt8KadDjtTk
         lkWDme/gPliLc59c0b3/kuK06FlcoVemhoayCAnoEy2xDUdK2dEGN+KXM2MBqk5vwban
         ZA8JvarBVu+g0WamK8CHRQF+3GvIENLO2GnPc6f8UNLJu4CMBcGYbuyn/hlBRrxfSfs4
         U77g==
X-Forwarded-Encrypted: i=1; AJvYcCXgd8Mafz6V/fywW79wwRwBMGOk65x8cSaegfcGLZQurZEUjAjCd0QPN4++30pq6+QrfJCed0qbx1h59iA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2r3mO15czNcLED7Ab2WoK2SIqVPUiewb5mkoEnMLSF6EnzZf0
	D4HqbEUgEQUfua5N10uhq3SGMHCAMD7LRf1ty6PCixPIgljlk4ZISyMB46l4x3o/G+GjDkrWXDZ
	+1UI=
X-Gm-Gg: ASbGncvEBwDd2wTdwKIhHtp+uLZhTmoCvJYk41UCKJQ30Ly4vBNzIMUJbKCOgEv5gwW
	COTSD6Tx82CYxB9cjPHBerk6vHxEFGqyD0NMKe8QRezsvY/xiYviSAIp6UOneEm/vZ8hkaONoFy
	stX8zsx6fInjBXZG0JHQ+AU3OqbdvDtK0509jUpHync9sDAPUrW5ouMOUaVH1kKZPL5ugBa2Orc
	JLcYylnzj7yPtoNfvZmwqea9zGlz+Hxy06FR1ZQ9pcdMlBWIeBpFFWK4/RACfZG4DIVpjp97ky0
	KLR8VgHc36ujZXGxaVwhkbsv4SkkCy1CFQ==
X-Google-Smtp-Source: AGHT+IG59oeD9k/rUOCvesGIKAV/ezj83uuhcluTrje5318wlJogWM8odJk4nxizFM14ZiA9HZnziA==
X-Received: by 2002:a05:6000:471b:b0:386:3835:9fff with SMTP id ffacd0b85a97d-3888e0c06c7mr12974884f8f.59.1734375231995;
        Mon, 16 Dec 2024 10:53:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8b75:a430:7bc1:919b? ([2a01:e0a:982:cbb0:8b75:a430:7bc1:919b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c805d489sm8978020f8f.88.2024.12.16.10.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 10:53:51 -0800 (PST)
Message-ID: <5c8691c4-4a57-40a9-9da6-00accf3d1a4f@linaro.org>
Date: Mon, 16 Dec 2024 19:53:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] clk: amlogic: g12b: fix cluster A parent data
To: Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241213-amlogic-clk-g12a-cpua-parent-fix-v1-1-d8c0f41865fe@baylibre.com>
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
In-Reply-To: <20241213-amlogic-clk-g12a-cpua-parent-fix-v1-1-d8c0f41865fe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 15:30, Jerome Brunet wrote:
> Several clocks used by both g12a and g12b use the g12a cpu A clock hw
> pointer as clock parent. This is incorrect on g12b since the parents of
> cluster A cpu clock are different. Also the hw clock provided as parent to
> these children is not even registered clock on g12b.
> 
> Fix the problem by reverting to the global namespace and let CCF pick
> the appropriate, as it is already done for other clocks, such as
> cpu_clk_trace_div.
> 
> Fixes: 25e682a02d91 ("clk: meson: g12a: migrate to the new parent description method")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/clk/meson/g12a.c | 36 ++++++++++++++++++++++++------------
>   1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 20be7b037c07535bd2115f6e70404a95a7832756..4e6584377e43fa7c9956017ddfcd3f295fafd686 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -1137,8 +1137,18 @@ static struct clk_regmap g12a_cpu_clk_div16_en = {
>   	.hw.init = &(struct clk_init_data) {
>   		.name = "cpu_clk_div16_en",
>   		.ops = &clk_regmap_gate_ro_ops,
> -		.parent_hws = (const struct clk_hw *[]) {
> -			&g12a_cpu_clk.hw
> +		.parent_data = &(const struct clk_parent_data) {
> +			/*
> +			 * Note:
> +			 * G12A and G12B have different cpu clocks (with
> +			 * different struct clk_hw). We fallback to the global
> +			 * naming string mechanism so this clock picks
> +			 * up the appropriate one. Same goes for the other
> +			 * clock using cpu cluster A clock output and present
> +			 * on both G12 variant.
> +			 */
> +			.name = "cpu_clk",
> +			.index = -1,
>   		},
>   		.num_parents = 1,
>   		/*
> @@ -1203,7 +1213,10 @@ static struct clk_regmap g12a_cpu_clk_apb_div = {
>   	.hw.init = &(struct clk_init_data){
>   		.name = "cpu_clk_apb_div",
>   		.ops = &clk_regmap_divider_ro_ops,
> -		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
> +		.parent_data = &(const struct clk_parent_data) {
> +			.name = "cpu_clk",
> +			.index = -1,
> +		},
>   		.num_parents = 1,
>   	},
>   };
> @@ -1237,7 +1250,10 @@ static struct clk_regmap g12a_cpu_clk_atb_div = {
>   	.hw.init = &(struct clk_init_data){
>   		.name = "cpu_clk_atb_div",
>   		.ops = &clk_regmap_divider_ro_ops,
> -		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
> +		.parent_data = &(const struct clk_parent_data) {
> +			.name = "cpu_clk",
> +			.index = -1,
> +		},
>   		.num_parents = 1,
>   	},
>   };
> @@ -1271,7 +1287,10 @@ static struct clk_regmap g12a_cpu_clk_axi_div = {
>   	.hw.init = &(struct clk_init_data){
>   		.name = "cpu_clk_axi_div",
>   		.ops = &clk_regmap_divider_ro_ops,
> -		.parent_hws = (const struct clk_hw *[]) { &g12a_cpu_clk.hw },
> +		.parent_data = &(const struct clk_parent_data) {
> +			.name = "cpu_clk",
> +			.index = -1,
> +		},
>   		.num_parents = 1,
>   	},
>   };
> @@ -1306,13 +1325,6 @@ static struct clk_regmap g12a_cpu_clk_trace_div = {
>   		.name = "cpu_clk_trace_div",
>   		.ops = &clk_regmap_divider_ro_ops,
>   		.parent_data = &(const struct clk_parent_data) {
> -			/*
> -			 * Note:
> -			 * G12A and G12B have different cpu_clks (with
> -			 * different struct clk_hw). We fallback to the global
> -			 * naming string mechanism so cpu_clk_trace_div picks
> -			 * up the appropriate one.
> -			 */
>   			.name = "cpu_clk",
>   			.index = -1,
>   		},
> 
> ---
> base-commit: 799ce46951dcc75682223cdab12fdc905f2fe735
> change-id: 20241213-amlogic-clk-g12a-cpua-parent-fix-64362495fc9b
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

