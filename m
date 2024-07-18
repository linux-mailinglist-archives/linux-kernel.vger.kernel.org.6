Return-Path: <linux-kernel+bounces-256332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3E8934C96
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5508B23BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488881386BF;
	Thu, 18 Jul 2024 11:31:08 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93875639;
	Thu, 18 Jul 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302267; cv=none; b=GJaFnQZ/sXLEMpk/m79eqIcsRdL+2az1ZZB4n3yhxV+U77Ksuj36jvhRpizKdHLFB6za2pdrhNIOI5PdbT2wFKrKfaTOuMk5zQhNp208X/yXl5pSg1pXQ6dFPOTp9jGhxCgLdIQ/NjBLcRu2fAO2XDz9xE9gma5X3Al477fe3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302267; c=relaxed/simple;
	bh=+VCRrBTFKNdz5EkxjA9kfRiSj/jzGVTeICKcDIP6uFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7jxHHM4qcRvxRP5+uoeVlYpbZzH//ldeYt6xdfhGJOgxXjAqgUV0VO5lsKesdrN4hurDNQ4GueT9dJ0Dm1ncuxhkDhi3GinImUSEDmNawhyw4gu4iZ1CZvWdONWnz4J0DiFCSAkB1lDsRQcJrl/GsnEsjMq/AmIVN4cdvu56mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d09.versanet.de ([94.134.13.9] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sUPLe-0004Fb-Er; Thu, 18 Jul 2024 13:30:58 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Conor Dooley <conor@kernel.org>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
Date: Thu, 18 Jul 2024 13:30:57 +0200
Message-ID: <30200583.43St1lv6Oq@diego>
In-Reply-To: <c60c8c462c6df23c1f1625bce5516525@manjaro.org>
References:
 <20240715110251.261844-1-heiko@sntech.de> <3178118.zE8UqtGg2D@diego>
 <c60c8c462c6df23c1f1625bce5516525@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Dragan,

Am Donnerstag, 18. Juli 2024, 12:53:07 CEST schrieb Dragan Simic:
> On 2024-07-18 11:25, Heiko St=FCbner wrote:
> > Am Dienstag, 16. Juli 2024, 18:15:08 CEST schrieb Conor Dooley:
> >> On Mon, Jul 15, 2024 at 01:02:49PM +0200, Heiko Stuebner wrote:
> >> > In contrast to fixed clocks that are described as ungateable, boards
> >> > sometimes use additional oscillators for things like PCIe reference
> >> > clocks, that need actual supplies to get enabled and enable-gpios to=
 be
> >> > toggled for them to work.
> >> >
> >> > This adds a binding for such oscillators that are not configurable
> >> > themself, but need to handle supplies for them to work.
> >> >
> >> > In schematics they often can be seen as
> >> >
> >> >          ----------------
> >> > Enable - | 100MHz,3.3V, | - VDD
> >> >          |    3225      |
> >> >    GND - |              | - OUT
> >> >          ----------------
> >> >
> >> > or similar. The enable pin might be separate but can also just be ti=
ed
> >> > to the vdd supply, hence it is optional in the binding.
> >> >
> >> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> > ---
> >> >  .../bindings/clock/voltage-oscillator.yaml    | 49 ++++++++++++++++=
+++
> >> >  1 file changed, 49 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/clock/voltage-=
oscillator.yaml
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/clock/voltage-oscilla=
tor.yaml b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> >> > new file mode 100644
> >> > index 0000000000000..8bff6b0fd582e
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> >> > @@ -0,0 +1,49 @@
> >> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> > +%YAML 1.2
> >> > +---
> >> > +$id: http://devicetree.org/schemas/clock/voltage-oscillator.yaml#
> >> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> > +
> >> > +title: Voltage controlled oscillator
> >>=20
> >> Voltage controlled oscillator? Really? That sounds far too similar to=
=20
> >> a
> >> VCO to me, and the input voltage here (according to the description at
> >> least) does not affect the frequency of oscillation.
> >=20
> > That naming was suggested by Stephen in v1 [0] .
> >=20
> > Of course the schematics for the board I have only describe it as
> > "100MHz,3.3V,3225" , thumbing through some mouser parts matching that
> > only mentions "supply voltage" in their datasheets but not a dependency
> > between rate and voltage.
> >=20
> > [0]=20
> > https://lore.kernel.org/linux-arm-kernel/b3c450a94bcb4ad0bc5b3c7ee8712c=
b8.sboyd@kernel.org/
> >=20
> >> Why the dedicated binding, rather than adding a supply and enable-gpio
> >> to the existing "fixed-clock" binding? I suspect that a large portion=
=20
> >> of
> >> "fixed-clock"s actually require a supply that is (effectively)
> >> always-on.
> >=20
> > I guess there are three aspects:
> > - I do remember discussions in the past about not extending generic
> >   bindings with device-specific stuff. I think generic power-sequences
> >   were the topic back then, though that might have changed over time?
> > - There are places that describe "fixed-clock" as
> >   "basic fixed-rate clock that cannot gate" [1]
> > - Stephen also suggested a separate binding [2]
> >=20
> > With the fixed-clock being sort of the root for everything else on most
> > systems, I opted to leave it alone. I guess if the consenus really is=20
> > that
> > this should go there, I can move it, but discussion in v1
> >=20
> > Interestingly the fixed clock had a gpios property 10 years ago [3] :-)=
=20
> > .
> >=20
> > [1]=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/clk/clk-fixed-rate.c#n18
> > [2]=20
> > https://lore.kernel.org/linux-arm-kernel/68f6dc44a8202fd83792e58aea1376=
32.sboyd@kernel.org/
> > [3]=20
> > https://lore.kernel.org/linux-kernel//20140515064420.9521.47383@quantum=
/T/#t
>=20
> After finally going through the v1 discussion [4] in detail,
> here are my further thoughts:
>=20
> - I agree with dropping the Diodes stuff, [5] because I see
>    no need for that at this point;  though, am I missing
>    something, where are they actually used?

On the Rock5 ITX that 100MHz clock comes the one single oscillator thing.

The Diodes parts are not root sources for their clocks but instead sort
PLLs or something, though their manual describes them as
"clock generator supporting PCI Express and Ethernet requirements" [8]

So they generate the 100MHz (frequency actually is
selected by input pins of the chip) from a separate 25MHz source clock.

One example are the Theobroma/Cherry embedded boards changed in v1 where
they currently are described via existing generic things (no schematics).

Another user is the rk3568-rock3b for example, where the diodes part
is enabled by the same rail as the port itself, so in contrast to the
Rock 5 ITX, it works "by accident" on the rock 3b [9]


The interesting part of the Diodes ICs is that they actually allow
configuration of the generated frequency via their S0 + S1 pins,
though they might be statically set in the board layout without
being user configurable. (Rock3b does it this way for example)


> - I agree that "enable-gpios" and "vdd-supply" should be
>    required in the binding, [5] because that's the basis for
>    something to be actually represented this way

I would only require the vdd supply though.

On the Rock 5 ITX, the chip does have an enable-gpio input, but that is
tied directly to the voltage rail and is not user controllable.


> - I agree that it should be better not to touch fixed-clock
>    at this point, simply because it's used in very many places,
>    and because in this case we need more than it requires (see
>    the bullet point above)
>=20
> - As I wrote already, [6] I highly disagree with this being
>    called voltage-controlled oscillator (VCO), [7] simply
>    because it isn't a VCO, but a clock that can be gated;
>    though, looking forward to what the last bullet point
>    asks to be clarified further
>=20
> - I still think that gated-clock is the best choice for the
>    name, because it uses "clock" that's used throughout the
>    entire codebase, and uses "gated" to reflect the nature
>    of the clock generator

"gated-oscillator" perhaps?=20

This would make it more explicit that we're talking about a root
for clock signals. "gated-clock" can be anything, in the middle
of a clock tree. Having a very generic name, also invites misuse.


> - Maybe we could actually use fixed-gated-clock as the name,
>    which would make more sense from the stanpoint of possibly
>    merging it into fixed-clock at some point, but I'd like
>    to hear first what's actually going on with the Diodes
>    stuff that was deleted in v2, which I already asked about
>    in the first bullet point
>=20
> [4]=20
> https://lore.kernel.org/linux-rockchip/20240709123121.1452394-1-heiko@snt=
ech.de/T/#u
> [5]=20
> https://lore.kernel.org/linux-rockchip/2e5852b9e94b9a8d0261ce7ad79f4329.s=
boyd@kernel.org/
> [6]=20
> https://lore.kernel.org/linux-rockchip/ec84dc37e2c421ee6d31294e08392d57@m=
anjaro.org/
> [7]=20
> https://lore.kernel.org/linux-rockchip/b3c450a94bcb4ad0bc5b3c7ee8712cb8.s=
boyd@kernel.org/

[8] https://www.diodes.com/assets/Datasheets/PI6C557-03.pdf
[9] https://dl.radxa.com/rock3/docs/hw/3b/Radxa_ROCK_3B_V1.51_SCH.pdf
    page 31, bottom left of the page


> >> > +
> >> > +maintainers:
> >> > +  - Heiko Stuebner <heiko@sntech.de>
> >> > +
> >> > +properties:
> >> > +  compatible:
> >> > +    const: voltage-oscillator
> >> > +
> >> > +  "#clock-cells":
> >> > +    const: 0
> >> > +
> >> > +  clock-frequency: true
> >> > +
> >> > +  clock-output-names:
> >> > +    maxItems: 1
> >> > +
> >> > +  enable-gpios:
> >> > +    description:
> >> > +      Contains a single GPIO specifier for the GPIO that enables an=
d disables
> >> > +      the oscillator.
> >> > +    maxItems: 1
> >> > +
> >> > +  vdd-supply:
> >> > +    description: handle of the regulator that provides the supply v=
oltage
> >> > +
> >> > +required:
> >> > +  - compatible
> >> > +  - "#clock-cells"
> >> > +  - clock-frequency
> >> > +  - vdd-supply
> >> > +
> >> > +additionalProperties: false
> >> > +
> >> > +examples:
> >> > +  - |
> >> > +    voltage-oscillator {
> >> > +      compatible =3D "voltage-oscillator";
> >> > +      #clock-cells =3D <0>;
> >> > +      clock-frequency =3D <1000000000>;
> >> > +      vdd-supply =3D <&reg_vdd>;
> >> > +    };
> >> > +...
>=20





