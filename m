Return-Path: <linux-kernel+bounces-226890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9607791454B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11ECEB24AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88E73501;
	Mon, 24 Jun 2024 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKaszT+M"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC118E29
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218959; cv=none; b=YEs5hoWp6cLcjCvcpJS3vdZGpVvhEBvkKKrnrQ1oGUho/tX46WX/JiOC4KX/MxY3WlourGQ1Hr/D9X1ea1lAHQ0u8Ri+GEROP2EHDbfgN0ZYjj//H84nBX9/FVrWfrfKK0wtQZZpYgqKh42nJW9MjvUdcqrDUHc2QcgOSNCLeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218959; c=relaxed/simple;
	bh=qxRNJio/8hiBjmRwHvn5+NlGBQLcypCIrM1oBdzNzcc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ey4kevOTbhDgVSgOXxLDFmgq3YV/sq+khTKWFJAlh35KkFz1dU/+WZLjUUZk4pn08gYk3IAzAXqj218Z7z0nrfKMbQVYpQG1J6d57526DzHslmX0MUFeu1a4W25ct9mlFngXUR2Mc8J6cvm+c3l1V+VEHIB2kDtyUWLXOIR3gG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKaszT+M; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso29546545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719218956; x=1719823756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRHkXdLvarv+iQ4omrB/sCUIDOsvkQjA1vlU8xNHIOU=;
        b=UKaszT+MbWnwiVLJ/fwEMewRBGojdgjIgt6pPbdBccQUJTNXgOM0a0UHUEEjHA9fe5
         /VatEus4GdAdAlRc5FqrAulQIxPRG83Q12daSRucnNpAVdnotfGVA+kqTdHQiC63GlTv
         W0W1oBGrro6f7aNBbVxbdWekm9+h++e2afebzUbbtdKoakgUuGcRjQd4LynpZBd4b4VF
         HabnZLEQNUui4iajrKvyogys5XyCDwwlmXMlZCPZVur4tzSyA/i4Xz7fm+D6LVJzWRPv
         HR9758ZcU5i++f8cpZJxsPJxhk9eAL+srEETp9LX5haze+04ecuTeAOL7OcfLlqn0eFz
         E1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719218956; x=1719823756;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qRHkXdLvarv+iQ4omrB/sCUIDOsvkQjA1vlU8xNHIOU=;
        b=HxgT3zdH5V8BbKs8dAbPcEMmbbAHIyI72NFeVtFiyONLDCxV6UsY1RkPA26bTX36go
         PIdyO7K3SVSqoL5fm5nBCHSuK9u/FS3Abb2qTYBWD97jsBS7jX7C4vQmuOknvIdqEfQm
         YWC2jq6Xu+XyMA1LxGRDXRFyvAYFiLG/rKs5QfF1UhciH+RrQ4Chwb5Mi23L3Nj3amcq
         Cmt4Ccs7Il89pj1JcXGKdASgt/rKl9och+gCw4XtYQYm25Z3RjySEbXxoLo7MWX/h4me
         u3HSLQXbqaCdE2vAQ/ZyFt+Lg729wOnzaqbxQhKQbm0/E0Kt0N1cglPdc+nn82TjPp01
         F/VA==
X-Forwarded-Encrypted: i=1; AJvYcCVrpCU+gMVr3e7asFXePYl4bcw1OeQGINov91oS/XSZ2IiJdXoT45LPtc+r1VaGfh/hBqKj8LA0xEC+eC16vluI/Lo3ZJ0MIV9ExS9q
X-Gm-Message-State: AOJu0YwgTtdTuOUqbECYqErmsn9HPcqD+yYpotAZv2eifsKSbB0+REg3
	buK8Haw52TEu0gDGBE9uk1sOktsWqj7USfad96ni09ow37fNGqnjG1HeSbS4pAs=
X-Google-Smtp-Source: AGHT+IGu4z54nEtdCqbxfPqbNwMsgP6QHm2iowrK3TjwdkX6xGQkYLEJdq12JnpDlKFB1Yil9Zq1Ww==
X-Received: by 2002:a05:600c:470e:b0:421:79b5:6d84 with SMTP id 5b1f17b1804b1-42489540d0fmr43312985e9.17.1719218955773;
        Mon, 24 Jun 2024 01:49:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74? ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b63b5sm165061555e9.7.2024.06.24.01.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 01:49:15 -0700 (PDT)
Message-ID: <d7fff0e8-6754-4bfc-b358-c557a5bd0ddb@linaro.org>
Date: Mon, 24 Jun 2024 10:49:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RESEND] drm/panel: simple: Add missing display timing
 flags for KOE TX26D202VM0BWA
To: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: quic_jesszhan@quicinc.com, sam@ravnborg.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, emil.l.velikov@gmail.com
References: <20240624015612.341983-1-victor.liu@nxp.com>
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
In-Reply-To: <20240624015612.341983-1-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2024 03:56, Liu Ying wrote:
> KOE TX26D202VM0BWA panel spec indicates the DE signal is active high in
> timing chart, so add DISPLAY_FLAGS_DE_HIGH flag in display timing flags.
> This aligns display_timing with panel_desc.
> 
> Fixes: 8a07052440c2 ("drm/panel: simple: Add support for KOE TX26D202VM0BWA panel")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 20e3df1c59d4..7b70606e5760 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2704,6 +2704,7 @@ static const struct display_timing koe_tx26d202vm0bwa_timing = {
>   	.vfront_porch = { 3, 5, 10 },
>   	.vback_porch = { 2, 5, 10 },
>   	.vsync_len = { 5, 5, 5 },
> +	.flags = DISPLAY_FLAGS_DE_HIGH,
>   };
>   
>   static const struct panel_desc koe_tx26d202vm0bwa = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

