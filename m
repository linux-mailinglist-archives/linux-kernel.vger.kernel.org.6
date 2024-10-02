Return-Path: <linux-kernel+bounces-347432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6998D2A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8607A284BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7A200112;
	Wed,  2 Oct 2024 11:59:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C18A19750B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870388; cv=none; b=cRzwbkMMBrZh7Vp94PMS+BWXQQdIyIs7XGs7c4ip52/JnL/Z0XRXSuD0QUsanUjIULQo8bIXaWbkg0zqRCmQRou/k/J1pKMb9f+gQ9dXtTp8aDwZPSrJhXzb+aGP95scz1KQHfBkIFX1O0EfzJxKDjqE1de5TIupSVsAgJ7Sw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870388; c=relaxed/simple;
	bh=tDGiDJeefuiVVlNrYVk6rYgvo7Zvpyl3GdFu/mO5AJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eD5Cy0PZk3tj3zXq35szI1KF1ICRDwztJP4BivJtq6dPbIsKNfzFJXLHME4Oke/49YZQZx3nM0Pdqe8gK+Xf9xZqyNF10dPwqMFDoqpsoD305U4QdwPawElswVunkWDEFbvCIjuVWh1fHDZXOeVPOnXNiqpqConxe6zK5XGYHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svy0q-0001HD-Pn; Wed, 02 Oct 2024 13:59:24 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svy0p-0036LM-NJ; Wed, 02 Oct 2024 13:59:23 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1svy0k-0007fY-1z;
	Wed, 02 Oct 2024 13:59:18 +0200
Message-ID: <07764ea71869cc1c1f95200bcb4e0888fd705dec.camel@pengutronix.de>
Subject: Re: [PATCH v1 06/11] reset: mpfs: add non-auxiliary bus probing
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>, Daire McNamara
 <daire.mcnamara@microchip.com>, pierre-henry.moussay@microchip.com, 
 valentina.fernandezalanis@microchip.com, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Neil Armstrong <neil.armstrong@linaro.org>, Jerome
 Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-riscv@lists.infradead.org,  linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 02 Oct 2024 13:59:18 +0200
In-Reply-To: <20241002-breeze-anywhere-4114da636ec6@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
	 <20241002-breeze-anywhere-4114da636ec6@spud>
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

On Mi, 2024-10-02 at 11:48 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> While the auxiliary bus was a nice bandaid, and meant that re-writing
> the representation of the clock regions in devicetree was not required,
> it has run its course. The "mss_top_sysreg" region that contains the
> clock and reset regions, also contains pinctrl and an interrupt
> controller, so the time has come rewrite the devicetree and probe the
> reset controller from an mfd devicetree node, rather than implement
> those drivers using the auxiliary bus. Wanting to avoid propagating this
> naive/incorrect description of the hardware to the new pic64gx SoC is a
> major motivating factor here.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/reset/reset-mpfs.c | 83 ++++++++++++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> index 710f9c1676f93..ac72e0fc405ed 100644
> --- a/drivers/reset/reset-mpfs.c
> +++ b/drivers/reset/reset-mpfs.c
> @@ -9,10 +9,12 @@
>  #include <linux/auxiliary_bus.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/regmap.h>
>  #include <linux/reset-controller.h>
>  #include <dt-bindings/clock/microchip,mpfs-clock.h>
>  #include <soc/microchip/mpfs.h>
> @@ -27,14 +29,37 @@
>  #define MPFS_SLEEP_MIN_US	100
>  #define MPFS_SLEEP_MAX_US	200
> =20
> +#define REG_SUBBLK_RESET_CR	0x88u
> +
>  /* block concurrent access to the soft reset register */
>  static DEFINE_SPINLOCK(mpfs_reset_lock);
> =20
>  struct mpfs_reset {
>  	void __iomem *base;
> +	struct regmap *regmap;
>  	struct reset_controller_dev rcdev;
>  };
> =20
> +static inline u32 mpfs_reset_read(struct mpfs_reset *rst)
> +{
> +	u32 ret;
> +
> +	if (rst->regmap)
> +		regmap_read(rst->regmap, REG_SUBBLK_RESET_CR, &ret);
> +	else
> +		ret =3D readl(rst->base);
> +
> +	return ret;
> +}
> +
> +static inline void mpfs_reset_write(struct mpfs_reset *rst, u32 val)
> +{
> +	if (rst->regmap)
> +		regmap_write(rst->regmap, REG_SUBBLK_RESET_CR, val);
> +	else
> +		writel(val, rst->base);
> +}
> +
>  static inline struct mpfs_reset *to_mpfs_reset(struct reset_controller_d=
ev *rcdev)
>  {
>  	return container_of(rcdev, struct mpfs_reset, rcdev);
> @@ -51,9 +76,9 @@ static int mpfs_assert(struct reset_controller_dev *rcd=
ev, unsigned long id)
> =20
>  	spin_lock_irqsave(&mpfs_reset_lock, flags);
> =20
> -	reg =3D readl(rst->base);
> +	reg =3D mpfs_reset_read(rst);
>  	reg |=3D BIT(id);
> -	writel(reg, rst->base);
> +	mpfs_reset_write(rst, reg);

This should use regmap_update_bits() in the regmap case, same in
mpfs_deassert().

regards
Philipp

