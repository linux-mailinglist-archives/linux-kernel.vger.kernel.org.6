Return-Path: <linux-kernel+bounces-327736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A72977A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721DE1F263F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3581BC9EC;
	Fri, 13 Sep 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzeQ/ld4"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0013D89D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214585; cv=none; b=oGiyqtRlM3OElB2vZQMxDRAg1d77wyqYB2ry0XaSyimewhmOr/Yd+TJevlWynu2LsdOcf5uiFvh30Zw2fESrRhajtna4o1bH6IHTi9WMWw/b75axn7d+s7qVd2ItNSBUExY9O1IFoYYTiVptqV2/hh8c0oCJZ/MFIZa0I+A6Rwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214585; c=relaxed/simple;
	bh=srQoL6/aXY/RpWn99OG3FcrilnPzoej+BEEFaRHX3ZM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B0/aKtdweRYM3bEAUYzg6qw56EXZh03oZJhKhD+VJYQopp2gaNJWrcNgE6wUD9Y7K0U0juPOK0xZITr2BGvIp17tuuE4yr61btChA38gt3avKN5fqDoybfOL2fkwy5uUkM/PUZecIAhFJOQVmMIQRo9eCU+9y6/rIkdyqseC0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IzeQ/ld4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3787f30d892so439472f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726214582; x=1726819382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuKvojtCZg7g14c14RQDvHtxwoqt5QeCZyN0kUqDmA0=;
        b=IzeQ/ld4Uvy0QgyqRCbgZmy48M7A0AJXMtwHYfQoP0IcSvRMpwMur6jOSkYq/Nqj/K
         CT2hfvQzWGTEOIPtCGMOzjZ2caepNxdqJTyXNnxYJrnt5tz0LRYoy7O1uNMc/9Uv46M9
         O1oXDMD6DDOdIrPUTKANsxl/Gv0PMiltVGFNsuzkacM941olmf8EdlVZik7wxVodxl1P
         TyVoc7Fj9kFsb4KIIbnKMee8v7NrbcHbkDxyYFu7I7wjEv+AsrigH+RK5R0Y5wnYAZHG
         cOR2YuI4NPYmu3PDkzKDqElscrJgXz0s1PR8Kxs1sFJOFYpvWRaz/Yc8+F+ZwE/YKMXt
         e5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214582; x=1726819382;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WuKvojtCZg7g14c14RQDvHtxwoqt5QeCZyN0kUqDmA0=;
        b=jrdKK2zq4g/899bgo8WZodJdVCg7rbwIlLc4/jF9TUO0+VHCvxbl2IGUKtMZ60EAPT
         q7wlTCdviRoV81KrSx9MbeIU7Z2710Zr4eE2td9PClE4YjPBzVh+QOdsm2Vhs5A+0TO5
         ckhpLFmVJgVw1B6v0A80Ms4j5VPCHD5k3dDP1uztKjCbmei3Aheku7lmqEq2VblQ1Ymq
         Y5otR/JaaprYm7ca3qgs8lrohhrxrtmtL4xECf9SmfSk2QlFBM2umBHsRClvMKNysdAz
         K5bvSmbjjfwSqJb5gZ3QesuPyxLAOzz4Z1i4G9sl8ZuOMB5wQy3i9Jts78eL8w0G6ylG
         sygA==
X-Forwarded-Encrypted: i=1; AJvYcCVUk7j1WZANqXlVWr0jFKvwayM5uNg2LMQgQokEqi+Vz0Lpg1AYIgyImxtpt3oAreKqmZMqfZsv7Dhunpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzv4HEjyWWf13CfOLy0u9xpXa3hg989y2MkuvhrzoLizEKI6L
	u/o2pUbNzD2KJDYZ29eQaKmUdnFlJdV8wke0xaLaCXWaRChNkiJWgidzO0J1o/w=
X-Google-Smtp-Source: AGHT+IGjWX8++sbopvCOcrzHWzZMeCZ109rEfa8ItpaKA91i9e/Yn1nIyeUmaUhA27muapNY9/QnTA==
X-Received: by 2002:adf:edc6:0:b0:34d:ae98:4e7 with SMTP id ffacd0b85a97d-378d6241ff8mr1021335f8f.41.1726214581833;
        Fri, 13 Sep 2024 01:03:01 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956761c6sm16112834f8f.61.2024.09.13.01.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 01:03:01 -0700 (PDT)
Message-ID: <17aece51-fe00-4c60-85cc-f89cb14b2e6a@linaro.org>
Date: Fri, 13 Sep 2024 10:03:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 06/10] drm: bridge: dw_hdmi: Remove previous_mode and
 mode_set
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
 <20240908132823.3308029-7-jonas@kwiboo.se>
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
In-Reply-To: <20240908132823.3308029-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 15:28, Jonas Karlman wrote:
> With the use of adjusted_mode directly from the crtc_state there is no
> longer a need to store a copy in previous_mode, remove it and the now
> unneeded mode_set ops.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 1eefa633ff78..6a94376a3da3 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -154,8 +154,6 @@ struct dw_hdmi {
>   		bool enabled;
>   	} phy;
>   
> -	struct drm_display_mode previous_mode;
> -
>   	struct i2c_adapter *ddc;
>   	void __iomem *regs;
>   	bool sink_is_hdmi;
> @@ -165,7 +163,7 @@ struct dw_hdmi {
>   	struct pinctrl_state *default_state;
>   	struct pinctrl_state *unwedge_state;
>   
> -	struct mutex mutex;		/* for state below and previous_mode */
> +	struct mutex mutex;		/* for state below */
>   	enum drm_connector_force force;	/* mutex-protected force state */
>   	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
>   	bool disabled;			/* DRM has disabled our bridge */
> @@ -2894,20 +2892,6 @@ dw_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
>   	return mode_status;
>   }
>   
> -static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
> -				    const struct drm_display_mode *orig_mode,
> -				    const struct drm_display_mode *mode)
> -{
> -	struct dw_hdmi *hdmi = bridge->driver_private;
> -
> -	mutex_lock(&hdmi->mutex);
> -
> -	/* Store the display mode for plugin/DKMS poweron events */
> -	drm_mode_copy(&hdmi->previous_mode, mode);
> -
> -	mutex_unlock(&hdmi->mutex);
> -}
> -
>   static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>   					  struct drm_bridge_state *old_state)
>   {
> @@ -2971,7 +2955,6 @@ static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
>   	.atomic_get_input_bus_fmts = dw_hdmi_bridge_atomic_get_input_bus_fmts,
>   	.atomic_enable = dw_hdmi_bridge_atomic_enable,
>   	.atomic_disable = dw_hdmi_bridge_atomic_disable,
> -	.mode_set = dw_hdmi_bridge_mode_set,
>   	.mode_valid = dw_hdmi_bridge_mode_valid,
>   	.detect = dw_hdmi_bridge_detect,
>   	.edid_read = dw_hdmi_bridge_edid_read,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

