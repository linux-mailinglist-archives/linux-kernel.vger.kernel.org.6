Return-Path: <linux-kernel+bounces-535164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE76A46FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD457A317A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C0425D91D;
	Wed, 26 Feb 2025 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="W1mn5Vq3"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5227004B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613918; cv=none; b=NfTau3u5Qz1fw7sdgZFNUT9coN3cpXvti1JspVED9g551a4AAb1SeNSDX4i1Z7QsZl1dvxpofxdReU30S5rXGa/eEhN7o335nwI6F2LoQE7q6Sn3lQ+E1pXySJvwFgYnod66aVeGQJ47Zm/lZdco3UQbLC9KZOfI0cnzBSgkqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613918; c=relaxed/simple;
	bh=xmIq/W+6KTZJx0jkgAcBnkZ10aGBzJKf2J/843j1erk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffo81jKAVqwW6BXREpyJKzR2TQDTNGnmUBSRd9VEvCLB+N/eVIKs4+zVmQAwiWrIk1cgnhAjfaPNPmFz8+hX49p1GxGsXeFjNYGOqz5UpjT5XrAe42HBVIqsw4rTnrq/83Qx+x9J0jZXIQHoax7M36VKrHjV4O5KmcdfIHBQJh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=W1mn5Vq3; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1740613907; x=1741218707; i=christian@heusel.eu;
	bh=ctqQsUfu4Pqg3mtV+bUnrVknuC4ZOOdHjvbmVoAs19w=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W1mn5Vq3DFAuKCrSrRZl92LVaHR3L/aCEIstucIFfzgtvXkM1FelXsJ46PZxC28g
	 7M8ff/njuNoY1OZGD6y69W+e1RL78b53pv0bVi68wFik5yBKkTd9Dfghiz4BQPhwJ
	 Qat9ageAiKqeIjmrNdRMHzU5sQKdgNNpwZOLecYMPuIzesW46pHJUTV+HfUpiDHYY
	 HycTzfLynfTKRzWeOXUU1w+DE5QhFs2ds7lkSy5y/6nlgRGekZiL7jCaWYgm5/gGe
	 ee+Ai5Qhd+kQ9b4xTjXWVIKVkOgY8tblzW+xf9KqAzmdMybIWST0HsruH7f/f3SJS
	 KJNN8Vl75zHVkTiAQQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MPK73-1tx9KX4B5R-00XkME; Thu, 27
 Feb 2025 00:46:17 +0100
Date: Thu, 27 Feb 2025 00:46:16 +0100
From: Christian Heusel <christian@heusel.eu>
To: Sean Rhodes <sean@starlabs.systems>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	quintafeira@tutanota.com, Arnd Bergmann <arnd@arndb.de>, Desnes Nunes <desnesn@redhat.com>, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] SD Cards detection broken leading to boot
 failures
Message-ID: <b80dc39c-cfa5-4064-906b-4cbc2ae8fad3@heusel.eu>
References: <1de87dfa-1e81-45b7-8dcb-ad86c21d5352@heusel.eu>
 <2025022429-powdery-possibly-e4e5@gregkh>
 <CABtds-2TDWCHqOa+Di2Yh074RukUrjEhKGC82DWZ_7ysK-NCrA@mail.gmail.com>
 <50e67317-62bb-46aa-a539-54bf6dbb245a@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t3fekkihnptrywhs"
Content-Disposition: inline
In-Reply-To: <50e67317-62bb-46aa-a539-54bf6dbb245a@heusel.eu>
X-Provags-ID: V03:K1:uPSfHjWljAB02VWFSZFx9t8NKq9J7nWMyM8Ak69djMLuqRtTYqz
 UzABhDOFif3MsGVpkKwL/M1WRpFaKo8EnTjma3AhzBQzCyRtYuZImpGNe6IWYrrTCwzj+hZ
 PdUwKIO9AgdTeIdnpo2jzAkWmw5Ov1nBnR+YgkASpII/VIF48knzTErjEv+yj9oN9WFQUFa
 D1lBBbM6yL52rjiP/qBTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BbTGaUlomuQ=;qNALSJK7W7m5i4IIWJsuqd4B1lw
 a8uMsgXhvXIh5BJDNs3k45+Iwqw/x/paVV8aPvUhzxP9NpX+Pd42JKrA0TDydPSzAqvWlZCby
 mCBqGeZ+c4m9oBNBZ0F608QSP3trqOVSmkogjIlAiLcspHDLklyUHiPCP2uSNEErQOLeAinrS
 /bwP4clAHCgsdcDGBJWDByVEZlwJMIvmYBUTU7CUp653j2xmyQE8hcYAevwOvlK2Vv1sSNgLH
 NtrNnasSdWy73rN14zcWNuwW7d6CYCOls7h0YiuPs/QI2zaEVTKroDr8M5dzm1mBK3QUZsgwa
 wQqE4OkRqTXOHAa3YcCrsJNlDFrSt7ieTl8rDuSZVZZ957ZRchdIoBKhjFvQ/Czc+EpZ/PQ7F
 gYbHC3Vxt9RIbUC/X2wBiNcRYIi67IqTRCqB3Ji3+v+/t8N2LEAoS4imCvp65QEkPgBndFZbL
 m9f3qX+YPsd3zN7qxlh8h25wvEPtIxhZEt85uNbKLavZNTrNnrGQtzstNgsLslsLCWG3g1C4Y
 DF1bcoxgrN/nHCgP+6IF4R5IrZjQAR+bshPIxlRSadbVaBr+DPxHZsxSWMaV0fl1mubdGTBVo
 zXIYyp58AFvaY+/4KbJhwYaj9CUeIRnks95HxNwJiy5UXKCmmv6xzX1+psVAGR7dBBt44u8KT
 oYp6q3iD1Y/ncGaSNIUK+Olv5WZ2OQsO61KlLqqv6FQJhyn2JFmgSXFfrVGubhOn1QHbRvFny
 uG8oSEsnzmKHm0VO2nzjFbetf8ZbfhD0z8zD9DetTGhGJP1dSkrowr2svKbG1ugV76CV/cMY3
 ahwUjTedYKYg/6Ktt+zdSCVZ/Yj8rqafiEHPzoyGq1CiC4d6b34oRFVlVz5gx5M9Pkxvi2gDe
 ATIsX/qIbtPu2aZDOgS7s388/+XEXwQE4U55+xXyt2dnJ3nbEwjsmNFJ08ec8LIlTNp4Ux9I7
 MAb1GFDAe7DHOZ7ocg/BvXRnfNDwV+22br63rlwngh7NlHZ7fnDLRnvpgBl0FJkj58giz4p9O
 Mel5CuHh8RiXGGCdHCgtnfPHObjYYd+2Yb+AAFdsejvVhJfwpP/3VUkZLZJpbwobUj4ffsv/D
 Px7WvtZTYyEsJobxlLDpykDM/QssPppZeLdWvPpTAX8vVDryteBjj611ZX4IGrbDiOx5zCsYz
 SeDP71RVLe/lhHQ1TSNUBTIcmVdUUA9HIQNSgZ5711lsj50Fva4H5KXY06vQPZLPcwOPttUCu
 Np7+tOsWxRTcLvPaBcuV9nXGC7HXcn5eO9VBk60GJZ8ym73Hv/fy7OVhhwjakdTUEMryLhxEq
 KtJxA8PgwdYd4gXkAh7y9y4qVjkVwHz8urFXskqa0alHona7Cf+B0SrBtMd2l86Gc9O0QNOl7
 aPNzqYGXaK92kECA==


--t3fekkihnptrywhs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [REGRESSION][BISECTED] SD Cards detection broken leading to boot
 failures
MIME-Version: 1.0

Hey Sean,

On 25/02/24 10:27AM, Christian Heusel wrote:
> On 25/02/24 09:09AM, Sean Rhodes wrote:
> > Give me a day, two tops please; ideally we can just push a patch to fix=
 the
> > trivial issue and keep the major fix :)
>=20
> Sure this is fine by me, I guess you can just hold off applying the
> revert patch that I have sent after gregs comment.
>=20
> If you need any testers for new patches or debug patches I'll happily
> build them and send them to the reporters on the Forum.

Did you already have a chance to look into this or should we go with a
revert for the time being? Just asking because you wanted to come up
with something quickly :)

Cheers,
Chris

>=20
> >=20
> > On Mon, 24 Feb 2025 at 07:07, Greg Kroah-Hartman <gregkh@linuxfoundatio=
n.org>
> > wrote:
> >=20
> > > On Sat, Feb 22, 2025 at 10:22:34PM +0100, Christian Heusel wrote:
> > > > Hello everyone,
> > > >
> > > > on the Arch Linux Forums[1] multiple users reported issues with the=
ir SD
> > > > cards not being recognized during boot or that they needed to re-pl=
ug
> > > > them in order for them to be recognized.
> > > >
> > > > One user tracked this down to the following commit:
> > > >
> > > >     235b630eda07 ("drivers/card_reader/rtsx_usb: Restore interrupt =
based
> > > detection")
> > > >
> > > > They have also created a report on the kernel bugzilla[1], therefor=
e I
> > > > cc'ed them to this thread. We found that reverting the above commit=
 on
> > > > top of v6.14-rc3 fixes the issue.
> > >
> > > Thanks for the report.  Do you want to send a revert for this, or do =
you
> > > need us to create it?
> > >
> > > thanks,
> > >
> > > greg k-h
> > >



--t3fekkihnptrywhs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAme/p8gACgkQwEfU8yi1
JYVnIxAAqLpoG+XE60RF+L5eoOT/wMj8bv+R72pnVogrISgDYGIdkpFKjvWZrhlK
if7IpyofhELQPYU5GojKKOZl6zwEzOl0JdTYllly1AGj+f/HsjXHsUdB2rkWaeeS
ZyVLz3d3S1s9s/ajgAwmiv050ySbHLgwJZ7hgo6kk5iSbNqVRWnHmYX4UovlJlcy
AgiQo0beS/o1ESmipiqMFx1GPMSqGOS8vdszgicH8nKWSf+YESun46p8DXCVHmhN
NDwIdhaPWFOiBrLqsQpcIdqwTMJ5khCumD0oUPudflUb0lormId4wMHdNnnH8Gxm
8i0g0avJv6fUiMa1QHRc7V50ap0rWa/LEDyTxDLBDKW4UlvO6phtZA2q0JA/B/iX
lsy8OC9Aa/eGneDNdQJ3vqRtJWBGGioikzpp7GjHZD9Cnz/nvLi7dHlgvnpWCje0
UUqHxvRaQO+Q3eSh2tNIh+BW2rVOCCePz3Se9dBAwkA76tThLbIhfHy02U2Vl3jA
Wk3oH4Sd386KI0YnH2S77YfDrL5d0s8mfv41X3JUHer8SXCj6TTL7ZwPofIE0Hya
U2xhd9+k1y4zyGJAh9jSGSDPIQQrr+w6He5gaqwJ4xzrcfCix9ZRbRw9JQ7wX3Ow
U0ojC/bK+3BNFngmDkluuEjqdks4lpLoj23toxPTkEdNCBNpNTQ=
=tFe8
-----END PGP SIGNATURE-----

--t3fekkihnptrywhs--

