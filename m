Return-Path: <linux-kernel+bounces-352980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA19926C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4CD1C22212
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E018B473;
	Mon,  7 Oct 2024 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQyenx5k"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4EE189F48
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289080; cv=none; b=m6zcwFTo6upZd6cnyFVgv60+GF1/4364HoHeuSCOChcVZ9ycHMiJSCGverFMz6WpWS4XFslVKdMvSOd+GNNt+nNMEzJtpDos4/x4DZos4m38t9Gj3tJmPqYpOwKuJZNtSa+AOohaSDIs72dG+tfx0YrpTBK/hfE+4x4CDy/HnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289080; c=relaxed/simple;
	bh=g5NzqMMFjAKW0zBo/XWskR6SOG72Xb+YtC1uP0EdJr4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=h9S0Kq512f+1SnHPljn2A6tgZ6ftOYPmG+M8NQB11bCn4uHJmZx1088uuR5Hnbz5KPFJxA+T6WLG4R3TCkAeDUzQhYuPZ95Lp3uOk+g3xWdOxEn9+p+n64+soZL3aGzCJYn07ZQFsrKn6ix3nnsLEHsFbXE+K7zIJpVzSHQRziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IQyenx5k; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ce14ab7eeso3577761f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728289077; x=1728893877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1edDQaZrOkr576aznoG41NUZzv1eU7bE/W4vr93KFU=;
        b=IQyenx5kIeAr6M6NgYelGR+BfrRJImrtKC7AHo17yjxjwuXssEuHib0ozAz9bobd2M
         fuh2v/5jOOk3TBy+x+WnSt25o8NN5oWRhTJWqi/ixgz7ERWMugxareDSXmN1TkBPeI6o
         jAJSt0DxvfjU2NofPYBDU7VhxQ3igAvR4b1E1PRAShii67lJexgl2H0QTEvrKzUTUCO1
         aJrMk0IvP6tzMtv9OdiK9N2YHhvbbp3GZbLD9fH4mSsFkJxBtGU6cOMaPBCheKTQTF5i
         bRu6JEmkazzUSE3rELPpWL1FkY9EhEJ0EwuJaTjA38M2yhY1SH7paJkJ45ndnIrh2Q1j
         AqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728289077; x=1728893877;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O1edDQaZrOkr576aznoG41NUZzv1eU7bE/W4vr93KFU=;
        b=HT2S8TvWjTOO/FJdJOUwtR0fv5bsByUxl32ecDyeGNmM3/CAgVrEsb6ftw5z2HGsrJ
         9h8OphIDfDD1dAwgAuVTS+81SR08JqIeEg9ZCuTituOzC9F7IfS41TPpQzU+hSbMMrjX
         6sFuZRTIzSko8Fq9vVRqi+vQUlQQrXgRXkwBMxfY/Z5K4TVGJtjOwrDZprg3gTwQBhzD
         XMKNNvONANhyd+aclWSUdmKg/YNLclAaL7WQL0Jlq7wqANLjUJ6DL0VpuyRtaoxWVE6r
         pSa+J80WhtInm0FvoSinoT+qiaII6EetONFUAqpX3SXXaBi8LSqcNqP7soVhI4NmnOPk
         yohQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQdUps98eim93FBe6QT0YPUJByzz2YoTwCkcRYDdtD8swcLIH5RQ/HuX3ng3qYEMZNlrT6flA7tGlKSnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtL6a1ZcinMBgi83EX02Mz67wWttiD+n2IKV25gao/qwg9zey
	+Kz2fi2IbeVFlunFsrerAmNlPy9RSPc0sM1T3D3k7nWjz+3FkMSiJkCazcxJ4P4=
X-Google-Smtp-Source: AGHT+IG9XJst6wsrAQL6BA85JuUkMdJMS7rThtpc/T8etcJuu3WuC0kKVQ3Uxb4DcOCO9c5BpMzHxw==
X-Received: by 2002:adf:ab15:0:b0:374:c7f8:3d50 with SMTP id ffacd0b85a97d-37d0eaea9a4mr8942994f8f.58.1728289076954;
        Mon, 07 Oct 2024 01:17:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7? ([2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972fe9sm5142480f8f.108.2024.10.07.01.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 01:17:56 -0700 (PDT)
Message-ID: <8320f7d4-cbf4-45d2-9cad-a71eb16d5924@linaro.org>
Date: Mon, 7 Oct 2024 10:17:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 1/3] drm/mipi-dsi: add mipi_dsi_compression_mode_multi
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241006-starqltechn_integration_upstream-v6-0-8336b9cd6c34@gmail.com>
 <20241006-starqltechn_integration_upstream-v6-1-8336b9cd6c34@gmail.com>
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
In-Reply-To: <20241006-starqltechn_integration_upstream-v6-1-8336b9cd6c34@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/10/2024 20:18, Dzmitry Sankouski wrote:
> mipi_dsi_compression_mode_multi can help with
> error handling.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>   drivers/gpu/drm/drm_mipi_dsi.c | 16 ++++++++++++++++
>   include/drm/drm_mipi_dsi.h     |  2 ++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 2bc3973d35a1..d8ee74701f1e 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -1520,6 +1520,22 @@ void mipi_dsi_compression_mode_ext_multi(struct mipi_dsi_multi_context *ctx,
>   }
>   EXPORT_SYMBOL(mipi_dsi_compression_mode_ext_multi);
>   
> +/**
> + * mipi_dsi_compression_mode_multi() - enable/disable DSC on the peripheral
> + * @dsi: DSI peripheral device
> + * @enable: Whether to enable or disable the DSC
> + *
> + * Enable or disable Display Stream Compression on the peripheral using the
> + * default Picture Parameter Set and VESA DSC 1.1 algorithm.
> + */
> +void mipi_dsi_compression_mode_multi(struct mipi_dsi_multi_context *ctx,
> +				     bool enable)
> +{
> +	return mipi_dsi_compression_mode_ext_multi(ctx, enable,
> +						   MIPI_DSI_COMPRESSION_DSC, 0);
> +}
> +EXPORT_SYMBOL(mipi_dsi_compression_mode_multi);
> +
>   /**
>    * mipi_dsi_dcs_nop_multi() - send DCS NOP packet
>    * @ctx: Context for multiple DSI transactions
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index f725f8654611..94400a78031f 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -280,6 +280,8 @@ void mipi_dsi_compression_mode_ext_multi(struct mipi_dsi_multi_context *ctx,
>   					 bool enable,
>   					 enum mipi_dsi_compression_algo algo,
>   					 unsigned int pps_selector);
> +void mipi_dsi_compression_mode_multi(struct mipi_dsi_multi_context *ctx,
> +				     bool enable);
>   void mipi_dsi_picture_parameter_set_multi(struct mipi_dsi_multi_context *ctx,
>   					  const struct drm_dsc_picture_parameter_set *pps);
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

