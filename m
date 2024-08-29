Return-Path: <linux-kernel+bounces-306713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E6296426A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438412858CC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362642B9CD;
	Thu, 29 Aug 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYWj5/8s"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4634158A33
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929053; cv=none; b=O7M8Bg+htuNy3pSM3AufjHbuc/MEQ8QeqoZkVs2Aurprubzx+pmt+5zjYrkXPWzTq5FWX6BYkuZmbClJBuVcAKZNxP+mMnFNxZFMI7y46hVDuIMFNq3v+dGxksgRBN8tt3cf4i1hYzEsOJJmif9fK/JC5e1AwbCGB4qIfusoHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929053; c=relaxed/simple;
	bh=OmUo2n5IySiw7WT+eI67AEuqklhjSSoYBItCIzp3NgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgiAcRb2r9XlSv9Ky8HEjtQG4Y5iqxx+cG8wwrYRNojfXdre5uL/uvz4DADsPQicHBLX+75CHFvM7uRygsFjkXrHxlTvzjevL+d3x3F2FqpLiQG8J9ouAYw4wnwHhy0C9zG9Vlcx1zgj28oavrcnBTZtdubBZSaqzFOcfa1Znpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FYWj5/8s; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b2e6e7ad28so13148067b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724929051; x=1725533851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kwqJQQb59xRLhCYwW6OAOAk3j2QVQ8lc2useMLEqB8g=;
        b=FYWj5/8swlMSJKUtgq0MXA223sJ6W94nBc3DLjx+agmLznGO1D4Vka3XObLY3zTHdq
         aOV7S0Bi12orVcXGogBFbVI39dZY2nOh5CYAdos3Frkl1BcDHij8SqRqoJxbyYDXjgyu
         HW8+V0cHi9G5Fh+UxE81AF1Qi7tnlbPq5X4f4Dgn4r4h5v7J7jt9ZJAqzpdO10rRQ9B8
         h8l/xF4D6c9y45ycdeQo9cuR7RFvtbqaPopRqGP4HD0aRV/ntSf97dVXp2ipXUCWXDai
         guZ967/aKzkFn8PqJodBFzwFCIO5jpIaw3cr76QGJjysBX9yvvlTu6jhpKSMCgI7F5rz
         w5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929051; x=1725533851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwqJQQb59xRLhCYwW6OAOAk3j2QVQ8lc2useMLEqB8g=;
        b=rcirEWsmOvcmkRu06NFOAexZXwpPWBRUNz9LkK43evrju3SdowfIvs9Ko3M9UF4h0a
         +KD+FzzFjKT7v3YC5V8iUMEbZCqGvnnlGqv321CAsaexlJQ33dWk7K4gwUd+VUkPjr+Z
         de0rBMw/Y5PBEOeeq7jMy4GoRXVzDB32yHONr2CdxnyiJO2oUkJDYs/V/tDjMzfrbQOW
         OuIa8BGehOXGXpwA+uKd+1WGeOZFKg6ku3fawlgUxFB/8DL1bZSB2o534ZWcC+gXLfQg
         2a+p/WXjcamNTgdIeKFNGSxQaLn87BnPuRpvCiqsTGaQ+gIJ555+IFYkANfUuDdrXLOS
         RTKw==
X-Forwarded-Encrypted: i=1; AJvYcCWPj1B3UyjsPX6NOykfHfMVqli6VJzCYzNpQMPjVJHwpvwqZrU5EZDjU0htRg9+60/EiIz24Sa1lQ/cR1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHW0y0XXSimKc7gnwoHtnH5biQLy/ED0BlH6zya1nNj/nBtsEA
	qm9xklAUoEuQtJ+HQ14jmBY3SmA6UvIgid1mxo0gSh9W/UXaNSy9jDgtZNIWjY86mXCPM+6zOYu
	ta5btd/RCG1qKAtFJOs5UvGnjfWz8oCopxCxHJg==
X-Google-Smtp-Source: AGHT+IFLwdc6wf30eDIUoq0QNI20U0jfGDr6mbQqABDDdx1FbiHjr/4K7A/bY8G0k8agAF4tWqiTjrO7GH+UZ34kNKQ=
X-Received: by 2002:a05:690c:5:b0:63b:ba95:c8b3 with SMTP id
 00721157ae682-6d2ed874487mr6947017b3.6.1724929050662; Thu, 29 Aug 2024
 03:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-3-bdb05b4b5a2e@linaro.org>
In-Reply-To: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-3-bdb05b4b5a2e@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 29 Aug 2024 13:57:19 +0300
Message-ID: <CAA8EJpqCL1xFVB8_2j2QwPsF-vHBcFBt3yx=acpWgmo4_Oudug@mail.gmail.com>
Subject: Re: [PATCH 03/21] drm/msm/dsi: pass the right width to dsc
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 13:19, Jun Nie <jun.nie@linaro.org> wrote:
>
> Data width for dsc engine is aligned with pipe, not with whole screen
> width. Because the width may be halved in DSI bonded case.

Can't really parse this.

>
> The dsc width is not related to the timing with back front porch in
> later stage, so update dsc timing earlier.
>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 7a4d9c071be5a..5abade8f26b88 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -953,7 +953,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                         return;
>                 }
>
> -               dsc->pic_width = mode->hdisplay;
> +               dsc->pic_width = hdisplay;
>                 dsc->pic_height = mode->vdisplay;
>                 DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);

Two separate commits

>
> @@ -964,6 +964,11 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                 if (ret)
>                         return;
>
> +               if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO)
> +                       dsi_update_dsc_timing(msm_host, false, hdisplay);
> +               else
> +                       dsi_update_dsc_timing(msm_host, true, hdisplay);
> +
>                 /*
>                  * DPU sends 3 bytes per pclk cycle to DSI. If widebus is
>                  * enabled, bus width is extended to 6 bytes.
> @@ -990,9 +995,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>         }
>
>         if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
> -               if (msm_host->dsc)
> -                       dsi_update_dsc_timing(msm_host, false, mode->hdisplay);
> -
>                 dsi_write(msm_host, REG_DSI_ACTIVE_H,
>                         DSI_ACTIVE_H_START(ha_start) |
>                         DSI_ACTIVE_H_END(ha_end));
> @@ -1011,9 +1013,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                         DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
>                         DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
>         } else {                /* command mode */
> -               if (msm_host->dsc)
> -                       dsi_update_dsc_timing(msm_host, true, mode->hdisplay);
> -
>                 /* image data and 1 byte write_memory_start cmd */
>                 if (!msm_host->dsc)
>                         wc = hdisplay * mipi_dsi_pixel_format_to_bpp(msm_host->format) / 8 + 1;
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

