Return-Path: <linux-kernel+bounces-227154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A91914924
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9986B1C237E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191FD13B29D;
	Mon, 24 Jun 2024 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezzbL0Ax"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE4137904
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229759; cv=none; b=bkaU5a3eMKhTLHMQsWj/HySnx20qv0pzT+ksbiJ6mfSGsuzsU04l7OGWn/7JpCWXh8yX0bmGLX544zpBRX1oHYYJPsUFZjypOpOLIKm51GLcXylb8/FiDxzYd3utrK1zrjqvqyGOBLgEoAwvghDIvucUwRRqQYFU0diAZfNEyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229759; c=relaxed/simple;
	bh=3CWoi5Gz3gp6QlUn+BkZlres7TdjUCPgGEgGNcjAg3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgODfo+SPza8I+hgy2V6rbt0jG/gEe9g3SGBKJjnOkNvQkwndRXufQGi0/SvVti6vRHK1pmNEgeUtDuyKoVUgjcnZVJjEyXNFJ8YIsdAfSoMuUbB3e54Hgu7Q44cCxT416EfCpxH79tqhiJE+XQyoh+IjrKXN/DPzlYgQTn3h2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ezzbL0Ax; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfe81d54db9so3862450276.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719229756; x=1719834556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkA/z1l9YpCOLu/cX4kLST/VORs4QaQkWnqqTvlwZPM=;
        b=ezzbL0AxyJ/N6eHyRR+CnZKselUuGHQJ9e7m3LLmosRY7Vz7W6oQqvmbuHxl182+IR
         NbS0fipE08ajvB6UTbpdoMDjrt4FUz4oEIxkdawg1t1bt27qgFW24WKxt3jlLWz8ZX4l
         sT1N/dZ+xASt/uqavlImbt/qGA+G5IMk+SP4JY185qgoXkk1WefUvdxRa7Iw+jR0f2CA
         biUZ7owjb18cMo51zdtBS1WGgqtYQ9jD7PB8KqpBiUoovqrD5fQrQrW7rRvySp3GJlj+
         JsQPvwqtCL3/68nD2jO3Yqt5kDtMP3E6pUk6wLNhFKnse9jxaMVaUgAwRjZ8UgtJBFJJ
         oU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229756; x=1719834556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkA/z1l9YpCOLu/cX4kLST/VORs4QaQkWnqqTvlwZPM=;
        b=KlqgHeo3YW4kGhKLhmU07FAD5xl++DaO21kO8vMVpYuthzjVtmI/AXRgTMYTGnMy+G
         hw6vOIumA8UQbmloHheu993dM7FnjjfkBIYMeFCApZUEvT0+Vh+KrTRpF3czhjkShYDY
         krPfDji83Lyn6qL2TuD6P3fH/d5Wd76NMAmKIuO9HGvJPmSOiaxWMEGJqU0gBGghw1Uv
         OAjKonGDT0oW/n0Fjx7k//+a6sGPFBnVP+vX7wpu0mNX0Isd2Bi3PVYAuBU3rV6dteWd
         LpnSYejG1qdb0iQCRM9IgqxGuXiWPeSrOYtXjFJug10cdZnBKXRxIsALY+WXZcalTILK
         0csQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbb0YzK1XzZNNyeK61o45/DzpY+qTq+gNuKoUsvGntlSU21149gI7dPR9YbQ+K3IDAdC0nCFs/Xkogpi4EGuqKhcJQ3PuHEgtWpzv2
X-Gm-Message-State: AOJu0YxHGxggq7so5WvkCM1ye8ZCEAFqtHccK0qI8UkYf7N8/yFJvy11
	jzsAbc6RZrgv+bXn+S7DnZUFvNYVKOoqhd49ChXVf+cVzwoVABvSvNK8/b2JDrPz9asm9p2oNTS
	zIubqxu/SW7jAyvUe0YK6vv8DvConht79Cpv1HA==
X-Google-Smtp-Source: AGHT+IFd9TlWtmtn5DwmKwZMZIwIbV3oYXTGDHovHK4lBMEBgjrMyjz7XYp6QERTqmQdXziI3ZktfSK5+Ivy8M+6820=
X-Received: by 2002:a05:6902:311:b0:dfe:4ab9:1cc1 with SMTP id
 3f1490d57ef6-e030109b1cemr3737428276.40.1719229755986; Mon, 24 Jun 2024
 04:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624-mxc-lcdif-bridge-attach-v1-1-37e8c5d5d934@linaro.org> <859620673.0ifERbkFSE@steina-w>
In-Reply-To: <859620673.0ifERbkFSE@steina-w>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Jun 2024 14:49:03 +0300
Message-ID: <CAA8EJppQtiDxZjLMk6VB0X_4VSuC8cNhPOMd8on2uQ3xo92vSg@mail.gmail.com>
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

On Mon, 24 Jun 2024 at 14:32, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Montag, 24. Juni 2024, 12:31:46 CEST schrieb Dmitry Baryshkov:
> > Existing in-kernel device trees use LCDIF with the dsim + adv7533, dsim
> > + tc358762 or with ldb + panel_bridge. All these combinations support
> > using DRM_BRIDGE_ATTACH_NO_CONNECTOR for bridge attachment.
> >
> > Change lcdif driver to use this flag when attaching the bridge and
> > create drm_bridge_connector afterwards.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Note: compile-tested only.
>
> I gave it a try, but it doesn't work. Despite DSI output it also breaks
> HDMI output, where I at least some error messages:
> [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@32c000=
00/hdmi@32fd8000 to encoder None-37: -22
> [drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@32c000=
00/display-bridge@32fc4000 to encoder None-37: -22
> imx-lcdif 32fc6000.display-controller: error -EINVAL: Failed to attach br=
idge for endpoint0
> imx-lcdif 32fc6000.display-controller: error -EINVAL: Cannot connect brid=
ge
> imx-lcdif 32fc6000.display-controller: probe with driver imx-lcdif failed=
 with error -22

Could you please try it with the following change:

diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
index 13bc570c5473..c87d3e55c00d 100644
--- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
@@ -94,6 +94,7 @@ static int imx8mp_dw_hdmi_probe(struct platform_device *p=
dev)
        plat_data->phy_name =3D "SAMSUNG HDMI TX PHY";
        plat_data->priv_data =3D hdmi;
        plat_data->phy_force_vendor =3D true;
+       plat_data->output_port =3D 1;

        hdmi->dw_hdmi =3D dw_hdmi_probe(pdev, plat_data);
        if (IS_ERR(hdmi->dw_hdmi))


>
> Best regards,
> Alexander
>
> > ---
> >  drivers/gpu/drm/mxsfb/lcdif_drv.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/=
lcdif_drv.c
> > index 0f895b8a99d6..1d5508449995 100644
> > --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> > +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> > @@ -16,6 +16,7 @@
> >
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_bridge.h>
> > +#include <drm/drm_bridge_connector.h>
> >  #include <drm/drm_drv.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_fbdev_dma.h>
> > @@ -48,6 +49,7 @@ static int lcdif_attach_bridge(struct lcdif_drm_priva=
te *lcdif)
> >  {
> >       struct device *dev =3D lcdif->drm->dev;
> >       struct device_node *ep;
> > +     struct drm_connector *connector;
> >       struct drm_bridge *bridge;
> >       int ret;
> >
> > @@ -96,13 +98,23 @@ static int lcdif_attach_bridge(struct lcdif_drm_pri=
vate *lcdif)
> >                       return ret;
> >               }
> >
> > -             ret =3D drm_bridge_attach(encoder, bridge, NULL, 0);
> > +             ret =3D drm_bridge_attach(encoder, bridge, NULL, DRM_BRID=
GE_ATTACH_NO_CONNECTOR);
> >               if (ret) {
> >                       of_node_put(ep);
> >                       return dev_err_probe(dev, ret,
> >                                            "Failed to attach bridge for=
 endpoint%u\n",
> >                                            of_ep.id);
> >               }
> > +
> > +             connector =3D drm_bridge_connector_init(lcdif->drm, encod=
er);
> > +             if (IS_ERR(connector)) {
> > +                     ret =3D PTR_ERR(connector);
> > +                     of_node_put(ep);
> > +
> > +                     return dev_err_probe(dev, ret,
> > +                                          "Failed to create bridge con=
nector for endpoint%u\n",
> > +                                          of_ep.id);
> > +             }
> >       }
> >
> >       return 0;
> >
> > ---
> > base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> > change-id: 20240624-mxc-lcdif-bridge-attach-60368807b2f9
> >
> > Best regards,
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

