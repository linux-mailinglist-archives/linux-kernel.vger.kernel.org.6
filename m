Return-Path: <linux-kernel+bounces-208097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD1902099
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C1B20B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7B87EEF5;
	Mon, 10 Jun 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8dUo9Ad"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BDB7E103
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019977; cv=none; b=R1F/0Kv5YdRmA/BbqxV+eKShUMTRyaZBuTrmDkPuVdKB3B/UGQDk3YHGN9oAULzl/ePwTbjvSXZuXxDnd9SmtMmAuX31cL/RTlIRMIPaFE9fEfHePf+1j99pOWO4VxyGm4cznTnSKyzGK2Ww1A0Dv+pEqvauxt/ciyq/AFpUaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019977; c=relaxed/simple;
	bh=euJKBP0BTUasb5iwo16OMHsaHKsK2u0WdU7AvYTzRfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSxeDVz2cY3ktJXfD5+ErWKk2M5vWZ18vJBCRhuYb15kEfeP8f0z+jmM+9rv4lDWPqQMwv2SKLQDZyJC1N6viwAdNG1GIaCbdbSSzxIS0zcrR9oQK4YCfw4IUjysg/Fa8E4YYSXl5lj2ovv0Ru6LWd3RZDr9jtztKp2WeUHHK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8dUo9Ad; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62ceb6a4e97so19929117b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718019975; x=1718624775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2iK4IsuByPlunVBIPa84PXOTmIsAWUdTQwWl9Bv3pV0=;
        b=c8dUo9AdL1CHiAa9zsECMAp3MdemMhXGklR/xickcbZyRGfCmhudx09GvP212wBxWG
         PaAnGE7syOUeuTzKkspRrekdwvV6QGWcZFT43dlQzbV+K0SM7O2Z+fNvqbVH4huLx2cc
         NWQrn9wf7o6DRlLtLreOYb5l0ptuZtFh1g8OVYUpiPCX0gN2Q49QACVqyec50skKd/3S
         K+aF3q0PqgomgEMRGiF4J0veE1Q7F6hD5R4XETAmJloih9DAKYAdTQmDbljgmAT3D2aN
         YPgZbvuQ52NqE4d66UA9fuHNM5k3lz+jTUxzdfixe38Ny9H0F41UyQQJovYoouK8mPu4
         FHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718019975; x=1718624775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iK4IsuByPlunVBIPa84PXOTmIsAWUdTQwWl9Bv3pV0=;
        b=lVJshAunorkGLoIEFll717J0HBUQqEuIO6ia09JF30Fko1RsB0hFjk2vDRThrJHWmu
         9VjOlpFJdaajrQipDSJapHYbi3ZyRb6FTnf+PxQ62mUNx9z17UUcqDL9w8njg5OqzRvl
         fFQ6VfSC+KRrvZV9DolvHASf5HtSLf5LEfy99HaHm2SCduZ/aycysj9P6U4lt25UTm3Q
         clUYUe0mxpU5j51w6E1gLbiY5Rkzzu+cuvD8CcBwoszaFWVq9BdHsTGHQEgvjzjiLBY8
         MDuKi2jfChyxFuUfrHfQeveh4VfHGlRmGc1YAOXadPtjyZtL5fBY2RvzI85ONNmfrz9e
         20/g==
X-Forwarded-Encrypted: i=1; AJvYcCVkrEAumf9aScncwPtuN/4vzU7AYTpwUv549F9DwMyHyMT2zzXxt2A9CGGXMgU7EkxqQYrK4kCPuaLwi5RRa9iQ3eYbvIv2K/VIPfZK
X-Gm-Message-State: AOJu0YxDA/59hB8e1ubLEVE/BB2GQI8t57Rghl7wljnYrMEUlpA3ztmT
	cw9mT4vKMfLEcjREMjQePoLfR9XKMHN0/K6WTqYJ63xVrUJuKS86nMSmAMxqSpbNLl0/e1oskuw
	FCDqRAa9lH6H7mXgXTjsG2ukiVOMGrqxVMTVG7A==
X-Google-Smtp-Source: AGHT+IFZa6J3mLfqVUkpGGClIfKkW9vivB5JAUacLCndpp+3DPNDSo8Ic0JsWYFR5j3gWxpjXglCS4Uiwbvy9b7NS3Q=
X-Received: by 2002:a0d:d403:0:b0:617:d49f:d5b9 with SMTP id
 00721157ae682-62cd55cc44emr86886597b3.14.1718019974751; Mon, 10 Jun 2024
 04:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
 <20240607-bridge-hdmi-connector-v5-2-ab384e6021af@linaro.org> <20240610-secret-rottweiler-from-asgard-132f75@houat>
In-Reply-To: <20240610-secret-rottweiler-from-asgard-132f75@houat>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 10 Jun 2024 14:46:03 +0300
Message-ID: <CAA8EJpogi2qm0bhCwumY4zj-xMUkF4zbK-NAPqCeDbLcybFciw@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] drm/bridge-connector: switch to using drmm allocations
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 11:04, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> On Fri, Jun 07, 2024 at 04:22:59PM GMT, Dmitry Baryshkov wrote:
> > Turn drm_bridge_connector to using drmm_kzalloc() and
> > drmm_connector_init() and drop the custom destroy function. The
> > drm_connector_unregister() and fwnode_handle_put() are already handled
> > by the drm_connector_cleanup() and so are safe to be dropped.
> >
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/drm_bridge_connector.c | 23 +++++------------------
> >  1 file changed, 5 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> > index 982552c9f92c..e093fc8928dc 100644
> > --- a/drivers/gpu/drm/drm_bridge_connector.c
> > +++ b/drivers/gpu/drm/drm_bridge_connector.c
> > @@ -15,6 +15,7 @@
> >  #include <drm/drm_connector.h>
> >  #include <drm/drm_device.h>
> >  #include <drm/drm_edid.h>
> > +#include <drm/drm_managed.h>
> >  #include <drm/drm_modeset_helper_vtables.h>
> >  #include <drm/drm_probe_helper.h>
> >
> > @@ -193,19 +194,6 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
> >       return status;
> >  }
> >
> > -static void drm_bridge_connector_destroy(struct drm_connector *connector)
> > -{
> > -     struct drm_bridge_connector *bridge_connector =
> > -             to_drm_bridge_connector(connector);
> > -
> > -     drm_connector_unregister(connector);
> > -     drm_connector_cleanup(connector);
> > -
> > -     fwnode_handle_put(connector->fwnode);
> > -
> > -     kfree(bridge_connector);
> > -}
> > -
> >  static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
> >                                             struct dentry *root)
> >  {
> > @@ -224,7 +212,6 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
> >       .reset = drm_atomic_helper_connector_reset,
> >       .detect = drm_bridge_connector_detect,
> >       .fill_modes = drm_helper_probe_single_connector_modes,
> > -     .destroy = drm_bridge_connector_destroy,
> >       .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> >       .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> >       .debugfs_init = drm_bridge_connector_debugfs_init,
> > @@ -328,7 +315,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >       int connector_type;
> >       int ret;
> >
> > -     bridge_connector = kzalloc(sizeof(*bridge_connector), GFP_KERNEL);
> > +     bridge_connector = drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_KERNEL);
>
> So you make destroy's kfree call unnecessary here ...
>
> >       if (!bridge_connector)
> >               return ERR_PTR(-ENOMEM);
> >
> > @@ -383,9 +370,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >               return ERR_PTR(-EINVAL);
> >       }
> >
> > -     ret = drm_connector_init_with_ddc(drm, connector,
> > -                                       &drm_bridge_connector_funcs,
> > -                                       connector_type, ddc);
> > +     ret = drmm_connector_init(drm, connector,
> > +                               &drm_bridge_connector_funcs,
> > +                               connector_type, ddc);
>
> ... and here of drm_connector_cleanup.
>
> drm_connector_unregister wasn't needed, so can ignore it, but you leak a reference to
> connector->fwnode since you don't call fwnode_handle_put anymore.
>
> We should register a drmm action right below the call to fwnode_handle_get too.

But drm_connector_cleanup() already contains
fwnode_handle_put(connector->fwnode). Isn't that enough?


-- 
With best wishes
Dmitry

