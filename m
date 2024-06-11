Return-Path: <linux-kernel+bounces-210146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC0C903FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEC7B22466
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CFE28DC1;
	Tue, 11 Jun 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AY9fjdD/"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F152110F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119418; cv=none; b=l/VnvqhdzmNbUxKiWLEHkVbxaFVUupMvk4GyaoAa82PVTlgBiSSftnFpqw+mFuVNPGe0CcWKYFHa72ZYrt7Hvp88sSPJzdRYI2q5+r1cueLj6rgKiFrbXfXow3KRaAJYIx5JeuJrgwSQXLacEZm6Lb7uT5m6y/HW/dXeEEnFEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119418; c=relaxed/simple;
	bh=BoTjwJJJ7ATkkqEGJ6qSGGmTj+pa9a950YInbeO5Hhw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=anw8790Bou8E0bdaO9uUnQ5fDE5PQh3Fgln5k65H3txYK3ThXWoLKXLY50hJLUd8ja0pDhQc1KeyfIFYs4/YSHzYk1kbMfOtdVkMu77Yw94QBUy/3RhzZH+cnqWlfA8Z3XACznZYjI2lQRymoOEdpoWWqBHtReFB9bKg3WMrtk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AY9fjdD/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57c9f3609beso558237a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718119414; x=1718724214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gr/GFIzdJKJ6qasNHXrRqoWa4hM/cqFCXBLFqXLE2/g=;
        b=AY9fjdD/J2DefhILDKlY87rBX3YTH5tohxIWkbBlFe6IIHmNgAY7V1LJtiEpqdYeRR
         4gqfnK5CW4hsDyKdsrOFGBblBOieNDAexHQ82durB3cEHnP+GJkQrsobGn00OMhivYKJ
         ivQuY/dVftVwCoFh6hkaV7xNpWy1Ilhf3wJic2JG95kSnVdRMANjZHOftGMf27j0x8Z0
         XPc95WPMPNtobvcurVGZeydpHrn0s2TNxW+bIX0E8OBB1PIIxVgR80KcsbGLlMWccLLP
         41+85/tsNPU+DidpVkiDSnMqOCAy4TqU8xQmbuAArOroJCQMRM562JVF5S7+nAYashyX
         dqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119414; x=1718724214;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gr/GFIzdJKJ6qasNHXrRqoWa4hM/cqFCXBLFqXLE2/g=;
        b=q0C19s0PTklg8/dTQDwHpdmosoaoKjarME9NsCdo7v0EoNS2bbGz3zElpsweoC/URy
         MSFKINpoqT90V9dvkI70sgwRDFD49EJmGSZ3xQ5HqqdUEoj3Xq+jftf16wyLILsRB0uh
         bSGhQxK2gDvRHIVQT7YA046bLXFF+CmFcxH8Aj+ehnELLhPjyCLpwaWYwN5Flhc8gfO/
         bSKUoZU0au739aw7nzOROqJdGHcLNQoUtnVTHiJG9UvoCDh+YHPnXJPJrr4YHuTerRmS
         prm0BJGwx+GVJgD/blc9DnW7rlKrJUW23wZ3OfXVrbrOL2uhCx4KDKiDP/t9kcGGRoF8
         Btlw==
X-Forwarded-Encrypted: i=1; AJvYcCUY9dfN2U2taqFpl07+qklpFhMByaB62UwWOeCieAHUX4CIusfbZHM7R9PrspZ0YxonkEhm3LPp8e2rgzb9C6AGOzmMxSBZVfhM+Rbs
X-Gm-Message-State: AOJu0YzqmNNAeSTX2BhJKwPwtCnIMcCYG/zy71pokLG2V7A9ux0AE+/0
	SUgdZzbQWIhwirlcDvsnauKYAp3Ea8j3QzcL8Ef3g/N00WjPJpU1BeSSNFlyQx4=
X-Google-Smtp-Source: AGHT+IGoIoRFuoxa3E4g4XERJiS09RtlI3jJuN3E3xumax/c1mOj+ZRW7srHVBRkgYhktd/Jqch+XA==
X-Received: by 2002:a17:906:4f0a:b0:a6f:3b3b:b7cb with SMTP id a640c23a62f3a-a6f3b3bb944mr138517566b.7.1718119401929;
        Tue, 11 Jun 2024 08:23:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a4:3b2:c750:ef5c? ([2a01:e0a:982:cbb0:5a4:3b2:c750:ef5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f19171cd0sm322482866b.61.2024.06.11.08.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 08:23:21 -0700 (PDT)
Message-ID: <eefc2c96-7309-4ea0-855f-44eff9fb0077@linaro.org>
Date: Tue, 11 Jun 2024 17:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] nvmem: meson-efuse: Fix return value of nvmem callbacks
To: Joy Chakraborty <joychakr@google.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240611145524.1022656-1-joychakr@google.com>
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
In-Reply-To: <20240611145524.1022656-1-joychakr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/06/2024 16:55, Joy Chakraborty wrote:
> Read/write callbacks registered with nvmem core expect 0 to be returned
> on success and a negative value to be returned on failure.
> 
> meson_efuse_read() and meson_efuse_write() call into
> meson_sm_call_read() and meson_sm_call_write() respectively which return
> the number of bytes read or written on success as per their api
> description.
> 
> Fix to return error if meson_sm_call_read()/meson_sm_call_write()
> returns an error else return 0.
> 
> Fixes: a29a63bdaf6f ("nvmem: meson-efuse: simplify read callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>   drivers/nvmem/meson-efuse.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
> index 52ed9a62ca5b..d7f9ac99a212 100644
> --- a/drivers/nvmem/meson-efuse.c
> +++ b/drivers/nvmem/meson-efuse.c
> @@ -18,18 +18,24 @@ static int meson_efuse_read(void *context, unsigned int offset,
>   			    void *val, size_t bytes)
>   {
>   	struct meson_sm_firmware *fw = context;
> +	int ret;
>   
> -	return meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
> -				  bytes, 0, 0, 0);
> +	ret = meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
> +				 bytes, 0, 0, 0);
> +
> +	return ret < 0 ? ret : 0;
>   }
>   
>   static int meson_efuse_write(void *context, unsigned int offset,
>   			     void *val, size_t bytes)
>   {
>   	struct meson_sm_firmware *fw = context;
> +	int ret;
> +
> +	ret = meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
> +				  bytes, 0, 0, 0);
>   
> -	return meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
> -				   bytes, 0, 0, 0);
> +	return ret < 0 ? ret : 0;
>   }
>   
>   static const struct of_device_id meson_efuse_match[] = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

