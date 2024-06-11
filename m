Return-Path: <linux-kernel+bounces-209732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E014903A05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0C01C21B09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB21A17B42E;
	Tue, 11 Jun 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6NFR+yc"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D417A93A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105187; cv=none; b=EdvTwTaV4f9dVKm9X0Hs9OeNtTLf7nlY555/UZ6+rxZvaI99/zwyiHQtgY43oaiYdAyd7yKJa08uS4zmLKDGXCAFVolHNjGigxULUvtLijdBl9R/xa9BeQqritScoIjvFWUNZJdwSNeBZL8/vVLsNPPhrXQD9vqSADBx6z7w4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105187; c=relaxed/simple;
	bh=CfXhXO5gbKHP0O3Mzpd0IEhQ/0lBlGLlCDI26UoQxPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sd9Qf50X/kmPMqijsmuOujPmtE3LHTzu2JaT0g4iDY6JHiRJDdew0zDq/nkoOZ46OHfho1jd1lfFudjCPE9HF511IHEyvnTHDWrjsW8Xse8iGOEPf0QY6eXdx+FRt69GWkOJujU+Rt5WJrEoGxVUJfuP1UjLGGQAgYD7bS5Ab/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o6NFR+yc; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfaf512483dso905537276.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718105184; x=1718709984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nbepqfHXX8/ebWOQDHLQgzSo88cywSIGNBywsOUNYMQ=;
        b=o6NFR+yc1t4sTd2qgy7tR6VQXc11wh1j0izTn7LArNhpwj4SUomwcAW8PUau2zhSWS
         I6iNAIAh1ksVNASfe/Bho16x+OHEUTgBl5UwS9qKX8WTPrnmMPnXjIC3BCI8WashVKQw
         eeA4O9x2nPcwTBdlHilE5BrgOMDFvw2FCZ4eJxeATZ1JTK4qNbaMw1otz+zAsfGW3trL
         jWuBzfXMqpgYaeLZ5zOZ0/i9e2dgzD7bzxdLeaxyvIgWTMu5084bywGCkycid6dpUWcS
         cpFPTU6p1ulQg/2Q7kiOtIu5b5+Kvqq/lSudain3pZGuKG6G6x+d/F3pYf5tWgBCQkPK
         Gd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718105184; x=1718709984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbepqfHXX8/ebWOQDHLQgzSo88cywSIGNBywsOUNYMQ=;
        b=pfGBA5EN1NUgB2NAl8XA4uaZ2IL0UwVWqkm3tX8VE86mfvfjUeFnB9uAzHcnPbXKJL
         9idqnWyTFLWHjE525mUBQY1AuYw5rUAtnjSzXghadqkUEr2KjbE0tJSsFNTRaTzKaY6y
         5GdjjdMT+fk/xFIgT01nSCfMfgbsNiEGN0hG2Nb/qMCiCiUfMIfWOBdpq82SGdqRfoKK
         YUmpWcg5+LuXkpyHMtxEA2NjM06wVt94dy83ole++DP777r7TPMtPhgMmVxMTYwwXPVs
         TwLeU3HnGbmCnhr4ypmxyKe1q368FJYMzrS4ITpPM9EsqJ9DizdrCDHxiRh/gh/I9k8T
         q8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdkPlSh0SeHNOuz1Z0I0f7xNSBKUvve59daXDZgSE76sEovcFqLEwEvw5XcbFpkzutR01CMdPj8FKToJJFdmG19dj9swdhHP8mlj97
X-Gm-Message-State: AOJu0YxnH5WI34y+XiHPd+qrlFBM3a63+4joKRnLLAk1fpuGRj8djXW/
	pbh0RvqbARikpKlsny5c/X3qBeGmzKQuMyKLUYUjueEMBx9UgvO98Wy3k2jFLr4MQ4kK9RcFxGK
	nQiqBmfp3X/5kfxhZRe/5EFA5o0/ChzipNxzJcg==
X-Google-Smtp-Source: AGHT+IHPQBOTA1l+9Q6Mt11B/7brXJx2+reHInxEahmPdyYeu/oGfCOgbBJHGoEyCZWwwwFiHs2jDWDlq4TplfBFJxM=
X-Received: by 2002:a25:b11e:0:b0:dfa:fe33:713f with SMTP id
 3f1490d57ef6-dfafe337732mr10791981276.31.1718105183996; Tue, 11 Jun 2024
 04:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
 <20240607-bridge-hdmi-connector-v5-2-ab384e6021af@linaro.org>
 <20240610-secret-rottweiler-from-asgard-132f75@houat> <CAA8EJpogi2qm0bhCwumY4zj-xMUkF4zbK-NAPqCeDbLcybFciw@mail.gmail.com>
 <20240610-smooth-liberal-guan-59853e@houat> <t5pav3up5r6ezs4q37lc7jqlv55ftta7fnntp75b4pjboycwsm@uvs7q6frrzf5>
 <20240611-zippy-pragmatic-catfish-cceee5@houat>
In-Reply-To: <20240611-zippy-pragmatic-catfish-cceee5@houat>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 11 Jun 2024 14:26:12 +0300
Message-ID: <CAA8EJppcqLm7UbW9n2Y_4mfJv4JFWDkPXJ8=TBL53LiFPADzpQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] drm/bridge-connector: switch to using drmm allocations
To: Maxime Ripard <mripard@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 11:54, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Jun 10, 2024 at 08:54:09PM GMT, Dmitry Baryshkov wrote:
> > On Mon, Jun 10, 2024 at 02:07:06PM +0200, Maxime Ripard wrote:
> > > Hi,
> > >
> > > +Hans
> > >
> > > On Mon, Jun 10, 2024 at 02:46:03PM GMT, Dmitry Baryshkov wrote:
> > > > On Mon, 10 Jun 2024 at 11:04, Maxime Ripard <mripard@kernel.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Fri, Jun 07, 2024 at 04:22:59PM GMT, Dmitry Baryshkov wrote:
> > > > > > Turn drm_bridge_connector to using drmm_kzalloc() and
> > > > > > drmm_connector_init() and drop the custom destroy function. The
> > > > > > drm_connector_unregister() and fwnode_handle_put() are already handled
> > > > > > by the drm_connector_cleanup() and so are safe to be dropped.
> > > > > >
> > > > > > Acked-by: Maxime Ripard <mripard@kernel.org>
> > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > ---
> > > > > >  drivers/gpu/drm/drm_bridge_connector.c | 23 +++++------------------
> > > > > >  1 file changed, 5 insertions(+), 18 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> > > > > > index 982552c9f92c..e093fc8928dc 100644
> > > > > > --- a/drivers/gpu/drm/drm_bridge_connector.c
> > > > > > +++ b/drivers/gpu/drm/drm_bridge_connector.c
> > > > > > @@ -15,6 +15,7 @@
> > > > > >  #include <drm/drm_connector.h>
> > > > > >  #include <drm/drm_device.h>
> > > > > >  #include <drm/drm_edid.h>
> > > > > > +#include <drm/drm_managed.h>
> > > > > >  #include <drm/drm_modeset_helper_vtables.h>
> > > > > >  #include <drm/drm_probe_helper.h>
> > > > > >
> > > > > > @@ -193,19 +194,6 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
> > > > > >       return status;
> > > > > >  }
> > > > > >
> > > > > > -static void drm_bridge_connector_destroy(struct drm_connector *connector)
> > > > > > -{
> > > > > > -     struct drm_bridge_connector *bridge_connector =
> > > > > > -             to_drm_bridge_connector(connector);
> > > > > > -
> > > > > > -     drm_connector_unregister(connector);
> > > > > > -     drm_connector_cleanup(connector);
> > > > > > -
> > > > > > -     fwnode_handle_put(connector->fwnode);
> > > > > > -
> > > > > > -     kfree(bridge_connector);
> > > > > > -}
> > > > > > -
> > > > > >  static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
> > > > > >                                             struct dentry *root)
> > > > > >  {
> > > > > > @@ -224,7 +212,6 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
> > > > > >       .reset = drm_atomic_helper_connector_reset,
> > > > > >       .detect = drm_bridge_connector_detect,
> > > > > >       .fill_modes = drm_helper_probe_single_connector_modes,
> > > > > > -     .destroy = drm_bridge_connector_destroy,
> > > > > >       .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> > > > > >       .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > > > > >       .debugfs_init = drm_bridge_connector_debugfs_init,
> > > > > > @@ -328,7 +315,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> > > > > >       int connector_type;
> > > > > >       int ret;
> > > > > >
> > > > > > -     bridge_connector = kzalloc(sizeof(*bridge_connector), GFP_KERNEL);
> > > > > > +     bridge_connector = drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_KERNEL);
> > > > >
> > > > > So you make destroy's kfree call unnecessary here ...
> > > > >
> > > > > >       if (!bridge_connector)
> > > > > >               return ERR_PTR(-ENOMEM);
> > > > > >
> > > > > > @@ -383,9 +370,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> > > > > >               return ERR_PTR(-EINVAL);
> > > > > >       }
> > > > > >
> > > > > > -     ret = drm_connector_init_with_ddc(drm, connector,
> > > > > > -                                       &drm_bridge_connector_funcs,
> > > > > > -                                       connector_type, ddc);
> > > > > > +     ret = drmm_connector_init(drm, connector,
> > > > > > +                               &drm_bridge_connector_funcs,
> > > > > > +                               connector_type, ddc);
> > > > >
> > > > > ... and here of drm_connector_cleanup.
> > > > >
> > > > > drm_connector_unregister wasn't needed, so can ignore it, but you leak a reference to
> > > > > connector->fwnode since you don't call fwnode_handle_put anymore.
> > > > >
> > > > > We should register a drmm action right below the call to fwnode_handle_get too.
> > > >
> > > > But drm_connector_cleanup() already contains
> > > > fwnode_handle_put(connector->fwnode). Isn't that enough?
> > >
> > > It does, but now I'm confused.
> > >
> > > drm_bridge_connector_init takes a reference, drm_connector_init doesn't.
> > > It will call drm_bridge_connector_destroy() that gives back its
> > > reference (which makes sense to me), but then why do
> > > drm_connector_cleanup() does? None of the drm_connector code even took
> > > that reference, and we end up with a double-put.
> > >
> > > It looks like it was introduced by commit 48c429c6d18d ("drm/connector:
> > > Add a fwnode pointer to drm_connector and register with ACPI (v2)") from
> > > Hans, which does call put, but never gets that reference.
> >
> > The mentioned patch documents that pretty clearly:
> >
> > * Drivers can set this to associate a fwnode with a connector, drivers
> > * are expected to get a reference on the fwnode when setting this.
> > * drm_connector_cleanup() will call fwnode_handle_put() on this.
> >
> > This is logical. Whoever sets the drm_connector::fwnode pointer, should
> > get reference. This way drm_connector_init() doesn't need to play with
> > the reference counting. The cleanup code drops the reference (so the
> > driver doesn't need to), because cleanup might be assynchronous..
>
> Right, but it's the cleanup part that isn't logical. It makes total
> sense to have the connector that sets connector->fwnode get the
> reference itself. It doesn't make sense to have the core give that
> reference instead of the driver.
>
> It's confusing, because if the driver is supposed to handle its
> reference itself, then it should handle all of it itself. This bug is
> the testament for that: the natural approach is buggy.

I'd say this is the 'transfer of the ownership'. The base driver gets
the reference, and then gives it away to the drm_connecter. But indeed
this is not very intuitive.

I have looked at the original series by Hans/Heikky, but I don't seem
to be able to find a good way to solve that. The fwnode can be set
after initialising the drm_connector. And at the same time it doesn't
make so much sense to put that burden onto the driver. One option
might be to add drm_connector_set_fwnode() that will get the reference
internally, but that looks a bit like an overkill.

>
> > The drm_bridge_connector follows this approach: it sets
> > drm_connector->fwnode, so it gets the reference. It uses
> > drm_connector_cleanup(), so it doesn't need to put it.
>
> Yet, it calls fwnode_handle_put in its destroy path, because it grabbed
> a reference before.
>
> Maxime



-- 
With best wishes
Dmitry

