Return-Path: <linux-kernel+bounces-306739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19209642BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677002815F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4838190679;
	Thu, 29 Aug 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBrgC1rd"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F18189F3E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929829; cv=none; b=YI2psUaXqQfRZTPhhh6fwguUupkc2xEcl8XGtu4L81Q/GNMo+kpomHJFkaEcJeq64RUTHkNd8742zrnITl/eKvpu10rCKOS4vDOvEBiWwVufCYckzDkhqQNkT5msIX8SUC0oZxCSp2DuqOQbaoX9lJCpnXla8jn6K6GK+vVvbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929829; c=relaxed/simple;
	bh=ZILWOizrwMsUda6cQqGOf30Fw9nb4FMaJ7/AwYYDyXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHtMTLWNE7ecxADcwzGF6/x16G8B0iZWZC3+UdkRT4V+u9G6Ym2dz17FRlUy1QE0FkFx5utuU4C4h4sRX3Uq0CNJV3Z4tm03zwNZpxqHcliwoCCKfCDe62QVQjsUeWZ/6w4W3vtpBiO/x+Vmele50MvH9hUP5Y4qmZwHoERVyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBrgC1rd; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so543920276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724929826; x=1725534626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IMZRn0sUhAT7QPLtxYhsMgrNJCWGnuhAKggHYsS2Lvc=;
        b=EBrgC1rdT2nBUAmgN8easAjqGnHY15UprcEGlMQlxe9nk+n7QlLZ2Z/KlEQo9Na6zU
         Uh+vD0DQrXCPi/UuNWF1VoU/BPdlr5/Yxn+IfbWc/yz8ORKLajZB6Jzi2A9O+0/8kK32
         iOc3uJB1IjhgSFtUhqh2ymDjmApz0FXWQAxM8zTQqpHcw76XULy7kzByGKjOpQSytU5Y
         AFgEdluGZHwrkL05YwigL8t5IR5u8fA2qOXD97aktDsQOOPhXBWrgPwNTyW9XVsC0Fcl
         3WGbEI/LKNQqybQJFbj78OCaTWiwRw9Jhh0T1UL26orKFKoEkGW6k48LmoZwrcDahWl9
         7toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929826; x=1725534626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMZRn0sUhAT7QPLtxYhsMgrNJCWGnuhAKggHYsS2Lvc=;
        b=LIlvs/79cXgG7USiTN+bNyCbp1sjfCEkSyyzVyysp6AYV6PLwUcBBQvGNRAj78Sm9q
         lACp/kqBM3KdeM2O7So9LGyHcrB0loOKFIJ4ckRkmYHPfxecSInAaNxrzJEyt4Zhza8r
         M/hnIiAGBa5St3SHcrqc/V/uOSaIXXwS+nLVVE7qxCxL74ciJqsoqFwtdTEvyKrvNc3x
         hYv0Fa+Of9Sn8w43q3jasgC7+uFZDcJormBLYuPFP3yh/AP/et/E01Nis6LKbiLVoayW
         IKN9qh+8RIXaXljhGtBSzkUFlsFQrDQHFZ6QIfmJ2Xi6FW/xcA5haMksmf3aVkXr3vQ1
         tEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbEDYxjlXttTAJf2yFLnnqGweY/EoC0EDadL1t9eu9Zkxu8znux9ZPD10FSwrugBCiVW3yiCjv8B7Wx9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlTzW/BcEkGrXlrBiKF2puDXjEL16CT/6NqirCx5i4qRJ5qgi0
	c75XijmzYjw6/tHgkfZYUOFiNmoBd0CN6TVVFp3Y6JtmCSn7rTO/x7hc2Xq4ZJsBkKJ4iVcSoTp
	hBxjt2lc9AaZ2T+aqen24jisAbgN0bh/Bu96G7A==
X-Google-Smtp-Source: AGHT+IExKB2y+YYKi+w/X2u1O51Cl6dOZJ7yQ6Ws+aZXHZmk8aKxUzPH5YQQBBnmoCI91r2oWOFUFXCggGYyUusPgOo=
X-Received: by 2002:a05:6902:e0b:b0:e13:cb58:dd15 with SMTP id
 3f1490d57ef6-e1a5ab47dfbmr2665701276.8.1724929826178; Thu, 29 Aug 2024
 04:10:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-7-bdb05b4b5a2e@linaro.org>
In-Reply-To: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-7-bdb05b4b5a2e@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 29 Aug 2024 14:10:15 +0300
Message-ID: <CAA8EJpqZjO9rfVgVkhyCpg9qfyc13MHtz=RRhZG6ihMsVM+bSA@mail.gmail.com>
Subject: Re: [PATCH 07/21] drm/msm/dpu: Support dynamic DSC number
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
> Do not assume DSC number as 2. Because there are 4 DSC in
> quad pipe case.

Please expand the commit message. You prefer brevity, but your
comments lack clarifications.

>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 6bdd9c21ff3ed..05b203be2a9bc 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -553,9 +553,9 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
>                 if (dpu_enc->phys_encs[i])
>                         intf_count++;
>
> -       /* See dpu_encoder_get_topology, we only support 2:2:1 topology */
> +       /* DSC and mixer are mapped 1:1, so reuse the mixer number */

Why? DSCmerge is a valid topology even if it is not supported yet.

>         if (dpu_enc->dsc)
> -               num_dsc = 2;
> +               num_dsc = dpu_crtc_get_lm_num(drm_enc->crtc->state);
>
>         return (num_dsc > 0) && (num_dsc > intf_count);
>  }
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

