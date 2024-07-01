Return-Path: <linux-kernel+bounces-236397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053191E1BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8416B2274E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7911166304;
	Mon,  1 Jul 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCa34a/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061E15EFD7;
	Mon,  1 Jul 2024 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842326; cv=none; b=kz1Qsa/zMEI1dMtJGeIXPLOzmNMgdnuP1JOtrP3I4bSaFIffEW/rH0Zvpx6K/BldytdvFLUCQBNTVU88+JiKse6188LnKN+R3F2R33yyOUHAxwQBphI/Yj/cZsF54CwkaHOJxhkhOglnjSQffZpLP2YnBXWE5uzPlaeS/X0QzDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842326; c=relaxed/simple;
	bh=VlYW+BVRr/2wR3yn9dKsp1GvB5pZ/gJsdlh3v7mNgNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKIA658+wK1909pT1/H9oweotXwKac2mVHkE65cH0B7j2Ig0As4jk9GmsStq+96IrmRgTfn2wF8OaFQqrI72QsHMULGrcJVYlhfOf8OcQ4biddPszvTtLbbR0/AQe2JDIEPdJqEufl3jjqiA/rAMsGWpdw3IFl4wNulQ1ZH22+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCa34a/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C0FC4AF0A;
	Mon,  1 Jul 2024 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719842325;
	bh=VlYW+BVRr/2wR3yn9dKsp1GvB5pZ/gJsdlh3v7mNgNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCa34a/qdJvYWcajMBbpHf1rUBXPV8M31Y/m6W6pDSxBp/BQN1u40rg0iq5bk/Le8
	 orPJ3ALUY0f4N3TIb7UhKwLSN+GJq2QDHkKh5ru85nk36b+YAjW82s2IGIArx0NngQ
	 SBxfkb2Jd1yeNPdlIX3MhwVWTDEEUT454n18TPjNlrOtrNNlT+M81WKU6UOHAHIQ7S
	 obF/PBNv+P2tskoAm5FKNTDGx7keMpSS4k+n5M+vAdg+WVcsWhlyXnINg6SrHWdp+l
	 jvoDBNvt1mCHjJTN3LMLcu+1RVz3vB140YbeTiVL9//yqfcHVKsn3a6Zk1TSCwS5A6
	 jMRAmmFScPTWA==
Date: Mon, 1 Jul 2024 14:58:36 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/8] RISC-V: Check Zicclsm to set unaligned access
 speed
Message-ID: <20240701-ajar-italicize-9e3d9b8a0264@spud>
References: <20240625005001.37901-1-jesse@rivosinc.com>
 <20240625005001.37901-5-jesse@rivosinc.com>
 <20240626-march-abreast-83414e844250@spud>
 <Zn3XrLRl/yazsoZe@ghost>
 <43941f48-9905-4b25-89ef-6ad75bf1a123@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EnTioEvMPr9HA3hF"
Content-Disposition: inline
In-Reply-To: <43941f48-9905-4b25-89ef-6ad75bf1a123@rivosinc.com>


--EnTioEvMPr9HA3hF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 09:15:09AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 27/06/2024 23:20, Charlie Jenkins wrote:
> > On Wed, Jun 26, 2024 at 03:39:14PM +0100, Conor Dooley wrote:
> >> On Mon, Jun 24, 2024 at 08:49:57PM -0400, Jesse Taube wrote:
> >>> Check for Zicclsm before checking for unaligned access speed. This wi=
ll
> >>> greatly reduce the boot up time as finding the access speed is no lon=
ger
> >>> necessary.
> >>>
> >>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> >>> ---
> >>> V2 -> V3:
> >>>  - New patch split from previous patch
> >>> ---
> >>>  arch/riscv/kernel/unaligned_access_speed.c | 26 ++++++++++++++------=
--
> >>>  1 file changed, 17 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/=
kernel/unaligned_access_speed.c
> >>> index a9a6bcb02acf..329fd289b5c8 100644
> >>> --- a/arch/riscv/kernel/unaligned_access_speed.c
> >>> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> >>> @@ -259,23 +259,31 @@ static int check_unaligned_access_speed_all_cpu=
s(void)
> >>>  	kfree(bufs);
> >>>  	return 0;
> >>>  }
> >>> +#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
> >>> +static int check_unaligned_access_speed_all_cpus(void)
> >>> +{
> >>> +	return 0;
> >>> +}
> >>> +#endif
> >>> =20
> >>>  static int check_unaligned_access_all_cpus(void)
> >>>  {
> >>> -	bool all_cpus_emulated =3D check_unaligned_access_emulated_all_cpus=
();
> >>> +	bool all_cpus_emulated;
> >>> +	int cpu;
> >>> +
> >>> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
> >>> +		for_each_online_cpu(cpu) {
> >>> +			per_cpu(misaligned_access_speed, cpu) =3D RISCV_HWPROBE_MISALIGNE=
D_FAST;
> >>
> >> - const: zicclsm
> >>   description:
> >>     The standard Zicclsm extension for misaligned support for all regu=
lar
> >>     load and store instructions (including scalar and vector) but not =
AMOs
> >>     or other specialized forms of memory access. Defined in the
> >>     RISC-V RVA Profiles Specification.=20
> >>
> >> Doesn't, unfortunately, say anywhere there that they're actually fast =
:(
> >=20
> > Oh no! That is unfortunate that the ISA does not explicitly call that
> > out, but I think that acceptable.
> >=20
> > If a vendor puts Zicclsm in their isa string, they should expect
> > software to take advantage of misaligned accesses. FAST is our signal to
> > tell software that they should emit misaligned accesses.
>=20
> AFAIK, Zicclsm is not even an ISA extension, simply a profile
> specification which means that only the execution environment which
> provides the profile support misaligned accesses (cf
> https://lists.riscv.org/g/tech-profiles/message/56).

I dunno, the specification status page used to describe it as an
extension:
https://wiki.riscv.org/display/HOME/Specification+Status+-+Historical
My understanding was that these could be considered extensions, just
like we are considering svade to be one.

> . I don't think we
> can extrapolate that the misaligned accesses will be fast at all.

That is my opinion on it too. If it doesn't say "fast" and give a
definition for what that means in the binding, then we can't assume that
it is fast. I'm also wary of extending definitions of extensions in the
binding, because a) I am 90% sure that people writing devicetrees don't
care and b) it'd be a potential difference between DT and ACPI without a
real justification (unlike the zkr or svade/svadu situations).

> > This allows for a generic kernel, like the one a distro would compile, =
to
> > skip the probing when booting on a system that explicitly called out
> > that the hardware supports misaligned accesses.

--EnTioEvMPr9HA3hF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoK2DAAKCRB4tDGHoIJi
0jMlAQDXSIyO1eIrZ/BuGBKJHLB7xCoNnG0MF/2pC2M8BmRSFgD/Z0rIDWJaRF7z
bgl9+NyRjblrbywgRXV4IPYh3mhDEww=
=/nDm
-----END PGP SIGNATURE-----

--EnTioEvMPr9HA3hF--

