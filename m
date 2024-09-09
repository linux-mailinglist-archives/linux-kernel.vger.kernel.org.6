Return-Path: <linux-kernel+bounces-321455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B47D971A9D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF801C22BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8E91B81C7;
	Mon,  9 Sep 2024 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQGpz/s+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA18282481
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887821; cv=none; b=WX5dyhN0g/5CF379ldrBxBGsDMbsG7regeQAYe1HE0kkscKz9wQf0+60EqNZCqgR+OEPHOUy0JEppffQojcXLvhXOZhPchvvHKBp9l8QSre717XXACP7dWJUVAVrTxefZrgcfYUkLQ2sNb3VSnYo1gUKUM0+cR3k+CcPviLCn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887821; c=relaxed/simple;
	bh=t2DE0tVlTgerMzK1w7AVeBcCUo3EclfAubiOY6ZywIE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uxNLwt+rdoCIp7j7qyhIKP2OYv4WK/APqrO+XDsMy2EgHNdzj1mcHU3djj3EmOS7qHLLrTplfVCHNdtT4qsNtn1zhTuH2uoDZZeVmB6BVnDS3F9TdNmjdjVbXStFuEuk+93j6cL9YYzfBgaXDKXGjLd7ZEZGihypdZ/17dvyrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NQGpz/s+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso11221625e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725887818; x=1726492618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sg3XnbABoZRPJGRGcZWLT0fiHtFn27fHJD7M1+IXq9Y=;
        b=NQGpz/s+ov2c70UzqiYbN8JTnTiE2PfqTBeO4FX1dRe44074kkMpiUNnRezBfd0kYr
         CYe/lU0ricotnGASLAcV5qsRui827N4eYpgqN5W1wO0hjgULSYhPgHnoCXD5YVNPFF4P
         WR6POMQDFA8qS9Tw5Iz/GAeejuPYkPO8T3+PYpS8ILjnDFT0b8dKnfF2onPrfQSHwBxB
         TA23sRnbMjymheXp+3s6jqg7p/h5CE4LEg3bkUqKNSnzCmkuwSqYaLAD+HN0FhDvzC1P
         Bz0+POLjciUNVV+ZlpNzbTk58nvAxp8NZad3Kq4ZhruIQOmuiyMLHYijfK9VZZ9W3Z9T
         pERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887818; x=1726492618;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sg3XnbABoZRPJGRGcZWLT0fiHtFn27fHJD7M1+IXq9Y=;
        b=Kkc0GhkdEWUrQhhagydmteKYyAgWgOo5BAClx9WmSs3mHSwQZ3XMnhMnIvdJzlZXnB
         DyR1uAF90KBEtxINIvHMdUhCC9Kjt+IVu46hq2WLTWt2v0PRQd55yb1stNFutUyohw9A
         UohTaMi+Cx2zy5p//8Oul0+RmVQqVGdP8nY8nJ3Np8Hdd7bWQYI44NjZsMlzcnFFzzNV
         HCZTyA8AWArUTzOOoarESggmx8HT1ck6sDIFW8CVwPvmOH7b3JRsxvFaK0mvthbdskXu
         1zdnFOO41hYcW9W8U4duzGeGS6BkVcshkyA1QwyPj37utK5QVxJKayp0sHOEIgRdJIAh
         0h+w==
X-Forwarded-Encrypted: i=1; AJvYcCUuF0w86ULaQ5H2c6e/KKXyWYrfpIDfEMDL8pnFIxkRUkYW+O3zs7Est7ukPppgO4mwpovFho+YufJggB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YmAwCLHuODVmvCqcBTls+t3uimzpxqJDa/KaEEjSWq3N3EmT
	4RvWJacn5AkZ2dQGr4x0o4OO5sMcLaJofuLmLU+n2I44R4qmC1SGRmDIDRAlLfc=
X-Google-Smtp-Source: AGHT+IHLaFRmjXq7bnm5y4AJSqSjgdR4U2OGsCo8bfREbnp9ZgT2lMllHdorREM+yqOr4qBpHp+aLQ==
X-Received: by 2002:a05:600c:548a:b0:42c:bae0:f057 with SMTP id 5b1f17b1804b1-42cbae0f29fmr9879275e9.8.1725887817701;
        Mon, 09 Sep 2024 06:16:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:63a3:6883:a358:b850? ([2a01:e0a:982:cbb0:63a3:6883:a358:b850])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05c2656sm109292335e9.7.2024.09.09.06.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:16:57 -0700 (PDT)
Message-ID: <bc0b47d9-ad8d-4beb-aad4-6dff79f48842@linaro.org>
Date: Mon, 9 Sep 2024 15:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 02/10] drm: bridge: dw_hdmi: Only notify connected
 status on HPD interrupt
To: Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240908132823.3308029-1-jonas@kwiboo.se>
 <20240908132823.3308029-3-jonas@kwiboo.se>
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
In-Reply-To: <20240908132823.3308029-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 15:28, Jonas Karlman wrote:
> drm_helper_hpd_irq_event() and drm_bridge_hpd_notify() may incorrectly
> be called with a connected status when HPD is high and RX sense is
> changed. This typically happen when the HDMI cable is unplugged, shortly
> before the HPD is changed to low.
> 
> Fix this by only notify connected status on the HPD interrupt when HPD
> is going high, not on the RX sense interrupt when RX sense is changed.
> 
> Fixes: da09daf88108 ("drm: bridge: dw_hdmi: only trigger hotplug event on link change")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: New patch
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 9e7f86a0bf5c..055fc9848df4 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3123,7 +3123,8 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>   			mutex_unlock(&hdmi->cec_notifier_mutex);
>   		}
>   
> -		if (phy_stat & HDMI_PHY_HPD)
> +		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
> +		    (phy_stat & HDMI_PHY_HPD))
>   			status = connector_status_connected;
>   
>   		if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))

Perhaps this should be also checked for the other lines checking HDMI_PHY_HPD ?

Neil

