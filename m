Return-Path: <linux-kernel+bounces-529866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C38A42BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D641D17A3D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BE42661BE;
	Mon, 24 Feb 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLp9aHZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25502266592;
	Mon, 24 Feb 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423048; cv=none; b=dch+WWMCnYNEl45w/dHHw/te/3PvKDlMcbEYZu6UBNi37nXuux82n5/JVXWb+rKsVQhU4g/Et2Gft29ArIiRyMYhhekhBfuMZF6ioNrN5ZLyT528hhwrhKRuWp1g51L7mHjn43Uc6a50V9DPcOsnftl3KDzM2Yyuq6YNU0GjJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423048; c=relaxed/simple;
	bh=BMUBPArP+Wl2MP2yf1DUU0DLgumvDFlAgy2cIovaSdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8mfmVz3luXHk3zkABynOf6bEZJcwfD6UA8cZFSfmPhe82Fkw9akdnXgGIIK/TbJMiYVZwAvOJA2fIJjslvlYJ5AhW2ovL2NaDeo15+s0lrWaH9m+7/FqbTry3gD4c1Ue/Uq2Bdvv6SjdEjsTjQkJtAwMQlkOG/ykJKfgTXcR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLp9aHZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F60AC4CED6;
	Mon, 24 Feb 2025 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423047;
	bh=BMUBPArP+Wl2MP2yf1DUU0DLgumvDFlAgy2cIovaSdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLp9aHZmrmhcv76Q/FrZjRvhZSxXxZzzZ+0Bdykswdbr2pqZL09LHdgkyME8/Y8vq
	 gMcnCIT0imkdUYcqdg7rTnRY7WSNfIYmd+TnCkQHWIE/QDIcvlN3asT6dpL3HFIViN
	 SOuXykIr77gK2H5pjdA5GE6UqiFatK53qLgx3owAi//JDOX+3nGVOqgyHHEvWC51Gg
	 WJwW38aqpIohQ7pKubT4bXDFchWcv+nZItVpCJKvcN4KYHdy3G+wakzOXCh7jHZnNX
	 FJwZVHzikteRv3ZPWTT0Vt0CXrLmYR3f4qv3W+h5m7IX6FGfivlJq+FWtsaif2hN2R
	 5BM66KAb5g5Iw==
Date: Mon, 24 Feb 2025 18:50:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Chunfeng Yun =?utf-8?B?KOS6keaYpeWzsCk=?= <Chunfeng.Yun@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [RESEND PATCH 1/2] dt-bindings: phy: mediatek,xsphy: add
 property to set disconnect threshold
Message-ID: <20250224-ranger-bobbed-68bc8b1f7386@spud>
References: <20250111141542.5007-1-chunfeng.yun@mediatek.com>
 <20250113-aerobics-tall-e570d8bbcf2c@spud>
 <e61b61574bd58c1bbc0648257fb4ab23ed582de0.camel@mediatek.com>
 <20250211-destiny-crablike-ab17a2814b7a@spud>
 <8eefe9902c884fe7a4a0d1f34c7b13c351b191e5.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9EAQEvPKoLp90x1U"
Content-Disposition: inline
In-Reply-To: <8eefe9902c884fe7a4a0d1f34c7b13c351b191e5.camel@mediatek.com>


--9EAQEvPKoLp90x1U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 08:30:00AM +0000, Chunfeng Yun (=E4=BA=91=E6=98=A5=
=E5=B3=B0) wrote:
> On Tue, 2025-02-11 at 18:30 +0000, Conor Dooley wrote:
> > On Sun, Feb 09, 2025 at 03:34:12AM +0000, Chunfeng Yun (=E4=BA=91=E6=98=
=A5=E5=B3=B0) wrote:
> > > On Mon, 2025-01-13 at 18:30 +0000, Conor Dooley wrote:
> > > > On Sat, Jan 11, 2025 at 10:15:41PM +0800, Chunfeng Yun wrote:
> > > > > Add a property to tune usb2 phy's disconnect threshold.
> > > > > And add a compatible for mt8196.
> > > > >=20
> > > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > > ---
> > > > > based on kernel 6.13-rc1
> > > > >=20
> > > > > this property is porting from t-phy driver, due to the u2 phy
> > > > > are
> > > > > similar.
> > > > > ---
> > > > >  Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml | 8
> > > > > ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> > > > > b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> > > > > index a9e3139fd421..2e012d5e1da1 100644
> > > > > --- a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> > > > > +++ b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> > > > > @@ -49,6 +49,7 @@ properties:
> > > > >        - enum:
> > > > >            - mediatek,mt3611-xsphy
> > > > >            - mediatek,mt3612-xsphy
> > > > > +          - mediatek,mt8196-xsphy
> > > > >        - const: mediatek,xsphy
> > > > > =20
> > > > >    reg:
> > > > > @@ -129,6 +130,13 @@ patternProperties:
> > > > >          minimum: 1
> > > > >          maximum: 7
> > > > > =20
> > > > > +      mediatek,discth:
> >=20
> > Just make it "disconnect-threshold" please.
> Ohhh, Ok, I'll modify it
> >=20
> > > > > +        description:
> > > > > +          The selection of disconnect threshold (U2 phy)
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        minimum: 1
> > > > > +        maximum: 15
> > > >=20
> > > > What unit is this? Unitless? How are the values determined?
> > >=20
> > > No unit, it's a level, may be treat it as an index to select
> > > different
> > > threshold.
> >=20
> > So this is a register value of some sort?=20
> Yes, the big value means higher threshold.
> > What is the actual threshold
> > measured in?
> I think that is mV in fact.

Can you put it in terms of uV then? The -microvolt suffix is standard in pr=
operty-units.yaml

--9EAQEvPKoLp90x1U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7y/ggAKCRB4tDGHoIJi
0o1SAP9lIYEztB/rF2WzpkSupF3l9zLozDGFDrs2V4XbkbJSsQD/c4lEOj5vxaHu
CK8IxbzXKINxqPhMdaZ+sbxCSAzccQA=
=ux7y
-----END PGP SIGNATURE-----

--9EAQEvPKoLp90x1U--

