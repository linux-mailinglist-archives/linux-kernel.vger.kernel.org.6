Return-Path: <linux-kernel+bounces-239341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD73925B42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C90B288FDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C2819ADB0;
	Wed,  3 Jul 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LaUjsdsI"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DF19B3CA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004085; cv=none; b=nrPfVosKKZdypQi5dOr+0ZogCLLkX5hEujx0e3X4G156GZJXHcz2ghXbLi+OPASj+TS3cfXSV63IZSFscOnnl+rUwXop+rm0NXuSVwdDQNpCpafYIqpDEFoR59CxbfHV79/J7RJ9hO/Tw3Vm0ZEb8mE+cb8QuBmdHLCQuXOBQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004085; c=relaxed/simple;
	bh=g07N+fsOcKlLhBzIfDUzB1qIS8l7vaHl89+jnh0XN64=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a6vENQo8Fgjc3quVLrJXa5lqtWkKgaTUk1Smcr1lNuy985xxZB91jLFL1mzAQxpyO3Zru0fkghaPCQ71jptHVbKHuuVzPRkj5qyDJidr3FlzucKztYyImQeRQbxBl9OqxnjMq8APBYni/oiVk+Sz1NiagZAwWzx1BGDo11bQkh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LaUjsdsI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso36833415e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720004082; x=1720608882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWMhS2jZ7Cr+0wlcIq6ka4uSw+tn1NfMqOVxdM3qgSc=;
        b=LaUjsdsIAavLvRhRsDq8tJn84HfHw4KFTvZ3JftkGpozJ+QTEGrip20skSqtn0C3TP
         w2UpRlgcHAc5TQNRoJgPnRzMLW98gtra1aGCS7yqSXRZBG/EQSvaXTJa/cjjoVgDKbyE
         zeew59dSX/HZuCFfheyiKXWc1454QXkrZY+lFo1X+Qm85huMeVwkKTrxMOo40kDcp3ii
         OAsBhaXsFeBlTKmj+7ySG/ohMHWbLo+wQ42hy2UnFyCVtJhOph7m2RNjqVRZi703uJmp
         pbkbBJEmGSy4wNn5TOm1NrvcfaU0tAGUJtFDhQXYgEt44iMGFKPSY5uUEG1CZY0gU8hl
         a+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720004082; x=1720608882;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GWMhS2jZ7Cr+0wlcIq6ka4uSw+tn1NfMqOVxdM3qgSc=;
        b=D6AQkMsDwvfI5BzUFRXjEdlXzDNOF+rObmeK0ovSqzaUU2Kfx+LqojsCYTNc97cEZ3
         2TZp9CcOrX9b/QpPIqw8Fqam3i9pOM8xraNqf+ok6WWX2PjIugT1qgJMBUFVoty+pLxM
         mGz27a5JG/0ExWpTAYKcK/pbiVAAANpyAqvu/iaxX6yNpid/zDjma3m6PUpFE0NFoQmK
         cxErGvL8Accym/3pZQUTdWpBAbD7UWTC9lO/p/f+PJy4dOK7pW3rcsuhZQKF3o/IuXd1
         uj1A4frqXq9lE2zNpCdZhRiYrpil/szXgCFML7PlGDy9nhYg+L291LYx3k0ahLjTe7MS
         tu1A==
X-Forwarded-Encrypted: i=1; AJvYcCUjUbIMR5DumBYvhaiPLRU8JxdT9+TcZqg8BLptkv001snxgjTKs/PD1DptvpAguNTwtToSvM6ILCf0X5SfFZmBl9PcB6/rnxqcAC/L
X-Gm-Message-State: AOJu0Yzsb9HZEpZKLXXG6QTSRaxPr+5i0mbr1D7iE0IbgLAtsvTM6Pa9
	IK7HcNt/O3A94YM6Py0iQcxIkUMPgtCFrfG5ICuzAC7+vyStSZNcSOIQjFzoiTg=
X-Google-Smtp-Source: AGHT+IHvbb0wvGbQxH7+T+GjtMUK2Sua5D7SFSvTYWQ0SgpCDBRQnTPQUma4ToIWD2jG969jX0Nhog==
X-Received: by 2002:a05:600c:12c6:b0:424:ada1:6d9 with SMTP id 5b1f17b1804b1-4257a088e18mr95532735e9.34.1720004081826;
        Wed, 03 Jul 2024 03:54:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ef03:73b5:7503:ee71? ([2a01:e0a:982:cbb0:ef03:73b5:7503:ee71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fbbfesm15660302f8f.66.2024.07.03.03.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 03:54:41 -0700 (PDT)
Message-ID: <5ebb2631-5782-4064-95fd-fd6deca013ee@linaro.org>
Date: Wed, 3 Jul 2024 12:54:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/10] clk: meson: c3: peripherals: Constify struct
 regmap_config
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
 <20240703-clk-const-regmap-v1-3-7d15a0671d6f@gmail.com>
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
In-Reply-To: <20240703-clk-const-regmap-v1-3-7d15a0671d6f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 11:50, Javier Carrasco wrote:
> `clkc_regmap_config` is not modified and can be declared as const to
>   move its data to a read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/clk/meson/c3-peripherals.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
> index 56b33d23c317..cfa573262bf1 100644
> --- a/drivers/clk/meson/c3-peripherals.c
> +++ b/drivers/clk/meson/c3-peripherals.c
> @@ -2296,7 +2296,7 @@ static struct clk_regmap *const c3_periphs_clk_regmaps[] = {
>   	&vapb,
>   };
>   
> -static struct regmap_config clkc_regmap_config = {
> +static const struct regmap_config clkc_regmap_config = {
>   	.reg_bits       = 32,
>   	.val_bits       = 32,
>   	.reg_stride     = 4,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

