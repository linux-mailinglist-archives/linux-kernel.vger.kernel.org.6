Return-Path: <linux-kernel+bounces-199054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1A8D8152
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86F22832D7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD1D84A49;
	Mon,  3 Jun 2024 11:33:31 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BDD288DF;
	Mon,  3 Jun 2024 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414410; cv=none; b=EdWhytaZAY2fXZsd4wU40EvGjuP/X6Uwjf/NsMsdzdY9gmKuz5/SV/7c0uyuD3JE9PvB1ZYQl6+MSZxgXwjU1sb+iran+ED2qkxwCCbgNZOXfQmhhrcP/du7DHFrV0KxElAmajUgDAclpQJ0VOuBPT30k9DtW8Rv18yHR38EThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414410; c=relaxed/simple;
	bh=mcb1k5EXFcI1/eY8+Oa4jSG6lo0jp4sHE+okiXL//FA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BhEOI3jPdRYv8MQ5O7Orwv7agxl3LZ0BAxMYBKmtzdmUjeB34jDpf/u3tc+XrDKouiZIOxMDGaIF0AKIU50qnttu8N63XbCT/mtfZZI47ykMpnpHByzHVrIWJj91g29PL8H6oFotEJdr7wM32XZhylTSSEP2JBVHopsjs7E3DzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 954AF92009C; Mon,  3 Jun 2024 13:33:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8676C92009B;
	Mon,  3 Jun 2024 12:33:26 +0100 (BST)
Date: Mon, 3 Jun 2024 12:33:26 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@arndb.de>
cc: "Paul E. McKenney" <paulmck@kernel.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Marc Zyngier <maz@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>, 
    Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
In-Reply-To: <4bb50dc0-244a-4781-85ad-9ebc5e59c99a@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2406031209560.9248@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <4bb50dc0-244a-4781-85ad-9ebc5e59c99a@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 May 2024, Arnd Bergmann wrote:

> I then tried changing the underlying variables to 32-bit ones
> to see how many changes are needed, but I gave up after around
> 150 of them, as I was only scratching the surface. To do this
> right, you'd need to go through each one of them and come up
> with a solution that is the best trade-off in terms of memory
> usage and performance for that one. There are of course
> others that should be using WRITE_ONCE() and are missing
> this, so the list is not complete either. See below for
> the ones I could find quickly.

 Thank you for your attempt, and I agree this is excessive and beyond what 
we can reasonably handle.

> >  FWIW even if it was only me I think that depriving the already thin Alpha 
> > port developer base of any quantity of the remaining manpower, by dropping 
> > support for a subset of the hardware available, and then a subset that is 
> > not just as exotic as the original i386 became to the x86 platform at the 
> > time support for it was dropped, is only going to lead to further demise 
> > and eventual drop of the entire port.
> 
> I know you like you museum pieces to be older than everyone
> else's, and I'm sorry that my patch series is causing you
> problems, but I don't think the more general criticism is
> valid here. My hope was mainly to help our with both keeping
> Alpha viable for a few more years while also allowing Paul
> to continue with his RCU changes.

 Appreciated and thank you for your appreciation as well.

> As far as I can tell, nobody else is actually using EV4
> machines or has been for years now, but the presence of that
> code did affect both the performance and correctness of the
> kernel code for all EV56+ users since distros have no way
> of picking the ISA level on alpha for a generic kernel.

 Well, at least John Paul Adrian complained as well, and who knows who 
else is there downstream.  I'd expect most people (i.e. all except for 
core Linux developers) not to track upstream development in a continuous 
manner.

> The strongest argument I see for assuming non-BWX alphas
> are long dead is that gcc-4.4 added support for C11 style
> _Atomic variables for alpha, but got the stores wrong
> without anyone ever noticing the problem. Even one makes
> the argument that normal byte stores and volatiles ones
> should not need atomic ll/st sequenes, the atomics
> clearly do. Building BWX-enabled kernels and userland
> completely avoids this problem, which make debugging
> easier for the remaining users when stuff breaks.

 This only shows the lack of proper verification here rather than just 
use.  I'm not even sure if the nature of this problem is going to make it 
trigger in GCC regression testing.  Which BTW I have wired my EV45 system 
for in my lab last year and which would be going by now if not for issues 
with support network automation equipment (FAOD, state of the art and 
supported by the manufacturer).  We shall see once I'm done.

 As John Paul Adrian has pointed out the removal was expedited with no 
attempt made to find a proper solution that would not affect other users.  
As you can see it took me one e-mail exchange with Linus to understand 
what the underlying issue has been and then just a little bit of thinking, 
maybe half an hour, likely even less, to identify a feasible solution.

 Yes, I could have come up with it maybe a month ago if I wasn't so much 
behind on mailing list traffic.  But it's not my day job and since we had 
this issue for years now, it wasn't something that had to be handled as a 
matter of urgency.  We all are people and have our limitations.  We could 
have waited with the RFC out for another development cycle.  This has been 
the point of my complaint.

  Maciej

