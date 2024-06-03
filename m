Return-Path: <linux-kernel+bounces-199487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C48D87A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAF11C220C9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5A2136E05;
	Mon,  3 Jun 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDwZsFpv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5F12EBCA;
	Mon,  3 Jun 2024 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434488; cv=none; b=IBl1lenet09ua/9ZRpsL5MXydGceAWkrBEebDy04X4jSXBkt6tNM3CIjvdwKQAQIZ68sHuRHTcQJnfuRZcMsQZyok1wL1oPOrTS2wuNiGC93SDRfCCZZFvhJ5CmqqucE+64f7oGUfZnE9vSewKdb3j3sN6fHcEZE1UjXmRNxTI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434488; c=relaxed/simple;
	bh=cLnmKG8NKO56KLhkrN1VR7uquGFk+bVXu8nCVoIpB7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QREkznxC+7ndGJyiCU2mT/+GRj71GguoYtKPjv5pQ4hvlQ8//vVlsu3Jt+OUUlBUcRWJavsgL3Meyducb77uBy/oxt3Z7AwUqJ/5xAKIAKCfFZZVcHvt6L5iK7u+BA8EH4nzg98v+fviT04TXz9MgxQXnHIAvdKNkJ1BXntNTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDwZsFpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB43C2BD10;
	Mon,  3 Jun 2024 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717434487;
	bh=cLnmKG8NKO56KLhkrN1VR7uquGFk+bVXu8nCVoIpB7M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oDwZsFpvT1WQyJ4m8UuvFKSx1RqyDaVnMgSisqgjdieDr8x9U57zcxWgqbe/KmLuo
	 x75dgb8yn9u/coMkYUmiqCuTdvq6cGONhzFLg1c8jtU/tE9PaSYbtsU4/xvcQiQws6
	 qvjRyAFWnQWipR3seemEk5jwOqarNAGeG9AVgS15hzTiHieWBfKa7u4YteoD6YrLtI
	 C20hcCXCfcLfeKFDOthgbjsKU7udPNepuOXzbYDnYYElw1GZ1JLfLeEfegTPa/QRHZ
	 bAPFVz8bia+/lG7RH4qEx5SpH72FiDNmRAFdfJz7Y4ykkMsDN9xFmJHuK/StCtbank
	 Oo0dWxC9eOF5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 704A0CE3B76; Mon,  3 Jun 2024 10:08:07 -0700 (PDT)
Date: Mon, 3 Jun 2024 10:08:07 -0700
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
Message-ID: <12a3f8ac-c542-4065-a464-fc246e355d1d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240503081125.67990-1-arnd@kernel.org>
 <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk>
 <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>
 <5567ab2e-80af-4c5f-bebb-d979e8a34f49@paulmck-laptop>
 <alpine.DEB.2.21.2405310432190.23854@angie.orcam.me.uk>
 <7b0a434c-2165-45a0-8507-e7f992094705@paulmck-laptop>
 <alpine.DEB.2.21.2406031716490.9248@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2406031716490.9248@angie.orcam.me.uk>

On Mon, Jun 03, 2024 at 05:22:22PM +0100, Maciej W. Rozycki wrote:
> On Fri, 31 May 2024, Paul E. McKenney wrote:
> 
> > >  You're the RCU expert so you know the answer.  I don't.  If it's OK for
> > > successive writes to get reordered, or readers to see a stale value, then 
> > > you don't need memory barriers.  Otherwise you do.  Whether byte accesses 
> > > are available or not does not matter, the CPU *will* do reordering if it's 
> > > allowed to (or more specifically, it won't do anything to prevent it from 
> > > happening, especially in SMP configurations; I can't remember offhand if 
> > > there are cases with UP).  Also adjacent byte writes may be merged, but I 
> > > suppose it does not matter, or does it?
> > 
> > RCU uses whichever wrapper is required.  For example, if ordering is
> > required, it might use smp_store_release() and smp_load_acquire().
> > If ordering does not matter, it might use WRITE_ONCE() and READ_ONCE().
> > If tearing/fusing/merging does not matter, as in there are not concurrent
> > accesses, it uses plain C-language loads and stores.
> 
>  Fair enough.
> 
> > >  NB MIPS has similar architectural arrangements (and a bunch of barriers 
> > > defined in the ISA), it's just most implementations are actually strongly 
> > > ordered, so most people can't see the effects of this.  With MIPS I know 
> > > for sure there are cases of UP reordering, but they only really matter for 
> > > MMIO use cases and not regular memory.
> > 
> > Any given architecture is required to provide architecture-specific
> > implementations of the various functions that meet the requirements of
> > Linux-kernel memory model.  See tools/memory-model for more information.
> 
>  This is a fairly recent addition, thank you for putting it all together.  
> I used to rely solely on Documentation/memory-barriers.txt.  Thanks for 
> the reference.

It has been in the kernel since April 2018, but OK.  And a big "thank you"
to all the people who made this possible and who continue contributing
to it.  And Documentation/memory-barriers.txt still matters, though the
long-term goal is for it to be subsumed into tools/memory-model.  Things
like compiler optimizations make this difficult, but not impossible.

Another precaution is to ensure that any contraints of a non-common-case
architecture be tested for.  For example, if I add a 64-bit divide, I
get yelled at promptly.  In contrast, that long list of byte accesses
that Arnd posted were suffered in silence.  So they accumulated well
past the point where they can reasonably be backed out.

							Thanx, Paul

