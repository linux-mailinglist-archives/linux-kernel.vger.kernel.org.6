Return-Path: <linux-kernel+bounces-347401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E8998D228
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD7E287749
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211561EC01E;
	Wed,  2 Oct 2024 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZLa70vv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC6B1E6DD4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868049; cv=none; b=hCkU6ba77sD05BFQTgsOz8AOjEIafGNbvnt3IemlQPgVeKOiNJteX+qW5HOjbcgRq2OS1OWtnnOuh/eM+QmwEujZd+NiQBHiiE01aoamnAb9YSH1PZfYKz7DSlRJnFGNYq2pWs//TD/boHjWqXu6xI/D7OaPeo/8su49lj5GEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868049; c=relaxed/simple;
	bh=HCCCEeMhNMH2j+6URk/vieugvjNSproh591L737VQN0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=euLdnOWJ/QOVPS9SaTkFWAkyyEkOZYguShmnZKw8jDorbyc0oKy6efdLQvsEo5/5rkAiobrSCRtpp+iktt/z42cjiFy2m9xIWwN68y8YpktFLz6gMQPD0F0CXtjLqGfteX+sE9u59LeE6vE6QfI9sJkYJZEok8tc7B+w2zNehs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZLa70vv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so28450705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727868046; x=1728472846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuMn+uvzgNhXlVl6NvssHiZDUL25KUVzV3NB9k+ro68=;
        b=eZLa70vvySLlAMYF8XrFcYOlI8YAD4HEWcaHCNXI/OsMZQuLileodYGx+zAtYxj85I
         m7t13mxBxWwQh6ASRaVKRHtmhZMQx3JNwcv/Q3hx5WZtJo4aS5v04dlRZ1cyzU54872i
         kcBcM15EP0pjx6zLft/9vw1aV/ue2bGSXn1xXUmDuDsDgMHELckR0I+AGZC4qk8uPhJ/
         sEbC/A0ihI0x+vimDcsEH5O0f6gLVyVYVtIPvj/lvQmTCAPXV6F8H2EpZXOcz7MXzKBB
         FkE5jMSTmSAsn56YXyBrhVDCu8gm1exmeyqt8xskawHWwTAAF/EEB8GcUD0JJumYAO5o
         PY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727868046; x=1728472846;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xuMn+uvzgNhXlVl6NvssHiZDUL25KUVzV3NB9k+ro68=;
        b=k/QcsFfCy4iswT7CSrH/lhfhcmUuGzL1+CjzUrbKwls3kLWPs31sR53fHhh/v3H0qC
         thm0qcau5o/tCRCeEPZ/818t8FENleSwAWQZIZ1veAGd6zDp7UrXq9UnD2jJpVfcPnim
         xRP2D5WzA/tMiyKxxkuShiIeX5AXy1cZX2buLq7pv4+HepUd5/WenQJjhUz0DDtsUzcP
         hrvn5LWdk1MU8PNCdvbpllSiapOF029/3oEgZPVkYRZuBsNlQrYa8JTNR6Imwu912NKg
         URISRE3GvxSu5EyQhlpLZ/UaX5z2AB39msJkY3tCDMfbZdjZgzyg4QiTnqyllWvl7SBk
         E+jA==
X-Forwarded-Encrypted: i=1; AJvYcCVjEX90G4pqQdoFPQBi/Nc3Tx9hwgFkyEdTh2n5iMnX+Ns4JPYCc24b/mT1Kuag/BV2zD1T+mjK7XLEq6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwStztg+IhdXpZKYk+mZMS8ElngWNx4qObltk1qI/E//rS6qSTI
	aByFxMq/eKtgu2gB+nmkYHABOauTyaSCKeVEbgsuWFfLfBsCZgkRDlyX2BjlV4g=
X-Google-Smtp-Source: AGHT+IG8p3dWVjk/6hZCzmXj39xeg0ImZtG3Merz+EByl/MIpSdWVEPWB/AKs0ghnMfzwQPyYhCtlQ==
X-Received: by 2002:a5d:4843:0:b0:374:c142:80e7 with SMTP id ffacd0b85a97d-37cfb8b14eamr2128521f8f.1.1727868045945;
        Wed, 02 Oct 2024 04:20:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ce64:813c:ca8:36b5? ([2a01:e0a:982:cbb0:ce64:813c:ca8:36b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6488sm13786576f8f.46.2024.10.02.04.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 04:20:45 -0700 (PDT)
Message-ID: <2b49c4df-a34a-42c5-8d44-9e47da630fe8@linaro.org>
Date: Wed, 2 Oct 2024 13:20:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 08/11] clk: move meson clk-regmap implementation to
 common code
To: Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 pierre-henry.moussay@microchip.com, valentina.fernandezalanis@microchip.com,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-hula-unwashed-1c4ddbadbec2@spud>
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
In-Reply-To: <20241002-hula-unwashed-1c4ddbadbec2@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2024 12:48, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> I like this one better than qualcomms and wish to use it for the
> PolarFire SoC clock drivers.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   drivers/clk/Kconfig                           |  4 ++
>   drivers/clk/Makefile                          |  1 +
>   drivers/clk/{meson => }/clk-regmap.c          |  2 +-
>   drivers/clk/meson/Kconfig                     | 46 +++++++++----------
>   drivers/clk/meson/Makefile                    |  1 -
>   drivers/clk/meson/a1-peripherals.c            |  2 +-
>   drivers/clk/meson/a1-pll.c                    |  2 +-
>   drivers/clk/meson/axg-aoclk.c                 |  2 +-
>   drivers/clk/meson/axg-audio.c                 |  2 +-
>   drivers/clk/meson/axg.c                       |  2 +-
>   drivers/clk/meson/c3-peripherals.c            |  2 +-
>   drivers/clk/meson/c3-pll.c                    |  2 +-
>   drivers/clk/meson/clk-cpu-dyndiv.c            |  2 +-
>   drivers/clk/meson/clk-dualdiv.c               |  2 +-
>   drivers/clk/meson/clk-mpll.c                  |  2 +-
>   drivers/clk/meson/clk-phase.c                 |  2 +-
>   drivers/clk/meson/clk-pll.c                   |  2 +-
>   drivers/clk/meson/g12a-aoclk.c                |  2 +-
>   drivers/clk/meson/g12a.c                      |  2 +-
>   drivers/clk/meson/gxbb-aoclk.c                |  2 +-
>   drivers/clk/meson/gxbb.c                      |  2 +-
>   drivers/clk/meson/meson-aoclk.h               |  2 +-
>   drivers/clk/meson/meson-eeclk.c               |  2 +-
>   drivers/clk/meson/meson-eeclk.h               |  2 +-
>   drivers/clk/meson/meson8-ddr.c                |  2 +-
>   drivers/clk/meson/meson8b.c                   |  2 +-
>   drivers/clk/meson/s4-peripherals.c            |  2 +-
>   drivers/clk/meson/s4-pll.c                    |  2 +-
>   drivers/clk/meson/sclk-div.c                  |  2 +-
>   drivers/clk/meson/vclk.h                      |  2 +-
>   drivers/clk/meson/vid-pll-div.c               |  2 +-
>   .../meson => include/linux/clk}/clk-regmap.h  |  0
>   32 files changed, 53 insertions(+), 53 deletions(-)
>   rename drivers/clk/{meson => }/clk-regmap.c (99%)
>   rename {drivers/clk/meson => include/linux/clk}/clk-regmap.h (100%)
> 
<snip>

I don't have objections, but I think Stephen didn't like the idea
a few years ago, but perhaps it has changed...

Anyway, take my:
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

