Return-Path: <linux-kernel+bounces-237113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9566591EB93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 01:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA9A1F2292E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB417332B;
	Mon,  1 Jul 2024 23:50:45 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053D502A9;
	Mon,  1 Jul 2024 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877845; cv=none; b=U/AcEPUUmUwrCoKc9ENcxhAT9vAjqrJmfRRveDQJglYmfIw6/yOtP48j0jVbbsTsdaeLpe6ojWYpEXdVltBqzDIjbFdN8rUtGTlmEUYaNif95u+5C8SkDynCMWYIQQ/s6+Oz7FV7RnkRxNwJwXT3UK0adCfwatI3pgrrJycnRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877845; c=relaxed/simple;
	bh=zBYdg3DzMhAy1TouLoxSC8I7NMnNOm/KTd6s9dqQi+4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t1jMwHkzuTO+CVnB3XQAdmqHcQjHCLeJNCtG/51XsaDSEtQrpOatONAwp7DEBg8f+3d9QyC0wKQMuFL7BzX4XjhBG/Id5QfR/L/da+Pxrjuzx3HZsa2+77Bgei5kZviDCIeVU6kLz7O3h/upulabpoL9OOLd1K1B+A4zYvfkJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id BB91F92009C; Tue,  2 Jul 2024 01:50:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B474D92009B;
	Tue,  2 Jul 2024 00:50:42 +0100 (BST)
Date: Tue, 2 Jul 2024 00:50:42 +0100 (BST)
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
In-Reply-To: <12a3f8ac-c542-4065-a464-fc246e355d1d@paulmck-laptop>
Message-ID: <alpine.DEB.2.21.2406031953550.9248@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <5567ab2e-80af-4c5f-bebb-d979e8a34f49@paulmck-laptop> <alpine.DEB.2.21.2405310432190.23854@angie.orcam.me.uk> <7b0a434c-2165-45a0-8507-e7f992094705@paulmck-laptop> <alpine.DEB.2.21.2406031716490.9248@angie.orcam.me.uk>
 <12a3f8ac-c542-4065-a464-fc246e355d1d@paulmck-laptop>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Jun 2024, Paul E. McKenney wrote:

> >  This is a fairly recent addition, thank you for putting it all together.  
> > I used to rely solely on Documentation/memory-barriers.txt.  Thanks for 
> > the reference.
> 
> It has been in the kernel since April 2018, but OK.  And a big "thank you"

 When you've been around for 25+ years, 5 years back seems like yesterday.

> to all the people who made this possible and who continue contributing
> to it.  And Documentation/memory-barriers.txt still matters, though the
> long-term goal is for it to be subsumed into tools/memory-model.  Things
> like compiler optimizations make this difficult, but not impossible.

 I realise these are tough matters and I second your gratitude.

> Another precaution is to ensure that any contraints of a non-common-case
> architecture be tested for.  For example, if I add a 64-bit divide, I
> get yelled at promptly.  In contrast, that long list of byte accesses
> that Arnd posted were suffered in silence.  So they accumulated well
> past the point where they can reasonably be backed out.

 Well, it's easy to notice and yell when you get an unresolved link-time 
reference to __divdi3 or suchlike.  While such heisenbugs as those caused 
by the race condition from concurrent unprotected rmw accesses may all be 
too easily blamed on cosmic rays or any other random instability.

 Take for example the GCC bug I mentioned in my reply to Linus in this 
thread, GCC PR rtl-optimization/115565.  It took 20 years to spot, even 
though it's in heavily used code and it does not depend on timing: with 
the right conditions it will trigger every time.

 If I were aware of these issues, I would definitely have got at them 
sooner.  Anyway, as mentioned in the other reply, I've overcome system 
setup issues now and will be working on the problem discussed here.

  Maciej

