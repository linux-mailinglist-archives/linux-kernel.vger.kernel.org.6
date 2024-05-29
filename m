Return-Path: <linux-kernel+bounces-193708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0D8D30F2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93731C2344E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2109168C3F;
	Wed, 29 May 2024 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QZHNzQzw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="X0yjbkyS"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947933CFC
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970531; cv=none; b=UzJwQKfSHw318RQPkg3QVpKLKvmJtLsE8slNQFLNToHk5dWo17WitrYXfEwYwyvGvspdaKAiD3H1kphTjF/VIv6qf52dSd3BkWRfxsNWY6HWku/XPpSB47cKBY/G1zGb5Ibj2KmSdz/o4ikiAuFwKEb5emaR32m1WCAcz8kbwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970531; c=relaxed/simple;
	bh=UzQmf9tjN3LeNjX/lVtrlreMZNXUsY8QbXs8KUectg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJPiNvTWF/aGqyYp8evscOBE0fuRKrNQ4xu7DG1XZwrq4e2Wf9gWFbYZ9CHoUMdA31VqQui85t/nhLXWaw886b8PhsBhHm4Dc+XQS8HCuoeclRJ6RVXAjjV2bByBfdBurkO11BhYEe2RoMT5AzJrihBK6lj8YjDHjIfg9Guq5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QZHNzQzw; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=X0yjbkyS reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716970528; x=1748506528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPzqmbhWrWgXeytPFFr8ZnaAVt6ESUekqElZje8ecik=;
  b=QZHNzQzwm0qFrgoOLEhkcQQQnO3iq43VNmwZPxRobkA+yNMCi+Md0Azp
   PIumymSHTTYCkDSOVvK8iA21E2GcCqh7Q2R2UqdM5mJs07BBKcOFZUYHd
   Z254ZiloN8tUMLS/k+JVdbMx3yeYCBmteUnLkR9Tm/99St8P94i/bVctq
   sKTNCr3bNnl8t/jODl66dZYiHdkm4yfzbuZfiSsaAcr0pATl55tOWiMWu
   wBltK/Dbzzagp7yoA/gm48i54s+4/vT1xavXxByM5BP8VfgaG7HTxsPfI
   FUHjMAhCYNGXlIpU7JZVy9y+B4yikt3y6Nxli+x70clvnrBe7IE/aYDW+
   Q==;
X-CSE-ConnectionGUID: peETRQxgQGeJmBnaAiv4Qw==
X-CSE-MsgGUID: BGCkLORMQzqJRAr6qC55Sg==
X-IronPort-AV: E=Sophos;i="6.08,197,1712613600"; 
   d="scan'208";a="37120964"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 May 2024 10:15:26 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 428F516564F;
	Wed, 29 May 2024 10:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716970522;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qPzqmbhWrWgXeytPFFr8ZnaAVt6ESUekqElZje8ecik=;
	b=X0yjbkySyuGTbdlhNBO93Jh68pO3BA/mg1Zd40iUSbpOU95OxQ52P5PGEqzn1uViTP7tbV
	iI62wxWbD0xc/OKGyawp1b6dojDbnY8akxQlxY9e9l8JkWzE3k8w9yJmXsbEuVLi3mJy1Z
	JWLzPP+GEyTf1xbuixIphwW1jshgmDGJbhsM26wmH70SZ73nvIg5vrj5VBP1ZF6LGgAhaq
	k1Z+w27V+CgqhxshxYlgoiDkKrmpmW0XUdSUFjJhKyEs0PHT1Ko4d+UnBTvf5+kOrl05eD
	LiJ5XSthmZoI6noWYj4kLdu/pdMTUiWfawdrHwOFq4NddGxNyi62if1v7I6qCA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] drm/bridge: imx93-mipi-dsi: Use dev_err_probe
Date: Wed, 29 May 2024 10:15:18 +0200
Message-ID: <6130653.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <091f1d5c-0bff-4dcb-b823-b82989eac628@nxp.com>
References: <20240529065400.461633-1-alexander.stein@ew.tq-group.com> <091f1d5c-0bff-4dcb-b823-b82989eac628@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Mittwoch, 29. Mai 2024, 09:50:24 CEST schrieb Liu Ying:
> On 05/29/2024, Alexander Stein wrote:
> > Although very unlike to occur (media_blk_ctrl needs 'syscon' compatible
> > removed), it lines up with the other error paths in probe function.
>=20
> Why media_blk_ctrl needs 'syscon' compatible removed?

No, it does not. As media_blk_ctrl is also used as power-domain the device
will not even be probed if media_blk_ctrl is not available.
I just mentioned it under which conditions this error path could happen.

Best regards,
Alexander

> device_node_get_regmap may return error pointer other than
> ERR_PTR(-EPROBE_DEFER), like ERR_PTR(-ENOMEM).
>=20
> struct regmap *syscon_node_to_regmap(struct device_node *np)             =
       =20
> {                                                                        =
       =20
>         if (!of_device_is_compatible(np, "syscon"))                      =
       =20
>                 return ERR_PTR(-EINVAL);                                 =
       =20
>                                                                          =
       =20
>         return device_node_get_regmap(np, true);                         =
       =20
> }                                                                        =
       =20
> EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
>=20
> Regard,
> Liu Ying
>=20
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > Changes in v2:
> > * Removed unused variable
> > * Added missing \n at end of string
> >=20
> >  drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/=
drm/bridge/imx/imx93-mipi-dsi.c
> > index 2347f8dd632f9..13025f47f3902 100644
> > --- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> > +++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> > @@ -834,18 +834,15 @@ static int imx93_dsi_probe(struct platform_device=
 *pdev)
> >  	struct device *dev =3D &pdev->dev;
> >  	struct device_node *np =3D dev->of_node;
> >  	struct imx93_dsi *dsi;
> > -	int ret;
> > =20
> >  	dsi =3D devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
> >  	if (!dsi)
> >  		return -ENOMEM;
> > =20
> >  	dsi->regmap =3D syscon_regmap_lookup_by_phandle(np, "fsl,media-blk-ct=
rl");
> > -	if (IS_ERR(dsi->regmap)) {
> > -		ret =3D PTR_ERR(dsi->regmap);
> > -		dev_err(dev, "failed to get block ctrl regmap: %d\n", ret);
> > -		return ret;
> > -	}
> > +	if (IS_ERR(dsi->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(dsi->regmap),
> > +				     "failed to get block ctrl regmap\n");
> > =20
> >  	dsi->clk_pixel =3D devm_clk_get(dev, "pix");
> >  	if (IS_ERR(dsi->clk_pixel))
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



