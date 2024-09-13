Return-Path: <linux-kernel+bounces-327747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D150D977AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C241282B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82B81BDAA1;
	Fri, 13 Sep 2024 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fg+3JyaV"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945C1BDA88
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214806; cv=none; b=bppEvvqPqG0XV3Nvn2fb4QnTRFppMbzFoxfIhgA0vRlQJjBo0XC7jCojQ/A3QcNYG/fuWYLLR7REtP4/bpY5e2mvb9dQjt4U2g13/qpTOLVCX3xfHNRz84qqF9C/sGftXswv9xPbLXzUis+q7x0dR/FEspHVr+VfLgOXdihyDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214806; c=relaxed/simple;
	bh=lW/8LjpzYr66TUOiWtUyF70fRRIYW1WbVkMtUjvDYAA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pt0UQdvtqUcpyFpvPYwwNh+4AfXqCxMU10U4ZqeMYSjJu9BCPg3HXG9HkFQTW16hTT+vuKEMbfUKgf2xn+HnrczrUaI4MSBut2rkdf+uko5aOIXS0DsK2UrfyuUhSEoaMVx3wp8UGvwauWbQzfV4XGMuI1mA/2hmn8nAdUlJFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fg+3JyaV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374c6187b6eso1460715f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726214803; x=1726819603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqZBhFB8cimpwzbXgNKnIbtzzD95dG7Ue+nxOw3CDQA=;
        b=fg+3JyaVLrq06yFkM0CNLuLjAwjgHy1Ri/izizicI/2U2nfsC6ASusYjlSluDTEf4+
         QpGjam1w+x6ihUh625pvZ88VUIT5tnUAocM5f0+QDGfjv4cA3/nX9l0XHu0NK6mTZ2Nc
         wYmzgtogD1tWDqGSIq28lg3FDIohWUN00B1zCXVGkV+XFU6CffbdAGQNW68c0CK8++IH
         CaA6cU5MxU0wDfja0euwht+LfaM+DksdqkbCZ/JG2wmLiKmusjkAC8q9OzZymf6v15xb
         /liYkVqFKMU+5LHZSNCvXwi31AVfdtQnjU2ApYkPZQvTp1WS6bbUPv8auwNT9YQHAxst
         KOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214803; x=1726819603;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TqZBhFB8cimpwzbXgNKnIbtzzD95dG7Ue+nxOw3CDQA=;
        b=vlzNZqEhth/CIqHf/Ie+k3kpezas7R8owDtjnZloM5HqCxA6axwaLGxcuIaFxeviek
         CWC10x886HylFFAYDApI9I30g96U6WDUK7K224mKd0DUX5nD5zV6j7PQrmbfu7Rd91xF
         DWHDbItCkifV7/YBa6tnnJ7YuzfDCVi0I2oafQ6C+3KPQIz3E+EF+WYNoaGvlqlPmubU
         fZi+ge2tkP2oCRBJwY1nZzcOgs+Y+81w1OQmx2BkxdQHCHwC2PDmo4eGjOY/h1WsMckq
         w1Y+9r5LXE8pSFqg2VVWxVJXhKtEkMYxX7OebJj1KxHdfziqE0WLCI8/WqRhO4nGOeLm
         visA==
X-Forwarded-Encrypted: i=1; AJvYcCVNL0o3SW/Pxy+RTwkEdOngLWYqyA7hncpFSnJ4NbtLm9kZVCv/LUFgVz9xnXHjIm2Rp9frreCQ9Tas6oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4Ayefe0h1H9wGsNNbG8ESkAPrWG+bPLhUEKVcXCKNfQvEPRK
	/X3WTNnIJH7c6kLD/me2RXrVu1HZgBAnXNEcu2dWkP6Ih3XeN6+uAJ5+cleznSg=
X-Google-Smtp-Source: AGHT+IHvWtfMha2KoMqPuP5/ukwrpi/HAR3rzVEdnlOieo8WnEC/635MZTdG6ngo/RnXP69csoG+mw==
X-Received: by 2002:a5d:4e42:0:b0:374:bb2b:e7c4 with SMTP id ffacd0b85a97d-378c2d62438mr3242559f8f.57.1726214802860;
        Fri, 13 Sep 2024 01:06:42 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b16bfb4sm15121095e9.28.2024.09.13.01.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 01:06:42 -0700 (PDT)
Message-ID: <ff114d4e-11f6-4fe7-9963-a30874f4df17@linaro.org>
Date: Fri, 13 Sep 2024 10:06:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 05/10] drm: bridge: dw_hdmi: Fold poweron and setup
 functions
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
 <20240908132823.3308029-6-jonas@kwiboo.se>
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
In-Reply-To: <20240908132823.3308029-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 15:28, Jonas Karlman wrote:
> Fold the poweron and setup functions into one function and use the
> adjusted_mode directly from the new crtc_state to remove the need of
> storing previous_mode.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 87fb6fd5cffd..1eefa633ff78 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2236,9 +2236,9 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
>   		    HDMI_IH_MUTE_FC_STAT2);
>   }
>   
> -static int dw_hdmi_setup(struct dw_hdmi *hdmi,
> -			 const struct drm_connector *connector,
> -			 const struct drm_display_mode *mode)
> +static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
> +			   const struct drm_connector *connector,
> +			   const struct drm_display_mode *mode)
>   {
>   	const struct drm_display_info *display = &connector->display_info;
>   	int ret;
> @@ -2378,15 +2378,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
>   	hdmi_writeb(hdmi, ih_mute, HDMI_IH_MUTE);
>   }
>   
> -static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
> -{
> -	/*
> -	 * The curr_conn field is guaranteed to be valid here, as this function
> -	 * is only be called when !hdmi->disabled.
> -	 */
> -	dw_hdmi_setup(hdmi, hdmi->curr_conn, &hdmi->previous_mode);
> -}
> -
>   static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
>   {
>   	if (hdmi->phy.enabled) {
> @@ -2936,15 +2927,19 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>   {
>   	struct dw_hdmi *hdmi = bridge->driver_private;
>   	struct drm_atomic_state *state = old_state->base.state;
> +	const struct drm_display_mode *mode;
>   	struct drm_connector *connector;
> +	struct drm_crtc *crtc;
>   
>   	connector = drm_atomic_get_new_connector_for_encoder(state,
>   							     bridge->encoder);
> +	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
> +	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
>   
>   	mutex_lock(&hdmi->mutex);
>   	hdmi->disabled = false;
>   	hdmi->curr_conn = connector;
> -	dw_hdmi_poweron(hdmi);
> +	dw_hdmi_poweron(hdmi, connector, mode);
>   	dw_hdmi_update_phy_mask(hdmi);
>   	handle_plugged_change(hdmi, true);
>   	mutex_unlock(&hdmi->mutex);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

