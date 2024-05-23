Return-Path: <linux-kernel+bounces-188117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C158CDDB0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188A628845D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1FC1292D4;
	Thu, 23 May 2024 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODAborJh"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D21292C3
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506575; cv=none; b=rHOh6ZmPQpXsILk4TDAX1HmgkyRES4o9Ax4eD4v0NNEBo7a5OUNoc93Nx3WOJ3WcDtEtDA5fzf4caAtA3So7+YxOlx7R+/qbTSHH5P3gU4c3beni2qzNyosBN7Nd11K3MfoZS4RYWoq/MXQm1jVnNmRA3jB3NCTU5sJd5hCcTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506575; c=relaxed/simple;
	bh=hBAK2EWjRxlWbq3h3sA3ZssGoYxqnIqX959k0jCqFLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmUXLtnqpvJf03ntEBsUdJJcKLJC0/GU6Xit5ay5nz0HCOKTozZdnZW/lYG0o8E7n0ZgjdptdyQapLUUNmzLhufJcGWr4eWXMP1Ti91GXZt7DAnH46LUNnFHsIPTxIYwoMcqsZdWF5XgdIqy1XugOxvLmn244pcda0Najd+Vjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ODAborJh; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso53496221fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716506571; x=1717111371; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JFndDbSEPFGWTHHMY8d+FZXd6zTs2WlrRGp5IfPBkeI=;
        b=ODAborJhHIoh9mpT1sfCPYY4CqalvZ6vDcVC8zCfq6exyk5HmzvJW7DG+fI9CYujbW
         28tJKIRgB0JFJf4Y0Rg+VxyTGuV8CPBukja+QvLOZbVe+rNdbT42YbVCzZSX6sx4teB7
         LB9EkRHVleinDcHb6PQTZ+1pNP3sNfEutX8HPa2Y1bZEDqz9yTOcq8NDwOIUZxMS7kjD
         cHidNaYp9iO5znAw6AKec3opZlRyaWdw5VKDOOfdQYjnvp9I+RmIq2kHJOsrqHdkIr9s
         rBWke/heC5zrQcyj3vfQBWf10yu1HH/dJJpu2gwWMhcdnEeXNEbqEYvA535E4kRgFjjw
         65+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716506571; x=1717111371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFndDbSEPFGWTHHMY8d+FZXd6zTs2WlrRGp5IfPBkeI=;
        b=i/qGBfg6YXXIeh3Tm2uZSHHg2Nlyv6ruwyMwolze9RvSQQ2DRIOYAaed7Ognz91ht0
         CTDGrUW/9P2lYO4x3pUXDdJjraGvxt62uPpN1XH7Jh6og/qSYXDUJaT4kioGqDYGjYD0
         /lz5l+KtkiS++C1o/YrEIA0yFBkexVGSbUxJwVhHJuT19RcnKRyuPN6AdPdjEMSfRlAr
         Cpq847FO3QGxShXZ3R95G9HfyLmyy9OMt09XAH1iKO1ojkEIPxy/hvkbsYOE6hooTL6I
         5xaz1UyAGqMhfLvKSpppRLgFl8A7N+60hJ5tuSnkBmRL/poqHiB8EznTHkhfyLaBoT36
         r6xw==
X-Forwarded-Encrypted: i=1; AJvYcCXsHeGsUszZ4HU7WMh1y/hujzqwej7v+cuquLXoidqKFgoFOf2atL9SDcRMOsaeYU+oKuOoAEGww4Teg7dTAmwLIAlLa81ecql7veL+
X-Gm-Message-State: AOJu0Yw80pbrDfiSsuCbgsXZw74oRvys6iaQKvwW6aTZgbqpDzvDqFJf
	FT+mHE+0EHkRDTDRHAEQJd+KsAKXilidu73D/xJXP4irqI/A+H0CuzUPMP+8gTriuoNhIStF0Ou
	d
X-Google-Smtp-Source: AGHT+IF4P8BB0TG4cx6LOlYv3K27CXQM5lsuUzYsdgB4XMRi7GyT4ZdjwvZ5ytrxEpqVrOoi24g7HQ==
X-Received: by 2002:a2e:b784:0:b0:2e0:3f37:5af5 with SMTP id 38308e7fff4ca-2e95b2564a0mr3991731fa.41.1716506571062;
        Thu, 23 May 2024 16:22:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcd7c20sm231521fa.33.2024.05.23.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:22:50 -0700 (PDT)
Date: Fri, 24 May 2024 02:22:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Doug Anderson <dianders@chromium.org>, Yakir Yang <ykk@rock-chips.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH RFC] drm/panel-edp: add fat warning against adding new
 panel compatibles
Message-ID: <6pivdkrvtknj4g4nniq3fesdzp2pyskkkhn57kg2huro7v253q@ygco3sc23u76>
References: <20240523-edp-panel-drop-v1-1-045d62511d09@linaro.org>
 <CAD=FV=Xz1VsF8jG0q-Ldk+p=NY-ChJkTk0iW8fq2bO=oRFvXRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Xz1VsF8jG0q-Ldk+p=NY-ChJkTk0iW8fq2bO=oRFvXRA@mail.gmail.com>

On Thu, May 23, 2024 at 08:36:39AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 22, 2024 at 3:07 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Add a fat warning against adding new panel compatibles to the panel-edp
> > driver. All new users of the eDP panels are supposed to use the generic
> > "edp-panel" compatible device on the AUX bus. The remaining compatibles
> > are either used by the existing DT or were used previously and are
> > retained for backwards compatibility.
> >
> > Suggested-by: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > The following compatibles were never used by the devices supported by
> > the upstream kernel and are a subject to possible removal:
> >
> > - auo,b133han05
> 
> Ack. Looks like this was added by Bjorn but by the time the dts for
> the board (from context, sc8180x-primus) using it made it upstream it
> was using "edp-panel".
> 
> 
> > - auo,b140han06
> 
> Ack. Same as above, but this time the board was "sc8180x-lenovo-flex-5g".
> 
> 
> > - ivo,m133nwf4-r0
> 
> Ack. Also added by Bjorn but not easy to tell from context which board
> it was from. "m133nwf4" never shows up in the history of arm64 qcom
> dts files.
> 
> 
> > - lg,lp097qx1-spa1
> 
> Maybe. Added by Yakir at Rockchip. I don't think this was ChromeOS
> related so I don't have any inside knowledge. Presumably this is for
> some other hardware they were using. Probably worth CCing Rockchip
> mailing list. It's entirely possible that they have downstream dts
> files using this and there's no requirement to upstream dts files that
> I'm aware of.

I see. Adding him to the CC list.

> 
> 
> > - lg,lp129qe
> 
> NAK. See "arch/arm/boot/dts/nvidia/tegra124-venice2.dts"

Yes. I even had a comment next to it. And then blindly posted it here.

> 
> 
> > - samsung,lsn122dl01-c01
> 
> Maybe. Also by Yakir at Rockchip and also doesn't appear to be
> ChromeOS, so you should ask them.
> 
> 
> > - samsung,ltn140at29-301
> 
> NAK. arch/arm/boot/dts/nvidia/tegra124-nyan-blaze.dts
> 
> 
> > - sharp,ld-d5116z01b
> 
> Added by Jeffrey Hugo. Maybe Cc him to make sure it's OK to delete?

I pinged him on IRC.

> 
> 
> > - sharp,lq140m1jw46
> 
> Ack. Feel free to delete. This was used in the sc7280 reference board
> (hoglin/zoglin) and by the time the dts made it upstream it was
> already using generic edp-panel.
> 
> 
> > - starry,kr122ea0sra
> 
> Ack. From my previous notes: "starry,kr122ea0sra - rk3399-gru-gru
> (reference board, not upstream)". Nobody needs this.
> 
> 
> > I'm considering dropping them, unless there is a good reason not to do
> > so.
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index 6db277efcbb7..95b25ec67168 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1776,7 +1776,23 @@ static const struct of_device_id platform_of_match[] = {
> >         {
> >                 /* Must be first */
> >                 .compatible = "edp-panel",
> > -       }, {
> > +       },
> > +       /*
> > +        * Do not add panels to the list below unless they cannot be handled by
> > +        * the generic edp-panel compatible.
> > +        *
> > +        * The only two valid reasons are:
> > +        * - because of the panel issues (e.g. broken EDID or broken
> > +        *   identification),
> > +        * - because the platform which uses the panel didn't wire up the AUX
> > +        *   bus properly.
> 
> You mean that they physically didn't wire up the AUX bus? I don't
> think that's actually possible. I don't believe you can use an eDP
> panel without this working. Conceivably a reason to add here is if
> there's some old platform that hasn't coded up support for AUX bus.
> ...but it would be much preferred to update the platform driver to
> support it.

I was thinking about the DT/driver side of the story. Let me rephrase it
in a cleaner way.

-- 
With best wishes
Dmitry

