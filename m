Return-Path: <linux-kernel+bounces-186273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FBC8CC204
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE9F285375
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3517613DBB7;
	Wed, 22 May 2024 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fagkg2fP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40513D532
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384142; cv=none; b=bsE/sE4G0TxE27gAwyHwqhAlpPhNHHT6asuh1hfzM5YiDXFIu0IZX8vpuYNfs4/hkNA279+OktYjQRVq/EMOCCSsy2LtCNRvcxnhn3X8+81gPxph9FLzh3W+yFeSeLmsqJ/n3J4SaxWfcIBkQj5sOuQBOe+1JMLMbNjyWI7orWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384142; c=relaxed/simple;
	bh=dKNZ5CJsAFXaKBWxbAsUexD9QKQL1d8lHCe0m3TQcIw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MFm4fI1szZKmQl4ftZO67Y4kTqyW1wdpgwqViGnv1wbV9j3aN+eG84hDSx9I9Eq7w9L5F4VOedCpzxsdJicje0M+N6Rsy2MY0LSy3o0sm0dOQMpn8SAR8xdBc00RqkVJpLQYZPKQyUGvz2l1A7rhAUYnSOdKi6G/KcnHVT0bE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fagkg2fP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a61b70394c0so386863966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716384138; x=1716988938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bKLL5XIAHEVLvDN5YrC/ZHxoZSNxD9MKEhKk6FUBOU=;
        b=Fagkg2fPSzzXmrNhjbKmD0GbnOfG6NgD28LPxw9nunpkYkNgxtOhBLzLvIcMf/UcBj
         cXYyonZ68F1E/zkeTsJa5PO9Kv9uL12Ql1T7BB9A3SK9Wy7lhj+7l9m4UH0AnoKVC7F7
         wjC3Ds8rhJPhrwawFtxf5Wk58v4Qiq3oOpyYBbQl/68hRKBti0CokqZq7Hy9p0aNJW1e
         UKX2OAbmn4hdfOPPAEkIkrJ3T7vGXkJBdxGct7Li/MhjpYZ3zVe74Snwar9U40WRV+hz
         o9vz+jBASjY0/A+iZm1EHrXQTkIjX7I1s3bgOfUNxziyrHcs/CX7hMpHgCseYBw1chT7
         95nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716384138; x=1716988938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9bKLL5XIAHEVLvDN5YrC/ZHxoZSNxD9MKEhKk6FUBOU=;
        b=jYL8rmiUIMV0IFrR8tnV0jKrcL/eV/dbVlaTXI6StDu0yhoUXf1OboG2xYz3O/mAkK
         6K0IG0AJC3oDclTaWRpBnTgtF3FQGZ2zlfEXrP0UltvVtPsY10+pd36CasurJUejQBnb
         DKsv+uQ2MoqBt+SCyIRLSZkNc+V0T1rTN6yg9L8II0e8SUXVQhLWMscxOSYMxed/Uj67
         wH+uuV9YAxPBh9MsMvpnbybc4TDuf6j5p+8MihP5OxFNvLneTPYdNWG54nWszmrh8sJw
         XM0y8ulbQAj13m/asEgBqZMSXisdLDw6K2cfGMKK1iXm8LRvhGAXYcEvJ8m7VU0l0zuU
         +pcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaTeJJUBjw9DuwFomAss7gWuIxXtpAhag8lzK/ka5Hgo79J9zgKx3LNSqBMA/hMiGRqJSUYFjReRcEjU6wIQUx6aUm97BsvHGObTTP
X-Gm-Message-State: AOJu0YwR5MaEAoqhj0VppaKuGLQyMeP1c+OTOjVVg+L1BAvDI1zy2krA
	AvslPgZahvOq1tYbQbOFLGc6mrDw7b7QjSXQ1vtHiDD5IyCsutuAY+NT4XuiBWI=
X-Google-Smtp-Source: AGHT+IEm0saGodh7RpUehh6ch8U1BxsILC9cvXZJ83PFyYVR48QbRteA8MXQzFg1qIXy7mSDgn8IiQ==
X-Received: by 2002:a17:906:f28e:b0:a59:a857:85ce with SMTP id a640c23a62f3a-a62281c9fa6mr123890766b.52.1716384138369;
        Wed, 22 May 2024 06:22:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10? ([2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01932sm1770472566b.168.2024.05.22.06.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 06:22:17 -0700 (PDT)
Message-ID: <4221943d-b0cf-4b78-992a-b2226589b745@linaro.org>
Date: Wed, 22 May 2024 15:22:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/3] drm/panel/lg-sw43408: mark sw43408_backlight_ops
 as static
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>, Vinod Koul
 <vkoul@kernel.org>, Caleb Connolly <caleb@connolly.tech>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 kernel test robot <lkp@intel.com>
References: <20240522-panel-sw43408-fix-v3-0-6902285adcc0@linaro.org>
 <20240522-panel-sw43408-fix-v3-3-6902285adcc0@linaro.org>
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
In-Reply-To: <20240522-panel-sw43408-fix-v3-3-6902285adcc0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2024 08:25, Dmitry Baryshkov wrote:
> Fix sparse warning regarding symbol 'sw43408_backlight_ops' not being
> declared.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404200739.hbWZvOhR-lkp@intel.com/
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> index 115f4702d59f..2b3a73696dce 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -182,7 +182,7 @@ static int sw43408_backlight_update_status(struct backlight_device *bl)
>   	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
>   }
>   
> -const struct backlight_ops sw43408_backlight_ops = {
> +static const struct backlight_ops sw43408_backlight_ops = {
>   	.update_status = sw43408_backlight_update_status,
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

