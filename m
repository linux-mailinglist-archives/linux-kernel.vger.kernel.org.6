Return-Path: <linux-kernel+bounces-374317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E699A686F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64801B285E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE21F4713;
	Mon, 21 Oct 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdHW6l5j"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12F1E7C1C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513721; cv=none; b=kWc0rplDWCXWHdhJFMe72xbQIrbYpSVpIzI1szrdNcoBVAwRfM9EvgrEtB6GImSTxrp/p6vcYmRSkwxV06G/fu+mKC4UzyXIxY7fB7F1UXVWzneGr2X6CAM88XScx/x+yGoWQQ4O2E+GiEuk7iv89lEXZdWC0/teU6rAlddItUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513721; c=relaxed/simple;
	bh=DBP0OOsTE11Yj47xHdts1PZQNqjVqwOWeu36dsdeH00=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qZwVxurDo9vvX9j5DNpWzGlLX6embIqrrpF8+1ZTiTxQPgf7jg2Ab5kZMnVxlls2JjBIamj8UjNT/g6Tdx+26iexItUvJkAR0lvwL9YOFVY9ltRCRdG5a5kA9yT1gtuL8UyrQRzczRNy+SIoRJTFVx8cIYcJ03gh1kJcuxvTdEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sdHW6l5j; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so3086858f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729513717; x=1730118517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFKVbBVSy5Twz2NJrd7MX/x/tbjvook+SkghctSTy6Y=;
        b=sdHW6l5j/tEvrYSAfUUFeBZ0V0qQyQeBOS9Pd9QnQCIIGwgUDh+Z5U1yOkUa7eMp1T
         F/LAOOFqXSW3tn1AmB2l/Xa3fcx1lCPJMc6BWQ9lJGtrTRBJiKHZxX+hvd01FLmhH3v7
         nvLt+Q2A4iohVABaZbqf82J7ZLczGH5ZMrUjY9FhO6at/aeob55aWhglag+XHftABiMm
         WzIvDXuJ8XCBkqPblquUw18pZMVawTSeolI6D72xUS0RgCRwyIQofGTkOceSZVwYva27
         NpCVi5C/YlGfkR3QekzTsrm2CY3kE/FAVsdSicepS/IZRbVEbLbji0Y0hkb9ksHRB5s+
         z25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513717; x=1730118517;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rFKVbBVSy5Twz2NJrd7MX/x/tbjvook+SkghctSTy6Y=;
        b=ZrWK6+AUAd1OjeShmuF/RljxxFrt98bWPPMouaTpK3MM3auhj/mFv8h/s0Z6S+jib2
         8upWNZv9FlbwHSAOYEGbN1x5Utx0Q6CXSAJfjo9RY+yeBOwbxlsksIjy+1d8uclnY4Fd
         g0XiuF3odx7L+iUWWzFjknCf+qCuXd5vM+9sYyMF3ZBRzHOQ8TMpYpycVIVdV3PRA4i4
         MgtojiaL8X4QffT4bOvtFzOjdTnQxT7XhRftgrjuUUvukdZpnFIte3TUHy0afuFSGOIy
         boXHBMCvsbBKWDdkZxYrnYIpMFKnc8l3C2gNeQXRN1AAil1A+aWM44kToL1rkSTu2RFd
         4H6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3ueEA9LXSJQ8JVhw4vsloFQpbnfjX+GZrnjtGeuiZiwBMGdeebnZNEzNgNBuost7rB78Q83VX0txaZy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSOHeyB39kkmASBBi1kBUN9SGy362VaxYw2kk9rj00mYb0WEBz
	T4/zSmSyl2pS9zOXh/PwuhWxHLWK6OlzepEIw6YcEoCiaqSFeIk8xec2mS9vDwk=
X-Google-Smtp-Source: AGHT+IHd+FXgHes3NYjH4MUcohJQ4f1USWSGT5Tv0j4+9vI1t2uAw+Rm9IHAvbdkd+rWKuLb0d0vUA==
X-Received: by 2002:a5d:4b05:0:b0:377:6073:48df with SMTP id ffacd0b85a97d-37eb489b413mr6556418f8f.58.1729513716937;
        Mon, 21 Oct 2024 05:28:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3908:dea6:2ddd:be97? ([2a01:e0a:982:cbb0:3908:dea6:2ddd:be97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4ebsm55654815e9.41.2024.10.21.05.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 05:28:36 -0700 (PDT)
Message-ID: <56b66841-e60b-4dd7-8b96-cf67628fc0e6@linaro.org>
Date: Mon, 21 Oct 2024 14:28:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/2] drm/bridge: sii902x: Set input bus format based on
 bus-width
To: Wadim Egorov <w.egorov@phytec.de>, andrzej.hajda@intel.com,
 rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, bbrezillon@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, upstream@lists.phytec.de
References: <20241017085556.3045686-1-w.egorov@phytec.de>
 <20241017085556.3045686-3-w.egorov@phytec.de>
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
In-Reply-To: <20241017085556.3045686-3-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2024 10:55, Wadim Egorov wrote:
> Introduce a bus-width property to define the number of parallel RGB
> input pins connected to the transmitter. The input bus formats are updated
> accordingly. If the property is not specified, default to 24-bit bus-width.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
> v3: Ensure bus_width is set/defaults to 24 even if an endpoint is not defined
> ---
>   drivers/gpu/drm/bridge/sii902x.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 7f91b0db161e..9be9cc5b9025 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -180,6 +180,8 @@ struct sii902x {
>   	struct gpio_desc *reset_gpio;
>   	struct i2c_mux_core *i2cmux;
>   	bool sink_is_hdmi;
> +	u32 bus_width;
> +
>   	/*
>   	 * Mutex protects audio and video functions from interfering
>   	 * each other, by keeping their i2c command sequences atomic.
> @@ -477,6 +479,8 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>   						     u32 output_fmt,
>   						     unsigned int *num_input_fmts)
>   {
> +
> +	struct sii902x *sii902x = bridge_to_sii902x(bridge);
>   	u32 *input_fmts;
>   
>   	*num_input_fmts = 0;
> @@ -485,7 +489,20 @@ static u32 *sii902x_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>   	if (!input_fmts)
>   		return NULL;
>   
> -	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
> +	switch (sii902x->bus_width) {
> +	case 16:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB565_1X16;
> +		break;
> +	case 18:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB666_1X18;
> +		break;
> +	case 24:
> +		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
>   	*num_input_fmts = 1;
>   
>   	return input_fmts;
> @@ -1167,6 +1184,11 @@ static int sii902x_probe(struct i2c_client *client)
>   		return PTR_ERR(sii902x->reset_gpio);
>   	}
>   
> +	sii902x->bus_width = 24;
> +	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
> +	if (endpoint)
> +		of_property_read_u32(endpoint, "bus-width", &sii902x->bus_width);
> +
>   	endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
>   	if (endpoint) {
>   		struct device_node *remote = of_graph_get_remote_port_parent(endpoint);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

