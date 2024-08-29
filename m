Return-Path: <linux-kernel+bounces-306710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BE2964261
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DDE1C249F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6569C19004E;
	Thu, 29 Aug 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvZbiUYm"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C918F2F8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928892; cv=none; b=IRn8Z7is/rjLAkJmcj31cMi5TIVl5z501xSa4lWqxuaPZnbTjw4h2kzP1c1/kFWTmqpA7D19xcEPk532nu44WzujyFFHqUr7NAxf2OLo7SnItOSWmQK8WfitL3TbBbBjd/uTNLeGcGSaprnNrkaZld1h2dhR02yo3XLSTxLrg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928892; c=relaxed/simple;
	bh=t7aHE2dXK/IOFwMDCAW+zgLH1Jvdl3bZbfXmVm/BEY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSmSpvY/K6dhg5mFUvfdBn1CF6z2eRsU0TO/flOa2eEDHLg6ACL5m18tzMbkFEDkudEYzBYD0c8e3/lR8B5SE6H9M9rowb34VPfRjFPJfiBoQnFX27qd5zmWk5CDGlemeiYbjVB/qcluEFwLWCKViN78eOq6D25Vl4RP16PS+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VvZbiUYm; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6b4432b541aso5162417b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724928890; x=1725533690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WsR7RqYqCQqmzwTsLeO8CdfGE+Tzge8dR38Zue/JNNI=;
        b=VvZbiUYmoDUwbDhOv1bhfgyqcWEmnfoXexvlefkp6+u6dX5W7yHwKq40vfnlMlgYt/
         O3m6D4wacZUSvO2/kpnwhFHvsMjNMBq12mvn5TwgptzHJgB0TuTZS2fH7EHggmXPWRoG
         1mMX3m0Z/a1fXUJFasP29UGfevs4IdXNHc1BQxQWB22NcHhdpCnkVRVUaQG52NCS0j9X
         jnhcm1mT0P4bDzlg4CABb0tkGqk4Vv5nRmtqBuESjegPfq8bvI0aGcOzg7X4DqTR5ULb
         5Gfrm42/beWhYuXbC/JjVHJwYvj8OppTXkFYFqB/MnS8MbDTxCQ4R9E2Ix2AIL51jXMG
         qZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724928890; x=1725533690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsR7RqYqCQqmzwTsLeO8CdfGE+Tzge8dR38Zue/JNNI=;
        b=dGHLQdpPMCR8TLyao1DlVfMVAfNP6L5WFm9rOhXbnCieq4X+c915zw/i3sgvpykEO1
         WB2lTppBxnPViM2WMrbOT3z4gQIiP6kXiKoxcn2vX1C7UvLF6Qm/2ohQXNGPtNFDnH/F
         PymKRMygyXVXuTfKDITfcGJP+jKr2rgl3ewVLJeoZEnfCqtSsQiuSdpvKk34cPXmbxAY
         94IWn959/fmgb7tbgrCX8WNw4Vr80/BLzA+XY9gQi3dRRa4Ue6ADRqGWNOEe2euWtyLr
         e/1C6rVTsiD5RIG3KohEMOWujS5PT4LtiGJtQYDlHAKXprMKB36tuY9Xfg2s48q/4fwz
         m8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfdPAGdkszvoO7Sg7ZJW+QZuNMdEHUFh4FrbLRfyb0iuT5mBddNA3OYil6QyIPAq0wCzbcaVDi6UpYD94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwgWCTEipCBi3OPX5HoVZljxvkIlP0wvCdIlps7vxCvSSGH1fm
	JG3FIGWAC1sEh7mVdIUyRCJw+VzrEN1Lphpw//asr7PnplXQSFLBI1qr9kldgW6LXSxHpPsaWH+
	hsiePMxy13yJ8gW9beDzEHWC5OA1vcaS98YcCOQ==
X-Google-Smtp-Source: AGHT+IHlwblUdL+UTiUzAymzgQqR07igHxM+PP4FRvpf+PudLjPp4cCTHGnYjCo+YatZmNPbhFJbfpb+bLIZNBzAQwc=
X-Received: by 2002:a05:690c:6308:b0:6b0:d9bc:5a1e with SMTP id
 00721157ae682-6d27852ac23mr19105637b3.46.1724928889652; Thu, 29 Aug 2024
 03:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
 <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-2-bdb05b4b5a2e@linaro.org>
In-Reply-To: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-2-bdb05b4b5a2e@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 29 Aug 2024 13:54:38 +0300
Message-ID: <CAA8EJpp_LWmuN8CFuQEAME-O44_wJXUKsR1QwahuigzSss5Rqw@mail.gmail.com>
Subject: Re: [PATCH 02/21] drm/msm/dsi: fix DSC width for the bonded DSI case
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 13:19, Jun Nie <jun.nie@linaro.org> wrote:
>
> From: Jonathan Marek <jonathan@marek.ca>
>
> For the bonded DSI case, DSC pic_width and timing calculations should use
> the width of a single panel instead of the total combined width.

What is a "single panel"? Please rephrase the commit message so that
it reads logically.

>
> Bonded DSI can be used to drive a single panel having two input
> channels, or to drive two panels with a input channel on every panel that
> behave like single panel for display controller.

Missing actual action. See Documentation/process/submitting-patches.rst

>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

As pointed out during internal review, missing Fixes tag. Any reason
for ignoring it?

> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.h         | 3 ++-
>  drivers/gpu/drm/msm/dsi/dsi_host.c    | 6 +++++-
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
> index 87496db203d6c..35b90c462f637 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
> @@ -79,7 +79,8 @@ int msm_dsi_host_power_off(struct mipi_dsi_host *host);
>  int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
>                                   const struct drm_display_mode *mode);
>  enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
> -                                           const struct drm_display_mode *mode);
> +                                           const struct drm_display_mode *mode,
> +                                           bool is_bonded_dsi);
>  unsigned long msm_dsi_host_get_mode_flags(struct mipi_dsi_host *host);
>  int msm_dsi_host_register(struct mipi_dsi_host *host);
>  void msm_dsi_host_unregister(struct mipi_dsi_host *host);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 6388bb12696ff..7a4d9c071be5a 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -2489,7 +2489,8 @@ int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
>  }
>
>  enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
> -                                           const struct drm_display_mode *mode)
> +                                           const struct drm_display_mode *mode,
> +                                           bool is_bonded_dsi)
>  {
>         struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>         struct drm_dsc_config *dsc = msm_host->dsc;
> @@ -2499,6 +2500,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
>         if (!msm_host->dsc)
>                 return MODE_OK;
>
> +       if (is_bonded_dsi)
> +               pic_width = mode->hdisplay / 2;
> +
>         if (pic_width % dsc->slice_width) {
>                 pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
>                        pic_width, dsc->slice_width);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index a210b7c9e5ca2..6e915b57e14bb 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -420,7 +420,7 @@ static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
>                         return MODE_ERROR;
>         }
>
> -       return msm_dsi_host_check_dsc(host, mode);
> +       return msm_dsi_host_check_dsc(host, mode, IS_BONDED_DSI());
>  }
>
>  static int dsi_mgr_bridge_attach(struct drm_bridge *bridge,
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

