Return-Path: <linux-kernel+bounces-449070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B559F494A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDB318927F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA41E633C;
	Tue, 17 Dec 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/6TyF+x"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8171DE8B9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432902; cv=none; b=OG+UdifGNZNBuv+E7dg9py0JTvKTcpGjEg4snymnpBflFSw2bP+IXXg9j6DL1vptHLkSVkMmHcEHA2x5Xt4M8pM/kNraec3E5xZUjIaX+u2LvWedN9axwxXYyFZqgsJj555Hl/IiaqoyZaYYPmeI37MipwcobI1S/dqeM1i0NIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432902; c=relaxed/simple;
	bh=f0wiDzDBtnzmIV3VrgFkm7LanaG35t0eZwVYsqtV5XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOoGr4bX/Nwye+zB+PNv//GVxGH0IQvrc2qwIskpP9cUc0cl9KzR1xlCxt+8LNFOQHZ2nJpOYBd9E3kFXfAaOTwHdsCKFNYjOvPv2wn1F6Aj9W7EMlAFYSIHrzFYpPHLb4FLgkMkY0ABdwE5kBjAzjHtFYRla4aXLNxnmhm38mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n/6TyF+x; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so7289897e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734432899; x=1735037699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHWIkqKFIPrZfDR6fwGCJpX7T0cdK1Nh9XGTjtxdWTw=;
        b=n/6TyF+xrYzl1S3GHjni7IlyxBaredY5xCgSTIzGFQ/V0s0HPtR+woCz5AawV8/1et
         +1RTCPh4n7/g/mZybJM8WTrbGCEyYOYxVSHj+kT9g9E5Pr2jj/zp/hh9sEw9fWsrgi8m
         zRGLkSc4/Gxrg0NtBR+ZL+3Iy5YNryiRooh7pzSOkaDRFjcKK7f9XhyOti1ln15CK2Vw
         OfBICCp745gJqe6A6UAzzJqXI5iymSvNb81IHnJnEd89e6cZno50DjdhxTfRuvzKIzJD
         /6WhT7V/0Mz4MenoEnWMLD39t6NKlmP8TUCdbIhrfAhhRmBo41v17+r1iDsUxV1GduQS
         ujwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432899; x=1735037699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHWIkqKFIPrZfDR6fwGCJpX7T0cdK1Nh9XGTjtxdWTw=;
        b=vmKMtiwS+Kz84a1v1QczzeTnpwjttUZ9TNjhh8ILDp7vqUkV5G7EmvE7nUzidZwi56
         5826ZDwb8z7aB8EJ2DipI9XwKqHmGNnDcWOnPXnfFISIp7Di0vPskYCl3Na/GUireCCd
         0PVq6TLMqBDIQoIPUqdPS2d9gaI0KqITG14nzpKs1PlRW7/LXcB5IVxl2HTTxDE2zOoY
         MmdO3FDcwWtR4XFcMp7hSbPBvSHiCyywGYgkKOas955GFnbcuS5gf5fHX+udkhCjaYXk
         y+YeFDl03lmwJWjVO7mh1I2edtzzDes1SFDMdmwRBNOmvYQm7tRGJlUFRnTn3m49vi1B
         kvTg==
X-Forwarded-Encrypted: i=1; AJvYcCUT/LVTDBA2FybeOe6BFVBdzo4YtihLDvfNTXfpMd5wdFZOPl2ZuBJ2u3Zr73zB6k4v7MmQJtQmIWe7K4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgM4Cyu2m1uadTga0zOWqn2DBL6n/y2mKpEQdaBDK04Ax/kUi
	O6G/ubSdJ71bh4ThzvPvP8Q5Y39S8COPmq1oMSih1v3wL4PQrKWr8LM7gnjOlA8=
X-Gm-Gg: ASbGncu4uvbP1apwh6Zd6lPaJ+J1IoUPU9HvOS4GlfhJQ0P1QPSIw8+T32mOB9o7fw1
	Oe+KudI6dygnP3pgaSR4WM8/EVFBcIxLruppKsLsr8LzA3sZTt2dUj5Gv0F+fd8QyNoYRBVYeOs
	0aduw8Cs2vOVlq1alfe+XMTirKGVJayfKqCXtiBl6rsR87KPi6D5foSxKr4+d6YfTysbXbJWBBD
	iDoRD5o7mVu+5cv32lkE26i5kwNGCg8bQP4N7dPLAiXoi8OPWbBC/vh99D3KG4bScNZTdQVoEPg
	6R3235u+rnHnugDQsjdhufT4H+jWj0MG5Shm
X-Google-Smtp-Source: AGHT+IHIIXGB/X+gwvncRHBdy9tDryU1EfA09rbZDao5aKxh/K7dmzH4R4ChpaOmldxWkT0LNMbwvw==
X-Received: by 2002:a05:6512:2809:b0:53e:362e:ed0 with SMTP id 2adb3069b0e04-540916d7331mr4458490e87.44.1734432899164;
        Tue, 17 Dec 2024 02:54:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c1fb46sm1125836e87.235.2024.12.17.02.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:54:57 -0800 (PST)
Date: Tue, 17 Dec 2024 12:54:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Liu Li <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/9] drm/msm/dpu: Add SM6150 support
Message-ID: <ntffm2jwr44m77z2bvuifv3itkpywco3cemgzkizzdp7e2ekdv@htfktmyyoe3k>
References: <20241210-add-display-support-for-qcs615-platform-v4-0-2d875a67602d@quicinc.com>
 <20241210-add-display-support-for-qcs615-platform-v4-5-2d875a67602d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-add-display-support-for-qcs615-platform-v4-5-2d875a67602d@quicinc.com>

On Tue, Dec 10, 2024 at 02:53:56PM +0800, Fange Zhang wrote:
> From: Li Liu <quic_lliu6@quicinc.com>
> 
> Add definitions for the display hardware used on the Qualcomm SM6150
> platform.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h | 254 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  4 files changed, 257 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..621a2140f675fa28b3a7fcd8573e59b306cd6832
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h

[...]

> +
> +const struct dpu_mdss_cfg dpu_sm6150_cfg = {
> +	.mdss_ver = &sm6150_mdss_ver,
> +	.caps = &sm6150_dpu_caps,
> +	.mdp = &sm6150_mdp,
> +	.ctl_count = ARRAY_SIZE(sm6150_ctl),
> +	.ctl = sm6150_ctl,
> +	.sspp_count = ARRAY_SIZE(sm6150_sspp),
> +	.sspp = sm6150_sspp,
> +	.mixer_count = ARRAY_SIZE(sm6150_lm),
> +	.mixer = sm6150_lm,
> +	.dspp_count = ARRAY_SIZE(sm6150_dspp),
> +	.dspp = sm6150_dspp,
> +	.pingpong_count = ARRAY_SIZE(sm6150_pp),
> +	.pingpong = sm6150_pp,
> +	.intf_count = ARRAY_SIZE(sm6150_intf),
> +	.intf = sm6150_intf,
> +	.vbif_count = ARRAY_SIZE(sdm845_vbif),
> +	.vbif = sdm845_vbif,
> +	.perf = &sm6150_perf_data,

I noticed that the catalog entry doesn't provide writeback configuration
although the vendor DTSi specified that there is WB_2 on this platform.
Please send a followup patch enabling writeback on this platform.

> +};
> +
> +#endif

-- 
With best wishes
Dmitry

