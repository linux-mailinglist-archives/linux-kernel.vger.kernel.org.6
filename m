Return-Path: <linux-kernel+bounces-186119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9918CC005
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AC51C21CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A268289C;
	Wed, 22 May 2024 11:11:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983582891
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376281; cv=none; b=Hy0rgmHB0BeViV/EXKoPVCmFNAc7+KrgeWjpYeQyQUM17UhQjxiHmn9i0qG8YsHrdJYikFIp1w7BDPkCCSTjExWRav8Bqe831F6x/40chGT0j3cvkYTBJm5wi7nOSiCHF2LCtesnflKYMbHy9F3E1MDrdvpm6m2d6qaIoCABp+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376281; c=relaxed/simple;
	bh=7omBT22T50M9DG8qe8VMelQgsvVyR3ldDWD333kj6JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDNJx9c4wkY6zD66orFlDy6M8lUOfr8hhWGqALuUQz7wnYT80tzeMMkGdfJmLX1dEYAY2/MOU6I8s3aPSIkwgSiM/ClTBvABss9+FUytzZyVLmetTQZQuLA1kjpSl/tFzpDJUX200xkqe+9HeOUQP/RXgmTYsgzX7l/I2aR6kxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s9jrx-0003mj-8q; Wed, 22 May 2024 13:10:53 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s9jrw-002Vuu-BD; Wed, 22 May 2024 13:10:52 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E087A2D669B;
	Wed, 22 May 2024 11:10:51 +0000 (UTC)
Date: Wed, 22 May 2024 13:10:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: RE: RE: RE: [EXT] Re: [PATCH 4/4] firmware: imx: add driver for
 NXP EdgeLock Enclave
Message-ID: <20240522-prudent-puffin-of-painting-d2f1c3-mkl@pengutronix.de>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
 <20240513-pretty-quartz-lemming-14d9ea-mkl@pengutronix.de>
 <AM9PR04MB86044FBF697375EB2C8D285B95EE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240520-accurate-intrepid-kestrel-8eb361-mkl@pengutronix.de>
 <AM9PR04MB86045BD682A0362A7D463C5A95EA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240521-handsome-hairy-bullfrog-d2faba-mkl@pengutronix.de>
 <AM9PR04MB8604836B3211B6D74878D04795EB2@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4wc3bdscyxbqok4p"
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604836B3211B6D74878D04795EB2@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--4wc3bdscyxbqok4p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.05.2024 10:46:10, Pankaj Gupta wrote:
> > > > > > > +
> > > > > > > +	memset(s_info, 0x0, sizeof(*s_info));
> > > > > > > +
> > > > > > > +	if (priv->mem_pool_name)
> > > > > > > +		get_info_data =3D get_phy_buf_mem_pool(dev,
> > > > > > > +						     priv-
> > >mem_pool_name,
> > > > > > > +						     &get_info_addr,
> > > > > > > +
> > ELE_GET_INFO_BUFF_SZ);
> > > > > > > +	else
> > > > > > > +		get_info_data =3D dmam_alloc_coherent(dev,
> > > > > > > +
> > ELE_GET_INFO_BUFF_SZ,
> > > > > > > +						    &get_info_addr,
> > > > > > > +						    GFP_KERNEL);
> > > > > >
> > > > > > It's better style to move the init of the dma memory into the
> > > > > > probe function.
> > > > >
> > > > > It is not DMA init. It is DMA allocation.
> > > >
> > > > It's better style to move the allocation of the dma memory into the
> > > > probe function.
> > > >
> > > The buffer 'get_info_data', is allocated and freed within this functi=
on.
> > > This API is called multiple times:
> > > - as part of probe.
> > > - as part of suspend/resume.
> > >
> > > Why to keep the memory retained?
> >=20
> > I see. Then why do you allocate with dmam_alloc_coherent()?
>=20
> Because this memory is written by Firmware. It should be either from SRAM
> Or from reserved memory region, accessible to FW.

It's about managed resources. Why don't you use dma_alloc_coherent()?

> > > > > > > +int imx_ele_msg_send(struct se_if_priv *priv, void *mssg) {
> > > > > > > +	bool is_cmd_lock_tobe_taken =3D false;
> > > > > > > +	int err;
> > > > > > > +
> > > > > > > +	if (!priv->waiting_rsp_dev || priv->no_dev_ctx_used) {
> > > > > > > +		is_cmd_lock_tobe_taken =3D true;
> > > > > > > +		mutex_lock(&priv->se_if_cmd_lock);
> > > > > > > +	}
> > > > > > > +	scoped_guard(mutex, &priv->se_if_lock);
> > > > > > > +
> > > > > > > +	err =3D mbox_send_message(priv->tx_chan, mssg);
> > > > > > > +	if (err < 0) {
> > > > > > > +		dev_err(priv->dev, "Error: mbox_send_message
> > failure.\n");
> > > > > > > +		if (is_cmd_lock_tobe_taken)
> > > > > > > +			mutex_unlock(&priv->se_if_cmd_lock);
> > > > > >
> > > > > > Only dropping the lock in case of failure doesn't look right to=
 me.
> > > > >
> > > > > The callers of this function, takes the execution flow to aborting
> > > > > the operation on getting return code < 0. No next action is
> > > > > expected under this aborted operation. Unlocking the lock here is
> > > > > not an issue
> > > > >
> > > > > > It seems you should better move the lock to the callers of this=
 function.
> > > > >
> > > > > Accepted, and moved to the caller of the function for:
> > > > >    - locking
> > > > >    - unlocking in case of error.
> > > > >
> > > > > Unlocking in the read API, once response is successfully received
> > > > > and read.
> > > >
> > > > A better design would be: imx_ele_msg_rcv() imx_ele_msg_send() are
> > > > expected to be called locked. Add lockdep_assert_held() to these
> > > > function to document/check this.
> > > >
> > > > The callers of imx_ele_msg_rcv() and imx_ele_msg_send() have to take
> > > > care of the locking.
> > > >
> > > > [...]
> > > >
> > > The locking/unlocking of se_if_cmd_lock, is taken care by the callers=
 only:
> > > - imx_ele_msg_send_rcv calls both the functions:
> > >   --imx_ele_msg_send.
> > >   --imx_ele_msg_rcv.
> > >
> > > But the lockdep_assert_held, cannot be added to imx_ele_msg_send, as
> > > its another caller function imx_ele_miscdev_msg_send calls if for
> > > sending:
> > >  --- command (here command lock is taken).
> > >  --- response to a command (here command lock is not taken).
> >=20
> > miscdev is another patch.
> Will try to split it.
>=20
> >=20
> > But why can't you use the same lock in imx_ele_miscdev_msg_send()?
> Using the same lock "se_if_cmd_lock", in imx_ele_miscdev_msg_send.
> This function is called from fops_write. This lock is taken conditionally=
 taken depending on the kind of message:
>=20
>   --- Message containing command (here command lock is taken).
>   --- Message containing response to a command (here command lock is not =
taken).

Let's design a proper the kernel internal interface first. For
simplicity reasons the misc dev should be out of scope first.

> > > > > > > +static const struct imx_se_node_info_list imx93_info =3D {
> > > > > > > +	.num_mu =3D 1,
> > > > > > > +	.soc_id =3D SOC_ID_OF_IMX93,
> > > > > > > +	.info =3D {
> > > > > > > +			{
> > > > > > > +				.se_if_id =3D 2,
> > > > > > > +				.se_if_did =3D 3,
> > > > > > > +				.max_dev_ctx =3D 4,
> > > > > > > +				.cmd_tag =3D 0x17,
> > > > > > > +				.rsp_tag =3D 0xe1,
> > > > > > > +				.success_tag =3D 0xd6,
> > > > > > > +				.base_api_ver =3D
> > MESSAGING_VERSION_6,
> > > > > > > +				.fw_api_ver =3D
> > MESSAGING_VERSION_7,
> > > > > > > +				.se_name =3D "hsm1",
> > > > > > > +				.mbox_tx_name =3D "tx",
> > > > > > > +				.mbox_rx_name =3D "rx",
> > > > > > > +				.reserved_dma_ranges =3D true,
> > > > > > > +				.imem_mgmt =3D true,
> > > > > > > +				.soc_register =3D true,
> > > > > > > +			},
> > > > > > > +	},
> > > > > >
> > > > > >
> > > > > > Some (most?) members of these structs are the same. Why do you
> > > > > > have this abstraction if it's not needed right now?
> > > > >
> > > > > It is needed as the values is different for different NXP SoC
> > > > > compatible. It will be needed for NXP i.MX95 platform, whose code
> > > > > will be next in pipeline.
> > > >
> > > > How does the imx95 .info look like?
> > > >
> > > Copied from the internal repo.
> > > static const struct imx_info_list imx95_info =3D {
> > >         .num_mu =3D 4,
> > >         .soc_id =3D SOC_ID_OF_IMX95,
> > >         .info =3D {
> > >                         {
> > >                                 .socdev =3D false,
> > >                                 .mu_id =3D 2,
> > >                                 .mu_did =3D 3,
> > >                                 .max_dev_ctx =3D 4,
> > >                                 .cmd_tag =3D 0x17,
> > >                                 .rsp_tag =3D 0xe1,
> > >                                 .success_tag =3D 0xd6,
> > >                                 .base_api_ver =3D MESSAGING_VERSION_6,
> > >                                 .fw_api_ver =3D MESSAGING_VERSION_7,
> > >                                 .se_name =3D "hsm1",
> > >                                 .mbox_tx_name =3D "tx",
> > >                                 .mbox_rx_name =3D "rx",
> > >                                 .pool_name =3D NULL,
> > >                                 .reserved_dma_ranges =3D false,
> > >                                 .init_fw =3D true,
> > >                                 .v2x_state_check =3D true,
> > >                                 .start_rng =3D ele_start_rng,
> > >                                 .enable_ele_trng =3D true,
> > >                                 .imem_mgmt =3D false,
> > >                                 .mu_buff_size =3D 0,
> > >                                 .fw_name_in_rfs =3D NULL,
> > >                         },
> > >                         {
> > >                                 .socdev =3D false,
> > >                                 .mu_id =3D 0,
> > >                                 .mu_did =3D 0,
> > >                                 .max_dev_ctx =3D 0,
> > >                                 .cmd_tag =3D 0x17,
> > >                                 .rsp_tag =3D 0xe1,
> > >                                 .success_tag =3D 0xd6,
> > >                                 .base_api_ver =3D 0x2,
> > >                                 .fw_api_ver =3D 0x2,
> > >                                 .se_name =3D "v2x_dbg",
> > >                                 .pool_name =3D NULL,
> > >                                 .mbox_tx_name =3D "tx",
> > >                                 .mbox_rx_name =3D "rx",
> > >                                 .reserved_dma_ranges =3D false,
> > >                                 .init_fw =3D false,
> > >                                 .v2x_state_check =3D true,
> > >                                 .start_rng =3D v2x_start_rng,
> > >                                 .enable_ele_trng =3D false,
> > >                                 .imem_mgmt =3D false,
> > >                                 .mu_buff_size =3D 0,
> > >                                 .fw_name_in_rfs =3D NULL,
> > >                         },
> > >                         {
> > >                                 .socdev =3D false,
> > >                                 .mu_id =3D 4,
> > >                                 .mu_did =3D 0,
> > >                                 .max_dev_ctx =3D 4,
> > >                                 .cmd_tag =3D 0x18,
> > >                                 .rsp_tag =3D 0xe2,
> > >                                 .success_tag =3D 0xd6,
> > >                                 .base_api_ver =3D 0x2,
> > >                                 .fw_api_ver =3D 0x2,
> > >                                 .se_name =3D "v2x_sv0",
> > >                                 .pool_name =3D NULL,
> > >                                 .mbox_tx_name =3D "tx",
> > >                                 .mbox_rx_name =3D "rx",
> > >                                 .reserved_dma_ranges =3D false,
> > >                                 .init_fw =3D false,
> > >                                 .v2x_state_check =3D true,
> > >                                 .start_rng =3D NULL,
> > >                                 .enable_ele_trng =3D false,
> > >                                 .imem_mgmt =3D false,
> > >                                 .mu_buff_size =3D 16,
> > >                                 .fw_name_in_rfs =3D NULL,
> > >                         },
> > >                         {
> > >                                 .socdev =3D false,
> > >                                 .mu_id =3D 6,
> > >                                 .mu_did =3D 0,
> > >                                 .max_dev_ctx =3D 4,
> > >                                 .cmd_tag =3D 0x1a,
> > >                                 .rsp_tag =3D 0xe4,
> > >                                 .success_tag =3D 0xd6,
> > >                                 .base_api_ver =3D 0x2,
> > >                                 .fw_api_ver =3D 0x2,
> > >                                 .se_name =3D "v2x_she",
> > >                                 .pool_name =3D NULL,
> > >                                 .mbox_tx_name =3D "tx",
> > > 		   .mbox_rx_name =3D "rx",
> > >                                 .reserved_dma_ranges =3D false,
> > >                                 .init_fw =3D false,
> > >                                 .v2x_state_check =3D true,
> > >                                 .start_rng =3D NULL,
> > >                                 .enable_ele_trng =3D false,
> > >                                 .imem_mgmt =3D false,
> > >                                 .mu_buff_size =3D 16,
> > >                                 .fw_name_in_rfs =3D NULL,
> > >                         },
> > >                         {
> > >                                 .socdev =3D false,
> > >                                 .mu_id =3D 6,
> > >                                 .mu_did =3D 0,
> > >                                 .max_dev_ctx =3D 4,
> > >                                 .cmd_tag =3D 0x1a,
> > >                                 .rsp_tag =3D 0xe4,
> > >                                 .success_tag =3D 0xd6,
> > >                                 .base_api_ver =3D 0x2,
> > >                                 .fw_api_ver =3D 0x2,
> > >                                 .se_name =3D "v2x_she",
> > >                                 .pool_name =3D NULL,
> > >                                 .mbox_tx_name =3D "tx",
> > >                                 .mbox_rx_name =3D "rx",
> > >                                 .reserved_dma_ranges =3D false,
> > >                                 .init_fw =3D false,
> > >                                 .v2x_state_check =3D true,
> > >                                 .start_rng =3D NULL,
> > >                                 .enable_ele_trng =3D false,
> > >                                 .imem_mgmt =3D false,
> > >                                 .mu_buff_size =3D 256,
> > >                                 .fw_name_in_rfs =3D NULL,
> > >                         },
> > >         }
> > > };
> >=20
> > Just looking at _some_, the .cmd_tag, .rsp_tag and .success_tag look the
> > same for all SoCs.
> .cmd_tag & .rsp_tag is varying for each: .se_name =3D "v2x_dbg",  .se_nam=
e =3D "v2x_she" and .se_name =3D "v2x_sv0",
>=20
> .success_tag is going to be different for i.MX8DXL. It will be zero for i=
=2EMX8DXL, as compared to current 0xD6, for i.MX8ULP, 93, 95
>=20
>=20
> >=20
> > [...]
> >=20
> > > Created a static variable g_soc_rev in the se_ctrl.c.
> > > Accepted and will correct it in v2.
> > >
> > > >
> > > > > > > +	if (info_list->soc_rev)
> > > > > > > +		return err;
> > > > > >
> > > Will change the above condition to g_soc_rev.
> >=20
> > "g_" as is global? Don't do that. Use your priv!
> Yes, soc_rev can be put under priv.
> It is proposed like this as it is used only once, that too in this file o=
nly.
>=20
> Will do this in V2.

If it's only used once, pass it via a function parameter. If you need it
past probe, put in priv.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4wc3bdscyxbqok4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZN0rgACgkQKDiiPnot
vG+q4Qf/XqaBftWbRVbl/NctWjNZD/C46y07kkG6ge99GnSoO+uBteK3qqypznFi
qch37xcHzvy1w4IiInZm2HzPFPRv2WAqu/BNbtRFQ5RUZUcKQNl2hCzX7GsVpQ1P
RWqUJBhzYXD83UnURjWEBKvf2UB+Gaxqyn5zYsp7yj+wHaBI8jp9tQPvfZtCnsUj
IrgOvnxD5Tze5V5uAEn53uxcEdYwYZqK5F3mNUWeT5n9fU1GhGVbLgnrXjVfVpDk
5P2WoU4C5McfOedvEssrKmkyW05j3m2j2JHogVLehE+z/5/jS6vS5ZnbsqspTzuY
BUAEKqVxDzR7x9sj8YeIs7t29uwTEw==
=2orR
-----END PGP SIGNATURE-----

--4wc3bdscyxbqok4p--

