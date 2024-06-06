Return-Path: <linux-kernel+bounces-203970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D28FE26A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE1A1F23C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673013E3F6;
	Thu,  6 Jun 2024 09:18:06 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50519D8B5;
	Thu,  6 Jun 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665485; cv=none; b=V7zBnq+Cb86QUgtxQwKgId85eI1XhGJpo0v4pXXl9O2TA2+raLCuwyKDFQwPEYS9fJxBH0S1D1II9PJWLBPnEsg39cGlCYnohtF0oINOcMVITFFibjPWzQjwaXmmCt5WL8b4frfodLW37QefzP2uudklfY3SqCrYX8lg3wXUEnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665485; c=relaxed/simple;
	bh=YJdbOuaHsaurGjX4eUFukDBYK8rr97L6xCHKtPDmWFg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCvjJpUpyZJ4oAUHl1mF1tlAvZo5oqOgAs84o3LKeL0qWrsv3JE2tju4J2Ez0AmThULKCEOsDoOoig72QPQpNnYPROWVHg/K0EI4V5fKaOqW4CDNQUYfLDcUuw3e2qZXbo63pqYkPPfL491dK3vvsdLKFkMWN/emKLygUMCJZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvzC40f30z6K6f5;
	Thu,  6 Jun 2024 17:13:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D1A511400E7;
	Thu,  6 Jun 2024 17:17:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 10:17:58 +0100
Date: Thu, 6 Jun 2024 10:17:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Markus Elfring <Markus.Elfring@web.de>
CC: <linux-usb@vger.kernel.org>, <kernel-janitors@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Xin Ji <xji@analogixsemi.com>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: anx7411: Use scope-based resource
 management in anx7411_typec_port_probe()
Message-ID: <20240606101757.0000331f@Huawei.com>
In-Reply-To: <889729ac-3fc5-4666-b9f5-ce6e588a341a@web.de>
References: <889729ac-3fc5-4666-b9f5-ce6e588a341a@web.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 5 Jun 2024 19:11:04 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 5 Jun 2024 18:56:19 +0200
>=20
> Scope-based resource management became supported also for another
> programming interface by contributions of Jonathan Cameron on 2024-02-17.
> See also the commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ("device
> property: Add cleanup.h based fwnode_handle_put() scope based cleanup.").
>=20
> * Thus use the attribute =E2=80=9C__free(fwnode_handle)=E2=80=9D.
>=20
> * Reduce the scope for the local variable =E2=80=9Cfwnode=E2=80=9D.
>=20
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 suppor=
t")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Hi Markus,

Good catch. However in this case I think this is insufficient.
Also your patch description should more clearly state the bug rather
and impacts (a potential resource leak).

I'm not 100% sure how this should work though.

If the expectation is that a reference to the fwnode is held when we
enter typec_register_port(), then if that errors out then we
need fwnode_handle_put().

If expectation is that the reference is not held, then we should
always call fwnode_handle_put() before that is called.
Internally it just uses this to fill in port->dev.fwnode.

Given typec_get_fw_cap() is called from there and doesn't get a reference
I think expectation is that the fwnode is held by the driver calling
typec_register_port() until that is unregistered.

Hence should be put in the error path of that call in the calling driver.

	ctx->typec.port =3D typec_register_port(dev, cap);
	if (IS_ERR(ctx->typec.port)) {
		// fwnode_handle_put() in here.
 		ret =3D PTR_ERR(ctx->typec.port);
		ctx->typec.port =3D NULL;
		dev_err(dev, "Failed to register type c port %d\n", ret);
		return ret;
	}

That makes it tricky to use no_free_ptr() so I wonder if this is
a case where the old fashioned fix of adding all the relevant
fwnode_handle_put() calls is the better option.  The __free()
approach doesn't always fit.

Jonathan

=20
> ---
>  drivers/usb/typec/anx7411.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index b12a07edc71b..9fb52f233a30 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_graph.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -1142,11 +1143,11 @@ static int anx7411_typec_port_probe(struct anx741=
1_data *ctx,
>  {
>  	struct typec_capability *cap =3D &ctx->typec.caps;
>  	struct typec_params *typecp =3D &ctx->typec;
> -	struct fwnode_handle *fwnode;
>  	const char *buf;
>  	int ret, i;
>=20
> -	fwnode =3D device_get_named_child_node(dev, "connector");
> +	struct fwnode_handle *fwnode __free(fwnode_handle)
> +				     =3D device_get_named_child_node(dev, "connector");
>  	if (!fwnode)
>  		return -EINVAL;
>=20
> @@ -1237,7 +1238,7 @@ static int anx7411_typec_port_probe(struct anx7411_=
data *ctx,
>  		typecp->caps_flags |=3D HAS_SINK_WATT;
>  	}
>=20
> -	cap->fwnode =3D fwnode;
> +	cap->fwnode =3D no_free_ptr(fwnode);
>=20
>  	ctx->typec.role_sw =3D usb_role_switch_get(dev);
>  	if (IS_ERR(ctx->typec.role_sw)) {
> --
> 2.45.1
>=20


