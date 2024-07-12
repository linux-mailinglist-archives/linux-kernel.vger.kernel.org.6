Return-Path: <linux-kernel+bounces-250512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370692F8B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8D11F23582
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C3F15098E;
	Fri, 12 Jul 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSTb+b0L"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937982D93
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779036; cv=none; b=O5+QeRBiYP+5i8Yf6ZcVZ/glUtq5QylelGDeHW03DObX9thoUCBjn+V2YjqpjoZ7E08eiba1st8Rs11ec8dVmChc1jdID6/qDnVukqSpxYdytqaFfqZDjpBL8FIjalBKm+YqGoNTbGRdRxaLOKBnMme3mmV6WbbDEISsN/L8wUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779036; c=relaxed/simple;
	bh=69BBWWWaXKK7jAEEAx6VjrMltghT6Mk6KJRKpv046q8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oUfYLKm8Er9dtbBlVNiw12M5IFgmV4NC3daJ+mDtBbdhBOG1lkZodzu5sdcSZSamcnabBK4N96t8kDKVXQcaKIlz3oBKTx9Uv7x2MesGZTqi9mFVSdR1t7osUOHt+g1zEpy8gJJkdNJrpKMrgMTQQKXddJu+v67UN3DNeniMgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hSTb+b0L; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e99060b0dso1994627e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779033; x=1721383833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLpvBosXYqA/rvkTh0mT/aSKt4vIFyBn/RUoc2V2tCE=;
        b=hSTb+b0LJkFY+eq7rda0kLHJcTo+HCcv02rXoewO7iycsfo+g9qlQGlPlXj1s8xIMP
         sg6hOOR/g7K15axkGvdrH4vyiuOlNJZOA8Yc3WyS+OtaRwtBCBQKNcEvkDKsS4Ukbi0C
         YvBBqrVqFCubvf019VWGhdZ6pIoKPpLKp7nm8p/sI8QWYcPzGNAzufsfKAGgGV3Ot2r1
         bF2yvaAKQsqkCWQHevaR1nHuPpTd3cP804EgO3kwT7OdXq0SAGzzpzqGG8tyWCahKYF0
         6kgVrf7lqRUS5v3c6cL7XTkPKF5aCaJioh1Vn4opIsigJPh8klb0gAGUbTrLR/l8cGAX
         OXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779033; x=1721383833;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YLpvBosXYqA/rvkTh0mT/aSKt4vIFyBn/RUoc2V2tCE=;
        b=l7NHeofBSw66OG2j11jh7U3jRX8WmbLw+jpxiTHNf0fRgwsgKaBPV4KCy96+7VK/9J
         j+5mLuPiFQnW33pgTqDq3iPnuVrUFx78+PEGhtFuNnmYsRnqr+Ndh/JILNv1ZG7zhkBa
         1walTSoOrJwmjqi2Oka7LnkoY27iw3Lq9VPOjif8VK5oGdu+xIQhjjSQjMHjRNW9OlVy
         dTOsgv4ZcM/kcdKe9/sy47MSIXhVePGqhIIL8k4QJbowRex0prpCBW10kDxVxE55q5S9
         i1/ajpAzFiUTuWiy6ejqRb3lXUZaKzJFQtCKAyTFyL87pC19+pIccyXDHh5i1E5PllPn
         7SpA==
X-Forwarded-Encrypted: i=1; AJvYcCU50nD7ynxaDl5MYuDeWrzRvB6S1HOzI4BlZ3KE0rHD35F0kq6iKme9PdDGOce5xnoVQ80GyYWkUFp1wrgqytGd6/cHCp/qo6q8XCUF
X-Gm-Message-State: AOJu0YzL0Vk2OiDoCj7JdPG6cqDO9Z6/DDoOkpfS1br4EJhnXA9FIq9g
	2mFIh84hQIzfAY9d3F/j73/D3j+syJRRp+ib0jMbP1N/SDawwv3Rp3p1Edt/3oA=
X-Google-Smtp-Source: AGHT+IFyqA3t3hkhhZrqF6nOtAnOoKoNqbS8mdY6Lc2Js711DlS8tj4mRAf2O93AAOxPA1QJBSNftA==
X-Received: by 2002:a19:f509:0:b0:52c:dfe1:44ea with SMTP id 2adb3069b0e04-52eb99913c4mr6234622e87.6.1720779032594;
        Fri, 12 Jul 2024 03:10:32 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:123f:f92c:dc0b:c36a:f16e:7964? ([2a0d:e487:123f:f92c:dc0b:c36a:f16e:7964])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36802d3f680sm1378714f8f.33.2024.07.12.03.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 03:10:32 -0700 (PDT)
Message-ID: <1dc131f7-b5f3-4219-9aac-7a5155a41165@linaro.org>
Date: Fri, 12 Jul 2024 12:10:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/5] soc: amlogic: meson-gx-socinfo: add new SoCs id
To: xianwei.zhao@amlogic.com, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240712-soc_info-v1-0-05ba95929d5a@amlogic.com>
 <20240712-soc_info-v1-1-05ba95929d5a@amlogic.com>
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
In-Reply-To: <20240712-soc_info-v1-1-05ba95929d5a@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/07/2024 08:54, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add new definition for Amlogi SoCs, include S4, C3, T7, A4, A5.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   drivers/soc/amlogic/meson-gx-socinfo.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
> index 8809a948201a..7549f1644e5e 100644
> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
> @@ -41,6 +41,11 @@ static const struct meson_gx_soc_id {
>   	{ "G12B", 0x29 },
>   	{ "SM1", 0x2b },
>   	{ "A1", 0x2c },
> +	{ "T7", 0x36 },
> +	{ "S4", 0x37 },
> +	{ "A5", 0x3c },
> +	{ "C3", 0x3d },
> +	{ "A4", 0x40 },
>   };
>   
>   static const struct meson_gx_package_id {
> @@ -76,6 +81,11 @@ static const struct meson_gx_package_id {
>   	{ "S905X3", 0x2b, 0x10, 0x3f },
>   	{ "S905D3", 0x2b, 0x30, 0x3f },
>   	{ "A113L", 0x2c, 0x0, 0xf8 },
> +	{ "S805X2", 0x37, 0x2, 0xf },
> +	{ "C308L", 0x3d, 0x1, 0xf },
> +	{ "A311D2", 0x36, 0x1, 0xf },
> +	{ "A113X2", 0x3c, 0x1, 0xf },
> +	{ "A113L2", 0x40, 0x1, 0xf },
>   };
>   
>   static inline unsigned int socinfo_to_major(u32 socinfo)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

