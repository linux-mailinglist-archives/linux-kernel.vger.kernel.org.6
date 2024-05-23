Return-Path: <linux-kernel+bounces-187093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E078CCD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37A3B21313
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F1113B592;
	Thu, 23 May 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HR6Tzz0+"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65253A1BF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449440; cv=none; b=dGP2sP9cATWYiL1qnjQBdmeQIlSaNIO/KVNJT1MNIPLQqbz4Md56wmvdGStMITelbft3mR9GjyRysnUhLtWtn7AoJ8MdiSR4ZQxJmEVKhyg9eP4STcy4iyYPwVT7E6ZnlyILYEYiJIgPXI0M85EawXo+oWUEeqmFd+6UA1UKKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449440; c=relaxed/simple;
	bh=wOxDKcGbG4teddMtysYkv+GMqM+lZeairyyUbKJet9o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VYpf3fw6hyIRO9S4Lx0nxoTGh2zKrr3cT2VTI7i1INF7tJkWmhEARmrLNMSy9NezVFd6Y0XTmcCJcCb+d2ReG4SMHp7j+HkD0HeK/dEa9CcTD6IBd3ztYdjK8B4uM+ng42OSqnm3QxYt1cQ7PHWBE9o0jmM2QVuL02LTS9E4T0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HR6Tzz0+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a599c55055dso1054680866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716449437; x=1717054237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUckpd3f12M8kYaJMY5HnA/Fu7ehVQRJEnQQrDzdFKA=;
        b=HR6Tzz0+arRlIIuFiHwckFKxtQm7bDbNVwBgQiiDn6Kf2p36jNQenS1DhhoKoqcxC2
         yYmjA52vhKPqf674KkljHkUnuEt9IAmCc+EOwIvdPxPDc/kABjqi0EmD/IElkjeD6Wzq
         HvxQPsbLFujbL42HJvqtLYcs28p9EFOSY2O8vFQnJ70QV7DqNkoKx7ZOr2zuLylFETcT
         DvBpuPTcKYl1ZxSrcE1lnZ/fvTCWitPHI7M6sON5wGZkiYbNUrfbLM3tSUP1PH2ntp9r
         evw1yWEqw9o4N0wcEJ6dLW6n3PhxLsc7RgZt7yIHOfR0v22V/GlN6pWbhN2+lRlEbdAA
         uoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716449437; x=1717054237;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YUckpd3f12M8kYaJMY5HnA/Fu7ehVQRJEnQQrDzdFKA=;
        b=I7lB47qhcrmEs7SCcxNJYpQ2lBeTtnQhKZ91wwqkGwHEXHzyN4hmAy+YGh00f212FX
         tzg8IiYOeYZNcMv52ZoexhMBV9b8y3IqxN7nTMCdAI8mOJ8z6iaR1NgWTkrf6FcuA+US
         Jpb+JY5NJ2/XulCI78g6fbxk6iumhkT57fBghlBcqVkr+ig+cwyKZgFUxUKtMNfWEkQ6
         5tsteNfnVfrqi7SF+NWJ613/tAr9UYJZHvOBMnI+8wec7eqfjipT379Pzd24kcukAfzC
         ySyayZAwaThkBAinuJ8+idgnOUGekpVZYMpKa6np81c4PeT/XIAuZChf3OWeqvgg1JKe
         lDSA==
X-Forwarded-Encrypted: i=1; AJvYcCW9i27e+5uVqw1ajUOFJlIHr+69Ja9WBBPnr/ThJoxmJXlQsvt6vAMe6AVz+pM5gIPYo/cHKMMGJGdZwIvnzemSixf87b2R8q5UvKXU
X-Gm-Message-State: AOJu0Yw526fQvuR1xRWi11t7T1VHOgPnUqAclQlbm3nFg4mh5GJB/qQ6
	w7hf5ArdIBiIHlQexC+J4GM8yoafYHSRe5FcqSquYCds01zGx2MampHeyvR4F5k=
X-Google-Smtp-Source: AGHT+IEg8yrUmCNlfpPlVHZKKpplSIhv6sL7GTGMIAgYNR9Fx/APKeFhT3bY1HqnCGw2fw6dqJEnqw==
X-Received: by 2002:a17:906:c799:b0:a59:d2ac:3858 with SMTP id a640c23a62f3a-a622806b89amr257389966b.11.1716449436803;
        Thu, 23 May 2024 00:30:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:825d:600a:c16:a973? ([2a01:e0a:982:cbb0:825d:600a:c16:a973])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d2dcsm1892573566b.44.2024.05.23.00.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 00:30:36 -0700 (PDT)
Message-ID: <b55df123-4e22-4cba-b36f-41b4cf117e15@linaro.org>
Date: Thu, 23 May 2024 09:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC] drm/panel-edp: add fat warning against adding new
 panel compatibles
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240523-edp-panel-drop-v1-1-045d62511d09@linaro.org>
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
In-Reply-To: <20240523-edp-panel-drop-v1-1-045d62511d09@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/05/2024 00:07, Dmitry Baryshkov wrote:
> Add a fat warning against adding new panel compatibles to the panel-edp
> driver. All new users of the eDP panels are supposed to use the generic
> "edp-panel" compatible device on the AUX bus. The remaining compatibles
> are either used by the existing DT or were used previously and are
> retained for backwards compatibility.
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> The following compatibles were never used by the devices supported by
> the upstream kernel and are a subject to possible removal:
> 
> - auo,b133han05
> - auo,b140han06
> - ivo,m133nwf4-r0
> - lg,lp097qx1-spa1
> - lg,lp129qe
> - samsung,lsn122dl01-c01
> - samsung,ltn140at29-301
> - sharp,ld-d5116z01b
> - sharp,lq140m1jw46
> - starry,kr122ea0sra
> 
> I'm considering dropping them, unless there is a good reason not to do
> so.
> ---
>   drivers/gpu/drm/panel/panel-edp.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 6db277efcbb7..95b25ec67168 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1776,7 +1776,23 @@ static const struct of_device_id platform_of_match[] = {
>   	{
>   		/* Must be first */
>   		.compatible = "edp-panel",
> -	}, {
> +	},
> +	/*
> +	 * Do not add panels to the list below unless they cannot be handled by
> +	 * the generic edp-panel compatible.
> +	 *
> +	 * The only two valid reasons are:
> +	 * - because of the panel issues (e.g. broken EDID or broken
> +	 *   identification),
> +	 * - because the platform which uses the panel didn't wire up the AUX
> +	 *   bus properly.
> +	 *
> +	 * In all other cases the platform should use the aux-bus and declare
> +	 * the panel using the 'edp-panel' compatible as a device on the AUX
> +	 * bus. The lack of the aux-bus support is not a valid case. Platforms
> +	 * are urged to be converted to declaring panels in a proper way.
> +	 */
> +	{
>   		.compatible = "auo,b101ean01",
>   		.data = &auo_b101ean01,
>   	}, {
> 
> ---
> base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
> change-id: 20240523-edp-panel-drop-00aa239b3c6b
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

