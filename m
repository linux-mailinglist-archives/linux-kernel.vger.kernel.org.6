Return-Path: <linux-kernel+bounces-209659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAD3903904
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B121C23B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681BE178CF1;
	Tue, 11 Jun 2024 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqnSTrD7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520217625F;
	Tue, 11 Jun 2024 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102194; cv=none; b=qL29jm8PYE+DaV6+N2svo3DX5MngJeQy3+EDYX5vJA5MAEpPMyuab5P32FE4zT5a2u/vxJZZmqgdTI63/7Y4jio+6B9tdu9AsteBNxRbobevUwyuNk1ealGmVtrad+u6hhfjJCqrAIKC2HEUwaByjyrafPk1KJumo1it7QT8mGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102194; c=relaxed/simple;
	bh=GRiJHJeBxHjjSrVuUZQEjtAnkrsyVP3YUixQ0bIDogY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egSkc74t/cHzKV2foaGBE7sdeU73j6WaYKm6JZXcwRBnOqR+red11vkVtaLsYutbYTRvoZrGjL2ZpPE09NKZBw+QciWwz/ZUWYUvOdQ6XEiNlH92Rtyz85LgGoX+kuvs/xvkDDZZCE7RGXI+6OJKw8s7jeMR1DybqE1eEPK+Jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqnSTrD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985F7C2BD10;
	Tue, 11 Jun 2024 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718102194;
	bh=GRiJHJeBxHjjSrVuUZQEjtAnkrsyVP3YUixQ0bIDogY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqnSTrD70/+vXgJD/5znDSFJoVnc7K8K6uckcQ3lWeVRuhL/70lTfzEN+6ZMRR5lU
	 QpQDparoIxqKCPK+ccn2ON/mf/aml+H+R07RM2rKDM74OfVrDpDvb32r1jk0nCddBM
	 bEfy3OIM2u+OlkNS0DYGtBXRG4SSa3ywLYgv06ekYWDSRayaANzBun4myW4uzyDWYw
	 4Mx+j0Y5GL1WQv//PFcyjnu7Mzd7jbs82fy0aK74PKm+R1B6eB+DKMasNzMylER/jO
	 KnUJJ0KBuxv00TT2P5DjcpJSoOIepMikp0zRLYUGJ4KdtBh5MMNf+FY8B/l+0rbXFa
	 E1M3eM9xJvUEw==
Date: Tue, 11 Jun 2024 11:36:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chancel Liu <chancel.liu@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [Patch v2 1/2] ASoC: fsl: Add i2s and pcm drivers for LPC32xx
 CPUs
Message-ID: <Zmgor8accyAiUkUO@finisterre.sirena.org.uk>
References: <[PATCH]ASoC:fsl:Addi2sandpcmdriversforLPC32xxCPUs>
 <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WW949k97zQLQvi69"
Content-Disposition: inline
In-Reply-To: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
X-Cookie: Your love life will be... interesting.


--WW949k97zQLQvi69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:47:51AM +0200, Piotr Wojtaszczyk wrote:

>  arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi |   4 +
>  arch/arm/mach-lpc32xx/phy3250.c        |  60 ++++

These architecture changes are separate and should at least be separate
commits, copied to the architecture maintainers.

> +FREESCALE SOC LPC32XX SOUND DRIVERS
> +M:	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> +L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Orphan
> +F:	sound/soc/fsl/lpc3xxx-*
> +

It seems a bit odd to add yourself as a maintainer while also marking
the driver as orphan?

> +config SND_SOC_FSL_LPC3XXX
> +	tristate "SoC Audio for NXP LPC32XX CPUs"
> +	depends on ARCH_LPC32XX && SND_SOC

On a quick scan I can't see any architecture dependency for build,
please add an || COMPILE_TEST for improved coverage.  As for all the
other things enabled in this Kconfig file there is no need to explicitly
depend on SND_SOC.

> @@ -42,6 +43,7 @@ obj-$(CONFIG_SND_SOC_FSL_XCVR) +=3D snd-soc-fsl-xcvr.o
>  obj-$(CONFIG_SND_SOC_FSL_AUD2HTX) +=3D snd-soc-fsl-aud2htx.o
>  obj-$(CONFIG_SND_SOC_FSL_RPMSG) +=3D snd-soc-fsl-rpmsg.o
>  obj-$(CONFIG_SND_SOC_POWERPC_QMC_AUDIO) +=3D snd-soc-fsl-qmc-audio.o
> +obj-$(CONFIG_SND_SOC_FSL_LPC3XXX) +=3D snd-soc-fsl-lpc3xxx.o
> =20
Please try to keep these files sorted alphabetically (it's not 100% at
the minute but no need to make it worse).

> --- /dev/null
> +++ b/sound/soc/fsl/lpc3xxx-i2s.c
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Author: Kevin Wells <kevin.wells@nxp.com>
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +static u32 absd32(u32 v1, u32 v2)
> +{
> +	if (v1 > v2)
> +		return v1 - v2;
> +	return v2 - v1;
> +}

Just use abs()?

> +static int lpc3xxx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned=
 int fmt)
> +{
> +	struct lpc3xxx_i2s_info *i2s_info_p =3D snd_soc_dai_get_drvdata(cpu_dai=
);
> +	struct device *dev =3D i2s_info_p->dev;
> +
> +	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) !=3D SND_SOC_DAIFMT_I2S) {
> +		dev_warn(dev, "unsupported bus format %d\n", fmt);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

If we're validating for I2S we should probably validate for clock
provider too.  Or just remove the function, it's not really needed?

> +	i2s_info_p->clk =3D devm_clk_get(dev, "i2s_clk");
> +	if (IS_ERR(i2s_info_p->clk))
> +		return dev_err_probe(dev, PTR_ERR(i2s_info_p->clk), "Can't get clock\n=
");
> +
> +	i2s_info_p->clkrate =3D clk_get_rate(i2s_info_p->clk);
> +	if (i2s_info_p->clkrate =3D=3D 0)
> +		return dev_err_probe(dev, -EINVAL, "Invalid returned clock rate\n");

Nothing ever enables this clock.

> +static int lpc32xx_i2s_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Remove empty functions, if they can legitimately be empty the framework
will support them being absent.

> +#define _SBF(f, v) ((v) << (f))

FIELD_PREP()

> +#define _BIT(n) _SBF(n, 1)

BIT().

> +/* I2S controller register offsets */
> +#define I2S_DAO		0x00
> +#define I2S_DAI		0x04
> +#define I2S_TX_FIFO	0x08
> +#define I2S_RX_FIFO	0x0C
> +#define I2S_STAT	0x10
> +#define I2S_DMA0	0x14
> +#define I2S_DMA1	0x18
> +#define I2S_IRQ		0x1C
> +#define I2S_TX_RATE	0x20
> +#define I2S_RX_RATE	0x24

Add a prefix to all these I2S_ names in case of collisions.

--WW949k97zQLQvi69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoKKsACgkQJNaLcl1U
h9DNgQf/bVmcCufP8jvhRnYGwhJ74PYfe8uGNqVDcvOPBqyxwbAHEcBkY4os9h6R
GoQMz21Qh+ZtEks0KjHFDl3Lnd51Kac5YBeyl5s/WRciIBOxe+jSqmW0GpRYZwZ+
YEMXUIyS6zA8Tik8onJLOtFrl4wLHXafkWOOPulK5v8+mZXYqPypwKq87c43IkrI
MviOLdW4TB0CVCKvk590+1YPY+ZBBAELM6eO/D9du/AyvN+BkUnZLO/VOwQ4enRQ
r2xnb2uSXMbDtKZKr4PbNw+9NbNaw9axfSzHbwXCu1Z0y+eOEKS1Vu2613VY9Al0
VKMHNg0tTYcWMk0XTzihz60mgPSf0A==
=srbB
-----END PGP SIGNATURE-----

--WW949k97zQLQvi69--

