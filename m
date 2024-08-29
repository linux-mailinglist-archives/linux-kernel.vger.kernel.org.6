Return-Path: <linux-kernel+bounces-306741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48FD9642C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183A7B2602C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCD4189F36;
	Thu, 29 Aug 2024 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMZ1P5MB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FC615AD9E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929932; cv=none; b=Jopq4MN8ECitOQDIp/8ex6GK9DTFYyvbqDX74Ysl+OjotPc7z5GbwdZuBv917tHyICW57d9ci5oTJx1mEu7aDqd+93uMYwfCJKQA0tVB9KCZa7hE7e/ObXiKkgAu6UR3Usnad3/rggWhMToeQWaOQ6zZb6oPDMIlGxygiAI+MUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929932; c=relaxed/simple;
	bh=qutK9Nb3WEHLa53IedWr1yMj03NWbnzdGsi3sD8GiQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGGbHfxrYEArv8xeE/uVw/9+ZSOV9P098d4n2QbXDfB1GyCVgQEgrrtZC/nRJGEp7fOvhhKfLvWvEGFwt99DncrntDxULjwgHLAU9FDrDJCTU9VOJsPg+OhLrB1DyNNk3ZyuAOI5du+JjKO1GAPE6I3JdiBwpiQ+17dTxy8loMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kMZ1P5MB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2021c03c13aso4241575ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724929930; x=1725534730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0LT3I5USuqdHB66fieoDxuDUolxHbQhLFiZF0asjZzM=;
        b=kMZ1P5MBNH/FBNqxTOYWvuC1Sp9OAFjcDJwzrvwjPZBDCLlyVnByHjwXEtORH+AiLk
         1J1x/MHGEKR6YsG7HsxP8KccFumXj2IRtUgUr+y4XFbkaaP95JY5gbj+3JA2xYU9qaPh
         BFMmEXoaO1cyQF3sGNqwZF48Txmlzqla8It3MUYg8S1P1Of8NwYE44ixTnwa5cFr4UCg
         jE29QPYuhHNqMUWt91dMwgQuSYt/Sym/ji7DaU33H8QatF5ivfgCPkoDGGwaNdyWYlto
         3ZJ/R4PZkaR/IHKXzNiiNQYz703WTbJU3XCPGVar1PPoEfGaGU8Jyw6bZe1CMhVNFCci
         uzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929930; x=1725534730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LT3I5USuqdHB66fieoDxuDUolxHbQhLFiZF0asjZzM=;
        b=NtLXC75jX575sVfEW06j6dM6WfILKxZFz6zu/yqFHYX1jdNsSUrR7Tz+ktXQ1zHDP8
         Ln4/3kAmHrnNGtQN31mJWMMjGWePkRqktgMQzh86q43AXrSg6DgrTypGosI0w3f0l9T5
         4ca7E3K8KDEdoyTLmhbogeg4HK8fxVaVIh/xP8DPVTs6etLV4synezo1jL4MZWxCjcw7
         eMrxrW/heMIPAzWRO5K85Xr/k8M9hKbqWdoF54wR2f0YBWGm6+P7Mmf3Oa8oY566Rni+
         qZwfzC8OGOz6xRGgfo9M0bYoPMbyoswJbTDbBD+akGFRoB4NuNJFw02sKmykOCv/pR5X
         fCzw==
X-Forwarded-Encrypted: i=1; AJvYcCWBTIXxc3JmcS0T8NFs2uXhcNVl6EWAxp8jPtlCYs9FkTUFzrN/sR6YebtMtuRUF8zOkmSH2UyLbAr38j0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GMwySiFZ0f3nHgd1G2NWG0Tz78BKQXRVQ3pacs58F1OIzhEe
	/AUg7DU9DW+DGcwPjULp8CLuAlw1Z388QaYsoG9UnHkYBmMvp/7GDtJti68Hh6RZoOI20hLLpoQ
	JyqPOE5v1eDirPwUeTgoFa4QF6W18P2o9R/0GZg==
X-Google-Smtp-Source: AGHT+IHuUtkpV/kCfgeCDeFSQtyZmOGgPIEFHPTwcwQPFLoYSq23mMMBRn9u66SKdd6NIBPJ/VPiWoO9n5k9fZu1gIk=
X-Received: by 2002:a17:902:c94c:b0:1fd:9648:2d66 with SMTP id
 d9443c01a7336-20516776254mr21438125ad.17.1724929929590; Thu, 29 Aug 2024
 04:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-9-bdb05b4b5a2e@linaro.org>
In-Reply-To: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-9-bdb05b4b5a2e@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 29 Aug 2024 14:11:57 +0300
Message-ID: <CAA8EJppAaHtwaDLQVG6f4zTmhpkpuuF0-NK9-iB7UzFcwO3hdw@mail.gmail.com>
Subject: Re: [PATCH 09/21] drm/msm/dpu: request more mixer for 4K+ DSC case
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
> request more mixer for the case that hdisplay exceeding 4096
> and DSC enabled.

This doesn't seem to match the code. And it misses the _reason_ to do it.

>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 05b203be2a9bc..33cfd94badaba 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -59,6 +59,7 @@
>  #define IDLE_SHORT_TIMEOUT     1
>
>  #define MAX_HDISPLAY_SPLIT 1080
> +#define MAX_HDISPLAY_DSC_SPLIT 2560
>
>  /* timeout in frames waiting for frame done */
>  #define DPU_ENCODER_FRAME_DONE_TIMEOUT_FRAMES 5
> @@ -588,15 +589,19 @@ static struct msm_display_topology dpu_encoder_get_topology(
>
>         /* Datapath topology selection
>          *
> -        * Dual display
> +        * Dual display without DSC
>          * 2 LM, 2 INTF ( Split display using 2 interfaces)
>          *
> +        * Dual display with DSC
> +        * 4 LM, 2 INTF ( Split display using 2 interfaces)

This doesn't match the code

> +        *
>          * Single display
>          * 1 LM, 1 INTF
>          * 2 LM, 1 INTF (stream merge to support high resolution interfaces)
>          *
>          * Add dspps to the reservation requirements if ctm is requested
>          */
> +
>         if (intf_count == 2)
>                 topology.num_lm = 2;
>         else if (!dpu_kms->catalog->caps->has_3d_merge)
> @@ -615,10 +620,21 @@ static struct msm_display_topology dpu_encoder_get_topology(
>                  * 2 DSC encoders, 2 layer mixers and 1 interface
>                  * this is power optimal and can drive up to (including) 4k
>                  * screens
> +                * But for dual display with hdisplay exceeding 4096, we need
> +                * 4 layer mixer. Because DSC has a max width of 2048 and
> +                * a single plane can only be used by one mixer pair
>                  */
> -               topology.num_dsc = 2;
> -               topology.num_lm = 2;
> -               topology.num_intf = 1;
> +
> +               if (intf_count == 2 &&
> +                   mode->hdisplay > MAX_HDISPLAY_DSC_SPLIT) {
> +                       topology.num_dsc = 4;
> +                       topology.num_lm = 4;
> +                       topology.num_intf = 2;
> +               } else {
> +                       topology.num_dsc = 2;
> +                       topology.num_lm = 2;
> +                       topology.num_intf = 1;
> +               }
>         }
>
>         return topology;
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

