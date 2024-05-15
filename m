Return-Path: <linux-kernel+bounces-180378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEDC8C6DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD24D1F24982
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F515B541;
	Wed, 15 May 2024 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHKjO6+a"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680815B134
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807841; cv=none; b=ksSFM4vvCyn4ZqDnqfKW7vGLBdqsGhqJIPuE+mVGUWKPbjNmwJJgC21HihHLY3FKEgVKJQtOj8pVr/ZsijRj+nwVRiD6gbQ1c1VFKUpB31hngbTuMFrmsKLTegjRccY+58+flH33zH5gRt3jB1OZkCfj6SYrGh2xS8pfK8ZkChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807841; c=relaxed/simple;
	bh=1uPoM8M5AFnNA/aSK75lckJJ0XXBCxElxSBf+HLF4/Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ChlVG/qw06o8ntsDT14K6wSOdWENDivBgyFNDREgPG7kYDFdLWXj9j0hD5rZelNVIq1OxdK7H5xcKH/T3pJqpMRrZf4HN7E7iLT2oi12Bka22csY9nvOYUCQjBV1T03m1JyTZKmwJo1Z2YD6HHZPK2HZAHN+18e8XInOdq0Q2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bHKjO6+a; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34da04e44a2so5743387f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715807838; x=1716412638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0ecu82tuX1ni98ypLLsTpUA0kFlxPhIqL4+3/EGxOA=;
        b=bHKjO6+aDOUhEVD+aJCFXw6ntVRO0vX9hU9v85U6XbKR8WLrcyEGvwcny8k5PTjVwn
         /aFeRmHJeMYD6afjYvFydPsAHsQcCUXOOmcy318HuqXQpxrzoYSk/Sxn8XzOtAZNpg7b
         CrMRjp1UChcveu8KMLq/B9p46mqcrcIiAXkpfk+ZsU5UbMozSyl7stzcOf+e1G8aRpv7
         ERP64mWqnhFuL8PGsRCpBVZyc1sfFzVN5oEFexfQ1ZII1dYK0RCKQi25FmAuh80GzLVH
         6eog7+kOBs6Mij1A6Bu9rvJnOxnHpbQ7wjoLdqr3y6wy/PMMUG74vgjFoJbvpU7qlggI
         t4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715807838; x=1716412638;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D0ecu82tuX1ni98ypLLsTpUA0kFlxPhIqL4+3/EGxOA=;
        b=N2lzVO3jTGg7ScMgYWr3lWtuGNVV6pLpHYRJqKxPNN68PJDTr3JP12oti8mmYX/Y8m
         TDenphanLeTYC1znQ3tkQtY2Q2OBidr8TERe/lzE6F7s5cCw+/Kyt9bq6M91H7tdBqKL
         HwTJu/DprMaEn8FvdPIDLFM6qPD4Fo7H8eLjqYeGJfB2u6rrZ52UacyfEJ2agcts9m+O
         /4ClDytTnyKGWwN2X4vG/bWCjaMGOvPjQOD/URSgr7tJwcaNXU0zs1XCUUNAaQo207ZI
         8w6dyq2Oyy7feA+++lh/ugNndodpdMnR/PNbCicCdnbWRNB/xgH4HPk/4vcwVkWcK/1a
         a4wA==
X-Forwarded-Encrypted: i=1; AJvYcCWgqW7vKd7B4SssQeNghONF93wXLcwp2uIJDBPLCk/bhdRJOuV84pGOnyegQOqxY75/H7/76vBipTruzk512pBUuupYZ/O/8Ybe3qsm
X-Gm-Message-State: AOJu0YyPtFu1MXl7RrBd5BrBNHx/tDXk7Dmnz3l0QIxapSTLqxiWUdZD
	2RusKiaVSsYzodSiD0WHM5i6crXwyLkpUIgV+EcIjDljfrmI6qcpp8iGfnaLfQQ=
X-Google-Smtp-Source: AGHT+IH8Iu67CkoC7/nlTrdtjmS8OSpJsiAUHCgKh2Xh/6pKxrhVkmBbpcisbLl6bNrjDPNWu/keEw==
X-Received: by 2002:adf:f791:0:b0:343:8e85:dd7c with SMTP id ffacd0b85a97d-3504a9580bamr12811320f8f.55.1715807837876;
        Wed, 15 May 2024 14:17:17 -0700 (PDT)
Received: from [10.1.2.176] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbca98sm17355196f8f.112.2024.05.15.14.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 14:17:17 -0700 (PDT)
Message-ID: <eb65ad1a-04df-42bf-8683-ba8876bb885e@linaro.org>
Date: Wed, 15 May 2024 23:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 6/6] drm/panel: simple: Add Microtips Technology
 MF-103HIEB0GA0 panel
To: Aradhya Bhatia <a-bhatia1@ti.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liu Ying <victor.liu@nxp.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: DRI Development List <dri-devel@lists.freedesktop.org>,
 Devicetree List <devicetree@vger.kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20240515095133.745492-1-a-bhatia1@ti.com>
 <20240515095133.745492-7-a-bhatia1@ti.com>
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
In-Reply-To: <20240515095133.745492-7-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/05/2024 11:51, Aradhya Bhatia wrote:
> Add support for Microtips Technology USA MF-103HIEB0GA0 10.25"[0],
> 1920x720, 8-bit TFT LCD with LVDS interface. Its a Dual-LVDS Panel and
> does not support touch.
> 
> [0]: Panel Datasheet
> https://simplespec.microtipsusa.com/uploads/spec/datasheetFile/2660/13-103HIEB0GA0-S_V1.0_20211206.pdf
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 3a0d8f0ff267..1b0a6b4e034c 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3084,6 +3084,35 @@ static const struct panel_desc microtips_mf_101hiebcaf0_c = {
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };
>   
> +static const struct drm_display_mode microtips_mf_103hieb0ga0_mode = {
> +	.clock = 93301,
> +	.hdisplay = 1920,
> +	.hsync_start = 1920 + 72,
> +	.hsync_end = 1920 + 72 + 72,
> +	.htotal = 1920 + 72 + 72 + 72,
> +	.vdisplay = 720,
> +	.vsync_start = 720 + 3,
> +	.vsync_end = 720 + 3 + 3,
> +	.vtotal = 720 + 3 + 3 + 2,
> +};
> +
> +static const struct panel_desc microtips_mf_103hieb0ga0 = {
> +	.modes = &microtips_mf_103hieb0ga0_mode,
> +	.bpc = 8,
> +	.num_modes = 1,
> +	.size = {
> +		.width = 244,
> +		.height = 92,
> +	},
> +	.delay = {
> +		.prepare = 50,
> +		.disable = 50,
> +	},
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct drm_display_mode mitsubishi_aa070mc01_mode = {
>   	.clock = 30400,
>   	.hdisplay = 800,
> @@ -4726,6 +4755,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "microtips,mf-101hiebcaf0",
>   		.data = &microtips_mf_101hiebcaf0_c,
> +	}, {
> +		.compatible = "microtips,mf-103hieb0ga0",
> +		.data = &microtips_mf_103hieb0ga0,
>   	}, {
>   		.compatible = "mitsubishi,aa070mc01-ca1",
>   		.data = &mitsubishi_aa070mc01,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

