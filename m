Return-Path: <linux-kernel+bounces-241741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C58A927EFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 00:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C6A1F23C69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 22:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DB7143875;
	Thu,  4 Jul 2024 22:21:45 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C632F10A35;
	Thu,  4 Jul 2024 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720131705; cv=none; b=Uk4ykhqk4BsQVYp8TxmGleeY9OTJaxHptkswqPpbyFMZmbOIUtgXzba4nqtnp2h9mo1Ycw45Ol7FaRJ+UyB911zk4IwiePjdbQi77vP/ih7dNNy870Rh5IqNZnoPbco7Tm/+5vpBOLlnve0XpN6+/QqFPwf4pfiUBtIlNXuMj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720131705; c=relaxed/simple;
	bh=NUvB76FimaA4vS3wr2eb3wGd7ZMDFrkYDBldO3x8vGQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ErgYgwi0s9nL3FpYLgLxv/ugGx52E/UK33LppVmo23ibpOjebFmFJ+G4Ls+EcthPQWNKn5llh0E9I1WgqTvjqpjoNIVb+VoNQh5kVijrA16Wny0XbrQAC/gotUffAo6ky8UkCwdl/J3GdWlNrslPn7MUilI9LLf6hoBbBttExnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3BE8892009C; Fri,  5 Jul 2024 00:21:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2EFCC92009B;
	Thu,  4 Jul 2024 23:21:34 +0100 (BST)
Date: Thu, 4 Jul 2024 23:21:34 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
    Michael Cree <mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
In-Reply-To: <CAHk-=wgncrjmWSETfPt+j6DY-MLH0=Lrd8kJHR6Tz1iJ6i39VA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2407040044180.38148@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <4bb50dc0-244a-4781-85ad-9ebc5e59c99a@app.fastmail.com> <CAHk-=wimJ2hQhKSq7+4O1EHtkg7eFBwY+fygxD+6sjWqgyDMTQ@mail.gmail.com> <alpine.DEB.2.21.2406302009480.43454@angie.orcam.me.uk>
 <CAHk-=wihNu+_bGwD8F107ds7Lv1Z6ODTwvYYvXeW3im1=4R65w@mail.gmail.com> <alpine.DEB.2.21.2407020219040.38148@angie.orcam.me.uk> <CAHk-=wgncrjmWSETfPt+j6DY-MLH0=Lrd8kJHR6Tz1iJ6i39VA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Jul 2024, Linus Torvalds wrote:

> >  Precisely my point!  We got so used to think in multiples of 8 bits that
> > other approaches seem ridiculous.
> 
> But Maciej - alpha *was* designed for bytes. It wasn't a Cray 1. It
> wasn't a PDP-10. It was designed by the time people knew that bytes
> were the dominant thing, and that bytes were important and the main
> use case.
> 
> But it was designed BADLY. The architecture sucked.

 OK, perhaps it was those people who decided to make it that way that 
lived in a parallel universe.

> Give it up. If alpha had been designed in the 60s or 70s when the
> whole issue of bytes were was debatable, it would have been
> incredible.
> 
> But no. It was designed for byte accesses, and it FAILED AT THEM.

 I guess they decided that trading byte and word accesses for simpler bus 
logic that does not have all the bits required to issue an RMW operation 
to recalculate the ECC syndrome on such accesses was a good deal, and I 
guess they did not realise data race implications or thought they could be 
sorted in a reasonable way.  The avoidance of RMWs is explicitly mentioned 
in the preface to the Alpha ARM.

 And I guess you are aware that getting an asynchronous multi-bit ECC 
error interrupt for a partial write the origin of which has long gone and 
all you have is the physical address is also a horror to handle.

 Bad choice I guess anyway.  Too many guesses I guess too.

  Maciej

