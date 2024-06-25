Return-Path: <linux-kernel+bounces-229035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD0E916A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18271F2286F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9400216D4D6;
	Tue, 25 Jun 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XK6wS4d+"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08E16D33A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324984; cv=none; b=MAtGGIHO/234WtxMp8VCVnhM9sy7XXmqzIKlGe4G0UFVkm8sMi2zUI7UQqb7EIkQfDzoSwuT+z4LqWfwVNk6W/cBE1iX45jsXK92OZMORaXSEcXhDIvpSQ/zCTnsloRpa7x4WyuyQi2X0q22Cn14Fq8gZsrEoQd1kNrlPm+OnR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324984; c=relaxed/simple;
	bh=7Qt8Rb0tw48IIFP/mjLMps8oBUfWXZCTQDsgdNYlkSY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JWulxjBIthfeNFZtWMAgNN5hJOp3owWT8L2B7W9E0Whhgen2UHS7dnimqTbPyIAodh986QOjSqr2qxBbAegK4qZEPhO+RFVTOSKT9xvzgyR1pLh+z0k768zop6/fzgVzSE6WoVm8YqFU41BpK/4CJhFPyePYI/BzduuDMVsQVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XK6wS4d+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-424aa70fbc4so1166855e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719324981; x=1719929781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XbwCezfhWbmSEC4HDR62w3HCK7ee4grHDBBWM8UBvM=;
        b=XK6wS4d++hAYbnhTfnPem78I7LxAvBOeHkQ0NLgdeglZqXApZyTaRAxvus/8QJ+pDk
         VA6KNbXCj1LnSYbDPQ6fHcI4br7qnDkS1xw10crNcJt3Y4l5iDQIF4SJkST2LOAzfzQg
         ruMgnheSIJ4NWHBS1m3SYRQ8nJjyEp8eeCWbjcj2KQv/bXYVG1RF6nJH6VbN8nN3BnZO
         PhdLXOJlazcTk6icmT1qPy3HpWMnR0T0naMPGJ6H5h4Xjf+WvVeRK32eVs77p1un8UUR
         UP7JgtLxtfZfTDXCV5+FAFNz2bGBAXW+c9oyXbxlxNGVx6t5E+hk/kAn4e+z6BOObaR/
         aZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719324981; x=1719929781;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/XbwCezfhWbmSEC4HDR62w3HCK7ee4grHDBBWM8UBvM=;
        b=qpPjPz+seUiXlsYpGObkUv/N/T5/uAn736VVjowEvwA4OJiaY5tx1J2FuD8OG/ujQr
         sNBxvHylyw0g6BY09ybc69uZB0s5J/jmFAYl9hemM+ArSTIWAwUorOPEiXQqedbSjgiG
         VcId3vR8OrJhSYVLGYZndjsp+Q2DXaWjf+nM3DfUlufk9SuEDTkh8HVgmMDixZPuV5ab
         Ak2dMd1Ndm3//2ydpXOz8dL5K0Awt99jCjbUP0TwttW7ibJfstc9Lp+mmRByoaHCa8ND
         uztjY2U3Dwc3LfCGmwiOV5GYDcSMdbkInHUqf0X11NlZAxJyRM7BKnlifHMMA1epQiY0
         JVcw==
X-Forwarded-Encrypted: i=1; AJvYcCVp17nPc4i2GN75vhpUGVrzXmmOw4Q465A8dil/ufKIjNa+C97EparrsWGDh7SpgbnKc8FVgTFvqjgLogh0Q9Iqbi2guMVLedBf9sto
X-Gm-Message-State: AOJu0Yzg8ZbCXe6N0zHUF2HRKTu1M16w1lvBM+lxnbJxukLQi5a4eacT
	rbT89xpssE2t+wq3NoQUUUg7NA5gY6wNXha688vK60romLf4tlnsN5SeQwVCgmU=
X-Google-Smtp-Source: AGHT+IEDwR3R+Yc2zndJ2m2H9HBzMvQCVx6dbHj7Y+/+ZwJjUOOAdQw1yOvr/BHHrG5A7T3tsUhPPQ==
X-Received: by 2002:a05:600c:4658:b0:420:66e:4c31 with SMTP id 5b1f17b1804b1-4248cc6693fmr67042985e9.34.1719324980468;
        Tue, 25 Jun 2024 07:16:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bd71:2ff1:592d:f52a? ([2a01:e0a:982:cbb0:bd71:2ff1:592d:f52a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54e4sm217625085e9.23.2024.06.25.07.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 07:16:20 -0700 (PDT)
Message-ID: <1de36429-a27a-4244-8e39-4cb0b09b2689@linaro.org>
Date: Tue, 25 Jun 2024 16:16:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: display-connector: Fix
 atomic_get_input_bus_fmt hook
To: Aradhya Bhatia <a-bhatia1@ti.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>
Cc: DRI Development List <dri-devel@lists.freedesktop.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Jai Luthra <j-luthra@ti.com>
References: <20240625095049.328461-1-a-bhatia1@ti.com>
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
In-Reply-To: <20240625095049.328461-1-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2024 11:50, Aradhya Bhatia wrote:
> The display-connector acts as a pass-through bridge. To truly reflect
> that, this bridge should accept the same input format, as it expects to
> output. That in turn should be the same as what the preceding bridge has
> to output.
> 
> While the get_output_fmt hook does exactly that by calling the same hook
> of the previous bridge, the get_input_fmt hook should simply propagate
> the expected output format as its required input format.
> 
> Let's say bridge(n) converts YUV bus format to RGB before transmitting
> the video signals. B is supposed to be RGB and A is YUV. The
> get_input_fmt hook of bridge(n) should receive RGB as its expected
> output format for it to select YUV as its required input format.
> 
> Moreover, since the display-connector is a pass-through bridge, X and Y
> should both be RGB as well.
> 
>      +-------------+            +-------------+
> A   |             |   B    X   |             |   Y
> --->|  Bridge(n)  +--->    --->| Display     +--->
>      |             |            | Connector   |
>      |             |            |             |
>      +-------------+            +-------------+
> 
> But that's not what's happening at the moment.
> 
> The core will call get_output_fmt hook of display-connector, which will
> call the same hook of bridge(n). Y will get set to RGB because B is RGB.
> 
> Now the core will call get_input_fmt hook of display-connector with Y =
> RGB as its expected output format. This hook will in turn call the
> get_input_fmt hook of bridge(n), with expected output as RGB. This hook
> will then return YUV as its required input format, which will set X =
> YUV.
> 
> This is where things get off the track. The core will then call
> bridge(n)'s get_input_fmt hook but this time the expected output will
> have changed to X = YUV, instead of what ideally should have been X =
> RGB. We don't know how bridge(n)'s input format requirement will change
> now that its expected output format isn't RGB but YUV.
> 
> Ideally, formats Y, X, B need to be the same and the get_input_fmt hook
> for bridge(n) should be called with these as its expected output format.
> Calling that hook twice can potentially change the expected output
> format - which can then change the required input format again, or it
> might just throw an -ENOTSUPP error.
> 
> While many bridges don't utilize these APIs, or in a lot of cases A and
> B are same anyway, it is not the biggest problem, but one that should be
> fixed anyway.
> 
> Fix this.
> 
> Fixes: 7cd70656d128 ("drm/bridge: display-connector: implement bus fmts callbacks")
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   drivers/gpu/drm/bridge/display-connector.c | 40 +---------------------
>   1 file changed, 1 insertion(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index ab8e00baf3f1..eebf1fbcdd23 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -131,50 +131,12 @@ static u32 *display_connector_get_output_bus_fmts(struct drm_bridge *bridge,
>   							      num_output_fmts);
>   }
>   
> -/*
> - * Since this bridge is tied to the connector, it acts like a passthrough,
> - * so concerning the input bus formats, either pass the bus formats from the
> - * previous bridge or MEDIA_BUS_FMT_FIXED (like select_bus_fmt_recursive())
> - * when atomic_get_input_bus_fmts is not supported.
> - * This supports negotiation if the bridge chain has all bits in place.
> - */
> -static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
> -					struct drm_bridge_state *bridge_state,
> -					struct drm_crtc_state *crtc_state,
> -					struct drm_connector_state *conn_state,
> -					u32 output_fmt,
> -					unsigned int *num_input_fmts)
> -{
> -	struct drm_bridge *prev_bridge = drm_bridge_get_prev_bridge(bridge);
> -	struct drm_bridge_state *prev_bridge_state;
> -
> -	if (!prev_bridge || !prev_bridge->funcs->atomic_get_input_bus_fmts) {
> -		u32 *in_bus_fmts;
> -
> -		*num_input_fmts = 1;
> -		in_bus_fmts = kmalloc(sizeof(*in_bus_fmts), GFP_KERNEL);
> -		if (!in_bus_fmts)
> -			return NULL;
> -
> -		in_bus_fmts[0] = MEDIA_BUS_FMT_FIXED;
> -
> -		return in_bus_fmts;
> -	}
> -
> -	prev_bridge_state = drm_atomic_get_new_bridge_state(crtc_state->state,
> -							    prev_bridge);
> -
> -	return prev_bridge->funcs->atomic_get_input_bus_fmts(prev_bridge, prev_bridge_state,
> -							     crtc_state, conn_state, output_fmt,
> -							     num_input_fmts);
> -}
> -
>   static const struct drm_bridge_funcs display_connector_bridge_funcs = {
>   	.attach = display_connector_attach,
>   	.detect = display_connector_detect,
>   	.edid_read = display_connector_edid_read,
>   	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
> -	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
> +	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
>   	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>   	.atomic_reset = drm_atomic_helper_bridge_reset,
> 
> base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371

This will break dw-hdmi YUV output negociation because returning output_format
it won't even try to select something else than the connector output_fmt.

This is limitation of the bus_fmt negociation, it negociates in backwards, but
if the last one uses bridge_propagate_bus_fmt, and a bridge before depends on the
display support, it will be constrained by the first output_fmt.

Neil


