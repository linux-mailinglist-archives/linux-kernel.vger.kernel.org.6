Return-Path: <linux-kernel+bounces-425888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7A9DEC40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E30163763
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4571A0BD1;
	Fri, 29 Nov 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjoxUx7v"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F71A0724
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732906506; cv=none; b=Ibyk2NkS0isCZukbaOHUBe6MyW0mF2cylT2uHPak8h5Wp3qiVgN+39LD2RjQJLcVNXFDMrr9dMmHlSit1MK/v1KNuVWIqjF2wU9fgK9+4oUm/0++wkjo34wvn5V4gSMKyy2oAstWZNWB+37kRDVcsu/pOtS5ENDrccsDjCtaX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732906506; c=relaxed/simple;
	bh=E7RMchv4y+AntKAlNoeAS7PUC1xG4c0PvSI9uNkW/VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfYEvM5eZ3S60XHmg0a6sBrox5C2H67ZJf78NJh+E4eg40MLN97KBb/wyXOQHcrcpa0o31Tn4C9dGLtEzcoHhAFLyIDylteWPzegFJs9DZnch9gF+sHjOx+XG6jgzMuB1Gi6sBpX/0qL4oJhJIT6KYVlxsZ4g79JmL1VA93bBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TjoxUx7v; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53dde5262fdso2551849e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732906503; x=1733511303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVpqKF5HDzWaD9sXJQFFkWoO/IvzFlRLrdhxrF/ucgg=;
        b=TjoxUx7vdGZuQaZGe2A78MiChrQocNyS1t5jOTf+7efCA/VNSQJVBnQYDv9HiSy7No
         2LDsU+hlcGDuFx/lnveWQ+v223wrt7+q/WqJkafXhL4Rx9mNo7MuEdM6hZrPH7bysNvr
         CqOlQt94xSHuL1D38tYHgkxwqPCl7kQUlA+uWSbh6tjr7amQGRc4/7tdyRVerCVIIY8T
         +/ZmkcjivmeiGhoWaSE38cweH2KBLDJp7rgFtk8V9v749KWym6/aXWpq2DgbKb+GsWUi
         J0mUT3r7f3j0vDuOSwdZRbRmRBLjgiAR8AlZb/RFriFP8UmKp4VY+f+eM+gg7aB2ct89
         Y8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732906503; x=1733511303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVpqKF5HDzWaD9sXJQFFkWoO/IvzFlRLrdhxrF/ucgg=;
        b=tvQqD/SOGz8qkFQgI0gYlXKVLX3QFLVQ/0oXv6ZZlzncFo/uQNkvhWkiOeKGQVx8Z0
         xClDjYhbV13WpXPV8AHPQl0oY3e4h2oM7LhWQb/Igw9+xMg56Atcrvdshms3b8q8Lspc
         ocoFmb0ED/bRuCZJ+teT27pwNCGqYbSy8ozipx/6v6CnC3xaUFNIliiNuqPdJ0bW5BEA
         8bUDsOHUypxh8Lzh8QNF+kW2tt05f9tRltYWVtw5NIeSyaZMTcm6tY+S0BNpeG49rWbY
         IHTAfAXv105h1PYxuKjFt6mvqwsBMdwmz5CwDyATZJWD9u3Uht/wKZwYdYr3mIvCsmpv
         tQhw==
X-Forwarded-Encrypted: i=1; AJvYcCWwIH9lSXiuqXjxwz7AKfffKMNWcODrbRZGvenCIYb7kYokC819gT3HNxL3iRPGFiWR/D8VWy1C3+fPPJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/wC1ArgyfXOb4sY/LoqVnu4CBxt0x0w3CIcnuS53jNAe83rvJ
	3A8LBgJP+2apWwIw2RDEgfS6kX8XXih26GadzKs2xnG7N6RnyP8mz6ODM0Uaxak=
X-Gm-Gg: ASbGncsYAm03H5imL0eNifZ7zDKj6c4VduUwkghenkcuiI5aE3AIJDv44tVVZ+W6qQJ
	Gd48beLlMM+/0chuHKGCNfELfCLcEa9HbNPfJC4DJ5pIVXtKkvjfB+wbXBZztTWW7H9IyicQ9ih
	4lP4In/faBPbzRzzuEFZqz4neIc37hk/raD3kdye7FSlxj+VID/NIrRhkhCxAe3dbPNz+Hg4xg5
	KvwVl2TKXLHwv7/IXmQvZUcaykRC+ciJ9TbKtmyrjhGSGf8Cwv1GuB6tptSCORB2uqZW8GAnGpi
	itzwRw1901A7BB9mHpT2uyF0gBN+jg==
X-Google-Smtp-Source: AGHT+IHl0rMozF8fyncgtwJnZuDNJR8Pa97HnX5NDJ1ulE+L6RXtTTJfzmFUESI9fNeMlRvrFf1Ojw==
X-Received: by 2002:a05:6512:400f:b0:53d:a93c:649e with SMTP id 2adb3069b0e04-53df0109024mr9144690e87.35.1732906503152;
        Fri, 29 Nov 2024 10:55:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6496a43sm552760e87.213.2024.11.29.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:55:01 -0800 (PST)
Date: Fri, 29 Nov 2024 20:55:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Ritesh Kumar <quic_riteshk@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/msm: mdss: Add QCS8300 support
Message-ID: <wbw7ftf7ogcylxbeav3vegyfgz32sc2h5plneo2w7djsy2kaeo@enkcbukosern>
References: <20241127-mdss_qcs8300-v1-0-29b2c3ee95b8@quicinc.com>
 <20241127-mdss_qcs8300-v1-3-29b2c3ee95b8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127-mdss_qcs8300-v1-3-29b2c3ee95b8@quicinc.com>

On Wed, Nov 27, 2024 at 03:05:03PM +0800, Yongxing Mou wrote:
> Add Mobile Display Subsystem (MDSS) support for the QCS8300 platform.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Once rebased on top of [1]:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[1] https://lore.kernel.org/dri-devel/20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org/

> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index b7bd899ead44bf86998e7295bccb31a334fa6811..90d8fe469d3134ec73f386153509ac257d75930a 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -568,6 +568,16 @@ static const struct msm_mdss_data qcm2290_data = {
>  	.reg_bus_bw = 76800,
>  };
>  
> +static const struct msm_mdss_data qcs8300_data = {
> +	.ubwc_enc_version = UBWC_4_0,
> +	.ubwc_dec_version = UBWC_4_0,
> +	.ubwc_swizzle = 6,
> +	.ubwc_static = 1,
> +	.highest_bank_bit = 3,
> +	.macrotile_mode = 1,
> +	.reg_bus_bw = 74000,
> +};
> +
>  static const struct msm_mdss_data sa8775p_data = {
>  	.ubwc_enc_version = UBWC_4_0,
>  	.ubwc_dec_version = UBWC_4_0,
> @@ -715,6 +725,7 @@ static const struct of_device_id mdss_dt_match[] = {
>  	{ .compatible = "qcom,mdss" },
>  	{ .compatible = "qcom,msm8998-mdss", .data = &msm8998_data },
>  	{ .compatible = "qcom,qcm2290-mdss", .data = &qcm2290_data },
> +	{ .compatible = "qcom,qcs8300-mdss", .data = &qcs8300_data },
>  	{ .compatible = "qcom,sa8775p-mdss", .data = &sa8775p_data },
>  	{ .compatible = "qcom,sdm670-mdss", .data = &sdm670_data },
>  	{ .compatible = "qcom,sdm845-mdss", .data = &sdm845_data },
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

