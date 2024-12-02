Return-Path: <linux-kernel+bounces-428295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C56C9E0C7C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61EF28135A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9871DED40;
	Mon,  2 Dec 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="hPt0TDkh";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="grYD+yUK"
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB871ABEB7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=72.84.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168735; cv=fail; b=H6+CujIks1hZ6mkYr42goEwauRoI3pDh3wtrnww5aVG4703liPLc/2oAPm0hIvPpW/H59JiPJZa6nE4P0lNXt6tWJ6XCzyg6MU3hZhtdKr7yP+j0mmRbGvjmVLtv7wYc6cqMeBwCekhI7VlGT3usROIJg/hskA1hZanL/liTjKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168735; c=relaxed/simple;
	bh=24eBWM5zvWOQJFtGFMHQ5UsW0HB4FgikZ8J9vugUA2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHjEi2Zp2Eitt7sXpzUJSViPY/i/OS89BKe45F+T4YCangvbZ5Or4OGda/ADr935BScC7KRnDjuZ1gn0qEXTGsIEzgsSByIs5K/ys2mHtzluePwnko14aAjekeGEyNZWfBKmJuJOiueI5RqKh5HsbC0nDh0HPK71Bg0C7vAUoPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com; spf=pass smtp.mailfrom=sapience.com; dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b=hPt0TDkh; dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b=grYD+yUK; arc=fail smtp.client-ip=72.84.236.66
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
	by s1.sapience.com (Postfix) with ESMTPS id C4D4248061F;
	Mon, 02 Dec 2024 14:45:32 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1733168732;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=zSxq6dc1C7eTZYRmJ5a1OVy/bcEUQ/xAm6oa5UI/v4Y=;
 b=hPt0TDkh25l3KBcZ0ksnb+kn0dm1pJ6P/e0FodhBiJmTF7urYVbe/UcTSjxecEZKpETs+
 9FjopPn/k6Ngjn2Bg==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1733168732;
	cv=none; b=MuxblmtYAyHlCqrFX+/eW0t02eD1wUFWTit3zC7RjSE3Na6HyPLBoCiiMkEdLN1c8IFVV/IH2bTHw3TucnMoYzkgH6W3DSIxHt6xNnXapMhu9Gx8+2ibfWYQFGnldp1aMg6yjAk3lZEHsia5Tdw1kGpmgGqkIaSEIlvUiiVTAYgIHeTBEIe9T5WkxIv+j4nRUi50rdMTIlToBahaa/64/3C+0wDI+NUu/50nFqe8m22Ax7sQmUXfWBfNZl6arM2tLtbDTryv2y2A4uqpVIRvD2NZHRq6xL7CLQtLmkDfO17Fey4pmAU+ZwfKvndQcG5PKd+UyORsUdr5QhJ9DyVudg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1733168732; c=relaxed/simple;
	bh=24eBWM5zvWOQJFtGFMHQ5UsW0HB4FgikZ8J9vugUA2c=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:
	 MIME-Version; b=GQU06m5jATESFe+o3SzDOxlcqHqH6qKRVX/fDZYBErchh+jDXZCPgVwYj0xxunO4K1XvZ/3lqxAsgLd4X3FJIXF6kKQMGmF4dJ8KL27ZZDNyEDwQaBp7RemuNgcMOWI/Mf3O3K6E9bALJ0nuwyuMY4ZpjFOMUnETbfjp1s6OJhSMUpYZ2szqj3xg3BuV6kVqYQ8oLA8r1B+rOsXu6Snhr8iE1s8o7OvlV/rXLPv5y5+F+99Na2lvtdFSa5YPAP7T9MxTZZqIoatisg0xCUU14RhVSehGowLHR30scm3xL78TfoikqZk/h+RmyzLPLxLerGqRSXLntrt6FvW30wNnmg==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1733168732;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : mime-version : from;
 bh=zSxq6dc1C7eTZYRmJ5a1OVy/bcEUQ/xAm6oa5UI/v4Y=;
 b=grYD+yUKlZ/EEBO5MxepsTpYl63BfxsIczMYV5b7kNOygxvYxaPeD5dqxop9ELs9rBsq1
 7M2mMiY3D2dP1RpN4clSqLIA7t8z2Nb9Lk0sjzk7/KwZ9zCDHVoAr+LUPG7y9L7h7Q29+1u
 foiMAdHOe1vMQEGy14Co9vaVKqZpwMDBisH9KSZnOZyWkseBto8P4AjC2tVhJZBbLQMzENV
 /NG4BFLfsD2XE86nfUY1achRjEMorNCvZl1pscikNOLdR3Iprx3JEe2HNIBW181O+4DEe5M
 Umd7gaYCaeIyXe6i3IXUvPVElIsTu4pz3bMnqkc7uQHPFnekbkK36/HfvQlA==
Received: from lap7.sapience.com (lap7w.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by srv8.sapience.com (Postfix) with ESMTPS id 6D416280016;
	Mon, 02 Dec 2024 14:45:32 -0500 (EST)
Message-ID: <f5a15027978a1ee95de49c61604654afde46c0b9.camel@sapience.com>
Subject: Re: 6.13-rc1 graphics fail
From: Genes Lists <lists@sapience.com>
To: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Date: Mon, 02 Dec 2024 14:45:32 -0500
In-Reply-To: <c87fa6006f356f999a1d5165ee5e58422f68a3a3.camel@linux.intel.com>
References: <3b097dddd7095bccabe6791b90899c689f271a35.camel@sapience.com>
	 <c87fa6006f356f999a1d5165ee5e58422f68a3a3.camel@linux.intel.com>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mDMEXSY9GRYJKwYBBAHaRw8BAQdAwzFfmp+m0ldl2vgmbtPC/XN7/k5vscpADq3BmRy5R
 7y0LU1haWwgTGlzdHMgKEwwIDIwMTkwNzEwKSA8bGlzdHNAc2FwaWVuY2UuY29tPoiWBBMWCAA+Ah
 sBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEE5YMoUxcbEgQOvOMKc+dlCv6PxQAFAmPJfooFCRl
 vRHEACgkQc+dlCv6PxQAc/wEA/Dbmg91DOGXll0OW1GKaZQGQDl7fHibMOKRGC6X/emoA+wQR5FIz
 BnV/PrXbao8LS/h0tSkeXgPsYxrzvfZInIAC
Content-Type: multipart/signed; micalg="pgp-sha384";
	protocol="application/pgp-signature"; boundary="=-FrjAIU4t4PzjtbJ0d8we"
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-FrjAIU4t4PzjtbJ0d8we
Content-Type: multipart/alternative; boundary="=-LQQX2DQwsDzWmwVxU5MV"

--=-LQQX2DQwsDzWmwVxU5MV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-12-02 at 20:22 +0100, Thomas Hellstr=C3=B6m wrote:
> Hi,
>=20
>=20
> Your logs shows the i915 driver loading and not the xe driver. The
> i915
> driver is the correct one for your hardware unless you are
> experimenting.
>=20
> So please file an issue here
> https://gitlab.freedesktop.org/drm/i915/kernel/-/issues
>=20
> And follow up on the intel-gfx list (CC'd)
>=20
>=20
Thank you - dropping all but lkml and intel-gfx list.
=C2=A0Issue created :

https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13198

gene




--=-LQQX2DQwsDzWmwVxU5MV
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body><div>On Mon, 2024-12-02 at 20:22 +0100, Thomas Hellstr=
=C3=B6m wrote:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; b=
order-left:2px #729fcf solid;padding-left:1ex"><div>Hi,<br></div><div><br><=
/div><div><br></div><div>Your logs shows the i915 driver loading and not th=
e xe driver. The i915<br></div><div>driver is the correct one for your hard=
ware unless you are<br></div><div>experimenting.<br></div><div><br></div><d=
iv>So please file an issue here<br></div><div><a href=3D"https://gitlab.fre=
edesktop.org/drm/i915/kernel/-/issues">https://gitlab.freedesktop.org/drm/i=
915/kernel/-/issues</a><br></div><div><br></div><div>And follow up on the i=
ntel-gfx list (CC'd)<br></div><div><br></div><div><br></div></blockquote><d=
iv>Thank you - dropping all but lkml and intel-gfx list.</div><div>&nbsp;Is=
sue created :</div><div><br></div><div><a href=3D"https://gitlab.freedeskto=
p.org/drm/i915/kernel/-/issues/13198">https://gitlab.freedesktop.org/drm/i9=
15/kernel/-/issues/13198</a></div><div><br></div><div>gene</div><div><br></=
div><div><span><pre><br></pre><div><br></div></span></div></body></html>

--=-LQQX2DQwsDzWmwVxU5MV--

--=-FrjAIU4t4PzjtbJ0d8we
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYJAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCZ04OXAAKCRA5BdB0L6Ze
2687AQCOnRSqbnjRjicZ6VBpf1DCDbDeUVN+pvHU3/DjODowSgEAqTtilZaqlgG1
hhOdeRQteRsyBc3fNEwJaP1M6ndU3AY=
=02/+
-----END PGP SIGNATURE-----

--=-FrjAIU4t4PzjtbJ0d8we--

