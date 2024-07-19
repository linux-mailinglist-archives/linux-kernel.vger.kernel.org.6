Return-Path: <linux-kernel+bounces-257177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D0937646
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6051F251C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B783CC7;
	Fri, 19 Jul 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7Y+P+nv"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9E82D66
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383172; cv=none; b=KlEyjw2oFGZiCEUhzAcFpehXcWAl3kqv7Y3/CmsN5QU7cNtSid9n0s5IQva7XKgLAYWv+84XMUgXZBz5BqmSdVuDyHdPfgnCvFKlbgMDQZPGs7p/wruP6qVh4usqlmr6yz1fk/XooD2/35fM60YEjudXm7heROp/JX79ikjTox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383172; c=relaxed/simple;
	bh=E8yWSbVUBXOFdUfq99dhcf8ztWREGIKn3YU6lk7v3jw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bGAmzXPHQxtTEA9/LrwJcKfZUFUeaszIfPnNATrNKxg1+GGapRuOXG+mQMPyCXGF2WgDD9Qqx5eQEPtQh6mVNlRHudJPzGijpxXXtiblUfjCYCdvz+WGG++QoJ6/jzi4BDHesVQqWWjnuukxV4VnJBDzFw23n5PTkpXnZL51jss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G7Y+P+nv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42795086628so10784525e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721383168; x=1721987968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7mYCfQ4ZGN1VGCpj1bS9Fmpdu8FKr2d7wAEUAdWl1s=;
        b=G7Y+P+nvQQwKFcHA959he2+B+t08q+7AFLz9HrTRQAQ/tTSupE4cy82Gga51po8hkR
         r7D1P0Nrto38aC+QnUY1SN4C5fuLjqRIsUxHBYB46io8vy1h/kbFlLKIAaiWNqoWvRhF
         QDxq9VlxHaqeHmYYfMbJwCqIWB0PL4KXkNMpvgouJ2hwj0KjWYMUGU5LTOPw3DcBr8Re
         8aphgixYycd1BYKVlq03BGKO4TApgh0+Cim4vPpu5pvRBkqtyUJI+Tq3+beOomctb8C1
         yflb1Ka3HGTLb1GPenr5l45mx3J3dd1Vw+jo2ZgbgE1MZb2qE2PlW3pk1cUcUdWRphiA
         ODOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721383168; x=1721987968;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u7mYCfQ4ZGN1VGCpj1bS9Fmpdu8FKr2d7wAEUAdWl1s=;
        b=jBHdgnjWVtbKpJmrcRZZClfbOfWgjtajrXNCU99ltcm+l5zgXvidbxMkzM4EQgAeoJ
         ydlupUxFGjENc2YLH3fg6Cu1VSbWc3i4smJtOVFcieYF5GzHViZpC/R/pUECPuWDP6CI
         WuEZgTSOlo89Cvq8ucIK4UESgqoMvJxr5Rlvuf489GkK7teESpvES6PbNxLr6Gh2vycT
         Ad8DjU0kVuSfRjKhWsNa9UOO0Zk8hNYd6h3rchgSXULm/HpjMEF96kZJSgjgqjBztTLh
         JwC5y2bYas5vXppYss8yVeGG9hUUSrDxWCcgl8Meuw4A/SV/jpSt2n50QEQ3ZaIeGUw5
         7oOg==
X-Gm-Message-State: AOJu0YzusETbF7MKN/JY5U2lU9IVDWCbcXGOgv5UUc8b798QpaHNE3Q5
	vMLg2JQ1RB/Sxg4mR2CGvTzSIAOFQ+yRx+73S8+9aEeIMPWlgjAF+fNHg8W0kUo=
X-Google-Smtp-Source: AGHT+IENJORR3Q2eLVox6ezFPgE5TkYWyhqgjekzySKbPMbFwLOWosYNswcFlEecO4WUNZr6JgGZAw==
X-Received: by 2002:a05:600c:45c8:b0:426:6389:94c4 with SMTP id 5b1f17b1804b1-427c2d0d669mr53141395e9.37.1721383167828;
        Fri, 19 Jul 2024 02:59:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ec82:adbe:8be7:588d? ([2a01:e0a:982:cbb0:ec82:adbe:8be7:588d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a724fasm43500305e9.26.2024.07.19.02.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 02:59:27 -0700 (PDT)
Message-ID: <7267f35c-fb14-4f38-a9a5-e7e2d7937bd8@linaro.org>
Date: Fri, 19 Jul 2024 11:59:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] clk: meson: introduce symbol namespace for amlogic clocks
To: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240719094228.3985595-1-jbrunet@baylibre.com>
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
In-Reply-To: <20240719094228.3985595-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2024 11:42, Jerome Brunet wrote:
> Symbols exported by the Amlogic clock modules are only meant to be used by
> Amlogic clock controller drivers. Using a dedicated symbols namespace make
> that clear and help clean the global namespace of symbols other modules do
> no need.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   drivers/clk/meson/a1-peripherals.c   |  1 +
>   drivers/clk/meson/a1-pll.c           |  1 +
>   drivers/clk/meson/axg-aoclk.c        |  1 +
>   drivers/clk/meson/axg-audio.c        |  1 +
>   drivers/clk/meson/axg.c              |  1 +
>   drivers/clk/meson/c3-peripherals.c   |  1 +
>   drivers/clk/meson/c3-pll.c           |  1 +
>   drivers/clk/meson/clk-cpu-dyndiv.c   |  3 ++-
>   drivers/clk/meson/clk-dualdiv.c      |  5 +++--
>   drivers/clk/meson/clk-mpll.c         |  5 +++--
>   drivers/clk/meson/clk-phase.c        |  8 ++++----
>   drivers/clk/meson/clk-pll.c          |  7 ++++---
>   drivers/clk/meson/clk-regmap.c       | 13 +++++++------
>   drivers/clk/meson/g12a-aoclk.c       |  1 +
>   drivers/clk/meson/g12a.c             |  1 +
>   drivers/clk/meson/gxbb-aoclk.c       |  1 +
>   drivers/clk/meson/gxbb.c             |  1 +
>   drivers/clk/meson/meson-aoclk.c      |  3 ++-
>   drivers/clk/meson/meson-clkc-utils.c |  3 ++-
>   drivers/clk/meson/meson-eeclk.c      |  3 ++-
>   drivers/clk/meson/s4-peripherals.c   |  1 +
>   drivers/clk/meson/s4-pll.c           |  1 +
>   drivers/clk/meson/sclk-div.c         |  3 ++-
>   drivers/clk/meson/vclk.c             |  5 +++--
>   drivers/clk/meson/vid-pll-div.c      |  3 ++-
>   25 files changed, 49 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
> index 99b5bc450446..53ffbc1cd6f4 100644
> --- a/drivers/clk/meson/a1-peripherals.c
> +++ b/drivers/clk/meson/a1-peripherals.c
> @@ -2246,3 +2246,4 @@ MODULE_DESCRIPTION("Amlogic A1 Peripherals Clock Controller driver");
>   MODULE_AUTHOR("Jian Hu <jian.hu@amlogic.com>");
>   MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> index a16e537d139a..5236821bc3bc 100644
> --- a/drivers/clk/meson/a1-pll.c
> +++ b/drivers/clk/meson/a1-pll.c
> @@ -360,3 +360,4 @@ MODULE_DESCRIPTION("Amlogic S4 PLL Clock Controller driver");
>   MODULE_AUTHOR("Jian Hu <jian.hu@amlogic.com>");
>   MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@sberdevices.ru>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
> index fa1dcb7f91e4..1dabc81535a6 100644
> --- a/drivers/clk/meson/axg-aoclk.c
> +++ b/drivers/clk/meson/axg-aoclk.c
> @@ -342,3 +342,4 @@ module_platform_driver(axg_aoclkc_driver);
>   
>   MODULE_DESCRIPTION("Amlogic AXG Always-ON Clock Controller driver");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 06dc1e1f45e5..beda86349389 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -1912,3 +1912,4 @@ module_platform_driver(axg_audio_driver);
>   MODULE_DESCRIPTION("Amlogic AXG/G12A/SM1 Audio Clock driver");
>   MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 065b5f198297..757c7a28c53d 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -2187,3 +2187,4 @@ module_platform_driver(axg_driver);
>   
>   MODULE_DESCRIPTION("Amlogic AXG Main Clock Controller driver");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
> index 56b33d23c317..dae80943a6c7 100644
> --- a/drivers/clk/meson/c3-peripherals.c
> +++ b/drivers/clk/meson/c3-peripherals.c
> @@ -2364,3 +2364,4 @@ module_platform_driver(c3_peripherals_driver);
>   MODULE_DESCRIPTION("Amlogic C3 Peripherals Clock Controller driver");
>   MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
> index 6d5271c61d14..5ff409e89cd2 100644
> --- a/drivers/clk/meson/c3-pll.c
> +++ b/drivers/clk/meson/c3-pll.c
> @@ -745,3 +745,4 @@ module_platform_driver(c3_pll_driver);
>   MODULE_DESCRIPTION("Amlogic C3 PLL Clock Controller driver");
>   MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/clk-cpu-dyndiv.c b/drivers/clk/meson/clk-cpu-dyndiv.c
> index aa824b030cb8..6c1f58826e24 100644
> --- a/drivers/clk/meson/clk-cpu-dyndiv.c
> +++ b/drivers/clk/meson/clk-cpu-dyndiv.c
> @@ -65,8 +65,9 @@ const struct clk_ops meson_clk_cpu_dyndiv_ops = {
>   	.determine_rate = meson_clk_cpu_dyndiv_determine_rate,
>   	.set_rate = meson_clk_cpu_dyndiv_set_rate,
>   };
> -EXPORT_SYMBOL_GPL(meson_clk_cpu_dyndiv_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_cpu_dyndiv_ops, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic CPU Dynamic Clock divider");
>   MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/clk-dualdiv.c b/drivers/clk/meson/clk-dualdiv.c
> index d46c02b51be5..913bf25d3771 100644
> --- a/drivers/clk/meson/clk-dualdiv.c
> +++ b/drivers/clk/meson/clk-dualdiv.c
> @@ -130,14 +130,15 @@ const struct clk_ops meson_clk_dualdiv_ops = {
>   	.determine_rate	= meson_clk_dualdiv_determine_rate,
>   	.set_rate	= meson_clk_dualdiv_set_rate,
>   };
> -EXPORT_SYMBOL_GPL(meson_clk_dualdiv_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_dualdiv_ops, CLK_MESON);
>   
>   const struct clk_ops meson_clk_dualdiv_ro_ops = {
>   	.recalc_rate	= meson_clk_dualdiv_recalc_rate,
>   };
> -EXPORT_SYMBOL_GPL(meson_clk_dualdiv_ro_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_dualdiv_ro_ops, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic dual divider driver");
>   MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>   MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
> index eae9b7dc5a6c..f639d56f0fd3 100644
> --- a/drivers/clk/meson/clk-mpll.c
> +++ b/drivers/clk/meson/clk-mpll.c
> @@ -165,7 +165,7 @@ const struct clk_ops meson_clk_mpll_ro_ops = {
>   	.recalc_rate	= mpll_recalc_rate,
>   	.determine_rate	= mpll_determine_rate,
>   };
> -EXPORT_SYMBOL_GPL(meson_clk_mpll_ro_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_mpll_ro_ops, CLK_MESON);
>   
>   const struct clk_ops meson_clk_mpll_ops = {
>   	.recalc_rate	= mpll_recalc_rate,
> @@ -173,8 +173,9 @@ const struct clk_ops meson_clk_mpll_ops = {
>   	.set_rate	= mpll_set_rate,
>   	.init		= mpll_init,
>   };
> -EXPORT_SYMBOL_GPL(meson_clk_mpll_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_mpll_ops, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic MPLL driver");
>   MODULE_AUTHOR("Michael Turquette <mturquette@baylibre.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/clk-phase.c b/drivers/clk/meson/clk-phase.c
> index ff3f0b1a3ed1..c1526fbfb6c4 100644
> --- a/drivers/clk/meson/clk-phase.c
> +++ b/drivers/clk/meson/clk-phase.c
> @@ -61,7 +61,7 @@ const struct clk_ops meson_clk_phase_ops = {
>   	.get_phase	= meson_clk_phase_get_phase,
>   	.set_phase	= meson_clk_phase_set_phase,
>   };
> -EXPORT_SYMBOL_GPL(meson_clk_phase_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_phase_ops, CLK_MESON);
>   
>   /*
>    * This is a special clock for the audio controller.
> @@ -123,7 +123,7 @@ const struct clk_ops meson_clk_triphase_ops = {
>   	.get_phase	= meson_clk_triphase_get_phase,
>   	.set_phase	= meson_clk_triphase_set_phase,
>   };
> -EXPORT_SYMBOL_GPL(meson_clk_triphase_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_triphase_ops, CLK_MESON);
>   
>   /*
>    * This is a special clock for the audio controller.
> @@ -178,9 +178,9 @@ const struct clk_ops meson_sclk_ws_inv_ops = {
>   	.get_phase	= meson_sclk_ws_inv_get_phase,
>   	.set_phase	= meson_sclk_ws_inv_set_phase,
>   };
> -EXPORT_SYMBOL_GPL(meson_sclk_ws_inv_ops);
> -
> +EXPORT_SYMBOL_NS_GPL(meson_sclk_ws_inv_ops, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic phase driver");
>   MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 467dc8b61a37..bc570a2ff3a3 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -472,7 +472,7 @@ const struct clk_ops meson_clk_pcie_pll_ops = {
>   	.enable		= meson_clk_pcie_pll_enable,
>   	.disable	= meson_clk_pll_disable
>   };
> -EXPORT_SYMBOL_GPL(meson_clk_pcie_pll_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_pcie_pll_ops, CLK_MESON);
>   
>   const struct clk_ops meson_clk_pll_ops = {
>   	.init		= meson_clk_pll_init,
> @@ -483,15 +483,16 @@ const struct clk_ops meson_clk_pll_ops = {
>   	.enable		= meson_clk_pll_enable,
>   	.disable	= meson_clk_pll_disable
>   };
> -EXPORT_SYMBOL_GPL(meson_clk_pll_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_pll_ops, CLK_MESON);
>   
>   const struct clk_ops meson_clk_pll_ro_ops = {
>   	.recalc_rate	= meson_clk_pll_recalc_rate,
>   	.is_enabled	= meson_clk_pll_is_enabled,
>   };
> -EXPORT_SYMBOL_GPL(meson_clk_pll_ro_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_pll_ro_ops, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic PLL driver");
>   MODULE_AUTHOR("Carlo Caione <carlo@endlessm.com>");
>   MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
> index ad116d24f700..07f7e441b916 100644
> --- a/drivers/clk/meson/clk-regmap.c
> +++ b/drivers/clk/meson/clk-regmap.c
> @@ -49,12 +49,12 @@ const struct clk_ops clk_regmap_gate_ops = {
>   	.disable = clk_regmap_gate_disable,
>   	.is_enabled = clk_regmap_gate_is_enabled,
>   };
> -EXPORT_SYMBOL_GPL(clk_regmap_gate_ops);
> +EXPORT_SYMBOL_NS_GPL(clk_regmap_gate_ops, CLK_MESON);
>   
>   const struct clk_ops clk_regmap_gate_ro_ops = {
>   	.is_enabled = clk_regmap_gate_is_enabled,
>   };
> -EXPORT_SYMBOL_GPL(clk_regmap_gate_ro_ops);
> +EXPORT_SYMBOL_NS_GPL(clk_regmap_gate_ro_ops, CLK_MESON);
>   
>   static unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
>   						unsigned long prate)
> @@ -125,13 +125,13 @@ const struct clk_ops clk_regmap_divider_ops = {
>   	.determine_rate = clk_regmap_div_determine_rate,
>   	.set_rate = clk_regmap_div_set_rate,
>   };
> -EXPORT_SYMBOL_GPL(clk_regmap_divider_ops);
> +EXPORT_SYMBOL_NS_GPL(clk_regmap_divider_ops, CLK_MESON);
>   
>   const struct clk_ops clk_regmap_divider_ro_ops = {
>   	.recalc_rate = clk_regmap_div_recalc_rate,
>   	.determine_rate = clk_regmap_div_determine_rate,
>   };
> -EXPORT_SYMBOL_GPL(clk_regmap_divider_ro_ops);
> +EXPORT_SYMBOL_NS_GPL(clk_regmap_divider_ro_ops, CLK_MESON);
>   
>   static u8 clk_regmap_mux_get_parent(struct clk_hw *hw)
>   {
> @@ -174,13 +174,14 @@ const struct clk_ops clk_regmap_mux_ops = {
>   	.set_parent = clk_regmap_mux_set_parent,
>   	.determine_rate = clk_regmap_mux_determine_rate,
>   };
> -EXPORT_SYMBOL_GPL(clk_regmap_mux_ops);
> +EXPORT_SYMBOL_NS_GPL(clk_regmap_mux_ops, CLK_MESON);
>   
>   const struct clk_ops clk_regmap_mux_ro_ops = {
>   	.get_parent = clk_regmap_mux_get_parent,
>   };
> -EXPORT_SYMBOL_GPL(clk_regmap_mux_ro_ops);
> +EXPORT_SYMBOL_NS_GPL(clk_regmap_mux_ro_ops, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic regmap backed clock driver");
>   MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
> index a5f4d15d8396..f0a18d8c9fc2 100644
> --- a/drivers/clk/meson/g12a-aoclk.c
> +++ b/drivers/clk/meson/g12a-aoclk.c
> @@ -477,3 +477,4 @@ module_platform_driver(g12a_aoclkc_driver);
>   
>   MODULE_DESCRIPTION("Amlogic G12A Always-ON Clock Controller driver");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index ec3b61686770..3c01b395205d 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -5616,3 +5616,4 @@ module_platform_driver(g12a_driver);
>   
>   MODULE_DESCRIPTION("Amlogic G12/SM1 Main Clock Controller driver");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
> index 33fafbdf65c4..83b034157b35 100644
> --- a/drivers/clk/meson/gxbb-aoclk.c
> +++ b/drivers/clk/meson/gxbb-aoclk.c
> @@ -303,3 +303,4 @@ module_platform_driver(gxbb_aoclkc_driver);
>   
>   MODULE_DESCRIPTION("Amlogic GXBB Always-ON Clock Controller driver");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index d3175e4335bb..f071faad1ebb 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -3571,3 +3571,4 @@ module_platform_driver(gxbb_driver);
>   
>   MODULE_DESCRIPTION("Amlogic GXBB Main Clock Controller driver");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
> index 2dd064201fae..053940ee8940 100644
> --- a/drivers/clk/meson/meson-aoclk.c
> +++ b/drivers/clk/meson/meson-aoclk.c
> @@ -88,7 +88,8 @@ int meson_aoclkc_probe(struct platform_device *pdev)
>   
>   	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
>   }
> -EXPORT_SYMBOL_GPL(meson_aoclkc_probe);
> +EXPORT_SYMBOL_NS_GPL(meson_aoclkc_probe, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic Always-ON Clock Controller helpers");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/meson-clkc-utils.c b/drivers/clk/meson/meson-clkc-utils.c
> index 4dd5948b7ae4..a8cd2c21fab7 100644
> --- a/drivers/clk/meson/meson-clkc-utils.c
> +++ b/drivers/clk/meson/meson-clkc-utils.c
> @@ -20,7 +20,8 @@ struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_da
>   
>   	return data->hws[idx];
>   }
> -EXPORT_SYMBOL_GPL(meson_clk_hw_get);
> +EXPORT_SYMBOL_NS_GPL(meson_clk_hw_get, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic Clock Controller Utilities");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
> index 570992eece86..66f79e384fe5 100644
> --- a/drivers/clk/meson/meson-eeclk.c
> +++ b/drivers/clk/meson/meson-eeclk.c
> @@ -57,7 +57,8 @@ int meson_eeclkc_probe(struct platform_device *pdev)
>   
>   	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
>   }
> -EXPORT_SYMBOL_GPL(meson_eeclkc_probe);
> +EXPORT_SYMBOL_NS_GPL(meson_eeclkc_probe, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic Main Clock Controller Helpers");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
> index 130c50554290..ee01e6839f38 100644
> --- a/drivers/clk/meson/s4-peripherals.c
> +++ b/drivers/clk/meson/s4-peripherals.c
> @@ -3814,3 +3814,4 @@ module_platform_driver(s4_driver);
>   MODULE_DESCRIPTION("Amlogic S4 Peripherals Clock Controller driver");
>   MODULE_AUTHOR("Yu Tu <yu.tu@amlogic.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
> index c2afade24f9f..d679ee8f85fd 100644
> --- a/drivers/clk/meson/s4-pll.c
> +++ b/drivers/clk/meson/s4-pll.c
> @@ -873,3 +873,4 @@ module_platform_driver(s4_driver);
>   MODULE_DESCRIPTION("Amlogic S4 PLL Clock Controller driver");
>   MODULE_AUTHOR("Yu Tu <yu.tu@amlogic.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
> index 987f5b06587c..ae03b048182f 100644
> --- a/drivers/clk/meson/sclk-div.c
> +++ b/drivers/clk/meson/sclk-div.c
> @@ -247,8 +247,9 @@ const struct clk_ops meson_sclk_div_ops = {
>   	.set_duty_cycle = sclk_div_set_duty_cycle,
>   	.init		= sclk_div_init,
>   };
> -EXPORT_SYMBOL_GPL(meson_sclk_div_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_sclk_div_ops, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic Sample divider driver");
>   MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/vclk.c b/drivers/clk/meson/vclk.c
> index e886df55d6e3..36f637d2d01b 100644
> --- a/drivers/clk/meson/vclk.c
> +++ b/drivers/clk/meson/vclk.c
> @@ -49,7 +49,7 @@ const struct clk_ops meson_vclk_gate_ops = {
>   	.disable = meson_vclk_gate_disable,
>   	.is_enabled = meson_vclk_gate_is_enabled,
>   };
> -EXPORT_SYMBOL_GPL(meson_vclk_gate_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_vclk_gate_ops, CLK_MESON);
>   
>   /* The VCLK Divider has supplementary reset & enable bits */
>   
> @@ -134,8 +134,9 @@ const struct clk_ops meson_vclk_div_ops = {
>   	.disable = meson_vclk_div_disable,
>   	.is_enabled = meson_vclk_div_is_enabled,
>   };
> -EXPORT_SYMBOL_GPL(meson_vclk_div_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_vclk_div_ops, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic vclk clock driver");
>   MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);
> diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
> index ee129f86794d..486cf68fc97a 100644
> --- a/drivers/clk/meson/vid-pll-div.c
> +++ b/drivers/clk/meson/vid-pll-div.c
> @@ -92,8 +92,9 @@ static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
>   const struct clk_ops meson_vid_pll_div_ro_ops = {
>   	.recalc_rate	= meson_vid_pll_div_recalc_rate,
>   };
> -EXPORT_SYMBOL_GPL(meson_vid_pll_div_ro_ops);
> +EXPORT_SYMBOL_NS_GPL(meson_vid_pll_div_ro_ops, CLK_MESON);
>   
>   MODULE_DESCRIPTION("Amlogic video pll divider driver");
>   MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>   MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CLK_MESON);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

