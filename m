Return-Path: <linux-kernel+bounces-175022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5498C1937
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806252812FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF595129A73;
	Thu,  9 May 2024 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYNm80ob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A31D1A2C03
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292519; cv=none; b=uisfLc38I93pPLKHbN02FFrHuTtFsKTIx8IX9O8B9G98WiG7eoVIumlypuE/98JR7Bd76xBxpjPG0/oG/obGXiAQToSCkTBM9OoAaD8dLztZw4EuPmNWUgj+ZV/Fy0vl7+a9gK/1FucL9+7L/x92qIcWGR4RWrYVESHGfjrtb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292519; c=relaxed/simple;
	bh=Hg44u7ibQJGu7rYhd2A4qsD9a8Yna0KkwhFe6+PAAfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZmWumLdRzU4/ZA8nKEf3zfALrboQp8lO/ZS/7nOJ+TZBi2scLpjlm5sW/MYcmGBc44LXQKw4QBXrLmqfDaXZ3e9e9ggHuzdRdndlK2TYTOx7j8TLwE1bxjeahOeKifsevz2tAP4K6ELPDZw8zLWPeWP3ROz45/XxRg22WiL6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYNm80ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B0BC116B1;
	Thu,  9 May 2024 22:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715292519;
	bh=Hg44u7ibQJGu7rYhd2A4qsD9a8Yna0KkwhFe6+PAAfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYNm80obu3MGlsXeF1YOPHK4rkvGtvXHQdLiFAer1aYQ2VxHWQZID6yoE2C7Sd5rd
	 1T+CvNL2r9T1QHmq1D3GyEZ3wOfErWJcuVSZ9bwD7pd+QXH9FQIncyKKalP5uKimiU
	 pKPSMwvBcL2YXVlm4Px7HPxlzgq4ycgx80Oy3CNF5kaNhdVwDJouCO1/it7owHVseB
	 bR+GHb6+L+5vhPg2kT4OVyFPSgHnN7FWtd2MRyrOyewsAbsrMvlpvD22xxq7DHctM7
	 X0ax2Cw3Tf/R04GzF1bD55sS+IDyN7XSM+xFqPT56NjmExzHhuWkdE5RW99bVQib+G
	 hOX05ORoxFhsQ==
Date: Thu, 9 May 2024 23:08:34 +0100
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
Message-ID: <20240509-google-passing-3e7577235c44@spud>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240509-uptown-aging-5bdec4730d70@spud>
 <Zj09IUE5k1EJL08X@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UsyF7h4OVwtBkffN"
Content-Disposition: inline
In-Reply-To: <Zj09IUE5k1EJL08X@ghost>


--UsyF7h4OVwtBkffN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 02:16:17PM -0700, Charlie Jenkins wrote:
> On Thu, May 09, 2024 at 09:25:10PM +0100, Conor Dooley wrote:
> > On Tue, May 07, 2024 at 06:36:26PM -0700, Charlie Jenkins wrote:
> > > The kernel currently has the restriction that it can only be compiled
> > > with the extensions that are hardcoded in arch/risc/Makefile.
> > >=20
> > > Any extension that is not listed in the Makefile can still be used by
> > > explicitly writing the assembly and using alternative patching.
> > >=20
> > > This series introduces Kconfig options that allow the kernel to be
> > > compiled with additional extensions.
> > >=20
> > > The motivation for this patch is the performance improvements that co=
me
> > > along with compiling the kernel with these extra instructions. Allowi=
ng
> > > the compiler to emit arbitrary Zb* instructions achieves a 4.9%
> > > reduction of dynamic instruction count for a test ran in Spike that
> > > boots the kernel and runs a user space program that prints to the
> > > console.
> > >=20
> > > Additionally, alternatives that check if an extension is supported can
> > > be eliminated when the Kconfig options to assume hardware support is
> > > enabled.
> >=20
> > I brought this up yesterday at the weekly patchwork call and meant to
> > reply here yesterday, but I didn't get a chance to. I'll start off with
> > my thoughts on the idea and the implementation and then mention some of
> > what was said at the call.
> >=20
> > Firstly, I don't like an implementation of this behaviour that requires
> > doing ifdeffery around alternative sites. I think that iff this is done,
> > the alternative itself should be evaluated at compile time, rather than
> > having to add more decoration to callsites. That becomes particular
> > important in the cases where the alternative may not be a simple a or b
> > case, although I don't think there are any of those in the extensions
> > you've looked at so far - or at least, you've not tackled those cases.
> >=20
> > I am curious about the Svpbmt patch, as you say
> > > Svpbmt would not benefit from having PLATFORM_SUPPORTS_RISCV_ISA_SVPB=
MT
> > > so just move the definition of RISCV_ISA_SVPBMT to Kconfig.isa.
> > without any any justification for why it would not benefit. There's
> > alternatives in the codebase right now for Svpbmt, why wouldn't those
> > get evaluated at build time also? Or why not Zicbom? Was your rationale
> > for the extensions chosen just the ones that the compiler can actually
> > generate code for?
>=20
> It's only used in a place that has errata so I wasn't sure how to
> handle that.
>=20
> > That aside, the series seems to address the easiest parts of doing
> > compile-time extension configuration rather than the messier cases like
> > Zicbom. To me it seems like the messier cases is actually where we shou=
ld
> > be starting, so that we have a scheme that works well.
>=20
> That's good advice. I wanted to send out something to start the
> conversation on what people were interested in optimizing here. I can
> look more into Zicbom.
>=20
> >=20
> > Ben mentioned something along the same lines for the
> > has_extension_likely() stuff, which should be far simpler, and can be
> > implemented via a macro, as you already pointed out.
>=20
> I was hesistant to change "too much" as I was expecting push back and
> didn't want to have to re-write everything ;)
>=20
> >=20
> > I did notice that you left the riscv_isa_extension_available() stuff
> > alone. I think that's reasonable as that code serves more than one
> > purpose and is intended for use in either in probe functions where
> > there's no perf (or even code-size impact really, just disable the
> > driver if you don't want it) or in cases where the user provides its own
> > bitmap, like KVM.
> >=20
> > I haven't actually reviewed the content line by line yet, so I don't
> > have any detailed comment on any patches, but I think the two things
> > being done here deserve to be split apart - the first element is
> > evaluating things that are using alternatives at build time and the
> > other is adding extensions to the toolchain's march.
>=20
> That will double the size of the series but if you think that's better
> than I can do that.
>=20
> >
> > Moving onto the objection to the series that I have though, at least at
> > the moment. Adding more and more optimisations to the kernel already has
> > potential to balloon to silly levels, and that's before we even consider
> > the permutations of different build-time options. Both of those things
> > feel like "where does it stop?" situation, with every single extension
> > that could have code-gen impact becoming another build-time option for
> > the kernel. As a result, I'm not convinced that we should do this at al=
l,
> > and I am starting to wonder about some of stuff that we have already
> > merged..
> >=20
>=20
> Vendors that expect a high level of performance need a way to be able to
> compile the kernel with more extensions than the base extensions. We are
> leaving 5% that can easily be gained by not allowing this.

Maybe we are, but if people want their 5% they need to show up with
evidence that there is actually 5% to be gained. Also, if you read on, I
am not saying we should never do this, and leave that 5% permanently on
the table, only that we should significantly constrain the permutations
that we are allowing. And honestly, if some vendor is really desperate to
compile the kernel with Zxy in march but not whatever other extensions
that may be in a profile's mandatory set, they can always do it out of
tree. Carrying a single out of tree patch is nothing to most vendors...

> > I don't think the configurability this series adds is worth the burden =
of
> > maintaining support for all the various configurations you're proposing
> > here (and the others that someone will come along with the week after
> > this would be merged. After all, with extant hardware that distros are
> > supporting, albeit in developer or bring-up type builds, one of these
> > options could even be enabled. Which I suppose could be translated to
> > a NAK from me on doing something like this at the moment...
>=20
> By migrating everything into more refined macros I think I can ease this
> burden. I don't see this as a burden, these options are all so closly
> tied to each other

What does "closely tied to each other" actually mean?

> and only matter when a kernel developer explicitly
> wants to use an extension.

Unless your definition of "kernel developer" extends to "people that
compile their own kernel based on menuconfig", then I don't think you
and I are on the same page about what the series actually does.
Remember, there's the making alternatives and other optimisations
unconditional /and/ the addition of stuff to march going on in this
series.

> If this is all wrapped up into the macros
> that check if an extension is available it won't even be an extra step
> than what it currently is.
>=20
> >=20
> > Palmer suggested in the weekly call that what would make more sense is
> > having established bases, that align with what distros are likely to
> > ship, which probably means something approximating the mandatory set for
> > profiles, although he also said that the rva23 profiles had already been
> > given the kibosh by folks. He'll have to provide more information on
> > that one though.
> > I think that that seems like a sane approach, as it would produce a far
> > more limited set of combinations to maintain, but it also means not doi=
ng
> > something like this until the point that distros commit to some specific
> > set of extensions that is not rv64gc... As well as reducing the
> > combinations that we need to reason about as developers, I think that t=
he
> > "user story" for people deciding what is worth enabling in their kernel
> > config before simpler too.
>=20
> There is a chicken and the egg problem here. The
> hardware/software/distros all want to support the same thing. Somebody
> needs to step up and make a decision. With a patch like this, a distro
> can see all of the functionality and select what they want. This can
> then be rolled up into a config that selects something like all of the
> bitmanip options.

I don't think there's a chicken and egg problem, or at least not one
that kernel config options for every extension solves. I expect distros
to work with RVI to define something, which may well be the platform
spec (hopefully it's the platform spec...) and then we can make that a
config option.

> > * Something else that came up during that call, and I think it was
> > Palmer's suggestion was having a hard think about what we are
> > currently accepting optimisations for in the kernel. I think we need to
> > up the "burden of proof" for what we will merge optimisations for to
> > things that are demonstrated to have significant benefits. I don't mean
> > to single you out here, cos I did ack the patch after all and it was
> > just the random example I stumbled on this evening while looking at some
> > alternative users in the course of writing a reply here. Take this code
> > for example:
> >=20
> > 	/*
> > 	 * ZBB only saves three instructions on 32-bit and five on 64-bit so n=
ot
> > 	 * worth checking if supported without Alternatives.
> > 	 */
> > 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > 	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > 		unsigned long fold_temp;
> >=20
> > 		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > 					      RISCV_ISA_EXT_ZBB, 1)
> > 		    :
> > 		    :
> > 		    :
> > 		    : no_zbb);
> >=20
> > 		if (IS_ENABLED(CONFIG_32BIT)) {
> > 			asm(".option push				\n\
> > 			.option arch,+zbb				\n\
> > 				not	%[fold_temp], %[csum]		\n\
> > 				rori	%[csum], %[csum], 16		\n\
> > 				sub	%[csum], %[fold_temp], %[csum]	\n\
> > 			.option pop"
> > 			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp));
> > 		} else {
> > 			asm(".option push				\n\
> > 			.option arch,+zbb				\n\
> > 				rori	%[fold_temp], %[csum], 32	\n\
> > 				add	%[csum], %[fold_temp], %[csum]	\n\
> > 				srli	%[csum], %[csum], 32		\n\
> > 				not	%[fold_temp], %[csum]		\n\
> > 				roriw	%[csum], %[csum], 16		\n\
> > 				subw	%[csum], %[fold_temp], %[csum]	\n\
> > 			.option pop"
> > 			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp));
> > 		}
> > 		return (__force __sum16)(csum >> 16);
> > 	}
> >=20
> > The comment there made me think as to why we even have this optimisation
> > for Zbb at all - is the saving of 3 - 1 or 5 - 1 instructions actually
> > worth having 3 code paths? The commit message for this contains no
> > information on the performance benefit of the code at, and while the co=
ver
> > letter has some information, it was not actually tested in hardware and
> > does not look to be a real-word benchmark. This one is already merged,
> > but something like this in the future would really need to be subjected=
 to
> > significantly more scrutiny! At the very least, "optimisations" need to=
 be
> > proved to be beneficial in hardware.
>=20
> I put the justification in the cover letter of the series:

If you read what I wrote I acknowledge that there's info in the cover,
but if you continue reading you'll note I said that "it was not tested
in hardware and does not look to be a real-word [sic] benchmark".

> "Tested on QEMU, this series allows the CHECKSUM_KUNIT tests to complete
> an average of 50.9% faster."
>=20
> I did a lot of testing locally to ensure that every combination was as
> performant as it possibly could be. I did not provide numbers for every
> case simply because the combination with 64-bit and Zbb was the
> primary target of the series and nobody asked about the other cases.
>=20
> There is pretty much only this code and the bitops optimization in the
> kernel that try to do anything extreme for the sake of performance.
> These checksum functions are very critical to performance as these
> checksums are computed on every network packet that is received by the
> kernel. Networking drivers rely on these functions and they need to be
> as fast as possible. 50% improvement is very good even if it's only
> qemu.
>=20
> We could just say we don't care about performance if you are running
> 32-bit linux or don't have Zbb, but we would be making that decision
> because we don't feel like maintaining the code. The code was written,
> tested, reviewed, and it provided large performance gains. I fail to
> understand why this is a burden to maintain.

Maybe if you read what I wrote you'd see what I was getting at, or maybe
not as I might not have been sufficiently clear. I'm not saying that this
particular optimisation is not worth having, but rather than I wanted to
see why this particular optimisation was worth maintaining 3 code paths
for but the commit message does not detail any of the benefits, and
looking at the cover I discovered that it was not tested in hardware nor
seemingly with a real test case.
I am saying that the future standard should require both of those things,
not that I think your optimisation is not worthwhile and should therefore
be thrown out.

Hope that helps,
Conor.

--UsyF7h4OVwtBkffN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj1JYgAKCRB4tDGHoIJi
0jSZAQCjxGD+rECe8QH48LKnrjN84x50ogXkkRnw9zhscMf50wD/YxwAUp8+fjAx
feEqZl9tzlOLBJZep5VY9fmnpdLIEQo=
=wUyu
-----END PGP SIGNATURE-----

--UsyF7h4OVwtBkffN--

