Return-Path: <linux-kernel+bounces-296169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9598B95A694
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C923D1C20D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD4C176FA5;
	Wed, 21 Aug 2024 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxLmgo2b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334813B297;
	Wed, 21 Aug 2024 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275742; cv=none; b=gchG5rlI2B2Kn0Tu7XLOv0V3czPfvHTFT8FqXFgjocg4XtHA96nqEgOg3WLICwgtWBFX2Txq73TmJJJfYFMEl02WegmCf5N+vlBy8VmbAiVSNWhWMKvflkXg6dDGnu6+Au7mq8khe04HRR6dX+jhQLVSJKOqs/E6GD4RTnoxKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275742; c=relaxed/simple;
	bh=xwtLdO+9ktMGuZdX5L6kQk2F65PMSUAnAVNlH9Yrj1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfWeJm8pfSy+0/6fbOS9bT/mYgYt9fLw3BPfIIjnnQEEsSmS8ZNeUXnB7Sjel37WWkS+PmUAZT7Z8t+rNvCmwYPFR0ftuQ8lzZV7YmJmksMWbpNwVTLt3YZzMnKIg7JjV1HdMY+3OxHvq6/RjGgMaS9HHlecq/J0K/PUbj8T0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxLmgo2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F244C4AF0E;
	Wed, 21 Aug 2024 21:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724275742;
	bh=xwtLdO+9ktMGuZdX5L6kQk2F65PMSUAnAVNlH9Yrj1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxLmgo2bIzm6idMoy0ugAby9PScIkxhyj4rOxXv6SDq/K4EZ/ZdbtDXV318P0kbrH
	 F5lVgKTx31+98B6wmNHwt6SsVSBrqICsNFv25Bd1RR8dGhIj+SZlbMHICgEAlUJhQx
	 GKNQxD7peoQvKXl0zstMxgt6QPXPmhKyoMd8U/oFzwfb/g+D8mt4iXaJlTgGkNwLEE
	 +ZzzZ9h+d2os376V68LB7GWY+kSCt2bUaMdkzAvrsmje6PTL8LjKMlq6D3vvmcj5wP
	 U5SB/YFq0/uALUVDk2W+TE0Wjz7e2JMJVkSiKsZTUen0LY1dt95spWtAFmS+qRvxYi
	 Mb5HMnCTxA+uA==
Date: Wed, 21 Aug 2024 22:28:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Yao <markyao0591@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
Message-ID: <20240821-stretch-scam-09d7adc08a4c@spud>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <20240819-b4-rk3588-bridge-upstream-v4-3-6417c72a2749@collabora.com>
 <20240819-bobbing-purplish-99e48baa2304@spud>
 <ec84bc0b-c4c2-4735-9f34-52bc3a852aaf@collabora.com>
 <20240820-tropics-hunchback-6fdcd0b37f91@spud>
 <038073d0-d4b9-4938-9a51-ea2aeb4530f6@collabora.com>
 <20240821-evoke-mop-fb09ceef3597@spud>
 <5813cea2-4890-4fa9-8826-19be5bf3e161@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/pKw8PjfkiYpJUBC"
Content-Disposition: inline
In-Reply-To: <5813cea2-4890-4fa9-8826-19be5bf3e161@collabora.com>


--/pKw8PjfkiYpJUBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Cristian, Heiko,

On Wed, Aug 21, 2024 at 11:38:01PM +0300, Cristian Ciocaltea wrote:
> On 8/21/24 6:07 PM, Conor Dooley wrote:
> > On Tue, Aug 20, 2024 at 11:12:45PM +0300, Cristian Ciocaltea wrote:
> >> On 8/20/24 7:14 PM, Conor Dooley wrote:
> >>> On Tue, Aug 20, 2024 at 03:37:44PM +0300, Cristian Ciocaltea wrote:
> >>>> On 8/19/24 7:53 PM, Conor Dooley wrote:
> >>>>> On Mon, Aug 19, 2024 at 01:29:30AM +0300, Cristian Ciocaltea wrote:
> >>>>>> +  rockchip,grf:
> >>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>>>> +    description:
> >>>>>> +      Most HDMI QP related data is accessed through SYS GRF regs.
> >>>>>> +
> >>>>>> +  rockchip,vo1-grf:
> >>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>>>> +    description:
> >>>>>> +      Additional HDMI QP related data is accessed through VO1 GRF=
 regs.
> >>>>>
> >>>>> Why are these required? What prevents you looking up the syscons by
> >>>>> compatible?
> >>>>
> >>>> That is for getting the proper instance:
> >>>
> >>> Ah, that makes sense. I am, however, curious why these have the same
> >>> compatible when they have different sized regions allocated to them.
> >>
> >> Good question, didn't notice.  I've just checked the TRM and, in both
> >> cases, the maximum register offset is within the 0x100 range.  Presuma=
bly
> >> this is nothing but an inconsistency, as the syscons have been added in
> >> separate commits.
> >=20
> > Is that TRM publicly available? I do find it curious that devices sound
> > like they have different contents have the same compatible. In my view,
> > that is incorrect and they should have unique compatibles if the
> > contents (and therefore the programming model) differs.
>=20
> Don't know if there's an official location to get it from, but a quick
> search on internet shows a few repos providing them, e.g. [1].
>=20
> Comparing "6.14 VO0_GRF Register Description" at pg. 777 with "6.15 VO1_G=
RF
> Register Description" at pg. 786 (from Part1) reveals the layout is mostly
> similar, with a few variations though.

Page references and everything, thank you very much. I don't think those
two GRFs should have the same compatibles, they're, as you say, similar
but not identical. Seems like a bug to me!

Heiko, what do you think?

> [1] https://github.com/FanX-Tek/rk3588-TRM-and-Datasheet
>=20
> >>
> >>>> 	vo0_grf: syscon@fd5a6000 {
> >>>> 		compatible =3D "rockchip,rk3588-vo-grf", "syscon";
> >>>> 		reg =3D <0x0 0xfd5a6000 0x0 0x2000>;
> >>>> 		clocks =3D <&cru PCLK_VO0GRF>;
> >>>> 	};
> >>>>
> >>>> 	vo1_grf: syscon@fd5a8000 {
> >>>> 		compatible =3D "rockchip,rk3588-vo-grf", "syscon";
> >>>> 		reg =3D <0x0 0xfd5a8000 0x0 0x100>;
> >>>> 		clocks =3D <&cru PCLK_VO1GRF>;
> >>>> 	};
> >

--/pKw8PjfkiYpJUBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsZcFgAKCRB4tDGHoIJi
0pWIAP4jFPCzxz/BuUKmSHkK/1MnQP5/ja+ucOIadjCDNiPuRAD9GF1a9MOn5TEw
SHbcMsCq/ZXQHJOY+b0OzSipkqvSPgg=
=BBdG
-----END PGP SIGNATURE-----

--/pKw8PjfkiYpJUBC--

