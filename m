Return-Path: <linux-kernel+bounces-306745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9989642D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F45B1C212A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DFF9474;
	Thu, 29 Aug 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLFA23Vk"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268A2B9CD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930230; cv=none; b=PN4wpqo8Z05QIAwPsRjYZQOFq/m+4ZNMBWi4M4vR2+EKfi8aVXTs7QJDvjM/Xje6xxVAB6cYvcY9uW+8TUD1vGUTmZiiMfcHO8ETTSyGm5/bBufP9g7ug9U/6WCYmygxfT/eMDggEOrzfvBFxEo46GEij9N0qvuH2/sdVrnfQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930230; c=relaxed/simple;
	bh=6MssBDNrO0WJQ7BC23qjUcaOIJyLa4CQjHgBgEWJIXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIUJHR04Imh5Zc7svq7BPZYgiEn9DsNXZcpEPAnUklPNDwcCVXadJm7VrLjhQBC74WXYsF8c56WNsPudq14fWYTfgrMinEiPNo7At/Kk6Nbf5xvaAuywR2gOJhxjUZvVpMgTc3on6t39/nm0pJihg1nRS59Ywm+/3XHeS2qdR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fLFA23Vk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d5f5d8cc01so388971a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724930228; x=1725535028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=am22cKQWP6n0/ohrouxqRikoVkqYhCxzxqagOImmkVY=;
        b=fLFA23VkKXwnXWcCU20DSpydhwk4rIAv4wDdLfGWkvoJy9PYtteYaaUVCyMA3oDlYI
         1/hPAxXa+4CA/Ly0H82ImX0gs+/LAnPj5sKKTwiesieVctf1rYBImgk5JzY42TYpmobl
         A4/VJQSreLPQm5ngxbSf0MEZD5OKEUIOPASAMSgu+QeBShzkI7NL1VnWMMKWH2AOt1Df
         mPLbUDkN4W7DyuRA58kfe5I2u9JKdhwI9wFKxfl+MZy+kfAc0/jgZeoY+zFXzFkxbsRN
         Rxsw65WgRWCQc5OZ8sEtUh7v/AIyn2/dXMHDrmZJ5IPQCoXZ4tEbbDwVZYgxYEG60IDc
         a5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724930228; x=1725535028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=am22cKQWP6n0/ohrouxqRikoVkqYhCxzxqagOImmkVY=;
        b=wpm1HvRi3cXg8ziKTirTlbtbU8FzP7pv/EwjMZWk4hgwdURJ6s4JBi+yTdFrAWgJmj
         OsFHbCp44pdDrODqLQCza3yhsfzQZfwVY6tpnaXPC7WJ+hGViHW7Zs0ZeG59IgnEr1X3
         sDOqAPc0dyoU759RzeCwqtQHZzqIz4TwvN/rlZEqwBL6rz9V/3sGWh79riZIuFkZ7ZKo
         Dh/1opM3ZuE9t/r6djVHoSNngeskZCsa5td/B0nZvta4zt1jF2pXbd2GomfDU3YhjZ31
         z+IZBvV2LTBggk4jejUqU9cQVtIznlzlr4xalmVozmh4eAfQzyaVcSE11raDtCc+dzie
         A1XA==
X-Forwarded-Encrypted: i=1; AJvYcCWhyeVLVs9eiP7S9Eo+RS2d35I9OVOcAyS0s0tW80G0GIhH3SkePFK9MHElLmiqLHwX1T30Yonb1FXb+IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHfcz9RJDuoYTFdbpACyRIhtCRF8Dmzc4pH6/vS0mHMJLHBeYR
	y2BbdYQ3aTi4p5H4J1N35IbtPuO4sagnO/FLMKD2g7Js5jWJK/2xFiveo4HvJ/DgVO28Tq590W7
	z6c2ewXjiC04pEwKe747UMDG7XinrIVmiZbO1KQ==
X-Google-Smtp-Source: AGHT+IH1T12mE9rHPH6kUY/iyJq0y2Ytt3ckXTMcNy8IISCWNcOwToqApPMtf/a43021k38iLM0rMUNHMbBnKa/5qAc=
X-Received: by 2002:a17:90b:4387:b0:2d4:27de:dc39 with SMTP id
 98e67ed59e1d1-2d856a5f271mr3395023a91.6.1724930227802; Thu, 29 Aug 2024
 04:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-10-bdb05b4b5a2e@linaro.org>
In-Reply-To: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-10-bdb05b4b5a2e@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 29 Aug 2024 14:16:55 +0300
Message-ID: <CAA8EJppFCVQPFa1-o7T08Bs+vzbykDXwVTOq4=B2LuWJb2gYGw@mail.gmail.com>
Subject: Re: [PATCH 10/21] drm/msm/dpu: fix lm number counter for quad-pipe
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 13:20, Jun Nie <jun.nie@linaro.org> wrote:
>
> Add the case to reserve multiple pair mixer for high resolution

I think you already know what is missing here.

>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 6 +++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 8 +++++++-
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 33cfd94badaba..f57725ad494d2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -54,7 +54,7 @@
>  #define MAX_PHYS_ENCODERS_PER_VIRTUAL \
>         (MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
>
> -#define MAX_CHANNELS_PER_ENC 2
> +#define MAX_CHANNELS_PER_ENC 4
>
>  #define IDLE_SHORT_TIMEOUT     1
>
> @@ -2029,8 +2029,8 @@ static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
>         struct dpu_hw_mixer_cfg mixer;
>         int i, num_lm;
>         struct dpu_global_state *global_state;
> -       struct dpu_hw_blk *hw_lm[2];
> -       struct dpu_hw_mixer *hw_mixer[2];
> +       struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
> +       struct dpu_hw_mixer *hw_mixer[MAX_CHANNELS_PER_ENC];
>         struct dpu_hw_ctl *ctl = phys_enc->hw_ctl;
>
>         memset(&mixer, 0, sizeof(mixer));
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index e219d706610c2..77d7ff789346e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -306,7 +306,11 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
>                 if (!rm->mixer_blks[i])
>                         continue;
>
> -               lm_count = 0;
> +               /*
> +                * Clear the last bit to drop the previous primary mixer if
> +                * fail to find its peer.
> +                */
> +               lm_count &= 0xfe;
>                 lm_idx[lm_count] = i;
>
>                 if (!_dpu_rm_check_lm_and_get_connected_blks(rm, global_state,
> @@ -353,6 +357,8 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
>
>                 trace_dpu_rm_reserve_lms(lm_idx[i] + LM_0, enc_id,
>                                          pp_idx[i] + PINGPONG_0);
> +               DPU_DEBUG("reserve lm[%d]:%d, pp_idx[%d]:%d, dspp[%d]:%d for enc_id %d\n",
> +                         i, lm_idx[i], i, pp_idx[i], i, dspp_idx[i], enc_id);
>         }
>
>         return 0;
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

