Return-Path: <linux-kernel+bounces-355103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C598E994753
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8411F230B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A8B1DE8A9;
	Tue,  8 Oct 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="AoH+kNsy"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D53E1D4342;
	Tue,  8 Oct 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387338; cv=none; b=HtgOUamgND1eHVK36Ouxp1LnBBEJXG4c9IUIsZU+P80OsBMEyyKQGQ5DTq2/ws2yTIW67Xv74RxUzfNlKHFgFrZ1JmJsKYpf22M8CenyxEPk+1ffgLoME/L5U7C9/C1LMwoR6LAjvLZHsDxQt+SzvNUP2fO0IqkwZYMk/gwshZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387338; c=relaxed/simple;
	bh=YPYePn9qXROHJ9vl/jwAclfR0CK1RcLn900rJr0Q6DM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfNuHQo1ONemVw+g5oT4efRq23D3K6ZiRaHaHBmjpk4rZU3YWrfJqX3K9vngs/x6/Kdx/oz8YDARzzdh3AfDl/kzr5WVDF4ZgH//GfissoEFNLK6rnFDRzstUgd6nfvoejgUNUR4KCbtNMSKkF6+nOED1XeURfpX+34C0Ub3ul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=AoH+kNsy; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E52A2889E1;
	Tue,  8 Oct 2024 13:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728387335;
	bh=3cD7NWV450ZD4Qg06pJDYhvM7J5Uufk5ZNY7YfVFLzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AoH+kNsyX27jirdfywpHOdKUUQNc4/H48ceEUinPX5Q5/GZ7OjmSySvpN0dpLtyx8
	 fSkybVa6wH76nUquYdqxrlvck3XnmIFPkY1/bSl95bh2TmSHHAZOb/x4muzhDdIxzE
	 1J3orwVm0Coh34fdgeuetb4buJyV6E0p06L5Pf1wlvcN+/3ziGpgTaWXlsR/UMD8ND
	 0gfZ5QjbsorMA6l4Y339lVZtssRjJ6tVwmcOkshMWD2kvpfkX5uNEcuaos4fg8TwXE
	 qzhsoSg/hahAg6+vJkjOtiCbA1TeNp7OKjoPQlJ1c8rBbs9tOppkLNW73enS/PXJYg
	 IMBHK64rUDm+A==
Date: Tue, 8 Oct 2024 13:35:33 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ARM: dts: mxs: Add descriptions for imx287 based
 btt3-[012] devices
Message-ID: <20241008133533.2311f306@wsk>
In-Reply-To: <752dfca1-327e-48b9-8065-3aca7a4b4420@gmx.net>
References: <20240925143129.4081815-1-lukma@denx.de>
	<20240925143129.4081815-2-lukma@denx.de>
	<20241007115336.393f0696@wsk>
	<752dfca1-327e-48b9-8065-3aca7a4b4420@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zRMKj/PlExkfDhs/YkG.TWg";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/zRMKj/PlExkfDhs/YkG.TWg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Hi Lukasz,
>=20
> Am 07.10.24 um 11:53 schrieb Lukasz Majewski:
> > Dear Community,
> > =20
> >> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> >> some extend similar to already upstreamed XEA devices, hence are
> >> using common imx28-lwe.dtsi file.
> >>
> >> New, imx28-btt3.dtsi has been added to embrace common DTS
> >> properties for different HW revisions for this device.
> >>
> >> As a result - changes introduced in imx28-btt3-[012].dts are
> >> minimal. =20
> > Gentle ping on this patch series... =20
> unfortunately most of my comments in V6 were silently ignored :(
>=20

Sorry - I've just realized that your reply "disappeared" under other
mails.

> Regards




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/zRMKj/PlExkfDhs/YkG.TWg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmcFGQYACgkQAR8vZIA0
zr35EwgAskWkXMfcoDlDJNoGLGCFD9PwnhLWiEJkPfgd0vbdsf11IeNu4gFcJNPT
kLEQlXnt/BnRDV2is7Ua/EwQEm56B63dpvTgrr+B6THUEMwJhJnsMFcu1uymlKDI
rbKsPghrfC8b93Vj8wkd+hl+AJ3aFyWzS1FJckvf3bw2XlHfxueb+gJRm+YeH1lM
u8QUjtM+Rr9jXcq/5rn2KBKx3grxtzAg0qDX4Xmdp4PiqsTNXckv7AEjOfR2KTyE
YLhxUtEP+DBffvrWNYeRFIi2rVQD1kiIVabHVzcRbGNwFhvZFnsLhNJWPGiGbQSi
Y0sLE+mcx/hx1lo4tXFD4+4rDCl9mw==
=gPaV
-----END PGP SIGNATURE-----

--Sig_/zRMKj/PlExkfDhs/YkG.TWg--

