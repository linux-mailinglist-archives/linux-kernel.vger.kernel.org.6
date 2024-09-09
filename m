Return-Path: <linux-kernel+bounces-321209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14099715E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BF0B2579E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E411B5803;
	Mon,  9 Sep 2024 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SDq3bFHz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC51B5338;
	Mon,  9 Sep 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879547; cv=none; b=Yz0JrCEO7FzICPG9ka5b0yro6DqOL0RkxJuEdtyfzQ02VBER3vu6y40isAjlblNjFLXDyX8zeT14TGIuExNW7rIMrO2xqwK0BP74dZfHav0gJG7bDGV1U5SdVGEmWQCXwc53Xu6ChZhDwZISMc61FAdEofDZsN6181mxnyw6ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879547; c=relaxed/simple;
	bh=t3Rf1MeA3cyYGLppiLzQ0ZvIDTirQffgCL6XpYhVB3A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISppXEl8Y+72D0kaAacWMPr14bT4NVvoTeCQdr5s0AzOFvDVAWrxms6bDTb6gGP0KHuZ+Fgq6zZ3nY5qBpM+pMzZ9W+15W4xgrfNbgrpyMvb94+TJfFoFW+OvUpPgEfE1uYGjLSZUjYx3Q+fO4OAx08KAV5TlbEKRBMsbJ1sSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SDq3bFHz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725879544; x=1757415544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t3Rf1MeA3cyYGLppiLzQ0ZvIDTirQffgCL6XpYhVB3A=;
  b=SDq3bFHz6+9/tsurpgKQYGC20ycnERx4265rHDSiNsLsnnBiFAV7mI+j
   J1AeJGsmiLLBy66Nf4ykskXmFaHlmshh/QQsdakwPW0Y2ZhiRPLqDwzQP
   Yviw9WmvvHChgqMQ0elY4TNr3VgvaaQk9hUJKQKs8qmJMwPrVqalnfL57
   yW5S1gFpb5LXNfCzG8SqAVBUCxF+iQF7lTGALBRzumazXhYn7kNW7Xo6o
   wMFsuijGGjTvb5+0F486ANFD915dfsFbneS8fero6tTJMAMfKrQHr66e8
   TrUZ9eIzBkOls82RORqN02AVN3wdRWCNqsJ9eU8VHGGieibxT1+qdBiof
   Q==;
X-CSE-ConnectionGUID: Fq4UIs45Smiz1mW+q5x7cA==
X-CSE-MsgGUID: e+e1WZbtSqmzJSCwPJBKhA==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="asc'?scan'208";a="34626940"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 03:59:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 03:58:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 03:58:36 -0700
Date: Mon, 9 Sep 2024 11:58:04 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Rob Herring <robh@kernel.org>
CC: Conor Dooley <conor@kernel.org>, <devicetree@vger.kernel.org>,
	<cyril.jean@microchip.com>, <valentina.fernandezalanis@microchip.com>,
	<nitin.deshpande@microchip.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1] dt-bindings: add IP versioning document for Microchip
 FPGAs
Message-ID: <20240909-fernlike-thickness-98b8c0566a0a@wendy>
References: <20240830-culinary-cautious-2c2c19902dcb@spud>
 <20240903145943.GA1002295-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KAW/k6vNVrLCa629"
Content-Disposition: inline
In-Reply-To: <20240903145943.GA1002295-robh@kernel.org>

--KAW/k6vNVrLCa629
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024 at 09:59:43AM -0500, Rob Herring wrote:
> On Fri, Aug 30, 2024 at 05:00:40PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > This is a pretty rough document I conjured up in 5 minutes, to document
> > my expectations for compatible strings for both our FPGA IP blocks and
> > reference designs that we ship, a la the one that exists for SiFive IPs.
> > There's been some internal conversations lately about this naming etc,
> > so good to have something written down.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > cc: cyril.jean@microchip.com
> > CC: valentina.fernandezalanis@microchip.com
> > CC: nitin.deshpande@microchip.com
> > CC: Rob Herring <robh@kernel.org>
> > CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > CC: Conor Dooley <conor+dt@kernel.org>
> > CC: devicetree@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  .../bindings/microchip/ip-versioning.txt      | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/microchip/ip-vers=
ioning.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/microchip/ip-versioning.=
txt b/Documentation/devicetree/bindings/microchip/ip-versioning.txt
> > new file mode 100644
> > index 000000000000..4a4e0e74c4e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/microchip/ip-versioning.txt
> > @@ -0,0 +1,34 @@
> > +Devicetree compatible string versioning for Microchip FPGA IP blocks a=
nd reference designs
> > +
> > +This document describes the versioning guidelines for compatible strin=
gs
> > +used on Microchip FPGA IP blocks and reference designs.
> > +
> > +IP block-specific compatible strings are in the form:
> > +"microchip,<ip-block-name>-rtl-v<major version number>"
> > +or optionally:
> > +"microchip,<ip-block-name>-rtl-v<major version number>.<minor version =
number>"
> > +
> > +<ip-block-name> should be the name of the IP in Libero's IP catalog.
> > +In most cases a major version should be sufficient, as breaking change=
s are
> > +intended to be accompanied by a version update, but if not, the option=
al minor
> > +version should be used,
>=20
> Please cover where do version numbers come from?

=46rom the IP itself, it's either listed in the catalog entry or in the
information for the instance. I'll have to double check exactly where it
can be found, but that is the source.

--KAW/k6vNVrLCa629
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt7UuwAKCRB4tDGHoIJi
0i3pAQDYB/GCqhU85G2zrGx98WK2fKYBVhbIFiyGAGjtzR8LwwD/eWvsdSSzEhvW
H33lggGHia//bGtutzSr7fY6MIbRjwE=
=iJ0Z
-----END PGP SIGNATURE-----

--KAW/k6vNVrLCa629--

