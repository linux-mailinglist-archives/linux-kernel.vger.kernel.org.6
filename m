Return-Path: <linux-kernel+bounces-374028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F19A60CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F6A1C21851
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD263194C79;
	Mon, 21 Oct 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJ3OQbwB"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742961E3DF7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504583; cv=none; b=Kv5zIO1zr+ENlin+A3hiGjNY6/tqgGmQccngnQ7Ii8gppZJjlK4/cDDxu0rCVSUmW/01XqZOrdflOI5QSF0IQHMMZJSwocM7omVkwgcr/uR/HO4IRiIBZpVt8rFQRltKfiFTANJp5h3KzdblM1O5shIm22wK0zVOCCo3rH3FnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504583; c=relaxed/simple;
	bh=WBJvHRoXXbzP49rdematYA3nl3HhQbf+5RyBGTJLCvU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EalreF//8n3DNjBy5TliL3oxItmPKGfGgYt9gCK5xVVYmwLRuOv/xqAMj0IWAPUOss3YqRpIPNf41Fw+6LWEwwC+PE4PTMAFyNjX/OjrptAJjfV6WqE21fnAA6rLu4foeNEeiBdn9QzJ8fYDpfo3rTmmGnSYaXQ5KZYWuF/xSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NJ3OQbwB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431481433bdso45061515e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729504578; x=1730109378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cgpfJEhAzWrKHn6Saq9h1Ti1FMhjMlcxODJjL9mRHOo=;
        b=NJ3OQbwBV5c1f8k64fB4X0i+ZyJhvJAGTCv3pdwlyjuvd4zlsarknq7Z6K6maY5YHF
         evuY3ihmeqa5PwR/g1H8VUip5bXQ/o9i6BVgKybfYAnSD5nEq7lOPYwVA3OkAevXr8tW
         5EG8nOQvgIaLjgAMkprFeHIPewgJRehvinkvn0cmmyKV0mqXgzdPYQfXF8BZQwxZ40yS
         Nw+tnp5i3VmTct45eHDjefh+ZrgWJP6hsNBR8NMrZfzygwLrjKgLdIAu6Hu90oylP78q
         oZZxeNIpbsRunXJh++IqczhLpgpkh2nLFd/HQZcW1OGuLiu14DQ6uekEpOzSOR9Z6hDm
         izPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504578; x=1730109378;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgpfJEhAzWrKHn6Saq9h1Ti1FMhjMlcxODJjL9mRHOo=;
        b=jHA5kpidnq/6WA7l+J/+JLpW83TQ/HXbD0feX+5vYNExaFwA0iJPYGQLsvkj5+UQLU
         kkavUyx4xJENgKmdiFHxVuMXBwEaTIxOTizXAwKjwYhX/nMWdCBRKUB91VcHGJiiJv9+
         26KfJZJZ5LInqSftE3bPpJqxq282QxgJ2hAIsd1jEwZagT/S9JNzI1Bl8JlNAeYgvBeZ
         k65zhBDB4+AzIA50s9gy3BoHNm4SlxTN/p55MWp9I4JzWT/p4J2j7FQ4sT9fKwgQweYJ
         +Fl/NMv9ZVqbzzS/nhWgeImas3io3vk31eJJd7s2inOfhR0nx4FiCYqYtkECA+BGo+8g
         Ik9w==
X-Forwarded-Encrypted: i=1; AJvYcCWNOwSbQV708rYNeEob6fPU73kXhRh2/7mzfSqAQ8zBMnXrlBKSPN7hPhAX30WS9NUaFeVl23YbDyz7+V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWK+7WGpdK3FOFs3+Wd7JmHa16LABEkfl53t1YeUAm8tC7MC2
	kYSmWkh5iaeawSSS1zOx2jPIhMkMtxvf6+qXKJ2bZnvvCIymLMrvcmZx7Loy2PI=
X-Google-Smtp-Source: AGHT+IGIDar+yxZvJ1r7QYBzcyotgUYIxhD9vF51nxf+UIHlreyBhCllflKvNHMM3hS9BUwcrAFqGQ==
X-Received: by 2002:a05:600c:3b89:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-4316168f6f8mr92889655e9.29.1729504577692;
        Mon, 21 Oct 2024 02:56:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3908:dea6:2ddd:be97? ([2a01:e0a:982:cbb0:3908:dea6:2ddd:be97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570d86sm52686215e9.8.2024.10.21.02.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 02:56:17 -0700 (PDT)
Message-ID: <f9c2a209-1234-4663-b37a-9e0dabc448da@linaro.org>
Date: Mon, 21 Oct 2024 11:56:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/6] drm/atomic: add interlaced and ycbcr_420 flags to
 connector's state dump
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
 <20241019-bridge-yuv420-v1-2-d74efac9e4e6@linaro.org>
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
In-Reply-To: <20241019-bridge-yuv420-v1-2-d74efac9e4e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/10/2024 23:49, Dmitry Baryshkov wrote:
> Although the interlace_allowed and ycbcr_420_allowed flags are a part of
> the struct drm_connector rather than struct drm_connector_state, still
> include them into state dump in order to ease debugging of the setup
> issues.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/drm_atomic.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 0fc99da93afe..9ea2611770f4 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1132,6 +1132,8 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
>   	drm_printf(p, "connector[%u]: %s\n", connector->base.id, connector->name);
>   	drm_printf(p, "\tcrtc=%s\n", state->crtc ? state->crtc->name : "(null)");
>   	drm_printf(p, "\tself_refresh_aware=%d\n", state->self_refresh_aware);
> +	drm_printf(p, "\tinterlace_allowed=%d\n", connector->interlace_allowed);
> +	drm_printf(p, "\tycbcr_420_allowed=%d\n", connector->ycbcr_420_allowed);
>   	drm_printf(p, "\tmax_requested_bpc=%d\n", state->max_requested_bpc);
>   	drm_printf(p, "\tcolorspace=%s\n", drm_get_colorspace_name(state->colorspace));
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

