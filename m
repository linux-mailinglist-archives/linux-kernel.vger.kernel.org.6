Return-Path: <linux-kernel+bounces-529215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A17A421BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F08D1634EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB45248877;
	Mon, 24 Feb 2025 13:46:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59D221F36
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404778; cv=none; b=TjjwqML8d7vec2H54c5WGkhWdyAWWXfNoLRHvKB4LIRfLbRf/j4OjP6zwYVCNzaOcnpfCTUvNsGen9pDtA0JrMs/a0AqbhE6UzHl/lH5YdCWFYtg/T2Xpf5OyClZdZjm8AJXmLc5KCkz/gA6dpgRSz90Sugh1MvFYnT7gTsoZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404778; c=relaxed/simple;
	bh=U54E3SdESm7dfYIQnckgPcM86HtTj/Q4chdE6jyHTM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ2I155TI8O6vJVOq0QcY0a0pNRbbiss+am2/EjDf2EV6B3sm/rtAjF6wENoV3+75B92WlFyQ+Vrm5ySOCYxBfoRSjY/j4hM3vV+RK379FIjuNm9naQM/3OKzg6csVIeQ3DDs9I6BgBWN1HQww91n/aETAV1TXiqJ6CeIAjg9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tmYmO-0007oj-Pq; Mon, 24 Feb 2025 14:45:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tmYmO-002bVW-12;
	Mon, 24 Feb 2025 14:45:52 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E8E753CA816;
	Mon, 24 Feb 2025 13:45:51 +0000 (UTC)
Date: Mon, 24 Feb 2025 14:45:50 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>, 
	Matthias Brugger <mbrugger@suse.com>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	NXP S32 Linux <s32@nxp.com>, Enric Balletbo <eballetb@redhat.com>, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Alberto Ruiz <aruizrui@redhat.com>, Christophe Lizzi <clizzi@redhat.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: s32g: add FlexCAN[0..3] support for s32g2
 and s32g3
Message-ID: <20250224-quizzical-tasteful-chupacabra-acf14d-mkl@pengutronix.de>
References: <20250224134016.3921196-1-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vdjp2jj2cgfxv3yv"
Content-Disposition: inline
In-Reply-To: <20250224134016.3921196-1-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--vdjp2jj2cgfxv3yv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] arm64: dts: s32g: add FlexCAN[0..3] support for s32g2
 and s32g3
MIME-Version: 1.0

On 24.02.2025 15:40:16, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> Add FlexCAN[0..3] for S32G2 and S32G3 SoCs.

The dt-bindings patch that documents support for the S32G2/S32G3 is in
net-next/main: 51723790b718 ("dt-bindings: can: fsl,flexcan: add
S32G2/S32G3 SoC support")

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vdjp2jj2cgfxv3yv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme8eAsACgkQDHRl3/mQ
kZzAFwgAkC2NY97unwSJJHjQK4vv1/t6fMnSIY0SgTnQ8Ch+OBenrj0ykSdhSdB4
spt7Ly83UumxmXfGM/1IWobj4tyx63ryqWEztyV5WojY8I+VpN4BoVLY9q1U58oH
ia1Ns6+5XSh3cUacaMn4pCOf3gJbjlGZxy0Yomp9QiaSDondf/osnjCVVTA59Zjj
q7yGEuUT83Q877UM39YCc/h7z1qFnmJV8av6IyrQoZLn8oX3bx8HIILM1PIJ6D5M
eLhwB7Mr2Oh5G20vDoq+VYNVxn7Uuwzd9lzOcm3g7DoQ5l+iLsaxQG7+aXOAV4o+
5YZzZNaiLlbyD3ZjL59b3PFtRefIwQ==
=98NH
-----END PGP SIGNATURE-----

--vdjp2jj2cgfxv3yv--

