Return-Path: <linux-kernel+bounces-260057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B573D93A251
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DC51C22A71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08951153BF7;
	Tue, 23 Jul 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8iOCGcg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21945153800;
	Tue, 23 Jul 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743702; cv=none; b=NwzIZTFUpTU2jrI4oysIL1u9qdjnG9gBEKC0Jd7tYF47uqWGMDYpT1cf9K2L3X0ZFnlMDMFca3fXPZNH0NjiDxiM5gm28FzlhOSFnHcsI6Z49ic/ErLATyCXO6PiNNRp9BnUKCJZfyRYIb+2nEkVbSwpveeb3u2RlrnsFIlqUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743702; c=relaxed/simple;
	bh=rIR6ptMSospz1fBXm3NdOc/NDWzLkQ7d8uaI/p2zgvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgKusE9Y+A01ezD0WYHQl0uXF3KH69Yzy0JJZXZi9INpMOANsp5QBU16Nj6Cliuzd22nE0hU6Ni6jYLG/edxhRaf4NcqbEbXIJlb6AjZEmSDfE2i25ahqx0CLFPC4cW99QvEQKoyJ77/GTrfHXI3/bbYOWA94oJMKseYMTGtwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8iOCGcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033A9C4AF0A;
	Tue, 23 Jul 2024 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721743702;
	bh=rIR6ptMSospz1fBXm3NdOc/NDWzLkQ7d8uaI/p2zgvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8iOCGcg/qL2HCfhahlZnvGRqWZNwaDk2N/N4zh/0cSy5XZ4yWFYIstWkt55VQsNh
	 klFDOMaEkL7gVEG+JpVAjeOfWk8afIbNjGErk1QJ+Agi9GmSxJK6PoxFaILOHmvWst
	 gNcSXRfHViqpM3OXE9+NYSqtYpJaFLiGIeY22UMmdt5x6NjL9IaetJ7B1Uxn8h//y9
	 JFfj1xzKZZzlbjmIZuAjzHt+jKRNmnyOq1jyDJHjb88a3Hf5H40J91oqOVKuFm5M5W
	 ziUyEsdK2fdsbRdgF1EUv78pTWOCIZP4vMcYs6T0h8GayaX7dKhKLwCdjAHgRBEbhF
	 mhtjAfYLx+taA==
Date: Tue, 23 Jul 2024 15:08:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Message-ID: <20240723-smitten-shower-1d15c0f3cf97@spud>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
 <20240722-popper-comfort-7538ea70c77b@spud>
 <AM9PR04MB8604123E065315093347F66C95A92@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jzq89wAQ2QEgaltg"
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604123E065315093347F66C95A92@AM9PR04MB8604.eurprd04.prod.outlook.com>


--Jzq89wAQ2QEgaltg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 09:28:31AM +0000, Pankaj Gupta wrote:
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Monday, July 22, 2024 10:20 PM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw =
binding
> > doc

Please fix this ^

> >=20
> > On Mon, Jul 22, 2024 at 10:21:37AM +0530, Pankaj Gupta wrote:
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
> > >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91
> > ++++++++++++++++++++++
> > >  1 file changed, 91 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > new file mode 100644
> > > index 000000000000..7511d0e9cf98
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > @@ -0,0 +1,91 @@
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
> > > +  Communication interface to the secure-enclaves(se) is based on the
> > > + messaging unit(s).
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,imx8ulp-se
> > > +      - fsl,imx93-se
> > > +      - fsl,imx95-se
> > > +
> > > +  mboxes:
> > > +    items:
> > > +      - description: mailbox phandle to send message to se firmware
> > > +      - description: mailbox phandle to receive message from se
> > > + firmware
> > > +
> > > +  mbox-names:
> > > +    items:
> > > +      - const: tx
> > > +      - const: rx
> > > +
> > > +  memory-region:
> > > +    maxItems: 1
> > > +
> > > +  sram:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - mboxes
> > > +  - mbox-names
> > > +
> > > +allOf:
> > > +  # memory-region
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx8ulp-se
> > > +              - fsl,imx93-se
> > > +    then:
> > > +      required:
> > > +        - memory-region
> > > +    else:
> > > +      properties:
> > > +        memory-region: false
> > > +
> > > +  # sram
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx8ulp-se
> > > +    then:
> > > +      required:
> > > +        - sram
> > > +
> > > +    else:
> > > +      properties:
> > > +        sram: false
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    senclave-firmware {
> >=20
> > Last revision this was "firmware", but now you've got something that ap=
pears
> > non-generic. Why did you change it?=20
>=20
> In case you missed, there was a previous email requesting your view on th=
is change.
> Having node as "firmware {", is very generic that has wide interpretation.
> Hence, replaced firmware with "senclave-firmware".

Which I came across after reading the updated series. If you ask me for
my opinion on something, just wait til I reply to you before sending
another version.

> Why "senclave"?
> Like sram, for secure RAM, I proposed senclave for secure enclave.
>=20
>=20
> Moreover, there are plenty of examples of YAML(s), that were already comm=
itted; that are using this:
> linux_bkp$:> find Documentation/ -name "*.yaml" | xargs grep -r "\-firmwa=
re {"

Just because something got in before doesn't mean it should now.

> Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml:      zynqm=
p_firmware: zynqmp-firmware {
> Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml:      z=
ynqmp_firmware: zynqmp-firmware {
> Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml:    =
zynqmp-firmware {
>  And more...
>=20
> If you any other suggested word to pre-fix , that narrows down this broad=
 referenced word "firmware".

> Please suggest.

 I already did:
> > The normal differentiator for multiple
> > nodes is -[0-9]*, why can't you use that, if you're worried about multi=
ple
> > nodes?
> Thanks Conor, for the suggestion this. Will use this. Thanks.

--Jzq89wAQ2QEgaltg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp+5UAAKCRB4tDGHoIJi
0q7tAQCPrTH8oQp81LnUqAxW0aIBbOmWOERuWjwoAeRPTg11oAEAuQZuN8bt6s/u
opD9Ek20yVXFya29Hbn2nTmfXQ0skAU=
=l8OU
-----END PGP SIGNATURE-----

--Jzq89wAQ2QEgaltg--

