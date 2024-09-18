Return-Path: <linux-kernel+bounces-332369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA09A97B8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512161F2178A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35BA175D48;
	Wed, 18 Sep 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKz6pjT8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E81174ECD;
	Wed, 18 Sep 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646690; cv=none; b=i9CMJ44zjbybRyOE/+GrMTfxrFiP917LszB954H8fPEdJSB7XErDPWzFzeGd07KgKRKojTU1HMQWOrBFHO5iz53TwvXyVvI/TElVm8nRAh9dlSinIXzZw/KC6DzWFogHwHahdZAtH1NRcjDDrgQbd5xCD8/eA8TdtZX4GzSPJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646690; c=relaxed/simple;
	bh=CQpaFzysb4OVegJAA2SGpwkBi1FpniqWiux2/BwVPz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx7n2v2sNQ+h4yd9Kw0xdnLzN9yO1uldKaMtSmUGxVnXPj+TF4FVhO8EEahRoODcB7YenatjdOGN2wg9LuOqXxzJLxW0H61lIG4d5VvCub7HyQGMzvHTzgFoJMXfkoZopQcVgHWBRQqlfZSDtyNwdA2oVo5AXI+7Q/p+slOzjIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKz6pjT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40932C4CEC3;
	Wed, 18 Sep 2024 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726646689;
	bh=CQpaFzysb4OVegJAA2SGpwkBi1FpniqWiux2/BwVPz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKz6pjT8tQ7gXW4b12FNAM0Ow63owPjNv97x/c0DbBnxpIX72WC0RV7AeZd16B8YD
	 yaSYyZQAxwVQtg77ATahJhS87G2rTF5nKYhEr/9Spb0F72Lci81jAntvdo8AES88fa
	 JR30B13QFSArCwPjNCbZFJWOFa7thHqJgWWtaCsz4jfDoGLoVxor547dfauqpnEXtT
	 Z4UIT9udfbB4gBP6fJ0jfgzt+pRdLcQRsfXee92bUdCBGzJMN0nu+HLQOsyjyuU/Um
	 fC40NpYA5HvvAMjqxlYYkiaC1yLhBvBg5gkc98f4SUnQG18yvKxRR2WoFwkN/H1Cec
	 EqZ/UUaigKcKw==
Date: Wed, 18 Sep 2024 09:04:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Manikandan.M@microchip.com
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux@armlinux.org.uk,
	Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, arnd@arndb.de, geert+renesas@glider.be,
	mpe@ellerman.id.au, rdunlap@infradead.org, Dharma.B@microchip.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: display: bridge: add
 sam9x75-mipi-dsi binding
Message-ID: <20240918-concert-liability-fab83f411cfa@squawk>
References: <20240814105256.177319-1-manikandan.m@microchip.com>
 <20240814105256.177319-2-manikandan.m@microchip.com>
 <20240814-anaerobic-unpainted-532b8b117b79@spud>
 <5cb63b40-9710-4a6d-984d-1be1394dcb63@microchip.com>
 <20240917-verdict-nativity-3b84cc3457cc@squawk>
 <d343d34e-f810-4375-882e-d74f104ce215@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wyxYEbU3SQR8ONJ3"
Content-Disposition: inline
In-Reply-To: <d343d34e-f810-4375-882e-d74f104ce215@microchip.com>


--wyxYEbU3SQR8ONJ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 03:00:45AM +0000, Manikandan.M@microchip.com wrote:
> On 17/09/24 6:08 pm, Conor Dooley wrote:
> > On Tue, Sep 17, 2024 at 03:16:53AM +0000,Manikandan.M@microchip.com  wr=
ote:
> >> Hi Conor,
> >>
> >> On 14/08/24 7:29 pm, Conor Dooley wrote:
> >>> On Wed, Aug 14, 2024 at 04:22:53PM +0530, Manikandan Muralidharan wro=
te:

> >>>> +  microchip,sfr:
> >>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>> +    description:
> >>>> +      phandle to Special Function Register (SFR) node.To enable the=
 DSI/CSI
> >>>> +      selection bit in SFR's ISS Configuration Register.
> >>> I'm curious - why is this phandle required? How many SFR nodes are th=
ere
> >>> on the platform?
> >> This phandle is to map the memory region of SFR node and configure the
> >> DSI bit in the SFR's ISS configuration register.
> >> currently there is only one SFR node in this platform.
> > What does "currently" mean? The platform either has one or it does not,
> > currently makes it sound like it has more than one but the dts only has
> > one.
> Apologies, I would like to clarify the statement that this platform only=
=20
> has one 32-bit special function register implemented.

In that case, you dont need a phandle at all, just look the sfr up by
its compatible.

--wyxYEbU3SQR8ONJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuqJnwAKCRB4tDGHoIJi
0ix4AQChrfrTy2bNfbi7J9Cmvc0AkOrqd4lC8oOBGlzlXXvbeAD1HqbkyJyyxQph
0xKmWJd1OCZWfCk7wGtjmG795nIHAA==
=/n4k
-----END PGP SIGNATURE-----

--wyxYEbU3SQR8ONJ3--

