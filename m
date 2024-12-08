Return-Path: <linux-kernel+bounces-436267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7809E83A3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 06:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756FC165A6E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 05:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E83A1B6;
	Sun,  8 Dec 2024 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNSOCCeq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446C1EA65
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733635765; cv=none; b=YW1rA9nwOxZXxubvyJDFAVYMFHyKHy6eBctkyTtoqVmoME11/+KwFJLu/KO1kvXlaCI9xOb3WAJ+ecEKlrEndcXh/JaQEAA+Kxi5zGafU8jZbznqSZHXDwjWWVcmaaYCbzYEv71uQQ43lktmXll9j9Iz4k71PKnQOjwgwlGPLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733635765; c=relaxed/simple;
	bh=Wd3Y7R3P9afqvPtxDb/Fjp+QCeKJHKSYfvw1Ti8lhTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyafZGq6pPoHads1PpqJzjAFosA3NF+UuR9Lptlk0ytoZG3DMFX/4CX8oGsqiSq/RiXabu6/SunmwnUbtRE3oXaVRGx9xXTF/JxiPEDtHHSgt4fgDI8cyN7VAZz+lJzOcC/03BgOIEL0rLibQ1q7/M8WrK70ZIApyfbNRIEWwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TNSOCCeq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e0844ee50so3323300e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 21:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733635760; x=1734240560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vNGx5T/kut2PnS1TJVU24AmFFsWO3iytxgtvJA9Xvfs=;
        b=TNSOCCeqjFz/jnKJOHO1z4FVr/iCD5JC1Y/BslPTK17MxPsIdKT/LukftpTQG2sBxf
         wSEmBEa6iV+GB2Bvp+rRF+6OPZotKLs0/99RQX3gHIM97W0+i3vX7Vh7/ab9O3v4j/5i
         v2614WVxXuJlxCxOrN0O0M8s1Rc3xQTgws2FDhCMh0tkoj73zNQScA6twKL9Kd6Ve9ew
         Tx7QowvhsonQptbcoM38LoTJdWr+aTp8lMrycXkLnYziopXUPQ/NyInpV6Q/0j5z5i+8
         Rkechkze9XEZWV1h6ZAqw1Qw2kXhqtnDr2xURmBGNdPt6FksDwrQACQ2/nC56UKx3pDy
         1SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733635760; x=1734240560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNGx5T/kut2PnS1TJVU24AmFFsWO3iytxgtvJA9Xvfs=;
        b=ImU0HgAPH05BQCSW7wjj1bOO9f2ostqGiEff/ycQOQpDC++fbT/P0DxEgenJ+jGPfz
         4J9bvHS2n2ScttWMDZSX3dCp/2gJBXaYaxlK4YtQD4j6cFLY0F1QSjWOghrrrHQx/T/M
         2ZtneLBKfgCbiWnOUaMslA344/xrPNPxvWpQSZGch6od53jCh8Xw/O8EMbzee+UydPiB
         Kfbqt7Y6wHxI2FjBKVdFg4cwWcZYAB45Q+BkuRoaXaV/G8nLIrV72rc9kshh72tLArvs
         gkVUt6twPNg4srTvgrWLR74LDm60qnDEQOumUtItcMgGU2OuUcWHYIjpO9mFELTTe+Pa
         a5bg==
X-Forwarded-Encrypted: i=1; AJvYcCWfDiCYrCImRosaI5TSnpepXyzmuZtpNpvjQ1fT4nuDL62AHw1YnCZWLcZ7WYOHX+VkKNgf7s9n9Hlr2gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKa6fSDoyd16xUUcuBgwvvFaR0TYKwUUDcN3Qmq5HzkqsbEjJz
	lMZsm7CUCR3+Q6V9Sn0ts20hbEDUoVg6NBZXARnA7rIB2CD8izticW0dURoAqIM=
X-Gm-Gg: ASbGncuAcQCxitmzWRx5RmBVZdCuEDBQjECJh1mGpbt94KvtKmQ6xPA90cB339DdYrI
	kwSX+5OYWnmcSDmmuIvbHtccopBZrMCIr1uD78T6tRwYyxKqesLB9kQPYKL+oM5uMQLb5klVOEH
	s6xn1wflM0Ab6VEkDle2QdO3zJ7SkzO73NiUgK/geIWAgxfSwpo28zSK/0iJi+f69zvjjRFRcBY
	BDWnZ5BxntXBedy+SwoIteICcTWAugIBCjbyuqSXJfrT4Dl8ig+NTzgA3/rdtocHcgtax7+SVDI
	pVwZA8ssNg6hDky7Bue9UYGOQixanA==
X-Google-Smtp-Source: AGHT+IGOhQSpceSZ9KEm21ZiMJVHBV/c3kQtKDrxqIsT6LPxNRV9WJHBnedhtMHtbPhWJEJ/Z4HNTg==
X-Received: by 2002:ac2:4c4d:0:b0:53f:8c46:42b0 with SMTP id 2adb3069b0e04-53f8c46432cmr719545e87.42.1733635758999;
        Sat, 07 Dec 2024 21:29:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a90336fsm420105e87.265.2024.12.07.21.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 21:29:17 -0800 (PST)
Date: Sun, 8 Dec 2024 07:29:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: filter out too wide modes if no 3dmux is
 present
Message-ID: <zae7rlojv5iiq2dx7bxhdsmmzj73o65cwk7kmryxsst36gy2of@k3vcm6omcias>
References: <20241206-no_3dmux-v1-1-72ad2677a323@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-no_3dmux-v1-1-72ad2677a323@quicinc.com>

On Fri, Dec 06, 2024 at 12:00:53PM -0800, Abhinav Kumar wrote:
> On chipsets such as QCS615, there is no 3dmux present. In such
> a case, a layer exceeding the max_mixer_width cannot be split,
> hence cannot be supported.
> 
> Filter out the modes which exceed the max_mixer_width when there
> is no 3dmux present. Also, add a check in the dpu_crtc_atomic_check()
> to return failure for such modes.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> Note: this was only compile tested, so its pending validation on QCS615
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 9f6ffd344693ecfb633095772a31ada5613345dc..e6e5540aae83be7c20d8ae29115b8fdd42056e55 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -732,6 +732,13 @@ static int _dpu_crtc_check_and_setup_lm_bounds(struct drm_crtc *crtc,
>  	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
>  	int i;
>  
> +	/* if we cannot merge 2 LMs (no 3d mux) better to fail earlier
> +	 * before even checking the width after the split
> +	 */
> +	if (!dpu_kms->catalog->caps->has_3d_merge
> +	    && adj_mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width)
> +		return -E2BIG;

Is it the same as checking that there are LMs which support
DPU_MIXER_SOURCESPLIT ?

> +
>  	for (i = 0; i < cstate->num_mixers; i++) {
>  		struct drm_rect *r = &cstate->lm_bounds[i];
>  		r->x1 = crtc_split_width * i;
> @@ -1251,6 +1258,12 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
>  {
>  	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
>  
> +	/* if there is no 3d_mux block we cannot merge LMs so we cannot
> +	 * split the large layer into 2 LMs, filter out such modes
> +	 */
> +	if (!dpu_kms->catalog->caps->has_3d_merge
> +	    && mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width)
> +		return MODE_BAD;

This can be more specific, like MODE_BAD_HVALUE.

>  	/*
>  	 * max crtc width is equal to the max mixer width * 2 and max height is 4K
>  	 */
> 
> ---
> base-commit: af2ea8ab7a546b430726183458da0a173d331272
> change-id: 20241206-no_3dmux-521a55ea0669
> 
> Best regards,
> -- 
> Abhinav Kumar <quic_abhinavk@quicinc.com>
> 

-- 
With best wishes
Dmitry

