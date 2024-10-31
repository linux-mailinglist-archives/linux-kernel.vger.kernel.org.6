Return-Path: <linux-kernel+bounces-390348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F10E9B78B3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833091C24048
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250D919925A;
	Thu, 31 Oct 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="R4DHCx5y"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E513A89A;
	Thu, 31 Oct 2024 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370871; cv=none; b=QanzTZnubei6RL23T8dL0POidM5xIgQexKyhFc3ZJOxKmL/il5oRLCylRbcIcd1B0+bkS3daH7eqC1yf7glJKT5BpPGUEjdjfhDl0sMW+/9/KAil8gGeSixIYqcq0aKzykpcB+3XvXIUxDapX3uXfYbsBK4SM0PTJS2lkRqe+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370871; c=relaxed/simple;
	bh=zANYUiHmKXksyQ6E+6YVTESkzq42rbS9GPMJvQKhXnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LerRlwiu9hAzWGUwl/4uwjrpYNCcgQIJAK+CkhIJg7zkiYxyRPunVPqlQ1fZAZTwEXYf/XYeMUvCvbm/n2qTJ5OtnZzRORSg2gKCClsh1o6K/j58gMu1hbdSX5geYz74qbAbOsrXwxYCrVoUZOLjFq5c8URF7PQWCTdwmDMlVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=R4DHCx5y; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C286989285;
	Thu, 31 Oct 2024 11:34:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730370867;
	bh=xMjYvi/k0LQv3mvZTRUW98lV/FQ3V/2XaFC77x3qp1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R4DHCx5y1WLPTmrQgUeiNT6q3Bn6qZiHbfVy1ehcrKerMsp7P+SUnLS0pozgzOPEO
	 kwgnuv6a61i3Dm+t+OvvD22xMAErsoInObWnEPfvAA8jybfRkteO3QxnFRAt/OeNgM
	 MoxHxi38Bt/0U2XnfgVEP3Bj+03bJYDY8TQQzGWn8DhvAcnznVXQAT3eJPUvFCPn//
	 pQfTEjQHSr0rSIfcrOi+2EDXasBluWymdqPk9XPs8skGxvOgoeapD4WQ1oLywpfmO5
	 Jbx+6iLWJwYhirI8XINXT4olddEyZrSN328ulmFYI1T6lTRVUjGnkRRn4p71+Hc2wW
	 +Fzheen24Xqmg==
Date: Thu, 31 Oct 2024 11:34:25 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 4/4] ARM: dts: mxs: Add descriptions for imx287
 based btt3-[012] devices
Message-ID: <20241031113425.1e3d1da5@wsk>
In-Reply-To: <806770fc-3830-4e89-a3ee-487b662685ed@gmx.net>
References: <20241022133040.686562-1-lukma@denx.de>
	<20241022133040.686562-4-lukma@denx.de>
	<20241031094236.17ed927d@wsk>
	<806770fc-3830-4e89-a3ee-487b662685ed@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FD/wYCUhTrUoXhAbjXcXHQB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/FD/wYCUhTrUoXhAbjXcXHQB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Am 31.10.24 um 09:42 schrieb Lukasz Majewski:
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
> >> minimal.
> >>
> >> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >>
> >> ---
> >> Changes for v2:
> >> - Rename dts file from btt3-[012] to imx28-btt3-[012] to match
> >> current linux kernel naming convention
> >> - Remove 'wlf,wm8974' from compatible for codec@1a
> >>
> >> Changes for v3:
> >> - Keep alphabethical order for Makefile entries
> >>
> >> Changes for v4:
> >> - Change compatible for btt3 board (to 'lwn,imx28-btt3')
> >>
> >> Changes for v5:
> >> - Combine patch, which adds btt3-[012] with one adding board entry
> >> to fsl.yaml
> >>
> >> Changes for v6:
> >> - Make the patch series for adding entry in fsl.yaml and btt3
> >>
> >> Changes for v7:
> >> - Use "panel" property as suggested by the community
> >> - Use panel-timing to specify the display parameters
> >> - Update subject line with correct tags
> >>
> >> Changes for v8:
> >> - Use GPIO_ACTIVE_HIGH instead of '0'
> >> - Add the comment regarding mac address specification
> >> - Remove superfluous comment
> >> - Change wifi-en-pin node name
> >>
> >> Changes for v9:
> >> - Remove not used 'pm-ignore-notify'
> >> - Add display names for 'panel-dpi' compatible to avoid Schema
> >> warnings
> >>
> >> Changes for v10:
> >> - Drop new line with panel-timing definitions
> >> - Add new lines with 'sound' node
> >> - Change 'codec' to 'audio-codec'
> >> - Change order of properties for saif1 node =20
> > Are there any more comments regarding this patch? =20
> Sorry, i wasn't aware that you are waiting for reviews after Rob's
> request.

I did not received any mail from Rob's automated DTS test script, so
this is a good thing :-).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/FD/wYCUhTrUoXhAbjXcXHQB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmcjXTEACgkQAR8vZIA0
zr2R0gf/dn+dA46KkhqB5cnCwM/Du4YuF84nm95iXMGzE3j0nrAz35xAEt4kbQWT
AeHvQn13mHETK44MBDyVCmwJsx/UIWNCPRdpFRyN1b7cVLqxQu2ktw3k2roMChbS
Xy4aOQY4GcAf+OPczECtsV/sXrCAbZlOILrtEP0qBxREDWbLy6J+7fWL8UZ6VXbM
fCBTG/iu4bJRUpQG4gX8w2G2WW4Su487RJqbun0Wj0r+/ED4tQqzmye5wZapZNhJ
CO8rqfo9o6qQZzW+ppECs3DC4vRVLeMYbsNhyKhTrM8igjjAnutyabSHzw5R3Jh1
5D8uiUHD+Y/NfIWkM/tJFFnS1iGreA==
=8/4m
-----END PGP SIGNATURE-----

--Sig_/FD/wYCUhTrUoXhAbjXcXHQB--

