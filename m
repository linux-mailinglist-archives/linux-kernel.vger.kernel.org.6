Return-Path: <linux-kernel+bounces-175052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E668C199D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488EB1F22D3B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9E12D1E0;
	Thu,  9 May 2024 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HXLUf3Tk"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061312D209
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295319; cv=none; b=hz6YZBG8WeKWiQyibr05Oxc5Sk1ZBh6vEBBqk/JtH/GOqQc1VwY++1aZce0qG0MiT36FUen0KgM/c0bKnvQhTURnIlqSn2KrcBHO8t+Dz5dSNw8ABckLzMt9TWKsu5j103MoeVoZpmmwI6ep6OlxJYSJfel+uqju6VH8vLyUBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295319; c=relaxed/simple;
	bh=8OwT9R9WeMp0H2JJ18JLMbfZRaGWcJ3wqM6n/apnk/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMlQUs7FENmpW65+KYploHHE93K4p1B8QUXpVwN96lXj17SiNVuCArzk0MAVKC7tnPGUloyy3Ngd/41DSUFlsPjuScwvO/BVvCGqPQn7RowVnLuCNhRoOuOa8NELjlNAB2RfAVZd3+yFpr5nW87hIwMC2uL8DXoH0Dx/mgd6Ciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HXLUf3Tk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso1315041b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715295316; x=1715900116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eu5Mej2H1ai5OU3q5e1PLVD6XX6aJfH4yB34qW6PVtM=;
        b=HXLUf3TkmQlFq66VDfJw7GWTQSBpm+E//lgE0K8qpVHGSUrppQGSh1ngZGnGvw4wdV
         A9/Rep+U3cKvbMSwwdD3b7mWNRKERKieRXXkuAKNGZbQ3t96jKas4u9fZCADXJuIfKe0
         fHP1majZLx2qBdxV2TPAk9u5guxe+JYKNsgfXCOuyNbpcvZItLJBlvjbDCZsuqk1gBoG
         fbEKP18DWHwlfAvszNEDG4EJodmNaNfB4hWBtcjGzN+Ms8MKXGcrvoMIXlNL8FP6OYOZ
         H96r/Nlu6h2/3S6f2EEtX2DdcD47fBfqnSAzkc/LbleEmeOILeZJBwweZZhHZdKdVl+k
         2OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715295316; x=1715900116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eu5Mej2H1ai5OU3q5e1PLVD6XX6aJfH4yB34qW6PVtM=;
        b=ZTA+i5nt/mimmVSLkT6AE77BaxXeh2/CVgNDdIoA3hKk4bEAwnFEZmgyFa20g7ukTI
         pMtkxjgu3erTIApmztAUuwPCYde8QDsTh1uT+gCcvHf57ngu9cdOXV+SFaWWxtTBeJto
         hn3So3lzm4uw4xd4v6SDBjIDpjCbhORnbt3oZ4NlT6CANM5iF59v9TPdpUORVNBdYzNV
         TuISNQzQD8lJAWEAVPmUh0BwGkLqTyyBvhQRb/ha0nh8+Ml16KZTb17FTTmhEZDyvDeI
         5/0iczyWlFmnrjhepEA5Wz0iPq7bV1lL7tCFj6zSwfMV1NqPhQM811m0T1tFpkpvRTRk
         f6mg==
X-Forwarded-Encrypted: i=1; AJvYcCU7m4cDOa0TOj+LkXSdFbsVfayroeSaPNia+Fdai1YZFN0iyGWba9D1wNyh0mvNnTeycbPxzhw+/1yCj0pF1uaGoUm10YucqoVUAxip
X-Gm-Message-State: AOJu0YzqixokeKyaHyTZW5vbGoedrVpghGCjbRDGpYkRvzkRgEPAGQt1
	iOLvNEI/gq+jcHlGJUnZW7+3cgaoLrKXzjQsXinnta19NwzIyK5r1faPc7wNTYU=
X-Google-Smtp-Source: AGHT+IHhcqlc/9uc+42yJUpBS0mUXfMgHLDsJw6mnEBMha0w59awAWv4LPy0XGgtfdc5JH2jgdu07A==
X-Received: by 2002:a05:6a20:7285:b0:1af:ce5e:ca5e with SMTP id adf61e73a8af0-1afde0b0de0mr1482210637.22.1715295316177;
        Thu, 09 May 2024 15:55:16 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:3668:6b5b:d71d:2683])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a8146csm1811936b3a.50.2024.05.09.15.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 15:55:15 -0700 (PDT)
Date: Thu, 9 May 2024 15:55:12 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
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
Message-ID: <Zj1UUIY8RYV1kJLM@ghost>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240509-uptown-aging-5bdec4730d70@spud>
 <Zj09IUE5k1EJL08X@ghost>
 <20240509-google-passing-3e7577235c44@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509-google-passing-3e7577235c44@spud>

On Thu, May 09, 2024 at 11:08:34PM +0100, Conor Dooley wrote:
> On Thu, May 09, 2024 at 02:16:17PM -0700, Charlie Jenkins wrote:
> > On Thu, May 09, 2024 at 09:25:10PM +0100, Conor Dooley wrote:
> > > On Tue, May 07, 2024 at 06:36:26PM -0700, Charlie Jenkins wrote:
> > > > The kernel currently has the restriction that it can only be compiled
> > > > with the extensions that are hardcoded in arch/risc/Makefile.
> > > > 
> > > > Any extension that is not listed in the Makefile can still be used by
> > > > explicitly writing the assembly and using alternative patching.
> > > > 
> > > > This series introduces Kconfig options that allow the kernel to be
> > > > compiled with additional extensions.
> > > > 
> > > > The motivation for this patch is the performance improvements that come
> > > > along with compiling the kernel with these extra instructions. Allowing
> > > > the compiler to emit arbitrary Zb* instructions achieves a 4.9%
> > > > reduction of dynamic instruction count for a test ran in Spike that
> > > > boots the kernel and runs a user space program that prints to the
> > > > console.
> > > > 
> > > > Additionally, alternatives that check if an extension is supported can
> > > > be eliminated when the Kconfig options to assume hardware support is
> > > > enabled.
> > > 
> > > I brought this up yesterday at the weekly patchwork call and meant to
> > > reply here yesterday, but I didn't get a chance to. I'll start off with
> > > my thoughts on the idea and the implementation and then mention some of
> > > what was said at the call.
> > > 
> > > Firstly, I don't like an implementation of this behaviour that requires
> > > doing ifdeffery around alternative sites. I think that iff this is done,
> > > the alternative itself should be evaluated at compile time, rather than
> > > having to add more decoration to callsites. That becomes particular
> > > important in the cases where the alternative may not be a simple a or b
> > > case, although I don't think there are any of those in the extensions
> > > you've looked at so far - or at least, you've not tackled those cases.
> > > 
> > > I am curious about the Svpbmt patch, as you say
> > > > Svpbmt would not benefit from having PLATFORM_SUPPORTS_RISCV_ISA_SVPBMT
> > > > so just move the definition of RISCV_ISA_SVPBMT to Kconfig.isa.
> > > without any any justification for why it would not benefit. There's
> > > alternatives in the codebase right now for Svpbmt, why wouldn't those
> > > get evaluated at build time also? Or why not Zicbom? Was your rationale
> > > for the extensions chosen just the ones that the compiler can actually
> > > generate code for?
> > 
> > It's only used in a place that has errata so I wasn't sure how to
> > handle that.
> > 
> > > That aside, the series seems to address the easiest parts of doing
> > > compile-time extension configuration rather than the messier cases like
> > > Zicbom. To me it seems like the messier cases is actually where we should
> > > be starting, so that we have a scheme that works well.
> > 
> > That's good advice. I wanted to send out something to start the
> > conversation on what people were interested in optimizing here. I can
> > look more into Zicbom.
> > 
> > > 
> > > Ben mentioned something along the same lines for the
> > > has_extension_likely() stuff, which should be far simpler, and can be
> > > implemented via a macro, as you already pointed out.
> > 
> > I was hesistant to change "too much" as I was expecting push back and
> > didn't want to have to re-write everything ;)
> > 
> > > 
> > > I did notice that you left the riscv_isa_extension_available() stuff
> > > alone. I think that's reasonable as that code serves more than one
> > > purpose and is intended for use in either in probe functions where
> > > there's no perf (or even code-size impact really, just disable the
> > > driver if you don't want it) or in cases where the user provides its own
> > > bitmap, like KVM.
> > > 
> > > I haven't actually reviewed the content line by line yet, so I don't
> > > have any detailed comment on any patches, but I think the two things
> > > being done here deserve to be split apart - the first element is
> > > evaluating things that are using alternatives at build time and the
> > > other is adding extensions to the toolchain's march.
> > 
> > That will double the size of the series but if you think that's better
> > than I can do that.
> > 
> > >
> > > Moving onto the objection to the series that I have though, at least at
> > > the moment. Adding more and more optimisations to the kernel already has
> > > potential to balloon to silly levels, and that's before we even consider
> > > the permutations of different build-time options. Both of those things
> > > feel like "where does it stop?" situation, with every single extension
> > > that could have code-gen impact becoming another build-time option for
> > > the kernel. As a result, I'm not convinced that we should do this at all,
> > > and I am starting to wonder about some of stuff that we have already
> > > merged..
> > > 
> > 
> > Vendors that expect a high level of performance need a way to be able to
> > compile the kernel with more extensions than the base extensions. We are
> > leaving 5% that can easily be gained by not allowing this.
> 
> Maybe we are, but if people want their 5% they need to show up with
> evidence that there is actually 5% to be gained. Also, if you read on, I
> am not saying we should never do this, and leave that 5% permanently on
> the table, only that we should significantly constrain the permutations
> that we are allowing. And honestly, if some vendor is really desperate to
> compile the kernel with Zxy in march but not whatever other extensions
> that may be in a profile's mandatory set, they can always do it out of
> tree. Carrying a single out of tree patch is nothing to most vendors...

My impression is that every vendor will want this, so it makes sense to
have this be a standard option. Internally to Rivos we test with
additional extensions hard-coded to append to march. That is obviously not
something that should be upstreamed. We can continue to carry this hack,
but I want something that is standardized that all vendors can use.

> 
> > > I don't think the configurability this series adds is worth the burden of
> > > maintaining support for all the various configurations you're proposing
> > > here (and the others that someone will come along with the week after
> > > this would be merged. After all, with extant hardware that distros are
> > > supporting, albeit in developer or bring-up type builds, one of these
> > > options could even be enabled. Which I suppose could be translated to
> > > a NAK from me on doing something like this at the moment...
> > 
> > By migrating everything into more refined macros I think I can ease this
> > burden. I don't see this as a burden, these options are all so closly
> > tied to each other
> 
> What does "closely tied to each other" actually mean?

Assuming that the hardware has an extension vs the hardware may support
an extension vs the hardware doesn't support an extension. It adds 2
additional options since the existing code only checks if the hardware
may support the extension. However, these two additional options do not
add significant more complexity. That's what I meant by closely tied to
each other.

> 
> > and only matter when a kernel developer explicitly
> > wants to use an extension.
> 
> Unless your definition of "kernel developer" extends to "people that
> compile their own kernel based on menuconfig", then I don't think you
> and I are on the same page about what the series actually does.
> Remember, there's the making alternatives and other optimisations
> unconditional /and/ the addition of stuff to march going on in this
> series.

True, I was referring to the alternatives when I said that.

> 
> > If this is all wrapped up into the macros
> > that check if an extension is available it won't even be an extra step
> > than what it currently is.
> > 
> > > Palmer suggested in the weekly call that what would make more sense is
> > > having established bases, that align with what distros are likely to
> > > ship, which probably means something approximating the mandatory set for
> > > profiles, although he also said that the rva23 profiles had already been
> > > given the kibosh by folks. He'll have to provide more information on
> > > that one though.
> > > I think that that seems like a sane approach, as it would produce a far
> > > more limited set of combinations to maintain, but it also means not doing
> > > something like this until the point that distros commit to some specific
> > > set of extensions that is not rv64gc... As well as reducing the
> > > combinations that we need to reason about as developers, I think that the
> > > "user story" for people deciding what is worth enabling in their kernel
> > > config before simpler too.
> > 
> > There is a chicken and the egg problem here. The
> > hardware/software/distros all want to support the same thing. Somebody
> > needs to step up and make a decision. With a patch like this, a distro
> > can see all of the functionality and select what they want. This can
> > then be rolled up into a config that selects something like all of the
> > bitmanip options.
> 
> I don't think there's a chicken and egg problem, or at least not one
> that kernel config options for every extension solves. I expect distros
> to work with RVI to define something, which may well be the platform
> spec (hopefully it's the platform spec...) and then we can make that a
> config option.

I'll wait for Palmer to weigh in but I see no reason to wait for that
since right now we can get the performance improvement. This won't be
merged into 6.10, and 6.11 won't be released for a couple of months so
we are looking at a timeline in the future anyway but I wanted to start
the conversation now.

> 
> > > * Something else that came up during that call, and I think it was
> > > Palmer's suggestion was having a hard think about what we are
> > > currently accepting optimisations for in the kernel. I think we need to
> > > up the "burden of proof" for what we will merge optimisations for to
> > > things that are demonstrated to have significant benefits. I don't mean
> > > to single you out here, cos I did ack the patch after all and it was
> > > just the random example I stumbled on this evening while looking at some
> > > alternative users in the course of writing a reply here. Take this code
> > > for example:
> > > 
> > > 	/*
> > > 	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
> > > 	 * worth checking if supported without Alternatives.
> > > 	 */
> > > 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > > 	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > > 		unsigned long fold_temp;
> > > 
> > > 		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > > 					      RISCV_ISA_EXT_ZBB, 1)
> > > 		    :
> > > 		    :
> > > 		    :
> > > 		    : no_zbb);
> > > 
> > > 		if (IS_ENABLED(CONFIG_32BIT)) {
> > > 			asm(".option push				\n\
> > > 			.option arch,+zbb				\n\
> > > 				not	%[fold_temp], %[csum]		\n\
> > > 				rori	%[csum], %[csum], 16		\n\
> > > 				sub	%[csum], %[fold_temp], %[csum]	\n\
> > > 			.option pop"
> > > 			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > > 		} else {
> > > 			asm(".option push				\n\
> > > 			.option arch,+zbb				\n\
> > > 				rori	%[fold_temp], %[csum], 32	\n\
> > > 				add	%[csum], %[fold_temp], %[csum]	\n\
> > > 				srli	%[csum], %[csum], 32		\n\
> > > 				not	%[fold_temp], %[csum]		\n\
> > > 				roriw	%[csum], %[csum], 16		\n\
> > > 				subw	%[csum], %[fold_temp], %[csum]	\n\
> > > 			.option pop"
> > > 			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > > 		}
> > > 		return (__force __sum16)(csum >> 16);
> > > 	}
> > > 
> > > The comment there made me think as to why we even have this optimisation
> > > for Zbb at all - is the saving of 3 - 1 or 5 - 1 instructions actually
> > > worth having 3 code paths? The commit message for this contains no
> > > information on the performance benefit of the code at, and while the cover
> > > letter has some information, it was not actually tested in hardware and
> > > does not look to be a real-word benchmark. This one is already merged,
> > > but something like this in the future would really need to be subjected to
> > > significantly more scrutiny! At the very least, "optimisations" need to be
> > > proved to be beneficial in hardware.
> > 
> > I put the justification in the cover letter of the series:
> 
> If you read what I wrote I acknowledge that there's info in the cover,
> but if you continue reading you'll note I said that "it was not tested
> in hardware and does not look to be a real-word [sic] benchmark".

I wanted to copy what I said in the cover letter here for other readers
to see. It's not "real world" but it tests the functions which use the
optimizations. The functions that are being optimized are 50% faster and
that's the benefit.

> 
> > "Tested on QEMU, this series allows the CHECKSUM_KUNIT tests to complete
> > an average of 50.9% faster."
> > 
> > I did a lot of testing locally to ensure that every combination was as
> > performant as it possibly could be. I did not provide numbers for every
> > case simply because the combination with 64-bit and Zbb was the
> > primary target of the series and nobody asked about the other cases.
> > 
> > There is pretty much only this code and the bitops optimization in the
> > kernel that try to do anything extreme for the sake of performance.
> > These checksum functions are very critical to performance as these
> > checksums are computed on every network packet that is received by the
> > kernel. Networking drivers rely on these functions and they need to be
> > as fast as possible. 50% improvement is very good even if it's only
> > qemu.
> > 
> > We could just say we don't care about performance if you are running
> > 32-bit linux or don't have Zbb, but we would be making that decision
> > because we don't feel like maintaining the code. The code was written,
> > tested, reviewed, and it provided large performance gains. I fail to
> > understand why this is a burden to maintain.
> 
> Maybe if you read what I wrote you'd see what I was getting at, or maybe
> not as I might not have been sufficiently clear. I'm not saying that this
> particular optimisation is not worth having, but rather than I wanted to

I seem to frequently give you the impression that I don't read what you
say before responding. What we each view as "important" in the kernel is
different so we come from different places when approaching a problem. I
respond in the way that I do not because I am not listening to you, but
simply because I have a different opinion and I am not explaining that
properly.

> see why this particular optimisation was worth maintaining 3 code paths

I interpreted the "3 code paths" as with Zbb + 64 bit, with Zbb + 32
bit, and without Zbb. I directly responded to that by saying that we
could eliminate all of the code paths that are not Zbb + 64 bit could be
eliminated. I should have given performance numbers for these alternate
cases too, and somebody should have asked. I agree that performance
needs justification, and I understand that I did not provide ample
justification in this patch. All other architectures optimized these
code paths so I figured that was sufficient justification for riscv to
do the same, but I understand that it is not.

> for but the commit message does not detail any of the benefits, and
> looking at the cover I discovered that it was not tested in hardware nor
> seemingly with a real test case.

It's hard when riscv currently is very focused on microcontrollers.
These changes are in order to help future hardware that is more focused
about performance. That's why I contribute this upstream with the hope
that other people, like me, care about performance. Rivos could carry
all of these performance patches internally, but if they already exist
why not let other vendors use them too?

- Charlie

> I am saying that the future standard should require both of those things,
> not that I think your optimisation is not worthwhile and should therefore
> be thrown out.
> 
> Hope that helps,
> Conor.



