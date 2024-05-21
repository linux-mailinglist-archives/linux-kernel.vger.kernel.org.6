Return-Path: <linux-kernel+bounces-185246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D68CB2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0475D1F226C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C07130A58;
	Tue, 21 May 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fGPJEWC6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1CD17758;
	Tue, 21 May 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311771; cv=none; b=Y1ir7FGQT9GDDq76sZjOzVOrTbH0zf7mGIngy+iZR+mD11G4GiJNJccQJ1/qwUbXKYImkHHBHzz6NewQ2haGf/GZz3kBPMonWZ+e4UKVsjjSMP07KXZsgTk/4xyAiIr0WkCC3/giUieoaLCmULlTgzxFFU3hRDjBAvub4ksGqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311771; c=relaxed/simple;
	bh=rd/1+9JNdQ/4d4EFXjf5NHg9TeVEP/YikPqrcWyBkmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTbQyUkF1tFll6KXYhoJNQqX34OXJhSTAtDDB749VGGg6+nLBVH4zBDac7EMweEzCdQzzwynF2SJpPmas26zPxBaASC9FCj+WEuciVLjyyWz8OB1HPkk7Uj2ul1iCeHJermabCGjsLVIQNKmcv3deI2xYgGaSkCHyD1Llvl7eQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fGPJEWC6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716311768;
	bh=rd/1+9JNdQ/4d4EFXjf5NHg9TeVEP/YikPqrcWyBkmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGPJEWC6H/LQ8fIQtmuSll6oJYcCRpHnF0BtiC/fBfC4kMzm1duBMBCbZIn09K7Dx
	 5T6anJwgNhagVeZanlGhLG1D7xBDs0ofcETveoJFa7HQO0+piRfL9N87Cw9rwXy9+B
	 5HwHa4Cvqmx5tA/LvNucSCDFufCy4U6KoscmC4fmdiX7rOSfwJNjFdZ9aQpajDXGEG
	 Ym4Mb7NMPUj09hcHVvc/Yj8KFm+IQzosXoYhOKv9/wQM7u87xnu9qPur2G0s3OQAlC
	 H7+QUuRx3vzvbCW30bQdVnVQ79y2Nnursu8e2c+qibS+Y/6q8xHhxUrOPJgaPWnEzF
	 MUn5IuvAm7TEA==
Received: from arisu.localnet (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CD52F378107C;
	Tue, 21 May 2024 17:16:04 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Conor Dooley <conor@kernel.org>,
 Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Chris Morgan <macromorgan@hotmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: display: vop2: Add VP clock resets
Date: Tue, 21 May 2024 13:15:46 -0400
Message-ID: <13628421.uLZWGnKmhe@arisu>
Organization: Collabora
In-Reply-To: <2182693.irdbgypaU6@diego>
References:
 <20240514152328.21415-1-detlev.casanova@collabora.com>
 <20240515-risk-exes-13db315da6bb@spud> <2182693.irdbgypaU6@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3048022.e9J7NaK4W3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3048022.e9J7NaK4W3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Tue, 21 May 2024 13:15:46 -0400
Message-ID: <13628421.uLZWGnKmhe@arisu>
Organization: Collabora
In-Reply-To: <2182693.irdbgypaU6@diego>
MIME-Version: 1.0

On Wednesday, May 15, 2024 12:33:22 P.M. EDT Heiko St=FCbner wrote:
> Am Mittwoch, 15. Mai 2024, 18:19:29 CEST schrieb Conor Dooley:
> > On Tue, May 14, 2024 at 11:19:47AM -0400, Detlev Casanova wrote:
> > > Add the documentation for VOP2 video ports reset clocks.
> > > One reset can be set per video port.
> > >=20
> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> >=20
> > Are these resets valid for all VOPs or just the one on 3588?
>=20
> Not in that form.
> I.e. rk3588 has 4 video-ports (0-3), while rk3568 has 3 (0-2).
>=20
> So the binding should take into account that rk3568 also has the
> SRST_VOP0 ... SRST_VOP2.

That is what is set in the example and the reason why I set minItems to 3 i=
n=20
the main bindings.
Then, the rk3588 specific part sets it to 4.

Isn't that enough ?

> Also, I guess we might not want to limit ourself to stuff we use?
> I.e. the new VOP-design is one block with multiple video-ports
>=20
> So for rk3568 I see
> #define SRST_A_VOP
> #define SRST_H_VOP
> #define SRST_VOP0
> #define SRST_VOP1
> #define SRST_VOP2
>=20
> similarly rk3588 has
>=20
> #define SRST_H_VOP
> #define SRST_A_VOP
> #define SRST_D_VOP0
> #define SRST_D_VOP1
> #define SRST_D_VOP2
> #define SRST_D_VOP3
>=20
> as generalized reset lines.

Argh, I added them at first then removed them as they are not used. Will ad=
d=20
them again then.

Detlev.

> > > ---
> > >=20
> > >  .../display/rockchip/rockchip-vop2.yaml       | 27 +++++++++++++++++=
++
> > >  1 file changed, 27 insertions(+)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.ya=
ml
> > > b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.ya=
ml
> > > index 2531726af306b..941fd059498d4 100644
> > > ---
> > > a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.ya=
ml
> > > +++
> > > b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.ya=
ml
> > >=20
> > > @@ -65,6 +65,22 @@ properties:
> > >        - const: dclk_vp3
> > >        - const: pclk_vop
> > >=20
> > > +  resets:
> > > +    minItems: 3
> > > +    items:
> > > +      - description: Pixel clock reset for video port 0.
> > > +      - description: Pixel clock reset for video port 1.
> > > +      - description: Pixel clock reset for video port 2.
> > > +      - description: Pixel clock reset for video port 3.
> > > +
> > > +  reset-names:
> > > +    minItems: 3
> > > +    items:
> > > +      - const: dclk_vp0
> > > +      - const: dclk_vp1
> > > +      - const: dclk_vp2
> > > +      - const: dclk_vp3
> > > +
> > >=20
> > >    rockchip,grf:
> > >      $ref: /schemas/types.yaml#/definitions/phandle
> > >=20
> > >      description:
> > > @@ -128,6 +144,11 @@ allOf:
> > >          clock-names:
> > >            minItems: 7
> > >=20
> > > +        resets:
> > > +          minItems: 4
> > > +        reset-names:
> > > +          minItems: 4
> > > +
> > >=20
> > >          ports:
> > >            required:
> > >              - port@0
> > >=20
> > > @@ -183,6 +204,12 @@ examples:
> > >                                "dclk_vp0",
> > >                                "dclk_vp1",
> > >                                "dclk_vp2";
> > >=20
> > > +                resets =3D <&cru SRST_VOP0>,
> > > +                         <&cru SRST_VOP1>,
> > > +                         <&cru SRST_VOP2>;
> > > +                reset-names =3D "dclk_vp0",
> > > +                              "dclk_vp1",
> > > +                              "dclk_vp2";
> > >=20
> > >                  power-domains =3D <&power RK3568_PD_VO>;
> > >                  iommus =3D <&vop_mmu>;
> > >                  vop_out: ports {


--nextPart3048022.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEonF9IvGrXNkDg+CX5EFKUk4x7bYFAmZM1sIACgkQ5EFKUk4x
7bb5lQf8CxeSuV+asxitEnkW/cVrTz51FbhHD8mO/z1OWW3fMUZXxilF1uNZ+zY4
UUD1+qE15cppWtyxK/qIGYtuytme46Mxlj6cLaI6fX3YikaZQE0y34jgv2OyOTQL
eiyKVPCNPk59jEFx1NSu/LqGQpQmemU3wWWL8DPmfesLsOzn866zYNJe7DgR3xfC
HkN9DbvGHLgMd4Bh7rH8lFoq9KZ0JbDbkzEkB1T9PpX+zYFGU6afiNaoitntsnXB
12TaLVomcfk/eejcNyxWJAqA2f7RQOgaI5qjz23kaBP9JZ2CJIWkudkSUG+b/BLe
dJupu8Sq2+ai63tx131WgNs3iMNz0Q==
=yXdu
-----END PGP SIGNATURE-----

--nextPart3048022.e9J7NaK4W3--




