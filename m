Return-Path: <linux-kernel+bounces-281035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28594D22E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF68F281C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1698197559;
	Fri,  9 Aug 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2/ZK9nf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254DF195FEA;
	Fri,  9 Aug 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213745; cv=none; b=ulKOHDkPBw9IEUwwx9hfwfZTBY5eRJacbrmQogfyyokhkP9o+ANKT6MdH6rW6raFOn7NmZmFER5ath7YvjibfAs8UztawVJ4zydblFkQgigSHgWvHIRiAv9xouqKmtVMed4y2rFkqBQCY3gZIbRSM0meZEEoXCrvbGJm+rlyPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213745; c=relaxed/simple;
	bh=ye0R2hjTypvg1eR6sUjuQGWIAQgBCYND9cAGA6VUVw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok7GNfCDruxWGLPdo6Ob026vrWpe/3oVfwKoJet2rOgtAH17k+bRQSmxFUtaRuTpoe6gDG4LiXTIf2NY+JUn1eisOOlqunlr4qBMuAu+DK2dLFWwkHatRRoSvjSrJUVeW7CIVuMlWI5vUP3lylOoSSmsfjCHGxwN9MAtHI7jSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2/ZK9nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12C6C32782;
	Fri,  9 Aug 2024 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723213744;
	bh=ye0R2hjTypvg1eR6sUjuQGWIAQgBCYND9cAGA6VUVw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2/ZK9nfOQtkRoL9D46jZexwvKvaKfHuWW5+K5SfAh8YVJvq6luCjq8ovxHI0aKEH
	 O8xIku7Z6kE/v6OcCx3+0871A1qUlsIX6C/SQbr0EhEGcG6ZJ21nRipMbcODtlKKMZ
	 mvHjM9bA+4uBiYqoy2xpcu9T0AYcUmpeprZtoLNSSh2Zgb3oXzJA7734tkuoQC3hOM
	 v3LXX8gkz75CsJrh7rxL9KCoRZSNR2uHw3bCxW7KkcL5zkdxA6yy7ojGybqFnpPkh8
	 5y+34VVsZiSJ3jBw9D5+GrrZRHwq7PoSeu6NJMbB8FnMOOz2gMYRKhQgV1b9n8NY/E
	 Xg59G4unk1Q4w==
Date: Fri, 9 Aug 2024 15:28:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, robh@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kalyani Akula <kalyani.akula@amd.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] dt-bindings: nvmem: Use soc-nvmem node name instead
 of nvmem
Message-ID: <20240809-emporium-haziness-e98208c39990@spud>
References: <1184b2799ecdeef04128f4bab3db7460fd8edb10.1723114978.git.michal.simek@amd.com>
 <20240808-imply-backroom-b5a9aaf44db8@spud>
 <18da4d46-68f2-4419-ab60-8df09c0cc7f4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b0jWOPiZeg+8EDbB"
Content-Disposition: inline
In-Reply-To: <18da4d46-68f2-4419-ab60-8df09c0cc7f4@amd.com>


--b0jWOPiZeg+8EDbB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 08:38:46AM +0200, Michal Simek wrote:
>=20
>=20
> On 8/8/24 17:51, Conor Dooley wrote:
> > On Thu, Aug 08, 2024 at 01:02:59PM +0200, Michal Simek wrote:
> > > Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
> > > soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem =
that's
> > > why also update example to have it described correctly everywhere.
> > >=20
> > > Fixes: c7f99cd8fb6b ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.t=
xt to yaml")
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >=20
> > > Changes in v2:
> > > - Fix sha1 in Fixes tag - reported by Stephen
> > >=20
> > > Adding comments from origin version
> > > https://lore.kernel.org/r/42c21f3bcd75f821061d047730dbbcd40233e256.17=
16800023.git.michal.simek@amd.com
> > >=20
> > > Rob:
> > >   This doesn't seem like an improvement. Is there another nvmem node =
at
> > >   this level? I would fix the binding instead if not.
> > >=20
> > > Michal:
> > > That name came from discussion with Conor.
> >=20
> > Did it? I don't recall that, only discussion about adding a "real"
> > example to the binding and noting a typo in the commit message.
>=20
> Definitely you ack it and description was saying the reason for soc-nvmem=
 name
> https://lore.kernel.org/all/20240131-portal-glazing-16fa36efb3cb@spud/

Yeah, to be clear I wasn't complaining about being name-dropped, just
was pointing out that it wasn't my idea, just something I didn't object
to :)

>=20
> And I found and sorry it wasn't you. It was Krzysztof over IRC who sugges=
ted it.
> I can c&p paste our discussion if he agrees.
>=20
> Thanks,
> Michal
>=20
>=20
>=20

--b0jWOPiZeg+8EDbB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYnqwAKCRB4tDGHoIJi
0m1AAP9+sOz212VUhdbThli+7K93jUlwyNVh/yyDryxOGzXHkAD/ZycZV9FFxGOj
Sv/xvdGg75g47zyQuyJlWHqJ3u4XHwk=
=8Snp
-----END PGP SIGNATURE-----

--b0jWOPiZeg+8EDbB--

