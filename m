Return-Path: <linux-kernel+bounces-380048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5139AE824
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B51C2188D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39361F6673;
	Thu, 24 Oct 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/DQVXYo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4210E20ADEE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778940; cv=none; b=VEQswnVYlrY/c9lliQo95P5s2Fihw45tBRgQg2Cxko9aoJW2ZWZUcUBtFkRlXEt/8Usstt8OVOizbKj9+4+K8A4tAAqxrjcTqRkkcplTB6+4LjpHcoqcboOMMweowNeUh/uO9scLgW89GwWIgZAESxDxiQRzHMr41SKQLpVtC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778940; c=relaxed/simple;
	bh=70JhF5B4RAzSQ5flc9ekaBE1VTkKScGCXnBRexd9F1I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MIiOGev62gCaEasllbzuA6C1dvAxpRz1F1OdwuCyD1+Ducz5YdsK709466ywQLoebpuiEKZqK98klvYjSiwIznz7Oef0Bgze714FcC4G9Dt8WdcERA0htbFqYFN00ooX/zuPsnp8r06M8Sv/4cl70pxRsXqdSctwUAdVnr/cPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/DQVXYo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431695fa98bso9730485e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729778934; x=1730383734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pxlHMb5AMgvpVGu1TIrG5oVzbcKbA0wfkWtUQw8bZc=;
        b=a/DQVXYoJgG82N8KWA1ZO1ODbSM/w4wCBA+Qowxa3kYSHuxBR5eBMTiuzXOkb+oQVx
         QgJQvxSXe/6+Q833WM2nveKz7RzCcHesUarrrmMOu7vht5kwSypSXFsFkIW3tV4jAYyv
         xZ7AE8GbhYgi/5yaCsbcYEbQDRWSgT8zoIXnDOmIldOU350qS57wIQDXTPdPgs7nhCWQ
         6vyjpk+fa5YXMeqi9jiRuvYe8CTXTUtbcX1GVHcqO4iqQmPRU9QlVXr5eAOpDBw+cEOF
         8zFcDmliAIjQcuLqtDSfWoz6U0JszxbYqIyij3pRetHssyrujtNNwMY5Rgotopp8Epee
         9P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729778934; x=1730383734;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4pxlHMb5AMgvpVGu1TIrG5oVzbcKbA0wfkWtUQw8bZc=;
        b=Kqv1U58H3q3PqWS2NURiCCApPdghH8+myqaRZpNPdztwpzvit80i83oVO6lXt6eWgP
         ec51L6G6Ofo23BpF+twRoGzDoprAjcFn9nVS69Mbodnq+DyiHVIog5Xi4Wda+GRL4h69
         QObQaORqYYBdhuH3i5HR3RIsD4icSYZ5gBR4MBdWmFJW4ngXrCYMCe3Go8PSlgzBwjz4
         lEZ9d07vEfzOSlIROjGClxgnwh44JQuF1MwOfd4ouujrOhj+qAJficq99+9eI20pmuAR
         K/dribGcE1kgf9apBxrfrU8hwnjp3ZpuZgOcs7FnwNNhaq/is3Hvmw3d3tDoQkOw69b9
         1r7w==
X-Forwarded-Encrypted: i=1; AJvYcCWqwX7P9n+m+s7/qRQB9fjMvjYlufqMs1KleQmRxTYNIf/BiHkf6q29PbIrvQ5jANnpyQyEmOucKidYXHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx2w1ruCpDyBL+vH6d7O5+f4HwObHvm0bp/r1o+xqlMl5FXusY
	13J8Ac3AP/0fYmlsK0On8jQf0w5aEYie4zq+2dTvY2VTGBhurOeTbQNjuvVCpiXoA3gbkyjUdY5
	5VKs=
X-Google-Smtp-Source: AGHT+IHtwZ0D7Hbl6lV9vXaF6Yh+U6E2VIFK5c7xfn2hS1JAXlfziXP71xH9LYJKYWxoN3UwtKx2ZA==
X-Received: by 2002:adf:f151:0:b0:37d:5338:8733 with SMTP id ffacd0b85a97d-380458b6106mr1655793f8f.37.1729778574351;
        Thu, 24 Oct 2024 07:02:54 -0700 (PDT)
Received: from [192.168.1.70] (147.48.71.86.rev.sfr.net. [86.71.48.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b5asm11376286f8f.10.2024.10.24.07.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:02:53 -0700 (PDT)
Message-ID: <5db25cea-10d5-4ed6-a385-141775a2a8bc@linaro.org>
Date: Thu, 24 Oct 2024 16:02:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: synaptics-r63353: Fix regulator unbalance
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
References: <20241024105050.3483542-1-dario.binacchi@amarulasolutions.com>
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
In-Reply-To: <20241024105050.3483542-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/10/2024 12:50, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> The shutdown function can be called when the display is already
> unprepared. For example during reboot this trigger a kernel
> backlog. Calling the drm_panel_unprepare, allow us to avoid
> to trigger the kernel warning.
> 
> Tested-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Could you add a Fixed tag ?


> 
> ---
> 
>   drivers/gpu/drm/panel/panel-synaptics-r63353.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> index 169c629746c7..17349825543f 100644
> --- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> +++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> @@ -325,7 +325,7 @@ static void r63353_panel_shutdown(struct mipi_dsi_device *dsi)
>   {
>   	struct r63353_panel *rpanel = mipi_dsi_get_drvdata(dsi);
>   
> -	r63353_panel_unprepare(&rpanel->base);
> +	drm_panel_unprepare(&rpanel->base);
>   }
>   
>   static const struct r63353_desc sharp_ls068b3sx02_data = {

With that:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

