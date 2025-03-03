Return-Path: <linux-kernel+bounces-542341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D4DA4C8B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7264D1895BA9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C324A062;
	Mon,  3 Mar 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="suuUEiKk"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4A248176
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020147; cv=none; b=Mz/HJAO37qii/aaG9qpcFWEp2jzdxYvZ6vMeMiCUeB662MlZC6GbT6z6g25HqR92ajafbnAUJ4U1cUwh/KEqmZ0dNA19E4hE+uTOlGRTz+DVdBC/HKY+0aNNmiIfJwN0KUHk+lljhDkC9YSvn06VzvNVtYr8NMQTXgxobxBBMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020147; c=relaxed/simple;
	bh=fsleVHd6/yEG34rdbEVKshgXN3hhu3qk/4aR80P4fpc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kyvwxjkv2Ef3RZRBRHgKo9k04SLezZmVI0WLBdRFmvf/9L1clVIGXmhjTRl76tvUJCxp3e6fRYKxXXPKIzdsFZ5uv4fpZpHM3WspLj+37vYRkfz+W0gcVr+YwQRmMG/5jRA4xZg0nB/srXkkC/TZiFHg2LrJV5URBXmQwN/Z4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=suuUEiKk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390f69e71c8so1743141f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741020143; x=1741624943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFKFKTz3f/ODCWb43+xuXVSlIieWn0Rv+6AT+FvWruI=;
        b=suuUEiKkQyoPOGbnYPIXvnE9RLulziY00iPPorLLBfUlrPE30VI6URVMor0hjThQmp
         rKKYjqRChXxHiXyIXFewsfdkWIQgpUbjW48kS2leyd1lXTwzCtgEoH3sQ0M7YazzVx/f
         qdF3O0Xzvya+wr9cO7W8ObcjC4J8NdSam712XR5Kqw41dvsPNq/4J9KWzDHgV6X/QdSr
         FKgSWFpySC5pQwM+ff0WathiBqQAHWzO1uw88WtmTfDH6J8Zmqm7ACKNwa9IZ81vUjqU
         zFaQpbxLiupxP3YXxYDYjaZm9BgmauqYWHUUR1XdCWU+Z9wV2uA0aVV5HCl6v/dWMcDX
         iG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020143; x=1741624943;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iFKFKTz3f/ODCWb43+xuXVSlIieWn0Rv+6AT+FvWruI=;
        b=t4Xt6pXndaP/wKLF9ALcRzKVXq38LMCezbMIK0Yp+tpY7IccK+q860M3eLklAvRz7G
         SBqQehYcJa8oTDDo/VnWDB30qWRRmzDaYV0b+1W/mVyMVAW0bmpeDHdMho7rf0oDg7sr
         2U7dKFY4rlO6T+8K/QhpH8TMbpb8zZ6032mcmfF8UEJBoRGuZEk1X6ZAwjWwxbspGmjz
         YO/1P7ObJbkZnBLM2nmdQyVHtqYIdyVkEg06ICGPdvki+s+ySK58ei1CytIfSlk/vWAD
         GmVyLmRRt0gQCaXCJznDc4+zPmBE0skPdZ+o8ZqcZWscyu5Q5IO2q90ZPpQ93yllJm3i
         OVPA==
X-Forwarded-Encrypted: i=1; AJvYcCU/QGDDPGhEByJMnYK6kGtinCCR+75zhkyCulo7fX8oQdUo+M4rItGI1sG7YMcNMmcTjGam0pS7MVzzVX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzco+Ju04vavZXIiL+2sr34FjQ4986Qtfw38MHx6GK/oWV0pIwL
	DrYsnOChMowG79RbWFn1f/wul77sv5E1Rafy4Ucewa9xWWYf0GJLD2xng9JVVQM=
X-Gm-Gg: ASbGncunFbM34sqtOjpBhwr9KeVGvTgbd/5fi4Mr+1Nzz4WLTrinF3nWMu3DtZL8xOa
	fr0TTC3VVYxAjT/6tEPEHMQmPNYAWh6e0U5C/dAT10Z0u0qXw2j/TW9cdL1kQWwKkfcGH/u85R3
	utr2S9IOcSiCXSjd1NFWQM3JuSb0B+pxW6hqGcUP9ylud1pgfXG2pcJXGUaovzPHUsPjk2AUhOv
	jusrAvm8qJjP4OHlVyFMo9O3U7anD2EINbc7JwMk0e+9yMdFV6NWC8IKHETxvGnsjONTE4dIE6n
	EjWb6TnbmEIiXf8dM5cGSmuL+UrU+9DOVWK16Nq9H136SvReorK6W98jl67LzTWykBFVNs+JD90
	nReVQRw9Par66S2arBm+qoQ==
X-Google-Smtp-Source: AGHT+IERr7trlQog+kaqqAb3/Ic3azfyefHYSZ50wtP9WNSBDS9iVBnCIw5D4hRIB3JQ4kfjJRTwFQ==
X-Received: by 2002:a05:6000:1fa9:b0:391:e1f:4c29 with SMTP id ffacd0b85a97d-3910e1f4d09mr3013310f8f.13.1741020143525;
        Mon, 03 Mar 2025 08:42:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1c49:dea2:d749:5015? ([2a01:e0a:982:cbb0:1c49:dea2:d749:5015])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc57529fasm28363735e9.31.2025.03.03.08.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:42:23 -0800 (PST)
Message-ID: <c3927b51-55ef-4a38-8931-18ff00caa8d8@linaro.org>
Date: Mon, 3 Mar 2025 17:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v7 0/5] Driver for pre-DCP apple display controller.
To: Maxime Ripard <mripard@kernel.org>, fnkl.kernel@gmail.com,
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alyssa Ross <hi@alyssa.is>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Neal Gompa <neal@gompa.dev>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Nick Chan <towinchenmi@gmail.com>
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
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
In-Reply-To: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17/02/2025 12:39, Sasha Finkelstein via B4 Relay wrote:
> Hi.
> 
> This patch series adds support for a secondary display controller
> present on Apple M1/M2 chips and used to drive the display of the
> "touchbar" touch panel present on those.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
> Changes in v7:
> - No changes aside from adding r-b trailers, effectively a resend.
> - Link to v6: https://lore.kernel.org/r/20250206-adpdrm-v6-0-c8ab9348b853@gmail.com
> 
> Changes in v6:
> - Use the drm_connector_helper_get_modes_fixed helper.
> - Split out into a separate MAINTAINERS entry
> - Link to v5: https://lore.kernel.org/r/20250205-adpdrm-v5-0-4e4ec979bbf2@gmail.com
> 
> Changes in v5:
> - Moved to using the component framework.
> - Other lifetime fixes
> - Link to v4: https://lore.kernel.org/r/20250114-adpdrm-v4-0-e9b5260a39f1@gmail.com
> 
> Changes in v4:
> - Fixed dt bindings.
> - Link to v3: https://lore.kernel.org/r/20250112-adpdrm-v3-0-c674dc19fa7f@gmail.com
> 
> Changes in v3:
> - Fixed building as module after splitting out mipi block
> - Addressing the review feedback.
> - Link to v2: https://lore.kernel.org/r/20241126-adpdrm-v2-0-c90485336c09@gmail.com
> 
> Changes in v2:
> - Addressing the review feedback.
> - Split out the mipi part of the display controller into a separate device
> - Link to v1: https://lore.kernel.org/r/20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com
> 
> ---
> Sasha Finkelstein (5):
>        dt-bindings: display: Add Apple pre-DCP display controller
>        drm: adp: Add Apple Display Pipe driver
>        drm: panel: Add a panel driver for the Summit display
>        arm64: dts: apple: Add touchbar screen nodes
>        MAINTAINERS: Add entries for touchbar display driver
> 
>   .../display/apple,h7-display-pipe-mipi.yaml        |  83 +++
>   .../bindings/display/apple,h7-display-pipe.yaml    |  88 +++
>   .../bindings/display/panel/apple,summit.yaml       |  58 ++
>   MAINTAINERS                                        |  16 +
>   arch/arm64/boot/dts/apple/t8103-j293.dts           |  31 ++
>   arch/arm64/boot/dts/apple/t8103.dtsi               |  61 ++
>   arch/arm64/boot/dts/apple/t8112-j493.dts           |  31 ++
>   arch/arm64/boot/dts/apple/t8112.dtsi               |  61 ++
>   drivers/gpu/drm/Kconfig                            |   2 +
>   drivers/gpu/drm/Makefile                           |   1 +
>   drivers/gpu/drm/adp/Kconfig                        |  17 +
>   drivers/gpu/drm/adp/Makefile                       |   5 +
>   drivers/gpu/drm/adp/adp-mipi.c                     | 276 +++++++++
>   drivers/gpu/drm/adp/adp_drv.c                      | 617 +++++++++++++++++++++
>   drivers/gpu/drm/panel/Kconfig                      |   9 +
>   drivers/gpu/drm/panel/Makefile                     |   1 +
>   drivers/gpu/drm/panel/panel-summit.c               | 132 +++++
>   17 files changed, 1489 insertions(+)
> ---
> base-commit: b62cef9a5c673f1b8083159f5dc03c1c5daced2f
> change-id: 20241124-adpdrm-25fce3dd8a71
> 
> 

All patches are reviewed, can we funnel patches 1, 2 & 5 via drm-misc-next now ?

Neil


