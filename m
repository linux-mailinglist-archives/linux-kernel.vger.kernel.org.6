Return-Path: <linux-kernel+bounces-436347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9759E84B9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C207281636
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2744C145B26;
	Sun,  8 Dec 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6ngVJuG"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B103145B16
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733658172; cv=none; b=M1u784+9w6dQLo9raVQuXhKefkJOL09uhYNZVxtH4GgUjQWQXncWm2OVilgKcVs7GcwkOKKc7xeIuUCC3kBCdFiSiv7Hx0xqVMI0llu4BxqJ8KJkyP8V7wvVY3xoWuTONCiMwHaLgr2HPY5iObOnkCHSwqp0BFR1rrMvZhaJzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733658172; c=relaxed/simple;
	bh=Vum42yeG4ePMwdSEBQgMnC472dCjq1yuN/izXZemDW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaO9fwi2L36V/dEn3sD+g9kvYTeZlPoHP9pKxJGGb1/npiRW7P6JJROEJASpiU+KCjOiUQUmeTDsxgyhm2v97EP86HdVm+Dv2KqfV7szGZoqInRibDnMV/sPQFbsLDfvBWgDpRAi6k//47aw0Uj0lGELcqVEJDt+3gtYWsFb8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z6ngVJuG; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso42326271fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 03:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733658169; x=1734262969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqdm0M9gFPaLS3SS+kPxyU+HG5ijsXwtikH0q0stVKg=;
        b=Z6ngVJuGncQNsmnRBoDl2RepLilyeUyXCeQ5hN8Q+HnMcsfO82jIb1Hdorupe3AqDd
         qBd2InhytD3WaSc7IYdbFXzQfePG8VmFlR0/l6hfo1pFdv+2rkKrMnhMzIW0RYrMjFw5
         82a9X7y4g+It739yKBxauIVD72mk2hKlrCMA9hdAQw3uFzNzPKPyWRzhB4ZhR/kOXaY1
         6FhsIOTiK70SePquDkuu3zHF/X2pnmjRAgS0f1CH4LCE7f19VSPyMVgSjTFqj0gl1Fzp
         IsXkq36RmVKEiYsZE2Oo1R5kZO57KPsN/96S2njzVy0wFzcR13q0mrRy544b9OJL8Ydy
         kdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733658169; x=1734262969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqdm0M9gFPaLS3SS+kPxyU+HG5ijsXwtikH0q0stVKg=;
        b=h2cqOzM6oe/xdK9BkIkyRPcN//SV6+hTOHPGFPjrgHkRfmdlKnXJyE7Zw1J5yxIk8o
         UfqlBrZEsno5HjYGrjtKJVrutqOfh3QlNSqcqt+4G2moIMrHVUZPBJMyISpRUd77/GxR
         EMhMC821UrI17r3rrTqb0iczDEMyTshd+YdcMm40iJJVJM8RBZ1FoIwFWLaJPMr1VTub
         o+5rKadcRuI2FRLm5nGfZeqS2Ec3zCaRogWVXFCZWIF/CQutgFbT/ABfk5/5qRzuMLQp
         Tf5Mi27V3g04gSKkdnPZchhM48ahvvq2NHZH+Bh6F/bhGhuUP+jGDiJRiOkrUcAg0I9v
         aZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwmXLAq7qRxRoTb4Yqf6UPREKP6wbR6qyOC89k1fh2m94xdi+4lYY712JmQ3NugaHr704kbgr3mihrI6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMFcI/D/pqE5NgmhjpGEHfVyNo+V3R0HeLmoRx+HuJ9l9A//R
	IDQfAjtEPQAdbrH9R6GGWUT7yiDDZGe7Ams81bNoEuBBw8IKOYk58EwmSsUsv/4=
X-Gm-Gg: ASbGncvfUqtK+D+Bi1YI4hWVKj8BpJZNAFtSHGWhe1NefxBRf1czbmfvf5O2eBo+8iQ
	JtctuTWDoJithuPixEFjoMAtmZqYWvwXefsoYYHchgNMfGpzLZavXrhEBzk30R/tHTV5pE9T+BZ
	CUVpuVAtfLnc+G25ahU4qbUyM43bD3dwOxN57M0y7l7WSGtgbOEgzzQnzSl21bezreImdiNy13g
	uFeP5R1/dxnnkpNIavWXew3ujuVMYez27b1YmNYz6oNYjWE310uZ+iJd8Bj9Y8LArqoCViTW1rz
	rEa/I6hsVHz0GZps0oi8z2pymBKthA==
X-Google-Smtp-Source: AGHT+IH8v5VqGhc3V23ZRaSeetM6jF9bsN4HcuZe4bb0441mma81kPswSik1ZjOvPZIUevWiRzkUZA==
X-Received: by 2002:a05:6512:3b98:b0:53e:16ed:eac2 with SMTP id 2adb3069b0e04-53e2c2efc44mr4026683e87.54.1733658168789;
        Sun, 08 Dec 2024 03:42:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53eaa3bd421sm427671e87.97.2024.12.08.03.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:42:47 -0800 (PST)
Date: Sun, 8 Dec 2024 13:42:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 19/45] drm/msm/dp: add support to program mst support in
 mainlink
Message-ID: <kdkbyhljc7dkvbmcrk6jhbtdybx3g5aca3uysw4l2qf4bf34uo@ty6jrhcruo5m>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-19-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-19-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:50PM -0800, Abhinav Kumar wrote:
> Add support to program the MST enabled bit in the mainlink
> control when a mst session is active and disabled.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 17 +++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_catalog.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    |  4 ++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index 88d6262a972ef2d30c467ef5ff5c58ef3299ae7d..bdc66e5cab640c351708ba1a1bc3bca21784df6e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -417,6 +417,23 @@ void msm_dp_catalog_ctrl_psr_mainlink_enable(struct msm_dp_catalog *msm_dp_catal
>  	msm_dp_write_link(catalog, REG_DP_MAINLINK_CTRL, val);
>  }
>  
> +void msm_dp_catalog_mst_config(struct msm_dp_catalog *msm_dp_catalog, bool enable)

Can this be merged into msm_dp_catalog_ctrl_mainlink_ctrl() ? Or is that
function called too early, when we do not know yet if we need MST or
not?

> +{
> +	struct msm_dp_catalog_private *catalog = container_of(msm_dp_catalog,
> +							      struct msm_dp_catalog_private,
> +							      msm_dp_catalog);
> +
> +	u32 mainlink_ctrl;
> +
> +	mainlink_ctrl = msm_dp_read_link(catalog, REG_DP_MAINLINK_CTRL);
> +	if (enable)
> +		mainlink_ctrl |= (0x04000100);
> +	else
> +		mainlink_ctrl &= ~(0x04000100);

#define

> +
> +	msm_dp_write_link(catalog, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
> +}
> +
>  void msm_dp_catalog_ctrl_mainlink_ctrl(struct msm_dp_catalog *msm_dp_catalog,
>  						bool enable)
>  {
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
> index c91c52d40209b8bcb63db9c0256f6ef721dace8a..07284f484e2861aeae12b115cd05a94afed1c9cb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.h
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
> @@ -138,5 +138,6 @@ void msm_dp_catalog_audio_sfe_level(struct msm_dp_catalog *catalog, u32 safe_to_
>  /* DP MST APIs */
>  void msm_dp_catalog_trigger_act(struct msm_dp_catalog *dp_catalog);
>  bool msm_dp_catalog_read_act_complete_sts(struct msm_dp_catalog *dp_catalog);
> +void msm_dp_catalog_mst_config(struct msm_dp_catalog *dp_catalog, bool enable);
>  
>  #endif /* _DP_CATALOG_H_ */
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 2bfe2aac3c02b02b12713dbd98e79ed4a75b85d0..3839f1e8e1aeb2a14a7f59c546693141a0df6323 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -186,6 +186,9 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
>  	msm_dp_catalog_ctrl_lane_mapping(ctrl->catalog);
>  	msm_dp_catalog_setup_peripheral_flush(ctrl->catalog);
>  
> +	if (ctrl->mst_active)
> +		msm_dp_catalog_mst_config(ctrl->catalog, true);
> +
>  	msm_dp_ctrl_config_ctrl(ctrl, msm_dp_panel);
>  
>  	tb = msm_dp_link_get_test_bits_depth(ctrl->link,
> @@ -2132,6 +2135,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  	phy = ctrl->phy;
>  
>  	msm_dp_catalog_ctrl_mainlink_ctrl(ctrl->catalog, false);
> +	msm_dp_catalog_mst_config(ctrl->catalog, false);
>  
>  	ctrl->mst_active = false;
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

