Return-Path: <linux-kernel+bounces-437809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A7E9E98ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0181166F75
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5BD1B041F;
	Mon,  9 Dec 2024 14:31:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3723313D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754678; cv=none; b=L5GkuoqPogzUSs2DOQ9G+6LhWFo2IOUvXnDKM1pGzF8rmHhdgrs5jKw6QctM+noG6h6wDT3etcPwO0GVchCmMFh8CD1N9+2BhwQTQ2+sgIHrkJd5NhbqhmUslGAG6Yh5VYIWSWfvd/O5XCQEW9HuYtmEYvK8FphQ7fgCNSSMAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754678; c=relaxed/simple;
	bh=I/V+Qzd+J/rgVQUcKk0W0SFlkrIGfbu4Hv2kZ7vcj1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgmMYD6q16OOfcSNuEVztKovoJRplAZoPI4ur7P/LI1q74oGdTL878rvObe/n6Pk8UduM4QO0IFJXs1w40fDdqGQ5mUltnp0AtIRtdpSakBTedTujkZraxQyAhWv+W4c1XmtA0Dw5D6R0gE+Xl98/1OLSW9vHRD7Cna9NjN/o/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKemm-00057P-43; Mon, 09 Dec 2024 15:30:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tKemk-002Wue-0q;
	Mon, 09 Dec 2024 15:30:55 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8DD5C389BCE;
	Mon, 09 Dec 2024 14:30:54 +0000 (UTC)
Date: Mon, 9 Dec 2024 15:30:54 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Leonard =?utf-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>
Subject: Re: [PATCH 0/6] ARM: dts: stm32: lxa-tac: fix gen{1,2} boards and
 add gen3 board
Message-ID: <20241209-magenta-boobook-of-respect-14ec68-mkl@pengutronix.de>
References: <20241119-lxa-tac-gen3-v1-0-e0ab0a369372@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zcg6nifetr3cb2sn"
Content-Disposition: inline
In-Reply-To: <20241119-lxa-tac-gen3-v1-0-e0ab0a369372@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--zcg6nifetr3cb2sn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] ARM: dts: stm32: lxa-tac: fix gen{1,2} boards and
 add gen3 board
MIME-Version: 1.0

Hello Alexandre,

On 19.11.2024 12:34:57, Marc Kleine-Budde wrote:
> Hello,
>=20
> this series fixes some problems found in the lxa-tac generation 1 and
> 2 boards and add support for the generation 3 board. It's based on an
> STM32MP153c, while the generation 1 and 2 are based on the
> STM32MP157c.
>=20
> regards,
> Marc
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Leonard G=C3=B6hrs (6):
>       ARM: dts: stm32: lxa-tac: disable the real time clock
>       ARM: dts: stm32: lxa-tac: extend the alias table
>       ARM: dts: stm32: lxa-tac: adjust USB gadget fifo sizes for multi fu=
nction
>       dt-bindings: arm: stm32: add compatible strings for Linux Automatio=
n LXA TAC gen 3
>       ARM: dts: stm32: lxa-tac: move adc and gpio{e,g} to gen{1,2} boards
>       ARM: dts: stm32: lxa-tac: Add support for generation 3 devices
>=20
>  .../devicetree/bindings/arm/stm32/stm32.yaml       |   7 +
>  arch/arm/boot/dts/st/Makefile                      |   1 +
>  arch/arm/boot/dts/st/stm32mp153c-lxa-tac-gen3.dts  | 267 +++++++++++++++=
++++++
>  arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen1.dts  |  84 +++++++
>  arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen2.dts  |  84 +++++++
>  arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi      | 100 +-------
>  6 files changed, 455 insertions(+), 88 deletions(-)

since the merge window is open, can you merge this series please.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zcg6nifetr3cb2sn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdW/xoACgkQKDiiPnot
vG/URgf/dtYmL9iBc+SHfx64MvPmj6DNHBSLqZnmsOY7n3wqlr+iKYz+6cM33m7n
mixEvaSXRcmbC/LnORRf2tRwJKu5d7P13lS88jWSyOPXhyfzcSYfFzKDYURjmNux
UISMbF/3QA12/W11Kks7pl0FFzhSeuHSTek6BSFJ1CmTKYrIQnoZIYAV8MsytUej
4P+MFT0SXYEMgMKObA7uxcSxWlwSFVKv3Kw8Zl8gj3SDsLWmuxdT5f1k/n+EIFmZ
B4BTT4VKiI/aVicjk+Wfa/EE24YtsIZeg3RbR50o04xVlRWFRwzeIfOh2HwH5vmQ
9v692jmzaPq3TR3977WzO0Hkxo+H4A==
=P04U
-----END PGP SIGNATURE-----

--zcg6nifetr3cb2sn--

