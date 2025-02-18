Return-Path: <linux-kernel+bounces-519039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBB6A39753
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9306189222A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187BE22FF38;
	Tue, 18 Feb 2025 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLYaJ95P"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793371B0F14
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871839; cv=none; b=tIK4op/qzufZzg6i/2IoA4mxFn/4t3aDCpVPRzqKN4bHhE7MUxksJg81LiQzznt/H188EShVDgiYk2Hmo5zmL5xKFhSKQ/WTTVNMJaoe+gknVzQrMjqMEPma+WEXFR8lKBLeaipxKDkmxqu1din/YGgJcyDJFS/4o7YCsrArFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871839; c=relaxed/simple;
	bh=j3MZdxCkWh1sLMai3uPuzNCY9K4tIbSU9MkTu0caunk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+b9JusbpK0LDx3/pphfhqkCoSDVEW1P8qArR9B4sWJcUUcRLN9J1kN8jkRMS2GLBaUvBwXKIWzA00pp/XVjEkCzkXhmKP2qyNb7lJ70jGpHsLod6CCPoTlp9b0LXmVuUzN79Dw17CNgOh9r51tc64OfApBXG0dGdH8/LzrKQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HLYaJ95P; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso2507477e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739871835; x=1740476635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9j3FDtCSLrxBBi5ynX/ADgMlPdUEwdI7w+vv6UgkLA=;
        b=HLYaJ95PvE2CK4stS/0rRnxpLNZBt0YoSqObN6IniM1srzw3E45PXE+ghQpnPjVeCp
         71S/K10Kb4BxpMKZE64RJlB3+wEDeCxhAROoKgEm+q3n7ltXgX4WsmcBKxRctefT8eop
         bWdt5KO9w57p44xlMY4I81JfVzGve2oBptVIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739871835; x=1740476635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9j3FDtCSLrxBBi5ynX/ADgMlPdUEwdI7w+vv6UgkLA=;
        b=hMJLupxx6p0yENfHMcvusq4kQ06C+NmRGHFXblbSQ5xeSgAFd3Uzxpwew1GzC/aZBu
         nvj7c3vNz/VFd4h/WvqRhu/H8sUCMtQdRJCRpAlcHfbgdyW4of12c2TsLoiviMRWQV/U
         nfS0EcFZm3AsGfXNl/rruZOSvMOb5WuNXGwiuQtqBh6KqJ8PxL02RfEVXTC+mBWsN7/d
         /v/Jm4aYBBQAMSER8VJEn8OmxTknOsdK08qZ5AUSwamkSuOIyBGaROFI4vAHtZMLKQoS
         pDyTAdqwzI/8StBuRXYYp9ScuHJylf4y0InDX9yKEIlvbrCoK14Igq4cweSAqNFQDMQp
         lgbw==
X-Forwarded-Encrypted: i=1; AJvYcCWUveeFYDzlRKI5/iNmToC4lZ9aI+7jhOae5F0z1PthK1fuU9PICphPGicuF93gPimpeQYjK7+uxKuyYa0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrwl/yRnGQjia6ij5l477svowrs7pfDJakilA05NmwcwgVbxj1
	0uKsNfABPF7OMGfUMImDC/u5KWrZ6qFmVrX4RXgEdGXiAUKaFOiu2hrZkfCMZUbOD2TLW+TPahi
	nRnBxmUhxlzA2+CGLxyh4c6fkxquMNvPNbfXR
X-Gm-Gg: ASbGncvDXWQuF6AUK/tIRZB+NZ39c0LF6Ynb9WnrQ9own4/SNdoC8mbBU1XaD9elWgw
	/S0SJzi/c1s4T9Hgq/HDZtXkey8htnHARkhy0d9/Nl4bW1iNgYvaxY/pFBsAcFEE4tEDevtT5zZ
	k4N2ZIXYABGjn5A88VmRYhk4UO
X-Google-Smtp-Source: AGHT+IFlFPI5zREPHuDeV35TrewF5xMFDi2pmIizcSEr1MF1Kyd27IzONQ06Tosq2K+bGbditdWvnMiF3nl6toSE7rk=
X-Received: by 2002:a05:6512:eaa:b0:540:1a40:ab0d with SMTP id
 2adb3069b0e04-5452fe65367mr4774141e87.28.1739871835497; Tue, 18 Feb 2025
 01:43:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com>
 <20250206-hotplug-drm-bridge-v6-8-9d6f2c9c3058@bootlin.com> <20250210-amusing-bobcat-of-pluck-0d4c09@houat>
In-Reply-To: <20250210-amusing-bobcat-of-pluck-0d4c09@houat>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 18 Feb 2025 17:43:43 +0800
X-Gm-Features: AWEUYZnscch0ATD4RPMuHj0VAYHapvvByEnogTVDzdPu_Io7G9wuKVum6WjojR4
Message-ID: <CAGXv+5GSF=YSiHTgty1J2suAvVYUtOgPShW2mmvuxYiFwK-yeg@mail.gmail.com>
Subject: Re: [PATCH v6 08/26] drm/bridge: panel: add a panel_bridge to every panel
To: Maxime Ripard <mripard@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
	Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Daniel Thompson <danielt@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Paul Kocialkowski <contact@paulk.fr>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:34=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Thu, Feb 06, 2025 at 07:14:23PM +0100, Luca Ceresoli wrote:
> > Adding a panel does currently not add a panel_bridge wrapping it. Usual=
ly
> > the panel_bridge creation happens when some other driver (e.g. the prev=
ious
> > bridge or the encoder) calls *_of_get_bridge() and the following elemen=
t in
> > the pipeline is a panel.
> >
> > This has some drawbacks:
> >
> >  * the panel_bridge is not created in the context of the driver of the
> >    underlying physical device (the panel driver), but of some other dri=
ver
> >  * that "other driver" is not aware of whether the returned drm_bridge
> >    pointer is a panel_bridge created on the fly, a pre-existing
> >    panel_bridge or a non-panel bridge
> >  * removal of a panel_bridge requires calling drm_panel_bridge_remove()=
,
> >    but the "other driver" doesn't know whether this is needed because i=
t
> >    doesn't know whether it has created a panel_bridge or not
> >
> > So far this approach has been working because devm and drmm ensure the
> > panel bridge would be dealloacted at some later point. However with the
> > upcoming implementation of dynamic bridge lifetime this will get more
> > complicated.
> >
> > Correct removal of a panel_bridge might possibly be obtained by adding =
more
> > devm/drmm technology to have it freed correctly at all times. However t=
his
> > would add more complexity and not help making lifetime more understanda=
ble.
> >
> > Use a different approach instead: always create a panel_bridge with a
> > drm_panel, thus matching the lifetime of the drm_panel and the panel_br=
idge
> > wrapping it. This makes lifetime much more straightforward to understan=
d
> > and to further develop on.
> >
> > With the panel_bridge always created, the functions to get a bridge
> > [devm_drm_of_get_bridge() and drmm_of_get_bridge()] become simpler beca=
use
> > the bridge they are looking for exists already (if it can exist at all)=
. In
> > turn, this is implemented based on a variant of
> > drm_of_find_panel_or_bridge() that only looks for panels:
> > of_drm_find_bridge_by_endpoint(). In the future
> > drm_of_find_panel_or_bridge() can be progressively removed because ther=
e
> > will never be a panel not exposing a bridge.
> >
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> >
> > ---
> >
> > This patch was added in v6.
> > ---
> >  drivers/gpu/drm/bridge/panel.c | 74 +++++++++++++++++++++++++++++++++-=
--------
> >  include/drm/drm_panel.h        |  8 +++++
> >  2 files changed, 66 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pa=
nel.c
> > index 58570ff6952ca313b3def084262c9bb3772272ef..6995de605e7317dd1eb153a=
fd475746ced764712 100644
> > --- a/drivers/gpu/drm/bridge/panel.c
> > +++ b/drivers/gpu/drm/bridge/panel.c
> > @@ -69,6 +69,9 @@ EXPORT_SYMBOL(drm_panel_init);
> >   */
> >  void drm_panel_add(struct drm_panel *panel)
> >  {
> > +     panel->bridge =3D drm_panel_bridge_add(panel);
> > +     WARN_ON(!panel->bridge);
> > +
> >       mutex_lock(&panel_lock);
> >       list_add_tail(&panel->list, &panel_list);
> >       mutex_unlock(&panel_lock);
> > @@ -86,6 +89,9 @@ void drm_panel_remove(struct drm_panel *panel)
> >       mutex_lock(&panel_lock);
> >       list_del_init(&panel->list);
> >       mutex_unlock(&panel_lock);
> > +
> > +     drm_panel_bridge_remove(panel->bridge);
> > +     panel->bridge =3D NULL;
> >  }
> >  EXPORT_SYMBOL(drm_panel_remove);
>
> Given that drm_panel_add and drm_panel_remove are typically called at
> probe/remove, it's pretty much equivalent to using devm. Both of these
> solutions aren't safe, and the drm_panel lifetime is still broken.

FWIW I believe this solves the panel vs panel_bridge lifetime
inconsistencies we previously reported [1]. Of course, as you rightly
point out, any pointers to the bridge become stale if the panel gets
removed.

> I'd rather work on a solution that actually fixes those lifetime issues.

I think that can happen once the bridges are ref-counted?

Instead of removing the bridge from the list, it can just clear the
panel pointer and have all the callbacks skip any operations involving
the panel.

The other option is to have the panel itself be ref-counted. I don't
think that's worth pursuing if the idea is to move everything over to
panel_bridge and things are somewhat ready.

ChenYu

[1] https://lore.kernel.org/dri-devel/20241009052402.411978-1-fshao@chromiu=
m.org/

