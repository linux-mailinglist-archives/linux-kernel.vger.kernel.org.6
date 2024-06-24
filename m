Return-Path: <linux-kernel+bounces-227631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51869154BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF3286504
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50DB19E839;
	Mon, 24 Jun 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDuNkAqF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571919E819;
	Mon, 24 Jun 2024 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247741; cv=none; b=LrM1xqhtpKqXqZotq8Unbi/HhcOPt93AlSDJ89pLz5binZl97YGYH8EqglLAuwYlw5tP2LW5tpc0LfZB7Vvv1Km/L7aSQ9gQyCfmNey9DsXFkwxZ3CCE22qph1pP95Y5geM+n/Gp54Z43xXvqLXuOm4EqPo8lL4OVzmvF9+Dgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247741; c=relaxed/simple;
	bh=7EIjVKwobYxuhKEgtOIhJ9Tg39QihhVL1irIwcz75/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvNvtwUYosSeayovbF0lF6bwN3vL2R0mtKGYgxCobaXO1wliJ7RM6KjIDoCF+kAl9KIXC7cTbsPX3AIY/8XBFXwMu+OixJiair+Ki2J0HDX1rKaw/t3AoX2D1loOuZB/+d3j+kWpyipugs7sKD38p6HvNRhudOIQNpZaHOg4MLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDuNkAqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C50CC4AF0D;
	Mon, 24 Jun 2024 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719247741;
	bh=7EIjVKwobYxuhKEgtOIhJ9Tg39QihhVL1irIwcz75/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDuNkAqFjP6H0PMV65mMsXcQTZqp7Yc5hB9Vav1a59LWaGP2baR9wKX1cKnpYKIJP
	 65IXF7dazTdLnRbR05apDZcbYNMYxsmEm2ahd5tu7wv2Fn7FZXwm1FNB5P5YvNwA+T
	 d9JHTpvpL7rB96puSoeAlTRpOewu9NuKOSsG8l9jQqFBhYcONhOm/j1ZvWIO23ao37
	 9HiJ/bWJ1YCxp+APH7D5ez2Cg8cSvKsBENSVMPr5Vf7QO0gnqLSufsqffWpBlP6JhN
	 JO6BqGgpNWEWkFSDV917FfwleFozoPy7OX01s9TzaFZ/2w5NtI0945dDGFK+Ft0FNd
	 R+i+PjXjoDG0Q==
Date: Mon, 24 Jun 2024 17:48:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Message-ID: <20240624-buffalo-unison-fad374066b0e@spud>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-2-a7d28dea5c4a@nxp.com>
 <20240617-control-calamari-317f59c4eb09@spud>
 <AM9PR04MB86049915593D86599C67975F95CE2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240618-antonym-tabloid-8f721ee752a5@wendy>
 <AM9PR04MB8604F9A6B01C3794CAAAF36C95D42@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tq5e8PI+/1dzunEp"
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8604F9A6B01C3794CAAAF36C95D42@AM9PR04MB8604.eurprd04.prod.outlook.com>


--tq5e8PI+/1dzunEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 01:46:19PM +0000, Pankaj Gupta wrote:
> Thanks Conor, for the help.
>=20
> Sorry to miss out this mail reply.
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor.dooley@microchip.com>
> > Sent: Tuesday, June 18, 2024 4:50 PM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Conor Dooley <conor@kernel.org>; Jonathan Corbet <corbet@lwn.net>;
> > Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> > Conor Dooley <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob Herring
> > <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev=
; linux-
> > arm-kernel@lists.infradead.org
> > Subject: Re: [EXT] Re: [PATCH v3 2/5] dt-bindings: arm: fsl: add imx-se=
-fw
> > binding doc
> >=20
> > On Tue, Jun 18, 2024 at 10:58:47AM +0000, Pankaj Gupta wrote:
> > > > From: Conor Dooley <conor@kernel.org> On Mon, Jun 17, 2024 at
> > > > 12:59:40PM +0530, Pankaj Gupta wrote:
> > > > > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X
> > > > > etc., creates an embedded secure enclave within the SoC boundary
> > > > > to enable features like:
> > > > > - HSM
> > > > > - SHE
> > > > > - V2X
> > > > >
> > > > > Secure-Enclave(s) communication interface are typically via
> > > > > message unit, i.e., based on mailbox linux kernel driver. This
> > > > > driver enables communication ensuring well defined message
> > > > > sequence protocol between Application Core and enclave's firmware.
> > > > >
> > > > > Driver configures multiple misc-device on the MU, for multiple
> > > > > user-space applications, to be able to communicate over single MU.
> > > > >
> > > > > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> > > > >
> > > > > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > ---
> > > > >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 160
> > > > +++++++++++++++++++++
> > > > >  1 file changed, 160 insertions(+)
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > > > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..60ad1c4a3dfa
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > > > @@ -0,0 +1,160 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > > +1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > > > > +
> > > > > +maintainers:
> > > > > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > +
> > > > > +description: |
> > > > > +  NXP's SoC may contain one or multiple embedded secure-enclave
> > > > > +HW
> > > > > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > > > > +  enables features like
> > > > > +    - Hardware Security Module (HSM),
> > > > > +    - Security Hardware Extension (SHE), and
> > > > > +    - Vehicular to Anything (V2X)
> > > > > +
> > > > > +  Communication interface to the secure-enclaves is based on the
> > > > > + messaging unit(s).
> > > > > +
> > > > > +properties:
> > > > > +  $nodename:
> > > > > +    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> > > >
> > > > Just "firmware@<hex>" please.
> > > >
> > >
> > > Modified as per your suggestion,
> > > -    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> > > +    pattern: "^[0-9a-z]*-if@<hex>"
> >=20
> > Firstly, that's not even what I said verbatim, which I could understand=
=2E <hex>
> > isn't even a valid bit of regex for this.
> > What I want to see is something like: "^firmware@[0-9a-f]+$"
>=20
> These nodes define the interfaces(-if) to the "secure enclave" FW(-fw).
> Will replace "-if", with "-fw".
>=20
> There are multiple NXP IP(s) for secure enclave(s):
> - EdgeLock Enclave (ele)
> - Vehicular to anything (v2x)
> - SECO (seco)
>=20
> Having "ele-fw" helps identify the FW IP name.

If you need to indentify it, just use a label. "ele-if" or "ele-fw" is
not a generic node name.

>=20
> Will it be fine to use:
> -    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> +   pattern: "^[0-9a-z]*-fw@[0-9a-f]+$"
>=20
> or
>=20
> -    pattern: "^[0-9a-z]*-if@[0-9a-f]+$"
> +   pattern: "^[0-9a-z]*-firmware@[0-9a-f]+$"

No, just use firmware please.

Thanks,
Conor.

--tq5e8PI+/1dzunEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmjdwAKCRB4tDGHoIJi
0r+gAQCyiiV0vjrfFRaz1N5YBIUMo8wNM+UMu8VCKySqxgd/AwD9GOcXAgTuK+Wj
eugyHt5D3w4H38UNyDR/kO1WrqflYQo=
=71M8
-----END PGP SIGNATURE-----

--tq5e8PI+/1dzunEp--

