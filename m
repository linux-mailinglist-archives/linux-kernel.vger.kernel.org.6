Return-Path: <linux-kernel+bounces-358918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48327998547
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DF12862FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFA71C2453;
	Thu, 10 Oct 2024 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1fLorkF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95001C232A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560729; cv=none; b=cIc7hVX2JGVtRX5iL/oUmbRv311OdtdztvxI6wP8q993llNFZrGCn78/Hzn4cKHDUA4G0GKNreLkcS0vl3ZLJEOc7k5lT4Y4A32KmH28W1Q0R8hU3IkstkCSY6NcUCHyPfBQqmxo/zTPx9B/0h+ATai2EOPWoTWYgXOvSsGMnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560729; c=relaxed/simple;
	bh=q9FMhM0jnNcL9a9AR10MCSj+R0zE1bgogO+nYxeLXH4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fMORU8npwo5b/eOCp8Nq5ukpjrFfk7lNJB3em1lgeV++FdnrrULzDyB6gulNO1zSY16AdRzJxsW7VL1OkmwAQmLIY4KLa8X0ZmwUKkKZzelOUdKGh+raA7mq33F+bgOWTXXADWwYQio7C4AR9UwS9B8qQ5k3z/O4OhZo3RM0rVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1fLorkF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so6164795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728560726; x=1729165526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2xmxsqgdQVradbva4jgM/cA1GhFS38qtF/e0CndkSs=;
        b=l1fLorkFEHh9g6xNv7USRiDU5pBFiXyAKQs349r4eCL1XAnCbPOP8vMx/Pf2Ch2De4
         UJIXBXEag43h89re2nrc6oWlihpKm1O85jigIeypObJWsNipVFHfs7Q8uF4SwC476EIU
         XZyFPRBNSTELaad7FwwqI+Gel6Ze0Awu1XUZxUo/dqD7PelkkaSo64CihdDegaWT61bv
         o19NH/XuPzQIALNR/b5JC3Xcip9Mr0eXPFbB6bZt9Kyn52+YVJNVU9SQ7iMXMto7viBN
         ZgHuJkvzKPVM6q9XUSMjj6+RlgrtUCI9SWn7zRpAO5xEiXSJY3OetfNIjo+7e9HgSsdA
         /xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728560726; x=1729165526;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2xmxsqgdQVradbva4jgM/cA1GhFS38qtF/e0CndkSs=;
        b=Zw6j09YH2SrqzzpqE8MhBYSDAKfmthNtZOlvQ+1RqJfyH5055vxgCCeVRaCnopTDoL
         zo/J5Lmu3pG2y9N7cy1+n1TfT2WjLdKNPlaN+nAB8c62cQ7Yg0XnXK68QwK9JpKURCrZ
         mclEkQdEZy87xiyusvAYNG5pEphvESxs/j+08mDaPH9KGLb/Esg4tcP5ogYPsJWbaPaP
         yK9TKj4HCTVBz43kBXxomdLz/FunqoCxeBZK4bzundHNHPz2nyBbcIfdZw3bO1s5cPoN
         /faVWeXly3cY6Ny9hK4ymheyv1jMCPKHB++VptWL+peD2w76pzL/fVdzPquudfhkZCic
         +6Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUc+/2X+ksP0G7BxekkrWitTFsphcSWLDHXlXJ2xK/NZ6b393UX45Sgz4rrRQJG9wD0zjK1ErSuXakr3tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdEFci9Se72doAyGJlJ4UEauGUuu54oWC1j+/bVP/mfDqcie+F
	QxACl1CPY0ZZDWJyak4JjvQNRPStx+aR6MXVnpXimuKOngiuhXJG9ctPWrU/bdpcZiI1TN0SY9h
	JhAg=
X-Google-Smtp-Source: AGHT+IEEXQ0SEJ5dsi+RYFbTzB2LMay1r8aPCx38Vlq/fjfIc7PXi4TMfoTrzPoCxDWU3RYD3VzWJQ==
X-Received: by 2002:a05:600c:1f11:b0:426:593c:9361 with SMTP id 5b1f17b1804b1-430d6faa2c2mr44641545e9.26.1728560726053;
        Thu, 10 Oct 2024 04:45:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:64e2:34a0:1d01:60a2? ([2a01:e0a:982:cbb0:64e2:34a0:1d01:60a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183061a4sm14120285e9.23.2024.10.10.04.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 04:45:25 -0700 (PDT)
Message-ID: <318b658f-a395-40f4-9bfc-0261489b547b@linaro.org>
Date: Thu, 10 Oct 2024 13:45:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/mipi-dsi: fix kernel doc on
 mipi_dsi_compression_mode_multi
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20241010-starqltechn_integration_upstream_drm_fix-v1-1-cf3cb1d1ce77@gmail.com>
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
In-Reply-To: <20241010-starqltechn_integration_upstream_drm_fix-v1-1-cf3cb1d1ce77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks !

On 10/10/2024 12:31, Dzmitry Sankouski wrote:
> Replace dsi parameter on ctx in kernel doc of
> mipi_dsi_compression_mode_multi function.
> 
> Fixes: 975bdea8c470 ("drm/mipi-dsi: add mipi_dsi_compression_mode_multi")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410092245.tfsuUllL-lkp@intel.com/
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>   drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index d8ee74701f1e..5e5c5f84daac 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -1522,7 +1522,7 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode_ext_multi);
>   
>   /**
>    * mipi_dsi_compression_mode_multi() - enable/disable DSC on the peripheral
> - * @dsi: DSI peripheral device
> + * @ctx: Context for multiple DSI transactions
>    * @enable: Whether to enable or disable the DSC
>    *
>    * Enable or disable Display Stream Compression on the peripheral using the
> 
> ---
> base-commit: 4c93ede2b0c73a7708f46a01669769d15d31e1d2
> change-id: 20241010-starqltechn_integration_upstream_drm_fix-72233382f98f
> 
> Best regards,


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

