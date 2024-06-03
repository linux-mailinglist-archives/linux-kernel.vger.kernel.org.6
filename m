Return-Path: <linux-kernel+bounces-198818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097558D7DEE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB71C21AD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73457E0F1;
	Mon,  3 Jun 2024 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RraybhmK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D453D551
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404955; cv=none; b=aolVKAb1AwuTeCGD3N0BVmkAxjUoXuWUpFhpUa07Bdpqza2TZF0XCHrhWT143pksEqkqEFoEULMfefqdFxx81Yg3iKZoWD6CojfNfvLfKG4JljVsPVZ2j77lwfuP/bFOfr5j8MTkC5n1gyhYQOxyUPDM3n/Ir06Hq4lPrwr3l68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404955; c=relaxed/simple;
	bh=IRsdLd+GS08wMOVpra3Hk7fNKRzBRjboEJdgkdPCZAI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dLHnpZ5jG2UhNGCfhHZ8PjWqFbR3rPfvfmuS4zzPnqiGUnuNRNY5tvxVqvM5Lhv0S//WQXuktZum5VPOBK5pvuyBtQbmgZl844Cy6iJqhndtjoS/onygdar8FW4JJbZJm4oGvlwB8zUyv3IWShvmtNw20OM6ofnVNf3ACELpUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RraybhmK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4213be171f7so6423305e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717404951; x=1718009751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QAeBcdtYqLIs/Rh+i5kD5TSLdR9qGs4llUtwWZdmtc=;
        b=RraybhmKRnCA4ZLLRoK4SQ5tHnlKR+94lMxkQvNX1e0EFdGOdBw1IPVKzfWWNG74oo
         C95tvjVhoEveCmYQrNmK39k16o2m7qtjeIajCsjyb2zraliOBrtvxiJigmWg8iOao4SV
         TMQ2k/HZPxqHdiTdhtPJQTx50mtNY9UizYMdBC7oL8Q+MNhh5YwNAkRqFq33BCD4nk+E
         hxaGmFCqXj9eaQioezXrnCSfrfmo7aetPi1cR+2MYge19bJ9TOjDcl0ZepLc9gvoDMbR
         EfeG5gIHGSZVVqBZp7CQnlhXX6/0/5xaAoURih5OfIyMyDkS2YsFpLHVN3r3vN8HU/OB
         bLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717404951; x=1718009751;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/QAeBcdtYqLIs/Rh+i5kD5TSLdR9qGs4llUtwWZdmtc=;
        b=WlTpRvkXdpXAED7TQgrX/lpZZGZEjsxDueC82t9GW7HU9vcgUZHNnRaJWG/dhCoKLH
         RIvi9WUW23BqftVwMz1BhJf4LWzKyLNRVRWIcSWmLaYY0ybg3r/aaByTnWUGLPGSAItb
         jpSEIb16er7fTtjs3yu8U+8My8ecMgUYesVOcS71+SYHBBCk1RA6zY3prnsDB5AM3Vg4
         GKeICeSGoa1nB9I0jkwnea5U22+z0ui2yqvLU+jljzE85AOXHJdi+j9vmQsE7Do3CxgI
         yRVglYjLMM9P/LYghLORfHUmkjGlLg4p1ub6EP0baWoUrLbLd0Xx+GCGeKL13q+gjBow
         CC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUmOG8DczjkSLHIHFIm0RiamgGjczDiRuO/OSGt7pUdbmppceSxpfFeneu2A/u8w6m9x1VovmMSKKIXTk7nsJ/7CQimjdaPYGlz40b
X-Gm-Message-State: AOJu0YxRUHZTViZ4nwiad7/1GEusYLpi4DMstptT3vyYE25Wh037c1UE
	bzECSEpOrIgspPppr1Ef4fH9GFVD28clBrrMVNvB+PK8YduBIzmrtValDCXaW0s=
X-Google-Smtp-Source: AGHT+IG4nbGZZdOjaAgpRmBbLec9RiHVzWyTIMWSj89sEDhnbEfh2N4e2rnLcxVfA/uyYM5cYYFysg==
X-Received: by 2002:a05:600c:3550:b0:420:1853:68c3 with SMTP id 5b1f17b1804b1-421417bd9aemr653405e9.20.1717404950955;
        Mon, 03 Jun 2024 01:55:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:79fe:b764:2b06:ab4b? ([2a01:e0a:982:cbb0:79fe:b764:2b06:ab4b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b858424sm110180695e9.21.2024.06.03.01.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 01:55:50 -0700 (PDT)
Message-ID: <a4b22708-e85d-448a-8145-244b49bca053@linaro.org>
Date: Mon, 3 Jun 2024 10:55:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/14] Add initial support for the Rockchip RK3588 HDMI TX
 Controller
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
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
In-Reply-To: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 01/06/2024 15:12, Cristian Ciocaltea wrote:
> The RK3588 SoC family integrates a Quad-Pixel (QP) variant of the
> Synopsys DesignWare HDMI TX controller used in the previous SoCs.
> 
> It is HDMI 2.1 compliant and supports the following features, among
> others:
> 
.

..

> * SCDC I2C DDC access
> * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
> * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
> * Multi-stream audio
> * Enhanced Audio Return Channel (EARC)
-> Those features were already supported by the HDMI 2.0a compliant HW, just
list the _new_ features for HDMI 2.1

I did a quick review of your patchset and I don't understand why you need
to add a separate dw-hdmi-qp.c since you only need simple variants of the I2C
bus, infoframe and bridge setup.

Can you elaborate further ? isn't this Quad-Pixel (QP) TX controller version
detectable at runtime ?

I would prefer to keep a single dw-hdmi driver if possible.

Thanks,
Neil

> 
> This is the last required component that needs to be supported in order
> to enable the HDMI output functionality on the RK3588 based SBCs, such
> as the RADXA Rock 5B. The other components are the Video Output
> Processor (VOP2) and the Samsung IP based HDMI/eDP TX Combo PHY, for
> which basic support has been already made available via [1] and [2],
> respectively.
> 
> The patches are grouped as follows:
> * PATCH 1..7: DW HDMI TX driver refactor to minimize code duplication in
>    the new QP driver (no functional changes intended)
> 
> * PATCH 8..11: Rockchip DW HDMI glue driver cleanup/improvements (no
>    functional changes intended)
> 
> * PATCH 12..13: The new DW HDMI QP TX driver reusing the previously
>    exported functions and structs from existing DW HDMI TX driver
> 
> * PATCH 14: Rockchip DW HDMI glue driver update to support RK3588 and
>    make use of DW HDMI QP TX
> 
> They provide just the basic HDMI support for now, i.e. RGB output up to
> 4K@60Hz, without audio, CEC or any of the HDMI 2.1 specific features.
> Also note the vop2 driver is currently not able to properly handle all
> display modes supported by the connected screens, e.g. it doesn't cope
> with non-integer refresh rates.
> 
> A possible workaround consists of enabling the display controller to
> make use of the clock provided by the HDMI PHY PLL. This is still work
> in progress and will be submitted later, as well as the required DTS
> updates.
> 
> To facilitate testing and experimentation, all HDMI output related
> patches, including those part of this series, are available at [3].
> So far I could only verify this on the RADXA Rock 3A and 5B boards.
> 
> Thanks,
> Cristian
> 
> [1]: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> [2]: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
> [3]: https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-hdmi-bridge-v6.10-rc1
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Cristian Ciocaltea (14):
>        drm/bridge: dw-hdmi: Simplify clock handling
>        drm/bridge: dw-hdmi: Add dw-hdmi-common.h header
>        drm/bridge: dw-hdmi: Commonize dw_hdmi_i2c_adapter()
>        drm/bridge: dw-hdmi: Factor out AVI infoframe setup
>        drm/bridge: dw-hdmi: Factor out vmode setup
>        drm/bridge: dw-hdmi: Factor out hdmi_data_info setup
>        drm/bridge: dw-hdmi: Commonize dw_hdmi_connector_create()
>        drm/rockchip: dw_hdmi: Use modern drm_device based logging
>        drm/rockchip: dw_hdmi: Simplify clock handling
>        drm/rockchip: dw_hdmi: Use devm_regulator_get_enable()
>        drm/rockchip: dw_hdmi: Drop superfluous assignments of mpll_cfg, cur_ctr and phy_config
>        dt-bindings: display: rockchip,dw-hdmi: Add compatible for RK3588
>        drm/bridge: synopsys: Add DW HDMI QP TX controller driver
>        drm/rockchip: dw_hdmi: Add basic RK3588 support
> 
>   .../display/rockchip/rockchip,dw-hdmi.yaml         | 127 +++-
>   drivers/gpu/drm/bridge/synopsys/Makefile           |   2 +-
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h   | 179 +++++
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 787 +++++++++++++++++++
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h       | 831 +++++++++++++++++++++
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 353 +++------
>   drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 351 +++++++--
>   include/drm/bridge/dw_hdmi.h                       |   8 +
>   8 files changed, 2290 insertions(+), 348 deletions(-)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240601-b4-rk3588-bridge-upstream-a27baff1b8fc
> 


