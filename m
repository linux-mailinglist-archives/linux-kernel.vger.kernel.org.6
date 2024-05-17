Return-Path: <linux-kernel+bounces-182368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691DD8C8A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9561C2128E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1261E13D8B8;
	Fri, 17 May 2024 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojeVfbUO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D812F5A3;
	Fri, 17 May 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965211; cv=none; b=hGhzhGznOzQH7Z57WOkrkH0Ie6qSlXj+a9UmiX/DsA/1hlFIoPalCtD04bWrIBV28WixvMRhO4aQ0dQhMM+GwlznDBtdgh+9L8GsiASc+u4aEIJEp4uvERYIItU8S7vqKwkFnIsmwV4QrDqRfmMuNqQ/ycVgCx3Feuijf1kvOj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965211; c=relaxed/simple;
	bh=rsQ1avTjcXONNAiKfYvcQsGWVH+WUA9EkQwyYwUy1bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEfdIVWygMgcl2wxShn+5IP2R0jqIlYQ6KUEm6icZQU1yeiZJyQDVPXFyGZHNgHvZz74DPHQDK58I//5ZOlGxnLB637EeZMSpK/SioRAXbgFQkLaaN4aBeycMy47iYu4Nym6I4O8l8wMGtlqHdv58GgjBNTw9vLAReIL+eso4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojeVfbUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B45C2BD10;
	Fri, 17 May 2024 17:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715965210;
	bh=rsQ1avTjcXONNAiKfYvcQsGWVH+WUA9EkQwyYwUy1bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojeVfbUOrUIybBIRl6iXpe77NPTEue+x3Mtmrzaxwk5Psphke0hAKwY3IjDAMKY7b
	 qvZG5Wdb8GEEZRrlEPpt3xPKQBS53QygfBWmT1yOdefyzlACSZzXG6aBE1TcsK5xMz
	 /rXO5sBhQu0a/bxboWURYz03Mq8AWXkxt5hK+7fO4PpDtIs8PleBf4ciWiq1F1FLf+
	 dkT0ygkBI8FZP+F14iXYL+hnihza9TtjZDXflW5ibOWBcvV4reWivmHW1YpM6StN46
	 fOyzG/pfdgYDUXGttXoJc0pCpjvAvuUGxbi/6FSbAHEmTtLLwA/uyMPMUyF6wRoP/K
	 VAtj1COrpJNXQ==
Date: Fri, 17 May 2024 18:00:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
Message-ID: <20240517-pointer-cloning-3889f3d6f744@spud>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
 <20240508215504.300580-2-chris.packham@alliedtelesis.co.nz>
 <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>
 <d11093bb-230b-4918-a8cd-4f4eb760ccf3@alliedtelesis.co.nz>
 <94c843e2-4415-4786-bfd4-a77fdbbfab07@roeck-us.net>
 <35361786-ef5f-4d81-83e8-e347f47c83ed@alliedtelesis.co.nz>
 <df40a387-37db-4a4d-b43f-ae22905789b5@roeck-us.net>
 <58fb36f5-4d4b-495b-a7cd-6129ab1ed454@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E0zBh/oCqKg5WlFd"
Content-Disposition: inline
In-Reply-To: <58fb36f5-4d4b-495b-a7cd-6129ab1ed454@alliedtelesis.co.nz>


--E0zBh/oCqKg5WlFd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 01:09:03AM +0000, Chris Packham wrote:
>=20
> On 13/05/24 04:58, Guenter Roeck wrote:
> > On 5/10/24 08:51, Chris Packham wrote:
> >>
> >> On 10/05/24 15:36, Guenter Roeck wrote:
> >>> Chris,
> >>>
> >>> On Thu, May 09, 2024 at 06:19:12PM +0000, Chris Packham wrote:
> >>>> Hi Krzysztof,
> >>>>
> >>>> On 9/05/24 19:06, Krzysztof Kozlowski wrote:
> >>>>> On 08/05/2024 23:55, Chris Packham wrote:
> >>>>>> Add documentation for the pwm-initial-duty-cycle and
> >>>>>> pwm-initial-frequency properties. These allow the starting state=
=20
> >>>>>> of the
> >>>>>> PWM outputs to be set to cater for hardware designs where=20
> >>>>>> undesirable
> >>>>>> amounts of noise is created by the default hardware state.
> >>>>>>
> >>>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >>>>>> ---
> >>>>>>
> >>>>>> Notes:
> >>>>>> =A0=A0=A0=A0=A0=A0 Changes in v2:
> >>>>>> =A0=A0=A0=A0=A0=A0 - Document 0 as a valid value (leaves hardware =
as-is)
> >>>>>>
> >>>>>> =A0=A0=A0 .../devicetree/bindings/hwmon/adt7475.yaml=A0=A0=A0 | 27=
=20
> >>>>>> ++++++++++++++++++-
> >>>>>> =A0=A0=A0 1 file changed, 26 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml=
=20
> >>>>>> b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> >>>>>> index 051c976ab711..97deda082b4a 100644
> >>>>>> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> >>>>>> @@ -51,6 +51,30 @@ properties:
> >>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 enum: [0, 1]
> >>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 default: 1
> >>>>>> =A0=A0=A0 +=A0 adi,pwm-initial-duty-cycle:
> >>>>>> +=A0=A0=A0 description: |
> >>>>>> +=A0=A0=A0=A0=A0 Configures the initial duty cycle for the PWM out=
puts. The=20
> >>>>>> hardware
> >>>>>> +=A0=A0=A0=A0=A0 default is 100% but this may cause unwanted fan n=
oise at=20
> >>>>>> startup. Set
> >>>>>> +=A0=A0=A0=A0=A0 this to a value from 0 (0% duty cycle) to 255 (10=
0% duty=20
> >>>>>> cycle).
> >>>>>> +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/uint32-array
> >>>>>> +=A0=A0=A0 minItems: 3
> >>>>>> +=A0=A0=A0 maxItems: 3
> >>>>>> +=A0=A0=A0 items:
> >>>>>> +=A0=A0=A0=A0=A0 minimum: 0
> >>>>>> +=A0=A0=A0=A0=A0 maximum: 255
> >>>>>> +=A0=A0=A0=A0=A0 default: 255
> >>>>>> +
> >>>>>> +=A0 adi,pwm-initial-frequency:
> >>>>> Frequency usually has some units, so use appropriate unit suffix and
> >>>>> drop $ref.=A0 Maybe that's just target-rpm property?
> >>>>>
> >>>>> But isn't this duplicating previous property? This is fan controlle=
r,
> >>>>> not PWM provider (in any case you miss proper $refs to pwm.yaml or
> >>>>> fan-common.yaml), so the only thing you initially want to=20
> >>>>> configure is
> >>>>> the fan rotation, not specific PWM waveform. If you you want to
> >>>>> configure specific PWM waveform, then it's a PWM provider... but=20
> >>>>> it is
> >>>>> not... Confused.
> >>>> There's two things going on here. There's a PWM duty cycle which is
> >>>> configurable from 0% to 100%. It might be nice if this was=20
> >>>> expressed as
> >>>> a percentage instead of 0-255 but I went with the latter because=20
> >>>> that's
> >>>> how the sysfs ABI for the duty cycle works.
> >>>>
> >>>> The frequency (which I'll call adi,pwm-initial-frequency-hz in v3)
> >>>> affects how that duty cycle is presented to the fans. So you could=
=20
> >>>> still
> >>>> have a duty cycle of 50% at any frequency. What frequency is best
> >>>> depends on the kind of fans being used. In my particular case the=20
> >>>> lower
> >>>> frequencies end up with the fans oscillating annoyingly so I use the
> >>>> highest setting.
> >>>>
> >>> My udnerstanding is that we are supposed to use standard pwm provider
> >>> properties. The property description is provider specicic, so I think
> >>> we can pretty much just make it up.
> >>>
> >>> Essentially you'd first define a pwm provider which defines all the
> >>> pwm parameters needed, such as pwm freqency, default duty cycle,
> >>> and flags such as PWM_POLARITY_INVERTED. You'd then add something like
> >>>
> >>> =A0=A0=A0=A0pwms =3D <&pwm index frequency duty_cycle ... flags>;
> >>>
> >>> to the node for each fan, and be done.
> >>>
> >>> That doesn't mean that we would actually have to register the chip
> >>> as pwm provider with the pwm subsystem; all we would have to do is to
> >>> interpret the property values.
> >>
> >> We've already got the pwm-active-state as a separate property so that
> >> might be tricky to deal with, I guess it could be deprecated in favour
> >> of something else. Looking at pwm.yaml and fan-common.yaml I can't qui=
te
> >> see how that'd help here. Were you thinking maybe something like
> >>
> >> pwm: hwmon@2e {
> >> =A0 =A0=A0=A0 compatible =3D "adi,adt7476";
> >> =A0 =A0=A0=A0 reg =3D <0x2e>;
> >> =A0 =A0=A0=A0 #pwm-cells =3D <4>;
> >> =A0 =A0=A0=A0 fan-0 {
> >> =A0 =A0=A0=A0 =A0=A0=A0 pwms =3D <&pwm 0 255 22500 PWM_POLARITY_INVERT=
ED>;
> >> =A0 =A0=A0=A0 =A0=A0=A0 pwm-names =3D "PWM1";
> >> =A0 =A0=A0=A0 =A0=A0=A0 tach-ch =3D <0>;
> >> =A0 =A0=A0=A0 };
> >> =A0 =A0=A0=A0 fan-1 {
> >> =A0 =A0=A0=A0 =A0=A0=A0 // controlled by pwm 0
> >> =A0 =A0=A0=A0 =A0=A0=A0 tach-ch =3D <1>
> >> =A0 =A0=A0=A0 };
> >> =A0 =A0=A0=A0 fan-0 {
> >> =A0 =A0=A0=A0=A0=A0=A0=A0 pwms =3D <&pwm 2 255 22500 PWM_POLARITY_INVE=
RTED>;
> >> =A0 =A0=A0=A0 =A0=A0=A0 pwm-names =3D "PWM3";
> >> =A0 =A0=A0=A0=A0=A0=A0=A0 tach-ch <2>;
> >> =A0 =A0=A0=A0 };
> >> =A0 =A0=A0=A0 fan-1 {
> >> =A0 =A0=A0=A0=A0=A0=A0=A0 // controlled by pwm 2
> >> =A0 =A0=A0=A0=A0=A0=A0=A0 tach-ch =3D <3>
> >
> > I think that would have to be
> >
> > =A0=A0=A0=A0...
> > =A0=A0=A0=A0fan-0 {
> > =A0=A0=A0=A0=A0=A0=A0 pwms =3D <&pwm 0 255 22500 PWM_POLARITY_INVERTED>;
> > =A0=A0=A0=A0=A0=A0=A0 tach-ch =3D <1 2>;
> > =A0=A0=A0=A0};
> > =A0=A0=A0=A0fan-1 {
> > =A0=A0=A0=A0=A0=A0=A0 tach-ch =3D <3>
> > =A0=A0=A0=A0};
> > =A0=A0=A0=A0...
> >
> > Context: pwm-names is optional and does not add value here unless I am=
=20
> > missing
> > something. Also, if I understand the bindings correctly, all=20
> > tachometer channels
> > controlled by a single pwm are supposed to be listed in a single node.=
=20
> > With the
> > above, you'd then have fan1, fan2, and fan3 plus pwm1 and pwm3 (pwm2=20
> > would be
> > disabled/unused).
> >
> > Code-wise, I think you'd then call
> >
> > =A0=A0=A0=A0struct of_phandle_args args;
> > =A0=A0=A0=A0...
> > =A0=A0=A0=A0err =3D of_parse_phandle_with_args(np, "pwms", "#pwm-cells"=
, 0, &args)
> >
> > with np pointing to the fan node. This should return the parameters in=
=20
> > 'args'.
>=20
> On that point. How would I explain in the bindings that cell 2 is the=20
> duty cycle, cell 3 is the frequency and cell 4 is the flags?

In the pwm-cells property in the pwm provider binding . You might want to
order it as <index freq flags duty> as usually that's the ordering done
in most (all?) pwm provider bindings that I have seen.
The pwm bindings I think are really unhelpful though - they all say "see
pwm.yaml for info on the cells in #pwm-cells, but then pwm.yaml has no
information. The information is actually in pwm.text, but the binding
conversion did s/pwm.text/pwm.yaml/ in pwm controller bindings.
I'll send a patch that fixes up pwm.yaml.

>=20
> The other complication is that one of the systems I have is x86 so I=20
> need to express this with the ACPI Device Properties compatibility code.=
=20
> I think I can figure out the ACPI table stuff but I can't call=20
> of_parse_phandle_with_args() directly.
>=20
> >
> > However, unless you have a use case, I'd suggest not to implement=20
> > support for
> > "multiple fans controlled by single pwm" since that would require extra
> > code and you would not actually be able to test it. A mandatory 1:1=20
> > mapping
> > is fine with me. Support for 1:n mapping can be implemented if / when=
=20
> > there
> > is a use case.=20
>=20
> The system I'm dealing with has exactly that. But we don't adjust the=20
> fan RPM directly so I think we're OK (just maybe some comments so people=
=20
> aren't confused by missing fans). The ADT7476 will adjust the PWM duty=20
> cycle based on the temperature, the fan RPM is just something we report=
=20
> (and generate an alarm if it goes too low).
>=20
> > The same is true for registering the driver with the pwm
> > subsystem - that would only be necessary if anyone ever uses one of the
> > pwm channels for non-fan use.
>=20
> Agreed. I won't plumb anything into the pwm subsystem. Although it would=
=20
> be kind of neat to see a LED that changes as the system gets hotter,=20
> kind of like an electronic thermochromic crystal.
>=20
> >
> > That makes me wonder if we actually need tach-ch in the first place or =
if
> > something like
> >
> > =A0=A0=A0=A0fan-0 {
> > =A0=A0=A0=A0=A0=A0=A0 pwms =3D <&pwm 0 255 22500 PWM_POLARITY_INVERTED>;
> > =A0=A0=A0=A0};
> > =A0=A0=A0=A0fan-1 {
> > =A0=A0=A0=A0=A0=A0=A0 pwms =3D <&pwm 1 255 22500 0>;
> > =A0=A0=A0=A0};
> > =A0=A0=A0=A0...
> > would do for this chip.=20
>=20
> Yeah that'd be fine for me.

--E0zBh/oCqKg5WlFd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkeNFgAKCRB4tDGHoIJi
0gsGAP9TfXE9mwcLmxdXm0MAVsD4MB7yThich6osnhWuZPnK4AEAs+1P42LT+6YL
sBlu222Rd2+6WB+AcbYBiL0UTpBYJwA=
=NlYM
-----END PGP SIGNATURE-----

--E0zBh/oCqKg5WlFd--

