Return-Path: <linux-kernel+bounces-283416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBE894F22D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C314DB24C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497CE186E20;
	Mon, 12 Aug 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKnVNvPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59F4D112;
	Mon, 12 Aug 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478210; cv=none; b=jCxZSWALQnBJUXztPtXXFUzjk3BlI+tf1Zt8Xlc2XCU8jmVLj2/DwOhzOigi2hCG5DvQb7zqa1/+VLYqcR/E9vi/MByStYnt6tgjOa/CJOg4FlwG7dKTAlju+TdCV8ig8VOFCAA+EqskLoyC7dI/g07gVNfO08j1jDVbXivVyI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478210; c=relaxed/simple;
	bh=4e6n6x92NqR9MazOboeLoHPGK4lVmsG86VhQltVlHWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agz/yzIGuLxXBNtDry0PnH32eE/5UV0FsB6b3xG8SPcg5aJVPsovwrfaHy1jdzpyfzS97F/d4L3HyO06V70Mu9rfHvgzTFrCYWkxIpoLl3+eFmP0SAd7AA0FdlEqT3Rq9kJS1mHbqVrrcSONgDzQfvNQcTNbaA43K9RLEYKpOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKnVNvPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025E0C32782;
	Mon, 12 Aug 2024 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723478210;
	bh=4e6n6x92NqR9MazOboeLoHPGK4lVmsG86VhQltVlHWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKnVNvPbsccKLigIcSzPDPIcxRbt14nNxS0R8oPjsUpRSOyH3dFuExFnz2wBg8Xob
	 KwK3j8pUKfJp95jaPS5zVNnhb5idDgyLDsjMVmM5XHeq5Hu1lewLpywzwTumyCeVJ5
	 gwjAYzyNCZi7hebQpqq1PDbjEwZPx+LTY5hZyr4NyKIwrmM2jwdm654gbe9zN369XN
	 TQaEYWvaXU6O2HVaHILIzd2XBDe/ZefkVmvS6dVyAB17sgrqJDQXM7MyNG8HRYe6Sp
	 EeHc8R4GAnwGDbFPZoAmAHdlzXkKi2ONO0LnxeCKl41/Yf5lPBYn+0dcYlvFf+MK3i
	 DWOdhCpbikSuA==
Date: Mon, 12 Aug 2024 16:56:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Jesse Taube <jesse@rivosinc.com>,
	linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: Add Zicclsm ISA extension
 description.
Message-ID: <20240812-rogue-enable-9194afe10621@spud>
References: <20240809162240.1842373-1-jesse@rivosinc.com>
 <20240809162240.1842373-3-jesse@rivosinc.com>
 <20240809181536.GA976083-robh@kernel.org>
 <ZrZmTvJgyQ5nB70H@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5oUgzud46N4jhbzw"
Content-Disposition: inline
In-Reply-To: <ZrZmTvJgyQ5nB70H@ghost>


--5oUgzud46N4jhbzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 11:56:14AM -0700, Charlie Jenkins wrote:
> On Fri, Aug 09, 2024 at 12:15:36PM -0600, Rob Herring wrote:
> > On Fri, Aug 09, 2024 at 12:22:40PM -0400, Jesse Taube wrote:
> > > Add description for Zicclsm ISA extension.
> > >=20
> > > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > > V1 -> V2:
> > >  - New patch
> > > V2 -> V3:
> > >  - No changes
> > > V3 -> V4:
> > >  - No changes
> > > V4 -> V5:
> > >  - No changes
> > > V5 -> V6:
> > >  - No changes
> > > V6 -> V7:
> > >  - No changes
> > > V7 -> V8:
> > >  - Rebase onto 2d1f51d8a4b0 (palmer/for-next)
> >=20
> > Please also put the version in the subject. '-vN' is the git-send-email=
=20
> > option to do it for you.
> >=20
> > Rob
> >=20
>=20
> These patches were originally part of a different series [1] but are no
> longer related to that series so I had asked Jesse to spin these off into=
 a
> different series. These version tags probably should not have been left
> on here when made into this new series though.

I dunno, I disagree. I think the versioning should continue on being
split - especially when there's been tags provided on earlier versions.

--5oUgzud46N4jhbzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrowuQAKCRB4tDGHoIJi
0jq+AQCp+/d4fJsH+1tFW/4KT0Q0ZRrPKVNCwnFEAIbB7uO4+AD8DA2HB1PxjGsW
KBrdfSC7D857tJ/2h3QaZbYOyeNjAQ4=
=sOnO
-----END PGP SIGNATURE-----

--5oUgzud46N4jhbzw--

