Return-Path: <linux-kernel+bounces-412596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54DD9D0B28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97220281471
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4916132F;
	Mon, 18 Nov 2024 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QeUWMpwi"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CA32629F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919440; cv=none; b=RUkmXVSxZ1GkyMfHK9eyNGXFw/M+NGK7SI5Ew9sUkMdh2gdhYz71t9XjRlhT1ig8t/eTKjfmwHKCtJIgRdxjOw289+wdfxpwgdm3F6bi+qw9zXvJ2VcVLKClRxN8hRhvSIqsLrmSK9vLDZbKry7/RZiT4T5QCn0Lehnmuh+dltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919440; c=relaxed/simple;
	bh=/HAWXQeWDxquzy/wU3MHS6hMvoH29G/vOCWHCZ28Yuk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lN1lnzhyqyR41j8zfyZVXUuk3QuncvNh7qt8oVK/hQY1r6iAD8UOLMhplgA8dIARt+UVasqusTlE46J2EZebahjxQF1YmOm5ylaHpb+Xybb8hUp4BuL6/S3z8m3C9HEa0saZbzuPJg3xMy53LTxFExVRDGZaru/I5YrN6nvJojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QeUWMpwi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38242abf421so699040f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 00:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731919437; x=1732524237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypUwUUYc52nz0VWt6hkJFRU5UFb2HonzDOj3Vy9qns0=;
        b=QeUWMpwiPpPv08Pe233hFi+wt8Rb9MjO0sR0dIOZoq4FhPCqkpwHl7/0Hr8hG04zsD
         5nFLsO34iyDeiMpcR1rsPdEzasa6CK83l6AdMca6n0GkOueamZRuu2vfeIU1f6jkGVkU
         hcxub2Db7XsAJ1VpAb4rbdyzZnagF0Mcz+s3v8mJbEq7b1h7USX/95NiIolP5ZeYeKR+
         NYHFXWu1YNi67rmUKDCSos+mMa6JSCv4Z/pxO8BvxXJ5GtVe9TsRT9b64o3E7IJvvu0N
         PnH6AA5o/qfsbBFwc6RaX7HyR0+LyWJHmTqBtVigzNuyTGkVDCqPNqqSU/3ZEeanUyrn
         3CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731919437; x=1732524237;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ypUwUUYc52nz0VWt6hkJFRU5UFb2HonzDOj3Vy9qns0=;
        b=gkfyuEVC7DP9ijMHWsD+bCt7/I/mRDYI++IlkBwxsyeV/7c1pOtpzZdMwRQi3o4F7A
         4oiZy2ovk0vGysQRM+Zp0BFGTDSxsB/MtM7fsPyRr0UsigNGBaBz4OD9IZedsrlL9yIu
         vbZpiEXEe0TAPPg8goUmd07YdipBdHNfprOyCaKx10PuTAPhJj8hzWv0CXs+ns47xjj0
         4kLYDUoaiMXXjlwfErfJdRAZTSMQCN3CQnueX2+ZW86CH/esUG0Kwx0rqjx9HBLhJzZ0
         XsO9R4hxKwuGPQQllCiVMDHtSb9ySYUYAYdgcgIwDT0Rht6mg6oMnYNxx3MMhgS7vcMl
         ZcmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtvfA7zSw5bI+1yC/sZgeXCmQeur45hba1nAsHRtC99683M4eB4069ojr6FimTwBOhYP6wIRBCEETv36I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jbP4folc3lqOLQsbEryVJUnp5dht8tjp8E9xU/Xsw2GF8A5T
	vk2HL1a+jZy/wg0IOm/GJsZkwAJkYuQ0oguKL89hcF+bCt3C9oq4bLuud6go/H4=
X-Google-Smtp-Source: AGHT+IG4x/wSsHa4buKCI+PmRIPnd+RHX7sQl/gl5v5lsTsElHnDURLtXwCLBx6jPTcOcp0me54+bA==
X-Received: by 2002:a5d:64a7:0:b0:382:3f31:f3b9 with SMTP id ffacd0b85a97d-3823f31f87amr4159436f8f.56.1731919437379;
        Mon, 18 Nov 2024 00:43:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed47:520d:3d5c:3acf? ([2a01:e0a:982:cbb0:ed47:520d:3d5c:3acf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382398aa925sm6021314f8f.50.2024.11.18.00.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 00:43:56 -0800 (PST)
Message-ID: <7ca35f75-3423-4ed3-bce0-6f3c7fa1f718@linaro.org>
Date: Mon, 18 Nov 2024 09:43:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/1] drm/bridge: tc358775: Remove burst mode support
To: Daniel Semkowicz <dse@thaumatec.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241115160641.74074-1-dse@thaumatec.com>
 <20241115160641.74074-2-dse@thaumatec.com>
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
In-Reply-To: <20241115160641.74074-2-dse@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/11/2024 17:06, Daniel Semkowicz wrote:
> Current tc358775 bridge driver implementation assumes that DSI clock
> is used as a source for LVDS pixel clock. Moreover, clock divider
> PCLKDIV has a hard-coded value. This means that driver expects DSI
> clock to always match a panel pixel clock. With such assumption, LVDS
> pixel clock is configured to be (DSI pixel clock / 3) for single link.
> This is true for DSI non-burst video modes. In burst mode, DSI host
> is allowed to set transmission rate higher than pixel clock to allow
> shorter data bursts. When the transmission rate is higher than expected
> by the bridge, LVDS output timings are still configured for the lower
> frequency, but the output is clocked with the higher one. In most cases,
> bad LVDS timings cause incorrect panel operation.
> 
> Remove support for burst mode, so the non-burst mode is used by DSI
> host by default. Burst mode is supported by the bridge itself,
> but requires proper implementation in the driver to operate correctly
> in all scenarios.
> 
> Fixes: a4ed72e85c46 ("drm/bridge: tc358775: Add burst and low-power modes")
> Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
> ---
> 
>   drivers/gpu/drm/bridge/tc358775.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
> index 0b4efaca6d682..7496681c7b883 100644
> --- a/drivers/gpu/drm/bridge/tc358775.c
> +++ b/drivers/gpu/drm/bridge/tc358775.c
> @@ -632,8 +632,7 @@ static int tc_attach_host(struct tc_data *tc)
>   
>   	dsi->lanes = tc->num_dsi_lanes;
>   	dsi->format = MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> -			  MIPI_DSI_MODE_LPM;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
>   
>   	/*
>   	 * The hs_rate and lp_rate are data rate values. The HS mode is

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

