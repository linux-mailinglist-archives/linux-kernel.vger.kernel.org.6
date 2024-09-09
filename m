Return-Path: <linux-kernel+bounces-321444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C17971A78
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272B1B25017
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5BB1B9B55;
	Mon,  9 Sep 2024 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtushEOc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60C1B86D5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887350; cv=none; b=PLftT5RV/gdk14kHjuNeAH8TUrfvVlDeDVdKMbFppdNkdO36iiUmm2bDMGjHNBTh3XmhIwJYg5MqdqBTPxNoBWOY7kPqcADb++meTEaz/VSUf6sh33ACe5f8erL43YW/6dUSCXYGAaH6kr1ci0P3IGQr0fktcser2L1cs5EC65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887350; c=relaxed/simple;
	bh=vEe/Qxpvo5sOWW8VNM3gGcKTiPKlxvBYJ1/KqNurYGI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PTpv54fjCw384dZUe7YGSCHunwU9M1N0vtA0JqlS/yA+j2LukRZMJbEi0/hCqa+bBYHzCqzWqNSa5Gyip4gqTTB9U1ALLtszMyS84KDpGVa7wQbEJDtIdIlK2uqQuZGyxc7SDYtDumcvYDS0YYTvH1wvkLf5KVM3+4TR63NEfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtushEOc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so39438015e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725887347; x=1726492147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pp8+krOVBN4xiv3btMIYSmkgmn24OFZlDjgzfDJ46U=;
        b=GtushEOciqlWPGbCWazK7w9ttbWeRskPYvc9OJ/Br82EUWN8kkosy/jr+/uWxhbGqU
         yp/9aXYS6LnKKREzdlbEYWC8T+i4kpCTmUZjSOUprSmI8Rpo2+4H0O04LWcPGGY9afQp
         Ai4Q2VbQ2i+mPLN4Bvj6VxzebA3i7nQcu5jOvYomNGIXOSJ0bLpMsTdiFLpIrUtls0GR
         JyLkEZb+AYWM/+nBTsTehDCSGbL3hIDn1FK6yxusntVRfoa8pgjO6e5Gs+axU/kU3N0n
         Z1ijRrM3V5laBS2l5WMYb185bu1SoM6teNA6xxgHDCDbIN3VP4J1Ox+6pGzRPV95NsLw
         hhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887347; x=1726492147;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2pp8+krOVBN4xiv3btMIYSmkgmn24OFZlDjgzfDJ46U=;
        b=rflxjUT9e7ho4hIW1kAB5iqP+6yC1N7M2jRxIdAF7XxPFp1KIygr6/BKXE7e1VVcDJ
         jT6bNCdcm4eVMof9nS4bSK04+2mz3BqnnXmL9FKDc77prZ/naA71y5rC0c4hN0yICmoR
         xDpO1Msbth0UObJQ6KGGgM6uv/2hsgtkKztdr1l0MgvE1isPgK06TGy7BY3Wy/BWpobe
         rcaCUbgjjkrFpVFgX2kVZi7ipNTD5eFQLbDNRWoeoBaQWNGQnNR+F0277/CtYWBmFQyN
         8R7kjXNkK88BV6StzYjlIEbVkubQLw1Lluw1jUJ7VdjjOGk4BFl0JnsEMME3JPiIW/j0
         VV1A==
X-Forwarded-Encrypted: i=1; AJvYcCVDJD0/NC6x/ZUGhXhruWv+xS9WzwlYNlBpD8uW6BkCqkAEBtwvCcrnL4TnfuJ5CKMp/5XKbff8Gy7CvrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiImO8Y9+Y4e0xXknUcu8Y4cBl0288NaLGTHYa9XliMHIOKxA
	7LzsTve5QbRKzV0HCU0LRJFmXHSWb0SBUqndOJN8uubww79wTyrrIQR920D4/cY=
X-Google-Smtp-Source: AGHT+IHSD1+u3qLHgQQDgLd9KTZj8ktLT+x+NJyEUasmCWPbR1m2BPv58TPiHRNGozX4xwUTGBFGpA==
X-Received: by 2002:a05:600c:3555:b0:429:a05:32fb with SMTP id 5b1f17b1804b1-42cae70f2c4mr59033445e9.10.1725887345788;
        Mon, 09 Sep 2024 06:09:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:63a3:6883:a358:b850? ([2a01:e0a:982:cbb0:63a3:6883:a358:b850])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d35e5sm6036285f8f.76.2024.09.09.06.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 06:09:05 -0700 (PDT)
Message-ID: <5d4416f1-d585-44a7-a5db-7fc93c7af4fa@linaro.org>
Date: Mon, 9 Sep 2024 15:09:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: khadas-ts050: make ts050[v2]_panel_data static
To: Min-Hua Chen <minhuadotchen@gmail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240908133533.112894-1-minhuadotchen@gmail.com>
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
In-Reply-To: <20240908133533.112894-1-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2024 15:35, Min-Hua Chen wrote:
> make ts050_panel_data and ts050v2_panel_data static because they
> are only used in drivers/gpu/drm/panel/panel-khadas-ts050.c,
> and fix the following sparse warnings:
> 
> drivers/gpu/drm/panel/panel-khadas-ts050.c:620:32:
> sparse: warning: symbol 'ts050_panel_data' was not declared. Should it be static?
> drivers/gpu/drm/panel/panel-khadas-ts050.c:625:32:
> sparse: warning: symbol 'ts050v2_panel_data' was not declared. Should it be static?
> 
> No functional changes intended.
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-khadas-ts050.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
> index 14932cb3defc..0e5e8e57bd1e 100644
> --- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
> +++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
> @@ -617,12 +617,12 @@ static const struct khadas_ts050_panel_cmd ts050_init_code[] = {
>   	{0xd4, {0x04}, 0x01}, /* RGBMIPICTRL: VSYNC front porch = 4 */
>   };
>   
> -struct khadas_ts050_panel_data ts050_panel_data = {
> +static struct khadas_ts050_panel_data ts050_panel_data = {
>   	.init_code = (struct khadas_ts050_panel_cmd *)ts050_init_code,
>   	.len = ARRAY_SIZE(ts050_init_code)
>   };
>   
> -struct khadas_ts050_panel_data ts050v2_panel_data = {
> +static struct khadas_ts050_panel_data ts050v2_panel_data = {
>   	.init_code = (struct khadas_ts050_panel_cmd *)ts050v2_init_code,
>   	.len = ARRAY_SIZE(ts050v2_init_code)
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

