Return-Path: <linux-kernel+bounces-532046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114AA44826
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F888680DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830BF198A29;
	Tue, 25 Feb 2025 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4dd+xUz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441E14A60A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503897; cv=none; b=p5Y2KQCvfwfOcMBhh6H74pDvyGLyODWTFZliw7U+4HDaWUiwT/jjbhZ5LbA4/ihu7rPEoCnlPA3KCOzYa2AL3o9syNVnncKCVH0QcnU6+uS/k24EeUxsb8bIzqCJrKA0OsHEYTdalpxxFyjnDugMQykMDp4wML1FHlJsjugyIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503897; c=relaxed/simple;
	bh=fegxD61N6B8hGlbYe8Jr/TcJ0cHmgZSa0wxqbTbnR+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA6s+ytdyUWs9RW/FywjvpyLxlKF1g0oSY8HhibGfrWecjlsQSBnJOlUpdXYFWLlwa4cnyDBVfZcbe7H8IsOL1egXFUpBpbuhgO72FhrRQPb5KQGGul4JwNkRghPzt4AlTL2G8i58hcejXf4qEXHCvViLaedcaw92shm99UC7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K4dd+xUz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-548409cd2a8so4151524e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740503894; x=1741108694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBMGUOCl55gdKoV7vW8XIwXzlyBYkDGukZo5cGFH5CU=;
        b=K4dd+xUzSiv2YuKc/yP1Gy16kZHMbr3DX7nqRtdAEnJJlDuf1s1JPwGsgO2LBSJI99
         HJL8EcX0TUWr8yIHFwTcNzMK3R7a5hrHNvmPILGSDw13aoVoypRCGnPviLNV15thfpd9
         v/UnDXIuwhspX5k+r+gNKKU4VfNM5j0CibKBYqxx5Xq4ysIDblW39upKRrQDRpk5yKnm
         4VWD97w6kZEyjledbQnm2vHjak/nzweN8qlaCkwm2Xb9p+mfgBd/vFq7f8gP0aXj7OAu
         R+VK5ids4diMRIlPvBWdvrw6ZZPyQbQosLNFXiYIQpyJF5vLj7gdfmmZLfgMEcZUd4by
         ab8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503894; x=1741108694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBMGUOCl55gdKoV7vW8XIwXzlyBYkDGukZo5cGFH5CU=;
        b=jWpJjl5FamHXYUuhN8GrNYCVM+sAwWP5y1KOkMORF6N9xN8TcUiEU/j67uUOhXwhFL
         +w9zud6mPvQ/CWLHcPFRbxbxOdVkJgj6tDyiMuAcZwJrAnmNafHc3JHtc24m9b30lDdu
         oiATcK52EM5KMfAsXo3Ofr+ouZayE77+LCFy4sWQZAtQ5VoPISiRx3j8HjQVMGnUUnOQ
         OlLY6sQItAorbpUXdzfMGrWDtVP1wqSv0T1SZkeC8fKuGicG9iO8WAIIgxc69oi2l00g
         MOp2vSjFBQ+hsHDfgCcgEVc81Lb3CpGS3kzIO+Zhg0i4KnkOMcZUkq2myr6YzRR/DoZC
         Qm3w==
X-Forwarded-Encrypted: i=1; AJvYcCUMMJ8ifh88lr9d6/Qd6tn1LILUqy1iYcFquP8EUkWcl4D89yNr1RBdfoDWAhvAH8iCE8oWqABPE1vVcWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6CPcbkBseO6538UE6D2KmKu4eyg1dafwCnIcyAIp0cgCVVhP7
	oZVW4MKqagBPxllc1GVRaEZ5VTYUVRURpKF1yuzZYNZoZgrnzja+vv9sU9RmOds=
X-Gm-Gg: ASbGncseMbrIJJkI7PZXBZ6hVChW/foUFfBlTXjzAL1pT4klC9yNeoR4xNXg3q+dyQ6
	97P2wnIjjbJh8/TGm6r1wQCHDgwQNZz+xPLXZfth0Zad0Voagn4Q+p+KPo2j8RVn+CwHDLbHy6r
	X2LCaQjw7FJrm4kKReD2g52v3Mkf+ptT16HRutGUI0Y2yMJWGZYo2oabsZuucI7WjCWN527A/3n
	1YGI1H9XJARpwucHLif1j50TX+KW0a4eE+3lld61CnCEo4BBN8tlLEK2KNGrOA08+j3spKPR/PS
	ze6ThOtdCsEmlDS2x5z/txBPFAYC30CjCEUEaOvSdMbn9V2uyHbslf2nH/oX3Hs7lhn7CXWyuDM
	RIv0uFQ==
X-Google-Smtp-Source: AGHT+IHP/HVI8920DHkWUudbL09CGIMVh2mmFw18ADlkjqgydR5LKcjUPGttxXMqHgdd2UEVYmuwRQ==
X-Received: by 2002:a05:6512:3f28:b0:545:b49:f96d with SMTP id 2adb3069b0e04-548510712admr2315191e87.0.1740503893983;
        Tue, 25 Feb 2025 09:18:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b261esm229975e87.24.2025.02.25.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:18:13 -0800 (PST)
Date: Tue, 25 Feb 2025 19:18:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robdclark@gmail.com, sean@poorly.run, marijn.suijten@somainline.org, 
	andersson@kernel.org, robh@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	konradybcio@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, quic_abhinavk@quicinc.com, 
	quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com, quic_jesszhan@quicinc.com
Subject: Re: [PATCH 05/11] drm/msm/dsi: add DSI support for SA8775P
Message-ID: <hl352hhpv6imtilpw554njkpod4nycjlls4gg75barlugc2e42@okw2snj2bqm3>
References: <20250225121824.3869719-1-quic_amakhija@quicinc.com>
 <20250225121824.3869719-6-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225121824.3869719-6-quic_amakhija@quicinc.com>

On Tue, Feb 25, 2025 at 05:48:18PM +0530, Ayushi Makhija wrote:
> Add DSI Controller v2.5.1 support for SA8775P SoC.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 7754dcec33d0..71881d9370af 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -221,6 +221,22 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
>  	},
>  };
>  
> +static const struct regulator_bulk_data sa8775p_dsi_regulators[] = {
> +	{ .supply = "vdda", .init_load_uA = 30100 },    /* 1.2 V */
> +	{ .supply = "refgen" },
> +};

sc7280 has 8350 uA here. I'd say, having those two next to each other is
suspicious. Could you please doublecheck it?

LGTM otherwise

> +
> +static const struct msm_dsi_config sa8775p_dsi_cfg = {
> +	.io_offset = DSI_6G_REG_SHIFT,
> +	.regulator_data = sa8775p_dsi_regulators,
> +	.num_regulators = ARRAY_SIZE(sa8775p_dsi_regulators),
> +	.bus_clk_names = dsi_v2_4_clk_names,
> +	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
> +	.io_start = {
> +		{ 0xae94000, 0xae96000 },
> +	},
> +};
> +
>  static const struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
>  	.link_clk_set_rate = dsi_link_clk_set_rate_v2,
>  	.link_clk_enable = dsi_link_clk_enable_v2,
> @@ -294,6 +310,8 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
>  		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_5_0,
>  		&sc7280_dsi_cfg, &msm_dsi_6g_v2_host_ops},
> +	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_5_1,
> +		&sa8775p_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_6_0,
>  		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_7_0,
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> index 120cb65164c1..65b0705fac0e 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> @@ -27,6 +27,7 @@
>  #define MSM_DSI_6G_VER_MINOR_V2_4_0	0x20040000
>  #define MSM_DSI_6G_VER_MINOR_V2_4_1	0x20040001
>  #define MSM_DSI_6G_VER_MINOR_V2_5_0	0x20050000
> +#define MSM_DSI_6G_VER_MINOR_V2_5_1	0x20050001
>  #define MSM_DSI_6G_VER_MINOR_V2_6_0	0x20060000
>  #define MSM_DSI_6G_VER_MINOR_V2_7_0	0x20070000
>  #define MSM_DSI_6G_VER_MINOR_V2_8_0	0x20080000
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

