Return-Path: <linux-kernel+bounces-519894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C769A3A342
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEE9170A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1703326F468;
	Tue, 18 Feb 2025 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BB/WU+Go"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F913B7B3;
	Tue, 18 Feb 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897642; cv=none; b=oOwx884YMLdDR3QWrrmqZycpzEjx+si5ZVsGhpmMcfG3qKQNEfifSUzfL/8C41h0Py9YkIX5s20GemoK0+2AAIJ2ADLf6oQB0e3XAPw4wwKL9i1yUmdKWhWxEpOTKefNp3gzZ6bMzjbchdPoz3QRWrjK7jGNQUBhnUxEeU81azc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897642; c=relaxed/simple;
	bh=YoP2Wb22V7FT45qYcDXO9+AVfW/P/IXMCuLIm9GpAPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeoA1MGB6t3MSu80/nEuKzzucatYDEbd5AvF3zvSrw73eE14yO99N3b264y0yQlNfVwrEmo4tSa9ZHsyr71ic7s2X7D2BveyB8bkwfsWOADADiejDC2vmCP8yo3+h7l8RRHizrj8vV5fqhVWHNFiEo1pq+JQybjppzDP2Z47Y/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BB/WU+Go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D458AC4CEE4;
	Tue, 18 Feb 2025 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739897641;
	bh=YoP2Wb22V7FT45qYcDXO9+AVfW/P/IXMCuLIm9GpAPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BB/WU+GohTnBhEdVx//Bcczd08fH2btl7+G5G7+hCNodMJ0M9BcCQe/7ZDr9uBQs1
	 AGnVubcCxB/KXfdba1nkdePAPAPfexDl1fNh4zq0F/DUyu2nP6+qdcHKED7034b7O4
	 FSoib2elHKMpF7H6khU7y8fpaeOx1vm2yzxOQixtjQzrw0nu8PDIy0I00h22dk0kk7
	 JjHDGxBP8nB9/5t+e732ByF8GmRftWalHUAxibZqT9lh4DC+5btqyXfVevwOuA+X0h
	 zwG6ZkTh/XciZgBNkzXLgi8Y6enlKpoAH0VRvkktuKwY66kALgGKJDTwzVYmrN/rF9
	 C2L3cYQ+2abUg==
Date: Tue, 18 Feb 2025 16:53:56 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Friday Yang =?utf-8?B?KOadqOmYsyk=?= <Friday.Yang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Garmin Chang =?utf-8?B?KOW8teWutumKmCk=?= <Garmin.Chang@mediatek.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>,
	Yong Wu =?utf-8?B?KOWQtOWLhyk=?= <Yong.Wu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: mediatek: Add SMI LARBs reset
 for MT8188
Message-ID: <20250218-imaginary-prism-d097ebd4a38b@spud>
References: <20250121065045.13514-1-friday.yang@mediatek.com>
 <20250121065045.13514-2-friday.yang@mediatek.com>
 <20250121-violet-widely-df3567b085a4@spud>
 <2bfb6c05a3471e54f51c06895709853661e82c9a.camel@mediatek.com>
 <20250124-aide-feisty-821cf9cf1382@spud>
 <85c616dd195da26313cab552b24f514b539193c1.camel@mediatek.com>
 <ddd1d62e-b1d2-4271-99a3-74bb0a48fb48@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z+c1Hyo5mnPQvSBK"
Content-Disposition: inline
In-Reply-To: <ddd1d62e-b1d2-4271-99a3-74bb0a48fb48@collabora.com>


--z+c1Hyo5mnPQvSBK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 03:24:58PM +0100, AngeloGioacchino Del Regno wrote:
> Il 18/02/25 13:44, Friday Yang (=E6=9D=A8=E9=98=B3) ha scritto:
> > On Fri, 2025-01-24 at 17:31 +0000, Conor Dooley wrote:
> > > On Wed, Jan 22, 2025 at 07:40:12AM +0000, Friday Yang (=E6=9D=A8=E9=
=98=B3) wrote:
> > > > On Tue, 2025-01-21 at 17:30 +0000, Conor Dooley wrote:
> > > > > On Tue, Jan 21, 2025 at 02:50:40PM +0800, Friday Yang wrote:
> > > > > > SMI LARBs require reset functions when applying clamp
> > > > > > operations.
> > > > > > Add '#reset-cells' for the clock controller located in image,
> > > > > > camera
> > > > > > and IPE subsystems.
> > > > >=20
> > > > > A new required property is an abi break, please explain why this
> > > > > is
> > > > > required.
> > >=20
> > > You never answered this part. From a quick check, looks like the
> > > change
> > > you made will cause probe failures if the resets are not present?
> > > Maybe
> > > I misread the driver code in my quick skim - but that is the
> > > implication
> > > of a new required property, so I didn't dig super far.
> > >=20
> > > Adding new properties that break a driver is not really acceptable,
> > > so I
> > > hope I made a mistake there.
> > >=20
> >=20
> > Sorry to reply late.
> > This is a known bus glitch issue. It worked because MediaTek has
> > provided patches 1, 2 and 3. In other word, it can not work
> > without patches 1, 2 and 3.
> >=20
> > 1.
> > https://lore.kernel.org/all/20240327055732.28198-1-yu-chang.lee@mediate=
k.com/
> > 2.
> > https://lore.kernel.org/all/20240327055732.28198-2-yu-chang.lee@mediate=
k.com/
> > 3.
> > https://lore.kernel.org/all/20240327055732.28198-3-yu-chang.lee@mediate=
k.com/
> >=20
> > Patches 1, 2 and 3 have been previously reviewed, and the reviewers
> > provided the following comments:
> > 4.
> > https://lore.kernel.org/all/CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=3DwXpo=
bDWU1CnvkA@mail.gmail.com/
> > 5.
> > https://lore.kernel.org/all/CAPDyKFpokXV2gJDgowbixTvOH_5VL3B5H8eyhP+KJ5=
Fasm2rFg@mail.gmail.com/
> > As I mentioned earlier, SMI clamp and reset operations should be
> > implemented in SMI driver rather than the PM driver. Additionally, the
> > reset operations have already been implemented in the clock control
> > driver. There is no need to submit duplicate code.
> >=20
> > To address this, I have provided patches 6, 7 to replace patches 1, 2,
> > and 3, as I believe this approach aligns more closely with the
> > reviewers' requirements.
> > 6.
> > https://lore.kernel.org/lkml/20250121065045.13514-1-friday.yang@mediate=
k.com/
> > 7.
> > https://lore.kernel.org/lkml/20250121064934.13482-1-friday.yang@mediate=
k.com/
> >=20
> > What's more, I have tested the patch 6, 7 in MediaTek MT8188 SoC.
> > It could work well. If you have any questions, please feel free to
> > contact me.
> >=20
> > > > What are "SMI LARBs"? Why did things previously work
> > > > > without
> > > > > acting as a reset controller?
> > > > >=20
> > > >=20
> > > > The background can refer to the discussion in the following link:
> > > >=20
> > > >=20
> > https://lore.kernel.org/all/CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=3DwXpo=
bDWU1CnvkA@mail.gmail.com/
> > > >=20
> > > >=20
> > https://lore.kernel.org/all/CAPDyKFpokXV2gJDgowbixTvOH_5VL3B5H8eyhP+KJ5=
Fasm2rFg@mail.gmail.com/
> > > > SMI clamp and reset operations should be implemented in SMI driver
> > > > instead of PM driver.
> > >=20
> > > So the answer to how it worked previously was that nothing actually
> > > used
> > > this multimedia interface?
> > >=20
> > > Your commit message needs to explain why a new required property is
> > > okay
> > > and why it was not there before.
> > >=20
>=20
> This conversation slipped through the cracks - wanted to reply to this qu=
ite a bit
> of time ago but then for whatever reason .... eh here we are :-)
>=20
> Anyway.
>=20
> The cleanest option to get the glitching situation to get resolved is pro=
bably
> exactly the one that Friday proposed with this series...
>=20
> I agree that the commit needs a proper description, though, and even thou=
gh the
> drivers were never actually used (so it's not a huge problem - as in - no=
 device
> gets broken when this is merged), it's still an ABI breakage, and that ha=
s to be
> justified with a good reason.
>=20
> The good reason is that there's a hardware bug that you're trying to reso=
lve here
> and that emerged only after the initial upstreaming of this binding (do *=
not*
> mention drivers in DT bindings, those describe the hardware, not software=
!), and
> the only way to resolve this situation is by resetting the Local Arbiter =
(LARB)
> of the cam/img/ipe macro-blocks.
>=20
> Failing to do this, the hardware is going to be unstable during high/dyna=
mic load
> conditions.
>=20
> So, just describe the problem and how you're solving it in the commit des=
cription:
> that's going to be okay and justifying everything that you're doing here.

Aye, seems fair enough to me to make the change if nothings ever used it
as it currently is, provided it's justified in the commit message :+1:

>=20
> I'm sorry for chiming in that late, btw.

--z+c1Hyo5mnPQvSBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7S7JAAKCRB4tDGHoIJi
0oIiAQDqz4r1wVNOAZjXPgcI3xZ7o90OxQ88cFEcH3wj/cvyRwD+JCkthqKwQ1xq
Lz4TBSkNQL1uBnH/mhgpnht6GEakHAI=
=GoZv
-----END PGP SIGNATURE-----

--z+c1Hyo5mnPQvSBK--

