Return-Path: <linux-kernel+bounces-568735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B71A699E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D41E8A6306
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD81420D500;
	Wed, 19 Mar 2025 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxFh5poV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9AD819
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414426; cv=none; b=jcI9cQiEuVfMhdGZ/KDTlBr1Q8zXYampLoMFw/PGHNHffLlcsCloTrjc5sGYNhogb88gZMiT67jlyR65W3Z6psW23iLLvAaoydBAyTJ6/ul2/+/kifvsywsOHMu+4RNG0l2hqakO285PtKqyIgCRj/LUc0EMYc+2ubieRLPAgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414426; c=relaxed/simple;
	bh=kvoI88amUV+xRQVe583X4SdWMaeA6WhkypywOswnqf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWjMV294QInjRFc+A4aqxD7h9OKH+mTqacVKzITCAoSpHJR/xr4fWBIRd55xH5/M4ihdJX0I0XmIWZUYfoFmCKgIG2lAvf94/5vBSHvh6jqyP3N+7WwfjQWf0I/5mksGNjGXtwK9ooP1iUkE9+zpnSiAf9yL0SwnFGL790NaQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxFh5poV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A385C4CEE4;
	Wed, 19 Mar 2025 20:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742414425;
	bh=kvoI88amUV+xRQVe583X4SdWMaeA6WhkypywOswnqf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxFh5poViDzonov3bqtwSZczfyVmPZc4ZtVjBkjdMg2kWZ2jhP/7DiDr9I74fsIqL
	 2vGOFc/yiYEP1vSib4nL/ZsSObNw6nnzlArcjwL+oavUbM4DDibdienY7IbY+MiKed
	 EP2HA9zalA5zNExD52ZqdrudbRRf9zSPlZxjYOWW/SHHnqhkjQBu3/gfJTH+cIsYF1
	 IJh2sZo6SM3UCUS+qvh5gyhBb5MXTpFqXi/kFbO4iQOlC5I4w8hL/Moq+LUNYpOhUC
	 EcQMMvjtic7T2IxiilyYJSXtBeagiSSxbuNRXDFZvHoS9qm9q/9MrmFl2Z3CKAAHTq
	 /jkKzOmFBoosg==
Date: Wed, 19 Mar 2025 20:00:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Sunny Shen =?utf-8?B?KOayiOWnjeWnjSk=?= <Sunny.Shen@mediatek.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	Nancy Lin =?utf-8?B?KOael+aso+ieoik=?= <Nancy.Lin@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>,
	"fshao@chromium.org" <fshao@chromium.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	Singo Chang =?utf-8?B?KOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	Paul-pl Chen =?utf-8?B?KOmZs+afj+mclik=?= <Paul-pl.Chen@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"treapking@chromium.org" <treapking@chromium.org>
Subject: Re: [PATCH 1/5] dt-bindings: display: mediatek: mdp-rsz: Add rules
 for MT8196
Message-ID: <20250319-footnote-trusting-230e509bed07@spud>
References: <20250211025317.399534-1-sunny.shen@mediatek.com>
 <20250211025317.399534-2-sunny.shen@mediatek.com>
 <20250211-feed-shed-4b32f146cc54@spud>
 <029f9fd7ab898769a7ae627b160e1dce446ccc9e.camel@mediatek.com>
 <20250224-dreamland-tactile-bdb58daf6060@spud>
 <76a6fc25a09dfddb55fdaf0a9d7dcf9a6129b00f.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YDfFiUDQR01e6m8O"
Content-Disposition: inline
In-Reply-To: <76a6fc25a09dfddb55fdaf0a9d7dcf9a6129b00f.camel@mediatek.com>


--YDfFiUDQR01e6m8O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 03:14:07AM +0000, Sunny Shen (=E6=B2=88=E5=A7=8D=E5=
=A7=8D) wrote:
> On Mon, 2025-02-24 at 19:01 +0000, Conor Dooley wrote:
> > On Sun, Feb 23, 2025 at 05:49:45PM +0000, Sunny Shen (=E6=B2=88=E5=A7=
=8D=E5=A7=8D) wrote:
> > > On Tue, 2025-02-11 at 17:54 +0000, Conor Dooley wrote:
> > > > On Tue, Feb 11, 2025 at 10:52:50AM +0800, Sunny Shen wrote:
> > > > > Add MDP-RSZ hardware description for MediaTek MT8196 SoC
> >=20
> > > > > +examples:
> > > > > +=C2=A0 - |
> > > > > +=C2=A0=C2=A0=C2=A0 soc {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <2=
>;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <2>;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disp_mdp_rsz0: disp-m=
dp-rsz0@321a0000 {
> > > >=20
> > > > And "disp-mdp-rsz0" isn't anything close to a generic node name.
> > >=20
> > > Will modify "disp-mdp-rsz0@321a0000" to "mdp-rsz@321a0000"
> >=20
> > I don't think that's an improvement. Hint: full words would be a good
> > place to start
>=20
> =C2=A0
> Hi Conor,
>=20
> About full words,=C2=A0
> Do you mean words like this?=C2=A0
> multimedia-display-path-resizer?
> or mdp-resizer?

These are both improvements on what you've got right now.

> We found that "mdp-rsz" this kind of word is used at
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/mediate=
k/mt8183.dtsi
>=20
> I'm not sure what will be better.
> Can you provide more detailed suggestion about this naming?

--YDfFiUDQR01e6m8O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9siUwAKCRB4tDGHoIJi
0qM6AP9QHiOJ1JZ8DbtI6sWT9DS41P7u5He+sMBB04jH28AtPgD9E9HooK6Of1XJ
+RkppxwWFhpzQPVFfQGxAiZm0J9taQo=
=bzKn
-----END PGP SIGNATURE-----

--YDfFiUDQR01e6m8O--

