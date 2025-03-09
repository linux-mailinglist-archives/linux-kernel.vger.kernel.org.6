Return-Path: <linux-kernel+bounces-552964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B2AA58194
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221AF3AD6FE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9C818FDD2;
	Sun,  9 Mar 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vhd5b55N"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA018E361
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741508199; cv=none; b=GeZx7NAs/LMwKrinKOvUUe1R5bBOYpeqR7Vx4L6Wl5tmifsxrfn4YbWlGz2K0YVgWaO6iaVJfVatXwGDGCgBWADPOzgoroAbjal13l62nGEfM98kFjkCvLF6q+gn7b0XsKtJY8xcb7IvQfAj52b5QPDSsxNjzexEU14SwGIavnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741508199; c=relaxed/simple;
	bh=lWZOKRJ5HqRDVKNcGDOhOGnuQdNGoBUNycSoUvRSUlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoR09oTvefxAsQsyYwsTo5LSxDt0y1rB+PbgVwDp44EAswz60k8cbe92pjjvoRkft3MJbOxNrB2gxptCCtMXDKUV0fABzo8R8GZIUtrgq5T9/pXB1n39/eKRNCotas8urpNcWnkDPGxtlmc7IF/CNt4wjEsPlaksVvUmvvOgMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vhd5b55N; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54963160818so3796329e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 00:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741508195; x=1742112995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=89SfYDl9Q5QnukNfbtuYibaaCHpU8JBYjMuTQ2U+dPA=;
        b=Vhd5b55NIZ044+9p6uUaM+/d3EOHEcXvHMWjDd0upR/uG6JVwfLeX3HrjGZY8ylmo0
         4ZtpCKij8URix8lBy+kPA7VtvVT1v9LD/UgtTjySX8ahDH6n1cTIhZD1g4Voppzt6Ys7
         ZcKdCLEig5ATglkztFJEq5qIOhnE0lMtUmBFgS4t+c/gFv1w9iovEyIjvazi7EiOy+dt
         sRz2lhGDDF5JeVk5ykeEpi1lj+1IldlmUAU7BOTNFZHo1aOkzhPFyXfURB6SmaskfAe5
         Zj0PeclEmHe6Q4q0wCfXO1zd1jFJOct8bzOp+weIzPi+9M1qqkqFpU819uRMU2a8ETMh
         CwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741508195; x=1742112995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89SfYDl9Q5QnukNfbtuYibaaCHpU8JBYjMuTQ2U+dPA=;
        b=g6SU1wQbqJ9fcclorkDBWfvekL/sD2XAQ5VaP+QEol3cq7R6lgpL/d3YZGe2fqm1Ge
         KgVT56Kfo/ThpVbC1AkqMpp3FTgaL0wZqhCdAxmrtBzBYRdBogbrQt8pR0k3lyrRxV5Z
         uJ0XhVOjWY1IcqUdTF4Ci5uL5OvCaThJuazuuisC+nQCaWj/ARlBQWoCGRZjk5hxVsyu
         ZoasKSyNcsQJwAtNOzekOXE5QcSopdOBo4I0WEmmOcHb0EXxJ7XdYMNmiqqGx1C+HLOk
         d2Hvvd3wkJJs7KdMS6iZjvjWJ1q/fxMbeXdfLemvBkIx40/71oYk/lgDZK9UF1LqFlYe
         RXHA==
X-Forwarded-Encrypted: i=1; AJvYcCV+rZMM5AWXYsgvRcMENdKIA3+NsOX/pCFQ6haUEg1rUQGj4ihL2ePLZ3npqCg5qgdzwaB9egMH4D1dRKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxR2HxJlkLMlgqTUOUEhfLrGhWTHjtGa8OIrz2H0MUpNkScUS
	fxR+DYzHurssXU9F1RSQi4yQ868/PLxPJ2DftU0mXhC64ycAeUTiLfMjD6VuC0o=
X-Gm-Gg: ASbGncsHYDw+SR3R391aWeOp20l6J3o+QlQFn/MCzCXRdR11f8Ntas4kdheCWbwBgse
	/kJBZ+m4bjJThJii5YJRo7GD8xIBjKQqPXZm6JwBw0YycY8bx2ldFUyCAEtD2lU6+VXXYp31XBA
	UaeJ17Ts9q2S6I8e5cC6htHtCG1YUkucMKuO2VSf1urbUfJCGZ1s4fKXj3XZcOKJFyfCnRhVts1
	565f5wgIapTX0wydNgygIMYT8qGnVZtPU5GI9ORdPvZnFojq06jwSEbDp5FifmwEVnsBNwJLnIZ
	kMiEQIUkcUe4FAmL1zjXaZVO0jfACHHqHDiR0RALDxHS5lnvH865il/tyVpMvmF5KnwOfW8MWOC
	YksElFWgFlvxXuqPk48uX3PX+
X-Google-Smtp-Source: AGHT+IHonFYRVCOD3hc2ZLZ2k0nh0AnV9X63OZNmrpqQRQXGzg2TI3GANig2LQlLgV4Hue3Yp7RGkw==
X-Received: by 2002:a05:6512:1112:b0:548:9786:c18a with SMTP id 2adb3069b0e04-54990e5da6emr3725516e87.19.1741508195235;
        Sun, 09 Mar 2025 00:16:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae46199sm1054491e87.39.2025.03.09.00.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 00:16:33 -0800 (PST)
Date: Sun, 9 Mar 2025 10:16:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, quic_jesszhan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: reorder pointer operations after sanity
 checks to avoid NULL deref
Message-ID: <5x4bmy52gxc6y3m6qswqxoxvjsk52zz7lvjpudqgr4d2hwaz4b@bdf2dzgji7gf>
References: <20250308144839.33849-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308144839.33849-1-qasdev00@gmail.com>

On Sat, Mar 08, 2025 at 02:48:39PM +0000, Qasim Ijaz wrote:
> _dpu_encoder_trigger_start dereferences "struct dpu_encoder_phys *phys" 
> before the sanity checks which can lead to a NULL pointer dereference if 
> phys is NULL. 
> 
> Fix this by reordering the dereference after the sanity checks.
> 
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> Fixes: 8144d17a81d9 ("drm/msm/dpu: Skip trigger flush and start for CWB")

Your SoB should be the last tag. Fixes comes before it.

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 0eed93a4d056..ba8b2a163232 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1667,8 +1667,6 @@ static void _dpu_encoder_trigger_flush(struct drm_encoder *drm_enc,
>   */
>  static void _dpu_encoder_trigger_start(struct dpu_encoder_phys *phys)
>  {
> -	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(phys->parent);
> -
>  	if (!phys) {
>  		DPU_ERROR("invalid argument(s)\n");
>  		return;
> @@ -1679,6 +1677,8 @@ static void _dpu_encoder_trigger_start(struct dpu_encoder_phys *phys)
>  		return;
>  	}
>  
> +	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(phys->parent);
> +

I'm not a fan of having variable defs in the middle of the code. Please
keep the def at the top and assign it here.

>  	if (phys->parent->encoder_type == DRM_MODE_ENCODER_VIRTUAL &&
>  	    dpu_enc->cwb_mask) {
>  		DPU_DEBUG("encoder %d CWB enabled, skipping\n", DRMID(phys->parent));
> -- 
> 2.39.5
> 

-- 
With best wishes
Dmitry

