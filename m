Return-Path: <linux-kernel+bounces-169614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DA8BCB37
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA261F25086
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2996142E89;
	Mon,  6 May 2024 09:50:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1914265C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989004; cv=none; b=Ylc8p5NCjU2c7be6savU6kes/Mptn8YhQ5/ynl6RkZbayQQnHrpFq/Tdb3kTb61R+FA5PpXHJtjsAoIa/yv3Qpd4yCG9Fi3zPTAwJH6pstcxXI0n0L4eMFjHTNQgdBDVhJDdIBPKxVpFvYvo58imd7UnL83XggqOPT02vlJq7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989004; c=relaxed/simple;
	bh=oPf4OegCtMS1cWBo4Xy+sDkXlsyJ0PkLaXkNDQj9s1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVKWTIRIYh3yn4uHEvrOZZyVvG7zknfn6CWNT3hOQCJQZlCd+cLGoxWt+j/K6Bza+mk8SN6FsroBQeojsQczQT9QaWEE5lmU8edb3Zu2NO0NXbHldQbP5/SCrgnuF1aXfamDVrJk3cW7YE9DMh/t31LlMtfb7MrV663fj1fOh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3uyg-0004td-9s; Mon, 06 May 2024 11:49:46 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3uyf-00GEx7-Hn; Mon, 06 May 2024 11:49:45 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1C33F2CB420;
	Mon, 06 May 2024 09:49:45 +0000 (UTC)
Date: Mon, 6 May 2024 11:49:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 5/6] can: mcp251xfd: add gpio functionality
Message-ID: <20240506-lean-strange-stork-3f7c67-mkl@pengutronix.de>
References: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
 <20240506-mcp251xfd-gpio-feature-v2-5-615b16fa8789@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w2lqxdcmcssatvzm"
Content-Disposition: inline
In-Reply-To: <20240506-mcp251xfd-gpio-feature-v2-5-615b16fa8789@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--w2lqxdcmcssatvzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.05.2024 07:59:47, Gregor Herburger wrote:
> The mcp251xfd devices allow two pins to be configured as gpio. Add this
> functionality to driver.
>=20
> Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> ---
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 173 +++++++++++++++++++=
++++++
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h      |   6 +
>  2 files changed, 179 insertions(+)
>=20
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net=
/can/spi/mcp251xfd/mcp251xfd-core.c
> index 4739ad80ef2a..de301f3a2f4e 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -16,6 +16,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> @@ -1768,6 +1769,172 @@ static int mcp251xfd_register_check_rx_int(struct=
 mcp251xfd_priv *priv)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_GPIOLIB
> +static const char * const mcp251xfd_gpio_names[] =3D {"GPIO0", "GPIO1"};
> +
> +static int mcp251xfd_gpio_request(struct gpio_chip *chip, unsigned int o=
ffset)
> +{
> +	struct mcp251xfd_priv *priv =3D gpiochip_get_data(chip);
> +	u32 pin_mask =3D MCP251XFD_REG_IOCON_PM0 << offset;
> +	int ret;
> +
> +	if (priv->rx_int && offset =3D=3D 1) {
> +		netdev_err(priv->ndev, "Can't use GPIO 1 with RX-INT!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D pm_runtime_resume_and_get(priv->ndev->dev.parent);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(priv->map_reg, MCP251XFD_REG_IOCON,
> +				  pin_mask, pin_mask);

The PM bits _should_ be 1 here, as it's the reset default.

But you have to convert mcp251xfd_chip_rx_int_enable() and
mcp251xfd_chip_rx_int_disable() to from regmap_write() to
regmap_update_bits(). Please do this in a separate patch before adding
the gpio support.

> +}

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--w2lqxdcmcssatvzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmY4p7UACgkQKDiiPnot
vG81OQf/QSbhG3kPD4JlGrR+11bLquKuYWbKLIdlVl8Nbckg4zSuVnYznwyPUvFK
VCpI/o0W7IqcPN9X8gxGue2as7rBtqyLkBqnQ2k5g4QMGH/8WPo6KIpeLjn9QTTF
tbn80CiVjtKdyGVDH+NNlb/a5qCLil93lj3PKVAmkX0bIbYIDTigwfea0lC8TUvA
dzHYAXfRsRQ/QtEv2IIxoTF8bK7jJbLruJhxyHjnp9qAKhSTENzAViuE9FZ15hXK
Bdadbqz1wSSQ9Sphl43+PPAXRl7N1mUkSlDKUgM5aMyeuTuVIhK0dj2TAzre0spg
+uQWde21p/FLn45ECXeuh2uYcGcFpA==
=MRFK
-----END PGP SIGNATURE-----

--w2lqxdcmcssatvzm--

