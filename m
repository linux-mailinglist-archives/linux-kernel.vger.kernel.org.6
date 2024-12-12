Return-Path: <linux-kernel+bounces-443301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8A59EEC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB89162E13
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328CE215F6A;
	Thu, 12 Dec 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="L274nxtG"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36591487CD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017377; cv=none; b=cgZhnJYUqgkm4vDRy5OTJ8egbPjcjzmKv9WK6qsH6YoiFUGBOyWg90TjEMZhYBf77/VuzZ95KrbzuHAtFS2r6cqJ3JkMsg4hJt0cSReLx3cAhaIumX/gH2hOXLTUFLmxxHW07RPiUroFlM7k2zcmKQryobzhEA0GydPn37nQr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017377; c=relaxed/simple;
	bh=cO3T9dgduvkZxGXn30oD+wPkEkryxD08Sy8NbQMoMhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlhnWYmb8y3hz+3lRKPgQrnoMcTBgkg4uv5rZ4AuFxarhREt2fW42KVh6Y29YADZnI36aWoolKO9uNmbp3CxUQ5iXIBDEwt+ekodE59BZnrysdynWCoLdNxUz7uLRQKVhFN1iQgoZY6NHPOJMsccY5C3JF+3fDQYGsevBA7bMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=L274nxtG; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e388503c0d7so443769276.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734017374; x=1734622174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ziTdzSVRBojAh7UOXHpRETilYMYbJPc01s+yNskJcaw=;
        b=L274nxtGs6mw+BsK9bymar9jDd13SAxCiF3MF1+5Qei+MKrlipKliG0qv4FSbxdGKv
         qi4WM3aEYGkHemAw7ZR7lwt8LBW5bGcwCRhzEth8bjSaXA43WO16r5EBqeJkZJGEmNSO
         0rtU3fxWp7m+QpfS5E4cOdp7VU70oxqDDqe8OvXo6vN+ykCXub0Cv27uVOcr9W8J739z
         4U6Mdoir7tRpNIYELbYPL9EnAwkOSN7p/xb2hsy4hczQ8j8TShVO7SA6iG22z60lEi+q
         ywK0fVZKPZEL9Sk9FW8SxlcW+x1rHCQvgk329UV0dsl6rBUBlowxi+cDsNqkuaPTcajp
         AJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734017374; x=1734622174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziTdzSVRBojAh7UOXHpRETilYMYbJPc01s+yNskJcaw=;
        b=an6PrsVHdLZsDoAylr+avZeBmA0IADuQX1EnYhJDCc56Kn3/rUksV8InpBGJI87VLm
         vQdRUrLZmN0PnyixKaCPZLT0DUgVtiYxhyEN0NzP6Q1oYz7sMmlWBCGkNN3ilVSQ4u1a
         YODmcwSsw6XNipu5cgCYYVV1H0CvUGmWyuHSAhjbwXaizpoR3MkR0mJbe3mSnZdzbA/R
         OrnajDaKGDCNQkCTo0HlUGDM+wFizYHzZ2SPR+e6BLdI4KlS75ZEcEJfIyBMwCt87XR+
         wg9AzLu8xFfFnmpnUvxb0P7cL8sKCc2qa3pY9jxjjFD1ds9yg6VnVibn+1pzyXo+Ma93
         bE7w==
X-Forwarded-Encrypted: i=1; AJvYcCWGbRkiLXiWtudVqezp7CkrNfe0IqrXAMouTy2EBYKplmnnLYK8gcUYazrHNzak+Tw5b5CpfA90hcOOZKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ4Zo3ktsjvlX/Bsu+gcugKOI6cuWT4PRl+qQv3vXr7rApq8xk
	TyA4etG/gYPQ4iEsMyOHhNHioL9wH5YaFfl6J/ulr1OEwIl4Rdd8QS0T0DaqzFY+bxBMqPULd7e
	gQIng+m+rtvwXnbLNf3JEKGJrj2fkZprbGe1MBw==
X-Gm-Gg: ASbGncs6rGq8gHoxRqTOL6yyKVpWxH4Hauc+CUjrQ4GYXsx+vlB8IT3haOs3fpDMMnH
	klxewoSPeCram1h0xpG+eOLTClZ5oUt6cvtHsHA==
X-Google-Smtp-Source: AGHT+IHSTvaRuk1a2h/8SW5H+X92KkYTlzLgic62LoMhq1Fpy7zQqRHv7pSca18JZvBcyW3l9eExwNR4jPCmNVbk61k=
X-Received: by 2002:a05:6902:118b:b0:e35:dac9:bd5a with SMTP id
 3f1490d57ef6-e41c3620479mr965142276.25.1734017374713; Thu, 12 Dec 2024
 07:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b61a81b2-0101-43bd-a4f6-09cf3a016484@stanley.mountain> <CAPY8ntBkQ9PrNx51g+W6TPTLhFjQrTC1vitbV6TVCwq8GUOLwA@mail.gmail.com>
In-Reply-To: <CAPY8ntBkQ9PrNx51g+W6TPTLhFjQrTC1vitbV6TVCwq8GUOLwA@mail.gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 15:29:15 +0000
Message-ID: <CAPY8ntDSi5hHWX8fUoiVq93n6bnwu+PVE3JYDxDi=0rGudvm2g@mail.gmail.com>
Subject: Re: [PATCH v2 next] drm/vc4: unlock on error in vc4_hvs_get_fifo_frame_count()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 14:33, Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> On Thu, 12 Dec 2024 at 12:47, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The default statement is never used in real life.  However, if it were
> > used for some reason then call drm_dev_exit() before returning.
> >
> > Fixes: 8f2fc64773be ("drm/vc4: Fix reading of frame count on GEN5 / Pi4")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Applied to drm-misc-next

> Thanks for the update.
>   Dave
>
> > ---
> > v2: style fixes
> >
> >  drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> > index b42027636c71..4811d794001f 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> > @@ -522,7 +522,7 @@ u8 vc4_hvs_get_fifo_frame_count(struct vc4_hvs *hvs, unsigned int fifo)
> >                 break;
> >         default:
> >                 drm_err(drm, "Unknown VC4 generation: %d", vc4->gen);
> > -               return 0;
> > +               break;
> >         }
> >
> >         drm_dev_exit(idx);
> > --
> > 2.45.2
> >

