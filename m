Return-Path: <linux-kernel+bounces-529893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD278A42C38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D8C1656F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231961D63C3;
	Mon, 24 Feb 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VORHk7Wq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84904A32
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423675; cv=none; b=YjXW6Y6AwyV5lvTyV3NNC/lUJh55zNBTRvZkyqY1TY9tQW2O/uNVa2uQ7RLZUlSPuP8YI+sNnD43/9Xm0/o5FCm9f2x6O831tZxYGeFG68EebrFqQI7EZwxw+ra534k4TB+S7p6FXf1bZfCGDeEa3qsiNyfVd8zbXz8oCChMblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423675; c=relaxed/simple;
	bh=tn7rMLzZMtYRYg7sNSmwLOytEKHtBv8WoWbob9xBWAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rgau+8xx28slQHvp10BGHfXq8Sk+uwkIZ98VZrHEKSg8WkGYmcpCs0U05xZU2SlGfBE4S81D447tzo2+Yfhs4PKUoWNQbm1q/wQaR2IFJWu34MaIPIClpBzUZUWdS2+TZiWJYnHAZNgzQNciQ2as+eaqBxTNMQotZ/qX7nYq6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VORHk7Wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB93C4CED6;
	Mon, 24 Feb 2025 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423674;
	bh=tn7rMLzZMtYRYg7sNSmwLOytEKHtBv8WoWbob9xBWAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VORHk7Wqt7FpXC7lv2ML0sepJs4sW6mDdIpTFKoV7wPrw0aR0r5iCxp8oLZLtoV0Y
	 540ePSSJ0hU/aKR0bzvf8f/bPJf5wVzaDukJaEB5j0TRYA+99jJRCQ4S1tclH1EsVk
	 395bkLFZhWxRREnrZo82NjoVBq+EYH9knwECJQhCvGguyL2NryDJ6Iztn0zVp1KOB1
	 okSrPhygsQc3THoomI+G3QF/b3gCLzBmk+ew1EnHT5kwVUAZduTsUgpLNmkPfeGf/b
	 GELUYLGonFzMCDJZMLWQ6selS3CyorJXMcDE/aAp0mj0qIeTCDm1eNFicwNARHIuja
	 BTIyXR32KjUFA==
Date: Mon, 24 Feb 2025 19:01:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Sunny Shen =?utf-8?B?KOayiOWnjeWnjSk=?= <Sunny.Shen@mediatek.com>
Cc: Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"robh@kernel.org" <robh@kernel.org>,
	Nancy Lin =?utf-8?B?KOael+aso+ieoik=?= <Nancy.Lin@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Paul-pl Chen =?utf-8?B?KOmZs+afj+mclik=?= <Paul-pl.Chen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"fshao@chromium.org" <fshao@chromium.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	Singo Chang =?utf-8?B?KOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"treapking@chromium.org" <treapking@chromium.org>
Subject: Re: [PATCH 1/5] dt-bindings: display: mediatek: mdp-rsz: Add rules
 for MT8196
Message-ID: <20250224-dreamland-tactile-bdb58daf6060@spud>
References: <20250211025317.399534-1-sunny.shen@mediatek.com>
 <20250211025317.399534-2-sunny.shen@mediatek.com>
 <20250211-feed-shed-4b32f146cc54@spud>
 <029f9fd7ab898769a7ae627b160e1dce446ccc9e.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kj7+TgqWhvqCa97w"
Content-Disposition: inline
In-Reply-To: <029f9fd7ab898769a7ae627b160e1dce446ccc9e.camel@mediatek.com>


--Kj7+TgqWhvqCa97w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 05:49:45PM +0000, Sunny Shen (=E6=B2=88=E5=A7=8D=E5=
=A7=8D) wrote:
> On Tue, 2025-02-11 at 17:54 +0000, Conor Dooley wrote:
> > On Tue, Feb 11, 2025 at 10:52:50AM +0800, Sunny Shen wrote:
> > > Add MDP-RSZ hardware description for MediaTek MT8196 SoC

> > > +examples:
> > > +=C2=A0 - |
> > > +=C2=A0=C2=A0=C2=A0 soc {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <2>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <2>;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disp_mdp_rsz0: disp-mdp-r=
sz0@321a0000 {
> >=20
> > And "disp-mdp-rsz0" isn't anything close to a generic node name.
>=20
> Will modify "disp-mdp-rsz0@321a0000" to "mdp-rsz@321a0000"

I don't think that's an improvement. Hint: full words would be a good
place to start

--Kj7+TgqWhvqCa97w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7zB9AAKCRB4tDGHoIJi
0movAP0T4ZSKqBTGVXYcSVdKvK8Atq3J5/N6tEb8HcMi9xx9UQEAkfBR5ULg8Sm6
kSeROWLffX6nrBC9VVNWJbYYIa/a0AI=
=v5zV
-----END PGP SIGNATURE-----

--Kj7+TgqWhvqCa97w--

