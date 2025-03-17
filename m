Return-Path: <linux-kernel+bounces-563812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47086A64913
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F9169C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE7F230BCD;
	Mon, 17 Mar 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gi9v8J/w"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653B76035
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206328; cv=none; b=Wqytj+gFf02kbCOzPArcIDvh7b23S+HxvnO/YsY2VFZbUDjknuEN0zRPmP4s9XpxB1sHp8ZK7O0+BXgr6E+rt6E7/GxjSdpXMZrd1onO0waua8dxQW/VCRRG1e5hHrfkzGnXrwfudwcjF9khCY8/621Gkp7ZwomSQ39PYtPfj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206328; c=relaxed/simple;
	bh=5llxBf6yrwHPPlLY2/u7q4b9DwPEQkoXUo0BB7//YyQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eXh95d1EPth0t5M5udIBVht0IbTI5Y1JR7np2i+TC0UDu57zl3qs9+dwL//HlF8lDXvgmmtp7XNXiZhSsUjLN3el7Wfto6lKKLEmImXckkbivYWHc/OEJ61vTZMR/vo9RPdgirmXsMGDwHT8hyHzm37cYQSm1X3kMfmzyUZY8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gi9v8J/w; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so13524775e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742206325; x=1742811125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Unak19FFUAPatD54I/+J4+Z4vCj2oJP7uUeW6FKDhls=;
        b=Gi9v8J/wcXBv/qYk1IWuYV7XOeGnHPC+DLvubo0UX1w3/9Yc3KUbfaJAJlN3uSIGrO
         0vMXaFQCCbCTELX5JuWnILAiIuRjZd97tXEZXuhpq67x/ZOihyubS7BfLLe/pwnJxw3c
         enAdghNBIl0YrnKoTbNUEfIWWhjTDbBhbe9kCyhAjA0wvpEXo2hIwK9FLwTuczdzq32A
         pmFWKQPckeXUDYaXgTHf+xWICqrOYFh6+JPLDUiXv9T/p1SaG45zxO6Cx5fr4sh5AsKH
         YyLJj91gshcmya3sXdxm3a5ab1AdU1VJHbyXqj4TDN1Yihn37gQO5z8JTxVb/OzvPJt3
         1rNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206325; x=1742811125;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Unak19FFUAPatD54I/+J4+Z4vCj2oJP7uUeW6FKDhls=;
        b=Z8srGkViGzt1U/adSqYxXvQjd5Gn+FlVBg/wfG8UeWdWsP4U8f7YoM/fl/m8ym+Mva
         p1duYDKXJt0RZJfmcE8hNzo3zJUXBzQ0Nm6cHLs0TR/gizUJt0MtABjDzLmT/usSDSEp
         6yjdZTzlDjhtIAPm0+wpuzxNzosIACxVVhU15tAxrkAZUR2Cz3KSgVEU7rdVYbn+s5vN
         e8Xv+6qyFZbWIYHfkEaRi+iRPyRUw4qZfEjd5ZhELdBFLmdHgiEDi2YJBUG2jaxeuuVy
         e2sqiZFi10lEoU8EqMiPfCTm0Oq4G9qMI3hg1c8nKpSJUVPkbkz42fzMfcBdNnZ6OLJL
         x9gw==
X-Forwarded-Encrypted: i=1; AJvYcCUw+4L876B7Uv0GuGSpQUu58m8lvOBc5XrXjJs0fhSWSZV/v9U54VWZBWbT4IYT7Anjp2XkuEm+hLVRnoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ5eFOENmyddTrwomJ9jxIiWIrkj4XPeHCM7zTSENqwC4Wr+sH
	eVqysXVpE5Y+iezWl9aGsblUhjQhrb9g967Pg0Qx5xbsYjR+BLzELSr4BaFq3H8=
X-Gm-Gg: ASbGnctjZOfNOXSn62cMF5p825ZrhL7o3lhhiLPFEyAPIVXYs2hAO1IOIMPP38c8pxZ
	JlhvhVXcOmdh0LQppymyp2VTvn/2cJNUkj2xRqC4nZKJpEee9SmZELSPI2WCP3jjNlrzEbUYti7
	PJTnptHMV2U2fB0JR5Tu4olskisE+VMPxdODYisy1QUtIZAPTQ3wJHBDZe/POlS3sBWkmRAWRKN
	aDSMfxZVSH8BLqvzUaBH4p3YcQY3We7oIVTpD6/3regOCZhZVl0iVOYicFrDOSlptL7gd+n3anl
	Okm1WgPp9scPO1Zg4J0KRceSYi+WMfzildTYH4wl/vk4HJZRzRap+NRevbQl27eBz2FnfAzS3ZS
	c7hDTruaR93dVU1/T9x2HWw==
X-Google-Smtp-Source: AGHT+IF9c9Mh2aIPNg9XfrvDpqYWQukEAmGtKi2uLzyWlmrgt/ypKChDbDRK5Er/GjQEgaiU1/Yvkg==
X-Received: by 2002:a05:600c:4e86:b0:43c:e7ae:4bcf with SMTP id 5b1f17b1804b1-43d1ebf9d44mr128205195e9.0.1742206324974;
        Mon, 17 Mar 2025 03:12:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:55a6:4776:6e68:e626? ([2a01:e0a:3d9:2080:55a6:4776:6e68:e626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200faebbsm99470565e9.30.2025.03.17.03.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:12:04 -0700 (PDT)
Message-ID: <3c688493-02db-461d-b07c-34f2f4477f01@linaro.org>
Date: Mon, 17 Mar 2025 11:12:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 2/2] drm/panel/panel-simple: Use the new allocation in
 place of devm_kzalloc()
To: Anusha Srivatsa <asrivats@redhat.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250312-drm-panel-v1-0-e99cd69f6136@redhat.com>
 <20250312-drm-panel-v1-2-e99cd69f6136@redhat.com>
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
In-Reply-To: <20250312-drm-panel-v1-2-e99cd69f6136@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/2025 01:54, Anusha Srivatsa wrote:
> Start using the new helper that does the refcounted
> allocations.
> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 232b03c1a259eb15e423b9d452d28e2ff95c70f8..d7530c3533af34f83ce8c6d6067e7f293f2d4bf1 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -579,7 +579,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>   	u32 bus_flags;
>   	int err;
>   
> -	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
> +	panel = devm_drm_panel_alloc(dev, struct panel_simple, base, &panel_simple_funcs);
>   	if (!panel)
>   		return -ENOMEM;
>   
> @@ -694,8 +694,6 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
>   	pm_runtime_set_autosuspend_delay(dev, 1000);
>   	pm_runtime_use_autosuspend(dev);
>   
> -	drm_panel_init(&panel->base, dev, &panel_simple_funcs, connector_type);

As pointed by the helpers review, you're loosing the connector_type info here.

> -
>   	err = drm_panel_of_backlight(&panel->base);
>   	if (err) {
>   		dev_err_probe(dev, err, "Could not find backlight\n");
> 

Thanks !
Neil

