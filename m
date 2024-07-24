Return-Path: <linux-kernel+bounces-260730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D693AD7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D111C1C20E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0581292CE;
	Wed, 24 Jul 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAo1r1aS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057A137C35
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807598; cv=none; b=qrcK5Jg0ypoFlK6AkyqczenHZ+ZhetZkQ2gdFMUTxHfqNCgwEDkaR1JEf60QdoiAjfQO/0zDu0Z5BdqhLPhyElKY266gZJQSS7aNetDh+/ji7+cS1ZFM6yNJB72H3DVek1xTY/iqfLYVEjyXqf6rszV5YqyooCvfLGNYc3hM2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807598; c=relaxed/simple;
	bh=tOT1e8MJiGceTGKKzM8O0kfZwKcCl3jacK9viYGUHwM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W56kX2hFvnzFGLI55PJ8c2LmeEWxRUQwtqk+380rrTMogb0Z4u22gHisJZCG1J+dwm9OajOSABC/f4nymByyIyt2G8Vi4IsvNhB8/oYtHTfF70wQX1NCaQP6wWioedLn8db0bP+ShPZpO28NWm7Nrq0+p/mBvCuswwBoOespv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oAo1r1aS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-427b4c621b9so43244835e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721807595; x=1722412395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2KlSahuFArGhX1/nu3nesKMLISwLS8Oj6J8y4N86tg=;
        b=oAo1r1aSZLJ6ebpXlMxwsp8C+Pl5c113DzkgRkTguEOe/l2BiQtOQlL2ix0LZqlA7V
         EIXQscohxLe2dx/KCn4LvGlDsm8Bcska7CMSp3LLN2MnGIIIXL6xFVD27Y+JNWvxUCdC
         7yvwIXilj44l3SkEOnpHjpyElsRl7PzQVH/B6IXr8DTc8d+ULsNCBJg33r3DpVTaQ/In
         tfM3WBCkCxw04FtrcvB4BaWXP9iXWDsCEA+aggj4T+8kOBErGkcHlQRjewlZtRAxsBnB
         k6FRSexYQAMJK2aHhUMmPXEZv9FcwsNGa1NNiu7rkWAkvbCDPgzpZuUuQM0mHeS4XkbJ
         cFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807595; x=1722412395;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a2KlSahuFArGhX1/nu3nesKMLISwLS8Oj6J8y4N86tg=;
        b=FQqS4kXjKliUt5vQykNx0gfULLfzKtDCpmEVqA+B5OJxKvDETN8vU8sGJMbHIsGZ+x
         t6m9mgXMBqKfWflhw8JLuxRrGFRJkdZIz2DXmwPGHb1T4fvpj6bx4EWC2w7J449J6Zpo
         gtsmuMGu9LnYOVYDFPUH5eu/9M5tYWqIDKx67uWFHet611XEgshfQ/Nuqmt3Wfy4t5wS
         kvBuGolyEHyeVplw/Fsyc6e5dil1bDq8XT0EcsbUn5GN6zLvRdz4KrERSt5AR83Q8A9R
         7JDRtFSDU0PH6YkZPHHunMQlAcMvHz498EhLvKqkBmXQVF5ClxtrC79EO4Iztf07s+5M
         Py+A==
X-Forwarded-Encrypted: i=1; AJvYcCUzO0wddsOi2RFtX/wBUXrhOvhC9t0tZkVOcGU8Pd+30wVqIPPyuOMj7GdPZoYnu6v13Y39pFD577KBzRWDWacE0H4XZ4UUOP15vlUQ
X-Gm-Message-State: AOJu0YxKZvzAxzWNR8KWeiR4emdXAquaB54FQQJRhrSdz9O+qqCC6xiM
	MZaKcWAyqIXtkdDcvEBXHHZ7G6OYXysY7q1bB7MIXuIrTc97TAgchEnfyJOSgHY=
X-Google-Smtp-Source: AGHT+IGwVEKmEHSe9k5B2D7ijwxG0vlMth4QsYhxFpbQgy422sw8HIZrxRw/RlhoiJzflOjRUKSsww==
X-Received: by 2002:adf:e6c5:0:b0:367:8909:197b with SMTP id ffacd0b85a97d-369f5ba036dmr840211f8f.61.1721807594852;
        Wed, 24 Jul 2024 00:53:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7? ([2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787cf156sm13691739f8f.70.2024.07.24.00.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 00:53:14 -0700 (PDT)
Message-ID: <ed6b10f5-f297-4839-a9fa-8c178792ab2d@linaro.org>
Date: Wed, 24 Jul 2024 09:53:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm: panel: boe-bf060y8m-aj0: Enable prepare_prev_first
To: Dang Huynh <danct12@riseup.net>, Jessica Zhang
 <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Marijn Suijten <marijn.suijten@somainline.org>
References: <20240722-bf060y8m-aj0-prepare-prev-v1-1-0e51c0f59d22@riseup.net>
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
In-Reply-To: <20240722-bf060y8m-aj0-prepare-prev-v1-1-0e51c0f59d22@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2024 09:07, Dang Huynh wrote:
> Enable prepare_prev_first flag for BF060Y8M-AJ0 panel so that the
> previous controller should be prepared first before the prepare for
> the panel is called.
> 
> This makes sure that the previous controller, likely to be a DSI host
> controller should be initialized to LP-11 before the panel is powered up.
> 
> Suggested-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
> This fixes display initialization on some platform/devices such as the
> Fxtec Pro1X.
> ---
>   drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> index e77db8597eb7..7e66db4a88bb 100644
> --- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> +++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> @@ -377,6 +377,8 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
>   	drm_panel_init(&boe->panel, dev, &boe_bf060y8m_aj0_panel_funcs,
>   		       DRM_MODE_CONNECTOR_DSI);
>   
> +	boe->panel.prepare_prev_first = true;
> +
>   	boe->panel.backlight = boe_bf060y8m_aj0_create_backlight(dsi);
>   	if (IS_ERR(boe->panel.backlight))
>   		return dev_err_probe(dev, PTR_ERR(boe->panel.backlight),
> 
> ---
> base-commit: 41c196e567fb1ea97f68a2ffb7faab451cd90854
> change-id: 20240722-bf060y8m-aj0-prepare-prev-2db87e7dd996
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

