Return-Path: <linux-kernel+bounces-241307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB4927993
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CA828B833
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4F1AEFF5;
	Thu,  4 Jul 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/Dd3Vxs"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0627452
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105634; cv=none; b=Qk5+sc501xJphPifi/Lh17bcy38tcdsQHy0b+qYe8SW6wlag6cuZm4ojlhxcUiieI6u8GA+u6O2B3VdiCJ7IXz6f8XaRt9ERofmgd/jtUql5zGovO6bufJXewp3jZbE7Ev6SbzRcUoA9hldRkpDVZDyQiOALCNT86U2s/c1YPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105634; c=relaxed/simple;
	bh=0ImlFYbOufUcsisQKWXWQMDkLeeex6HeTL83swchfnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj2CDs244K0XWJ22shZhBU1/2O4GvIOGLQxpW0AaGB8vQq0Z17NLdBfzaSTKe1Oiby9Yk0F4GZ1xYel23QP1bPoUcNe4tu3XtHfWKRRswqBBFfsO9ef+NpUzwrzW82i2woZps6E5VYb2xsMucpfxbixv64uwBS165N4NvA1CsI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i/Dd3Vxs; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so798735276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720105632; x=1720710432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nnU2GZk3GvU2j9RUyPBjNitDac3G21CdBZm/Vv/gzjU=;
        b=i/Dd3Vxs+9U9viGDudtfWQenIRPxRT4DyAImHJZsL6iOfEZ075mYZdZXnpwykkt4yv
         9d9+KewvK2qE2QOfzq2xIQNj4Jde5x/EQxM0VBe89PP2N6lPRwviSHGLD8MQ8GIHkcqi
         BK9BcR8erKlbFuKelMfDYzZizFuqWbXW4h+adaM6oP7PfECnhSerIVCZtXq32+KhywAu
         11ksMNTZ2c2e+ZvblkAchqsmrfWUMvkA6UXHr9NaSIgfqj2q3IfgvGj/keJ+Wf2nZag1
         LASugRcyI9trRKYMZvINqWu6V8g7Orl1btoceNw1vpyGnPcQg470SHfJe4VymeKk4HIx
         U9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105632; x=1720710432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnU2GZk3GvU2j9RUyPBjNitDac3G21CdBZm/Vv/gzjU=;
        b=wwBp09UuapW4ODOWTfr5tUDDHWrEbdyJn6YzgQnuOllciLHahacubp2Qxh0CQb/GWO
         ZRRle/9aEzhXDoeDQHRhyw4v4V9x3/cdxLBtDkZaVFhcklCbRWbc4naww7qxAWTGqT0d
         K8zUyQfNUcsGw6tPNddcGKWOaW7zUe2DfBvFae/L0dXK909sGTBZKJyJN8mtI/yfs+ux
         wpJ4HL4W1YdPDN+KXFM15lXSWFrnJ2QsgLMeIpchzw1lWtOdFyUMF5fWWBC0vuEOqKux
         WR6+qUI/eQojHO6NN7Pzr4tURmLVwe0WqMpdGSnaLBnTKVZcgoASvP6RkWhX4UYFKXfF
         Z1MA==
X-Forwarded-Encrypted: i=1; AJvYcCUjN7L1uTqvjoMlmaJVpbqlBb4wIFTNcahRPwghU0EuKFUyLJoAqdhu49UEkhULT9cBKcrgS0EZk40Q7LqVxq8RNDtVbzh4DjvdDk3q
X-Gm-Message-State: AOJu0YxlRgYpgmZl63x8fBb/EptKVD6Mw6/k+S3YivIGuuoq81h9ttqb
	UyqGMr37KdjcIWdOMCr+0POaB4fQZbM27UwyB/sDztTrb7pyJqEmKlAVCjomgIsdl8dnNM3I4TO
	2Nehbvbwnwv/FtRHLiLFtzcgieFpAH6onzDBvcA==
X-Google-Smtp-Source: AGHT+IF9hmKUAngU+XkEYYdVI6hGoHL4ie0aigB5IWXi9UydYCJoJBQQop8fXKQKn2jxuGIzVs4R7hjVverTeJ5rxns=
X-Received: by 2002:a25:1d6:0:b0:dff:91e:56ed with SMTP id 3f1490d57ef6-e03c1912d45mr1779996276.1.1720105632032;
 Thu, 04 Jul 2024 08:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
 <20240702-drm-bridge-connector-fix-hdmi-reset-v3-3-12b0e3124ca4@linaro.org> <20240704-roaring-aromatic-seal-d046af@houat>
In-Reply-To: <20240704-roaring-aromatic-seal-d046af@houat>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 4 Jul 2024 18:07:01 +0300
Message-ID: <CAA8EJpri+Jib=4gG4oK50s5yZy7RGEN30ka9KfHKt_aLYyd9tA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/bridge-connector: move to DRM_DISPLAY_HELPER module
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, dri-devel@lists.freedesktop.org, 
	igt-dev@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 15:54, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Tue, Jul 02, 2024 at 12:48:54PM GMT, Dmitry Baryshkov wrote:
> > drm_bridge_connector is a "leaf" driver, belonging to the display
> > helper, rather than the "CRTC" drm_kms_helper module. Move the driver
> > to the drm/display and add necessary Kconfig selection clauses.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/Makefile                             | 1 -
> >  drivers/gpu/drm/bridge/Kconfig                       | 1 +
> >  drivers/gpu/drm/display/Kconfig                      | 6 ++++++
> >  drivers/gpu/drm/display/Makefile                     | 2 ++
> >  drivers/gpu/drm/{ => display}/drm_bridge_connector.c | 0
> >  drivers/gpu/drm/imx/dcss/Kconfig                     | 2 ++
> >  drivers/gpu/drm/imx/lcdc/Kconfig                     | 2 ++
> >  drivers/gpu/drm/ingenic/Kconfig                      | 2 ++
> >  drivers/gpu/drm/kmb/Kconfig                          | 2 ++
> >  drivers/gpu/drm/mediatek/Kconfig                     | 2 ++
> >  drivers/gpu/drm/meson/Kconfig                        | 2 ++
> >  drivers/gpu/drm/msm/Kconfig                          | 1 +
> >  drivers/gpu/drm/omapdrm/Kconfig                      | 2 ++
> >  drivers/gpu/drm/renesas/rcar-du/Kconfig              | 2 ++
> >  drivers/gpu/drm/renesas/rz-du/Kconfig                | 2 ++
> >  drivers/gpu/drm/renesas/shmobile/Kconfig             | 2 ++
> >  drivers/gpu/drm/rockchip/Kconfig                     | 4 ++++
> >  drivers/gpu/drm/tegra/Kconfig                        | 1 +
> >  drivers/gpu/drm/tidss/Kconfig                        | 2 ++
> >  drivers/gpu/drm/xlnx/Kconfig                         | 1 +
> >  20 files changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 68cc9258ffc4..fa432a1ac9e2 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -128,7 +128,6 @@ obj-$(CONFIG_DRM_TTM_HELPER) += drm_ttm_helper.o
> >  drm_kms_helper-y := \
> >       drm_atomic_helper.o \
> >       drm_atomic_state_helper.o \
> > -     drm_bridge_connector.o \
> >       drm_crtc_helper.o \
> >       drm_damage_helper.o \
> >       drm_encoder_slave.o \
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index c621be1a99a8..3eb955333c80 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -390,6 +390,7 @@ config DRM_TI_SN65DSI86
> >       depends on OF
> >       select DRM_DISPLAY_DP_HELPER
> >       select DRM_DISPLAY_HELPER
> > +     select DRM_BRIDGE_CONNECTOR
> >       select DRM_KMS_HELPER
> >       select REGMAP_I2C
> >       select DRM_PANEL
> > diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
> > index 479e62690d75..1a192a45961b 100644
> > --- a/drivers/gpu/drm/display/Kconfig
> > +++ b/drivers/gpu/drm/display/Kconfig
> > @@ -6,6 +6,12 @@ config DRM_DISPLAY_HELPER
> >       help
> >         DRM helpers for display adapters.
> >
> > +config DRM_BRIDGE_CONNECTOR
> > +     bool
> > +     depends on DRM && DRM_BRIDGE && DRM_DISPLAY_HELPER
> > +     help
> > +       DRM connector implementation terminating DRM bridge chains.
> > +
>
> Is there any reason to put it in there instead of under DRM_BRIDGE like
> DRM_PANEL_BRIDGE?

DRM_PANEL_ BRIDGE is a bridge in the end. DRM_BRIDGE_CONNECTOR is not.
That's why I thought that drm/display is a better way to go.

-- 
With best wishes
Dmitry

