Return-Path: <linux-kernel+bounces-373810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA09A5D18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4B7B25AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97421D0E15;
	Mon, 21 Oct 2024 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNNKxpB3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75111DF734
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495816; cv=none; b=h0TtlbWmq0b9eLF92+mqvqZT2w9nlgjvV1Y3IgCuOtVpQ5CCJWW+DuRztps0ctAepBE4+GfSqZDLkQMacWWjX44Ds4hbKdyIjhNjFTpGAaEOCv1dn4ljKfZyqTO0No7UH+cumtabBaS/WcGfAGfpKFQZoWAs83ATIR+ZEibBZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495816; c=relaxed/simple;
	bh=GcjvyuU+Anj3nafKua3s9OX4PuczqAU2+2s9KUnhq/Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hQdbqk8aX1Nvv0bvp6dHBzul0PNjDQbWQRnmYqIY4mgHXlmGr0MmfVji+XfDLMg3K8D8QANOXDYdXQX5V1AHWZeOaDAEUIjbY19e2oWCEND83cqeiQDqp+nCBpWc8Ep0zLB/PhthamiCsxAC/AuOQYllYi4bVKZXJoYhWBBaBTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iNNKxpB3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43158625112so40364665e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729495812; x=1730100612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFWiSRU+E0T2EnN+h3/EdYDS8QJTZn1YySSnOLAXaNA=;
        b=iNNKxpB3e4ZYMaQpLLTdVl0DBZ7rc7JXWxZak/1QYEg+Y8VBT1nfcKR1Nc1NpKrhkL
         cyCaQLKgUYPGXTWQi+PsNtBEIf+dFqQzTCsEZO7VpOGntTZzP95Yr8Pn72JUTinTwyyg
         TjMs+sJ8GeHB5cmbDoHQQjM+0KyLkyzw0+dj5XgwlzulpzQJTuVVhOxO9dOyoYbd+iL8
         r0ugX3fZ82Wfp9dA/sQNNRdckkR1lAWbiXBvsAQMyDByGOlMFwhXPmdXc3o8Estdsb2X
         EntxDY60SU2k7yHQFOHXyosUOB70cBbqRLCh4A4s8MLJz86syWPN7In1Q492DsfNfmoc
         h65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495812; x=1730100612;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rFWiSRU+E0T2EnN+h3/EdYDS8QJTZn1YySSnOLAXaNA=;
        b=MPWAatga6d8FLcMmEEdWaHBp2KX99P8a8IxkC8QQpHQWu92zWiAZs0IROBBVRhEDK+
         FfkukZqyAcLZ+LFCabGAjztfKwIrKxjk0N2fZvZc6i0I5WQUHOKmsoVxiT3fZ5yWXON9
         nxhRUdPUbQnjG6ylwcVA7XjXiwsBGlj6zRL37a+Rsw+TlkJwo3jfr0f7FtqLSMzgxLaW
         Ccv+eFeGIzPiC61U+m3CFIOh9iU5aGYOgP3gxeEcOcPuU2Ert555bBLcaXbjL1J1PV5l
         Wtp7U744bpgheGg+DimehZee2Z0tf6CZkEdqTxpMVwGnXraKu+kfbei7kZ+4Z+5q2pSF
         ENDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPFFOIKRB6VX3s50I0yXg9wjBxlXvFupAVFkKnwxUBQW3CIHYsh4OjJz4IOjRXfp4SEg9kJRkYtknRGJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX6cl3zVlHBUUghotIiQDFBuy+xV25Uq/9w1ZX63ZjKuKuEoDH
	RDXmlRVq2QM1lTcrsQTojurYixPRX31ICiJQ0E+GWUYR22WgpsKSzIwbnHnvz5I=
X-Google-Smtp-Source: AGHT+IEWHJSABtiE4Y1+3d+0nQDBiBZ/096ktfb8dHOQacmmZT08uUrkQlfuwa4ruGF8dEl9Wva13g==
X-Received: by 2002:a05:600c:674a:b0:42f:8229:a0a1 with SMTP id 5b1f17b1804b1-431616adba5mr73274585e9.33.1729495812076;
        Mon, 21 Oct 2024 00:30:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3908:dea6:2ddd:be97? ([2a01:e0a:982:cbb0:3908:dea6:2ddd:be97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc5b9sm47149335e9.45.2024.10.21.00.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 00:30:11 -0700 (PDT)
Message-ID: <2bcb1942-f636-4e1e-aa32-7755309ca655@linaro.org>
Date: Mon, 21 Oct 2024 09:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 6/6] drm/bridge: dw-hdmi: set bridge's ycbcr_420_allowed
 flag
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
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>
References: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
 <20241019-bridge-yuv420-v1-6-d74efac9e4e6@linaro.org>
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
In-Reply-To: <20241019-bridge-yuv420-v1-6-d74efac9e4e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/10/2024 23:49, Dmitry Baryshkov wrote:
> Set the drm_bridge's ycbcr_420_allowed flag if the YCbCr 420 output is
> supported by the hardware.
> 
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 0031f3c54882..996733ed2c00 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3503,6 +3503,9 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>   	hdmi->bridge.of_node = pdev->dev.of_node;
>   	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>   
> +	if (hdmi->version >= 0x200a)
> +		hdmi->bridge.ycbcr_420_allowed = plat_data->ycbcr_420_allowed;
> +
>   	memset(&pdevinfo, 0, sizeof(pdevinfo));
>   	pdevinfo.parent = dev;
>   	pdevinfo.id = PLATFORM_DEVID_AUTO;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

