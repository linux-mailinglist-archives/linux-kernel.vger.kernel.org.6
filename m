Return-Path: <linux-kernel+bounces-369291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A468A9A1B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2920E1F228B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE21C2309;
	Thu, 17 Oct 2024 07:09:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA82155A24
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148973; cv=none; b=XcpU9bfSSzYb99aQ6HbMQ39yy3fjaGkgF2KfoqOKqjQU0tj5voGzSsvFRSh6KZsD+4NkSM2muNwVh4iLA5IrIIZAoWbTi9YfWvk0xzz4tEq74YRKiiD/TSWMISBxSAMIIHJoUugn0wvYKdJZGharj64JFXwqrIwfBef/IsMuYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148973; c=relaxed/simple;
	bh=XBzZoUWwSEObEugZNOrcy6598cbZcniaUW2TeBRHQQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYI2E9GzyGrpzuw/DJ6owy26x2y9+Yd/UMyhNGahEgQaEkK47Bb/7906gdkz0ZRYMssa0sdO7o6Lhfv5cOfcPAYBKxKSxzFHcGcQnZabGSa9WZRD1ovR9qKXu1h42B2hnjQvR8hN3YqAFDDOSwbMOMbCvUCIJMfaIsGcGDl0Vos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KdJ-0001gV-BX; Thu, 17 Oct 2024 09:09:17 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KdI-002UGJ-FV; Thu, 17 Oct 2024 09:09:16 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 21AF4354DC9;
	Thu, 17 Oct 2024 07:09:16 +0000 (UTC)
Date: Thu, 17 Oct 2024 09:09:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: [PATCH net-next 13/13] net: fec: fec_enet_rx_queue(): factor
 out VLAN handling into separate function fec_enet_rx_vlan()
Message-ID: <20241017-fox-of-awesome-blizzard-544df5-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-13-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85104DCA7DED14565615E4A588472@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kdko7g4iyimtpy44"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85104DCA7DED14565615E4A588472@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--kdko7g4iyimtpy44
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.10.2024 03:33:09, Wei Fang wrote:
> > -----Original Message-----
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Sent: 2024=E5=B9=B410=E6=9C=8817=E6=97=A5 5:52
> > To: Wei Fang <wei.fang@nxp.com>; Shenwei Wang <shenwei.wang@nxp.com>;
> > Clark Wang <xiaoning.wang@nxp.com>; David S. Miller
> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Richard
> > Cochran <richardcochran@gmail.com>
> > Cc: imx@lists.linux.dev; netdev@vger.kernel.org; linux-kernel@vger.kern=
el.org;
> > kernel@pengutronix.de; Marc Kleine-Budde <mkl@pengutronix.de>
> > Subject: [PATCH net-next 13/13] net: fec: fec_enet_rx_queue(): factor o=
ut
> > VLAN handling into separate function fec_enet_rx_vlan()
> >=20
> > In order to clean up of the VLAN handling, factor out the VLAN
> > handling into separate function fec_enet_rx_vlan().
> >=20
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/net/ethernet/freescale/fec_main.c | 32
> > ++++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > b/drivers/net/ethernet/freescale/fec_main.c
> > index
> > d9415c7c16cea3fc3d91e198c21af9fe9e21747e..e14000ba85586b9cd73151e
> > 62924c3b4597bb580 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -1672,6 +1672,22 @@ fec_enet_run_xdp(struct fec_enet_private *fep,
> > struct bpf_prog *prog,
> >  	return ret;
> >  }
> >=20
> > +static void fec_enet_rx_vlan(struct net_device *ndev, struct sk_buff *=
skb)
> > +{
> > +	struct vlan_ethhdr *vlan_header =3D skb_vlan_eth_hdr(skb);
>=20
> Why not move vlan_header into the if statement?

I've an upcoming patch that adds NETIF_F_HW_VLAN_STAG_RX (a.k.a.
801.2ad, S-VLAN) handling that changes this function.

One hunk looks like this, it uses the vlan_header outside of the if:

@@ -1675,15 +1678,19 @@ fec_enet_run_xdp(struct fec_enet_private *fep, stru=
ct bpf_prog *prog,
 static void fec_enet_rx_vlan(struct net_device *ndev, struct sk_buff *skb)
 {
         struct vlan_ethhdr *vlan_header =3D skb_vlan_eth_hdr(skb);
+        __be16 vlan_proto =3D vlan_header->h_vlan_proto;
=20
-        if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
+        if ((vlan_proto =3D=3D htons(ETH_P_8021Q) &&
+             ndev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
+            (vlan_proto =3D=3D htons(ETH_P_8021AD) &&
+             ndev->features & NETIF_F_HW_VLAN_STAG_RX)) {
                 /* Push and remove the vlan tag */
                 u16 vlan_tag =3D ntohs(vlan_header->h_vlan_TCI);

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kdko7g4iyimtpy44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQuBkACgkQKDiiPnot
vG+1Awf/bepBsoNajHzaS0pV6MTSyE3H/Zj4qBfrFCaf4LrffGO1q2RzdRluG2cj
71GqXA4WmKmhSIcIpdWtHm17BsOCi3idHeXF3/50gLgHDFQj7r0d84JKmbPAiDdG
PJxL2bWuqSXUjPXoJDd8M7nkiATzep9RU6UGDmE7/g4uNBoieYyDOkCAQ0XnJSGw
0Leij7j4/5IrA9RBnyCwFamq/utxiShnBqjfq7yZORX8R+BNUiNAu2GvudnpbVlh
lr4Nvh8EkGn8IqzOLWH6RgoloCeWSCvcZP6bDizN79UXeBrxV13j0m4loYT+N7yv
ulYcfHzxyQaHCzByASE49us4gAJ4tg==
=mrNP
-----END PGP SIGNATURE-----

--kdko7g4iyimtpy44--

