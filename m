Return-Path: <linux-kernel+bounces-292501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C25957036
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07E5282B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C81741DC;
	Mon, 19 Aug 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OL5AFqHU"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A513BAD5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084850; cv=none; b=GWLwDlwT+nubjwuw4bicsDq7zBQid6MH1beD1RGu9ZNw9f/kAPjUSRqHWVJwgr512EG0apdT6wIuh5QCQtvSruo5FANlGaFFS98B6RqahlJFDiHhjq2ppJtG/wnlrwYP0Sma0bzsvfbeSAtgf2F/u/Ig4GEY5kGKqgIEdFbibio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084850; c=relaxed/simple;
	bh=4Oh5HFWShoiE5+ep/UQTZ60Zpa1EEtGTgoYAgMZ2Xn0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jpQCMcZyYLsf77X6itOwtHlfXV6KUJX/66NBAANfwEEahAZePureujZ+OYoFdDyW5gk2j93i0A2QcqOEXbd8sgiBUMBtO59BftvNBFYqvfFdgiYTmMLbmK7mJqB+nHjQ7oQFWtvkrAKGri/r+3f1VbDRwf/JdPl1CZajKC+EuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OL5AFqHU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42816ca797fso36965705e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724084846; x=1724689646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s26y2YASDAdGxsHZ7d56abaHHsBVOs2ZG5NV1yhnbpQ=;
        b=OL5AFqHUtoLJvVpahJ58PnmmealGoZSWNG1To1PKDIzBv24LtHD3L0UVGG3BAHAOQQ
         eYNuBZ/xMjFYxL6Bh60iabUQqvis4MbtVJcneqZDuupIMfmo3z46QYdQK0XwL/6UOgjv
         YwB0bMH7lHDGgltMtTTIYK9QcQuUZG2rT2V0mT+IKtUX/oQOi5Bd36HXbIMNOcGnhHJZ
         NEpN+tvMQE4w3/Gah+M1QbAF411DjxFr+5sjwaZQBHLN95HSHbhFrur01FU4bk9XeMFx
         Kpukg8GkTY3UFYJn38fPlXdm9zukZx5L++Z7SAgmCf7y9cL3BfAESwdP+BW3GN90TLaq
         dKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084846; x=1724689646;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s26y2YASDAdGxsHZ7d56abaHHsBVOs2ZG5NV1yhnbpQ=;
        b=dJqlOT8KEgsdICmK+FyaMNtLL5HhUFqYsG1rlXwEYVko7SU9fKqgcKEsTzlGEy789b
         hK25IaVE4lDS+LGa3nBOGGD3ohEb7+W/4sYAzKl1bg8ihIMtMxaslAcfzdTEq/x7tPGv
         n8hGBI1K3n7U05UV45TLEqXwW/xUzkauGBff2B2NwYA0JjSp5Hq6C2s7YoQrt47QIk6s
         UzKwjuQOhuIwzuFRByfzDTzd9GnrlfvsePkQ5lK0opAaAJXIUdi8X11hT3bjll7VG2G4
         NfqEsux4c83EQhlauFoCcuZBZiSWjeQKdpjY3FdDR7hSBytOY0EIJ9PwRy1JJvaLyDsC
         w6YA==
X-Forwarded-Encrypted: i=1; AJvYcCVevyRJksaxsee+KNHwyLUUTmxSwR0I1Q2/SKxuuqUuiJN/lipCCUJq0qfO/mNtesUBUCrqxSph8uIPawrga4d7wKnupElr2E8hehpi
X-Gm-Message-State: AOJu0YzfJMTRMSthy+gd5b1dM5j8yrgGDDUVI1b9tie2g64HknyGRiOC
	YBZMDMpn0CDgxukzNDFSQAlXRSYqgunSwoFRi0+jJE2mwxGg5UdMod8wn3uJs6A=
X-Google-Smtp-Source: AGHT+IGyaOFKm6KH67C+5hH2/5G0422FDAPK6JZLNWUTv4Npjeh6t5xLFubuidWWYm7P8IzFY6X6Bg==
X-Received: by 2002:a05:600c:444b:b0:426:6320:7ddf with SMTP id 5b1f17b1804b1-429ed7f944bmr68331525e9.35.1724084845997;
        Mon, 19 Aug 2024 09:27:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5bfsm171663065e9.46.2024.08.19.09.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:27:25 -0700 (PDT)
Message-ID: <e8c91a84-bfef-42c0-9e20-91676bb3843d@linaro.org>
Date: Mon, 19 Aug 2024 18:27:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH LATER 8/9] drm/meson: dw-hdmi: don't write power
 controller registers
To: Jerome Brunet <jbrunet@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240730125023.710237-1-jbrunet@baylibre.com>
 <20240730125023.710237-9-jbrunet@baylibre.com>
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
In-Reply-To: <20240730125023.710237-9-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2024 14:50, Jerome Brunet wrote:
> The HDMI phy has a power domain properly set in DT.
> 
> Writing the power controller register directly from the hdmi driver is
> incorrect. The power domain framework should be used for that.
> 
> HHI is a collection of Amlogic devices, such as clocks, reset,
> power domains and phys.
> 
> This is another step to get rid of HHI access in Amlogic display drivers
> and possibly stop using the component API.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> 
>   This change depends on:
>   * f1ab099d6591 ("arm64: dts: amlogic: add power domain to hdmitx")
> 
> Time is needed for these changes to sink in u-boot and distros,
> making this change safe to apply.


Well no, we will basically need to wait until none of the stable and long-stable kernel stops
shipping a kernel without this change, but you can check if a power-domain have been associated
with the device and do the same.

> 
>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index ef059c5ef520..6c18d97b8b16 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -111,7 +111,6 @@
>   #define HDMITX_TOP_G12A_OFFSET	0x8000
>   
>   /* HHI Registers */
> -#define HHI_MEM_PD_REG0		0x100 /* 0x40 */
>   #define HHI_HDMI_CLK_CNTL	0x1cc /* 0x73 */
>   #define HHI_HDMI_PHY_CNTL0	0x3a0 /* 0xe8 */
>   #define HHI_HDMI_PHY_CNTL1	0x3a4 /* 0xe9 */
> @@ -423,9 +422,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
>   	/* Enable clocks */
>   	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
>   
> -	/* Bring HDMITX MEM output of power down */
> -	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
> -
>   	/* Bring out of reset */
>   	regmap_write(meson_dw_hdmi->top, HDMITX_TOP_SW_RESET, 0);
>   	msleep(20);


