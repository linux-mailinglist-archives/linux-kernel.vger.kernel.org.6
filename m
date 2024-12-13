Return-Path: <linux-kernel+bounces-444746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28939F0BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF8E281F94
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED691DF735;
	Fri, 13 Dec 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="q4sPn34s";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="kh504LIt"
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7721DF263
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092057; cv=fail; b=kid0FStzWV8TiIRbY2HdD7koOxrA2Q2pCu0/JSeoZzaoNaUOh7qhEN4GBbBMaRPGcJnm0ku3me5Srr0P/dPNXo8EaX/2C+AqS0RFXmd1oYn+dwUJ3yPGsEp5Sww6PFVJWsLU4Y2FjRVlpGUQ4EBHZ2OXYJ6xklgLZn+gtcVgCyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092057; c=relaxed/simple;
	bh=on+3kOjcl/tu3R48ep6Fp66Q8LyJDxFH/zcLNPzbXow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FGJZTD5WjmFFxTFLdwg1AvqzKPSjglPJuxZBmf6D3fXQ+uY9pwv+h6bqr4Pq12D5Mum0ZmUGNlD6wJaVAZ5PHzfO++vMDlVmxlP/LD5yvP8F8FNJZQ07863uxZvRV0ADaBwcvdv+XcdTqqzOyrvRznbegGRTkigFMyT0DToEhJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=q4sPn34s; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=kh504LIt; arc=fail smtp.client-ip=72.84.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.sapience.com (srv8.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id E862D480525;
	Fri, 13 Dec 2024 07:14:08 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1734092048;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=on+3kOjcl/tu3R48ep6Fp66Q8LyJDxFH/zcLNPzbXow=;
 b=q4sPn34soKydu57/9MOjEXYwGdmyeJj2hCmSyqsRycrtjy3yZwIRXBe34Y97lrnBhAqrm
 J9yAY6yvZ5xLWmRBA==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1734092048;
	cv=none; b=mCeFMKbRbWJPrZtEHGL/TRg+QOJAvmLaaQ0ncKPgHKhoJaeJ562QKEct8Xayqy2MYu9go083lqz2jj1Yd72FM/HNgPcItTiHL/mQUv27I/CxfaqmtnAcbOiRQ5LIiaPUbQM0jYSlNEYZbQGQHyzr+WYDVdE82C56dz+iTWBZlEfel9Ke+PrwbYPKgW48so3oxYnMmqpgGeNhmRl88ulY8Dl0tADvFZ+Vc/ILl+U5fDFC/1mFlb7UyB8pWyAktpfv2zvKJDfk8q2qJjQzVWSxITVqibyNZhK4y2MabECkM6749LXBfo1DqWpxDffJQsaRQSG/p1L2C6DOeISMNrEHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1734092048; c=relaxed/simple;
	bh=on+3kOjcl/tu3R48ep6Fp66Q8LyJDxFH/zcLNPzbXow=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=nAgS6qbKdI0yR3Gu075nKMDm1nY/aqPSU838DZqGbuK21hsThoP3rWs97j2ktbjKwY4NfeQcosTmTzsJiLzPFdV9RVQe1iuMu5F4OLzfBfF1fYd1CZV2o+zcJuqtabdy0ZJ/27wyfIAdlx0U5lfWYPufg5SLtQ6xdDJORZVKi57e6gGyyMjZSnoUgBAOZfv8BmNkojGqFIreUDvoGiX+WU82Vk61hhDtbWKPlkj4x6XFQru09xdUADM9iYmSifAO7/qkclq0mOdvUFrbd/UN6HHpHguvJlMYFwUA9LPSJIcOOpxoTn2Alw4HHRWk6fw4o86v8f8H53h7VIJXIzZPBA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1734092048;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=on+3kOjcl/tu3R48ep6Fp66Q8LyJDxFH/zcLNPzbXow=;
 b=kh504LItE0Pj3pt4Wkqr//E6SOjF0D4S63h1tl240YyGFqwfOb48xV3OhaZ8xMxMEIMEL
 oD0H/yDDT1LT/fA/ae/hW9Y4HpdZsH+CeUAl3hmLPy/9eXPcN0fuccZjFEM1IkygQPWjQWh
 SgjClSUWvd8i3qqMFt1Vw8LomD/2/WGJSYdi0hbApWQ/dB//nA7n7pdm46JnPp07+o/T+CR
 AZmEt+tslcQrGRDtRXK13XQrZwP3UMO7M7NS/mBCSQCVKlZ1DJnWnbt3TsqcehPTDD1COfr
 Xul01E3Xe0eeh/+IQV+oO7FzcXPBymRWlCpAv/ThshpCo/AsQDw/FXGf3dZQ==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id B90A4280018;
	Fri, 13 Dec 2024 07:14:08 -0500 (EST)
Message-ID: <dd13efc9b3fe3e3acd599ca91b714fa92f6cb9a8.camel@sapience.com>
Subject: Re: 6.13-rc1 graphics fail
From: Genes Lists <lists@sapience.com>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, airlied@gmail.com, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Date: Fri, 13 Dec 2024 07:14:07 -0500
In-Reply-To: <7db24095f935d874fae466853b0984103f97b40f.camel@sapience.com>
References: <3b097dddd7095bccabe6791b90899c689f271a35.camel@sapience.com>
		 <Z07Mg2_6y2MW22qV@intel.com>
	 <7db24095f935d874fae466853b0984103f97b40f.camel@sapience.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-yjX0hr7VVXVlChB9wdQW"
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-yjX0hr7VVXVlChB9wdQW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-12-03 at 06:34 -0500, Genes Lists wrote:
> On Tue, 2024-12-03 at 11:16 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > ...
>=20
> > Probably https://gitlab.freedesktop.org/drm/i915/kernel/-
> > /issues/13057
> >=20
> Very helpful.
>=20
> I tested your patch set on Linus' tree commit
> cdd30ebb1b9f36159d66f088b61aee264e649d7a :
>=20
> =C2=A0 =C2=A0=C2=A0https://patchwork.freedesktop.org/series/141911/
>=20
> and confirm that this fixes the problem=C2=A0
>=20
> Thank you.
>=20
>=20

Just a CC to regressions list for tracking.

First report here:=C2=A0
https://lore.kernel.org/lkml/3b097dddd7095bccabe6791b90899c689f271a35.c
amel@sapience.com/

Fixed by patch set as noted above, but not yet in mainline or linux-
next.

Thank you again Ville for quickly coming up with a fix.

--=20
Gene


--=-yjX0hr7VVXVlChB9wdQW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZ1wlEAAKCRA5BdB0L6Ze
2191AP9B/XFuJzoozY9SuPe5rgJMEoYgdU1lPwVq7uI22li+UAEAtoZSAumqaeVA
FYnoRJYhHfK4M/sUzUz5a0qaLhX4Egw=
=3Hbb
-----END PGP SIGNATURE-----

--=-yjX0hr7VVXVlChB9wdQW--

