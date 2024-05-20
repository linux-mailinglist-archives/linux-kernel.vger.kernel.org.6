Return-Path: <linux-kernel+bounces-183647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FFA8C9BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B92C1C21C41
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A35337E;
	Mon, 20 May 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wafdUty1"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4F182DF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716203601; cv=none; b=dR+i/N8jlUqI0jzTgTpJ1dDBKYG1z8z8kh7+XsB37xk6tOk5AteHtQ3TQ+OVR4hSV9ZaIf6m7WC16YVZ5f3w27YkJgLneAM4BQkwYf33t/DWh5FrZe2DvYW3kldgg6uBMUhgjx95v+8LR/BP1SsxbPfeoHU9DxbhdfFsfRmjHuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716203601; c=relaxed/simple;
	bh=BwJI/vqR/Vf+YTatfUGzhpZo0KGpHV1810YIo5sFMss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lr66gJALAi5F46pCwhNfwoAuyRXWCSrwqNRlh7o9kimeI+yBJn2x19omA8C3oMXj219EpCa/hRS/GSbY1QQGJvVzCeO+M1HixE9MGLtcQhOwNkGd88cB7iw6TRAVKIgVTJUmR5a1dPd76tViMRfp9CNOz6j55tEpuJiMGEZdXv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wafdUty1; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de462979e00so2640319276.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716203598; x=1716808398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O5jh8Q3/PtVQ/wHNrcuIbE1MuAYfpZQK0CvL7Pv+jlo=;
        b=wafdUty1KBK9CRkOIEDnJ2G275QipBnHhbDQsf9Kx2uySr/LDXW2Ny4CYUUBNR46qE
         zCTOv/VzgTOoNJDxfPPIj9IFgrugP4fwi1hz7Mno4kUWeCKhR5bvpVsVBo33kacu45Gn
         G+DJ+z20adO2ioVN1y8wtC7fWErscDa7WzU14USN6zxQoeuEEJKl1HJ7JJEX1eH7MPbd
         9kVJQgW4wG4RAPn99Pr5ONtjOOJkowBJ1t5zssqGSjvKdOS1yc7CL+z6KcBmn9lvZoIq
         gk7is1X5VVEEK4wr5H3SwiMx+xFOqRpJesWd1fpX9KNAlM+r3NhBAGAWqYN3yROTs89b
         uc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716203598; x=1716808398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5jh8Q3/PtVQ/wHNrcuIbE1MuAYfpZQK0CvL7Pv+jlo=;
        b=Hqqha/MRfnj76qYiKc2j1Yrh/XMw0feBq3wlEjAW0+UifPqDdu+TGm6ks+ouVyNUOe
         SwLE+VfAn+dcOjgyUbq5gMvJmcA1AM9Ae3K5zwV1w0WgqBx7HaMq1tFs/VbUdO8NfQ4Q
         Ww2K7Uz8NkhEZdzAnY0O6X+sGfl2GWOGfvdlftG121UIjDSx569iz/mp024eaBYce7LN
         9yhezzh7QzN8KKqpvfMqk4VtdeoJZsbF1nTZ0GQckLhXe4ijK3fwQBEv0pw1k2vGxSd4
         qNSSVjU+Po4qySdtaDZyJeu9GI/SFS4sLX5HPcUC5ZXI3XJM7WpugJugCENYkhP952vR
         XQUg==
X-Forwarded-Encrypted: i=1; AJvYcCXlpIaxbWWmg0uhRJtxaS5AFm+s8uKJrRsxbRNuZo+tqHtAMpnfFte6EJHiDxsX4LF5Za32LF6WxTVe74SiYhYbRDHllPbOYeixpl7F
X-Gm-Message-State: AOJu0Yy7nR7XZoubRGJtSHGD0jLK3p6kcnxK/NNnzI7AnOUF0DFClCou
	5rUqtNdiluz+TfMfqSyzXeWyAer+RVCCkXLsQ06tfoRxHPF7rRLoPxYk8+3V4LwHE1osh+Hjt9Y
	DZBzZZus2/raPIRCWsF0c1olpI6Yk08Dw4CQr/A==
X-Google-Smtp-Source: AGHT+IHgw3R2VDG3/RcUEiQCjrLCQ2HYddtsmPFqDCMLDMd5M1yfaM/WnZRHZJBTrNeCwPZKpwSj4dE7NBwdkz/lREo=
X-Received: by 2002:a25:ae18:0:b0:dee:607c:3528 with SMTP id
 3f1490d57ef6-dee607c3793mr25911507276.3.1716203598470; Mon, 20 May 2024
 04:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516101006.2388767-1-victor.liu@nxp.com> <evnxopqt5be56vxuxqdj4l3mcd5nrrvucio7jhwgg4emraai3t@gherubdynyip>
 <e2d4e8b4-bab4-448f-8b67-21f2902fdcd2@linux.dev>
In-Reply-To: <e2d4e8b4-bab4-448f-8b67-21f2902fdcd2@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 20 May 2024 14:13:07 +0300
Message-ID: <CAA8EJppH1rYQ5pzkGP+V-=cOPBYMWm=ZK2Ei1ttjOiN6GRDP+w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: adv7511: Exit interrupt handling when necessary
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, biju.das.jz@bp.renesas.com, 
	u.kleine-koenig@pengutronix.de, aford173@gmail.com, jani.nikula@intel.com, 
	bli@bang-olufsen.dk
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 May 2024 at 14:11, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
> On 5/20/24 06:11, Dmitry Baryshkov wrote:
> > On Thu, May 16, 2024 at 06:10:06PM +0800, Liu Ying wrote:
> >> Commit f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> >> fails to consider the case where adv7511->i2c_main->irq is zero, i.e.,
> >> no interrupt requested at all.
> >>
> >> Without interrupt, adv7511_wait_for_edid() could return -EIO sometimes,
> >> because it polls adv7511->edid_read flag by calling adv7511_irq_process()
> >> a few times, but adv7511_irq_process() happens to refuse to handle
> >> interrupt by returning -ENODATA.  Hence, EDID retrieval fails randomly.
> >>
> >> Fix the issue by checking adv7511->i2c_main->irq before exiting interrupt
> >> handling from adv7511_irq_process().
> >>
> >> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> >> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >> ---
> >>   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >> index 6089b0bb9321..2074fa3c1b7b 100644
> >> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> >> @@ -479,7 +479,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
> >>              return ret;
> >>
> >>      /* If there is no IRQ to handle, exit indicating no IRQ data */
> >> -    if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> >> +    if (adv7511->i2c_main->irq &&
> >> +        !(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> >>          !(irq1 & ADV7511_INT1_DDC_ERROR))
> >>              return -ENODATA;
> >
> > I think it might be better to handle -ENODATA in adv7511_wait_for_edid()
> > instead. WDYT?
> >
>
> I think this is may deserve another patch.

My point is that the IRQ handler is fine to remove -ENODATA here,
there is no pending IRQ that can be handled. So instead of continuing
the execution when we know that IRQ bits are not set, it's better to
ignore -ENODATA in the calling code and go on with msleep().

-- 
With best wishes
Dmitry

