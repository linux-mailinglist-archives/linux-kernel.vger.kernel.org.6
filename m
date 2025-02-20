Return-Path: <linux-kernel+bounces-523951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A795A3DD41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A7117335C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BAF1C6F70;
	Thu, 20 Feb 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="iWtjEsLy"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0F19D06E;
	Thu, 20 Feb 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062920; cv=none; b=aFl+9DwTa7ElR1Ta0jyKOchfHfTfJgxuVGjoG29sH5EpAtXR17IEUjMEmPST+59Wm7JyNIwsJU8Kr3FUsBKot/k7DEibpsPrcWOXU7oUQXtYFVMh/Glg4Q12VuCp+PAJAr9ey/6qNPf5zQ1ffPk8MAjAq6x0Caa2ozx1Q4qYj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062920; c=relaxed/simple;
	bh=PzEer1mTGvGb2m+KD/jgWxiPMBT75xyrk+ydbLeYI3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVxv3SOy3mpiiJX2+KbuhTNOaZp3S4Bc/ayN7kfXzz99jH+5qd8ZDg3/I4GOBx9r1qO+E/e3leTP/KdE4MBKN/vmAO4kr4pLK1YdF2mLS5I/6AlwrjhtMKjVmyj2vQ8BzTAdYlJ/nT3MvoN1jto32wqykcEVqu8LIpfEuV8ehLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=iWtjEsLy; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F81210382D37;
	Thu, 20 Feb 2025 15:48:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740062910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldqI1Le+GNbE+uBRLkLvuLrordSQ/bU414re+PDqRgg=;
	b=iWtjEsLylFgr2+ddtCwYOKZnorICgZLXMimUifa+okc9WQqYoo6+u6UKCRYO1RI10IL3Di
	46+qHJXpjf3Z43lYHQM2qvPZ3Ivnu2Kq7LTgrbBFi2ZopTitbRaImYsWZL5dodu7p0JW0N
	h9BjrlQElNSaPiQLSlfeCMOnzRYNURThGfezcLWolcaueVQzlMQ+ZvAAg2ZGESCmNC92x0
	mbQIDRlR2lMHYQ4Ary2yPugSaa7wIOsVdwNNhZQ2Nij0WKSk2EaUlB1N6QK5RjCbiUyz6h
	4UU3C+wlpwa22XeoR9XVKXNwpPsbdIZ4iCt5fP8kV7//a2Zil6r/dxf1LhqsAw==
Date: Thu, 20 Feb 2025 15:48:26 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-clk@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH] arm: clk: Add ETH switch clock description for vf610
 SoC
Message-ID: <20250220154826.3455b15e@wsk>
In-Reply-To: <5a9d9eef-f2ca-4168-aca4-4419dcfcacb6@lunn.ch>
References: <20250219114936.3546530-1-lukma@denx.de>
	<3cebe152-6326-454c-9da6-5cf5a64f71c9@lunn.ch>
	<20250219233802.20ec53e5@wsk>
	<5a9d9eef-f2ca-4168-aca4-4419dcfcacb6@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EoF.xD3edO+ut3CeLCKvgE3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/EoF.xD3edO+ut3CeLCKvgE3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> On Wed, Feb 19, 2025 at 11:38:02PM +0100, Lukasz Majewski wrote:
> > Hi Andrew,
> >  =20
> > > On Wed, Feb 19, 2025 at 12:49:36PM +0100, Lukasz Majewski wrote: =20
> > > > The NXP's vf610 soc is equipped with L2 switch IP block from
> > > > More Than IP (MTIP) vendor.
> > > >=20
> > > > It requires special clock (VF610_CLK_ESW) to be operational.   =20
> > >=20
> > > So you have a driver for this switch? It has been talked about in
> > > the past, but nobody made any progress with it. Ah, it was you in
> > > 2020. =20
> >=20
> > Yes, I'm going to try another time to upstream it.... :-)
> >  =20
> > > It
> > > will be interesting to see what you came up with in the end, pure
> > > switchdev or a DSA driver. =20
> >=20
> > I think it would be:
> >=20
> > 1. Standalone driver, which would configure the L2 switch from the
> > very beginning to work (this is different from FEC on imx28/vf610
> > where switch is bypassed)
> >=20
> > 2. It will use the in-switch registers to have two network
> > interfaces separated. As a result - it may be slower than the
> > fec_main.c in this use case. =20
>=20
> Seems like a reasonable compromise. You would only load this driver if
> you intend to make use of the switch...

Yes, the main use case would be the switch (after bridge ... command
called).

However, until then we shall? have port separation.

>=20
> > 3. When somebody call "bridge ..." on it - then the in-switch
> > separation would be disabled. This is the "normal" state of
> > operation for L2 switch, which would be a HW accelerator for
> > bridging.
> >=20
> > 4. The switchdev would be used to manage it
> >=20
> > 5. This would be just a very simple driver - just bridging and
> > startup of the L2 switch.
> >=20
> > After we would have a consensus (i.e. it would be pulled to
> > mainline) - I would proceed further.
> >=20
> > I will try to not touch fec_main.c driver - just write standalone,
> > new for MoreThanIP L2 switch driver. =20
>=20
> It might make sense to refactor the MDIO code into a helper which both
> can share? No point duplicating that.

This is a latter step (common MDIO library code), IMHO.=20

>=20
> > If somebody would like to use FEC, then he will insert the proper
> > module. If switch, another one can be inserted, depending o the
> > target use case. =20
>=20
> This all seems like a reasonable way forward.

+1

>=20
> MoreThanIP is now part of Synopsys. I wounder if this IP now exists in
> other SoCs? The press release however suggests Synopsys was
> interesting in the high speed interfaces, not a two ports Fast
> Ethernet switch.

I would need some detailed documentation....

>=20
> 	Andrew




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/EoF.xD3edO+ut3CeLCKvgE3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAme3QLoACgkQAR8vZIA0
zr2Zzgf9HtLGK3Ux7Xf80L6yo2vvKfPiWZ/RuxE4tCAf9yjd5vk2Wfg9EizNIaaX
ILs8pKZkCxVRQxUqQ7Cx2k02jDSZiHJ30GFYlE6EtUFGgk00siH1uUZA5ScSsHPj
DZfO/gVB4MW+ofwapPvYEGyUdKQmyB2IOt5OfusD4f9p869BqoskJQpsESHDP16m
qcDpAwgne46YXCHFpfzDFTEDmriOa0/iY04iTFAV/kbxGu+OwW23X7c5CJFE79KP
AWxzzSzuu9iNAGcKEW1u9rH6H1iEb0GW9dVBDE/dX5VHwAqRct6S+tZonQGQzQab
eNojXymqBTXSfY5w/1xzbDX5z4WPGw==
=A4R8
-----END PGP SIGNATURE-----

--Sig_/EoF.xD3edO+ut3CeLCKvgE3--

