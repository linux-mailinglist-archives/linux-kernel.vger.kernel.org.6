Return-Path: <linux-kernel+bounces-174923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EE28C177C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11431F246F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D07E82876;
	Thu,  9 May 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM71nvhN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAA1292D2
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286315; cv=none; b=HhKAyg2m7CXo7a6+KUN+LZMx0d8uvpn9BgbdZFtx1zEDA8nN208za+w9ZWrJAvsCOYWXpAADMCcdL6p8YeJYEqB8xfoqZw6UbHA8WhGIxsMTZ7268KFbdGFDhOGsYfBE4YnZ6knI7Xd3G+0ONkMHeK4pVN8w9dZzKDntYcY8+OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286315; c=relaxed/simple;
	bh=HAriXKJsiU78eptyWYez9fPS0ZXKC1upA9sTck3fd8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEYoryytKn/nejhX1Rai+WxsVRO7lQjSNKjm34PgbQQuboA9QVg6SM2Kq3Wg3ZzzbImE5LxvPHIntDXmSYsSsjrJVuso+0zwxJOMjfManDFPYUsQPG0n53cKZ2j9oCVJZ9jsFm+W/dh07obxcsB57ZRrfVL/pzQl7RVyBKQQv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM71nvhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F961C116B1;
	Thu,  9 May 2024 20:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715286314;
	bh=HAriXKJsiU78eptyWYez9fPS0ZXKC1upA9sTck3fd8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rM71nvhNwdY861RZfJ53j0EXV9nRkvPrBMtNb9iL9Lt4ILBXYJJMyB6ouNmyVEbZM
	 ya0gz+F1kGWXa1+kZqm1xYxlrzgXu3WUVS+gOLzf/MbR/3x7IyteSXPNCGg0UDWp2G
	 os1bz59Hkm1anT4upLYUVoHugxqw+LR3bd0NsieuCGAsfeGuYdzM8/XUIDh7p3Zetz
	 GgeD28lhWHl1YqKAcBdkDtl86R2t2b6qiDCLYUlfwHpnExv6AEU8fg1zT1mjj3ryzM
	 Xe2Baf90apLbtKOpZmHfvpIk/BnqFFQIMO7gEnyFKEr6DO0SIMBnu1SvhW/arqUq/w
	 bMFoV1TZA9pDA==
Date: Thu, 9 May 2024 21:25:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Song Liu <song@kernel.org>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] riscv: Support compiling the kernel with more
 extensions
Message-ID: <20240509-uptown-aging-5bdec4730d70@spud>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UijRVgKdYpkEM1/8"
Content-Disposition: inline
In-Reply-To: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>


--UijRVgKdYpkEM1/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Charlie,

Don't mean to subject you to a rant here, but that's kinda what it seems
to have become. I wish the Zbb example I use below was something someone
else had written, so that it doesn't feel like I am tryna kick you while
you're down, but that was the thing I happened across this evening :/

On Tue, May 07, 2024 at 06:36:26PM -0700, Charlie Jenkins wrote:
> The kernel currently has the restriction that it can only be compiled
> with the extensions that are hardcoded in arch/risc/Makefile.
>=20
> Any extension that is not listed in the Makefile can still be used by
> explicitly writing the assembly and using alternative patching.
>=20
> This series introduces Kconfig options that allow the kernel to be
> compiled with additional extensions.
>=20
> The motivation for this patch is the performance improvements that come
> along with compiling the kernel with these extra instructions. Allowing
> the compiler to emit arbitrary Zb* instructions achieves a 4.9%
> reduction of dynamic instruction count for a test ran in Spike that
> boots the kernel and runs a user space program that prints to the
> console.
>=20
> Additionally, alternatives that check if an extension is supported can
> be eliminated when the Kconfig options to assume hardware support is
> enabled.

I brought this up yesterday at the weekly patchwork call and meant to
reply here yesterday, but I didn't get a chance to. I'll start off with
my thoughts on the idea and the implementation and then mention some of
what was said at the call.

Firstly, I don't like an implementation of this behaviour that requires
doing ifdeffery around alternative sites. I think that iff this is done,
the alternative itself should be evaluated at compile time, rather than
having to add more decoration to callsites. That becomes particular
important in the cases where the alternative may not be a simple a or b
case, although I don't think there are any of those in the extensions
you've looked at so far - or at least, you've not tackled those cases.

I am curious about the Svpbmt patch, as you say
> Svpbmt would not benefit from having PLATFORM_SUPPORTS_RISCV_ISA_SVPBMT
> so just move the definition of RISCV_ISA_SVPBMT to Kconfig.isa.
without any any justification for why it would not benefit. There's
alternatives in the codebase right now for Svpbmt, why wouldn't those
get evaluated at build time also? Or why not Zicbom? Was your rationale
for the extensions chosen just the ones that the compiler can actually
generate code for?
That aside, the series seems to address the easiest parts of doing
compile-time extension configuration rather than the messier cases like
Zicbom. To me it seems like the messier cases is actually where we should
be starting, so that we have a scheme that works well.

Ben mentioned something along the same lines for the
has_extension_likely() stuff, which should be far simpler, and can be
implemented via a macro, as you already pointed out.

I did notice that you left the riscv_isa_extension_available() stuff
alone. I think that's reasonable as that code serves more than one
purpose and is intended for use in either in probe functions where
there's no perf (or even code-size impact really, just disable the
driver if you don't want it) or in cases where the user provides its own
bitmap, like KVM.

I haven't actually reviewed the content line by line yet, so I don't
have any detailed comment on any patches, but I think the two things
being done here deserve to be split apart - the first element is
evaluating things that are using alternatives at build time and the
other is adding extensions to the toolchain's march.

Moving onto the objection to the series that I have though, at least at
the moment. Adding more and more optimisations to the kernel already has
potential to balloon to silly levels, and that's before we even consider
the permutations of different build-time options. Both of those things
feel like "where does it stop?" situation, with every single extension
that could have code-gen impact becoming another build-time option for
the kernel. As a result, I'm not convinced that we should do this at all,
and I am starting to wonder about some of stuff that we have already
merged..

I don't think the configurability this series adds is worth the burden of
maintaining support for all the various configurations you're proposing
here (and the others that someone will come along with the week after
this would be merged. After all, with extant hardware that distros are
supporting, albeit in developer or bring-up type builds, one of these
options could even be enabled. Which I suppose could be translated to
a NAK from me on doing something like this at the moment...

Palmer suggested in the weekly call that what would make more sense is
having established bases, that align with what distros are likely to
ship, which probably means something approximating the mandatory set for
profiles, although he also said that the rva23 profiles had already been
given the kibosh by folks. He'll have to provide more information on
that one though.
I think that that seems like a sane approach, as it would produce a far
more limited set of combinations to maintain, but it also means not doing
something like this until the point that distros commit to some specific
set of extensions that is not rv64gc... As well as reducing the
combinations that we need to reason about as developers, I think that the
"user story" for people deciding what is worth enabling in their kernel
config before simpler too.

* Something else that came up during that call, and I think it was
Palmer's suggestion was having a hard think about what we are
currently accepting optimisations for in the kernel. I think we need to
up the "burden of proof" for what we will merge optimisations for to
things that are demonstrated to have significant benefits. I don't mean
to single you out here, cos I did ack the patch after all and it was
just the random example I stumbled on this evening while looking at some
alternative users in the course of writing a reply here. Take this code
for example:

	/*
	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
	 * worth checking if supported without Alternatives.
	 */
	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
		unsigned long fold_temp;

		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
					      RISCV_ISA_EXT_ZBB, 1)
		    :
		    :
		    :
		    : no_zbb);

		if (IS_ENABLED(CONFIG_32BIT)) {
			asm(".option push				\n\
			.option arch,+zbb				\n\
				not	%[fold_temp], %[csum]		\n\
				rori	%[csum], %[csum], 16		\n\
				sub	%[csum], %[fold_temp], %[csum]	\n\
			.option pop"
			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp));
		} else {
			asm(".option push				\n\
			.option arch,+zbb				\n\
				rori	%[fold_temp], %[csum], 32	\n\
				add	%[csum], %[fold_temp], %[csum]	\n\
				srli	%[csum], %[csum], 32		\n\
				not	%[fold_temp], %[csum]		\n\
				roriw	%[csum], %[csum], 16		\n\
				subw	%[csum], %[fold_temp], %[csum]	\n\
			.option pop"
			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp));
		}
		return (__force __sum16)(csum >> 16);
	}

The comment there made me think as to why we even have this optimisation
for Zbb at all - is the saving of 3 - 1 or 5 - 1 instructions actually
worth having 3 code paths? The commit message for this contains no
information on the performance benefit of the code at, and while the cover
letter has some information, it was not actually tested in hardware and
does not look to be a real-word benchmark. This one is already merged,
but something like this in the future would really need to be subjected to
significantly more scrutiny! At the very least, "optimisations" need to be
proved to be beneficial in hardware.

Anyways, that's my thoughts on this. IIRC it was mainly Palmer and I
doing the talking about this on the call, with Paul I think having some
comments. Hopefully Palmer can chime in :)

Cheers,
Conor.

--UijRVgKdYpkEM1/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj0xJgAKCRB4tDGHoIJi
0rXRAP4p05n/waiyPH1aG6rl2m1w37SOA4jrSOw4Jj3bMdpARwD/XkPXYV+QX60U
tipaXSRdd9JtZvsRkBodhAWw+2ya3wo=
=MrRj
-----END PGP SIGNATURE-----

--UijRVgKdYpkEM1/8--

