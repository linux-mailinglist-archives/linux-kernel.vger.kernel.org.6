Return-Path: <linux-kernel+bounces-226985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5957E9146CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A463AB214AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BAD134415;
	Mon, 24 Jun 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0G9vcZd"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156FF13248E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223024; cv=none; b=D3jetekQ+ZnBxLJdjhIxXjdOS38sX94XDOP6rfGmYLEprsQ+0EUUaX2O/1+fTjHcvZUhJaKUYgJ7mzEnUuv58h+xDiFAYfFyPxI++RfPMVDtEhxBpdC886pX9W+VgQUvxtoRIUoLbvW+52TtM7No++Jhlu0JujBVx9THbeCi4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223024; c=relaxed/simple;
	bh=6OFEI25kJJaEdiTnNvvUMjvN4diTYZF1dLtWzV4JGm0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZtZOEIi0tDZ2HVw3WgKH+M0L7K9UCS93LVLkSJ5CYvFQro8s0hlP5QdkmuEDXuhbUiWZ7+I/c4T8y9hncH/KvkQ8CBh0p0O+MGQlyezgRe4OiEHQ3/ZEukpwvdNlDZhYO7SrkMjtKnz2ydOOrwRBw7+qhjEtjI8kcVZaVrV6h64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D0G9vcZd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-363bbd51050so3137136f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719223020; x=1719827820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lernVVREgJ6DsB5CkgGs6God1E29++TaTF36V6rTHrI=;
        b=D0G9vcZdVNsFjs6V/d8cd3IBo9z67pRlVGWxdRJnUQJ0Q/MTl114F+JQSGRfupnBJ1
         ExhXVzYJmu0cRsfW0Gd2AtxMFmKLtoOXoUYBKSu9dDuBW5p+jcLzWiJVDtGg2pb/24jP
         4TGMsgnfJCpnqcco1Bp/PpnPs54vc8cwpgHLYGlF2YdNsOS4phO+Yk0Zn3vmKlV4gTg7
         uRz/MGXa47A5fK2T4yqbKcG/ljHFUIq6+D9WhSjtrZKAHkQg0LxHo9JyUZxNklqQskNG
         xziXjLkV4iVNBqMj3nXLhiTT7pTJTfO7beF6IjpfXjpcQ7ccjuvpOB/MDoL+0ZANiLdr
         oskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719223020; x=1719827820;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lernVVREgJ6DsB5CkgGs6God1E29++TaTF36V6rTHrI=;
        b=muWXegZBwJjmjS0OctgwIV1mqC8mBS9A9+xejeGTcu0IpcI5vqQxfeHY0wgBcA94/w
         lPnPv4cbi+QsHyi6STnI9M0DV1t0AzCW+nFWIWq//GiLKxFsxEL39ONGVYhLN2pSXr6x
         W4bs4N3ySYpmBqS5GZkUFTKoXFG8VxdX3vpjm9Wgq224X+c509zG2HuzcoHYE2J1w1MI
         dDwVaJchWy+7Xb2fJbSq4s44Zg1g517QC+pAxg3cKea1Etvf7x10rO/kCw8sPNWFzvKA
         N7VsvkFOor6rYWbv1YVnw/l9SYnD+NMASmH0ApVO/1Xrg2XjSAIIkl/uOxF8a9cMt26A
         I7gg==
X-Forwarded-Encrypted: i=1; AJvYcCVlKnwIGEj/QqlOFfq2bAf5u4z6MLOwVyf7P58ZvcuY8YfyinW7vM4iE6szOiXIJLwWrqry47MgXi+GxIYJ2lKHFhtVQzk72pIN1UNQ
X-Gm-Message-State: AOJu0Yw04jt8PoHT5CAUP0XVnPgqLbYeGAxiolk/yWbqyn991gH82fNB
	A+jJYl3z9oXkFfc2djzlmgw/TMBnnOaYOrH7pprsnCZQWpzWTQVaD1tIYXG/s/4=
X-Google-Smtp-Source: AGHT+IE0XLB9h1oLwiIgfMkryF3MrNQ1FAsESgNrsTtKryKlwcLQOoE4D97yauPlmOXcsT4+eV6a/Q==
X-Received: by 2002:a5d:58ed:0:b0:362:f291:6f97 with SMTP id ffacd0b85a97d-366e4ed2eb5mr2997487f8f.18.1719223020045;
        Mon, 24 Jun 2024 02:57:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74? ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366eef51a14sm3169040f8f.83.2024.06.24.02.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 02:56:59 -0700 (PDT)
Message-ID: <2759176e-031b-4c63-8dc8-b017a63f00b0@linaro.org>
Date: Mon, 24 Jun 2024 11:56:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/8] drm: bridge: dw_hdmi: Call poweron/poweroff from
 atomic enable/disable
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240611155108.1436502-1-jonas@kwiboo.se>
 <20240611155108.1436502-2-jonas@kwiboo.se>
 <dd6f7a67-e338-4c08-8520-8e85a953834b@linaro.org>
 <af41d129-53ce-4875-bee2-c331aa47c248@kwiboo.se>
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
In-Reply-To: <af41d129-53ce-4875-bee2-c331aa47c248@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2024 11:41, Jonas Karlman wrote:
> Hi Neil,
> 
> On 2024-06-24 11:23, Neil Armstrong wrote:
>> On 11/06/2024 17:50, Jonas Karlman wrote:
>>> Change to only call poweron/poweroff from atomic_enable/atomic_disable
>>> ops instead of trying to keep a bridge_is_on state and poweron/off in
>>> the hotplug irq handler.
>>>
>>> A benefit of this is that drm mode_config mutex is always held at
>>> poweron/off, something that may reduce the need for our own mutex.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 33 ++---------------------
>>>    1 file changed, 2 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> index 9f2bc932c371..34bc6f4754b8 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>> @@ -172,7 +172,6 @@ struct dw_hdmi {
>>>    	enum drm_connector_force force;	/* mutex-protected force state */
>>>    	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
>>>    	bool disabled;			/* DRM has disabled our bridge */
>>> -	bool bridge_is_on;		/* indicates the bridge is on */
>>>    	bool rxsense;			/* rxsense state */
>>>    	u8 phy_mask;			/* desired phy int mask settings */
>>>    	u8 mc_clkdis;			/* clock disable register */
>>> @@ -2383,8 +2382,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
>>>    
>>>    static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
>>>    {
>>> -	hdmi->bridge_is_on = true;
>>> -
>>>    	/*
>>>    	 * The curr_conn field is guaranteed to be valid here, as this function
>>>    	 * is only be called when !hdmi->disabled.
>>> @@ -2398,30 +2395,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
>>>    		hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
>>>    		hdmi->phy.enabled = false;
>>>    	}
>>> -
>>> -	hdmi->bridge_is_on = false;
>>> -}
>>> -
>>> -static void dw_hdmi_update_power(struct dw_hdmi *hdmi)
>>> -{
>>> -	int force = hdmi->force;
>>> -
>>> -	if (hdmi->disabled) {
>>> -		force = DRM_FORCE_OFF;
>>> -	} else if (force == DRM_FORCE_UNSPECIFIED) {
>>> -		if (hdmi->rxsense)
>>> -			force = DRM_FORCE_ON;
>>> -		else
>>> -			force = DRM_FORCE_OFF;
>>> -	}
>>
>> This means we always poweron the bridge even if rxsense is false ?
> 
> If I follow the logic there should not be any difference, beside that
> power on now only happen in atomic_enable instead of sometime in irq
> handler.
> 
> hdmi->rxsense is set to true based on hpd in dw_hdmi_setup_rx_sense().
> For both meson and dw-hdmi this means HPD=1 and not rxsense=1.

Yeah I know, I was worried for other platforms using rxsense

> 
> drm core will call the force/detect ops and enable/disable based on
> forced/HPD state, so I am not expecting any difference in how this
> currently works.
> 
> This change to only poweron/setup in atomic_enable should also fix
> issues/situations where dw-hdmi was poweron too early during bootup in
> irq handler, before the drm driver was fully probed.

Hmm, but I thought the code wouldn't poweron the bridge is rxsense was 0
even if a mode was set, this won't work like this anymore right ?

Neil

> 
> Regards,
> Jonas
> 
>>
>> Neil
>>
>>> -
>>> -	if (force == DRM_FORCE_OFF) {
>>> -		if (hdmi->bridge_is_on)
>>> -			dw_hdmi_poweroff(hdmi);
>>> -	} else {
>>> -		if (!hdmi->bridge_is_on)
>>> -			dw_hdmi_poweron(hdmi);
>>> -	}
>>>    }
>>>    
>>>    /*
>>> @@ -2546,7 +2519,6 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>>>    
>>>    	mutex_lock(&hdmi->mutex);
>>>    	hdmi->force = connector->force;
>>> -	dw_hdmi_update_power(hdmi);
>>>    	dw_hdmi_update_phy_mask(hdmi);
>>>    	mutex_unlock(&hdmi->mutex);
>>>    }
>>> @@ -2955,7 +2927,7 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>>>    	mutex_lock(&hdmi->mutex);
>>>    	hdmi->disabled = true;
>>>    	hdmi->curr_conn = NULL;
>>> -	dw_hdmi_update_power(hdmi);
>>> +	dw_hdmi_poweroff(hdmi);
>>>    	dw_hdmi_update_phy_mask(hdmi);
>>>    	handle_plugged_change(hdmi, false);
>>>    	mutex_unlock(&hdmi->mutex);
>>> @@ -2974,7 +2946,7 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>>>    	mutex_lock(&hdmi->mutex);
>>>    	hdmi->disabled = false;
>>>    	hdmi->curr_conn = connector;
>>> -	dw_hdmi_update_power(hdmi);
>>> +	dw_hdmi_poweron(hdmi);
>>>    	dw_hdmi_update_phy_mask(hdmi);
>>>    	handle_plugged_change(hdmi, true);
>>>    	mutex_unlock(&hdmi->mutex);
>>> @@ -3073,7 +3045,6 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
>>>    		if (hpd)
>>>    			hdmi->rxsense = true;
>>>    
>>> -		dw_hdmi_update_power(hdmi);
>>>    		dw_hdmi_update_phy_mask(hdmi);
>>>    	}
>>>    	mutex_unlock(&hdmi->mutex);
>>
> 


