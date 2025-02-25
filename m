Return-Path: <linux-kernel+bounces-530343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31292A4324A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCDC17AB13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A851AAC9;
	Tue, 25 Feb 2025 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgDxIBPr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097B1802B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445731; cv=none; b=mwZs6KfRgpUOz2E3aiWV/T+VrAtkIi3Bbh3ipWLmkJAAihaipPdS/RAigWRzbK56eDTnS38V8ZdV6d3Nyz72RXs/BL7klS/w3DVnLWta1njbvenfl43rIApNz0j7YZfHkP32+H0BcBmFAmrLblM13D4OjLDqr5cVPvSb5acCHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445731; c=relaxed/simple;
	bh=4JjZCvlSvAcrdGG6chlOPvtTzrD7zADg4rr91bu7xIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoQp8Yji6J2xmNrauFKF7fQVYlo1ko0pmtjzapce1BCr632QfK0A9j3hEgKcIBG6nyE/2hrAAzYekpm/1pJomv8kQWwLI0clq4TSC+8jlIoLl5m7MonYQLdc9a8wmcrk36ITsIipABXplUvwhVFdrjq18smXp1zvMPfZ6BsoNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgDxIBPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D37C4CED6;
	Tue, 25 Feb 2025 01:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740445730;
	bh=4JjZCvlSvAcrdGG6chlOPvtTzrD7zADg4rr91bu7xIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DgDxIBPrZN/fn5ejaaxlBPxDnP01A2n0WZFcdqZtxxJVYMxzi0KSKcEVhmvgCETdz
	 U3Sa/jyN4S/6hlwI2SAGwi71iSVV/IKo3WTIUofAuvN8RwbPPeESVshrqYF86ir25Q
	 YBaCf5yJkVPIKsryBDSSil4PkdZ2KhVjA5YC1wI8qB4NMgp8GLnbcsgqvXJJH/PnvZ
	 WT2DKdvGqOYjdrfssz82pYZ6aR6bMWUhEl/nc29Sly2EGFQcIKh4dlDs2CV6WOvSy/
	 lUbPkcJmiVT+OonOfjTHXq9prPuVNH/dbEdbXm3FOyDh/bx4YVrqNYb+W2SFQbjXqC
	 8BBjGEK1CFngA==
Received: by venus (Postfix, from userid 1000)
	id 663FB18066E; Tue, 25 Feb 2025 02:08:48 +0100 (CET)
Date: Tue, 25 Feb 2025 02:08:48 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>, rdunlap@infradead.org, 
	linux-kernel@vger.kernel.org, 21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn
Subject: Re: [PATCH v3] HSI: ssi_protocol: Fix use after free vulnerability
 in ssi_protocol Driver Due to Race Condition
Message-ID: <srkkyfb7lm4ywuro6vunaunv6q6sf4a3epyhggfzno4rk4v7wx@cgdxyuofk47m>
References: <20240918120749.1730-1-kxwang23@m.fudan.edu.cn>
 <88CA06F7CB097DC8+6c5e0521.3de0.19535fad611.Coremail.kxwang23@m.fudan.edu.cn>
 <Z7xRJbUVEcbWnCgO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="abwuhlsij27wg73r"
Content-Disposition: inline
In-Reply-To: <Z7xRJbUVEcbWnCgO@smile.fi.intel.com>


--abwuhlsij27wg73r
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] HSI: ssi_protocol: Fix use after free vulnerability
 in ssi_protocol Driver Due to Race Condition
MIME-Version: 1.0

Hi,

On Mon, Feb 24, 2025 at 12:59:49PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 24, 2025 at 11:23:06AM +0800, Kaixin Wang wrote:
> > At 2024-09-18 20:07:50, "Kaixin Wang" <kxwang23@m.fudan.edu.cn> wrote:
>=20
> > >In the ssi_protocol_probe() function, &ssi->work is bound with
> > >ssip_xmit_work(), In ssip_pn_setup(), the ssip_pn_xmit() function
> > >within the ssip_pn_ops structure is capable of starting the
> > >work.
> > >
> > >If we remove the module which will call ssi_protocol_remove()
> > >to make a cleanup, it will free ssi through kfree(ssi),
> > >while the work mentioned above will be used. The sequence
> > >of operations that may lead to a UAF bug is as follows:
> > >
> > >CPU0                                    CPU1
> > >
> > >                        | ssip_xmit_work
> > >ssi_protocol_remove     |
> > >kfree(ssi);             |
> > >                        | struct hsi_client *cl =3D ssi->cl;
> > >                        | // use ssi
> > >
> > >Fix it by ensuring that the work is canceled before proceeding
> > >with the cleanup in ssi_protocol_remove().
>=20
> ...
>=20
> > Hi, I noticed that there are no relevant replies to this patch that I s=
ent
> > several months ago. Is it missed?
>=20
> Seems like fell into cracks...

Indeed, but queued to hsi for-next now.

-- Sebastian

--abwuhlsij27wg73r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme9GB8ACgkQ2O7X88g7
+ppxeA/8DvFoQzvyYAOdV61yZMgaN33pzF6cUEfSgIGKkpI9UZSxp320sI1DKnO5
FKdwl6qIOZjVf/KXBKBJ5aQWORw8vHEW5E/mW5hkn0+UiEKNvShnlJorI1ra1/lo
wtTLG4JjU9QjZd4azZfZjmR5/09woGF+/PcCMfHcuefBXe0XSvnkHp0vOx1VENRo
nZnw73wInzf9k71SERs5M8ViIkLJlUcHojQisLSkpQXSFsJ/wQ5uI6NhGaRgA7/B
XgAx3CWLn/FXLnmA8PqA1O72f9+2l6oyntBqxqqkqpTddFBQxe/t1LanE6aXnHSU
ubdCo6eOaJ1DlNurEuP8ZDqGaK9/QEZVKY8IZPimM2HVHYZ+OEhDsofG8n65kEjc
2wmKI4SbGwKLbcrPsrL+8PRyPgqkWwrSn+ikORWQescaVWNJ7pdKdfCzpf9N8LnC
EAB+Vlev6HceblYCYuZjm2owxiiSnoceLtk2PIsmm2+3bKKw7+SGuPHRLiOSWGyz
E5lm4db1E4C27SJDB3e704yZYpat6lAVgCziE7wjQzliNCFAStN0FGBSXgjSbqdx
t9OKePiVD71hVeSYONuA7f9hR601wE9zBlc0MpzHrbyYxjY2eHK0ieqVguK1t0Wb
t4RZR4CCaV9G3bDTJXWN1q054eYSDOwhX1y7sVDyu+W9etU6Ag4=
=xqKz
-----END PGP SIGNATURE-----

--abwuhlsij27wg73r--

