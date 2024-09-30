Return-Path: <linux-kernel+bounces-344492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B302C98AA62
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAFD1F23C10
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105B193418;
	Mon, 30 Sep 2024 16:56:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61C1925B8
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715374; cv=none; b=RF1oKKiueUcxd2d8UXYo1vMYheODWvthr/u4/m2YeAp+2kbGnchSZNVJ/DWFx4D+Qd+m4+GmyexV7ArCs3zS/r10nm5nV66XwRZuF4LKPxD6SvpKKiPlpM0+uggxO2s0lekVRtzf5nKRlow/luKzvXwnwHSea2KDuW45QRaR+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715374; c=relaxed/simple;
	bh=4zBNprMZl9BBdFUcZxU//hySXcCOgRT08A1NmFvH89Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6TlJ8RM8Wt4/uE423bq7E4BwNt1imxEAIDcATJZSHSPz6xax3Wqfn0/RhHMdoWB6VNBcEYgvCpnRLqyXYL5m/Vxmn6ceiIJYa7G4onlXrY3M1fWg5Mk4Wmjh5ggWa/dUZ+oWeP9F88wNrVlOaVGLqI9irAocvVORMoIyf9Tc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svJgs-0003Pg-7Z; Mon, 30 Sep 2024 18:56:06 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svJgr-002fvN-Eg; Mon, 30 Sep 2024 18:56:05 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svJgr-000FXL-1G;
	Mon, 30 Sep 2024 18:56:05 +0200
Message-ID: <01aff9c0f129f8c1cf41c7ae53dac38048aa34a8.camel@pengutronix.de>
Subject: Re: [PATCH v5 8/9] reset: amlogic: split the device core and
 platform probe
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Jiucheng Xu
 <jiucheng.xu@amlogic.com>, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Sep 2024 18:56:05 +0200
In-Reply-To: <1jldzwkpsu.fsf@starbuckisacylon.baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
	 <20240910-meson-rst-aux-v5-8-60be62635d3e@baylibre.com>
	 <8cb81058c8f45e378675e078e296336a2cf74308.camel@pengutronix.de>
	 <1jldzwkpsu.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fr, 2024-09-13 at 08:53 +0200, Jerome Brunet wrote:
> On Thu 12 Sep 2024 at 10:12, Philipp Zabel <p.zabel@pengutronix.de> wrote=
:
>=20
> > On Di, 2024-09-10 at 18:32 +0200, Jerome Brunet wrote:
> > > To prepare the addition of the auxiliary device support, split
> > > out the device coomon functions from the probe of the platform device=
.
> > >=20
> > > The device core function will be common to both the platform and auxi=
liary
> > > driver.
> > >=20
> > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > ---
> > >  drivers/reset/amlogic/Kconfig              |   7 +-
> > >  drivers/reset/amlogic/Makefile             |   1 +
> > >  drivers/reset/amlogic/reset-meson-common.c | 121 +++++++++++++++++++=
+++++++++
> > >  drivers/reset/amlogic/reset-meson.c        | 122 ++++---------------=
----------
> > >  drivers/reset/amlogic/reset-meson.h        |  24 ++++++
> > >  5 files changed, 167 insertions(+), 108 deletions(-)
> > >=20
> > > diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kc=
onfig
> > > index 532e6a4f7865..1d77987088f4 100644
> > > --- a/drivers/reset/amlogic/Kconfig
> > > +++ b/drivers/reset/amlogic/Kconfig
> > > @@ -1,10 +1,15 @@
> > > +config RESET_MESON_COMMON
> > > +	tristate
> > > +	select REGMAP
> > > +
> > >  config RESET_MESON
> > >  	tristate "Meson Reset Driver"
> > >  	depends on ARCH_MESON || COMPILE_TEST
> > >  	default ARCH_MESON
> > >  	select REGMAP_MMIO
> > > +	select RESET_MESON_COMMON
> > >  	help
> > > -	  This enables the reset driver for Amlogic Meson SoCs.
> > > +	  This enables the reset driver for Amlogic SoCs.
> > > =20
> > >  config RESET_MESON_AUDIO_ARB
> > >  	tristate "Meson Audio Memory Arbiter Reset Driver"
> > > diff --git a/drivers/reset/amlogic/Makefile b/drivers/reset/amlogic/M=
akefile
> > > index 55509fc78513..74aaa2fb5e13 100644
> > > --- a/drivers/reset/amlogic/Makefile
> > > +++ b/drivers/reset/amlogic/Makefile
> > > @@ -1,2 +1,3 @@
> > >  obj-$(CONFIG_RESET_MESON) +=3D reset-meson.o
> > > +obj-$(CONFIG_RESET_MESON_COMMON) +=3D reset-meson-common.o
> > >  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) +=3D reset-meson-audio-arb.o
> > > diff --git a/drivers/reset/amlogic/reset-meson-common.c b/drivers/res=
et/amlogic/reset-meson-common.c
> > > new file mode 100644
> > > index 000000000000..d57544801ae9
> > > --- /dev/null
> > > +++ b/drivers/reset/amlogic/reset-meson-common.c
> > > @@ -0,0 +1,121 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > > +/*
> > > + * Amlogic Meson Reset core functions
> > > + *
> > > + * Copyright (c) 2016-2024 BayLibre, SAS.
> > > + * Authors: Neil Armstrong <narmstrong@baylibre.com>
> > > + *          Jerome Brunet <jbrunet@baylibre.com>
> > > + */
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/reset-controller.h>
> > > +
> > > +#include "reset-meson.h"
> > > +
> > > +struct meson_reset {
> > > +	const struct meson_reset_param *param;
> > > +	struct reset_controller_dev rcdev;
> > > +	struct regmap *map;
> > > +};
> > > +
> > > +static void meson_reset_offset_and_bit(struct meson_reset *data,
> > > +				       unsigned long id,
> > > +				       unsigned int *offset,
> > > +				       unsigned int *bit)
> > > +{
> > > +	unsigned int stride =3D regmap_get_reg_stride(data->map);
> > > +
> > > +	*offset =3D (id / (stride * BITS_PER_BYTE)) * stride;
> > > +	*bit =3D id % (stride * BITS_PER_BYTE);
> > > +}
> > > +
> > > +static int meson_reset_reset(struct reset_controller_dev *rcdev,
> > > +			     unsigned long id)
> >=20
> > checkpatch --strict complains about the alignment here.
> > I'll fix this up when applying, no need to resend.
>=20
> Thanks Philipp.
>=20
> FYI, those mis-alignement were already present in the original code and
> there has been comments when I re-indented code while moving it
> around so I did not touch it.

Oh, ok.

I've applied them to reset/next them unchanged, at:
https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D5b93105afcdc
and sent a follow-up patch to fix the alignment.

regards
Philipp

