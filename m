Return-Path: <linux-kernel+bounces-528568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB67A41921
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F7A16D841
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D4245034;
	Mon, 24 Feb 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="edIUWxhI"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27DF2441B4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389261; cv=none; b=gVC5f3xhfWyk24FNLjlZ4rWmePCq4J/p+dA14YVK48+MFO+O3gwmb8Ss5bReI8Nxk0nGjryPSdGsFv0R7JWS3Z/9lVYetYIi+5afbw1hvK2G0EDk7E2eb06QS3Ys5N21468fp6KSgJmyEfhmmHEUdWoQ8V7TvKKPGB6L2Lif0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389261; c=relaxed/simple;
	bh=0Ohu78Zf/UEpjP9FyBlGg/0cZKd58JmhbgDBP0/Z8Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOInlPaXLkhrp9fBKloe0dvch6ekttl1vSzbAGxruOGV97eAsUAiqkssE13HaNBTWkiEKYi66FyFRt3ZYyXSFjHsJiULkQntKFvnKqW1BOOuYfoX00joK9LamkQcOFtPC9UotDOrUSSGfyAbX0c+yQxR4hY/Nhe0aM65BTsqXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=edIUWxhI; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1740389244; x=1740994044; i=christian@heusel.eu;
	bh=NrZLRnQZ8ugzVrwD0om47oW/zeqiczYDfHAh63LwAmw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=edIUWxhIy8hhEYa89TXOCXT0p7jparO7D4C/NRel+C07kXzKnCpij5qUmlb9yLII
	 xM/l4Y4wEdtlnMjJez+aGcAcTZwKEekBFQOjWYila6gZux+4rznxGa3mKDIcl1J5s
	 ijYsb0MG7MLRt+4VcGR6lWYDhxY7rpQcILy+VgwydWW6bJ1SLF2TbZ8byQi+Y5LMi
	 IH0PUO9cxWMwejNx7ZlpsLy29W/rKrvjwFcR68A+aMZsMl2SEhJ9rSKbpxKpuIzKH
	 D+FoMOLBMAQqhJLZ1EP/ZtPvmVVI52z97rkO7U7R1qfLiGNQYkVFHy0Cd5SMOI6LY
	 I1y/xYP7GlxoZ9RkSA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MPowd-1u0ZDT2CoN-00XcSE; Mon, 24
 Feb 2025 10:27:24 +0100
Date: Mon, 24 Feb 2025 10:27:22 +0100
From: Christian Heusel <christian@heusel.eu>
To: Sean Rhodes <sean@starlabs.systems>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	quintafeira@tutanota.com, Arnd Bergmann <arnd@arndb.de>, Desnes Nunes <desnesn@redhat.com>, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] SD Cards detection broken leading to boot
 failures
Message-ID: <50e67317-62bb-46aa-a539-54bf6dbb245a@heusel.eu>
References: <1de87dfa-1e81-45b7-8dcb-ad86c21d5352@heusel.eu>
 <2025022429-powdery-possibly-e4e5@gregkh>
 <CABtds-2TDWCHqOa+Di2Yh074RukUrjEhKGC82DWZ_7ysK-NCrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="izfjcqek7qbgaff5"
Content-Disposition: inline
In-Reply-To: <CABtds-2TDWCHqOa+Di2Yh074RukUrjEhKGC82DWZ_7ysK-NCrA@mail.gmail.com>
X-Provags-ID: V03:K1:85G+PFLrSgYtQaEM1qjDE6+iiLg97SEZKLHIA3wiNVoK8rD5lnY
 URPrcto/8beZY+wzYCkYJAKpMmxqjP1brzrp4ds0mTccAHK6br7zAyttqBDyk/KZimhzbrV
 Y/Ey4dJQVm0L3uhgUUbQlsM4qE986xnKlHEDU1VyU83ck8RgZHwjV+/mpf5jy+1fivrkvJZ
 SkvWABdTqNKFJ+Dch+XZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:58xAS1X/5XM=;s9mO2nr1XnSQxgUM/tckVxb7JrR
 J0rXj5llItKJS/bSE9DOGJ2ehclI6b5cBBz9i9DQ1ihiPj2bcfJ1SQZw6CSPZ4cENjUTO5AmF
 myh17TdIadNPfzgTw/yCYOGO3EdgTxWaWAF8bPl5gXw/xHNbFxpciQEirKAKsBM3KCWa9jbwE
 2k6C19LWzNsYvaFEv7V9tu1LA9q242TqFVs2OHTktZ372ySFmValY7tO0zLCBXQaGC0104KGY
 iZ3D5nibCCM5QoWGTJGemUK831951hYIZVU6+wbVXcoL52VOVgJzbBaL9Y0Q7qv6ggoTMqquI
 Yf9zSPTtr67z0me778XcI8B5hY8kt6P41t1ytYb01R5unPZ6xD2H6riehorneRRJKZcep4inE
 jT8a8v71XQz8g2oWHqxHNAWIOeKciT2K9koF/4NSCi6Wx6zPH9LXH7kaPe5re+Zmvi8o7YFyw
 sgbtjr3WN/NAefrdyBDOETrBYnjdNSw419nix8If/01O/s3brwiTBRMZSMbzDOuQ9+ft8KUQ1
 rF0zIiFYQ3dZOoronAd8FlbgDEmLY2zpSDY59CiXrbVdLm8BOzZZY+oaePPbkIOT7sfB3uNho
 q6pIJ/zAUPXR2Vf80uCuZK9bzwdxDfb5G0waXY1gYFdXRaG1E2IERoUDEEHUo7jhsHaABpA7N
 8PeMNtpbU/NpK3EqVezTInNNVfpkD15DK4mtgHLh+2IUO5s4U0gzQYdGmnm4WwwDjL3jUIwlQ
 OkCT0ElniM/BObPxdygR/E0XNumO79KqskDNRWN/0jiAOIYQIQvJyxbtxGrpXrmMNw2MRcKvh
 Bb74fa3BV7uBt6NDNcsTAgLFsszndoPCmXSwEB1P/bVJ0Rl8C+TSxQMPaTUCD8fv07/k2fT0i
 BKxBhECqMkcWUDvYqiXyCAHB3CL3Xdm/J2+LNXjVYVu9cPWjVLM3/xDxcm2KLSMJDGAMxZwiG
 UOM5QrL8O0x1RaKdgyo5eSgtZC9NEhRAU9IAYVhXMjjko64u7S3SmDejtMFSzqxRkK5XIXCis
 +0vaFokHBOlskTxCZOvnRSqK/8FUIQJkasUIUZZ09eUw17hhYL3X1go1TvYaQAGrPicXGDTPN
 dq8m1+yG9lzucoeYkTpMVvhLqFlTCphLsoTmj9lk4n+MnohKYIgpBzX1pjn0WRnx3J6D2FTZo
 wfhy4K8/SkYBiAeKceY+xOniaM+iK3YHgchx7oXBvbPA/Rv8/km8hPJVy70WdwOtqv14M6S/x
 w1upm/LlAfjatYdDn0dfs4YCQEMuTLA4kP+Cj013UOb1cSiKvpqrRGl2Weo1+gLa6u0Kj6Qor
 SCdkwD4x/MLTTjO+TPC+csoP78uXCLA9u53MxS/awBhBiAsHE8vM2O64+gSvKKZOMEnkKveZj
 Ge1LMbuzRUmxPEEPqnBHjwNYpUv19iZZN/H1s=


--izfjcqek7qbgaff5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [REGRESSION][BISECTED] SD Cards detection broken leading to boot
 failures
MIME-Version: 1.0

On 25/02/24 09:09AM, Sean Rhodes wrote:
> Give me a day, two tops please; ideally we can just push a patch to fix t=
he
> trivial issue and keep the major fix :)

Sure this is fine by me, I guess you can just hold off applying the
revert patch that I have sent after gregs comment.

If you need any testers for new patches or debug patches I'll happily
build them and send them to the reporters on the Forum.

Cheers,
Chris

>=20
> On Mon, 24 Feb 2025 at 07:07, Greg Kroah-Hartman <gregkh@linuxfoundation.=
org>
> wrote:
>=20
> > On Sat, Feb 22, 2025 at 10:22:34PM +0100, Christian Heusel wrote:
> > > Hello everyone,
> > >
> > > on the Arch Linux Forums[1] multiple users reported issues with their=
 SD
> > > cards not being recognized during boot or that they needed to re-plug
> > > them in order for them to be recognized.
> > >
> > > One user tracked this down to the following commit:
> > >
> > >     235b630eda07 ("drivers/card_reader/rtsx_usb: Restore interrupt ba=
sed
> > detection")
> > >
> > > They have also created a report on the kernel bugzilla[1], therefore I
> > > cc'ed them to this thread. We found that reverting the above commit on
> > > top of v6.14-rc3 fixes the issue.
> >
> > Thanks for the report.  Do you want to send a revert for this, or do you
> > need us to create it?
> >
> > thanks,
> >
> > greg k-h
> >

--izfjcqek7qbgaff5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAme8O3oACgkQwEfU8yi1
JYWemg/8C/m1ZwOLVXB3Xh4+m6dPW9xDvTG5fINVTGtdtFapK05tLSBsQhsuP/xu
eFL9xJ/9kzvhyUhaWqflWTl85YDtXIiLiGbWX6F7c3jo5VRjm2ucdjz8dez9KviS
3jr0uUfOL3INXNgQrvrUXbMO3VP3hvEBJCgEagtn2F6CIbjNzkfTACBCwPAOPk6z
SjwauibKwppxq93KyVvVxKCa1LdtLj2/FgEOAVvPEUkHPOFTas7PDDKRrAnFbfNt
i+LiWv0HCxpTy51v/ozWTR5W97iWEycF3jDFgQgdJp7GgyDrky4k3HSTq/T9d54E
VjzpwVgSxsvOsWWqCbVTWXwElnXr510v0NwEsd84JH2oY27z1/ci8jaGi+sdkS4v
d0lkFQwowp3Oz/Oxy5pm26qtnEMNFuSWkLws8H1WgmHzHc3nSKHWDrx1Ce9IRrNT
d0E3aCNnBgTH2XbPBC7JZK/KcsbY3UdUtq7eoyHKcJmMQtT9PPo60AcvzDaYkolx
yKY3qE4aaTxeb3hWoYT8+PAN+uAAiGTvMdXwH+lYbvAZdsf4XFMKOyP61tO9RyLm
cL91diKLZ6E6gCGpnW1JQAJs1T322lN5Gz8+jIq6jWxAUILc3Y7Nz6sH/vphw1uv
Fzj2Nj+IpqZfectwSdZA7psIvxZL98DIPvvuuj5sH+2sw8gD96o=
=wV/P
-----END PGP SIGNATURE-----

--izfjcqek7qbgaff5--

