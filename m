Return-Path: <linux-kernel+bounces-209424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEAA903460
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68A2B2765B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F668172BCE;
	Tue, 11 Jun 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNHsKZWS"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE38172BBA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092337; cv=none; b=DmNbSSRumeX9onNJVUBuYlbmc+rGQp20l8X+2SDio8LYi9SJWcrTKWXqT0LNDXtokcZ50sjqaIVq217WtQa2dYlWaZpeV9h5KvdhEJqQJTtqF4g11oEVyB4nHF5lnpKhuTYvXSI6Tz8rXoGVeix40++QIqn/rg8kXBWuv2EPILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092337; c=relaxed/simple;
	bh=PFaOu9a7fmvg2U7EnD3zWTxtEnuwCCoBOOXnykWuskw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CczOQ2pbhYaZIXnkVpOohm5UqzvTG9NcOO6hixfm/M4eEQAwMG3GsSPDqMtQKM3tCqUZNc6QWe3k8gHkjBE1urN9lJ0SFdqG6emFmDJz/lHU/lPddI6mkahHeH27lo2WixVDI2w2CgoAdIMXFNYAlmIXso+DgW3V/JNOGdm/PUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RNHsKZWS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f223e7691so1271680f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718092334; x=1718697134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+i/Z/3ch3+r0A2KLwIIY0Ok9e/HC8f36K3FJuJKx2E=;
        b=RNHsKZWS+Fg3XQh5GpzTB3COY51MrUK1LrQCeb3TfeEskI4R4MZbZLhu4rSK/iqGmR
         WraNLBU7RTu/mOQoF00YMa7KaeUnuW2JR3PuYnNjASp7LBFGN2IRTlZlNGBNrMVmbWCR
         ZjgtdMPwPUih8EkPP8InyHfkiiRi6u05TCIXy+zPSi9TQh+SAM0aaRp6xNWueM8ETyQ8
         6doZkdXq6XM6NXMQrm55TsWx3f5+GQNn2+nD9ZloiGPxQ66DiF3gNGJvlOhVG8eUQ3d2
         I2Ld0TPT815pPk/p6V6gyyKW3aey84A9hxnjjmf1tMJb0vg9skuKYwS5PzjSxDu1d4cK
         oT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092334; x=1718697134;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E+i/Z/3ch3+r0A2KLwIIY0Ok9e/HC8f36K3FJuJKx2E=;
        b=E/f4Z/UwUyr1WFYDrYRNr+FY0k2N6EkDwQrShSTdTqRGMwrvPV/fRVZoJeoCTPpAeZ
         oFZjv0WkYOtTWzt/Rq+an6m3I58/sL/AvwWeKwYCU66USbniAFk97S8exy2+ftRY8+TS
         0UwK0siLdlbBHcZjGHa6edAKxlU+AegzMCRNQok5Jsc5qvRMcPWUyF050oN1sQTxmtPZ
         oZ7UDZLj2eUmgvp7/RvabToNwT5G9qUt3c2b/M9jRGF3jqoIOBSW3WwNhij9W3tkp9u1
         tLGJZv1EdtxgxSzYOPUeYLsS6USvFa9Ll3y13YXTZYlYhZwxhTR3j6dFRSiyyWQ6Cl3r
         ip3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9yQH8fNco8R6DxWekWfNcbMMYgytQg3pd03uEFItCdwvSnmB8aSUFhK5iAmdVAQLns+fAuL3UhcWXYNX7J5cTclb3Y7n6j9deqwRW
X-Gm-Message-State: AOJu0Yw11ZSrrKWwfL155N4OBvW46nkDPjq2CpJldg87bkU5I3/LcPVO
	QPNUf7m0LCfOtEkcuWz8kJQeQqWN7GOFxCIYNBJDWWgtW15hSzxopvhKY+sIJKY=
X-Google-Smtp-Source: AGHT+IHbpFLNyHr0v8Vs+79JJ833765mxE2qEwYh61HH/guFxEXNMCK4FT13xTiK8JTlcmdmZO1t1g==
X-Received: by 2002:a05:6000:2cc:b0:35f:2d7b:2e30 with SMTP id ffacd0b85a97d-35f2d7b2efdmr929217f8f.34.1718092334519;
        Tue, 11 Jun 2024 00:52:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a4:3b2:c750:ef5c? ([2a01:e0a:982:cbb0:5a4:3b2:c750:ef5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc0a0dsm13055898f8f.91.2024.06.11.00.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 00:52:14 -0700 (PDT)
Message-ID: <35fc64da-1f2b-4aa8-841a-7a311a918894@linaro.org>
Date: Tue, 11 Jun 2024 09:52:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel : himax-hx83102: fix incorrect argument to
 mipi_dsi_msleep
To: Tejas Vipin <tejasvipin76@gmail.com>, quic_jesszhan@quicinc.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <d9f4546f-c2f9-456d-ba75-85cc195dd9b8@gmail.com>
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
In-Reply-To: <d9f4546f-c2f9-456d-ba75-85cc195dd9b8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/06/2024 11:17, Tejas Vipin wrote:
> 
> From: Tejas Vipin <tejasvipin76@gmail.com>
> Subject: [PATCH] drm/panel : himax-hx83102: fix incorrect argument to
>   mipi_dsi_msleep
> 
> mipi_dsi_msleep expects struct mipi_dsi_multi_context to be passed as a
> value and not as a reference.
> 

Please add a Fixes tag

> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-himax-hx83102.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> index 6009a3fe1b8f..ab00fd92cce0 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
> @@ -479,7 +479,7 @@ static int hx83102_disable(struct drm_panel *panel)
>   	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
>   	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
>   
> -	mipi_dsi_msleep(&dsi_ctx, 150);
> +	mipi_dsi_msleep(dsi_ctx, 150);
>   
>   	return dsi_ctx.accum_err;
>   }

Thanks,
Neil

