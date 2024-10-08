Return-Path: <linux-kernel+bounces-355590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9405995472
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DF91C20FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82211E0DF5;
	Tue,  8 Oct 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCJ0G0KQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1EC1E0DBD;
	Tue,  8 Oct 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405079; cv=none; b=VweIeCKo9oSGhO3wQ/NP1Y9X9vuNCPWXxu3AT1qkMhFb4mfN99AfWoYuWuW+Fh3WLoiswg9eLzKs4x53jWHC+JCcn7uubiw+lyEhDqX1jLemE0HRirXhuuCVLF9wG9Ce2mrs5Fk3nA4hXEBSah6fiLA8Z/RHkDBxPeE3wdB8o/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405079; c=relaxed/simple;
	bh=0lgV2rFoiw5wtsRBRpfDph44UOojRfjp31BzeyWcZYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDtuArRSyK32LW9eWkZWaHbNcjeqHJomKPn4dQho6OlClH4cvEG3hQH9gRvzr7t0zkb5licsjTxz7TgZ7tsdirwK0cqQdMYJjD6PsCIy6Acyms6V3ZZoIvW4ho7Lbh1JaRvIRWHKbK1rN3ivGUWVX5sQ4a3KWVOzvsRoT1W5rfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCJ0G0KQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDD2C4CEC7;
	Tue,  8 Oct 2024 16:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728405078;
	bh=0lgV2rFoiw5wtsRBRpfDph44UOojRfjp31BzeyWcZYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCJ0G0KQB3IkegGfi7xpcFnytubZPjBoE9f+MGXwi81fbYaacAABX1ePDBohhRTUI
	 2owuVDaqFcWK/DcJAqQQVlqMCfMvUCAZmbzaoDGpn6Q4uSg19YsI23o/PMcP4F6xYk
	 pKDmaT1Wt3/gJDY2UjIXBtu8Ek2HKwamzbfyYq5moxFEh+/ta+TsNFPmtWabP4PgCQ
	 54ItjmfveVxPymysSocAKJ02/NMv+cTF+tuHAlHqdvI0wVGJeL6Lp5Bx90UAQXZPRN
	 lNH/E77GhvHD+ep4gJMlH1gfJOp6dnTNWlfOnw9PgLOxOMiAhgx2UQeUNsx0G/j9/H
	 +cdsvIqCUoJcQ==
Date: Tue, 8 Oct 2024 17:31:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Jason-ch Chen <Jason-ch.Chen@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH] dt-bindings: phy: mediatek: tphy: add a property for
 power-domains
Message-ID: <20241008-disorder-slacking-d8196ceb68f7@spud>
References: <20240926101804.22471-1-macpaul.lin@mediatek.com>
 <20240926-treadmill-purr-b2e3279a14a4@spud>
 <3a970560-2458-f5f3-87c5-925079fa12a4@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="63wFwyn02Gwtymi/"
Content-Disposition: inline
In-Reply-To: <3a970560-2458-f5f3-87c5-925079fa12a4@mediatek.com>


--63wFwyn02Gwtymi/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 12:03:37PM +0800, Macpaul Lin wrote:
>=20
>=20
> On 9/27/24 00:25, Conor Dooley wrote:
> > On Thu, Sep 26, 2024 at 06:18:04PM +0800, Macpaul Lin wrote:
> > > Some platforms requires a dependency for power-domains.
> >=20
> > Some, so not all? Why isn't this restricted on a per compatible basis?
>=20
> After discussion with Chunfeng and double check tphy design in detail.
> Chunfeng commented that tphy dose not need to add mtcmos.
> It is not necessary to add it, if the power of the phy is turned off,
> it will affect other functions.
>=20
> From the current USB hardware design perspective, even if mtcmos
> is added to the phy, it is always on.

Firstly, I have no idea what "mtcmos" means, sorry. I am a dt-bindings
guy, not someone familiar with mediatek hardware.
Secondly, it sounds like this /does/ have a power domain, so it should
be in the binding. That it is turned on by something else and must
remain on doesn't mean it shouldn't be documented here. What if those
things try to turn it off while the tphy is using it?

>=20
> > > So we add property 'power-domains' and set 'maxItems: 1' in the
> > > DT Schema.
> > >=20
> > > Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> > > ---
> > >   Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml=
 b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > > index 423b7c4e62f2..c77fe43c224a 100644
> > > --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> > > @@ -125,6 +125,9 @@ properties:
> > >       $ref: /schemas/types.yaml#/definitions/uint32
> > >       default: 28
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > >   # Required child node:
> > >   patternProperties:
> > >     "^(usb|pcie|sata)-phy@[0-9a-f]+$":
> > > --=20
> > > 2.45.2
> > >=20
>=20
> Please drop this patch and I'll send a new fix to mt8195.dtsi.
>=20
> Thanks
> Macpaul Lin

--63wFwyn02Gwtymi/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwVeUAAKCRB4tDGHoIJi
0qBJAP942MK2haivS9lUOXeS3zszXJHYx8a0MTJissHiNv9Y6AEAlULCD/bffod/
Ajhj7718HDTdpLU80QNMjPu2uFTR0Qg=
=MNh6
-----END PGP SIGNATURE-----

--63wFwyn02Gwtymi/--

