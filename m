Return-Path: <linux-kernel+bounces-208681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FF7902811
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391CA1F234A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EDF14A0A0;
	Mon, 10 Jun 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oq+g2w3r"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1D147C74
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042056; cv=none; b=mtC63aiOU0Hlclb/4UZYv6NnrpTBNfaJLlaoRUwzBnAMFYs6y8+wn4yFGsvqerCEtMUFw8xA2m9ncSiDrAhlw/PoT7uXw8l4QDByG1JC5XxD/IXGUcPt6YOl/skKy/jcDZZJUCMUY7O3M7/lETHK71oHzsvi8fnwMKVXwzNv1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042056; c=relaxed/simple;
	bh=DqlBReCntRkAfjMiyGre5joFM/nIKurevFFUxsbH+wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZRNGPicS7SBe/zZaHjgPiCgXyiYEcBa3nuHLiXp1jz5SmRG9HFVUQB1sRC+rKNm24OL6PZxSyZzdTiCdjXoz2ZkcvC16EJHdq+epFJVnc0teHEBIc6zFK86hOAcF4x2eqFpbkkXVJT77XYHKHZFdjPWAB0nTfTHd/JRe4sd2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oq+g2w3r; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c8ddc2b29so271677e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718042051; x=1718646851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WF40KLAkximrjsTW3ssqoGFaQBR69JrpW4FxsMvcSc4=;
        b=oq+g2w3rvYjbcePI/dP/HsHVRcST7cXHa2jnA0oC9PT33a/Pd5OLUxJc5NUiH32wwp
         VhdCD4NepjeYsR6HOJWdck3QCsKwf9ktW+XYMvd4YC6HIOc8ihNGHFuXVGe3VbPynAr9
         oXUoYc9bSOwz1PedsZrMNP50Xgjtp4AWjT8MP9n5uCJ0RjPE3sIk2j0mWJRHTn39tutq
         cSkN7XRJvic/OynE+KdV7tARAMOiu0q8P3vXPVcxpnr9PLPHE0oiKOgWDXCkVIT3gTkV
         z7VXM0sJ5fQ4FYeWRoaQkFSuMk3dlF9E/PmFz6xNxROR5lH/fHTM/gzxBjjcKQIx588q
         aE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042051; x=1718646851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF40KLAkximrjsTW3ssqoGFaQBR69JrpW4FxsMvcSc4=;
        b=iqUyZMTQ1Qpnz0JDhm6trz8xSbSLIoac5T1ttkPaCTqHMq1lGUXqmQ4O+iEyh0eStP
         ndGjE1LEK6RiPaZIOx5PlV2D5opuAtf52lvdFIROZa02UR30RwXsSMzJHALZvZaxg2kQ
         het6b7t7lsvHnN08unJy5Q38RteripHDrM8JRY+U8IkECLtKlJNj+hcL/zTAGH3+Htjd
         pSl+16gxFRmpFXiyqwUDinoKIxzZqTBFGwBcmduKLzpeVjMEoX0ar7LJ5QJKTRSaabMO
         cGkd/EtkNfhhacINq0yXhbvjOuw2NGutr0/ZSqr03rjcmJmmGXUYapwjNiKL95P6tniT
         rLgg==
X-Forwarded-Encrypted: i=1; AJvYcCXc+Pp5hEdDWa+uHRxQ4lVofOCYl4Boj1vT2fOOpRmZAIJ2tiFwxpkMTe3OsqP+msvFHkQzlge+bHW3R13aSeDTdugTeDjpUnjHf1wa
X-Gm-Message-State: AOJu0YyQDxGuIe2hY9HS22xMh27AtsPZleu8V51yvx73htJcVqlZCpYb
	An/ygJhWNElpZXch0iv18V+XP2sJj3XtV7RBZOYaP7p9rwM+dNNkPQOHEa/RlT4=
X-Google-Smtp-Source: AGHT+IEmuXhTm5mdM3lvjSvOFZmrX8S9MxFYd5t2YIYtjO2PNmSKP1Vp9kngKdCZNYrU6DsbsjCmsA==
X-Received: by 2002:ac2:490b:0:b0:52c:8079:b264 with SMTP id 2adb3069b0e04-52c8079b896mr4288403e87.9.1718042051388;
        Mon, 10 Jun 2024 10:54:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c8f4f52c1sm431573e87.266.2024.06.10.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:54:10 -0700 (PDT)
Date: Mon, 10 Jun 2024 20:54:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/9] drm/bridge-connector: switch to using drmm
 allocations
Message-ID: <t5pav3up5r6ezs4q37lc7jqlv55ftta7fnntp75b4pjboycwsm@uvs7q6frrzf5>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
 <20240607-bridge-hdmi-connector-v5-2-ab384e6021af@linaro.org>
 <20240610-secret-rottweiler-from-asgard-132f75@houat>
 <CAA8EJpogi2qm0bhCwumY4zj-xMUkF4zbK-NAPqCeDbLcybFciw@mail.gmail.com>
 <20240610-smooth-liberal-guan-59853e@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610-smooth-liberal-guan-59853e@houat>

On Mon, Jun 10, 2024 at 02:07:06PM +0200, Maxime Ripard wrote:
> Hi,
> 
> +Hans
> 
> On Mon, Jun 10, 2024 at 02:46:03PM GMT, Dmitry Baryshkov wrote:
> > On Mon, 10 Jun 2024 at 11:04, Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Jun 07, 2024 at 04:22:59PM GMT, Dmitry Baryshkov wrote:
> > > > Turn drm_bridge_connector to using drmm_kzalloc() and
> > > > drmm_connector_init() and drop the custom destroy function. The
> > > > drm_connector_unregister() and fwnode_handle_put() are already handled
> > > > by the drm_connector_cleanup() and so are safe to be dropped.
> > > >
> > > > Acked-by: Maxime Ripard <mripard@kernel.org>
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >  drivers/gpu/drm/drm_bridge_connector.c | 23 +++++------------------
> > > >  1 file changed, 5 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> > > > index 982552c9f92c..e093fc8928dc 100644
> > > > --- a/drivers/gpu/drm/drm_bridge_connector.c
> > > > +++ b/drivers/gpu/drm/drm_bridge_connector.c
> > > > @@ -15,6 +15,7 @@
> > > >  #include <drm/drm_connector.h>
> > > >  #include <drm/drm_device.h>
> > > >  #include <drm/drm_edid.h>
> > > > +#include <drm/drm_managed.h>
> > > >  #include <drm/drm_modeset_helper_vtables.h>
> > > >  #include <drm/drm_probe_helper.h>
> > > >
> > > > @@ -193,19 +194,6 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
> > > >       return status;
> > > >  }
> > > >
> > > > -static void drm_bridge_connector_destroy(struct drm_connector *connector)
> > > > -{
> > > > -     struct drm_bridge_connector *bridge_connector =
> > > > -             to_drm_bridge_connector(connector);
> > > > -
> > > > -     drm_connector_unregister(connector);
> > > > -     drm_connector_cleanup(connector);
> > > > -
> > > > -     fwnode_handle_put(connector->fwnode);
> > > > -
> > > > -     kfree(bridge_connector);
> > > > -}
> > > > -
> > > >  static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
> > > >                                             struct dentry *root)
> > > >  {
> > > > @@ -224,7 +212,6 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
> > > >       .reset = drm_atomic_helper_connector_reset,
> > > >       .detect = drm_bridge_connector_detect,
> > > >       .fill_modes = drm_helper_probe_single_connector_modes,
> > > > -     .destroy = drm_bridge_connector_destroy,
> > > >       .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> > > >       .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > > >       .debugfs_init = drm_bridge_connector_debugfs_init,
> > > > @@ -328,7 +315,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> > > >       int connector_type;
> > > >       int ret;
> > > >
> > > > -     bridge_connector = kzalloc(sizeof(*bridge_connector), GFP_KERNEL);
> > > > +     bridge_connector = drmm_kzalloc(drm, sizeof(*bridge_connector), GFP_KERNEL);
> > >
> > > So you make destroy's kfree call unnecessary here ...
> > >
> > > >       if (!bridge_connector)
> > > >               return ERR_PTR(-ENOMEM);
> > > >
> > > > @@ -383,9 +370,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> > > >               return ERR_PTR(-EINVAL);
> > > >       }
> > > >
> > > > -     ret = drm_connector_init_with_ddc(drm, connector,
> > > > -                                       &drm_bridge_connector_funcs,
> > > > -                                       connector_type, ddc);
> > > > +     ret = drmm_connector_init(drm, connector,
> > > > +                               &drm_bridge_connector_funcs,
> > > > +                               connector_type, ddc);
> > >
> > > ... and here of drm_connector_cleanup.
> > >
> > > drm_connector_unregister wasn't needed, so can ignore it, but you leak a reference to
> > > connector->fwnode since you don't call fwnode_handle_put anymore.
> > >
> > > We should register a drmm action right below the call to fwnode_handle_get too.
> > 
> > But drm_connector_cleanup() already contains
> > fwnode_handle_put(connector->fwnode). Isn't that enough?
> 
> It does, but now I'm confused.
> 
> drm_bridge_connector_init takes a reference, drm_connector_init doesn't.
> It will call drm_bridge_connector_destroy() that gives back its
> reference (which makes sense to me), but then why do
> drm_connector_cleanup() does? None of the drm_connector code even took
> that reference, and we end up with a double-put.
> 
> It looks like it was introduced by commit 48c429c6d18d ("drm/connector:
> Add a fwnode pointer to drm_connector and register with ACPI (v2)") from
> Hans, which does call put, but never gets that reference.

The mentioned patch documents that pretty clearly:

* Drivers can set this to associate a fwnode with a connector, drivers
* are expected to get a reference on the fwnode when setting this.
* drm_connector_cleanup() will call fwnode_handle_put() on this.

This is logical. Whoever sets the drm_connector::fwnode pointer, should
get reference. This way drm_connector_init() doesn't need to play with
the reference counting. The cleanup code drops the reference (so the
driver doesn't need to), because cleanup might be assynchronous..

The drm_bridge_connector follows this approach: it sets
drm_connector->fwnode, so it gets the reference. It uses
drm_connector_cleanup(), so it doesn't need to put it.

> 
> It has nothing to do with this series anymore, but that's super fishy to
> me, and the source of bugs as we can see here.

-- 
With best wishes
Dmitry

