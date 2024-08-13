Return-Path: <linux-kernel+bounces-285158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA69509F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56E21F23EED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2621D1A0AFB;
	Tue, 13 Aug 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsQ/kg4W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22E19AD90;
	Tue, 13 Aug 2024 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565803; cv=none; b=YCiQTiw3hvZbE2aBndatuD9qmzyczhADv4OaFJpcQ3JVlJa3dPOZ8H9tUWhx6iZV0IYJUfvDNXvXDX9e9LGO2ei5LI4dT4kTT8OqQspEPv280zwxCgOqfa7cr0nVpbQb+Zgi6hv2mC3hvi6+iObCZJBdZJ9W5VCT5Q8XG8RKPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565803; c=relaxed/simple;
	bh=daOJgWX3PT8vZBC5urR9rWuZVDqjHh5/saAshpAPoAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjsTN29nB4Q2byvz56oIi+vZBef6kICDdiagacdFjSciw6GpRi4VYfdobyGHmNKqI1AQZuI0K+MG6Pihx4d9V8fS12FUfqst/ZQkzk/sUW0CtmF0/TPzPEfUAAAbYPgySvYDuSKJj3LxHy6BohKG28XOg5QfwN6eYJnZSoUFi4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsQ/kg4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D46C4AF09;
	Tue, 13 Aug 2024 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723565803;
	bh=daOJgWX3PT8vZBC5urR9rWuZVDqjHh5/saAshpAPoAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsQ/kg4WI10Y5eUajCACFdN/J7ekx2sJbxryxg2p1zSg+yBoMXNC7Rw5mFteNUxwL
	 Yg1QL4C/uFFS5m2JotwfWX4+Do9J1Er+MDWjI9ybMPiOxKNnmDeDtuuUn2fl/U0oBg
	 Fy+7h31xwUBtcvxjZbE+6c9ZmnkQkdAMunjmuExlv0Jhlrl9VwcjaMpNdhRLcg2kt9
	 kHN6gJ4023Xw1QsNVPysCq9wiwIzvMtd/DKGEPfMuWN6mglWhS6ZR7RX6PJlJeFPJK
	 hiukZXWgS53IxyfJvg/pWGZrtQ/e08OxHgcE1uPzKZowpy4yAHcaVyeIQ1jmGIGUq2
	 412R69seE3pAQ==
Date: Tue, 13 Aug 2024 17:16:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Chanh Nguyen <chanh@os.amperecomputing.com>,
	Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>,
	Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: hwmon: Add maxim max31790
Message-ID: <20240813-extruding-unfunded-0e14a5c161e1@spud>
References: <20240813084152.25002-1-chanh@os.amperecomputing.com>
 <20240813084152.25002-2-chanh@os.amperecomputing.com>
 <20240813-sister-hamburger-586eff8b45fc@spud>
 <10680d13-442d-4f12-a77c-2bd05f11dc10@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uC4C3RIk4uKBhTFS"
Content-Disposition: inline
In-Reply-To: <10680d13-442d-4f12-a77c-2bd05f11dc10@roeck-us.net>


--uC4C3RIk4uKBhTFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 08:52:22AM -0700, Guenter Roeck wrote:
> On 8/13/24 08:33, Conor Dooley wrote:
> > On Tue, Aug 13, 2024 at 08:41:52AM +0000, Chanh Nguyen wrote:
> > > Add device tree bindings and an example for max31790 device.
> > >=20
> > > Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> > > ---
> > > Changes in v2:
> > >   - Update filename of the maxim,max31790.yaml                       =
 [Krzysztof]
> > >   - Add the common fan schema to $ref                                =
 [Krzysztof]
> > >   - Update the node name to "fan-controller" in maxim,max31790.yaml  =
 [Krzysztof]
> > >   - Drop "driver" in commit title                                    =
 [Krzysztof]
> > > Changes in v3:
> > >   - Drop redundant "bindings" in commit title                        =
 [Krzysztof]
> > >   - Add the clocks and resets property in example                    =
 [Krzysztof]
> > >   - Add child node refer to fan-common.yaml                          =
 [Krzysztof, Conor]
> > > ---
> > >   .../bindings/hwmon/maxim,max31790.yaml        | 81 ++++++++++++++++=
+++
> > >   1 file changed, 81 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,ma=
x31790.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.y=
aml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> > > new file mode 100644
> > > index 000000000000..d28a6373edd3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> > > @@ -0,0 +1,81 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: The Maxim MAX31790 Fan Controller
> > > +
> > > +maintainers:
> > > +  - Guenter Roeck <linux@roeck-us.net>
> >=20
> > Why Guenter and not you?
> >=20
>=20
> Fine with me, actually. We don't expect individual driver maintainers
> in the hardware monitoring subsystem, and this chip doesn't have an
> explicit maintainer. Forcing people to act as maintainer for .yaml
> files they submit can only result in fewer submissions. I prefer to be
> listed as maintainer over having no devicetree bindings.

Sure, if you're happy with it. Having someone that knows about how the
particular model works is usually preferred however!

>=20
> > > +
> > > +description: >
> > > +  The MAX31790 controls the speeds of up to six fans using six
> > > +  independent PWM outputs. The desired fan speeds (or PWM duty cycle=
s)
> > > +  are written through the I2C interface.
> > > +
> > > +  Datasheets:
> > > +    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: maxim,max31790
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  "#pwm-cells":
> > > +    const: 1
> > > +
> > > +patternProperties:
> > > +  "^fan-[0-9]+$":
> > > +    $ref: fan-common.yaml#
> > > +    unevaluatedProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    i2c {
> > > +      #address-cells =3D <1>;
> > > +      #size-cells =3D <0>;
> > > +
> > > +      fan-controller@21 {
> > > +        compatible =3D "maxim,max31790";
> > > +        reg =3D <0x21>;
> > > +        clocks =3D <&sys_clk>;
> > > +        resets =3D <&reset 0>;
> > > +      };
> > > +    };
> >=20
> > What does this example demonstrate? The one below seems useful, this one
> > I don't quite understand - what's the point of a fan controller with no
> > fans connected to it? What am I missing?
> >=20
>=20
> Just guessing, but maybe this is supposed to reflect a system which only =
monitors fan
> speeds but does not implement fan control.

Even without any control, I would expect to see fan-# child nodes, just
no pwms property in them. Without the child nodes, how does software
determine which fan is being monitored by which channel?

Cheers,
Conor.

> > > +  - |
> > > +    i2c {
> > > +      #address-cells =3D <1>;
> > > +      #size-cells =3D <0>;
> > > +
> > > +      pwm_provider: fan-controller@20 {
> > > +        compatible =3D "maxim,max31790";
> > > +        reg =3D <0x20>;
> > > +        clocks =3D <&sys_clk>;
> > > +        resets =3D <&reset 0>;
> > > +        #pwm-cells =3D <1>;
> > > +
> > > +        fan-0 {
> > > +          pwms =3D <&pwm_provider 1>;
> > > +        };
> > > +
> > > +        fan-1 {
> > > +          pwms =3D <&pwm_provider 2>;
> > > +        };
> > > +      };
> > > +    };
> > > +
> > > --=20
> > > 2.43.0
> > >=20
>=20

--uC4C3RIk4uKBhTFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZruG5gAKCRB4tDGHoIJi
0pOFAP4/0+bg9cjKQnVF88AcHV6oKCmzIrA1RT6z0WKz2YQaTwEA7WffCz0ElzBM
nzSxulI2PfdAHoWuUAIlqFZj6fNb+Qo=
=iRVr
-----END PGP SIGNATURE-----

--uC4C3RIk4uKBhTFS--

