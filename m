Return-Path: <linux-kernel+bounces-327744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DF977A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A9F287D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB781BDA9D;
	Fri, 13 Sep 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2JSEzzs"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2E1BD4F7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214757; cv=none; b=iONa0TX25d7IC5TOA0ifiPgunKF/kcjfAiAwQvtQj1IPCAecAKKeH2ea1/nPqRCsaH4Uswy5mgumo4RIT232QbTC4xh4+B+mieCuRw1a9gxZ870c6J0q5RYx24Tcwqgnr8Xrc0dxImwSuMWh/OXzWy8vhVMOYuALdhdhaxAoGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214757; c=relaxed/simple;
	bh=Q4LWbd7exzTRye03LcVI6bK7n6aKJKoqRFoikwXsh6w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YZW3WjtyD4Hneb0dI9So/ndh4bUDX1uCheWJgFq3loV0IBveTlOCV2vo468u5EaLwzDfUqcLyNZXsx5lrOfn6zJyz6X8e3MjrVkqhCSgUzzB0Lt6+cd495wWo8HhAcARvOMXzieTI6CNp5zFpPBQjuDpjYCCFaqXEv1Pmps0TYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I2JSEzzs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374b9761eecso1497964f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726214754; x=1726819554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpaBa3rXzcmPvmVGwgNwO7QYicep+zX2dSIy24NgTYE=;
        b=I2JSEzzsciOPTmoPnhx9NTMzUQ6pJrJRPspiRdUSi5kp9wVYbV7GwuBp2VRSXfENKJ
         FQloYFgQUsHxSZxlEqGaRq4LiY6qU3D05IFsApPJgjLVbwp/I/uPDl0gCI/htg9Y1Fmg
         rr4uEOf2g80qkGvzGl/3l98BtbkNyfS6StGRrQFtsW1zQGDkE527kGF9IHw5ytJt3pYJ
         UyPaPVFfzzZaz/+5GjRBdPLAlRyMOLXkI7DvZwvQ/cZhBPv94V/HtSJYS4TGLOWijPG/
         3GtIHVZX2OFS96Hc0sW9kxjJ72seM6ybJXw5o44CwTQg5YR1ozdm17UJv9w1AhGXE/xN
         sm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214754; x=1726819554;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YpaBa3rXzcmPvmVGwgNwO7QYicep+zX2dSIy24NgTYE=;
        b=DrNlSUI4mD06XKZiVdYvbeM8DD8hUPBB0B4DPmmfljpQCVaInZ1yew8bQrgemuLC0X
         x0u/RnX/E/nRdD6pqOoahgv8g/t0DtKD+5THYd1/c1x1ZOOPlOSlsl4QZ3NpgDPOWJZv
         sYkWBJ+U9iggR+eOoyDWsgrb3i2f8z3vl5Yo2Sq4HEkaRFk2yL3g+8kcprhR0iy2smZB
         sNV9qYfZhvZ6PbP5/wm/Fs8L5DDYbDOE1aThLHGmM+VF2u9V8Mr+LvDmFnzLUxl0woLm
         nVcGNXbmnGr/hpGFSwu+yoeRL58uqbTMfLOGNCdVt1N/hdwAQZjJRXIWvQUG9m3FxFdg
         J0LA==
X-Forwarded-Encrypted: i=1; AJvYcCV7FEb/WQbFbJwrRY1Mgoz4GFuj3lPt+1f5THisRwAUFCt/2s0aIol4N8vgnytWvkglFwFzVz7WnPaJhMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnf1Beinq9zX5hNO2E/LZzhyZXtPU95AGc5UBHliL3YMFSJC28
	rDqf8A0IeoVik4g1F/trh4uRblRtpoQX20L9/Pxc01qdwGSariQbSgzAfLYoMYU=
X-Google-Smtp-Source: AGHT+IFL22svDjzCRrUXs2QqC+xPgNTUGDJOJrl+aZeS9c8hKYkQUJ+F4J7YvEpATOxHxMm5RmaV9w==
X-Received: by 2002:adf:efca:0:b0:371:9362:c286 with SMTP id ffacd0b85a97d-378c2cd3ee8mr3375083f8f.4.1726214753750;
        Fri, 13 Sep 2024 01:05:53 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a1a0sm16047177f8f.23.2024.09.13.01.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 01:05:53 -0700 (PDT)
Message-ID: <8a7da0a7-1234-4343-8538-9f7230024ca7@linaro.org>
Date: Fri, 13 Sep 2024 10:05:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 03/10] drm: bridge: dw_hdmi: Call poweron/poweroff from
 atomic enable/disable
To: Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240908132823.3308029-1-jonas@kwiboo.se>
 <20240908132823.3308029-4-jonas@kwiboo.se>
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
In-Reply-To: <20240908132823.3308029-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 15:28, Jonas Karlman wrote:
> Change to only call poweron/poweroff from atomic_enable/atomic_disable
> ops instead of trying to be clever by keeping a bridge_is_on state and
> poweron/off in the hotplug irq handler.
> 
> The bridge is already enabled/disabled depending on connection state
> with the call to drm_helper_hpd_irq_event() in hotplug irq handler.
> 
> A benefit of this is that drm mode_config mutex is always held at
> poweron/off, something that may reduce the need for our own mutex.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: Update commit message
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 33 ++---------------------
>   1 file changed, 2 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 055fc9848df4..5b67640b1d0a 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -169,7 +169,6 @@ struct dw_hdmi {
>   	enum drm_connector_force force;	/* mutex-protected force state */
>   	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
>   	bool disabled;			/* DRM has disabled our bridge */
> -	bool bridge_is_on;		/* indicates the bridge is on */
>   	bool rxsense;			/* rxsense state */
>   	u8 phy_mask;			/* desired phy int mask settings */
>   	u8 mc_clkdis;			/* clock disable register */
> @@ -2382,8 +2381,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
>   
>   static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
>   {
> -	hdmi->bridge_is_on = true;
> -
>   	/*
>   	 * The curr_conn field is guaranteed to be valid here, as this function
>   	 * is only be called when !hdmi->disabled.
> @@ -2397,30 +2394,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
>   		hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
>   		hdmi->phy.enabled = false;
>   	}
> -
> -	hdmi->bridge_is_on = false;
> -}
> -
> -static void dw_hdmi_update_power(struct dw_hdmi *hdmi)
> -{
> -	int force = hdmi->force;
> -
> -	if (hdmi->disabled) {
> -		force = DRM_FORCE_OFF;
> -	} else if (force == DRM_FORCE_UNSPECIFIED) {
> -		if (hdmi->rxsense)
> -			force = DRM_FORCE_ON;
> -		else
> -			force = DRM_FORCE_OFF;
> -	}
> -
> -	if (force == DRM_FORCE_OFF) {
> -		if (hdmi->bridge_is_on)
> -			dw_hdmi_poweroff(hdmi);
> -	} else {
> -		if (!hdmi->bridge_is_on)
> -			dw_hdmi_poweron(hdmi);
> -	}
>   }
>   
>   /*
> @@ -2545,7 +2518,6 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>   
>   	mutex_lock(&hdmi->mutex);
>   	hdmi->force = connector->force;
> -	dw_hdmi_update_power(hdmi);
>   	dw_hdmi_update_phy_mask(hdmi);
>   	mutex_unlock(&hdmi->mutex);
>   }
> @@ -2954,7 +2926,7 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>   	mutex_lock(&hdmi->mutex);
>   	hdmi->disabled = true;
>   	hdmi->curr_conn = NULL;
> -	dw_hdmi_update_power(hdmi);
> +	dw_hdmi_poweroff(hdmi);
>   	dw_hdmi_update_phy_mask(hdmi);
>   	handle_plugged_change(hdmi, false);
>   	mutex_unlock(&hdmi->mutex);
> @@ -2973,7 +2945,7 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>   	mutex_lock(&hdmi->mutex);
>   	hdmi->disabled = false;
>   	hdmi->curr_conn = connector;
> -	dw_hdmi_update_power(hdmi);
> +	dw_hdmi_poweron(hdmi);
>   	dw_hdmi_update_phy_mask(hdmi);
>   	handle_plugged_change(hdmi, true);
>   	mutex_unlock(&hdmi->mutex);
> @@ -3072,7 +3044,6 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
>   		if (hpd)
>   			hdmi->rxsense = true;
>   
> -		dw_hdmi_update_power(hdmi);
>   		dw_hdmi_update_phy_mask(hdmi);
>   	}
>   	mutex_unlock(&hdmi->mutex);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

