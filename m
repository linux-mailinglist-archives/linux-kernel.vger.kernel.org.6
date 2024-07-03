Return-Path: <linux-kernel+bounces-238599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAF924CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1AA1C21E7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503EE635;
	Wed,  3 Jul 2024 00:13:04 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A9110E3;
	Wed,  3 Jul 2024 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965583; cv=none; b=XWvJGsIBfeoaEWHD8PomMbk2gkcZ5UJq6tLHXtfhJ1Rb4mlk31Fctv9nlogp3SYrUYOWW6h0CFDdfO17hZJY8sBU25YlCmahY06iSagAwtmW0CBj5Bin6nkhfGUeEtgCnloDD9djyDd7MaA6wL3Qjafyqo5bVtYpIuXNJcFiFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965583; c=relaxed/simple;
	bh=XTzWuLlWI1vnmXFpCrALo1hSI5hOjBF96hPZLbjaPrk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cq44SGXcQKZswmuaOdpa9P/xogc2Kk+oP+vpfQUIMbW098JTBceZD7lLbAUJfHlkLzkr2wpf6eigsSGM9aUVeOMB8FonFsqiyNhN+B1xrIDELu4JtMUQ32X8Ypdr3f/muXLRJPNVK/HUPXPGKT/bqiembXDqF8Qtxne16SPuPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id CA9B392009D; Wed,  3 Jul 2024 02:12:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C5D4A92009B;
	Wed,  3 Jul 2024 01:12:52 +0100 (BST)
Date: Wed, 3 Jul 2024 01:12:52 +0100 (BST)
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
In-Reply-To: <CAHk-=wihNu+_bGwD8F107ds7Lv1Z6ODTwvYYvXeW3im1=4R65w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2407020219040.38148@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <4bb50dc0-244a-4781-85ad-9ebc5e59c99a@app.fastmail.com> <CAHk-=wimJ2hQhKSq7+4O1EHtkg7eFBwY+fygxD+6sjWqgyDMTQ@mail.gmail.com> <alpine.DEB.2.21.2406302009480.43454@angie.orcam.me.uk>
 <CAHk-=wihNu+_bGwD8F107ds7Lv1Z6ODTwvYYvXeW3im1=4R65w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Jul 2024, Linus Torvalds wrote:

> The architecture was wrong 30 years ago. It's not that it "became"
> wrong in hindsight. It was wrong originally, and it's just that people
> hadn't thought things through enough to realize how wrong it was.
> 
> The only way it's not wrong is if you say "byte accesses do not
> matter". That's a very Cray way of looking at things - Cray 1 had a
> 64-bit "char" in C, because there were no byte accesses.
> 
> That's fine if your only goal in life is to do HPC.
> 
> So if you simply don't care about bytes, and you *only* work with
> words and quad-words, then alpha looks ok.
> 
> But honestly, that's basically saying "in a different universe, alpha
> is not a mis-design".

 Precisely my point!  We got so used to think in multiples of 8 bits that 
other approaches seem ridiculous.

 The PDP-10 operated on 36-bit quantities and strings were essentially 
clusters of 6-bit characters packed into 6-packs (which is also allegedly 
where the C language's original limitation of using at most six characters 
for identifiers came from -- so that the PDP-10 could compare a pair with 
a single machine instruction).

 So there was already legacy of doing things this way at DEC back in ~1990 
and I can envisage engineers there actually thought that to have a machine 
that in C terms has 32-bit shorts and ints, 64-bit longs and pointers, and 
strings as clusters of 8-bit characters packed into 4-packs or 8-packs was 
not at all unreasonable.  Or maybe just plain 32-bit characters.  After 
all you don't absolutely *have* to use data types of 8 or 16 bits exactly 
in width for anything, do you?  NB for strings nowadays we have Unicode 
and we could just use UTF-32 if not to waste memory.

 And even now ISO C is very flexible on data type widths and only requires 
the character data type to be at least 8 bits wide, and 16-bit and 24-bit 
examples are actually given in the standard itself.  Yes, POSIX requires 
the character data type to be 8 bits wide exactly now, but POSIX.1-1988 
deferred to ANSI C AFAICT.

  Maciej

