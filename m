Return-Path: <linux-kernel+bounces-560451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F326A6046A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B294E3B3742
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BD81F790F;
	Thu, 13 Mar 2025 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDrxNl7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C21F12EB;
	Thu, 13 Mar 2025 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905249; cv=none; b=Jx8duipStub6T0Tnlj4rtH4niL8UMTmntdas3uWPADofIP4+K+OgB3F34onIMfI0XgLYc4sTfZF6P2K81cURwIVQLC0h51cT5Lt4iia91v9u3a/UzwjYz1Hv/q8MKDC6EVkQG5VnKIWc8N3pTA+OPULoeA/2SxHIHvyT9PCrm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905249; c=relaxed/simple;
	bh=OH8SKV3EpGTINOyp0l73k/e/saWtSYUO8XFQ+5bYqKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxMwuuaUowQ3mA9Esl0Xh3rc5h5sPSz3hkv/3KitQLXOpyNwJsC9BhU3jvG3rICv75GRyNsPBHtgJ6/hCLOub8SqANbn6StjxZGAUQQHdjh4E3iLqp0e7aujza1myCzHpAZNA875tb4yO/zdcrmkMurOdmON1X1E+exO9tvx1HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDrxNl7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C15C4CEDD;
	Thu, 13 Mar 2025 22:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741905249;
	bh=OH8SKV3EpGTINOyp0l73k/e/saWtSYUO8XFQ+5bYqKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDrxNl7TfU3zY5HAqFwmGLsa5buw1ltxtr8qA+s3P5xsOUe5ymPLy4o9pCQTwx+nX
	 SF15AFE2kAq2hn62gwhQeGT8CVN1w3oRA3s3DOpk94feJKHx1YLw7HjfrYk823I07H
	 SQJhYFgkJkvXEaIMZyw2HQyDDaa1B7IN1S20AEC3HN28s7tY/quRoDhAQ6cEKhqPQC
	 crTeXyu4i0dyQ7VkpFyYOleqNgLrHZ1WP6WYWKVocuAGQY1a3GUnkZZf4sotCpYGie
	 PuMT4PcEbJzJAXf5W/LFwDfl4xCMIaQ+slWOdW1nHcWgtsKWIJ44iOxequfURRe+yM
	 I6SCV2Ywlnl8w==
Date: Thu, 13 Mar 2025 22:34:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Nick Hu <nick.hu@sifive.com>
Cc: Rob Herring <robh@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: timer: Add SiFive CLINT2
Message-ID: <20250313-kimono-passport-496a312a849c@spud>
References: <20250311051903.3825-1-nick.hu@sifive.com>
 <20250311195953.GA14239-robh@kernel.org>
 <20250311-erasure-rival-f68525c21742@spud>
 <CAKddAkBwkVQS7UtVvXCdLxEz6bz1=_X1u1CGUPm-OHiyAD4Dsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IrKm9n+XjpE4JIEJ"
Content-Disposition: inline
In-Reply-To: <CAKddAkBwkVQS7UtVvXCdLxEz6bz1=_X1u1CGUPm-OHiyAD4Dsw@mail.gmail.com>


--IrKm9n+XjpE4JIEJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 03:58:05PM +0800, Nick Hu wrote:
> Hi Rob and Conor
>=20
> Thanks to all your feedback.
>=20
> On Wed, Mar 12, 2025 at 4:46=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Tue, Mar 11, 2025 at 02:59:53PM -0500, Rob Herring wrote:
> > > On Tue, Mar 11, 2025 at 01:19:03PM +0800, Nick Hu wrote:
> > > > Add compatible string and property for the SiFive CLINT v2.
> > > >
> > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> > > > ---
> > > >  .../bindings/timer/sifive,clint.yaml          | 19 +++++++++++++++=
++++
> > > >  1 file changed, 19 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.y=
aml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > > index 76d83aea4e2b..93d74c504b5f 100644
> > > > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > > @@ -36,6 +36,9 @@ properties:
> > > >                - starfive,jh7110-clint   # StarFive JH7110
> > > >                - starfive,jh8100-clint   # StarFive JH8100
> > > >            - const: sifive,clint0        # SiFive CLINT v0 IP block
> > >
> > > Notice that we don't allow clint0 by itself. We shouldn't start now.
> > >
> > > > +      - items:
> > >
> > > If you don't have a specific one yet, then add '- {}' for the first
> > > entry.
> > >
> Do you suggest something like the following?
>      - items:
>           - {}
>           - const: sifive,clint2        # SiFive CLINT v2 IP block
>         description: SiFive CLINT v2 is the HRT that supports the Zicntr
>=20
> > > > +          - const: sifive,clint2        # SiFive CLINT v2 IP block
> > > > +        description: SiFive CLINT v2 is the HRT that supports the =
Zicntr
> > > >        - items:
> > > >            - enum:
> > > >                - allwinner,sun20i-d1-clint
> > > > @@ -62,6 +65,22 @@ properties:
> > > >      minItems: 1
> > > >      maxItems: 4095
> > > >
> > > > +  sifive,fine-ctr-bits:
> > > > +    description: The width in bits of the fine counter.
> > >
> > > maximum: 15
> > >
> > > Unless you know of a different maximum in which case why aren't you
> > > documenting that too?
> >
> You are right. It's my bad. The maximum width should always be 15 in
> sifive,clint2.
> I should update to:
>  sifive,fine-ctr-bits:
>     maximum: 15
>     description: The width in bits of the fine counter.
>=20
> if:
>   not:
>     properties:
>       compatible:
>         contains:
>           const: sifive,clint2
> then:
>   properties:
>     sifive,fine-ctr-bits: false

I think this should be inverted, to

if: properties: compatible: contains: const: sifive,clint2
then: required: - sifive,fine-counter-bits
else: sifive,fine-counter-bits: false

since the property has no default.

>=20
> > I'm curious why this is not something that can be discerned from the
> > compatible. It's max 15, but are there actually versions of this with a
> > less-than-15-bit width?
> >
> The width may be various on different platforms so it is possible to
> have a less-than-15-bit width.
>=20
> > >
> > > > +
> > > > +if:
> > > > +  properties:
> > > > +    compatible:
> > > > +      contains:
> > > > +        const: sifive,clint2
> > > > +then:
> > > > +  properties:
> > > > +    sifive,fine-ctr-bits:
> > > > +      maximum: 15
> > > > +else:
> > > > +  properties:
> > > > +    sifive,fine-ctr-bits: false
> > > > +
> > > >  additionalProperties: false
> > > >
> > > >  required:
> > > > --
> > > > 2.17.1
> > > >
>=20
> Best Regards,
> Nick

--IrKm9n+XjpE4JIEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9NdXAAKCRB4tDGHoIJi
0g0uAPsEXt5V5cLEAAhBAZ5l7d6lhyvuUe5XiNi2ELaP0v6OPgEAzVJEkH+aXiak
nA/2l4YbUtpVYVh1j3dDZcrVq4FM4wE=
=SkWm
-----END PGP SIGNATURE-----

--IrKm9n+XjpE4JIEJ--

