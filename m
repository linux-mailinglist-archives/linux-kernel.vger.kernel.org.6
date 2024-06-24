Return-Path: <linux-kernel+bounces-226944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8A491462B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF66281143
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79465131E2D;
	Mon, 24 Jun 2024 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u613XxxS"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1F2C95
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220823; cv=none; b=oe0dcEbhPo/ZULLtf5gR7MdPhW18NsRlzMJoYkSMTSHAQ9sBHybCiRg6HlIamVAUu7oUgwdYUTbRiZICIZ0Ln5aN/YANPtXab53Uf1L4bHKPuQNRSBn6nysyy6LN0kvQuHykLZnWaaTYggzmj9vYeIZhvyJjmSlmAuVtySiVtME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220823; c=relaxed/simple;
	bh=6J9hBIJ/TfTiDd4aqIDWPyo9ped7Iioq3c4ra5bbZjU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LixBC2c8qJ8HPaSeV6SDuShbSR0zdph4FIykrk8RT6fJujUV5TlM+iI5SXU6asCAHnVOxHr5d2nxQZZv6YsW2dB2w8a+twyu2jd3wMI2Sb37Lsg4inWv7z8062GkO1qHowYLcFd6J7r1EN8VtQmUOaYCNbmamfPmr2mh+J5afOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u613XxxS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42278f3aea4so34003375e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719220820; x=1719825620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbmsdFqXhQhvnEQu5Ix9nA78YzXIrqpXyv4OIIIx9Kw=;
        b=u613XxxSzOu/VUVtYP2nUyH/RQnhdvT4g+ioOfy8U4HhIqwVqoCCNc14UwN8Sbnxwl
         u2saNGherJJ2aDSoMCkBgq5WTq+haXNRWwyRbbVfetN1Ewu26pYZoRGq2yodnS3tI5R5
         M80om8t0tngMM5eI9kNHUl9QPQXNyKWM0dtFtkUmPKvSrOeJAFBYTMTRRA73CQSmZpN+
         epd0U/mn/rQlMkAN7Tl4tjFfPwfB7F1OCpf8fmc8rUDK2VWoTHY8F7bI/VcMaqYkwm86
         S1CaNtBtI/Fugv/LRPd/ELh0ryQ3KdEhHxZtKHWH8ANTwAin1nhy2waRykhzD4ClYHeI
         2hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719220820; x=1719825620;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KbmsdFqXhQhvnEQu5Ix9nA78YzXIrqpXyv4OIIIx9Kw=;
        b=rHngpPtkLqXpW/d0D07OGbB1VxMOSElj87nugJK95hL/B4MAUGU3rd96IcnyHu1vBr
         FWZvCreAuy+rSttnaisDBb9QZTjlBZ7mGXcnlIkD8nidrE5Nx4MYfn94iZEA8m9XOFPR
         bd/VCj6WqUVUbrlnzRtF8/5EZetfQOyXkdIZs8gnipg/WUtUaPvE06SG3Orbos4P0y2F
         CKrjLrMe2zj0ctth1ZWS7IqLzWWd1GaDOYf8nYNDYrYkK3Rs2kCVbIsXBfsEX+pXn5Ux
         TDZtpwuBJX8nENiDQOfO4hbpVlDmZobLV95eaXDWgxZBE52deE5LUd6TUrjVfDKyx+ys
         uS6A==
X-Forwarded-Encrypted: i=1; AJvYcCVRnNV5XHk+M/PuqoHb2fIGtn8a827+6VOaGdrAyi6eo+hD1PrvAU+DOc1Ec7sLAZ2oUqwE5LXephh4qxyFfzBrGE19aFjbk6qRu2AQ
X-Gm-Message-State: AOJu0Yy3RlxM+iCcObMrn9jdnUnLwLVpdzDug+X0eTYzWTiF8gKtr9h7
	HfBxbvUVTIVooXcvffzoVYxJTrF9+79wJeuj+QZIZh8X2MveVKPqlSWi1uXNkc0=
X-Google-Smtp-Source: AGHT+IFrQuBGPmb21bSe4gE+PEpAMSIhvu1ChdgH/Jh3NGW+9L0wjfpeM1gpbYLXuT+fpdI6/DoYiA==
X-Received: by 2002:a05:600c:2152:b0:424:8838:364f with SMTP id 5b1f17b1804b1-4248cc350b1mr26340595e9.22.1719220820016;
        Mon, 24 Jun 2024 02:20:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74? ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247fe1b5desm149043575e9.4.2024.06.24.02.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 02:20:19 -0700 (PDT)
Message-ID: <2bb62caa-e213-42fa-ac9c-4118f66aee9e@linaro.org>
Date: Mon, 24 Jun 2024 11:20:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 6/8] drm: bridge: dw_hdmi: Remove cec_notifier_mutex
To: Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240611155108.1436502-1-jonas@kwiboo.se>
 <20240611155108.1436502-7-jonas@kwiboo.se>
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
In-Reply-To: <20240611155108.1436502-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/06/2024 17:50, Jonas Karlman wrote:
> With CEC phys addr invalidation moved away from the irq handler there is
> no longer a need for cec_notifier_mutex, remove it.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 0814ca181f04..256e00a97a9a 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -189,7 +189,6 @@ struct dw_hdmi {
>   	void (*enable_audio)(struct dw_hdmi *hdmi);
>   	void (*disable_audio)(struct dw_hdmi *hdmi);
>   
> -	struct mutex cec_notifier_mutex;
>   	struct cec_notifier *cec_notifier;
>   
>   	hdmi_codec_plugged_cb plugged_cb;
> @@ -2459,11 +2458,8 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>   
>   	status = dw_hdmi_detect(hdmi);
>   
> -	if (status == connector_status_disconnected) {
> -		mutex_lock(&hdmi->cec_notifier_mutex);
> +	if (status == connector_status_disconnected)
>   		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
> -		mutex_unlock(&hdmi->cec_notifier_mutex);
> -	}
>   
>   	return status;
>   }
> @@ -2577,9 +2573,7 @@ static int dw_hdmi_connector_create(struct dw_hdmi *hdmi)
>   	if (!notifier)
>   		return -ENOMEM;
>   
> -	mutex_lock(&hdmi->cec_notifier_mutex);
>   	hdmi->cec_notifier = notifier;
> -	mutex_unlock(&hdmi->cec_notifier_mutex);
>   
>   	return 0;
>   }
> @@ -2877,10 +2871,8 @@ static void dw_hdmi_bridge_detach(struct drm_bridge *bridge)
>   {
>   	struct dw_hdmi *hdmi = bridge->driver_private;
>   
> -	mutex_lock(&hdmi->cec_notifier_mutex);
>   	cec_notifier_conn_unregister(hdmi->cec_notifier);
>   	hdmi->cec_notifier = NULL;
> -	mutex_unlock(&hdmi->cec_notifier_mutex);
>   }
>   
>   static enum drm_mode_status
> @@ -3303,7 +3295,6 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>   
>   	mutex_init(&hdmi->mutex);
>   	mutex_init(&hdmi->audio_mutex);
> -	mutex_init(&hdmi->cec_notifier_mutex);
>   	spin_lock_init(&hdmi->audio_lock);
>   
>   	ret = dw_hdmi_parse_dt(hdmi);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

