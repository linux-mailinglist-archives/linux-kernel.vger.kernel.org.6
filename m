Return-Path: <linux-kernel+bounces-211870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1EF905827
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB5F282AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB816EC13;
	Wed, 12 Jun 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hKDCRm6n"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1091B65E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208477; cv=none; b=d3T/iLQcAY+JIkkPtrDuwemki2I/+GlEbYZP8QisDLAxeX6RPRYx2bokpI8kkcRamHLfdqaWYhFMjpy0ZiXt23KwFRg3qJtZyu0dE6E9k7upcnvg0xflCrIX2UGfXRyBIN+LGmOxSU6TB1vO90y7WSYhg8kNF538l2kt+i9NG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208477; c=relaxed/simple;
	bh=XdHqsH/9uv1tCEVQ17AGLi+mANthbEEVXcLIzOA8ZAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrkfahFIDKVCjgfTQBXDRD1QatGJUIVsdPKqtRjCf52YZ7BdF6DCq0gFD6++YbTF9ZIkPiUgM4fTbZOv+Me7s+TgXNT4VsOFvUJ/BsVYk5kmvhZgI4U3ta7L6UQ7a/TwtjAS/VleZEn6wjnjjuRghsduDEQWwBRotTHtl7Rb5Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hKDCRm6n; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso5340676a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718208474; x=1718813274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IqehpmeT3Gvcj7Szl/e6rWIKHCUYKVZi38Av+Wl/SE=;
        b=hKDCRm6n1vwYt0zMV2oBcxdb/Y+MFWyUWLFMiDZStr0l6PJkKi0/EYO6di6KrqUAL0
         MsfWc1XxyeYjijlSQD0fEgN02h61TVx3InC9a05KGILAh0FBTzi3jnE0UOPbVk1et1E3
         qZoEf6fCScspounQtNFb2qcBoULou+dVU6tU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208474; x=1718813274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IqehpmeT3Gvcj7Szl/e6rWIKHCUYKVZi38Av+Wl/SE=;
        b=SZwQ4LJ6dkp4urTYtBCiXf40Y1aOIe9fBdTTWhGv5/Pr2Kn5jvPbkzx1kXEeiVHQLx
         yawCld6kQZS3iuOqToTggOXvNqMGZkK9aaQGLybpB8obczCt8soksvXCQTU+A6JQt1Cp
         IsITX3kE+DbKQ9Ay71hkCSJsdLabmePRQjC+NUGT7BoV5WEM2ZklJH8VttELOkxC+49j
         CEDk06JGU7ZNoAPyyI6XyBnu0kR5hLcv0TDxb48Gok/0GWPhbKKoYx3m/fWulbKe3cAt
         JRnR0aJOlyghXiVf2pTGR/BsYaceh0666eJHdfrGYIC2mBxly6+a2DmsQmUo8nNQCjeh
         UZLg==
X-Forwarded-Encrypted: i=1; AJvYcCVyzExvYT7aCbcrgjVCSENa6aaOH8YIzEFKJwt0A1OgQTIbRSF9lgVEs3nghA6xyDPV3GOre0MYSeU00IasttiH1wfDg5nwYzWR2kg3
X-Gm-Message-State: AOJu0YzIoW0CF5mMd9R8iN8Ouk9rQYnKe8xa5Az84qiG9g0OrjCEbtAR
	xm1C5FIv4s2Lcks60CEzGkdN+669sNwPWq4HVRltb9zTdSbHSt0SZsclcYYEiLRPuRUpkM6dC9U
	=
X-Google-Smtp-Source: AGHT+IH2aUehNqTrU7Mye8fb9PSOxuCk6wFD0sRvjoZEP3F5GxUTVeqNt/a9DQp8yYUDfMmCAb6yWw==
X-Received: by 2002:a17:903:2292:b0:1f4:a6cb:db3d with SMTP id d9443c01a7336-1f83b710aa7mr29990805ad.44.1718208474373;
        Wed, 12 Jun 2024 09:07:54 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com. [209.85.214.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f2c825e9sm84420055ad.291.2024.06.12.09.07.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:07:54 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso188765ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:07:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW19TK77rc3lekpIRqpIpYBK8VwuVh+f+IO0W78XWY6OPrmOQrZRgczqShRkv9CVcEBCeAhZi599zPfN3cTau0dTVz/TyTKj0T9v2fz
X-Received: by 2002:a05:622a:2612:b0:441:4878:1238 with SMTP id
 d75a77b69052e-44158bc73f9mr4776301cf.8.1718208042481; Wed, 12 Jun 2024
 09:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611074846.1.Ieb287c2c3ee3f6d3b0d5f49b29f746b93621749c@changeid>
 <ZmljNHteJ9L5EdE9@phenom.ffwll.local> <CAD=FV=V4C1AYVqG4gig+SiQr4n_mAPVASxneDDZT1a=7AY3Hzw@mail.gmail.com>
 <20240612-lean-intrepid-sponge-bb30e6@houat>
In-Reply-To: <20240612-lean-intrepid-sponge-bb30e6@houat>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 09:00:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgJ6GNgEfjATYMVE=T8yFtZTjNMM2bK0pfUepdJxFkRg@mail.gmail.com>
Message-ID: <CAD=FV=XgJ6GNgEfjATYMVE=T8yFtZTjNMM2bK0pfUepdJxFkRg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown
To: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 8:03=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> > > Why does something like this now work?
> > >
> > > drm_panel_shutdown_fixup(panel)
> > > {
> > >         /* if you get warnings here, fix your main drm driver to call
> > >          * drm_atomic_helper_shutdown()
> > >          */
> > >         if (WARN_ON(panel->enabled))
> > >                 drm_panel_disable(panel);
> > >
> > >         if (WARN_ON(panel->prepared))
> > >                 drm_panel_unprepare(panel);
> > > }
> > >
> > > And then call that little helper in the relevant panel drivers? Also =
feel
> > > free to bikeshed the name and maybe put a more lengthly explainer int=
o the
> > > kerneldoc for that ...
> > >
> > > Or am I completely missing the point here?
> >
> > The problem is that the ordering is wrong, I think. Even if the OS was
> > calling driver shutdown functions in the perfect order (which I'm not
> > convinced about since panels aren't always child "struct device"s of
> > the DRM device), the OS should be calling panel shutdown _before_
> > shutting down the DRM device. That means that with your suggestion:
> >
> > 1. Shutdown starts and panel is on.
> >
> > 2. OS calls panel shutdown call, which prints warnings because panel
> > is still on.
> >
> > 3. OS calls DRM driver shutdown call, which prints warnings because
> > someone else turned the panel off.
> >
> > :-P
> >
> > Certainly if I goofed and the above is wrong then let me know--I did
> > my experiments on this many months ago and didn't try repeating them
> > again now.
> >
> > In any case, the only way I could figure out around this was some sort
> > of list. As mentioned in the commit message, it's super ugly and
> > intended to be temporary. Once we solve all the current in-tree
> > drivers, I'd imagine that long term for new DRM drivers this kind of
> > thing would be discovered during bringup of new boards. Usually during
> > bringup of new boards EEs measure timing signals and complain if
> > they're not right. If some EE cared and said we weren't disabling the
> > panel correctly at shutdown time then we'd know there was a problem.
>
> Based on a discussion we had today With Sima on IRC, I think there's
> another way forward.
>
> We were actually discussing refcount'ing the panels to avoid lifetime
> issues. It would require some API overhaul to have a function to
> allocate the drm_panel structure and init'ing the refcount, plus some to
> get / put the references.
>
> Having this refcount would mean that we also get a release function now,
> called when the panel is free'd.
>
> Could we warn if the panel is still prepared/enabled and is about to be
> freed?
>
> It would require to switch panel-simple and panel-edp to that new API,
> but it should be easy enough.

I think there are two problems here:

1. The problem is at shutdown here. Memory isn't freed at shutdown
time. This isn't a lifetime issue. No release functions are involved
in shutdown and we don't free memory then.

2. As I tried to point out, even if we were guaranteed the correct
order it still doesn't help us. In other words: if all device links
were perfect and all ordering was proper then the panel should get
shutdown _before_ the DRM device. That means we can't put a check in
the panel code to see if the DRM device has been shutdown.


-Doug

