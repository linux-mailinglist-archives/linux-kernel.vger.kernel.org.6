Return-Path: <linux-kernel+bounces-227173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF336914977
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C28B229F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6BB13B5AD;
	Mon, 24 Jun 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRK4lLLP"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06013B58D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231181; cv=none; b=CpLU5K7s4qlKHaOZoh8xQYOaTNAVlx+5QcqDyq8C3PAocxck0uDoTmIy5UPLD+fXHXp5WWI50Dy0EBCmDR5ggpSSTEU5yrFDeqF2AlpVb8gbQiDVIYqwmAUy9iOBK3942Nefe+Dw/g+0qokCeTIRLo6AKLy0BYaMME9yMY0eqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231181; c=relaxed/simple;
	bh=MaefPGkP/eVC1BUq+bhf0BpCWTj09NkDwsi6DKIEHIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNlznODy/sbvopcF9SkquOrXvT4udaL1Tx0lZLKHsoVGk+Ql+YBO9nPPSZE6Mxi2aeSnakV6Tq9S7wwUEDjoq1XLaiXpAq9aSsjQK4cdKgDngLRm9xykZuG5L9sz61z/tgumYHEwdQjoJ/+lJqqpuJKyIInRenqvJhhopnjLBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZRK4lLLP; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-63258caaa91so38913117b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719231178; x=1719835978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6qUn3B941SaKmnTlYImbJrnT+/A2pSZCbuhCNRlU2c=;
        b=ZRK4lLLPWqp6jkirwho2CDdxFiJKsnvVIatJ96sYU0Al/42zMNItK2AYZB12Xq3Nz8
         y2dbXFMMczcvt2YgaC96JZMWGxTwX13gcizB7i1XXzzuFcDavoFmqJAQj5MjDTadV/7m
         WoDQcQQaNoLZkO+iQR0Nq4lipiaITNjNsj6bj5P89x5A6bBfFPqtE/k3nWsHnH8z/1jU
         Fc0t/NfGd4ZARcT1uD7QdtfEzMoi+4SyQG7nyHkJxUvdpKkpLvrXuqq8wKfiicJwKII9
         80YzT115mv/e5s7fsWyDZINglIjykzZtMA+g7BclE58NeLpqQ97/eLxYVmIyhK9F0IJk
         5O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719231178; x=1719835978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6qUn3B941SaKmnTlYImbJrnT+/A2pSZCbuhCNRlU2c=;
        b=OWVaJJG8So3VkO8cgQWDD6pY+Cdk4/l4gJBg7ai6l/uZKrx5/A4PWNl1LgLCbvioqm
         9DBazdYqictOh2xh3wkB+BDebZWls4Z5Po7oXi8efLQlVHdRfAfo214fmUC3MmJAkB+E
         /8CSq802LJtRVhYoh5WVLzsYXonjQHX67x9/W3wnLyyc9k2drxzsHCtqGy5nfXzTj1pm
         Wtrwhw/uajEKnJTPSvYhGHdQYblyNM2vV+Km/c0NhBaEZ/DHg1DoSg6okwdDZhcUAJV0
         tnZS8aPjJMkQx7fSZea9jYcuU0QQH8uJMR37VtTlE5I3jYAThF+kVdC5exE5IaMglF7S
         4g1A==
X-Forwarded-Encrypted: i=1; AJvYcCW+5Zp3k8+zwbGlULuC+IVsWUADQsIr6DoAq+yY9vDp8Y/kPvpLGcg/DpSh+T3BKBkokdzt3IET6ctBFAlFL2kXpAU3f+sPRguRoSbI
X-Gm-Message-State: AOJu0YwYQEYcHAHb1hFdg2f0N2guAbA99Km5PhmQp9+yULdojTOQZeiC
	zcDzWCEKZrhLBH14lpW5VP017SkoBGtcZFIMQcr3My5GC/Ol2qzp3/UkqqjS9oBtEIOcDL+SB2J
	J6jao75dxvGAInseeqkNg3gJyNkKjpRO2V6OInQ==
X-Google-Smtp-Source: AGHT+IEF1HehGOmrnh5OAL93YehPGGcegJHyWkO5g5YUNrXsZWXxAzZkNA0qGBJHKUiwcOCe0R4VtMvMhRHHrQfF14k=
X-Received: by 2002:a81:690b:0:b0:627:7f2a:3b0a with SMTP id
 00721157ae682-6429aa00545mr43803277b3.31.1719231178522; Mon, 24 Jun 2024
 05:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624-mxc-lcdif-bridge-attach-v1-1-37e8c5d5d934@linaro.org>
 <859620673.0ifERbkFSE@steina-w> <CAA8EJppQtiDxZjLMk6VB0X_4VSuC8cNhPOMd8on2uQ3xo92vSg@mail.gmail.com>
 <1984704.yKVeVyVuyW@steina-w>
In-Reply-To: <1984704.yKVeVyVuyW@steina-w>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Jun 2024 15:12:45 +0300
Message-ID: <CAA8EJpoKudfSF_BM9O3xXv0GV3wUkTz2x6nH3J4JzrXtk7ECzg@mail.gmail.com>
Subject: Re: [PATCH] drm/lcdif: switch to DRM_BRIDGE_ATTACH_NO_CONNECTOR
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Jun 2024 at 15:03, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Dmitry,
>
> Am Montag, 24. Juni 2024, 13:49:03 CEST schrieb Dmitry Baryshkov:
> > On Mon, 24 Jun 2024 at 14:32, Alexander Stein
> > <alexander.stein@ew.tq-group.com> wrote:
> > >
> > > Hi,
> > >
> > > Am Montag, 24. Juni 2024, 12:31:46 CEST schrieb Dmitry Baryshkov:
> > > > Existing in-kernel device trees use LCDIF with the dsim + adv7533, =
dsim
> > > > + tc358762 or with ldb + panel_bridge. All these combinations suppo=
rt
> > > > using DRM_BRIDGE_ATTACH_NO_CONNECTOR for bridge attachment.
> > > >
> > > > Change lcdif driver to use this flag when attaching the bridge and
> > > > create drm_bridge_connector afterwards.
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > > Note: compile-tested only.
> > >
> > > I gave it a try, but it doesn't work. Despite DSI output it also brea=
ks
> > > HDMI output, where I at least some error messages:
> > > [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@32=
c00000/hdmi@32fd8000 to encoder None-37: -22
> > > [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@32=
c00000/display-bridge@32fc4000 to encoder None-37: -22
> > > imx-lcdif 32fc6000.display-controller: error -EINVAL: Failed to attac=
h bridge for endpoint0
> > > imx-lcdif 32fc6000.display-controller: error -EINVAL: Cannot connect =
bridge
> > > imx-lcdif 32fc6000.display-controller: probe with driver imx-lcdif fa=
iled with error -22
> >
> > Could you please try it with the following change:
> >
> > diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > index 13bc570c5473..c87d3e55c00d 100644
> > --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> > @@ -94,6 +94,7 @@ static int imx8mp_dw_hdmi_probe(struct platform_devic=
e *pdev)
> >         plat_data->phy_name =3D "SAMSUNG HDMI TX PHY";
> >         plat_data->priv_data =3D hdmi;
> >         plat_data->phy_force_vendor =3D true;
> > +       plat_data->output_port =3D 1;
> >
> >         hdmi->dw_hdmi =3D dw_hdmi_probe(pdev, plat_data);
> >         if (IS_ERR(hdmi->dw_hdmi))
>
> Okay, this does fix the HDMI probe errors. Nevertheless I get the errors:
> [   13.429313] [drm] Initialized imx-lcdif 1.0.0 for 32e80000.display-con=
troller on minor 1
> [   13.439116] imx-lcdif 32e80000.display-controller: [drm] Cannot find a=
ny crtc or sizes
> [   13.448168] imx-lcdif 32e80000.display-controller: [drm] Cannot find a=
ny crtc or sizes
> [   15.519737] [drm] Initialized imx-lcdif 1.0.0 for 32fc6000.display-con=
troller on minor 2
> [   15.675672] imx-lcdif 32fc6000.display-controller: [drm] Cannot find a=
ny crtc or sizes
>
> just from the lcdif patch for both HDMI and DP.

It seems, because I'm stupid and I missed drm_connector_attach_encoder().

Anyway, it looks like even if that fixes the issue, dw-hdmi needs more
work to work with drm_bridge_connector without losing access to such
features like YCbCr 420 and CEC. So thank you for the tests, but let's
probably drop the patch / idea for now.


>
> Best regards,
> Alexander
>
> >
> > >
> > > Best regards,
> > > Alexander
> > >
> > > > ---
> > > >  drivers/gpu/drm/mxsfb/lcdif_drv.c | 14 +++++++++++++-
> > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mx=
sfb/lcdif_drv.c
> > > > index 0f895b8a99d6..1d5508449995 100644
> > > > --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> > > > +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> > > > @@ -16,6 +16,7 @@
> > > >
> > > >  #include <drm/drm_atomic_helper.h>
> > > >  #include <drm/drm_bridge.h>
> > > > +#include <drm/drm_bridge_connector.h>
> > > >  #include <drm/drm_drv.h>
> > > >  #include <drm/drm_encoder.h>
> > > >  #include <drm/drm_fbdev_dma.h>
> > > > @@ -48,6 +49,7 @@ static int lcdif_attach_bridge(struct lcdif_drm_p=
rivate *lcdif)
> > > >  {
> > > >       struct device *dev =3D lcdif->drm->dev;
> > > >       struct device_node *ep;
> > > > +     struct drm_connector *connector;
> > > >       struct drm_bridge *bridge;
> > > >       int ret;
> > > >
> > > > @@ -96,13 +98,23 @@ static int lcdif_attach_bridge(struct lcdif_drm=
_private *lcdif)
> > > >                       return ret;
> > > >               }
> > > >
> > > > -             ret =3D drm_bridge_attach(encoder, bridge, NULL, 0);
> > > > +             ret =3D drm_bridge_attach(encoder, bridge, NULL, DRM_=
BRIDGE_ATTACH_NO_CONNECTOR);
> > > >               if (ret) {
> > > >                       of_node_put(ep);
> > > >                       return dev_err_probe(dev, ret,
> > > >                                            "Failed to attach bridge=
 for endpoint%u\n",
> > > >                                            of_ep.id);
> > > >               }
> > > > +
> > > > +             connector =3D drm_bridge_connector_init(lcdif->drm, e=
ncoder);
> > > > +             if (IS_ERR(connector)) {
> > > > +                     ret =3D PTR_ERR(connector);
> > > > +                     of_node_put(ep);
> > > > +
> > > > +                     return dev_err_probe(dev, ret,
> > > > +                                          "Failed to create bridge=
 connector for endpoint%u\n",
> > > > +                                          of_ep.id);
> > > > +             }
> > > >       }
> > > >
> > > >       return 0;
> > > >
> > > > ---
> > > > base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> > > > change-id: 20240624-mxc-lcdif-bridge-attach-60368807b2f9
> > > >
> > > > Best regards,
> > > >
> > >
> > >
> > > --
> > > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld=
, Germany
> > > Amtsgericht M=C3=BCnchen, HRB 105018
> > > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stef=
an Schneider
> > > http://www.tq-group.com/
> > >
> > >
> >
> >
> >
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>


--=20
With best wishes
Dmitry

