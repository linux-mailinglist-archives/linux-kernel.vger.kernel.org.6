Return-Path: <linux-kernel+bounces-321453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C1C971A95
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11281C2104C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BEB1B86DD;
	Mon,  9 Sep 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxMArm38"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEA51779BD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887731; cv=none; b=aKGnbyIz81MPaUCKnv6HlLGxMIUmV3oC2dnYDNCYPpqPWhWDH4qfBSBdSHlLJYhsFRZMA8QiEmJTOx1iywJYoACvD4dJK2xxEjUYOo9+wRSvVwAab5VHv+yVigNEYWsA0JkvIIOTPonM3/isLYrkKGkzC7dzqHgev632PlUDE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887731; c=relaxed/simple;
	bh=YHMRzIUlyXUZUbH+6LpeQi0S4hjTywoZ/QNLjkYB5yw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XKYTuwR7SOQMPMeL3H2w0VDbeIlP4/G4ruWDT+UJ4liPaF0dBuLpTHZzGOQOcNGJTLlvN2K/lSFPjJvwLdoB99PzAArP7RVlWHtoto/0nJQoYZ/a8UaVraPXAAt4/U7D3VtVP+1lXikrATfK6sq2BOlJq+GP2Ze+HUzoQgYA0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RxMArm38; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c84dcc90so2556417f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725887728; x=1726492528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B95ObHJpdojG5xYgPYvRks8MDbQVxroVTSkoySW7Ido=;
        b=RxMArm38kSUrdVhWJgdkTAHhbY6QPMJYUwnTnRHQpxMRqgfZXIJwFyZBOz6IaUDkiB
         WxUgQBNGBWa7Y6P3dgy/I7p24S43vcbiooK8dPiKeYON7EvCIlUl0vg33wSEo/1gJgfC
         Yo2s6KKvPiNdbLur79rMCuIaUoOCmyWf0ZJnO3p4zsIid+jVAnxDoFKFM6IqF9Zcpdo1
         PaJ2sMhn4NUY3A65McWTijPgG9XO6+MxxvU142+GsOD2YKado9wm2Q//zTkT1a8+rBLr
         qVvwJR7eavhrWN5tV6SnFCQMZANCULNRlrFx2UrC8+MntoJpZWIxE4no50OAQPeBtBgt
         up2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887728; x=1726492528;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B95ObHJpdojG5xYgPYvRks8MDbQVxroVTSkoySW7Ido=;
        b=adeoG/pyyP8ml94AWAXH6WaiwwLoQTtOFOPN+MT67Bq5dG5i5yqGDEn4rdeJSOYjnL
         6eZpaqdvKiWF78WvOi3fBl/8ZjqlAQ5zHpfWBDGqo+rKTlLpDkYulDhB4784P1APQXY9
         lzuy1IOnYj6UprTEmG20HvbrzxeoEpBV04jnBpJvz9BslwWn0qwKcn+c07f2ZTZDE+QD
         xAwzwUz0D5MhfqmA3nG5F/AGdpKiH3DaMd5VKhqy57+r0Mq9G7OPAo9ZhS8R8SUzkIPm
         6rDnUHrWd13FBXtYNKZYzZ5e9IA+v2azYriF2ztWROiZgSiqMXFaIbFzLXnBCnesi4eg
         ffbA==
X-Forwarded-Encrypted: i=1; AJvYcCW2PQVvZ2icCHLP8MiOM19isPUPIBgcXC1jMktqAdTGIRAFy95o63Sz11lFrtRoiOUqyyd4qiJdW2nMWyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9dwknN0TDAq7Zrhnaw+UfKolmZ9r5kTXXQCv8bOMI+uHde4M
	W8D7foTy93qVGuQD80AkhXYkso7EVkNLg8qsHzfjhOdKO3FCWZSapgUo5Z+1MPE=
X-Google-Smtp-Source: AGHT+IEU43fgBZkJDiu5N74vNjtuUNPxSdgWTgzbyhk1oykhQZa3fOmHlH6jxK/DCxOHnZ+0No77XA==
X-Received: by 2002:adf:f74b:0:b0:36b:b297:1419 with SMTP id ffacd0b85a97d-378895ca68dmr7209193f8f.20.1725887726980;
        Mon, 09 Sep 2024 06:15:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:63a3:6883:a358:b850? ([2a01:e0a:982:cbb0:63a3:6883:a358:b850])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653d1sm6002863f8f.33.2024.09.09.06.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:15:26 -0700 (PDT)
Message-ID: <8cdfa4f1-3acd-4839-a490-9152174e3136@linaro.org>
Date: Mon, 9 Sep 2024 15:15:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 01/10] drm: bridge: dw_hdmi: Disable scrambler feature
 when not supported
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
 <20240908132823.3308029-2-jonas@kwiboo.se>
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
In-Reply-To: <20240908132823.3308029-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 15:28, Jonas Karlman wrote:
> The scrambler feature can be left enabled when hotplugging from a sink
> and mode that require scrambling to a sink that does not support SCDC or
> scrambling.
> 
> Typically a blank screen or 'no signal' message can be observed after
> using a HDMI 2.0 4K@60Hz mode and then hotplugging to a sink that only
> support HDMI 1.4.
> 
> Fix this by disabling the scrambler feature when SCDC is not supported.
> 
> Fixes: 264fce6cc2c1 ("drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support")
> Reported-by: Christopher Obbard <chris.obbard@collabora.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: New patch
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 0031f3c54882..9e7f86a0bf5c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2117,6 +2117,8 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>   				    HDMI_MC_SWRSTZ);
>   			drm_scdc_set_scrambling(hdmi->curr_conn, 0);
>   		}
> +	} else if (hdmi->version >= 0x200a) {
> +		hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
>   	}
>   
>   	/* Set up horizontal active pixel width */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

