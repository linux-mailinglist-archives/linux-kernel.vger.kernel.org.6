Return-Path: <linux-kernel+bounces-184613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE68CA998
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BE1284589
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7FE55C29;
	Tue, 21 May 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZUnFClq"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3B5478B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278685; cv=none; b=HhQIXwYbTprxNMN30flu5frmtnHTquDsAbS3MZ31vY7u37Tdc0RrlAObBB64mX9I+ZSk3/xYvbV3k7gK7NB3bBrnuvEnxp4NyYnm2OwYRBuGaRdtmQ9RzT1AIxlmgoF4q3QfMrywLG+IJ5MrRqhr5qrzBU8H7jt3k31Dl3ugBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278685; c=relaxed/simple;
	bh=uLi2MkZ3WoO6Mdw8cAM7c6NGs/WS7eNq6hcFY+rQlMk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KtO0S5wL/IOEA2L9/APkXe2TEscQMWqxHiW6+SX4yMYCyZSS5Npaj6606cOjpmJ6wjfR5zsYvw23eQbdmipUktJrs0sU693shEkJCBcP/ONvx7zYcb+KuYA0aruuIv0MS+DDc3ciVbdivj5v9AdOXO5LgIsS6WBAjZbRlwOBYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZUnFClq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso9321637a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716278682; x=1716883482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAMY8jM6kvm7yEmPZgtlsWom0wlMBK3w6eQ04WgZH54=;
        b=jZUnFClqJr2+i/LtkaUa0802b8w/83mch3O0kbGQQGT+k9yLnGVTFS0qvEMZ4DJcy8
         9DDXQ0C4xlc4T760aoJ5kaaAP5YHzyBNZlShtMGaJ5xTol5/Ybd4x+4wq7hk27m1eldE
         scyt1fOVlFY74szjxXSXXcWJ31vTyAgCJb2ga8oOF5KTX/HIvhbyh1fGkybVKPt5zlZn
         REDow32L81maeJGnwJy6P84kxCD70a3ZvHM0jDDQLNhTKpPKY1e4dLeFYJTD8A4tydxx
         53/xdknQeJSl8rfmBaoLTN3EIe/g4hgXrydD1kvLUC5RxZsR2pLwwdNQEvfLrahCHNyO
         A+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716278682; x=1716883482;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eAMY8jM6kvm7yEmPZgtlsWom0wlMBK3w6eQ04WgZH54=;
        b=ZAWham9v5DrTsssM4R/rf1LnkXGBzOZm/C+f3ObEzkK5W/kJo4X+ZPvdHiQh2nX+Oe
         rFMXDHwCkvWCAq9yl3AGYNogDpaTH94aCRgKO+Id1lRqCO+ASHWHPBId60KO1NH1q91m
         TnOAnklUBPJ0y0AInFIqFLkAYwMXerqRUuYYhV8CV3iVpU30YoxqgZih++EvVFoSmDXx
         NvB9+WOUxY42IScIMu65mbhFMXbDVFvE+yJMEXSJreAwSFNHO/E0+7asrBR5v4Se6bp+
         vZ8toRSjt/pKKPnlP71VY4DmIIKNr3+pdQsHGXXLfWxXGjg9vIbSmX6l2yOFHpAoJfE3
         NBKw==
X-Forwarded-Encrypted: i=1; AJvYcCW62hI6dPQG/YgzqIqdH5kog2tW8Lazz40gOTfXp0NnHI/1fUbCEVsd7yvtP9RMIyZCBQJqNDvQzNOEUAwlBMoLURgnh0Li4dYoOitu
X-Gm-Message-State: AOJu0YzNvKUedYjDEmnjDIczRMoSIElvslYOnzfquCj9K6uwU5bSmrdM
	zi1syBz4X7pHPNWZD4D3NMWVmW3gIGAkEhL2SzilcOiXLW/TAwRtbI5UoFkfJzU=
X-Google-Smtp-Source: AGHT+IFJJOxptM8D1lGXi3EqZn8hbRk8sEydjEhMKA60wMAgoaWW76h6s6TsK4TKL6CRd80lurBGvA==
X-Received: by 2002:a17:907:77cd:b0:a58:e71d:d74 with SMTP id a640c23a62f3a-a5a2d55a8c7mr2285026566b.13.1716278681749;
        Tue, 21 May 2024 01:04:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:adf9:e5d:4c15:f725? ([2a01:e0a:982:cbb0:adf9:e5d:4c15:f725])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b015ecsm1595150366b.177.2024.05.21.01.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 01:04:41 -0700 (PDT)
Message-ID: <c08f679c-7063-4e61-a1f3-8a16459d9c04@linaro.org>
Date: Tue, 21 May 2024 10:04:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 5/5] drm/tiny: panel-mipi-dbi: Support the pixel format
 property
To: noralf@tronnes.org, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
References: <20240512-panel-mipi-dbi-rgb666-v2-0-49dd266328a0@tronnes.org>
 <20240512-panel-mipi-dbi-rgb666-v2-5-49dd266328a0@tronnes.org>
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
In-Reply-To: <20240512-panel-mipi-dbi-rgb666-v2-5-49dd266328a0@tronnes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/05/2024 17:25, Noralf Trønnes via B4 Relay wrote:
> From: Noralf Trønnes <noralf@tronnes.org>
> 
> Add support for these pixel format property values:
> - r5g6b5, RGB565
> - b6x2g6x2r6x2, BGR666
> 
> BGR666 is presented to userspace as RGB888. The 2 LSB in each color
> are discarded by the controller. The pixel is sent on the wire using
> 8 bits per word (little endian) so the controller sees it as BGR.
> 
> RGB565 is the default if the property is not present.
> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
>   drivers/gpu/drm/tiny/panel-mipi-dbi.c | 55 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> index f80a141fcf36..f3aa2abce314 100644
> --- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> +++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> @@ -26,6 +26,49 @@
>   
>   #include <video/mipi_display.h>
>   
> +struct panel_mipi_dbi_format {
> +	const char *name;
> +	u32 fourcc;
> +	unsigned int bpp;
> +};
> +
> +static const struct panel_mipi_dbi_format panel_mipi_dbi_formats[] = {
> +	{ "r5g6b5", DRM_FORMAT_RGB565, 16 },
> +	{ "b6x2g6x2r6x2", DRM_FORMAT_RGB888, 24 },
> +};
> +
> +static int panel_mipi_dbi_get_format(struct device *dev, u32 *formats, unsigned int *bpp)
> +{
> +	const char *format_name;
> +	unsigned int i;
> +	int ret;
> +
> +	formats[1] = DRM_FORMAT_XRGB8888;
> +
> +	ret = device_property_read_string(dev, "format", &format_name);
> +	if (ret) {
> +		/* Old Device Trees don't have this property */
> +		formats[0] = DRM_FORMAT_RGB565;
> +		*bpp = 16;
> +		return 0;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(panel_mipi_dbi_formats); i++) {
> +		const struct panel_mipi_dbi_format *format = &panel_mipi_dbi_formats[i];
> +
> +		if (strcmp(format_name, format->name))
> +			continue;
> +
> +		formats[0] = format->fourcc;
> +		*bpp = format->bpp;
> +		return 0;
> +	}
> +
> +	dev_err(dev, "Pixel format is not supported: '%s'\n", format_name);
> +
> +	return -EINVAL;
> +}
> +
>   static const u8 panel_mipi_dbi_magic[15] = { 'M', 'I', 'P', 'I', ' ', 'D', 'B', 'I',
>   					     0, 0, 0, 0, 0, 0, 0 };
>   
> @@ -276,6 +319,9 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
>   	struct drm_device *drm;
>   	struct mipi_dbi *dbi;
>   	struct gpio_desc *dc;
> +	unsigned int bpp;
> +	size_t buf_size;
> +	u32 formats[2];
>   	int ret;
>   
>   	dbidev = devm_drm_dev_alloc(dev, &panel_mipi_dbi_driver, struct mipi_dbi_dev, drm);
> @@ -323,7 +369,14 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
>   	if (IS_ERR(dbidev->driver_private))
>   		return PTR_ERR(dbidev->driver_private);
>   
> -	ret = mipi_dbi_dev_init(dbidev, &panel_mipi_dbi_pipe_funcs, &mode, 0);
> +	ret = panel_mipi_dbi_get_format(dev, formats, &bpp);
> +	if (ret)
> +		return ret;
> +
> +	buf_size = DIV_ROUND_UP(mode.hdisplay * mode.vdisplay * bpp, 8);
> +	ret = mipi_dbi_dev_init_with_formats(dbidev, &panel_mipi_dbi_pipe_funcs,
> +					     formats, ARRAY_SIZE(formats),
> +					     &mode, 0, buf_size);
>   	if (ret)
>   		return ret;
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

