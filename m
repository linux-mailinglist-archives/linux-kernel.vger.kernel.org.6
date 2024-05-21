Return-Path: <linux-kernel+bounces-185876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A04E8CBC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CC72822BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBE67E0E9;
	Wed, 22 May 2024 07:48:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A798E7C081
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364092; cv=none; b=uPTDFu0tJF6aEEdozcrftfPQi4/rdhQ0WRXcEb+itKneCSHjp4A24mFWc4gF4ZgpRyZTi0ted1e/rQNcPhyw1A/PeB2IfSIiLub5hGs9enbC59i4l24wgX/vRW0ky/NOTvmMslBUl/f8NNSqx6bldIYoiBSWN4Rpk165qGu3N8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364092; c=relaxed/simple;
	bh=UFileiIY+FcdENlfmaHs7dMmW4+IrMZlQd00Hn5+Gt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd5QQbS7l7BnD8mm+HdJa1kUXBAeNigwW67yVvIYkAGPLbtzxeLzaxxQ6FVHErUptZDZCKFOY5dlpvCfIs3an8OZgjB5yn/+1WF1Hj1H7Qwwdbdn2maMidXnPefXibwlGb+AArtJ6mHmCuxkZK2W7itT3nO+evgOqhFtVTAsMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s9ghS-00081G-2A; Wed, 22 May 2024 09:47:50 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s9ghP-002Uky-JB; Wed, 22 May 2024 09:47:47 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 50A9C2D520D;
	Tue, 21 May 2024 12:27:11 +0000 (UTC)
Date: Tue, 21 May 2024 14:27:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: RE: RE: [EXT] Re: [PATCH 4/4] firmware: imx: add driver for NXP
 EdgeLock Enclave
Message-ID: <20240521-handsome-hairy-bullfrog-d2faba-mkl@pengutronix.de>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
 <20240513-pretty-quartz-lemming-14d9ea-mkl@pengutronix.de>
 <AM9PR04MB86044FBF697375EB2C8D285B95EE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240520-accurate-intrepid-kestrel-8eb361-mkl@pengutronix.de>
 <AM9PR04MB86045BD682A0362A7D463C5A95EA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7yk6pkmeqxyudczq"
Content-Disposition: inline
In-Reply-To: <AM9PR04MB86045BD682A0362A7D463C5A95EA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--7yk6pkmeqxyudczq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.05.2024 11:57:04, Pankaj Gupta wrote:
> > > > > +
> > > > > +	memset(s_info, 0x0, sizeof(*s_info));
> > > > > +
> > > > > +	if (priv->mem_pool_name)
> > > > > +		get_info_data =3D get_phy_buf_mem_pool(dev,
> > > > > +						     priv->mem_pool_name,
> > > > > +						     &get_info_addr,
> > > > > +						     ELE_GET_INFO_BUFF_SZ);
> > > > > +	else
> > > > > +		get_info_data =3D dmam_alloc_coherent(dev,
> > > > > +						    ELE_GET_INFO_BUFF_SZ,
> > > > > +						    &get_info_addr,
> > > > > +						    GFP_KERNEL);
> > > >
> > > > It's better style to move the init of the dma memory into the probe
> > > > function.
> > >
> > > It is not DMA init. It is DMA allocation.
> >=20
> > It's better style to move the allocation of the dma memory into the pro=
be
> > function.
> >=20
> The buffer 'get_info_data', is allocated and freed within this function.
> This API is called multiple times:
> - as part of probe.
> - as part of suspend/resume.
>=20
> Why to keep the memory retained?

I see. Then why do you allocate with dmam_alloc_coherent()?

[...]

> > > > > +int imx_ele_msg_send(struct se_if_priv *priv, void *mssg) {
> > > > > +	bool is_cmd_lock_tobe_taken =3D false;
> > > > > +	int err;
> > > > > +
> > > > > +	if (!priv->waiting_rsp_dev || priv->no_dev_ctx_used) {
> > > > > +		is_cmd_lock_tobe_taken =3D true;
> > > > > +		mutex_lock(&priv->se_if_cmd_lock);
> > > > > +	}
> > > > > +	scoped_guard(mutex, &priv->se_if_lock);
> > > > > +
> > > > > +	err =3D mbox_send_message(priv->tx_chan, mssg);
> > > > > +	if (err < 0) {
> > > > > +		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> > > > > +		if (is_cmd_lock_tobe_taken)
> > > > > +			mutex_unlock(&priv->se_if_cmd_lock);
> > > >
> > > > Only dropping the lock in case of failure doesn't look right to me.
> > >
> > > The callers of this function, takes the execution flow to aborting the
> > > operation on getting return code < 0. No next action is expected under
> > > this aborted operation. Unlocking the lock here is not an issue
> > >
> > > > It seems you should better move the lock to the callers of this fun=
ction.
> > >
> > > Accepted, and moved to the caller of the function for:
> > >    - locking
> > >    - unlocking in case of error.
> > >
> > > Unlocking in the read API, once response is successfully received and
> > > read.
> >=20
> > A better design would be: imx_ele_msg_rcv() imx_ele_msg_send() are
> > expected to be called locked. Add lockdep_assert_held() to these functi=
on to
> > document/check this.
> >=20
> > The callers of imx_ele_msg_rcv() and imx_ele_msg_send() have to take ca=
re
> > of the locking.
> >=20
> > [...]
> >=20
> The locking/unlocking of se_if_cmd_lock, is taken care by the callers onl=
y:
> - imx_ele_msg_send_rcv calls both the functions:
>   --imx_ele_msg_send.
>   --imx_ele_msg_rcv.
>=20
> But the lockdep_assert_held, cannot be added to imx_ele_msg_send, as
> its another caller function imx_ele_miscdev_msg_send calls if for
> sending:
>  --- command (here command lock is taken).
>  --- response to a command (here command lock is not taken).

miscdev is another patch.

But why can't you use the same lock in imx_ele_miscdev_msg_send()?


> > > > > +static const struct imx_se_node_info_list imx93_info =3D {
> > > > > +	.num_mu =3D 1,
> > > > > +	.soc_id =3D SOC_ID_OF_IMX93,
> > > > > +	.info =3D {
> > > > > +			{
> > > > > +				.se_if_id =3D 2,
> > > > > +				.se_if_did =3D 3,
> > > > > +				.max_dev_ctx =3D 4,
> > > > > +				.cmd_tag =3D 0x17,
> > > > > +				.rsp_tag =3D 0xe1,
> > > > > +				.success_tag =3D 0xd6,
> > > > > +				.base_api_ver =3D MESSAGING_VERSION_6,
> > > > > +				.fw_api_ver =3D MESSAGING_VERSION_7,
> > > > > +				.se_name =3D "hsm1",
> > > > > +				.mbox_tx_name =3D "tx",
> > > > > +				.mbox_rx_name =3D "rx",
> > > > > +				.reserved_dma_ranges =3D true,
> > > > > +				.imem_mgmt =3D true,
> > > > > +				.soc_register =3D true,
> > > > > +			},
> > > > > +	},
> > > >
> > > >
> > > > Some (most?) members of these structs are the same. Why do you have
> > > > this abstraction if it's not needed right now?
> > >
> > > It is needed as the values is different for different NXP SoC
> > > compatible. It will be needed for NXP i.MX95 platform, whose code will
> > > be next in pipeline.
> >=20
> > How does the imx95 .info look like?
> >=20
> Copied from the internal repo.
> static const struct imx_info_list imx95_info =3D {
>         .num_mu =3D 4,
>         .soc_id =3D SOC_ID_OF_IMX95,
>         .info =3D {
>                         {
>                                 .socdev =3D false,
>                                 .mu_id =3D 2,
>                                 .mu_did =3D 3,
>                                 .max_dev_ctx =3D 4,
>                                 .cmd_tag =3D 0x17,
>                                 .rsp_tag =3D 0xe1,
>                                 .success_tag =3D 0xd6,
>                                 .base_api_ver =3D MESSAGING_VERSION_6,
>                                 .fw_api_ver =3D MESSAGING_VERSION_7,
>                                 .se_name =3D "hsm1",
>                                 .mbox_tx_name =3D "tx",
>                                 .mbox_rx_name =3D "rx",
>                                 .pool_name =3D NULL,
>                                 .reserved_dma_ranges =3D false,
>                                 .init_fw =3D true,
>                                 .v2x_state_check =3D true,
>                                 .start_rng =3D ele_start_rng,
>                                 .enable_ele_trng =3D true,
>                                 .imem_mgmt =3D false,
>                                 .mu_buff_size =3D 0,
>                                 .fw_name_in_rfs =3D NULL,
>                         },
>                         {
>                                 .socdev =3D false,
>                                 .mu_id =3D 0,
>                                 .mu_did =3D 0,
>                                 .max_dev_ctx =3D 0,
>                                 .cmd_tag =3D 0x17,
>                                 .rsp_tag =3D 0xe1,
>                                 .success_tag =3D 0xd6,
>                                 .base_api_ver =3D 0x2,
>                                 .fw_api_ver =3D 0x2,
>                                 .se_name =3D "v2x_dbg",
>                                 .pool_name =3D NULL,
>                                 .mbox_tx_name =3D "tx",
>                                 .mbox_rx_name =3D "rx",
>                                 .reserved_dma_ranges =3D false,
>                                 .init_fw =3D false,
>                                 .v2x_state_check =3D true,
>                                 .start_rng =3D v2x_start_rng,
>                                 .enable_ele_trng =3D false,
>                                 .imem_mgmt =3D false,
>                                 .mu_buff_size =3D 0,
>                                 .fw_name_in_rfs =3D NULL,
>                         },
>                         {
>                                 .socdev =3D false,
>                                 .mu_id =3D 4,
>                                 .mu_did =3D 0,
>                                 .max_dev_ctx =3D 4,
>                                 .cmd_tag =3D 0x18,
>                                 .rsp_tag =3D 0xe2,
>                                 .success_tag =3D 0xd6,
>                                 .base_api_ver =3D 0x2,
>                                 .fw_api_ver =3D 0x2,
>                                 .se_name =3D "v2x_sv0",
>                                 .pool_name =3D NULL,
>                                 .mbox_tx_name =3D "tx",
>                                 .mbox_rx_name =3D "rx",
>                                 .reserved_dma_ranges =3D false,
>                                 .init_fw =3D false,
>                                 .v2x_state_check =3D true,
>                                 .start_rng =3D NULL,
>                                 .enable_ele_trng =3D false,
>                                 .imem_mgmt =3D false,
>                                 .mu_buff_size =3D 16,
>                                 .fw_name_in_rfs =3D NULL,
>                         },
>                         {
>                                 .socdev =3D false,
>                                 .mu_id =3D 6,
>                                 .mu_did =3D 0,
>                                 .max_dev_ctx =3D 4,
>                                 .cmd_tag =3D 0x1a,
>                                 .rsp_tag =3D 0xe4,
>                                 .success_tag =3D 0xd6,
>                                 .base_api_ver =3D 0x2,
>                                 .fw_api_ver =3D 0x2,
>                                 .se_name =3D "v2x_she",
>                                 .pool_name =3D NULL,
>                                 .mbox_tx_name =3D "tx",
> 		   .mbox_rx_name =3D "rx",
>                                 .reserved_dma_ranges =3D false,
>                                 .init_fw =3D false,
>                                 .v2x_state_check =3D true,
>                                 .start_rng =3D NULL,
>                                 .enable_ele_trng =3D false,
>                                 .imem_mgmt =3D false,
>                                 .mu_buff_size =3D 16,
>                                 .fw_name_in_rfs =3D NULL,
>                         },
>                         {
>                                 .socdev =3D false,
>                                 .mu_id =3D 6,
>                                 .mu_did =3D 0,
>                                 .max_dev_ctx =3D 4,
>                                 .cmd_tag =3D 0x1a,
>                                 .rsp_tag =3D 0xe4,
>                                 .success_tag =3D 0xd6,
>                                 .base_api_ver =3D 0x2,
>                                 .fw_api_ver =3D 0x2,
>                                 .se_name =3D "v2x_she",
>                                 .pool_name =3D NULL,
>                                 .mbox_tx_name =3D "tx",
>                                 .mbox_rx_name =3D "rx",
>                                 .reserved_dma_ranges =3D false,
>                                 .init_fw =3D false,
>                                 .v2x_state_check =3D true,
>                                 .start_rng =3D NULL,
>                                 .enable_ele_trng =3D false,
>                                 .imem_mgmt =3D false,
>                                 .mu_buff_size =3D 256,
>                                 .fw_name_in_rfs =3D NULL,
>                         },
>         }
> };

Just looking at _some_, the .cmd_tag, .rsp_tag and .success_tag look the
same for all SoCs.

[...]

> Created a static variable g_soc_rev in the se_ctrl.c.
> Accepted and will correct it in v2.
>=20
> >=20
> > > > > +	if (info_list->soc_rev)
> > > > > +		return err;
> > > >
> Will change the above condition to g_soc_rev.

"g_" as is global? Don't do that. Use your priv!

[...]

> > > > > +
> > > > > +	info_list->soc_rev =3D s_info.soc_rev;
> > > > > +
> > > > > +	if (!info->soc_register)
> > > > > +		return 0;
> > > > > +
> > > > > +	attr =3D devm_kzalloc(dev, sizeof(*attr), GFP_KERNEL);
> > > > > +	if (!attr)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	if (s_info.minor_ver)
> > > > > +		attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%x.%x",
> > > > > +					   s_info.major_ver,
> > > > > +					   s_info.minor_ver);
> > > > > +	else
> > > > > +		attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%x",
> > > > > +					   s_info.major_ver);
> > > > > +
> > > > > +	switch (s_info.soc_id) {
> > > > > +	case SOC_ID_OF_IMX8ULP:
> > > > > +		attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
> > > > > +					      "i.MX8ULP");
> > > > > +		break;
> > > > > +	case SOC_ID_OF_IMX93:
> > > > > +		attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
> > > > > +					      "i.MX93");
> > > > > +		break;
> > > > > +	}
> > > > > +
> > > > > +	err =3D of_property_read_string(of_root, "model",
> > > > > +				      &attr->machine);
> > > > > +	if (err) {
> > > > > +		devm_kfree(dev, attr);
> > > >
> > > > Why do you do a manual cleanup of devm managed resources? Same
> > > > applies to the other devm managed resources, too.
> > > >
> > > Used devm managed memory, as this function is called as part probe.
> > > Post device registration, this devm managed memory is un-necessarily
> > > blocked. It is better to release it as part of clean-up, under this
> > > function only.
> >=20
> > Why do you allocate the memory with devm in the first place, if it's not
> > needed after probe?
>=20
> Sorry to confuse you. Actually the devm_memory will be needed for the cas=
e of soc_registration.
> Meaning, memory with devm, will be needed post probing as well.
>=20
> If this function fails, the probing will fail too. It will be auto cleane=
d.
>=20
> Accepted, will remove the devm_free in v2.

If you don't need the memory past probe() allocate with kzalloc() and
use kfree(). Only used managed resources for lifetimes beyond the probe
function.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7yk6pkmeqxyudczq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZMkxsACgkQKDiiPnot
vG+Z/Af/WMnqhWM48LnZtU6kUIbY7cRacggeGQv2jj71QpNxkSQ62f9qkFrUh3rS
Zmnt+uZAOghpnCADbwdGszNnOMR8saS83xmewg528L/7StvqR2/2N92ZGAfVC7Q1
BEn0/fwyAGSWnvNLgmeSGi0gDd+LxVQVfrkhqxSPSYvLCcZMJh0Q0VBiHlv2ikqt
Sf8hGPnZ5cyeNWzHucZ0luAWy2ilrU2fA9VUiuhrczVRJL4Rb6Tudswv7Dmb2DX2
jHSD3/RViGgDHR4xUVQnV2BW43sS220cKg8xQ5xeHgtOlxo/PvVfMPbCyrpZZJ11
Weuh3GM0jY/KBh4rxcm2VBE8FJOfgw==
=R/M7
-----END PGP SIGNATURE-----

--7yk6pkmeqxyudczq--

