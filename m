Return-Path: <linux-kernel+bounces-227127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39B59148CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C7A287329
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F490139590;
	Mon, 24 Jun 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jzk8zOGz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="J/ZYT6ZZ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99B18654
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228751; cv=none; b=YTZlzlbtiR4PB8l0zjZLTRjRYs6s/bX+pDx0/hPxMC3jAUbnYjb6Ar2/9h55lYhvt8YSOFofw6LtOs5Y7MAD2KMOdQFJOnZ86yPUgYhtsYVnY/8Vu7vTdKBQdI3d7GEBFePyKGVgvz2BqcB6xu9zMEt41hbNsHES8ipxyZpopNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228751; c=relaxed/simple;
	bh=7jlo9vmhtWKTResIq0eDD/qPIJzSgx51/e3patMJCKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgQO4qj0aOb5dySqS678Kns3Ft/mBBX5gEHaN9OpNR9FJpOyCfrxnJFNqRKo4q4JWct5Gr4K8pby3tdLX8A5RXRa0jnwZFW2tM4GuVwYiqJwNHTZkaeluAaQ9h96tzW/1HvFA/LT8j6v/PT/iVm/iHKYhDWFZDCUh83wrO1is+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jzk8zOGz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=J/ZYT6ZZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719228748; x=1750764748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HS0w/FAC4Vg1rsGlmB0DrwqRXeG8EmTG+BPwYRmz0Bo=;
  b=jzk8zOGzp6uniq/W8e9ZG4hsjdCJBPScwQ/hyhcavWOsNn28FHtORJck
   vT1hVLg+YYoz92Ulkc2zFj9zULhcj8U7X57WneeIIDAKvRqLGoAtWwhdw
   Tv4mU2zOJfTuS9wyHY+FfKy8OKnZ5d+tnd1qoHsPRIi5DfCQ4zh5pTWHP
   4B4XK9Jt/1k+dApVNGbIYTfhpoaDNSATMnNyqxMqpaTF7t3395qHGmB3y
   8uhPkq2UlHSwWma84w6FLkLSQ42C7BM7ChY1vQ8SmU9kHIUFpH9nIVTMP
   dKi4TzdQk57ELUkrepDZVbm2/fFaqGPeIWlkMd3KsLYlrfEHSRPrfUHss
   A==;
X-CSE-ConnectionGUID: xutlt1bvR1OPgmKEzE8qrw==
X-CSE-MsgGUID: 0ZaALeZKQNuLTK+a8XFTmg==
X-IronPort-AV: E=Sophos;i="6.08,261,1712613600"; 
   d="scan'208";a="37550994"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jun 2024 13:32:26 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA73B161461;
	Mon, 24 Jun 2024 13:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719228742;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HS0w/FAC4Vg1rsGlmB0DrwqRXeG8EmTG+BPwYRmz0Bo=;
	b=J/ZYT6ZZPm0j+qJ4XydMuPOr/DBjQtDvmdFLU+zCLT2h1BaF/9ZdN6AMbIEAcBFZHOufHo
	dY71HZUtLEoVzDdVUenSGEbmC9Htj7QxPLqUzfdN4VEPC6+XmzXZ/wnv3zRAO9jfin2YbP
	BTPYjfEK0tJXbllPhenw25hwg59vJ3BfVqrsD9tffJ6zY8lalYhJEWP2xkkzWNtXHr29IP
	2omtKCwu6I5hltQ+s/T0yYI7+LslkgRXYZRal3CUsTjGdpUaDGgRs5lOzWG+54od/Pkme+
	cFyVcHhTOZmaG51c+KlgFFdeOkjT9u1kB70EsnbN1e+OV529ORP8gwloyvVoTw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] drm/lcdif: switch to DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date: Mon, 24 Jun 2024 13:32:20 +0200
Message-ID: <859620673.0ifERbkFSE@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240624-mxc-lcdif-bridge-attach-v1-1-37e8c5d5d934@linaro.org>
References: <20240624-mxc-lcdif-bridge-attach-v1-1-37e8c5d5d934@linaro.org>
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

Am Montag, 24. Juni 2024, 12:31:46 CEST schrieb Dmitry Baryshkov:
> Existing in-kernel device trees use LCDIF with the dsim + adv7533, dsim
> + tc358762 or with ldb + panel_bridge. All these combinations support
> using DRM_BRIDGE_ATTACH_NO_CONNECTOR for bridge attachment.
>=20
> Change lcdif driver to use this flag when attaching the bridge and
> create drm_bridge_connector afterwards.
>=20
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Note: compile-tested only.

I gave it a try, but it doesn't work. Despite DSI output it also breaks
HDMI output, where I at least some error messages:
[drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@32c00000=
/hdmi@32fd8000 to encoder None-37: -22
[drm:drm_bridge_attach] *ERROR* failed to attach bridge /soc@0/bus@32c00000=
/display-bridge@32fc4000 to encoder None-37: -22
imx-lcdif 32fc6000.display-controller: error -EINVAL: Failed to attach brid=
ge for endpoint0
imx-lcdif 32fc6000.display-controller: error -EINVAL: Cannot connect bridge
imx-lcdif 32fc6000.display-controller: probe with driver imx-lcdif failed w=
ith error -22

Best regards,
Alexander

> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lc=
dif_drv.c
> index 0f895b8a99d6..1d5508449995 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -16,6 +16,7 @@
> =20
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_fbdev_dma.h>
> @@ -48,6 +49,7 @@ static int lcdif_attach_bridge(struct lcdif_drm_private=
 *lcdif)
>  {
>  	struct device *dev =3D lcdif->drm->dev;
>  	struct device_node *ep;
> +	struct drm_connector *connector;
>  	struct drm_bridge *bridge;
>  	int ret;
> =20
> @@ -96,13 +98,23 @@ static int lcdif_attach_bridge(struct lcdif_drm_priva=
te *lcdif)
>  			return ret;
>  		}
> =20
> -		ret =3D drm_bridge_attach(encoder, bridge, NULL, 0);
> +		ret =3D drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_=
CONNECTOR);
>  		if (ret) {
>  			of_node_put(ep);
>  			return dev_err_probe(dev, ret,
>  					     "Failed to attach bridge for endpoint%u\n",
>  					     of_ep.id);
>  		}
> +
> +		connector =3D drm_bridge_connector_init(lcdif->drm, encoder);
> +		if (IS_ERR(connector)) {
> +			ret =3D PTR_ERR(connector);
> +			of_node_put(ep);
> +
> +			return dev_err_probe(dev, ret,
> +					     "Failed to create bridge connector for endpoint%u\n",
> +					     of_ep.id);
> +		}
>  	}
> =20
>  	return 0;
>=20
> ---
> base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> change-id: 20240624-mxc-lcdif-bridge-attach-60368807b2f9
>=20
> Best regards,
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



