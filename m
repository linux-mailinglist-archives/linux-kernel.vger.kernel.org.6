Return-Path: <linux-kernel+bounces-194730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326FA8D4120
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5414B1C211CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E231CB306;
	Wed, 29 May 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiqBUDn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B111CB302;
	Wed, 29 May 2024 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020542; cv=none; b=BkENQ/pdHIEwlchMpL7c3jkShFXBKA8kA3RgFGAu7Ry+8sG83ukT4OUWbPR+lYIQZroplJmC7lU+f3EyzbjbXlZlGBxcAZEws/wg1BOHjOMsjnZp0DYJyp+v3v5J93dQZXsSPi6zGjRYRdamRsrgTug2rkMdLd2Ff1yHo3yiBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020542; c=relaxed/simple;
	bh=5hJscbHLPraseeS6H0nSdgSUUmKcqeXC1lMt7BU2w4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2QDP3RL0CjdVA15p4s/5rp6grhtidq4KQjlSkq70MFjt4pRzX5w89zdtNaPxSoiQ2djuJTDiPyKH04fTplb2JNrHlJVGC1C0hW+RySLovv6WzspiQ6Ddl0dObCFHDmpRP8NHmkB+y7uDtP0hlzj+ofztTIvPy6scQ4IcH9YqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiqBUDn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70119C32782;
	Wed, 29 May 2024 22:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717020541;
	bh=5hJscbHLPraseeS6H0nSdgSUUmKcqeXC1lMt7BU2w4Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BiqBUDn1idmpEYrYCPGkumQs2VOdUF8LjxdpfFUOymSP9Q/k3Rluw1idu6cc67gSi
	 EGdGQBmOUF8GLMe/TPK5Uo0aX0LAdLhR3WSt3qu9dGC7NIi7ht5yFIphAl0hdypbeX
	 7eB4K3Jor2Lk6aZZ9UImVaIHquTMB9ohiXAqv1x6rUt8l8lzW142ZRMnd/9VMZU9Po
	 gmCK93Gq0N89asm7F/4fY177cn7M4dUW41bQG1LjJBMVVmiHiM5pNswcXAh2z+HXrP
	 PlP4qPyi3s+A01I5+OO5rWP0eLjpCIRpJac/Rn0z1kHaLH8LY7Y7uBqcJTv++wdJei
	 ghZHX8VNqGXcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 05204CE0EE0; Wed, 29 May 2024 15:09:00 -0700 (PDT)
Date: Wed, 29 May 2024 15:09:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
Message-ID: <5567ab2e-80af-4c5f-bebb-d979e8a34f49@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240503081125.67990-1-arnd@kernel.org>
 <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk>
 <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>

On Wed, May 29, 2024 at 07:50:28PM +0100, Maciej W. Rozycki wrote:
> On Tue, 28 May 2024, Paul E. McKenney wrote:
> 
> > > > > This topic came up again when Paul E. McKenney noticed that
> > > > > parts of the RCU code already rely on byte access and do not
> > > > > work on alpha EV5 reliably, so I refreshed my series now for
> > > > > inclusion into the next merge window.
> > > > 
> > > > Hrrrm? That sounds like like Paul ran tests on EV5, did he?
> > > 
> > >  What exactly is required to make it work?
> > 
> > Whatever changes are needed to prevent the data corruption that can
> > currently result in code generated by single-byte stores.  For but one
> > example, consider a pair of tasks (or one task and an interrupt handler
> > in the CONFIG_SMP=n case) do a single-byte store to a pair of bytes
> > in the same machine word.  As I understand it, in code generated for
> > older Alphas, both "stores" will load the word containing that byte,
> > update their own byte, and store the updated word.
> > 
> > If two such single-byte stores run concurrently, one or the other of those
> > two stores will be lost, as in overwritten by the other.  This is a bug,
> > even in kernels built for single-CPU systems.  And a rare bug at that, one
> > that tends to disappear as you add debug code in an attempt to find it.
> 
>  Thank you for the detailed description of the problematic scenario.
> 
>  I hope someone will find it useful, however for the record I have been 
> familiar with the intricacies of the Alpha architecture as well as their 
> implications for software for decades now.  The Alpha port of Linux was 
> the first non-x86 Linux platform I have used and actually (and I've chased 
> that as a matter of interest) my first ever contribution to Linux was for 
> Alpha platform code:
> 
> On Mon, 30 Mar 1998, Jay.Estabrook@digital.com wrote:
> 
> > Hi, sorry about the delay in answering, but you'll be happy to know, I took
> > your patches and merged them into my latest SMP patches, and submitted them
> > to Linus just last night. He promises them to (mostly) be in 2.1.92, so we
> > can look forward to that... :-)
> 
> so I find the scenario you have described more than obvious.

Glad that it helped.

>  Mind that the read-modify-write sequence that software does for sub-word 
> write accesses with original Alpha hardware is precisely what hardware 
> would have to do anyway and support for that was deliberately omitted by 
> the architecture designers from the ISA to give it performance advantages 
> quoted in the architecture manual.  The only difference here is that with 
> hardware read-modify-write operations atomicity for sub-word accesses is 
> guaranteed by the ISA, however for software read-modify-write it has to be 
> explictly coded using the usual load-locked/store-conditional sequence in 
> a loop.  I don't think it's a big deal really, it should be trivial to do 
> in the relevant accessors, along with the memory barriers that are needed 
> anyway for EV56+ and possibly other ports such as the MIPS one.

There shouldn't be any memory barriers required, and don't EV56+ have
single-byte loads and stores?

>  What I have been after actually is: can you point me at a piece of code 
> in our tree that will cause an issue with a non-BWX Alpha as described in 
> your scenario, so that I have a starting point?  Mind that I'm completely 
> new to RCU as I didn't have a need to research it before (though from a 
> skim over Documentation/RCU/rcu.rst I understand what its objective is).

See the uses of the fields of the current->rcu_read_unlock_special.b
anonymous structure for the example that led us here.  And who knows how
many other pieces of the Linux kernel that assume that it is possible
to atomically store a single byte.

Many of which use a normal C-language store, in which case there are
no accessors.  This can be a problem even in the case where there are no
data races to either byte, because the need for the read-modify-write
sequence on older Alpha systems results in implicit data races at the
machine-word level.

>  FWIW even if it was only me I think that depriving the already thin Alpha 
> port developer base of any quantity of the remaining manpower, by dropping 
> support for a subset of the hardware available, and then a subset that is 
> not just as exotic as the original i386 became to the x86 platform at the 
> time support for it was dropped, is only going to lead to further demise 
> and eventual drop of the entire port.

Yes, support has been dropped for some of the older x86 CPUs as well,
for example, Linux-kernel support for multiprocessor 80386 systems was
dropped a great many years ago, in part because those CPUs do not have
a cmpxchg instruction.  So it is not like we are picking on Alpha.

>  And I think it would be good if we kept the port, just as we keep other 
> ports of historical significance only, for educational reasons if nothing 
> else, such as to let people understand based on an actual example, once 
> mainstream, the implications of weakly ordered memory systems.

I don't know of any remaining issues with the newer Alpha systems that do
support single-byte and double-byte load and store instructions, and so
I am not aware of any reason for dropping Linux-kernel support for them.

							Thanx, Paul

