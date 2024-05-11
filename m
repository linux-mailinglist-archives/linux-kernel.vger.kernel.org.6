Return-Path: <linux-kernel+bounces-176531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E415F8C313D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0A01F218D8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15DE56446;
	Sat, 11 May 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/6ke5/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE453362;
	Sat, 11 May 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715429927; cv=none; b=ZC19GDbY54HYwZ/RjjhjrA9yLzInA/MvW5Qa1oyq00DWO+0cYNkyZqaeCzWYW8yFb9HdTIc7ydzlJluPBrav+uPSKgawZfTwe1HqVqipTkIscfwPnqdJMRyOkrxlcFPh8bRpkXTc4Z0KAEbuwHFvxqQyUpfLoYQ4db47xZ5G9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715429927; c=relaxed/simple;
	bh=s+M9h0DBUQzIAjC8URttvL4W46/RRLRnAX+0HaoiRJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTv4NxTJx348gGklZ+FtYZzA7RR0alfCcg4HdWzKmSWmuxR0Zl/ti0pnwWcIXGweSeLrUTnQKsFy+Xi8DWHseV6f0XKyUnJHch6Ud/2PQg3J8J4ZAwZ99rXl7jsiyGkhWlpp8jQB2R/mXek0ajyPKiQHGsmU67EE96DxxRV7JWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/6ke5/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6E7C2BBFC;
	Sat, 11 May 2024 12:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715429926;
	bh=s+M9h0DBUQzIAjC8URttvL4W46/RRLRnAX+0HaoiRJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/6ke5/c5OoLeBvn2RdkJkBy6iB8OiTNKb0NMyf8j5FtnDl4Yi5PjTaeUlns3cIOp
	 mC5LT+b2P1SfMZabSGhbeeSB2J6uAMA+iSNSG3ZmBgFxD+o2trHRZ8KPQ7oa7BnyWA
	 V2Q5v4i37XtvluH9ctWIHl+3+pP6HwwuGIwD8BQ06HLfIeFDKoiC0INjMt3E/bzjWT
	 /Uljpo7zyXJTsJfKeciN8Tp6IWA07Jg9FPZmLm6XjAotY0gL9XmENG2bOZMi1OC7Us
	 Dp5ykq3/v6KyKbw2UfxA09dYJ4nVTrtXVCivfQ7DzH+T+WzS3KcMMB7TgVonkJ+6DO
	 kXByUnWWnbvsA==
Date: Sat, 11 May 2024 13:18:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Message-ID: <20240511-unbiased-dainty-ccb5ece9b1b9@spud>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
 <20240510-unfounded-syrup-d1263d57d05a@spud>
 <NTZPR01MB0956D48361098E8AA4B3930A9FE02@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="333ws8b+xrVh64Qn"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB0956D48361098E8AA4B3930A9FE02@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>


--333ws8b+xrVh64Qn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 03:02:56AM +0000, Xingyu Wu wrote:
> On 11/05/2024 05:05, Conor Dooley wrote:
> >=20
> > On Tue, May 07, 2024 at 02:53:17PM +0800, Xingyu Wu wrote:
> > > This patch is to add the notifier for PLL0 clock and set the PLL0 rate
> > > to 1.5GHz to fix the lower rate of CPUfreq on the JH7110 SoC.
> > >
> > > The first patch is to add the notifier for PLL0 clock. Setting the
> > > PLL0 rate need the son clock (cpu_root) to switch its parent clock to
> > > OSC clock and switch it back after setting PLL0 rate. It need to use
> > > the cpu_root clock from SYSCRG and register the notifier in the SYSCRG
> > > driver.
> > >
> > > The second patch is to set cpu_core rate to 500MHz and PLL0 rate to
> > > 1.5GHz to fix the problem about the lower rate of CPUfreq on the
> > > visionfive board. The cpu_core clock rate is set to 500MHz first to
> > > ensure that the cpu frequency will not suddenly become high and the
> > > cpu voltage is not enough to cause a crash when the PLL0 is set to 1.=
5GHz.
> > > The cpu voltage and frequency are then adjusted together by CPUfreq.
> >=20
> > Hmm, how does sequencing work here? If we split the patches between tre=
es it
> > sounds like without the dts patch, the clock tree would (or
> > could) crash, or mainline if the clock changes there before the dts one=
s do. Am I
> > misunderstanding that?
>=20
> Oh, I think you misunderstood it. Patch 1 (clock driver patch) does not c=
ause the
> clock tree crash without the patch 2 (dts patch), and it just provides th=
e correct
> flow of how to change the PLL0 rate. The patch 2 is to set the clock rate=
 of
> cpu_core and PLL0 rate, which causes the crash without patch 1. Setting c=
pu_core
> rate is to avoid crashes by insufficient cpu voltage when setting PLL0 ra=
te.

So is the problem in the other direction then? My dts tree will crash if
I apply the dts change without the clock patch?
Additionally, what about U-Boot? Will it have problems if the dts is
imported there without changes to its clock driver?

Cheers,
Conor.

--333ws8b+xrVh64Qn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj9iIQAKCRB4tDGHoIJi
0jz7AQDMGT0ZB2SbFkWjxos3cZ08Ze3mWlouJG3EZjiHUCiEpQD9GdnqEmDDi+rg
c/RIx75GM1ix0t3Vh238l/JUOHWRsg0=
=/uka
-----END PGP SIGNATURE-----

--333ws8b+xrVh64Qn--

