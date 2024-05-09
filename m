Return-Path: <linux-kernel+bounces-174973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352A98C1829
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD92B20CF6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B2284FBC;
	Thu,  9 May 2024 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="beAhfGBX"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353380034
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289384; cv=none; b=oYlmoSpvJ3nV3TgjPYXV9AJgAkif1YRZl/5OVEBtchFdAAWUTON5lxRLKeKqFDbAnJC/XZb/rW+ZlVN5ps1b01eDWM8kd7WgDUXVJBEMZgMt1HKj7G7BsqD8o7sZqUDZGPkQSFS9o8r5oqgTnw3i/xnsdRDHC0L9QFTJKSRoY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289384; c=relaxed/simple;
	bh=xYf+guDhlgJMVbpiTSeHjwwwZiWqu9X3yAfFMIyvs8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFPvGf5jarellBUUHUd5fzuQ4KWxXJDM/TqzEZGPWju/POiBbRUq1L9YHVrQgTx4WPafT2leCs2kYJzIRPKqcyUVEznMND+HmXRaYB4Bu+/dKAwlMWRRZWP8bZYtWyTOfVxZic6PvfC/Aa+qlB0/ygL+rn66xbvhSbLkR9GRhcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=beAhfGBX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-628a551d10cso1006891a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715289381; x=1715894181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtrpmPs/8tWjRF/kXS6kBYaf57q1eTrsr00lK1K2fwo=;
        b=beAhfGBXO7fiGUHhqENKu9/71d4bjy/KUpEQi55ydz/FsjhKQlk7XAWKdrXlQ70BNc
         TiWZZL9c9hBHHnbg0IapWbmljjKwyz8y/a/9iflk/swn2lxRjygV+vfBgXyLJhczkkSL
         69KleuIw23ZTU0Rcq+Nq67fQBOAPlr2wCbVplcNzjlJGObt7xrrpssA0G4EcVWe5ZTT/
         vTCO+hK1obkX1TiRRxUrApc77FA83Rz0leVCSa0CudozvXzVYwtAJy0qeqh1JLBp5cLe
         bOSAp4RLaFblI4+pCce2pP7xuWxmI2aoKLViHVkrJbs89JCLHhgsFJYSfO0ctJDziHWG
         HuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289381; x=1715894181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtrpmPs/8tWjRF/kXS6kBYaf57q1eTrsr00lK1K2fwo=;
        b=l8FNr5KWL8FG7SMFeMdAnTLQvVCPlYxamU1egnHc4crUCMvU/BxY1Xto7Fgzsnu0Jp
         eUR3FUg4lrB+HFXghK0qSTxmgJ2eXpxiqwKjuZDLrUERemf75qCz/EzvjgnHiyRjDVNh
         N9QePXTy7mVnXZ/brXAsKt5zJo/R1egc+JTKsNayU1LmbSthznfXO1vRv8TaBrEWWSAT
         c4Q+P+XdLNSuGez7f8Epzti+d9P/NkB7LnVMMHsULF/BkJ8QB/e1ypyNrX0jsN22au/B
         hC0jD/jfnQkkcv4TXCaeCxg3UFH83BPCa4mrpfPUlRTJnzuKHiSoc1vf+YStuQ+WuqiQ
         07Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWOUVDz4eC9XpRc3ewVmy/FZvgfyQPTg70PYuh2jF2jrnF4S/cnI+13Om1RCQATUcniQBoK8LFY0vX9Hkv4UjM1rIe5Cffs/4k4ynUq
X-Gm-Message-State: AOJu0Ywz2ckx4jH7l3PPmlPWEa0lyprbLTaZSuF/rVN9KqUNB4LQCP0S
	6H2/wSgP8axVbfsPnK9Yx9cFcW3C96rusG2zvjZj9Yei7ff23vkzxVmJ56qK+bQ=
X-Google-Smtp-Source: AGHT+IHWAM1NQAisbSoFl3DqX2pmOe5hG2saLWkI1jbMADpZg5qPqsRMf5AT6IKOFvfnMFU1diTshw==
X-Received: by 2002:a17:90a:c7d1:b0:2b6:2067:dde0 with SMTP id 98e67ed59e1d1-2b6cc342832mr778629a91.5.1715289381313;
        Thu, 09 May 2024 14:16:21 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:3668:6b5b:d71d:2683])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62884a265sm3820721a91.19.2024.05.09.14.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 14:16:20 -0700 (PDT)
Date: Thu, 9 May 2024 14:16:17 -0700
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
Message-ID: <Zj09IUE5k1EJL08X@ghost>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240509-uptown-aging-5bdec4730d70@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509-uptown-aging-5bdec4730d70@spud>

On Thu, May 09, 2024 at 09:25:10PM +0100, Conor Dooley wrote:
> Hey Charlie,
> 
> Don't mean to subject you to a rant here, but that's kinda what it seems
> to have become. I wish the Zbb example I use below was something someone
> else had written, so that it doesn't feel like I am tryna kick you while
> you're down, but that was the thing I happened across this evening :/

Don't feel bad! I wrote it so I can take it :)

> 
> On Tue, May 07, 2024 at 06:36:26PM -0700, Charlie Jenkins wrote:
> > The kernel currently has the restriction that it can only be compiled
> > with the extensions that are hardcoded in arch/risc/Makefile.
> > 
> > Any extension that is not listed in the Makefile can still be used by
> > explicitly writing the assembly and using alternative patching.
> > 
> > This series introduces Kconfig options that allow the kernel to be
> > compiled with additional extensions.
> > 
> > The motivation for this patch is the performance improvements that come
> > along with compiling the kernel with these extra instructions. Allowing
> > the compiler to emit arbitrary Zb* instructions achieves a 4.9%
> > reduction of dynamic instruction count for a test ran in Spike that
> > boots the kernel and runs a user space program that prints to the
> > console.
> > 
> > Additionally, alternatives that check if an extension is supported can
> > be eliminated when the Kconfig options to assume hardware support is
> > enabled.
> 
> I brought this up yesterday at the weekly patchwork call and meant to
> reply here yesterday, but I didn't get a chance to. I'll start off with
> my thoughts on the idea and the implementation and then mention some of
> what was said at the call.
> 
> Firstly, I don't like an implementation of this behaviour that requires
> doing ifdeffery around alternative sites. I think that iff this is done,
> the alternative itself should be evaluated at compile time, rather than
> having to add more decoration to callsites. That becomes particular
> important in the cases where the alternative may not be a simple a or b
> case, although I don't think there are any of those in the extensions
> you've looked at so far - or at least, you've not tackled those cases.
> 
> I am curious about the Svpbmt patch, as you say
> > Svpbmt would not benefit from having PLATFORM_SUPPORTS_RISCV_ISA_SVPBMT
> > so just move the definition of RISCV_ISA_SVPBMT to Kconfig.isa.
> without any any justification for why it would not benefit. There's
> alternatives in the codebase right now for Svpbmt, why wouldn't those
> get evaluated at build time also? Or why not Zicbom? Was your rationale
> for the extensions chosen just the ones that the compiler can actually
> generate code for?

It's only used in a place that has errata so I wasn't sure how to
handle that.

> That aside, the series seems to address the easiest parts of doing
> compile-time extension configuration rather than the messier cases like
> Zicbom. To me it seems like the messier cases is actually where we should
> be starting, so that we have a scheme that works well.

That's good advice. I wanted to send out something to start the
conversation on what people were interested in optimizing here. I can
look more into Zicbom.

> 
> Ben mentioned something along the same lines for the
> has_extension_likely() stuff, which should be far simpler, and can be
> implemented via a macro, as you already pointed out.

I was hesistant to change "too much" as I was expecting push back and
didn't want to have to re-write everything ;)

> 
> I did notice that you left the riscv_isa_extension_available() stuff
> alone. I think that's reasonable as that code serves more than one
> purpose and is intended for use in either in probe functions where
> there's no perf (or even code-size impact really, just disable the
> driver if you don't want it) or in cases where the user provides its own
> bitmap, like KVM.
> 
> I haven't actually reviewed the content line by line yet, so I don't
> have any detailed comment on any patches, but I think the two things
> being done here deserve to be split apart - the first element is
> evaluating things that are using alternatives at build time and the
> other is adding extensions to the toolchain's march.

That will double the size of the series but if you think that's better
than I can do that.

>
> Moving onto the objection to the series that I have though, at least at
> the moment. Adding more and more optimisations to the kernel already has
> potential to balloon to silly levels, and that's before we even consider
> the permutations of different build-time options. Both of those things
> feel like "where does it stop?" situation, with every single extension
> that could have code-gen impact becoming another build-time option for
> the kernel. As a result, I'm not convinced that we should do this at all,
> and I am starting to wonder about some of stuff that we have already
> merged..
> 

Vendors that expect a high level of performance need a way to be able to
compile the kernel with more extensions than the base extensions. We are
leaving 5% that can easily be gained by not allowing this.

> I don't think the configurability this series adds is worth the burden of
> maintaining support for all the various configurations you're proposing
> here (and the others that someone will come along with the week after
> this would be merged. After all, with extant hardware that distros are
> supporting, albeit in developer or bring-up type builds, one of these
> options could even be enabled. Which I suppose could be translated to
> a NAK from me on doing something like this at the moment...

By migrating everything into more refined macros I think I can ease this
burden. I don't see this as a burden, these options are all so closly
tied to each other and only matter when a kernel developer explicitly
wants to use an extension. If this is all wrapped up into the macros
that check if an extension is available it won't even be an extra step
than what it currently is.

> 
> Palmer suggested in the weekly call that what would make more sense is
> having established bases, that align with what distros are likely to
> ship, which probably means something approximating the mandatory set for
> profiles, although he also said that the rva23 profiles had already been
> given the kibosh by folks. He'll have to provide more information on
> that one though.
> I think that that seems like a sane approach, as it would produce a far
> more limited set of combinations to maintain, but it also means not doing
> something like this until the point that distros commit to some specific
> set of extensions that is not rv64gc... As well as reducing the
> combinations that we need to reason about as developers, I think that the
> "user story" for people deciding what is worth enabling in their kernel
> config before simpler too.

There is a chicken and the egg problem here. The
hardware/software/distros all want to support the same thing. Somebody
needs to step up and make a decision. With a patch like this, a distro
can see all of the functionality and select what they want. This can
then be rolled up into a config that selects something like all of the
bitmanip options.

> 
> * Something else that came up during that call, and I think it was
> Palmer's suggestion was having a hard think about what we are
> currently accepting optimisations for in the kernel. I think we need to
> up the "burden of proof" for what we will merge optimisations for to
> things that are demonstrated to have significant benefits. I don't mean
> to single you out here, cos I did ack the patch after all and it was
> just the random example I stumbled on this evening while looking at some
> alternative users in the course of writing a reply here. Take this code
> for example:
> 
> 	/*
> 	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
> 	 * worth checking if supported without Alternatives.
> 	 */
> 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> 	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> 		unsigned long fold_temp;
> 
> 		asm goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> 					      RISCV_ISA_EXT_ZBB, 1)
> 		    :
> 		    :
> 		    :
> 		    : no_zbb);
> 
> 		if (IS_ENABLED(CONFIG_32BIT)) {
> 			asm(".option push				\n\
> 			.option arch,+zbb				\n\
> 				not	%[fold_temp], %[csum]		\n\
> 				rori	%[csum], %[csum], 16		\n\
> 				sub	%[csum], %[fold_temp], %[csum]	\n\
> 			.option pop"
> 			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> 		} else {
> 			asm(".option push				\n\
> 			.option arch,+zbb				\n\
> 				rori	%[fold_temp], %[csum], 32	\n\
> 				add	%[csum], %[fold_temp], %[csum]	\n\
> 				srli	%[csum], %[csum], 32		\n\
> 				not	%[fold_temp], %[csum]		\n\
> 				roriw	%[csum], %[csum], 16		\n\
> 				subw	%[csum], %[fold_temp], %[csum]	\n\
> 			.option pop"
> 			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> 		}
> 		return (__force __sum16)(csum >> 16);
> 	}
> 
> The comment there made me think as to why we even have this optimisation
> for Zbb at all - is the saving of 3 - 1 or 5 - 1 instructions actually
> worth having 3 code paths? The commit message for this contains no
> information on the performance benefit of the code at, and while the cover
> letter has some information, it was not actually tested in hardware and
> does not look to be a real-word benchmark. This one is already merged,
> but something like this in the future would really need to be subjected to
> significantly more scrutiny! At the very least, "optimisations" need to be
> proved to be beneficial in hardware.

I put the justification in the cover letter of the series:

"Tested on QEMU, this series allows the CHECKSUM_KUNIT tests to complete
an average of 50.9% faster."

I did a lot of testing locally to ensure that every combination was as
performant as it possibly could be. I did not provide numbers for every
case simply because the combination with 64-bit and Zbb was the
primary target of the series and nobody asked about the other cases.

There is pretty much only this code and the bitops optimization in the
kernel that try to do anything extreme for the sake of performance.
These checksum functions are very critical to performance as these
checksums are computed on every network packet that is received by the
kernel. Networking drivers rely on these functions and they need to be
as fast as possible. 50% improvement is very good even if it's only
qemu.

We could just say we don't care about performance if you are running
32-bit linux or don't have Zbb, but we would be making that decision
because we don't feel like maintaining the code. The code was written,
tested, reviewed, and it provided large performance gains. I fail to
understand why this is a burden to maintain.

- Charlie

> 
> Anyways, that's my thoughts on this. IIRC it was mainly Palmer and I
> doing the talking about this on the call, with Paul I think having some
> comments. Hopefully Palmer can chime in :)
> 
> Cheers,
> Conor.



