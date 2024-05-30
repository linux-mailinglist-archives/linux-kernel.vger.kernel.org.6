Return-Path: <linux-kernel+bounces-195995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB898D55DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47DB1F235A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CCA183980;
	Thu, 30 May 2024 22:59:31 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B7B17545;
	Thu, 30 May 2024 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109971; cv=none; b=q9QUPeN2tCuETHJLNrtzJVk+MoU0QF6GaKcA8raFDrpPBZ08UfTa4sR0FRnB3yPohzGhjHGJQ0EDpz6Axfhwp3JPulqhNmdZbubmT7LqtzMJMz/6vmxUEn7mWxd4z/rbJ7GRrzc9ovIanJGi73AoY+xTRE5ye5KLP6Hc3sc9mP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109971; c=relaxed/simple;
	bh=m7Sq2rAhdxuGD38L5CCDAZsnrG/N2vhzCA1ZriqAONs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PPy0jECMR8JON59tWa4NZas1KLU8+xi5huvTk/11hRsGmvBI9Qn4hzzG265EvsABCuOzU2JsGnIQUbdYdpUuosJs6nEWLu46kq6TK4diKCG/tMf4yw1jJH8ikvbjJtyLuz+R23rPMGkdgrj+Wm7528vTmfZejLxUOn3zvtXvG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 20C1192009D; Fri, 31 May 2024 00:59:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 1A8BD92009B;
	Thu, 30 May 2024 23:59:27 +0100 (BST)
Date: Thu, 30 May 2024 23:59:27 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org, 
    Arnd Bergmann <arnd@arndb.de>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Marc Zyngier <maz@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>, 
    Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
In-Reply-To: <5567ab2e-80af-4c5f-bebb-d979e8a34f49@paulmck-laptop>
Message-ID: <alpine.DEB.2.21.2405302248550.23854@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <5567ab2e-80af-4c5f-bebb-d979e8a34f49@paulmck-laptop>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 May 2024, Paul E. McKenney wrote:

> >  What I have been after actually is: can you point me at a piece of code 
> > in our tree that will cause an issue with a non-BWX Alpha as described in 
> > your scenario, so that I have a starting point?  Mind that I'm completely 
> > new to RCU as I didn't have a need to research it before (though from a 
> > skim over Documentation/RCU/rcu.rst I understand what its objective is).
> 
> See the uses of the fields of the current->rcu_read_unlock_special.b
> anonymous structure for the example that led us here.  And who knows how
> many other pieces of the Linux kernel that assume that it is possible
> to atomically store a single byte.

 Thanks, that helps.

> Many of which use a normal C-language store, in which case there are
> no accessors.  This can be a problem even in the case where there are no
> data races to either byte, because the need for the read-modify-write
> sequence on older Alpha systems results in implicit data races at the
> machine-word level.

 Ack.

> >  FWIW even if it was only me I think that depriving the already thin Alpha 
> > port developer base of any quantity of the remaining manpower, by dropping 
> > support for a subset of the hardware available, and then a subset that is 
> > not just as exotic as the original i386 became to the x86 platform at the 
> > time support for it was dropped, is only going to lead to further demise 
> > and eventual drop of the entire port.
> 
> Yes, support has been dropped for some of the older x86 CPUs as well,
> for example, Linux-kernel support for multiprocessor 80386 systems was
> dropped a great many years ago, in part because those CPUs do not have
> a cmpxchg instruction.  So it is not like we are picking on Alpha.

 That's what I mentioned (and for the record i386 wasn't dropped for the 
lack of CMPXCHG, as we never supported i386 SMP, exceedingly rare, anyway, 
but for the lack of page-level write-protection in the kernel mode, which 
implied painful manual checks).  At the time our support for the i386 was 
dropped its population outside embedded use was minuscule and certainly 
compared to non-i386 x86 Linux user base.  And the supply of modern x86 
systems was not an issue either.

 Conversely no new Alpha systems are made and I suspect the ratio between 
BWX and non-BWX Alpha Linux users is not as high as between post-i386 x86 
and original i386 Linux users at the time of the drop.

> >  And I think it would be good if we kept the port, just as we keep other 
> > ports of historical significance only, for educational reasons if nothing 
> > else, such as to let people understand based on an actual example, once 
> > mainstream, the implications of weakly ordered memory systems.
> 
> I don't know of any remaining issues with the newer Alpha systems that do
> support single-byte and double-byte load and store instructions, and so
> I am not aware of any reason for dropping Linux-kernel support for them.

 Well, the lack of developers to maintain the port would be the reason I 
refer to.  If you let developers drop by preventing them from using their 
hardware to work on the port, then eventually we'll have none.

 Anyway it seems like an issue to be sorted in the compiler, transparently 
to RCU, so it shouldn't be a reason to drop support for non-BWX Alpha CPUs 
anymore.  See my reply to Linus in this thread.

 Thank you for your input, always appreciated.

  Maciej

