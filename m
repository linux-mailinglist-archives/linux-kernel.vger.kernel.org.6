Return-Path: <linux-kernel+bounces-448047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9001E9F3A61
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98557A296E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF82320CCE5;
	Mon, 16 Dec 2024 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4HqgMKa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D402C2FD;
	Mon, 16 Dec 2024 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379165; cv=none; b=bXh8zpQrowf2cwjyfVjdyZaiFDJozIAIlA0fZPxiM329LFAM+CcLR6xpEwij7Q5FGqKx9uDL9l8avLWlIJNq6hhnErx4TIeckNNbojFmIQOpinzFvSjO8I3j93BDn6/CmDzzFIHpDDVnaEVUobmei43nDr5/fQ+sTiuMkLYPMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379165; c=relaxed/simple;
	bh=9pg4FXAuFe/CPveJLo1jazZb+qVovMGyDclZS6yjorc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMUDeQYDvGHkVQ9YTAKh/AycSymag3Akg11AnP2kpnDTa9DzYFDg2CTbmb2F6ivx7ZksOH6aLM7Xb8yVN7VjLFQ+y3Yhr00Zw0GAi9Mgb7pkA/iK6NIBzkxoHQj/BY7OFq6QVzNtb9B03cKD4ak+TeZXEE+eG+5Kmv+o/1ArHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4HqgMKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610BAC4CED0;
	Mon, 16 Dec 2024 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734379165;
	bh=9pg4FXAuFe/CPveJLo1jazZb+qVovMGyDclZS6yjorc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4HqgMKaDL2s1piTwpNzo//zvQB0yLx8SqNF5Knx/Qzmnzk1oSxA4oejBzeO8aspj
	 z+Z8EE61K2BFCQWoPh2pKtn5ex2TCasTLFSU1GCTekiuIIi3CVpycVliAZKgDTq0gg
	 p95h/C8CoxyIvuMlbCKzjWz8vlADfBz/DQf/TC6SNuFcy5iELXRYghwMgooSaV2r8W
	 oEodblxCK9ZeQ1w7muO6AJzbxYVMvukbJmhP0VV8LWfaP15EF2rKzzTyRGWCZiCg+4
	 +jqKMG+cjQ1fk3e8JTrIYdi16VvzZ98OGuzrs1yKxF+XO8qS/blGwUWRxwAXHgy2Bc
	 /R1OD10pcmJQg==
Date: Mon, 16 Dec 2024 19:59:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frieder Schrempf <frieder@fris.de>,
	linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>, Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 01/11] Revert "regulator: pca9450: Add sd-vsel GPIO"
Message-ID: <20241216-unchain-respect-1c344203a140@spud>
References: <20241127164337.613915-1-frieder@fris.de>
 <20241127164337.613915-2-frieder@fris.de>
 <20241128-candle-guzzler-b7ea4e5ce643@spud>
 <b5456480-a68f-4e71-831b-f145453e2646@kontron.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Wi4ZHhW6IIDtlCK"
Content-Disposition: inline
In-Reply-To: <b5456480-a68f-4e71-831b-f145453e2646@kontron.de>


--6Wi4ZHhW6IIDtlCK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 04:59:06PM +0100, Frieder Schrempf wrote:
> On 28.11.24 6:37 PM, Conor Dooley wrote:
> > On Wed, Nov 27, 2024 at 05:42:17PM +0100, Frieder Schrempf wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> This reverts commit 27866e3e8a7e93494f8374f48061aa73ee46ceb2.
> >>
> >> It turned out that this feature was implemented based on
> >> the wrong assumption that the SD_VSEL signal needs to be
> >> controlled as GPIO in any case.
> >>
> >> In fact the straight-forward approach is to mux the signal
> >> as USDHC_VSELECT and let the USDHC controller do the job.
> >>
> >> Most users never even used this property and the few who
> >> did have been or are getting migrated to the alternative
> >> approach.
> >>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >> ---
> >> Changes for v2:
> >> * split revert into separate patch
> >> ---
> >>  .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml | 5 -----
> >>  1 file changed, 5 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-r=
egulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-reg=
ulator.yaml
> >> index f8057bba747a5..79fc0baf5fa2f 100644
> >> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulato=
r.yaml
> >> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulato=
r.yaml
> >> @@ -77,11 +77,6 @@ properties:
> >> =20
> >>      additionalProperties: false
> >> =20
> >> -  sd-vsel-gpios:
> >> -    description: GPIO that is used to switch LDO5 between being confi=
gured by
> >> -      LDO5CTRL_L or LDO5CTRL_H register. Use this if the SD_VSEL sign=
al is
> >> -      connected to a host GPIO.
> >=20
> > Your driver side of this, that I wasn't sent and cba downloading an
> > mbox of is not backwards compatible. The code has been there for a few
> > years, are you sure that there are no out of tree users or other OSes
> > that use the property?
>=20
> Yes, this is not backwards compatible. I introduced the original meaning
> for the sd-vsel-gpios property based on some misunderstanding of how the
> hardware actually works. Therefore I'm quite sure that except for the
> cases where someone copied my erroneous implementation into their
> devicetree, nobody has really any reason to actually use this.
>=20
> In-tree all users have been removed (one fix still included in this
> series). Of course we can't be fully sure that there isn't someone out
> there having non-standard hardware (SD_VSEL not connected to
> USDHC_VSELECT but to GPIO only) and using the old sd-vsel-gpios, but the
> probability is very, very low.
>=20
> IMHO taking the small risk here is better than keeping the misleading
> implementation which will likely cause confusion and failures in the
> future. But of course that's not up to me to decide.

Given that the !property case retains the behaviour from before, only
those with the property are affected - which means if it does end up
being problematic then it can be rectified at that point in time.

> > tbh, I think all 3 of your dt-binding patches should be squashed rather
> > than drip-feeding the conversion. It makes more sense as a single
> > change, rather than splitting the rationales across 3 patches.
>=20
> Ok, if you like this better in one change I can squash these for the
> next version.

Sounds good, sorry again for the delay getting back to you.

--6Wi4ZHhW6IIDtlCK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2CGmAAKCRB4tDGHoIJi
0pO5AQDDH9YtmHz8YalRyuddqOb/sFuBFnCARsqnUFpN8oFinQD/Q3AD0LQOpMpo
yJ9zX1H8uFekOTFcji5o0ncP7pwLtQc=
=VUPv
-----END PGP SIGNATURE-----

--6Wi4ZHhW6IIDtlCK--

