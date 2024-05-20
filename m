Return-Path: <linux-kernel+bounces-183638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F7E8C9BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC23A1F20F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C445553390;
	Mon, 20 May 2024 11:02:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED04DA09
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202968; cv=none; b=ubC+YwVhrOwtpJE8wF4SdukGl91tS3qvzkQYlRYr7VXTEvFq4TBU22AHbaHvfg+gjTDcoc+wK6QU0cOrtQeXQooDsXFStOnb1gDMq00Xw7tn8sr6qXfCKQXJIVzghnhQwnB2cocKq4XjTK0vnrsWu7/S6zvb8WAj2S7DgG4p+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202968; c=relaxed/simple;
	bh=HfVSPCkIpBgqSPj4OEA1+CzolRA2i1yxTJWqE1IWoyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNzQNHIh2kZm8LKtAdC1u1cw03tUwlMTW9W6iGHiUoKcO/G0tf7J/3XeOyjnBxI56DDv9Q62iQB5YyfbkcW9ljL4MHcD3s49GeX5qLFGrMB21zdA6MfV/LqfPBiYg6GH+a2OzWgAsv3bJAYRa/bfLfj9jUdbklGp4GdReyoFtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s90mW-0007PH-Eo; Mon, 20 May 2024 13:02:16 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s90mT-002FDk-08; Mon, 20 May 2024 13:02:13 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 88E852D40C2;
	Mon, 20 May 2024 11:02:12 +0000 (UTC)
Date: Mon, 20 May 2024 13:02:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: RE: [EXT] Re: [PATCH 4/4] firmware: imx: add driver for NXP
 EdgeLock Enclave
Message-ID: <20240520-accurate-intrepid-kestrel-8eb361-mkl@pengutronix.de>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-4-27c5a674916d@nxp.com>
 <20240513-pretty-quartz-lemming-14d9ea-mkl@pengutronix.de>
 <AM9PR04MB86044FBF697375EB2C8D285B95EE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dvuxbbj5nymmnkgy"
Content-Disposition: inline
In-Reply-To: <AM9PR04MB86044FBF697375EB2C8D285B95EE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--dvuxbbj5nymmnkgy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.05.2024 11:24:46, Pankaj Gupta wrote:
> > > new file mode 100644
> > > index 000000000000..0463f26d93c7
> > > --- /dev/null
> > > +++ b/drivers/firmware/imx/ele_base_msg.c
> > > @@ -0,0 +1,287 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2024 NXP
> > > + */
> > > +
> > > +#include <linux/types.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/dma-mapping.h>
> > > +
> > > +#include "ele_base_msg.h"
> > > +#include "ele_common.h"
> > > +
> > > +int ele_get_info(struct device *dev, struct soc_info *s_info)
> > > +{
> > > +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > > +	struct se_api_msg *tx_msg __free(kfree);
> > > +	struct se_api_msg *rx_msg __free(kfree);
> > > +	phys_addr_t get_info_addr;
> > > +	u32 *get_info_data;
> > > +	u32 status;
> > > +	int ret;
> > > +
> > > +	if (!priv || !s_info)
> > > +		goto exit;
> >=20
> > You should code properly, so that this doesn't happen, your cleanup is
> > broken, it will work on uninitialized data, as Sascha already mentioned.
>=20
> The API(s) part of this file will be later exported and might get used by=
 driver/crypto/ele/*.c.
> Still if you think, this check should be removed, I will do it in v2.

It makes no sense to call these functions with NULL pointers, if you do
so, it's a mistake by the caller. If it's used by some other part of the
ele driver that should be coded properly.

> > > +
> > > +	memset(s_info, 0x0, sizeof(*s_info));
> > > +
> > > +	if (priv->mem_pool_name)
> > > +		get_info_data =3D get_phy_buf_mem_pool(dev,
> > > +						     priv->mem_pool_name,
> > > +						     &get_info_addr,
> > > +						     ELE_GET_INFO_BUFF_SZ);
> > > +	else
> > > +		get_info_data =3D dmam_alloc_coherent(dev,
> > > +						    ELE_GET_INFO_BUFF_SZ,
> > > +						    &get_info_addr,
> > > +						    GFP_KERNEL);
> >=20
> > It's better style to move the init of the dma memory into the probe
> > function.
>=20
> It is not DMA init. It is DMA allocation.

It's better style to move the allocation of the dma memory into the
probe function.


[...]

> > > +	priv->rx_msg =3D rx_msg;
> > > +	ret =3D imx_ele_msg_send_rcv(priv, tx_msg);
> >=20
> > This API looks strange, why put the tx_msg as a parameter the rx_msg
> > into the private struct?
>=20
> The rx_msg is the populated in the interrupt context. Hence, it kept
> as part of private structure; which is in-turn associated with
> mbox_client.

These are implementation details, it just feels strange to pass one
parameter via an arguments and put the other in the private pointer.

> Though, in v2 moving the rx_msg setting to imx_ele_msg_send_rcv(priv,
> tx_msg, rx_msg);

fine

[...]

> > > +	if (status !=3D priv->success_tag) {
> > > +		dev_err(dev, "Command Id[%d], Response Failure =3D 0x%x",
> > > +			ELE_GET_INFO_REQ, status);
> > > +		ret =3D -1;
> > > +	}
> > > +
> > > +	s_info->imem_state =3D (get_info_data[ELE_IMEM_STATE_WORD]
> > > +				& ELE_IMEM_STATE_MASK) >> 16;
> >=20
> > can you use a struct for get_info_data and use FIELD_GET() (if needed)
>=20
> Re-write the structure soc_info, matching the information provided in
> response to this api.

Looks better. Please compile the driver and check with "pahole" that the
layout of these structures doesn't contain any unwanted padding.
Otherwise add "__packed" and if you can guarantee "__aligned(4)".

> struct dev_info {
>         uint8_t  cmd;
>         uint8_t  ver;
>         uint16_t length;
>         uint16_t soc_id;
>         uint16_t soc_rev;
>         uint16_t lmda_val;
>         uint8_t  ssm_state;
>         uint8_t  dev_atts_api_ver;
>         uint8_t  uid[MAX_UID_SIZE];
>         uint8_t  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
>         uint8_t  sha_fw[DEV_GETINFO_FW_SHA_SZ];
> };
>=20
> struct dev_addn_info {
>         uint8_t  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
>         uint8_t  trng_state;
>         uint8_t  csal_state;
>         uint8_t  imem_state;
>         uint8_t  reserved2;
> };
>=20
> struct soc_info {
>         struct dev_info d_info;
>         struct dev_addn_info d_addn_info;
> };

[...]

> > > +int imx_ele_msg_send(struct se_if_priv *priv, void *mssg)
> > > +{
> > > +	bool is_cmd_lock_tobe_taken =3D false;
> > > +	int err;
> > > +
> > > +	if (!priv->waiting_rsp_dev || priv->no_dev_ctx_used) {
> > > +		is_cmd_lock_tobe_taken =3D true;
> > > +		mutex_lock(&priv->se_if_cmd_lock);
> > > +	}
> > > +	scoped_guard(mutex, &priv->se_if_lock);
> > > +
> > > +	err =3D mbox_send_message(priv->tx_chan, mssg);
> > > +	if (err < 0) {
> > > +		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> > > +		if (is_cmd_lock_tobe_taken)
> > > +			mutex_unlock(&priv->se_if_cmd_lock);
> >=20
> > Only dropping the lock in case of failure doesn't look right to me.
>=20
> The callers of this function, takes the execution flow to aborting the
> operation on getting return code < 0. No next action is expected under
> this aborted operation. Unlocking the lock here is not an issue
>=20
> > It seems you should better move the lock to the callers of this functio=
n.
>
> Accepted, and moved to the caller of the function for:
>    - locking
>    - unlocking in case of error.
>=20
> Unlocking in the read API, once response is successfully received and
> read.

A better design would be: imx_ele_msg_rcv() imx_ele_msg_send() are
expected to be called locked. Add lockdep_assert_held() to these
function to document/check this.

The callers of imx_ele_msg_rcv() and imx_ele_msg_send() have to take
care of the locking.

[...]

> > > +static const struct imx_se_node_info_list imx8ulp_info =3D {
> > > +	.num_mu =3D 1,
> > > +	.soc_id =3D SOC_ID_OF_IMX8ULP,
> > > +	.info =3D {
> > > +			{
> > > +				.se_if_id =3D 2,
> > > +				.se_if_did =3D 7,
> > > +				.max_dev_ctx =3D 4,
> > > +				.cmd_tag =3D 0x17,
> > > +				.rsp_tag =3D 0xe1,
> > > +				.success_tag =3D 0xd6,
> > > +				.base_api_ver =3D MESSAGING_VERSION_6,
> > > +				.fw_api_ver =3D MESSAGING_VERSION_7,
> > > +				.se_name =3D "hsm1",
> > > +				.mbox_tx_name =3D "tx",
> > > +				.mbox_rx_name =3D "rx",
> > > +				.pool_name =3D "sram",
> > > +				.fw_name_in_rfs =3D IMX_ELE_FW_DIR\
> >                                                                 ^
> >                                                            not needed
>=20
> It is needed for i.MX8ULP, dual FW support.

The backslash is not needed.

>=20
> > > +						  "mx8ulpa2ext-ahab- container.img",
>=20
>=20
> > > +				.soc_register =3D true,
> > > +				.reserved_dma_ranges =3D true,
> > > +				.imem_mgmt =3D true,
> > > +			},
> > > +	},
> > > +};
> > > +
> > > +static const struct imx_se_node_info_list imx93_info =3D {
> > > +	.num_mu =3D 1,
> > > +	.soc_id =3D SOC_ID_OF_IMX93,
> > > +	.info =3D {
> > > +			{
> > > +				.se_if_id =3D 2,
> > > +				.se_if_did =3D 3,
> > > +				.max_dev_ctx =3D 4,
> > > +				.cmd_tag =3D 0x17,
> > > +				.rsp_tag =3D 0xe1,
> > > +				.success_tag =3D 0xd6,
> > > +				.base_api_ver =3D MESSAGING_VERSION_6,
> > > +				.fw_api_ver =3D MESSAGING_VERSION_7,
> > > +				.se_name =3D "hsm1",
> > > +				.mbox_tx_name =3D "tx",
> > > +				.mbox_rx_name =3D "rx",
> > > +				.reserved_dma_ranges =3D true,
> > > +				.imem_mgmt =3D true,
> > > +				.soc_register =3D true,
> > > +			},
> > > +	},
> >=20
> >=20
> > Some (most?) members of these structs are the same. Why do you have this
> > abstraction if it's not needed right now?
>
> It is needed as the values is different for different NXP SoC
> compatible. It will be needed for NXP i.MX95 platform, whose code will
> be next in pipeline.

How does the imx95 .info look like?

[...]

> > > +static int imx_fetch_soc_info(struct device *dev)
> > > +{
> > > +	struct se_if_priv *priv =3D dev_get_drvdata(dev);
> > > +	struct imx_se_node_info_list *info_list;
> > > +	const struct imx_se_node_info *info;
> > > +	struct soc_device_attribute *attr;
> > > +	struct soc_device *sdev;
> > > +	struct soc_info s_info;
> > > +	int err =3D 0;
> > > +
> > > +	info =3D priv->info;
> > > +	info_list =3D (struct imx_se_node_info_list *)
> > > +				device_get_match_data(dev->parent);
> >=20
> > I think cast is not needed.
>
> It returns memory reference with const attribute. SoC revision member
> of 'info_list', is required to be updated. Thus type casted.

Have you considered that this memory is marked as const for a reason?
It's const, you cannot change it. Place any values that have to changed
into your priv.

> > > +	if (info_list->soc_rev)
> > > +		return err;
> >=20
> > What does this check do? You'll only get data you put in the info_list
> > in the first place.

> info_list->soc_rev, is equal to zero for the first call to this
> function. To return from this function if this function is already
> executed.

This looks wrong, see above.

> > > +	err =3D ele_get_info(dev, &s_info);
> > > +	if (err)
> > > +		s_info.major_ver =3D DEFAULT_IMX_SOC_VER;
> >=20
> > Why continue here in case of error?
>
> To continue with SoC registration for the default values (without
> fetching information from ELE).

Have you tested the driver that it will work, if this fails?

> > > +
> > > +	info_list->soc_rev =3D s_info.soc_rev;
> > > +
> > > +	if (!info->soc_register)
> > > +		return 0;
> > > +
> > > +	attr =3D devm_kzalloc(dev, sizeof(*attr), GFP_KERNEL);
> > > +	if (!attr)
> > > +		return -ENOMEM;
> > > +
> > > +	if (s_info.minor_ver)
> > > +		attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%x.%x",
> > > +					   s_info.major_ver,
> > > +					   s_info.minor_ver);
> > > +	else
> > > +		attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%x",
> > > +					   s_info.major_ver);
> > > +
> > > +	switch (s_info.soc_id) {
> > > +	case SOC_ID_OF_IMX8ULP:
> > > +		attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
> > > +					      "i.MX8ULP");
> > > +		break;
> > > +	case SOC_ID_OF_IMX93:
> > > +		attr->soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
> > > +					      "i.MX93");
> > > +		break;
> > > +	}
> > > +
> > > +	err =3D of_property_read_string(of_root, "model",
> > > +				      &attr->machine);
> > > +	if (err) {
> > > +		devm_kfree(dev, attr);
> >=20
> > Why do you do a manual cleanup of devm managed resources? Same applies
> > to the other devm managed resources, too.
> >=20
> Used devm managed memory, as this function is called as part probe.
> Post device registration, this devm managed memory is un-necessarily
> blocked. It is better to release it as part of clean-up, under this
> function only.

Why do you allocate the memory with devm in the first place, if it's not
needed after probe?

> Other devm managed memory clean-up, under se_probe_cleanup, will be
> removed, as suggested.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dvuxbbj5nymmnkgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZLLbEACgkQKDiiPnot
vG+SOgf/YGBZgMjP3BeqAQYz56cPSTV61/SRUZP4EvHDzma8EH83xkVAElGkxUzy
7yZeHijx/zqnSfe2IR5/dwTPJWXGxBPLms7psmBogYitZd3WnX4P/fgTI78ah3qC
IO+3kt231mk5aHnOI8o3hbZeMRlUPbdLqRzl300zsZeGPy8PlsC5F3jj5pXKfkQU
K/7N4IOajyIrsiAkWiaJxcfBvQFoPW5VA1zveDxDZvPp1uoz80xzeSSsEYWCt/zh
WkNdyIfPw3IMXYgrirubuy9HZF1zJimFPYvTJqbx5+6bEgfU6peTwPr/NBXNaLu3
907OtaYVSrtwVTtax03Wn9LeOLLjOw==
=vcYe
-----END PGP SIGNATURE-----

--dvuxbbj5nymmnkgy--

