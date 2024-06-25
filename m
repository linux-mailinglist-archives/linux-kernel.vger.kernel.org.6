Return-Path: <linux-kernel+bounces-229250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C4916D56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DAD1C20902
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F3616FF3D;
	Tue, 25 Jun 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEQUFkmy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3816EC10;
	Tue, 25 Jun 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330170; cv=none; b=MZRw4OTY/iTApbXQcl7HmEDwweg33y2H/oiTGEjRJfVPBmjtOle11gZdv0dXYs25KkfLbXk4Dt+R/EVeMp053A7Lv5RbLa4RbZt/pp3IS2jk/RCjzO1BfurHcRucSNkCWwgwbPfHKiyvH6HTp4oZX2MB71VXzgnXreDBWyG+Jxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330170; c=relaxed/simple;
	bh=0EWqU0TQngTF3BLWUKxqBKCJJ/uf0uceTeoQNO0hkEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv8DHigIQGV3mSk6+qE2bA1qg0u71fm4W0U5OcExtc1TWkxAbpo5iEHb6Em7iOuLmjLizNRjC0bLz4Ncrou5qtsWPJHEVfgyiPn3v2+2dHAK40rDsGwS7nOrJuiKtvv6mkFwpRSUR4jTlffxz2oV/ulxJAdJUZhDpXQLkG7c5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEQUFkmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9049C32782;
	Tue, 25 Jun 2024 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330170;
	bh=0EWqU0TQngTF3BLWUKxqBKCJJ/uf0uceTeoQNO0hkEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEQUFkmya3YR+mR/j1IfIw7nhDcTMrVSVpBkCSfmCY+AvrHHMRp0leFrhiPBCMXec
	 WIC+RIJCFVem677msnmCo+b1lST8j77gMxbUTZnjuR8tOJ90ccP5Qx450+VwsTApKq
	 RQHm1u5EZ9631bvdj3vLUIjp9SNAFnl6WMDcizSmzA4ezPK27owtAmJTtOsdiNhGOn
	 xbis7nC1Eh+zXx8NCBA39MqwNnvYaXdxHqVUlVvZX8oswAcq4YGho2JH9VY7vPj2Jf
	 vslMqgLshuT5pZmD4ZteXZUfnuYhvf++aVA1hfT4Y9EQpWrSdDqZQQBkvsjGEHDwTG
	 +5tNhEHlfvpaA==
Date: Tue, 25 Jun 2024 16:42:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org, Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH RESEND v8 0/6] riscv: add initial support for
 Canaan Kendryte K230
Message-ID: <20240625-broadside-cope-52ecb71d459f@spud>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
 <20240410-unwoven-march-299a9499f5f4@spud>
 <20240619-hammock-drum-04bfc16a8ef6@spud>
 <CAJF2gTRYpDLij1aQoftz6ZqEgXDrfhNA39KiFVrwm7qc4WH6Fg@mail.gmail.com>
 <20240623-graveyard-consonant-97eff0f11808@spud>
 <CAJF2gTS_KkQjyQPubc2+naYiammLjN8jJyptGtCe8Z56MAmT2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OM922ceDo/uZsKlH"
Content-Disposition: inline
In-Reply-To: <CAJF2gTS_KkQjyQPubc2+naYiammLjN8jJyptGtCe8Z56MAmT2A@mail.gmail.com>


--OM922ceDo/uZsKlH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 11:55:32AM +0800, Guo Ren wrote:
> On Mon, Jun 24, 2024 at 1:32=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Jun 24, 2024 at 01:07:55AM +0800, Guo Ren wrote:
> > > On Wed, Jun 19, 2024 at 6:45=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >
> > > > On Wed, Apr 10, 2024 at 11:30:25AM +0100, Conor Dooley wrote:
> > > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > > >
> > > > > On Mon, 08 Apr 2024 00:26:58 +0800, Yangyu Chen wrote:
> > > > > > K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add=
 initial
> > > > > > support for it to allow more people to participate in building =
drivers
> > > > > > to mainline for it.
> > > > > >
> > > > > > This kernel has been tested upon factory SDK [1] with
> > > > > > k230_evb_only_linux_defconfig and patched mainline opensbi [2] =
to skip
> > > > > > locked pmp and successfully booted to busybox on initrd with th=
is log [3].
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Applied to riscv-dt-for-next, thanks!
> > > > >
> > > > > [1/6] dt-bindings: riscv: Add T-HEAD C908 compatible
> > > > >       https://git.kernel.org/conor/c/64cbc46bb854
> > > > > [2/6] dt-bindings: add Canaan K230 boards compatible strings
> > > > >       https://git.kernel.org/conor/c/b065da13ea9c
> > > > > [3/6] dt-bindings: timer: Add Canaan K230 CLINT
> > > > >       https://git.kernel.org/conor/c/b3ae796d0a4f
> > > > > [4/6] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
> > > > >       https://git.kernel.org/conor/c/db54fda11b13
> > > > > [5/6] riscv: dts: add initial canmv-k230 and k230-evb dts
> > > > >       https://git.kernel.org/conor/c/5db2c4dc413e
> > > >
> > > > After some discussion on the k1 thread
> > > > (https://lore.kernel.org/all/ZnEOU7D00J8Jzy-1@xhacker/, https://lor=
e.kernel.org/all/ZnA6pZLkI2StP8Hh@xhacker/)
> > > > I am going to drop this series. It's not very useful in the current
> > > > state and there's not really been any interest from people in getti=
ng
> > > > the platform to a more complete state. Jisheng made some good point=
s in
> > > > the k1 thread about the missing clock controller stuff, and I think=
 I'm
> > > > going to make having basic things like clocks and where applicable
> > > > resets and pinctrl the minimum requirement for the platforms I'm lo=
oking
> > > > after.
> > > Here is the k230 clock driver based on Linux-6.6:
> > > https://github.com/ruyisdk/linux-xuantie-kernel/commit/196242fd9b9b4a=
191dab0c7c3c5bf851ed857d8d
> > >
> > > pinctrl:
> > > https://github.com/ruyisdk/linux-xuantie-kernel/commit/baf26b6622c9de=
2ff64a6ed58eeeb98c8b2c828b
> > >
> > > No reset driver.
> > >
> > > Most of the k230 drivers are under Linux-5.10, and we are porting them
> > > into the newest version of Linux, which takes time.
> > >
> > > So, if the clock & punctual drivers mentioned above could satisfy the
> > > minimum requirements for the platforms, we will update the version of
> > > this series as a supplement.
> > >
> > > Is that okay?
> >
> > I don't understand how that changes anything, these are all out of tree
> > drivers based on an old kernel. I know that there are drivers for a lot
> > of the peripherals that are in-use in the vendor tree etc. What I am
> > looking to happen, before I apply patches for the k230, is that the clo=
ck
> > dt-bindings will have landed in linux-next - and ideally the pinctrl on=
es
> > too.
> Okay, clock & pinctrl, the reply is clear to me. Thx.

If you could get someone to work on them, or convince Canaan to do it
etc, that'd be neat :)

--OM922ceDo/uZsKlH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrldQAKCRB4tDGHoIJi
0mj/AQDSC+8biqd74U/wZIAYY5mPtlzOLL72kl322YLxabTrsQEAlqZIiS7uT0VG
hn+xDxQiJhWGReEGAEQpjvt64ET4LA4=
=j+ri
-----END PGP SIGNATURE-----

--OM922ceDo/uZsKlH--

