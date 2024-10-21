Return-Path: <linux-kernel+bounces-374681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5279A6E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE6A282DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE351C460C;
	Mon, 21 Oct 2024 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIVR4Zw9"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049D1C3F38
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525430; cv=none; b=Vq7RMdC2Gs2SN+RnhUeYgY4tL8gjIGxktJteUlxW9n4eYaUAFiaibpMI/OBVRIUgT2D8uQTOSwST18xFn2/LqWHVDyy57xDnvWZhbLD3Ui+wQOIXD3sBwpcL0eVy4qBPQzmlhJrAgdK2O9f9KAtq0nJB2sHOrRT/TZFuHG9YsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525430; c=relaxed/simple;
	bh=i6i/59JCEVsHCnMoO1FJ7p/UISE8eDTzY78w4e5PFgM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NRvymcrKHbqWv4ZFVPNvjHwnOMUNTBZy09vXIkbLVsIWkp5z4vWYnYK/rdsMcZShPoYqhQtTRyYu58yUlJSLwzc5V100rswQKsLA91jBCDuN1VUNYEPPSUtQBC3AAeVxm+8/Imnw6isS3PNd+l+4J2ctY4rHZ5huzGFSDbk6gn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VIVR4Zw9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d461162b8so3063811f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729525427; x=1730130227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGA74I+lerUAIhxea5XYBGaEAohmLRQWTRCa+iIScN0=;
        b=VIVR4Zw9BDgV+sBWQBtavVV+s3B5u3v+Pq3dCZ1qfu9QRFL60KpxJfz3iafgp8obB/
         J7oqE1h8WsJ3ii8lIL9n4IvTBd05u71KAOhuX5/FBkCYJNTbbc1439Rl1pSc/oKHW/zz
         3ax64kg6z1Qd5bRHvhIqX1rvw6+qWHNIVGmOesNBvf+LjKom+AN2gowinmenIviU/MHi
         r4dWfgZI6nnM0XqJsJbGPFZ6UYu85SRCs4zrt9JVnY1zQSozxyXz24cMoPfRae/jQwVd
         7B6V8vXg+DZ3/ZOEciXnjDTZBIRoXlOAgTakEoGI+oItVUqdCvUkAZ8Ur4VYb3UhqcKU
         u4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525427; x=1730130227;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KGA74I+lerUAIhxea5XYBGaEAohmLRQWTRCa+iIScN0=;
        b=v+3YKCDIkk1/WHU0aQ/ignwjVGubGqV991eik3m7v7g3iHomum/NRWEtuWSh6xeCav
         2zoBWAGJHD+dCgm4V2hQkn3HIhcthjmF++zFCXwIyQc5U78rQSdutnnebp3JJ6Hhr4B+
         DJ3p9XzrdgIio9x7Bs885NNPWCsSwSuvOmskJWyXpoM7K05TCA41GyABbeCgmoSSN/WO
         vowRrz2oZmMLWQtROnE6u0cahU6Vz7sL+74w3Z3de3qIq23gmnD1+oKnyaX6zUgBTPLG
         +4Bk1D0QEZKJd2RUyA77UxayFmjDSy76yvrp73oLH9IKrM6O3uieD6OFOyz2wj2Z2fmB
         kOLw==
X-Forwarded-Encrypted: i=1; AJvYcCVsYLu7rPlNaOXdCx/Z7ChazMMZRC7PRLgRl5RC17hdHrJrUgPwEIotBrHNGSDBSmxUGOY4rLIH+CQbwfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvjGeS0k6T1yrbuUWFMoPSQ2Nl4KGW1hapxjpfbRQ8jPV4GNoM
	90PGcs/SjpnT9f+LaCPK5a6hNYOZ7xe9zeJjAMEWHL5k+4g17rWOHilyaQ2NnXs=
X-Google-Smtp-Source: AGHT+IEsQ5AxlB9GE6akyS5dKzjRFYX7u8twYPyLIG6YTNGCTtFu0tNbmMGEU3mLEInFyESnDA5wEg==
X-Received: by 2002:adf:b35d:0:b0:37d:4894:6878 with SMTP id ffacd0b85a97d-37ea2140245mr6051299f8f.10.1729525427001;
        Mon, 21 Oct 2024 08:43:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3908:dea6:2ddd:be97? ([2a01:e0a:982:cbb0:3908:dea6:2ddd:be97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc183sm60983875e9.40.2024.10.21.08.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:43:45 -0700 (PDT)
Message-ID: <a252b2e3-14dd-4e76-bce5-d5df511312ee@linaro.org>
Date: Mon, 21 Oct 2024 17:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: s6e3ha8: add static modifier to supply list
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20241021-starqltechn_upstream_integration_panel_fix-v1-1-81776e89052a@gmail.com>
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
In-Reply-To: <20241021-starqltechn_upstream_integration_panel_fix-v1-1-81776e89052a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2024 15:52, Dzmitry Sankouski wrote:
> Add 'static' modifier to panel supply list.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410160810.0jaNgxB2-lkp@intel.com/
> Fixes: 779679d3c164 ("drm/panel: Add support for S6E3HA8 panel driver")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Fix kernel robot static analyzer error.
> Rebuild with sparse to be sure.
> ---
>   drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> index 76b5a6ea610d..64c6f7d45bed 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
> @@ -24,7 +24,7 @@ struct s6e3ha8 {
>   	struct regulator_bulk_data *supplies;
>   };
>   
> -const struct regulator_bulk_data s6e3ha8_supplies[] = {
> +static const struct regulator_bulk_data s6e3ha8_supplies[] = {
>   	{ .supply = "vdd3" },
>   	{ .supply = "vci" },
>   	{ .supply = "vddr" },
> 
> ---
> base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
> change-id: 20241021-starqltechn_upstream_integration_panel_fix-32270575b583
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

