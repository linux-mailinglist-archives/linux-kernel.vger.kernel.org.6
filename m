Return-Path: <linux-kernel+bounces-423133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A09DA343
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1862B1622E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F705154BEA;
	Wed, 27 Nov 2024 07:42:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296C1547C0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693354; cv=none; b=BtKgB2/xFl985X288DFxWi1n5cH+kbQT776E/UWt8GJ8FMjx/631v1V4JQeyEixe4T7gA4IAXAdea2hdGYOZx1FjsxILe7ZS/OO3RsJOrqg2inHwlKh+sUqHHK59BODS2GPsBk33djb7sB20XugZNFSvktpNfzd/s/3aN454YdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693354; c=relaxed/simple;
	bh=5vv8IHHMQtHAOQk523vzxTXpY6w+84T4PwVdQXLrQDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRKGtic1puvUynVQ9ZPOaDvBUWoTvJhyLYCK44ic+rZSa3WTMA32XdZp+LQ1i/zrj2omvnPh/48FVMQnOfUhBhy4IuVPCIYTZ5sJtbcEszxBnalS/KOU1ocqhAH5jR3t5AzxgdeoEfTjquk5v8jh56XEXJSS8O13n1+mM3gCODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tGCgn-0002io-EU; Wed, 27 Nov 2024 08:42:21 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tGCgm-000OCN-15;
	Wed, 27 Nov 2024 08:42:21 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C46AA37E17B;
	Wed, 27 Nov 2024 07:42:20 +0000 (UTC)
Date: Wed, 27 Nov 2024 08:42:20 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: carlos.song@nxp.com
Cc: frank.li@nxp.com, o.rempel@pengutronix.de, kernel@pengutronix.de, 
	andi.shyti@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: imx: support DMA defer probing
Message-ID: <20241127-ninja-dormouse-of-bloom-8ee494-mkl@pengutronix.de>
References: <20241127074458.2102112-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uslwfux5gvanalae"
Content-Disposition: inline
In-Reply-To: <20241127074458.2102112-1-carlos.song@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--uslwfux5gvanalae
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] i2c: imx: support DMA defer probing
MIME-Version: 1.0

On 27.11.2024 15:44:58, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>=20
> Return -EPROBE_DEFER when dma_request_slave_channel() because DMA driver
> have not ready yet.
>=20
> Move i2c_imx_dma_request() before registering I2C adapter to avoid
> infinite loop of .probe() calls to the same driver, see "e8c220fac415
> Revert "i2c: imx: improve the error handling in i2c_imx_dma_request()""
> and "Documentation/driver-api/driver-model/driver.rst".
>=20
> Use CPU mode to avoid stuck registering i2c adapter when DMA resources
> are unavailable.
>=20
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
> Change for V3:
> - According to Marc's comment, remove error print when defer probe.
>   Add info log when DMA has not been enabled and add error log when
>   DMA error, both won't stuck the i2c adapter register, just for remindin=
g,
>   i2c adapter is working only in PIO mode.=20
> Change for V2:
> - According to Frank's comments, wrap at 75 char and Simplify fix code
>   at i2c_imx_dma_request().
> - Use strict patch check, fix alignment warning at i2c_imx_dma_request()
> ---
>  drivers/i2c/busses/i2c-imx.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 5ed4cb61e262..47112a38d034 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -397,17 +397,16 @@ static void i2c_imx_reset_regs(struct imx_i2c_struc=
t *i2c_imx)
>  }
> =20
>  /* Functions for DMA support */
> -static void i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> -						dma_addr_t phy_addr)
> +static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx, dma_addr_=
t phy_addr)
>  {
>  	struct imx_i2c_dma *dma;
>  	struct dma_slave_config dma_sconfig;
> -	struct device *dev =3D &i2c_imx->adapter.dev;
> +	struct device *dev =3D i2c_imx->adapter.dev.parent;
>  	int ret;
> =20
>  	dma =3D devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
>  	if (!dma)
> -		return;
> +		return -ENOMEM;
> =20
>  	dma->chan_tx =3D dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->chan_tx)) {
> @@ -452,7 +451,7 @@ static void i2c_imx_dma_request(struct imx_i2c_struct=
 *i2c_imx,
>  	dev_info(dev, "using %s (tx) and %s (rx) for DMA transfers\n",
>  		dma_chan_name(dma->chan_tx), dma_chan_name(dma->chan_rx));
> =20
> -	return;
> +	return 0;
> =20
>  fail_rx:
>  	dma_release_channel(dma->chan_rx);
> @@ -460,6 +459,8 @@ static void i2c_imx_dma_request(struct imx_i2c_struct=
 *i2c_imx,
>  	dma_release_channel(dma->chan_tx);
>  fail_al:
>  	devm_kfree(dev, dma);
> +
> +	return ret;
>  }
> =20
>  static void i2c_imx_dma_callback(void *arg)
> @@ -1803,6 +1804,23 @@ static int i2c_imx_probe(struct platform_device *p=
dev)
>  	if (ret =3D=3D -EPROBE_DEFER)
>  		goto clk_notifier_unregister;
> =20
> +	/*
> +	 * Init DMA config if supported, -ENODEV means DMA not enabled at
> +	 * this platform, that is not a real error, so just remind "only
> +	 * PIO mode is used". If DMA is enabled, but meet error when request
> +	 * DMA channel, error should be showed in probe error log. PIO mode
> +	 * should be available regardless of DMA.
> +	 */
> +	ret =3D i2c_imx_dma_request(i2c_imx, phy_addr);
> +	if (ret) {
> +		if (ret =3D=3D -EPROBE_DEFER)
> +			goto clk_notifier_unregister;
> +		else if (ret =3D=3D -ENODEV)
> +			dev_info(&pdev->dev, "Only use PIO mode\n");

On a system without DMA configured, with this patch we now get this info
message that wasn't there before. I think this might annoy some people,
so you should remove it.

regards,
Marc

> +		else
> +			dev_err_probe(&pdev->dev, ret, "Failed to setup DMA, only use PIO mod=
e\n");
> +	}
> +
>  	/* Add I2C adapter */
>  	ret =3D i2c_add_numbered_adapter(&i2c_imx->adapter);
>  	if (ret < 0)
> @@ -1817,9 +1835,6 @@ static int i2c_imx_probe(struct platform_device *pd=
ev)
>  		i2c_imx->adapter.name);
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
> =20
> -	/* Init DMA config if supported */
> -	i2c_imx_dma_request(i2c_imx, phy_addr);
> -
>  	return 0;   /* Return OK */
> =20
>  clk_notifier_unregister:
> --=20
> 2.34.1
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uslwfux5gvanalae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdGzVkACgkQKDiiPnot
vG/p/gf/dNbUgrCuDN9PCQSS3wFnlsgOdh8NYGwvCYGdpCKsCEV5ka+ZsoeG3Gs3
sL9ZpngFs6mYthktAyMv7JYNeC8swoxZCNAlxbOoqcp3DO6Xea4Iw6mA/RCmbzQU
5AdJ0SdFYCIZSyklxCdnftN5IC0Ss9bKBbWNh/u4DwfIgImX3NdmH3I9ICRy+Q3r
iIqAmqDA89AlPQbvzpNb2C3hhlLIRMpLzQX2CMwxLacuEBlG6ipHWZp1dLJ44U5N
PYg1rrZxYvq/ALYAYLiCz7HbpNtPnRADB0TU336iG8/KhjfvmZhRY7wG8hju2hEU
3RrT9AlFcC69Gp8TDMvlFrs8YqEEcA==
=wCoA
-----END PGP SIGNATURE-----

--uslwfux5gvanalae--

