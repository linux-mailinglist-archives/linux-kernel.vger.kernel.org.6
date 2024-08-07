Return-Path: <linux-kernel+bounces-277729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2F194A567
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745101C20306
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4761DD3B1;
	Wed,  7 Aug 2024 10:27:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FA1803A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026423; cv=none; b=Au1OJ8ysKw1SrJMXzhW2N/HtXRI6/MnX2lWPk+dpJZWBaOJgY1scH7vCk2DWseSwjnDQRQ1OjGQxOdJMqVKTlJQ3H92pExrpK/Fkd826xl9NnsM1s5b/XeSPVQHS1Nv5B3XqALEWabvbXCqOicbhKn2QG9WHrmLbLRyQoKhKIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026423; c=relaxed/simple;
	bh=8INA9PN3D3vFUNYja6UFIHKU2EbiqBnPoJpxLq2TfxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVTWBrq2Xgt/uuMQnpmlFeIUux83Kvy9MB2cKN2D4p5jmSSvRmfo7vnCW7vUB02hSTMZ5ach2lgyAnZliDaEV+1CYDL9pFr8R8SRvKMb0ReqO/OSLXv3fCso7m4ohqAMrF0foM0LEyu9WD2D28TjiQInN4eazduDwZHdnd11IEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbdsS-0003ur-4r; Wed, 07 Aug 2024 12:26:44 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbdsP-005AZU-K2; Wed, 07 Aug 2024 12:26:41 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3BC37318A36;
	Wed, 07 Aug 2024 10:26:41 +0000 (UTC)
Date: Wed, 7 Aug 2024 12:26:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Wei Fang <wei.fang@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/1] net: fec: using page pool to manage RX buffers
Message-ID: <20240807-rustling-literate-cormorant-08d7a8-mkl@pengutronix.de>
References: <20220930204427.1299077-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4llhy42hfqhiqap"
Content-Disposition: inline
In-Reply-To: <20220930204427.1299077-1-shenwei.wang@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--s4llhy42hfqhiqap
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

while looking at the fec driver I noticed the following not explicitly
initialized variable.=20

On 30.09.2022 15:44:27, Shenwei Wang wrote:
> This patch optimizes the RX buffer management by using the page
> pool. The purpose for this change is to prepare for the following
> XDP support. The current driver uses one frame per page for easy
> management.

[...]

> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/=
freescale/fec.h
> index b0100fe3c9e4..33f84a30e167 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -17,6 +17,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/pm_qos.h>
> +#include <linux/bpf.h>
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/timecounter.h>
>  #include <dt-bindings/firmware/imx/rsrc.h>
> @@ -346,8 +347,11 @@ struct bufdesc_ex {
>   * the skbuffer directly.
>   */
>=20
> +#define FEC_ENET_XDP_HEADROOM	(XDP_PACKET_HEADROOM)
> +
>  #define FEC_ENET_RX_PAGES	256
> -#define FEC_ENET_RX_FRSIZE	2048
> +#define FEC_ENET_RX_FRSIZE	(PAGE_SIZE - FEC_ENET_XDP_HEADROOM \
> +		- SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
>  #define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
>  #define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
>  #define FEC_ENET_TX_FRSIZE	2048
> @@ -517,6 +521,12 @@ struct bufdesc_prop {
>  	unsigned char dsize_log2;
>  };
>=20
> +struct fec_enet_priv_txrx_info {
> +	int	offset;
> +	struct	page *page;
> +	struct  sk_buff *skb;
> +};
> +
>  struct fec_enet_priv_tx_q {
>  	struct bufdesc_prop bd;
>  	unsigned char *tx_bounce[TX_RING_SIZE];
> @@ -532,7 +542,14 @@ struct fec_enet_priv_tx_q {
>=20
>  struct fec_enet_priv_rx_q {
>  	struct bufdesc_prop bd;
> -	struct  sk_buff *rx_skbuff[RX_RING_SIZE];
> +	struct  fec_enet_priv_txrx_info rx_skb_info[RX_RING_SIZE];
> +
> +	/* page_pool */
> +	struct page_pool *page_pool;
> +	struct xdp_rxq_info xdp_rxq;
> +
> +	/* rx queue number, in the range 0-7 */
> +	u8 id;

This number is never explicitly initialized, I think it's always 0.

>  };
>=20
>  struct fec_stop_mode_gpr {
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethe=
rnet/freescale/fec_main.c
> index 59921218a8a4..169950e43b88 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -66,6 +66,8 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  #include <soc/imx/cpuidle.h>
> +#include <linux/filter.h>
> +#include <linux/bpf.h>
>=20
>  #include <asm/cacheflush.h>
>=20
> @@ -422,6 +424,48 @@ fec_enet_clear_csum(struct sk_buff *skb, struct net_=
device *ndev)
>  	return 0;
>  }
>=20
> +static int
> +fec_enet_create_page_pool(struct fec_enet_private *fep,
> +			  struct fec_enet_priv_rx_q *rxq, int size)
> +{
> +	struct page_pool_params pp_params =3D {
> +		.order =3D 0,
> +		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.pool_size =3D size,
> +		.nid =3D dev_to_node(&fep->pdev->dev),
> +		.dev =3D &fep->pdev->dev,
> +		.dma_dir =3D DMA_FROM_DEVICE,
> +		.offset =3D FEC_ENET_XDP_HEADROOM,
> +		.max_len =3D FEC_ENET_RX_FRSIZE,
> +	};
> +	int err;
> +
> +	rxq->page_pool =3D page_pool_create(&pp_params);
> +	if (IS_ERR(rxq->page_pool)) {
> +		err =3D PTR_ERR(rxq->page_pool);
> +		rxq->page_pool =3D NULL;
> +		return err;
> +	}
> +
> +	err =3D xdp_rxq_info_reg(&rxq->xdp_rxq, fep->netdev, rxq->id, 0);

But it's used here.

> +	if (err < 0)
> +		goto err_free_pp;
> +
> +	err =3D xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
> +					 rxq->page_pool);
> +	if (err)
> +		goto err_unregister_rxq;
> +
> +	return 0;
> +
> +err_unregister_rxq:
> +	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> +err_free_pp:
> +	page_pool_destroy(rxq->page_pool);
> +	rxq->page_pool =3D NULL;
> +	return err;
> +}

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s4llhy42hfqhiqap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmazS90ACgkQKDiiPnot
vG8Fkwf+Ps9pjpSLtQV8dyl9uZnQPKfe7NElj8fvdZfRsIsj5CtvCyFCyebQn4HZ
5Lz9KDa1mJszjuou3Lpp5t9mrMfxDcCeiF1wLBZRYB2gz+MNNtRJmtGrszljVfJx
PeUFt1H0BnqOgxpNyOk6SJ8Qc50bK+ekikcrHIXv4Hn1UQIVJU/SEfqpQ2ZJ7ggh
JR07NflWtzD7OrMuHLE+kfXxKIZpj9sJ59b2t0LujGRjo5a61+yuajYIr/aXtq/7
Y17Oi6Pz9JqP1z/Q/VviCSsOqCg+hri+BSo3cFJc1Q7emgw6CDC32C5S++U83W9h
Xq41EHPD7Sz3mjPbOx3JpmgcColM5g==
=NCqU
-----END PGP SIGNATURE-----

--s4llhy42hfqhiqap--

