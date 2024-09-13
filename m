Return-Path: <linux-kernel+bounces-327742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E7B977A93
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E322B239DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F4C1BCA03;
	Fri, 13 Sep 2024 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvqrWFlA"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED721155742
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214698; cv=none; b=f4b19zEl3Nvba0684Od8vxoRs+lwrRW574mqvMQ9YXqnL+rx3lbylKHxTz053qonh9cMQ5wSYOln8RSQ+EZn+njJBFkB4W/Y8oFURNVGUO+k8cklwuS7oRi7Mff9S0koQ6BsLBkHMGnPsbwq/DYvBjgWaELGFLyVlSO+iv93j3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214698; c=relaxed/simple;
	bh=sbfB93zlS0TdfHpq801+7DlVmbEmF+S+mrujIRXzqP0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LGh3aO/i6B8BPExKdyv4LaSDMQGW//jwp+j2NCZiA9yWEBm6wMKHvyPoOyAVeb6CWuKksDlgCka7tes7k4+UMgEXGI7WkkMPqJm5QJmSHDOX3wOvkIcQHggwMyIJ0bz9B+FRP/q35HbS/OGd/3y9T4cddPrMn5Fu9UVTz6czOtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FvqrWFlA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso14718795e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726214695; x=1726819495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tN0f5KnLz0Fgv6Uw4PEqovbRdCu6k+vdYOILHvBPqH8=;
        b=FvqrWFlAB8Sf/bXdxYMisP0lcpflDna5ePGTrCQg4uCBTV2bdXUpHsXRKr4Es+1t/T
         jcYmnrLBlmenO4BRh26Nwh6incWAHpbVnAu7fveIfdKTBPTUwuMn5NcIni4DGCt0bMmy
         iq42Bccei08yxwmOtHhaCxHGTuL6f521yzjhhfwgh1cy1PyypXl5T2iCB8Q5WMDPIuFv
         0wqIzjMUWLocZJgi7IleZNtJJuoZ3aP2uhYPtgjhk9xUppGePmu0ppFZ1H0GD34Hn9JB
         eZ1TKo1JyKiSXS/lvb2wajQnaRWhuNDvmPUlPgppC59o32paZ8V5tvHph8xdb66QlHrz
         3vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214695; x=1726819495;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tN0f5KnLz0Fgv6Uw4PEqovbRdCu6k+vdYOILHvBPqH8=;
        b=VczwAVKqsBNa0ymchKNlRNZEIpkWntCaldZI+t7AnMuPWiwsjpsmFSl23AIw4IOIdy
         TF4croz87VmV59ZdCcG6jlORe4ntlz4RFLXbnrvNVAojzqObaOTUu5k5Yse1okjriFxZ
         qm5ICdOTeLoVurVEiemFVG2EFIECTvtyQ9qmUdtnq842A/eMMObjkQxHlPRgS5y9zl9d
         gPeMCUG/092cThbImSCi++AOXVJLZ800ptcwSa9nuhJGlifOLQtlEoEVpdoNMuVgvEDG
         GdloB3cJWTN1l8+SUoVxjCOQgFhmQn7nUpqzKGnWJxCqAZpkVvkYhZqg1igkdOZAgCHP
         Tm9w==
X-Forwarded-Encrypted: i=1; AJvYcCXosERLa1IACwndGWF/4Zzjih6dU+1VpQny2GaEwT5f6iCve9AAIZdzCTJ2mCpTJYjQpC5RF9fDQx4FXMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJb7WOtxVG1Cip19sfXIwHukZQkr+mrtfX+E8HsJakIo7FmH2U
	ppE1C1syREX7N5Y9/NE685T1irFvCRPx6BakTghORPhnxG9hPGXK0lAWflfaYzw=
X-Google-Smtp-Source: AGHT+IE+/EPYZj8Jxd7YCIShYfXbXYbbomxByU1YjyiDIlF9V+tx4J8IWT7k674TkMxeicqzdjvskg==
X-Received: by 2002:a05:600c:3b1d:b0:42a:a6aa:4135 with SMTP id 5b1f17b1804b1-42cdb53fab7mr35348055e9.20.1726214694972;
        Fri, 13 Sep 2024 01:04:54 -0700 (PDT)
Received: from [192.168.7.202] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b181ecasm14927755e9.43.2024.09.13.01.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 01:04:54 -0700 (PDT)
Message-ID: <b28e86f1-3730-4739-9499-24bed32c16b9@linaro.org>
Date: Fri, 13 Sep 2024 10:04:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 04/10] drm: bridge: dw_hdmi: Use passed mode instead of
 stored previous_mode
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
 <20240908132823.3308029-5-jonas@kwiboo.se>
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
In-Reply-To: <20240908132823.3308029-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 15:28, Jonas Karlman wrote:
> Use the passed mode instead of mixing use of passed mode and the stored
> previous_mode. The passed mode is currenly always the previous_mode.
> 
> Also fix a small typo and add a variable to help shorten a code line.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: Update commit message, s/type/typo/
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 5b67640b1d0a..87fb6fd5cffd 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2240,6 +2240,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
>   			 const struct drm_connector *connector,
>   			 const struct drm_display_mode *mode)
>   {
> +	const struct drm_display_info *display = &connector->display_info;
>   	int ret;
>   
>   	hdmi_disable_overflow_interrupts(hdmi);
> @@ -2285,12 +2286,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
>   	hdmi->hdmi_data.video_mode.mdataenablepolarity = true;
>   
>   	/* HDMI Initialization Step B.1 */
> -	hdmi_av_composer(hdmi, &connector->display_info, mode);
> +	hdmi_av_composer(hdmi, display, mode);
>   
> -	/* HDMI Initializateion Step B.2 */
> -	ret = hdmi->phy.ops->init(hdmi, hdmi->phy.data,
> -				  &connector->display_info,
> -				  &hdmi->previous_mode);
> +	/* HDMI Initialization Step B.2 */
> +	ret = hdmi->phy.ops->init(hdmi, hdmi->phy.data, display, mode);
>   	if (ret)
>   		return ret;
>   	hdmi->phy.enabled = true;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

