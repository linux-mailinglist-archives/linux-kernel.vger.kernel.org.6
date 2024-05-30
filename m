Return-Path: <linux-kernel+bounces-196013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB48D560F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABAD71F2730B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9118411A;
	Thu, 30 May 2024 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXOPQRE7"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0318399D
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110676; cv=none; b=jegBGdZjSqseysRy77xKrsTNIDSTCvU/tWHYriwONHlikGKEH0w8VVJ9oEkR9NpJXeLvSGOipdG8nHerQFC0j4I7SuPw/l933CHucgeToDogvuTf3zyf82MHuZkEDRu0yKnY/hAFSYonroC0R/bjoNt0yRIAgmUWVy5DfxcS54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110676; c=relaxed/simple;
	bh=MBFCW274J0YqTTxvu3B4tCqGsCfhBgX47D2Q/GYGEqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQwC9l9L/SCqVholmU+eDDEX0CChrlfLe+UyNGiiWRLpjm5nSMWIPTv9YoZ+5hFMfTYNL4Xt1fC7U0e5qJuym/qAzXuC5Cag91UkaM5TYgf+MuvPAZADKDQSRkyuzzGWq+unrAhk2kJQEwRlg8WEWm3m0AaShXXHL/vv7kBFPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXOPQRE7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b0d25b54eso2102301e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717110672; x=1717715472; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5rtVeYQ5u84CD0AA2JcRrrPlaJCkNb/Fj7mnCC/lgjg=;
        b=NXOPQRE7bVcUXqATFyFTvlycGAV6aTQ25lNZHPJbocPea2960r7zbxoUyBxEq16yQy
         /t4rhX1Htr7vkIL/KOu5EEh9Xd3dD34B4vll3RRAQgG8ItPS79ux2GFFboukoaS9FrMR
         JPPXZ9W6TpN4zAAqKPKqOjqJrUtzqnxsloTAcnKXT6vXRtKFO+vkFuoH/09auRITC+lR
         TjpXSroDPgXzDi4CxzJPXkeQT2FZZNEIzrW5O4B4faT/RqjRfbUHvh6VYxvEt0qERXER
         aNdFGe6zXJBjokYMKZo272/8y6i8jbkXLAr0gPGl65prRiea3JOmCK83Lxuap8TSsdEp
         UI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717110672; x=1717715472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rtVeYQ5u84CD0AA2JcRrrPlaJCkNb/Fj7mnCC/lgjg=;
        b=r1XOZHCVGmzH5DORYNpLjPcZSWXCVBjU8xLAvZ/+yuZwlfXDyZr6VjkcmsxW/2olU1
         pnCUK+SC120RoN85pBTeYlbY/d/4RfhZfzXO3s/mf+mhGU0/q028gRANkLlCCItY5t3f
         S9BAmaVmLdj2D/sSYItzw8eWheSChhpDsw5aNdh7yK2B0p76IgiXjhU5zvDYOV0MmFCy
         e17lj3lPOHXlZO3kz5jbGethtQ1UCS8wkkw+BDUDbucAYrFK5Zvyh4BjDmqFNBcuGJtT
         y+vfJQ6c96OgEpXK4EhjB2jyrrbVATMxAU8sPsc9uoazIvvG2D1WuevTczovBeDvr+Dk
         d/Og==
X-Forwarded-Encrypted: i=1; AJvYcCVT/tJb12W7EpJaISfNdGUgmRvwBnRPsSV6lZ2L0j+dhN8pLH6jepR9qDqazFWMR8kglPrpmbwmXYtsLcE/agp56V08S0yz4qI/dRkN
X-Gm-Message-State: AOJu0YxKtLPP31h9wyBrQmwkifCeO1nVRnWDo6k+q5H/4WIMRdOYwCA2
	27HTAk06gHJ3BJdNFTXQwiJh4oDooupSmXCqW041aPA1FVbxYURtXx1BQaP53t0=
X-Google-Smtp-Source: AGHT+IG0t3rZTPhtJybKaUF15LVmYhDBWgz6POuiQcknG9wUsiCJYYjByHxxMrF/IH17dhoIvEgTyA==
X-Received: by 2002:ac2:51b0:0:b0:51f:9549:9c0d with SMTP id 2adb3069b0e04-52b895a4043mr42465e87.48.1717110671620;
        Thu, 30 May 2024 16:11:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d34d76sm120623e87.10.2024.05.30.16.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:11:11 -0700 (PDT)
Date: Fri, 31 May 2024 02:11:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH v2 1/3] drm/panel-edp: add fat warning against adding new
 panel compatibles
Message-ID: <kxfuvsmi6eblpavtevwllqmkdnzdih7kfc73wlos7yozikerjv@si6jshczffjy>
References: <20240529-edp-panel-drop-v2-0-fcfc457fc8dd@linaro.org>
 <20240529-edp-panel-drop-v2-1-fcfc457fc8dd@linaro.org>
 <CAD=FV=Uw+KYQQ2xFLhNdWSW0sNX9uV_zSAVO2uBWY4JEcaO2bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Uw+KYQQ2xFLhNdWSW0sNX9uV_zSAVO2uBWY4JEcaO2bA@mail.gmail.com>

On Thu, May 30, 2024 at 07:33:59AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, May 28, 2024 at 4:52 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Add a fat warning against adding new panel compatibles to the panel-edp
> > driver. All new users of the eDP panels are supposed to use the generic
> > "edp-panel" compatible device on the AUX bus. The remaining compatibles
> > are either used by the existing DT or were used previously and are
> > retained for backwards compatibility.
> >
> > Suggested-by: Doug Anderson <dianders@chromium.org>
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
> > +        *
> > +        * In all other cases the platform should use the aux-bus and declare
> > +        * the panel using the 'edp-panel' compatible as a device on the AUX
> > +        * bus. The lack of the aux-bus support is not a valid case. Platforms
> > +        * are urged to be converted to declaring panels in a proper way.
> 
> I'm still at least slightly confused by the wording. What is "the lack
> of the aux-bus support". I guess this is different from the valid
> reason of "the platform which uses the panel didn't wire up the AUX
> bus properly" but I'm not sure how. Maybe you can explain?
> 
> I guess I'd write it like this:
> 
>     /*
>      * Do not add panels to the list below unless they cannot be handled by
>      * the generic edp-panel compatible.
>      *
>      * The only two valid reasons are:
>      * - because of the panel issues (e.g. broken EDID or broken
>      *   identification).
>      * - because the platform which uses the panel didn't wire up the AUX
>      *   bus properly. NOTE that, though this is a marginally valid reason,
>      *   some justification needs to be made for why the platform can't
>      *   wire up the AUX bus properly.
>      *
>      * In all other cases the platform should use the aux-bus and declare
>      * the panel using the 'edp-panel' compatible as a device on the AUX
>      * bus.
>      */
> 
> What do you think? In any case, it probably doesn't matter much. The
> important thing is some sort of warning here telling people not to add
> to the table. In that sense:

Ack, I'l update the wording in a similar way.

> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

-- 
With best wishes
Dmitry

