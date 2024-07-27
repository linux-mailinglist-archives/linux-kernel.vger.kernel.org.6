Return-Path: <linux-kernel+bounces-264141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6ED93DF6C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 14:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8262B21508
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430285270;
	Sat, 27 Jul 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrlcOLIm"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B81E52C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722084728; cv=none; b=KDRi9eVIwQg23AcoxI0r5yFd7uqJtDw6xu0H3zQFbxX5MMidvWUglj0rd/6w50IOvaJw/0iC3+rA7SxfMN73nVVOlnx1V07j6D2p0zqI2ox6jd1qIMlo2oFsOB9yhN2rlDVj9CGJ1LCg+kLCp4kTQ4pZZXIECp0Ej0DOBiT0mMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722084728; c=relaxed/simple;
	bh=lSWfdgZLpPAyHeO1G2Ngy1BGnQnduvZK/yTk52Mvfgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYbmdVYu9rbfW4D+dYgWhq5pj9CvH3HzphbfaXh3IMl0dkeC5m082cblcvHSBNoOzcnIk9VcZeG3i1hTsdF7egXsGN3PNi0dz3lggX8izYnBNtIpjADuBuCw1huYZrdqquokXlULrudXYOmo/eWNzOa3xFaR2X6DyW9WtqE5LHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nrlcOLIm; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6694b50a937so6737337b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722084726; x=1722689526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xxwI+BF04Fun71O/+zyaVLE4ENb0bE6poonk4EgAFQ4=;
        b=nrlcOLImciQGPs2GduAXe9vXpk0aGabOIpZrJVnh+bwtT7anY0CaF1CNLpk/HLv4yv
         Rnv8bOB+COOuBkOAmDjd0jacSNaCIR8T81PyJqVyuDV4anBKGQZoK9/1/11LlMQ4A3TA
         xuJT5aLwYw+w/EgMnfUTdHuiK7QWkA18hBWPMyRRLZn8iv08aPSCrYaYL3Bu4WOJUyqJ
         u/b5ak8BEgCxXBlRquI4i4NAori1Woxw6eH+QqnsAveyorl5SwXLNxk5H7qfeXZB23y7
         SgCQsqQsG+j/4btI/MvnVtwAJFgs2R0O4U3JVaGhpwEkSbC4bTaqBbXp2OaAUy4dNU0c
         oNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722084726; x=1722689526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxwI+BF04Fun71O/+zyaVLE4ENb0bE6poonk4EgAFQ4=;
        b=PHBtZvnk8yyS9iAk8VD2h0sQQ0qzEAmtcFBZjrCWeCjDou19uWlnItsogkq7/S6D5Q
         y+Egwa+D/mvnA7P4v7bhMiMCmCFa1HaNUzD/p+oisfz05mEifdKRBYYuBBcuJ/iL/ivJ
         21aX2hxyrWPLLZRfgiKB2NjNqfezQ59Q3y/6V/CjKnJtCQE5SAsX3iHSHSlDKJOCcysj
         w9GK7tCq5FodGnaeB1YIRanZhXlqifyOK3mgTPhb7AM3ozkdmb9/+oQHKhut0BN+hzwq
         RIXJ3RgwY+dkEc+VusVdG0Jsm3AP1+sGPZqsTm10nOWOIwvEY+6tnaQAdL/7MieTUOJH
         CpMw==
X-Forwarded-Encrypted: i=1; AJvYcCXUABw6Xo3oLvul4BjzS+HrPCh6Kc8AVoUN00Ll8RP56WmLoLtiVuTnC8C+VDOVfamMVSMi70RosoMxvRjHc7ZHrS/VOypsFQKh7/UF
X-Gm-Message-State: AOJu0YztYJpV9adkE18YkaxAROHoezn/6fR0CDCmCut5j+eC/Ur/tllU
	nd8s0ReNVDorPTTy/O+dKtRf/HnwiNR3QhwODdghmvnntOO2MOqzN1oa35/DcV2w7XQ3lfx97Ml
	BfvdEYE7mvFJAOL1jM0lfA4dNBKH2zWa2biKnhg==
X-Google-Smtp-Source: AGHT+IEDKPNFNODeNrgJWmlfw38zwxZ+Y+DGJZtlBMJO4eyj7EUsw2gsxBSghNaHzBTxF4I0ABOrfpiNWu8XhZZ8WmQ=
X-Received: by 2002:a05:690c:23c1:b0:62c:c62e:e0db with SMTP id
 00721157ae682-67a0a60d465mr33584997b3.44.1722084725792; Sat, 27 Jul 2024
 05:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725220320.130916-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240725220320.130916-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 27 Jul 2024 15:51:54 +0300
Message-ID: <CAA8EJpoYqHnG_=jt6Lo6v7a7h3CdF66bKqRf63RCmvqHWb4kFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: fix the max supported bpp logic
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <groeck@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, Vara Reddy <quic_varar@quicinc.com>, 
	Stephen Boyd <swboyd@chromium.org>, dri-devel@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, neil.armstrong@linaro.org, abel.vesa@linaro.org, 
	quic_khsieh@quicinc.com, Rob Clark <robdclark@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:04, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Currently the DP driver hard-codes the max supported bpp to 30.
> This is incorrect because the number of lanes and max data rate
> supported by the lanes need to be taken into account.
>
> Replace the hardcoded limit with the appropriate math which accounts
> for the accurate number of lanes and max data rate.
>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_panel.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index a916b5f3b317..56ce5e4008f8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -397,6 +397,7 @@ int dp_panel_init_panel_info(struct dp_panel *dp_panel)
>  {
>         struct drm_display_mode *drm_mode;
>         struct dp_panel_private *panel;
> +       u32 max_supported_bpp;
>
>         drm_mode = &dp_panel->dp_mode.drm_mode;
>
> @@ -423,8 +424,10 @@ int dp_panel_init_panel_info(struct dp_panel *dp_panel)
>                                 drm_mode->clock);
>         drm_dbg_dp(panel->drm_dev, "bpp = %d\n", dp_panel->dp_mode.bpp);
>
> -       dp_panel->dp_mode.bpp = max_t(u32, 18,
> -                               min_t(u32, dp_panel->dp_mode.bpp, 30));
> +       max_supported_bpp = dp_panel_get_mode_bpp(dp_panel, dp_panel->dp_mode.bpp,
> +                                                 dp_panel->dp_mode.drm_mode.clock);
> +       dp_panel->dp_mode.bpp = max_t(u32, 18, max_supported_bpp);

I think that in mode_valid() the driver should filter out modes that
result in BPP being less than 18. Then the max_t can be dropped
completely.

Nevertheless this indeed fixes an issue with the screen corruption,
this is great!

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8350-HDK

> +
>         drm_dbg_dp(panel->drm_dev, "updated bpp = %d\n",
>                                 dp_panel->dp_mode.bpp);
>
> --
> 2.44.0
>


-- 
With best wishes
Dmitry

