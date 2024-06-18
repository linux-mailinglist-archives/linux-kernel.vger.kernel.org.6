Return-Path: <linux-kernel+bounces-219134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D0890CB89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D240F1F22EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874392139B2;
	Tue, 18 Jun 2024 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O4acL4YP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF832139A1;
	Tue, 18 Jun 2024 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709638; cv=none; b=lAeYrEzcEDTfIPVk1zqFjKnpsq1d9flS9DGEJD9p5/sk7mkEr9wH54dFDGYK9zM31MTFHGRlifRKfEUO5b7Z2l4DV6RTCsetVTls1OYWdzVX4Y3x61bRyQUFWbCrnowUsIYlyjTJvi6DbcqMmtvnfJviBjZ4+IN6wqrs2eQp1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709638; c=relaxed/simple;
	bh=IvE5FbcVI2pegd79JZlj+/QWHfl7QdtfKBA9OVblIcs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeAXmp3z+uxZch5zkZstrC1U3pP0X4rHXbYdNF3FOB/9s/97YiDK5N1hYzik00NHjmSBaSE7j6HdJ7X7ybGSeQSpYrlDNU1H1BpWuIakfyXatmDZa9+aqXVN47PBjapEyZyd0tU6ldzJRYHQCN8WGk+H6mjL4i0GLBYNQzEHCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O4acL4YP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718709637; x=1750245637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IvE5FbcVI2pegd79JZlj+/QWHfl7QdtfKBA9OVblIcs=;
  b=O4acL4YPEeeCgAdsnv7T/Su2pKy8eDpaK875qg1q7o10FqD33gm/ZxqH
   Fc+4xt4YZwCC4KWJn715KdyWx8QnV+Oq4WjuPxx5RaGVxumdoAxFjZ67f
   gFRCsMbv+0w64KnRfyR0AltQj6jGLDSIa2a4Sk0KMoRDP4GAbK5lmGlcR
   lSqEjYwn1Eq0q3CkRCuSToHnVU+4c1gQXMS0NUT/zB7YHWI0Kr/KjSEpE
   r73DO6exyrSKhfDRViEO0sJwaMZ2TZv+rc4IqfLD5IIMNbAUdt7XJDcVQ
   TU5fNbzR6rpzrvh/a2ibI8y7E1nSc3w94dp+rXycNHqZLw8Hhbev+b2Zv
   A==;
X-CSE-ConnectionGUID: PuOaNyA3Q265D/HqhrKrgA==
X-CSE-MsgGUID: hEgZvK9yRJyHfODyuYnfPw==
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="asc'?scan'208";a="30534875"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2024 04:20:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 18 Jun 2024 04:20:14 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 18 Jun 2024 04:20:11 -0700
Date: Tue, 18 Jun 2024 12:19:53 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
CC: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Message-ID: <20240618-antonym-tabloid-8f721ee752a5@wendy>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-2-a7d28dea5c4a@nxp.com>
 <20240617-control-calamari-317f59c4eb09@spud>
 <AM9PR04MB86049915593D86599C67975F95CE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+fn5GsXAWL169s6l"
Content-Disposition: inline
In-Reply-To: <AM9PR04MB86049915593D86599C67975F95CE2@AM9PR04MB8604.eurprd04.prod.outlook.com>

--+fn5GsXAWL169s6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 10:58:47AM +0000, Pankaj Gupta wrote:
> > From: Conor Dooley <conor@kernel.org>
> > On Mon, Jun 17, 2024 at 12:59:40PM +0530, Pankaj Gupta wrote:
> > > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> > > creates an embedded secure enclave within the SoC boundary to enable
> > > features like:
> > > - HSM
> > > - SHE
> > > - V2X
> > >
> > > Secure-Enclave(s) communication interface are typically via message
> > > unit, i.e., based on mailbox linux kernel driver. This driver enables
> > > communication ensuring well defined message sequence protocol between
> > > Application Core and enclave's firmware.
> > >
> > > Driver configures multiple misc-device on the MU, for multiple
> > > user-space applications, to be able to communicate over single MU.
> > >
> > > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> > >
> > > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > ---
> > >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 160
> > +++++++++++++++++++++
> > >  1 file changed, 160 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > new file mode 100644
> > > index 000000000000..60ad1c4a3dfa
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > @@ -0,0 +1,160 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > > +
> > > +maintainers:
> > > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > > +
> > > +description: |
> > > +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> > > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > > +  enables features like
> > > +    - Hardware Security Module (HSM),
> > > +    - Security Hardware Extension (SHE), and
> > > +    - Vehicular to Anything (V2X)
> > > +
> > > +  Communication interface to the secure-enclaves is based on the
> > > + messaging unit(s).
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> >=20
> > Just "firmware@<hex>" please.
> >=20
>=20
> Modified as per your suggestion,=20
> -    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> +    pattern: "^[0-9a-z]*-if@<hex>"

Firstly, that's not even what I said verbatim, which I could
understand. <hex> isn't even a valid bit of regex for this.=20
What I want to see is something like: "^firmware@[0-9a-f]+$"

--+fn5GsXAWL169s6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnFtWQAKCRB4tDGHoIJi
0miHAQDK5urm/jbXpXfJfqOdk/VRtRlPzLTUy47n0dGXRTwoqQD/TpLFsHuOmXDR
ImC+g+nyDCS4DQIZFnikdx8el2/ZSw0=
=6dVg
-----END PGP SIGNATURE-----

--+fn5GsXAWL169s6l--

