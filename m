Return-Path: <linux-kernel+bounces-552251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118D3A57792
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031B33B3FD7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95F7101FF;
	Sat,  8 Mar 2025 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6VzCJCm"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4617BA6
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741399223; cv=none; b=Qazmj0PUUNm3OlBxPZ2oe02Ece4NY+vh1V4P+qHXVtzCkfTCimOVwl/UTzj7pOH5O/4wasX1xhyneDjNyDDBLJvT6jPEOq8APaXPbptf5+YPjnx9gQ6YoBNwfR6lrV6l/BWeeLZPO1C+WjkWiaYFeGO3jyhOebODmvvPuTTYdhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741399223; c=relaxed/simple;
	bh=S8N+QxxiOhUsGd3S0a1x+yo4CeNlEdKYrscPJ0aeCTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9XZDXpdAtUI6X/FwcFOH0bqQYcsUMzKwNtO8k8hZkwOmekfd001Qx6o3tbKYIoC+VNaqieLN8MqnsfA74K46ADMuFuUWkiWM/1+S6JPswbjVCcRi5C6FpITyhcdAv81a1RLUwQgABwADwtESewtn0ISkv8kR8ZmfJONBTbFwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h6VzCJCm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so2574371e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 18:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741399219; x=1742004019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjVkCifx/RSQQ8Da117ebd6rVOl6XM9uzHnpVWsZ5zs=;
        b=h6VzCJCmdxyZxXwCyL0qCG5jl6lsPzVqvjjUESWqf8k9TpVGTdbT0KtGgdlk9tcn1K
         dIpEryQUif8dUjd0ZyNt+aCa9Bq0BzJTbUa+JO8Rk5hQwVXk+0xxyTj5eVZ87Gx06CEZ
         Wa4pJRXNNbnUEsrGg7/WBFpIIvDCCtjNvyDZmDSKmoklxiXddNbX7sbQTbK6Ars57HtC
         ZlUFvf3wO3qeVak7gCJqtNEq1mMzr+TUcHU79IvxxPrCbLjg4pF4IzgqTQu1ryXzx4aV
         guF2lb9G+4oeiX5c6yKdXwgYLq78CSmUzgpQVZoDZKGMcmyvQTIlbjIpTF8g+B42QRF+
         HUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741399219; x=1742004019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjVkCifx/RSQQ8Da117ebd6rVOl6XM9uzHnpVWsZ5zs=;
        b=jON+nypoEmv/PEOSmc68oz3Ws9ugpAG/M+QHOKHPOFZH6Xk3dwNKnj29geGoFid0ZS
         S1ndKD9Loor4d/qz1nzepokFrVh74Vbsf7JseJtOiLZxgasoZbIjJgZB8XTm45o17lro
         yGDEw2Y2CP7xphkH5ICheXcjTQKPSu50UzpJlmVP4qO0MtSchEWm+/n7zNcQgLstuVp5
         TiKuQad5WlMGykMiMlX+ci/ef8qhi9rJXFndLNmqCqXuC/Hs5k6Blf+3WAVCEIcEDIU5
         6X4yNefy2UEKyJAFRAPsf0iPdY8+V6bjJA34MReavKi93YAZqUdn19+Qosr1KZQyVuOv
         OtBw==
X-Forwarded-Encrypted: i=1; AJvYcCW3NvWmPxt8ZnW+/xdJ7n3kS1awb9tx3Ox3QcG9K4koCPg1bhIzMWCCD3x9oDMjVfV5LzjhaF1g38VWmQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHbMZ5AG6uDKApUBQ7qUGkO39h9yemnwhIh5aK/YIVcU3vxIC
	v9RH6Dlb87T6s6+E5B/pOWM45VUl8ShMcFC17A1xmATKGnPfkMavwcXMo+pMV3s=
X-Gm-Gg: ASbGnctVI8cn2fSXi17YHUT6v0ehL8NXUa/UP4HuDlT+R25ybowF0zClR8ijFOLQB2z
	z7zxkT4RKRgR6xzEG6aIT7i7SCrYcx85HViI6NzOC/ekHYar2uAf3/b/Y7IhZifGZRPrDvwQ2Mc
	a08EaUPCrh9mnxIqMbTPlOXaGxARTzQsRNtlzjK3BndNeRCraLqPzbfhrbwqIaD7fs3M4PZYfQx
	jx2un4PdD+xgaLubVd8VKhIaAADJoByPYYLzErIKHKCKYtCCUQFI+tq/W4Iag3h0rwySGqeab7y
	+WaBGbxlz1v3aJpxlbcOrpNLdiru5X0LKYnuG/LYOo3MmymPf/NC8i1yO5jvl6GM0amY2x0lB+x
	T4gHope5o3kQFRvJW3DEOCra2
X-Google-Smtp-Source: AGHT+IHD+uwBqwVOK6PF+JlAvIXYtVL34Ab2L2yfhLPX2xkxj8BVZbxw9BTY9Ei5g5385gK2RsIBIw==
X-Received: by 2002:a05:6512:3dab:b0:549:8ed4:fb46 with SMTP id 2adb3069b0e04-54990e676f0mr1813977e87.26.1741399219383;
        Fri, 07 Mar 2025 18:00:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c33bfsm680563e87.236.2025.03.07.18.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 18:00:18 -0800 (PST)
Date: Sat, 8 Mar 2025 04:00:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Jonathan Marek <jonathan@marek.ca>, 
	Bjorn Andersson <andersson@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/10] drm/msm/mdss: add SAR2130P device configuration
Message-ID: <kifzy754m7zygspknsk4a4aeuqxkt4bkyp5jbu6ul43gon7je3@yleqikfmh4lp>
References: <20250308-sar2130p-display-v1-0-1d4c30f43822@linaro.org>
 <20250308-sar2130p-display-v1-6-1d4c30f43822@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308-sar2130p-display-v1-6-1d4c30f43822@linaro.org>

On Sat, Mar 08, 2025 at 03:42:24AM +0200, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Add compatible and device configuration for the Qualcomm SAR2130P
> platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index dcb49fd30402b80edd2cb5971f95a78eaad6081f..3e82ba0885d03107d54eab9569bb4c5395454c7a 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -592,6 +592,16 @@ static const struct msm_mdss_data sa8775p_data = {
>  	.reg_bus_bw = 74000,
>  };
>  
> +static const struct msm_mdss_data sar2130p_data = {
> +	.ubwc_enc_version = UBWC_3_0, /* 4.0.2 in hw */
> +	.ubwc_dec_version = UBWC_4_3,
> +	.ubwc_swizzle = 6,
> +	.ubwc_static = 1,

This should have been .ubwc_bank_spread = true.
I have been rebasing the series from the earlier kernel and I'm not sure
why this didn't show up during the build phase.

> +	.highest_bank_bit = 0,
> +	.macrotile_mode = 1,
> +	.reg_bus_bw = 74000,
> +};
> +
>  static const struct msm_mdss_data sc7180_data = {
>  	.ubwc_enc_version = UBWC_2_0,
>  	.ubwc_dec_version = UBWC_2_0,
> @@ -738,6 +748,7 @@ static const struct of_device_id mdss_dt_match[] = {
>  	{ .compatible = "qcom,msm8998-mdss", .data = &msm8998_data },
>  	{ .compatible = "qcom,qcm2290-mdss", .data = &qcm2290_data },
>  	{ .compatible = "qcom,sa8775p-mdss", .data = &sa8775p_data },
> +	{ .compatible = "qcom,sar2130p-mdss", .data = &sar2130p_data },
>  	{ .compatible = "qcom,sdm670-mdss", .data = &sdm670_data },
>  	{ .compatible = "qcom,sdm845-mdss", .data = &sdm845_data },
>  	{ .compatible = "qcom,sc7180-mdss", .data = &sc7180_data },
> 
> -- 
> 2.39.5
> 

-- 
With best wishes
Dmitry

