Return-Path: <linux-kernel+bounces-186439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1EA8CC42F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D96A1C21E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC337D08F;
	Wed, 22 May 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJCaiQjL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF641171C;
	Wed, 22 May 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392151; cv=none; b=R/XJsjpfSIb+DhbURxLVuLz2eYUSZZklCr/lc893q5f4DptHAtqboc5XDQ5wZxM6EhfeWrqpsECqxxq2z16UmaeaNdlTn3Q7adLLhEWoKjFgy0HCjrzKQemt9biNvID+lXhMFnfPpZeKcNtuY3DVassabCNNECQBmN5WUFF/irM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392151; c=relaxed/simple;
	bh=Qd+NDxGOZ2bJf9sIDqREHnfFavqyfD7ddBDGDAxcjbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF8CuFLubuTp1/qrxU8kZoJrGh1Boqzc+2efiqb1f3z4Co09Fzlp15NDZz9luCREN4DgK84ZJ1qVJWHqZuUHQhiGz1gruWa1znCOM8e2dOsvqEQDI1L7W10KpLfABpybUOVnsf/f5NJ02QI5x9r4VowpepH81vpIMTo9kgHu+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJCaiQjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DE9C2BD11;
	Wed, 22 May 2024 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716392151;
	bh=Qd+NDxGOZ2bJf9sIDqREHnfFavqyfD7ddBDGDAxcjbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJCaiQjLOSkJeC8737kXYulTF1E8kx+viQmK6R8A79ohnS0Ia2oKO7niWQO25ldGP
	 YcrmWJcjzgvYYamWATddny5NL8foEzHP71g5oKW+oZV2cvD+IbmF/V50RAHLsngVuW
	 8T6ALDPEmvK1nPQML2+v2HFyWk40+BCuyzs1d7AFmd7wuIRr9poXzP7qvb3kGF5LA7
	 k3x18K6WyK0m64ECtrMbp0YEnAQ1NR5l1clMI2yrI91yteJvWEX4i9zH6bLxnWIz8d
	 6yzROBcTARIC05vmq7n0pwnrFEtY8Rk4mGhd5bjzNdXdFWL2JL9AbLdWWc5sMj7OYr
	 0Q+7VSasTFxdw==
Date: Wed, 22 May 2024 16:35:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: display: vop2: Add VP clock resets
Message-ID: <20240522-slimness-dullness-bb807f053c89@spud>
References: <20240514152328.21415-1-detlev.casanova@collabora.com>
 <13628421.uLZWGnKmhe@arisu>
 <20240521-silver-exciting-bb3725dc495d@spud>
 <3334403.5fSG56mABF@arisu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O1xKPYmQ4qbvZFbX"
Content-Disposition: inline
In-Reply-To: <3334403.5fSG56mABF@arisu>


--O1xKPYmQ4qbvZFbX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:31:36AM -0400, Detlev Casanova wrote:
> On Tuesday, May 21, 2024 2:31:51 P.M. EDT Conor Dooley wrote:
> > On Tue, May 21, 2024 at 01:15:46PM -0400, Detlev Casanova wrote:
> > > On Wednesday, May 15, 2024 12:33:22 P.M. EDT Heiko St=FCbner wrote:
> > > > Am Mittwoch, 15. Mai 2024, 18:19:29 CEST schrieb Conor Dooley:
> > > > > On Tue, May 14, 2024 at 11:19:47AM -0400, Detlev Casanova wrote:
> > > > > > Add the documentation for VOP2 video ports reset clocks.
> > > > > > One reset can be set per video port.
> > > > > >=20
> > > > > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > > >=20
> > > > > Are these resets valid for all VOPs or just the one on 3588?
> > > >=20
> > > > Not in that form.
> > > > I.e. rk3588 has 4 video-ports (0-3), while rk3568 has 3 (0-2).
> > > >=20
> > > > So the binding should take into account that rk3568 also has the
> > > > SRST_VOP0 ... SRST_VOP2.
> > >=20
> > > That is what is set in the example and the reason why I set minItems =
to 3
> > > in the main bindings.
> > > Then, the rk3588 specific part sets it to 4.
> > >=20
> > > Isn't that enough ?
> >=20
> > Not quite - you need to restrict maxItems to 3 for the other devices if
> > the clocks are not valid. What you've got says that 4 clocks are
> > possible but not needed on !rk3588.
> >=20
> I don't understand what "properties: resets: minItems: 3" means then. I=
=20
> thought it means that all devices should have at least 3 resets. Then the=
=20
> allOf below specifies the special case of rk3588 which has a minimum of 4=
=20
> resets.

The change you made to the bindings allows someone to define either 3
(because of minItems 3) or 4 (because there are 4 items in the list) resets
for the rk3568.

> Do I need to add=20
>         resets:
>           minItems: 3
>         reset-names:
>           minItems: 3
> in the "else:" ?

No, you need to add maxItems: 3 to the else.

> So in that case, I can remove "properties: resets: minItems: 3" above ?
>=20
> Also, what do you mean "If the clocks are not valid" ?

s/clocks/resets/ ;)

--O1xKPYmQ4qbvZFbX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk4Q0AAKCRB4tDGHoIJi
0s0DAQDoOkPVLDr+HE00hhznKtcPPj+CcSSPyDVA/6sDIBivXQEAsVedCSlfxbXc
k7i+X+yRjsbEqstU9Tavi7c6NTEiuQI=
=aFFV
-----END PGP SIGNATURE-----

--O1xKPYmQ4qbvZFbX--

