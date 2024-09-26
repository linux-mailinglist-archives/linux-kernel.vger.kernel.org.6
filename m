Return-Path: <linux-kernel+bounces-340491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F5A987417
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA00287D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFF736B0D;
	Thu, 26 Sep 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKXGbPTz"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48A364D6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355744; cv=none; b=uw6SZuKgbJPcui5ma/sChqun1PkHXIfEmzg3o2wQS5EXTS1D0cvugLoWc1Ut2TpYXTJzn6jFIv3Nis2BM/VYGpoWx2fqFf837RvS6SUJtK2SGBjUBoLs1D9jERAjfDoE4WF29FSOC76OH/JyNyD2YjCbIPSB67uEJ+aD3WXX6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355744; c=relaxed/simple;
	bh=Yw2gERMntAsAFddVzmQJOo5KLhmlfIFpjS86moCqkYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgZAVhx3xa3uy7lkVvIpsmol6im+brPkc79deOxt2s4UEtq2KAiebkkncCOwR4ov/gf/1c9eVHm7aWyiyxyacTfR8I7IZGZXMpkGUjNGRjhMrV6jxp4KjUsBj0KbNVY8O1GJNxZL6/Pup51pNXuD1yQLZJpboXD1fB6qt8cwhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKXGbPTz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365392cfafso1032009e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727355741; x=1727960541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FjrjrRM9XPvHYxyCvf9B1RVZyMTuwJYX+MU9Coc6xcE=;
        b=kKXGbPTz+aRwCKE6glKY09lJ/NgbPcVGmpIH+dfvnqHMcxUpLzX2EduoDRHsmLQYvY
         X/KQq4uu9SICpn9+cAadGM68gKdfiJPCtP1ljDODn0lQWeIt8qAl4YmB4rkzgM7BgI4h
         ovMtzuksh3bukiKma1lgHv1lcsrldJpb8/JUwYxLhVFWKriXXqGArcjWowdpKMjx0pmd
         RZMT8pBZur4bNpPEu7fxnb77M2BNvUt3bT/dJ7OvaeOwKvg77i5iWvHWOeQe3eLtxtQ3
         iFOuCmygs1DM4BWrzkLRsp31tPcBtCGOC3uQuLseBJlFTnJkccoT9JeOZKnYUvUC4njW
         D+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727355741; x=1727960541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjrjrRM9XPvHYxyCvf9B1RVZyMTuwJYX+MU9Coc6xcE=;
        b=iBNf8AwKK2AdN2rkn8ert+2XHHT3kzXvgo73hIICTSPdiDumaTc8F3deT+aZdefUvt
         n2zzVoHPNeJ1VzQpZU+k0vy0KYZKVUB0rLpTk+qeKj32wgWJNUP3xqtkyy97/EMlRTl8
         RB3l7sU2HAVyffaeLhWvsS0Yr3SeO4xy/uO5qF4nVOobRqCEcHw7StrDPbvCMeTqQ1IP
         AiwrYOQYmtMrHL9pTe1SU+Nl/aSKPpc5aKfqxTuTjWMzRCXve4+UzzgQQEewKjMFixuh
         oFOb083SUvsbi6UtRA0V8oNoyijMsNlyQ7ey5bB5FwYFOLpQaxpdHKiJvEH8Yq3JHYqE
         /sMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrLLPh6u8pT9U5lXGFar1oeXGmXklgKNUllUHeb0WLuZ5g9PM0YXs75hMhiTAyXtHnm6Gy2v5+twi2Pi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTk0CdyTwiM+rkCWp6RKPl2dZezoJKDt9rkPIJTikuRjwoqTeS
	uJtHdqh8Z+z4WS4dWePGtHemNo6ThNY1+RV58hCLJx6ppedIJb9cM0ePvdlLTuQ=
X-Google-Smtp-Source: AGHT+IH2/C/vn/3guz1GtFMt/oWgqT239gTYMR64SJn79sphprz6qemJfk5SXKxHE0ZI+qaue6j10Q==
X-Received: by 2002:a05:6512:31cd:b0:536:a695:9429 with SMTP id 2adb3069b0e04-5387048a724mr3919631e87.10.1727355740345;
        Thu, 26 Sep 2024 06:02:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e582esm795886e87.63.2024.09.26.06.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:02:17 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:02:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mahadevan <quic_mahap@quicinc.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, swboyd@chromium.org, 
	konrad.dybcio@linaro.org, danila@jiaxyga.com, bigfoot@classfun.cn, 
	neil.armstrong@linaro.org, mailingradian@gmail.com, quic_jesszhan@quicinc.com, 
	andersson@kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_kalyant@quicinc.com, quic_jmadiset@quicinc.com, quic_vpolimer@quicinc.com
Subject: Re: [PATCH v2 3/5] drm/msm: mdss: Add SA8775P support
Message-ID: <35e6yleiy6wkja3ojlfjddifxv7kr7x6tyn5pszas2chouuvql@trpeb7b4eop2>
References: <20240926110137.2200158-1-quic_mahap@quicinc.com>
 <20240926110137.2200158-4-quic_mahap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926110137.2200158-4-quic_mahap@quicinc.com>

On Thu, Sep 26, 2024 at 04:31:35PM GMT, Mahadevan wrote:
> Add Mobile Display Subsystem (MDSS) support for the SA8775P platform.
> 
> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>
> ---
> 
> [v2]
> - Update commit message. [Dmitry]
> - Reorder compatible string of MDSS based on alphabetical order. [Dmitry]
> - add reg_bus_bw in msm_mdss_data. [Dmitry]
> 
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index faa88fd6eb4d..8f1d42a43bd0 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -573,6 +573,16 @@ static const struct msm_mdss_data qcm2290_data = {
>  	.reg_bus_bw = 76800,
>  };
>  
> +static const struct msm_mdss_data sa8775p_data = {
> +	.ubwc_enc_version = UBWC_4_0,
> +	.ubwc_dec_version = UBWC_4_0,

Just 4.0 or 4.3?

> +	.ubwc_swizzle = 4,
> +	.ubwc_static = 1,
> +	.highest_bank_bit = 0,
> +	.macrotile_mode = 1,
> +	.reg_bus_bw = 74000,
> +};
> +
>  static const struct msm_mdss_data sc7180_data = {
>  	.ubwc_enc_version = UBWC_2_0,
>  	.ubwc_dec_version = UBWC_2_0,
> @@ -710,6 +720,7 @@ static const struct of_device_id mdss_dt_match[] = {
>  	{ .compatible = "qcom,mdss" },
>  	{ .compatible = "qcom,msm8998-mdss", .data = &msm8998_data },
>  	{ .compatible = "qcom,qcm2290-mdss", .data = &qcm2290_data },
> +	{ .compatible = "qcom,sa8775p-mdss", .data = &sa8775p_data },
>  	{ .compatible = "qcom,sdm670-mdss", .data = &sdm670_data },
>  	{ .compatible = "qcom,sdm845-mdss", .data = &sdm845_data },
>  	{ .compatible = "qcom,sc7180-mdss", .data = &sc7180_data },
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

