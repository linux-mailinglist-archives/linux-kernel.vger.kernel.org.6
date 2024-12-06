Return-Path: <linux-kernel+bounces-434702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D79E69F0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3F61688E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103D81DED74;
	Fri,  6 Dec 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZ1wBGo5"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB31DC74A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476850; cv=none; b=Yy/XhurGR1GiJwDtj8wC81Di8v1Azc4v7zd9QlmHBM35HGqlx/HR9ZIccefvrO4LqDbGavQnznAtDreJ8ueenDIXJ6CsowkH+PhMrOs3m+T6rqJ6JrIRyQLiDmR/XtDT3d3ByGPWAlbI/v7G+74+XjGkrzLBrlPpMoQAGtM5Z00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476850; c=relaxed/simple;
	bh=TtuKGPOmoByFFofycXBbE4r/ApB0wI0JsvmsEiQC7lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzURjXxk+R2cH2ocC5t7Yp/8RGQ0q8Q8bsiOZvSgvpFXF4IkeO+noaVFOxHm+ngpxZQhaKRGFiD32P3XUi8+Cysrk4WGgXfUCSg/kEcYJy4eFJ4TjXIuk508UzvcK24njA63Q+kLaoEvjzdK+rwYYbAKeODExwCMhtp/P6JGNSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZ1wBGo5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffc7a2c5d5so18804111fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733476847; x=1734081647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IRA3/L1MtueZJgMZJQTJG4nr5iZomdRWg1qoH/eWPx4=;
        b=OZ1wBGo5YsBD8g59fDHaaNljkQojIJuszzac/cE4IgNeEFvqKIlQndkxkG1JR+OvqH
         bZCZ/fquGMtHYB5Z4hEqTVNq83mJmrnglS0a8dpchP+8KokhGSwAXfHHn+ERzsMdWC+N
         CxfqTFTKNmQEg/wJHoXYab7MOrp1dC/2U0m9lkzNvKHTqFAy9cwijcwMaYEWx5EO8ugo
         yIYG1Cg4Xp74MZelOgBBtIESF2BOG6EYZbw079RRvNdVhdX4q/d91B7aOVMRg1jh9R2X
         cSLZ5EVVQIujv9ZvpadMAj7YVmk3Im7caqWrXzLoh+KvMh4zGhfCgaRnwtWtrkgMkyeg
         AZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733476847; x=1734081647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRA3/L1MtueZJgMZJQTJG4nr5iZomdRWg1qoH/eWPx4=;
        b=b3yRlu8jwJUclh0O7LBeYZXHuaawt4Esd+inivM84YV5AVAuuID5JJ5X6NOkjtjRS/
         ZxRXi7BJvKxHxgEmoyJo6ip081fCWWoie/aW87mogHM2KylpbK+PCl9jmetddHxgQcQc
         AnWy1jaxBVpez1ZS5269XFrjXTmQAlk1mpanq+Bce89MHNhQaBGCTozExQH+CvRHpjRM
         8R8LYIafbI+h5sVCTWc9MKWeX0SCdS3ql6vsLmhq0JAUfhVmrlC+JPADETulQgj5+Sl7
         ZGsAEFOmwfweAUsRVH/F5jDcXdhXsCqwOcdp8Y5URVAAqAyf/WJ/s0XeLMhWS84kR7WF
         0zSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOcHY2CSSeOXpI+j8KrnEIe/ls9JvdK2ECiA4HNr0s+1n1cwVsJ+9Lv8QG+fxibZGMaFSZdpIch+zPKEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8EA3KQRBZRO9iqO5Xu305coErTUWOeW1EB1+5MXJctDNIw9C
	vK+JI+RDczr4EtyZm9tL7JG4QCNgKCsaG672NxhMVWQzDExvshuTpcymNgPrrdU=
X-Gm-Gg: ASbGncvOe8ciN920JBhGoYbScs0PJkjPQMYn7H8FyaMGcTwCESnAOoEieO9JYENfkI0
	Vw7csa4tNDb3kQuRxhe2UwsNCl3YJP1OnhG0IK/u+DAKoSKIkrXHvxAfTWxxCMUU/WUGxv/A4pM
	XP5I379iJ1Vg8wXdyBqZjiRaq7bMtITMkDfdpE4V4KEKFakAixrLPNdqDSReHsnKbXOH41v+X0R
	fvQxY6puhzbBBu5v89A+oF1WuQZLosX1LZTCsqtH3TDQ9pqDL/z1vHG9cFOscti7J8AjEhxxGmA
	woDMbq3JeVhxk0mlAEYZdaRkTRp2iQ==
X-Google-Smtp-Source: AGHT+IECiQCAbYzEAjTKkWFCv1BZNgR1l7qD78Lgn6sV9wEMLOHQj41O396xk2oN3Wdy+DhHim++Vg==
X-Received: by 2002:a05:651c:1541:b0:300:264f:d002 with SMTP id 38308e7fff4ca-3002fc68eb9mr6568881fa.27.1733476846623;
        Fri, 06 Dec 2024 01:20:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020dbe28asm4556091fa.63.2024.12.06.01.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:20:45 -0800 (PST)
Date: Fri, 6 Dec 2024 11:20:42 +0200
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
Subject: Re: [PATCH 40/45] drm/msm: add a stream to intf map for DP controller
Message-ID: <by3wnkql4mguqi3u4w6iuzmt747hictbdzit2wktd5zkordhum@53njkt7dzf7e>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-40-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-40-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:32:11PM -0800, Abhinav Kumar wrote:
> Each DP controller capable of MST can support multiple streams
> and each of the streams maps to an interface block ID which can
> vary based on chipset. Add a stream to interface map for MST capable
> DP controllers.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 46 +++++++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/msm_drv.h       |  7 ++++++
>  2 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 7f2eace17c126e3758c68bb0dee67662463a6e05..caac0cd3ec94e7be1389d8129fbd506998cf77da 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -116,6 +116,8 @@ struct msm_dp_display_private {
>  
>  	u32 active_stream_cnt;
>  
> +	const unsigned int *intf_map;
> +
>  	struct msm_dp_audio *audio;
>  };
>  
> @@ -123,11 +125,36 @@ struct msm_dp_desc {
>  	phys_addr_t io_start;
>  	unsigned int id;
>  	bool wide_bus_supported;
> +	const unsigned int *intf_map;
> +};
> +
> +/* to be kept in sync with enum dpu_intf of dpu_hw_mdss.h */

This points out that it's not the best place to handle the mapping.
Please move the mapping to the DPU's hw_catalog instead.

> +enum dp_mst_intf {
> +	INTF_0 = 1,
> +	INTF_1,
> +	INTF_2,
> +	INTF_3,
> +	INTF_4,
> +	INTF_5,
> +	INTF_6,
> +	INTF_7,
> +	INTF_8,
> +	INTF_MAX
> +};
> +
> +static const unsigned int stream_intf_map_sa_8775p[][DP_STREAM_MAX] = {
> +	{INTF_0, INTF_3},
> +	{INTF_4, INTF_8},
> +	{}
>  };
>  
>  static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
> -	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> -	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true,
> +	  .intf_map = stream_intf_map_sa_8775p[MSM_DP_CONTROLLER_0],
> +	},
> +	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true,
> +	  .intf_map = stream_intf_map_sa_8775p[MSM_DP_CONTROLLER_1],
> +	},
>  	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
>  	{ .io_start = 0x2215c000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
>  	{}
> @@ -1489,6 +1516,9 @@ static int msm_dp_display_probe(struct platform_device *pdev)
>  		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
>  
>  	dp->max_stream = DEFAULT_STREAM_COUNT;
> +
> +	dp->intf_map = desc->intf_map;
> +
>  	rc = msm_dp_init_sub_modules(dp);
>  	if (rc) {
>  		DRM_ERROR("init sub module failed\n");
> @@ -1646,6 +1676,18 @@ bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
>  	return dp->wide_bus_supported;
>  }
>  
> +int msm_dp_get_mst_intf_id(struct msm_dp *dp_display, int stream_id)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	if (dp->intf_map)
> +		return dp->intf_map[stream_id];
> +
> +	return 0;
> +}
> +
>  void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *root, bool is_edp)
>  {
>  	struct msm_dp_display_private *dp;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 7ed0e25d6c2bc9e4e3d78895742226d22d103e4c..50719e188732acd3652e4a7063d1ba1e2963b48a 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -378,6 +378,8 @@ int msm_dp_mst_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encode
>  
>  int msm_dp_mst_register(struct msm_dp *dp_display);
>  
> +int msm_dp_get_mst_intf_id(struct msm_dp *dp_display, int stream_id);
> +
>  #else
>  static inline int __init msm_dp_register(void)
>  {
> @@ -430,6 +432,11 @@ static inline bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
>  	return false;
>  }
>  
> +int msm_dp_get_mst_intf_id(struct msm_dp *dp_display, int stream_id)
> +{
> +	return -EINVAL;
> +}
> +
>  #endif
>  
>  #ifdef CONFIG_DRM_MSM_MDP4
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

