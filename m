Return-Path: <linux-kernel+bounces-226951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9924391464D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF281F2185A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F96131BDD;
	Mon, 24 Jun 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m5xMock3"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905EC13667F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220989; cv=none; b=ZSjXbfZQ83qbgqsrLwv+0eXIcV0q96H6pO1m9nGSFIzJXK4wcwCvpHGYKh8OX//uH9BqxgEeCDeWzNHNwt/yp5lPswWDhZvTd3Wv3PVTtw5hTfQ28MePsN/7P1OD/Nqyrt8O2tup102scpZHd0bTtEEoGcSSierGSlsjoMuBETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220989; c=relaxed/simple;
	bh=2DTLw1QgXTnhlJwnj5IgGQckRfw/H7CQujwKEKUfaa0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=giKgoJZO0KVB4jBcgfbsWY3ux/RAOFIZb53RQcmUiARjTdPur/phi6xjiC4TPy8SGR0eEHpy4mdA0im2l7FIFekLnq0x3SC3Oit5SgSAv2OQ7kswBUVzXqKbuwPjzFj7gV9hakB/qMR06K3zNoKSDAfRdzKr2ol7ZoR2Sw/6udU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m5xMock3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-364cdfdaf91so3024356f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719220986; x=1719825786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9P217sn9M/MJa4bSxNl7YInysiYF0hUm16+UxY3/mRM=;
        b=m5xMock3ulSa3fz6xMHWRmnCrXOY/fE/xqZ1EIwPzCQoUn9iCk/pHpV2mqGLdVtytz
         rdi9pxmA+ZD7sIh5Dbts82TNDEhJsHdEgV82qz3mMUKhT0+LL6nExXoVuEb1DVWclY5a
         NAkB57F/8dXF8tmJw+aa3QF7nxKQeMwHg07dQGis0WW3x9ICxCmNoCc7JL74Zu98wUdh
         gLHRM+KinhjIfQJWpVJ6DYK7VGd0W2PlkBKRNAumF/O47bndMmxSs3mzWGGY+z5NeawU
         kdPZjM5ylWGz3AX12ElNPnpmYNhUzAvzDug+P0vebHi/FrqE8CV6yJGCfSi/WGJ590N0
         GDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719220986; x=1719825786;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9P217sn9M/MJa4bSxNl7YInysiYF0hUm16+UxY3/mRM=;
        b=pe+Rpwz6KK6johKanRYMCxl4fp1jDfk4UPWTAbHzizDFXjlGmz0f6eMh4WmolaL4JU
         RhhR6iFOqiSfH6iua6nH3ZPpRP98dn23xxDLo7OPz1EfDleGT79q54UgEPCKJShboyMY
         qG46bCLkmQWJVnvUXkdClG1t5kcSUgXl8fdMj7B8UJLaUCcMWXuNtYhwDi5hqVMl0m/g
         CE6d10khjrkMFVQaj2EQrtYG6FBnNzIpjQXetlKDKLJ6tbmlk6PfTmiwic7ojCnx5Jp5
         SFTbCmCD4jmjAKKQ3E2sr6VQyzG6IYCzziYR5DAHemkdVneOZv2donUtxcNfGpg35PPp
         9XCg==
X-Forwarded-Encrypted: i=1; AJvYcCWQrSmCwZ7KHX9/STZ3X4vV87srNij/EiknoupCoc9mpUWlV/Ue1JzBiagVpEmGjgbi8fgIGn/OlzE9q9shg8lqlGwWTGTZgbd3Iqy9
X-Gm-Message-State: AOJu0Yzvh2vmqqdVVi2125iVYhdbDYEqMeYsXwUJ46BduoZdiNUxYCux
	LuOloCl4WRt4o8py7Fi4ClUrjxYI3/RYBMEI/IgirKO3eO0e+CWT8lhW9OnGxFw=
X-Google-Smtp-Source: AGHT+IH3/ALEXbfYlT2sTHs08MgJbhu0VXcoE0ZN53qFZcym9IwtEXwpeKiTUO0P3AYufoyP3blVSg==
X-Received: by 2002:adf:f3cd:0:b0:364:e963:bd1a with SMTP id ffacd0b85a97d-366e96c0d75mr2373056f8f.65.1719220985494;
        Mon, 24 Jun 2024 02:23:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74? ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a99fbsm125020125e9.16.2024.06.24.02.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 02:23:05 -0700 (PDT)
Message-ID: <dd6f7a67-e338-4c08-8520-8e85a953834b@linaro.org>
Date: Mon, 24 Jun 2024 11:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/8] drm: bridge: dw_hdmi: Call poweron/poweroff from
 atomic enable/disable
To: Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240611155108.1436502-1-jonas@kwiboo.se>
 <20240611155108.1436502-2-jonas@kwiboo.se>
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
In-Reply-To: <20240611155108.1436502-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/06/2024 17:50, Jonas Karlman wrote:
> Change to only call poweron/poweroff from atomic_enable/atomic_disable
> ops instead of trying to keep a bridge_is_on state and poweron/off in
> the hotplug irq handler.
> 
> A benefit of this is that drm mode_config mutex is always held at
> poweron/off, something that may reduce the need for our own mutex.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 33 ++---------------------
>   1 file changed, 2 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 9f2bc932c371..34bc6f4754b8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -172,7 +172,6 @@ struct dw_hdmi {
>   	enum drm_connector_force force;	/* mutex-protected force state */
>   	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
>   	bool disabled;			/* DRM has disabled our bridge */
> -	bool bridge_is_on;		/* indicates the bridge is on */
>   	bool rxsense;			/* rxsense state */
>   	u8 phy_mask;			/* desired phy int mask settings */
>   	u8 mc_clkdis;			/* clock disable register */
> @@ -2383,8 +2382,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
>   
>   static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
>   {
> -	hdmi->bridge_is_on = true;
> -
>   	/*
>   	 * The curr_conn field is guaranteed to be valid here, as this function
>   	 * is only be called when !hdmi->disabled.
> @@ -2398,30 +2395,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
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

This means we always poweron the bridge even if rxsense is false ?

Neil

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
> @@ -2546,7 +2519,6 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>   
>   	mutex_lock(&hdmi->mutex);
>   	hdmi->force = connector->force;
> -	dw_hdmi_update_power(hdmi);
>   	dw_hdmi_update_phy_mask(hdmi);
>   	mutex_unlock(&hdmi->mutex);
>   }
> @@ -2955,7 +2927,7 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>   	mutex_lock(&hdmi->mutex);
>   	hdmi->disabled = true;
>   	hdmi->curr_conn = NULL;
> -	dw_hdmi_update_power(hdmi);
> +	dw_hdmi_poweroff(hdmi);
>   	dw_hdmi_update_phy_mask(hdmi);
>   	handle_plugged_change(hdmi, false);
>   	mutex_unlock(&hdmi->mutex);
> @@ -2974,7 +2946,7 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>   	mutex_lock(&hdmi->mutex);
>   	hdmi->disabled = false;
>   	hdmi->curr_conn = connector;
> -	dw_hdmi_update_power(hdmi);
> +	dw_hdmi_poweron(hdmi);
>   	dw_hdmi_update_phy_mask(hdmi);
>   	handle_plugged_change(hdmi, true);
>   	mutex_unlock(&hdmi->mutex);
> @@ -3073,7 +3045,6 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
>   		if (hpd)
>   			hdmi->rxsense = true;
>   
> -		dw_hdmi_update_power(hdmi);
>   		dw_hdmi_update_phy_mask(hdmi);
>   	}
>   	mutex_unlock(&hdmi->mutex);


