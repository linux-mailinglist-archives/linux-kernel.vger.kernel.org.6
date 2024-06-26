Return-Path: <linux-kernel+bounces-231197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AFC91878C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6F6B22651
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99318F2EA;
	Wed, 26 Jun 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwRHRWV9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773518F2CA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419718; cv=none; b=bpK+iO6l+gXh/SPVAp+Ldl/PZJOvZwa88bjAb8znZiTwGXBTz2h35XpOyxI9pn1azM+Urk+bTDZ4a5r/3ZWi85NnBh2xU/bd8GzrzpuvWv77j/qPjp+Yuom8GISKi7kSYMJxJ7V6GaYz485QlZ+Gr0vvWIta1o5pevOU0r0wkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419718; c=relaxed/simple;
	bh=kgGAP2jiX9oay6z5BxbbxJlZ5+1RVmCwiBdWsINvYMM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BVRzsbagLdXBuGAmrGr+XfOwIRsOcv5uudLUc2La+iQKTdBd4uFjyRP0EDmpGkgm5HFOurHL8Nwb39ukevn1unL1csbcM7wNZyRVzhWeFb+OegxfxHPauXW2tBQBJnge4KF0tpvSO65o7/svcVTap/BEhiAgA7ZmiBVbIgH4MZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zwRHRWV9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4255fa23f7bso4953065e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719419715; x=1720024515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVNombFGh6XnGXwdeuW//QrSGHhjwRxXK5+Bp5Yi1fc=;
        b=zwRHRWV9ZF20Ai9uvhdKcVYYdTZ3BubjHyt10E6GL1mvsm+c36nTjwOmiVV+w0x3Ey
         r2N9fpINH6NCUKLTZf98fxScNUhfGtlhrGfiqvbSuXTKI+yDYSBCf3h2rVCOMbAlMUZq
         N2Mr+tctPB1wqZDGfqxiJxYDBegRWoB/v4/l9Tl3edag0YCgsIEhADPi3et0nUC0k+7q
         Ac/C3vk6VGydtGA/7n84Z80x5PV8ePMs9JH331kgu3MoVxH6e6JOyL9dkQhs5Abk5Sky
         UpicJMuN7XKe1eSKo+qyZoRj88Jdz0YSxNSGZuWyoebzh5R+TNZ+RBmL+1NLGIDku5S5
         Fz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719419715; x=1720024515;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IVNombFGh6XnGXwdeuW//QrSGHhjwRxXK5+Bp5Yi1fc=;
        b=AeC5tSSrt5oi/SMTl+0GLZT5l0U3GWryehwfRe9lmfBs/unNrKnCPiEov+lh3RK+PK
         TGR+H2/93Mkp3VI88aI586FZ7S8uMDmU9Bp3XRPrMpljBA6AasabcpUlXV5xrrU5IxuH
         O4Jn/MGI9pVFaV+HRCpRlHMESuLypER3jWMTqcwjn5j9ixkEidpEcENmCnh8sKwPDEks
         PqJz1NVUmOQvEwyq5xPsgWDXbReMSW0G8JDCCT9yD6lccSqNZpawJ5cO0mHMhMxasYIK
         WrkzOaVuNBspWRdP6FtNUwQo34Ozt9dNub69Xg9zX8KrenN2Tb9zvcOBFxUF5PJPk13X
         nQWw==
X-Gm-Message-State: AOJu0Yy9kX2DbXq+fEAxzpoPux9A/UhYc5tgQK7Iikt5s7iV5EyUHdEj
	WCSV0c4nF/4owYoBNks0dpSuBrgoVuF9xjBREoVUAg4KfcvS14LdVwyXrCv9yeI=
X-Google-Smtp-Source: AGHT+IF/H3qe3QkAkh67maafTcj7zPClcHcEdJ3mjvr0P7EcQetcMG/YNSoiIEG0zx2IAQ4inoE7dw==
X-Received: by 2002:a05:600c:3c8d:b0:421:a575:99c9 with SMTP id 5b1f17b1804b1-4248fe3fa35mr63895905e9.20.1719419713858;
        Wed, 26 Jun 2024 09:35:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:afc0:84d8:433a:2d67? ([2a01:e0a:982:cbb0:afc0:84d8:433a:2d67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82519c8sm32498645e9.16.2024.06.26.09.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:35:13 -0700 (PDT)
Message-ID: <bc7edabf-fec7-4626-bba1-03a78c87b500@linaro.org>
Date: Wed, 26 Jun 2024 18:35:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] drm/mipi-dsi: add mipi_dsi_usleep_range helper
To: Jerome Brunet <jbrunet@baylibre.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240626142212.1341556-1-jbrunet@baylibre.com>
 <20240626142212.1341556-3-jbrunet@baylibre.com>
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
In-Reply-To: <20240626142212.1341556-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2024 16:22, Jerome Brunet wrote:
> Like for mipi_dsi_msleep(), usleep_range() may often be called
> in between mipi_dsi_dcs_*() functions and needs a multi compatible
> counter part.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   include/drm/drm_mipi_dsi.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 71d121aeef24..0f520eeeaa8e 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -10,6 +10,7 @@
>   #define __DRM_MIPI_DSI_H__
>   
>   #include <linux/device.h>
> +#include <linux/delay.h>
>   
>   struct mipi_dsi_host;
>   struct mipi_dsi_device;
> @@ -297,6 +298,12 @@ ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
>   			msleep(delay);	\
>   	} while (0)
>   
> +#define mipi_dsi_usleep_range(ctx, min, max)	\
> +	do {					\
> +		if (!(ctx)->accum_err)		\
> +			usleep_range(min, max);	\
> +	} while (0)
> +
>   /**
>    * enum mipi_dsi_dcs_tear_mode - Tearing Effect Output Line mode
>    * @MIPI_DSI_DCS_TEAR_MODE_VBLANK: the TE output line consists of V-Blanking

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

