Return-Path: <linux-kernel+bounces-306733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA2E9642AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79391F26833
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FBC190679;
	Thu, 29 Aug 2024 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPglk4+w"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D455190674
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929625; cv=none; b=g6GMZq9iiHPcMXWnpy2abvhHJqgH1uJ+IJNssOJqADnyyL3JCxXx7zP8JaLmehNXiABqVczFh9BU+mkNpLIMtLGELz/JumcBi1gOqcpYrc3zJQ9kRWYFN9rETe009PZ6VE2DiCnlKM48Bf0SXAvGds8MctLHEfKPpm9+prDs87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929625; c=relaxed/simple;
	bh=wZvxKKGYSnnrJAe54yLhMalukjNH017TM2OAmexPsu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQrKVuty8zgjnuSRXy9YKvSwTwjCid/23pspozDzsN4asoh8RDBNBqAioz3BNWgVLc58C4JU9N0JCxTJzVUPqt0v9eL+IMDAIOc2DuxCnw9Yullon8689q2I1nEbdmf5S58FgfiERSrIWVlMRl/VRxaNSnEr4BldHw50MH1Nv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dPglk4+w; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e13c2ef0f6fso501289276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724929622; x=1725534422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2FuiHRYmBII7CoQqq9xCL2kOtuNSnjrajQjxmPmHnZ8=;
        b=dPglk4+wXk0lmoOdkiPQG6+Uww4hiXVz66/G+XgJZhs6M8nsVRRfNyo7IqV9lrfZy4
         Mx4/+r02Ie99VSXafSGHjQvZpmCDZR2qsY9v/71uTiwG/VmXbDufUIIXbg1ZpWVgGQcD
         9ry2E1zPdJ8XqfADxUQnEf/qsq1rGEgqbd6V52KpMCfsw7tIXer98Hy59YACpWq7Fu/t
         dZVqKyvt2TNrJEQQ9HJVqr3ZqqAMw9tjXryZZcQvcpAYinzkebSWakoHUrXrlEY89SWL
         dKXpoiNKYrrRYRdmJ96u42jUYceCzTPPAZo/m0cclnO3HY7yYoQqCJCsFaYACkRHoegX
         gs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929622; x=1725534422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FuiHRYmBII7CoQqq9xCL2kOtuNSnjrajQjxmPmHnZ8=;
        b=kQVpCngXqVw6/0/r77LhjRAOYkLGS+23/QsNV3ZPAuT1S7U+LdE9WulGcLjaT4ixhV
         t1r1PpnOLH4wvvWSq18w8XdtPdrA2/TN/S1eiS8gM3NH3qvuo8o6o/tXVOBsVMmsWDV1
         LXhXPCg4SGTZb/9p6VvjmHSWOQ8QfyjH6QLH+8Zs7aEBYdulgcj8mowes8lGvLv6/7tG
         fjkybzCWASW3SPf4IMLnjsWZVCKRshICiVPIpjczx2/01ZUp6psRIylZYEly3tmfRnJU
         Gnva1+A/tKXMHMy4suqk4KpR/r9fAjSVehVCh3+u/6tg+g5gHtJqFeqUt5jAf92X2r7w
         nX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkJLoYuofBRtwCXSrhzx5u3BvlaBcHmJetu051VJNx+ryoMNcmnr1+vTs5isIs+pUUZXYFeH9EBh4zyP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9cRywBligi3hoLeaf+4oMov4YbyZXb9cS7YgdkN/NoWHw3BM
	EaEXHDkubhAEtYoOx/Ui+Exh3WsF0gTvgPCX9/el090/+H6DvAwv2S/v7FTRECJt2KNzAulHQDN
	jjno8s+n4fyCjVYPHVVplWzxJUsbZKNpqtZ1uIw==
X-Google-Smtp-Source: AGHT+IG6C72qHtyISBm3HKfToRlotpCAtyStHxCL0ejzZ1LSExVqFZtCpufpvVkCjEjUXY8Iy4niYfvncKhgcjxsk1k=
X-Received: by 2002:a25:a504:0:b0:e1a:6493:21e4 with SMTP id
 3f1490d57ef6-e1a6493239bmr928134276.44.1724929621911; Thu, 29 Aug 2024
 04:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-6-bdb05b4b5a2e@linaro.org>
In-Reply-To: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-6-bdb05b4b5a2e@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 29 Aug 2024 14:06:51 +0300
Message-ID: <CAA8EJppJUB=wmaU+Hnh1=46deh-_wgd2qKtS-MJRkowUr8bhPQ@mail.gmail.com>
Subject: Re: [PATCH 06/21] drm/msm/dpu: Add utility to get mixer number
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
> Add utility to get mixer number via CRTC handler
>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 7 +++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h | 5 +++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 7d0fff9472441..a27e39c525d1a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -1306,6 +1306,13 @@ int dpu_crtc_vblank(struct drm_crtc *crtc, bool en)
>         return 0;
>  }
>
> +unsigned int dpu_crtc_get_lm_num(const struct drm_crtc_state *state)
> +{
> +       struct dpu_crtc_state *cstate = to_dpu_crtc_state(state);
> +
> +       return cstate->num_mixers;
> +}

Merge with the user

> +
>  #ifdef CONFIG_DEBUG_FS
>  static int _dpu_debugfs_status_show(struct seq_file *s, void *data)
>  {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> index b26d5fe40c721..701c35803633d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
> @@ -301,5 +301,10 @@ static inline enum dpu_crtc_client_type dpu_crtc_get_client_type(
>  }
>
>  void dpu_crtc_frame_event_cb(struct drm_crtc *crtc, u32 event);
> +/**
> + * dpu_crtc_get_lm_num - Get mixer number in this CRTC pipeline
> + * @crtc: Pointer to drm crtc object
> + */

Move kerneldoc before the function implementation so that W=1 can check it.

> +unsigned int dpu_crtc_get_lm_num(const struct drm_crtc_state *state);
>
>  #endif /* _DPU_CRTC_H_ */
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

