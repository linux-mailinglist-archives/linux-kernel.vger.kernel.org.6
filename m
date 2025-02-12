Return-Path: <linux-kernel+bounces-512074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2086A333BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350DD3A87EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE2214204;
	Wed, 12 Feb 2025 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaCuilnj"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF543206F2C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739404693; cv=none; b=RdIfxyrgrgy1kp2e1RfdGr1G7duVXxNn/j7mVoOMWlNmxxt7osPHtg7spObB+d0PUwlZXFnxC7mV+it0YkopR0f99zKe1+Pr36/qpJSOwYiD87buzgSbYmxGJD+NmP9w+XpuTDmf4TuurqZuEI+6P8PoR7TRGf8G3GQS5u9y9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739404693; c=relaxed/simple;
	bh=GXgapAEMfDI8VVTx7ozZlmThk7UNNcxIVlFjSwQ0cck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1zv2LgzY/jcbOGn+yliAnJ2lfUVjC2z2lHG30P6R+1esWAfxT/szirvk+IZcl1O6G6hQBzM3NGG+SsD5vEpgM9i7unCZgNkMOdDL5fha0Pt7i9BKOTqY2KaYry0aMDG6ifd4K/DY06mu2fu/ihhVRg5ejYn67NC3o3DeXfzOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CaCuilnj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54505a75445so240829e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739404690; x=1740009490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3BAFGjYw2QJwqRQ3fFZmP6lC2tUfHuW+BgEHuxf/+t0=;
        b=CaCuilnjIWPpF4ADeVQXGfZ7luYwoLrRGN2wG90qNAw4IyevC8bmuRdugCantGWkKq
         nbdmG/e1OBijeG0at22T5kUlNHkj03zoQgXDE1yTPe4UnoQZYTldbgMCaeZtAxHKfHW7
         JKQfRruz91AtPY1mN5uAN9UZ5Oc74CwaYezK14Fr0OMifO9SuEF3zsPbsrQa1fCSyTcM
         PZgmHH6N+QYoLsKeAeVsPqpbZszcNfkuG8LXanV8KEqPUAl6P9VaYN4poqpI5iRfQjZv
         FJ6WmbvxQSBC675d7dqMw6Uc4QmGc4E2uCT7zNp6E9Y88rsNBS7fJzC6FhPRAU/don0Y
         iLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739404690; x=1740009490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BAFGjYw2QJwqRQ3fFZmP6lC2tUfHuW+BgEHuxf/+t0=;
        b=eiw8qNK+T+nb+F7CNQrPhvQYTPMuPr87INXo3D7wmXskGvWltPouhVeXtdfUJXvLcJ
         j4wXYFU8oOQcsTjkAVG9C0TfWq5DMEm2cB5CfDAnhhS0JHBO9oItWmg5OWXslzHJVDQL
         VUz8LBwHMMgSirH5aRjF0TPG9UCWL3FNvKuatPa+Po9PM1e5e/kazvsSDxt+qlBrd1lR
         cSYRRjNJZkTGs6R+EAP+jKX+gcW5vJXDOrdM48BeyYN1GLjVtQhqWGiKD8WVuAmlK9Ut
         kuCe6DTpHtq3kWUTRJDLn0ZT1B+95HaB/vCIC7B9IdmRJ1BoQ9GPMu/dBQHQf+/J4API
         sJeA==
X-Forwarded-Encrypted: i=1; AJvYcCXSxEROE1J3khifkeNC/UYA+bUiO8QbmNo+m6IGeZQq6ID4T4RmwLiWwqj75NwbhSimsKkAbvEuHgl5/a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziP/tMu1IVVdC6Ep1tNExbsBtE6Ha7a8NP/mfp8FX8/mVvQpew
	bLyXgg/jBPunueQvqtL3s+zr7TlmSoM+FXBVF48HbnCzwXaseHS2K1sxHY+eSpE=
X-Gm-Gg: ASbGncs3PeQzo48vBGtygRcKZCmDQ8+ih398k/XFsMxMptjYXXK7RAhPUyJDq7b7YcO
	e5HVvBbuUP0rMRWFIGhfhJH8nKNoi5P3jIepsLK3E5NbMWiT+xgr5Ywb9aI6T9AGPzfALhxo3aL
	q3Z1pgklr1LKJl1JXoLxHP/K+6qiul804Wqh+eE/DahQtYbqpPahGLtJUxz5L3B0sdc31cTejX0
	7Sw3sNbSjM/RPtqUewpCPaXwAvimAa8W0tIiNkosTxjpVXeUknBqrpPSIPvVxgmPLVb8l4WsnQe
	qheEWYtadCRODvr358wXVFpzY/xFiCzFUAs9MrKD6r1uW9Jfr1qudJe3KV4iVozGtS8j8Ks=
X-Google-Smtp-Source: AGHT+IFOzevMzwSqrsW5SI2f6zfmPKiGi7Ag3hljzjdY6B6YmBgvHDwMJG1evRLjw+6YvkchrmUSAA==
X-Received: by 2002:ac2:465b:0:b0:545:1d25:460d with SMTP id 2adb3069b0e04-5451d255120mr480534e87.12.1739404689779;
        Wed, 12 Feb 2025 15:58:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09ab70sm13305e87.78.2025.02.12.15.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 15:58:08 -0800 (PST)
Date: Thu, 13 Feb 2025 01:58:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: "James A. MacInnes" <james.a.macinnes@gmail.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Chandan Uddaraju <chandanu@codeaurora.org>, 
	Stephen Boyd <swboyd@chromium.org>, Vara Reddy <quic_varar@quicinc.com>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Guenter Roeck <groeck@chromium.org>, Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v2 1/2] drm/msm/dp: Disable wide bus support for SDM845
Message-ID: <dk7udmgj3mexlvxxoxvgwut6p3cv4faxhtcbqrikvfp6h6odi3@myp4sxi7nh5c>
References: <20250212-sdm845_dp-v2-0-4954e51458f4@gmail.com>
 <20250212-sdm845_dp-v2-1-4954e51458f4@gmail.com>
 <voecekzdacvrxedltgkiq5vwnaomchv2dryi6ukvk2xynw72wp@5nre7uesyvkk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <voecekzdacvrxedltgkiq5vwnaomchv2dryi6ukvk2xynw72wp@5nre7uesyvkk>

On Thu, Feb 13, 2025 at 12:41:02AM +0100, Marijn Suijten wrote:
> On 2025-02-12 15:03:46, James A. MacInnes wrote:
> > SDM845 DPU hardware is rev 4.0.0 per hardware documents.
> > Original patch to enable wide_bus operation did not take into account
> > the SDM845 and it got carried over by accident.
> > 
> > - Incorrect setting caused inoperable DisplayPort.
> > - Corrected by separating SDM845 into its own descriptor.
> 
> If anything I'd have appreciated to see our conversation in v1 pasted here
> verbatim which is of the right verbosity to explain this.  I can't do much with
> a list of two items.
> 
> I don't have a clearer way of explaining what all I find confusing about this
> description, so let me propose what I would have written if this was my patch
> instead:
> 
> 	When widebus was enabled for DisplayPort in commit c7c412202623 ("drm/msm/dp:
> 	enable widebus on all relevant chipsets") it was clarified that it is only
> 	supported on DPU 5.0.0 onwards which includes SC7180 on DPU revision 6.2.
> 	However, this patch missed that the description structure for SC7180 is also
> 	reused for SDM845 (because of identical io_start address) which is only DPU
> 	4.0.0, leading to a wrongly enbled widebus feature and corruption on that
> 	platform.
> 
> 	Create a separate msm_dp_desc_sdm845 structure for this SoC compatible,
> 	with the wide_bus_supported flag turned off.
> 
> 	Note that no other DisplayPort compatibles currently exist for SoCs older
> 	than DPU 4.0.0 besides SDM845.

With more or less similar commit message:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Hope I'm not considered being too picky.  I first sketch **how** the original
> patch created a problem, then explain how this patch is intending to fix it,
> and finally describe that we went a step further and ensured no other SoCs
> are suffering from a similar problem.
> 
> - Marijn
> 
> > 
> > Fixes: c7c412202623 ("drm/msm/dp: enable widebus on all relevant chipsets")
> > Signed-off-by: James A. MacInnes <james.a.macinnes@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_display.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index aff51bb973eb..e30cccd63910 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -126,6 +126,11 @@ static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
> >  	{}
> >  };
> >  
> > +static const struct msm_dp_desc msm_dp_desc_sdm845[] = {
> > +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
> > +	{}
> > +};
> > +
> >  static const struct msm_dp_desc msm_dp_desc_sc7180[] = {
> >  	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> >  	{}
> > @@ -178,7 +183,7 @@ static const struct of_device_id msm_dp_dt_match[] = {
> >  	{ .compatible = "qcom,sc8180x-edp", .data = &msm_dp_desc_sc8180x },
> >  	{ .compatible = "qcom,sc8280xp-dp", .data = &msm_dp_desc_sc8280xp },
> >  	{ .compatible = "qcom,sc8280xp-edp", .data = &msm_dp_desc_sc8280xp },
> > -	{ .compatible = "qcom,sdm845-dp", .data = &msm_dp_desc_sc7180 },
> > +	{ .compatible = "qcom,sdm845-dp", .data = &msm_dp_desc_sdm845 },
> >  	{ .compatible = "qcom,sm8350-dp", .data = &msm_dp_desc_sc7180 },
> >  	{ .compatible = "qcom,sm8650-dp", .data = &msm_dp_desc_sm8650 },
> >  	{ .compatible = "qcom,x1e80100-dp", .data = &msm_dp_desc_x1e80100 },
> > 
> > -- 
> > 2.43.0
> > 

-- 
With best wishes
Dmitry

