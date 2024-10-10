Return-Path: <linux-kernel+bounces-359061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF69986F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E40E287F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA301C8FBF;
	Thu, 10 Oct 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMKyVXuj"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B941BCA0E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565266; cv=none; b=Xp5wPjSZRPGO77B915o9ipAWSZ+itKbIY6MO120eH8rf1P0hmt8vUx/FcnjKsOc8FQEJhisj0wHr1mN+kmvgUnsDzc7INbeKrH5GzouNteoMjqaQyMW2ipDDZGZ4rIFcx9sRX/t1E/oRuCnoRpCOpsKjAu1+77Tfgl/LZqgRHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565266; c=relaxed/simple;
	bh=KOfseRigeJP0g4tSYmYGWzveuRzC5sENzMevN8ZOdqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXkLC5UrCQYcGauOvgx+RUUrmA+z8UU5e15r3KMw1xAMTYEtBaloMvAOxmbetyo5IXTwvvZ2B80VPRO2mw63t03xY1+dPzmeHb9xP565Qm36g+xxVmHKVkmx48DQTMI4E3CJxtFGQ02L/MtM5/OV//p3VxPz+Ah6UBMnYeAqVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EMKyVXuj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fac787f39fso9377941fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728565262; x=1729170062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/87wXXc/sp8cu8fisdCuGHnQqXu+PRTq4hBnj2QHS1I=;
        b=EMKyVXuj1pEhQ8xIVmFh4y6ubP8lR38u4kZt2c7Y+jPflqbZRvp5t1iZVNutlJUNSg
         xIV0iAN1sCB1h8fdZfcbY45SsFLr5nNfk5xbvBItUNFBrb5KnVy52ywW3Xa04cmsihNe
         Q4se4TlkFVbSr40BnlnZ9x/cWdY9UO835N9H6QZLNZowCXPNNBTiy4gf9bx//26B4eYu
         qT4kG0am1X+QfBgreHtXEgl7L5id1sEwJe7CAR6N/Pw/GwCa00rv429rSYsVqlZ6Miz3
         P/PVTb9iUG3KAq7QRg95wthUeLdJm9S865TkOEy65tCVjGytCBXnjUQEHZEKMKgbAFAq
         4jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565262; x=1729170062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/87wXXc/sp8cu8fisdCuGHnQqXu+PRTq4hBnj2QHS1I=;
        b=OM24T+EwMfuSMCXxhyzeK215guqTXDEuF9t+YpKOoov7eEqajnbpwpVDPf022Ss/Vd
         hxAvGEUbXCY0L73Q5UuNX9hd6UVTKw0aVamUyxYpx7fn47BoDhFuZmGuyaRooG/18nqr
         FSvt5vpBRTTYyCgtBESkTjvrlUnPTH9jyRUJsS3OUrMvUUUhMuwXKV0xVHYq2NTnyFCV
         Q17qwkKJSyLfjNOsYWryUKZz7Sawr0j/wQcluis9oatAhPzjs4kdjyMEIFSOPnHzh0hl
         EGrBjrOZjrmlyVI8bn09dw/BdgCFdXI/57dI7lw0tZanTjXtL9x6nm1fANvluMUplXRJ
         Wggg==
X-Forwarded-Encrypted: i=1; AJvYcCWcyAx0+5Y5Fj8uwB5xAcqWoush3OODqB/JGzab3WVc62G13/VXEn7aJi47H7vFWBq+5kfo0ZLBPHBfNiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+7X3Bv9obqaWdYmnQoNxwUz+meyg8AHAuB9RqvUlSToDiI2z
	LrJ3DId0sWUyq/mE2xQ/Hw2V8jZ/x6LmFjlCgaGZOdg632395Mtfbm2hua2DwzA=
X-Google-Smtp-Source: AGHT+IGI3cE4GJxXPqkv7BkcTu+I9BR6+dZ4zRgvWww5xlpXaIyKaImwMbGL+v/uydmVX7pdtU2aZA==
X-Received: by 2002:a05:6512:108d:b0:52c:e170:9d38 with SMTP id 2adb3069b0e04-539c48e461bmr3996836e87.31.1728565262114;
        Thu, 10 Oct 2024 06:01:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8f0e9csm246820e87.187.2024.10.10.06.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:01:01 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:00:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] drm/msm/dpu: polish log for resource allocation
Message-ID: <3pdtrfs7cmdqtll5uonf7o6arm4har4dj3kcz4gsbtghb6e6n3@p6pgw7l3222u>
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
 <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-1-76d4f5d413bf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-1-76d4f5d413bf@linaro.org>

On Wed, Oct 09, 2024 at 04:50:14PM GMT, Jun Nie wrote:
> Add resource allocation type info.

Please describe changes properly.

> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index 15b42a6683639..2b03ab907c2bc 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -778,6 +778,21 @@ void dpu_rm_release_all_sspp(struct dpu_global_state *global_state,
>  		ARRAY_SIZE(global_state->sspp_to_crtc_id), crtc_id);
>  }
>  
> +static char *dpu_hw_blk_type_name[] = {
> +	[DPU_HW_BLK_TOP] = "TOP",
> +	[DPU_HW_BLK_SSPP] = "SSPP",
> +	[DPU_HW_BLK_LM] = "LM",
> +	[DPU_HW_BLK_CTL] = "CTL",
> +	[DPU_HW_BLK_PINGPONG] = "pingpong",
> +	[DPU_HW_BLK_INTF] = "INTF",
> +	[DPU_HW_BLK_WB] = "WB",
> +	[DPU_HW_BLK_DSPP] = "DSPP",
> +	[DPU_HW_BLK_MERGE_3D] = "merge_3d",
> +	[DPU_HW_BLK_DSC] = "DSC",
> +	[DPU_HW_BLK_CDM] = "CDM",
> +	[DPU_HW_BLK_MAX] = "none",
> +};
> +
>  int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
>  	struct dpu_global_state *global_state, uint32_t enc_id,
>  	enum dpu_hw_blk_type type, struct dpu_hw_blk **blks, int blks_size)
> @@ -828,13 +843,13 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
>  			continue;
>  
>  		if (num_blks == blks_size) {
> -			DPU_ERROR("More than %d resources assigned to enc %d\n",
> -				  blks_size, enc_id);
> +			DPU_ERROR("More than %d %s assigned to enc %d\n",
> +				  blks_size, dpu_hw_blk_type_name[type], enc_id);
>  			break;
>  		}
>  		if (!hw_blks[i]) {
> -			DPU_ERROR("Allocated resource %d unavailable to assign to enc %d\n",
> -				  type, enc_id);
> +			DPU_ERROR("%s unavailable to assign to enc %d\n",
> +				  dpu_hw_blk_type_name[type], enc_id);
>  			break;
>  		}
>  		blks[num_blks++] = hw_blks[i];
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

