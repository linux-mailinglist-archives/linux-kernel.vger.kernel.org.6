Return-Path: <linux-kernel+bounces-293628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DED958225
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00706284E66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EED18C01B;
	Tue, 20 Aug 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcZTZBC+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9618C006
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145956; cv=none; b=aCkTz49H8sqZ3Op2UK4QOiNKCuKZf3551mpN73sfMXNT6/LuahPyKOaEw29uuTaYhnj3+kEVz8tP3UR/GDzTaFkrK9hDMOz8KV424J6i3xFmHUXDtHgFV+pHgG8pOcPfdosTXBD1ji5SfeoBCS0QtLRrrblATlKwz9sLU9ngbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145956; c=relaxed/simple;
	bh=aCftOF2l1DIO9pJ3hoV3EoBtfZ4BDNpCl4r7FIXJdgw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ijcl3HS5EuRHyH9+k0wOrrf6Tlsu1PvrCajdlWutSJ7ahWtcXL1HQh2djQzI8zKS1I2r1+mvWr4ESoB7iSUed817J2LWuItyZMVY9g7u79TA09AgyGuRRK4wqfBIZVqXKfoqMYLVEq/jEpgxeYe05ubcZTo0C4O9jC6GMw6cfwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fcZTZBC+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428163f7635so46123985e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724145953; x=1724750753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fpdSwy3nGrw4PABZFiCr5LgDgb+DtH007BgfPyMTp0=;
        b=fcZTZBC+GhJgdX5GObLy1lipZhfZeKRyB7XeruHiiTRJpI7Mj9gK7SKZW/E/vXBq2f
         u+2ZmgrAfglgQg14rJef9PA4TvFUZIv1vACMSRuPjko66m2pjc6RljTYny0CkAvGhOxG
         tp5U0kHVftoT2qK9GGkj7CXh+dJasT+bR0azNq5mR8hVndEb8MI28hYvgj3+CsvjRJrP
         bA+T3o2RPo1qelcmiWUqa2NgXWCBDknMhWtZgRchVSXKnMTVaIMkVB+0Y+d49F7eC8yu
         sLqAvOOLgcZN6R0uz4vzsirMRnWcWqNU0EppLkdTcnDAF/3n3nODlzX2dOLnJ4O90RGq
         onig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724145953; x=1724750753;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fpdSwy3nGrw4PABZFiCr5LgDgb+DtH007BgfPyMTp0=;
        b=IqJw8GD8xzPQaBdiwoJ9lwNmHepAV9XBsoeCU+s4CpMbhl/7wZFuDm0F8F6Qo2wd1m
         sAGZql1NStM7TIGF2gKkR3Szjb+UO81iFFclVylDdeGlwu/zIv/f5cCzZq5He+WhMuq7
         wdA2iOMCH5b40vPaLo682jtaQnp68QkW+EnEaq3c0iV1LHN56VbRLKN7PHi4c6hlMJaO
         FFD0MzuB3Qx0sZS5zrJmdScSR6AP898ZqWCPiQr6K2k1sWSVBI5gk9W3K+BrtcpJmNw0
         MItngWKk+k+FgMrh+IUOH0qgkJvcII5aLgY6D7wRjEd1zt5sZVsMrjJx5FTkvHL62sEa
         INmA==
X-Forwarded-Encrypted: i=1; AJvYcCV/QT7Xy8FT4F3aVIgMALqV2hO2o3zNGpwXFaBnyDhyBMMra+G4s+MR6bgcf2rMZWuEPV5nxDfTbfgtCPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0+tVNlrmpir+FFp2A67pt/0wmy0WHMdl/GyRM5+JFlWEfk9g
	Q1UAUfqshoy2s0qLGrfZ6UIwJpXAtmviMGsGhJ6f0cnLno4ZzHXGRA0pfaNmbYs=
X-Google-Smtp-Source: AGHT+IE5taQEJMC1YeBdOtD2SdXBNuCi3YY2RtBFOJ7kytJ3vZFgMvT8yq2apa+5KoIxZxwxyRVs6A==
X-Received: by 2002:a05:600c:3509:b0:426:6b92:387d with SMTP id 5b1f17b1804b1-429ed7b8860mr97908635e9.21.1724145952525;
        Tue, 20 Aug 2024 02:25:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ebdf:8de4:37af:6aad? ([2a01:e0a:982:cbb0:ebdf:8de4:37af:6aad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabf5sm12616024f8f.97.2024.08.20.02.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 02:25:52 -0700 (PDT)
Message-ID: <230d1888-294d-4651-af23-a7045f9d998b@linaro.org>
Date: Tue, 20 Aug 2024 11:25:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] drm/panel: mantix-mlaf057we51: write hex in
 lowercase
To: Tejas Vipin <tejasvipin76@gmail.com>, agx@sigxcpu.org, kernel@puri.sm
Cc: dianders@chromium.org, quic_jesszhan@quicinc.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240820091556.1032726-1-tejasvipin76@gmail.com>
 <20240820091556.1032726-3-tejasvipin76@gmail.com>
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
In-Reply-To: <20240820091556.1032726-3-tejasvipin76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/08/2024 11:15, Tejas Vipin wrote:
> Converts uppercase hex to lowercase hex for cleanup.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> index 2a365eaa4ad4..4db852ffb0f6 100644
> --- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> +++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
> @@ -23,7 +23,7 @@
>   
>   /* Manufacturer specific Commands send via DSI */
>   #define MANTIX_CMD_OTP_STOP_RELOAD_MIPI 0x41
> -#define MANTIX_CMD_INT_CANCEL           0x4C
> +#define MANTIX_CMD_INT_CANCEL           0x4c
>   #define MANTIX_CMD_SPI_FINISH           0x90
>   
>   struct mantix {
> @@ -50,18 +50,18 @@ static void mantix_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
>   	/*
>   	 * Init sequence was supplied by the panel vendor.
>   	 */
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a);
>   
>   	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_INT_CANCEL, 0x03);
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x03);
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0xA9, 0x00);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a, 0x03);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0xa9, 0x00);
>   
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5A, 0x09);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x5a, 0x09);
>   	mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x80, 0x64, 0x00, 0x64, 0x00, 0x00);
>   	mipi_dsi_msleep(dsi_ctx, 20);
>   
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xA5);
> -	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2F);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_SPI_FINISH, 0xa5);
> +	mipi_dsi_generic_write_seq_multi(dsi_ctx, MANTIX_CMD_OTP_STOP_RELOAD_MIPI, 0x00, 0x2f);
>   	mipi_dsi_msleep(dsi_ctx, 20);
>   }
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

