Return-Path: <linux-kernel+bounces-200861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152CD8FB5D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12BE3B28549
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80713D605;
	Tue,  4 Jun 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/VUG4Ka"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555C171BA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512078; cv=none; b=t4qrQWcy8YxpZFAedRJJPpWNVZkX5ZWknTS6y7mJ+FFJ8xEvo4xC+GRF9fz7AYvdDBmI4eCtSqw9V3E00TkVkwGusx9JiLOjS21oNLsVToH1J4R2rmFC5vTwItWmer8qW9kbUq76F9xOsZl9lmmv6nsJ51xKSJUE4qBD7AKm74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512078; c=relaxed/simple;
	bh=040vW42xwDh0dRhxM2zbmHCog9d1S3h5HZOryzlBhTs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=SH+jA6dWGE5VE49xGXfCe05fjU+Z0ugC/EtcMHnBr4fHnVXapg3efmUN3OJkGU5rONtOWpX7zR7Gv6IHSSJCiEbNK1ccM0VuhouvRwcK7OkXHdFavmfFJ3jrc16HpzV8+qb3a9kM/NKD/QMgWHngkHMPFc3/wfqbkEBHStVFp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/VUG4Ka; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e73359b900so12043661fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717512075; x=1718116875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vQBqWQKdiSCGnWlHt/otymCNpcbYBOH6U22YJB9LlU=;
        b=Z/VUG4KasLK4uVwyZumqVePOCABW5CVUAFjzweB0pk/H102uZGI0KdEi84clEmlCOC
         cqvbaYtQAPBglD2tMQZYw436dGqS+QNgng8vnjSJKAAzGAKcN8UHqE6HMnrqg99P1B1H
         hcRDSO648Vp6ePtBZeIoL/bb5vcAH0Vr0K7ryVqHz2Gv8CW1FkOrHSvXDlJz4s4xyS9V
         toT81ERuZABNw4MXrxosvCUk2iVWGrtswUP/YXT91yae4hrHyki18mE0VguG78Ciomdx
         DA1+gIzMjuZWSzOpFhLbKIsegjKRedEZoh0Z9G2kATRgi6vpSNctoIGFy3kSZaTNw/CD
         BgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512075; x=1718116875;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2vQBqWQKdiSCGnWlHt/otymCNpcbYBOH6U22YJB9LlU=;
        b=u44w9XDdxbnh+YrjTiTG8jWg4RblwKMuPNAYoj2tgKB5k7cOwwuJyv9ksvbQlw7zci
         oyCqSe3G7Gy3iriaWND2mk2nXu5+KBSUsLYDd4O5OxRn26Ds5H/uq6Up9iJBrYuxq2hh
         73vIQu4zlsG9zOnkec/O8L4RbS4HOguQ/a0L+0eJOSSnPYI8O4BUnfItpyVIYRipfpkK
         5kRoF5HNFbDKxEmVA4T6YyMJzuB7XZqweEzPs120LMDBWLGqUycLm18gT5DwkOu49ToQ
         Itkaz5UiQxGzOu2vj0I/cYdQXbhVHCMRJFmKpI55k2L7HoouwiVV2WIBm5/f9sIqdqD1
         Lfuw==
X-Forwarded-Encrypted: i=1; AJvYcCWyDZVEKPKdvnKcPOt9YqPuZd6ST9HUy6G6bjtOvYuqvQAMLH80+Ff9391G/cvxyVzWG6PcSHC9btQtNL9lVmf5zFwGVLM9cGPf5eay
X-Gm-Message-State: AOJu0Yw3aDMdY0dq0+azysRnp5yo9Lu6YcGzY6Kl4ERL0sZD1Rtblvyp
	dS5DmSFIqrlnDEi1hA+F+ahXZdy0JWTedcVYnap19BMaIk2op2XoFAAxaHmWLwU=
X-Google-Smtp-Source: AGHT+IEw13AJKJtvmeJ2e7Z1/3vaawvXvsxsctB4K5CR6UoYlwjJ6aniOCKrnfEuV11Hr2LCfmJdLw==
X-Received: by 2002:a2e:87d1:0:b0:2ea:7e38:7968 with SMTP id 38308e7fff4ca-2ea951e8561mr75046131fa.53.1717512074957;
        Tue, 04 Jun 2024 07:41:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:409c:8ebe:886e:8c03? ([2a01:e0a:982:cbb0:409c:8ebe:886e:8c03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8a4cc0sm156510835e9.30.2024.06.04.07.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:41:14 -0700 (PDT)
Message-ID: <97365305-6152-474a-8866-6e4730aa9add@linaro.org>
Date: Tue, 4 Jun 2024 16:41:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] soc: amlogic: meson-gx-socinfo: add new A113X SoC id
To: Viacheslav Bocharov <adeep@lexina.in>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20240604140612.1179323-1-adeep@lexina.in>
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
In-Reply-To: <20240604140612.1179323-1-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2024 16:04, Viacheslav Bocharov wrote:
> Add new definition for Amlogix A113X SoC found in JetHub D1/D1+ devices:
> 
> soc soc0: Amlogic Meson AXG (A113X) Revision 25:b (43:2) Detected
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> 
> ---
> This commit is applied on top of Christian Hewitt's commit with S905L SoC id.
> 
> ---
>   drivers/soc/amlogic/meson-gx-socinfo.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
> index 7e255acf5430..8809a948201a 100644
> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
> @@ -63,6 +63,7 @@ static const struct meson_gx_package_id {
>   	{ "962X", 0x24, 0x10, 0xf0 },
>   	{ "962E", 0x24, 0x20, 0xf0 },
>   	{ "A113X", 0x25, 0x37, 0xff },
> +	{ "A113X", 0x25, 0x43, 0xff },
>   	{ "A113D", 0x25, 0x22, 0xff },
>   	{ "S905L", 0x26, 0, 0x0 },
>   	{ "S905D2", 0x28, 0x10, 0xf0 },

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

