Return-Path: <linux-kernel+bounces-226943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08BF91462A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF411C213FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3551304B1;
	Mon, 24 Jun 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRPsq/OZ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA99136E1B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220803; cv=none; b=NSxWxmDhItTrlNER1fskXPDfLlxtmWme39pJkMvxNglXmygYpWidWFZb++mesYt5HRCctxXT/0AH2ofsv0GOOTyFt8ivQnaZVpgiBF1EZDyVfOdIee417tqiIQBs/WyLKY6h24BZrw2rQ3qOk7O4dkJMzyO1tvPCVrkZXEfG+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220803; c=relaxed/simple;
	bh=7yKVLPfkXYokvoegflBQ/9qEBP6GZwyR8ds15geBjR8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=btB2ZkbLOQhSZ9FDjRTe2B1se3vqLzQA8lWe54zhgWz7gjORsf4DwGgv9w0qOy+rzzpWR1TKMxOn/AqgN2DbTYmEB9nbO5sIXfDn+dy84+Gy/OYeRjEILy4+mXBrtCZnCwXymhVPH6h+wsZhf3DyVrxQmNLeKUcM0megzqRQsyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wRPsq/OZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-364b2f92388so2857908f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719220800; x=1719825600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rzhBjyz5jjvgMNRRPFm2knRSqWyQzc3/BQBCba6JkY=;
        b=wRPsq/OZAMdCkpJ6bQl8Mch8TEIwAKiu5Q9RnL+bljskg+e+Dain14DHYGKLuY9UOu
         IFw+TQbeCadqta9HSa79JzlNuvg8KXYsxGAj8gY1NIUGa6m1i9FjnvkbzCKZQNiA8gnc
         WE3k/53jBmBOXtHBw6CEqginx1J6e03clHjA5f9dSH3bDi00gMikpmbxQKKBWba1c7UY
         0hngtcn6T9v0y8eQpQEVz3au+1KORDMtAPY1omzgKMoMawA4EHbhGo1tH5KypFT3oDlJ
         4xMutFknNpq+rFC+2rT/K9NYvITC7oeMiIbsoFP+6H75baOJkqSmSvnuHOaNIA4O5WAf
         O7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719220800; x=1719825600;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1rzhBjyz5jjvgMNRRPFm2knRSqWyQzc3/BQBCba6JkY=;
        b=bThvoGLSDEaFDpBRFFkRVlwyzdB7vpKRk7sukPL3YPXu8wKkWnm8UI3GftSJP+8tMH
         p5sPnAfrsjVitpD8hSTYIEvtHM7pO5EUfzQkemYRtn1gyROMeGrDJ09aYe6/LA195Yee
         2jXjaPmVR4YpB1BpPc471yzE4K5Geb8UHS0wkdD1dqOPF6w6MzAo11eYLei6Mci9tck+
         UfVYY8PgKc2EzoxLKSgDZNbmBxRwWfDZDqN9wR0aDLnHGHkiC3FCvvM7kFljL5xjdN+T
         Yl9+4PDhUZzdh4XWsnipsITmADzhcrxi6q9O5nrb/xE5nJeha6ilEKw/ajROCgnk7mb0
         vHow==
X-Forwarded-Encrypted: i=1; AJvYcCXACb94xjc0u/vBgTTwJIuJdeVQO2TWHaKaqgbao+P9gJxnFqgM0N1GeR/Uj+2wZTwDjvJbCBXHQo6YpY//wLt9ZeEJgzCzFCY0Scb5
X-Gm-Message-State: AOJu0Ywcmnzcz387vJrfs921cjaVLAva1ZRAJpsG8dYaL5FzCGuDd+/0
	CVMWT2Gaj7op1IcCQEy1KMMGavLuGGY30mr+5jaFJz32nBrKiB2wUeLP1gVzc3I=
X-Google-Smtp-Source: AGHT+IHRZ1tAaFSNfK8/s7Iexd9ivbkvRD5s+vKV1yQwTPEUSZoY/5RFg7cefOTs7oZfhcoSVW3q1g==
X-Received: by 2002:a5d:5745:0:b0:364:81e7:3917 with SMTP id ffacd0b85a97d-366e946480fmr3098589f8f.3.1719220800019;
        Mon, 24 Jun 2024 02:20:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74? ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7befsm9477398f8f.95.2024.06.24.02.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 02:19:59 -0700 (PDT)
Message-ID: <a3a645a0-2d2f-4b6c-9878-f02764b686c1@linaro.org>
Date: Mon, 24 Jun 2024 11:19:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/8] drm: bridge: dw_hdmi: Invalidate CEC phys addr from
 connector detect
To: Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240611155108.1436502-1-jonas@kwiboo.se>
 <20240611155108.1436502-6-jonas@kwiboo.se>
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
In-Reply-To: <20240611155108.1436502-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/06/2024 17:50, Jonas Karlman wrote:
> Wait until the connector detect ops is called to invalidate CEC phys
> addr instead of doing it directly from the irq handler.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 9ecf038f551e..0814ca181f04 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2455,7 +2455,17 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>   {
>   	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
>   					     connector);
> -	return dw_hdmi_detect(hdmi);
> +	enum drm_connector_status status;
> +
> +	status = dw_hdmi_detect(hdmi);
> +
> +	if (status == connector_status_disconnected) {
> +		mutex_lock(&hdmi->cec_notifier_mutex);
> +		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
> +		mutex_unlock(&hdmi->cec_notifier_mutex);
> +	}
> +
> +	return status;
>   }
>   
>   static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
> @@ -3066,12 +3076,6 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>   				       phy_stat & HDMI_PHY_HPD,
>   				       phy_stat & HDMI_PHY_RX_SENSE);
>   
> -		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) == 0) {
> -			mutex_lock(&hdmi->cec_notifier_mutex);
> -			cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
> -			mutex_unlock(&hdmi->cec_notifier_mutex);
> -		}
> -
>   		if (phy_stat & HDMI_PHY_HPD)
>   			status = connector_status_connected;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

