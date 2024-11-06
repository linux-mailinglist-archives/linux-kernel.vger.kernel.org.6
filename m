Return-Path: <linux-kernel+bounces-398259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A919BEC93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3BD1C23B02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A941FCC76;
	Wed,  6 Nov 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLuSR5vl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D391F4FCF;
	Wed,  6 Nov 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897791; cv=none; b=btk9dH/uZgVqQUCmJVrYQ3X6fZZMszJUsiKwymXGGWEV7bjTQ1B9vkwKZc6HaZ1SD/s8rnAB7FzbmrjtxHqw/GWw+Au7hXbDCr4hqL8KULCS9OSHjBNjoZOpLJtIk8rzWBe2kV8cmVNDqp+hGHmS9/VHSMmwOuXG+qZAujudVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897791; c=relaxed/simple;
	bh=9ijZ17+hfv173zIRsOLUz+ONcBtjK1noi4xIUL4UXiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTTaP8WnioaoXBd/cysAYJaTAET0Oj0cFtz6wonK7ZsRPhoTdO1qKvucphwXa13K/1F5c5bIQCnLLHUnM8KwgqhDlm9NMlGI6bLQQs+Uap0Es2Ce8MAcBP0Up7QvYJFSad7TMVeTmUE+eKLr2feEFhJS3EIx+EK8olYUlysQylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLuSR5vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427F6C4CECD;
	Wed,  6 Nov 2024 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730897791;
	bh=9ijZ17+hfv173zIRsOLUz+ONcBtjK1noi4xIUL4UXiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLuSR5vlRZejmXGOTr2xkmuiFaAbNeB2RYqCYYSTohQYjkwLSSH40Ya4qJTuEZJZ/
	 29Fz2lpnp3KTKwlbiVUCC4tzQBpHkT83M6tVoE1B9oBaE1ipSczWXKFY1+4ZYtDVTh
	 tfgew3c/kbSscfwGdCDX2RMCOR2hvowbao+ebxr//l7iV5fYz8wm14jD8hlwTSX1n0
	 g9LXyt+W0CWru9jjM6aIxwBt1L1Q0Pa7V7GXfM2BzFIW+NMNZJhHBwRRjxzqR7+0Jd
	 b9k0n0NHwxSh46nojWFF01+TLtxAZNz/cCol3HBd+D7kNrGPtOMa9s/qhtVaYQF2Kq
	 Sl6SCUCUXJi2g==
Date: Wed, 6 Nov 2024 12:56:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 08/11] clk: move meson clk-regmap implementation to
 common code
Message-ID: <20241106-freefall-slider-db379b05821e@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-hula-unwashed-1c4ddbadbec2@spud>
 <2b49c4df-a34a-42c5-8d44-9e47da630fe8@linaro.org>
 <1jwmiqsks3.fsf@starbuckisacylon.baylibre.com>
 <20241003-tacking-ladylike-dfe2b633e647@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+TLJ5hylperMRXZ0"
Content-Disposition: inline
In-Reply-To: <20241003-tacking-ladylike-dfe2b633e647@spud>


--+TLJ5hylperMRXZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen,

On Thu, Oct 03, 2024 at 12:33:40PM +0100, Conor Dooley wrote:
> On Wed, Oct 02, 2024 at 03:21:16PM +0200, Jerome Brunet wrote:
> > On Wed 02 Oct 2024 at 13:20, Neil Armstrong <neil.armstrong@linaro.org>=
 wrote:
> >=20
> > > On 02/10/2024 12:48, Conor Dooley wrote:
> > >> From: Conor Dooley <conor.dooley@microchip.com>
> > >> I like this one better than qualcomms and wish to use it for the
> > >> PolarFire SoC clock drivers.
> > >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > >> ---
> > >>   drivers/clk/Kconfig                           |  4 ++
> > >>   drivers/clk/Makefile                          |  1 +
> > >>   drivers/clk/{meson =3D> }/clk-regmap.c          |  2 +-
> > >>   drivers/clk/meson/Kconfig                     | 46 +++++++++------=
----
> > >>   drivers/clk/meson/Makefile                    |  1 -
> > >>   drivers/clk/meson/a1-peripherals.c            |  2 +-
> > >>   drivers/clk/meson/a1-pll.c                    |  2 +-
> > >>   drivers/clk/meson/axg-aoclk.c                 |  2 +-
> > >>   drivers/clk/meson/axg-audio.c                 |  2 +-
> > >>   drivers/clk/meson/axg.c                       |  2 +-
> > >>   drivers/clk/meson/c3-peripherals.c            |  2 +-
> > >>   drivers/clk/meson/c3-pll.c                    |  2 +-
> > >>   drivers/clk/meson/clk-cpu-dyndiv.c            |  2 +-
> > >>   drivers/clk/meson/clk-dualdiv.c               |  2 +-
> > >>   drivers/clk/meson/clk-mpll.c                  |  2 +-
> > >>   drivers/clk/meson/clk-phase.c                 |  2 +-
> > >>   drivers/clk/meson/clk-pll.c                   |  2 +-
> > >>   drivers/clk/meson/g12a-aoclk.c                |  2 +-
> > >>   drivers/clk/meson/g12a.c                      |  2 +-
> > >>   drivers/clk/meson/gxbb-aoclk.c                |  2 +-
> > >>   drivers/clk/meson/gxbb.c                      |  2 +-
> > >>   drivers/clk/meson/meson-aoclk.h               |  2 +-
> > >>   drivers/clk/meson/meson-eeclk.c               |  2 +-
> > >>   drivers/clk/meson/meson-eeclk.h               |  2 +-
> > >>   drivers/clk/meson/meson8-ddr.c                |  2 +-
> > >>   drivers/clk/meson/meson8b.c                   |  2 +-
> > >>   drivers/clk/meson/s4-peripherals.c            |  2 +-
> > >>   drivers/clk/meson/s4-pll.c                    |  2 +-
> > >>   drivers/clk/meson/sclk-div.c                  |  2 +-
> > >>   drivers/clk/meson/vclk.h                      |  2 +-
> > >>   drivers/clk/meson/vid-pll-div.c               |  2 +-
> > >>   .../meson =3D> include/linux/clk}/clk-regmap.h  |  0
> > >>   32 files changed, 53 insertions(+), 53 deletions(-)
> > >>   rename drivers/clk/{meson =3D> }/clk-regmap.c (99%)
> > >>   rename {drivers/clk/meson =3D> include/linux/clk}/clk-regmap.h (10=
0%)
> > >>=20
> > > <snip>
> > >
> > > I don't have objections, but I think Stephen didn't like the idea
> > > a few years ago, but perhaps it has changed...
> > >
> > > Anyway, take my:
> > > Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> >=20
> > We had a similar discussion 3y ago indeed:
> > https://lore.kernel.org/linux-clk/162734682512.2368309.1201587301077708=
3014@swboyd.mtv.corp.google.com/
> >=20
> > There are needs for a common regmap backed clocks indeed, but allowing
> > meson flavored regmap clocks to spread in the kernel was not really the
> > prefered way to do it.=20
>=20
> Cool, thanks for that link.
>=20
> > IIRC, Stephen's idea was more the bring regmap support in clk-gate.c,
> > clk-mux, etc ... I'm not quite sure how make iomem and regmap co-exist
> > in a manageable/maintainable way within those drivers (without adding y=
et
> > another level of abstraction I mean) ? Silently creating a regmap maybe
> > ? but that's probably a bit heavy. I did not really had time to dig more
> > on this, I guess no one did.
>=20
> I guess I have some motivation to looking into it at the moment. I had
> my reservations about the Meson approach too, liking it more than
> Qualcomm's didn't mean I completely liked it.
> It was already my intention to implement point b of your mail, had the
> general idea here been acceptable, cos that's a divergence from how the
> generic clock types (that the driver in question currently uses) work.
> And on that note, I just noticed I left the mild-annoyance variable name
> "sigh" in the submitted driver changes, which I had used for the
> clk_regmap struct that your point b in the link relates to.
>=20
> > I don't really have a preference one way or the other but if it is going
> > to be exposed in 'include/linux', we need to be sure that's how we want
> > to do it. With clocks poping in many driver subsystems, it will
> > difficult to change afterward.=20
>=20
> Yeah, I agree. I didn't expect this to go in right away, and I also
> didn't want to surge ahead on some rework of the clock types, were
> people to hate even the reuse.

Hmm, so how (in-)complete of a regmap implementation can I get away
with? I only need clk-gate and clk-divider for this patchset...

Shoving the regmap into the clk structs makes things pretty trivial as I
don't need to do anything special in any function other than
clk_*_readl()/clk_*_writel() and the registration code. A flag isn't
even needed to determine if a clock is a regmap one I don't think, since
you can just check if the regmap pointer is non-NULL. My use case doesn't
actually need the registration code changes either as, currently, only reg
gets set at runtime, but leaving that out is a level of incomplete I'd not
let myself away with.
Obviously shoving the extra members into the clk structs has the downside
of taking up a pointer and a offset worth of memory for each clock of
that type registered, but it is substantially easier to support devices
with multiple regmaps that way. Probably moot though since the approach you
suggested in the thread linked above that implements a clk_hw_get_regmap()
has to store a pointer to the regmap's identifier which would take up an
identical amount of memory.

I don't really care which way you want it done, both are pretty easy to
implement if I can get away with just doing so for the two standard
clock types that I am using - is it okay to just do those two?

Cheers,
Conor.

--+TLJ5hylperMRXZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZytneQAKCRB4tDGHoIJi
0hKAAQCFpDV3E/AK8dWA7TkIPrTKd116nVNbF4DDHJKcPS36cAEAtymt/KGIdIPF
koqYyHxopwgZYIbz0xbdA1kU80glwQo=
=DxRh
-----END PGP SIGNATURE-----

--+TLJ5hylperMRXZ0--

