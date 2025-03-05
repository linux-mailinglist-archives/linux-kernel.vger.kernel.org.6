Return-Path: <linux-kernel+bounces-546234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCC0A4F82A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBFE16CBB0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF361DED5F;
	Wed,  5 Mar 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQBwqW5F"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812721DE4EC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160652; cv=none; b=Jvss8rojeg4XpPUi6iPpNeRzE1jTjMmcFFTKRgBziMJl3b5gLesPut1TWzWdOHD5POw+cEXocTu5FxPUNordLjy75GDntXM/Xs4gQdqfyLYhRMm8jcpU6NAPhL0SKkp8TV+uynmi0r22/CCWRPPUKtZKfLUZhlMqWAOOLjvEzQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160652; c=relaxed/simple;
	bh=so1vOChmRHXBlFtvjtF17fRyfqlljb1Gqqi3fIjYvmE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BeGws6YwJUHcXPijc0zrsqeJVCDSfuIsMjemPpO7F0wpORNXTanhNQWuRFiIm6lKlIobDaYE62DYZej7Wp9jqdmwQKwhic8ob1EEvP1CBVkZDuFP2sLtExFhEOjtceSX+uy7qjgItIzTvOIvpBiT/C27/KbdL6V/CJ4yVT0VB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQBwqW5F; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43995b907cfso41399375e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741160648; x=1741765448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aVVWfpM/R7114kq8yw+67pir5NUPFWO9h9JRxaS7qo=;
        b=qQBwqW5FHdq5FgVHJ7n9X8Z17sp5mtrNMv1ze68knpYPQeEnfqvnuSoqsuCsEQ2PoE
         HgdoOtrtBE47wV2fWkdSgsEIcGHBezYbvXft90kLiLt3MD0U0n8HwlSpoQ0HzLiHBs18
         T0NrrVJuud3wOhFlHgkfNgh2acLckRpwiWdQ2+hBN1qgTelF14GB9WxNHjJduvnPzdqo
         mJ05KRx0rQusiiLF8W1n0QDJjX9H3+emVi2uw9KozZPq2FmMPuYQfGEbC0zWvJgcR+/Q
         7plHFEjOm/rk/eN5gnkJ91lRrxpYvZStk3E3NpA2sU8w1tAhr1O+TNA/cHwP0U4Lxi2E
         jxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741160648; x=1741765448;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+aVVWfpM/R7114kq8yw+67pir5NUPFWO9h9JRxaS7qo=;
        b=mhz83kC+fyV43xcDUi5x51iaOh5qzQTiJaVETBsMtxelWXDGQA/klcAKpfr/yoGI4C
         EJKZaHs0FceVyvpE7+teeQCfhhm1eGcgtP22JbJ9zcCl9ccpw4ZVF5zkHk8qHLA1Gl/w
         2Dj5Le6fAueBmbTuJ1sHXjlwETryAUNJ4Ru++ihdF7A2wGAf0kQ1eD9Ot5xVcWdL6ChP
         dHJ6QSWMcHgHGd1voJB9ZtGW6PUCB5ure7dnmJ5Kx/CY1Qobl2R3fNievULM3T2fU+C1
         JRAQoD3D6I5Q3oW9gIZCPq1bO0+Hkf4IiTcjHq5aASQrvocW3r+CeMZLVhvZ1p7MTkbI
         VwfA==
X-Forwarded-Encrypted: i=1; AJvYcCWHkwqrYWiTk7AqthcCvTPdwFDxHWvfaKDNogD72+RMm+wrAdoEurvtz17K5PudLJvua6X10ThtILvi/co=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyd+9v1HXSMzF2a4J7nfEs1clWRi/t/HErLXlnyn7j+IGDuYU5
	zyKTiDFPSMe31TCFGBVEweJYI/6qvxw6+Tk0hSdl38J2Exl/Mta9gn/yypN6qfdsvj1H5cRrxuj
	8
X-Gm-Gg: ASbGncs57T7xnrzLHMozHF3xzuHvh3LAc8TTDixZsvUOvYbtAFCcxFD9Eq4GNlljgOr
	Am64RZ9t8l8OQoO7SkQlUyxpLZptZ47phyEvvl4Z6JEBBYE+P9srJ+6aoJE0iJwM3rAHaWxhsz+
	kQ+v9rEJwcLpAgEz7qrveLWTUQ/VTnml/SgTz+LCTtMR/Pb4m5EjCmxJ2MTTQAJqgCOplIfnJ5u
	n4d1TrjTuP8vM6vLmRThpt/OkRp+Pcm5DeBU/EL+n9VysfoNavePtYIkPXZ3uxGUdE6joYOOSX2
	tMB5KSPdQbg07bwg+qIbLg4enX8PNE0g5c2wcDUj0PoMuYKXk1HigQnlsRU9ICjPd2UoJ47xgyv
	uLwyZGTq14qT1dpPQl1E=
X-Google-Smtp-Source: AGHT+IEPvMkwnzMHESBZZ3ISL/jIpWI/iMcyXh+NYDVcMmY+PloN4Ai5r0S5PZs9sI+S0GqIqmbenw==
X-Received: by 2002:a05:600c:4f15:b0:439:8c80:6af2 with SMTP id 5b1f17b1804b1-43bd2ae000emr10350255e9.21.1741160647791;
        Tue, 04 Mar 2025 23:44:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:80fe:f5c:3d29:e407? ([2a01:e0a:982:cbb0:80fe:f5c:3d29:e407])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426c355sm9274075e9.1.2025.03.04.23.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 23:44:07 -0800 (PST)
Message-ID: <02fb7b29-6af0-40f2-a187-326fd762835a@linaro.org>
Date: Wed, 5 Mar 2025 08:44:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: fix Visionox RM692E5 dependencies
To: Arnd Bergmann <arnd@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Danila Tikhonov <danila@jiaxyga.com>, Eugene Lepshy <fekz115@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 David Wronek <david@mainlining.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250304142907.732196-1-arnd@kernel.org>
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
In-Reply-To: <20250304142907.732196-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2025 15:29, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added driver uses the DSC helpers, so the corresponding
> Kconfig option must be enabled:
> 
> ERROR: modpost: "drm_dsc_pps_payload_pack" [drivers/gpu/drm/panel/panel-visionox-rm692e5.ko] undefined!
> 
> Fixes: 7cb3274341bf ("drm/panel: Add Visionox RM692E5 panel driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/panel/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 5927806cb4a9..e059b06e0239 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -1020,6 +1020,8 @@ config DRM_PANEL_VISIONOX_RM692E5
>   	depends on OF
>   	depends on DRM_MIPI_DSI
>   	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER
> +	select DRM_DISPLAY_HELPER
>   	help
>   	  Say Y here if you want to enable support for Visionox RM692E5 amoled
>   	  display panels, such as the one found in the Nothing Phone (1)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

