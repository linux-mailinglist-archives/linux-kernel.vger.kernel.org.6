Return-Path: <linux-kernel+bounces-524161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A2AA3DFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC6919C1C78
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3FD1CA84;
	Thu, 20 Feb 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="A4hGitDb"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A541DC991;
	Thu, 20 Feb 2025 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067520; cv=none; b=sWQFsilqi3yEf5a9137aGujuATWquQyUKFVWMjAmFwTHUb1n1g4v+F7vOxOX/Xoyjk9TUeFrLiHOGrFQ7oTMDNtUA5O0x4PEl6EgKaXvv1XhThWJMkzLbcdP5Sj6s5bab+aNTYlM7sFXy8D/1o8WoNFcNZF6+GGl4sgWD5pxULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067520; c=relaxed/simple;
	bh=mb7aYcCG8Adpx+o3PB0V+PLcJxbA/KMq9DZ3PJrzvkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO+39W9gPOz43oAmS9vbANaAefdMLIOd+24MpGtPjLrxChD6RxvNY5qENFPsEWSNnlhgSI7EE0krXgKJDw4xXynUIOBo10FKCsdVGFM98e72HD19MLnJpa0Y59onfunN9eFsYppSObIgu3N9JDH3VjKALRuLjosi49ckdoCM9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=A4hGitDb; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A1C810382D3C;
	Thu, 20 Feb 2025 17:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740067515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhrEMPazg4VWtR34qnd0rK9L+bUZ2MhCj/KoPwKqizc=;
	b=A4hGitDbo72QAmhefQeUeZL3T3Rp2wKldnOpn/EQrjnDZScLwr/7Rd/j6nY9MKQ/KQtUiP
	JG6759wwrIzoRhywmF9uAcVztzoO0PQMKccT4bfjss4i/bzvHo3e4QsMJ2ZFsmfKki2y0s
	Acm5EEFFlh5RmmRGT0p4iYS3Da9UI9dAV27ZGIPW+JnIDvcDm/vLRZwAnuyp2SY9DGxbBN
	WSS1HcMuR2u97P2HlCwVn4vftvNDGyHa/BA2d77O1avi3nCO/PcdfsCOuhwI7EudA97zsE
	hReD8N+WY0jdzLWeauVDM1r5cp17mHQ9kRTZjsormprBNDTwtHdw6UDOts+SIQ==
Date: Thu, 20 Feb 2025 17:05:11 +0100
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
Message-ID: <20250220170511.719a1cac@wsk>
In-Reply-To: <f68ebe15-69ee-428a-8079-8bb05d7aa21b@lunn.ch>
References: <20250219114936.3546530-1-lukma@denx.de>
	<3cebe152-6326-454c-9da6-5cf5a64f71c9@lunn.ch>
	<20250219233802.20ec53e5@wsk>
	<5a9d9eef-f2ca-4168-aca4-4419dcfcacb6@lunn.ch>
	<20250220154826.3455b15e@wsk>
	<f68ebe15-69ee-428a-8079-8bb05d7aa21b@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LvcxCIoyiyxMRzVmv5VeRt=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/LvcxCIoyiyxMRzVmv5VeRt=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > > Seems like a reasonable compromise. You would only load this
> > > driver if you intend to make use of the switch... =20
> >=20
> > Yes, the main use case would be the switch (after bridge ... command
> > called).
> >=20
> > However, until then we shall? have port separation. =20
>=20
> Yes. The model Linux uses is that the ports are individual interfaces
> to start with. We should keep to that model.

+1

>=20
> > > MoreThanIP is now part of Synopsys. I wounder if this IP now
> > > exists in other SoCs? The press release however suggests Synopsys
> > > was interesting in the high speed interfaces, not a two ports Fast
> > > Ethernet switch. =20
> >=20
> > I would need some detailed documentation.... =20
>=20
> Which is probably not available. You might be able to get some clues
> from the Freescale datasheets, if they have kept the address spaces
> separated. I don't see it as a strong requirement, given how old this
> IP is, and the limited interest in supporting it over the years, My
> guess is, nobody else uses it.

:-)

>=20
> 	Andrew




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/LvcxCIoyiyxMRzVmv5VeRt=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAme3UrcACgkQAR8vZIA0
zr0WCQgAxyZwB9mNdVIeRsd8mJN2KEWBP3zwFWv3w1XX1glLh9Y/MFa9riYX2/XO
P+so9vOKEXJUCHUxC3GIqJTIoHYB5Rk75zjTDoUs9K851v5SWlXwM2ZtMtbC3DpO
xzh/XjXEoX63V/zJszTYRQKYpjBnep4z4+Qfyabs0TvNSakVz3qdIbSG5zbjiRUr
mP3ZwG/37azFpwaqb2dYwt3IFLlpALBbNaJuSH+UlwqW+JPuiv9bjL6h+tSD7KTB
CPrs16qxPsbOvnilSVURJZOjV9YsgFZBaRquJrlZwoJg9uvo5rUQWjX3x2HlUIX9
uiqcEHdpcgkZDKIOXsnbvZSuE2d87w==
=R4zZ
-----END PGP SIGNATURE-----

--Sig_/LvcxCIoyiyxMRzVmv5VeRt=--

