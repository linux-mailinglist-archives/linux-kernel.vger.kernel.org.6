Return-Path: <linux-kernel+bounces-524724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5387A3E654
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A7D3BF6C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F6264603;
	Thu, 20 Feb 2025 21:06:00 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FF1EDA1C;
	Thu, 20 Feb 2025 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085559; cv=none; b=netj5JoiknB+9fhYydbElaHYrpfyN3ah7+55cV37i89o6yJxfHeww0Zq8QPTulLlHnW6tXQzjVkcSfuoiXyn5R92ISRXwmS3GOAhR6ejbyLfzm0eP4bOg2iZBLVIvCHKG0SjKC0wCj4SsrG+geT6dypS+gktz31z6G0il/y3Nis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085559; c=relaxed/simple;
	bh=Z21VTHiZkTGyepyjiVPQ4h2mNI2Vsj2dBuWL5nHRIp4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d0kmZYJ9MBTl9cGqtTA7Cil+qIy7cble0MnmQmfSbhXzs4eTMZXakcw/4iHVihoeEW/CeKDtb/r8vK73IFnJj7Ez9BJt8d58M6PFt1jqGBz5y8buTuovcFWeHau1S/86nbgWAcESS6PY6JtuzYNDLOE51sL1dxVZnE2qvVRL7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A62F392009C; Thu, 20 Feb 2025 22:05:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9FF6E92009B;
	Thu, 20 Feb 2025 21:05:54 +0000 (GMT)
Date: Thu, 20 Feb 2025 21:05:54 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Richard Henderson <richard.henderson@linaro.org>
cc: Ivan Kokshaysky <ink@unseen.parts>, Matt Turner <mattst88@gmail.com>, 
    Arnd Bergmann <arnd@arndb.de>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data
 consistency
In-Reply-To: <45155869-1490-49ab-8df1-7ad13f79c09a@linaro.org>
Message-ID: <alpine.DEB.2.21.2502202009470.65342@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk> <45155869-1490-49ab-8df1-7ad13f79c09a@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 20 Feb 2025, Richard Henderson wrote:

> > Complementing compiler support for the `-msafe-bwa' and `-msafe-partial'
> > code generation options slated to land in GCC 15,
> 
> Pointer?  I can't find it on the gcc-patches list.

 Here: 
<https://inbox.sourceware.org/gcc-patches/alpine.DEB.2.21.2501050246590.49841@angie.orcam.me.uk/>
and hopefully in your inbox/archive somewhere as well.

> > 7. At this point both whole data quantities have been written, ensuring
> >     that no third-party intervening write has changed them at the point
> >     of the write from the values held at previous LDx_L.  Therefore 1 is
> >     returned in the intended register as the result of the trapping STx_C
> >     instruction.
> 
> I think general-purpose non-atomic emulation of STx_C is a really bad idea.
> 
> Without looking at your gcc patches, I can guess what you're after: you've
> generated a ll/sc sequence for (aligned) short, and want to emulate if it
> happens to be unaligned.

 It's a corner case, yes, when the compiler was told the access would be 
aligned, but it turns out not.  It's where you cast a (char *) pointer to 
(short *) that wasn't suitably aligned for such a cast and dereference it 
(and the quadword case is similarly for the ends of misaligned inline 
`memcpy'/`memset').

 Only two cases (plus a bug in GM2 frontend) hitting this throughout the 
GCC testsuite show the rarity of this case.

> Crucially, when emulating non-aligned, you should not strive to make it
> atomic.  No other architecture promises atomic non-aligned stores, so why
> should you do that here?

 This code doesn't strive to be atomic, but to preserve data *outside* the 
quantity accessed from being clobbered, and for this purpose an atomic 
sequence is both inevitable and sufficient, for both partial quantities 
around the unaligned quantity written.  The trapping code does not expect 
atomicity for the unaligned quantity itself -- it is handled in pieces 
just as say with MIPS SWL/SWR masked store instruction pairs -- and this 
code, effectively an Alpha/Linux psABI extension, does not guarantee it 
either.

> I suggest some sort of magic code sequence,
> 
> 	bic	addr_in, 6, addr_al
> loop:
> 	ldq_l	t0, 0(addr_al)
> 	magic-nop done - loop
> 	inswl	data, addr_in, t1
> 	mskwl	t0, addr_in, t0
> 	bis	t0, t1, t0
> 	stq_c	t0, 0(addr_al)
> 	beq	t0, loop
> done:
> 
> With the trap, match the magic-nop, pick out the input registers from the
> following inswl, perform the two (atomic!) byte stores to accomplish the
> emulation, adjust the pc forward to the done label.

 It seems to make no sense to me to penalise all user code for the corner 
case mentioned above while still having the emulation in the kernel, given 
that 99.999...% of accesses will have been correctly aligned by GCC.  And 
it gets even more complex when you have an awkward number of bytes to 
mask, such as 3, 5, 6, 7, which will happen for example if inline `memcpy' 
is expanded by GCC for a quadword-aligned block of 31-bytes, in which case 
other instructions will be used for masking/insertion for the trailing 7 
bytes, and the block turns out misaligned at run time.

 I'm inconvinced, it seems a lot of hassle for little gain to me.

  Maciej

