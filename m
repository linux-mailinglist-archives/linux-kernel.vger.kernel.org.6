Return-Path: <linux-kernel+bounces-245356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1591A92B19F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB611F22696
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80D15218F;
	Tue,  9 Jul 2024 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0gXX0O8"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFB14F9D9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511590; cv=none; b=FgiBLZkgfZKoik0VbTt4+dhlD6xx0S+MhDlUws7ypglUl0ZoQMOE5clPt1a+KE9rvqQMP2dSLjaLHdILtAa8fUxdjQAkyhMOGfAhI5VL1Lv9YO4uJWAX/AGFiy2ZZp1xpXIJvGBxei/o7Ax4oOaxNtQmMEfRB1CLYbZXqdZPO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511590; c=relaxed/simple;
	bh=gfII0zhUn1atGGU9cc8kglrMj/vxz87CvQr4T/oV72w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TrjzRO8UYpbMj/pAV7Yrtv3Bai3S9N5HDf0al2JbKGInmmgAVquUTMPOxrKyW4m3KUp1ASWQp/5GTDSxb44IuRP14fUIG1orq4V+3VZwrri/8tjKSB7vsTbi+3hz7bLCba08cLv58N9ozw251EI5YSBx3HSpABsCsp81Nyyb5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R0gXX0O8; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee8911b451so59649221fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720511587; x=1721116387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AGEuMlgvc+93yz0nFkBwtMqtIlBEUBjzj2ZINl8Zkc=;
        b=R0gXX0O8pcnKFHurrZy5XSlmjN/gikhg1E8CGISsjpNpZy1J4e5IR3ETdSwoZw4tAy
         Z91u64cBpNrNuWqI/B4uxlXqV0yq3X6G1/VuwQx4dUSVibBQZnuWJgw9HiYTCRCpYCDs
         YQnz4PwGaM4D4gX1KiUUfKuqUg/veauUyzfOknrkk2bk2+9c+RKrjtLh7FLBdaAFV++B
         jTY/igFYjNhg+JTKZ7AVkdgLhqhB191W2HXUkXT5IHc8woZ1vqgcVfvw1Sq4D1XZ3PDN
         6IvOBWR5H9mfcmKzHDuDaJmy0L1rqA/VIPIX7VBK1W8Vcl8OwB1dTGe4eAe7mkNtoTph
         Pu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511587; x=1721116387;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1AGEuMlgvc+93yz0nFkBwtMqtIlBEUBjzj2ZINl8Zkc=;
        b=jjUTELhDwYA4fpg48UewuDCioGDnsY++z66L5VgXm3usFTPPQ9ayGve6mOOC75A+ZF
         QxcGnz0bO5q2+tSeQDWSTZMMI7IxW0U4/qycA//jIwQ1eb5070fOnVO7fey4uR22D7Bl
         mBnfTO9PC7ipThCyQ3sttLfiEB2+xczEHJPO9P13Te0xgvW2uIyC59UGylxHCvSwRZ7u
         sqwgnhto0k0nbC1HiZqo8+oeSKinPMRsueGgiW23i5P7QttWsoMUKsbFLrB/BpNdsymw
         6+m/wBKJkKEnVfztrde1veYLcTakVTCA2J3N95B9mEPl4itsdB6s/Kt8v4LZVVLtvaP/
         srdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgXoYCzZEacASLMm/6WvCnrh1c5kM0L35dHdAjuXtJTnPkOobt3aULAW/NYoWJ4S6NrtrBTkyg6URE2M+BBmMqy21amhEaefUM6z1X
X-Gm-Message-State: AOJu0Yx9F1yHw92dp9tmLutC4FicTewQjCbHlFb5jhj4m0I5s/GbySPI
	dXq0pVa1AVCNXmY44QcymqOyz2LuM5JDNPmzwswqZ+OMHjm+xjVUqHuJvyYDVW0=
X-Google-Smtp-Source: AGHT+IGxLTU8fE9QuMwbFmLT718J7M+v5z1Y3xAsljjNF9JsHFKbDVR7hOBIxdvi3QH6AzRkxyiunw==
X-Received: by 2002:a2e:9f03:0:b0:2ec:57c7:c740 with SMTP id 38308e7fff4ca-2eeb31717bdmr12490661fa.39.1720511586666;
        Tue, 09 Jul 2024 00:53:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:b12a:8461:5e2a:dfe? ([2a01:e0a:cad:2140:b12a:8461:5e2a:dfe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427265d6ebasm1882975e9.41.2024.07.09.00.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 00:53:06 -0700 (PDT)
Message-ID: <ba539524-d0bf-4a22-9872-7c8347d88abd@linaro.org>
Date: Tue, 9 Jul 2024 09:53:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: sharp-lq101r1sx01: Fixed reversed "if" in
 remove
To: Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Thierry Reding <treding@nvidia.com>,
 kernel test robot <lkp@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
References: <20240708105221.1.I576751c661c7edb6b804dda405d10e2e71153e32@changeid>
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
In-Reply-To: <20240708105221.1.I576751c661c7edb6b804dda405d10e2e71153e32@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2024 19:52, Douglas Anderson wrote:
> Commit d7d473d8464e ("drm/panel: sharp-lq101r1sx01: Don't call disable
> at shutdown/remove") had a subtle bug. We should be calling
> sharp_panel_del() when the "sharp" variable is non-NULL, not when it's
> NULL. Fix.
> 
> Fixes: d7d473d8464e ("drm/panel: sharp-lq101r1sx01: Don't call disable at shutdown/remove")
> Cc: Thierry Reding <treding@nvidia.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202406261525.SkhtM3ZV-lkp@intel.com/
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
> index edc9425bb143..a0d76d588da1 100644
> --- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
> +++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
> @@ -362,7 +362,7 @@ static void sharp_panel_remove(struct mipi_dsi_device *dsi)
>   		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
>   
>   	/* only detach from host for the DSI-LINK2 interface */
> -	if (!sharp)
> +	if (sharp)
>   		sharp_panel_del(sharp);
>   }
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

